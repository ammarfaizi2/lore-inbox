Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVCSWSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVCSWSc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 17:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVCSWSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 17:18:13 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:15192 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261872AbVCSWRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 17:17:52 -0500
X-IronPort-AV: i="3.91,104,1110175200"; 
   d="scan'208"; a="217854166:sNHT24020620"
Date: Sat, 19 Mar 2005 16:17:51 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2.4.30-pre3] x86_64: pci_alloc_consistent() match 2.6 implementation
Message-ID: <20050319221751.GA27863@lists.us.dell.com>
References: <20050318212344.GC26112@lists.us.dell.com> <20050319192645.GA3937@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319192645.GA3937@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 08:26:45PM +0100, Andi Kleen wrote:
> On Fri, Mar 18, 2005 at 03:23:44PM -0600, Matt Domsch wrote:
> > For review and comment.
> > 
> > On x86_64 systems with no IOMMU and with >4GB RAM (in fact, whenever
> > there are any pages mapped above 4GB), pci_alloc_consistent() falls
> > back to using ZONE_DMA for all allocations, even if the device's
> > dma_mask could have supported using memory from other zones.  Problems
> > can be seen when other ZONE_DMA users (SWIOTLB, scsi_malloc()) consume
> > all of ZONE_DMA, leaving none left for pci_alloc_consistent() use.
> > 
> > Patch below makes pci_alloc_consistent() for the nommu case (EM64T
> > processors) match the 2.6 implementation of dma_alloc_coherent(), with
> > the exception that this continues to use GFP_ATOMIC.
> 
> You fixed the wrong code. The pci-nommu code is only used
> when IOMMU is disabled in the Kconfig. But most kernels have
> it enabled. You would need to change it in pci-gart.c too.

OK, then how's this for review?  Compiles clean, can't test it myself
for a few days.

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== arch/x86_64/kernel/pci-gart.c 1.12 vs edited =====
--- 1.12/arch/x86_64/kernel/pci-gart.c	2004-06-03 05:29:36 -05:00
+++ edited/arch/x86_64/kernel/pci-gart.c	2005-03-19 15:56:34 -06:00
@@ -154,27 +154,37 @@ void *pci_alloc_consistent(struct pci_de
 	int gfp = GFP_ATOMIC;
 	int i;
 	unsigned long iommu_page;
+	dma_addr_t dma_mask;
 
-	if (hwdev == NULL || hwdev->dma_mask < 0xffffffff || no_iommu)
+	if (hwdev == NULL || hwdev->dma_mask < 0xffffffff)
 		gfp |= GFP_DMA;
 
+	dma_mask = hwdev ? hwdev->dma_mask : 0xffffffffULL;
+	if (dma_mask == 0)
+		dma_mask = 0xffffffffULL;
+
 	/* 
-	 * First try to allocate continuous and use directly if already 
-	 * in lowmem. 
+	 * First try to allocate continuous and use directly if
+	 * our device supports it
 	 */ 
 	size = round_up(size, PAGE_SIZE); 
+ again:
 	memory = (void *)__get_free_pages(gfp, get_order(size));
 	if (memory == NULL) {
 		return NULL; 
 	} else {
-		int high = 0, mmu;
-		if (((unsigned long)virt_to_bus(memory) + size) > 0xffffffffUL)
-			high = 1;
-		mmu = high;
+		int high = (((unsigned long)virt_to_bus(memory) + size) & ~dma_mask) != 0;
+		int mmu = high;
 		if (force_mmu && !(gfp & GFP_DMA)) 
 			mmu = 1;
 		if (no_iommu) { 
-			if (high) goto error;
+			if (high && (gfp & GFP_DMA))
+				goto error;
+			if (high) {
+				free_pages((unsigned long)memory, get_order(size));
+				gfp |= GFP_DMA;
+				goto again;
+			}
 			mmu = 0; 
 		} 	
 		memset(memory, 0, size); 
