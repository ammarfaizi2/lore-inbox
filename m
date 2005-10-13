Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVJMVz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVJMVz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 17:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVJMVz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 17:55:59 -0400
Received: from fmr24.intel.com ([143.183.121.16]:33688 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751112AbVJMVz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 17:55:58 -0400
Date: Thu, 13 Oct 2005 14:55:46 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [discuss] [Patch 1/2] x86, x86_64: Intel HT, Multi core detection fixes
Message-ID: <20051013145546.B8988@unix-os.sc.intel.com>
References: <20051005161706.B30098@unix-os.sc.intel.com> <200510122349.05312.ak@suse.de> <20051012151926.E29292@unix-os.sc.intel.com> <200510130210.23311.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200510130210.23311.ak@suse.de>; from ak@suse.de on Thu, Oct 13, 2005 at 02:10:22AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2005 at 02:10:22AM +0200, Andi Kleen wrote:
> Ok, if you rename the variable to make it clear
> 
> x86_num_cores -> x86_max_cores

Andrew, please apply.

thanks,
suresh
--

Fields obtained through cpuid vector 0x1(ebx[16:23]) and
vector 0x4(eax[14:25], eax[26:31]) indicate the maximum values and might not
always be the same as what is available and what OS sees.  So make sure
"siblings" and "cpu cores" values in /proc/cpuinfo reflect the values as seen
by OS instead of what cpuid instruction says. This will also fix the buggy BIOS
cases (for example where cpuid on a single core cpu says there are "2" siblings,
even when HT is disabled in the BIOS. 
http://bugzilla.kernel.org/show_bug.cgi?id=4359)

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

diff -pNru linux-2.6.14-rc4/arch/i386/kernel/cpu/amd.c linux-2.6.14-rc4-dc/arch/i386/kernel/cpu/amd.c
--- linux-2.6.14-rc4/arch/i386/kernel/cpu/amd.c	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-dc/arch/i386/kernel/cpu/amd.c	2005-10-12 18:21:08.267235544 -0700
@@ -206,9 +206,9 @@ static void __init init_amd(struct cpuin
 	display_cacheinfo(c);
 
 	if (cpuid_eax(0x80000000) >= 0x80000008) {
-		c->x86_num_cores = (cpuid_ecx(0x80000008) & 0xff) + 1;
-		if (c->x86_num_cores & (c->x86_num_cores - 1))
-			c->x86_num_cores = 1;
+		c->x86_max_cores = (cpuid_ecx(0x80000008) & 0xff) + 1;
+		if (c->x86_max_cores & (c->x86_max_cores - 1))
+			c->x86_max_cores = 1;
 	}
 
 #ifdef CONFIG_X86_HT
@@ -217,15 +217,15 @@ static void __init init_amd(struct cpuin
 	 * distingush the cores.  Assumes number of cores is a power
 	 * of two.
 	 */
-	if (c->x86_num_cores > 1) {
+	if (c->x86_max_cores > 1) {
 		int cpu = smp_processor_id();
 		unsigned bits = 0;
-		while ((1 << bits) < c->x86_num_cores)
+		while ((1 << bits) < c->x86_max_cores)
 			bits++;
 		cpu_core_id[cpu] = phys_proc_id[cpu] & ((1<<bits)-1);
 		phys_proc_id[cpu] >>= bits;
 		printk(KERN_INFO "CPU %d(%d) -> Core %d\n",
-		       cpu, c->x86_num_cores, cpu_core_id[cpu]);
+		       cpu, c->x86_max_cores, cpu_core_id[cpu]);
 	}
 #endif
 }
diff -pNru linux-2.6.14-rc4/arch/i386/kernel/cpu/common.c linux-2.6.14-rc4-dc/arch/i386/kernel/cpu/common.c
--- linux-2.6.14-rc4/arch/i386/kernel/cpu/common.c	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-dc/arch/i386/kernel/cpu/common.c	2005-10-12 18:21:08.271234936 -0700
@@ -335,7 +335,7 @@ void __devinit identify_cpu(struct cpuin
 	c->x86_model = c->x86_mask = 0;	/* So far unknown... */
 	c->x86_vendor_id[0] = '\0'; /* Unset */
 	c->x86_model_id[0] = '\0';  /* Unset */
-	c->x86_num_cores = 1;
+	c->x86_max_cores = 1;
 	memset(&c->x86_capability, 0, sizeof c->x86_capability);
 
 	if (!have_cpuid_p()) {
@@ -446,52 +446,44 @@ void __devinit identify_cpu(struct cpuin
 void __devinit detect_ht(struct cpuinfo_x86 *c)
 {
 	u32 	eax, ebx, ecx, edx;
-	int 	index_msb, tmp;
+	int 	index_msb, core_bits;
 	int 	cpu = smp_processor_id();
 
+	cpuid(1, &eax, &ebx, &ecx, &edx);
+
+	c->apicid = phys_pkg_id((ebx >> 24) & 0xFF, 0);
+
 	if (!cpu_has(c, X86_FEATURE_HT) || cpu_has(c, X86_FEATURE_CMP_LEGACY))
 		return;
 
-	cpuid(1, &eax, &ebx, &ecx, &edx);
 	smp_num_siblings = (ebx & 0xff0000) >> 16;
 
 	if (smp_num_siblings == 1) {
 		printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
 	} else if (smp_num_siblings > 1 ) {
-		index_msb = 31;
 
 		if (smp_num_siblings > NR_CPUS) {
 			printk(KERN_WARNING "CPU: Unsupported number of the siblings %d", smp_num_siblings);
 			smp_num_siblings = 1;
 			return;
 		}
-		tmp = smp_num_siblings;
-		while ((tmp & 0x80000000 ) == 0) {
-			tmp <<=1 ;
-			index_msb--;
-		}
-		if (smp_num_siblings & (smp_num_siblings - 1))
-			index_msb++;
+
+		index_msb = get_count_order(smp_num_siblings);
 		phys_proc_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb);
 
 		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
 		       phys_proc_id[cpu]);
 
-		smp_num_siblings = smp_num_siblings / c->x86_num_cores;
+		smp_num_siblings = smp_num_siblings / c->x86_max_cores;
 
-		tmp = smp_num_siblings;
-		index_msb = 31;
-		while ((tmp & 0x80000000) == 0) {
-			tmp <<=1 ;
-			index_msb--;
-		}
+		index_msb = get_count_order(smp_num_siblings) ;
 
-		if (smp_num_siblings & (smp_num_siblings - 1))
-			index_msb++;
+		core_bits = get_count_order(c->x86_max_cores);
 
-		cpu_core_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb);
+		cpu_core_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb) &
+					       ((1 << core_bits) - 1);
 
-		if (c->x86_num_cores > 1)
+		if (c->x86_max_cores > 1)
 			printk(KERN_INFO  "CPU: Processor Core ID: %d\n",
 			       cpu_core_id[cpu]);
 	}
diff -pNru linux-2.6.14-rc4/arch/i386/kernel/cpu/intel.c linux-2.6.14-rc4-dc/arch/i386/kernel/cpu/intel.c
--- linux-2.6.14-rc4/arch/i386/kernel/cpu/intel.c	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-dc/arch/i386/kernel/cpu/intel.c	2005-10-12 18:21:08.273234632 -0700
@@ -157,7 +157,7 @@ static void __devinit init_intel(struct 
 	if ( p )
 		strcpy(c->x86_model_id, p);
 	
-	c->x86_num_cores = num_cpu_cores(c);
+	c->x86_max_cores = num_cpu_cores(c);
 
 	detect_ht(c);
 
diff -pNru linux-2.6.14-rc4/arch/i386/kernel/cpu/intel_cacheinfo.c linux-2.6.14-rc4-dc/arch/i386/kernel/cpu/intel_cacheinfo.c
--- linux-2.6.14-rc4/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-10-13 13:56:15.405521280 -0700
+++ linux-2.6.14-rc4-dc/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-10-13 13:56:47.645620040 -0700
@@ -317,7 +317,7 @@ static void __devinit cache_shared_cpu_m
 #ifdef CONFIG_X86_HT
 	else if (num_threads_sharing == smp_num_siblings)
 		this_leaf->shared_cpu_map = cpu_sibling_map[cpu];
-	else if (num_threads_sharing == (c->x86_num_cores * smp_num_siblings))
+	else if (num_threads_sharing == (c->x86_max_cores * smp_num_siblings))
 		this_leaf->shared_cpu_map = cpu_core_map[cpu];
 	else
 		printk(KERN_DEBUG "Number of CPUs sharing cache didn't match "
diff -pNru linux-2.6.14-rc4/arch/i386/kernel/cpu/proc.c linux-2.6.14-rc4-dc/arch/i386/kernel/cpu/proc.c
--- linux-2.6.14-rc4/arch/i386/kernel/cpu/proc.c	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-dc/arch/i386/kernel/cpu/proc.c	2005-10-12 18:21:08.289232200 -0700
@@ -94,12 +94,11 @@ static int show_cpuinfo(struct seq_file 
 	if (c->x86_cache_size >= 0)
 		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
 #ifdef CONFIG_X86_HT
-	if (c->x86_num_cores * smp_num_siblings > 1) {
+	if (c->x86_max_cores * smp_num_siblings > 1) {
 		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
-		seq_printf(m, "siblings\t: %d\n",
-				c->x86_num_cores * smp_num_siblings);
+		seq_printf(m, "siblings\t: %d\n", cpus_weight(cpu_core_map[n]));
 		seq_printf(m, "core id\t\t: %d\n", cpu_core_id[n]);
-		seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
+		seq_printf(m, "cpu cores\t: %d\n", c->booted_cores);
 	}
 #endif
 	
diff -pNru linux-2.6.14-rc4/arch/i386/kernel/smpboot.c linux-2.6.14-rc4-dc/arch/i386/kernel/smpboot.c
--- linux-2.6.14-rc4/arch/i386/kernel/smpboot.c	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-dc/arch/i386/kernel/smpboot.c	2005-10-13 13:58:26.266627368 -0700
@@ -74,9 +74,11 @@ EXPORT_SYMBOL(phys_proc_id);
 int cpu_core_id[NR_CPUS] __read_mostly = {[0 ... NR_CPUS-1] = BAD_APICID};
 EXPORT_SYMBOL(cpu_core_id);
 
+/* representing HT siblings of each logical CPU */
 cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_sibling_map);
 
+/* representing HT and core siblings of each logical CPU */
 cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_core_map);
 
@@ -440,35 +442,60 @@ static void __devinit smp_callin(void)
 
 static int cpucount;
 
+/* representing cpus for which sibling maps can be computed */
+static cpumask_t cpu_sibling_setup_map;
+
 static inline void
 set_cpu_sibling_map(int cpu)
 {
 	int i;
+	struct cpuinfo_x86 *c = cpu_data;
+
+	cpu_set(cpu, cpu_sibling_setup_map);
 
 	if (smp_num_siblings > 1) {
-		for (i = 0; i < NR_CPUS; i++) {
-			if (!cpu_isset(i, cpu_callout_map))
-				continue;
-			if (cpu_core_id[cpu] == cpu_core_id[i]) {
+		for_each_cpu_mask(i, cpu_sibling_setup_map) {
+			if (phys_proc_id[cpu] == phys_proc_id[i] &&
+			    cpu_core_id[cpu] == cpu_core_id[i]) {
 				cpu_set(i, cpu_sibling_map[cpu]);
 				cpu_set(cpu, cpu_sibling_map[i]);
+				cpu_set(i, cpu_core_map[cpu]);
+				cpu_set(cpu, cpu_core_map[i]);
 			}
 		}
 	} else {
 		cpu_set(cpu, cpu_sibling_map[cpu]);
 	}
 
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
+	if (current_cpu_data.x86_max_cores == 1) {
 		cpu_core_map[cpu] = cpu_sibling_map[cpu];
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
 	}
 }
 
@@ -1092,11 +1119,8 @@ static void __init smp_boot_cpus(unsigne
 
 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
-	cpus_clear(cpu_sibling_map[0]);
-	cpu_set(0, cpu_sibling_map[0]);
 
-	cpus_clear(cpu_core_map[0]);
-	cpu_set(0, cpu_core_map[0]);
+	set_cpu_sibling_map(0);
 
 	/*
 	 * If we couldn't find an SMP configuration at boot time,
@@ -1275,15 +1299,24 @@ static void
 remove_siblinginfo(int cpu)
 {
 	int sibling;
+	struct cpuinfo_x86 *c = cpu_data;
 
+	for_each_cpu_mask(sibling, cpu_core_map[cpu]) {
+		cpu_clear(cpu, cpu_core_map[sibling]);
+		/*
+		 * last thread sibling in this cpu core going down
+		 */
+		if (cpus_weight(cpu_sibling_map[cpu]) == 1)
+			c[sibling].booted_cores--;
+	}
+			
 	for_each_cpu_mask(sibling, cpu_sibling_map[cpu])
 		cpu_clear(cpu, cpu_sibling_map[sibling]);
-	for_each_cpu_mask(sibling, cpu_core_map[cpu])
-		cpu_clear(cpu, cpu_core_map[sibling]);
 	cpus_clear(cpu_sibling_map[cpu]);
 	cpus_clear(cpu_core_map[cpu]);
 	phys_proc_id[cpu] = BAD_APICID;
 	cpu_core_id[cpu] = BAD_APICID;
+	cpu_clear(cpu, cpu_sibling_setup_map);
 }
 
 int __cpu_disable(void)
diff -pNru linux-2.6.14-rc4/arch/x86_64/kernel/setup.c linux-2.6.14-rc4-dc/arch/x86_64/kernel/setup.c
--- linux-2.6.14-rc4/arch/x86_64/kernel/setup.c	2005-10-12 18:22:04.262722936 -0700
+++ linux-2.6.14-rc4-dc/arch/x86_64/kernel/setup.c	2005-10-12 18:21:08.298230832 -0700
@@ -793,7 +793,7 @@ static void __init amd_detect_cmp(struct
 #endif
 
 	bits = 0;
-	while ((1 << bits) < c->x86_num_cores)
+	while ((1 << bits) < c->x86_max_cores)
 		bits++;
 
 	/* Low order bits define the core id (index of core in socket) */
@@ -826,7 +826,7 @@ static void __init amd_detect_cmp(struct
   	cpu_to_node[cpu] = node;
 
   	printk(KERN_INFO "CPU %d(%d) -> Node %d -> Core %d\n",
-  			cpu, c->x86_num_cores, node, cpu_core_id[cpu]);
+  			cpu, c->x86_max_cores, node, cpu_core_id[cpu]);
 #endif
 #endif
 }
@@ -875,9 +875,9 @@ static int __init init_amd(struct cpuinf
 	display_cacheinfo(c);
 
 	if (c->extended_cpuid_level >= 0x80000008) {
-		c->x86_num_cores = (cpuid_ecx(0x80000008) & 0xff) + 1;
-		if (c->x86_num_cores & (c->x86_num_cores - 1))
-			c->x86_num_cores = 1;
+		c->x86_max_cores = (cpuid_ecx(0x80000008) & 0xff) + 1;
+		if (c->x86_max_cores & (c->x86_max_cores - 1))
+			c->x86_max_cores = 1;
 
 		amd_detect_cmp(c);
 	}
@@ -889,54 +889,44 @@ static void __cpuinit detect_ht(struct c
 {
 #ifdef CONFIG_SMP
 	u32 	eax, ebx, ecx, edx;
-	int 	index_msb, tmp;
+	int 	index_msb, core_bits;
 	int 	cpu = smp_processor_id();
-	
+
+	cpuid(1, &eax, &ebx, &ecx, &edx);
+
+	c->apicid = phys_pkg_id(0);
+
 	if (!cpu_has(c, X86_FEATURE_HT) || cpu_has(c, X86_FEATURE_CMP_LEGACY))
 		return;
 
-	cpuid(1, &eax, &ebx, &ecx, &edx);
 	smp_num_siblings = (ebx & 0xff0000) >> 16;
-	
+
 	if (smp_num_siblings == 1) {
 		printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
-	} else if (smp_num_siblings > 1) {
-		index_msb = 31;
-		/*
-		 * At this point we only support two siblings per
-		 * processor package.
-		 */
+	} else if (smp_num_siblings > 1 ) {
+
 		if (smp_num_siblings > NR_CPUS) {
 			printk(KERN_WARNING "CPU: Unsupported number of the siblings %d", smp_num_siblings);
 			smp_num_siblings = 1;
 			return;
 		}
-		tmp = smp_num_siblings;
-		while ((tmp & 0x80000000 ) == 0) {
-			tmp <<=1 ;
-			index_msb--;
-		}
-		if (smp_num_siblings & (smp_num_siblings - 1))
-			index_msb++;
+
+		index_msb = get_count_order(smp_num_siblings);
 		phys_proc_id[cpu] = phys_pkg_id(index_msb);
-		
+
 		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
 		       phys_proc_id[cpu]);
 
-		smp_num_siblings = smp_num_siblings / c->x86_num_cores;
+		smp_num_siblings = smp_num_siblings / c->x86_max_cores;
 
-		tmp = smp_num_siblings;
-		index_msb = 31;
-		while ((tmp & 0x80000000) == 0) {
-			tmp <<=1 ;
-			index_msb--;
-		}
-		if (smp_num_siblings & (smp_num_siblings - 1))
-			index_msb++;
+		index_msb = get_count_order(smp_num_siblings) ;
+
+		core_bits = get_count_order(c->x86_max_cores);
 
-		cpu_core_id[cpu] = phys_pkg_id(index_msb);
+		cpu_core_id[cpu] = phys_pkg_id(index_msb) &
+					       ((1 << core_bits) - 1);
 
-		if (c->x86_num_cores > 1)
+		if (c->x86_max_cores > 1)
 			printk(KERN_INFO  "CPU: Processor Core ID: %d\n",
 			       cpu_core_id[cpu]);
 	}
@@ -999,7 +989,7 @@ static void __cpuinit init_intel(struct 
 		c->x86_cache_alignment = c->x86_clflush_size * 2;
 	if (c->x86 >= 15)
 		set_bit(X86_FEATURE_CONSTANT_TSC, &c->x86_capability);
- 	c->x86_num_cores = intel_num_cpu_cores(c);
+ 	c->x86_max_cores = intel_num_cpu_cores(c);
 
 	srat_detect_node();
 }
@@ -1037,7 +1027,7 @@ void __cpuinit early_identify_cpu(struct
 	c->x86_model_id[0] = '\0';  /* Unset */
 	c->x86_clflush_size = 64;
 	c->x86_cache_alignment = c->x86_clflush_size;
-	c->x86_num_cores = 1;
+	c->x86_max_cores = 1;
 	c->extended_cpuid_level = 0;
 	memset(&c->x86_capability, 0, sizeof c->x86_capability);
 
@@ -1271,13 +1261,12 @@ static int show_cpuinfo(struct seq_file 
 		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
 	
 #ifdef CONFIG_SMP
-	if (smp_num_siblings * c->x86_num_cores > 1) {
+	if (smp_num_siblings * c->x86_max_cores > 1) {
 		int cpu = c - cpu_data;
 		seq_printf(m, "physical id\t: %d\n", phys_proc_id[cpu]);
-		seq_printf(m, "siblings\t: %d\n",
-				c->x86_num_cores * smp_num_siblings);
+		seq_printf(m, "siblings\t: %d\n", cpus_weight(cpu_core_map[cpu]));
 		seq_printf(m, "core id\t\t: %d\n", cpu_core_id[cpu]);
-		seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
+		seq_printf(m, "cpu cores\t: %d\n", c->booted_cores);
 	}
 #endif	
 
diff -pNru linux-2.6.14-rc4/arch/x86_64/kernel/smpboot.c linux-2.6.14-rc4-dc/arch/x86_64/kernel/smpboot.c
--- linux-2.6.14-rc4/arch/x86_64/kernel/smpboot.c	2005-10-12 18:22:04.263722784 -0700
+++ linux-2.6.14-rc4-dc/arch/x86_64/kernel/smpboot.c	2005-10-13 13:58:36.485073928 -0700
@@ -64,6 +64,7 @@
 int smp_num_siblings = 1;
 /* Package ID of each logical CPU */
 u8 phys_proc_id[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = BAD_APICID };
+/* core ID of each logical CPU */
 u8 cpu_core_id[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = BAD_APICID };
 EXPORT_SYMBOL(phys_proc_id);
 EXPORT_SYMBOL(cpu_core_id);
@@ -89,7 +90,10 @@ struct cpuinfo_x86 cpu_data[NR_CPUS] __c
 /* Set when the idlers are all forked */
 int smp_threads_ready;
 
+/* representing HT siblings of each logical CPU */
 cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
+
+/* representing HT and core siblings of each logical CPU */
 cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_core_map);
 
@@ -436,30 +440,59 @@ void __cpuinit smp_callin(void)
 	cpu_set(cpuid, cpu_callin_map);
 }
 
+/* representing cpus for which sibling maps can be computed */
+static cpumask_t cpu_sibling_setup_map;
+
 static inline void set_cpu_sibling_map(int cpu)
 {
 	int i;
+	struct cpuinfo_x86 *c = cpu_data;
+
+	cpu_set(cpu, cpu_sibling_setup_map);
 
 	if (smp_num_siblings > 1) {
-		for_each_cpu(i) {
-			if (cpu_core_id[cpu] == cpu_core_id[i]) {
+		for_each_cpu_mask(i, cpu_sibling_setup_map) {
+			if (phys_proc_id[cpu] == phys_proc_id[i] &&
+			    cpu_core_id[cpu] == cpu_core_id[i]) {
 				cpu_set(i, cpu_sibling_map[cpu]);
 				cpu_set(cpu, cpu_sibling_map[i]);
+				cpu_set(i, cpu_core_map[cpu]);
+				cpu_set(cpu, cpu_core_map[i]);
 			}
 		}
 	} else {
 		cpu_set(cpu, cpu_sibling_map[cpu]);
 	}
 
-	if (current_cpu_data.x86_num_cores > 1) {
-		for_each_cpu(i) {
-			if (phys_proc_id[cpu] == phys_proc_id[i]) {
-				cpu_set(i, cpu_core_map[cpu]);
-				cpu_set(cpu, cpu_core_map[i]);
-			}
-		}
-	} else {
+	if (current_cpu_data.x86_max_cores == 1) {
 		cpu_core_map[cpu] = cpu_sibling_map[cpu];
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
 	}
 }
 
@@ -966,6 +999,7 @@ void __init smp_prepare_cpus(unsigned in
 	nmi_watchdog_default();
 	current_cpu_data = boot_cpu_data;
 	current_thread_info()->cpu = 0;  /* needed? */
+	set_cpu_sibling_map(0);
 
 	if (smp_sanity_check(max_cpus) < 0) {
 		printk(KERN_INFO "SMP disabled\n");
@@ -1009,8 +1043,6 @@ void __init smp_prepare_boot_cpu(void)
 	int me = smp_processor_id();
 	cpu_set(me, cpu_online_map);
 	cpu_set(me, cpu_callout_map);
-	cpu_set(0, cpu_sibling_map[0]);
-	cpu_set(0, cpu_core_map[0]);
 	per_cpu(cpu_state, me) = CPU_ONLINE;
 }
 
@@ -1082,15 +1114,24 @@ void __init smp_cpus_done(unsigned int m
 static void remove_siblinginfo(int cpu)
 {
 	int sibling;
+	struct cpuinfo_x86 *c = cpu_data;
 
+	for_each_cpu_mask(sibling, cpu_core_map[cpu]) {
+		cpu_clear(cpu, cpu_core_map[sibling]);
+		/*
+		 * last thread sibling in this cpu core going down
+		 */
+		if (cpus_weight(cpu_sibling_map[cpu]) == 1)
+			c[sibling].booted_cores--;
+	}
+			
 	for_each_cpu_mask(sibling, cpu_sibling_map[cpu])
 		cpu_clear(cpu, cpu_sibling_map[sibling]);
-	for_each_cpu_mask(sibling, cpu_core_map[cpu])
-		cpu_clear(cpu, cpu_core_map[sibling]);
 	cpus_clear(cpu_sibling_map[cpu]);
 	cpus_clear(cpu_core_map[cpu]);
 	phys_proc_id[cpu] = BAD_APICID;
 	cpu_core_id[cpu] = BAD_APICID;
+	cpu_clear(cpu, cpu_sibling_setup_map);
 }
 
 void remove_cpu_from_maps(void)
diff -pNru linux-2.6.14-rc4/include/asm-i386/processor.h linux-2.6.14-rc4-dc/include/asm-i386/processor.h
--- linux-2.6.14-rc4/include/asm-i386/processor.h	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-dc/include/asm-i386/processor.h	2005-10-13 13:40:54.128576664 -0700
@@ -65,7 +65,9 @@ struct cpuinfo_x86 {
 	int	f00f_bug;
 	int	coma_bug;
 	unsigned long loops_per_jiffy;
-	unsigned char x86_num_cores;
+	unsigned char x86_max_cores;	/* cpuid returned max cores value */
+	unsigned char booted_cores;	/* number of cores as seen by OS */
+	unsigned char apicid;
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
 
 #define X86_VENDOR_INTEL 0
diff -pNru linux-2.6.14-rc4/include/asm-x86_64/processor.h linux-2.6.14-rc4-dc/include/asm-x86_64/processor.h
--- linux-2.6.14-rc4/include/asm-x86_64/processor.h	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-dc/include/asm-x86_64/processor.h	2005-10-13 13:41:53.880492992 -0700
@@ -61,10 +61,12 @@ struct cpuinfo_x86 {
 	int	x86_cache_alignment;
 	int	x86_tlbsize;	/* number of 4K pages in DTLB/ITLB combined(in pages)*/
         __u8    x86_virt_bits, x86_phys_bits;
-	__u8	x86_num_cores;
+	__u8	x86_max_cores;	/* cpuid returned max cores value */
         __u32   x86_power; 	
 	__u32   extended_cpuid_level;	/* Max extended CPUID function supported */
 	unsigned long loops_per_jiffy;
+	__u8	apicid;
+	__u8	booted_cores;	/* number of cores as seen by OS */
 } ____cacheline_aligned;
 
 #define X86_VENDOR_INTEL 0
diff -pNru linux-2.6.14-rc4/include/linux/bitops.h linux-2.6.14-rc4-dc/include/linux/bitops.h
--- linux-2.6.14-rc4/include/linux/bitops.h	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-dc/include/linux/bitops.h	2005-10-12 11:17:52.585965928 -0700
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
