Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131134AbRAAWqb>; Mon, 1 Jan 2001 17:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131155AbRAAWqV>; Mon, 1 Jan 2001 17:46:21 -0500
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:51932 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S131134AbRAAWqI>; Mon, 1 Jan 2001 17:46:08 -0500
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200101012215.XAA20190@faui11.informatik.uni-erlangen.de>
Subject: [RFC, PATCH] TLB flush changes for S/390
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Date: Mon, 1 Jan 2001 23:15:26 +0100 (MET)
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, ton@de.ibm.com
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

on the S/390 architecture we have problems implementing the flush_tlb_page()
macro efficiently.  The only semantically correct implementation on S/390 is
to completely flush the TLB, which is somewhat suboptimal ...

With only minor interface changes, however, it becomes possible for us to
use the (very efficient) Invalidate Page Table Entry (ipte) instruction,
which clears out one particular mapping from a virtual to a physical page
in a particular address space on all CPUs.  The reason why we cannot use 
this to implement flush_tlb_page() is simply that ipte requires that the 
*original* PTE is still present in the page table when ipte is performed.

Thus, I was wondering whether it would be possible that you check these
proposed modifications out, and if they don't pose any problems, integrate 
them into the standard kernel?

The basic idea is simple:  wherever we currently have some pte modification
followed by a flush_tlb_page, merge these two operations into a single routine 
provided by the architecture.  The default asm-generic implementation can
then simply use flush_tlb_page, while the S/390 implementation can use ipte
to perform both operations combined.

The changes in detail:

 * Make establish_pte architecture-dependent (as ptep_establish).
   Semantics unchanged.

 * Add new arch-dependent routine ptep_invalidate, which performs a
   combination of ptep_get_and_clear and flush_tlb_page.  Use this
   routine in try_to_swap_out.

 * Change semantics of ptep_test_and_clear_{young|dirty} to have
   these routines perform a TLB flush if they change the bit.
   Therefore, remove the flush_tlb_page call in filemap_sync_pte.

Note that the only caller of ptep_test_and_clear_dirty was 
filemap_sync_pte which did a flush_tlb_page anyway, so here
the overall semantics is unchanged.  However, the only caller
of ptep_test_and_clear_young is try_to_swap_out, which does
currently *not* flush the TLB when it clears the accessed bit.
However, I would argue that the TLB *should* in fact be flushed,
otherwise the accessed bit might not be re-set by future 
accesses to the page ...

All in all, this change means that an architecture which
implements those four routines (ptep_test_and_clear_{young|dirty},
ptep_invalidate, ptep_establish) need not implement 
flush_tlb_page, because the common code does not call this 
routine anymore.  Those four routines can be efficiently 
implemented on S/390 using ipte ...


Some remaining questions:

 * Is there some reason why ptep_test_and_clear_young should
   *not*, after all, flush the TLB?

 * In try_to_swap_out, should the flush_cache_page call be
   moved before the ptep_invalidate call to ensure it is 
   performed before the flush_tlb_page call?

   Maybe flush_cache_page should even be *called* by 
   ptep_establish and ptep_invalidate?

 * It is somewhat unfortunate that flush_tlb_page resides in
   pgalloc.h, which makes it necessary to include pgalloc.h
   into asm-generic/pgtable.h ...


Thanks,
Ulrich Weigand
(IBM Linux for S/390 development)


diff -ur linux-2.4.0-prerelease/include/asm-generic/pgtable.h linux-2.4.0-prerelease-tlb/include/asm-generic/pgtable.h
--- linux-2.4.0-prerelease/include/asm-generic/pgtable.h	Mon Dec 11 22:45:42 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-generic/pgtable.h	Mon Jan  1 20:51:00 2001
@@ -1,22 +1,41 @@
 #ifndef _ASM_GENERIC_PGTABLE_H
 #define _ASM_GENERIC_PGTABLE_H
 
-static inline int ptep_test_and_clear_young(pte_t *ptep)
+#include <asm/pgalloc.h>
+
+static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
 {
 	pte_t pte = *ptep;
 	if (!pte_young(pte))
 		return 0;
 	set_pte(ptep, pte_mkold(pte));
+	flush_tlb_page(vma, address);
 	return 1;
 }
 
-static inline int ptep_test_and_clear_dirty(pte_t *ptep)
+static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
 {
 	pte_t pte = *ptep;
 	if (!pte_dirty(pte))
 		return 0;
 	set_pte(ptep, pte_mkclean(pte));
+	flush_tlb_page(vma, address);
 	return 1;
+}
+
+static inline void ptep_establish(struct vm_area_struct *vma, unsigned long address, pte_t *ptep, pte_t entry)
+{
+	set_pte(ptep, entry);
+	flush_tlb_page(vma, address);
+	update_mmu_cache(vma, address, entry);
+}
+
+static inline pte_t ptep_invalidate(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
+{
+	pte_t pte = *ptep;
+	pte_clear(ptep);
+	flush_tlb_page(vma, address);
+	return pte;
 }
 
 static inline pte_t ptep_get_and_clear(pte_t *ptep)
diff -ur linux-2.4.0-prerelease/include/asm-i386/pgtable.h linux-2.4.0-prerelease-tlb/include/asm-i386/pgtable.h
--- linux-2.4.0-prerelease/include/asm-i386/pgtable.h	Sun Dec 31 20:10:17 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-i386/pgtable.h	Mon Jan  1 17:11:27 2001
@@ -281,10 +281,35 @@
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
 
-static inline  int ptep_test_and_clear_dirty(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_DIRTY, ptep); }
-static inline  int ptep_test_and_clear_young(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_ACCESSED, ptep); }
-static inline void ptep_set_wrprotect(pte_t *ptep)		{ clear_bit(_PAGE_BIT_RW, ptep); }
-static inline void ptep_mkdirty(pte_t *ptep)			{ set_bit(_PAGE_BIT_DIRTY, ptep); }
+static inline void ptep_set_wrprotect(pte_t *ptep)	{ clear_bit(_PAGE_BIT_RW, ptep); }
+static inline void ptep_mkdirty(pte_t *ptep)		{ set_bit(_PAGE_BIT_DIRTY, ptep); }
+
+static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
+{ 
+	if (!test_and_clear_bit(_PAGE_BIT_DIRTY, ptep))
+		return 0;
+	flush_tlb_page(vma, address);
+	return 1;
+}
+static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
+{ 
+	if (!test_and_clear_bit(_PAGE_BIT_ACCESSED, ptep))
+		return 0;
+	flush_tlb_page(vma, address);
+	return 1;
+}
+static inline void ptep_establish(struct vm_area_struct *vma, unsigned long address, pte_t *ptep, pte_t entry)
+{       
+	set_pte(ptep, entry);
+	flush_tlb_page(vma, address);
+}
+static inline pte_t ptep_invalidate(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
+{
+	pte_t pte = ptep_get_and_clear(ptep);
+	flush_tlb_page(vma, address);
+	return pte;
+}
+
 
 /*
  * Conversion functions: convert a page and protection to a page entry,
diff -ur linux-2.4.0-prerelease/mm/filemap.c linux-2.4.0-prerelease-tlb/mm/filemap.c
--- linux-2.4.0-prerelease/mm/filemap.c	Sat Dec 30 02:11:46 2000
+++ linux-2.4.0-prerelease-tlb/mm/filemap.c	Mon Jan  1 17:11:27 2001
@@ -1592,7 +1592,6 @@
 
 	if (pte_present(pte) && ptep_test_and_clear_dirty(ptep)) {
 		struct page *page = pte_page(pte);
-		flush_tlb_page(vma, address);
 		set_page_dirty(page);
 	}
 	return 0;
diff -ur linux-2.4.0-prerelease/mm/memory.c linux-2.4.0-prerelease-tlb/mm/memory.c
--- linux-2.4.0-prerelease/mm/memory.c	Fri Dec 29 23:07:57 2000
+++ linux-2.4.0-prerelease-tlb/mm/memory.c	Mon Jan  1 17:11:27 2001
@@ -775,18 +775,6 @@
 	return error;
 }
 
-/*
- * Establish a new mapping:
- *  - flush the old one
- *  - update the page tables
- *  - inform the TLB about the new one
- */
-static inline void establish_pte(struct vm_area_struct * vma, unsigned long address, pte_t *page_table, pte_t entry)
-{
-	set_pte(page_table, entry);
-	flush_tlb_page(vma, address);
-	update_mmu_cache(vma, address, entry);
-}
 
 static inline void break_cow(struct vm_area_struct * vma, struct page *	old_page, struct page * new_page, unsigned long address, 
 		pte_t *page_table)
@@ -794,7 +782,7 @@
 	copy_cow_page(old_page,new_page,address);
 	flush_page_to_ram(new_page);
 	flush_cache_page(vma, address);
-	establish_pte(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
+	ptep_establish(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
 }
 
 /*
@@ -852,7 +840,7 @@
 		/* FallThrough */
 	case 1:
 		flush_cache_page(vma, address);
-		establish_pte(vma, address, page_table, pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
+		ptep_establish(vma, address, page_table, pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
 		spin_unlock(&mm->page_table_lock);
 		return 1;	/* Minor fault */
 	}
@@ -1180,7 +1168,7 @@
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
-	establish_pte(vma, address, pte, entry);
+	ptep_establish(vma, address, pte, entry);
 	spin_unlock(&mm->page_table_lock);
 	return 1;
 }
diff -ur linux-2.4.0-prerelease/mm/vmscan.c linux-2.4.0-prerelease-tlb/mm/vmscan.c
--- linux-2.4.0-prerelease/mm/vmscan.c	Fri Dec 29 23:07:57 2000
+++ linux-2.4.0-prerelease-tlb/mm/vmscan.c	Mon Jan  1 17:11:27 2001
@@ -78,7 +78,7 @@
 	 * is needed on CPUs which update the accessed and dirty
 	 * bits in hardware.
 	 */
-	pte = ptep_get_and_clear(page_table);
+	pte = ptep_invalidate(vma, address, page_table);
 
 	/*
 	 * Is the page already in the swap cache? If so, then
@@ -98,7 +98,6 @@
 drop_pte:
 		UnlockPage(page);
 		mm->rss--;
-		flush_tlb_page(vma, address);
 		deactivate_page(page);
 		page_cache_release(page);
 out_failed:
-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
