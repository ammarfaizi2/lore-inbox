Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268541AbUIGS4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268541AbUIGS4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268440AbUIGSy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:54:29 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:39861 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268430AbUIGSty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:49:54 -0400
Message-Id: <200409071849.i87Inq3f149466@austin.ibm.com>
Subject: [patch 1/2] parameterize arch_init_sched_domains
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rusty@rustcorp.com.au, piggin@cyberone.com.au,
       nathanl@austin.ibm.com
From: nathanl@austin.ibm.com
Date: Tue,  7 Sep 2004 13:50:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On some systems (e.g. ppc64 partitions), we don't have topology and
associativity information for all "possible" cpus, so it doesn't make
sense to set up domains for them.  Make arch_init_sched_domains take a
cpumask_t argument, which is used instead of cpu_possible_map to set
up the domains and groups.  At boot, call arch_init_sched_domains with
the online map as argument.  This leaves offline cpus attached to the
dummy sched_domain_init domain, which should be fine.

A followup patch will handle cpus which are onlined after boot.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN kernel/sched.c~parameterize-arch_init_sched_domains kernel/sched.c
--- 2.6.9-rc1-bk14/kernel/sched.c~parameterize-arch_init_sched_domains	2004-09-07 13:02:39.000000000 -0500
+++ 2.6.9-rc1-bk14-nathanl/kernel/sched.c	2004-09-07 13:29:51.000000000 -0500
@@ -4394,21 +4394,19 @@ __init static void init_sched_build_grou
 	last->next = first;
 }
 
-__init static void arch_init_sched_domains(void)
+__init static void arch_init_sched_domains(cpumask_t cpu_default_map)
 {
 	int i;
-	cpumask_t cpu_default_map;
-
 	/*
 	 * Setup mask for cpus without special case scheduling requirements.
 	 * For now this just excludes isolated cpus, but could be used to
 	 * exclude other special cases in the future.
 	 */
-	cpus_complement(cpu_default_map, cpu_isolated_map);
-	cpus_and(cpu_default_map, cpu_default_map, cpu_possible_map);
+	for_each_cpu_mask(i, cpu_isolated_map)
+		cpu_clear(i, cpu_default_map);
 
 	/* Set up domains */
-	for_each_cpu(i) {
+	for_each_cpu_mask(i, cpu_default_map) {
 		int group;
 		struct sched_domain *sd = NULL, *p;
 		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
@@ -4454,7 +4452,7 @@ __init static void arch_init_sched_domai
 #ifdef CONFIG_NUMA
 		sd->span = nodemask;
 #else
-		sd->span = cpu_possible_map;
+		sd->span = cpu_default_map;
 #endif
 		sd->parent = p;
 		sd->groups = &sched_group_phys[group];
@@ -4473,7 +4471,7 @@ __init static void arch_init_sched_domai
 
 #ifdef CONFIG_SCHED_SMT
 	/* Set up CPU (sibling) groups */
-	for_each_cpu(i) {
+	for_each_cpu_mask(i, cpu_default_map) {
 		cpumask_t this_sibling_map = cpu_sibling_map[i];
 		cpus_and(this_sibling_map, this_sibling_map, cpu_default_map);
 		if (i != first_cpu(this_sibling_map))
@@ -4506,7 +4504,7 @@ __init static void arch_init_sched_domai
 						&cpu_to_phys_group);
 	}
 #else
-	init_sched_build_groups(sched_group_phys, cpu_possible_map,
+	init_sched_build_groups(sched_group_phys, cpu_default_map,
 							&cpu_to_phys_group);
 #endif
 
@@ -4541,7 +4539,7 @@ __init static void arch_init_sched_domai
 	}
 
 	/* Attach the domains */
-	for_each_cpu(i) {
+	for_each_cpu_mask(i, cpu_default_map) {
 		struct sched_domain *sd;
 #ifdef CONFIG_SCHED_SMT
 		sd = &per_cpu(cpu_domains, i);
@@ -4634,7 +4632,7 @@ void sched_domain_debug(void)
 
 void __init sched_init_smp(void)
 {
-	arch_init_sched_domains();
+	arch_init_sched_domains(cpu_online_map);
 	sched_domain_debug();
 }
 #else

_
