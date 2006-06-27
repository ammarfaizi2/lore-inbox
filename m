Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932915AbWF0Es4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915AbWF0Es4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030698AbWF0Ese
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:48:34 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:49627 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933426AbWF0EmF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:05 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 15/21] [Suspend2] Prepare ui for work.
Date: Tue, 27 Jun 2006 14:42:04 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044202.14883.33128.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set logging settings and attempt to start the userspace helper ('userui').

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index a915a75..eedab56 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -499,3 +499,36 @@ void suspend_cond_pause(int pause, char 
 	schedule();
 }
 
+extern asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, 
+		unsigned long arg);
+
+/* suspend_prepare_console
+ *
+ * Description:	Prepare a console for use, save current settings.
+ * Returns:	Boolean: Whether an error occured. Errors aren't
+ * 		treated as fatal, but a warning is printed.
+ */
+void suspend_prepare_console(void)
+{
+	orig_loglevel = console_loglevel;
+	orig_default_message_loglevel = default_message_loglevel;
+	orig_kmsg = kmsg_redirect;
+	kmsg_redirect = fg_console + 1;
+	default_message_loglevel = 1;
+	console_loglevel = suspend_default_console_level;
+
+	ui_helper_data.pid = -1;
+
+	if (userui_ops.disabled)
+		return;
+
+	if (!*ui_helper_data.program) {
+		printk("suspend_userui: program not configured. suspend_userui disabled.\n");
+		return;
+	}
+
+	suspend_netlink_setup(&ui_helper_data);
+
+	return;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
