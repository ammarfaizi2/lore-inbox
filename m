Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVGKXzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVGKXzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 19:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVGKUma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:42:30 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:12237 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262619AbVGKU1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:27:43 -0400
Subject: [PATCH 14/29v2] Optimize canceling a MAD
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110318.4389.5012.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 16:20:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize canceling a MAD. 
- Eliminate searching timeout list in cancel case.
- Remove duplicate calls to queue work item.
- Eliminate resending a MAD before MAD is completed.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 13/29.

--
 mad.c |   21 +++++++++++++--
 1 files changed, 13 insertions(+), 8 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1-13/drivers/infiniband/core/mad.c linux-2.6.13-rc2-mm1-14/drivers/infiniband/core/mad.c
-- linux-2.6.13-rc2-mm1-13/drivers/infiniband/core/mad.c	2005-07-11 13:38:30.000000000 -0400
+++ linux-2.6.13-rc2-mm1-14/drivers/infiniband/core/mad.c	2005-07-11 13:38:42.000000000 -0400
@@ -1754,14 +1754,18 @@ static void wait_for_response(struct ib_
 	delay = mad_send_wr->timeout;
 	mad_send_wr->timeout += jiffies;
 
-	list_for_each_prev(list_item, &mad_agent_priv->wait_list) {
-		temp_mad_send_wr = list_entry(list_item,
-					      struct ib_mad_send_wr_private,
-					      agent_list);
-		if (time_after(mad_send_wr->timeout,
-			       temp_mad_send_wr->timeout))
-			break;
+	if (delay) {
+		list_for_each_prev(list_item, &mad_agent_priv->wait_list) {
+			temp_mad_send_wr = list_entry(list_item,
+						struct ib_mad_send_wr_private,
+						agent_list);
+			if (time_after(mad_send_wr->timeout,
+				       temp_mad_send_wr->timeout))
+				break;
+		}
 	}
+	else
+		list_item = &mad_agent_priv->wait_list;
 	list_add(&mad_send_wr->agent_list, list_item);
 
 	/* Reschedule a work item if we have a shorter timeout */
@@ -2197,7 +2201,8 @@ static void timeout_sends(void *data)
 		}
 
 		list_del(&mad_send_wr->agent_list);
-		if (!retry_send(mad_send_wr))
+		if (mad_send_wr->status == IB_WC_SUCCESS &&
+		    !retry_send(mad_send_wr))
 			continue;
 
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);


