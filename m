Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbVJMOKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbVJMOKv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 10:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbVJMOKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 10:10:51 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:10135 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751509AbVJMOKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 10:10:51 -0400
Date: Thu, 13 Oct 2005 15:10:27 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, jschopp@austin.ibm.com, kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2/8] Fragmentation Avoidance V17: 002_usemap
In-Reply-To: <1129211783.7780.7.camel@localhost>
Message-ID: <Pine.LNX.4.58.0510131500020.7570@skynet>
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie> 
 <20051011151231.16178.58396.sendpatchset@skynet.csn.ul.ie>
 <1129211783.7780.7.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2005, Dave Hansen wrote:

> On Tue, 2005-10-11 at 16:12 +0100, Mel Gorman wrote:
> > + extern int get_pageblock_type(struct zone *zone,
> > +						struct page *page);
>
> That indenting is pretty funky.
>

Unnecessary as well.

> > @@ -473,6 +491,15 @@ extern struct pglist_data contig_page_da
> >  #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
> >  #error Allocator MAX_ORDER exceeds SECTION_SIZE
> >  #endif
> > +#if ((SECTION_SIZE_BITS - MAX_ORDER) * BITS_PER_RCLM_TYPE) > 64
> > +#error free_area_usemap is not big enough
> > +#endif
>
> Every time I look at these patches, I see this #if, and I don't remember
> what that '64' means.  Can it please get a real name?
>

Joel, suggestions?

> > +/* Usemap initialisation */
> > +#ifdef CONFIG_SPARSEMEM
> > +static inline void setup_usemap(struct pglist_data *pgdat,
> > +				struct zone *zone, unsigned long zonesize) {}
> > +#endif /* CONFIG_SPARSEMEM */
> >
> >  struct page;
> >  struct mem_section {
> > @@ -485,6 +512,7 @@ struct mem_section {
> >  	 * before using it wrong.
> >  	 */
> >  	unsigned long section_mem_map;
> > +	DECLARE_BITMAP(free_area_usemap,64);
> >  };
>
> There's that '64' again!  You need a space after the comma, too.
>
> >  #ifdef CONFIG_SPARSEMEM_EXTREME
> > @@ -552,6 +580,17 @@ static inline struct mem_section *__pfn_
> >  	return __nr_to_section(pfn_to_section_nr(pfn));
> >  }
> >
> > +static inline unsigned long *pfn_to_usemap(struct zone *zone, unsigned long pfn)
> > +{
> > +	return &__pfn_to_section(pfn)->free_area_usemap[0];
> > +}
> > +
> > +static inline int pfn_to_bitidx(struct zone *zone, unsigned long pfn)
> > +{
> > +	pfn &= (PAGES_PER_SECTION-1);
> > +	return (int)((pfn >> (MAX_ORDER-1)) * BITS_PER_RCLM_TYPE);
> > +}
>
> Why does that return int?  Should it be "unsigned long", maybe?  Also,
> that cast is implicit in the return and shouldn't be needed.
>

It returns int because the bit functions like assign_bit() expect an int
for the bit index, not an unsigned long or anything else.

> >  #define pfn_to_page(pfn) 						\
> >  ({ 									\
> >  	unsigned long __pfn = (pfn);					\
> > @@ -589,6 +628,16 @@ void sparse_init(void);
> >  #else
> >  #define sparse_init()	do {} while (0)
> >  #define sparse_index_init(_sec, _nid)  do {} while (0)
> > +static inline unsigned long *pfn_to_usemap(struct zone *zone,
> > +						unsigned long pfn)
> > +{
> > +	return (zone->free_area_usemap);
> > +}
>
> "return" is not a function.  The parenthesis can go away.
>
> > +static inline int pfn_to_bitidx(struct zone *zone, unsigned long pfn)
> > +{
> > +	pfn = pfn - zone->zone_start_pfn;
> > +	return (int)((pfn >> (MAX_ORDER-1)) * BITS_PER_RCLM_TYPE);
> > +}
>
> Again, why the cast?
>

Same reason as above, bit functions expect an int for the index.

> >  #endif /* CONFIG_SPARSEMEM */
> >
> >  #ifdef CONFIG_NODES_SPAN_OTHER_NODES
> > diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-001_antidefrag_flags/mm/page_alloc.c linux-2.6.14-rc3-002_usemap/mm/page_alloc.c
> > --- linux-2.6.14-rc3-001_antidefrag_flags/mm/page_alloc.c	2005-10-04 22:58:34.000000000 +0100
> > +++ linux-2.6.14-rc3-002_usemap/mm/page_alloc.c	2005-10-11 12:07:26.000000000 +0100
> > @@ -66,6 +66,88 @@ EXPORT_SYMBOL(totalram_pages);
> >  EXPORT_SYMBOL(nr_swap_pages);
> >
> >  /*
> > + * RCLM_SHIFT is the number of bits that a gfp_mask has to be shifted right
> > + * to have just the __GFP_USER and __GFP_KERNRCLM bits. The static check is
> > + * made afterwards in case the GFP flags are not updated without updating
> > + * this number
> > + */
> > +#define RCLM_SHIFT 19
> > +#if (__GFP_USER >> RCLM_SHIFT) != RCLM_USER
> > +#error __GFP_USER not mapping to RCLM_USER
> > +#endif
> > +#if (__GFP_KERNRCLM >> RCLM_SHIFT) != RCLM_KERN
> > +#error __GFP_KERNRCLM not mapping to RCLM_KERN
> > +#endif
>
> Should this really be in page_alloc.c, or should it be close to the
> RCLM_* definitions?
>

I can't test it right now, but I think the reason it is here is because
RCLM_* and __GFP_* are in different headers that are not aware of each
other. This is the place a static compile-time check can be made.

> > +/*
> > + * This function maps gfpflags to their RCLM_TYPE. It makes assumptions
> > + * on the location of the GFP flags
> > + */
> > +static inline unsigned long gfpflags_to_rclmtype(unsigned long gfp_flags) {
> > +	return (gfp_flags & __GFP_RCLM_BITS) >> RCLM_SHIFT;
> > +}
>
> First brace on a new line, please.
>
> > +/*
> > + * copy_bits - Copy bits between bitmaps
> > + * @dstaddr: The destination bitmap to copy to
> > + * @srcaddr: The source bitmap to copy from
> > + * @sindex_dst: The start bit index within the destination map to copy to
> > + * @sindex_src: The start bit index within the source map to copy from
> > + * @nr: The number of bits to copy
> > + */
> > +static inline void copy_bits(unsigned long *dstaddr,
> > +		unsigned long *srcaddr,
> > +		int sindex_dst,
> > +		int sindex_src,
> > +		int nr)
> > +{
> > +	/*
> > +	 * Written like this to take advantage of arch-specific
> > +	 * set_bit() and clear_bit() functions
> > +	 */
> > +	for (nr = nr-1; nr >= 0; nr--) {
> > +		int bit = test_bit(sindex_src + nr, srcaddr);
> > +		if (bit)
> > +			set_bit(sindex_dst + nr, dstaddr);
> > +		else
> > +			clear_bit(sindex_dst + nr, dstaddr);
> > +	}
> > +}
>
> We might want to make a note that this is slow, and doesn't have any
> atomicity guarantees, either.

The comment can be put in, but this is only called with a spinlock held.
No arguements about it being slow though.

> But, it's functional, and certainly
> describes the operation that we wanted.  It's an improvement over what
> was there.
>
> BTW, this could probably be done with some fancy bitmask operations, and
> be more efficient.
>

Very likely but I was worred about corner cases if the value of
BITS_PER_RCLM_TYPE changed later to 3 or something. This time, I was going
for the safe choice.

> > +int get_pageblock_type(struct zone *zone,
> > +						struct page *page)
> > +{
> > +	unsigned long pfn = page_to_pfn(page);
> > +	unsigned long type = 0;
> > +	unsigned long *usemap;
> > +	int bitidx;
> > +
> > +	bitidx = pfn_to_bitidx(zone, pfn);
> > +	usemap = pfn_to_usemap(zone, pfn);
> > +
> > +	copy_bits(&type, usemap, 0, bitidx, BITS_PER_RCLM_TYPE);
> > +
> > +	return (int)type;
> > +}
>
> Where did all these casts come from?
>

It was pointed out that type used for use with the bit functions should
all be unsigned long, not int as they were previously. However, I found if
I used unsigned long throughout the code, including for array operations,
there was a 10-12% slowdown in AIM9. These casts were the compromise.
alloctype is unsigned long when used with the functions like assign_bit()
but int every other time.

In this case, there is an implicit cast so the cast is redundent if that
is the problem you are pointing out. I can remove the explicit casts that
are dotted around the place.

> > -static struct page *__rmqueue(struct zone *zone, unsigned int order)
> > +static struct page *__rmqueue(struct zone *zone, unsigned int order,
> > +		int alloctype)
> >  {
> >  	struct free_area * area;
> >  	unsigned int current_order;
> > @@ -486,6 +569,15 @@ static struct page *__rmqueue(struct zon
> >  		rmv_page_order(page);
> >  		area->nr_free--;
> >  		zone->free_pages -= 1UL << order;
> > +
> > +		/*
> > +		 * If splitting a large block, record what the block is being
> > +		 * used for in the usemap
> > +		 */
> > +		if (current_order == MAX_ORDER-1)
> > +			set_pageblock_type(zone, page,
> > +						(unsigned long)alloctype);
>
> This cast makes that line wrap, and makes it quite a bit less readable.
>
> >  		return expand(zone, page, order, current_order, area);
> >  	}
> >
> > @@ -498,7 +590,8 @@ static struct page *__rmqueue(struct zon
> >   * Returns the number of new pages which were placed at *list.
> >   */
> >  static int rmqueue_bulk(struct zone *zone, unsigned int order,
> > -			unsigned long count, struct list_head *list)
> > +			unsigned long count, struct list_head *list,
> > +			int alloctype)
> >  {
> >  	unsigned long flags;
> >  	int i;
> > @@ -507,7 +600,7 @@ static int rmqueue_bulk(struct zone *zon
> >
> >  	spin_lock_irqsave(&zone->lock, flags);
> >  	for (i = 0; i < count; ++i) {
> > -		page = __rmqueue(zone, order);
> > +		page = __rmqueue(zone, order, alloctype);
> >  		if (page == NULL)
> >  			break;
> >  		allocated++;
> > @@ -691,7 +784,8 @@ buffered_rmqueue(struct zone *zone, int
> >  	unsigned long flags;
> >  	struct page *page = NULL;
> >  	int cold = !!(gfp_flags & __GFP_COLD);
> > -
> > +	int alloctype = (int)gfpflags_to_rclmtype(gfp_flags);
> > +
>
> Just a note: that inserts whitespace.
>
> You can avoid these kinds of mistakes by keeping incremental patches.
> Start with your last set of work, and keep all changes to _that_ work in
> separate patches on top of the old.  You'll see only what you change and
> little tiny mishaps like this will tend to jump out more than in the
> hundreds of lines of the whole thing.
>

Understood.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
