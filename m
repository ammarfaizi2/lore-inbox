Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161156AbWJXSbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbWJXSbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 14:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161158AbWJXSbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 14:31:48 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:32389 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161156AbWJXSbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 14:31:37 -0400
Date: Tue, 24 Oct 2006 11:31:19 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Message-Id: <20061024183119.4530.64973.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 3/5] Use next_balance instead of last_balance
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use next_balance instead of last_balance ...

The cpu offset calculation in the sched_domains code makes it difficult to
figure out when the next event is supposed to happen since we only keep
track of the last_balancing. We want to know when the next load balance
is supposed to occur.

Move the cpu offset calculation into build_sched_domains(). Do the
setup of the staggered load balance schewduling when the sched domains
are initialized. That way we dont have to worry about it anymore later.

This also in turn simplifies the load balancing time checks.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc2-mm2/include/asm-ia64/topology.h
===================================================================
--- linux-2.6.19-rc2-mm2.orig/include/asm-ia64/topology.h	2006-10-24 10:37:49.925081728 -0500
+++ linux-2.6.19-rc2-mm2/include/asm-ia64/topology.h	2006-10-24 10:39:13.728037801 -0500
@@ -76,7 +76,6 @@ void build_cpu_to_node_map(void);
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
 				| SD_WAKE_AFFINE,	\
-	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
 }
@@ -102,7 +101,6 @@ void build_cpu_to_node_map(void);
 				| SD_BALANCE_EXEC	\
 				| SD_BALANCE_FORK	\
 				| SD_WAKE_BALANCE,	\
-	.last_balance		= jiffies,		\
 	.balance_interval	= 64,			\
 	.nr_balance_failed	= 0,			\
 }
Index: linux-2.6.19-rc2-mm2/include/linux/sched.h
===================================================================
--- linux-2.6.19-rc2-mm2.orig/include/linux/sched.h	2006-10-24 10:37:49.971955705 -0500
+++ linux-2.6.19-rc2-mm2/include/linux/sched.h	2006-10-24 10:39:13.743663180 -0500
@@ -692,7 +692,7 @@ struct sched_domain {
 	int flags;			/* See SD_* */
 
 	/* Runtime fields. */
-	unsigned long last_balance;	/* init to jiffies. units in jiffies */
+	unsigned long next_balance;	/* init to jiffies. units in jiffies */
 	unsigned int balance_interval;	/* initialise to 1. units in ms. */
 	unsigned int nr_balance_failed; /* initialise to 0 */
 
Index: linux-2.6.19-rc2-mm2/include/linux/topology.h
===================================================================
--- linux-2.6.19-rc2-mm2.orig/include/linux/topology.h	2006-10-24 10:37:49.979768034 -0500
+++ linux-2.6.19-rc2-mm2/include/linux/topology.h	2006-10-24 10:39:13.754405628 -0500
@@ -108,7 +108,6 @@
 				| SD_WAKE_AFFINE	\
 				| SD_WAKE_IDLE		\
 				| SD_SHARE_CPUPOWER,	\
-	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
 }
@@ -140,7 +139,6 @@
 				| SD_WAKE_AFFINE	\
 				| SD_SHARE_PKG_RESOURCES\
 				| BALANCE_FOR_MC_POWER,	\
-	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
 }
@@ -170,7 +168,6 @@
 				| SD_BALANCE_EXEC	\
 				| SD_WAKE_AFFINE	\
 				| BALANCE_FOR_PKG_POWER,\
-	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
 }
@@ -195,7 +192,6 @@
 	.forkexec_idx		= 0, /* unused */	\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE,	\
-	.last_balance		= jiffies,		\
 	.balance_interval	= 64,			\
 	.nr_balance_failed	= 0,			\
 }
Index: linux-2.6.19-rc2-mm2/kernel/sched.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/sched.c	2006-10-24 10:39:07.158552011 -0500
+++ linux-2.6.19-rc2-mm2/kernel/sched.c	2006-10-24 10:39:13.782726627 -0500
@@ -2849,17 +2849,10 @@ static void update_load(struct rq *this_
  *
  * Balancing parameters are set up in arch_init_sched_domains.
  */
-
-/* Don't have all balancing operations going off at once: */
-static inline unsigned long cpu_offset(int cpu)
-{
-	return jiffies + cpu * HZ / NR_CPUS;
-}
-
 static void
 rebalance_tick(int this_cpu, struct rq *this_rq, enum idle_type idle)
 {
-	unsigned long interval, j = cpu_offset(this_cpu);
+	unsigned long interval;
 	struct sched_domain *sd;
 
 	for_each_domain(this_cpu, sd) {
@@ -2875,7 +2868,7 @@ rebalance_tick(int this_cpu, struct rq *
 		if (unlikely(!interval))
 			interval = 1;
 
-		if (j - sd->last_balance >= interval) {
+		if (jiffies >= sd->next_balance) {
 			if (load_balance(this_cpu, this_rq, sd, idle)) {
 				/*
 				 * We've pulled tasks over so either we're no
@@ -2884,7 +2877,7 @@ rebalance_tick(int this_cpu, struct rq *
 				 */
 				idle = NOT_IDLE;
 			}
-			sd->last_balance += interval;
+			sd->next_balance += interval;
 		}
 	}
 }
@@ -6445,6 +6438,16 @@ static void init_sched_groups_power(int 
 }
 
 /*
+ * Calculate jiffies start to use for each cpu. On sched domain
+ * initialization this jiffy value is used to stagger the load balancing
+ * of the cpus so that they do not load balance all at at the same time.
+ */
+static inline unsigned long cpu_offset(int cpu)
+{
+	return jiffies + cpu * HZ / NR_CPUS;
+}
+
+/*
  * Build sched domains for a given set of cpus and attach the sched domains
  * to the individual cpus
  */
@@ -6500,6 +6503,7 @@ static int build_sched_domains(const cpu
 			sd->span = *cpu_map;
 			group = cpu_to_allnodes_group(i, cpu_map);
 			sd->groups = &sched_group_allnodes[group];
+			sd->next_balance = cpu_offset(i);
 			p = sd;
 		} else
 			p = NULL;
@@ -6508,6 +6512,7 @@ static int build_sched_domains(const cpu
 		*sd = SD_NODE_INIT;
 		sd->span = sched_domain_node_span(cpu_to_node(i));
 		sd->parent = p;
+		sd->next_balance = cpu_offset(i);
 		if (p)
 			p->child = sd;
 		cpus_and(sd->span, sd->span, *cpu_map);
@@ -6519,6 +6524,7 @@ static int build_sched_domains(const cpu
 		*sd = SD_CPU_INIT;
 		sd->span = nodemask;
 		sd->parent = p;
+		sd->next_balance = cpu_offset(i);
 		if (p)
 			p->child = sd;
 		sd->groups = &sched_group_phys[group];
@@ -6531,6 +6537,7 @@ static int build_sched_domains(const cpu
 		sd->span = cpu_coregroup_map(i);
 		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
+		sd->next_balance = cpu_offset(i);
 		p->child = sd;
 		sd->groups = &sched_group_core[group];
 #endif
@@ -6543,6 +6550,7 @@ static int build_sched_domains(const cpu
 		sd->span = cpu_sibling_map[i];
 		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
+		sd->next_balance = cpu_offset(i);
 		p->child = sd;
 		sd->groups = &sched_group_cpus[group];
 #endif
Index: linux-2.6.19-rc2-mm2/include/asm-i386/topology.h
===================================================================
--- linux-2.6.19-rc2-mm2.orig/include/asm-i386/topology.h	2006-10-24 10:37:49.988556905 -0500
+++ linux-2.6.19-rc2-mm2/include/asm-i386/topology.h	2006-10-24 10:39:13.799328592 -0500
@@ -90,7 +90,6 @@ static inline int node_to_first_cpu(int 
 				| SD_BALANCE_EXEC	\
 				| SD_BALANCE_FORK	\
 				| SD_WAKE_BALANCE,	\
-	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
 }
Index: linux-2.6.19-rc2-mm2/include/asm-powerpc/topology.h
===================================================================
--- linux-2.6.19-rc2-mm2.orig/include/asm-powerpc/topology.h	2006-10-24 10:37:49.998322317 -0500
+++ linux-2.6.19-rc2-mm2/include/asm-powerpc/topology.h	2006-10-24 10:39:13.816907143 -0500
@@ -60,7 +60,6 @@ extern int pcibus_to_node(struct pci_bus
 				| SD_BALANCE_NEWIDLE	\
 				| SD_WAKE_IDLE		\
 				| SD_WAKE_BALANCE,	\
-	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
 }
Index: linux-2.6.19-rc2-mm2/include/asm-x86_64/topology.h
===================================================================
--- linux-2.6.19-rc2-mm2.orig/include/asm-x86_64/topology.h	2006-10-24 10:37:50.007111192 -0500
+++ linux-2.6.19-rc2-mm2/include/asm-x86_64/topology.h	2006-10-24 10:39:13.826673004 -0500
@@ -48,7 +48,6 @@ extern int __node_distance(int, int);
 				| SD_BALANCE_FORK	\
 				| SD_BALANCE_EXEC	\
 				| SD_WAKE_BALANCE,	\
-	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
 }
Index: linux-2.6.19-rc2-mm2/include/asm-mips/mach-ip27/topology.h
===================================================================
--- linux-2.6.19-rc2-mm2.orig/include/asm-mips/mach-ip27/topology.h	2006-10-24 10:37:50.018829694 -0500
+++ linux-2.6.19-rc2-mm2/include/asm-mips/mach-ip27/topology.h	2006-10-24 10:39:13.841321797 -0500
@@ -33,7 +33,6 @@ extern unsigned char __node_distances[MA
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_EXEC	\
 				| SD_WAKE_BALANCE,	\
-	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
 }
