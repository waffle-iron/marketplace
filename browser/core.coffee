#
# Marketplace browser's core module
#

class Core

  constructor: (@bridge) ->
    @resetPurchaseTxRequest()
    @resetMyInfoRequest()
    @resetAllPrivateTxsRequest()
    @resetAllPublicTxsRequest()


  resetPurchaseTxRequest: ->
    @bridge.tx = "{}"


  resetAllPrivateTxsRequest: ->
    @bridge.isAllPrivateTxsRequest = false


  resetAllPublicTxsRequest: ->
    @bridge.isAllPublicTxsRequest = false


  resetMyInfoRequest: ->
    @bridge.isMyInfoRequest = false


  setMyInfo: (data) ->
    console.log "setMyInfo (#{data})"
    @bridge.setMyInfo JSON.parse(data).user
    '{ "code": "0" }'


  setSellerInfo: (data) ->
    console.log "setSellerInfo (#{data})"
    r = JSON.parse(data)
    if r.stores? and r.stores.length > 0
      @bridge.setSellerInfo r
    '{ "code": "0" }'


  # it returns a purchase transaction once it was requested from the browser
  getPurchaseTxRequest: ->
    console.log 'new tx request here:', @bridge.tx  if @bridge.tx != "{}"
    @bridge.tx


  getTxStep1: (data) ->
    console.log "getTxStep1 (#{data})"
    @resetPurchaseTxRequest()
    @bridge.informPurchaseStatus "Purchase transaction is in progress..."
    '{ "code": "0" }'


  getTxStep6: (data) ->
    console.log "getTxStep6 (#{JSON.stringify data})"
    if data.code == "0"
      @bridge.informPurchaseStatus "Purchase transaction ##{data.id} has been successfully executed!", true
    else
      @bridge.informPurchaseStatus "Purchase transaction failed!"


  getMyInfoRequest: ->
    console.log 'my info request here'  if @bridge.isMyInfoRequest
    @bridge.isMyInfoRequest


  # it returns a request for getting all private ledger's executed transactions from the browser
  getAllPrivateTxsRequest: ->
    console.log 'all private txs request here'  if @bridge.isAllPrivateTxsRequest
    @bridge.isAllPrivateTxsRequest


  # it returns a request for getting all public blockchain's executed transactions from the browser
  getAllPublicTxsRequest: ->
    console.log 'all public txs request here'  if @bridge.isAllPublicTxsRequest
    @bridge.isAllPublicTxsRequest


  setAllPrivateTxs: (txs) ->
    @bridge.setAllPrivateTxs txs


  setAllPublicTxs: (txs) ->
    @bridge.setAllPublicTxs txs


module.exports = Core
