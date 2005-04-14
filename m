Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVDNXoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVDNXoC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 19:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVDNXoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 19:44:02 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:55145 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S261653AbVDNXnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 19:43:50 -0400
Date: Thu, 14 Apr 2005 16:43:22 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] hangcheck-timer: Update to 0.9.0.
Message-ID: <20050414234322.GD31163@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050412235033.GI31163@ca-server1.us.oracle.com> <20050412171801.444df4bc.akpm@osdl.org> <20050413003804.GJ31163@ca-server1.us.oracle.com> <20050412174726.168df393.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412174726.168df393.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.8i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
	I recently realized that the in-kernel copy of hangcheck-timer
was quite stale.  Here's the latest.  It adds support for s390, ppc64,
and ia64 too.

Signed-off-by: Joel Becker <joel.becker@oracle.com>
---

 Kconfig           |    2 -
 hangcheck-timer.c |  104 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 96 insertions(+), 10 deletions(-)

Index: linux-2.6.12-rc2/drivers/char/hangcheck-timer.c
===================================================================
--- linux-2.6.12-rc2.orig/drivers/char/hangcheck-timer.c	2005-03-01 23:38:07.000000000 -0800
+++ linux-2.6.12-rc2/drivers/char/hangcheck-timer.c	2005-04-14 15:32:03.000000000 -0700
@@ -3,7 +3,7 @@
  *
  * Driver for a little io fencing timer.
  *
- * Copyright (C) 2002 Oracle Corporation.  All rights reserved.
+ * Copyright (C) 2002, 2003 Oracle.  All rights reserved.
  *
  * Author: Joel Becker <joel.becker@oracle.com>
  *
@@ -44,11 +44,14 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/reboot.h>
+#include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
+#include <linux/sysrq.h>
 
 
-#define VERSION_STR "0.5.0"
+#define VERSION_STR "0.9.0"
 
 #define DEFAULT_IOFENCE_MARGIN 60	/* Default fudge factor, in seconds */
 #define DEFAULT_IOFENCE_TICK 180	/* Default timer timeout, in seconds */
@@ -56,18 +59,89 @@
 static int hangcheck_tick = DEFAULT_IOFENCE_TICK;
 static int hangcheck_margin = DEFAULT_IOFENCE_MARGIN;
 static int hangcheck_reboot;  /* Defaults to not reboot */
+static int hangcheck_dump_tasks;  /* Defaults to not dumping SysRQ T */
 
-/* Driver options */
+/* options - modular */
 module_param(hangcheck_tick, int, 0);
 MODULE_PARM_DESC(hangcheck_tick, "Timer delay.");
 module_param(hangcheck_margin, int, 0);
 MODULE_PARM_DESC(hangcheck_margin, "If the hangcheck timer has been delayed more than hangcheck_margin seconds, the driver will fire.");
 module_param(hangcheck_reboot, int, 0);
 MODULE_PARM_DESC(hangcheck_reboot, "If nonzero, the machine will reboot when the timer margin is exceeded.");
+module_param(hangcheck_dump_tasks, int, 0);
+MODULE_PARM_DESC(hangcheck_dump_tasks, "If nonzero, the machine will dump the system task state when the timer margin is exceeded.");
 
-MODULE_AUTHOR("Joel Becker");
+MODULE_AUTHOR("Oracle");
 MODULE_DESCRIPTION("Hangcheck-timer detects when the system has gone out to lunch past a certain margin.");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(VERSION_STR);
+
+/* options - nonmodular */
+#ifndef MODULE
+
+static int __init hangcheck_parse_tick(char *str)
+{
+	int par;
+	if (get_option(&str,&par))
+		hangcheck_tick = par;
+	return 1;
+}
+
+static int __init hangcheck_parse_margin(char *str)
+{
+	int par;
+	if (get_option(&str,&par))
+		hangcheck_margin = par;
+	return 1;
+}
+
+static int __init hangcheck_parse_reboot(char *str)
+{
+	int par;
+	if (get_option(&str,&par))
+		hangcheck_reboot = par;
+	return 1;
+}
+
+static int __init hangcheck_parse_dump_tasks(char *str)
+{
+	int par;
+	if (get_option(&str,&par))
+		hangcheck_dump_tasks = par;
+	return 1;
+}
+
+__setup("hcheck_tick", hangcheck_parse_tick);
+__setup("hcheck_margin", hangcheck_parse_margin);
+__setup("hcheck_reboot", hangcheck_parse_reboot);
+__setup("hcheck_dump_tasks", hangcheck_parse_dump_tasks);
+#endif /* not MODULE */
+
+#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
+# define HAVE_MONOTONIC
+# define TIMER_FREQ 1000000000ULL
+#elif defined(CONFIG_ARCH_S390)
+/* FA240000 is 1 Second in the IBM time universe (Page 4-38 Principles of Op for zSeries */
+# define TIMER_FREQ 0xFA240000ULL
+#elif defined(CONFIG_IA64)
+# define TIMER_FREQ ((unsigned long long)local_cpu_data->itc_freq)
+#elif defined(CONFIG_PPC64)
+# define TIMER_FREQ (HZ*loops_per_jiffy)
+#endif
+
+#ifdef HAVE_MONOTONIC
+extern unsigned long long monotonic_clock(void);
+#else
+static inline unsigned long long monotonic_clock(void)
+{
+# ifdef __s390__
+	/* returns the TOD.  see 4-38 Principles of Op of zSeries */
+	return get_clock();
+# else
+	return get_cycles();
+# endif  /* __s390__ */
+}
+#endif  /* HAVE_MONOTONIC */
 
 
 /* Last time scheduled */
@@ -78,7 +152,6 @@
 static struct timer_list hangcheck_ticktock =
 		TIMER_INITIALIZER(hangcheck_fire, 0, 0);
 
-extern unsigned long long monotonic_clock(void);
 
 static void hangcheck_fire(unsigned long data)
 {
@@ -92,6 +165,12 @@
 		tsc_diff = (cur_tsc + (~0ULL - hangcheck_tsc)); /* or something */
 
 	if (tsc_diff > hangcheck_tsc_margin) {
+		if (hangcheck_dump_tasks) {
+			printk(KERN_CRIT "Hangcheck: Task state:\n");
+#ifdef CONFIG_MAGIC_SYSRQ
+			handle_sysrq('t', NULL, NULL);
+#endif  /* CONFIG_MAGIC_SYSRQ */
+		}
 		if (hangcheck_reboot) {
 			printk(KERN_CRIT "Hangcheck: hangcheck is restarting the machine.\n");
 			machine_restart(NULL);
@@ -108,10 +187,16 @@
 {
 	printk("Hangcheck: starting hangcheck timer %s (tick is %d seconds, margin is %d seconds).\n",
 	       VERSION_STR, hangcheck_tick, hangcheck_margin);
-
-	hangcheck_tsc_margin = hangcheck_margin + hangcheck_tick;
-	hangcheck_tsc_margin *= 1000000000;
-
+#if defined (HAVE_MONOTONIC)
+	printk("Hangcheck: Using monotonic_clock().\n");
+#elif defined(__s390__)
+	printk("Hangcheck: Using TOD.\n");
+#else
+	printk("Hangcheck: Using get_cycles().\n");
+#endif  /* HAVE_MONOTONIC */
+	hangcheck_tsc_margin =
+		(unsigned long long)(hangcheck_margin + hangcheck_tick);
+	hangcheck_tsc_margin *= (unsigned long long)TIMER_FREQ;
 
 	hangcheck_tsc = monotonic_clock();
 	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));
@@ -123,6 +208,7 @@
 static void __exit hangcheck_exit(void)
 {
 	del_timer_sync(&hangcheck_ticktock);
+        printk("Hangcheck: Stopped hangcheck timer.\n");
 }
 
 module_init(hangcheck_init);
Index: linux-2.6.12-rc2/drivers/char/Kconfig
===================================================================
--- linux-2.6.12-rc2.orig/drivers/char/Kconfig	2005-04-12 15:33:39.000000000 -0700
+++ linux-2.6.12-rc2/drivers/char/Kconfig	2005-04-12 15:34:26.000000000 -0700
@@ -968,7 +968,7 @@
 
 config HANGCHECK_TIMER
 	tristate "Hangcheck timer"
-	depends on X86_64 || X86
+	depends on X86_64 || X86 || IA64 || PPC64 || ARCH_S390
 	help
 	  The hangcheck-timer module detects when the system has gone
 	  out to lunch past a certain margin.  It can reboot the system
-- 

Viro's Razor:
	Any race condition, no matter how unlikely, will occur just
	often enough to bite you.

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
