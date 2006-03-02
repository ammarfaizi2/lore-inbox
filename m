Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWCBOjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWCBOjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 09:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWCBOjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 09:39:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31786 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750922AbWCBOjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 09:39:02 -0500
Date: Thu, 2 Mar 2006 15:38:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Michael Monnerie <m.monnerie@zmi.at>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Message-ID: <20060302143839.GU4329@suse.de>
References: <200603020023.21916@zmi.at> <200603021458.02934.ak@suse.de> <20060302141412.GT4329@suse.de> <200603021535.36549.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603021535.36549.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02 2006, Andi Kleen wrote:
> On Thursday 02 March 2006 15:14, Jens Axboe wrote:
> 
> [...]
> 
> Ok great we agree on everything then.

Seems so :)

> > > > 
> > > > I would not want to call wake_up() unless I have to. Would a
> > > > 
> > > >         smp_mb();
> > > >         if (waitqueue_active(&iommu_wq))
> > > >                 ...
> > > > 
> > > > not be sufficient?
> > > 
> > > Probably, but one would need to be careful to not miss events this way.
> > 
> > Definitely, as far as I can see the above should be enough...
> 
> Ok - you just need to give me a wait queue then and I would be happy
> to add the wakeups to the low level code
> 
> (or you can just do it yourself	if you prefer, shouldn't be very
> difficult ... - just needs to be done for both swiotlb and GART iommu.
> The other architectures can follow then. At the beginning using an
> ARCH_HAS_* ifdef might be a good idea for easier transition for
> everybody) 

I'd prefer adding that wait queue in the iommu code, it's where it
belongs. Didn't we agree on just a global waitqueue? The the interface
for block/net/whatever-consume would just be something like:

        iommu_wait();

which would return when we have enough space, hopefully. A subsystem
specific waitqueue would have the handy side of supplying a callback on
the wake up, which would be a nicer design. But isn't the enough
wait_for_resources() call sufficient for this?

-- 
Jens Axboe

