Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUDEMRs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 08:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbUDEMRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 08:17:48 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:11667 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262193AbUDEMRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 08:17:30 -0400
Date: Mon, 5 Apr 2004 17:48:24 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: rusty@au1.ibm.com
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to CPU_DEAD handling
Message-ID: <20040405121824.GA8497@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,
	migrate_all_tasks is currently run with rest of the machine stopped.
It iterates thr' the complete task table, turning off cpu affinity of any task 
that it finds affine to the dying cpu. Depending on the task table 
size this can take considerable time. All this time machine is stopped, doing
nothing.

I think Nick was working on reducing this time spent in migrating tasks
by concentrating only on the tasks in the runqueue and catch up with sleeping
tasks as and when they wake up (in try_to_wake_up). But this still can be 
considerable time spent depending on the number of tasks in the dying CPU's 
runqueue.

Other solutions that we thought of were put off by either changes required
in hot path (schedule for ex) or the complexity of implementation.

I was tempted to think of an alternate _simple_ solution that :

	a. avoids doing migrate tasks with machine stopped
	b. avoids any changes in core code (especially hot path)

Point a) leads to a more scalable solution where amout of time machine
is stopped is _independent_ of runqueue length or task table length.

The solution that I came up with (which can be shot down if you think its
not correct/good :-) which meets both the above goals was to have idle task put
to the _front_ of the dying CPU's runqueue at the highest priority 
possible. This cause idle thread to run _immediately_ after kstopmachine
thread yields. Idle thread notices that its cpu is offline and 
dies quickly. Task migration can then be done at leisure in CPU_DEAD
notification, when rest of the CPUs are running.

Some advantages I see with this approach are:

	- More scalable. Predicatable amout of time that machine is stopped.
	- No changes to core code. We are just exploiting scheduler rules
	  which runs the next high-priority task on the runqueue. Also
	  since I put idle task to the _front_ of the runqueue, there
	  are no races when a equally high priority task is woken up 
	  and added to the runqueue. It gets in at the back of the runqueue,
	  _after_ idle task!
	- No changes in hot path/core code (schedule/try_to_wake_up)
	- cpu_is_offline check that is presenty required in load_balance
	  can be removed, thus speeding it up a bit
	- Probably the cpu_is_offline check that is present in try_to_wake_up
	  (sync case) can also be removed ..I dont think that check is required
	  even w/o this patch?

Patch below is (stress) tested on 4-way PPC64 box against 2.6.5-ames. To
test it, you probably need to also apply the "fix __cpu_up race" patch that I
posted earlier.

Pls let me know if this topic is worth pursuing!



---

 linux-2.6.5-ames-vatsa/include/linux/sched.h |    5 -
 linux-2.6.5-ames-vatsa/kernel/cpu.c          |   28 +++++-
 linux-2.6.5-ames-vatsa/kernel/sched.c        |  109 ++++++++++++++++++++-------
 3 files changed, 109 insertions(+), 33 deletions(-)

diff -puN include/linux/sched.h~migrate_all_tasks_in_CPU_DEAD include/linux/sched.h
--- linux-2.6.5-ames/include/linux/sched.h~migrate_all_tasks_in_CPU_DEAD	2004-04-05 16:44:50.000000000 +0530
+++ linux-2.6.5-ames-vatsa/include/linux/sched.h	2004-04-05 16:46:01.000000000 +0530
@@ -549,8 +549,9 @@ extern void node_nr_running_init(void);
 #define node_nr_running_init() {}
 #endif
 
-/* Move tasks off this (offline) CPU onto another. */
-extern void migrate_all_tasks(void);
+/* Move tasks off dead CPU onto another. */
+extern void migrate_all_tasks(int cpu);
+extern void sched_idle_next(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -puN kernel/sched.c~migrate_all_tasks_in_CPU_DEAD kernel/sched.c
--- linux-2.6.5-ames/kernel/sched.c~migrate_all_tasks_in_CPU_DEAD	2004-04-05 16:44:50.000000000 +0530
+++ linux-2.6.5-ames-vatsa/kernel/sched.c	2004-04-05 16:45:12.000000000 +0530
@@ -342,6 +342,15 @@ static inline void enqueue_task(struct t
 	p->array = array;
 }
 
+/* Add task at the _front_ of it's priority queue - Used by CPU offline code */
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
@@ -382,6 +391,15 @@ static inline void __activate_task(task_
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
@@ -666,8 +684,7 @@ repeat_lock_task:
 			if (unlikely(sync && !task_running(rq, p) &&
 				(task_cpu(p) != smp_processor_id()) &&
 					cpu_isset(smp_processor_id(),
-							p->cpus_allowed) &&
-					!cpu_is_offline(smp_processor_id()))) {
+							p->cpus_allowed))) {
 				set_task_cpu(p, smp_processor_id());
 				task_rq_unlock(rq, &flags);
 				goto repeat_lock_task;
@@ -1301,9 +1318,6 @@ static void load_balance(runqueue_t *thi
 	struct list_head *head, *curr;
 	task_t *tmp;
 
-	if (cpu_is_offline(this_cpu))
-		goto out;
-
 	busiest = find_busiest_queue(this_rq, this_cpu, idle,
 				     &imbalance, cpumask);
 	if (!busiest)
@@ -2657,7 +2671,7 @@ void show_state(void)
 	read_unlock(&tasklist_lock);
 }
 
-void __init init_idle(task_t *idle, int cpu)
+void __devinit init_idle(task_t *idle, int cpu)
 {
 	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(task_cpu(idle));
 	unsigned long flags;
@@ -2736,20 +2750,21 @@ out:
 
 EXPORT_SYMBOL_GPL(set_cpus_allowed);
 
-/* Move (not current) task off this cpu, onto dest cpu. */
-static void move_task_away(struct task_struct *p, int dest_cpu)
+/* Move (not current) task off src cpu, onto dest cpu. */
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
@@ -2757,7 +2772,7 @@ static void move_task_away(struct task_s
 	p->timestamp = rq_dest->timestamp_last_tick;
 
 out:
-	double_rq_unlock(this_rq(), rq_dest);
+	double_rq_unlock(rq_src, rq_dest);
 }
 
 /*
@@ -2792,7 +2807,7 @@ static int migration_thread(void * data)
 		list_del_init(head->next);
 		spin_unlock(&rq->lock);
 
-		move_task_away(req->task,
+		move_task_away(req->task, smp_processor_id(),
 			       any_online_cpu(req->task->cpus_allowed));
 		local_irq_enable();
 		complete(&req->done);
@@ -2801,19 +2816,17 @@ static int migration_thread(void * data)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-/* migrate_all_tasks - function to migrate all the tasks from the
- * current cpu caller must have already scheduled this to the target
- * cpu via set_cpus_allowed.  Machine is stopped.  */
-void migrate_all_tasks(void)
+/* migrate_all_tasks - function to migrate all the tasks from
+ * (dead) cpu.
+ */
+void migrate_all_tasks(int cpu)
 {
 	struct task_struct *tsk, *t;
 	int dest_cpu, src_cpu;
 	unsigned int node;
 
-	/* We're nailed to this CPU. */
-	src_cpu = smp_processor_id();
+	src_cpu = cpu;
 
-	/* Not required, but here for neatness. */
 	write_lock(&tasklist_lock);
 
 	/* watch out for per node tasks, let's stay on this node */
@@ -2850,11 +2863,40 @@ void migrate_all_tasks(void)
 				       tsk->pid, tsk->comm, src_cpu);
 		}
 
-		move_task_away(tsk, dest_cpu);
+		local_irq_disable();
+		move_task_away(tsk, src_cpu, dest_cpu);
+		local_irq_enable();
 	} while_each_thread(t, tsk);
 
 	write_unlock(&tasklist_lock);
 }
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
+}
 #endif /* CONFIG_HOTPLUG_CPU */
 
 /*
@@ -2889,11 +2931,28 @@ static int migration_call(struct notifie
 	case CPU_UP_CANCELED:
 		/* Unbind it from offline cpu so it can run.  Fall thru. */
 		kthread_bind(cpu_rq(cpu)->migration_thread,smp_processor_id());
-	case CPU_DEAD:
 		kthread_stop(cpu_rq(cpu)->migration_thread);
 		cpu_rq(cpu)->migration_thread = NULL;
- 		BUG_ON(cpu_rq(cpu)->nr_running != 0);
- 		break;
+		break;
+	case CPU_DEAD:
+		migrate_all_tasks(cpu);
+		rq = cpu_rq(cpu);
+		kthread_stop(rq->migration_thread);
+		rq->migration_thread = NULL;
+		/* Take idle task off runqueue and restore it's
+		 * policy/priority
+		 */
+		rq = task_rq_lock(rq->idle, &flags);
+
+		/* Call init_idle instead ?? init_idle doesn't restore the
+		 * policy though for us ..
+		 */
+		deactivate_task(rq->idle, rq);
+		__setscheduler(rq->idle, SCHED_NORMAL, MAX_PRIO);
+
+		task_rq_unlock(rq, &flags);
+		BUG_ON(rq->nr_running != 0);
+		break;
 #endif
 	}
 	return NOTIFY_OK;
diff -puN kernel/cpu.c~migrate_all_tasks_in_CPU_DEAD kernel/cpu.c
--- linux-2.6.5-ames/kernel/cpu.c~migrate_all_tasks_in_CPU_DEAD	2004-04-05 16:44:50.000000000 +0530
+++ linux-2.6.5-ames-vatsa/kernel/cpu.c	2004-04-05 16:45:12.000000000 +0530
@@ -43,13 +43,13 @@ void unregister_cpu_notifier(struct noti
 EXPORT_SYMBOL(unregister_cpu_notifier);
 
 #ifdef CONFIG_HOTPLUG_CPU
-static inline void check_for_tasks(int cpu, struct task_struct *k)
+static inline void check_for_tasks(int cpu)
 {
 	struct task_struct *p;
 
 	write_lock_irq(&tasklist_lock);
 	for_each_process(p) {
-		if (task_cpu(p) == cpu && p != k)
+		if (task_cpu(p) == cpu)
 			printk(KERN_WARNING "Task %s is on cpu %d\n",
 				p->comm, cpu);
 	}
@@ -96,8 +96,14 @@ static int take_cpu_down(void *unused)
 	if (err < 0)
 		cpu_set(smp_processor_id(), cpu_online_map);
 	else
-		/* Everyone else gets kicked off. */
-		migrate_all_tasks();
+		/* Force scheduler to switch to idle task when we yield.
+		 * We expect idle task to _immediately_ notice that it's cpu
+		 * is offline and die quickly.
+		 *
+		 * This allows us to defer calling mirate_all_tasks until
+		 * CPU_DEAD notification time.
+		 */
+		sched_idle_next();
 
 	return err;
 }
@@ -106,6 +112,7 @@ int cpu_down(unsigned int cpu)
 {
 	int err;
 	struct task_struct *p;
+	cpumask_t old_allowed, tmp;
 
 	if ((err = lock_cpu_hotplug_interruptible()) != 0)
 		return err;
@@ -120,16 +127,21 @@ int cpu_down(unsigned int cpu)
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
 
 	/* Wait for it to sleep (leaving idle task). */
 	while (!idle_cpu(cpu))
@@ -146,10 +158,14 @@ int cpu_down(unsigned int cpu)
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

_





	

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
