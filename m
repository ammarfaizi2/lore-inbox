Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269404AbUJLC1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269404AbUJLC1a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 22:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269405AbUJLC1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 22:27:30 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:37791 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S269404AbUJLC1U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 22:27:20 -0400
Date: Mon, 11 Oct 2004 19:27:20 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: linux-kernel@vger.kernel.org
Subject: [patch] transmeta efficeon support and cpuid update
Message-ID: <Pine.LNX.4.61.0410111916300.16060@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patch adds efficeon as a cpu option, and makes a small update to the 
transmeta cpuid code.  (i wasn't sure if the various doc files are 
UTF-8... if they are, then the e should be a U-275 ;)

the compile options may not be ideal, but they're probably close.  i used 
-march=pentium3, but -march=pentium4 would have been good enough too.

the cpuid update teaches transmeta.c about the extended processor revision 
present in cpuid level 0x80860002... the external documentation does not 
indicate how to break apart this field, and instructs only that the 32-bit 
value should be printed in hex (alas).

Signed-off-by: dean gaudet <dean@arctic.org>

-dean

diff -ru linux-2.6.9-rc4.orig/Documentation/cpu-freq/user-guide.txt linux-2.6.9-rc4/Documentation/cpu-freq/user-guide.txt
--- linux-2.6.9-rc4.orig/Documentation/cpu-freq/user-guide.txt	2004-10-10 19:57:03.000000000 -0700
+++ linux-2.6.9-rc4/Documentation/cpu-freq/user-guide.txt	2004-10-11 18:52:12.000000000 -0700
@@ -65,6 +65,7 @@
  Intel Pentium M (Centrino)
  National Semiconductors Geode GX
  Transmeta Crusoe
+Transmeta Efficeon
  VIA Cyrix 3 / C3
  various processors on some ACPI 2.0-compatible systems [*]

diff -ru linux-2.6.9-rc4.orig/arch/i386/Kconfig linux-2.6.9-rc4/arch/i386/Kconfig
--- linux-2.6.9-rc4.orig/arch/i386/Kconfig	2004-10-10 19:57:06.000000000 -0700
+++ linux-2.6.9-rc4/arch/i386/Kconfig	2004-10-11 18:53:14.000000000 -0700
@@ -179,6 +179,7 @@
  	  - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
  	  - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
  	  - "Crusoe" for the Transmeta Crusoe series.
+	  - "Efficeon" for the Transmeta Efficeon series.
  	  - "Winchip-C6" for original IDT Winchip.
  	  - "Winchip-2" for IDT Winchip 2.
  	  - "Winchip-2A" for IDT Winchips with 3dNow! capabilities.
@@ -281,6 +282,11 @@
  	  like a 586 with TSC, and sets some GCC optimization flags (like a
  	  Pentium Pro with no alignment requirements).

+config MEFFICEON
+	bool "Efficeon"
+	help
+	  Select this for a Transmeta Efficeon processor.
+
  config MWINCHIPC6
  	bool "Winchip-C6"
  	help
@@ -354,7 +360,7 @@
  	int
  	default "7" if MPENTIUM4 || X86_GENERIC
  	default "4" if X86_ELAN || M486 || M386
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
+	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
  	default "6" if MK7 || MK8 || MPENTIUMM

  config RWSEM_GENERIC_SPINLOCK
@@ -404,17 +410,17 @@

  config X86_GOOD_APIC
  	bool
-	depends on MK7 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8
+	depends on MK7 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8 || MEFFICEON
  	default y

  config X86_INTEL_USERCOPY
  	bool
-	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7
+	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7 || MEFFICEON
  	default y

  config X86_USE_PPRO_CHECKSUM
  	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MEFFICEON
  	default y

  config X86_USE_3DNOW
@@ -549,7 +555,7 @@

  config X86_TSC
  	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
+	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
  	default y

  config X86_MCE
diff -ru linux-2.6.9-rc4.orig/arch/i386/Makefile linux-2.6.9-rc4/arch/i386/Makefile
--- linux-2.6.9-rc4.orig/arch/i386/Makefile	2004-10-10 19:57:30.000000000 -0700
+++ linux-2.6.9-rc4/arch/i386/Makefile	2004-10-11 18:51:15.000000000 -0700
@@ -42,6 +42,7 @@
  cflags-$(CONFIG_MK7)		+= $(call cc-option,-march=athlon,-march=i686 $(align)-functions=4)
  cflags-$(CONFIG_MK8)		+= $(call cc-option,-march=k8,$(call cc-option,-march=athlon,-march=i686 $(align)-functions=4))
  cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
+cflags-$(CONFIG_MEFFICEON)	+= $(call cc-option,-march=pentium3,-march=i686) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
  cflags-$(CONFIG_MWINCHIPC6)	+= $(call cc-option,-march=winchip-c6,-march=i586)
  cflags-$(CONFIG_MWINCHIP2)	+= $(call cc-option,-march=winchip2,-march=i586)
  cflags-$(CONFIG_MWINCHIP3D)	+= $(call cc-option,-march=winchip2,-march=i586)
diff -ru linux-2.6.9-rc4.orig/arch/i386/defconfig linux-2.6.9-rc4/arch/i386/defconfig
--- linux-2.6.9-rc4.orig/arch/i386/defconfig	2004-10-10 19:58:07.000000000 -0700
+++ linux-2.6.9-rc4/arch/i386/defconfig	2004-10-11 18:51:24.000000000 -0700
@@ -71,6 +71,7 @@
  # CONFIG_MK7 is not set
  # CONFIG_MK8 is not set
  # CONFIG_MCRUSOE is not set
+# CONFIG_MEFFICEON is not set
  # CONFIG_MWINCHIPC6 is not set
  # CONFIG_MWINCHIP2 is not set
  # CONFIG_MWINCHIP3D is not set
diff -ru linux-2.6.9-rc4.orig/arch/i386/kernel/cpu/cpufreq/Kconfig linux-2.6.9-rc4/arch/i386/kernel/cpu/cpufreq/Kconfig
--- linux-2.6.9-rc4.orig/arch/i386/kernel/cpu/cpufreq/Kconfig	2004-10-10 19:57:07.000000000 -0700
+++ linux-2.6.9-rc4/arch/i386/kernel/cpu/cpufreq/Kconfig	2004-10-11 18:44:12.000000000 -0700
@@ -200,8 +200,8 @@
  	tristate "Transmeta LongRun"
  	depends on CPU_FREQ
  	help
-	  This adds the CPUFreq driver for Transmeta Crusoe processors which
-	  support LongRun.
+	  This adds the CPUFreq driver for Transmeta Crusoe and Efficeon processors
+	  which support LongRun.

  	  For details, take a look at <file:Documentation/cpu-freq/>.

diff -ru linux-2.6.9-rc4.orig/arch/i386/kernel/cpu/cpufreq/longrun.c linux-2.6.9-rc4/arch/i386/kernel/cpu/cpufreq/longrun.c
--- linux-2.6.9-rc4.orig/arch/i386/kernel/cpu/cpufreq/longrun.c	2004-10-10 19:58:23.000000000 -0700
+++ linux-2.6.9-rc4/arch/i386/kernel/cpu/cpufreq/longrun.c	2004-10-11 18:44:36.000000000 -0700
@@ -308,7 +308,7 @@


  MODULE_AUTHOR ("Dominik Brodowski <linux@brodo.de>");
-MODULE_DESCRIPTION ("LongRun driver for Transmeta Crusoe processors.");
+MODULE_DESCRIPTION ("LongRun driver for Transmeta Crusoe and Efficeon processors.");
  MODULE_LICENSE ("GPL");

  module_init(longrun_init);
diff -ru linux-2.6.9-rc4.orig/arch/i386/kernel/cpu/transmeta.c linux-2.6.9-rc4/arch/i386/kernel/cpu/transmeta.c
--- linux-2.6.9-rc4.orig/arch/i386/kernel/cpu/transmeta.c	2004-10-10 19:59:11.000000000 -0700
+++ linux-2.6.9-rc4/arch/i386/kernel/cpu/transmeta.c	2004-10-11 18:42:03.000000000 -0700
@@ -8,7 +8,7 @@
  {
  	unsigned int cap_mask, uk, max, dummy;
  	unsigned int cms_rev1, cms_rev2;
-	unsigned int cpu_rev, cpu_freq, cpu_flags;
+	unsigned int cpu_rev, cpu_freq, cpu_flags, new_cpu_rev;
  	char cpu_info[65];

  	get_model_name(c);	/* Same as AMD/Cyrix */
@@ -16,17 +16,24 @@

  	/* Print CMS and CPU revision */
  	max = cpuid_eax(0x80860000);
+	cpu_rev = 0;
  	if ( max >= 0x80860001 ) {
  		cpuid(0x80860001, &dummy, &cpu_rev, &cpu_freq, &cpu_flags); 
-		printk(KERN_INFO "CPU: Processor revision %u.%u.%u.%u, %u MHz\n",
-		       (cpu_rev >> 24) & 0xff,
-		       (cpu_rev >> 16) & 0xff,
-		       (cpu_rev >> 8) & 0xff,
-		       cpu_rev & 0xff,
-		       cpu_freq);
+		if (cpu_rev != 0x02000000) {
+			printk(KERN_INFO "CPU: Processor revision %u.%u.%u.%u, %u MHz\n",
+				(cpu_rev >> 24) & 0xff,
+				(cpu_rev >> 16) & 0xff,
+				(cpu_rev >> 8) & 0xff,
+				cpu_rev & 0xff,
+				cpu_freq);
+		}
  	}
  	if ( max >= 0x80860002 ) {
-		cpuid(0x80860002, &dummy, &cms_rev1, &cms_rev2, &dummy);
+		cpuid(0x80860002, &new_cpu_rev, &cms_rev1, &cms_rev2, &dummy);
+		if (cpu_rev == 0x02000000) {
+			printk(KERN_INFO "CPU: Processor revision %08X, %u MHz\n",
+				new_cpu_rev, cpu_freq);
+		}
  		printk(KERN_INFO "CPU: Code Morphing Software revision %u.%u.%u-%u-%u\n",
  		       (cms_rev1 >> 24) & 0xff,
  		       (cms_rev1 >> 16) & 0xff,
diff -ru linux-2.6.9-rc4.orig/include/asm-i386/module.h linux-2.6.9-rc4/include/asm-i386/module.h
--- linux-2.6.9-rc4.orig/include/asm-i386/module.h	2004-10-10 19:57:04.000000000 -0700
+++ linux-2.6.9-rc4/include/asm-i386/module.h	2004-10-11 18:52:02.000000000 -0700
@@ -40,6 +40,8 @@
  #define MODULE_PROC_FAMILY "ELAN "
  #elif defined CONFIG_MCRUSOE
  #define MODULE_PROC_FAMILY "CRUSOE "
+#elif defined CONFIG_MEFFICEON
+#define MODULE_PROC_FAMILY "EFFICEON "
  #elif defined CONFIG_MWINCHIPC6
  #define MODULE_PROC_FAMILY "WINCHIPC6 "
  #elif defined CONFIG_MWINCHIP2
