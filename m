Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263974AbRFSHw2>; Tue, 19 Jun 2001 03:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263975AbRFSHwS>; Tue, 19 Jun 2001 03:52:18 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:6651 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S263974AbRFSHwL>; Tue, 19 Jun 2001 03:52:11 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200106190751.f5J7pXVb031505@webber.adilger.int>
Subject: Re: Simple example of using slab allocator?
In-Reply-To: <20010618230537.B28162@one-eyed-alien.net> "from Matthew Dharm at
 Jun 18, 2001 11:05:37 pm"
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Date: Tue, 19 Jun 2001 01:51:32 -0600 (MDT)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm writes:
> Well, if it's really that simple....
> 
> Another aspect of this, tho, is that I'd like to be able to profile my
> memory usage.  Does the SA have any ability to report (easily) the number
> of pages allocated and how full each one is?

Then "cat /proc/slabinfo" is your friend.  It lists currently allocated
objects, maximum objects that will fit in the current allocated pages,
size of object, pages used if objects were tightly packed, real pages
used, and pages per slab.

On SMP systems it also lists the number of slab cache objects kept
local to each CPU to avoid global locking when they need to allocate.

Cheers, Andreas

> On Mon, Jun 18, 2001 at 10:56:36AM -0600, Andreas Dilger wrote:
> > The slab allocator IS dead simple to use, basically:
> > 
> > - driver global variable:
> > 
> > kmem_cache_t *usb_mass_cachep;
> > 	
> > - in the driver init function:
> > 
> > 	usb_mass_cachep = kmem_cache_create("usb_mass_cache",
> > 					    sizeof(struct whatever),
> > 					    0, SLAB_HWCACHE_ALIGN,
> > 					    NULL, NULL);
> > 	(check for NULL usb_mass_slab)
> > 
> > - in the driver cleanup function:
> > 
> > 	if (usb_mass_cachep && kmem_cache_destroy(usb_mass_cachep))
> > 		printk(KERN_ERR "usb_mass_cache: not all structures freed\n");
> > 
> > - wherever you need an item from the slab cache:
> > 
> > 	whateverp = kmem_cache_alloc(usb_mass_cachep, GFP_KERNEL);
> > 	(check for NULL whateverp)
> > 
> > - when you are done with it:
> > 
> > 	kmem_cache_free(usb_mass_cachep, whateverp);
> > 
> > Notes:
> > - if you have a slab leak and you don't free all of the items (hence the slab
> >   cache is not removed), you will probably get an oops when you reload the
> >   driver.  You can only have one slab cache per name ("usb_mass_cache" here).
> > - You may need different alignment (SLAB_HWCACHE_ALIGN), or not
> > - You may need different allocation policy (GFP_KERNEL), or not
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
