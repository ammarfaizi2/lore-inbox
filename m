Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317841AbSFMV0t>; Thu, 13 Jun 2002 17:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317839AbSFMV0s>; Thu, 13 Jun 2002 17:26:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57582 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317836AbSFMV0m>; Thu, 13 Jun 2002 17:26:42 -0400
Subject: [PATCH] Re: current scheduler bits #3, 2.5.21
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206112028430.17460-100000@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jun 2002 14:26:34 -0700
Message-Id: <1024003595.4799.102.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-11 at 11:33, Ingo Molnar wrote:

> + * WARNING: to squeeze out a few more cycles we do not disable preemption
> + * explicitly (or implicitly), we just keep interrupts disabled. This means
> + * that within task_rq_lock/unlock sections you must be careful
> + * about locking/unlocking spinlocks, since they could cause an unexpected
> + * preemption.

This is not working for me.  I am getting intermittent hard locks -
seems we are taking a hard fall with interrupts off.  Smelt like the
preemption optimization, so I removed it and all is well...

...which is fine, because I do not entirely trust this and it is really
not worth it to save just an inc and a dec.

Attached is your #3 patch with that one change reverted.  The rest of
the changes are in tact.  It is running here very nicely...

Unless you have a solution - and really think this is worth it - I would
like to pull this change out.

	Robert Love

diff -urN linux-2.5.21/fs/pipe.c linux/fs/pipe.c
--- linux-2.5.21/fs/pipe.c	Sat Jun  8 22:26:29 2002
+++ linux/fs/pipe.c	Thu Jun 13 14:10:48 2002
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
diff -urN linux-2.5.21/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.21/include/linux/sched.h	Sat Jun  8 22:27:21 2002
+++ linux/include/linux/sched.h	Thu Jun 13 14:10:48 2002
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
diff -urN linux-2.5.21/include/linux/spinlock.h linux/include/linux/spinlock.h
--- linux-2.5.21/include/linux/spinlock.h	Sat Jun  8 22:30:01 2002
+++ linux/include/linux/spinlock.h	Thu Jun 13 14:11:43 2002
@@ -197,6 +197,12 @@
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
@@ -206,20 +212,21 @@
 
 #else
 
-#define preempt_get_count()	(0)
-#define preempt_disable()	do { } while (0)
-#define preempt_enable_no_resched()	do {} while(0)
-#define preempt_enable()	do { } while (0)
-
-#define spin_lock(lock)		_raw_spin_lock(lock)
-#define spin_trylock(lock)	_raw_spin_trylock(lock)
-#define spin_unlock(lock)	_raw_spin_unlock(lock)
-
-#define read_lock(lock)		_raw_read_lock(lock)
-#define read_unlock(lock)	_raw_read_unlock(lock)
-#define write_lock(lock)	_raw_write_lock(lock)
-#define write_unlock(lock)	_raw_write_unlock(lock)
-#define write_trylock(lock)	_raw_write_trylock(lock)
+#define preempt_get_count()		(0)
+#define preempt_disable()		do {} while (0)
+#define preempt_enable_no_resched()	do {} while (0)
+#define preempt_enable()		do {} while (0)
+
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
diff -urN linux-2.5.21/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.5.21/kernel/ksyms.c	Sat Jun  8 22:26:33 2002
+++ linux/kernel/ksyms.c	Thu Jun 13 14:10:48 2002
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
diff -urN linux-2.5.21/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.21/kernel/sched.c	Sat Jun  8 22:28:13 2002
+++ linux/kernel/sched.c	Thu Jun 13 14:10:48 2002
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
@@ -403,7 +437,7 @@
 #if CONFIG_SMP || CONFIG_PREEMPT
 asmlinkage void schedule_tail(void)
 {
-	spin_unlock_irq(&this_rq()->frozen);
+	spin_unlock_irq(&this_rq()->lock);
 }
 #endif
 
@@ -828,9 +862,6 @@
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		rq->curr = next;
-		spin_lock(&rq->frozen);
-		spin_unlock(&rq->lock);
-
 		context_switch(prev, next);
 
 		/*
@@ -840,10 +871,8 @@
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
@@ -880,7 +909,7 @@
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
-static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
+static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
 {
 	struct list_head *tmp;
 	unsigned int state;
@@ -891,7 +920,7 @@
 		curr = list_entry(tmp, wait_queue_t, task_list);
 		p = curr->task;
 		state = p->state;
-		if ((state & mode) && try_to_wake_up(p) &&
+		if ((state & mode) && try_to_wake_up(p, sync) &&
 			((curr->flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive))
 				break;
 	}
@@ -905,17 +934,36 @@
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
 
@@ -1342,8 +1390,7 @@
 	runqueue_t *rq;
 	prio_array_t *array;
 
-	preempt_disable();
-	rq = this_rq();
+	rq = rq_lock(rq);
 
 	/*
 	 * Decrease the yielding task's priority by one, to avoid
@@ -1353,7 +1400,6 @@
 	 * If priority is already MAX_PRIO-1 then we still
 	 * roundrobin the task within the runlist.
 	 */
-	spin_lock_irq(&rq->lock);
 	array = current->array;
 	/*
 	 * If the task has reached maximum priority (or is a RT task)
@@ -1370,8 +1416,7 @@
 		list_add_tail(&current->run_list, array->queue + current->prio);
 		__set_bit(current->prio, array->bitmap);
 	}
-	spin_unlock(&rq->lock);
-	preempt_enable_no_resched();
+	spin_unlock_no_resched(&rq->lock);
 
 	schedule();
 
@@ -1599,7 +1644,6 @@
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
-		spin_lock_init(&rq->frozen);
 		INIT_LIST_HEAD(&rq->migration_queue);
 
 		for (j = 0; j < 2; j++) {
@@ -1687,7 +1731,15 @@
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




