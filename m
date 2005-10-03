Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbVJCRaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbVJCRaq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVJCRaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:30:46 -0400
Received: from amdext3.amd.com ([139.95.251.6]:48344 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S932474AbVJCRap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:30:45 -0400
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Date: Mon, 3 Oct 2005 11:47:38 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] AMD Geode GX/LX support
Message-ID: <20051003174738.GC29264@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F5FB533354696374-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the GX processor including processor
identification, and enabling / disabling the appropriate configuration
options.  Please apply against linux-2.4.14-rc2-mm2.

Signed off by:  Jordan Crouse (jordan.crouse@amd.com)

Index: linux-2.6.14-rc2-mm2/MAINTAINERS
===================================================================
--- linux-2.6.14-rc2-mm2.orig/MAINTAINERS
+++ linux-2.6.14-rc2-mm2/MAINTAINERS
@@ -259,6 +259,13 @@ P:	Ivan Kokshaysky
 M:	ink@jurassic.park.msu.ru
 S:	Maintained for 2.4; PCI support for 2.6.
 
+AMD GEODE PROCESSOR/CHIPSET SUPPORT
+P:
+M:
+L:	info-linux@geode.amd.com
+W:	http://www.amd.com/us-en/ConnectivitySolutions/TechnicalResources/0,,50_2334_2452_11363,00.html
+S:	Supported
+
 APM DRIVER
 P:	Stephen Rothwell
 M:	sfr@canb.auug.org.au
Index: linux-2.6.14-rc2-mm2/arch/i386/Kconfig
===================================================================
--- linux-2.6.14-rc2-mm2.orig/arch/i386/Kconfig
+++ linux-2.6.14-rc2-mm2/arch/i386/Kconfig
@@ -189,6 +189,7 @@ config M386
 	  - "Pentium-4" for the Intel Pentium 4 or P4-based Celeron.
 	  - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
 	  - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
+	  - "Geode GX" for AMD Geode GX processors
 	  - "Crusoe" for the Transmeta Crusoe series.
 	  - "Efficeon" for the Transmeta Efficeon series.
 	  - "Winchip-C6" for original IDT Winchip.
@@ -287,6 +288,12 @@ config MK8
 	  use of some extended instructions, and passes appropriate optimization
 	  flags to GCC.
 
+config MGEODE_GX
+	bool "Geode GX"
+	help
+	  Select this for AMD Geode GX processors.  Enables use of some extended
+	  instructions, and passes appropriate optimization flags to GCC.
+
 config MCRUSOE
 	bool "Crusoe"
 	help
@@ -377,7 +384,7 @@ config X86_L1_CACHE_SHIFT
 	int
 	default "7" if MPENTIUM4 || X86_GENERIC
 	default "4" if X86_ELAN || M486 || M386
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODEGX1
+	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODEGX1 || MGEODE_GX
 	default "6" if MK7 || MK8 || MPENTIUMM
 
 config RWSEM_GENERIC_SPINLOCK
@@ -446,12 +453,12 @@ config X86_INTEL_USERCOPY
 
 config X86_USE_PPRO_CHECKSUM
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MEFFICEON
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MEFFICEON || MGEODE_GX
 	default y
 
 config X86_USE_3DNOW
 	bool
-	depends on MCYRIXIII || MK7
+	depends on MCYRIXIII || MK7 || MGEODE_GX
 	default y
 
 config X86_OOSTORE
@@ -532,7 +539,7 @@ source "kernel/Kconfig.preempt"
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors"
-	depends on !SMP && !(X86_VISWS || X86_VOYAGER)
+	depends on !SMP && !(X86_VISWS || X86_VOYAGER || MGEODE_GX)
 	help
 	  A local APIC (Advanced Programmable Interrupt Controller) is an
 	  integrated interrupt controller in the CPU. If you have a single-CPU
@@ -749,6 +756,7 @@ config HIGHMEM4G
 
 config HIGHMEM64G
 	bool "64GB"
+	depends on !MGEODE_GX
 	help
 	  Select this if you have a 32-bit processor and more than 4
 	  gigabytes of physical RAM.
Index: linux-2.6.14-rc2-mm2/arch/i386/kernel/cpu/cyrix.c
===================================================================
--- linux-2.6.14-rc2-mm2.orig/arch/i386/kernel/cpu/cyrix.c
+++ linux-2.6.14-rc2-mm2/arch/i386/kernel/cpu/cyrix.c
@@ -342,6 +342,50 @@ static void __init init_cyrix(struct cpu
 	return;
 }
 
+
+static void __init init_nsc(struct cpuinfo_x86 *c)
+{
+
+
+	/* Handle the National Semiconductor models with non-Cyrix init */
+	if ( (c->x86 == 5) && (c->x86_model >= 4 && c->x86_model <= 5)) {
+		/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
+		   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
+		clear_bit(0*32+31, c->x86_capability);
+
+		get_model_name(c);
+
+		switch ( c->x86_model ) {
+                case 4: /* GX1/SCxx00 */
+
+			/* TODO Finish up the GX1/SCxx00 detection */
+                        /* GX1 uses bits 16 and 24 differently -
+                           you could probably just do
+
+                           clear_bit(0*32+16, &c->x86_capability);
+                           clear_bit(0*32+24, &c->x86_capability);
+
+                           since I don't think the kernel supports
+                           FPU-CMOV or Cyrix MMX.  Unsure tho.
+
+                           Also checking GX1 cache here needs to be done -
+                           display_cacheinfo() won't work according to
+                           AMD specs.
+                        */
+
+                        break;
+
+                case 5: /* GX */
+                        display_cacheinfo(c);
+                        break;
+		}
+	} else {
+		/* invoke the 'base class' */
+		init_cyrix(c);
+	}
+}
+
+
 /*
  * Cyrix CPUs without cpuid or with cpuid not yet enabled can be detected
  * by the fact that they preserve the flags across the division of 5/2.
@@ -422,7 +466,7 @@ int __init cyrix_init_cpu(void)
 static struct cpu_dev nsc_cpu_dev __initdata = {
 	.c_vendor	= "NSC",
 	.c_ident 	= { "Geode by NSC" },
-	.c_init		= init_cyrix,
+	.c_init		= init_nsc,
 	.c_identify	= generic_identify,
 };
 
Index: linux-2.6.14-rc2-mm2/include/asm-i386/module.h
===================================================================
--- linux-2.6.14-rc2-mm2.orig/include/asm-i386/module.h
+++ linux-2.6.14-rc2-mm2/include/asm-i386/module.h
@@ -36,6 +36,8 @@ struct mod_arch_specific
 #define MODULE_PROC_FAMILY "K7 "
 #elif defined CONFIG_MK8
 #define MODULE_PROC_FAMILY "K8 "
+#elif defined CONFIG_MGEODE_GX
+#define MODULE_PROC_FAMILY "GEODE_GX "
 #elif defined CONFIG_X86_ELAN
 #define MODULE_PROC_FAMILY "ELAN "
 #elif defined CONFIG_MCRUSOE
Index: linux-2.6.14-rc2-mm2/include/linux/pci_ids.h
===================================================================
--- linux-2.6.14-rc2-mm2.orig/include/linux/pci_ids.h
+++ linux-2.6.14-rc2-mm2/include/linux/pci_ids.h
@@ -408,6 +408,13 @@
 #define PCI_DEVICE_ID_NS_SC1100_XBUS	0x0515
 #define PCI_DEVICE_ID_NS_87410		0xd001
 
+#define PCI_DEVICE_ID_NS_CS5535_HOST_BRIDGE  0x0028
+#define PCI_DEVICE_ID_NS_CS5535_ISA_BRIDGE   0x002b
+#define PCI_DEVICE_ID_NS_CS5535_IDE          0x002d
+#define PCI_DEVICE_ID_NS_CS5535_AUDIO        0x002e
+#define PCI_DEVICE_ID_NS_CS5535_USB          0x002f
+#define PCI_DEVICE_ID_NS_CS5535_VIDEO        0x0030
+
 #define PCI_VENDOR_ID_TSENG		0x100c
 #define PCI_DEVICE_ID_TSENG_W32P_2	0x3202
 #define PCI_DEVICE_ID_TSENG_W32P_b	0x3205

