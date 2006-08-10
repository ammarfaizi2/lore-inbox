Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWHJUOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWHJUOe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWHJTfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:35:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:63978 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932146AbWHJTfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:18 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [4/145] x86_64: Temporarily revert parts of the Core 2 nmi nmi watchdog support
Message-Id: <20060810193516.1B75413B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:16 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

This makes merging easier.  They are readded a few patches later.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/nmi.c                  |   65 -------------------------
 arch/x86_64/kernel/nmi.c                |   81 +-------------------------------
 include/asm-i386/intel_arch_perfmon.h   |   19 -------
 include/asm-x86_64/intel_arch_perfmon.h |   19 -------
 4 files changed, 6 insertions(+), 178 deletions(-)

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -24,7 +24,6 @@
 
 #include <asm/smp.h>
 #include <asm/nmi.h>
-#include <asm/intel_arch_perfmon.h>
 
 #include "mach_traps.h"
 
@@ -96,9 +95,6 @@ int nmi_active;
 	(P4_CCCR_OVF_PMI0|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
 	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
 
-#define ARCH_PERFMON_NMI_EVENT_SEL	ARCH_PERFMON_UNHALTED_CORE_CYCLES_SEL
-#define ARCH_PERFMON_NMI_EVENT_UMASK	ARCH_PERFMON_UNHALTED_CORE_CYCLES_UMASK
-
 #ifdef CONFIG_SMP
 /* The performance counters used by NMI_LOCAL_APIC don't trigger when
  * the CPU is idle. To make sure the NMI watchdog really ticks on all
@@ -211,8 +207,6 @@ static int __init setup_nmi_watchdog(cha
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
-static void disable_intel_arch_watchdog(void);
-
 static void disable_lapic_nmi_watchdog(void)
 {
 	if (nmi_active <= 0)
@@ -222,10 +216,6 @@ static void disable_lapic_nmi_watchdog(v
 		wrmsr(MSR_K7_EVNTSEL0, 0, 0);
 		break;
 	case X86_VENDOR_INTEL:
-		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
-			disable_intel_arch_watchdog();
-			break;
-		}
 		switch (boot_cpu_data.x86) {
 		case 6:
 			if (boot_cpu_data.x86_model > 0xd)
@@ -454,53 +444,6 @@ static int setup_p4_watchdog(void)
 	return 1;
 }
 
-static void disable_intel_arch_watchdog(void)
-{
-	unsigned ebx;
-
-	/*
-	 * Check whether the Architectural PerfMon supports
-	 * Unhalted Core Cycles Event or not.
-	 * NOTE: Corresponding bit = 0 in ebp indicates event present.
-	 */
-	ebx = cpuid_ebx(10);
-	if (!(ebx & ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT))
-		wrmsr(MSR_ARCH_PERFMON_EVENTSEL0, 0, 0);
-}
-
-static int setup_intel_arch_watchdog(void)
-{
-	unsigned int evntsel;
-	unsigned ebx;
-
-	/*
-	 * Check whether the Architectural PerfMon supports
-	 * Unhalted Core Cycles Event or not.
-	 * NOTE: Corresponding bit = 0 in ebp indicates event present.
-	 */
-	ebx = cpuid_ebx(10);
-	if ((ebx & ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT))
-		return 0;
-
-	nmi_perfctr_msr = MSR_ARCH_PERFMON_PERFCTR0;
-
-	clear_msr_range(MSR_ARCH_PERFMON_EVENTSEL0, 2);
-	clear_msr_range(MSR_ARCH_PERFMON_PERFCTR0, 2);
-
-	evntsel = ARCH_PERFMON_EVENTSEL_INT
-		| ARCH_PERFMON_EVENTSEL_OS
-		| ARCH_PERFMON_EVENTSEL_USR
-		| ARCH_PERFMON_NMI_EVENT_SEL
-		| ARCH_PERFMON_NMI_EVENT_UMASK;
-
-	wrmsr(MSR_ARCH_PERFMON_EVENTSEL0, evntsel, 0);
-	write_watchdog_counter("INTEL_ARCH_PERFCTR0");
-	apic_write(APIC_LVTPC, APIC_DM_NMI);
-	evntsel |= ARCH_PERFMON_EVENTSEL0_ENABLE;
-	wrmsr(MSR_ARCH_PERFMON_EVENTSEL0, evntsel, 0);
-	return 1;
-}
-
 void setup_apic_nmi_watchdog (void)
 {
 	switch (boot_cpu_data.x86_vendor) {
@@ -510,11 +453,6 @@ void setup_apic_nmi_watchdog (void)
 		setup_k7_watchdog();
 		break;
 	case X86_VENDOR_INTEL:
-		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
-			if (!setup_intel_arch_watchdog())
-				return;
-			break;
-		}
 		switch (boot_cpu_data.x86) {
 		case 6:
 			if (boot_cpu_data.x86_model > 0xd)
@@ -619,8 +557,7 @@ void nmi_watchdog_tick (struct pt_regs *
 			wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
 			apic_write(APIC_LVTPC, APIC_DM_NMI);
 		}
-		else if (nmi_perfctr_msr == MSR_P6_PERFCTR0 ||
-		         nmi_perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0) {
+		else if (nmi_perfctr_msr == MSR_P6_PERFCTR0) {
 			/* Only P6 based Pentium M need to re-unmask
 			 * the apic vector but it doesn't hurt
 			 * other P6 variant */
Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -26,7 +26,6 @@
 #include <asm/proto.h>
 #include <asm/kdebug.h>
 #include <asm/mce.h>
-#include <asm/intel_arch_perfmon.h>
 
 /*
  * lapic_nmi_owner tracks the ownership of the lapic NMI hardware:
@@ -66,9 +65,6 @@ static unsigned int nmi_p4_cccr_val;
 #define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0x76
 #define K7_NMI_EVENT		K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING
 
-#define ARCH_PERFMON_NMI_EVENT_SEL	ARCH_PERFMON_UNHALTED_CORE_CYCLES_SEL
-#define ARCH_PERFMON_NMI_EVENT_UMASK	ARCH_PERFMON_UNHALTED_CORE_CYCLES_UMASK
-
 #define MSR_P4_MISC_ENABLE	0x1A0
 #define MSR_P4_MISC_ENABLE_PERF_AVAIL	(1<<7)
 #define MSR_P4_MISC_ENABLE_PEBS_UNAVAIL	(1<<12)
@@ -100,10 +96,7 @@ static __cpuinit inline int nmi_known_cp
 	case X86_VENDOR_AMD:
 		return boot_cpu_data.x86 == 15;
 	case X86_VENDOR_INTEL:
-		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON))
-			return 1;
-		else
-			return (boot_cpu_data.x86 == 15);
+		return boot_cpu_data.x86 == 15;
 	}
 	return 0;
 }
@@ -209,8 +202,6 @@ int __init setup_nmi_watchdog(char *str)
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
-static void disable_intel_arch_watchdog(void);
-
 static void disable_lapic_nmi_watchdog(void)
 {
 	if (nmi_active <= 0)
@@ -223,8 +214,6 @@ static void disable_lapic_nmi_watchdog(v
 		if (boot_cpu_data.x86 == 15) {
 			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
 			wrmsr(MSR_P4_CRU_ESCR0, 0, 0);
-		} else if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
-			disable_intel_arch_watchdog();
 		}
 		break;
 	}
@@ -377,53 +366,6 @@ static void setup_k7_watchdog(void)
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
 }
 
-static void disable_intel_arch_watchdog(void)
-{
-	unsigned ebx;
-
-	/*
-	 * Check whether the Architectural PerfMon supports
-	 * Unhalted Core Cycles Event or not.
-	 * NOTE: Corresponding bit = 0 in ebp indicates event present.
-	 */
-	ebx = cpuid_ebx(10);
-	if (!(ebx & ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT))
-		wrmsr(MSR_ARCH_PERFMON_EVENTSEL0, 0, 0);
-}
-
-static int setup_intel_arch_watchdog(void)
-{
-	unsigned int evntsel;
-	unsigned ebx;
-
-	/*
-	 * Check whether the Architectural PerfMon supports
-	 * Unhalted Core Cycles Event or not.
-	 * NOTE: Corresponding bit = 0 in ebp indicates event present.
-	 */
-	ebx = cpuid_ebx(10);
-	if ((ebx & ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT))
-		return 0;
-
-	nmi_perfctr_msr = MSR_ARCH_PERFMON_PERFCTR0;
-
-	clear_msr_range(MSR_ARCH_PERFMON_EVENTSEL0, 2);
-	clear_msr_range(MSR_ARCH_PERFMON_PERFCTR0, 2);
-
-	evntsel = ARCH_PERFMON_EVENTSEL_INT
-		| ARCH_PERFMON_EVENTSEL_OS
-		| ARCH_PERFMON_EVENTSEL_USR
-		| ARCH_PERFMON_NMI_EVENT_SEL
-		| ARCH_PERFMON_NMI_EVENT_UMASK;
-
-	wrmsr(MSR_ARCH_PERFMON_EVENTSEL0, evntsel, 0);
-	wrmsrl(MSR_ARCH_PERFMON_PERFCTR0, -((u64)cpu_khz * 1000 / nmi_hz));
-	apic_write(APIC_LVTPC, APIC_DM_NMI);
-	evntsel |= ARCH_PERFMON_EVENTSEL0_ENABLE;
-	wrmsr(MSR_ARCH_PERFMON_EVENTSEL0, evntsel, 0);
-	return 1;
-}
-
 
 static int setup_p4_watchdog(void)
 {
@@ -477,16 +419,10 @@ void setup_apic_nmi_watchdog(void)
 		setup_k7_watchdog();
 		break;
 	case X86_VENDOR_INTEL:
-		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
-			if (!setup_intel_arch_watchdog())
-				return;
-		} else if (boot_cpu_data.x86 == 15) {
-			if (!setup_p4_watchdog())
-				return;
-		} else {
+		if (boot_cpu_data.x86 != 15)
+			return;
+		if (!setup_p4_watchdog())
 			return;
-		}
-
 		break;
 
 	default:
@@ -571,14 +507,7 @@ void __kprobes nmi_watchdog_tick(struct 
  			 */
  			wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
  			apic_write(APIC_LVTPC, APIC_DM_NMI);
- 		} else if (nmi_perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0) {
-			/*
-			 * For Intel based architectural perfmon
-			 * - LVTPC is masked on interrupt and must be
-			 *   unmasked by the LVTPC handler.
-			 */
-			apic_write(APIC_LVTPC, APIC_DM_NMI);
-		}
+ 		}
 		wrmsrl(nmi_perfctr_msr, -((u64)cpu_khz * 1000 / nmi_hz));
 	}
 }
Index: linux/include/asm-i386/intel_arch_perfmon.h
===================================================================
--- linux.orig/include/asm-i386/intel_arch_perfmon.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef X86_INTEL_ARCH_PERFMON_H
-#define X86_INTEL_ARCH_PERFMON_H 1
-
-#define MSR_ARCH_PERFMON_PERFCTR0		0xc1
-#define MSR_ARCH_PERFMON_PERFCTR1		0xc2
-
-#define MSR_ARCH_PERFMON_EVENTSEL0		0x186
-#define MSR_ARCH_PERFMON_EVENTSEL1		0x187
-
-#define ARCH_PERFMON_EVENTSEL0_ENABLE      (1 << 22)
-#define ARCH_PERFMON_EVENTSEL_INT          (1 << 20)
-#define ARCH_PERFMON_EVENTSEL_OS           (1 << 17)
-#define ARCH_PERFMON_EVENTSEL_USR          (1 << 16)
-
-#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_SEL	(0x3c)
-#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_UMASK	(0x00 << 8)
-#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT (1 << 0)
-
-#endif	/* X86_INTEL_ARCH_PERFMON_H */
Index: linux/include/asm-x86_64/intel_arch_perfmon.h
===================================================================
--- linux.orig/include/asm-x86_64/intel_arch_perfmon.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef X86_64_INTEL_ARCH_PERFMON_H
-#define X86_64_INTEL_ARCH_PERFMON_H 1
-
-#define MSR_ARCH_PERFMON_PERFCTR0		0xc1
-#define MSR_ARCH_PERFMON_PERFCTR1		0xc2
-
-#define MSR_ARCH_PERFMON_EVENTSEL0		0x186
-#define MSR_ARCH_PERFMON_EVENTSEL1		0x187
-
-#define ARCH_PERFMON_EVENTSEL0_ENABLE      (1 << 22)
-#define ARCH_PERFMON_EVENTSEL_INT          (1 << 20)
-#define ARCH_PERFMON_EVENTSEL_OS           (1 << 17)
-#define ARCH_PERFMON_EVENTSEL_USR          (1 << 16)
-
-#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_SEL	(0x3c)
-#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_UMASK	(0x00 << 8)
-#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT (1 << 0)
-
-#endif	/* X86_64_INTEL_ARCH_PERFMON_H */
