Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261577AbRFRQ5l>; Mon, 18 Jun 2001 12:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbRFRQ5b>; Mon, 18 Jun 2001 12:57:31 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:25594 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261577AbRFRQ5Z>; Mon, 18 Jun 2001 12:57:25 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200106181656.f5IGuamN013348@webber.adilger.int>
Subject: Re: Simple example of using slab allocator?
In-Reply-To: <20010615151901.G28394@one-eyed-alien.net> "from Matthew Dharm at
 Jun 15, 2001 03:19:01 pm"
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Date: Mon, 18 Jun 2001 10:56:36 -0600 (MDT)
CC: Kernel Developer List <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm writes:
> For 2.5, I'm planning on switching my driver over to the slab allocator,
> for a variety of reasons.  Does anyone have a _dead_ simple example of how
> to use such a beast?  I've seen the various web pages and document
> explaining the API, but I love to see working examples for reference (and
> to fill in the blanks).

The slab allocator IS dead simple to use, basically:

- driver global variable:

kmem_cache_t *usb_mass_cachep;
	
- in the driver init function:

	usb_mass_cachep = kmem_cache_create("usb_mass_cache",
					    sizeof(struct whatever),
					    0, SLAB_HWCACHE_ALIGN,
					    NULL, NULL);
	(check for NULL usb_mass_slab)

- in the driver cleanup function:

	if (usb_mass_cachep && kmem_cache_destroy(usb_mass_cachep))
		printk(KERN_ERR "usb_mass_cache: not all structures freed\n");

- wherever you need an item from the slab cache:

	whateverp = kmem_cache_alloc(usb_mass_cachep, GFP_KERNEL);
	(check for NULL whateverp)

- when you are done with it:

	kmem_cache_free(usb_mass_cachep, whateverp);

Notes:
- if you have a slab leak and you don't free all of the items (hence the slab
  cache is not removed), you will probably get an oops when you reload the
  driver.  You can only have one slab cache per name ("usb_mass_cache" here).
- You may need different alignment (SLAB_HWCACHE_ALIGN), or not
- You may need different allocation policy (GFP_KERNEL), or not

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
