Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWBCANJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWBCANJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 19:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWBCANJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 19:13:09 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:48030 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964805AbWBCANI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 19:13:08 -0500
Date: Thu, 2 Feb 2006 18:13:01 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: ak@muc.de
Cc: mulix@mulix.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86-64: IOMMU printk cleanup
Message-ID: <20060203001300.GB32198@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains a printk reorder to remove the current problem of
displaying "PCI-DMA: Disabling IOMMU." and then "PCI-DMA: using GART IOMMU" 20
lines later in dmesg.

It also constains a printk reorder in swiotlb to state swiotlb enablement prior
to describing the location of the bounce buffers, and a printk reorder to
state gart enablement prior to describing the aperature.

Also constains a whitespace cleanup in arch/x86_64/kernel/setup.c

Tested (along with patch 2/2) on dual opteron with gart enabled, iommu=soft,
and iommu=off.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 338f9c8a66ea arch/x86_64/kernel/pci-gart.c
--- a/arch/x86_64/kernel/pci-gart.c	Thu Feb  2 04:15:57 2006
+++ b/arch/x86_64/kernel/pci-gart.c	Thu Feb  2 15:25:11 2006
@@ -642,9 +642,18 @@
 	    (no_agp && init_k8_gatt(&info) < 0)) {
 		no_iommu = 1;
 		no_iommu_init();
+		printk(KERN_INFO "PCI-DMA: Disabling IOMMU.\n");
+		if (end_pfn > MAX_DMA32_PFN) {
+			printk(KERN_ERR "WARNING more than 4GB of memory "
+					"but IOMMU not compiled in.\n"
+			       KERN_ERR "WARNING 32bit PCI may malfunction.\n"
+			       KERN_ERR "You might want to enable "
+					"CONFIG_GART_IOMMU\n");
+		}
 		return -1;
 	}
 
+	printk(KERN_INFO "PCI-DMA: using GART IOMMU.\n");
 	aper_size = info.aper_size * 1024 * 1024;	
 	iommu_size = check_iommu_size(info.aper_base, aper_size); 
 	iommu_pages = iommu_size >> PAGE_SHIFT; 
@@ -718,7 +727,6 @@
 		     
 	flush_gart(NULL);
 
-	printk(KERN_INFO "PCI-DMA: using GART IOMMU.\n");
 	dma_ops = &gart_dma_ops;
 
 	return 0;
diff -r 338f9c8a66ea arch/x86_64/kernel/pci-nommu.c
--- a/arch/x86_64/kernel/pci-nommu.c	Thu Feb  2 04:15:57 2006
+++ b/arch/x86_64/kernel/pci-nommu.c	Thu Feb  2 15:25:11 2006
@@ -88,12 +88,5 @@
 {
 	if (dma_ops)
 		return;
-	printk(KERN_INFO "PCI-DMA: Disabling IOMMU.\n");
 	dma_ops = &nommu_dma_ops;
-	if (end_pfn > MAX_DMA32_PFN) {
-		printk(KERN_ERR
-		       "WARNING more than 4GB of memory but IOMMU not compiled in.\n"
-		       KERN_ERR "WARNING 32bit PCI may malfunction.\n"
-		       KERN_ERR "You might want to enable CONFIG_GART_IOMMU\n");
-	}
 }
diff -r 338f9c8a66ea arch/x86_64/kernel/pci-swiotlb.c
--- a/arch/x86_64/kernel/pci-swiotlb.c	Thu Feb  2 04:15:57 2006
+++ b/arch/x86_64/kernel/pci-swiotlb.c	Thu Feb  2 15:25:11 2006
@@ -35,8 +35,8 @@
 	    (end_pfn > MAX_DMA32_PFN || force_iommu))
 	       swiotlb = 1;
 	if (swiotlb) {
+		printk(KERN_INFO "PCI-DMA: Using software bounce buffering for IO (SWIOTLB)\n");
 		swiotlb_init();
-		printk(KERN_INFO "PCI-DMA: Using software bounce buffering for IO (SWIOTLB)\n");
 		dma_ops = &swiotlb_dma_ops;
 	}
 }
diff -r 338f9c8a66ea arch/x86_64/kernel/setup.c
--- a/arch/x86_64/kernel/setup.c	Thu Feb  2 04:15:57 2006
+++ b/arch/x86_64/kernel/setup.c	Thu Feb  2 15:25:11 2006
@@ -741,7 +741,7 @@
 	e820_setup_gap();
 
 #ifdef CONFIG_GART_IOMMU
-       iommu_hole_init();
+	iommu_hole_init();
 #endif
 
 #ifdef CONFIG_VT
