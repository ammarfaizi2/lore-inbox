Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289386AbSAVVjT>; Tue, 22 Jan 2002 16:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289394AbSAVVjK>; Tue, 22 Jan 2002 16:39:10 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:25356 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S289386AbSAVVjD>; Tue, 22 Jan 2002 16:39:03 -0500
Date: Tue, 22 Jan 2002 21:41:16 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
In-Reply-To: <20020122201002.E1547@athlon.random>
Message-ID: <Pine.LNX.4.21.0201222045450.1352-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Andrea Arcangeli wrote:
> On Tue, Jan 22, 2002 at 06:01:43PM +0000, Hugh Dickins wrote:
> 
> > Actually, I'm coming to think that most of the pte_offset_atomic
> > calls should be replaced by a pte_offset_nowait: which gives the usual
> > pte_offset kmap if it can without blocking, or an atomic if not - your
> > pte_kunmap seems nicely designed for that very possibility.  Whether
> 
> Possible optimization. Before doing so we should really measure how the
> kmaps are faster compared to the kmap_atomic I believe. This could be a
> performance optimization. But it could also be that the kmap_atomic are
> faster and it doesn't worth to get into the kmap overhead when
> persistence is not necessary.

Optimization, yes, can just avoid deadlocks with atomics for now.
I don't expect the kmap_atomics to be slow, but it's a shame to have
to keep on using them in so many places where there's a likelihood
that the pagetable in question is already mapped, no chance of blocking.
Particularly with the pagetable cache: kmapped on exit, ready for reuse.

> pagetable2 is needed every single time you need to access two pagetables
> at the same time with a static kmap. Infact now that I notice it also
> mremap needs it. With mremap both the two kmaps could return
> entries in the PAGETABLE serie, no-way around it.

Yes, I was politely turning a blind eye to move_one_page for now.
It's not a high-priority, and I'm sure it's easily fixed one way or
another.  I hope we don't need PAGETABLE2 for it, I'd imagined one
pagetable kmapped from pool and the other nowaited (atomic if none
in pool).  Definitely needs care yes, but as in copy_page_range,
the situation here is well defined (cannot be in a page fault,
doesn't involve filesystem, task cannot have other kmaps pinned),
so no great problem.

> So to solve all this mess between mixture of PAGETABLE2 and PAGETABLE
> (and even with DEFAULT if /dev/kmem will ever mess with highmem), I will
> just drop the recursive behaviour of kmap. That is not needed for
> coherency, that was only a kind of performance optimization and to
> maintain a page->virtual, so I will just kill it and then we're done, no
> mixture mess any longer. I will left it only for the DEFAULT serie,
> because of the page->virtual, all other series will not care about
> page->virtual any longer, page->virtual was a bad idea since the first
> place, it would been better to keep the information on the current
> stack, like all the other series will do.

As ever you think too fast for me: I need to ponder more about it.
At the moment I feel you're now over-reacting, I'd prefer to keep
pagetable page->virtual if we can.

> > > Same is true between KM_SERIE_PAGETABLE and KM_SERIE_DEFAULT, the reason
> > > it is obviously correct here is because the mixture cannot happen since
> > > the first place, because pages will pass through the freelist before the
> > > two can be mixed, and so they will be kunmapped first.
> > 
> > I think you're mistaken there: passing through the
> > freelist doesn't affect a page's kmapping at all, does it?
> > We could make changes to do so, but that wouldn't be enough.
> 
> Doing:
> 
> 	page = alloc_page();
> 	kmap(page);
> 	__free_page(page)
> 
> is a bug (it will leak kmap entries eventually), this is what i meant
> with "passing through the freelist" as serializing point between
> PAGETABLE and DEFAULT series.

Oh sure, it's wrong to kmap then free like that.  What I meant is that
the pkmap_count is always kept one higher for persistence, so even when
you kunmap(page) before the __free_page(page) above, the page->virtual
mapping (appropriate to a particular serie) remains, and will be used
by the next user of the page (unless a flush_all_zero_pkmaps intervenes).

I'm a bit confused by your explanation here, unsure whether I'm just
retelling you what you already well know (but don't see how you could
have called passing through the freelist a serializing point between
PAGETABLE and DEFAULT if you do).

> > Well, I've had my say: I believe the SERIEs, as currently implemented,
> > give _an illusion of_ security from kmap deadlock.  But it feels like
> > I'm failing to dislodge you from your belief in them, and they're
> > not actively harmful, so I'll shut up - until provoked!
> 
> You shouldn't really giveup if you think it's not right yet! :) Also I
> now agree the ordering matters. So I'd define an ordering which is
> PAGETABLE2 first, PAGETABLE second, and DEFAULT third. This in
> combination of the changes I will make to the kmap (only DEFAULT kmap
> reentrant), should fix all the deadlocks, right? The ordering between
> DEFAULT and PAGETABLE should be always enforced, if we get a kmap on a
> page it will be after we touch its respective pagetable, right?

Again, I need to think more about this, feel you're rushing.

> I will try to get a new version out in the next few days. In short we
> found that current version can deadlock in mremap (double PAGETABLE kmap
> in a raw) or in fork (overlooked the spinlock), both deadlocks are not
> reproducible in real life for me in normal usage at least, next version
> should not deadlock there any longer.

Yes, neither of those potential deadlocks is high-priority to fix,
and there are plenty of others lurking in the ordering issue.

> BTW, did you checked my fix for the contiogous_pte in fixinit_range?

Yes, not keen on it!  You'll have my separate mail with patch by now.

> many thanks for the help,

Glad to, and glad we're now more or less "on the same page"!

Hugh

