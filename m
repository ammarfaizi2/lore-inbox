Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275296AbTHSBbX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275298AbTHSBbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:31:23 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:49357 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S275296AbTHSBbN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:31:13 -0400
Date: Tue, 19 Aug 2003 13:23:42 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Software Suspend 2.4 beta18-1.1rc4: Possible hard disk corruption
To: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1061256163.9992.7.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

The following patch fixes possible hard disk corruption in versions
beta18 through 1.1-rc4 (inclusive) of Software Suspend for 2.4 kernels.
Software Suspend for 2.5/6 is not affected.

Corruption can occur if you have unsynced data when starting to suspend
and that data is overwritten by Software Suspend in the normal course of
its operation and then the kernel attempts to sync data due to a panic
or you pressing the appropriate SysRq keys. This patch addresses those
issues.

All users should apply this portion of the incremental patch for 1.1-rc5
immediately.

Regards and apologies,

Nigel

diff -ruN swsusp-1.1-rc4/drivers/char/sysrq.c swsusp-1.1-rc5/drivers/char/sysrq.c
--- swsusp-1.1-rc4/drivers/char/sysrq.c	2003-08-19 13:05:43.000000000 +1200
+++ swsusp-1.1-rc5/drivers/char/sysrq.c	2003-08-19 13:05:44.000000000 +1200
@@ -139,8 +139,19 @@
 static void go_sync(struct super_block *sb, int remount_flag)
 {
 	int orig_loglevel;
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	if (suspend_task) {
+		printk(KERN_INFO "Not %sing device %s. Suspend may have used memory with dirty data!",
+		       remount_flag ? "remount" : "sync",
+		       kdevname(sb->s_dev));
+		return;
+	}
+#endif
+
 	orig_loglevel = console_loglevel;
 	console_loglevel = 7;
+
 	printk(KERN_INFO "%sing device %s ... ",
 	       remount_flag ? "Remount" : "Sync",
 	       kdevname(sb->s_dev));
diff -ruN swsusp-1.1-rc4/kernel/panic.c swsusp-1.1-rc5/kernel/panic.c
--- swsusp-1.1-rc4/kernel/panic.c	2003-08-19 13:05:43.000000000 +1200
+++ swsusp-1.1-rc5/kernel/panic.c	2003-08-19 13:05:44.000000000 +1200
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
+#include <linux/suspend.h>
 
 asmlinkage void sys_sync(void);	/* it's really int */
 
@@ -58,6 +59,10 @@
 		printk(KERN_EMERG "In interrupt handler - not syncing\n");
 	else if (!current->pid)
 		printk(KERN_EMERG "In idle task - not syncing\n");
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	else if (suspend_task)
+		printk(KERN_EMERG "In software suspend - not syncing.\n");
+#endif
 	else
 		sys_sync();
 	bust_spinlocks(0);



