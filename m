Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263467AbUFFMmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUFFMmN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 08:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbUFFMmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 08:42:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45005 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263467AbUFFMlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 08:41:25 -0400
Date: Sun, 6 Jun 2004 14:41:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] better i386 and amd64 cpu selection
Message-ID: <20040606124119.GC5830@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch changes the way the CPUs are selected from the current
"select a reasonable setting that supports all your CPUs, and for
further optimizations for more than one CPU type you might also want to
enable X86_GENERIC" to "select all CPUs your kernel should support"
which is a better understandable semantics for users (= people
configuring a kernel).

As a side effect, further optimizations are possible based on this 
patch, but they are _not_ included.

It's now updated for 2.6.7-rc2.

This patch was too late for 2.6, but I'll try to resubmit once 2.7 
opens.

Changes:

- changed the CPU selection from a choice to single options for
  every cpu
- X86_GENERIC is no longer required
- renamed the M* variables to CPU_*, this is needed to ask the users
  upgrading from older kernels instead of silently changing the
  semantics
- X86_GOOD_APIC -> X86_BAD_APIC
- help text changes/updates

TODO:
- module versioning


The main effect is that this patch makes it easier for people who configure
kernels that should work on different CPU types.  A user (= person compiling
his own kernel) does no longer need any deeper knowledge when e.g. 
configuring a kernel that should run on both an Athlon and a Pentium 4 - he
simply selects all CPUs he wants to support in his kernel.

As a side effect, this patch allows further optimizations based on the fact
that e.g.  a kernel for an i386 no longer needs to support an Athlon which
can be used to omit support for non-selected CPUs.  For exampler there is no
need to include arch/i386/kernel/cpu/amd.c in your kernel if the kernel
should only run on a 386; I made two such example patches that are _way_ too
ugly for merging but show that this CPU selection scheme makes some more
space savings possible




--- 25/arch/i386/lib/mmx.c~better-i386-cpu-selection	2004-01-22 23:09:50.000000000 -0800
+++ 25-akpm/arch/i386/lib/mmx.c	2004-01-22 23:09:50.000000000 -0800
@@ -121,7 +121,7 @@ void *_mmx_memcpy(void *to, const void *
 	return p;
 }
 
-#ifdef CONFIG_MK7
+#ifdef CONFIG_CPU_ONLY_K7
 
 /*
  *	The K7 has streaming cache bypass load/store. The Cyrix III, K6 and
--- 25/include/asm-i386/apic.h~better-i386-cpu-selection	2004-01-22 23:09:50.000000000 -0800
+++ 25-akpm/include/asm-i386/apic.h	2004-01-22 23:09:50.000000000 -0800
@@ -41,7 +41,7 @@ static __inline__ void apic_wait_icr_idl
 	do { } while ( apic_read( APIC_ICR ) & APIC_ICR_BUSY );
 }
 
-#ifdef CONFIG_X86_GOOD_APIC
+#ifndef CONFIG_X86_BAD_APIC
 # define FORCE_READ_AROUND_WRITE 0
 # define apic_read_around(x)
 # define apic_write_around(x,y) apic_write((x),(y))
@@ -56,7 +56,7 @@ static inline void ack_APIC_irq(void)
 	/*
 	 * ack_APIC_irq() actually gets compiled as a single instruction:
 	 * - a single rmw on Pentium/82489DX
-	 * - a single write on P6+ cores (CONFIG_X86_GOOD_APIC)
+	 * - a single write on P6+ cores (!CONFIG_X86_BAD_APIC)
 	 * ... yummie.
 	 */
 
--- 25/include/asm-x86_64/apic.h~better-i386-cpu-selection	2004-01-22 23:09:50.000000000 -0800
+++ 25-akpm/include/asm-x86_64/apic.h	2004-01-22 23:09:50.000000000 -0800
@@ -52,7 +52,7 @@ static inline void ack_APIC_irq(void)
 	/*
 	 * ack_APIC_irq() actually gets compiled as a single instruction:
 	 * - a single rmw on Pentium/82489DX
-	 * - a single write on P6+ cores (CONFIG_X86_GOOD_APIC)
+	 * - a single write on P6+ cores (!CONFIG_X86_BAD_APIC)
 	 * ... yummie.
 	 */
 

_
--- linux-2.6.6/arch/i386/mach-voyager/voyager_smp.c.old	2004-05-17 01:45:56.000000000 +0200
+++ linux-2.6.6/arch/i386/mach-voyager/voyager_smp.c	2004-05-17 01:46:00.000000000 +0200
@@ -553,7 +553,7 @@
 
 	/* For the 486, we can't use the 4Mb page table trick, so
 	 * must map a region of memory */
-#ifdef CONFIG_M486
+#ifdef CONFIG_CPU_486
 	int i;
 	unsigned long *page_table_copies = (unsigned long *)
 		__get_free_page(GFP_KERNEL);
@@ -610,7 +610,7 @@
 	/* set the original swapper_pg_dir[0] to map 0 to 4Mb transparently
 	 * (so that the booting CPU can find start_32 */
 	orig_swapper_pg_dir0 = swapper_pg_dir[0];
-#ifdef CONFIG_M486
+#ifdef CONFIG_CPU_486
 	if(page_table_copies == NULL)
 		panic("No free memory for 486 page tables\n");
 	for(i = 0; i < PAGE_SIZE/sizeof(unsigned long); i++)
@@ -669,7 +669,7 @@
 	/* reset the page table */
 	swapper_pg_dir[0] = orig_swapper_pg_dir0;
 	local_flush_tlb();
-#ifdef CONFIG_M486
+#ifdef CONFIG_CPU_486
 	free_page((unsigned long)page_table_copies);
 #endif
 	  
--- linux-2.6.6/arch/i386/Makefile.old	2004-05-17 01:45:56.000000000 +0200
+++ linux-2.6.6/arch/i386/Makefile	2004-05-17 01:46:00.000000000 +0200
@@ -26,30 +26,47 @@
 
 align := $(subst -functions=0,,$(call check_gcc,-falign-functions=0,-malign-functions=0))
 
-cflags-$(CONFIG_M386)		+= -march=i386
-cflags-$(CONFIG_M486)		+= -march=i486
-cflags-$(CONFIG_M586)		+= -march=i586
-cflags-$(CONFIG_M586TSC)	+= -march=i586
-cflags-$(CONFIG_M586MMX)	+= $(call check_gcc,-march=pentium-mmx,-march=i586)
-cflags-$(CONFIG_M686)		+= -march=i686
-cflags-$(CONFIG_MPENTIUMII)	+= $(call check_gcc,-march=pentium2,-march=i686)
-cflags-$(CONFIG_MPENTIUMIII)	+= $(call check_gcc,-march=pentium3,-march=i686)
-cflags-$(CONFIG_MPENTIUMM)	+= $(call check_gcc,-march=pentium3,-march=i686)
-cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
-cflags-$(CONFIG_MK6)		+= -march=k6
+cflags-$(CONFIG_CPU_PENTIUM4)	:= $(call check_gcc,-march=pentium4,-march=i686)
+
+ifdef CONFIG_CPU_PENTIUM4
+  cflags-$(CONFIG_CPU_K8)	:= $(call check_gcc,-march=pentium3,-march=i686)
+else
+  cflags-$(CONFIG_CPU_K8)	:= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
+endif
+
 # Please note, that patches that add -march=athlon-xp and friends are pointless.
 # They make zero difference whatsosever to performance at this time.
-cflags-$(CONFIG_MK7)		+= $(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4)
-cflags-$(CONFIG_MK8)		+= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
-cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
-cflags-$(CONFIG_MWINCHIPC6)	+= $(call check_gcc,-march=winchip-c6,-march=i586)
-cflags-$(CONFIG_MWINCHIP2)	+= $(call check_gcc,-march=winchip2,-march=i586)
-cflags-$(CONFIG_MWINCHIP3D)	+= $(call check_gcc,-march=winchip2,-march=i586)
-cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i486) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
-cflags-$(CONFIG_MVIAC3_2)	+= $(call check_gcc,-march=c3-2,-march=i686)
+ifdef CONFIG_CPU_PENTIUM4
+  cflags-$(CONFIG_CPU_K7)	:= $(call check_gcc,-march=pentium3,-march=i686)
+else
+  cflags-$(CONFIG_CPU_K7)	:= $(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4)
+endif
+
+cflags-$(CONFIG_CPU_PENTIUMM)		:= $(call check_gcc,-march=pentium3,-march=i686)
+cflags-$(CONFIG_CPU_PENTIUMIII)	:= $(call check_gcc,-march=pentium3,-march=i686)
+cflags-$(CONFIG_CPU_PENTIUMII)	:= $(call check_gcc,-march=pentium2,-march=i686)
+cflags-$(CONFIG_CPU_VIAC3_2)  	:= $(call check_gcc,-march=c3-2,-march=i686)
+cflags-$(CONFIG_CPU_CRUSOE)		:= -march=i686 $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
+cflags-$(CONFIG_CPU_686)      	:= -march=i686
+
+# supports i686 without cmov
+cflags-$(CONFIG_CPU_CYRIXIII)	:= $(call check_gcc,-march=c3,-march=i486) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
+
+cflags-$(CONFIG_CPU_K6)	:= -march=k6
+cflags-$(CONFIG_CPU_586MMX)	:= $(call check_gcc,-march=pentium-mmx,-march=i586)
+
+# Winchip supports i586
+cflags-$(CONFIG_CPU_WINCHIPC6)	:= $(call check_gcc,-march=winchip-c6,-march=i486)
+cflags-$(CONFIG_CPU_WINCHIP2)		:= $(call check_gcc,-march=winchip2,-march=i486)
+cflags-$(CONFIG_CPU_WINCHIP3D)	:= $(call check_gcc,-march=winchip2,-march=i486)
+
+cflags-$(CONFIG_CPU_586TSC)	:= -march=i586
+cflags-$(CONFIG_CPU_586)	:= -march=i586
+cflags-$(CONFIG_CPU_486)	:= -march=i486
+cflags-$(CONFIG_CPU_386)	:= -march=i386
 
 # AMD Elan support
-cflags-$(CONFIG_X86_ELAN)	+= -march=i486
+cflags-$(CONFIG_X86_ELAN)	:= -march=i486
 
 # -mregparm=3 works ok on gcc-3.0 and later
 #
--- linux-2.6.6/drivers/serial/8250.h.old	2004-05-17 01:45:56.000000000 +0200
+++ linux-2.6.6/drivers/serial/8250.h	2004-05-17 01:46:00.000000000 +0200
@@ -35,7 +35,7 @@
 
 #undef SERIAL_DEBUG_PCI
 
-#if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
+#if defined(__i386__) && (defined(CONFIG_CPU_386) || defined(CONFIG_CPU_486))
 #define SERIAL_INLINE
 #endif
   
--- linux-2.6.6/include/asm-i386/bugs.h.old	2004-05-17 01:45:56.000000000 +0200
+++ linux-2.6.6/include/asm-i386/bugs.h	2004-05-17 01:46:00.000000000 +0200
@@ -152,9 +152,8 @@
  * - In order to run on anything without a TSC, we need to be
  *   compiled for a i486.
  * - In order to support the local APIC on a buggy Pentium machine,
- *   we need to be compiled with CONFIG_X86_GOOD_APIC disabled,
- *   which happens implicitly if compiled for a Pentium or lower
- *   (unless an advanced selection of CPU features is used) as an
+ *   we need to be compiled with CONFIG_X86_BAD_APIC enabled,
+ *   which happens implicitly if compiled for a Pentium as an
  *   otherwise config implies a properly working local APIC without
  *   the need to do extra reads from the APIC.
 */
@@ -185,7 +184,7 @@
  * integrated APIC (see 11AP erratum in "Pentium Processor
  * Specification Update").
  */
-#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_GOOD_APIC)
+#if defined(CONFIG_X86_LOCAL_APIC) && !defined(CONFIG_X86_BAD_APIC)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL
 	    && cpu_has_apic
 	    && boot_cpu_data.x86 == 5
--- linux-2.6.6/include/asm-i386/module.h.old	2004-05-17 01:45:56.000000000 +0200
+++ linux-2.6.6/include/asm-i386/module.h	2004-05-17 01:46:00.000000000 +0200
@@ -51,7 +51,7 @@
 #elif defined CONFIG_MVIAC3_2
 #define MODULE_PROC_FAMILY "VIAC3-2 "
 #else
-#error unknown processor family
+#define MODULE_PROC_FAMILY "this needs to be fixed"
 #endif
 
 #ifdef CONFIG_REGPARM
--- linux-2.6.7-rc2/include/asm-i386/processor.h.old	2004-06-06 12:03:38.000000000 +0200
+++ linux-2.6.7-rc2/include/asm-i386/processor.h	2004-06-06 12:08:48.000000000 +0200
@@ -587,7 +587,7 @@
 #define K7_NOP7        ".byte 0x8D,0x04,0x05,0,0,0,0\n"
 #define K7_NOP8        K7_NOP7 ASM_NOP1
 
-#ifdef CONFIG_MK8
+#ifdef CONFIG_CPU_ONLY_K8
 #define ASM_NOP1 K8_NOP1
 #define ASM_NOP2 K8_NOP2
 #define ASM_NOP3 K8_NOP3
@@ -596,7 +596,7 @@
 #define ASM_NOP6 K8_NOP6
 #define ASM_NOP7 K8_NOP7
 #define ASM_NOP8 K8_NOP8
-#elif defined(CONFIG_MK7)
+#elif defined(CONFIG_CPU_ONLY_K7)
 #define ASM_NOP1 K7_NOP1
 #define ASM_NOP2 K7_NOP2
 #define ASM_NOP3 K7_NOP3
--- linux-2.6.7-rc2/arch/i386/Kconfig.old	2004-06-06 12:03:47.000000000 +0200
+++ linux-2.6.7-rc2/arch/i386/Kconfig	2004-06-06 12:08:48.000000000 +0200
@@ -137,289 +137,267 @@
 config ES7000_CLUSTERED_APIC
 	bool
 	default y
-	depends on SMP && X86_ES7000 && MPENTIUMIII
+	depends on SMP && X86_ES7000 && CPU_PENTIUMIII
 
 if !X86_ELAN
 
-choice
-	prompt "Processor family"
-	default M686
+menu "Processor support"
 
-config M386
-	bool "386"
-	---help---
-	  This is the processor type of your CPU. This information is used for
-	  optimizing purposes. In order to compile a kernel that can run on
-	  all x86 CPU types (albeit not optimally fast), you can specify
-	  "386" here.
-
-	  The kernel will not necessarily run on earlier architectures than
-	  the one you have chosen, e.g. a Pentium optimized kernel will run on
-	  a PPro, but not necessarily on a i486.
-
-	  Here are the settings recommended for greatest speed:
-	  - "386" for the AMD/Cyrix/Intel 386DX/DXL/SL/SLC/SX, Cyrix/TI
-	  486DLC/DLC2, UMC 486SX-S and NexGen Nx586.  Only "386" kernels
-	  will run on a 386 class machine.
-	  - "486" for the AMD/Cyrix/IBM/Intel 486DX/DX2/DX4 or
-	  SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or U5S.
-	  - "586" for generic Pentium CPUs lacking the TSC
-	  (time stamp counter) register.
-	  - "Pentium-Classic" for the Intel Pentium.
-	  - "Pentium-MMX" for the Intel Pentium MMX.
-	  - "Pentium-Pro" for the Intel Pentium Pro.
-	  - "Pentium-II" for the Intel Pentium II or pre-Coppermine Celeron.
-	  - "Pentium-III" for the Intel Pentium III or Coppermine Celeron.
-	  - "Pentium-4" for the Intel Pentium 4 or P4-based Celeron.
-	  - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
-	  - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
-	  - "Crusoe" for the Transmeta Crusoe series.
-	  - "Winchip-C6" for original IDT Winchip.
-	  - "Winchip-2" for IDT Winchip 2.
-	  - "Winchip-2A" for IDT Winchips with 3dNow! capabilities.
-	  - "CyrixIII/VIA C3" for VIA Cyrix III or VIA C3.
-	  - "VIA C3-2 for VIA C3-2 "Nehemiah" (model 9 and above).
+comment "Select all processors your kernel should support"
 
-	  If you don't know what to do, choose "386".
+config CPU_386
+	bool "386"
+	default n
+	help
+	  Select this for a 386 series processor.
 
-config M486
+config CPU_486
 	bool "486"
+	default y
 	help
 	  Select this for a 486 series processor, either Intel or one of the
 	  compatible processors from AMD, Cyrix, IBM, or Intel.  Includes DX,
 	  DX2, and DX4 variants; also SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or
 	  U5S.
 
-config M586
+config CPU_586
 	bool "586/K5/5x86/6x86/6x86MX"
+	default y
 	help
-	  Select this for an 586 or 686 series processor such as the AMD K5,
-	  the Intel 5x86 or 6x86, or the Intel 6x86MX.  This choice does not
-	  assume the RDTSC (Read Time Stamp Counter) instruction.
+	  Select this for a non-Intel 586 or 686 series processor such as
+	  the AMD K5 or the Cyrix 6x86MX.
+
+	  Several CPUs that have their own options below (e.g. AMD K6,
+	  Duron, Athlon and Opteeron, IDT Winchip, Cyrix III and
+	  VIA C3) do _not_ need this option.
 
-config M586TSC
+	  This choice does not assume the RDTSC (Read Time Stamp Counter)
+	  instruction.
+
+config CPU_586TSC
 	bool "Pentium-Classic"
+	default y
 	help
 	  Select this for a Pentium Classic processor with the RDTSC (Read
-	  Time Stamp Counter) instruction for benchmarking.
+	  Time Stamp Counter) instruction.
 
-config M586MMX
+config CPU_586MMX
 	bool "Pentium-MMX"
+	default y
 	help
 	  Select this for a Pentium with the MMX graphics/multimedia
 	  extended instructions.
 
-config M686
+config CPU_686
 	bool "Pentium-Pro"
+	default y
 	help
-	  Select this for Intel Pentium Pro chips.  This enables the use of
-	  Pentium Pro extended instructions, and disables the init-time guard
-	  against the f00f bug found in earlier Pentiums.
+	  Select this for Intel Pentium Pro chips.
 
-config MPENTIUMII
+config CPU_PENTIUMII
 	bool "Pentium-II/Celeron(pre-Coppermine)"
+	default y
 	help
 	  Select this for Intel chips based on the Pentium-II and
-	  pre-Coppermine Celeron core.  This option enables an unaligned
-	  copy optimization, compiles the kernel with optimization flags
-	  tailored for the chip, and applies any applicable Pentium Pro
-	  optimizations.
+	  pre-Coppermine Celeron core.
 
-config MPENTIUMIII
+config CPU_PENTIUMIII
 	bool "Pentium-III/Celeron(Coppermine)/Pentium-III Xeon"
+	default y
 	help
 	  Select this for Intel chips based on the Pentium-III and
-	  Celeron-Coppermine core.  This option enables use of some
-	  extended prefetch instructions in addition to the Pentium II
-	  extensions.
+	  Celeron-Coppermine core.
 
-config MPENTIUMM
+config CPU_PENTIUMM
 	bool "Pentium M"
+	default y
 	help
 	  Select this for Intel Pentium M (not Pentium-4 M)
 	  notebook chips.
 
-config MPENTIUM4
+config CPU_PENTIUM4
 	bool "Pentium-4/Celeron(P4-based)/Pentium-4 M/Xeon"
+	default y
 	help
-	  Select this for Intel Pentium 4 chips.  This includes the
-	  Pentium 4, P4-based Celeron and Xeon, and Pentium-4 M
-	  (not Pentium M) chips.  This option enables compile flags
-	  optimized for the chip, uses the correct cache shift, and
-	  applies any applicable Pentium III optimizations.
+	  Select this for Intel Pentium 4 chips.  This includes
+	  the Pentium 4, P4-based Celeron and Xeon, and
+	  Pentium-4 M (not Pentium M) chips.
 
-config MK6
+config CPU_K6
 	bool "K6/K6-II/K6-III"
+	default y
 	help
-	  Select this for an AMD K6-family processor.  Enables use of
-	  some extended instructions, and passes appropriate optimization
-	  flags to GCC.
+	  Select this for an AMD K6, K6-II or K6-III (aka K6-3D).
 
-config MK7
+config CPU_K7
 	bool "Athlon/Duron/K7"
+	default y
 	help
-	  Select this for an AMD Athlon K7-family processor.  Enables use of
-	  some extended instructions, and passes appropriate optimization
-	  flags to GCC.
+	  Select this for an AMD Athlon K7-family processor.
 
-config MK8
+config CPU_K8
 	bool "Opteron/Athlon64/Hammer/K8"
+	default y
 	help
-	  Select this for an AMD Opteron or Athlon64 Hammer-family processor.  Enables
-	  use of some extended instructions, and passes appropriate optimization
-	  flags to GCC.
+	  Select this for an AMD Opteron or Athlon64 Hammer-family processor.
 
-config MCRUSOE
+config CPU_CRUSOE
 	bool "Crusoe"
+	default y
 	help
-	  Select this for a Transmeta Crusoe processor.  Treats the processor
-	  like a 586 with TSC, and sets some GCC optimization flags (like a
-	  Pentium Pro with no alignment requirements).
+	  Select this for a Transmeta Crusoe processor.
 
-config MWINCHIPC6
+config CPU_WINCHIPC6
 	bool "Winchip-C6"
+	default y
 	help
-	  Select this for an IDT Winchip C6 chip.  Linux and GCC
-	  treat this chip as a 586TSC with some extended instructions
-	  and alignment requirements.
+	  Select this for an IDT Winchip C6 chip.
 
-config MWINCHIP2
+config CPU_WINCHIP2
 	bool "Winchip-2"
+	default y
 	help
-	  Select this for an IDT Winchip-2.  Linux and GCC
-	  treat this chip as a 586TSC with some extended instructions
-	  and alignment requirements.
+	  Select this for an IDT Winchip-2.
 
-config MWINCHIP3D
+config CPU_WINCHIP3D
 	bool "Winchip-2A/Winchip-3"
+	default y
 	help
-	  Select this for an IDT Winchip-2A or 3.  Linux and GCC
-	  treat this chip as a 586TSC with some extended instructions
-	  and alignment reqirements.  Also enable out of order memory
-	  stores for this CPU, which can increase performance of some
-	  operations.
+	  Select this for an IDT Winchip-2A or 3 with 3dNow!
+	  capabilities.
 
-config MCYRIXIII
+config CPU_CYRIXIII
 	bool "CyrixIII/VIA-C3"
+	default y
 	help
-	  Select this for a Cyrix III or C3 chip.  Presently Linux and GCC
-	  treat this chip as a generic 586. Whilst the CPU is 686 class,
-	  it lacks the cmov extension which gcc assumes is present when
-	  generating 686 code.
-	  Note that Nehemiah (Model 9) and above will not boot with this
-	  kernel due to them lacking the 3DNow! instructions used in earlier
-	  incarnations of the CPU.
+	  Select this for a Cyrix III or VIA C3 chip.
 
-config MVIAC3_2
+config CPU_VIAC3_2
 	bool "VIA C3-2 (Nehemiah)"
+	default y
 	help
-	  Select this for a VIA C3 "Nehemiah". Selecting this enables usage
-	  of SSE and tells gcc to treat the CPU as a 686.
-	  Note, this kernel will not boot on older (pre model 9) C3s.
+	  Select this for a VIA C3 "Nehemiah" (model 9 and above).
 
-endchoice
+endmenu
 
-config X86_GENERIC
-       bool "Generic x86 support" 
-       help
-	  Instead of just including optimizations for the selected
-	  x86 variant (e.g. PII, Crusoe or Athlon), include some more
-	  generic optimizations as well. This will make the kernel
-	  perform better on x86 CPUs other than that selected.
+endif
 
-	  This is really intended for distributors who need more
-	  generic optimizations.
+#
+# helper options
+#
+config CPU_INTEL
+	bool
+	depends on CPU_386 || CPU_486 || CPU_586TSC || CPU_686 || CPU_PENTIUMII || CPU_PENTIUMIII || CPU_PENTIUMM || CPU_PENTIUM4
+	default y
 
-endif
+config CPU_WINCHIP
+	bool
+	depends on CPU_WINCHIPC6 || CPU_WINCHIP2 || CPU_WINCHIP3D
+	default y
+
+config CPU_ONLY_K7
+	bool
+	depends on CPU_K7 && !CPU_INTEL && !CPU_K6 && !CPU_K8 && !X86_ELAN && !CPU_CRUSOE && !CPU_WINCHIP && !CPU_CYRIXIII && !CPU_VIAC3_2
+	default y
+
+config CPU_ONLY_K8
+	bool
+	depends on CPU_K8 && !CPU_INTEL && !CPU_K6 && !CPU_K7 && !X86_ELAN && !CPU_CRUSOE && !CPU_WINCHIP && !CPU_CYRIXIII && !CPU_VIAC3_2
+	default y
+
+config CPU_ONLY_WINCHIP
+	bool
+	depends on CPU_WINCHIP && !CPU_INTEL && !CPU_K6 && !CPU_K7 && !CPU_K8 && !X86_ELAN && !CPU_CRUSOE && !CPU_CYRIXIII && !CPU_VIAC3_2
+	default y
 
 #
 # Define implied options from the CPU selection here
 #
 config X86_CMPXCHG
 	bool
-	depends on !M386
+	depends on !CPU_386
 	default y
 
 config X86_XADD
 	bool
-	depends on !M386
+	depends on !CPU_386
 	default y
 
 config X86_L1_CACHE_SHIFT
 	int
-	default "7" if MPENTIUM4 || X86_GENERIC
-	default "4" if X86_ELAN || M486 || M386
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
-	default "6" if MK7 || MK8 || MPENTIUMM
+	default "7" if CPU_PENTIUM4
+	default "6" if CPU_K7 || CPU_K8 || CPU_PENTIUMM
+	default "5" if CPU_WINCHIP || CPU_CRUSOE || CPU_CYRIXIII || CPU_K6 || CPU_PENTIUMIII || CPU_PENTIUMII || CPU_686 || CPU_586MMX || CPU_586TSC || CPU_586 || CPU_VIAC3_2
+	default "4" if X86_ELAN || CPU_486 || CPU_386
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
-	depends on M386
+	depends on CPU_386
 	default y
 
 config RWSEM_XCHGADD_ALGORITHM
 	bool
-	depends on !M386
+	depends on !CPU_386
 	default y
 
 config X86_PPRO_FENCE
 	bool
-	depends on M686 || M586MMX || M586TSC || M586 || M486 || M386
+	depends on CPU_686
 	default y
 
 config X86_F00F_BUG
 	bool
-	depends on M586MMX || M586TSC || M586 || M486 || M386
+	depends on CPU_586MMX || CPU_586TSC
 	default y
 
 config X86_WP_WORKS_OK
 	bool
-	depends on !M386
+	depends on !CPU_386
 	default y
 
 config X86_INVLPG
 	bool
-	depends on !M386
+	depends on !CPU_386
 	default y
 
 config X86_BSWAP
 	bool
-	depends on !M386
+	depends on !CPU_386
 	default y
 
 config X86_POPAD_OK
 	bool
-	depends on !M386
+	depends on !CPU_386
 	default y
 
 config X86_ALIGNMENT_16
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || X86_ELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2
+	depends on CPU_WINCHIP || CPU_CYRIXIII || X86_ELAN || CPU_K6 || CPU_586MMX || CPU_586TSC || CPU_586 || CPU_486 || CPU_VIAC3_2
 	default y
 
-config X86_GOOD_APIC
+config X86_BAD_APIC
 	bool
-	depends on MK7 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8
+	depends on CPU_586TSC
 	default y
 
 config X86_INTEL_USERCOPY
 	bool
-	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7
+	depends on CPU_K7 || CPU_K8 || CPU_PENTIUMII || CPU_PENTIUMIII || CPU_PENTIUMM || CPU_PENTIUM4
 	default y
 
 config X86_USE_PPRO_CHECKSUM
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2
+	depends on !CPU_386 && !CPU_486 && !CPU_586 && !CPU_586TSC && !CPU_586MMX && !X86_ELAN && !CPU_CRUSOE
 	default y
 
 config X86_USE_3DNOW
 	bool
-	depends on MCYRIXIII || MK7
+	depends on !CPU_INTEL && !CPU_K6 && !CPU_K8 && !X86_ELAN && !CPU_CRUSOE && !CPU_WINCHIP && !CPU_VIAC3_2
 	default y
 
 config X86_OOSTORE
 	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MWINCHIPC6) && MTRR
+	depends on CPU_ONLY_WINCHIP && MTRR
 	default y
 
 config HPET_TIMER
@@ -543,7 +521,7 @@
 
 config X86_TSC
 	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
+	depends on !X86_NUMAQ && !CPU_386 && !CPU_486 && !CPU_586 && !X86_ELAN && !CPU_WINCHIPC6
 	default y
 
 config X86_MCE
--- linux-2.6.7-rc2/arch/x86_64/Kconfig.old	2004-06-06 12:11:14.000000000 +0200
+++ linux-2.6.7-rc2/arch/x86_64/Kconfig	2004-06-06 12:11:55.000000000 +0200
@@ -83,49 +83,43 @@
 
 menu "Processor type and features"
 
-choice
-	prompt "Processor family"
-	default MK8
+menu "Processor support"
 
-config MK8
+comment "Select all processors your kernel should support"
+
+config CPU_K8
 	bool "AMD-Opteron/Athlon64"
+	default y
 	help
 	  Optimize for AMD Opteron/Athlon64/Hammer/K8 CPUs. 
 
-config MPSC
-       bool "Intel x86-64" 
-       help
+config CPU_PSC
+	bool "Intel x86-64"
+	default y
+	help
 	  Optimize for Intel IA32 with 64bit extension CPUs
 	  (Prescott/Nocona/Potomac)
        
-config GENERIC_CPU
-	bool "Generic-x86-64"
-	help
-	  Generic x86-64 CPU.
 
-endchoice
+endmenu
 
 #
 # Define implied options from the CPU selection here
 #
 config X86_L1_CACHE_BYTES
 	int
-	default "128" if GENERIC_CPU || MPSC
-	default "64" if MK8
+	default "128" if CPU_PSC
+	default "64" if CPU_K8
 
 config X86_L1_CACHE_SHIFT
 	int
-	default "7" if GENERIC_CPU || MPSC
-	default "6" if MK8
+	default "7" if CPU_PSC
+	default "6" if CPU_K8
 
 config X86_TSC
 	bool
 	default y
 
-config X86_GOOD_APIC
-	bool
-	default y
-
 config MICROCODE
 	tristate "/dev/cpu/microcode - Intel CPU microcode support"
 	---help---
@@ -163,7 +157,7 @@
 # disable it for opteron optimized builds because it pulls in ACPI_BOOT
 config X86_HT
 	bool
-	depends on SMP && !MK8
+	depends on SMP && CPU_PSC
 	default y
        
 config MATH_EMULATION
--- linux-2.6.7-rc2-mm2/arch/x86_64/Makefile.old	2004-06-06 14:30:55.000000000 +0200
+++ linux-2.6.7-rc2-mm2/arch/x86_64/Makefile	2004-06-06 14:40:01.000000000 +0200
@@ -37,8 +37,13 @@
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux := -e stext
 
-cflags-$(CONFIG_MK8) += $(call check_gcc,-march=k8,)
-cflags-$(CONFIG_MPSC) += $(call check_gcc,-march=nocona,)
+ifndef CONFIG_CPU_PSC
+  cflags-$(CONFIG_CPU_K8)	+= $(call check_gcc,-march=k8,)
+endif
+ifndef CONFIG_CPU_K8
+  cflags-$(CONFIG_CPU_PSC)	+= $(call check_gcc,-march=nocona,)
+endif
+
 CFLAGS += $(cflags-y)
 
 CFLAGS += -mno-red-zone
