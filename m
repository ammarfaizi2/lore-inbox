Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbUKVOrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbUKVOrC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 09:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbUKVOp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:45:26 -0500
Received: from holomorphy.com ([207.189.100.168]:37273 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261537AbUKVOlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:41:53 -0500
Date: Mon, 22 Nov 2004 06:41:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compound page overhaul
Message-ID: <20041122144127.GE2714@holomorphy.com>
References: <11948.1101130077@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11948.1101130077@redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 01:27:57PM +0000, David Howells wrote:
> The attached patch overhauls compound page handling.

There's not really much to object to in concept.


On Mon, Nov 22, 2004 at 01:27:57PM +0000, David Howells wrote:
>  (1) A new bit flag PG_compound_slave has been added. This is used to mark the
>      second+ subpages of a compound page, thus making get_page() and
>      put_page() able to determine the need to perform weird stuff quickly.
>      This could be changed to do horribly things with the page count or to
>      abuse the page->lru member instead of eating another page flag.

There are a lot of ways to do these things. Most of it is bitpacking
and dodging assumptions in other code about various fields always being
something or other they expect (e.g. bh's vs. page->private).


On Mon, Nov 22, 2004 at 01:27:57PM +0000, David Howells wrote:
>  (2) Compound page metadata is now always set on high-order pages when
>      allocating and always checked when freeing:
> 	- PG_compound is set on all subpages
> 	- PG_compound_slave is set on all but the first subpage
> 	- page[1].index holds the compound page order
> 	- page[1...N-1].private points to page[0]
> 	- page[1].mapping may hold a destructor function for put_page()
>      This is now done in prep_new_page().

A generally innocuous rearrangement. Some explanation of the advantage
of these new bitpacking and field arrangements over the current
arrangement may be good to have.


On Mon, Nov 22, 2004 at 01:27:57PM +0000, David Howells wrote:
>  (3) __page_first() is now provided to find the first page of any page set
>      (even single page sets).

I have to question the underscores. Also, there's a commonly-used term
in the superpage literature, ``head of the superpage'', that may be
more easily recognizable for readers familiar with that but not Linux
specifics, but that's just nomenclature and not particularly pressing
or any kind of requirement, just a non-Linux precedent.


On Mon, Nov 22, 2004 at 01:27:57PM +0000, David Howells wrote:
>  (4) A new config option ENHANCED_COMPOUND_PAGES is now available. This is
>      only set on !MMU or HUGETLB_PAGE. It causes __page_first() to dereference
>      page->private if PG_compound_slave is set.
>  (5) __GFP_COMP is no longer required since compound metadata is always now
>      set.

__GFP_COMP was introduced because several unusual drivers allocate
higher-order pages and then move on to free fragments of them. There's
a small danger some others may allocate higher-order pages and then
treat each piece as a separate entity (particularly in the freeing pass).

Sweeping affected drivers to use a fragmenting primitive may help here.


On Mon, Nov 22, 2004 at 01:27:57PM +0000, David Howells wrote:
>  (6) compound_page_order() is now available. This will indicate the order of
>      any page, high-order or not.
>      Since it is now trivial to work out the order of any page, free_pages()
>      and co could all lose their order arguments.

Possible, but it's likely a micro-optimization to cache the order in
registers across function calls. The allocator is something of a
``hot path'' and small alterations can have noticeable effects.


On Mon, Nov 22, 2004 at 01:27:57PM +0000, David Howells wrote:
>  (7) Trailing spaces have been cleaned up on lines in page_alloc.c.

I like this quite a bit. =)


On Mon, Nov 22, 2004 at 01:27:57PM +0000, David Howells wrote:
>  (8) bootmem.c now has a separate path to release pages to the main allocator
>      that bypasses many of the checks performed on struct pages.
>      bootmem.c's page releaser could be improved by giving the boot
>      allocator's bitmap sufficient bits to make sure bit 0 is 32-page or
>      64-page aligned (depending on bits/long), even if the page to which it
>      corresponds doesn't actually exist.

Clearly it could merely scan the bitmap for the largest properly-sized,
properly-aligned leading run of free bits beyond even that, though I
wouldn't expect you to pursue that as it's far beyond the scope of the
patch. I was hit up to deal with bootmem.c issues, and will be looking
into that and more after the current set of bootmem changes has settled
down and ia64 bootstrap has been stable for a while.


On Mon, Nov 22, 2004 at 01:27:57PM +0000, David Howells wrote:
>  (9) bad_page() now prints more information, including information about more
>      pages in the case of a compound page.
> (10) prep_compound_page() and destroy_compound_page() have been absorbed.

Not much to say about these.


On Mon, Nov 22, 2004 at 01:27:57PM +0000, David Howells wrote:
> (11) A lot more unlikely() clauses have been inserted in the free page
>      checking functions.

Some people aren't wild about the branch prediction hints, though error
checking is the poster child for ``predict not taken''.


On Mon, Nov 22, 2004 at 01:27:57PM +0000, David Howells wrote:
> (12) The !MMU bits have all gone from page_alloc.c.
> (13) __pagevec_free() has moved to swap.c with all the other pagevec
>      functions.
> (14) put_page() has moved to page_alloc.c with all the other related
>      functions. This could be relegated to a separate file, but since there
>      are many other conditionals in page_alloc.c, what's the point?

Not much to say here, either.

So, going over the code:

(1) the set_page_count() parenthesization is probably qualifies as a
	fix for a latent bug.

(2) The physaddr alignment comment in bootmem.c is mangled. It's not
	O(LOG2(BITS_PER_LONG)) -aligned, it's exactly LOG2(BITS_PER_LONG)
	aligned. But we don't have a LOG2(...) macro, we have fls()/ffs().

(3) page_count() probably deserves the %0*lx treatment in __bad_page().
	Conserving screenspace when possible helps some, though that's
	offset a bit against predictable field alignment. Maybe putting
	variable-length fields at the end of the line would help. Also,
	the pfn would be great to have there, too, while you're at it.

(4) I wonder if anyone's run with CONFIG_DEBUG_PAGEALLOC recently.
	bootmem.c seems a bit early for kernel_map_pages() et al.
	It could be okay depending.

(5) This patch does a fair number of different things and it takes a
	bit of effort to wade through some of the longer rearrangements
	as they overflow 80x24. It would be helpful for reviewers if you
	could break this down into a somewhat more easily-digestible
	series of smaller patches.

Anyway, a more intense review from me will have to wait until my
current hugetlb bughunt is wrapped up.


-- wli
