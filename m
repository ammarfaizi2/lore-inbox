Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267638AbUGaJE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbUGaJE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 05:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267914AbUGaJE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 05:04:27 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:15613 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267638AbUGaJEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 05:04:22 -0400
Date: Sat, 31 Jul 2004 14:31:08 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, nathanl@austin.ibm.com
Subject: Re: [PATCH] RCU - rcu-cpu-offline-fix [2/3]
Message-ID: <20040731090108.GB4612@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040731085402.GA4612@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731085402.GA4612@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

This patch replaces fixes-for-rcu_offline_cpu-rcu_move_batch-268-rc2.patch
in -mm tree. Same thing, but I needed to add the tail pointers anyway
for the RCU lists. That allows callbacks lists to be added to the
tail without iterating, so an optimized version of Nathan's patch.
I have sanity tested cpu hotplug on a ppc64 box with this patch.

Thanks
Dipankar

This fixes the RCU cpu offline code which was broken by singly-linked
RCU changes. Nathan pointed out the problems and submitted a patch
for this. This is an optimal fix - no need to iterate through
the list of callbacks, just use the tail pointers and attach the
list from the dead cpu.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>



 include/linux/rcupdate.h |    2 ++
 kernel/rcupdate.c        |   22 +++++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff -puN kernel/rcupdate.c~rcu-cpu-offline-fix kernel/rcupdate.c
--- linux-2.6.8-rc2-rcu/kernel/rcupdate.c~rcu-cpu-offline-fix	2004-07-29 16:06:03.000000000 +0530
+++ linux-2.6.8-rc2-rcu-dipankar/kernel/rcupdate.c	2004-07-31 12:25:57.000000000 +0530
@@ -210,17 +210,15 @@ static void rcu_check_quiescent_state(vo
  * locking requirements, the list it's pulling from has to belong to a cpu
  * which is dead and hence not processing interrupts.
  */
-static void rcu_move_batch(struct list_head *list)
+static void rcu_move_batch(struct rcu_head *list, struct rcu_head **tail)
 {
-	struct list_head *entry;
-	int cpu = smp_processor_id();
+	int cpu;
 
 	local_irq_disable();
-	while (!list_empty(list)) {
-		entry = list->next;
-		list_del(entry);
-		list_add_tail(entry, &RCU_nxtlist(cpu));
-	}
+	cpu = smp_processor_id();
+	*RCU_nxttail(cpu) = list;
+	if (list)
+		RCU_nxttail(cpu) = tail;
 	local_irq_enable();
 }
 
@@ -233,11 +231,10 @@ static void rcu_offline_cpu(int cpu)
 	spin_lock_bh(&rcu_state.mutex);
 	if (rcu_ctrlblk.cur != rcu_ctrlblk.completed)
 		cpu_quiet(cpu);
-unlock:
 	spin_unlock_bh(&rcu_state.mutex);
 
-	rcu_move_batch(&RCU_curlist(cpu));
-	rcu_move_batch(&RCU_nxtlist(cpu));
+	rcu_move_batch(RCU_curlist(cpu), RCU_curtail(cpu));
+	rcu_move_batch(RCU_nxtlist(cpu), RCU_nxttail(cpu));
 
 	tasklet_kill_immediate(&RCU_tasklet(cpu), cpu);
 }
@@ -270,6 +267,7 @@ static void rcu_process_callbacks(unsign
 	    !rcu_batch_before(rcu_ctrlblk.completed, RCU_batch(cpu))) {
 		rcu_list = RCU_curlist(cpu);
 		RCU_curlist(cpu) = NULL;
+		RCU_curtail(cpu) = &RCU_curlist(cpu);
 	}
 
 	local_irq_disable();
@@ -277,6 +275,7 @@ static void rcu_process_callbacks(unsign
 		int next_pending, seq;
 
 		RCU_curlist(cpu) = RCU_nxtlist(cpu);
+		RCU_curtail(cpu) = RCU_nxttail(cpu);
 		RCU_nxtlist(cpu) = NULL;
 		RCU_nxttail(cpu) = &RCU_nxtlist(cpu);
 		local_irq_enable();
@@ -318,6 +317,7 @@ static void __devinit rcu_online_cpu(int
 {
 	memset(&per_cpu(rcu_data, cpu), 0, sizeof(struct rcu_data));
 	tasklet_init(&RCU_tasklet(cpu), rcu_process_callbacks, 0UL);
+	RCU_curtail(cpu) = &RCU_curlist(cpu);
 	RCU_nxttail(cpu) = &RCU_nxtlist(cpu);
 	RCU_quiescbatch(cpu) = rcu_ctrlblk.completed;
 	RCU_qs_pending(cpu) = 0;
diff -puN include/linux/rcupdate.h~rcu-cpu-offline-fix include/linux/rcupdate.h
--- linux-2.6.8-rc2-rcu/include/linux/rcupdate.h~rcu-cpu-offline-fix	2004-07-29 16:12:51.000000000 +0530
+++ linux-2.6.8-rc2-rcu-dipankar/include/linux/rcupdate.h	2004-07-31 12:25:44.000000000 +0530
@@ -98,6 +98,7 @@ struct rcu_data {
         struct rcu_head *nxtlist;
 	struct rcu_head **nxttail;
         struct rcu_head *curlist;
+        struct rcu_head **curtail;
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
@@ -111,6 +112,7 @@ extern struct rcu_ctrlblk rcu_ctrlblk;
 #define RCU_nxtlist(cpu) 	(per_cpu(rcu_data, (cpu)).nxtlist)
 #define RCU_curlist(cpu) 	(per_cpu(rcu_data, (cpu)).curlist)
 #define RCU_nxttail(cpu) 	(per_cpu(rcu_data, (cpu)).nxttail)
+#define RCU_curtail(cpu) 	(per_cpu(rcu_data, (cpu)).curtail)
 
 static inline int rcu_pending(int cpu) 
 {

_
