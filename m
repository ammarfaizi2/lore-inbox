Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTDLMaI (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 08:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTDLMaI (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 08:30:08 -0400
Received: from lsanca2-ar27-4-46-141-054.lsanca2.dsl-verizon.net ([4.46.141.54]:46852
	"EHLO BL4ST") by vger.kernel.org with ESMTP id S263260AbTDLM34 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 08:29:56 -0400
Date: Sat, 12 Apr 2003 05:41:32 -0700
From: Eric Wong <eric@yhbt.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-ck5 sucks
Message-ID: <20030412124132.GA3187@BL4ST>
References: <200304121323.25094.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304121323.25094.kernel@kolivas.org>
Organization: Tire Smokers Anonymous
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
> It seems the interactivity patch wasn't worth the effort, confirming my 
> suspicions - which is why I resisted posting it in the first place.

Yikes!  I've been indulging in 2.5.67 + anticipatory I/O for bit now, 
back to 2.4...

I finally got around running ck5 with a lot of other odd patches from
here and there just last night.  I wasn't sure if it was ck5 or any
thing else I put in my kernel that caused it, but the scheduler didn't
seem to want to work once physical memory was low. 

There's a pretty serious bug in the ck5 scheduler where things stop
running after physical memory is low.  Even if the make World jobs are
cancelled, performance is still sluggish.

I tried compiling X in two directories simultaneously, 2.5.67+as-I/O
passes with flying colors while remaining quite usable in X. ck5 works
initially, but once I started using up memory the CPU started idling
(even though there was plenty of CPU work to be done) and eventually
everything stalled :(

I started looking at the 2.5.66/7 scheduler again and did a glorified
cut and paste job that seems to work, at least with regards to fixing
performance system deteriorating and not recovering syndrome. 

It's not tuned for the best interactive response yet, HZ is unchanged
from the 2.4 default of 100, and heavy disk I/O still kills latency (I
didn't run the read latency2 hack).  Nevertheless, XMMS plays
SHN/FLAC/mp3 files well even during large compile jobs, even while
limiting myself to only 128M of physical RAM.


this patch is against 001_o1_pe_ll_030412_ck_2.4.20 only

note: not SMP tested!


diff -ruNp ck6pre/include/linux/sched.h ck5bad/include/linux/sched.h
--- ck6pre/include/linux/sched.h	2003-04-11 21:51:09.000000000 -0700
+++ ck5bad/include/linux/sched.h	2003-04-12 04:04:35.000000000 -0700
@@ -355,7 +355,7 @@ struct task_struct {
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
-	unsigned long sleep_timestamp;
+	unsigned long last_run;
 
 	unsigned long policy;
 	unsigned long cpus_allowed;
diff -ruNp ck6pre/kernel/fork.c ck5bad/kernel/fork.c
--- ck6pre/kernel/fork.c	2003-04-11 21:51:09.000000000 -0700
+++ ck5bad/kernel/fork.c	2003-04-11 22:43:54.000000000 -0700
@@ -733,7 +733,7 @@ int do_fork(unsigned long clone_flags, u
 		current->time_slice = 1;
 		scheduler_tick(0,0);
 	}
-	p->sleep_timestamp = jiffies;
+	p->last_run = jiffies;
 	__sti();
 
 	/*
diff -ruNp ck6pre/kernel/sched.c ck5bad/kernel/sched.c
--- ck6pre/kernel/sched.c	2003-04-11 21:51:09.000000000 -0700
+++ ck5bad/kernel/sched.c	2003-04-12 04:26:04.000000000 -0700
@@ -1,5 +1,5 @@
 /*
-  *  kernel/sched.c
+ *  kernel/sched.c
  *
  *  Kernel scheduler and related syscalls
  *
@@ -48,19 +48,20 @@
   /*
  * These are the 'tuning knobs' of the scheduler:
  *
- * Minimum timeslice is 5 msecs, default timeslice is 150 msecs,
- * maximum timeslice is 200 msecs. Timeslices get refilled after
+ * Minimum timeslice is 10 msecs, default timeslice is 150 msecs,
+ * maximum timeslice is 300 msecs. Timeslices get refilled after
  * they expire.
    */
 #define MIN_TIMESLICE		((5 * HZ) / 1000 ?: 1)
 #define MAX_TIMESLICE		(200 * HZ) / 1000
-#define CHILD_PENALTY		95
+#define CHILD_PENALTY		50
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(2*HZ)
-#define STARVATION_LIMIT	(2*HZ)
+#define MAX_SLEEP_AVG		(10 * HZ)
+#define STARVATION_LIMIT	(10 * HZ)
+
 #define TIMESLICE_GRANULARITY	(HZ/20 ?: 1)
 
 /*
@@ -119,7 +120,7 @@
 #define BASE_TIMESLICE(p) \
 	(MAX_TIMESLICE * (MAX_PRIO-(p)->static_prio)/MAX_USER_PRIO)
 
-static inline unsigned int task_timeslice(task_t *p)
+static unsigned int task_timeslice(task_t *p)
 {
 	unsigned int time_slice = BASE_TIMESLICE(p);
 
@@ -157,6 +158,7 @@ struct runqueue {
 	unsigned long nr_running, nr_switches, expired_timestamp,
 			nr_uninterruptible;
 	task_t *curr, *idle;
+	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
 
@@ -199,6 +201,10 @@ static struct runqueue runqueues[NR_CPUS
 # define task_running(rq, p)           ((rq)->curr == (p))
 #endif
 
+# define nr_running_init(rq)   do { } while (0)
+# define nr_running_inc(rq)    do { (rq)->nr_running++; } while (0)
+# define nr_running_dec(rq)    do { (rq)->nr_running--; } while (0)
+
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
@@ -281,6 +287,9 @@ static inline int effective_prio(task_t 
 	 *
 	 * Both properties are important to certain workloads.
  */
+	if (rt_task(p))
+		return p->prio;
+
 	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
@@ -292,27 +301,47 @@ static inline int effective_prio(task_t 
 	return prio;
 }
 
-static inline void activate_task(task_t *p, runqueue_t *rq)
+static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	unsigned long sleep_time = jiffies - p->sleep_timestamp;
-	prio_array_t *array = rq->active;
+	enqueue_task(p, rq->active);
+	nr_running_inc(rq);
+}
 
-	if (!rt_task(p) && sleep_time) {
-	/*
-		 * This code gives a bonus to interactive tasks. We update
-		 * an 'average sleep time' value here, based on
-		 * sleep_timestamp. The more time a task spends sleeping,
-		 * the higher the average gets - and the higher the priority
-		 * boost gets as well.
-  		 */
-		p->sleep_avg += sleep_time;
-		if (p->sleep_avg > MAX_SLEEP_AVG)
-			p->sleep_avg = MAX_SLEEP_AVG;
-		p->prio = effective_prio(p);
+static inline int activate_task(task_t *p, runqueue_t *rq)
+{
+	long sleep_time = jiffies - p->last_run - 1;
+	int requeue_waker = 0;
+
+	if (!rt_task(p) && (sleep_time > 0)) {
+		int sleep_avg;
+
+		/*
+		 * This code gives a bonus to interactive tasks.
+		 *
+		 * The boost works by updating the 'average sleep time'
+		 * value here, based on ->last_run. The more time a task
+		 * spends sleeping, the higher the average gets - and the
+		 * higher the priority boost gets as well.
+		 */
+		sleep_avg = p->sleep_avg + sleep_time;
+
+		/*
+		 * 'Overflow' bonus ticks go to the waker as well, so the
+		 * ticks are not lost. This has the effect of further
+		 * boosting tasks that are related to maximum-interactive
+		 * tasks.
+		 */
+		if (sleep_avg > MAX_SLEEP_AVG)
+			sleep_avg = MAX_SLEEP_AVG;
+		if (p->sleep_avg != sleep_avg) {
+			p->sleep_avg = sleep_avg;
+			p->prio = effective_prio(p);
 		}
-	enqueue_task(p, array);
-	rq->nr_running++;
 	}
+	__activate_task(p, rq);
+
+	return requeue_waker;
+}
 
 static inline void activate_batch_task(task_t *p, runqueue_t *rq)
 {
@@ -324,7 +353,7 @@ static inline void activate_batch_task(t
 
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	rq->nr_running--;
+	nr_running_dec(rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -386,7 +415,7 @@ static inline void resched_task(task_t *
  * ptrace() code.
    */
 void wait_task_inactive(task_t * p)
-  {
+{
 	unsigned long flags;
 	runqueue_t *rq;
 
@@ -427,7 +456,7 @@ repeat:
  */
 void kick_if_running(task_t * p)
 {
-	if (task_running(task_rq(p), p) && (p->cpu != smp_processor_id()))
+	if (task_running(task_rq(p), p) && (task_cpu(p) != smp_processor_id()))
 		resched_task(p);
 	/*
 	 * If batch processes get signals but are not running currently
@@ -447,8 +476,6 @@ void kick_if_running(task_t * p)
 }
 
 /*
-
-/*
  * Wake up a process. Put it on the run-queue if it's not
  * already there.  The "current" process is always on the
  * run-queue (except when the actual re-schedule is in
@@ -458,70 +485,98 @@ void kick_if_running(task_t * p)
  *
  * returns failure only if the task is already active.
  */
-static int try_to_wake_up(task_t * p, int sync)
+
+static int try_to_wake_up(task_t * p, unsigned int state, int sync)
 {
+	int success = 0, requeue_waker = 0;
 	unsigned long flags;
-	int success = 0;
 	long old_state;
 	runqueue_t *rq;
 
 repeat_lock_task:
 	rq = task_rq_lock(p, &flags);
 	old_state = p->state;
-	if (!p->array) {
-	/*
-		 * Fast-migrate the task if it's not running or runnable
-		 * currently. Do not violate hard affinity.
-	 */
-		if (unlikely(sync && !task_running(rq, p) &&
-			(task_cpu(p) != smp_processor_id()) &&
-			(p->cpus_allowed & (1UL << smp_processor_id())))) {
-
-			set_task_cpu(p, smp_processor_id());
+	if (old_state & state) {
+		if (!p->array) {
+		/*
+			 * Fast-migrate the task if it's not running or runnable
+			 * currently. Do not violate hard affinity.
+		 */
+			if (unlikely(sync && !task_running(rq, p) &&
+				(task_cpu(p) != smp_processor_id()) &&
+				(p->cpus_allowed & (1UL << smp_processor_id())))) {
+
+				set_task_cpu(p, smp_processor_id());
+				task_rq_unlock(rq, &flags);
+				goto repeat_lock_task;
+			}
+			if (old_state == TASK_UNINTERRUPTIBLE)
+				rq->nr_uninterruptible--;
 
-			task_rq_unlock(rq, &flags);
-			goto repeat_lock_task;
+			if (sync)
+				__activate_task(p, rq);
+			else {
+				requeue_waker = activate_task(p, rq);
+				if (p->prio < rq->curr->prio || rq->curr->policy == SCHED_BATCH)
+					resched_task(rq->curr);
+			}
+			success = 1;
 		}
-		if (old_state == TASK_UNINTERRUPTIBLE)
-			rq->nr_uninterruptible--;
-		activate_task(p, rq);
-
-		if (p->prio < rq->curr->prio || rq->curr->policy == SCHED_BATCH)
-			resched_task(rq->curr);
-	success = 1;
+		p->state = TASK_RUNNING;
 	}
-	p->state = TASK_RUNNING;
 	task_rq_unlock(rq, &flags);
 
+	/*
+	 * We have to do this outside the other spinlock, the two
+	 * runqueues might be different:
+	 */
+	if (requeue_waker) {
+		prio_array_t *array;
+		rq = task_rq_lock(current, &flags);
+		array = current->array;
+		dequeue_task(current, array);
+		current->prio = effective_prio(current);
+		enqueue_task(current, array);
+		task_rq_unlock(rq, &flags);
+	}
+
 	return success;
 }
 
 int wake_up_process(task_t * p)
 {
-	return try_to_wake_up(p, 0);
+	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
 }
 
 void wake_up_forked_process(task_t * p)
 {
-	runqueue_t *rq ;
+	runqueue_t *rq;
+	unsigned long flags;
 	preempt_disable();
-	rq = this_rq_lock();
+
+	rq = task_rq_lock(current, &flags);
 
 	p->state = TASK_RUNNING;
-	if (!rt_task(p)) {
-		/*
-		 * We decrease the sleep average of forking parents
-		 * and children as well, to keep max-interactive tasks
-		 * from forking tasks that are max-interactive.
-		 */
-		current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
-		p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
-		p->prio = effective_prio(p);
-}
+	/*
+	 * We decrease the sleep average of forking parents
+	 * and children as well, to keep max-interactive tasks
+	 * from forking tasks that are max-interactive.
+	 */
+	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
+	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
+	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
-	activate_task(p, rq);
 
-	rq_unlock(rq);
+	if (unlikely(!current->array))
+		__activate_task(p, rq);
+	else {
+		p->prio = current->prio;
+		list_add_tail(&p->run_list, &current->run_list);
+		p->array = current->array;
+		p->array->nr_active++;
+		nr_running_inc(rq);
+	}
+	task_rq_unlock(rq, &flags);
 	preempt_enable();
 }
 
@@ -536,30 +591,58 @@ void wake_up_forked_process(task_t * p)
  */
 void sched_exit(task_t * p)
 {
-	__cli();
+	unsigned long flags;
+
+	local_irq_save(flags);
 	if (p->first_time_slice) {
-		current->time_slice += p->time_slice;
-		if (unlikely(current->time_slice > MAX_TIMESLICE))
-			current->time_slice = MAX_TIMESLICE;
+		p->p_pptr->time_slice += p->time_slice;
+		if (unlikely(p->p_pptr->time_slice > MAX_TIMESLICE))
+			p->p_pptr->time_slice = MAX_TIMESLICE;
 	}
-	__sti();
+	local_irq_restore(flags);
 	/*
 	 * If the child was a (relative-) CPU hog then decrease
 	 * the sleep_avg of the parent as well.
 	 */
-	if (p->sleep_avg < current->sleep_avg)
-		current->sleep_avg = (current->sleep_avg * EXIT_WEIGHT +
+	if (p->sleep_avg < p->p_pptr->sleep_avg)
+		p->p_pptr->sleep_avg = (p->p_pptr->sleep_avg * EXIT_WEIGHT +
 			p->sleep_avg) / (EXIT_WEIGHT + 1);
 }
 
+/**
+ * finish_task_switch - clean up after a task-switch
+ * @prev: the thread we just switched away from.
+ *
+ * We enter this with the runqueue still locked, and finish_arch_switch()
+ * will unlock it along with doing any other architecture-specific cleanup
+ * actions.
+ *
+ * Note that we may have delayed dropping an mm in context_switch(). If
+ * so, we finish that here outside of the runqueue lock.  (Doing it
+ * with the lock held can cause deadlocks; see schedule() for
+ * details.)
+ */
+static inline void finish_task_switch(task_t *prev)
+{
+	runqueue_t *rq = this_rq();
+	struct mm_struct *mm = rq->prev_mm;
+
+	rq->prev_mm = NULL;
+	finish_arch_switch(rq, prev);
+	if (mm)
+		mmdrop(mm);
+	if (prev->state & (TASK_ZOMBIE))
+		free_task_struct(prev);
+}
+
 #if CONFIG_SMP || CONFIG_PREEMPT
 asmlinkage void schedule_tail(task_t *prev)
 {
-	finish_arch_switch(this_rq(), prev);
+	finish_task_switch(prev);
 }
 #endif
 
-static inline task_t * context_switch(task_t *prev, task_t *next)
+static inline task_t * context_switch(runqueue_t *rq, task_t *prev, task_t *next)
 {
 	struct mm_struct *mm = next->mm;
 	struct mm_struct *oldmm = prev->active_mm;
@@ -573,7 +656,8 @@ static inline task_t * context_switch(ta
 
 	if (unlikely(!prev->mm)) {
 		prev->active_mm = NULL;
-		mmdrop(oldmm);
+		/* BUG_ON(rq->prev_mm); */
+		rq->prev_mm = oldmm;
 	}
 
 	/* Here we just switch the register state and the stack. */
@@ -833,9 +917,9 @@ static inline runqueue_t *find_busiest_q
 static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
 {
 	dequeue_task(p, src_array);
-	src_rq->nr_running--;
+	nr_running_dec(src_rq);
 	set_task_cpu(p, this_cpu);
-	this_rq->nr_running++;
+	nr_running_inc(this_rq);
 	enqueue_task(p, this_rq->active);
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
@@ -843,6 +927,11 @@ static inline void pull_task(runqueue_t 
 	 */
 	if (p->prio < this_rq->curr->prio)
 		set_need_resched();
+	else {
+		if (p->prio == this_rq->curr->prio &&
+				p->time_slice > this_rq->curr->time_slice)
+			set_need_resched();
+	}
 }
 
 	/*
@@ -905,7 +994,7 @@ skip_queue:
 	 */
 
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
+	((idle || (jiffies - (p)->last_run > cache_decay_ticks)) && \
 		!task_running(rq, p) &&					\
 			((p)->cpus_allowed & (1UL << (this_cpu))))
 
@@ -963,9 +1052,9 @@ static inline void idle_tick(runqueue_t 
  * increasing number of running tasks:
 	 */
 #define EXPIRED_STARVING(rq) \
-		((rq)->expired_timestamp && \
+		(STARVATION_LIMIT && ((rq)->expired_timestamp && \
 		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1))
+			STARVATION_LIMIT * ((rq)->nr_running) + 1 )))
 
 /*
  * This function gets called by the timer code, with HZ frequency.
@@ -1017,6 +1106,17 @@ void scheduler_tick(int user_ticks, int 
 		return;
 	}
 	spin_lock(&rq->lock);
+	/*
+	 * The task was running during this tick - update the
+	 * time slice counter and the sleep average. Note: we
+	 * do not update a process's priority until it either
+	 * goes to sleep or uses up its timeslice. This makes
+	 * it possible for interactive tasks to use up their
+	 * timeslices at their highest priority levels.
+	 */
+	if (p->sleep_avg)
+		p->sleep_avg--;
+
 	if (unlikely(rt_task(p))) {
 		/*
 		 * RR tasks need a special form of timeslice management.
@@ -1033,16 +1133,6 @@ void scheduler_tick(int user_ticks, int 
 		}
 		goto out;
 	}
-	/*
-	 * The task was running during this tick - update the
-	 * time slice counter and the sleep average. Note: we
-	 * do not update a process's priority until it either
-	 * goes to sleep or uses up its timeslice. This makes
-	 * it possible for interactive tasks to use up their
-	 * timeslices at their highest priority levels.
-	 */
-	if (p->sleep_avg)
-		p->sleep_avg--;
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
@@ -1138,7 +1228,7 @@ need_resched:
 	rq = this_rq();
 
 	release_kernel_lock(prev, smp_processor_id());
-	prev->sleep_timestamp = jiffies;
+	prev->last_run = jiffies;
 	spin_lock_irq(&rq->lock);
 
 	/*
@@ -1204,10 +1294,9 @@ switch_tasks:
 		rq->curr = next;
 
 		prepare_arch_switch(rq, next);
-		prev = context_switch(prev, next);
+		prev = context_switch(rq, prev, next);
 		barrier();
-		rq = this_rq();
-		finish_arch_switch(rq, prev);
+		finish_task_switch(prev);
 	} else
 		spin_unlock_irq(&rq->lock);
 
@@ -1261,7 +1350,7 @@ static inline void __wake_up_common(wait
 		curr = list_entry(tmp, wait_queue_t, task_list);
 		p = curr->task;
 		state = p->state;
-		if ((state & mode) && try_to_wake_up(p, sync) &&
+		if ((state & mode) && try_to_wake_up(p, state, sync) &&
 			((curr->flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive))
 				break;
 		}
@@ -1474,7 +1563,7 @@ asmlinkage long sys_nice(int increment)
  */
 int task_prio(task_t *p)
 {
-	return p->prio - MAX_USER_RT_PRIO;
+	return p->prio - MAX_RT_PRIO;
 }
 
 int task_nice(task_t *p)
@@ -1567,7 +1656,7 @@ static int setscheduler(pid_t pid, int p
 	else
 		p->prio = p->static_prio;
 	if (array)
-		activate_task(p, task_rq(p));
+		__activate_task(p, task_rq(p));
 
 out_unlock:
 	task_rq_unlock(rq, &flags);
@@ -1766,7 +1855,6 @@ void yield(void)
 {
 	set_current_state(TASK_RUNNING);
 	sys_sched_yield();
-	schedule();
 }
 
 void __cond_resched(void)
@@ -1820,14 +1908,19 @@ asmlinkage long sys_sched_rr_get_interva
 	retval = -ESRCH;
 	read_lock(&tasklist_lock);
 	p = find_process_by_pid(pid);
-	if (p)
-		jiffies_to_timespec(p->policy & SCHED_FIFO ?
-					 0 : task_timeslice(p), &t);
+	if (!p)
+		goto out_unlock;
+		
+	
+	jiffies_to_timespec(p->policy & SCHED_FIFO ?
+				 0 : task_timeslice(p), &t);
 	read_unlock(&tasklist_lock);
-	if (p)
-		retval = copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;
+	retval = copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;
 out_nounlock:
 	return retval;
+out_unlock:
+	read_unlock(&tasklist_lock);
+	return retval;
 }
 
 static void show_task(task_t * p)
@@ -1928,8 +2021,7 @@ void __init init_idle(task_t *idle, int 
 	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(task_cpu(idle));
 	unsigned long flags;
 
-	__save_flags(flags);
-	__cli();
+	local_irq_save(flags);
 	double_rq_lock(idle_rq, rq);
 
 	idle_rq->curr = idle_rq->idle = idle;
@@ -1940,10 +2032,14 @@ void __init init_idle(task_t *idle, int 
 	set_task_cpu(idle, cpu);
 	double_rq_unlock(idle_rq, rq);
 	set_tsk_need_resched(idle);
-	__restore_flags(flags);
+	local_irq_restore(flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
+#ifdef CONFIG_PREEMPT
 	idle->preempt_count = (idle->lock_depth >= 0);
+#else
+	idle->preempt_count = 0;
+#endif
 }
 
  #if LOWLATENCY_NEEDED
@@ -2252,7 +2348,7 @@ void __init sched_init(void)
 	rq->curr = current;
 	rq->idle = current;
 	set_task_cpu(current, smp_processor_id());
-	wake_up_process(current);
+	wake_up_forked_process(current);
 
 	init_timervecs();
 	init_bh(TIMER_BH, timer_bh);


-- 
Eric Wong
