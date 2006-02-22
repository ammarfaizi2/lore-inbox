Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWBVNe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWBVNe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 08:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWBVNe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 08:34:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45851 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751023AbWBVNeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 08:34:25 -0500
Date: Wed, 22 Feb 2006 14:34:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Chittenden <AChittenden@bluearc.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060222133409.GY8852@suse.de>
References: <89E85E0168AD994693B574C80EDB9C2703758C89@uk-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89E85E0168AD994693B574C80EDB9C2703758C89@uk-email.terastack.bluearc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22 2006, Andy Chittenden wrote:
> Jens
> 
> > On Fri, Feb 03 2006, Andy Chittenden wrote:
> > > Which brings me back to the original problem I reported: 
> > any progress on
> > > a patch for that? FYI I often come in the morning to find processes
> > > killed.
> > 
> > Nope sorry, I'll probably get to it at the start of next week.
> > 
> > -- 
> > Jens Axboe
> > 
> 
> Any progress? This is getting very irritating especially when processes
> get killed during the day when I link a big executable.

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
Jens Axboe

