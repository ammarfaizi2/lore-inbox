Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSFPOqQ>; Sun, 16 Jun 2002 10:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316243AbSFPOqP>; Sun, 16 Jun 2002 10:46:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11661 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316235AbSFPOqK>;
	Sun, 16 Jun 2002 10:46:10 -0400
Date: Sun, 16 Jun 2002 16:43:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: mgix@mgix.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] Re: Question about sched_yield()
In-Reply-To: <AMEKICHCJFIFEDIBLGOBGEDPCBAA.mgix@mgix.com>
Message-ID: <Pine.LNX.4.44.0206161625240.5877-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Jun 2002 mgix@mgix.com wrote:

> I am seeing some strange linux scheduler behaviours, and I thought
> this'd be the best place to ask.
> 
> I have two processes, one that loops forever and does nothing but
> calling sched_yield(), and the other is basically benchmarking how fast
> it can compute some long math calculation.

sched_yield() is indeed misbehaving both in 2.4 and 2.5. (I think you are
using some variant of 2.4.18, does that kernel have the O(1) scheduler
patches applied?) In fact in 2.5 it's behaving slightly worse than in
vanilla 2.4.18.

the O(1)-scheduler's sched_yield() implementation does the following to
'give up' the CPU:

 - it decreases its priority by 1 until it reaches the lowest level
 - it queues the task to the end of the priority queue

this scheme works fine in most cases, but if sched_yield()-active tasks
are mixed with CPU-using processes then it's quite likely that the
CPU-using process is in the expired array. In that case the yield()-ing
process only requeues itself in the active array - a true context-switch
to the expired process will only occur once the timeslice of the
yield()-ing process has expired: in ~150 msecs. This leads to the
yield()-ing and CPU-using process to use up rougly the same amount of
CPU-time, which is arguably deficient.

i've fixed this problem by extending sched_yield() the following way:

+        * There are three levels of how a yielding task will give up
+        * the current CPU:
+        *
+        *  #1 - it decreases its priority by one. This priority loss is
+        *       temporary, it's recovered once the current timeslice
+        *       expires.
+        *
+        *  #2 - once it has reached the lowest priority level,
+        *       it will give up timeslices one by one. (We do not
+        *       want to give them up all at once, it's gradual,
+        *       to protect the casual yield()er.)
+        *
+        *  #3 - once all timeslices are gone we put the process into
+        *       the expired array.
+        *
+        *  (special rule: RT tasks do not lose any priority, they just
+        *  roundrobin on their current priority level.)
+        */

the attached patch against vanilla 2.5.21 also includes this sched_yield()  
improvement, and in my tests it now behaves well. Could you give it a go,
does it now behave for your workload as well?

	Ingo

diff -rNu linux-2.5.21-final/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.21-final/arch/i386/kernel/entry.S	Sun Jun  9 07:28:19 2002
+++ linux/arch/i386/kernel/entry.S	Sun Jun 16 16:35:52 2002
@@ -193,6 +193,7 @@
 
 ENTRY(ret_from_fork)
 #if CONFIG_SMP || CONFIG_PREEMPT
+	# NOTE: this function takes a parameter but it's unused on x86.
 	call schedule_tail
 #endif
 	GET_THREAD_INFO(%ebx)
diff -rNu linux-2.5.21-final/fs/pipe.c linux/fs/pipe.c
--- linux-2.5.21-final/fs/pipe.c	Sun Jun  9 07:26:29 2002
+++ linux/fs/pipe.c	Sun Jun 16 16:35:36 2002
@@ -119,7 +119,7 @@
 		 * writers synchronously that there is more
 		 * room.
 		 */
-		wake_up_interruptible(PIPE_WAIT(*inode));
+		wake_up_interruptible_sync(PIPE_WAIT(*inode));
  		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 		if (!PIPE_EMPTY(*inode))
 			BUG();
@@ -219,7 +219,7 @@
 			 * is going to give up this CPU, so it doesnt have
 			 * to do idle reschedules.
 			 */
-			wake_up_interruptible(PIPE_WAIT(*inode));
+			wake_up_interruptible_sync(PIPE_WAIT(*inode));
  			kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
 			PIPE_WAITING_WRITERS(*inode)++;
 			pipe_wait(inode);
diff -rNu linux-2.5.21-final/include/asm-i386/system.h linux/include/asm-i386/system.h
--- linux-2.5.21-final/include/asm-i386/system.h	Sun Jun  9 07:26:29 2002
+++ linux/include/asm-i386/system.h	Sun Jun 16 16:35:52 2002
@@ -11,9 +11,12 @@
 struct task_struct;	/* one of the stranger aspects of C forward declarations.. */
 extern void FASTCALL(__switch_to(struct task_struct *prev, struct task_struct *next));
 
-#define prepare_to_switch()	do { } while(0)
+#define prepare_arch_schedule(prev)		do { } while(0)
+#define finish_arch_schedule(prev)		do { } while(0)
+#define prepare_arch_switch(rq)			do { } while(0)
+#define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
 
-#define switch_to(prev,next) do {					\
+#define switch_to(prev,next,last) do {					\
 	asm volatile("pushl %%esi\n\t"					\
 		     "pushl %%edi\n\t"					\
 		     "pushl %%ebp\n\t"					\
diff -rNu linux-2.5.21-final/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.21-final/include/linux/sched.h	Sun Jun  9 07:27:21 2002
+++ linux/include/linux/sched.h	Sun Jun 16 16:35:36 2002
@@ -491,6 +491,7 @@
 extern unsigned long prof_shift;
 
 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
+extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
 extern void FASTCALL(sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
 				      signed long timeout));
@@ -507,6 +508,11 @@
 #define wake_up_interruptible(x)	__wake_up((x),TASK_INTERRUPTIBLE, 1)
 #define wake_up_interruptible_nr(x, nr)	__wake_up((x),TASK_INTERRUPTIBLE, nr)
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
+#ifdef CONFIG_SMP
+#define wake_up_interruptible_sync(x)   __wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
+#else
+#define wake_up_interruptible_sync(x)   __wake_up((x),TASK_INTERRUPTIBLE, 1)
+#endif
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
 
 extern int in_group_p(gid_t);
diff -rNu linux-2.5.21-final/include/linux/spinlock.h linux/include/linux/spinlock.h
--- linux-2.5.21-final/include/linux/spinlock.h	Sun Jun  9 07:30:01 2002
+++ linux/include/linux/spinlock.h	Sun Jun 16 16:35:46 2002
@@ -26,6 +26,7 @@
 #define write_lock_bh(lock)			do { local_bh_disable();         write_lock(lock); } while (0)
 
 #define spin_unlock_irqrestore(lock, flags)	do { spin_unlock(lock);  local_irq_restore(flags); } while (0)
+#define _raw_spin_unlock_irqrestore(lock, flags) do { _raw_spin_unlock(lock);  local_irq_restore(flags); } while (0)
 #define spin_unlock_irq(lock)			do { spin_unlock(lock);  local_irq_enable();       } while (0)
 #define spin_unlock_bh(lock)			do { spin_unlock(lock);  local_bh_enable();        } while (0)
 
@@ -183,6 +184,12 @@
 		preempt_schedule(); \
 } while (0)
 
+#define preempt_check_resched() \
+do { \
+	if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
+		preempt_schedule(); \
+} while (0)
+
 #define spin_lock(lock)	\
 do { \
 	preempt_disable(); \
@@ -197,6 +204,12 @@
 	preempt_enable(); \
 } while (0)
 
+#define spin_unlock_no_resched(lock) \
+do { \
+	_raw_spin_unlock(lock); \
+	preempt_enable_no_resched(); \
+} while (0)
+
 #define read_lock(lock)		({preempt_disable(); _raw_read_lock(lock);})
 #define read_unlock(lock)	({_raw_read_unlock(lock); preempt_enable();})
 #define write_lock(lock)	({preempt_disable(); _raw_write_lock(lock);})
@@ -206,20 +219,22 @@
 
 #else
 
-#define preempt_get_count()	(0)
-#define preempt_disable()	do { } while (0)
+#define preempt_get_count()		(0)
+#define preempt_disable()		do { } while (0)
 #define preempt_enable_no_resched()	do {} while(0)
-#define preempt_enable()	do { } while (0)
+#define preempt_enable()		do { } while (0)
+#define preempt_check_resched()		do { } while (0)
 
-#define spin_lock(lock)		_raw_spin_lock(lock)
-#define spin_trylock(lock)	_raw_spin_trylock(lock)
-#define spin_unlock(lock)	_raw_spin_unlock(lock)
-
-#define read_lock(lock)		_raw_read_lock(lock)
-#define read_unlock(lock)	_raw_read_unlock(lock)
-#define write_lock(lock)	_raw_write_lock(lock)
-#define write_unlock(lock)	_raw_write_unlock(lock)
-#define write_trylock(lock)	_raw_write_trylock(lock)
+#define spin_lock(lock)			_raw_spin_lock(lock)
+#define spin_trylock(lock)		_raw_spin_trylock(lock)
+#define spin_unlock(lock)		_raw_spin_unlock(lock)
+#define spin_unlock_no_resched(lock)	_raw_spin_unlock(lock)
+
+#define read_lock(lock)			_raw_read_lock(lock)
+#define read_unlock(lock)		_raw_read_unlock(lock)
+#define write_lock(lock)		_raw_write_lock(lock)
+#define write_unlock(lock)		_raw_write_unlock(lock)
+#define write_trylock(lock)		_raw_write_trylock(lock)
 #endif
 
 /* "lock on reference count zero" */
diff -rNu linux-2.5.21-final/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.5.21-final/kernel/ksyms.c	Sun Jun  9 07:26:33 2002
+++ linux/kernel/ksyms.c	Sun Jun 16 16:35:36 2002
@@ -457,6 +457,9 @@
 /* process management */
 EXPORT_SYMBOL(complete_and_exit);
 EXPORT_SYMBOL(__wake_up);
+#if CONFIG_SMP
+EXPORT_SYMBOL_GPL(__wake_up_sync); /* internal use only */
+#endif
 EXPORT_SYMBOL(wake_up_process);
 EXPORT_SYMBOL(sleep_on);
 EXPORT_SYMBOL(sleep_on_timeout);
diff -rNu linux-2.5.21-final/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.21-final/kernel/sched.c	Sun Jun  9 07:28:13 2002
+++ linux/kernel/sched.c	Sun Jun 16 16:36:00 2002
@@ -135,7 +135,6 @@
  */
 struct runqueue {
 	spinlock_t lock;
-	spinlock_t frozen;
 	unsigned long nr_running, nr_switches, expired_timestamp;
 	signed long nr_uninterruptible;
 	task_t *curr, *idle;
@@ -153,17 +152,21 @@
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
+/*
+ * task_rq_lock - lock the runqueue a given task resides on and disable
+ * interrupts.  Note the ordering: we can safely lookup the task_rq without
+ * explicitly disabling preemption.
+ */
 static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 {
 	struct runqueue *rq;
 
 repeat_lock_task:
-	preempt_disable();
+	local_irq_save(*flags);
 	rq = task_rq(p);
-	spin_lock_irqsave(&rq->lock, *flags);
+	spin_lock(&rq->lock);
 	if (unlikely(rq != task_rq(p))) {
 		spin_unlock_irqrestore(&rq->lock, *flags);
-		preempt_enable();
 		goto repeat_lock_task;
 	}
 	return rq;
@@ -172,7 +175,23 @@
 static inline void task_rq_unlock(runqueue_t *rq, unsigned long *flags)
 {
 	spin_unlock_irqrestore(&rq->lock, *flags);
-	preempt_enable();
+}
+
+/*
+ * rq_lock - lock a given runqueue and disable interrupts.
+ */
+static inline runqueue_t *rq_lock(runqueue_t *rq)
+{
+	local_irq_disable();
+	rq = this_rq();
+	spin_lock(&rq->lock);
+	return rq;
+}
+
+static inline void rq_unlock(runqueue_t *rq)
+{
+	spin_unlock(&rq->lock);
+	local_irq_enable();
 }
 
 /*
@@ -284,9 +303,15 @@
 repeat:
 	preempt_disable();
 	rq = task_rq(p);
-	while (unlikely(rq->curr == p)) {
+	if (unlikely(rq->curr == p)) {
 		cpu_relax();
-		barrier();
+		/*
+		 * enable/disable preemption just to make this
+		 * a preemption point - we are busy-waiting
+		 * anyway.
+		 */
+		preempt_enable();
+		goto repeat;
 	}
 	rq = task_rq_lock(p, &flags);
 	if (unlikely(rq->curr == p)) {
@@ -322,40 +347,50 @@
  * "current->state = TASK_RUNNING" to mark yourself runnable
  * without the overhead of this.
  */
-static int try_to_wake_up(task_t * p)
+static int try_to_wake_up(task_t * p, int sync)
 {
 	unsigned long flags;
 	int success = 0;
 	long old_state;
 	runqueue_t *rq;
 
+repeat_lock_task:
 	rq = task_rq_lock(p, &flags);
 	old_state = p->state;
-	p->state = TASK_RUNNING;
 	if (!p->array) {
+		if (unlikely(sync && (rq->curr != p))) {
+			if (p->thread_info->cpu != smp_processor_id()) {
+				p->thread_info->cpu = smp_processor_id();
+				task_rq_unlock(rq, &flags);
+				goto repeat_lock_task;
+			}
+		}
 		if (old_state == TASK_UNINTERRUPTIBLE)
 			rq->nr_uninterruptible--;
 		activate_task(p, rq);
+		/*
+		 * If sync is set, a resched_task() is a NOOP
+		 */
 		if (p->prio < rq->curr->prio)
 			resched_task(rq->curr);
 		success = 1;
 	}
+	p->state = TASK_RUNNING;
 	task_rq_unlock(rq, &flags);
+
 	return success;
 }
 
 int wake_up_process(task_t * p)
 {
-	return try_to_wake_up(p);
+	return try_to_wake_up(p, 0);
 }
 
 void wake_up_forked_process(task_t * p)
 {
 	runqueue_t *rq;
 
-	preempt_disable();
-	rq = this_rq();
-	spin_lock_irq(&rq->lock);
+	rq = rq_lock(rq);
 
 	p->state = TASK_RUNNING;
 	if (!rt_task(p)) {
@@ -371,8 +406,7 @@
 	p->thread_info->cpu = smp_processor_id();
 	activate_task(p, rq);
 
-	spin_unlock_irq(&rq->lock);
-	preempt_enable();
+	rq_unlock(rq);
 }
 
 /*
@@ -401,19 +435,18 @@
 }
 
 #if CONFIG_SMP || CONFIG_PREEMPT
-asmlinkage void schedule_tail(void)
+asmlinkage void schedule_tail(task_t *prev)
 {
-	spin_unlock_irq(&this_rq()->frozen);
+	finish_arch_switch(this_rq());
+	finish_arch_schedule(prev);
 }
 #endif
 
-static inline void context_switch(task_t *prev, task_t *next)
+static inline task_t * context_switch(task_t *prev, task_t *next)
 {
 	struct mm_struct *mm = next->mm;
 	struct mm_struct *oldmm = prev->active_mm;
 
-	prepare_to_switch();
-
 	if (unlikely(!mm)) {
 		next->active_mm = oldmm;
 		atomic_inc(&oldmm->mm_count);
@@ -427,7 +460,9 @@
 	}
 
 	/* Here we just switch the register state and the stack. */
-	switch_to(prev, next);
+	switch_to(prev, next, prev);
+
+	return prev;
 }
 
 unsigned long nr_running(void)
@@ -773,6 +808,7 @@
 	rq = this_rq();
 
 	release_kernel_lock(prev, smp_processor_id());
+	prepare_arch_schedule(prev);
 	prev->sleep_timestamp = jiffies;
 	spin_lock_irq(&rq->lock);
 
@@ -828,28 +864,20 @@
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		rq->curr = next;
-		spin_lock(&rq->frozen);
-		spin_unlock(&rq->lock);
-
-		context_switch(prev, next);
-
-		/*
-		 * The runqueue pointer might be from another CPU
-		 * if the new task was last running on a different
-		 * CPU - thus re-load it.
-		 */
-		mb();
+	
+		prepare_arch_switch(rq);
+		prev = context_switch(prev, next);
+		barrier();
 		rq = this_rq();
-		spin_unlock_irq(&rq->frozen);
-	} else {
+		finish_arch_switch(rq);
+	} else
 		spin_unlock_irq(&rq->lock);
-	}
+	finish_arch_schedule(prev);
 
 	reacquire_kernel_lock(current);
 	preempt_enable_no_resched();
 	if (test_thread_flag(TIF_NEED_RESCHED))
 		goto need_resched;
-	return;
 }
 
 #ifdef CONFIG_PREEMPT
@@ -880,7 +908,7 @@
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
-static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
+static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
 {
 	struct list_head *tmp;
 	unsigned int state;
@@ -891,7 +919,7 @@
 		curr = list_entry(tmp, wait_queue_t, task_list);
 		p = curr->task;
 		state = p->state;
-		if ((state & mode) && try_to_wake_up(p) &&
+		if ((state & mode) && try_to_wake_up(p, sync) &&
 			((curr->flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive))
 				break;
 	}
@@ -905,17 +933,36 @@
 		return;
 
 	spin_lock_irqsave(&q->lock, flags);
-	__wake_up_common(q, mode, nr_exclusive);
+	__wake_up_common(q, mode, nr_exclusive, 0);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+
+#if CONFIG_SMP
+
+void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
+{
+	unsigned long flags;
+
+	if (unlikely(!q))
+		return;
+
+	spin_lock_irqsave(&q->lock, flags);
+	if (likely(nr_exclusive))
+		__wake_up_common(q, mode, nr_exclusive, 1);
+	else
+		__wake_up_common(q, mode, nr_exclusive, 0);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
+#endif
+ 
 void complete(struct completion *x)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&x->wait.lock, flags);
 	x->done++;
-	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1);
+	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, 0);
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
@@ -1339,27 +1386,34 @@
 
 asmlinkage long sys_sched_yield(void)
 {
-	runqueue_t *rq;
-	prio_array_t *array;
-
-	preempt_disable();
-	rq = this_rq();
+	runqueue_t *rq = rq_lock(rq);
+	prio_array_t *array = current->array;
 
 	/*
-	 * Decrease the yielding task's priority by one, to avoid
-	 * livelocks. This priority loss is temporary, it's recovered
-	 * once the current timeslice expires.
+	 * There are three levels of how a yielding task will give up
+	 * the current CPU:
 	 *
-	 * If priority is already MAX_PRIO-1 then we still
-	 * roundrobin the task within the runlist.
-	 */
-	spin_lock_irq(&rq->lock);
-	array = current->array;
-	/*
-	 * If the task has reached maximum priority (or is a RT task)
-	 * then just requeue the task to the end of the runqueue:
+	 *  #1 - it decreases its priority by one. This priority loss is
+	 *       temporary, it's recovered once the current timeslice
+	 *       expires.
+	 *  #2 - once it has reached the lowest priority level,
+	 *       it will give up timeslices one by one. (We do not
+	 *       want to give them up all at once, it's gradual,
+	 *       to protect the casual yield()er.)
+	 *
+	 *  #3 - once all timeslices are gone we put the process into
+	 *       the expired array.
+	 *
+	 *  (special rule: RT tasks do not lose any priority, they just
+	 *  roundrobin on their current priority level.)
 	 */
-	if (likely(current->prio == MAX_PRIO-1 || rt_task(current))) {
+	if (likely(current->prio == MAX_PRIO-1)) {
+		if (current->time_slice <= 1) {
+			dequeue_task(current, rq->active);
+			enqueue_task(current, rq->expired);
+		} else
+			current->time_slice--;
+	} else if (unlikely(rt_task(current))) {
 		list_del(&current->run_list);
 		list_add_tail(&current->run_list, array->queue + current->prio);
 	} else {
@@ -1370,8 +1424,7 @@
 		list_add_tail(&current->run_list, array->queue + current->prio);
 		__set_bit(current->prio, array->bitmap);
 	}
-	spin_unlock(&rq->lock);
-	preempt_enable_no_resched();
+	spin_unlock_no_resched(&rq->lock);
 
 	schedule();
 
@@ -1599,7 +1652,6 @@
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
-		spin_lock_init(&rq->frozen);
 		INIT_LIST_HEAD(&rq->migration_queue);
 
 		for (j = 0; j < 2; j++) {
@@ -1687,7 +1739,15 @@
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
-
+	/*
+	 * If the task is not on a runqueue (and not running), then
+	 * it is sufficient to simply update the task's cpu field.
+	 */
+	if (!p->array && (p != rq->curr)) {
+		p->thread_info->cpu = __ffs(p->cpus_allowed);
+		task_rq_unlock(rq, &flags);
+		goto out;
+	}
 	init_MUTEX_LOCKED(&req.sem);
 	req.task = p;
 	list_add(&req.list, &rq->migration_queue);

