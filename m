Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261989AbREURyT>; Mon, 21 May 2001 13:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261995AbREURyJ>; Mon, 21 May 2001 13:54:09 -0400
Received: from are.twiddle.net ([64.81.246.98]:27776 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S261989AbREURx5>;
	Mon, 21 May 2001 13:53:57 -0400
Date: Mon, 21 May 2001 10:53:39 -0700
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521105339.A1907@twiddle.net>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521115631.I30738@athlon.random> <15112.59880.127047.315855@pizda.ninka.net> <20010521125032.K30738@athlon.random> <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random> <20010521155151.A10403@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010521155151.A10403@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Mon, May 21, 2001 at 03:51:51PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 03:51:51PM +0400, Ivan Kokshaysky wrote:
> I'm unable reproduce it with *8Mb* window, so I'm asking.

Me either.  But Tom Vier, the guy who started this thread
was able to use up the 8MB.  Which is completely believable.

The following should aleviate the situation on these smaller
machines where the direct map does cover all physical memory.
Really, we were failing gratuitously before.

On Tsunami and Titan, espectially with more than 4G ram we
should probably just go ahead and allocate the 512M or 1G
scatter-gather arena.

(BTW, Andrea, it's easy enough to work around the Cypress
problem by marking the last 1M of the 1G arena in use.)


r~



diff -ruNp linux/arch/alpha/kernel/pci_iommu.c linux-new/arch/alpha/kernel/pci_iommu.c
--- linux/arch/alpha/kernel/pci_iommu.c	Fri Mar  2 11:12:07 2001
+++ linux-new/arch/alpha/kernel/pci_iommu.c	Mon May 21 01:25:25 2001
@@ -402,8 +402,20 @@ sg_fill(struct scatterlist *leader, stru
 	paddr &= ~PAGE_MASK;
 	npages = calc_npages(paddr + size);
 	dma_ofs = iommu_arena_alloc(arena, npages);
-	if (dma_ofs < 0)
-		return -1;
+	if (dma_ofs < 0) {
+		/* If we attempted a direct map above but failed, die.  */
+		if (leader->dma_address == 0)
+			return -1;
+
+		/* Otherwise, break up the remaining virtually contiguous
+		   hunks into individual direct maps.  */
+		for (sg = leader; sg < end; ++sg)
+			if (sg->dma_address == 2 || sg->dma_address == -2)
+				sg->dma_address = 0;
+
+		/* Retry.  */
+		return sg_fill(leader, end, out, arena, max_dma);
+	}
 
 	out->dma_address = arena->dma_base + dma_ofs*PAGE_SIZE + paddr;
 	out->dma_length = size;
