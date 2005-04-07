Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVDGClw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVDGClw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 22:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVDGClw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 22:41:52 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:64677 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262394AbVDGCj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 22:39:58 -0400
Message-ID: <42549D76.9040701@yahoo.com.au>
Date: Thu, 07 Apr 2005 12:39:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] sched: consolidate sbe sbf
Content-Type: multipart/mixed;
 boundary="------------000109050707020809060702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000109050707020809060702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ingo,

What do you think of the following patch? I won't send the
whole series again, I'll queue them up with Andrew if you
think this one looks OK (which is the only major change).

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

--------------000109050707020809060702
Content-Type: text/plain;
 name="sched-consolidate-sbe-sbf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-consolidate-sbe-sbf.patch"

Consolidate balance-on-exec with balance-on-fork. This is made easy
by the sched-domains RCU patches.

As well as the general goodness of code reduction, this allows
the runqueues to be unlocked during balance-on-fork.

schedstats is a problem. Maybe just have balance-on-event instead
of distinguishing fork and exec?

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-04-07 02:39:21.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-04-07 12:34:06.000000000 +1000
@@ -1022,8 +1022,57 @@ static int find_idlest_cpu(struct sched_
 	return idlest;
 }
 
+/*
+ * sched_balance_self: balance the current task (running on cpu) in domains
+ * that have the 'flag' flag set. In practice, this is SD_BALANCE_FORK and
+ * SD_BALANCE_EXEC.
+ *
+ * Balance, ie. select the least loaded group.
+ *
+ * Returns the target CPU number, or the same CPU if no balancing is needed.
+ *
+ * preempt must be disabled.
+ */
+static int sched_balance_self(int cpu, int flag)
+{
+	struct task_struct *t = current;
+	struct sched_domain *tmp, *sd = NULL;
 
-#endif
+	for_each_domain(cpu, tmp)
+		if (tmp->flags & flag)
+			sd = tmp;
+
+	while (sd) {
+		cpumask_t span;
+		struct sched_group *group;
+		int new_cpu;
+
+		span = sd->span;
+		group = find_idlest_group(sd, t, cpu);
+		if (!group)
+			goto nextlevel;
+
+		new_cpu = find_idlest_cpu(group, cpu);
+		if (new_cpu == -1 || new_cpu == cpu)
+			goto nextlevel;
+
+		/* Now try balancing at a lower domain level */
+		cpu = new_cpu;
+nextlevel:
+		sd = NULL;
+		for_each_domain(cpu, tmp) {
+			if (cpus_subset(span, tmp->span))
+				break;
+			if (tmp->flags & flag)
+				sd = tmp;
+		}
+		/* while loop will break here if sd == NULL */
+	}
+
+	return cpu;
+}
+
+#endif /* CONFIG_SMP */
 
 /*
  * wake_idle() will wake a task on an idle cpu if task->cpu is
@@ -1241,8 +1290,17 @@ int fastcall wake_up_state(task_t *p, un
  * Perform scheduler related setup for a newly forked process p.
  * p is forked by current.
  */
-void fastcall sched_fork(task_t *p)
+void fastcall sched_fork(task_t *p, int clone_flags)
 {
+	int cpu = smp_processor_id();
+	
+#ifdef CONFIG_SMP
+	preempt_disable();
+	cpu = sched_balance_self(cpu, SD_BALANCE_FORK);
+	preempt_enable();
+#endif
+	set_task_cpu(p, cpu);
+
 	/*
 	 * We mark the process as running here, but have not actually
 	 * inserted it onto the runqueue yet. This guarantees that
@@ -1303,64 +1361,12 @@ void fastcall wake_up_new_task(task_t * 
 	unsigned long flags;
 	int this_cpu, cpu;
 	runqueue_t *rq, *this_rq;
-#ifdef CONFIG_SMP
-	struct sched_domain *tmp, *sd = NULL;
-#endif
 
 	rq = task_rq_lock(p, &flags);
 	BUG_ON(p->state != TASK_RUNNING);
 	this_cpu = smp_processor_id();
 	cpu = task_cpu(p);
 
-#ifdef CONFIG_SMP
-	for_each_domain(cpu, tmp)
-		if (tmp->flags & SD_BALANCE_FORK)
-			sd = tmp;
-
-	if (sd) {
-		cpumask_t span;
-		int new_cpu;
-		struct sched_group *group;
-
-again:
-		schedstat_inc(sd, sbf_cnt);
-		span = sd->span;
-		cpu = task_cpu(p);
-		group = find_idlest_group(sd, p, cpu);
-		if (!group) {
-			schedstat_inc(sd, sbf_balanced);
-			goto nextlevel;
-		}
-
-		new_cpu = find_idlest_cpu(group, cpu);
-		if (new_cpu == -1 || new_cpu == cpu) {
-			schedstat_inc(sd, sbf_balanced);
-			goto nextlevel;
-		}
-
-		if (cpu_isset(new_cpu, p->cpus_allowed)) {
-			schedstat_inc(sd, sbf_pushed);
-			set_task_cpu(p, new_cpu);
-			task_rq_unlock(rq, &flags);
-			rq = task_rq_lock(p, &flags);
-			cpu = task_cpu(p);
-		}
-
-		/* Now try balancing at a lower domain level */
-nextlevel:
-		sd = NULL;
-		for_each_domain(cpu, tmp) {
-			if (cpus_subset(span, tmp->span))
-				break;
-			if (tmp->flags & SD_BALANCE_FORK)
-				sd = tmp;
-		}
-
-		if (sd)
-			goto again;
-	}
-
-#endif
 	/*
 	 * We decrease the sleep average of forking parents
 	 * and children as well, to keep max-interactive tasks
@@ -1708,59 +1714,17 @@ out:
 	task_rq_unlock(rq, &flags);
 }
 
-/*
- * sched_exec(): find the highest-level, exec-balance-capable
- * domain and try to migrate the task to the least loaded CPU.
- *
- * execve() is a valuable balancing opportunity, because at this point
- * the task has the smallest effective memory and cache footprint.
+/* 
+ * sched_exec - execve() is a valuable balancing opportunity, because at
+ * this point the task has the smallest effective memory and cache footprint.
  */
 void sched_exec(void)
 {
-	struct sched_domain *tmp, *sd = NULL;
 	int new_cpu, this_cpu = get_cpu();
-
-	for_each_domain(this_cpu, tmp)
-		if (tmp->flags & SD_BALANCE_EXEC)
-			sd = tmp;
-
-	if (sd) {
-		cpumask_t span;
-		struct sched_group *group;
-again:
-		schedstat_inc(sd, sbe_cnt);
-		span = sd->span;
-		group = find_idlest_group(sd, current, this_cpu);
-		if (!group) {
-			schedstat_inc(sd, sbe_balanced);
-			goto nextlevel;
-		}
-		new_cpu = find_idlest_cpu(group, this_cpu);
-		if (new_cpu == -1 || new_cpu == this_cpu) {
-			schedstat_inc(sd, sbe_balanced);
-			goto nextlevel;
-		}
-
-		schedstat_inc(sd, sbe_pushed);
-		put_cpu();
-		sched_migrate_task(current, new_cpu);
-		
-		/* Now try balancing at a lower domain level */
-		this_cpu = get_cpu();
-nextlevel:
-		sd = NULL;
-		for_each_domain(this_cpu, tmp) {
-			if (cpus_subset(span, tmp->span))
-				break;
-			if (tmp->flags & SD_BALANCE_EXEC)
-				sd = tmp;
-		}
-
-		if (sd)
-			goto again;
-	}
-
+	new_cpu = sched_balance_self(this_cpu, SD_BALANCE_EXEC);
 	put_cpu();
+	if (new_cpu != this_cpu)
+		sched_migrate_task(current, new_cpu);
 }
 
 /*
Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h	2005-04-07 02:31:47.000000000 +1000
+++ linux-2.6/include/linux/sched.h	2005-04-07 02:39:21.000000000 +1000
@@ -923,7 +923,7 @@ extern void FASTCALL(wake_up_new_task(st
 #else
  static inline void kick_process(struct task_struct *tsk) { }
 #endif
-extern void FASTCALL(sched_fork(task_t * p));
+extern void FASTCALL(sched_fork(task_t * p, int clone_flags));
 extern void FASTCALL(sched_exit(task_t * p));
 
 extern int in_group_p(gid_t);
Index: linux-2.6/kernel/fork.c
===================================================================
--- linux-2.6.orig/kernel/fork.c	2005-04-07 02:31:47.000000000 +1000
+++ linux-2.6/kernel/fork.c	2005-04-07 02:39:21.000000000 +1000
@@ -1000,9 +1000,6 @@ static task_t *copy_process(unsigned lon
 	p->pdeath_signal = 0;
 	p->exit_state = 0;
 
-	/* Perform scheduler related setup */
-	sched_fork(p);
-
 	/*
 	 * Ok, make it visible to the rest of the system.
 	 * We dont wake it up yet.
@@ -1011,19 +1008,25 @@ static task_t *copy_process(unsigned lon
 	INIT_LIST_HEAD(&p->ptrace_children);
 	INIT_LIST_HEAD(&p->ptrace_list);
 
+	/* Perform scheduler related setup. Assign this task to a CPU. */
+	sched_fork(p, clone_flags);
+
 	/* Need tasklist lock for parent etc handling! */
 	write_lock_irq(&tasklist_lock);
 
 	/*
-	 * The task hasn't been attached yet, so cpus_allowed mask cannot
-	 * have changed. The cpus_allowed mask of the parent may have
-	 * changed after it was copied first time, and it may then move to
-	 * another CPU - so we re-copy it here and set the child's CPU to
-	 * the parent's CPU. This avoids alot of nasty races.
+	 * The task hasn't been attached yet, so its cpus_allowed mask will
+	 * not be changed, nor will its assigned CPU.
+	 * 
+	 * The cpus_allowed mask of the parent may have changed after it was
+	 * copied first time - so re-copy it here, then check the child's CPU
+	 * to ensure it is on a valid CPU (and if not, just force it back to
+	 * parent's CPU). This avoids alot of nasty races.
 	 */
 	p->cpus_allowed = current->cpus_allowed;
-	set_task_cpu(p, smp_processor_id());
-
+	if (unlikely(!cpu_isset(task_cpu(p), p->cpus_allowed)))
+		set_task_cpu(p, smp_processor_id());
+		
 	/*
 	 * Check for pending SIGKILL! The new thread should not be allowed
 	 * to slip out of an OOM kill. (or normal SIGKILL.)

--------------000109050707020809060702--

