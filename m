Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVGKOCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVGKOCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVGKOA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:00:28 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:43717 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261715AbVGKN7K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:59:10 -0400
Subject: [PATCH 4/27] Combine some MAD routines
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121089083.4389.4513.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 09:51:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Combine response_mad() and solicited_mad() routines into a single
function and simplify/encapsulate its usage.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 3/27.

-- 
 mad.c |  105 ++++++++++++++++--
 1 files changed, 27 insertions(+), 78 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband3/core/mad.c linux-2.6.13-rc2-mm1/drivers/infiniband4/core/mad.c
-- linux-2.6.13-rc2-mm1/drivers/infiniband3/core/mad.c	2005-07-09 14:31:49.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband4/core/mad.c	2005-07-09 15:06:29.000000000 -0400
@@ -58,7 +58,7 @@ static int method_in_use(struct ib_mad_m
 static void remove_mad_reg_req(struct ib_mad_agent_private *priv);
 static struct ib_mad_agent_private *find_mad_agent(
 					struct ib_mad_port_private *port_priv,
-					struct ib_mad *mad, int solicited);
+					struct ib_mad *mad);
 static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 				    struct ib_mad_private *mad);
 static void cancel_mads(struct ib_mad_agent_private *mad_agent_priv);
@@ -67,7 +67,6 @@ static void ib_mad_complete_send_wr(stru
 static void timeout_sends(void *data);
 static void cancel_sends(void *data);
 static void local_completions(void *data);
-static int solicited_mad(struct ib_mad *mad);
 static int add_nonoui_reg_req(struct ib_mad_reg_req *mad_reg_req,
 			      struct ib_mad_agent_private *agent_priv,
 			      u8 mgmt_class);
@@ -558,6 +557,13 @@ int ib_unregister_mad_agent(struct ib_ma
 }
 EXPORT_SYMBOL(ib_unregister_mad_agent);
 
+static inline int response_mad(struct ib_mad *mad)
+{
+	/* Trap represses are responses although response bit is reset */
+	return ((mad->mad_hdr.method == IB_MGMT_METHOD_TRAP_REPRESS) ||
+		(mad->mad_hdr.method & IB_MGMT_METHOD_RESP));
+}
+
 static void dequeue_mad(struct ib_mad_list_head *mad_list)
 {
 	struct ib_mad_queue *mad_queue;
@@ -650,7 +656,7 @@ static int handle_outgoing_dr_smp(struct
 				  struct ib_smp *smp,
 				  struct ib_send_wr *send_wr)
 {
-	int ret, solicited;
+	int ret;
 	unsigned long flags;
 	struct ib_mad_local_private *local;
 	struct ib_mad_private *mad_priv;
@@ -696,11 +702,7 @@ static int handle_outgoing_dr_smp(struct
 	switch (ret)
 	{
 	case IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY:
-		/*
-		 * See if response is solicited and
-		 * there is a recv handler
-		 */
-		if (solicited_mad(&mad_priv->mad.mad) &&
+		if (response_mad(&mad_priv->mad.mad) &&
 		    mad_agent_priv->agent.recv_handler) {
 			local->mad_priv = mad_priv;
 			local->recv_mad_agent = mad_agent_priv;
@@ -717,15 +719,13 @@ static int handle_outgoing_dr_smp(struct
 		break;
 	case IB_MAD_RESULT_SUCCESS:
 		/* Treat like an incoming receive MAD */
-		solicited = solicited_mad(&mad_priv->mad.mad);
 		port_priv = ib_get_mad_port(mad_agent_priv->agent.device,
 					    mad_agent_priv->agent.port_num);
 		if (port_priv) {
 			mad_priv->mad.mad.mad_hdr.tid =
 				((struct ib_mad *)smp)->mad_hdr.tid;
 			recv_mad_agent = find_mad_agent(port_priv,
-						       &mad_priv->mad.mad,
-							solicited);
+						        &mad_priv->mad.mad);
 		}
 		if (!port_priv || !recv_mad_agent) {
 			kmem_cache_free(ib_mad_cache, mad_priv);
@@ -1421,42 +1421,15 @@ out:
 	return;
 }
 
-static int response_mad(struct ib_mad *mad)
-{
-	/* Trap represses are responses although response bit is reset */
-	return ((mad->mad_hdr.method == IB_MGMT_METHOD_TRAP_REPRESS) ||
-		(mad->mad_hdr.method & IB_MGMT_METHOD_RESP));
-}
-
-static int solicited_mad(struct ib_mad *mad)
-{
-	/* CM MADs are never solicited */
-	if (mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_CM) {
-		return 0;
-	}
-
-	/* XXX: Determine whether MAD is using RMPP */
-
-	/* Not using RMPP */
-	/* Is this MAD a response to a previous MAD ? */
-	return response_mad(mad);
-}
-
 static struct ib_mad_agent_private *
 find_mad_agent(struct ib_mad_port_private *port_priv,
-	       struct ib_mad *mad,
-	       int solicited)
+	       struct ib_mad *mad)
 {
 	struct ib_mad_agent_private *mad_agent = NULL;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port_priv->reg_lock, flags);
-
-	/*
-	 * Whether MAD was solicited determines type of routing to
-	 * MAD client.
-	 */
-	if (solicited) {
+	if (response_mad(mad)) {
 		u32 hi_tid;
 		struct ib_mad_agent_private *entry;
 
@@ -1560,18 +1533,6 @@ out:
 	return valid;
 }
 
-/*
- * Return start of fully reassembled MAD, or NULL, if MAD isn't assembled yet
- */
-static struct ib_mad_private *
-reassemble_recv(struct ib_mad_agent_private *mad_agent_priv,
-		struct ib_mad_private *recv)
-{
-	/* Until we have RMPP, all receives are reassembled!... */
-	INIT_LIST_HEAD(&recv->header.recv_wc.recv_buf.list);
-	return recv;
-}
-
 static struct ib_mad_send_wr_private*
 find_send_req(struct ib_mad_agent_private *mad_agent_priv,
 	      u64 tid)
@@ -1600,29 +1561,22 @@ find_send_req(struct ib_mad_agent_privat
 }
 
 static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
-				 struct ib_mad_private *recv,
-				 int solicited)
+				 struct ib_mad_recv_wc *mad_recv_wc)
 {
 	struct ib_mad_send_wr_private *mad_send_wr;
 	struct ib_mad_send_wc mad_send_wc;
 	unsigned long flags;
+	u64 tid;
 
-	/* Fully reassemble receive before processing */
-	recv = reassemble_recv(mad_agent_priv, recv);
-	if (!recv) {
-		if (atomic_dec_and_test(&mad_agent_priv->refcount))
-			wake_up(&mad_agent_priv->wait);
-		return;
-	}
-
+	INIT_LIST_HEAD(&mad_recv_wc->recv_buf.list);
 	/* Complete corresponding request */
-	if (solicited) {
+	if (response_mad(mad_recv_wc->recv_buf.mad)) {
+		tid = mad_recv_wc->recv_buf.mad->mad_hdr.tid;
 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
-		mad_send_wr = find_send_req(mad_agent_priv,
-					    recv->mad.mad.mad_hdr.tid);
+		mad_send_wr = find_send_req(mad_agent_priv, tid);
 		if (!mad_send_wr) {
 			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
-			ib_free_recv_mad(&recv->header.recv_wc);
+			ib_free_recv_mad(mad_recv_wc);
 			if (atomic_dec_and_test(&mad_agent_priv->refcount))
 				wake_up(&mad_agent_priv->wait);
 			return;
@@ -1632,10 +1586,9 @@ static void ib_mad_complete_recv(struct 
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
 		/* Defined behavior is to complete response before request */
-		recv->header.recv_wc.wc->wr_id = mad_send_wr->wr_id;
-		mad_agent_priv->agent.recv_handler(
-						&mad_agent_priv->agent,
-						&recv->header.recv_wc);
+		mad_recv_wc->wc->wr_id = mad_send_wr->wr_id;
+		mad_agent_priv->agent.recv_handler(&mad_agent_priv->agent,
+						   mad_recv_wc);
 		atomic_dec(&mad_agent_priv->refcount);
 
 		mad_send_wc.status = IB_WC_SUCCESS;
@@ -1643,9 +1596,8 @@ static void ib_mad_complete_recv(struct 
 		mad_send_wc.wr_id = mad_send_wr->wr_id;
 		ib_mad_complete_send_wr(mad_send_wr, &mad_send_wc);
 	} else {
-		mad_agent_priv->agent.recv_handler(
-						&mad_agent_priv->agent,
-						&recv->header.recv_wc);
+		mad_agent_priv->agent.recv_handler(&mad_agent_priv->agent,
+						   mad_recv_wc);
 		if (atomic_dec_and_test(&mad_agent_priv->refcount))
 			wake_up(&mad_agent_priv->wait);
 	}
@@ -1659,7 +1611,6 @@ static void ib_mad_recv_done_handler(str
 	struct ib_mad_private *recv, *response;
 	struct ib_mad_list_head *mad_list;
 	struct ib_mad_agent_private *mad_agent;
-	int solicited;
 
 	response = kmem_cache_alloc(ib_mad_cache, GFP_KERNEL);
 	if (!response)
@@ -1745,11 +1696,9 @@ local:
 		}
 	}
 
-	/* Determine corresponding MAD agent for incoming receive MAD */
-	solicited = solicited_mad(&recv->mad.mad);
-	mad_agent = find_mad_agent(port_priv, &recv->mad.mad, solicited);
+	mad_agent = find_mad_agent(port_priv, &recv->mad.mad);
 	if (mad_agent) {
-		ib_mad_complete_recv(mad_agent, recv, solicited);
+		ib_mad_complete_recv(mad_agent, &recv->header.recv_wc);
 		/*
 		 * recv is freed up in error cases in ib_mad_complete_recv
 		 * or via recv_handler in ib_mad_complete_recv()


