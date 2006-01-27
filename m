Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWA0UET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWA0UET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbWA0UET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:04:19 -0500
Received: from mail.gmx.net ([213.165.64.21]:50862 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030337AbWA0UES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:04:18 -0500
X-Authenticated: #14349625
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
From: MIke Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <5.2.1.1.2.20060127175530.00c3db30@pop.gmx.net>
References: <5.2.1.1.2.20060127175530.00c3db30@pop.gmx.net>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 21:06:08 +0100
Message-Id: <1138392368.7770.72.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-27 at 17:57 +0100, Con Kolivas wrote:
> On Saturday 14 January 2006 03:15, Mike Galbraith wrote:
>  > At 01:34 AM 1/14/2006 +1100, Con Kolivas wrote:
>  > >On Saturday 14 January 2006 00:01, Mike Galbraith wrote:
>  > > > At 09:51 PM 1/13/2006 +1100, Con Kolivas wrote:
>  > > > >See my followup patches that I have posted following "[PATCH 0/5]
>  > > > > sched - interactivity updates". The first 3 patches are what you
>  > > > > tested. These patches are being put up for testing hopefully in -mm.
>  > > >
>  > > > Then the (buggy) version of my simple throttling patch will need to
>  > > > come out.  (which is OK, I have a debugged potent++ version)
>  > >
>  > >Your code need not be mutually exclusive with mine. I've simply damped the
>  > >current behaviour. Your sanity throttling is a good idea.
>  >
>  > I didn't mean to imply that they're mutually exclusive, and after doing
>  > some testing, I concluded that it (or something like it) is definitely
>  > still needed.  The version that's in mm2 _is_ buggy however, so ripping it
>  > back out wouldn't hurt my delicate little feelings one bit.  In fact, it
>  > would give me some more time to instrument and test integration with your
>  > changes.
> 
> Ok I've communicated this to Andrew (cc'ed here too) so he should remove your
> patch pending a new version from you.

(Ok, it took a while what with setting up a new test box, testing this
and that, RL etc etc.)

What do you think of the below as an evaluation patch?  It leaves the
bits I'd really like to change (INTERACTIVE_SLEEP() for one), so it can
be switched on and off for easy comparison and regression testing.

I really didn't want to add more to the task struct, but after trying
different things, a timeout was the most effective means of keeping the
nice burst aspect of the interactivity logic but still make sure that a
burst doesn't turn into starvation.

The workings are dirt simple just as before.  The goal is to keep
sleep_avg and slice_avg balanced.  When an imbalance starts, immediately
cut off interactive bonus points.  If the imbalance doesn't correct
itself through normal sleep_avg usage, we'll soon hit the (1 dynamic
prio) trigger point, which starts a countdown toward active
intervention.  The default setting is that a task can run at higher
dynamic priority than it's cpu usage can justify for 5 seconds.  After
than, we start trying to work off the deficit, and if we don't succeeded
within another second (ie it was a big deficit), we demote the offender
to the rank his cpu usage indicates.

The strategy works well enough to take the wind out of irman2's sails,
and interactive tasks can still do a nice reasonable burst of activity
without being evicted.  Down side to starvation control is that X is
sometimes a serious cpu user, and _can_ end up in the expired array (not
nice under load).  I personally don't think that's a show stopper
though... all you have to do is tell the scheduler that what it already
noticed, that X is a piggy, but an OK piggy by renicing it. It becomes
immune from active throttling, and all is well.  I know that's not going
to be popular, but you just can't let X have free rein without leaving
the barn door wide open.  (maybe that switch should stay since the
majority of boxen are workstations, and default to off?).

'nuff words, patch follows.

	-Mike

--- 2.6.16-rc1-mm3/include/linux/sched.h.org	2006-01-27 11:28:20.000000000 +0100
+++ 2.6.16-rc1-mm3/include/linux/sched.h	2006-01-27 11:54:48.000000000 +0100
@@ -722,6 +722,7 @@
 	unsigned short ioprio;
 
 	unsigned long sleep_avg;
+	unsigned long slice_avg, last_slice, throttle_stamp;
 	unsigned long long timestamp, last_ran;
 	unsigned long long sched_time; /* sched_clock time spent running */
 	enum sleep_type sleep_type;
--- 2.6.16-rc1-mm3/include/linux/sysctl.h.org	2006-01-27 11:28:20.000000000 +0100
+++ 2.6.16-rc1-mm3/include/linux/sysctl.h	2006-01-27 11:57:13.000000000 +0100
@@ -147,6 +147,8 @@
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
+	KERN_SCHED_THROTTLE1=72,  /* int: sleep_avg throttling enabled */
+	KERN_SCHED_THROTTLE2=73,  /* int: throttling grace period in secs */
 };
 
 
--- 2.6.16-rc1-mm3/kernel/sched.c.org	2006-01-27 11:28:20.000000000 +0100
+++ 2.6.16-rc1-mm3/kernel/sched.c	2006-01-27 12:08:59.000000000 +0100
@@ -138,6 +138,55 @@
 	(NS_TO_JIFFIES((p)->sleep_avg) * MAX_BONUS / \
 		MAX_SLEEP_AVG)
 
+/*
+ * Interactivity boost can lead to serious starvation problems if the
+ * task being boosted turns out to be a cpu hog.  To combat this, we
+ * compute a running slice_avg, which is the sane upper limit for the
+ * task's sleep_avg.  If an 'interactive' task begins burning cpu, it's
+ * slice_avg will decay, making it visible as a problem so corrective
+ * measures can be applied.  RT tasks and kernel threads are exempt from
+ * throttling - reniced tasks are only subject to mild throttling.
+ *
+ * /proc/sys/kernel tunables.
+ *
+ * sched_throttle: enable throttling logic.
+ * sched_throttle_secs: throttling grace period in seconds.
+ */
+
+int throttle = 1;
+int throttle_secs = 5;
+int throttle_secs_max = 10;
+
+#define THROTTLE_BASE \
+	(10 * (NS_MAX_SLEEP_AVG / 100))
+
+/* Disable interactive task bias logic. */
+#define THROTTLE_BIAS(p) \
+	(throttle && (p)->mm && (p)->sleep_avg > (p)->slice_avg)
+
+/* Begin adjusting sleep_avg consumption to match slice_avg. */
+#define THROTTLE_SOFT(p) \
+	((p)->throttle_stamp && time_after(jiffies, (p)->throttle_stamp) && \
+	(p)->sleep_avg >= (p)->slice_avg + THROTTLE_BASE)
+
+/* Begin adjusting priority to match slice_avg. */
+#define THROTTLE_HARD(p) \
+	((p)->throttle_stamp && time_after(jiffies, (p)->throttle_stamp + HZ) && \
+	(p)->sleep_avg >= (p)->slice_avg + THROTTLE_BASE)
+
+#define THROTTLE_ENGAGE(p) (throttle && !(p)->throttle_stamp && \
+	(p)->mm && PRIO_TO_NICE((p)->static_prio) >= 0 && \
+	(p)->sleep_avg >= (p)->slice_avg + THROTTLE_BASE)
+
+#define THROTTLE_DISENGAGE(p) ((p)->throttle_stamp && \
+	(PRIO_TO_NICE((p)->static_prio) < 0 || !THROTTLE_BIAS((p)) || \
+	time_after(jiffies, (p)->last_slice + (throttle_secs * HZ))))
+
+#define CURRENT_COST(p) \
+	(NS_TO_JIFFIES(THROTTLE_SOFT((p)) ? \
+	min((p)->sleep_avg, (p)->slice_avg) : NS_MAX_SLEEP_AVG) * \
+	MAX_BONUS / MAX_SLEEP_AVG)
+
 #define GRANULARITY	(10 * HZ / 1000 ? : 1)
 
 #ifdef CONFIG_SMP
@@ -162,6 +211,10 @@
 	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
 		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
 
+#define INTERACTIVE_SLEEP_AVG(p) \
+	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
+		(MAX_BONUS / 2 + DELTA((p))) / MAX_BONUS))
+
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
 
@@ -669,6 +722,8 @@
 		return p->prio;
 
 	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
+	if (unlikely(THROTTLE_HARD(p)))
+		bonus = CURRENT_COST(p) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
@@ -803,8 +858,15 @@
 		if (p->mm && sleep_time > INTERACTIVE_SLEEP(p)) {
 				unsigned long ceiling;
 
-				ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -
-					DEF_TIMESLICE);
+				if (!throttle)
+					ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -
+						DEF_TIMESLICE);
+				else {
+					ceiling = INTERACTIVE_SLEEP_AVG(p);
+					ceiling += JIFFIES_TO_NS(DEF_TIMESLICE);
+					if (p->slice_avg < ceiling)
+						ceiling = p->slice_avg;
+				}
 				if (p->sleep_avg < ceiling)
 					p->sleep_avg = ceiling;
 		} else {
@@ -1367,7 +1429,10 @@
 
 out_activate:
 #endif /* CONFIG_SMP */
-	if (old_state == TASK_UNINTERRUPTIBLE) {
+	if (unlikely(THROTTLE_DISENGAGE(p)))
+		p->throttle_stamp = 0;
+
+	if (old_state & TASK_UNINTERRUPTIBLE) {
 		rq->nr_uninterruptible--;
 		/*
 		 * Tasks waking from uninterruptible sleep are likely
@@ -1382,7 +1447,7 @@
 	 * woken up with their sleep average not weighted in an
 	 * interactive way.
 	 */
-		if (old_state & TASK_NONINTERACTIVE)
+		if (old_state & TASK_NONINTERACTIVE || THROTTLE_BIAS(p))
 			p->sleep_type = SLEEP_NONINTERACTIVE;
 
 
@@ -1471,6 +1536,7 @@
 	p->first_time_slice = 1;
 	current->time_slice >>= 1;
 	p->timestamp = sched_clock();
+	p->throttle_stamp = 0;
 	if (unlikely(!current->time_slice)) {
 		/*
 		 * This case is rare, it happens when the parent has only
@@ -1510,6 +1576,9 @@
 	 */
 	p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
 		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
+	p->slice_avg = NS_MAX_SLEEP_AVG;
+	p->last_slice = jiffies;
+	p->throttle_stamp = 0;
 
 	p->prio = effective_prio(p);
 
@@ -1584,7 +1653,7 @@
 	 * the sleep_avg of the parent as well.
 	 */
 	rq = task_rq_lock(p->parent, &flags);
-	if (p->first_time_slice && task_cpu(p) == task_cpu(p->parent)) {
+	if ((int)p->first_time_slice > 0  && task_cpu(p) == task_cpu(p->parent)) {
 		p->parent->time_slice += p->time_slice;
 		if (unlikely(p->parent->time_slice > task_timeslice(p)))
 			p->parent->time_slice = task_timeslice(p);
@@ -2665,6 +2734,37 @@
 }
 
 /*
+ * Calculate a task's average slice usage rate in terms of sleep_avg.
+ * @p: task for which slice_avg should be computed.
+ * @time_slice: task's current timeslice.
+ */
+static unsigned long task_slice_avg(task_t *p, int time_slice)
+{
+	unsigned long slice_avg = p->slice_avg;
+	int idle, ticks = jiffies - p->last_slice;
+	int w = HZ / DEF_TIMESLICE;
+
+	if (ticks < time_slice)
+		ticks = time_slice;
+	idle = 100 - (100 * time_slice / ticks);
+	slice_avg /= NS_MAX_SLEEP_AVG / 100;
+
+	/*
+	 * If the task is lowering it's cpu usage, speed up the
+	 * effect on slice_avg so we don't over-throttle.
+	 */
+	if (idle > slice_avg + 10) {
+		w -= idle / 10;
+		if (!w)
+			w = 1;
+	}
+	slice_avg = (w * (slice_avg ? : 1) + idle) / (w + 1);
+	slice_avg *= NS_MAX_SLEEP_AVG / 100;
+
+	return slice_avg;
+}
+
+/*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  *
@@ -2710,19 +2810,33 @@
 		if ((p->policy == SCHED_RR) && !--p->time_slice) {
 			p->time_slice = task_timeslice(p);
 			p->first_time_slice = 0;
+			p->slice_avg = task_slice_avg(p, p->time_slice);
+			p->last_slice = jiffies;
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
 			requeue_task(p, rq->active);
 		}
+		if (unlikely(p->throttle_stamp))
+			p->throttle_stamp = 0;
 		goto out_unlock;
 	}
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
+		p->slice_avg = task_slice_avg(p, p->time_slice);
+		p->prio = effective_prio(p);
 		p->first_time_slice = 0;
+		p->last_slice = jiffies;
+
+		/*
+		 * Check to see if we should start/stop throttling;
+		 */
+		if (THROTTLE_ENGAGE(p))
+			p->throttle_stamp = jiffies + (throttle_secs * HZ);
+		else if (THROTTLE_DISENGAGE(p))
+			p->throttle_stamp = 0;
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
@@ -3033,7 +3147,7 @@
 	 * Tasks charged proportionately less run_time at high sleep_avg to
 	 * delay them losing their interactive status
 	 */
-	run_time /= (CURRENT_BONUS(prev) ? : 1);
+	run_time /= (CURRENT_COST(prev) ? : 1);
 
 	spin_lock_irq(&rq->lock);
 
@@ -3047,7 +3161,7 @@
 				unlikely(signal_pending(prev))))
 			prev->state = TASK_RUNNING;
 		else {
-			if (prev->state == TASK_UNINTERRUPTIBLE)
+			if (prev->state & TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible++;
 			deactivate_task(prev, rq);
 		}
@@ -3134,6 +3248,14 @@
 		prev->sleep_avg = 0;
 	prev->timestamp = prev->last_ran = now;
 
+	/*
+	 * Mark the beginning of a new slice in this mostly unused space.
+	 */
+	if (unlikely(!next->first_time_slice)) {
+		next->first_time_slice = ~0U;
+		next->last_slice = jiffies;
+	}
+
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
 		next->timestamp = now;
--- 2.6.16-rc1-mm3/kernel/sysctl.c.org	2006-01-27 11:28:20.000000000 +0100
+++ 2.6.16-rc1-mm3/kernel/sysctl.c	2006-01-27 11:58:30.000000000 +0100
@@ -69,6 +69,9 @@
 extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
+extern int throttle;
+extern int throttle_secs;
+extern int throttle_secs_max;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -224,6 +227,12 @@
 	{ .ctl_name = 0 }
 };
 
+/* Constants for minimum and maximum testing in vm_table and
+ * kern_table.  We use these as one-element integer vectors. */
+static int zero;
+static int one = 1;
+static int one_hundred = 100;
+
 static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_OSTYPE,
@@ -666,15 +675,31 @@
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+	{
+		.ctl_name	= KERN_SCHED_THROTTLE1,
+		.procname	= "sched_throttle",
+		.data		= &throttle,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+	{
+		.ctl_name	= KERN_SCHED_THROTTLE2,
+		.procname	= "sched_throttle_secs",
+		.data		= &throttle_secs,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &throttle_secs_max,
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


