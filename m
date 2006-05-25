Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWEYD35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWEYD35 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 23:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWEYD35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 23:29:57 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:49542 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964834AbWEYD34
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 23:29:56 -0400
Date: Wed, 24 May 2006 22:34:09 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/4] x86-64: Calgary IOMMU - introduce iommu_detected
Message-ID: <20060525033408.GC7720@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swiotlb relies on the gart specific iommu_aperture variable to know if
we discovered a hardware IOMMU before swiotlb initialization.  Introduce
iommu_detected to do the same thing, but in a HW IOMMU neutral manner,
in preparation for adding the Calgary HW IOMMU.

Thanks,
Jon

Signed-Off-By: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-Off-By: Jon Mason <jdmason@us.ibm.com>

diff -r 82f66cc5a33b arch/x86_64/kernel/aperture.c
--- a/arch/x86_64/kernel/aperture.c	Tue May 23 18:57:22 2006
+++ b/arch/x86_64/kernel/aperture.c	Tue May 23 14:05:16 2006
@@ -212,6 +212,7 @@
 		if (read_pci_config(0, num, 3, 0x00) != NB_ID_3) 
 			continue;	
 
+		iommu_detected = 1;
 		iommu_aperture = 1; 
 
 		aper_order = (read_pci_config(0, num, 3, 0x90) >> 1) & 7; 
diff -r 82f66cc5a33b arch/x86_64/kernel/pci-dma.c
--- a/arch/x86_64/kernel/pci-dma.c	Tue May 23 18:57:22 2006
+++ b/arch/x86_64/kernel/pci-dma.c	Tue May 23 14:05:16 2006
@@ -32,6 +32,9 @@
 int panic_on_overflow __read_mostly = 0;
 int force_iommu __read_mostly= 0;
 #endif
+
+/* Set this to 1 if there is a HW IOMMU in the system */
+int iommu_detected __read_mostly = 0;
 
 /* Dummy device used for NULL arguments (normally ISA). Better would
    be probably a smaller DMA mask, but this is bug-to-bug compatible
diff -r 82f66cc5a33b arch/x86_64/kernel/pci-gart.c
--- a/arch/x86_64/kernel/pci-gart.c	Tue May 23 18:57:22 2006
+++ b/arch/x86_64/kernel/pci-gart.c	Tue May 23 14:05:16 2006
@@ -624,6 +624,10 @@
 	if (swiotlb)
 		return -1; 
 
+	/* Did we detect a different HW IOMMU? */
+	if (iommu_detected && !iommu_aperture)
+		return -1;
+
 	if (no_iommu ||
 	    (!force_iommu && end_pfn <= MAX_DMA32_PFN) ||
 	    !iommu_aperture ||
diff -r 82f66cc5a33b arch/x86_64/kernel/pci-swiotlb.c
--- a/arch/x86_64/kernel/pci-swiotlb.c	Tue May 23 18:57:22 2006
+++ b/arch/x86_64/kernel/pci-swiotlb.c	Tue May 23 14:05:16 2006
@@ -31,7 +31,7 @@
 void pci_swiotlb_init(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-	if (!iommu_aperture && !no_iommu &&
+	if (!iommu_detected && !no_iommu &&
 	    (end_pfn > MAX_DMA32_PFN || force_iommu))
 	       swiotlb = 1;
 	if (swiotlb) {
diff -r 82f66cc5a33b include/asm-x86_64/proto.h
--- a/include/asm-x86_64/proto.h	Tue May 23 18:57:22 2006
+++ b/include/asm-x86_64/proto.h	Tue May 23 14:05:16 2006
@@ -116,6 +116,7 @@
 extern int acpi_ht;
 extern int acpi_disabled;
 
+extern int iommu_detected;
 #ifdef CONFIG_GART_IOMMU
 extern int fallback_aper_order;
 extern int fallback_aper_force;
