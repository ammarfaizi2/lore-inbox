Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWFRHaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWFRHaI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWFRHaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:30:07 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:33492 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932115AbWFRHaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:30:06 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][4/29] sched-staircase16_interactive_tunable
Date: Sun, 18 Jun 2006 17:30:03 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 5014
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181730.04040.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the interactive tunable for the staircase cpu scheduler. The default
behaviour is for nice value to determine cpu proportion only, and wakeup
latency is determined by the percentage of the cpu entitlement of a task. The
interactive tunable modifies this behaviour such that nice value determines
both cpu proportion and wakeup latency.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 Documentation/sysctl/kernel.txt |   10 ++++++++++
 include/linux/sched.h           |    1 +
 include/linux/sysctl.h          |    1 +
 kernel/sched.c                  |    8 +++++++-
 kernel/sysctl.c                 |    8 ++++++++
 5 files changed, 27 insertions(+), 1 deletion(-)

Index: linux-ck-dev/include/linux/sched.h
===================================================================
--- linux-ck-dev.orig/include/linux/sched.h	2006-06-18 15:23:05.000000000 +1000
+++ linux-ck-dev/include/linux/sched.h	2006-06-18 15:23:07.000000000 +1000
@@ -202,6 +202,7 @@ extern void show_stack(struct task_struc
 
 void io_schedule(void);
 long io_schedule_timeout(long timeout);
+extern int sched_interactive;
 
 extern void cpu_init (void);
 extern void trap_init(void);
Index: linux-ck-dev/include/linux/sysctl.h
===================================================================
--- linux-ck-dev.orig/include/linux/sysctl.h	2006-06-18 15:23:05.000000000 +1000
+++ linux-ck-dev/include/linux/sysctl.h	2006-06-18 15:23:07.000000000 +1000
@@ -148,6 +148,7 @@ enum
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+	KERN_INTERACTIVE=73,	/* interactive tasks can have cpu bursts */
 };
 
 
Index: linux-ck-dev/kernel/sysctl.c
===================================================================
--- linux-ck-dev.orig/kernel/sysctl.c	2006-06-18 15:23:05.000000000 +1000
+++ linux-ck-dev/kernel/sysctl.c	2006-06-18 15:23:07.000000000 +1000
@@ -623,6 +623,14 @@ static ctl_table kern_table[] = {
 		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= KERN_INTERACTIVE,
+		.procname	= "interactive",
+		.data		= &sched_interactive,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 	{
 		.ctl_name       = KERN_UNKNOWN_NMI_PANIC,
Index: linux-ck-dev/kernel/sched.c
===================================================================
--- linux-ck-dev.orig/kernel/sched.c	2006-06-18 15:23:05.000000000 +1000
+++ linux-ck-dev/kernel/sched.c	2006-06-18 15:23:07.000000000 +1000
@@ -58,6 +58,12 @@
 #include <asm/unistd.h>
 
 /*
+ * sched_interactive - sysctl which allows interactive tasks to have bonus
+ * raise its priority.
+ */
+int sched_interactive __read_mostly = 1;
+
+/*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
  * and back.
@@ -731,7 +737,7 @@ static int effective_prio(const task_t *
 
 	best_bonus = bonus(p);
 	prio = MAX_RT_PRIO + best_bonus;
-	if (!batch_task(p))
+	if (sched_interactive && !batch_task(p))
 		prio -= p->bonus;
 
 	rr = rr_interval(p);
Index: linux-ck-dev/Documentation/sysctl/kernel.txt
===================================================================
--- linux-ck-dev.orig/Documentation/sysctl/kernel.txt	2006-06-18 15:23:05.000000000 +1000
+++ linux-ck-dev/Documentation/sysctl/kernel.txt	2006-06-18 15:23:07.000000000 +1000
@@ -25,6 +25,7 @@ show up in /proc/sys/kernel:
 - domainname
 - hostname
 - hotplug
+- interactive
 - java-appletviewer           [ binfmt_java, obsolete ]
 - java-interpreter            [ binfmt_java, obsolete ]
 - l2cr                        [ PPC only ]
@@ -161,6 +162,15 @@ Default value is "/sbin/hotplug".
 
 ==============================================================
 
+interactive:
+
+This flag controls the allocation of dynamic priorities in the cpu
+scheduler. It gives low cpu using tasks high priority for lowest
+latencies. Nice value is still observed but stricter cpu proportions
+are obeyed if this tunable is disabled. Enabled by default.
+
+==============================================================
+
 l2cr: (PPC only)
 
 This flag controls the L2 cache of G3 processor boards. If

-- 
-ck
