Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUGWDT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUGWDT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 23:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUGWDT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 23:19:27 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:7356 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267514AbUGWDSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 23:18:37 -0400
Message-ID: <41008386.9060009@yahoo.com.au>
Date: Fri, 23 Jul 2004 13:18:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Anton Blanchard <anton@samba.org>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] consolidate sched domains
Content-Type: multipart/mixed;
 boundary="------------090006070803090906070809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090006070803090906070809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch is against 2.6.8-rc1-mm1. Tested on SMP, UP and SMP+HT
here and it seems to be OK.

I have included the cpu_sibling_map for ppc64, although Anton said he did
have an implementation floating around which he would probably prefer, but
I'll let him deal with that.

Anyway, x86-64 is not equivalent before and after this patch. The main
thing is that they've been using SD_CPU_INIT for NUMA nodes, but will now
use SD_NODE_INIT. Probably neither is optimal, but I don't think Andi has
had much time to look at it. I should be able to take a look at it soon.

Nick

--------------090006070803090906070809
Content-Type: text/x-patch;
 name="sched-consolidate-domains.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-consolidate-domains.patch"



Teach the generic domains builder about SMT, and consolidate all architecture
specific domain code into that. Also, the SD_*_INIT macros can now be redefined
by arch code without duplicating the entire setup code. This can be done by
defining ARCH_HASH_SCHED_TUNE.

The generic builder has been simplified with the addition of a helper macro
which will probably prove to be useful to arch specific code as well and should
be exported if that is the case.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


---

 linux-2.6-npiggin/Documentation/sched-domains.txt  |   27 +-
 linux-2.6-npiggin/arch/i386/kernel/smpboot.c       |  207 -------------------
 linux-2.6-npiggin/arch/ppc64/kernel/smp.c          |  227 +--------------------
 linux-2.6-npiggin/arch/x86_64/kernel/Makefile      |    1 
 linux-2.6-npiggin/arch/x86_64/kernel/Makefile-HEAD |    1 
 linux-2.6-npiggin/include/asm-i386/processor.h     |    5 
 linux-2.6-npiggin/include/asm-ppc64/processor.h    |    5 
 linux-2.6-npiggin/include/asm-ppc64/smp.h          |    3 
 linux-2.6-npiggin/include/asm-x86_64/processor.h   |    5 
 linux-2.6-npiggin/include/linux/sched.h            |    5 
 linux-2.6-npiggin/kernel/sched.c                   |  219 ++++++++++++--------
 linux-2.6/arch/x86_64/kernel/domain.c              |   93 --------
 12 files changed, 179 insertions(+), 619 deletions(-)

diff -puN kernel/sched.c~sched-consolidate-domains kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-consolidate-domains	2004-07-23 13:08:55.000000000 +1000
+++ linux-2.6-npiggin/kernel/sched.c	2004-07-23 13:08:55.000000000 +1000
@@ -3674,118 +3674,175 @@ void cpu_attach_domain(struct sched_doma
 #ifdef ARCH_HAS_SCHED_DOMAIN
 extern void __init arch_init_sched_domains(void);
 #else
-static struct sched_group sched_group_cpus[NR_CPUS];
+
+#ifdef CONFIG_SCHED_SMT
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
+static struct sched_group sched_group_cpus[NR_CPUS];
+__init static int cpu_to_cpu_group(int cpu)
+{
+	return cpu;
+}
+#endif
+
+static DEFINE_PER_CPU(struct sched_domain, phys_domains);
+static struct sched_group sched_group_phys[NR_CPUS];
+__init static int cpu_to_phys_group(int cpu)
+{
+	return first_cpu(cpu_sibling_map[cpu]);
+}
+
 #ifdef CONFIG_NUMA
-static struct sched_group sched_group_nodes[MAX_NUMNODES];
 static DEFINE_PER_CPU(struct sched_domain, node_domains);
-static void __init arch_init_sched_domains(void)
+static struct sched_group sched_group_nodes[MAX_NUMNODES];
+__init static int cpu_to_node_group(int cpu)
 {
-	int i;
-	struct sched_group *first_node = NULL, *last_node = NULL;
+	return cpu_to_node(cpu);
+}
+#endif
 
-	/* Set up domains */
-	for_each_cpu(i) {
-		int node = cpu_to_node(i);
-		cpumask_t nodemask = node_to_cpumask(node);
-		struct sched_domain *node_sd = &per_cpu(node_domains, i);
-		struct sched_domain *cpu_sd = &per_cpu(cpu_domains, i);
-
-		*node_sd = SD_NODE_INIT;
-		node_sd->span = cpu_possible_map;
-		node_sd->groups = &sched_group_nodes[cpu_to_node(i)];
-
-		*cpu_sd = SD_CPU_INIT;
-		cpus_and(cpu_sd->span, nodemask, cpu_possible_map);
-		cpu_sd->groups = &sched_group_cpus[i];
-		cpu_sd->parent = node_sd;
-	}
+/*
+ * init_sched_build_groups takes an array of groups, the cpumask we wish
+ * to span, and a pointer to a function which identifies what group a CPU
+ * belongs to. The return value of group_fn must be a valid index into the
+ * groups[] array, and must be >= 0 and < NR_CPUS (due to the fact that we
+ * keep track of groups covered with a cpumask_t).
+ *
+ * init_sched_build_groups will build a circular linked list of the groups
+ * covered by the given span, and will set each group's ->cpumask correctly,
+ * and ->cpu_power to 0.
+ */
+__init static void init_sched_build_groups(struct sched_group groups[],
+			cpumask_t span, int (*group_fn)(int cpu))
+{
+	struct sched_group *first = NULL, *last = NULL;
+	cpumask_t covered = CPU_MASK_NONE;
+	int i;
 
-	/* Set up groups */
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		cpumask_t tmp = node_to_cpumask(i);
-		cpumask_t nodemask;
-		struct sched_group *first_cpu = NULL, *last_cpu = NULL;
-		struct sched_group *node = &sched_group_nodes[i];
+	for_each_cpu_mask(i, span) {
+		int group = group_fn(i);
+		struct sched_group *sg = &groups[group];
 		int j;
 
-		cpus_and(nodemask, tmp, cpu_possible_map);
-
-		if (cpus_empty(nodemask))
+		if (cpu_isset(i, covered))
 			continue;
 
-		node->cpumask = nodemask;
-		node->cpu_power = SCHED_LOAD_SCALE * cpus_weight(node->cpumask);
+		sg->cpumask = CPU_MASK_NONE;
+		sg->cpu_power = 0;
 
-		for_each_cpu_mask(j, node->cpumask) {
-			struct sched_group *cpu = &sched_group_cpus[j];
+		for_each_cpu_mask(j, span) {
+			if (group_fn(j) != group)
+				continue;
 
-			cpus_clear(cpu->cpumask);
-			cpu_set(j, cpu->cpumask);
-			cpu->cpu_power = SCHED_LOAD_SCALE;
-
-			if (!first_cpu)
-				first_cpu = cpu;
-			if (last_cpu)
-				last_cpu->next = cpu;
-			last_cpu = cpu;
+			cpu_set(j, covered);
+			cpu_set(j, sg->cpumask);
 		}
-		last_cpu->next = first_cpu;
-
-		if (!first_node)
-			first_node = node;
-		if (last_node)
-			last_node->next = node;
-		last_node = node;
-	}
-	last_node->next = first_node;
-
-	mb();
-	for_each_cpu(i) {
-		struct sched_domain *cpu_sd = &per_cpu(cpu_domains, i);
-		cpu_attach_domain(cpu_sd, i);
+		if (!first)
+			first = sg;
+		if (last)
+			last->next = sg;
+		last = sg;
 	}
+	last->next = first;
 }
 
-#else /* !CONFIG_NUMA */
-static void __init arch_init_sched_domains(void)
+__init static void arch_init_sched_domains(void)
 {
 	int i;
-	struct sched_group *first_cpu = NULL, *last_cpu = NULL;
 
 	/* Set up domains */
 	for_each_cpu(i) {
-		struct sched_domain *cpu_sd = &per_cpu(cpu_domains, i);
+		int group;
+		struct sched_domain *sd = NULL, *p;
+		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
 
-		*cpu_sd = SD_CPU_INIT;
-		cpu_sd->span = cpu_possible_map;
-		cpu_sd->groups = &sched_group_cpus[i];
+#ifdef CONFIG_NUMA
+		sd = &per_cpu(node_domains, i);
+		group = cpu_to_node_group(i);
+		*sd = SD_NODE_INIT;
+		sd->span = cpu_possible_map;
+		sd->groups = &sched_group_nodes[group];
+#endif
+
+		p = sd;
+		sd = &per_cpu(phys_domains, i);
+		group = cpu_to_phys_group(i);
+		*sd = SD_CPU_INIT;
+		sd->span = nodemask;
+		sd->parent = p;
+		sd->groups = &sched_group_phys[group];
+
+#ifdef CONFIG_SCHED_SMT
+		p = sd;
+		sd = &per_cpu(cpu_domains, i);
+		group = cpu_to_cpu_group(i);
+		*sd = SD_SIBLING_INIT;
+		sd->span = cpu_sibling_map[i];
+		sd->parent = p;
+		sd->groups = &sched_group_cpus[group];
+#endif
 	}
 
-	/* Set up CPU groups */
-	for_each_cpu_mask(i, cpu_possible_map) {
-		struct sched_group *cpu = &sched_group_cpus[i];
+#ifdef CONFIG_SCHED_SMT
+	/* Set up CPU (sibling) groups */
+	for_each_cpu(i) {
+		if (i != first_cpu(cpu_sibling_map[i]))
+			continue;
 
-		cpus_clear(cpu->cpumask);
-		cpu_set(i, cpu->cpumask);
-		cpu->cpu_power = SCHED_LOAD_SCALE;
+		init_sched_build_groups(sched_group_cpus, cpu_sibling_map[i],
+						&cpu_to_cpu_group);
+	}
+#endif
 
-		if (!first_cpu)
-			first_cpu = cpu;
-		if (last_cpu)
-			last_cpu->next = cpu;
-		last_cpu = cpu;
+	/* Set up physical groups */
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		cpumask_t nodemask = node_to_cpumask(i);
+
+		cpus_and(nodemask, nodemask, cpu_possible_map);
+		if (cpus_empty(nodemask))
+			continue;
+
+		init_sched_build_groups(sched_group_phys, nodemask,
+						&cpu_to_phys_group);
 	}
-	last_cpu->next = first_cpu;
 
-	mb(); /* domains were modified outside the lock */
+#ifdef CONFIG_NUMA
+	/* Set up node groups */
+	init_sched_build_groups(sched_group_nodes, cpu_possible_map,
+					&cpu_to_node_group);
+#endif
+
+	/* Calculate CPU power for physical packages and nodes */
+	for_each_cpu(i) {
+		int power;
+		struct sched_domain *sd;
+#ifdef CONFIG_SCHED_SMT
+		sd = &per_cpu(cpu_domains, i);
+		power = SCHED_LOAD_SCALE;
+		sd->groups->cpu_power = power;
+#endif
+
+		sd = &per_cpu(phys_domains, i);
+		power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE *
+				(cpus_weight(sd->groups->cpumask)-1) / 10;
+		sd->groups->cpu_power = power;
+
+#ifdef CONFIG_NUMA
+		sd = &per_cpu(node_domains, i);
+		sd->groups->cpu_power += power;
+#endif
+	}
+
+	/* Attach the domains */
 	for_each_cpu(i) {
-		struct sched_domain *cpu_sd = &per_cpu(cpu_domains, i);
-		cpu_attach_domain(cpu_sd, i);
+		struct sched_domain *sd;
+#ifdef CONFIG_SCHED_SMT
+		sd = &per_cpu(cpu_domains, i);
+#else
+		sd = &per_cpu(phys_domains, i);
+#endif
+		cpu_attach_domain(sd, i);
 	}
 }
-
-#endif /* CONFIG_NUMA */
 #endif /* ARCH_HAS_SCHED_DOMAIN */
 
 #define SCHED_DOMAIN_DEBUG
diff -puN include/linux/sched.h~sched-consolidate-domains include/linux/sched.h
--- linux-2.6/include/linux/sched.h~sched-consolidate-domains	2004-07-23 13:08:55.000000000 +1000
+++ linux-2.6-npiggin/include/linux/sched.h	2004-07-23 13:08:55.000000000 +1000
@@ -615,6 +615,9 @@ struct sched_domain {
 	unsigned int nr_balance_failed; /* initialise to 0 */
 };
 
+#ifndef ARCH_HAS_SCHED_TUNE
+#ifdef CONFIG_SCHED_SMT
+#define ARCH_HAS_SCHED_WAKE_IDLE
 /* Common values for SMT siblings */
 #define SD_SIBLING_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
@@ -636,6 +639,7 @@ struct sched_domain {
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
 }
+#endif
 
 /* Common values for CPUs */
 #define SD_CPU_INIT (struct sched_domain) {		\
@@ -678,6 +682,7 @@ struct sched_domain {
 	.nr_balance_failed	= 0,			\
 }
 #endif
+#endif /*  ARCH_HAS_SCHED_TUNE */
 
 extern void cpu_attach_domain(struct sched_domain *sd, int cpu);
 
diff -puN arch/i386/kernel/smpboot.c~sched-consolidate-domains arch/i386/kernel/smpboot.c
--- linux-2.6/arch/i386/kernel/smpboot.c~sched-consolidate-domains	2004-07-23 13:08:55.000000000 +1000
+++ linux-2.6-npiggin/arch/i386/kernel/smpboot.c	2004-07-23 13:08:55.000000000 +1000
@@ -1129,213 +1129,6 @@ static void __init smp_boot_cpus(unsigne
 		synchronize_tsc_bp();
 }
 
-#ifdef CONFIG_SCHED_SMT
-#ifdef CONFIG_NUMA
-static struct sched_group sched_group_cpus[NR_CPUS];
-static struct sched_group sched_group_phys[NR_CPUS];
-static struct sched_group sched_group_nodes[MAX_NUMNODES];
-static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
-static DEFINE_PER_CPU(struct sched_domain, phys_domains);
-static DEFINE_PER_CPU(struct sched_domain, node_domains);
-__init void arch_init_sched_domains(void)
-{
-	int i;
-	struct sched_group *first = NULL, *last = NULL;
-
-	/* Set up domains */
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		struct sched_domain *phys_domain = &per_cpu(phys_domains, i);
-		struct sched_domain *node_domain = &per_cpu(node_domains, i);
-		int node = cpu_to_node(i);
-		cpumask_t nodemask = node_to_cpumask(node);
-
-		*cpu_domain = SD_SIBLING_INIT;
-		cpu_domain->span = cpu_sibling_map[i];
-		cpu_domain->parent = phys_domain;
-		cpu_domain->groups = &sched_group_cpus[i];
-
-		*phys_domain = SD_CPU_INIT;
-		phys_domain->span = nodemask;
-		phys_domain->parent = node_domain;
-		phys_domain->groups = &sched_group_phys[first_cpu(cpu_domain->span)];
-
-		*node_domain = SD_NODE_INIT;
-		node_domain->span = cpu_possible_map;
-		node_domain->groups = &sched_group_nodes[cpu_to_node(i)];
-	}
-
-	/* Set up CPU (sibling) groups */
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		int j;
-		first = last = NULL;
-
-		if (i != first_cpu(cpu_domain->span))
-			continue;
-
-		for_each_cpu_mask(j, cpu_domain->span) {
-			struct sched_group *cpu = &sched_group_cpus[j];
-
-			cpu->cpumask = CPU_MASK_NONE;
-			cpu_set(j, cpu->cpumask);
-			cpu->cpu_power = SCHED_LOAD_SCALE;
-
-			if (!first)
-				first = cpu;
-			if (last)
-				last->next = cpu;
-			last = cpu;
-		}
-		last->next = first;
-	}
-
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		int j;
-		cpumask_t nodemask;
-		struct sched_group *node = &sched_group_nodes[i];
-		cpumask_t node_cpumask = node_to_cpumask(i);
-
-		cpus_and(nodemask, node_cpumask, cpu_possible_map);
-
-		if (cpus_empty(nodemask))
-			continue;
-
-		first = last = NULL;
-		/* Set up physical groups */
-		for_each_cpu_mask(j, nodemask) {
-			struct sched_domain *cpu_domain = &per_cpu(cpu_domains, j);
-			struct sched_group *cpu = &sched_group_phys[j];
-
-			if (j != first_cpu(cpu_domain->span))
-				continue;
-
-			cpu->cpumask = cpu_domain->span;
-			/*
-			 * Make each extra sibling increase power by 10% of
-			 * the basic CPU. This is very arbitrary.
-			 */
-			cpu->cpu_power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE*(cpus_weight(cpu->cpumask)-1) / 10;
-			node->cpu_power += cpu->cpu_power;
-
-			if (!first)
-				first = cpu;
-			if (last)
-				last->next = cpu;
-			last = cpu;
-		}
-		last->next = first;
-	}
-
-	/* Set up nodes */
-	first = last = NULL;
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		struct sched_group *cpu = &sched_group_nodes[i];
-		cpumask_t nodemask;
-		cpumask_t node_cpumask = node_to_cpumask(i);
-
-		cpus_and(nodemask, node_cpumask, cpu_possible_map);
-
-		if (cpus_empty(nodemask))
-			continue;
-
-		cpu->cpumask = nodemask;
-		/* ->cpu_power already setup */
-
-		if (!first)
-			first = cpu;
-		if (last)
-			last->next = cpu;
-		last = cpu;
-	}
-	last->next = first;
-
-	mb();
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		cpu_attach_domain(cpu_domain, i);
-	}
-}
-#else /* !CONFIG_NUMA */
-static struct sched_group sched_group_cpus[NR_CPUS];
-static struct sched_group sched_group_phys[NR_CPUS];
-static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
-static DEFINE_PER_CPU(struct sched_domain, phys_domains);
-__init void arch_init_sched_domains(void)
-{
-	int i;
-	struct sched_group *first = NULL, *last = NULL;
-
-	/* Set up domains */
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		struct sched_domain *phys_domain = &per_cpu(phys_domains, i);
-
-		*cpu_domain = SD_SIBLING_INIT;
-		cpu_domain->span = cpu_sibling_map[i];
-		cpu_domain->parent = phys_domain;
-		cpu_domain->groups = &sched_group_cpus[i];
-
-		*phys_domain = SD_CPU_INIT;
-		phys_domain->span = cpu_possible_map;
-		phys_domain->groups = &sched_group_phys[first_cpu(cpu_domain->span)];
-	}
-
-	/* Set up CPU (sibling) groups */
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		int j;
-		first = last = NULL;
-
-		if (i != first_cpu(cpu_domain->span))
-			continue;
-
-		for_each_cpu_mask(j, cpu_domain->span) {
-			struct sched_group *cpu = &sched_group_cpus[j];
-
-			cpus_clear(cpu->cpumask);
-			cpu_set(j, cpu->cpumask);
-			cpu->cpu_power = SCHED_LOAD_SCALE;
-
-			if (!first)
-				first = cpu;
-			if (last)
-				last->next = cpu;
-			last = cpu;
-		}
-		last->next = first;
-	}
-
-	first = last = NULL;
-	/* Set up physical groups */
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		struct sched_group *cpu = &sched_group_phys[i];
-
-		if (i != first_cpu(cpu_domain->span))
-			continue;
-
-		cpu->cpumask = cpu_domain->span;
-		/* See SMT+NUMA setup for comment */
-		cpu->cpu_power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE*(cpus_weight(cpu->cpumask)-1) / 10;
-
-		if (!first)
-			first = cpu;
-		if (last)
-			last->next = cpu;
-		last = cpu;
-	}
-	last->next = first;
-
-	mb();
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		cpu_attach_domain(cpu_domain, i);
-	}
-}
-#endif /* CONFIG_NUMA */
-#endif /* CONFIG_SCHED_SMT */
-
 /* These are wrappers to interface to the new boot process.  Someone
    who understands all this stuff should rewrite it properly. --RR 15/Jul/02 */
 void __init smp_prepare_cpus(unsigned int max_cpus)
diff -puN include/asm-ppc64/processor.h~sched-consolidate-domains include/asm-ppc64/processor.h
--- linux-2.6/include/asm-ppc64/processor.h~sched-consolidate-domains	2004-07-23 13:08:55.000000000 +1000
+++ linux-2.6-npiggin/include/asm-ppc64/processor.h	2004-07-23 13:08:55.000000000 +1000
@@ -626,11 +626,6 @@ static inline void prefetchw(const void 
 
 #define spin_lock_prefetch(x)	prefetchw(x)
 
-#ifdef CONFIG_SCHED_SMT
-#define ARCH_HAS_SCHED_DOMAIN
-#define ARCH_HAS_SCHED_WAKE_IDLE
-#endif
-
 #endif /* ASSEMBLY */
 
 /*
diff -puN include/asm-i386/processor.h~sched-consolidate-domains include/asm-i386/processor.h
--- linux-2.6/include/asm-i386/processor.h~sched-consolidate-domains	2004-07-23 13:08:55.000000000 +1000
+++ linux-2.6-npiggin/include/asm-i386/processor.h	2004-07-23 13:08:55.000000000 +1000
@@ -649,9 +649,4 @@ extern void select_idle_routine(const st
 
 #define cache_line_size() (boot_cpu_data.x86_cache_alignment)
 
-#ifdef CONFIG_SCHED_SMT
-#define ARCH_HAS_SCHED_DOMAIN
-#define ARCH_HAS_SCHED_WAKE_IDLE
-#endif
-
 #endif /* __ASM_I386_PROCESSOR_H */
diff -puN include/asm-x86_64/processor.h~sched-consolidate-domains include/asm-x86_64/processor.h
--- linux-2.6/include/asm-x86_64/processor.h~sched-consolidate-domains	2004-07-23 13:08:55.000000000 +1000
+++ linux-2.6-npiggin/include/asm-x86_64/processor.h	2004-07-23 13:08:55.000000000 +1000
@@ -458,9 +458,4 @@ static inline void __mwait(unsigned long
 
 #define cache_line_size() (boot_cpu_data.x86_cache_alignment)
 
-#ifdef CONFIG_SCHED_SMT
-#define ARCH_HAS_SCHED_DOMAIN
-#define ARCH_HAS_SCHED_WAKE_IDLE
-#endif
-
 #endif /* __ASM_X86_64_PROCESSOR_H */
diff -puN arch/ppc64/kernel/smp.c~sched-consolidate-domains arch/ppc64/kernel/smp.c
--- linux-2.6/arch/ppc64/kernel/smp.c~sched-consolidate-domains	2004-07-23 13:08:55.000000000 +1000
+++ linux-2.6-npiggin/arch/ppc64/kernel/smp.c	2004-07-23 13:08:55.000000000 +1000
@@ -55,6 +55,9 @@
 #include <asm/rtas.h>
 
 int smp_threads_ready;
+#ifdef CONFIG_SCHED_SMT
+cpumask_t cpu_sibling_map[NR_CPUS];
+#endif
 unsigned long cache_decay_ticks;
 
 cpumask_t cpu_possible_map = CPU_MASK_NONE;
@@ -436,6 +439,15 @@ static inline void look_for_more_cpus(vo
 	/* Make those cpus (which might appear later) possible too. */
 	for (i = 0; i < maxcpus; i++)
 		cpu_set(i, cpu_possible_map);
+
+#ifdef CONFIG_SCHED_SMT
+	memset(cpu_sibling_map, 0, sizeof(cpu_sibling_map));
+	for_each_cpu(i) {
+		cpu_set(i, cpu_sibling_map[i]);
+		if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+			cpu_set(i^1, cpu_sibling_map[i]);
+	}
+#endif
 }
 #else /* ... CONFIG_HOTPLUG_CPU */
 static inline int __devinit smp_startup_cpu(unsigned int lcpu)
@@ -990,218 +1002,3 @@ void __init smp_cpus_done(unsigned int m
 
 	set_cpus_allowed(current, old_mask);
 }
-
-#ifdef CONFIG_SCHED_SMT
-#ifdef CONFIG_NUMA
-static struct sched_group sched_group_cpus[NR_CPUS];
-static struct sched_group sched_group_phys[NR_CPUS];
-static struct sched_group sched_group_nodes[MAX_NUMNODES];
-static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
-static DEFINE_PER_CPU(struct sched_domain, phys_domains);
-static DEFINE_PER_CPU(struct sched_domain, node_domains);
-__init void arch_init_sched_domains(void)
-{
-	int i;
-	struct sched_group *first = NULL, *last = NULL;
-
-	/* Set up domains */
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		struct sched_domain *phys_domain = &per_cpu(phys_domains, i);
-		struct sched_domain *node_domain = &per_cpu(node_domains, i);
-		int node = cpu_to_node(i);
-		cpumask_t nodemask = node_to_cpumask(node);
-		cpumask_t my_cpumask = cpumask_of_cpu(i);
-		cpumask_t sibling_cpumask = cpumask_of_cpu(i ^ 0x1);
-
-		*cpu_domain = SD_SIBLING_INIT;
-		if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
-			cpus_or(cpu_domain->span, my_cpumask, sibling_cpumask);
-		else
-			cpu_domain->span = my_cpumask;
-		cpu_domain->parent = phys_domain;
-		cpu_domain->groups = &sched_group_cpus[i];
-
-		*phys_domain = SD_CPU_INIT;
-		phys_domain->span = nodemask;
-		phys_domain->parent = node_domain;
-		phys_domain->groups = &sched_group_phys[first_cpu(cpu_domain->span)];
-
-		*node_domain = SD_NODE_INIT;
-		node_domain->span = cpu_possible_map;
-		node_domain->groups = &sched_group_nodes[node];
-	}
-
-	/* Set up CPU (sibling) groups */
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		int j;
-		first = last = NULL;
-
-		if (i != first_cpu(cpu_domain->span))
-			continue;
-
-		for_each_cpu_mask(j, cpu_domain->span) {
-			struct sched_group *cpu = &sched_group_cpus[j];
-
-			cpus_clear(cpu->cpumask);
-			cpu_set(j, cpu->cpumask);
-			cpu->cpu_power = SCHED_LOAD_SCALE;
-
-			if (!first)
-				first = cpu;
-			if (last)
-				last->next = cpu;
-			last = cpu;
-		}
-		last->next = first;
-	}
-
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		int j;
-		cpumask_t nodemask;
-		struct sched_group *node = &sched_group_nodes[i];
-		cpumask_t node_cpumask = node_to_cpumask(i);
-		cpus_and(nodemask, node_cpumask, cpu_possible_map);
-
-		if (cpus_empty(nodemask))
-			continue;
-
-		first = last = NULL;
-		/* Set up physical groups */
-		for_each_cpu_mask(j, nodemask) {
-			struct sched_domain *cpu_domain = &per_cpu(cpu_domains, j);
-			struct sched_group *cpu = &sched_group_phys[j];
-
-			if (j != first_cpu(cpu_domain->span))
-				continue;
-
-			cpu->cpumask = cpu_domain->span;
-			/*
-			 * Make each extra sibling increase power by 10% of
-			 * the basic CPU. This is very arbitrary.
-			 */
-			cpu->cpu_power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE*(cpus_weight(cpu->cpumask)-1) / 10;
-			node->cpu_power += cpu->cpu_power;
-
-			if (!first)
-				first = cpu;
-			if (last)
-				last->next = cpu;
-			last = cpu;
-		}
-		last->next = first;
-	}
-
-	/* Set up nodes */
-	first = last = NULL;
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		struct sched_group *cpu = &sched_group_nodes[i];
-		cpumask_t nodemask;
-		cpumask_t node_cpumask = node_to_cpumask(i);
-		cpus_and(nodemask, node_cpumask, cpu_possible_map);
-
-		if (cpus_empty(nodemask))
-			continue;
-
-		cpu->cpumask = nodemask;
-		/* ->cpu_power already setup */
-
-		if (!first)
-			first = cpu;
-		if (last)
-			last->next = cpu;
-		last = cpu;
-	}
-	last->next = first;
-
-	mb();
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		cpu_attach_domain(cpu_domain, i);
-	}
-}
-#else /* !CONFIG_NUMA */
-static struct sched_group sched_group_cpus[NR_CPUS];
-static struct sched_group sched_group_phys[NR_CPUS];
-static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
-static DEFINE_PER_CPU(struct sched_domain, phys_domains);
-__init void arch_init_sched_domains(void)
-{
-	int i;
-	struct sched_group *first = NULL, *last = NULL;
-
-	/* Set up domains */
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		struct sched_domain *phys_domain = &per_cpu(phys_domains, i);
-		cpumask_t my_cpumask = cpumask_of_cpu(i);
-		cpumask_t sibling_cpumask = cpumask_of_cpu(i ^ 0x1);
-
-		*cpu_domain = SD_SIBLING_INIT;
-		if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
-			cpus_or(cpu_domain->span, my_cpumask, sibling_cpumask);
-		else
-			cpu_domain->span = my_cpumask;
-		cpu_domain->parent = phys_domain;
-		cpu_domain->groups = &sched_group_cpus[i];
-
-		*phys_domain = SD_CPU_INIT;
-		phys_domain->span = cpu_possible_map;
-		phys_domain->groups = &sched_group_phys[first_cpu(cpu_domain->span)];
-	}
-
-	/* Set up CPU (sibling) groups */
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		int j;
-		first = last = NULL;
-
-		if (i != first_cpu(cpu_domain->span))
-			continue;
-
-		for_each_cpu_mask(j, cpu_domain->span) {
-			struct sched_group *cpu = &sched_group_cpus[j];
-
-			cpus_clear(cpu->cpumask);
-			cpu_set(j, cpu->cpumask);
-			cpu->cpu_power = SCHED_LOAD_SCALE;
-
-			if (!first)
-				first = cpu;
-			if (last)
-				last->next = cpu;
-			last = cpu;
-		}
-		last->next = first;
-	}
-
-	first = last = NULL;
-	/* Set up physical groups */
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		struct sched_group *cpu = &sched_group_phys[i];
-
-		if (i != first_cpu(cpu_domain->span))
-			continue;
-
-		cpu->cpumask = cpu_domain->span;
-		/* See SMT+NUMA setup for comment */
-		cpu->cpu_power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE*(cpus_weight(cpu->cpumask)-1) / 10;
-
-		if (!first)
-			first = cpu;
-		if (last)
-			last->next = cpu;
-		last = cpu;
-	}
-	last->next = first;
-
-	mb();
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		cpu_attach_domain(cpu_domain, i);
-	}
-}
-#endif /* CONFIG_NUMA */
-#endif /* CONFIG_SCHED_SMT */
diff -L arch/x86_64/kernel/domain.c -puN arch/x86_64/kernel/domain.c~sched-consolidate-domains /dev/null
--- linux-2.6/arch/x86_64/kernel/domain.c
+++ /dev/null	2004-06-24 18:17:02.000000000 +1000
@@ -1,93 +0,0 @@
-#include <linux/init.h>
-#include <linux/sched.h>
-
-/* Don't do any NUMA setup on Opteron right now. They seem to be
-   better off with flat scheduling. This is just for SMT. */
-
-#ifdef CONFIG_SCHED_SMT
-
-static struct sched_group sched_group_cpus[NR_CPUS];
-static struct sched_group sched_group_phys[NR_CPUS];
-static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
-static DEFINE_PER_CPU(struct sched_domain, phys_domains);
-__init void arch_init_sched_domains(void)
-{
-	int i;
-	struct sched_group *first = NULL, *last = NULL;
-
-	/* Set up domains */
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		struct sched_domain *phys_domain = &per_cpu(phys_domains, i);
-
-		*cpu_domain = SD_SIBLING_INIT;
-		/* Disable SMT NICE for CMP */
-		/* RED-PEN use a generic flag */ 
-		if (cpu_data[i].x86_vendor == X86_VENDOR_AMD) 
-			cpu_domain->flags &= ~SD_SHARE_CPUPOWER; 
-		cpu_domain->span = cpu_sibling_map[i];
-		cpu_domain->parent = phys_domain;
-		cpu_domain->groups = &sched_group_cpus[i];
-
-		*phys_domain = SD_CPU_INIT;
-		phys_domain->span = cpu_possible_map;
-		phys_domain->groups = &sched_group_phys[first_cpu(cpu_domain->span)];
-	}
-
-	/* Set up CPU (sibling) groups */
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		int j;
-		first = last = NULL;
-
-		if (i != first_cpu(cpu_domain->span))
-			continue;
-
-		for_each_cpu_mask(j, cpu_domain->span) {
-			struct sched_group *cpu = &sched_group_cpus[j];
-
-			cpus_clear(cpu->cpumask);
-			cpu_set(j, cpu->cpumask);
-			cpu->cpu_power = SCHED_LOAD_SCALE;
-
-			if (!first)
-				first = cpu;
-			if (last)
-				last->next = cpu;
-			last = cpu;
-		}
-		last->next = first;
-	}
-
-	first = last = NULL;
-	/* Set up physical groups */
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		struct sched_group *cpu = &sched_group_phys[i];
-
-		if (i != first_cpu(cpu_domain->span))
-			continue;
-
-		cpu->cpumask = cpu_domain->span;
-		/*
-		 * Make each extra sibling increase power by 10% of
-		 * the basic CPU. This is very arbitrary.
-		 */
-		cpu->cpu_power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE*(cpus_weight(cpu->cpumask)-1) / 10;
-
-		if (!first)
-			first = cpu;
-		if (last)
-			last->next = cpu;
-		last = cpu;
-	}
-	last->next = first;
-
-	mb();
-	for_each_cpu(i) {
-		struct sched_domain *cpu_domain = &per_cpu(cpu_domains, i);
-		cpu_attach_domain(cpu_domain, i);
-	}
-}
-
-#endif
diff -puN arch/x86_64/kernel/Makefile~sched-consolidate-domains arch/x86_64/kernel/Makefile
--- linux-2.6/arch/x86_64/kernel/Makefile~sched-consolidate-domains	2004-07-23 13:08:55.000000000 +1000
+++ linux-2.6-npiggin/arch/x86_64/kernel/Makefile	2004-07-23 13:08:55.000000000 +1000
@@ -25,7 +25,6 @@ obj-$(CONFIG_EARLY_PRINTK)	+= early_prin
 obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o aperture.o
 obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
 obj-$(CONFIG_SWIOTLB)		+= swiotlb.o
-obj-$(CONFIG_SCHED_SMT)		+= domain.o
 
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_KGDB)		+= kgdb_stub.o
diff -puN arch/x86_64/kernel/Makefile-HEAD~sched-consolidate-domains arch/x86_64/kernel/Makefile-HEAD
--- linux-2.6/arch/x86_64/kernel/Makefile-HEAD~sched-consolidate-domains	2004-07-23 13:08:55.000000000 +1000
+++ linux-2.6-npiggin/arch/x86_64/kernel/Makefile-HEAD	2004-07-23 13:08:55.000000000 +1000
@@ -25,7 +25,6 @@ obj-$(CONFIG_EARLY_PRINTK)	+= early_prin
 obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o aperture.o
 obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
 obj-$(CONFIG_SWIOTLB)		+= swiotlb.o
-obj-$(CONFIG_SCHED_SMT)		+= domain.o
 
 obj-$(CONFIG_MODULES)		+= module.o
 
diff -puN include/asm-ppc64/smp.h~sched-consolidate-domains include/asm-ppc64/smp.h
--- linux-2.6/include/asm-ppc64/smp.h~sched-consolidate-domains	2004-07-23 13:08:55.000000000 +1000
+++ linux-2.6-npiggin/include/asm-ppc64/smp.h	2004-07-23 13:08:55.000000000 +1000
@@ -73,6 +73,9 @@ void smp_init_pSeries(void);
 extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
 extern void cpu_die(void) __attribute__((noreturn));
+#ifdef CONFIG_SCHED_SMT
+extern cpumask_t cpu_sibling_map[NR_CPUS];
+#endif
 #endif /* !(CONFIG_SMP) */
 
 #define get_hard_smp_processor_id(CPU) (paca[(CPU)].hw_cpu_id)
diff -puN Documentation/sched-domains.txt~sched-consolidate-domains Documentation/sched-domains.txt
--- linux-2.6/Documentation/sched-domains.txt~sched-consolidate-domains	2004-07-23 13:08:55.000000000 +1000
+++ linux-2.6-npiggin/Documentation/sched-domains.txt	2004-07-23 13:08:55.000000000 +1000
@@ -5,12 +5,13 @@ MUST be NULL terminated, and domain stru
 are locklessly updated.
 
 Each scheduling domain spans a number of CPUs (stored in the ->span field).
-A domain's span MUST be a superset of it child's span, and a base domain
-for CPU i MUST span at least i. The top domain for each CPU will generally
-span all CPUs in the system although strictly it doesn't have to, but this
-could lead to a case where some CPUs will never be given tasks to run unless
-the CPUs allowed mask is explicitly set. A sched domain's span means "balance
-process load among these CPUs".
+A domain's span MUST be a superset of it child's span (this restriction could
+be relaxed if the need arises), and a base domain for CPU i MUST span at least
+i. The top domain for each CPU will generally span all CPUs in the system
+although strictly it doesn't have to, but this could lead to a case where some
+CPUs will never be given tasks to run unless the CPUs allowed mask is
+explicitly set. A sched domain's span means "balance process load among these
+CPUs".
 
 Each scheduling domain must have one or more CPU groups (struct sched_group)
 which are organised as a circular one way linked list from the ->groups
@@ -46,6 +47,20 @@ The implementor should read comments in 
 struct sched_domain fields, SD_FLAG_*, SD_*_INIT to get an idea of
 the specifics and what to tune.
 
+For SMT, the architecture must define CONFIG_SCHED_SMT and provide a
+cpumask_t cpu_sibling_map[NR_CPUS], where cpu_sibling_map[i] is the mask of
+all "i"'s siblings as well as "i" itself.
+
+Architectures may retain the regular override the default SD_*_INIT flags
+while using the generic domain builder in kernel/sched.c if they wish to
+retain the traditional SMT->SMP->NUMA topology (or some subset of that). This
+can be done by #define'ing ARCH_HASH_SCHED_TUNE.
+
+Alternatively, the architecture may completely override the generic domain
+builder by #define'ing ARCH_HASH_SCHED_DOMAIN, and exporting your
+arch_init_sched_domains function. This function will attach domains to all
+CPUs using cpu_attach_domain.
+
 Implementors should change the line
 #undef SCHED_DOMAIN_DEBUG
 to

_

--------------090006070803090906070809--
