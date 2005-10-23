Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbVJWJDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbVJWJDw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 05:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbVJWJDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 05:03:52 -0400
Received: from silver.veritas.com ([143.127.12.111]:35608 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751440AbVJWJDw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 05:03:52 -0400
Date: Sun, 23 Oct 2005 10:02:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: [PATCH 3/9] mm: parisc pte atomicity
In-Reply-To: <1130000925.6461.15.camel@mulgrave>
Message-ID: <Pine.LNX.4.61.0510230930470.19527@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com> 
 <Pine.LNX.4.61.0510221722260.18047@goblin.wat.veritas.com> 
 <20051022163330.GD3364@parisc-linux.org> <1130000925.6461.15.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Oct 2005 09:03:51.0524 (UTC) FILETIME=[AFE62A40:01C5D7B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2005, James Bottomley wrote:
> On Sat, 2005-10-22 at 10:33 -0600, Matthew Wilcox wrote:
> > On Sat, Oct 22, 2005 at 05:23:27PM +0100, Hugh Dickins wrote:
> > > There's a worrying function translation_exists in parisc cacheflush.h,
> > > unaffected by split ptlock since flush_dcache_page is using it on some
> > > other mm, without any relevant lock.  Oh well, make it a slightly more
> > > robust by factoring the pfn check within it.  And it looked liable to
> > > confuse a camouflaged swap or file entry with a good pte: fix that too.
> > 
> > I have to say I really don't understand VM at all.  cc'ing the
> > parisc-linux list in case anyone there has a better understanding than I
> > do.
> 
> Well, I wrote the code for translation_exists() so I suppose that's
> me...
> 
> Do you have a reference to the thread that triggered this?  I need more
> context to decide what the actual problem is.

No thread, and I don't know of any problem reported.  It's just that
in connection with my page fault scalability patches, splitting up the
page_table_lock, I've had to search through architectures for pte code
which may need changing.

Since translation_exists is doing no locking at present, it doesn't need
any change to match my ptlock changes.  But it's a little worrying that
it has no locking.  When called from flush_cache_page that's almost
always right, and locking would just deadlock on locks already taken
(I think core dumping uses flush_cache_page outside of locks, not a big
deal).  But when called from flush_dcache_page, it's dealing with some
other mm entirely: anything could happen at any moment.

We're actually better off with my changes here than before.  Since you're
coming from the vma_prio_tree, with the necessary locking on that, you
can now be sure that the page tables won't get pulled out from under you
(whereas before there was an unlikely window in which they might be).

> Let me explain what translation_exists() is though for the benefit of
> the mm people.

Thanks for taking the trouble, James (more than I needed to know!
but I'm reassured by what you say of the TLB miss handlers, I was
worried about how serious the consequence of doing it on an invalid
entry, feared kernel panic or something).
 
> Parisc is a VIPT architecture, so that would ordinarily entail a lot of
> cache flushing through process spaces for shared pages.  However, we use
> an optimisation of making all user space shared pages congruent, so
> flushing a single one makes the cache coherent for all the others (this
> is also a cache usage optimisation).
> 
> So, what our flush_dcache_page() does is it selects the first user page
> it comes across to flush knowing that flushing this is sufficient to
> flush all the others.
> 
> Unfortunately, there's a catch: the page we're flushing must have been
> mapped into the user process (not guaranteed even if the area is in the
> vma list) otherwise the flush has no effect (a VIPT cache flush must
> know the translation of the page it's flushing), so we have to check the
> validity of the translation before doing the flush.
> 
> On parisc, if we try to flush a page without a translation, it's picked
> up by our software tlb miss handlers, which actually nullify the
> instruction (but since we have to flush a page as a set of non
> interlocking cache line flushes [about 128 of them per page with a cache
> width of 32]) and the tlb handler is invoked for every flush instruction
> (because the translation continues not to exist) it makes that flush
> operation extremely slow. (128 interruptions of the execution stream per
> flush)
> 
> So, the uses of translation_exists() are threefold
> 
> 1) Make sure we execute flush_dcache_page() correctly (rather than
> executing a flush that has no effect)
> 2) optimise single page flushing: don't excite the tlb miss handlers if
> there's no translation
> 3) optimise pte lookup (that's why translation_exists returns the pte
> pointer); since we already have to walk the page tables to answer the
> question, the return value may as well be the pte entry or NULL rather
> than true or false.

Regarding 3, I changed it to boolean because the only use made of the pte
pointer was to check pfn: which check I folded inside translation_exists,
so the pte it's checking for pfn cannot have changed since it was checked
for being present (repeated dereferences of pte pointer without locking
make me nervous, and I changed some code in other architectures for that).

I'm right, aren't I? that the previous pte_none test was actually letting
through swap entries and pte_file entries which might look as if they had
the right pfn, just by coincidence of their offsets?  So flush_dcache_page
would stop, thinking it had done a good flush, when actually it hadn't.

But races remain: the pte good at the moment translation_exists checks it,
may have been taken out by kswapd a moment later (flush_dcache_mmap_lock
only secures the vma_prio_tree structure, not ptes within the vmas);
or it may have been COWed in the interval; or zapped from the mm.

Can you get a success code out of __flush_cache_page?  Or perhaps you
should run translation_exists a second time after the  __flush_cache_page,
to check nothing changed (the pte pointer would then be helpful, to save
descending a second time)?  Or perhaps it all works out, that any such
change which might occur, itself does the __flush_cache_page you need?

Hugh
