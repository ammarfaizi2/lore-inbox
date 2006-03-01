Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWCAP6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWCAP6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 10:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWCAP6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 10:58:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56900 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030214AbWCAP6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 10:58:15 -0500
Date: Wed, 1 Mar 2006 16:57:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Chittenden <AChittenden@bluearc.com>
Cc: Andi Kleen <ak@suse.de>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org, lwoodman@redhat.com,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060301155740.GB4816@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270393C141@uk-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89E85E0168AD994693B574C80EDB9C270393C141@uk-email.terastack.bluearc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01 2006, Andy Chittenden wrote:
> > On Wed, Mar 01 2006, Andi Kleen wrote:
> > > On Wednesday 01 March 2006 15:34, Jens Axboe wrote:
> > > 
> > > 
> > > > > It shouldn't end up with more, only with less.
> > > > 
> > > > Sure yes, but if that 'less' is still more than what the 
> > driver can
> > > > handle, then there's a problem.
> > > 
> > > The driver needs to handle the full list it passed in. It's quite
> > > possible that the iommu layer is unable to merge anything.
> > > 
> > > 
> > > This isn't the block layer based merging where we guarantee
> > > to be able to merge in advance - just lazy after the fact merging.
> > 
> > Yes I realize that, I wonder if the bounce patch screwed something up
> > that destroys the block layer merging/accounting. We'll know when Andy
> > posts results that dump the request as well.
> 
> And here's the dmesg o/p (I had to gather it from /var/log/kern.log as
> there was so much output):

Thanks!

> hda: DMA table too small
> ide dma table, 256 entries, bounce pfn 1310720
> sg0: dma=830e800, len=4096/0, pfn=1202633
> sg1: dma=830f800, len=4096/0, pfn=1202590
> sg2: dma=8310800, len=4096/0, pfn=1202548
> sg3: dma=8311800, len=4096/0, pfn=1202506

Alright Andi, take a look at this then. We have the same thing again,
mid page start of the sg entries. The block layer has done no merging,
it's 256 separate segments. The pci_map_sg() output is the same, except
that the IDE driver now needs to split the entries. The corresponding rq
entries for the first four above are:

> request: phys seg 256, hw seg 256, nr_sectors 2048
>   bio0: bytes=4096, phys seg 1, hw seg 1
>     bvec0: addr=ffff8101259c9000, size=4096, off=0
>   bio1: bytes=4096, phys seg 1, hw seg 1
>     bvec0: addr=ffff81012599e000, size=4096, off=0
>   bio2: bytes=4096, phys seg 1, hw seg 1
>     bvec0: addr=ffff810125974000, size=4096, off=0
>   bio3: bytes=4096, phys seg 1, hw seg 1
>     bvec0: addr=ffff81012594a000, size=4096, off=0

these here. Totally plain 4kb bios strung to the request, no funky
offsets or anything. 256 hardware and physical segments, for a total of
a 1MB request.

So what is going wrong? Why does the pci mapping output looks so
"strange"?

-- 
Jens Axboe

