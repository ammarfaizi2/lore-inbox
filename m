Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbUCRAbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbUCRAbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:31:36 -0500
Received: from fmr04.intel.com ([143.183.121.6]:1244 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262236AbUCRAb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:31:29 -0500
Message-Id: <200403180031.i2I0VQF02038@unix-os.sc.intel.com>
From: "Kenneth Chen" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-ia64@vger.kernel.org>
Subject: add lowpower_idle sysctl
Date: Wed, 17 Mar 2004 16:31:26 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQMgFk4FqG2Qc/WQ86ABjRymBVj/w==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ia64, we need runtime control to manage CPU power state in the idle
loop.  Logically it means a sysctl entry in /proc/sys/kernel.  Even
though this sysctl entry doesn't exist today, lots of arch already has
some sort of API to dynamically enable/disable low power idle state.
Looking at linux-2.6.4, arm, arm26, cris, i386, parisc, sh, um, x86-64
all has very much the same code in each arch.  So instead of replicate
another set under arch/ia64, we are proposing these API to be abstracted
out in the generic code.  And also add a sysctl entry under /proc/sys/kernel.

Would this be useful to all architecture who wants this features?  It
would be a lot less code duplication.

- Ken


diff -Nur linux-2.6.4/include/linux/sysctl.h linux-2.6.4.halt/include/linux/sysctl.h
--- linux-2.6.4/include/linux/sysctl.h	2004-03-10 18:55:28.000000000 -0800
+++ linux-2.6.4.halt/include/linux/sysctl.h	2004-03-17 15:33:30.000000000 -0800
@@ -131,6 +131,7 @@
 	KERN_PRINTK_RATELIMIT_BURST=61,	/* int: tune printk ratelimiting */
 	KERN_PTY=62,		/* dir: pty driver */
 	KERN_NGROUPS_MAX=63,	/* int: NGROUPS_MAX */
+	KERN_LOWPOWER_IDLE=64,	/* int: low power idle */
 };


diff -Nur linux-2.6.4/kernel/cpu.c linux-2.6.4.halt/kernel/cpu.c
--- linux-2.6.4/kernel/cpu.c	2004-03-10 18:55:44.000000000 -0800
+++ linux-2.6.4.halt/kernel/cpu.c	2004-03-17 15:36:32.000000000 -0800
@@ -64,3 +64,15 @@
 	up(&cpucontrol);
 	return ret;
 }
+
+atomic_t halt_counter;
+void enable_halt(void)
+{
+	atomic_dec(&halt_counter);
+}
+void disable_halt(void)
+{
+	atomic_inc(&halt_counter);
+}
+EXPORT_SYMBOL(enable_halt);
+EXPORT_SYMBOL(disable_halt);
diff -Nur linux-2.6.4/kernel/sysctl.c linux-2.6.4.halt/kernel/sysctl.c
--- linux-2.6.4/kernel/sysctl.c	2004-03-10 18:55:22.000000000 -0800
+++ linux-2.6.4.halt/kernel/sysctl.c	2004-03-17 15:34:52.000000000 -0800
@@ -64,6 +64,7 @@
 extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
+extern atomic_t halt_counter;

 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -615,6 +616,14 @@
 		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= KERN_LOWPOWER_IDLE,
+		.procname	= "lowpower_idle",
+		.data		= &halt_counter,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };



