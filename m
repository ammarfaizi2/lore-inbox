Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbUDFQnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbUDFQnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:43:47 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:21168 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263909AbUDFQmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:42:00 -0400
Date: Tue, 6 Apr 2004 22:13:04 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rusty@au1.ibm.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [lhcs-devel] Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to CPU_DEAD handling
Message-ID: <20040406164304.GA9258@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040405121824.GA8497@in.ibm.com> <4071F9C5.2030002@yahoo.com.au> <20040406011508.GA5077@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406011508.GA5077@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 06:45:08AM +0530, Srivatsa Vaddagiri wrote:
> Will send out today a patch against latest -mm tree!

And here's the patch against 2.6.5-mm1 (did some minimal testing on
4-way Pentium Box - Will run stress tests tomorrow and update the
patch if necessary!)



---

 linux-2.6.5-mm1-vatsa/include/linux/sched.h |    3 
 linux-2.6.5-mm1-vatsa/kernel/cpu.c          |   29 ++++++--
 linux-2.6.5-mm1-vatsa/kernel/sched.c        |   92 +++++++++++++++++++++-------
 3 files changed, 92 insertions(+), 32 deletions(-)

diff -puN include/linux/sched.h~migrate_all_tasks_in_CPU_DEAD include/linux/sched.h
--- linux-2.6.5-mm1/include/linux/sched.h~migrate_all_tasks_in_CPU_DEAD	2004-04-06 22:04:27.000000000 +0530
+++ linux-2.6.5-mm1-vatsa/include/linux/sched.h	2004-04-06 22:04:44.000000000 +0530
@@ -664,8 +664,7 @@ extern void sched_balance_exec(void);
 #define sched_balance_exec()   {}
 #endif
 
-/* Move tasks off this (offline) CPU onto another. */
-extern void migrate_all_tasks(void);
+extern void sched_idle_next(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
diff -puN kernel/sched.c~migrate_all_tasks_in_CPU_DEAD kernel/sched.c
--- linux-2.6.5-mm1/kernel/sched.c~migrate_all_tasks_in_CPU_DEAD	2004-04-06 22:04:27.000000000 +0530
+++ linux-2.6.5-mm1-vatsa/kernel/sched.c	2004-04-06 22:05:16.000000000 +0530
@@ -385,6 +385,15 @@ static inline void __activate_task(task_
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
@@ -748,7 +757,7 @@ static int try_to_wake_up(task_t * p, un
 	this_cpu = smp_processor_id();
 
 #ifdef CONFIG_SMP
-	if (unlikely(task_running(rq, p) || cpu_is_offline(this_cpu)))
+	if (unlikely(task_running(rq, p)))
 		goto out_activate;
 
 	new_cpu = cpu;
@@ -1681,9 +1690,6 @@ static inline void idle_balance(int this
 {
 	struct sched_domain *sd;
 
-	if (unlikely(cpu_is_offline(this_cpu)))
-		return;
-
 	for_each_domain(this_cpu, sd) {
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
 			if (load_balance_newidle(this_cpu, this_rq, sd)) {
@@ -1771,9 +1777,6 @@ static void rebalance_tick(int this_cpu,
 	unsigned long j = jiffies + CPU_OFFSET(this_cpu);
 	struct sched_domain *sd;
 
-	if (unlikely(cpu_is_offline(this_cpu)))
-		return;
-
 	/* Update our load */
 	old_load = this_rq->cpu_load;
 	this_load = this_rq->nr_running * SCHED_LOAD_SCALE;
@@ -3222,15 +3225,16 @@ EXPORT_SYMBOL_GPL(set_cpus_allowed);
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
@@ -3238,7 +3242,7 @@ static void __migrate_task(struct task_s
 
 	set_task_cpu(p, dest_cpu);
 	if (p->array) {
-		deactivate_task(p, this_rq());
+		deactivate_task(p, rq_src);
 		activate_task(p, rq_dest);
 		if (TASK_PREEMPTS_CURR(p, rq_dest))
 			resched_task(rq_dest->curr);
@@ -3246,7 +3250,7 @@ static void __migrate_task(struct task_s
 	p->timestamp = rq_dest->timestamp_last_tick;
 
 out:
-	double_rq_unlock(this_rq(), rq_dest);
+	double_rq_unlock(rq_src, rq_dest);
 }
 
 /*
@@ -3289,7 +3293,7 @@ static int migration_thread(void * data)
 		spin_unlock(&rq->lock);
 
 		if (req->type == REQ_MOVE_TASK) {
-			__migrate_task(req->task, req->dest_cpu);
+			__migrate_task(req->task, smp_processor_id(), req->dest_cpu);
 		} else if (req->type == REQ_SET_DOMAIN) {
 			rq->sd = req->sd;
 		} else {
@@ -3304,19 +3308,16 @@ static int migration_thread(void * data)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-/* migrate_all_tasks - function to migrate all the tasks from the
- * current cpu caller must have already scheduled this to the target
- * cpu via set_cpus_allowed.  Machine is stopped.  */
-void migrate_all_tasks(void)
+/* migrate_all_tasks - function to migrate all the tasks from the  dead cpu.  */
+static void migrate_all_tasks(int cpu)
 {
 	struct task_struct *tsk, *t;
 	int dest_cpu, src_cpu;
 	unsigned int node;
 
 	/* We're nailed to this CPU. */
-	src_cpu = smp_processor_id();
+	src_cpu = cpu;
 
-	/* Not required, but here for neatness. */
 	write_lock(&tasklist_lock);
 
 	/* watch out for per node tasks, let's stay on this node */
@@ -3353,11 +3354,39 @@ void migrate_all_tasks(void)
 				       tsk->pid, tsk->comm, src_cpu);
 		}
 
-		__migrate_task(tsk, dest_cpu);
+		local_irq_disable();
+		__migrate_task(tsk, src_cpu, dest_cpu);
+		local_irq_enable();
 	} while_each_thread(t, tsk);
 
 	write_unlock(&tasklist_lock);
 }
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
+}
 #endif /* CONFIG_HOTPLUG_CPU */
 
 /*
@@ -3392,10 +3421,27 @@ static int migration_call(struct notifie
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
+ 		BUG_ON(rq->nr_running != 0);
  		break;
 #endif
 	}
diff -puN kernel/cpu.c~migrate_all_tasks_in_CPU_DEAD kernel/cpu.c
--- linux-2.6.5-mm1/kernel/cpu.c~migrate_all_tasks_in_CPU_DEAD	2004-04-06 22:04:27.000000000 +0530
+++ linux-2.6.5-mm1-vatsa/kernel/cpu.c	2004-04-06 22:05:04.000000000 +0530
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
@@ -120,17 +127,21 @@ int cpu_down(unsigned int cpu)
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
@@ -146,10 +157,14 @@ int cpu_down(unsigned int cpu)
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
