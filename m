Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316484AbSFJWhz>; Mon, 10 Jun 2002 18:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316489AbSFJWhz>; Mon, 10 Jun 2002 18:37:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:42690 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316484AbSFJWhv>;
	Mon, 10 Jun 2002 18:37:51 -0400
Date: Tue, 11 Jun 2002 00:35:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Bug (set_cpus_allowed)
In-Reply-To: <20020610135734.D1565@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0206102257100.369-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Jun 2002, Mike Kravetz wrote:

> Ingo, I saw your patch to remove the frozen lock from the scheduler and
> agree this is the best way to go.  Once this change is made, I think it
> is then safe to add a fast path for migration (to set_cpus_allowed) as:
> 
> 	/*
> 	 * If the task is not on a runqueue (and not running), then
> 	 * it is sufficient to simply update the task's cpu field.
> 	 */
> 	if (!p->array && (p != rq->curr)) {
> 		p->thread_info->cpu = __ffs(p->cpus_allowed);
> 		task_rq_unlock(rq, &flags);
> 		goto out;
> 	}

yes, if the task is absolutely not running and not even in any runqueue
then indeed we can do this - the scheduler doesnt even know that this task
exists.

The test for 'is this task running or runnable' is interesting. The
!p->array condition covers 99.9% of the cases. But the (p != rq->curr)  
test is needed to shield against the following rare path: freshly
deactivated tasks that call into load_balance() might unlock the current
runqueue to aquire runqueue locks in order. We could get rid of the (p !=
rq->curr) test if we deactivated tasks *after* calling load_balance(), but
this is problematic because load_balance() needs to know whether the
current task is going to stay runnable or not.

> Would you agree that this is now safe?  My concern is not so much with
> the performance of set_cpus_allowed, but rather in using the same
> concept to 'move' tasks in this state.

this code should be safe, we safely lock the 'potential' runqueue of the
task first, via task_rq_lock(), then we set p->thread_info->cpu to a
different CPU. The only requirement i can see is that this setting of
p->thread_info->cpu must be SMP-atomic - which it currently is.

> Consider the '__wake_up_sync' functionality that existed in the old
> scheduler for pipes.  One result of __wake_up_sync is that the reader
> and writer of the pipe were scheduled on the same CPU.  This seemed to
> help with pipe bandwidth.  Perhaps we could add code something like the
> above to wakeup a task on a specific CPU.  This could be used in VERY
> VERY specific cases (such as blocking reader/writer on pipe) to increase
> performance.

agreed. I removed the _sync code mainly because there was no
idle_resched() to migrate a task actively, and the migration bits i tried
were incomplete. But with your above conditional it should cover all the
practical cases we care about, in an elegant way.

i ported your sync wakeup resurrection patch to 2.5.21 (attached). I did
some modifications:

- wake_up() needs to check (rq->curr != p) as well, not only !p->array.

- make __wake_up_sync dependent on CONFIG_SMP

- export __wake_up_sync().

(the attached patch includes both the ->frozen change plus the sync wakeup
resurrection, it's against vanilla 2.5.21.)

appears to work for me just fine (compiles, boots and works under SMP & UP
alike), and does the trick for bw_pipe and lat_pipe. Comments?

	Ingo

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.493   ->        
#	           fs/pipe.c	1.12    -> 1.13   
#	      kernel/ksyms.c	1.96    -> 1.97   
#	include/linux/sched.h	1.65    -> 1.66   
#	      kernel/sched.c	1.83    -> 1.85   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/10	mingo@elte.hu	1.494
# - get rid of rq->frozen, fix context switch races.
# --------------------------------------------
# 02/06/11	mingo@elte.hu	1.495
# - put the sync wakeup feature back in, based on Mike Kravetz's patch.
# --------------------------------------------
#
diff -Nru a/fs/pipe.c b/fs/pipe.c
--- a/fs/pipe.c	Tue Jun 11 00:34:25 2002
+++ b/fs/pipe.c	Tue Jun 11 00:34:25 2002
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
--- a/include/linux/sched.h	Tue Jun 11 00:34:25 2002
+++ b/include/linux/sched.h	Tue Jun 11 00:34:25 2002
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
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Tue Jun 11 00:34:25 2002
+++ b/kernel/ksyms.c	Tue Jun 11 00:34:25 2002
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
--- a/kernel/sched.c	Tue Jun 11 00:34:25 2002
+++ b/kernel/sched.c	Tue Jun 11 00:34:25 2002
@@ -135,7 +135,6 @@
  */
 struct runqueue {
 	spinlock_t lock;
-	spinlock_t frozen;
 	unsigned long nr_running, nr_switches, expired_timestamp;
 	signed long nr_uninterruptible;
 	task_t *curr, *idle;
@@ -322,31 +321,43 @@
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
@@ -403,7 +414,7 @@
 #if CONFIG_SMP || CONFIG_PREEMPT
 asmlinkage void schedule_tail(void)
 {
-	spin_unlock_irq(&this_rq()->frozen);
+	spin_unlock_irq(&this_rq()->lock);
 }
 #endif
 
@@ -828,9 +839,6 @@
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		rq->curr = next;
-		spin_lock(&rq->frozen);
-		spin_unlock(&rq->lock);
-
 		context_switch(prev, next);
 
 		/*
@@ -840,10 +848,8 @@
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
@@ -880,7 +886,7 @@
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
-static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
+static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
 {
 	struct list_head *tmp;
 	unsigned int state;
@@ -891,7 +897,7 @@
 		curr = list_entry(tmp, wait_queue_t, task_list);
 		p = curr->task;
 		state = p->state;
-		if ((state & mode) && try_to_wake_up(p) &&
+		if ((state & mode) && try_to_wake_up(p, sync) &&
 			((curr->flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive))
 				break;
 	}
@@ -905,17 +911,36 @@
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
 
@@ -1599,7 +1624,6 @@
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
-		spin_lock_init(&rq->frozen);
 		INIT_LIST_HEAD(&rq->migration_queue);
 
 		for (j = 0; j < 2; j++) {

