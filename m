Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVJWPFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVJWPFq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 11:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbVJWPFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 11:05:46 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:19100 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750717AbVJWPFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 11:05:46 -0400
Subject: Re: [parisc-linux] Re: [PATCH 3/9] mm: parisc pte atomicity
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, parisc-linux@parisc-linux.org,
       linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <Pine.LNX.4.61.0510230930470.19527@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
	 <Pine.LNX.4.61.0510221722260.18047@goblin.wat.veritas.com>
	 <20051022163330.GD3364@parisc-linux.org>
	 <1130000925.6461.15.camel@mulgrave>
	 <Pine.LNX.4.61.0510230930470.19527@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Sun, 23 Oct 2005 10:05:31 -0500
Message-Id: <1130079931.3437.21.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-23 at 10:02 +0100, Hugh Dickins wrote:
> No thread, and I don't know of any problem reported.  It's just that
> in connection with my page fault scalability patches, splitting up the
> page_table_lock, I've had to search through architectures for pte code
> which may need changing.
> 
> Since translation_exists is doing no locking at present, it doesn't need
> any change to match my ptlock changes.  But it's a little worrying that
> it has no locking.  When called from flush_cache_page that's almost
> always right, and locking would just deadlock on locks already taken
> (I think core dumping uses flush_cache_page outside of locks, not a big
> deal).  But when called from flush_dcache_page, it's dealing with some
> other mm entirely: anything could happen at any moment.

Yes ... and flush_dcache_page() is the only one we really care about;
flush_cache_page() is just an optimisation.

> We're actually better off with my changes here than before.  Since you're
> coming from the vma_prio_tree, with the necessary locking on that, you
> can now be sure that the page tables won't get pulled out from under you
> (whereas before there was an unlikely window in which they might be).

OK, thanks.

> > 1) Make sure we execute flush_dcache_page() correctly (rather than
> > executing a flush that has no effect)
> > 2) optimise single page flushing: don't excite the tlb miss handlers if
> > there's no translation
> > 3) optimise pte lookup (that's why translation_exists returns the pte
> > pointer); since we already have to walk the page tables to answer the
> > question, the return value may as well be the pte entry or NULL rather
> > than true or false.
> 
> Regarding 3, I changed it to boolean because the only use made of the pte
> pointer was to check pfn: which check I folded inside translation_exists,
> so the pte it's checking for pfn cannot have changed since it was checked
> for being present (repeated dereferences of pte pointer without locking
> make me nervous, and I changed some code in other architectures for that).

Actually, yes, I think the code it was optimising already got removed,
so it's now a pointless optimisation.

Originally translation_exists returned any pte entry at all and it was
up to the caller to check the pte flags.

The change does slightly worry me in that it alters the behaviour of
flush_cache_page() because now it checks the pfn whereas previously it
didn't.  This means that previously we would flush the COW'd page of a
shared mapping, now we won't.

> I'm right, aren't I? that the previous pte_none test was actually letting
> through swap entries and pte_file entries which might look as if they had
> the right pfn, just by coincidence of their offsets?  So flush_dcache_page
> would stop, thinking it had done a good flush, when actually it hadn't.

Actually, no, pte_none() on parisc is either pte is zero or _PAGE_FLUSH
(which is our private flag saying we're preserving the pte entry for the
purposes of flushing even though it's gone) is set.  However, now that I
look at it, are you thinking our ptep_get_and_clear() should be doing a
check for _PAGE_PRESENT before it sets _PAGE_FLUSH?

> But races remain: the pte good at the moment translation_exists checks it,
> may have been taken out by kswapd a moment later (flush_dcache_mmap_lock
> only secures the vma_prio_tree structure, not ptes within the vmas);
> or it may have been COWed in the interval; or zapped from the mm.
> 
> Can you get a success code out of __flush_cache_page?  Or perhaps you
> should run translation_exists a second time after the  __flush_cache_page,
> to check nothing changed (the pte pointer would then be helpful, to save
> descending a second time)?  Or perhaps it all works out, that any such
> change which might occur, itself does the __flush_cache_page you need?

Yes, I know ... I never liked the volatility of this, but it's better
than what was there before, believe me (previously we just flushed the
first entry we found regardless).

Getting a return code out of __flush_dcache_page() is hard because it
doesn't know if the tlb miss handler nullified the instructions it's
trying to execute; and they're interruption handlers (meaning we don't
push anything on the stack for them, they run in shadow registers), so
getting a return code out of them is next to impossible.

For the flush to be effective in the VIPT cache, we have to have a
virtual address with a valid translation that points to the correct
physical address.  I suppose we could flush through the tmpalias space
instead.  That's where we set up an artifical translation that's not the
actual vaddr but instead is congruent to the vaddr so the mapping is
effective in cache aliasing terms.  Our congruence boundary is 4MB, so
we set up a private (per cpu) 4MB space (tmpalias) where we can set up
our pte's (or actually manufacture them in the tlb miss handler)
securely.

James


