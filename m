Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268886AbUHUHvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268886AbUHUHvr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 03:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268829AbUHUHvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 03:51:47 -0400
Received: from ozlabs.org ([203.10.76.45]:57481 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268888AbUHUHvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 03:51:35 -0400
Subject: Re: 2.6.8.1-mm2
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Nathan Lynch <nathanl@austin.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
In-Reply-To: <20040820081458.GA4949@elte.hu>
References: <20040819014204.2d412e9b.akpm@osdl.org>
	 <1092964083.4946.7.camel@biclops.private.network>
	 <20040819181603.700a9a0e.akpm@osdl.org> <1092987650.28849.349.camel@bach>
	 <20040820081458.GA4949@elte.hu>
Content-Type: text/plain
Message-Id: <1093074658.4883.99.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 Aug 2004 17:51:14 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 18:14, Ingo Molnar wrote:
> * Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > +	/* Delayed cleanup on death of task with uncaring parent. */
> > +	struct list_head death;
> 
> > +/* Keventd handles tasks whose parent won't ever release_task them. */
> > +static DEFINE_PER_CPU(struct list_head, unreleased_tasks);
> > +static DEFINE_PER_CPU(struct work_struct, release_task_work);
> 
> no! this removes the whole performance optimization of self-reaping and
> re-introduces the context-switches. Just measure the
> creation/destruction performance of threads. Strong NACK.

OK, that patch sucked.  But this self-reaping optimization has caused
more than one subtle bug; I am determined to get rid of it.

What do you think of this? (against 2.6.8.1-mm2)
Rusty.

Name: Don't Sleep After We're Out Of Task List
Status: Booted on 2.6.8.1-mm2
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (authored)
Version: -mm

Ingo recently accidentally broke CPU hotplug by enabling preemption
around release_task(), which can be called on the current task if the
parent isn't interested.  This is because release_task() can now
sleep.

The problem is, the task can be preempted and then the CPU can go
down: it's not in the task list any more, and so it won't get migrated
after the CPU goes down.  It stays on the down CPU, which triggers a
BUG_ON.

We have had previous problems with tasks releasing themselves:
oprofile has a comment about it, and we had the case of trying to
deliver SIGXCPU in the timer tick to the current task which had called
release_task().  I tried shuffling release_task off the
finish_arch_switch, but that can't sleep either.  I tried using rcu,
but same problem.  Finally, I just use a workqueue and a per-cpu list,
which also guarantees the task has actually finished running.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6239-linux-2.6.8.1-mm2/include/linux/sched.h .6239-linux-2.6.8.1-mm2.updated/include/linux/sched.h
--- .6239-linux-2.6.8.1-mm2/include/linux/sched.h	2004-08-20 17:33:26.000000000 +1000
+++ .6239-linux-2.6.8.1-mm2.updated/include/linux/sched.h	2004-08-21 17:12:34.000000000 +1000
@@ -615,7 +615,6 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 					/* Not implemented yet, only for 486*/
 #define PF_STARTING	0x00000002	/* being created */
 #define PF_EXITING	0x00000004	/* getting shut down */
-#define PF_DEAD		0x00000008	/* Dead */
 #define PF_SELFREAP	0x00000010	/* Never a zombie, must be released */
 #define PF_FORKNOEXEC	0x00000040	/* forked but didn't exec */
 #define PF_SUPERPRIV	0x00000100	/* used super-user privileges */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6239-linux-2.6.8.1-mm2/kernel/exit.c .6239-linux-2.6.8.1-mm2.updated/kernel/exit.c
--- .6239-linux-2.6.8.1-mm2/kernel/exit.c	2004-08-20 17:33:27.000000000 +1000
+++ .6239-linux-2.6.8.1-mm2.updated/kernel/exit.c	2004-08-21 17:10:52.000000000 +1000
@@ -646,13 +646,14 @@ static inline void forget_original_paren
 	}
 }
 
+static DEFINE_PER_CPU(struct task_struct *, last_exited_task);
+
 /*
  * Send signals to all our closest relatives so that they know
  * to properly mourn us..
  */
 static void exit_notify(struct task_struct *tsk)
 {
-	int state;
 	struct task_struct *t;
 	struct list_head ptrace_dead, *_p, *_n;
 
@@ -749,18 +750,11 @@ static void exit_notify(struct task_stru
 		do_notify_parent(tsk, SIGCHLD);
 	}
 
-	state = TASK_ZOMBIE;
-	if (tsk->exit_signal == -1 && tsk->ptrace == 0)
-		state = TASK_DEAD;
-	tsk->state = state;
-
-	/*
-	 * Clear these here so that update_process_times() won't try to deliver
-	 * itimer, profile or rlimit signals to this task while it is in late exit.
-	 */
-	tsk->it_virt_value = 0;
-	tsk->it_prof_value = 0;
-	tsk->rlim[RLIMIT_CPU].rlim_cur = RLIM_INFINITY;
+	if (tsk->exit_signal == -1 && tsk->ptrace == 0) {
+		tsk->state = TASK_DEAD;
+		tsk->flags |= PF_SELFREAP;
+	} else
+		tsk->state = TASK_ZOMBIE;
 
 	write_unlock_irq(&tasklist_lock);
 
@@ -770,12 +764,25 @@ static void exit_notify(struct task_stru
 		release_task(t);
 	}
 
+again:
 	preempt_disable();
-	/* PF_DEAD says drop ref after we schedule. */
-	tsk->flags |= PF_DEAD;
-	/* PF_SELFREAP says there's no parent to wait4() for us. */
-	if (state == TASK_DEAD)
-		tsk->flags |= PF_SELFREAP;
+
+	/* Now it's safe to do final put on last task which exited. */
+	t = __get_cpu_var(last_exited_task);
+	if (t) {
+		if (t->flags & PF_SELFREAP) {
+			/* release_task can sleep: release and retry. */
+			__get_cpu_var(last_exited_task) = NULL;
+			preempt_enable();
+			release_task(t);
+			put_task_struct(t);
+			goto again;
+		}
+		put_task_struct(t);
+	}
+
+	/* Once we've set this, we must not be preempted. */
+	__get_cpu_var(last_exited_task) = tsk;
 }
 
 asmlinkage NORET_TYPE void do_exit(long code)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6239-linux-2.6.8.1-mm2/kernel/sched.c .6239-linux-2.6.8.1-mm2.updated/kernel/sched.c
--- .6239-linux-2.6.8.1-mm2/kernel/sched.c	2004-08-20 17:33:27.000000000 +1000
+++ .6239-linux-2.6.8.1-mm2.updated/kernel/sched.c	2004-08-21 17:01:31.000000000 +1000
@@ -1467,30 +1467,12 @@ static void finish_task_switch(task_t *p
 {
 	runqueue_t *rq = this_rq();
 	struct mm_struct *mm = rq->prev_mm;
-	unsigned long prev_task_flags;
 
 	rq->prev_mm = NULL;
 
-	/*
-	 * A task struct has one reference for the use as "current".
-	 * If a task dies, then it sets TASK_ZOMBIE in tsk->state and calls
-	 * schedule one last time. The schedule call will never return,
-	 * and the scheduled task must drop that reference.
-	 * The test for TASK_ZOMBIE must occur while the runqueue locks are
-	 * still held, otherwise prev could be scheduled on another cpu, die
-	 * there before we look at prev->state, and then the reference would
-	 * be dropped twice.
-	 *		Manfred Spraul <manfred@colorfullife.com>
-	 */
-	prev_task_flags = prev->flags;
 	finish_arch_switch(rq, prev);
 	if (mm)
 		mmdrop(mm);
-	if (unlikely(prev_task_flags & PF_DEAD)) {
-		if (prev_task_flags & PF_SELFREAP)
-			release_task(prev);
-		put_task_struct(prev);
-	}
 }
 
 /**

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

