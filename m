Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbUDFB1r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 21:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbUDFB1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 21:27:47 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:49537 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262750AbUDFB1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 21:27:33 -0400
Message-ID: <4072077F.7060305@yahoo.com.au>
Date: Tue, 06 Apr 2004 11:27:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: rusty@au1.ibm.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to
 CPU_DEAD handling
References: <20040405121824.GA8497@in.ibm.com> <4071F9C5.2030002@yahoo.com.au> <20040406011508.GA5077@in.ibm.com>
In-Reply-To: <20040406011508.GA5077@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------070707040303010504090701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070707040303010504090701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Srivatsa Vaddagiri wrote:
> On Tue, Apr 06, 2004 at 10:28:53AM +1000, Nick Piggin wrote:
> 
>>First of all, if you're proposing this stuff for inclusion, you
>>should port it to the -mm tree, because I don't think Andrew
>>will want any other scheduler work going in just now. It wouldn't
>>be too hard.
> 
> 
> Will send out today a patch against latest -mm tree!
> 
> 
>>I think my stuff is a bit orthogonal to what you're attempting.
>>And they should probably work well together. My "lazy migrate"
>>patch means the tasklist lock does not need to be held at all,
>>only the dying runqueue's lock.
> 
> 
> Is there some place where I can download your patch (or is it in -mm tree)?
> 
> 

I have attached it (against 2.6.5-mm1). I haven't actually tested it
yet because I haven't got around to finding and using the i386 test
code yet.

It also contains a copule of cleanups:
rename double_lock_balance to second_rq_lock, and make migrate_all_tasks
static, and have the hotplug code call sched_cpu_stop.

Comments would be welcome.

Nick

--------------070707040303010504090701
Content-Type: text/x-patch;
 name="hotplugcpu-lazy-migrate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hotplugcpu-lazy-migrate.patch"

 linux-2.6-npiggin/include/linux/sched.h |    4 
 linux-2.6-npiggin/kernel/cpu.c          |    9 +
 linux-2.6-npiggin/kernel/sched.c        |  178 ++++++++++++++++++++------------
 3 files changed, 121 insertions(+), 70 deletions(-)

diff -puN kernel/sched.c~hotplugcpu-lazy-migrate kernel/sched.c
--- linux-2.6/kernel/sched.c~hotplugcpu-lazy-migrate	2004-04-06 11:16:31.000000000 +1000
+++ linux-2.6-npiggin/kernel/sched.c	2004-04-06 11:23:30.000000000 +1000
@@ -41,6 +41,7 @@
 #include <linux/cpu.h>
 #include <linux/percpu.h>
 #include <linux/kthread.h>
+#include <linux/list.h>
 
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
@@ -710,6 +711,53 @@ static inline int wake_idle(int cpu, tas
 }
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+/*
+ * go_away: choose a new CPU for tsk if the one it is on has gone
+ * offline. Updates cpus_allowed affinity if it absolutely has to.
+ * Returns chosen destination CPU.
+ */
+static int go_away(struct task_struct *tsk)
+{
+	cpumask_t mask;
+	int cpu, node, dest_cpu;
+
+	/*
+	 * watch out for per node tasks, let's stay on this node.
+	 * TODO turn this into a sched_domain flag - np
+	 */
+	cpu = task_cpu(tsk);
+	node = cpu_to_node(cpu);
+	mask = node_to_cpumask(node);
+
+	/*
+	 * Figure out where this task should go (attempt to keep it on-node),
+	 * and check if it can be migrated as-is.  NOTE that kernel threads
+	 * bound to more than one online cpu will be migrated.
+	 */
+	cpus_and(mask, mask, tsk->cpus_allowed);
+	dest_cpu = any_online_cpu(mask);
+	if (dest_cpu == NR_CPUS)
+		dest_cpu = any_online_cpu(tsk->cpus_allowed);
+	if (dest_cpu == NR_CPUS) {
+		cpus_clear(tsk->cpus_allowed);
+		cpus_complement(tsk->cpus_allowed);
+		dest_cpu = any_online_cpu(tsk->cpus_allowed);
+
+		/*
+		 * Don't tell them about moving exiting tasks or kernel
+		 * threads (both mm NULL), since they never leave kernel.
+		 */
+		if (tsk->mm && printk_ratelimit()) {
+			printk(KERN_INFO "process %d (%s) no "
+				       "longer affine to cpu%d\n",
+				       tsk->pid, tsk->comm, task_cpu(tsk));
+		}
+	}
+	return dest_cpu;
+}
+#endif
+
 /***
  * try_to_wake_up - wake up a thread
  * @p: the to-be-woken-up thread
@@ -748,11 +796,18 @@ static int try_to_wake_up(task_t * p, un
 	this_cpu = smp_processor_id();
 
 #ifdef CONFIG_SMP
-	if (unlikely(task_running(rq, p) || cpu_is_offline(this_cpu)))
+	if (unlikely(task_running(rq, p))
 		goto out_activate;
 
 	new_cpu = cpu;
 
+#ifdef CONFIG_HOTPLUG_CPU
+	if (unlikely(cpu_is_offline(cpu))) {
+		/* Must lazy-migrate off this CPU */
+		goto out_set_cpu;
+	}
+#endif
+
 	if (cpu == this_cpu || unlikely(!cpu_isset(this_cpu, p->cpus_allowed)))
 		goto out_set_cpu;
 
@@ -1257,17 +1312,17 @@ out:
 #endif /* CONFIG_NUMA */
 
 /*
- * double_lock_balance - lock the busiest runqueue, this_rq is locked already.
+ * second_rq_lock - lock the busiest runqueue, this_rq is locked already.
  */
-static void double_lock_balance(runqueue_t *this_rq, runqueue_t *busiest)
+static void second_rq_lock(runqueue_t *locked, runqueue_t *to_lock)
 {
-	if (unlikely(!spin_trylock(&busiest->lock))) {
-		if (busiest < this_rq) {
-			spin_unlock(&this_rq->lock);
-			spin_lock(&busiest->lock);
-			spin_lock(&this_rq->lock);
+	if (unlikely(!spin_trylock(&to_lock->lock))) {
+		if (to_lock < locked) {
+			spin_unlock(&locked->lock);
+			spin_lock(&to_lock->lock);
+			spin_lock(&locked->lock);
 		} else
-			spin_lock(&busiest->lock);
+			spin_lock(&to_lock->lock);
 	}
 }
 
@@ -1592,7 +1647,7 @@ static int load_balance(int this_cpu, ru
 	}
 
 	/* Attempt to move tasks */
-	double_lock_balance(this_rq, busiest);
+	second_rq_lock(this_rq, busiest);
 
 	nr_moved = move_tasks(this_rq, this_cpu, busiest, imbalance, sd, idle);
 	spin_unlock(&this_rq->lock);
@@ -1662,7 +1717,7 @@ static int load_balance_newidle(int this
 		goto out;
 
 	/* Attempt to move tasks */
-	double_lock_balance(this_rq, busiest);
+	second_rq_lock(this_rq, busiest);
 
 	nr_moved = move_tasks(this_rq, this_cpu, busiest,
 					imbalance, sd, NEWLY_IDLE);
@@ -1744,7 +1799,7 @@ static void active_load_balance(runqueue
  		}
 
 		rq = cpu_rq(push_cpu);
-		double_lock_balance(busiest, rq);
+		second_rq_lock(busiest, rq);
 		move_tasks(rq, push_cpu, busiest, 1, sd, IDLE);
 		spin_unlock(&rq->lock);
 next_group:
@@ -3221,6 +3276,8 @@ EXPORT_SYMBOL_GPL(set_cpus_allowed);
  *
  * So we race with normal scheduler movements, but that's OK, as long
  * as the task is no longer on this CPU.
+ *
+ * Called with this_rq locked
  */
 static void __migrate_task(struct task_struct *p, int dest_cpu)
 {
@@ -3228,7 +3285,7 @@ static void __migrate_task(struct task_s
 
 	rq_dest = cpu_rq(dest_cpu);
 
-	double_rq_lock(this_rq(), rq_dest);
+	second_rq_lock(this_rq(), rq_dest);
 	/* Already moved. */
 	if (task_cpu(p) != smp_processor_id())
 		goto out;
@@ -3246,7 +3303,7 @@ static void __migrate_task(struct task_s
 	p->timestamp = rq_dest->timestamp_last_tick;
 
 out:
-	double_rq_unlock(this_rq(), rq_dest);
+	spin_unlock(&rq_dest->lock);
 }
 
 /*
@@ -3286,8 +3343,6 @@ static int migration_thread(void * data)
 		req = list_entry(head->next, migration_req_t, list);
 		list_del_init(head->next);
 
-		spin_unlock(&rq->lock);
-
 		if (req->type == REQ_MOVE_TASK) {
 			__migrate_task(req->task, req->dest_cpu);
 		} else if (req->type == REQ_SET_DOMAIN) {
@@ -3296,7 +3351,7 @@ static int migration_thread(void * data)
 			WARN_ON(1);
 		}
 
-		local_irq_enable();
+		spin_unlock_irq(&rq->lock);
 
 		complete(&req->done);
 	}
@@ -3304,60 +3359,53 @@ static int migration_thread(void * data)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-/* migrate_all_tasks - function to migrate all the tasks from the
- * current cpu caller must have already scheduled this to the target
- * cpu via set_cpus_allowed.  Machine is stopped.  */
-void migrate_all_tasks(void)
-{
-	struct task_struct *tsk, *t;
-	int dest_cpu, src_cpu;
-	unsigned int node;
-
-	/* We're nailed to this CPU. */
-	src_cpu = smp_processor_id();
-
-	/* Not required, but here for neatness. */
-	write_lock(&tasklist_lock);
-
-	/* watch out for per node tasks, let's stay on this node */
-	node = cpu_to_node(src_cpu);
-
-	do_each_thread(t, tsk) {
-		cpumask_t mask;
-		if (tsk == current)
-			continue;
+/*
+ * migrate_all_tasks - function to migrate all the tasks from the
+ * current CPU. Current CPU must be marked offline.
+ */
+static void migrate_all_tasks(void)
+{
+	runqueue_t *rq;
+	int i, j;
+	int dest_cpu;
 
-		if (task_cpu(tsk) != src_cpu)
-			continue;
+	rq = this_rq_lock();
 
-		/* Figure out where this task should go (attempting to
-		 * keep it on-node), and check if it can be migrated
-		 * as-is.  NOTE that kernel threads bound to more than
-		 * one online cpu will be migrated. */
-		mask = node_to_cpumask(node);
-		cpus_and(mask, mask, tsk->cpus_allowed);
-		dest_cpu = any_online_cpu(mask);
-		if (dest_cpu == NR_CPUS)
-			dest_cpu = any_online_cpu(tsk->cpus_allowed);
-		if (dest_cpu == NR_CPUS) {
-			cpus_clear(tsk->cpus_allowed);
-			cpus_complement(tsk->cpus_allowed);
-			dest_cpu = any_online_cpu(tsk->cpus_allowed);
-
-			/* Don't tell them about moving exiting tasks
-			   or kernel threads (both mm NULL), since
-			   they never leave kernel. */
-			if (tsk->mm && printk_ratelimit())
-				printk(KERN_INFO "process %d (%s) no "
-				       "longer affine to cpu%d\n",
-				       tsk->pid, tsk->comm, src_cpu);
+again:
+	/* Traverse the runqueue */
+	for (i = 0; i < 2; i++) {
+		for (j = 0; j < MAX_PRIO; j++) {
+			struct task_struct *tsk, *tmp;
+			list_for_each_entry_safe(tsk, tmp,
+					&rq->arrays[i].queue[j], run_list) {
+				if (tsk == current)
+					continue;
+
+				dest_cpu = go_away(tsk);
+				__migrate_task(tsk, dest_cpu);
+			}
 		}
+	}
 
-		__migrate_task(tsk, dest_cpu);
-	} while_each_thread(t, tsk);
+	/* __migrate_task can drop the lock (via second_rq_lock).
+	 * Recheck and go again if we're not the only ones left. */
+	if (rq->nr_running > 1)
+		goto again;
 
-	write_unlock(&tasklist_lock);
+	rq_unlock(rq);
 }
+
+/*
+ * sched_cpu_stop is called by CPU hotplug code when it intends to take
+ * the current CPU down. It must be called after the CPU has been marked
+ * offline.
+ */
+void sched_cpu_stop(void)
+{
+	/* At the moment all we need to do is migrate tasks off */
+	migrate_all_tasks();
+}
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 /*
diff -puN kernel/cpu.c~hotplugcpu-lazy-migrate kernel/cpu.c
--- linux-2.6/kernel/cpu.c~hotplugcpu-lazy-migrate	2004-04-06 11:16:31.000000000 +1000
+++ linux-2.6-npiggin/kernel/cpu.c	2004-04-06 11:16:31.000000000 +1000
@@ -91,13 +91,16 @@ static int take_cpu_down(void *unused)
 	/* Take offline: makes arch_cpu_down somewhat easier. */
 	cpu_clear(smp_processor_id(), cpu_online_map);
 
+	/* Ensure all other CPUs see that we're offline */
+	wmb();
+
+	/* Everyone else gets kicked off. */
+	sched_cpu_stop();
+
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err = __cpu_disable();
 	if (err < 0)
 		cpu_set(smp_processor_id(), cpu_online_map);
-	else
-		/* Everyone else gets kicked off. */
-		migrate_all_tasks();
 
 	return err;
 }
diff -puN include/linux/sched.h~hotplugcpu-lazy-migrate include/linux/sched.h
--- linux-2.6/include/linux/sched.h~hotplugcpu-lazy-migrate	2004-04-06 11:16:31.000000000 +1000
+++ linux-2.6-npiggin/include/linux/sched.h	2004-04-06 11:16:31.000000000 +1000
@@ -664,8 +664,8 @@ extern void sched_balance_exec(void);
 #define sched_balance_exec()   {}
 #endif
 
-/* Move tasks off this (offline) CPU onto another. */
-extern void migrate_all_tasks(void);
+/* sched_cpu_stop must be called after the CPU is marked offline */
+extern void sched_cpu_stop(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);

_

--------------070707040303010504090701--
