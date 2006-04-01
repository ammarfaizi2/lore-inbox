Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWDAJbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWDAJbX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 04:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWDAJbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 04:31:23 -0500
Received: from mail.gmx.de ([213.165.64.20]:55937 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750887AbWDAJbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 04:31:22 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-mm2 9/9] sched throttle tree extract - export
	tunables
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143883607.7617.71.camel@homer>
References: <1143880124.7617.5.camel@homer> <1143880397.7617.10.camel@homer>
	 <1143880683.7617.16.camel@homer>  <1143881058.7617.24.camel@homer>
	 <1143881494.7617.32.camel@homer>  <1143881983.7617.41.camel@homer>
	 <1143882731.7617.55.camel@homer>  <1143883385.7617.66.camel@homer>
	 <1143883607.7617.71.camel@homer>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 11:31:55 +0200
Message-Id: <1143883915.7617.77.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a convenience for people testing this patch series.  It
exports throttling tunables to userland, and is utterly disposable.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm2/include/linux/sysctl.h.org	2006-03-31 11:25:16.000000000 +0200
+++ linux-2.6.16-mm2/include/linux/sysctl.h	2006-03-31 14:08:28.000000000 +0200
@@ -148,6 +148,8 @@ enum
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+	KERN_SCHED_THROTTLE1=73,  /* int: throttling credit period 1 in secs */
+	KERN_SCHED_THROTTLE2=74,  /* int: throttling credit period 2 in secs */
 };
 
 
--- linux-2.6.16-mm2/kernel/sysctl.c.org	2006-03-31 11:24:50.000000000 +0200
+++ linux-2.6.16-mm2/kernel/sysctl.c	2006-03-31 14:08:28.000000000 +0200
@@ -73,6 +73,9 @@ extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
+extern int credit_c1;
+extern int credit_c2;
+extern int credit_max;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -230,6 +233,11 @@ static ctl_table root_table[] = {
 	{ .ctl_name = 0 }
 };
 
+/* Constants for minimum and maximum testing in vm_table and
+ * kern_table.  We use these as one-element integer vectors. */
+static int zero;
+static int one_hundred = 100;
+
 static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_OSTYPE,
@@ -684,15 +692,31 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+	{
+		.ctl_name	= KERN_SCHED_THROTTLE1,
+		.procname	= "credit_c1",
+		.data		= &credit_c1,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &credit_max,
+	},
+	{
+		.ctl_name	= KERN_SCHED_THROTTLE2,
+		.procname	= "credit_c2",
+		.data		= &credit_c2,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &credit_max,
+	},
 	{ .ctl_name = 0 }
 };
 
-/* Constants for minimum and maximum testing in vm_table.
-   We use these as one-element integer vectors. */
-static int zero;
-static int one_hundred = 100;
-
-
 static ctl_table vm_table[] = {
 	{
 		.ctl_name	= VM_OVERCOMMIT_MEMORY,
--- linux-2.6.16-mm2/kernel/sched.c-8.slice_accounting	2006-03-24 09:40:33.000000000 +0100
+++ linux-2.6.16-mm2/kernel/sched.c	2006-03-24 09:51:06.000000000 +0100
@@ -220,11 +220,12 @@ static int task_interactive_idle(task_t 
  *           credit that fits in 32 bits jiffies is 42949 seconds.
  */
 
-#define CREDIT_C1 10
-#define CREDIT_C2 14400
+int credit_c1 = 10;
+int credit_c2 = 14400;
+int credit_max = 42949;
 
-#define C1 (CREDIT_C1 * MAX_BONUS * HZ)
-#define C2 (CREDIT_C2 * MAX_BONUS * HZ + C1)
+#define C1 (credit_c1 * MAX_BONUS * HZ)
+#define C2 (credit_c2 * MAX_BONUS * HZ + C1)
 #define C3 (MAX_BONUS * C2)
 
 #define credit_exhausted(p, credit) \


