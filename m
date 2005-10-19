Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVJSPXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVJSPXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVJSPXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:23:53 -0400
Received: from gold.veritas.com ([143.127.12.110]:15239 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751092AbVJSPXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:23:53 -0400
Date: Wed, 19 Oct 2005 16:23:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Rohit Seth <rohit.seth@intel.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
 2.6.14-rc4-git5
In-Reply-To: <1129692330.24309.44.camel@akash.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0510191551180.7586@goblin.wat.veritas.com>
References: <20051018141512.A26194@unix-os.sc.intel.com> 
 <20051018143438.66d360c4.akpm@osdl.org>  <1129673824.19875.36.camel@akash.sc.intel.com>
  <20051018172549.7f9f31da.akpm@osdl.org> <1129692330.24309.44.camel@akash.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Oct 2005 15:23:52.0469 (UTC) FILETIME=[1CAB4450:01C5D4C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2005, Rohit Seth wrote:
> On Tue, 2005-10-18 at 17:25 -0700, Andrew Morton wrote: 
> > Rohit Seth <rohit.seth@intel.com> wrote:
> > >
> > > 
> > > Unsused pte is where *pte == 0.  Basically entries in leaf page table
> > > that does not map anything.
> > 
> > Oh.  Then I'm still not understanding.

I've had great trouble understanding it too.
This mail was the most helpful, thanks.

> Following is the scenario:
> 
> Kernel is going to prefault the huge page for user virtual address V.  
> 
> Let us say the pointer pte points to the page table entry (for x86 it is
> PDE/PMD) which maps the hugepage.  
> 
> At this point *pte == 0.  CPU also has this entry cached in its TLB.

I thought that the CPU never caches !present entries in the TLB?
Or is that true of i386 (and x86_64), but untrue of ia64?
Or do you have some new model or errata on some CPU where it's true?
Or, final ghastly possibility ;), am I simply altogether wrong?

> Meaning, unless this entry is purged or displaced, for virtual address V

When you say "purged", is that what we elsewhere call "flushed"
in relation to the TLB, or something else?

> CPU will generate the page fault (as the P bit is not set and assuming
> this fault has the highest precedence).
> 
> Kernel updates the *pte so that it now maps the hugepage at virtual
> address V to physical address P.  
> 
> Later when the user process make a reference to V, because of stale TLB
> entry, the processor gets PAGE_FAULT.

You seem to be saying that strictly, we ought to flush TLB even when we
make a page present where none was before, but that the likelihood of it
being needed is so low, and the overhead of TLB flush so high, and the
existing code almost everywhere recovering safely from this condition,
that the most effective thing to do is just fix up the hugetlb case.
Is that correct?

> > Has this problem been observed in testing?
> 
> Yes. On IA-64.

But not on i386 or x86_64.

> > I still don't understand what's different about hugepages here.  If the
> > prefetching problem also occurs on regular pages and is handled OK for
> > regular pages, why do hugepages need special treatment?

Okay, I get that part of the puzzle.

> The prefetching problem is handled OK for regular pages because we can

But here you mention prefetching, and I think in another of these
explanations you mention that this only happens via speculative prefetch.

I thought prefetch was designed to have no such visible effects?
Same series of doubts as with !present entries in the TLB; but after
looking at the ia64 fault handler, that does seem to have stuff about
speculative loads, so I'm guessing i386 and x86_64 prefetch does not
cause faults (modulo errata), but ia64 does.

> handle page faults corresponding to those pages.  That is currently not
> true for hugepages.  Currently the kernel assumes that PAGE_FAULT
> happening against a hugetlb page is caused by truncate and returns
> SIGBUS.

Testing against i_size is not good enough, but I'll explain that
in other mail against Andrew's latest version of the patch.

Once I started to understand this thread, I thought you were quite
wrong to be changing hugetlb fault handling, thought I'd find several
other places which would need fixing too e.g. kmap_atomic, remap_pfn_range.

But no, I've found no others.  Either miraculously, or by good design,
all the kernel misfaults should be seamlessly handled by the lazy vmalloc
path (on i386 anyway: I don't know what happens for ia64 there), and the
userspace misfaults by handle_pte_fault's pte_present check.  I think.

Even with Nick's PageReserved changes in -mm, where he might have chosen
to put a warning on VM_RESERVED higher in the fault path, it looks like
it needs no change for this issue.

Hugh
