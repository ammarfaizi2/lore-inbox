Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbVJ1QcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbVJ1QcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVJ1QcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:32:11 -0400
Received: from amdext3.amd.com ([139.95.251.6]:28329 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1030201AbVJ1QcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:32:10 -0400
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Date: Fri, 28 Oct 2005 09:44:30 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: info-linux@ldcmail.amd.com
Subject: [PATCH 1/6] AMD Geode GX/LX Support (Refreshed)
Message-ID: <20051028154430.GB19854@cosmic.amd.com>
References: <LYRIS-4270-74122-2005.10.28-09.38.17--jordan.crouse#amd.com@whitestar.amd.com>
MIME-Version: 1.0
In-Reply-To: <LYRIS-4270-74122-2005.10.28-09.38.17--jordan.crouse#amd.com@whitestar.amd.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F7C99633CO5944149-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the base GX/LX support patch.  Prior changelog:

* fixed up the MGEODEGX1 cache line size to the correct value.
* Removed GEODE_LX restrictions from IOAPIC and HIGHMEM (Alan Cox and others)
* Removed GEODE_LX define from the 3DNOW config option pending conclusive
  benchmark results that it increases performance (Alan Cox)
* Fix up the GX1/GX cpu init function so that it is cleaner and more
  correct. If anybody gets a NSC branded GX1 processor, it should jump 
  into the init_cyrix and do the right thing. (Alan Cox)
* Updated the MAINTAINERS information (Adrian Bunk)

MAINTAINERS                  |    7 +++++++
arch/i386/Kconfig            |   12 +++++++++---
arch/i386/kernel/cpu/amd.c   |    7 +++++++
arch/i386/kernel/cpu/cyrix.c |   32 +++++++++++++++++++++++++++++++-
include/asm-i386/module.h    |    4 +++-
include/linux/pci_ids.h      |   10 ++++++++++
6 files changed, 67 insertions(+), 5 deletions(-)

Index: linux-2.6.14/arch/i386/Kconfig
===================================================================
--- linux-2.6.14.orig/arch/i386/Kconfig
+++ linux-2.6.14/arch/i386/Kconfig
@@ -191,6 +191,7 @@ config M386
 	  - "Winchip-2" for IDT Winchip 2.
 	  - "Winchip-2A" for IDT Winchips with 3dNow! capabilities.
 	  - "GeodeGX1" for Geode GX1 (Cyrix MediaGX).
+	  - "Geode GX/LX" For AMD Geode GX and LX processors.
 	  - "CyrixIII/VIA C3" for VIA Cyrix III or VIA C3.
 	  - "VIA C3-2 for VIA C3-2 "Nehemiah" (model 9 and above).
 
@@ -323,6 +324,11 @@ config MGEODEGX1
 	help
 	  Select this for a Geode GX1 (Cyrix MediaGX) chip.
 
+config MGEODE_LX
+       bool "Geode GX/LX"
+       help
+         Select this for AMD Geode GX and LX processors.
+
 config MCYRIXIII
 	bool "CyrixIII/VIA-C3"
 	help
@@ -372,8 +378,8 @@ config X86_XADD
 config X86_L1_CACHE_SHIFT
 	int
 	default "7" if MPENTIUM4 || X86_GENERIC
-	default "4" if X86_ELAN || M486 || M386
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODEGX1
+	default "4" if X86_ELAN || M486 || M386 || MGEODEGX1
+	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
 	default "6" if MK7 || MK8 || MPENTIUMM
 
 config RWSEM_GENERIC_SPINLOCK
@@ -437,7 +443,7 @@ config X86_INTEL_USERCOPY
 
 config X86_USE_PPRO_CHECKSUM
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MEFFICEON
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MEFFICEON || MGEODE_LX
 	default y
 
 config X86_USE_3DNOW
Index: linux-2.6.14/arch/i386/kernel/cpu/amd.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/cpu/amd.c
+++ linux-2.6.14/arch/i386/kernel/cpu/amd.c
@@ -161,6 +161,13 @@ static void __init init_amd(struct cpuin
 					set_bit(X86_FEATURE_K6_MTRR, c->x86_capability);
 				break;
 			}
+
+			if ( c->x86_model == 10 ) {
+				/* AMD Geode LX is model 10 */
+				/* placeholder for any needed mods */
+				break;
+			}
+
 			break;
 
 		case 6: /* An Athlon/Duron */
Index: linux-2.6.14/include/linux/pci_ids.h
===================================================================
--- linux-2.6.14.orig/include/linux/pci_ids.h
+++ linux-2.6.14/include/linux/pci_ids.h
@@ -405,6 +405,13 @@
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
@@ -536,6 +543,9 @@
 #define PCI_DEVICE_ID_AMD_8151_0	0x7454
 #define PCI_DEVICE_ID_AMD_8131_APIC     0x7450
 
+#define PCI_DEVICE_ID_AMD_LX_VIDEO  0x2081
+#define PCI_DEVICE_ID_AMD_LX_AES    0x2082
+
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_NX	0x2001
Index: linux-2.6.14/MAINTAINERS
===================================================================
--- linux-2.6.14.orig/MAINTAINERS
+++ linux-2.6.14/MAINTAINERS
@@ -252,6 +252,13 @@ P:	Ivan Kokshaysky
 M:	ink@jurassic.park.msu.ru
 S:	Maintained for 2.4; PCI support for 2.6.
 
+AMD GEODE PROCESSOR/CHIPSET SUPPORT
+P:      Jordan Crouse
+M:      info-linux@geode.amd.com
+L:	info-linux@geode.amd.com
+W:	http://www.amd.com/us-en/ConnectivitySolutions/TechnicalResources/0,,50_2334_2452_11363,00.html
+S:	Supported
+
 APM DRIVER
 P:	Stephen Rothwell
 M:	sfr@canb.auug.org.au
Index: linux-2.6.14/arch/i386/kernel/cpu/cyrix.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/cpu/cyrix.c
+++ linux-2.6.14/arch/i386/kernel/cpu/cyrix.c
@@ -342,6 +342,36 @@ static void __init init_cyrix(struct cpu
 	return;
 }
 
+
+/* This function handles National Semiconductor branded processors */
+
+static void __init init_nsc(struct cpuinfo_x86 *c)
+{
+	int r;
+
+	/* There may be GX1 processors in the wild that are branded
+	 * NSC and not Cyrix.
+	 *
+	 * This function only handles the GX processor, and kicks every
+	 * thing else to the Cyrix init function above - that should
+	 * cover any processors that might have been branded differently
+	 * after NSC aquired Cyrix.
+	 *
+	 * If this breaks your GX1 horribly, please e-mail
+	 * info-linux@ldcmail.amd.com to tell us.
+	 */
+
+	/* Handle the GX (Formally known as the GX2) */
+
+	if ((c->x86 == 5) && (c->x86_model == 5)) {
+		r = get_model_name(c);
+		display_cacheinfo(c);
+	}
+	else
+		init_cyrix(c);
+}
+
+
 /*
  * Cyrix CPUs without cpuid or with cpuid not yet enabled can be detected
  * by the fact that they preserve the flags across the division of 5/2.
@@ -422,7 +452,7 @@ int __init cyrix_init_cpu(void)
 static struct cpu_dev nsc_cpu_dev __initdata = {
 	.c_vendor	= "NSC",
 	.c_ident 	= { "Geode by NSC" },
-	.c_init		= init_cyrix,
+	.c_init		= init_nsc,
 	.c_identify	= generic_identify,
 };
 
Index: linux-2.6.14/include/asm-i386/module.h
===================================================================
--- linux-2.6.14.orig/include/asm-i386/module.h
+++ linux-2.6.14/include/asm-i386/module.h
@@ -52,8 +52,10 @@ struct mod_arch_specific
 #define MODULE_PROC_FAMILY "CYRIXIII "
 #elif defined CONFIG_MVIAC3_2
 #define MODULE_PROC_FAMILY "VIAC3-2 "
-#elif CONFIG_MGEODEGX1
+#elif defined CONFIG_MGEODEGX1
 #define MODULE_PROC_FAMILY "GEODEGX1 "
+#elif defined CONFIG_MGEODE_LX
+#define MODULE_PROC_FAMILY "GEODE "
 #else
 #error unknown processor family
 #endif

