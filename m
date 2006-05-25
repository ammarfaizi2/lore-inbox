Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030504AbWEYW5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030504AbWEYW5G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030505AbWEYW5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:57:06 -0400
Received: from mga05.intel.com ([192.55.52.89]:41526 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030504AbWEYW5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:57:04 -0400
X-IronPort-AV: i="4.05,174,1146466800"; 
   d="scan'208"; a="42635376:sNHT223868631"
Date: Thu, 25 May 2006 15:54:50 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386/x86-64 Add nmi watchdog support for new Intel CPUs
Message-ID: <20060525155450.A9360@unix-os.sc.intel.com>
References: <20060514185023.A16695@unix-os.sc.intel.com> <200605150922.25511.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200605150922.25511.ak@suse.de>; from ak@suse.de on Mon, May 15, 2006 at 09:22:25AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, May 15, 2006 at 09:22:25AM +0200, Andi Kleen wrote:
> 
> Can you regenerate it against the latest firstfloor tree please? 
> With Don's x86-64 NMI changes there are a zillion rejects.
> 

Below is the updated patch, to apply over Don's changes.


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

Index: linux-2.6.16/arch/i386/kernel/cpu/intel.c
===================================================================
--- linux-2.6.16.orig/arch/i386/kernel/cpu/intel.c
+++ linux-2.6.16/arch/i386/kernel/cpu/intel.c
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
Index: linux-2.6.16/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.16.orig/arch/i386/kernel/nmi.c
+++ linux-2.6.16/arch/i386/kernel/nmi.c
@@ -26,6 +26,7 @@
 #include <asm/smp.h>
 #include <asm/nmi.h>
 #include <asm/kdebug.h>
+#include <asm/intel_arch_perfmon.h>
 
 #include "mach_traps.h"
 
@@ -78,6 +79,9 @@ static inline unsigned int nmi_perfctr_m
 	case X86_VENDOR_AMD:
 		return (msr - MSR_K7_PERFCTR0);
 	case X86_VENDOR_INTEL:
+		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON))
+			return (msr - MSR_ARCH_PERFMON_PERFCTR0);
+
 		switch (boot_cpu_data.x86) {
 		case 6:
 			return (msr - MSR_P6_PERFCTR0);
@@ -96,6 +100,9 @@ static inline unsigned int nmi_evntsel_m
 	case X86_VENDOR_AMD:
 		return (msr - MSR_K7_EVNTSEL0);
 	case X86_VENDOR_INTEL:
+		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON))
+			return (msr - MSR_ARCH_PERFMON_EVENTSEL0);
+
 		switch (boot_cpu_data.x86) {
 		case 6:
 			return (msr - MSR_P6_EVNTSEL0);
@@ -175,7 +182,10 @@ static __cpuinit inline int nmi_known_cp
 	case X86_VENDOR_AMD:
 		return ((boot_cpu_data.x86 == 15) || (boot_cpu_data.x86 == 6));
 	case X86_VENDOR_INTEL:
-		return ((boot_cpu_data.x86 == 15) || (boot_cpu_data.x86 == 6));
+		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON))
+			return 1;
+		else
+			return ((boot_cpu_data.x86 == 15) || (boot_cpu_data.x86 == 6));
 	}
 	return 0;
 }
@@ -262,8 +272,24 @@ static int __init check_nmi_watchdog(voi
 
 	/* now that we know it works we can reduce NMI frequency to
 	   something more reasonable; makes a difference in some configs */
-	if (nmi_watchdog == NMI_LOCAL_APIC)
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
+		struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
 		nmi_hz = 1;
+		/*
+		 * On Intel CPUs with ARCH_PERFMON only 32 bits in the counter
+		 * are writable, with higher bits sign extending from bit 31.
+		 * So, we can only program the counter with 31 bit values and
+		 * 32nd bit should be 1, for 33.. to be 1.
+		 * Find the appropriate nmi_hz
+		 */
+	 	if (wd->perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0 &&
+			((u64)cpu_khz * 1000) > 0x7fffffffULL) {
+			u64 count = (u64)cpu_khz * 1000;
+			do_div(count, 0x7fffffffUL);
+			nmi_hz = count + 1;
+		}
+	}
 
 	kfree(prev_nmi_count);
 	return 0;
@@ -633,6 +659,85 @@ static void stop_p4_watchdog(void)
 	release_perfctr_nmi(wd->perfctr_msr);
 }
 
+#define ARCH_PERFMON_NMI_EVENT_SEL	ARCH_PERFMON_UNHALTED_CORE_CYCLES_SEL
+#define ARCH_PERFMON_NMI_EVENT_UMASK	ARCH_PERFMON_UNHALTED_CORE_CYCLES_UMASK
+
+static int setup_intel_arch_watchdog(void)
+{
+	unsigned int ebx;
+	union cpuid10_eax eax;
+	unsigned int unused;
+	unsigned int perfctr_msr, evntsel_msr;
+	unsigned int evntsel;
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
+	/*
+	 * Check whether the Architectural PerfMon supports
+	 * Unhalted Core Cycles Event or not.
+	 * NOTE: Corresponding bit = 0 in ebx indicates event present.
+	 */
+	cpuid(10, &(eax.full), &ebx, &unused, &unused);
+	if ((eax.split.mask_length < (ARCH_PERFMON_UNHALTED_CORE_CYCLES_INDEX+1)) ||
+	    (ebx & ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT))
+		goto fail;
+
+	perfctr_msr = MSR_ARCH_PERFMON_PERFCTR0;
+	evntsel_msr = MSR_ARCH_PERFMON_EVENTSEL0;
+
+	if (!reserve_perfctr_nmi(perfctr_msr))
+		goto fail;
+
+	if (!reserve_evntsel_nmi(evntsel_msr))
+		goto fail1;
+
+	wrmsrl(perfctr_msr, 0UL);
+
+	evntsel = ARCH_PERFMON_EVENTSEL_INT
+		| ARCH_PERFMON_EVENTSEL_OS
+		| ARCH_PERFMON_EVENTSEL_USR
+		| ARCH_PERFMON_NMI_EVENT_SEL
+		| ARCH_PERFMON_NMI_EVENT_UMASK;
+
+	/* setup the timer */
+	wrmsr(evntsel_msr, evntsel, 0);
+	write_watchdog_counter(perfctr_msr, "INTEL_ARCH_PERFCTR0");
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	evntsel |= ARCH_PERFMON_EVENTSEL0_ENABLE;
+	wrmsr(evntsel_msr, evntsel, 0);
+
+	wd->perfctr_msr = perfctr_msr;
+	wd->evntsel_msr = evntsel_msr;
+	wd->cccr_msr = 0;  //unused
+	wd->check_bit = 1ULL << (eax.split.bit_width - 1);
+	return 1;
+fail1:
+	release_perfctr_nmi(perfctr_msr);
+fail:
+	return 0;
+}
+
+static void stop_intel_arch_watchdog(void)
+{
+	unsigned int ebx;
+	union cpuid10_eax eax;
+	unsigned int unused;
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
+	/*
+	 * Check whether the Architectural PerfMon supports
+	 * Unhalted Core Cycles Event or not.
+	 * NOTE: Corresponding bit = 0 in ebx indicates event present.
+	 */
+	cpuid(10, &(eax.full), &ebx, &unused, &unused);
+	if ((eax.split.mask_length < (ARCH_PERFMON_UNHALTED_CORE_CYCLES_INDEX+1)) ||
+	    (ebx & ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT))
+		return;
+
+	wrmsr(wd->evntsel_msr, 0, 0);
+	release_evntsel_nmi(wd->evntsel_msr);
+	release_perfctr_nmi(wd->perfctr_msr);
+}
+
 void setup_apic_nmi_watchdog (void *unused)
 {
 	/* only support LOCAL and IO APICs for now */
@@ -649,6 +754,11 @@ void setup_apic_nmi_watchdog (void *unus
 				return;
 			break;
 		case X86_VENDOR_INTEL:
+			if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
+				if (!setup_intel_arch_watchdog())
+					return;
+				break;
+			}
 			switch (boot_cpu_data.x86) {
 			case 6:
 				if (boot_cpu_data.x86_model > 0xd)
@@ -689,6 +799,10 @@ static void stop_apic_nmi_watchdog(void 
 			stop_k7_watchdog();
 			break;
 		case X86_VENDOR_INTEL:
+			if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
+				stop_intel_arch_watchdog();
+				break;
+			}
 			switch (boot_cpu_data.x86) {
 			case 6:
 				if (boot_cpu_data.x86_model > 0xd)
@@ -811,10 +925,12 @@ int nmi_watchdog_tick (struct pt_regs * 
 	 			wrmsrl(wd->cccr_msr, dummy);
 	 			apic_write(APIC_LVTPC, APIC_DM_NMI);
 	 		}
-			else if (wd->perfctr_msr == MSR_P6_PERFCTR0) {
-				/* Only P6 based Pentium M need to re-unmask
+			else if (wd->perfctr_msr == MSR_P6_PERFCTR0 ||
+				 wd->perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0) {
+				/* P6 based Pentium M need to re-unmask
 				 * the apic vector but it doesn't hurt
-				 * other P6 variant */
+				 * other P6 variant.
+				 * ArchPerfom/Core Duo also needs this */
 				apic_write(APIC_LVTPC, APIC_DM_NMI);
 			}
 			/* start the cycle over again */
Index: linux-2.6.16/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-2.6.16.orig/arch/x86_64/kernel/nmi.c
+++ linux-2.6.16/arch/x86_64/kernel/nmi.c
@@ -27,6 +27,7 @@
 #include <asm/proto.h>
 #include <asm/kdebug.h>
 #include <asm/mce.h>
+#include <asm/intel_arch_perfmon.h>
 
 /* perfctr_nmi_owner tracks the ownership of the perfctr registers:
  * evtsel_nmi_owner tracks the ownership of the event selection
@@ -75,7 +76,10 @@ static inline unsigned int nmi_perfctr_m
 	case X86_VENDOR_AMD:
 		return (msr - MSR_K7_PERFCTR0);
 	case X86_VENDOR_INTEL:
-		return (msr - MSR_P4_BPU_PERFCTR0);
+		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON))
+			return (msr - MSR_ARCH_PERFMON_PERFCTR0);
+		else
+			return (msr - MSR_P4_BPU_PERFCTR0);
 	}
 	return 0;
 }
@@ -88,7 +92,10 @@ static inline unsigned int nmi_evntsel_m
 	case X86_VENDOR_AMD:
 		return (msr - MSR_K7_EVNTSEL0);
 	case X86_VENDOR_INTEL:
-		return (msr - MSR_P4_BSU_ESCR0);
+		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON))
+			return (msr - MSR_ARCH_PERFMON_EVENTSEL0);
+		else
+			return (msr - MSR_P4_BSU_ESCR0);
 	}
 	return 0;
 }
@@ -162,7 +169,10 @@ static __cpuinit inline int nmi_known_cp
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
@@ -248,8 +258,22 @@ int __init check_nmi_watchdog (void)
 
 	/* now that we know it works we can reduce NMI frequency to
 	   something more reasonable; makes a difference in some configs */
-	if (nmi_watchdog == NMI_LOCAL_APIC)
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
+		struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
 		nmi_hz = 1;
+		/*
+		 * On Intel CPUs with ARCH_PERFMON only 32 bits in the counter
+		 * are writable, with higher bits sign extending from bit 31.
+		 * So, we can only program the counter with 31 bit values and
+		 * 32nd bit should be 1, for 33.. to be 1.
+		 * Find the appropriate nmi_hz
+		 */
+	 	if (wd->perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0 &&
+			((u64)cpu_khz * 1000) > 0x7fffffffULL) {
+			nmi_hz = ((u64)cpu_khz * 1000) / 0x7fffffffUL + 1;
+		}
+	}
 
 	kfree(counts);
 	return 0;
@@ -560,6 +584,87 @@ static void stop_p4_watchdog(void)
 	release_perfctr_nmi(wd->perfctr_msr);
 }
 
+#define ARCH_PERFMON_NMI_EVENT_SEL	ARCH_PERFMON_UNHALTED_CORE_CYCLES_SEL
+#define ARCH_PERFMON_NMI_EVENT_UMASK	ARCH_PERFMON_UNHALTED_CORE_CYCLES_UMASK
+
+static int setup_intel_arch_watchdog(void)
+{
+	unsigned int ebx;
+	union cpuid10_eax eax;
+	unsigned int unused;
+	unsigned int perfctr_msr, evntsel_msr;
+	unsigned int evntsel;
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
+	/*
+	 * Check whether the Architectural PerfMon supports
+	 * Unhalted Core Cycles Event or not.
+	 * NOTE: Corresponding bit = 0 in ebx indicates event present.
+	 */
+	cpuid(10, &(eax.full), &ebx, &unused, &unused);
+	if ((eax.split.mask_length < (ARCH_PERFMON_UNHALTED_CORE_CYCLES_INDEX+1)) ||
+	    (ebx & ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT))
+		goto fail;
+
+	perfctr_msr = MSR_ARCH_PERFMON_PERFCTR0;
+	evntsel_msr = MSR_ARCH_PERFMON_EVENTSEL0;
+
+	if (!reserve_perfctr_nmi(perfctr_msr))
+		goto fail;
+
+	if (!reserve_evntsel_nmi(evntsel_msr))
+		goto fail1;
+
+	wrmsrl(perfctr_msr, 0UL);
+
+	evntsel = ARCH_PERFMON_EVENTSEL_INT
+		| ARCH_PERFMON_EVENTSEL_OS
+		| ARCH_PERFMON_EVENTSEL_USR
+		| ARCH_PERFMON_NMI_EVENT_SEL
+		| ARCH_PERFMON_NMI_EVENT_UMASK;
+
+	/* setup the timer */
+	wrmsr(evntsel_msr, evntsel, 0);
+	wrmsrl(perfctr_msr, -((u64)cpu_khz * 1000 / nmi_hz));
+
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	evntsel |= ARCH_PERFMON_EVENTSEL0_ENABLE;
+	wrmsr(evntsel_msr, evntsel, 0);
+
+	wd->perfctr_msr = perfctr_msr;
+	wd->evntsel_msr = evntsel_msr;
+	wd->cccr_msr = 0;  //unused
+	wd->check_bit = 1ULL << (eax.split.bit_width - 1);
+	return 1;
+fail1:
+	release_perfctr_nmi(perfctr_msr);
+fail:
+	return 0;
+}
+
+static void stop_intel_arch_watchdog(void)
+{
+	unsigned int ebx;
+	union cpuid10_eax eax;
+	unsigned int unused;
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
+	/*
+	 * Check whether the Architectural PerfMon supports
+	 * Unhalted Core Cycles Event or not.
+	 * NOTE: Corresponding bit = 0 in ebx indicates event present.
+	 */
+	cpuid(10, &(eax.full), &ebx, &unused, &unused);
+	if ((eax.split.mask_length < (ARCH_PERFMON_UNHALTED_CORE_CYCLES_INDEX+1)) ||
+	    (ebx & ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT))
+		return;
+
+	wrmsr(wd->evntsel_msr, 0, 0);
+
+	release_evntsel_nmi(wd->evntsel_msr);
+	release_perfctr_nmi(wd->perfctr_msr);
+}
+
 void setup_apic_nmi_watchdog(void *unused)
 {
 	/* only support LOCAL and IO APICs for now */
@@ -576,6 +681,11 @@ void setup_apic_nmi_watchdog(void *unuse
 				return;
 			break;
 		case X86_VENDOR_INTEL:
+			if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
+				if (!setup_intel_arch_watchdog())
+					return;
+				break;
+			}
 			if (!setup_p4_watchdog())
 				return;
 			break;
@@ -602,6 +712,10 @@ static void stop_apic_nmi_watchdog(void 
 			stop_k7_watchdog();
 			break;
 		case X86_VENDOR_INTEL:
+			if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
+				stop_intel_arch_watchdog();
+				break;
+			}
 			stop_p4_watchdog();
 			break;
 		default:
@@ -705,9 +819,15 @@ int __kprobes nmi_watchdog_tick(struct p
 				dummy &= ~P4_CCCR_OVF;
 	 			wrmsrl(wd->cccr_msr, dummy);
 	 			apic_write(APIC_LVTPC, APIC_DM_NMI);
-	 		}
+	 		} else if (wd->perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0) {
+				/*
+				 * ArchPerfom/Core Duo needs to re-unmask
+				 * the apic vector
+				 */
+				apic_write(APIC_LVTPC, APIC_DM_NMI);
+			}
 			/* start the cycle over again */
			wrmsrl(wd->perfctr_msr, -((u64)cpu_khz * 1000 / nmi_hz));
 			rc = 1;
 		} else 	if (nmi_watchdog == NMI_IO_APIC) {
 			/* don't know how to accurately check for this.
Index: linux-2.6.16/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.16.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.16/arch/x86_64/kernel/setup.c
@@ -997,6 +997,13 @@ static void __cpuinit init_intel(struct 
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
Index: linux-2.6.16/include/asm-i386/cpufeature.h
===================================================================
--- linux-2.6.16.orig/include/asm-i386/cpufeature.h
+++ linux-2.6.16/include/asm-i386/cpufeature.h
@@ -72,6 +72,7 @@
 #define X86_FEATURE_CONSTANT_TSC (3*32+ 8) /* TSC ticks at a constant rate */
 #define X86_FEATURE_UP		(3*32+ 9) /* smp kernel running on up */
 #define X86_FEATURE_FXSAVE_LEAK (3*32+10) /* FXSAVE leaks FOP/FIP/FOP */
+#define X86_FEATURE_ARCH_PERFMON (3*32+11) /* Intel Architectural PerfMon */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
Index: linux-2.6.16/include/asm-i386/intel_arch_perfmon.h
===================================================================
--- /dev/null
+++ linux-2.6.16/include/asm-i386/intel_arch_perfmon.h
@@ -0,0 +1,31 @@
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
+#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_INDEX (0)
+#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT \
+				(1 << (ARCH_PERFMON_UNHALTED_CORE_CYCLES_INDEX))
+
+union cpuid10_eax {
+	struct {
+		unsigned int version_id:8;
+		unsigned int num_counters:8;
+		unsigned int bit_width:8;
+		unsigned int mask_length:8;
+	} split;
+	unsigned int full;
+};
+
+#endif	/* X86_INTEL_ARCH_PERFMON_H */
Index: linux-2.6.16/include/asm-x86_64/cpufeature.h
===================================================================
--- linux-2.6.16.orig/include/asm-x86_64/cpufeature.h
+++ linux-2.6.16/include/asm-x86_64/cpufeature.h
@@ -66,6 +66,7 @@
 #define X86_FEATURE_SYNC_RDTSC  (3*32+6)  /* RDTSC syncs CPU core */
 #define X86_FEATURE_FXSAVE_LEAK (3*32+7)  /* FIP/FOP/FDP leaks through FXSAVE */
 #define X86_FEATURE_UP		(3*32+8) /* SMP kernel running on UP */
+#define X86_FEATURE_ARCH_PERFMON (3*32+9) /* Intel Architectural PerfMon */
 
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
Index: linux-2.6.16/include/asm-x86_64/intel_arch_perfmon.h
===================================================================
--- /dev/null
+++ linux-2.6.16/include/asm-x86_64/intel_arch_perfmon.h
@@ -0,0 +1,31 @@
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
+#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_INDEX (0)
+#define ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT \
+				(1 << (ARCH_PERFMON_UNHALTED_CORE_CYCLES_INDEX))
+
+union cpuid10_eax {
+	struct {
+		unsigned int version_id:8;
+		unsigned int num_counters:8;
+		unsigned int bit_width:8;
+		unsigned int mask_length:8;
+	} split;
+	unsigned int full;
+};
+
+#endif	/* X86_64_INTEL_ARCH_PERFMON_H */
