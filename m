Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVCRVXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVCRVXz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 16:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVCRVXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 16:23:54 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:57905 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261368AbVCRVXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 16:23:47 -0500
X-IronPort-AV: i="3.91,102,1110175200"; 
   d="scan'208"; a="217681737:sNHT22789844"
Date: Fri, 18 Mar 2005 15:23:44 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: ak@suse.de, linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: [PATCH 2.4.30-pre3] x86_64: pci_alloc_consistent() match 2.6 implementation
Message-ID: <20050318212344.GC26112@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For review and comment.

On x86_64 systems with no IOMMU and with >4GB RAM (in fact, whenever
there are any pages mapped above 4GB), pci_alloc_consistent() falls
back to using ZONE_DMA for all allocations, even if the device's
dma_mask could have supported using memory from other zones.  Problems
can be seen when other ZONE_DMA users (SWIOTLB, scsi_malloc()) consume
all of ZONE_DMA, leaving none left for pci_alloc_consistent() use.

Patch below makes pci_alloc_consistent() for the nommu case (EM64T
processors) match the 2.6 implementation of dma_alloc_coherent(), with
the exception that this continues to use GFP_ATOMIC.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--- linux-2.4/arch/x86_64/kernel/pci-nommu.c	Fri Feb 25 13:01:44 2005
+++ linux-2.4/arch/x86_64/kernel/pci-nommu.c	Fri Feb 25 06:56:55 2005
@@ -13,18 +13,28 @@ void *pci_alloc_consistent(struct pci_de
 			   dma_addr_t *dma_handle)
 {
 	void *ret;
+	u64 mask;
+	int order = get_order(size);
 	int gfp = GFP_ATOMIC;
-	
-	if (hwdev == NULL ||
-	    end_pfn > (hwdev->dma_mask>>PAGE_SHIFT) ||  /* XXX */
-	    (u32)hwdev->dma_mask < 0xffffffff)
-		gfp |= GFP_DMA;
-	ret = (void *)__get_free_pages(gfp, get_order(size));
 
-	if (ret != NULL) {
-		memset(ret, 0, size);
+	if (hwdev)
+		mask = hwdev->dma_mask;
+	else
+		mask = 0xffffffffULL;
+
+	for (;;) {
+		ret = (void *)__get_free_pages(gfp, order);
+		if (ret == NULL)
+			return NULL;
 		*dma_handle = virt_to_bus(ret);
+		if ((*dma_handle & ~mask) == 0)
+			break;
+		free_pages((unsigned long)ret, order);
+		if (gfp & GFP_DMA)
+			return NULL;
+		gfp |= GFP_DMA;
 	}
+	memset(ret, 0, size);
 	return ret;
 }
 
