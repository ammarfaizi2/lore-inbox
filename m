Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262980AbVDBC6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbVDBC6g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 21:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbVDBC6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 21:58:36 -0500
Received: from fmr22.intel.com ([143.183.121.14]:33746 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262980AbVDBC6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 21:58:22 -0500
Date: Fri, 1 Apr 2005 18:58:12 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: mingo@elte.hu, nickpiggin@yahoo.com.au
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: [patch] sched: improve pinned task handling again!
Message-ID: <20050401185812.A5598@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  Wednesday, February 23, 2005 11:17 PM Nick Piggin wrote:
>John Hawkes explained the problem best:
>  A large number of processes that are pinned to a single CPU results
>  in every other CPU's load_balance() seeing this overloaded CPU as
>  "busiest", yet move_tasks() never finds a task to pull-migrate.  This
>  condition occurs during module unload, but can also occur as a
>  denial-of-service using sys_sched_setaffinity().  Several hundred
>  CPUs performing this fruitless load_balance() will livelock on the
>  busiest CPU's runqueue lock.  A smaller number of CPUs will livelock
>  if the pinned task count gets high.
>	
>Expanding slightly on John's patch, this one attempts to work out
>whether the balancing failure has been due to too many tasks pinned
>on the runqueue. This allows it to be basically invisible to the
>regular blancing paths (ie. when there are no pinned tasks). We can
>use this extra knowledge to shut down the balancing faster, and ensure
>the migration threads don't start running which is another problem
>observed in the wild.

This time Ken Chen brought up this issue -- No it has nothing to do with 
industry db benchmark ;-) 

Even with the above mentioned Nick's patch in -mm, I see system livelock's 
if for example I have 7000 processes pinned onto one cpu (this is on the 
fastest 8-way system I have access to). I am sure there will be other 
systems where this problem can be encountered even with lesser pin count.

We tried to fix this issue but as you know there is no good mechanism
in fixing this issue with out letting the regular paths know about this.

Our proposed solution is appended and we tried to minimize the affect on 
fast path.  It builds up on Nick's patch and once this situation is detected,
it will not do any more move_tasks as long as busiest cpu is always the 
same cpu and the queued processes on busiest_cpu, their
cpu affinity remain same(found out by runqueue's "generation_num")

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- linux-2.6.12-rc1-mm4/kernel/sched.c	2005-04-01 10:07:24.183605296 -0800
+++ linux/kernel/sched.c	2005-04-01 18:40:21.120799664 -0800
@@ -205,9 +205,16 @@
 	/*
 	 * nr_running and cpu_load should be in the same cacheline because
 	 * remote CPUs use both these fields when doing load calculation.
+	 * generation_num also needs to be in the same cacheline as nr_running.
 	 */
-	unsigned long nr_running;
+	unsigned int nr_running;
 #ifdef CONFIG_SMP
+	/*
+	 * generation_num gets incremented in the following cases
+	 * 	- a process moves to this runqueue
+	 *	- cpu affinity of a process on this runqueue is changed
+	 */
+ 	unsigned int generation_num;
 	unsigned long cpu_load[3];
 #endif
 	unsigned long long nr_switches;
@@ -237,6 +244,8 @@
 
 	task_t *migration_thread;
 	struct list_head migration_queue;
+	runqueue_t *busiest_rq;
+	unsigned int busiest_generation_num;
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
@@ -598,6 +607,9 @@
 {
 	enqueue_task(p, rq->active);
 	rq->nr_running++;
+#ifdef CONFIG_SMP
+	rq->generation_num++;
+#endif
 }
 
 /*
@@ -1670,6 +1682,7 @@
 	src_rq->nr_running--;
 	set_task_cpu(p, this_cpu);
 	this_rq->nr_running++;
+	this_rq->generation_num++;
 	enqueue_task(p, this_array);
 	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
@@ -1998,6 +2011,14 @@
 
 	schedstat_add(sd, lb_imbalance[idle], imbalance);
 
+	/* if all tasks on busiest_cpu were pinned and can't be moved to 
+	 * this_cpu and from our last load_balance, there is no
+	 * changes to busiest_cpu's generation_num, then we are balanced
+	 */ 
+	if (unlikely(this_rq->busiest_rq == busiest && 
+		     this_rq->busiest_generation_num == busiest->generation_num))
+		goto out_balanced;
+		
 	nr_moved = 0;
 	if (busiest->nr_running > 1) {
 		/*
@@ -2013,8 +2034,12 @@
 		spin_unlock(&busiest->lock);
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
-		if (unlikely(all_pinned))
+		if (unlikely(all_pinned)) {
+			this_rq->busiest_rq = busiest;
+			this_rq->busiest_generation_num = busiest->generation_num;
 			goto out_balanced;
+		} else
+			this_rq->busiest_rq = NULL;
 	}
 
 	spin_unlock(&this_rq->lock);
@@ -4146,8 +4171,10 @@
 
 	p->cpus_allowed = new_mask;
 	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpu_isset(task_cpu(p), new_mask))
+	if (cpu_isset(task_cpu(p), new_mask)) {
+		rq->generation_num++;
 		goto out;
+	}
 
 	if (migrate_task(p, any_online_cpu(new_mask), &req)) {
 		/* Need help from migration thread: drop lock and wait. */
