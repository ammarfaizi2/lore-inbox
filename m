Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267058AbTGOKHA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 06:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267063AbTGOKHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 06:07:00 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:47327 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S267058AbTGOKGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 06:06:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] N1int for interactivity
Date: Tue, 15 Jul 2003 20:23:50 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, efault@gmx.de, felipe_alfaro@linuxmail.org
References: <200307151355.23586.kernel@kolivas.org> <20030714205915.5a4c8d16.akpm@osdl.org> <Pine.LNX.4.53.0307150254390.32541@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.53.0307150254390.32541@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307152023.51207.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003 17:00, Zwane Mwaikambo wrote:
> On Mon, 14 Jul 2003, Andrew Morton wrote:
> > >  	base = monotonic_base;
> > > -	read_unlock_irq(&monotonic_lock);
> > > +	read_unlock_irqrestore(&monotonic_lock, flags);
> > >
> > >  	/* Read the Time Stamp Counter */
> >
> > Why do we need to take a global lock here?  Can't we use
> > get_cycles() or something?
>
> I think that'll break even on some x86 boxes if we used get_cycles. I do
> wonder however why we need that lock, i see x86/64 uses seqlock at least.
> Although i can't vouch for whether that would have an adverse affect here.
> I presume Stultz would know.
>
> > Have all the other architectures been reviewed to see if they need this
> > change?
>
> No one else appears to have monotonic_clock, this would break every other
> arch out there.

Ok what this patch is for is to see whether we really need to go down this 
path. It may be untidy and have dragons but it can be cleaned up and 
work with other archs but I just need some feedback by testers to see if it
adds _significant_ benefit that warrants it's addition to the direction I'm
already taking. Unfortunately all the incremental patches I've done seem 
to have scared people off :(

Here's a slightly tidier version (also at kernel.kolivas.org/2.5) which
patches against 2.5.75-mm1 that has been patched with O5int.

akpm removed from cc list as it's not interesting for -mm atm

Con

diff -Naurp linux-2.5.75-mm1/arch/i386/kernel/timers/timer_tsc.c linux-2.5.75-test/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.5.75-mm1/arch/i386/kernel/timers/timer_tsc.c	2003-07-12 00:01:27.000000000 +1000
+++ linux-2.5.75-test/arch/i386/kernel/timers/timer_tsc.c	2003-07-15 12:48:14.000000000 +1000
@@ -102,12 +102,13 @@ static unsigned long get_offset_tsc(void
 static unsigned long long monotonic_clock_tsc(void)
 {
 	unsigned long long last_offset, this_offset, base;
-	
+	unsigned long flags;
+
 	/* atomically read monotonic base & last_offset */
-	read_lock_irq(&monotonic_lock);
+	read_lock_irqsave(&monotonic_lock, flags);
 	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	base = monotonic_base;
-	read_unlock_irq(&monotonic_lock);
+	read_unlock_irqrestore(&monotonic_lock, flags);
 
 	/* Read the Time Stamp Counter */
 	rdtscll(this_offset);
diff -Naurp linux-2.5.75-mm1/include/linux/sched.h linux-2.5.75-test/include/linux/sched.h
--- linux-2.5.75-mm1/include/linux/sched.h	2003-07-13 00:21:30.000000000 +1000
+++ linux-2.5.75-test/include/linux/sched.h	2003-07-15 20:11:53.000000000 +1000
@@ -341,7 +341,9 @@ struct task_struct {
 
 	unsigned long sleep_avg;
 	unsigned long avg_start;
-	unsigned long last_run;
+	unsigned long long last_run;
+	unsigned long run_nsecs;
+	unsigned long sleep_nsecs;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
diff -Naurp linux-2.5.75-mm1/kernel/sched.c linux-2.5.75-test/kernel/sched.c
--- linux-2.5.75-mm1/kernel/sched.c	2003-07-15 12:47:41.000000000 +1000
+++ linux-2.5.75-test/kernel/sched.c	2003-07-15 20:07:26.000000000 +1000
@@ -78,8 +78,14 @@
 #define STARVATION_LIMIT	(10*HZ)
 #define SLEEP_BUFFER		(HZ/20)
 #define NODE_THRESHOLD		125
+#define SCHED_NANOSECOND	1
+#define SCHED_SECOND		(1000000000 * SCHED_NANOSECOND)
+#define SCHED_TICK		(SCHED_SECOND / HZ)
+#define TICKS_PER_SECOND	(SCHED_SECOND / SCHED_TICK)
 #define MAX_BONUS		((MAX_USER_PRIO - MAX_RT_PRIO) * PRIO_BONUS_RATIO / 100)
 
+extern unsigned long long monotonic_clock(void);
+
 /*
  * If a task is 'interactive' then we reinsert it in the active
  * array after it has expired its current timeslice. (it will not
@@ -387,9 +393,19 @@ static inline void __activate_task(task_
  */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	long sleep_time = jiffies - p->last_run - 1;
+	unsigned long long now = monotonic_clock();
+	unsigned long sleep =  (unsigned long)(now - p->last_run + p->sleep_nsecs);
+	unsigned long ticks = 0;
+
+	if (sleep >= SCHED_TICK) {
+		ticks += TICKS_PER_SECOND * (sleep / SCHED_SECOND);
+		sleep %= SCHED_SECOND;
+		ticks += sleep / SCHED_TICK;
+		sleep %= SCHED_TICK;
+		p->sleep_nsecs = sleep;
+	} else p->sleep_nsecs += sleep;
 
-	if (sleep_time > 0) {
+	if (ticks > 0) {
 		unsigned long runtime = jiffies - p->avg_start;
 
 		/*
@@ -397,7 +413,7 @@ static inline void activate_task(task_t 
 		 * will get just under interactive status with a small runtime
 		 * to allow them to become interactive or non-interactive rapidly
 		 */
-		if (sleep_time > MIN_SLEEP_AVG){
+		if (ticks > MIN_SLEEP_AVG){
 			p->avg_start = jiffies - MIN_SLEEP_AVG;
 			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 1) /
 				MAX_BONUS;
@@ -410,7 +426,7 @@ static inline void activate_task(task_t 
 			 * spends sleeping, the higher the average gets - and the
 			 * higher the priority boost gets as well.
 			 */
-			p->sleep_avg += sleep_time;
+			p->sleep_avg += ticks;
 
 			/*
 			 * Give a bonus to tasks that wake early on to prevent
@@ -427,8 +443,10 @@ static inline void activate_task(task_t 
 			 * prevent fully interactive tasks from becoming
 			 * lower priority with small bursts of cpu usage.
 			 */
-			if (p->sleep_avg > (MAX_SLEEP_AVG + SLEEP_BUFFER))
+			if (p->sleep_avg > (MAX_SLEEP_AVG + SLEEP_BUFFER)){
 				p->sleep_avg = MAX_SLEEP_AVG + SLEEP_BUFFER;
+				p->sleep_nsecs = 0;
+			}
 		}
 
 		if (unlikely(p->avg_start > jiffies)){
@@ -616,6 +634,8 @@ void wake_up_forked_process(task_t * p)
 	normalise_sleep(p);
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 	p->prio = effective_prio(p);
+	p->run_nsecs = 0;
+	p->sleep_nsecs = 0;
 	set_task_cpu(p, smp_processor_id());
 
 	if (unlikely(!current->array))
@@ -1236,6 +1256,57 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
 		(jiffies - (rq)->expired_timestamp >= \
 			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
 
+static void __scheduler_tick(runqueue_t *rq, task_t *p)
+{
+	unsigned long long now = monotonic_clock();
+	prio_array_t *array = rq->active;
+	unsigned long ticks;
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
+	} else if (unlikely(p->prio < effective_prio(p))){
+		/*
+		 * Tasks that have lowered their priority are put to the end
+		 * of the active array with their remaining timeslice
+		 */
+		dequeue_task(p, rq->active);
+		set_tsk_need_resched(p);
+		p->prio = effective_prio(p);
+		enqueue_task(p, rq->active);
+	}
+
+abort:
+	p->last_run = monotonic_clock();
+}
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -1249,11 +1320,12 @@ void scheduler_tick(int user_ticks, int 
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
+	int idle = p == rq->idle;
 
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
 
-	if (p == rq->idle) {
+	if (idle) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
 			cpustat->system += sys_ticks;
@@ -1261,8 +1333,7 @@ void scheduler_tick(int user_ticks, int 
 			cpustat->iowait += sys_ticks;
 		else
 			cpustat->idle += sys_ticks;
-		rebalance_tick(rq, 1);
-		return;
+		goto out;
 	}
 	if (TASK_NICE(p) > 0)
 		cpustat->nice += user_ticks;
@@ -1270,61 +1341,15 @@ void scheduler_tick(int user_ticks, int 
 		cpustat->user += user_ticks;
 	cpustat->system += sys_ticks;
 
-	/* Task might have expired already, but not scheduled off yet */
-	if (p->array != rq->active) {
-		set_tsk_need_resched(p);
-		goto out;
-	}
 	spin_lock(&rq->lock);
 	/*
 	 * The task was running during this tick - update the
-	 * time slice counter and the sleep average.
+	 * time slice counter and the sleep average. 
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
-	} else if (unlikely(p->prio < effective_prio(p))){
-		/*
-		 * Tasks that have lowered their priority are put to the end
-		 * of the active array with their remaining timeslice
-		 */
-		dequeue_task(p, rq->active);
-		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
-		enqueue_task(p, rq->active);
-	}
-out_unlock:
+	 __scheduler_tick(rq, p);
 	spin_unlock(&rq->lock);
 out:
-	rebalance_tick(rq, 0);
+	rebalance_tick(rq, idle);
 }
 
 void scheduling_functions_start_here(void) { }
@@ -1358,8 +1383,8 @@ need_resched:
 	rq = this_rq();
 
 	release_kernel_lock(prev);
-	prev->last_run = jiffies;
 	spin_lock_irq(&rq->lock);
+	__scheduler_tick(rq, prev);
 
 	/*
 	 * if entering off of a kernel preemption go straight
@@ -1414,6 +1439,7 @@ switch_tasks:
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		rq->curr = next;
+		next->last_run = prev->last_run;
 
 		prepare_arch_switch(rq, next);
 		prev = context_switch(rq, prev, next);

