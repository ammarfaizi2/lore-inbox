Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933425AbWF0Euy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933425AbWF0Euy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030651AbWF0Elz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:55 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:44507 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933425AbWF0Ela
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:30 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 05/21] [Suspend2] Receive a message from the userui.
Date: Tue, 27 Jun 2006 14:41:29 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044128.14883.19346.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Receive a message from the userspace user interface.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index 365c033..48719de 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -118,3 +118,61 @@ void request_abort_suspend(void)
 	}
 }
 
+static int userui_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
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
+	if (type >= USERUI_MSG_MAX)
+		return -EINVAL;
+
+	/* All operations require privileges, even GET */
+	if (security_netlink_recv(skb))
+		return -EPERM;
+
+	/* Only allow one task to receive NOFREEZE privileges */
+	if (type == NETLINK_MSG_NOFREEZE_ME && ui_helper_data.pid != -1)
+		return -EBUSY;
+
+	data = (int*)NLMSG_DATA(nlh);
+
+	switch (type) {
+		case USERUI_MSG_ABORT:
+			request_abort_suspend();
+			break;
+		case USERUI_MSG_GET_STATE:
+			suspend_send_netlink_message(&ui_helper_data, 
+					USERUI_MSG_GET_STATE, &suspend_action,
+					sizeof(suspend_action));
+			break;
+		case USERUI_MSG_GET_DEBUG_STATE:
+			suspend_send_netlink_message(&ui_helper_data,
+					USERUI_MSG_GET_DEBUG_STATE,
+					&suspend_debug_state,
+					sizeof(suspend_debug_state));
+			break;
+		case USERUI_MSG_SET_STATE:
+			if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(int)))
+				return -EINVAL;
+			ui_nl_set_state(*data);
+			break;
+		case USERUI_MSG_SET_DEBUG_STATE:
+			if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(int)))
+				return -EINVAL;
+			suspend_debug_state = (*data);
+			break;
+		case USERUI_MSG_SPACE:
+			wake_up_interruptible(&userui_wait_for_key);
+			break;
+	}
+
+	return 1;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
