Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUCKNzc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUCKNzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:55:32 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:26886
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261263AbUCKNz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:55:27 -0500
Date: Thu, 11 Mar 2004 14:56:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
Message-ID: <20040311135608.GI30940@dualathlon.random>
References: <20040311065254.GT30940@dualathlon.random> <Pine.LNX.4.44.0403111248450.1402-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403111248450.1402-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Thu, Mar 11, 2004 at 01:23:24PM +0000, Hugh Dickins wrote:
> Hi Andrea,
> 
> On Thu, 11 Mar 2004, Andrea Arcangeli wrote:
> > 
> > this is the full current status of my anon_vma work. Now fork() and all
> > the other page_add/remove_rmap in memory.c plus the paging routines
> > seems fully covered and I'm now dealing with the  vma merging and the
> > anon_vma garbage collection (the latter is easy but I need to track all
> > the kmem_cache_free).
> 
> I'm still making my way through all the relevant mails, and not even
> glanced at your code yet: I hope later today.  But to judge by the
> length of your essay on vma merging, it strikes me that you've taken
> a wrong direction in switching from my anon mm to your anon vma.
> 
> Go by vmas and you have tiresome problems as they are split and merged,
> very commonly.  Plus you have the overhead of new data structure per vma.

it's more complicated because it's more finegrined and it can handle
mremap too. I mean, the additional cost of tracking the vmas payoffs
because then we've a tiny list of vma to search for every page,
otherwise with the mm-wide model we'd need to search all of the vmas in
a mm. This is quite important during swapping with tons of vmas. Note
that in my common case the page will point directly to the vma
(PageDirect(page) == 1), no find_vma or whatever needed in between.

the per-vma overhead is 12 bytes, 2 pointers for the list node and 1
pointer to the anon-vma. As said above it provides several advantages,
but you're certainly right the mm approch had no vma overhead.

I'm quite convinced the anon_vma is the optimal design, though it's not
running yet ;). However it's close to compile. the whole vma and page
layer is finished (including the vma merging). I'm now dealing with the
swapcache stuff and I'm doing it slightly differently from your
anobjrmap-2 patch (obviously I also reistantiate the PG_swapcache
bitflag but the fundamental difference is that I don't drop the
swapper_space):

static inline struct address_space * page_mapping(struct page * page)
{
	extern struct address_space swapper_space;
	struct address_space * mapping = NULL;

	if (PageSwapCache(page))
		mapping = &swapper_space;
	else if (!PageAnon(page))
		mapping = page->as.mapping;
	return mapping;
}

I want the same pagecache/swapcache code to work transparently, but I
free up the page->index and the page->mapping for the swapcache, so that
I can reuse it to track the anon_vma. I think the above is simpler than
killing the swapper_space completely as you did. My solution avoids  me
hacks like this:

 	if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
 		return mapping->a_ops->sync_page(page);
+	if (PageSwapCache(page))
+		blk_run_queues();
 	return 0;
 }

it also avoids me rework set_page_dirty to call __set_page_dirty_buffers
by hand too. I mean, it's less intrusive.

the cpu cost it's similar, since I pay for an additional compare in
page_mapping though, but the code looks cleaner. Could be my opinion
only though ;).

> If your design magicked those problems away somehow, okay, but it seems
> you're finding issues with it: I think you should go back to anon mms.

the only issue I found so far, is that to track the stuff in a
fine-granular way I have to forbid merging sometime. note that
forbidding merging is a feature too, if I would go down with a pagetable
scan on the vma to fixup all page->as.vma/anon_vma and page->index I
would then lose some historic information on the origin of certain vmas,
and I would eventually fallback to the mm-wide information if I would do
total merging.

I think the probability of forbidden merging is low enough that it
doesn't matter. Also it doesn't impact in any way the file merging.
It basically merges as well as the file merging. Right now I'm also not
overriding the intitial vm_pgoff given to brand new anonymous vmas, but
I could, to boost the merging with mremapped segments. Though I don't
think it's necessary.

Overall the main reason for forbidding keeping track of vmas and not of
mm, is to be able to handle mremap as efficiently as with 2.4, I mean
your anobjrmap-5 simply reistantiate the pte_chains, so the vm then has
to deal with both pte_chains and anonmm too.

> Go by mms, and there's only the exceedingly rare (does it ever occur
> outside our testing?) awkward case of tracking pages in a private anon
> vma inherited from parent, when parent or child mremaps it with MAYMOVE.
> 
> Which I reused the pte_chain code for, but it's probably better done
> by conjuring up an imaginary tmpfs object as backing at that point
> (that has its own little cost, since the object lives on at full size
> until all its mappers unmap it, however small the portion they have
> mapped).  And the overhead of the new data structre is per mm only.
> 
> I'll get back to reading through the mails now: sorry if I'm about to
> find the arguments against anonmm in my reading.  (By the way, several
> times you mention the size of a 2.6 struct page as larger than a 2.4
> struct page: no, thanks to wli and others it's the 2.6 that's smaller.)

really? mainline 2.6 has the same size of mainline 2.4 (48 bytes), or
I'm counting wrong? (at least my 2.4-aa tree is 48 bytes too, but I
think 2.4 mainline too) objrmap adds 4 bytes (goes to 52bytes), my patch
removes 8 bytes (i.e.  the pte_chain) and the result of my patch is 4
bytes less than 2.4 and 2.6 (44 bytes instead of 48 bytes). I wanted to
nuke the mapcount too but that destroy the nr_mapped info, and that
spreads all over so for now I keep the page->mapcount ;)
