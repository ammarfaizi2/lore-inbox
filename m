Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbVCPXXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVCPXXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVCPXVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:21:39 -0500
Received: from fire.osdl.org ([65.172.181.4]:5358 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262856AbVCPXG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:06:29 -0500
Date: Wed, 16 Mar 2005 15:06:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4
Message-Id: <20050316150612.2359a488.akpm@osdl.org>
In-Reply-To: <6u8y4n434b.fsf@zork.zork.net>
References: <20050316040654.62881834.akpm@osdl.org>
	<6u8y4n434b.fsf@zork.zork.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> wrote:
>
>  Fails to build here:
> 
>    arch/ppc/platforms/built-in.o(.pmac.text+0x6828): In function `flush_disable_caches':
>    : undefined reference to `cpufreq_frequency_table_verify'
>    arch/ppc/platforms/built-in.o(.pmac.text+0x6868): In function `flush_disable_caches':
>    : undefined reference to `cpufreq_frequency_table_target'
>    arch/ppc/platforms/built-in.o(.pmac.text+0x68f0): In function `flush_disable_caches':
>    : undefined reference to `cpufreq_frequency_table_cpuinfo'
>    make: *** [.tmp_vmlinux1] Error 1
> 
> 
>  This patch makes it work again; there are duplicate CPU_FREQ_TABLE
>  definitions in some arch Kconfigs.  Possibly not the Right Thing(tm).
> 
>  [briny(~/build/linux/S11-mm4)] find arch/ -name Kconfig | xargs grep '^config CPU_FREQ_TABLE'
>  arch/sparc64/Kconfig:config CPU_FREQ_TABLE
>  arch/sh/Kconfig:config CPU_FREQ_TABLE
>  arch/ppc/Kconfig:config CPU_FREQ_TABLE
>  arch/x86_64/kernel/cpufreq/Kconfig:config CPU_FREQ_TABLE

Yes, the pmac cpufreq Kconfig dependencies are being troublesome.

Roman sent this to Ben and I overnight:


From: Roman Zippel <zippel@linux-m68k.org>

This completes the Kconfig cleanup for all other archs.  CPU_FREQ_TABLE was
moved to drivers/cpufreq/Kconfig and is selected as needed.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/Kconfig                   |    6 +-----
 25-akpm/arch/sh/Kconfig                    |   11 +----------
 25-akpm/arch/sparc64/Kconfig               |   16 ++++------------
 25-akpm/arch/x86_64/kernel/cpufreq/Kconfig |   28 ++++++++++------------------
 4 files changed, 16 insertions(+), 45 deletions(-)

diff -puN arch/ppc/Kconfig~complete-cpufreq-kconfig-cleanup arch/ppc/Kconfig
--- 25/arch/ppc/Kconfig~complete-cpufreq-kconfig-cleanup	2005-03-16 15:05:33.000000000 -0800
+++ 25-akpm/arch/ppc/Kconfig	2005-03-16 15:05:33.000000000 -0800
@@ -203,16 +203,12 @@ source "drivers/cpufreq/Kconfig"
 config CPU_FREQ_PMAC
 	bool "Support for Apple PowerBooks"
 	depends on CPU_FREQ && ADB_PMU
+	select CPU_FREQ_TABLE
 	help
 	  This adds support for frequency switching on Apple PowerBooks,
 	  this currently includes some models of iBook & Titanium
 	  PowerBook.
 
-config CPU_FREQ_TABLE
-	tristate
-	depends on CPU_FREQ_PMAC
-	default y
-
 config PPC601_SYNC_FIX
 	bool "Workarounds for PPC601 bugs"
 	depends on 6xx && (PPC_PREP || PPC_PMAC)
diff -puN arch/sh/Kconfig~complete-cpufreq-kconfig-cleanup arch/sh/Kconfig
--- 25/arch/sh/Kconfig~complete-cpufreq-kconfig-cleanup	2005-03-16 15:05:33.000000000 -0800
+++ 25-akpm/arch/sh/Kconfig	2005-03-16 15:05:33.000000000 -0800
@@ -659,19 +659,10 @@ menu "CPU Frequency scaling"
 
 source "drivers/cpufreq/Kconfig"
 
-config CPU_FREQ_TABLE
-	tristate "CPU frequency table helpers"
-	depends on CPU_FREQ
-	default y
-	help
-	  Many cpufreq drivers use these helpers, so only say N here if
-	  the cpufreq driver of your choice doesn't need these helpers.
-
-	  If unsure, say Y.
-
 config SH_CPU_FREQ
 	tristate "SuperH CPU Frequency driver"
 	depends on CPU_FREQ
+	select CPU_FREQ_TABLE
 	help
 	  This adds the cpufreq driver for SuperH. At present, only
 	  the SH-4 is supported.
diff -puN arch/sparc64/Kconfig~complete-cpufreq-kconfig-cleanup arch/sparc64/Kconfig
--- 25/arch/sparc64/Kconfig~complete-cpufreq-kconfig-cleanup	2005-03-16 15:05:33.000000000 -0800
+++ 25-akpm/arch/sparc64/Kconfig	2005-03-16 15:05:33.000000000 -0800
@@ -136,19 +136,10 @@ config NR_CPUS
 
 source "drivers/cpufreq/Kconfig"
 
-config CPU_FREQ_TABLE
-       tristate "CPU frequency table helpers"
-       depends on CPU_FREQ
-       default y
-       help
-         Many CPUFreq drivers use these helpers, so only say N here if
-	 the CPUFreq driver of your choice doesn't need these helpers.
-
-	 If in doubt, say Y.
-
 config US3_FREQ
 	tristate "UltraSPARC-III CPU Frequency driver"
-	depends on CPU_FREQ_TABLE
+	depends on CPU_FREQ
+	select CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for UltraSPARC-III processors.
 
@@ -158,7 +149,8 @@ config US3_FREQ
 
 config US2E_FREQ
 	tristate "UltraSPARC-IIe CPU Frequency driver"
-	depends on CPU_FREQ_TABLE
+	depends on CPU_FREQ
+	select CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for UltraSPARC-IIe processors.
 
diff -puN arch/x86_64/kernel/cpufreq/Kconfig~complete-cpufreq-kconfig-cleanup arch/x86_64/kernel/cpufreq/Kconfig
--- 25/arch/x86_64/kernel/cpufreq/Kconfig~complete-cpufreq-kconfig-cleanup	2005-03-16 15:05:33.000000000 -0800
+++ 25-akpm/arch/x86_64/kernel/cpufreq/Kconfig	2005-03-16 15:05:33.000000000 -0800
@@ -6,22 +6,13 @@ menu "CPU Frequency scaling"
 
 source "drivers/cpufreq/Kconfig"
 
-config CPU_FREQ_TABLE
-       tristate "CPU frequency table helpers"
-       depends on CPU_FREQ
-       default y
-       help
-         Many CPUFreq drivers use these helpers, so only say N here if
-	 the CPUFreq driver of your choice doesn't need these helpers.
-
-	 If in doubt, say Y.
+if CPU_FREQ
 
 comment "CPUFreq processor drivers"
-       depends on CPU_FREQ
 
 config X86_POWERNOW_K8
 	tristate "AMD Opteron/Athlon64 PowerNow!"
-	depends on CPU_FREQ_TABLE
+	select CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for mobile AMD Opteron/Athlon64 processors.
 
@@ -31,12 +22,14 @@ config X86_POWERNOW_K8
 
 config X86_POWERNOW_K8_ACPI
 	bool
-	depends on ((X86_POWERNOW_K8 = "m" && ACPI_PROCESSOR) || (X86_POWERNOW_K8 = "y" && ACPI_PROCESSOR = "y"))
+	depends on X86_POWERNOW_K8 && ACPI_PROCESSOR
+	depends on !(X86_POWERNOW_K8 = y && ACPI_PROCESSOR = m)
 	default y
 
 config X86_SPEEDSTEP_CENTRINO
 	tristate "Intel Enhanced SpeedStep"
-	depends on CPU_FREQ_TABLE && ACPI_PROCESSOR
+	select CPU_FREQ_TABLE
+	depends on ACPI_PROCESSOR
 	help
 	  This adds the CPUFreq driver for Enhanced SpeedStep enabled
 	  mobile CPUs.  This means Intel Pentium M (Centrino) CPUs
@@ -53,7 +46,7 @@ config X86_SPEEDSTEP_CENTRINO_ACPI
 
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
-	depends on CPU_FREQ_TABLE && ACPI_PROCESSOR
+	depends on ACPI_PROCESSOR
 	help
 	  This driver adds a CPUFreq driver which utilizes the ACPI
 	  Processor Performance States.
@@ -63,7 +56,6 @@ config X86_ACPI_CPUFREQ
 	  If in doubt, say N.
 
 comment "shared options"
-	depends on CPU_FREQ
 
 config X86_ACPI_CPUFREQ_PROC_INTF
         bool "/proc/acpi/processor/../performance interface (deprecated)"
@@ -78,7 +70,7 @@ config X86_ACPI_CPUFREQ_PROC_INTF
 
 config X86_P4_CLOCKMOD
 	tristate "Intel Pentium 4 clock modulation"
-	depends on CPU_FREQ_TABLE && EMBEDDED
+	depends on EMBEDDED
 	help
 	  This adds the clock modulation driver for Intel Pentium 4 / XEON
 	  processors.  When enabled it will lower CPU temperature by skipping
@@ -96,9 +88,9 @@ config X86_P4_CLOCKMOD
 
 config X86_SPEEDSTEP_LIB
         tristate
-        depends on (X86_P4_CLOCKMOD)
-        default (X86_P4_CLOCKMOD)
+        default X86_P4_CLOCKMOD
 
+endif
 
 endmenu
 
_

