Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289355AbSAVTNA>; Tue, 22 Jan 2002 14:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289357AbSAVTMm>; Tue, 22 Jan 2002 14:12:42 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:2057 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289355AbSAVTMg>; Tue, 22 Jan 2002 14:12:36 -0500
Date: Tue, 22 Jan 2002 20:10:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
Message-ID: <20020122201002.E1547@athlon.random>
In-Reply-To: <20020121191539.K8292@athlon.random> <Pine.LNX.4.21.0201221609060.1030-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0201221609060.1030-100000@localhost.localdomain>; from hugh@veritas.com on Tue, Jan 22, 2002 at 06:01:43PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 06:01:43PM +0000, Hugh Dickins wrote:
> On Mon, 21 Jan 2002, Andrea Arcangeli wrote:
> > On Sat, Jan 19, 2002 at 08:56:53PM +0000, Hugh Dickins wrote:
> > > ....
> > > that puts a limit NR_CPUS+1 on the kmaps needed here, so just add
> > > NR_CPUS+1 for safety to the poolsize already thought necessary (??),
> > 
> > the number of cpus have nothing to do with this, the issue is only the
> > number of tasks, the problem is the same in a UP or in a 1024way
> > machine.
> 
> If copy_page_range were some low-level function called from all over
> the place, or if it blocked after its second kmap, I'd agree with you.
> But I'm afraid your PAGETABLE2 justifications have only made me firmer
> in the opinion that it's unnecessary.  Never mind, that disagreement
> is irrelevant because...
> 
> > > instead of holding a separate pool.  But the stronger reason is that
> > > pte_offset2 is being called with dst->page_table_lock held, yet it
> > 
> > pte_offset2 is called without the pagetable lock held, otherwise it had
> > to be a pte_offset_atomic, we cannot recall pte_offset with a spinlock
> > held because pte_offset can schedule.
> > 
> > > may have to block while all its kmaps are in use: elsewhere you have
> > > consistently used pte_offset_atomic when spinlock held, why not here?
> > 
> > because the spinlock isn't held there :)
> 
> Please look again.  src->page_table_lock is not held across pte_offset2,
> but dst->page_table_lock _is_ being held across pte_offset2.  See comment

Oops, I overlooked one spin_lock held by the caller :). Many thanks for
spotting this.  at least it will only deadlock at worse (if the
PAGETABLE2 seies is shorted).

> just above copy_page_range.  See how the immediately preceding pte_alloc
> expects dst->page_table_lock to be held.  So, pte_offset_atomic is
> appropriate there, and pte_offset2 etc can go.

Either that or pte_offset_under_lock2.

> Actually, I'm coming to think that most of the pte_offset_atomic
> calls should be replaced by a pte_offset_nowait: which gives the usual
> pte_offset kmap if it can without blocking, or an atomic if not - your
> pte_kunmap seems nicely designed for that very possibility.  Whether

Possible optimization. Before doing so we should really measure how the
kmaps are faster compared to the kmap_atomic I believe. This could be a
performance optimization. But it could also be that the kmap_atomic are
faster and it doesn't worth to get into the kmap overhead when
persistence is not necessary.

> pte_offset_nowait should ever flush_all_zero_pkmaps, or just return
> an atomic in the end-of-pkmap case, I'm not sure.
> 
> > the mixture between PAGETABLE2 and PAGETABLE series due the
> > reentrance of kmap is more difficult to proof as correct. The reason it
> > cannot deadlock is that the previous pte_alloc (from the PAGETABLE
> > serie) is on a certainly newly created kmap, so it cannot be the one
> > that keeps a PAGETABLE2 slot pinned. As far as you do pte_offset2 while
> > you are sure you're not keeping pinned a PAGETABLE2 slot in the same
> > path (possibly with a pte_offset/pte_alloc) you're safe. The case of the
> > fork() path is obviously correct because the pte_alloc will map
> > something new. 
> 
> No, the phrase "newly created kmap" is misleading.  It is a new use
> for a kmap, but the mapping being used may simply be that left over
> from the previous use of that page.  To get the SERIEs working as you
> intend, you need to re-kmap whenever serie wanted differs from serie
> already assigned (but PAGETABLE/PAGETABLE2 distinction a nuisance,
> PAGETABLE2 when it's forking parent, PAGETABLE at other times).

pagetable2 is needed every single time you need to access two pagetables
at the same time with a static kmap. Infact now that I notice it also
mremap needs it. With mremap both the two kmaps could return
entries in the PAGETABLE serie, no-way around it.

So to solve all this mess between mixture of PAGETABLE2 and PAGETABLE
(and even with DEFAULT if /dev/kmem will ever mess with highmem), I will
just drop the recursive behaviour of kmap. That is not needed for
coherency, that was only a kind of performance optimization and to
maintain a page->virtual, so I will just kill it and then we're done, no
mixture mess any longer. I will left it only for the DEFAULT serie,
because of the page->virtual, all other series will not care about
page->virtual any longer, page->virtual was a bad idea since the first
place, it would been better to keep the information on the current
stack, like all the other series will do.

> And what happens when a page is wanted for two purposes at once?  I'm
> thinking there of mapping /dev/mem, kmapping as DEFAULT while it's in
> use as PAGETABLE.  At present /dev/mem does not supply highmem, but if
> page tables are in highmem, I believe we shall need to give something
> like LKCD's lcrash access to it.

see above.

> 
> > Same is true between KM_SERIE_PAGETABLE and KM_SERIE_DEFAULT, the reason
> > it is obviously correct here is because the mixture cannot happen since
> > the first place, because pages will pass through the freelist before the
> > two can be mixed, and so they will be kunmapped first.
> 
> I think you're mistaken there: passing through the
> freelist doesn't affect a page's kmapping at all, does it?
> We could make changes to do so, but that wouldn't be enough.

Doing:

	page = alloc_page();
	kmap(page);
	__free_page(page)

is a bug (it will leak kmap entries eventually), this is what i meant
with "passing through the freelist" as serializing point between
PAGETABLE and DEFAULT series.

> 
> > > ....
> > > And doesn't that argument assume an ordering, a rule that a task
> > > would necessarily allocate DEFAULT before PAGETABLE (or vice versa)?
> > 
> > The ordering doesn't matter. You just don't need to keep pinned a
> > DEFAULT while mapping a default, and the other way around for pagetable.
> > 
> > > But I think in some contexts it's one way round (DEFAULT before
> > > PAGETABLE when read's file_read_actor's __copy_to_user faults),
> > > and in other contexts the other way round (PAGETABLE before DEFAULT
> > > when do_no_page's block_read_full_page clears hole, or nfs readpage,
> > > or ramfs readpage, or shmem_nopage's clear_highpage).  I'm willing
> > > to believe that the DEFAULT,PAGETABLE distinction reduces the chance
> > > of kmap exhaustion deadlock, but it looks difficult to carry through.
> > 
> > I don't think there's any possible conflict between DEFAULT and
> > PAGETABLE.
> 
> But I'm suggesting that in some cases a DEFAULT kmap is pinned while
> a PAGETABLE kmap is being acquired, and in other cases a PAGETABLE
> kmap is pinned while a DEFAULT kmap is being acquired; which might
> be happening concurrently in an unlimited (well, <32768) number of
> tasks.  Is that not so?  And couldn't that deadlock, even if the
> DEFAULT/PAGETABLE distinction were strictly maintained?  Of course,
> the all-one-pool case can deadlock there too: perhaps more easily
> (though it would be sensible to give that one pool as many entries
> as all your pools combined).
> 
> Well, I've had my say: I believe the SERIEs, as currently implemented,
> give _an illusion of_ security from kmap deadlock.  But it feels like
> I'm failing to dislodge you from your belief in them, and they're
> not actively harmful, so I'll shut up - until provoked!

You shouldn't really giveup if you think it's not right yet! :) Also I
now agree the ordering matters. So I'd define an ordering which is
PAGETABLE2 first, PAGETABLE second, and DEFAULT third. This in
combination of the changes I will make to the kmap (only DEFAULT kmap
reentrant), should fix all the deadlocks, right? The ordering between
DEFAULT and PAGETABLE should be always enforced, if we get a kmap on a
page it will be after we touch its respective pagetable, right?

I will try to get a new version out in the next few days. In short we
found that current version can deadlock in mremap (double PAGETABLE kmap
in a raw) or in fork (overlooked the spinlock), both deadlocks are not
reproducible in real life for me in normal usage at least, next version
should not deadlock there any longer.

BTW, did you checked my fix for the contiogous_pte in fixinit_range?

many thanks for the help,

Andrea
