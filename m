Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289181AbSAVR76>; Tue, 22 Jan 2002 12:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289251AbSAVR7t>; Tue, 22 Jan 2002 12:59:49 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:15003 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S289181AbSAVR7b>; Tue, 22 Jan 2002 12:59:31 -0500
Date: Tue, 22 Jan 2002 18:01:43 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
In-Reply-To: <20020121191539.K8292@athlon.random>
Message-ID: <Pine.LNX.4.21.0201221609060.1030-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Andrea Arcangeli wrote:
> On Sat, Jan 19, 2002 at 08:56:53PM +0000, Hugh Dickins wrote:
> > ....
> > that puts a limit NR_CPUS+1 on the kmaps needed here, so just add
> > NR_CPUS+1 for safety to the poolsize already thought necessary (??),
> 
> the number of cpus have nothing to do with this, the issue is only the
> number of tasks, the problem is the same in a UP or in a 1024way
> machine.

If copy_page_range were some low-level function called from all over
the place, or if it blocked after its second kmap, I'd agree with you.
But I'm afraid your PAGETABLE2 justifications have only made me firmer
in the opinion that it's unnecessary.  Never mind, that disagreement
is irrelevant because...

> > instead of holding a separate pool.  But the stronger reason is that
> > pte_offset2 is being called with dst->page_table_lock held, yet it
> 
> pte_offset2 is called without the pagetable lock held, otherwise it had
> to be a pte_offset_atomic, we cannot recall pte_offset with a spinlock
> held because pte_offset can schedule.
> 
> > may have to block while all its kmaps are in use: elsewhere you have
> > consistently used pte_offset_atomic when spinlock held, why not here?
> 
> because the spinlock isn't held there :)

Please look again.  src->page_table_lock is not held across pte_offset2,
but dst->page_table_lock _is_ being held across pte_offset2.  See comment
just above copy_page_range.  See how the immediately preceding pte_alloc
expects dst->page_table_lock to be held.  So, pte_offset_atomic is
appropriate there, and pte_offset2 etc can go.

Actually, I'm coming to think that most of the pte_offset_atomic
calls should be replaced by a pte_offset_nowait: which gives the usual
pte_offset kmap if it can without blocking, or an atomic if not - your
pte_kunmap seems nicely designed for that very possibility.  Whether
pte_offset_nowait should ever flush_all_zero_pkmaps, or just return
an atomic in the end-of-pkmap case, I'm not sure.

> the mixture between PAGETABLE2 and PAGETABLE series due the
> reentrance of kmap is more difficult to proof as correct. The reason it
> cannot deadlock is that the previous pte_alloc (from the PAGETABLE
> serie) is on a certainly newly created kmap, so it cannot be the one
> that keeps a PAGETABLE2 slot pinned. As far as you do pte_offset2 while
> you are sure you're not keeping pinned a PAGETABLE2 slot in the same
> path (possibly with a pte_offset/pte_alloc) you're safe. The case of the
> fork() path is obviously correct because the pte_alloc will map
> something new. 

No, the phrase "newly created kmap" is misleading.  It is a new use
for a kmap, but the mapping being used may simply be that left over
from the previous use of that page.  To get the SERIEs working as you
intend, you need to re-kmap whenever serie wanted differs from serie
already assigned (but PAGETABLE/PAGETABLE2 distinction a nuisance,
PAGETABLE2 when it's forking parent, PAGETABLE at other times).

And what happens when a page is wanted for two purposes at once?  I'm
thinking there of mapping /dev/mem, kmapping as DEFAULT while it's in
use as PAGETABLE.  At present /dev/mem does not supply highmem, but if
page tables are in highmem, I believe we shall need to give something
like LKCD's lcrash access to it.

> Same is true between KM_SERIE_PAGETABLE and KM_SERIE_DEFAULT, the reason
> it is obviously correct here is because the mixture cannot happen since
> the first place, because pages will pass through the freelist before the
> two can be mixed, and so they will be kunmapped first.

I think you're mistaken there: passing through the
freelist doesn't affect a page's kmapping at all, does it?
We could make changes to do so, but that wouldn't be enough.

> > ....
> > And doesn't that argument assume an ordering, a rule that a task
> > would necessarily allocate DEFAULT before PAGETABLE (or vice versa)?
> 
> The ordering doesn't matter. You just don't need to keep pinned a
> DEFAULT while mapping a default, and the other way around for pagetable.
> 
> > But I think in some contexts it's one way round (DEFAULT before
> > PAGETABLE when read's file_read_actor's __copy_to_user faults),
> > and in other contexts the other way round (PAGETABLE before DEFAULT
> > when do_no_page's block_read_full_page clears hole, or nfs readpage,
> > or ramfs readpage, or shmem_nopage's clear_highpage).  I'm willing
> > to believe that the DEFAULT,PAGETABLE distinction reduces the chance
> > of kmap exhaustion deadlock, but it looks difficult to carry through.
> 
> I don't think there's any possible conflict between DEFAULT and
> PAGETABLE.

But I'm suggesting that in some cases a DEFAULT kmap is pinned while
a PAGETABLE kmap is being acquired, and in other cases a PAGETABLE
kmap is pinned while a DEFAULT kmap is being acquired; which might
be happening concurrently in an unlimited (well, <32768) number of
tasks.  Is that not so?  And couldn't that deadlock, even if the
DEFAULT/PAGETABLE distinction were strictly maintained?  Of course,
the all-one-pool case can deadlock there too: perhaps more easily
(though it would be sensible to give that one pool as many entries
as all your pools combined).

Well, I've had my say: I believe the SERIEs, as currently implemented,
give _an illusion of_ security from kmap deadlock.  But it feels like
I'm failing to dislodge you from your belief in them, and they're
not actively harmful, so I'll shut up - until provoked!

> > A final point.  I don't have a conclusive argument (beyond simplicity),
> > but I believe it will prove to be a mistake to give highmem pagetables
> > to the kernel's vmalloc area.  I think you should define pte_alloc_k
> > for vmalloc, then you can avoid its pte_kunmaps, and remove traps.c
> > fault.c ioremap.c drm_scatter.h drm_vm.h from the patch (drm_proc.h
> > would have to stay; but personally, I'd just delete that #if 0 block
> > and be done with it - it's shown up too often in my pte greps!); and
> > save you from having to add all those video drivers using "rvmalloc"
> > into the patch, currently they're missing.
> 
> That's an option, but it's so easy to update those few drivers that I'm
> not sure if it worth to ask yourself if the pte are been allocated by
> vmalloc, and also putting hacks into vmalloc.c doesn't look very nice,
> it is more effort than to update the drivers I believe.

Well, you've done that work now in pre4aa1, and you've fixed the only
actual problem I saw with it overnight, and was hoping to hit you with
today (the vmalloc fault in interrupt context).  I still don't like it
(just now I was checking my pagetable_init patch, wanted to check the
the vmalloc pagetable, quite difficult), but never mind.

Hugh

