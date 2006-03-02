Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWCBNwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWCBNwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 08:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWCBNwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 08:52:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9053 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750771AbWCBNwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 08:52:49 -0500
Date: Thu, 2 Mar 2006 14:49:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Michael Monnerie <m.monnerie@zmi.at>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Message-ID: <20060302134918.GR4329@suse.de>
References: <200603020023.21916@zmi.at> <200603021433.17235.ak@suse.de> <20060302133322.GQ4329@suse.de> <200603021446.46352.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603021446.46352.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02 2006, Andi Kleen wrote:
> On Thursday 02 March 2006 14:33, Jens Axboe wrote:
> 
> > Hmm I would have guessed the first is way more common, the device/driver
> > consuming lots of iommu space would be the most likely to run into
> > IOMMU-OOM.
> 
> e.g. consider a simple RAID-1. It will always map the requests twice so the 
> normal case is 2 times as much IOMMU space needed. Or even more with bigger 
> raids.
> 
> But you're right of course that only waiting for one user would be likely
> sufficient. e.g. even if it misses some freeing events the "current" device
> should eventually free some space too.
> 
> On the other hand it would seem cleaner to me to solve it globally
> instead of trying to hack around it in the higher layers.

But I don't think that's really possible. As Jeff points out, SCSI can't
do this right now because of the way we map requests. And it would be a
shame to change the hot path because of the error case. And then you
have things like networking and other block drivers - it would be a big
audit/fixup to make that work.

It's much easier to extend the dma mapping api to have an error
fallback.

> > I was thinking just a global one, we are in soft error handling anyways
> > so should be ok. I don't think you would need to dirty any global cache
> > line unless you actually need to wake waiters.
> 
> __wake_up takes the spinlock even when nobody waits.

I would not want to call wake_up() unless I have to. Would a

        smp_mb();
        if (waitqueue_active(&iommu_wq))
                ...

not be sufficient?

-- 
Jens Axboe

