Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267916AbUGaJI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267916AbUGaJI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 05:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267917AbUGaJI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 05:08:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:59391 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267916AbUGaJIN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 05:08:13 -0400
Date: Sat, 31 Jul 2004 14:35:01 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU - low-latency-rcu [3/3]
Message-ID: <20040731090501.GC4612@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040731085402.GA4612@in.ibm.com> <20040731090108.GB4612@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731090108.GB4612@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As promised in OLS, this patch introduces a throttling mechanism
for RCU callbacks. We should not be executing thousands of callbacks
from a single tasklet handler, that is not scheduler friendly.
I introduced a kernel paramenter (rcupdate.maxbatch) which
allows us to control how many callbacks per tasklet handler
are invoked. I have sanity tested this on both UP and SMP
x86 box with dcache heavy workload, there doesn't seem to be
any problem, leak or otherwise.

Thanks
Dipankar

This patch makes RCU callbacks friendly to scheduler. It helps
low latency by limiting the number of callbacks invoked per
tasklet handler. Since we cannot schedule during a single softirq
handler, this reduces size of non-preemptible section significantly,
specially under heavy RCU updates. The limiting is done
through a kernel parameter rcupdate.maxbatch which is the
maximum number of RCU callbacks to invoke during a single
tasklet handler.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 include/linux/rcupdate.h |    7 +++++++
 kernel/rcupdate.c        |   27 +++++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff -puN kernel/rcupdate.c~low-latency-rcu kernel/rcupdate.c
--- linux-2.6.8-rc2-rcu/kernel/rcupdate.c~low-latency-rcu	2004-07-31 12:26:19.000000000 +0530
+++ linux-2.6.8-rc2-rcu-dipankar/kernel/rcupdate.c	2004-07-31 12:26:19.000000000 +0530
@@ -40,6 +40,7 @@
 #include <asm/bitops.h>
 #include <linux/module.h>
 #include <linux/completion.h>
+#include <linux/moduleparam.h>
 #include <linux/percpu.h>
 #include <linux/notifier.h>
 #include <linux/rcupdate.h>
@@ -63,6 +64,7 @@ DEFINE_PER_CPU(struct rcu_data, rcu_data
 /* Fake initialization required by compiler */
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 #define RCU_tasklet(cpu) (per_cpu(rcu_tasklet, cpu))
+static int maxbatch = 10;
 
 /**
  * call_rcu - Queue an RCU update request.
@@ -93,15 +95,23 @@ void fastcall call_rcu(struct rcu_head *
  * Invoke the completed RCU callbacks. They are expected to be in
  * a per-cpu list.
  */
-static void rcu_do_batch(struct rcu_head *list)
+static void rcu_do_batch(int cpu)
 {
-	struct rcu_head *next;
+	struct rcu_head *next, *list;
+	int count = 0;
 
+	list = RCU_donelist(cpu);
 	while (list) {
-		next = list->next;
+		next = RCU_donelist(cpu) = list->next;
 		list->func(list);
 		list = next;
+		if (++count >= maxbatch)
+			break;
 	}
+	if (!RCU_donelist(cpu))
+		RCU_donetail(cpu) = &RCU_donelist(cpu);
+	else
+		tasklet_schedule(&RCU_tasklet(cpu));
 }
 
 /*
@@ -261,11 +271,11 @@ void rcu_restart_cpu(int cpu)
 static void rcu_process_callbacks(unsigned long unused)
 {
 	int cpu = smp_processor_id();
-	struct rcu_head *rcu_list = NULL;
 
 	if (RCU_curlist(cpu) &&
 	    !rcu_batch_before(rcu_ctrlblk.completed, RCU_batch(cpu))) {
-		rcu_list = RCU_curlist(cpu);
+		*RCU_donetail(cpu) = RCU_curlist(cpu);
+		RCU_donetail(cpu) = RCU_curtail(cpu);
 		RCU_curlist(cpu) = NULL;
 		RCU_curtail(cpu) = &RCU_curlist(cpu);
 	}
@@ -300,8 +310,8 @@ static void rcu_process_callbacks(unsign
 		local_irq_enable();
 	}
 	rcu_check_quiescent_state();
-	if (rcu_list)
-		rcu_do_batch(rcu_list);
+	if (RCU_donelist(cpu))
+		rcu_do_batch(cpu);
 }
 
 void rcu_check_callbacks(int cpu, int user)
@@ -319,6 +329,7 @@ static void __devinit rcu_online_cpu(int
 	tasklet_init(&RCU_tasklet(cpu), rcu_process_callbacks, 0UL);
 	RCU_curtail(cpu) = &RCU_curlist(cpu);
 	RCU_nxttail(cpu) = &RCU_nxtlist(cpu);
+	RCU_donetail(cpu) = &RCU_donelist(cpu);
 	RCU_quiescbatch(cpu) = rcu_ctrlblk.completed;
 	RCU_qs_pending(cpu) = 0;
 }
@@ -388,6 +399,6 @@ void synchronize_kernel(void)
 	wait_for_completion(&rcu.completion);
 }
 
-
+module_param(maxbatch, int, 0);
 EXPORT_SYMBOL(call_rcu);
 EXPORT_SYMBOL(synchronize_kernel);
diff -puN include/linux/rcupdate.h~low-latency-rcu include/linux/rcupdate.h
--- linux-2.6.8-rc2-rcu/include/linux/rcupdate.h~low-latency-rcu	2004-07-31 12:26:19.000000000 +0530
+++ linux-2.6.8-rc2-rcu-dipankar/include/linux/rcupdate.h	2004-07-31 12:26:19.000000000 +0530
@@ -99,6 +99,8 @@ struct rcu_data {
 	struct rcu_head **nxttail;
         struct rcu_head *curlist;
         struct rcu_head **curtail;
+        struct rcu_head *donelist;
+        struct rcu_head **donetail;
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
@@ -113,6 +115,8 @@ extern struct rcu_ctrlblk rcu_ctrlblk;
 #define RCU_curlist(cpu) 	(per_cpu(rcu_data, (cpu)).curlist)
 #define RCU_nxttail(cpu) 	(per_cpu(rcu_data, (cpu)).nxttail)
 #define RCU_curtail(cpu) 	(per_cpu(rcu_data, (cpu)).curtail)
+#define RCU_donelist(cpu) 	(per_cpu(rcu_data, (cpu)).donelist)
+#define RCU_donetail(cpu) 	(per_cpu(rcu_data, (cpu)).donetail)
 
 static inline int rcu_pending(int cpu) 
 {
@@ -127,6 +131,9 @@ static inline int rcu_pending(int cpu) 
 	if (!RCU_curlist(cpu) && RCU_nxtlist(cpu))
 		return 1;
 
+	if (RCU_donelist(cpu))
+		return 1;
+
 	/* The rcu core waits for a quiescent state from the cpu */
 	if (RCU_quiescbatch(cpu) != rcu_ctrlblk.cur || RCU_qs_pending(cpu))
 		return 1;

_
