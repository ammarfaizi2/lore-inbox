Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268294AbUHQPqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbUHQPqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268290AbUHQPqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:46:14 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:14219 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268319AbUHQP3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:29:39 -0400
Date: Tue, 17 Aug 2004 08:28:44 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: "David S. Miller" <davem@redhat.com>, raybry@sgi.com, ak@muc.de,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page fault fastpath patch v2: fix race conditions, stats for 8,32
 and 512 cpu SMP
In-Reply-To: <20040816143903.GY11200@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0408170804430.8365@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <20040815130919.44769735.davem@redhat.com> <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
 <20040815165827.0c0c8844.davem@redhat.com> <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
 <20040815185644.24ecb247.davem@redhat.com> <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
 <20040816143903.GY11200@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second release of the page fault fastpath path. The fast path
avoids locking during the creation of page table entries for anonymous
memory in a threaded application running on a SMP system. The performance
increases significantly for more than 4 threads running concurrently.

Changes:
- Insure that it is safe to call the various functions without holding
the page_table_lock.
- Fix cases in rmap.c where a pte could be cleared for a very short time
before being set to another value by introducing a pte_xchg function. This
created a potential race condition with the fastpath code which checks for
a cleared pte without holding the page_table_lock.
- i386 support
- Various cleanups

Issue remaining:
- The fastpath increments mm->rss without acquiring the page_table_lock.
Introducing the page_table_lock even for a short time makes performance
drop to the level before the patch.

Ideas:
- One could avoid pte locking by introducing a pte_cmpxchg. cmpxchg
seems to be supported by all ia64 and i386 cpus except the original 80386.
- Make rss atomic or eliminate rss?

==== 8 CPU SMP system

Unpatched:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  2   3    1    0.094s      4.500s   4.059s 85561.646  85568.398
  2   3    2    0.092s      6.390s   3.043s 60649.650 114521.474
  2   3    4    0.081s      6.500s   1.093s 59740.813 203552.963
  2   3    8    0.101s     12.001s   2.035s 32487.736 167082.560

With page fault fastpath patch:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  2   3    1    0.095s      4.544s   4.064s 84733.378  84699.952
  2   3    2    0.080s      4.749s   2.056s 81426.302 153163.463
  2   3    4    0.081s      5.173s   1.057s 74828.674 249792.084
  2   3    8    0.093s      7.097s   1.021s 54678.576 324072.260

==== 16 CPU system

Unpatched:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 16   3    1    0.627s     61.749s  62.038s 50430.908  50427.364
 16   3    2    0.579s     64.237s  33.068s 48532.874  93375.083
 16   3    4    0.608s     87.579s  28.011s 35670.888 111900.261
 16   3    8    0.612s    122.913s  19.074s 25466.233 159343.342
 16   3   16    0.617s    383.727s  26.091s  8184.648 116868.093
 16   3   32    2.492s    753.081s  25.031s  4163.364 124275.119

With page fault fastpath patch:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 16   3    1    0.572s     61.460s  62.003s 50710.367  50705.490
 16   3    2    0.571s     63.951s  33.057s 48753.975  93679.565
 16   3    4    0.593s     72.737s  24.078s 42897.603 126927.505
 16   3    8    0.625s     85.085s  15.008s 36701.575 208502.061
 16   3   16    0.560s     67.191s   6.096s 46430.048 451954.271
 16   3   32    1.599s    162.986s   5.079s 19112.972 543031.652

==== 512 CPU system

Unpatched:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 16   3    1    0.748s     67.200s  67.098s 46295.921  46270.533
 16   3    2    0.899s    100.189s  52.021s 31118.426  60242.544
 16   3    4    1.517s    103.467s  31.021s 29963.479 100777.788
 16   3    8    1.268s    166.023s  26.035s 18803.807 119350.434
 16   3   16    6.296s    453.445s  33.082s  6842.371  92987.774
 16   3   32   22.434s   1341.205s  48.026s  2306.860  65174.913
 16   3   64   54.189s   4633.748s  81.089s   671.026  38411.466
 16   3  128  244.333s  17584.111s 152.026s   176.444  20659.132
 16   3  256  222.936s   8167.241s  73.018s   374.930  42983.366
 16   3  512  207.464s   4259.264s  39.044s   704.258  79741.366

With page fault fastpath patch:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 16   3    1    0.884s     64.241s  65.014s 48302.177  48287.787
 16   3    2    0.931s     99.156s  51.058s 31429.640  60979.126
 16   3    4    1.028s     88.451s  26.096s 35155.837 116669.999
 16   3    8    1.957s     61.395s  12.099s 49654.307 242078.305
 16   3   16    5.701s     81.382s   9.039s 36122.904 334774.381
 16   3   32   15.207s    163.893s   9.094s 17564.021 316284.690
 16   3   64   76.056s    440.771s  13.037s  6086.601 235120.800
 16   3  128  203.843s   1535.909s  19.084s  1808.145 158495.679
 16   3  256  274.815s    755.764s  12.058s  3052.387 250010.942
 16   3  512  205.505s    381.106s   7.060s  5362.531 413531.352

Test program and scripts were posted with the first release of this patch.

Feedback welcome. I will be at a conference for the rest of the week and
may reply late to feedback.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

==== FASTPATH PATCH

Index: linux-2.6.8.1/mm/memory.c
===================================================================
--- linux-2.6.8.1.orig/mm/memory.c	2004-08-14 03:55:24.000000000 -0700
+++ linux-2.6.8.1/mm/memory.c	2004-08-16 21:37:39.000000000 -0700
@@ -1680,6 +1680,10 @@
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
+#ifdef __HAVE_ARCH_PTE_LOCK
+	pte_t *pte;
+	pte_t entry;
+#endif

 	__set_current_state(TASK_RUNNING);
 	pgd = pgd_offset(mm, address);
@@ -1688,7 +1692,81 @@

 	if (is_vm_hugetlb_page(vma))
 		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+#ifdef __HAVE_ARCH_PTE_LOCK
+	/*
+	 * Fast path for anonymous pages, not found faults bypassing
+	 * the necessity to acquire the page_table_lock
+	 */
+
+	if ((vma->vm_ops && vma->vm_ops->nopage) || pgd_none(*pgd)) goto use_page_table_lock;
+	pmd = pmd_offset(pgd,address);
+	if (pmd_none(*pmd)) goto use_page_table_lock;
+	pte = pte_offset_kernel(pmd,address);
+	if (pte_locked(*pte)) return VM_FAULT_MINOR;
+	if (!pte_none(*pte)) goto use_page_table_lock;
+
+	/*
+	 * Page not present, so kswapd and PTE updates will not touch the pte
+	 * so we are able to just use a pte lock.
+	 */
+
+	/* Return from fault handler perhaps cause another fault if the page is still locked */
+	if (ptep_lock(pte)) return VM_FAULT_MINOR;
+	/* Someout could have set the pte to something else before we acquired the lock. check */
+	if (!pte_none(pte_mkunlocked(*pte))) {
+		ptep_unlock(pte);
+		return VM_FAULT_MINOR;
+	}
+	/* Read-only mapping of ZERO_PAGE. */
+	entry = pte_wrprotect(mk_pte(ZERO_PAGE(address), vma->vm_page_prot));
+
+	if (write_access) {
+		struct page *page;
+
+		/*
+		 * anon_vma_prepare only requires the mmap_mem lock and
+		 * will acquire the page_table_lock if necessary
+		 */
+		if (unlikely(anon_vma_prepare(vma))) goto no_mem;
+
+		/* alloc_page_vma only requires mmap_mem lock */
+		page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		if (!page)  goto no_mem;
+
+		clear_user_highpage(page, address);
+
+		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,vma->vm_page_prot)),vma);
+		/* lru_cache_add_active uses a cpu_var */
+		lru_cache_add_active(page);
+		mark_page_accessed(page);
+
+		/*
+		 * Incrementing rss usually requires the page_table_lock
+		 * We need something to make this atomic!
+		 * Adding a lock here will hurt performance significantly
+		 */
+		mm->rss++;
+
+		/*
+		 * Invoking page_add_anon_rmap without the page_table_lock since
+		 * page is a newly allocated page not yet managed by VM
+		 */
+		page_add_anon_rmap(page, vma, address);
+	}
+	/* Setting the pte clears the pte lock so there is no need for unlocking */
+	set_pte(pte, entry);
+	pte_unmap(pte);
+
+	/* No need to invalidate - it was non-present before */
+	update_mmu_cache(vma, address, entry);
+	return VM_FAULT_MINOR;		/* Minor fault */

+no_mem:
+	ptep_unlock(pte);
+	return VM_FAULT_OOM;
+
+use_page_table_lock:
+#endif
 	/*
 	 * We need the page table lock to synchronize with kswapd
 	 * and the SMP-safe atomic PTE updates.
Index: linux-2.6.8.1/mm/rmap.c
===================================================================
--- linux-2.6.8.1.orig/mm/rmap.c	2004-08-14 03:56:22.000000000 -0700
+++ linux-2.6.8.1/mm/rmap.c	2004-08-16 21:41:19.000000000 -0700
@@ -333,7 +333,10 @@
  * @vma:	the vm area in which the mapping is added
  * @address:	the user virtual address mapped
  *
- * The caller needs to hold the mm->page_table_lock.
+ * The caller needs to hold the mm->page_table_lock if page
+ * is pointing to something that is known by the vm.
+ * The lock does not need to be held if page is pointing
+ * to a newly allocated page.
  */
 void page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address)
@@ -494,11 +497,6 @@

 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address);
-	pteval = ptep_clear_flush(vma, address, pte);
-
-	/* Move the dirty bit to the physical page now the pte is gone. */
-	if (pte_dirty(pteval))
-		set_page_dirty(page);

 	if (PageAnon(page)) {
 		swp_entry_t entry = { .val = page->private };
@@ -508,9 +506,14 @@
 		 */
 		BUG_ON(!PageSwapCache(page));
 		swap_duplicate(entry);
-		set_pte(pte, swp_entry_to_pte(entry));
+		pteval = ptep_xchg_flush(vma, address, pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
-	}
+	} else
+		pteval = ptep_clear_flush(vma, address, pte);
+
+	/* Move the dirty bit to the physical page now the pte is gone. */
+	if (pte_dirty(pteval))
+		set_page_dirty(page);

 	mm->rss--;
 	BUG_ON(!page->mapcount);
@@ -602,11 +605,12 @@

 		/* Nuke the page table entry. */
 		flush_cache_page(vma, address);
-		pteval = ptep_clear_flush(vma, address, pte);

 		/* If nonlinear, store the file page offset in the pte. */
 		if (page->index != linear_page_index(vma, address))
-			set_pte(pte, pgoff_to_pte(page->index));
+			pteval = ptep_xchg_flush(vma, address, pte, pgoff_to_pte(page->index));
+		else
+			pteval = ptep_clear_flush(vma, address, pte);

 		/* Move the dirty bit to the physical page now the pte is gone. */
 		if (pte_dirty(pteval))

===== PTE LOCK PATCH

Index: linux-2.6.8.1/include/asm-generic/pgtable.h
===================================================================
--- linux-2.6.8.1.orig/include/asm-generic/pgtable.h	2004-08-14 03:55:10.000000000 -0700
+++ linux-2.6.8.1/include/asm-generic/pgtable.h	2004-08-16 21:36:11.000000000 -0700
@@ -85,6 +85,15 @@
 }
 #endif

+#ifndef __HAVE_ARCH_PTEP_XCHG
+static inline pte_t ptep_xchg(pte_t *ptep,pte_t pteval)
+{
+	pte_t pte = *ptep;
+	set_pte(ptep, pteval);
+	return pte;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
 #define ptep_clear_flush(__vma, __address, __ptep)			\
 ({									\
@@ -94,6 +103,16 @@
 })
 #endif

+#ifndef __HAVE_ARCH_PTEP_XCHG_FLUSH
+#define ptep_xchg_flush(__vma, __address, __ptep, __pteval)		\
+({									\
+	pte_t __pte = ptep_xchg(__ptep, __pteval);			\
+	flush_tlb_page(__vma, __address);				\
+	__pte;								\
+})
+#endif
+
+
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(pte_t *ptep)
 {
Index: linux-2.6.8.1/include/asm-ia64/pgtable.h
===================================================================
--- linux-2.6.8.1.orig/include/asm-ia64/pgtable.h	2004-08-14 03:55:10.000000000 -0700
+++ linux-2.6.8.1/include/asm-ia64/pgtable.h	2004-08-16 20:36:12.000000000 -0700
@@ -30,6 +30,8 @@
 #define _PAGE_P_BIT		0
 #define _PAGE_A_BIT		5
 #define _PAGE_D_BIT		6
+#define _PAGE_IG_BITS		53
+#define _PAGE_LOCK_BIT		(_PAGE_IG_BITS+3)	/* bit 56. Aligned to 8 bits */

 #define _PAGE_P			(1 << _PAGE_P_BIT)	/* page present bit */
 #define _PAGE_MA_WB		(0x0 <<  2)	/* write back memory attribute */
@@ -58,6 +60,7 @@
 #define _PAGE_PPN_MASK		(((__IA64_UL(1) << IA64_MAX_PHYS_BITS) - 1) & ~0xfffUL)
 #define _PAGE_ED		(__IA64_UL(1) << 52)	/* exception deferral */
 #define _PAGE_PROTNONE		(__IA64_UL(1) << 63)
+#define _PAGE_LOCK		(__IA64_UL(1) << _PAGE_LOCK_BIT)

 /* Valid only for a PTE with the present bit cleared: */
 #define _PAGE_FILE		(1 << 1)		/* see swap & file pte remarks below */
@@ -281,6 +284,13 @@
 #define pte_mkyoung(pte)	(__pte(pte_val(pte) | _PAGE_A))
 #define pte_mkclean(pte)	(__pte(pte_val(pte) & ~_PAGE_D))
 #define pte_mkdirty(pte)	(__pte(pte_val(pte) | _PAGE_D))
+#define pte_mkunlocked(pte)	(__pte(pte_val(pte) & ~_PAGE_LOCK))
+/*
+ * Lock functions for pte's
+*/
+#define ptep_lock(ptep)		test_and_set_bit(_PAGE_LOCK_BIT,ptep)
+#define ptep_unlock(ptep)	{ clear_bit(_PAGE_LOCK_BIT,ptep);smp_mb__after_clear_bit(); }
+#define pte_locked(pte)		((pte_val(pte) & _PAGE_LOCK)!=0)

 /*
  * Macro to a page protection value as "uncacheable".  Note that "protection" is really a
@@ -387,6 +397,18 @@
 #endif
 }

+static inline pte_t
+ptep_xchg (pte_t *ptep,pte_t pteval)
+{
+#ifdef CONFIG_SMP
+	return __pte(xchg((long *) ptep, pteval.pte));
+#else
+	pte_t pte = *ptep;
+	set_pte(ptep,pteval);
+	return pte;
+#endif
+}
+
 static inline void
 ptep_set_wrprotect (pte_t *ptep)
 {
@@ -554,10 +576,12 @@
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+#define __HAVE_ARCH_PTEP_XCHG
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
 #define __HAVE_ARCH_PGD_OFFSET_GATE
+#define __HAVE_ARCH_PTE_LOCK
 #include <asm-generic/pgtable.h>

 #endif /* _ASM_IA64_PGTABLE_H */
Index: linux-2.6.8.1/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.8.1.orig/include/asm-i386/pgtable.h	2004-08-14 03:55:48.000000000 -0700
+++ linux-2.6.8.1/include/asm-i386/pgtable.h	2004-08-16 20:36:12.000000000 -0700
@@ -101,7 +101,7 @@
 #define _PAGE_BIT_DIRTY		6
 #define _PAGE_BIT_PSE		7	/* 4 MB (or 2MB) page, Pentium+, if present.. */
 #define _PAGE_BIT_GLOBAL	8	/* Global TLB entry PPro+ */
-#define _PAGE_BIT_UNUSED1	9	/* available for programmer */
+#define _PAGE_BIT_LOCK		9	/* available for programmer */
 #define _PAGE_BIT_UNUSED2	10
 #define _PAGE_BIT_UNUSED3	11
 #define _PAGE_BIT_NX		63
@@ -115,7 +115,7 @@
 #define _PAGE_DIRTY	0x040
 #define _PAGE_PSE	0x080	/* 4 MB (or 2MB) page, Pentium+, if present.. */
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry PPro+ */
-#define _PAGE_UNUSED1	0x200	/* available for programmer */
+#define _PAGE_LOCK	0x200	/* available for programmer */
 #define _PAGE_UNUSED2	0x400
 #define _PAGE_UNUSED3	0x800

@@ -201,6 +201,7 @@
 extern unsigned long pg0[];

 #define pte_present(x)	((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
+#define pte_locked(x) ((x).pte_low & _PAGE_LOCK)
 #define pte_clear(xp)	do { set_pte(xp, __pte(0)); } while (0)

 #define pmd_none(x)	(!pmd_val(x))
@@ -236,6 +237,7 @@
 static inline pte_t pte_mkdirty(pte_t pte)	{ (pte).pte_low |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
+static inline pte_t pte_mkunlocked(pte_t pte)	{ (pte).pte_low &= ~_PAGE_LOCK; return pte; }

 #ifdef CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
@@ -260,6 +262,9 @@
 static inline void ptep_set_wrprotect(pte_t *ptep)		{ clear_bit(_PAGE_BIT_RW, &ptep->pte_low); }
 static inline void ptep_mkdirty(pte_t *ptep)			{ set_bit(_PAGE_BIT_DIRTY, &ptep->pte_low); }

+#define ptep_lock(ptep) test_and_set_bit(_PAGE_BIT_LOCK,&ptep->pte_low)
+#define ptep_unlock(ptep) clear_bit(_PAGE_BIT_LOCK,&ptep->pte_low)
+
 /*
  * Macro to mark a page protection value as "uncacheable".  On processors which do not support
  * it, this is a no-op.
@@ -416,9 +421,11 @@
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+#define __HAVE_ARCH_PTEP_XCHG
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
+#define __HAVE_ARCH_PTE_LOCK
 #include <asm-generic/pgtable.h>

 #endif /* _I386_PGTABLE_H */
