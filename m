Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWCNI3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWCNI3u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWCNI3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:29:50 -0500
Received: from mtaout2.012.net.il ([84.95.2.4]:28201 "EHLO mtaout2.012.net.il")
	by vger.kernel.org with ESMTP id S932147AbWCNI3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:29:49 -0500
Date: Tue, 14 Mar 2006 10:24:32 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [RFC PATCH 1/3] x86-64: Calgary IOMMU - introduce iommu_detected
To: Andi Kleen <ak@suse.de>
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <MULI@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Message-id: <20060314082432.GE23631@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

swiotlb relies on the gart specific iommu_aperture variable to know if
we discovered a hardware IOMMU before swiotlb
initialization. Introduce iommu_detected to do the same thing, but in
a HW IOMMU neutral manner, in preparation for adding the Calgary HW
IOMMU.

Signed-Off-By: Muli Ben-Yehuda <mulix@mulix.org>
Signed-Off-By: Jon Mason <jdmason@us.ibm.com>

diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/x86_64/kernel/aperture.c iommu_detected/arch/x86_64/kernel/aperture.c
--- vanilla/arch/x86_64/kernel/aperture.c	2006-03-14 08:24:37.000000000 +0200
+++ iommu_detected/arch/x86_64/kernel/aperture.c	2006-03-14 09:05:00.000000000 +0200
@@ -212,6 +212,7 @@ void __init iommu_hole_init(void) 
 		if (read_pci_config(0, num, 3, 0x00) != NB_ID_3) 
 			continue;	
 
+		iommu_detected = 1;
 		iommu_aperture = 1; 
 
 		aper_order = (read_pci_config(0, num, 3, 0x90) >> 1) & 7; 
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/x86_64/kernel/pci-dma.c iommu_detected/arch/x86_64/kernel/pci-dma.c
--- vanilla/arch/x86_64/kernel/pci-dma.c	2006-03-14 08:24:37.000000000 +0200
+++ iommu_detected/arch/x86_64/kernel/pci-dma.c	2006-03-14 09:05:48.000000000 +0200
@@ -33,6 +33,9 @@ int panic_on_overflow __read_mostly = 0;
 int force_iommu __read_mostly= 0;
 #endif
 
+/* Set this to 1 if there is a HW IOMMU in the system */
+int iommu_detected __read_mostly = 0;
+
 /* Dummy device used for NULL arguments (normally ISA). Better would
    be probably a smaller DMA mask, but this is bug-to-bug compatible
    to i386. */
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/x86_64/kernel/pci-gart.c iommu_detected/arch/x86_64/kernel/pci-gart.c
--- vanilla/arch/x86_64/kernel/pci-gart.c	2006-03-14 08:24:37.000000000 +0200
+++ iommu_detected/arch/x86_64/kernel/pci-gart.c	2006-03-14 09:06:44.000000000 +0200
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
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/x86_64/kernel/pci-swiotlb.c iommu_detected/arch/x86_64/kernel/pci-swiotlb.c
--- vanilla/arch/x86_64/kernel/pci-swiotlb.c	2006-03-14 08:24:37.000000000 +0200
+++ iommu_detected/arch/x86_64/kernel/pci-swiotlb.c	2006-03-14 09:07:05.000000000 +0200
@@ -31,7 +31,7 @@ struct dma_mapping_ops swiotlb_dma_ops =
 void pci_swiotlb_init(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-	if (!iommu_aperture && !no_iommu &&
+	if (!iommu_detected && !no_iommu &&
 	    (end_pfn > MAX_DMA32_PFN || force_iommu))
 	       swiotlb = 1;
 	if (swiotlb) {
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/include/asm-x86_64/dma-mapping.h iommu_detected/include/asm-x86_64/dma-mapping.h
--- vanilla/include/asm-x86_64/dma-mapping.h	2006-03-14 08:26:27.000000000 +0200
+++ iommu_detected/include/asm-x86_64/dma-mapping.h	2006-03-14 09:07:56.000000000 +0200
@@ -183,5 +183,6 @@ dma_cache_sync(void *vaddr, size_t size,
 
 extern struct device fallback_dev;
 extern int panic_on_overflow;
+extern int iommu_detected;
 
 #endif /* _X8664_DMA_MAPPING_H */


-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

