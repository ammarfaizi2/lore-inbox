Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbVGKUql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbVGKUql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVGKUo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:44:29 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:37325 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262619AbVGKUn4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:43:56 -0400
Subject: [PATCH 19/29v2] Add RMPP implementation
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110354.4389.5022.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 16:36:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add RMPP implementation 
Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 18/29.

-- 
 Makefile   |    2 
 mad.c      |  167 +++++++++--
 mad_priv.h |   28 +-
 mad_rmpp.c |  765 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mad_rmpp.h |   58 ++++
 5 files changed, 968 insertions(+), 52 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1-18/drivers/infiniband/core/mad.c linux-2.6.13-rc2-mm1-19/drivers/infiniband/core/mad.c
-- linux-2.6.13-rc2-mm1-18/drivers/infiniband/core/mad.c	2005-07-11 13:39:53.000000000 -0400
+++ linux-2.6.13-rc2-mm1-19/drivers/infiniband/core/mad.c	2005-07-11 13:40:04.000000000 -0400
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2004, 2005 Voltaire, Inc. All rights reserved.
+ * Copyright (c) 2005 Intel Corporation.  All rights reserved.
+ * Copyright (c) 2005 Mellanox Technologies Ltd.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -29,12 +31,12 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: mad.c 1389 2004-12-27 22:56:47Z roland $
+ * $Id: mad.c 2817 2005-07-07 11:29:26Z halr $
  */
-
 #include <linux/dma-mapping.h>
 
 #include "mad_priv.h"
+#include "mad_rmpp.h"
 #include "smi.h"
 #include "agent.h"
 
@@ -45,6 +47,7 @@ MODULE_AUTHOR("Sean Hefty");
 

 kmem_cache_t *ib_mad_cache;
+
 static struct list_head ib_mad_port_list;
 static u32 ib_mad_client_id = 0;
 
@@ -62,8 +65,6 @@ static struct ib_mad_agent_private *find
 static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 				    struct ib_mad_private *mad);
 static void cancel_mads(struct ib_mad_agent_private *mad_agent_priv);
-static void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
-				    struct ib_mad_send_wc *mad_send_wc);
 static void timeout_sends(void *data);
 static void local_completions(void *data);
 static int add_nonoui_reg_req(struct ib_mad_reg_req *mad_reg_req,
@@ -195,8 +196,8 @@ struct ib_mad_agent *ib_register_mad_age
 	if (qpn == -1)
 		goto error1;
 
-	if (rmpp_version)
-		goto error1;	/* XXX: until RMPP implemented */
+	if (rmpp_version && rmpp_version != IB_MGMT_RMPP_VERSION)
+		goto error1;
 
 	/* Validate MAD registration request if supplied */
 	if (mad_reg_req) {
@@ -281,7 +282,7 @@ struct ib_mad_agent *ib_register_mad_age
 	/* Now, fill in the various structures */
 	mad_agent_priv->qp_info = &port_priv->qp_info[qpn];
 	mad_agent_priv->reg_req = reg_req;
-	mad_agent_priv->rmpp_version = rmpp_version;
+	mad_agent_priv->agent.rmpp_version = rmpp_version;
 	mad_agent_priv->agent.device = device;
 	mad_agent_priv->agent.recv_handler = recv_handler;
 	mad_agent_priv->agent.send_handler = send_handler;
@@ -341,6 +342,7 @@ struct ib_mad_agent *ib_register_mad_age
 	INIT_LIST_HEAD(&mad_agent_priv->send_list);
 	INIT_LIST_HEAD(&mad_agent_priv->wait_list);
 	INIT_LIST_HEAD(&mad_agent_priv->done_list);
+	INIT_LIST_HEAD(&mad_agent_priv->rmpp_list);
 	INIT_WORK(&mad_agent_priv->timed_work, timeout_sends, mad_agent_priv);
 	INIT_LIST_HEAD(&mad_agent_priv->local_list);
 	INIT_WORK(&mad_agent_priv->local_work, local_completions,
@@ -502,6 +504,7 @@ static void unregister_mad_agent(struct 
 	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
 
 	flush_workqueue(port_priv->wq);
+	ib_cancel_rmpp_recvs(mad_agent_priv);
 
 	atomic_dec(&mad_agent_priv->refcount);
 	wait_event(mad_agent_priv->wait,
@@ -689,7 +692,7 @@ static int handle_outgoing_dr_smp(struct
 		kfree(local);
 		goto out;
 	}
-
+	
 	build_smp_wc(send_wr->wr_id, smp->dr_slid, send_wr->wr.ud.pkey_index,
 		     send_wr->wr.ud.port_num, &mad_wc);
 
@@ -705,7 +708,7 @@ static int handle_outgoing_dr_smp(struct
 			local->mad_priv = mad_priv;
 			local->recv_mad_agent = mad_agent_priv;
 			/*
-			 * Reference MAD agent until receive
+			 * Reference MAD agent until receive 
 			 * side of local completion handled
 			 */
 			atomic_inc(&mad_agent_priv->refcount);
@@ -786,12 +789,15 @@ struct ib_mad_send_buf * ib_create_send_
 	int buf_size;
 	void *buf;
 
-	if (rmpp_active)
-		return ERR_PTR(-EINVAL);	/* until RMPP implemented */
 	mad_agent_priv = container_of(mad_agent,
 				      struct ib_mad_agent_private, agent);
 	buf_size = get_buf_length(hdr_len, data_len);
 
+	if ((!mad_agent->rmpp_version &&
+	     (rmpp_active || buf_size > sizeof(struct ib_mad))) ||
+	    (!rmpp_active && buf_size > sizeof(struct ib_mad)))
+		return ERR_PTR(-EINVAL);
+
 	buf = kmalloc(sizeof *send_buf + buf_size, gfp_mask);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
@@ -816,6 +822,18 @@ struct ib_mad_send_buf * ib_create_send_
 	send_buf->send_wr.wr.ud.remote_qpn = remote_qpn;
 	send_buf->send_wr.wr.ud.remote_qkey = IB_QP_SET_QKEY;
 	send_buf->send_wr.wr.ud.pkey_index = pkey_index;
+
+	if (rmpp_active) {
+		struct ib_rmpp_mad *rmpp_mad;
+		rmpp_mad = (struct ib_rmpp_mad *)send_buf->mad;
+		rmpp_mad->rmpp_hdr.paylen_newwin = cpu_to_be32(hdr_len -
+			offsetof(struct ib_rmpp_mad, data) + data_len);
+		rmpp_mad->rmpp_hdr.rmpp_version = mad_agent->rmpp_version;
+		rmpp_mad->rmpp_hdr.rmpp_type = IB_MGMT_RMPP_TYPE_DATA;
+		ib_set_rmpp_flags(&rmpp_mad->rmpp_hdr,
+				  IB_MGMT_RMPP_FLAG_ACTIVE);
+	}
+
 	send_buf->mad_agent = mad_agent;
 	atomic_inc(&mad_agent_priv->refcount);
 	return send_buf;
@@ -839,7 +857,7 @@ void ib_free_send_mad(struct ib_mad_send
 }
 EXPORT_SYMBOL(ib_free_send_mad);
 
-static int ib_send_mad(struct ib_mad_send_wr_private *mad_send_wr)
+int ib_send_mad(struct ib_mad_send_wr_private *mad_send_wr)
 {
 	struct ib_mad_qp_info *qp_info;
 	struct ib_send_wr *bad_send_wr;
@@ -940,13 +958,13 @@ int ib_post_send_mad(struct ib_mad_agent
 			ret = -ENOMEM;
 			goto error2;
 		}
+		memset(mad_send_wr, 0, sizeof *mad_send_wr);
 
 		mad_send_wr->send_wr = *send_wr;
 		mad_send_wr->send_wr.sg_list = mad_send_wr->sg_list;
 		memcpy(mad_send_wr->sg_list, send_wr->sg_list,
 		       sizeof *send_wr->sg_list * send_wr->num_sge);
-		mad_send_wr->wr_id = mad_send_wr->send_wr.wr_id;
-		mad_send_wr->send_wr.next = NULL;
+		mad_send_wr->wr_id = send_wr->wr_id;
 		mad_send_wr->tid = send_wr->wr.ud.mad_hdr->tid;
 		mad_send_wr->mad_agent_priv = mad_agent_priv;
 		/* Timeout will be updated after send completes */
@@ -964,8 +982,13 @@ int ib_post_send_mad(struct ib_mad_agent
 			      &mad_agent_priv->send_list);
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
-		ret = ib_send_mad(mad_send_wr);
-		if (ret) {
+		if (mad_agent_priv->agent.rmpp_version) {
+			ret = ib_send_rmpp_mad(mad_send_wr);
+			if (ret >= 0 && ret != IB_RMPP_RESULT_CONSUMED)
+				ret = ib_send_mad(mad_send_wr);
+		} else
+			ret = ib_send_mad(mad_send_wr);
+		if (ret < 0) {
 			/* Fail send request */
 			spin_lock_irqsave(&mad_agent_priv->lock, flags);
 			list_del(&mad_send_wr->agent_list);
@@ -991,31 +1014,25 @@ EXPORT_SYMBOL(ib_post_send_mad);
  */
 void ib_free_recv_mad(struct ib_mad_recv_wc *mad_recv_wc)
 {
-	struct ib_mad_recv_buf *entry;
+	struct ib_mad_recv_buf *mad_recv_buf, *temp_recv_buf;
 	struct ib_mad_private_header *mad_priv_hdr;
 	struct ib_mad_private *priv;
+	struct list_head free_list;
 
-	mad_priv_hdr = container_of(mad_recv_wc,
-				    struct ib_mad_private_header,
-				    recv_wc);
-	priv = container_of(mad_priv_hdr, struct ib_mad_private, header);
+	INIT_LIST_HEAD(&free_list);
+	list_splice_init(&mad_recv_wc->rmpp_list, &free_list);
 
-	/*
-	 * Walk receive buffer list associated with this WC
-	 * No need to remove them from list of receive buffers
-	 */
-	list_for_each_entry(entry, &mad_recv_wc->recv_buf.list, list) {
-		/* Free previous receive buffer */
-		kmem_cache_free(ib_mad_cache, priv);
+	list_for_each_entry_safe(mad_recv_buf, temp_recv_buf,
+					&free_list, list) {
+		mad_recv_wc = container_of(mad_recv_buf, struct ib_mad_recv_wc,
+					   recv_buf);
 		mad_priv_hdr = container_of(mad_recv_wc,
 					    struct ib_mad_private_header,
 					    recv_wc);
 		priv = container_of(mad_priv_hdr, struct ib_mad_private,
 				    header);
+		kmem_cache_free(ib_mad_cache, priv);
 	}
-
-	/* Free last buffer */
-	kmem_cache_free(ib_mad_cache, priv);
 }
 EXPORT_SYMBOL(ib_free_recv_mad);
 
@@ -1524,9 +1541,20 @@ out:
 	return valid;
 }
 
-static struct ib_mad_send_wr_private*
-find_send_req(struct ib_mad_agent_private *mad_agent_priv,
-	      u64 tid)
+static int is_data_mad(struct ib_mad_agent_private *mad_agent_priv,
+		       struct ib_mad_hdr *mad_hdr)
+{
+	struct ib_rmpp_mad *rmpp_mad;
+
+	rmpp_mad = (struct ib_rmpp_mad *)mad_hdr;
+	return !mad_agent_priv->agent.rmpp_version ||
+		!(ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) &
+				    IB_MGMT_RMPP_FLAG_ACTIVE) ||
+		(rmpp_mad->rmpp_hdr.rmpp_type == IB_MGMT_RMPP_TYPE_DATA);
+}
+
+struct ib_mad_send_wr_private*
+ib_find_send_mad(struct ib_mad_agent_private *mad_agent_priv, u64 tid)
 {
 	struct ib_mad_send_wr_private *mad_send_wr;
 
@@ -1542,7 +1570,9 @@ find_send_req(struct ib_mad_agent_privat
 	 */
 	list_for_each_entry(mad_send_wr, &mad_agent_priv->send_list,
 			    agent_list) {
-		if (mad_send_wr->tid == tid && mad_send_wr->timeout) {
+		if (is_data_mad(mad_agent_priv,
+				mad_send_wr->send_wr.wr.ud.mad_hdr) &&
+		    mad_send_wr->tid == tid && mad_send_wr->timeout) {
 			/* Verify request has not been canceled */
 			return (mad_send_wr->status == IB_WC_SUCCESS) ?
 				mad_send_wr : NULL;
@@ -1551,7 +1581,7 @@ find_send_req(struct ib_mad_agent_privat
 	return NULL;
 }
 
-static void ib_mark_req_done(struct ib_mad_send_wr_private *mad_send_wr)
+void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr)
 {
 	mad_send_wr->timeout = 0;
 	if (mad_send_wr->refcount == 1) {
@@ -1569,12 +1599,23 @@ static void ib_mad_complete_recv(struct 
 	unsigned long flags;
 	u64 tid;
 
-	INIT_LIST_HEAD(&mad_recv_wc->recv_buf.list);
+	INIT_LIST_HEAD(&mad_recv_wc->rmpp_list);
+	list_add(&mad_recv_wc->recv_buf.list, &mad_recv_wc->rmpp_list);
+	if (mad_agent_priv->agent.rmpp_version) {
+		mad_recv_wc = ib_process_rmpp_recv_wc(mad_agent_priv,
+						      mad_recv_wc);
+		if (!mad_recv_wc) {
+			if (atomic_dec_and_test(&mad_agent_priv->refcount))
+				wake_up(&mad_agent_priv->wait);
+			return;
+		}
+	}
+
 	/* Complete corresponding request */
 	if (response_mad(mad_recv_wc->recv_buf.mad)) {
 		tid = mad_recv_wc->recv_buf.mad->mad_hdr.tid;
 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
-		mad_send_wr = find_send_req(mad_agent_priv, tid);
+		mad_send_wr = ib_find_send_mad(mad_agent_priv, tid);
 		if (!mad_send_wr) {
 			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 			ib_free_recv_mad(mad_recv_wc);
@@ -1582,7 +1623,7 @@ static void ib_mad_complete_recv(struct 
 				wake_up(&mad_agent_priv->wait);
 			return;
 		}
-		ib_mark_req_done(mad_send_wr);
+		ib_mark_mad_done(mad_send_wr);
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
 		/* Defined behavior is to complete response before request */
@@ -1787,14 +1828,22 @@ void ib_reset_mad_timeout(struct ib_mad_
 /*
  * Process a send work completion
  */
-static void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
-				    struct ib_mad_send_wc *mad_send_wc)
+void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
+			     struct ib_mad_send_wc *mad_send_wc)
 {
 	struct ib_mad_agent_private	*mad_agent_priv;
 	unsigned long			flags;
+	int				ret;
 
 	mad_agent_priv = mad_send_wr->mad_agent_priv;
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
+	if (mad_agent_priv->agent.rmpp_version) {
+		ret = ib_process_rmpp_send_wc(mad_send_wr, mad_send_wc);
+		if (ret == IB_RMPP_RESULT_CONSUMED)
+			goto done;
+	} else
+		ret = IB_RMPP_RESULT_UNHANDLED;
+
 	if (mad_send_wc->status != IB_WC_SUCCESS &&
 	    mad_send_wr->status == IB_WC_SUCCESS) {
 		mad_send_wr->status = mad_send_wc->status;
@@ -1806,8 +1855,7 @@ static void ib_mad_complete_send_wr(stru
 		    mad_send_wr->status == IB_WC_SUCCESS) {
 			wait_for_response(mad_send_wr);
 		}
-		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
-		return;
+		goto done;
 	}
 
 	/* Remove send from MAD agent and notify client of completion */
@@ -1817,14 +1865,18 @@ static void ib_mad_complete_send_wr(stru
 
 	if (mad_send_wr->status != IB_WC_SUCCESS )
 		mad_send_wc->status = mad_send_wr->status;
-	mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
-					    mad_send_wc);
+	if (ret != IB_RMPP_RESULT_INTERNAL)
+		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
+						   mad_send_wc);
 
 	/* Release reference on agent taken when sending */
 	if (atomic_dec_and_test(&mad_agent_priv->refcount))
 		wake_up(&mad_agent_priv->wait);
 
 	kfree(mad_send_wr);
+	return;
+done:
+	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 }
 
 static void ib_mad_send_done_handler(struct ib_mad_port_private *port_priv,
@@ -2036,7 +2088,9 @@ find_send_by_wr_id(struct ib_mad_agent_p
 
 	list_for_each_entry(mad_send_wr, &mad_agent_priv->send_list,
 			    agent_list) {
-		if (mad_send_wr->wr_id == wr_id)
+		if (is_data_mad(mad_agent_priv,
+				mad_send_wr->send_wr.wr.ud.mad_hdr) &&
+		    mad_send_wr->wr_id == wr_id)
 			return mad_send_wr;
 	}
 	return NULL;
@@ -2118,7 +2172,9 @@ static void local_completions(void *data
 			local->mad_priv->header.recv_wc.wc = &wc;
 			local->mad_priv->header.recv_wc.mad_len =
 						sizeof(struct ib_mad);
-			INIT_LIST_HEAD(&local->mad_priv->header.recv_wc.recv_buf.list);
+			INIT_LIST_HEAD(&local->mad_priv->header.recv_wc.rmpp_list);
+			list_add(&local->mad_priv->header.recv_wc.recv_buf.list,
+				 &local->mad_priv->header.recv_wc.rmpp_list);
 			local->mad_priv->header.recv_wc.recv_buf.grh = NULL;
 			local->mad_priv->header.recv_wc.recv_buf.mad =
 						&local->mad_priv->mad.mad;
@@ -2166,7 +2222,21 @@ static int retry_send(struct ib_mad_send
 	mad_send_wr->timeout = msecs_to_jiffies(mad_send_wr->send_wr.
 						wr.ud.timeout_ms);
 
-	ret = ib_send_mad(mad_send_wr);
+	if (mad_send_wr->mad_agent_priv->agent.rmpp_version) {
+		ret = ib_retry_rmpp(mad_send_wr);
+		switch (ret) {
+		case IB_RMPP_RESULT_UNHANDLED:
+			ret = ib_send_mad(mad_send_wr);
+			break;
+		case IB_RMPP_RESULT_CONSUMED:
+			ret = 0;
+			break;
+		default:
+			ret = -ECOMM;
+			break;
+		}
+	} else
+		ret = ib_send_mad(mad_send_wr);
 
 	if (!ret) {
 		mad_send_wr->refcount++;
@@ -2724,3 +2794,4 @@ static void __exit ib_mad_cleanup_module
 
 module_init(ib_mad_init_module);
 module_exit(ib_mad_cleanup_module);
+
diff -uprN linux-2.6.13-rc2-mm1-18/drivers/infiniband/core/mad_priv.h linux-2.6.13-rc2-mm1-19/drivers/infiniband/core/mad_priv.h
-- linux-2.6.13-rc2-mm1-18/drivers/infiniband/core/mad_priv.h	2005-07-09 17:57:55.000000000 -0400
+++ linux-2.6.13-rc2-mm1-19/drivers/infiniband/core/mad_priv.h	2005-07-10 12:12:10.000000000 -0400
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2004, 2005, Voltaire, Inc. All rights reserved.
+ * Copyright (c) 2005 Intel Corporation. All rights reserved.
+ * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -29,7 +31,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: mad_priv.h 1980 2005-03-11 22:33:53Z sean.hefty $
+ * $Id: mad_priv.h 2730 2005-06-28 16:43:03Z sean.hefty $
  */
 
 #ifndef __IB_MAD_PRIV_H__
@@ -97,10 +99,10 @@ struct ib_mad_agent_private {
 	unsigned long timeout;
 	struct list_head local_list;
 	struct work_struct local_work;
+	struct list_head rmpp_list;
 
 	atomic_t refcount;
 	wait_queue_head_t wait;
-	u8 rmpp_version;
 };
 
 struct ib_mad_snoop_private {
@@ -125,6 +127,14 @@ struct ib_mad_send_wr_private {
 	int retry;
 	int refcount;
 	enum ib_wc_status status;
+
+	/* RMPP control */
+	int last_ack;
+	int seg_num;
+	int newwin;
+	int total_seg;
+	int data_offset;
+	int pad;
 };
 
 struct ib_mad_local_private {
@@ -135,7 +145,6 @@ struct ib_mad_local_private {
 	struct ib_sge sg_list[IB_MAD_SEND_REQ_MAX_SG];
 	u64 wr_id;			/* client WR ID */
 	u64 tid;
-	int retries;
 };
 
 struct ib_mad_mgmt_method_table {
@@ -198,4 +207,17 @@ struct ib_mad_port_private {
 
 extern kmem_cache_t *ib_mad_cache;
 
+int ib_send_mad(struct ib_mad_send_wr_private *mad_send_wr);
+
+struct ib_mad_send_wr_private *
+ib_find_send_mad(struct ib_mad_agent_private *mad_agent_priv, u64 tid);
+
+void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
+			     struct ib_mad_send_wc *mad_send_wc);
+
+void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr);
+
+void ib_reset_mad_timeout(struct ib_mad_send_wr_private *mad_send_wr,
+			  int timeout_ms);
+
 #endif	/* __IB_MAD_PRIV_H__ */
diff -uprN linux-2.6.13-rc2-mm1-18/drivers/infiniband/core/mad_rmpp.c linux-2.6.13-rc2-mm1-19/drivers/infiniband/core/mad_rmpp.c
-- linux-2.6.13-rc2-mm1-18/drivers/infiniband/core/mad_rmpp.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13-rc2-mm1-19/drivers/infiniband/core/mad_rmpp.c	2005-07-06 16:52:21.000000000 -0400
@@ -0,0 +1,765 @@
+/*
+ * Copyright (c) 2005 Intel Inc. All rights reserved.
+ * Copyright (c) 2005 Voltaire, Inc. All rights reserved.
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
+ * $Id: mad_rmpp.c 1921 2005-03-02 22:58:44Z sean.hefty $
+ */
+
+#include <linux/dma-mapping.h>
+
+#include "mad_priv.h"
+#include "mad_rmpp.h"
+
+enum rmpp_state {
+	RMPP_STATE_ACTIVE,
+	RMPP_STATE_TIMEOUT,
+	RMPP_STATE_COMPLETE
+};
+
+struct mad_rmpp_recv {
+	struct ib_mad_agent_private *agent;
+	struct list_head list;
+	struct work_struct timeout_work;
+	struct work_struct cleanup_work;
+	wait_queue_head_t wait;
+	enum rmpp_state state;
+	spinlock_t lock;
+	atomic_t refcount;
+
+	struct ib_ah *ah;
+	struct ib_mad_recv_wc *rmpp_wc;
+	struct ib_mad_recv_buf *cur_seg_buf;
+	int last_ack;
+	int seg_num;
+	int newwin;
+
+	u64 tid;
+	u32 src_qp;
+	u16 slid;
+	u8 mgmt_class;
+	u8 class_version;
+	u8 method;
+};
+
+static void destroy_rmpp_recv(struct mad_rmpp_recv *rmpp_recv)
+{
+	atomic_dec(&rmpp_recv->refcount);
+	wait_event(rmpp_recv->wait, !atomic_read(&rmpp_recv->refcount));
+	ib_destroy_ah(rmpp_recv->ah);
+	kfree(rmpp_recv);
+}
+
+void ib_cancel_rmpp_recvs(struct ib_mad_agent_private *agent)
+{
+	struct mad_rmpp_recv *rmpp_recv, *temp_rmpp_recv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&agent->lock, flags);
+	list_for_each_entry(rmpp_recv, &agent->rmpp_list, list) {
+		cancel_delayed_work(&rmpp_recv->timeout_work);
+		cancel_delayed_work(&rmpp_recv->cleanup_work);
+	}
+	spin_unlock_irqrestore(&agent->lock, flags);
+
+	flush_workqueue(agent->qp_info->port_priv->wq);
+
+	list_for_each_entry_safe(rmpp_recv, temp_rmpp_recv,
+				 &agent->rmpp_list, list) {
+		list_del(&rmpp_recv->list);
+		if (rmpp_recv->state != RMPP_STATE_COMPLETE)
+			ib_free_recv_mad(rmpp_recv->rmpp_wc);
+		destroy_rmpp_recv(rmpp_recv);
+	}
+}
+
+static void recv_timeout_handler(void *data)
+{
+	struct mad_rmpp_recv *rmpp_recv = data;
+	struct ib_mad_recv_wc *rmpp_wc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rmpp_recv->agent->lock, flags);
+	if (rmpp_recv->state != RMPP_STATE_ACTIVE) {
+		spin_unlock_irqrestore(&rmpp_recv->agent->lock, flags);
+		return;
+	}
+	rmpp_recv->state = RMPP_STATE_TIMEOUT;
+	list_del(&rmpp_recv->list);
+	spin_unlock_irqrestore(&rmpp_recv->agent->lock, flags);
+
+	/* TODO: send abort. */
+	rmpp_wc = rmpp_recv->rmpp_wc;
+	destroy_rmpp_recv(rmpp_recv);
+	ib_free_recv_mad(rmpp_wc);
+}
+
+static void recv_cleanup_handler(void *data)
+{
+	struct mad_rmpp_recv *rmpp_recv = data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rmpp_recv->agent->lock, flags);
+	list_del(&rmpp_recv->list);
+	spin_unlock_irqrestore(&rmpp_recv->agent->lock, flags);
+	destroy_rmpp_recv(rmpp_recv);
+}
+
+static struct mad_rmpp_recv *
+create_rmpp_recv(struct ib_mad_agent_private *agent,
+		 struct ib_mad_recv_wc *mad_recv_wc)
+{
+	struct mad_rmpp_recv *rmpp_recv;
+	struct ib_mad_hdr *mad_hdr;
+
+	rmpp_recv = kmalloc(sizeof *rmpp_recv, GFP_KERNEL);
+	if (!rmpp_recv)
+		return NULL;
+
+	rmpp_recv->ah = ib_create_ah_from_wc(agent->agent.qp->pd,
+					     mad_recv_wc->wc,
+					     mad_recv_wc->recv_buf.grh,
+					     agent->agent.port_num);
+	if (IS_ERR(rmpp_recv->ah))
+		goto error;
+
+	rmpp_recv->agent = agent;
+	init_waitqueue_head(&rmpp_recv->wait);
+	INIT_WORK(&rmpp_recv->timeout_work, recv_timeout_handler, rmpp_recv);
+	INIT_WORK(&rmpp_recv->cleanup_work, recv_cleanup_handler, rmpp_recv);
+	spin_lock_init(&rmpp_recv->lock);
+	rmpp_recv->state = RMPP_STATE_ACTIVE;
+	atomic_set(&rmpp_recv->refcount, 1);
+
+	rmpp_recv->rmpp_wc = mad_recv_wc;
+	rmpp_recv->cur_seg_buf = &mad_recv_wc->recv_buf;
+	rmpp_recv->newwin = 1;
+	rmpp_recv->seg_num = 1;
+	rmpp_recv->last_ack = 0;
+
+	mad_hdr = &mad_recv_wc->recv_buf.mad->mad_hdr;
+	rmpp_recv->tid = mad_hdr->tid;
+	rmpp_recv->src_qp = mad_recv_wc->wc->src_qp;
+	rmpp_recv->slid = mad_recv_wc->wc->slid;
+	rmpp_recv->mgmt_class = mad_hdr->mgmt_class;
+	rmpp_recv->class_version = mad_hdr->class_version;
+	rmpp_recv->method  = mad_hdr->method;
+	return rmpp_recv;
+
+error:	kfree(rmpp_recv);
+	return NULL;
+}
+
+static inline void deref_rmpp_recv(struct mad_rmpp_recv *rmpp_recv)
+{
+	if (atomic_dec_and_test(&rmpp_recv->refcount))
+		wake_up(&rmpp_recv->wait);
+}
+
+static struct mad_rmpp_recv *
+find_rmpp_recv(struct ib_mad_agent_private *agent,
+	       struct ib_mad_recv_wc *mad_recv_wc)
+{
+	struct mad_rmpp_recv *rmpp_recv;
+	struct ib_mad_hdr *mad_hdr = &mad_recv_wc->recv_buf.mad->mad_hdr;
+
+	list_for_each_entry(rmpp_recv, &agent->rmpp_list, list) {
+		if (rmpp_recv->tid == mad_hdr->tid &&
+		    rmpp_recv->src_qp == mad_recv_wc->wc->src_qp &&
+		    rmpp_recv->slid == mad_recv_wc->wc->slid &&
+		    rmpp_recv->mgmt_class == mad_hdr->mgmt_class &&
+		    rmpp_recv->class_version == mad_hdr->class_version &&
+		    rmpp_recv->method == mad_hdr->method)
+			return rmpp_recv;
+	}
+	return NULL;
+}
+
+static struct mad_rmpp_recv *
+acquire_rmpp_recv(struct ib_mad_agent_private *agent,
+		  struct ib_mad_recv_wc *mad_recv_wc)
+{
+	struct mad_rmpp_recv *rmpp_recv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&agent->lock, flags);
+	rmpp_recv = find_rmpp_recv(agent, mad_recv_wc);
+	if (rmpp_recv)
+		atomic_inc(&rmpp_recv->refcount);
+	spin_unlock_irqrestore(&agent->lock, flags);
+	return rmpp_recv;
+}
+
+static struct mad_rmpp_recv *
+insert_rmpp_recv(struct ib_mad_agent_private *agent,
+		 struct mad_rmpp_recv *rmpp_recv)
+{
+	struct mad_rmpp_recv *cur_rmpp_recv;
+
+	cur_rmpp_recv = find_rmpp_recv(agent, rmpp_recv->rmpp_wc);
+	if (!cur_rmpp_recv)
+		list_add_tail(&rmpp_recv->list, &agent->rmpp_list);
+
+	return cur_rmpp_recv;
+}
+
+static int data_offset(u8 mgmt_class)
+{
+	if (mgmt_class == IB_MGMT_CLASS_SUBN_ADM)
+		return offsetof(struct ib_sa_mad, data);
+	else if ((mgmt_class >= IB_MGMT_CLASS_VENDOR_RANGE2_START) &&
+		 (mgmt_class <= IB_MGMT_CLASS_VENDOR_RANGE2_END))
+		return offsetof(struct ib_vendor_mad, data);
+	else
+		return offsetof(struct ib_rmpp_mad, data);
+}
+
+static void format_ack(struct ib_rmpp_mad *ack,
+		       struct ib_rmpp_mad *data,
+		       struct mad_rmpp_recv *rmpp_recv)
+{
+	unsigned long flags;
+
+	memcpy(&ack->mad_hdr, &data->mad_hdr,
+	       data_offset(data->mad_hdr.mgmt_class));
+
+	ack->mad_hdr.method ^= IB_MGMT_METHOD_RESP;
+	ack->rmpp_hdr.rmpp_type = IB_MGMT_RMPP_TYPE_ACK;
+	ib_set_rmpp_flags(&ack->rmpp_hdr, IB_MGMT_RMPP_FLAG_ACTIVE);
+
+	spin_lock_irqsave(&rmpp_recv->lock, flags);
+	rmpp_recv->last_ack = rmpp_recv->seg_num;
+	ack->rmpp_hdr.seg_num = cpu_to_be32(rmpp_recv->seg_num);
+	ack->rmpp_hdr.paylen_newwin = cpu_to_be32(rmpp_recv->newwin);
+	spin_unlock_irqrestore(&rmpp_recv->lock, flags);
+}
+
+static void ack_recv(struct mad_rmpp_recv *rmpp_recv,
+		     struct ib_mad_recv_wc *recv_wc)
+{
+	struct ib_mad_send_buf *msg;
+	struct ib_send_wr *bad_send_wr;
+	int hdr_len, ret;
+
+	hdr_len = sizeof(struct ib_mad_hdr) + sizeof(struct ib_rmpp_hdr);
+	msg = ib_create_send_mad(&rmpp_recv->agent->agent, recv_wc->wc->src_qp,
+				 recv_wc->wc->pkey_index, rmpp_recv->ah, 1,
+				 hdr_len, sizeof(struct ib_rmpp_mad) - hdr_len,
+				 GFP_KERNEL);
+	if (!msg)
+		return;
+
+	format_ack((struct ib_rmpp_mad *) msg->mad,
+		   (struct ib_rmpp_mad *) recv_wc->recv_buf.mad, rmpp_recv);
+	ret = ib_post_send_mad(&rmpp_recv->agent->agent, &msg->send_wr,
+			       &bad_send_wr);
+	if (ret)
+		ib_free_send_mad(msg);
+}
+
+static inline int get_last_flag(struct ib_mad_recv_buf *seg)
+{
+	struct ib_rmpp_mad *rmpp_mad;
+
+	rmpp_mad = (struct ib_rmpp_mad *) seg->mad;
+	return ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) & IB_MGMT_RMPP_FLAG_LAST;
+}
+
+static inline int get_seg_num(struct ib_mad_recv_buf *seg)
+{
+	struct ib_rmpp_mad *rmpp_mad;
+
+	rmpp_mad = (struct ib_rmpp_mad *) seg->mad;
+	return be32_to_cpu(rmpp_mad->rmpp_hdr.seg_num);
+}
+
+static inline struct ib_mad_recv_buf * get_next_seg(struct list_head *rmpp_list,
+						    struct ib_mad_recv_buf *seg)
+{
+	if (seg->list.next == rmpp_list)
+		return NULL;
+
+	return container_of(seg->list.next, struct ib_mad_recv_buf, list);
+}
+
+static inline int window_size(struct ib_mad_agent_private *agent)
+{
+	return max(agent->qp_info->recv_queue.max_active >> 3, 1);
+}
+
+static struct ib_mad_recv_buf * find_seg_location(struct list_head *rmpp_list,
+						  int seg_num)
+{
+        struct ib_mad_recv_buf *seg_buf;
+	int cur_seg_num;
+
+	list_for_each_entry_reverse(seg_buf, rmpp_list, list) {
+		cur_seg_num = get_seg_num(seg_buf);
+		if (seg_num > cur_seg_num)
+			return seg_buf;
+		if (seg_num == cur_seg_num)
+			break;
+	}
+	return NULL;
+}
+
+static void update_seg_num(struct mad_rmpp_recv *rmpp_recv,
+			   struct ib_mad_recv_buf *new_buf)
+{
+	struct list_head *rmpp_list = &rmpp_recv->rmpp_wc->rmpp_list;
+	
+	while (new_buf && (get_seg_num(new_buf) == rmpp_recv->seg_num + 1)) {
+		rmpp_recv->cur_seg_buf = new_buf;
+		rmpp_recv->seg_num++;
+		new_buf = get_next_seg(rmpp_list, new_buf);
+	}
+}
+
+static inline int get_mad_len(struct mad_rmpp_recv *rmpp_recv)
+{
+	struct ib_rmpp_mad *rmpp_mad;
+	int hdr_size, data_size, pad;
+
+	rmpp_mad = (struct ib_rmpp_mad *)rmpp_recv->cur_seg_buf->mad;
+
+	hdr_size = data_offset(rmpp_mad->mad_hdr.mgmt_class);
+	data_size = sizeof(struct ib_rmpp_mad) - hdr_size;
+	pad = data_size - be32_to_cpu(rmpp_mad->rmpp_hdr.paylen_newwin);
+	if (pad > data_size || pad < 0)
+		pad = 0;
+
+	return hdr_size + rmpp_recv->seg_num * data_size - pad;
+}
+
+static struct ib_mad_recv_wc * complete_rmpp(struct mad_rmpp_recv *rmpp_recv)
+{
+	struct ib_mad_recv_wc *rmpp_wc;
+
+	ack_recv(rmpp_recv, rmpp_recv->rmpp_wc);
+	if (rmpp_recv->seg_num > 1)
+		cancel_delayed_work(&rmpp_recv->timeout_work);
+
+	rmpp_wc = rmpp_recv->rmpp_wc;
+	rmpp_wc->mad_len = get_mad_len(rmpp_recv);
+	/* 10 seconds until we can find the packet lifetime */
+	queue_delayed_work(rmpp_recv->agent->qp_info->port_priv->wq,
+			   &rmpp_recv->cleanup_work, msecs_to_jiffies(10000));
+	return rmpp_wc;
+}
+
+void ib_coalesce_recv_mad(struct ib_mad_recv_wc *mad_recv_wc, void *buf)
+{
+	struct ib_mad_recv_buf *seg_buf;
+	struct ib_rmpp_mad *rmpp_mad;
+	void *data;
+	int size, len, offset;
+	u8 flags;
+
+	len = mad_recv_wc->mad_len;
+	if (len <= sizeof(struct ib_mad)) {
+		memcpy(buf, mad_recv_wc->recv_buf.mad, len);
+		return;
+	}
+
+	offset = data_offset(mad_recv_wc->recv_buf.mad->mad_hdr.mgmt_class);
+
+	list_for_each_entry(seg_buf, &mad_recv_wc->rmpp_list, list) {
+		rmpp_mad = (struct ib_rmpp_mad *)seg_buf->mad;
+		flags = ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr);
+
+		if (flags & IB_MGMT_RMPP_FLAG_FIRST) {
+			data = rmpp_mad;
+			size = sizeof(*rmpp_mad);
+		} else {
+			data = (void *) rmpp_mad + offset;
+			if (flags & IB_MGMT_RMPP_FLAG_LAST) 
+				size = len;
+			else
+				size = sizeof(*rmpp_mad) - offset;
+		}
+
+		memcpy(buf, data, size);
+		len -= size;
+		buf += size;
+	}
+}
+EXPORT_SYMBOL(ib_coalesce_recv_mad);
+
+static struct ib_mad_recv_wc *
+continue_rmpp(struct ib_mad_agent_private *agent,
+	      struct ib_mad_recv_wc *mad_recv_wc)
+{
+	struct mad_rmpp_recv *rmpp_recv;
+	struct ib_mad_recv_buf *prev_buf;
+	struct ib_mad_recv_wc *done_wc;
+	int seg_num;
+	unsigned long flags;
+
+	rmpp_recv = acquire_rmpp_recv(agent, mad_recv_wc);
+	if (!rmpp_recv)
+		goto drop1;
+
+	seg_num = get_seg_num(&mad_recv_wc->recv_buf);
+
+	spin_lock_irqsave(&rmpp_recv->lock, flags);
+	if ((rmpp_recv->state == RMPP_STATE_TIMEOUT) ||
+	    (seg_num > rmpp_recv->newwin))
+		goto drop3;
+
+	if ((seg_num <= rmpp_recv->last_ack) ||
+	    (rmpp_recv->state == RMPP_STATE_COMPLETE)) {
+		spin_unlock_irqrestore(&rmpp_recv->lock, flags);
+		ack_recv(rmpp_recv, mad_recv_wc);
+		goto drop2;
+	}
+
+	prev_buf = find_seg_location(&rmpp_recv->rmpp_wc->rmpp_list, seg_num);
+	if (!prev_buf)
+		goto drop3;
+
+	done_wc = NULL;
+	list_add(&mad_recv_wc->recv_buf.list, &prev_buf->list);
+	if (rmpp_recv->cur_seg_buf == prev_buf) {
+		update_seg_num(rmpp_recv, &mad_recv_wc->recv_buf);
+		if (get_last_flag(rmpp_recv->cur_seg_buf)) {
+			rmpp_recv->state = RMPP_STATE_COMPLETE;
+			spin_unlock_irqrestore(&rmpp_recv->lock, flags);
+			done_wc = complete_rmpp(rmpp_recv);
+			goto out;
+		} else if (rmpp_recv->seg_num == rmpp_recv->newwin) {
+			rmpp_recv->newwin += window_size(agent);
+			spin_unlock_irqrestore(&rmpp_recv->lock, flags);
+			ack_recv(rmpp_recv, mad_recv_wc);
+			goto out;
+		}
+	}
+	spin_unlock_irqrestore(&rmpp_recv->lock, flags);
+out:
+	deref_rmpp_recv(rmpp_recv);
+	return done_wc;
+
+drop3:	spin_unlock_irqrestore(&rmpp_recv->lock, flags);
+drop2:	deref_rmpp_recv(rmpp_recv);
+drop1:	ib_free_recv_mad(mad_recv_wc);
+	return NULL;
+}
+
+static struct ib_mad_recv_wc *
+start_rmpp(struct ib_mad_agent_private *agent,
+	   struct ib_mad_recv_wc *mad_recv_wc)
+{
+	struct mad_rmpp_recv *rmpp_recv;
+	unsigned long flags;
+
+	rmpp_recv = create_rmpp_recv(agent, mad_recv_wc);
+	if (!rmpp_recv) {
+		ib_free_recv_mad(mad_recv_wc);
+		return NULL;
+	}
+
+	spin_lock_irqsave(&agent->lock, flags);
+	if (insert_rmpp_recv(agent, rmpp_recv)) {
+		spin_unlock_irqrestore(&agent->lock, flags);
+		/* duplicate first MAD */
+		destroy_rmpp_recv(rmpp_recv);
+		return continue_rmpp(agent, mad_recv_wc);
+	}
+	atomic_inc(&rmpp_recv->refcount);
+
+	if (get_last_flag(&mad_recv_wc->recv_buf)) {
+		rmpp_recv->state = RMPP_STATE_COMPLETE;
+		spin_unlock_irqrestore(&agent->lock, flags);
+		complete_rmpp(rmpp_recv);
+	} else {
+		spin_unlock_irqrestore(&agent->lock, flags);
+		/* 40 seconds until we can find the packet lifetimes */
+		queue_delayed_work(agent->qp_info->port_priv->wq,
+				   &rmpp_recv->timeout_work,
+				   msecs_to_jiffies(40000));
+		rmpp_recv->newwin += window_size(agent);
+		ack_recv(rmpp_recv, mad_recv_wc);
+		mad_recv_wc = NULL;
+	}
+	deref_rmpp_recv(rmpp_recv);
+	return mad_recv_wc;
+}
+
+static inline u64 get_seg_addr(struct ib_mad_send_wr_private *mad_send_wr)
+{
+	return mad_send_wr->sg_list[0].addr + mad_send_wr->data_offset +
+	       (sizeof(struct ib_rmpp_mad) - mad_send_wr->data_offset) *
+	       (mad_send_wr->seg_num - 1);
+}
+
+static int send_next_seg(struct ib_mad_send_wr_private *mad_send_wr)
+{
+	struct ib_rmpp_mad *rmpp_mad;
+	int timeout;
+
+	rmpp_mad = (struct ib_rmpp_mad *)mad_send_wr->send_wr.wr.ud.mad_hdr;
+	ib_set_rmpp_flags(&rmpp_mad->rmpp_hdr, IB_MGMT_RMPP_FLAG_ACTIVE);
+	rmpp_mad->rmpp_hdr.seg_num = cpu_to_be32(mad_send_wr->seg_num);
+
+	if (mad_send_wr->seg_num == 1) {
+		rmpp_mad->rmpp_hdr.rmpp_rtime_flags |= IB_MGMT_RMPP_FLAG_FIRST;
+		rmpp_mad->rmpp_hdr.paylen_newwin =
+			cpu_to_be32(mad_send_wr->total_seg *
+				    (sizeof(struct ib_rmpp_mad) -
+				       offsetof(struct ib_rmpp_mad, data)));
+		mad_send_wr->sg_list[0].length = sizeof(struct ib_rmpp_mad);
+	} else {
+		mad_send_wr->send_wr.num_sge = 2;
+		mad_send_wr->sg_list[0].length = mad_send_wr->data_offset;
+		mad_send_wr->sg_list[1].addr = get_seg_addr(mad_send_wr);
+		mad_send_wr->sg_list[1].length = sizeof(struct ib_rmpp_mad) -
+						 mad_send_wr->data_offset;
+		mad_send_wr->sg_list[1].lkey = mad_send_wr->sg_list[0].lkey;
+	}
+
+	if (mad_send_wr->seg_num == mad_send_wr->total_seg) {
+		rmpp_mad->rmpp_hdr.rmpp_rtime_flags |= IB_MGMT_RMPP_FLAG_LAST;
+		rmpp_mad->rmpp_hdr.paylen_newwin =
+			cpu_to_be32(sizeof(struct ib_rmpp_mad) -
+				    offsetof(struct ib_rmpp_mad, data) -
+				    mad_send_wr->pad);
+	}
+
+	/* 2 seconds for an ACK until we can find the packet lifetime */
+	timeout = mad_send_wr->send_wr.wr.ud.timeout_ms;
+	if (!timeout || timeout > 2000)
+		mad_send_wr->timeout = msecs_to_jiffies(2000);
+	mad_send_wr->seg_num++;
+	return ib_send_mad(mad_send_wr);
+}
+
+static void process_rmpp_ack(struct ib_mad_agent_private *agent,
+			     struct ib_mad_recv_wc *mad_recv_wc)
+{
+	struct ib_mad_send_wr_private *mad_send_wr;
+	struct ib_rmpp_mad *rmpp_mad;
+	unsigned long flags;
+	int seg_num, newwin, ret;
+
+	rmpp_mad = (struct ib_rmpp_mad *)mad_recv_wc->recv_buf.mad;
+	if (rmpp_mad->rmpp_hdr.rmpp_status)
+		return;
+
+	seg_num = be32_to_cpu(rmpp_mad->rmpp_hdr.seg_num);
+	newwin = be32_to_cpu(rmpp_mad->rmpp_hdr.paylen_newwin);
+
+	spin_lock_irqsave(&agent->lock, flags);
+	mad_send_wr = ib_find_send_mad(agent, rmpp_mad->mad_hdr.tid);
+	if (!mad_send_wr)
+		goto out;	/* Unmatched ACK */
+
+	if ((mad_send_wr->last_ack == mad_send_wr->total_seg) ||
+	    (!mad_send_wr->timeout) || (mad_send_wr->status != IB_WC_SUCCESS))
+		goto out;	/* Send is already done */
+
+	if (seg_num > mad_send_wr->total_seg)
+		goto out;	/* Bad ACK */
+
+	if (newwin < mad_send_wr->newwin || seg_num < mad_send_wr->last_ack)
+		goto out;	/* Old ACK */
+
+	if (seg_num > mad_send_wr->last_ack) {
+		mad_send_wr->last_ack = seg_num;
+		mad_send_wr->retries = mad_send_wr->send_wr.wr.ud.retries;
+	}
+	mad_send_wr->newwin = newwin;
+	if (mad_send_wr->last_ack == mad_send_wr->total_seg) {
+		/* If no response is expected, the ACK completes the send */
+		if (!mad_send_wr->send_wr.wr.ud.timeout_ms) {
+			struct ib_mad_send_wc wc;
+
+			ib_mark_mad_done(mad_send_wr);
+			spin_unlock_irqrestore(&agent->lock, flags);
+
+			wc.status = IB_WC_SUCCESS;
+			wc.vendor_err = 0;
+			wc.wr_id = mad_send_wr->wr_id;
+			ib_mad_complete_send_wr(mad_send_wr, &wc);
+			return;
+		}
+		if (mad_send_wr->refcount == 1)
+			ib_reset_mad_timeout(mad_send_wr, mad_send_wr->
+					     send_wr.wr.ud.timeout_ms);
+	} else if (mad_send_wr->refcount == 1 &&
+		   mad_send_wr->seg_num < mad_send_wr->newwin &&
+		   mad_send_wr->seg_num <= mad_send_wr->total_seg) {
+		/* Send failure will just result in a timeout/retry */
+		ret = send_next_seg(mad_send_wr);
+		if (ret)
+			goto out;
+
+		mad_send_wr->refcount++;
+		list_del(&mad_send_wr->agent_list);
+		list_add_tail(&mad_send_wr->agent_list,
+			      &mad_send_wr->mad_agent_priv->send_list);
+	}
+out:
+	spin_unlock_irqrestore(&agent->lock, flags);
+}
+
+struct ib_mad_recv_wc *
+ib_process_rmpp_recv_wc(struct ib_mad_agent_private *agent,
+			struct ib_mad_recv_wc *mad_recv_wc)
+{
+	struct ib_rmpp_mad *rmpp_mad;
+
+	rmpp_mad = (struct ib_rmpp_mad *)mad_recv_wc->recv_buf.mad;
+	if (!(rmpp_mad->rmpp_hdr.rmpp_rtime_flags & IB_MGMT_RMPP_FLAG_ACTIVE))
+		return mad_recv_wc;
+
+	if (rmpp_mad->rmpp_hdr.rmpp_version != IB_MGMT_RMPP_VERSION)
+		goto out;
+
+	switch (rmpp_mad->rmpp_hdr.rmpp_type) {
+	case IB_MGMT_RMPP_TYPE_DATA:
+		if (rmpp_mad->rmpp_hdr.seg_num == __constant_htonl(1))
+			return start_rmpp(agent, mad_recv_wc);
+		else
+			return continue_rmpp(agent, mad_recv_wc);
+	case IB_MGMT_RMPP_TYPE_ACK:
+		process_rmpp_ack(agent, mad_recv_wc);
+		break;
+	case IB_MGMT_RMPP_TYPE_STOP:
+	case IB_MGMT_RMPP_TYPE_ABORT:
+		/* TODO: process_rmpp_nack(agent, mad_recv_wc); */
+		break;
+	default:
+		break;
+	}
+out:
+	ib_free_recv_mad(mad_recv_wc);
+	return NULL;
+}
+
+int ib_send_rmpp_mad(struct ib_mad_send_wr_private *mad_send_wr)
+{
+	struct ib_rmpp_mad *rmpp_mad;
+	int i, total_len, ret;
+
+	rmpp_mad = (struct ib_rmpp_mad *)mad_send_wr->send_wr.wr.ud.mad_hdr;
+	if (!(ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) &
+	      IB_MGMT_RMPP_FLAG_ACTIVE))
+		return IB_RMPP_RESULT_UNHANDLED;
+
+	if (rmpp_mad->rmpp_hdr.rmpp_type != IB_MGMT_RMPP_TYPE_DATA)
+		return IB_RMPP_RESULT_INTERNAL;
+
+	if (mad_send_wr->send_wr.num_sge > 1)
+		return -EINVAL;		/* TODO: support num_sge > 1 */
+
+	mad_send_wr->seg_num = 1;
+	mad_send_wr->newwin = 1;
+	mad_send_wr->data_offset = data_offset(rmpp_mad->mad_hdr.mgmt_class);
+
+	total_len = 0;
+	for (i = 0; i < mad_send_wr->send_wr.num_sge; i++)
+		total_len += mad_send_wr->send_wr.sg_list[i].length;
+
+        mad_send_wr->total_seg = (total_len - mad_send_wr->data_offset) /
+			(sizeof(struct ib_rmpp_mad) - mad_send_wr->data_offset);
+	mad_send_wr->pad = total_len - offsetof(struct ib_rmpp_mad, data) -
+			   be32_to_cpu(rmpp_mad->rmpp_hdr.paylen_newwin);
+
+	/* We need to wait for the final ACK even if there isn't a response */
+	mad_send_wr->refcount += (mad_send_wr->timeout == 0);
+	ret = send_next_seg(mad_send_wr);
+	if (!ret)
+		return IB_RMPP_RESULT_CONSUMED;
+	return ret;
+}
+
+int ib_process_rmpp_send_wc(struct ib_mad_send_wr_private *mad_send_wr,
+			    struct ib_mad_send_wc *mad_send_wc)
+{
+	struct ib_rmpp_mad *rmpp_mad;
+	struct ib_mad_send_buf *msg;
+	int ret;
+
+	rmpp_mad = (struct ib_rmpp_mad *)mad_send_wr->send_wr.wr.ud.mad_hdr;
+	if (!(ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) & 
+	      IB_MGMT_RMPP_FLAG_ACTIVE))
+		return IB_RMPP_RESULT_UNHANDLED; /* RMPP not active */
+
+	if (rmpp_mad->rmpp_hdr.rmpp_type != IB_MGMT_RMPP_TYPE_DATA) {
+		msg = (struct ib_mad_send_buf *) (unsigned long)
+		      mad_send_wc->wr_id;
+		ib_free_send_mad(msg);
+		return IB_RMPP_RESULT_INTERNAL;	 /* ACK, STOP, or ABORT */
+	}
+
+	if (mad_send_wc->status != IB_WC_SUCCESS ||
+	    mad_send_wr->status != IB_WC_SUCCESS)
+		return IB_RMPP_RESULT_PROCESSED; /* Canceled or send error */
+
+	if (!mad_send_wr->timeout)
+		return IB_RMPP_RESULT_PROCESSED; /* Response received */
+
+	if (mad_send_wr->last_ack == mad_send_wr->total_seg) {
+		mad_send_wr->timeout =
+			msecs_to_jiffies(mad_send_wr->send_wr.wr.ud.timeout_ms);
+		return IB_RMPP_RESULT_PROCESSED; /* Send done */
+	}
+
+	if (mad_send_wr->seg_num > mad_send_wr->newwin ||
+	    mad_send_wr->seg_num > mad_send_wr->total_seg)
+		return IB_RMPP_RESULT_PROCESSED; /* Wait for ACK */
+
+	ret = send_next_seg(mad_send_wr);
+	if (ret) {
+		mad_send_wc->status = IB_WC_GENERAL_ERR;
+		return IB_RMPP_RESULT_PROCESSED;
+	}
+	return IB_RMPP_RESULT_CONSUMED;
+}
+
+int ib_retry_rmpp(struct ib_mad_send_wr_private *mad_send_wr)
+{
+	struct ib_rmpp_mad *rmpp_mad;
+	int ret;
+
+	rmpp_mad = (struct ib_rmpp_mad *)mad_send_wr->send_wr.wr.ud.mad_hdr;
+	if (!(ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) & 
+	      IB_MGMT_RMPP_FLAG_ACTIVE))
+		return IB_RMPP_RESULT_UNHANDLED; /* RMPP not active */
+
+	if (mad_send_wr->last_ack == mad_send_wr->total_seg)
+		return IB_RMPP_RESULT_PROCESSED;
+
+	mad_send_wr->seg_num = mad_send_wr->last_ack + 1;
+	ret = send_next_seg(mad_send_wr);
+	if (ret)
+		return IB_RMPP_RESULT_PROCESSED;
+
+	return IB_RMPP_RESULT_CONSUMED;
+}
diff -uprN linux-2.6.13-rc2-mm1-18/drivers/infiniband/core/mad_rmpp.h linux-2.6.13-rc2-mm1-19/drivers/infiniband/core/mad_rmpp.h
-- linux-2.6.13-rc2-mm1-18/drivers/infiniband/core/mad_rmpp.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13-rc2-mm1-19/drivers/infiniband/core/mad_rmpp.h	2005-07-06 16:55:32.000000000 -0400
@@ -0,0 +1,58 @@
+/*
+ * Copyright (c) 2005 Intel Inc. All rights reserved.
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
+ * $Id: mad_rmpp.h 1921 2005-02-25 22:58:44Z sean.hefty $
+ */
+
+#ifndef __MAD_RMPP_H__
+#define __MAD_RMPP_H__
+
+enum {
+	IB_RMPP_RESULT_PROCESSED,
+	IB_RMPP_RESULT_CONSUMED,
+	IB_RMPP_RESULT_INTERNAL,
+	IB_RMPP_RESULT_UNHANDLED
+};
+
+int ib_send_rmpp_mad(struct ib_mad_send_wr_private *mad_send_wr);
+
+struct ib_mad_recv_wc *
+ib_process_rmpp_recv_wc(struct ib_mad_agent_private *agent,
+			struct ib_mad_recv_wc *mad_recv_wc);
+
+int ib_process_rmpp_send_wc(struct ib_mad_send_wr_private *mad_send_wr,
+			    struct ib_mad_send_wc *mad_send_wc);
+
+void ib_cancel_rmpp_recvs(struct ib_mad_agent_private *agent);
+
+int ib_retry_rmpp(struct ib_mad_send_wr_private *mad_send_wr);
+
+#endif	/* __MAD_RMPP_H__ */
diff -uprN linux-2.6.13-rc2-mm1-18/drivers/infiniband/core/Makefile linux-2.6.13-rc2-mm1-19/drivers/infiniband/core/Makefile
-- linux-2.6.13-rc2-mm1-18/drivers/infiniband/core/Makefile	2005-07-10 16:30:24.000000000 -0400
+++ linux-2.6.13-rc2-mm1-19/drivers/infiniband/core/Makefile	2005-07-10 16:32:15.000000000 -0400
@@ -6,7 +6,7 @@ obj-$(CONFIG_INFINIBAND_USER_VERBS) +=	i
 ib_core-y :=			packer.o ud_header.o verbs.o sysfs.o \
 				device.o fmr_pool.o cache.o
 
-ib_mad-y :=			mad.o smi.o agent.o
+ib_mad-y :=			mad.o smi.o agent.o mad_rmpp.o
 
 ib_sa-y :=			sa_query.o
 


