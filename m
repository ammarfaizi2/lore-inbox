Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316096AbSEWGBb>; Thu, 23 May 2002 02:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316106AbSEWGBa>; Thu, 23 May 2002 02:01:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15891 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316096AbSEWGB2>; Thu, 23 May 2002 02:01:28 -0400
Date: Wed, 22 May 2002 23:01:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Q: backport of the free_pgtables tlb fixes to 2.4
In-Reply-To: <20020523051454.GO21164@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0205222242120.9440-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 May 2002, Andrea Arcangeli wrote:
>
> I'm dealing with the backport of the free_pgtables() tlb flushes fixes
> to 2.4 (got interrupted with it in the middle of the inode highmem
> imbalance). I seen a patch and an explanation floating around but it's
> wrong as far I can tell in the sense it seems completly a noop.

Don't take the 2.5.x tree - those changes are bigger than necessary. They
may be _cleaner_ than the quick fix, but I don't think it's worth it for
2.4.x.

The suggested fix for 2.4.x is basically:
 - enable pmd quicklists
 - do a TLB flush _before_ doing the check_pgt_cache() that might free up
   the quicklist, and make sure that nothing else runs on that CPU that
   might get something from the quicklist (interrupts don't do it, so the
   only thing to make sure is that we don't get preempted).

That should do it. Intel made a patch that they've apparently tested that
does this, I think.

> Also it's not related to the P4 cpu, it's just a generic bug for all
> archs it seems.

Well, the hardware has to do a hw tlb walk, so that cuts down the affected
archs to not very many. And the hw has to do a fair amount of speculation,
or support SMP, so that cuts it down even further.

But yes, in theory the bug is generic.

> In both 2.4 and 2.5 we were just doing the release of the pages
> correctly in zap_page_range, by clearing the pte entry, then
> invalidating the tlb and finally freeing the page, I can't see problems
> in the normal do_munmap path unless free_pgtables triggers too.

Right, it's free_pgtables that matters, and we need to do the same
"deferred free" (deferred until the TLB invalidate) as for the actual
pages themselves. "pmd_quicklist" can act as such a deferral method.

In 2.5.x, I wanted to make the deferral explicit, which is why the 2.5.x
approach re-did the thing to make the whole "TLB gather" cover the page
table freeing too.

> So the fix is simply to
> extend the tlb_gather_mm/tlb_finish_mmu/tlb_remove_page to the
> free_pgtables path too (while dropping pte/pmd), so in turn to
> clear_page_tables, even if only the "free_pgtables" caller really needs
> it.

This is indeed exactly what 2.5.x does, but see above about it.

> I don't see why you changed the "fast mode" to 1 cpu (even without an
> #ifdef SMP), if the mm_users is == 1 we are just guaranteed that no
> parallel reading of the address space that we're working on can happen

Yes, but there is ANOTHER race, and this is actually the much more likely
one, and the one that actually happens:

	CPU1		CPU2

	munmap
	.. speculation starts ..
	.. TLB looks up pgd entry ..
	clear pgd entry
	free pmd

			alloc page - get old pmd
			scribble on page

	.. TLB looks up pmd entry ..
	.. tlb fill ends ...
	invalidate_tlb

CPU2 can be doing something completely _unrelated_ and not have the same
MM at all. The bug happens entirely within the TLB contents of CPU1,
simply because the CPU1 speculation started a TLB fill, which looked up
the PGD entry _before_ it was cleared, but because of a cache miss got
delayed at the point where it was going to look up the PTE entry. In the
meantime, CPU1 free'd the page, and another CPU scribbled stuff on it.

So we not have an invalid entry in the TLB on cpu1 - and while we will
invalidate the TLB, if the entry had the global bit set that bad random
entry would NOT get invalidated.

This, btw, is why in practice the thing only shows up on a P4. Only a P4
has deep enough speculation queues that this bug actually happens. Intel
apparently had this trace for 2000 (yes, two THOUSAND) cycles that showed
this asynchronous TLB lookup.

> About the patch floating around I also seen random changes in leave_mm
> that I cannot explain (that's in 2.5 too, I think that part of 2.5
> is superflous too infact)

Here the issue is:

	CPU1			CPU2

				Lazy TLB of same MM as on CPU1
	munmap()		.. start speculative TLB fetch ...
	.. free_pgtable
	.. invalidate   ->	crosscall tlb_IPI
				We're lazy, nothing to do
	free page
	alloc page
	scribble on it
				 .. speculative TLB lookup ends ..
				get a bogus TLB entry with G bit


According to intel, the _only_ thing that serializes the TLB fills is to
do a TLB invalidate (either invlpg or mov->cr3). So not even the
cross-call itself necessarily does anything to the background TLB fetch.

So even the lazy case needs to do that, at which point it is just as well
to just move to another stabler page table (it's actually faster than
doing the cr3<->cr3 dance).

NOTE! This was not seen in any traces, but Intel was worried.

> explanation of why the above is superflous: every time a task enters the
> lazy state we bump the mm_users so the active_mm is pinned somehow and
> nothing can throw away the kernel side of the pgd

The page tables are freed, the same race can occur.

> A change like this (not from 2.5) as well is obviously superflous:

That's the intel patch - they just prefer that order, but they admitted it
doesn't matter.

> This below change as well is superflous after we backout the above
> change to leave_mm.

Don't back it out.

> This actually gets more near to the real problem...
>
>  static inline void flush_tlb_pgtables(struct mm_struct *mm,
>  				      unsigned long start, unsigned long end)
>  {
> -	/* i386 does not keep any page table caches in TLB */
> +	flush_tlb_mm(mm);
>  }

The above, _together_ with moving it to before the check_pgt_cache() (and
removing some other TLB flushes that are now superfluous).

In short, the Intel patch is good.

		Linus

