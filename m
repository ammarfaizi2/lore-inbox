Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265164AbUAWDeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 22:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUAWDeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 22:34:17 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:35458 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265164AbUAWDeI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 22:34:08 -0500
Message-ID: <4010954A.7090904@cyberone.com.au>
Date: Fri, 23 Jan 2004 14:30:18 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>
Subject: Re: [PATCH] Directed migration: Don't Change cpumask in sched_balance_exec()
References: <20040122082303.333432C08A@lists.samba.org>
In-Reply-To: <20040122082303.333432C08A@lists.samba.org>
Content-Type: multipart/mixed;
 boundary="------------010404090108080104050703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010404090108080104050703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Rusty Russell wrote:

>In message <400F5D71.7010702@cyberone.com.au> you write:
>
>>Hi Rusty,
>>Yes I do like it. It hass bothered me that the visible cpus_allowed
>>mask is changed in order to do the balancing. Thanks Rusty. Ingo?
>>
>
>Note that I should have used for_each_online_cpu, not for_each_cpu,
>since we explicitly don't want to look at offline cpus.
>
>New patch with one-line change below...
>Rusty.
>

I'm just reviewing this and porting it to -mm now. I have a few
comments to start with.

CPUs have (I think) always been int in sched.c, you're using unsigned
int. No big deal, but I'll change them to int.

My patches introduce a "move_tasks" function, so I'll rename yours
to migrate_task and __migrate_task.

Your version of move_task (now migrate_task) never actually used dest_cpu
unless I am seeing things. Fixed.

Hows that?


--------------010404090108080104050703
Content-Type: text/plain;
 name="sched-directed-migration.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-directed-migration.patch"


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


 linux-2.6-npiggin/kernel/sched.c |   65 +++++++++++++++++++--------------------
 1 files changed, 32 insertions(+), 33 deletions(-)

diff -puN kernel/sched.c~sched-directed-migration kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-directed-migration	2004-01-23 14:09:22.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2004-01-23 14:27:31.000000000 +1100
@@ -521,37 +521,30 @@ inline int task_curr(task_t *p)
 typedef struct {
 	struct list_head list;
 	task_t *task;
+	int dest_cpu;
 	struct completion done;
 } migration_req_t;
 
 /*
- * The task's runqueue lock must be held, and the new mask must be valid.
+ * The task's runqueue lock must be held.
  * Returns true if you have to wait for migration thread.
  */
-static int __set_cpus_allowed(task_t *p, cpumask_t new_mask,
-				migration_req_t *req)
+static int migrate_task(task_t *p, int dest_cpu, migration_req_t *req)
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
 	 */
 	if (!p->array && !task_running(rq, p)) {
-		set_task_cpu(p, any_online_cpu(p->cpus_allowed));
+		set_task_cpu(p, dest_cpu);
 		return 0;
 	}
 
 	init_completion(&req->done);
 	req->task = p;
+	req->dest_cpu = dest_cpu;
 	list_add(&req->list, &rq->migration_queue);
 	return 1;
 }
@@ -1041,7 +1034,7 @@ unsigned long nr_running(void)
 {
 	unsigned long i, sum = 0;
 
-	for (i = 0; i < NR_CPUS; i++)
+	for_each_cpu(i)
 		sum += cpu_rq(i)->nr_running;
 
 	return sum;
@@ -1131,28 +1124,18 @@ static void sched_migrate_task(task_t *p
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
+	if (migrate_task(p, dest_cpu, &req)) {
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
@@ -1169,7 +1152,7 @@ static int sched_best_cpu(struct task_st
 	best_cpu = this_cpu = task_cpu(p);
 	min_load = INT_MAX;
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_online_cpu(i) {
 		unsigned long load;
 		if (!cpu_isset(i, domain->span))
 			continue;
@@ -3011,7 +2994,12 @@ int set_cpus_allowed(task_t *p, cpumask_
 		goto out;
 	}
 
-	if (__set_cpus_allowed(p, new_mask, &req)) {
+	p->cpus_allowed = new_mask;
+	/* Can the task run on the task's current CPU? If so, we're done */
+	if (cpu_isset(task_cpu(p), new_mask))
+		goto out;
+
+	if (migrate_task(p, any_online_cpu(new_mask), &req)) {
 		/* Need help from migration thread: drop lock and wait. */
 		task_rq_unlock(rq, &flags);
 		wake_up_process(rq->migration_thread);
@@ -3025,8 +3013,16 @@ out:
 
 EXPORT_SYMBOL_GPL(set_cpus_allowed);
 
-/* Move (not current) task off this cpu, onto dest cpu. */
-static void move_task_away(struct task_struct *p, int dest_cpu)
+/*
+ * Move (not current) task off this cpu, onto dest cpu.  We're doing
+ * this because either it can't run here any more (set_cpus_allowed()
+ * away from this CPU, or CPU going down), or because we're
+ * attempting to rebalance this task on exec (sched_balance_exec).
+ *
+ * So we race with normal scheduler movements, but that's OK, as long
+ * as the task is no longer on this CPU.
+ */
+static void __migrate_task(struct task_struct *p, int dest_cpu)
 {
 	runqueue_t *rq_dest;
 	unsigned long flags;
@@ -3035,8 +3031,12 @@ static void move_task_away(struct task_s
 
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
@@ -3096,8 +3096,7 @@ static int migration_thread(void * data)
 		list_del_init(head->next);
 		spin_unlock_irq(&rq->lock);
 
-		move_task_away(req->task,
-			       any_online_cpu(req->task->cpus_allowed));
+		__migrate_task(req->task, req->dest_cpu);
 		complete(&req->done);
 	}
 	return 0;

_

--------------010404090108080104050703--

