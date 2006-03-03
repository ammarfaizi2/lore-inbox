Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWCCK4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWCCK4r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 05:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWCCK4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 05:56:47 -0500
Received: from mail.gmx.de ([213.165.64.20]:5791 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750840AbWCCK4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 05:56:46 -0500
X-Authenticated: #14349625
Subject: [patch 2.6.16-rc5-mm2]  sched_throttle-V17 - task throttling patch
	2 of 2
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: mingo@elte.hu, kernel@kolivas.org, pwil3058@bigpond.net.au,
       nickpiggin@yahoo.com.au, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1141382609.8768.57.camel@homer>
References: <1140183903.14128.77.camel@homer>
	 <1140812981.8713.35.camel@homer>  <20060224141505.41b1a627.akpm@osdl.org>
	 <1140834190.7641.25.camel@homer>  <1141382609.8768.57.camel@homer>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 11:58:27 +0100
Message-Id: <1141383507.8768.72.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diff 2 of 2, the throttling itself.  Primary changes since the last
version is that I no longer dink around with the task's priority
directly.  Carefully trimming excess sleep_avg at timeslice refresh time
works just about as well, and makes the patch look a heck of a lot
better.

I've also done away with a division that was in the fast path, and fixed
a bug in the 'concession to interactivity' bits in refresh_timeslice()
which had it working more by accident than design.  With this diff, I
can set grace_g0 to zero seconds, and still have a very nice interactive
kernel.  grace_g2 has to be also set to zero to completely disable
interactivity logic.

Comments?

	-Mike

signed-off-by: Mike Galbraith <efault@gmx.de>

 include/linux/sched.h  |    4 
 include/linux/sysctl.h |    2 
 kernel/sched.c         |  249 +++++++++++++++++++++++++++++++++++++++++++++----
 kernel/sysctl.c        |   36 +++++--
 4 files changed, 267 insertions(+), 24 deletions(-)

--- linux-2.6.16-rc5-mm2/include/linux/sched.h.org	2006-02-28 06:11:17.000000000 +0100
+++ linux-2.6.16-rc5-mm2/include/linux/sched.h	2006-02-28 06:11:41.000000000 +0100
@@ -713,7 +713,7 @@
 	unsigned short ioprio;
 	unsigned int btrace_seq;
 
-	unsigned long sleep_avg;
+	unsigned long sleep_avg, last_slice, throttle;
 	unsigned long long timestamp, last_ran;
 	unsigned long long sched_time; /* sched_clock time spent running */
 	enum sleep_type sleep_type;
@@ -721,7 +721,7 @@
 	unsigned long policy;
 	cpumask_t cpus_allowed;
 	int time_slice;
-	unsigned int first_time_slice;
+	unsigned int slice_info;
 
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
--- linux-2.6.16-rc5-mm2/include/linux/sysctl.h.org	2006-02-28 06:11:29.000000000 +0100
+++ linux-2.6.16-rc5-mm2/include/linux/sysctl.h	2006-02-28 06:11:41.000000000 +0100
@@ -148,6 +148,8 @@
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+	KERN_SCHED_THROTTLE1=73,  /* int: throttling grace period 1 in secs */
+	KERN_SCHED_THROTTLE2=74,  /* int: throttling grace period 2 in secs */
 };
 
 
--- linux-2.6.16-rc5-mm2/kernel/sched.c.org	2006-02-28 06:10:31.000000000 +0100
+++ linux-2.6.16-rc5-mm2/kernel/sched.c	2006-02-28 06:53:54.000000000 +0100
@@ -80,6 +80,21 @@
 #define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
 #define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
 
+#if (BITS_PER_LONG < 64)
+#define JIFFIES_TO_NS64(TIME) \
+	((unsigned long long)(TIME) * ((unsigned long) (1000000000 / HZ)))
+
+#define NS64_TO_JIFFIES(TIME) \
+	((((unsigned long long)((TIME)) >> BITS_PER_LONG) * \
+	(1 + NS_TO_JIFFIES(~0UL))) + NS_TO_JIFFIES((unsigned long)(TIME)))
+#else /* BITS_PER_LONG < 64 */
+
+#define NS64_TO_JIFFIES(TIME) NS_TO_JIFFIES(TIME)
+#define JIFFIES_TO_NS64(TIME) JIFFIES_TO_NS(TIME)
+
+#endif /* BITS_PER_LONG < 64 */
+
+
 /*
  * These are the 'tuning knobs' of the scheduler:
  *
@@ -177,6 +192,115 @@
 	return p->sleep_avg + sleep_time >= INTERACTIVE_SLEEP_AVG(p);
 }
 
+/*
+ * Interactive boost can lead to starvation if the decision to
+ * boost a task turns out to be a bad one.  To combat this, we
+ * compute the sane upper limit for cpu usage 'slice_avg' based
+ * upon a task's sleep_avg, and use this information combined
+ * with a timer to determine when intervention is required.
+ *
+ * When a task is behaving as it's sleep_avg indicates it should,
+ * it's throttle is moved forward, otherwise it will timeout, and
+ * the task's priority will be lowered.
+ *
+ * /proc/sys/kernel tunables.
+ *
+ * grace_g1: The amount of cpu time in seconds that a new task
+ *           will run completely free, ie the head start a task
+ *           has to get far enough ahead of it's timer that it
+ *           can aviod being throttled.  Each conforming slice
+ *           thereafter increases it's lead, and vice versa.
+ *
+ * grace_g2: The maximum amount of 'good carma' a task can save
+ *           for later use.
+ */
+
+int grace_g1 = 10;
+int grace_g2 = 14400;
+int grace_max = 42949;
+
+#define G1 (grace_g1 * MAX_BONUS * HZ)
+#define G2 (grace_g2 * MAX_BONUS * HZ + G1)
+
+/*
+ * Depth of task hell.
+ */
+#define G3 (MAX_BONUS * G2)
+
+#define grace_expired(p, grace) \
+	(time_after(jiffies, (p)->throttle + (grace)))
+
+/*
+ * Masks for p->slice_info, formerly p->first_time_slice.
+ * SLICE_FTS:   0x80000000  Task is in it's first ever timeslice.
+ * SLICE_NEW:   0x40000000  Slice refreshed.
+ * SLICE_SPA:   0x3FFE0000  Spare bits.
+ * SLICE_LTS:   0x0001FF80  Last time slice
+ * SLICE_AVG:   0x0000007F  Task slice_avg stored as percentage.
+ */
+#define SLICE_AVG_BITS    7
+#define SLICE_LTS_BITS   10
+#define SLICE_SPA_BITS   13
+#define SLICE_NEW_BITS    1
+#define SLICE_FTS_BITS    1
+
+#define SLICE_AVG_SHIFT   0
+#define SLICE_LTS_SHIFT   (SLICE_AVG_SHIFT + SLICE_AVG_BITS)
+#define SLICE_SPA_SHIFT   (SLICE_LTS_SHIFT + SLICE_LTS_BITS)
+#define SLICE_NEW_SHIFT   (SLICE_SPA_SHIFT + SLICE_SPA_BITS)
+#define SLICE_FTS_SHIFT   (SLICE_NEW_SHIFT + SLICE_NEW_BITS)
+
+#define INFO_MASK(x)      ((1U << (x))-1)
+#define SLICE_AVG_MASK    (INFO_MASK(SLICE_AVG_BITS) << SLICE_AVG_SHIFT)
+#define SLICE_LTS_MASK    (INFO_MASK(SLICE_LTS_BITS) << SLICE_LTS_SHIFT)
+#define SLICE_SPA_MASK    (INFO_MASK(SLICE_SPA_BITS) << SLICE_SPA_SHIFT)
+#define SLICE_NEW_MASK    (INFO_MASK(SLICE_NEW_BITS) << SLICE_NEW_SHIFT)
+#define SLICE_FTS_MASK    (INFO_MASK(SLICE_FTS_BITS) << SLICE_FTS_SHIFT)
+
+/*
+ * p->slice_info access macros.
+ */
+#define first_time_slice(p) ((p)->slice_info & SLICE_FTS_MASK)
+#define set_first_time_slice(p) ((p)->slice_info |= SLICE_FTS_MASK)
+#define clr_first_time_slice(p) ((p)->slice_info &= ~SLICE_FTS_MASK)
+
+#define slice_is_new(p) ((p)->slice_info & SLICE_NEW_MASK)
+#define set_slice_is_new(p) ((p)->slice_info |= SLICE_NEW_MASK)
+#define clr_slice_is_new(p) ((p)->slice_info &= ~SLICE_NEW_MASK)
+
+#define last_slice(p) (((p)->slice_info & SLICE_LTS_MASK) >> SLICE_LTS_SHIFT)
+#define set_last_slice(p, n) ((p)->slice_info = (((p)->slice_info & \
+	~SLICE_LTS_MASK) | (((n) << SLICE_LTS_SHIFT) & SLICE_LTS_MASK)))
+
+#define NS_SLEEP_AVG_PCNT (NS_MAX_SLEEP_AVG / 100)
+
+#define slice_avg(p) ((typeof((p)->sleep_avg)) \
+	((((p)->slice_info & SLICE_AVG_MASK) >> SLICE_AVG_SHIFT) * \
+	NS_SLEEP_AVG_PCNT))
+#define set_slice_avg(p, n) ((p)->slice_info = (((p)->slice_info & \
+	~SLICE_AVG_MASK) | ((((n) / NS_SLEEP_AVG_PCNT) \
+	<< SLICE_AVG_SHIFT) & SLICE_AVG_MASK)))
+#define slice_avg_raw(p)  \
+	(((p)->slice_info & SLICE_AVG_MASK) >> SLICE_AVG_SHIFT)
+#define set_slice_avg_raw(p, n) ((p)->slice_info = (((p)->slice_info & \
+	~SLICE_AVG_MASK) | (((n) << SLICE_AVG_SHIFT) & SLICE_AVG_MASK)))
+
+/*
+ * cpu usage macros.
+ */
+#define cpu_avg(p) \
+	(100 - slice_avg_raw(p))
+
+#define cpu_max(p) \
+	(100 - ((p)->sleep_avg / NS_SLEEP_AVG_PCNT))
+
+#define time_this_slice(p) \
+	(jiffies - (p)->last_slice)
+
+#define cpu_this_slice(p) \
+	(100 * last_slice(p) / max((unsigned) time_this_slice(p), \
+	(unsigned) last_slice(p)))
+
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
 
@@ -812,6 +936,13 @@
 
 	if (likely(sleep_time > 0)) {
 		/*
+		 * Update throttle position.
+		 */
+		p->throttle += NS64_TO_JIFFIES(__sleep_time);
+		if (time_before(jiffies, p->throttle))
+			p->throttle = jiffies;
+
+		/*
 		 * Tasks that sleep a long time are categorised as idle.
 		 * They will only have their sleep_avg increased to a
 		 * level that makes them just interactive priority to stay
@@ -1492,9 +1623,19 @@
 	 * The remainder of the first timeslice might be recovered by
 	 * the parent if the child exits early enough.
 	 */
-	p->first_time_slice = 1;
+	set_first_time_slice(p);
 	current->time_slice >>= 1;
 	p->timestamp = sched_clock();
+
+	/*
+	 * Set up slice_info for the child.
+	 */
+	set_slice_avg(p, p->sleep_avg);
+	set_last_slice(p, NS_TO_JIFFIES(p->time_slice));
+	set_slice_is_new(p);
+	p->last_slice = jiffies;
+	p->throttle = jiffies - G2 + G1;
+
 	if (unlikely(current->time_slice < NS_TICK)) {
 		/*
 		 * This case is rare, it happens when the parent has only
@@ -1607,7 +1748,7 @@
 	 * the sleep_avg of the parent as well.
 	 */
 	rq = task_rq_lock(p->parent, &flags);
-	if (p->first_time_slice && task_cpu(p) == task_cpu(p->parent)) {
+	if (first_time_slice(p) && task_cpu(p) == task_cpu(p->parent)) {
 		p->parent->time_slice += p->time_slice;
 		if (unlikely(p->parent->time_slice > task_timeslice(p)))
 			p->parent->time_slice = task_timeslice(p);
@@ -2720,6 +2861,86 @@
 }
 
 /*
+ * Refresh timeslice and associated slice information.
+ * @p: the process to refresh.
+ */
+static void refresh_timeslice(task_t *p)
+{
+	unsigned long slice_time = jiffies - p->last_slice;
+	unsigned int slice = last_slice(p);
+	unsigned int slice_avg, cpu, idle;
+	int run_time = JIFFIES_TO_NS(slice) - p->time_slice;
+	int w = MAX_BONUS, delta, bonus;
+
+	/*
+	 * Update time_slice.
+	 */
+	p->time_slice = task_timeslice(p);
+	set_last_slice(p, NS_TO_JIFFIES(p->time_slice));
+
+	/*
+	 * Update sleep_avg.
+	 *
+	 * Tasks charged proportionately less run_time at high
+	 * sleep_avg to delay them losing their interactive status
+	 */
+	run_time /= SLEEP_AVG_DIVISOR(p);
+	if (p->sleep_avg >= run_time)
+		p->sleep_avg -= run_time;
+	else p->sleep_avg = 0;
+
+	/*
+	 * Update slice_avg.
+	 */
+	slice_avg = slice_avg_raw(p);
+	cpu = cpu_this_slice(p);
+	idle = 100 - cpu;
+
+	delta = max(slice_avg, idle) - min(slice_avg, idle);
+	w = 1 + (delta / w);
+	slice_avg = (w * slice_avg + idle) / (w + 1);
+	set_slice_avg_raw(p, slice_avg);
+
+	/*
+	 * If we've hit the timeout, we aren't draining enough sleep_avg
+	 * to catch up with the task's cpu usage.  Up the ante to bring
+	 * the task back toward balance.  This is important, because it
+	 * allows interactive tasks to push their throttle back enough
+	 * that they can both sustain, and rapidly recover from throttling
+	 * instead of descending into G3.
+	 */
+	if (grace_expired(p, G2) && p->sleep_avg > slice_avg(p)) {
+		unsigned long run_time = p->sleep_avg - slice_avg(p);
+		run_time /= w;
+		if (p->sleep_avg >= run_time)
+			p->sleep_avg -= run_time;
+	}
+
+	/*
+	 * Update throttle position.
+	 */
+	if (cpu < cpu_max(p) + PCNT_PER_DYNPRIO || !grace_expired(p, G1)) {
+		bonus = idle * PCNT_PER_DYNPRIO / 100;
+		p->throttle += (slice_time - slice) * bonus;
+	} else if (cpu >= cpu_max(p) + PCNT_PER_DYNPRIO) {
+		bonus = (cpu - cpu_max(p)) / PCNT_PER_DYNPRIO;
+		p->throttle -= slice_time * bonus;
+	}
+
+	if (time_before(jiffies, p->throttle))
+		p->throttle = jiffies;
+	else if (grace_expired(p, G3))
+		p->throttle = jiffies - G3;
+
+	/*
+	 * And finally, stamp and flag the new slice.
+	 */
+	clr_first_time_slice(p);
+	set_slice_is_new(p);
+	p->last_slice = jiffies;
+}
+
+/*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  *
@@ -2763,8 +2984,7 @@
 		 * FIFO tasks have no timeslices.
 		 */
 		if ((p->policy == SCHED_RR) && p->time_slice < NS_TICK) {
-			p->time_slice += task_timeslice(p);
-			p->first_time_slice = 0;
+			refresh_timeslice(p);
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
@@ -2773,21 +2993,10 @@
 		goto out_unlock;
 	}
 	if (p->time_slice < NS_TICK) {
-		int time_slice = task_timeslice(p);
-		int run_time = time_slice - p->time_slice;
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
-		p->time_slice += time_slice;
-		/*
-		 * Tasks are charged proportionately less run_time at high
-		 * sleep_avg to delay them losing their interactive status
-		 */
-		run_time /= SLEEP_AVG_DIVISOR(p);
-		p->sleep_avg -= run_time;
-		if ((long)p->sleep_avg < 0)
-			p->sleep_avg = 0;
+		refresh_timeslice(p);
 		p->prio = effective_prio(p);
-		p->first_time_slice = 0;
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
@@ -3185,6 +3394,14 @@
 
 	prev->timestamp = prev->last_ran = now;
 
+	/*
+	 * Tag start of execution of a new timeslice.
+	 */
+	if (unlikely(slice_is_new(next))) {
+		next->last_slice = jiffies;
+		clr_slice_is_new(next);
+	}
+
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
 		next->timestamp = rq->timestamp_last_switch = now;
--- linux-2.6.16-rc5-mm2/kernel/sysctl.c.org	2006-02-28 06:10:43.000000000 +0100
+++ linux-2.6.16-rc5-mm2/kernel/sysctl.c	2006-02-28 06:11:41.000000000 +0100
@@ -73,6 +73,9 @@
 extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
+extern int grace_g1;
+extern int grace_g2;
+extern int grace_max;
 
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
+		.procname	= "grace_g1",
+		.data		= &grace_g1,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &grace_max,
+	},
+	{
+		.ctl_name	= KERN_SCHED_THROTTLE2,
+		.procname	= "grace_g2",
+		.data		= &grace_g2,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &grace_max,
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
 

