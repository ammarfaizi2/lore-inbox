Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbTIGL2n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 07:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTIGL2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 07:28:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18123 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263220AbTIGL2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 07:28:20 -0400
Date: Sun, 7 Sep 2003 13:28:13 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, robert@schwebel.de
Subject: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030907112813.GQ14436@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below tries to implement a better i386 CPU selection.

In 2.4 selecting e.g. M486 has the semantics to get a kernel that runs 
on a 486 and above.

In 2.6 selecting M486 means that only the 486 is supported.

The help text for the X86_GENERIC option says it generates a generic 
kernel but the implementation is that it supports CPUs of the selected 
M* option and above.

There are two different needs:
1. the installation kernel of a distribution should support all CPUs 
   this distribution supports (perhaps starting with the 386)
2. a sysadmin might e.g. want a kernel that support both a Pentium-III
   and a Pentium 4, but doesn't need to support a 386

The implementation in 2.4 was near to satisfy need 2., if X86_GENERIC in 
2.6 was implemented as the help text says it would satisfy the need
of 1.

The patch below against 2.6.0-test4-mm5 does a different implementation
that lets you select all CPUs you want to support and it should
therefore suit both needs.

Changes:
- changed the i386 CPU selection from a choice to single options for
  every cpu
- renamed the M* variables to CPU_*, this is needed to ask the users
  upgrading from older kernels instead of silently changing the 
  semantics
- AMD Elan is a different subarch, you can't configure a kernel that 
  runs on both the AMD Elan and other i386 CPUs
- help text changes

Questions/TODO:
- @Rusty:
  what's your opinion on making MODULE_PROC_FAMILY in 
  include/asm-i386/module.h some kind of bitmask?
- @Robert:
  there were no Elan CFLAGS in arch/i386/Makefile???
- which CPUs exactly need X86_ALIGNMENT_16?
- X86_GOOD_APIC: are there really that many processors with a bad APIC?
- could someone with a deeper knowledge of i386 CPUs comment on whether
  I got the CFLAGS in arch/i386/Makefile right for all possible CPU
  combinations?
- Kconfig handling of no CPU selected

diffstat output:

 arch/i386/Kconfig            |  237 ++++++++++++++---------------------
 arch/i386/Makefile           |   98 +++++++++++---
 arch/i386/boot/setup.S       |    2
 drivers/serial/8250.h        |    2
 include/asm-i386/processor.h |    4
 include/asm-i386/timex.h     |    2
 6 files changed, 184 insertions(+), 161 deletions(-)


A 2.6.0-test4-mm5 kernel with this patch applied compiled and bootet on
my PC.


cu
Adrian

--- linux-2.6.0-test4-mm5/arch/i386/Kconfig.old	2003-09-05 08:34:00.000000000 +0200
+++ linux-2.6.0-test4-mm5/arch/i386/Kconfig	2003-09-05 13:02:46.000000000 +0200
@@ -43,6 +43,15 @@
 	help
 	  Choose this option if your computer is a standard PC or compatible.
 
+config X86_ELAN
+	bool "Elan"
+	help
+	  Select this for an AMD Elan processor.
+	
+	  Do not use this option for K6/Athlon/Opteron processors!
+	
+	  If unsure choose "PC-compatible" instead.
+
 config X86_VOYAGER
 	bool "Voyager (NCR)"
 	help
@@ -125,48 +134,19 @@
 	default y
 	depends on SMP && X86_ES7000 && MPENTIUMIII
 
-choice
-	prompt "Processor family"
-	default M686
 
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
+if !X86_ELAN
 
-	  If you don't know what to do, choose "386".
+menu "Processor support"
 
-config M486
+comment "Select all processors your kernel should support"
+
+config CPU_386
+	bool "386"
+	help
+	  Select this for a 386 series processor.
+
+config CPU_486
 	bool "486"
 	help
 	  Select this for a 486 series processor, either Intel or one of the
@@ -174,227 +154,210 @@
 	  DX2, and DX4 variants; also SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or
 	  U5S.
 
-config M586
+config CPU_586
 	bool "586/K5/5x86/6x86/6x86MX"
 	help
 	  Select this for an 586 or 686 series processor such as the AMD K5,
 	  the Intel 5x86 or 6x86, or the Intel 6x86MX.  This choice does not
 	  assume the RDTSC (Read Time Stamp Counter) instruction.
 
-config M586TSC
+config CPU_586TSC
 	bool "Pentium-Classic"
 	help
 	  Select this for a Pentium Classic processor with the RDTSC (Read
-	  Time Stamp Counter) instruction for benchmarking.
+	  Time Stamp Counter) instruction.
 
-config M586MMX
+config CPU_586MMX
 	bool "Pentium-MMX"
 	help
 	  Select this for a Pentium with the MMX graphics/multimedia
 	  extended instructions.
 
-config M686
+config CPU_686
 	bool "Pentium-Pro"
 	help
-	  Select this for Intel Pentium Pro chips.  This enables the use of
-	  Pentium Pro extended instructions, and disables the init-time guard
-	  against the f00f bug found in earlier Pentiums.
+	  Select this for Intel Pentium Pro chips.
 
-config MPENTIUMII
+config CPU_PENTIUMII
 	bool "Pentium-II/Celeron(pre-Coppermine)"
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
 	help
 	  Select this for Intel chips based on the Pentium-III and
-	  Celeron-Coppermine core.  This option enables use of some
-	  extended prefetch instructions in addition to the Pentium II
-	  extensions.
+	  Celeron-Coppermine core.
 
-config MPENTIUM4
+config CPU_PENTIUM4
 	bool "Pentium-4/Celeron(P4-based)/Xeon"
 	help
 	  Select this for Intel Pentium 4 chips.  This includes both
-	  the Pentium 4 and P4-based Celeron chips.  This option
-	  enables compile flags optimized for the chip, uses the
-	  correct cache shift, and applies any applicable Pentium III
-	  optimizations.
+	  the Pentium 4 and P4-based Celeron chips.
 
-config MK6
+config CPU_K6
 	bool "K6/K6-II/K6-III"
 	help
-	  Select this for an AMD K6-family processor.  Enables use of
-	  some extended instructions, and passes appropriate optimization
-	  flags to GCC.
+	  Select this for an AMD K6, K6-II or K6-III (aka K6-3D).
 
-config MK7
+config CPU_K7
 	bool "Athlon/Duron/K7"
 	help
-	  Select this for an AMD Athlon K7-family processor.  Enables use of
-	  some extended instructions, and passes appropriate optimization
-	  flags to GCC.
+	  Select this for an AMD Athlon K7-family processor.
 
-config MK8
+config CPU_K8
 	bool "Opteron/Athlon64/Hammer/K8"
 	help
-	  Select this for an AMD Opteron or Athlon64 Hammer-family processor.  Enables
-	  use of some extended instructions, and passes appropriate optimization
-	  flags to GCC.
+	  Select this for an AMD Opteron or Athlon64 Hammer-family processor.
 
-config MELAN
-	bool "Elan"
-
-config MCRUSOE
+config CPU_CRUSOE
 	bool "Crusoe"
 	help
-	  Select this for a Transmeta Crusoe processor.  Treats the processor
-	  like a 586 with TSC, and sets some GCC optimization flags (like a
-	  Pentium Pro with no alignment requirements).
+	  Select this for a Transmeta Crusoe processor.
 
-config MWINCHIPC6
+config CPU_WINCHIPC6
 	bool "Winchip-C6"
 	help
-	  Select this for an IDT Winchip C6 chip.  Linux and GCC
-	  treat this chip as a 586TSC with some extended instructions
-	  and alignment requirements.
+	  Select this for an IDT Winchip C6 chip.
 
-config MWINCHIP2
+config CPU_WINCHIP2
 	bool "Winchip-2"
 	help
-	  Select this for an IDT Winchip-2.  Linux and GCC
-	  treat this chip as a 586TSC with some extended instructions
-	  and alignment requirements.
+	  Select this for an IDT Winchip-2.
 
-config MWINCHIP3D
+config CPU_WINCHIP3D
 	bool "Winchip-2A/Winchip-3"
 	help
-	  Select this for an IDT Winchip-2A or 3.  Linux and GCC
-	  treat this chip as a 586TSC with some extended instructions
-	  and alignment reqirements.  Also enable out of order memory
-	  stores for this CPU, which can increase performance of some
-	  operations.
-
-config MCYRIXIII
-	bool "CyrixIII/VIA-C3"
-	help
-	  Select this for a Cyrix III or C3 chip.  Presently Linux and GCC
-	  treat this chip as a generic 586. Whilst the CPU is 686 class,
-	  it lacks the cmov extension which gcc assumes is present when
-	  generating 686 code.
-	  Note that Nehemiah (Model 9) and above will not boot with this
-	  kernel due to them lacking the 3DNow! instructions used in earlier
-	  incarnations of the CPU.
+	  Select this for an IDT Winchip-2A or 3 with 3dNow!
+	  capabilities.
+
+config CPU_CYRIXIII
+	bool "Cyrix III/VIA C3"
+	help
+	  Select this for a Cyrix III or VIA C3 chip.
 
-config MVIAC3_2
+	  Note that Nehemiah (Model 9) and above need the next
+	  option instead.
+
+config CPU_VIAC3_2
 	bool "VIA C3-2 (Nehemiah)"
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
-       	  Including some tuning for non selected x86 CPUs too.
-	  when it has moderate overhead. This is intended for generic 
-	  distributions kernels.
+endif
+
+#
+# helper options
+#
+config CPU_WINCHIP
+	bool
+	depends on CPU_WINCHIPC6 || CPU_WINCHIP2 || CPU_WINCHIP3D
+	default y
+
+config CPU_ONLY_K7
+	bool
+	depends on CPU_K7 && !CPU_386 && !CPU_486 && !CPU_586 && !CPU_586TSC && !CPU_586MMX && !CPU_686 && !CPU_PENTIUMII && !CPU_PENTIUMIII && !CPU_PENTIUM4 && !CPU_K6 && !CPU_K8 && !X86_ELAN && !CPU_CRUSOE && !CPU_WINCHIP && !CPU_CYRIXIII && !CPU_VIAC3_2
+
+config CPU_ONLY_K8
+	bool
+	depends on CPU_K8 && !CPU_386 && !CPU_486 && !CPU_586 && !CPU_586TSC && !CPU_586MMX && !CPU_686 && !CPU_PENTIUMII && !CPU_PENTIUMIII && !CPU_PENTIUM4 && !CPU_K6 && !CPU_K7 && !X86_ELAN && !CPU_CRUSOE && !CPU_WINCHIP && !CPU_CYRIXIII && !CPU_VIAC3_2
+
+config CPU_ONLY_WINCHIP
+	bool
+	depends on CPU_WINCHIP && !CPU_386 && !CPU_486 && !CPU_586 && !CPU_586TSC && !CPU_586MMX && !CPU_686 && !CPU_PENTIUMII && !CPU_PENTIUMIII && !CPU_PENTIUM4 && !CPU_K6 && !CPU_K7 && !CPU_K8 && !X86_ELAN && !CPU_CRUSOE && !CPU_CYRIXIII && !CPU_VIAC3_2
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
-	default "4" if MELAN || M486 || M386
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
-	default "6" if MK7 || MK8
+	default "7" if CPU_PENTIUM4
+	default "6" if CPU_K7 || CPU_K8
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
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2
+	depends on CPU_WINCHIP || CPU_CYRIXIII || X86_ELAN || CPU_K6 || CPU_586MMX || CPU_586TSC || CPU_586 || CPU_486 || CPU_VIAC3_2
 	default y
 
 config X86_GOOD_APIC
 	bool
-	depends on MK7 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8
+	depends on !CPU_386 && !CPU_486 && !CPU_586 && !CPU_586TSC && !CPU_K6 && !X86_ELAN && !CPU_CRUSOE && !CPU_WINCHIP && !CPU_CYRIXIII && !CPU_VIAC3_2
 	default y
 
 config X86_INTEL_USERCOPY
 	bool
-	depends on MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7
+	depends on !CPU_386 && !CPU_486 && !CPU_586 && !CPU_586TSC && !CPU_686 && !CPU_K6 && !X86_ELAN && !CPU_CRUSOE && !CPU_WINCHIP && !CPU_CYRIXIII && !CPU_VIAC3_2
 	default y
 
 config X86_USE_PPRO_CHECKSUM
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2
+	depends on !CPU_386 && !CPU_486 && !CPU_586 && !CPU_586TSC && !CPU_586MMX && !X86_ELAN && !CPU_CRUSOE
 	default y
 
 config X86_USE_3DNOW
 	bool
-	depends on MCYRIXIII || MK7
+	depends on !CPU_386 && !CPU_486 && !CPU_586 && !CPU_586TSC && !CPU_586MMX && !CPU_686 && !CPU_PENTIUMII && !CPU_PENTIUMIII && !CPU_PENTIUM4 && !CPU_K6 && !CPU_K8 && !X86_ELAN && !CPU_CRUSOE && !CPU_WINCHIP && !CPU_VIAC3_2
 	default y
 
 config X86_OOSTORE
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6
+	depends on CPU_ONLY_WINCHIP
 	default y
 
 config X86_4G
@@ -565,7 +528,7 @@
 
 config X86_TSC
 	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
+	depends on !X86_NUMAQ && !CPU_386 && !CPU_486 && !CPU_586 && !X86_ELAN && !CPU_WINCHIPC6
 	default y
 
 config X86_MCE
--- linux-2.6.0-test4-mm5/arch/i386/Makefile.old	2003-09-05 10:22:38.000000000 +0200
+++ linux-2.6.0-test4-mm5/arch/i386/Makefile	2003-09-05 13:03:02.000000000 +0200
@@ -28,28 +28,88 @@
 
 align := $(subst -functions=0,,$(call check_gcc,-falign-functions=0,-malign-functions=0))
 
-cflags-$(CONFIG_M386)		+= -march=i386
-cflags-$(CONFIG_M486)		+= -march=i486
-cflags-$(CONFIG_M586)		+= -march=i586
-cflags-$(CONFIG_M586TSC)	+= -march=i586
-cflags-$(CONFIG_M586MMX)	+= $(call check_gcc,-march=pentium-mmx,-march=i586)
-cflags-$(CONFIG_M686)		+= -march=i686
-cflags-$(CONFIG_MPENTIUMII)	+= $(call check_gcc,-march=pentium2,-march=i686)
-cflags-$(CONFIG_MPENTIUMIII)	+= $(call check_gcc,-march=pentium3,-march=i686)
-cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
-cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
+ifdef CONFIG_CPU_PENTIUM4
+  CFLAGS_CPU	:= $(call check_gcc,-march=pentium4,-march=i686)
+endif
+
+ifdef CONFIG_CPU_PENTIUMIII
+CFLAGS_CPU	:= $(call check_gcc,-march=pentium3,-march=i686)
+endif
+
+ifdef CONFIG_CPU_PENTIUMII
+CFLAGS_CPU	:= $(call check_gcc,-march=pentium2,-march=i686)
+endif
+
+ifdef CONFIG_CPU_K8
+  CFLAGS_CPU	:= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
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
+ifdef CONFIG_CPU_K7
+  CFLAGS_CPU	:= $(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4)
+endif
+
+ifdef CONFIG_CPU_VIAC3_2
+  CFLAGS_CPU  := $(call check_gcc,-march=c3-2,-march=i686)
+endif
+
+ifdef CONFIG_CPU_CYRIXIII
+  CFLAGS_CPU	:= $(call check_gcc,-march=c3,-march=i486) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
+endif
+
+ifdef CONFIG_CPU_CRUSOE
+  CFLAGS_CPU	:= -march=i686 $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
+endif
+
+ifdef CONFIG_CPU_686
+  CFLAGS_CPU      := -march=i686
+endif
+
+ifdef CONFIG_CPU_K6
+  CFLAGS_CPU	:= $(call check_gcc,-march=k6,-march=i586)
+endif
+
+ifdef CONFIG_CPU_586MMX
+  CFLAGS_CPU	:= $(call check_gcc,-march=pentium-mmx,-march=i586)
+endif
+
+ifdef CONFIG_CPU_ONLY_WINCHIP
+  ifdef CONFIG_CPU_WINCHIPC6
+    CFLAGS_CPU	:= $(call check_gcc,-march=winchip-c6,-march=i586)
+  else
+    ifdef CONFIG_CPU_WINCHIP2
+      CFLAGS_CPU	:= $(call check_gcc,-march=winchip2,-march=i586)
+    else
+      ifdef CPU_WINCHIP3D
+        CFLAGS_CPU	:= $(call check_gcc,-march=winchip2,-march=i586)
+      endif
+    endif
+  endif
+else
+  ifdef CPU_WINCHIP
+    CFLAGS_CPU	:= -march=i586
+  endif
+endif
+
+ifdef CONFIG_CPU_586TSC
+CFLAGS_CPU	:= -march=i586
+endif
+
+ifdef CONFIG_CPU_586
+  CFLAGS_CPU	:= -march=i586
+endif
+
+ifdef CONFIG_CPU_486
+  CFLAGS_CPU	:= -march=i486
+endif
+
+ifdef CONFIG_CPU_386
+  CFLAGS_CPU	:= -march=i386
+endif
+
 
-CFLAGS += $(cflags-y)
+CFLAGS += $(CFLAGS_CPU)
 
 # Default subarch .c files
 mcore-y  := mach-default
--- linux-2.6.0-test4-mm5/include/asm-i386/processor.h.old	2003-09-05 12:46:37.000000000 +0200
+++ linux-2.6.0-test4-mm5/include/asm-i386/processor.h	2003-09-05 12:47:08.000000000 +0200
@@ -544,7 +544,7 @@
 #define K7_NOP7        ".byte 0x8D,0x04,0x05,0,0,0,0\n"
 #define K7_NOP8        K7_NOP7 ASM_NOP1
 
-#ifdef CONFIG_MK8
+#ifdef CONFIG_CPU_ONLY_K8
 #define ASM_NOP1 K8_NOP1
 #define ASM_NOP2 K8_NOP2
 #define ASM_NOP3 K8_NOP3
@@ -553,7 +553,7 @@
 #define ASM_NOP6 K8_NOP6
 #define ASM_NOP7 K8_NOP7
 #define ASM_NOP8 K8_NOP8
-#elif defined(CONFIG_MK7)
+#elif defined(CONFIG_CPU_ONLY_K7)
 #define ASM_NOP1 K7_NOP1
 #define ASM_NOP2 K7_NOP2
 #define ASM_NOP3 K7_NOP3
--- linux-2.6.0-test4-mm5/drivers/serial/8250.h.old	2003-09-05 10:21:47.000000000 +0200
+++ linux-2.6.0-test4-mm5/drivers/serial/8250.h	2003-09-05 10:22:03.000000000 +0200
@@ -44,7 +44,7 @@
 
 #undef SERIAL_DEBUG_PCI
 
-#if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
+#if defined(__i386__) && (defined(CONFIG_CPU_386) || defined(CONFIG_CPU_486))
 #define SERIAL_INLINE
 #endif
   
--- linux-2.6.0-test4-mm5/arch/i386/boot/setup.S.old	2003-09-05 12:35:25.000000000 +0200
+++ linux-2.6.0-test4-mm5/arch/i386/boot/setup.S	2003-09-05 12:35:38.000000000 +0200
@@ -744,7 +744,7 @@
 # AMD Elan bug fix by Robert Schwebel.
 #
 
-#if defined(CONFIG_MELAN)
+#if defined(CONFIG_X86_ELAN)
 	movb $0x02, %al			# alternate A20 gate
 	outb %al, $0x92			# this works on SC410/SC520
 a20_elan_wait:
--- linux-2.6.0-test4-mm5/include/asm-i386/timex.h.old	2003-09-05 12:36:47.000000000 +0200
+++ linux-2.6.0-test4-mm5/include/asm-i386/timex.h	2003-09-05 12:36:59.000000000 +0200
@@ -12,7 +12,7 @@
 #ifdef CONFIG_X86_PC9800
    extern int CLOCK_TICK_RATE;
 #else
-#ifdef CONFIG_MELAN
+#ifdef CONFIG_X86_ELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
 #else
 #  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
