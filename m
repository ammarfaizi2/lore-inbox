Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUAVDbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 22:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266159AbUAVD3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 22:29:46 -0500
Received: from dp.samba.org ([66.70.73.150]:8684 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266163AbUAVD30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 22:29:26 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: [PATCH] Directed migration: Don't Change cpumask in sched_balance_exec()
Date: Thu, 22 Jan 2004 13:58:47 +1100
Message-Id: <20040122032941.3377D2C26B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

	This is against 2.6.2-rc1, but with some merging should work
against -mm.  I think you'll like this approach.

Feedback welcome!
Rusty.

Name: Directed Migration: Don't Change cpumask in sched_balance_exec()
Author: Rusty Russell
Status: Experimental

D: The current sched_balance_exec() sets the task's cpus_allowed mask
D: temporarily to move it to a different CPU.  This has several
D: issues, including the fact that a task will see its affinity at a
D: bogus value.
D: 
D: So we change the migration_req_t to explicitly specify a
D: destination CPU, rather than the migration thread deriving it from
D: cpus_allowed.  If the requested CPU is no longer valid (racing with
D: another set_cpus_allowed, say), it can be ignored: if the task is
D: not allowed on this CPU, there will be another migration request
D: pending.
D: 
D: This change allows sched_balance_exec() to tell the migration
D: thread what to do without changing the cpus_allowed mask.
D: 
D: So we rename __set_cpus_allowed() to move_task(), as the
D: cpus_allowed mask is now set by the caller.  And move_task_away(),
D: which the migration thread uses to actually perform the move, is
D: renamed __move_task().
D: 
D: I also ignore offline CPUs in sched_best_cpu(), so sched_migrate_task()
D: doesn't need to check for offline CPUs.
D: 
D: Alterior motive: this approach also plays well with CPU Hotplug.
D: Previously that patch might have seen a task with cpus_allowed only
D: containing the dying CPU (temporarily due to sched_balance_exec) and
D: forcibly reset it to all cpus, which might be wrong.  The other approach
D: is to hold the cpucontrol sem around sched_balance_exec(), which is
D: too much of a bottleneck.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16376-linux-2.6.2-rc1/kernel/sched.c .16376-linux-2.6.2-rc1.updated/kernel/sched.c
--- .16376-linux-2.6.2-rc1/kernel/sched.c	2004-01-21 16:19:08.000000000 +1100
+++ .16376-linux-2.6.2-rc1.updated/kernel/sched.c	2004-01-22 13:34:50.000000000 +1100
@@ -543,26 +543,18 @@ inline int task_curr(task_t *p)
 typedef struct {
 	struct list_head list;
 	task_t *task;
+	unsigned int dest_cpu;
 	struct completion done;
 } migration_req_t;
 
 /*
- * The task's runqueue lock must be held, and the new mask must be valid.
+ * The task's runqueue lock must be held.
  * Returns true if you have to wait for migration thread.
  */
-static int __set_cpus_allowed(task_t *p, cpumask_t new_mask,
-				migration_req_t *req)
+static int move_task(task_t *p, unsigned int dest_cpu, migration_req_t *req)
 {
 	runqueue_t *rq = task_rq(p);
 
-	p->cpus_allowed = new_mask;
-	/*
-	 * Can the task run on the task's current CPU? If not then
-	 * migrate the thread off to a proper CPU.
-	 */
-	if (cpu_isset(task_cpu(p), new_mask))
-		return 0;
-
 	/*
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
@@ -1011,28 +1003,18 @@ static void sched_migrate_task(task_t *p
 	runqueue_t *rq;
 	migration_req_t req;
 	unsigned long flags;
-	cpumask_t old_mask, new_mask = cpumask_of_cpu(dest_cpu);
 
 	rq = task_rq_lock(p, &flags);
-	old_mask = p->cpus_allowed;
-	if (!cpu_isset(dest_cpu, old_mask) || !cpu_online(dest_cpu))
+	if (!cpu_isset(dest_cpu, p->cpus_allowed))
 		goto out;
 
 	/* force the process onto the specified CPU */
-	if (__set_cpus_allowed(p, new_mask, &req)) {
+	if (move_task(p, dest_cpu, &req)) {
 		/* Need to wait for migration thread. */
 		task_rq_unlock(rq, &flags);
 		wake_up_process(rq->migration_thread);
 		wait_for_completion(&req.done);
-
-		/* If we raced with sys_sched_setaffinity, don't
-		 * restore mask. */
-		rq = task_rq_lock(p, &flags);
-		if (likely(cpus_equal(p->cpus_allowed, new_mask))) {
-			/* Restore old mask: won't need migration
-			 * thread, since current cpu is allowed. */
-			BUG_ON(__set_cpus_allowed(p, old_mask, NULL));
-		}
+		return;
 	}
 out:
 	task_rq_unlock(rq, &flags);
@@ -1068,7 +1050,7 @@ static int sched_best_cpu(struct task_st
 
 	minload = 10000000;
 	cpumask = node_to_cpumask(node);
-	for (i = 0; i < NR_CPUS; ++i) {
+	for_each_cpu(i) {
 		if (!cpu_isset(i, cpumask))
 			continue;
 		if (cpu_rq(i)->nr_running < minload) {
@@ -2705,7 +2687,12 @@ int set_cpus_allowed(task_t *p, cpumask_
 		goto out;
 	}
 
-	if (__set_cpus_allowed(p, new_mask, &req)) {
+	p->cpus_allowed = new_mask;
+	/* Can the task run on the task's current CPU? If so, we're done */
+	if (cpu_isset(task_cpu(p), new_mask))
+		goto out;
+
+	if (move_task(p, any_online_cpu(new_mask), &req)) {
 		/* Need help from migration thread: drop lock and wait. */
 		task_rq_unlock(rq, &flags);
 		wake_up_process(rq->migration_thread);
@@ -2719,8 +2706,15 @@ out:
 
 EXPORT_SYMBOL_GPL(set_cpus_allowed);
 
-/* Move (not current) task off this cpu, onto dest cpu. */
-static void move_task_away(struct task_struct *p, int dest_cpu)
+/* Move (not current) task off this cpu, onto dest cpu.  We're doing
+   this because either it can't run here any more (set_cpus_allowed()
+   away from this CPU, or CPU going down), or because we're
+   attempting to rebalance this task on exec (sched_balance_exec).
+
+   So we race with normal scheduler movements, but that's OK, as long
+   as the task is no longer on this CPU.
+ */
+static void __move_task(struct task_struct *p, int dest_cpu)
 {
 	runqueue_t *rq_dest;
 	unsigned long flags;
@@ -2729,8 +2723,12 @@ static void move_task_away(struct task_s
 
 	local_irq_save(flags);
 	double_rq_lock(this_rq(), rq_dest);
+	/* Already moved. */
 	if (task_cpu(p) != smp_processor_id())
-		goto out; /* Already moved */
+		goto out;
+	/* Affinity changed (again). */
+	if (!cpu_isset(dest_cpu, p->cpus_allowed))
+		goto out;
 
 	set_task_cpu(p, dest_cpu);
 	if (p->array) {
@@ -2800,8 +2798,7 @@ static int migration_thread(void * data)
 		list_del_init(head->next);
 		spin_unlock_irq(&rq->lock);
 
-		move_task_away(req->task,
-			       any_online_cpu(req->task->cpus_allowed));
+		__move_task(req->task, req->dest_cpu);
 		complete(&req->done);
 	}
 }


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
