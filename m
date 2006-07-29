Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752082AbWG2TnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbWG2TnH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbWG2TnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:43:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:61148 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752077AbWG2Tmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:42:51 -0400
Date: Sat, 29 Jul 2006 21:42:49 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.18] [6/8] x86_64: Fix swiotlb=force
Message-ID: <44cbba39.hVPnfsQ2VLOwT8Gs%ak@suse.de>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It was broken before. But having it is important as possible hardware
bug workaround.

And previously there was no way to force swiotlb if there is another IOMMU.
Side effect is that iommu=force won't force swiotlb anymore even if there
isn't another IOMMU.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-swiotlb.c |    5 +++--
 include/asm-x86_64/swiotlb.h     |    2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc2-git7/arch/x86_64/kernel/pci-swiotlb.c
===================================================================
--- linux-2.6.18-rc2-git7.orig/arch/x86_64/kernel/pci-swiotlb.c
+++ linux-2.6.18-rc2-git7/arch/x86_64/kernel/pci-swiotlb.c
@@ -31,9 +31,10 @@ struct dma_mapping_ops swiotlb_dma_ops =
 void pci_swiotlb_init(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-	if (!iommu_detected && !no_iommu &&
-	    (end_pfn > MAX_DMA32_PFN || force_iommu))
+	if (!iommu_detected && !no_iommu && end_pfn > MAX_DMA32_PFN)
 	       swiotlb = 1;
+	if (swiotlb_force)
+		swiotlb = 1;
 	if (swiotlb) {
 		printk(KERN_INFO "PCI-DMA: Using software bounce buffering for IO (SWIOTLB)\n");
 		swiotlb_init();
Index: linux-2.6.18-rc2-git7/include/asm-x86_64/swiotlb.h
===================================================================
--- linux-2.6.18-rc2-git7.orig/include/asm-x86_64/swiotlb.h
+++ linux-2.6.18-rc2-git7/include/asm-x86_64/swiotlb.h
@@ -42,6 +42,8 @@ extern void swiotlb_free_coherent (struc
 extern int swiotlb_dma_supported(struct device *hwdev, u64 mask);
 extern void swiotlb_init(void);
 
+extern int swiotlb_force;
+
 #ifdef CONFIG_SWIOTLB
 extern int swiotlb;
 #else
