Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUDOXda (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 19:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUDOXd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 19:33:29 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:43007 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261296AbUDOXcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 19:32:33 -0400
Date: Fri, 16 Apr 2004 00:32:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmap 9 remove pte_chains
Message-ID: <Pine.LNX.4.44.0404160030330.10431-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of today's batch of three rmap patches, based on 2.6.5-mm6.
I believe the only interaction with other patches of 2.6.5-mm6 is
with slab-panic.patch - this first rmap patch removes a SLAB_PANIC
cache creation, the next patch adds a SLAB_PANIC cache creation.

rmap 9 remove pte_chain rmap

Lots of deletions: the next patch will put in the new anon rmap, which
should look clearer if first we remove all of the old pte-pointer-based
rmap from the core in this patch - which therefore leaves anonymous rmap
totally disabled, anon pages locked in memory until process frees them.

Leave arch files (and page table rmap) untouched for now, clean them up
in a later batch.  A few constructive changes amidst all the deletions:

Choose names (e.g. page_add_anon_rmap) and args (e.g. no more pteps) now
so we need not revisit so many files in the next patch.  Inline function
page_dup_rmap for fork's copy_page_range, simply bumps mapcount under
lock.  cond_resched_lock in copy_page_range.  Struct page rearranged:
no pte union, just mapcount moved next to atomic count, so two ints can
occupy one long on 64-bit; i386 struct page now 32 bytes even with PAE.
Never pass PageReserved to page_remove_rmap, only do_wp_page did so.

 fs/exec.c                  |   31 --
 include/linux/mm.h         |   34 +--
 include/linux/page-flags.h |   12 -
 include/linux/rmap.h       |   26 +-
 init/main.c                |    2 
 mm/fremap.c                |    2 
 mm/memory.c                |  103 +--------
 mm/mremap.c                |   17 -
 mm/nommu.c                 |    4 
 mm/rmap.c                  |  488 +++++----------------------------------------
 mm/swapfile.c              |   26 --
 11 files changed, 128 insertions(+), 617 deletions(-)

--- 2.6.5-mm6/fs/exec.c	2004-04-15 09:01:57.728033520 +0100
+++ rmap9/fs/exec.c	2004-04-15 20:23:55.464969792 +0100
@@ -293,53 +293,42 @@ EXPORT_SYMBOL(copy_strings_kernel);
  * This routine is used to map in a page into an address space: needed by
  * execve() for the initial stack and environment pages.
  *
- * tsk->mmap_sem is held for writing.
+ * tsk->mm->mmap_sem is held for writing.
  */
 void put_dirty_page(struct task_struct *tsk, struct page *page,
 			unsigned long address, pgprot_t prot)
 {
+	struct mm_struct *mm = tsk->mm;
 	pgd_t * pgd;
 	pmd_t * pmd;
 	pte_t * pte;
-	struct pte_chain *pte_chain;
 
-	if (page_count(page) != 1)
-		printk(KERN_ERR "mem_map disagrees with %p at %08lx\n",
-				page, address);
-
-	pgd = pgd_offset(tsk->mm, address);
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain)
-		goto out_sig;
-	spin_lock(&tsk->mm->page_table_lock);
-	pmd = pmd_alloc(tsk->mm, pgd, address);
+	pgd = pgd_offset(mm, address);
+	spin_lock(&mm->page_table_lock);
+	pmd = pmd_alloc(mm, pgd, address);
 	if (!pmd)
 		goto out;
-	pte = pte_alloc_map(tsk->mm, pmd, address);
+	pte = pte_alloc_map(mm, pmd, address);
 	if (!pte)
 		goto out;
 	if (!pte_none(*pte)) {
 		pte_unmap(pte);
 		goto out;
 	}
+	mm->rss++;
 	lru_cache_add_active(page);
 	flush_dcache_page(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, prot))));
-	pte_chain = page_add_rmap(page, pte, pte_chain);
+	page_add_anon_rmap(page, mm, address);
 	pte_unmap(pte);
-	tsk->mm->rss++;
-	spin_unlock(&tsk->mm->page_table_lock);
+	spin_unlock(&mm->page_table_lock);
 
 	/* no need for flush_tlb */
-	pte_chain_free(pte_chain);
 	return;
 out:
-	spin_unlock(&tsk->mm->page_table_lock);
-out_sig:
+	spin_unlock(&mm->page_table_lock);
 	__free_page(page);
 	force_sig(SIGKILL, tsk);
-	pte_chain_free(pte_chain);
-	return;
 }
 
 int setup_arg_pages(struct linux_binprm *bprm, int executable_stack)
--- 2.6.5-mm6/include/linux/mm.h	2004-04-15 09:01:59.263800048 +0100
+++ rmap9/include/linux/mm.h	2004-04-15 20:23:55.466969488 +0100
@@ -164,8 +164,6 @@ struct vm_operations_struct {
 #endif
 };
 
-/* forward declaration; pte_chain is meant to be internal to rmap.c */
-struct pte_chain;
 struct mmu_gather;
 struct inode;
 
@@ -187,28 +185,26 @@ typedef unsigned long page_flags_t;
  *
  * The first line is data used in page cache lookup, the second line
  * is used for linear searches (eg. clock algorithm scans). 
- *
- * TODO: make this structure smaller, it could be as small as 32 bytes.
  */
 struct page {
-	page_flags_t flags;		/* atomic flags, some possibly
-					   updated asynchronously */
+	page_flags_t flags;		/* Atomic flags, some possibly
+					 * updated asynchronously */
 	atomic_t count;			/* Usage count, see below. */
-	struct address_space *mapping;	/* The inode (or ...) we belong to. */
-	pgoff_t index;			/* Our offset within mapping. */
-	struct list_head lru;		/* Pageout list, eg. active_list;
-					   protected by zone->lru_lock !! */
-	union {
-		struct pte_chain *chain;/* Reverse pte mapping pointer.
-					 * protected by PG_chainlock */
-		pte_addr_t direct;
-		unsigned int mapcount;	/* Count ptes mapped into mms */
-	} pte;
+	unsigned int mapcount;		/* Count of ptes mapped in mms,
+					 * to show when page is mapped
+					 * & limit reverse map searches,
+					 * protected by PG_maplock.
+					 */
 	unsigned long private;		/* Mapping-private opaque data:
 					 * usually used for buffer_heads
 					 * if PagePrivate set; used for
 					 * swp_entry_t if PageSwapCache
 					 */
+	struct address_space *mapping;	/* The inode (or ...) we belong to. */
+	pgoff_t index;			/* Our offset within mapping. */
+	struct list_head lru;		/* Pageout list, eg. active_list
+					 * protected by zone->lru_lock !
+					 */
 	/*
 	 * On machines where all RAM is mapped into kernel address space,
 	 * we can simply calculate the virtual address. On machines with
@@ -419,13 +415,11 @@ static inline struct address_space *page
 }
 
 /*
- * Return true if this page is mapped into pagetables.  Subtle: test pte.direct
- * rather than pte.chain.  Because sometimes pte.direct is 64-bit, and .chain
- * is only 32-bit.
+ * Return true if this page is mapped into pagetables.
  */
 static inline int page_mapped(struct page *page)
 {
-	return page->pte.direct != 0;
+	return page->mapcount != 0;
 }
 
 /*
--- 2.6.5-mm6/include/linux/page-flags.h	2004-04-15 09:01:59.295795184 +0100
+++ rmap9/include/linux/page-flags.h	2004-04-15 20:23:55.468969184 +0100
@@ -71,12 +71,12 @@
 #define PG_nosave		14	/* Used for system suspend/resume */
 #define PG_maplock		15	/* Lock bit for rmap to ptes */
 
-#define PG_direct		16	/* ->pte_chain points directly at pte */
+#define PG_swapcache		16	/* Swap page: swp_entry_t in private */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
-#define PG_anon			20	/* Anonymous page: anon_vma in mapping*/
-#define PG_swapcache		21	/* Swap page: swp_entry_t in private */
+
+#define PG_anon			20	/* Anonymous page: anonmm in mapping */
 
 
 /*
@@ -281,12 +281,6 @@ extern void get_full_page_state(struct p
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
--- 2.6.5-mm6/include/linux/rmap.h	2004-04-15 09:01:59.341788192 +0100
+++ rmap9/include/linux/rmap.h	2004-04-15 20:23:55.469969032 +0100
@@ -15,21 +15,25 @@
 
 #ifdef CONFIG_MMU
 
-struct pte_chain;
-struct pte_chain *pte_chain_alloc(int gfp_flags);
-void __pte_chain_free(struct pte_chain *pte_chain);
+void fastcall page_add_anon_rmap(struct page *,
+		struct mm_struct *, unsigned long addr);
+void fastcall page_add_file_rmap(struct page *);
+void fastcall page_remove_rmap(struct page *);
 
-static inline void pte_chain_free(struct pte_chain *pte_chain)
+/**
+ * page_dup_rmap - duplicate pte mapping to a page
+ * @page:	the page to add the mapping to
+ *
+ * For copy_page_range only: minimal extract from page_add_rmap,
+ * avoiding unnecessary tests (already checked) so it's quicker.
+ */
+static inline void page_dup_rmap(struct page *page)
 {
-	if (pte_chain)
-		__pte_chain_free(pte_chain);
+	rmap_lock(page);
+	page->mapcount++;
+	rmap_unlock(page);
 }
 
-struct pte_chain * fastcall
-	page_add_rmap(struct page *, pte_t *, struct pte_chain *);
-void fastcall page_add_file_rmap(struct page *);
-void fastcall page_remove_rmap(struct page *, pte_t *);
-
 /*
  * Called from mm/vmscan.c to handle paging out
  */
--- 2.6.5-mm6/init/main.c	2004-04-15 09:01:59.462769800 +0100
+++ rmap9/init/main.c	2004-04-15 20:23:55.470968880 +0100
@@ -84,7 +84,6 @@ extern void signals_init(void);
 extern void buffer_init(void);
 extern void pidhash_init(void);
 extern void pidmap_init(void);
-extern void pte_chain_init(void);
 extern void radix_tree_init(void);
 extern void free_initmem(void);
 extern void populate_rootfs(void);
@@ -501,7 +500,6 @@ asmlinkage void __init start_kernel(void
 	calibrate_delay();
 	pidmap_init();
 	pgtable_cache_init();
-	pte_chain_init();
 #ifdef CONFIG_X86
 	if (efi_enabled)
 		efi_enter_virtual_mode();
--- 2.6.5-mm6/mm/fremap.c	2004-04-15 09:01:59.659739856 +0100
+++ rmap9/mm/fremap.c	2004-04-15 20:23:55.471968728 +0100
@@ -36,7 +36,7 @@ static inline void zap_pte(struct mm_str
 			if (!PageReserved(page)) {
 				if (pte_dirty(pte))
 					set_page_dirty(page);
-				page_remove_rmap(page, ptep);
+				page_remove_rmap(page);
 				page_cache_release(page);
 				mm->rss--;
 			}
--- 2.6.5-mm6/mm/memory.c	2004-04-15 09:01:59.691734992 +0100
+++ rmap9/mm/memory.c	2004-04-15 20:23:55.475968120 +0100
@@ -217,20 +217,10 @@ int copy_page_range(struct mm_struct *ds
 	unsigned long address = vma->vm_start;
 	unsigned long end = vma->vm_end;
 	unsigned long cow;
-	struct pte_chain *pte_chain = NULL;
 
 	if (is_vm_hugetlb_page(vma))
 		return copy_hugetlb_page_range(dst, src, vma);
 
-	pte_chain = pte_chain_alloc(GFP_ATOMIC | __GFP_NOWARN);
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
@@ -329,35 +319,8 @@ skip_copy_pte_range:
 				pte = pte_mkold(pte);
 				get_page(page);
 				dst->rss++;
-
 				set_pte(dst_pte, pte);
-				if (PageAnon(page))
-					pte_chain = page_add_rmap(page,
-						dst_pte, pte_chain);
-				else
-					page_add_file_rmap(page);
-				if (pte_chain)
-					goto cont_copy_pte_range_noset;
-				pte_chain = pte_chain_alloc(GFP_ATOMIC | __GFP_NOWARN);
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
+				page_dup_rmap(page);
 cont_copy_pte_range_noset:
 				address += PAGE_SIZE;
 				if (address >= end) {
@@ -371,7 +334,7 @@ cont_copy_pte_range_noset:
 			pte_unmap_nested(src_pte-1);
 			pte_unmap(dst_pte-1);
 			spin_unlock(&src->page_table_lock);
-		
+			cond_resched_lock(&dst->page_table_lock);
 cont_copy_pmd_range:
 			src_pmd++;
 			dst_pmd++;
@@ -380,10 +343,8 @@ cont_copy_pmd_range:
 out_unlock:
 	spin_unlock(&src->page_table_lock);
 out:
-	pte_chain_free(pte_chain);
 	return 0;
 nomem:
-	pte_chain_free(pte_chain);
 	return -ENOMEM;
 }
 
@@ -459,7 +420,7 @@ static void zap_pte_range(struct mmu_gat
 			if (pte_young(pte) && page_mapping(page))
 				mark_page_accessed(page);
 			tlb->freed++;
-			page_remove_rmap(page, ptep);
+			page_remove_rmap(page);
 			tlb_remove_page(tlb, page);
 			continue;
 		}
@@ -1094,7 +1055,6 @@ static int do_wp_page(struct mm_struct *
 {
 	struct page *old_page, *new_page;
 	unsigned long pfn = pte_pfn(pte);
-	struct pte_chain *pte_chain;
 	pte_t entry;
 
 	if (unlikely(!pfn_valid(pfn))) {
@@ -1133,9 +1093,6 @@ static int do_wp_page(struct mm_struct *
 	page_cache_get(old_page);
 	spin_unlock(&mm->page_table_lock);
 
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain)
-		goto no_pte_chain;
 	new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 	if (!new_page)
 		goto no_new_page;
@@ -1149,10 +1106,11 @@ static int do_wp_page(struct mm_struct *
 	if (pte_same(*page_table, pte)) {
 		if (PageReserved(old_page))
 			++mm->rss;
-		page_remove_rmap(old_page, page_table);
+		else
+			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
-		pte_chain = page_add_rmap(new_page, page_table, pte_chain);
 		lru_cache_add_active(new_page);
+		page_add_anon_rmap(new_page, mm, address);
 
 		/* Free the old page.. */
 		new_page = old_page;
@@ -1161,12 +1119,9 @@ static int do_wp_page(struct mm_struct *
 	page_cache_release(new_page);
 	page_cache_release(old_page);
 	spin_unlock(&mm->page_table_lock);
-	pte_chain_free(pte_chain);
 	return VM_FAULT_MINOR;
 
 no_new_page:
-	pte_chain_free(pte_chain);
-no_pte_chain:
 	page_cache_release(old_page);
 	return VM_FAULT_OOM;
 }
@@ -1367,7 +1322,6 @@ static int do_swap_page(struct mm_struct
 	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 	pte_t pte;
 	int ret = VM_FAULT_MINOR;
-	struct pte_chain *pte_chain = NULL;
 
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
@@ -1397,11 +1351,6 @@ static int do_swap_page(struct mm_struct
 	}
 
 	mark_page_accessed(page);
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain) {
-		ret = VM_FAULT_OOM;
-		goto out;
-	}
 	lock_page(page);
 
 	/*
@@ -1433,14 +1382,13 @@ static int do_swap_page(struct mm_struct
 
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
-	pte_chain = page_add_rmap(page, page_table, pte_chain);
+	page_add_anon_rmap(page, mm, address);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 out:
-	pte_chain_free(pte_chain);
 	return ret;
 }
 
@@ -1456,20 +1404,7 @@ do_anonymous_page(struct mm_struct *mm, 
 {
 	pte_t entry;
 	struct page * page = ZERO_PAGE(addr);
-	struct pte_chain *pte_chain;
-	int ret;
 
-	pte_chain = pte_chain_alloc(GFP_ATOMIC | __GFP_NOWARN);
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
 
@@ -1491,7 +1426,6 @@ do_anonymous_page(struct mm_struct *mm, 
 			pte_unmap(page_table);
 			page_cache_release(page);
 			spin_unlock(&mm->page_table_lock);
-			ret = VM_FAULT_MINOR;
 			goto out;
 		}
 		mm->rss++;
@@ -1500,24 +1434,19 @@ do_anonymous_page(struct mm_struct *mm, 
 				      vma);
 		lru_cache_add_active(page);
 		mark_page_accessed(page);
+		page_add_anon_rmap(page, mm, addr);
 	}
 
 	set_pte(page_table, entry);
-	/* ignores ZERO_PAGE */
-	pte_chain = page_add_rmap(page, page_table, pte_chain);
 	pte_unmap(page_table);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, addr, entry);
 	spin_unlock(&mm->page_table_lock);
-	ret = VM_FAULT_MINOR;
-	goto out;
-
-no_mem:
-	ret = VM_FAULT_OOM;
 out:
-	pte_chain_free(pte_chain);
-	return ret;
+	return VM_FAULT_MINOR;
+no_mem:
+	return VM_FAULT_OOM;
 }
 
 /*
@@ -1539,7 +1468,6 @@ do_no_page(struct mm_struct *mm, struct 
 	struct page * new_page;
 	struct address_space *mapping = NULL;
 	pte_t entry;
-	struct pte_chain *pte_chain;
 	int sequence = 0;
 	int ret = VM_FAULT_MINOR;
 	int anon = 0;
@@ -1564,10 +1492,6 @@ retry:
 	if (new_page == NOPAGE_OOM)
 		return VM_FAULT_OOM;
 
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain)
-		goto oom;
-
 	/*
 	 * Should we do an early C-O-W break?
 	 */
@@ -1592,7 +1516,6 @@ retry:
 		sequence = atomic_read(&mapping->truncate_count);
 		spin_unlock(&mm->page_table_lock);
 		page_cache_release(new_page);
-		pte_chain_free(pte_chain);
 		goto retry;
 	}
 	page_table = pte_offset_map(pmd, address);
@@ -1618,8 +1541,7 @@ retry:
 		set_pte(page_table, entry);
 		if (anon) {
 			lru_cache_add_active(new_page);
-			pte_chain = page_add_rmap(new_page,
-						page_table, pte_chain);
+			page_add_anon_rmap(new_page, mm, address);
 		} else
 			page_add_file_rmap(new_page);
 		pte_unmap(page_table);
@@ -1639,7 +1561,6 @@ oom:
 	page_cache_release(new_page);
 	ret = VM_FAULT_OOM;
 out:
-	pte_chain_free(pte_chain);
 	return ret;
 }
 
--- 2.6.5-mm6/mm/mremap.c	2004-04-15 09:01:59.722730280 +0100
+++ rmap9/mm/mremap.c	2004-04-15 20:23:55.476967968 +0100
@@ -81,7 +81,7 @@ static inline pte_t *alloc_one_pte_map(s
 
 static void
 copy_one_pte(struct vm_area_struct *vma, unsigned long old_addr,
-	     pte_t *src, pte_t *dst, struct pte_chain **pte_chainp)
+	     unsigned long new_addr, pte_t *src, pte_t *dst)
 {
 	pte_t pte = ptep_clear_flush(vma, old_addr, src);
 	set_pte(dst, pte);
@@ -91,8 +91,8 @@ copy_one_pte(struct vm_area_struct *vma,
 		if (pfn_valid(pfn)) {
 			struct page *page = pfn_to_page(pfn);
 			if (PageAnon(page)) {
-				page_remove_rmap(page, src);
-				*pte_chainp = page_add_rmap(page, dst, *pte_chainp);
+				page_remove_rmap(page);
+				page_add_anon_rmap(page, vma->vm_mm, new_addr);
 			}
 		}
 	}
@@ -105,13 +105,7 @@ move_one_page(struct vm_area_struct *vma
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
@@ -133,8 +127,7 @@ move_one_page(struct vm_area_struct *vma
 		 */
 		if (src) {
 			if (dst)
-				copy_one_pte(vma, old_addr, src,
-						dst, &pte_chain);
+				copy_one_pte(vma, old_addr, new_addr, src, dst);
 			else
 				error = -ENOMEM;
 			pte_unmap_nested(src);
@@ -142,8 +135,6 @@ move_one_page(struct vm_area_struct *vma
 		pte_unmap(dst);
 	}
 	spin_unlock(&mm->page_table_lock);
-	pte_chain_free(pte_chain);
-out:
 	return error;
 }
 
--- 2.6.5-mm6/mm/nommu.c	2004-02-04 02:45:41.000000000 +0000
+++ rmap9/mm/nommu.c	2004-04-15 20:23:55.478967664 +0100
@@ -567,7 +567,3 @@ unsigned long get_unmapped_area(struct f
 {
 	return -ENOMEM;
 }
-
-void pte_chain_init(void)
-{
-}
--- 2.6.5-mm6/mm/rmap.c	2004-04-15 09:01:59.741727392 +0100
+++ rmap9/mm/rmap.c	2004-04-15 20:23:55.482967056 +0100
@@ -4,17 +4,14 @@
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
- * - the page->pte.chain is protected by the PG_maplock bit,
- *   which nests within the the mm->page_table_lock,
+ * - the page->mapcount field is protected by the PG_maplock bit,
+ *   which nests within the mm->page_table_lock,
  *   which nests within the page lock.
  * - because swapout locking is opposite to the locking order
  *   in the page fault path, the swapout path uses trylocks
@@ -27,88 +24,15 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/rmap.h>
-#include <linux/cache.h>
-#include <linux/percpu.h>
 
-#include <asm/pgalloc.h>
-#include <asm/rmap.h>
-#include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-/*
- * Something oopsable to put for now in the page->mapping
- * of an anonymous page, to test that it is ignored.
- */
-#define ANON_MAPPING_DEBUG	((struct address_space *) 0xADB)
-
 static inline void clear_page_anon(struct page *page)
 {
-	BUG_ON(page->mapping != ANON_MAPPING_DEBUG);
 	page->mapping = NULL;
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
-#define NRPTE ((L1_CACHE_BYTES - sizeof(unsigned long))/sizeof(pte_addr_t))
-
-/*
- * next_and_idx encodes both the address of the next pte_chain and the
- * offset of the lowest-index used pte in ptes[] (which is equal also
- * to the offset of the highest-index unused pte in ptes[], plus one).
- */
-struct pte_chain {
-	unsigned long next_and_idx;
-	pte_addr_t ptes[NRPTE];
-} ____cacheline_aligned;
-
-kmem_cache_t	*pte_chain_cache;
-
-static inline struct pte_chain *pte_chain_next(struct pte_chain *pte_chain)
-{
-	return (struct pte_chain *)(pte_chain->next_and_idx & ~NRPTE);
-}
-
-static inline struct pte_chain *pte_chain_ptr(unsigned long pte_chain_addr)
-{
-	return (struct pte_chain *)(pte_chain_addr & ~NRPTE);
-}
-
-static inline int pte_chain_idx(struct pte_chain *pte_chain)
-{
-	return pte_chain->next_and_idx & NRPTE;
-}
-
-static inline unsigned long
-pte_chain_encode(struct pte_chain *pte_chain, int idx)
-{
-	return (unsigned long)pte_chain | idx;
-}
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
  ** VM stuff below this comment
  **/
@@ -126,6 +50,11 @@ unsigned long vma_address(struct vm_area
 		address: -EFAULT;
 }
 
+/**
+ ** Subfunctions of page_referenced: page_referenced_one called
+ ** repeatedly from either page_referenced_anon or page_referenced_file.
+ **/
+
 static int page_referenced_one(struct page *page,
 	struct mm_struct *mm, unsigned long address,
 	unsigned int *mapcount, int *failed)
@@ -172,6 +101,11 @@ out_unlock:
 	return referenced;
 }
 
+static inline int page_referenced_anon(struct page *page)
+{
+	return 1;	/* until next patch */
+}
+
 /**
  * page_referenced_file - referenced check for object-based rmap
  * @page: the page we're checking references on.
@@ -188,7 +122,7 @@ out_unlock:
  */
 static inline int page_referenced_file(struct page *page)
 {
-	unsigned int mapcount = page->pte.mapcount;
+	unsigned int mapcount = page->mapcount;
 	struct address_space *mapping = page->mapping;
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 	struct vm_area_struct *vma;
@@ -247,15 +181,11 @@ out:
  * @page: the page to test
  *
  * Quick test_and_clear_referenced for all mappings to a page,
- * returns the number of processes which referenced the page.
+ * returns the number of ptes which referenced the page.
  * Caller needs to hold the rmap lock.
- *
- * If the page has a single-entry pte_chain, collapse that back to a PageDirect
- * representation.  This way, it's only done under memory pressure.
  */
-int fastcall page_referenced(struct page * page)
+int fastcall page_referenced(struct page *page)
 {
-	struct pte_chain *pc;
 	int referenced = 0;
 
 	if (page_test_and_clear_young(page))
@@ -264,97 +194,38 @@ int fastcall page_referenced(struct page
 	if (TestClearPageReferenced(page))
 		referenced++;
 
-	if (!PageAnon(page)) {
-		if (page_mapped(page) && page->mapping)
+	if (page->mapcount && page->mapping) {
+		if (PageAnon(page))
+			referenced += page_referenced_anon(page);
+		else
 			referenced += page_referenced_file(page);
-	} else if (PageDirect(page)) {
-		pte_t *pte = rmap_ptep_map(page->pte.direct);
-		if (ptep_test_and_clear_young(pte))
-			referenced++;
-		rmap_ptep_unmap(pte);
-	} else {
-		int nr_chains = 0;
-
-		/* Check all the page tables mapping this page. */
-		for (pc = page->pte.chain; pc; pc = pte_chain_next(pc)) {
-			int i;
-
-			for (i = pte_chain_idx(pc); i < NRPTE; i++) {
-				pte_addr_t pte_paddr = pc->ptes[i];
-				pte_t *p;
-
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
 	}
 	return referenced;
 }
 
 /**
- * page_add_rmap - add reverse mapping entry to an anonymous page
- * @page: the page to add the mapping to
- * @ptep: the page table entry mapping this page
+ * page_add_anon_rmap - add pte mapping to an anonymous page
+ * @page:	the page to add the mapping to
+ * @mm:		the mm in which the mapping is added
+ * @address:	the user virtual address mapped
  *
- * Add a new pte reverse mapping to a page.
  * The caller needs to hold the mm->page_table_lock.
  */
-struct pte_chain * fastcall
-page_add_rmap(struct page *page, pte_t *ptep, struct pte_chain *pte_chain)
+void fastcall page_add_anon_rmap(struct page *page,
+	struct mm_struct *mm, unsigned long address)
 {
-	pte_addr_t pte_paddr = ptep_to_paddr(ptep);
-	struct pte_chain *cur_pte_chain;
-
-	if (PageReserved(page))
-		return pte_chain;
+	BUG_ON(PageReserved(page));
+	BUG_ON(page_mapping(page));
 
 	rmap_lock(page);
-
-	if (page->pte.direct == 0) {
-		page->pte.direct = pte_paddr;
-		SetPageDirect(page);
+	if (!page->mapcount) {
 		SetPageAnon(page);
-		page->mapping = ANON_MAPPING_DEBUG;
+		page->index = address & PAGE_MASK;
+		page->mapping = (void *) mm;	/* until next patch */
 		inc_page_state(nr_mapped);
-		goto out;
 	}
-
-	if (PageDirect(page)) {
-		/* Convert a direct pointer into a pte_chain */
-		ClearPageDirect(page);
-		pte_chain->ptes[NRPTE-1] = page->pte.direct;
-		pte_chain->ptes[NRPTE-2] = pte_paddr;
-		pte_chain->next_and_idx = pte_chain_encode(NULL, NRPTE-2);
-		page->pte.direct = 0;
-		page->pte.chain = pte_chain;
-		pte_chain = NULL;	/* We consumed it */
-		goto out;
-	}
-
-	cur_pte_chain = page->pte.chain;
-	if (cur_pte_chain->ptes[0]) {	/* It's full */
-		pte_chain->next_and_idx = pte_chain_encode(cur_pte_chain,
-								NRPTE - 1);
-		page->pte.chain = pte_chain;
-		pte_chain->ptes[NRPTE-1] = pte_paddr;
-		pte_chain = NULL;	/* We consumed it */
-		goto out;
-	}
-	cur_pte_chain->ptes[pte_chain_idx(cur_pte_chain) - 1] = pte_paddr;
-	cur_pte_chain->next_and_idx--;
-out:
+	page->mapcount++;
 	rmap_unlock(page);
-	return pte_chain;
 }
 
 /**
@@ -370,160 +241,39 @@ void fastcall page_add_file_rmap(struct 
 		return;
 
 	rmap_lock(page);
-	if (!page_mapped(page))
+	if (!page->mapcount)
 		inc_page_state(nr_mapped);
-	page->pte.mapcount++;
+	page->mapcount++;
 	rmap_unlock(page);
 }
 
 /**
- * page_remove_rmap - take down reverse mapping to a page
+ * page_remove_rmap - take down pte mapping from a page
  * @page: page to remove mapping from
- * @ptep: page table entry to remove
  *
- * Removes the reverse mapping from the pte_chain of the page,
- * after that the caller can clear the page table entry and free
- * the page.
  * Caller needs to hold the mm->page_table_lock.
  */
-void fastcall page_remove_rmap(struct page *page, pte_t *ptep)
+void fastcall page_remove_rmap(struct page *page)
 {
-	pte_addr_t pte_paddr = ptep_to_paddr(ptep);
-	struct pte_chain *pc;
-
-	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
-		return;
+	BUG_ON(PageReserved(page));
+	BUG_ON(!page->mapcount);
 
 	rmap_lock(page);
-
-	if (!page_mapped(page))
-		goto out_unlock;	/* remap_page_range() from a driver? */
-
-	if (!PageAnon(page)) {
-		page->pte.mapcount--;
-	} else if (PageDirect(page)) {
-		if (page->pte.direct == pte_paddr) {
-			page->pte.direct = 0;
-			ClearPageDirect(page);
-			goto out;
-		}
-	} else {
-		struct pte_chain *start = page->pte.chain;
-		struct pte_chain *next;
-		int victim_i = pte_chain_idx(start);
-
-		for (pc = start; pc; pc = next) {
-			int i;
-
-			next = pte_chain_next(pc);
-			if (next)
-				prefetch(next);
-			for (i = pte_chain_idx(pc); i < NRPTE; i++) {
-				pte_addr_t pa = pc->ptes[i];
-
-				if (pa != pte_paddr)
-					continue;
-				pc->ptes[i] = start->ptes[victim_i];
-				start->ptes[victim_i] = 0;
-				if (victim_i == NRPTE-1) {
-					/* Emptied a pte_chain */
-					page->pte.chain = pte_chain_next(start);
-					__pte_chain_free(start);
-				} else {
-					start->next_and_idx++;
-				}
-				goto out;
-			}
-		}
-	}
-out:
-	if (!page_mapped(page)) {
+	page->mapcount--;
+	if (!page->mapcount) {
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
 		if (PageAnon(page))
 			clear_page_anon(page);
 		dec_page_state(nr_mapped);
 	}
-out_unlock:
 	rmap_unlock(page);
 }
 
 /**
- * try_to_unmap_anon_one - worker function for try_to_unmap
- * @page: page to unmap
- * @ptep: page table entry to unmap from page
- *
- * Internal helper function for try_to_unmap, called for each page
- * table entry mapping a page. Because locking order here is opposite
- * to the locking order used by the page fault path, we use trylocks.
- * Locking:
- *	    page lock			shrink_list(), trylock
- *		rmap lock		shrink_list()
- *		    mm->page_table_lock	try_to_unmap_one(), trylock
- */
-static int fastcall try_to_unmap_anon_one(struct page * page, pte_addr_t paddr)
-{
-	pte_t *ptep = rmap_ptep_map(paddr);
-	unsigned long address = ptep_to_address(ptep);
-	struct mm_struct * mm = ptep_to_mm(ptep);
-	struct vm_area_struct * vma;
-	pte_t pte;
-	int ret;
-
-	if (!mm)
-		BUG();
-
-	/*
-	 * We need the page_table_lock to protect us from page faults,
-	 * munmap, fork, etc...
-	 */
-	if (!spin_trylock(&mm->page_table_lock)) {
-		rmap_ptep_unmap(ptep);
-		return SWAP_AGAIN;
-	}
-
-	/* unmap_vmas drops page_table_lock with vma unlinked */
-	vma = find_vma(mm, address);
-	if (!vma) {
-		ret = SWAP_FAIL;
-		goto out_unlock;
-	}
-
-	/* The page is mlock()d, we cannot swap it out. */
-	if (vma->vm_flags & VM_LOCKED) {
-		ret = SWAP_FAIL;
-		goto out_unlock;
-	}
-
-	/* Nuke the page table entry. */
-	flush_cache_page(vma, address);
-	pte = ptep_clear_flush(vma, address, ptep);
-
-	{
-		swp_entry_t entry = { .val = page->private };
-		/*
-		 * Store the swap location in the pte.
-		 * See handle_pte_fault() ...
-		 */
-		BUG_ON(!PageSwapCache(page));
-		swap_duplicate(entry);
-		set_pte(ptep, swp_entry_to_pte(entry));
-		BUG_ON(pte_file(*ptep));
-	}
-
-	/* Move the dirty bit to the physical page now the pte is gone. */
-	if (pte_dirty(pte))
-		set_page_dirty(page);
-
-	mm->rss--;
-	page_cache_release(page);
-	ret = SWAP_SUCCESS;
-
-out_unlock:
-	rmap_ptep_unmap(ptep);
-	spin_unlock(&mm->page_table_lock);
-	return ret;
-}
+ ** Subfunctions of try_to_unmap: try_to_unmap_one called
+ ** repeatedly from either try_to_unmap_anon or try_to_unmap_file.
+ **/
 
 static int try_to_unmap_one(struct page *page,
 	struct mm_struct *mm, unsigned long address,
@@ -579,8 +329,8 @@ static int try_to_unmap_one(struct page 
 		set_page_dirty(page);
 
 	mm->rss--;
-	BUG_ON(!page->pte.mapcount);
-	page->pte.mapcount--;
+	BUG_ON(!page->mapcount);
+	page->mapcount--;
 	page_cache_release(page);
 
 out_unmap:
@@ -668,7 +418,7 @@ static int try_to_unmap_cluster(struct m
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
 
-		page_remove_rmap(page, pte);
+		page_remove_rmap(page);
 		page_cache_release(page);
 		mm->rss--;
 		(*mapcount)--;
@@ -681,6 +431,11 @@ out_unlock:
 	return SWAP_AGAIN;
 }
 
+static inline int try_to_unmap_anon(struct page *page)
+{
+	return SWAP_FAIL;	/* until next patch */
+}
+
 /**
  * try_to_unmap_file - unmap file page using the object-based rmap method
  * @page: the page to unmap
@@ -695,7 +450,7 @@ out_unlock:
  */
 static inline int try_to_unmap_file(struct page *page)
 {
-	unsigned int mapcount = page->pte.mapcount;
+	unsigned int mapcount = page->mapcount;
 	struct address_space *mapping = page->mapping;
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 	struct vm_area_struct *vma;
@@ -820,73 +575,20 @@ out:
  * SWAP_AGAIN	- we missed a trylock, try again later
  * SWAP_FAIL	- the page is unswappable
  */
-int fastcall try_to_unmap(struct page * page)
+int fastcall try_to_unmap(struct page *page)
 {
-	struct pte_chain *pc, *next_pc, *start;
-	int ret = SWAP_SUCCESS;
-	int victim_i;
+	int ret;
 
 	BUG_ON(PageReserved(page));
 	BUG_ON(!PageLocked(page));
-	BUG_ON(!page_mapped(page));
+	BUG_ON(!page->mapcount);
 
-	if (!PageAnon(page)) {
+	if (PageAnon(page))
+		ret = try_to_unmap_anon(page);
+	else
 		ret = try_to_unmap_file(page);
-		goto out;
-	}
 
-	if (PageDirect(page)) {
-		ret = try_to_unmap_anon_one(page, page->pte.direct);
-		if (ret == SWAP_SUCCESS) {
-			page->pte.direct = 0;
-			ClearPageDirect(page);
-		}
-		goto out;
-	}
-
-	start = page->pte.chain;
-	victim_i = pte_chain_idx(start);
-	for (pc = start; pc; pc = next_pc) {
-		int i;
-
-		next_pc = pte_chain_next(pc);
-		if (next_pc)
-			prefetch(next_pc);
-		for (i = pte_chain_idx(pc); i < NRPTE; i++) {
-			pte_addr_t pte_paddr = pc->ptes[i];
-
-			switch (try_to_unmap_anon_one(page, pte_paddr)) {
-			case SWAP_SUCCESS:
-				/*
-				 * Release a slot.  If we're releasing the
-				 * first pte in the first pte_chain then
-				 * pc->ptes[i] and start->ptes[victim_i] both
-				 * refer to the same thing.  It works out.
-				 */
-				pc->ptes[i] = start->ptes[victim_i];
-				start->ptes[victim_i] = 0;
-				victim_i++;
-				if (victim_i == NRPTE) {
-					page->pte.chain = pte_chain_next(start);
-					__pte_chain_free(start);
-					start = page->pte.chain;
-					victim_i = 0;
-				} else {
-					start->next_and_idx++;
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
-	if (!page_mapped(page)) {
+	if (!page->mapcount) {
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
 		if (PageAnon(page))
@@ -896,73 +598,3 @@ out:
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
-	struct pte_chain **pte_chainp;
-
-	pte_chainp = &get_cpu_var(local_pte_chain);
-	if (pte_chain->next_and_idx)
-		pte_chain->next_and_idx = 0;
-	if (*pte_chainp)
-		kmem_cache_free(pte_chain_cache, *pte_chainp);
-	*pte_chainp = pte_chain;
-	put_cpu_var(local_pte_chain);
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
-	struct pte_chain *ret;
-	struct pte_chain **pte_chainp;
-
-	might_sleep_if(gfp_flags & __GFP_WAIT);
-
-	pte_chainp = &get_cpu_var(local_pte_chain);
-	if (*pte_chainp) {
-		ret = *pte_chainp;
-		*pte_chainp = NULL;
-		put_cpu_var(local_pte_chain);
-	} else {
-		put_cpu_var(local_pte_chain);
-		ret = kmem_cache_alloc(pte_chain_cache, gfp_flags);
-	}
-	return ret;
-}
-
-void __init pte_chain_init(void)
-{
-	pte_chain_cache = kmem_cache_create(	"pte_chain",
-						sizeof(struct pte_chain),
-						sizeof(struct pte_chain),
-						SLAB_PANIC,
-						pte_chain_ctor,
-						NULL);
-}
--- 2.6.5-mm6/mm/swapfile.c	2004-04-15 09:01:59.759724656 +0100
+++ rmap9/mm/swapfile.c	2004-04-15 20:23:55.485966600 +0100
@@ -455,19 +455,19 @@ void free_swap_and_cache(swp_entry_t ent
 /* vma->vm_mm->page_table_lock is held */
 static void
 unuse_pte(struct vm_area_struct *vma, unsigned long address, pte_t *dir,
-	swp_entry_t entry, struct page *page, struct pte_chain **pte_chainp)
+	swp_entry_t entry, struct page *page)
 {
 	vma->vm_mm->rss++;
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
-	*pte_chainp = page_add_rmap(page, dir, *pte_chainp);
+	page_add_anon_rmap(page, vma->vm_mm, address);
 	swap_free(entry);
 }
 
 /* vma->vm_mm->page_table_lock is held */
 static int unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
 	unsigned long address, unsigned long size, unsigned long offset,
-	swp_entry_t entry, struct page *page, struct pte_chain **pte_chainp)
+	swp_entry_t entry, struct page *page)
 {
 	pte_t * pte;
 	unsigned long end;
@@ -492,8 +492,7 @@ static int unuse_pmd(struct vm_area_stru
 		 * Test inline before going to call unuse_pte.
 		 */
 		if (unlikely(pte_same(*pte, swp_pte))) {
-			unuse_pte(vma, offset + address, pte,
-					entry, page, pte_chainp);
+			unuse_pte(vma, offset + address, pte, entry, page);
 			pte_unmap(pte);
 			return 1;
 		}
@@ -507,7 +506,7 @@ static int unuse_pmd(struct vm_area_stru
 /* vma->vm_mm->page_table_lock is held */
 static int unuse_pgd(struct vm_area_struct * vma, pgd_t *dir,
 	unsigned long address, unsigned long size,
-	swp_entry_t entry, struct page *page, struct pte_chain **pte_chainp)
+	swp_entry_t entry, struct page *page)
 {
 	pmd_t * pmd;
 	unsigned long offset, end;
@@ -529,7 +528,7 @@ static int unuse_pgd(struct vm_area_stru
 		BUG();
 	do {
 		if (unuse_pmd(vma, pmd, address, end - address,
-				offset, entry, page, pte_chainp))
+				offset, entry, page))
 			return 1;
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
@@ -539,15 +538,14 @@ static int unuse_pgd(struct vm_area_stru
 
 /* vma->vm_mm->page_table_lock is held */
 static int unuse_vma(struct vm_area_struct * vma, pgd_t *pgdir,
-	swp_entry_t entry, struct page *page, struct pte_chain **pte_chainp)
+	swp_entry_t entry, struct page *page)
 {
 	unsigned long start = vma->vm_start, end = vma->vm_end;
 
 	if (start >= end)
 		BUG();
 	do {
-		if (unuse_pgd(vma, pgdir, start, end - start,
-				entry, page, pte_chainp))
+		if (unuse_pgd(vma, pgdir, start, end - start, entry, page))
 			return 1;
 		start = (start + PGDIR_SIZE) & PGDIR_MASK;
 		pgdir++;
@@ -559,11 +557,6 @@ static int unuse_process(struct mm_struc
 			swp_entry_t entry, struct page* page)
 {
 	struct vm_area_struct* vma;
-	struct pte_chain *pte_chain;
-
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain)
-		return -ENOMEM;
 
 	/*
 	 * Go through process' page directory.
@@ -571,11 +564,10 @@ static int unuse_process(struct mm_struc
 	spin_lock(&mm->page_table_lock);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		pgd_t * pgd = pgd_offset(mm, vma->vm_start);
-		if (unuse_vma(vma, pgd, entry, page, &pte_chain))
+		if (unuse_vma(vma, pgd, entry, page))
 			break;
 	}
 	spin_unlock(&mm->page_table_lock);
-	pte_chain_free(pte_chain);
 	return 0;
 }
 

