Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269260AbUJVX7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269260AbUJVX7u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269261AbUJVXir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:38:47 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:24752 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269260AbUJVXhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:37:02 -0400
Subject: [patch] scheduler: active_load_balance fixes
From: Darren Hart <dvhltc@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Matt Dobson <colpatch@us.ibm.com>, Martin J Bligh <mbligh@aracnet.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <piggin@cyberone.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 22 Oct 2004 16:36:13 -0700
Message-Id: <1098488173.2854.13.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch against the latest mm fixes several problems with
active_load_balance().

Rather than starting with the highest allowable domain (SD_LOAD_BALANCE
is still set) and depending on the order of the cpu groups, we start at
the lowest domain and work up until we find a suitable CPU or run out of
options (SD_LOAD_BALANCE is no longer set).  This is a more robust
approach as it is more explicit and not subject to the construction
order of the cpu groups.

We move the test for busiest_rq->nr_running <=1 into the domain loop so
we don't continue to try and move tasks when there are none left to
move.  This new logic (testing for nr_running in the domain loop) should
make the busiest_rq==target_rq condition really impossible, so we have
replaced the graceful continue on fail with a BUG_ON. (Bjorn Helgaas,
please confirm)

We eliminate the exclusion of the busiest_cpu's group from the pool of
available groups to push to as it is the ideal group to push to, even if
not very likely to be available.  Note that by removing the test for
group==busy_group and allowing it to also be tested for suitability, the
running time is nearly the same.

We no longer force the destination CPU to be in a group of completely
idle CPUs, nor to be the last in that group.


Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
---

sched.c |  123 +++++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 69 insertions(+), 54 deletions(-)


diff -purN -X /home/mbligh/.diff.exclude /home/linux/views/linux-2.6.9-mm1/kernel/sched.c 2.6.9-mm1-active_balance/kernel/sched.c
--- /home/linux/views/linux-2.6.9-mm1/kernel/sched.c	2004-10-22 11:21:46.000000000 -0700
+++ 2.6.9-mm1-active_balance/kernel/sched.c	2004-10-22 12:08:49.000000000 -0700
@@ -2062,70 +2062,85 @@ static inline void idle_balance(int this
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
-			break;
-	if (!sd)
-		return;
-
-	group = sd->groups;
-	while (!cpu_isset(busiest_cpu, group->cpumask))
-		group = group->next;
-	busy_group = group;
+	struct sched_group *cpu_group;
+	cpumask_t visited_cpus;
 
-	group = sd->groups;
-	do {
-		runqueue_t *rq;
-		int push_cpu = 0;
-
-		if (group == busy_group)
-			goto next_group;
+	schedstat_inc(busiest_rq, alb_cnt);
+	/*
+	 * Search for suitable CPUs to push tasks to in successively higher
+	 * domains with SD_LOAD_BALANCE set.
+	 */ 
+	visited_cpus = CPU_MASK_NONE;
+	for_each_domain(busiest_cpu, sd) {
+		if (!(sd->flags & SD_LOAD_BALANCE) || busiest_rq->nr_running <= 1) 
+			break; /* no more domains to search or no more tasks to move */
+
+		cpu_group = sd->groups;
+		do { /* sched_groups should either use list_heads or be merged into the domains structure */
+			int cpu, target_cpu = -1;
+			runqueue_t *target_rq;
+
+			for_each_cpu_mask(cpu, cpu_group->cpumask) {
+				if (cpu_isset(cpu, visited_cpus) || cpu == busiest_cpu || 
+				    !cpu_and_siblings_are_idle(cpu)) {
+					cpu_set(cpu, visited_cpus);
+					continue;
+				}
+				target_cpu = cpu;
+				break;
+			}
+			if (target_cpu == -1)
+				goto next_group; /* failed to find a suitable target cpu in this domain */
 
-		for_each_cpu_mask(i, group->cpumask) {
-			if (!idle_cpu(i))
-				goto next_group;
-			push_cpu = i;
-		}
+			target_rq = cpu_rq(target_cpu);
 
-		rq = cpu_rq(push_cpu);
+			/*
+			 * This condition is "impossible", if it occurs we need to fix it
+			 * Reported by Bjorn Helgaas on a 128-cpu setup.
+			 */
+			BUG_ON(busiest_rq == target_rq);
 
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
+			/* move a task from busiest_rq to target_rq */
+			double_lock_balance(busiest_rq, target_rq);
+			if (move_tasks(target_rq, target_cpu, busiest_rq, 1, sd, SCHED_IDLE)) {
+				schedstat_inc(busiest_rq, alb_lost);
+				schedstat_inc(target_rq, alb_gained);
+			} else {
+				schedstat_inc(busiest_rq, alb_failed);
+			}
+			spin_unlock(&target_rq->lock);
 next_group:
-		group = group->next;
-	} while (group != sd->groups);
+			cpu_group = cpu_group->next;
+		} while (cpu_group != sd->groups && busiest_rq->nr_running > 1);
+	}
 }
 
 /*

