Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVALV75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVALV75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVALV55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:57:57 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261496AbVALVsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:32 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121348.wTtIj6K84YZQwY0U@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:48:07 -0800
Message-Id: <20051121348.Xc0vsayRkBF6BIqu@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][12/18] InfiniBand/core: fix handling of 0-hop directed route MADs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:48:08.0141 (UTC) FILETIME=[67419FD0:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle outgoing DR 0 hop SMPs properly when provider returns just
SUCCESS to process_mad.

Signed-off-by: Hal Rosenstock <halr@voltaire.com>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/core/mad.c	(revision 1501)
+++ linux/drivers/infiniband/core/mad.c	(revision 1502)
@@ -60,6 +60,9 @@
 static int method_in_use(struct ib_mad_mgmt_method_table **method,
 			 struct ib_mad_reg_req *mad_reg_req);
 static void remove_mad_reg_req(struct ib_mad_agent_private *priv);
+static struct ib_mad_agent_private *find_mad_agent(
+					struct ib_mad_port_private *port_priv,
+					struct ib_mad *mad, int solicited);
 static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 				    struct ib_mad_private *mad);
 static void cancel_mads(struct ib_mad_agent_private *mad_agent_priv);
@@ -623,10 +626,12 @@
 				  struct ib_smp *smp,
 				  struct ib_send_wr *send_wr)
 {
-	int ret, alloc_flags;
+	int ret, alloc_flags, solicited;
 	unsigned long flags;
 	struct ib_mad_local_private *local;
 	struct ib_mad_private *mad_priv;
+	struct ib_mad_port_private *port_priv;
+	struct ib_mad_agent_private *recv_mad_agent = NULL;
 	struct ib_device *device = mad_agent_priv->agent.device;
 	u8 port_num = mad_agent_priv->agent.port_num;
 
@@ -651,6 +656,7 @@
 		goto out;
 	}
 	local->mad_priv = NULL;
+	local->recv_mad_agent = NULL;
 	mad_priv = kmem_cache_alloc(ib_mad_cache, alloc_flags);
 	if (!mad_priv) {
 		ret = -ENOMEM;
@@ -669,19 +675,41 @@
 		 * there is a recv handler
 		 */
 		if (solicited_mad(&mad_priv->mad.mad) &&
-		    mad_agent_priv->agent.recv_handler)
+		    mad_agent_priv->agent.recv_handler) {
 			local->mad_priv = mad_priv;
-		else
+			local->recv_mad_agent = mad_agent_priv;
+			/*
+			 * Reference MAD agent until receive 
+			 * side of local completion handled
+			 */
+			atomic_inc(&mad_agent_priv->refcount);
+		} else
 			kmem_cache_free(ib_mad_cache, mad_priv);
 		break;
 	case IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED:
 		kmem_cache_free(ib_mad_cache, mad_priv);
 		break;
 	case IB_MAD_RESULT_SUCCESS:
-		kmem_cache_free(ib_mad_cache, mad_priv);
-		kfree(local);
-		ret = 0;
-		goto out;
+		/* Treat like an incoming receive MAD */
+		solicited = solicited_mad(&mad_priv->mad.mad);
+		port_priv = ib_get_mad_port(mad_agent_priv->agent.device,
+					    mad_agent_priv->agent.port_num);
+		if (port_priv) {
+			mad_priv->mad.mad.mad_hdr.tid =
+				((struct ib_mad *)smp)->mad_hdr.tid;
+			recv_mad_agent = find_mad_agent(port_priv,
+						       &mad_priv->mad.mad,
+							solicited);
+		}
+		if (!port_priv || !recv_mad_agent) {
+			kmem_cache_free(ib_mad_cache, mad_priv);
+			kfree(local);
+			ret = 0;
+			goto out;
+		}
+		local->mad_priv = mad_priv;
+		local->recv_mad_agent = recv_mad_agent;
+		break;
 	default:
 		kmem_cache_free(ib_mad_cache, mad_priv);
 		kfree(local);
@@ -696,7 +724,7 @@
 	local->send_wr.next = NULL;
 	local->tid = send_wr->wr.ud.mad_hdr->tid;
 	local->wr_id = send_wr->wr_id;
-	/* Reference MAD agent until local completion handled */
+	/* Reference MAD agent until send side of local completion handled */
 	atomic_inc(&mad_agent_priv->refcount);
 	/* Queue local completion to local list */
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
@@ -1997,6 +2025,7 @@
 {
 	struct ib_mad_agent_private *mad_agent_priv;
 	struct ib_mad_local_private *local;
+	struct ib_mad_agent_private *recv_mad_agent;
 	unsigned long flags;
 	struct ib_wc wc;
 	struct ib_mad_send_wc mad_send_wc;
@@ -2010,6 +2039,13 @@
 				   completion_list);
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 		if (local->mad_priv) {
+			recv_mad_agent = local->recv_mad_agent;
+			if (!recv_mad_agent) {
+				printk(KERN_ERR PFX "No receive MAD agent for local completion\n");
+				kmem_cache_free(ib_mad_cache, local->mad_priv);
+				goto local_send_completion;
+			}
+
 			/*
 			 * Defined behavior is to complete response
 			 * before request
@@ -2034,15 +2070,19 @@
 			local->mad_priv->header.recv_wc.recv_buf.grh = NULL;
 			local->mad_priv->header.recv_wc.recv_buf.mad =
 						&local->mad_priv->mad.mad;
-			if (atomic_read(&mad_agent_priv->qp_info->snoop_count))
-				snoop_recv(mad_agent_priv->qp_info,
+			if (atomic_read(&recv_mad_agent->qp_info->snoop_count))
+				snoop_recv(recv_mad_agent->qp_info,
 					  &local->mad_priv->header.recv_wc,
 					   IB_MAD_SNOOP_RECVS);
-			mad_agent_priv->agent.recv_handler(
-						&mad_agent_priv->agent,
+			recv_mad_agent->agent.recv_handler(
+						&recv_mad_agent->agent,
 						&local->mad_priv->header.recv_wc);
+			spin_lock_irqsave(&recv_mad_agent->lock, flags);
+			atomic_dec(&recv_mad_agent->refcount);
+			spin_unlock_irqrestore(&recv_mad_agent->lock, flags);
 		}
 
+local_send_completion:
 		/* Complete send */
 		mad_send_wc.status = IB_WC_SUCCESS;
 		mad_send_wc.vendor_err = 0;
--- linux/drivers/infiniband/core/mad_priv.h	(revision 1501)
+++ linux/drivers/infiniband/core/mad_priv.h	(revision 1502)
@@ -127,6 +127,7 @@
 struct ib_mad_local_private {
 	struct list_head completion_list;
 	struct ib_mad_private *mad_priv;
+	struct ib_mad_agent_private *recv_mad_agent;
 	struct ib_send_wr send_wr;
 	struct ib_sge sg_list[IB_MAD_SEND_REQ_MAX_SG];
 	u64 wr_id;			/* client WR ID */

