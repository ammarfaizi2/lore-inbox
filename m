Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWIUV4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWIUV4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWIUV4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:56:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:11880 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1751638AbWIUV4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:56:07 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,196,1157353200"; 
   d="scan'208"; a="132249406:sNHT105615118"
Date: Thu, 21 Sep 2006 14:39:24 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: akpm@osdl.org
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, pj@sgi.com,
       linux-kernel@vger.kernel.org, suresh.b.siddha@intel.com
Subject: [patch 1/2] sched: introduce child field in sched_domain
Message-ID: <20060921143924.A25601@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please drop sched-generic-sched_group-cpu-power-setup.patch in your
-mm tree and add these two split up patches instead.

First patch appended and second patch will follow this.

thanks,
suresh
---

From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>

Introduce the child field in sched_domain struct and use it in
sched_balance_self().

We will also use this field in cleaning up the sched group cpu_power
setup(done in a different patch) code.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>
---

diff -pNru linux-2.6.18/include/asm-i386/topology.h linux-child/include/asm-i386/topology.h
--- linux-2.6.18/include/asm-i386/topology.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-child/include/asm-i386/topology.h	2006-09-20 18:45:01.000000000 -0700
@@ -74,6 +74,7 @@ static inline int node_to_first_cpu(int 
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 8,			\
 	.max_interval		= 32,			\
diff -pNru linux-2.6.18/include/asm-ia64/topology.h linux-child/include/asm-ia64/topology.h
--- linux-2.6.18/include/asm-ia64/topology.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-child/include/asm-ia64/topology.h	2006-09-20 18:45:01.000000000 -0700
@@ -59,6 +59,7 @@ void build_cpu_to_node_map(void);
 #define SD_CPU_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 1,			\
 	.max_interval		= 4,			\
@@ -84,6 +85,7 @@ void build_cpu_to_node_map(void);
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 8,			\
 	.max_interval		= 8*(min(num_online_cpus(), 32)), \
diff -pNru linux-2.6.18/include/asm-mips/mach-ip27/topology.h linux-child/include/asm-mips/mach-ip27/topology.h
--- linux-2.6.18/include/asm-mips/mach-ip27/topology.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-child/include/asm-mips/mach-ip27/topology.h	2006-09-20 18:45:01.000000000 -0700
@@ -22,6 +22,7 @@ extern unsigned char __node_distances[MA
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 8,			\
 	.max_interval		= 32,			\
diff -pNru linux-2.6.18/include/asm-powerpc/topology.h linux-child/include/asm-powerpc/topology.h
--- linux-2.6.18/include/asm-powerpc/topology.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-child/include/asm-powerpc/topology.h	2006-09-20 18:45:01.000000000 -0700
@@ -43,6 +43,7 @@ extern int pcibus_to_node(struct pci_bus
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 8,			\
 	.max_interval		= 32,			\
diff -pNru linux-2.6.18/include/asm-x86_64/topology.h linux-child/include/asm-x86_64/topology.h
--- linux-2.6.18/include/asm-x86_64/topology.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-child/include/asm-x86_64/topology.h	2006-09-20 18:45:01.000000000 -0700
@@ -31,6 +31,7 @@ extern int __node_distance(int, int);
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 8,			\
 	.max_interval		= 32,			\
diff -pNru linux-2.6.18/include/linux/sched.h linux-child/include/linux/sched.h
--- linux-2.6.18/include/linux/sched.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-child/include/linux/sched.h	2006-09-20 18:45:01.000000000 -0700
@@ -642,6 +642,7 @@ struct sched_group {
 struct sched_domain {
 	/* These fields must be setup */
 	struct sched_domain *parent;	/* top domain must be null terminated */
+	struct sched_domain *child;	/* bottom domain must be null terminated */
 	struct sched_group *groups;	/* the balancing groups of the domain */
 	cpumask_t span;			/* span of all CPUs in this domain */
 	unsigned long min_interval;	/* Minimum balance interval ms */
diff -pNru linux-2.6.18/include/linux/topology.h linux-child/include/linux/topology.h
--- linux-2.6.18/include/linux/topology.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-child/include/linux/topology.h	2006-09-20 18:45:51.000000000 -0700
@@ -89,6 +89,7 @@
 #define SD_SIBLING_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 1,			\
 	.max_interval		= 2,			\
@@ -119,6 +120,7 @@
 #define SD_CPU_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 1,			\
 	.max_interval		= 4,			\
@@ -146,6 +148,7 @@
 #define SD_ALLNODES_INIT (struct sched_domain) {	\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 64,			\
 	.max_interval		= 64*num_online_cpus(),	\
diff -pNru linux-2.6.18/kernel/sched.c linux-child/kernel/sched.c
--- linux-2.6.18/kernel/sched.c	2006-09-19 20:42:06.000000000 -0700
+++ linux-child/kernel/sched.c	2006-09-20 18:45:01.000000000 -0700
@@ -1276,21 +1276,29 @@ static int sched_balance_self(int cpu, i
 	while (sd) {
 		cpumask_t span;
 		struct sched_group *group;
-		int new_cpu;
-		int weight;
+		int new_cpu, weight;
+
+		if (!(sd->flags & flag)) {
+			sd = sd->child;
+			continue;
+		}
 
 		span = sd->span;
 		group = find_idlest_group(sd, t, cpu);
-		if (!group)
-			goto nextlevel;
+		if (!group) {
+			sd = sd->child;
+			continue;
+		}
 
 		new_cpu = find_idlest_cpu(group, t, cpu);
-		if (new_cpu == -1 || new_cpu == cpu)
-			goto nextlevel;
+		if (new_cpu == -1 || new_cpu == cpu) {
+			/* Now try balancing at a lower domain level of cpu */
+			sd = sd->child;
+			continue;
+		}
 
-		/* Now try balancing at a lower domain level */
+		/* Now try balancing at a lower domain level of new_cpu */
 		cpu = new_cpu;
-nextlevel:
 		sd = NULL;
 		weight = cpus_weight(span);
 		for_each_domain(cpu, tmp) {
@@ -5404,12 +5412,18 @@ static void cpu_attach_domain(struct sch
 		struct sched_domain *parent = tmp->parent;
 		if (!parent)
 			break;
-		if (sd_parent_degenerate(tmp, parent))
+		if (sd_parent_degenerate(tmp, parent)) {
 			tmp->parent = parent->parent;
+			if (parent->parent)
+				parent->parent->child = tmp;
+		}
 	}
 
-	if (sd && sd_degenerate(sd))
+	if (sd && sd_degenerate(sd)) {
 		sd = sd->parent;
+		if (sd)
+			sd->child = NULL;
+	}
 
 	sched_domain_debug(sd, cpu);
 
@@ -6248,6 +6262,8 @@ static int build_sched_domains(const cpu
 		*sd = SD_NODE_INIT;
 		sd->span = sched_domain_node_span(cpu_to_node(i));
 		sd->parent = p;
+		if (p)
+			p->child = sd;
 		cpus_and(sd->span, sd->span, *cpu_map);
 #endif
 
@@ -6269,6 +6285,8 @@ static int build_sched_domains(const cpu
 		*sd = SD_CPU_INIT;
 		sd->span = nodemask;
 		sd->parent = p;
+		if (p)
+			p->child = sd;
 		sd->groups = &sched_group_phys[group];
 
 #ifdef CONFIG_SCHED_MC
@@ -6291,6 +6309,7 @@ static int build_sched_domains(const cpu
 		sd->span = cpu_coregroup_map(i);
 		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
+		p->child = sd;
 		sd->groups = &sched_group_core[group];
 #endif
 
@@ -6302,6 +6321,7 @@ static int build_sched_domains(const cpu
 		sd->span = cpu_sibling_map[i];
 		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
+		p->child = sd;
 		sd->groups = &sched_group_cpus[group];
 #endif
 	}
