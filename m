Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVFBNDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVFBNDj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 09:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVFBNDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 09:03:34 -0400
Received: from fmr20.intel.com ([134.134.136.19]:20440 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261413AbVFBNBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 09:01:25 -0400
Message-Id: <20050602130111.694382000@araj-em64t>
References: <20050602125754.993470000@araj-em64t>
Date: Thu, 02 Jun 2005 05:57:56 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Ashok Raj <ashok.raj@intel.com>
Subject: [patch 1/5] x86_64: Change init sections for CPU hotplug support
Content-Disposition: inline; filename=x86_64-cpuhp-initcall-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds __cpuinit and __cpuinitdata sections that need to exist
past boot to support cpu hotplug.

Caveat: This is done *only* for EM64T CPU Hotplug support, on request from
Andi Kleen. Much of the generic hotplug code in kernel, and none of the 
other archs that support CPU hotplug today, i386, ia64, ppc64, s390 and
parisc dont mark sections with __cpuinit, but only mark them as __devinit, 
and __devinitdata.

If someone is motivated to change generic code, we need to make sure all
existing hotplug code does not break, on other arch's that dont use 
__cpuinit, and __cpudevinit.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------------------------------------
 arch/x86_64/kernel/apic.c      |    8 ++++----
 arch/x86_64/kernel/i387.c      |    2 +-
 arch/x86_64/kernel/mce.c       |    8 ++++----
 arch/x86_64/kernel/mce_intel.c |    4 ++--
 arch/x86_64/kernel/nmi.c       |    4 ++--
 arch/x86_64/kernel/process.c   |    2 +-
 arch/x86_64/kernel/setup.c     |   18 +++++++++---------
 arch/x86_64/kernel/setup64.c   |    6 +++---
 arch/x86_64/kernel/smpboot.c   |   15 +++++----------
 arch/x86_64/mm/numa.c          |    2 +-
 include/linux/init.h           |   13 +++++++++++++
 mm/page_alloc.c                |    2 +-
 12 files changed, 46 insertions(+), 38 deletions(-)

Index: linux-2.6.12-rc5-mm2/include/linux/init.h
===================================================================
--- linux-2.6.12-rc5-mm2.orig/include/linux/init.h
+++ linux-2.6.12-rc5-mm2/include/linux/init.h
@@ -222,6 +222,19 @@ void __init parse_early_param(void);
 #define __devinitdata
 #define __devexit
 #define __devexitdata
+
+#ifdef CONFIG_HOTPLUG_CPU
+#define __cpuinit
+#define __cpuinitdata
+#define __cpuexit
+#define __cpuexitdata
+#else
+#define __cpuinit	__init
+#define __cpuinitdata __initdata
+#define __cpuexit __exit
+#define __cpuexitdata	__exitdata
+#endif
+
 #else
 #define __devinit __init
 #define __devinitdata __initdata
Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/smpboot.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/smpboot.c
@@ -58,11 +58,6 @@
 #include <asm/proto.h>
 #include <asm/nmi.h>
 
-/* Change for real CPU hotplug. Note other files need to be fixed
-   first too. */
-#define __cpuinit __init
-#define __cpuinitdata __initdata
-
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
 /* Package ID of each logical CPU */
@@ -823,7 +818,7 @@ static __cpuinit void smp_cleanup_boot(v
  *
  * RED-PEN audit/test this more. I bet there is more state messed up here.
  */
-static __cpuinit void disable_smp(void)
+static __init void disable_smp(void)
 {
 	cpu_present_map = cpumask_of_cpu(0);
 	cpu_possible_map = cpumask_of_cpu(0);
@@ -838,7 +833,7 @@ static __cpuinit void disable_smp(void)
 /*
  * Handle user cpus=... parameter.
  */
-static __cpuinit void enforce_max_cpus(unsigned max_cpus)
+static __init void enforce_max_cpus(unsigned max_cpus)
 {
 	int i, k;
 	k = 0;
@@ -855,7 +850,7 @@ static __cpuinit void enforce_max_cpus(u
 /*
  * Various sanity checks.
  */
-static int __cpuinit smp_sanity_check(unsigned max_cpus)
+static int __init smp_sanity_check(unsigned max_cpus)
 {
 	if (!physid_isset(hard_smp_processor_id(), phys_cpu_present_map)) {
 		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
@@ -913,7 +908,7 @@ static int __cpuinit smp_sanity_check(un
  * Prepare for SMP bootup.  The MP table or ACPI has been read
  * earlier.  Just do some sanity checking here and enable APIC mode.
  */
-void __cpuinit smp_prepare_cpus(unsigned int max_cpus)
+void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int i;
 
@@ -1019,7 +1014,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
 /*
  * Finish the SMP boot.
  */
-void __cpuinit smp_cpus_done(unsigned int max_cpus)
+void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
 	smp_cleanup_boot();
Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/process.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/process.c
@@ -204,7 +204,7 @@ static void mwait_idle(void)
 	}
 }
 
-void __init select_idle_routine(const struct cpuinfo_x86 *c)
+void __cpuinit select_idle_routine(const struct cpuinfo_x86 *c)
 {
 	static int printed;
 	if (cpu_has(c, X86_FEATURE_MWAIT)) {
Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/setup.c
@@ -708,7 +708,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 }
 
-static int __init get_model_name(struct cpuinfo_x86 *c)
+static int __cpuinit get_model_name(struct cpuinfo_x86 *c)
 {
 	unsigned int *v;
 
@@ -724,7 +724,7 @@ static int __init get_model_name(struct 
 }
 
 
-static void __init display_cacheinfo(struct cpuinfo_x86 *c)
+static void __cpuinit display_cacheinfo(struct cpuinfo_x86 *c)
 {
 	unsigned int n, dummy, eax, ebx, ecx, edx;
 
@@ -835,7 +835,7 @@ static int __init init_amd(struct cpuinf
 	return r;
 }
 
-static void __init detect_ht(struct cpuinfo_x86 *c)
+static void __cpuinit detect_ht(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
 	u32 	eax, ebx, ecx, edx;
@@ -896,7 +896,7 @@ static void __init detect_ht(struct cpui
 /*
  * find out the number of processor cores on the die
  */
-static int __init intel_num_cpu_cores(struct cpuinfo_x86 *c)
+static int __cpuinit intel_num_cpu_cores(struct cpuinfo_x86 *c)
 {
 	unsigned int eax;
 
@@ -914,7 +914,7 @@ static int __init intel_num_cpu_cores(st
 		return 1;
 }
 
-static void __init init_intel(struct cpuinfo_x86 *c)
+static void __cpuinit init_intel(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
 	unsigned n;
@@ -934,7 +934,7 @@ static void __init init_intel(struct cpu
  	c->x86_num_cores = intel_num_cpu_cores(c);
 }
 
-void __init get_cpu_vendor(struct cpuinfo_x86 *c)
+void __cpuinit get_cpu_vendor(struct cpuinfo_x86 *c)
 {
 	char *v = c->x86_vendor_id;
 
@@ -955,7 +955,7 @@ struct cpu_model_info {
 /* Do some early cpuid on the boot CPU to get some parameter that are
    needed before check_bugs. Everything advanced is in identify_cpu
    below. */
-void __init early_identify_cpu(struct cpuinfo_x86 *c)
+void __cpuinit early_identify_cpu(struct cpuinfo_x86 *c)
 {
 	u32 tfms;
 
@@ -1009,7 +1009,7 @@ void __init early_identify_cpu(struct cp
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
-void __init identify_cpu(struct cpuinfo_x86 *c)
+void __cpuinit identify_cpu(struct cpuinfo_x86 *c)
 {
 	int i;
 	u32 xlvl;
@@ -1086,7 +1086,7 @@ void __init identify_cpu(struct cpuinfo_
 }
  
 
-void __init print_cpu_info(struct cpuinfo_x86 *c)
+void __cpuinit print_cpu_info(struct cpuinfo_x86 *c)
 {
 	if (c->x86_model_id[0])
 		printk("%s", c->x86_model_id);
Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/apic.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/apic.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/apic.c
@@ -321,7 +321,7 @@ void __init init_bsp_APIC(void)
 	apic_write_around(APIC_LVT1, value);
 }
 
-void __init setup_local_APIC (void)
+void __cpuinit setup_local_APIC (void)
 {
 	unsigned int value, ver, maxlvt;
 
@@ -570,7 +570,7 @@ static struct sys_device device_lapic = 
 	.cls		= &lapic_sysclass,
 };
 
-static void __init apic_pm_activate(void)
+static void __cpuinit apic_pm_activate(void)
 {
 	apic_pm_state.active = 1;
 }
@@ -810,14 +810,14 @@ void __init setup_boot_APIC_clock (void)
 	local_irq_enable();
 }
 
-void __init setup_secondary_APIC_clock(void)
+void __cpuinit setup_secondary_APIC_clock(void)
 {
 	local_irq_disable(); /* FIXME: Do we need this? --RR */
 	setup_APIC_timer(calibration_result);
 	local_irq_enable();
 }
 
-void __init disable_APIC_timer(void)
+void __cpuinit disable_APIC_timer(void)
 {
 	if (using_apic_timer) {
 		unsigned long v;
Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/setup64.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/setup64.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/setup64.c
@@ -29,7 +29,7 @@
 
 char x86_boot_params[BOOT_PARAM_SIZE] __initdata = {0,};
 
-cpumask_t cpu_initialized __initdata = CPU_MASK_NONE;
+cpumask_t cpu_initialized __cpuinitdata = CPU_MASK_NONE;
 
 struct x8664_pda cpu_pda[NR_CPUS] __cacheline_aligned; 
 
@@ -171,7 +171,7 @@ void syscall_init(void)
 	wrmsrl(MSR_SYSCALL_MASK, EF_TF|EF_DF|EF_IE|0x3000); 
 }
 
-void __init check_efer(void)
+void __cpuinit check_efer(void)
 {
 	unsigned long efer;
 
@@ -188,7 +188,7 @@ void __init check_efer(void)
  * 'CPU state barrier', nothing should get across.
  * A lot of state is already set up in PDA init.
  */
-void __init cpu_init (void)
+void __cpuinit cpu_init (void)
 {
 #ifdef CONFIG_SMP
 	int cpu = stack_smp_processor_id();
Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/i387.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/i387.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/i387.c
@@ -42,7 +42,7 @@ void mxcsr_feature_mask_init(void)
  * Called at bootup to set up the initial FPU state that is later cloned
  * into all processes.
  */
-void __init fpu_init(void)
+void __cpuinit fpu_init(void)
 {
 	unsigned long oldcr0 = read_cr0();
 	extern void __bad_fxsave_alignment(void);
Index: linux-2.6.12-rc5-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/mm/page_alloc.c
+++ linux-2.6.12-rc5-mm2/mm/page_alloc.c
@@ -72,7 +72,7 @@ EXPORT_SYMBOL(zone_table);
 
 #ifdef CONFIG_NUMA
 static struct per_cpu_pageset
-	pageset_table[MAX_NR_ZONES*MAX_NUMNODES*NR_CPUS] __initdata;
+	pageset_table[MAX_NR_ZONES*MAX_NUMNODES*NR_CPUS] __cpuinitdata;
 #endif
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/nmi.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/nmi.c
@@ -98,7 +98,7 @@ static unsigned int nmi_p4_cccr_val;
 	(P4_CCCR_OVF_PMI0|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
 	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
 
-static __init inline int nmi_known_cpu(void)
+static __cpuinit inline int nmi_known_cpu(void)
 {
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
@@ -110,7 +110,7 @@ static __init inline int nmi_known_cpu(v
 }
 
 /* Run after command line and cpu_init init, but before all other checks */
-void __init nmi_watchdog_default(void)
+void __cpuinit nmi_watchdog_default(void)
 {
 	if (nmi_watchdog != NMI_DEFAULT)
 		return;
Index: linux-2.6.12-rc5-mm2/arch/x86_64/mm/numa.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/mm/numa.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/mm/numa.c
@@ -251,7 +251,7 @@ void __init numa_initmem_init(unsigned l
 	setup_node_bootmem(0, start_pfn << PAGE_SHIFT, end_pfn << PAGE_SHIFT);
 }
 
-__init void numa_add_cpu(int cpu)
+__cpuinit void numa_add_cpu(int cpu)
 {
 	/* BP is initialized elsewhere */
 	if (cpu) 
Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/mce.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/mce.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/mce.c
@@ -327,7 +327,7 @@ static void mce_init(void *dummy)
 }
 
 /* Add per CPU specific workarounds here */
-static void __init mce_cpu_quirks(struct cpuinfo_x86 *c) 
+static void __cpuinit mce_cpu_quirks(struct cpuinfo_x86 *c)
 { 
 	/* This should be disabled by the BIOS, but isn't always */
 	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 == 15) {
@@ -337,7 +337,7 @@ static void __init mce_cpu_quirks(struct
 	}
 }			
 
-static void __init mce_cpu_features(struct cpuinfo_x86 *c)
+static void __cpuinit mce_cpu_features(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
 	case X86_VENDOR_INTEL:
@@ -352,7 +352,7 @@ static void __init mce_cpu_features(stru
  * Called for each booted CPU to set up machine checks.
  * Must be called with preempt off. 
  */
-void __init mcheck_init(struct cpuinfo_x86 *c)
+void __cpuinit mcheck_init(struct cpuinfo_x86 *c)
 {
 	static cpumask_t mce_cpus __initdata = CPU_MASK_NONE;
 
@@ -542,7 +542,7 @@ ACCESSOR(bank4ctl,bank[4],mce_restart())
 ACCESSOR(tolerant,tolerant,)
 ACCESSOR(check_interval,check_interval,mce_restart())
 
-static __init int mce_init_device(void)
+static __cpuinit int mce_init_device(void)
 {
 	int err;
 	if (!mce_available(&boot_cpu_data))
Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/mce_intel.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/mce_intel.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/mce_intel.c
@@ -42,7 +42,7 @@ done:
 	irq_exit();
 }
 
-static void __init intel_init_thermal(struct cpuinfo_x86 *c)
+static void __cpuinit intel_init_thermal(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int tm2 = 0;
@@ -93,7 +93,7 @@ static void __init intel_init_thermal(st
 	return;
 }
 
-void __init mce_intel_feature_init(struct cpuinfo_x86 *c)
+void __cpuinit mce_intel_feature_init(struct cpuinfo_x86 *c)
 {
 	intel_init_thermal(c);
 }

--

