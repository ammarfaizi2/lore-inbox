Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269032AbTGJIA7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 04:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269036AbTGJIA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 04:00:59 -0400
Received: from ol.freeshell.org ([192.94.73.20]:29417 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S269032AbTGJIAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 04:00:53 -0400
Date: Thu, 10 Jul 2003 08:15:13 +0000
From: Tavis Ormandy <taviso@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: alpha@gentoo.org
Subject: [PATCH] 2.4.21: Optionally Configure UAC Policy via Sysctl (Alpha)
Message-ID: <20030710081513.GA7671@sdf.lonestar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, this patch adds a configuration option in General Setup for Alpha
users, "CONFIG_ALPHA_UAC_SYSCTL", which will allow the kernel UAC policy to
be modified at runtime via sysctl's.

The sysctl's created are:

	/proc/sys/kernel/uac/noprint
	/proc/sys/kernel/uac/sigbus
	/proc/sys/kernel/uac/nofix

which are initialised to the existing policy. I've added some text for
the Help screen.

Benefits:

	* No longer need to recompile to change UAC policy.
	* Disabling the 'unaligned trap' messages usually requires
	  changing the loglevel, which sacrifices other useful messages.
	* UAC_SIGBUS can be turned on and off at will, which is quite
	  handy for debugging.

Suggestions/comments/flames welcome, im considering submitting to Marcelo
(so any tips welcome). Patch (against 2.4.21) below sig.

Thanks, Tavis.

-- 
-------------------------------------
taviso@sdf.lonestar.org | finger me for my gpg key.
-------------------------------------------------------

diff -ruN linux-2.4.21.orig/arch/alpha/config.in linux-2.4.21/arch/alpha/config.in
--- linux-2.4.21.orig/arch/alpha/config.in	2003-06-13 15:51:29.000000000 +0100
+++ linux-2.4.21/arch/alpha/config.in	2003-07-10 07:45:21.000000000 +0100
@@ -294,6 +294,9 @@
 fi
 if [ "$CONFIG_PROC_FS" != "n" ]; then
    tristate 'SRM environment through procfs' CONFIG_SRM_ENV
+   if [ "$CONFIG_SYSCTL" != "n" ]; then
+	   bool 'Configure uac policy via sysctl' CONFIG_ALPHA_UAC_SYSCTL
+   fi 
 fi
  
 tristate 'Kernel support for a.out (ECOFF) binaries' CONFIG_BINFMT_AOUT
diff -ruN linux-2.4.21.orig/arch/alpha/kernel/traps.c linux-2.4.21/arch/alpha/kernel/traps.c
--- linux-2.4.21.orig/arch/alpha/kernel/traps.c	2003-06-13 15:51:29.000000000 +0100
+++ linux-2.4.21/arch/alpha/kernel/traps.c	2003-07-10 07:43:38.000000000 +0100
@@ -14,6 +14,8 @@
 #include <linux/tty.h>
 #include <linux/delay.h>
 #include <linux/smp_lock.h>
+#include <linux/sysctl.h>
+#include <linux/init.h>
 
 #include <asm/gentrap.h>
 #include <asm/uaccess.h>
@@ -32,6 +34,43 @@
 static int opDEC_checked = 0;
 static unsigned long opDEC_test_pc = 0;
 
+#ifdef CONFIG_ALPHA_UAC_SYSCTL
+static struct ctl_table_header *uac_sysctl_header;
+
+static int enabled_noprint = 0;
+static int enabled_sigbus = 0;
+static int enabled_nofix = 0;
+
+ctl_table uac_table[] = {
+	{KERN_UAC_NOPRINT, "noprint", &enabled_noprint, sizeof (int), 0644, NULL, &proc_dointvec},
+	{KERN_UAC_SIGBUS, "sigbus", &enabled_sigbus, sizeof (int), 0644, NULL, &proc_dointvec},
+	{KERN_UAC_NOFIX, "nofix", &enabled_nofix, sizeof (int), 0644, NULL, &proc_dointvec},
+        {0}
+};
+
+static int __init init_uac_sysctl(void)
+{
+	unsigned long uac_bits;
+
+	/* get the defined UAC_POLICY */
+        uac_bits = (current->thread.flags >> UAC_SHIFT) & UAC_BITMASK;
+
+	/* now initialize sysctl's with that policy */
+	enabled_noprint = (uac_bits & UAC_NOPRINT) ? 1 : 0;
+	enabled_sigbus = (uac_bits & UAC_SIGBUS) ? 1 : 0;
+	enabled_nofix = (uac_bits & UAC_NOFIX) ? 1 : 0;
+
+	/* save this for later so we can clean up */	
+	uac_sysctl_header = register_sysctl_table(uac_table, 0);
+	return 0;
+}
+
+static void __exit exit_uac_sysctl(void)
+{
+	unregister_sysctl_table(uac_sysctl_header);
+}
+#endif
+
 static void
 opDEC_check(void)
 {
@@ -710,19 +749,24 @@
 do_entUnaUser(void * va, unsigned long opcode,
 	      unsigned long reg, struct pt_regs *regs)
 {
-	static int cnt = 0;
-	static long last_time = 0;
-
 	unsigned long tmp1, tmp2, tmp3, tmp4;
 	unsigned long fake_reg, *reg_addr = &fake_reg;
-	unsigned long uac_bits;
 	long error;
+	static int cnt = 0;
+	static long last_time = 0;
 
+#ifndef CONFIG_ALPHA_UAC_SYSCTL
+	unsigned long uac_bits;
+	
 	/* Check the UAC bits to decide what the user wants us to do
 	   with the unaliged access.  */
 
 	uac_bits = (current->thread.flags >> UAC_SHIFT) & UAC_BITMASK;
 	if (!(uac_bits & UAC_NOPRINT)) {
+#else
+	/* check systcls for uac policy */
+	if (!(enabled_noprint)) {
+#endif
 		if (cnt >= 5 && jiffies - last_time > 5*HZ) {
 			cnt = 0;
 		}
@@ -733,10 +777,18 @@
 		}
 		last_time = jiffies;
 	}
+#ifndef CONFIG_ALPHA_UAC_SYSCTL
 	if (uac_bits & UAC_SIGBUS) {
+#else
+	if (enabled_sigbus) {
+#endif
 		goto give_sigbus;
 	}
+#ifndef CONFIG_ALPHA_UAC_SYSCTL
 	if (uac_bits & UAC_NOFIX) {
+#else
+	if (enabled_nofix) {
+#endif
 		/* Not sure why you'd want to use this, but... */
 		return;
 	}
diff -ruN linux-2.4.21.orig/Documentation/Configure.help linux-2.4.21/Documentation/Configure.help
--- linux-2.4.21.orig/Documentation/Configure.help	2003-06-13 15:51:29.000000000 +0100
+++ linux-2.4.21/Documentation/Configure.help	2003-07-10 07:40:03.000000000 +0100
@@ -3372,6 +3372,29 @@
 
   Say N unless you know you need gobs and gobs of vmalloc space.
 
+Configure UAC policy via sysctl
+CONFIG_ALPHA_UAC_SYSCTL
+  Configuring the UAC policy on a Linux system usually involves
+  setting a compile time define, if you say Y here and also to 
+  sysctl support above, you will be able to modify the UAC policy
+  at runtime using the /proc interface. 
+
+  The UAC Policy defines the action Linux should take when an 
+  unaligned memory access occurs, the action can include printing
+  a warning message (NOPRINT), sending a signal to help developers 
+  debug their applications (SIGBUS), and you can disable the 
+  transparent fixing (NOFIX).
+
+  The sysctl's will be initialized to the defined UAC policy, you
+  can change these manually, or with the sysctl(8) userspace 
+  utility.
+
+  To disable the warning messages at runtime, you might use
+
+  echo 1 > /proc/sys/kernel/uac/noprint
+
+  Say N if your not sure.
+
 Non-standard serial port support
 CONFIG_SERIAL_NONSTANDARD
   Say Y here if you have any non-standard serial boards -- boards
diff -ruN linux-2.4.21.orig/include/linux/sysctl.h linux-2.4.21/include/linux/sysctl.h
--- linux-2.4.21.orig/include/linux/sysctl.h	2003-06-13 15:51:39.000000000 +0100
+++ linux-2.4.21/include/linux/sysctl.h	2003-07-10 06:58:04.000000000 +0100
@@ -125,6 +125,9 @@
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
  	KERN_CORE_PATTERN=56,	/* string: pattern for core-files */
+#ifdef CONFIG_ALPHA_UAC_SYSCTL
+	KERN_UAC_POLICY=57,	/* uac policy */
+#endif
 };
 
 
@@ -146,6 +149,16 @@
 	VM_MAX_READAHEAD=13,    /* Max file readahead */
 };
 
+#ifdef CONFIG_ALPHA_UAC_SYSCTL
+/* /proc/sys/kernel/uac */
+enum
+{
+	/* UAC policy */
+	KERN_UAC_NOPRINT=1,    /* int: printk() on unaligned access */
+	KERN_UAC_SIGBUS=2,     /* int: send SIGBUS on unaligned access */
+	KERN_UAC_NOFIX=3,      /* int: dont fix. */
+};				
+#endif
 
 /* CTL_NET names: */
 enum
diff -ruN linux-2.4.21.orig/kernel/sysctl.c linux-2.4.21/kernel/sysctl.c
--- linux-2.4.21.orig/kernel/sysctl.c	2003-06-13 15:51:39.000000000 +0100
+++ linux-2.4.21/kernel/sysctl.c	2003-07-10 06:18:00.000000000 +0100
@@ -97,6 +97,11 @@
 extern int acct_parm[];
 #endif
 
+
+#ifdef CONFIG_ALPHA_UAC_SYSCTL
+extern ctl_table uac_table[];
+#endif
+
 extern int pgt_cache_water[];
 
 static int parse_table(int *, int, void *, size_t *, void *, size_t,
@@ -259,6 +264,10 @@
 	{KERN_S390_USER_DEBUG_LOGGING,"userprocess_debug",
 	 &sysctl_userprocess_debug,sizeof(int),0644,NULL,&proc_dointvec},
 #endif
+
+#ifdef CONFIG_ALPHA_UAC_SYSCTL
+	{KERN_UAC_POLICY, "uac", NULL, 0, 0555, uac_table},
+#endif
 	{0}
 };
 
