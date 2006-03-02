Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751982AbWCBKqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbWCBKqa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 05:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWCBKqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 05:46:30 -0500
Received: from mailgate.terastack.com ([195.173.195.66]:6411 "EHLO
	uk-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1751982AbWCBKqa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 05:46:30 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Date: Thu, 2 Mar 2006 10:46:26 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C270393C1BF@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Thread-Index: AcY9SOtnqzlIuISLQOWq8ayJ4905CAAnSMMA
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Andi Kleen" <ak@suse.de>, "Anton Altaparmakov" <aia21@cam.ac.uk>,
       "Andrew Morton" <akpm@osdl.org>, <davej@redhat.com>,
       <linux-kernel@vger.kernel.org>, <lwoodman@redhat.com>,
       "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Mar 01 2006, Andy Chittenden wrote:
> > > On Wed, Mar 01 2006, Andi Kleen wrote:
> > > > On Wednesday 01 March 2006 15:34, Jens Axboe wrote:
> > > > 
> > > > 
> > > > > > It shouldn't end up with more, only with less.
> > > > > 
> > > > > Sure yes, but if that 'less' is still more than what the 
> > > driver can
> > > > > handle, then there's a problem.
> > > > 
> > > > The driver needs to handle the full list it passed in. 
> It's quite
> > > > possible that the iommu layer is unable to merge anything.
> > > > 
> > > > 
> > > > This isn't the block layer based merging where we guarantee
> > > > to be able to merge in advance - just lazy after the 
> fact merging.
> > > 
> > > Yes I realize that, I wonder if the bounce patch screwed 
> something up
> > > that destroys the block layer merging/accounting. We'll 
> know when Andy
> > > posts results that dump the request as well.
> > 
> > And here's the dmesg o/p (I had to gather it from 
> /var/log/kern.log as
> > there was so much output):
> 
> Thanks!
> 
> > hda: DMA table too small
> > ide dma table, 256 entries, bounce pfn 1310720
> > sg0: dma=830e800, len=4096/0, pfn=1202633
> > sg1: dma=830f800, len=4096/0, pfn=1202590
> > sg2: dma=8310800, len=4096/0, pfn=1202548
> > sg3: dma=8311800, len=4096/0, pfn=1202506
> 
> Alright Andi, take a look at this then. We have the same thing again,
> mid page start of the sg entries. The block layer has done no merging,
> it's 256 separate segments. The pci_map_sg() output is the 
> same, except
> that the IDE driver now needs to split the entries. The 
> corresponding rq
> entries for the first four above are:
> 
> > request: phys seg 256, hw seg 256, nr_sectors 2048
> >   bio0: bytes=4096, phys seg 1, hw seg 1
> >     bvec0: addr=ffff8101259c9000, size=4096, off=0
> >   bio1: bytes=4096, phys seg 1, hw seg 1
> >     bvec0: addr=ffff81012599e000, size=4096, off=0
> >   bio2: bytes=4096, phys seg 1, hw seg 1
> >     bvec0: addr=ffff810125974000, size=4096, off=0
> >   bio3: bytes=4096, phys seg 1, hw seg 1
> >     bvec0: addr=ffff81012594a000, size=4096, off=0
> 
> these here. Totally plain 4kb bios strung to the request, no funky
> offsets or anything. 256 hardware and physical segments, for 
> a total of
> a 1MB request.
> 
> So what is going wrong? Why does the pci mapping output looks so
> "strange"?
> 
> -- 
> Jens Axboe
> 

So, what's the story? Apart from the performance implications, one thing
that does concern me is whether this could cause corruptions on disk as
it appears a cross-page write is being attempted.

-- 
Andy, BlueArc Engineering 
