Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWFRHbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWFRHbS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWFRHbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:31:18 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:39144 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932130AbWFRHbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:31:14 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][7/29] sched-iso-4.5
Date: Sun, 18 Jun 2006 17:31:07 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 11300
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181731.07304.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SCHED_ISO policy (isochronous) which is a starvation free soft
realtime policy available to unprivileged users. The amount of cpu that
SCHED_ISO tasks will run as realtime is configurable by the tunable in

/proc/sys/kernel/iso_cpu

and is set to 80% (over 3 seconds) by default.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 Documentation/sysctl/kernel.txt |    9 ++++
 include/linux/sched.h           |   10 +++--
 include/linux/sysctl.h          |    1 
 kernel/sched.c                  |   77 ++++++++++++++++++++++++++++++++++++----
 kernel/sysctl.c                 |   22 ++++++++---
 5 files changed, 104 insertions(+), 15 deletions(-)

Index: linux-ck-dev/include/linux/sched.h
===================================================================
--- linux-ck-dev.orig/include/linux/sched.h	2006-06-18 15:23:35.000000000 +1000
+++ linux-ck-dev/include/linux/sched.h	2006-06-18 15:23:38.000000000 +1000
@@ -164,9 +164,10 @@ extern unsigned long weighted_cpuload(co
 #define SCHED_FIFO		1
 #define SCHED_RR		2
 #define SCHED_BATCH		3
+#define SCHED_ISO		4
 
 #define SCHED_MIN		0
-#define SCHED_MAX		3
+#define SCHED_MAX		4
 
 #define SCHED_RANGE(policy)	((policy) <= SCHED_MAX)
 #define SCHED_RT(policy)	((policy) == SCHED_FIFO || \
@@ -209,7 +210,7 @@ extern void show_stack(struct task_struc
 
 void io_schedule(void);
 long io_schedule_timeout(long timeout);
-extern int sched_interactive, sched_compute;
+extern int sched_interactive, sched_compute, sched_iso_cpu;
 
 extern void cpu_init (void);
 extern void trap_init(void);
@@ -489,12 +490,14 @@ struct signal_struct {
 
 #define MAX_USER_RT_PRIO	100
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
+#define ISO_PRIO		(MAX_RT_PRIO - 1)
 
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
 #define MIN_USER_PRIO		(MAX_PRIO - 1)
 
-#define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))
+#define rt_task(p)		(unlikely(SCHED_RT((p)->policy)))
 #define batch_task(p)		(unlikely((p)->policy == SCHED_BATCH))
+#define iso_task(p)		(unlikely((p)->policy == SCHED_ISO))
 
 /*
  * Some day this will be a full-fledged user tracking system..
@@ -954,6 +957,7 @@ static inline void put_task_struct(struc
 #define PF_MEMPOLICY	0x10000000	/* Non-default NUMA mempolicy */
 #define PF_NONSLEEP	0x20000000	/* Waiting on in kernel activity */
 #define PF_FORKED	0x40000000	/* Task just forked another process */
+#define PF_ISOREF	0x80000000	/* SCHED_ISO task has used up quota */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: linux-ck-dev/include/linux/sysctl.h
===================================================================
--- linux-ck-dev.orig/include/linux/sysctl.h	2006-06-18 15:23:21.000000000 +1000
+++ linux-ck-dev/include/linux/sysctl.h	2006-06-18 15:23:38.000000000 +1000
@@ -150,6 +150,7 @@ enum
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
 	KERN_INTERACTIVE=73,	/* interactive tasks can have cpu bursts */
 	KERN_COMPUTE=74,	/* adjust timeslices for a compute server */
+	KERN_ISO_CPU=75,	/* percent cpu SCHED_ISO tasks run SCHED_RR */
 };
 
 
Index: linux-ck-dev/kernel/sched.c
===================================================================
--- linux-ck-dev.orig/kernel/sched.c	2006-06-18 15:23:35.000000000 +1000
+++ linux-ck-dev/kernel/sched.c	2006-06-18 15:23:38.000000000 +1000
@@ -62,10 +62,14 @@
  * raise its priority.
  * sched_compute - sysctl which enables long timeslices and delayed preemption
  * for compute server usage.
+ * sched_iso_cpu - sysctl which determines the cpu percentage SCHED_ISO tasks
+ * are allowed to run (over ISO_PERIOD seconds) as real time tasks.
  */
 int sched_interactive __read_mostly = 1;
 int sched_compute __read_mostly;
+int sched_iso_cpu __read_mostly = 80;
 
+#define ISO_PERIOD		(5 * HZ)
 /*
  * CACHE_DELAY is the time preemption is delayed in sched_compute mode
  * and is set to a nominal 10ms.
@@ -146,6 +150,9 @@ struct runqueue {
 
 	unsigned long long timestamp_last_tick;
 	unsigned short cache_ticks, preempted;
+	unsigned long iso_ticks;
+	unsigned short iso_refractory;
+
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
 	unsigned long bitmap[BITS_TO_LONGS(MAX_PRIO + 1)];
@@ -742,6 +749,17 @@ static int effective_prio(const task_t *
 	if (rt_task(p))
 		return p->prio;
 
+	if (iso_task(p)) {
+		if (likely(!(p->flags & PF_ISOREF)))
+			/*
+			 * If SCHED_ISO tasks have not used up their real time
+			 * quota they have run just better than highest
+			 * SCHED_NORMAL priority. Otherwise they run as
+			 * SCHED_NORMAL.
+			 */
+			return ISO_PRIO;
+	}
+
 	full_slice = slice(p);
 	if (full_slice > p->slice)
 		used_slice = full_slice - p->slice;
@@ -2632,6 +2650,22 @@ static void time_slice_expired(task_t *p
 }
 
 /*
+ * Test if SCHED_ISO tasks have run longer than their alloted period as RT
+ * tasks and set the refractory flag if necessary. There is 10% hysteresis
+ * for unsetting the flag.
+ */
+static inline unsigned int test_ret_isorefractory(runqueue_t *rq)
+{
+	if (likely(!rq->iso_refractory)) {
+		if (rq->iso_ticks / ISO_PERIOD > sched_iso_cpu)
+			rq->iso_refractory = 1;
+	} else
+		if (rq->iso_ticks / ISO_PERIOD < (sched_iso_cpu * 90 / 100))
+			rq->iso_refractory = 0;
+	return rq->iso_refractory;
+}
+
+/*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  */
@@ -2659,11 +2693,29 @@ void scheduler_tick(void)
 		set_tsk_need_resched(p);
 		goto out;
 	}
-	/* SCHED_FIFO tasks never run out of timeslice. */
-	if (unlikely(p->policy == SCHED_FIFO))
-		goto out;
 
 	spin_lock(&rq->lock);
+	if (unlikely((rt_task(p) || (iso_task(p) && !rq->iso_refractory)) &&
+	    p->mm)) {
+			if (rq->iso_ticks <= (ISO_PERIOD * 100) - 100)
+				rq->iso_ticks += 100;
+	} else
+		rq->iso_ticks = rq->iso_ticks * (ISO_PERIOD - 1) / ISO_PERIOD;
+
+	if (iso_task(p)) {
+		if (unlikely(test_ret_isorefractory(rq))) {
+			if (!(p->flags & PF_ISOREF)) {
+				set_tsk_need_resched(p);
+				p->flags |= PF_ISOREF;
+			}
+		} else
+			p->flags &= ~PF_ISOREF;
+	} else
+		/* SCHED_FIFO tasks never run out of timeslice. */
+		if (unlikely(p->policy == SCHED_FIFO))
+			goto out_unlock;
+
+
 	debit = ns_diff(rq->timestamp_last_tick, p->timestamp);
 	p->ns_debit += debit;
 	if (p->ns_debit < NSJIFFY)
@@ -2758,7 +2810,7 @@ static int dependent_sleeper(int this_cp
 	int ret = 0, i;
 
 	/* kernel/rt threads do not participate in dependent sleeping */
-	if (!p->mm || rt_task(p))
+	if (!p->mm || rt_task(p) || iso_task(p))
 		return 0;
 
 	for_each_domain(this_cpu, tmp) {
@@ -2795,7 +2847,7 @@ static int dependent_sleeper(int this_cp
 		 * task from using an unfair proportion of the
 		 * physical cpu's resources. -ck
 		 */
-		if (rt_task(smt_curr)) {
+		if (rt_task(smt_curr) || iso_task(smt_curr)) {
 			/*
 			 * With real time tasks we run non-rt tasks only
 			 * per_cpu_gain% of the time.
@@ -3567,9 +3619,19 @@ int sched_setscheduler(struct task_struc
 {
 	int retval;
 	int queued, oldprio, oldpolicy = -1;
+	struct sched_param zero_param = { .sched_priority = 0 };
 	unsigned long flags;
 	runqueue_t *rq;
 
+	if (SCHED_RT(policy) && !capable(CAP_SYS_NICE)) {
+		/*
+		 * If the caller requested an RT policy without having the
+		 * necessary rights, we downgrade the policy to SCHED_ISO.
+		 * We also set the parameter to zero to pass the checks.
+		 */
+		policy = SCHED_ISO;
+		param = &zero_param;
+	}
 recheck:
 	/* double check policy once rq lock held */
 	if (policy < 0)
@@ -4063,6 +4125,7 @@ asmlinkage long sys_sched_get_priority_m
 		break;
 	case SCHED_NORMAL:
 	case SCHED_BATCH:
+	case SCHED_ISO:
 		ret = 0;
 		break;
 	}
@@ -4087,6 +4150,7 @@ asmlinkage long sys_sched_get_priority_m
 		break;
 	case SCHED_NORMAL:
 	case SCHED_BATCH:
+	case SCHED_ISO:
 		ret = 0;
 	}
 	return ret;
@@ -5992,7 +6056,8 @@ void __init sched_init(void)
 
 		rq = cpu_rq(i);
 		spin_lock_init(&rq->lock);
-		rq->nr_running = rq->cache_ticks = rq->preempted = 0;
+		rq->nr_running = rq->cache_ticks = rq->preempted =
+			rq->iso_ticks = 0;
 
 #ifdef CONFIG_SMP
 		rq->sd = NULL;
Index: linux-ck-dev/kernel/sysctl.c
===================================================================
--- linux-ck-dev.orig/kernel/sysctl.c	2006-06-18 15:23:21.000000000 +1000
+++ linux-ck-dev/kernel/sysctl.c	2006-06-18 15:23:38.000000000 +1000
@@ -229,6 +229,11 @@ static ctl_table root_table[] = {
 	{ .ctl_name = 0 }
 };
 
+/* Constants for minimum and maximum testing.
+   We use these as one-element integer vectors. */
+static int zero;
+static int one_hundred = 100;
+
 static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_OSTYPE,
@@ -639,6 +644,17 @@ static ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= KERN_ISO_CPU,
+		.procname	= "iso_cpu",
+		.data		= &sched_iso_cpu,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &one_hundred,
+	},
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 	{
 		.ctl_name       = KERN_UNKNOWN_NMI_PANIC,
@@ -702,12 +718,6 @@ static ctl_table kern_table[] = {
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
Index: linux-ck-dev/Documentation/sysctl/kernel.txt
===================================================================
--- linux-ck-dev.orig/Documentation/sysctl/kernel.txt	2006-06-18 15:23:21.000000000 +1000
+++ linux-ck-dev/Documentation/sysctl/kernel.txt	2006-06-18 15:23:38.000000000 +1000
@@ -27,6 +27,7 @@ show up in /proc/sys/kernel:
 - hostname
 - hotplug
 - interactive
+- iso_cpu
 - java-appletviewer           [ binfmt_java, obsolete ]
 - java-interpreter            [ binfmt_java, obsolete ]
 - l2cr                        [ PPC only ]
@@ -182,6 +183,14 @@ are obeyed if this tunable is disabled. 
 
 ==============================================================
 
+iso_cpu:
+
+This sets the percentage cpu that the unprivileged SCHED_ISO tasks can
+run effectively at realtime priority, averaged over a rolling 3 seconds.
+Set to 80% by default.
+
+==============================================================
+
 l2cr: (PPC only)
 
 This flag controls the L2 cache of G3 processor boards. If

-- 
-ck
