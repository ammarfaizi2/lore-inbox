Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbTFWL1s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 07:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbTFWL1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 07:27:48 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:26893 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266002AbTFWL1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 07:27:41 -0400
Subject: [PATCH] 2.5.72-mm3 O(1) interactivity enhancements
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-nyYOnIm+AMZX8ZX+FfhN"
Message-Id: <1056368505.746.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 23 Jun 2003 13:41:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nyYOnIm+AMZX8ZX+FfhN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

I have just cooked up a patch which mixes Mike Galbraith's excellent
monotonic clock O(1) scheduler changes with another patch I think that
came from Ingo Molnar and some scheduler parameter tweaks. This patch is
against 2.5.72-mm3, but applies cleanly on top of 2.5.73.

For me, it gives impressive interactive behavior. With it applied, I can
no longer make XMMS skips sound, moving windows on an X session is
perfectly smooth, even when moving them fastly enough for a very long
time.

Thanks for listening!


--=-nyYOnIm+AMZX8ZX+FfhN
Content-Disposition: attachment; filename=sched.patch
Content-Type: text/x-patch; name=sched.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -ur linux-2.5.72/arch/i386/kernel/timers/timer_tsc.c linux-2.5.72-best/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.5.72/arch/i386/kernel/timers/timer_tsc.c	2003-06-17 06:20:07.000000000 +0200
+++ linux-2.5.72-best/arch/i386/kernel/timers/timer_tsc.c	2003-06-23 13:00:34.000000000 +0200
@@ -102,12 +102,13 @@
 static unsigned long long monotonic_clock_tsc(void)
 {
 	unsigned long long last_offset, this_offset, base;
+	unsigned long flags;
 	
 	/* atomically read monotonic base & last_offset */
-	read_lock_irq(&monotonic_lock);
+	read_lock_irqsave(&monotonic_lock, flags);
 	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	base = monotonic_base;
-	read_unlock_irq(&monotonic_lock);
+	read_unlock_irqrestore(&monotonic_lock, flags);
 
 	/* Read the Time Stamp Counter */
 	rdtscll(this_offset);
diff -ur linux-2.5.72/include/linux/sched.h linux-2.5.72-best/include/linux/sched.h
--- linux-2.5.72/include/linux/sched.h	2003-06-23 13:32:41.391468232 +0200
+++ linux-2.5.72-best/include/linux/sched.h	2003-06-23 13:00:34.000000000 +0200
@@ -343,7 +343,9 @@
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
-	unsigned long last_run;
+	unsigned long long last_run;
+	unsigned int run_nsecs;
+	unsigned int sleep_nsecs;
 
 #ifdef CONFIG_SLEEPOMETER
 	unsigned long long sleepo_start;	/* usecs */
diff -ur linux-2.5.72/kernel/sched.c linux-2.5.72-best/kernel/sched.c
--- linux-2.5.72/kernel/sched.c	2003-06-23 13:32:41.456458352 +0200
+++ linux-2.5.72-best/kernel/sched.c	2003-06-23 13:31:09.639416664 +0200
@@ -67,14 +67,20 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
-#define CHILD_PENALTY		50
+#define CHILD_PENALTY		75
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
-#define PRIO_BONUS_RATIO	25
+#define PRIO_BONUS_RATIO	20
 #define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(10*HZ)
-#define STARVATION_LIMIT	(10*HZ)
+#define MAX_SLEEP_AVG		(2*HZ)
+#define STARVATION_LIMIT	(2*HZ)
 #define NODE_THRESHOLD		125
+#define SCHED_NANOSECOND	1
+#define SCHED_SECOND		(1000000000 * SCHED_NANOSECOND)
+#define SCHED_TICK		(SCHED_SECOND / HZ)
+#define TICKS_PER_SECOND	(SCHED_SECOND / SCHED_TICK)
+
+extern unsigned long long monotonic_clock(void);
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -346,9 +352,23 @@
  */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	long sleep_time = jiffies - p->last_run - 1;
+	unsigned long long now = monotonic_clock();
+	long long sleep =  now - p->last_run + p->sleep_nsecs;
+	int ticks = 0, requeue_waker = 0;
+
+	if (sleep >= SCHED_TICK) {
+		while (sleep >= SCHED_SECOND) {
+			sleep -= SCHED_SECOND;
+			ticks += TICKS_PER_SECOND;
+		}
+		while (sleep >= SCHED_TICK) {
+			sleep -= SCHED_TICK;
+			ticks++;
+		}
+		p->sleep_nsecs = sleep;
+	} else p->sleep_nsecs += sleep;
 
-	if (sleep_time > 0) {
+	if (ticks > 0) {
 		int sleep_avg;
 
 		/*
@@ -359,7 +379,7 @@
 		 * spends sleeping, the higher the average gets - and the
 		 * higher the priority boost gets as well.
 		 */
-		sleep_avg = p->sleep_avg + sleep_time;
+		sleep_avg = p->sleep_avg + ticks;
 
 		/*
 		 * 'Overflow' bonus ticks go to the waker as well, so the
@@ -367,8 +387,10 @@
 		 * boosting tasks that are related to maximum-interactive
 		 * tasks.
 		 */
-		if (sleep_avg > MAX_SLEEP_AVG)
+		if (sleep_avg > MAX_SLEEP_AVG) {
 			sleep_avg = MAX_SLEEP_AVG;
+			p->sleep_nsecs = 0;
+		}
 		if (p->sleep_avg != sleep_avg) {
 			p->sleep_avg = sleep_avg;
 			p->prio = effective_prio(p);
@@ -552,6 +574,8 @@
 	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 	p->prio = effective_prio(p);
+	p->run_nsecs = 0;
+	p->sleep_nsecs = 0;
 	set_task_cpu(p, smp_processor_id());
 
 	if (unlikely(!current->array))
@@ -1151,6 +1175,57 @@
 		(jiffies - (rq)->expired_timestamp >= \
 			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
 
+inline void __scheduler_tick(runqueue_t *rq, task_t *p)
+{
+	unsigned long long now = monotonic_clock();
+	prio_array_t *array = rq->active;
+	int ticks;
+
+	p->run_nsecs += now - p->last_run;
+	/* Task might have expired already, but not scheduled off yet */
+	if (p->array != array) {
+		set_tsk_need_resched(p);
+		goto abort;
+	}
+	if (p->run_nsecs < SCHED_TICK || p->policy == SCHED_FIFO )
+		goto abort;
+
+	for (ticks = 0; p->run_nsecs >= SCHED_TICK; ticks++)
+		p->run_nsecs -= SCHED_TICK;
+	if (ticks > p->time_slice)
+		show_task(p);
+	if (p->sleep_avg > ticks)
+		p->sleep_avg -= ticks;
+	else
+		p->sleep_avg = 0;
+	p->time_slice -= ticks;
+
+	if (p->time_slice <= 0) {
+		dequeue_task(p, p->array);
+		p->prio = effective_prio(p);
+		p->time_slice = task_timeslice(p);
+		p->first_time_slice = 0;
+		set_tsk_need_resched(p);
+		if ((EXPIRED_STARVING(rq) && !rt_task(p)) ||
+				!TASK_INTERACTIVE(p)) {
+			array = rq->expired;
+			if (!rq->expired_timestamp)
+				rq->expired_timestamp = jiffies;
+		}
+		enqueue_task(p, array);
+	} else {
+		if (!(p->time_slice % MIN_TIMESLICE) &&
+				(p->array == rq->active)) {
+			dequeue_task(p, rq->active);
+			set_tsk_need_resched(p);
+			p->prio = effective_prio(p);
+			enqueue_task(p, rq->active);
+		}
+	}
+abort:
+	p->last_run = monotonic_clock();
+}
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -1163,11 +1238,12 @@
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
+	int idle = p == rq->idle;
 
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
 
-	if (p == rq->idle) {
+	if (idle) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
 			kstat_cpu(cpu).cpustat.system += sys_ticks;
@@ -1175,8 +1251,7 @@
 			kstat_cpu(cpu).cpustat.iowait += sys_ticks;
 		else
 			kstat_cpu(cpu).cpustat.idle += sys_ticks;
-		rebalance_tick(rq, 1);
-		return;
+		goto out;
 	}
 	if (TASK_NICE(p) > 0)
 		kstat_cpu(cpu).cpustat.nice += user_ticks;
@@ -1184,11 +1259,6 @@
 		kstat_cpu(cpu).cpustat.user += user_ticks;
 	kstat_cpu(cpu).cpustat.system += sys_ticks;
 
-	/* Task might have expired already, but not scheduled off yet */
-	if (p->array != rq->active) {
-		set_tsk_need_resched(p);
-		goto out;
-	}
 	spin_lock(&rq->lock);
 	/*
 	 * The task was running during this tick - update the
@@ -1198,42 +1268,10 @@
 	 * it possible for interactive tasks to use up their
 	 * timeslices at their highest priority levels.
 	 */
-	if (p->sleep_avg)
-		p->sleep_avg--;
-	if (unlikely(rt_task(p))) {
-		/*
-		 * RR tasks need a special form of timeslice management.
-		 * FIFO tasks have no timeslices.
-		 */
-		if ((p->policy == SCHED_RR) && !--p->time_slice) {
-			p->time_slice = task_timeslice(p);
-			p->first_time_slice = 0;
-			set_tsk_need_resched(p);
-
-			/* put it at the end of the queue: */
-			dequeue_task(p, rq->active);
-			enqueue_task(p, rq->active);
-		}
-		goto out_unlock;
-	}
-	if (!--p->time_slice) {
-		dequeue_task(p, rq->active);
-		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
-		p->time_slice = task_timeslice(p);
-		p->first_time_slice = 0;
-
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			if (!rq->expired_timestamp)
-				rq->expired_timestamp = jiffies;
-			enqueue_task(p, rq->expired);
-		} else
-			enqueue_task(p, rq->active);
-	}
-out_unlock:
+	 __scheduler_tick(rq, p);
 	spin_unlock(&rq->lock);
 out:
-	rebalance_tick(rq, 0);
+	rebalance_tick(rq, idle);
 }
 
 void scheduling_functions_start_here(void) { }
@@ -1271,8 +1309,8 @@
 	rq = this_rq();
 
 	release_kernel_lock(prev);
-	prev->last_run = jiffies;
 	spin_lock_irq(&rq->lock);
+	__scheduler_tick(rq, prev);
 
 	/*
 	 * if entering off of a kernel preemption go straight
@@ -1327,6 +1365,7 @@
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		rq->curr = next;
+		next->last_run = prev->last_run;
 
 		prepare_arch_switch(rq, next);
 		prev = context_switch(rq, prev, next);

--=-nyYOnIm+AMZX8ZX+FfhN--

