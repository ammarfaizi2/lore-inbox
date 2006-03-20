Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWCTI5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWCTI5Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWCTI5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:57:24 -0500
Received: from mtaout1.012.net.il ([84.95.2.1]:7751 "EHLO mtaout1.012.net.il")
	by vger.kernel.org with ESMTP id S932244AbWCTI5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:57:09 -0500
Date: Mon, 20 Mar 2006 10:56:41 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [PATCH 3/3] x86-64: Calgary IOMMU - hook it in
In-reply-to: <20060320085416.GB21729@granada.merseine.nu>
To: Andi Kleen <ak@suse.de>
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Message-id: <20060320085641.GC21729@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060320084848.GA21729@granada.merseine.nu>
 <20060320085416.GB21729@granada.merseine.nu>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch hooks Calgary into the build and the x86-64 IOMMU
initialization paths.

This is patch -B2 against 2.6.16, with minor Kconfig updates.

diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/arch/x86_64/Kconfig linux/arch/x86_64/Kconfig
--- iommu_detected/arch/x86_64/Kconfig	2006-03-20 09:12:23.000000000 +0200
+++ linux/arch/x86_64/Kconfig	2006-03-20 09:30:10.000000000 +0200
@@ -372,6 +372,19 @@ config GART_IOMMU
 	  and a software emulation used on other systems.
 	  If unsure, say Y.
 
+config CALGARY_IOMMU
+	bool "IBM x366 server IOMMU"
+	default y
+	depends on PCI && MPSC && EXPERIMENTAL
+	help
+	  Support for hardware IOMMUs in IBM's xSeries x366 and x460
+	  systems. Needed to run systems with more than 3GB of memory
+	  properly with 32-bit PCI devices that do not support DAC
+	  (Double Address Cycle).  The IOMMU can be turned off at
+	  boot time with the iommu=off parameter.  Normally the kernel
+	  will make the right choice by iteself.
+	  If unsure, say Y.
+
 # need this always enabled with GART_IOMMU for the VIA workaround
 config SWIOTLB
 	bool
diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/arch/x86_64/kernel/Makefile linux/arch/x86_64/kernel/Makefile
--- iommu_detected/arch/x86_64/kernel/Makefile	2006-03-20 09:12:24.000000000 +0200
+++ linux/arch/x86_64/kernel/Makefile	2006-03-20 09:30:11.000000000 +0200
@@ -29,6 +29,7 @@ obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspen
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o aperture.o
+obj-$(CONFIG_CALGARY_IOMMU)	+= pci-calgary.o tce.o
 obj-$(CONFIG_SWIOTLB)		+= pci-swiotlb.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_X86_PM_TIMER)	+= pmtimer.o
diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/arch/x86_64/kernel/pci-dma.c linux/arch/x86_64/kernel/pci-dma.c
--- iommu_detected/arch/x86_64/kernel/pci-dma.c	2006-03-20 09:15:17.000000000 +0200
+++ linux/arch/x86_64/kernel/pci-dma.c	2006-03-20 09:30:11.000000000 +0200
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
+#ifdef CONFIG_GART_IOMMU
+	rc = gart_iommu_init();
+	if (!rc) /* success? */
+		return 0;
+#endif
+#ifdef CONFIG_CALGARY_IOMMU
+	rc = calgary_iommu_init();
+#endif
+	return rc;
+}
+
+/* Must execute after PCI subsystem */
+fs_initcall(pci_iommu_init);
diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/arch/x86_64/kernel/pci-gart.c linux/arch/x86_64/kernel/pci-gart.c
--- iommu_detected/arch/x86_64/kernel/pci-gart.c	2006-03-20 09:15:17.000000000 +0200
+++ linux/arch/x86_64/kernel/pci-gart.c	2006-03-20 09:30:11.000000000 +0200
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
 
diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/arch/x86_64/kernel/setup.c linux/arch/x86_64/kernel/setup.c
--- iommu_detected/arch/x86_64/kernel/setup.c	2006-03-20 09:12:25.000000000 +0200
+++ linux/arch/x86_64/kernel/setup.c	2006-03-20 09:30:11.000000000 +0200
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
 
@@ -747,6 +754,9 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_GART_IOMMU
 	iommu_hole_init();
 #endif
+#ifdef CONFIG_CALGARY_IOMMU
+	detect_calgary();
+#endif
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/include/asm-x86_64/pci.h linux/include/asm-x86_64/pci.h
--- iommu_detected/include/asm-x86_64/pci.h	2006-03-20 09:13:42.000000000 +0200
+++ linux/include/asm-x86_64/pci.h	2006-03-20 09:30:12.000000000 +0200
@@ -53,7 +53,7 @@ extern int iommu_setup(char *opt);
  */
 #define PCI_DMA_BUS_IS_PHYS (dma_ops->is_phys)
 
-#ifdef CONFIG_GART_IOMMU
+#if defined(CONFIG_GART_IOMMU) || defined(CONFIG_CALGARY_IOMMU)
 
 /*
  * x86-64 always supports DAC, but sometimes it is useful to force
diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/include/asm-x86_64/proto.h linux/include/asm-x86_64/proto.h
--- iommu_detected/include/asm-x86_64/proto.h	2006-03-20 09:13:42.000000000 +0200
+++ linux/include/asm-x86_64/proto.h	2006-03-20 09:30:12.000000000 +0200
@@ -104,7 +104,9 @@ extern int unsynchronized_tsc(void);
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 
 extern void gart_parse_options(char *);
-extern void __init no_iommu_init(void);
+extern int gart_iommu_init(void);
+extern void no_iommu_init(void);
+extern void detect_calgary(void);
 
 extern unsigned long table_start, table_end;
 


-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

