Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWBNDOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWBNDOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 22:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWBNDOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 22:14:42 -0500
Received: from fmr21.intel.com ([143.183.121.13]:44674 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030215AbWBNDOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 22:14:42 -0500
Message-Id: <200602140314.k1E3EWg17639@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, "'Ingo Molnar'" <mingo@elte.hu>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch 2/2] fix perf. bug in wake-up load balancing for aim7 and db workload
Date: Mon, 13 Feb 2006 19:14:32 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYxFAK2pbwTbFOMQ5WU5455NIBdvQAAH8NA
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysctl to control wake-balance behavior.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- linux-2.6.16-rc2/include/linux/sysctl.h.orig	2006-02-13 18:48:13.287205480 -0800
+++ linux-2.6.16-rc2/include/linux/sysctl.h	2006-02-13 18:49:32.138767014 -0800
@@ -146,6 +146,7 @@ enum
 	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
+	KERN_WAKE_BALANCE=71,	/* int: load balance on wakeup */
 };
 
 
--- linux-2.6.16-rc2/kernel/sched.c.orig	2006-02-13 18:24:03.035270121 -0800
+++ linux-2.6.16-rc2/kernel/sched.c	2006-02-13 19:04:22.872154540 -0800
@@ -1237,6 +1237,8 @@ static inline int wake_idle(int cpu, tas
 }
 #endif
 
+int sysctl_wake_balance=1;
+
 /***
  * try_to_wake_up - wake up a thread
  * @p: the to-be-woken-up thread
@@ -1294,6 +1296,9 @@ static int try_to_wake_up(task_t *p, uns
 		}
 	}
 
+	if (!sysctl_wake_balance)
+		goto out_activate;
+
 	if (unlikely(!cpu_isset(this_cpu, p->cpus_allowed)))
 		goto out_set_cpu;
 
--- linux-2.6.16-rc2/kernel/sysctl.c.orig	2006-02-13 18:49:44.342868427 -0800
+++ linux-2.6.16-rc2/kernel/sysctl.c	2006-02-13 18:52:37.038178812 -0800
@@ -71,6 +71,7 @@ extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
+extern int sysctl_wake_balance;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -658,6 +659,14 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+	{
+		.ctl_name	= KERN_WAKE_BALANCE,
+		.procname	= "wake_balance",
+		.data		= &sysctl_wake_balance,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 

