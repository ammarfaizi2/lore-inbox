Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317212AbSFKRhx>; Tue, 11 Jun 2002 13:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSFKRhw>; Tue, 11 Jun 2002 13:37:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:62367 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317212AbSFKRhr>;
	Tue, 11 Jun 2002 13:37:47 -0400
Date: Tue, 11 Jun 2002 19:35:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Robert Love <rml@tech9.net>
Cc: Mike Kravetz <kravetz@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: [patch] current scheduler bits #2, 2.5.21
In-Reply-To: <1023755255.21155.166.camel@sinai>
Message-ID: <Pine.LNX.4.44.0206111917220.14481-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Jun 2002, Robert Love wrote:

> > - The spin_unlock_irqrestore path does not have to be split up like the
> >   spin_lock path: spin_unlock() + local_irq_restore() ==
> >   spin_unlock_irqrestore() ... this is true both in task_rq_unlock() and
> >   rq_unlock() code.
> 
> I know.  The reason I split them up is to maintain consistency through
> the way we lock vs unlock and enable vs disable interrupts.  Partly for
> style, partly in case we ever decide to hook the different calls in a
> different manner.

well, i'm simply using a shorter code form, it's equivalent.

anyway, my current tree has a new type of optimization which again changes
the way task_rq_lock() and task_rq_unlock() looks like: in this specific
case we can rely on __cli() disabling preemption, we do not need to
elevate the preemption count in this case. (Some special care has to be
taken to not cause a preemption with the raw rq spinlock held, which the
patch does.)

and i found and fixed a preemption latency source in wait_task_inactive().
That function can create *very* bad latencies if the target task happens
to not go away from its CPU for many milliseconds (for whatever reason).
So we should and can check the resched bit.

the full patch is attached, against vanilla 2.5.21.

	Ingo

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.453   ->        
#	           fs/pipe.c	1.12    -> 1.13   
#	      kernel/ksyms.c	1.96    -> 1.97   
#	include/linux/sched.h	1.65    -> 1.66   
#	      kernel/sched.c	1.83    -> 1.89   
#	include/linux/spinlock.h	1.11    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/10	mingo@elte.hu	1.447.16.1
# - get rid of rq->frozen, fix context switch races.
# --------------------------------------------
# 02/06/11	mingo@elte.hu	1.447.16.2
# - put the sync wakeup feature back in, based on Mike Kravetz's patch.
# --------------------------------------------
# 02/06/11	mingo@elte.hu	1.447.16.3
# - rq-lock optimization in the preemption case, from Robert Love, plus some more cleanups.
# --------------------------------------------
# 02/06/11	mingo@elte.hu	1.455
# - set_cpus_allowed() optimization from Mike Kravetz: we can
#   set p->thread_info->cpu directly if the task is not running
#   and is not on any runqueue.
# --------------------------------------------
# 02/06/11	mingo@elte.hu	1.456
# - wait_task_inactive() preemption-latency optimization: we should
#   enable/disable preemption to not spend too much time with
#   preemption disabled. wait_task_inactive() can take quite some
#   time occasionally ...
# --------------------------------------------
# 02/06/11	mingo@elte.hu	1.457
# - squeeze a few more cycles out of the wakeup hotpath.
# --------------------------------------------
#
diff -Nru a/fs/pipe.c b/fs/pipe.c
--- a/fs/pipe.c	Tue Jun 11 19:27:46 2002
+++ b/fs/pipe.c	Tue Jun 11 19:27:46 2002
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
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Tue Jun 11 19:27:46 2002
+++ b/include/linux/sched.h	Tue Jun 11 19:27:46 2002
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
diff -Nru a/include/linux/spinlock.h b/include/linux/spinlock.h
--- a/include/linux/spinlock.h	Tue Jun 11 19:27:46 2002
+++ b/include/linux/spinlock.h	Tue Jun 11 19:27:46 2002
@@ -26,6 +26,7 @@
 #define write_lock_bh(lock)			do { local_bh_disable();         write_lock(lock); } while (0)
 
 #define spin_unlock_irqrestore(lock, flags)	do { spin_unlock(lock);  local_irq_restore(flags); } while (0)
+#define _raw_spin_unlock_irqrestore(lock, flags) do { _raw_spin_unlock(lock);  local_irq_restore(flags); } while (0)
 #define spin_unlock_irq(lock)			do { spin_unlock(lock);  local_irq_enable();       } while (0)
 #define spin_unlock_bh(lock)			do { spin_unlock(lock);  local_bh_enable();        } while (0)
 
@@ -143,6 +144,12 @@
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
@@ -157,6 +164,12 @@
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
@@ -166,20 +179,22 @@
 
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
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Tue Jun 11 19:27:46 2002
+++ b/kernel/ksyms.c	Tue Jun 11 19:27:46 2002
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
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Tue Jun 11 19:27:46 2002
+++ b/kernel/sched.c	Tue Jun 11 19:27:46 2002
@@ -135,7 +135,6 @@
  */
 struct runqueue {
 	spinlock_t lock;
-	spinlock_t frozen;
 	unsigned long nr_running, nr_switches, expired_timestamp;
 	signed long nr_uninterruptible;
 	task_t *curr, *idle;
@@ -153,17 +152,27 @@
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
+/*
+ * task_rq_lock - lock the runqueue a given task resides on and disable
+ * interrupts.  Note the ordering: we can safely lookup the task_rq without
+ * explicitly disabling preemption.
+ *
+ * WARNING: to squeeze out a few more cycles we do not disable preemption
+ * explicitly (or implicitly), we just keep interrupts disabled. This means
+ * that within task_rq_lock/unlock sections you must be careful
+ * about locking/unlocking spinlocks, since they could cause an unexpected
+ * preemption.
+ */
 static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 {
 	struct runqueue *rq;
 
 repeat_lock_task:
-	preempt_disable();
+	local_irq_save(*flags);
 	rq = task_rq(p);
-	spin_lock_irqsave(&rq->lock, *flags);
+	_raw_spin_lock(&rq->lock);
 	if (unlikely(rq != task_rq(p))) {
-		spin_unlock_irqrestore(&rq->lock, *flags);
-		preempt_enable();
+		_raw_spin_unlock_irqrestore(&rq->lock, *flags);
 		goto repeat_lock_task;
 	}
 	return rq;
@@ -171,8 +180,24 @@
 
 static inline void task_rq_unlock(runqueue_t *rq, unsigned long *flags)
 {
-	spin_unlock_irqrestore(&rq->lock, *flags);
-	preempt_enable();
+	_raw_spin_unlock_irqrestore(&rq->lock, *flags);
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
@@ -263,8 +288,15 @@
 	nrpolling |= test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
 
 	if (!need_resched && !nrpolling && (p->thread_info->cpu != smp_processor_id()))
+		/*
+		 * NOTE: smp_send_reschedule() can be called from
+		 * spinlocked sections which do not have an elevated
+		 * preemption count. So the code either has to avoid
+	 	 * spinlocks, or has to put preempt_disable() and
+		 * preempt_enable_no_resched() around the code.
+		 */
 		smp_send_reschedule(p->thread_info->cpu);
-	preempt_enable();
+	preempt_enable_no_resched();
 #else
 	set_tsk_need_resched(p);
 #endif
@@ -284,9 +316,15 @@
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
@@ -309,8 +347,10 @@
  */
 void kick_if_running(task_t * p)
 {
-	if (p == task_rq(p)->curr)
+	if (p == task_rq(p)->curr) {
 		resched_task(p);
+		preempt_check_resched();
+	}
 }
 #endif
 
@@ -322,40 +362,50 @@
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
@@ -371,8 +421,7 @@
 	p->thread_info->cpu = smp_processor_id();
 	activate_task(p, rq);
 
-	spin_unlock_irq(&rq->lock);
-	preempt_enable();
+	rq_unlock(rq);
 }
 
 /*
@@ -403,7 +452,7 @@
 #if CONFIG_SMP || CONFIG_PREEMPT
 asmlinkage void schedule_tail(void)
 {
-	spin_unlock_irq(&this_rq()->frozen);
+	spin_unlock_irq(&this_rq()->lock);
 }
 #endif
 
@@ -828,9 +877,6 @@
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		rq->curr = next;
-		spin_lock(&rq->frozen);
-		spin_unlock(&rq->lock);
-
 		context_switch(prev, next);
 
 		/*
@@ -840,10 +886,8 @@
 		 */
 		mb();
 		rq = this_rq();
-		spin_unlock_irq(&rq->frozen);
-	} else {
-		spin_unlock_irq(&rq->lock);
 	}
+	spin_unlock_irq(&rq->lock);
 
 	reacquire_kernel_lock(current);
 	preempt_enable_no_resched();
@@ -880,7 +924,7 @@
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
-static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
+static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
 {
 	struct list_head *tmp;
 	unsigned int state;
@@ -891,7 +935,7 @@
 		curr = list_entry(tmp, wait_queue_t, task_list);
 		p = curr->task;
 		state = p->state;
-		if ((state & mode) && try_to_wake_up(p) &&
+		if ((state & mode) && try_to_wake_up(p, sync) &&
 			((curr->flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive))
 				break;
 	}
@@ -905,17 +949,36 @@
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
 
@@ -1342,8 +1405,7 @@
 	runqueue_t *rq;
 	prio_array_t *array;
 
-	preempt_disable();
-	rq = this_rq();
+	rq = rq_lock(rq);
 
 	/*
 	 * Decrease the yielding task's priority by one, to avoid
@@ -1353,7 +1415,6 @@
 	 * If priority is already MAX_PRIO-1 then we still
 	 * roundrobin the task within the runlist.
 	 */
-	spin_lock_irq(&rq->lock);
 	array = current->array;
 	/*
 	 * If the task has reached maximum priority (or is a RT task)
@@ -1370,8 +1431,7 @@
 		list_add_tail(&current->run_list, array->queue + current->prio);
 		__set_bit(current->prio, array->bitmap);
 	}
-	spin_unlock(&rq->lock);
-	preempt_enable_no_resched();
+	spin_unlock_no_resched(&rq->lock);
 
 	schedule();
 
@@ -1599,7 +1659,6 @@
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
-		spin_lock_init(&rq->frozen);
 		INIT_LIST_HEAD(&rq->migration_queue);
 
 		for (j = 0; j < 2; j++) {
@@ -1687,7 +1746,15 @@
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

