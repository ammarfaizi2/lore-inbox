Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUABGTP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 01:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbUABGTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 01:19:15 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:14007 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265051AbUABGTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 01:19:11 -0500
Message-ID: <3FF50D5D.6050905@comcast.net>
Date: Fri, 02 Jan 2004 00:19:09 -0600
From: Ian Pilcher <i.pilcher@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sysctl equivalent to "idle=poll"
Content-Type: multipart/mixed;
 boundary="------------070607010003070805070501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070607010003070805070501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch against 2.4.23 adds an x86 sysctl,
/proc/sys/kernel/idle_poll, which allows idle behavior to be toggled
between polling and using HLT instructions.

Since this is the first time I've ever messed with kernel code, I'd
appreciate it if those more knowledgeable can give it a quick glance and
let me know if I've made any particularly obvious errors.  For example,
should I be doing something to ensure that the value of pm_idle_poll is
actually read from memory in default_idle?  (sysctl.c doesn't like it if
I just make pm_idle_poll volatile.)

Thanks!
-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

--------------070607010003070805070501
Content-Type: text/plain;
 name="linux-2.4.23-idle_poll.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.23-idle_poll.patch"

diff -ur linux-2.4.23-orig/arch/i386/kernel/process.c linux-2.4.23/arch/i386/kernel/process.c
--- linux-2.4.23-orig/arch/i386/kernel/process.c	2004-01-01 22:11:19.000000000 -0600
+++ linux-2.4.23/arch/i386/kernel/process.c	2004-01-01 22:31:57.000000000 -0600
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
diff -ur linux-2.4.23-orig/include/linux/pm.h linux-2.4.23/include/linux/pm.h
--- linux-2.4.23-orig/include/linux/pm.h	2004-01-01 22:11:01.000000000 -0600
+++ linux-2.4.23/include/linux/pm.h	2004-01-01 22:31:18.000000000 -0600
@@ -185,6 +185,10 @@
 
 #endif /* CONFIG_PM */
 
+#ifdef CONFIG_X86
+extern int pm_idle_poll;
+#endif
+
 extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
 
diff -ur linux-2.4.23-orig/include/linux/sysctl.h linux-2.4.23/include/linux/sysctl.h
--- linux-2.4.23-orig/include/linux/sysctl.h	2004-01-01 22:11:01.000000000 -0600
+++ linux-2.4.23/include/linux/sysctl.h	2004-01-01 22:19:07.000000000 -0600
@@ -128,6 +128,7 @@
 	KERN_PPC_L3CR=57,       /* l3cr register on PPC */
 	KERN_EXCEPTION_TRACE=58, /* boolean: exception trace */
  	KERN_CORE_SETUID=59,	/* int: set to allow core dumps of setuid apps */
+	KERN_IDLE_POLL=60,  	/* boolean: use polling for idle threads? */
 };
 
 
diff -ur linux-2.4.23-orig/kernel/sysctl.c linux-2.4.23/kernel/sysctl.c
--- linux-2.4.23-orig/kernel/sysctl.c	2004-01-01 22:11:01.000000000 -0600
+++ linux-2.4.23/kernel/sysctl.c	2004-01-01 22:20:01.000000000 -0600
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
 

--------------070607010003070805070501--

