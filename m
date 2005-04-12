Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVDLT3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVDLT3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVDLT2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:28:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:18121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262196AbVDLKcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:20 -0400
Message-Id: <200504121032.j3CAWAek005522@shell0.pdx.osdl.net>
Subject: [patch 097/198] x86_64: add support for Intel dual-core detection and displaying
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de,
       suresh.b.siddha@intel.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Appended patch adds the support for Intel dual-core detection and displaying
the core related information in /proc/cpuinfo.  

It adds two new fields "core id" and "cpu cores" to x86 /proc/cpuinfo and the
"core id" field for x86_64("cpu cores" field is already present in x86_64).

Number of processor cores in a die is detected using cpuid(4) and this is
documented in IA-32 Intel Architecture Software Developer's Manual (vol 2a)
(http://developer.intel.com/design/pentium4/manuals/index_new.htm#sdm_vol2a)

This patch also adds cpu_core_map similar to cpu_sibling_map.

Slightly hacked by AK.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/cpu/amd.c    |   13 +++---
 25-akpm/arch/i386/kernel/cpu/common.c |   28 ++++++++++----
 25-akpm/arch/i386/kernel/cpu/intel.c  |   23 ++++++++++++
 25-akpm/arch/i386/kernel/cpu/proc.c   |    8 ++++
 25-akpm/arch/i386/kernel/smpboot.c    |   31 +++++++++++++++-
 25-akpm/arch/x86_64/kernel/setup.c    |   64 ++++++++++++++++++++++++++--------
 25-akpm/arch/x86_64/kernel/smpboot.c  |   24 +++++++++++-
 25-akpm/include/asm-i386/processor.h  |    1 
 25-akpm/include/asm-i386/smp.h        |    1 
 25-akpm/include/asm-x86_64/smp.h      |    2 +
 10 files changed, 163 insertions(+), 32 deletions(-)

diff -puN arch/i386/kernel/cpu/amd.c~x86_64-adds-support-for-intel-dual-core-detection-and-displaying arch/i386/kernel/cpu/amd.c
--- 25/arch/i386/kernel/cpu/amd.c~x86_64-adds-support-for-intel-dual-core-detection-and-displaying	2005-04-12 03:21:26.167158888 -0700
+++ 25-akpm/arch/i386/kernel/cpu/amd.c	2005-04-12 03:21:26.182156608 -0700
@@ -188,6 +188,13 @@ static void __init init_amd(struct cpuin
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
@@ -199,12 +206,6 @@ static void __init init_amd(struct cpuin
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
diff -puN arch/i386/kernel/cpu/common.c~x86_64-adds-support-for-intel-dual-core-detection-and-displaying arch/i386/kernel/cpu/common.c
--- 25/arch/i386/kernel/cpu/common.c~x86_64-adds-support-for-intel-dual-core-detection-and-displaying	2005-04-12 03:21:26.168158736 -0700
+++ 25-akpm/arch/i386/kernel/cpu/common.c	2005-04-12 03:21:26.183156456 -0700
@@ -434,7 +434,7 @@ void __init identify_cpu(struct cpuinfo_
 void __init detect_ht(struct cpuinfo_x86 *c)
 {
 	u32 	eax, ebx, ecx, edx;
-	int 	index_lsb, index_msb, tmp;
+	int 	index_msb, tmp;
 	int 	cpu = smp_processor_id();
 
 	if (!cpu_has(c, X86_FEATURE_HT))
@@ -446,7 +446,6 @@ void __init detect_ht(struct cpuinfo_x86
 	if (smp_num_siblings == 1) {
 		printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
 	} else if (smp_num_siblings > 1 ) {
-		index_lsb = 0;
 		index_msb = 31;
 
 		if (smp_num_siblings > NR_CPUS) {
@@ -455,21 +454,34 @@ void __init detect_ht(struct cpuinfo_x86
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
diff -puN arch/i386/kernel/cpu/intel.c~x86_64-adds-support-for-intel-dual-core-detection-and-displaying arch/i386/kernel/cpu/intel.c
--- 25/arch/i386/kernel/cpu/intel.c~x86_64-adds-support-for-intel-dual-core-detection-and-displaying	2005-04-12 03:21:26.169158584 -0700
+++ 25-akpm/arch/i386/kernel/cpu/intel.c	2005-04-12 03:21:26.184156304 -0700
@@ -77,6 +77,27 @@ static void __init Intel_errata_workarou
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
@@ -139,6 +160,8 @@ static void __init init_intel(struct cpu
 	if ( p )
 		strcpy(c->x86_model_id, p);
 	
+	c->x86_num_cores = num_cpu_cores(c);
+
 	detect_ht(c);
 
 	/* Work around errata */
diff -puN arch/i386/kernel/cpu/proc.c~x86_64-adds-support-for-intel-dual-core-detection-and-displaying arch/i386/kernel/cpu/proc.c
--- 25/arch/i386/kernel/cpu/proc.c~x86_64-adds-support-for-intel-dual-core-detection-and-displaying	2005-04-12 03:21:26.171158280 -0700
+++ 25-akpm/arch/i386/kernel/cpu/proc.c	2005-04-12 03:21:26.184156304 -0700
@@ -129,6 +129,14 @@ static int show_cpuinfo(struct seq_file 
 	seq_printf(m, "\nbogomips\t: %lu.%02lu\n\n",
 		     c->loops_per_jiffy/(500000/HZ),
 		     (c->loops_per_jiffy/(5000/HZ)) % 100);
+
+#ifdef CONFIG_SMP
+	/* Put new fields at the end to lower the probability of
+	   breaking user space parsers. */
+	seq_printf(m, "core id\t\t: %d\n", cpu_core_id[n]);
+	seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
+#endif
+
 	return 0;
 }
 
diff -puN arch/i386/kernel/smpboot.c~x86_64-adds-support-for-intel-dual-core-detection-and-displaying arch/i386/kernel/smpboot.c
--- 25/arch/i386/kernel/smpboot.c~x86_64-adds-support-for-intel-dual-core-detection-and-displaying	2005-04-12 03:21:26.172158128 -0700
+++ 25-akpm/arch/i386/kernel/smpboot.c	2005-04-12 03:21:26.186156000 -0700
@@ -62,6 +62,8 @@ static int __initdata smp_b_stepping;
 int smp_num_siblings = 1;
 int phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
 EXPORT_SYMBOL(phys_proc_id);
+int cpu_core_id[NR_CPUS]; /* Core ID of each logical CPU */
+EXPORT_SYMBOL(cpu_core_id);
 
 /* bitmap of online cpus */
 cpumask_t cpu_online_map;
@@ -885,6 +887,7 @@ static int boot_cpu_logical_apicid;
 void *xquad_portio;
 
 cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
+cpumask_t cpu_core_map[NR_CPUS] __cacheline_aligned;
 
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
@@ -907,6 +910,9 @@ static void __init smp_boot_cpus(unsigne
 	cpus_clear(cpu_sibling_map[0]);
 	cpu_set(0, cpu_sibling_map[0]);
 
+	cpus_clear(cpu_core_map[0]);
+	cpu_set(0, cpu_core_map[0]);
+
 	/*
 	 * If we couldn't find an SMP configuration at boot time,
 	 * get out of here now!
@@ -919,6 +925,8 @@ static void __init smp_boot_cpus(unsigne
 			printk(KERN_NOTICE "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
 		map_cpu_to_logical_apicid();
+		cpu_set(0, cpu_sibling_map[0]);
+		cpu_set(0, cpu_core_map[0]);
 		return;
 	}
 
@@ -942,6 +950,8 @@ static void __init smp_boot_cpus(unsigne
 		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
 		smpboot_clear_io_apic_irqs();
 		phys_cpu_present_map = physid_mask_of_physid(0);
+		cpu_set(0, cpu_sibling_map[0]);
+		cpu_set(0, cpu_core_map[0]);
 		return;
 	}
 
@@ -955,6 +965,8 @@ static void __init smp_boot_cpus(unsigne
 		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
 		smpboot_clear_io_apic_irqs();
 		phys_cpu_present_map = physid_mask_of_physid(0);
+		cpu_set(0, cpu_sibling_map[0]);
+		cpu_set(0, cpu_core_map[0]);
 		return;
 	}
 
@@ -1035,10 +1047,13 @@ static void __init smp_boot_cpus(unsigne
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
@@ -1048,7 +1063,7 @@ static void __init smp_boot_cpus(unsigne
 			for (i = 0; i < NR_CPUS; i++) {
 				if (!cpu_isset(i, cpu_callout_map))
 					continue;
-				if (phys_proc_id[cpu] == phys_proc_id[i]) {
+				if (cpu_core_id[cpu] == cpu_core_id[i]) {
 					siblings++;
 					cpu_set(i, cpu_sibling_map[cpu]);
 				}
@@ -1060,6 +1075,18 @@ static void __init smp_boot_cpus(unsigne
 
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
diff -puN arch/x86_64/kernel/setup.c~x86_64-adds-support-for-intel-dual-core-detection-and-displaying arch/x86_64/kernel/setup.c
--- 25/arch/x86_64/kernel/setup.c~x86_64-adds-support-for-intel-dual-core-detection-and-displaying	2005-04-12 03:21:26.174157824 -0700
+++ 25-akpm/arch/x86_64/kernel/setup.c	2005-04-12 03:21:26.188155696 -0700
@@ -774,7 +774,7 @@ static void __init detect_ht(struct cpui
 {
 #ifdef CONFIG_SMP
 	u32 	eax, ebx, ecx, edx;
-	int 	index_lsb, index_msb, tmp;
+	int 	index_msb, tmp;
 	int 	cpu = smp_processor_id();
 	
 	if (!cpu_has(c, X86_FEATURE_HT))
@@ -786,7 +786,6 @@ static void __init detect_ht(struct cpui
 	if (smp_num_siblings == 1) {
 		printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
 	} else if (smp_num_siblings > 1) {
-		index_lsb = 0;
 		index_msb = 31;
 		/*
 		 * At this point we only support two siblings per
@@ -798,21 +797,33 @@ static void __init detect_ht(struct cpui
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
@@ -829,7 +840,28 @@ static void __init sched_cmp_hack(struct
 		smp_num_siblings = 1;
 #endif
 }
-	
+
+/*
+ * find out the number of processor cores on the die
+ */
+static int __init intel_num_cpu_cores(struct cpuinfo_x86 *c)
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
@@ -847,6 +879,7 @@ static void __init init_intel(struct cpu
 		c->x86_cache_alignment = c->x86_clflush_size * 2;
 	if (c->x86 >= 15)
 		set_bit(X86_FEATURE_CONSTANT_TSC, &c->x86_capability);
+ 	c->x86_num_cores = intel_num_cpu_cores(c);
 }
 
 void __init get_cpu_vendor(struct cpuinfo_x86 *c)
@@ -1153,13 +1186,16 @@ static int show_cpuinfo(struct seq_file 
 					seq_printf(m, " [%d]", i);
 			}
 	}
-	seq_printf(m, "\n");
 
-	if (c->x86_num_cores > 1)
-		seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
-
-	seq_printf(m, "\n\n"); 
+	seq_printf(m, "\n");
 
+#ifdef CONFIG_SMP
+	/* Put new fields at the end to lower the probability of
+	   breaking user space parsers. */
+	seq_printf(m, "core id\t\t: %d\n", cpu_core_id[c - cpu_data]);
+	seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
+#endif
+	seq_printf(m, "\n");
 	return 0;
 }
 
diff -puN arch/x86_64/kernel/smpboot.c~x86_64-adds-support-for-intel-dual-core-detection-and-displaying arch/x86_64/kernel/smpboot.c
--- 25/arch/x86_64/kernel/smpboot.c~x86_64-adds-support-for-intel-dual-core-detection-and-displaying	2005-04-12 03:21:26.175157672 -0700
+++ 25-akpm/arch/x86_64/kernel/smpboot.c	2005-04-12 03:21:26.189155544 -0700
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
@@ -71,6 +74,7 @@ static cpumask_t smp_commenced_mask;
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
 
 cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
+cpumask_t cpu_core_map[NR_CPUS] __cacheline_aligned;
 
 /*
  * Trampoline 80x86 program as an array.
@@ -713,6 +717,7 @@ static void __init smp_boot_cpus(unsigne
 		io_apic_irqs = 0;
 		cpu_online_map = cpumask_of_cpu(0);
 		cpu_set(0, cpu_sibling_map[0]);
+		cpu_set(0, cpu_core_map[0]);
 		phys_cpu_present_map = physid_mask_of_physid(0);
 		if (APIC_init_uniprocessor())
 			printk(KERN_NOTICE "Local APIC not detected."
@@ -740,6 +745,7 @@ static void __init smp_boot_cpus(unsigne
 		io_apic_irqs = 0;
 		cpu_online_map = cpumask_of_cpu(0);
 		cpu_set(0, cpu_sibling_map[0]);
+		cpu_set(0, cpu_core_map[0]);
 		phys_cpu_present_map = physid_mask_of_physid(0);
 		disable_apic = 1;
 		goto smp_done;
@@ -756,6 +762,7 @@ static void __init smp_boot_cpus(unsigne
 		io_apic_irqs = 0;
 		cpu_online_map = cpumask_of_cpu(0);
 		cpu_set(0, cpu_sibling_map[0]);
+		cpu_set(0, cpu_core_map[0]);
 		phys_cpu_present_map = physid_mask_of_physid(0);
 		disable_apic = 1;
 		goto smp_done;
@@ -833,10 +840,13 @@ static void __init smp_boot_cpus(unsigne
 	 * Construct cpu_sibling_map[], so that we can tell the
 	 * sibling CPU efficiently.
 	 */
-	for (cpu = 0; cpu < NR_CPUS; cpu++)
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		cpus_clear(cpu_sibling_map[cpu]);
+		cpus_clear(cpu_core_map[cpu]);
+	}
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+  		struct cpuinfo_x86 *c = cpu_data + cpu;
 		int siblings = 0;
 		int i;
 		if (!cpu_isset(cpu, cpu_callout_map))
@@ -846,7 +856,7 @@ static void __init smp_boot_cpus(unsigne
 			for (i = 0; i < NR_CPUS; i++) {
 				if (!cpu_isset(i, cpu_callout_map))
 					continue;
-				if (phys_proc_id[cpu] == phys_proc_id[i]) {
+				if (phys_proc_id[cpu] == cpu_core_id[i]) {
 					siblings++;
 					cpu_set(i, cpu_sibling_map[cpu]);
 				}
@@ -862,6 +872,16 @@ static void __init smp_boot_cpus(unsigne
 			       siblings, cpu, smp_num_siblings);
 			smp_num_siblings = siblings;
 		}       
+ 		if (c->x86_num_cores > 1) {
+			for (i = 0; i < NR_CPUS; i++) {
+				if (!cpu_isset(i, cpu_callout_map))
+					continue;
+ 				if (phys_proc_id[cpu] == phys_proc_id[i]) {
+ 					cpu_set(i, cpu_core_map[cpu]);
+ 				}
+ 			}
+ 		} else
+ 			cpu_core_map[cpu] = cpu_sibling_map[cpu];
 	}
 
 	Dprintk("Boot done.\n");
diff -puN include/asm-i386/processor.h~x86_64-adds-support-for-intel-dual-core-detection-and-displaying include/asm-i386/processor.h
--- 25/include/asm-i386/processor.h~x86_64-adds-support-for-intel-dual-core-detection-and-displaying	2005-04-12 03:21:26.176157520 -0700
+++ 25-akpm/include/asm-i386/processor.h	2005-04-12 03:21:26.190155392 -0700
@@ -98,6 +98,7 @@ extern struct cpuinfo_x86 cpu_data[];
 #endif
 
 extern	int phys_proc_id[NR_CPUS];
+extern	int cpu_core_id[NR_CPUS];
 extern char ignore_fpu_irq;
 
 extern void identify_cpu(struct cpuinfo_x86 *);
diff -puN include/asm-i386/smp.h~x86_64-adds-support-for-intel-dual-core-detection-and-displaying include/asm-i386/smp.h
--- 25/include/asm-i386/smp.h~x86_64-adds-support-for-intel-dual-core-detection-and-displaying	2005-04-12 03:21:26.178157216 -0700
+++ 25-akpm/include/asm-i386/smp.h	2005-04-12 03:21:26.190155392 -0700
@@ -35,6 +35,7 @@ extern void smp_alloc_memory(void);
 extern int pic_mode;
 extern int smp_num_siblings;
 extern cpumask_t cpu_sibling_map[];
+extern cpumask_t cpu_core_map[];
 
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
diff -puN include/asm-x86_64/smp.h~x86_64-adds-support-for-intel-dual-core-detection-and-displaying include/asm-x86_64/smp.h
--- 25/include/asm-x86_64/smp.h~x86_64-adds-support-for-intel-dual-core-detection-and-displaying	2005-04-12 03:21:26.179157064 -0700
+++ 25-akpm/include/asm-x86_64/smp.h	2005-04-12 03:21:26.190155392 -0700
@@ -48,7 +48,9 @@ extern void (*mtrr_hook) (void);
 extern void zap_low_mappings(void);
 void smp_stop_cpu(void);
 extern cpumask_t cpu_sibling_map[NR_CPUS];
+extern cpumask_t cpu_core_map[NR_CPUS];
 extern u8 phys_proc_id[NR_CPUS];
+extern u8 cpu_core_id[NR_CPUS];
 
 #define SMP_TRAMPOLINE_BASE 0x6000
 
_
