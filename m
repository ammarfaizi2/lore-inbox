Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWDLVCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWDLVCp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 17:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWDLVCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 17:02:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35791 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932243AbWDLVCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 17:02:44 -0400
Date: Wed, 12 Apr 2006 16:02:40 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86-64: pci-dma.c clean-up - trivial
Message-ID: <20060412210240.GD9602@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hard coded DMA masks with #defines from
include/linux/dma-mapping.h

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 4d9f2789dcd2 arch/x86_64/kernel/pci-dma.c
--- a/arch/x86_64/kernel/pci-dma.c	Wed Apr 12 23:54:39 2006 +0700
+++ b/arch/x86_64/kernel/pci-dma.c	Wed Apr 12 15:45:34 2006 -0500
@@ -38,7 +38,7 @@ int force_iommu __read_mostly= 0;
    to i386. */
 struct device fallback_dev = {
 	.bus_id = "fallback device",
-	.coherent_dma_mask = 0xffffffff,
+	.coherent_dma_mask = DMA_32BIT_MASK,
 	.dma_mask = &fallback_dev.coherent_dma_mask,
 };
 
@@ -73,7 +73,7 @@ dma_alloc_coherent(struct device *dev, s
 		dev = &fallback_dev;
 	dma_mask = dev->coherent_dma_mask;
 	if (dma_mask == 0)
-		dma_mask = 0xffffffff;
+		dma_mask = DMA_32BIT_MASK;
 
 	/* Don't invoke OOM killer */
 	gfp |= __GFP_NORETRY;
@@ -86,7 +86,7 @@ dma_alloc_coherent(struct device *dev, s
 	   larger than 16MB and in this case we have a chance of
 	   finding fitting memory in the next higher zone first. If
 	   not retry with true GFP_DMA. -AK */
-	if (dma_mask <= 0xffffffff)
+	if (dma_mask <= DMA_32BIT_MASK)
 		gfp |= GFP_DMA32;
 
  again:
@@ -107,7 +107,7 @@ dma_alloc_coherent(struct device *dev, s
 
 			/* Don't use the 16MB ZONE_DMA unless absolutely
 			   needed. It's better to use remapping first. */
-			if (dma_mask < 0xffffffff && !(gfp & GFP_DMA)) {
+			if (dma_mask < DMA_32BIT_MASK && !(gfp & GFP_DMA)) {
 				gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
 				goto again;
 			}
@@ -170,7 +170,7 @@ int dma_supported(struct device *dev, u6
 	/* Copied from i386. Doesn't make much sense, because it will
 	   only work for pci_alloc_coherent.
 	   The caller just has to use GFP_DMA in this case. */
-        if (mask < 0x00ffffff)
+        if (mask < DMA_24BIT_MASK)
                 return 0;
 
 	/* Tell the device to use SAC when IOMMU force is on.  This
@@ -185,7 +185,7 @@ int dma_supported(struct device *dev, u6
 	   SAC for these.  Assume all masks <= 40 bits are of this
 	   type. Normally this doesn't make any difference, but gives
 	   more gentle handling of IOMMU overflow. */
-	if (iommu_sac_force && (mask >= 0xffffffffffULL)) {
+	if (iommu_sac_force && (mask >= DMA_40BIT_MASK)) {
 		printk(KERN_INFO "%s: Force SAC with mask %Lx\n", dev->bus_id,mask);
 		return 0;
 	}
