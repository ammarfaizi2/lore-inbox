Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWBFVMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWBFVMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWBFVMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:12:37 -0500
Received: from cantor2.suse.de ([195.135.220.15]:15304 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932073AbWBFVMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:12:36 -0500
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
Date: Mon, 6 Feb 2006 22:11:29 +0100
User-Agent: KMail/1.8.2
Cc: Brian King <brking@us.ibm.com>, "David S. Miller" <davem@davemloft.net>,
       James.Bottomley@steeleye.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com> <43E7613B.5060706@us.ibm.com> <Pine.LNX.4.61.0602061621450.3560@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0602061621450.3560@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602062211.29993.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 17:45, Hugh Dickins wrote:

> 
> But all this presupposes that someone is suddenly going to change the
> x86_64 gart_map_sg (and subfunctions), or else force its iommu=nomerge:
> that won't be me.

Ok i changed it to conform to the gospel. I gave it some basic pounding LTP/dd IO with 
and without IOMMU force, but it's not that well tested. More testing welcome.

-Andi

Don't touch the non DMA members in the sg list in dma_map_sg in the IOMMU

Some drivers (in particular ipr) ran into problems because they
reused the sg lists after passing them to pci_map_sg(). The merging
procedure in the K8 GART IOMMU corrupted the state. This patch
changes it to only touch the dma* entries during merging,
but not the other fields.  Approach suggested by Dave Miller.

I did some basic tests with CONFIG_IOMMU_DEBUG (LTP, large dd) 
and without and it hold up, but needs more testing.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/kernel/pci-gart.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-gart.c
+++ linux/arch/x86_64/kernel/pci-gart.c
@@ -300,7 +300,7 @@ void gart_unmap_sg(struct device *dev, s
 
 	for (i = 0; i < nents; i++) {
 		struct scatterlist *s = &sg[i];
-		if (!s->dma_length || !s->length)
+		if (!s->dma_length)
 			break;
 		dma_unmap_single(dev, s->dma_address, s->dma_length, dir);
 	}
@@ -354,7 +354,6 @@ static int __dma_map_cont(struct scatter
 		
 		BUG_ON(i > start && s->offset);
 		if (i == start) {
-			*sout = *s; 
 			sout->dma_address = iommu_bus_base;
 			sout->dma_address += iommu_page*PAGE_SIZE + s->offset;
 			sout->dma_length = s->length;
@@ -369,7 +368,7 @@ static int __dma_map_cont(struct scatter
 			SET_LEAK(iommu_page);
 			addr += PAGE_SIZE;
 			iommu_page++;
-	} 
+		} 
 	} 
 	BUG_ON(iommu_page - iommu_start != pages);	
 	return 0;
@@ -381,7 +380,6 @@ static inline int dma_map_cont(struct sc
 {
 	if (!need) { 
 		BUG_ON(stopat - start != 1);
-		*sout = sg[start]; 
 		sout->dma_length = sg[start].length; 
 		return 0;
 	} 
