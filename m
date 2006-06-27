Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWF0FDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWF0FDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWF0FD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:03:26 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:27611 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030649AbWF0Ejl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:41 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 05/13] [Suspend2] Send netlink message to userspace helper.
Date: Tue, 27 Jun 2006 14:39:40 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043939.14630.69133.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043923.14630.565.stgit@nigel.suspend2.net>
References: <20060627043923.14630.565.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Send a netlink message to a userspace helper.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/netlink.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/kernel/power/netlink.c b/kernel/power/netlink.c
index c8c543a..696009d 100644
--- a/kernel/power/netlink.c
+++ b/kernel/power/netlink.c
@@ -79,3 +79,39 @@ static void suspend_notify_userspace(voi
 	read_unlock(&tasklist_lock);
 }
 
+DECLARE_WORK(suspend_notify_userspace_work, suspend_notify_userspace, NULL);
+
+void suspend_send_netlink_message(struct user_helper_data *uhd,
+		int type, void* params, size_t len)
+{
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh;
+	void *dest;
+
+	skb = suspend_get_skb(uhd);
+	if (!skb) {
+		printk("suspend_netlink: Can't allocate skb!\n");
+		return;
+	}
+
+	/* NLMSG_PUT contains a hidden goto nlmsg_failure */
+	nlh = NLMSG_PUT(skb, 0, uhd->sock_seq, type, len);
+	uhd->sock_seq++;
+
+	dest = NLMSG_DATA(nlh);
+	if (params && len > 0)
+		memcpy(dest, params, len);
+
+	netlink_unicast(uhd->nl, skb, uhd->pid, 0);
+
+	/* We may be in an interrupt context so defer waking up userspace */
+	suspend_notify_userspace_work.data = uhd;
+	schedule_work(&suspend_notify_userspace_work);
+
+	return;
+
+nlmsg_failure:
+	if (skb)
+		put_skb(uhd, skb);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
