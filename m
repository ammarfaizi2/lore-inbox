Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751619AbWF1W1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbWF1W1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbWF1W1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:27:23 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:10457 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751619AbWF1W1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:27:22 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: nigel@suspend2.net
Subject: Re: [Suspend2][] [Suspend2] Dynamically allocated pageflags
Date: Thu, 29 Jun 2006 00:27:25 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060626165209.10918.86526.stgit@nigel.suspend2.net> <200606280015.02703.rjw@sisk.pl> <200606281615.06333.nigel@suspend2.net>
In-Reply-To: <200606281615.06333.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606290027.25578.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 28 June 2006 08:15, Nigel Cunningham wrote:
> On Wednesday 28 June 2006 08:15, Rafael J. Wysocki wrote:
> > > > Well, having read the entire patch I think I'd do this in a different
> > > > way. Namely, we can always use pfn_to_page() to get the struct page
> > > > corresponding to given PFN, so we can enumerate pages from 0 to max_pfn
> > > > and create a simple bitmap with one or more bits per PFN.  The only
> > > > difficulty I see wrt this is to make sure 0-order allocations are used
> > > > for the bitmaps.
> > >
> > > I used to do that, but it arm pfns don't start at zero and it would leave
> > > gaps/wastage in the discontig mem case.
> >
> > Would that be a big problem?  That is, how many bits we would waste eg. on
> > ARM?
> 
> It depends on the board (PHYS_PFN_OFFSET), but can be as much as 0xf0000000
> (based on a quick search of include/asm-arm. 

That's quilte a lot.  Actually the case in which PFNs don't start from 0 would
be fixable, memory holes seem to be worse.
 
> > > > > +
> > > > > +#define BITNUMBER(page) (page_to_pfn(page))
> > > >
> > > > I think it would be cleaner to use page_to_pfn(page) verbatim instead
> > > > of this.
> > >
> > > I was going for readability.
> >
> > Well, if I see BITNUMBER(page), I tend to check what it means, so I have to
> > browse the code just to find out it's page_to_pfn(page).  Ouch.
> 
> Heh. It turned out to be another missed cleanup (was unused), so it's gone now.
> 
> > > > > +
> > > > > +/*
> > > > > + * pages_for_zone(struct zone *zone)
> > > > > + *
> > > > > + * How many pages do we need for a bitmap for this zone?
> > > > > + *
> > > > > + */
> > > > > +
> > > > > +static int pages_for_zone(struct zone *zone)
> > > > > +{
> > > > > +	return (zone->spanned_pages + (PAGE_SIZE << 3) - 1) >>
> > > > > +			(PAGE_SHIFT + 3);
> > > > > +}
> > > >
> > > > Could you please explain the maths above?
> > >
> > > Sure. Page_size << 3 is the number of bits in a page. We are calculating
> > > the number of pages needed to store spanned_pages bits, which is
> > > (spanned_pages + bits_per_page - 1) / (bits_per_page - 1). (Rounds up).
> >
> > Any chance to use DIV_ROUND_UP here?
> 
> Where did you get that name from? I did find -name '*.[ch]' | xargs grep
> DIV_ROUND_UP and couldn't find it anywhere. Is it an -mm thing? If so, I'll
> keep an eye out for it getting mainlined.

Sorry for that.  I'm sure I used it at some time, but apparently it's gone now.

> 
> > > > > +
> > > > > +/*
> > > > > + * page_zone_number(struct page *page)
> > > > > + *
> > > > > + * Which zone index does the page match?
> > > > > + *
> > > > > + */
> > > > > +
> > > > > +static int page_zone_number(struct page *page)
> > > > > +{
> > > > > +	struct zone *zone, *zone_sought = page_zone(page);
> > > > > +	int zone_num = 0;
> > > > > +
> > > > > +	for_each_zone(zone)
> > > > > +		if (zone == zone_sought)
> > > > > +			return zone_num;
> > > > > +		else
> > > > > +			zone_num++;
> > > > > +
> > > > > +	printk("Was looking for a zone for page %p.\n", page);
> > > > > +	BUG_ON(1);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > >
> > > > Why can't we use page_zonenum() instead of this?
> > >
> > > They will only be the same thing in the x86 case. If you have multiple
> > > zones and some don't have any dma pages or highmem pages, this will give
> > > a more compact numbering.
> >
> > But this is _really_ inefficient, because you call it for every page and
> > for how many times?  I think it should be fixed.
> 
> It's called once each for set/test/clearing bits, and once for each get_next_bit_on.
> So far as I recall, every time I use these flags, I iterate through the whole lot. I can
> see that it would be more efficient to remember the number and only update it when
> we know we've gone to a new zone (as get_next_bit_on does when searching),
> but that would require passing the zone number back and forward to the caller, and
> this is probably not as bad as it looks anyway because its a small routine and the data
> will be reasonably likely (depending on what else the caller is doing) to still be in the
> cpu caches.

Well, how about using the observation that
(page->flags >> ZONETABLE_PGSHIFT) & ZONETABLE_MASK
is an index in zone_table[] and enumerating zones using these indices?
This is used by page_zone() to get the pointer to the page's struct zone, so
it should be suitable for you too.

> > > > > +
> > > > > +/*
> > > > > + * allocate_dyn_pageflags(dyn_pageflags_t *pagemap)
> > > > > + *
> > > > > + * Allocate a bitmap for dynamic page flags.
> > > > > + *
> > > > > + */
> > > > > +int allocate_dyn_pageflags(dyn_pageflags_t *pagemap)
> > > > > +{
> > > > > +	int i, zone_num = 0;
> > > > > +	struct zone *zone;
> > > > > +
> > > > > +	BUG_ON(*pagemap);
> > > > > +
> > > > > +	*pagemap = kmalloc(sizeof(void *) * num_zones(), GFP_ATOMIC);
> > > >
> > > > By using kmalloc(), you use slab.  I'd rather allocate entire pages.
> > >
> > > You might only be using 20 bytes out of the page. At resume time, I do
> > > use entire pages if the kmalloc'd value needs relocating, but only if
> > > that's needed.
> >
> > Which is not exactly straightforward.  IMHO that should be simplified
> > somehow.
> 
> Do you have a concrete suggestion. I can't see how it can get simpler -
> everything I consider would be to make it more complicated.

If you allocated a whole page in the beginning it wouldn't be so, I think.
Even if you take only 20 bytes out of this page, it's temporary storage and
your kmalloc() may result in a whole page being allocated as well.

> > Moreover, it would be nice to avoid calling page_to_zone_offset(page) for
> > the second time in test/set/clear_dynpageflag below.
> 
> Fixed. I inlined dyn_pageflags_ul_ptr in each of the following functions and tidied.
> 
> > > > Please let me disagree with this comment.  I think it would be more
> > > > efficient if you searched the bitmap for the first zero bit and then
> > > > find the page, pfn, whatever corresponding to this bit.
> > >
> > > Yes, it would be more efficient. I don't mind modifying it. This is a
> > > different moment to the one when I wrote that :)
> 
> Optimisation added.
> 
> > > Once again,
> > >
> > > Thanks for your feedback. It's good to get picked up on cleanups I've
> > > missed and be made to remember again and provide the justification for
> > > decisions I've made.
> >
> > Well, unfortunately the patch doesn't look very good to me.  The overall
> > idea is quite reasonable, but IMHO the implementation needs fixing.
> 
> Here's the new dyn_pageflags.c...

I'm too tired to look at it now, so probably I'll do that tomorrow.  Also I'd
like to see where you use this and how exactly.  Could you please point me
to that code?

Rafael
