Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262955AbTCWIB0>; Sun, 23 Mar 2003 03:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262956AbTCWIB0>; Sun, 23 Mar 2003 03:01:26 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:41147 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S262955AbTCWIBV>; Sun, 23 Mar 2003 03:01:21 -0500
Date: Sun, 23 Mar 2003 08:14:12 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@digeo.com>, <dmccr@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: 2.5.65-mm2 vs 2.5.65-mm3 (full objrmap)
In-Reply-To: <370130000.1048381666@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0303230723210.1595-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Mar 2003, Martin J. Bligh wrote:
> >> Did you keep the pte_direct
> >> optimisation? That seems worth keeping, with partial objrmap as well
> >> (I think that was removed in Dave's patch, but would presumably be easy
> >> to put back).
> > 
> > Dave didn't remove it at all, just went another way so that it became
> > irrelevant to obj rmaps (or you could say, every obj rmap direct,
> > apart from the sys_remap_file pages).  I did the same with anonymous,
> > they're almost all direct (since a given anon page is almost always
> > mapped at the same user virtual address in whatever mms it appears),
> > the exception needing chains coming from a perverse use of mremap.
> 
> OK, so you're saying we can still use the direct map for singletons
> that are filebacked? I thought that dissappeared for some reason ...
> don't recall what. I just thought it'd save some time on the lookup
> side of the equation .. but I'm not sure our testing is doing any
> lookup ;-)

Sorry, no, that's not what I meant.  I was looking at it from the
perspective that with objrmap the file page has no pte_chains at all
(except in the sys_remap_file_pages case), and with anobjrmap the
anon page also has no chains at all (except in odd mremap case).
Thinking of the chain as the thing you waste time on adding a page
to and removing a page from (more the latter).

But when it comes to lookup (page_referenced or try_to_unmap), yes,
with objrmap all file pages are chained (via page->mapping->i_mmap
and page->mapping->i_mmap_shared lists of vmas); and with anobjrmap
all anon pages are chained (via page->anonmm->mm).  So you could
say they've abandoned the page direct map (but I think it came in
as a space saving, to prevent every single mapped page from needing
a struct pte_chain attached, not as a lookup optimization).

There's no doubt (except insofar as actual measurement can spring
surprises!) that the pte_chain-based rmap is much more efficient at
locating ptes referencing a page, than objrmap or objrmap+anobjrmap.
The problem with pte_chain-based rmap is that it's faster at the
operations we expect to be slow, and slower at the common operations
we need to be fast (adding and removing a page).

To make up your mind whether we've preserved or abandoned the
page direct optimization, I think you'd better look at the code:
it's just different.

> > The clearest advantage of anobjrmap so far is for your HIGHMEM64G
> > HIGHPTE configurations: which had a 64-bit direct pte_addr_t in
> > struct page, now just a 32-bit count like in the non-PAE configs.
> > (Though that saving could have been achieved in other ways.)
> 
> Ah, I don't run highpte, too much performance impact from kmap, even
> once they were made atomic instead of persistant. Were you using highpte 
> in your tests? shpte seems to work much better in terms of performance,
> and control the high-use cases for ptes ... I think the UKVA based
> version with each process permanently mapping its own pagetables will
> perform much better.

I build with highpte on one machine for testing purposes, I don't have
enough memory for it actually to be important.  I'm almost always
working with Andrew's trees, so was using shpte when it was in, but
not since.  I like the idea of shpte (and the UKVA idea), I couldn't
see its constituency - the small processes immediately needed to cow
all their page tables, and the large ones should have been using
huge pages instead (or such was my misperception).

> >> Or maybe we just need some more tuning ;-)
> > 
> > Be nice if a magic wand would make it go faster, but it seems too
> > simple for tuning.  A lot of effort went into speeding up pte_chains,
> > looks like the effort paid off. 
> 
> Well, I think the real key is that we're hardly using pte_chains any
> more with the partial objrmap code ... they're mostly direct mapped
> singletons anyway, so you're not saving much. I had a crude /proc 
> thingy to draw histograms of chain length somewhere that I did my 
> initial analysis on, I'll try to dig it out.
> 
> Did you measure either partial objrmap or anon-objrmap under memory
> pressure? 

No.  I'd expect, and be content with, some slowdown there:
if it's not obvious then it does not matter.

> > (It's particularly helpful that the
> > chains got collapsed back to direct lazily, by page_referenced, not
> > by page_remove_rmap - that means a repetitively forking process
> > was not perpetually convulsed in allocating and freeing chains).
> 
> mmm ... can you explain that one a bit more? I think I missed that
> bit, and maybe it explains why we don't see too much impact from
> the fork/exec stuff for anon pages.

When a process forks, each page it had mapped gains one more reference.
With pte_chain-based rmap that means one more pte pointer has to be
added to the page: so if it was PageDirect before, now a struct
pte_chain has to be allocated and the now two pointers put there.
If the forked child immediately execs, its copy of the mm is
immediately torn down and the page references return to what they
were before.  Naively I'd expect page_remove_rmap to be tidy and
collapse pte_chain back to PageDirect and free the struct, but in
fact it doesn't bother, leaving that collapse for the next
page_referenced check.  And that's a good strategy for processes
which do a lot of forking+execing, they won't be forever switching
between direct and chained.

Hugh

