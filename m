Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWBLVbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWBLVbE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 16:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWBLVbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 16:31:04 -0500
Received: from mail.gmx.de ([213.165.64.21]:49308 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751006AbWBLVbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 16:31:01 -0500
X-Authenticated: #14349625
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: MIke Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Con Kolivas <kernel@kolivas.org>,
       gcoady@gmail.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139771016.19342.253.camel@mindpipe>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602081335.18256.kernel@kolivas.org>
	 <Pine.LNX.4.61.0602091806100.30108@yvahk01.tjqt.qr>
	 <1139515605.30058.94.camel@mindpipe>  <1139553319.8850.79.camel@homer>
	 <1139752033.27408.20.camel@homer>  <1139771016.19342.253.camel@mindpipe>
Content-Type: text/plain
Date: Sun, 12 Feb 2006 22:36:33 +0100
Message-Id: <1139780193.7837.7.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-12 at 14:03 -0500, Lee Revell wrote:
> On Sun, 2006-02-12 at 14:47 +0100, MIke Galbraith wrote:
> > If you think it's the scheduler, how about try the patch below.  It's
> > against 2.6.16-rc2-mm1, and should tell you if it is the interactivity
> > logic in the scheduler or not.  I don't see other candidates in there,
> > not that that means there aren't any of course. 
> 
> I'll try, but it's a serious pain for me to build an -mm kernel.  A
> patch against 2.6.16-rc1 would be much easier.

Ok, here she comes.  It's a bit too reluctant to release a task so it
can reach interactive status at the moment, but for this test, that's a
feature. In fact, for this test, it's probably best to jump straight to
setting both g1 and g2 to zero.

	-Mike

--- linux-2.6.16-rc1/include/linux/sched.h.org	2006-02-12 21:28:28.000000000 +0100
+++ linux-2.6.16-rc1/include/linux/sched.h	2006-02-12 21:54:40.000000000 +0100
@@ -688,6 +688,13 @@
 struct audit_context;		/* See audit.c */
 struct mempolicy;
 
+enum sleep_type {
+	SLEEP_NORMAL,
+	SLEEP_NONINTERACTIVE,
+	SLEEP_INTERACTIVE,
+	SLEEP_INTERRUPTED,
+};
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -709,14 +716,14 @@
 
 	unsigned short ioprio;
 
-	unsigned long sleep_avg;
+	unsigned long sleep_avg, last_slice, throttle_stamp;
 	unsigned long long timestamp, last_ran;
 	unsigned long long sched_time; /* sched_clock time spent running */
-	int activated;
+	enum sleep_type sleep_type;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
-	unsigned int time_slice, first_time_slice;
+	unsigned int time_slice, slice_info;
 
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
--- linux-2.6.16-rc1/include/linux/sysctl.h.org	2006-02-12 21:28:44.000000000 +0100
+++ linux-2.6.16-rc1/include/linux/sysctl.h	2006-02-12 21:34:46.000000000 +0100
@@ -146,6 +146,8 @@
 	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
+	KERN_SCHED_THROTTLE1=71,  /* int: throttling grace period 1 in secs */
+	KERN_SCHED_THROTTLE2=72,  /* int: throttling grace period 2 in secs */
 };
 
 
--- linux-2.6.16-rc1/kernel/sched.c.org	2006-02-12 21:29:13.000000000 +0100
+++ linux-2.6.16-rc1/kernel/sched.c	2006-02-12 21:58:14.000000000 +0100
@@ -149,9 +149,195 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
-#define INTERACTIVE_SLEEP(p) \
-	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
-		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
+/*
+ * Interactivity boost can lead to serious starvation problems if the
+ * task being boosted turns out to be a cpu hog.  To combat this, we
+ * compute a running slice_avg, which is the sane upper limit for the
+ * task's sleep_avg.  If an 'interactive' task begins burning cpu, it's
+ * slice_avg will decay, making it visible as a problem so corrective
+ * measures can be applied.
+ *
+ * /proc/sys/kernel tunables.
+ *
+ * sched_g1: Grace period in seconds that a task is allowed to run unchecked.
+ * sched_g2: seconds thereafter, to force a priority adjustment.
+ */
+
+int sched_g1 = 20;
+int sched_g2 = 10;
+
+/*
+ * Offset from the time we noticed a potential problem until we disable the
+ * interactive bonus multiplier, and adjust sleep_avg consumption rate.
+ */
+#define G1 (sched_g1 * HZ)
+
+/*
+ * Offset thereafter that we disable the interactive bonus divisor, and adjust
+ * a runaway task's priority.
+ */
+#define G2 (sched_g2 * HZ + G1)
+
+/*
+ * Grace period has expired.
+ */
+#define grace_expired(p, grace) ((p)->throttle_stamp && \
+	time_after_eq(jiffies, (p)->throttle_stamp + (grace)))
+
+#define NEXT_PRIO (NS_MAX_SLEEP_AVG / MAX_BONUS)
+
+/*
+ * Warning: do not reduce threshold below NS_MAX_SLEEP_AVG / MAX_BONUS
+ * else you may break the case where one of a pair of communicating tasks
+ * only sleeps a miniscule amount of time, but must to be able to preempt
+ * it's partner in order to get any cpu time to speak of.  If you push that
+ * task to the same level or below it's partner, it will not be able to
+ * preempt and will starve.  This scenario was fixed for bonus calculation
+ * by converting sleep_avg to ns.
+ */
+#define THROTTLE_THRESHOLD (NEXT_PRIO)
+
+#define NS_MAX_SLEEP_AVG_PCNT (NS_MAX_SLEEP_AVG / 100)
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
+#define slice_avg(p) \
+	((((p)->slice_info & SLICE_AVG_MASK) >> SLICE_AVG_SHIFT) * \
+	NS_MAX_SLEEP_AVG_PCNT)
+#define set_slice_avg(p, n) ((p)->slice_info = (((p)->slice_info & \
+	~SLICE_AVG_MASK) | ((((n) / NS_MAX_SLEEP_AVG_PCNT) \
+	<< SLICE_AVG_SHIFT) & SLICE_AVG_MASK))) 
+#define slice_avg_raw(p)  \
+	(((p)->slice_info & SLICE_AVG_MASK) >> SLICE_AVG_SHIFT)
+#define set_slice_avg_raw(p, n) ((p)->slice_info = (((p)->slice_info & \
+	~SLICE_AVG_MASK) | (((n) << SLICE_AVG_SHIFT) & SLICE_AVG_MASK))) 
+
+#define cpu_avg(p) \
+	(100 - slice_avg_raw(p))
+
+#define slice_time_avg(p) \
+	(100 * last_slice(p) / max((unsigned)cpu_avg(p), 1U))
+
+#define time_this_slice(p) \
+	(jiffies - (p)->last_slice)
+
+#define cpu_this_slice(p) \
+	(100 * last_slice(p) / max((unsigned)time_this_slice(p), \
+	(unsigned)last_slice(p)))
+
+#define this_slice_avg(p) \
+	((100 - cpu_this_slice(p)) * NS_MAX_SLEEP_AVG_PCNT)
+
+/*
+ * In order to prevent tasks from thrashing between domesticated livestock
+ * and irate rhino, once a throttle is hung on a task, the only way to get
+ * rid of it is to change behavior.  We push the throttle stamp forward in
+ * time as things improve until the stamp is in the future.  Only then may
+ * we safely pull our 'tranquilizer dart'. 
+ */
+#define conditional_tag(p) ((!(p)->throttle_stamp && 			\
+	(p)->sleep_avg > slice_avg(p) + THROTTLE_THRESHOLD) ?		\
+({									\
+	((p)->throttle_stamp = jiffies) ? : 1;				\
+}) : 0)
+
+/*
+ * Those who use the least cpu receive the most encouragement.
+ */
+#define SLICE_AVG_MULTIPLIER(p) \
+	(1 + NS_TO_JIFFIES(this_slice_avg(p)) * MAX_BONUS / MAX_SLEEP_AVG)
+
+#define conditional_release(p) (((p)->throttle_stamp &&			\
+	(p)->sched_time >= (G2 ? JIFFIES_TO_NS(HZ) : ~0ULL) &&		\
+	((20 + cpu_this_slice(p) < cpu_avg(p) && (p)->sleep_avg < 	\
+	slice_avg(p) + THROTTLE_THRESHOLD) || cpu_avg(p) <= 5)) ?	\
+({									\
+	int __ret = 0;							\
+	int delay = slice_time_avg(p) - last_slice(p);			\
+	if (delay > 0) {						\
+		delay *= SLICE_AVG_MULTIPLIER(p);			\
+		(p)->throttle_stamp += delay;				\
+	}								\
+	if (time_before(jiffies, (p)->throttle_stamp)) {		\
+		(p)->throttle_stamp = 0;				\
+		__ret++;						\
+		if (!((p)->state & TASK_NONINTERACTIVE))		\
+			(p)->sleep_type = SLEEP_NORMAL;			\
+	}								\
+	__ret;								\
+}) : 0)
+
+/*
+ * CURRENT_BONUS(p) adjusted to match slice_avg after grace expiration.
+ */
+#define ADJUSTED_BONUS(p, grace)				\
+({								\
+	unsigned long sleep_avg = (p)->sleep_avg;		\
+	if (grace_expired(p, (grace)))				\
+		sleep_avg = min((unsigned long)(p)->sleep_avg,	\
+		(unsigned long)slice_avg(p));			\
+	NS_TO_JIFFIES(sleep_avg) * MAX_BONUS / MAX_SLEEP_AVG;	\
+})
+
+#define BONUS_MULTIPLIER(p) \
+	(grace_expired(p, G1) ? : SLICE_AVG_MULTIPLIER(p))
+
+#define BONUS_DIVISOR(p) \
+	(grace_expired(p, G2) ? : (1 + ADJUSTED_BONUS(p, G1)))
+
+#define INTERACTIVE_SLEEP_AVG(p) \
+	(min(JIFFIES_TO_NS(MAX_SLEEP_AVG * (MAX_BONUS / 2 + DELTA(p)) / MAX_BONUS), \
+	NS_MAX_SLEEP_AVG))
+
+/*
+ * The quantity of sleep quaranteed to elevate a task to interactive status,
+ * or if already there, to elevate it to the next priority or beyond.
+ */
+#define INTERACTIVE_SLEEP_NS(p, ns) \
+	(BONUS_MULTIPLIER(p) * (ns) >= INTERACTIVE_SLEEP_AVG(p)	|| \
+	((p)->sleep_avg < INTERACTIVE_SLEEP_AVG(p) && BONUS_MULTIPLIER(p) * \
+	(ns) + (p)->sleep_avg >= INTERACTIVE_SLEEP_AVG(p))      || \
+	((p)->sleep_avg >= INTERACTIVE_SLEEP_AVG(p) && BONUS_MULTIPLIER(p) * \
+	(ns) + ((p)->sleep_avg % NEXT_PRIO) >= NEXT_PRIO))
 
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
@@ -659,7 +845,7 @@
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
+	bonus = ADJUSTED_BONUS(p, G2) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
@@ -759,36 +945,50 @@
 
 	if (likely(sleep_time > 0)) {
 		/*
-		 * User tasks that sleep a long time are categorised as
-		 * idle and will get just interactive status to stay active &
-		 * prevent them suddenly becoming cpu hogs and starving
-		 * other processes.
+		 * Tasks that sleep a long time are categorised as idle.
+		 * They will only have their sleep_avg increased to a
+		 * level that makes them just interactive priority to stay
+		 * active yet prevent them suddenly becoming cpu hogs and
+		 * starving other processes.  All tasks must stop at each
+		 * TASK_INTERACTIVE boundry before moving on so that no
+		 * single sleep slams it straight into NS_MAX_SLEEP_AVG.
 		 */
-		if (p->mm && p->activated != -1 &&
-			sleep_time > INTERACTIVE_SLEEP(p)) {
-				p->sleep_avg = JIFFIES_TO_NS(MAX_SLEEP_AVG -
-						DEF_TIMESLICE);
+		if (INTERACTIVE_SLEEP_NS(p, sleep_time)) {
+			int ticks = last_slice(p) / BONUS_DIVISOR(p);
+			unsigned long ceiling = INTERACTIVE_SLEEP_AVG(p);
+
+			ticks = JIFFIES_TO_NS(ticks);
+
+			if (grace_expired(p, G2) && slice_avg(p) < ceiling)
+				ceiling = slice_avg(p);
+			/* Promote previously interactive task. */
+			else if (p->sleep_avg >= INTERACTIVE_SLEEP_AVG(p) &&
+					!grace_expired(p, G2)) {
+
+				ceiling = p->sleep_avg / NEXT_PRIO;
+				if (ceiling < MAX_BONUS)
+					ceiling++;
+				ceiling *= NEXT_PRIO;
+			}
+
+			ceiling += ticks;
+
+			if (ceiling > NS_MAX_SLEEP_AVG)
+				ceiling = NS_MAX_SLEEP_AVG;
+
+			if (p->sleep_avg < ceiling)
+				p->sleep_avg = ceiling;
 		} else {
-			/*
-			 * The lower the sleep avg a task has the more
-			 * rapidly it will rise with sleep time.
-			 */
-			sleep_time *= (MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
 
 			/*
-			 * Tasks waking from uninterruptible sleep are
-			 * limited in their sleep_avg rise as they
-			 * are likely to be waiting on I/O
+			 * The lower the sleep avg a task has the more
+			 * rapidly it will rise with sleep time. This enables
+			 * tasks to rapidly recover to a low latency priority.
+			 * If a task was sleeping with the noninteractive
+			 * label do not apply this non-linear boost
 			 */
-			if (p->activated == -1 && p->mm) {
-				if (p->sleep_avg >= INTERACTIVE_SLEEP(p))
-					sleep_time = 0;
-				else if (p->sleep_avg + sleep_time >=
-						INTERACTIVE_SLEEP(p)) {
-					p->sleep_avg = INTERACTIVE_SLEEP(p);
-					sleep_time = 0;
-				}
-			}
+			if (p->sleep_type != SLEEP_NONINTERACTIVE)
+				sleep_time *= BONUS_MULTIPLIER(p);
 
 			/*
 			 * This code gives a bonus to interactive tasks.
@@ -835,7 +1035,7 @@
 	 * This checks to make sure it's not an uninterruptible task
 	 * that is now waking up.
 	 */
-	if (!p->activated) {
+	if (p->sleep_type != SLEEP_NONINTERACTIVE) {
 		/*
 		 * Tasks which were woken up by interrupts (ie. hw events)
 		 * are most likely of interactive nature. So we give them
@@ -844,13 +1044,13 @@
 		 * on a CPU, first time around:
 		 */
 		if (in_interrupt())
-			p->activated = 2;
+			p->sleep_type = SLEEP_INTERRUPTED;
 		else {
 			/*
 			 * Normal first-time wakeups get a credit too for
 			 * on-runqueue time, but it will be weighted down:
 			 */
-			p->activated = 1;
+			p->sleep_type = SLEEP_INTERACTIVE;
 		}
 	}
 	p->timestamp = now;
@@ -1371,25 +1571,28 @@
 
 out_activate:
 #endif /* CONFIG_SMP */
-	if (old_state == TASK_UNINTERRUPTIBLE) {
-		rq->nr_uninterruptible--;
+
+	conditional_release(p);
+
+	if (old_state & TASK_UNINTERRUPTIBLE) {
 		/*
-		 * Tasks on involuntary sleep don't earn
-		 * sleep_avg beyond just interactive state.
+		 * Tasks waking from uninterruptible sleep are likely
+		 * to be sleeping involuntarily on I/O and are otherwise
+		 * cpu bound so label them as noninteractive.
 		 */
-		p->activated = -1;
-	}
+		p->sleep_type = SLEEP_NONINTERACTIVE;
+	} else
 
 	/*
 	 * Tasks that have marked their sleep as noninteractive get
-	 * woken up without updating their sleep average. (i.e. their
-	 * sleep is handled in a priority-neutral manner, no priority
-	 * boost and no penalty.)
+	 * woken up with their sleep average not weighted in an
+	 * interactive way.
 	 */
-	if (old_state & TASK_NONINTERACTIVE)
-		__activate_task(p, rq);
-	else
-		activate_task(p, rq, cpu == this_cpu);
+		if (old_state & TASK_NONINTERACTIVE)
+			p->sleep_type = SLEEP_NONINTERACTIVE;
+
+
+	activate_task(p, rq, cpu == this_cpu);
 	/*
 	 * Sync wakeups (i.e. those types of wakeups where the waker
 	 * has indicated that it will leave the CPU in short order)
@@ -1471,9 +1674,27 @@
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
+	 * Note: The child inherits the parent's throttle,
+	 * and must shake it loose.  It does not inherit
+	 * the parent's slice_avg.
+	 */
+	set_slice_avg(p, NS_MAX_SLEEP_AVG);
+	set_last_slice(p, p->time_slice);
+	set_slice_is_new(p);
+	p->last_slice = jiffies;
+	/*
+	 * Limit the difficulty to what the parent faced.
+	 */
+	if (p->throttle_stamp && grace_expired(p, G2))
+		p->throttle_stamp = jiffies - G2;
+
 	if (unlikely(!current->time_slice)) {
 		/*
 		 * This case is rare, it happens when the parent has only
@@ -1587,7 +1808,7 @@
 	 * the sleep_avg of the parent as well.
 	 */
 	rq = task_rq_lock(p->parent, &flags);
-	if (p->first_time_slice && task_cpu(p) == task_cpu(p->parent)) {
+	if (first_time_slice(p) && task_cpu(p) == task_cpu(p->parent)) {
 		p->parent->time_slice += p->time_slice;
 		if (unlikely(p->parent->time_slice > task_timeslice(p)))
 			p->parent->time_slice = task_timeslice(p);
@@ -2655,6 +2876,51 @@
 }
 
 /*
+ * Calculate a task's average cpu usage rate in terms of sleep_avg, and
+ * check whether the task may soon need throttling.  Must be called after
+ * refreshing the task's time slice.
+ * @p: task for which slice_avg should be computed.
+ */
+static void recalc_task_slice_avg(task_t *p)
+{
+	unsigned int slice_avg = slice_avg_raw(p);
+	unsigned int time_slice = last_slice(p);
+	int w = MAX_BONUS, idle;
+
+	if (unlikely(!time_slice))
+		set_last_slice(p, p->time_slice);
+
+	idle = 100 - cpu_this_slice(p);
+
+	/*
+	 * If the task is lowering it's cpu usage, speed up the
+	 * effect on slice_avg so we don't over-throttle.
+	 */
+	if (idle > slice_avg) {
+		w -= idle / w;
+		if (!w)
+			w = 1;
+	}
+
+	slice_avg = (w * (slice_avg ? : 1) + idle) / (w + 1);
+
+	/* Check to see if we should start/stop throttling. */
+	if(!rt_task(p) && !conditional_release(p))
+		conditional_tag(p);
+
+	/* Update slice_avg. */
+	set_slice_avg_raw(p, slice_avg);
+
+	/* Update cached slice length. */
+	if (time_slice != p->time_slice)
+		set_last_slice(p, p->time_slice);
+
+	/* And finally, stamp and tag the new slice. */
+	set_slice_is_new(p);
+	p->last_slice = jiffies;
+}
+
+/*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  *
@@ -2699,20 +2965,24 @@
 		 */
 		if ((p->policy == SCHED_RR) && !--p->time_slice) {
 			p->time_slice = task_timeslice(p);
-			p->first_time_slice = 0;
+			recalc_task_slice_avg(p);
+			clr_first_time_slice(p);
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
-		p->first_time_slice = 0;
+		recalc_task_slice_avg(p);
+		p->prio = effective_prio(p);
+		clr_first_time_slice(p);
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
@@ -2959,6 +3229,12 @@
 
 #endif
 
+static inline int interactive_sleep(enum sleep_type sleep_type)
+{
+	return (sleep_type == SLEEP_INTERACTIVE ||
+		sleep_type == SLEEP_INTERRUPTED);
+}
+
 /*
  * schedule() is the main scheduler function.
  */
@@ -3017,7 +3293,7 @@
 	 * Tasks charged proportionately less run_time at high sleep_avg to
 	 * delay them losing their interactive status
 	 */
-	run_time /= (CURRENT_BONUS(prev) ? : 1);
+	run_time /= BONUS_DIVISOR(prev);
 
 	spin_lock_irq(&rq->lock);
 
@@ -3031,7 +3307,7 @@
 				unlikely(signal_pending(prev))))
 			prev->state = TASK_RUNNING;
 		else {
-			if (prev->state == TASK_UNINTERRUPTIBLE)
+			if (prev->state & TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible++;
 			deactivate_task(prev, rq);
 		}
@@ -3080,16 +3356,17 @@
 		rq->best_expired_prio = MAX_PRIO;
 	}
 
+repeat_selection:
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
-	if (!rt_task(next) && next->activated > 0) {
+	if (!rt_task(next) && interactive_sleep(next->sleep_type)) {
 		unsigned long long delta = now - next->timestamp;
 		if (unlikely((long long)(now - next->timestamp) < 0))
 			delta = 0;
 
-		if (next->activated == 1)
+		if (next->sleep_type == SLEEP_INTERACTIVE)
 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 
 		array = next->array;
@@ -3099,10 +3376,16 @@
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
-	next->activated = 0;
+	next->sleep_type = SLEEP_NORMAL;
 switch_tasks:
 	if (next == rq->idle)
 		schedstat_inc(rq, sched_goidle);
@@ -3118,6 +3401,14 @@
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
--- linux-2.6.16-rc1/kernel/sysctl.c.org	2006-02-12 21:29:24.000000000 +0100
+++ linux-2.6.16-rc1/kernel/sysctl.c	2006-02-12 21:29:53.000000000 +0100
@@ -71,6 +71,8 @@
 extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
+extern int sched_g1;
+extern int sched_g2;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -226,6 +228,11 @@
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
@@ -658,15 +665,29 @@
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
--- linux-2.6.16-rc1/fs/pipe.c.org	2006-02-12 21:29:35.000000000 +0100
+++ linux-2.6.16-rc1/fs/pipe.c	2006-02-12 21:29:53.000000000 +0100
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


