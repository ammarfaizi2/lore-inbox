Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030699AbWF0Em0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030699AbWF0Em0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030696AbWF0EmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:42:24 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:52187 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030694AbWF0EmV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:21 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 20/21] [Suspend2] Load time initialisation for user interface code.
Date: Tue, 27 Jun 2006 14:42:20 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044219.14883.13444.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise when userui code is loaded.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index 3f2f549..83a0370 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -788,3 +788,34 @@ static struct suspend_module_ops userui_
 	.memory_needed			= userui_memory_needed,
 #endif
 };
+
+/* suspend_console_proc_init
+ * Description: Boot time initialisation for user interface.
+ */
+static __init int suspend_console_proc_init(void)
+{
+	int result, i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+
+	if (!(result = suspend_register_module(&userui_ops)))
+		for (i=0; i< numfiles; i++)
+			suspend_register_procfile(&proc_params[i]);
+
+#ifdef CONFIG_NET
+	ui_helper_data.nl = NULL;
+	ui_helper_data.program[0] = '\0';
+	ui_helper_data.pid = -1;
+	ui_helper_data.skb_size = sizeof(struct userui_msg_params);
+	ui_helper_data.pool_limit = 6;
+	ui_helper_data.netlink_id = NETLINK_SUSPEND2_USERUI;
+	ui_helper_data.name = "userspace ui";
+	ui_helper_data.rcv_msg = userui_user_rcv_msg;
+	ui_helper_data.interface_version = 6;
+	ui_helper_data.must_init = 0;
+	ui_helper_data.not_ready = suspend_cleanup_console;
+	init_completion(&ui_helper_data.wait_for_process);
+#endif
+
+	return result;
+}
+
+late_initcall(suspend_console_proc_init);

--
Nigel Cunningham		nigel at suspend2 dot net
