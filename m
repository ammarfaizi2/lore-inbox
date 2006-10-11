Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161396AbWJKV2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161396AbWJKV2p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161513AbWJKV2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:28:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:50078 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161397AbWJKVFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:05:22 -0400
Date: Wed, 11 Oct 2006 14:04:49 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, nickpiggin@yahoo.com.au,
       suresh.b.siddha@intel.com, Christoph Lameter <clameter@sgi.com>,
       John Hawkes <hawkes@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 17/67] Fix longstanding load balancing bug in the scheduler
Message-ID: <20061011210449.GR16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-longstanding-load-balancing-bug-in-the-scheduler.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Christoph Lameter <christoph@sgi.com>

The scheduler will stop load balancing if the most busy processor contains
processes pinned via processor affinity.

The scheduler currently only does one search for busiest cpu.  If it cannot
pull any tasks away from the busiest cpu because they were pinned then the
scheduler goes into a corner and sulks leaving the idle processors idle.

F.e.  If you have processor 0 busy running four tasks pinned via taskset,
there are none on processor 1 and one just started two processes on
processor 2 then the scheduler will not move one of the two processes away
from processor 2.

This patch fixes that issue by forcing the scheduler to come out of its
corner and retrying the load balancing by considering other processors for
load balancing.

This patch was originally developed by John Hawkes and discussed at
http://marc.theaimsgroup.com/?l=linux-kernel&m=113901368523205&w=2.

I have removed extraneous material and gone back to equipping struct rq
with the cpu the queue is associated with since this makes the patch much
easier and it is likely that others in the future will have the same
difficulty of figuring out which processor owns which runqueue.

The overhead added through these patches is a single word on the stack if
the kernel is configured to support 32 cpus or less (32 bit).  For 32 bit
environments the maximum number of cpus that can be configued is 255 which
would result in the use of 32 bytes additional on the stack.  On IA64 up to
1k cpus can be configured which will result in the use of 128 additional
bytes on the stack.  The maximum additional cache footprint is one
cacheline.  Typically memory use will be much less than a cacheline and the
additional cpumask will be placed on the stack in a cacheline that already
contains other local variable.


Signed-off-by: Christoph Lameter <clameter@sgi.com>
Cc: John Hawkes <hawkes@sgi.com>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Peter Williams <pwil3058@bigpond.net.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 kernel/sched.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 8 deletions(-)

--- linux-2.6.18.orig/kernel/sched.c
+++ linux-2.6.18/kernel/sched.c
@@ -238,6 +238,7 @@ struct rq {
 	/* For active balancing */
 	int active_balance;
 	int push_cpu;
+	int cpu;		/* cpu of this runqueue */
 
 	struct task_struct *migration_thread;
 	struct list_head migration_queue;
@@ -267,6 +268,15 @@ struct rq {
 
 static DEFINE_PER_CPU(struct rq, runqueues);
 
+static inline int cpu_of(struct rq *rq)
+{
+#ifdef CONFIG_SMP
+	return rq->cpu;
+#else
+	return 0;
+#endif
+}
+
 /*
  * The domain tree (rq->sd) is protected by RCU's quiescent state transition.
  * See detach_destroy_domains: synchronize_sched for details.
@@ -2211,7 +2221,8 @@ out:
  */
 static struct sched_group *
 find_busiest_group(struct sched_domain *sd, int this_cpu,
-		   unsigned long *imbalance, enum idle_type idle, int *sd_idle)
+		   unsigned long *imbalance, enum idle_type idle, int *sd_idle,
+		   cpumask_t *cpus)
 {
 	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
@@ -2248,7 +2259,12 @@ find_busiest_group(struct sched_domain *
 		sum_weighted_load = sum_nr_running = avg_load = 0;
 
 		for_each_cpu_mask(i, group->cpumask) {
-			struct rq *rq = cpu_rq(i);
+			struct rq *rq;
+
+			if (!cpu_isset(i, *cpus))
+				continue;
+
+			rq = cpu_rq(i);
 
 			if (*sd_idle && !idle_cpu(i))
 				*sd_idle = 0;
@@ -2466,13 +2482,17 @@ ret:
  */
 static struct rq *
 find_busiest_queue(struct sched_group *group, enum idle_type idle,
-		   unsigned long imbalance)
+		   unsigned long imbalance, cpumask_t *cpus)
 {
 	struct rq *busiest = NULL, *rq;
 	unsigned long max_load = 0;
 	int i;
 
 	for_each_cpu_mask(i, group->cpumask) {
+
+		if (!cpu_isset(i, *cpus))
+			continue;
+
 		rq = cpu_rq(i);
 
 		if (rq->nr_running == 1 && rq->raw_weighted_load > imbalance)
@@ -2511,6 +2531,7 @@ static int load_balance(int this_cpu, st
 	struct sched_group *group;
 	unsigned long imbalance;
 	struct rq *busiest;
+	cpumask_t cpus = CPU_MASK_ALL;
 
 	if (idle != NOT_IDLE && sd->flags & SD_SHARE_CPUPOWER &&
 	    !sched_smt_power_savings)
@@ -2518,13 +2539,15 @@ static int load_balance(int this_cpu, st
 
 	schedstat_inc(sd, lb_cnt[idle]);
 
-	group = find_busiest_group(sd, this_cpu, &imbalance, idle, &sd_idle);
+redo:
+	group = find_busiest_group(sd, this_cpu, &imbalance, idle, &sd_idle,
+							&cpus);
 	if (!group) {
 		schedstat_inc(sd, lb_nobusyg[idle]);
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group, idle, imbalance);
+	busiest = find_busiest_queue(group, idle, imbalance, &cpus);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[idle]);
 		goto out_balanced;
@@ -2549,8 +2572,12 @@ static int load_balance(int this_cpu, st
 		double_rq_unlock(this_rq, busiest);
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
-		if (unlikely(all_pinned))
+		if (unlikely(all_pinned)) {
+			cpu_clear(cpu_of(busiest), cpus);
+			if (!cpus_empty(cpus))
+				goto redo;
 			goto out_balanced;
+		}
 	}
 
 	if (!nr_moved) {
@@ -2639,18 +2666,22 @@ load_balance_newidle(int this_cpu, struc
 	unsigned long imbalance;
 	int nr_moved = 0;
 	int sd_idle = 0;
+	cpumask_t cpus = CPU_MASK_ALL;
 
 	if (sd->flags & SD_SHARE_CPUPOWER && !sched_smt_power_savings)
 		sd_idle = 1;
 
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
-	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE, &sd_idle);
+redo:
+	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE,
+				&sd_idle, &cpus);
 	if (!group) {
 		schedstat_inc(sd, lb_nobusyg[NEWLY_IDLE]);
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group, NEWLY_IDLE, imbalance);
+	busiest = find_busiest_queue(group, NEWLY_IDLE, imbalance,
+				&cpus);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
 		goto out_balanced;
@@ -2668,6 +2699,12 @@ load_balance_newidle(int this_cpu, struc
 					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, NEWLY_IDLE, NULL);
 		spin_unlock(&busiest->lock);
+
+		if (!nr_moved) {
+			cpu_clear(cpu_of(busiest), cpus);
+			if (!cpus_empty(cpus))
+				goto redo;
+		}
 	}
 
 	if (!nr_moved) {
@@ -6747,6 +6784,7 @@ void __init sched_init(void)
 			rq->cpu_load[j] = 0;
 		rq->active_balance = 0;
 		rq->push_cpu = 0;
+		rq->cpu = i;
 		rq->migration_thread = NULL;
 		INIT_LIST_HEAD(&rq->migration_queue);
 #endif

--
