Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933024AbWFZVLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933024AbWFZVLc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933046AbWFZVLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:11:32 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:11451 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S933024AbWFZVLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:11:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [Suspend2][] [Suspend2] Dynamically allocated pageflags
Date: Mon, 26 Jun 2006 23:11:50 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060626165209.10918.86526.stgit@nigel.suspend2.net> <20060626165211.10918.58434.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165211.10918.58434.stgit@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606262311.50846.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 June 2006 18:52, Nigel Cunningham wrote:
> Add support for dynamically allocated pageflags - bitmaps consisting of
> single pages merged together into per zone bitmaps that can then be used as
> temporary page flags.

IIRC, this has already been discussed on LKML and some people argued it would
be overkill.  Could you please say why you think it's not so?

Well, having read the entire patch I think I'd do this in a different way.
Namely, we can always use pfn_to_page() to get the struct page corresponding
to given PFN, so we can enumerate pages from 0 to max_pfn and create a
simple bitmap with one or more bits per PFN.  The only difficulty I see wrt
this is to make sure 0-order allocations are used for the bitmaps.

Anyway you can find some comments below.

Greetings,
Rafael


> Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> 
>  include/linux/dyn_pageflags.h |   66 ++++++++
>  lib/Kconfig                   |    3 
>  lib/Makefile                  |    2 
>  lib/dyn_pageflags.c           |  330 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 401 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/dyn_pageflags.h b/include/linux/dyn_pageflags.h
> new file mode 100644
> index 0000000..1a7b5d8
> --- /dev/null
> +++ b/include/linux/dyn_pageflags.h
> @@ -0,0 +1,66 @@
> +/*
> + * include/linux/dyn_pageflags.h
> + *
> + * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
> + *
> + * This file is released under the GPLv2.
> + *
> + * It implements support for dynamically allocated bitmaps that are
> + * used for temporary or infrequently used pageflags, in lieu of
> + * bits in the struct page flags entry.
> + */
> +
> +#ifndef DYN_PAGEFLAGS_H
> +#define DYN_PAGEFLAGS_H
> +
> +#include <linux/mm.h>
> +
> +typedef unsigned long *** dyn_pageflags_t;

Is this really necessary to define the dyn_pageflags_t here?

> +
> +#define BITNUMBER(page) (page_to_pfn(page))

I think it would be cleaner to use page_to_pfn(page) verbatim instead of this.

> +
> +#if BITS_PER_LONG == 32
> +#define UL_SHIFT 5
> +#else 
> +#if BITS_PER_LONG == 64
> +#define UL_SHIFT 6
> +#else
> +#error Bits per long not 32 or 64?
> +#endif
> +#endif
> +
> +#define BIT_NUM_MASK (sizeof(unsigned long) * 8 - 1)
> +#define PAGE_NUM_MASK (~((1 << (PAGE_SHIFT + 3)) - 1))
> +#define UL_NUM_MASK (~(BIT_NUM_MASK | PAGE_NUM_MASK))
> +
> +#define BITS_PER_PAGE (PAGE_SIZE << 3)
> +#define PAGENUMBER(zone_offset) (zone_offset >> (PAGE_SHIFT + 3))
> +#define PAGEINDEX(zone_offset) ((zone_offset & UL_NUM_MASK) >> UL_SHIFT)
> +#define PAGEBIT(zone_offset) (zone_offset & BIT_NUM_MASK)
> +
> +#define PAGE_UL_PTR(bitmap, zone_num, zone_pfn) \
> +       ((bitmap[zone_num][PAGENUMBER(zone_pfn)])+PAGEINDEX(zone_pfn))

All of the above definitions seem to be related in an opaque way.  Any chance
to make them a bit more clearer?  A comment, maybe?

> +
> +/* With the above macros defined, you can do...
> +
> +#define PagePageset1(page) (test_dynpageflag(&pageset1_map, page))
> +#define SetPagePageset1(page) (set_dynpageflag(&pageset1_map, page))
> +#define ClearPagePageset1(page) (clear_dynpageflag(&pageset1_map, page))
> +*/

I'd choose different names for these.  Also the definitions shouldn't go before
test/set/clear_dynpageflag() are defined, IMO.

> +
> +#define BITMAP_FOR_EACH_SET(bitmap, counter) \
> +	for (counter = get_next_bit_on(bitmap, -1); counter > -1; \
> +		counter = get_next_bit_on(bitmap, counter))
> +
> +extern void clear_dyn_pageflags(dyn_pageflags_t pagemap);
> +extern int allocate_dyn_pageflags(dyn_pageflags_t *pagemap);
> +extern void free_dyn_pageflags(dyn_pageflags_t *pagemap);
> +extern int dyn_pageflags_pages_per_bitmap(void);
> +extern int get_next_bit_on(dyn_pageflags_t bitmap, int counter);
> +extern unsigned long *dyn_pageflags_ul_ptr(dyn_pageflags_t *bitmap,
> +		struct page *pg);
> +
> +extern int test_dynpageflag(dyn_pageflags_t *bitmap, struct page *page);
> +extern void set_dynpageflag(dyn_pageflags_t *bitmap, struct page *page);
> +extern void clear_dynpageflag(dyn_pageflags_t *bitmap, struct page *page);
> +#endif
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 3de9335..5596bd8 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -38,6 +38,9 @@ config LIBCRC32C
>  	  require M here.  See Castagnoli93.
>  	  Module will be libcrc32c.
>  
> +config DYN_PAGEFLAGS
> +	bool
> +
>  #
>  # compression support is select'ed if needed
>  #
> diff --git a/lib/Makefile b/lib/Makefile
> index b830c9a..8290e9b 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -31,6 +31,8 @@ ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
>    lib-y += dec_and_lock.o
>  endif
>  
> +obj-$(CONFIG_DYN_PAGEFLAGS) += dyn_pageflags.o
> +
>  obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
>  obj-$(CONFIG_CRC16)	+= crc16.o
>  obj-$(CONFIG_CRC32)	+= crc32.o
> diff --git a/lib/dyn_pageflags.c b/lib/dyn_pageflags.c
> new file mode 100644
> index 0000000..4da52f5
> --- /dev/null
> +++ b/lib/dyn_pageflags.c
> @@ -0,0 +1,330 @@
> +/*
> + * lib/dyn_pageflags.c
> + *
> + * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
> + * 
> + * This file is released under the GPLv2.
> + *
> + * Routines for dynamically allocating and releasing bitmaps
> + * used as pseudo-pageflags.
> + *
> + * Arrays are not contiguous. The first sizeof(void *) bytes are
> + * the pointer to the next page in the bitmap. This allows us to
> + * work under low memory conditions where order 0 might be all
> + * that's available. In their original use (suspend2), it also
> + * lets us save the pages at suspend time, reload and relocate them
> + * as necessary at resume time without much effort.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/dyn_pageflags.h>
> +#include <linux/bootmem.h>
> +
> +#define page_to_zone_offset(pg) (page_to_pfn(pg) - page_zone(pg)->zone_start_pfn)
> +
> +/* 
> + * num_zones
> + * 
> + * How many zones are there?
> + *
> + */
> +
> +static int num_zones(void)
> +{
> +	int result = 0;
> +	struct zone *zone;
> +
> +	for_each_zone(zone)
> +		result++;
> +
> +	return result;
> +}

Do we really need this?

> +
> +/* 
> + * pages_for_zone(struct zone *zone)
> + * 
> + * How many pages do we need for a bitmap for this zone?
> + *
> + */
> +
> +static int pages_for_zone(struct zone *zone)
> +{
> +	return (zone->spanned_pages + (PAGE_SIZE << 3) - 1) >>
> +			(PAGE_SHIFT + 3);
> +}

Could you please explain the maths above?

> +
> +/*
> + * page_zone_number(struct page *page)
> + *
> + * Which zone index does the page match?
> + *
> + */
> +
> +static int page_zone_number(struct page *page)
> +{
> +	struct zone *zone, *zone_sought = page_zone(page);
> +	int zone_num = 0;
> +
> +	for_each_zone(zone)
> +		if (zone == zone_sought)
> +			return zone_num;
> +		else
> +			zone_num++;
> +
> +	printk("Was looking for a zone for page %p.\n", page);
> +	BUG_ON(1);
> +
> +	return 0;
> +}

Why can't we use page_zonenum() instead of this?

> +
> +/*
> + * dyn_pageflags_pages_per_bitmap
> + *
> + * Number of pages needed for a bitmap covering all zones.
> + *
> + */
> +int dyn_pageflags_pages_per_bitmap(void)
> +{
> +	int total = 0;
> +	struct zone *zone;
> +
> +	for_each_zone(zone)
> +		total += pages_for_zone(zone);
> +
> +	return total;
> +}

Why is a separate function needed for this?

> +
> +/* 
> + * clear_dyn_pageflags(dyn_pageflags_t pagemap)
> + *
> + * Clear an array used to store local page flags.
> + *
> + */
> +
> +void clear_dyn_pageflags(dyn_pageflags_t pagemap)
> +{
> +	int i = 0, zone_num = 0;
> +	struct zone *zone;
> +	
> +	BUG_ON(!pagemap);
> +
> +	for_each_zone(zone) {
> +		for (i = 0; i < pages_for_zone(zone); i++)
> +			memset((pagemap[zone_num][i]), 0, PAGE_SIZE);
> +		zone_num++;
> +	}
> +}

I think this could be done in a simpler way too.

> +
> +/* 
> + * allocate_dyn_pageflags(dyn_pageflags_t *pagemap)
> + *
> + * Allocate a bitmap for dynamic page flags.
> + *
> + */
> +int allocate_dyn_pageflags(dyn_pageflags_t *pagemap)
> +{
> +	int i, zone_num = 0;
> +	struct zone *zone;
> +
> +	BUG_ON(*pagemap);
> +
> +	*pagemap = kmalloc(sizeof(void *) * num_zones(), GFP_ATOMIC);

By using kmalloc(), you use slab.  I'd rather allocate entire pages.

> +
> +	if (!*pagemap)
> +		return -ENOMEM;
> +
> +	for_each_zone(zone) {
> +		int zone_pages = pages_for_zone(zone);
> +		(*pagemap)[zone_num] = kmalloc(sizeof(void *) * zone_pages,
> +					       GFP_ATOMIC);
> +
> +		if (!(*pagemap)[zone_num]) {
> +			kfree (*pagemap);

This seems to leak memory, eg. if *pagemap[0] is allocated, but the allocation
of *pagemap[1] fails.  You should free *pagemap[j] up to zone_num-1 and then
*pagemap, IMO.

> +			return -ENOMEM;
> +		}
> +
> +		for (i = 0; i < zone_pages; i++) {
> +			unsigned long address = get_zeroed_page(GFP_ATOMIC);
> +			(*pagemap)[zone_num][i] = (unsigned long *) address;
> +			if (!(*pagemap)[zone_num][i]) {
> +				printk("Error. Unable to allocate memory for "
> +					"dynamic pageflags.");
> +				free_dyn_pageflags(pagemap);
> +				return -ENOMEM;
> +			}
> +		}
> +		zone_num++;
> +	}
> +
> +	return 0;
> +}
> +
> +/* 
> + * free_dyn_pageflags(dyn_pageflags_t *pagemap)
> + *
> + * Free a dynamically allocated pageflags bitmap. For Suspend2 usage, we
> + * support data being relocated from slab to pages that don't conflict
> + * with the image that will be copied back. This is the reason for the
> + * PageSlab tests below.
> + *
> + */
> +void free_dyn_pageflags(dyn_pageflags_t *pagemap)
> +{
> +	int i = 0, zone_num = 0;
> +	struct zone *zone;
> +
> +	if (!*pagemap)
> +		return;
> +	
> +	for_each_zone(zone) {
> +		int zone_pages = pages_for_zone(zone);
> +
> +		if (!((*pagemap)[zone_num]))
> +			continue;
> +		for (i = 0; i < zone_pages; i++)
> +			if ((*pagemap)[zone_num][i])
> +				free_page((unsigned long) (*pagemap)[zone_num][i]);
> +	
> +		if (PageSlab(virt_to_page((*pagemap)[zone_num])))
> +			kfree((*pagemap)[zone_num]);
> +		else
> +			free_page((unsigned long) (*pagemap)[zone_num]);
> +
> +		zone_num++;
> +	}
> +
> +	if (PageSlab(virt_to_page((*pagemap))))
> +		kfree(*pagemap);
> +	else
> +		free_page((unsigned long) (*pagemap));

Why so?

> +
> +	*pagemap = NULL;
> +	return;
> +}
> +
> +/*
> + * dyn_pageflags_ul_ptr(dyn_pageflags_t *bitmap, struct page *pg)
> + *
> + * Get a pointer to the unsigned long containing the flag in the bitmap
> + * for the given page.
> + *
> + */
> +
> +unsigned long *dyn_pageflags_ul_ptr(dyn_pageflags_t *bitmap, struct page *pg)
> +{
> +	int zone_pfn = page_to_zone_offset(pg);
> +	int zone_num = page_zone_number(pg);
> +	int pagenum = PAGENUMBER(zone_pfn);
> +	int page_offset = PAGEINDEX(zone_pfn);
> +	return ((*bitmap)[zone_num][pagenum]) + page_offset;
> +}

It doesn't look very efficient, does it? ;-)

> +
> +/*
> + * test_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
> + *
> + * Is the page flagged in the given bitmap?
> + *
> + */
> +
> +int test_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
> +{
> +	unsigned long *ul = dyn_pageflags_ul_ptr(bitmap, page);
> +	int zone_offset = page_to_zone_offset(page);
> +	int bit = PAGEBIT(zone_offset);
> +	
> +	return test_bit(bit, ul);
> +}
> +
> +/*
> + * set_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
> + *
> + * Set the flag for the page in the given bitmap.
> + *
> + */
> +
> +void set_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
> +{
> +	unsigned long *ul = dyn_pageflags_ul_ptr(bitmap, page);
> +	int zone_offset = page_to_zone_offset(page);
> +	int bit = PAGEBIT(zone_offset);
> +	set_bit(bit, ul);
> +}
> +
> +/*
> + * clear_dynpageflags(dyn_pageflags_t *bitmap, struct page *page)
> + *
> + * Clear the flag for the page in the given bitmap.
> + *
> + */
> +
> +void clear_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
> +{
> +	unsigned long *ul = dyn_pageflags_ul_ptr(bitmap, page);
> +	int zone_offset = page_to_zone_offset(page);
> +	int bit = PAGEBIT(zone_offset);
> +	clear_bit(bit, ul);
> +}
> +
> +/*
> + * get_next_bit_on(dyn_pageflags_t bitmap, int counter)
> + *
> + * Given a pfn (possibly -1), find the next pfn in the bitmap that
> + * is set. If there are no more flags set, return -1.
> + *
> + */
> +
> +int get_next_bit_on(dyn_pageflags_t bitmap, int counter)
> +{
> +	struct page *page;
> +	struct zone *zone;
> +	unsigned long *ul = NULL;
> +	int zone_offset, pagebit, zone_num, first;
> +
> +	first = (counter == -1);
> +	
> +	if (first)
> +		counter = first_online_pgdat()->node_zones->zone_start_pfn;
> +
> +	page = pfn_to_page(counter);
> +	zone = page_zone(page);
> +	zone_num = page_zone_number(page);
> +	zone_offset = counter - zone->zone_start_pfn;
> +
> +	if (first) {
> +		counter--;
> +		zone_offset--;
> +	} else
> +		ul = (bitmap[zone_num][PAGENUMBER(zone_offset)]) + PAGEINDEX(zone_offset);
> +
> +	do {
> +		counter++;
> +		zone_offset++;
> +	
> +		if (zone_offset >= zone->spanned_pages) {
> +			do {
> +				zone = next_zone(zone);
> +				if (!zone)
> +					return -1;
> +				zone_num++;
> +			} while(!zone->spanned_pages);
> +
> +			counter = zone->zone_start_pfn;
> +			zone_offset = 0;
> +		}
> +		
> +		/*
> +		 * This could be optimised, but there are more
> +		 * important things and the code is simple at
> +		 * the moment 
> +		 */

Please let me disagree with this comment.  I think it would be more efficient
if you searched the bitmap for the first zero bit and then find the page, pfn,
whatever corresponding to this bit.

> +		pagebit = PAGEBIT(zone_offset);
> +
> +		if (!pagebit)
> +			ul = (bitmap[zone_num][PAGENUMBER(zone_offset)]) + PAGEINDEX(zone_offset);
> +
> +	} while(!test_bit(pagebit, ul));
> +
> +	return counter;
> +}
> +
