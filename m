Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317046AbSEWXXS>; Thu, 23 May 2002 19:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317048AbSEWXXR>; Thu, 23 May 2002 19:23:17 -0400
Received: from [195.223.140.120] ([195.223.140.120]:36130 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317046AbSEWXXN>; Thu, 23 May 2002 19:23:13 -0400
Date: Fri, 24 May 2002 01:22:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: backport of the free_pgtables tlb fixes to 2.4
Message-ID: <20020523232234.GC21164@dualathlon.random>
In-Reply-To: <20020523204101.GY21164@dualathlon.random> <Pine.LNX.4.44.0205231459230.29160-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 03:04:36PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 23 May 2002, Andrea Arcangeli wrote:
> >
> > If the userspace tlb lookup is started during munmap the tlb can contain
> > garabge before invalidate_tlb.
> 
> No.

Above I just repeated what you said as confirmation of your:

	By the time the invalidate_tlb happens, the TLB fill has already
	finished, and has already picked up garbage.

Not sure why you say "no" about it.

> If we wait until after the TLB fill to actually free the page tables
> pages, there is _no_ way the TLB can contain garbage, because the page
> directories will never have had garbage in it while any TLB lookup could
> be active.

Agreed, doing the safe ordering always is clearly safe, just overkill
for example while freeing the pages (not the pagtables), infact the 2.4
patch floating around allows the fastmode with mm_users == 1 while
freeing the pages. Probably it's not a significant optimization, but
maybe mostly for documentation reasons we could resurrect the mm_users
== 1 fastmode while freeing pages (while freeing pagetables the fastmode
must go away completly anyways, that was the bug).

> > What I don't understand is how the BTB can invoke random userspace tlb
> > fills when we are running do_munmap, there's no point at all in doing
> > that. If the cpu see a read of an user address after invalidate_tlb,
> > the tlb must not be started because it's before an invalidate_tlb.
> 
> Take a course in CPU design if you want to understand why a CPU front-end
> might speculatively start accessing something before the back-end has
> actually told it what the "something" actually is.
> 
> But don't argue with the patch.

If I'm arguing is just because until now there was a lack of coherency
in the explanations and in the code, so I was simply stuck and I
couldn't extract something that made complete sense to me, there was
still some contraddiciton. Now that you admitted 2.5 is buggy in one
place I can finally drop a collision and things make complete sense
again. Without your help I could never understand the changes (like
leave_mm) that were going on in 2.5 and its 2.4 equivalent, thanks.
 
> > And if it's true not even irq are barriers for the tlb fills invoked by
> > this p4-BTB thing
> 
> It has nothing to do with the BTB - the BTB is just a source of
> speculative addresses to start looking at.
> 
> But yes, Intel tells me that the only thing that is guaranteed to
> serialize a TLB lookup is a TLB invalidate. NOTHING else.

If the only thing that serialize the speculative tlb fill is the tlb
invalidate, then the irq won't serialize it.

Probably due the lack of any course in out of order CPU design, I'm not
aware of any other cpu (not only x86) out there that exposes the
internal out of order speculative actions of the CPU, to the local CPU
strem. I recall you even said once that out of order cpus are hard to
make exactly because it's hard to take care of the serialization across
irq to make all out of order actions transparent for the local cpu
stream.  I'd be curious to know how many other cpus have this new
"feature".

BTW, about the quicklist I think they were nicer to have than just the
per-cpu page allocator in front of the global page allocator (the
allocator affinity is at a lower layer, much easier to be polluted with
non-per-cpu stuff than the pte quicklists). So I'm not really against
resurrecting them, however I suggest to build pte chain always with a
list on the page struct and never overwriting the contents of the pte
like it happens in most current 2.4 quicklists (I partly fixed that in
pte-highmem). This way it is more general. then once it's documented the
shrinkage of the quicklist must be done after the tlb flush we're fine,
like in 2.4 as you said. Last but not the least, also the tlb shootdown
for the page freeing in zap_page_range currently is very inefficient and
it should be rewritten not to use such tiny and inefficient array with a
few hundred pte pointers, but to just queue all the pages pending to be
freed in a list_head allocated in the tlb_gather_t structure (so such
per-cpu structure will also shrink a lot), so we don't need to trigger
suprious tlb flushes every time such tiny array overflows (basically it
will work like the pte_quicklist, but it will be shrunk completly after
the tlb flush, it's not a cache, it will be simply a dispose_list and it
should make the tlb shootdown code more readable too).

Andrea
