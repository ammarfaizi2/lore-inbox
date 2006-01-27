Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWA0DwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWA0DwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 22:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWA0DwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 22:52:18 -0500
Received: from fmr22.intel.com ([143.183.121.14]:54222 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750703AbWA0DwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 22:52:17 -0500
Date: Thu, 26 Jan 2006 19:51:56 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, nickpiggin@yahoo.com.au,
       ak@suse.de, linux-kernel@vger.kernel.org, rohit.seth@intel.com,
       asit.k.mallick@intel.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch] sched: new sched domain for representing multi-core
Message-ID: <20060126195156.E19789@unix-os.sc.intel.com>
References: <20060126015132.A8521@unix-os.sc.intel.com> <20060127000854.GA16332@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060127000854.GA16332@elte.hu>; from mingo@elte.hu on Fri, Jan 27, 2006 at 01:08:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 01:08:54AM +0100, Ingo Molnar wrote:
> Otherwise, looks pretty clean to me, both the scheduler and the x86_* 
> arch level bits! Would be nice to get this tested in -mm too.
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

Andrew, Please apply to -mm. Thanks.
--

Appended patch adds a new sched domain for representing multi-core with
shared caches between cores. Consider a dual package system, each package
containing two cores and with last level cache shared between cores with in a
package. If there are two runnable processes, with this appended patch
those two processes will be scheduled on different packages.

On such system, with this patch we have observed 8% perf improvement with 
specJBB(2 warehouse) benchmark and 35% improvement with CFP2000 rate(with
2 users).

This new domain will come into play only on multi-core systems with shared
caches. On other systems, this sched domain will be removed by
domain degeneration code. This new domain can be also used for implementing
power savings policy (see OLS 2005 CMP kernel scheduler paper for more
details.. I will post another patch for power savings policy soon)

Most of the arch/* file changes are for cpu_coregroup_map() implementation.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Acked-by: Ingo Molnar <mingo@elte.hu>

diff -pNru linux-2.6.16-rc1/arch/i386/Kconfig linux-core/arch/i386/Kconfig
--- linux-2.6.16-rc1/arch/i386/Kconfig	2006-01-16 23:44:47.000000000 -0800
+++ linux-core/arch/i386/Kconfig	2006-01-26 18:11:47.370042152 -0800
@@ -235,6 +235,14 @@ config SCHED_SMT
 	  cost of slightly increased overhead in some places. If unsure say
 	  N here.
 
+config SCHED_MC
+	bool "Multi-core scheduler support"
+	depends on SMP
+	help
+	  Multi-core scheduler support improves the CPU scheduler's decision 
+	  making when dealing with multi-core CPU chips at a cost of slightly 
+	  increased overhead in some places. If unsure say N here.
+
 source "kernel/Kconfig.preempt"
 
 config X86_UP_APIC
diff -pNru linux-2.6.16-rc1/arch/i386/kernel/cpu/common.c linux-core/arch/i386/kernel/cpu/common.c
--- linux-2.6.16-rc1/arch/i386/kernel/cpu/common.c	2006-01-16 23:44:47.000000000 -0800
+++ linux-core/arch/i386/kernel/cpu/common.c	2006-01-24 13:35:49.167864480 -0800
@@ -244,7 +244,7 @@ static void __init early_cpu_detect(void
 void __devinit generic_identify(struct cpuinfo_x86 * c)
 {
 	u32 tfms, xlvl;
-	int junk;
+	int ebx;
 
 	if (have_cpuid_p()) {
 		/* Get vendor name */
@@ -260,7 +260,7 @@ void __devinit generic_identify(struct c
 		/* Intel-defined flags: level 0x00000001 */
 		if ( c->cpuid_level >= 0x00000001 ) {
 			u32 capability, excap;
-			cpuid(0x00000001, &tfms, &junk, &excap, &capability);
+			cpuid(0x00000001, &tfms, &ebx, &excap, &capability);
 			c->x86_capability[0] = capability;
 			c->x86_capability[4] = excap;
 			c->x86 = (tfms >> 8) & 15;
@@ -270,6 +270,7 @@ void __devinit generic_identify(struct c
 				c->x86_model += ((tfms >> 16) & 0xF) << 4;
 			} 
 			c->x86_mask = tfms & 15;
+			c->apicid = phys_pkg_id((ebx >> 24) & 0xFF, 0);
 		} else {
 			/* Have CPUID level 0 only - unheard of */
 			c->x86 = 4;
@@ -448,7 +449,6 @@ void __devinit detect_ht(struct cpuinfo_
 
 	cpuid(1, &eax, &ebx, &ecx, &edx);
 
-	c->apicid = phys_pkg_id((ebx >> 24) & 0xFF, 0);
 
 	if (!cpu_has(c, X86_FEATURE_HT) || cpu_has(c, X86_FEATURE_CMP_LEGACY))
 		return;
diff -pNru linux-2.6.16-rc1/arch/i386/kernel/cpu/intel_cacheinfo.c linux-core/arch/i386/kernel/cpu/intel_cacheinfo.c
--- linux-2.6.16-rc1/arch/i386/kernel/cpu/intel_cacheinfo.c	2006-01-16 23:44:47.000000000 -0800
+++ linux-core/arch/i386/kernel/cpu/intel_cacheinfo.c	2006-01-24 14:38:36.361164048 -0800
@@ -161,6 +161,10 @@ unsigned int __cpuinit init_intel_cachei
 	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
 	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
 	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
+	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
+#ifdef CONFIG_SMP
+	unsigned int cpu = (c == &boot_cpu_data) ? 0 : (c - cpu_data);
+#endif
 
 	if (c->cpuid_level > 4) {
 		static int is_initialized;
@@ -193,9 +197,15 @@ unsigned int __cpuinit init_intel_cachei
 					break;
 				    case 2:
 					new_l2 = this_leaf.size/1024;
+					num_threads_sharing = 1 + this_leaf.eax.split.num_threads_sharing;
+					index_msb = get_count_order(num_threads_sharing);
+					l2_id = c->apicid >> index_msb;
 					break;
 				    case 3:
 					new_l3 = this_leaf.size/1024;
+					num_threads_sharing = 1 + this_leaf.eax.split.num_threads_sharing;
+					index_msb = get_count_order(num_threads_sharing);
+					l3_id = c->apicid >> index_msb;
 					break;
 				    default:
 					break;
@@ -261,11 +271,19 @@ unsigned int __cpuinit init_intel_cachei
 		if (new_l1i)
 			l1i = new_l1i;
 
-		if (new_l2)
+		if (new_l2) {
 			l2 = new_l2;
+#ifdef CONFIG_SMP
+			cpu_llc_id[cpu] = l2_id;
+#endif
+		}
 
-		if (new_l3)
+		if (new_l3) {
 			l3 = new_l3;
+#ifdef CONFIG_SMP
+			cpu_llc_id[cpu] = l3_id;
+#endif
+		}
 
 		if ( trace )
 			printk (KERN_INFO "CPU: Trace cache: %dK uops", trace);
diff -pNru linux-2.6.16-rc1/arch/i386/kernel/smpboot.c linux-core/arch/i386/kernel/smpboot.c
--- linux-2.6.16-rc1/arch/i386/kernel/smpboot.c	2006-01-16 23:44:47.000000000 -0800
+++ linux-core/arch/i386/kernel/smpboot.c	2006-01-24 14:21:30.935052512 -0800
@@ -72,6 +72,8 @@ int phys_proc_id[NR_CPUS] __read_mostly 
 /* Core ID of each logical CPU */
 int cpu_core_id[NR_CPUS] __read_mostly = {[0 ... NR_CPUS-1] = BAD_APICID};
 
+int cpu_llc_id[NR_CPUS] __read_mostly = {[0 ... NR_CPUS-1] = BAD_APICID};
+
 /* representing HT siblings of each logical CPU */
 cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_sibling_map);
@@ -84,6 +86,8 @@ EXPORT_SYMBOL(cpu_core_map);
 cpumask_t cpu_online_map __read_mostly;
 EXPORT_SYMBOL(cpu_online_map);
 
+cpumask_t cpu_llc_shared_map[NR_CPUS] __read_mostly;
+
 cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
 EXPORT_SYMBOL(cpu_callout_map);
@@ -444,6 +448,17 @@ static void __devinit smp_callin(void)
 
 static int cpucount;
 
+/* maps the cpu to the sched domain representing multi-core */
+cpumask_t cpu_coregroup_map(int cpu)
+{
+	/*
+	 * For perf, we return last level cache shared map.
+	 * TBD: when power saving sched policy is added, we will return
+	 *      cpu_core_map when power saving policy is enabled
+	 */
+	return cpu_llc_shared_map[cpu];
+}
+
 /* representing cpus for which sibling maps can be computed */
 static cpumask_t cpu_sibling_setup_map;
 
@@ -463,12 +478,16 @@ set_cpu_sibling_map(int cpu)
 				cpu_set(cpu, cpu_sibling_map[i]);
 				cpu_set(i, cpu_core_map[cpu]);
 				cpu_set(cpu, cpu_core_map[i]);
+				cpu_set(i, cpu_llc_shared_map[cpu]);
+				cpu_set(cpu, cpu_llc_shared_map[i]);
 			}
 		}
 	} else {
 		cpu_set(cpu, cpu_sibling_map[cpu]);
 	}
 
+	cpu_set(cpu, cpu_llc_shared_map[cpu]);
+
 	if (current_cpu_data.x86_max_cores == 1) {
 		cpu_core_map[cpu] = cpu_sibling_map[cpu];
 		c[cpu].booted_cores = 1;
@@ -476,6 +495,11 @@ set_cpu_sibling_map(int cpu)
 	}
 
 	for_each_cpu_mask(i, cpu_sibling_setup_map) {
+		if (cpu_llc_id[cpu] != BAD_APICID &&
+		    cpu_llc_id[cpu] == cpu_llc_id[i]) {
+			cpu_set(i, cpu_llc_shared_map[cpu]);
+			cpu_set(cpu, cpu_llc_shared_map[i]);
+		}
 		if (phys_proc_id[cpu] == phys_proc_id[i]) {
 			cpu_set(i, cpu_core_map[cpu]);
 			cpu_set(cpu, cpu_core_map[i]);
diff -pNru linux-2.6.16-rc1/arch/x86_64/Kconfig linux-core/arch/x86_64/Kconfig
--- linux-2.6.16-rc1/arch/x86_64/Kconfig	2006-01-16 23:44:47.000000000 -0800
+++ linux-core/arch/x86_64/Kconfig	2006-01-26 18:21:15.432683504 -0800
@@ -246,6 +246,14 @@ config SCHED_SMT
 	  cost of slightly increased overhead in some places. If unsure say
 	  N here.
 
+config SCHED_MC
+	bool "Multi-core scheduler support"
+	depends on SMP
+	help
+	  Multi-core scheduler support improves the CPU scheduler's decision 
+	  making when dealing with multi-core CPU chips at a cost of slightly 
+	  increased overhead in some places. If unsure say N here.
+
 source "kernel/Kconfig.preempt"
 
 config NUMA
diff -pNru linux-2.6.16-rc1/arch/x86_64/kernel/setup.c linux-core/arch/x86_64/kernel/setup.c
--- linux-2.6.16-rc1/arch/x86_64/kernel/setup.c	2006-01-16 23:44:47.000000000 -0800
+++ linux-core/arch/x86_64/kernel/setup.c	2006-01-24 13:35:49.181862352 -0800
@@ -935,7 +935,6 @@ static void __cpuinit detect_ht(struct c
 
 	cpuid(1, &eax, &ebx, &ecx, &edx);
 
-	c->apicid = phys_pkg_id(0);
 
 	if (!cpu_has(c, X86_FEATURE_HT) || cpu_has(c, X86_FEATURE_CMP_LEGACY))
 		return;
@@ -1144,6 +1143,8 @@ void __cpuinit identify_cpu(struct cpuin
 			c->x86_capability[2] = cpuid_edx(0x80860001);
 	}
 
+	c->apicid = phys_pkg_id(0);
+
 	/*
 	 * Vendor-specific initialization.  In this section we
 	 * canonicalize the feature flags, meaning if there are
diff -pNru linux-2.6.16-rc1/arch/x86_64/kernel/smpboot.c linux-core/arch/x86_64/kernel/smpboot.c
--- linux-2.6.16-rc1/arch/x86_64/kernel/smpboot.c	2006-01-16 23:44:47.000000000 -0800
+++ linux-core/arch/x86_64/kernel/smpboot.c	2006-01-25 22:33:48.297894336 -0800
@@ -67,6 +67,8 @@ u8 phys_proc_id[NR_CPUS] __read_mostly =
 /* core ID of each logical CPU */
 u8 cpu_core_id[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = BAD_APICID };
 
+u8 cpu_llc_id[NR_CPUS] __read_mostly = {[0 ... NR_CPUS-1] = BAD_APICID};
+
 /* Bitmask of currently online CPUs */
 cpumask_t cpu_online_map __read_mostly;
 
@@ -95,6 +97,8 @@ cpumask_t cpu_sibling_map[NR_CPUS] __rea
 cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_core_map);
 
+cpumask_t cpu_llc_shared_map[NR_CPUS] __read_mostly;
+
 /*
  * Trampoline 80x86 program as an array.
  */
@@ -444,6 +448,17 @@ void __cpuinit smp_callin(void)
 	cpu_set(cpuid, cpu_callin_map);
 }
 
+/* maps the cpu to the sched domain representing multi-core */
+cpumask_t cpu_coregroup_map(int cpu)
+{
+	/*
+	 * For perf, we return last level cache shared map.
+	 * TBD: when power saving sched policy is added, we will return
+	 *      cpu_core_map when power saving policy is enabled
+	 */
+	return cpu_llc_shared_map[cpu];
+}
+
 /* representing cpus for which sibling maps can be computed */
 static cpumask_t cpu_sibling_setup_map;
 
@@ -462,12 +477,16 @@ static inline void set_cpu_sibling_map(i
 				cpu_set(cpu, cpu_sibling_map[i]);
 				cpu_set(i, cpu_core_map[cpu]);
 				cpu_set(cpu, cpu_core_map[i]);
+				cpu_set(i, cpu_llc_shared_map[cpu]);
+				cpu_set(cpu, cpu_llc_shared_map[i]);
 			}
 		}
 	} else {
 		cpu_set(cpu, cpu_sibling_map[cpu]);
 	}
 
+	cpu_set(cpu, cpu_llc_shared_map[cpu]);
+
 	if (current_cpu_data.x86_max_cores == 1) {
 		cpu_core_map[cpu] = cpu_sibling_map[cpu];
 		c[cpu].booted_cores = 1;
@@ -475,6 +494,11 @@ static inline void set_cpu_sibling_map(i
 	}
 
 	for_each_cpu_mask(i, cpu_sibling_setup_map) {
+		if (cpu_llc_id[cpu] != BAD_APICID &&
+		    cpu_llc_id[cpu] == cpu_llc_id[i]) {
+			cpu_set(i, cpu_llc_shared_map[cpu]);
+			cpu_set(cpu, cpu_llc_shared_map[i]);
+		}
 		if (phys_proc_id[cpu] == phys_proc_id[i]) {
 			cpu_set(i, cpu_core_map[cpu]);
 			cpu_set(cpu, cpu_core_map[i]);
diff -pNru linux-2.6.16-rc1/include/asm-i386/processor.h linux-core/include/asm-i386/processor.h
--- linux-2.6.16-rc1/include/asm-i386/processor.h	2006-01-16 23:44:47.000000000 -0800
+++ linux-core/include/asm-i386/processor.h	2006-01-24 13:35:49.182862200 -0800
@@ -103,6 +103,7 @@ extern struct cpuinfo_x86 cpu_data[];
 
 extern	int phys_proc_id[NR_CPUS];
 extern	int cpu_core_id[NR_CPUS];
+extern	int cpu_llc_id[NR_CPUS];
 extern char ignore_fpu_irq;
 
 extern void identify_cpu(struct cpuinfo_x86 *);
diff -pNru linux-2.6.16-rc1/include/asm-i386/smp.h linux-core/include/asm-i386/smp.h
--- linux-2.6.16-rc1/include/asm-i386/smp.h	2006-01-16 23:44:47.000000000 -0800
+++ linux-core/include/asm-i386/smp.h	2006-01-24 13:35:49.192860680 -0800
@@ -36,6 +36,7 @@ extern int pic_mode;
 extern int smp_num_siblings;
 extern cpumask_t cpu_sibling_map[];
 extern cpumask_t cpu_core_map[];
+extern cpumask_t cpu_llc_shared_map[];
 
 extern void (*mtrr_hook) (void);
 extern void zap_low_mappings (void);
diff -pNru linux-2.6.16-rc1/include/asm-i386/topology.h linux-core/include/asm-i386/topology.h
--- linux-2.6.16-rc1/include/asm-i386/topology.h	2006-01-16 23:44:47.000000000 -0800
+++ linux-core/include/asm-i386/topology.h	2006-01-24 13:43:46.379317312 -0800
@@ -103,4 +103,6 @@ extern unsigned long node_remap_size[];
 
 #endif /* CONFIG_NUMA */
 
+extern cpumask_t cpu_coregroup_map(int cpu);
+
 #endif /* _ASM_I386_TOPOLOGY_H */
diff -pNru linux-2.6.16-rc1/include/asm-x86_64/smp.h linux-core/include/asm-x86_64/smp.h
--- linux-2.6.16-rc1/include/asm-x86_64/smp.h	2006-01-16 23:44:47.000000000 -0800
+++ linux-core/include/asm-x86_64/smp.h	2006-01-24 13:35:49.193860528 -0800
@@ -54,8 +54,10 @@ extern int smp_call_function_single(int 
 
 extern cpumask_t cpu_sibling_map[NR_CPUS];
 extern cpumask_t cpu_core_map[NR_CPUS];
+extern cpumask_t cpu_llc_shared_map[NR_CPUS];
 extern u8 phys_proc_id[NR_CPUS];
 extern u8 cpu_core_id[NR_CPUS];
+extern u8 cpu_llc_id[NR_CPUS];
 
 #define SMP_TRAMPOLINE_BASE 0x6000
 
diff -pNru linux-2.6.16-rc1/include/asm-x86_64/topology.h linux-core/include/asm-x86_64/topology.h
--- linux-2.6.16-rc1/include/asm-x86_64/topology.h	2006-01-16 23:44:47.000000000 -0800
+++ linux-core/include/asm-x86_64/topology.h	2006-01-24 13:43:57.069692128 -0800
@@ -59,4 +59,6 @@ extern int __node_distance(int, int);
 
 #include <asm-generic/topology.h>
 
+extern cpumask_t cpu_coregroup_map(int cpu);
+
 #endif
diff -pNru linux-2.6.16-rc1/include/linux/topology.h linux-core/include/linux/topology.h
--- linux-2.6.16-rc1/include/linux/topology.h	2006-01-16 23:44:47.000000000 -0800
+++ linux-core/include/linux/topology.h	2006-01-25 21:10:50.380652784 -0800
@@ -156,6 +156,15 @@
 	.nr_balance_failed	= 0,			\
 }
 
+#ifdef CONFIG_SCHED_MC
+#ifndef SD_MC_INIT
+/* for now its same as SD_CPU_INIT.
+ * TBD: Tune Domain parameters!
+ */
+#define SD_MC_INIT   SD_CPU_INIT
+#endif
+#endif
+
 #ifdef CONFIG_NUMA
 #ifndef SD_NODE_INIT
 #error Please define an appropriate SD_NODE_INIT in include/asm/topology.h!!!
diff -pNru linux-2.6.16-rc1/kernel/sched.c linux-core/kernel/sched.c
--- linux-2.6.16-rc1/kernel/sched.c	2006-01-16 23:44:47.000000000 -0800
+++ linux-core/kernel/sched.c	2006-01-26 18:31:37.053182824 -0800
@@ -5658,11 +5658,27 @@ static int cpu_to_cpu_group(int cpu)
 }
 #endif
 
+#ifdef CONFIG_SCHED_MC
+static DEFINE_PER_CPU(struct sched_domain, core_domains);
+static struct sched_group sched_group_core[NR_CPUS];
+static int cpu_to_core_group(int cpu)
+{
+#ifdef	CONFIG_SCHED_SMT
+	return first_cpu(cpu_sibling_map[cpu]);
+#else
+	return cpu;
+#endif
+}
+#endif
+
 static DEFINE_PER_CPU(struct sched_domain, phys_domains);
 static struct sched_group sched_group_phys[NR_CPUS];
 static int cpu_to_phys_group(int cpu)
 {
-#ifdef CONFIG_SCHED_SMT
+#if defined(CONFIG_SCHED_MC)
+	cpumask_t mask = cpu_coregroup_map(cpu);
+	return first_cpu(mask);
+#elif defined(CONFIG_SCHED_SMT)
 	return first_cpu(cpu_sibling_map[cpu]);
 #else
 	return cpu;
@@ -5760,6 +5776,17 @@ void build_sched_domains(const cpumask_t
 		sd->parent = p;
 		sd->groups = &sched_group_phys[group];
 
+#ifdef CONFIG_SCHED_MC
+		p = sd;
+		sd = &per_cpu(core_domains, i);
+		group = cpu_to_core_group(i);
+		*sd = SD_MC_INIT;
+		sd->span = cpu_coregroup_map(i);
+		cpus_and(sd->span, sd->span, *cpu_map);
+		sd->parent = p;
+		sd->groups = &sched_group_core[group];
+#endif
+
 #ifdef CONFIG_SCHED_SMT
 		p = sd;
 		sd = &per_cpu(cpu_domains, i);
@@ -5785,6 +5812,19 @@ void build_sched_domains(const cpumask_t
 	}
 #endif
 
+#ifdef CONFIG_SCHED_MC
+	/* Set up CMP (core) groups */
+	for_each_online_cpu(i) {
+		cpumask_t this_core_map = cpu_coregroup_map(i);
+		cpus_and(this_core_map, this_core_map, *cpu_map);
+		if (i != first_cpu(this_core_map))
+			continue;
+		init_sched_build_groups(sched_group_core, this_core_map,
+					&cpu_to_core_group);
+	}
+#endif
+
+
 	/* Set up physical groups */
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		cpumask_t nodemask = node_to_cpumask(i);
@@ -5881,11 +5921,31 @@ void build_sched_domains(const cpumask_t
 		power = SCHED_LOAD_SCALE;
 		sd->groups->cpu_power = power;
 #endif
+#ifdef CONFIG_SCHED_MC
+		sd = &per_cpu(core_domains, i);
+		power = SCHED_LOAD_SCALE + (cpus_weight(sd->groups->cpumask)-1)
+					    * SCHED_LOAD_SCALE / 10;
+		sd->groups->cpu_power = power;
+ 
+		sd = &per_cpu(phys_domains, i);
 
+ 		/*
+ 		 * This has to be < 2 * SCHED_LOAD_SCALE
+ 		 * Lets keep it SCHED_LOAD_SCALE, so that
+ 		 * while calculating NUMA group's cpu_power
+ 		 * we can simply do
+ 		 *  numa_group->cpu_power += phys_group->cpu_power;
+ 		 *
+ 		 * See "only add power once for each physical pkg"
+ 		 * comment below
+ 		 */
+ 		sd->groups->cpu_power = SCHED_LOAD_SCALE;
+#else
 		sd = &per_cpu(phys_domains, i);
 		power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE *
 				(cpus_weight(sd->groups->cpumask)-1) / 10;
 		sd->groups->cpu_power = power;
+#endif
 
 #ifdef CONFIG_NUMA
 		sd = &per_cpu(allnodes_domains, i);
@@ -5907,7 +5967,6 @@ void build_sched_domains(const cpumask_t
 next_sg:
 		for_each_cpu_mask(j, sg->cpumask) {
 			struct sched_domain *sd;
-			int power;
 
 			sd = &per_cpu(phys_domains, j);
 			if (j != first_cpu(sd->groups->cpumask)) {
@@ -5917,10 +5976,8 @@ next_sg:
 				 */
 				continue;
 			}
-			power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE *
-				(cpus_weight(sd->groups->cpumask)-1) / 10;
 
-			sg->cpu_power += power;
+			sg->cpu_power += sd->groups->cpu_power;
 		}
 		sg = sg->next;
 		if (sg != sched_group_nodes[i])
@@ -5933,6 +5990,8 @@ next_sg:
 		struct sched_domain *sd;
 #ifdef CONFIG_SCHED_SMT
 		sd = &per_cpu(cpu_domains, i);
+#elif defined(CONFIG_SCHED_MC)
+		sd = &per_cpu(core_domains, i);
 #else
 		sd = &per_cpu(phys_domains, i);
 #endif
