Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263023AbUJ1SRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbUJ1SRF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUJ1SRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:17:05 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:3839 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263023AbUJ1SQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:16:20 -0400
Subject: Re: [PATCH] active_load_balance() fixlet
From: Darren Hart <dvhltc@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Matt Dobson <colpatch@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20041028062656.GA9781@elte.hu>
References: <1098921429.20183.27.camel@arrakis>
	 <1098921793.17741.8.camel@farah.beaverton.ibm.com>
	 <20041028062656.GA9781@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 28 Oct 2004 11:15:49 -0700
Message-Id: <1098987349.24291.10.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-28 at 08:26 +0200, Ingo Molnar wrote:
> * Darren Hart <darren@dvhart.com> wrote:
> 
> > On Wed, 2004-10-27 at 16:57 -0700, Matthew Dobson wrote:
> > > Darren, Andrew, and scheduler folks,
> > > 
> > > There is a small problem with the active_load_balance() patch that
> > > Darren sent out last week.
> > 
> > This cleans up some awkward tests in my patch as well.  Looks good to
> > me.
> 
> could you send a combined patch for review?
> 
> 	Ingo


Patch below only for review - please DO NOT APPLY.

Note that Andrew already included my original patch in 2.6.10-rc1-mm1
and sent it along to Linus, and it is now in bk.  Matt found some minor
things that could be improved.  Matt's patch can/should be applied
separately (to 2.6.10-rc1-mm1).

I am submitting the combined patch below (against 2.6.9-mm1) strictly
for review at Ingo's request, 

-- 
Darren Hart
IBM, Linux Technology Center
503 578 3185
dvhltc@us.ibm.com


diff -aurpN -X /home/dvhart/.diff.exclude 2.6.9-mm1/kernel/sched.c 2.6.9-mm1-active_balance/kernel/sched.c
--- 2.6.9-mm1/kernel/sched.c	2004-10-22 08:30:09.000000000 -0700
+++ 2.6.9-mm1-active_balance/kernel/sched.c	2004-10-28 10:52:59.000000000 -0700
@@ -2062,70 +2062,86 @@ static inline void idle_balance(int this
 	}
 }
 
+#ifdef CONFIG_SCHED_SMT
+static int cpu_and_siblings_are_idle(int cpu)
+{
+	int sib;
+	for_each_cpu_mask(sib, cpu_sibling_map[cpu]) {
+		if (idle_cpu(sib))
+			continue;
+		return 0;
+	}
+
+	return 1;
+}
+#else
+#define cpu_and_siblings_are_idle(A) idle_cpu(A)
+#endif
+
+
 /*
- * active_load_balance is run by migration threads. It pushes a running
- * task off the cpu. It can be required to correctly have at least 1 task
- * running on each physical CPU where possible, and not have a physical /
- * logical imbalance.
+ * active_load_balance is run by migration threads. It pushes running tasks
+ * off the busiest CPU onto idle CPUs. It requires at least 1 task to be
+ * running on each physical CPU where possible, and avoids physical /
+ * logical imbalances.
  *
- * Called with busiest locked.
+ * Called with busiest_rq locked.
  */
-static void active_load_balance(runqueue_t *busiest, int busiest_cpu)
+static void active_load_balance(runqueue_t *busiest_rq, int busiest_cpu)
 {
 	struct sched_domain *sd;
-	struct sched_group *group, *busy_group;
-	int i;
-
-	schedstat_inc(busiest, alb_cnt);
-	if (busiest->nr_running <= 1)
-		return;
-
-	for_each_domain(busiest_cpu, sd)
-		if (cpu_isset(busiest->push_cpu, sd->span))
+	struct sched_group *cpu_group;
+	runqueue_t *target_rq;
+	cpumask_t visited_cpus;
+	int cpu;
+
+	schedstat_inc(busiest_rq, alb_cnt);
+	/*
+	 * Search for suitable CPUs to push tasks to in successively higher
+	 * domains with SD_LOAD_BALANCE set.
+	 */ 
+	visited_cpus = CPU_MASK_NONE;
+	for_each_domain(busiest_cpu, sd) {
+		if (!(sd->flags & SD_LOAD_BALANCE))
+			/* no more domains to search */
 			break;
-	if (!sd)
-		return;
-
-	group = sd->groups;
-	while (!cpu_isset(busiest_cpu, group->cpumask))
-		group = group->next;
-	busy_group = group;
-
-	group = sd->groups;
-	do {
-		runqueue_t *rq;
-		int push_cpu = 0;
 
-		if (group == busy_group)
-			goto next_group;
-
-		for_each_cpu_mask(i, group->cpumask) {
-			if (!idle_cpu(i))
-				goto next_group;
-			push_cpu = i;
-		}
-
-		rq = cpu_rq(push_cpu);
+		cpu_group = sd->groups;
+		do {
+			for_each_cpu_mask(cpu, cpu_group->cpumask) {
+				if (busiest_rq->nr_running <= 1)
+					/* no more tasks left to move */
+					return;
+				if (cpu_isset(cpu, visited_cpus))
+					continue;
+				cpu_set(cpu, visited_cpus);
+				if (!cpu_and_siblings_are_idle(cpu) ||
+				    cpu == busiest_cpu) {
+					continue;
+				}
+				target_rq = cpu_rq(cpu);
 
-		/*
-		 * This condition is "impossible", but since load
-		 * balancing is inherently a bit racy and statistical,
-		 * it can trigger.. Reported by Bjorn Helgaas on a
-		 * 128-cpu setup.
-		 */
-		if (unlikely(busiest == rq))
-			goto next_group;
-		double_lock_balance(busiest, rq);
-		if (move_tasks(rq, push_cpu, busiest, 1, sd, SCHED_IDLE)) {
-			schedstat_inc(busiest, alb_lost);
-			schedstat_inc(rq, alb_gained);
-		} else {
-			schedstat_inc(busiest, alb_failed);
-		}
-		spin_unlock(&rq->lock);
-next_group:
-		group = group->next;
-	} while (group != sd->groups);
+				/*
+				 * This condition is "impossible", if it occurs
+				 * we need to fix it. Originially reported by 
+				 * Bjorn Helgaas on a 128-cpu machine.
+				 */
+				BUG_ON(busiest_rq == target_rq);
+
+				/* move a task from busiest_rq to target_rq */
+				double_lock_balance(busiest_rq, target_rq);
+				if (move_tasks(target_rq, target_cpu, busiest_rq,
+					       1, sd, SCHED_IDLE)) {
+					schedstat_inc(busiest_rq, alb_lost);
+					schedstat_inc(target_rq, alb_gained);
+				} else {
+					schedstat_inc(busiest_rq, alb_failed);
+				}
+				spin_unlock(&target_rq->lock);
+			}
+			cpu_group = cpu_group->next;
+		} while (cpu_group != sd->groups);
+	}
 }
 
 /*

