Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268051AbTAIXwv>; Thu, 9 Jan 2003 18:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268055AbTAIXwv>; Thu, 9 Jan 2003 18:52:51 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:22213 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268051AbTAIXwt>; Thu, 9 Jan 2003 18:52:49 -0500
Date: Thu, 09 Jan 2003 15:54:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Minature NUMA scheduler
Message-ID: <52570000.1042156448@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried a small experiment today - did a simple restriction of
the O(1) scheduler to only balance inside a node. Coupled with
the small initial load balancing patch floating around, this
covers 95% of cases, is a trivial change (3 lines), performs 
just as well as Erich's patch on a kernel compile, and actually
better on schedbench.

This is NOT meant to be a replacement for the code Erich wrote,
it's meant to be a simple way to get integration and acceptance.
Code that just forks and never execs will stay on one node - but
we can take the code Erich wrote, and put it in seperate rebalancer
that fires much less often to do a cross-node rebalance. All that
would be under #ifdef CONFIG_NUMA, the only thing that would touch
mainline is these three lines of change, and it's trivial to see
they're completely equivalent to the current code on non-NUMA systems.

I also believe that this is the more correct approach in design, it
should result in much less cross-node migration of tasks, and less 
scanning of remote runqueues.

Opinions / comments?

M.

Kernbench:
                                   Elapsed        User      System         CPU
                   2.5.54-mjb3      19.41s     186.38s     39.624s     1191.4%
          2.5.54-mjb3-mjbsched     19.508s    186.356s     39.888s     1164.6%

Schedbench 4:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.54-mjb3        0.00       35.14       88.82        0.64
          2.5.54-mjb3-mjbsched        0.00       31.84       88.91        0.49

Schedbench 8:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.54-mjb3        0.00       47.55      269.36        1.48
          2.5.54-mjb3-mjbsched        0.00       41.01      252.34        1.07

Schedbench 16:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.54-mjb3        0.00       76.53      957.48        4.17
          2.5.54-mjb3-mjbsched        0.00       69.01      792.71        2.74

Schedbench 32:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.54-mjb3        0.00      145.20     1993.97       11.05
          2.5.54-mjb3-mjbsched        0.00      117.47     1798.93        5.95

Schedbench 64:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.54-mjb3        0.00      307.80     4643.55       20.36
          2.5.54-mjb3-mjbsched        0.00      241.04     3589.55       12.74

-----------------------------------------

diff -purN -X /home/mbligh/.diff.exclude virgin/kernel/sched.c mjbsched/kernel/sched.c
--- virgin/kernel/sched.c	Mon Dec  9 18:46:15 2002
+++ mjbsched/kernel/sched.c	Thu Jan  9 14:09:17 2003
@@ -654,7 +654,7 @@ static inline unsigned int double_lock_b
 /*
  * find_busiest_queue - find the busiest runqueue.
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
+static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance, unsigned long cpumask)
 {
 	int nr_running, load, max_load, i;
 	runqueue_t *busiest, *rq_src;
@@ -689,7 +689,7 @@ static inline runqueue_t *find_busiest_q
 	busiest = NULL;
 	max_load = 1;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
+		if (!cpu_online(i) || !((1 << i) & cpumask) )
 			continue;
 
 		rq_src = cpu_rq(i);
@@ -764,7 +764,8 @@ static void load_balance(runqueue_t *thi
 	struct list_head *head, *curr;
 	task_t *tmp;
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance, 
+				__node_to_cpu_mask(__cpu_to_node(this_cpu)) );
 	if (!busiest)
 		goto out;
 

---------------------------------------------------

A tiny change in the current ilb patch is also needed to stop it
using a macro from the first patch:

diff -purN -X /home/mbligh/.diff.exclude ilbold/kernel/sched.c ilbnew/kernel/sched.c
--- ilbold/kernel/sched.c	Thu Jan  9 15:20:53 2003
+++ ilbnew/kernel/sched.c	Thu Jan  9 15:27:49 2003
@@ -2213,6 +2213,7 @@ static void sched_migrate_task(task_t *p
 static int sched_best_cpu(struct task_struct *p)
 {
 	int i, minload, load, best_cpu, node = 0;
+	unsigned long cpumask;
 
 	best_cpu = task_cpu(p);
 	if (cpu_rq(best_cpu)->nr_running <= 2)
@@ -2226,9 +2227,11 @@ static int sched_best_cpu(struct task_st
 			node = i;
 		}
 	}
+
 	minload = 10000000;
-	loop_over_node(i,node) {
-		if (!cpu_online(i))
+	cpumask = __node_to_cpu_mask(node);
+	for (i = 0; i < NR_CPUS; ++i) {
+		if (!(cpumask & (1 << i)))
 			continue;
 		if (cpu_rq(i)->nr_running < minload) {
 			best_cpu = i;



