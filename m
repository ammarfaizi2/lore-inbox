Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWBCAPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWBCAPh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 19:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWBCAPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 19:15:36 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:3504 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964812AbWBCAPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 19:15:36 -0500
Date: Thu, 2 Feb 2006 18:15:29 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: ak@muc.de
Cc: mulix@mulix.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86-64: no_iommu removal in pci-gart.c
Message-ID: <20060203001529.GC32198@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In previous versions of pci-gart.c, no_iommu was used to determine if IOMMU was
disabled in the GART DMA mapping functions.  This changed in 2.6.16 and now
gart_xxx() functions are only called if gart is enabled.  Therefore, uses of
no_iommu in the GART code are no longer necessary and can be removed.

Also, it removes double deceleration of no_iommu and force_iommu in pci.h and
proto.h, by removing the deceleration in pci.h.

Lastly, end_pfn off by one error.

Tested (along with patch 1/2) on dual opteron with gart enabled, iommu=soft,
and iommu=off.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r e961b4a72270 arch/x86_64/kernel/aperture.c
--- a/arch/x86_64/kernel/aperture.c	Thu Feb  2 21:28:35 2006
+++ b/arch/x86_64/kernel/aperture.c	Thu Feb  2 15:34:24 2006
@@ -248,7 +248,7 @@
 		/* Got the aperture from the AGP bridge */
 	} else if (swiotlb && !valid_agp) {
 		/* Do nothing */
-	} else if ((!no_iommu && end_pfn >= MAX_DMA32_PFN) ||
+	} else if ((!no_iommu && end_pfn > MAX_DMA32_PFN) ||
 		   force_iommu ||
 		   valid_agp ||
 		   fallback_aper_force) { 
diff -r e961b4a72270 arch/x86_64/kernel/pci-gart.c
--- a/arch/x86_64/kernel/pci-gart.c	Thu Feb  2 21:28:35 2006
+++ b/arch/x86_64/kernel/pci-gart.c	Thu Feb  2 15:34:24 2006
@@ -228,11 +228,6 @@
 	int mmu = high;
 	if (force_iommu) 
 		mmu = 1; 
-	if (no_iommu) { 
-		if (high) 
-			panic("PCI-DMA: high address but no IOMMU.\n"); 
-		mmu = 0; 
-	} 	
 	return mmu; 
 }
 
@@ -241,11 +236,6 @@
 	u64 mask = *dev->dma_mask;
 	int high = addr + size >= mask;
 	int mmu = high;
-	if (no_iommu) { 
-		if (high) 
-			panic("PCI-DMA: high address but no IOMMU.\n"); 
-		mmu = 0; 
-	} 	
 	return mmu; 
 }
 
@@ -631,17 +621,13 @@
 		(agp_copy_info(agp_bridge, &info) < 0);
 #endif	
 
-	if (swiotlb) { 
-		no_iommu = 1;
+	if (swiotlb)
 		return -1; 
-	} 
-	
+
 	if (no_iommu ||
 	    (!force_iommu && end_pfn <= MAX_DMA32_PFN) ||
 	    !iommu_aperture ||
 	    (no_agp && init_k8_gatt(&info) < 0)) {
-		no_iommu = 1;
-		no_iommu_init();
 		printk(KERN_INFO "PCI-DMA: Disabling IOMMU.\n");
 		if (end_pfn > MAX_DMA32_PFN) {
 			printk(KERN_ERR "WARNING more than 4GB of memory "
diff -r e961b4a72270 include/asm-x86_64/pci.h
--- a/include/asm-x86_64/pci.h	Thu Feb  2 21:28:35 2006
+++ b/include/asm-x86_64/pci.h	Thu Feb  2 15:34:24 2006
@@ -18,8 +18,6 @@
 #define pcibios_assign_all_busses()	0
 #endif
 #define pcibios_scan_all_fns(a, b)	0
-
-extern int no_iommu, force_iommu;
 
 extern unsigned long pci_mem_start;
 #define PCIBIOS_MIN_IO		0x1000
