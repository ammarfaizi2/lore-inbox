Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUIIT5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUIIT5A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUIITyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:54:38 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:28625 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264795AbUIITtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:49:46 -0400
Date: Thu, 9 Sep 2004 14:45:58 -0500
From: Jack Steiner <steiner@sgi.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - Fix potential race condition in wake_up_forked_process()
Message-ID: <20040909194558.GA28653@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There appears to be a tiny (microscopic) timing hole in 
wake_up_forked_process(). It is possible that a load_balancing
application could change cpus_allowed on a task as it
is being forked. Unlikely, but it can happen, especially if preemption 
is enabled.

If the new mask does not contain the cpu of the parent process, the
child will be placed on a cpu that is not in it's cpus_allowed mask.

Here is a fix:

	- patch 1 simply moves wake_up_forked_process() so that
	  it appears further down in the file. This is needed
	  so that double_rq_lock() can be called. An alternate
	  solution would be to move double_rq_lock() but placing
	  wake_up_forked_process() & wake_up_forked_thread()
	  together seemed preferable. 

	- patch 2 is the real change. After obtaining the runqueue lock,
	  the code verifies that the new process's cpu
	  is in cpus_allowed. (The new code was cloned from 
	  wake_up_forked_thread()).

Patch is against 2.6.9-rc1

Signed-off-by: Jack Steiner <steiner@sgi.com>

Fix race in wake_up_forked_process(). Cpus_allowed may have
been changed by sched_setaffinity() while the process was 
being forked.



Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2004-09-09 10:11:12.000000000 -0500
+++ linux/kernel/sched.c	2004-09-09 10:47:01.000000000 -0500
@@ -920,47 +920,6 @@ void fastcall sched_fork(task_t *p)
 }
 
 /*
- * wake_up_forked_process - wake up a freshly forked process.
- *
- * This function will do some initial scheduler statistics housekeeping
- * that must be done for every newly created process.
- */
-void fastcall wake_up_forked_process(task_t * p)
-{
-	unsigned long flags;
-	runqueue_t *rq = task_rq_lock(current, &flags);
-
-	BUG_ON(p->state != TASK_RUNNING);
-
-	/*
-	 * We decrease the sleep average of forking parents
-	 * and children as well, to keep max-interactive tasks
-	 * from forking tasks that are max-interactive.
-	 */
-	current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
-		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
-
-	p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
-		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
-
-	p->interactive_credit = 0;
-
-	p->prio = effective_prio(p);
-	set_task_cpu(p, smp_processor_id());
-
-	if (unlikely(!current->array))
-		__activate_task(p, rq);
-	else {
-		p->prio = current->prio;
-		list_add_tail(&p->run_list, &current->run_list);
-		p->array = current->array;
-		p->array->nr_active++;
-		rq->nr_running++;
-	}
-	task_rq_unlock(rq, &flags);
-}
-
-/*
  * Potentially available exiting-child timeslices are
  * retrieved here - this way the parent does not get
  * penalized for creating too many threads.
@@ -1211,6 +1170,47 @@ static int find_idlest_cpu(struct task_s
 }
 
 /*
+ * wake_up_forked_process - wake up a freshly forked process.
+ *
+ * This function will do some initial scheduler statistics housekeeping
+ * that must be done for every newly created process.
+ */
+void fastcall wake_up_forked_process(task_t * p)
+{
+	unsigned long flags;
+	runqueue_t *rq = task_rq_lock(current, &flags);
+
+	BUG_ON(p->state != TASK_RUNNING);
+
+	/*
+	 * We decrease the sleep average of forking parents
+	 * and children as well, to keep max-interactive tasks
+	 * from forking tasks that are max-interactive.
+	 */
+	current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
+		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
+
+	p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
+		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
+
+	p->interactive_credit = 0;
+
+	p->prio = effective_prio(p);
+	set_task_cpu(p, smp_processor_id());
+
+	if (unlikely(!current->array))
+		__activate_task(p, rq);
+	else {
+		p->prio = current->prio;
+		list_add_tail(&p->run_list, &current->run_list);
+		p->array = current->array;
+		p->array->nr_active++;
+		rq->nr_running++;
+	}
+	task_rq_unlock(rq, &flags);
+}
+
+/*
  * wake_up_forked_thread - wake up a freshly forked thread.
  *
  * This function will do some initial scheduler statistics housekeeping





Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2004-09-09 10:47:01.000000000 -0500
+++ linux/kernel/sched.c	2004-09-09 10:50:49.000000000 -0500
@@ -1178,10 +1178,26 @@ static int find_idlest_cpu(struct task_s
 void fastcall wake_up_forked_process(task_t * p)
 {
 	unsigned long flags;
-	runqueue_t *rq = task_rq_lock(current, &flags);
+	int this_cpu = get_cpu(), cpu = task_cpu(p);
+	runqueue_t *this_rq = cpu_rq(this_cpu), *rq;
 
 	BUG_ON(p->state != TASK_RUNNING);
 
+	local_irq_save(flags);
+lock_again:
+	rq = cpu_rq(cpu);
+	double_rq_lock(this_rq, rq);
+
+	/*
+	 * We picked the cpu unlocked. In theory, the cpus_allowed
+	 * mask could have changed.
+	 */
+	if (unlikely(!cpu_isset(cpu, p->cpus_allowed))) {
+		double_rq_unlock(this_rq, rq);
+		cpu = any_online_cpu(p->cpus_allowed);
+		goto lock_again;
+	}
+
 	/*
 	 * We decrease the sleep average of forking parents
 	 * and children as well, to keep max-interactive tasks
@@ -1196,20 +1212,25 @@ void fastcall wake_up_forked_process(tas
 	p->interactive_credit = 0;
 
 	p->prio = effective_prio(p);
-	set_task_cpu(p, smp_processor_id());
+	set_task_cpu(p, cpu);
 
-	if (unlikely(!current->array))
+	if (unlikely(!p->array)) {
 		__activate_task(p, rq);
-	else {
+		if (TASK_PREEMPTS_CURR(p, rq))
+			resched_task(rq->curr);
+	} else {
 		p->prio = current->prio;
 		list_add_tail(&p->run_list, &current->run_list);
 		p->array = current->array;
 		p->array->nr_active++;
 		rq->nr_running++;
 	}
-	task_rq_unlock(rq, &flags);
+	double_rq_unlock(this_rq, rq);
+	local_irq_restore(flags);
+	put_cpu();
 }
 
+
 /*
  * wake_up_forked_thread - wake up a freshly forked thread.
  *
-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


