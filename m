Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315850AbSEWFPf>; Thu, 23 May 2002 01:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316056AbSEWFPe>; Thu, 23 May 2002 01:15:34 -0400
Received: from [195.223.140.120] ([195.223.140.120]:31602 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315850AbSEWFPc>; Thu, 23 May 2002 01:15:32 -0400
Date: Thu, 23 May 2002 07:14:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Q: backport of the free_pgtables tlb fixes to 2.4
Message-ID: <20020523051454.GO21164@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

I'm dealing with the backport of the free_pgtables() tlb flushes fixes
to 2.4 (got interrupted with it in the middle of the inode highmem
imbalance). I seen a patch and an explanation floating around but it's
wrong as far I can tell in the sense it seems completly a noop.

As far I can see by reading the code the only kernel bug was in the
free_pgtables path and nothing else, so in theory by commenting out the
call of free_pgtables (that is not strictly required except for security
against malicious proggy) the segfault should go away too (could be even
a valid workaround for 2.4). Also it's not related to the P4 cpu, it's
just a generic bug for all archs it seems.

In both 2.4 and 2.5 we were just doing the release of the pages
correctly in zap_page_range, by clearing the pte entry, then
invalidating the tlb and finally freeing the page, I can't see problems
in the normal do_munmap path unless free_pgtables triggers too.

Only in free_pgtables there's an exception: if during an munmap a whole
pgd slot is unmapped we go to a deeper level and we throw away both pmd
and pte too (under the now empty pgd slot) to make space and avoid
expoits that fills the whole pagetable unswappable metadata but without
real pages associated to it.

The problem is that while freeing the pte and pmd we don't do the
"clear; invalidate tlb; free ram" ordered-thread-SMP-safe shootdown
sequence but we instead do the racy "clear; free; invalidate tlb"
SMP-thread-unsafe ordering and that's _THE_ bug. So the fix is simply to
extend the tlb_gather_mm/tlb_finish_mmu/tlb_remove_page to the
free_pgtables path too (while dropping pte/pmd), so in turn to
clear_page_tables, even if only the "free_pgtables" caller really needs
it. exit_mmap obviously cannot need the enforced "clear; invalidate tlb;
free ram" ordering because by the time exit_mmap is recalled there
cannot be any racy reader of the address space in parallel [mm_users ==
0] (and higher performance for exit_mmap are taken care by the fast
mode, or better it was supposed to be taken care before the fast mode
broke in latest 2.5, see below).

I don't see why you changed the "fast mode" to 1 cpu (even without an
#ifdef SMP), if the mm_users is == 1 we are just guaranteed that no
parallel reading of the address space that we're working on can happen
(we're also guaranteed that mm_users cannot increase or decrease under
us), no matter on the number of the cpus. I think the "fast mode" should
return to the more efficient one of 2.4, not to be "slow mode for every
true SMP".

About the patch floating around I also seen random changes in leave_mm
that I cannot explain (that's in 2.5 too, I think that part of 2.5
is superflous too infact)

 /*
  * We cannot call mmdrop() because we are in interrupt context, 
  * instead update mm->cpu_vm_mask.
+ *
+ * We need to reload %cr3 since the page tables may be going
+ * away from under us..
  */
 static void inline leave_mm (unsigned long cpu)
 {
 	if (cpu_tlbstate[cpu].state == TLBSTATE_OK)
 		BUG();
 	clear_bit(cpu, &cpu_tlbstate[cpu].active_mm->cpu_vm_mask);
+	load_cr3(swapper_pg_dir);
 }
 
 /*

explanation of why the above is superflous: every time a task enters the
lazy state we bump the mm_users so the active_mm is pinned somehow and
nothing can throw away the kernel side of the pgd, so we cannot care
less about loading swapper_pg_dir in %cr3 for tasks in lazy state, it's
simply not required, so I think the patch above is superflous. The
pinned mm (if it's the last refernece) is released by the scheduler
after our cr3 changed in switch_mm. The comment is wrong, our page
tables cannot go away under us, because being a lazy task it only
allowed to use the kernel side of the address space and nothing can
throw it away.

A change like this (not from 2.5) as well is obviously superflous:

 #define tlb_remove_page(ctxp, pte, addr) do {\
 		/* Handle the common case fast, first. */\
 		if ((ctxp)->nr == ~0UL) {\
-			__free_pte(*(pte));\
-			pte_clear((pte));\
+			pte_t __pte = *(pte);\
+			pte_clear(pte);\
+			__free_pte(__pte);\

nr == ~0UL is the single threaded case, so again there cannot be any
parallel reader of the address space, and so it's perfectly fine to free
the page, clear the pte and finally flush the tlb, we don't care about
the ordering if we're single threaded, any ordering is ok, nobody can
access the address space while we're working on it.

This below change as well is superflous after we backout the above
change to leave_mm.

@@ -51,9 +51,9 @@
 			BUG();
 		if(!test_and_set_bit(cpu, &next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm * disabled 
-			 * tlb flush IPI delivery. We must flush our
			 tlb.
+			 * tlb flush IPI delivery. We must reload %cr3.
 			 */
-			local_flush_tlb();
+			load_cr3(next->pgd);
 		}


This actually gets more near to the real problem...

 static inline void flush_tlb_pgtables(struct mm_struct *mm,
 				      unsigned long start, unsigned long end)
 {
-	/* i386 does not keep any page table caches in TLB */
+	flush_tlb_mm(mm);
 }
[..]
 void clear_page_tables(struct mm_struct *mm, unsigned long first, int
nr)
 {
 	pgd_t * page_dir = mm->pgd;
+	unsigned long	last = first + nr;
 
 	spin_lock(&mm->page_table_lock);
 	page_dir += first;
@@ -153,6 +154,8 @@
 	} while (--nr);
 	spin_unlock(&mm->page_table_lock);
 
+	flush_tlb_pgtables(mm, first * PGDIR_SIZE, last * PGDIR_SIZE);
+	
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
[..]

... but it's again a noop, cannot fix anything, still any tlb flush done
there is way too late, the pte just gone away in the freelist at that
time. It may reduce the window for the race at best.

The only effective fix that nobody backported yet to 2.4 AFIK is to
avoid the race between free_pgtables and a parallel reader thread in the
address space, and it consists in backporting the pte_free_tlb(tlb, pte)
in the clear_page_tables path to 2.4, nothing else and nothing more. the
zap_page_range path and the fast mode of 2.4 just looks perfectly
correct, only free_pgtables must start using the "slow mode that enforce
ordering" when the mm_count is > 1 (either that or commenting out
free_pgtables will be a valid workaround for the SMP race).

Could you confirm/comment or explain what the problem really is? Many
thanks!

Andrea
