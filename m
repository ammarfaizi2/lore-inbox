Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWF0Ex6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWF0Ex6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWF0ElO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:14 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:35803 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933409AbWF0Ekd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:33 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 02/13] [Suspend2] Receive storage manager message
Date: Tue, 27 Jun 2006 14:40:32 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044031.14778.21499.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
References: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routine called when netlink messages are received.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/storage.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/kernel/power/storage.c b/kernel/power/storage.c
index 91b24a6..b66efe2 100644
--- a/kernel/power/storage.c
+++ b/kernel/power/storage.c
@@ -34,3 +34,41 @@ static int usm_prepare_count = 0;
 static int storage_manager_last_action = 0;
 static int storage_manager_action = 0;
        
+static int usm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
+{
+	int type;
+	int *data;
+
+	type = nlh->nlmsg_type;
+
+	/* A control message: ignore them */
+	if (type < NETLINK_MSG_BASE)
+		return 0;
+
+	/* Unknown message: reply with EINVAL */
+	if (type >= USM_MSG_MAX)
+		return -EINVAL;
+
+	/* All operations require privileges, even GET */
+	if (security_netlink_recv(skb))
+		return -EPERM;
+
+	/* Only allow one task to receive NOFREEZE privileges */
+	if (type == NETLINK_MSG_NOFREEZE_ME && usm_helper_data.pid != -1)
+		return -EBUSY;
+
+	data = (int*)NLMSG_DATA(nlh);
+
+	switch (type) {
+		case USM_MSG_SUCCESS:
+		case USM_MSG_FAILED:
+			message_received = type;
+			complete(&usm_helper_data.wait_for_process);
+			break;
+		default:
+			printk("Storage manager doesn't recognise message %d.\n", type);
+	}
+
+	return 1;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
