Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbTCTXEZ>; Thu, 20 Mar 2003 18:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263244AbTCTXEY>; Thu, 20 Mar 2003 18:04:24 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:40088 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S263228AbTCTXCU>; Thu, 20 Mar 2003 18:02:20 -0500
Date: Thu, 20 Mar 2003 23:15:06 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: [PATCH] anobjrmap 3/6 unchained
In-Reply-To: <Pine.LNX.4.44.0303202310440.2743-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303202314190.2743-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anobjrmap 3/6 remove pte-pointer-based rmap

Lots of deletions: the next patch will put in the new anon rmap,
I expect it to look clearer if first we remove all of the old
pte-pointer-based anon rmap in this patch - which therefore
leaves anonymous rmap totally disabled, anon pages locked in
memory until the process frees them.

A few additions: the previous patch brought ClearPageAnon into
rmap.c instead of leaving it to final page free; but I think
there'd be a race with swapin or swapoff doing SetPageAnon:
now SetPageAnon under lock within page_add_rmap.  That lock
now being called rmap_lock instead of pte_chain_lock.

Removed nr_reverse_maps, ReverseMaps: easily reverted if that
poses a vmstat or meminfo compatibility problem, or someone is
still interested in that number; but objrmap wasn't maintaining
it, and if they don't occupy space, is it worth showing?
Besides, look at page_dup_rmap for copy_page_range: I don't
want to clutter that with inc_page_state(nr_reverse_maps).

 fs/exec.c                  |   10 
 fs/proc/proc_misc.c        |    6 
 include/asm-generic/rmap.h |   90 ----
 include/asm-i386/pgtable.h |   12 
 include/asm-i386/rmap.h    |   21 -
 include/linux/mm.h         |   20 -
 include/linux/page-flags.h |   10 
 include/linux/rmap.h       |   27 -
 init/main.c                |    2 
 mm/fremap.c                |   16 
 mm/memory.c                |  130 +------
 mm/mremap.c                |   37 --
 mm/nommu.c                 |    4 
 mm/page_alloc.c            |   10 
 mm/rmap.c                  |  818 +++++++++------------------------------------
 mm/swapfile.c              |   14 
 mm/vmscan.c                |   22 -
 17 files changed, 250 insertions(+), 999 deletions(-)

--- anobjrmap2/fs/exec.c	Thu Mar 20 17:09:50 2003
+++ anobjrmap3/fs/exec.c	Thu Mar 20 17:10:12 2003
@@ -293,15 +293,11 @@
 	pgd_t * pgd;
 	pmd_t * pmd;
 	pte_t * pte;
-	struct pte_chain *pte_chain;
 
 	if (page_count(page) != 1)
 		printk(KERN_ERR "mem_map disagrees with %p at %08lx\n", page, address);
 
 	pgd = pgd_offset(tsk->mm, address);
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain)
-		goto out_sig;
 	spin_lock(&tsk->mm->page_table_lock);
 	pmd = pmd_alloc(tsk->mm, pgd, address);
 	if (!pmd)
@@ -316,22 +312,18 @@
 	lru_cache_add_active(page);
 	flush_dcache_page(page);
 	flush_page_to_ram(page);
-	SetPageAnon(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, PAGE_COPY))));
-	pte_chain = page_add_rmap(page, pte, pte_chain);
+	page_add_rmap(page, 1);
 	pte_unmap(pte);
 	tsk->mm->rss++;
 	spin_unlock(&tsk->mm->page_table_lock);
 
 	/* no need for flush_tlb */
-	pte_chain_free(pte_chain);
 	return;
 out:
 	spin_unlock(&tsk->mm->page_table_lock);
-out_sig:
 	__free_page(page);
 	force_sig(SIGKILL, tsk);
-	pte_chain_free(pte_chain);
 	return;
 }
 
--- anobjrmap2/fs/proc/proc_misc.c	Thu Mar 20 17:10:01 2003
+++ anobjrmap3/fs/proc/proc_misc.c	Thu Mar 20 17:10:12 2003
@@ -177,8 +177,7 @@
 		"Mapped:       %8lu kB\n"
 		"Slab:         %8lu kB\n"
 		"Committed_AS: %8u kB\n"
-		"PageTables:   %8lu kB\n"
-		"ReverseMaps:  %8lu\n",
+		"PageTables:   %8lu kB\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.bufferram),
@@ -197,8 +196,7 @@
 		K(ps.nr_mapped),
 		K(ps.nr_slab),
 		K(committed),
-		K(ps.nr_page_table_pages),
-		ps.nr_reverse_maps
+		K(ps.nr_page_table_pages)
 		);
 
 		len += hugetlb_report_meminfo(page + len);
--- anobjrmap2/include/asm-generic/rmap.h	Mon Feb 10 20:12:52 2003
+++ anobjrmap3/include/asm-generic/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,90 +0,0 @@
-#ifndef _GENERIC_RMAP_H
-#define _GENERIC_RMAP_H
-/*
- * linux/include/asm-generic/rmap.h
- *
- * Architecture dependent parts of the reverse mapping code,
- * this version should work for most architectures with a
- * 'normal' page table layout.
- *
- * We use the struct page of the page table page to find out
- * the process and full address of a page table entry:
- * - page->mapping points to the process' mm_struct
- * - page->index has the high bits of the address
- * - the lower bits of the address are calculated from the
- *   offset of the page table entry within the page table page
- *
- * For CONFIG_HIGHPTE, we need to represent the address of a pte in a
- * scalar pte_addr_t.  The pfn of the pte's page is shifted left by PAGE_SIZE
- * bits and is then ORed with the byte offset of the pte within its page.
- *
- * For CONFIG_HIGHMEM4G, the pte_addr_t is 32 bits.  20 for the pfn, 12 for
- * the offset.
- *
- * For CONFIG_HIGHMEM64G, the pte_addr_t is 64 bits.  52 for the pfn, 12 for
- * the offset.
- */
-#include <linux/mm.h>
-
-static inline void pgtable_add_rmap(struct page * page, struct mm_struct * mm, unsigned long address)
-{
-#ifdef BROKEN_PPC_PTE_ALLOC_ONE
-	/* OK, so PPC calls pte_alloc() before mem_map[] is setup ... ;( */
-	extern int mem_init_done;
-
-	if (!mem_init_done)
-		return;
-#endif
-	page->mapping = (void *)mm;
-	page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
-	inc_page_state(nr_page_table_pages);
-}
-
-static inline void pgtable_remove_rmap(struct page * page)
-{
-	page->mapping = NULL;
-	page->index = 0;
-	dec_page_state(nr_page_table_pages);
-}
-
-static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
-{
-	struct page * page = kmap_atomic_to_page(ptep);
-	return (struct mm_struct *) page->mapping;
-}
-
-static inline unsigned long ptep_to_address(pte_t * ptep)
-{
-	struct page * page = kmap_atomic_to_page(ptep);
-	unsigned long low_bits;
-	low_bits = ((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE;
-	return page->index + low_bits;
-}
-
-#if CONFIG_HIGHPTE
-static inline pte_addr_t ptep_to_paddr(pte_t *ptep)
-{
-	pte_addr_t paddr;
-	paddr = ((pte_addr_t)page_to_pfn(kmap_atomic_to_page(ptep))) << PAGE_SHIFT;
-	return paddr + (pte_addr_t)((unsigned long)ptep & ~PAGE_MASK);
-}
-#else
-static inline pte_addr_t ptep_to_paddr(pte_t *ptep)
-{
-	return (pte_addr_t)ptep;
-}
-#endif
-
-#ifndef CONFIG_HIGHPTE
-static inline pte_t *rmap_ptep_map(pte_addr_t pte_paddr)
-{
-	return (pte_t *)pte_paddr;
-}
-
-static inline void rmap_ptep_unmap(pte_t *pte)
-{
-	return;
-}
-#endif
-
-#endif /* _GENERIC_RMAP_H */
--- anobjrmap2/include/asm-i386/pgtable.h	Wed Mar 19 11:05:12 2003
+++ anobjrmap3/include/asm-i386/pgtable.h	Thu Mar 20 17:10:12 2003
@@ -288,18 +288,6 @@
 #define pte_unmap_nested(pte) do { } while (0)
 #endif
 
-#if defined(CONFIG_HIGHPTE) && defined(CONFIG_HIGHMEM4G)
-typedef u32 pte_addr_t;
-#endif
-
-#if defined(CONFIG_HIGHPTE) && defined(CONFIG_HIGHMEM64G)
-typedef u64 pte_addr_t;
-#endif
-
-#if !defined(CONFIG_HIGHPTE)
-typedef pte_t *pte_addr_t;
-#endif
-
 /*
  * The i386 doesn't have any external MMU info: the kernel page
  * tables contain all the necessary information.
--- anobjrmap2/include/asm-i386/rmap.h	Mon Sep 16 05:51:50 2002
+++ anobjrmap3/include/asm-i386/rmap.h	Thu Jan  1 01:00:00 1970
@@ -1,21 +0,0 @@
-#ifndef _I386_RMAP_H
-#define _I386_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#ifdef CONFIG_HIGHPTE
-static inline pte_t *rmap_ptep_map(pte_addr_t pte_paddr)
-{
-	unsigned long pfn = (unsigned long)(pte_paddr >> PAGE_SHIFT);
-	unsigned long off = ((unsigned long)pte_paddr) & ~PAGE_MASK;
-	return (pte_t *)((char *)kmap_atomic(pfn_to_page(pfn), KM_PTE2) + off);
-}
-
-static inline void rmap_ptep_unmap(pte_t *pte)
-{
-	kunmap_atomic(pte, KM_PTE2);
-}
-#endif
-
-#endif
--- anobjrmap2/include/linux/mm.h	Thu Mar 20 17:10:01 2003
+++ anobjrmap3/include/linux/mm.h	Thu Mar 20 17:10:12 2003
@@ -139,8 +139,6 @@
 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
 };
 
-/* forward declaration; pte_chain is meant to be internal to rmap.c */
-struct pte_chain;
 struct mmu_gather;
 
 /*
@@ -167,12 +165,7 @@
 	unsigned long index;		/* Our offset within mapping. */
 	struct list_head lru;		/* Pageout list, eg. active_list;
 					   protected by zone->lru_lock !! */
-	union {
-		struct pte_chain *chain;/* Reverse pte mapping pointer.
-					 * protected by PG_chainlock */
-		pte_addr_t direct;
-		int mapcount;
-	} pte;
+	unsigned long rmap_count;	/* Count mappings in mms */
 	unsigned long private;		/* mapping-private opaque data */
 
 	/*
@@ -371,16 +364,7 @@
  * refers to user virtual address space into which the page is mapped.
  */
 #define page_mapping(page) (PageAnon(page)? NULL: (page)->mapping)
-
-/*
- * Return true if this page is mapped into pagetables.  Subtle: test pte.direct
- * rather than pte.chain.  Because sometimes pte.direct is 64-bit, and .chain
- * is only 32-bit.
- */
-static inline int page_mapped(struct page *page)
-{
-	return page->pte.direct != 0;
-}
+#define page_mapped(page)  ((page)->rmap_count != 0)
 
 /*
  * Error return values for the *_nopage functions
--- anobjrmap2/include/linux/page-flags.h	Thu Mar 20 17:10:01 2003
+++ anobjrmap3/include/linux/page-flags.h	Thu Mar 20 17:10:12 2003
@@ -68,9 +68,8 @@
 #define PG_private		12	/* Has something at ->private */
 #define PG_writeback		13	/* Page is under writeback */
 #define PG_nosave		14	/* Used for system suspend/resume */
-#define PG_chainlock		15	/* lock bit for ->pte_chain */
+#define PG_rmaplock		15	/* Lock bit for reversing to ptes */
 
-#define PG_direct		16	/* ->pte_chain points directly at pte */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
@@ -88,7 +87,6 @@
 	unsigned long nr_pagecache;	/* Pages in pagecache */
 	unsigned long nr_swapcache;	/* Pages in swapcache */
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-	unsigned long nr_reverse_maps;	/* includes PageDirect */
 	unsigned long nr_mapped;	/* mapped into pagetables */
 	unsigned long nr_slab;		/* In slab */
 #define GET_PAGE_STATE_LAST nr_slab
@@ -241,12 +239,6 @@
 #define ClearPageNosave(page)		clear_bit(PG_nosave, &(page)->flags)
 #define TestClearPageNosave(page)	test_and_clear_bit(PG_nosave, &(page)->flags)
 
-#define PageDirect(page)	test_bit(PG_direct, &(page)->flags)
-#define SetPageDirect(page)	set_bit(PG_direct, &(page)->flags)
-#define TestSetPageDirect(page)	test_and_set_bit(PG_direct, &(page)->flags)
-#define ClearPageDirect(page)		clear_bit(PG_direct, &(page)->flags)
-#define TestClearPageDirect(page)	test_and_clear_bit(PG_direct, &(page)->flags)
-
 #define PageMappedToDisk(page)	test_bit(PG_mappedtodisk, &(page)->flags)
 #define SetPageMappedToDisk(page) set_bit(PG_mappedtodisk, &(page)->flags)
 #define ClearPageMappedToDisk(page) clear_bit(PG_mappedtodisk, &(page)->flags)
--- anobjrmap2/include/linux/rmap.h	Thu Mar 20 17:10:01 2003
+++ anobjrmap3/include/linux/rmap.h	Thu Mar 20 17:10:12 2003
@@ -8,20 +8,9 @@
 #include <linux/linkage.h>
 
 #ifdef CONFIG_MMU
-
-struct pte_chain;
-struct pte_chain *pte_chain_alloc(int gfp_flags);
-void __pte_chain_free(struct pte_chain *pte_chain);
-
-static inline void pte_chain_free(struct pte_chain *pte_chain)
-{
-	if (pte_chain)
-		__pte_chain_free(pte_chain);
-}
-
-struct pte_chain *FASTCALL(
-	page_add_rmap(struct page *, pte_t *, struct pte_chain *));
-void FASTCALL(page_remove_rmap(struct page *, pte_t *));
+void FASTCALL(page_add_rmap(struct page *, int anon));
+void FASTCALL(page_dup_rmap(struct page *));
+void FASTCALL(page_remove_rmap(struct page *));
 
 /*
  * Called from mm/vmscan.c to handle paging out
@@ -43,7 +32,7 @@
 #define SWAP_AGAIN	1
 #define SWAP_FAIL	2
 
-static inline void pte_chain_lock(struct page *page)
+static inline void rmap_lock(struct page *page)
 {
 	/*
 	 * Assuming the lock is uncontended, this never enters
@@ -54,18 +43,18 @@
 	 */
 	preempt_disable();
 #ifdef CONFIG_SMP
-	while (test_and_set_bit(PG_chainlock, &page->flags)) {
-		while (test_bit(PG_chainlock, &page->flags))
+	while (test_and_set_bit(PG_rmaplock, &page->flags)) {
+		while (test_bit(PG_rmaplock, &page->flags))
 			cpu_relax();
 	}
 #endif
 }
 
-static inline void pte_chain_unlock(struct page *page)
+static inline void rmap_unlock(struct page *page)
 {
 #ifdef CONFIG_SMP
 	smp_mb__before_clear_bit();
-	clear_bit(PG_chainlock, &page->flags);
+	clear_bit(PG_rmaplock, &page->flags);
 #endif
 	preempt_enable();
 }
--- anobjrmap2/init/main.c	Wed Mar 19 11:05:16 2003
+++ anobjrmap3/init/main.c	Thu Mar 20 17:10:12 2003
@@ -82,7 +82,6 @@
 extern void buffer_init(void);
 extern void pidhash_init(void);
 extern void pidmap_init(void);
-extern void pte_chain_init(void);
 extern void radix_tree_init(void);
 extern void free_initmem(void);
 extern void populate_rootfs(void);
@@ -436,7 +435,6 @@
 	kmem_cache_sizes_init();
 	pidmap_init();
 	pgtable_cache_init();
-	pte_chain_init();
 	fork_init(num_physpages);
 	proc_caches_init();
 	security_scaffolding_startup();
--- anobjrmap2/mm/fremap.c	Thu Mar 20 17:10:01 2003
+++ anobjrmap3/mm/fremap.c	Thu Mar 20 17:10:12 2003
@@ -31,7 +31,7 @@
 			if (!PageReserved(page)) {
 				if (pte_dirty(pte))
 					set_page_dirty(page);
-				page_remove_rmap(page, ptep);
+				page_remove_rmap(page);
 				page_cache_release(page);
 				mm->rss--;
 			}
@@ -56,11 +56,6 @@
 	pte_t *pte, entry;
 	pgd_t *pgd;
 	pmd_t *pmd;
-	struct pte_chain *pte_chain;
-
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain)
-		goto err;
 
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
@@ -80,19 +75,14 @@
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, prot);
 	set_pte(pte, entry);
-	pte_chain = page_add_rmap(page, pte, pte_chain);
+	page_add_rmap(page, 0);
 	pte_unmap(pte);
 	if (flush)
 		flush_tlb_page(vma, addr);
 
-	spin_unlock(&mm->page_table_lock);
-	pte_chain_free(pte_chain);
-	return 0;
-
+	err = 0;
 err_unlock:
 	spin_unlock(&mm->page_table_lock);
-	pte_chain_free(pte_chain);
-err:
 	return err;
 }
 
--- anobjrmap2/mm/memory.c	Thu Mar 20 17:10:01 2003
+++ anobjrmap3/mm/memory.c	Thu Mar 20 17:10:12 2003
@@ -47,7 +47,6 @@
 #include <linux/rmap.h>
 
 #include <asm/pgalloc.h>
-#include <asm/rmap.h>
 #include <asm/uaccess.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
@@ -95,7 +94,7 @@
 	}
 	page = pmd_page(*dir);
 	pmd_clear(dir);
-	pgtable_remove_rmap(page);
+	dec_page_state(nr_page_table_pages);
 	pte_free_tlb(tlb, page);
 }
 
@@ -166,7 +165,7 @@
 			pte_free(new);
 			goto out;
 		}
-		pgtable_add_rmap(new, mm, address);
+		inc_page_state(nr_page_table_pages);
 		pmd_populate(mm, pmd, new);
 	}
 out:
@@ -192,7 +191,7 @@
 			pte_free_kernel(new);
 			goto out;
 		}
-		pgtable_add_rmap(virt_to_page(new), mm, address);
+		inc_page_state(nr_page_table_pages);
 		pmd_populate_kernel(mm, pmd, new);
 	}
 out:
@@ -219,20 +218,10 @@
 	unsigned long address = vma->vm_start;
 	unsigned long end = vma->vm_end;
 	unsigned long cow;
-	struct pte_chain *pte_chain = NULL;
 
 	if (is_vm_hugetlb_page(vma))
 		return copy_hugetlb_page_range(dst, src, vma);
 
-	pte_chain = pte_chain_alloc(GFP_ATOMIC);
-	if (!pte_chain) {
-		spin_unlock(&dst->page_table_lock);
-		pte_chain = pte_chain_alloc(GFP_KERNEL);
-		spin_lock(&dst->page_table_lock);
-		if (!pte_chain)
-			goto nomem;
-	}
-	
 	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 	src_pgd = pgd_offset(src, address)-1;
 	dst_pgd = pgd_offset(dst, address)-1;
@@ -295,8 +284,7 @@
 				if (!pte_present(pte)) {
 					if (!pte_file(pte))
 						swap_duplicate(pte_to_swp_entry(pte));
-					set_pte(dst_pte, pte);
-					goto cont_copy_pte_range_noset;
+					goto cont_copy_pte_range;
 				}
 				pfn = pte_pfn(pte);
 				/* the pte points outside of valid memory, the
@@ -304,10 +292,8 @@
 				 * and not mapped via rmap - duplicate the
 				 * mapping as is.
 				 */
-				if (!pfn_valid(pfn)) {
-					set_pte(dst_pte, pte);
-					goto cont_copy_pte_range_noset;
-				}
+				if (!pfn_valid(pfn))
+					goto cont_copy_pte_range;
 				page = pfn_to_page(pfn);
 				if (PageReserved(page))
 					goto cont_copy_pte_range;
@@ -330,33 +316,9 @@
 				pte = pte_mkold(pte);
 				get_page(page);
 				dst->rss++;
-
+				page_dup_rmap(page);
 cont_copy_pte_range:
 				set_pte(dst_pte, pte);
-				pte_chain = page_add_rmap(page, dst_pte,
-							pte_chain);
-				if (pte_chain)
-					goto cont_copy_pte_range_noset;
-				pte_chain = pte_chain_alloc(GFP_ATOMIC);
-				if (pte_chain)
-					goto cont_copy_pte_range_noset;
-
-				/*
-				 * pte_chain allocation failed, and we need to
-				 * run page reclaim.
-				 */
-				pte_unmap_nested(src_pte);
-				pte_unmap(dst_pte);
-				spin_unlock(&src->page_table_lock);	
-				spin_unlock(&dst->page_table_lock);	
-				pte_chain = pte_chain_alloc(GFP_KERNEL);
-				spin_lock(&dst->page_table_lock);	
-				if (!pte_chain)
-					goto nomem;
-				spin_lock(&src->page_table_lock);
-				dst_pte = pte_offset_map(dst_pmd, address);
-				src_pte = pte_offset_map_nested(src_pmd,
-								address);
 cont_copy_pte_range_noset:
 				address += PAGE_SIZE;
 				if (address >= end) {
@@ -379,10 +341,8 @@
 out_unlock:
 	spin_unlock(&src->page_table_lock);
 out:
-	pte_chain_free(pte_chain);
 	return 0;
 nomem:
-	pte_chain_free(pte_chain);
 	return -ENOMEM;
 }
 
@@ -423,7 +383,7 @@
 							page_mapping(page))
 						mark_page_accessed(page);
 					tlb->freed++;
-					page_remove_rmap(page, ptep);
+					page_remove_rmap(page);
 					tlb_remove_page(tlb, page);
 				}
 			}
@@ -958,7 +918,6 @@
 {
 	struct page *old_page, *new_page;
 	unsigned long pfn = pte_pfn(pte);
-	struct pte_chain *pte_chain = NULL;
 	int ret;
 
 	if (unlikely(!pfn_valid(pfn))) {
@@ -994,9 +953,6 @@
 	page_cache_get(old_page);
 	spin_unlock(&mm->page_table_lock);
 
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain)
-		goto no_mem;
 	new_page = alloc_page(GFP_HIGHUSER);
 	if (!new_page)
 		goto no_mem;
@@ -1010,10 +966,10 @@
 	if (pte_same(*page_table, pte)) {
 		if (PageReserved(old_page))
 			++mm->rss;
-		page_remove_rmap(old_page, page_table);
+		else
+			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
-		SetPageAnon(new_page);
-		pte_chain = page_add_rmap(new_page, page_table, pte_chain);
+		page_add_rmap(new_page, 1);
 		lru_cache_add_active(new_page);
 
 		/* Free the old page.. */
@@ -1023,16 +979,14 @@
 	page_cache_release(new_page);
 	page_cache_release(old_page);
 	ret = VM_FAULT_MINOR;
-	goto out;
-
+out:
+	spin_unlock(&mm->page_table_lock);
+	return ret;
 no_mem:
 	page_cache_release(old_page);
 oom:
 	ret = VM_FAULT_OOM;
-out:
-	spin_unlock(&mm->page_table_lock);
-	pte_chain_free(pte_chain);
-	return ret;
+	goto out;
 }
 
 static void vmtruncate_list(struct list_head *head, unsigned long pgoff)
@@ -1155,7 +1109,6 @@
 	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 	pte_t pte;
 	int ret = VM_FAULT_MINOR;
-	struct pte_chain *pte_chain = NULL;
 
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
@@ -1185,11 +1138,6 @@
 	}
 
 	mark_page_accessed(page);
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain) {
-		ret = -ENOMEM;
-		goto out;
-	}
 	lock_page(page);
 
 	/*
@@ -1222,15 +1170,13 @@
 	flush_page_to_ram(page);
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
-	SetPageAnon(page);
-	pte_chain = page_add_rmap(page, page_table, pte_chain);
+	page_add_rmap(page, 1);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 out:
-	pte_chain_free(pte_chain);
 	return ret;
 }
 
@@ -1246,20 +1192,8 @@
 {
 	pte_t entry;
 	struct page * page = ZERO_PAGE(addr);
-	struct pte_chain *pte_chain;
 	int ret;
 
-	pte_chain = pte_chain_alloc(GFP_ATOMIC);
-	if (!pte_chain) {
-		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);
-		pte_chain = pte_chain_alloc(GFP_KERNEL);
-		if (!pte_chain)
-			goto no_mem;
-		spin_lock(&mm->page_table_lock);
-		page_table = pte_offset_map(pmd, addr);
-	}
-		
 	/* Read-only mapping of ZERO_PAGE. */
 	entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
 
@@ -1289,25 +1223,22 @@
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 		lru_cache_add_active(page);
 		mark_page_accessed(page);
-		SetPageAnon(page);
 	}
 
 	set_pte(page_table, entry);
 	/* ignores ZERO_PAGE */
-	pte_chain = page_add_rmap(page, page_table, pte_chain);
+	page_add_rmap(page, 1);
 	pte_unmap(page_table);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, addr, entry);
 	spin_unlock(&mm->page_table_lock);
 	ret = VM_FAULT_MINOR;
-	goto out;
-
-no_mem:
-	ret = VM_FAULT_OOM;
 out:
-	pte_chain_free(pte_chain);
 	return ret;
+no_mem:
+	ret = VM_FAULT_OOM;
+	goto out;
 }
 
 /*
@@ -1328,7 +1259,6 @@
 {
 	struct page * new_page;
 	pte_t entry;
-	struct pte_chain *pte_chain;
 	int anon = 0;
 	int ret;
 
@@ -1346,19 +1276,13 @@
 	if (new_page == NOPAGE_OOM)
 		return VM_FAULT_OOM;
 
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain)
-		goto oom;
-
 	/*
 	 * Should we do an early C-O-W break?
 	 */
 	if (write_access && !(vma->vm_flags & VM_SHARED)) {
 		struct page * page = alloc_page(GFP_HIGHUSER);
-		if (!page) {
-			page_cache_release(new_page);
+		if (!page)
 			goto oom;
-		}
 		copy_user_highpage(page, new_page, address);
 		page_cache_release(new_page);
 		lru_cache_add_active(page);
@@ -1388,9 +1312,7 @@
 		if (write_access)
 			entry = pte_mkwrite(pte_mkdirty(entry));
 		set_pte(page_table, entry);
-		if (anon)
-			SetPageAnon(new_page);
-		pte_chain = page_add_rmap(new_page, page_table, pte_chain);
+		page_add_rmap(new_page, anon);
 		pte_unmap(page_table);
 	} else {
 		/* One of our sibling threads was faster, back out. */
@@ -1405,12 +1327,12 @@
 	update_mmu_cache(vma, address, entry);
 	spin_unlock(&mm->page_table_lock);
 	ret = VM_FAULT_MAJOR;
-	goto out;
-oom:
-	ret = VM_FAULT_OOM;
 out:
-	pte_chain_free(pte_chain);
 	return ret;
+oom:
+	page_cache_release(new_page);
+	ret = VM_FAULT_OOM;
+	goto out;
 }
 
 /*
--- anobjrmap2/mm/mremap.c	Thu Mar 20 17:09:50 2003
+++ anobjrmap3/mm/mremap.c	Thu Mar 20 17:10:12 2003
@@ -83,30 +83,25 @@
 }
 
 static int
-copy_one_pte(struct mm_struct *mm, pte_t *src, pte_t *dst,
-		struct pte_chain **pte_chainp)
+copy_one_pte(struct mm_struct *mm, pte_t *src, pte_t *dst)
 {
-	int error = 0;
 	pte_t pte;
 	struct page *page = NULL;
 
-	if (pte_present(*src))
-		page = pte_page(*src);
-
 	if (!pte_none(*src)) {
-		if (page)
-			page_remove_rmap(page, src);
+		if (!dst)
+			return -1;
+		if (pte_present(*src))
+			page = pte_page(*src);
 		pte = ptep_get_and_clear(src);
-		if (!dst) {
-			/* No dest?  We must put it back. */
-			dst = src;
-			error++;
-		}
 		set_pte(dst, pte);
-		if (page)
-			*pte_chainp = page_add_rmap(page, dst, *pte_chainp);
+		if (page) {
+			int anon = PageAnon(page);
+			page_remove_rmap(page);
+			page_add_rmap(page, anon);
+		}
 	}
-	return error;
+	return 0;
 }
 
 static int
@@ -116,13 +111,7 @@
 	struct mm_struct *mm = vma->vm_mm;
 	int error = 0;
 	pte_t *src, *dst;
-	struct pte_chain *pte_chain;
 
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain) {
-		error = -ENOMEM;
-		goto out;
-	}
 	spin_lock(&mm->page_table_lock);
 	src = get_one_pte_map_nested(mm, old_addr);
 	if (src) {
@@ -138,14 +127,12 @@
 		dst = alloc_one_pte_map(mm, new_addr);
 		if (src == NULL)
 			src = get_one_pte_map_nested(mm, old_addr);
-		error = copy_one_pte(mm, src, dst, &pte_chain);
+		error = copy_one_pte(mm, src, dst);
 		pte_unmap_nested(src);
 		pte_unmap(dst);
 	}
 	flush_tlb_page(vma, old_addr);
 	spin_unlock(&mm->page_table_lock);
-	pte_chain_free(pte_chain);
-out:
 	return error;
 }
 
--- anobjrmap2/mm/nommu.c	Wed Mar 19 11:05:16 2003
+++ anobjrmap3/mm/nommu.c	Thu Mar 20 17:10:12 2003
@@ -567,7 +567,3 @@
 {
 	return -ENOMEM;
 }
-
-void pte_chain_init(void)
-{
-}
--- anobjrmap2/mm/page_alloc.c	Thu Mar 20 17:10:01 2003
+++ anobjrmap3/mm/page_alloc.c	Thu Mar 20 17:10:12 2003
@@ -80,8 +80,7 @@
 			1 << PG_lru	|
 			1 << PG_active	|
 			1 << PG_dirty	|
-			1 << PG_chainlock |
-			1 << PG_direct    |
+			1 << PG_rmaplock  |
 			1 << PG_anon      |
 			1 << PG_swapcache |
 			1 << PG_writeback);
@@ -220,8 +219,7 @@
 			1 << PG_locked	|
 			1 << PG_active	|
 			1 << PG_reclaim	|
-			1 << PG_chainlock |
-			1 << PG_direct    |
+			1 << PG_rmaplock  |
 			1 << PG_anon      |
 			1 << PG_swapcache |
 			1 << PG_writeback )))
@@ -328,8 +326,7 @@
 			1 << PG_active	|
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
-			1 << PG_chainlock |
-			1 << PG_direct    |
+			1 << PG_rmaplock  |
 			1 << PG_anon      |
 			1 << PG_swapcache |
 			1 << PG_writeback )))
@@ -1454,7 +1451,6 @@
 	"nr_pagecache",
 	"nr_swapcache",
 	"nr_page_table_pages",
-	"nr_reverse_maps",
 	"nr_mapped",
 	"nr_slab",
 
--- anobjrmap2/mm/rmap.c	Thu Mar 20 17:10:01 2003
+++ anobjrmap3/mm/rmap.c	Thu Mar 20 17:10:12 2003
@@ -4,37 +4,30 @@
  * Copyright 2001, Rik van Riel <riel@conectiva.com.br>
  * Released under the General Public License (GPL).
  *
- *
- * Simple, low overhead pte-based reverse mapping scheme.
- * This is kept modular because we may want to experiment
- * with object-based reverse mapping schemes. Please try
- * to keep this thing as modular as possible.
+ * Simple, low overhead reverse mapping scheme.
+ * Please try to keep this thing as modular as possible.
  */
 
 /*
  * Locking:
- * - the page->pte.chain is protected by the PG_chainlock bit,
- *   which nests within the zone->lru_lock, then the
- *   mm->page_table_lock, and then the page lock.
+ * - the page->rmap field is protected by the PG_rmaplock bit,
+ *   which nests within the mm->page_table_lock,
+ *   which nests within the page lock.
  * - because swapout locking is opposite to the locking order
  *   in the page fault path, the swapout path uses trylocks
  *   on the mm->page_table_lock
  */
+
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/swapops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/rmap.h>
-#include <linux/cache.h>
 #include <linux/percpu.h>
-
-#include <asm/pgalloc.h>
-#include <asm/rmap.h>
-#include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-/* #define DEBUG_RMAP */
+#define page_mapcount(page)	((page)->rmap_count)
 
 /*
  * Something oopsable to put for now in the page->mapping
@@ -50,61 +43,13 @@
 	ClearPageAnon(page);
 }
 
-/*
- * Shared pages have a chain of pte_chain structures, used to locate
- * all the mappings to this page. We only need a pointer to the pte
- * here, the page struct for the page table page contains the process
- * it belongs to and the offset within that process.
- *
- * We use an array of pte pointers in this structure to minimise cache misses
- * while traversing reverse maps.
- */
-#define NRPTE ((L1_CACHE_BYTES - sizeof(void *))/sizeof(pte_addr_t))
-
-struct pte_chain {
-	struct pte_chain *next;
-	pte_addr_t ptes[NRPTE];
-} ____cacheline_aligned;
-
-kmem_cache_t	*pte_chain_cache;
-
-/*
- * pte_chain list management policy:
- *
- * - If a page has a pte_chain list then it is shared by at least two processes,
- *   because a single sharing uses PageDirect. (Well, this isn't true yet,
- *   coz this code doesn't collapse singletons back to PageDirect on the remove
- *   path).
- * - A pte_chain list has free space only in the head member - all succeeding
- *   members are 100% full.
- * - If the head element has free space, it occurs in its leading slots.
- * - All free space in the pte_chain is at the start of the head member.
- * - Insertion into the pte_chain puts a pte pointer in the last free slot of
- *   the head member.
- * - Removal from a pte chain moves the head pte of the head member onto the
- *   victim pte and frees the head member if it became empty.
- */
-
 /**
- ** VM stuff below this comment
+ ** Subfunctions of page_referenced: page_referenced_one called
+ ** repeatedly from page_referenced_obj.
  **/
 
-/**
- * find_pte - Find a pte pointer given a vma and a struct page.
- * @vma: the vma to search
- * @page: the page to find
- *
- * Determine if this page is mapped in this vma.  If it is, map and rethrn
- * the pte pointer associated with it.  Return null if the page is not
- * mapped in this vma for any reason.
- *
- * This is strictly an internal helper function for the object-based rmap
- * functions.
- * 
- * It is the caller's responsibility to unmap the pte if it is returned.
- */
-static inline pte_t *
-find_pte(struct vm_area_struct *vma, struct page *page, unsigned long *addr)
+static int
+page_referenced_one(struct page *page, struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
@@ -112,6 +57,7 @@
 	pte_t *pte;
 	unsigned long loffset;
 	unsigned long address;
+	int referenced = 0;
 
 	loffset = (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
 	if (loffset < vma->vm_pgoff)
@@ -122,13 +68,18 @@
 	if (address >= vma->vm_end)
 		goto out;
 
+	if (!spin_trylock(&mm->page_table_lock)) {
+		referenced = 1;
+		goto out;
+	}
+
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
-		goto out;
+		goto out_unlock;
 
 	pmd = pmd_offset(pgd, address);
 	if (!pmd_present(*pmd))
-		goto out;
+		goto out_unlock;
 
 	pte = pte_offset_map(pmd, address);
 	if (!pte_present(*pte))
@@ -137,84 +88,36 @@
 	if (page_to_pfn(page) != pte_pfn(*pte))
 		goto out_unmap;
 
-	if (addr)
-		*addr = address;
-
-	return pte;
+	if (ptep_test_and_clear_young(pte))
+		referenced++;
 
 out_unmap:
 	pte_unmap(pte);
-out:
-	return NULL;
-}
-
-/**
- * page_referenced_obj_one - referenced check for object-based rmap
- * @vma: the vma to look in.
- * @page: the page we're working on.
- *
- * Find a pte entry for a page/vma pair, then check and clear the referenced
- * bit.
- *
- * This is strictly a helper function for page_referenced_obj.
- */
-static int
-page_referenced_obj_one(struct vm_area_struct *vma, struct page *page)
-{
-	pte_t *pte;
-	int referenced = 0;
 
-	pte = find_pte(vma, page, NULL);
-	if (pte) {
-		if (ptep_test_and_clear_young(pte))
-			referenced++;
-		pte_unmap(pte);
-	}
+out_unlock:
+	spin_unlock(&mm->page_table_lock);
 
+out:
 	return referenced;
 }
 
-/**
- * page_referenced_obj_one - referenced check for object-based rmap
- * @page: the page we're checking references on.
- *
- * For an object-based mapped page, find all the places it is mapped and
- * check/clear the referenced flag.  This is done by following the page->mapping
- * pointer, then walking the chain of vmas it holds.  It returns the number
- * of references it found.
- *
- * This function is only called from page_referenced for object-based pages.
- *
- * The semaphore address_space->i_shared_sem is tried.  If it can't be gotten,
- * assume a reference count of 1.
- */
-static int
+static inline int
 page_referenced_obj(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct vm_area_struct *vma;
 	int referenced = 0;
 
-	if (!page->pte.mapcount)
-		return 0;
-
-	if (!mapping)
-		return 0;
-
-	if (PageSwapCache(page))
-		BUG();
-
 	if (down_trylock(&mapping->i_shared_sem))
 		return 1;
-	
+
 	list_for_each_entry(vma, &mapping->i_mmap, shared)
-		referenced += page_referenced_obj_one(vma, page);
+		referenced += page_referenced_one(page, vma);
 
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared)
-		referenced += page_referenced_obj_one(vma, page);
+		referenced += page_referenced_one(page, vma);
 
 	up(&mapping->i_shared_sem);
-
 	return referenced;
 }
 
@@ -223,423 +126,169 @@
  * @page: the page to test
  *
  * Quick test_and_clear_referenced for all mappings to a page,
- * returns the number of processes which referenced the page.
- * Caller needs to hold the pte_chain_lock.
- *
- * If the page has a single-entry pte_chain, collapse that back to a PageDirect
- * representation.  This way, it's only done under memory pressure.
+ * returns the number of ptes which referenced the page.
+ * Caller needs to hold the rmap_lock.
  */
-int page_referenced(struct page * page)
+int
+page_referenced(struct page *page)
 {
-	struct pte_chain * pc;
-	int referenced = 0;
+	int referenced;
 
-	if (TestClearPageReferenced(page))
-		referenced++;
-
-	if (!PageAnon(page)) {
+	referenced = !!TestClearPageReferenced(page);
+	if (page_mapcount(page) && page->mapping && !PageAnon(page))
 		referenced += page_referenced_obj(page);
-		goto out;
-	}
-	if (PageDirect(page)) {
-		pte_t *pte = rmap_ptep_map(page->pte.direct);
-		if (ptep_test_and_clear_young(pte))
-			referenced++;
-		rmap_ptep_unmap(pte);
-	} else {
-		int nr_chains = 0;
-
-		/* Check all the page tables mapping this page. */
-		for (pc = page->pte.chain; pc; pc = pc->next) {
-			int i;
-
-			for (i = NRPTE-1; i >= 0; i--) {
-				pte_addr_t pte_paddr = pc->ptes[i];
-				pte_t *p;
-
-				if (!pte_paddr)
-					break;
-				p = rmap_ptep_map(pte_paddr);
-				if (ptep_test_and_clear_young(p))
-					referenced++;
-				rmap_ptep_unmap(p);
-				nr_chains++;
-			}
-		}
-		if (nr_chains == 1) {
-			pc = page->pte.chain;
-			page->pte.direct = pc->ptes[NRPTE-1];
-			SetPageDirect(page);
-			pc->ptes[NRPTE-1] = 0;
-			__pte_chain_free(pc);
-		}
-	}
-out:
 	return referenced;
 }
 
 /**
  * page_add_rmap - add reverse mapping entry to a page
- * @page: the page to add the mapping to
- * @ptep: the page table entry mapping this page
+ * @page:	the page to add the mapping to
+ * @anon:	is this an anonymous (not file-backed) page?
  *
- * Add a new pte reverse mapping to a page.
+ * For general use: Add a new reverse mapping to a page.
  * The caller needs to hold the mm->page_table_lock.
  */
-struct pte_chain *
-page_add_rmap(struct page *page, pte_t *ptep, struct pte_chain *pte_chain)
+void
+page_add_rmap(struct page *page, int anon)
 {
-	pte_addr_t pte_paddr = ptep_to_paddr(ptep);
-	struct pte_chain *cur_pte_chain;
-	int i;
-
-#ifdef DEBUG_RMAP
-	if (!page || !ptep)
-		BUG();
-	if (!pte_present(*ptep))
-		BUG();
-	if (!ptep_to_mm(ptep))
-		BUG();
-#endif
-
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
-		return pte_chain;
+		return;
 
-	pte_chain_lock(page);
+	rmap_lock(page);
 
-	/*
-	 * If this is an object-based page, just count it.  We can
-	 * find the mappings by walking the object vma chain for that object.
-	 */
-	if (!PageAnon(page)) {
-		if (PageSwapCache(page))
-			BUG();
-		if (!page->pte.mapcount)
-			inc_page_state(nr_mapped);
-		page->pte.mapcount++;
-		pte_chain_unlock(page);
-		return pte_chain;
-	}
+	if (!page_mapped(page))
+		inc_page_state(nr_mapped);
+	page_mapcount(page)++;
 
-#ifdef DEBUG_RMAP
-	/*
-	 * This stuff needs help to get up to highmem speed.
-	 */
-	{
-		struct pte_chain * pc;
-		if (PageDirect(page)) {
-			if (page->pte.direct == pte_paddr)
-				BUG();
+	if (page->mapping) {
+		if (anon) {
+			BUG_ON(!PageAnon(page));
 		} else {
-			for (pc = page->pte.chain; pc; pc = pc->next) {
-				for (i = 0; i < NRPTE; i++) {
-					pte_addr_t p = pc->ptes[i];
-
-					if (p && p == pte_paddr)
-						BUG();
-				}
-			}
+			BUG_ON(PageAnon(page));
+		}
+	} else {
+		if (anon) {
+			SetPageAnon(page);
+			page->mapping = ANON_MAPPING_DEBUG;
+		} else {
+			/*
+			 * Driver did not assign page->mapping,
+			 * nor did it set PageReserved.  That's
+			 * okay, it's as if vma were VM_LOCKED.
+			 */
 		}
-	}
-#endif
-
-	page->mapping = ANON_MAPPING_DEBUG;
-
-	if (page->pte.direct == 0) {
-		page->pte.direct = pte_paddr;
-		SetPageDirect(page);
-		inc_page_state(nr_mapped);
-		goto out;
-	}
-
-	if (PageDirect(page)) {
-		/* Convert a direct pointer into a pte_chain */
-		ClearPageDirect(page);
-		pte_chain->ptes[NRPTE-1] = page->pte.direct;
-		pte_chain->ptes[NRPTE-2] = pte_paddr;
-		page->pte.direct = 0;
-		page->pte.chain = pte_chain;
-		pte_chain = NULL;	/* We consumed it */
-		goto out;
-	}
-
-	cur_pte_chain = page->pte.chain;
-	if (cur_pte_chain->ptes[0]) {	/* It's full */
-		pte_chain->next = cur_pte_chain;
-		page->pte.chain = pte_chain;
-		pte_chain->ptes[NRPTE-1] = pte_paddr;
-		pte_chain = NULL;	/* We consumed it */
-		goto out;
 	}
 
-	BUG_ON(!cur_pte_chain->ptes[NRPTE-1]);
+	rmap_unlock(page);
+}
 
-	for (i = NRPTE-2; i >= 0; i--) {
-		if (!cur_pte_chain->ptes[i]) {
-			cur_pte_chain->ptes[i] = pte_paddr;
-			goto out;
-		}
-	}
-	BUG();
-out:
-	pte_chain_unlock(page);
-	inc_page_state(nr_reverse_maps);
-	return pte_chain;
+/**
+ * page_dup_rmap - duplicate reverse mapping entry to a page
+ * @page:	the page to add the mapping to
+ *
+ * For copy_page_range only: minimal extract from page_add_rmap,
+ * avoiding unnecessary tests (already checked) so it's quicker.
+ */
+void
+page_dup_rmap(struct page *page)
+{
+	rmap_lock(page);
+	page_mapcount(page)++;
+	rmap_unlock(page);
 }
 
 /**
  * page_remove_rmap - take down reverse mapping to a page
  * @page: page to remove mapping from
- * @ptep: page table entry to remove
  *
- * Removes the reverse mapping from the pte_chain of the page,
+ * For general use: Remove the reverse mapping from the page,
  * after that the caller can clear the page table entry and free
- * the page.
- * Caller needs to hold the mm->page_table_lock.
+ * the page.  Caller needs to hold the mm->page_table_lock.
  */
-void page_remove_rmap(struct page * page, pte_t * ptep)
+void
+page_remove_rmap(struct page *page)
 {
-	pte_addr_t pte_paddr = ptep_to_paddr(ptep);
-	struct pte_chain *pc;
-
-	if (!page || !ptep)
-		BUG();
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
 		return;
 
-	pte_chain_lock(page);
-
-	/*
-	 * If this is an object-based page, just uncount it.  We can
-	 * find the mappings by walking the object vma chain for that object.
-	 */
-	if (!PageAnon(page)) {
-		if (PageSwapCache(page))
-			BUG();
-		if (!page->pte.mapcount)
-			BUG();
-		page->pte.mapcount--;
-		if (!page->pte.mapcount)
-			dec_page_state(nr_mapped);
-		pte_chain_unlock(page);
-		return;
-	}
-
-	if (PageDirect(page)) {
-		if (page->pte.direct == pte_paddr) {
-			page->pte.direct = 0;
-			dec_page_state(nr_reverse_maps);
-			ClearPageDirect(page);
-			goto out;
-		}
-	} else {
-		struct pte_chain *start = page->pte.chain;
-		int victim_i = -1;
-
-		for (pc = start; pc; pc = pc->next) {
-			int i;
+	rmap_lock(page);
 
-			if (pc->next)
-				prefetch(pc->next);
-			for (i = 0; i < NRPTE; i++) {
-				pte_addr_t pa = pc->ptes[i];
-
-				if (!pa)
-					continue;
-				if (victim_i == -1)
-					victim_i = i;
-				if (pa != pte_paddr)
-					continue;
-				pc->ptes[i] = start->ptes[victim_i];
-				dec_page_state(nr_reverse_maps);
-				start->ptes[victim_i] = 0;
-				if (victim_i == NRPTE-1) {
-					/* Emptied a pte_chain */
-					page->pte.chain = start->next;
-					__pte_chain_free(start);
-				} else {
-					/* Do singleton->PageDirect here */
-				}
-				goto out;
-			}
-		}
-	}
-#ifdef DEBUG_RMAP
-	/* Not found. This should NEVER happen! */
-	printk(KERN_ERR "page_remove_rmap: pte_chain %p not present.\n", ptep);
-	printk(KERN_ERR "page_remove_rmap: only found: ");
-	if (PageDirect(page)) {
-		printk("%llx", (u64)page->pte.direct);
-	} else {
-		for (pc = page->pte.chain; pc; pc = pc->next) {
-			int i;
-			for (i = 0; i < NRPTE; i++)
-				printk(" %d:%llx", i, (u64)pc->ptes[i]);
-		}
-	}
-	printk("\n");
-	printk(KERN_ERR "page_remove_rmap: driver cleared PG_reserved ?\n");
-#endif
+	BUG_ON(!page_mapcount(page));
+	page_mapcount(page)--;
 
-out:
 	if (!page_mapped(page)) {
 		dec_page_state(nr_mapped);
-		clear_page_anon(page);
+		if (PageAnon(page))
+			clear_page_anon(page);
 	}
-	pte_chain_unlock(page);
+
+	rmap_unlock(page);
 }
 
 /**
- * try_to_unmap_obj - unmap a page using the object-based rmap method
- * @page: the page to unmap
- *
- * Determine whether a page is mapped in a given vma and unmap it if it's found.
- *
- * This function is strictly a helper function for try_to_unmap_obj.
- */
-static inline int
-try_to_unmap_obj_one(struct vm_area_struct *vma, struct page *page)
+ ** Subfunctions of try_to_unmap: try_to_unmap_one called
+ ** repeatedly from try_to_unmap_obj.
+ **/
+
+static int
+try_to_unmap_one(struct page *page, struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long address;
+	pgd_t *pgd;
+	pmd_t *pmd;
 	pte_t *pte;
 	pte_t pteval;
-	int ret = SWAP_SUCCESS;
+	unsigned long loffset;
+	unsigned long address;
+	int ret = SWAP_AGAIN;
 
-	pte = find_pte(vma, page, &address);
-	if (!pte)
+	loffset = (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
+	if (loffset < vma->vm_pgoff)
 		goto out;
 
-	if (vma->vm_flags & VM_LOCKED) {
-		ret =  SWAP_FAIL;
-		goto out_unmap;
-	}
-
-	flush_cache_page(vma, address);
-	pteval = ptep_get_and_clear(pte);
-	flush_tlb_page(vma, address);
-
-	if (pte_dirty(pteval))
-		set_page_dirty(page);
-
-	if (!page->pte.mapcount)
-		BUG();
-
-	mm->rss--;
-	page->pte.mapcount--;
-	page_cache_release(page);
-
-out_unmap:
-	pte_unmap(pte);
-
-out:
-	return ret;
-}
-
-/**
- * try_to_unmap_obj - unmap a page using the object-based rmap method
- * @page: the page to unmap
- *
- * Find all the mappings of a page using the mapping pointer and the vma chains
- * contained in the address_space struct it points to.
- *
- * This function is only called from try_to_unmap for object-based pages.
- *
- * The semaphore address_space->i_shared_sem is tried.  If it can't be gotten,
- * return a temporary error.
- */
-static int
-try_to_unmap_obj(struct page *page)
-{
-	struct address_space *mapping = page->mapping;
-	struct vm_area_struct *vma;
-	int ret = SWAP_SUCCESS;
-
-	if (!mapping)
-		BUG();
-
-	if (PageSwapCache(page))
-		BUG();
-
-	if (down_trylock(&mapping->i_shared_sem))
-		return SWAP_AGAIN;
-	
-	list_for_each_entry(vma, &mapping->i_mmap, shared) {
-		ret = try_to_unmap_obj_one(vma, page);
-		if (ret != SWAP_SUCCESS)
-			goto out;
-	}
-
-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
-		ret = try_to_unmap_obj_one(vma, page);
-		if (ret != SWAP_SUCCESS)
-			goto out;
-	}
-
-	/* We lose track of sys_remap_file pages (for now) */
-	if (page->pte.mapcount)
-		ret = SWAP_FAIL;
-
-out:
-	up(&mapping->i_shared_sem);
-	return ret;
-}
-
-/**
- * try_to_unmap_one - worker function for try_to_unmap
- * @page: page to unmap
- * @ptep: page table entry to unmap from page
- *
- * Internal helper function for try_to_unmap, called for each page
- * table entry mapping a page. Because locking order here is opposite
- * to the locking order used by the page fault path, we use trylocks.
- * Locking:
- *	zone->lru_lock			page_launder()
- *	    page lock			page_launder(), trylock
- *		pte_chain_lock		page_launder()
- *		    mm->page_table_lock	try_to_unmap_one(), trylock
- */
-static int FASTCALL(try_to_unmap_one(struct page *, pte_addr_t));
-static int try_to_unmap_one(struct page * page, pte_addr_t paddr)
-{
-	pte_t *ptep = rmap_ptep_map(paddr);
-	unsigned long address = ptep_to_address(ptep);
-	struct mm_struct * mm = ptep_to_mm(ptep);
-	struct vm_area_struct * vma;
-	pte_t pte;
-	int ret;
+	address = vma->vm_start + ((loffset - vma->vm_pgoff) << PAGE_SHIFT);
 
-	if (!mm)
-		BUG();
+	if (address >= vma->vm_end)
+		goto out;
 
 	/*
 	 * We need the page_table_lock to protect us from page faults,
 	 * munmap, fork, etc...
 	 */
-	if (!spin_trylock(&mm->page_table_lock)) {
-		rmap_ptep_unmap(ptep);
-		return SWAP_AGAIN;
-	}
+	if (!spin_trylock(&mm->page_table_lock))
+		goto out;
 
+	pgd = pgd_offset(mm, address);
+	if (!pgd_present(*pgd))
+		goto out_unlock;
 
-	/* During mremap, it's possible pages are not in a VMA. */
-	vma = find_vma(mm, address);
-	if (!vma) {
-		ret = SWAP_FAIL;
+	pmd = pmd_offset(pgd, address);
+	if (!pmd_present(*pmd))
 		goto out_unlock;
-	}
 
-	/* The page is mlock()d, we cannot swap it out. */
+	pte = pte_offset_map(pmd, address);
+	if (!pte_present(*pte))
+		goto out_unmap;
+
+	if (page_to_pfn(page) != pte_pfn(*pte))
+		goto out_unmap;
+
+	/* If the page is mlock()d, we cannot swap it out. */
 	if (vma->vm_flags & VM_LOCKED) {
-		ret = SWAP_FAIL;
-		goto out_unlock;
+		ret =  SWAP_FAIL;
+		goto out_unmap;
 	}
 
 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address);
-	pte = ptep_get_and_clear(ptep);
+	pteval = ptep_get_and_clear(pte);
 	flush_tlb_page(vma, address);
 
+	/*
+	 * This block makes no sense in this subpatch: neither anon
+	 * pages nor nonlinear pages get here.  But we want to hold on
+	 * to this code, to use in later patches which correct that.
+	 */
 	if (PageAnon(page)) {
 		swp_entry_t entry = { .val = page->private };
 		/*
@@ -648,34 +297,66 @@
 		 */
 		BUG_ON(!PageSwapCache(page));
 		swap_duplicate(entry);
-		set_pte(ptep, swp_entry_to_pte(entry));
-		BUG_ON(pte_file(*ptep));
+		set_pte(pte, swp_entry_to_pte(entry));
+		BUG_ON(pte_file(*pte));
 	} else {
 		unsigned long pgidx;
 		/*
-		 * If a nonlinear mapping then store the file page offset
-		 * in the pte.
+		 * If a nonlinear mapping from sys_remap_file_pages,
+		 * then store the file page offset in the pte.
 		 */
 		pgidx = (address - vma->vm_start) >> PAGE_SHIFT;
 		pgidx += vma->vm_pgoff;
 		pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
-		if (1 || page->index != pgidx) {
-			set_pte(ptep, pgoff_to_pte(page->index));
-			BUG_ON(!pte_file(*ptep));
+		if (page->index != pgidx) {
+			set_pte(pte, pgoff_to_pte(page->index));
+			BUG_ON(!pte_file(*pte));
 		}
 	}
 
 	/* Move the dirty bit to the physical page now the pte is gone. */
-	if (pte_dirty(pte))
+	if (pte_dirty(pteval))
 		set_page_dirty(page);
 
 	mm->rss--;
+	BUG_ON(!page_mapcount(page));
+	page_mapcount(page)--;
 	page_cache_release(page);
-	ret = SWAP_SUCCESS;
+
+out_unmap:
+	pte_unmap(pte);
 
 out_unlock:
-	rmap_ptep_unmap(ptep);
 	spin_unlock(&mm->page_table_lock);
+
+out:
+	return ret;
+}
+
+static inline int
+try_to_unmap_obj(struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+	struct vm_area_struct *vma;
+	int ret = SWAP_AGAIN;
+
+	if (down_trylock(&mapping->i_shared_sem))
+		return ret;
+
+	list_for_each_entry(vma, &mapping->i_mmap, shared) {
+		ret = try_to_unmap_one(page, vma);
+		if (ret == SWAP_FAIL)
+			goto out;
+	}
+
+	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+		ret = try_to_unmap_one(page, vma);
+		if (ret == SWAP_FAIL)
+			goto out;
+	}
+
+out:
+	up(&mapping->i_shared_sem);
 	return ret;
 }
 
@@ -684,173 +365,30 @@
  * @page: the page to get unmapped
  *
  * Tries to remove all the page table entries which are mapping this
- * page, used in the pageout path.  Caller must hold zone->lru_lock
- * and the page lock.  Return values are:
+ * page, used in the pageout path.  Caller must hold the page lock
+ * and its rmap_lock.  Return values are:
  *
  * SWAP_SUCCESS	- we succeeded in removing all mappings
  * SWAP_AGAIN	- we missed a trylock, try again later
  * SWAP_FAIL	- the page is unswappable
  */
-int try_to_unmap(struct page * page)
+int
+try_to_unmap(struct page *page)
 {
-	struct pte_chain *pc, *next_pc, *start;
-	int ret = SWAP_SUCCESS;
-	int victim_i = -1;
-
-	/* This page should not be on the pageout lists. */
-	if (PageReserved(page))
-		BUG();
-	if (!PageLocked(page))
-		BUG();
-	/* We need backing store to swap out a page. */
-	if (!page_mapping(page) && !PageSwapCache(page))
-		BUG();
+	int ret = SWAP_FAIL;
 
-	/*
-	 * If it's an object-based page, use the object vma chain to find all
-	 * the mappings.
-	 */
-	if (!PageAnon(page)) {
-		ret = try_to_unmap_obj(page);
-		goto out;
-	}
+	BUG_ON(PageReserved(page));
+	BUG_ON(!PageLocked(page));
+	BUG_ON(!page_mapped(page));
 
-	if (PageDirect(page)) {
-		ret = try_to_unmap_one(page, page->pte.direct);
-		if (ret == SWAP_SUCCESS) {
-			page->pte.direct = 0;
-			dec_page_state(nr_reverse_maps);
-			ClearPageDirect(page);
-		}
-		goto out;
-	}		
+	if (!PageAnon(page))
+		ret = try_to_unmap_obj(page);
 
-	start = page->pte.chain;
-	for (pc = start; pc; pc = next_pc) {
-		int i;
-
-		next_pc = pc->next;
-		if (next_pc)
-			prefetch(next_pc);
-		for (i = 0; i < NRPTE; i++) {
-			pte_addr_t pte_paddr = pc->ptes[i];
-
-			if (!pte_paddr)
-				continue;
-			if (victim_i == -1) 
-				victim_i = i;
-
-			switch (try_to_unmap_one(page, pte_paddr)) {
-			case SWAP_SUCCESS:
-				/*
-				 * Release a slot.  If we're releasing the
-				 * first pte in the first pte_chain then
-				 * pc->ptes[i] and start->ptes[victim_i] both
-				 * refer to the same thing.  It works out.
-				 */
-				pc->ptes[i] = start->ptes[victim_i];
-				start->ptes[victim_i] = 0;
-				dec_page_state(nr_reverse_maps);
-				victim_i++;
-				if (victim_i == NRPTE) {
-					page->pte.chain = start->next;
-					__pte_chain_free(start);
-					start = page->pte.chain;
-					victim_i = 0;
-				}
-				break;
-			case SWAP_AGAIN:
-				/* Skip this pte, remembering status. */
-				ret = SWAP_AGAIN;
-				continue;
-			case SWAP_FAIL:
-				ret = SWAP_FAIL;
-				goto out;
-			}
-		}
-	}
-out:
 	if (!page_mapped(page)) {
 		dec_page_state(nr_mapped);
 		if (PageAnon(page))
 			clear_page_anon(page);
+		ret = SWAP_SUCCESS;
 	}
 	return ret;
 }
-
-/**
- ** No more VM stuff below this comment, only pte_chain helper
- ** functions.
- **/
-
-static void pte_chain_ctor(void *p, kmem_cache_t *cachep, unsigned long flags)
-{
-	struct pte_chain *pc = p;
-
-	memset(pc, 0, sizeof(*pc));
-}
-
-DEFINE_PER_CPU(struct pte_chain *, local_pte_chain) = 0;
-
-/**
- * __pte_chain_free - free pte_chain structure
- * @pte_chain: pte_chain struct to free
- */
-void __pte_chain_free(struct pte_chain *pte_chain)
-{
-	int cpu = get_cpu();
-	struct pte_chain **pte_chainp;
-
-	if (pte_chain->next)
-		pte_chain->next = NULL;
-	pte_chainp = &per_cpu(local_pte_chain, cpu);
-	if (*pte_chainp)
-		kmem_cache_free(pte_chain_cache, *pte_chainp);
-	*pte_chainp = pte_chain;
-	put_cpu();
-}
-
-/*
- * pte_chain_alloc(): allocate a pte_chain structure for use by page_add_rmap().
- *
- * The caller of page_add_rmap() must perform the allocation because
- * page_add_rmap() is invariably called under spinlock.  Often, page_add_rmap()
- * will not actually use the pte_chain, because there is space available in one
- * of the existing pte_chains which are attached to the page.  So the case of
- * allocating and then freeing a single pte_chain is specially optimised here,
- * with a one-deep per-cpu cache.
- */
-struct pte_chain *pte_chain_alloc(int gfp_flags)
-{
-	int cpu;
-	struct pte_chain *ret;
-	struct pte_chain **pte_chainp;
-
-	if (gfp_flags & __GFP_WAIT)
-		might_sleep();
-
-	cpu = get_cpu();
-	pte_chainp = &per_cpu(local_pte_chain, cpu);
-	if (*pte_chainp) {
-		ret = *pte_chainp;
-		*pte_chainp = NULL;
-		put_cpu();
-	} else {
-		put_cpu();
-		ret = kmem_cache_alloc(pte_chain_cache, gfp_flags);
-	}
-	return ret;
-}
-
-void __init pte_chain_init(void)
-{
-	pte_chain_cache = kmem_cache_create(	"pte_chain",
-						sizeof(struct pte_chain),
-						0,
-						0,
-						pte_chain_ctor,
-						NULL);
-
-	if (!pte_chain_cache)
-		panic("failed to create pte_chain cache!\n");
-}
--- anobjrmap2/mm/swapfile.c	Thu Mar 20 17:10:02 2003
+++ anobjrmap3/mm/swapfile.c	Thu Mar 20 17:10:12 2003
@@ -386,7 +386,7 @@
 /* mmlist_lock and vma->vm_mm->page_table_lock are held */
 static void
 unuse_pte(struct vm_area_struct *vma, unsigned long address, pte_t *dir,
-	swp_entry_t entry, struct page *page, struct pte_chain **pte_chainp)
+	swp_entry_t entry, struct page *page)
 {
 	pte_t pte = *dir;
 
@@ -398,8 +398,7 @@
 		return;
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
-	SetPageAnon(page);
-	*pte_chainp = page_add_rmap(page, dir, *pte_chainp);
+	page_add_rmap(page, 1);
 	swap_free(entry);
 	++vma->vm_mm->rss;
 }
@@ -411,7 +410,6 @@
 {
 	pte_t * pte;
 	unsigned long end;
-	struct pte_chain *pte_chain = NULL;
 
 	if (pmd_none(*dir))
 		return;
@@ -427,18 +425,12 @@
 	if (end > PMD_SIZE)
 		end = PMD_SIZE;
 	do {
-		/*
-		 * FIXME: handle pte_chain_alloc() failures
-		 */
-		if (pte_chain == NULL)
-			pte_chain = pte_chain_alloc(GFP_ATOMIC);
 		unuse_pte(vma, offset+address-vma->vm_start,
-				pte, entry, page, &pte_chain);
+				pte, entry, page);
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
 	pte_unmap(pte - 1);
-	pte_chain_free(pte_chain);
 }
 
 /* mmlist_lock and vma->vm_mm->page_table_lock are held */
--- anobjrmap2/mm/vmscan.c	Thu Mar 20 17:10:02 2003
+++ anobjrmap3/mm/vmscan.c	Thu Mar 20 17:10:12 2003
@@ -173,7 +173,7 @@
 	return 0;
 }
 
-/* Must be called with page's pte_chain_lock held. */
+/* Must be called with page's rmap_lock held. */
 static inline int page_mapping_inuse(struct page *page)
 {
 	struct address_space *mapping;
@@ -254,10 +254,10 @@
 		if (PageWriteback(page))
 			goto keep_locked;
 
-		pte_chain_lock(page);
+		rmap_lock(page);
 		if (page_referenced(page) && page_mapping_inuse(page)) {
 			/* In active use or really unfreeable.  Activate it. */
-			pte_chain_unlock(page);
+			rmap_unlock(page);
 			goto activate_locked;
 		}
 
@@ -273,10 +273,10 @@
 		if (PageSwapCache(page))
 			mapping = &swapper_space;
 		else if (PageAnon(page)) {
-			pte_chain_unlock(page);
+			rmap_unlock(page);
 			if (!add_to_swap(page))
 				goto activate_locked;
-			pte_chain_lock(page);
+			rmap_lock(page);
 			mapping = &swapper_space;
 		}
 #endif /* CONFIG_SWAP */
@@ -288,16 +288,16 @@
 		if (page_mapped(page) && mapping) {
 			switch (try_to_unmap(page)) {
 			case SWAP_FAIL:
-				pte_chain_unlock(page);
+				rmap_unlock(page);
 				goto activate_locked;
 			case SWAP_AGAIN:
-				pte_chain_unlock(page);
+				rmap_unlock(page);
 				goto keep_locked;
 			case SWAP_SUCCESS:
 				; /* try to free the page below */
 			}
 		}
-		pte_chain_unlock(page);
+		rmap_unlock(page);
 
 		/*
 		 * If the page is dirty, only perform writeback if that write
@@ -629,13 +629,13 @@
 		page = list_entry(l_hold.prev, struct page, lru);
 		list_del(&page->lru);
 		if (page_mapped(page)) {
-			pte_chain_lock(page);
+			rmap_lock(page);
 			if (page_mapped(page) && page_referenced(page)) {
-				pte_chain_unlock(page);
+				rmap_unlock(page);
 				list_add(&page->lru, &l_active);
 				continue;
 			}
-			pte_chain_unlock(page);
+			rmap_unlock(page);
 			if (!reclaim_mapped) {
 				list_add(&page->lru, &l_active);
 				continue;

