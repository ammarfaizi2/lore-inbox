Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWBLNlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWBLNlu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 08:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWBLNlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 08:41:49 -0500
Received: from mail.gmx.net ([213.165.64.21]:34435 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751029AbWBLNlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 08:41:47 -0500
X-Authenticated: #14349625
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: MIke Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Con Kolivas <kernel@kolivas.org>,
       gcoady@gmail.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139553319.8850.79.camel@homer>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602081335.18256.kernel@kolivas.org>
	 <Pine.LNX.4.61.0602091806100.30108@yvahk01.tjqt.qr>
	 <1139515605.30058.94.camel@mindpipe>  <1139553319.8850.79.camel@homer>
Content-Type: multipart/mixed; boundary="=-Tx8S/ZRusT/rvrhT2W8s"
Date: Sun, 12 Feb 2006 14:47:13 +0100
Message-Id: <1139752033.27408.20.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Tx8S/ZRusT/rvrhT2W8s
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-02-10 at 07:35 +0100, MIke Galbraith wrote:
> On Thu, 2006-02-09 at 15:06 -0500, Lee Revell wrote:
> > On Thu, 2006-02-09 at 18:06 +0100, Jan Engelhardt wrote:
> > > >> grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log| cut
> > > >> -c-95 ...
> > > >
> > > >What happens if you add "| cat" on the end of your command?
> > > >
> > > Do you think it's the new pipe buffering thing? (Introduced 2.6.10-.12, 
> > > don't remember exactly)
> > 
> > If it's the same problem I've been seeing it goes back much farther than
> > 2.6.10.
> > 
> > Lately I suspect the scheduler.
> 
> Hmm.  I ran into an oddity while testing a modified kernel, and see
> something in schedule() that I don't think is right...
> 
> Down where it does requeue_task(next, array) if a freshly awakened task
> is to possibly receive a priority boost for the time it sat on the
> runqueue, I see a potential problem.  If the task didn't sit on the
> queue long enough to be promoted, and isn't at the very top, it is going
> to the back of the bus as soon it gets preempted by say xmms.  For a
> task that possibly just sat through the full rotation of a busy queue
> waiting for a shot at the cpu, that has got to hurt.  Speculating, that
> requeue looks like it's there to increase the queue rotation rate, ie to
> reduce latency, but it looks to me like it can also accomplish the
> opposite if the context switch rate for your queue isn't very high.
> 
> ... I ended up sharing a queue with a few rampaging irman2 threads, and
> each keystroke took ages.  [btw, i wonder how the heck next->array could
> not be rq->active there]  

I guess you didn't try my pseudo suggestion.  Since I happen to be
actively tinkering in this very area, I'll be a bit more direct :)

If you think it's the scheduler, how about try the patch below.  It's
against 2.6.16-rc2-mm1, and should tell you if it is the interactivity
logic in the scheduler or not.  I don't see other candidates in there,
not that that means there aren't any of course.

With this patch in place, running an irman2 in one window, a make -j4
over nfs in another, and multimedia_sim as a test application in
another, I get these results...
 
[mikeg@Homer]:> ./multimedia_sim 0 60
nice_level = 0
duration = 60 seconds
[frames] received: 1784 dropped: 0
[latency] mean: 0.000627 max: 0.019647 stddev: 0.000786
score: 0.004240

.... test proggy attached for inspection.

To be extra sure, set both /proc/sys/kernel/sched_g1 and g2 to 0.  That
will (I mean should of course;) more or less restore the original O(1)
scheduler behavior.

	-Mike

Maybe not pretty, but effective counts too...

--- linux-2.6.16-rc2-mm1x/include/linux/sched.h.org	2006-02-09 13:15:50.000000000 +0100
+++ linux-2.6.16-rc2-mm1x/include/linux/sched.h	2006-02-09 13:16:30.000000000 +0100
@@ -721,14 +721,14 @@
 
 	unsigned short ioprio;
 
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
--- linux-2.6.16-rc2-mm1x/include/linux/sysctl.h.org	2006-02-09 13:16:02.000000000 +0100
+++ linux-2.6.16-rc2-mm1x/include/linux/sysctl.h	2006-02-09 13:16:30.000000000 +0100
@@ -147,6 +147,8 @@
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
+	KERN_SCHED_THROTTLE1=72,  /* int: throttling grace period 1 in secs */
+	KERN_SCHED_THROTTLE2=73,  /* int: throttling grace period 2 in secs */
 };
 
 
--- linux-2.6.16-rc2-mm1x/kernel/sched.c.org	2006-02-09 13:15:04.000000000 +0100
+++ linux-2.6.16-rc2-mm1x/kernel/sched.c	2006-02-10 16:55:09.000000000 +0100
@@ -158,9 +158,195 @@
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
@@ -668,7 +854,7 @@
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
+	bonus = ADJUSTED_BONUS(p, G2) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
@@ -794,19 +980,39 @@
 
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
+		 * TASK_INTERACTIVE boundry before moving on so that no
+		 * single sleep slams it straight into NS_MAX_SLEEP_AVG.
 		 */
-		if (p->mm && sleep_time > INTERACTIVE_SLEEP(p)) {
-				unsigned long ceiling;
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
 
-				ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -
-					DEF_TIMESLICE);
-				if (p->sleep_avg < ceiling)
-					p->sleep_avg = ceiling;
+			ceiling += ticks;
+
+			if (ceiling > NS_MAX_SLEEP_AVG)
+				ceiling = NS_MAX_SLEEP_AVG;
+
+			if (p->sleep_avg < ceiling)
+				p->sleep_avg = ceiling;
 		} else {
 
 			/*
@@ -816,9 +1022,8 @@
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
@@ -1367,7 +1572,10 @@
 
 out_activate:
 #endif /* CONFIG_SMP */
-	if (old_state == TASK_UNINTERRUPTIBLE) {
+
+	conditional_release(p);
+
+	if (old_state & TASK_UNINTERRUPTIBLE) {
 		rq->nr_uninterruptible--;
 		/*
 		 * Tasks waking from uninterruptible sleep are likely
@@ -1468,9 +1676,27 @@
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
@@ -1584,7 +1810,7 @@
 	 * the sleep_avg of the parent as well.
 	 */
 	rq = task_rq_lock(p->parent, &flags);
-	if (p->first_time_slice && task_cpu(p) == task_cpu(p->parent)) {
+	if (first_time_slice(p) && task_cpu(p) == task_cpu(p->parent)) {
 		p->parent->time_slice += p->time_slice;
 		if (unlikely(p->parent->time_slice > task_timeslice(p)))
 			p->parent->time_slice = task_timeslice(p);
@@ -2665,6 +2891,51 @@
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
@@ -2709,20 +2980,24 @@
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
@@ -3033,7 +3308,7 @@
 	 * Tasks charged proportionately less run_time at high sleep_avg to
 	 * delay them losing their interactive status
 	 */
-	run_time /= (CURRENT_BONUS(prev) ? : 1);
+	run_time /= BONUS_DIVISOR(prev);
 
 	spin_lock_irq(&rq->lock);
 
@@ -3047,7 +3322,7 @@
 				unlikely(signal_pending(prev))))
 			prev->state = TASK_RUNNING;
 		else {
-			if (prev->state == TASK_UNINTERRUPTIBLE)
+			if (prev->state & TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible++;
 			deactivate_task(prev, rq);
 		}
@@ -3096,6 +3371,7 @@
 		rq->best_expired_prio = MAX_PRIO;
 	}
 
+repeat_selection:
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
@@ -3115,8 +3391,14 @@
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
@@ -3134,6 +3416,14 @@
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
--- linux-2.6.16-rc2-mm1x/kernel/sysctl.c.org	2006-02-09 13:15:17.000000000 +0100
+++ linux-2.6.16-rc2-mm1x/kernel/sysctl.c	2006-02-09 13:16:30.000000000 +0100
@@ -69,6 +69,8 @@
 extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
+extern int sched_g1;
+extern int sched_g2;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -224,6 +226,11 @@
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
@@ -666,15 +673,29 @@
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
--- linux-2.6.16-rc2-mm1x/fs/pipe.c.org	2006-02-09 13:15:35.000000000 +0100
+++ linux-2.6.16-rc2-mm1x/fs/pipe.c	2006-02-09 13:16:30.000000000 +0100
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


--=-Tx8S/ZRusT/rvrhT2W8s
Content-Disposition: attachment; filename=multimedia_sim.c
Content-Type: text/x-csrc; name=multimedia_sim.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

/* multimedia_sim.c v0.3
 *
 * Dec 2002 - Miguel Freitas
 *
 * this is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 *
 * this program is meant to simulate a dummy multimedia application and
 * measure how it would perform in a loaded system. it basicaly tries to
 * identify frame skipping problems that would have affected the movie
 * playback.
 *
 * although the model of threads is heavily based on xine's architecture,
 * its results should be also comparable with any other player program
 * like mplayer or avifile. the idea is to measure when the player isn't 
 * scheduled in time for sending images at full frame rate and if X server
 * would also be scheduled in time for displaying.
 *
 * of course one might try some tricks to improve performance like decreasing
 * nice values for both XFree86 and player. however some distros don't
 * ship the X reniced and modifying desktop menu entries to add "nice" and
 * "sudo" commands is beyond most of users who just want to play their dvds...
 * 
 * compile with: gcc -o multimedia_sim multimedia_sim.c -lpthread -lm
 * run as: ./multimedia_sim [nice_level] [test_duration]
 *
 * note1: default CPU_BURNING value should simulate more or less a mpeg2-class
 * decoding cpu usage. that will require, at least, a 300MHz processor.
 * 
 * note2: a better simulation of xine's backend/frontend architecture would
 * also include another thread (frontend) to receive the xshm completion
 * events. i have intentionally not implemented it here.
 */
 
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/time.h>
#include <math.h>
#include <inttypes.h>

#define FRAME_PERIOD     1000000/30    /* NTSC period in us */
#define FRAME_SIZE       720*480*3/2   /* std resolution in yv12 format */
#define PREBUFFER_FRAMES 15            /* how many frames to "decode" ahead */
#define CPU_BURNING      8             /* reduce if your cpu isn't fast enough */

int nice_level = 0;

int decoder_running;
int video_out_running;
int server_running;

pthread_mutex_t counters_lock;
pthread_cond_t wakeup_server;
pthread_mutex_t queue_lock;
pthread_cond_t enqueued;
pthread_cond_t dequeued;
int frames_sent = 0;
int frames_received = 0;
int frames_enqueued = 0;
double start_time;

pthread_mutex_t counters_lock;
pthread_cond_t wakeup_server;


/* statistics */
double total_latency = 0.0;
double total_square = 0.0;
double max_latency = 0.0;
int frames_dropped = 0;
int dropped_in_burst = 0;
int bursts = 0;


static void *alloc_frame( void ) {
  void *frame;
  
  frame = (void *)malloc(FRAME_SIZE);
  memset(frame,0,FRAME_SIZE);
  return frame;  
}

static void dummy_enqueue_frame( void ) {
  pthread_mutex_lock( &queue_lock ); 
  while( frames_enqueued == PREBUFFER_FRAMES )
    pthread_cond_wait( &dequeued, &queue_lock );
  frames_enqueued++;  
  pthread_cond_signal( &enqueued );
  pthread_mutex_unlock( &queue_lock ); 
}

static void dummy_dequeue_frame( void ) {
  pthread_mutex_lock( &queue_lock ); 
  while( !frames_enqueued )
    pthread_cond_wait( &enqueued, &queue_lock );
  frames_enqueued--;  
  pthread_cond_signal( &dequeued );
  pthread_mutex_unlock( &queue_lock ); 
}

static double get_us_time( void ) {
  struct timeval tv;
  double us;
   
  gettimeofday(&tv, NULL);
  us = tv.tv_sec * 1e6;
  us += tv.tv_usec;
  
  return us;
}

/* from libmpeg2, used to burn cpu cycles */
#define W1 2841 /* 2048*sqrt (2)*cos (1*pi/16) */
#define W2 2676 /* 2048*sqrt (2)*cos (2*pi/16) */
#define W3 2408 /* 2048*sqrt (2)*cos (3*pi/16) */
#define W5 1609 /* 2048*sqrt (2)*cos (5*pi/16) */
#define W6 1108 /* 2048*sqrt (2)*cos (6*pi/16) */
#define W7 565  /* 2048*sqrt (2)*cos (7*pi/16) */
static void idct_row (int16_t * block)
{
    int x0, x1, x2, x3, x4, x5, x6, x7, x8;

    x1 = block[4] << 11;
    x2 = block[6];
    x3 = block[2];
    x4 = block[1];
    x5 = block[7];
    x6 = block[5];
    x7 = block[3];

    x0 = (block[0] << 11) + 128; /* for proper rounding in the fourth stage */

    /* first stage */
    x8 = W7 * (x4 + x5);
    x4 = x8 + (W1 - W7) * x4;
    x5 = x8 - (W1 + W7) * x5;
    x8 = W3 * (x6 + x7);
    x6 = x8 - (W3 - W5) * x6;
    x7 = x8 - (W3 + W5) * x7;
 
    /* second stage */
    x8 = x0 + x1;
    x0 -= x1;
    x1 = W6 * (x3 + x2);
    x2 = x1 - (W2 + W6) * x2;
    x3 = x1 + (W2 - W6) * x3;
    x1 = x4 + x6;
    x4 -= x6;
    x6 = x5 + x7;
    x5 -= x7;
 
    /* third stage */
    x7 = x8 + x3;
    x8 -= x3;
    x3 = x0 + x2;
    x0 -= x2;
    x2 = (181 * (x4 + x5) + 128) >> 8;
    x4 = (181 * (x4 - x5) + 128) >> 8;
 
    /* fourth stage */
    block[0] = (x7 + x1) >> 8;
    block[1] = (x3 + x2) >> 8;
    block[2] = (x0 + x4) >> 8;
    block[3] = (x8 + x6) >> 8;
    block[4] = (x8 - x6) >> 8;
    block[5] = (x0 - x4) >> 8;
    block[6] = (x3 - x2) >> 8;
    block[7] = (x7 - x1) >> 8;
}


static void *decoder_loop (void *this_gen) {

  int16_t *frame;
  int i,j;
  
  frame = alloc_frame();
  /* dummy data */
  for( i = 0; i < FRAME_SIZE/sizeof(int16_t); i++ )
    frame[i] = i;

  while( decoder_running )
  {
    /* eat some cpu cycles */
    for( j = 0; j < CPU_BURNING; j++ )
     for( i = 0; i < FRAME_SIZE/8/sizeof(int16_t); i+=8 )
       idct_row( &frame[i] );
    
    dummy_enqueue_frame();
  }
  
  free(frame);
  
  pthread_exit(NULL);  
}


static void *video_out_loop (void *this_gen) {

  double ttf; /* time to frame */
  void *frame1, *frame2;
  
  nice(nice_level);
  
  frame1 = alloc_frame();
  frame2 = alloc_frame();

  start_time = get_us_time() + (FRAME_PERIOD * PREBUFFER_FRAMES);
  
  while( video_out_running )
  {
    dummy_dequeue_frame();
    
    /* eat some cpu cycles */
    /*memcpy(frame1, frame2, FRAME_SIZE);*/
    
    ttf = start_time + (frames_sent * FRAME_PERIOD);
    ttf -= get_us_time();
                   
    if( ttf > 0 )
      usleep( ttf );
    
    pthread_mutex_lock( &counters_lock ); 
    frames_sent++;
    pthread_cond_signal( &wakeup_server );
    pthread_mutex_unlock( &counters_lock ); 
  }
  
  free(frame1);
  free(frame2);
  
  pthread_exit(NULL);  
}


static void *server_loop (void *this_gen) {

  double estimated;
  double latency;
  void *frame1, *frame2;
  
  nice(nice_level);

  frame1 = alloc_frame();
  frame2 = alloc_frame();
  
  while( server_running )
  {
    pthread_mutex_lock( &counters_lock ); 
    while( frames_sent <= frames_received )
      pthread_cond_wait( &wakeup_server, &counters_lock );
    pthread_mutex_unlock( &counters_lock ); 
    
    estimated = start_time + (frames_received * FRAME_PERIOD);
    latency = (get_us_time() - estimated)/1.0e6;
     
    if( latency > max_latency )
      max_latency = latency;
       
    frames_received++;
    if( latency > FRAME_PERIOD/1.0e6 ) {
      frames_dropped++;
      dropped_in_burst++;
    } else if (dropped_in_burst) {
      dropped_in_burst = 0;
      bursts++;
    }
    
    total_latency += latency;
    total_square += latency * latency;
    
    /* eat some cpu cycles */
    memcpy(frame1, frame2, FRAME_SIZE);
  }
    
  if (dropped_in_burst)
    bursts++;
  
  free(frame1);
  free(frame2);
  
  pthread_exit(NULL);  
}


int main(int argc, char *argv[])
{
  pthread_t decoder_thread;
  pthread_t video_thread;
  pthread_t server_thread;
  void *p;
  double mean, var, stddev;
  double burst_size;
  double score;
  int duration = 10;

  if( argc > 1 ) {
    nice_level = atoi(argv[1]);
    printf("nice_level = %d\n", nice_level );
    if( nice_level < 0 )
      printf("(make sure you are root for negative nice)\n");
    if( argc > 2 ) {
      duration = atoi(argv[2]);
      printf("duration = %d seconds\n", duration );
    }
  }
  
  pthread_mutex_init (&counters_lock, NULL);
  pthread_cond_init  (&wakeup_server, NULL);
  pthread_mutex_init (&queue_lock, NULL);
  pthread_cond_init  (&enqueued, NULL);
  pthread_cond_init  (&dequeued, NULL);

  server_running = 1;
  if ( pthread_create (&server_thread, NULL, server_loop, NULL) != 0) {
    printf("Error creating server thread.\n");
    return 1;
  }
    
  video_out_running = 1;
  if ( pthread_create (&video_thread, NULL, video_out_loop, NULL) != 0) {
    printf("Error creating video thread.\n");
    return 1;
  }

  decoder_running = 1;
  if ( pthread_create (&decoder_thread, NULL, decoder_loop, NULL) != 0) {
    printf("Error creating decoder thread.\n");
    return 1;
  }
  
  sleep(duration);
  
  server_running = 0;
  pthread_join(server_thread,&p);
  video_out_running = 0;
  pthread_join(video_thread, &p);
  
  printf("[frames] received: %d dropped: %d\n", frames_received, frames_dropped );
  if( bursts ) {
    burst_size = (double)frames_dropped / bursts;
    printf("[frames] mean dropped per burst: %lf\n", burst_size );
  } else
    burst_size = 1.0;
  
  mean = total_latency / frames_received;
  var = total_square / frames_received - mean*mean;
  stddev = sqrt(var);
  printf("[latency] mean: %lf max: %lf stddev: %lf\n", mean, max_latency, stddev);
  
  /* score: lower is better. it tries to measure "how bad" the playback
   * was to the user. it counts fraction of dropped frames, if the dropped
   * frames were somewhat evenly distributed (instead of in bursts), and
   * also the mean and standard deviation. 
   * note that the formula is actually arbitrary, i'm just trying to count
   * all these factors and weight them.
   */
  
  score = 0.0; 
  score += 0.90 * (double) frames_dropped / frames_received * sqrt(burst_size);
  score += 0.10 * (mean + stddev)/(FRAME_PERIOD/1.0e6);
  printf("score: %lf\n", score );
}

--=-Tx8S/ZRusT/rvrhT2W8s--

