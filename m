Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbUDLQIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 12:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbUDLQIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 12:08:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:1665 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262930AbUDLQIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 12:08:11 -0400
Date: Mon, 12 Apr 2004 21:38:39 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LHCS list <lhcs-devel@lists.sourceforge.net>
Subject: Re: [lhcs-devel] Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to CPU_DEAD handling
Message-ID: <20040412160838.GA8481@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040405121824.GA8497@in.ibm.com> <4071F9C5.2030002@yahoo.com.au> <20040406083713.GB7362@in.ibm.com> <407277AE.2050403@yahoo.com.au> <1081310073.5922.86.camel@bach> <20040407050111.GA10256@in.ibm.com> <1081315931.5922.151.camel@bach> <20040407141721.GA12876@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407141721.GA12876@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 07:47:21PM +0530, Srivatsa Vaddagiri wrote:
> I would like to run my stress tests for longer time before I send it
> for inclusion 

I had kept my stress tests running over the weekend and here's an
updated patch. Changes since last time:

	- Register scheduler's callback at highest priority.
	  Task migration needs to happen before anything else.
	  (I have also been running with timer/softirq callbacks
	  at lowest prio of -10).

	- Do write_lock_irq on tasklist_lock (migrate_all_tasks) instead of 
	  just write_lock. Protection against any code (signal handling?) that 
	  can attempt to take a read lock in interrupt context.

	- In preempption case, there is a narrow window where check_all_tasks
	  will warn of a task still bound to dead cpu. That task happens
	  to be a newly created child. copy_process created the new task 
	  structure for the child and initialized it, but before it could be 
	  added in the task list it got preempted. migrate_all_tasks won't 
	  find it. However check_all_tasks _can_ find it and warn if the 
	  parent has not done wake_up_forked_process yet on the child. This
	  is a false warning and hence added some logic not to warn
	  in this special case (although I don't think the logic is 100% 
	  correct - comments to fix this wellcome!)

	- Analyzing the above lead to another task "leak", where a task
	  can be woken up on a dead CPU. If CLONE_STOPPED is set, then do_fork 
	  won't wake up the child. It will leave it in a stopped state. In such
	  a case, the newly created task can be affine to dead CPU and 
	  migrate_all_tasks may not migrate it (since it didn't find it in the
	  task table - see copy_process preemption race explained above). 
	  When the stopped task is continued later, it can be added to 
	  dead cpu's runqueue (?). Fixed this special case in do_fork.
	
	  Note: I think the above task leak would have been true in the old
	  scenario as well where migrate_all_tasks was run with rest of m/c 
	  frozen.

Patch against both 2.6.5-mm4 and 2.6.5-ames follows. Rusty, pls consider for
inclusion.

Name 	: Defer migrate_all_tasks to CPU_DEAD handling
Author 	: Srivatsa Vaddagiri (vatsa@in.ibm.com)
Status 	: Tested on 2.6.5-mm4 on a 4-way Pentium box



---

 linux-2.6.5-mm4-vatsa/include/linux/sched.h |    3 
 linux-2.6.5-mm4-vatsa/kernel/cpu.c          |   29 +++++---
 linux-2.6.5-mm4-vatsa/kernel/fork.c         |    6 +
 linux-2.6.5-mm4-vatsa/kernel/sched.c        |   94 +++++++++++++++++++---------
 4 files changed, 92 insertions(+), 40 deletions(-)

diff -puN include/linux/sched.h~migrate_all_tasks_in_CPU_DEAD include/linux/sched.h
--- linux-2.6.5-mm4/include/linux/sched.h~migrate_all_tasks_in_CPU_DEAD	2004-04-12 16:09:29.000000000 +0530
+++ linux-2.6.5-mm4-vatsa/include/linux/sched.h	2004-04-12 15:51:22.000000000 +0530
@@ -668,8 +668,7 @@ extern void sched_balance_exec(void);
 #define sched_balance_exec()   {}
 #endif
 
-/* Move tasks off this (offline) CPU onto another. */
-extern void migrate_all_tasks(void);
+extern void sched_idle_next(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -puN kernel/sched.c~migrate_all_tasks_in_CPU_DEAD kernel/sched.c
--- linux-2.6.5-mm4/kernel/sched.c~migrate_all_tasks_in_CPU_DEAD	2004-04-12 14:17:16.000000000 +0530
+++ linux-2.6.5-mm4-vatsa/kernel/sched.c	2004-04-12 16:33:29.000000000 +0530
@@ -386,6 +386,15 @@ static inline void __activate_task(task_
 	rq->nr_running++;
 }
 
+/*
+ * __activate_idle_task - move idle task to the _front_ of runqueue.
+ */
+static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
+{
+	enqueue_task_head(p, rq->active);
+	rq->nr_running++;
+}
+
 static void recalc_task_prio(task_t *p, unsigned long long now)
 {
 	unsigned long long __sleep_time = now - p->timestamp;
@@ -749,7 +758,7 @@ static int try_to_wake_up(task_t * p, un
 	this_cpu = smp_processor_id();
 
 #ifdef CONFIG_SMP
-	if (unlikely(task_running(rq, p) || cpu_is_offline(this_cpu)))
+	if (unlikely(task_running(rq, p)))
 		goto out_activate;
 
 	new_cpu = cpu;
@@ -1682,9 +1691,6 @@ static inline void idle_balance(int this
 {
 	struct sched_domain *sd;
 
-	if (unlikely(cpu_is_offline(this_cpu)))
-		return;
-
 	for_each_domain(this_cpu, sd) {
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
 			if (load_balance_newidle(this_cpu, this_rq, sd)) {
@@ -1772,9 +1778,6 @@ static void rebalance_tick(int this_cpu,
 	unsigned long j = jiffies + CPU_OFFSET(this_cpu);
 	struct sched_domain *sd;
 
-	if (unlikely(cpu_is_offline(this_cpu)))
-		return;
-
 	/* Update our load */
 	old_load = this_rq->cpu_load;
 	this_load = this_rq->nr_running * SCHED_LOAD_SCALE;
@@ -3223,15 +3226,16 @@ EXPORT_SYMBOL_GPL(set_cpus_allowed);
  * So we race with normal scheduler movements, but that's OK, as long
  * as the task is no longer on this CPU.
  */
-static void __migrate_task(struct task_struct *p, int dest_cpu)
+static void __migrate_task(struct task_struct *p, int src_cpu, int dest_cpu)
 {
-	runqueue_t *rq_dest;
+	runqueue_t *rq_dest, *rq_src;
 
+	rq_src  = cpu_rq(src_cpu);
 	rq_dest = cpu_rq(dest_cpu);
 
-	double_rq_lock(this_rq(), rq_dest);
+	double_rq_lock(rq_src, rq_dest);
 	/* Already moved. */
-	if (task_cpu(p) != smp_processor_id())
+	if (task_cpu(p) != src_cpu)
 		goto out;
 	/* Affinity changed (again). */
 	if (!cpu_isset(dest_cpu, p->cpus_allowed))
@@ -3239,7 +3243,7 @@ static void __migrate_task(struct task_s
 
 	set_task_cpu(p, dest_cpu);
 	if (p->array) {
-		deactivate_task(p, this_rq());
+		deactivate_task(p, rq_src);
 		activate_task(p, rq_dest);
 		if (TASK_PREEMPTS_CURR(p, rq_dest))
 			resched_task(rq_dest->curr);
@@ -3247,7 +3251,7 @@ static void __migrate_task(struct task_s
 	p->timestamp = rq_dest->timestamp_last_tick;
 
 out:
-	double_rq_unlock(this_rq(), rq_dest);
+	double_rq_unlock(rq_src, rq_dest);
 }
 
 /*
@@ -3290,7 +3294,7 @@ static int migration_thread(void * data)
 		spin_unlock(&rq->lock);
 
 		if (req->type == REQ_MOVE_TASK) {
-			__migrate_task(req->task, req->dest_cpu);
+			__migrate_task(req->task, smp_processor_id(), req->dest_cpu);
 		} else if (req->type == REQ_SET_DOMAIN) {
 			rq->sd = req->sd;
 		} else {
@@ -3305,20 +3309,14 @@ static int migration_thread(void * data)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-/* migrate_all_tasks - function to migrate all the tasks from the
- * current cpu caller must have already scheduled this to the target
- * cpu via set_cpus_allowed.  Machine is stopped.  */
-void migrate_all_tasks(void)
+/* migrate_all_tasks - function to migrate all tasks from the dead cpu.  */
+static void migrate_all_tasks(int src_cpu)
 {
 	struct task_struct *tsk, *t;
-	int dest_cpu, src_cpu;
+	int dest_cpu;
 	unsigned int node;
 
-	/* We're nailed to this CPU. */
-	src_cpu = smp_processor_id();
-
-	/* Not required, but here for neatness. */
-	write_lock(&tasklist_lock);
+	write_lock_irq(&tasklist_lock);
 
 	/* watch out for per node tasks, let's stay on this node */
 	node = cpu_to_node(src_cpu);
@@ -3354,10 +3352,36 @@ void migrate_all_tasks(void)
 				       tsk->pid, tsk->comm, src_cpu);
 		}
 
-		__migrate_task(tsk, dest_cpu);
+		__migrate_task(tsk, src_cpu, dest_cpu);
 	} while_each_thread(t, tsk);
 
-	write_unlock(&tasklist_lock);
+	write_unlock_irq(&tasklist_lock);
+}
+
+/* Schedules idle task to be the next runnable task on current CPU.
+ * It does so by boosting its priority to highest possible and adding it to
+ * the _front_ of runqueue. Used by CPU offline code.
+ */
+void sched_idle_next(void)
+{
+	int cpu = smp_processor_id();
+	runqueue_t *rq = this_rq();
+	struct task_struct *p = rq->idle;
+	unsigned long flags;
+
+	/* cpu has to be offline */
+	BUG_ON(cpu_online(cpu));
+
+	/* Strictly not necessary since rest of the CPUs are stopped by now
+	 * and interrupts disabled on current cpu.
+	 */
+	spin_lock_irqsave(&rq->lock, flags);
+
+	__setscheduler(p, SCHED_FIFO, MAX_RT_PRIO-1);
+	/* Add idle task to _front_ of it's priority queue */
+	__activate_idle_task(p, rq);
+
+	spin_unlock_irqrestore(&rq->lock, flags);
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
@@ -3393,18 +3417,32 @@ static int migration_call(struct notifie
 	case CPU_UP_CANCELED:
 		/* Unbind it from offline cpu so it can run.  Fall thru. */
 		kthread_bind(cpu_rq(cpu)->migration_thread,smp_processor_id());
-	case CPU_DEAD:
 		kthread_stop(cpu_rq(cpu)->migration_thread);
 		cpu_rq(cpu)->migration_thread = NULL;
- 		BUG_ON(cpu_rq(cpu)->nr_running != 0);
+		break;
+	case CPU_DEAD:
+		migrate_all_tasks(cpu);
+		rq = cpu_rq(cpu);
+		kthread_stop(rq->migration_thread);
+		rq->migration_thread = NULL;
+		/* Idle task back to normal (off runqueue, low prio) */
+		rq = task_rq_lock(rq->idle, &flags);
+		deactivate_task(rq->idle, rq);
+		__setscheduler(rq->idle, SCHED_NORMAL, MAX_PRIO);
+		task_rq_unlock(rq, &flags);
+ 		BUG_ON(rq->nr_running != 0);
  		break;
 #endif
 	}
 	return NOTIFY_OK;
 }
 
+/* Register at highest priority so that task migration (migrate_all_tasks)
+ * happens before anything else.
+ */
 static struct notifier_block __devinitdata migration_notifier = {
 	.notifier_call = migration_call,
+	.priority = 10
 };
 
 int __init migration_init(void)
diff -puN kernel/cpu.c~migrate_all_tasks_in_CPU_DEAD kernel/cpu.c
--- linux-2.6.5-mm4/kernel/cpu.c~migrate_all_tasks_in_CPU_DEAD	2004-04-12 14:17:16.000000000 +0530
+++ linux-2.6.5-mm4-vatsa/kernel/cpu.c	2004-04-12 21:27:43.000000000 +0530
@@ -43,15 +43,16 @@ void unregister_cpu_notifier(struct noti
 EXPORT_SYMBOL(unregister_cpu_notifier);
 
 #ifdef CONFIG_HOTPLUG_CPU
-static inline void check_for_tasks(int cpu, struct task_struct *k)
+static inline void check_for_tasks(int cpu)
 {
 	struct task_struct *p;
 
 	write_lock_irq(&tasklist_lock);
 	for_each_process(p) {
-		if (task_cpu(p) == cpu && p != k)
-			printk(KERN_WARNING "Task %s is on cpu %d\n",
-				p->comm, cpu);
+		if (task_cpu(p) == cpu && (p->utime != 0 || p->stime != 0))
+			printk(KERN_WARNING "Task %s (pid = %d) is on cpu %d\
+				(state = %ld, flags = %lx) \n",
+				 p->comm, p->pid, cpu, p->state, p->flags);
 	}
 	write_unlock_irq(&tasklist_lock);
 }
@@ -96,8 +97,9 @@ static int take_cpu_down(void *unused)
 	if (err < 0)
 		cpu_set(smp_processor_id(), cpu_online_map);
 	else
-		/* Everyone else gets kicked off. */
-		migrate_all_tasks();
+		/* Force idle task to run as soon as we yield: it should
+		   immediately notice cpu is offline and die quickly. */
+		sched_idle_next();
 
 	return err;
 }
@@ -106,6 +108,7 @@ int cpu_down(unsigned int cpu)
 {
 	int err;
 	struct task_struct *p;
+	cpumask_t old_allowed, tmp;
 
 	if ((err = lock_cpu_hotplug_interruptible()) != 0)
 		return err;
@@ -120,17 +123,21 @@ int cpu_down(unsigned int cpu)
 		goto out;
 	}
 
+	/* Ensure that we are not runnable on dying cpu */
+	old_allowed = current->cpus_allowed;
+	tmp = CPU_MASK_ALL;
+	cpu_clear(cpu, tmp);
+	set_cpus_allowed(current, tmp);
+
 	p = __stop_machine_run(take_cpu_down, NULL, cpu);
 	if (IS_ERR(p)) {
 		err = PTR_ERR(p);
-		goto out;
+		goto out_allowed;
 	}
 
 	if (cpu_online(cpu))
 		goto out_thread;
 
-	check_for_tasks(cpu, p);
-
 	/* Wait for it to sleep (leaving idle task). */
 	while (!idle_cpu(cpu))
 		yield();
@@ -146,10 +153,14 @@ int cpu_down(unsigned int cpu)
 	    == NOTIFY_BAD)
 		BUG();
 
+	check_for_tasks(cpu);
+
 	cpu_run_sbin_hotplug(cpu, "offline");
 
 out_thread:
 	err = kthread_stop(p);
+out_allowed:
+	set_cpus_allowed(current, old_allowed);
 out:
 	unlock_cpu_hotplug();
 	return err;
diff -puN kernel/fork.c~migrate_all_tasks_in_CPU_DEAD kernel/fork.c
--- linux-2.6.5-mm4/kernel/fork.c~migrate_all_tasks_in_CPU_DEAD	2004-04-12 14:17:16.000000000 +0530
+++ linux-2.6.5-mm4-vatsa/kernel/fork.c	2004-04-12 15:59:01.000000000 +0530
@@ -33,6 +33,7 @@
 #include <linux/ptrace.h>
 #include <linux/mount.h>
 #include <linux/audit.h>
+#include <linux/cpu.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1198,8 +1199,11 @@ long do_fork(unsigned long clone_flags,
 
 		if (!(clone_flags & CLONE_STOPPED))
 			wake_up_forked_process(p);	/* do this last */
-		else
+		else {
 			p->state = TASK_STOPPED;
+			if (unlikely(cpu_is_offline(task_cpu(p))))
+				set_task_cpu(p, smp_processor_id());
+		}
 		++total_forks;
 
 		if (unlikely (trace)) {




Name 	: Defer migrate_all_tasks to CPU_DEAD handling
Author 	: Srivatsa Vaddagiri (vatsa@in.ibm.com)
Status 	: Tested on 2.6.5-ames on a 4-way PPC64 box (p630)


---

 ameslab-vatsa/include/linux/sched.h |    3 -
 ameslab-vatsa/kernel/cpu.c          |   29 +++++++---
 ameslab-vatsa/kernel/fork.c         |    6 +-
 ameslab-vatsa/kernel/sched.c        |  101 ++++++++++++++++++++++++++----------
 4 files changed, 101 insertions(+), 38 deletions(-)

diff -puN include/linux/sched.h~migrate_all_tasks_in_CPU_DEAD include/linux/sched.h
--- ameslab/include/linux/sched.h~migrate_all_tasks_in_CPU_DEAD	2004-04-12 16:16:57.000000000 +0530
+++ ameslab-vatsa/include/linux/sched.h	2004-04-12 16:18:01.000000000 +0530
@@ -549,8 +549,7 @@ extern void node_nr_running_init(void);
 #define node_nr_running_init() {}
 #endif
 
-/* Move tasks off this (offline) CPU onto another. */
-extern void migrate_all_tasks(void);
+extern void sched_idle_next(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -puN kernel/sched.c~migrate_all_tasks_in_CPU_DEAD kernel/sched.c
--- ameslab/kernel/sched.c~migrate_all_tasks_in_CPU_DEAD	2004-04-12 16:16:57.000000000 +0530
+++ ameslab-vatsa/kernel/sched.c	2004-04-12 21:32:20.000000000 +0530
@@ -342,6 +342,14 @@ static inline void enqueue_task(struct t
 	p->array = array;
 }
 
+static inline void __enqueue_task(struct task_struct *p, prio_array_t *array)
+{
+	list_add(&p->run_list, array->queue + p->prio);
+	__set_bit(p->prio, array->bitmap);
+	array->nr_active++;
+	p->array = array;
+}
+
 /*
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
@@ -382,6 +390,15 @@ static inline void __activate_task(task_
 	nr_running_inc(rq);
 }
 
+/*
+ * __activate_idle_task - move idle task to the _front_ of runqueue.
+ */
+static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
+{
+	__enqueue_task(p, rq->active);
+	nr_running_inc(rq);
+}
+
 static void recalc_task_prio(task_t *p, unsigned long long now)
 {
 	unsigned long long __sleep_time = now - p->timestamp;
@@ -666,8 +683,7 @@ repeat_lock_task:
 			if (unlikely(sync && !task_running(rq, p) &&
 				(task_cpu(p) != smp_processor_id()) &&
 					cpu_isset(smp_processor_id(),
-							p->cpus_allowed) &&
-					!cpu_is_offline(smp_processor_id()))) {
+							p->cpus_allowed))) {
 				set_task_cpu(p, smp_processor_id());
 				task_rq_unlock(rq, &flags);
 				goto repeat_lock_task;
@@ -1301,9 +1317,6 @@ static void load_balance(runqueue_t *thi
 	struct list_head *head, *curr;
 	task_t *tmp;
 
-	if (cpu_is_offline(this_cpu))
-		goto out;
-
 	busiest = find_busiest_queue(this_rq, this_cpu, idle,
 				     &imbalance, cpumask);
 	if (!busiest)
@@ -2737,19 +2750,20 @@ out:
 EXPORT_SYMBOL_GPL(set_cpus_allowed);
 
 /* Move (not current) task off this cpu, onto dest cpu. */
-static void move_task_away(struct task_struct *p, int dest_cpu)
+static void move_task_away(struct task_struct *p, int src_cpu, int dest_cpu)
 {
-	runqueue_t *rq_dest;
+	runqueue_t *rq_dest, *rq_src;
 
+	rq_src  = cpu_rq(src_cpu);
 	rq_dest = cpu_rq(dest_cpu);
 
-	double_rq_lock(this_rq(), rq_dest);
-	if (task_cpu(p) != smp_processor_id())
+	double_rq_lock(rq_src, rq_dest);
+	if (task_cpu(p) != src_cpu)
 		goto out; /* Already moved */
 
 	set_task_cpu(p, dest_cpu);
 	if (p->array) {
-		deactivate_task(p, this_rq());
+		deactivate_task(p, rq_src);
 		activate_task(p, rq_dest);
 		if (p->prio < rq_dest->curr->prio)
 			resched_task(rq_dest->curr);
@@ -2757,7 +2771,7 @@ static void move_task_away(struct task_s
 	p->timestamp = rq_dest->timestamp_last_tick;
 
 out:
-	double_rq_unlock(this_rq(), rq_dest);
+	double_rq_unlock(rq_src, rq_dest);
 }
 
 /*
@@ -2792,7 +2806,7 @@ static int migration_thread(void * data)
 		list_del_init(head->next);
 		spin_unlock(&rq->lock);
 
-		move_task_away(req->task,
+		move_task_away(req->task, smp_processor_id(),
 			       any_online_cpu(req->task->cpus_allowed));
 		local_irq_enable();
 		complete(&req->done);
@@ -2801,20 +2815,14 @@ static int migration_thread(void * data)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-/* migrate_all_tasks - function to migrate all the tasks from the
- * current cpu caller must have already scheduled this to the target
- * cpu via set_cpus_allowed.  Machine is stopped.  */
-void migrate_all_tasks(void)
+/* migrate_all_tasks - function to migrate all tasks from the dead cpu. */
+static void migrate_all_tasks(int src_cpu)
 {
 	struct task_struct *tsk, *t;
-	int dest_cpu, src_cpu;
+	int dest_cpu;
 	unsigned int node;
 
-	/* We're nailed to this CPU. */
-	src_cpu = smp_processor_id();
-
-	/* Not required, but here for neatness. */
-	write_lock(&tasklist_lock);
+	write_lock_irq(&tasklist_lock);
 
 	/* watch out for per node tasks, let's stay on this node */
 	node = cpu_to_node(src_cpu);
@@ -2850,10 +2858,37 @@ void migrate_all_tasks(void)
 				       tsk->pid, tsk->comm, src_cpu);
 		}
 
-		move_task_away(tsk, dest_cpu);
+		move_task_away(tsk, src_cpu, dest_cpu);
 	} while_each_thread(t, tsk);
 
-	write_unlock(&tasklist_lock);
+	write_unlock_irq(&tasklist_lock);
+}
+
+/* Schedules idle task to be the next runnable task on current CPU.
+ * It does so by boosting its priority to highest possible and adding it to
+ * the _front_ of runqueue. Used by CPU offline code.
+ */
+
+void sched_idle_next(void)
+{
+	int cpu = smp_processor_id();
+	runqueue_t *rq = this_rq();
+	struct task_struct *p = rq->idle;
+	unsigned long flags;
+
+	/* cpu has to be offline */
+	BUG_ON(cpu_online(cpu));
+
+	/* Strictly not necessary since rest of the CPUs are stopped by now
+	 * and interrupts disabled on current cpu.
+	 */
+	spin_lock_irqsave(&rq->lock, flags);
+
+	__setscheduler(p, SCHED_FIFO, MAX_RT_PRIO-1);
+	/* Add idle task to _front_ of it's priority queue */
+	__activate_idle_task(p, rq);
+
+	spin_unlock_irqrestore(&rq->lock, flags);
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
@@ -2889,18 +2924,32 @@ static int migration_call(struct notifie
 	case CPU_UP_CANCELED:
 		/* Unbind it from offline cpu so it can run.  Fall thru. */
 		kthread_bind(cpu_rq(cpu)->migration_thread,smp_processor_id());
-	case CPU_DEAD:
 		kthread_stop(cpu_rq(cpu)->migration_thread);
 		cpu_rq(cpu)->migration_thread = NULL;
- 		BUG_ON(cpu_rq(cpu)->nr_running != 0);
+		break;
+	case CPU_DEAD:
+		migrate_all_tasks(cpu);
+		rq = cpu_rq(cpu);
+		kthread_stop(rq->migration_thread);
+		rq->migration_thread = NULL;
+		/* Idle task back to normal (off runqueue, low prio) */
+		rq = task_rq_lock(rq->idle, &flags);
+		deactivate_task(rq->idle, rq);
+		__setscheduler(rq->idle, SCHED_NORMAL, MAX_PRIO);
+		task_rq_unlock(rq, &flags);
+ 		BUG_ON(rq->nr_running != 0);
  		break;
 #endif
 	}
 	return NOTIFY_OK;
 }
 
+/* Register at highest priority so that task migration (migrate_all_tasks)
+ * happens before anything else.
+ */
 static struct notifier_block __devinitdata migration_notifier = {
 	.notifier_call = migration_call,
+	.priority = 10
 };
 
 int __init migration_init(void)
diff -puN kernel/fork.c~migrate_all_tasks_in_CPU_DEAD kernel/fork.c
--- ameslab/kernel/fork.c~migrate_all_tasks_in_CPU_DEAD	2004-04-12 16:16:57.000000000 +0530
+++ ameslab-vatsa/kernel/fork.c	2004-04-12 16:18:31.000000000 +0530
@@ -31,6 +31,7 @@
 #include <linux/futex.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
+#include <linux/cpu.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1168,8 +1169,11 @@ long do_fork(unsigned long clone_flags,
 
 		if (!(clone_flags & CLONE_STOPPED))
 			wake_up_forked_process(p);	/* do this last */
-		else
+		else {
 			p->state = TASK_STOPPED;
+			if (unlikely(cpu_is_offline(task_cpu(p))))
+				set_task_cpu(p, smp_processor_id());
+		}
 		++total_forks;
 
 		if (unlikely (trace)) {
diff -puN kernel/cpu.c~migrate_all_tasks_in_CPU_DEAD kernel/cpu.c
--- ameslab/kernel/cpu.c~migrate_all_tasks_in_CPU_DEAD	2004-04-12 16:16:57.000000000 +0530
+++ ameslab-vatsa/kernel/cpu.c	2004-04-12 16:24:58.000000000 +0530
@@ -43,15 +43,16 @@ void unregister_cpu_notifier(struct noti
 EXPORT_SYMBOL(unregister_cpu_notifier);
 
 #ifdef CONFIG_HOTPLUG_CPU
-static inline void check_for_tasks(int cpu, struct task_struct *k)
+static inline void check_for_tasks(int cpu)
 {
 	struct task_struct *p;
 
 	write_lock_irq(&tasklist_lock);
 	for_each_process(p) {
-		if (task_cpu(p) == cpu && p != k)
-			printk(KERN_WARNING "Task %s is on cpu %d\n",
-				p->comm, cpu);
+		if (task_cpu(p) == cpu && (p->utime != 0 || p->stime != 0))
+			printk(KERN_WARNING "Task %s (pid = %d) is on cpu %d\
+				(state = %ld, flags = %lx) \n",
+				 p->comm, p->pid, cpu, p->state, p->flags);
 	}
 	write_unlock_irq(&tasklist_lock);
 }
@@ -96,8 +97,9 @@ static int take_cpu_down(void *unused)
 	if (err < 0)
 		cpu_set(smp_processor_id(), cpu_online_map);
 	else
-		/* Everyone else gets kicked off. */
-		migrate_all_tasks();
+		/* Force idle task to run as soon as we yield: it should
+		   immediately notice cpu is offline and die quickly. */
+		sched_idle_next();
 
 	return err;
 }
@@ -106,6 +108,7 @@ int cpu_down(unsigned int cpu)
 {
 	int err;
 	struct task_struct *p;
+	cpumask_t old_allowed, tmp;
 
 	if ((err = lock_cpu_hotplug_interruptible()) != 0)
 		return err;
@@ -120,17 +123,21 @@ int cpu_down(unsigned int cpu)
 		goto out;
 	}
 
+	/* Ensure that we are not runnable on dying cpu */
+	old_allowed = current->cpus_allowed;
+	tmp = CPU_MASK_ALL;
+	cpu_clear(cpu, tmp);
+	set_cpus_allowed(current, tmp);
+
 	p = __stop_machine_run(take_cpu_down, NULL, cpu);
 	if (IS_ERR(p)) {
 		err = PTR_ERR(p);
-		goto out;
+		goto out_allowed;
 	}
 
 	if (cpu_online(cpu))
 		goto out_thread;
 
-	check_for_tasks(cpu, p);
-
 	/* Wait for it to sleep (leaving idle task). */
 	while (!idle_cpu(cpu))
 		yield();
@@ -146,10 +153,14 @@ int cpu_down(unsigned int cpu)
 	    == NOTIFY_BAD)
 		BUG();
 
+	check_for_tasks(cpu);
+
 	cpu_run_sbin_hotplug(cpu, "offline");
 
 out_thread:
 	err = kthread_stop(p);
+out_allowed:
+	set_cpus_allowed(current, old_allowed);
 out:
 	unlock_cpu_hotplug();
 	return err;





	   

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
