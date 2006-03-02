Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWCBOFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWCBOFX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 09:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWCBOFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 09:05:23 -0500
Received: from ns1.suse.de ([195.135.220.2]:54758 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751073AbWCBOFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 09:05:22 -0500
From: Andi Kleen <ak@suse.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Thu, 2 Mar 2006 14:58:02 +0100
User-Agent: KMail/1.9.1
Cc: Michael Monnerie <m.monnerie@zmi.at>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
References: <200603020023.21916@zmi.at> <200603021446.46352.ak@suse.de> <20060302134918.GR4329@suse.de>
In-Reply-To: <20060302134918.GR4329@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021458.02934.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 14:49, Jens Axboe wrote:
> On Thu, Mar 02 2006, Andi Kleen wrote:
> > On Thursday 02 March 2006 14:33, Jens Axboe wrote:
> > 
> > > Hmm I would have guessed the first is way more common, the device/driver
> > > consuming lots of iommu space would be the most likely to run into
> > > IOMMU-OOM.
> > 
> > e.g. consider a simple RAID-1. It will always map the requests twice so the 
> > normal case is 2 times as much IOMMU space needed. Or even more with bigger 
> > raids.
> > 
> > But you're right of course that only waiting for one user would be likely
> > sufficient. e.g. even if it misses some freeing events the "current" device
> > should eventually free some space too.
> > 
> > On the other hand it would seem cleaner to me to solve it globally
> > instead of trying to hack around it in the higher layers.
> 
> But I don't think that's really possible.

Wasn't this whole thread about making it possible?

> As Jeff points out, SCSI can't 
> do this right now because of the way we map requests.

Sure you have to punt out outside this spinlock and then find
a "safe place" as you put it to wait. The low level IOMMU code
would supply the wakeup.

> And it would be a 
> shame to change the hot path because of the error case. And then you
> have things like networking and other block drivers - it would be a big
> audit/fixup to make that work.
> 
> It's much easier to extend the dma mapping api to have an error
> fallback.

It already has one (pci_map_sg returning 0 or pci_mapping_error()
for pci_map_single()) 

The problem is just that when you get it you can only error out
because there is no way to wait for a free space event. With
your help I've been trying to figure out how to add it. Of course
after that's done you still have to do the work to handle 
it in the block layer somewhere.
 
> > > I was thinking just a global one, we are in soft error handling anyways
> > > so should be ok. I don't think you would need to dirty any global cache
> > > line unless you actually need to wake waiters.
> > 
> > __wake_up takes the spinlock even when nobody waits.
> 
> I would not want to call wake_up() unless I have to. Would a
> 
>         smp_mb();
>         if (waitqueue_active(&iommu_wq))
>                 ...
> 
> not be sufficient?

Probably, but one would need to be careful to not miss events this way.

-Andi

