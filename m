Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316572AbSFKAHm>; Mon, 10 Jun 2002 20:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSFKAHl>; Mon, 10 Jun 2002 20:07:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:19123 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316572AbSFKAHf>;
	Mon, 10 Jun 2002 20:07:35 -0400
Date: Tue, 11 Jun 2002 02:05:22 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Robert Love <rml@tech9.net>
Cc: Mike Kravetz <kravetz@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: [patch] current scheduler bits, 2.5.21
In-Reply-To: <1023751686.21176.124.camel@sinai>
Message-ID: <Pine.LNX.4.44.0206110134130.5377-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Jun 2002, Robert Love wrote:

> > sure, agreed. I've added it to my tree.
> 
> What do you think of this?
> 
> No more explicit preempt disables...

Thanks. I've applied your patch with the following additional
improvements:

- The spin_unlock_irqrestore path does not have to be split up like the
  spin_lock path: spin_unlock() + local_irq_restore() ==
  spin_unlock_irqrestore() ... this is true both in task_rq_unlock() and
  rq_unlock() code.

- in sys_sched_yield() you removed an optimization: the final spin_unlock
  does not have to check for resched explicitly, we'll call into
  schedule() anyway. I've introduced a new spin_unlock variant:
  spin_unlock_no_resched(), which uses preempt_enable_no_resched().

otherwise it's looking good. The attached patch is my current tree which
includes the rq-lock/unlock optimization plus the previous patches
(race-fix and sync-wakeup), against 2.5.21-vanilla.

	Ingo

diff -Nru a/fs/pipe.c b/fs/pipe.c
--- a/fs/pipe.c	Tue Jun 11 02:02:56 2002
+++ b/fs/pipe.c	Tue Jun 11 02:02:56 2002
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
--- a/include/linux/sched.h	Tue Jun 11 02:02:56 2002
+++ b/include/linux/sched.h	Tue Jun 11 02:02:56 2002
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
--- a/include/linux/spinlock.h	Tue Jun 11 02:02:56 2002
+++ b/include/linux/spinlock.h	Tue Jun 11 02:02:56 2002
@@ -157,6 +157,12 @@
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
@@ -166,20 +172,21 @@
 
 #else
 
-#define preempt_get_count()	(0)
-#define preempt_disable()	do { } while (0)
+#define preempt_get_count()		(0)
+#define preempt_disable()		do { } while (0)
 #define preempt_enable_no_resched()	do {} while(0)
-#define preempt_enable()	do { } while (0)
+#define preempt_enable()		do { } while (0)
 
-#define spin_lock(lock)		_raw_spin_lock(lock)
-#define spin_trylock(lock)	_raw_spin_trylock(lock)
-#define spin_unlock(lock)	_raw_spin_unlock(lock)
+#define spin_lock(lock)			_raw_spin_lock(lock)
+#define spin_trylock(lock)		_raw_spin_trylock(lock)
+#define spin_unlock(lock)		_raw_spin_unlock(lock)
+#define spin_unlock_no_resched(lock)	_raw_spin_unlock(lock)
 
-#define read_lock(lock)		_raw_read_lock(lock)
-#define read_unlock(lock)	_raw_read_unlock(lock)
-#define write_lock(lock)	_raw_write_lock(lock)
-#define write_unlock(lock)	_raw_write_unlock(lock)
-#define write_trylock(lock)	_raw_write_trylock(lock)
+#define read_lock(lock)			_raw_read_lock(lock)
+#define read_unlock(lock)		_raw_read_unlock(lock)
+#define write_lock(lock)		_raw_write_lock(lock)
+#define write_unlock(lock)		_raw_write_unlock(lock)
+#define write_trylock(lock)		_raw_write_trylock(lock)
 #endif
 
 /* "lock on reference count zero" */
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Tue Jun 11 02:02:56 2002
+++ b/kernel/ksyms.c	Tue Jun 11 02:02:56 2002
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
--- a/kernel/sched.c	Tue Jun 11 02:02:56 2002
+++ b/kernel/sched.c	Tue Jun 11 02:02:56 2002
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
@@ -322,40 +341,50 @@
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
@@ -371,8 +400,7 @@
 	p->thread_info->cpu = smp_processor_id();
 	activate_task(p, rq);
 
-	spin_unlock_irq(&rq->lock);
-	preempt_enable();
+	rq_unlock(rq);
 }
 
 /*
@@ -403,7 +431,7 @@
 #if CONFIG_SMP || CONFIG_PREEMPT
 asmlinkage void schedule_tail(void)
 {
-	spin_unlock_irq(&this_rq()->frozen);
+	spin_unlock_irq(&this_rq()->lock);
 }
 #endif
 
@@ -828,9 +856,6 @@
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		rq->curr = next;
-		spin_lock(&rq->frozen);
-		spin_unlock(&rq->lock);
-
 		context_switch(prev, next);
 
 		/*
@@ -840,10 +865,8 @@
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
@@ -880,7 +903,7 @@
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
-static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
+static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
 {
 	struct list_head *tmp;
 	unsigned int state;
@@ -891,7 +914,7 @@
 		curr = list_entry(tmp, wait_queue_t, task_list);
 		p = curr->task;
 		state = p->state;
-		if ((state & mode) && try_to_wake_up(p) &&
+		if ((state & mode) && try_to_wake_up(p, sync) &&
 			((curr->flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive))
 				break;
 	}
@@ -905,17 +928,36 @@
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
 
@@ -1342,8 +1384,7 @@
 	runqueue_t *rq;
 	prio_array_t *array;
 
-	preempt_disable();
-	rq = this_rq();
+	rq = rq_lock(rq);
 
 	/*
 	 * Decrease the yielding task's priority by one, to avoid
@@ -1353,7 +1394,6 @@
 	 * If priority is already MAX_PRIO-1 then we still
 	 * roundrobin the task within the runlist.
 	 */
-	spin_lock_irq(&rq->lock);
 	array = current->array;
 	/*
 	 * If the task has reached maximum priority (or is a RT task)
@@ -1370,8 +1410,7 @@
 		list_add_tail(&current->run_list, array->queue + current->prio);
 		__set_bit(current->prio, array->bitmap);
 	}
-	spin_unlock(&rq->lock);
-	preempt_enable_no_resched();
+	spin_unlock_no_resched(&rq->lock);
 
 	schedule();
 
@@ -1599,7 +1638,6 @@
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
-		spin_lock_init(&rq->frozen);
 		INIT_LIST_HEAD(&rq->migration_queue);
 
 		for (j = 0; j < 2; j++) {

