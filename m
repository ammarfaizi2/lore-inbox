Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbWFUXQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbWFUXQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 19:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbWFUXQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 19:16:18 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41376 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030458AbWFUXQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 19:16:17 -0400
Date: Wed, 21 Jun 2006 19:15:52 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, gregkh@suse.de, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] 64bit resources start end value fix
Message-ID: <20060621231552.GA25514@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060621172903.GC9423@in.ibm.com> <20060621132227.ec401f93.akpm@osdl.org> <20060621204120.GA14739@in.ibm.com> <20060621135855.ce68720f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621135855.ce68720f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 01:58:55PM -0700, Andrew Morton wrote:
> > 
> > Andrew, you don't have to apply this patch. It is supposed to be picked
> > by Greg.
> > 
> > There seems to be some confusion. Just few days back Greg consolidated
> > and re-organized all the 64bit resources patches and posted on LKML for
> > review.
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=115015916118671&w=2
> > 
> > There were few review comments regarding kconfig options.
> > I reworked the patch and CONFING_RESOURCES_32BIT was changed to
> > CONFIG_RESOURCES_64BIT.
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=115072559700302&w=2
> > 
> > Now Greg's tree and your tree are not exact replica when it comes to 
> > 64bit resource patches. Hence this patch is supposed to be picked by 
> > Greg to make sure things are not broken in his tree.
> 
> I'm working against Greg's tree, always...

I am sorry. That's a mistake on my part. I misunderstood it.

Can you please include the attached patch. Now RESOURCES_32BIT has been
dropped and RESOURCES_64BIT has been introduced based on the review 
feedback.

By default RESOURCES_64BIT is not selected for 32bit platform and user
has got the option to enable it. For 64BIT kernels, RESOURCES_64BIT
is always set.

Thanks
Vivek



o Based on review comments, removed CONFIG_RESOURCE_32BIT and added
  CONFIG_RESOURCE_64BIT in arch independent manner.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/arm/Kconfig         |    7 -------
 arch/arm26/Kconfig       |    7 -------
 arch/cris/Kconfig        |    7 -------
 arch/frv/Kconfig         |    7 -------
 arch/i386/Kconfig        |    8 +-------
 arch/i386/kernel/setup.c |    2 +-
 arch/m32r/Kconfig        |    7 -------
 arch/m68k/Kconfig        |    7 -------
 arch/m68knommu/Kconfig   |    7 -------
 arch/mips/Kconfig        |    8 --------
 arch/parisc/Kconfig      |    8 --------
 arch/powerpc/Kconfig     |    8 --------
 arch/ppc/Kconfig         |    7 -------
 arch/s390/Kconfig        |    8 --------
 arch/sh/Kconfig          |    7 -------
 arch/sparc/Kconfig       |    7 -------
 arch/v850/Kconfig        |    7 -------
 arch/xtensa/Kconfig      |    7 -------
 include/linux/types.h    |    6 +++---
 mm/Kconfig               |    6 ++++++
 20 files changed, 11 insertions(+), 127 deletions(-)

diff -puN mm/Kconfig~64bit-resources-modify-kconfig-options mm/Kconfig
--- linux-2.6.17-mm1/mm/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:07:37.000000000 -0400
+++ linux-2.6.17-mm1-root/mm/Kconfig	2006-06-21 11:09:31.000000000 -0400
@@ -208,3 +208,9 @@ config READAHEAD_SMOOTH_AGING
 	def_bool n if NUMA
 	default y if !NUMA
 	depends on ADAPTIVE_READAHEAD
+
+config RESOURCES_64BIT
+	bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && EXPERIMENTAL)
+	default 64BIT
+	help
+	  This option allows memory and IO resources to be 64 bit.
diff -puN include/linux/types.h~64bit-resources-modify-kconfig-options include/linux/types.h
--- linux-2.6.17-mm1/include/linux/types.h~64bit-resources-modify-kconfig-options	2006-06-21 11:10:21.000000000 -0400
+++ linux-2.6.17-mm1-root/include/linux/types.h	2006-06-21 11:11:33.000000000 -0400
@@ -178,10 +178,10 @@ typedef __u64 __bitwise __be64;
 #ifdef __KERNEL__
 typedef unsigned __bitwise__ gfp_t;
 
-#ifdef CONFIG_RESOURCES_32BIT
-typedef __u32 resource_size_t;
+#ifdef CONFIG_RESOURCES_64BIT
+typedef u64 resource_size_t;
 #else
-typedef __u64 resource_size_t;
+typedef u32 resource_size_t;
 #endif
 
 #endif	/* __KERNEL__ */
diff -puN arch/i386/Kconfig~64bit-resources-modify-kconfig-options arch/i386/Kconfig
--- linux-2.6.17-mm1/arch/i386/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:12:37.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/i386/Kconfig	2006-06-21 11:13:26.000000000 -0400
@@ -528,6 +528,7 @@ config X86_PAE
 	bool
 	depends on HIGHMEM64G
 	default y
+	select RESOURCES_64BIT
 
 # Common NUMA Features
 config NUMA
@@ -774,13 +775,6 @@ config PHYSICAL_START
 
 	  Don't change this unless you know what you are doing.
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && !X86_PAE
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
 	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
diff -puN arch/arm/Kconfig~64bit-resources-modify-kconfig-options arch/arm/Kconfig
--- linux-2.6.17-mm1/arch/arm/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:18:37.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/arm/Kconfig	2006-06-21 11:18:49.000000000 -0400
@@ -531,13 +531,6 @@ config NODES_SHIFT
 
 source "mm/Kconfig"
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 config LEDS
 	bool "Timer and CPU usage LEDs"
 	depends on ARCH_CDB89712 || ARCH_CO285 || ARCH_EBSA110 || \
diff -puN arch/arm26/Kconfig~64bit-resources-modify-kconfig-options arch/arm26/Kconfig
--- linux-2.6.17-mm1/arch/arm26/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:19:03.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/arm26/Kconfig	2006-06-21 11:19:16.000000000 -0400
@@ -187,13 +187,6 @@ config CMDLINE
 
 source "mm/Kconfig"
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 endmenu
 
 source "net/Kconfig"
diff -puN arch/cris/Kconfig~64bit-resources-modify-kconfig-options arch/cris/Kconfig
--- linux-2.6.17-mm1/arch/cris/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:19:32.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/cris/Kconfig	2006-06-21 11:19:44.000000000 -0400
@@ -84,13 +84,6 @@ config PREEMPT
 
 source mm/Kconfig
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 endmenu
 
 menu "Hardware setup"
diff -puN arch/frv/Kconfig~64bit-resources-modify-kconfig-options arch/frv/Kconfig
--- linux-2.6.17-mm1/arch/frv/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:19:55.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/frv/Kconfig	2006-06-21 11:20:05.000000000 -0400
@@ -80,13 +80,6 @@ config HIGHPTE
 
 source "mm/Kconfig"
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 choice
 	prompt "uClinux kernel load address"
 	depends on !MMU
diff -puN arch/m32r/Kconfig~64bit-resources-modify-kconfig-options arch/m32r/Kconfig
--- linux-2.6.17-mm1/arch/m32r/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:20:22.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/m32r/Kconfig	2006-06-21 11:20:55.000000000 -0400
@@ -188,13 +188,6 @@ config ARCH_DISCONTIGMEM_ENABLE
 
 source "mm/Kconfig"
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 config IRAM_START
 	hex "Internal memory start address (hex)"
 	default "00f00000" if !CHIP_M32104
diff -puN arch/m68k/Kconfig~64bit-resources-modify-kconfig-options arch/m68k/Kconfig
--- linux-2.6.17-mm1/arch/m68k/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:21:09.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/m68k/Kconfig	2006-06-21 11:21:23.000000000 -0400
@@ -368,13 +368,6 @@ config 060_WRITETHROUGH
 
 source "mm/Kconfig"
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 endmenu
 
 menu "General setup"
diff -puN arch/m68knommu/Kconfig~64bit-resources-modify-kconfig-options arch/m68knommu/Kconfig
--- linux-2.6.17-mm1/arch/m68knommu/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:21:41.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/m68knommu/Kconfig	2006-06-21 11:21:52.000000000 -0400
@@ -605,13 +605,6 @@ endchoice
 
 source "mm/Kconfig"
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 endmenu
 
 config ISA_DMA_API
diff -puN arch/mips/Kconfig~64bit-resources-modify-kconfig-options arch/mips/Kconfig
--- linux-2.6.17-mm1/arch/mips/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:22:05.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/mips/Kconfig	2006-06-21 11:22:16.000000000 -0400
@@ -1789,14 +1789,6 @@ config HZ
 
 source "kernel/Kconfig.preempt"
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	depends on 32BIT
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 config RTC_DS1742
 	bool "DS1742 BRAM/RTC support"
 	depends on TOSHIBA_JMR3927 || TOSHIBA_RBTX4927
diff -puN arch/parisc/Kconfig~64bit-resources-modify-kconfig-options arch/parisc/Kconfig
--- linux-2.6.17-mm1/arch/parisc/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:22:33.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/parisc/Kconfig	2006-06-21 11:22:43.000000000 -0400
@@ -221,14 +221,6 @@ source "kernel/Kconfig.preempt"
 source "kernel/Kconfig.hz"
 source "mm/Kconfig"
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	depends on !64BIT
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 config COMPAT
 	def_bool y
 	depends on 64BIT
diff -puN arch/powerpc/Kconfig~64bit-resources-modify-kconfig-options arch/powerpc/Kconfig
--- linux-2.6.17-mm1/arch/powerpc/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:22:58.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/powerpc/Kconfig	2006-06-21 11:23:08.000000000 -0400
@@ -634,14 +634,6 @@ config CRASH_DUMP
 
 	  Don't change this unless you know what you are doing.
 
-config RESOURCES_32BIT
-        bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-        depends on EXPERIMENTAL
-	depends on PPC32
-        help
-          By default resources are 64 bit. This option allows memory and IO
-          resources to be 32 bit to optimize code size.
-
 config EMBEDDEDBOOT
 	bool
 	depends on 8xx || 8260
diff -puN arch/ppc/Kconfig~64bit-resources-modify-kconfig-options arch/ppc/Kconfig
--- linux-2.6.17-mm1/arch/ppc/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:23:21.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/ppc/Kconfig	2006-06-21 11:23:44.000000000 -0400
@@ -957,13 +957,6 @@ source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
 source "mm/Kconfig"
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 source "fs/Kconfig.binfmt"
 
 config PREP_RESIDUAL
diff -puN arch/s390/Kconfig~64bit-resources-modify-kconfig-options arch/s390/Kconfig
--- linux-2.6.17-mm1/arch/s390/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:23:57.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/s390/Kconfig	2006-06-21 11:24:10.000000000 -0400
@@ -218,14 +218,6 @@ config WARN_STACK_SIZE
 
 source "mm/Kconfig"
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	depends on !64BIT
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 comment "I/O subsystem configuration"
 
 config MACHCHK_WARNING
diff -puN arch/sh/Kconfig~64bit-resources-modify-kconfig-options arch/sh/Kconfig
--- linux-2.6.17-mm1/arch/sh/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:24:24.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/sh/Kconfig	2006-06-21 11:24:36.000000000 -0400
@@ -532,13 +532,6 @@ config NODES_SHIFT
 	default "1"
 	depends on NEED_MULTIPLE_NODES
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 endmenu
 
 menu "Boot options"
diff -puN arch/sparc/Kconfig~64bit-resources-modify-kconfig-options arch/sparc/Kconfig
--- linux-2.6.17-mm1/arch/sparc/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:24:49.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/sparc/Kconfig	2006-06-21 11:25:01.000000000 -0400
@@ -67,13 +67,6 @@ config SPARC32
 	  maintains both the SPARC32 and SPARC64 ports; its web page is
 	  available at <http://www.ultralinux.org/>.
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 # Global things across all Sun machines.
 config ISA
 	bool
diff -puN arch/v850/Kconfig~64bit-resources-modify-kconfig-options arch/v850/Kconfig
--- linux-2.6.17-mm1/arch/v850/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:25:19.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/v850/Kconfig	2006-06-21 11:25:30.000000000 -0400
@@ -235,13 +235,6 @@ menu "Processor type and features"
 
 source "mm/Kconfig"
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 endmenu
 
 
diff -puN arch/xtensa/Kconfig~64bit-resources-modify-kconfig-options arch/xtensa/Kconfig
--- linux-2.6.17-mm1/arch/xtensa/Kconfig~64bit-resources-modify-kconfig-options	2006-06-21 11:25:40.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/xtensa/Kconfig	2006-06-21 11:25:52.000000000 -0400
@@ -95,13 +95,6 @@ config MATH_EMULATION
 config HIGHMEM
 	bool "High memory support"
 
-config RESOURCES_32BIT
-	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  By default resources are 64 bit. This option allows memory and IO
-	  resources to be 32 bit to optimize code size.
-
 endmenu
 
 menu "Platform options"
diff -puN arch/i386/kernel/setup.c~64bit-resources-modify-kconfig-options arch/i386/kernel/setup.c
--- linux-2.6.17-mm1/arch/i386/kernel/setup.c~64bit-resources-modify-kconfig-options	2006-06-21 11:37:17.000000000 -0400
+++ linux-2.6.17-mm1-root/arch/i386/kernel/setup.c	2006-06-21 11:37:57.000000000 -0400
@@ -1332,7 +1332,7 @@ legacy_init_iomem_resources(struct resou
 	probe_roms();
 	for (i = 0; i < e820.nr_map; i++) {
 		struct resource *res;
-#ifdef CONFIG_RESOURCES_32BIT
+#ifndef CONFIG_RESOURCES_64BIT
 		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
 			continue;
 #endif
_
