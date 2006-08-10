Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWHJUY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWHJUY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWHJUPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:21 -0400
Received: from ns2.suse.de ([195.135.220.15]:31979 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932575AbWHJTgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:05 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [46/145] x86_64: Remove all ifdefs for local/io apic
Message-Id: <20060810193600.A867713B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:00 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

IO-APIC or local APIC can only be disabled at runtime anyways and
Kconfig has forced these options on for a long time now.

The Kconfigs are kept only now for the benefit of the shared acpi
boot.c code.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/Makefile  |    4 ++--
 arch/x86_64/kernel/apic.c    |    6 +-----
 arch/x86_64/kernel/crash.c   |    2 --
 arch/x86_64/kernel/entry.S   |    2 --
 arch/x86_64/kernel/head64.c  |    2 --
 arch/x86_64/kernel/i8259.c   |    9 ---------
 arch/x86_64/kernel/irq.c     |    6 ------
 arch/x86_64/kernel/mpparse.c |    9 ---------
 arch/x86_64/kernel/setup.c   |    6 ------
 arch/x86_64/kernel/smpboot.c |    5 -----
 arch/x86_64/kernel/time.c    |    8 --------
 arch/x86_64/kernel/traps.c   |    2 --
 include/asm-x86_64/apic.h    |    4 ----
 include/asm-x86_64/fixmap.h  |    4 ----
 include/asm-x86_64/io_apic.h |    6 ------
 include/asm-x86_64/irq.h     |    2 --
 include/asm-x86_64/mpspec.h  |    2 --
 include/asm-x86_64/smp.h     |    4 ----
 18 files changed, 3 insertions(+), 80 deletions(-)

Index: linux/arch/x86_64/kernel/Makefile
===================================================================
--- linux.orig/arch/x86_64/kernel/Makefile
+++ linux/arch/x86_64/kernel/Makefile
@@ -20,8 +20,8 @@ obj-$(CONFIG_X86_MSR)		+= msr.o
 obj-$(CONFIG_MICROCODE)		+= microcode.o
 obj-$(CONFIG_X86_CPUID)		+= cpuid.o
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o trampoline.o
-obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o  nmi.o
-obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o \
+obj-y				+= apic.o  nmi.o
+obj-y				+= io_apic.o mpparse.o \
 		genapic.o genapic_cluster.o genapic_flat.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
Index: linux/arch/x86_64/kernel/apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/apic.c
+++ linux/arch/x86_64/kernel/apic.c
@@ -661,7 +661,6 @@ void __init init_apic_mappings(void)
 	 */
 	boot_cpu_id = GET_APIC_ID(apic_read(APIC_ID));
 
-#ifdef CONFIG_X86_IO_APIC
 	{
 		unsigned long ioapic_phys, idx = FIX_IO_APIC_BASE_0;
 		int i;
@@ -679,7 +678,6 @@ void __init init_apic_mappings(void)
 			idx++;
 		}
 	}
-#endif
 }
 
 /*
@@ -1129,12 +1127,10 @@ int __init APIC_init_uniprocessor (void)
 
 	setup_local_APIC();
 
-#ifdef CONFIG_X86_IO_APIC
 	if (smp_found_config && !skip_ioapic_setup && nr_ioapics)
-			setup_IO_APIC();
+		setup_IO_APIC();
 	else
 		nr_ioapics = 0;
-#endif
 	setup_boot_APIC_clock();
 	check_nmi_watchdog();
 	return 0;
Index: linux/arch/x86_64/kernel/crash.c
===================================================================
--- linux.orig/arch/x86_64/kernel/crash.c
+++ linux/arch/x86_64/kernel/crash.c
@@ -194,9 +194,7 @@ void machine_crash_shutdown(struct pt_re
 	if(cpu_has_apic)
 		 disable_local_APIC();
 
-#if defined(CONFIG_X86_IO_APIC)
 	disable_IO_APIC();
-#endif
 
 	crash_save_self(regs);
 }
Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -676,7 +676,6 @@ ENTRY(call_function_interrupt)
 END(call_function_interrupt)
 #endif
 
-#ifdef CONFIG_X86_LOCAL_APIC	
 ENTRY(apic_timer_interrupt)
 	apicinterrupt LOCAL_TIMER_VECTOR,smp_apic_timer_interrupt
 END(apic_timer_interrupt)
@@ -688,7 +687,6 @@ END(error_interrupt)
 ENTRY(spurious_interrupt)
 	apicinterrupt SPURIOUS_APIC_VECTOR,smp_spurious_interrupt
 END(spurious_interrupt)
-#endif
 				
 /*
  * Exception entry points.
Index: linux/arch/x86_64/kernel/head64.c
===================================================================
--- linux.orig/arch/x86_64/kernel/head64.c
+++ linux/arch/x86_64/kernel/head64.c
@@ -111,10 +111,8 @@ void __init x86_64_start_kernel(char * r
 	if (s != NULL)
 		numa_setup(s+5);
 #endif
-#ifdef CONFIG_X86_IO_APIC
 	if (strstr(saved_command_line, "disableapic"))
 		disable_apic = 1;
-#endif
 	/* You need early console to see that */
 	if (__pa_symbol(&_end) >= KERNEL_TEXT_SIZE)
 		panic("Kernel too big for kernel mapping\n");
Index: linux/arch/x86_64/kernel/i8259.c
===================================================================
--- linux.orig/arch/x86_64/kernel/i8259.c
+++ linux/arch/x86_64/kernel/i8259.c
@@ -55,7 +55,6 @@
  */
 BUILD_16_IRQS(0x0)
 
-#ifdef CONFIG_X86_LOCAL_APIC
 /*
  * The IO-APIC gives us many more interrupt sources. Most of these 
  * are unused but an SMP system is supposed to have enough memory ...
@@ -75,8 +74,6 @@ BUILD_16_IRQS(0xc) BUILD_16_IRQS(0xd)
 	BUILD_15_IRQS(0xe)
 #endif
 
-#endif
-
 #undef BUILD_16_IRQS
 #undef BUILD_15_IRQS
 #undef BI
@@ -100,7 +97,6 @@ BUILD_16_IRQS(0xc) BUILD_16_IRQS(0xd)
 void (*interrupt[NR_IRQS])(void) = {
 	IRQLIST_16(0x0),
 
-#ifdef CONFIG_X86_IO_APIC
 			 IRQLIST_16(0x1), IRQLIST_16(0x2), IRQLIST_16(0x3),
 	IRQLIST_16(0x4), IRQLIST_16(0x5), IRQLIST_16(0x6), IRQLIST_16(0x7),
 	IRQLIST_16(0x8), IRQLIST_16(0x9), IRQLIST_16(0xa), IRQLIST_16(0xb),
@@ -110,7 +106,6 @@ void (*interrupt[NR_IRQS])(void) = {
 	, IRQLIST_15(0xe)
 #endif
 
-#endif
 };
 
 #undef IRQ
@@ -453,9 +448,7 @@ void __init init_ISA_irqs (void)
 {
 	int i;
 
-#ifdef CONFIG_X86_LOCAL_APIC
 	init_bsp_APIC();
-#endif
 	init_8259A(0);
 
 	for (i = 0; i < NR_IRQS; i++) {
@@ -581,14 +574,12 @@ void __init init_IRQ(void)
 	set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
 	set_intr_gate(THRESHOLD_APIC_VECTOR, threshold_interrupt);
 
-#ifdef CONFIG_X86_LOCAL_APIC
 	/* self generated IPI for local APIC timer */
 	set_intr_gate(LOCAL_TIMER_VECTOR, apic_timer_interrupt);
 
 	/* IPI vectors for APIC spurious and error interrupts */
 	set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
 	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
-#endif
 
 	/*
 	 * Set the clock to HZ Hz, we already have a valid
Index: linux/arch/x86_64/kernel/irq.c
===================================================================
--- linux.orig/arch/x86_64/kernel/irq.c
+++ linux/arch/x86_64/kernel/irq.c
@@ -20,11 +20,9 @@
 #include <asm/idle.h>
 
 atomic_t irq_err_count;
-#ifdef CONFIG_X86_IO_APIC
 #ifdef APIC_MISMATCH_DEBUG
 atomic_t irq_mis_count;
 #endif
-#endif
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 /*
@@ -92,18 +90,14 @@ skip:
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", cpu_pda(j)->__nmi_count);
 		seq_putc(p, '\n');
-#ifdef CONFIG_X86_LOCAL_APIC
 		seq_printf(p, "LOC: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", cpu_pda(j)->apic_timer_irqs);
 		seq_putc(p, '\n');
-#endif
 		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
-#ifdef CONFIG_X86_IO_APIC
 #ifdef APIC_MISMATCH_DEBUG
 		seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
 #endif
-#endif
 	}
 	return 0;
 }
Index: linux/arch/x86_64/kernel/mpparse.c
===================================================================
--- linux.orig/arch/x86_64/kernel/mpparse.c
+++ linux/arch/x86_64/kernel/mpparse.c
@@ -74,14 +74,10 @@ physid_mask_t phys_cpu_present_map = PHY
 /* ACPI MADT entry parsing functions */
 #ifdef CONFIG_ACPI
 extern struct acpi_boot_flags acpi_boot;
-#ifdef CONFIG_X86_LOCAL_APIC
 extern int acpi_parse_lapic (acpi_table_entry_header *header);
 extern int acpi_parse_lapic_addr_ovr (acpi_table_entry_header *header);
 extern int acpi_parse_lapic_nmi (acpi_table_entry_header *header);
-#endif /*CONFIG_X86_LOCAL_APIC*/
-#ifdef CONFIG_X86_IO_APIC
 extern int acpi_parse_ioapic (acpi_table_entry_header *header);
-#endif /*CONFIG_X86_IO_APIC*/
 #endif /*CONFIG_ACPI*/
 
 u8 bios_cpu_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
@@ -661,9 +657,7 @@ void __init find_intel_smp (void)
  */
 void __init find_smp_config (void)
 {
-#ifdef CONFIG_X86_LOCAL_APIC
 	find_intel_smp();
-#endif
 }
 
 
@@ -717,8 +711,6 @@ void __cpuinit mp_register_lapic (
 	MP_processor_info(&processor);
 }
 
-#ifdef CONFIG_X86_IO_APIC
-
 #define MP_ISA_BUS		0
 #define MP_MAX_IOAPIC_PIN	127
 
@@ -997,5 +989,4 @@ int mp_register_gsi(u32 gsi, int trigger
 	return gsi;
 }
 
-#endif /*CONFIG_X86_IO_APIC*/
 #endif /*CONFIG_ACPI*/
Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -340,11 +340,9 @@ static __init void parse_cmdline_early (
 		else if (fullarg(from, "acpi=strict")) {
 			acpi_strict = 1;
 		}
-#ifdef CONFIG_X86_IO_APIC
 		else if (fullarg(from, "acpi_skip_timer_override"))
 			acpi_skip_timer_override = 1;
 #endif
-#endif
 
 		if (fullarg(from, "disable_timer_pin_1"))
 			disable_timer_pin_1 = 1;
@@ -627,12 +625,10 @@ void __init setup_arch(char **cmdline_p)
         */
        acpi_reserve_bootmem();
 #endif
-#ifdef CONFIG_X86_LOCAL_APIC
 	/*
 	 * Find and reserve possible boot-time SMP configuration:
 	 */
 	find_smp_config();
-#endif
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (end_pfn << PAGE_SHIFT)) {
@@ -676,14 +672,12 @@ void __init setup_arch(char **cmdline_p)
 
 	init_cpu_to_node();
 
-#ifdef CONFIG_X86_LOCAL_APIC
 	/*
 	 * get boot-time SMP configuration:
 	 */
 	if (smp_found_config)
 		get_smp_config();
 	init_apic_mappings();
-#endif
 
 	/*
 	 * Request address space for all standard RAM and ROM resources
Index: linux/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smpboot.c
+++ linux/arch/x86_64/kernel/smpboot.c
@@ -1175,13 +1175,8 @@ int __cpuinit __cpu_up(unsigned int cpu)
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	smp_cleanup_boot();
-
-#ifdef CONFIG_X86_IO_APIC
 	setup_ioapic_dest();
-#endif
-
 	check_nmi_watchdog();
-
 	time_init_gtod();
 }
 
Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c
+++ linux/arch/x86_64/kernel/time.c
@@ -41,9 +41,7 @@
 #include <asm/sections.h>
 #include <linux/cpufreq.h>
 #include <linux/hpet.h>
-#ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/apic.h>
-#endif
 
 #ifdef CONFIG_CPU_FREQ
 static void cpufreq_delayed_get(void);
@@ -438,12 +436,8 @@ void main_timer_handler(struct pt_regs *
  * have to call the local interrupt handler.
  */
 
-#ifndef CONFIG_X86_LOCAL_APIC
-	profile_tick(CPU_PROFILING, regs);
-#else
 	if (!using_apic_timer)
 		smp_local_timer_interrupt(regs);
-#endif
 
 /*
  * If we have an externally synchronized Linux clock, then update CMOS clock
@@ -467,10 +461,8 @@ static irqreturn_t timer_interrupt(int i
 	if (apic_runs_main_timer > 1)
 		return IRQ_HANDLED;
 	main_timer_handler(regs);
-#ifdef CONFIG_X86_LOCAL_APIC
 	if (using_apic_timer)
 		smp_send_timer_broadcast_ipi();
-#endif
 	return IRQ_HANDLED;
 }
 
Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -784,7 +784,6 @@ asmlinkage __kprobes void default_do_nmi
 		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 2, SIGINT)
 								== NOTIFY_STOP)
 			return;
-#ifdef CONFIG_X86_LOCAL_APIC
 		/*
 		 * Ok, so this is none of the documented NMI sources,
 		 * so it must be the NMI watchdog.
@@ -792,7 +791,6 @@ asmlinkage __kprobes void default_do_nmi
 		if (nmi_watchdog_tick(regs,reason))
 			return;
 		if (!do_nmi_callback(regs,cpu))
-#endif
 			unknown_nmi_error(reason, regs);
 
 		return;
Index: linux/include/asm-x86_64/apic.h
===================================================================
--- linux.orig/include/asm-x86_64/apic.h
+++ linux/include/asm-x86_64/apic.h
@@ -29,8 +29,6 @@ extern int apic_runs_main_timer;
 			printk(s, ##a);    \
 	} while (0)
 
-#ifdef CONFIG_X86_LOCAL_APIC
-
 struct pt_regs;
 
 /*
@@ -104,8 +102,6 @@ void switch_ipi_to_APIC_timer(void *cpum
 
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
-#endif /* CONFIG_X86_LOCAL_APIC */
-
 extern unsigned boot_cpu_id;
 
 #endif /* __ASM_APIC_H */
Index: linux/include/asm-x86_64/fixmap.h
===================================================================
--- linux.orig/include/asm-x86_64/fixmap.h
+++ linux/include/asm-x86_64/fixmap.h
@@ -37,13 +37,9 @@ enum fixed_addresses {
 	VSYSCALL_FIRST_PAGE = VSYSCALL_LAST_PAGE + ((VSYSCALL_END-VSYSCALL_START) >> PAGE_SHIFT) - 1,
 	VSYSCALL_HPET,
 	FIX_HPET_BASE,
-#ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
-#endif
-#ifdef CONFIG_X86_IO_APIC
 	FIX_IO_APIC_BASE_0,
 	FIX_IO_APIC_BASE_END = FIX_IO_APIC_BASE_0 + MAX_IO_APICS-1,
-#endif
 	__end_of_fixed_addresses
 };
 
Index: linux/include/asm-x86_64/io_apic.h
===================================================================
--- linux.orig/include/asm-x86_64/io_apic.h
+++ linux/include/asm-x86_64/io_apic.h
@@ -10,8 +10,6 @@
  * Copyright (C) 1997, 1998, 1999, 2000 Ingo Molnar
  */
 
-#ifdef CONFIG_X86_IO_APIC
-
 #ifdef CONFIG_PCI_MSI
 static inline int use_pci_vector(void)	{return 1;}
 static inline void disable_edge_ioapic_vector(unsigned int vector) { }
@@ -209,10 +207,6 @@ extern int timer_uses_ioapic_pin_0;
 
 extern int sis_apic_bug; /* dummy */ 
 
-#else  /* !CONFIG_X86_IO_APIC */
-#define io_apic_assign_pci_irqs 0
-#endif
-
 extern int assign_irq_vector(int irq);
 
 void enable_NMI_through_LVT0 (void * dummy);
Index: linux/include/asm-x86_64/irq.h
===================================================================
--- linux.orig/include/asm-x86_64/irq.h
+++ linux/include/asm-x86_64/irq.h
@@ -44,9 +44,7 @@ static __inline__ int irq_canonicalize(i
 	return ((irq == 2) ? 9 : irq);
 }
 
-#ifdef CONFIG_X86_LOCAL_APIC
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
-#endif
 
 #ifdef CONFIG_HOTPLUG_CPU
 #include <linux/cpumask.h>
Index: linux/include/asm-x86_64/mpspec.h
===================================================================
--- linux.orig/include/asm-x86_64/mpspec.h
+++ linux/include/asm-x86_64/mpspec.h
@@ -184,12 +184,10 @@ extern int pic_mode;
 extern void mp_register_lapic (u8 id, u8 enabled);
 extern void mp_register_lapic_address (u64 address);
 
-#ifdef CONFIG_X86_IO_APIC
 extern void mp_register_ioapic (u8 id, u32 address, u32 gsi_base);
 extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 gsi);
 extern void mp_config_acpi_legacy_irqs (void);
 extern int mp_register_gsi (u32 gsi, int triggering, int polarity);
-#endif /*CONFIG_X86_IO_APIC*/
 #endif
 
 extern int using_apic_timer;
Index: linux/include/asm-x86_64/smp.h
===================================================================
--- linux.orig/include/asm-x86_64/smp.h
+++ linux/include/asm-x86_64/smp.h
@@ -9,15 +9,11 @@
 #include <linux/bitops.h>
 extern int disable_apic;
 
-#ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/fixmap.h>
 #include <asm/mpspec.h>
-#ifdef CONFIG_X86_IO_APIC
 #include <asm/io_apic.h>
-#endif
 #include <asm/apic.h>
 #include <asm/thread_info.h>
-#endif
 
 #ifdef CONFIG_SMP
 
