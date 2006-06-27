Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWF0FCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWF0FCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933402AbWF0EkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:40:09 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:30171 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933389AbWF0Ej7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:59 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 10/13] [Suspend2] Prepare/cleanup netlink connections.
Date: Tue, 27 Jun 2006 14:39:58 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043956.14630.47655.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043923.14630.565.stgit@nigel.suspend2.net>
References: <20060627043923.14630.565.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to communicate with a userspace helper over a netlink socket and
cleanup afterwards.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/netlink.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/kernel/power/netlink.c b/kernel/power/netlink.c
index c5b4bea..7b75f4f 100644
--- a/kernel/power/netlink.c
+++ b/kernel/power/netlink.c
@@ -257,3 +257,36 @@ static void suspend_netlink_input(struct
 	} while (uhd->nl && uhd->nl->sk_receive_queue.qlen);
 }
 
+static int netlink_prepare(struct user_helper_data *uhd)
+{
+	uhd->next = uhd_list;
+	uhd_list = uhd;
+
+	uhd->sock_seq = 0x42c0ffee;
+	uhd->nl = netlink_kernel_create(uhd->netlink_id, 0,
+			suspend_netlink_input, THIS_MODULE);
+	if (!uhd->nl) {
+		printk("Failed to allocate netlink socket for %s.\n",
+				uhd->name);
+		return -ENOMEM;
+	}
+
+	suspend_fill_skb_pool(uhd);
+
+	return 0;
+}
+
+void suspend_netlink_close(struct user_helper_data *uhd)
+{
+	if (uhd->nl) {
+		sock_release(uhd->nl->sk_socket);
+		uhd->nl = NULL;
+	}
+
+	while (uhd->emerg_skbs) {
+		struct sk_buff *next = uhd->emerg_skbs->next;
+		kfree_skb(uhd->emerg_skbs);
+		uhd->emerg_skbs = next;
+	}
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
