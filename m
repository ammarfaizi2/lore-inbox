Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUJ1ACy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUJ1ACy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbUJ1AAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:00:00 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:39810 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262738AbUJ0X5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 19:57:35 -0400
Subject: [PATCH] active_load_balance() fixlet
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Darren Hart <dvhltc@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1098921429.20183.27.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 27 Oct 2004 16:57:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren, Andrew, and scheduler folks,

There is a small problem with the active_load_balance() patch that
Darren sent out last week.  As soon as we discover a potential
'target_cpu' from 'cpu_group' to try to push tasks to, we cease
considering other CPUs in that group as potential 'target_cpu's.  We
break out of the for_each_cpu_mask() loop and try to push tasks to that
CPU.  The problem is that there may well be other idle cpus in that
group that we should also try to push tasks to.  Here is a patch to fix
that small problem.  The solution is to simply move the code that tries
to push the tasks into the for_each_cpu_mask() loop and do away with the
whole 'target_cpu' thing entirely.  Compiled & booted on a 16-way x440.

[mcd@arrakis source]$ diffstat ~/linux/patches/sched_domains/alb_fix-mcd.patch
 sched.c |   65 +++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 32 insertions(+), 33 deletions(-)

-Matt


diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc1-mm1/kernel/sched.c linux-2.6.10-rc1-mm1+alb_fix/kernel/sched.c
--- linux-2.6.10-rc1-mm1/kernel/sched.c	2004-10-27 11:56:22.000000000 -0700
+++ linux-2.6.10-rc1-mm1+alb_fix/kernel/sched.c	2004-10-27 16:22:28.000000000 -0700
@@ -2089,7 +2089,9 @@ static void active_load_balance(runqueue
 {
 	struct sched_domain *sd;
 	struct sched_group *cpu_group;
+	runqueue_t *target_rq;
 	cpumask_t visited_cpus;
+	int cpu;
 
 	schedstat_inc(busiest_rq, alb_cnt);
 	/*
@@ -2098,46 +2100,43 @@ static void active_load_balance(runqueue
 	 */
 	visited_cpus = CPU_MASK_NONE;
 	for_each_domain(busiest_cpu, sd) {
-		if (!(sd->flags & SD_LOAD_BALANCE) || busiest_rq->nr_running <= 1)
-			break; /* no more domains to search or no more tasks to move */
+		if (!(sd->flags & SD_LOAD_BALANCE))
+			/* no more domains to search */
+			break;
 
 		cpu_group = sd->groups;
-		do { /* sched_groups should either use list_heads or be merged into the domains structure */
-			int cpu, target_cpu = -1;
-			runqueue_t *target_rq;
-
+		do {
 			for_each_cpu_mask(cpu, cpu_group->cpumask) {
-				if (cpu_isset(cpu, visited_cpus) || cpu == busiest_cpu ||
-				    !cpu_and_siblings_are_idle(cpu)) {
-					cpu_set(cpu, visited_cpus);
+				if (busiest_rq->nr_running <= 1)
+					/* no more tasks left to move */
+					return;
+				if (cpu_isset(cpu, visited_cpus))
+					continue;
+				cpu_set(cpu, visited_cpus);
+				if (!cpu_and_siblings_are_idle(cpu) || cpu == busiest_cpu)
 					continue;
-				}
-				target_cpu = cpu;
-				break;
-			}
-			if (target_cpu == -1)
-				goto next_group; /* failed to find a suitable target cpu in this domain */
-
-			target_rq = cpu_rq(target_cpu);
-
-			/*
-			 * This condition is "impossible", if it occurs we need to fix it
-			 * Reported by Bjorn Helgaas on a 128-cpu setup.
-			 */
-			BUG_ON(busiest_rq == target_rq);
 
-			/* move a task from busiest_rq to target_rq */
-			double_lock_balance(busiest_rq, target_rq);
-			if (move_tasks(target_rq, target_cpu, busiest_rq, 1, sd, SCHED_IDLE)) {
-				schedstat_inc(busiest_rq, alb_lost);
-				schedstat_inc(target_rq, alb_gained);
-			} else {
-				schedstat_inc(busiest_rq, alb_failed);
+				target_rq = cpu_rq(cpu);
+				/*
+				 * This condition is "impossible", if it occurs
+				 * we need to fix it.  Originally reported by
+				 * Bjorn Helgaas on a 128-cpu setup.
+				 */
+				BUG_ON(busiest_rq == target_rq);
+
+				/* move a task from busiest_rq to target_rq */
+				double_lock_balance(busiest_rq, target_rq);
+				if (move_tasks(target_rq, cpu, busiest_rq,
+						1, sd, SCHED_IDLE)) {
+					schedstat_inc(busiest_rq, alb_lost);
+					schedstat_inc(target_rq, alb_gained);
+				} else {
+					schedstat_inc(busiest_rq, alb_failed);
+				}
+				spin_unlock(&target_rq->lock);
 			}
-			spin_unlock(&target_rq->lock);
-next_group:
 			cpu_group = cpu_group->next;
-		} while (cpu_group != sd->groups && busiest_rq->nr_running > 1);
+		} while (cpu_group != sd->groups);
 	}
 }
 


