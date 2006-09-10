Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWIJQSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWIJQSG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 12:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWIJQSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 12:18:06 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:30870 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S932286AbWIJQSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 12:18:04 -0400
Date: Sun, 10 Sep 2006 20:18:10 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] force_quiescent_state: factor out duplicated code
Message-ID: <20060910161810.GA10262@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of rcu-simplify-improve-batch-tuning.patch

Cleanup. Move '#ifdef CONFIG_SMP' check and rdp->bhlimit setting
into force_quiescent_state().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 18-rc6/kernel/rcupdate.c~2_fold	2006-09-10 16:56:10.000000000 +0400
+++ 18-rc6/kernel/rcupdate.c	2006-09-10 20:00:31.000000000 +0400
@@ -76,14 +76,17 @@ static atomic_t rcu_barrier_cpu_count;
 static DEFINE_MUTEX(rcu_barrier_mutex);
 static struct completion rcu_barrier_completion;
 
-#ifdef CONFIG_SMP
 static void force_quiescent_state(struct rcu_data *rdp,
-			struct rcu_ctrlblk *rcp)
+				struct rcu_ctrlblk *rcp)
 {
-	int cpu;
-	cpumask_t cpumask;
+	rdp->blimit = INT_MAX;
 	set_need_resched();
+
+#ifdef CONFIG_SMP
 	if (unlikely(!rcp->signaled)) {
+		cpumask_t cpumask;
+		int cpu;
+
 		rcp->signaled = 1;
 		/*
 		 * Don't send IPI to itself. With irqs disabled,
@@ -94,14 +97,8 @@ static void force_quiescent_state(struct
 		for_each_cpu_mask(cpu, cpumask)
 			smp_send_reschedule(cpu);
 	}
-}
-#else
-static inline void force_quiescent_state(struct rcu_data *rdp,
-			struct rcu_ctrlblk *rcp)
-{
-	set_need_resched();
-}
 #endif
+}
 
 /**
  * call_rcu - Queue an RCU callback for invocation after a grace period.
@@ -126,10 +123,9 @@ void fastcall call_rcu(struct rcu_head *
 	rdp = &__get_cpu_var(rcu_data);
 	*rdp->nxttail = head;
 	rdp->nxttail = &head->next;
-	if (unlikely(++rdp->qlen > qhimark)) {
-		rdp->blimit = INT_MAX;
+
+	if (unlikely(++rdp->qlen > qhimark))
 		force_quiescent_state(rdp, &rcu_ctrlblk);
-	}
 	local_irq_restore(flags);
 }
 
@@ -162,11 +158,8 @@ void fastcall call_rcu_bh(struct rcu_hea
 	*rdp->nxttail = head;
 	rdp->nxttail = &head->next;
 
-	if (unlikely(++rdp->qlen > qhimark)) {
-		rdp->blimit = INT_MAX;
+	if (unlikely(++rdp->qlen > qhimark))
 		force_quiescent_state(rdp, &rcu_bh_ctrlblk);
-	}
-
 	local_irq_restore(flags);
 }
 

