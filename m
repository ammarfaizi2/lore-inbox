Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317057AbSEXA1t>; Thu, 23 May 2002 20:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317058AbSEXA1s>; Thu, 23 May 2002 20:27:48 -0400
Received: from [195.223.140.120] ([195.223.140.120]:14378 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317057AbSEXA1q>; Thu, 23 May 2002 20:27:46 -0400
Date: Fri, 24 May 2002 02:27:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: backport of the free_pgtables tlb fixes to 2.4
Message-ID: <20020524002707.GE21164@dualathlon.random>
In-Reply-To: <20020523232234.GC21164@dualathlon.random> <Pine.LNX.4.44.0205231636140.7747-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 04:51:17PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 24 May 2002, Andrea Arcangeli wrote:
> > On Thu, May 23, 2002 at 03:04:36PM -0700, Linus Torvalds wrote:
> > >
> > >
> > > On Thu, 23 May 2002, Andrea Arcangeli wrote:
> > > >
> > > > If the userspace tlb lookup is started during munmap the tlb can contain
> > > > garabge before invalidate_tlb.
> > >
> > > No.
> >
> > Above I just repeated what you said as confirmation of your:
> >
> > 	By the time the invalidate_tlb happens, the TLB fill has already
> > 	finished, and has already picked up garbage.
> >
> > Not sure why you say "no" about it.
> 
> With the intel patches for 2.4.x, or with the 2.5.x tree, the problem is
> fixed.
> 
> I don't see why you argue against the patches - they've been tested, and
> they clearly fix a kernel bug that I've explained, and that Intel itself
> even has posted explanations about.
> 
> > Agreed, doing the safe ordering always is clearly safe, just overkill
> > for example while freeing the pages (not the pagtables), infact the 2.4
> > patch floating around allows the fastmode with mm_users == 1 while
> > freeing the pages.
> 
> Yes, you can free the pages themselves if mm_users is 1 with the fastmode.
> That's one of the reasons I'm going to make the 2.5.x tree use the
> pmd_quicklist, so that the page table tree itself can more cleanly be
> handled differently than the pages.

agreed.

> 
> >			 Probably it's not a significant optimization, but
> > maybe mostly for documentation reasons we could resurrect the mm_users
> > == 1 fastmode while freeing pages (while freeing pagetables the fastmode
> > must go away completly anyways, that was the bug).
> 
> The other thing I was considering was to actually make fastmode go away,
> it doesn't really seem to buy anything. If anything it might be possible
> that the "slow" case is faster than the fast case for some loads, simply
> because it has nicer icache "batching" behaviour.

most probably worthwhile to drop it.

> 
> > > But yes, Intel tells me that the only thing that is guaranteed to
> > > serialize a TLB lookup is a TLB invalidate. NOTHING else.
> >
> > If the only thing that serialize the speculative tlb fill is the tlb
> > invalidate, then the irq won't serialize it.
> 
> Right.
> 
> HOWEVER, there's obviously another issue - the TLB lookup will complete at
> some point on its own, and the interrupt may well be slow enough that it
> effectively serializes the TLB lookup just by virtue of taking many
> cycles.
> 
> In fact I don't think Intel was ever able to reproduce the lazy-TLB
> problem, their engineers only speculated that in theory it could be an
> issue.
> 
> I personally think it's very unlikely that the "load_cr3()" makes any real
> difference, but we also have another issue: because we clear the
> "vm_cpu_bitmap" thing for that CPU, we'll only ever get _one_ cross-call
> for such a lazy TLB. It is quite possible to have one unmap() cause
> _multiple_ invalidates because it has a lot of page tables to go over, and
> so the second page table clearing might not trigger an interrupt at all.
> You also lose the TLB flushes for future unmaps in case the CPU stays in
> lazy-TLB mode.

ok, I see that now that I know about that the p4 fills random user tlb
during any kernel code completly unrelated to the virtual userspace
addresses that is resolving speculatively. The reason it just didn't
looked worthwhile to do that is that the cpu never knows if it will ever
access those user addresses again, the higher the context switch rate,
the lower the probability that any speculative tlb fill on user
addresses will pay off. Of course assuming they're x86 cpus without
ASN/tlb-tagging that isn't possible to implement in hardware without OS
cooperation.

With all other x86 cpus leave_mm is never been a problem, because a CPU
could never start filling an user tlb while it was in lazy mode. before
even trying to access userspace addresses the kernel is supposed to do a
tlb flush during switch_mm and so a tlb fill in userspace could never be
run before the next tlb flush.

> 
> So that's another reason for loading %cr3 with a "known good" page table
> value: because we inhibit future TLB flushes, we really should also make
> sure that we're not continuing to use this "known-unstable" page table
> tree.
> 
> > Probably due the lack of any course in out of order CPU design, I'm not
> > aware of any other cpu (not only x86) out there that exposes the
> > internal out of order speculative actions of the CPU,
> 
> I agree. I'm actually surprised myself at just how agressive the P4 is,
> but on the other hand I think it's very interesting behaviour.
> 
> > BTW, about the quicklist I think they were nicer to have than just the
> > per-cpu page allocator in front of the global page allocator (the
> > allocator affinity is at a lower layer, much easier to be polluted with
> > non-per-cpu stuff than the pte quicklists). So I'm not really against
> > resurrecting them, however I suggest to build pte chain always with a
> > list on the page struct and never overwriting the contents of the pte
> > like it happens in most current 2.4 quicklists (I partly fixed that in
> > pte-highmem).
> 
> I'd suggest (ab-)using something like page->mapping for the quicklist
> following. You can use the page itself (the pointer will always be even,
> so using the page will not re-trigger the bug on x86 because the "garbage"
> written to the page table never has the Present bit set), but it's nicer
> from a cache standpoint to use the "struct page" area.

Agreed. In 2.4 pte-highmem (where I don't want to kmap_atomic inside every
pte_free_fast but I want to just work with pages so I avoid kmapping
overhead) I simply used page->list, that's the most appropriate list
chain to use in a wrapper in front of __free_pages.

static inline void pte_free_fast(struct page * page)
{
	list_add(&page->list, &pte_quicklist);
	pgtable_cache_size++;
}

Andrea
