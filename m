Return-Path: <linux-kernel-owner+w=401wt.eu-S1751385AbXAOTX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbXAOTX2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbXAOTX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:23:28 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:55901 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbXAOTX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:23:27 -0500
Date: Tue, 16 Jan 2007 00:52:48 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul E McKenney <paulmck@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [mm PATCH 2/6] RCU: softirq for RCU
Message-ID: <20070115192247.GC32238@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20070115191909.GA32238@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115191909.GA32238@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Finally, RCU gets its own softirq. With it being used extensively,
the per-cpu tasklet used earlier was just a softirq with overheads.
This makes things more efficient.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---



diff -puN include/linux/interrupt.h~rcu-softirq include/linux/interrupt.h
--- linux-2.6.20-rc3-mm1-rcu/include/linux/interrupt.h~rcu-softirq	2007-01-15 15:36:43.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/include/linux/interrupt.h	2007-01-15 15:36:43.000000000 +0530
@@ -236,6 +236,7 @@ enum
 #ifdef CONFIG_HIGH_RES_TIMERS
 	HRTIMER_SOFTIRQ,
 #endif
+	RCU_SOFTIRQ	/* Preferable RCU should always be the last softirq */
 };
 
 /* softirq mask and active fields moved to irq_cpustat_t in
diff -puN kernel/rcuclassic.c~rcu-softirq kernel/rcuclassic.c
--- linux-2.6.20-rc3-mm1-rcu/kernel/rcuclassic.c~rcu-softirq	2007-01-15 15:36:43.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/kernel/rcuclassic.c	2007-01-15 15:36:43.000000000 +0530
@@ -69,7 +69,6 @@ DEFINE_PER_CPU(struct rcu_data, rcu_data
 DEFINE_PER_CPU(struct rcu_data, rcu_bh_data) = { 0L };
 
 /* Fake initialization required by compiler */
-static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 static int blimit = 10;
 static int qhimark = 10000;
 static int qlowmark = 100;
@@ -215,7 +214,7 @@ static void rcu_do_batch(struct rcu_data
 	if (!rdp->donelist)
 		rdp->donetail = &rdp->donelist;
 	else
-		tasklet_schedule(&per_cpu(rcu_tasklet, rdp->cpu));
+		raise_softirq(RCU_SOFTIRQ);
 }
 
 /*
@@ -367,7 +366,6 @@ static void rcu_offline_cpu(int cpu)
 					&per_cpu(rcu_bh_data, cpu));
 	put_cpu_var(rcu_data);
 	put_cpu_var(rcu_bh_data);
-	tasklet_kill_immediate(&per_cpu(rcu_tasklet, cpu), cpu);
 }
 
 #else
@@ -379,7 +377,7 @@ static void rcu_offline_cpu(int cpu)
 #endif
 
 /*
- * This does the RCU processing work from tasklet context. 
+ * This does the RCU processing work from softirq context. 
  */
 static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp,
 					struct rcu_data *rdp)
@@ -424,7 +422,7 @@ static void __rcu_process_callbacks(stru
 		rcu_do_batch(rdp);
 }
 
-static void rcu_process_callbacks(unsigned long unused)
+static void rcu_process_callbacks(struct softirq_action *unused)
 {
 	__rcu_process_callbacks(&rcu_ctrlblk, &__get_cpu_var(rcu_data));
 	__rcu_process_callbacks(&rcu_bh_ctrlblk, &__get_cpu_var(rcu_bh_data));
@@ -488,7 +486,7 @@ void rcu_check_callbacks(int cpu, int us
 		rcu_bh_qsctr_inc(cpu);
 	} else if (!in_softirq())
 		rcu_bh_qsctr_inc(cpu);
-	tasklet_schedule(&per_cpu(rcu_tasklet, cpu));
+	raise_softirq(RCU_SOFTIRQ);
 }
 
 static void rcu_init_percpu_data(int cpu, struct rcu_ctrlblk *rcp,
@@ -511,7 +509,7 @@ static void __devinit rcu_online_cpu(int
 
 	rcu_init_percpu_data(cpu, &rcu_ctrlblk, rdp);
 	rcu_init_percpu_data(cpu, &rcu_bh_ctrlblk, bh_rdp);
-	tasklet_init(&per_cpu(rcu_tasklet, cpu), rcu_process_callbacks, 0UL);
+	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks, NULL);
 }
 
 static int __cpuinit rcu_cpu_notify(struct notifier_block *self,

_
