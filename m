Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUHTHmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUHTHmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUHTHma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:42:30 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:1463 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263117AbUHTHlf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:41:35 -0400
Subject: Re: 2.6.8.1-mm2
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Nathan Lynch <nathanl@austin.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20040819181603.700a9a0e.akpm@osdl.org>
References: <20040819014204.2d412e9b.akpm@osdl.org>
	 <1092964083.4946.7.camel@biclops.private.network>
	 <20040819181603.700a9a0e.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1092987650.28849.349.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 17:40:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 11:16, Andrew Morton wrote:
> Nathan Lynch <nathanl@austin.ibm.com> wrote:
> >
> > > +dont-sleep-after-were-out-of-task-list.patch
> > > 
> > >  CPU hotplug race fix
> > 
> > I don't mean to be a pain, but this patch does not fix the bug I
> > reported.

Nathan, can you revert that, and apply this?  This actually fixes the
might_sleep problem, and should fix at least the problem Vatsa saw.  If
it doesn't solve your problem, we need to look again.

Thanks,
Rusty.

Name: Don't Sleep After We're Out Of Task List
Status: Booted on 2.6.8.1-mm1
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

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29294-linux-2.6.8.1-mm1/include/linux/sched.h .29294-linux-2.6.8.1-mm1.updated/include/linux/sched.h
--- .29294-linux-2.6.8.1-mm1/include/linux/sched.h	2004-08-17 11:32:33.000000000 +1000
+++ .29294-linux-2.6.8.1-mm1.updated/include/linux/sched.h	2004-08-20 12:18:37.000000000 +1000
@@ -590,6 +591,8 @@ struct task_struct {
 	struct rw_semaphore pagg_sem;
 #endif
 
+	/* Delayed cleanup on death of task with uncaring parent. */
+	struct list_head death;
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29294-linux-2.6.8.1-mm1/kernel/exit.c .29294-linux-2.6.8.1-mm1.updated/kernel/exit.c
--- .29294-linux-2.6.8.1-mm1/kernel/exit.c	2004-08-17 11:32:33.000000000 +1000
+++ .29294-linux-2.6.8.1-mm1.updated/kernel/exit.c	2004-08-20 14:50:25.000000000 +1000
@@ -51,6 +51,41 @@ static void __unhash_process(struct task
 	REMOVE_LINKS(p);
 }
 
+/* Keventd handles tasks whose parent won't ever release_task them. */
+static DEFINE_PER_CPU(struct list_head, unreleased_tasks);
+static DEFINE_PER_CPU(struct work_struct, release_task_work);
+
+static void release_tasks(void *tasks)
+{
+	struct task_struct *tsk, *next;
+	LIST_HEAD(list);
+
+	write_lock_irq(&tasklist_lock);
+	list_splice_init((struct list_head *)tasks, &list);
+	write_unlock_irq(&tasklist_lock);
+
+	list_for_each_entry_safe(tsk, next, &list, death) {
+		BUG_ON(!(tsk->flags & PF_DEAD));
+		/* I don't *think* this should happen... --RR */
+		WARN_ON(tsk->state != TASK_DEAD);
+		list_del(&tsk->death);
+		release_task(tsk);
+	}
+}
+
+static __init int init_release_tasks(void)
+{
+	unsigned int i;
+
+	for_each_cpu(i) {
+		INIT_LIST_HEAD(&per_cpu(unreleased_tasks, i));
+		INIT_WORK(&per_cpu(release_task_work, i), release_tasks,
+			  &per_cpu(unreleased_tasks, i));
+	}
+	return 0;
+}
+core_initcall(init_release_tasks);
+
 void release_task(struct task_struct * p)
 {
 	int zap_leader;
@@ -656,7 +691,6 @@ static inline void forget_original_paren
  */
 static void exit_notify(struct task_struct *tsk)
 {
-	int state;
 	struct task_struct *t;
 	struct list_head ptrace_dead, *_p, *_n;
 
@@ -753,47 +787,37 @@ static void exit_notify(struct task_stru
 		do_notify_parent(tsk, SIGCHLD);
 	}
 
-	state = TASK_ZOMBIE;
-	if (tsk->exit_signal == -1 && tsk->ptrace == 0)
-		state = TASK_DEAD;
-	else
-		tsk->state = state;
-	/*
-	 * Clear these here so that update_process_times() won't try to deliver
-	 * itimer, profile or rlimit signals to this task while it is in late exit.
-	 */
-	tsk->it_virt_value = 0;
-	tsk->it_prof_value = 0;
-	tsk->rlim[RLIMIT_CPU].rlim_cur = RLIM_INFINITY;
+	tsk->flags |= PF_DEAD;
+	if (tsk->exit_signal == -1 && tsk->ptrace == 0) {
+		/* Uncaring parent: keventd will do the final release_task */
+		tsk->state = TASK_DEAD;
+		list_add(&tsk->death, &__get_cpu_var(unreleased_tasks));
+		schedule_work(&__get_cpu_var(release_task_work));
+	} else
+		tsk->state = TASK_ZOMBIE;
 
 	/*
-	 * Get a reference to it so that we can set the state
-	 * as the last step. The state-setting only matters if the
-	 * current task is releasing itself, to trigger the final
-	 * put_task_struct() in finish_task_switch(). (thread self-reap)
+	 * In the preemption case it must be impossible for the task
+	 * to get runnable again, so use "_raw_" unlock to keep
+	 * preempt_count elevated until we schedule().  Also, this
+	 * ensures that keventd won't release this task until
+	 * after we schedule().
+	 *
+	 * To avoid deadlock on SMP, interrupts must be unmasked.  If we
+	 * don't, subsequently called functions (e.g, wait_task_inactive()
+	 * via release_task()) will spin, with interrupt flags
+	 * unwittingly blocked, until the other task sleeps.  That task
+	 * may itself be waiting for smp_call_function() to answer and
+	 * complete, and with interrupts blocked that will never happen.
 	 */
-	get_task_struct(tsk);
-
-	write_unlock_irq(&tasklist_lock);
+	_raw_write_unlock(&tasklist_lock);
+	local_irq_enable();
 
 	list_for_each_safe(_p, _n, &ptrace_dead) {
 		list_del_init(_p);
 		t = list_entry(_p,struct task_struct,ptrace_list);
 		release_task(t);
 	}
-
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
-	tsk->flags |= PF_DEAD;
-	put_task_struct(tsk);
 }
 
 asmlinkage NORET_TYPE void do_exit(long code)

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

