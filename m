Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266597AbUBQVUD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266657AbUBQVUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:20:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20395 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266597AbUBQVOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:14:52 -0500
Message-ID: <40328446.5030805@redhat.com>
Date: Tue, 17 Feb 2004 16:14:46 -0500
From: Jim Paradis <jparadis@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030919
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com, ak@suse.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix fencepost error in x86_64 IOMMU (2.4)
Content-Type: multipart/mixed;
 boundary="------------050004070901040900000208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050004070901040900000208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

There's a fencepost error in the GART IOMMU handling on x86_64
in the unmap path.  When testing to see if the bus address is
within the IOMMU window and needs to be unmapped, the start of
the first page *beyond* the window also passes the test.  This
can cause the first doubleword of the next page beyond the gatt
table to be smashed to zero, with unpredictable results depending
on what that page is used for.

Patch attached for 2.4.  The same problem also exists in 2.6,
for which I'll send a separate patch.


--------------050004070901040900000208
Content-Type: text/plain;
 name="pci-gart-fix-2.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-gart-fix-2.4.patch"

--- linux-2.4.25-rc3/arch/x86_64/kernel/pci-gart.c.orig	2004-02-17 15:21:03.000000000 -0500
+++ linux-2.4.25-rc3/arch/x86_64/kernel/pci-gart.c	2004-02-17 15:23:20.000000000 -0500
@@ -220,7 +220,7 @@ void pci_free_consistent(struct pci_dev 
 	unsigned long iommu_page;
 
 	size = round_up(size, PAGE_SIZE); 
-	if (bus >= iommu_bus_base && bus <= iommu_bus_base + iommu_size) { 
+	if (bus >= iommu_bus_base && bus < iommu_bus_base + iommu_size) { 
 		unsigned pages = size >> PAGE_SHIFT;
 		iommu_page = (bus - iommu_bus_base) >> PAGE_SHIFT;
 		vaddr = __va(GPTE_DECODE(iommu_gatt_base[iommu_page]));
@@ -353,7 +353,7 @@ void pci_unmap_single(struct pci_dev *hw
 	unsigned long iommu_page; 
 	int npages;
 	if (dma_addr < iommu_bus_base + EMERGENCY_PAGES*PAGE_SIZE || 
-	    dma_addr > iommu_bus_base + iommu_size)
+	    dma_addr >= iommu_bus_base + iommu_size)
 		return;
 	iommu_page = (dma_addr - iommu_bus_base)>>PAGE_SHIFT;	
 	npages = round_up(size + (dma_addr & ~PAGE_MASK), PAGE_SIZE) >> PAGE_SHIFT;

--------------050004070901040900000208--

