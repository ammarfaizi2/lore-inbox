Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbUCKVyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 16:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUCKVyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 16:54:16 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:54755 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261750AbUCKVyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 16:54:09 -0500
Date: Thu, 11 Mar 2004 21:54:01 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040311135608.GI30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403112043420.2120-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004, Andrea Arcangeli wrote:
> On Thu, Mar 11, 2004 at 01:23:24PM +0000, Hugh Dickins wrote:
> > 
> > Go by vmas and you have tiresome problems as they are split and merged,
> > very commonly.  Plus you have the overhead of new data structure per vma.
> 
> it's more complicated because it's more finegrined and it can handle
> mremap too. I mean, the additional cost of tracking the vmas payoffs
> because then we've a tiny list of vma to search for every page,
> otherwise with the mm-wide model we'd need to search all of the vmas in
> a mm. This is quite important during swapping with tons of vmas. Note
> that in my common case the page will point directly to the vma
> (PageDirect(page) == 1), no find_vma or whatever needed in between.

Nice if you can avoid the find_vma, but it is (or was) used in the
objrmap case, so I was happy to have it in the anobj case also.

Could you post a patch against 2.6.3 or 2.6.4?  Your objrmap patch
applies with offsets, no problem, but your anobjrmap patch doesn't
apply cleanly on top of that, partly because you've renamed files
in between (revert that?), but there seem to be other untracked
changes too.  I may not be seeing the whole story right.

Great to see the pte_chains gone, but I find what you have for anon
vmas strangely complicated: the continued existence of PageDirect etc.
I guess, having elected to go by vmas, you're trying to avoid some of
the overhead until fork.  But that does make it messy to my eyes,
the anonmm way much cleaner and simpler in that regard.

> I want the same pagecache/swapcache code to work transparently, but I
> free up the page->index and the page->mapping for the swapcache, so that
> I can reuse it to track the anon_vma. I think the above is simpler than
> killing the swapper_space completely as you did. My solution avoids  me
> hacks like this:
> 
>  	if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
>  		return mapping->a_ops->sync_page(page);
> +	if (PageSwapCache(page))
> +		blk_run_queues();
>  	return 0;
>  }
> 
> it also avoids me rework set_page_dirty to call __set_page_dirty_buffers
> by hand too. I mean, it's less intrusive.

There may well be better ways of reassigning the page struct fields
than I had, making for less extensive changes, yes.  Best to go with the
least intrusive for now (so long as not too ugly) and reappraise later.

> Overall the main reason for forbidding keeping track of vmas and not of
> mm, is to be able to handle mremap as efficiently as with 2.4, I mean
> your anobjrmap-5 simply reistantiate the pte_chains, so the vm then has
> to deal with both pte_chains and anonmm too.

Yes, I used pte_chains for that because we hadn't worked out how to
do remap_file_pages without them (I've not yet looked into how you're
handling those), so might as well put them to use here too.  But if
nonlinear is now relieved of pte_chains, great, and as I said below,
the anonmm mremap case should be able to conjure a tmpfs backing object
- which probably amounts to your anon_vma, but only needed in that one
odd case, anon mm sufficient for all the rest, less overhead all round.

> > Go by mms, and there's only the exceedingly rare (does it ever occur
> > outside our testing?) awkward case of tracking pages in a private anon
> > vma inherited from parent, when parent or child mremaps it with MAYMOVE.
> > 
> > Which I reused the pte_chain code for, but it's probably better done
> > by conjuring up an imaginary tmpfs object as backing at that point
> > (that has its own little cost, since the object lives on at full size
> > until all its mappers unmap it, however small the portion they have
> > mapped).  And the overhead of the new data structre is per mm only.
> > 
> > I'll get back to reading through the mails now: sorry if I'm about to
> > find the arguments against anonmm in my reading.  (By the way, several
> > times you mention the size of a 2.6 struct page as larger than a 2.4
> > struct page: no, thanks to wli and others it's the 2.6 that's smaller.)
> 
> really? mainline 2.6 has the same size of mainline 2.4 (48 bytes), or
> I'm counting wrong? (at least my 2.4-aa tree is 48 bytes too, but I
> think 2.4 mainline too) objrmap adds 4 bytes (goes to 52bytes), my patch
> removes 8 bytes (i.e.  the pte_chain) and the result of my patch is 4
> bytes less than 2.4 and 2.6 (44 bytes instead of 48 bytes). I wanted to
> nuke the mapcount too but that destroy the nr_mapped info, and that
> spreads all over so for now I keep the page->mapcount ;)

I think you were counting wrong.  Mainline 2.4 i386 48 bytes, agreed.
Mainline 2.6 i386 40 bytes, or 44 bytes if PAE & HIGHPTE.  And today,
2.6.4-mm1 i386 32 bytes, or 36 bytes if PAE & HIGHPTE.  Though of course
the vanished fields will often be countered by memory usage elsewhere.

Yes, keep mapcount for now: I went around that same loop, it
surely has the feel of something that can be disposed of in the end,
but there's no need to attempt that while doing this objrmap job,
it's better done after since it needs a different kind of care.

(Be aware that shmem_writepage will do the wrong thing, COWing what
should be a shared page, if it is ever given a still-mapped page:
but no need to worry about that now, and it may be easy to work it
differently once the rmap changes settle down.  As to shmem_writepage
going directly to swap, by the way: I'm perfectly happy for you to
make that change, but I don't believe the old way was mistaken - it
intentionally gave tmpfs pages which should remain in memory another
go around.  I was never convinced one way or the other: but the current
code works very badly for some loads, as you found, I doubt there are
any that will suffer so greatly from the change, so go ahead.)

Hugh

