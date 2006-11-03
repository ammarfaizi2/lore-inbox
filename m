Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753532AbWKCUrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbWKCUrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWKCUrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:47:03 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50898 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753532AbWKCUq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:46:58 -0500
Date: Fri, 3 Nov 2006 12:46:56 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20061103204656.15739.37599.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061103204636.15739.74831.sendpatchset@schroedinger.engr.sgi.com>
References: <20061103204636.15739.74831.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 4/7] Stagger load balancing in build_sched_domains
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6.19-rc4-mm2/kernel/sched.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/kernel/sched.c	2006-11-03 12:51:52.997976327 -0600
+++ linux-2.6.19-rc4-mm2/kernel/sched.c	2006-11-03 12:53:23.254849673 -0600
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
+		if (jiffies - sd->last_balance >= interval) {
 			if (load_balance(this_cpu, this_rq, sd, idle)) {
 				/*
 				 * We've pulled tasks over so either we're no
@@ -6447,6 +6440,16 @@ static void init_sched_groups_power(int 
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
@@ -6502,6 +6505,7 @@ static int build_sched_domains(const cpu
 			sd->span = *cpu_map;
 			group = cpu_to_allnodes_group(i, cpu_map);
 			sd->groups = &sched_group_allnodes[group];
+			sd->last_balance = cpu_offset(i);
 			p = sd;
 		} else
 			p = NULL;
@@ -6510,6 +6514,7 @@ static int build_sched_domains(const cpu
 		*sd = SD_NODE_INIT;
 		sd->span = sched_domain_node_span(cpu_to_node(i));
 		sd->parent = p;
+		sd->last_balance = cpu_offset(i);
 		if (p)
 			p->child = sd;
 		cpus_and(sd->span, sd->span, *cpu_map);
@@ -6521,6 +6526,7 @@ static int build_sched_domains(const cpu
 		*sd = SD_CPU_INIT;
 		sd->span = nodemask;
 		sd->parent = p;
+		sd->last_balance = cpu_offset(i);
 		if (p)
 			p->child = sd;
 		sd->groups = &sched_group_phys[group];
@@ -6533,6 +6539,7 @@ static int build_sched_domains(const cpu
 		sd->span = cpu_coregroup_map(i);
 		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
+		sd->last_balance = cpu_offset(i);
 		p->child = sd;
 		sd->groups = &sched_group_core[group];
 #endif
@@ -6545,6 +6552,7 @@ static int build_sched_domains(const cpu
 		sd->span = cpu_sibling_map[i];
 		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
+		sd->last_balance = cpu_offset(i);
 		p->child = sd;
 		sd->groups = &sched_group_cpus[group];
 #endif
