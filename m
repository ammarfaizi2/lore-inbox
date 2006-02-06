Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWBFWK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWBFWK1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWBFWK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:10:26 -0500
Received: from gold.veritas.com ([143.127.12.110]:64566 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932182AbWBFWK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:10:26 -0500
Date: Mon, 6 Feb 2006 22:11:09 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>, Ryan Richter <ryan@tau.solarneutrino.net>
cc: Brian King <brking@us.ibm.com>, "David S. Miller" <davem@davemloft.net>,
       James.Bottomley@steeleye.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
In-Reply-To: <200602062211.29993.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0602062154430.3652@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com>
 <43E7613B.5060706@us.ibm.com> <Pine.LNX.4.61.0602061621450.3560@goblin.wat.veritas.com>
 <200602062211.29993.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Feb 2006 22:10:25.0517 (UTC) FILETIME=[217F81D0:01C62B6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Andi Kleen wrote:
> On Monday 06 February 2006 17:45, Hugh Dickins wrote:
> > 
> > But all this presupposes that someone is suddenly going to change the
> > x86_64 gart_map_sg (and subfunctions), or else force its iommu=nomerge:
> > that won't be me.
> 
> Ok i changed it to conform to the gospel. I gave it some basic pounding LTP/dd IO with 
> and without IOMMU force, but it's not that well tested. More testing welcome.

Great, thanks Andi.  One small correction to the comment...

> Don't touch the non DMA members in the sg list in dma_map_sg in the IOMMU
> 
> Some drivers (in particular ipr) ran into problems because they

No, the problem hasn't knowingly been sighted on ipr, it was the
st driver that Ryan's been seeing it with - ipr just came from
my looking around for like instances.

> reused the sg lists after passing them to pci_map_sg(). The merging
> procedure in the K8 GART IOMMU corrupted the state. This patch
> changes it to only touch the dma* entries during merging,
> but not the other fields.  Approach suggested by Dave Miller.
> 
> I did some basic tests with CONFIG_IOMMU_DEBUG (LTP, large dd) 
> and without and it hold up, but needs more testing.

Below is, I think, the 2.6.15 equivalent of the patch Andi posted.
Ryan cannot effectively test Andi's patch on 2.6.16-rc because Mike
Christie's scsi_execute_async changes have serendipitously fixed
the st instance.  Ryan, would you be able to test the patch below
on 2.6.15 without my st.c,st.h patch?

But I fear Ryan may be growing a little tired of this surfeit
of fixes: he's waited months for one, now he's been given one
workaround and three fixes.

Thanks,
Hugh

--- 2.6.15/arch/x86_64/kernel/pci-gart.c	2006-01-03 03:21:10.000000000 +0000
+++ linux/arch/x86_64/kernel/pci-gart.c	2006-02-06 21:33:17.000000000 +0000
@@ -477,7 +477,6 @@ static int __dma_map_cont(struct scatter
 		
 		BUG_ON(i > start && s->offset);
 		if (i == start) {
-			*sout = *s; 
 			sout->dma_address = iommu_bus_base;
 			sout->dma_address += iommu_page*PAGE_SIZE + s->offset;
 			sout->dma_length = s->length;
@@ -492,7 +491,7 @@ static int __dma_map_cont(struct scatter
 			SET_LEAK(iommu_page);
 			addr += PAGE_SIZE;
 			iommu_page++;
-	} 
+		} 
 	} 
 	BUG_ON(iommu_page - iommu_start != pages);	
 	return 0;
@@ -504,7 +503,6 @@ static inline int dma_map_cont(struct sc
 {
 	if (!need) { 
 		BUG_ON(stopat - start != 1);
-		*sout = sg[start]; 
 		sout->dma_length = sg[start].length; 
 		return 0;
 	} 
@@ -622,7 +620,7 @@ void dma_unmap_sg(struct device *dev, st
 	}
 	for (i = 0; i < nents; i++) { 
 		struct scatterlist *s = &sg[i];
-		if (!s->dma_length || !s->length) 
+		if (!s->dma_length) 
 			break;
 		dma_unmap_single(dev, s->dma_address, s->dma_length, dir);
 	}
