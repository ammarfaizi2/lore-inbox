Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030696AbWHILqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030696AbWHILqu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030707AbWHILqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:46:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030696AbWHILqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:46:49 -0400
Date: Wed, 9 Aug 2006 13:46:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
Subject: Re: [RFC][PATCH -mm 1/5] swsusp: Introduce memory bitmaps
Message-ID: <20060809114628.GR3308@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608091158.38458.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608091158.38458.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Introduce the memory bitmap data structure and make swsusp use in the suspend
> phase.
> 
> The current swsusp's internal data structure is not very efficient from the
> memory usage point of view, so it seems reasonable to replace it with a data
> structure that will require less memory, such as a pair of bitmaps.
> 
> The idea is to use bitmaps that may be allocated as sets of individual pages,
> so that we can avoid making allocations of order greater than 0.  For this
> reason the memory bitmap structure consists of several linked lists of objects
> that contain pointers to memory pages with the actual bitmap data.  Still, for
> a typical system all of these lists fit in a single page, so it's reasonable
> to introduce an additional mechanism allowing us to allocate all of them
> efficiently without sacrificing the generality of the design.  This is done
> with the help of the chain_allocator structure and associated functions.
> 
> We need to use two memory bitmaps during the suspend phase of the
> suspend-resume cycle.  One of them is necessary for marking the saveable
> pages, and the second is used to mark the pages in which to store the copies
> of them (aka image pages).
> 
> First, the bitmaps are created and we allocate as many image pages as needed
> (the corresponding bits in the second bitmap are set as soon as the pages are
> allocated).  Second, the bits corresponding to the saveable pages are set in
> the first bitmap and the saveable pages are copied to the image pages.
> Finally, the first bitmap is used to save the kernel virtual addresses of the
> saveable pages and the second one is used to save the contents of the image
> pages.

Maybe that bitmap code should go to kernel/power/bitmaps.c or
something?

> +static inline void bm_position_reset_chunk(struct memory_bitmap *bm)
> +{
> +	bm->cur.chunk = 0;
> +	bm->cur.bit = -1;
> +}
> +
> +static void bm_position_reset(struct memory_bitmap *bm)
> +{
> +	struct zone_bitmap *zone_bm;
> +
> +	zone_bm = bm->zone_bm_list;
> +	bm->cur.zone_bm = zone_bm;
> +	bm->cur.block = zone_bm->bm_blocks;
> +	bm_position_reset_chunk(bm);
> +}
> +
> +static void free_memory_bm(struct memory_bitmap *bm, int
> clear_nosave_free);

All your other functions use bm_XXX, this is XXX_bm. Well, you are
mixing it rather freely..

> +/**
> + *	memory_bm_set_bit - set the bit in the bitmap @bm that corresponds
> + *	to given pfn.  The cur_zone_bm member of @bm and the cur_block member
> + *	of @bm->cur_zone_bm are updated.
> + *
> + *	If the bit cannot be set, the function returns -EINVAL .
> + */
> +
> +static int
> +memory_bm_set_bit(struct memory_bitmap *bm, unsigned long pfn)
> +{
> +	struct zone_bitmap *zone_bm;
> +	struct bm_block *bb;
> +
> +	/* Check if the pfn is from the current zone */
> +	zone_bm = bm->cur.zone_bm;
> +	if (pfn < zone_bm->start_pfn || pfn >= zone_bm->end_pfn) {
> +		zone_bm = bm->zone_bm_list;
> +		/* We don't assume that the zones are sorted by pfns */
> +		while (pfn < zone_bm->start_pfn || pfn >= zone_bm->end_pfn) {
> +			zone_bm = zone_bm->next;
> +			if (unlikely(!zone_bm))
> +				return -EINVAL;
> +		}
> +		bm->cur.zone_bm = zone_bm;
> +	}
> +	/* Check if the pfn corresponds to the current bitmap block */
> +	bb = zone_bm->cur_block;
> +	if (pfn < bb->start_pfn)
> +		bb = zone_bm->bm_blocks;
> +
> +	while (pfn >= bb->end_pfn) {
> +		bb = bb->next;
> +		if (unlikely(!bb))
> +			return -EINVAL;
> +	}
> +	zone_bm->cur_block = bb;
> +	pfn -= bb->start_pfn;
> +	set_bit(pfn % BM_BITS_PER_CHUNK, bb->data + pfn / BM_BITS_PER_CHUNK);
> +	return 0;
> +}

It seems like this will not really introduce O(n^2) behaviour, since
you are starting from last position each time?

You have my ACK here, but maybe it should go _after_ 4/5 and 5/5?
Those are simple cleanups, this has break-something-potential and
should rest in -mm for a while.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
