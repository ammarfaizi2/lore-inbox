Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWEYDc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWEYDc2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 23:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWEYDcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 23:32:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:22158 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964851AbWEYDcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 23:32:20 -0400
Date: Wed, 24 May 2006 22:36:32 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/4] x86-64: Calgary IOMMU - IOMMU abstractions
Message-ID: <20060525033631.GE7720@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a new interface for IOMMUs by adding a centralized
location for IOMMU allocation (for translation tables/apertures) and
IOMMU initialization.  In creating these, code was moved around for
abstraction, uniformity, and consiceness.

Take note of the move of the iommu_setup bootarg parsing code to
__setup.  This is enabled by moving back the location of the aperture
allocation/detection to mem init (which while ugly, was already the
location of the swiotlb_init).

While a slight departure from the previous patch, I belive this provides
the true intention of the previous versions of the patch which changed
this code.  It also makes the addition of the upcoming calgary code much
cleaner than previous patches.

Signed-Off-By: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-Off-By: Jon Mason <jdmason@us.ibm.com>

diff -r 5ac11d170266 arch/x86_64/kernel/pci-dma.c
--- a/arch/x86_64/kernel/pci-dma.c	Wed May 24 11:01:18 2006 -0500
+++ b/arch/x86_64/kernel/pci-dma.c	Wed May 24 12:03:56 2006 -0500
@@ -227,7 +227,7 @@ EXPORT_SYMBOL(dma_set_mask);
    soft	 Use software bounce buffering (default for Intel machines)
    noaperture Don't touch the aperture for AGP.
 */
-__init int iommu_setup(char *p)
+static int __init iommu_setup(char *p)
 {
     iommu_merge = 1;
 
@@ -275,3 +275,32 @@ __init int iommu_setup(char *p)
     }
     return 1;
 }
+__setup("iommu=", iommu_setup);
+
+void __init pci_iommu_alloc(void)
+{
+	/* 
+	 * The order of these functions is important for
+	 * fall-back/fail-over reasons
+	 */
+#ifdef CONFIG_GART_IOMMU
+	iommu_hole_init();
+#endif
+
+#ifdef CONFIG_SWIOTLB
+	pci_swiotlb_init();
+#endif
+}
+
+static int __init pci_iommu_init(void)
+{
+#ifdef CONFIG_GART_IOMMU
+	gart_iommu_init();
+#endif
+
+	no_iommu_init();
+	return 0;
+}
+
+/* Must execute after PCI subsystem */
+fs_initcall(pci_iommu_init);
diff -r 5ac11d170266 arch/x86_64/kernel/pci-gart.c
--- a/arch/x86_64/kernel/pci-gart.c	Wed May 24 11:01:18 2006 -0500
+++ b/arch/x86_64/kernel/pci-gart.c	Wed May 24 12:03:56 2006 -0500
@@ -602,7 +602,7 @@ static struct dma_mapping_ops gart_dma_o
 	.unmap_sg = gart_unmap_sg,
 };
 
-static int __init pci_iommu_init(void)
+void __init gart_iommu_init(void)
 { 
 	struct agp_kern_info info;
 	unsigned long aper_size;
@@ -622,11 +622,11 @@ static int __init pci_iommu_init(void)
 #endif	
 
 	if (swiotlb)
-		return -1; 
+		return; 
 
 	/* Did we detect a different HW IOMMU? */
 	if (iommu_detected && !iommu_aperture)
-		return -1;
+		return;
 
 	if (no_iommu ||
 	    (!force_iommu && end_pfn <= MAX_DMA32_PFN) ||
@@ -640,7 +640,7 @@ static int __init pci_iommu_init(void)
 			       KERN_ERR "You might want to enable "
 					"CONFIG_GART_IOMMU\n");
 		}
-		return -1;
+		return;
 	}
 
 	i = 0;
@@ -648,7 +648,7 @@ static int __init pci_iommu_init(void)
 		i++;
 	if (i > MAX_NB) {
 		printk(KERN_ERR "PCI-GART: Too many northbridges (%ld). Disabled\n", i);
-		return -1;
+		return;
 	}
 
 	printk(KERN_INFO "PCI-DMA: using GART IOMMU.\n");
@@ -727,13 +727,10 @@ static int __init pci_iommu_init(void)
 
 	dma_ops = &gart_dma_ops;
 
-	return 0;
-} 
-
-/* Must execute after PCI subsystem */
-fs_initcall(pci_iommu_init);
-
-void gart_parse_options(char *p)
+	return;
+} 
+
+void __init gart_parse_options(char *p)
 {
 	int arg;
 
diff -r 5ac11d170266 arch/x86_64/kernel/setup.c
--- a/arch/x86_64/kernel/setup.c	Wed May 24 11:01:18 2006 -0500
+++ b/arch/x86_64/kernel/setup.c	Wed May 24 12:03:56 2006 -0500
@@ -65,7 +65,6 @@
 #include <asm/setup.h>
 #include <asm/mach_apic.h>
 #include <asm/numa.h>
-#include <asm/swiotlb.h>
 #include <asm/sections.h>
 #include <asm/gart-mapping.h>
 #include <asm/dmi.h>
@@ -396,10 +395,6 @@ static __init void parse_cmdline_early (
 			numa_setup(from+5); 
 #endif
 
-		if (!memcmp(from,"iommu=",6)) { 
-			iommu_setup(from+6); 
-		}
-
 		if (fullarg(from,"oops=panic"))
 			panic_on_oops = 1;
 
@@ -778,10 +773,6 @@ void __init setup_arch(char **cmdline_p)
 	}
 
 	e820_setup_gap();
-
-#ifdef CONFIG_GART_IOMMU
-	iommu_hole_init();
-#endif
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
diff -r 5ac11d170266 arch/x86_64/mm/init.c
--- a/arch/x86_64/mm/init.c	Wed May 24 11:01:18 2006 -0500
+++ b/arch/x86_64/mm/init.c	Wed May 24 12:03:56 2006 -0500
@@ -41,8 +41,6 @@
 #include <asm/proto.h>
 #include <asm/smp.h>
 #include <asm/sections.h>
-#include <asm/dma-mapping.h>
-#include <asm/swiotlb.h>
 
 #ifndef Dprintk
 #define Dprintk(x...)
@@ -587,10 +585,7 @@ void __init mem_init(void)
 {
 	long codesize, reservedpages, datasize, initsize;
 
-#ifdef CONFIG_SWIOTLB
-	pci_swiotlb_init();
-#endif
-	no_iommu_init();
+	pci_iommu_alloc();
 
 	/* How many end-of-memory variables you have, grandma! */
 	max_low_pfn = end_pfn;
diff -r 5ac11d170266 include/asm-x86_64/pci.h
--- a/include/asm-x86_64/pci.h	Wed May 24 11:01:18 2006 -0500
+++ b/include/asm-x86_64/pci.h	Wed May 24 12:03:56 2006 -0500
@@ -40,9 +40,8 @@ int pcibios_set_irq_routing(struct pci_d
 #include <asm/scatterlist.h>
 #include <linux/string.h>
 #include <asm/page.h>
-#include <linux/dma-mapping.h> /* for have_iommu */
 
-extern int iommu_setup(char *opt);
+extern void pci_iommu_alloc(void);
 
 /* The PCI address space does equal the physical memory
  * address space.  The networking and block device layers use
diff -r 5ac11d170266 include/asm-x86_64/proto.h
--- a/include/asm-x86_64/proto.h	Wed May 24 11:01:18 2006 -0500
+++ b/include/asm-x86_64/proto.h	Wed May 24 12:03:56 2006 -0500
@@ -37,7 +37,6 @@ extern void ia32_sysenter_target(void);
 
 extern void config_acpi_tables(void);
 extern void ia32_syscall(void);
-extern void iommu_hole_init(void);
 
 extern int pmtimer_mark_offset(void);
 extern void pmtimer_resume(void);
@@ -101,13 +100,9 @@ extern int unsynchronized_tsc(void);
 
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 
-extern void gart_parse_options(char *);
-extern void __init no_iommu_init(void);
-
 extern unsigned long table_start, table_end;
 
 extern int exception_trace;
-extern int force_iommu, no_iommu;
 extern int using_apic_timer;
 extern int disable_apic;
 extern unsigned cpu_khz;
@@ -116,8 +111,13 @@ extern int acpi_ht;
 extern int acpi_ht;
 extern int acpi_disabled;
 
+extern void no_iommu_init(void);
+extern int force_iommu, no_iommu;
 extern int iommu_detected;
 #ifdef CONFIG_GART_IOMMU
+extern void gart_iommu_init(void);
+extern void gart_parse_options(char *);
+extern void iommu_hole_init(void);
 extern int fallback_aper_order;
 extern int fallback_aper_force;
 extern int iommu_aperture;
