Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266858AbUGVQmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266858AbUGVQmC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 12:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUGVQlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 12:41:50 -0400
Received: from cfcafwp.SGI.COM ([192.48.179.6]:63193 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266853AbUGVQla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 12:41:30 -0400
Date: Thu, 22 Jul 2004 11:41:26 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: [RFC] Patch for isolated scheduler domains
Message-ID: <20040722164126.GB13189@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'm interested in implementing something I'll call isolated sched domains
for single cpus (to minimize the latencies involved when doing things like
load balancing on certain select cpus) on IA64.

Below I've included an initial patch to illustrate what I'd like to do.  I know
there's been mention of 'platform specific work' in the area of sched domains.
This patch only addresses IA64, but could be made generic as well.  The code
is derived directly from the current default arch_init_sched_domains code.

The patch isolates cpus that have been specified via a boot time parameter
'isolcpus=<cpu #>,<cpu #>'.

I've got some questions:

- Overall, does what I have below seem like a reasonably acceptable way to
  implement an isolated cpu concept?  Would something like this be an
  acceptable change?

- In my patch I've created groups for each cpu, with the domain of that
  cpu spanning only that cpu.  Should I instead just have one group that
  is used by all isolated cpus (each domain might then span all isolated
  cpus) with load balancing simply turned off?

- Are the values I'm using (things like 'flags', 'balance_interval' and
  'cpu_power') appropriate?

- Assuming boot time configuration is appropriate ('isolcpus=' in my example),
  is allowing boot time configuration of only completely isolated cpus
  focusing too narrowly on this one concept, or should a boot time
  configuration allow for a broader array of configurations, or would other
  types of sched domain configurations be addressed separately?

- Would it be useful for this patch to encompass all platforms, or is
  limiting it to IA64 (as I've done) the appropriate approach?

This patch applies to 2.6.8-rc2.


Index: linux/arch/ia64/kernel/smpboot.c
===================================================================
--- linux.orig/arch/ia64/kernel/smpboot.c
+++ linux/arch/ia64/kernel/smpboot.c
@@ -719,3 +719,121 @@ init_smp_config(void)
 		printk(KERN_ERR "SMP: Can't set SAL AP Boot Rendezvous: %s\n",
 		       ia64_sal_strerror(sal_ret));
 }
+
+#ifdef CONFIG_NUMA
+cpumask_t __initdata isol_cpumask; /* Isolated domain cpus */
+
+/* Setup the mask of cpus configured for isolated domains */
+static int __init
+isol_cpu_setup(char *str)
+{
+	int ints[NR_CPUS], i;
+ 
+	str = get_options(str, ARRAY_SIZE(ints), ints);
+	cpus_clear(isol_cpumask);
+	for (i=1; i<=ints[0]; i++) {
+		cpu_set(ints[i], isol_cpumask);
+	}
+	return 1;
+}
+
+__setup ("isolcpus=", isol_cpu_setup);
+
+static struct sched_group sched_group_cpus[NR_CPUS];
+static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
+static struct sched_group sched_group_nodes[MAX_NUMNODES];
+static DEFINE_PER_CPU(struct sched_domain, node_domains);
+void __init arch_init_sched_domains(void)
+{
+	int i;
+	struct sched_group *first_node = NULL, *last_node = NULL;
+	cpumask_t cpu_nonisolated;
+
+	cpus_and(cpu_nonisolated, cpu_possible_map, isol_cpumask);
+	cpus_complement(cpu_nonisolated, cpu_nonisolated);
+	cpus_and(cpu_nonisolated, cpu_nonisolated, cpu_possible_map);
+
+	/*
+	 * Set up isolated domains.
+	 * Unlike those of other cpus, the domains and groups are single
+	 * level, and span a single cpu.
+	 */
+	for_each_cpu_mask(i, isol_cpumask) {
+		struct sched_domain *cpu_sd = &per_cpu(cpu_domains, i);
+
+		cpus_clear(sched_group_cpus[i].cpumask);
+		cpu_set(i, sched_group_cpus[i].cpumask);
+		sched_group_cpus[i].cpu_power = SCHED_LOAD_SCALE;
+		sched_group_cpus[i].next = &sched_group_cpus[i];
+
+		*cpu_sd = SD_CPU_INIT;
+		cpus_clear(cpu_sd->span);
+		cpu_set(i, cpu_sd->span);
+		cpu_sd->groups = &sched_group_cpus[i];
+		cpu_sd->balance_interval = INT_MAX; /* Don't balance */
+		cpu_sd->flags &= ~(SD_BALANCE_NEWIDLE | SD_BALANCE_EXEC | SD_BALANCE_CLONE);  /* Probably redundant */
+		printk(KERN_ERR "arch_init_sched_domains: Setting up cpu %d isolated.\n", i);
+	}
+	/* Set up default domains on other cpus */
+	for_each_cpu_mask(i, cpu_nonisolated) {
+		int node = cpu_to_node(i);
+		cpumask_t nodemask = node_to_cpumask(node);
+		struct sched_domain *node_sd = &per_cpu(node_domains, i);
+		struct sched_domain *cpu_sd = &per_cpu(cpu_domains, i);
+
+		*node_sd = SD_NODE_INIT;
+		node_sd->span = cpu_nonisolated;
+		node_sd->groups = &sched_group_nodes[cpu_to_node(i)];
+
+		*cpu_sd = SD_CPU_INIT;
+		cpus_and(cpu_sd->span, nodemask, cpu_nonisolated);
+		cpu_sd->groups = &sched_group_cpus[i];
+		cpu_sd->parent = node_sd;
+	}
+
+	/* Set up node groups for non isolated cpus */
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		cpumask_t tmp = node_to_cpumask(i);
+		cpumask_t nodemask;
+		struct sched_group *first_cpu = NULL, *last_cpu = NULL;
+		struct sched_group *node = &sched_group_nodes[i];
+		int j;
+
+		cpus_and(nodemask, tmp, cpu_nonisolated);
+
+		if (cpus_empty(nodemask))
+			continue;
+
+		node->cpumask = nodemask;
+		node->cpu_power = SCHED_LOAD_SCALE * cpus_weight(node->cpumask);
+
+		for_each_cpu_mask(j, node->cpumask) {
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
+
+		if (!first_node)
+			first_node = node;
+		if (last_node)
+			last_node->next = node;
+		last_node = node;
+	}
+	last_node->next = first_node;
+
+	mb();
+	for_each_cpu(i) {
+		struct sched_domain *cpu_sd = &per_cpu(cpu_domains, i);
+		cpu_attach_domain(cpu_sd, i);
+	}
+}
+#endif /* CONFIG_NUMA_SCHED */
Index: linux/include/asm-ia64/processor.h
===================================================================
--- linux.orig/include/asm-ia64/processor.h
+++ linux/include/asm-ia64/processor.h
@@ -689,6 +689,9 @@ prefetchw (const void *x)
 
 #define spin_lock_prefetch(x)	prefetchw(x)
 
+#ifdef CONFIG_NUMA
+#define ARCH_HAS_SCHED_DOMAIN
+#endif
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_IA64_PROCESSOR_H */
