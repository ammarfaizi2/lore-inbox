Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266600AbUBQVWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266652AbUBQVUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:20:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46765 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266654AbUBQVSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:18:44 -0500
Message-ID: <40328530.2000303@redhat.com>
Date: Tue, 17 Feb 2004 16:18:40 -0500
From: Jim Paradis <jparadis@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030919
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix fencepost error in x86_64 IOMMU (2.6)
Content-Type: multipart/mixed;
 boundary="------------010205020501060402060207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010205020501060402060207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

There's a fencepost error in the GART IOMMU handling on x86_64
in the unmap path.  When testing to see if the bus address is
within the IOMMU window and needs to be unmapped, the start of
the first page *beyond* the window also passes the test.  This
can cause the first doubleword of the next page beyond the gatt
table to be smashed to zero, with unpredictable results depending
on what that page is used for.

Patch attached for 2.6.  2.4 patch already sent separately.

--------------010205020501060402060207
Content-Type: text/plain;
 name="pci-gart-fix-2.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-gart-fix-2.6.patch"

--- linux-2.6.3-rc4/arch/x86_64/kernel/pci-gart.c.orig	2004-02-17 15:31:25.000000000 -0500
+++ linux-2.6.3-rc4/arch/x86_64/kernel/pci-gart.c	2004-02-17 15:33:13.000000000 -0500
@@ -521,7 +521,7 @@ void pci_unmap_single(struct pci_dev *hw
 	int npages;
 	int i;
 	if (dma_addr < iommu_bus_base + EMERGENCY_PAGES*PAGE_SIZE || 
-	    dma_addr > iommu_bus_base + iommu_size)
+	    dma_addr >= iommu_bus_base + iommu_size)
 		return;
 	iommu_page = (dma_addr - iommu_bus_base)>>PAGE_SHIFT;	
 	npages = to_pages(dma_addr, size);

--------------010205020501060402060207--

