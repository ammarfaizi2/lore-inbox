Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWFARIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWFARIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWFARIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:08:42 -0400
Received: from es335.com ([67.65.19.105]:26463 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S965008AbWFARIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:08:40 -0400
Subject: Re: [openib-general] Re: [PATCH 1/2] iWARP Connection Manager.
From: Tom Tucker <tom@opengridcomputing.com>
To: Sean Hefty <mshefty@ichips.intel.com>
Cc: Steve Wise <swise@opengridcomputing.com>, netdev@vger.kernel.org,
       rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <447E1720.7000307@ichips.intel.com>
References: <20060531182650.3308.81538.stgit@stevo-desktop>
	 <20060531182652.3308.1244.stgit@stevo-desktop>
	 <447E1720.7000307@ichips.intel.com>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 12:11:58 -0500
Message-Id: <1149181918.18855.23.camel@trinity.ogc.int>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 15:22 -0700, Sean Hefty wrote:
> Steve Wise wrote:
> > +/* 
> > + * Release a reference on cm_id. If the last reference is being removed
> > + * and iw_destroy_cm_id is waiting, wake up the waiting thread.
> > + */
> > +static int iwcm_deref_id(struct iwcm_id_private *cm_id_priv)
> > +{
> > +	int ret = 0;
> > +
> > +	BUG_ON(atomic_read(&cm_id_priv->refcount)==0);
> > +	if (atomic_dec_and_test(&cm_id_priv->refcount)) {
> > +		BUG_ON(!list_empty(&cm_id_priv->work_list));
> > +		if (waitqueue_active(&cm_id_priv->destroy_wait)) {
> > +			BUG_ON(cm_id_priv->state != IW_CM_STATE_DESTROYING);
> > +			BUG_ON(test_bit(IWCM_F_CALLBACK_DESTROY,
> > +					&cm_id_priv->flags));
> > +			ret = 1;
> > +			wake_up(&cm_id_priv->destroy_wait);
> 
> We recently changed the RDMA CM, IB CM, and a couple of other modules from using 
> wait objects to completions.   This avoids a race condition between decrementing 
> the reference count, which allows destruction to proceed, and calling wake_up on 
> a freed cm_id.  My guess is that you may need to do the same.
> 
> Can you also explain the use of the return value here?  It's ignored below in 
> rem_ref() and destroy_cm_id().
> 
> > +static void add_ref(struct iw_cm_id *cm_id)
> > +{
> > +	struct iwcm_id_private *cm_id_priv;
> > +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> > +	atomic_inc(&cm_id_priv->refcount);
> > +}
> > +
> > +static void rem_ref(struct iw_cm_id *cm_id)
> > +{
> > +	struct iwcm_id_private *cm_id_priv;
> > +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> > +	iwcm_deref_id(cm_id_priv);
> > +}
> > +
> 
> > +/* 
> > + * CM_ID <-- CLOSING
> > + *
> > + * Block if a passive or active connection is currenlty being processed. Then
> > + * process the event as follows:
> > + * - If we are ESTABLISHED, move to CLOSING and modify the QP state
> > + *   based on the abrupt flag 
> > + * - If the connection is already in the CLOSING or IDLE state, the peer is
> > + *   disconnecting concurrently with us and we've already seen the 
> > + *   DISCONNECT event -- ignore the request and return 0
> > + * - Disconnect on a listening endpoint returns -EINVAL
> > + */
> > +int iw_cm_disconnect(struct iw_cm_id *cm_id, int abrupt)
> > +{
> > +	struct iwcm_id_private *cm_id_priv;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> > +	/* Wait if we're currently in a connect or accept downcall */
> > +	wait_event(cm_id_priv->connect_wait, 
> > +		   !test_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags));
> 
> Am I understanding this check correctly?  You're checking to see if the user has 
> called iw_cm_disconnect() at the same time that they called iw_cm_connect() or 
> iw_cm_accept().  Are connect / accept blocking, or are you just waiting for an 
> event?

Yes. The application (or the case I saw was user-mode exit logic after
ctrl-C) cleaning up at random times relative to connection
establishment. 

> 
> > +
> > +	spin_lock_irqsave(&cm_id_priv->lock, flags);
> > +	switch (cm_id_priv->state) {
> > +	case IW_CM_STATE_ESTABLISHED:
> > +		cm_id_priv->state = IW_CM_STATE_CLOSING;
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		if (cm_id_priv->qp)	{ /* QP could be <nul> for user-mode client */
> > +			if (abrupt)
> > +				ret = iwcm_modify_qp_err(cm_id_priv->qp);
> > +			else
> > +				ret = iwcm_modify_qp_sqd(cm_id_priv->qp);
> > +			/* 
> > +			 * If both sides are disconnecting the QP could
> > +			 * already be in ERR or SQD states
> > +			 */
> > +			ret = 0;
> > +		}
> > +		else
> > +			ret = -EINVAL;
> > +		break;
> > +	case IW_CM_STATE_LISTEN:
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		ret = -EINVAL;
> > +		break;
> > +	case IW_CM_STATE_CLOSING:
> > +		/* remote peer closed first */
> > +	case IW_CM_STATE_IDLE:	
> > +		/* accept or connect returned !0 */
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		break;
> > +	case IW_CM_STATE_CONN_RECV:
> > +		/* 
> > +		 * App called disconnect before/without calling accept after
> > +		 * connect_request event delivered.
> > +		 */
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		break;
> > +	case IW_CM_STATE_CONN_SENT:
> > +		/* Can only get here if wait above fails */
> > +	default:		
> > +		BUG_ON(1);
> > +	}
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(iw_cm_disconnect);
> > +static void destroy_cm_id(struct iw_cm_id *cm_id)
> > +{
> > +	struct iwcm_id_private *cm_id_priv;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> > +	/* Wait if we're currently in a connect or accept downcall. A
> > +	 * listening endpoint should never block here. */
> > +	wait_event(cm_id_priv->connect_wait, 
> > +		   !test_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags));
> 
> Same question/comment as above.
> 
> > +
> > +	spin_lock_irqsave(&cm_id_priv->lock, flags);
> > +	switch (cm_id_priv->state) {
> > +	case IW_CM_STATE_LISTEN:
> > +		cm_id_priv->state = IW_CM_STATE_DESTROYING;
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		/* destroy the listening endpoint */
> > +		ret = cm_id->device->iwcm->destroy_listen(cm_id);
> > +		break;
> > +	case IW_CM_STATE_ESTABLISHED:
> > +		cm_id_priv->state = IW_CM_STATE_DESTROYING;
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		/* Abrupt close of the connection */
> > +		(void)iwcm_modify_qp_err(cm_id_priv->qp);
> > +		break;
> > +	case IW_CM_STATE_IDLE:
> > +	case IW_CM_STATE_CLOSING:
> > +		cm_id_priv->state = IW_CM_STATE_DESTROYING;
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		break;
> > +	case IW_CM_STATE_CONN_RECV:
> > +		/* 
> > +		 * App called destroy before/without calling accept after
> > +		 * receiving connection request event notification.
> > +		 */ 
> > +		cm_id_priv->state = IW_CM_STATE_DESTROYING;
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		break;
> > +	case IW_CM_STATE_CONN_SENT:
> > +	case IW_CM_STATE_DESTROYING:
> > +	default:
> > +		BUG_ON(1);
> > +		break;
> > +	}
> > +
> > +	spin_lock_irqsave(&cm_id_priv->lock, flags);
> 
> As an alternative, you could hold the lock from above, an let the LISTEN / 
> ESTABLISHED state checks release and reacquire.
> 
> > +	if (cm_id_priv->qp) {
> > +		cm_id_priv->id.device->iwcm->rem_ref(cm_id_priv->qp);
> > +		cm_id_priv->qp = NULL;
> > +	}
> > +	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +
> > +	(void)iwcm_deref_id(cm_id_priv);
> > +}
> > +
> > +/* 
> > + * This function is only called by the application thread and cannot
> > + * be called by the event thread. The function will wait for all
> > + * references to be released on the cm_id and then kfree the cm_id
> > + * object. 
> > + */
> > +void iw_destroy_cm_id(struct iw_cm_id *cm_id)
> > +{
> > +	struct iwcm_id_private *cm_id_priv;
> > +
> > +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> > +        BUG_ON(test_bit(IWCM_F_CALLBACK_DESTROY, &cm_id_priv->flags));
> > +
> > +	destroy_cm_id(cm_id);
> > +
> > +	wait_event(cm_id_priv->destroy_wait, 
> > +		   !atomic_read(&cm_id_priv->refcount));
> > +
> > +	kfree(cm_id_priv);
> > +}
> > +EXPORT_SYMBOL(iw_destroy_cm_id);
> > +
> > +/* 
> > + * CM_ID <-- LISTEN
> > + *
> > + * Start listening for connect requests. Generates one CONNECT_REQUEST
> > + * event for each inbound connect request. 
> > + */
> > +int iw_cm_listen(struct iw_cm_id *cm_id, int backlog)
> > +{
> > +	struct iwcm_id_private *cm_id_priv;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> > +	spin_lock_irqsave(&cm_id_priv->lock, flags);
> > +	switch (cm_id_priv->state) {
> > +	case IW_CM_STATE_IDLE:
> > +		cm_id_priv->state = IW_CM_STATE_LISTEN;
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		ret = cm_id->device->iwcm->create_listen(cm_id, backlog);
> > +		if (ret)
> > +			cm_id_priv->state = IW_CM_STATE_IDLE;
> > +		break;
> > +	default:
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(iw_cm_listen);
> > +
> > +/* 
> > + * CM_ID <-- IDLE
> > + *
> > + * Rejects an inbound connection request. No events are generated.
> > + */
> > +int iw_cm_reject(struct iw_cm_id *cm_id,
> > +		 const void *private_data,
> > +		 u8 private_data_len)
> > +{
> > +	struct iwcm_id_private *cm_id_priv;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> > +	set_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
> > +
> > +	spin_lock_irqsave(&cm_id_priv->lock, flags);
> > +	if (cm_id_priv->state != IW_CM_STATE_CONN_RECV) {
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
> > +		wake_up_all(&cm_id_priv->connect_wait);
> > +		return -EINVAL;
> > +	}
> > +	cm_id_priv->state = IW_CM_STATE_IDLE;
> > +	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +
> > +	ret = cm_id->device->iwcm->reject(cm_id, private_data, 
> > +					  private_data_len);
> > +
> > +	clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
> > +	wake_up_all(&cm_id_priv->connect_wait);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(iw_cm_reject);
> > +
> > +/* 
> > + * CM_ID <-- ESTABLISHED
> > + *
> > + * Accepts an inbound connection request and generates an ESTABLISHED
> > + * event. Callers of iw_cm_disconnect and iw_destroy_cm_id will block
> > + * until the ESTABLISHED event is received from the provider. 
> > + */
> 
> This makes it sound like we're just waiting for an event.
> 
> > +int iw_cm_accept(struct iw_cm_id *cm_id, 
> > +		 struct iw_cm_conn_param *iw_param)
> > +{
> > +	struct iwcm_id_private *cm_id_priv;
> > +	struct ib_qp *qp;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> > +	set_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
> > +
> > +	spin_lock_irqsave(&cm_id_priv->lock, flags);
> > +	if (cm_id_priv->state != IW_CM_STATE_CONN_RECV) {
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
> > +		wake_up_all(&cm_id_priv->connect_wait);
> > +		return -EINVAL;
> > +	}
> > +	/* Get the ib_qp given the QPN */
> > +	qp = cm_id->device->iwcm->get_qp(cm_id->device, iw_param->qpn);
> > +	if (!qp) {
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		return -EINVAL;
> > +	}
> > +	cm_id->device->iwcm->add_ref(qp);
> > +	cm_id_priv->qp = qp;
> > +	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +
> > +	ret = cm_id->device->iwcm->accept(cm_id, iw_param);
> > +	if (ret) {
> > +		/* An error on accept precludes provider events */
> > +		BUG_ON(cm_id_priv->state != IW_CM_STATE_CONN_RECV);
> > +		cm_id_priv->state = IW_CM_STATE_IDLE;
> > +		spin_lock_irqsave(&cm_id_priv->lock, flags);
> > +		if (cm_id_priv->qp) {
> > +			cm_id->device->iwcm->rem_ref(qp);
> > +			cm_id_priv->qp = NULL;
> > +		}
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		printk("Accept failed, ret=%d\n", ret);
> > +		clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
> > +		wake_up_all(&cm_id_priv->connect_wait);
> > +	}			
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(iw_cm_accept);
> > +
> > +/*
> > + * Active Side: CM_ID <-- CONN_SENT
> > + *
> > + * If successful, results in the generation of a CONNECT_REPLY
> > + * event. iw_cm_disconnect and iw_cm_destroy will block until the
> > + * CONNECT_REPLY event is received from the provider.
> > + */
> > +int iw_cm_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *iw_param)
> > +{
> > +	struct iwcm_id_private *cm_id_priv;
> > +	int ret = 0;
> > +	unsigned long flags;
> > +	struct ib_qp *qp;
> > +
> > +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> > +	set_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
> > +
> > +	spin_lock_irqsave(&cm_id_priv->lock, flags);
> > +	if (cm_id_priv->state != IW_CM_STATE_IDLE) {
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
> > +		wake_up_all(&cm_id_priv->connect_wait);
> > +		return -EINVAL;
> > +	}
> > +		
> > +	/* Get the ib_qp given the QPN */
> > +	qp = cm_id->device->iwcm->get_qp(cm_id->device, iw_param->qpn);
> > +	if (!qp) {
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		return -EINVAL;
> > +	}
> > +	cm_id->device->iwcm->add_ref(qp);
> > +	cm_id_priv->qp = qp;
> > +	cm_id_priv->state = IW_CM_STATE_CONN_SENT;
> > +	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +
> > +	ret = cm_id->device->iwcm->connect(cm_id, iw_param);
> > +	if (ret) {
> > +		spin_lock_irqsave(&cm_id_priv->lock, flags);
> > +		if (cm_id_priv->qp) {
> > +			cm_id->device->iwcm->rem_ref(qp);
> > +			cm_id_priv->qp = NULL;
> > +		}
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		BUG_ON(cm_id_priv->state != IW_CM_STATE_CONN_SENT);
> > +		cm_id_priv->state = IW_CM_STATE_IDLE;
> > +		printk("Connect failed, ret=%d\n", ret);
> > +		clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
> > +		wake_up_all(&cm_id_priv->connect_wait);
> > +	}
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(iw_cm_connect);
> > +
> > +/*
> > + * Passive Side: new CM_ID <-- CONN_RECV
> > + *
> > + * Handles an inbound connect request. The function creates a new
> > + * iw_cm_id to represent the new connection and inherits the client
> > + * callback function and other attributes from the listening parent. 
> > + * 
> > + * The work item contains a pointer to the listen_cm_id and the event. The
> > + * listen_cm_id contains the client cm_handler, context and
> > + * device. These are copied when the device is cloned. The event
> > + * contains the new four tuple.
> > + *
> > + * An error on the child should not affect the parent, so this
> > + * function does not return a value.
> > + */
> > +static void cm_conn_req_handler(struct iwcm_id_private *listen_id_priv, 
> > +				struct iw_cm_event *iw_event)
> > +{
> > +	unsigned long flags;
> > +	struct iw_cm_id *cm_id;
> > +	struct iwcm_id_private *cm_id_priv;
> > +	int ret;
> > +
> > +	/* The provider should never generate a connection request
> > +	 * event with a bad status. 
> > +	 */
> > +	BUG_ON(iw_event->status);
> > +
> > +	/* We could be destroying the listening id. If so, ignore this
> > +	 * upcall. */
> > +	spin_lock_irqsave(&listen_id_priv->lock, flags);
> > +	if (listen_id_priv->state != IW_CM_STATE_LISTEN) {
> > +		spin_unlock_irqrestore(&listen_id_priv->lock, flags);
> > +		return;
> > +	}
> > +	spin_unlock_irqrestore(&listen_id_priv->lock, flags);
> > +
> > +	cm_id = iw_create_cm_id(listen_id_priv->id.device,	
> > +				listen_id_priv->id.cm_handler, 
> > +				listen_id_priv->id.context);
> > +	/* If the cm_id could not be created, ignore the request */
> > +	if (IS_ERR(cm_id)) 
> > +		return;
> > +
> > +	cm_id->provider_data = iw_event->provider_data;
> > +	cm_id->local_addr = iw_event->local_addr;
> > +	cm_id->remote_addr = iw_event->remote_addr;
> > +
> > +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> > +	cm_id_priv->state = IW_CM_STATE_CONN_RECV;
> > +	
> > +	/* Call the client CM handler */
> > +	ret = cm_id->cm_handler(cm_id, iw_event);
> > +	if (ret) {
> > +		printk("destroying child id %p, ret=%d\n",
> > +		       cm_id, ret);
> 
> We probably don't always want to print a message here.
> 
> > +		set_bit(IWCM_F_CALLBACK_DESTROY, &cm_id_priv->flags);
> > +		destroy_cm_id(cm_id);
> > +		if (atomic_read(&cm_id_priv->refcount)==0)
> > +			kfree(cm_id);
> > +	}
> > +}
> > +
> > +/*
> > + * Passive Side: CM_ID <-- ESTABLISHED
> > + * 
> > + * The provider generated an ESTABLISHED event which means that 
> > + * the MPA negotion has completed successfully and we are now in MPA
> > + * FPDU mode. 
> > + *
> > + * This event can only be received in the CONN_RECV state. If the
> > + * remote peer closed, the ESTABLISHED event would be received followed
> > + * by the CLOSE event. If the app closes, it will block until we wake
> > + * it up after processing this event.
> > + */
> > +static int cm_conn_est_handler(struct iwcm_id_private *cm_id_priv, 
> > +			       struct iw_cm_event *iw_event)
> > +{
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	spin_lock_irqsave(&cm_id_priv->lock, flags);
> > +
> > +	/* We clear the CONNECT_WAIT bit here to allow the callback
> > +	 * function to call iw_cm_disconnect. Calling iw_destroy_cm_id
> > +	 * from a callback handler is not allowed */
> > +	clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
> > +	switch (cm_id_priv->state) {
> > +	case IW_CM_STATE_CONN_RECV:
> > +		cm_id_priv->state = IW_CM_STATE_ESTABLISHED;
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, iw_event);
> > +		break;
> > +	default:
> > +		BUG_ON(1);
> 
> Can just BUG_ON the state and avoid the switch.  Same comment applies below.
> 
> > +	}
> > +	wake_up_all(&cm_id_priv->connect_wait);
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Active Side: CM_ID <-- ESTABLISHED
> > + *
> > + * The app has called connect and is waiting for the established event to
> > + * post it's requests to the server. This event will wake up anyone
> > + * blocked in iw_cm_disconnect or iw_destroy_id.
> > + */
> > +static int cm_conn_rep_handler(struct iwcm_id_private *cm_id_priv, 
> > +			       struct iw_cm_event *iw_event)
> > +{
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	spin_lock_irqsave(&cm_id_priv->lock, flags);
> > +	/* Clear the connect wait bit so a callback function calling
> > +	 * iw_cm_disconnect will not wait and deadlock this thread */
> > +	clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
> > +	switch (cm_id_priv->state) {
> > +	case IW_CM_STATE_CONN_SENT:
> > +		if (iw_event->status == IW_CM_EVENT_STATUS_ACCEPTED) {
> > +			cm_id_priv->id.local_addr = iw_event->local_addr;
> > +			cm_id_priv->id.remote_addr = iw_event->remote_addr;
> > +			cm_id_priv->state = IW_CM_STATE_ESTABLISHED;
> > +		} else {
> > +			/* REJECTED or RESET */
> > +			cm_id_priv->id.device->iwcm->rem_ref(cm_id_priv->qp);
> > +			cm_id_priv->qp = NULL;
> > +			cm_id_priv->state = IW_CM_STATE_IDLE;
> > +		}
> > +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +		ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, iw_event);
> > +		break;
> > +	default:
> > +		BUG_ON(1);
> > +	}
> > +	/* Wake up waiters on connect complete */
> > +	wake_up_all(&cm_id_priv->connect_wait);
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * CM_ID <-- CLOSING 
> > + *
> > + * If in the ESTABLISHED state, move to CLOSING.
> > + */
> > +static void cm_disconnect_handler(struct iwcm_id_private *cm_id_priv, 
> > +				  struct iw_cm_event *iw_event)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&cm_id_priv->lock, flags);
> > +	if (cm_id_priv->state == IW_CM_STATE_ESTABLISHED)
> > +		cm_id_priv->state = IW_CM_STATE_CLOSING;
> > +	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> > +}
> > +
> > +/*
> > + * CM_ID <-- IDLE
> > + *
> > + * If in the ESTBLISHED or CLOSING states, the QP will have have been
> > + * moved by the provider to the ERR state. Disassociate the CM_ID from
> > + * the QP,  move to IDLE, and remove the 'connected' reference.
> > + * 
> > + * If in some other state, the cm_id was destroyed asynchronously.
> > + * This is the last reference that will result in waking up
> > + * the app thread blocked in iw_destroy_cm_id.
> > + */
> > +static int cm_close_handler(struct iwcm_id_private *cm_id_priv, 
> > +				  struct iw_cm_event *iw_event)
> > +{
> > +	unsigned long flags;
> > +	int ret = 0;
> > +	/* TT */printk("%s:%d cm_id_priv=%p, state=%d\n", 
> > +		       __FUNCTION__, __LINE__,
> > +		       cm_id_priv,cm_id_priv->state);
> 
> Will want to remove this.
> 
> - Sean
> _______________________________________________
> openib-general mailing list
> openib-general@openib.org
> http://openib.org/mailman/listinfo/openib-general
> 
> To unsubscribe, please visit http://openib.org/mailman/listinfo/openib-general

