Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUCMRYU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbUCMRYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:24:20 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:21873 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263117AbUCMRYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:24:11 -0500
Date: Sat, 13 Mar 2004 17:24:12 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Rik van Riel <riel@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <Pine.LNX.4.58.0403130759150.1045@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0403131653010.3585-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2004, Linus Torvalds wrote:
> 
> Ok, guys,
>  how about this anon-page suggestion?

What you describe is pretty much exactly what my anobjrmap patch
from a year ago did.  I'm currently looking through that again
to bring it up to date.

> I'm a bit nervous about the complexity issues in Andrea's current setup, 
> so I've been thinking about Rik's per-mm thing. And I think that there is 
> one very simple approach, which should work fine, and should have minimal 
> impact on the existing setup exactly because it is so simple.
> 
> Basic setup:
>  - each anonymous page is associated with exactly _one_ virtual address, 
>    in a "anon memory group". 
> 
>    We put the virtual address (shifted down by PAGE_SHIFT) into 
>    "page->index". We put the "anon memory group" pointer into 
>    "page->mapping". We have a PAGE_ANONYMOUS flag to tell the
>    rest of the world about this.

It's a bit more complicated because page->mapping currently contains
&swapper_space if PageSwapCache(page) - indeed, at present that's
exactly what PageSwapCache(page) tests.  So I reintroduced a
PageSwapCache(page) flagbit, avoid the very few places where mapping
pointing to swapper_space was actually useful, and use page->private
instead of page->index for the swp_entry_t.

(Andrew did point out that we could reduce the scale of the mods by
reusing page->list fields instead of mapping/index; but mapping/index
are the natural fields to use, and Andrew now has other changes in
-mm which remove page->list: so the original choice looks right again.)

> 		for_each_entry(mm, mmlist->anon_mms, anon_mm) {
> 			.. look up page in page tables in "mm, address" ..
> 			.. most of the time we may not even need to look ..
> 			.. up the "vma" at all, just walk the page tables ..
> 		}

I believe page_referenced() can just walk the page tables,
but try_to_unmap() needs vma to check VM_LOCKED (we're thinking
of other ways to avoid that, but they needn't get mixed into this)
and for flushing cache and tlb (perhaps avoidable on some arches?
I've not checked, and again that would be an optimization to
consider later, not mix in at this stage).

> The only problem is mremap() after a fork(), and hell, we know that's a
> special case anyway, and let's just add a few lines to copy_one_pte(),
> which basically does:
> 
> 	if (PageAnonymous(page) && page->count > 1) {
> 		newpage = alloc_page();
> 		copy_page(page, newpage);
> 		page = newpage;
> 	}
> 	/* Move the page to the new address */
> 	page->index = address >> PAGE_SHIFT;
> 
> and now we have zero special cases.

That's always been a fallback solution, I was just a little too ashamed
to propose it originally - seems a little wrong to waste whole pages
rather than wasting a few bytes of data structure trying to track them:
though the pages are pageable unlike any data structure we come up with.

I think we have page_table_lock in copy_one_pte, so won't want to do
it quite like that.  It won't matter at all if pages are transiently
untrackable.  Might want to do something like make_pages_present
afterwards (but it should only be COWing instantiated pages; and
does need to COW pages currently on swap too).

There's probably an issue with Alan's strict commit memory accounting,
if the mapping is readonly; but so long as we get that counting right,
I don't think it's really going to matter at all if we sometimes fail
an mremap for that reason - but probably need to avoid mistaking the
common case (mremap of own area) for the rare case which needs this
copying (mremap of inherited area).

Hugh

