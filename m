Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317696AbSHDOX6>; Sun, 4 Aug 2002 10:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317799AbSHDOX6>; Sun, 4 Aug 2002 10:23:58 -0400
Received: from ppp-217-133-220-178.dialup.tiscali.it ([217.133.220.178]:58341
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317696AbSHDOXx>; Sun, 4 Aug 2002 10:23:53 -0400
Subject: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ps4UTj0BEWIsGUiPVeE5"
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Aug 2002 16:27:16 +0200
Message-Id: <1028471237.1294.515.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ps4UTj0BEWIsGUiPVeE5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is a revised version of a patch I posted a few months ago and
implements all the suggestions that were posted in reply and several
other things. 


This patch does the following: 
- Modifies CPU choices texts to include processor features (e.g.
"586+MMX+TSC...Pentium-MMX")
- Splits Pentium2 and PentiumPro 
- Splits K6 and K6-2/K6-3
- Splits Athlon and Athlon-SSE
- Splits 586 and 6x86MX
- Makes CONFIG_X86_PPRO_FENCE user-settable and disable if not SMP or
CPU incompatible with Pentium Pro selected 
- Supports F0 0F bug workaround for all kernels that don't require 686
or 3DNow! 
- Defines CONFIG_X86_{686,MMX{EXT,},SSE{2,},3DNOW{EXT,}}: all except
MMXEXT are currently unused (this is the reason for splitting
Athlon-SSE, 6x86MX and Pentium2)
- Updates and adds entries in Config.help 
- Compiles K6s with -march=i586 -mcpu=i686 if -march=k6{-2,} is not
available (matches insn costs more closely)
- Replaces GCC tests in Makefile with calls to new cc_test function to
reduce redundancy
- Uses -march={pentium{-mmx,2,3,4},k6{-2,},athlon{-xp,}} when
appropriate and supported and adds -mno-{mmx,sse{2,}} to prevent
careless use of builtin and automatic use by compiler
- Adds panics for CONFIG_X86_{PPRO_FENCE,USE_SSE_PREFETCH,686,USE_3DNOW}
in bugs.h
- Enables prefetchnta when CONFIG_X86_USE_SSE_PREFETCH is defined, which
happens for Pentium3, Pentium4 and Athlon
- Causes Athlon to use prefetchnta rather than prefetch 
- Adds Makefile entry for Elan (as 486)


I need help on these issues:
- I have read the specification update and Intel explicitly says that UP
systems are not affected, but the use of CONFIG_PPRO_FENCE in io.h might
indicate the contrary. Does anyone know if this is the case or not?
(patch assumes Intel is right)

- Is prefetchnta really better than prefetch on Athlons? (consider both
prefetch() and memcpy()) (patch assumes it is for prefetch() but doesn't
modify memcpy())

- The optimized memcpy routines seem seriously deficient: IMHO they
should be available in MMX, MMX+prefetch, MMX+prefetch+nt, SSE and SSE2
flavors rather than only MMX+prefetch and a partial version of
MMX+prefetch+nt (uses movntq but not prefetchnta). Any comments? Is
anyone doing this/did anyone already do this?

- Should I port this to 2.4? 


diffstat:
 arch/i386/config.in           |  106 +++++++++++++++++++++++++++++++++---------
 arch/i386/Config.help         |   93 +++++++++++++++++++++++++++---------
 arch/i386/Makefile            |   43 ++++++++++++++---
 include/asm-i386/bugs.h       |   23 +++++++++
 include/asm-i386/processor.h  |    9 ++-
 arch/i386/kernel/cpu/common.c |    4 +
 arch/i386/lib/mmx.c           |    2 
 7 files changed, 224 insertions(+), 56 deletions(-)


diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/Config.help b/arch/i386/Config.help
--- a/arch/i386/Config.help	2002-07-20 21:11:07.000000000 +0200
+++ b/arch/i386/Config.help	2002-08-04 07:37:29.000000000 +0200
@@ -403,14 +403,18 @@
    - "486" for the AMD/Cyrix/IBM/Intel 486DX/DX2/DX4 or
      SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or U5S.
    - "586" for generic Pentium CPUs lacking the TSC
-     (time stamp counter) register.
-   - "Pentium-Classic" for the Intel Pentium.
-   - "Pentium-MMX" for the Intel Pentium MMX.
-   - "Pentium-Pro" for the Intel Pentium Pro/Celeron/Pentium II.
+     (time stamp counter) register and MMX instructions.
+   - 6x86MX for the 6x86MX and generic Pentium CPUs lacking the TSC
+     but with MMX instructions.
+   - "Pentium-Classic" for the Intel Pentium (586 with TSC).
+   - "Pentium-MMX" for the Intel Pentium MMX (586 with TSC+MMX).
+   - "Pentium-Pro" for the Intel Pentium Pro/Celeron.
+   - "Pentium-II" for the Intel Pentium II.
    - "Pentium-III" for the Intel Pentium III
      and Celerons based on the Coppermine core.
    - "Pentium-4" for the Intel Pentium 4.
-   - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
+   - "K6" for the AMD K6
+   - "K6-2" for the K6-II and K6-III (aka K6-3D).
    - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
    - "Crusoe" for the Transmeta Crusoe series.
    - "Winchip-C6" for original IDT Winchip.
@@ -418,7 +422,9 @@
    - "Winchip-2A" for IDT Winchips with 3dNow! capabilities.
    - "CyrixIII" for VIA Cyrix III or VIA C3.
 
-  If you don't know what to do, choose "386".
+  If you don't know what to do, type "cat /proc/cpuinfo" or open the
+  case and look at the processor. If you are building a generic
+  kernel or don't have access to the target machine, choose "386".
 
 CONFIG_M486
   Select this for a x486 processor, ether Intel or one of the
@@ -431,18 +437,38 @@
   Intel 5x86 or 6x86, or the Intel 6x86MX.  This choice does not
   assume the RDTSC (Read Time Stamp Counter) instruction.
 
+CONFIG_M586MX
+  Select this for the NexGen 6x86MX and other Pentium-class processors
+  with the MMX graphics/multimedia extended instructions but without
+  the RDTSC (Read Time Stamp Counter) instruction.
+
 CONFIG_M586TSC
   Select this for a Pentium Classic processor with the RDTSC (Read
   Time Stamp Counter) instruction for benchmarking.
 
 CONFIG_M586MMX
   Select this for a Pentium with the MMX graphics/multimedia
-  extended instructions.
+  extended instructions and with the RDTSC (Read Time Stamp Counter)
+  instruction for benchmarking.
 
 CONFIG_M686
-  Select this for a Pro/Celeron/Pentium II.  This enables the use of
-  Pentium Pro extended instructions, and disables the init-time guard
-  against the f00f bug found in earlier Pentiums.
+  Select this for a non-Intel/AMD 686 processor without MMX support
+  support. This enables the use of Pentium Pro extended instructions
+  and disables the init-time guard against the f00f bug found in
+  earlier Pentiums.
+
+CONFIG_MPENTIUMPRO
+  Select this for a Pentium Pro or Celeron. This enables the use of
+  Pentium Pro extended instructions, disables  the init-time guard
+  against the f00f bug found in earlier Pentiums and enables the
+  workaround for the Pentium Pro store ordering bug.
+
+CONFIG_MPENTIUMII
+  Select this for a Pentium II or another 686 processor with MMX
+  support. This enables the use of Pentium Pro extended instructions,
+  disables  the init-time guard against the f00f bug found in earlier
+  Pentiums and disables the workaround for the Pentium Pro store
+  ordering bug.
 
 CONFIG_MPENTIUMIII
   Select this for Intel chips based on the Pentium-III and
@@ -450,9 +476,10 @@
   instructions, in addition to the Pentium II extensions.
 
 CONFIG_MPENTIUM4
-  Select this for Intel Pentium 4 chips.  Presently these are
-  treated almost like Pentium IIIs, but with a different cache
-  shift.
+  Select this for Intel Pentium 4 chips.  They have a different cache
+  shift and if you are compiling with GCC 3.1 or later instructions
+  will be selected and ordered specifically for maximum performance on
+  the Intel Pentium 4.
 
 CONFIG_MCRUSOE
   Select this for Transmeta Crusoe processor.  Treats the processor
@@ -460,14 +487,18 @@
   Pentium Pro with no alignment requirements).
 
 CONFIG_MK6
-  Select this for an AMD K6-family processor.  Enables use of
-  some extended instructions, and passes appropriate optimization
-  flags to GCC.
+  Select this for an AMD K6 processor.  Enables use of some extended
+  instructions, and passes appropriate optimization flags to GCC.
+
+CONFIG_MK6
+  Select this for an AMD K6-2/K6-3D or K6-3.  Enables use of some
+  extended instructions, passes appropriate optimization flags to GCC
+  and enables 3DNow!
 
 CONFIG_MK7
   Select this for an AMD Athlon K7-family processor.  Enables use of
-  some extended instructions, and passes appropriate optimization
-  flags to GCC.
+  some extended instructions, passes appropriate optimization flags to
+  GCC and enables 3DNow!
 
 CONFIG_MCYRIXIII
   Select this for a Cyrix III or C3 chip.  Presently Linux and GCC
@@ -477,20 +508,34 @@
 
 CONFIG_MWINCHIPC6
   Select this for a IDT Winchip C6 chip.  Linux and GCC
-  treat this chip as a 586TSC with some extended instructions
-  and alignment requirements.
+  treat this chip as a 586 with some extended instructions
+  and alignment requirements.  Development kernels also enable
+  out of order memory stores for this CPU, which can increase
+  performance of some operations.
 
 CONFIG_MWINCHIP2
   Select this for a IDT Winchip-2.  Linux and GCC
   treat this chip as a 586TSC with some extended instructions
-  and alignment requirements.
+  and alignment requirements.  Development kernels also enable
+  out of order memory stores for this CPU, which can increase
+  performance of some operations.
 
 CONFIG_MWINCHIP3D
   Select this for a IDT Winchip-2A or 3.  Linux and GCC
   treat this chip as a 586TSC with some extended instructions
-  and alignment reqirements.  Development kernels also enable
-  out of order memory stores for this CPU, which can increase
-  performance of some operations.
+  and alignment reqirements and with 3DNow! support.  Development
+  kernels also enable out of order memory stores for this CPU, which
+  can increase performance of some operations.
+
+CONFIG_X86_PPRO_FENCE
+  Allows the kernel to run on Pentium Pro SMP systems by supporting a
+  workaround for the store ordering bug present on them.
+  This slows down all processors except WinChips since they already do
+  out-of-order stores.
+
+  If you don't know what to do, type "cat /proc/cpuinfo" or open the
+  case and look at the processor. If you are building a generic
+  kernel or don't have access to the target machine, choose Y.
 
 CONFIG_VGA_CONSOLE
   Saying Y here will allow you to use Linux in text mode through a
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	2002-07-29 04:22:22.000000000 +0200
+++ b/arch/i386/config.in	2002-08-04 14:59:39.000000000 +0200
@@ -17,20 +17,24 @@
 choice 'Processor family' \
 	"386					CONFIG_M386 \
 	 486					CONFIG_M486 \
-	 586/K5/5x86/6x86/6x86MX		CONFIG_M586 \
-	 Pentium-Classic			CONFIG_M586TSC \
-	 Pentium-MMX				CONFIG_M586MMX \
-	 Pentium-Pro/Celeron/Pentium-II		CONFIG_M686 \
-	 Pentium-III/Celeron(Coppermine)	CONFIG_MPENTIUMIII \
+	 586/K5/5x86/6x86			CONFIG_M586 \
+	 586+MMX...6x86MX			CONFIG_M586MX \
+	 586+TSC...Pentium-Classic		CONFIG_M586TSC \
+	 586+TSC+MMX...Pentium-MMX		CONFIG_M586MMX \
+	 686...Pentium-Pro/Celeron		CONFIG_M686 \
+	 686+MMX...Pentium-II			CONFIG_MPENTIUMII \
+	 686+SSE...Pentium-III/Celeron(Coppermine)	CONFIG_MPENTIUMIII \
 	 Pentium-4				CONFIG_MPENTIUM4 \
-	 K6/K6-II/K6-III			CONFIG_MK6 \
-	 Athlon/Duron/K7			CONFIG_MK7 \
+	 K6              			CONFIG_MK6 \
+	 K6-II/K6-III 				CONFIG_MK6II \
+	 K7...Athlon/Duron			CONFIG_MK7 \
+	 K7+SSE...Athlon-4/XP/MP			CONFIG_MK7SSE \
 	 Elan					CONFIG_MELAN \
 	 Crusoe					CONFIG_MCRUSOE \
 	 Winchip-C6				CONFIG_MWINCHIPC6 \
-	 Winchip-2				CONFIG_MWINCHIP2 \
-	 Winchip-2A/Winchip-3			CONFIG_MWINCHIP3D \
-	 CyrixIII/C3				CONFIG_MCYRIXIII" Pentium-Pro
+	 Winchip+TSC...Winchip-2			CONFIG_MWINCHIP2 \
+	 Winchip+TSC+3DNow...Winchip-2A/Winchip-3	CONFIG_MWINCHIP3D \
+	 CyrixIII/C3				CONFIG_MCYRIXIII" Pentium-III
 #
 # Define implied options from the CPU selection here
 #
@@ -41,8 +45,6 @@
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
    define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
-   define_bool CONFIG_X86_PPRO_FENCE y
-   define_bool CONFIG_X86_F00F_BUG y
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
@@ -57,23 +59,23 @@
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_PPRO_FENCE y
-   define_bool CONFIG_X86_F00F_BUG y
 fi
 if [ "$CONFIG_M586" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_PPRO_FENCE y
-   define_bool CONFIG_X86_F00F_BUG y
+fi
+if [ "$CONFIG_M586MX" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_bool CONFIG_X86_USE_STRING_486 y
+   define_bool CONFIG_X86_ALIGNMENT_16 y
+   define_bool CONFIG_X86_MMX y
 fi
 if [ "$CONFIG_M586TSC" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_PPRO_FENCE y
-   define_bool CONFIG_X86_F00F_BUG y
 fi
 if [ "$CONFIG_M586MMX" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -81,33 +83,60 @@
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
-   define_bool CONFIG_X86_PPRO_FENCE y
-   define_bool CONFIG_X86_F00F_BUG y
+   define_bool CONFIG_X86_MMX y
 fi
 if [ "$CONFIG_M686" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-   define_bool CONFIG_X86_PPRO_FENCE y
+   define_bool CONFIG_X86_686 y
+fi
+if [ "$CONFIG_MPENTIUMII" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_686 y
+   define_bool CONFIG_X86_MMX y
 fi
 if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_686 y
+   define_bool CONFIG_X86_MMX y
+   define_bool CONFIG_X86_MMXEXT y
+   define_bool CONFIG_X86_SSE y
+   define_bool CONFIG_X86_USE_SSE_PREFETCH y
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_686 y
+   define_bool CONFIG_X86_MMX y
+   define_bool CONFIG_X86_MMXEXT y
+   define_bool CONFIG_X86_SSE y
+   define_bool CONFIG_X86_SSE2 y
+   define_bool CONFIG_X86_USE_SSE_PREFETCH y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_MMX y
+fi
+if [ "$CONFIG_MK6II" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_bool CONFIG_X86_ALIGNMENT_16 y
+   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_MMX y
+   define_bool CONFIG_X86_3DNOW y
 fi
 if [ "$CONFIG_MK7" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 6
@@ -115,6 +144,26 @@
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_686 y
+   define_bool CONFIG_X86_MMX y
+   define_bool CONFIG_X86_MMXEXT y
+   define_bool CONFIG_X86_3DNOW y
+   define_bool CONFIG_X86_3DNOWEXT y
+   define_bool CONFIG_X86_USE_SSE_PREFETCH y
+fi
+if [ "$CONFIG_MK7SSE" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_USE_3DNOW y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_686 y
+   define_bool CONFIG_X86_MMX y
+   define_bool CONFIG_X86_MMXEXT y
+   define_bool CONFIG_X86_3DNOW y
+   define_bool CONFIG_X86_3DNOWEXT y
+   define_bool CONFIG_X86_SSE y
+   define_bool CONFIG_X86_USE_SSE_PREFETCH y
 fi
 if [ "$CONFIG_MELAN" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
@@ -127,16 +176,20 @@
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_MMX y
+   define_bool CONFIG_X86_3DNOW y
 fi
 if [ "$CONFIG_MCRUSOE" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_686 y
 fi
 if [ "$CONFIG_MWINCHIPC6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
+   define_bool CONFIG_X86_MMX y
 fi
 if [ "$CONFIG_MWINCHIP2" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -144,6 +197,7 @@
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
+   define_bool CONFIG_X86_MMX y
 fi
 if [ "$CONFIG_MWINCHIP3D" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -151,6 +205,16 @@
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
+   define_bool CONFIG_X86_MMX y
+   define_bool CONFIG_X86_3DNOW y
+fi
+
+# Enable workarounds if kernel would not panic on an affected processor
+if [ "$CONFIG_X86_686" != "y" -a "$CONFIG_X86_USE_3DNOW" != "y" ]; then
+   define_bool CONFIG_X86_F00F_BUG y
+fi
+if [ "$CONFIG_X86_USE_SSE_PREFETCH" != "y" -a "$CONFIG_X86_USE_3DNOW" != "y" -a "$CONFIG_X86_OOSTORE" != "y" ]; then
+   dep_bool 'Support Pentium Pro SMP and slow down all processors' CONFIG_X86_PPRO_FENCE $CONFIG_SMP
 fi
 
 bool 'Symmetric multi-processing support' CONFIG_SMP
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	2002-07-29 04:18:06.000000000 +0200
+++ b/arch/i386/kernel/cpu/common.c	2002-08-04 09:58:15.000000000 +0200
@@ -299,6 +299,10 @@
 		clear_bit(X86_FEATURE_TSC, c->x86_capability);
 #endif
 
+	/* Intel SSE-capable processors have all AMD MMX extensions */
+	if(test_bit(X86_FEATURE_XMM, c->x86_capability))
+		set_bit(X86_FEATURE_MMXEXT, c->x86_capability);
+
 	/* FXSR disabled? */
 	if (disable_x86_fxsr) {
 		clear_bit(X86_FEATURE_FXSR, c->x86_capability);
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/lib/mmx.c b/arch/i386/lib/mmx.c
--- a/arch/i386/lib/mmx.c	2002-07-20 21:11:20.000000000 +0200
+++ b/arch/i386/lib/mmx.c	2002-08-04 09:58:49.000000000 +0200
@@ -121,7 +121,7 @@
 	return p;
 }
 
-#ifdef CONFIG_MK7
+#ifdef CONFIG_X86_MMXEXT
 
 /*
  *	The K7 has streaming cache bypass load/store. The Cyrix III, K6 and
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	2002-07-20 21:11:13.000000000 +0200
+++ b/arch/i386/Makefile	2002-08-04 15:51:08.000000000 +0200
@@ -20,10 +20,20 @@
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux := -T arch/i386/vmlinux.lds -e stext
 
+__cc_test = if $(CC) $(1) -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "$(1)"; $(2)fi
+cc_test = $(call __cc_test,$(1),)
+cc_test_ = $(call __cc_test,$(1),else $(2); )
+cc_test_march = $(call cc_test_,-march=$(1),echo "-march=$(2)")
+cc_test_march3 = $(call cc_test_,-march=$(1),$(call cc_test_march,$(2),$(3)))
+
 CFLAGS += -pipe
 
 # prevent gcc from keeping the stack 16 byte aligned
-CFLAGS += $(shell if $(CC) -mpreferred-stack-boundary=2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mpreferred-stack-boundary=2"; fi)
+CFLAGS += $(shell $(call cc_test,-mpreferred-stack-boundary=2))
+
+# MMX, SSE and SSE2 are disabled to prevent use by compiler (that could clobber user registers and cause unexpected oopses)
+# and because builtins must not be used until we require GCC 3.1
+CFLAGS += $(shell $(call cc_test,-mno-mmx -mno-sse -mno-sse2))
 
 ifdef CONFIG_M386
 CFLAGS += -march=i386
@@ -33,6 +43,10 @@
 CFLAGS += -march=i486
 endif
 
+ifdef CONFIG_MELAN
+CFLAGS += -march=i486
+endif
+
 ifdef CONFIG_M586
 CFLAGS += -march=i586
 endif
@@ -41,32 +55,48 @@
 CFLAGS += -march=i586
 endif
 
+ifdef CONFIG_M586MX
+CFLAGS += $(shell $(call cc_test_march,pentium-mmx,i586))
+endif
+
 ifdef CONFIG_M586MMX
-CFLAGS += -march=i586
+CFLAGS += $(shell $(call cc_test_march,pentium-mmx,i586))
 endif
 
 ifdef CONFIG_M686
 CFLAGS += -march=i686
 endif
 
+ifdef CONFIG_MPENTIUMII
+CFLAGS += $(shell $(call cc_test_march,pentium2,i686))
+endif
+
 ifdef CONFIG_MPENTIUMIII
-CFLAGS += -march=i686
+CFLAGS += $(shell $(call cc_test_march,pentium3,i686))
 endif
 
 ifdef CONFIG_MPENTIUM4
-CFLAGS += -march=i686
+CFLAGS += $(shell $(call cc_test_march,pentium4,i686))
 endif
 
 ifdef CONFIG_MK6
-CFLAGS += $(shell if $(CC) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6"; else echo "-march=i586"; fi)
+CFLAGS += $(shell $(call cc_test_march,k6,i586 -mcpu=i686))
+endif
+
+ifdef CONFIG_MK6II
+CFLAGS += $(shell $(call cc_test_march3,k6-2,k6,i586 -mcpu=i686))
 endif
 
 ifdef CONFIG_MK7
-CFLAGS += $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi) 
+CFLAGS += $(shell $(call cc_test_march,athlon,i686))
+endif
+
+ifdef CONFIG_MK7SSE
+CFLAGS += $(shell $(call cc_test_march3,athlon-xp,athlon,i686))
 endif
 
 ifdef CONFIG_MCRUSOE
-CFLAGS += -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0
+CFLAGS += $(shell $(call cc_test_march,crusoe,i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0))
 endif
 
 ifdef CONFIG_MWINCHIPC6
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/include/asm-i386/bugs.h b/include/asm-i386/bugs.h
--- a/include/asm-i386/bugs.h	2002-07-20 21:11:09.000000000 +0200
+++ b/include/asm-i386/bugs.h	2002-08-04 15:27:40.000000000 +0200
@@ -171,6 +171,11 @@
 		panic("Kernel requires i486+ for 'invlpg' and other features");
 #endif
 
+#if defined(CONFIG_X86_686)
+	if(boot_cpu_data.x86 < 6)
+		panic("Kernel requires 686+ for cmov");
+#endif
+	
 /*
  * If we configured ourselves for a TSC, we'd better have one!
  */
@@ -193,6 +198,24 @@
 	    && (boot_cpu_data.x86_mask < 6 || boot_cpu_data.x86_mask == 11))
 		panic("Kernel compiled for PMMX+, assumes a local APIC without the read-before-write bug!");
 #endif
+
+#if !defined(CONFIG_X86_PPRO_FENCE) && defined(CONFIG_SMP)
+	if(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL
+	   && boot_cpu_data.x86 == 6
+	   && boot_cpu_data.x86_model <= 1
+		)
+		panic("Kernel compiled without Pentium Pro SMP support!");
+#endif
+
+#if defined(CONFIG_X86_USE_3DNOW)
+	if(!boot_cpu_has(X86_FEATURE_3DNOW))
+		panic("Kernel requires 3DNow support (K6-2/3, Athlon)");
+#endif
+
+#if defined(CONFIG_X86_USE_SSE_PREFETCH)
+	if(!boot_cpu_has(X86_FEATURE_MMXEXT))
+		panic("Kernel requires extended MMX support (Pentium3/4, Athlon)");
+#endif
 }
 
 static void __init check_bugs(void)
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/include/asm-i386/processor.h b/include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	2002-08-02 01:19:14.000000000 +0200
+++ b/include/asm-i386/processor.h	2002-08-03 13:41:03.000000000 +0200
@@ -464,7 +464,7 @@
 #define cpu_relax()	rep_nop()
 
 /* Prefetch instructions for Pentium III and AMD Athlon */
-#ifdef 	CONFIG_MPENTIUMIII
+#ifdef 	CONFIG_X86_USE_SSE_PREFETCH
 
 #define ARCH_HAS_PREFETCH
 extern inline void prefetch(const void *x)
@@ -475,13 +475,16 @@
 #elif CONFIG_X86_USE_3DNOW
 
 #define ARCH_HAS_PREFETCH
-#define ARCH_HAS_PREFETCHW
-#define ARCH_HAS_SPINLOCK_PREFETCH
 
 extern inline void prefetch(const void *x)
 {
 	 __asm__ __volatile__ ("prefetch (%0)" : : "r"(x));
 }
+#endif
+
+#ifdef CONFIG_X86_USE_3DNOW
+#define ARCH_HAS_PREFETCHW
+#define ARCH_HAS_SPINLOCK_PREFETCH
 
 extern inline void prefetchw(const void *x)
 {

--=-ps4UTj0BEWIsGUiPVeE5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9TTnEdjkty3ft5+cRArrOAKDLkwFviyfCRhsbEnKLNQZWlFQ6EQCggOIq
f/87+Cll3WZvPt3BXH88WT8=
=ZojY
-----END PGP SIGNATURE-----

--=-ps4UTj0BEWIsGUiPVeE5--
