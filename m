Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286364AbRLJTvg>; Mon, 10 Dec 2001 14:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286365AbRLJTvR>; Mon, 10 Dec 2001 14:51:17 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:51986 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S286364AbRLJTvE>; Mon, 10 Dec 2001 14:51:04 -0500
Message-Id: <200112101950.fBAJoxg54527@aslan.scsiguy.com>
To: Jens Axboe <axboe@suse.de>
cc: LBJM <LB33JM16@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping 
In-Reply-To: Your message of "Mon, 10 Dec 2001 20:21:30 +0100."
             <20011210192130.GE12200@suse.de> 
Date: Mon, 10 Dec 2001 12:50:59 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ok I decided to try and trace this.

...

>		/*
>		 * The sg_count may be larger than nseg if
>		 * a transfer crosses a 32bit page.
>		 */ 
>
>hmm, here it already starts to smell fishy...
>
>		scb->sg_count = 0;
>		while(cur_seg < end_seg) {
>			bus_addr_t addr;
>			bus_size_t len;
>			int consumed;
>
>			addr = sg_dma_address(cur_seg);
>			len = sg_dma_len(cur_seg);
>			consumed = ahc_linux_map_seg(ahc, scb, sg, addr, len);
>
>ahc_linux_map_seg checks if scb->sg_count gets bigger than AHC_NSEG, in
>fact the test is
>
>	if (scb->sg_count + 1 > AHC_NSEC)
>		panic()
>
>What am I missing here?? I see nothing preventing hitting this panic in
>some circumstances.

If you don't cross a 4GB boundary, this is the same as a static test
that you never have more than AHC_NSEG segments.

>	if (scb->sg_count + 2 > AHC_NSEG)
>		panic()
>
>weee, we crossed a 4gb boundary and suddenly we have bigger problems
>yet. Ok, so what I think the deal is here is that AHC_NSEG are two
>different things to your driver and the mid layer.
>
>Am I missing something? It can't be this obvious.

You will never cross a 4GB boundary on a machine with only 2GB of
physical memory.  This report and another I have received are for
configurations with 2GB or less memory.  This is not the cause of the
problem.  Further, after this code was written, David Miller made the
comment that an I/O that crosses a 4GB boundary will never be generated
for the exact same reason that this check is included in the aic7xxx
driver - you can't cross a 4GB page in a single PCI DAC transaction.  
I should go verify that this is really the case in recent 2.4.X kernels.

Saying that AHC_NSEG and the segment count exported to the mid-layer are
too differnt things is true to some extent, but if the 4GB rule is not
honored by the mid-layer implicitly, I would have to tell the mid-layer
I can only handle half the number of segments I really can.  This isn't
good for the memory footprint of the driver.  The test was added to
protect against a situation that I don't believe can now happen in Linux.

In truth, the solution to these kinds of problems is to export alignment,
boundary, and range restrictions on memory mappings from the device
driver to the layer creating the mappings.  This is the only way to
generically allow a device driver to export a true segment limit.

--
Justin
