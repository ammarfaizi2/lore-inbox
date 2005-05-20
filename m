Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVETWmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVETWmn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 18:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVETWmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 18:42:42 -0400
Received: from fmr20.intel.com ([134.134.136.19]:18574 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261441AbVETWjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 18:39:52 -0400
Message-Id: <20050520223417.196245000@csdlinux-2.jf.intel.com>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com>
Date: Fri, 20 May 2005 15:16:23 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: ak@muc.de
Cc: zwane@arm.linux.org.uk, discuss@x86-64.org, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org
Subject: [patch 1/4] CPU hot-plug support for x86_64
Content-Disposition: inline; filename=x86_64-init_cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes all init sections that are required to exist
past smpboot.

- Changed __cpuinit to __devinit since this is how the rest
  of the cpu hotplug infrastructure is written.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>

--------------------------------------------
 arch/x86_64/kernel/apic.c    |    8 ++++----
 arch/x86_64/kernel/i387.c    |    2 +-
 arch/x86_64/kernel/nmi.c     |    4 ++--
 arch/x86_64/kernel/process.c |    2 +-
 arch/x86_64/kernel/setup.c   |   18 +++++++++---------
 arch/x86_64/kernel/setup64.c |    8 ++++----
 arch/x86_64/kernel/smpboot.c |   37 ++++++++++++++++---------------------
 mm/page_alloc.c              |    2 +-
 8 files changed, 38 insertions(+), 43 deletions(-)

Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/smpboot.c	2005-05-18 15:30:27.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/smpboot.c	2005-05-20 13:14:58.000000000 -0700
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
@@ -108,7 +103,7 @@
  * has made sure it's suitably aligned.
  */
 
-static unsigned long __cpuinit setup_trampoline(void)
+static unsigned long __devinit setup_trampoline(void)
 {
 	void *tramp = __va(SMP_TRAMPOLINE_BASE); 
 	memcpy(tramp, trampoline_data, trampoline_end - trampoline_data);
@@ -120,7 +115,7 @@
  * a given CPU
  */
 
-static void __cpuinit smp_store_cpu_info(int id)
+static void __devinit smp_store_cpu_info(int id)
 {
 	struct cpuinfo_x86 *c = cpu_data + id;
 
@@ -331,13 +326,13 @@
 }
 __setup("notscsync", notscsync_setup);
 
-static atomic_t init_deasserted __cpuinitdata;
+static atomic_t init_deasserted __devinitdata;
 
 /*
  * Report back to the Boot Processor.
  * Running on AP.
  */
-void __cpuinit smp_callin(void)
+void __devinit smp_callin(void)
 {
 	int cpuid, phys_id;
 	unsigned long timeout;
@@ -420,7 +415,7 @@
 /*
  * Setup code on secondary processor (after comming out of the trampoline)
  */
-void __cpuinit start_secondary(void)
+void __devinit start_secondary(void)
 {
 	/*
 	 * Dont put anything before smp_callin(), SMP
@@ -504,7 +499,7 @@
 /*
  * Kick the secondary to wake up.
  */
-static int __cpuinit wakeup_secondary_via_INIT(int phys_apicid, unsigned int start_rip)
+static int __devinit wakeup_secondary_via_INIT(int phys_apicid, unsigned int start_rip)
 {
 	unsigned long send_status = 0, accept_status = 0;
 	int maxlvt, timeout, num_starts, j;
@@ -630,7 +625,7 @@
 /*
  * Boot one CPU.
  */
-static int __cpuinit do_boot_cpu(int cpu, int apicid)
+static int __devinit do_boot_cpu(int cpu, int apicid)
 {
 	struct task_struct *idle;
 	unsigned long boot_error;
@@ -748,7 +743,7 @@
  * Construct cpu_sibling_map[], so that we can tell the sibling CPU
  * on SMT systems efficiently.
  */
-static __cpuinit void detect_siblings(void)
+static __devinit void detect_siblings(void)
 {
 	int cpu;
 
@@ -792,7 +787,7 @@
 /*
  * Cleanup possible dangling ends...
  */
-static __cpuinit void smp_cleanup_boot(void)
+static __devinit void smp_cleanup_boot(void)
 {
 	/*
 	 * Paranoid:  Set warm reset code and vector here back
@@ -822,7 +817,7 @@
  *
  * RED-PEN audit/test this more. I bet there is more state messed up here.
  */
-static __cpuinit void disable_smp(void)
+static __init void disable_smp(void)
 {
 	cpu_present_map = cpumask_of_cpu(0);
 	cpu_possible_map = cpumask_of_cpu(0);
@@ -837,7 +832,7 @@
 /*
  * Handle user cpus=... parameter.
  */
-static __cpuinit void enforce_max_cpus(unsigned max_cpus)
+static __init void enforce_max_cpus(unsigned max_cpus)
 {
 	int i, k;
 	k = 0;
@@ -854,7 +849,7 @@
 /*
  * Various sanity checks.
  */
-static int __cpuinit smp_sanity_check(unsigned max_cpus)
+static int __devinit smp_sanity_check(unsigned max_cpus)
 {
 	if (!physid_isset(hard_smp_processor_id(), phys_cpu_present_map)) {
 		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
@@ -912,7 +907,7 @@
  * Prepare for SMP bootup.  The MP table or ACPI has been read
  * earlier.  Just do some sanity checking here and enable APIC mode.
  */
-void __cpuinit smp_prepare_cpus(unsigned int max_cpus)
+void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int i;
 
@@ -982,10 +977,10 @@
 /*
  * Entry point to boot a CPU.
  *
- * This is all __cpuinit, not __devinit for now because we don't support
+ * This is all __devinit, not __devinit for now because we don't support
  * CPU hotplug (yet).
  */
-int __cpuinit __cpu_up(unsigned int cpu)
+int __devinit __cpu_up(unsigned int cpu)
 {
 	int err;
 	int apicid = cpu_present_to_apicid(cpu);
@@ -1018,7 +1013,7 @@
 /*
  * Finish the SMP boot.
  */
-void __cpuinit smp_cpus_done(unsigned int max_cpus)
+void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
 	smp_cleanup_boot();
Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/process.c	2005-05-18 15:30:27.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/process.c	2005-05-20 13:14:58.000000000 -0700
@@ -204,7 +204,7 @@
 	}
 }
 
-void __init select_idle_routine(const struct cpuinfo_x86 *c)
+void __devinit select_idle_routine(const struct cpuinfo_x86 *c)
 {
 	static int printed;
 	if (cpu_has(c, X86_FEATURE_MWAIT)) {
Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/setup.c	2005-05-18 15:30:27.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/setup.c	2005-05-18 15:30:55.000000000 -0700
@@ -696,7 +696,7 @@
 #endif
 }
 
-static int __init get_model_name(struct cpuinfo_x86 *c)
+static int __devinit get_model_name(struct cpuinfo_x86 *c)
 {
 	unsigned int *v;
 
@@ -712,7 +712,7 @@
 }
 
 
-static void __init display_cacheinfo(struct cpuinfo_x86 *c)
+static void __devinit display_cacheinfo(struct cpuinfo_x86 *c)
 {
 	unsigned int n, dummy, eax, ebx, ecx, edx;
 
@@ -823,7 +823,7 @@
 	return r;
 }
 
-static void __init detect_ht(struct cpuinfo_x86 *c)
+static void __devinit detect_ht(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
 	u32 	eax, ebx, ecx, edx;
@@ -884,7 +884,7 @@
 /*
  * find out the number of processor cores on the die
  */
-static int __init intel_num_cpu_cores(struct cpuinfo_x86 *c)
+static int __devinit intel_num_cpu_cores(struct cpuinfo_x86 *c)
 {
 	unsigned int eax;
 
@@ -902,7 +902,7 @@
 		return 1;
 }
 
-static void __init init_intel(struct cpuinfo_x86 *c)
+static void __devinit init_intel(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
 	unsigned n;
@@ -922,7 +922,7 @@
  	c->x86_num_cores = intel_num_cpu_cores(c);
 }
 
-void __init get_cpu_vendor(struct cpuinfo_x86 *c)
+void __devinit get_cpu_vendor(struct cpuinfo_x86 *c)
 {
 	char *v = c->x86_vendor_id;
 
@@ -943,7 +943,7 @@
 /* Do some early cpuid on the boot CPU to get some parameter that are
    needed before check_bugs. Everything advanced is in identify_cpu
    below. */
-void __init early_identify_cpu(struct cpuinfo_x86 *c)
+void __devinit early_identify_cpu(struct cpuinfo_x86 *c)
 {
 	u32 tfms;
 
@@ -998,7 +998,7 @@
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
-void __init identify_cpu(struct cpuinfo_x86 *c)
+void __devinit identify_cpu(struct cpuinfo_x86 *c)
 {
 	int i;
 	u32 xlvl;
@@ -1075,7 +1075,7 @@
 }
  
 
-void __init print_cpu_info(struct cpuinfo_x86 *c)
+void __devinit print_cpu_info(struct cpuinfo_x86 *c)
 {
 	if (c->x86_model_id[0])
 		printk("%s", c->x86_model_id);
Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/apic.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/apic.c	2005-05-18 15:30:27.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/apic.c	2005-05-18 15:30:55.000000000 -0700
@@ -321,7 +321,7 @@
 	apic_write_around(APIC_LVT1, value);
 }
 
-void __init setup_local_APIC (void)
+void __devinit setup_local_APIC (void)
 {
 	unsigned int value, ver, maxlvt;
 
@@ -570,7 +570,7 @@
 	.cls		= &lapic_sysclass,
 };
 
-static void __init apic_pm_activate(void)
+static void __devinit apic_pm_activate(void)
 {
 	apic_pm_state.active = 1;
 }
@@ -810,14 +810,14 @@
 	local_irq_enable();
 }
 
-void __init setup_secondary_APIC_clock(void)
+void __devinit setup_secondary_APIC_clock(void)
 {
 	local_irq_disable(); /* FIXME: Do we need this? --RR */
 	setup_APIC_timer(calibration_result);
 	local_irq_enable();
 }
 
-void __init disable_APIC_timer(void)
+void __devinit disable_APIC_timer(void)
 {
 	if (using_apic_timer) {
 		unsigned long v;
Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/setup64.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/setup64.c	2005-05-06 22:20:31.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/setup64.c	2005-05-18 15:30:55.000000000 -0700
@@ -29,7 +29,7 @@
 
 char x86_boot_params[BOOT_PARAM_SIZE] __initdata = {0,};
 
-cpumask_t cpu_initialized __initdata = CPU_MASK_NONE;
+cpumask_t cpu_initialized __devinitdata = CPU_MASK_NONE;
 
 struct x8664_pda cpu_pda[NR_CPUS] __cacheline_aligned; 
 
@@ -171,7 +171,7 @@
 	wrmsrl(MSR_SYSCALL_MASK, EF_TF|EF_DF|EF_IE|0x3000); 
 }
 
-void __init check_efer(void)
+void __devinit check_efer(void)
 {
 	unsigned long efer;
 
@@ -188,7 +188,7 @@
  * 'CPU state barrier', nothing should get across.
  * A lot of state is already set up in PDA init.
  */
-void __init cpu_init (void)
+void __devinit cpu_init (void)
 {
 #ifdef CONFIG_SMP
 	int cpu = stack_smp_processor_id();
@@ -214,7 +214,7 @@
 
 	printk("Initializing CPU#%d\n", cpu);
 
-		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
+	clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
 
 	/*
 	 * Initialize the per-CPU GDT with the boot GDT,
Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/i387.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/i387.c	2005-05-06 22:20:31.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/i387.c	2005-05-18 15:30:55.000000000 -0700
@@ -42,7 +42,7 @@
  * Called at bootup to set up the initial FPU state that is later cloned
  * into all processes.
  */
-void __init fpu_init(void)
+void __devinit fpu_init(void)
 {
 	unsigned long oldcr0 = read_cr0();
 	extern void __bad_fxsave_alignment(void);
Index: linux-2.6.12-rc4-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/mm/page_alloc.c	2005-05-18 15:30:28.000000000 -0700
+++ linux-2.6.12-rc4-mm2/mm/page_alloc.c	2005-05-18 15:30:55.000000000 -0700
@@ -72,7 +72,7 @@
 
 #ifdef CONFIG_NUMA
 static struct per_cpu_pageset
-	pageset_table[MAX_NR_ZONES*MAX_NUMNODES*NR_CPUS] __initdata;
+	pageset_table[MAX_NR_ZONES*MAX_NUMNODES*NR_CPUS] __devinitdata;
 #endif
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/nmi.c	2005-05-18 15:30:27.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/nmi.c	2005-05-18 16:34:00.000000000 -0700
@@ -98,7 +98,7 @@
 	(P4_CCCR_OVF_PMI0|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
 	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
 
-static __init inline int nmi_known_cpu(void)
+static __devinit inline int nmi_known_cpu(void)
 {
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
@@ -110,7 +110,7 @@
 }
 
 /* Run after command line and cpu_init init, but before all other checks */
-void __init nmi_watchdog_default(void)
+void __devinit nmi_watchdog_default(void)
 {
 	if (nmi_watchdog != NMI_DEFAULT)
 		return;

--
