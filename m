Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUCKNvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUCKNvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:51:36 -0500
Received: from dp.samba.org ([66.70.73.150]:27626 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261263AbUCKNvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:51:00 -0500
Date: Fri, 12 Mar 2004 00:49:55 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040311134955.GB16751@krispykreme>
References: <20040310233140.3ce99610.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310233140.3ce99610.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> - The CPU scheduler changes in -mm (sched-domains) have been hanging about
>   for too long.  I had been hoping that the people who care about SMT and
>   NUMA performance would have some results by now but all seems to be silent.
> 
>   I do not wish to merge these up until the big-iron guys can say that they
>   suit their requirements, with a reasonable expectation that we will not
>   need to churn this code later in the 2.6 series.
> 
>   So.  If you have been testing, please speak up.  If you have not been
>   testing, please do so.

I sucked sched-* out of mm, added sched-ppc64bits (attached) and am
having problems with the following threaded test case. NUMA is enabled.

#include <pthread.h>
#define NR_THREADS 100

void dostuff(void *junk)
{
        while(1)
                ;
}

int main()
{
        int i;
        pthread_t tid;

        for (i = 0; i < NR_THREADS-1; i++)
                pthread_create(&tid, NULL, dostuff, NULL);

        dostuff(NULL);
}

100 runnable threads but we never use more than one cpu:

          user    system idle                     user    system idle
cpu0      0       0     100             cpu1      0       0     100
cpu2      0       0     100             cpu3      0       0     100
cpu4      0       0     100             cpu5      0       0     100
cpu6      0       0     100             cpu7      0       0     100
cpu8      0       0     100             cpu9      0       0     100
cpu10     0       0     100             cpu11     0       0     100
cpu12     0       0     100             cpu13   100       0       0

Anton

diff -puN arch/ppc64/Kconfig~sched-ppc64bits arch/ppc64/Kconfig
--- gr23_work/arch/ppc64/Kconfig~sched-ppc64bits	2004-03-03 07:43:29.762761114 -0600
+++ gr23_work-anton/arch/ppc64/Kconfig	2004-03-03 07:43:29.778758577 -0600
@@ -173,6 +173,16 @@ config NUMA
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
--- gr23_work/arch/ppc64/kernel/smp.c~sched-ppc64bits	2004-03-03 07:43:29.768760162 -0600
+++ gr23_work-anton/arch/ppc64/kernel/smp.c	2004-03-03 07:43:29.782757942 -0600
@@ -890,3 +890,204 @@ static int __init topology_init(void)
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
+	for_each_online_cpu(i) {
+		struct sched_domain *cpu_domain = cpu_sched_domain(i);
+		struct sched_domain *phys_domain = &per_cpu(phys_domains, i);
+		struct sched_domain *node_domain = &per_cpu(node_domains, i);
+		int node = cpu_to_node(i);
+		cpumask_t nodemask = node_to_cpumask(node);
+
+		*cpu_domain = SD_SIBLING_INIT;
+		cpumask_t tmp1 = cpumask_of_cpu(i ^ 0x1);
+		cpumask_t tmp2 = cpumask_of_cpu(i);
+		cpus_or(cpu_domain->span, tmp1, tmp2);
+
+		*phys_domain = SD_CPU_INIT;
+		phys_domain->span = nodemask;
+
+		*node_domain = SD_NODE_INIT;
+		node_domain->span = cpu_online_map;
+	}
+
+	/* Set up CPU (sibling) groups */
+	for_each_online_cpu(i) {
+		struct sched_domain *cpu_domain = cpu_sched_domain(i);
+		int j;
+		first_cpu = last_cpu = NULL;
+
+		if (i != first_cpu(cpu_domain->span))
+			continue;
+
+		for_each_cpu_mask(j, cpu_domain->span) {
+			struct sched_group *cpu = &sched_group_cpus[j];
+
+			cpus_clear(cpu->cpumask);
+			cpu_set(j, cpu->cpumask);
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
+	for (i = 0; i < numnodes; i++) {
+		int j;
+		cpumask_t nodemask;
+		cpumask_t node_cpumask = node_to_cpumask(i);
+		cpus_and(nodemask, node_cpumask, cpu_online_map);
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
+
+			if (!first_cpu)
+				first_cpu = cpu;
+			if (last_cpu)
+				last_cpu->next = cpu;
+			last_cpu = cpu;
+		}
+		if (last_cpu)
+			last_cpu->next = first_cpu;
+	}
+
+	/* Set up nodes */
+	first_cpu = last_cpu = NULL;
+	for (i = 0; i < numnodes; i++) {
+		struct sched_group *cpu = &sched_group_nodes[i];
+		cpumask_t nodemask;
+		cpumask_t node_cpumask = node_to_cpumask(i);
+		cpus_and(nodemask, node_cpumask, cpu_online_map);
+
+		if (cpus_empty(nodemask))
+			continue;
+
+		cpu->cpumask = nodemask;
+
+		if (!first_cpu)
+			first_cpu = cpu;
+		if (last_cpu)
+			last_cpu->next = cpu;
+		last_cpu = cpu;
+	}
+	if (last_cpu)
+		last_cpu->next = first_cpu;
+
+	mb();
+	for_each_online_cpu(i) {
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
+	for_each_cpu_mask(i, cpu_online_map) {
+		struct sched_domain *cpu_domain = cpu_sched_domain(i);
+		struct sched_domain *phys_domain = &per_cpu(phys_domains, i);
+
+		*cpu_domain = SD_SIBLING_INIT;
+		cpu_domain->span = blah cpu_sibling_map[i];
+
+		*phys_domain = SD_CPU_INIT;
+		phys_domain->span = cpu_online_map;
+	}
+
+	/* Set up CPU (sibling) groups */
+	for_each_cpu_mask(i, cpu_online_map) {
+		struct sched_domain *cpu_domain = cpu_sched_domain(i);
+		int j;
+		first_cpu = last_cpu = NULL;
+
+		if (i != first_cpu(cpu_domain->span))
+			continue;
+
+		for_each_cpu_mask(j, cpu_domain->span) {
+			struct sched_group *cpu = &sched_group_cpus[j];
+
+			cpu->cpumask = CPU_MASK_NONE;
+			cpu_set(j, cpu->cpumask);
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
+	for_each_cpu_mask(i, cpu_online_map) {
+		struct sched_domain *cpu_domain = cpu_sched_domain(i);
+		struct sched_group *cpu = &sched_group_phys[i];
+
+		if (i != first_cpu(cpu_domain->span))
+			continue;
+
+		cpu->cpumask = cpu_domain->span;
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
+	for_each_cpu_mask(i, cpu_online_map) {
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
--- gr23_work/include/asm-ppc64/processor.h~sched-ppc64bits	2004-03-03 07:43:29.773759370 -0600
+++ gr23_work-anton/include/asm-ppc64/processor.h	2004-03-03 07:43:29.784757625 -0600
@@ -631,6 +631,11 @@ static inline void prefetchw(const void 
 
 #define spin_lock_prefetch(x)	prefetchw(x)
 
+#ifdef CONFIG_SCHED_SMT
+#define ARCH_HAS_SCHED_DOMAIN
+#define ARCH_HAS_SCHED_WAKE_BALANCE
+#endif
+
 #endif /* ASSEMBLY */
 
 #endif /* __ASM_PPC64_PROCESSOR_H */

