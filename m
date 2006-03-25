Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWCYVF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWCYVF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 16:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWCYVFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 16:05:44 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:30029 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751431AbWCYVFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 16:05:40 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 3] x86-64: Calgary IOMMU - hook it in
X-Mercurial-Node: 0fb9d3906919574377da15172911353bd75367e3
Message-Id: <0fb9d3906919574377da.1143320681@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1143320678@rhun.haifa.ibm.com>
Date: Sat, 25 Mar 2006 23:04:41 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: ak@suse.de
Cc: jdmason@us.ibm.com, mulix@mulix.org, muli@il.ibm.com,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, akpm@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# HG changeset patch
# User Muli Ben-Yehuda <mulix@mulix.org>
# Node ID 0fb9d3906919574377da15172911353bd75367e3
# Parent  3790675cd50e897691fe89c7e5b0e4d5d33057a4
x86-64: Calgary IOMMU - hook it in

This patch hooks Calgary into the build and the x86-64 IOMMU
initialization paths. It makes the following changes:

- add Kconfig entry for Calgary
- add Makefile stanza for Calgary
- try to initialize Calgary in pci_iommu_init
- parse calgary=xxx boot options in parse_cmdline_early (early because
  we need them in detect_calgary(), called from setup_arch())
- add Calgary boot options documentation
- make sure PCI_UNMAP_ADDR/PCI_UNMAP_LEN are defined properly for
  Calgary
- add prototypes for gart_iommu_init(), no_iommu_init() and
  detect_calgary() to proto.h

This is patch -C1 against 2.6.16-git. Changes from previous version:

- remove dependency on MPSC in Kconfig
- elaborate in the Kconfig message on Calgary's isolation capabilities
- switch the initialization order: first Calgary, then gart

Signed-off-by: Muli Ben-Yehuda <mulix@mulix.org>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 3790675cd50e -r 0fb9d3906919 Documentation/x86_64/boot-options.txt
--- a/Documentation/x86_64/boot-options.txt	Sat Mar 25 22:28:34 2006 +0200
+++ b/Documentation/x86_64/boot-options.txt	Sat Mar 25 22:36:17 2006 +0200
@@ -200,6 +200,27 @@ IOMMU
   pages  Prereserve that many 128K pages for the software IO bounce buffering.
   force  Force all IO through the software TLB.
 
+  calgary=[64k,128k,256k,512k,1M,2M,4M,8M]
+  calgary=[translate_empty_slots,translate_phb0]
+
+    64k,...,8M - Set the size of each PCI slot's translation table
+    when using the Calgary IOMMU. This is the size of the translation
+    table itself in main memory. The smallest table, 64k, covers an IO
+    space of 32MB; the largest, 8MB table, can cover an IO space of
+    4GB. Normally the kernel will make the right choice by itself.
+
+    translate_empty_slots - Enable translation even on slots that have
+    no devices attached to them, in case a device will be hotplugged
+    in the future.
+
+    translate_phb0 - Enable translation on PHB0. The built-in graphics
+    adapter resides on the first bridge (PHB0); if translation
+    (isolation) is enabled on this PHB, X servers that access the
+    hardware directly from user space might stop working. Enable this
+    option if your X server only accesses hardware through the kernel
+    (or you're not using X) and you wants isolation for this bridge as
+    well.
+
 Debugging
 
   oops=panic Always panic on oopses. Default is to just kill the process,
diff -r 3790675cd50e -r 0fb9d3906919 arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	Sat Mar 25 22:28:34 2006 +0200
+++ b/arch/x86_64/Kconfig	Sat Mar 25 22:36:17 2006 +0200
@@ -372,6 +372,24 @@ config GART_IOMMU
 	  and a software emulation used on other systems.
 	  If unsure, say Y.
 
+config CALGARY_IOMMU
+	bool "IBM x366 server IOMMU"
+	default y
+	depends on PCI && EXPERIMENTAL
+	help
+	  Support for hardware IOMMUs in IBM's xSeries x366 and x460
+	  systems. Needed to run systems with more than 3GB of memory
+	  properly with 32-bit PCI devices that do not support DAC
+	  (Double Address Cycle). Calgary also supports bus level 
+	  isolation, where all DMAs pass through the IOMMU.  This 
+	  prevents them from going anywhere except their intended 
+	  destination. This catches hard-to-find kernel bugs and
+	  mis-behaving drivers and devices that do not use the DMA-API
+	  properly to set up their DMA buffers.  The IOMMU can be 
+	  turned off at boot time with the iommu=off parameter.  
+	  Normally the kernel will make the right choice by itself.
+	  If unsure, say Y.
+
 # need this always enabled with GART_IOMMU for the VIA workaround
 config SWIOTLB
 	bool
diff -r 3790675cd50e -r 0fb9d3906919 arch/x86_64/kernel/Makefile
--- a/arch/x86_64/kernel/Makefile	Sat Mar 25 22:28:34 2006 +0200
+++ b/arch/x86_64/kernel/Makefile	Sat Mar 25 22:36:17 2006 +0200
@@ -29,6 +29,7 @@ obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o aperture.o
+obj-$(CONFIG_CALGARY_IOMMU)	+= pci-calgary.o tce.o
 obj-$(CONFIG_SWIOTLB)		+= pci-swiotlb.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_X86_PM_TIMER)	+= pmtimer.o
diff -r 3790675cd50e -r 0fb9d3906919 arch/x86_64/kernel/pci-dma.c
--- a/arch/x86_64/kernel/pci-dma.c	Sat Mar 25 22:28:34 2006 +0200
+++ b/arch/x86_64/kernel/pci-dma.c	Sat Mar 25 22:36:17 2006 +0200
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <asm/io.h>
 #include <asm/proto.h>
+#include <asm/calgary.h>
 
 int iommu_merge __read_mostly = 0;
 EXPORT_SYMBOL(iommu_merge);
@@ -270,3 +271,21 @@ __init int iommu_setup(char *p)
     }
     return 1;
 }
+
+static int __init pci_iommu_init(void)
+{
+	int rc = 0;
+
+#ifdef CONFIG_CALGARY_IOMMU
+	rc = calgary_iommu_init();
+	if (!rc) /* success? */
+		return 0;
+#endif
+#ifdef CONFIG_GART_IOMMU
+	rc = gart_iommu_init();
+#endif
+	return rc;
+}
+
+/* Must execute after PCI subsystem */
+fs_initcall(pci_iommu_init);
diff -r 3790675cd50e -r 0fb9d3906919 arch/x86_64/kernel/pci-gart.c
--- a/arch/x86_64/kernel/pci-gart.c	Sat Mar 25 22:28:34 2006 +0200
+++ b/arch/x86_64/kernel/pci-gart.c	Sat Mar 25 22:36:17 2006 +0200
@@ -605,7 +605,7 @@ static struct dma_mapping_ops gart_dma_o
 	.unmap_sg = gart_unmap_sg,
 };
 
-static int __init pci_iommu_init(void)
+int __init gart_iommu_init(void)
 { 
 	struct agp_kern_info info;
 	unsigned long aper_size;
@@ -725,10 +725,7 @@ static int __init pci_iommu_init(void)
 	return 0;
 } 
 
-/* Must execute after PCI subsystem */
-fs_initcall(pci_iommu_init);
-
-void gart_parse_options(char *p)
+void __init gart_parse_options(char *p)
 {
 	int arg;
 
diff -r 3790675cd50e -r 0fb9d3906919 arch/x86_64/kernel/setup.c
--- a/arch/x86_64/kernel/setup.c	Sat Mar 25 22:28:34 2006 +0200
+++ b/arch/x86_64/kernel/setup.c	Sat Mar 25 22:36:17 2006 +0200
@@ -67,6 +67,7 @@
 #include <asm/swiotlb.h>
 #include <asm/sections.h>
 #include <asm/gart-mapping.h>
+#include <asm/calgary.h>
 
 /*
  * Machine setup..
@@ -388,6 +389,12 @@ static __init void parse_cmdline_early (
 			iommu_setup(from+6); 
 		}
 
+#ifdef CONFIG_CALGARY_IOMMU 
+		if (!memcmp(from,"calgary=",8)) { 
+			calgary_parse_options(from+8);
+		}
+#endif
+
 		if (!memcmp(from,"oops=panic", 10))
 			panic_on_oops = 1;
 
@@ -746,6 +753,9 @@ void __init setup_arch(char **cmdline_p)
 
 #ifdef CONFIG_GART_IOMMU
 	iommu_hole_init();
+#endif
+#ifdef CONFIG_CALGARY_IOMMU
+	detect_calgary();
 #endif
 
 #ifdef CONFIG_VT
diff -r 3790675cd50e -r 0fb9d3906919 include/asm-x86_64/pci.h
--- a/include/asm-x86_64/pci.h	Sat Mar 25 22:28:34 2006 +0200
+++ b/include/asm-x86_64/pci.h	Sat Mar 25 22:36:17 2006 +0200
@@ -53,7 +53,7 @@ extern int iommu_setup(char *opt);
  */
 #define PCI_DMA_BUS_IS_PHYS (dma_ops->is_phys)
 
-#ifdef CONFIG_GART_IOMMU
+#if defined(CONFIG_GART_IOMMU) || defined(CONFIG_CALGARY_IOMMU)
 
 /*
  * x86-64 always supports DAC, but sometimes it is useful to force
diff -r 3790675cd50e -r 0fb9d3906919 include/asm-x86_64/proto.h
--- a/include/asm-x86_64/proto.h	Sat Mar 25 22:28:34 2006 +0200
+++ b/include/asm-x86_64/proto.h	Sat Mar 25 22:36:17 2006 +0200
@@ -104,7 +104,9 @@ extern void select_idle_routine(const st
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 
 extern void gart_parse_options(char *);
-extern void __init no_iommu_init(void);
+extern int gart_iommu_init(void);
+extern void no_iommu_init(void);
+extern void detect_calgary(void);
 
 extern unsigned long table_start, table_end;
 
