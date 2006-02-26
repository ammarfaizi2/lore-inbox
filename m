Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWBZXrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWBZXrn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWBZXrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:47:42 -0500
Received: from colin.muc.de ([193.149.48.1]:5636 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751428AbWBZXrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:47:42 -0500
Date: 27 Feb 2006 00:47:36 +0100
Date: Mon, 27 Feb 2006 00:47:36 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: largret@gmail.com, 76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: OOM-killer too aggressive?
Message-ID: <20060226234736.GA91959@muc.de>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com> <20060226102152.69728696.akpm@osdl.org> <1140988015.5178.15.camel@shogun.daga.dyndns.org> <20060226133140.4cf05ea5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060226133140.4cf05ea5.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hm, OK.  I suppose we can hit it with the big hammer, but I'd be reluctant
> to merge this patch because it has the potential to hide problems, such as
> the as-yet-unfixed bio-uses-ZONE_DMA one.

Better would be to fix the block layer. I think something like that
would be better: (only lightly tested - it booted on a 6GB x86-64 box) 

It is over pessimistic on systems with real IOMMU that can even remap
to DMA addresses < 4GB - in the future those might want to define
some ARCH_HAS macro so it can be checked here.

Does that patch fix the problem?

That said adding GFP_NORETRY to the floppy allocation is probably still a good
idea. I will do that change here.

-Andi


Disable block layer bouncing for most memory on 64bit systems

The low level PCI DMA mapping functions should handle it in most cases.

This should fix problems with depleting the DMA zone early. The old
code used precious GFP_DMA memory in many cases where it was not needed.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/block/ll_rw_blk.c
===================================================================
--- linux.orig/block/ll_rw_blk.c
+++ linux/block/ll_rw_blk.c
@@ -625,26 +625,32 @@ static inline int ordered_bio_endio(stru
  *    Different hardware can have different requirements as to what pages
  *    it can do I/O directly to. A low level driver can call
  *    blk_queue_bounce_limit to have lower memory pages allocated as bounce
- *    buffers for doing I/O to pages residing above @page. By default
- *    the block layer sets this to the highest numbered "low" memory page.
+ *    buffers for doing I/O to pages residing above @page. 
  **/
 void blk_queue_bounce_limit(request_queue_t *q, u64 dma_addr)
 {
 	unsigned long bounce_pfn = dma_addr >> PAGE_SHIFT;
+	int dma = 0;
 
-	/*
-	 * set appropriate bounce gfp mask -- unfortunately we don't have a
-	 * full 4GB zone, so we have to resort to low memory for any bounces.
-	 * ISA has its own < 16MB zone.
-	 */
-	if (bounce_pfn < blk_max_low_pfn) {
+	q->bounce_gfp = GFP_NOIO;
+#if BITS_PER_LONG == 64
+	/* Assume anything >= 4GB can be handled by IOMMU. 
+	   Actually some IOMMUs can handle everything, but I don't
+	   know of a way to test this here. */
+	if (bounce_pfn < (0xffffffff>>PAGE_SHIFT))
+		dma = 1;
+	q->bounce_pfn = max_low_pfn;
+#else
+	if (bounce_pfn < blk_max_low_pfn)
+		dma = 1;
+	q->bounce_pfn = bounce_pfn;
+#endif
+	if (dma) {	
 		BUG_ON(dma_addr < BLK_BOUNCE_ISA);
 		init_emergency_isa_pool();
 		q->bounce_gfp = GFP_NOIO | GFP_DMA;
-	} else
-		q->bounce_gfp = GFP_NOIO;
-
-	q->bounce_pfn = bounce_pfn;
+		q->bounce_pfn = bounce_pfn;
+	}
 }
 
 EXPORT_SYMBOL(blk_queue_bounce_limit);
