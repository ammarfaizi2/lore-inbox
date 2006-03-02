Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWCBOOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWCBOOm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 09:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWCBOOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 09:14:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30472 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751271AbWCBOOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 09:14:41 -0500
Date: Thu, 2 Mar 2006 15:14:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Michael Monnerie <m.monnerie@zmi.at>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Message-ID: <20060302141412.GT4329@suse.de>
References: <200603020023.21916@zmi.at> <200603021446.46352.ak@suse.de> <20060302134918.GR4329@suse.de> <200603021458.02934.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603021458.02934.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02 2006, Andi Kleen wrote:
> On Thursday 02 March 2006 14:49, Jens Axboe wrote:
> > On Thu, Mar 02 2006, Andi Kleen wrote:
> > > On Thursday 02 March 2006 14:33, Jens Axboe wrote:
> > > 
> > > > Hmm I would have guessed the first is way more common, the device/driver
> > > > consuming lots of iommu space would be the most likely to run into
> > > > IOMMU-OOM.
> > > 
> > > e.g. consider a simple RAID-1. It will always map the requests twice so the 
> > > normal case is 2 times as much IOMMU space needed. Or even more with bigger 
> > > raids.
> > > 
> > > But you're right of course that only waiting for one user would be likely
> > > sufficient. e.g. even if it misses some freeing events the "current" device
> > > should eventually free some space too.
> > > 
> > > On the other hand it would seem cleaner to me to solve it globally
> > > instead of trying to hack around it in the higher layers.
> > 
> > But I don't think that's really possible.
> 
> Wasn't this whole thread about making it possible?

Sorry, what I mean is that I don't think it solvable in the normal
dma_map_sg() path. You have to punt and allow the upper layer to wait.

> > As Jeff points out, SCSI can't 
> > do this right now because of the way we map requests.
> 
> Sure you have to punt out outside this spinlock and then find
> a "safe place" as you put it to wait. The low level IOMMU code
> would supply the wakeup.

Precisely.

> > And it would be a 
> > shame to change the hot path because of the error case. And then you
> > have things like networking and other block drivers - it would be a big
> > audit/fixup to make that work.
> > 
> > It's much easier to extend the dma mapping api to have an error
> > fallback.
> 
> It already has one (pci_map_sg returning 0 or pci_mapping_error()
> for pci_map_single()) 

Yeah we can signal the error in map_sg() with 0, that's not what I
meant. I meant adding a way to handle that error, not signal it. Which
is the wait stuff we are discussing.

> The problem is just that when you get it you can only error out
> because there is no way to wait for a free space event. With
> your help I've been trying to figure out how to add it. Of course
> after that's done you still have to do the work to handle 
> it in the block layer somewhere.

Yes that's the issue. We can have a defer helper in the block layer that
could reinvoke the request handling when we _hope_ it'll work. That's
already in place, the driver does a BLKPREP_DEFER for that case. For
drivers that don't use the prep handler, we can do something very
similar.

> > > > I was thinking just a global one, we are in soft error handling anyways
> > > > so should be ok. I don't think you would need to dirty any global cache
> > > > line unless you actually need to wake waiters.
> > > 
> > > __wake_up takes the spinlock even when nobody waits.
> > 
> > I would not want to call wake_up() unless I have to. Would a
> > 
> >         smp_mb();
> >         if (waitqueue_active(&iommu_wq))
> >                 ...
> > 
> > not be sufficient?
> 
> Probably, but one would need to be careful to not miss events this way.

Definitely, as far as I can see the above should be enough...

-- 
Jens Axboe

