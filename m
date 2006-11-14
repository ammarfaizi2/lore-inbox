Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966332AbWKNUeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966332AbWKNUeX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966334AbWKNUeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:34:22 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:65205 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S966332AbWKNUdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:33:49 -0500
Date: Tue, 14 Nov 2006 12:33:37 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Message-Id: <20061114203337.12761.60937.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
References: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 8/8] Add option to serialize load balancing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add option to allow single threading of sched domains

Large sched domains can be very expensive to scan. Add an option
SD_SERIALIZE to the sched domain flags. If that flag is set then
we make sure that no other such domain is being balanced.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm1/include/asm-ia64/topology.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/asm-ia64/topology.h	2006-11-14 14:02:10.000000000 -0600
+++ linux-2.6.19-rc5-mm1/include/asm-ia64/topology.h	2006-11-14 14:03:05.969788964 -0600
@@ -101,6 +101,7 @@ void build_cpu_to_node_map(void);
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_EXEC	\
 				| SD_BALANCE_FORK	\
+				| SD_SERIALIZE		\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 64,			\
Index: linux-2.6.19-rc5-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/linux/sched.h	2006-11-14 14:02:10.000000000 -0600
+++ linux-2.6.19-rc5-mm1/include/linux/sched.h	2006-11-14 14:03:05.988344844 -0600
@@ -647,6 +647,7 @@ enum idle_type
 #define SD_SHARE_CPUPOWER	128	/* Domain members share cpu power */
 #define SD_POWERSAVINGS_BALANCE	256	/* Balance for power savings */
 #define SD_SHARE_PKG_RESOURCES	512	/* Domain members share cpu pkg resources */
+#define SD_SERIALIZE		1024	/* Only a single load balancing instance */
 
 #define BALANCE_FOR_MC_POWER	\
 	(sched_smt_power_savings ? SD_POWERSAVINGS_BALANCE : 0)
Index: linux-2.6.19-rc5-mm1/include/linux/topology.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/linux/topology.h	2006-11-14 14:02:10.000000000 -0600
+++ linux-2.6.19-rc5-mm1/include/linux/topology.h	2006-11-14 14:03:06.000064348 -0600
@@ -194,7 +194,8 @@
 	.wake_idx		= 0, /* unused */	\
 	.forkexec_idx		= 0, /* unused */	\
 	.per_cpu_gain		= 100,			\
-	.flags			= SD_LOAD_BALANCE,	\
+	.flags			= SD_LOAD_BALANCE	\
+				| SD_SERIALIZE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 64,			\
 	.nr_balance_failed	= 0,			\
Index: linux-2.6.19-rc5-mm1/kernel/sched.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/kernel/sched.c	2006-11-14 14:03:01.000000000 -0600
+++ linux-2.6.19-rc5-mm1/kernel/sched.c	2006-11-14 14:03:26.749455649 -0600
@@ -2883,6 +2883,7 @@ static void update_load(struct rq *this_
  *
  * Balancing parameters are set up in arch_init_sched_domains.
  */
+static spinlock_t balancing;
 
 static void run_rebalance_domains(struct softirq_action *h)
 {
@@ -2912,6 +2913,11 @@ static void run_rebalance_domains(struct
 		if (unlikely(!interval))
 			interval = 1;
 
+		if (sd->flags & SD_SERIALIZE) {
+			if (!spin_trylock(&balancing))
+				goto out;
+		}
+
 		if (time_after_eq(jiffies, sd->last_balance + interval)) {
 			if (load_balance(this_cpu, this_rq, sd, idle)) {
 				/*
@@ -2923,6 +2929,9 @@ static void run_rebalance_domains(struct
 			}
 			sd->last_balance = jiffies;
 		}
+		if (sd->flags & SD_SERIALIZE)
+			spin_unlock(&balancing);
+out:
 		if (time_after(next_balance, sd->last_balance + interval))
 			next_balance = sd->last_balance + interval;
 	}
@@ -6986,6 +6996,7 @@ void __init sched_init(void)
 
 #ifdef CONFIG_RT_MUTEXES
 	plist_head_init(&init_task.pi_waiters, &init_task.pi_lock);
+	spin_lock_init(&balancing);
 #endif
 
 	/*
Index: linux-2.6.19-rc5-mm1/include/asm-i386/topology.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/asm-i386/topology.h	2006-11-14 14:02:10.000000000 -0600
+++ linux-2.6.19-rc5-mm1/include/asm-i386/topology.h	2006-11-14 14:03:06.055731993 -0600
@@ -89,6 +89,7 @@ static inline int node_to_first_cpu(int 
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_EXEC	\
 				| SD_BALANCE_FORK	\
+				| SD_SERIALIZE		\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
Index: linux-2.6.19-rc5-mm1/include/asm-powerpc/topology.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/asm-powerpc/topology.h	2006-11-14 14:02:10.000000000 -0600
+++ linux-2.6.19-rc5-mm1/include/asm-powerpc/topology.h	2006-11-14 14:03:06.068428123 -0600
@@ -59,6 +59,7 @@ extern int pcibus_to_node(struct pci_bus
 				| SD_BALANCE_EXEC	\
 				| SD_BALANCE_NEWIDLE	\
 				| SD_WAKE_IDLE		\
+				| SD_SERIALIZE		\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
Index: linux-2.6.19-rc5-mm1/include/asm-x86_64/topology.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/asm-x86_64/topology.h	2006-11-14 14:02:10.000000000 -0600
+++ linux-2.6.19-rc5-mm1/include/asm-x86_64/topology.h	2006-11-14 14:03:06.082100878 -0600
@@ -47,6 +47,7 @@ extern int __node_distance(int, int);
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_FORK	\
 				| SD_BALANCE_EXEC	\
+				| SD_SERIALIZE		\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
