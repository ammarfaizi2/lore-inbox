Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWF1AME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWF1AME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 20:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWF1AME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 20:12:04 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:19132 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932133AbWF1AMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 20:12:00 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend2][] [Suspend2] Dynamically allocated pageflags
Date: Wed, 28 Jun 2006 10:11:51 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060626165209.10918.86526.stgit@nigel.suspend2.net> <200606270917.36229.nigel@suspend2.net> <200606280015.02703.rjw@sisk.pl>
In-Reply-To: <200606280015.02703.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2066420.oRZgsys6DM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606281011.55247.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2066420.oRZgsys6DM
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 28 June 2006 08:15, Rafael J. Wysocki wrote:
> Hi,
>
> On Tuesday 27 June 2006 01:17, Nigel Cunningham wrote:
> > On Tuesday 27 June 2006 07:11, Rafael J. Wysocki wrote:
> > > On Monday 26 June 2006 18:52, Nigel Cunningham wrote:
> > > > Add support for dynamically allocated pageflags - bitmaps consisting
> > > > of single pages merged together into per zone bitmaps that can then
> > > > be used as temporary page flags.
> > >
> > > IIRC, this has already been discussed on LKML and some people argued =
it
> > > would be overkill.  Could you please say why you think it's not so?
> >
> > Some people did, but IIRC, Dave Jones liked the general idea. The main
> > rationale was that we have a limited number of pageflags, and this
> > provides a way that we can easily add new ones without expanding struct
> > page. Obviously it's better for usage patterns like suspend2.
>
> Well, I think that might only be useful for "temporary" flags, because if
> such a structure were to stay in memory permanently, it would be better to
> expand struct page anyway.
>
> > The other (suspend2 specific) advantage is that having them stored like
> > this makes storing the image data much simpler and while we're
> > calculating the contents of the image, there is zero impact on the size
> > of this metadata storage from changes in the pages that are in each
> > pagedir.
>
> The question is if there are any potential users of this, except for
> suspend2. If not, it probably would make sense to use a more
> suspend2-specific and maybe simpler data structure and give up the
> generality.

Well, from a suspend2 perspective it's ideal, because saving the flags is j=
ust=20
a case of iterating over the pages in the bitmap (yeah, and adding some=20
metadata). If they were real pageflags, it would be much more painful.

If we were going to make this suspend2 only, all I'd do would be move=20
dyn_pageflags.h and dyn_pageflags.c to kernel/power, combining them with=20
pageflags.c and .h. I'm satisfied that the data structure is simple enough.=
=20
It will cope with memory hot plugging and so on (maybe need some tweaking,=
=20
but I haven't considered that yet). I do accept your argument that the code=
=20
could do with some optimisation though.

> > > Well, having read the entire patch I think I'd do this in a different
> > > way. Namely, we can always use pfn_to_page() to get the struct page
> > > corresponding to given PFN, so we can enumerate pages from 0 to max_p=
fn
> > > and create a simple bitmap with one or more bits per PFN.  The only
> > > difficulty I see wrt this is to make sure 0-order allocations are used
> > > for the bitmaps.
> >
> > I used to do that, but it arm pfns don't start at zero and it would lea=
ve
> > gaps/wastage in the discontig mem case.
>
> Would that be a big problem?  That is, how many bits we would waste eg. on
> ARM?

I'm not sure, but it was enough to cause a concern to the guy who was worki=
ng=20
on an arm port earlier in the year. The other thing that might be relevant=
=20
here is the amount of memory available. ARM is usually embedded, right?

> > > > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> > > >
> > > >  include/linux/dyn_pageflags.h |   66 ++++++++
> > > >  lib/Kconfig                   |    3
> > > >  lib/Makefile                  |    2
> > > >  lib/dyn_pageflags.c           |  330
> > > > +++++++++++++++++++++++++++++++++++++++++ 4 files changed, 401
> > > > insertions(+), 0 deletions(-)
> > > >
> > > > diff --git a/include/linux/dyn_pageflags.h
> > > > b/include/linux/dyn_pageflags.h new file mode 100644
> > > > index 0000000..1a7b5d8
> > > > --- /dev/null
> > > > +++ b/include/linux/dyn_pageflags.h
> > > > @@ -0,0 +1,66 @@
> > > > +/*
> > > > + * include/linux/dyn_pageflags.h
> > > > + *
> > > > + * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
> > > > + *
> > > > + * This file is released under the GPLv2.
> > > > + *
> > > > + * It implements support for dynamically allocated bitmaps that are
> > > > + * used for temporary or infrequently used pageflags, in lieu of
> > > > + * bits in the struct page flags entry.
> > > > + */
> > > > +
> > > > +#ifndef DYN_PAGEFLAGS_H
> > > > +#define DYN_PAGEFLAGS_H
> > > > +
> > > > +#include <linux/mm.h>
> > > > +
> > > > +typedef unsigned long *** dyn_pageflags_t;
> > >
> > > Is this really necessary to define the dyn_pageflags_t here?
> >
> > This will also be used in Suspend2's kernel/power/pageflags.c, which ad=
ds
> > support for saving the pageflags in the image header and reloading and
> > relocating them at resume time.
>
> I would probably use unsigned long *** directly anyway.

Using the typedef has helped in debugging (it's quite possible to get confu=
sed=20
when  you start passing pointers to the locations of pageflags around). I'd=
=20
really prefer to keep it.

> > > > +
> > > > +#define BITNUMBER(page) (page_to_pfn(page))
> > >
> > > I think it would be cleaner to use page_to_pfn(page) verbatim instead
> > > of this.
> >
> > I was going for readability.
>
> Well, if I see BITNUMBER(page), I tend to check what it means, so I have =
to
> browse the code just to find out it's page_to_pfn(page).  Ouch.
>
> > > > +
> > > > +#if BITS_PER_LONG =3D=3D 32
> > > > +#define UL_SHIFT 5
> > > > +#else
> > > > +#if BITS_PER_LONG =3D=3D 64
> > > > +#define UL_SHIFT 6
> > > > +#else
> > > > +#error Bits per long not 32 or 64?
> > > > +#endif
> > > > +#endif
> > > > +
> > > > +#define BIT_NUM_MASK (sizeof(unsigned long) * 8 - 1)
> > > > +#define PAGE_NUM_MASK (~((1 << (PAGE_SHIFT + 3)) - 1))
> > > > +#define UL_NUM_MASK (~(BIT_NUM_MASK | PAGE_NUM_MASK))
> > > > +
> > > > +#define BITS_PER_PAGE (PAGE_SIZE << 3)
> > > > +#define PAGENUMBER(zone_offset) (zone_offset >> (PAGE_SHIFT + 3))
> > > > +#define PAGEINDEX(zone_offset) ((zone_offset & UL_NUM_MASK) >>
> > > > UL_SHIFT) +#define PAGEBIT(zone_offset) (zone_offset & BIT_NUM_MASK)
> > > > +
> > > > +#define PAGE_UL_PTR(bitmap, zone_num, zone_pfn) \
> > > > +     =20
> > > > ((bitmap[zone_num][PAGENUMBER(zone_pfn)])+PAGEINDEX(zone_pfn))
> > >
> > > All of the above definitions seem to be related in an opaque way.  Any
> > > chance to make them a bit more clearer?  A comment, maybe?
> >
> > Ok.
> >
> > > > +
> > > > +/* With the above macros defined, you can do...
> > > > +
> > > > +#define PagePageset1(page) (test_dynpageflag(&pageset1_map, page))
> > > > +#define SetPagePageset1(page) (set_dynpageflag(&pageset1_map, page=
))
> > > > +#define ClearPagePageset1(page) (clear_dynpageflag(&pageset1_map,
> > > > page)) +*/
> > >
> > > I'd choose different names for these.  Also the definitions shouldn't
> > > go before test/set/clear_dynpageflag() are defined, IMO.
> >
> > I was seeking to make them similar to the real pageflags semantics. Did
> > you notice that this is a comment?
>
> I didn't, sorry.  Anyway it's a bit confusing.
>
> > Will rearrange anyway.
>
> OK
>
> > > > +
> > > > +#define BITMAP_FOR_EACH_SET(bitmap, counter) \
> > > > +	for (counter =3D get_next_bit_on(bitmap, -1); counter > -1; \
> > > > +		counter =3D get_next_bit_on(bitmap, counter))
> > > > +
> > > > +extern void clear_dyn_pageflags(dyn_pageflags_t pagemap);
> > > > +extern int allocate_dyn_pageflags(dyn_pageflags_t *pagemap);
> > > > +extern void free_dyn_pageflags(dyn_pageflags_t *pagemap);
> > > > +extern int dyn_pageflags_pages_per_bitmap(void);
> > > > +extern int get_next_bit_on(dyn_pageflags_t bitmap, int counter);
> > > > +extern unsigned long *dyn_pageflags_ul_ptr(dyn_pageflags_t *bitmap,
> > > > +		struct page *pg);
> > > > +
> > > > +extern int test_dynpageflag(dyn_pageflags_t *bitmap, struct page
> > > > *page); +extern void set_dynpageflag(dyn_pageflags_t *bitmap, struct
> > > > page *page); +extern void clear_dynpageflag(dyn_pageflags_t *bitmap,
> > > > struct page *page); +#endif
> > > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > > index 3de9335..5596bd8 100644
> > > > --- a/lib/Kconfig
> > > > +++ b/lib/Kconfig
> > > > @@ -38,6 +38,9 @@ config LIBCRC32C
> > > >  	  require M here.  See Castagnoli93.
> > > >  	  Module will be libcrc32c.
> > > >
> > > > +config DYN_PAGEFLAGS
> > > > +	bool
> > > > +
> > > >  #
> > > >  # compression support is select'ed if needed
> > > >  #
> > > > diff --git a/lib/Makefile b/lib/Makefile
> > > > index b830c9a..8290e9b 100644
> > > > --- a/lib/Makefile
> > > > +++ b/lib/Makefile
> > > > @@ -31,6 +31,8 @@ ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
> > > >    lib-y +=3D dec_and_lock.o
> > > >  endif
> > > >
> > > > +obj-$(CONFIG_DYN_PAGEFLAGS) +=3D dyn_pageflags.o
> > > > +
> > > >  obj-$(CONFIG_CRC_CCITT)	+=3D crc-ccitt.o
> > > >  obj-$(CONFIG_CRC16)	+=3D crc16.o
> > > >  obj-$(CONFIG_CRC32)	+=3D crc32.o
> > > > diff --git a/lib/dyn_pageflags.c b/lib/dyn_pageflags.c
> > > > new file mode 100644
> > > > index 0000000..4da52f5
> > > > --- /dev/null
> > > > +++ b/lib/dyn_pageflags.c
> > > > @@ -0,0 +1,330 @@
> > > > +/*
> > > > + * lib/dyn_pageflags.c
> > > > + *
> > > > + * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
> > > > + *
> > > > + * This file is released under the GPLv2.
> > > > + *
> > > > + * Routines for dynamically allocating and releasing bitmaps
> > > > + * used as pseudo-pageflags.
> > > > + *
> > > > + * Arrays are not contiguous. The first sizeof(void *) bytes are
> > > > + * the pointer to the next page in the bitmap. This allows us to
> > > > + * work under low memory conditions where order 0 might be all
> > > > + * that's available. In their original use (suspend2), it also
> > > > + * lets us save the pages at suspend time, reload and relocate them
> > > > + * as necessary at resume time without much effort.
> > > > + *
> > > > + */
> > > > +
> > > > +#include <linux/module.h>
> > > > +#include <linux/dyn_pageflags.h>
> > > > +#include <linux/bootmem.h>
> > > > +
> > > > +#define page_to_zone_offset(pg) (page_to_pfn(pg) -
> > > > page_zone(pg)->zone_start_pfn) +
> > > > +/*
> > > > + * num_zones
> > > > + *
> > > > + * How many zones are there?
> > > > + *
> > > > + */
> > > > +
> > > > +static int num_zones(void)
> > > > +{
> > > > +	int result =3D 0;
> > > > +	struct zone *zone;
> > > > +
> > > > +	for_each_zone(zone)
> > > > +		result++;
> > > > +
> > > > +	return result;
> > > > +}
> > >
> > > Do we really need this?
> >
> > Well, I need to know how many zones there are, and haven't seen a gener=
ic
> > function. If you know of one, please point me to it. (Or I could shift
> > this somewhere else and make it a generic function - I'm aware that I
> > have something similar in pageflags.c).
>
> I don't know such a function, but if you need to call the above more than
> once it's plain inefficient.  I'd define a variable num_zones instead.
>
> > > > +
> > > > +/*
> > > > + * pages_for_zone(struct zone *zone)
> > > > + *
> > > > + * How many pages do we need for a bitmap for this zone?
> > > > + *
> > > > + */
> > > > +
> > > > +static int pages_for_zone(struct zone *zone)
> > > > +{
> > > > +	return (zone->spanned_pages + (PAGE_SIZE << 3) - 1) >>
> > > > +			(PAGE_SHIFT + 3);
> > > > +}
> > >
> > > Could you please explain the maths above?
> >
> > Sure. Page_size << 3 is the number of bits in a page. We are calculating
> > the number of pages needed to store spanned_pages bits, which is
> > (spanned_pages + bits_per_page - 1) / (bits_per_page - 1). (Rounds up).
>
> Any chance to use DIV_ROUND_UP here?

Wasn't aware of it's existence. Thanks.

> > > > +
> > > > +/*
> > > > + * page_zone_number(struct page *page)
> > > > + *
> > > > + * Which zone index does the page match?
> > > > + *
> > > > + */
> > > > +
> > > > +static int page_zone_number(struct page *page)
> > > > +{
> > > > +	struct zone *zone, *zone_sought =3D page_zone(page);
> > > > +	int zone_num =3D 0;
> > > > +
> > > > +	for_each_zone(zone)
> > > > +		if (zone =3D=3D zone_sought)
> > > > +			return zone_num;
> > > > +		else
> > > > +			zone_num++;
> > > > +
> > > > +	printk("Was looking for a zone for page %p.\n", page);
> > > > +	BUG_ON(1);
> > > > +
> > > > +	return 0;
> > > > +}
> > >
> > > Why can't we use page_zonenum() instead of this?
> >
> > They will only be the same thing in the x86 case. If you have multiple
> > zones and some don't have any dma pages or highmem pages, this will give
> > a more compact numbering.
>
> But this is _really_ inefficient, because you call it for every page and
> for how many times?  I think it should be fixed.
>
> > > > +
> > > > +/*
> > > > + * dyn_pageflags_pages_per_bitmap
> > > > + *
> > > > + * Number of pages needed for a bitmap covering all zones.
> > > > + *
> > > > + */
> > > > +int dyn_pageflags_pages_per_bitmap(void)
> > > > +{
> > > > +	int total =3D 0;
> > > > +	struct zone *zone;
> > > > +
> > > > +	for_each_zone(zone)
> > > > +		total +=3D pages_for_zone(zone);
> > > > +
> > > > +	return total;
> > > > +}
> > >
> > > Why is a separate function needed for this?
> >
> > Readability. Actually, answering this made me check again, and I couldn=
't
> > find a user of this function. I'll remove it.
> >
> > > > +
> > > > +/*
> > > > + * clear_dyn_pageflags(dyn_pageflags_t pagemap)
> > > > + *
> > > > + * Clear an array used to store local page flags.
> > > > + *
> > > > + */
> > > > +
> > > > +void clear_dyn_pageflags(dyn_pageflags_t pagemap)
> > > > +{
> > > > +	int i =3D 0, zone_num =3D 0;
> > > > +	struct zone *zone;
> > > > +
> > > > +	BUG_ON(!pagemap);
> > > > +
> > > > +	for_each_zone(zone) {
> > > > +		for (i =3D 0; i < pages_for_zone(zone); i++)
> > > > +			memset((pagemap[zone_num][i]), 0, PAGE_SIZE);
> > > > +		zone_num++;
> > > > +	}
> > > > +}
> > >
> > > I think this could be done in a simpler way too.
> > >
> > > > +
> > > > +/*
> > > > + * allocate_dyn_pageflags(dyn_pageflags_t *pagemap)
> > > > + *
> > > > + * Allocate a bitmap for dynamic page flags.
> > > > + *
> > > > + */
> > > > +int allocate_dyn_pageflags(dyn_pageflags_t *pagemap)
> > > > +{
> > > > +	int i, zone_num =3D 0;
> > > > +	struct zone *zone;
> > > > +
> > > > +	BUG_ON(*pagemap);
> > > > +
> > > > +	*pagemap =3D kmalloc(sizeof(void *) * num_zones(), GFP_ATOMIC);
> > >
> > > By using kmalloc(), you use slab.  I'd rather allocate entire pages.
> >
> > You might only be using 20 bytes out of the page. At resume time, I do
> > use entire pages if the kmalloc'd value needs relocating, but only if
> > that's needed.
>
> Which is not exactly straightforward.  IMHO that should be simplified
> somehow.
>
> > > > +
> > > > +	if (!*pagemap)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	for_each_zone(zone) {
> > > > +		int zone_pages =3D pages_for_zone(zone);
> > > > +		(*pagemap)[zone_num] =3D kmalloc(sizeof(void *) * zone_pages,
> > > > +					       GFP_ATOMIC);
> > > > +
> > > > +		if (!(*pagemap)[zone_num]) {
> > > > +			kfree (*pagemap);
> > >
> > > This seems to leak memory, eg. if *pagemap[0] is allocated, but the
> > > allocation of *pagemap[1] fails.  You should free *pagemap[j] up to
> > > zone_num-1 and then *pagemap, IMO.
> >
> > Yes, I should. Thanks.
> >
> > > > +			return -ENOMEM;
> > > > +		}
> > > > +
> > > > +		for (i =3D 0; i < zone_pages; i++) {
> > > > +			unsigned long address =3D get_zeroed_page(GFP_ATOMIC);
> > > > +			(*pagemap)[zone_num][i] =3D (unsigned long *) address;
> > > > +			if (!(*pagemap)[zone_num][i]) {
> > > > +				printk("Error. Unable to allocate memory for "
> > > > +					"dynamic pageflags.");
> > > > +				free_dyn_pageflags(pagemap);
> > > > +				return -ENOMEM;
> > > > +			}
> > > > +		}
> > > > +		zone_num++;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +/*
> > > > + * free_dyn_pageflags(dyn_pageflags_t *pagemap)
> > > > + *
> > > > + * Free a dynamically allocated pageflags bitmap. For Suspend2
> > > > usage, we + * support data being relocated from slab to pages that
> > > > don't conflict + * with the image that will be copied back. This is
> > > > the reason for the + * PageSlab tests below.
> > > > + *
> > > > + */
> > > > +void free_dyn_pageflags(dyn_pageflags_t *pagemap)
> > > > +{
> > > > +	int i =3D 0, zone_num =3D 0;
> > > > +	struct zone *zone;
> > > > +
> > > > +	if (!*pagemap)
> > > > +		return;
> > > > +
> > > > +	for_each_zone(zone) {
> > > > +		int zone_pages =3D pages_for_zone(zone);
> > > > +
> > > > +		if (!((*pagemap)[zone_num]))
> > > > +			continue;
> > > > +		for (i =3D 0; i < zone_pages; i++)
> > > > +			if ((*pagemap)[zone_num][i])
> > > > +				free_page((unsigned long) (*pagemap)[zone_num][i]);
> > > > +
> > > > +		if (PageSlab(virt_to_page((*pagemap)[zone_num])))
> > > > +			kfree((*pagemap)[zone_num]);
> > > > +		else
> > > > +			free_page((unsigned long) (*pagemap)[zone_num]);
> > > > +
> > > > +		zone_num++;
> > > > +	}
> > > > +
> > > > +	if (PageSlab(virt_to_page((*pagemap))))
> > > > +		kfree(*pagemap);
> > > > +	else
> > > > +		free_page((unsigned long) (*pagemap));
> > >
> > > Why so?
> >
> > See above (Suspend2 relocation at resume time).
>
> Oh well ...
>
> > > > +
> > > > +	*pagemap =3D NULL;
> > > > +	return;
> > > > +}
> > > > +
> > > > +/*
> > > > + * dyn_pageflags_ul_ptr(dyn_pageflags_t *bitmap, struct page *pg)
> > > > + *
> > > > + * Get a pointer to the unsigned long containing the flag in the
> > > > bitmap + * for the given page.
> > > > + *
> > > > + */
> > > > +
> > > > +unsigned long *dyn_pageflags_ul_ptr(dyn_pageflags_t *bitmap, struct
> > > > page *pg) +{
> > > > +	int zone_pfn =3D page_to_zone_offset(pg);
> > > > +	int zone_num =3D page_zone_number(pg);
> > > > +	int pagenum =3D PAGENUMBER(zone_pfn);
> > > > +	int page_offset =3D PAGEINDEX(zone_pfn);
> > > > +	return ((*bitmap)[zone_num][pagenum]) + page_offset;
> > > > +}
> > >
> > > It doesn't look very efficient, does it? ;-)
> >
> > Readability again. I'm assuming the compiler is semi intelligent :)
>
> Well, how is it supposed to optimise out the call to page_zone_number()?
> Also I wouldn't bet on the efficiency of the displacement computations.
>
> Moreover, it would be nice to avoid calling page_to_zone_offset(page) for
> the second time in test/set/clear_dynpageflag below.
>
> > > > +
> > > > +/*
> > > > + * test_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
> > > > + *
> > > > + * Is the page flagged in the given bitmap?
> > > > + *
> > > > + */
> > > > +
> > > > +int test_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
> > > > +{
> > > > +	unsigned long *ul =3D dyn_pageflags_ul_ptr(bitmap, page);
> > > > +	int zone_offset =3D page_to_zone_offset(page);
> > > > +	int bit =3D PAGEBIT(zone_offset);
> > > > +
> > > > +	return test_bit(bit, ul);
> > > > +}
> > > > +
> > > > +/*
> > > > + * set_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
> > > > + *
> > > > + * Set the flag for the page in the given bitmap.
> > > > + *
> > > > + */
> > > > +
> > > > +void set_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
> > > > +{
> > > > +	unsigned long *ul =3D dyn_pageflags_ul_ptr(bitmap, page);
> > > > +	int zone_offset =3D page_to_zone_offset(page);
> > > > +	int bit =3D PAGEBIT(zone_offset);
> > > > +	set_bit(bit, ul);
> > > > +}
> > > > +
> > > > +/*
> > > > + * clear_dynpageflags(dyn_pageflags_t *bitmap, struct page *page)
> > > > + *
> > > > + * Clear the flag for the page in the given bitmap.
> > > > + *
> > > > + */
> > > > +
> > > > +void clear_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
> > > > +{
> > > > +	unsigned long *ul =3D dyn_pageflags_ul_ptr(bitmap, page);
> > > > +	int zone_offset =3D page_to_zone_offset(page);
> > > > +	int bit =3D PAGEBIT(zone_offset);
> > > > +	clear_bit(bit, ul);
> > > > +}
> > > > +
> > > > +/*
> > > > + * get_next_bit_on(dyn_pageflags_t bitmap, int counter)
> > > > + *
> > > > + * Given a pfn (possibly -1), find the next pfn in the bitmap that
> > > > + * is set. If there are no more flags set, return -1.
> > > > + *
> > > > + */
> > > > +
> > > > +int get_next_bit_on(dyn_pageflags_t bitmap, int counter)
> > > > +{
> > > > +	struct page *page;
> > > > +	struct zone *zone;
> > > > +	unsigned long *ul =3D NULL;
> > > > +	int zone_offset, pagebit, zone_num, first;
> > > > +
> > > > +	first =3D (counter =3D=3D -1);
> > > > +
> > > > +	if (first)
> > > > +		counter =3D first_online_pgdat()->node_zones->zone_start_pfn;
> > > > +
> > > > +	page =3D pfn_to_page(counter);
> > > > +	zone =3D page_zone(page);
> > > > +	zone_num =3D page_zone_number(page);
> > > > +	zone_offset =3D counter - zone->zone_start_pfn;
> > > > +
> > > > +	if (first) {
> > > > +		counter--;
> > > > +		zone_offset--;
> > > > +	} else
> > > > +		ul =3D (bitmap[zone_num][PAGENUMBER(zone_offset)]) +
> > > > PAGEINDEX(zone_offset); +
> > > > +	do {
> > > > +		counter++;
> > > > +		zone_offset++;
> > > > +
> > > > +		if (zone_offset >=3D zone->spanned_pages) {
> > > > +			do {
> > > > +				zone =3D next_zone(zone);
> > > > +				if (!zone)
> > > > +					return -1;
> > > > +				zone_num++;
> > > > +			} while(!zone->spanned_pages);
> > > > +
> > > > +			counter =3D zone->zone_start_pfn;
> > > > +			zone_offset =3D 0;
> > > > +		}
> > > > +
> > > > +		/*
> > > > +		 * This could be optimised, but there are more
> > > > +		 * important things and the code is simple at
> > > > +		 * the moment
> > > > +		 */
> > >
> > > Please let me disagree with this comment.  I think it would be more
> > > efficient if you searched the bitmap for the first zero bit and then
> > > find the page, pfn, whatever corresponding to this bit.
> >
> > Yes, it would be more efficient. I don't mind modifying it. This is a
> > different moment to the one when I wrote that :)
> >
> > > > +		pagebit =3D PAGEBIT(zone_offset);
> > > > +
> > > > +		if (!pagebit)
> > > > +			ul =3D (bitmap[zone_num][PAGENUMBER(zone_offset)]) +
> > > > PAGEINDEX(zone_offset); +
> > > > +	} while(!test_bit(pagebit, ul));
> > > > +
> > > > +	return counter;
> > > > +}
> > > > +
> >
> > Once again,
> >
> > Thanks for your feedback. It's good to get picked up on cleanups I've
> > missed and be made to remember again and provide the justification for
> > decisions I've made.
>
> Well, unfortunately the patch doesn't look very good to me.  The overall
> idea is quite reasonable, but IMHO the implementation needs fixing.

Ok. I'll do some work on this. Thanks for your comments.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2066420.oRZgsys6DM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoclLN0y+n1M3mo0RAvgvAJ0X5e78Mb6rPreF+sudyRDV7gXNFACfdgSk
6LXBrAY+BhsWm4upqxhwfEU=
=fEor
-----END PGP SIGNATURE-----

--nextPart2066420.oRZgsys6DM--
