Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWF0FDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWF0FDX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030684AbWF0Ejj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:39:39 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:26075 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030658AbWF0Ejb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:31 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 02/13] [Suspend2] Fill skb pool.
Date: Tue, 27 Jun 2006 14:39:30 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043929.14630.80423.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043923.14630.565.stgit@nigel.suspend2.net>
References: <20060627043923.14630.565.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fill the skb pool used to communicate with userspace helpers.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/netlink.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/kernel/power/netlink.c b/kernel/power/netlink.c
index 8d27801..d169096 100644
--- a/kernel/power/netlink.c
+++ b/kernel/power/netlink.c
@@ -15,3 +15,22 @@
 #ifdef CONFIG_NET
 struct user_helper_data *uhd_list = NULL;
        
+/* 
+ * Refill our pool of SKBs for use in emergencies (eg, when eating memory and none
+ * can be allocated).
+ */
+static void suspend_fill_skb_pool(struct user_helper_data *uhd)
+{
+	while (uhd->pool_level < uhd->pool_limit) {
+		struct sk_buff *new_skb =
+			alloc_skb(NLMSG_SPACE(uhd->skb_size), GFP_ATOMIC);
+
+		if (!new_skb)
+			break;
+
+		new_skb->next = uhd->emerg_skbs;
+		uhd->emerg_skbs = new_skb;
+		uhd->pool_level++;
+	}
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
