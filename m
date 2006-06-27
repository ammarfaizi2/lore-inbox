Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030693AbWF0Esz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030693AbWF0Esz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030688AbWF0Esb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:48:31 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:50139 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933414AbWF0EmI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:08 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 16/21] [Suspend2] Cleanup console after suspending.
Date: Tue, 27 Jun 2006 14:42:07 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044206.14883.60157.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Close down the userspace program (if one was running) and reset logging.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index eedab56..2012c2a 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -532,3 +532,34 @@ void suspend_prepare_console(void)
 	return;
 }
 
+/* suspend_cleanup_console
+ *
+ * Description: Restore the settings we saved above.
+ */
+
+void suspend_cleanup_console(void)
+{
+	suspend_default_console_level = console_loglevel;
+
+	if (ui_helper_data.pid > -1) {
+		struct task_struct *t;
+
+		suspend_send_netlink_message(&ui_helper_data,
+				NETLINK_MSG_CLEANUP, NULL, 0);
+
+		read_lock(&tasklist_lock);
+		if ((t = find_task_by_pid(ui_helper_data.pid)))
+			t->flags &= ~PF_NOFREEZE;
+		read_unlock(&tasklist_lock);
+
+		suspend_netlink_close(&ui_helper_data);
+
+		ui_helper_data.pid = -1;
+	}
+
+	console_loglevel = orig_loglevel;
+	kmsg_redirect = orig_kmsg;
+	default_message_loglevel = orig_default_message_loglevel;
+}
+#endif
+

--
Nigel Cunningham		nigel at suspend2 dot net
