Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbVGKUcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVGKUcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbVGKUcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:32:14 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:16333 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262597AbVGKUa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:30:56 -0400
Subject: [PATCH 15/29v2] Fix a couple of MAD code paths
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110325.4389.5014.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 16:23:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed locking to handle error posting MAD send work requests. 
Fixed handling canceling a MAD with an active work request.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 14/29.

-- 
 mad.c |   28 ++++++++++++++--
 1 files changed, 14 insertions(+), 14 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1-14/drivers/infiniband/core/mad.c linux-2.6.13-rc2-mm1-15/drivers/infiniband/core/mad.c
-- linux-2.6.13-rc2-mm1-14/drivers/infiniband/core/mad.c	2005-07-11 13:38:42.000000000 -0400
+++ linux-2.6.13-rc2-mm1-15/drivers/infiniband/core/mad.c	2005-07-11 13:38:54.000000000 -0400
@@ -841,6 +841,7 @@ static int ib_send_mad(struct ib_mad_sen
 {
 	struct ib_mad_qp_info *qp_info;
 	struct ib_send_wr *bad_send_wr;
+	struct list_head *list;
 	unsigned long flags;
 	int ret;
 
@@ -850,22 +851,20 @@ static int ib_send_mad(struct ib_mad_sen
 	mad_send_wr->mad_list.mad_queue = &qp_info->send_queue;
 
 	spin_lock_irqsave(&qp_info->send_queue.lock, flags);
-	if (qp_info->send_queue.count++ < qp_info->send_queue.max_active) {
-		list_add_tail(&mad_send_wr->mad_list.list,
-			      &qp_info->send_queue.list);
-		spin_unlock_irqrestore(&qp_info->send_queue.lock, flags);
+	if (qp_info->send_queue.count < qp_info->send_queue.max_active) {
 		ret = ib_post_send(mad_send_wr->mad_agent_priv->agent.qp,
 				   &mad_send_wr->send_wr, &bad_send_wr);
-		if (ret) {
-			printk(KERN_ERR PFX "ib_post_send failed: %d\n", ret);
-			dequeue_mad(&mad_send_wr->mad_list);
-		}
+		list = &qp_info->send_queue.list;
 	} else {
-		list_add_tail(&mad_send_wr->mad_list.list,
-			      &qp_info->overflow_list);
-		spin_unlock_irqrestore(&qp_info->send_queue.lock, flags);
 		ret = 0;
+		list = &qp_info->overflow_list;
 	}
+
+	if (!ret) {
+		qp_info->send_queue.count++;
+		list_add_tail(&mad_send_wr->mad_list.list, list);
+	}
+	spin_unlock_irqrestore(&qp_info->send_queue.lock, flags);
 	return ret;
 }
 
@@ -2023,8 +2022,7 @@ static void cancel_mads(struct ib_mad_ag
 }
 
 static struct ib_mad_send_wr_private*
-find_send_by_wr_id(struct ib_mad_agent_private *mad_agent_priv,
-		   u64 wr_id)
+find_send_by_wr_id(struct ib_mad_agent_private *mad_agent_priv, u64 wr_id)
 {
 	struct ib_mad_send_wr_private *mad_send_wr;
 
@@ -2047,6 +2045,7 @@ int ib_modify_mad(struct ib_mad_agent *m
 	struct ib_mad_agent_private *mad_agent_priv;
 	struct ib_mad_send_wr_private *mad_send_wr;
 	unsigned long flags;
+	int active;
 
 	mad_agent_priv = container_of(mad_agent, struct ib_mad_agent_private,
 				      agent);
@@ -2057,13 +2056,14 @@ int ib_modify_mad(struct ib_mad_agent *m
 		return -EINVAL;
 	}
 
+	active = (!mad_send_wr->timeout || mad_send_wr->refcount > 1);
 	if (!timeout_ms) {
 		mad_send_wr->status = IB_WC_WR_FLUSH_ERR;
 		mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
 	}
 
 	mad_send_wr->send_wr.wr.ud.timeout_ms = timeout_ms;
-	if (!mad_send_wr->timeout || mad_send_wr->refcount > 1)
+	if (active)
 		mad_send_wr->timeout = msecs_to_jiffies(timeout_ms);
 	else
 		ib_reset_mad_timeout(mad_send_wr, timeout_ms);


