Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTKHAGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTKGWMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:12:01 -0500
Received: from ns.suse.de ([195.135.220.2]:56030 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263941AbTKGIZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 03:25:42 -0500
Date: Fri, 7 Nov 2003 09:24:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Bug 1412] Copy from USB1 CF/SM reader stalls, no actual content is read (only directory structure)
Message-ID: <20031107082439.GB504@suse.de>
References: <20031105084002.GX1477@suse.de> <Pine.LNX.4.44L0.0311051013190.828-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0311051013190.828-100000@ida.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05 2003, Alan Stern wrote:
> > > 	3. What's wrong with sg_adress()?  I notice that bio_data() in 
> > > include/linux/bio.h is practically the same.
> > 
> > Yeah, bio_data() is not supposed to be used either, but it also has a
> > comment to that effect. sg_address() is worse, because it's readding
> > something that 2.5 explicitly removed to encourage proper use of the pci
> > dma mapping api.
> 
> Okay.  The real trouble we're facing is that the driver is handed an sg 
> list, but sometimes it has to copy data directly to/from the memory area 
> (via memcpy() for example) rather than doing I/O -- and even when doing 
> I/O it may sometimes have to use PIO rather than DMA.
> 
> Anyway, we have to be able to access the underlying memory for the sg 
> buffer.  The code currently uses
> 
> 	page_address(sg[i].page) + sg[i].offset
> 
> to do this.  Is this now wrong?  And if so, what should it use instead?
> I don't see anything about it in DMA-mapping.txt.

No that looks alright, given you are allocating low memory pages. The
devices can probably do full 32-bit dma I bet, though. Not having looked
too closely, that will likely require invasive changes to support if you
are used to virtually mapped pages.

> > > 	4. What's wrong with kfree() on ptr + offset?  As long as that 
> > > points to the same address as was kmalloc'ed, it should work fine.
> > 
> > Ah you are right, there's nothing wrong with that. It's just the
> > implementation that looks odd. Why not do away with that kmalloc() and
> > virt_to_page(), and just alloc_page() explicitly? Kill the 2.4 ifdefs at
> > the same time.
> 
> Certainly the 2.4 ifdefs can go away now.  We use kmalloc() rather than
> alloc_page() because we will have to examine the allocated memory after
> the DMA operation is complete.

The alloc_page() would be nicer if you supported highmem io as well. It
still not a problem to access it, simply kmap it.

> > > 	5. We are doing DMA into those pages.  What's wrong with that?  
> > > They were allocated using kmalloc, so there should be no difficulty in 
> > > mapping and using them.
> > 
> > Where are they mapped? Are you flushing buffers appropriately?
> 
> They are mapped in drivers/usb/core/usb.c:usb_buffer_map_sg().  I don't 
> know what buffers you're referring to.

The sg buffers. The mapping looks ok to me, no problem there.

> > > 	7. DMA-mapping isn't the issue.  The problem is that 
> > > sddr09_read_data() -- not sddr09_read_map() as you seem to have assumed -- 
> > > has been passed an sg entry for which page_address() returns 0.
> > 
> > But why does that happen, if ->page is set? That's the mystery, and that
> > heavily points to a driver bug.
> 
> You mean, why does page_address() return 0 if ->page is set?  I don't
> know.  In fact, it's not even certain that ->page _is_ set -- I didn't
> think to print it out in the diagnostic patch.

I've lost the original mail in the thread, but I'm quite sure it listed
sg[0].page as being valid. Maybe the driver cleared it somewhere too
early? page_address() will not have returned NULL for a valid page.
Unless it's a highmem page, in that case you have to map it and unmap
after use. For drivers like this that aren't performance critical and
are by no means highmem ready, it's easier just to set your dma mask low
enough that you wont be handed such pages.

> In any case, it quite likely _does_ point to a driver bug.  But since
> sddr09_read_data() was handed this sg entry and didn't change it, if there
> is such a bug it must lie in a higher-level driver.  Maybe the scsi layer, 
> maybe the block layer, maybe the memory-management system, maybe the file 
> system.  That was my original point.

Well, the sg entry looks perfectly valid. And that was my original
point :-). And that is why I said it looks like a driver bug, not in
upper layers. How much memory did the system that crashed have? If the
system has highmem, try testing with scsi_calculate_bounce_limit()
unconditionally returning BLK_BOUNCE_HIGH.

-- 
Jens Axboe

