Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287317AbSASUzA>; Sat, 19 Jan 2002 15:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287332AbSASUyu>; Sat, 19 Jan 2002 15:54:50 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31932 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S287317AbSASUyl>; Sat, 19 Jan 2002 15:54:41 -0500
Date: Sat, 19 Jan 2002 20:56:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
In-Reply-To: <20020118033800.C4847@athlon.random>
Message-ID: <Pine.LNX.4.21.0201192053550.1254-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Andrea Arcangeli wrote:
> 
> It really makes the cricial difference (deadlock avoidance is the only
> reason there is the serie thing in the kmaps). see the thread with Ingo
> about mempool, it's exactly the same problem.
> 
> in short: the same task cannot get two entries from the same serie
> (/mempool) or the system can deadlock.

Many thanks for your patient illustrations, Andrea.
I certainly don't dispute that an indefinite number of tasks,
competing for multiple limited resources, are liable to deadlock.
I hope your heart won't sink too heavily when I say I'm still not
convinced that your SERIEs will solve that.  I really value your
time, so please don't spend it on detailed reply to me (never
mind my ?s): I'm trying to help, but in danger of hindering you.
Nobody should interpret your silence as accepting my points.

I still believe that KM_SERIE_PAGETABLE2 kmap_pagetable2 pmd_page2
pte_offset2 should just be removed.  The weaker reason is that they
are used only in copy_page_range, and there's no block between the
pte_offset2 and the pte_kunmaps, so progress can be made if all cpus
have done the kmap in pte_alloc, and there's at least one kmap spare
(or freeable) to use for the pte_offset (replacing the pte_offset2);
that puts a limit NR_CPUS+1 on the kmaps needed here, so just add
NR_CPUS+1 for safety to the poolsize already thought necessary (??),
instead of holding a separate pool.  But the stronger reason is that
pte_offset2 is being called with dst->page_table_lock held, yet it
may have to block while all its kmaps are in use: elsewhere you have
consistently used pte_offset_atomic when spinlock held, why not here?

You might argue that there would always be a spare KM_SERIE_PAGETABLE2
kmap (after the usual flush_all_zero_pkmaps), could never block there.
But if that's so, it's not at all obvious: because of the way the
SERIEs are not entirely disjoint.  When trying to kmap for a particular
serie, kmap_high accepts the existing page->virtual, no matter what
serie it belongs to.  So I think it is possible that though PAGETABLE2s
are only assigned in copy_page_range, they could linger indefinitely
being used as PAGETABLEs and even as DEFAULTs (since kmaps independent
of page freeing).  I suspect that this blurring of the distinction
between SERIEs invalidates (in a strict sense) the deadlock avoidance
argument for separate SERIEs.

And doesn't that argument assume an ordering, a rule that a task
would necessarily allocate DEFAULT before PAGETABLE (or vice versa)?
But I think in some contexts it's one way round (DEFAULT before
PAGETABLE when read's file_read_actor's __copy_to_user faults),
and in other contexts the other way round (PAGETABLE before DEFAULT
when do_no_page's block_read_full_page clears hole, or nfs readpage,
or ramfs readpage, or shmem_nopage's clear_highpage).  I'm willing
to believe that the DEFAULT,PAGETABLE distinction reduces the chance
of kmap exhaustion deadlock, but it looks difficult to carry through.

Eek!  Am I reading that right?  pte_alloc_one uses clear_highpage
which uses kmap i.e. DEFAULT, so with the persistence of page->virtual,
page tables will usually start out as DEFAULT and not PAGETABLE?  If
you retain the separate SERIEs, then I think you will need to add a
clear_pagetable for use by pte_alloc_one.

Regarding swap_out_pmd: I expect you've now made it pte_offset_atomic
because the spinlock is held; but want to highlight that that one for
sure must not use the same pool as pte_alloc, otherwise you could
deadlock with swap_out needing the pool to free pages, but waiting
page allocators holding all kmaps from that pool.

I am worried by the way those pagetable kmaps are held across
handle_pte_fault: under memory load with many tasks, the system will
reach the point where all pagetable kmaps are in use, waiting for
pages to be allocated to satisfy the faults.  Perhaps that's just
a fact of life, perhaps it will bring its own problems.  It also
seems wrong how often we are reduced to using the atomic kmaps: I'm
not against them, I don't think "invlpg" is itself expensive, but after
going to the trouble to set up a cache of mappings, it's sad to have
to bypass it so often.  I think we're going to find a better design
later on, but right now I don't have a constructive suggestion
(aah, 65536 kmaps, that would help!).

A final point.  I don't have a conclusive argument (beyond simplicity),
but I believe it will prove to be a mistake to give highmem pagetables
to the kernel's vmalloc area.  I think you should define pte_alloc_k
for vmalloc, then you can avoid its pte_kunmaps, and remove traps.c
fault.c ioremap.c drm_scatter.h drm_vm.h from the patch (drm_proc.h
would have to stay; but personally, I'd just delete that #if 0 block
and be done with it - it's shown up too often in my pte greps!); and
save you from having to add all those video drivers using "rvmalloc"
into the patch, currently they're missing.

(On the contiguity of the pagetables for kmaps: yes, you're right,
the patch I offered goes rather beyond what you'd want to put in
right now.  I'll try very hard to cut it down to what's necessary
- but I'm sure you know just how hard it is to resist cleaning up!)

Hugh

