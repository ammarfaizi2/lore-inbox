Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265012AbSLXPyw>; Tue, 24 Dec 2002 10:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSLXPyw>; Tue, 24 Dec 2002 10:54:52 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:55270 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265012AbSLXPyq>; Tue, 24 Dec 2002 10:54:46 -0500
Date: Tue, 24 Dec 2002 17:02:48 +0100
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] Add AMD K8 support to 2.5.53.
Message-ID: <20021224160248.GA1632@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add support for the AMD Opteron/Athlon64/Hammer/K8 line to the 32bit
kernel.

Mostly just reusing Athlon code with some changed CPU model checks.
The Hammer has model number 15.

I also fixed rmb()/mb() to use the SSE2 mfence/lfence instructions
on P4 and Hammer. They are somewhat cheaper than the locked cycle.

Patch for 2.5.53. Please consider applying.

-Andi


diff -X ../KDIFX -burp linux/arch/i386/Kconfig linux-2.5.53-work/arch/i386/Kconfig
--- linux/arch/i386/Kconfig	2002-12-24 16:45:11.000000000 +0100
+++ linux-2.5.53-work/arch/i386/Kconfig	2002-12-24 16:44:41.000000000 +0100
@@ -140,6 +140,13 @@ config MK7
 	  some extended instructions, and passes appropriate optimization
 	  flags to GCC.
 
+config MK8
+	bool "Opteron/Athlon64/Hammer/K8"
+	help
+	  Select this for an AMD Opteron or Athlon64 Hammer-family processor.  Enables
+	  use of some extended instructions, and passes appropriate optimization
+	  flags to GCC.
+
 config MELAN
 	bool "Elan"
 
@@ -200,7 +207,7 @@ config X86_L1_CACHE_SHIFT
 	int
 	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || M686 || M586MMX || M586TSC || M586
 	default "4" if MELAN || M486 || M386
-	default "6" if MK7
+	default "6" if MK7 || MK8
 	default "7" if MPENTIUM4
 
 config RWSEM_GENERIC_SPINLOCK
@@ -255,12 +262,12 @@ config X86_ALIGNMENT_16
 
 config X86_TSC
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || M686 || M586MMX || M586TSC
+	depends on MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || M686 || M586MMX || M586TSC || MK8
 	default y
 
 config X86_GOOD_APIC
 	bool
-	depends on MK7 || MPENTIUM4 || MPENTIUMIII || M686 || M586MMX
+	depends on MK7 || MPENTIUM4 || MPENTIUMIII || M686 || M586MMX || MK8
 	default y
 
 config X86_INTEL_USERCOPY
@@ -270,7 +277,7 @@ config X86_INTEL_USERCOPY
 
 config X86_USE_PPRO_CHECKSUM
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || M686
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || M686 || MK8
 	default y
 
 config X86_USE_3DNOW
@@ -283,6 +290,11 @@ config X86_OOSTORE
 	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6
 	default y
 
+config X86_SSE2
+        bool
+	depends on MK8 || MPENTIUM4
+	default y
+
 config HUGETLB_PAGE
 	bool "Huge TLB Page Support"
 	help
diff -X ../KDIFX -burp linux/arch/i386/Makefile linux-2.5.53-work/arch/i386/Makefile
--- linux/arch/i386/Makefile	2002-12-24 16:45:11.000000000 +0100
+++ linux-2.5.53-work/arch/i386/Makefile	2002-12-24 16:44:41.000000000 +0100
@@ -38,6 +38,7 @@ cflags-$(CONFIG_MPENTIUMIII)	+= $(call c
 cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
 cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
 cflags-$(CONFIG_MK7)		+= $(call check_gcc,-march=athlon,-march=i686 -malign-functions=4)
+cflags-$(CONFIG_MK8)		+= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 -malign-functions=4))
 cflags-$(CONFIG_MCRUSOE)	+= -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0
 cflags-$(CONFIG_MWINCHIPC6)	+= $(call check_gcc,-march=winchip-c6,-march=i586)
 cflags-$(CONFIG_MWINCHIP2)	+= $(call check_gcc,-march=winchip2,-march=i586)
diff -X ../KDIFX -burp linux/arch/i386/kernel/apic.c linux-2.5.53-work/arch/i386/kernel/apic.c
--- linux/arch/i386/kernel/apic.c	2002-12-24 16:45:11.000000000 +0100
+++ linux-2.5.53-work/arch/i386/kernel/apic.c	2002-12-24 16:44:41.000000000 +0100
@@ -614,7 +614,8 @@ static int __init detect_init_APIC (void
 
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
-		if (boot_cpu_data.x86 == 6 && boot_cpu_data.x86_model > 1)
+		if ((boot_cpu_data.x86 == 6 && boot_cpu_data.x86_model > 1) ||
+		    (boot_cpu_data.x86 == 15))	    
 			break;
 		goto no_apic;
 	case X86_VENDOR_INTEL:
diff -X ../KDIFX -burp linux/arch/i386/kernel/cpu/mcheck/k7.c linux-2.5.53-work/arch/i386/kernel/cpu/mcheck/k7.c
--- linux/arch/i386/kernel/cpu/mcheck/k7.c	2002-11-13 23:43:45.000000000 +0100
+++ linux-2.5.53-work/arch/i386/kernel/cpu/mcheck/k7.c	2002-12-22 15:07:43.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * Athlon specific Machine Check Exception Reporting
+ * Athlon/Hammer specific Machine Check Exception Reporting
  */
 
 #include <linux/init.h>
@@ -82,6 +82,9 @@ void __init amd_mcheck_init(struct cpuin
 	nr_mce_banks = l & 0xff;
 
 	for (i=0; i<nr_mce_banks; i++) {
+		/* Don't enable northbridge MCE by default on Hammer */
+		if (boot_cpu_data.x86_model == 15 && i == 4) 
+			continue;
 		wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
 		wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
 	}
diff -X ../KDIFX -burp linux/arch/i386/kernel/cpu/mtrr/main.c linux-2.5.53-work/arch/i386/kernel/cpu/mtrr/main.c
--- linux/arch/i386/kernel/cpu/mtrr/main.c	2002-12-24 16:45:11.000000000 +0100
+++ linux-2.5.53-work/arch/i386/kernel/cpu/mtrr/main.c	2002-12-24 16:49:35.000000000 +0100
@@ -574,7 +574,7 @@ static int __init mtrr_init(void)
 			   query the width (in bits) of the physical
 			   addressable memory on the Hammer family.
 			 */
-			if (boot_cpu_data.x86 >= 7 
+			if (boot_cpu_data.x86 == 15
 			    && (cpuid_eax(0x80000000) >= 0x80000008)) {
 				u32 phys_addr;
 				phys_addr = cpuid_eax(0x80000008) & 0xff;
diff -X ../KDIFX -burp linux/arch/i386/kernel/nmi.c linux-2.5.53-work/arch/i386/kernel/nmi.c
--- linux/arch/i386/kernel/nmi.c	2002-10-19 04:32:30.000000000 +0200
+++ linux-2.5.53-work/arch/i386/kernel/nmi.c	2002-12-22 13:24:23.000000000 +0100
@@ -123,7 +123,7 @@ static int __init setup_nmi_watchdog(cha
 		nmi_watchdog = nmi;
 	if ((nmi == NMI_LOCAL_APIC) &&
 			(boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
-			(boot_cpu_data.x86 == 6))
+	  		(boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15))
 		nmi_watchdog = nmi;
 	/*
 	 * We can enable the IO-APIC watchdog
@@ -294,7 +294,7 @@ void __pminit setup_apic_nmi_watchdog (v
 {
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
-		if (boot_cpu_data.x86 != 6)
+		if (boot_cpu_data.x86 != 6 && boot_cpu_data.x86 != 15)
 			return;
 		setup_k7_watchdog();
 		break;
diff -X ../KDIFX -burp linux/include/asm-i386/bugs.h linux-2.5.53-work/include/asm-i386/bugs.h
--- linux/include/asm-i386/bugs.h	2002-10-12 06:21:34.000000000 +0200
+++ linux-2.5.53-work/include/asm-i386/bugs.h	2002-12-22 13:16:24.000000000 +0100
@@ -193,6 +193,11 @@ static void __init check_config(void)
 	    && (boot_cpu_data.x86_mask < 6 || boot_cpu_data.x86_mask == 11))
 		panic("Kernel compiled for PMMX+, assumes a local APIC without the read-before-write bug!");
 #endif
+
+#ifdef CONFIG_X86_SSE2
+	if (!cpu_has_sse2)
+		panic("Kernel compiled for SSE2, CPU doesn't have it.");
+#endif
 }
 
 static void __init check_bugs(void)
diff -X ../KDIFX -burp linux/include/asm-i386/cpufeature.h linux-2.5.53-work/include/asm-i386/cpufeature.h
--- linux/include/asm-i386/cpufeature.h	2002-12-24 16:45:16.000000000 +0100
+++ linux-2.5.53-work/include/asm-i386/cpufeature.h	2002-12-24 16:45:04.000000000 +0100
@@ -75,6 +75,7 @@
 #define cpu_has_tsc		boot_cpu_has(X86_FEATURE_TSC)
 #define cpu_has_pae		boot_cpu_has(X86_FEATURE_PAE)
 #define cpu_has_pge		boot_cpu_has(X86_FEATURE_PGE)
+#define cpu_has_sse2		boot_cpu_has(X86_FEATURE_XMM2)
 #define cpu_has_apic		boot_cpu_has(X86_FEATURE_APIC)
 #define cpu_has_sep		boot_cpu_has(X86_FEATURE_SEP)
 #define cpu_has_mtrr		boot_cpu_has(X86_FEATURE_MTRR)
diff -X ../KDIFX -burp linux/include/asm-i386/system.h linux-2.5.53-work/include/asm-i386/system.h
--- linux/include/asm-i386/system.h	2002-11-30 13:58:19.000000000 +0100
+++ linux-2.5.53-work/include/asm-i386/system.h	2002-12-22 13:11:24.000000000 +0100
@@ -288,9 +288,13 @@ static inline unsigned long __cmpxchg(vo
  * nop for these.
  */
  
+#ifdef CONFIG_X86_SSE2
+#define mb()	asm volatile("mfence" ::: "memory")
+#define rmb()	asm volatile("lfence" ::: "memory")
+#else
 #define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
 #define rmb()	mb()
-
+#endif
 /**
  * read_barrier_depends - Flush all pending reads that subsequents reads
  * depend on.
