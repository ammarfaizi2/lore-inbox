Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261772AbSJDW5R>; Fri, 4 Oct 2002 18:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261778AbSJDWxz>; Fri, 4 Oct 2002 18:53:55 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:35147 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261772AbSJDWtp>; Fri, 4 Oct 2002 18:49:45 -0400
Date: Fri, 4 Oct 2002 16:03:44 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210042303.g94N3i410041@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40: lkcd (6/9): sysrq changes for dump
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sysrq changes so that dumps can be generated on the fly.

diff -urN -X /home/bharata/dontdiff linux-2.5.40/drivers/char/sysrq.c linux-2.5.40+lkcd/drivers/char/sysrq.c
--- linux-2.5.40/drivers/char/sysrq.c	Tue Oct  1 12:37:35 2002
+++ linux-2.5.40+lkcd/drivers/char/sysrq.c	Thu Oct  3 07:18:35 2002
@@ -32,6 +32,7 @@
 #include <linux/buffer_head.h>		/* for fsync_bdev() */
 
 #include <linux/spinlock.h>
+#include <linux/dump.h>
 
 #include <asm/ptrace.h>
 
@@ -307,6 +308,34 @@
 	}
 }
 
+static void sysrq_handle_crashdump(int key, struct pt_regs *pt_regs,
+		struct tty_struct *tty) {
+	dump("sysrq", pt_regs);
+}
+static struct sysrq_key_op sysrq_crashdump_op = {
+	handler:	sysrq_handle_crashdump,
+	help_msg:	"Crash",
+	action_msg:	"Start a Crash Dump (If Configured)",
+};
+
+static void sysrq_handle_dumpregs(int key, struct pt_regs *pt_regs,
+		struct tty_struct *tty) {
+#if defined(CONFIG_X86) && defined(CONFIG_SMP)
+	extern void (*dump_trace_ptr)(struct pt_regs *);
+	printk("Show state of all cpus\n");
+	if (dump_trace_ptr) {
+		dump_trace_ptr(pt_regs);
+	} else {
+		printk("Load dump module/configure first\n");
+	}
+#endif
+}
+static struct sysrq_key_op sysrq_dumpregs_op = {
+	handler:	sysrq_handle_dumpregs,
+	help_msg:	"Dumpregisters",
+	action_msg:	"Dump CPU Registers (If Configured)"
+};
+
 static void sysrq_handle_term(int key, struct pt_regs *pt_regs,
 			      struct tty_struct *tty) 
 {
@@ -352,8 +381,8 @@
 		 it is handled specially on the spark
 		 and will never arive */
 /* b */	&sysrq_reboot_op,
-/* c */	NULL,
-/* d */	NULL,
+/* c */	&sysrq_crashdump_op,
+/* d */	&sysrq_dumpregs_op,
 /* e */	&sysrq_term_op,
 /* f */	NULL,
 /* g */	NULL,
