Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbTKEPrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 10:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTKEPrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 10:47:41 -0500
Received: from ida.rowland.org ([192.131.102.52]:4868 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261768AbTKEPri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 10:47:38 -0500
Date: Wed, 5 Nov 2003 10:47:37 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Jens Axboe <axboe@suse.de>
cc: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 1412] Copy from USB1 CF/SM reader stalls, no actual content
 is read (only directory structure)
In-Reply-To: <20031105084002.GX1477@suse.de>
Message-ID: <Pine.LNX.4.44L0.0311051013190.828-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Nov 2003, Jens Axboe wrote:

> On Tue, Nov 04 2003, Alan Stern wrote:
> > 
> > 	1. No, the sg entry was DMA-mapped previously and then unmapped.
> > The problem Nicholas encountered is an oops that occurs later during a
> > memcpy, not during a DMA operation.  Apparently the page is not locked in
> > memory.
> 
> Well what's the difference? Still a driver bug. Where does the dma
> mapping happen?

Sorry, my answer above was wrong.  In Nicholas's particular case there was
no DMA transfer at all, only memcpy().  There are other cases that do use
DMA, of course, like the one you were looking at.


> > 	3. What's wrong with sg_adress()?  I notice that bio_data() in 
> > include/linux/bio.h is practically the same.
> 
> Yeah, bio_data() is not supposed to be used either, but it also has a
> comment to that effect. sg_address() is worse, because it's readding
> something that 2.5 explicitly removed to encourage proper use of the pci
> dma mapping api.

Okay.  The real trouble we're facing is that the driver is handed an sg 
list, but sometimes it has to copy data directly to/from the memory area 
(via memcpy() for example) rather than doing I/O -- and even when doing 
I/O it may sometimes have to use PIO rather than DMA.

Anyway, we have to be able to access the underlying memory for the sg 
buffer.  The code currently uses

	page_address(sg[i].page) + sg[i].offset

to do this.  Is this now wrong?  And if so, what should it use instead?
I don't see anything about it in DMA-mapping.txt.


> > 	4. What's wrong with kfree() on ptr + offset?  As long as that 
> > points to the same address as was kmalloc'ed, it should work fine.
> 
> Ah you are right, there's nothing wrong with that. It's just the
> implementation that looks odd. Why not do away with that kmalloc() and
> virt_to_page(), and just alloc_page() explicitly? Kill the 2.4 ifdefs at
> the same time.

Certainly the 2.4 ifdefs can go away now.  We use kmalloc() rather than
alloc_page() because we will have to examine the allocated memory after
the DMA operation is complete.


> > 	5. We are doing DMA into those pages.  What's wrong with that?  
> > They were allocated using kmalloc, so there should be no difficulty in 
> > mapping and using them.
> 
> Where are they mapped? Are you flushing buffers appropriately?

They are mapped in drivers/usb/core/usb.c:usb_buffer_map_sg().  I don't 
know what buffers you're referring to.


> > 	6. There _are_ checks for kmalloc() failing; they just aren't 
> > where you would expect to see them.  The check depends on virt_to_page() 
> > returning 0 when passed an argument of 0.  Maybe that assumption is wrong.
> > Certainly it wouldn't hurt to do the checking properly.
> 
> Irk that's even more ugly... And it's wrong, too.

I'll change it.  But first we better settle the other questions I asked 
above.


> > 	7. DMA-mapping isn't the issue.  The problem is that 
> > sddr09_read_data() -- not sddr09_read_map() as you seem to have assumed -- 
> > has been passed an sg entry for which page_address() returns 0.
> 
> But why does that happen, if ->page is set? That's the mystery, and that
> heavily points to a driver bug.

You mean, why does page_address() return 0 if ->page is set?  I don't
know.  In fact, it's not even certain that ->page _is_ set -- I didn't
think to print it out in the diagnostic patch.

In any case, it quite likely _does_ point to a driver bug.  But since
sddr09_read_data() was handed this sg entry and didn't change it, if there
is such a bug it must lie in a higher-level driver.  Maybe the scsi layer, 
maybe the block layer, maybe the memory-management system, maybe the file 
system.  That was my original point.

Alan Stern

