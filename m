Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVDEXxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVDEXxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 19:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVDEXxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 19:53:02 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:34415 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262012AbVDEXuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 19:50:04 -0400
Message-ID: <42532427.3030100@yahoo.com.au>
Date: Wed, 06 Apr 2005 09:49:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: [patch 5/5] sched: consolidate sbe sbf
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au> <425323A1.5030603@yahoo.com.au>
In-Reply-To: <425323A1.5030603@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------070908000103090003060807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070908000103090003060807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

5/5

Any ideas about what to do with schedstats?
Do we really need balance on exec and fork as seperate
statistics?

--------------070908000103090003060807
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
--- linux-2.6.orig/kernel/sched.c	2005-04-05 18:39:14.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-04-05 18:40:18.000000000 +1000
@@ -1013,8 +1013,57 @@ static int find_idlest_cpu(struct sched_
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
@@ -1295,63 +1344,22 @@ void fastcall wake_up_new_task(task_t * 
 	int this_cpu, cpu;
 	runqueue_t *rq, *this_rq;
 #ifdef CONFIG_SMP
-	struct sched_domain *tmp, *sd = NULL;
-#endif
+	int new_cpu;
 
+	cpu = task_cpu(p);
+	preempt_disable();
+	new_cpu = sched_balance_self(cpu, SD_BALANCE_FORK);
+	preempt_enable();
+	if (new_cpu != cpu)
+		set_task_cpu(p, new_cpu);
+#endif
+	
+	cpu = task_cpu(p);
 	rq = task_rq_lock(p, &flags);
-	BUG_ON(p->state != TASK_RUNNING);
 	this_cpu = smp_processor_id();
-	cpu = task_cpu(p);
-
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
+	BUG_ON(p->state != TASK_RUNNING);
 
-#endif
 	/*
 	 * We decrease the sleep average of forking parents
 	 * and children as well, to keep max-interactive tasks
@@ -1699,59 +1707,17 @@ out:
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

--------------070908000103090003060807--

