Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289563AbSAVXeO>; Tue, 22 Jan 2002 18:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289568AbSAVXd6>; Tue, 22 Jan 2002 18:33:58 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19248 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289563AbSAVXdp>; Tue, 22 Jan 2002 18:33:45 -0500
Date: Wed, 23 Jan 2002 00:34:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
Message-ID: <20020123003449.F1547@athlon.random>
In-Reply-To: <20020122201002.E1547@athlon.random> <Pine.LNX.4.21.0201222045450.1352-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0201222045450.1352-100000@localhost.localdomain>; from hugh@veritas.com on Tue, Jan 22, 2002 at 09:41:16PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 09:41:16PM +0000, Hugh Dickins wrote:
> On Tue, 22 Jan 2002, Andrea Arcangeli wrote:
> > On Tue, Jan 22, 2002 at 06:01:43PM +0000, Hugh Dickins wrote:
> > 
> > > Actually, I'm coming to think that most of the pte_offset_atomic
> > > calls should be replaced by a pte_offset_nowait: which gives the usual
> > > pte_offset kmap if it can without blocking, or an atomic if not - your
> > > pte_kunmap seems nicely designed for that very possibility.  Whether
> > 
> > Possible optimization. Before doing so we should really measure how the
> > kmaps are faster compared to the kmap_atomic I believe. This could be a
> > performance optimization. But it could also be that the kmap_atomic are
> > faster and it doesn't worth to get into the kmap overhead when
> > persistence is not necessary.
> 
> Optimization, yes, can just avoid deadlocks with atomics for now.

Let's speak about this later. We should ring a bell as soon as we know
what's really faster (invlpg at every kmap or global tlb flush once
every 1024 kmaps?).

> Yes, I was politely turning a blind eye to move_one_page for now.
> It's not a high-priority, and I'm sure it's easily fixed one way or
> another.  I hope we don't need PAGETABLE2 for it, I'd imagined one
> pagetable kmapped from pool and the other nowaited (atomic if none
> in pool).  Definitely needs care yes, but as in copy_page_range,
> the situation here is well defined (cannot be in a page fault,
> doesn't involve filesystem, task cannot have other kmaps pinned),
> so no great problem.

It could be solved also without the PAGETABLE2 by reworking some code
yes, but still the problem remains between PAGETABLE and DEFAULT.

> 
> > So to solve all this mess between mixture of PAGETABLE2 and PAGETABLE
> > (and even with DEFAULT if /dev/kmem will ever mess with highmem), I will
> > just drop the recursive behaviour of kmap. That is not needed for
> > coherency, that was only a kind of performance optimization and to
> > maintain a page->virtual, so I will just kill it and then we're done, no
> > mixture mess any longer. I will left it only for the DEFAULT serie,
> > because of the page->virtual, all other series will not care about
> > page->virtual any longer, page->virtual was a bad idea since the first
> > place, it would been better to keep the information on the current
> > stack, like all the other series will do.
> 
> As ever you think too fast for me: I need to ponder more about it.
> At the moment I feel you're now over-reacting, I'd prefer to keep
> pagetable page->virtual if we can.

page->virtual will remain for all the DEFAULT serie, to avoid breaking
the regular kmap pagecache users. But to keep a page->virtual for each
serie we'd need a page->virtual[KM_NR_SERIES] array, which is very
costly in terms of ram, so I prefer to manage the virtual address on the
stack, just like we always have to do with the atomic kmaps. Recursion
on the same page->virtual (at the second simultaneous kmap on the same
page) will be allowed only for the default series, all other series will
allocate a new kmap entry even if the page is just mapped in another
entry in the same serie.  With pagetable mappings we never use
page->address, think that the pte_kunmap is the same regardless of the
kind of kmap happened (atomic or not), we never make use of page_address
on the pagetables. So it's going to work very easily and we'll save
some tons of static ram.

> > > > Same is true between KM_SERIE_PAGETABLE and KM_SERIE_DEFAULT, the reason
> > > > it is obviously correct here is because the mixture cannot happen since
> > > > the first place, because pages will pass through the freelist before the
> > > > two can be mixed, and so they will be kunmapped first.
> > > 
> > > I think you're mistaken there: passing through the
> > > freelist doesn't affect a page's kmapping at all, does it?
> > > We could make changes to do so, but that wouldn't be enough.
> > 
> > Doing:
> > 
> > 	page = alloc_page();
> > 	kmap(page);
> > 	__free_page(page)
> > 
> > is a bug (it will leak kmap entries eventually), this is what i meant
> > with "passing through the freelist" as serializing point between
> > PAGETABLE and DEFAULT series.
> 
> Oh sure, it's wrong to kmap then free like that.  What I meant is that
> the pkmap_count is always kept one higher for persistence, so even when
> you kunmap(page) before the __free_page(page) above, the page->virtual
> mapping (appropriate to a particular serie) remains, and will be used
> by the next user of the page (unless a flush_all_zero_pkmaps intervenes).

correct. I'm convinced the mixture problem invalidates completly the
deadlock avoidance using the series, so the only way to fix the
deadlocks is to avoid the mixture between the series.

> 
> I'm a bit confused by your explanation here, unsure whether I'm just
> retelling you what you already well know (but don't see how you could
> have called passing through the freelist a serializing point between
> PAGETABLE and DEFAULT if you do).
> 
> > > Well, I've had my say: I believe the SERIEs, as currently implemented,
> > > give _an illusion of_ security from kmap deadlock.  But it feels like
> > > I'm failing to dislodge you from your belief in them, and they're
> > > not actively harmful, so I'll shut up - until provoked!
> > 
> > You shouldn't really giveup if you think it's not right yet! :) Also I
> > now agree the ordering matters. So I'd define an ordering which is
> > PAGETABLE2 first, PAGETABLE second, and DEFAULT third. This in
> > combination of the changes I will make to the kmap (only DEFAULT kmap
> > reentrant), should fix all the deadlocks, right? The ordering between
> > DEFAULT and PAGETABLE should be always enforced, if we get a kmap on a
> > page it will be after we touch its respective pagetable, right?
> 
> Again, I need to think more about this, feel you're rushing.

Well, if you see any problem let me know.

> > I will try to get a new version out in the next few days. In short we
> > found that current version can deadlock in mremap (double PAGETABLE kmap
> > in a raw) or in fork (overlooked the spinlock), both deadlocks are not
> > reproducible in real life for me in normal usage at least, next version
> > should not deadlock there any longer.
> 
> Yes, neither of those potential deadlocks is high-priority to fix,
> and there are plenty of others lurking in the ordering issue.

The ordering thing is really simple I think. There are very few places
where we kmap and kmap_pagetable at the same time. And I don't see how
can could ever kmap before kmap_pagetable. so that part looks fine to
me. The other ordering constraint between kmap_pagetable2 and
kmap_pagetable is under our full control and it will have to check it in
only two places: mremap and fork, so the ordering sounds really a no
brainer. The mixture-avoidance of the series is the more difficult part
I believe (with page->virtual still retained for the DEFAULT serie).

> 
> > BTW, did you checked my fix for the contiogous_pte in fixinit_range?
> 
> Yes, not keen on it!  You'll have my separate mail with patch by now.

thanks, my version is a few liner change to fixinit_range, yours is
bigger, but I will try to merge yours as soon as I will check it in
detail (I trust you it is better than my dirty fix :). OTOH, while the
"best" version should go into 2.5, for 2.4 I would have lived just fine
with the shorted possible fix that I did yesterday too :)

> Glad to, and glad we're now more or less "on the same page"!

yep :)

Andrea
