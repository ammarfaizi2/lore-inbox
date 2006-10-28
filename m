Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbWJ1Cls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWJ1Cls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 22:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbWJ1Cls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 22:41:48 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:40138 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751624AbWJ1Clr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 22:41:47 -0400
Date: Fri, 27 Oct 2006 19:41:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20061028024133.10809.18860.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061028024112.10809.15841.sendpatchset@schroedinger.engr.sgi.com>
References: <20061028024112.10809.15841.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 4/7] Stagger load balancing in build_sched_domains
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stagger load balancing in build_sched_domains

Instead of dealing with the staggering of load balancing
during actual load balancing we just do it once when the sched domains
set up.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc3/kernel/sched.c
===================================================================
--- linux-2.6.19-rc3.orig/kernel/sched.c	2006-10-27 15:35:40.221104772 -0500
+++ linux-2.6.19-rc3/kernel/sched.c	2006-10-27 15:37:36.526511796 -0500
@@ -2848,17 +2848,10 @@ static void update_load(struct rq *this_
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
@@ -2874,7 +2867,7 @@ rebalance_tick(int this_cpu, struct rq *
 		if (unlikely(!interval))
 			interval = 1;
 
-		if (j - sd->last_balance >= interval) {
+		if (jiffies - sd->last_balance >= interval) {
 			if (load_balance(this_cpu, this_rq, sd, idle)) {
 				/*
 				 * We've pulled tasks over so either we're no
@@ -6327,6 +6320,16 @@ static void init_sched_groups_power(int 
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
@@ -6382,6 +6385,7 @@ static int build_sched_domains(const cpu
 			sd->span = *cpu_map;
 			group = cpu_to_allnodes_group(i, cpu_map);
 			sd->groups = &sched_group_allnodes[group];
+			sd->last_balance = cpu_offset(i);
 			p = sd;
 		} else
 			p = NULL;
@@ -6390,6 +6394,7 @@ static int build_sched_domains(const cpu
 		*sd = SD_NODE_INIT;
 		sd->span = sched_domain_node_span(cpu_to_node(i));
 		sd->parent = p;
+		sd->last_balance = cpu_offset(i);
 		if (p)
 			p->child = sd;
 		cpus_and(sd->span, sd->span, *cpu_map);
@@ -6401,6 +6406,7 @@ static int build_sched_domains(const cpu
 		*sd = SD_CPU_INIT;
 		sd->span = nodemask;
 		sd->parent = p;
+		sd->last_balance = cpu_offset(i);
 		if (p)
 			p->child = sd;
 		sd->groups = &sched_group_phys[group];
@@ -6413,6 +6419,7 @@ static int build_sched_domains(const cpu
 		sd->span = cpu_coregroup_map(i);
 		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
+		sd->last_balance = cpu_offset(i);
 		p->child = sd;
 		sd->groups = &sched_group_core[group];
 #endif
@@ -6425,6 +6432,7 @@ static int build_sched_domains(const cpu
 		sd->span = cpu_sibling_map[i];
 		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
+		sd->last_balance = cpu_offset(i);
 		p->child = sd;
 		sd->groups = &sched_group_cpus[group];
 #endif
