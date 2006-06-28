Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWF1GPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWF1GPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 02:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWF1GPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 02:15:12 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:52124 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1030391AbWF1GPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 02:15:09 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend2][] [Suspend2] Dynamically allocated pageflags
Date: Wed, 28 Jun 2006 16:15:02 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060626165209.10918.86526.stgit@nigel.suspend2.net> <200606270917.36229.nigel@suspend2.net> <200606280015.02703.rjw@sisk.pl>
In-Reply-To: <200606280015.02703.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1157969.7fNPPfh8mh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606281615.06333.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1157969.7fNPPfh8mh
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 28 June 2006 08:15, Rafael J. Wysocki wrote:
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

It depends on the board (PHYS_PFN_OFFSET), but can be as much as 0xf0000000=
 (based on a quick search of include/asm-arm.

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

Heh. It turned out to be another missed cleanup (was unused), so it's gone =
now.

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

Where did you get that name from? I did find -name '*.[ch]' | xargs grep DI=
V_ROUND_UP and couldn't find it anywhere. Is it an -mm thing? If so, I'll k=
eep an eye out for it getting mainlined.

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

It's called once each for set/test/clearing bits, and once for each get_nex=
t_bit_on. So far as I recall, every time I use these flags, I iterate throu=
gh the whole lot. I can see that it would be more efficient to remember the=
 number and only update it when we know we've gone to a new zone (as get_ne=
xt_bit_on does when searching), but that would require passing the zone num=
ber back and forward to the caller, and this is probably not as bad as it l=
ooks anyway because its a small routine and the data will be reasonably lik=
ely (depending on what else the caller is doing) to still be in the cpu cac=
hes.

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

Do you have a concrete suggestion. I can't see how it can get simpler - eve=
rything I consider would be to make it more complicated.

> Moreover, it would be nice to avoid calling page_to_zone_offset(page) for
> the second time in test/set/clear_dynpageflag below.

=46ixed. I inlined dyn_pageflags_ul_ptr in each of the following functions =
and tidied.

> > > Please let me disagree with this comment.  I think it would be more
> > > efficient if you searched the bitmap for the first zero bit and then
> > > find the page, pfn, whatever corresponding to this bit.
> >
> > Yes, it would be more efficient. I don't mind modifying it. This is a
> > different moment to the one when I wrote that :)

Optimisation added.

> > Once again,
> >
> > Thanks for your feedback. It's good to get picked up on cleanups I've
> > missed and be made to remember again and provide the justification for
> > decisions I've made.
>
> Well, unfortunately the patch doesn't look very good to me.  The overall
> idea is quite reasonable, but IMHO the implementation needs fixing.

Here's the new dyn_pageflags.c...

Regards,

Nigel

/*
 * lib/dyn_pageflags.c
 *
 * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
 *=20
 * This file is released under the GPLv2.
 *
 * Routines for dynamically allocating and releasing bitmaps
 * used as pseudo-pageflags.
 */

#include <linux/module.h>
#include <linux/dyn_pageflags.h>
#include <linux/bootmem.h>

#define page_to_zone_offset(pg) (page_to_pfn(pg) - page_zone(pg)->zone_star=
t_pfn)

/*=20
 * pages_for_zone(struct zone *zone)
 *=20
 * How many pages do we need for a bitmap for this zone?
 *
 */

static int pages_for_zone(struct zone *zone)
{
	return (zone->spanned_pages + (PAGE_SIZE << 3) - 1) >>
			(PAGE_SHIFT + 3);
}

/*
 * page_zone_number(struct page *page)
 *
 * Which zone index does the page match?
 *
 */

static int page_zone_number(struct page *page)
{
	struct zone *zone, *zone_sought =3D page_zone(page);
	int zone_num =3D 0;

	for_each_zone(zone)
		if (zone =3D=3D zone_sought)
			return zone_num;
		else
			zone_num++;

	printk("Was looking for a zone for page %p.\n", page);
	BUG_ON(1);

	return 0;
}

/*
 * dyn_pageflags_pages_per_bitmap
 *
 * Number of pages needed for a bitmap covering all zones.
 *
 */
int dyn_pageflags_pages_per_bitmap(void)
{
	int total =3D 0;
	struct zone *zone;

	for_each_zone(zone)
		total +=3D pages_for_zone(zone);

	return total;
}

/*=20
 * clear_dyn_pageflags(dyn_pageflags_t pagemap)
 *
 * Clear an array used to store local page flags.
 *
 */

void clear_dyn_pageflags(dyn_pageflags_t pagemap)
{
	int i =3D 0, zone_num =3D 0;
	struct zone *zone;
=09
	BUG_ON(!pagemap);

	for_each_zone(zone) {
		for (i =3D 0; i < pages_for_zone(zone); i++)
			memset((pagemap[zone_num][i]), 0, PAGE_SIZE);
		zone_num++;
	}
}

/*=20
 * allocate_dyn_pageflags(dyn_pageflags_t *pagemap)
 *
 * Allocate a bitmap for dynamic page flags.
 *
 */
int allocate_dyn_pageflags(dyn_pageflags_t *pagemap)
{
	int i, zone_num =3D 0;
	struct zone *zone;

	BUG_ON(*pagemap);

	*pagemap =3D kmalloc(sizeof(void *) * zones_in_use, GFP_ATOMIC);

	if (!*pagemap)
		return -ENOMEM;

	for_each_zone(zone) {
		int zone_pages =3D pages_for_zone(zone);
		(*pagemap)[zone_num] =3D kmalloc(sizeof(void *) * zone_pages,
					       GFP_ATOMIC);

		if (!(*pagemap)[zone_num]) {
			free_dyn_pageflags(pagemap);
			return -ENOMEM;
		}

		for (i =3D 0; i < zone_pages; i++) {
			unsigned long address =3D get_zeroed_page(GFP_ATOMIC);
			(*pagemap)[zone_num][i] =3D (unsigned long *) address;
			if (!(*pagemap)[zone_num][i]) {
				printk("Error. Unable to allocate memory for "
					"dynamic pageflags.");
				free_dyn_pageflags(pagemap);
				return -ENOMEM;
			}
		}
		zone_num++;
	}

	return 0;
}

/*=20
 * free_dyn_pageflags(dyn_pageflags_t *pagemap)
 *
 * Free a dynamically allocated pageflags bitmap. For Suspend2 usage, we
 * support data being relocated from slab to pages that don't conflict
 * with the image that will be copied back. This is the reason for the
 * PageSlab tests below.
 *
 */
void free_dyn_pageflags(dyn_pageflags_t *pagemap)
{
	int i =3D 0, zone_num =3D 0;
	struct zone *zone;

	if (!*pagemap)
		return;
=09
	for_each_zone(zone) {
		int zone_pages =3D pages_for_zone(zone);

		if (!((*pagemap)[zone_num]))
			continue;
		for (i =3D 0; i < zone_pages; i++)
			if ((*pagemap)[zone_num][i])
				free_page((unsigned long) (*pagemap)[zone_num][i]);
=09
		if (PageSlab(virt_to_page((*pagemap)[zone_num])))
			kfree((*pagemap)[zone_num]);
		else
			free_page((unsigned long) (*pagemap)[zone_num]);

		zone_num++;
	}

	if (PageSlab(virt_to_page((*pagemap))))
		kfree(*pagemap);
	else
		free_page((unsigned long) (*pagemap));

	*pagemap =3D NULL;
	return;
}

/*
 * test_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
 *
 * Is the page flagged in the given bitmap?
 *
 */

int test_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
{
	int zone_pfn =3D page_to_zone_offset(page);
	int zone_num =3D page_zone_number(page);
	int pagenum =3D PAGENUMBER(zone_pfn);
	int page_offset =3D PAGEINDEX(zone_pfn);
	unsigned long *ul =3D ((*bitmap)[zone_num][pagenum]) + page_offset;
	int bit =3D PAGEBIT(zone_pfn);
=09
	return test_bit(bit, ul);
}

/*
 * set_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
 *
 * Set the flag for the page in the given bitmap.
 *
 */

void set_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
{
	int zone_pfn =3D page_to_zone_offset(page);
	int zone_num =3D page_zone_number(page);
	int pagenum =3D PAGENUMBER(zone_pfn);
	int page_offset =3D PAGEINDEX(zone_pfn);
	unsigned long *ul =3D ((*bitmap)[zone_num][pagenum]) + page_offset;
	int bit =3D PAGEBIT(zone_pfn);
=09
	set_bit(bit, ul);
}

/*
 * clear_dynpageflags(dyn_pageflags_t *bitmap, struct page *page)
 *
 * Clear the flag for the page in the given bitmap.
 *
 */

void clear_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
{
	int zone_pfn =3D page_to_zone_offset(page);
	int zone_num =3D page_zone_number(page);
	int pagenum =3D PAGENUMBER(zone_pfn);
	int page_offset =3D PAGEINDEX(zone_pfn);
	unsigned long *ul =3D ((*bitmap)[zone_num][pagenum]) + page_offset;
	int bit =3D PAGEBIT(zone_pfn);
=09
	clear_bit(bit, ul);
}

/*
 * get_next_bit_on(dyn_pageflags_t bitmap, int counter)
 *
 * Given a pfn (possibly -1), find the next pfn in the bitmap that
 * is set. If there are no more flags set, return -1.
 *
 */

int get_next_bit_on(dyn_pageflags_t bitmap, int counter)
{
	struct page *page;
	struct zone *zone;
	unsigned long *ul =3D NULL;
	int zone_offset, pagebit, zone_num, first;

	first =3D (counter =3D=3D -1);
=09
	if (first)
		counter =3D first_online_pgdat()->node_zones->zone_start_pfn;

	page =3D pfn_to_page(counter);
	zone =3D page_zone(page);
	zone_num =3D page_zone_number(page);
	zone_offset =3D counter - zone->zone_start_pfn;

	if (first) {
		counter--;
		zone_offset--;
	}

	do {
		counter++;
		zone_offset++;
=09
		if (zone_offset >=3D zone->spanned_pages) {
			do {
				zone =3D next_zone(zone);
				if (!zone)
					return -1;
				zone_num++;
			} while(!zone->spanned_pages);

			counter =3D zone->zone_start_pfn;
			zone_offset =3D 0;
		}

		pagebit =3D PAGEBIT(zone_offset);

		if (!pagebit || !ul)
			ul =3D (bitmap[zone_num][PAGENUMBER(zone_offset)]) + PAGEINDEX(zone_offs=
et);

		if (!(*ul & ~((1 << pagebit) - 1))) {
			int increment =3D BITS_PER_LONG - pagebit - 1;
			counter +=3D increment;
			zone_offset +=3D increment;
			continue;
		}

	} while(!test_bit(pagebit, ul));

	return counter;
}


=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1157969.7fNPPfh8mh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoh5qN0y+n1M3mo0RAmmvAKDW1PrjMtEmkqUuCjT9iQ+tSQ4a3QCfceuy
dY0I2/b7Utt7umGcoodto78=
=ZgPY
-----END PGP SIGNATURE-----

--nextPart1157969.7fNPPfh8mh--
