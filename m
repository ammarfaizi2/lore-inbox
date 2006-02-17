Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWBQNoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWBQNoJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWBQNoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:44:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:39889 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751415AbWBQNoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:44:08 -0500
X-Authenticated: #14349625
Subject: [patch 2.6.16-rc3-mm1]  Task Throttling V9
From: MIke Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 14:45:03 +0100
Message-Id: <1140183903.14128.77.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Below, please find the latest version of my task throttling attempt.

What the patch addresses:

The current interactivity heuristics are so heavily slanted in favor of
tasks which sleep at all, that any task which sleeps for 5% of the time
can use 95% cpu forever.  Even if this slant were removed, became linear
again, any task which sleeps even a tiny bit longer than it runs will
eventually attain maximum dynamic priority.

That said, the current heuristics work very well in the general case.
When they fail, however, it can get pretty darn ugly.  That is the
problem space this patch attempts to address, and does pretty well at.
It tries to solve the nasty corner cases.

How it works is by no means rocket science, and is described in the
comments of the first hunk of sched.c changes.

In addition to the throttling, this simple patch does three things
(more?) which may be controversial.

1.  It removes the barrier between kernel threads and user tasks wrt the
handling of dynamic priority.

2.  It changes the meaning of INTERACTIVE_SLEEP() a little.

3.  It removes TASK_NONINTERACTIVE from fs/pipe.c

My argument for #1:  Either dynamic priority is fully applicable or not
at all.  If any kernel thread really needs to be exempt from any aspect
of dynamic priority, it should be in a different scheduling class.

My argument for #2:  The boundary established by TASK_INTERACTIVE() is a
portal, and should be treated as such.  This patch does not establish
the boundary, it only enforces it.  It also adds a very modest level of
caution to the promotion of tasks beyond the interactive task boundary.
One single 10ms sleep will no longer take a pure cpu hog to the very
top.

My argument for #3:  AnaroK is an mp3 player which uses pipes to
communicate with its various components.  I can see no that reason it
should not receive the same boost as any other task.  It is after all a
genuine interactive task.  Besides, it's no longer necessary.

Oops, there's a #4.

4.  It adds knobs to the scheduler.

My argument for #4:  These knobs put policy where it belongs.  If the
user wants a maximum interactive environment, and is willing to accept
that this means some starvation comes with the deal, it's his choice.
Those who have little to no tolerance for starvation can set both knobs
to zero, and be happy.  Both can have their cake with whatever icing
they are partial to.

There may be a #5, #6... who knows, you tell me ;-)

Comments?  Suggestions?  Fla^H^H^H (nah... beware what you ask)

	-Mike

P.S.  Any interactive feel improvement inflicted upon the user by the
throttling of hyperactive cpu-hog is absolutely free... as is the
strangulation of their favorite mp3 player GL visualization ;-)

Not to be taken as a sign of misguided confidence, I'm just taking blame
for this in all of it's ugly-is-in-the-eye-of-the-beholder glory.

Signed-off-by: Mike Galbraith <efault@gmx.de>


--- linux-2.6.16-rc3-mm1x/include/linux/sched.h.org	2006-02-15 08:40:13.000000000 +0100
+++ linux-2.6.16-rc3-mm1x/include/linux/sched.h	2006-02-15 08:40:37.000000000 +0100
@@ -719,14 +719,14 @@
 	unsigned short ioprio;
 	unsigned int btrace_seq;
 
-	unsigned long sleep_avg;
+	unsigned long sleep_avg, last_slice, throttle_stamp;
 	unsigned long long timestamp, last_ran;
 	unsigned long long sched_time; /* sched_clock time spent running */
 	enum sleep_type sleep_type;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
-	unsigned int time_slice, first_time_slice;
+	unsigned int time_slice, slice_info;
 
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
--- linux-2.6.16-rc3-mm1x/include/linux/sysctl.h.org	2006-02-15 08:40:25.000000000 +0100
+++ linux-2.6.16-rc3-mm1x/include/linux/sysctl.h	2006-02-15 08:40:37.000000000 +0100
@@ -147,6 +147,8 @@
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
+	KERN_SCHED_THROTTLE1=72,  /* int: throttling grace period 1 in secs */
+	KERN_SCHED_THROTTLE2=73,  /* int: throttling grace period 2 in secs */
 };
 
 
--- linux-2.6.16-rc3-mm1x/kernel/sched.c.org	2006-02-15 08:32:15.000000000 +0100
+++ linux-2.6.16-rc3-mm1x/kernel/sched.c	2006-02-17 12:13:48.000000000 +0100
@@ -158,9 +158,192 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
-#define INTERACTIVE_SLEEP(p) \
-	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
-		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
+/*
+ * Interactive boost can lead to serious starvation problems if the
+ * task being boosted turns out to be a cpu hog.  To combat this, we
+ * compute the sane upper limit for cpu usage 'slice_avg' based on a
+ * task's sleep_avg, and use this information combined with a timer
+ * to determine when a task is in need of throttling.
+ *
+ * Strategy:
+ *
+ * All tasks begin life with a throttle timer which is expired, but a 
+ * slice_avg which allows brief interactive status.  This status will
+ * expire at the end of their very first timeslice if they don't sleep,
+ * thus preventing them from doing harm right from the beginning.  The
+ * only ways to reset the throttle timer, and thus escape it's effects,
+ * are to either change behavior to match what sleep_avg indicates, or
+ * to become insignificant.  We push the time stamp forward in time when
+ * a task's behavior matches expectations until it's in the future, we
+ * then reset the timer, which will allow the task to run unencumbered
+ * for a maximum amount of time determined by the user.  The less cpu a
+ * task uses, the faster it can reset it's timer, so light weight tasks
+ * very rapidly attain interactive status, as do things like X which
+ * change behavior radically.  Tasks with cpu usage which is constantly
+ * above what their sleep_avg indicates can't escape.
+ *
+ * /proc/sys/kernel tunables.
+ *
+ * sched_g1: Grace period in seconds that a task is allowed to run free.
+ * sched_g2: seconds thereafter, to force a priority adjustment.
+ */
+
+int sched_g1 = 20;
+int sched_g2 = 10;
+
+#define G1 (sched_g1 * HZ)
+#define G2 (sched_g2 * HZ + G1)
+
+/*
+ * Throttle distance maximum.
+ */
+#define GRACE_MAX (G2 << 1)
+
+#define grace_expired(p, grace) ((p)->throttle_stamp && \
+	time_after_eq(jiffies, (p)->throttle_stamp + (grace)))
+
+#define NS_MAX_BONUS (NS_MAX_SLEEP_AVG / MAX_BONUS)
+#define NS_SLEEP_AVG_PCNT (NS_MAX_SLEEP_AVG / 100)
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
+#define last_slice(p) \
+	((((p)->slice_info & SLICE_LTS_MASK) >> SLICE_LTS_SHIFT) ? : \
+	DEF_TIMESLICE)
+#define set_last_slice(p, n) ((p)->slice_info = (((p)->slice_info & \
+	~SLICE_LTS_MASK) | (((n) << SLICE_LTS_SHIFT) & SLICE_LTS_MASK))) 
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
+#define slice_time_avg(p) \
+	(100 * last_slice(p) / max((unsigned) cpu_avg(p), 1U))
+
+#define cpu_max(p) \
+	(100 - ((p)->sleep_avg / NS_SLEEP_AVG_PCNT))
+
+#define slice_time_min(p) \
+	(100 * last_slice(p) / max((unsigned) cpu_max(p), 1U))
+
+#define time_this_slice(p) \
+	(jiffies - (p)->last_slice)
+
+#define cpu_this_slice(p) \
+	(100 * last_slice(p) / max((unsigned) time_this_slice(p), \
+	(unsigned) last_slice(p)))
+
+#define this_slice_avg(p) ((typeof((p)->sleep_avg)) \
+	((100 - cpu_this_slice(p)) * NS_SLEEP_AVG_PCNT))
+
+/*
+ * Those who use the least cpu receive the most encouragement.
+ */
+#define SLICE_AVG_MULTIPLIER(p) \
+	(1 + NS_TO_JIFFIES(this_slice_avg(p)) * MAX_BONUS / MAX_SLEEP_AVG)
+
+#define CPU_MINIMAL (100 / MAX_BONUS / 2)
+
+static void throttle_cond_reset(task_t *p)
+{
+	int delay;
+
+	if (cpu_avg(p) > cpu_max(p) && cpu_this_slice(p) > CPU_MINIMAL)
+		return;
+
+	delay = slice_time_avg(p) - last_slice(p);
+
+	if (delay > 0) {
+		delay *= SLICE_AVG_MULTIPLIER(p);
+		p->throttle_stamp += delay;
+	}
+	if (time_before(jiffies, p->throttle_stamp)) {
+		p->throttle_stamp = jiffies;
+		if (!(p->state & TASK_NONINTERACTIVE))
+			p->sleep_type = SLEEP_NORMAL;
+	}
+}
+
+/*
+ * CURRENT_BONUS(p) adjusted to match slice_avg after grace expiration.
+ */
+#define ADJUSTED_BONUS(p, grace)					\
+({									\
+	unsigned long sleep_avg = (p)->sleep_avg;			\
+	if (grace_expired(p, (grace)))					\
+		sleep_avg = min((p)->sleep_avg, slice_avg(p));		\
+	NS_TO_JIFFIES(sleep_avg) * MAX_BONUS / MAX_SLEEP_AVG;		\
+})
+
+#define BONUS_MULTIPLIER(p) \
+	(grace_expired(p, G1) ? : SLICE_AVG_MULTIPLIER(p))
+
+#define BONUS_DIVISOR(p) \
+	(grace_expired(p, G2) ? : (1 + ADJUSTED_BONUS(p, G1)))
+
+#define INTERACTIVE_SLEEP_AVG(p) \
+	(min(JIFFIES_TO_NS(MAX_SLEEP_AVG * (MAX_BONUS / 2 + DELTA(p)) / \
+	MAX_BONUS), NS_MAX_SLEEP_AVG))
+
+/*
+ * Quantity of sleep quaranteed to elevate a task to interactive status,
+ * or once there, to elevate it to the next priority or beyond.
+ */
+#define INTERACTIVE_SLEEP_NS(p, ns) \
+	(BONUS_MULTIPLIER(p) * (ns) >= INTERACTIVE_SLEEP_AVG(p)	|| \
+	((p)->sleep_avg < INTERACTIVE_SLEEP_AVG(p) && BONUS_MULTIPLIER(p) * \
+	(ns) + (p)->sleep_avg >= INTERACTIVE_SLEEP_AVG(p))      || \
+	((p)->sleep_avg >= INTERACTIVE_SLEEP_AVG(p) && BONUS_MULTIPLIER(p) * \
+	(ns) + ((p)->sleep_avg % NS_MAX_BONUS) >= NS_MAX_BONUS))
 
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
@@ -668,7 +851,7 @@
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
+	bonus = ADJUSTED_BONUS(p, G2) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
@@ -792,21 +975,41 @@
 			sleep_time = (unsigned long)__sleep_time;
 	}
 
+	throttle_cond_reset(p);
+
 	if (likely(sleep_time > 0)) {
 		/*
-		 * User tasks that sleep a long time are categorised as
-		 * idle. They will only have their sleep_avg increased to a
+		 * Tasks that sleep a long time are categorised as idle.
+		 * They will only have their sleep_avg increased to a
 		 * level that makes them just interactive priority to stay
 		 * active yet prevent them suddenly becoming cpu hogs and
-		 * starving other processes.
+		 * starving other processes.  All tasks must stop at each
+		 * TASK_INTERACTIVE boundary before moving on so that no
+		 * single sleep slams it straight into NS_MAX_SLEEP_AVG.
+		 * Tasks which have exceeded their authorized cpu usage
+		 * will not be promoted beyond minimally interactive.
 		 */
-		if (p->mm && sleep_time > INTERACTIVE_SLEEP(p)) {
-				unsigned long ceiling;
+		if (INTERACTIVE_SLEEP_NS(p, sleep_time)) {
+			unsigned long ceiling = INTERACTIVE_SLEEP_AVG(p);
+			unsigned int slice = p->time_slice / BONUS_DIVISOR(p);
+			int throttle = grace_expired(p, G1);
+
+			/*
+			 * Promote previously interactive tasks.
+			 */
+			if (!throttle && p->sleep_avg >= ceiling) {
+				ceiling = p->sleep_avg / NS_MAX_BONUS;
+				if (ceiling < MAX_BONUS)
+					ceiling++;
+				ceiling *= NS_MAX_BONUS;
+			}
+
+		 	ceiling += JIFFIES_TO_NS(slice);
+			if (ceiling > NS_MAX_SLEEP_AVG)
+				ceiling = NS_MAX_SLEEP_AVG;
+			if (p->sleep_avg < ceiling)
+				p->sleep_avg = ceiling;
 
-				ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -
-					DEF_TIMESLICE);
-				if (p->sleep_avg < ceiling)
-					p->sleep_avg = ceiling;
 		} else {
 
 			/*
@@ -816,9 +1019,8 @@
 			 * If a task was sleeping with the noninteractive
 			 * label do not apply this non-linear boost
 			 */
-			if (p->sleep_type != SLEEP_NONINTERACTIVE || !p->mm)
-				sleep_time *=
-					(MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
+			if (p->sleep_type != SLEEP_NONINTERACTIVE)
+				sleep_time *= BONUS_MULTIPLIER(p);
 
 			/*
 			 * This code gives a bonus to interactive tasks.
@@ -1362,7 +1564,8 @@
 
 out_activate:
 #endif /* CONFIG_SMP */
-	if (old_state == TASK_UNINTERRUPTIBLE) {
+
+	if (old_state & TASK_UNINTERRUPTIBLE) {
 		rq->nr_uninterruptible--;
 		/*
 		 * Tasks waking from uninterruptible sleep are likely
@@ -1460,9 +1663,27 @@
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
+	 *
+	 * Note:  All new tasks receive the benefit of the doubt in that
+	 * they begin life with a slice_avg of right at the interactive
+	 * boundary.  They are also born with an maximim expired throttle
+	 * stamp, and will lose interactive status after their first slice
+	 * if they don't sleep before it expires.
+	 */
+	set_slice_avg(p, INTERACTIVE_SLEEP_AVG(p) + p->time_slice);
+	if (unlikely(slice_avg(p) > NS_MAX_SLEEP_AVG))
+		set_slice_avg(p, NS_MAX_SLEEP_AVG);
+	set_last_slice(p, p->time_slice);
+	set_slice_is_new(p);
+	p->last_slice = jiffies;
+	p->throttle_stamp = jiffies - GRACE_MAX;
+
 	if (unlikely(!current->time_slice)) {
 		/*
 		 * This case is rare, it happens when the parent has only
@@ -1576,7 +1797,7 @@
 	 * the sleep_avg of the parent as well.
 	 */
 	rq = task_rq_lock(p->parent, &flags);
-	if (p->first_time_slice && task_cpu(p) == task_cpu(p->parent)) {
+	if (first_time_slice(p) && task_cpu(p) == task_cpu(p->parent)) {
 		p->parent->time_slice += p->time_slice;
 		if (unlikely(p->parent->time_slice > task_timeslice(p)))
 			p->parent->time_slice = task_timeslice(p);
@@ -2657,6 +2878,49 @@
 }
 
 /*
+ * Calculate a task's average cpu usage in terms of sleep_avg, and store
+ * it along with the task's last timeslice in slice_info.  Must be called
+ * after refreshing the task's time slice.
+ * @p: task for which usage should be calculated.
+ */
+static void recalc_task_slice_avg(task_t *p)
+{
+	unsigned int slice = last_slice(p);
+	unsigned int prev = slice_avg_raw(p);
+	unsigned int this = 100 - cpu_this_slice(p);
+	int delta = max(prev, this) - min(prev, this);
+	int w = MAX_BONUS;
+
+	/*
+	 * Weigh by behavior delta magnitude.
+	 */
+	w -= delta / w;
+	if (!w)
+		w = 1;
+	this = (w * (prev ? : 1) + this) / (w + 1);
+
+	/*
+	 * Update slice_info.
+	 */
+	set_slice_avg_raw(p, this);
+	if (slice != p->time_slice)
+		set_last_slice(p, p->time_slice);
+
+	/*
+	 * Stamp and tag the new slice.
+	 */
+	set_slice_is_new(p);
+	p->last_slice = jiffies;
+
+	/*
+	 * And finally, insure that our hero doesn't ride off
+	 * into the sunset.
+	 */
+	if (p->throttle_stamp && grace_expired(p, GRACE_MAX))
+		p->throttle_stamp = jiffies - GRACE_MAX;
+}
+
+/*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  *
@@ -2701,7 +2965,8 @@
 		 */
 		if ((p->policy == SCHED_RR) && !--p->time_slice) {
 			p->time_slice = task_timeslice(p);
-			p->first_time_slice = 0;
+			recalc_task_slice_avg(p);
+			clr_first_time_slice(p);
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
@@ -2712,9 +2977,10 @@
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
-		p->first_time_slice = 0;
+		recalc_task_slice_avg(p);
+		p->prio = effective_prio(p);
+		clr_first_time_slice(p);
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
@@ -3025,7 +3291,7 @@
 	 * Tasks charged proportionately less run_time at high sleep_avg to
 	 * delay them losing their interactive status
 	 */
-	run_time /= (CURRENT_BONUS(prev) ? : 1);
+	run_time /= BONUS_DIVISOR(prev);
 
 	spin_lock_irq(&rq->lock);
 
@@ -3039,7 +3305,7 @@
 				unlikely(signal_pending(prev))))
 			prev->state = TASK_RUNNING;
 		else {
-			if (prev->state == TASK_UNINTERRUPTIBLE)
+			if (prev->state & TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible++;
 			deactivate_task(prev, rq);
 		}
@@ -3088,6 +3354,7 @@
 		rq->best_expired_prio = MAX_PRIO;
 	}
 
+repeat_selection:
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
@@ -3107,8 +3374,14 @@
 			dequeue_task(next, array);
 			next->prio = new_prio;
 			enqueue_task(next, array);
-		} else
-			requeue_task(next, array);
+
+			/*
+			 * We may have just been demoted below other
+			 * runnable tasks in our previous queue.
+			 */
+			next->sleep_type = SLEEP_NORMAL;
+			goto repeat_selection;
+		}
 	}
 	next->sleep_type = SLEEP_NORMAL;
 switch_tasks:
@@ -3126,6 +3399,14 @@
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
--- linux-2.6.16-rc3-mm1x/kernel/sysctl.c.org	2006-02-15 08:32:15.000000000 +0100
+++ linux-2.6.16-rc3-mm1x/kernel/sysctl.c	2006-02-15 08:40:37.000000000 +0100
@@ -69,6 +69,8 @@
 extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
+extern int sched_g1;
+extern int sched_g2;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -222,6 +224,11 @@
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
@@ -664,15 +671,29 @@
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+	{
+		.ctl_name	= KERN_SCHED_THROTTLE1,
+		.procname	= "sched_g1",
+		.data		= &sched_g1,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
+	{
+		.ctl_name	= KERN_SCHED_THROTTLE2,
+		.procname	= "sched_g2",
+		.data		= &sched_g2,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
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
--- linux-2.6.16-rc3-mm1x/fs/pipe.c.org	2006-02-15 08:32:12.000000000 +0100
+++ linux-2.6.16-rc3-mm1x/fs/pipe.c	2006-02-15 08:40:37.000000000 +0100
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


