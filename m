Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWFGUGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWFGUGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 16:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWFGUGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 16:06:13 -0400
Received: from rrcs-24-227-247-179.sw.biz.rr.com ([24.227.247.179]:19883 "EHLO
	linux.local") by vger.kernel.org with ESMTP id S1751219AbWFGUGG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 16:06:06 -0400
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH v2 1/2] iWARP Connection Manager.
Date: Wed, 07 Jun 2006 15:06:05 -0500
To: rdreier@cisco.com, mshefty@ichips.intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org
Message-Id: <20060607200605.9003.25830.stgit@stevo-desktop>
In-Reply-To: <20060607200600.9003.56328.stgit@stevo-desktop>
References: <20060607200600.9003.56328.stgit@stevo-desktop>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch provides the new files implementing the iWARP Connection
Manager.

Review Changes:

- sizeof -> sizeof()

- removed printks

- removed TT debug code

- cleaned up lock/unlock around switch statements.

- waitqueue -> completion for destroy path.
---

 drivers/infiniband/core/iwcm.c |  877 ++++++++++++++++++++++++++++++++++++++++
 include/rdma/iw_cm.h           |  254 ++++++++++++
 include/rdma/iw_cm_private.h   |   62 +++
 3 files changed, 1193 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
new file mode 100644
index 0000000..994bc79
--- /dev/null
+++ b/drivers/infiniband/core/iwcm.c
@@ -0,0 +1,877 @@
+/*
+ * Copyright (c) 2004, 2005 Intel Corporation.  All rights reserved.
+ * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
+ * Copyright (c) 2004, 2005 Voltaire Corporation.  All rights reserved.
+ * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
+ * Copyright (c) 2005 Open Grid Computing, Inc. All rights reserved.
+ * Copyright (c) 2005 Network Appliance, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ */
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/rbtree.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/completion.h>
+#include <rdma/iw_cm.h>
+#include <rdma/iw_cm_private.h>
+#include <rdma/ib_addr.h>
+
+MODULE_AUTHOR("Tom Tucker");
+MODULE_DESCRIPTION("iWARP CM");
+MODULE_LICENSE("Dual BSD/GPL");
+
+static struct workqueue_struct *iwcm_wq;
+struct iwcm_work {
+	struct work_struct work;
+	struct iwcm_id_private *cm_id;
+	struct list_head list;
+	struct iw_cm_event event;
+};
+
+/* 
+ * Release a reference on cm_id. If the last reference is being removed
+ * and iw_destroy_cm_id is waiting, wake up the waiting thread.
+ */
+static int iwcm_deref_id(struct iwcm_id_private *cm_id_priv)
+{
+	int ret = 0;
+
+	BUG_ON(atomic_read(&cm_id_priv->refcount)==0);
+	if (atomic_dec_and_test(&cm_id_priv->refcount)) {
+		BUG_ON(!list_empty(&cm_id_priv->work_list));
+		if (waitqueue_active(&cm_id_priv->destroy_comp.wait)) {
+			BUG_ON(cm_id_priv->state != IW_CM_STATE_DESTROYING);
+			BUG_ON(test_bit(IWCM_F_CALLBACK_DESTROY,
+					&cm_id_priv->flags));
+			ret = 1;
+		}
+		complete(&cm_id_priv->destroy_comp);
+	}
+
+	return ret;
+}
+
+static void add_ref(struct iw_cm_id *cm_id)
+{
+	struct iwcm_id_private *cm_id_priv;
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	atomic_inc(&cm_id_priv->refcount);
+}
+
+static void rem_ref(struct iw_cm_id *cm_id)
+{
+	struct iwcm_id_private *cm_id_priv;
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	iwcm_deref_id(cm_id_priv);
+}
+
+static void cm_event_handler(struct iw_cm_id *cm_id, struct iw_cm_event *event);
+
+struct iw_cm_id *iw_create_cm_id(struct ib_device *device,
+				 iw_cm_handler cm_handler,
+				 void *context)
+{
+	struct iwcm_id_private *cm_id_priv;
+
+	cm_id_priv = kzalloc(sizeof(*cm_id_priv), GFP_KERNEL);
+	if (!cm_id_priv)
+		return ERR_PTR(-ENOMEM);
+
+	cm_id_priv->state = IW_CM_STATE_IDLE;
+	cm_id_priv->id.device = device;
+	cm_id_priv->id.cm_handler = cm_handler;
+	cm_id_priv->id.context = context;
+	cm_id_priv->id.event_handler = cm_event_handler;
+	cm_id_priv->id.add_ref = add_ref;
+	cm_id_priv->id.rem_ref = rem_ref;
+	spin_lock_init(&cm_id_priv->lock);
+	atomic_set(&cm_id_priv->refcount, 1);
+	init_waitqueue_head(&cm_id_priv->connect_wait);
+	init_completion(&cm_id_priv->destroy_comp);
+	INIT_LIST_HEAD(&cm_id_priv->work_list);
+
+	return &cm_id_priv->id;
+}
+EXPORT_SYMBOL(iw_create_cm_id);
+
+
+static int iwcm_modify_qp_err(struct ib_qp *qp)
+{
+	struct ib_qp_attr qp_attr;
+
+	if (!qp)
+		return -EINVAL;
+
+	qp_attr.qp_state = IB_QPS_ERR;
+	return ib_modify_qp(qp, &qp_attr, IB_QP_STATE);
+}
+
+/* 
+ * This is really the RDMAC CLOSING state. It is most similar to the
+ * IB SQD QP state. 
+ */
+static int iwcm_modify_qp_sqd(struct ib_qp *qp)
+{
+	struct ib_qp_attr qp_attr;
+
+	BUG_ON(qp == NULL);
+	qp_attr.qp_state = IB_QPS_SQD;
+	return ib_modify_qp(qp, &qp_attr, IB_QP_STATE);
+}
+
+/* 
+ * CM_ID <-- CLOSING
+ *
+ * Block if a passive or active connection is currenlty being processed. Then
+ * process the event as follows:
+ * - If we are ESTABLISHED, move to CLOSING and modify the QP state
+ *   based on the abrupt flag 
+ * - If the connection is already in the CLOSING or IDLE state, the peer is
+ *   disconnecting concurrently with us and we've already seen the 
+ *   DISCONNECT event -- ignore the request and return 0
+ * - Disconnect on a listening endpoint returns -EINVAL
+ */
+int iw_cm_disconnect(struct iw_cm_id *cm_id, int abrupt)
+{
+	struct iwcm_id_private *cm_id_priv;
+	unsigned long flags;
+	int ret = 0;
+	struct ib_qp *qp = NULL;
+
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	/* Wait if we're currently in a connect or accept downcall */
+	wait_event(cm_id_priv->connect_wait, 
+		   !test_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags));
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	switch (cm_id_priv->state) {
+	case IW_CM_STATE_ESTABLISHED:
+		cm_id_priv->state = IW_CM_STATE_CLOSING;
+
+		/* QP could be <nul> for user-mode client */
+		if (cm_id_priv->qp)
+			qp = cm_id_priv->qp;
+		else
+			ret = -EINVAL;
+		break;
+	case IW_CM_STATE_LISTEN:
+		ret = -EINVAL;
+		break;
+	case IW_CM_STATE_CLOSING:
+		/* remote peer closed first */
+	case IW_CM_STATE_IDLE:	
+		/* accept or connect returned !0 */
+		break;
+	case IW_CM_STATE_CONN_RECV:
+		/* 
+		 * App called disconnect before/without calling accept after
+		 * connect_request event delivered.
+		 */
+		break;
+	case IW_CM_STATE_CONN_SENT:
+		/* Can only get here if wait above fails */
+	default:		
+		BUG_ON(1);
+	}
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+
+	if (qp) {
+		if (abrupt)
+			ret = iwcm_modify_qp_err(qp);
+		else
+			ret = iwcm_modify_qp_sqd(qp);
+
+		/*
+		 * If both sides are disconnecting the QP could
+		 * already be in ERR or SQD states
+		 */
+		ret = 0;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(iw_cm_disconnect);
+
+/* 
+ * CM_ID <-- DESTROYING
+ * 
+ * Clean up all resources associated with the connection and release
+ * the initial reference taken by iw_create_cm_id. 
+ */
+static void destroy_cm_id(struct iw_cm_id *cm_id)
+{
+	struct iwcm_id_private *cm_id_priv;
+	unsigned long flags;
+	int ret;
+
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	/* Wait if we're currently in a connect or accept downcall. A
+	 * listening endpoint should never block here. */
+	wait_event(cm_id_priv->connect_wait, 
+		   !test_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags));
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	switch (cm_id_priv->state) {
+	case IW_CM_STATE_LISTEN:
+		cm_id_priv->state = IW_CM_STATE_DESTROYING;
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		/* destroy the listening endpoint */
+		ret = cm_id->device->iwcm->destroy_listen(cm_id);
+		spin_lock_irqsave(&cm_id_priv->lock, flags);
+		break;
+	case IW_CM_STATE_ESTABLISHED:
+		cm_id_priv->state = IW_CM_STATE_DESTROYING;
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		/* Abrupt close of the connection */
+		(void)iwcm_modify_qp_err(cm_id_priv->qp);
+		spin_lock_irqsave(&cm_id_priv->lock, flags);
+		break;
+	case IW_CM_STATE_IDLE:
+	case IW_CM_STATE_CLOSING:
+		cm_id_priv->state = IW_CM_STATE_DESTROYING;
+		break;
+	case IW_CM_STATE_CONN_RECV:
+		/* 
+		 * App called destroy before/without calling accept after
+		 * receiving connection request event notification.
+		 */ 
+		cm_id_priv->state = IW_CM_STATE_DESTROYING;
+		break;
+	case IW_CM_STATE_CONN_SENT:
+	case IW_CM_STATE_DESTROYING:
+	default:
+		BUG_ON(1);
+		break;
+	}
+	if (cm_id_priv->qp) {
+		cm_id_priv->id.device->iwcm->rem_ref(cm_id_priv->qp);
+		cm_id_priv->qp = NULL;
+	}
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+
+	(void)iwcm_deref_id(cm_id_priv);
+}
+
+/* 
+ * This function is only called by the application thread and cannot
+ * be called by the event thread. The function will wait for all
+ * references to be released on the cm_id and then kfree the cm_id
+ * object. 
+ */
+void iw_destroy_cm_id(struct iw_cm_id *cm_id)
+{
+	struct iwcm_id_private *cm_id_priv;
+
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+        BUG_ON(test_bit(IWCM_F_CALLBACK_DESTROY, &cm_id_priv->flags));
+
+	destroy_cm_id(cm_id);
+
+	wait_for_completion(&cm_id_priv->destroy_comp);
+
+	kfree(cm_id_priv);
+}
+EXPORT_SYMBOL(iw_destroy_cm_id);
+
+/* 
+ * CM_ID <-- LISTEN
+ *
+ * Start listening for connect requests. Generates one CONNECT_REQUEST
+ * event for each inbound connect request. 
+ */
+int iw_cm_listen(struct iw_cm_id *cm_id, int backlog)
+{
+	struct iwcm_id_private *cm_id_priv;
+	unsigned long flags;
+	int ret = 0;
+
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	switch (cm_id_priv->state) {
+	case IW_CM_STATE_IDLE:
+		cm_id_priv->state = IW_CM_STATE_LISTEN;
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		ret = cm_id->device->iwcm->create_listen(cm_id, backlog);
+		if (ret)
+			cm_id_priv->state = IW_CM_STATE_IDLE;
+		spin_lock_irqsave(&cm_id_priv->lock, flags);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(iw_cm_listen);
+
+/* 
+ * CM_ID <-- IDLE
+ *
+ * Rejects an inbound connection request. No events are generated.
+ */
+int iw_cm_reject(struct iw_cm_id *cm_id,
+		 const void *private_data,
+		 u8 private_data_len)
+{
+	struct iwcm_id_private *cm_id_priv;
+	unsigned long flags;
+	int ret;
+
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	set_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	if (cm_id_priv->state != IW_CM_STATE_CONN_RECV) {
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
+		wake_up_all(&cm_id_priv->connect_wait);
+		return -EINVAL;
+	}
+	cm_id_priv->state = IW_CM_STATE_IDLE;
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+
+	ret = cm_id->device->iwcm->reject(cm_id, private_data, 
+					  private_data_len);
+
+	clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
+	wake_up_all(&cm_id_priv->connect_wait);
+
+	return ret;
+}
+EXPORT_SYMBOL(iw_cm_reject);
+
+/* 
+ * CM_ID <-- ESTABLISHED
+ *
+ * Accepts an inbound connection request and generates an ESTABLISHED
+ * event. Callers of iw_cm_disconnect and iw_destroy_cm_id will block
+ * until the ESTABLISHED event is received from the provider. 
+ */
+int iw_cm_accept(struct iw_cm_id *cm_id, 
+		 struct iw_cm_conn_param *iw_param)
+{
+	struct iwcm_id_private *cm_id_priv;
+	struct ib_qp *qp;
+	unsigned long flags;
+	int ret;
+
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	set_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	if (cm_id_priv->state != IW_CM_STATE_CONN_RECV) {
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
+		wake_up_all(&cm_id_priv->connect_wait);
+		return -EINVAL;
+	}
+	/* Get the ib_qp given the QPN */
+	qp = cm_id->device->iwcm->get_qp(cm_id->device, iw_param->qpn);
+	if (!qp) {
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		return -EINVAL;
+	}
+	cm_id->device->iwcm->add_ref(qp);
+	cm_id_priv->qp = qp;
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+
+	ret = cm_id->device->iwcm->accept(cm_id, iw_param);
+	if (ret) {
+		/* An error on accept precludes provider events */
+		BUG_ON(cm_id_priv->state != IW_CM_STATE_CONN_RECV);
+		cm_id_priv->state = IW_CM_STATE_IDLE;
+		spin_lock_irqsave(&cm_id_priv->lock, flags);
+		if (cm_id_priv->qp) {
+			cm_id->device->iwcm->rem_ref(qp);
+			cm_id_priv->qp = NULL;
+		}
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		printk("Accept failed, ret=%d\n", ret);
+		clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
+		wake_up_all(&cm_id_priv->connect_wait);
+	}			
+
+	return ret;
+}
+EXPORT_SYMBOL(iw_cm_accept);
+
+/*
+ * Active Side: CM_ID <-- CONN_SENT
+ *
+ * If successful, results in the generation of a CONNECT_REPLY
+ * event. iw_cm_disconnect and iw_cm_destroy will block until the
+ * CONNECT_REPLY event is received from the provider.
+ */
+int iw_cm_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *iw_param)
+{
+	struct iwcm_id_private *cm_id_priv;
+	int ret = 0;
+	unsigned long flags;
+	struct ib_qp *qp;
+
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	set_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	if (cm_id_priv->state != IW_CM_STATE_IDLE) {
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
+		wake_up_all(&cm_id_priv->connect_wait);
+		return -EINVAL;
+	}
+		
+	/* Get the ib_qp given the QPN */
+	qp = cm_id->device->iwcm->get_qp(cm_id->device, iw_param->qpn);
+	if (!qp) {
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		return -EINVAL;
+	}
+	cm_id->device->iwcm->add_ref(qp);
+	cm_id_priv->qp = qp;
+	cm_id_priv->state = IW_CM_STATE_CONN_SENT;
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+
+	ret = cm_id->device->iwcm->connect(cm_id, iw_param);
+	if (ret) {
+		spin_lock_irqsave(&cm_id_priv->lock, flags);
+		if (cm_id_priv->qp) {
+			cm_id->device->iwcm->rem_ref(qp);
+			cm_id_priv->qp = NULL;
+		}
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		BUG_ON(cm_id_priv->state != IW_CM_STATE_CONN_SENT);
+		cm_id_priv->state = IW_CM_STATE_IDLE;
+		printk("Connect failed, ret=%d\n", ret);
+		clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
+		wake_up_all(&cm_id_priv->connect_wait);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(iw_cm_connect);
+
+/*
+ * Passive Side: new CM_ID <-- CONN_RECV
+ *
+ * Handles an inbound connect request. The function creates a new
+ * iw_cm_id to represent the new connection and inherits the client
+ * callback function and other attributes from the listening parent. 
+ * 
+ * The work item contains a pointer to the listen_cm_id and the event. The
+ * listen_cm_id contains the client cm_handler, context and
+ * device. These are copied when the device is cloned. The event
+ * contains the new four tuple.
+ *
+ * An error on the child should not affect the parent, so this
+ * function does not return a value.
+ */
+static void cm_conn_req_handler(struct iwcm_id_private *listen_id_priv, 
+				struct iw_cm_event *iw_event)
+{
+	unsigned long flags;
+	struct iw_cm_id *cm_id;
+	struct iwcm_id_private *cm_id_priv;
+	int ret;
+
+	/* The provider should never generate a connection request
+	 * event with a bad status. 
+	 */
+	BUG_ON(iw_event->status);
+
+	/* We could be destroying the listening id. If so, ignore this
+	 * upcall. */
+	spin_lock_irqsave(&listen_id_priv->lock, flags);
+	if (listen_id_priv->state != IW_CM_STATE_LISTEN) {
+		spin_unlock_irqrestore(&listen_id_priv->lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&listen_id_priv->lock, flags);
+
+	cm_id = iw_create_cm_id(listen_id_priv->id.device,	
+				listen_id_priv->id.cm_handler, 
+				listen_id_priv->id.context);
+	/* If the cm_id could not be created, ignore the request */
+	if (IS_ERR(cm_id)) 
+		return;
+
+	cm_id->provider_data = iw_event->provider_data;
+	cm_id->local_addr = iw_event->local_addr;
+	cm_id->remote_addr = iw_event->remote_addr;
+
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	cm_id_priv->state = IW_CM_STATE_CONN_RECV;
+	
+	/* Call the client CM handler */
+	ret = cm_id->cm_handler(cm_id, iw_event);
+	if (ret) {
+		set_bit(IWCM_F_CALLBACK_DESTROY, &cm_id_priv->flags);
+		destroy_cm_id(cm_id);
+		if (atomic_read(&cm_id_priv->refcount)==0)
+			kfree(cm_id);
+	}
+}
+
+/*
+ * Passive Side: CM_ID <-- ESTABLISHED
+ * 
+ * The provider generated an ESTABLISHED event which means that 
+ * the MPA negotion has completed successfully and we are now in MPA
+ * FPDU mode. 
+ *
+ * This event can only be received in the CONN_RECV state. If the
+ * remote peer closed, the ESTABLISHED event would be received followed
+ * by the CLOSE event. If the app closes, it will block until we wake
+ * it up after processing this event.
+ */
+static int cm_conn_est_handler(struct iwcm_id_private *cm_id_priv, 
+			       struct iw_cm_event *iw_event)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+
+	/* We clear the CONNECT_WAIT bit here to allow the callback
+	 * function to call iw_cm_disconnect. Calling iw_destroy_cm_id
+	 * from a callback handler is not allowed */
+	clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
+	BUG_ON(cm_id_priv->state != IW_CM_STATE_CONN_RECV);
+	cm_id_priv->state = IW_CM_STATE_ESTABLISHED;
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+	ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, iw_event);
+	wake_up_all(&cm_id_priv->connect_wait);
+
+	return ret;
+}
+
+/*
+ * Active Side: CM_ID <-- ESTABLISHED
+ *
+ * The app has called connect and is waiting for the established event to
+ * post it's requests to the server. This event will wake up anyone
+ * blocked in iw_cm_disconnect or iw_destroy_id.
+ */
+static int cm_conn_rep_handler(struct iwcm_id_private *cm_id_priv, 
+			       struct iw_cm_event *iw_event)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	/* Clear the connect wait bit so a callback function calling
+	 * iw_cm_disconnect will not wait and deadlock this thread */
+	clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
+	BUG_ON(cm_id_priv->state != IW_CM_STATE_CONN_SENT);
+	if (iw_event->status == IW_CM_EVENT_STATUS_ACCEPTED) {
+		cm_id_priv->id.local_addr = iw_event->local_addr;
+		cm_id_priv->id.remote_addr = iw_event->remote_addr;
+		cm_id_priv->state = IW_CM_STATE_ESTABLISHED;
+	} else {
+		/* REJECTED or RESET */
+		cm_id_priv->id.device->iwcm->rem_ref(cm_id_priv->qp);
+		cm_id_priv->qp = NULL;
+		cm_id_priv->state = IW_CM_STATE_IDLE;
+	}
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+	ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, iw_event);
+
+	/* Wake up waiters on connect complete */
+	wake_up_all(&cm_id_priv->connect_wait);
+
+	return ret;
+}
+
+/*
+ * CM_ID <-- CLOSING 
+ *
+ * If in the ESTABLISHED state, move to CLOSING.
+ */
+static void cm_disconnect_handler(struct iwcm_id_private *cm_id_priv, 
+				  struct iw_cm_event *iw_event)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	if (cm_id_priv->state == IW_CM_STATE_ESTABLISHED)
+		cm_id_priv->state = IW_CM_STATE_CLOSING;
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+}
+
+/*
+ * CM_ID <-- IDLE
+ *
+ * If in the ESTBLISHED or CLOSING states, the QP will have have been
+ * moved by the provider to the ERR state. Disassociate the CM_ID from
+ * the QP,  move to IDLE, and remove the 'connected' reference.
+ * 
+ * If in some other state, the cm_id was destroyed asynchronously.
+ * This is the last reference that will result in waking up
+ * the app thread blocked in iw_destroy_cm_id.
+ */
+static int cm_close_handler(struct iwcm_id_private *cm_id_priv, 
+				  struct iw_cm_event *iw_event)
+{
+	unsigned long flags;
+	int ret = 0;
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+
+	if (cm_id_priv->qp) {
+		cm_id_priv->id.device->iwcm->rem_ref(cm_id_priv->qp);
+		cm_id_priv->qp = NULL;
+	}
+	switch (cm_id_priv->state) {
+	case IW_CM_STATE_ESTABLISHED:
+	case IW_CM_STATE_CLOSING:
+		cm_id_priv->state = IW_CM_STATE_IDLE;
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, iw_event);
+		spin_lock_irqsave(&cm_id_priv->lock, flags);
+		break;
+	case IW_CM_STATE_DESTROYING:
+		break;
+	default:
+		BUG_ON(1);
+	}
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+
+	return ret;
+}
+
+static int process_event(struct iwcm_id_private *cm_id_priv, 
+			 struct iw_cm_event *iw_event)
+{
+	int ret = 0;
+
+	switch (iw_event->event) {
+	case IW_CM_EVENT_CONNECT_REQUEST:
+		cm_conn_req_handler(cm_id_priv, iw_event);
+		break;
+	case IW_CM_EVENT_CONNECT_REPLY:
+		ret = cm_conn_rep_handler(cm_id_priv, iw_event);
+		break;
+	case IW_CM_EVENT_ESTABLISHED:
+		ret = cm_conn_est_handler(cm_id_priv, iw_event);
+		break;
+	case IW_CM_EVENT_DISCONNECT:
+		cm_disconnect_handler(cm_id_priv, iw_event);
+		break;
+	case IW_CM_EVENT_CLOSE:
+		ret = cm_close_handler(cm_id_priv, iw_event);
+		break;
+	default:
+		BUG_ON(1);
+	}
+
+	return ret;
+}
+
+/* 
+ * Process events on the work_list for the cm_id. If the callback
+ * function requests that the cm_id be deleted, a flag is set in the
+ * cm_id flags to indicate that when the last reference is
+ * removed, the cm_id is to be destroyed. This is necessary to
+ * distinguish between an object that will be destroyed by the app
+ * thread asleep on the destroy_comp list vs. an object destroyed
+ * here synchronously when the last reference is removed.
+ */
+static void cm_work_handler(void *arg)
+{
+	struct iwcm_work *work = (struct iwcm_work*)arg;
+	struct iwcm_id_private *cm_id_priv = work->cm_id;
+	unsigned long flags;
+	int empty;
+	int ret = 0;
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	empty = list_empty(&cm_id_priv->work_list);
+	while (!empty) {
+		work = list_entry(cm_id_priv->work_list.next, 
+				  struct iwcm_work, list);
+		list_del_init(&work->list);
+		empty = list_empty(&cm_id_priv->work_list);
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+
+		ret = process_event(cm_id_priv, &work->event);
+		kfree(work);
+		if (ret) {
+			set_bit(IWCM_F_CALLBACK_DESTROY, &cm_id_priv->flags);
+			destroy_cm_id(&cm_id_priv->id);
+		}
+		BUG_ON(atomic_read(&cm_id_priv->refcount)==0);
+		if (iwcm_deref_id(cm_id_priv))
+			return;
+		
+		if (atomic_read(&cm_id_priv->refcount)==0 && 
+		    test_bit(IWCM_F_CALLBACK_DESTROY, &cm_id_priv->flags)) {
+			kfree(cm_id_priv);
+			return;
+		}
+		spin_lock_irqsave(&cm_id_priv->lock, flags);
+	}
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+}
+
+/* 
+ * This function is called on interrupt context. Schedule events on
+ * the iwcm_wq thread to allow callback functions to downcall into
+ * the CM and/or block.  Events are queued to a per-CM_ID
+ * work_list. If this is the first event on the work_list, the work
+ * element is also queued on the iwcm_wq thread.
+ *
+ * Each event holds a reference on the cm_id. Until the last posted
+ * event has been delivered and processed, the cm_id cannot be
+ * deleted. 
+ */
+static void cm_event_handler(struct iw_cm_id *cm_id,
+			     struct iw_cm_event *iw_event) 
+{
+	struct iwcm_work *work;
+	struct iwcm_id_private *cm_id_priv;
+	unsigned long flags;
+
+	work = kmalloc(sizeof(*work), GFP_ATOMIC);
+	if (!work)
+		return;
+
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	atomic_inc(&cm_id_priv->refcount);
+	
+	INIT_WORK(&work->work, cm_work_handler, work);
+	work->cm_id = cm_id_priv;
+	work->event = *iw_event;
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	if (list_empty(&cm_id_priv->work_list)) {
+		list_add_tail(&work->list, &cm_id_priv->work_list);
+		queue_work(iwcm_wq, &work->work);
+	} else
+		list_add_tail(&work->list, &cm_id_priv->work_list);
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+}
+
+static int iwcm_init_qp_init_attr(struct iwcm_id_private *cm_id_priv,
+				  struct ib_qp_attr *qp_attr,
+				  int *qp_attr_mask)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	switch (cm_id_priv->state) {
+	case IW_CM_STATE_IDLE:
+	case IW_CM_STATE_CONN_SENT:
+	case IW_CM_STATE_CONN_RECV:
+	case IW_CM_STATE_ESTABLISHED:
+		*qp_attr_mask = IB_QP_STATE | IB_QP_ACCESS_FLAGS;
+		qp_attr->qp_access_flags = IB_ACCESS_LOCAL_WRITE |
+					   IB_ACCESS_REMOTE_WRITE|
+					   IB_ACCESS_REMOTE_READ;
+		ret = 0;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+	return ret;
+}
+
+static int iwcm_init_qp_rts_attr(struct iwcm_id_private *cm_id_priv,
+				  struct ib_qp_attr *qp_attr,
+				  int *qp_attr_mask)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	switch (cm_id_priv->state) {
+	case IW_CM_STATE_IDLE:
+	case IW_CM_STATE_CONN_SENT:
+	case IW_CM_STATE_CONN_RECV:
+	case IW_CM_STATE_ESTABLISHED:
+		*qp_attr_mask = 0;
+		ret = 0;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+	return ret;
+}
+
+int iw_cm_init_qp_attr(struct iw_cm_id *cm_id,
+		       struct ib_qp_attr *qp_attr,
+		       int *qp_attr_mask)
+{
+	struct iwcm_id_private *cm_id_priv;
+	int ret;
+
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	switch (qp_attr->qp_state) {
+	case IB_QPS_INIT:
+	case IB_QPS_RTR:
+		ret = iwcm_init_qp_init_attr(cm_id_priv, 
+					     qp_attr, qp_attr_mask);
+		break;
+	case IB_QPS_RTS:
+		ret = iwcm_init_qp_rts_attr(cm_id_priv, 
+					    qp_attr, qp_attr_mask);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+EXPORT_SYMBOL(iw_cm_init_qp_attr);
+
+static int __init iw_cm_init(void)
+{
+	iwcm_wq = create_singlethread_workqueue("iw_cm_wq");
+	if (!iwcm_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void __exit iw_cm_cleanup(void)
+{
+	destroy_workqueue(iwcm_wq);
+}
+
+module_init(iw_cm_init);
+module_exit(iw_cm_cleanup);
diff --git a/include/rdma/iw_cm.h b/include/rdma/iw_cm.h
new file mode 100644
index 0000000..0752a94
--- /dev/null
+++ b/include/rdma/iw_cm.h
@@ -0,0 +1,254 @@
+/*
+ * Copyright (c) 2005 Network Appliance, Inc. All rights reserved.
+ * Copyright (c) 2005 Open Grid Computing, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+#if !defined(IW_CM_H)
+#define IW_CM_H
+
+#include <linux/in.h>
+#include <rdma/ib_cm.h>
+
+struct iw_cm_id;
+
+enum iw_cm_event_type {
+	IW_CM_EVENT_CONNECT_REQUEST = 1, /* connect request received */
+	IW_CM_EVENT_CONNECT_REPLY,	 /* reply from active connect request */
+	IW_CM_EVENT_ESTABLISHED,	 /* passive side accept successful */
+	IW_CM_EVENT_DISCONNECT,		 /* orderly shutdown */
+	IW_CM_EVENT_CLOSE		 /* close complete */
+};
+enum iw_cm_event_status {
+	IW_CM_EVENT_STATUS_OK = 0,	 /* request successful */
+	IW_CM_EVENT_STATUS_ACCEPTED = 0, /* connect request accepted */
+	IW_CM_EVENT_STATUS_REJECTED,	 /* connect request rejected */
+	IW_CM_EVENT_STATUS_TIMEOUT,	 /* the operation timed out */
+	IW_CM_EVENT_STATUS_RESET,	 /* reset from remote peer */
+	IW_CM_EVENT_STATUS_EINVAL,	 /* asynchronous failure for bad parm */
+};
+struct iw_cm_event {
+	enum iw_cm_event_type event;
+	enum iw_cm_event_status status;
+	struct sockaddr_in local_addr;
+	struct sockaddr_in remote_addr;
+	void *private_data;
+	u8 private_data_len;
+	void* provider_data;
+};
+
+/**
+ * iw_cm_handler - Function to be called by the IW CM when delivering events
+ * to the client.
+ *
+ * @cm_id: The IW CM identifier associated with the event.
+ * @event: Pointer to the event structure.
+ */
+typedef int (*iw_cm_handler)(struct iw_cm_id *cm_id,
+			     struct iw_cm_event *event);
+
+/**
+ * iw_event_handler - Function called by the provider when delivering provider
+ * events to the IW CM. 
+ *
+ * @cm_id: The IW CM identifier associated with the event.
+ * @event: Pointer to the event structure.
+ */
+typedef void (*iw_event_handler)(struct iw_cm_id *cm_id,
+				 struct iw_cm_event *event);
+struct iw_cm_id {
+	iw_cm_handler		cm_handler;      /* client callback function */
+	void		        *context;	 /* client cb context */
+	struct ib_device	*device;	 
+	struct sockaddr_in      local_addr;
+	struct sockaddr_in	remote_addr;
+	void			*provider_data;	 /* provider private data */
+	iw_event_handler        event_handler;   /* cb for provider
+						    events */
+	/* Used by provider to add and remove refs on IW cm_id */	
+	void (*add_ref)(struct iw_cm_id *);     
+	void (*rem_ref)(struct iw_cm_id *);
+};
+
+struct iw_cm_conn_param {
+	const void *private_data;
+	u16 private_data_len;
+	u32 ord;
+	u32 ird;
+	u32 qpn;
+};
+
+struct iw_cm_verbs {
+	void		(*add_ref)(struct ib_qp *qp);
+
+	void		(*rem_ref)(struct ib_qp *qp);
+
+	struct ib_qp *	(*get_qp)(struct ib_device *device,
+				  int qpn);
+
+	int		(*connect)(struct iw_cm_id *cm_id,
+				   struct iw_cm_conn_param *conn_param);
+	
+	int		(*accept)(struct iw_cm_id *cm_id, 
+				  struct iw_cm_conn_param *conn_param);
+
+	int		(*reject)(struct iw_cm_id *cm_id, 
+				  const void *pdata, u8 pdata_len);
+
+	int		(*create_listen)(struct iw_cm_id *cm_id,
+					 int backlog);
+
+	int		(*destroy_listen)(struct iw_cm_id *cm_id);
+};
+
+/**
+ * iw_create_cm_id - Create an IW CM identifier.
+ *
+ * @device: The IB device on which to create the IW CM identier.
+ * @event_handler: User callback invoked to report events associated with the
+ *   returned IW CM identifier. 
+ * @context: User specified context associated with the id.
+ */
+struct iw_cm_id *iw_create_cm_id(struct ib_device *device,
+				 iw_cm_handler cm_handler, void *context);
+
+/**
+ * iw_destroy_cm_id - Destroy an IW CM identifier.
+ *
+ * @cm_id: The previously created IW CM identifier to destroy.
+ *
+ * The client can assume that no events will be delivered for the CM ID after
+ * this function returns. 
+ */
+void iw_destroy_cm_id(struct iw_cm_id *cm_id);
+
+/**
+ * iw_cm_bind_qp - Unbind the specified IW CM identifier and QP
+ *
+ * @cm_id: The IW CM idenfier to unbind from the QP. 
+ * @qp: The QP
+ *
+ * This is called by the provider when destroying the QP to ensure
+ * that any references held by the IWCM are released. It may also
+ * be called by the IWCM when destroying a CM_ID to that any
+ * references held by the provider are released.
+ */
+void iw_cm_unbind_qp(struct iw_cm_id *cm_id, struct ib_qp *qp);
+
+/**
+ * iw_cm_get_qp - Return the ib_qp associated with a QPN
+ *
+ * @ib_device: The IB device
+ * @qpn: The queue pair number
+ */
+struct ib_qp *iw_cm_get_qp(struct ib_device *device, int qpn);
+
+/**
+ * iw_cm_listen - Listen for incoming connection requests on the
+ * specified IW CM id. 
+ *
+ * @cm_id: The IW CM identifier.
+ * @backlog: The maximum number of outstanding un-accepted inbound listen
+ *   requests to queue. 
+ * 
+ * The source address and port number are specified in the IW CM identifier
+ * structure.
+ */
+int iw_cm_listen(struct iw_cm_id *cm_id, int backlog);
+
+/**
+ * iw_cm_accept - Called to accept an incoming connect request. 
+ *
+ * @cm_id: The IW CM identifier associated with the connection request. 
+ * @iw_param: Pointer to a structure containing connection establishment
+ *   parameters. 
+ *
+ * The specified cm_id will have been provided in the event data for a
+ * CONNECT_REQUEST event. Subsequent events related to this connection will be
+ * delivered to the specified IW CM identifier prior and may occur prior to
+ * the return of this function. If this function returns a non-zero value, the
+ * client can assume that no events will be delivered to the specified IW CM
+ * identifier. 
+ */
+int iw_cm_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *iw_param);
+
+/**
+ * iw_cm_reject - Reject an incoming connection request.
+ *
+ * @cm_id: Connection identifier associated with the request.
+ * @private_daa: Pointer to data to deliver to the remote peer as part of the
+ *   reject message. 
+ * @private_data_len: The number of bytes in the private_data parameter. 
+ *
+ * The client can assume that no events will be delivered to the specified IW
+ * CM identifier following the return of this function. The private_data
+ * buffer is available for reuse when this function returns. 
+ */
+int iw_cm_reject(struct iw_cm_id *cm_id, const void *private_data,
+		 u8 private_data_len);
+
+/**
+ * iw_cm_connect - Called to request a connection to a remote peer. 
+ *
+ * @cm_id: The IW CM identifier for the connection.
+ * @iw_param: Pointer to a structure containing connection  establishment
+ *   parameters. 
+ *
+ * Events may be delivered to the specified IW CM identifier prior to the
+ * return of this function. If this function returns a non-zero value, the
+ * client can assume that no events will be delivered to the specified IW CM
+ * identifier.  
+ */
+int iw_cm_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *iw_param);
+
+/**
+ * iw_cm_disconnect - Close the specified connection. 
+ *
+ * @cm_id: The IW CM identifier to close.
+ * @abrupt: If 0, the connection will be closed gracefully, otherwise, the
+ *   connection will be reset.  
+ *
+ * The IW CM identifier is still active until the IW_CM_EVENT_CLOSE event is
+ * delivered. 
+ */
+int iw_cm_disconnect(struct iw_cm_id *cm_id, int abrupt);
+
+/**
+ * iw_cm_init_qp_attr - Called to initialize the attributes of the QP
+ * associated with a IW CM identifier.
+ *
+ * @cm_id: The IW CM identifier associated with the QP
+ * @qp_attr: Pointer to the QP attributes structure. 
+ * @qp_attr_mask: Pointer to a bit vector specifying which QP attributes are
+ *   valid.  
+ */
+int iw_cm_init_qp_attr(struct iw_cm_id *cm_id, struct ib_qp_attr *qp_attr,
+		       int *qp_attr_mask);
+
+#endif /* IW_CM_H */
diff --git a/include/rdma/iw_cm_private.h b/include/rdma/iw_cm_private.h
new file mode 100644
index 0000000..aba8cb2
--- /dev/null
+++ b/include/rdma/iw_cm_private.h
@@ -0,0 +1,62 @@
+/*
+ * Copyright (c) 2005 Network Appliance, Inc. All rights reserved.
+ * Copyright (c) 2005 Open Grid Computing, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+#if !defined(IW_CM_PRIVATE_H)
+#define IW_CM_PRIVATE_H
+
+#include <rdma/iw_cm.h>
+
+enum iw_cm_state {
+	IW_CM_STATE_IDLE,             /* unbound, inactive */
+	IW_CM_STATE_LISTEN,           /* listen waiting for connect */
+	IW_CM_STATE_CONN_RECV,        /* inbound waiting for user accept */
+	IW_CM_STATE_CONN_SENT,        /* outbound waiting for peer accept */
+	IW_CM_STATE_ESTABLISHED,      /* established */
+	IW_CM_STATE_CLOSING,	      /* disconnect */
+	IW_CM_STATE_DESTROYING        /* object being deleted */
+};
+
+struct iwcm_id_private {
+	struct iw_cm_id	id;
+	enum iw_cm_state state;
+	unsigned long flags;
+	struct ib_qp *qp;
+	struct completion destroy_comp;
+	wait_queue_head_t connect_wait;
+	struct list_head work_list;
+	spinlock_t lock;
+	atomic_t refcount;
+};
+#define IWCM_F_CALLBACK_DESTROY   1
+#define IWCM_F_CONNECT_WAIT       2
+
+#endif /* IW_CM_PRIVATE_H */
