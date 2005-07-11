Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVGKOas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVGKOas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVGKO2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:28:35 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:32966 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261842AbVGKO2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:28:15 -0400
Subject: [PATCH 13/27] Add ib_modify_mad API to MAD
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121089121.4389.4531.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 10:20:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add new MAD layer call to modify (ib_modify_mad) the timeout of a sent 
MAD, and simplify cancel code.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 12/27.

-- 
 core/mad.c       |   83 ++++++++++++++++++--
 core/mad_priv.h  |    2 -
 include/ib_mad.h |   14 +++++++--
 3 files changed, 40 insertions(+), 59 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband12/core/mad.c linux-2.6.13-rc2-mm1/drivers/infiniband13/core/mad.c
-- linux-2.6.13-rc2-mm1/drivers/infiniband12/core/mad.c	2005-07-09 17:46:10.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband13/core/mad.c	2005-07-09 18:16:36.000000000 -0400
@@ -65,7 +65,6 @@ static void cancel_mads(struct ib_mad_ag
 static void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
 				    struct ib_mad_send_wc *mad_send_wc);
 static void timeout_sends(void *data);
-static void cancel_sends(void *data);
 static void local_completions(void *data);
 static int add_nonoui_reg_req(struct ib_mad_reg_req *mad_reg_req,
 			      struct ib_mad_agent_private *agent_priv,
@@ -346,8 +345,6 @@ struct ib_mad_agent *ib_register_mad_age
 	INIT_LIST_HEAD(&mad_agent_priv->local_list);
 	INIT_WORK(&mad_agent_priv->local_work, local_completions,
 		   mad_agent_priv);
-	INIT_LIST_HEAD(&mad_agent_priv->canceled_list);
-	INIT_WORK(&mad_agent_priv->canceled_work, cancel_sends, mad_agent_priv);
 	atomic_set(&mad_agent_priv->refcount, 1);
 	init_waitqueue_head(&mad_agent_priv->wait);
 
@@ -1775,6 +1772,13 @@ static void wait_for_response(struct ib_
 	}
 }
 
+void ib_reset_mad_timeout(struct ib_mad_send_wr_private *mad_send_wr,
+			  int timeout_ms)
+{
+	mad_send_wr->timeout = msecs_to_jiffies(timeout_ms);
+	wait_for_response(mad_send_wr);
+}
+
 /*
  * Process a send work completion
  */
@@ -2034,41 +2038,7 @@ find_send_by_wr_id(struct ib_mad_agent_p
 	return NULL;
 }
 
-void cancel_sends(void *data)
-{
-	struct ib_mad_agent_private *mad_agent_priv;
-	struct ib_mad_send_wr_private *mad_send_wr;
-	struct ib_mad_send_wc mad_send_wc;
-	unsigned long flags;
-
-	mad_agent_priv = data;
-
-	mad_send_wc.status = IB_WC_WR_FLUSH_ERR;
-	mad_send_wc.vendor_err = 0;
-
-	spin_lock_irqsave(&mad_agent_priv->lock, flags);
-	while (!list_empty(&mad_agent_priv->canceled_list)) {
-		mad_send_wr = list_entry(mad_agent_priv->canceled_list.next,
-					 struct ib_mad_send_wr_private,
-					 agent_list);
-
-		list_del(&mad_send_wr->agent_list);
-		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
-
-		mad_send_wc.wr_id = mad_send_wr->wr_id;
-		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
-						   &mad_send_wc);
-
-		kfree(mad_send_wr);
-		if (atomic_dec_and_test(&mad_agent_priv->refcount))
-			wake_up(&mad_agent_priv->wait);
-		spin_lock_irqsave(&mad_agent_priv->lock, flags);
-	}
-	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
-}
-
-void ib_cancel_mad(struct ib_mad_agent *mad_agent,
-		  u64 wr_id)
+int ib_modify_mad(struct ib_mad_agent *mad_agent, u64 wr_id, u32 timeout_ms)
 {
 	struct ib_mad_agent_private *mad_agent_priv;
 	struct ib_mad_send_wr_private *mad_send_wr;
@@ -2078,29 +2048,30 @@ void ib_cancel_mad(struct ib_mad_agent *
 				      agent);
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
 	mad_send_wr = find_send_by_wr_id(mad_agent_priv, wr_id);
-	if (!mad_send_wr) {
+	if (!mad_send_wr || mad_send_wr->status != IB_WC_SUCCESS) {
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
-		goto out;
+		return -EINVAL;
 	}
 
-	if (mad_send_wr->status == IB_WC_SUCCESS)
-		mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
-
-	if (mad_send_wr->refcount != 0) {
+	if (!timeout_ms) {
 		mad_send_wr->status = IB_WC_WR_FLUSH_ERR;
-		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
-		goto out;
+		mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
 	}
 
-	list_del(&mad_send_wr->agent_list);
-	list_add_tail(&mad_send_wr->agent_list, &mad_agent_priv->canceled_list);
-	adjust_timeout(mad_agent_priv);
+	mad_send_wr->send_wr.wr.ud.timeout_ms = timeout_ms;
+	if (!mad_send_wr->timeout || mad_send_wr->refcount > 1)
+		mad_send_wr->timeout = msecs_to_jiffies(timeout_ms);
+	else
+		ib_reset_mad_timeout(mad_send_wr, timeout_ms);
+
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL(ib_modify_mad);
 
-	queue_work(mad_agent_priv->qp_info->port_priv->wq,
-		   &mad_agent_priv->canceled_work);
-out:
-	return;
+void ib_cancel_mad(struct ib_mad_agent *mad_agent, u64 wr_id)
+{
+	ib_modify_mad(mad_agent, wr_id, 0);
 }
 EXPORT_SYMBOL(ib_cancel_mad);
 
@@ -2207,8 +2178,6 @@ static void timeout_sends(void *data)
 	unsigned long flags, delay;
 
 	mad_agent_priv = (struct ib_mad_agent_private *)data;
-
-	mad_send_wc.status = IB_WC_RESP_TIMEOUT_ERR;
 	mad_send_wc.vendor_err = 0;
 
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
@@ -2233,6 +2202,10 @@ static void timeout_sends(void *data)
 
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
+		if (mad_send_wr->status == IB_WC_SUCCESS)
+			mad_send_wc.status = IB_WC_RESP_TIMEOUT_ERR;
+		else
+			mad_send_wc.status = mad_send_wr->status;
 		mad_send_wc.wr_id = mad_send_wr->wr_id;
 		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
 						   &mad_send_wc);
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband12/core/mad_priv.h linux-2.6.13-rc2-mm1/drivers/infiniband13/core/mad_priv.h
-- linux-2.6.13-rc2-mm1/drivers/infiniband12/core/mad_priv.h	2005-07-09 17:15:40.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband13/core/mad_priv.h	2005-07-09 17:57:55.000000000 -0400
@@ -97,8 +97,6 @@ struct ib_mad_agent_private {
 	unsigned long timeout;
 	struct list_head local_list;
 	struct work_struct local_work;
-	struct list_head canceled_list;
-	struct work_struct canceled_work;
 
 	atomic_t refcount;
 	wait_queue_head_t wait;
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband12/include/ib_mad.h linux-2.6.13-rc2-mm1/drivers/infiniband13/include/ib_mad.h
-- linux-2.6.13-rc2-mm1/drivers/infiniband12/include/ib_mad.h	2005-07-09 16:59:22.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband13/include/ib_mad.h	2005-07-09 17:57:11.000000000 -0400
@@ -385,8 +385,18 @@ void ib_free_recv_mad(struct ib_mad_recv
  * MADs will be returned to the user through the corresponding
  * ib_mad_send_handler.
  */
-void ib_cancel_mad(struct ib_mad_agent *mad_agent,
-		   u64 wr_id);
+void ib_cancel_mad(struct ib_mad_agent *mad_agent, u64 wr_id);
+
+/**
+ * ib_modify_mad - Modifies an outstanding send MAD operation.
+ * @mad_agent: Specifies the registration associated with sent MAD.
+ * @wr_id: Indicates the work request identifier of the MAD to modify.
+ * @timeout_ms: New timeout value for sent MAD.
+ *
+ * This call will reset the timeout value for a sent MAD to the specified
+ * value.
+ */
+int ib_modify_mad(struct ib_mad_agent *mad_agent, u64 wr_id, u32 timeout_ms);
 
 /**
  * ib_redirect_mad_qp - Registers a QP for MAD services.


