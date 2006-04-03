Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWDCUkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWDCUkP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 16:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWDCUkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 16:40:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:4840 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964876AbWDCUkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 16:40:12 -0400
Date: Mon, 3 Apr 2006 15:39:58 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: mason@suse.de, Christoph Lameter <clameter@sgi.com>
Subject: [PATCH 2/2] dynamic configuration for remote rcu callback processing
Message-ID: <20060403203958.GB8178@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the ability to dynamically configure processors for remote
rcu callback processing.  It applies on top of PATCH 1/2.

Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux/include/linux/rcupdate.h
===================================================================
--- linux.orig/include/linux/rcupdate.h	2006-04-03 15:26:38.743863052 -0500
+++ linux/include/linux/rcupdate.h	2006-04-03 15:26:43.863355795 -0500
@@ -109,6 +109,7 @@ struct rcu_data {
 #ifdef CONFIG_SMP
 	long		last_rs_qlen;	 /* qlen during the last resched */
 	spinlock_t	rmlock;		 /* for use with remote callback */
+	short		batch_stat;	 /* indicate processing being done */
 #endif
 };
 
Index: linux/kernel/rcupdate.c
===================================================================
--- linux.orig/kernel/rcupdate.c	2006-04-03 15:26:38.743863052 -0500
+++ linux/kernel/rcupdate.c	2006-04-03 15:26:43.867355399 -0500
@@ -195,7 +195,7 @@ static int rcu_next_remotercu(void)
 /*
  * Configure a cpu for remote rcu callback processing.
  */
-static int rcu_set_remote_rcu(int cpu) {
+int rcu_set_remote_rcu(int cpu) {
 	unsigned long flags;
 
 	if (cpu < NR_CPUS) {
@@ -206,11 +206,12 @@ static int rcu_set_remote_rcu(int cpu) {
 	} else
 		return 1;
 }
+EXPORT_SYMBOL_GPL(rcu_set_remote_rcu);
 
 /*
  * Configure a cpu for standard rcu callback processing.
  */
-static void rcu_clear_remote_rcu(int cpu) {
+void rcu_clear_remote_rcu(int cpu) {
 	unsigned long flags;
 
 	if (cpu < NR_CPUS) {
@@ -219,6 +220,7 @@ static void rcu_clear_remote_rcu(int cpu
 		spin_unlock_irqrestore(&cpu_remotercu_lock, flags);
 	}
 }
+EXPORT_SYMBOL_GPL(rcu_clear_remote_rcu);
 
 /*
  * Configure a set of cpus at boot time for remote rcu callback
@@ -238,7 +240,6 @@ static int __init rcu_remotercu_cpu_setu
 
 __setup ("remotercu=", rcu_remotercu_cpu_setup);
 #else
-static int rcu_callbacks_processed_remotely(int cpu) { return 0; }
 static int rcu_process_remote(int cpu) { return 0; }
 static void rcu_clear_remote_rcu(int cpu) {}
 #endif
@@ -650,8 +651,16 @@ static void __rcu_process_callbacks(stru
 	}
 
 	rcu_check_quiescent_state(rcp, rdp);
-	if (!rcu_callbacks_processed_remotely(cpu) && rdp->donelist)
+#ifdef CONFIG_NUMA
+	if (rdp->donelist && !rcu_callbacks_processed_remotely(cpu) &&
+			(cmpxchg(&rdp->batch_stat, 0, 1)) == 0) {
 		rcu_do_batch(rdp);
+		rdp->batch_stat = 0;
+	}
+#else
+	if (rdp->donelist)
+		rcu_do_batch(rdp);
+#endif
 }
 
 static void rcu_process_callbacks(unsigned long unused)
@@ -692,15 +701,25 @@ static void rcu_process_remote_callbacks
 	 */
 	rdp = &per_cpu(rcu_data, cpu);
 	if (spin_trylock_irq(&rdp->rmlock)) {
-		if ((list=xchg(&rdp->donelist, NULL))!=NULL)
-			rdp->donetail = &rdp->donelist;
+		/*
+		 * batch_stat ensures cpu isn't still running rcu_do_batch.
+		 * This can happen if we've just configured on the fly.
+		 */
+		if (cmpxchg(&rdp->batch_stat, 0, 2) == 0) {
+			list=xchg(&rdp->donelist, NULL);
+			if (list != NULL)
+				rdp->donetail = &rdp->donelist;
+		}
 		spin_unlock_irq(&rdp->rmlock);
 	}
 
 	rdp_bh = &per_cpu(rcu_bh_data, cpu);
 	if (spin_trylock_irq(&rdp_bh->rmlock)) {
-		if ((list_bh=xchg(&rdp_bh->donelist, NULL))!=NULL)
-			rdp_bh->donetail = &rdp_bh->donelist;
+		if (cmpxchg(&rdp_bh->batch_stat, 0, 2) == 0) {
+			list_bh=xchg(&rdp_bh->donelist, NULL);
+			if (list_bh != NULL)
+				rdp_bh->donetail = &rdp_bh->donelist;
+		}
 		spin_unlock_irq(&rdp_bh->rmlock);
 	}
 
@@ -717,6 +736,8 @@ static void rcu_process_remote_callbacks
 		old = rdp->qlen;
 		new = old - cnt;
 	} while (cmpxchg(&rdp->qlen, old, new)!=old);
+	if (rdp->batch_stat == 2)
+		rdp->batch_stat = 0;
 
 	cnt=0;
 	while (list_bh) {
@@ -729,6 +750,8 @@ static void rcu_process_remote_callbacks
 		old = rdp_bh->qlen;
 		new = old - cnt;
 	} while (cmpxchg(&rdp_bh->qlen, old, new)!=old);
+	if (rdp_bh->batch_stat == 2)
+		rdp_bh->batch_stat = 0;
 }
 #else
 static void rcu_process_remote_callbacks(unsigned long unused) {}
