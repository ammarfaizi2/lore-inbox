Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbVCCXfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVCCXfi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbVCCX1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:27:44 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56054 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262750AbVCCXWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:35 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][26/26] IB: MAD cancel callbacks from thread
In-Reply-To: <2005331520.mctunM7QrSZHM8mX@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:28 -0800
Message-Id: <2005331520.zA1xypugai2bUq7X@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:28.0675 (UTC) FILETIME=[96538530:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Hefty <sean.hefty@intel.com>

Modify ib_cancel_mad() to invoke a user's send completion callback from
a different thread context than that used by the caller.  This allows a
caller to hold a lock while calling cancel that is also acquired from
their send handler.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/core/mad.c	2005-03-03 14:12:54.671054304 -0800
+++ linux-export/drivers/infiniband/core/mad.c	2005-03-03 14:13:04.375947697 -0800
@@ -68,6 +68,7 @@
 static void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
 				    struct ib_mad_send_wc *mad_send_wc);
 static void timeout_sends(void *data);
+static void cancel_sends(void *data);
 static void local_completions(void *data);
 static int solicited_mad(struct ib_mad *mad);
 static int add_nonoui_reg_req(struct ib_mad_reg_req *mad_reg_req,
@@ -341,6 +342,8 @@
 	INIT_LIST_HEAD(&mad_agent_priv->local_list);
 	INIT_WORK(&mad_agent_priv->local_work, local_completions,
 		   mad_agent_priv);
+	INIT_LIST_HEAD(&mad_agent_priv->canceled_list);
+	INIT_WORK(&mad_agent_priv->canceled_work, cancel_sends, mad_agent_priv);
 	atomic_set(&mad_agent_priv->refcount, 1);
 	init_waitqueue_head(&mad_agent_priv->wait);
 
@@ -2004,12 +2007,44 @@
 	return NULL;
 }
 
+void cancel_sends(void *data)
+{
+	struct ib_mad_agent_private *mad_agent_priv;
+	struct ib_mad_send_wr_private *mad_send_wr;
+	struct ib_mad_send_wc mad_send_wc;
+	unsigned long flags;
+
+	mad_agent_priv = (struct ib_mad_agent_private *)data;
+
+	mad_send_wc.status = IB_WC_WR_FLUSH_ERR;
+	mad_send_wc.vendor_err = 0;
+
+	spin_lock_irqsave(&mad_agent_priv->lock, flags);
+	while (!list_empty(&mad_agent_priv->canceled_list)) {
+		mad_send_wr = list_entry(mad_agent_priv->canceled_list.next,
+					 struct ib_mad_send_wr_private,
+					 agent_list);
+
+		list_del(&mad_send_wr->agent_list);
+		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+
+		mad_send_wc.wr_id = mad_send_wr->wr_id;
+		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
+						   &mad_send_wc);
+
+		kfree(mad_send_wr);
+		if (atomic_dec_and_test(&mad_agent_priv->refcount))
+			wake_up(&mad_agent_priv->wait);
+		spin_lock_irqsave(&mad_agent_priv->lock, flags);
+	}
+	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+}
+
 void ib_cancel_mad(struct ib_mad_agent *mad_agent,
 		  u64 wr_id)
 {
 	struct ib_mad_agent_private *mad_agent_priv;
 	struct ib_mad_send_wr_private *mad_send_wr;
-	struct ib_mad_send_wc mad_send_wc;
 	unsigned long flags;
 
 	mad_agent_priv = container_of(mad_agent, struct ib_mad_agent_private,
@@ -2031,19 +2066,12 @@
 	}
 
 	list_del(&mad_send_wr->agent_list);
+	list_add_tail(&mad_send_wr->agent_list, &mad_agent_priv->canceled_list);
 	adjust_timeout(mad_agent_priv);
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
-	mad_send_wc.status = IB_WC_WR_FLUSH_ERR;
-	mad_send_wc.vendor_err = 0;
-	mad_send_wc.wr_id = mad_send_wr->wr_id;
-	mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
-					   &mad_send_wc);
-
-	kfree(mad_send_wr);
-	if (atomic_dec_and_test(&mad_agent_priv->refcount))
-		wake_up(&mad_agent_priv->wait);
-
+	queue_work(mad_agent_priv->qp_info->port_priv->wq,
+		   &mad_agent_priv->canceled_work);
 out:
 	return;
 }
--- linux-export.orig/drivers/infiniband/core/mad_priv.h	2005-03-02 20:53:21.000000000 -0800
+++ linux-export/drivers/infiniband/core/mad_priv.h	2005-03-03 14:13:04.375947697 -0800
@@ -95,6 +95,8 @@
 	unsigned long timeout;
 	struct list_head local_list;
 	struct work_struct local_work;
+	struct list_head canceled_list;
+	struct work_struct canceled_work;
 
 	atomic_t refcount;
 	wait_queue_head_t wait;

