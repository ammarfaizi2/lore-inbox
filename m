Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286367AbRLJUEq>; Mon, 10 Dec 2001 15:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286368AbRLJUEi>; Mon, 10 Dec 2001 15:04:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45576 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286367AbRLJUE2>;
	Mon, 10 Dec 2001 15:04:28 -0500
Date: Mon, 10 Dec 2001 21:03:02 +0100
From: Jens Axboe <axboe@suse.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: LBJM <LB33JM16@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
Message-ID: <20011210200302.GA13498@suse.de>
In-Reply-To: <20011210192130.GE12200@suse.de> <200112101950.fBAJoxg54527@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200112101950.fBAJoxg54527@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10 2001, Justin T. Gibbs wrote:
> >ahc_linux_map_seg checks if scb->sg_count gets bigger than AHC_NSEG, in
> >fact the test is
> >
> >	if (scb->sg_count + 1 > AHC_NSEC)
> >		panic()
> >
> >What am I missing here?? I see nothing preventing hitting this panic in
> >some circumstances.
> 
> If you don't cross a 4GB boundary, this is the same as a static test
> that you never have more than AHC_NSEG segments.

Yes sorry, my one-off.

> >	if (scb->sg_count + 2 > AHC_NSEG)
> >		panic()
> >
> >weee, we crossed a 4gb boundary and suddenly we have bigger problems
> >yet. Ok, so what I think the deal is here is that AHC_NSEG are two
> >different things to your driver and the mid layer.
> >
> >Am I missing something? It can't be this obvious.
> 
> You will never cross a 4GB boundary on a machine with only 2GB of
> physical memory.  This report and another I have received are for

Of course not.

> configurations with 2GB or less memory.  This is not the cause of the
> problem.  Further, after this code was written, David Miller made the
> comment that an I/O that crosses a 4GB boundary will never be generated
> for the exact same reason that this check is included in the aic7xxx
> driver - you can't cross a 4GB page in a single PCI DAC transaction.  
> I should go verify that this is really the case in recent 2.4.X kernels.

Right, we decided against ever doing that. In fact I added the very code
to do this in the block-highmem series -- however, this assumption
breaks down in the current 2.4 afair on 64-bit archs.

> Saying that AHC_NSEG and the segment count exported to the mid-layer are
> too differnt things is true to some extent, but if the 4GB rule is not
> honored by the mid-layer implicitly, I would have to tell the mid-layer
> I can only handle half the number of segments I really can.  This isn't
> good for the memory footprint of the driver.  The test was added to
> protect against a situation that I don't believe can now happen in Linux.

> In truth, the solution to these kinds of problems is to export alignment,
> boundary, and range restrictions on memory mappings from the device
> driver to the layer creating the mappings.  This is the only way to
> generically allow a device driver to export a true segment limit.

I agree, and that is why I've already included code to do just that in
2.5.

-- 
Jens Axboe

