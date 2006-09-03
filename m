Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWICQen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWICQen (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 12:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWICQen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 12:34:43 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:25060 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751418AbWICQem
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 12:34:42 -0400
Date: Sun, 3 Sep 2006 20:34:19 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Eric Dumazet <dada1@cosmosbay.com>,
       "David S. Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] simplify/improve rcu batch tuning
Message-ID: <20060903163419.GA235@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have no idea how to test this patch. It passed rcutorture.ko,
but the "improve" part of the subject is only my speculation, so
please comment.

This patch kills a hard-to-calculate 'rsinterval' boot parameter
and per-cpu rcu_data.last_rs_qlen. Instead, it adds adds a flag
rcu_ctrlblk.signaled, which records the fact that one of CPUs
has sent a resched IPI since the last rcu_start_batch().

Roughly speaking, we need two rcu_start_batch()s in order to move
callbacks from ->nxtlist to ->donelist. This means that when ->qlen
exceeds qhimark and continues to grow, we should send a resched IPI,
and then do it again after we gone through a quiescent state.

On the other hand, if it was already sent, we don't need to do
it again when another CPU detects overflow of the queue.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/Documentation/kernel-parameters.txt~1_auto	2006-08-19 17:50:56.000000000 +0400
+++ 2.6.18-rc4/Documentation/kernel-parameters.txt	2006-09-03 17:47:38.000000000 +0400
@@ -1342,10 +1342,6 @@ running once the system is up.
 	rcu.qlowmark=	[KNL,BOOT] Set threshold of queued
 			RCU callbacks below which batch limiting is re-enabled.
 
-	rcu.rsinterval=	[KNL,BOOT,SMP] Set the number of additional
-			RCU callbacks to queued before forcing reschedule
-			on all cpus.
-
 	rdinit=		[KNL]
 			Format: <full_path>
 			Run specified binary instead of /init from the ramdisk,
--- 2.6.18-rc4/include/linux/rcupdate.h~1_auto	2006-07-16 01:53:08.000000000 +0400
+++ 2.6.18-rc4/include/linux/rcupdate.h	2006-09-03 18:00:59.000000000 +0400
@@ -66,6 +66,8 @@ struct rcu_ctrlblk {
 	long	completed;	/* Number of the last completed batch         */
 	int	next_pending;	/* Is the next batch already waiting?         */
 
+	int	signaled;
+
 	spinlock_t	lock	____cacheline_internodealigned_in_smp;
 	cpumask_t	cpumask; /* CPUs that need to switch in order    */
 	                         /* for current batch to proceed.        */
@@ -106,9 +108,6 @@ struct rcu_data {
 	long		blimit;		 /* Upper limit on a processed batch */
 	int cpu;
 	struct rcu_head barrier;
-#ifdef CONFIG_SMP
-	long		last_rs_qlen;	 /* qlen during the last resched */
-#endif
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
--- 2.6.18-rc4/kernel/rcupdate.c~1_auto	2006-08-19 17:50:56.000000000 +0400
+++ 2.6.18-rc4/kernel/rcupdate.c	2006-09-03 18:01:23.000000000 +0400
@@ -71,9 +71,6 @@ static DEFINE_PER_CPU(struct tasklet_str
 static int blimit = 10;
 static int qhimark = 10000;
 static int qlowmark = 100;
-#ifdef CONFIG_SMP
-static int rsinterval = 1000;
-#endif
 
 static atomic_t rcu_barrier_cpu_count;
 static DEFINE_MUTEX(rcu_barrier_mutex);
@@ -86,8 +83,8 @@ static void force_quiescent_state(struct
 	int cpu;
 	cpumask_t cpumask;
 	set_need_resched();
-	if (unlikely(rdp->qlen - rdp->last_rs_qlen > rsinterval)) {
-		rdp->last_rs_qlen = rdp->qlen;
+	if (unlikely(!rcp->signaled)) {
+		rcp->signaled = 1;
 		/*
 		 * Don't send IPI to itself. With irqs disabled,
 		 * rdp->cpu is the current cpu.
@@ -297,6 +294,7 @@ static void rcu_start_batch(struct rcu_c
 		smp_mb();
 		cpus_andnot(rcp->cpumask, cpu_online_map, nohz_cpu_mask);
 
+		rcp->signaled = 0;
 	}
 }
 
@@ -624,9 +622,6 @@ void synchronize_rcu(void)
 module_param(blimit, int, 0);
 module_param(qhimark, int, 0);
 module_param(qlowmark, int, 0);
-#ifdef CONFIG_SMP
-module_param(rsinterval, int, 0);
-#endif
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
 EXPORT_SYMBOL_GPL(rcu_batches_completed_bh);
 EXPORT_SYMBOL_GPL(call_rcu);


-- 
VGER BF report: U 0.50412
