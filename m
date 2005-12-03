Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVLCXK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVLCXK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 18:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVLCXK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 18:10:26 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:35494 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932170AbVLCXKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 18:10:25 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][mm][Fix] swsusp: fix counting of highmem pages
Date: Sun, 4 Dec 2005 00:11:29 +0100
User-Agent: KMail/1.8.3
Cc: Andy Isaacson <adi@hexapodia.org>, LKML <linux-kernel@vger.kernel.org>
References: <200512032140.15192.rjw@sisk.pl> <20051203214020.GA5198@elf.ucw.cz>
In-Reply-To: <20051203214020.GA5198@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512040011.30274.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[dropped Andrew from the CC list]

On Saturday, 3 of December 2005 22:40, Pavel Machek wrote:
> Hi!
> 
> > The following patch fixes a problem with swsusp that causes suspend to
> > fail on systems with the highmem zone, if many highmem pages are in use.
> > 
> > It makes swsusp count the non-free highmem pages in a correct way
> > and, consequently, release a sufficient amount of memory before suspend.
> > 
> > Please apply (Pavel, please ack if you think the patch is ok).
> 
> Please don't, it's way too complex in my eyes. Sorry, result of
> misscomunication between me and Rafael.
> 
> > +static inline unsigned int get_kmalloc_size(void)
> > +{
> > +#define CACHE(x) \
> > +	if (sizeof(struct highmem_page) <= x) \
> > +		return x;
> > +#include <linux/kmalloc_sizes.h>
> > +#undef CACHE
> > +	return sizeof(struct highmem_page);
> > +}
> > +
> 
> Can we get rid of this uglyness...

Sure, we can.

> > @@ -437,8 +446,14 @@
> >  
> >  static int enough_free_mem(unsigned int nr_pages)
> >  {
> > -	pr_debug("swsusp: available memory: %u pages\n", nr_free_pages());
> > -	return nr_free_pages() > (nr_pages + PAGES_FOR_IO +
> > +	struct zone *zone;
> > +	unsigned int n = 0;
> > +
> > +	for_each_zone (zone)
> > +		if (!is_highmem(zone))
> > +			n += zone->free_pages;
> > +	pr_debug("swsusp: available memory: %u pages\n", n);
> > +	return n > (nr_pages + PAGES_FOR_IO +
> >  		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
> >  }
> >  
> 
> And just use 2% approximation here, too?

Well, I don't think so.  It's checking free memory _after_ the highmem
pages have been "saved" (ie we are ready to create the image and just
check if there are enough non-highmem pages to do this).  Here we _know_
exactly how many pages are needed for the image, so we don't need to use
any "safety margins".

> > Index: linux-2.6.15-rc3-mm1/kernel/power/swsusp.c
> > ===================================================================
> > --- linux-2.6.15-rc3-mm1.orig/kernel/power/swsusp.c	2005-12-03 00:14:49.000000000 +0100
> > +++ linux-2.6.15-rc3-mm1/kernel/power/swsusp.c	2005-12-03 21:25:07.000000000 +0100
> > @@ -635,7 +635,8 @@
> >  	printk("Shrinking memory...  ");
> >  	do {
> >  #ifdef FAST_FREE
> > -		tmp = count_data_pages() + count_highmem_pages();
> > +		tmp = 2 * count_highmem_pages();
> > +		tmp += tmp / 50 + count_data_pages();
> >  		tmp += (tmp + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
> >  			PAGES_FOR_IO;
> >  		for_each_zone (zone)
> 
> This part is okay. Just make enough_free_mem use similar code. (If
> possible, share the code, it is really computing the same thing).

enough_free_mem() must not take highmem into account, so it has
to use different code.  IOW, the current implementation is buggy,
so I'm trying to change it.

Greetings,
Rafael
