Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268660AbRHKSUb>; Sat, 11 Aug 2001 14:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268617AbRHKSUV>; Sat, 11 Aug 2001 14:20:21 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:25606 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268660AbRHKSUJ>; Sat, 11 Aug 2001 14:20:09 -0400
Date: Sat, 11 Aug 2001 11:20:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8aa1
In-Reply-To: <20010811160231.C19169@athlon.random>
Message-ID: <Pine.LNX.4.33.0108111105470.15497-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea,
 mind cleaning this up a bit and not just papering over the horridness?

On Sat, 11 Aug 2001, Andrea Arcangeli wrote:
>
> This is the same problem I mentioned yesterday to the list. Nobody
> should ever use page->virtual directly, it's not there in -aa when
> highmem is disabled to save memory and increase performance, if it would
> be in C or python it would be a private field of the class to make it
> explicit (nitpicking, in python __ just rename and it's techincally
> still visible from the outside of the class).
>
> page_address(page) must be used instead of page->virtual.

It would be good to instead adding the functions

	unsigned long pte_to_pfn(pte_t pte)
	{
		.. architecture-specific in asm/pgtable.h ..
	}

	/*
	 * struct page -> "page frame number", ie
	 * physical page number.
	 */
	unsigned long page_to_pfn(struct page *page)
	{
		zone_t zone = page->zone;
		return (page - zone->zone_mem_map) + zone->zone_start_mapnr;
	}

	unsigned long long page_to_bus(struct page *page)
	{
		return (unsigned long long) phys_to_bus(page_to_pfn(page) << PAGE_SHIFT;
	}

and using those? As it is right now, drivers that _could_ use up to 4GB of
bus addresses simply cannot do it, because there is no good way to get the
high physical addresses from a "struct page".

(You can do the above by hand, of course, but device driver writers really
shouldn't know about the internals of page zone handling).

The things that you changed were all

	virt_to_bus( page_address (...) )

which really is rather distateful in that it artificially limits itself to
only lowmem code, and gets randomly incorrect values for anything else.

> @@ -107,7 +107,7 @@
>  	if( !pmd_present( *pmd ) ) return NOPAGE_OOM;
>  	pte = pte_offset( pmd, i );
>  	if( !pte_present( *pte ) ) return NOPAGE_OOM;
> -	physical = (unsigned long)pte_page( *pte )->virtual;
> +	physical = (unsigned long)page_address(pte_page( *pte ));
>  	atomic_inc(&virt_to_page(physical)->count); /* Dec. by kernel */

That is just too ugly for words. It's not a "physical" address at all, but
a virtual one, and we're getting the virtual address from the struct page
just to get back to the struct page.

It should really do

	struct page *page = pte_page( *pte );
	get_page(page);

instead..

		Linus

