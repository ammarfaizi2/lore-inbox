Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265090AbTFMBFk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 21:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265092AbTFMBFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 21:05:40 -0400
Received: from dp.samba.org ([66.70.73.150]:27365 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265090AbTFMBFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 21:05:20 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [PATCH] sched.c neatening and fixes.
Date: Fri, 13 Jun 2003 10:31:12 +1000
Message-Id: <20030613011906.A05742C261@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply: Ingo acked it.

Name: sched.c neatening
Author: Rusty Russell
Status: Tested on 2.5.70-bk16

D: 1) Fix the comments for the migration_thread.  A while back Ingo
D:    agreed they were exactly wrong, IIRC. 8).
D: 
D: 2) Changed spin_lock_irqsave to spin_lock_irq, since it's in a
D:    kernel thread.
D: 
D: 3) Don't repeat if the task has moved off the original CPU, just finish.
D:    This is because we are simply trying to push the task off this CPU:
D:    if it's already moved, great.  Currently we might theoretically move
D:    a task which is actually running on another CPU, which is v. bad.
D:
D: 4) Replace the __ffs(p->cpus_allowed) with any_online_cpu(), since
D:    that's what it's for, and __ffs() can give the wrong answer, eg. if
D:    there's no CPU 0.
D:
D: 5) Move the core functionality of migrate_task into a separate function,
D:    move_task_away, which I want for the hotplug CPU patch.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.70-bk16/kernel/sched.c working-2.5.70-bk16-sched-refactor/kernel/sched.c
--- linux-2.5.70-bk16/kernel/sched.c	2003-06-12 09:58:07.000000000 +1000
+++ working-2.5.70-bk16-sched-refactor/kernel/sched.c	2003-06-12 17:35:41.000000000 +1000
@@ -2297,7 +2297,7 @@ void set_cpus_allowed(task_t *p, unsigne
 	 * it is sufficient to simply update the task's cpu field.
 	 */
 	if (!p->array && !task_running(rq, p)) {
-		set_task_cpu(p, __ffs(p->cpus_allowed));
+		set_task_cpu(p, any_online_cpu(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
 		return;
 	}
@@ -2311,9 +2311,35 @@ void set_cpus_allowed(task_t *p, unsigne
 	wait_for_completion(&req.done);
 }
 
+/* Move (not current) task off this cpu, onto dest cpu. */
+static void move_task_away(struct task_struct *p, int dest_cpu)
+{
+	runqueue_t *rq_dest;
+	unsigned long flags;
+
+	rq_dest = cpu_rq(dest_cpu);
+
+	local_irq_save(flags);
+	double_rq_lock(this_rq(), rq_dest);
+	if (task_cpu(p) != smp_processor_id())
+		goto out; /* Already moved */
+
+	set_task_cpu(p, dest_cpu);
+	if (p->array) {
+		deactivate_task(p, this_rq());
+		activate_task(p, rq_dest);
+		if (p->prio < rq_dest->curr->prio)
+			resched_task(rq_dest->curr);
+	}
+ out:
+	double_rq_unlock(this_rq(), rq_dest);
+	local_irq_restore(flags);
+}
+
 /*
  * migration_thread - this is a highprio system thread that performs
- * thread migration by 'pulling' threads into the target runqueue.
+ * thread migration by bumping thread off CPU then 'pushing' onto
+ * another runqueue.
  */
 static int migration_thread(void * data)
 {
@@ -2327,8 +2353,9 @@ static int migration_thread(void * data)
 	set_fs(KERNEL_DS);
 
 	/*
-	 * Either we are running on the right CPU, or there's a
-	 * a migration thread on the target CPU, guaranteed.
+	 * Either we are running on the right CPU, or there's a a
+	 * migration thread on this CPU, guaranteed (we're started
+	 * serially).
 	 */
 	set_cpus_allowed(current, 1UL << cpu);
 
@@ -2338,51 +2365,23 @@ static int migration_thread(void * data)
 	rq->migration_thread = current;
 
 	for (;;) {
-		runqueue_t *rq_src, *rq_dest;
 		struct list_head *head;
-		int cpu_src, cpu_dest;
 		migration_req_t *req;
-		unsigned long flags;
-		task_t *p;
 
-		spin_lock_irqsave(&rq->lock, flags);
+		spin_lock_irq(&rq->lock);
 		head = &rq->migration_queue;
 		current->state = TASK_INTERRUPTIBLE;
 		if (list_empty(head)) {
-			spin_unlock_irqrestore(&rq->lock, flags);
+			spin_unlock_irq(&rq->lock);
 			schedule();
 			continue;
 		}
 		req = list_entry(head->next, migration_req_t, list);
 		list_del_init(head->next);
-		spin_unlock_irqrestore(&rq->lock, flags);
-
-		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
-		rq_dest = cpu_rq(cpu_dest);
-repeat:
-		cpu_src = task_cpu(p);
-		rq_src = cpu_rq(cpu_src);
-
-		local_irq_save(flags);
-		double_rq_lock(rq_src, rq_dest);
-		if (task_cpu(p) != cpu_src) {
-			double_rq_unlock(rq_src, rq_dest);
-			local_irq_restore(flags);
-			goto repeat;
-		}
-		if (rq_src == rq) {
-			set_task_cpu(p, cpu_dest);
-			if (p->array) {
-				deactivate_task(p, rq_src);
-				__activate_task(p, rq_dest);
-				if (p->prio < rq_dest->curr->prio)
-					resched_task(rq_dest->curr);
-			}
-		}
-		double_rq_unlock(rq_src, rq_dest);
-		local_irq_restore(flags);
+		spin_unlock_irq(&rq->lock);
 
+		move_task_away(req->task,
+			       any_online_cpu(req->task->cpus_allowed));
 		complete(&req->done);
 	}
 }
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

