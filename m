Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVCVV4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVCVV4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVCVV4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:56:09 -0500
Received: from fmr24.intel.com ([143.183.121.16]:57824 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262011AbVCVVvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:51:37 -0500
Date: Tue, 22 Mar 2005 13:51:32 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2.4.30-pre3] x86_64: pci_alloc_consistent() match 2.6 implementation
Message-ID: <20050322135132.A18592@unix-os.sc.intel.com>
References: <20050318212344.GC26112@lists.us.dell.com> <20050319192645.GA3937@wotan.suse.de> <20050319221751.GA27863@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050319221751.GA27863@lists.us.dell.com>; from Matt_Domsch@dell.com on Sat, Mar 19, 2005 at 04:17:51PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 04:17:51PM -0600, Matt Domsch wrote:
> OK, then how's this for review?  Compiles clean, can't test it myself
> for a few days.
> 
> -		int high = 0, mmu;
> -		if (((unsigned long)virt_to_bus(memory) + size) > 0xffffffffUL)
> -			high = 1;
> -		mmu = high;
> +		int high = (((unsigned long)virt_to_bus(memory) + size) & ~dma_mask) != 0;
> +		int mmu = high;

Documentation/DMA-mapping.txt says consistent DMA mapping interface will always 
return SAC addressable DMA address. Your patch breaks this behavior.
(Though I don't know the reason why this behavior is expected!)

Appended is a simple 2.4 patch which will sync the behavior with 2.6

thanks,
suresh
--

Sync 2.4 pci_alloc_consistent behavior with 2.6

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>


diff -Nru linux-2.4.29/arch/ia64/lib/swiotlb.c linux-2.4.29-swiotlb/arch/ia64/lib/swiotlb.c
--- linux-2.4.29/arch/ia64/lib/swiotlb.c	2003-08-25 04:44:39.000000000 -0700
+++ linux-2.4.29-swiotlb/arch/ia64/lib/swiotlb.c	2005-03-22 10:51:21.968565920 -0800
@@ -50,13 +50,13 @@
  * Used to do a quick range check in swiotlb_unmap_single and swiotlb_sync_single, to see
  * if the memory was in fact allocated by this API.
  */
-static char *io_tlb_start, *io_tlb_end;
+char *io_tlb_start, *io_tlb_end;
 
 /*
  * The number of IO TLB blocks (in groups of 64) betweeen io_tlb_start and io_tlb_end.
  * This is command line adjustable via setup_io_tlb_npages.
  */
-static unsigned long io_tlb_nslabs = 1024;
+static unsigned long io_tlb_nslabs = 32768;
 
 /*
  * This is a free list describing the number of free entries available from each index
diff -Nru linux-2.4.29/arch/x86_64/kernel/pci-gart.c linux-2.4.29-swiotlb/arch/x86_64/kernel/pci-gart.c
--- linux-2.4.29/arch/x86_64/kernel/pci-gart.c	2004-08-07 16:26:04.000000000 -0700
+++ linux-2.4.29-swiotlb/arch/x86_64/kernel/pci-gart.c	2005-03-22 10:38:45.211610464 -0800
@@ -155,7 +155,7 @@
 	int i;
 	unsigned long iommu_page;
 
-	if (hwdev == NULL || hwdev->dma_mask < 0xffffffff || no_iommu)
+	if (hwdev == NULL || hwdev->dma_mask < 0xffffffff || (no_iommu && !swiotlb))
 		gfp |= GFP_DMA;
 
 	/* 
@@ -174,6 +174,22 @@
 		if (force_mmu && !(gfp & GFP_DMA)) 
 			mmu = 1;
 		if (no_iommu) { 
+#ifdef CONFIG_SWIOTLB
+			if (swiotlb && high && hwdev) {
+				unsigned long dma_mask = 0;
+				if (hwdev->dma_mask == ~0UL) {
+					hwdev->dma_mask = 0xffffffff;
+					dma_mask = ~0UL;
+				}
+				*dma_handle = swiotlb_map_single(hwdev, memory, size,
+						   		 PCI_DMA_FROMDEVICE);
+				if (dma_mask)
+					hwdev->dma_mask = dma_mask;
+				memset(phys_to_virt(*dma_handle), 0, size); 
+				free_pages((unsigned long)memory, get_order(size));
+				return phys_to_virt(*dma_handle);
+			}
+#endif
 			if (high) goto error;
 			mmu = 0; 
 		} 	
@@ -218,8 +234,16 @@
 			 void *vaddr, dma_addr_t bus)
 {
 	unsigned long iommu_page;
-
+ 	extern  char *io_tlb_start, *io_tlb_end;
+ 
 	size = round_up(size, PAGE_SIZE); 
+#ifdef CONFIG_SWIOTLB
+ 	if (swiotlb && vaddr >= (void *)io_tlb_start &&
+ 	    vaddr < (void *)io_tlb_end) {
+ 		swiotlb_unmap_single (hwdev, bus, size, PCI_DMA_TODEVICE);
+ 		return;
+ 	}
+#endif
 	if (bus >= iommu_bus_base && bus < iommu_bus_base + iommu_size) { 
 		unsigned pages = size >> PAGE_SHIFT;
 		iommu_page = (bus - iommu_bus_base) >> PAGE_SHIFT;
