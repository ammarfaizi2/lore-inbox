Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030649AbWF0FFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030649AbWF0FFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030685AbWF0Ejh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:39:37 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:26587 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030684AbWF0Ejf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:35 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 03/13] [Suspend2] Get and put skbs.
Date: Tue, 27 Jun 2006 14:39:34 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043932.14630.93435.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043923.14630.565.stgit@nigel.suspend2.net>
References: <20060627043923.14630.565.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get and put skbs used to communicate with userspace helpers.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/netlink.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/kernel/power/netlink.c b/kernel/power/netlink.c
index d169096..82a9f6d 100644
--- a/kernel/power/netlink.c
+++ b/kernel/power/netlink.c
@@ -34,3 +34,34 @@ static void suspend_fill_skb_pool(struct
 	}
 }
 
+/* 
+ * Try to allocate a single skb. If we can't get one, try to use one from
+ * our pool.
+ */
+static struct sk_buff *suspend_get_skb(struct user_helper_data *uhd)
+{
+	struct sk_buff *skb =
+		alloc_skb(NLMSG_SPACE(uhd->skb_size), GFP_ATOMIC);
+
+	if (skb)
+		return skb;
+
+	skb = uhd->emerg_skbs;
+	if (skb) {
+		uhd->pool_level--;
+		uhd->emerg_skbs = skb->next;
+		skb->next = NULL;
+	}
+
+	return skb;
+}
+
+static void put_skb(struct user_helper_data *uhd, struct sk_buff *skb)
+{
+	if (uhd->pool_level < uhd->pool_limit) {
+		skb->next = uhd->emerg_skbs;
+		uhd->emerg_skbs = skb;
+	} else
+		kfree_skb(skb);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
