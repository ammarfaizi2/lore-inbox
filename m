Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWHJTfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWHJTfS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWHJTfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:35:18 -0400
Received: from mail.suse.de ([195.135.220.2]:656 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932132AbWHJTfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:16 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [3/145] i386: Allow to use GENERICARCH for UP kernels
Message-Id: <20060810193515.0E65213B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:15 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

There are some machines around (large xSeries or Unisys ES7000) that
need physical IO-APIC destination mode to access all of their IO 
devices. This currently doesn't work in UP kernels as used in
distribution installers. 

This patch allows to compile even UP kernels as GENERICARCH which
allows to use physical or clustered APIC mode.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/Kconfig                        |    7 +--
 arch/i386/kernel/io_apic.c               |    1 
 arch/i386/kernel/mpparse.c               |    1 
 arch/i386/mach-generic/bigsmp.c          |    1 
 arch/i386/mach-generic/es7000.c          |    1 
 arch/i386/mach-generic/probe.c           |    2 
 arch/i386/mach-generic/summit.c          |    1 
 include/asm-i386/genapic.h               |   69 ++++++++++++++++++-------------
 include/asm-i386/mach-es7000/mach_apic.h |    4 +
 include/asm-i386/mach-summit/mach_apic.h |   11 ++++
 include/asm-i386/smp.h                   |   19 +++++---
 11 files changed, 76 insertions(+), 41 deletions(-)

Index: linux/arch/i386/mach-generic/probe.c
===================================================================
--- linux.orig/arch/i386/mach-generic/probe.c
+++ linux/arch/i386/mach-generic/probe.c
@@ -119,7 +119,9 @@ int __init acpi_madt_oem_check(char *oem
 	return 0;	
 }
 
+#ifdef CONFIG_SMP
 int hard_smp_processor_id(void)
 {
 	return genapic->get_apic_id(*(unsigned long *)(APIC_BASE+APIC_ID));
 }
+#endif
Index: linux/arch/i386/Kconfig
===================================================================
--- linux.orig/arch/i386/Kconfig
+++ linux/arch/i386/Kconfig
@@ -165,7 +165,6 @@ config X86_VISWS
 
 config X86_GENERICARCH
        bool "Generic architecture (Summit, bigsmp, ES7000, default)"
-       depends on SMP
        help
           This option compiles in the Summit, bigsmp, ES7000, default subarchitectures.
 	  It is intended for a generic binary kernel.
@@ -261,7 +260,7 @@ source "kernel/Kconfig.preempt"
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors"
-	depends on !SMP && !(X86_VISWS || X86_VOYAGER)
+	depends on !SMP && !(X86_VISWS || X86_VOYAGER || X86_GENERICARCH)
 	help
 	  A local APIC (Advanced Programmable Interrupt Controller) is an
 	  integrated interrupt controller in the CPU. If you have a single-CPU
@@ -286,12 +285,12 @@ config X86_UP_IOAPIC
 
 config X86_LOCAL_APIC
 	bool
-	depends on X86_UP_APIC || ((X86_VISWS || SMP) && !X86_VOYAGER)
+	depends on X86_UP_APIC || ((X86_VISWS || SMP) && !X86_VOYAGER) || X86_GENERICARCH
 	default y
 
 config X86_IO_APIC
 	bool
-	depends on X86_UP_IOAPIC || (SMP && !(X86_VISWS || X86_VOYAGER))
+	depends on X86_UP_IOAPIC || (SMP && !(X86_VISWS || X86_VOYAGER)) || X86_GENERICARCH
 	default y
 
 config X86_VISWS_APIC
Index: linux/arch/i386/mach-generic/bigsmp.c
===================================================================
--- linux.orig/arch/i386/mach-generic/bigsmp.c
+++ linux/arch/i386/mach-generic/bigsmp.c
@@ -5,6 +5,7 @@
 #define APIC_DEFINITION 1
 #include <linux/threads.h>
 #include <linux/cpumask.h>
+#include <asm/smp.h>
 #include <asm/mpspec.h>
 #include <asm/genapic.h>
 #include <asm/fixmap.h>
Index: linux/arch/i386/mach-generic/es7000.c
===================================================================
--- linux.orig/arch/i386/mach-generic/es7000.c
+++ linux/arch/i386/mach-generic/es7000.c
@@ -4,6 +4,7 @@
 #define APIC_DEFINITION 1
 #include <linux/threads.h>
 #include <linux/cpumask.h>
+#include <asm/smp.h>
 #include <asm/mpspec.h>
 #include <asm/genapic.h>
 #include <asm/fixmap.h>
Index: linux/arch/i386/mach-generic/summit.c
===================================================================
--- linux.orig/arch/i386/mach-generic/summit.c
+++ linux/arch/i386/mach-generic/summit.c
@@ -4,6 +4,7 @@
 #define APIC_DEFINITION 1
 #include <linux/threads.h>
 #include <linux/cpumask.h>
+#include <asm/smp.h>
 #include <asm/mpspec.h>
 #include <asm/genapic.h>
 #include <asm/fixmap.h>
Index: linux/include/asm-i386/genapic.h
===================================================================
--- linux.orig/include/asm-i386/genapic.h
+++ linux/include/asm-i386/genapic.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_GENAPIC_H
 #define _ASM_GENAPIC_H 1
 
+#include <asm/mpspec.h>
+
 /*
  * Generic APIC driver interface.
  *
@@ -63,14 +65,25 @@ struct genapic { 
 	unsigned (*get_apic_id)(unsigned long x);
 	unsigned long apic_id_mask;
 	unsigned int (*cpu_mask_to_apicid)(cpumask_t cpumask);
-	
+
+#ifdef CONFIG_SMP
 	/* ipi */
 	void (*send_IPI_mask)(cpumask_t mask, int vector);
 	void (*send_IPI_allbutself)(int vector);
 	void (*send_IPI_all)(int vector);
+#endif
 }; 
 
-#define APICFUNC(x) .x = x
+#define APICFUNC(x) .x = x,
+
+/* More functions could be probably marked IPIFUNC and save some space
+   in UP GENERICARCH kernels, but I don't have the nerve right now
+   to untangle this mess. -AK  */
+#ifdef CONFIG_SMP
+#define IPIFUNC(x) APICFUNC(x)
+#else
+#define IPIFUNC(x)
+#endif
 
 #define APIC_INIT(aname, aprobe) { \
 	.name = aname, \
@@ -80,33 +93,33 @@ struct genapic { 
 	.no_balance_irq = NO_BALANCE_IRQ, \
 	.ESR_DISABLE = esr_disable, \
 	.apic_destination_logical = APIC_DEST_LOGICAL, \
-	APICFUNC(apic_id_registered), \
-	APICFUNC(target_cpus), \
-	APICFUNC(check_apicid_used), \
-	APICFUNC(check_apicid_present), \
-	APICFUNC(init_apic_ldr), \
-	APICFUNC(ioapic_phys_id_map), \
-	APICFUNC(clustered_apic_check), \
-	APICFUNC(multi_timer_check), \
-	APICFUNC(apicid_to_node), \
-	APICFUNC(cpu_to_logical_apicid), \
-	APICFUNC(cpu_present_to_apicid), \
-	APICFUNC(apicid_to_cpu_present), \
-	APICFUNC(mpc_apic_id), \
-	APICFUNC(setup_portio_remap), \
-	APICFUNC(check_phys_apicid_present), \
-	APICFUNC(mpc_oem_bus_info), \
-	APICFUNC(mpc_oem_pci_bus), \
-	APICFUNC(mps_oem_check), \
-	APICFUNC(get_apic_id), \
+	APICFUNC(apic_id_registered) \
+	APICFUNC(target_cpus) \
+	APICFUNC(check_apicid_used) \
+	APICFUNC(check_apicid_present) \
+	APICFUNC(init_apic_ldr) \
+	APICFUNC(ioapic_phys_id_map) \
+	APICFUNC(clustered_apic_check) \
+	APICFUNC(multi_timer_check) \
+	APICFUNC(apicid_to_node) \
+	APICFUNC(cpu_to_logical_apicid) \
+	APICFUNC(cpu_present_to_apicid) \
+	APICFUNC(apicid_to_cpu_present) \
+	APICFUNC(mpc_apic_id) \
+	APICFUNC(setup_portio_remap) \
+	APICFUNC(check_phys_apicid_present) \
+	APICFUNC(mpc_oem_bus_info) \
+	APICFUNC(mpc_oem_pci_bus) \
+	APICFUNC(mps_oem_check) \
+	APICFUNC(get_apic_id) \
 	.apic_id_mask = APIC_ID_MASK, \
-	APICFUNC(cpu_mask_to_apicid), \
-	APICFUNC(acpi_madt_oem_check), \
-	APICFUNC(send_IPI_mask), \
-	APICFUNC(send_IPI_allbutself), \
-	APICFUNC(send_IPI_all), \
-	APICFUNC(enable_apic_mode), \
-	APICFUNC(phys_pkg_id), \
+	APICFUNC(cpu_mask_to_apicid) \
+	APICFUNC(acpi_madt_oem_check) \
+	IPIFUNC(send_IPI_mask) \
+	IPIFUNC(send_IPI_allbutself) \
+	IPIFUNC(send_IPI_all) \
+	APICFUNC(enable_apic_mode) \
+	APICFUNC(phys_pkg_id) \
 	}
 
 extern struct genapic *genapic;
Index: linux/include/asm-i386/mach-summit/mach_apic.h
===================================================================
--- linux.orig/include/asm-i386/mach-summit/mach_apic.h
+++ linux/include/asm-i386/mach-summit/mach_apic.h
@@ -46,10 +46,12 @@ extern u8 cpu_2_logical_apicid[];
 static inline void init_apic_ldr(void)
 {
 	unsigned long val, id;
-	int i, count;
-	u8 lid;
+	int count = 0;
 	u8 my_id = (u8)hard_smp_processor_id();
 	u8 my_cluster = (u8)apicid_cluster(my_id);
+#ifdef CONFIG_SMP
+	u8 lid;
+	int i;
 
 	/* Create logical APIC IDs by counting CPUs already in cluster. */
 	for (count = 0, i = NR_CPUS; --i >= 0; ) {
@@ -57,6 +59,7 @@ static inline void init_apic_ldr(void)
 		if (lid != BAD_APICID && apicid_cluster(lid) == my_cluster)
 			++count;
 	}
+#endif
 	/* We only have a 4 wide bitmap in cluster mode.  If a deranged
 	 * BIOS puts 5 CPUs in one APIC cluster, we're hosed. */
 	BUG_ON(count >= XAPIC_DEST_CPUS_SHIFT);
@@ -91,9 +94,13 @@ static inline int apicid_to_node(int log
 /* Mapping from cpu number to logical apicid */
 static inline int cpu_to_logical_apicid(int cpu)
 {
+#ifdef CONFIG_SMP
        if (cpu >= NR_CPUS)
 	       return BAD_APICID;
 	return (int)cpu_2_logical_apicid[cpu];
+#else
+	return logical_smp_processor_id();
+#endif
 }
 
 static inline int cpu_present_to_apicid(int mps_cpu)
Index: linux/include/asm-i386/mach-es7000/mach_apic.h
===================================================================
--- linux.orig/include/asm-i386/mach-es7000/mach_apic.h
+++ linux/include/asm-i386/mach-es7000/mach_apic.h
@@ -123,9 +123,13 @@ extern u8 cpu_2_logical_apicid[];
 /* Mapping from cpu number to logical apicid */
 static inline int cpu_to_logical_apicid(int cpu)
 {
+#ifdef CONFIG_SMP
        if (cpu >= NR_CPUS)
 	       return BAD_APICID;
        return (int)cpu_2_logical_apicid[cpu];
+#else
+	return logical_smp_processor_id();
+#endif
 }
 
 static inline int mpc_apic_id(struct mpc_config_processor *m, struct mpc_config_translation *unused)
Index: linux/arch/i386/kernel/io_apic.c
===================================================================
--- linux.orig/arch/i386/kernel/io_apic.c
+++ linux/arch/i386/kernel/io_apic.c
@@ -40,6 +40,7 @@
 #include <asm/nmi.h>
 
 #include <mach_apic.h>
+#include <mach_apicdef.h>
 
 #include "io_ports.h"
 
Index: linux/arch/i386/kernel/mpparse.c
===================================================================
--- linux.orig/arch/i386/kernel/mpparse.c
+++ linux/arch/i386/kernel/mpparse.c
@@ -30,6 +30,7 @@
 #include <asm/io_apic.h>
 
 #include <mach_apic.h>
+#include <mach_apicdef.h>
 #include <mach_mpparse.h>
 #include <bios_ebda.h>
 
Index: linux/include/asm-i386/smp.h
===================================================================
--- linux.orig/include/asm-i386/smp.h
+++ linux/include/asm-i386/smp.h
@@ -80,17 +80,11 @@ static inline int hard_smp_processor_id(
 	return GET_APIC_ID(*(unsigned long *)(APIC_BASE+APIC_ID));
 }
 #endif
-
-static __inline int logical_smp_processor_id(void)
-{
-	/* we don't want to mark this access volatile - bad code generation */
-	return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
-}
-
 #endif
 
 extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
+
 #endif /* !__ASSEMBLY__ */
 
 #else /* CONFIG_SMP */
@@ -100,4 +94,15 @@ extern void __cpu_die(unsigned int cpu);
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
 #endif
+
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_X86_LOCAL_APIC
+static __inline int logical_smp_processor_id(void)
+{
+	/* we don't want to mark this access volatile - bad code generation */
+	return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
+}
+#endif
+#endif
+
 #endif
