Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319110AbSH2EJO>; Thu, 29 Aug 2002 00:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319111AbSH2EJN>; Thu, 29 Aug 2002 00:09:13 -0400
Received: from ppp-217-133-223-7.dialup.tiscali.it ([217.133.223.7]:30096 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S319110AbSH2EI6>;
	Thu, 29 Aug 2002 00:08:58 -0400
Subject: [PATCH 3 / 4] i386 individual CPU selection
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-EmtKZMGV+fE/oAaBqlJC"
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Aug 2002 06:13:11 +0200
Message-Id: <1030594391.1491.30.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EmtKZMGV+fE/oAaBqlJC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

User interface:

This patch changes the CPU selection mechanism so that each CPU is an
independent y/n choice.
The advantage of this is that the user knows exactly and has full
control over the range of CPUs supported by the kernel.
Without this patch it's not clear, for example, how to build a kernel
that will work on both K6s and WinChips.
In addition to the processor selection, a choice is added for the CPU
that the kernel should be optimized, which is used for the -mcpu switch.


CPU description language and capabilities:

CPU capabilities are described in a simple description language in
arch/i386/kernel/cpu/Config.in.in which is converted by
scripts/gencpucfg to config language and a generated header.
Example:
cpu	PENTIUMIII
name	"Intel Pentium III"
arch	686
align	4
has	fpu good_apic mmx mmxext pae xmm tsc
mayhave	smp
wants	686_checksum prefetch
end

For each of the capabilities listed in has/mayhave/wants/maywant two
macros may be defined: CONFIG_X86_MAY_HAVE|WANT_feature and
CONFIG_X86_MAY_NOT_HAVE|WANT_feature.
These flags are defined in arch/i386/kernel/cpu/Config.in: the
definitions are done per-flag rather than per-cpu to avoid config
options showing multiple times in .config.
The cpufeature_config.h header is generated and defines
cpu_has|wants_feature either as 0, to 1 or __cpu_has|wants_feature
depending on the flags.

Example:
#if defined(CONFIG_X86_MAY_HAVE_TSC) && defined(CONFIG_X86_MAY_NOT_HAVE_TSC)
#define cpu_has_tsc	__cpu_has_tsc
#elif defined(CONFIG_X86_MAY_HAVE_TSC)
#define cpu_has_tsc	1
#else
#define cpu_has_tsc	0
#endif

The code alignment and L1 cache size are instead automatically set to
the largest value among the selected processors.

This system, while a bit complex, allows to generate optimal code for a
given set of processors.

Now the only missing feature is the actual use of these macros and the
dynamic fixup code in the whole i386 kernel tree, which is a 57KB patch,
coming soon if no one objects.


diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_fixup_smp/arch/i386/Config.help linux-2.5.32_fixup_smp_cpu/arch/i386/Config.help
--- linux-2.5.32_fixup_smp/arch/i386/Config.help	2002-08-27 21:26:34.000000000 +0200
+++ linux-2.5.32_fixup_smp_cpu/arch/i386/Config.help	2002-08-29 02:31:24.000000000 +0200
@@ -387,110 +387,137 @@ CONFIG_BINFMT_MISC
   don't know what to answer at this point, say Y.
 
 CONFIG_M386
-  This is the processor type of your CPU. This information is used for
-  optimizing purposes. In order to compile a kernel that can run on
-  all x86 CPU types (albeit not optimally fast), you can specify
-  "386" here.
-
-  The kernel will not necessarily run on earlier architectures than
-  the one you have chosen, e.g. a Pentium optimized kernel will run on
-  a PPro, but not necessarily on a i486.
-
-  Here are the settings recommended for greatest speed:
-   - "386" for the AMD/Cyrix/Intel 386DX/DXL/SL/SLC/SX, Cyrix/TI
-     486DLC/DLC2, UMC 486SX-S and NexGen Nx586.  Only "386" kernels
-     will run on a 386 class machine.
-   - "486" for the AMD/Cyrix/IBM/Intel 486DX/DX2/DX4 or
-     SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or U5S.
-   - "586" for generic Pentium CPUs lacking the TSC
-     (time stamp counter) register.
-   - "Pentium-Classic" for the Intel Pentium.
-   - "Pentium-MMX" for the Intel Pentium MMX.
-   - "Pentium-Pro" for the Intel Pentium Pro/Celeron/Pentium II.
-   - "Pentium-III" for the Intel Pentium III
-     and Celerons based on the Coppermine core.
-   - "Pentium-4" for the Intel Pentium 4.
-   - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
-   - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
-   - "Crusoe" for the Transmeta Crusoe series.
-   - "Winchip-C6" for original IDT Winchip.
-   - "Winchip-2" for IDT Winchip 2.
-   - "Winchip-2A" for IDT Winchips with 3dNow! capabilities.
-   - "CyrixIII" for VIA Cyrix III or VIA C3.
-
-  If you don't know what to do, choose "386".
+  Say Y here for a x386 processor, ether Intel or one of the
+  compatible processors from AMD, Cyrix, IBM.
+  Only say Y if necessary, since the 386 lack of several cool features
+  will cause the kernel to emulate them with slower code.
 
 CONFIG_M486
-  Select this for a x486 processor, ether Intel or one of the
-  compatible processors from AMD, Cyrix, IBM, or Intel.  Includes DX,
+  Say Y here for a x486 processor, ether Intel or one of the
+  compatible processors from AMD, Cyrix, IBM.  Includes DX,
   DX2, and DX4 variants; also SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or
   U5S.
 
+CONFIG_MELAN
+  Say Y here for an AMD Elan processor. Unfortunately this processor
+  is supported in such a way that the resulting kernel won't run on
+  any other processor.
+
 CONFIG_M586
-  Select this for an x586 or x686 processor such as the AMD K5, the
+  Say Y here for an x586 or x686 processor such as the AMD K5, the
   Intel 5x86 or 6x86, or the Intel 6x86MX.  This choice does not
   assume the RDTSC (Read Time Stamp Counter) instruction.
 
+CONFIG_M586MX
+  Say Y here for the NexGen 6x86MX and other Pentium-class processors
+  with the MMX graphics/multimedia extended instructions but without
+  the RDTSC (Read Time Stamp Counter) instruction.
+
 CONFIG_M586TSC
-  Select this for a Pentium Classic processor with the RDTSC (Read
+  Say Y here for a Pentium Classic processor with the RDTSC (Read
   Time Stamp Counter) instruction for benchmarking.
 
 CONFIG_M586MMX
-  Select this for a Pentium with the MMX graphics/multimedia
-  extended instructions.
+  Say Y here for a Pentium with the MMX graphics/multimedia
+  extended instructions and with the RDTSC (Read Time Stamp Counter)
+  instruction for benchmarking.
 
 CONFIG_M686
-  Select this for a Pro/Celeron/Pentium II.  This enables the use of
-  Pentium Pro extended instructions, and disables the init-time guard
-  against the f00f bug found in earlier Pentiums.
+  Say Y here for a non-Intel/AMD 686 processor without MMX support
+  support. This enables the use of Pentium Pro extended instructions
+  and disables the init-time guard against the f00f bug found in
+  earlier Pentiums.
+
+CONFIG_MPENTIUMPRO
+  Say Y here for a Pentium Pro or Celeron. This enables the use of
+  Pentium Pro extended instructions, disables  the init-time guard
+  against the f00f bug found in earlier Pentiums and enables the
+  workaround for the Pentium Pro store ordering bug.
+
+CONFIG_MPENTIUMII
+  Say Y here for a Pentium II or another 686 processor with MMX
+  support. This enables the use of Pentium Pro extended instructions,
+  disables  the init-time guard against the f00f bug found in earlier
+  Pentiums and disables the workaround for the Pentium Pro store
+  ordering bug.
 
 CONFIG_MPENTIUMIII
-  Select this for Intel chips based on the Pentium-III and
+  Say Y here for Intel chips based on the Pentium-III and
   Celeron-Coppermine core.  Enables use of some extended prefetch
   instructions, in addition to the Pentium II extensions.
 
 CONFIG_MPENTIUM4
-  Select this for Intel Pentium 4 chips.  Presently these are
-  treated almost like Pentium IIIs, but with a different cache
-  shift.
+  Say Y here for Intel Pentium 4 chips.  They have a different cache
+  shift and if you are compiling with GCC 3.1 or later instructions
+  will be selected and ordered specifically for maximum performance on
+  the Intel Pentium 4.
 
 CONFIG_MCRUSOE
-  Select this for Transmeta Crusoe processor.  Treats the processor
+  Say Y here for Transmeta Crusoe processor.  Treats the processor
   like a 586 with TSC, and sets some GCC optimization flags (like a
   Pentium Pro with no alignment requirements).
 
 CONFIG_MK6
-  Select this for an AMD K6-family processor.  Enables use of
-  some extended instructions, and passes appropriate optimization
-  flags to GCC.
+  Say Y here for an AMD K6 processor.  Enables use of some extended
+  instructions, and passes appropriate optimization flags to GCC.
+
+CONFIG_MK6II
+  Say Y here for an AMD K6-2/K6-3D or K6-3.  Enables use of some
+  extended instructions, passes appropriate optimization flags to GCC
+  and enables 3DNow!
 
 CONFIG_MK7
-  Select this for an AMD Athlon K7-family processor.  Enables use of
-  some extended instructions, and passes appropriate optimization
-  flags to GCC.
+  Say Y here for an AMD Athlon K7-family processor.  Enables use of
+  some extended instructions, passes appropriate optimization flags to
+  GCC and enables 3DNow!
+
+CONFIG_MK7SSE
+  Say Y here for an AMD Athlon K7-family processor with SSE support
+  such as the Athlon XP/MP.  Enables use of some extended
+  instructions, passes appropriate optimization flags to GCC and
+  enables 3DNow! and SSE
 
 CONFIG_MCYRIXIII
-  Select this for a Cyrix III or C3 chip.  Presently Linux and GCC
+  Say Y here for a Cyrix III or C3 chip.  Presently Linux and GCC
   treat this chip as a generic 586. Whilst the CPU is 686 class,
   it lacks the cmov extension which gcc assumes is present when
   generating 686 code.
 
 CONFIG_MWINCHIPC6
-  Select this for a IDT Winchip C6 chip.  Linux and GCC
-  treat this chip as a 586TSC with some extended instructions
-  and alignment requirements.
+  Say Y here for a IDT Winchip C6 chip.  Linux and GCC
+  treat this chip as a 586 with some extended instructions
+  and alignment requirements.  Development kernels also enable
+  out of order memory stores for this CPU, which can increase
+  performance of some operations.
 
 CONFIG_MWINCHIP2
-  Select this for a IDT Winchip-2.  Linux and GCC
+  Say Y here for a IDT Winchip-2.  Linux and GCC
   treat this chip as a 586TSC with some extended instructions
-  and alignment requirements.
+  and alignment requirements.  Development kernels also enable
+  out of order memory stores for this CPU, which can increase
+  performance of some operations.
 
 CONFIG_MWINCHIP3D
-  Select this for a IDT Winchip-2A or 3.  Linux and GCC
+  Say Y here for a IDT Winchip-2A or 3.  Linux and GCC
   treat this chip as a 586TSC with some extended instructions
-  and alignment reqirements.  Development kernels also enable
-  out of order memory stores for this CPU, which can increase
-  performance of some operations.
+  and alignment reqirements and with 3DNow! support.  Development
+  kernels also enable out of order memory stores for this CPU, which
+  can increase performance of some operations.
+
+CONFIG_X86_MCPU_386
+  This is the processor type the kernel will be optimized for. The
+  kernel will run on any processor you selected in the previous
+  questions, but it will run faster on the CPUs selected here and
+  slower on others.
+
+  Currently this only affects instruction scheduling. Alignment and L1
+  cacheline size are automatically set to the largest one from the
+  processors you select.
+
+  If you don't know what to do, choose the processor where you want to
+  obtain the maximum performance. If you still don't know what to do,
+  choose the first element in the list that matches a processors that
+  you selected in the previous questions.
 
 CONFIG_VGA_CONSOLE
   Saying Y here will allow you to use Linux in text mode through a
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_fixup_smp/arch/i386/config.in linux-2.5.32_fixup_smp_cpu/arch/i386/config.in
--- linux-2.5.32_fixup_smp/arch/i386/config.in	2002-08-27 21:26:39.000000000 +0200
+++ linux-2.5.32_fixup_smp_cpu/arch/i386/config.in	2002-08-29 02:35:05.000000000 +0200
@@ -14,36 +14,50 @@ define_bool CONFIG_GENERIC_ISA_DMA y
 source init/Config.in
 
 mainmenu_option next_comment
-comment 'Processor type and features'
-choice 'Processor family' \
-	"386					CONFIG_M386 \
-	 486					CONFIG_M486 \
-	 586/K5/5x86/6x86/6x86MX		CONFIG_M586 \
-	 Pentium-Classic			CONFIG_M586TSC \
-	 Pentium-MMX				CONFIG_M586MMX \
-	 Pentium-Pro/Celeron/Pentium-II		CONFIG_M686 \
-	 Pentium-III/Celeron(Coppermine)	CONFIG_MPENTIUMIII \
-	 Pentium-4				CONFIG_MPENTIUM4 \
-	 K6/K6-II/K6-III			CONFIG_MK6 \
-	 Athlon/Duron/K7			CONFIG_MK7 \
-	 Elan					CONFIG_MELAN \
-	 Crusoe					CONFIG_MCRUSOE \
-	 Winchip-C6				CONFIG_MWINCHIPC6 \
-	 Winchip-2				CONFIG_MWINCHIP2 \
-	 Winchip-2A/Winchip-3			CONFIG_MWINCHIP3D \
-	 CyrixIII/C3				CONFIG_MCYRIXIII" Pentium-Pro
-#
-# Define implied options from the CPU selection here
-#
+comment 'Processor selection'
+
+bool 'Support AMD Elan processor and nothing else' CONFIG_MELAN
+if [ "$CONFIG_MELAN" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
+   define_bool CONFIG_X86_MAY_WANT_STRING_486 y
+   define_bool CONFIG_X86_ALIGNMENT_16 y
+   define_bool CONFIG_X86_MARCH_486 y
+   define_bool CONFIG_X86_MCPU_486 y
+else
+   comment "Select all the processors you want the kernel to run on"
+   source arch/i386/kernel/cpu/Config.in
+
+   if [ "$CONFIG_MPENTIUM4" = "y" ]; then
+      define_int  CONFIG_X86_L1_CACHE_SHIFT 7
+   else
+   if [ "$CONFIG_MK7" = "y" -o "$CONFIG_MK7SSE" = "y"  -o "$CONFIG_MK8" = "y" ]; then
+      define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   else
+   if [ "$CONFIG_M586" = "y" -o "$CONFIG_M586MX" = "y" -o "$CONFIG_M586TSC" = "y" -o "$CONFIG_M586MMX" = "y" -o "$CONFIG_MK6" = "y" -o "$CONFIG_MK6II" = "y" -o "$CONFIG_MCYRIXII" = "y" -o "$CONFIG_MK6" = "y" -o "$CONFIG_WINCHIPC6" = "y" -o "$CONFIG_WINCHIP2" = "y" -o "$CONFIG_WINCHIP3D" = "y" -o "$CONFIG_M686" = "y" -o "$CONFIG_MPENTIUMII" = "y" -o "$CONFIG_MPENTIUMIII" = "y" ]; then
+      define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   else
+      define_int  CONFIG_X86_L1_CACHE_SHIFT 4
+   fi
+   fi
+   fi
+
+  # This is just for -mcpu
+   choice 'Optimized for processor family' \
+	"386					CONFIG_X86_MCPU_386 \
+	 486...486/Elan				CONFIG_X86_MCPU_486 \
+	 586...Pentium-Classic/MMX/K5/WinChip/Cyrix	CONFIG_X86_MCPU_586 \
+	 686...Pentium-Pro/II/III/Crusoe	CONFIG_X86_MCPU_686 \
+	 Pentium-4				CONFIG_X86_MCPU_PENTIUM4 \
+	 K6					CONFIG_X86_MCPU_K6 \
+	 Athlon					CONFIG_X86_MCPU_ATHLON" 686
+fi
 
 if [ "$CONFIG_M386" = "y" ]; then
    define_bool CONFIG_X86_CMPXCHG n
    define_bool CONFIG_X86_XADD n
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
    define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
-   define_bool CONFIG_X86_PPRO_FENCE y
-   define_bool CONFIG_X86_F00F_BUG y
+   define_bool CONFIG_MARCH_386 y
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
@@ -54,107 +68,18 @@ else
    define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 fi
-if [ "$CONFIG_M486" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
-   define_bool CONFIG_X86_USE_STRING_486 y
-   define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_PPRO_FENCE y
-   define_bool CONFIG_X86_F00F_BUG y
-fi
-if [ "$CONFIG_M586" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_USE_STRING_486 y
-   define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_PPRO_FENCE y
-   define_bool CONFIG_X86_F00F_BUG y
-fi
-if [ "$CONFIG_M586TSC" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_USE_STRING_486 y
-   define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_PPRO_FENCE y
-   define_bool CONFIG_X86_F00F_BUG y
-fi
-if [ "$CONFIG_M586MMX" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_USE_STRING_486 y
-   define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_GOOD_APIC y
-   define_bool CONFIG_X86_PPRO_FENCE y
-   define_bool CONFIG_X86_F00F_BUG y
-fi
-if [ "$CONFIG_M686" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_GOOD_APIC y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-   define_bool CONFIG_X86_PPRO_FENCE y
-fi
-if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_GOOD_APIC y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-fi
-if [ "$CONFIG_MPENTIUM4" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
-   define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_GOOD_APIC y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-fi
-if [ "$CONFIG_MK6" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-fi
-if [ "$CONFIG_MK7" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
-   define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_GOOD_APIC y
-   define_bool CONFIG_X86_USE_3DNOW y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-fi
-if [ "$CONFIG_MELAN" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
-   define_bool CONFIG_X86_USE_STRING_486 y
-   define_bool CONFIG_X86_ALIGNMENT_16 y
-fi
-if [ "$CONFIG_MCYRIXIII" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_USE_3DNOW y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-fi
-if [ "$CONFIG_MCRUSOE" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
-fi
-if [ "$CONFIG_MWINCHIPC6" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-   define_bool CONFIG_X86_OOSTORE y
-fi
-if [ "$CONFIG_MWINCHIP2" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-   define_bool CONFIG_X86_OOSTORE y
-fi
-if [ "$CONFIG_MWINCHIP3D" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-   define_bool CONFIG_X86_OOSTORE y
-fi
 
-bool 'Symmetric multi-processing support' CONFIG_SMP
+# 486 strings are broken
+#if [ "$CONFIG_MCPU_586" = "y" ]; then
+#   define_bool CONFIG_X86_USE_STRING_486 y
+#fi
+
+define_bool CONFIG_X86_TSC y
+endmenu
+
+mainmenu_option next_comment
+comment 'Processor features'
+dep_bool 'Symmetric multi-processing support' CONFIG_SMP $CONFIG_X86_MAY_HAVE_SMP
 bool 'Preemptible Kernel' CONFIG_PREEMPT
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Local APIC support on uniprocessors' CONFIG_X86_UP_APIC
@@ -170,8 +95,10 @@ else
 fi
 
 bool 'Machine Check Exception' CONFIG_X86_MCE
-dep_bool 'Check for non-fatal errors on Athlon/Duron' CONFIG_X86_MCE_NONFATAL $CONFIG_X86_MCE
-dep_bool 'check for P4 thermal throttling interrupt.' CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE $CONFIG_X86_UP_APIC
+if [ "$CONFIG_MK7" = "y" -o "$CONFIG_MK7SSE" = "y" ]; then
+   dep_bool 'Check for non-fatal errors on Athlon/Duron' CONFIG_X86_MCE_NONFATAL $CONFIG_X86_MCE
+fi
+dep_bool 'check for P4 thermal throttling interrupt.' CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE $CONFIG_X86_UP_APIC $CONFIG_MPENTIUM4
 

 tristate 'Toshiba Laptop support' CONFIG_TOSHIBA
@@ -181,10 +108,12 @@ tristate '/dev/cpu/microcode - Intel IA3
 tristate '/dev/cpu/*/msr - Model-specific register support' CONFIG_X86_MSR
 tristate '/dev/cpu/*/cpuid - CPU information support' CONFIG_X86_CPUID
 
-choice 'High Memory Support' \
-	"off           CONFIG_NOHIGHMEM \
-	 4GB           CONFIG_HIGHMEM4G \
-	 64GB          CONFIG_HIGHMEM64G" off
+bool 'High Memory Support (for more than ~900MB of RAM)' CONFIG_HIGHMEM
+
+# Keep our promises of processor compatibility
+if [ "$CONFIG_X86_MAY_HAVE_PAE" = "y" -a "$CONFIG_X86_MAY_NOT_HAVE_PAE" != "y" -a "$CONFIG_HIGHMEM" = "y" ]; then
+   bool '64-bit physical memory addressing (for more than 4GB of RAM)' CONFIG_X86_PAE
+fi
 
 if [ "$CONFIG_HIGHMEM4G" = "y" ]; then
    define_bool CONFIG_HIGHMEM y
@@ -195,7 +124,7 @@ if [ "$CONFIG_HIGHMEM64G" = "y" ]; then
    define_bool CONFIG_X86_PAE y
 fi
 
-bool 'Math emulation' CONFIG_MATH_EMULATION
+dep_bool 'Floating-point math emulation' CONFIG_MATH_EMULATION $CONFIG_X86_MAY_NOT_HAVE_FPU
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
 
 if [ "$CONFIG_SMP" = "y" -o "$CONFIG_PREEMPT" = "y" ]; then
@@ -204,6 +133,9 @@ if [ "$CONFIG_SMP" = "y" -o "$CONFIG_PRE
    fi
 fi
 
+# Debuggers should disable this
+define_bool CONFIG_X86_DYNAMIC_FIXUP_INT3 y
+
 endmenu
 
 mainmenu_option next_comment
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_fixup_smp/arch/i386/defconfig linux-2.5.32_fixup_smp_cpu/arch/i386/defconfig
--- linux-2.5.32_fixup_smp/arch/i386/defconfig	2002-08-27 21:26:34.000000000 +0200
+++ linux-2.5.32_fixup_smp_cpu/arch/i386/defconfig	2002-08-29 02:31:24.000000000 +0200
@@ -36,16 +36,19 @@ CONFIG_KMOD=y
 # CONFIG_M586TSC is not set
 # CONFIG_M586MMX is not set
 # CONFIG_M686 is not set
+CONFIG_MPENTIUMII=y
 CONFIG_MPENTIUMIII=y
-# CONFIG_MPENTIUM4 is not set
+CONFIG_MPENTIUM4=y
 # CONFIG_MK6 is not set
-# CONFIG_MK7 is not set
+CONFIG_MK7=y
+CONFIG_MK7SSE=y
 # CONFIG_MELAN is not set
 # CONFIG_MCRUSOE is not set
 # CONFIG_MWINCHIPC6 is not set
 # CONFIG_MWINCHIP2 is not set
 # CONFIG_MWINCHIP3D is not set
 # CONFIG_MCYRIXIII is not set
+CONFIG_MCPU_686=y
 CONFIG_X86_WP_WORKS_OK=y
 CONFIG_X86_INVLPG=y
 CONFIG_X86_CMPXCHG=y
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_fixup_smp/arch/i386/kernel/cpu/Config.in.in linux-2.5.32_fixup_smp_cpu/arch/i386/kernel/cpu/Config.in.in
--- linux-2.5.32_fixup_smp/arch/i386/kernel/cpu/Config.in.in	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.32_fixup_smp_cpu/arch/i386/kernel/cpu/Config.in.in	2002-08-29 04:47:59.000000000 +0200
@@ -0,0 +1,182 @@
+cpu	386
+name	"386"
+arch	386
+align	4
+has
+wants
+end
+
+cpu	486
+name	"486"
+arch	486
+align	16
+has	
+mayhave	fpu smp
+wants	string_486
+end
+
+cpu	586
+name	"non-Intel 586 (586/K5/5x86/6x86)"
+align	16
+has	fpu
+mayhave	smp
+wants	string_486
+end
+
+cpu	586MX
+name	"non-Intel 586 MMX (6x86MX)"
+arch	586
+align	16
+has	fpu mmx
+mayhave	smp
+wants	string_486
+end
+
+cpu	586TSC
+name	"Intel Pentium"
+arch	586
+align	16
+has	f00f_bug fpu tsc
+mayhave	smp
+wants	string_486
+end
+
+cpu	586MMX
+name	"Intel Pentium MMX"
+arch	586
+align	16
+has	f00f_bug fpu good_apic mmx tsc
+mayhave	smp
+wants	string_486
+end
+
+cpu	686
+name	"Intel Pentium Pro"
+arch	686
+align	4
+has	fpu good_apic pae tsc
+mayhave	smp
+wants	686_checksum
+end
+
+cpu	PENTIUMII
+name	"Intel Pentium II"
+arch	686
+align	4
+has	fpu good_apic mmx pae tsc
+mayhave	smp
+wants	686_checksum
+end
+
+cpu	PENTIUMIII
+name	"Intel Pentium III"
+arch	686
+align	4
+has	fpu good_apic mmx mmxext pae xmm tsc
+mayhave	smp
+wants	686_checksum prefetch
+end
+
+cpu	PENTIUM4
+name	"Intel Pentium 4"
+arch	686
+# according to GCC source and P4 manual it might be possible to use
+# 0 alignment. Modify this if you are sure of it.
+align	4
+has	fpu good_apic mmx mmxext pae xmm xmm2 tsc
+mayhave	smp
+wants	686_checksum prefetch
+end
+
+cpu	K6
+name	"AMD K6"
+arch	586
+align	32
+has	fpu mmx tsc
+mayhave	smp
+wants	686_checksum
+end
+
+cpu	K6II
+name	"AMD K6-II/III/3D"
+arch	586
+align	32
+has	3dnow fpu mmx tsc
+mayhave	smp
+wants	686_checksum prefetch prefetchw
+end
+
+cpu	K7
+name	"AMD Athlon"
+arch	686
+align	4
+has	3dnow 3dnowext fpu good_apic mmx mmxext pae tsc
+mayhave	smp
+wants	686_checksum prefetch prefetchw
+end
+
+cpu	K7XMM
+name	"AMD Athlon XP/MP"
+arch	686
+align	4
+has	3dnow 3dnowext fpu good_apic mmx mmxext pae smp xmm tsc
+mayhave	smp
+wants	686_checksum prefetch prefetchw
+end
+
+cpu	CRUSOE
+name	"Transmeta Crusoe"
+arch	686
+align	0
+has	fpu mmx tsc
+mayhave	smp
+wants
+end
+
+cpu	WINCHIPC6
+name	"IDT Winchip C6"
+arch	586
+align	16
+has	fpu mmx oostore
+mayhave	smp
+wants	686_checksum
+end
+
+cpu	WINCHIP2
+name	"IDT Winchip 2"
+arch	586
+align	16
+has	fpu mmx oostore tsc
+mayhave	smp
+wants	686_checksum
+end
+
+cpu	WINCHIP3D
+name	"IDT Winchip 2A/3D"
+arch	586
+align	16
+has	3dnow fpu mmx oostore tsc
+mayhave	smp
+wants	686_checksum
+end
+
+cpu	CYRIXIII
+name	"Cyrix III/C3"
+arch	586
+align	16
+has	3dnow fpu mmx tsc
+mayhave	smp
+wants	686_checksum
+end
+
+comment "You won't get 64-bit support with the following choices: use ARCH=x86-64 make for that"
+
+# This is just considered an Athlon XP+long mode. Fix if you know better.
+cpu	K8
+name	"AMD Opteron"
+arch	686
+align	4
+has	3dnow 3dnowext fpu good_apic long mmx mmxext pae smp xmm tsc
+mayhave	smp
+wants	686_checksum prefetch prefetchw
+end
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_fixup_smp/arch/i386/Makefile linux-2.5.32_fixup_smp_cpu/arch/i386/Makefile
--- linux-2.5.32_fixup_smp/arch/i386/Makefile	2002-08-27 21:26:40.000000000 +0200
+++ linux-2.5.32_fixup_smp_cpu/arch/i386/Makefile	2002-08-29 04:42:48.000000000 +0200
@@ -20,71 +20,103 @@ LDFLAGS		:= -m elf_i386
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux := -T arch/i386/vmlinux.lds -e stext
 
+__cc_test = if $(CC) $(1) -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "$(1)"; $(2)fi
+# -f* is only supported in GCC 3.0 and -m* gives warnings in GCC 3.1
+cc_test = $(call __cc_test,$(1),)
+cc_test_ = $(call __cc_test,$(1),else $(2); )
+cc_test_o = $(call cc_test_,-$(1)=$(2),echo "-$(1)=$(3)")
+cc_test_o3 = $(call cc_test_,-$(1)=$(2),$(call cc_test_o,$(1),$(3),$(4)))
+cc_test_align = $(call cc_test_,-falign-loops=$(1) -falign-jumps=$(1) -falign-functions=$(1),echo "-malign-loops=$(1) -malign-jumps=$(1) -malign-functions=$(1)")
 CFLAGS += -pipe
 
 # prevent gcc from keeping the stack 16 byte aligned
-CFLAGS += $(shell if $(CC) -mpreferred-stack-boundary=2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mpreferred-stack-boundary=2"; fi)
+CFLAGS += $(shell $(call cc_test,-mpreferred-stack-boundary=2))
 
-ifdef CONFIG_M386
-CFLAGS += -march=i386
+# MMX, SSE and SSE2 are disabled to prevent use by compiler (that could clobber user registers and cause unexpected oopses)
+# and because builtins must not be used until we require GCC 3.1
+CFLAGS += $(shell $(call cc_test,-mno-mmx -mno-sse -mno-sse2))
+
+ifdef CONFIG_X86_MARCH_686
+ifdef CONFIG_X86_MAY_WANT_PREFETCHW
+MARCH = $(shell $(call cc_test_o,mcpu,athlon-xp,i686))
+else
+ifdef CONFIG_X86_MAY_WANT_PREFETCH
+MARCH = $(shell $(call cc_test_o,mcpu,pentium3,i686))
+else
+MARCH = -march=i686
+endif
+endif
 endif
 
-ifdef CONFIG_M486
-CFLAGS += -march=i486
+ifdef CONFIG_X86_MARCH_586
+ifdef CONFIG_X86_MAY_WANT_PREFETCHW
+MARCH = $(shell $(call cc_test_o,mcpu,k6-2,i586))
+else
+MARCH = -march=i586
+endif
 endif
 
-ifdef CONFIG_M586
-CFLAGS += -march=i586
+ifdef CONFIG_X86_MARCH_486
+MARCH = -march=i486
 endif
 
-ifdef CONFIG_M586TSC
-CFLAGS += -march=i586
+ifdef CONFIG_X86_MARCH_386
+MARCH = -march=i386
 endif
 
-ifdef CONFIG_M586MMX
-CFLAGS += -march=i586
+ifeq ($(MARCH),)
+ifneq ($(filter-out $(noconfig_targets),$(MAKECMDGOALS)),)
+$(error At least one processor must be selected!)
+endif
 endif
 
-ifdef CONFIG_M686
-CFLAGS += -march=i686
+CFLAGS += $(MARCH)
+
+
+ifdef CONFIG_X86_MCPU_386
+CFLAGS += -mcpu=i386
 endif
 
-ifdef CONFIG_MPENTIUMIII
-CFLAGS += -march=i686
+ifdef CONFIG_X86_MCPU_486
+CFLAGS += -mcpu=i486
 endif
 
-ifdef CONFIG_MPENTIUM4
-CFLAGS += -march=i686
+ifdef CONFIG_X86_MCPU_586
+CFLAGS += -mcpu=i586
 endif
 
-ifdef CONFIG_MK6
-CFLAGS += $(shell if $(CC) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6"; else echo "-march=i586"; fi)
+ifdef CONFIG_X86_MCPU_686
+CFLAGS += -mcpu=i686
 endif
 
-ifdef CONFIG_MK7
-CFLAGS += $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi) 
+ifdef CONFIG_X86_MCPU_PENTIUM4
+CFLAGS += $(shell $(call cc_test_o,mcpu,pentium4,i686))
 endif
 
-ifdef CONFIG_MCRUSOE
-CFLAGS += -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0
+ifdef CONFIG_X86_MCPU_K6
+CFLAGS += $(shell $(call cc_test_o,mcpu,k6,i686))
 endif
 
-ifdef CONFIG_MWINCHIPC6
-CFLAGS += -march=i586
+ifdef CONFIG_X86_MCPU_ATHLON
+CFLAGS += $(shell $(call cc_test_o,mcpu,athlon,i686))
 endif
 
-ifdef CONFIG_MWINCHIP2
-CFLAGS += -march=i586
+ALIGN = $(shell $(call cc_test_align,0))
+
+ifdef CONFIG_X86_ALIGNMENT_4
+ALIGN = $(shell $(call cc_test_align,2))
 endif
 
-ifdef CONFIG_MWINCHIP3D
-CFLAGS += -march=i586
+ifdef CONFIG_X86_ALIGNMENT_16
+ALIGN = $(shell $(call cc_test_align,4))
 endif
 
-ifdef CONFIG_MCYRIXIII
-CFLAGS += -march=i586
+ifdef CONFIG_X86_ALIGNMENT_32
+ALIGN = $(shell $(call cc_test_align,5))
 endif
 
+CFLAGS += $(ALIGN)
+
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 SUBDIRS += arch/i386/kernel arch/i386/mm arch/i386/lib
@@ -141,3 +173,15 @@ archclean:
 	@$(MAKEBOOT) clean
 
 archmrproper:
+
+arch/$(ARCH)/kernel/cpu/Config.in: arch/$(ARCH)/kernel/cpu/Config.in.in scripts/gencpucfg
+	@echo 'scripts/gencpucfg --config $< X86_>$@'
+	@scripts/gencpucfg --config $< X86_>$@; ret=$$?; if test "$$ret" != 0; then rm -f $@; fi; exit $$ret
+
+include/asm/cpufeature_config.h: arch/$(ARCH)/kernel/cpu/Config.in.in scripts/gencpucfg
+	@echo 'scripts/gencpucfg --header $< X86_>$@'
+	@scripts/gencpucfg --header $< X86_>$@; ret=$$?; if test "$$ret" != 0; then rm -f $@; fi; exit $$ret
+
+prepare: include/asm/cpufeature_config.h
+
+arch/$(ARCH)/config.in: arch/$(ARCH)/kernel/cpu/Config.in
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_fixup_smp/Makefile linux-2.5.32_fixup_smp_cpu/Makefile
--- linux-2.5.32_fixup_smp/Makefile	2002-08-27 21:26:34.000000000 +0200
+++ linux-2.5.32_fixup_smp_cpu/Makefile	2002-08-29 02:31:24.000000000 +0200
@@ -565,36 +565,38 @@ ifeq ($(filter-out $(noconfig_targets),$
 # Kernel configuration
 # ---------------------------------------------------------------------------
 
+include arch/$(ARCH)/Makefile
+
 .PHONY: oldconfig xconfig menuconfig config \
 	make_with_config
 
-xconfig:
+xconfig: arch/$(ARCH)/config.in
 	@$(MAKE) -C scripts kconfig.tk
 	wish -f scripts/kconfig.tk
 
-menuconfig:
+menuconfig: arch/$(ARCH)/config.in
 	@$(MAKE) -C scripts lxdialog
 	$(CONFIG_SHELL) $(src)/scripts/Menuconfig arch/$(ARCH)/config.in
 
-config:
+config: arch/$(ARCH)/config.in
 	$(CONFIG_SHELL) $(src)/scripts/Configure arch/$(ARCH)/config.in
 
-oldconfig:
+oldconfig: arch/$(ARCH)/config.in
 	$(CONFIG_SHELL) $(src)/scripts/Configure -d arch/$(ARCH)/config.in
 
-randconfig:
+randconfig: arch/$(ARCH)/config.in
 	$(CONFIG_SHELL) $(src)/scripts/Configure -r arch/$(ARCH)/config.in
 
-allyesconfig:
+allyesconfig: arch/$(ARCH)/config.in
 	$(CONFIG_SHELL) $(src)/scripts/Configure -y arch/$(ARCH)/config.in
 
-allnoconfig:
+allnoconfig: arch/$(ARCH)/config.in
 	$(CONFIG_SHELL) $(src)/scripts/Configure -n arch/$(ARCH)/config.in
 
-allmodconfig:
+allmodconfig: arch/$(ARCH)/config.in
 	$(CONFIG_SHELL) $(src)/scripts/Configure -m arch/$(ARCH)/config.in
 
-defconfig:
+defconfig: arch/$(ARCH)/config.in
 	yes '' | $(CONFIG_SHELL) $(src)/scripts/Configure -d arch/$(ARCH)/config.in
 
 # Cleaning up
@@ -654,8 +656,6 @@ MRPROPER_DIRS += \
 
 #	That's our way to know about arch specific cleanup.
 
-include arch/$(ARCH)/Makefile
-
 clean:	archclean
 	@echo 'Cleaning up'
 	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_fixup_smp/scripts/gencpucfg linux-2.5.32_fixup_smp_cpu/scripts/gencpucfg
--- linux-2.5.32_fixup_smp/scripts/gencpucfg	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.32_fixup_smp_cpu/scripts/gencpucfg	2002-08-29 04:50:55.000000000 +0200
@@ -0,0 +1,140 @@
+#!/bin/bash
+# Copyright 2002 Luca Barbieri
+# This code is released under the GNU General Public License version 2 or later.
+
+type="$1"
+input="$2"
+varprefix="$3"
+prefix="$4"
+
+low="abcdefghijklmnopqrstuvwxyz"
+up="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+
+for((i = 0; i < 26; i++)); do
+	eval UP_${low:$i:1}="${up:$i:1}"
+done
+
+function real_upcase()
+{
+	local str="$1"
+	upstr=""
+	for((i = 0; $i < ${#str}; i++)); do
+		local c="${str:$i:1}"
+		eval local up=\$UP_$c
+		if test -n "$up"; then
+			upstr="$upstr$up"
+		else
+			upstr="$upstr$c"
+		fi
+	done
+}
+
+# Caching upcase in bash
+function upcase()
+{
+	eval upstr=\$UPSTR_$1
+	if test -z "$upstr"; then
+		real_upcase $1
+		eval UPSTR_$1=$upstr
+	fi
+}
+
+function fixlist() { echo "$*"|tr ' ' '\n'|sort|uniq|tr '\n' ' '; }
+
+function arch() { :; }
+function align() { :; }
+function note() { :; }
+function end() { :; }
+function name() { :; }
+function comment() { :; }
+
+allhas=""
+allwants=""
+allcpus=""
+allarch=
+allalign=
+
+function cpu() { curcpu=$1; allcpus="$allcpus $1"; }
+if test "$type" == "--config"; then
+echo "# Automatically generated by scripts/gencpucfg $*"
+echo ""
+function name() { echo "${prefix}bool '$1' CONFIG_M$curcpu"; }
+function comment() { echo "comment \""${*/\"/\'}\"; }
+fi
+function arch() { allarch="$allarch march_$1"; }
+function align() { allalign="$allalign alignment_$1"; }
+function has() { for i in $*; do allhas="$allhas have_$i"; done; }
+function mayhave() { for i in $*; do allhas="$allhas have_$i"; done; }
+function wants() { for i in $*; do allwants="$allwants want_$i"; done; }
+function maywant() { for i in $*; do allwants="$allwants want_$i"; done; }
+
+. "$input"
+
+allvarslow="`fixlist "$allarch $allalign $allhas $allwants"`"
+real_upcase "$allvarslow"
+allvars="$upstr"
+
+if test "$type" == "--config"; then
+echo ""
+
+prefix2="${prefix}   "
+function cpu() { curcpu=$1; }
+function name() { :; }
+function arch() { upcase $1; eval VAR_${curcpu}_MARCH_${upstr}=y; }
+function align() { eval VAR_${curcpu}_ALIGNMENT_$1=y; }
+function has() { for i in $*; do upcase $i; eval VAR_${curcpu}_HAVE_$upstr=y; done; }
+function mayhave() { for i in $*; do upcase $i; eval VARMAY_${curcpu}_HAVE_$upstr=y; done; }
+function wants() { for i in $*; do upcase $i; eval VAR_${curcpu}_WANT_$upstr=y; done; }
+function maywant() { for i in $*; do upcase $i; eval VARMAY_${curcpu}_WANT_$upstr=y; done; }
+function end() { :; }
+function comment() { :; }
+
+. "$input"
+
+for var in $allvars; do
+	for flavor in MAY_ MAY_NOT_; do
+		if test "$flavor" == MAY_NOT_ -a \( "${var:0:6}" == "MARCH_" -o "${var:0:10}" == "ALIGNMENT_" \); then continue; fi
+		ifprinted=
+		for cpu in $allcpus; do
+			eval maybe=\$VARMAY_${cpu}_$var
+			eval surely=\$VAR_${cpu}_$var
+			if test \( $flavor == MAY_ -a \( -n "$maybe" -o -n "$surely" \) \) -o \( $flavor == MAY_NOT_ -a \( -n "$maybe" -o -z "$surely" \) \); then
+				if test -z "$ifprinted"; then
+					echo -n "${prefix}if [ \"\$CONFIG_M$cpu\" = \"y\""
+					ifprinted=1
+				else
+					echo -n " -o \"\$CONFIG_M$cpu\" = \"y\""
+				fi
+			fi
+		done
+		if test -n "$ifprinted"; then
+			if test "$flavor" == MAY_ -a \( "${var:0:6}" == "MARCH_" -o "${var:0:10}" == "ALIGNMENT_" \); then flavor=; fi
+			echo " ]; then"
+			echo "${prefix2}define_bool CONFIG_$varprefix$flavor$var y"		
+			echo "${prefix}fi"
+			echo ""
+		fi
+	done
+done
+
+elif test "$type" == "--header"; then
+echo "/* Automatically generated by scripts/gencpucfg $* */"
+echo ""
+for var in $allvarslow; do
+	upcase "$var"
+	if test "${upstr:0:6}" == "MARCH_" -o "${upstr:0:10}" == "ALIGNMENT_"; then continue; fi
+	if test "${var:0:5}" == "have_"; then var=has_${var:5}; fi
+	if test "${var:0:5}" == "want_"; then var=wants_${var:5}; fi
+	echo "#ifdef cpu_$var"
+	echo "#error \"Conflict on cpu_$var\""
+	echo "#endif"
+	echo "#if defined(CONFIG_${varprefix}MAY_$upstr) && defined(CONFIG_${varprefix}MAY_NOT_$upstr)"
+	echo "#define cpu_$var	__cpu_$var"
+	echo "#elif defined(CONFIG_${varprefix}MAY_$upstr)"
+	echo "#define cpu_$var	1"
+	echo "#else"
+	echo "#define cpu_$var	0"
+	echo "#endif"
+	echo ""
+done
+fi



--=-EmtKZMGV+fE/oAaBqlJC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9bZ9Wdjkty3ft5+cRAjASAJ9KtcRT0Xv4hAIrf2oADWcttsu8GQCdHvKO
lDVB7k4oiH09j2Fy8fX7MiE=
=YC9X
-----END PGP SIGNATURE-----

--=-EmtKZMGV+fE/oAaBqlJC--
