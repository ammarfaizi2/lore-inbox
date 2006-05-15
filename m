Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWEOBvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWEOBvT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 21:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWEOBvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 21:51:19 -0400
Received: from mga06.intel.com ([134.134.136.21]:17812 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751034AbWEOBvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 21:51:18 -0400
X-IronPort-AV: i="4.05,127,1146466800"; 
   d="scan'208"; a="36145337:sNHT19356330"
Date: Sun, 14 May 2006 18:50:23 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH] i386/x86-64 Add nmi watchdog support for new Intel CPUs
Message-ID: <20060514185023.A16695@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Sorry if this is a duplicate. I tried sending this mail two days back and I don't
see it on the mailing list yet. So, resending it.]



Intel now has support for Architectural Performance Monitoring Counters
( Refer to IA-32 Intel Architecture Software Developer's Manual
http://www.intel.com/design/pentium4/manuals/253669.htm ). This
feature is present starting from Intel Core Duo and Intel Core Solo processors.

What this means is, the performance monitoring counters and some performance
monitoring events are now defined in an architectural way (using cpuid).
And there will be no need to check for family/model etc for these architectural
events.

Below is the patch to use this performance counters in nmi watchdog driver.
Patch handles both i386 and x86-64 kernels.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

diff -purN linux-2.6.17-rc4/arch/i386/kernel/cpu/intel.c linux-2.6.17-rc4-nmi/arch/i386/kernel/cpu/intel.c
--- linux-2.6.17-rc4/arch/i386/kernel/cpu/intel.c	2006-05-11 17:23:13.000000000 -0700
+++ linux-2.6.17-rc4-nmi/arch/i386/kernel/cpu/intel.c	2006-05-11 17:45:25.000000000 -0700
@@ -122,6 +122,12 @@ static void __cpuinit init_intel(struct 
 
 	select_idle_routine(c);
 	l2 = init_intel_cacheinfo(c);
+	if (c->cpuid_level > 9 ) {
+		unsigned eax = cpuid_eax(10);
+		/* Check for version and the number of counters */
+		if ((eax & 0xff) && (((eax>>8) & 0xff) > 1))
+			set_bit(X86_FEATURE_ARCH_PERFMON, c->x86_capability);
+	}
 
 	/* SEP CPUID bug: Pentium Pro reports SEP but doesn't have it until model 3 mask 3 */
 	if ((c->x86<<8 | c->x86_model<<4 | c->x86_mask) < 0x633)
diff -purN linux-2.6.17-rc4/arch/i386/kernel/nmi.c linux-2.6.17-rc4-nmi/arch/i386/kernel/nmi.c
--- linux-2.6.17-rc4/arch/i386/kernel/nmi.c	2006-05-11 17:23:13.000000000 -0700
+++ linux-2.6.17-rc4-nmi/arch/i386/kernel/nmi.c	2006-05-12 17:47:48.000000000 -0700
@@ -29,6 +29,7 @@
 #include <asm/smp.h>
 #include <asm/div64.h>
 #include <asm/nmi.h>
+#include <asm/intel_arch_perfmon.h>
 
 #include "mach_traps.h"
 
@@ -100,6 +101,9 @@ int nmi_active;
 	(P4_CCCR_OVF_PMI0|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
 	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
 
+#define ARCH_PERFMON_NMI_EVENT_SEL	ARCH_PERFMON_UNHALTED_CORE_CYCLES_SEL
+#define ARCH_PERFMON_NMI_EVENT_UMASK	ARCH_PERFMON_UNHALTED_CORE_CYCLES_UMASK
+
 #ifdef CONFIG_SMP
 /* The performance counters used by NMI_LOCAL_APIC don't trigger when
  * the CPU is idle. To make sure the NMI watchdog really ticks on all
@@ -212,6 +216,8 @@ static int __init setup_nmi_watchdog(cha
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
+static void disable_intel_arch_watchdog(void);
+
 static void disable_lapic_nmi_watchdog(void)
 {
 	if (nmi_active <= 0)
@@ -221,6 +227,10 @@ static void disable_lapic_nmi_watchdog(v
 		wrmsr(MSR_K7_EVNTSEL0, 0, 0);
 		break;
 	case X86_VENDOR_INTEL:
+		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
+			disable_intel_arch_watchdog();
+			break;
+		}
 		switch (boot_cpu_data.x86) {
 		case 6:
 			if (boot_cpu_data.x86_model > 0xd)
@@ -449,6 +459,53 @@ static int setup_p4_watchdog(void)
 	return 1;
 }
 
+static void disable_intel_arch_watchdog(void)
+{
+	unsigned ebx;
+
+	/*
+	 * Check whether the Architectural PerfMon supports
+	 * Unhalted Core Cycles Event or not.
+	 * NOTE: Corresponding bit = 0 in ebp indicates event present.
+	 */
+	ebx = cpuid_ebx(10);
+	if (!(ebx & ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT))
+		wrmsr(MSR_ARCH_PERFMON_EVENTSEL0, 0, 0);
+}
+
+static int setup_intel_arch_watchdog(void)
+{
+	unsigned int evntsel;
+	unsigned ebx;
+
+	/*
+	 * Check whether the Architectural PerfMon supports
+	 * Unhalted Core Cycles Event or not.
+	 * NOTE: Corresponding bit = 0 in ebp indicates event present.
+	 */
+	ebx = cpuid_ebx(10);
+	if ((ebx & ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT))
+		return 0;
+
+	nmi_perfctr_msr = MSR_ARCH_PERFMON_PERFCTR0;
+
+	clear_msr_range(MSR_ARCH_PERFMON_EVENTSEL0, 2);
+	clear_msr_range(MSR_ARCH_PERFMON_PERFCTR0, 2);
+
+	evntsel = ARCH_PERFMON_EVENTSEL_INT
+		| ARCH_PERFMON_EVENTSEL_OS
+		| ARCH_PERFMON_EVENTSEL_USR
+		| ARCH_PERFMON_NMI_EVENT_SEL
+		| ARCH_PERFMON_NMI_EVENT_UMASK;
+
+	wrmsr(MSR_ARCH_PERFMON_EVENTSEL0, evntsel, 0);
+	write_watchdog_counter("INTEL_ARCH_PERFCTR0");
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	evntsel |= ARCH_PERFMON_EVENTSEL0_ENABLE;
+	wrmsr(MSR_ARCH_PERFMON_EVENTSEL0, evntsel, 0);
+	return 1;
+}
+
 void setup_apic_nmi_watchdog (void)
 {
 	switch (boot_cpu_data.x86_vendor) {
@@ -458,6 +515,11 @@ void setup_apic_nmi_watchdog (void)
 		setup_k7_watchdog();
 		break;
 	case X86_VENDOR_INTEL:
+		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
+			if (!setup_intel_arch_watchdog())
+				return;
+			break;
+		}
 		switch (boot_cpu_data.x86) {
 		case 6:
 			if (boot_cpu_data.x86_model > 0xd)
@@ -561,7 +623,8 @@ void nmi_watchdog_tick (struct pt_regs *
 			wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
 			apic_write(APIC_LVTPC, APIC_DM_NMI);
 		}
-		else if (nmi_perfctr_msr == MSR_P6_PERFCTR0) {
+		else if (nmi_perfctr_msr == MSR_P6_PERFCTR0 || 
+		         nmi_perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0) {
 			/* Only P6 based Pentium M need to re-unmask
 			 * the apic vector but it doesn't hurt
 			 * other P6 variant */
diff -purN linux-2.6.17-rc4/arch/x86_64/kernel/nmi.c linux-2.6.17-rc4-nmi/arch/x86_64/kernel/nmi.c
--- linux-2.6.17-rc4/arch/x86_64/kernel/nmi.c	2006-05-11 17:23:17.000000000 -0700
+++ linux-2.6.17-rc4-nmi/arch/x86_64/kernel/nmi.c	2006-05-12 17:46:54.000000000 -0700
@@ -35,6 +35,7 @@
 #include <asm/kdebug.h>
 #include <asm/local.h>
 #include <asm/mce.h>
+#include <asm/intel_arch_perfmon.h>
 
 /*
  * lapic_nmi_owner tracks the ownership of the lapic NMI hardware:
@@ -74,6 +75,9 @@ static unsigned int nmi_p4_cccr_val;
 #define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0x76
 #define K7_NMI_EVENT		K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING
 
+#define ARCH_PERFMON_NMI_EVENT_SEL	ARCH_PERFMON_UNHALTED_CORE_CYCLES_SEL
+#define ARCH_PERFMON_NMI_EVENT_UMASK	ARCH_PERFMON_UNHALTED_CORE_CYCLES_UMASK
+
 #define MSR_P4_MISC_ENABLE	0x1A0
 #define MSR_P4_MISC_ENABLE_PERF_AVAIL	(1<<7)
 #define MSR_P4_MISC_ENABLE_PEBS_UNAVAIL	(1<<12)
@@ -105,7 +109,10 @@ static __cpuinit inline int nmi_known_cp
 	case X86_VENDOR_AMD:
 		return boot_cpu_data.x86 == 15;
 	case X86_VENDOR_INTEL:
-		return boot_cpu_data.x86 == 15;
+		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON))
+			return 1;
+		else
+			return (boot_cpu_data.x86 == 15);
 	}
 	return 0;
 }
@@ -211,6 +218,8 @@ int __init setup_nmi_watchdog(char *str)
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
+static void disable_intel_arch_watchdog(void);
+
 static void disable_lapic_nmi_watchdog(void)
 {
 	if (nmi_active <= 0)
@@ -223,6 +232,8 @@ static void disable_lapic_nmi_watchdog(v
 		if (boot_cpu_data.x86 == 15) {
 			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
 			wrmsr(MSR_P4_CRU_ESCR0, 0, 0);
+		} else if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
+			disable_intel_arch_watchdog();
 		}
 		break;
 	}
@@ -375,6 +386,53 @@ static void setup_k7_watchdog(void)
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
 }
 
+static void disable_intel_arch_watchdog(void)
+{
+	unsigned ebx;
+
+	/*
+	 * Check whether the Architectural PerfMon supports
+	 * Unhalted Core Cycles Event or not.
+	 * NOTE: Corresponding bit = 0 in ebp indicates event present.
+	 */
+	ebx = cpuid_ebx(10);
+	if (!(ebx & ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT))
+		wrmsr(MSR_ARCH_PERFMON_EVENTSEL0, 0, 0);
+}
+
+static int setup_intel_arch_watchdog(void)
+{
+	unsigned int evntsel;
+	unsigned ebx;
+
+	/*
+	 * Check whether the Architectural PerfMon supports
+	 * Unhalted Core Cycles Event or not.
+	 * NOTE: Corresponding bit = 0 in ebp indicates event present.
+	 */
+	ebx = cpuid_ebx(10);
+	if ((ebx & ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT))
+		return 0;
+
+	nmi_perfctr_msr = MSR_ARCH_PERFMON_PERFCTR0;
+
+	clear_msr_range(MSR_ARCH_PERFMON_EVENTSEL0, 2);
+	clear_msr_range(MSR_ARCH_PERFMON_PERFCTR0, 2);
+
+	evntsel = ARCH_PERFMON_EVENTSEL_INT
+		| ARCH_PERFMON_EVENTSEL_OS
+		| ARCH_PERFMON_EVENTSEL_USR
+		| ARCH_PERFMON_NMI_EVENT_SEL
+		| ARCH_PERFMON_NMI_EVENT_UMASK;
+
+	wrmsr(MSR_ARCH_PERFMON_EVENTSEL0, evntsel, 0);
+	wrmsrl(MSR_ARCH_PERFMON_PERFCTR0, -((u64)cpu_khz * 1000 / nmi_hz));
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	evntsel |= ARCH_PERFMON_EVENTSEL0_ENABLE;
+	wrmsr(MSR_ARCH_PERFMON_EVENTSEL0, evntsel, 0);
+	return 1;
+}
+
 
 static int setup_p4_watchdog(void)
 {
@@ -428,10 +486,16 @@ void setup_apic_nmi_watchdog(void)
 		setup_k7_watchdog();
 		break;
 	case X86_VENDOR_INTEL:
-		if (boot_cpu_data.x86 != 15)
-			return;
-		if (!setup_p4_watchdog())
+		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
+			if (!setup_intel_arch_watchdog())
+				return;
+		} else if (boot_cpu_data.x86 == 15) {
+			if (!setup_p4_watchdog())
+				return;
+		} else {
 			return;
+		}
+
 		break;
 
 	default:
@@ -516,7 +580,14 @@ void __kprobes nmi_watchdog_tick(struct 
  			 */
  			wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
  			apic_write(APIC_LVTPC, APIC_DM_NMI);
- 		}
+ 		} else if (nmi_perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0) {
+			/*
+			 * For Intel based architectural perfmon
+			 * - LVTPC is masked on interrupt and must be
+			 *   unmasked by the LVTPC handler.
+			 */
+			apic_write(APIC_LVTPC, APIC_DM_NMI);
+		}
 		wrmsrl(nmi_perfctr_msr, -((u64)cpu_khz * 1000 / nmi_hz));
 	}
 }
diff -purN linux-2.6.17-rc4/arch/x86_64/kernel/setup.c linux-2.6.17-rc4-nmi/arch/x86_64/kernel/setup.c
--- linux-2.6.17-rc4/arch/x86_64/kernel/setup.c	2006-05-11 17:23:17.000000000 -0700
+++ linux-2.6.17-rc4-nmi/arch/x86_64/kernel/setup.c	2006-05-11 17:27:05.000000000 -0700
@@ -1065,6 +1065,13 @@ static void __cpuinit init_intel(struct 
 	unsigned n;
 
 	init_intel_cacheinfo(c);
+	if (c->cpuid_level > 9 ) {
+		unsigned eax = cpuid_eax(10);
+		/* Check for version and the number of counters */
+		if ((eax & 0xff) && (((eax>>8) & 0xff) > 1))
+			set_bit(X86_FEATURE_ARCH_PERFMON, &c->x86_capability);
+	}
+
 	n = c->extended_cpuid_level;
 	if (n >= 0x80000008) {
 		unsigned eax = cpuid_eax(0x80000008);
diff -purN linux-2.6.17-rc4/include/asm-i386/cpufeature.h linux-2.6.17-rc4-nmi/include/asm-i386/cpufeature.h
--- linux-2.6.17-rc4/include/asm-i386/cpufeature.h	2006-05-11 17:23:21.000000000 -0700
+++ linux-2.6.17-rc4-nmi/include/asm-i386/cpufeature.h	2006-05-11 17:29:17.000000000 -0700
@@ -72,6 +72,7 @@
 #define X86_FEATURE_CONSTANT_TSC (3*32+ 8) /* TSC ticks at a constant rate */
 #define X86_FEATURE_UP		(3*32+ 9) /* smp kernel running on up */
 #define X86_FEATURE_FXSAVE_LEAK (3*32+10) /* FXSAVE leaks FOP/FIP/FOP */
+#define X86_FEATURE_ARCH_PERFMON (3*32+11) /* Intel Architectural PerfMon */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
diff -purN linux-2.6.17-rc4/include/asm-i386/intel_arch_perfmon.h linux-2.6.17-rc4-nmi/include/asm-i386/intel_arch_perfmon.h
--- linux-2.6.17-rc4/include/asm-i386/intel_arch_perfmon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4-nmi/include/asm-i386/intel_arch_perfmon.h	2006-05-11 17:27:05.000000000 -0700
@@ -0,0 +1,19 @@
+#ifndef X86_INTEL_ARCH_PERFMON_H
+#define X86_INTEL_ARCH_PERFMON_H 1
+
+#define MSR_ARCH_PERFMON_PERFCTR0		0xc1
+#define MSR_ARCH_PERFMON_PERFCTR1		0xc2
+
+#define MSR_ARCH_PERFMON_EVENTSEL0		0x186
+#define MSR_ARCH_PERFMON_EVENTSEL1		0x187
+
+#define ARCH_PERFMON_EVENTSEL0_ENABLE      (1 << 22)
+#define ARCH_PERFMON_EVENTSEL_INT          (1 << 20)
+#define ARCH_PERFMON_EVENTSEL_OS           (1 << 17)
+#define ARCH_PERFMON_EVENTSEL_USR          (1 << 16)
+
+#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_SEL	(0x3c)
+#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_UMASK	(0x00 << 8)
+#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT (1 << 0)
+
+#endif	/* X86_INTEL_ARCH_PERFMON_H */
diff -purN linux-2.6.17-rc4/include/asm-x86_64/cpufeature.h linux-2.6.17-rc4-nmi/include/asm-x86_64/cpufeature.h
--- linux-2.6.17-rc4/include/asm-x86_64/cpufeature.h	2006-05-11 17:23:22.000000000 -0700
+++ linux-2.6.17-rc4-nmi/include/asm-x86_64/cpufeature.h	2006-05-11 17:30:27.000000000 -0700
@@ -65,6 +65,7 @@
 #define X86_FEATURE_CONSTANT_TSC (3*32+5) /* TSC runs at constant rate */
 #define X86_FEATURE_SYNC_RDTSC  (3*32+6)  /* RDTSC syncs CPU core */
 #define X86_FEATURE_FXSAVE_LEAK (3*32+7)  /* FIP/FOP/FDP leaks through FXSAVE */
+#define X86_FEATURE_ARCH_PERFMON (3*32+8) /* Intel Architectural PerfMon */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
diff -purN linux-2.6.17-rc4/include/asm-x86_64/intel_arch_perfmon.h linux-2.6.17-rc4-nmi/include/asm-x86_64/intel_arch_perfmon.h
--- linux-2.6.17-rc4/include/asm-x86_64/intel_arch_perfmon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4-nmi/include/asm-x86_64/intel_arch_perfmon.h	2006-05-11 17:27:05.000000000 -0700
@@ -0,0 +1,19 @@
+#ifndef X86_64_INTEL_ARCH_PERFMON_H
+#define X86_64_INTEL_ARCH_PERFMON_H 1
+
+#define MSR_ARCH_PERFMON_PERFCTR0		0xc1
+#define MSR_ARCH_PERFMON_PERFCTR1		0xc2
+
+#define MSR_ARCH_PERFMON_EVENTSEL0		0x186
+#define MSR_ARCH_PERFMON_EVENTSEL1		0x187
+
+#define ARCH_PERFMON_EVENTSEL0_ENABLE      (1 << 22)
+#define ARCH_PERFMON_EVENTSEL_INT          (1 << 20)
+#define ARCH_PERFMON_EVENTSEL_OS           (1 << 17)
+#define ARCH_PERFMON_EVENTSEL_USR          (1 << 16)
+
+#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_SEL	(0x3c)
+#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_UMASK	(0x00 << 8)
+#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT (1 << 0)
+
+#endif	/* X86_64_INTEL_ARCH_PERFMON_H */
