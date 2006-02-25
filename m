Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWBYGo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWBYGo5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 01:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWBYGo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 01:44:57 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:1168 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932357AbWBYGo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 01:44:57 -0500
Date: Sat, 25 Feb 2006 01:41:40 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Kernel panic when compiling with SMP support
To: "largret@gmail.com" <largret@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602250144_MC3-1-B93A-63E9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1140732949.5733.13.camel@shogun.daga.dyndns.org>

On Thu, 23 Feb 2006 at 14:15:49 -0800, Chris Largret wrote:

> While tinkering with this the last couple days, I've started to notice
> that the infamous OOM killer is running loose when I enable SMP. dmesg
> is filled with messages like this (this is from the boot-up scripts and
> I should have more than enough memory):
> 
> 
> oom-killer: gfp_mask=0xd1, order=3
> 
> Call Trace: <ffffffff8104ed46>{out_of_memory+58}
> <ffffffff8104ff30>{__alloc_pages+534}
>        <ffffffff8104ffee>{__get_free_pages+48} <ffffffff8117d8e9>{dma_mem_alloc+31}
>        <ffffffff81183e70>{floppy_open+348} <ffffffff81072125>{do_open+172}
>        <ffffffff810724b4>{blkdev_open+0} <ffffffff810724dc>{blkdev_open

 It wants 32K of contiguous DMA memory.  You have 44K free but it's probably
not contiguous.

 Maybe this patch from Jens Axboe would help?

=============================================================================

Can you give this a shot? Untested, as I cannot reproduce it here.

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 41387f5..a6cfe7d 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -631,21 +631,15 @@ static inline int ordered_bio_endio(stru
  **/
 void blk_queue_bounce_limit(request_queue_t *q, u64 dma_addr)
 {
-	unsigned long bounce_pfn = dma_addr >> PAGE_SHIFT;
+	q->bounce_gfp = GFP_NOIO;
 
-	/*
-	 * set appropriate bounce gfp mask -- unfortunately we don't have a
-	 * full 4GB zone, so we have to resort to low memory for any bounces.
-	 * ISA has its own < 16MB zone.
-	 */
-	if (bounce_pfn < blk_max_low_pfn) {
-		BUG_ON(dma_addr < BLK_BOUNCE_ISA);
+	if (dma_addr < ISA_DMA_THRESHOLD) {
 		init_emergency_isa_pool();
-		q->bounce_gfp = GFP_NOIO | GFP_DMA;
-	} else
-		q->bounce_gfp = GFP_NOIO;
+		q->bounce_gfp |= GFP_DMA;
+	} else if (dma_addr < DMA_32BIT_MASK)
+		q->bounce_gfp |= GFP_DMA32;
 
-	q->bounce_pfn = bounce_pfn;
+	q->bounce_pfn = dma_addr >> PAGE_SHIFT;
 }
 
 EXPORT_SYMBOL(blk_queue_bounce_limit);
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
