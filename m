Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbUCLFO2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 00:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbUCLFO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 00:14:28 -0500
Received: from dp.samba.org ([66.70.73.150]:3272 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261962AbUCLFOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 00:14:17 -0500
Date: Fri, 12 Mar 2004 16:11:35 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040312051135.GI16751@krispykreme>
References: <20040310233140.3ce99610.akpm@osdl.org> <20040311134955.GB16751@krispykreme> <4050F657.3050005@cyberone.com.au> <40511A89.3040204@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40511A89.3040204@cyberone.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> You need to be setting cpu_power for each of the CPU groups.

Thanks Nick, that fixed it. New patch attached, its basically the x86
version with cpumask fixes when compiling with NR_CPUS > 64.

Anton

---

 gr25_work-anton/arch/ppc64/Kconfig            |   10 +
 gr25_work-anton/arch/ppc64/kernel/smp.c       |  222 ++++++++++++++++++++++++++
 gr25_work-anton/include/asm-ppc64/processor.h |    5 
 3 files changed, 237 insertions(+)

diff -puN arch/ppc64/Kconfig~sched-ppc64bits arch/ppc64/Kconfig
--- gr25_work/arch/ppc64/Kconfig~sched-ppc64bits	2004-03-11 21:27:02.655467583 -0600
+++ gr25_work-anton/arch/ppc64/Kconfig	2004-03-11 21:27:02.671465046 -0600
@@ -175,6 +175,16 @@ config NUMA
 	bool "NUMA support"
 	depends on DISCONTIGMEM
 
+config SCHED_SMT
+	bool "SMT (Hyperthreading) scheduler support"
+	depends on SMP
+	default off
+	help
+	  SMT scheduler support improves the CPU scheduler's decision making
+	  when dealing with Intel Pentium 4 chips with HyperThreading at a
+	  cost of slightly increased overhead in some places. If unsure say
+	  N here.
+
 config PREEMPT
 	bool
 	help
diff -puN arch/ppc64/kernel/smp.c~sched-ppc64bits arch/ppc64/kernel/smp.c
--- gr25_work/arch/ppc64/kernel/smp.c~sched-ppc64bits	2004-03-11 21:27:02.660466790 -0600
+++ gr25_work-anton/arch/ppc64/kernel/smp.c	2004-03-11 21:57:09.897044235 -0600
@@ -890,3 +890,225 @@ static int __init topology_init(void)
 	return 0;
 }
 __initcall(topology_init);
+
+#ifdef CONFIG_SCHED_SMT
+#ifdef CONFIG_NUMA
+static struct sched_group sched_group_cpus[NR_CPUS];
+static struct sched_group sched_group_phys[NR_CPUS];
+static struct sched_group sched_group_nodes[MAX_NUMNODES];
+static DEFINE_PER_CPU(struct sched_domain, phys_domains);
+static DEFINE_PER_CPU(struct sched_domain, node_domains);
+__init void arch_init_sched_domains(void)
+{
+	int i;
+	struct sched_group *first_cpu = NULL, *last_cpu = NULL;
+
+	/* Set up domains */
+	for_each_cpu(i) {
+		struct sched_domain *cpu_domain = cpu_sched_domain(i);
+		struct sched_domain *phys_domain = &per_cpu(phys_domains, i);
+		struct sched_domain *node_domain = &per_cpu(node_domains, i);
+		int node = cpu_to_node(i);
+		cpumask_t nodemask = node_to_cpumask(node);
+		cpumask_t tmp1 = cpumask_of_cpu(i ^ 0x1);
+		cpumask_t tmp2 = cpumask_of_cpu(i);
+
+		*cpu_domain = SD_SIBLING_INIT;
+		cpus_or(cpu_domain->span, tmp1, tmp2);
+
+		*phys_domain = SD_CPU_INIT;
+		phys_domain->span = nodemask;
+
+		*node_domain = SD_NODE_INIT;
+		node_domain->span = cpu_possible_map;
+	}
+
+	/* Set up CPU (sibling) groups */
+	for_each_cpu(i) {
+		struct sched_domain *cpu_domain = cpu_sched_domain(i);
+		int j;
+		first_cpu = last_cpu = NULL;
+
+		if (i != first_cpu(cpu_domain->span)) {
+			cpu_sched_domain(i)->flags |= SD_FLAG_SHARE_CPUPOWER;
+			cpu_sched_domain(first_cpu(cpu_domain->span))->flags |=
+				SD_FLAG_SHARE_CPUPOWER;
+			continue;
+		}
+
+		for_each_cpu_mask(j, cpu_domain->span) {
+			struct sched_group *cpu = &sched_group_cpus[j];
+
+			cpus_clear(cpu->cpumask);
+			cpu_set(j, cpu->cpumask);
+			cpu->cpu_power = SCHED_LOAD_SCALE;
+
+			if (!first_cpu)
+				first_cpu = cpu;
+			if (last_cpu)
+				last_cpu->next = cpu;
+			last_cpu = cpu;
+		}
+		last_cpu->next = first_cpu;
+	}
+
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		int j;
+		cpumask_t nodemask;
+		struct sched_group *node = &sched_group_nodes[i];
+		cpumask_t node_cpumask = node_to_cpumask(i);
+		cpus_and(nodemask, node_cpumask, cpu_online_map);
+
+		if (cpus_empty(nodemask))
+			continue;
+
+		first_cpu = last_cpu = NULL;
+		/* Set up physical groups */
+		for_each_cpu_mask(j, nodemask) {
+			struct sched_domain *cpu_domain = cpu_sched_domain(j);
+			struct sched_group *cpu = &sched_group_phys[j];
+
+			if (j != first_cpu(cpu_domain->span))
+				continue;
+
+			cpu->cpumask = cpu_domain->span;
+			/*
+			 * Make each extra sibling increase power by 10% of
+			 * the basic CPU. This is very arbitrary.
+			 */
+			cpu->cpu_power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE*(cpus_weight(cpu->cpumask)-1) / 10;
+			node->cpu_power += cpu->cpu_power;
+
+			if (!first_cpu)
+				first_cpu = cpu;
+			if (last_cpu)
+				last_cpu->next = cpu;
+			last_cpu = cpu;
+		}
+		last_cpu->next = first_cpu;
+	}
+
+	/* Set up nodes */
+	first_cpu = last_cpu = NULL;
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		struct sched_group *cpu = &sched_group_nodes[i];
+		cpumask_t nodemask;
+		cpumask_t node_cpumask = node_to_cpumask(i);
+		cpus_and(nodemask, node_cpumask, cpu_possible_map);
+
+		if (cpus_empty(nodemask))
+			continue;
+
+		cpu->cpumask = nodemask;
+		/* ->cpu_power already setup */
+
+		if (!first_cpu)
+			first_cpu = cpu;
+		if (last_cpu)
+			last_cpu->next = cpu;
+		last_cpu = cpu;
+	}
+	last_cpu->next = first_cpu;
+
+	mb();
+	for_each_cpu(i) {
+		int node = cpu_to_node(i);
+		struct sched_domain *cpu_domain = cpu_sched_domain(i);
+		struct sched_domain *phys_domain = &per_cpu(phys_domains, i);
+		struct sched_domain *node_domain = &per_cpu(node_domains, i);
+		struct sched_group *cpu_group = &sched_group_cpus[i];
+		struct sched_group *phys_group = &sched_group_phys[first_cpu(cpu_domain->span)];
+		struct sched_group *node_group = &sched_group_nodes[node];
+
+		cpu_domain->parent = phys_domain;
+		phys_domain->parent = node_domain;
+
+		node_domain->groups = node_group;
+		phys_domain->groups = phys_group;
+		cpu_domain->groups = cpu_group;
+	}
+}
+#else /* CONFIG_NUMA */
+static struct sched_group sched_group_cpus[NR_CPUS];
+static struct sched_group sched_group_phys[NR_CPUS];
+static DEFINE_PER_CPU(struct sched_domain, phys_domains);
+__init void arch_init_sched_domains(void)
+{
+	int i;
+	struct sched_group *first_cpu = NULL, *last_cpu = NULL;
+
+	/* Set up domains */
+	for_each_cpu(i) {
+		struct sched_domain *cpu_domain = cpu_sched_domain(i);
+		struct sched_domain *phys_domain = &per_cpu(phys_domains, i);
+
+		*cpu_domain = SD_SIBLING_INIT;
+		cpu_domain->span = cpu_sibling_map[i];
+
+		*phys_domain = SD_CPU_INIT;
+		phys_domain->span = cpu_possible_map;
+	}
+
+	/* Set up CPU (sibling) groups */
+	for_each_cpu(i) {
+		struct sched_domain *cpu_domain = cpu_sched_domain(i);
+		int j;
+		first_cpu = last_cpu = NULL;
+
+		if (i != first_cpu(cpu_domain->span)) {
+			cpu_sched_domain(i)->flags |= SD_FLAG_SHARE_CPUPOWER;
+			cpu_sched_domain(first_cpu(cpu_domain->span))->flags |=
+				SD_FLAG_SHARE_CPUPOWER;
+			continue;
+		}
+
+		for_each_cpu_mask(j, cpu_domain->span) {
+			struct sched_group *cpu = &sched_group_cpus[j];
+
+			cpus_clear(cpu->cpumask);
+			cpu_set(j, cpu->cpumask);
+			cpu->cpu_power = SCHED_LOAD_SCALE;
+
+			if (!first_cpu)
+				first_cpu = cpu;
+			if (last_cpu)
+				last_cpu->next = cpu;
+			last_cpu = cpu;
+		}
+		last_cpu->next = first_cpu;
+	}
+
+	first_cpu = last_cpu = NULL;
+	/* Set up physical groups */
+	for_each_cpu(i) {
+		struct sched_domain *cpu_domain = cpu_sched_domain(i);
+		struct sched_group *cpu = &sched_group_phys[i];
+
+		if (i != first_cpu(cpu_domain->span))
+			continue;
+
+		cpu->cpumask = cpu_domain->span;
+		/* See SMT+NUMA setup for comment */
+		cpu->cpu_power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE*(cpus_weight(cpu->cpumask)-1) / 10;
+
+		if (!first_cpu)
+			first_cpu = cpu;
+		if (last_cpu)
+			last_cpu->next = cpu;
+		last_cpu = cpu;
+	}
+	last_cpu->next = first_cpu;
+
+	mb();
+	for_each_cpu(i) {
+		struct sched_domain *cpu_domain = cpu_sched_domain(i);
+		struct sched_domain *phys_domain = &per_cpu(phys_domains, i);
+		struct sched_group *cpu_group = &sched_group_cpus[i];
+		struct sched_group *phys_group = &sched_group_phys[first_cpu(cpu_domain->span)];
+		cpu_domain->parent = phys_domain;
+		phys_domain->groups = phys_group;
+		cpu_domain->groups = cpu_group;
+	}
+}
+#endif /* CONFIG_NUMA */
+#endif /* CONFIG_SCHED_SMT */
diff -puN include/asm-ppc64/processor.h~sched-ppc64bits include/asm-ppc64/processor.h
--- gr25_work/include/asm-ppc64/processor.h~sched-ppc64bits	2004-03-11 21:27:02.665465998 -0600
+++ gr25_work-anton/include/asm-ppc64/processor.h	2004-03-11 21:27:02.677464095 -0600
@@ -631,6 +631,11 @@ static inline void prefetchw(const void 
 
 #define spin_lock_prefetch(x)	prefetchw(x)
 
+#ifdef CONFIG_SCHED_SMT
+#define ARCH_HAS_SCHED_DOMAIN
+#define ARCH_HAS_SCHED_WAKE_BALANCE
+#endif
+
 #endif /* ASSEMBLY */
 
 #endif /* __ASM_PPC64_PROCESSOR_H */

_
