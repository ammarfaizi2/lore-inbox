Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbVJHAw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbVJHAw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 20:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbVJHAw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 20:52:56 -0400
Received: from fmr22.intel.com ([143.183.121.14]:39083 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1161021AbVJHAwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 20:52:55 -0400
Date: Fri, 7 Oct 2005 17:52:40 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, akpm@osdl.org
Subject: Re: [discuss] Re: [Patch] x86, x86_64: Intel HT, Multi core detection code cleanup
Message-ID: <20051007175240.A2354@unix-os.sc.intel.com>
References: <20051005161706.B30098@unix-os.sc.intel.com> <200510061242.26563.ak@suse.de> <20051006192052.B21395@unix-os.sc.intel.com> <20051007095200.GL6642@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051007095200.GL6642@verdi.suse.de>; from ak@suse.de on Fri, Oct 07, 2005 at 11:52:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 11:52:00AM +0200, Andi Kleen wrote:
> > I can fix the API mess. Is there anything else you want me to do?
> 
> I think you overdid the sharing. Can you limit it to one file
> and copy the stuff that doesn't fit easily? 

Andi, This stuff is very much common to x86 and x86_64. Shared code is split
into two files because setting up sibling map code is generic and HT/core
detection code is very specific to Intel.

How about the appended patch?

thanks,
suresh
--

This patch cleans up the Intel HT and Multi Core detection code in x86
and x86_64. These are the areas that this patch touches.

a) Cleanup and merge HT and Mutli Core detection code for x86 and x86_64

b) Fields obtained through cpuid vector 0x1(ebx[16:23]) and
vector 0x4(eax[14:25], eax[26:31]) indicate the maximum values and might not
always be the same as what is available and what OS sees.  So make sure
"siblings" and "cpu cores" values in /proc/cpuinfo reflect the values as seen
by OS instead of what cpuid instruction says. This will also fix the buggy BIOS
cases (for example where cpuid says there are "2" siblings, even when HT is
disabled in the BIOS. http://bugzilla.kernel.org/show_bug.cgi?id=4359)

c) Fix the cache detection code assumption that number of threads sharing the
cache will either be equal to number of HT or core siblings.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

diff -pNru linux-2.6.14-rc3/arch/i386/kernel/Makefile linux/arch/i386/kernel/Makefile
--- linux-2.6.14-rc3/arch/i386/kernel/Makefile	2005-09-30 14:17:35.000000000 -0700
+++ linux/arch/i386/kernel/Makefile	2005-10-07 16:27:37.706580584 -0700
@@ -18,7 +18,7 @@ obj-$(CONFIG_X86_MSR)		+= msr.o
 obj-$(CONFIG_X86_CPUID)		+= cpuid.o
 obj-$(CONFIG_MICROCODE)		+= microcode.o
 obj-$(CONFIG_APM)		+= apm.o
-obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o
+obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o sibling-map.o
 obj-$(CONFIG_X86_TRAMPOLINE)	+= trampoline.o
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
diff -pNru linux-2.6.14-rc3/arch/i386/kernel/cpu/Makefile linux/arch/i386/kernel/cpu/Makefile
--- linux-2.6.14-rc3/arch/i386/kernel/cpu/Makefile	2005-09-30 14:17:35.000000000 -0700
+++ linux/arch/i386/kernel/cpu/Makefile	2005-10-07 16:27:37.706580584 -0700
@@ -8,7 +8,7 @@ obj-y	+=	amd.o
 obj-y	+=	cyrix.o
 obj-y	+=	centaur.o
 obj-y	+=	transmeta.o
-obj-y	+=	intel.o intel_cacheinfo.o
+obj-y	+=	intel.o intel_cacheinfo.o intel_htmc.o
 obj-y	+=	rise.o
 obj-y	+=	nexgen.o
 obj-y	+=	umc.o
diff -pNru linux-2.6.14-rc3/arch/i386/kernel/cpu/common.c linux/arch/i386/kernel/cpu/common.c
--- linux-2.6.14-rc3/arch/i386/kernel/cpu/common.c	2005-09-30 14:17:35.000000000 -0700
+++ linux/arch/i386/kernel/cpu/common.c	2005-10-07 16:27:37.707580432 -0700
@@ -442,61 +442,6 @@ void __devinit identify_cpu(struct cpuin
 		mtrr_ap_init();
 }
 
-#ifdef CONFIG_X86_HT
-void __devinit detect_ht(struct cpuinfo_x86 *c)
-{
-	u32 	eax, ebx, ecx, edx;
-	int 	index_msb, tmp;
-	int 	cpu = smp_processor_id();
-
-	if (!cpu_has(c, X86_FEATURE_HT) || cpu_has(c, X86_FEATURE_CMP_LEGACY))
-		return;
-
-	cpuid(1, &eax, &ebx, &ecx, &edx);
-	smp_num_siblings = (ebx & 0xff0000) >> 16;
-
-	if (smp_num_siblings == 1) {
-		printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
-	} else if (smp_num_siblings > 1 ) {
-		index_msb = 31;
-
-		if (smp_num_siblings > NR_CPUS) {
-			printk(KERN_WARNING "CPU: Unsupported number of the siblings %d", smp_num_siblings);
-			smp_num_siblings = 1;
-			return;
-		}
-		tmp = smp_num_siblings;
-		while ((tmp & 0x80000000 ) == 0) {
-			tmp <<=1 ;
-			index_msb--;
-		}
-		if (smp_num_siblings & (smp_num_siblings - 1))
-			index_msb++;
-		phys_proc_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb);
-
-		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
-		       phys_proc_id[cpu]);
-
-		smp_num_siblings = smp_num_siblings / c->x86_num_cores;
-
-		tmp = smp_num_siblings;
-		index_msb = 31;
-		while ((tmp & 0x80000000) == 0) {
-			tmp <<=1 ;
-			index_msb--;
-		}
-
-		if (smp_num_siblings & (smp_num_siblings - 1))
-			index_msb++;
-
-		cpu_core_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb);
-
-		if (c->x86_num_cores > 1)
-			printk(KERN_INFO  "CPU: Processor Core ID: %d\n",
-			       cpu_core_id[cpu]);
-	}
-}
-#endif
 
 void __devinit print_cpu_info(struct cpuinfo_x86 *c)
 {
diff -pNru linux-2.6.14-rc3/arch/i386/kernel/cpu/intel.c linux/arch/i386/kernel/cpu/intel.c
--- linux-2.6.14-rc3/arch/i386/kernel/cpu/intel.c	2005-09-30 14:17:35.000000000 -0700
+++ linux/arch/i386/kernel/cpu/intel.c	2005-10-07 16:27:37.707580432 -0700
@@ -76,25 +76,6 @@ static void __devinit Intel_errata_worka
 	}
 }
 
-
-/*
- * find out the number of processor cores on the die
- */
-static int __devinit num_cpu_cores(struct cpuinfo_x86 *c)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	if (c->cpuid_level < 4)
-		return 1;
-
-	/* Intel has a non-standard dependency on %ecx for this CPUID level. */
-	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
-	if (eax & 0x1f)
-		return ((eax >> 26) + 1);
-	else
-		return 1;
-}
-
 static void __devinit init_intel(struct cpuinfo_x86 *c)
 {
 	unsigned int l2 = 0;
@@ -157,7 +138,7 @@ static void __devinit init_intel(struct 
 	if ( p )
 		strcpy(c->x86_model_id, p);
 	
-	c->x86_num_cores = num_cpu_cores(c);
+	c->x86_num_cores = intel_num_cpu_cores(c);
 
 	detect_ht(c);
 
diff -pNru linux-2.6.14-rc3/arch/i386/kernel/cpu/intel_cacheinfo.c linux/arch/i386/kernel/cpu/intel_cacheinfo.c
--- linux-2.6.14-rc3/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-09-30 14:17:35.000000000 -0700
+++ linux/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-10-07 16:27:37.708580280 -0700
@@ -303,29 +303,45 @@ static struct _cpuid4_info *cpuid4_info[
 #ifdef CONFIG_SMP
 static void __devinit cache_shared_cpu_map_setup(unsigned int cpu, int index)
 {
-	struct _cpuid4_info	*this_leaf;
+	struct _cpuid4_info	*this_leaf, *sibling_leaf;
 	unsigned long num_threads_sharing;
-#ifdef CONFIG_X86_HT
-	struct cpuinfo_x86 *c = cpu_data + cpu;
-#endif
+	int index_msb, i;
+	struct cpuinfo_x86 *c = cpu_data;
 
 	this_leaf = CPUID4_INFO_IDX(cpu, index);
 	num_threads_sharing = 1 + this_leaf->eax.split.num_threads_sharing;
 
 	if (num_threads_sharing == 1)
 		cpu_set(cpu, this_leaf->shared_cpu_map);
-#ifdef CONFIG_X86_HT
-	else if (num_threads_sharing == smp_num_siblings)
-		this_leaf->shared_cpu_map = cpu_sibling_map[cpu];
-	else if (num_threads_sharing == (c->x86_num_cores * smp_num_siblings))
-		this_leaf->shared_cpu_map = cpu_core_map[cpu];
-	else
-		printk(KERN_DEBUG "Number of CPUs sharing cache didn't match "
-				"any known set of CPUs\n");
-#endif
+	else {
+		index_msb = get_count_order(num_threads_sharing);
+
+		for_each_online_cpu(i) {
+			if (c[i].apicid >> index_msb ==
+			    c[cpu].apicid >> index_msb) {
+				cpu_set(i, this_leaf->shared_cpu_map);
+				if (i != cpu && cpuid4_info[i])  {
+					sibling_leaf = CPUID4_INFO_IDX(i, index);
+					cpu_set(cpu, sibling_leaf->shared_cpu_map);
+				}
+			}
+		}
+	}
+}
+static void __devinit cache_remove_shared_cpu_map(unsigned int cpu, int index)
+{
+	struct _cpuid4_info	*this_leaf, *sibling_leaf;
+	int sibling;
+
+	this_leaf = CPUID4_INFO_IDX(cpu, index);
+	for_each_cpu_mask(sibling, this_leaf->shared_cpu_map) {
+		sibling_leaf = CPUID4_INFO_IDX(sibling, index);	
+		cpu_clear(cpu, sibling_leaf->shared_cpu_map);
+	}
 }
 #else
 static void __init cache_shared_cpu_map_setup(unsigned int cpu, int index) {}
+static void __init cache_remove_shared_cpu_map(unsigned int cpu, int index) {}
 #endif
 
 static void free_cache_attributes(unsigned int cpu)
@@ -584,8 +600,10 @@ static int __devexit cache_remove_dev(st
 	unsigned int cpu = sys_dev->id;
 	unsigned long i;
 
-	for (i = 0; i < num_cache_leaves; i++)
+	for (i = 0; i < num_cache_leaves; i++) {
+		cache_remove_shared_cpu_map(cpu, i);
 		kobject_unregister(&(INDEX_KOBJECT_PTR(cpu,i)->kobj));
+	}
 	kobject_unregister(cache_kobject[cpu]);
 	cpuid4_cache_sysfs_exit(cpu);
 	return 0;
diff -pNru linux-2.6.14-rc3/arch/i386/kernel/cpu/intel_htmc.c linux/arch/i386/kernel/cpu/intel_htmc.c
--- linux-2.6.14-rc3/arch/i386/kernel/cpu/intel_htmc.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/arch/i386/kernel/cpu/intel_htmc.c	2005-10-07 16:27:37.708580280 -0700
@@ -0,0 +1,81 @@
+/*
+ *	Copyright (C) 2005 Intel Corp
+ *	Intel Multi Core and Hyper-Threading detection routines
+ *	
+ *	Changes:
+ *	Suresh Siddha		: Merge x86 and x86_64 code with some fixes.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+
+#include <linux/smp.h>
+#include <asm/processor.h>
+
+
+/*
+ * find out the number of processor cores on the die
+ */
+int __cpuinit intel_num_cpu_cores(struct cpuinfo_x86 *c)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	if (c->cpuid_level < 4)
+		return 1;
+
+	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
+
+	if (eax & 0x1f)
+		return ((eax >> 26) + 1);
+	else
+		return 1;
+}
+
+#ifdef CONFIG_X86_HT
+#include <asm/mach_apic.h>
+
+void __cpuinit detect_ht(struct cpuinfo_x86 *c)
+{
+	u32 	eax, ebx, ecx, edx;
+	int 	index_msb, core_bits;
+	int 	cpu = smp_processor_id();
+
+	cpuid(1, &eax, &ebx, &ecx, &edx);
+
+	c->apicid = phys_pkg_id((ebx >> 24) & 0xFF, 0);
+
+	if (!cpu_has(c, X86_FEATURE_HT) || cpu_has(c, X86_FEATURE_CMP_LEGACY))
+		return;
+
+	smp_num_siblings = (ebx & 0xff0000) >> 16;
+
+	if (smp_num_siblings == 1) {
+		printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
+	} else if (smp_num_siblings > 1 ) {
+
+		if (smp_num_siblings > NR_CPUS) {
+			printk(KERN_WARNING "CPU: Unsupported number of the siblings %d", smp_num_siblings);
+			smp_num_siblings = 1;
+			return;
+		}
+
+		index_msb = get_count_order(smp_num_siblings);
+		phys_proc_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb);
+
+		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
+		       phys_proc_id[cpu]);
+
+		smp_num_siblings = smp_num_siblings / c->x86_num_cores;
+
+		index_msb = get_count_order(smp_num_siblings) ;
+
+		core_bits = get_count_order(c->x86_num_cores);
+
+		cpu_core_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb) &
+					       ((1 << core_bits) - 1);
+
+		if (c->x86_num_cores > 1)
+			printk(KERN_INFO  "CPU: Processor Core ID: %d\n",
+			       cpu_core_id[cpu]);
+	}
+}
+#endif
diff -pNru linux-2.6.14-rc3/arch/i386/kernel/cpu/proc.c linux/arch/i386/kernel/cpu/proc.c
--- linux-2.6.14-rc3/arch/i386/kernel/cpu/proc.c	2005-09-30 14:17:35.000000000 -0700
+++ linux/arch/i386/kernel/cpu/proc.c	2005-10-07 16:27:37.709580128 -0700
@@ -97,9 +97,9 @@ static int show_cpuinfo(struct seq_file 
 	if (c->x86_num_cores * smp_num_siblings > 1) {
 		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
 		seq_printf(m, "siblings\t: %d\n",
-				c->x86_num_cores * smp_num_siblings);
+				cpus_weight(cpu_core_map[n]));
 		seq_printf(m, "core id\t\t: %d\n", cpu_core_id[n]);
-		seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
+		seq_printf(m, "cpu cores\t: %d\n", c->booted_cores);
 	}
 #endif
 	
diff -pNru linux-2.6.14-rc3/arch/i386/kernel/sibling-map.c linux/arch/i386/kernel/sibling-map.c
--- linux-2.6.14-rc3/arch/i386/kernel/sibling-map.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/arch/i386/kernel/sibling-map.c	2005-10-07 16:27:37.709580128 -0700
@@ -0,0 +1,93 @@
+/*
+ *	Copyright (C) 2005 Intel Corp
+ * 	Setup and Removal of various sibling maps
+ *
+ *	Changes:
+ *	Suresh Siddha 		: Merge x86 and x86_64 code with some fixes
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+
+#include <linux/smp.h>
+
+static cpumask_t cpu_sibling_setup_map;
+
+#ifdef CONFIG_HOTPLUG_CPU
+void
+remove_siblinginfo(int cpu)
+{
+	int sibling;
+	struct cpuinfo_x86 *c = cpu_data;
+
+	for_each_cpu_mask(sibling, cpu_core_map[cpu]) {
+		cpu_clear(cpu, cpu_core_map[sibling]);
+		/*
+		 * last thread sibling in this cpu core going down
+		 */
+		if (cpus_weight(cpu_sibling_map[cpu]) == 1)
+			c[sibling].booted_cores--;
+	}
+			
+	for_each_cpu_mask(sibling, cpu_sibling_map[cpu])
+		cpu_clear(cpu, cpu_sibling_map[sibling]);
+	cpus_clear(cpu_sibling_map[cpu]);
+	cpus_clear(cpu_core_map[cpu]);
+	phys_proc_id[cpu] = BAD_APICID;
+	cpu_core_id[cpu] = BAD_APICID;
+	cpu_clear(cpu, cpu_sibling_setup_map);
+}
+#endif
+
+void __cpuinit
+set_cpu_sibling_map(int cpu)
+{
+	int i;
+	struct cpuinfo_x86 *c = cpu_data;
+
+	cpu_set(cpu, cpu_sibling_setup_map);
+
+	if (smp_num_siblings > 1) {
+		for_each_cpu_mask(i, cpu_sibling_setup_map) {
+			if (phys_proc_id[cpu] == phys_proc_id[i] &&
+			    cpu_core_id[cpu] == cpu_core_id[i]) {
+				cpu_set(i, cpu_sibling_map[cpu]);
+				cpu_set(cpu, cpu_sibling_map[i]);
+				cpu_set(i, cpu_core_map[cpu]);
+				cpu_set(cpu, cpu_core_map[i]);
+			}
+		}
+	} else {
+		cpu_set(cpu, cpu_sibling_map[cpu]);
+	}
+
+	if (current_cpu_data.x86_num_cores == 1) {
+		cpu_core_map[cpu] = cpu_sibling_map[cpu];
+		c[cpu].booted_cores = 1;
+		return;
+	}
+
+	for_each_cpu_mask(i, cpu_sibling_setup_map) {
+		if (phys_proc_id[cpu] == phys_proc_id[i]) {
+			cpu_set(i, cpu_core_map[cpu]);
+			cpu_set(cpu, cpu_core_map[i]);
+			/*
+			 *  Does this new cpu bringup a new core?
+			 */
+			if (cpus_weight(cpu_sibling_map[cpu]) == 1) {
+				/*
+				 * for each core in package, increment
+				 * the booted_cores for this new cpu
+				 */
+				if (first_cpu(cpu_sibling_map[i]) == i)
+					c[cpu].booted_cores++;
+				/*
+				 * increment the core count for all
+				 * the other cpus in this package
+				 */
+				if (i != cpu)
+					c[i].booted_cores++;
+			} else if (i != cpu && !c[cpu].booted_cores)
+				c[cpu].booted_cores = c[i].booted_cores;
+		}
+	}
+}
diff -pNru linux-2.6.14-rc3/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux-2.6.14-rc3/arch/i386/kernel/smpboot.c	2005-09-30 14:17:35.000000000 -0700
+++ linux/arch/i386/kernel/smpboot.c	2005-10-07 16:27:37.710579976 -0700
@@ -440,38 +440,6 @@ static void __devinit smp_callin(void)
 
 static int cpucount;
 
-static inline void
-set_cpu_sibling_map(int cpu)
-{
-	int i;
-
-	if (smp_num_siblings > 1) {
-		for (i = 0; i < NR_CPUS; i++) {
-			if (!cpu_isset(i, cpu_callout_map))
-				continue;
-			if (cpu_core_id[cpu] == cpu_core_id[i]) {
-				cpu_set(i, cpu_sibling_map[cpu]);
-				cpu_set(cpu, cpu_sibling_map[i]);
-			}
-		}
-	} else {
-		cpu_set(cpu, cpu_sibling_map[cpu]);
-	}
-
-	if (current_cpu_data.x86_num_cores > 1) {
-		for (i = 0; i < NR_CPUS; i++) {
-			if (!cpu_isset(i, cpu_callout_map))
-				continue;
-			if (phys_proc_id[cpu] == phys_proc_id[i]) {
-				cpu_set(i, cpu_core_map[cpu]);
-				cpu_set(cpu, cpu_core_map[i]);
-			}
-		}
-	} else {
-		cpu_core_map[cpu] = cpu_sibling_map[cpu];
-	}
-}
-
 /*
  * Activate a secondary processor.
  */
@@ -1092,11 +1060,7 @@ static void __init smp_boot_cpus(unsigne
 
 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
-	cpus_clear(cpu_sibling_map[0]);
-	cpu_set(0, cpu_sibling_map[0]);
-
-	cpus_clear(cpu_core_map[0]);
-	cpu_set(0, cpu_core_map[0]);
+	set_cpu_sibling_map(raw_smp_processor_id());
 
 	/*
 	 * If we couldn't find an SMP configuration at boot time,
@@ -1271,21 +1235,6 @@ void __devinit smp_prepare_boot_cpu(void
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void
-remove_siblinginfo(int cpu)
-{
-	int sibling;
-
-	for_each_cpu_mask(sibling, cpu_sibling_map[cpu])
-		cpu_clear(cpu, cpu_sibling_map[sibling]);
-	for_each_cpu_mask(sibling, cpu_core_map[cpu])
-		cpu_clear(cpu, cpu_core_map[sibling]);
-	cpus_clear(cpu_sibling_map[cpu]);
-	cpus_clear(cpu_core_map[cpu]);
-	phys_proc_id[cpu] = BAD_APICID;
-	cpu_core_id[cpu] = BAD_APICID;
-}
-
 int __cpu_disable(void)
 {
 	cpumask_t map = cpu_online_map;
diff -pNru linux-2.6.14-rc3/arch/x86_64/kernel/Makefile linux/arch/x86_64/kernel/Makefile
--- linux-2.6.14-rc3/arch/x86_64/kernel/Makefile	2005-09-30 14:17:35.000000000 -0700
+++ linux/arch/x86_64/kernel/Makefile	2005-10-07 16:27:37.710579976 -0700
@@ -16,7 +16,7 @@ obj-$(CONFIG_ACPI)		+= acpi/
 obj-$(CONFIG_X86_MSR)		+= msr.o
 obj-$(CONFIG_MICROCODE)		+= microcode.o
 obj-$(CONFIG_X86_CPUID)		+= cpuid.o
-obj-$(CONFIG_SMP)		+= smp.o smpboot.o trampoline.o
+obj-$(CONFIG_SMP)		+= smp.o smpboot.o trampoline.o sibling-map.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o  nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o \
 		genapic.o genapic_cluster.o genapic_flat.o
@@ -34,7 +34,7 @@ obj-$(CONFIG_X86_PM_TIMER)	+= pmtimer.o
 obj-$(CONFIG_MODULES)		+= module.o
 
 obj-y				+= topology.o
-obj-y				+= intel_cacheinfo.o
+obj-y				+= intel_cacheinfo.o intel_htmc.o
 
 CFLAGS_vsyscall.o		:= $(PROFILING) -g0
 
@@ -47,3 +47,5 @@ intel_cacheinfo-y		+= ../../i386/kernel/
 quirks-y			+= ../../i386/kernel/quirks.o
 i8237-y				+= ../../i386/kernel/i8237.o
 msr-$(subst m,y,$(CONFIG_X86_MSR))  += ../../i386/kernel/msr.o
+sibling-map-y			+= ../../i386/kernel/sibling-map.o
+intel_htmc-y			+= ../../i386/kernel/cpu/intel_htmc.o
diff -pNru linux-2.6.14-rc3/arch/x86_64/kernel/genapic_cluster.c linux/arch/x86_64/kernel/genapic_cluster.c
--- linux-2.6.14-rc3/arch/x86_64/kernel/genapic_cluster.c	2005-09-30 14:17:35.000000000 -0700
+++ linux/arch/x86_64/kernel/genapic_cluster.c	2005-10-07 16:29:23.157549600 -0700
@@ -113,7 +113,7 @@ static unsigned int cluster_cpu_mask_to_
  *
  * See Intel's IA-32 SW Dev's Manual Vol2 under CPUID.
  */
-static unsigned int phys_pkg_id(int index_msb)
+static unsigned int phys_pkg_id(u32 cpu_apicid, int index_msb)
 {
 	return hard_smp_processor_id() >> index_msb;
 }
diff -pNru linux-2.6.14-rc3/arch/x86_64/kernel/genapic_flat.c linux/arch/x86_64/kernel/genapic_flat.c
--- linux-2.6.14-rc3/arch/x86_64/kernel/genapic_flat.c	2005-09-30 14:17:35.000000000 -0700
+++ linux/arch/x86_64/kernel/genapic_flat.c	2005-10-07 16:29:42.509607640 -0700
@@ -107,12 +107,9 @@ static unsigned int flat_cpu_mask_to_api
 	return cpus_addr(cpumask)[0] & APIC_ALL_CPUS;
 }
 
-static unsigned int phys_pkg_id(int index_msb)
+static unsigned int phys_pkg_id(u32 cpu_apicid, int index_msb)
 {
-	u32 ebx;
-
-	ebx = cpuid_ebx(1);
-	return ((ebx >> 24) & 0xFF) >> index_msb;
+	return cpu_apicid >> index_msb;
 }
 
 struct genapic apic_flat =  {
diff -pNru linux-2.6.14-rc3/arch/x86_64/kernel/setup.c linux/arch/x86_64/kernel/setup.c
--- linux-2.6.14-rc3/arch/x86_64/kernel/setup.c	2005-09-30 14:17:35.000000000 -0700
+++ linux/arch/x86_64/kernel/setup.c	2005-10-07 16:27:37.711579824 -0700
@@ -885,85 +885,6 @@ static int __init init_amd(struct cpuinf
 	return r;
 }
 
-static void __cpuinit detect_ht(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	u32 	eax, ebx, ecx, edx;
-	int 	index_msb, tmp;
-	int 	cpu = smp_processor_id();
-	
-	if (!cpu_has(c, X86_FEATURE_HT) || cpu_has(c, X86_FEATURE_CMP_LEGACY))
-		return;
-
-	cpuid(1, &eax, &ebx, &ecx, &edx);
-	smp_num_siblings = (ebx & 0xff0000) >> 16;
-	
-	if (smp_num_siblings == 1) {
-		printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
-	} else if (smp_num_siblings > 1) {
-		index_msb = 31;
-		/*
-		 * At this point we only support two siblings per
-		 * processor package.
-		 */
-		if (smp_num_siblings > NR_CPUS) {
-			printk(KERN_WARNING "CPU: Unsupported number of the siblings %d", smp_num_siblings);
-			smp_num_siblings = 1;
-			return;
-		}
-		tmp = smp_num_siblings;
-		while ((tmp & 0x80000000 ) == 0) {
-			tmp <<=1 ;
-			index_msb--;
-		}
-		if (smp_num_siblings & (smp_num_siblings - 1))
-			index_msb++;
-		phys_proc_id[cpu] = phys_pkg_id(index_msb);
-		
-		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
-		       phys_proc_id[cpu]);
-
-		smp_num_siblings = smp_num_siblings / c->x86_num_cores;
-
-		tmp = smp_num_siblings;
-		index_msb = 31;
-		while ((tmp & 0x80000000) == 0) {
-			tmp <<=1 ;
-			index_msb--;
-		}
-		if (smp_num_siblings & (smp_num_siblings - 1))
-			index_msb++;
-
-		cpu_core_id[cpu] = phys_pkg_id(index_msb);
-
-		if (c->x86_num_cores > 1)
-			printk(KERN_INFO  "CPU: Processor Core ID: %d\n",
-			       cpu_core_id[cpu]);
-	}
-#endif
-}
-
-/*
- * find out the number of processor cores on the die
- */
-static int __cpuinit intel_num_cpu_cores(struct cpuinfo_x86 *c)
-{
-	unsigned int eax;
-
-	if (c->cpuid_level < 4)
-		return 1;
-
-	__asm__("cpuid"
-		: "=a" (eax)
-		: "0" (4), "c" (0)
-		: "bx", "dx");
-
-	if (eax & 0x1f)
-		return ((eax >> 26) + 1);
-	else
-		return 1;
-}
-
 static void srat_detect_node(void)
 {
 #ifdef CONFIG_NUMA
@@ -1276,9 +1197,9 @@ static int show_cpuinfo(struct seq_file 
 		int cpu = c - cpu_data;
 		seq_printf(m, "physical id\t: %d\n", phys_proc_id[cpu]);
 		seq_printf(m, "siblings\t: %d\n",
-				c->x86_num_cores * smp_num_siblings);
+				cpus_weight(cpu_core_map[cpu]));
 		seq_printf(m, "core id\t\t: %d\n", cpu_core_id[cpu]);
-		seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
+		seq_printf(m, "cpu cores\t: %d\n", c->booted_cores);
 	}
 #endif	
 
diff -pNru linux-2.6.14-rc3/arch/x86_64/kernel/smpboot.c linux/arch/x86_64/kernel/smpboot.c
--- linux-2.6.14-rc3/arch/x86_64/kernel/smpboot.c	2005-09-30 14:17:35.000000000 -0700
+++ linux/arch/x86_64/kernel/smpboot.c	2005-10-07 16:27:37.712579672 -0700
@@ -436,33 +436,6 @@ void __cpuinit smp_callin(void)
 	cpu_set(cpuid, cpu_callin_map);
 }
 
-static inline void set_cpu_sibling_map(int cpu)
-{
-	int i;
-
-	if (smp_num_siblings > 1) {
-		for_each_cpu(i) {
-			if (cpu_core_id[cpu] == cpu_core_id[i]) {
-				cpu_set(i, cpu_sibling_map[cpu]);
-				cpu_set(cpu, cpu_sibling_map[i]);
-			}
-		}
-	} else {
-		cpu_set(cpu, cpu_sibling_map[cpu]);
-	}
-
-	if (current_cpu_data.x86_num_cores > 1) {
-		for_each_cpu(i) {
-			if (phys_proc_id[cpu] == phys_proc_id[i]) {
-				cpu_set(i, cpu_core_map[cpu]);
-				cpu_set(cpu, cpu_core_map[i]);
-			}
-		}
-	} else {
-		cpu_core_map[cpu] = cpu_sibling_map[cpu];
-	}
-}
-
 /*
  * Setup code on secondary processor (after comming out of the trampoline)
  */
@@ -966,6 +939,7 @@ void __init smp_prepare_cpus(unsigned in
 	nmi_watchdog_default();
 	current_cpu_data = boot_cpu_data;
 	current_thread_info()->cpu = 0;  /* needed? */
+	set_cpu_sibling_map(0);
 
 #ifdef CONFIG_HOTPLUG_CPU
 	prefill_possible_map();
@@ -1013,8 +987,7 @@ void __init smp_prepare_boot_cpu(void)
 	int me = smp_processor_id();
 	cpu_set(me, cpu_online_map);
 	cpu_set(me, cpu_callout_map);
-	cpu_set(0, cpu_sibling_map[0]);
-	cpu_set(0, cpu_core_map[0]);
+
 	per_cpu(cpu_state, me) = CPU_ONLINE;
 }
 
@@ -1083,20 +1056,6 @@ void __init smp_cpus_done(unsigned int m
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-static void remove_siblinginfo(int cpu)
-{
-	int sibling;
-
-	for_each_cpu_mask(sibling, cpu_sibling_map[cpu])
-		cpu_clear(cpu, cpu_sibling_map[sibling]);
-	for_each_cpu_mask(sibling, cpu_core_map[cpu])
-		cpu_clear(cpu, cpu_core_map[sibling]);
-	cpus_clear(cpu_sibling_map[cpu]);
-	cpus_clear(cpu_core_map[cpu]);
-	phys_proc_id[cpu] = BAD_APICID;
-	cpu_core_id[cpu] = BAD_APICID;
-}
-
 void remove_cpu_from_maps(void)
 {
 	int cpu = smp_processor_id();
diff -pNru linux-2.6.14-rc3/include/asm-i386/mach_apic.h linux/include/asm-i386/mach_apic.h
--- linux-2.6.14-rc3/include/asm-i386/mach_apic.h	1969-12-31 16:00:00.000000000 -0800
+++ linux/include/asm-i386/mach_apic.h	2005-10-07 16:27:37.712579672 -0700
@@ -0,0 +1,5 @@
+/* Magic for including machine specific mach_apic.h from C files,
+ * so that shared code between i386 and x86_64 can simply include 
+ * <asm/mach_apic.h> without complicated ifdefs
+ */
+#include <mach_apic.h>
diff -pNru linux-2.6.14-rc3/include/asm-i386/processor.h linux/include/asm-i386/processor.h
--- linux-2.6.14-rc3/include/asm-i386/processor.h	2005-09-30 14:17:35.000000000 -0700
+++ linux/include/asm-i386/processor.h	2005-10-07 16:27:37.713579520 -0700
@@ -66,6 +66,8 @@ struct cpuinfo_x86 {
 	int	coma_bug;
 	unsigned long loops_per_jiffy;
 	unsigned char x86_num_cores;
+	unsigned char booted_cores;
+	unsigned char apicid;
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
 
 #define X86_VENDOR_INTEL 0
@@ -104,6 +106,7 @@ extern char ignore_fpu_irq;
 extern void identify_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
+extern int intel_num_cpu_cores(struct cpuinfo_x86 *c);
 
 #ifdef CONFIG_X86_HT
 extern void detect_ht(struct cpuinfo_x86 *c);
diff -pNru linux-2.6.14-rc3/include/asm-i386/smp.h linux/include/asm-i386/smp.h
--- linux-2.6.14-rc3/include/asm-i386/smp.h	2005-09-30 14:17:35.000000000 -0700
+++ linux/include/asm-i386/smp.h	2005-10-07 16:27:37.713579520 -0700
@@ -37,6 +37,9 @@ extern int smp_num_siblings;
 extern cpumask_t cpu_sibling_map[];
 extern cpumask_t cpu_core_map[];
 
+extern void set_cpu_sibling_map(int);
+extern void remove_siblinginfo(int);
+
 extern void (*mtrr_hook) (void);
 extern void zap_low_mappings (void);
 extern void lock_ipi_call_lock(void);
diff -pNru linux-2.6.14-rc3/include/asm-x86_64/genapic.h linux/include/asm-x86_64/genapic.h
--- linux-2.6.14-rc3/include/asm-x86_64/genapic.h	2005-09-30 14:17:35.000000000 -0700
+++ linux/include/asm-x86_64/genapic.h	2005-10-07 16:30:02.322595608 -0700
@@ -26,7 +26,7 @@ struct genapic {
 	void (*send_IPI_all)(int vector);
 	/* */
 	unsigned int (*cpu_mask_to_apicid)(cpumask_t cpumask);
-	unsigned int (*phys_pkg_id)(int index_msb);
+	unsigned int (*phys_pkg_id)(u32 cpu_apicid, int index_msb);
 };
 
 
diff -pNru linux-2.6.14-rc3/include/asm-x86_64/processor.h linux/include/asm-x86_64/processor.h
--- linux-2.6.14-rc3/include/asm-x86_64/processor.h	2005-09-30 14:17:35.000000000 -0700
+++ linux/include/asm-x86_64/processor.h	2005-10-07 16:27:37.713579520 -0700
@@ -65,6 +65,8 @@ struct cpuinfo_x86 {
         __u32   x86_power; 	
 	__u32   extended_cpuid_level;	/* Max extended CPUID function supported */
 	unsigned long loops_per_jiffy;
+	__u8	booted_cores;
+	__u8	apicid;
 } ____cacheline_aligned;
 
 #define X86_VENDOR_INTEL 0
@@ -91,6 +93,14 @@ extern char ignore_irq13;
 extern void identify_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
+extern int intel_num_cpu_cores(struct cpuinfo_x86 *c);
+
+#ifdef CONFIG_X86_HT
+extern void detect_ht(struct cpuinfo_x86 *c);
+#else
+static inline void detect_ht(struct cpuinfo_x86 *c) {}
+#endif
+
 
 /*
  * EFLAGS bits
diff -pNru linux-2.6.14-rc3/include/asm-x86_64/smp.h linux/include/asm-x86_64/smp.h
--- linux-2.6.14-rc3/include/asm-x86_64/smp.h	2005-09-30 14:17:35.000000000 -0700
+++ linux/include/asm-x86_64/smp.h	2005-10-07 16:27:37.714579368 -0700
@@ -57,6 +57,9 @@ extern cpumask_t cpu_core_map[NR_CPUS];
 extern u8 phys_proc_id[NR_CPUS];
 extern u8 cpu_core_id[NR_CPUS];
 
+extern void set_cpu_sibling_map(int);
+extern void remove_siblinginfo(int);
+
 #define SMP_TRAMPOLINE_BASE 0x6000
 
 /*
diff -pNru linux-2.6.14-rc3/include/linux/bitops.h linux/include/linux/bitops.h
--- linux-2.6.14-rc3/include/linux/bitops.h	2005-09-30 14:17:35.000000000 -0700
+++ linux/include/linux/bitops.h	2005-10-07 16:27:37.714579368 -0700
@@ -84,6 +84,16 @@ static __inline__ int get_bitmask_order(
 	return order;	/* We could be slightly more clever with -1 here... */
 }
 
+static __inline__ int get_count_order(unsigned int count)
+{
+	int order;
+	
+	order = fls(count) - 1;
+	if (count & (count - 1))
+		order++;
+	return order;
+}
+
 /*
  * hweightN: returns the hamming weight (i.e. the number
  * of bits set) of a N-bit word
