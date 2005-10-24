Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbVJXEh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbVJXEh3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 00:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbVJXEh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 00:37:28 -0400
Received: from gold.veritas.com ([143.127.12.110]:64663 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750977AbVJXEh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 00:37:28 -0400
Date: Mon, 24 Oct 2005 05:36:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, parisc-linux@parisc-linux.org,
       linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
Subject: Re: [parisc-linux] Re: [PATCH 3/9] mm: parisc pte atomicity
In-Reply-To: <1130079931.3437.21.camel@mulgrave>
Message-ID: <Pine.LNX.4.61.0510240441570.22402@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com> 
 <Pine.LNX.4.61.0510221722260.18047@goblin.wat.veritas.com> 
 <20051022163330.GD3364@parisc-linux.org>  <1130000925.6461.15.camel@mulgrave>
  <Pine.LNX.4.61.0510230930470.19527@goblin.wat.veritas.com>
 <1130079931.3437.21.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Oct 2005 04:37:27.0762 (UTC) FILETIME=[A33F6320:01C5D854]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2005, James Bottomley wrote:
> On Sun, 2005-10-23 at 10:02 +0100, Hugh Dickins wrote:
> 
> The change does slightly worry me in that it alters the behaviour of
> flush_cache_page() because now it checks the pfn whereas previously it
> didn't.  This means that previously we would flush the COW'd page of a
> shared mapping, now we won't.

Perhaps you're thinking of some use of flush_cache_page that no longer
exists in the tree?  All the uses I see are passing in the right pfn,
and the question is why translation_exists even gets called by it.

Even those uses of flush_cache_page in asm-parisc/cacheflush.h itself
(which I'd missed before): copy_to_user_page and copy_from_user_page
are only used by nothing but access_process_vm, after get_user_pages:
so any COW has already been done, and the right pfn is passed in.

> > I'm right, aren't I? that the previous pte_none test was actually letting
> > through swap entries and pte_file entries which might look as if they had
> > the right pfn, just by coincidence of their offsets?  So flush_dcache_page
> > would stop, thinking it had done a good flush, when actually it hadn't.
> 
> Actually, no, pte_none() on parisc is either pte is zero or _PAGE_FLUSH
> (which is our private flag saying we're preserving the pte entry for the
> purposes of flushing even though it's gone) is set.

Sorry, "pte_none test" was my lazy shorthand for the actual test:
	if(pte_none(*pte) && ((pte_val(*pte) & _PAGE_FLUSH) == 0))
		return NULL;
from which point on it assumes the pte is valid.  I'm contending that
a swap entry or pte_file entry does not return NULL there, so is then
treated as a valid pte: and pte_pfn on it might match the target pfn.

I believe my
	/* Filter out coincidental file entries and swap entries */
	if (!(pte_val(pte) & (_PAGE_FLUSH|_PAGE_PRESENT)))
		return 0;
is correct, and avoids that problem (plus avoiding the complication
of parisc's unintuitive pte_none).

> However, now that I
> look at it, are you thinking our ptep_get_and_clear() should be doing a
> check for _PAGE_PRESENT before it sets _PAGE_FLUSH?

That's certainly not what I was thinking.  No, I'm pretty sure that
ptep_get_and_clear only gets called when we've got the right lock and
know the pte is present: I don't think you need to make any change there.
(The "pretty sure" reflecting that there's a bit of a macro maze here now,
so actually following up each reference would take a bit longer.)

But you may be seeing something I don't see: I've only just met your
_PAGE_FLUSH, and that unusual pte_none might be letting something
through that I'm overlooking, that you're aware of.

> > But races remain: the pte good at the moment translation_exists checks it,
> > may have been taken out by kswapd a moment later (flush_dcache_mmap_lock
> > only secures the vma_prio_tree structure, not ptes within the vmas);
> > or it may have been COWed in the interval; or zapped from the mm.
> > 
> > Can you get a success code out of __flush_cache_page?  Or perhaps you
> > should run translation_exists a second time after the  __flush_cache_page,
> > to check nothing changed (the pte pointer would then be helpful, to save
> > descending a second time)?  Or perhaps it all works out, that any such
> > change which might occur, itself does the __flush_cache_page you need?
> 
> Yes, I know ... I never liked the volatility of this, but it's better
> than what was there before, believe me (previously we just flushed the
> first entry we found regardless).

I do believe you!

> Getting a return code out of __flush_dcache_page() is hard because it
> doesn't know if the tlb miss handler nullified the instructions it's
> trying to execute; and they're interruption handlers (meaning we don't
> push anything on the stack for them, they run in shadow registers), so
> getting a return code out of them is next to impossible.

Right, it was just a thought.

> For the flush to be effective in the VIPT cache, we have to have a
> virtual address with a valid translation that points to the correct
> physical address.  I suppose we could flush through the tmpalias space
> instead.  That's where we set up an artifical translation that's not the
> actual vaddr but instead is congruent to the vaddr so the mapping is
> effective in cache aliasing terms.  Our congruence boundary is 4MB, so
> we set up a private (per cpu) 4MB space (tmpalias) where we can set up
> our pte's (or actually manufacture them in the tlb miss handler)
> securely.

I have no appreciation at all how that would compare.  On the one hand
it sounds like a lot of overhead you'd understandably prefer to avoid;
on the other hand, this hit-and-miss search of the vma_prio_tree might
be a worse overhead better avoided.   I've no appreciation at all.

But I made two suggestions above that might be less work.  One,
requiring no work but research, that _perhaps_ in all the racy cases
you can rely on the __flush_cache_page having been done by the racer?
I can't tell, and it may be obvious to you that that's a non-starter.

Other, that you just check the pte again after the __flush_cache_page,
if it's no longer right then assume the flush didn't work and continue.
There is a small chance that the pte was right before, wrong during the
flush, then right after (something else faulted it back in, while we
were away... I was about to say handling an interrupt, but actually
even interrupts are disabled here by flush_dcache_mmap_lock, since
that's a reuse of mapping->tree_lock).  But it would improve the
safety by several orders of magnitude.

Hugh
