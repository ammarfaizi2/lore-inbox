Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933409AbWF0EyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933409AbWF0EyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933424AbWF0ElM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:12 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:36315 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933410AbWF0Ekh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:37 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 03/13] [Suspend2] Ask userspace to enable/disable access to our storage.
Date: Tue, 27 Jun 2006 14:40:35 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044034.14778.54026.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
References: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ask userspace to do whatever it needs to do to provide us with access to
the image storage, or to tear down the access.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/storage.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/kernel/power/storage.c b/kernel/power/storage.c
index b66efe2..71b8c02 100644
--- a/kernel/power/storage.c
+++ b/kernel/power/storage.c
@@ -72,3 +72,61 @@ static int usm_user_rcv_msg(struct sk_bu
 	return 1;
 }
 
+int suspend_activate_storage(int force)
+{
+	int tries = 1;
+
+	if (usm_helper_data.pid == -1 || usm_ops.disabled)
+		return 0;
+
+	message_received = 0;
+	activations++;
+
+	if (activations > 1 && !force)
+		return 0;
+
+	while ((!message_received || message_received == USM_MSG_FAILED) && tries < 2) {
+		suspend_prepare_status(DONT_CLEAR_BAR, "Activate storage attempt %d.\n", tries);
+
+		init_completion(&usm_helper_data.wait_for_process);
+
+		suspend_send_netlink_message(&usm_helper_data,
+			USM_MSG_CONNECT,
+			NULL, 0);
+
+		/* Wait 2 seconds for the userspace process to make contact */
+		wait_for_completion_timeout(&usm_helper_data.wait_for_process, 2*HZ);
+
+		tries++;
+	}
+
+	return 0;
+}
+
+int suspend_deactivate_storage(int force)
+{
+	if (usm_helper_data.pid == -1 || usm_ops.disabled)
+		return 0;
+	
+	message_received = 0;
+	activations--;
+
+	if (activations && !force)
+		return 0;
+
+	init_completion(&usm_helper_data.wait_for_process);
+
+	suspend_send_netlink_message(&usm_helper_data,
+			USM_MSG_DISCONNECT,
+			NULL, 0);
+
+	wait_for_completion_timeout(&usm_helper_data.wait_for_process, 2*HZ);
+
+	if (!message_received || message_received == USM_MSG_FAILED) {
+		printk("Returning failure disconnecting storage.\n");
+		return 1;
+	}
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
