Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264516AbTLTPYy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 10:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbTLTPYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 10:24:54 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:10387 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264516AbTLTPYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 10:24:33 -0500
Message-ID: <3FE469AA.3010808@cyberone.com.au>
Date: Sun, 21 Dec 2003 02:24:26 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] 2.6.0 sched affinity race
References: <3FE46885.2030905@cyberone.com.au> <3FE468BF.9000102@cyberone.com.au> <3FE468F5.7020501@cyberone.com.au> <3FE46930.1020504@cyberone.com.au>
In-Reply-To: <3FE46930.1020504@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------090501010302020205040600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090501010302020205040600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Prevents a race where sys_sched_setaffinity can race with sched_migrate_task
and cause sched_migrate_task to restore an invalid cpu mask.

(race can only happen on NUMA)


--------------090501010302020205040600
Content-Type: text/plain;
 name="sched-migrate-affinity-race.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-migrate-affinity-race.patch"


Prevents a race where sys_sched_setaffinity can race with sched_migrate_task
and cause sched_migrate_task to restore an invalid cpu mask.


 linux-2.6-npiggin/kernel/sched.c |   83 +++++++++++++++++++++++++++++----------
 1 files changed, 62 insertions(+), 21 deletions(-)

diff -puN kernel/sched.c~sched-migrate-affinity-race kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-migrate-affinity-race	2003-12-19 19:56:27.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2003-12-19 19:57:58.000000000 +1100
@@ -947,6 +947,9 @@ static inline void double_rq_unlock(runq
 }
 
 #ifdef CONFIG_NUMA
+
+static inline int __set_cpus_allowed(task_t *p, cpumask_t new_mask, unsigned long *flags);
+
 /*
  * If dest_cpu is allowed for this process, migrate the task to it.
  * This is accomplished by forcing the cpu_allowed mask to only
@@ -955,16 +958,37 @@ static inline void double_rq_unlock(runq
  */
 static void sched_migrate_task(task_t *p, int dest_cpu)
 {
-	cpumask_t old_mask;
+	runqueue_t *rq;
+	unsigned long flags;
+	cpumask_t old_mask, new_mask = cpumask_of_cpu(dest_cpu);
 
+	rq = task_rq_lock(p, &flags);
 	old_mask = p->cpus_allowed;
-	if (!cpu_isset(dest_cpu, old_mask))
+	if (!cpu_isset(dest_cpu, old_mask)) {
+		task_rq_unlock(rq, &flags);
 		return;
+	}
+
 	/* force the process onto the specified CPU */
-	set_cpus_allowed(p, cpumask_of_cpu(dest_cpu));
+	if (__set_cpus_allowed(p, new_mask, &flags) < 0)
+		return;
 
-	/* restore the cpus allowed mask */
-	set_cpus_allowed(p, old_mask);
+	rq = task_rq_lock(p, &flags);	/* __set_cpus_allowed unlocks rq */
+	if (unlikely(p->cpus_allowed != new_mask)) {
+		/*
+		 * We have raced with another set_cpus_allowed.
+		 * old_mask is invalid and we needn't move the
+		 * task back.
+		 */
+		task_rq_unlock(rq, &flags);
+		return;
+	}
+
+	/*
+	 * restore the cpus allowed mask. old_mask must be valid because
+	 * p->cpus_allowed is a subset of old_mask.
+	 */
+	WARN_ON(__set_cpus_allowed(p, old_mask, &flags) < 0);
 }
 
 /*
@@ -2603,31 +2627,27 @@ typedef struct {
 } migration_req_t;
 
 /*
- * Change a given task's CPU affinity. Migrate the thread to a
- * proper CPU and schedule it away if the CPU it's executing on
- * is removed from the allowed bitmask.
- *
- * NOTE: the caller must have a valid reference to the task, the
- * task must not exit() & deallocate itself prematurely.  The
- * call is not atomic; no spinlocks may be held.
+ * See comment for set_cpus_allowed. calling rules are different:
+ * the task's runqueue lock must be held, and __set_cpus_allowed
+ * will return with the runqueue unlocked.
  */
-int set_cpus_allowed(task_t *p, cpumask_t new_mask)
+static inline int __set_cpus_allowed(task_t *p, cpumask_t new_mask, unsigned long *flags)
 {
-	unsigned long flags;
 	migration_req_t req;
-	runqueue_t *rq;
+	runqueue_t *rq = task_rq(p);
 
-	if (any_online_cpu(new_mask) == NR_CPUS)
+	if (any_online_cpu(new_mask) == NR_CPUS) {
+		task_rq_unlock(rq, flags);
 		return -EINVAL;
+	}
 
-	rq = task_rq_lock(p, &flags);
 	p->cpus_allowed = new_mask;
 	/*
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the thread off to a proper CPU.
 	 */
 	if (cpu_isset(task_cpu(p), new_mask)) {
-		task_rq_unlock(rq, &flags);
+		task_rq_unlock(rq, flags);
 		return 0;
 	}
 	/*
@@ -2636,18 +2656,39 @@ int set_cpus_allowed(task_t *p, cpumask_
 	 */
 	if (!p->array && !task_running(rq, p)) {
 		set_task_cpu(p, any_online_cpu(p->cpus_allowed));
-		task_rq_unlock(rq, &flags);
+		task_rq_unlock(rq, flags);
 		return 0;
 	}
+
 	init_completion(&req.done);
 	req.task = p;
 	list_add(&req.list, &rq->migration_queue);
-	task_rq_unlock(rq, &flags);
+	task_rq_unlock(rq, flags);
 
 	wake_up_process(rq->migration_thread);
-
 	wait_for_completion(&req.done);
+
 	return 0;
+
+}
+
+/*
+ * Change a given task's CPU affinity. Migrate the thread to a
+ * proper CPU and schedule it away if the CPU it's executing on
+ * is removed from the allowed bitmask.
+ *
+ * NOTE: the caller must have a valid reference to the task, the
+ * task must not exit() & deallocate itself prematurely.  The
+ * call is not atomic; no spinlocks may be held.
+ */
+int set_cpus_allowed(task_t *p, cpumask_t new_mask)
+{
+	unsigned long flags;
+	runqueue_t *rq;
+
+	rq = task_rq_lock(p, &flags);
+
+	return __set_cpus_allowed(p, new_mask, &flags);
 }
 
 EXPORT_SYMBOL_GPL(set_cpus_allowed);

_

--------------090501010302020205040600--

