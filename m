Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287647AbSAUSPQ>; Mon, 21 Jan 2002 13:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287645AbSAUSPH>; Mon, 21 Jan 2002 13:15:07 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:33568 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287647AbSAUSOy>; Mon, 21 Jan 2002 13:14:54 -0500
Date: Mon, 21 Jan 2002 19:15:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
Message-ID: <20020121191539.K8292@athlon.random>
In-Reply-To: <20020118033800.C4847@athlon.random> <Pine.LNX.4.21.0201192053550.1254-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0201192053550.1254-100000@localhost.localdomain>; from hugh@veritas.com on Sat, Jan 19, 2002 at 08:56:53PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2002 at 08:56:53PM +0000, Hugh Dickins wrote:
> On Fri, 18 Jan 2002, Andrea Arcangeli wrote:
> > 
> > It really makes the cricial difference (deadlock avoidance is the only
> > reason there is the serie thing in the kmaps). see the thread with Ingo
> > about mempool, it's exactly the same problem.
> > 
> > in short: the same task cannot get two entries from the same serie
> > (/mempool) or the system can deadlock.
> 
> Many thanks for your patient illustrations, Andrea.

I'm the one who should thank you for the so helpful reviews, thanks so
much.

> I certainly don't dispute that an indefinite number of tasks,
> competing for multiple limited resources, are liable to deadlock.
> I hope your heart won't sink too heavily when I say I'm still not
> convinced that your SERIEs will solve that.  I really value your
> time, so please don't spend it on detailed reply to me (never
> mind my ?s): I'm trying to help, but in danger of hindering you.
> Nobody should interpret your silence as accepting my points.
> 
> I still believe that KM_SERIE_PAGETABLE2 kmap_pagetable2 pmd_page2
> pte_offset2 should just be removed.  The weaker reason is that they
> are used only in copy_page_range, and there's no block between the
> pte_offset2 and the pte_kunmaps, so progress can be made if all cpus

the only issue is that the pte_offset2 could deadlock if it would be a
pte_offset instead of a pte_offset2. 

> have done the kmap in pte_alloc, and there's at least one kmap spare
> (or freeable) to use for the pte_offset (replacing the pte_offset2);

there isn't a kmap spare, all 1024 kmaps are been used by 1024 tasks all
running pte_alloc, and later all blocking in the pte_offset (replacing
the pte_offset2), so all the 1024 tasks blocks in pte_offset, waiting a
spare kmap that will never arrive. KM_SERIE_PAGETABLE2 fixes this.

It is exactly like with the bio allocation, you can't allocate two bio
from the same mempool from the same taks or you can deadlock.

> that puts a limit NR_CPUS+1 on the kmaps needed here, so just add
> NR_CPUS+1 for safety to the poolsize already thought necessary (??),

the number of cpus have nothing to do with this, the issue is only the
number of tasks, the problem is the same in a UP or in a 1024way
machine.

> instead of holding a separate pool.  But the stronger reason is that
> pte_offset2 is being called with dst->page_table_lock held, yet it

pte_offset2 is called without the pagetable lock held, otherwise it had
to be a pte_offset_atomic, we cannot recall pte_offset with a spinlock
held because pte_offset can schedule.

> may have to block while all its kmaps are in use: elsewhere you have
> consistently used pte_offset_atomic when spinlock held, why not here?

because the spinlock isn't held there :)

> You might argue that there would always be a spare KM_SERIE_PAGETABLE2
> kmap (after the usual flush_all_zero_pkmaps), could never block there.
> But if that's so, it's not at all obvious: because of the way the
> SERIEs are not entirely disjoint.  When trying to kmap for a particular
> serie, kmap_high accepts the existing page->virtual, no matter what
> serie it belongs to.  So I think it is possible that though PAGETABLE2s
> are only assigned in copy_page_range, they could linger indefinitely
> being used as PAGETABLEs and even as DEFAULTs (since kmaps independent
> of page freeing).  I suspect that this blurring of the distinction
> between SERIEs invalidates (in a strict sense) the deadlock avoidance
> argument for separate SERIEs.

the mixture between PAGETABLE2 and PAGETABLE series due the
reentrance of kmap is more difficult to proof as correct. The reason it
cannot deadlock is that the previous pte_alloc (from the PAGETABLE
serie) is on a certainly newly created kmap, so it cannot be the one
that keeps a PAGETABLE2 slot pinned. As far as you do pte_offset2 while
you are sure you're not keeping pinned a PAGETABLE2 slot in the same
path (possibly with a pte_offset/pte_alloc) you're safe. The case of the
fork() path is obviously correct because the pte_alloc will map
something new. 

Same is true between KM_SERIE_PAGETABLE and KM_SERIE_DEFAULT, the reason
it is obviously correct here is because the mixture cannot happen since
the first place, because pages will pass through the freelist before the
two can be mixed, and so they will be kunmapped first.

So still it can't deadlock and it's fine to use pte_offset2.
kunmap_vaddr will take care to unmap anything whatever it cames from.

The decision if to use pte_offset_atomic or pte_offset2 should be based
solely on performance factors (which still have to be measured).

> And doesn't that argument assume an ordering, a rule that a task
> would necessarily allocate DEFAULT before PAGETABLE (or vice versa)?

The ordering doesn't matter. You just don't need to keep pinned a
DEFAULT while mapping a default, and the other way around for pagetable.

> But I think in some contexts it's one way round (DEFAULT before
> PAGETABLE when read's file_read_actor's __copy_to_user faults),
> and in other contexts the other way round (PAGETABLE before DEFAULT
> when do_no_page's block_read_full_page clears hole, or nfs readpage,
> or ramfs readpage, or shmem_nopage's clear_highpage).  I'm willing
> to believe that the DEFAULT,PAGETABLE distinction reduces the chance
> of kmap exhaustion deadlock, but it looks difficult to carry through.

I don't think there's any possible conflict between DEFAULT and
PAGETABLE.

> Eek!  Am I reading that right?  pte_alloc_one uses clear_highpage
> which uses kmap i.e. DEFAULT, so with the persistence of page->virtual,
> page tables will usually start out as DEFAULT and not PAGETABLE?  If
> you retain the separate SERIEs, then I think you will need to add a
> clear_pagetable for use by pte_alloc_one.

agreed, thanks.

> Regarding swap_out_pmd: I expect you've now made it pte_offset_atomic
> because the spinlock is held; but want to highlight that that one for

correct, this was the missing chunk:

--- 2.4.18pre2aa2/mm/vmscan.c.~1~	Wed Jan 16 17:52:20 2002
+++ 2.4.18pre2aa2/mm/vmscan.c	Fri Jan 18 03:51:45 2002
@@ -164,7 +164,7 @@
 /* mm->page_table_lock is held. mmap_sem is not held */
 static inline int swap_out_pmd(struct mm_struct * mm, struct vm_area_struct * vma, pmd_t *dir, unsigned long address, unsigned long end, int count, zone_t * classzone)
 {
-	pte_t * pte;
+	pte_t * pte, * pte_orig;
 	unsigned long pmd_end;
 
 	if (pmd_none(*dir))
@@ -175,7 +175,7 @@
 		return count;
 	}
 	
-	pte = pte_offset(dir, address);
+	pte_orig = pte = pte_offset_atomic(dir, address);
 	
 	pmd_end = (address + PMD_SIZE) & PMD_MASK;
 	if (end > pmd_end)
@@ -196,6 +196,7 @@
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
+	pte_kunmap(pte_orig);
 	mm->swap_address = address;
 	return count;
 }

> sure must not use the same pool as pte_alloc, otherwise you could
> deadlock with swap_out needing the pool to free pages, but waiting
> page allocators holding all kmaps from that pool.
> 
> I am worried by the way those pagetable kmaps are held across
> handle_pte_fault: under memory load with many tasks, the system will
> reach the point where all pagetable kmaps are in use, waiting for
> pages to be allocated to satisfy the faults.  Perhaps that's just
> a fact of life, perhaps it will bring its own problems.  It also
> seems wrong how often we are reduced to using the atomic kmaps: I'm
> not against them, I don't think "invlpg" is itself expensive, but after
> going to the trouble to set up a cache of mappings, it's sad to have
> to bypass it so often.  I think we're going to find a better design
> later on, but right now I don't have a constructive suggestion
> (aah, 65536 kmaps, that would help!).

1024 tasks all taking a pagefault at the same time before the 1025th has
to block, sounds like a rasonable limit at the moment. Enlarging the
pool should be easy, by just changing the LAST_PKMAP define.

> A final point.  I don't have a conclusive argument (beyond simplicity),
> but I believe it will prove to be a mistake to give highmem pagetables
> to the kernel's vmalloc area.  I think you should define pte_alloc_k
> for vmalloc, then you can avoid its pte_kunmaps, and remove traps.c
> fault.c ioremap.c drm_scatter.h drm_vm.h from the patch (drm_proc.h
> would have to stay; but personally, I'd just delete that #if 0 block
> and be done with it - it's shown up too often in my pte greps!); and
> save you from having to add all those video drivers using "rvmalloc"
> into the patch, currently they're missing.

That's an option, but it's so easy to update those few drivers that I'm
not sure if it worth to ask yourself if the pte are been allocated by
vmalloc, and also putting hacks into vmalloc.c doesn't look very nice,
it is more effort than to update the drivers I believe.

> (On the contiguity of the pagetables for kmaps: yes, you're right,
> the patch I offered goes rather beyond what you'd want to put in
> right now.  I'll try very hard to cut it down to what's necessary
> - but I'm sure you know just how hard it is to resist cleaning up!)

oh yes, I know :)

Andrea
