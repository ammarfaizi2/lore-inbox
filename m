Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262855AbVEHMTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbVEHMTO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 08:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbVEHMTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 08:19:14 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:22252 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262855AbVEHMSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 08:18:51 -0400
Date: Sun, 8 May 2005 17:49:32 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, schwidefsky@de.ibm.com,
       jdike@addtoit.com, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050508121932.GA3055@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050507182728.GA29592@in.ibm.com> <1115524211.17482.23.camel@localhost.localdomain> <427D921F.8070602@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427D921F.8070602@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2005 at 02:14:23PM +1000, Nick Piggin wrote:
> Yeah probably something around that order of magnitude. I suspect
> there will fast be a point where either you'll get other timers
> going off more frequently, and / or you simply get very quickly
> diminishing returns on the amount of power saving gained from
> increasing the period.

I am looking at it from the other perspective also i.e, virtualized
env. Any amount of unnecessary timer ticks will lead to equivalent amount
of unnecessary context switches among the guest OSes.

> It is not so much a matter of "fixing" the scheduler as just adding
> more heuristics. When are we too busy? When should we wake another
> CPU? What if that CPU is an SMT sibling? What if it is across the
> other side of the topology, and other CPUs closer to it are busy
> as well? What if they're busy but not as busy as we are? etc.
> 
> We've already got that covered in the existing periodic pull balancing,
> so instead of duplicating this logic and moving this extra work to busy
> CPUs, we can just use the existing framework.

I don't think we have to duplicate the logic, just "reuse" whatever logic
exists (in find_busiest_group etc). However I do agree there is movement
of extra work to busy CPUs, but that is only to help the idle CPU sleep longer.
Whether it justifies the additional complexity or not is what this RFC is
about I guess!

FWIW, I have also made some modifications in the original proposal 
for reducing the watchdog workload (instead of the same non-idle cpu waking 
up all the sleeping CPUs it finds in the same rebalance_tick, the task
is spread over multiple non-idle tasks in different rebalance_ticks).
New (lightly tested) patch is in the mail below.


> At least we should try method A first, and if that isn't good enough
> (though I suspect it will be), then think about adding more complexity
> to the scheduler.

What would be good to measure between the two approaches is the CPU utilization 
(over a period of time - say 10 hrs) of somewhat lightly loaded SMP guest OSes 
(i.e some CPUs are idle and other CPUs of the same guest are not idle), when 
multiple such guest OSes are running simultaneously on the same box.  This 
means I need a port of VST to UML :(

> Well in the UP case, both A and B should basically degenerate to the
> same thing.

I agree.

> Probably the more important case for the scheduler is to be able to
> turn off idle SMP hypervisor clients, Srivatsa?

True. To make a distinction, these SMP clients can be either completely
idle (all their CPUs idle) or partially idle (only fraction of CPUs idle).
It would be good to cater to both kind of clients.

My latest watchdog implementation is below for reference:

---

 linux-2.6.12-rc3-mm2-vatsa/include/linux/sched.h |    1 
 linux-2.6.12-rc3-mm2-vatsa/kernel/sched.c        |  150 ++++++++++++++++++++++-
 2 files changed, 146 insertions(+), 5 deletions(-)

diff -puN kernel/sched.c~sched-nohz kernel/sched.c
--- linux-2.6.12-rc3-mm2/kernel/sched.c~sched-nohz	2005-05-04 18:23:30.000000000 +0530
+++ linux-2.6.12-rc3-mm2-vatsa/kernel/sched.c	2005-05-07 22:09:04.000000000 +0530
@@ -1875,6 +1875,25 @@ out:
 	return pulled;
 }
 
+static inline struct sched_domain *
+sched_domain_ptr(int dst_cpu, int src_cpu, struct sched_domain *src_ptr)
+{
+	struct sched_domain *tmp, *dst_ptr;
+
+	dst_ptr = cpu_rq(dst_cpu)->sd;
+
+	for_each_domain(src_cpu, tmp) {
+		if (tmp == src_ptr || !dst_ptr)
+			break;
+		dst_ptr = dst_ptr->parent;
+	}
+
+	if (tmp == NULL)
+		dst_ptr = NULL;
+
+	return dst_ptr;
+}
+
 /*
  * find_busiest_group finds and returns the busiest CPU group within the
  * domain. It calculates and returns the number of tasks which should be
@@ -1882,11 +1901,18 @@ out:
  */
 static struct sched_group *
 find_busiest_group(struct sched_domain *sd, int this_cpu,
-		   unsigned long *imbalance, enum idle_type idle)
+		   unsigned long *imbalance, enum idle_type idle,
+		   cpumask_t *wakemaskp)
 {
 	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
 	int load_idx;
+#ifdef CONFIG_NO_IDLE_HZ
+	int grp_sleeping = 0, woken = 0;
+	cpumask_t tmpmask;
+	struct sched_domain *sd1;
+	unsigned long interval;
+#endif
 
 	max_load = this_load = total_load = total_pwr = 0;
 	if (idle == NOT_IDLE)
@@ -1896,6 +1922,11 @@ find_busiest_group(struct sched_domain *
 	else
 		load_idx = sd->idle_idx;
 
+#ifdef CONFIG_NO_IDLE_HZ
+	if (wakemaskp)
+		cpus_clear(*wakemaskp);
+#endif
+
 	do {
 		unsigned long load;
 		int local_group;
@@ -1906,6 +1937,17 @@ find_busiest_group(struct sched_domain *
 		/* Tally up the load of all CPUs in the group */
 		avg_load = 0;
 
+#ifdef CONFIG_NO_IDLE_HZ
+		grp_sleeping = 0;
+		woken = 0;
+		if (wakemaskp && idle == NOT_IDLE) {
+			/* Are all CPUs in the group sleeping ? */
+			cpus_and(tmpmask, group->cpumask, nohz_cpu_mask);
+			if (cpus_equal(tmpmask, group->cpumask))
+				grp_sleeping = 1;
+		}
+#endif
+
 		for_each_cpu_mask(i, group->cpumask) {
 			/* Bias balancing toward cpus of our domain */
 			if (local_group)
@@ -1914,6 +1956,36 @@ find_busiest_group(struct sched_domain *
 				load = source_load(i, load_idx);
 
 			avg_load += load;
+
+#ifdef CONFIG_NO_IDLE_HZ
+			/* Try to find a CPU that can be woken up from the
+			 * sleeping group. After we wake up one CPU, we will let
+			 * it wakeup others in its group.
+			 */
+			if (!grp_sleeping || woken)
+				continue;
+
+			sd1 = sched_domain_ptr(i, this_cpu, sd);
+
+			if (!sd1 || !sd1->flags & SD_LOAD_BALANCE)
+				continue;
+
+			interval = sd1->balance_interval;
+			/* scale ms to jiffies */
+			interval = msecs_to_jiffies(interval);
+	                if (unlikely(!interval))
+        	                interval = 1;
+
+			if (jiffies - sd1->last_balance >= interval) {
+				/* Lets record this CPU as a possible target
+				 * to be woken up. Whether we actually wake it
+				 * up or not depends on the CPU's imbalance wrt
+				 * others in the domain.
+				 */
+				woken = 1;
+				cpu_set(i, *wakemaskp);
+			}
+#endif
 		}
 
 		total_load += avg_load;
@@ -2050,11 +2122,15 @@ static int load_balance(int this_cpu, ru
 	unsigned long imbalance;
 	int nr_moved, all_pinned = 0;
 	int active_balance = 0;
+	cpumask_t wakemask;
+#ifdef CONFIG_NO_IDLE_HZ
+	struct sched_domain *sd1;
+#endif
 
 	spin_lock(&this_rq->lock);
 	schedstat_inc(sd, lb_cnt[idle]);
 
-	group = find_busiest_group(sd, this_cpu, &imbalance, idle);
+	group = find_busiest_group(sd, this_cpu, &imbalance, idle, &wakemask);
 	if (!group) {
 		schedstat_inc(sd, lb_nobusyg[idle]);
 		goto out_balanced;
@@ -2130,9 +2206,11 @@ static int load_balance(int this_cpu, ru
 			sd->balance_interval *= 2;
 	}
 
-	return nr_moved;
+	goto out_nohz;
 
 out_balanced:
+	nr_moved = 0;
+
 	spin_unlock(&this_rq->lock);
 
 	schedstat_inc(sd, lb_balanced[idle]);
@@ -2143,7 +2221,36 @@ out_balanced:
 			(sd->balance_interval < sd->max_interval))
 		sd->balance_interval *= 2;
 
-	return 0;
+out_nohz:
+#ifdef CONFIG_NO_IDLE_HZ
+	if (!cpus_empty(wakemask)) {
+		int i;
+
+		/* Lets try to wakeup one CPU from the mask. Rest of the cpus
+		 * in the mask can be woken up by other CPUs when they do load
+		 * balancing in this domain. That way, the overhead of watchdog
+		 * functionality is spread across (non-idle) CPUs in the domain.
+		 */
+
+		for_each_cpu_mask(i, wakemask) {
+
+			sd1 = sched_domain_ptr(i, this_cpu, sd);
+
+			if (!sd1)
+				continue;
+
+			find_busiest_group(sd1, i, &imbalance, SCHED_IDLE,
+					   			NULL);
+			if (imbalance > 0) {
+				spin_lock(&cpu_rq(i)->lock);
+				resched_task(cpu_rq(i)->idle);
+				spin_unlock(&cpu_rq(i)->lock);
+				break;
+			}
+		}
+	}
+#endif
+	return nr_moved;
 }
 
 /*
@@ -2162,7 +2269,7 @@ static int load_balance_newidle(int this
 	int nr_moved = 0;
 
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
-	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE);
+	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE, NULL);
 	if (!group) {
 		schedstat_inc(sd, lb_nobusyg[NEWLY_IDLE]);
 		goto out_balanced;
@@ -2323,6 +2430,39 @@ static void rebalance_tick(int this_cpu,
 		}
 	}
 }
+
+#ifdef CONFIG_NO_IDLE_HZ
+/*
+ * Try hard to pull tasks. Called by idle task before it sleeps cutting off
+ * local timer ticks.  This clears the various load counters and tries to pull
+ * tasks.
+ *
+ * Returns 1 if tasks were pulled over, 0 otherwise.
+ */
+int idle_balance_retry(void)
+{
+	int j, moved = 0, this_cpu = smp_processor_id();
+	runqueue_t *this_rq = this_rq();
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	for (j = 0; j < 3; j++)
+		this_rq->cpu_load[j] = 0;
+
+	rebalance_tick(this_cpu, this_rq, SCHED_IDLE);
+
+	if (this_rq->nr_running) {
+		moved = 1;
+		set_tsk_need_resched(current);
+	}
+
+	local_irq_restore(flags);
+
+	return moved;
+}
+#endif
+
 #else
 /*
  * on UP we do not need to balance between CPUs:
diff -puN include/linux/sched.h~sched-nohz include/linux/sched.h
--- linux-2.6.12-rc3-mm2/include/linux/sched.h~sched-nohz	2005-05-04 18:23:30.000000000 +0530
+++ linux-2.6.12-rc3-mm2-vatsa/include/linux/sched.h	2005-05-04 18:23:37.000000000 +0530
@@ -897,6 +897,7 @@ extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
 extern task_t *idle_task(int cpu);
+extern int idle_balance_retry(void);
 
 void yield(void);
 

_

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
