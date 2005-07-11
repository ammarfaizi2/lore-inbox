Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVGKO2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVGKO2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVGKO0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:26:30 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:25286 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261803AbVGKOY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:24:59 -0400
Subject: [PATCH 12/27] Eliminate MAD cache leak associated with local
	completions
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121089118.4389.4529.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 10:17:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate MAD cache leak associated with local completions. 
Also, when canceling MAD, empty local completion list as well.

Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 11/27.

-- 
 mad.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband11/core/mad.c linux-2.6.13-rc2-mm1/drivers/infiniband12/core/mad.c
-- linux-2.6.13-rc2-mm1/drivers/infiniband11/core/mad.c	2005-07-09 17:41:24.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband12/core/mad.c	2005-07-09 17:46:10.000000000 -0400
@@ -1994,6 +1994,8 @@ static void cancel_mads(struct ib_mad_ag
 
 	/* Empty wait list to prevent receives from finding a request */
 	list_splice_init(&mad_agent_priv->wait_list, &cancel_list);
+	/* Empty local completion list as well */
+	list_splice_init(&mad_agent_priv->local_list, &cancel_list);
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
 	/* Report all cancelled requests */
@@ -2108,6 +2110,7 @@ static void local_completions(void *data
 	struct ib_mad_local_private *local;
 	struct ib_mad_agent_private *recv_mad_agent;
 	unsigned long flags;
+	int recv = 0;
 	struct ib_wc wc;
 	struct ib_mad_send_wc mad_send_wc;
 
@@ -2123,10 +2126,10 @@ static void local_completions(void *data
 			recv_mad_agent = local->recv_mad_agent;
 			if (!recv_mad_agent) {
 				printk(KERN_ERR PFX "No receive MAD agent for local completion\n");
-				kmem_cache_free(ib_mad_cache, local->mad_priv);
 				goto local_send_completion;
 			}
 
+			recv = 1;
 			/*
 			 * Defined behavior is to complete response
 			 * before request
@@ -2169,6 +2172,8 @@ local_send_completion:
 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
 		list_del(&local->completion_list);
 		atomic_dec(&mad_agent_priv->refcount);
+		if (!recv)
+			kmem_cache_free(ib_mad_cache, local->mad_priv);
 		kfree(local);
 	}
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);


