Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUJ2Jmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUJ2Jmn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 05:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263180AbUJ2Jmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 05:42:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46040 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263189AbUJ2Jjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 05:39:42 -0400
Date: Fri, 29 Oct 2004 11:39:41 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] Configurable Magic Sysrq
Message-ID: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  I know about a few people who would like to use some functionality of
the Magic Sysrq but don't want to enable all the functions it provides.
So I wrote a patch which should allow them to do so. It allows to
configure available functions of Sysrq via /proc/sys/kernel/sysrq (the
interface is backward compatible). If you think it's useful then use it :)
Andrew, do you think it can go into mainline or it's just an overdesign?

			Thanks in advance for comments, bugreports
								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="enable-sysrq.diff"

Enable configuration of sysrq functions via /proc/sys/kernel/sysrq.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -ru linux-2.6.9/Documentation/sysrq.txt linux-2.6.9-sysrq/Documentation/sysrq.txt
--- linux-2.6.9/Documentation/sysrq.txt	2004-10-18 23:54:08.000000000 +0200
+++ linux-2.6.9-sysrq/Documentation/sysrq.txt	2004-10-22 18:58:07.924933784 +0200
@@ -10,13 +10,27 @@
 *  How do I enable the magic SysRq key?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 You need to say "yes" to 'Magic SysRq key (CONFIG_MAGIC_SYSRQ)' when
-configuring the kernel. When running on a kernel with SysRq compiled in, it
-may be DISABLED at run-time using following command:
+configuring the kernel. When running a kernel with SysRq compiled in,
+/proc/sys/kernel/sysrq controls the functions allowed to be invoked via
+the SysRq key. By default the file contains 1 which means that every
+possible SysRq request is allowed (in older versions SysRq was disabled
+by default, and you were required to specifically enable it at run-time
+but this is not the case any more). Here is the list of possible values
+in /proc/sys/kernel/sysrq:
+   0 - disable sysrq completely
+   1 - enable all functions of sysrq
+  >1 - bitmask of allowed sysrq functions (see below for detailed function
+       description):
+          2 - enable control of console logging level
+          4 - enable control of keyboard (SAK, unraw)
+          8 - enable debugging dumps of processes etc.
+         16 - enable sync command
+         32 - enable remount read-only
+         64 - enable signalling of processes (term, kill)
+        128 - allow reboot
 
-        echo "0" > /proc/sys/kernel/sysrq
-
-Note that previous versions disabled sysrq by default, and you were required
-to specifically enable it at run-time. That is not the case any longer.
+You can set the value in the file by the following command:
+    echo "number" >/proc/sys/kernel/sysrq
 
 *  How do I use the magic SysRq key?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff -ru linux-2.6.9/drivers/char/sysrq.c linux-2.6.9-sysrq/drivers/char/sysrq.c
--- linux-2.6.9/drivers/char/sysrq.c	2004-10-18 23:55:06.000000000 +0200
+++ linux-2.6.9-sysrq/drivers/char/sysrq.c	2004-10-22 14:47:25.000000000 +0200
@@ -38,6 +38,15 @@
 
 extern void reset_vc(unsigned int);
 
+/* 0x0001 is reserved for enable everything */
+#define SYSRQ_ENABLE_LOG	0x0002
+#define SYSRQ_ENABLE_KEYBOARD	0x0004
+#define SYSRQ_ENABLE_DUMP	0x0008
+#define SYSRQ_ENABLE_SYNC	0x0010
+#define SYSRQ_ENABLE_REMOUNT	0x0020
+#define SYSRQ_ENABLE_SIGNAL	0x0040
+#define SYSRQ_ENABLE_BOOT	0x0080
+
 /* Whether we react on sysrq keys or just ignore them */
 int sysrq_enabled = 1;
 
@@ -58,6 +67,7 @@
 	.handler	= sysrq_handle_loglevel,
 	.help_msg	= "loglevel0-8",
 	.action_msg	= "Changing Loglevel",
+	.enable_mask	= SYSRQ_ENABLE_LOG,
 };
 
 
@@ -74,6 +84,7 @@
 	.handler	= sysrq_handle_SAK,
 	.help_msg	= "saK",
 	.action_msg	= "SAK",
+	.enable_mask	= SYSRQ_ENABLE_KEYBOARD,
 };
 #endif
 
@@ -91,6 +102,7 @@
 	.handler	= sysrq_handle_unraw,
 	.help_msg	= "unRaw",
 	.action_msg	= "Keyboard mode set to XLATE",
+	.enable_mask	= SYSRQ_ENABLE_KEYBOARD,
 };
 #endif /* CONFIG_VT */
 
@@ -105,6 +117,7 @@
 	.handler	= sysrq_handle_reboot,
 	.help_msg	= "reBoot",
 	.action_msg	= "Resetting",
+	.enable_mask	= SYSRQ_ENABLE_BOOT,
 };
 
 static void sysrq_handle_sync(int key, struct pt_regs *pt_regs,
@@ -117,6 +130,7 @@
 	.handler	= sysrq_handle_sync,
 	.help_msg	= "Sync",
 	.action_msg	= "Emergency Sync",
+	.enable_mask	= SYSRQ_ENABLE_SYNC,
 };
 
 static void sysrq_handle_mountro(int key, struct pt_regs *pt_regs,
@@ -129,6 +143,7 @@
 	.handler	= sysrq_handle_mountro,
 	.help_msg	= "Unmount",
 	.action_msg	= "Emergency Remount R/O",
+	.enable_mask	= SYSRQ_ENABLE_REMOUNT,
 };
 
 /* END SYNC SYSRQ HANDLERS BLOCK */
@@ -146,6 +161,7 @@
 	.handler	= sysrq_handle_showregs,
 	.help_msg	= "showPc",
 	.action_msg	= "Show Regs",
+	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
 
 
@@ -158,6 +174,7 @@
 	.handler	= sysrq_handle_showstate,
 	.help_msg	= "showTasks",
 	.action_msg	= "Show State",
+	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
 
 
@@ -170,6 +187,7 @@
 	.handler	= sysrq_handle_showmem,
 	.help_msg	= "showMem",
 	.action_msg	= "Show Memory",
+	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
 
 /* SHOW SYSRQ HANDLERS BLOCK */
@@ -200,6 +218,7 @@
 	.handler	= sysrq_handle_term,
 	.help_msg	= "tErm",
 	.action_msg	= "Terminate All Tasks",
+	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
 
 static void sysrq_handle_kill(int key, struct pt_regs *pt_regs,
@@ -212,6 +231,7 @@
 	.handler	= sysrq_handle_kill,
 	.help_msg	= "kIll",
 	.action_msg	= "Kill All Tasks",
+	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
 
 /* END SIGNAL SYSRQ HANDLERS BLOCK */
@@ -331,9 +351,13 @@
 
         op_p = __sysrq_get_key_op(key);
         if (op_p) {
-		printk ("%s\n", op_p->action_msg);
-		console_loglevel = orig_log_level;
-		op_p->handler(key, pt_regs, tty);
+		if (sysrq_enabled == 1 || sysrq_enabled & op_p->enable_mask) {
+			printk ("%s\n", op_p->action_msg);
+			console_loglevel = orig_log_level;
+			op_p->handler(key, pt_regs, tty);
+		}
+		else
+			printk("This sysrq operation is disabled.\n");
 	} else {
 		printk("HELP : ");
 		/* Only print the help msg once per handler */
diff -ru linux-2.6.9/include/linux/sysrq.h linux-2.6.9-sysrq/include/linux/sysrq.h
--- linux-2.6.9/include/linux/sysrq.h	2004-10-18 23:53:06.000000000 +0200
+++ linux-2.6.9-sysrq/include/linux/sysrq.h	2004-10-22 14:47:25.000000000 +0200
@@ -20,6 +20,7 @@
 	void (*handler)(int, struct pt_regs *, struct tty_struct *);
 	char *help_msg;
 	char *action_msg;
+	int enable_mask;
 };
 
 #ifdef CONFIG_MAGIC_SYSRQ

--FL5UXtIhxfXey3p5--
