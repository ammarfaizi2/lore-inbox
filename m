Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUALXiB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUALXiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:38:01 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42196 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263185AbUALXhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:37:51 -0500
Date: Tue, 13 Jan 2004 00:37:43 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, robert@schwebel.de
Cc: linux-kernel@vger.kernel.org
Subject: [3/3] AMD Elan is a different subarch
Message-ID: <20040112233743.GS9677@fs.tum.de>
References: <20040112230839.GP9677@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040112230839.GP9677@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- AMD Elan is a different subarch, you can't configure a kernel that
  runs on both the AMD Elan and other i386 CPUs
- added optimizing CFLAGS for the AMD Elan


diffstat output:

 arch/i386/Kconfig                    |   17 +++++++++++++++--
 arch/i386/Makefile                   |    3 +++
 arch/i386/boot/setup.S               |    2 +-
 arch/i386/kernel/cpu/cpufreq/Kconfig |    2 +-
 include/asm-i386/timex.h             |    2 +-
 5 files changed, 21 insertions(+), 5 deletions(-)



--- linux-2.6.0-test5-mm4/arch/i386/boot/setup.S.old	2003-09-25 14:28:07.000000000 +0200
+++ linux-2.6.0-test5-mm4/arch/i386/boot/setup.S	2003-09-25 14:28:16.000000000 +0200
@@ -755,7 +755,7 @@
 # AMD Elan bug fix by Robert Schwebel.
 #
 
-#if defined(CONFIG_MELAN)
+#if defined(CONFIG_X86_ELAN)
 	movb $0x02, %al			# alternate A20 gate
 	outb %al, $0x92			# this works on SC410/SC520
 a20_elan_wait:
--- linux-2.6.0-test5-mm4/include/asm-i386/timex.h.old	2003-09-25 14:28:07.000000000 +0200
+++ linux-2.6.0-test5-mm4/include/asm-i386/timex.h	2003-09-25 14:28:16.000000000 +0200
@@ -12,7 +12,7 @@
 #ifdef CONFIG_X86_PC9800
    extern int CLOCK_TICK_RATE;
 #else
-#ifdef CONFIG_MELAN
+#ifdef CONFIG_X86_ELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
 #else
 #  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
--- linux-2.6.1-rc1/arch/i386/kernel/cpu/cpufreq/Kconfig.old	2004-01-08 04:04:37.000000000 +0100
+++ linux-2.6.1-rc1/arch/i386/kernel/cpu/cpufreq/Kconfig	2004-01-08 04:05:26.000000000 +0100
@@ -54,7 +54,7 @@
 
 config ELAN_CPUFREQ
 	tristate "AMD Elan"
-	depends on CPU_FREQ_TABLE && MELAN
+	depends on CPU_FREQ_TABLE && X86_ELAN
 	---help---
 	  This adds the CPUFreq driver for AMD Elan SC400 and SC410
 	  processors.
--- linux-2.6.1-mm2/arch/i386/Kconfig.old	2004-01-12 23:55:45.000000000 +0100
+++ linux-2.6.1-mm2/arch/i386/Kconfig	2004-01-12 23:57:45.000000000 +0100
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
@@ -319,6 +330,8 @@
 	  when it has moderate overhead. This is intended for generic 
 	  distributions kernels.
 
+endif
+
 #
 # Define implied options from the CPU selection here
 #
@@ -335,7 +348,7 @@
 config X86_L1_CACHE_SHIFT
 	int
 	default "7" if MPENTIUM4 || X86_GENERIC
-	default "4" if MELAN || M486 || M386
+	default "4" if X86_ELAN || M486 || M386
 	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
 	default "6" if MK7 || MK8
 
@@ -381,7 +394,7 @@
 
 config X86_ALIGNMENT_16
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || X86_ELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2
 	default y
 
 config X86_GOOD_APIC
--- linux-2.6.1-mm2/arch/i386/Makefile.old	2004-01-13 00:33:12.000000000 +0100
+++ linux-2.6.1-mm2/arch/i386/Makefile	2004-01-13 00:34:48.000000000 +0100
@@ -48,6 +48,9 @@
 cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i486) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MVIAC3_2)	+= $(call check_gcc,-march=c3-2,-march=i686)
 
+# AMD Elan support
+cflags-$(CONFIG_X86_ELAN)	+= -march=i486
+
 CFLAGS += $(cflags-y)
 
 # Default subarch .c files
