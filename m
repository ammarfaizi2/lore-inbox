Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269813AbUH0BuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269813AbUH0BuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 21:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269794AbUH0Bsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 21:48:37 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:40906 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S269939AbUH0Bnb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 21:43:31 -0400
Subject: [PATCH 2/2] Fix CPU Hotplug: Handle dying tasks on dead CPU
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nathan Lynch <nathanl@austin.ibm.com>
In-Reply-To: <1093570544.17654.7.camel@bach>
References: <1093570544.17654.7.camel@bach>
Content-Type: text/plain
Message-Id: <1093570711.17652.11.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 27 Aug 2004 11:39:40 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Hotplug CPU vs TASK_ZOMBIEs: The Sequel to Hotplug CPU vs TASK_DEAD
Status: Tested on 2.6.8.1-mm4
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Depends: Hotcpu/neaten-migrate_all_tasks.patch.gz

To recap: release_task can now sleep.  Sleeping allows a CPU to go
down underneath you.  release_task removes you from the tasklist, so
you don't get migrated off the CPU: BUG() in sched.c.

In last week's episode, our dashing hero (Ingo Molnar) solved this for
self-reaping tasks by grabbing the hotplug cpu lock to prevent this.
However, in an unexpected twist, the problem remains for tasks whose
parents call release_task on them: the zombies are off the task list,
and lurk on the dead CPU.

Fortunately, the comedic sidekick (Rusty Russell) has an answer: let's
make the hotplug callback walk the runqueue of the dead CPU as well,
taking care of the zombies.

1) Restore exit.c to its former form.  The comment is incorrect:
   sched.c checks PF_DEAD, not the state, to decide to do the final
   put_task_struct(), and it does it for all tasks, self-reaping or
   no.

2) Implement migrate_dead_tasks() in the sched.c hotplug CPU callback.

3) Rename migrate_all_tasks() to migrate_live_tasks().

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29162-linux-2.6.8.1-mm4/kernel/exit.c .29162-linux-2.6.8.1-mm4.updated/kernel/exit.c
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32142-linux-2.6.8.1-mm4/kernel/exit.c .32142-linux-2.6.8.1-mm4.updated/kernel/exit.c
--- .32142-linux-2.6.8.1-mm4/kernel/exit.c	2004-08-26 13:21:45.000000000 +1000
+++ .32142-linux-2.6.8.1-mm4.updated/kernel/exit.c	2004-08-26 17:25:33.000000000 +1000
@@ -754,8 +754,8 @@ static void exit_notify(struct task_stru
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
@@ -764,14 +764,6 @@ static void exit_notify(struct task_stru
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
@@ -781,23 +773,12 @@ static void exit_notify(struct task_stru
 	}
 
 	/* If the process is dead, release it - nobody will wait for it */
-	if (state == TASK_DEAD) {
-		lock_cpu_hotplug();
+	if (state == TASK_DEAD)
 		release_task(tsk);
-		write_lock_irq(&tasklist_lock);
-		/*
-		 * No preemption may happen from this point on,
-		 * or CPU hotplug (and task exit) breaks:
-		 */
-		unlock_cpu_hotplug();
-		tsk->state = state;
-		_raw_write_unlock(&tasklist_lock);
-		local_irq_enable();
-	} else
-		preempt_disable();
 
+	/* PF_DEAD causes final put_task_struct after we schedule. */
+	preempt_disable();
 	tsk->flags |= PF_DEAD;
-	put_task_struct(tsk);
 }
 
 asmlinkage NORET_TYPE void do_exit(long code)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32142-linux-2.6.8.1-mm4/kernel/sched.c .32142-linux-2.6.8.1-mm4.updated/kernel/sched.c
--- .32142-linux-2.6.8.1-mm4/kernel/sched.c	2004-08-26 17:25:32.000000000 +1000
+++ .32142-linux-2.6.8.1-mm4.updated/kernel/sched.c	2004-08-26 17:25:54.000000000 +1000
@@ -3820,8 +3820,8 @@ static void move_task_off_dead_cpu(int d
 	__migrate_task(tsk, dead_cpu, dest_cpu);
 }
 
-/* migrate_all_tasks - function to migrate all tasks from the dead cpu. */
-static void migrate_all_tasks(int src_cpu)
+/* Run through task list and migrate tasks from the dead cpu. */
+static void migrate_live_tasks(int src_cpu)
 {
 	struct task_struct *tsk, *t;
 
@@ -3863,6 +3863,47 @@ void sched_idle_next(void)
 
 	spin_unlock_irqrestore(&rq->lock, flags);
 }
+
+static void migrate_dead(unsigned int dead_cpu, task_t *tsk)
+{
+	struct runqueue *rq = cpu_rq(dead_cpu);
+
+	/* Must be exiting, otherwise would be on tasklist. */
+	BUG_ON(tsk->state != TASK_ZOMBIE && tsk->state != TASK_DEAD);
+
+	/* Cannot have done final schedule yet: would have vanished. */
+	BUG_ON(tsk->flags & PF_DEAD);
+
+	get_task_struct(tsk);
+
+	/* 
+	 * Drop lock around migration; if someone else moves it,
+	 * that's OK.  No task can be added to this CPU, so iteration is
+	 * fine.
+	 */
+	spin_unlock_irq(&rq->lock);
+	move_task_off_dead_cpu(dead_cpu, tsk);
+	spin_lock_irq(&rq->lock);
+
+	put_task_struct(tsk);
+}
+
+/* release_task() removes task from tasklist, so we won't find dead tasks. */
+static void migrate_dead_tasks(unsigned int dead_cpu)
+{
+	unsigned arr, i;
+	struct runqueue *rq = cpu_rq(dead_cpu);
+
+	for (arr = 0; arr < 2; arr++) {
+		for (i = 0; i < MAX_PRIO; i++) {
+			struct list_head *list = &rq->arrays[arr].queue[i];
+			while (!list_empty(list))
+				migrate_dead(dead_cpu,
+					     list_entry(list->next, task_t,
+							run_list));
+		}
+	}
+}
 #endif /* CONFIG_HOTPLUG_CPU */
 
 /*
@@ -3902,7 +3943,7 @@ static int migration_call(struct notifie
 		cpu_rq(cpu)->migration_thread = NULL;
 		break;
 	case CPU_DEAD:
-		migrate_all_tasks(cpu);
+		migrate_live_tasks(cpu);
 		rq = cpu_rq(cpu);
 		kthread_stop(rq->migration_thread);
 		rq->migration_thread = NULL;
@@ -3911,6 +3952,7 @@ static int migration_call(struct notifie
 		deactivate_task(rq->idle, rq);
 		rq->idle->static_prio = MAX_PRIO;
 		__setscheduler(rq->idle, SCHED_NORMAL, 0);
+		migrate_dead_tasks(cpu);
 		task_rq_unlock(rq, &flags);
 		BUG_ON(rq->nr_running != 0);
 

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

