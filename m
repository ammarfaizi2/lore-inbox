Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbUAYVzW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 16:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUAYVym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 16:54:42 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49903 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265292AbUAYVxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 16:53:18 -0500
Date: Sun, 25 Jan 2004 22:53:10 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2/3] AMD Elan patch: rediffed
Message-ID: <20040125215310.GR513@fs.tum.de>
References: <20040125214530.GN513@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125214530.GN513@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Adrian Bunk <bunk@fs.tum.de>

- AMD Elan is a different subarch, you can't configure a kernel that runs
  on both the AMD Elan and other i386 CPUs

- added optimizing CFLAGS for the AMD Elan


diffstat output:

 arch/i386/Kconfig                    |   20 +++++++++++++++-----
 arch/i386/Makefile                   |    3 +++
 arch/i386/boot/setup.S               |    2 +-
 arch/i386/kernel/cpu/cpufreq/Kconfig |    2 +-
 include/asm-i386/module.h            |    2 +-
 include/asm-i386/timex.h             |    2 +-
 6 files changed, 22 insertions(+), 9 deletions(-)




diff -puN arch/i386/boot/setup.S~amd-elan-is-a-different-subarch arch/i386/boot/setup.S
--- 25/arch/i386/boot/setup.S~amd-elan-is-a-different-subarch	Mon Jan 12 15:53:12 2004
+++ 25-akpm/arch/i386/boot/setup.S	Mon Jan 12 15:53:12 2004
@@ -755,7 +755,7 @@ end_move_self:					# now we are at the r
 # AMD Elan bug fix by Robert Schwebel.
 #
 
-#if defined(CONFIG_MELAN)
+#if defined(CONFIG_X86_ELAN)
 	movb $0x02, %al			# alternate A20 gate
 	outb %al, $0x92			# this works on SC410/SC520
 a20_elan_wait:
diff -puN arch/i386/kernel/cpu/cpufreq/Kconfig~amd-elan-is-a-different-subarch arch/i386/kernel/cpu/cpufreq/Kconfig
--- 25/arch/i386/kernel/cpu/cpufreq/Kconfig~amd-elan-is-a-different-subarch	Mon Jan 12 15:53:12 2004
+++ 25-akpm/arch/i386/kernel/cpu/cpufreq/Kconfig	Mon Jan 12 15:53:12 2004
@@ -54,7 +54,7 @@ config X86_ACPI_CPUFREQ_PROC_INTF
 
 config ELAN_CPUFREQ
 	tristate "AMD Elan"
-	depends on CPU_FREQ_TABLE && MELAN
+	depends on CPU_FREQ_TABLE && X86_ELAN
 	---help---
 	  This adds the CPUFreq driver for AMD Elan SC400 and SC410
 	  processors.
diff -puN arch/i386/Makefile~amd-elan-is-a-different-subarch arch/i386/Makefile
--- 25/arch/i386/Makefile~amd-elan-is-a-different-subarch	Mon Jan 12 15:53:12 2004
+++ 25-akpm/arch/i386/Makefile	Mon Jan 12 15:53:12 2004
@@ -48,6 +48,9 @@ cflags-$(CONFIG_MWINCHIP3D)	+= $(call ch
 cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i486) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MVIAC3_2)	+= $(call check_gcc,-march=c3-2,-march=i686)
 
+# AMD Elan support
+cflags-$(CONFIG_X86_ELAN)	+= -march=i486
+
 CFLAGS += $(cflags-y)
 
 # Default subarch .c files
diff -puN include/asm-i386/timex.h~amd-elan-is-a-different-subarch include/asm-i386/timex.h
--- 25/include/asm-i386/timex.h~amd-elan-is-a-different-subarch	Mon Jan 12 15:53:12 2004
+++ 25-akpm/include/asm-i386/timex.h	Mon Jan 12 15:53:12 2004
@@ -12,7 +12,7 @@
 #ifdef CONFIG_X86_PC9800
    extern int CLOCK_TICK_RATE;
 #else
-#ifdef CONFIG_MELAN
+#ifdef CONFIG_X86_ELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
 #else
 #  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */

_
--- linux-2.6.2-rc1-mm3/arch/i386/Kconfig.old	2004-01-25 18:08:34.000000000 +0100
+++ linux-2.6.2-rc1-mm3/arch/i386/Kconfig	2004-01-25 18:09:23.000000000 +0100
@@ -43,6 +43,15 @@
 	help
 	  Choose this option if your computer is a standard PC or compatible.
 
+config X86_ELAN
+	bool "AMD Elan"
+	help
+	  Select this for an AMD Elan processor.
+
+	  Do not use this option for K6/Athlon/Opteron processors!
+
+	  If unsure, choose "PC-compatible" instead.
+
 config X86_VOYAGER
 	bool "Voyager (NCR)"
 	help
@@ -130,6 +139,8 @@
 	default y
 	depends on SMP && X86_ES7000 && MPENTIUMIII
 
+if !X86_ELAN
+
 choice
 	prompt "Processor family"
 	default M686
@@ -258,9 +269,6 @@
 	  use of some extended instructions, and passes appropriate optimization
 	  flags to GCC.
 
-config MELAN
-	bool "Elan"
-
 config MCRUSOE
 	bool "Crusoe"
 	help
@@ -318,6 +326,8 @@
 	  when it has moderate overhead. This is intended for generic 
 	  distributions kernels.
 
+endif
+
 #
 # Define implied options from the CPU selection here
 #
@@ -334,7 +344,7 @@
 config X86_L1_CACHE_SHIFT
 	int
 	default "7" if MPENTIUM4 || X86_GENERIC
-	default "4" if MELAN || M486 || M386
+	default "4" if X86_ELAN || M486 || M386
 	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
 	default "6" if MK7 || MK8 || MPENTIUMM
 
@@ -380,7 +390,7 @@
 
 config X86_ALIGNMENT_16
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || X86_ELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2
 	default y
 
 config X86_GOOD_APIC
--- linux-2.6.2-rc1-mm3/include/asm-i386/module.h.old	2004-01-25 18:11:14.000000000 +0100
+++ linux-2.6.2-rc1-mm3/include/asm-i386/module.h	2004-01-25 18:11:27.000000000 +0100
@@ -36,7 +36,7 @@
 #define MODULE_PROC_FAMILY "K7 "
 #elif defined CONFIG_MK8
 #define MODULE_PROC_FAMILY "K8 "
-#elif defined CONFIG_MELAN
+#elif defined CONFIG_X86_ELAN
 #define MODULE_PROC_FAMILY "ELAN "
 #elif defined CONFIG_MCRUSOE
 #define MODULE_PROC_FAMILY "CRUSOE "
