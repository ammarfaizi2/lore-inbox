Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWCYVFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWCYVFl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 16:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWCYVFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 16:05:40 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:40579 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751447AbWCYVFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 16:05:40 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 3] x86-64: Calgary IOMMU - introduce iommu_detected
X-Mercurial-Node: 6681fd7b99190c743a6bf200b25531da582de766
Message-Id: <6681fd7b99190c743a6b.1143320679@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1143320678@rhun.haifa.ibm.com>
Date: Sat, 25 Mar 2006 23:04:39 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: ak@suse.de
Cc: jdmason@us.ibm.com, mulix@mulix.org, muli@il.ibm.com,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, akpm@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# HG changeset patch
# User Muli Ben-Yehuda <mulix@mulix.org>
# Node ID 6681fd7b99190c743a6bf200b25531da582de766
# Parent  2e00371db0e917d63984e01d04742bdf7ef6df2e
x86-64: Calgary IOMMU - introduce iommu_detected

swiotlb relies on the gart specific iommu_aperture variable to know if
we discovered a hardware IOMMU before swiotlb
initialization. Introduce iommu_detected to do the same thing, but in
a HW IOMMU neutral manner, in preparation for adding the Calgary HW
IOMMU.

This is patch -C1 against 2.6.16-git, unchanged from previous
version.

Signed-Off-By: Muli Ben-Yehuda <mulix@mulix.org>
Signed-Off-By: Jon Mason <jdmason@us.ibm.com>

diff -r 2e00371db0e9 -r 6681fd7b9919 arch/x86_64/kernel/aperture.c
--- a/arch/x86_64/kernel/aperture.c	Sat Mar 25 22:11:26 2006 +0200
+++ b/arch/x86_64/kernel/aperture.c	Sat Mar 25 22:13:44 2006 +0200
@@ -212,6 +212,7 @@ void __init iommu_hole_init(void)
 		if (read_pci_config(0, num, 3, 0x00) != NB_ID_3) 
 			continue;	
 
+		iommu_detected = 1;
 		iommu_aperture = 1; 
 
 		aper_order = (read_pci_config(0, num, 3, 0x90) >> 1) & 7; 
diff -r 2e00371db0e9 -r 6681fd7b9919 arch/x86_64/kernel/pci-dma.c
--- a/arch/x86_64/kernel/pci-dma.c	Sat Mar 25 22:11:26 2006 +0200
+++ b/arch/x86_64/kernel/pci-dma.c	Sat Mar 25 22:13:44 2006 +0200
@@ -32,6 +32,9 @@ int panic_on_overflow __read_mostly = 0;
 int panic_on_overflow __read_mostly = 0;
 int force_iommu __read_mostly= 0;
 #endif
+
+/* Set this to 1 if there is a HW IOMMU in the system */
+int iommu_detected __read_mostly = 0;
 
 /* Dummy device used for NULL arguments (normally ISA). Better would
    be probably a smaller DMA mask, but this is bug-to-bug compatible
diff -r 2e00371db0e9 -r 6681fd7b9919 arch/x86_64/kernel/pci-gart.c
--- a/arch/x86_64/kernel/pci-gart.c	Sat Mar 25 22:11:26 2006 +0200
+++ b/arch/x86_64/kernel/pci-gart.c	Sat Mar 25 22:13:44 2006 +0200
@@ -627,6 +627,10 @@ static int __init pci_iommu_init(void)
 	if (swiotlb)
 		return -1; 
 
+        /* Did we detect a different HW IOMMU? */
+	if (iommu_detected && !iommu_aperture)
+		return -1;
+ 
 	if (no_iommu ||
 	    (!force_iommu && end_pfn <= MAX_DMA32_PFN) ||
 	    !iommu_aperture ||
diff -r 2e00371db0e9 -r 6681fd7b9919 arch/x86_64/kernel/pci-swiotlb.c
--- a/arch/x86_64/kernel/pci-swiotlb.c	Sat Mar 25 22:11:26 2006 +0200
+++ b/arch/x86_64/kernel/pci-swiotlb.c	Sat Mar 25 22:13:44 2006 +0200
@@ -31,7 +31,7 @@ void pci_swiotlb_init(void)
 void pci_swiotlb_init(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-	if (!iommu_aperture && !no_iommu &&
+	if (!iommu_detected && !no_iommu &&
 	    (end_pfn > MAX_DMA32_PFN || force_iommu))
 	       swiotlb = 1;
 	if (swiotlb) {
diff -r 2e00371db0e9 -r 6681fd7b9919 include/asm-x86_64/dma-mapping.h
--- a/include/asm-x86_64/dma-mapping.h	Sat Mar 25 22:11:26 2006 +0200
+++ b/include/asm-x86_64/dma-mapping.h	Sat Mar 25 22:13:44 2006 +0200
@@ -200,5 +200,6 @@ dma_cache_sync(void *vaddr, size_t size,
 
 extern struct device fallback_dev;
 extern int panic_on_overflow;
+extern int iommu_detected;
 
 #endif /* _X8664_DMA_MAPPING_H */
