Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVJYWLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVJYWLq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVJYWLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:11:25 -0400
Received: from [151.97.230.9] ([151.97.230.9]:43192 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932436AbVJYWLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:11:18 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/6] Uml - reuse i386 cpu-specific tuning
Date: Wed, 26 Oct 2005 00:11:07 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051025221105.21106.95194.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Make UML share the underlying cpu-specific tuning done on i386.

Actually, for now many config options aren't used a lot - but that can be done
later. Also, UML relies on GCC optimization for things like memcpy and such more
than i386, so specifying the correct -march and -mtune should be enough.
Later, we may want to correct some other stuff.

For instance, since FPU context switching, for us, is done (at least partially,
i.e. between our kernelspace and userspace) by the host, we may allow usage of
FPU operations by GCC. This doesn't hold for kernelspace vs. kernelspace, but
we don't support preemption.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/i386/Kconfig      |  304 ------------------------------------------------
 arch/i386/Kconfig.cpu  |  305 ++++++++++++++++++++++++++++++++++++++++++++++++
 arch/i386/Makefile     |   31 -----
 arch/i386/Makefile.cpu |   33 +++++
 arch/um/Kconfig        |    6 +
 arch/um/Makefile-i386  |   10 ++
 include/asm-um/cache.h |   19 ++-
 7 files changed, 372 insertions(+), 336 deletions(-)

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -151,304 +151,7 @@ config ES7000_CLUSTERED_APIC
 	default y
 	depends on SMP && X86_ES7000 && MPENTIUMIII
 
-if !X86_ELAN
-
-choice
-	prompt "Processor family"
-	default M686
-
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
-	  - "Efficeon" for the Transmeta Efficeon series.
-	  - "Winchip-C6" for original IDT Winchip.
-	  - "Winchip-2" for IDT Winchip 2.
-	  - "Winchip-2A" for IDT Winchips with 3dNow! capabilities.
-	  - "GeodeGX1" for Geode GX1 (Cyrix MediaGX).
-	  - "CyrixIII/VIA C3" for VIA Cyrix III or VIA C3.
-	  - "VIA C3-2 for VIA C3-2 "Nehemiah" (model 9 and above).
-
-	  If you don't know what to do, choose "386".
-
-config M486
-	bool "486"
-	help
-	  Select this for a 486 series processor, either Intel or one of the
-	  compatible processors from AMD, Cyrix, IBM, or Intel.  Includes DX,
-	  DX2, and DX4 variants; also SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or
-	  U5S.
-
-config M586
-	bool "586/K5/5x86/6x86/6x86MX"
-	help
-	  Select this for an 586 or 686 series processor such as the AMD K5,
-	  the Cyrix 5x86, 6x86 and 6x86MX.  This choice does not
-	  assume the RDTSC (Read Time Stamp Counter) instruction.
-
-config M586TSC
-	bool "Pentium-Classic"
-	help
-	  Select this for a Pentium Classic processor with the RDTSC (Read
-	  Time Stamp Counter) instruction for benchmarking.
-
-config M586MMX
-	bool "Pentium-MMX"
-	help
-	  Select this for a Pentium with the MMX graphics/multimedia
-	  extended instructions.
-
-config M686
-	bool "Pentium-Pro"
-	help
-	  Select this for Intel Pentium Pro chips.  This enables the use of
-	  Pentium Pro extended instructions, and disables the init-time guard
-	  against the f00f bug found in earlier Pentiums.
-
-config MPENTIUMII
-	bool "Pentium-II/Celeron(pre-Coppermine)"
-	help
-	  Select this for Intel chips based on the Pentium-II and
-	  pre-Coppermine Celeron core.  This option enables an unaligned
-	  copy optimization, compiles the kernel with optimization flags
-	  tailored for the chip, and applies any applicable Pentium Pro
-	  optimizations.
-
-config MPENTIUMIII
-	bool "Pentium-III/Celeron(Coppermine)/Pentium-III Xeon"
-	help
-	  Select this for Intel chips based on the Pentium-III and
-	  Celeron-Coppermine core.  This option enables use of some
-	  extended prefetch instructions in addition to the Pentium II
-	  extensions.
-
-config MPENTIUMM
-	bool "Pentium M"
-	help
-	  Select this for Intel Pentium M (not Pentium-4 M)
-	  notebook chips.
-
-config MPENTIUM4
-	bool "Pentium-4/Celeron(P4-based)/Pentium-4 M/Xeon"
-	help
-	  Select this for Intel Pentium 4 chips.  This includes the
-	  Pentium 4, P4-based Celeron and Xeon, and Pentium-4 M
-	  (not Pentium M) chips.  This option enables compile flags
-	  optimized for the chip, uses the correct cache shift, and
-	  applies any applicable Pentium III optimizations.
-
-config MK6
-	bool "K6/K6-II/K6-III"
-	help
-	  Select this for an AMD K6-family processor.  Enables use of
-	  some extended instructions, and passes appropriate optimization
-	  flags to GCC.
-
-config MK7
-	bool "Athlon/Duron/K7"
-	help
-	  Select this for an AMD Athlon K7-family processor.  Enables use of
-	  some extended instructions, and passes appropriate optimization
-	  flags to GCC.
-
-config MK8
-	bool "Opteron/Athlon64/Hammer/K8"
-	help
-	  Select this for an AMD Opteron or Athlon64 Hammer-family processor.  Enables
-	  use of some extended instructions, and passes appropriate optimization
-	  flags to GCC.
-
-config MCRUSOE
-	bool "Crusoe"
-	help
-	  Select this for a Transmeta Crusoe processor.  Treats the processor
-	  like a 586 with TSC, and sets some GCC optimization flags (like a
-	  Pentium Pro with no alignment requirements).
-
-config MEFFICEON
-	bool "Efficeon"
-	help
-	  Select this for a Transmeta Efficeon processor.
-
-config MWINCHIPC6
-	bool "Winchip-C6"
-	help
-	  Select this for an IDT Winchip C6 chip.  Linux and GCC
-	  treat this chip as a 586TSC with some extended instructions
-	  and alignment requirements.
-
-config MWINCHIP2
-	bool "Winchip-2"
-	help
-	  Select this for an IDT Winchip-2.  Linux and GCC
-	  treat this chip as a 586TSC with some extended instructions
-	  and alignment requirements.
-
-config MWINCHIP3D
-	bool "Winchip-2A/Winchip-3"
-	help
-	  Select this for an IDT Winchip-2A or 3.  Linux and GCC
-	  treat this chip as a 586TSC with some extended instructions
-	  and alignment reqirements.  Also enable out of order memory
-	  stores for this CPU, which can increase performance of some
-	  operations.
-
-config MGEODEGX1
-	bool "GeodeGX1"
-	help
-	  Select this for a Geode GX1 (Cyrix MediaGX) chip.
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
-
-config MVIAC3_2
-	bool "VIA C3-2 (Nehemiah)"
-	help
-	  Select this for a VIA C3 "Nehemiah". Selecting this enables usage
-	  of SSE and tells gcc to treat the CPU as a 686.
-	  Note, this kernel will not boot on older (pre model 9) C3s.
-
-endchoice
-
-config X86_GENERIC
-       bool "Generic x86 support"
-       help
-	  Instead of just including optimizations for the selected
-	  x86 variant (e.g. PII, Crusoe or Athlon), include some more
-	  generic optimizations as well. This will make the kernel
-	  perform better on x86 CPUs other than that selected.
-
-	  This is really intended for distributors who need more
-	  generic optimizations.
-
-endif
-
-#
-# Define implied options from the CPU selection here
-#
-config X86_CMPXCHG
-	bool
-	depends on !M386
-	default y
-
-config X86_XADD
-	bool
-	depends on !M386
-	default y
-
-config X86_L1_CACHE_SHIFT
-	int
-	default "7" if MPENTIUM4 || X86_GENERIC
-	default "4" if X86_ELAN || M486 || M386
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODEGX1
-	default "6" if MK7 || MK8 || MPENTIUMM
-
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	depends on M386
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	depends on !M386
-	default y
-
-config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
-
-config X86_PPRO_FENCE
-	bool
-	depends on M686 || M586MMX || M586TSC || M586 || M486 || M386 || MGEODEGX1
-	default y
-
-config X86_F00F_BUG
-	bool
-	depends on M586MMX || M586TSC || M586 || M486 || M386
-	default y
-
-config X86_WP_WORKS_OK
-	bool
-	depends on !M386
-	default y
-
-config X86_INVLPG
-	bool
-	depends on !M386
-	default y
-
-config X86_BSWAP
-	bool
-	depends on !M386
-	default y
-
-config X86_POPAD_OK
-	bool
-	depends on !M386
-	default y
-
-config X86_ALIGNMENT_16
-	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || X86_ELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2 || MGEODEGX1
-	default y
-
-config X86_GOOD_APIC
-	bool
-	depends on MK7 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8 || MEFFICEON
-	default y
-
-config X86_INTEL_USERCOPY
-	bool
-	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7 || MEFFICEON
-	default y
-
-config X86_USE_PPRO_CHECKSUM
-	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MEFFICEON
-	default y
-
-config X86_USE_3DNOW
-	bool
-	depends on MCYRIXIII || MK7
-	default y
-
-config X86_OOSTORE
-	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MWINCHIPC6) && MTRR
-	default y
+source "arch/i386/Kconfig.cpu"
 
 config HPET_TIMER
 	bool "HPET Timer Support"
@@ -561,11 +264,6 @@ config X86_VISWS_APIC
 	depends on X86_VISWS
 	default y
 
-config X86_TSC
-	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MGEODEGX1) && !X86_NUMAQ
-	default y
-
 config X86_MCE
 	bool "Machine Check Exception"
 	depends on !X86_VOYAGER
diff --git a/arch/i386/Kconfig.cpu b/arch/i386/Kconfig.cpu
new file mode 100644
--- /dev/null
+++ b/arch/i386/Kconfig.cpu
@@ -0,0 +1,305 @@
+# Put here option for CPU selection and depending optimization
+if !X86_ELAN
+
+choice
+	prompt "Processor family"
+	default M686
+
+config M386
+	bool "386"
+	---help---
+	  This is the processor type of your CPU. This information is used for
+	  optimizing purposes. In order to compile a kernel that can run on
+	  all x86 CPU types (albeit not optimally fast), you can specify
+	  "386" here.
+
+	  The kernel will not necessarily run on earlier architectures than
+	  the one you have chosen, e.g. a Pentium optimized kernel will run on
+	  a PPro, but not necessarily on a i486.
+
+	  Here are the settings recommended for greatest speed:
+	  - "386" for the AMD/Cyrix/Intel 386DX/DXL/SL/SLC/SX, Cyrix/TI
+	  486DLC/DLC2, UMC 486SX-S and NexGen Nx586.  Only "386" kernels
+	  will run on a 386 class machine.
+	  - "486" for the AMD/Cyrix/IBM/Intel 486DX/DX2/DX4 or
+	  SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or U5S.
+	  - "586" for generic Pentium CPUs lacking the TSC
+	  (time stamp counter) register.
+	  - "Pentium-Classic" for the Intel Pentium.
+	  - "Pentium-MMX" for the Intel Pentium MMX.
+	  - "Pentium-Pro" for the Intel Pentium Pro.
+	  - "Pentium-II" for the Intel Pentium II or pre-Coppermine Celeron.
+	  - "Pentium-III" for the Intel Pentium III or Coppermine Celeron.
+	  - "Pentium-4" for the Intel Pentium 4 or P4-based Celeron.
+	  - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
+	  - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
+	  - "Crusoe" for the Transmeta Crusoe series.
+	  - "Efficeon" for the Transmeta Efficeon series.
+	  - "Winchip-C6" for original IDT Winchip.
+	  - "Winchip-2" for IDT Winchip 2.
+	  - "Winchip-2A" for IDT Winchips with 3dNow! capabilities.
+	  - "GeodeGX1" for Geode GX1 (Cyrix MediaGX).
+	  - "CyrixIII/VIA C3" for VIA Cyrix III or VIA C3.
+	  - "VIA C3-2 for VIA C3-2 "Nehemiah" (model 9 and above).
+
+	  If you don't know what to do, choose "386".
+
+config M486
+	bool "486"
+	help
+	  Select this for a 486 series processor, either Intel or one of the
+	  compatible processors from AMD, Cyrix, IBM, or Intel.  Includes DX,
+	  DX2, and DX4 variants; also SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or
+	  U5S.
+
+config M586
+	bool "586/K5/5x86/6x86/6x86MX"
+	help
+	  Select this for an 586 or 686 series processor such as the AMD K5,
+	  the Cyrix 5x86, 6x86 and 6x86MX.  This choice does not
+	  assume the RDTSC (Read Time Stamp Counter) instruction.
+
+config M586TSC
+	bool "Pentium-Classic"
+	help
+	  Select this for a Pentium Classic processor with the RDTSC (Read
+	  Time Stamp Counter) instruction for benchmarking.
+
+config M586MMX
+	bool "Pentium-MMX"
+	help
+	  Select this for a Pentium with the MMX graphics/multimedia
+	  extended instructions.
+
+config M686
+	bool "Pentium-Pro"
+	help
+	  Select this for Intel Pentium Pro chips.  This enables the use of
+	  Pentium Pro extended instructions, and disables the init-time guard
+	  against the f00f bug found in earlier Pentiums.
+
+config MPENTIUMII
+	bool "Pentium-II/Celeron(pre-Coppermine)"
+	help
+	  Select this for Intel chips based on the Pentium-II and
+	  pre-Coppermine Celeron core.  This option enables an unaligned
+	  copy optimization, compiles the kernel with optimization flags
+	  tailored for the chip, and applies any applicable Pentium Pro
+	  optimizations.
+
+config MPENTIUMIII
+	bool "Pentium-III/Celeron(Coppermine)/Pentium-III Xeon"
+	help
+	  Select this for Intel chips based on the Pentium-III and
+	  Celeron-Coppermine core.  This option enables use of some
+	  extended prefetch instructions in addition to the Pentium II
+	  extensions.
+
+config MPENTIUMM
+	bool "Pentium M"
+	help
+	  Select this for Intel Pentium M (not Pentium-4 M)
+	  notebook chips.
+
+config MPENTIUM4
+	bool "Pentium-4/Celeron(P4-based)/Pentium-4 M/Xeon"
+	help
+	  Select this for Intel Pentium 4 chips.  This includes the
+	  Pentium 4, P4-based Celeron and Xeon, and Pentium-4 M
+	  (not Pentium M) chips.  This option enables compile flags
+	  optimized for the chip, uses the correct cache shift, and
+	  applies any applicable Pentium III optimizations.
+
+config MK6
+	bool "K6/K6-II/K6-III"
+	help
+	  Select this for an AMD K6-family processor.  Enables use of
+	  some extended instructions, and passes appropriate optimization
+	  flags to GCC.
+
+config MK7
+	bool "Athlon/Duron/K7"
+	help
+	  Select this for an AMD Athlon K7-family processor.  Enables use of
+	  some extended instructions, and passes appropriate optimization
+	  flags to GCC.
+
+config MK8
+	bool "Opteron/Athlon64/Hammer/K8"
+	help
+	  Select this for an AMD Opteron or Athlon64 Hammer-family processor.  Enables
+	  use of some extended instructions, and passes appropriate optimization
+	  flags to GCC.
+
+config MCRUSOE
+	bool "Crusoe"
+	help
+	  Select this for a Transmeta Crusoe processor.  Treats the processor
+	  like a 586 with TSC, and sets some GCC optimization flags (like a
+	  Pentium Pro with no alignment requirements).
+
+config MEFFICEON
+	bool "Efficeon"
+	help
+	  Select this for a Transmeta Efficeon processor.
+
+config MWINCHIPC6
+	bool "Winchip-C6"
+	help
+	  Select this for an IDT Winchip C6 chip.  Linux and GCC
+	  treat this chip as a 586TSC with some extended instructions
+	  and alignment requirements.
+
+config MWINCHIP2
+	bool "Winchip-2"
+	help
+	  Select this for an IDT Winchip-2.  Linux and GCC
+	  treat this chip as a 586TSC with some extended instructions
+	  and alignment requirements.
+
+config MWINCHIP3D
+	bool "Winchip-2A/Winchip-3"
+	help
+	  Select this for an IDT Winchip-2A or 3.  Linux and GCC
+	  treat this chip as a 586TSC with some extended instructions
+	  and alignment reqirements.  Also enable out of order memory
+	  stores for this CPU, which can increase performance of some
+	  operations.
+
+config MGEODEGX1
+	bool "GeodeGX1"
+	help
+	  Select this for a Geode GX1 (Cyrix MediaGX) chip.
+
+config MCYRIXIII
+	bool "CyrixIII/VIA-C3"
+	help
+	  Select this for a Cyrix III or C3 chip.  Presently Linux and GCC
+	  treat this chip as a generic 586. Whilst the CPU is 686 class,
+	  it lacks the cmov extension which gcc assumes is present when
+	  generating 686 code.
+	  Note that Nehemiah (Model 9) and above will not boot with this
+	  kernel due to them lacking the 3DNow! instructions used in earlier
+	  incarnations of the CPU.
+
+config MVIAC3_2
+	bool "VIA C3-2 (Nehemiah)"
+	help
+	  Select this for a VIA C3 "Nehemiah". Selecting this enables usage
+	  of SSE and tells gcc to treat the CPU as a 686.
+	  Note, this kernel will not boot on older (pre model 9) C3s.
+
+endchoice
+
+config X86_GENERIC
+       bool "Generic x86 support"
+       help
+	  Instead of just including optimizations for the selected
+	  x86 variant (e.g. PII, Crusoe or Athlon), include some more
+	  generic optimizations as well. This will make the kernel
+	  perform better on x86 CPUs other than that selected.
+
+	  This is really intended for distributors who need more
+	  generic optimizations.
+
+#!X86_ELAN
+endif
+
+#
+# Define implied options from the CPU selection here
+#
+config X86_CMPXCHG
+	bool
+	depends on !M386
+	default y
+
+config X86_XADD
+	bool
+	depends on !M386
+	default y
+
+config X86_L1_CACHE_SHIFT
+	int
+	default "7" if MPENTIUM4 || X86_GENERIC
+	default "4" if X86_ELAN || M486 || M386
+	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODEGX1
+	default "6" if MK7 || MK8 || MPENTIUMM
+
+config RWSEM_GENERIC_SPINLOCK
+	bool
+	depends on M386
+	default y
+
+config RWSEM_XCHGADD_ALGORITHM
+	bool
+	depends on !M386
+	default y
+
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+config X86_PPRO_FENCE
+	bool
+	depends on M686 || M586MMX || M586TSC || M586 || M486 || M386 || MGEODEGX1
+	default y
+
+config X86_F00F_BUG
+	bool
+	depends on M586MMX || M586TSC || M586 || M486 || M386
+	default y
+
+config X86_WP_WORKS_OK
+	bool
+	depends on !M386
+	default y
+
+config X86_INVLPG
+	bool
+	depends on !M386
+	default y
+
+config X86_BSWAP
+	bool
+	depends on !M386
+	default y
+
+config X86_POPAD_OK
+	bool
+	depends on !M386
+	default y
+
+config X86_ALIGNMENT_16
+	bool
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || X86_ELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2 || MGEODEGX1
+	default y
+
+config X86_GOOD_APIC
+	bool
+	depends on MK7 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8 || MEFFICEON
+	default y
+
+config X86_INTEL_USERCOPY
+	bool
+	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7 || MEFFICEON
+	default y
+
+config X86_USE_PPRO_CHECKSUM
+	bool
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MEFFICEON
+	default y
+
+config X86_USE_3DNOW
+	bool
+	depends on MCYRIXIII || MK7
+	default y
+
+config X86_OOSTORE
+	bool
+	depends on (MWINCHIP3D || MWINCHIP2 || MWINCHIPC6) && MTRR
+	default y
+
+config X86_TSC
+	bool
+	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MGEODEGX1) && !X86_NUMAQ
+	default y
diff --git a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -34,35 +34,8 @@ CFLAGS += -pipe -msoft-float
 # prevent gcc from keeping the stack 16 byte aligned
 CFLAGS += $(call cc-option,-mpreferred-stack-boundary=2)
 
-align := $(cc-option-align)
-cflags-$(CONFIG_M386)		+= -march=i386
-cflags-$(CONFIG_M486)		+= -march=i486
-cflags-$(CONFIG_M586)		+= -march=i586
-cflags-$(CONFIG_M586TSC)	+= -march=i586
-cflags-$(CONFIG_M586MMX)	+= $(call cc-option,-march=pentium-mmx,-march=i586)
-cflags-$(CONFIG_M686)		+= -march=i686
-cflags-$(CONFIG_MPENTIUMII)	+= -march=i686 $(call cc-option,-mtune=pentium2)
-cflags-$(CONFIG_MPENTIUMIII)	+= -march=i686 $(call cc-option,-mtune=pentium3)
-cflags-$(CONFIG_MPENTIUMM)	+= -march=i686 $(call cc-option,-mtune=pentium3)
-cflags-$(CONFIG_MPENTIUM4)	+= -march=i686 $(call cc-option,-mtune=pentium4)
-cflags-$(CONFIG_MK6)		+= -march=k6
-# Please note, that patches that add -march=athlon-xp and friends are pointless.
-# They make zero difference whatsosever to performance at this time.
-cflags-$(CONFIG_MK7)		+= $(call cc-option,-march=athlon,-march=i686 $(align)-functions=4)
-cflags-$(CONFIG_MK8)		+= $(call cc-option,-march=k8,$(call cc-option,-march=athlon,-march=i686 $(align)-functions=4))
-cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
-cflags-$(CONFIG_MEFFICEON)	+= -march=i686 $(call cc-option,-mtune=pentium3) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
-cflags-$(CONFIG_MWINCHIPC6)	+= $(call cc-option,-march=winchip-c6,-march=i586)
-cflags-$(CONFIG_MWINCHIP2)	+= $(call cc-option,-march=winchip2,-march=i586)
-cflags-$(CONFIG_MWINCHIP3D)	+= $(call cc-option,-march=winchip2,-march=i586)
-cflags-$(CONFIG_MCYRIXIII)	+= $(call cc-option,-march=c3,-march=i486) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
-cflags-$(CONFIG_MVIAC3_2)	+= $(call cc-option,-march=c3-2,-march=i686)
-
-# AMD Elan support
-cflags-$(CONFIG_X86_ELAN)	+= -march=i486
-
-# Geode GX1 support
-cflags-$(CONFIG_MGEODEGX1)		+= $(call cc-option,-march=pentium-mmx,-march=i486)
+# CPU-specific tuning. Anything which can be shared with UML should go here.
+include $(srctree)/arch/i386/Makefile.cpu
 
 # -mregparm=3 works ok on gcc-3.0 and later
 #
diff --git a/arch/i386/Makefile.cpu b/arch/i386/Makefile.cpu
new file mode 100644
--- /dev/null
+++ b/arch/i386/Makefile.cpu
@@ -0,0 +1,33 @@
+# CPU tuning section - shared with UML.
+# Must change only cflags-y (or [yn]), not CFLAGS! That makes a difference for UML.
+
+align := $(cc-option-align)
+cflags-$(CONFIG_M386)		+= -march=i386
+cflags-$(CONFIG_M486)		+= -march=i486
+cflags-$(CONFIG_M586)		+= -march=i586
+cflags-$(CONFIG_M586TSC)	+= -march=i586
+cflags-$(CONFIG_M586MMX)	+= $(call cc-option,-march=pentium-mmx,-march=i586)
+cflags-$(CONFIG_M686)		+= -march=i686
+cflags-$(CONFIG_MPENTIUMII)	+= -march=i686 $(call cc-option,-mtune=pentium2)
+cflags-$(CONFIG_MPENTIUMIII)	+= -march=i686 $(call cc-option,-mtune=pentium3)
+cflags-$(CONFIG_MPENTIUMM)	+= -march=i686 $(call cc-option,-mtune=pentium3)
+cflags-$(CONFIG_MPENTIUM4)	+= -march=i686 $(call cc-option,-mtune=pentium4)
+cflags-$(CONFIG_MK6)		+= -march=k6
+# Please note, that patches that add -march=athlon-xp and friends are pointless.
+# They make zero difference whatsosever to performance at this time.
+cflags-$(CONFIG_MK7)		+= $(call cc-option,-march=athlon,-march=i686 $(align)-functions=4)
+cflags-$(CONFIG_MK8)		+= $(call cc-option,-march=k8,$(call cc-option,-march=athlon,-march=i686 $(align)-functions=4))
+cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
+cflags-$(CONFIG_MEFFICEON)	+= -march=i686 $(call cc-option,-mtune=pentium3) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
+cflags-$(CONFIG_MWINCHIPC6)	+= $(call cc-option,-march=winchip-c6,-march=i586)
+cflags-$(CONFIG_MWINCHIP2)	+= $(call cc-option,-march=winchip2,-march=i586)
+cflags-$(CONFIG_MWINCHIP3D)	+= $(call cc-option,-march=winchip2,-march=i586)
+cflags-$(CONFIG_MCYRIXIII)	+= $(call cc-option,-march=c3,-march=i486) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
+cflags-$(CONFIG_MVIAC3_2)	+= $(call cc-option,-march=c3-2,-march=i686)
+
+# AMD Elan support
+cflags-$(CONFIG_X86_ELAN)	+= -march=i486
+
+# Geode GX1 support
+cflags-$(CONFIG_MGEODEGX1)		+= $(call cc-option,-march=pentium-mmx,-march=i486)
+
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -39,6 +39,12 @@ config IRQ_RELEASE_METHOD
 	bool
 	default y
 
+menu "Host processor type and features"
+
+source "arch/i386/Kconfig.cpu"
+
+endmenu
+
 menu "UML-specific options"
 
 config MODE_TT
diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -32,3 +32,13 @@ CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH)
 ifneq ($(CONFIG_GPROF),y)
 ARCH_CFLAGS += -DUM_FASTCALL
 endif
+
+# First of all, tune CFLAGS for the specific CPU. This actually sets cflags-y.
+include $(srctree)/arch/i386/Makefile.cpu
+
+# prevent gcc from keeping the stack 16 byte aligned. Taken from i386.
+cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
+
+CFLAGS += $(cflags-y)
+USER_CFLAGS += $(cflags-y)
+
diff --git a/include/asm-um/cache.h b/include/asm-um/cache.h
--- a/include/asm-um/cache.h
+++ b/include/asm-um/cache.h
@@ -1,10 +1,21 @@
 #ifndef __UM_CACHE_H
 #define __UM_CACHE_H
 
-/* These are x86 numbers */
-#define L1_CACHE_SHIFT 5
-#define L1_CACHE_BYTES (1 << L1_CACHE_SHIFT)
+#include <linux/config.h>
 
-#define L1_CACHE_SHIFT_MAX 7	/* largest L1 which this arch supports */
+#if defined(CONFIG_UML_X86) && !defined(CONFIG_64BIT)
+# define L1_CACHE_SHIFT		(CONFIG_X86_L1_CACHE_SHIFT)
+#elif defined(CONFIG_UML_X86) /* 64-bit */
+# define L1_CACHE_SHIFT		6 /* Should be 7 on Intel */
+#else
+/* XXX: this was taken from x86, now it's completely random. Luckily only
+ * affects SMP padding. */
+# define L1_CACHE_SHIFT		5
+#endif
+
+/* XXX: this is valid for x86 and x86_64. */
+#define L1_CACHE_SHIFT_MAX	7	/* largest L1 which this arch supports */
+
+#define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
 #endif

