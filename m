Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVCPBiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVCPBiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 20:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVCPBiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 20:38:21 -0500
Received: from fmr24.intel.com ([143.183.121.16]:59008 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262390AbVCPBhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 20:37:10 -0500
Date: Tue, 15 Mar 2005 17:36:25 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@muc.de, rohit.seth@intel.com
Subject: [Patch] x86, x86_64: Intel dual-core detection 
Message-ID: <20050315173624.A2100@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Appended patch adds the support for Intel dual-core detection and displaying
the core related information in /proc/cpuinfo. 

It adds two new fields "core id" and "cpu cores" to x86 /proc/cpuinfo
and the "core id" field for x86_64("cpu cores" field is already present in
x86_64).

Number of processor cores in a die is detected using cpuid(4) and this
is documented in IA-32 Intel Architecture Software Developer's Manual (vol 2a)
(http://developer.intel.com/design/pentium4/manuals/index_new.htm#sdm_vol2a)

This patch also adds cpu_core_map similar to cpu_sibling_map.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

diff -Nru linux-2.6.11/arch/i386/kernel/cpu/amd.c linux-mc/arch/i386/kernel/cpu/amd.c
--- linux-2.6.11/arch/i386/kernel/cpu/amd.c	2005-03-01 23:38:26.000000000 -0800
+++ linux-mc/arch/i386/kernel/cpu/amd.c	2004-11-01 16:13:46.141256624 -0800
@@ -188,6 +188,13 @@
 	}
 
 	display_cacheinfo(c);
+
+	if (cpuid_eax(0x80000000) >= 0x80000008) {
+		c->x86_num_cores = (cpuid_ecx(0x80000008) & 0xff) + 1;
+		if (c->x86_num_cores & (c->x86_num_cores - 1))
+			c->x86_num_cores = 1;
+	}
+
 	detect_ht(c);
 
 #ifdef CONFIG_X86_HT
@@ -199,12 +206,6 @@
 	if (cpu_has(c, X86_FEATURE_CMP_LEGACY))
 		smp_num_siblings = 1;
 #endif
-
-	if (cpuid_eax(0x80000000) >= 0x80000008) {
-		c->x86_num_cores = (cpuid_ecx(0x80000008) & 0xff) + 1;
-		if (c->x86_num_cores & (c->x86_num_cores - 1))
-			c->x86_num_cores = 1;
-	}
 }
 
 static unsigned int amd_size_cache(struct cpuinfo_x86 * c, unsigned int size)
diff -Nru linux-2.6.11/arch/i386/kernel/cpu/common.c linux-mc/arch/i386/kernel/cpu/common.c
--- linux-2.6.11/arch/i386/kernel/cpu/common.c	2005-03-01 23:37:47.000000000 -0800
+++ linux-mc/arch/i386/kernel/cpu/common.c	2004-11-07 11:34:10.237802664 -0800
@@ -441,7 +441,7 @@
 void __init detect_ht(struct cpuinfo_x86 *c)
 {
 	u32 	eax, ebx, ecx, edx;
-	int 	index_lsb, index_msb, tmp;
+	int 	index_msb, tmp;
 	int 	cpu = smp_processor_id();
 
 	if (!cpu_has(c, X86_FEATURE_HT))
@@ -453,7 +453,6 @@
 	if (smp_num_siblings == 1) {
 		printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
 	} else if (smp_num_siblings > 1 ) {
-		index_lsb = 0;
 		index_msb = 31;
 
 		if (smp_num_siblings > NR_CPUS) {
@@ -462,21 +461,34 @@
 			return;
 		}
 		tmp = smp_num_siblings;
-		while ((tmp & 1) == 0) {
-			tmp >>=1 ;
-			index_lsb++;
-		}
-		tmp = smp_num_siblings;
 		while ((tmp & 0x80000000 ) == 0) {
 			tmp <<=1 ;
 			index_msb--;
 		}
-		if (index_lsb != index_msb )
+		if (smp_num_siblings & (smp_num_siblings - 1))
 			index_msb++;
 		phys_proc_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb);
 
 		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
 		       phys_proc_id[cpu]);
+		
+		smp_num_siblings = smp_num_siblings / c->x86_num_cores;
+
+		tmp = smp_num_siblings;
+		index_msb = 31;
+		while ((tmp & 0x80000000) == 0) {
+			tmp <<=1 ;
+			index_msb--;
+		}
+
+		if (smp_num_siblings & (smp_num_siblings - 1))
+			index_msb++;
+
+		cpu_core_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb);
+
+		if (c->x86_num_cores > 1)
+			printk(KERN_INFO  "CPU: Processor Core ID: %d\n",
+			       cpu_core_id[cpu]);
 	}
 }
 #endif
diff -Nru linux-2.6.11/arch/i386/kernel/cpu/intel.c linux-mc/arch/i386/kernel/cpu/intel.c
--- linux-2.6.11/arch/i386/kernel/cpu/intel.c	2005-03-01 23:37:52.000000000 -0800
+++ linux-mc/arch/i386/kernel/cpu/intel.c	2004-11-01 16:13:46.187249632 -0800
@@ -77,6 +77,27 @@
 }
 
 
+/*
+ * find out the number of processor cores on the die
+ */
+static int __init num_cpu_cores(struct cpuinfo_x86 *c)
+{
+	unsigned int eax;
+
+	if (c->cpuid_level < 4)
+		return 1;
+
+	__asm__("cpuid"
+		: "=a" (eax)
+		: "0" (4), "c" (0)
+		: "bx", "dx");
+
+	if (eax & 0x1f)
+		return ((eax >> 26) + 1);
+	else
+		return 1;
+}
+
 static void __init init_intel(struct cpuinfo_x86 *c)
 {
 	unsigned int l2 = 0;
@@ -139,6 +160,8 @@
 	if ( p )
 		strcpy(c->x86_model_id, p);
 	
+	c->x86_num_cores = num_cpu_cores(c);
+
 	detect_ht(c);
 
 	/* Work around errata */
diff -Nru linux-2.6.11/arch/i386/kernel/cpu/proc.c linux-mc/arch/i386/kernel/cpu/proc.c
--- linux-2.6.11/arch/i386/kernel/cpu/proc.c	2005-03-01 23:38:25.000000000 -0800
+++ linux-mc/arch/i386/kernel/cpu/proc.c	2004-11-06 11:34:08.794818520 -0800
@@ -94,8 +94,12 @@
 	if (c->x86_cache_size >= 0)
 		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
 #ifdef CONFIG_X86_HT
-	seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
-	seq_printf(m, "siblings\t: %d\n", c->x86_num_cores * smp_num_siblings);
+	if (smp_num_siblings > 1 || c->x86_num_cores > 1) {
+		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
+		seq_printf(m, "siblings\t: %d\n", c->x86_num_cores * smp_num_siblings);
+		seq_printf(m, "core id\t\t: %d\n", cpu_core_id[n]);
+		seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
+	}
 #endif
 	
 	/* We use exception 16 if we have hardware math and we've either seen it or the CPU claims it is internal */
diff -Nru linux-2.6.11/arch/i386/kernel/smpboot.c linux-mc/arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c	2004-11-05 11:41:28.582757080 -0800
+++ linux-mc/arch/i386/kernel/smpboot.c	2004-11-07 11:34:17.781655824 -0800
@@ -62,6 +62,8 @@
 int smp_num_siblings = 1;
 int phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
 EXPORT_SYMBOL(phys_proc_id);
+int cpu_core_id[NR_CPUS]; /* Core ID of each logical CPU */
+EXPORT_SYMBOL(cpu_core_id);
 
 /* bitmap of online cpus */
 cpumask_t cpu_online_map;
@@ -900,6 +902,7 @@
 void *xquad_portio;
 
 cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
+cpumask_t cpu_core_map[NR_CPUS] __cacheline_aligned;
 
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
@@ -922,6 +925,9 @@
 	cpus_clear(cpu_sibling_map[0]);
 	cpu_set(0, cpu_sibling_map[0]);
 
+	cpus_clear(cpu_core_map[0]);
+	cpu_set(0, cpu_core_map[0]);
+
 	/*
 	 * If we couldn't find an SMP configuration at boot time,
 	 * get out of here now!
@@ -1050,10 +1056,13 @@
 	 * construct cpu_sibling_map[], so that we can tell sibling CPUs
 	 * efficiently.
 	 */
-	for (cpu = 0; cpu < NR_CPUS; cpu++)
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		cpus_clear(cpu_sibling_map[cpu]);
+		cpus_clear(cpu_core_map[cpu]);
+	}
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		struct cpuinfo_x86 *c = cpu_data + cpu;
 		int siblings = 0;
 		int i;
 		if (!cpu_isset(cpu, cpu_callout_map))
@@ -1063,7 +1072,7 @@
 			for (i = 0; i < NR_CPUS; i++) {
 				if (!cpu_isset(i, cpu_callout_map))
 					continue;
-				if (phys_proc_id[cpu] == phys_proc_id[i]) {
+				if (cpu_core_id[cpu] == cpu_core_id[i]) {
 					siblings++;
 					cpu_set(i, cpu_sibling_map[cpu]);
 				}
@@ -1075,6 +1084,18 @@
 
 		if (siblings != smp_num_siblings)
 			printk(KERN_WARNING "WARNING: %d siblings found for CPU%d, should be %d\n", siblings, cpu, smp_num_siblings);
+
+		if (c->x86_num_cores > 1) {
+			for (i = 0; i < NR_CPUS; i++) {
+				if (!cpu_isset(i, cpu_callout_map))
+					continue;
+				if (phys_proc_id[cpu] == phys_proc_id[i]) {
+					cpu_set(i, cpu_core_map[cpu]);
+				}
+			}
+		} else {
+			cpu_core_map[cpu] = cpu_sibling_map[cpu];
+		}
 	}
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
diff -Nru linux-2.6.11/arch/x86_64/kernel/setup.c linux-mc/arch/x86_64/kernel/setup.c
--- linux-2.6.11/arch/x86_64/kernel/setup.c	2005-03-01 23:37:47.000000000 -0800
+++ linux-mc/arch/x86_64/kernel/setup.c	2004-11-07 11:33:23.467912768 -0800
@@ -788,7 +788,7 @@
 {
 #ifdef CONFIG_SMP
 	u32 	eax, ebx, ecx, edx;
-	int 	index_lsb, index_msb, tmp;
+	int 	index_msb, tmp;
 	int 	cpu = smp_processor_id();
 	
 	if (!cpu_has(c, X86_FEATURE_HT))
@@ -800,7 +800,6 @@
 	if (smp_num_siblings == 1) {
 		printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
 	} else if (smp_num_siblings > 1) {
-		index_lsb = 0;
 		index_msb = 31;
 		/*
 		 * At this point we only support two siblings per
@@ -812,21 +811,33 @@
 			return;
 		}
 		tmp = smp_num_siblings;
-		while ((tmp & 1) == 0) {
-			tmp >>=1 ;
-			index_lsb++;
-		}
-		tmp = smp_num_siblings;
 		while ((tmp & 0x80000000 ) == 0) {
 			tmp <<=1 ;
 			index_msb--;
 		}
-		if (index_lsb != index_msb )
+		if (smp_num_siblings & (smp_num_siblings - 1))
 			index_msb++;
 		phys_proc_id[cpu] = phys_pkg_id(index_msb);
 		
 		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
 		       phys_proc_id[cpu]);
+
+		smp_num_siblings = smp_num_siblings / c->x86_num_cores;
+
+		tmp = smp_num_siblings;
+		index_msb = 31;
+		while ((tmp & 0x80000000) == 0) {
+			tmp <<=1 ;
+			index_msb--;
+		}
+		if (smp_num_siblings & (smp_num_siblings - 1))
+			index_msb++;
+
+		cpu_core_id[cpu] = phys_pkg_id(index_msb);
+
+		if (c->x86_num_cores > 1)
+			printk(KERN_INFO  "CPU: Processor Core ID: %d\n",
+			       cpu_core_id[cpu]);
 	}
 #endif
 }
@@ -843,7 +854,28 @@
 		smp_num_siblings = 1;
 #endif
 }
-	
+
+/*
+ * find out the number of processor cores on the die
+ */
+static int __init num_cpu_cores(struct cpuinfo_x86 *c)
+{
+	unsigned int eax;
+
+	if (c->cpuid_level < 4)
+		return 1;
+
+	__asm__("cpuid"
+		: "=a" (eax)
+		: "0" (4), "c" (0)
+		: "bx", "dx");
+
+	if (eax & 0x1f)
+		return ((eax >> 26) + 1);
+	else
+		return 1;
+}
+
 static void __init init_intel(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
@@ -859,6 +891,8 @@
 
 	if (c->x86 == 15)
 		c->x86_cache_alignment = c->x86_clflush_size * 2;
+
+	c->x86_num_cores = num_cpu_cores(c);
 }
 
 void __init get_cpu_vendor(struct cpuinfo_x86 *c)
@@ -1115,8 +1149,12 @@
 		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
 	
 #ifdef CONFIG_SMP
-	seq_printf(m, "physical id\t: %d\n", phys_proc_id[c - cpu_data]);
-	seq_printf(m, "siblings\t: %d\n", c->x86_num_cores * smp_num_siblings);
+	if (smp_num_siblings > 1 || c->x86_num_cores > 1) {
+		seq_printf(m, "physical id\t: %d\n", phys_proc_id[c - cpu_data]);
+		seq_printf(m, "siblings\t: %d\n", c->x86_num_cores * smp_num_siblings);
+		seq_printf(m, "core id\t\t: %d\n", cpu_core_id[c - cpu_data]);
+		seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
+	}
 #endif	
 
 	seq_printf(m,
@@ -1158,10 +1196,6 @@
 					seq_printf(m, " [%d]", i);
 			}
 	}
-	seq_printf(m, "\n");
-
-	if (c->x86_num_cores > 1)
-		seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
 
 	seq_printf(m, "\n\n"); 
 
diff -Nru linux-2.6.11/arch/x86_64/kernel/smpboot.c linux-mc/arch/x86_64/kernel/smpboot.c
--- linux-2.6.11/arch/x86_64/kernel/smpboot.c	2005-03-01 23:38:33.000000000 -0800
+++ linux-mc/arch/x86_64/kernel/smpboot.c	2004-11-07 11:33:37.282812584 -0800
@@ -58,7 +58,10 @@
 int smp_num_siblings = 1;
 /* Package ID of each logical CPU */
 u8 phys_proc_id[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
+/* Core ID of each logical CPU */
+u8 cpu_core_id[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 EXPORT_SYMBOL(phys_proc_id);
+EXPORT_SYMBOL(cpu_core_id);
 
 /* Bitmask of currently online CPUs */
 cpumask_t cpu_online_map;
@@ -74,6 +77,7 @@
 int smp_threads_ready;
 
 cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
+cpumask_t cpu_core_map[NR_CPUS] __cacheline_aligned;
 
 /*
  * Trampoline 80x86 program as an array.
@@ -857,10 +861,13 @@
 	 * Construct cpu_sibling_map[], so that we can tell the
 	 * sibling CPU efficiently.
 	 */
-	for (cpu = 0; cpu < NR_CPUS; cpu++)
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		cpus_clear(cpu_sibling_map[cpu]);
+		cpus_clear(cpu_core_map[cpu]);
+	}
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		struct cpuinfo_x86 *c = cpu_data + cpu;
 		int siblings = 0;
 		int i;
 		if (!cpu_isset(cpu, cpu_callout_map))
@@ -870,7 +877,7 @@
 			for (i = 0; i < NR_CPUS; i++) {
 				if (!cpu_isset(i, cpu_callout_map))
 					continue;
-				if (phys_proc_id[cpu] == phys_proc_id[i]) {
+				if (cpu_core_id[cpu] == cpu_core_id[i]) {
 					siblings++;
 					cpu_set(i, cpu_sibling_map[cpu]);
 				}
@@ -886,6 +893,17 @@
 			       siblings, cpu, smp_num_siblings);
 			smp_num_siblings = siblings;
 		}       
+
+		if (c->x86_num_cores > 1) {
+			for (i = 0; i < NR_CPUS; i++) {
+				if (!cpu_isset(i, cpu_callout_map))
+					continue;
+				if (phys_proc_id[cpu] == phys_proc_id[i]) {
+					cpu_set(i, cpu_core_map[cpu]);
+				}
+			}
+		} else
+			cpu_core_map[cpu] = cpu_sibling_map[cpu];
 	}
 
 	Dprintk("Boot done.\n");
diff -Nru linux-2.6.11/include/asm-i386/processor.h linux-mc/include/asm-i386/processor.h
--- linux-2.6.11/include/asm-i386/processor.h	2005-03-01 23:37:47.000000000 -0800
+++ linux-mc/include/asm-i386/processor.h	2004-11-01 16:32:21.407710352 -0800
@@ -98,6 +98,7 @@
 #endif
 
 extern	int phys_proc_id[NR_CPUS];
+extern	int cpu_core_id[NR_CPUS];
 extern char ignore_fpu_irq;
 
 extern void identify_cpu(struct cpuinfo_x86 *);
diff -Nru linux-2.6.11/include/asm-i386/smp.h linux-mc/include/asm-i386/smp.h
--- linux-2.6.11/include/asm-i386/smp.h	2005-03-01 23:38:38.000000000 -0800
+++ linux-mc/include/asm-i386/smp.h	2004-11-07 11:34:30.182770568 -0800
@@ -35,6 +35,7 @@
 extern int pic_mode;
 extern int smp_num_siblings;
 extern cpumask_t cpu_sibling_map[];
+extern cpumask_t cpu_core_map[];
 
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
diff -Nru linux-2.6.11/include/asm-x86_64/smp.h linux-mc/include/asm-x86_64/smp.h
--- linux-2.6.11/include/asm-x86_64/smp.h	2005-03-01 23:38:34.000000000 -0800
+++ linux-mc/include/asm-x86_64/smp.h	2004-11-07 11:33:58.856532880 -0800
@@ -48,7 +48,9 @@
 extern void zap_low_mappings(void);
 void smp_stop_cpu(void);
 extern cpumask_t cpu_sibling_map[NR_CPUS];
+extern cpumask_t cpu_core_map[NR_CPUS];
 extern u8 phys_proc_id[NR_CPUS];
+extern u8 cpu_core_id[NR_CPUS];
 
 #define SMP_TRAMPOLINE_BASE 0x6000
 
