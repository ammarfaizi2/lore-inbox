Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286137AbRLJTWd>; Mon, 10 Dec 2001 14:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286184AbRLJTWW>; Mon, 10 Dec 2001 14:22:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22535 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286301AbRLJTWJ>;
	Mon, 10 Dec 2001 14:22:09 -0500
Date: Mon, 10 Dec 2001 20:21:30 +0100
From: Jens Axboe <axboe@suse.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: LBJM <LB33JM16@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
Message-ID: <20011210192130.GE12200@suse.de>
In-Reply-To: <3C1410BB.6884E52F@yahoo.com> <200112101840.fBAIeTg53340@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200112101840.fBAIeTg53340@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10 2001, Justin T. Gibbs wrote:
> >When I upgraded to 2gigs of ram I was using 2.4.10 then used 2.4.14 and
> >2.4.16 each did a kernel panic. however none do it with highmem off.
> 
> I am still investigating the cause of this particular problem.  In
> fact we are building up a new system today in the hope of being able
> to reproduce and solve this problem.

Ok I decided to try and trace this. You se sg_tablesize go AHC_NSEG, so
the SCSI mid layer merging functions will at best create a AHC_NSEG
sized request for you. So far, so good. Now, aic7xxx queuer is entered,
and eventually we end up in ahc_linux_run_device_queue to process the
queued scsi_cmnd. You call pci_map_sg on the supplied scatter gather
list, which returns nseg amount of segments. On x86 nseg will equal the
scatter gather members initially created (no iommu to do funky tricks),
so for our test case here nseg still equals AHC_NSEG. Now you build and
map the segments, the jist of that loop is something ala

	
		/*
		 * The sg_count may be larger than nseg if
		 * a transfer crosses a 32bit page.
		 */ 

hmm, here it already starts to smell fishy...

		scb->sg_count = 0;
		while(cur_seg < end_seg) {
			bus_addr_t addr;
			bus_size_t len;
			int consumed;

			addr = sg_dma_address(cur_seg);
			len = sg_dma_len(cur_seg);
			consumed = ahc_linux_map_seg(ahc, scb, sg, addr, len);

ahc_linux_map_seg checks if scb->sg_count gets bigger than AHC_NSEG, in
fact the test is

	if (scb->sg_count + 1 > AHC_NSEC)
		panic()

What am I missing here?? I see nothing preventing hitting this panic in
some circumstances.

	if (scb->sg_count + 2 > AHC_NSEG)
		panic()

weee, we crossed a 4gb boundary and suddenly we have bigger problems
yet. Ok, so what I think the deal is here is that AHC_NSEG are two
different things to your driver and the mid layer.

Am I missing something? It can't be this obvious.


-- 
Jens Axboe

