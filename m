Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289117AbSAGFA2>; Mon, 7 Jan 2002 00:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289118AbSAGFAS>; Mon, 7 Jan 2002 00:00:18 -0500
Received: from [202.135.142.194] ([202.135.142.194]:49167 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S289117AbSAGFAG>; Mon, 7 Jan 2002 00:00:06 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler 
In-Reply-To: Your message of "Fri, 04 Jan 2002 03:19:10 BST."
             <Pine.LNX.4.33.0201040050440.1363-100000@localhost.localdomain> 
Date: Mon, 07 Jan 2002 13:58:02 +1100
Message-Id: <E16NPz8-0001t1-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0201040050440.1363-100000@localhost.localdomain> you 
write:
> 
> now that new-year's parties are over things are getting boring again. For
> those who want to see and perhaps even try something more complex, i'm
> announcing this patch that is a pretty radical rewrite of the Linux
> scheduler for 2.5.2-pre6:

Hi Ingo...

	Reading through 2.5.2-C1, couple of comments/questions:

sched.c line 402:
	/*
	 * Current runqueue is empty, try to find work on
	 * other runqueues.
	 *
	 * We call this with the current runqueue locked,
	 * irqs disabled.
	 */
	static void load_balance(runqueue_t *this_rq)

This first comment doesn't seem to be true: it also seems to be called
from idle_tick and expire task.  Perhaps it'd be nicer too, to split
load_balance into "if (is_unbalanced(cpu())) pull_task(cpu())".  (I
like "pull_" and "push_" nomenclature for the scheduler).

sched.c load_balance() line 435:

		if ((load > max_load) && (load < prev_max_load) &&
						(rq_tmp != this_rq)) {

Why are you ignoring a CPU with more than the previous maximum load
(prev_max_load is incremented earlier)?

sched.c expire_task line 552:

	if (p->array != rq->active) {
		p->need_resched = 1;
		return;
	}

I'm not clear how this can happen??

Finally, I gather you want to change smp_processor_id() to cpu()?
That's fine (smp_num_cpus => num_cpus() too please), but it'd be nice
to have that as a separate patch, rather than getting stuck with BOTH
cpu() and smp_processor_id().

Patch below (untested) corrects SMP_CACHE_BYTES alignment, minor
comment, and rebalance tick for HZ < 100 (ie. User Mode Linux).

Rusty.
PS. Awesome work.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.2-pre9-mingosched/kernel/sched.c working-2.5.2-pre9-mingoschedfix/kernel/sched.c
--- working-2.5.2-pre9-mingosched/kernel/sched.c	Mon Jan  7 12:39:10 2002
+++ working-2.5.2-pre9-mingoschedfix/kernel/sched.c	Mon Jan  7 13:51:39 2002
@@ -43,14 +43,14 @@
  * if there is a RT task active in an SMP system but there is no
  * RT scheduling activity otherwise.
  */
-static struct runqueue {
+struct runqueue {
 	int cpu;
 	spinlock_t lock;
 	unsigned long nr_running, nr_switches, last_rt_event;
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
-	char __pad [SMP_CACHE_BYTES];
-} runqueues [NR_CPUS] __cacheline_aligned;
+} ____cacheline_aligned;
+static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
 
 #define this_rq()		(runqueues + cpu())
 #define task_rq(p)		(runqueues + (p)->cpu)
@@ -102,7 +102,7 @@
  * This is the per-process load estimator. Processes that generate
  * more load than the system can handle get a priority penalty.
  *
- * The estimator uses a 4-entry load-history ringbuffer which is
+ * The estimator uses a SLEEP_HIST_SIZE-entry load-history ringbuffer which is
  * updated whenever a task is moved to/from the runqueue. The load
  * estimate is also updated from the timer tick to get an accurate
  * estimation of currently executing tasks as well.
@@ -511,7 +511,7 @@
 	spin_unlock(&busiest->lock);
 }
 
-#define REBALANCE_TICK (HZ/100)
+#define REBALANCE_TICK ((HZ/100) ?: 1)
 
 void idle_tick(void)
 {
