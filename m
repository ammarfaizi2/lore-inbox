Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUAGGjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 01:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUAGGjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 01:39:16 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:10702 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266136AbUAGGjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 01:39:11 -0500
Message-ID: <3FFBA98D.1080901@comcast.net>
Date: Wed, 07 Jan 2004 00:39:09 -0600
From: Ian Pilcher <i.pilcher@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl equivalent of "idle=poll"
Content-Type: multipart/mixed;
 boundary="------------050305000703010607060500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050305000703010607060500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The previous version of this patch didn't get any response, so on the
"no news is good news" theory ... Any comments before I send this off to
Marcelo?

This adds a new x86-only sysctl, /proc/sys/kernel/idle_poll, which does
basically the same thing as the "idle=poll" boot parameter (except that
it can be turned on and off).

This patch does not affect the ability of the APM and/or ACPI subsystems
to override the default idle function.  It adds one symbol,
pm_idle_poll, to the global namespace.

This patch applies cleanly to 2.4.23, 2.4.24, and 2.4.25-pre4.

-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

--------------050305000703010607060500
Content-Type: text/plain;
 name="idle_poll.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idle_poll.patch"

diff -ur linux-2.4.25-pre4/arch/i386/kernel/process.c linux/arch/i386/kernel/process.c
--- linux-2.4.25-pre4/arch/i386/kernel/process.c	2004-01-07 00:01:39.000000000 -0600
+++ linux/arch/i386/kernel/process.c	2004-01-07 00:04:22.000000000 -0600
@@ -62,6 +62,12 @@
 void (*pm_idle)(void);
 
 /*
+ * Use polling instead of HLT instructions?  (Has no effect if pm_idle is over-
+ * ridden by APM, ACPI, etc.)
+ */
+int pm_idle_poll = 0;
+
+/*
  * Power off function, if any
  */
 void (*pm_power_off)(void);
@@ -77,10 +83,9 @@
 }
 
 /*
- * We use this if we don't have any better
- * idle routine..
+ * Idle using HLT instructions; saves power & keeps cpu's cool.
  */
-void default_idle(void)
+static void hlt_idle(void)
 {
 	if (current_cpu_data.hlt_works_ok && !hlt_counter) {
 		__cli();
@@ -118,6 +123,18 @@
 }
 
 /*
+ * Default idle routine; can be overridden by APM, ACPI, etc.  (See cpu_idle &
+ * pm_idle.)
+ */
+void default_idle(void)
+{
+	if (pm_idle_poll)
+		poll_idle();
+	else
+		hlt_idle();
+}
+
+/*
  * The idle thread. There's no useful work to be
  * done, so just try to conserve power and have a
  * low exit latency (ie sit in a loop waiting for
@@ -145,7 +162,7 @@
 {
 	if (!strncmp(str, "poll", 4)) {
 		printk("using polling idle threads.\n");
-		pm_idle = poll_idle;
+		pm_idle_poll = 1;
 	}
 
 	return 1;
diff -ur linux-2.4.25-pre4/Documentation/sysctl/kernel.txt linux/Documentation/sysctl/kernel.txt
--- linux-2.4.25-pre4/Documentation/sysctl/kernel.txt	2001-09-30 14:26:08.000000000 -0500
+++ linux/Documentation/sysctl/kernel.txt	2004-01-07 00:15:56.000000000 -0600
@@ -22,6 +22,7 @@
 - domainname
 - hostname
 - htab-reclaim                [ PPC only ]
+- idle_poll                   [ x86 only ]
 - java-appletviewer           [ binfmt_java, obsolete ]
 - java-interpreter            [ binfmt_java, obsolete ]
 - l2cr                        [ PPC only ]
@@ -105,6 +106,20 @@
  
 ==============================================================
 
+idle_poll: (x86 only)
+
+Setting this to a non-zero value causes the idle loop in the
+kernel to poll on the need reschedule flag instead of waiting
+for an interrupt to happen.  This can result in an improvement
+in performance on SMP systems (albeit at the cost of an increase
+in power consumption).
+
+Note that the power management subsystem (APM or ACPI) can
+override the default idle function, in which case this setting
+will have no effect.
+
+==============================================================
+
 l2cr: (PPC only)
 
 This flag controls the L2 cache of G3 processor boards. If
diff -ur linux-2.4.25-pre4/include/linux/pm.h linux/include/linux/pm.h
--- linux-2.4.25-pre4/include/linux/pm.h	2002-08-02 19:39:45.000000000 -0500
+++ linux/include/linux/pm.h	2004-01-07 00:04:22.000000000 -0600
@@ -185,6 +185,10 @@
 
 #endif /* CONFIG_PM */
 
+#ifdef CONFIG_X86
+extern int pm_idle_poll;
+#endif
+
 extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
 
diff -ur linux-2.4.25-pre4/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-2.4.25-pre4/include/linux/sysctl.h	2004-01-07 00:01:56.000000000 -0600
+++ linux/include/linux/sysctl.h	2004-01-07 00:04:22.000000000 -0600
@@ -128,6 +128,7 @@
 	KERN_PPC_L3CR=57,       /* l3cr register on PPC */
 	KERN_EXCEPTION_TRACE=58, /* boolean: exception trace */
  	KERN_CORE_SETUID=59,	/* int: set to allow core dumps of setuid apps */
+	KERN_IDLE_POLL=60,  	/* boolean: use polling for idle threads? */
 };
 
 
diff -ur linux-2.4.25-pre4/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-2.4.25-pre4/kernel/sysctl.c	2003-11-28 12:26:21.000000000 -0600
+++ linux/kernel/sysctl.c	2004-01-07 00:04:22.000000000 -0600
@@ -31,6 +31,7 @@
 #include <linux/sysrq.h>
 #include <linux/highuid.h>
 #include <linux/swap.h>
+#include <linux/pm.h>
 
 #include <asm/uaccess.h>
 
@@ -275,6 +276,10 @@
 	{KERN_EXCEPTION_TRACE,"exception-trace",
 	 &exception_trace,sizeof(int),0644,NULL,&proc_dointvec},
 #endif	
+#ifdef CONFIG_X86
+	{KERN_IDLE_POLL,"idle_poll",
+	&pm_idle_poll,sizeof(int),0644,NULL,&proc_dointvec},
+#endif
 	{0}
 };
 

--------------050305000703010607060500--

