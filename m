Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266978AbTBTUms>; Thu, 20 Feb 2003 15:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbTBTUms>; Thu, 20 Feb 2003 15:42:48 -0500
Received: from packet.digeo.com ([12.110.80.53]:35740 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266978AbTBTUmp>;
	Thu, 20 Feb 2003 15:42:45 -0500
Date: Thu, 20 Feb 2003 12:50:21 -0800
From: Andrew Morton <akpm@digeo.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: mingo@elte.hu, zwane@holomorphy.com, cw@f00f.org,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, wli@holomorphy.com
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
Message-Id: <20030220125021.03c6d39c.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302201207320.12127-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0302202057020.2262-100000@localhost.localdomain>
	<Pine.LNX.4.44.0302201207320.12127-100000@penguin.transmeta.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Feb 2003 20:52:43.0665 (UTC) FILETIME=[03DBD810:01C2D922]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
>
> wait_task_inactive()

There are two other bugs in this exact area.  I received the below from Bill
Irwin and Rick Lindsley yesterday.  Can someone take this off my hands?


Fixes two deadlocks in the scheduler exit path:

1: We're calling mmdrop() under spin_lock_irq(&rq->lock).  But mmdrop
   calls vfree(), which calls smp_call_function().  

   It is not legal to call smp_call_function() with irq's off.  Because
   another CPU may be running smp_call_function() against _this_ CPU, which
   deadlocks.

   So the patch arranges for mmdrop() to not be called under
   spin_lock_irq(&rq->lock).

2: We are leaving local interrupts disabled coming out of exit_notify(). 
   But we are about to call wait_task_inactive() which spins, waiting for
   another CPU to end a task.  If that CPU has issued smp_call_function() to
   this CPU, deadlock.

   So the patch enables interrupts again before returning from exit_notify().

   Also, exit_notify() returns with preemption disabled, so there is no
   need to perform another preempt_disable() in do_exit().


 exit.c  |   17 +++++++++++------
 sched.c |   43 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 11 deletions(-)

diff -puN kernel/exit.c~wli-mem-leak-fix kernel/exit.c
--- 25/kernel/exit.c~wli-mem-leak-fix	2003-02-20 03:10:08.000000000 -0800
+++ 25-akpm/kernel/exit.c	2003-02-20 03:10:35.000000000 -0800
@@ -674,13 +674,19 @@ static void exit_notify(struct task_stru
 
 	tsk->state = TASK_ZOMBIE;
 	/*
-	 * No need to unlock IRQs, we'll schedule() immediately
-	 * anyway. In the preemption case this also makes it
-	 * impossible for the task to get runnable again (thus
-	 * the "_raw_" unlock - to make sure we don't try to
-	 * preempt here).
+	 * In the preemption case it must be impossible for the task
+	 * to get runnable again, so use "_raw_" unlock to keep
+	 * preempt_count elevated until we schedule().
+	 *
+	 * To avoid deadlock on SMP, interrupts must be unmasked.  If we
+	 * don't, subsequently called functions (e.g, wait_task_inactive()
+	 * via release_task()) will spin, with interrupt flags
+	 * unwittingly blocked, until the other task sleeps.  That task
+	 * may itself be waiting for smp_call_function() to answer and
+	 * complete, and with interrupts blocked that will never happen.
 	 */
 	_raw_write_unlock(&tasklist_lock);
+	local_irq_enable();
 }
 
 NORET_TYPE void do_exit(long code)
@@ -727,7 +733,6 @@ NORET_TYPE void do_exit(long code)
 
 	tsk->exit_code = code;
 	exit_notify(tsk);
-	preempt_disable();
 
 	if (tsk->exit_signal == -1)
 		release_task(tsk);
diff -puN kernel/sched.c~wli-mem-leak-fix kernel/sched.c
--- 25/kernel/sched.c~wli-mem-leak-fix	2003-02-20 03:10:08.000000000 -0800
+++ 25-akpm/kernel/sched.c	2003-02-20 03:10:08.000000000 -0800
@@ -152,6 +152,7 @@ struct runqueue {
 	unsigned long nr_running, nr_switches, expired_timestamp,
 			nr_uninterruptible;
 	task_t *curr, *idle;
+	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
 #ifdef CONFIG_NUMA
@@ -388,7 +389,10 @@ static inline void resched_task(task_t *
  * wait_task_inactive - wait for a thread to unschedule.
  *
  * The caller must ensure that the task *will* unschedule sometime soon,
- * else this function might spin for a *long* time.
+ * else this function might spin for a *long* time. This function can't
+ * be called with interrupts off, or it may introduce deadlock with
+ * smp_call_function() if an IPI is sent by the same process we are
+ * waiting to become inactive.
  */
 void wait_task_inactive(task_t * p)
 {
@@ -558,10 +562,24 @@ void sched_exit(task_t * p)
 /**
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
+ *
+ * Note that we may have delayed dropping an mm in context_switch(). If
+ * so, we finish that here outside of the runqueue lock.  (Doing it
+ * with the lock held can cause deadlocks; see schedule() for
+ * details.)
+ */
+if (mm)
  */
 asmlinkage void schedule_tail(task_t *prev)
 {
-	finish_arch_switch(this_rq(), prev);
+	runqueue_t *rq = this_rq();
+	struct mm_struct *mm = rq->prev_mm;
+
+		rq->prev_mm = NULL;
+	finish_arch_switch(rq, prev);
+	if (mm)
+		mmdrop(mm);
+
 	if (current->set_child_tid)
 		put_user(current->pid, current->set_child_tid);
 }
@@ -570,7 +588,7 @@ asmlinkage void schedule_tail(task_t *pr
  * context_switch - switch to the new MM and the new
  * thread's register state.
  */
-static inline task_t * context_switch(task_t *prev, task_t *next)
+static inline task_t * context_switch(runqueue_t *rq, task_t *prev, task_t *next)
 {
 	struct mm_struct *mm = next->mm;
 	struct mm_struct *oldmm = prev->active_mm;
@@ -584,7 +602,8 @@ static inline task_t * context_switch(ta
 
 	if (unlikely(!prev->mm)) {
 		prev->active_mm = NULL;
-		mmdrop(oldmm);
+		WARN_ON(rq->prev_mm);
+		rq->prev_mm = oldmm;
 	}
 
 	/* Here we just switch the register state and the stack. */
@@ -1223,14 +1242,28 @@ switch_tasks:
 	RCU_qsctr(prev->thread_info->cpu)++;
 
 	if (likely(prev != next)) {
+		struct mm_struct *prev_mm;
 		rq->nr_switches++;
 		rq->curr = next;
 	
 		prepare_arch_switch(rq, next);
-		prev = context_switch(prev, next);
+		prev = context_switch(rq, prev, next);
 		barrier();
 		rq = this_rq();
+		prev_mm = rq->prev_mm;
+		rq->prev_mm = NULL;
+
+		/*
+		 * It's extremely improtant to drop the runqueue lock
+		 * before mmdrop(): on i386, destroy_context(), called
+		 * by mmdrop(), can potentially vfree() LDT's. This may
+		 * generate interrupts to processors spinning (with
+		 * interrupts blocked) on the runqueue lock we're holding.
+		 */
 		finish_arch_switch(rq, prev);
+
+		if (prev_mm)
+			mmdrop(prev_mm);
 	} else
 		spin_unlock_irq(&rq->lock);
 

_

