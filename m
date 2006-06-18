Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWFRHav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWFRHav (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWFRHav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:30:51 -0400
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:26859 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932117AbWFRHau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:30:50 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][5/29] sched-staircase16_compute_tunable.patch
Date: Sun, 18 Jun 2006 17:30:47 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 7452
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181730.47688.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compute tunable for the staircase cpu scheduler. This modifies the
cpu scheduler behaviour for significantly longer cpu timeslices and delays
normal preemption to minimise the cpu cache harming effects of multiple
concurrent running tasks. This increases cpu throughput at the cost of
significantly increased latencies.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 Documentation/sysctl/kernel.txt |   11 +++++++++++
 include/linux/sched.h           |    2 +-
 include/linux/sysctl.h          |    1 +
 kernel/sched.c                  |   40 ++++++++++++++++++++++++++++++++--------
 kernel/sysctl.c                 |    8 ++++++++
 5 files changed, 53 insertions(+), 9 deletions(-)

Index: linux-ck-dev/include/linux/sched.h
===================================================================
--- linux-ck-dev.orig/include/linux/sched.h	2006-06-18 15:23:07.000000000 +1000
+++ linux-ck-dev/include/linux/sched.h	2006-06-18 15:23:21.000000000 +1000
@@ -202,7 +202,7 @@ extern void show_stack(struct task_struc
 
 void io_schedule(void);
 long io_schedule_timeout(long timeout);
-extern int sched_interactive;
+extern int sched_interactive, sched_compute;
 
 extern void cpu_init (void);
 extern void trap_init(void);
Index: linux-ck-dev/include/linux/sysctl.h
===================================================================
--- linux-ck-dev.orig/include/linux/sysctl.h	2006-06-18 15:23:07.000000000 +1000
+++ linux-ck-dev/include/linux/sysctl.h	2006-06-18 15:23:21.000000000 +1000
@@ -149,6 +149,7 @@ enum
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
 	KERN_INTERACTIVE=73,	/* interactive tasks can have cpu bursts */
+	KERN_COMPUTE=74,	/* adjust timeslices for a compute server */
 };
 
 
Index: linux-ck-dev/kernel/sched.c
===================================================================
--- linux-ck-dev.orig/kernel/sched.c	2006-06-18 15:23:07.000000000 +1000
+++ linux-ck-dev/kernel/sched.c	2006-06-18 15:23:21.000000000 +1000
@@ -60,8 +60,17 @@
 /*
  * sched_interactive - sysctl which allows interactive tasks to have bonus
  * raise its priority.
+ * sched_compute - sysctl which enables long timeslices and delayed preemption
+ * for compute server usage.
  */
 int sched_interactive __read_mostly = 1;
+int sched_compute __read_mostly;
+
+/*
+ * CACHE_DELAY is the time preemption is delayed in sched_compute mode
+ * and is set to a nominal 10ms.
+ */
+#define CACHE_DELAY	(10 * (HZ) / 1001 + 1)
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -92,9 +101,10 @@ int sched_interactive __read_mostly = 1;
 
 /*
  * This is the time all tasks within the same priority round robin.
- * Set to a minimum of 6ms.
+ * Set to a minimum of 6ms. It is 10 times longer in compute mode.
  */
-#define RR_INTERVAL		((6 * HZ / 1001) + 1)
+#define _RR_INTERVAL		((6 * HZ / 1001) + 1)
+#define RR_INTERVAL		(_RR_INTERVAL * (1 + 9 * sched_compute))
 #define DEF_TIMESLICE		(RR_INTERVAL * 19)
 
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->timestamp)	\
@@ -135,6 +145,7 @@ struct runqueue {
 	unsigned long nr_uninterruptible;
 
 	unsigned long long timestamp_last_tick;
+	unsigned short cache_ticks, preempted;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
 	unsigned long bitmap[BITS_TO_LONGS(MAX_PRIO + 1)];
@@ -737,7 +748,7 @@ static int effective_prio(const task_t *
 
 	best_bonus = bonus(p);
 	prio = MAX_RT_PRIO + best_bonus;
-	if (sched_interactive && !batch_task(p))
+	if (sched_interactive && !sched_compute && !batch_task(p))
 		prio -= p->bonus;
 
 	rr = rr_interval(p);
@@ -1209,12 +1220,21 @@ static inline int wake_idle(int cpu, tas
 #endif
 
 /*
- * Check to see if p preempts rq->curr and resched if it does.
+ * Check to see if p preempts rq->curr and resched if it does. In compute
+ * mode we do not preempt for at least CACHE_DELAY and set rq->preempted.
  */
-static inline void preempt(const task_t *p, runqueue_t *rq)
+static void fastcall preempt(const task_t *p, runqueue_t *rq)
 {
-	if (TASK_PREEMPTS_CURR(p, rq))
-		resched_task(rq->curr);
+	task_t *curr = rq->curr;
+
+	if (p->prio >= curr->prio)
+		return;
+	if (!sched_compute || rq->cache_ticks >= CACHE_DELAY || !p->mm ||
+	    rt_task(p) || curr == rq->idle) {
+		resched_task(curr);
+		return;
+	}
+	rq->preempted = 1;
 }
 
 /***
@@ -2667,6 +2687,9 @@ void scheduler_tick(void)
 		time_slice_expired(p, rq);
 		goto out_unlock;
 	}
+	rq->cache_ticks++;
+	if (rq->preempted && rq->cache_ticks >= CACHE_DELAY)
+		set_tsk_need_resched(p);
 out_unlock:
 	spin_unlock(&rq->lock);
 out:
@@ -2933,6 +2956,7 @@ switch_tasks:
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
+		rq->preempted = rq->cache_ticks = 0;
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
@@ -5971,7 +5995,7 @@ void __init sched_init(void)
 
 		rq = cpu_rq(i);
 		spin_lock_init(&rq->lock);
-		rq->nr_running = 0;
+		rq->nr_running = rq->cache_ticks = rq->preempted = 0;
 
 #ifdef CONFIG_SMP
 		rq->sd = NULL;
Index: linux-ck-dev/kernel/sysctl.c
===================================================================
--- linux-ck-dev.orig/kernel/sysctl.c	2006-06-18 15:23:07.000000000 +1000
+++ linux-ck-dev/kernel/sysctl.c	2006-06-18 15:23:21.000000000 +1000
@@ -631,6 +631,14 @@ static ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= KERN_COMPUTE,
+		.procname	= "compute",
+		.data		= &sched_compute,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 	{
 		.ctl_name       = KERN_UNKNOWN_NMI_PANIC,
Index: linux-ck-dev/Documentation/sysctl/kernel.txt
===================================================================
--- linux-ck-dev.orig/Documentation/sysctl/kernel.txt	2006-06-18 15:23:07.000000000 +1000
+++ linux-ck-dev/Documentation/sysctl/kernel.txt	2006-06-18 15:23:21.000000000 +1000
@@ -18,6 +18,7 @@ Currently, these files might (depending 
 show up in /proc/sys/kernel:
 - acpi_video_flags
 - acct
+- compute
 - core_pattern
 - core_uses_pid
 - ctrl-alt-del
@@ -85,6 +86,16 @@ valid for 30 seconds.
 
 ==============================================================
 
+compute:
+
+This flag controls the long timeslice, delayed preemption mode in the
+cpu scheduler suitable for scientific computation applications. It
+leads to large latencies so is unsuitable for normal usage.
+
+Disabled by default.
+
+==============================================================
+
 core_pattern:
 
 core_pattern is used to specify a core dumpfile pattern name.

-- 
-ck
