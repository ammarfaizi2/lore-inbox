Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268535AbUHRBFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268535AbUHRBFl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 21:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUHRBFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 21:05:41 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:62163 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S268535AbUHRBFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 21:05:23 -0400
Subject: Re: 2.6.8.1-mm1
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, nathanl@austin.ibm.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20040817105322.6f596061.akpm@osdl.org>
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
	 <1092722342.3081.68.camel@booger> <20040817113839.GB7005@in.ibm.com>
	 <20040817105322.6f596061.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1092791073.27352.183.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 Aug 2004 11:04:36 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-18 at 03:53, Andrew Morton wrote:
> Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> >
> > I found this to be due to task leak in exit code. In release_task:
> > 
> >  	a. Task is removed from task-list (unhash_process)
> >  	b. More processing is done (like proc_pid_flush etc)
> >  	   before task finally dies.
> > 
> >  The problem is the task can get preempted between a and b.
> 
> It seems wrong that a task can be preempted so late in its lifetime.  We're
> just asking for nasty bugs by permitting that.

Indeed, but recent changes mean we need to be able to sleep
(proc_pid_flush) after we've unlinked the task.

IMHO, the best solution is to side-step the release_task-on-yourself
case which has been traditionally problematic anyway (remember the
SIGXCPU problem?) and do the release_task from finish_task_switch if the
parent isn't going to do it.  

Ingo, I don't understand this comment in exit_notify;

	/*
	 * Get a reference to it so that we can set the state
	 * as the last step. The state-setting only matters if the
	 * current task is releasing itself, to trigger the final
	 * put_task_struct() in finish_task_switch(). (thread self-reap)
	 */
	get_task_struct(tsk);

The flags, not the state, is checked in finish_task_switch: we must not
hit schedule with the PF_DEAD flag set, but the state should be OK?
I also don't see the need for get_task_struct().  Am I missing
something?

Thanks,
Rusty.

Name: Don't Sleep After We're Out Of Task List
Status: Booted on 2.6.8.1-mm1
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (authored)
Version: -mm

Ingo recently accidentally broke CPU hotplug by enabling preemption
around release_task(), which can be called on the current task if the
parent isn't interested.

The problem is, the task can be preempted and then the CPU can go
down: it's not in the task list any more, and so it won't get migrated
after the CPU goes down.  It stays on the down CPU, which triggers a
BUG_ON.

We have had previous problems with tasks releasing themselves:
oprofile has a comment about it, and we had the case of trying to
deliver SIGXCPU in the timer tick to the current task which had called
release_task().  This patch shuffles the self-reaping off to
finish_task_switch, so there's never a running task which isn't in the
task list, except idle threads.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28758-linux-2.6.8.1-mm1/include/linux/sched.h .28758-linux-2.6.8.1-mm1.updated/include/linux/sched.h
--- .28758-linux-2.6.8.1-mm1/include/linux/sched.h	2004-08-17 11:32:33.000000000 +1000
+++ .28758-linux-2.6.8.1-mm1.updated/include/linux/sched.h	2004-08-18 09:34:24.000000000 +1000
@@ -610,6 +610,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_STARTING	0x00000002	/* being created */
 #define PF_EXITING	0x00000004	/* getting shut down */
 #define PF_DEAD		0x00000008	/* Dead */
+#define PF_SELFREAP	0x00000010	/* Never a zombie, must be released */
 #define PF_FORKNOEXEC	0x00000040	/* forked but didn't exec */
 #define PF_SUPERPRIV	0x00000100	/* used super-user privileges */
 #define PF_DUMPCORE	0x00000200	/* dumped core */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28758-linux-2.6.8.1-mm1/kernel/exit.c .28758-linux-2.6.8.1-mm1.updated/kernel/exit.c
--- .28758-linux-2.6.8.1-mm1/kernel/exit.c	2004-08-17 11:32:33.000000000 +1000
+++ .28758-linux-2.6.8.1-mm1.updated/kernel/exit.c	2004-08-18 10:10:26.000000000 +1000
@@ -756,8 +756,8 @@ static void exit_notify(struct task_stru
 	state = TASK_ZOMBIE;
 	if (tsk->exit_signal == -1 && tsk->ptrace == 0)
 		state = TASK_DEAD;
-	else
-		tsk->state = state;
+	tsk->state = state;
+
 	/*
 	 * Clear these here so that update_process_times() won't try to deliver
 	 * itimer, profile or rlimit signals to this task while it is in late exit.
@@ -766,14 +766,6 @@ static void exit_notify(struct task_stru
 	tsk->it_prof_value = 0;
 	tsk->rlim[RLIMIT_CPU].rlim_cur = RLIM_INFINITY;
 
-	/*
-	 * Get a reference to it so that we can set the state
-	 * as the last step. The state-setting only matters if the
-	 * current task is releasing itself, to trigger the final
-	 * put_task_struct() in finish_task_switch(). (thread self-reap)
-	 */
-	get_task_struct(tsk);
-
 	write_unlock_irq(&tasklist_lock);
 
 	list_for_each_safe(_p, _n, &ptrace_dead) {
@@ -782,18 +774,12 @@ static void exit_notify(struct task_stru
 		release_task(t);
 	}
 
-	/* If the process is dead, release it - nobody will wait for it */
-	if (state == TASK_DEAD) {
-		release_task(tsk);
-		write_lock_irq(&tasklist_lock);
-		tsk->state = state;
-		_raw_write_unlock(&tasklist_lock);
-		local_irq_enable();
-	} else
-		preempt_disable();
-
+	preempt_disable();
+	/* PF_DEAD says drop ref after we schedule. */
 	tsk->flags |= PF_DEAD;
-	put_task_struct(tsk);
+	/* PF_SELFREAP says there's no parent to wait4() for us. */
+	if (state == TASK_DEAD)
+		tsk->flags |= PF_SELFREAP;
 }
 
 asmlinkage NORET_TYPE void do_exit(long code)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28758-linux-2.6.8.1-mm1/kernel/sched.c .28758-linux-2.6.8.1-mm1.updated/kernel/sched.c
--- .28758-linux-2.6.8.1-mm1/kernel/sched.c	2004-08-17 11:32:34.000000000 +1000
+++ .28758-linux-2.6.8.1-mm1.updated/kernel/sched.c	2004-08-18 09:35:29.000000000 +1000
@@ -1480,8 +1480,11 @@ static void finish_task_switch(task_t *p
 	finish_arch_switch(rq, prev);
 	if (mm)
 		mmdrop(mm);
-	if (unlikely(prev_task_flags & PF_DEAD))
+	if (unlikely(prev_task_flags & PF_DEAD)) {
+		if (prev_task_flags & PF_SELFREAP)
+			release_task(prev);
 		put_task_struct(prev);
+	}
 }
 
 /**


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

