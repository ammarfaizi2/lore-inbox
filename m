Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWBXU0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWBXU0I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWBXU0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:26:08 -0500
Received: from mail.gmx.de ([213.165.64.20]:52197 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932430AbWBXU0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:26:06 -0500
X-Authenticated: #14349625
Subject: [patch 2.6.16-rc4-mm1]  Task Throttling V14
From: MIke Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <1140183903.14128.77.camel@homer>
References: <1140183903.14128.77.camel@homer>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 21:29:41 +0100
Message-Id: <1140812981.8713.35.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 14:45 +0100, MIke Galbraith wrote: 
> Greetings,
> 
> Below, please find the latest version of my task throttling attempt.
> 
> What the patch addresses:
> 
> The current interactivity heuristics are so heavily slanted in favor of
> tasks which sleep at all, that any task which sleeps for 5% of the time
> can use 95% cpu forever.  Even if this slant were removed, became linear
> again, any task which sleeps even a tiny bit longer than it runs will
> eventually attain maximum dynamic priority.
> 
> That said, the current heuristics work very well in the general case.
> When they fail, however, it can get pretty darn ugly.  That is the
> problem space this patch attempts to address, and does pretty well at.
> It tries to solve the nasty corner cases.
> 
...

> Comments?  Suggestions?  Fla^H^H^H (nah... beware what you ask)

Not many comments came back, zero actually.  Probably because everyone
was really busy, not because anyone felt a sudden urge to hug the ole
porcelain Buddha after taking a look ;-)

Anyway, below is [imo] a very much nicer version.  Functionally,
throttling is fairly air tight now, and interactivity is not affected in
the least afaikt.  The thing works well.  So well, that the nasty little
fundamental problem, while not whipped, is off in a corner licking it's
wounds ;-)

One kinda nifty feature about the way I do the throttling now, is that I
don't need to give a sometimes hog like X the keys to the city by
defining a huge window of opportunity for it's cpu use, and then trying
to figure out if I should throttle it or not when it gets busy.  I can
leave a _zero_ length window for it, and it is quite happy.  It usually
has such low cpu usage, that there are plenty of spare cycles that I let
it save for a rainy day.  There is no free lunch though, they _will_ run
out.  It's automatic.  When the task's savings account is empty, it hits
the wall with a big splat.  Interactive tasks naturally build a pool of
spare cycles, whereas tasks which want excessive cpu can't.

Even if you think that last patch was too ugly to risk looking again,
brace yourself, and take a peek at it anyway.  There may be a nugget or
two be had even if my implementation erm... isn't the most beautiful bit
of code you've seen lately.  The throttling idea works just fine, and
among the low hanging fruit, there's the fact that I don't miss the
sleep multiplier I ripped out even a tiny little bit.  If anyone
actually tries this patch out [recommended] , they'll see what I mean.
Try a make -j5 kernel build on a fairly slow nfs mount.  That has
absolutely nothing to do with the quite functional throttling, it's the
result of interactivity logic tweaks I was kinda-sorta-forced to do
along the way.

	Cheers,

	-Mike

 fs/pipe.c              |    6 
 include/linux/sched.h  |    4 
 include/linux/sysctl.h |    2 
 kernel/sched.c         |  332 ++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/sysctl.c        |   36 ++++-
 5 files changed, 336 insertions(+), 44 deletions(-)

diffstat looks really obese, but it's not as fat as it looks.

--- linux-2.6.16-rc4-mm1x/include/linux/sched.h.org	2006-02-20 14:07:26.000000000 +0100
+++ linux-2.6.16-rc4-mm1x/include/linux/sched.h	2006-02-23 05:05:20.000000000 +0100
@@ -712,14 +712,14 @@
 	unsigned short ioprio;
 	unsigned int btrace_seq;
 
-	unsigned long sleep_avg;
+	unsigned long sleep_avg, last_slice, throttle;
 	unsigned long long timestamp, last_ran;
 	unsigned long long sched_time; /* sched_clock time spent running */
 	enum sleep_type sleep_type;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
-	unsigned int time_slice, first_time_slice;
+	unsigned int time_slice, slice_info;
 
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
--- linux-2.6.16-rc4-mm1x/include/linux/sysctl.h.org	2006-02-20 14:07:36.000000000 +0100
+++ linux-2.6.16-rc4-mm1x/include/linux/sysctl.h	2006-02-20 14:08:28.000000000 +0100
@@ -147,6 +147,8 @@
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
+	KERN_SCHED_THROTTLE1=72,  /* int: throttling grace period 1 in secs */
+	KERN_SCHED_THROTTLE2=73,  /* int: throttling grace period 2 in secs */
 };
 
 
--- linux-2.6.16-rc4-mm1x/kernel/sched.c.org	2006-02-20 14:07:48.000000000 +0100
+++ linux-2.6.16-rc4-mm1x/kernel/sched.c	2006-02-24 14:38:26.000000000 +0100
@@ -79,6 +79,21 @@
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
@@ -151,9 +166,159 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
-#define INTERACTIVE_SLEEP(p) \
-	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
-		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
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
+ * sched_g1: The amount of cpu time in seconds that a new task
+ *           will run completely free, ie the head start a task
+ *           has to get far enough ahead of it's timer that it
+ *           can aviod being throttled.  Each conforming slice
+ *           thereafter increases it's lead, and vice versa.
+ *
+ * sched_g2: The maximum amount of 'good carma' a task can save
+ *           for later use.
+ */
+
+int sched_g1 = 30;
+int sched_g2 = 14400;
+int sched_g2_max = 42949;
+
+#define G1 (sched_g1 * MAX_BONUS * HZ)
+#define G2 (sched_g2 * MAX_BONUS * HZ + G1)
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
+ * SLICE_SPA:   0x3FFF8000  Spare bits.
+ * SLICE_LTS:   0x00007F80  Last time slice
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
+/*
+ * CURRENT_BONUS(p) with timeout controlled output.
+ */
+static int current_bonus(task_t *p, unsigned long grace)
+{
+	unsigned long sleep_avg = p->sleep_avg;
+	unsigned long slice_avg = slice_avg(p);
+
+	if (grace_expired(p, grace))
+		sleep_avg = min(sleep_avg, slice_avg);
+	return NS_TO_JIFFIES(sleep_avg) * MAX_BONUS / MAX_SLEEP_AVG;
+}
+
+#define PCNT_PER_DYNPRIO (100 / MAX_BONUS)
+#define NS_PER_DYNPRIO (PCNT_PER_DYNPRIO * NS_SLEEP_AVG_PCNT)
+
+#define SLEEP_AVG_DIVISOR(p) \
+	(grace_expired(p, G2) ? : (1 + CURRENT_BONUS(p)))
+
+#define INTERACTIVE_SLEEP_AVG(p) \
+	(min(JIFFIES_TO_NS(MAX_SLEEP_AVG * (MAX_BONUS / 2 + DELTA(p)) / \
+	MAX_BONUS), NS_MAX_SLEEP_AVG))
+
+/*
+ * Returns whether a quantity of sleep is guaranteed to promote a task to
+ * interactive status, or if already there, to the next dynamic priority
+ * or beyond.
+ */
+static int sleep_time_interactive(task_t *p, unsigned long length)
+{
+	unsigned long ceiling = INTERACTIVE_SLEEP_AVG(p);
+	unsigned long sleep_avg = p->sleep_avg;
+
+	if (length >= ceiling)
+		return 1;
+	if (sleep_avg >= ceiling) {
+		int bonus;
+		if (length >= NS_PER_DYNPRIO)
+			return 1;
+		bonus = CURRENT_BONUS(p);
+		return (sleep_avg + length) / NS_PER_DYNPRIO != bonus;
+	}
+	return sleep_avg + length >= ceiling;
+}
 
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
@@ -661,7 +826,7 @@
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
+	bonus = current_bonus(p, G2) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
@@ -767,6 +932,11 @@
 	unsigned long long __sleep_time = now - p->timestamp;
 	unsigned long sleep_time;
 
+	/*
+	 * TSC synchronization.
+	 */
+	if (unlikely(now < p->timestamp))
+		__sleep_time = 0ULL;
 	if (unlikely(p->policy == SCHED_BATCH))
 		sleep_time = 0;
 	else {
@@ -777,32 +947,48 @@
 	}
 
 	if (likely(sleep_time > 0)) {
+
 		/*
-		 * User tasks that sleep a long time are categorised as
-		 * idle. They will only have their sleep_avg increased to a
+		 * Update throttle position.
+		 */
+		p->throttle += NS64_TO_JIFFIES(__sleep_time);
+		if (time_before(jiffies, p->throttle))
+			p->throttle = jiffies;
+
+		/*
+		 * Tasks that sleep a long time are categorised as idle.
+		 * They will only have their sleep_avg increased to a
 		 * level that makes them just interactive priority to stay
 		 * active yet prevent them suddenly becoming cpu hogs and
 		 * starving other processes.
 		 */
-		if (p->mm && sleep_time > INTERACTIVE_SLEEP(p)) {
-				unsigned long ceiling;
+		if (sleep_time_interactive(p, sleep_time)) {
+			unsigned long ceiling = INTERACTIVE_SLEEP_AVG(p);
+			unsigned long ticks = p->time_slice;
 
-				ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -
-					DEF_TIMESLICE);
-				if (p->sleep_avg < ceiling)
-					p->sleep_avg = ceiling;
-		} else {
+			/*
+			 * Promote previously interactive tasks.
+			 */
+			if (p->sleep_avg > ceiling) {
+				ceiling = p->sleep_avg / NS_PER_DYNPRIO;
+				if (ceiling < MAX_BONUS)
+					ceiling++;
+				ceiling *= NS_PER_DYNPRIO;
+			}
 
 			/*
-			 * The lower the sleep avg a task has the more
-			 * rapidly it will rise with sleep time. This enables
-			 * tasks to rapidly recover to a low latency priority.
-			 * If a task was sleeping with the noninteractive
-			 * label do not apply this non-linear boost
+			 * Provide for sustainment.
 			 */
-			if (p->sleep_type != SLEEP_NONINTERACTIVE || !p->mm)
-				sleep_time *=
-					(MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
+			ticks = JIFFIES_TO_NS(ticks) / SLEEP_AVG_DIVISOR(p);
+			if (sleep_time >= ticks)
+				ceiling += ticks;
+			else ceiling += sleep_time;
+			if (ceiling > NS_MAX_SLEEP_AVG)
+				ceiling = NS_MAX_SLEEP_AVG;
+			if (p->sleep_avg < ceiling)
+				p->sleep_avg = ceiling;
+
+		} else {
 
 			/*
 			 * This code gives a bonus to interactive tasks.
@@ -1357,7 +1543,8 @@
 
 out_activate:
 #endif /* CONFIG_SMP */
-	if (old_state == TASK_UNINTERRUPTIBLE) {
+
+	if (old_state & TASK_UNINTERRUPTIBLE) {
 		rq->nr_uninterruptible--;
 		/*
 		 * Tasks waking from uninterruptible sleep are likely
@@ -1455,9 +1642,19 @@
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
+	set_last_slice(p, p->time_slice);
+	set_slice_is_new(p);
+	p->last_slice = jiffies;
+	p->throttle = jiffies - G2 + G1;
+
 	if (unlikely(!current->time_slice)) {
 		/*
 		 * This case is rare, it happens when the parent has only
@@ -1571,7 +1768,7 @@
 	 * the sleep_avg of the parent as well.
 	 */
 	rq = task_rq_lock(p->parent, &flags);
-	if (p->first_time_slice && task_cpu(p) == task_cpu(p->parent)) {
+	if (first_time_slice(p) && task_cpu(p) == task_cpu(p->parent)) {
 		p->parent->time_slice += p->time_slice;
 		if (unlikely(p->parent->time_slice > task_timeslice(p)))
 			p->parent->time_slice = task_timeslice(p);
@@ -2680,6 +2877,65 @@
 		cpustat->steal = cputime64_add(cpustat->steal, tmp);
 }
 
+
+#define CURRENT_CPU_BONUS(p) \
+	(100 - (cpu_this_slice(p) * PCNT_PER_DYNPRIO / 100))
+
+/*
+ * Refresh timeslice and associated slice information.
+ * @p: the process to refresh.
+ */
+static void refresh_timeslice(task_t *p)
+{
+	unsigned long slice_time = jiffies - p->last_slice;
+	unsigned int slice = last_slice(p);
+	unsigned int slice_avg, cpu, idle;
+	int w = MAX_BONUS, delta, bonus;
+
+	/*
+	 * Update time_slice.
+	 */
+	p->time_slice = task_timeslice(p);
+	if (slice != p->time_slice)
+		set_last_slice(p, p->time_slice);
+
+	/*
+	 * Update slice_avg.
+	 */
+	slice_avg = slice_avg_raw(p);
+	cpu = cpu_this_slice(p);
+	idle = 100 - cpu;
+	delta = max(slice_avg, idle) - min(slice_avg, idle);
+	w -= delta / w;
+	if (!w)
+		w = 1;
+	slice_avg = (w * slice_avg + idle) / (w + 1);
+	set_slice_avg_raw(p, slice_avg);
+
+	/*
+	 * Update throttle position.
+	 */
+	bonus = CURRENT_CPU_BONUS(p);
+	if (!grace_expired(p, G1) || cpu < cpu_max(p) + PCNT_PER_DYNPRIO)
+		p->throttle += (slice_time - slice) * bonus;
+	else if (cpu > cpu_max(p)) {
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
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -2724,8 +2980,7 @@
 		 * FIFO tasks have no timeslices.
 		 */
 		if ((p->policy == SCHED_RR) && !--p->time_slice) {
-			p->time_slice = task_timeslice(p);
-			p->first_time_slice = 0;
+			refresh_timeslice(p);
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
@@ -2735,10 +2990,9 @@
 	}
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
-		set_tsk_need_resched(p);
+		refresh_timeslice(p);
 		p->prio = effective_prio(p);
-		p->time_slice = task_timeslice(p);
-		p->first_time_slice = 0;
+		set_tsk_need_resched(p);
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
@@ -3049,7 +3303,7 @@
 	 * Tasks charged proportionately less run_time at high sleep_avg to
 	 * delay them losing their interactive status
 	 */
-	run_time /= (CURRENT_BONUS(prev) ? : 1);
+	run_time /= SLEEP_AVG_DIVISOR(prev);
 
 	spin_lock_irq(&rq->lock);
 
@@ -3063,7 +3317,7 @@
 				unlikely(signal_pending(prev))))
 			prev->state = TASK_RUNNING;
 		else {
-			if (prev->state == TASK_UNINTERRUPTIBLE)
+			if (prev->state & TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible++;
 			deactivate_task(prev, rq);
 		}
@@ -3112,6 +3366,7 @@
 		rq->best_expired_prio = MAX_PRIO;
 	}
 
+repeat_selection:
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
@@ -3131,6 +3386,13 @@
 			dequeue_task(next, array);
 			next->prio = new_prio;
 			enqueue_task(next, array);
+
+			/*
+			 * We may have just been demoted below other
+			 * runnable tasks in our previous queue.
+			 */
+			next->sleep_type = SLEEP_NORMAL;
+			goto repeat_selection;
 		}
 	}
 	next->sleep_type = SLEEP_NORMAL;
@@ -3149,6 +3411,14 @@
 		prev->sleep_avg = 0;
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
 		next->timestamp = now;
--- linux-2.6.16-rc4-mm1x/kernel/sysctl.c.org	2006-02-20 14:07:57.000000000 +0100
+++ linux-2.6.16-rc4-mm1x/kernel/sysctl.c	2006-02-24 14:41:33.000000000 +0100
@@ -72,6 +72,9 @@
 extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
+extern int sched_g1;
+extern int sched_g2;
+extern int sched_g2_max;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -225,6 +228,11 @@
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
@@ -669,15 +677,31 @@
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+	{
+		.ctl_name	= KERN_SCHED_THROTTLE1,
+		.procname	= "sched_g1",
+		.data		= &sched_g1,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &sched_g2_max,
+	},
+	{
+		.ctl_name	= KERN_SCHED_THROTTLE2,
+		.procname	= "sched_g2",
+		.data		= &sched_g2,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &sched_g2_max,
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
--- linux-2.6.16-rc4-mm1x/fs/pipe.c.org	2006-02-20 14:08:09.000000000 +0100
+++ linux-2.6.16-rc4-mm1x/fs/pipe.c	2006-02-20 14:08:28.000000000 +0100
@@ -39,11 +39,7 @@
 {
 	DEFINE_WAIT(wait);
 
-	/*
-	 * Pipes are system-local resources, so sleeping on them
-	 * is considered a noninteractive wait:
-	 */
-	prepare_to_wait(PIPE_WAIT(*inode), &wait, TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
+	prepare_to_wait(PIPE_WAIT(*inode), &wait, TASK_INTERRUPTIBLE);
 	mutex_unlock(PIPE_MUTEX(*inode));
 	schedule();
 	finish_wait(PIPE_WAIT(*inode), &wait);


