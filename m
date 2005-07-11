Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVGKUED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVGKUED (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVGKUCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:02:07 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:33228 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262531AbVGKUBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:01:11 -0400
Subject: [PATCH 7/29v2] Fix timeout/cancelled MAD handling
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110279.4389.4998.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 15:53:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an issue processing a sent MAD after it has timed out or 
been canceled.  The race occurs when a response MAD matches with
the send request.  The request could time out or be canceled after
the response MAD matches with the request, but before the request
completion can be processed.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 6/29.

--
 mad.c      |   14 ++++++++++++--
 mad_priv.h |    1 +
 2 files changed, 13 insertions(+), 2 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1-6/drivers/infiniband/core/mad.c linux-2.6.13-rc2-mm1-7/drivers/infiniband/core/mad.c
-- linux-2.6.13-rc2-mm1-6/drivers/infiniband/core/mad.c	2005-07-11 13:36:16.000000000 -0400
+++ linux-2.6.13-rc2-mm1-7/drivers/infiniband/core/mad.c	2005-07-11 13:36:29.000000000 -0400
@@ -341,6 +341,7 @@ struct ib_mad_agent *ib_register_mad_age
 	spin_lock_init(&mad_agent_priv->lock);
 	INIT_LIST_HEAD(&mad_agent_priv->send_list);
 	INIT_LIST_HEAD(&mad_agent_priv->wait_list);
+	INIT_LIST_HEAD(&mad_agent_priv->done_list);
 	INIT_WORK(&mad_agent_priv->timed_work, timeout_sends, mad_agent_priv);
 	INIT_LIST_HEAD(&mad_agent_priv->local_list);
 	INIT_WORK(&mad_agent_priv->local_work, local_completions,
@@ -1559,6 +1560,16 @@ find_send_req(struct ib_mad_agent_privat
 	return NULL;
 }
 
+static void ib_mark_req_done(struct ib_mad_send_wr_private *mad_send_wr)
+{
+	mad_send_wr->timeout = 0;
+	if (mad_send_wr->refcount == 1) {
+		list_del(&mad_send_wr->agent_list);
+		list_add_tail(&mad_send_wr->agent_list,
+			      &mad_send_wr->mad_agent_priv->done_list);
+	}
+}
+
 static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 				 struct ib_mad_recv_wc *mad_recv_wc)
 {
@@ -1580,8 +1591,7 @@ static void ib_mad_complete_recv(struct 
 				wake_up(&mad_agent_priv->wait);
 			return;
 		}
-		/* Timeout = 0 means that we won't wait for a response */
-		mad_send_wr->timeout = 0;
+		ib_mark_req_done(mad_send_wr);
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
 		/* Defined behavior is to complete response before request */
diff -uprN linux-2.6.13-rc2-mm1-6/drivers/infiniband/core/mad_priv.h linux-2.6.13-rc2-mm1-7/drivers/infiniband/core/mad_priv.h
-- linux-2.6.13-rc2-mm1-6/drivers/infiniband/core/mad_priv.h	2005-07-09 15:09:53.000000000 -0400
+++ linux-2.6.13-rc2-mm1-7/drivers/infiniband/core/mad_priv.h	2005-07-09 16:48:05.000000000 -0400
@@ -92,6 +92,7 @@ struct ib_mad_agent_private {
 	spinlock_t lock;
 	struct list_head send_list;
 	struct list_head wait_list;
+	struct list_head done_list;
 	struct work_struct timed_work;
 	unsigned long timeout;
 	struct list_head local_list;


