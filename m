Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbVJLVg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVJLVg4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 17:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVJLVg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 17:36:56 -0400
Received: from fmr22.intel.com ([143.183.121.14]:48589 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932457AbVJLVgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 17:36:55 -0400
Date: Wed, 12 Oct 2005 14:36:42 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [Patch 1/2] x86, x86_64: Intel HT, Multi core detection fixes 
Message-ID: <20051012143641.B29292@unix-os.sc.intel.com>
References: <20051005161706.B30098@unix-os.sc.intel.com> <20051007095200.GL6642@verdi.suse.de> <20051007175240.A2354@unix-os.sc.intel.com> <200510081228.39492.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200510081228.39492.ak@suse.de>; from ak@suse.de on Sat, Oct 08, 2005 at 12:28:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Please apply.

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

diff -pNru linux-2.6.14-rc4/arch/i386/kernel/cpu/common.c linux-2.6.14-rc4-dc/arch/i386/kernel/cpu/common.c
--- linux-2.6.14-rc4/arch/i386/kernel/cpu/common.c	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-dc/arch/i386/kernel/cpu/common.c	2005-10-12 11:02:00.361726016 -0700
@@ -446,32 +446,29 @@ void __devinit identify_cpu(struct cpuin
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
@@ -479,17 +476,12 @@ void __devinit detect_ht(struct cpuinfo_
 
 		smp_num_siblings = smp_num_siblings / c->x86_num_cores;
 
-		tmp = smp_num_siblings;
-		index_msb = 31;
-		while ((tmp & 0x80000000) == 0) {
-			tmp <<=1 ;
-			index_msb--;
-		}
+		index_msb = get_count_order(smp_num_siblings) ;
 
-		if (smp_num_siblings & (smp_num_siblings - 1))
-			index_msb++;
+		core_bits = get_count_order(c->x86_num_cores);
 
-		cpu_core_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb);
+		cpu_core_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb) &
+					       ((1 << core_bits) - 1);
 
 		if (c->x86_num_cores > 1)
 			printk(KERN_INFO  "CPU: Processor Core ID: %d\n",
diff -pNru linux-2.6.14-rc4/arch/i386/kernel/cpu/proc.c linux-2.6.14-rc4-dc/arch/i386/kernel/cpu/proc.c
--- linux-2.6.14-rc4/arch/i386/kernel/cpu/proc.c	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-dc/arch/i386/kernel/cpu/proc.c	2005-10-12 11:03:05.211867296 -0700
@@ -96,10 +96,9 @@ static int show_cpuinfo(struct seq_file 
 #ifdef CONFIG_X86_HT
 	if (c->x86_num_cores * smp_num_siblings > 1) {
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
+++ linux-2.6.14-rc4-dc/arch/i386/kernel/smpboot.c	2005-10-12 11:12:53.383451624 -0700
@@ -440,35 +440,59 @@ static void __devinit smp_callin(void)
 
 static int cpucount;
 
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
+	if (current_cpu_data.x86_num_cores == 1) {
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
 
@@ -1092,11 +1116,8 @@ static void __init smp_boot_cpus(unsigne
 
 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
-	cpus_clear(cpu_sibling_map[0]);
-	cpu_set(0, cpu_sibling_map[0]);
 
-	cpus_clear(cpu_core_map[0]);
-	cpu_set(0, cpu_core_map[0]);
+	set_cpu_sibling_map(0);
 
 	/*
 	 * If we couldn't find an SMP configuration at boot time,
@@ -1275,15 +1296,24 @@ static void
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
--- linux-2.6.14-rc4/arch/x86_64/kernel/setup.c	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-dc/arch/x86_64/kernel/setup.c	2005-10-12 11:29:43.188937856 -0700
@@ -889,52 +889,42 @@ static void __cpuinit detect_ht(struct c
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
 
 		smp_num_siblings = smp_num_siblings / c->x86_num_cores;
 
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
+		core_bits = get_count_order(c->x86_num_cores);
 
-		cpu_core_id[cpu] = phys_pkg_id(index_msb);
+		cpu_core_id[cpu] = phys_pkg_id(index_msb) &
+					       ((1 << core_bits) - 1);
 
 		if (c->x86_num_cores > 1)
 			printk(KERN_INFO  "CPU: Processor Core ID: %d\n",
@@ -1274,10 +1264,9 @@ static int show_cpuinfo(struct seq_file 
 	if (smp_num_siblings * c->x86_num_cores > 1) {
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
--- linux-2.6.14-rc4/arch/x86_64/kernel/smpboot.c	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-dc/arch/x86_64/kernel/smpboot.c	2005-10-12 11:17:34.109774736 -0700
@@ -436,30 +436,58 @@ void __cpuinit smp_callin(void)
 	cpu_set(cpuid, cpu_callin_map);
 }
 
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
+	if (current_cpu_data.x86_num_cores == 1) {
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
 
@@ -966,6 +994,7 @@ void __init smp_prepare_cpus(unsigned in
 	nmi_watchdog_default();
 	current_cpu_data = boot_cpu_data;
 	current_thread_info()->cpu = 0;  /* needed? */
+	set_cpu_sibling_map(0);
 
 	if (smp_sanity_check(max_cpus) < 0) {
 		printk(KERN_INFO "SMP disabled\n");
@@ -1009,8 +1038,6 @@ void __init smp_prepare_boot_cpu(void)
 	int me = smp_processor_id();
 	cpu_set(me, cpu_online_map);
 	cpu_set(me, cpu_callout_map);
-	cpu_set(0, cpu_sibling_map[0]);
-	cpu_set(0, cpu_core_map[0]);
 	per_cpu(cpu_state, me) = CPU_ONLINE;
 }
 
@@ -1082,15 +1109,24 @@ void __init smp_cpus_done(unsigned int m
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
+++ linux-2.6.14-rc4-dc/include/asm-i386/processor.h	2005-10-12 10:59:34.927835328 -0700
@@ -66,6 +66,8 @@ struct cpuinfo_x86 {
 	int	coma_bug;
 	unsigned long loops_per_jiffy;
 	unsigned char x86_num_cores;
+	unsigned char booted_cores;
+	unsigned char apicid;
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
 
 #define X86_VENDOR_INTEL 0
diff -pNru linux-2.6.14-rc4/include/asm-x86_64/processor.h linux-2.6.14-rc4-dc/include/asm-x86_64/processor.h
--- linux-2.6.14-rc4/include/asm-x86_64/processor.h	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-dc/include/asm-x86_64/processor.h	2005-10-12 10:44:45.467053920 -0700
@@ -65,6 +65,8 @@ struct cpuinfo_x86 {
         __u32   x86_power; 	
 	__u32   extended_cpuid_level;	/* Max extended CPUID function supported */
 	unsigned long loops_per_jiffy;
+	__u8	apicid;
+	__u8	booted_cores;
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
