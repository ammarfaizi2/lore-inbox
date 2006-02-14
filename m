Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbWBNHq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWBNHq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 02:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWBNHq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 02:46:26 -0500
Received: from fmr21.intel.com ([143.183.121.13]:18581 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030360AbWBNHqZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 02:46:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 0/2] fix perf. bug in wake-up load balancing for aim7 and db workload
Date: Mon, 13 Feb 2006 23:46:10 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB509AAE8BD@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 0/2] fix perf. bug in wake-up load balancing for aim7 and db workload
Thread-Index: AcYxHGOYiPKKLSgESGao1//0RcDRAwAGh2ow
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Feb 2006 07:46:13.0011 (UTC) FILETIME=[BA4CFE30:01C6313A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Monday, February 13, 2006 8:00 PM
> Ho hum.  Well could someone please resend Ken's sysctl-knob patch,
> this time 
> 
> a) with a good changelog which is useful to people who write things to
>    /proc.  ie: end users, not scheduler hackers and
> 
> b) with an update to Documentation/kernel-parameters.txt and
> 
> c) if poss, with a better name?  Something which describes what its
>    effect is upon the overall system not its effect upon mysterious
>    scheduler internals.
> 
> If this thing is to be useful to administrators, they actually have to
> have a chance of understanding what it does.


Here is a respin of the patch with more documentation. I can't come up
with a better name without make it long: cpu_load_balance_on_wakeup?
(quickly duck behind a bunker).



[patch] add sysctl to control wake up load balancing

Some workload like aim7 relies on CPU load balancing action in the
wake-up path to achieve best performance.  Process wake-up time is
typically a good opportunity for kernel to perform CPU load balance
and by using heuristics, it can perform relatively well for workloads
that exhibits large dynamics.  However, there are other workload which
exhibit fixed wake-up pattern, i.e. because of interrupt binding or
already established balanced CPU load via periodic load balancing,
such balancing action in wake up will disturb the system and cause
excessive process migration.  Experiments showed that for aim7 type
of workload, 10% performance is gained if load balance is performed,
while 2.3% performance is gained for db transaction processing workload
if load balance is not performed.  Because of opposite requirements
for these two type of environment, it is best to have a sysctl variable
to control the behavior of load balancing in wake up path, so user can
dynamically select a mode that best fit for the workload environment.
And kernel can achieve best performance in two extreme ends of
incompatible workload environments.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- linux-2.6.16-rc2/Documentation/filesystems/proc.txt.orig
2006-02-14 00:06:14.692245170 -0800
+++ linux-2.6.16-rc2/Documentation/filesystems/proc.txt	2006-02-14
00:08:37.735212168 -0800
@@ -1130,6 +1130,22 @@ If a system hangs up, try pressing the N
    And NMI watchdog will be disabled when the value in this file is set
to
    non-zero.
 
+wake_balance
+------------
+
+When value in this file is 1 [default], kernel will performance CPU
load
+balance when wake up process.  Wake-up is a term used to describe
transition
+of a sleeping process become run-able and getting scheduled on
available CPU.
+Kernel uses heuristics to achieve best performance for vast majority of
+workloads, e.g. workloads exhibit large amount of dynamics.  When the
value
+is 0, kernel will not perform any CPU load balance and directly queue
up the
+process on the CPU that was previously ran. This is best suitable for
workload
+environment that exhibit fixed wake-up pattern or already established
balanced
+CPU load via periodic load balancing.  Thus keep disturbance on process
+migration to minimal.  If such value is to be changed from the default,
it
+is recommended that sys admin to measure the effect. If in doubt, use
default
+value.
+
 2.4 /proc/sys/vm - The virtual memory subsystem
 -----------------------------------------------
 
--- linux-2.6.16-rc2/include/linux/sysctl.h.orig	2006-02-13
18:48:13.287205480 -0800
+++ linux-2.6.16-rc2/include/linux/sysctl.h	2006-02-13
18:49:32.138767014 -0800
@@ -146,6 +146,7 @@ enum
 	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid
core */
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
+	KERN_WAKE_BALANCE=71,	/* int: load balance on wakeup */
 };
 
 
--- linux-2.6.16-rc2/kernel/sched.c.orig	2006-02-13
18:24:03.035270121 -0800
+++ linux-2.6.16-rc2/kernel/sched.c	2006-02-13 19:04:22.872154540
-0800
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
 
--- linux-2.6.16-rc2/kernel/sysctl.c.orig	2006-02-13
18:49:44.342868427 -0800
+++ linux-2.6.16-rc2/kernel/sysctl.c	2006-02-13 18:52:37.038178812
-0800
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
 
