Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbTA2PNJ>; Wed, 29 Jan 2003 10:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266228AbTA2PNI>; Wed, 29 Jan 2003 10:13:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55201 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266199AbTA2PNH>;
	Wed, 29 Jan 2003 10:13:07 -0500
Date: Wed, 29 Jan 2003 16:22:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE: Do not call bh_phys() on buffers with invalid b_page.
Message-ID: <20030129152214.GE31566@suse.de>
References: <1043852266.1690.63.camel@zion.wanadoo.fr> <20030129150000.GD31566@suse.de> <1043853614.1668.70.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043853614.1668.70.camel@zion.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29 2003, Benjamin Herrenschmidt wrote:
> On Wed, 2003-01-29 at 16:00, Jens Axboe wrote:
> > On Wed, Jan 29 2003, Benjamin Herrenschmidt wrote:
> > > Hi, I just spotted this in the patch (but the code itself have been
> > > there since 2.4.20-pre2).
> > > 
> > > > -			if (((unsigned long) bh->b_data) < PAGE_SIZE)
> > > > +			if ((unsigned long) bh->b_data < PAGE_SIZE)
> > > 
> > > Didn't you meant PAGE_OFFSET and not PAGE_SIZE here ? I fail to see why
> > > it would make any sense to compare a virtual address to PAGE_SIZE ;)
> > 
> > For highmem buffer heads, b_data is the offset into the page. Does look
> > confusing, I'll give you that :-)
> > 
> > The test should most likely just be removed, if anything.
> 
> I would agree with you if you were actually testing that ;) Look
> closely, the test is in the non-b_page case, that is when b_data
> contains a kernel virtual address.
> 
> So the test should be either removed or moved to the first part of the 
> if () statement.
> 
> In our case (virtual address, not page), though, it makes some sense to
> test that it's higher or equal than PAGE_OFFSET since virt_to_page()
> won't work on addresses not part of the lowmem linear mapping.

Ehm no, if b_data is < PAGE_SIZE, it's probably an offset and not a
valid address. So it should be exactly where it is -- for b_page, it's
_not_ buggy for b_data to be < PAGE_SIZE. That's expected. Submitter
would have to be buggy for it to trigger, though, so you can just remove
it if you want.

-- 
Jens Axboe

