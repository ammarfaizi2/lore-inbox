Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWEaS2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWEaS2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 14:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWEaS2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 14:28:53 -0400
Received: from rrcs-24-227-247-130.sw.biz.rr.com ([24.227.247.130]:8663 "EHLO
	linux.local") by vger.kernel.org with ESMTP id S965086AbWEaS1p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 14:27:45 -0400
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 4/7] AMSO1100 OpenFabrics Provider.
Date: Wed, 31 May 2006 13:27:42 -0500
To: rdreier@cisco.com, mshefty@ichips.intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org
Message-Id: <20060531182742.3652.15436.stgit@stevo-desktop>
In-Reply-To: <20060531182733.3652.54755.stgit@stevo-desktop>
References: <20060531182733.3652.54755.stgit@stevo-desktop>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



---

 drivers/infiniband/hw/amso1100/c2_cm.c       |  452 ++++++++++++
 drivers/infiniband/hw/amso1100/c2_cq.c       |  424 +++++++++++
 drivers/infiniband/hw/amso1100/c2_pd.c       |   71 ++
 drivers/infiniband/hw/amso1100/c2_provider.c |  871 +++++++++++++++++++++++
 drivers/infiniband/hw/amso1100/c2_provider.h |  182 +++++
 drivers/infiniband/hw/amso1100/c2_qp.c       |  975 ++++++++++++++++++++++++++
 drivers/infiniband/hw/amso1100/c2_user.h     |   82 ++
 7 files changed, 3057 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/amso1100/c2_cm.c b/drivers/infiniband/hw/amso1100/c2_cm.c
new file mode 100644
index 0000000..018d11f
--- /dev/null
+++ b/drivers/infiniband/hw/amso1100/c2_cm.c
@@ -0,0 +1,452 @@
+/*
+ * Copyright (c) 2005 Ammasso, Inc.  All rights reserved.
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
+ *
+ */
+#include "c2.h"
+#include "c2_wr.h"
+#include "c2_vq.h"
+#include <rdma/iw_cm.h>
+
+int c2_llp_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *iw_param)
+{
+	struct c2_dev *c2dev = to_c2dev(cm_id->device);
+	struct ib_qp *ibqp;
+	struct c2_qp *qp;
+	struct c2wr_qp_connect_req *wr;	/* variable size needs a malloc. */
+	struct c2_vq_req *vq_req;
+	int err;
+
+	ibqp = c2_get_qp(cm_id->device, iw_param->qpn);
+	if (!ibqp)
+		return -EINVAL;
+	qp = to_c2qp(ibqp);
+
+	/* Associate QP <--> CM_ID */
+	cm_id->provider_data = qp;
+	cm_id->add_ref(cm_id);
+	qp->cm_id = cm_id;
+
+	/*
+	 * only support the max private_data length
+	 */
+	if (iw_param->private_data_len > C2_MAX_PRIVATE_DATA_SIZE) {
+		err = -EINVAL;
+		goto bail0;
+	}
+	/* 
+	 * Set the rdma read limits 
+	 */
+	err = c2_qp_set_read_limits(c2dev, qp, iw_param->ord, iw_param->ird);
+	if (err)
+		goto bail0;
+
+	/*
+	 * Create and send a WR_QP_CONNECT...
+	 */
+	wr = kmalloc(c2dev->req_vq.msg_size, GFP_KERNEL);
+	if (!wr) {
+		err = -ENOMEM;
+		goto bail0;
+	}
+
+	vq_req = vq_req_alloc(c2dev);
+	if (!vq_req) {
+		err = -ENOMEM;
+		goto bail1;
+	}
+
+	c2_wr_set_id(wr, CCWR_QP_CONNECT);
+	wr->hdr.context = 0;
+	wr->rnic_handle = c2dev->adapter_handle;
+	wr->qp_handle = qp->adapter_handle;
+
+	wr->remote_addr = cm_id->remote_addr.sin_addr.s_addr;
+	wr->remote_port = cm_id->remote_addr.sin_port;
+
+	/*
+	 * Move any private data from the callers's buf into 
+	 * the WR.
+	 */
+	if (iw_param->private_data) {
+		wr->private_data_length = 
+			cpu_to_be32(iw_param->private_data_len);
+		memcpy(&wr->private_data[0], iw_param->private_data,
+		       iw_param->private_data_len);
+	} else
+		wr->private_data_length = 0;
+
+	/*
+	 * Send WR to adapter.  NOTE: There is no synch reply from 
+	 * the adapter.
+	 */
+	err = vq_send_wr(c2dev, (union c2wr *) wr);
+	vq_req_free(c2dev, vq_req);
+
+ bail1:
+	kfree(wr);
+ bail0:
+	if (err) {
+		/* 
+		 * If we fail, release reference on QP and
+		 * disassociate QP from CM_ID  
+		 */
+		cm_id->provider_data = NULL;
+		qp->cm_id = NULL;
+		cm_id->rem_ref(cm_id);
+	}
+	return err;
+}
+
+int c2_llp_service_create(struct iw_cm_id *cm_id, int backlog)
+{
+	struct c2_dev *c2dev;
+	struct c2wr_ep_listen_create_req wr;
+	struct c2wr_ep_listen_create_rep *reply;
+	struct c2_vq_req *vq_req;
+	int err;
+
+	c2dev = to_c2dev(cm_id->device);
+	if (c2dev == NULL)
+		return -EINVAL;
+
+	/*
+	 * Allocate verbs request.
+	 */
+	vq_req = vq_req_alloc(c2dev);
+	if (!vq_req)
+		return -ENOMEM;
+
+	/* 
+	 * Build the WR
+	 */
+	c2_wr_set_id(&wr, CCWR_EP_LISTEN_CREATE);
+	wr.hdr.context = (u64) (unsigned long) vq_req;
+	wr.rnic_handle = c2dev->adapter_handle;
+	wr.local_addr = cm_id->local_addr.sin_addr.s_addr;
+	wr.local_port = cm_id->local_addr.sin_port;
+	wr.backlog = cpu_to_be32(backlog);
+	wr.user_context = (u64) (unsigned long) cm_id;
+
+	/*
+	 * Reference the request struct.  Dereferenced in the int handler.
+	 */
+	vq_req_get(c2dev, vq_req);
+
+	/*
+	 * Send WR to adapter
+	 */
+	err = vq_send_wr(c2dev, (union c2wr *) & wr);
+	if (err) {
+		vq_req_put(c2dev, vq_req);
+		goto bail0;
+	}
+
+	/*
+	 * Wait for reply from adapter
+	 */
+	err = vq_wait_for_reply(c2dev, vq_req);
+	if (err)
+		goto bail0;
+
+	/*
+	 * Process reply 
+	 */
+	reply =
+	    (struct c2wr_ep_listen_create_rep *) (unsigned long) vq_req->reply_msg;
+	if (!reply) {
+		err = -ENOMEM;
+		goto bail1;
+	}
+
+	if ((err = c2_errno(reply)) != 0)
+		goto bail1;
+
+	/* 
+	 * Keep the adapter handle. Used in subsequent destroy 
+	 */
+	cm_id->provider_data = (void*)(unsigned long) reply->ep_handle;
+
+	/*
+	 * free vq stuff
+	 */
+	vq_repbuf_free(c2dev, reply);
+	vq_req_free(c2dev, vq_req);
+
+	return 0;
+
+ bail1:
+	vq_repbuf_free(c2dev, reply);
+ bail0:
+	vq_req_free(c2dev, vq_req);
+	return err;
+}
+
+
+int c2_llp_service_destroy(struct iw_cm_id *cm_id)
+{
+
+	struct c2_dev *c2dev;
+	struct c2wr_ep_listen_destroy_req wr;
+	struct c2wr_ep_listen_destroy_rep *reply;
+	struct c2_vq_req *vq_req;
+	int err;
+
+	c2dev = to_c2dev(cm_id->device);
+	if (c2dev == NULL)
+		return -EINVAL;
+
+	/*
+	 * Allocate verbs request.
+	 */
+	vq_req = vq_req_alloc(c2dev);
+	if (!vq_req)
+		return -ENOMEM;
+
+	/* 
+	 * Build the WR
+	 */
+	c2_wr_set_id(&wr, CCWR_EP_LISTEN_DESTROY);
+	wr.hdr.context = (unsigned long) vq_req;
+	wr.rnic_handle = c2dev->adapter_handle;
+	wr.ep_handle = (u32)(unsigned long)cm_id->provider_data;
+
+	/*
+	 * reference the request struct.  dereferenced in the int handler.
+	 */
+	vq_req_get(c2dev, vq_req);
+
+	/*
+	 * Send WR to adapter
+	 */
+	err = vq_send_wr(c2dev, (union c2wr *) & wr);
+	if (err) {
+		vq_req_put(c2dev, vq_req);
+		goto bail0;
+	}
+
+	/*
+	 * Wait for reply from adapter
+	 */
+	err = vq_wait_for_reply(c2dev, vq_req);
+	if (err)
+		goto bail0;
+
+	/*
+	 * Process reply 
+	 */
+	reply=(struct c2wr_ep_listen_destroy_rep *)(unsigned long)vq_req->reply_msg;
+	if (!reply) {
+		err = -ENOMEM;
+		goto bail0;
+	}
+	if ((err = c2_errno(reply)) != 0)
+		goto bail1;
+
+ bail1:
+	vq_repbuf_free(c2dev, reply);
+ bail0:
+	vq_req_free(c2dev, vq_req);
+	return err;
+}
+
+int c2_llp_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *iw_param)
+{
+	struct c2_dev *c2dev = to_c2dev(cm_id->device);
+	struct c2_qp *qp;
+	struct ib_qp *ibqp;
+	struct c2wr_cr_accept_req *wr;	/* variable length WR */
+	struct c2_vq_req *vq_req;
+	struct c2wr_cr_accept_rep *reply;	/* VQ Reply msg ptr. */
+	int err;
+
+	ibqp = c2_get_qp(cm_id->device, iw_param->qpn);
+	if (!ibqp)
+		return -EINVAL;
+	qp = to_c2qp(ibqp);
+
+	/* Set the RDMA read limits */
+	err = c2_qp_set_read_limits(c2dev, qp, iw_param->ord, iw_param->ird);
+	if (err)
+		goto bail0;
+
+	/* Allocate verbs request. */
+	vq_req = vq_req_alloc(c2dev);
+	if (!vq_req) {
+		err = -ENOMEM;
+		goto bail1;
+	}
+	vq_req->qp = qp;
+	vq_req->cm_id = cm_id;
+	vq_req->event = IW_CM_EVENT_ESTABLISHED;
+
+	wr = kmalloc(c2dev->req_vq.msg_size, GFP_KERNEL);
+	if (!wr) {
+		err = -ENOMEM;
+		goto bail2;
+	}
+
+	/* Build the WR */
+	c2_wr_set_id(wr, CCWR_CR_ACCEPT);
+	wr->hdr.context = (unsigned long) vq_req;
+	wr->rnic_handle = c2dev->adapter_handle;
+	wr->ep_handle = (u32) (unsigned long) cm_id->provider_data;
+	wr->qp_handle = qp->adapter_handle;
+
+	/* Replace the cr_handle with the QP after accept */
+	cm_id->provider_data = qp;
+	cm_id->add_ref(cm_id);
+	qp->cm_id = cm_id;
+
+	cm_id->provider_data = qp;
+
+	/* Validate private_data length */
+	if (iw_param->private_data_len > C2_MAX_PRIVATE_DATA_SIZE) {
+		err = -EINVAL;
+		goto bail2;
+	}
+
+	if (iw_param->private_data) {
+		wr->private_data_length = cpu_to_be32(iw_param->private_data_len);
+		memcpy(&wr->private_data[0], 
+		       iw_param->private_data, iw_param->private_data_len);
+	} else 
+		wr->private_data_length = 0;
+
+	/* Reference the request struct.  Dereferenced in the int handler. */
+	vq_req_get(c2dev, vq_req);
+
+	/* Send WR to adapter */
+	err = vq_send_wr(c2dev, (union c2wr *) wr);
+	if (err) {
+		vq_req_put(c2dev, vq_req);
+		goto bail2;
+	}
+
+	/* Wait for reply from adapter */
+	err = vq_wait_for_reply(c2dev, vq_req);
+	if (err)
+		goto bail2;
+
+	/* Check that reply is present */
+	reply = (struct c2wr_cr_accept_rep *) (unsigned long) vq_req->reply_msg;
+	if (!reply) {
+		err = -ENOMEM;
+		goto bail2;
+	}
+
+	err = c2_errno(reply);
+	vq_repbuf_free(c2dev, reply);
+
+	if (!err)
+		c2_set_qp_state(qp, C2_QP_STATE_RTS);
+ bail2:
+	kfree(wr);
+ bail1:
+	vq_req_free(c2dev, vq_req);
+ bail0:
+	if (err) {
+		/* 
+		 * If we fail, release reference on QP and
+		 * disassociate QP from CM_ID  
+		 */
+		cm_id->provider_data = NULL;
+		qp->cm_id = NULL;
+		cm_id->rem_ref(cm_id);
+	}
+	return err;
+}
+
+int c2_llp_reject(struct iw_cm_id *cm_id, const void *pdata, u8 pdata_len)
+{
+	struct c2_dev *c2dev;
+	struct c2wr_cr_reject_req wr;
+	struct c2_vq_req *vq_req;
+	struct c2wr_cr_reject_rep *reply;
+	int err;
+
+	c2dev = to_c2dev(cm_id->device);
+
+	/*
+	 * Allocate verbs request.
+	 */
+	vq_req = vq_req_alloc(c2dev);
+	if (!vq_req)
+		return -ENOMEM;
+
+	/* 
+	 * Build the WR
+	 */
+	c2_wr_set_id(&wr, CCWR_CR_REJECT);
+	wr.hdr.context = (unsigned long) vq_req;
+	wr.rnic_handle = c2dev->adapter_handle;
+	wr.ep_handle = (u32) (unsigned long) cm_id->provider_data;
+
+	/*
+	 * reference the request struct.  dereferenced in the int handler.
+	 */
+	vq_req_get(c2dev, vq_req);
+
+	/*
+	 * Send WR to adapter
+	 */
+	err = vq_send_wr(c2dev, (union c2wr *) & wr);
+	if (err) {
+		vq_req_put(c2dev, vq_req);
+		goto bail0;
+	}
+
+	/*
+	 * Wait for reply from adapter
+	 */
+	err = vq_wait_for_reply(c2dev, vq_req);
+	if (err)
+		goto bail0;
+
+	/*
+	 * Process reply 
+	 */
+	reply = (struct c2wr_cr_reject_rep *) (unsigned long) 
+		vq_req->reply_msg;
+	if (!reply) {
+		err = -ENOMEM;
+		goto bail0;
+	}
+	err = c2_errno(reply);
+	/*
+	 * free vq stuff
+	 */
+	vq_repbuf_free(c2dev, reply);
+
+ bail0:
+	vq_req_free(c2dev, vq_req);
+	return err;
+}
diff --git a/drivers/infiniband/hw/amso1100/c2_cq.c b/drivers/infiniband/hw/amso1100/c2_cq.c
new file mode 100644
index 0000000..77351d7
--- /dev/null
+++ b/drivers/infiniband/hw/amso1100/c2_cq.c
@@ -0,0 +1,424 @@
+/*
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
+ * Copyright (c) 2005 Cisco Systems, Inc. All rights reserved.
+ * Copyright (c) 2005 Mellanox Technologies. All rights reserved.
+ * Copyright (c) 2004 Voltaire, Inc. All rights reserved.
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
+ *
+ */
+#include "c2.h"
+#include "c2_vq.h"
+#include "c2_status.h"
+
+#define C2_CQ_MSG_SIZE ((sizeof(struct c2wr_ce) + 32-1) & ~(32-1))
+
+struct c2_cq *c2_cq_get(struct c2_dev *c2dev, int cqn)
+{
+	struct c2_cq *cq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&c2dev->lock, flags);
+	cq = c2dev->qptr_array[cqn];
+	if (!cq) {
+		spin_unlock_irqrestore(&c2dev->lock, flags);
+		return NULL;
+	}
+	atomic_inc(&cq->refcount);
+	spin_unlock_irqrestore(&c2dev->lock, flags);
+	return cq;
+}
+
+void c2_cq_put(struct c2_cq *cq)
+{
+	if (atomic_dec_and_test(&cq->refcount))
+		wake_up(&cq->wait);
+}
+
+void c2_cq_event(struct c2_dev *c2dev, u32 mq_index)
+{
+	struct c2_cq *cq;
+
+	cq = c2_cq_get(c2dev, mq_index);
+	if (!cq) {
+		printk("discarding events on destroyed CQN=%d\n", mq_index);
+		return;
+	}
+
+	assert(cq->ibcq.comp_handler);
+	(*cq->ibcq.comp_handler) (&cq->ibcq, cq->ibcq.cq_context);
+	c2_cq_put(cq);
+}
+
+void c2_cq_clean(struct c2_dev *c2dev, struct c2_qp *qp, u32 mq_index)
+{
+	struct c2_cq *cq;
+	struct c2_mq *q;
+
+	cq = c2_cq_get(c2dev, mq_index);
+	if (!cq)
+		return;
+
+	spin_lock_irq(&cq->lock);
+	q = &cq->mq;
+	if (q && !c2_mq_empty(q)) {
+		u16 priv = q->priv;
+		struct c2wr_ce *msg;
+
+		while (priv != be16_to_cpu(*q->shared)) {
+			msg = (struct c2wr_ce *) 
+				(q->msg_pool.host + priv * q->msg_size);
+			if (msg->qp_user_context == (u64) (unsigned long) qp) {
+				msg->qp_user_context = (u64) 0;
+			}
+			priv = (priv + 1) % q->q_size;
+		}
+	}
+	spin_unlock_irq(&cq->lock);
+	c2_cq_put(cq);
+}
+
+static inline enum ib_wc_status c2_cqe_status_to_openib(u8 status)
+{
+	switch (status) {
+	case C2_OK:
+		return IB_WC_SUCCESS;
+	case CCERR_FLUSHED:
+		return IB_WC_WR_FLUSH_ERR;
+	case CCERR_BASE_AND_BOUNDS_VIOLATION:
+		return IB_WC_LOC_PROT_ERR;
+	case CCERR_ACCESS_VIOLATION:
+		return IB_WC_LOC_ACCESS_ERR;
+	case CCERR_TOTAL_LENGTH_TOO_BIG:
+		return IB_WC_LOC_LEN_ERR;
+	case CCERR_INVALID_WINDOW:
+		return IB_WC_MW_BIND_ERR;
+	default:
+		return IB_WC_GENERAL_ERR;
+	}
+}
+
+
+static inline int c2_poll_one(struct c2_dev *c2dev,
+			      struct c2_cq *cq, struct ib_wc *entry)
+{
+	struct c2wr_ce *ce;
+	struct c2_qp *qp;
+	int is_recv = 0;
+
+	ce = (struct c2wr_ce *) c2_mq_consume(&cq->mq);
+	if (!ce) {
+		return -EAGAIN;
+	}
+
+	/*
+	 * if the qp returned is null then this qp has already 
+	 * been freed and we are unable process the completion.  
+	 * try pulling the next message
+	 */
+	while ((qp =
+		(struct c2_qp *) (unsigned long) ce->qp_user_context) == NULL) {
+		c2_mq_free(&cq->mq);
+		ce = (struct c2wr_ce *) c2_mq_consume(&cq->mq);
+		if (!ce)
+			return -EAGAIN;
+	}
+
+	entry->status = c2_cqe_status_to_openib(c2_wr_get_result(ce));
+	entry->wr_id = ce->hdr.context;
+	entry->qp_num = ce->handle;
+	entry->wc_flags = 0;
+	entry->slid = 0;
+	entry->sl = 0;
+	entry->src_qp = 0;
+	entry->dlid_path_bits = 0;
+	entry->pkey_index = 0;
+
+	switch (c2_wr_get_id(ce)) {
+	case C2_WR_TYPE_SEND:
+		entry->opcode = IB_WC_SEND;
+		break;
+	case C2_WR_TYPE_RDMA_WRITE:
+		entry->opcode = IB_WC_RDMA_WRITE;
+		break;
+	case C2_WR_TYPE_RDMA_READ:
+		entry->opcode = IB_WC_RDMA_READ;
+		break;
+	case C2_WR_TYPE_BIND_MW:
+		entry->opcode = IB_WC_BIND_MW;
+		break;
+	case C2_WR_TYPE_RECV:
+		entry->byte_len = be32_to_cpu(ce->bytes_rcvd);
+		entry->opcode = IB_WC_RECV;
+		is_recv = 1;
+		break;
+	default:
+		break;
+	}
+
+	/* consume the WQEs */
+	if (is_recv)
+		c2_mq_lconsume(&qp->rq_mq, 1);
+	else
+		c2_mq_lconsume(&qp->sq_mq,
+			       be32_to_cpu(c2_wr_get_wqe_count(ce)) + 1);
+
+	/* free the message */
+	c2_mq_free(&cq->mq);
+
+	return 0;
+}
+
+int c2_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *entry)
+{
+	struct c2_dev *c2dev = to_c2dev(ibcq->device);
+	struct c2_cq *cq = to_c2cq(ibcq);
+	unsigned long flags;
+	int npolled, err;
+
+	spin_lock_irqsave(&cq->lock, flags);
+
+	for (npolled = 0; npolled < num_entries; ++npolled) {
+
+		err = c2_poll_one(c2dev, cq, entry + npolled);
+		if (err)
+			break;
+	}
+
+	spin_unlock_irqrestore(&cq->lock, flags);
+
+	return npolled;
+}
+
+int c2_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify notify)
+{
+	struct c2_mq_shared __iomem *shared;
+	struct c2_cq *cq;
+
+	cq = to_c2cq(ibcq);
+	shared = cq->mq.peer;
+
+	if (notify == IB_CQ_NEXT_COMP)
+		writeb(C2_CQ_NOTIFICATION_TYPE_NEXT, &shared->notification_type);
+	else if (notify == IB_CQ_SOLICITED)
+		writeb(C2_CQ_NOTIFICATION_TYPE_NEXT_SE, &shared->notification_type);
+	else
+		return -EINVAL;
+
+	writeb(CQ_WAIT_FOR_DMA | CQ_ARMED, &shared->armed);
+
+	/*
+	 * Now read back shared->armed to make the PCI
+	 * write synchronous.  This is necessary for
+	 * correct cq notification semantics.
+	 */
+	readb(&shared->armed);
+
+	return 0;
+}
+
+static void c2_free_cq_buf(struct c2_mq *mq)
+{
+	free_pages((unsigned long) mq->msg_pool.host, 
+		   get_order(mq->q_size * mq->msg_size));
+}
+
+static int c2_alloc_cq_buf(struct c2_mq *mq, int q_size, int msg_size)
+{
+	unsigned long pool_start;
+
+	pool_start = __get_free_pages(GFP_KERNEL, 
+				      get_order(q_size * msg_size));
+	if (!pool_start)
+		return -ENOMEM;
+
+	c2_mq_rep_init(mq, 
+		       0,		/* index (currently unknown) */
+		       q_size, 
+		       msg_size, 
+		       (u8 *) pool_start, 
+		       NULL,	/* peer (currently unknown) */
+		       C2_MQ_HOST_TARGET);
+
+	return 0;
+}
+
+int c2_init_cq(struct c2_dev *c2dev, int entries,
+	       struct c2_ucontext *ctx, struct c2_cq *cq)
+{
+	struct c2wr_cq_create_req wr;
+	struct c2wr_cq_create_rep *reply;
+	unsigned long peer_pa;
+	struct c2_vq_req *vq_req;
+	int err;
+
+	might_sleep();
+
+	cq->ibcq.cqe = entries - 1;
+	cq->is_kernel = !ctx;
+
+	/* Allocate a shared pointer */
+	cq->mq.shared = c2_alloc_mqsp(c2dev->kern_mqsp_pool);
+	if (!cq->mq.shared)
+		return -ENOMEM;
+
+	/* Allocate pages for the message pool */
+	err = c2_alloc_cq_buf(&cq->mq, entries + 1, C2_CQ_MSG_SIZE);
+	if (err)
+		goto bail0;
+
+	vq_req = vq_req_alloc(c2dev);
+	if (!vq_req) {
+		err = -ENOMEM;
+		goto bail1;
+	}
+
+	memset(&wr, 0, sizeof(wr));
+	c2_wr_set_id(&wr, CCWR_CQ_CREATE);
+	wr.hdr.context = (unsigned long) vq_req;
+	wr.rnic_handle = c2dev->adapter_handle;
+	wr.msg_size = cpu_to_be32(cq->mq.msg_size);
+	wr.depth = cpu_to_be32(cq->mq.q_size);
+	wr.shared_ht = cpu_to_be64(__pa(cq->mq.shared));
+	wr.msg_pool = cpu_to_be64(__pa(cq->mq.msg_pool.host));
+	wr.user_context = (u64) (unsigned long) (cq);
+
+	vq_req_get(c2dev, vq_req);
+
+	err = vq_send_wr(c2dev, (union c2wr *) & wr);
+	if (err) {
+		vq_req_put(c2dev, vq_req);
+		goto bail2;
+	}
+
+	err = vq_wait_for_reply(c2dev, vq_req);
+	if (err)
+		goto bail2;
+
+	reply = (struct c2wr_cq_create_rep *) (unsigned long) (vq_req->reply_msg);
+	if (!reply) {
+		err = -ENOMEM;
+		goto bail2;
+	}
+
+	if ((err = c2_errno(reply)) != 0)
+		goto bail3;
+
+	cq->adapter_handle = reply->cq_handle;
+	cq->mq.index = be32_to_cpu(reply->mq_index);
+
+	peer_pa = c2dev->pa + be32_to_cpu(reply->adapter_shared);
+	cq->mq.peer = ioremap_nocache(peer_pa, PAGE_SIZE);
+	if (!cq->mq.peer) {
+		err = -ENOMEM;
+		goto bail3;
+	}
+
+	vq_repbuf_free(c2dev, reply);
+	vq_req_free(c2dev, vq_req);
+
+	spin_lock_init(&cq->lock);
+	atomic_set(&cq->refcount, 1);
+	init_waitqueue_head(&cq->wait);
+
+	/* 
+	 * Use the MQ index allocated by the adapter to
+	 * store the CQ in the qptr_array
+	 */
+	cq->cqn = cq->mq.index;
+	c2dev->qptr_array[cq->cqn] = cq;
+
+	return 0;
+
+      bail3:
+	vq_repbuf_free(c2dev, reply);
+      bail2:
+	vq_req_free(c2dev, vq_req);
+      bail1:
+	c2_free_cq_buf(&cq->mq);
+      bail0:
+	c2_free_mqsp(cq->mq.shared);
+
+	return err;
+}
+
+void c2_free_cq(struct c2_dev *c2dev, struct c2_cq *cq)
+{
+	int err;
+	struct c2_vq_req *vq_req;
+	struct c2wr_cq_destroy_req wr;
+	struct c2wr_cq_destroy_rep *reply;
+
+	might_sleep();
+
+	/* Clear CQ from the qptr array */
+	spin_lock_irq(&c2dev->lock);
+	c2dev->qptr_array[cq->mq.index] = NULL;
+	atomic_dec(&cq->refcount);
+	spin_unlock_irq(&c2dev->lock);
+
+	wait_event(cq->wait, !atomic_read(&cq->refcount));
+
+	vq_req = vq_req_alloc(c2dev);
+	if (!vq_req) {
+		goto bail0;
+	}
+
+	memset(&wr, 0, sizeof(wr));
+	c2_wr_set_id(&wr, CCWR_CQ_DESTROY);
+	wr.hdr.context = (unsigned long) vq_req;
+	wr.rnic_handle = c2dev->adapter_handle;
+	wr.cq_handle = cq->adapter_handle;
+
+	vq_req_get(c2dev, vq_req);
+
+	err = vq_send_wr(c2dev, (union c2wr *) & wr);
+	if (err) {
+		vq_req_put(c2dev, vq_req);
+		goto bail1;
+	}
+
+	err = vq_wait_for_reply(c2dev, vq_req);
+	if (err)
+		goto bail1;
+
+	reply = (struct c2wr_cq_destroy_rep *) (unsigned long) (vq_req->reply_msg);
+
+	vq_repbuf_free(c2dev, reply);
+      bail1:
+	vq_req_free(c2dev, vq_req);
+      bail0:
+	if (cq->is_kernel) {
+		c2_free_cq_buf(&cq->mq);
+	}
+
+	return;
+}
diff --git a/drivers/infiniband/hw/amso1100/c2_pd.c b/drivers/infiniband/hw/amso1100/c2_pd.c
new file mode 100644
index 0000000..27459b8
--- /dev/null
+++ b/drivers/infiniband/hw/amso1100/c2_pd.c
@@ -0,0 +1,71 @@
+/*
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
+ * Copyright (c) 2005 Mellanox Technologies. All rights reserved.
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
+
+#include <linux/init.h>
+#include <linux/errno.h>
+
+#include "c2.h"
+#include "c2_provider.h"
+
+int c2_pd_alloc(struct c2_dev *dev, int privileged, struct c2_pd *pd)
+{
+	int err = 0;
+
+	might_sleep();
+
+	atomic_set(&pd->sqp_count, 0);
+	pd->pd_id = c2_alloc(&dev->pd_table.alloc);
+	if (pd->pd_id == -1)
+		return -ENOMEM;
+
+	return err;
+}
+
+void c2_pd_free(struct c2_dev *dev, struct c2_pd *pd)
+{
+	might_sleep();
+	c2_free(&dev->pd_table.alloc, pd->pd_id);
+}
+
+int __devinit c2_init_pd_table(struct c2_dev *dev)
+{
+	return c2_alloc_init(&dev->pd_table.alloc, dev->props.max_pd, 0);
+}
+
+void __devexit c2_cleanup_pd_table(struct c2_dev *dev)
+{
+	/* XXX check if any PDs are still allocated? */
+	c2_alloc_cleanup(&dev->pd_table.alloc);
+}
diff --git a/drivers/infiniband/hw/amso1100/c2_provider.c b/drivers/infiniband/hw/amso1100/c2_provider.c
new file mode 100644
index 0000000..0d38c54
--- /dev/null
+++ b/drivers/infiniband/hw/amso1100/c2_provider.c
@@ -0,0 +1,871 @@
+/*
+ * Copyright (c) 2005 Ammasso, Inc. All rights reserved.
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
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/inetdevice.h>
+#include <linux/delay.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/if_vlan.h>
+#include <linux/crc32.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/tcp.h>
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/if_arp.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/byteorder.h>
+
+#include <rdma/ib_smi.h>
+#include <rdma/ib_user_verbs.h>
+#include "c2.h"
+#include "c2_provider.h"
+#include "c2_user.h"
+
+static int c2_query_device(struct ib_device *ibdev,
+			   struct ib_device_attr *props)
+{
+	struct c2_dev *c2dev = to_c2dev(ibdev);
+
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+
+	*props = c2dev->props;
+	return 0;
+}
+
+static int c2_query_port(struct ib_device *ibdev,
+			 u8 port, struct ib_port_attr *props)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+
+	props->max_mtu = IB_MTU_4096;
+	props->lid = 0;
+	props->lmc = 0;
+	props->sm_lid = 0;
+	props->sm_sl = 0;
+	props->state = IB_PORT_ACTIVE;
+	props->phys_state = 0;
+	props->port_cap_flags =
+	    IB_PORT_CM_SUP |
+	    IB_PORT_REINIT_SUP |
+	    IB_PORT_VENDOR_CLASS_SUP | IB_PORT_BOOT_MGMT_SUP;
+	props->gid_tbl_len = 1;
+	props->pkey_tbl_len = 1;
+	props->qkey_viol_cntr = 0;
+	props->active_width = 1;
+	props->active_speed = 1;
+
+	return 0;
+}
+
+static int c2_modify_port(struct ib_device *ibdev,
+			  u8 port, int port_modify_mask,
+			  struct ib_port_modify *props)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	return 0;
+}
+
+static int c2_query_pkey(struct ib_device *ibdev,
+			 u8 port, u16 index, u16 * pkey)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	*pkey = 0;
+	return 0;
+}
+
+static int c2_query_gid(struct ib_device *ibdev, u8 port,
+			int index, union ib_gid *gid)
+{
+	struct c2_dev *c2dev = to_c2dev(ibdev);
+
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	memset(&(gid->raw[0]), 0, sizeof(gid->raw));
+	memcpy(&(gid->raw[0]), c2dev->pseudo_netdev->dev_addr, 6);
+
+	return 0;
+}
+
+/* Allocate the user context data structure. This keeps track
+ * of all objects associated with a particular user-mode client.
+ */
+static struct ib_ucontext *c2_alloc_ucontext(struct ib_device *ibdev,
+					     struct ib_udata *udata)
+{
+	struct c2_ucontext *context;
+
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	context = kmalloc(sizeof *context, GFP_KERNEL);
+	if (!context)
+		return ERR_PTR(-ENOMEM);
+
+	return &context->ibucontext;
+}
+
+static int c2_dealloc_ucontext(struct ib_ucontext *context)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	kfree(context);
+	return 0;
+}
+
+static int c2_mmap_uar(struct ib_ucontext *context, struct vm_area_struct *vma)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	return -ENOSYS;
+}
+
+static struct ib_pd *c2_alloc_pd(struct ib_device *ibdev,
+				 struct ib_ucontext *context,
+				 struct ib_udata *udata)
+{
+	struct c2_pd *pd;
+	int err;
+
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+
+	pd = kmalloc(sizeof *pd, GFP_KERNEL);
+	if (!pd)
+		return ERR_PTR(-ENOMEM);
+
+	err = c2_pd_alloc(to_c2dev(ibdev), !context, pd);
+	if (err) {
+		kfree(pd);
+		return ERR_PTR(err);
+	}
+
+	if (context) {
+		if (ib_copy_to_udata(udata, &pd->pd_id, sizeof(__u32))) {
+			c2_pd_free(to_c2dev(ibdev), pd);
+			kfree(pd);
+			return ERR_PTR(-EFAULT);
+		}
+	}
+
+	return &pd->ibpd;
+}
+
+static int c2_dealloc_pd(struct ib_pd *pd)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	c2_pd_free(to_c2dev(pd->device), to_c2pd(pd));
+	kfree(pd);
+
+	return 0;
+}
+
+static struct ib_ah *c2_ah_create(struct ib_pd *pd, struct ib_ah_attr *ah_attr)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	return ERR_PTR(-ENOSYS);
+}
+
+static int c2_ah_destroy(struct ib_ah *ah)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	return -ENOSYS;
+}
+
+static void c2_add_ref(struct ib_qp *ibqp)
+{
+	struct c2_qp *qp;
+	BUG_ON(!ibqp);
+	qp = to_c2qp(ibqp);
+	atomic_inc(&qp->refcount);
+}
+
+static void c2_rem_ref(struct ib_qp *ibqp)
+{
+	struct c2_qp *qp;
+	BUG_ON(!ibqp);
+	qp = to_c2qp(ibqp);
+#if 0
+	dprintk("%s:%d qp=%p, qp->refcount=%d\n", __FUNCTION__, __LINE__, 
+		qp, atomic_read(&qp->refcount));
+#endif
+	if (atomic_dec_and_test(&qp->refcount))
+		wake_up(&qp->wait);
+}
+
+struct ib_qp *c2_get_qp(struct ib_device *device, int qpn)
+{
+	struct c2_dev* c2dev = to_c2dev(device);
+	struct c2_qp *qp;
+
+	qp = c2dev->qp_table.map[qpn];
+	dprintk("%s Returning QP=%p for QPN=%d, device=%p, refcount=%d\n",
+		__FUNCTION__, qp, qpn, device,
+		(qp?atomic_read(&qp->refcount):0));
+
+	return (qp?&qp->ibqp:NULL);
+}
+
+static struct ib_qp *c2_create_qp(struct ib_pd *pd,
+				  struct ib_qp_init_attr *init_attr,
+				  struct ib_udata *udata)
+{
+	struct c2_qp *qp;
+	int err;
+
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+
+	switch (init_attr->qp_type) {
+	case IB_QPT_RC:
+		qp = kzalloc(sizeof(*qp), GFP_KERNEL);
+		if (!qp) {
+			dprintk("%s: Unable to allocate QP\n", __FUNCTION__);
+			return ERR_PTR(-ENOMEM);
+		}
+		spin_lock_init(&qp->lock);
+		if (pd->uobject) {
+			/* XXX userspace specific */
+		}
+
+		err = c2_alloc_qp(to_c2dev(pd->device),
+				  to_c2pd(pd), init_attr, qp);
+		
+		if (err && pd->uobject) {
+			/* XXX userspace specific */
+		}
+
+		break;
+	default:
+		dprintk("%s: Invalid QP type: %d\n", __FUNCTION__,
+			init_attr->qp_type);
+		return ERR_PTR(-EINVAL);
+		break;
+	}
+
+	if (err) {
+		kfree(qp);
+		return ERR_PTR(err);
+	}
+
+	return &qp->ibqp;
+}
+
+static int c2_destroy_qp(struct ib_qp *ib_qp)
+{
+	struct c2_qp *qp = to_c2qp(ib_qp);
+
+	dprintk("%s:%u qp=%p,qp->state=%d\n", 
+		__FUNCTION__, __LINE__,ib_qp,qp->state);
+	c2_free_qp(to_c2dev(ib_qp->device), qp);
+	kfree(qp);
+	return 0;
+}
+
+static struct ib_cq *c2_create_cq(struct ib_device *ibdev, int entries,
+				  struct ib_ucontext *context,
+				  struct ib_udata *udata)
+{
+	struct c2_cq *cq;
+	int err;
+
+	cq = kmalloc(sizeof(*cq), GFP_KERNEL);
+	if (!cq) {
+		dprintk("%s: Unable to allocate CQ\n", __FUNCTION__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	err = c2_init_cq(to_c2dev(ibdev), entries, NULL, cq);
+	if (err) {
+		dprintk("%s: error initializing CQ\n", __FUNCTION__);
+		kfree(cq);
+		return ERR_PTR(err);
+	}
+
+	return &cq->ibcq;
+}
+
+static int c2_destroy_cq(struct ib_cq *ib_cq)
+{
+	struct c2_cq *cq = to_c2cq(ib_cq);
+
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+
+	c2_free_cq(to_c2dev(ib_cq->device), cq);
+	kfree(cq);
+
+	return 0;
+}
+
+static inline u32 c2_convert_access(int acc)
+{
+	return (acc & IB_ACCESS_REMOTE_WRITE ? C2_ACF_REMOTE_WRITE : 0) |
+	    (acc & IB_ACCESS_REMOTE_READ ? C2_ACF_REMOTE_READ : 0) |
+	    (acc & IB_ACCESS_LOCAL_WRITE ? C2_ACF_LOCAL_WRITE : 0) |
+	    C2_ACF_LOCAL_READ | C2_ACF_WINDOW_BIND;
+}
+
+static struct ib_mr *c2_reg_phys_mr(struct ib_pd *ib_pd,
+				    struct ib_phys_buf *buffer_list,
+				    int num_phys_buf, int acc, u64 * iova_start)
+{
+	struct c2_mr *mr;
+	u64 *page_list;
+	u32 total_len;
+	int err, i, j, k, page_shift, pbl_depth;
+
+	pbl_depth = 0;
+	total_len = 0;
+
+	page_shift = PAGE_SHIFT;
+	/*
+	 * If there is only 1 buffer we assume this could
+	 * be a map of all phy mem...use a 32k page_shift.
+	 */
+	if (num_phys_buf == 1)
+		page_shift += 3;	/* XXX */
+
+	for (i = 0; i < num_phys_buf; i++) {
+
+		if (buffer_list[i].addr & ~PAGE_MASK) {
+			dprintk("Unaligned Memory Buffer: 0x%x\n",
+				(unsigned int) buffer_list[i].addr);
+			return ERR_PTR(-EINVAL);
+		}
+
+		if (!buffer_list[i].size) {
+			dprintk("Invalid Buffer Size\n");
+			return ERR_PTR(-EINVAL);
+		}
+
+		total_len += buffer_list[i].size;
+		pbl_depth += ALIGN(buffer_list[i].size, 
+				   (1 << page_shift)) >> page_shift;
+	}
+
+	page_list = vmalloc(sizeof(u64) * pbl_depth);
+	if (!page_list) {
+		dprintk("couldn't vmalloc page_list of size %zd\n",
+			(sizeof(u64) * pbl_depth));
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (i = 0, j = 0; i < num_phys_buf; i++) {
+
+		int naddrs;
+
+ 		naddrs = ALIGN(buffer_list[i].size, 
+			       (1 << page_shift)) >> page_shift;
+		for (k = 0; k < naddrs; k++)
+			page_list[j++] = (buffer_list[i].addr + 
+						     (k << page_shift));
+	}
+
+	mr = kmalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	mr->pd = to_c2pd(ib_pd);
+	dprintk("%s - page shift %d, pbl_depth %d, total_len %u, "
+		"*iova_start %llx, first pa %llx, last pa %llx\n",
+		__FUNCTION__, page_shift, pbl_depth, total_len, 
+		*iova_start, page_list[0], page_list[pbl_depth-1]);
+  	err = c2_nsmr_register_phys_kern(to_c2dev(ib_pd->device), page_list,
+ 					 (1 << page_shift), pbl_depth, 
+					 total_len, 0, iova_start, 
+					 c2_convert_access(acc), mr);
+	vfree(page_list);
+	if (err) {
+		kfree(mr);
+		return ERR_PTR(err);
+	}
+
+	return &mr->ibmr;
+}
+
+static struct ib_mr *c2_get_dma_mr(struct ib_pd *pd, int acc)
+{
+	struct ib_phys_buf bl;
+	u64 kva = 0;
+
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+
+	/* AMSO1100 limit */
+	bl.size = 0xffffffff;
+	bl.addr = 0;
+	return c2_reg_phys_mr(pd, &bl, 1, acc, &kva);
+}
+
+static struct ib_mr *c2_reg_user_mr(struct ib_pd *pd, struct ib_umem *region,
+				    int acc, struct ib_udata *udata)
+{
+	u64 *pages;
+	u64 kva = 0;
+	int shift, n, len;
+	int i, j, k;
+	int err = 0;
+	struct ib_umem_chunk *chunk;
+	struct c2_pd *c2pd = to_c2pd(pd);
+	struct c2_mr *c2mr;
+
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	shift = ffs(region->page_size) - 1;
+
+	c2mr = kmalloc(sizeof(*c2mr), GFP_KERNEL);
+	if (!c2mr)
+		return ERR_PTR(-ENOMEM);
+	c2mr->pd = c2pd;
+
+	n = 0;
+	list_for_each_entry(chunk, &region->chunk_list, list)
+		n += chunk->nents;
+
+	pages = kmalloc(n * sizeof(u64), GFP_KERNEL);
+	if (!pages) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	i = 0;
+	list_for_each_entry(chunk, &region->chunk_list, list) {
+		for (j = 0; j < chunk->nmap; ++j) {
+			len = sg_dma_len(&chunk->page_list[j]) >> shift;
+			for (k = 0; k < len; ++k) {
+				pages[i++] = 
+					sg_dma_address(&chunk->page_list[j]) +
+					(region->page_size * k);
+			}
+		}
+	}
+
+	kva = (u64)region->virt_base;
+  	err = c2_nsmr_register_phys_kern(to_c2dev(pd->device), 
+					 pages,
+ 					 region->page_size,
+					 i, 
+					 region->length, 
+					 region->offset,
+					 &kva,
+					 c2_convert_access(acc), 
+					 c2mr);
+	kfree(pages);
+	if (err) {
+		kfree(c2mr);
+		return ERR_PTR(err);
+	}
+	return &c2mr->ibmr;
+
+err:
+	kfree(c2mr);
+	return ERR_PTR(err);
+}
+
+static int c2_dereg_mr(struct ib_mr *ib_mr)
+{
+	struct c2_mr *mr = to_c2mr(ib_mr);
+	int err;
+
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+
+	err = c2_stag_dealloc(to_c2dev(ib_mr->device), ib_mr->lkey);
+	if (err)
+		dprintk("c2_stag_dealloc failed: %d\n", err);
+	else
+		kfree(mr);
+
+	return err;
+}
+
+static ssize_t show_rev(struct class_device *cdev, char *buf)
+{
+	struct c2_dev *dev = container_of(cdev, struct c2_dev, ibdev.class_dev);
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	return sprintf(buf, "%x\n", dev->props.hw_ver);
+}
+
+static ssize_t show_fw_ver(struct class_device *cdev, char *buf)
+{
+	struct c2_dev *dev = container_of(cdev, struct c2_dev, ibdev.class_dev);
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	return sprintf(buf, "%x.%x.%x\n",
+		       (int) (dev->props.fw_ver >> 32),
+		       (int) (dev->props.fw_ver >> 16) & 0xffff,
+		       (int) (dev->props.fw_ver & 0xffff));
+}
+
+static ssize_t show_hca(struct class_device *cdev, char *buf)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	return sprintf(buf, "AMSO1100\n");
+}
+
+static ssize_t show_board(struct class_device *cdev, char *buf)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	return sprintf(buf, "%.*s\n", 32, "AMSO1100 Board ID");
+}
+
+static CLASS_DEVICE_ATTR(hw_rev, S_IRUGO, show_rev, NULL);
+static CLASS_DEVICE_ATTR(fw_ver, S_IRUGO, show_fw_ver, NULL);
+static CLASS_DEVICE_ATTR(hca_type, S_IRUGO, show_hca, NULL);
+static CLASS_DEVICE_ATTR(board_id, S_IRUGO, show_board, NULL);
+
+static struct class_device_attribute *c2_class_attributes[] = {
+	&class_device_attr_hw_rev,
+	&class_device_attr_fw_ver,
+	&class_device_attr_hca_type,
+	&class_device_attr_board_id
+};
+
+static int c2_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
+			int attr_mask)
+{
+	int err;
+
+	err =
+	    c2_qp_modify(to_c2dev(ibqp->device), to_c2qp(ibqp), attr,
+			 attr_mask);
+
+	return err;
+}
+
+static int c2_multicast_attach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	return -ENOSYS;
+}
+
+static int c2_multicast_detach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	return -ENOSYS;
+}
+
+static int c2_process_mad(struct ib_device *ibdev,
+			  int mad_flags,
+			  u8 port_num,
+			  struct ib_wc *in_wc,
+			  struct ib_grh *in_grh,
+			  struct ib_mad *in_mad, struct ib_mad *out_mad)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	return -ENOSYS;
+}
+
+static int c2_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *iw_param)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+
+	/* Request a connection */
+	return c2_llp_connect(cm_id, iw_param);
+}
+
+static int c2_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *iw_param)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+
+	/* Accept the new connection */
+	return c2_llp_accept(cm_id, iw_param);
+}
+
+static int c2_reject(struct iw_cm_id *cm_id, const void *pdata, u8 pdata_len)
+{
+	int err;
+
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+
+	err = c2_llp_reject(cm_id, pdata, pdata_len);
+	return err;
+}
+
+static int c2_service_create(struct iw_cm_id *cm_id, int backlog)
+{
+	int err;
+
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	err = c2_llp_service_create(cm_id, backlog);
+	dprintk("%s:%u err=%d\n", 
+		__FUNCTION__, __LINE__,
+		err);
+	return err;
+}
+
+static int c2_service_destroy(struct iw_cm_id *cm_id)
+{
+	int err;
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+
+	err = c2_llp_service_destroy(cm_id);
+
+	return err;
+}
+
+static int c2_pseudo_up(struct net_device *netdev)
+{
+	struct in_device *ind;
+	struct c2_dev *c2dev = netdev->priv;
+
+	ind = in_dev_get(netdev);
+	if (!ind)
+		return 0;
+
+	dprintk("adding...\n");
+	for_ifa(ind) {
+#ifdef C2_DEBUG
+		u8 *ip = (u8 *) & ifa->ifa_address;
+
+		dprintk("%s: %d.%d.%d.%d\n",
+		       ifa->ifa_label, ip[0], ip[1], ip[2], ip[3]);
+#endif
+		c2_add_addr(c2dev, ifa->ifa_address, ifa->ifa_mask);
+	}
+	endfor_ifa(ind);
+	in_dev_put(ind);
+
+	return 0;
+}
+
+static int c2_pseudo_down(struct net_device *netdev)
+{
+	struct in_device *ind;
+	struct c2_dev *c2dev = netdev->priv;
+
+	ind = in_dev_get(netdev);
+	if (!ind)
+		return 0;
+
+	dprintk("deleting...\n");
+	for_ifa(ind) {
+#ifdef C2_DEBUG
+		u8 *ip = (u8 *) & ifa->ifa_address;
+
+		dprintk("%s: %d.%d.%d.%d\n",
+		       ifa->ifa_label, ip[0], ip[1], ip[2], ip[3]);
+#endif
+		c2_del_addr(c2dev, ifa->ifa_address, ifa->ifa_mask);
+	}
+	endfor_ifa(ind);
+	in_dev_put(ind);
+
+	return 0;
+}
+
+static int c2_pseudo_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
+{
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+static int c2_pseudo_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	int ret = 0;
+
+	if (new_mtu < ETH_ZLEN || new_mtu > ETH_JUMBO_MTU)
+		return -EINVAL;
+
+	netdev->mtu = new_mtu;
+
+	/* XXX tell rnic about new rmda interface mtu */
+	return ret;
+}
+
+static void setup(struct net_device *netdev)
+{
+	SET_MODULE_OWNER(netdev);
+	netdev->open = c2_pseudo_up;
+	netdev->stop = c2_pseudo_down;
+	netdev->hard_start_xmit = c2_pseudo_xmit_frame;
+	netdev->get_stats = NULL;
+	netdev->tx_timeout = NULL;
+	netdev->set_mac_address = NULL;
+	netdev->change_mtu = c2_pseudo_change_mtu;
+	netdev->watchdog_timeo = 0;
+	netdev->type = ARPHRD_ETHER;
+	netdev->mtu = 1500;
+	netdev->hard_header_len = ETH_HLEN;
+	netdev->addr_len = ETH_ALEN;
+	netdev->tx_queue_len = 0;
+	netdev->flags |= IFF_NOARP;
+	return;
+}
+
+static struct net_device *c2_pseudo_netdev_init(struct c2_dev *c2dev)
+{
+	char name[IFNAMSIZ];
+	struct net_device *netdev;
+
+	/* change ethxxx to iwxxx */
+	strcpy(name, "iw");
+	strcat(name, &c2dev->netdev->name[3]);
+	netdev = alloc_netdev(sizeof(*netdev), name, setup);
+	if (!netdev) {
+		printk(KERN_ERR PFX "%s -  etherdev alloc failed",
+			__FUNCTION__);
+		return NULL;
+	}
+
+	netdev->priv = c2dev;
+
+	SET_NETDEV_DEV(netdev, &c2dev->pcidev->dev);
+
+	memcpy_fromio(netdev->dev_addr, c2dev->kva + C2_REGS_RDMA_ENADDR, 6);
+
+	/* Print out the MAC address */
+	dprintk("%s: MAC %02X:%02X:%02X:%02X:%02X:%02X\n",
+		netdev->name,
+		netdev->dev_addr[0], netdev->dev_addr[1], netdev->dev_addr[2],
+		netdev->dev_addr[3], netdev->dev_addr[4], netdev->dev_addr[5]);
+
+	/* Disable network packets */
+	netif_stop_queue(netdev);
+	return netdev;
+}
+
+int c2_register_device(struct c2_dev *dev)
+{
+	int ret;
+	int i;
+
+	/* Register pseudo network device */
+	dev->pseudo_netdev = c2_pseudo_netdev_init(dev);
+	if (dev->pseudo_netdev) {
+		ret = register_netdev(dev->pseudo_netdev);
+		if (ret) {
+			printk(KERN_ERR PFX
+				"Unable to register netdev, ret = %d\n", ret);
+			free_netdev(dev->pseudo_netdev);
+			return ret;
+		}
+	}
+
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	strlcpy(dev->ibdev.name, "amso%d", IB_DEVICE_NAME_MAX);
+	dev->ibdev.owner = THIS_MODULE;
+	dev->ibdev.uverbs_cmd_mask =
+	    (1ull << IB_USER_VERBS_CMD_GET_CONTEXT) |
+	    (1ull << IB_USER_VERBS_CMD_QUERY_DEVICE) |
+	    (1ull << IB_USER_VERBS_CMD_QUERY_PORT) |
+	    (1ull << IB_USER_VERBS_CMD_ALLOC_PD) |
+	    (1ull << IB_USER_VERBS_CMD_DEALLOC_PD) |
+	    (1ull << IB_USER_VERBS_CMD_REG_MR) |
+	    (1ull << IB_USER_VERBS_CMD_DEREG_MR) |
+	    (1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
+	    (1ull << IB_USER_VERBS_CMD_CREATE_CQ) |
+	    (1ull << IB_USER_VERBS_CMD_DESTROY_CQ) |
+	    (1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ) |
+	    (1ull << IB_USER_VERBS_CMD_CREATE_QP) |
+	    (1ull << IB_USER_VERBS_CMD_MODIFY_QP) |
+	    (1ull << IB_USER_VERBS_CMD_POLL_CQ) |
+	    (1ull << IB_USER_VERBS_CMD_DESTROY_QP) |
+	    (1ull << IB_USER_VERBS_CMD_POST_SEND) |
+	    (1ull << IB_USER_VERBS_CMD_POST_RECV);
+
+	dev->ibdev.node_type = RDMA_NODE_RNIC;
+	memset(&dev->ibdev.node_guid, 0, sizeof(dev->ibdev.node_guid));
+	memcpy(&dev->ibdev.node_guid, dev->pseudo_netdev->dev_addr, 6);
+	dev->ibdev.phys_port_cnt = 1;
+	dev->ibdev.dma_device = &dev->pcidev->dev;
+	dev->ibdev.class_dev.dev = &dev->pcidev->dev;
+	dev->ibdev.query_device = c2_query_device;
+	dev->ibdev.query_port = c2_query_port;
+	dev->ibdev.modify_port = c2_modify_port;
+	dev->ibdev.query_pkey = c2_query_pkey;
+	dev->ibdev.query_gid = c2_query_gid;
+	dev->ibdev.alloc_ucontext = c2_alloc_ucontext;
+	dev->ibdev.dealloc_ucontext = c2_dealloc_ucontext;
+	dev->ibdev.mmap = c2_mmap_uar;
+	dev->ibdev.alloc_pd = c2_alloc_pd;
+	dev->ibdev.dealloc_pd = c2_dealloc_pd;
+	dev->ibdev.create_ah = c2_ah_create;
+	dev->ibdev.destroy_ah = c2_ah_destroy;
+	dev->ibdev.create_qp = c2_create_qp;
+	dev->ibdev.modify_qp = c2_modify_qp;
+	dev->ibdev.destroy_qp = c2_destroy_qp;
+	dev->ibdev.create_cq = c2_create_cq;
+	dev->ibdev.destroy_cq = c2_destroy_cq;
+	dev->ibdev.poll_cq = c2_poll_cq;
+	dev->ibdev.get_dma_mr = c2_get_dma_mr;
+	dev->ibdev.reg_phys_mr = c2_reg_phys_mr;
+	dev->ibdev.reg_user_mr = c2_reg_user_mr;
+	dev->ibdev.dereg_mr = c2_dereg_mr;
+
+	dev->ibdev.alloc_fmr = NULL;
+	dev->ibdev.unmap_fmr = NULL;
+	dev->ibdev.dealloc_fmr = NULL;
+	dev->ibdev.map_phys_fmr = NULL;
+
+	dev->ibdev.attach_mcast = c2_multicast_attach;
+	dev->ibdev.detach_mcast = c2_multicast_detach;
+	dev->ibdev.process_mad = c2_process_mad;
+
+	dev->ibdev.req_notify_cq = c2_arm_cq;
+	dev->ibdev.post_send = c2_post_send;
+	dev->ibdev.post_recv = c2_post_receive;
+
+	dev->ibdev.iwcm = kmalloc(sizeof(*dev->ibdev.iwcm), GFP_KERNEL);
+	dev->ibdev.iwcm->add_ref = c2_add_ref;
+	dev->ibdev.iwcm->rem_ref = c2_rem_ref;
+	dev->ibdev.iwcm->get_qp = c2_get_qp;
+	dev->ibdev.iwcm->connect = c2_connect;
+	dev->ibdev.iwcm->accept = c2_accept;
+	dev->ibdev.iwcm->reject = c2_reject;
+	dev->ibdev.iwcm->create_listen = c2_service_create;
+	dev->ibdev.iwcm->destroy_listen = c2_service_destroy;
+
+	ret = ib_register_device(&dev->ibdev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(c2_class_attributes); ++i) {
+		ret = class_device_create_file(&dev->ibdev.class_dev,
+					       c2_class_attributes[i]);
+		if (ret) {
+			unregister_netdev(dev->pseudo_netdev);
+			free_netdev(dev->pseudo_netdev);
+			ib_unregister_device(&dev->ibdev);
+			return ret;
+		}
+	}
+
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	return 0;
+}
+
+void c2_unregister_device(struct c2_dev *dev)
+{
+	dprintk("%s:%u\n", __FUNCTION__, __LINE__);
+	unregister_netdev(dev->pseudo_netdev);
+	free_netdev(dev->pseudo_netdev);
+	ib_unregister_device(&dev->ibdev);
+}
diff --git a/drivers/infiniband/hw/amso1100/c2_provider.h b/drivers/infiniband/hw/amso1100/c2_provider.h
new file mode 100644
index 0000000..05c4ab6
--- /dev/null
+++ b/drivers/infiniband/hw/amso1100/c2_provider.h
@@ -0,0 +1,182 @@
+/*
+ * Copyright (c) 2005 Ammasso, Inc. All rights reserved.
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
+ *
+ */
+
+#ifndef C2_PROVIDER_H
+#define C2_PROVIDER_H
+#include <linux/inetdevice.h>
+
+#include <rdma/ib_verbs.h>
+#include <rdma/ib_pack.h>
+
+#include "c2_mq.h"
+#include <rdma/iw_cm.h>
+
+#define C2_MPT_FLAG_ATOMIC        (1 << 14)
+#define C2_MPT_FLAG_REMOTE_WRITE  (1 << 13)
+#define C2_MPT_FLAG_REMOTE_READ   (1 << 12)
+#define C2_MPT_FLAG_LOCAL_WRITE   (1 << 11)
+#define C2_MPT_FLAG_LOCAL_READ    (1 << 10)
+
+struct c2_buf_list {
+	void *buf;
+	 DECLARE_PCI_UNMAP_ADDR(mapping)
+};
+
+
+/* The user context keeps track of objects allocated for a
+ * particular user-mode client. */
+struct c2_ucontext {
+	struct ib_ucontext ibucontext;
+};
+
+struct c2_mtt;
+
+/* All objects associated with a PD are kept in the 
+ * associated user context if present. 
+ */
+struct c2_pd {
+	struct ib_pd ibpd;
+	u32 pd_id;
+	atomic_t sqp_count;
+};
+
+struct c2_mr {
+	struct ib_mr ibmr;
+	struct c2_pd *pd;
+};
+
+struct c2_av;
+
+enum c2_ah_type {
+	C2_AH_ON_HCA,
+	C2_AH_PCI_POOL,
+	C2_AH_KMALLOC
+};
+
+struct c2_ah {
+	struct ib_ah ibah;
+};
+
+struct c2_cq {
+	struct ib_cq ibcq;
+	spinlock_t lock;
+	atomic_t refcount;
+	int cqn;
+	int is_kernel;
+	wait_queue_head_t wait;
+
+	u32 adapter_handle;
+	struct c2_mq mq;
+};
+
+struct c2_wq {
+	spinlock_t lock;
+};
+struct iw_cm_id;
+struct c2_qp {
+	struct ib_qp ibqp;
+	struct iw_cm_id *cm_id;
+	spinlock_t lock;
+	atomic_t refcount;
+	wait_queue_head_t wait;
+	int qpn;
+
+	u32 adapter_handle;
+	u32 send_sgl_depth;
+	u32 recv_sgl_depth;
+	u32 rdma_write_sgl_depth;
+	u8 state;
+
+	struct c2_mq sq_mq;
+	struct c2_mq rq_mq;
+};
+
+struct c2_cr_query_attrs {
+	u32 local_addr;
+	u32 remote_addr;
+	u16 local_port;
+	u16 remote_port;
+};
+
+static inline struct c2_pd *to_c2pd(struct ib_pd *ibpd)
+{
+	return container_of(ibpd, struct c2_pd, ibpd);
+}
+
+static inline struct c2_ucontext *to_c2ucontext(struct ib_ucontext *ibucontext)
+{
+	return container_of(ibucontext, struct c2_ucontext, ibucontext);
+}
+
+static inline struct c2_mr *to_c2mr(struct ib_mr *ibmr)
+{
+	return container_of(ibmr, struct c2_mr, ibmr);
+}
+
+
+static inline struct c2_ah *to_c2ah(struct ib_ah *ibah)
+{
+	return container_of(ibah, struct c2_ah, ibah);
+}
+
+static inline struct c2_cq *to_c2cq(struct ib_cq *ibcq)
+{
+	return container_of(ibcq, struct c2_cq, ibcq);
+}
+
+static inline struct c2_qp *to_c2qp(struct ib_qp *ibqp)
+{
+	return container_of(ibqp, struct c2_qp, ibqp);
+}
+
+static inline int is_rnic_addr(struct net_device *netdev, u32 addr)
+{
+	struct in_device *ind;
+	int ret = 0;
+
+	ind = in_dev_get(netdev);
+	if (!ind)
+		return 0;
+
+	for_ifa(ind) {
+		if (ifa->ifa_address == addr) {
+			ret = 1;
+			break;
+		}
+	}
+	endfor_ifa(ind);
+	in_dev_put(ind);
+	return ret;
+}
+#endif				/* C2_PROVIDER_H */
diff --git a/drivers/infiniband/hw/amso1100/c2_qp.c b/drivers/infiniband/hw/amso1100/c2_qp.c
new file mode 100644
index 0000000..e0e3c83
--- /dev/null
+++ b/drivers/infiniband/hw/amso1100/c2_qp.c
@@ -0,0 +1,975 @@
+/*
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Cisco Systems. All rights reserved.
+ * Copyright (c) 2005 Mellanox Technologies. All rights reserved.
+ * Copyright (c) 2004 Voltaire, Inc. All rights reserved. 
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
+ *
+ */
+
+#include "c2.h"
+#include "c2_vq.h"
+#include "c2_status.h"
+
+#define C2_MAX_ORD_PER_QP 128
+#define C2_MAX_IRD_PER_QP 128
+
+#define C2_HINT_MAKE(q_index, hint_count) (((q_index) << 16) | hint_count)
+#define C2_HINT_GET_INDEX(hint) (((hint) & 0x7FFF0000) >> 16)
+#define C2_HINT_GET_COUNT(hint) ((hint) & 0x0000FFFF)
+
+#define NO_SUPPORT -1
+static const u8 c2_opcode[] = {
+	[IB_WR_SEND] = C2_WR_TYPE_SEND,
+	[IB_WR_SEND_WITH_IMM] = NO_SUPPORT,
+	[IB_WR_RDMA_WRITE] = C2_WR_TYPE_RDMA_WRITE,
+	[IB_WR_RDMA_WRITE_WITH_IMM] = NO_SUPPORT,
+	[IB_WR_RDMA_READ] = C2_WR_TYPE_RDMA_READ,
+	[IB_WR_ATOMIC_CMP_AND_SWP] = NO_SUPPORT,
+	[IB_WR_ATOMIC_FETCH_AND_ADD] = NO_SUPPORT,
+};
+
+static int to_c2_state(enum ib_qp_state ib_state)
+{
+	switch (ib_state) {
+	case IB_QPS_RESET:
+		return C2_QP_STATE_IDLE;
+	case IB_QPS_RTS:
+		return C2_QP_STATE_RTS;
+	case IB_QPS_SQD:
+		return C2_QP_STATE_CLOSING;
+	case IB_QPS_SQE:
+		return C2_QP_STATE_CLOSING;
+	case IB_QPS_ERR:
+		return C2_QP_STATE_ERROR;
+	default:
+		return -1;
+	}
+}
+
+int to_ib_state(enum c2_qp_state c2_state)
+{
+	switch (c2_state) {
+	case C2_QP_STATE_IDLE:
+		return IB_QPS_RESET;
+	case C2_QP_STATE_CONNECTING:
+		return IB_QPS_RTR;
+	case C2_QP_STATE_RTS:
+		return IB_QPS_RTS;
+	case C2_QP_STATE_CLOSING:
+		return IB_QPS_SQD;
+	case C2_QP_STATE_ERROR:
+		return IB_QPS_ERR;
+	case C2_QP_STATE_TERMINATE:
+		return IB_QPS_SQE;
+	default:
+		return -1;
+	}
+}
+
+const char *to_ib_state_str(int ib_state)
+{
+	static const char *state_str[] = {
+		"IB_QPS_RESET",
+		"IB_QPS_INIT",
+		"IB_QPS_RTR",
+		"IB_QPS_RTS",
+		"IB_QPS_SQD",
+		"IB_QPS_SQE",
+		"IB_QPS_ERR"
+	};
+	if (ib_state < IB_QPS_RESET ||
+	    ib_state > IB_QPS_ERR)
+		return "<invalid IB QP state>";
+
+	ib_state -= IB_QPS_RESET;
+	return state_str[ib_state];
+}
+
+void c2_set_qp_state(struct c2_qp *qp, int c2_state)
+{
+	int new_state = to_ib_state(c2_state);
+
+	dprintk("%s: qp[%p] state modify %s --> %s\n", 
+	       __FUNCTION__,
+		qp, 
+		to_ib_state_str(qp->state), 
+		to_ib_state_str(new_state));
+	qp->state = new_state;
+}
+
+#define C2_QP_NO_ATTR_CHANGE 0xFFFFFFFF
+
+int c2_qp_modify(struct c2_dev *c2dev, struct c2_qp *qp,
+		 struct ib_qp_attr *attr, int attr_mask)
+{
+	struct c2wr_qp_modify_req wr;
+	struct c2wr_qp_modify_rep *reply;
+	struct c2_vq_req *vq_req;
+	unsigned long flags;
+	u8 next_state;
+	int err;
+
+	dprintk("%s:%d qp=%p, %s --> %s\n", 
+		__FUNCTION__, __LINE__,
+		qp, 
+		to_ib_state_str(qp->state), 
+		to_ib_state_str(attr->qp_state));
+
+	vq_req = vq_req_alloc(c2dev);
+	if (!vq_req)
+		return -ENOMEM;
+
+	c2_wr_set_id(&wr, CCWR_QP_MODIFY);
+	wr.hdr.context = (unsigned long) vq_req;
+	wr.rnic_handle = c2dev->adapter_handle;
+	wr.qp_handle = qp->adapter_handle;
+	wr.ord = cpu_to_be32(C2_QP_NO_ATTR_CHANGE);
+	wr.ird = cpu_to_be32(C2_QP_NO_ATTR_CHANGE);
+	wr.sq_depth = cpu_to_be32(C2_QP_NO_ATTR_CHANGE);
+	wr.rq_depth = cpu_to_be32(C2_QP_NO_ATTR_CHANGE);
+
+	if (attr_mask & IB_QP_STATE) {
+		/* Ensure the state is valid */
+		if (attr->qp_state < 0 || attr->qp_state > IB_QPS_ERR)
+			return -EINVAL;
+
+		wr.next_qp_state = cpu_to_be32(to_c2_state(attr->qp_state));
+
+		if (attr->qp_state == IB_QPS_ERR) {
+			spin_lock_irqsave(&qp->lock, flags);
+			if (qp->cm_id && qp->state == IB_QPS_RTS) {
+				dprintk("Generating CLOSE event for QP-->ERR, "
+					"qp=%p, cm_id=%p\n",qp,qp->cm_id);
+				/* Generate an CLOSE event */
+				vq_req->cm_id = qp->cm_id;
+				vq_req->event = IW_CM_EVENT_CLOSE;
+			}
+			spin_unlock_irqrestore(&qp->lock, flags);
+		}
+		next_state =  attr->qp_state;
+
+	} else if (attr_mask & IB_QP_CUR_STATE) {
+
+		if (attr->cur_qp_state != IB_QPS_RTR &&
+		    attr->cur_qp_state != IB_QPS_RTS &&
+		    attr->cur_qp_state != IB_QPS_SQD &&
+		    attr->cur_qp_state != IB_QPS_SQE)
+			return -EINVAL;
+		else
+			wr.next_qp_state =
+			    cpu_to_be32(to_c2_state(attr->cur_qp_state));
+
+		next_state = attr->cur_qp_state;
+
+	} else {
+		err = 0;
+		goto bail0;
+	}
+
+	/* reference the request struct */
+	vq_req_get(c2dev, vq_req);
+
+	err = vq_send_wr(c2dev, (union c2wr *) & wr);
+	if (err) {
+		vq_req_put(c2dev, vq_req);
+		goto bail0;
+	}
+
+	err = vq_wait_for_reply(c2dev, vq_req);
+	if (err)
+		goto bail0;
+
+	reply = (struct c2wr_qp_modify_rep *) (unsigned long) vq_req->reply_msg;
+	if (!reply) {
+		err = -ENOMEM;
+		goto bail0;
+	}
+
+	err = c2_errno(reply);
+	if (!err) 
+		qp->state = next_state;
+#ifdef C2_DEBUG
+	else
+		dprintk("%s: c2_errno=%d\n", __FUNCTION__, err);
+#endif
+	/*
+	 * If we're going to error and generating the event here, then 
+	 * we need to remove the reference because there will be no
+	 * close event generated by the adapter 
+	*/
+	spin_lock_irqsave(&qp->lock, flags);
+	if (vq_req->event==IW_CM_EVENT_CLOSE && qp->cm_id) {
+		qp->cm_id->rem_ref(qp->cm_id);
+		qp->cm_id = NULL;
+	}
+	spin_unlock_irqrestore(&qp->lock, flags);
+
+	vq_repbuf_free(c2dev, reply);
+      bail0:
+	vq_req_free(c2dev, vq_req);
+
+	dprintk("%s:%d qp=%p, cur_state=%s\n", 
+		__FUNCTION__, __LINE__,
+		qp, 
+		to_ib_state_str(qp->state));
+	return err;
+}
+
+int c2_qp_set_read_limits(struct c2_dev *c2dev, struct c2_qp *qp, 
+			  int ord, int ird)
+{
+	struct c2wr_qp_modify_req wr;
+	struct c2wr_qp_modify_rep *reply;
+	struct c2_vq_req *vq_req;
+	int err;
+
+	vq_req = vq_req_alloc(c2dev);
+	if (!vq_req)
+		return -ENOMEM;
+
+	c2_wr_set_id(&wr, CCWR_QP_MODIFY);
+	wr.hdr.context = (unsigned long) vq_req;
+	wr.rnic_handle = c2dev->adapter_handle;
+	wr.qp_handle = qp->adapter_handle;
+	wr.ord = cpu_to_be32(ord);
+	wr.ird = cpu_to_be32(ird);
+	wr.sq_depth = cpu_to_be32(C2_QP_NO_ATTR_CHANGE);
+	wr.rq_depth = cpu_to_be32(C2_QP_NO_ATTR_CHANGE);
+	wr.next_qp_state = cpu_to_be32(C2_QP_NO_ATTR_CHANGE);
+
+	/* reference the request struct */
+	vq_req_get(c2dev, vq_req);
+
+	err = vq_send_wr(c2dev, (union c2wr *) & wr);
+	if (err) {
+		vq_req_put(c2dev, vq_req);
+		goto bail0;
+	}
+
+	err = vq_wait_for_reply(c2dev, vq_req);
+	if (err)
+		goto bail0;
+
+	reply = (struct c2wr_qp_modify_rep *) (unsigned long) 
+		vq_req->reply_msg;
+	if (!reply) {
+		err = -ENOMEM;
+		goto bail0;
+	}
+
+	err = c2_errno(reply);
+	vq_repbuf_free(c2dev, reply);
+      bail0:
+	vq_req_free(c2dev, vq_req);
+	return err;
+}
+
+static int destroy_qp(struct c2_dev *c2dev, struct c2_qp *qp)
+{
+	struct c2_vq_req *vq_req;
+	struct c2wr_qp_destroy_req wr;
+	struct c2wr_qp_destroy_rep *reply;
+	unsigned long flags;
+	int err;
+
+	/*
+	 * Allocate a verb request message
+	 */
+	vq_req = vq_req_alloc(c2dev);
+	if (!vq_req) {
+		return -ENOMEM;
+	}
+
+	/* 
+	 * Initialize the WR 
+	 */
+	c2_wr_set_id(&wr, CCWR_QP_DESTROY);
+	wr.hdr.context = (unsigned long) vq_req;
+	wr.rnic_handle = c2dev->adapter_handle;
+	wr.qp_handle = qp->adapter_handle;
+
+	/*
+	 * reference the request struct.  dereferenced in the int handler.
+	 */
+	vq_req_get(c2dev, vq_req);
+
+	spin_lock_irqsave(&qp->lock, flags);
+	if (qp->cm_id && qp->state == IB_QPS_RTS) {
+		dprintk("destroy_qp: generating CLOSE event for QP-->ERR, "
+			"qp=%p, cm_id=%p\n",qp,qp->cm_id);
+		/* Generate an CLOSE event */
+		vq_req->qp = qp;
+		vq_req->cm_id = qp->cm_id;
+		vq_req->event = IW_CM_EVENT_CLOSE;
+	}
+	spin_unlock_irqrestore(&qp->lock, flags);
+
+	/*
+	 * Send WR to adapter
+	 */
+	err = vq_send_wr(c2dev, (union c2wr *) & wr);
+	if (err) {
+		vq_req_put(c2dev, vq_req);
+		goto bail0;
+	}
+
+	/*
+	 * Wait for reply from adapter
+	 */
+	err = vq_wait_for_reply(c2dev, vq_req);
+	if (err) {
+		goto bail0;
+	}
+
+	/*
+	 * Process reply
+	 */
+	reply = (struct c2wr_qp_destroy_rep *) (unsigned long) (vq_req->reply_msg);
+	if (!reply) {
+		err = -ENOMEM;
+		goto bail0;
+	}
+
+	spin_lock_irqsave(&qp->lock, flags);
+	if (qp->cm_id) {
+		qp->cm_id->rem_ref(qp->cm_id);
+		qp->cm_id = NULL;
+	}
+	spin_unlock_irqrestore(&qp->lock, flags);
+
+	vq_repbuf_free(c2dev, reply);
+      bail0:
+	vq_req_free(c2dev, vq_req);
+	return err;
+}
+
+int c2_alloc_qp(struct c2_dev *c2dev,
+		struct c2_pd *pd,
+		struct ib_qp_init_attr *qp_attrs, struct c2_qp *qp)
+{
+	struct c2wr_qp_create_req wr;
+	struct c2wr_qp_create_rep *reply;
+	struct c2_vq_req *vq_req;
+	struct c2_cq *send_cq = to_c2cq(qp_attrs->send_cq);
+	struct c2_cq *recv_cq = to_c2cq(qp_attrs->recv_cq);
+	unsigned long peer_pa;
+	u32 q_size, msg_size, mmap_size;
+	void __iomem *mmap;
+	int err;
+
+	qp->qpn = c2_alloc(&c2dev->qp_table.alloc);
+	if (qp->qpn == -1)
+		return -ENOMEM;
+
+	qp->ibqp.qp_num = qp->qpn;
+	qp->ibqp.qp_type = IB_QPT_RC;
+
+	/* Allocate the SQ and RQ shared pointers */
+	qp->sq_mq.shared = c2_alloc_mqsp(c2dev->kern_mqsp_pool);
+	if (!qp->sq_mq.shared) {
+		err = -ENOMEM;
+		goto bail0;
+	}
+
+	qp->rq_mq.shared = c2_alloc_mqsp(c2dev->kern_mqsp_pool);
+	if (!qp->rq_mq.shared) {
+		err = -ENOMEM;
+		goto bail1;
+	}
+
+	/* Allocate the verbs request */
+	vq_req = vq_req_alloc(c2dev);
+	if (vq_req == NULL) {
+		err = -ENOMEM;
+		goto bail2;
+	}
+
+	/* Initialize the work request */
+	memset(&wr, 0, sizeof(wr));
+	c2_wr_set_id(&wr, CCWR_QP_CREATE);
+	wr.hdr.context = (unsigned long) vq_req;
+	wr.rnic_handle = c2dev->adapter_handle;
+	wr.sq_cq_handle = send_cq->adapter_handle;
+	wr.rq_cq_handle = recv_cq->adapter_handle;
+	wr.sq_depth = cpu_to_be32(qp_attrs->cap.max_send_wr + 1);
+	wr.rq_depth = cpu_to_be32(qp_attrs->cap.max_recv_wr + 1);
+	wr.srq_handle = 0;
+	wr.flags = cpu_to_be32(QP_RDMA_READ | QP_RDMA_WRITE | QP_MW_BIND |
+			       QP_ZERO_STAG | QP_RDMA_READ_RESPONSE);
+	wr.send_sgl_depth = cpu_to_be32(qp_attrs->cap.max_send_sge);
+	wr.recv_sgl_depth = cpu_to_be32(qp_attrs->cap.max_recv_sge);
+	wr.rdma_write_sgl_depth = cpu_to_be32(qp_attrs->cap.max_send_sge);
+	// XXX no write depth?
+	wr.shared_sq_ht = cpu_to_be64(__pa(qp->sq_mq.shared));
+	wr.shared_rq_ht = cpu_to_be64(__pa(qp->rq_mq.shared));
+	wr.ord = cpu_to_be32(C2_MAX_ORD_PER_QP);
+	wr.ird = cpu_to_be32(C2_MAX_IRD_PER_QP);
+	wr.pd_id = pd->pd_id;
+	wr.user_context = (unsigned long) qp;
+
+	vq_req_get(c2dev, vq_req);
+
+	/* Send the WR to the adapter */
+	err = vq_send_wr(c2dev, (union c2wr *) & wr);
+	if (err) {
+		vq_req_put(c2dev, vq_req);
+		goto bail3;
+	}
+
+	/* Wait for the verb reply  */
+	err = vq_wait_for_reply(c2dev, vq_req);
+	if (err) {
+		goto bail3;
+	}
+
+	/* Process the reply */
+	reply = (struct c2wr_qp_create_rep *) (unsigned long) (vq_req->reply_msg);
+	if (!reply) {
+		err = -ENOMEM;
+		goto bail3;
+	}
+
+	if ((err = c2_wr_get_result(reply)) != 0) {
+		goto bail4;
+	}
+
+	/* Fill in the kernel QP struct */
+	atomic_set(&qp->refcount, 1);
+	qp->adapter_handle = reply->qp_handle;
+	qp->state = IB_QPS_RESET;
+	qp->send_sgl_depth = qp_attrs->cap.max_send_sge;
+	qp->rdma_write_sgl_depth = qp_attrs->cap.max_send_sge;
+	qp->recv_sgl_depth = qp_attrs->cap.max_recv_sge;
+
+	/* Initialize the SQ MQ */
+	q_size = be32_to_cpu(reply->sq_depth);
+	msg_size = be32_to_cpu(reply->sq_msg_size);
+	peer_pa = c2dev->pa + be32_to_cpu(reply->sq_mq_start);
+	mmap_size = PAGE_ALIGN(sizeof(struct c2_mq_shared) + msg_size * q_size);
+	mmap = ioremap_nocache(peer_pa, mmap_size);
+	if (!mmap) {
+		err = -ENOMEM;
+		goto bail5;
+	}
+
+	c2_mq_req_init(&qp->sq_mq, 
+		       be32_to_cpu(reply->sq_mq_index), 
+		       q_size, 
+		       msg_size, 
+		       mmap + sizeof(struct c2_mq_shared),	/* pool start */
+		       mmap,				/* peer */
+		       C2_MQ_ADAPTER_TARGET);
+
+	/* Initialize the RQ mq */
+	q_size = be32_to_cpu(reply->rq_depth);
+	msg_size = be32_to_cpu(reply->rq_msg_size);
+	peer_pa = c2dev->pa + be32_to_cpu(reply->rq_mq_start);
+	mmap_size = PAGE_ALIGN(sizeof(struct c2_mq_shared) + msg_size * q_size);
+	mmap = ioremap_nocache(peer_pa, mmap_size);
+	if (!mmap) {
+		err = -ENOMEM;
+		goto bail6;
+	}
+
+	c2_mq_req_init(&qp->rq_mq, 
+		       be32_to_cpu(reply->rq_mq_index), 
+		       q_size, 
+		       msg_size, 
+		       mmap + sizeof(struct c2_mq_shared),	/* pool start */
+		       mmap,				/* peer */
+		       C2_MQ_ADAPTER_TARGET);
+
+	vq_repbuf_free(c2dev, reply);
+	vq_req_free(c2dev, vq_req);
+
+	spin_lock_irq(&c2dev->qp_table.lock);
+	c2_array_set(&c2dev->qp_table.qp, qp->qpn & (c2dev->props.max_qp - 1), qp);
+	c2dev->qp_table.map[qp->qpn] = qp;
+	spin_unlock_irq(&c2dev->qp_table.lock);
+
+	return 0;
+
+      bail6:
+	iounmap(qp->sq_mq.peer);
+      bail5:
+	destroy_qp(c2dev, qp);
+      bail4:
+	vq_repbuf_free(c2dev, reply);
+      bail3:
+	vq_req_free(c2dev, vq_req);
+      bail2:
+	c2_free_mqsp(qp->rq_mq.shared);
+      bail1:
+	c2_free_mqsp(qp->sq_mq.shared);
+      bail0:
+	c2_free(&c2dev->qp_table.alloc, qp->qpn);
+	return err;
+}
+
+void c2_free_qp(struct c2_dev *c2dev, struct c2_qp *qp)
+{
+	struct c2_cq *send_cq;
+	struct c2_cq *recv_cq;
+
+	send_cq = to_c2cq(qp->ibqp.send_cq);
+	recv_cq = to_c2cq(qp->ibqp.recv_cq);
+
+	/*
+	 * Lock CQs here, so that CQ polling code can do QP lookup
+	 * without taking a lock.
+	 */
+	spin_lock_irq(&send_cq->lock);
+	if (send_cq != recv_cq)
+		spin_lock(&recv_cq->lock);
+
+	spin_lock(&c2dev->qp_table.lock);
+	c2_array_clear(&c2dev->qp_table.qp, qp->qpn & (c2dev->props.max_qp - 1));
+	c2dev->qp_table.map[qp->qpn] = NULL;
+	spin_unlock(&c2dev->qp_table.lock);
+
+	if (send_cq != recv_cq)
+		spin_unlock(&recv_cq->lock);
+	spin_unlock_irq(&send_cq->lock);
+
+	/*
+	 * Destory qp in the rnic...
+	 */
+	destroy_qp(c2dev, qp);
+
+	/*
+	 * Mark any unreaped CQEs as null and void.
+	 */
+	c2_cq_clean(c2dev, qp, send_cq->cqn);
+	if (send_cq != recv_cq)
+		c2_cq_clean(c2dev, qp, recv_cq->cqn);
+	/*
+	 * Unmap the MQs and return the shared pointers
+	 * to the message pool.
+	 */
+	iounmap(qp->sq_mq.peer);
+	iounmap(qp->rq_mq.peer);
+	c2_free_mqsp(qp->sq_mq.shared);
+	c2_free_mqsp(qp->rq_mq.shared);
+
+	atomic_dec(&qp->refcount);
+	wait_event(qp->wait, !atomic_read(&qp->refcount));
+	c2_free(&c2dev->qp_table.alloc, qp->qpn);
+}
+
+/*
+ * Function: move_sgl 
+ *
+ * Description: 
+ * Move an SGL from the user's work request struct into a CCIL Work Request 
+ * message, swapping to WR byte order and ensure the total length doesn't 
+ * overflow. 
+ *
+ * IN: 
+ * dst		- ptr to CCIL Work Request message SGL memory.
+ * src		- ptr to the consumers SGL memory.
+ *
+ * OUT: none
+ *
+ * Return: 
+ * CCIL status codes.
+ */
+static int
+move_sgl(struct c2_data_addr * dst, struct ib_sge *src, int count, u32 * p_len,
+	 u8 * actual_count)
+{
+	u32 tot = 0;		/* running total */
+	u8 acount = 0;		/* running total non-0 len sge's */
+
+	while (count > 0) {
+		/*
+		 * If the addition of this SGE causes the
+		 * total SGL length to exceed 2^32-1, then
+		 * fail-n-bail.
+		 *
+		 * If the current total plus the next element length
+		 * wraps, then it will go negative and be less than the
+		 * current total...
+		 */
+		if ((tot + src->length) < tot) {
+			return -EINVAL;
+		}
+		/*
+		 * Bug: 1456 (as well as 1498 & 1643)
+		 * Skip over any sge's supplied with len=0
+		 */
+		if (src->length) {
+			tot += src->length;
+			dst->stag = cpu_to_be32(src->lkey);
+			dst->to = cpu_to_be64(src->addr);
+			dst->length = cpu_to_be32(src->length);
+			dst++;
+			acount++;
+		}
+		src++;
+		count--;
+	}
+
+	if (acount == 0) {
+		/*
+		 * Bug: 1476 (as well as 1498, 1456 and 1643)
+		 * Setup the SGL in the WR to make it easier for the RNIC.
+		 * This way, the FW doesn't have to deal with special cases.
+		 * Setting length=0 should be sufficient.
+		 */
+		dst->stag = 0;
+		dst->to = 0;
+		dst->length = 0;
+	}
+
+	*p_len = tot;
+	*actual_count = acount;
+	return 0;
+}
+
+/*
+ * Function: c2_activity (private function)
+ *
+ * Description: 
+ * Post an mq index to the host->adapter activity fifo.
+ *
+ * IN: 
+ * c2dev	- ptr to c2dev structure
+ * mq_index	- mq index to post
+ * shared	- value most recently written to shared 
+ *
+ * OUT: 
+ *
+ * Return: 
+ * none
+ */
+static inline void c2_activity(struct c2_dev *c2dev, u32 mq_index, u16 shared)
+{
+	/*
+	 * First read the register to see if the FIFO is full, and if so,
+	 * spin until it's not.  This isn't perfect -- there is no
+	 * synchronization among the clients of the register, but in
+	 * practice it prevents multiple CPU from hammering the bus
+	 * with PCI RETRY. Note that when this does happen, the card
+	 * cannot get on the bus and the card and system hang in a
+	 * deadlock -- thus the need for this code. [TOT]
+	 */
+	while (readl(c2dev->regs + PCI_BAR0_ADAPTER_HINT) & 0x80000000) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(0);
+	}
+
+	__raw_writel(C2_HINT_MAKE(mq_index, shared),
+		     c2dev->regs + PCI_BAR0_ADAPTER_HINT);
+}
+
+/*
+ * Function: qp_wr_post 
+ *
+ * Description: 
+ * This in-line function allocates a MQ msg, then moves the host-copy of 
+ * the completed WR into msg.  Then it posts the message. 
+ * 
+ * IN: 
+ * q		- ptr to user MQ.
+ * wr		- ptr to host-copy of the WR.
+ * qp		- ptr to user qp
+ * size		- Number of bytes to post.  Assumed to be divisible by 4.
+ *
+ * OUT: none
+ *
+ * Return: 
+ * CCIL status codes.
+ */
+static int qp_wr_post(struct c2_mq *q, union c2wr * wr, struct c2_qp *qp, u32 size)
+{
+	union c2wr *msg;
+
+	msg = c2_mq_alloc(q);
+	if (msg == NULL) {
+		return -EINVAL;
+	}
+#ifdef CCMSGMAGIC
+	((c2wr_hdr_t *) wr)->magic = cpu_to_be32(CCWR_MAGIC);
+#endif
+
+	/*
+	 * Since all header fields in the WR are the same as the
+	 * CQE, set the following so the adapter need not.
+	 */
+	c2_wr_set_result(wr, CCERR_PENDING);
+
+	/*
+	 * Copy the wr down to the adapter
+	 */
+	memcpy((void *) msg, (void *) wr, size);
+
+	c2_mq_produce(q);
+	return 0;
+}
+
+
+int c2_post_send(struct ib_qp *ibqp, struct ib_send_wr *ib_wr,
+		 struct ib_send_wr **bad_wr)
+{
+	struct c2_dev *c2dev = to_c2dev(ibqp->device);
+	struct c2_qp *qp = to_c2qp(ibqp);
+	union c2wr wr;
+	int err = 0;
+
+	u32 flags;
+	u32 tot_len;
+	u8 actual_sge_count;
+	u32 msg_size;
+
+	if (qp->state > IB_QPS_RTS)
+		return -EINVAL;
+
+	while (ib_wr) {
+
+		flags = 0;
+		wr.sqwr.sq_hdr.user_hdr.hdr.context = ib_wr->wr_id;
+		if (ib_wr->send_flags & IB_SEND_SIGNALED) {
+			flags |= SQ_SIGNALED;
+		}
+
+		switch (ib_wr->opcode) {
+		case IB_WR_SEND:
+			if (ib_wr->send_flags & IB_SEND_SOLICITED) {
+				c2_wr_set_id(&wr, C2_WR_TYPE_SEND_SE);
+				msg_size = sizeof(struct c2wr_send_req);
+			} else {
+				c2_wr_set_id(&wr, C2_WR_TYPE_SEND);
+				msg_size = sizeof(struct c2wr_send_req);
+			}
+
+			wr.sqwr.send.remote_stag = 0;
+			msg_size += sizeof(struct c2_data_addr) * ib_wr->num_sge;
+			if (ib_wr->num_sge > qp->send_sgl_depth) {
+				err = -EINVAL;
+				break;
+			}
+			if (ib_wr->send_flags & IB_SEND_FENCE) {
+				flags |= SQ_READ_FENCE;
+			}
+			err = move_sgl((struct c2_data_addr *) & (wr.sqwr.send.data),
+				       ib_wr->sg_list,
+				       ib_wr->num_sge,
+				       &tot_len, &actual_sge_count);
+			wr.sqwr.send.sge_len = cpu_to_be32(tot_len);
+			c2_wr_set_sge_count(&wr, actual_sge_count);
+			break;
+		case IB_WR_RDMA_WRITE:
+			c2_wr_set_id(&wr, C2_WR_TYPE_RDMA_WRITE);
+			msg_size = sizeof(struct c2wr_rdma_write_req) +
+			    (sizeof(struct c2_data_addr) * ib_wr->num_sge);
+			if (ib_wr->num_sge > qp->rdma_write_sgl_depth) {
+				err = -EINVAL;
+				break;
+			}
+			if (ib_wr->send_flags & IB_SEND_FENCE) {
+				flags |= SQ_READ_FENCE;
+			}
+			wr.sqwr.rdma_write.remote_stag =
+			    cpu_to_be32(ib_wr->wr.rdma.rkey);
+			wr.sqwr.rdma_write.remote_to =
+			    cpu_to_be64(ib_wr->wr.rdma.remote_addr);
+			err = move_sgl((struct c2_data_addr *)
+				       & (wr.sqwr.rdma_write.data),
+				       ib_wr->sg_list,
+				       ib_wr->num_sge,
+				       &tot_len, &actual_sge_count);
+			wr.sqwr.rdma_write.sge_len = cpu_to_be32(tot_len);
+			c2_wr_set_sge_count(&wr, actual_sge_count);
+			break;
+		case IB_WR_RDMA_READ:
+			c2_wr_set_id(&wr, C2_WR_TYPE_RDMA_READ);
+			msg_size = sizeof(struct c2wr_rdma_read_req);
+
+			/* IWarp only suppots 1 sge for RDMA reads */
+			if (ib_wr->num_sge > 1) {
+				err = -EINVAL;
+				break;
+			}
+
+			/*
+			 * Move the local and remote stag/to/len into the WR. 
+			 */
+			wr.sqwr.rdma_read.local_stag =
+			    cpu_to_be32(ib_wr->sg_list->lkey);
+			wr.sqwr.rdma_read.local_to =
+			    cpu_to_be64(ib_wr->sg_list->addr);
+			wr.sqwr.rdma_read.remote_stag =
+			    cpu_to_be32(ib_wr->wr.rdma.rkey);
+			wr.sqwr.rdma_read.remote_to =
+			    cpu_to_be64(ib_wr->wr.rdma.remote_addr);
+			wr.sqwr.rdma_read.length =
+			    cpu_to_be32(ib_wr->sg_list->length);
+			break;
+		default:
+			/* error */
+			msg_size = 0;
+			err = -EINVAL;
+			break;
+		}
+
+		/*
+		 * If we had an error on the last wr build, then
+		 * break out.  Possible errors include bogus WR 
+		 * type, and a bogus SGL length...
+		 */
+		if (err) {
+			break;
+		}
+
+		/*
+		 * Store flags
+		 */
+		c2_wr_set_flags(&wr, flags);
+
+		/*
+		 * Post the puppy!
+		 */
+		err = qp_wr_post(&qp->sq_mq, &wr, qp, msg_size);
+		if (err) {
+			break;
+		}
+
+		/*
+		 * Enqueue mq index to activity FIFO.
+		 */
+		c2_activity(c2dev, qp->sq_mq.index, qp->sq_mq.hint_count);
+
+		ib_wr = ib_wr->next;
+	}
+
+	if (err)
+		*bad_wr = ib_wr;
+	return err;
+}
+
+int c2_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *ib_wr,
+		    struct ib_recv_wr **bad_wr)
+{
+	struct c2_dev *c2dev = to_c2dev(ibqp->device);
+	struct c2_qp *qp = to_c2qp(ibqp);
+	union c2wr wr;
+	int err = 0;
+
+	if (qp->state > IB_QPS_RTS)
+		return -EINVAL;
+
+	/*
+	 * Try and post each work request
+	 */
+	while (ib_wr) {
+		u32 tot_len;
+		u8 actual_sge_count;
+
+		if (ib_wr->num_sge > qp->recv_sgl_depth) {
+			err = -EINVAL;
+			break;
+		}
+
+		/*
+		 * Create local host-copy of the WR
+		 */
+		wr.rqwr.rq_hdr.user_hdr.hdr.context = ib_wr->wr_id;
+		c2_wr_set_id(&wr, CCWR_RECV);
+		c2_wr_set_flags(&wr, 0);
+
+		/* sge_count is limited to eight bits. */
+		assert(ib_wr->num_sge < 256);
+		err = move_sgl((struct c2_data_addr *) & (wr.rqwr.data),
+			       ib_wr->sg_list,
+			       ib_wr->num_sge, &tot_len, &actual_sge_count);
+		c2_wr_set_sge_count(&wr, actual_sge_count);
+
+		/*
+		 * If we had an error on the last wr build, then
+		 * break out.  Possible errors include bogus WR 
+		 * type, and a bogus SGL length...
+		 */
+		if (err) {
+			break;
+		}
+
+		err = qp_wr_post(&qp->rq_mq, &wr, qp, qp->rq_mq.msg_size);
+		if (err) {
+			break;
+		}
+
+		/*
+		 * Enqueue mq index to activity FIFO
+		 */
+		c2_activity(c2dev, qp->rq_mq.index, qp->rq_mq.hint_count);
+
+		ib_wr = ib_wr->next;
+	}
+
+	if (err)
+		*bad_wr = ib_wr;
+	return err;
+}
+
+int __devinit c2_init_qp_table(struct c2_dev *c2dev)
+{
+	int err;
+
+	spin_lock_init(&c2dev->qp_table.lock);
+
+	err = c2_alloc_init(&c2dev->qp_table.alloc, 
+			    c2dev->props.max_qp, 1);
+	if (err)
+		return err;
+
+	err = c2_array_init(&c2dev->qp_table.qp, c2dev->props.max_qp);
+	if (err) {
+		c2_alloc_cleanup(&c2dev->qp_table.alloc);
+		return err;
+	}
+
+	c2dev->qp_table.map = vmalloc(sizeof(struct c2_qp *) * c2dev->props.max_qp);
+	if (!c2dev->qp_table.map) {
+		dprintk("Could not allocate QPN <-> QP map\n");
+		c2_alloc_cleanup(&c2dev->qp_table.alloc);
+		c2_array_cleanup(&c2dev->qp_table.qp, c2dev->props.max_qp);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void __devexit c2_cleanup_qp_table(struct c2_dev *c2dev)
+{
+	c2_alloc_cleanup(&c2dev->qp_table.alloc);
+	c2_array_cleanup(&c2dev->qp_table.qp, c2dev->props.max_qp);
+}
diff --git a/drivers/infiniband/hw/amso1100/c2_user.h b/drivers/infiniband/hw/amso1100/c2_user.h
new file mode 100644
index 0000000..7e9e7ad
--- /dev/null
+++ b/drivers/infiniband/hw/amso1100/c2_user.h
@@ -0,0 +1,82 @@
+/*
+ * Copyright (c) 2005 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
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
+ *
+ */
+
+#ifndef C2_USER_H
+#define C2_USER_H
+
+#include <linux/types.h>
+
+/*
+ * Make sure that all structs defined in this file remain laid out so
+ * that they pack the same way on 32-bit and 64-bit architectures (to
+ * avoid incompatibility between 32-bit userspace and 64-bit kernels).
+ * In particular do not use pointer types -- pass pointers in __u64
+ * instead.
+ */
+
+struct c2_alloc_ucontext_resp {
+	__u32 qp_tab_size;
+	__u32 uarc_size;
+};
+
+struct c2_alloc_pd_resp {
+	__u32 pdn;
+	__u32 reserved;
+};
+
+struct c2_create_cq {
+	__u32 lkey;
+	__u32 pdn;
+	__u64 arm_db_page;
+	__u64 set_db_page;
+	__u32 arm_db_index;
+	__u32 set_db_index;
+};
+
+struct c2_create_cq_resp {
+	__u32 cqn;
+	__u32 reserved;
+};
+
+struct c2_create_qp {
+	__u32 lkey;
+	__u32 reserved;
+	__u64 sq_db_page;
+	__u64 rq_db_page;
+	__u32 sq_db_index;
+	__u32 rq_db_index;
+};
+
+#endif				/* C2_USER_H */
