Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVDDCP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVDDCP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 22:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVDDCPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 22:15:30 -0400
Received: from fmr20.intel.com ([134.134.136.19]:56750 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261973AbVDDCJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 22:09:10 -0400
Subject: [RFC 3/6]init call cleanup
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Message-Id: <1112580360.4194.340.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 04 Apr 2005 10:06:47 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trival patch for CPU hotplug. In CPU identify part, only did cleanup for intel
CPUs. Need do for other CPUs if they support S3 SMP.

Thanks,
Shaohua

---

 linux-2.6.11-root/arch/i386/kernel/apic.c                |   14 +++----
 linux-2.6.11-root/arch/i386/kernel/cpu/common.c          |   30 +++++++--------
 linux-2.6.11-root/arch/i386/kernel/cpu/intel.c           |   10 ++---
 linux-2.6.11-root/arch/i386/kernel/cpu/intel_cacheinfo.c |    4 +-
 linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/mce.c      |    4 +-
 linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/p4.c       |    4 +-
 linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/p5.c       |    2 -
 linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/p6.c       |    2 -
 linux-2.6.11-root/arch/i386/kernel/process.c             |    2 -
 linux-2.6.11-root/arch/i386/kernel/smpboot.c             |   18 ++++-----
 linux-2.6.11-root/arch/i386/kernel/timers/timer_tsc.c    |    2 -
 11 files changed, 46 insertions(+), 46 deletions(-)

diff -puN arch/i386/kernel/process.c~init_call_cleanup arch/i386/kernel/process.c
--- linux-2.6.11/arch/i386/kernel/process.c~init_call_cleanup	2005-03-31 10:48:40.721107104 +0800
+++ linux-2.6.11-root/arch/i386/kernel/process.c	2005-03-31 10:48:40.745103456 +0800
@@ -242,7 +242,7 @@ static void mwait_idle(void)
 	}
 }
 
-void __init select_idle_routine(const struct cpuinfo_x86 *c)
+void __devinit select_idle_routine(const struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_MWAIT)) {
 		printk("monitor/mwait feature present.\n");
diff -puN arch/i386/kernel/smpboot.c~init_call_cleanup arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c~init_call_cleanup	2005-03-31 10:48:40.722106952 +0800
+++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-03-31 10:48:40.746103304 +0800
@@ -59,7 +59,7 @@
 #include <smpboot_hooks.h>
 
 /* Set if we find a B stepping CPU */
-static int __initdata smp_b_stepping;
+static int __devinitdata smp_b_stepping;
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
@@ -103,7 +103,7 @@ DEFINE_PER_CPU(int, cpu_state) = { 0 };
  * has made sure it's suitably aligned.
  */
 
-static unsigned long __init setup_trampoline(void)
+static unsigned long __devinit setup_trampoline(void)
 {
 	memcpy(trampoline_base, trampoline_data, trampoline_end - trampoline_data);
 	return virt_to_phys(trampoline_base);
@@ -133,7 +133,7 @@ void __init smp_alloc_memory(void)
  * a given CPU
  */
 
-static void __init smp_store_cpu_info(int id)
+static void __devinit smp_store_cpu_info(int id)
 {
 	struct cpuinfo_x86 *c = cpu_data + id;
 
@@ -327,7 +327,7 @@ extern void calibrate_delay(void);
 
 static atomic_t init_deasserted;
 
-static void __init smp_callin(void)
+static void __devinit smp_callin(void)
 {
 	int cpuid, phys_id;
 	unsigned long timeout;
@@ -423,7 +423,7 @@ extern void enable_sep_cpu(void *);
 /*
  * Activate a secondary processor.
  */
-static void __init start_secondary(void *unused)
+static void __devinit start_secondary(void *unused)
 {
 	int siblings = 0;
 	int i;
@@ -486,7 +486,7 @@ static void __init start_secondary(void 
  * from the task structure
  * This function must not return.
  */
-void __init initialize_secondary(void)
+void __devinit initialize_secondary(void)
 {
 	/*
 	 * We don't actually need to load the full TSS,
@@ -600,7 +600,7 @@ static inline void __inquire_remote_apic
  * INIT, INIT, STARTUP sequence will reset the chip hard for us, and this
  * won't ... remember to clear down the APIC, etc later.
  */
-static int __init
+static int __devinit
 wakeup_secondary_cpu(int logical_apicid, unsigned long start_eip)
 {
 	unsigned long send_status = 0, accept_status = 0;
@@ -646,7 +646,7 @@ wakeup_secondary_cpu(int logical_apicid,
 #endif	/* WAKE_SECONDARY_VIA_NMI */
 
 #ifdef WAKE_SECONDARY_VIA_INIT
-static int __init
+static int __devinit
 wakeup_secondary_cpu(int phys_apicid, unsigned long start_eip)
 {
 	unsigned long send_status = 0, accept_status = 0;
@@ -782,7 +782,7 @@ wakeup_secondary_cpu(int phys_apicid, un
 
 extern cpumask_t cpu_initialized;
 
-static int __init do_boot_cpu(int apicid)
+static int __devinit do_boot_cpu(int apicid)
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
diff -puN arch/i386/kernel/cpu/common.c~init_call_cleanup arch/i386/kernel/cpu/common.c
--- linux-2.6.11/arch/i386/kernel/cpu/common.c~init_call_cleanup	2005-03-31 10:48:40.724106648 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/common.c	2005-03-31 10:48:40.747103152 +0800
@@ -21,9 +21,9 @@
 DEFINE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
 EXPORT_PER_CPU_SYMBOL(cpu_gdt_table);
 
-static int cachesize_override __initdata = -1;
-static int disable_x86_fxsr __initdata = 0;
-static int disable_x86_serial_nr __initdata = 1;
+static int cachesize_override __devinitdata = -1;
+static int disable_x86_fxsr __devinitdata = 0;
+static int disable_x86_serial_nr __devinitdata = 1;
 
 struct cpu_dev * cpu_devs[X86_VENDOR_NUM] = {};
 
@@ -56,7 +56,7 @@ static int __init cachesize_setup(char *
 }
 __setup("cachesize=", cachesize_setup);
 
-int __init get_model_name(struct cpuinfo_x86 *c)
+int __devinit get_model_name(struct cpuinfo_x86 *c)
 {
 	unsigned int *v;
 	char *p, *q;
@@ -86,7 +86,7 @@ int __init get_model_name(struct cpuinfo
 }
 
 
-void __init display_cacheinfo(struct cpuinfo_x86 *c)
+void __devinit display_cacheinfo(struct cpuinfo_x86 *c)
 {
 	unsigned int n, dummy, ecx, edx, l2size;
 
@@ -127,7 +127,7 @@ void __init display_cacheinfo(struct cpu
 /* in particular, if CPUID levels 0x80000002..4 are supported, this isn't used */
 
 /* Look up CPU names by table lookup. */
-static char __init *table_lookup_model(struct cpuinfo_x86 *c)
+static char __devinit *table_lookup_model(struct cpuinfo_x86 *c)
 {
 	struct cpu_model_info *info;
 
@@ -148,7 +148,7 @@ static char __init *table_lookup_model(s
 }
 
 
-void __init get_cpu_vendor(struct cpuinfo_x86 *c, int early)
+void __devinit get_cpu_vendor(struct cpuinfo_x86 *c, int early)
 {
 	char *v = c->x86_vendor_id;
 	int i;
@@ -199,7 +199,7 @@ static inline int flag_is_changeable_p(u
 
 
 /* Probe for the CPUID instruction */
-static int __init have_cpuid_p(void)
+static int __devinit have_cpuid_p(void)
 {
 	return flag_is_changeable_p(X86_EFLAGS_ID);
 }
@@ -242,7 +242,7 @@ static void __init early_cpu_detect(void
 	early_intel_workaround(c);
 }
 
-void __init generic_identify(struct cpuinfo_x86 * c)
+void __devinit generic_identify(struct cpuinfo_x86 * c)
 {
 	u32 tfms, xlvl;
 	int junk;
@@ -289,7 +289,7 @@ void __init generic_identify(struct cpui
 	}
 }
 
-static void __init squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
+static void __devinit squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_PN) && disable_x86_serial_nr ) {
 		/* Disable processor serial number */
@@ -317,7 +317,7 @@ __setup("serialnumber", x86_serial_nr_se
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
-void __init identify_cpu(struct cpuinfo_x86 *c)
+void __devinit identify_cpu(struct cpuinfo_x86 *c)
 {
 	int i;
 
@@ -428,7 +428,7 @@ void __init identify_cpu(struct cpuinfo_
 }
 
 #ifdef CONFIG_X86_HT
-void __init detect_ht(struct cpuinfo_x86 *c)
+void __devinit detect_ht(struct cpuinfo_x86 *c)
 {
 	u32 	eax, ebx, ecx, edx;
 	int 	index_lsb, index_msb, tmp;
@@ -471,7 +471,7 @@ void __init detect_ht(struct cpuinfo_x86
 }
 #endif
 
-void __init print_cpu_info(struct cpuinfo_x86 *c)
+void __devinit print_cpu_info(struct cpuinfo_x86 *c)
 {
 	char *vendor = NULL;
 
@@ -494,7 +494,7 @@ void __init print_cpu_info(struct cpuinf
 		printk("\n");
 }
 
-cpumask_t cpu_initialized __initdata = CPU_MASK_NONE;
+cpumask_t cpu_initialized __devinitdata = CPU_MASK_NONE;
 
 /* This is hacky. :)
  * We're emulating future behavior.
@@ -541,7 +541,7 @@ void __init early_cpu_init(void)
  * and IDT. We reload them nevertheless, this function acts as a
  * 'CPU state barrier', nothing should get across.
  */
-void __init cpu_init (void)
+void __devinit cpu_init (void)
 {
 	int cpu = smp_processor_id();
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
diff -puN arch/i386/kernel/timers/timer_tsc.c~init_call_cleanup arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.11/arch/i386/kernel/timers/timer_tsc.c~init_call_cleanup	2005-03-31 10:48:40.725106496 +0800
+++ linux-2.6.11-root/arch/i386/kernel/timers/timer_tsc.c	2005-03-31 10:48:40.747103152 +0800
@@ -33,7 +33,7 @@ static struct timer_opts timer_tsc;
 
 static inline void cpufreq_delayed_get(void);
 
-int tsc_disable __initdata = 0;
+int tsc_disable __devinitdata = 0;
 
 extern spinlock_t i8253_lock;
 
diff -puN arch/i386/kernel/apic.c~init_call_cleanup arch/i386/kernel/apic.c
--- linux-2.6.11/arch/i386/kernel/apic.c~init_call_cleanup	2005-03-31 10:48:40.727106192 +0800
+++ linux-2.6.11-root/arch/i386/kernel/apic.c	2005-03-31 10:48:40.748103000 +0800
@@ -364,7 +364,7 @@ void __init init_bsp_APIC(void)
 	apic_write_around(APIC_LVT1, value);
 }
 
-void __init setup_local_APIC (void)
+void __devinit setup_local_APIC (void)
 {
 	unsigned long oldvalue, value, ver, maxlvt;
 
@@ -635,7 +635,7 @@ static struct sys_device device_lapic = 
 	.cls	= &lapic_sysclass,
 };
 
-static void __init apic_pm_activate(void)
+static void __devinit apic_pm_activate(void)
 {
 	apic_pm_state.active = 1;
 }
@@ -856,7 +856,7 @@ fake_ioapic_page:
  * but we do not accept timer interrupts yet. We only allow the BP
  * to calibrate.
  */
-static unsigned int __init get_8254_timer_count(void)
+static unsigned int __devinit get_8254_timer_count(void)
 {
 	extern spinlock_t i8253_lock;
 	unsigned long flags;
@@ -875,7 +875,7 @@ static unsigned int __init get_8254_time
 }
 
 /* next tick in 8254 can be caught by catching timer wraparound */
-static void __init wait_8254_wraparound(void)
+static void __devinit wait_8254_wraparound(void)
 {
 	unsigned int curr_count, prev_count;
 
@@ -895,7 +895,7 @@ static void __init wait_8254_wraparound(
  * Default initialization for 8254 timers. If we use other timers like HPET,
  * we override this later
  */
-void (*wait_timer_tick)(void) __initdata = wait_8254_wraparound;
+void (*wait_timer_tick)(void) __devinitdata = wait_8254_wraparound;
 
 /*
  * This function sets up the local APIC timer, with a timeout of
@@ -931,7 +931,7 @@ static void __setup_APIC_LVTT(unsigned i
 	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
 }
 
-static void __init setup_APIC_timer(unsigned int clocks)
+static void __devinit setup_APIC_timer(unsigned int clocks)
 {
 	unsigned long flags;
 
@@ -1044,7 +1044,7 @@ void __init setup_boot_APIC_clock(void)
 	local_irq_enable();
 }
 
-void __init setup_secondary_APIC_clock(void)
+void __devinit setup_secondary_APIC_clock(void)
 {
 	setup_APIC_timer(calibration_result);
 }
diff -puN arch/i386/kernel/cpu/intel.c~init_call_cleanup arch/i386/kernel/cpu/intel.c
--- linux-2.6.11/arch/i386/kernel/cpu/intel.c~init_call_cleanup	2005-03-31 10:48:40.729105888 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/intel.c	2005-03-31 10:48:40.748103000 +0800
@@ -28,7 +28,7 @@ extern int trap_init_f00f_bug(void);
 struct movsl_mask movsl_mask;
 #endif
 
-void __init early_intel_workaround(struct cpuinfo_x86 *c)
+void __devinit early_intel_workaround(struct cpuinfo_x86 *c)
 {
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return;
@@ -43,7 +43,7 @@ void __init early_intel_workaround(struc
  *	This is called before we do cpu ident work
  */
  
-int __init ppro_with_ram_bug(void)
+int __devinit ppro_with_ram_bug(void)
 {
 	/* Uses data from early_cpu_detect now */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
@@ -61,7 +61,7 @@ int __init ppro_with_ram_bug(void)
  * P4 Xeon errata 037 workaround.
  * Hardware prefetcher may cause stale data to be loaded into the cache.
  */
-static void __init Intel_errata_workarounds(struct cpuinfo_x86 *c)
+static void __devinit Intel_errata_workarounds(struct cpuinfo_x86 *c)
 {
 	unsigned long lo, hi;
 
@@ -77,7 +77,7 @@ static void __init Intel_errata_workarou
 }
 
 
-static void __init init_intel(struct cpuinfo_x86 *c)
+static void __devinit init_intel(struct cpuinfo_x86 *c)
 {
 	unsigned int l2 = 0;
 	char *p = NULL;
@@ -181,7 +181,7 @@ static unsigned int intel_size_cache(str
 	return size;
 }
 
-static struct cpu_dev intel_cpu_dev __initdata = {
+static struct cpu_dev intel_cpu_dev __devinitdata = {
 	.c_vendor	= "Intel",
 	.c_ident 	= { "GenuineIntel" },
 	.c_models = {
diff -puN arch/i386/kernel/cpu/intel_cacheinfo.c~init_call_cleanup arch/i386/kernel/cpu/intel_cacheinfo.c
--- linux-2.6.11/arch/i386/kernel/cpu/intel_cacheinfo.c~init_call_cleanup	2005-03-31 10:48:40.730105736 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-03-31 10:48:40.748103000 +0800
@@ -15,7 +15,7 @@ struct _cache_table
 };
 
 /* all the cache descriptor types we care about (no TLB or trace cache entries) */
-static struct _cache_table cache_table[] __initdata =
+static struct _cache_table cache_table[] __devinitdata =
 {
 	{ 0x06, LVL_1_INST, 8 },	/* 4-way set assoc, 32 byte line size */
 	{ 0x08, LVL_1_INST, 16 },	/* 4-way set assoc, 32 byte line size */
@@ -58,7 +58,7 @@ static struct _cache_table cache_table[]
 	{ 0x00, 0, 0}
 };
 
-unsigned int __init init_intel_cacheinfo(struct cpuinfo_x86 *c)
+unsigned int __devinit init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
 
diff -puN arch/i386/kernel/cpu/mcheck/mce.c~init_call_cleanup arch/i386/kernel/cpu/mcheck/mce.c
--- linux-2.6.11/arch/i386/kernel/cpu/mcheck/mce.c~init_call_cleanup	2005-03-31 10:48:40.732105432 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/mce.c	2005-03-31 10:48:40.748103000 +0800
@@ -16,7 +16,7 @@
 
 #include "mce.h"
 
-int mce_disabled __initdata = 0;
+int mce_disabled __devinitdata = 0;
 int nr_mce_banks;
 
 EXPORT_SYMBOL_GPL(nr_mce_banks);	/* non-fatal.o */
@@ -31,7 +31,7 @@ static fastcall void unexpected_machine_
 void fastcall (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
 
 /* This has to be run for each processor */
-void __init mcheck_init(struct cpuinfo_x86 *c)
+void __devinit mcheck_init(struct cpuinfo_x86 *c)
 {
 	if (mce_disabled==1)
 		return;
diff -puN arch/i386/kernel/cpu/mcheck/p4.c~init_call_cleanup arch/i386/kernel/cpu/mcheck/p4.c
--- linux-2.6.11/arch/i386/kernel/cpu/mcheck/p4.c~init_call_cleanup	2005-03-31 10:48:40.733105280 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/p4.c	2005-03-31 10:48:40.749102848 +0800
@@ -78,7 +78,7 @@ fastcall void smp_thermal_interrupt(stru
 }
 
 /* P4/Xeon Thermal regulation detect and init */
-static void __init intel_init_thermal(struct cpuinfo_x86 *c)
+static void __devinit intel_init_thermal(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	unsigned int cpu = smp_processor_id();
@@ -232,7 +232,7 @@ static fastcall void intel_machine_check
 }
 
 
-void __init intel_p4_mcheck_init(struct cpuinfo_x86 *c)
+void __devinit intel_p4_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int i;
diff -puN arch/i386/kernel/cpu/mcheck/p5.c~init_call_cleanup arch/i386/kernel/cpu/mcheck/p5.c
--- linux-2.6.11/arch/i386/kernel/cpu/mcheck/p5.c~init_call_cleanup	2005-03-31 10:48:40.735104976 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/p5.c	2005-03-31 10:48:40.749102848 +0800
@@ -29,7 +29,7 @@ static fastcall void pentium_machine_che
 }
 
 /* Set up machine check reporting for processors with Intel style MCE */
-void __init intel_p5_mcheck_init(struct cpuinfo_x86 *c)
+void __devinit intel_p5_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	
diff -puN arch/i386/kernel/cpu/mcheck/p6.c~init_call_cleanup arch/i386/kernel/cpu/mcheck/p6.c
--- linux-2.6.11/arch/i386/kernel/cpu/mcheck/p6.c~init_call_cleanup	2005-03-31 10:48:40.736104824 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/p6.c	2005-03-31 10:48:40.749102848 +0800
@@ -80,7 +80,7 @@ static fastcall void intel_machine_check
 }
 
 /* Set up machine check reporting for processors with Intel style MCE */
-void __init intel_p6_mcheck_init(struct cpuinfo_x86 *c)
+void __devinit intel_p6_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int i;
_


