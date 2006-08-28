Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWH1QLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWH1QLH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWH1QLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:11:07 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:62156 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751161AbWH1QLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:11:04 -0400
Date: Mon, 28 Aug 2006 21:41:12 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul E McKenney <paulmck@us.ibm.com>
Subject: Re: [PATCH 2/4] RCU: use a separate softirq
Message-ID: <20060828161112.GD3325@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060828160845.GB3325@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828160845.GB3325@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Finally, RCU gets its own softirq. With it being used extensively,
the per-cpu tasklet used earlier was just a softirq with overheads.
This makes things more efficient.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---


 include/linux/interrupt.h |    3 ++-
 kernel/rcuclassic.c       |   12 +++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff -puN kernel/rcuclassic.c~rcu-softirq kernel/rcuclassic.c
--- linux-2.6.18-rc3-rcu/kernel/rcuclassic.c~rcu-softirq	2006-08-27 01:01:15.000000000 +0530
+++ linux-2.6.18-rc3-rcu-dipankar/kernel/rcuclassic.c	2006-08-27 01:01:15.000000000 +0530
@@ -69,7 +69,6 @@ DEFINE_PER_CPU(struct rcu_data, rcu_data
 DEFINE_PER_CPU(struct rcu_data, rcu_bh_data) = { 0L };
 
 /* Fake initialization required by compiler */
-static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 static int blimit = 10;
 static int qhimark = 10000;
 static int qlowmark = 100;
@@ -212,7 +211,7 @@ static void rcu_do_batch(struct rcu_data
 	if (!rdp->donelist)
 		rdp->donetail = &rdp->donelist;
 	else
-		tasklet_schedule(&per_cpu(rcu_tasklet, rdp->cpu));
+		raise_softirq(RCU_SOFTIRQ);
 }
 
 /*
@@ -363,7 +362,6 @@ static void rcu_offline_cpu(int cpu)
 					&per_cpu(rcu_bh_data, cpu));
 	put_cpu_var(rcu_data);
 	put_cpu_var(rcu_bh_data);
-	tasklet_kill_immediate(&per_cpu(rcu_tasklet, cpu), cpu);
 }
 
 #else
@@ -375,7 +373,7 @@ static void rcu_offline_cpu(int cpu)
 #endif
 
 /*
- * This does the RCU processing work from tasklet context. 
+ * This does the RCU processing work from softirq context. 
  */
 static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp,
 					struct rcu_data *rdp)
@@ -420,7 +418,7 @@ static void __rcu_process_callbacks(stru
 		rcu_do_batch(rdp);
 }
 
-static void rcu_process_callbacks(unsigned long unused)
+static void rcu_process_callbacks(struct softirq_action *unused)
 {
 	__rcu_process_callbacks(&rcu_ctrlblk, &__get_cpu_var(rcu_data));
 	__rcu_process_callbacks(&rcu_bh_ctrlblk, &__get_cpu_var(rcu_bh_data));
@@ -484,7 +482,7 @@ void rcu_check_callbacks(int cpu, int us
 		rcu_bh_qsctr_inc(cpu);
 	} else if (!in_softirq())
 		rcu_bh_qsctr_inc(cpu);
-	tasklet_schedule(&per_cpu(rcu_tasklet, cpu));
+	raise_softirq(RCU_SOFTIRQ);
 }
 
 static void rcu_init_percpu_data(int cpu, struct rcu_ctrlblk *rcp,
@@ -507,7 +505,7 @@ static void __devinit rcu_online_cpu(int
 
 	rcu_init_percpu_data(cpu, &rcu_ctrlblk, rdp);
 	rcu_init_percpu_data(cpu, &rcu_bh_ctrlblk, bh_rdp);
-	tasklet_init(&per_cpu(rcu_tasklet, cpu), rcu_process_callbacks, 0UL);
+	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks, NULL);
 }
 
 static int __devinit rcu_cpu_notify(struct notifier_block *self,
diff -puN include/linux/interrupt.h~rcu-softirq include/linux/interrupt.h
--- linux-2.6.18-rc3-rcu/include/linux/interrupt.h~rcu-softirq	2006-08-27 01:01:15.000000000 +0530
+++ linux-2.6.18-rc3-rcu-dipankar/include/linux/interrupt.h	2006-08-27 01:01:15.000000000 +0530
@@ -219,7 +219,8 @@ enum
 	NET_TX_SOFTIRQ,
 	NET_RX_SOFTIRQ,
 	BLOCK_SOFTIRQ,
-	TASKLET_SOFTIRQ
+	TASKLET_SOFTIRQ,
+	RCU_SOFTIRQ	/* Preferable RCU should always be the last softirq */
 };
 
 /* softirq mask and active fields moved to irq_cpustat_t in

_
