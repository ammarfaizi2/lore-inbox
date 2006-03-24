Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWCXL2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWCXL2G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbWCXL2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:28:05 -0500
Received: from mail.gmx.de ([213.165.64.20]:403 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751670AbWCXL2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:28:04 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143199493.7741.32.camel@homer>
References: <1143198208.7741.8.camel@homer> <1143198459.7741.14.camel@homer>
	 <1143198964.7741.23.camel@homer>  <1143199295.7741.29.camel@homer>
	 <1143199493.7741.32.camel@homer>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 12:28:48 +0100
Message-Id: <1143199728.7741.37.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 6/6

This patch exports throttling tuning knobs to userland.  Should be
useful for testing, and in easily discarded should my throttling stuff
make it into mm, and survive the experience.

Signed-off-by: Mike Galbraith <efauklt@gmx.de>

--- linux-2.6.16-mm1/include/linux/sysctl.h.org	2006-03-24 09:43:37.000000000 +0100
+++ linux-2.6.16-mm1/include/linux/sysctl.h	2006-03-24 09:47:49.000000000 +0100
@@ -148,6 +148,8 @@
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+	KERN_SCHED_THROTTLE1=73,  /* int: throttling credit period 1 in secs */
+	KERN_SCHED_THROTTLE2=74,  /* int: throttling credit period 2 in secs */
 };
 
 
--- linux-2.6.16-mm1/kernel/sysctl.c.org	2006-03-24 09:43:14.000000000 +0100
+++ linux-2.6.16-mm1/kernel/sysctl.c	2006-03-24 09:47:49.000000000 +0100
@@ -73,6 +73,9 @@
 extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
+extern int credit_c1;
+extern int credit_c2;
+extern int credit_max;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -230,6 +233,11 @@
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
@@ -684,15 +692,31 @@
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
--- linux-2.6.16-mm1/kernel/sched.c-5.slice_accounting	2006-03-24 09:40:33.000000000 +0100
+++ linux-2.6.16-mm1/kernel/sched.c	2006-03-24 09:51:06.000000000 +0100
@@ -220,11 +220,12 @@
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


