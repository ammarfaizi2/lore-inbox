Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317003AbSEWT6y>; Thu, 23 May 2002 15:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317001AbSEWT6y>; Thu, 23 May 2002 15:58:54 -0400
Received: from [195.223.140.120] ([195.223.140.120]:9482 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317000AbSEWT6l>; Thu, 23 May 2002 15:58:41 -0400
Date: Thu, 23 May 2002 21:57:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: backport of the free_pgtables tlb fixes to 2.4
Message-ID: <20020523195757.GW21164@dualathlon.random>
In-Reply-To: <20020523051454.GO21164@dualathlon.random> <Pine.LNX.4.44.0205222242120.9440-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 11:01:28PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 23 May 2002, Andrea Arcangeli wrote:
> >
> > I'm dealing with the backport of the free_pgtables() tlb flushes fixes
> > to 2.4 (got interrupted with it in the middle of the inode highmem
> > imbalance). I seen a patch and an explanation floating around but it's
> > wrong as far I can tell in the sense it seems completly a noop.
> 
> Don't take the 2.5.x tree - those changes are bigger than necessary. They
> may be _cleaner_ than the quick fix, but I don't think it's worth it for
> 2.4.x.
> 
> The suggested fix for 2.4.x is basically:
>  - enable pmd quicklists

actually the pte_quicklist only, the 4 pmd are always associated with
the pgd even with pae.

>  - do a TLB flush _before_ doing the check_pgt_cache() that might free up
>    the quicklist, and make sure that nothing else runs on that CPU that

I see how the patch is supposed to work, such subtle dependency on doing
the check_pgt_cache after the tlb invalidate wasn't commented in the
patch, it deserves a fat comment or it's really hard to guess we depend
on it. the main reason being that pte_free semantics are really "free
like if I put back in the freelist", not "don't touch it until
check_pgt_cache", because remember the pte_free clobbers the contents of
the pte with "random" data, this random data happens to have the
property on x86 that all the last 2 bits are always zero, so the last
two bits aren't random, and with this conicidence plus the other
coincidence that the invalid bit of the pte is the less significant bit
in the pte entry, it can actually work on x86, but it can very well not
work on other archs if the invalid bit isn't the last one or if they
stores something else and not a virtual addess in the pte entry chain.

In short the "pte_free" must clobber the pte in a way that lefts it
invalid, so that we're guaranteed to generate a page fault, this
requirement also deserves a big fat comment. I couldn't guess the
dependency of the fix on the lowlevel details of the quicklist
releasing, on the invalid bits of the pte and finally on the bits
guaranteed to be zero, not sure if that was just obvious to all the arch
maintainers.

>    might get something from the quicklist (interrupts don't do it, so the
>    only thing to make sure is that we don't get preempted).
> 
> That should do it. Intel made a patch that they've apparently tested that
> does this, I think.
> 
> > Also it's not related to the P4 cpu, it's just a generic bug for all
> > archs it seems.
> 
> Well, the hardware has to do a hw tlb walk, so that cuts down the affected
> archs to not very many. And the hw has to do a fair amount of speculation,
> or support SMP, so that cuts it down even further.
> 
> But yes, in theory the bug is generic.
> 
> > In both 2.4 and 2.5 we were just doing the release of the pages
> > correctly in zap_page_range, by clearing the pte entry, then
> > invalidating the tlb and finally freeing the page, I can't see problems
> > in the normal do_munmap path unless free_pgtables triggers too.
> 
> Right, it's free_pgtables that matters, and we need to do the same
> "deferred free" (deferred until the TLB invalidate) as for the actual
> pages themselves. "pmd_quicklist" can act as such a deferral method.
> 
> In 2.5.x, I wanted to make the deferral explicit, which is why the 2.5.x
> approach re-did the thing to make the whole "TLB gather" cover the page
> table freeing too.
> 
> > So the fix is simply to
> > extend the tlb_gather_mm/tlb_finish_mmu/tlb_remove_page to the
> > free_pgtables path too (while dropping pte/pmd), so in turn to
> > clear_page_tables, even if only the "free_pgtables" caller really needs
> > it.
> 
> This is indeed exactly what 2.5.x does, but see above about it.
> 
> > I don't see why you changed the "fast mode" to 1 cpu (even without an
> > #ifdef SMP), if the mm_users is == 1 we are just guaranteed that no
> > parallel reading of the address space that we're working on can happen
> 
> Yes, but there is ANOTHER race, and this is actually the much more likely
> one, and the one that actually happens:
> 
> 	CPU1		CPU2
> 
> 	munmap
> 	.. speculation starts ..

the question is: can you explain how the speculative tlb fill can start?
see below.

> 	.. TLB looks up pgd entry ..
> 	clear pgd entry
> 	free pmd
> 
> 			alloc page - get old pmd
> 			scribble on page
> 
> 	.. TLB looks up pmd entry ..
> 	.. tlb fill ends ...
> 	invalidate_tlb
	^^^^^^^^^^^^^^

I assume the userspace access could be imagined right after the
invalidate_tlb in the above example, and that's the one supposed to
trigger the speculative tlb fill but how can it pass the invalidate_tlb?
see below.

> CPU2 can be doing something completely _unrelated_ and not have the same
> MM at all. The bug happens entirely within the TLB contents of CPU1,
> simply because the CPU1 speculation started a TLB fill, which looked up
> the PGD entry _before_ it was cleared, but because of a cache miss got
> delayed at the point where it was going to look up the PTE entry. In the
> meantime, CPU1 free'd the page, and another CPU scribbled stuff on it.
> 
> So we not have an invalid entry in the TLB on cpu1 - and while we will
> invalidate the TLB, if the entry had the global bit set that bad random
> entry would NOT get invalidated.
> 
> This, btw, is why in practice the thing only shows up on a P4. Only a P4
> has deep enough speculation queues that this bug actually happens. Intel
> apparently had this trace for 2000 (yes, two THOUSAND) cycles that showed
> this asynchronous TLB lookup.

In all cases either the 2.4 fix is wrong, or 2.5 is still overkill while
freeing the pages (not the pagetables), while freeing the pages the
fastmode can still be mm_users == 1 (there's no risk of caching a global
tlb entry with the pages, they're just data, not metadata, and the data
will be invalidated from the cpu during the tlb flush).

I also assume that an irq will force a restart of the TLB fill, if it
doesn't then the same race in freeing the pagetables can happen with
only one cpu too (again assuming invalidate_tlb isn't enough that I
don't think it's the case).

> 
> > About the patch floating around I also seen random changes in leave_mm
> > that I cannot explain (that's in 2.5 too, I think that part of 2.5
> > is superflous too infact)
> 
> Here the issue is:
> 
> 	CPU1			CPU2
> 
> 				Lazy TLB of same MM as on CPU1
> 	munmap()		.. start speculative TLB fetch ...
> 	.. free_pgtable
> 	.. invalidate   ->	crosscall tlb_IPI
> 				We're lazy, nothing to do
> 	free page
> 	alloc page
> 	scribble on it
> 				 .. speculative TLB lookup ends ..
> 				get a bogus TLB entry with G bit
> 
> 
> According to intel, the _only_ thing that serializes the TLB fills is to
		      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> do a TLB invalidate (either invlpg or mov->cr3). So not even the
  ^^^^^^^^^^^^^^^^^^^                   ^^^^^^^^

If that's true then the previous race (the number 2, where I wrote "see
below") cannot happen and we can return to do the fastmode mm_users == 1
check also for the pte/pmd freeing (not only for the page freeing). They
are confirming the TLB fill is serialized by the overwrite of mov->cr3
and the invalidate_tlb _before_ the cpu-local userspace access
underlined in the previous case2 will be a strong barrier for any tlb
fill, so the tlb fill cannot be speculated across it and we can fastmode
with mm_users == 1.

> cross-call itself necessarily does anything to the background TLB fetch.

If smp_num_cpus == 1 or #ifndef CONFIG_SMP can use the fastmode for bug
number 2, then it means the irq handler is a cpu-local strong barrier as
strong as the invalidate_tlb (otherwise in case 2 again the race could
trigger on an UP machine if the irq handler aloocates the page [skb or
whatever] and scribbles over it). OTOH as said case 2 cannot trigger
anyways even on SMP because there's the invalidate_tlb that forbids the
speculative tlb fill to pass, so if the irq is a barrier for the tlb
fill or not is not obvious from case2.

But regardless of case2, I think for UP single threaded transparency all
the IRQs should be strong barriers to any speculative activity, so I
think the IPI irq should as well be a strong barrier that forbids the
speculative TLB to pass. So I'm not convinced the above is necessary.

The only required thing for this last case3 is that the order is
pte_clear, invalidate_tlb and finally free_page and that's guaranteed by
the fastmode because mm_users > 1 (there's an active lazy mm of the same
mm in cpu2), and the invalidate_tlb will make sure any tlb fill is
restarted before the page can be freed and in turn before the pte can be
scribbled by cpu 1 (or any other cpu in the system). otherwise it means
the irq isn't a barrier for the speculative tlb fill as it should for
UP transparency of the speculative actions (all speculative actions
should become visible only with smp effects).

> 
> So even the lazy case needs to do that, at which point it is just as
> well
> to just move to another stabler page table (it's actually faster than
> doing the cr3<->cr3 dance).
> 
> NOTE! This was not seen in any traces, but Intel was worried.
> 
> > explanation of why the above is superflous: every time a task enters the
> > lazy state we bump the mm_users so the active_mm is pinned somehow and
> > nothing can throw away the kernel side of the pgd
> 
> The page tables are freed, the same race can occur.
> 
> > A change like this (not from 2.5) as well is obviously superflous:
> 
> That's the intel patch - they just prefer that order, but they admitted it
> doesn't matter.

ok.

> 
> > This below change as well is superflous after we backout the above
> > change to leave_mm.
> 
> Don't back it out.
> 
> > This actually gets more near to the real problem...
> >
> >  static inline void flush_tlb_pgtables(struct mm_struct *mm,
> >  				      unsigned long start, unsigned long end)
> >  {
> > -	/* i386 does not keep any page table caches in TLB */
> > +	flush_tlb_mm(mm);
> >  }
> 
> The above, _together_ with moving it to before the check_pgt_cache() (and
> removing some other TLB flushes that are now superfluous).
> 
> In short, the Intel patch is good.

thanks for the whole explanation, this just makes many things clear, the
approch in the patch floating around definitely can fix free_pgtables
(case1) [I'd say a bit by luck because the pte still are overwritten in
pte_free], and it incidentally fixes case2 as well (plus it is more
efficient than 2.4 by lefting the fastmode for pages mm_users == 1). But
I'm not really convinced that the tlb fill can pass the IPI irq in case
3 (so I'm not convinced leave_mm is needed), and I think the 2.4 patch
incidentally takes care of case 2 too, but again I don't see what's the
problem of case2 in doing the fastmode for pte too (not only for pages,
where for pages it is certainly safe, or better at worse we can read out
of the ram address spce, potentially allocating an alias cacheline on
the gart but that's ok as far as it's a read-only cacheline, and
speculative read activity shouldn't really allocate writeback buffered
cachelines that would cause lost coherency to two aliased phys addresses)

Comments?

Andrea
