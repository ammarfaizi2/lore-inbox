Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUCRXrg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbUCRXrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:47:36 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:15264 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263324AbUCRXZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:25:18 -0500
Date: Thu, 18 Mar 2004 23:25:12 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: [PATCH] anobjrmap 4/6 no pte_chains
In-Reply-To: <Pine.LNX.4.44.0403182317050.16911-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403182324060.16928-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anobjrmap 4/6 remove pte-pointer-based rmap

Lots of deletions: the next patch will put in the new anon rmap,
I expect it to look clearer if first we remove all of the old
pte-pointer-based anon rmap in this patch - which therefore
leaves anonymous rmap totally disabled, anon pages locked in
memory until the process frees them.

A few additions: the previous patch brought ClearPageAnon into
rmap.c instead of leaving it to final page free; but I think
there'd be a race with swapin or swapoff doing SetPageAnon:
now SetPageAnon under lock within page_add_anon_rmap.  That
lock now being called rmap_lock instead of pte_chain_lock.

 fs/exec.c                  |   28 --
 include/linux/mm.h         |   20 -
 include/linux/page-flags.h |   11 
 include/linux/rmap.h       |   33 +-
 init/main.c                |    2 
 mm/fremap.c                |   17 -
 mm/memory.c                |  112 +-------
 mm/mremap.c                |   48 +--
 mm/nommu.c                 |    4 
 mm/page_alloc.c            |    9 
 mm/rmap.c                  |  598 +++++++--------------------------------------
 mm/swapfile.c              |   41 ---
 mm/vmscan.c                |   22 -
 13 files changed, 207 insertions(+), 738 deletions(-)

--- anobjrmap3/fs/exec.c	2004-03-18 21:26:52.270066848 +0000
+++ anobjrmap4/fs/exec.c	2004-03-18 21:27:15.341559448 +0000
@@ -293,54 +293,46 @@ EXPORT_SYMBOL(copy_strings_kernel);
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
 
 	if (page_count(page) != 1)
 		printk(KERN_ERR "mem_map disagrees with %p at %08lx\n",
 				page, address);
 
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
-	SetPageAnon(page);
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
 
 int setup_arg_pages(struct linux_binprm *bprm)
--- anobjrmap3/include/linux/mm.h	2004-03-18 21:27:03.810312464 +0000
+++ anobjrmap4/include/linux/mm.h	2004-03-18 21:27:15.342559296 +0000
@@ -147,8 +147,6 @@ struct vm_operations_struct {
 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
 };
 
-/* forward declaration; pte_chain is meant to be internal to rmap.c */
-struct pte_chain;
 struct mmu_gather;
 struct inode;
 
@@ -171,17 +169,12 @@ struct page {
 	unsigned long flags;		/* atomic flags, some possibly
 					   updated asynchronously */
 	atomic_t count;			/* Usage count, see below. */
+	int      mapcount;		/* rmap counts ptes mapped in mms */
 	struct list_head list;		/* ->mapping has some page lists. */
 	struct address_space *mapping;	/* The inode (or ...) we belong to. */
 	unsigned long index;		/* Our offset within mapping. */
 	struct list_head lru;		/* Pageout list, eg. active_list;
 					   protected by zone->lru_lock !! */
-	union {
-		struct pte_chain *chain;/* Reverse pte mapping pointer.
-					 * protected by PG_chainlock */
-		pte_addr_t direct;
-		int mapcount;
-	} pte;
 	unsigned long private;		/* mapping-private opaque data */
 
 	/*
@@ -404,16 +397,7 @@ void page_address_init(void);
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
+#define page_mapped(page)  ((page)->mapcount != 0)
 
 /*
  * Error return values for the *_nopage functions
--- anobjrmap3/include/linux/page-flags.h	2004-03-18 21:27:03.812312160 +0000
+++ anobjrmap4/include/linux/page-flags.h	2004-03-18 21:27:15.344558992 +0000
@@ -69,15 +69,14 @@
 #define PG_private		12	/* Has something at ->private */
 #define PG_writeback		13	/* Page is under writeback */
 #define PG_nosave		14	/* Used for system suspend/resume */
-#define PG_chainlock		15	/* lock bit for ->pte_chain */
+#define PG_rmaplock		15	/* Lock bit for reversing to ptes */
 
-#define PG_direct		16	/* ->pte_chain points directly at pte */
+#define PG_swapcache		16	/* Swap page: swp_entry_t in private */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
 
 #define PG_anon			20	/* Anonymous page: anonmm in mapping */
-#define PG_swapcache		21	/* Swap page: swp_entry_t in private */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -284,12 +283,6 @@ extern void get_full_page_state(struct p
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
--- anobjrmap3/include/linux/rmap.h	2004-03-18 21:27:03.813312008 +0000
+++ anobjrmap4/include/linux/rmap.h	2004-03-18 21:27:15.345558840 +0000
@@ -8,25 +8,32 @@
 #include <linux/config.h>
 #include <linux/linkage.h>
 
-#define pte_chain_lock(page)	bit_spin_lock(PG_chainlock, &(page)->flags)
-#define pte_chain_unlock(page)	bit_spin_unlock(PG_chainlock, &(page)->flags)
+#define rmap_lock(page)    bit_spin_lock(PG_rmaplock, &(page)->flags)
+#define rmap_unlock(page)  bit_spin_unlock(PG_rmaplock, &(page)->flags)
 
 #ifdef CONFIG_MMU
 
-struct pte_chain;
-struct pte_chain *pte_chain_alloc(int gfp_flags);
-void __pte_chain_free(struct pte_chain *pte_chain);
-
-static inline void pte_chain_free(struct pte_chain *pte_chain)
+void fastcall page_add_anon_rmap(struct page *,
+		struct mm_struct *, unsigned long addr);
+void fastcall page_update_anon_rmap(struct page *,
+		struct mm_struct *, unsigned long addr);
+void fastcall page_add_obj_rmap(struct page *);
+void fastcall page_remove_rmap(struct page *);
+
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
-void fastcall page_remove_rmap(struct page *, pte_t *);
-
 /*
  * Called from mm/vmscan.c to handle paging out
  */
--- anobjrmap3/init/main.c	2004-03-16 07:00:20.000000000 +0000
+++ anobjrmap4/init/main.c	2004-03-18 21:27:15.346558688 +0000
@@ -84,7 +84,6 @@ extern void signals_init(void);
 extern void buffer_init(void);
 extern void pidhash_init(void);
 extern void pidmap_init(void);
-extern void pte_chain_init(void);
 extern void radix_tree_init(void);
 extern void free_initmem(void);
 extern void populate_rootfs(void);
@@ -457,7 +456,6 @@ asmlinkage void __init start_kernel(void
 	calibrate_delay();
 	pidmap_init();
 	pgtable_cache_init();
-	pte_chain_init();
 #ifdef CONFIG_X86
 	if (efi_enabled)
 		efi_enter_virtual_mode();
--- anobjrmap3/mm/fremap.c	2004-03-18 21:27:03.817311400 +0000
+++ anobjrmap4/mm/fremap.c	2004-03-18 21:27:15.347558536 +0000
@@ -36,7 +36,7 @@ static inline void zap_pte(struct mm_str
 			if (!PageReserved(page)) {
 				if (pte_dirty(pte))
 					set_page_dirty(page);
-				page_remove_rmap(page, ptep);
+				page_remove_rmap(page);
 				page_cache_release(page);
 				mm->rss--;
 			}
@@ -49,7 +49,7 @@ static inline void zap_pte(struct mm_str
 }
 
 /*
- * Install a page to a given virtual memory address, release any
+ * Install a file page to a given virtual memory address, release any
  * previously existing mapping.
  */
 int install_page(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -60,11 +60,12 @@ int install_page(struct mm_struct *mm, s
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t pte_val;
-	struct pte_chain *pte_chain;
 
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain)
-		goto err;
+	/*
+	 * We use page_add_obj_rmap below: if install_page is
+	 * ever extended to anonymous pages, this will warn us.
+	 */
+	BUG_ON(!page_mapping(page));
 
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
@@ -82,7 +83,7 @@ int install_page(struct mm_struct *mm, s
 	mm->rss++;
 	flush_icache_page(vma, page);
 	set_pte(pte, mk_pte(page, prot));
-	pte_chain = page_add_rmap(page, pte, pte_chain);
+	page_add_obj_rmap(page);
 	pte_val = *pte;
 	pte_unmap(pte);
 	update_mmu_cache(vma, addr, pte_val);
@@ -90,8 +91,6 @@ int install_page(struct mm_struct *mm, s
 	err = 0;
 err_unlock:
 	spin_unlock(&mm->page_table_lock);
-	pte_chain_free(pte_chain);
-err:
 	return err;
 }
 EXPORT_SYMBOL(install_page);
--- anobjrmap3/mm/memory.c	2004-03-18 21:27:03.820310944 +0000
+++ anobjrmap4/mm/memory.c	2004-03-18 21:27:15.351557928 +0000
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
@@ -329,32 +319,8 @@ skip_copy_pte_range:
 				pte = pte_mkold(pte);
 				get_page(page);
 				dst->rss++;
-
 				set_pte(dst_pte, pte);
-				pte_chain = page_add_rmap(page, dst_pte,
-							pte_chain);
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
@@ -377,10 +343,8 @@ cont_copy_pmd_range:
 out_unlock:
 	spin_unlock(&src->page_table_lock);
 out:
-	pte_chain_free(pte_chain);
 	return 0;
 nomem:
-	pte_chain_free(pte_chain);
 	return -ENOMEM;
 }
 
@@ -421,7 +385,7 @@ zap_pte_range(struct mmu_gather *tlb, pm
 							page_mapping(page))
 						mark_page_accessed(page);
 					tlb->freed++;
-					page_remove_rmap(page, ptep);
+					page_remove_rmap(page);
 					tlb_remove_page(tlb, page);
 				}
 			}
@@ -1014,7 +978,6 @@ static int do_wp_page(struct mm_struct *
 {
 	struct page *old_page, *new_page;
 	unsigned long pfn = pte_pfn(pte);
-	struct pte_chain *pte_chain;
 	pte_t entry;
 
 	if (unlikely(!pfn_valid(pfn))) {
@@ -1039,6 +1002,14 @@ static int do_wp_page(struct mm_struct *
 			entry = maybe_mkwrite(pte_mkyoung(pte_mkdirty(pte)),
 					      vma);
 			ptep_establish(vma, address, page_table, entry);
+			if (PageAnon(old_page)) {
+				/*
+				 * Optimization: the page may have been
+				 * registered under a long defunct mm:
+				 * now we know it belongs only to this.
+				 */
+				page_update_anon_rmap(old_page, mm, address);
+			}
 			update_mmu_cache(vma, address, entry);
 			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
@@ -1053,9 +1024,6 @@ static int do_wp_page(struct mm_struct *
 	page_cache_get(old_page);
 	spin_unlock(&mm->page_table_lock);
 
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain)
-		goto no_pte_chain;
 	new_page = alloc_page(GFP_HIGHUSER);
 	if (!new_page)
 		goto no_new_page;
@@ -1069,11 +1037,11 @@ static int do_wp_page(struct mm_struct *
 	if (pte_same(*page_table, pte)) {
 		if (PageReserved(old_page))
 			++mm->rss;
-		page_remove_rmap(old_page, page_table);
+		else
+			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
-		SetPageAnon(new_page);
-		pte_chain = page_add_rmap(new_page, page_table, pte_chain);
 		lru_cache_add_active(new_page);
+		page_add_anon_rmap(new_page, mm, address);
 
 		/* Free the old page.. */
 		new_page = old_page;
@@ -1082,12 +1050,9 @@ static int do_wp_page(struct mm_struct *
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
@@ -1245,7 +1210,6 @@ static int do_swap_page(struct mm_struct
 	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 	pte_t pte;
 	int ret = VM_FAULT_MINOR;
-	struct pte_chain *pte_chain = NULL;
 
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
@@ -1275,11 +1239,6 @@ static int do_swap_page(struct mm_struct
 	}
 
 	mark_page_accessed(page);
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain) {
-		ret = VM_FAULT_OOM;
-		goto out;
-	}
 	lock_page(page);
 
 	/*
@@ -1311,15 +1270,13 @@ static int do_swap_page(struct mm_struct
 
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
-	SetPageAnon(page);
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
 
@@ -1335,20 +1292,7 @@ do_anonymous_page(struct mm_struct *mm, 
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
 
@@ -1370,7 +1314,6 @@ do_anonymous_page(struct mm_struct *mm, 
 			pte_unmap(page_table);
 			page_cache_release(page);
 			spin_unlock(&mm->page_table_lock);
-			ret = VM_FAULT_MINOR;
 			goto out;
 		}
 		mm->rss++;
@@ -1379,25 +1322,19 @@ do_anonymous_page(struct mm_struct *mm, 
 				      vma);
 		lru_cache_add_active(page);
 		mark_page_accessed(page);
-		SetPageAnon(page);
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
@@ -1419,7 +1356,6 @@ do_no_page(struct mm_struct *mm, struct 
 	struct page * new_page;
 	struct address_space *mapping = NULL;
 	pte_t entry;
-	struct pte_chain *pte_chain;
 	int sequence = 0;
 	int ret = VM_FAULT_MINOR;
 	int anon = 0;
@@ -1444,10 +1380,6 @@ retry:
 	if (new_page == NOPAGE_OOM)
 		return VM_FAULT_OOM;
 
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain)
-		goto oom;
-
 	/*
 	 * Should we do an early C-O-W break?
 	 */
@@ -1472,7 +1404,6 @@ retry:
 		sequence = atomic_read(&mapping->truncate_count);
 		spin_unlock(&mm->page_table_lock);
 		page_cache_release(new_page);
-		pte_chain_free(pte_chain);
 		goto retry;
 	}
 	page_table = pte_offset_map(pmd, address);
@@ -1497,10 +1428,10 @@ retry:
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		set_pte(page_table, entry);
 		if (anon) {
-			SetPageAnon(new_page);
 			lru_cache_add_active(new_page);
-		}
-		pte_chain = page_add_rmap(new_page, page_table, pte_chain);
+			page_add_anon_rmap(new_page, mm, address);
+		} else
+			page_add_obj_rmap(new_page);
 		pte_unmap(page_table);
 	} else {
 		/* One of our sibling threads was faster, back out. */
@@ -1518,7 +1449,6 @@ oom:
 	page_cache_release(new_page);
 	ret = VM_FAULT_OOM;
 out:
-	pte_chain_free(pte_chain);
 	return ret;
 }
 
--- anobjrmap3/mm/mremap.c	2004-03-18 21:26:52.286064416 +0000
+++ anobjrmap4/mm/mremap.c	2004-03-18 21:27:15.353557624 +0000
@@ -79,31 +79,29 @@ static inline pte_t *alloc_one_pte_map(s
 	return pte;
 }
 
-static int
+static void
 copy_one_pte(struct vm_area_struct *vma, unsigned long old_addr,
-	     pte_t *src, pte_t *dst, struct pte_chain **pte_chainp)
+	     unsigned long new_addr, pte_t *src, pte_t *dst)
 {
-	int error = 0;
 	pte_t pte;
-	struct page *page = NULL;
 
-	if (pte_present(*src))
-		page = pte_page(*src);
+	pte = ptep_clear_flush(vma, old_addr, src);
+	set_pte(dst, pte);
 
-	if (!pte_none(*src)) {
-		if (page)
-			page_remove_rmap(page, src);
-		pte = ptep_clear_flush(vma, old_addr, src);
-		if (!dst) {
-			/* No dest?  We must put it back. */
-			dst = src;
-			error++;
+	/*
+	 * This block handles a common case, but is grossly inadequate
+	 * for the general case: what if the anon page is shared with
+	 * parent or child? what if it's currently swapped out?
+	 * Return to handle mremap moving rmap in a later patch.
+	 */
+	if (pte_present(pte)) {
+		unsigned long pfn = pte_pfn(pte);
+		if (pfn_valid(pfn)) {
+			struct page *page = pfn_to_page(pfn);
+			if (PageAnon(page))
+				page_update_anon_rmap(page, vma->vm_mm, new_addr);
 		}
-		set_pte(dst, pte);
-		if (page)
-			*pte_chainp = page_add_rmap(page, dst, *pte_chainp);
 	}
-	return error;
 }
 
 static int
@@ -113,13 +111,7 @@ move_one_page(struct vm_area_struct *vma
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
@@ -140,15 +132,15 @@ move_one_page(struct vm_area_struct *vma
 		 * page_table_lock, we should re-check the src entry...
 		 */
 		if (src) {
-			error = copy_one_pte(vma, old_addr, src,
-						dst, &pte_chain);
+			if (dst)
+				copy_one_pte(vma, old_addr, new_addr, src, dst);
+			else
+				error = -ENOMEM;
 			pte_unmap_nested(src);
 		}
 		pte_unmap(dst);
 	}
 	spin_unlock(&mm->page_table_lock);
-	pte_chain_free(pte_chain);
-out:
 	return error;
 }
 
--- anobjrmap3/mm/nommu.c	2004-02-04 02:45:41.000000000 +0000
+++ anobjrmap4/mm/nommu.c	2004-03-18 21:27:15.354557472 +0000
@@ -567,7 +567,3 @@ unsigned long get_unmapped_area(struct f
 {
 	return -ENOMEM;
 }
-
-void pte_chain_init(void)
-{
-}
--- anobjrmap3/mm/page_alloc.c	2004-03-18 21:27:03.824310336 +0000
+++ anobjrmap4/mm/page_alloc.c	2004-03-18 21:27:15.356557168 +0000
@@ -83,8 +83,7 @@ static void bad_page(const char *functio
 			1 << PG_lru	|
 			1 << PG_active	|
 			1 << PG_dirty	|
-			1 << PG_chainlock |
-			1 << PG_direct    |
+			1 << PG_rmaplock  |
 			1 << PG_anon      |
 			1 << PG_swapcache |
 			1 << PG_writeback);
@@ -224,8 +223,7 @@ static inline void free_pages_check(cons
 			1 << PG_active	|
 			1 << PG_reclaim	|
 			1 << PG_slab	|
-			1 << PG_chainlock |
-			1 << PG_direct    |
+			1 << PG_rmaplock  |
 			1 << PG_anon      |
 			1 << PG_swapcache |
 			1 << PG_writeback )))
@@ -335,8 +333,7 @@ static void prep_new_page(struct page *p
 			1 << PG_active	|
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
-			1 << PG_chainlock |
-			1 << PG_direct    |
+			1 << PG_rmaplock  |
 			1 << PG_anon      |
 			1 << PG_swapcache |
 			1 << PG_writeback )))
--- anobjrmap3/mm/rmap.c	2004-03-18 21:27:03.828309728 +0000
+++ anobjrmap4/mm/rmap.c	2004-03-18 21:27:15.362556256 +0000
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
- * - the page->pte.chain is protected by the PG_chainlock bit,
- *   which nests within the the mm->page_table_lock,
+ * - the page->mapcount field is protected by the PG_rmaplock bit,
+ *   which nests within the mm->page_table_lock,
  *   which nests within the page lock.
  * - because swapout locking is opposite to the locking order
  *   in the page fault path, the swapout path uses trylocks
@@ -27,87 +24,13 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/rmap.h>
-#include <linux/cache.h>
-#include <linux/percpu.h>
-
-#include <asm/pgalloc.h>
-#include <asm/rmap.h>
-#include <asm/tlb.h>
-#include <asm/tlbflush.h>
-
-/*
- * Something oopsable to put for now in the page->mapping
- * of an anonymous page, to test that it is ignored.
- */
-#define ANON_MAPPING_DEBUG	((struct address_space *) 1)
 
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
- * offset of the highest-index used pte in ptes[].
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
@@ -198,6 +121,11 @@ page_referenced_obj_one(struct vm_area_s
 	return referenced;
 }
 
+static inline int page_referenced_anon(struct page *page)
+{
+	return 0;	/* until next patch */
+}
+
 /**
  * page_referenced_obj - referenced check for object-based rmap
  * @page: the page we're checking references on.
@@ -219,15 +147,6 @@ page_referenced_obj(struct page *page)
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
 	
@@ -248,14 +167,10 @@ page_referenced_obj(struct page *page)
  *
  * Quick test_and_clear_referenced for all mappings to a page,
  * returns the number of processes which referenced the page.
- * Caller needs to hold the pte_chain_lock.
- *
- * If the page has a single-entry pte_chain, collapse that back to a PageDirect
- * representation.  This way, it's only done under memory pressure.
+ * Caller needs to hold the rmap_lock.
  */
 int fastcall page_referenced(struct page * page)
 {
-	struct pte_chain *pc;
 	int referenced = 0;
 
 	if (page_test_and_clear_young(page))
@@ -264,194 +179,104 @@ int fastcall page_referenced(struct page
 	if (TestClearPageReferenced(page))
 		referenced++;
 
-	if (!PageAnon(page)) {
-		referenced += page_referenced_obj(page);
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
+	if (page->mapcount && page->mapping) {
+		if (PageAnon(page))
+			referenced += page_referenced_anon(page);
+		else
+			referenced += page_referenced_obj(page);
 	}
-out:
 	return referenced;
 }
 
 /**
- * page_add_rmap - add reverse mapping entry to a page
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
-
-	pte_chain_lock(page);
-
-	/*
-	 * If this is an object-based page, just count it.  We can
- 	 * find the mappings by walking the object vma chain for that object.
-	 */
-	if (!PageAnon(page)) {
-		if (PageSwapCache(page))
-			BUG();
-		if (!page->pte.mapcount)
-			inc_page_state(nr_mapped);
-		page->pte.mapcount++;
-		goto out;
-	}
-
-	page->mapping = ANON_MAPPING_DEBUG;
+	BUG_ON(PageReserved(page));
+	BUG_ON(page_mapping(page));
 
-	if (page->pte.direct == 0) {
-		page->pte.direct = pte_paddr;
-		SetPageDirect(page);
+	rmap_lock(page);
+	if (!page->mapcount) {
+		SetPageAnon(page);
+		page->index = address & PAGE_MASK;
+		page->mapping = (void *) mm;	/* until next patch */
 		inc_page_state(nr_mapped);
-		goto out;
 	}
+	page->mapcount++;
+	rmap_unlock(page);
+}
 
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
+/**
+ * page_update_anon_rmap - move pte mapping of an anonymous page
+ * @page:	the page to update the mapping of
+ * @mm:		the new mm in which the mapping is found
+ * @address:	the new user virtual address mapped
+ *
+ * The caller needs to hold the mm->page_table_lock.
+ *
+ * For do_wp_page: to update mapping to the one remaining mm.
+ * For copy_one_pte: to update address when vma is mremapped.
+ */
+void fastcall page_update_anon_rmap(struct page *page,
+	struct mm_struct *mm, unsigned long address)
+{
+	BUG_ON(!PageAnon(page));
+	if (page->mapcount != 1)
+		return;
 
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
-	pte_chain_unlock(page);
-	return pte_chain;
+	rmap_lock(page);
+	page->index = address & PAGE_MASK;
+	page->mapping = (void *) mm;	/* until next patch */
+	rmap_unlock(page);
 }
 
 /**
- * page_remove_rmap - take down reverse mapping to a page
- * @page: page to remove mapping from
- * @ptep: page table entry to remove
+ * page_add_obj_rmap - add pte mapping to a file page
+ * @page: the page to add the mapping to
  *
- * Removes the reverse mapping from the pte_chain of the page,
- * after that the caller can clear the page table entry and free
- * the page.
- * Caller needs to hold the mm->page_table_lock.
+ * The caller needs to hold the mm->page_table_lock.
  */
-void fastcall page_remove_rmap(struct page *page, pte_t *ptep)
+void fastcall page_add_obj_rmap(struct page *page)
 {
-	pte_addr_t pte_paddr = ptep_to_paddr(ptep);
-	struct pte_chain *pc;
-
+	BUG_ON(PageAnon(page));
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
 		return;
 
-	pte_chain_lock(page);
+	rmap_lock(page);
+	if (!page->mapcount)
+		inc_page_state(nr_mapped);
+	page->mapcount++;
+	rmap_unlock(page);
+}
 
-	if (!page_mapped(page))
-		goto out_unlock;
+/**
+ * page_remove_rmap - take down pte mapping from a page
+ * @page: page to remove mapping from
+ *
+ * Caller needs to hold the mm->page_table_lock.
+ */
+void fastcall page_remove_rmap(struct page *page)
+{
+	BUG_ON(PageReserved(page));
+	BUG_ON(!page->mapcount);
 
-	/*
-	 * If this is an object-based page, just uncount it.  We can
-	 * find the mappings by walking the object vma chain for that object.
-	 */
-	if (!PageAnon(page)) {
-		if (PageSwapCache(page))
-			BUG();
-		page->pte.mapcount--;
-		goto out;
-	}
-  
-	if (PageDirect(page)) {
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
+	rmap_lock(page);
+	page->mapcount--;
+	if (!page->mapcount) {
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
 		if (PageAnon(page))
 			clear_page_anon(page);
 		dec_page_state(nr_mapped);
 	}
-out_unlock:
-	pte_chain_unlock(page);
-	return;
+	rmap_unlock(page);
 }
 
 /**
@@ -489,11 +314,9 @@ try_to_unmap_obj_one(struct vm_area_stru
 	if (pte_dirty(pteval))
 		set_page_dirty(page);
 
-	if (!page->pte.mapcount)
-		BUG();
-
 	mm->rss--;
-	page->pte.mapcount--;
+	BUG_ON(!page->mapcount);
+	page->mapcount--;
 	page_cache_release(page);
 
 out_unmap:
@@ -504,6 +327,11 @@ out:
 	return ret;
 }
 
+static inline int try_to_unmap_anon(struct page *page)
+{
+	return SWAP_FAIL;	/* until next patch */
+}
+
 /**
  * try_to_unmap_obj - unmap a page using the object-based rmap method
  * @page: the page to unmap
@@ -523,24 +351,18 @@ try_to_unmap_obj(struct page *page)
 	struct vm_area_struct *vma;
 	int ret = SWAP_AGAIN;
 
-	if (!mapping)
-		BUG();
-
-	if (PageSwapCache(page))
-		BUG();
-
 	if (down_trylock(&mapping->i_shared_sem))
 		return ret;
 	
 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
 		ret = try_to_unmap_obj_one(vma, page);
-		if (ret == SWAP_FAIL || !page->pte.mapcount)
+		if (ret == SWAP_FAIL || !page->mapcount)
 			goto out;
 	}
 
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
 		ret = try_to_unmap_obj_one(vma, page);
-		if (ret == SWAP_FAIL || !page->pte.mapcount)
+		if (ret == SWAP_FAIL || !page->mapcount)
 			goto out;
 	}
 
@@ -550,103 +372,12 @@ out:
 }
 
 /**
- * try_to_unmap_one - worker function for try_to_unmap
- * @page: page to unmap
- * @ptep: page table entry to unmap from page
- *
- * Internal helper function for try_to_unmap, called for each page
- * table entry mapping a page. Because locking order here is opposite
- * to the locking order used by the page fault path, we use trylocks.
- * Locking:
- *	    page lock			shrink_list(), trylock
- *		pte_chain_lock		shrink_list()
- *		    mm->page_table_lock	try_to_unmap_one(), trylock
- */
-static int fastcall try_to_unmap_one(struct page * page, pte_addr_t paddr)
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
-
-	/* During mremap, it's possible pages are not in a VMA. */
-	vma = find_vma(mm, address);
-	if (!vma) {
-		ret = SWAP_FAIL;
-		goto out_unlock;
-	}
-
-	/* The page is mlock()d, we cannot swap it out. */
-	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
-		ret = SWAP_FAIL;
-		goto out_unlock;
-	}
-
-	/* Nuke the page table entry. */
-	flush_cache_page(vma, address);
-	pte = ptep_clear_flush(vma, address, ptep);
-
-	if (PageAnon(page)) {
-		swp_entry_t entry = { .val = page->private };
-		/*
-		 * Store the swap location in the pte.
-		 * See handle_pte_fault() ...
-		 */
-		BUG_ON(!PageSwapCache(page));
-		swap_duplicate(entry);
-		set_pte(ptep, swp_entry_to_pte(entry));
-		BUG_ON(pte_file(*ptep));
-	} else {
-		unsigned long pgidx;
-		/*
-		 * If a nonlinear mapping then store the file page offset
-		 * in the pte.
-		 */
-		pgidx = (address - vma->vm_start) >> PAGE_SHIFT;
-		pgidx += vma->vm_pgoff;
-		pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
-		if (page->index != pgidx) {
-			set_pte(ptep, pgoff_to_pte(page->index));
-			BUG_ON(!pte_file(*ptep));
-		}
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
-
-/**
  * try_to_unmap - try to remove all page table mappings to a page
  * @page: the page to get unmapped
  *
  * Tries to remove all the page table entries which are mapping this
  * page, used in the pageout path.  Caller must hold the page lock
- * and its pte chain lock.  Return values are:
+ * and its rmap_lock.  Return values are:
  *
  * SWAP_SUCCESS	- we succeeded in removing all mappings
  * SWAP_AGAIN	- we missed a trylock, try again later
@@ -654,80 +385,18 @@ out_unlock:
  */
 int fastcall try_to_unmap(struct page * page)
 {
-	struct pte_chain *pc, *next_pc, *start;
-	int ret = SWAP_SUCCESS;
-	int victim_i;
-
-	/* This page should not be on the pageout lists. */
-	if (PageReserved(page))
-		BUG();
-	if (!PageLocked(page))
-		BUG();
-	/* We need backing store to swap out a page. */
-	if (!page_mapping(page) && !PageSwapCache(page))
-		BUG();
-
-	/*
-	 * If it's an object-based page, use the object vma chain to find all
-	 * the mappings.
-	 */
-	if (!PageAnon(page)) {
-		ret = try_to_unmap_obj(page);
-		goto out;
-	}
+	int ret;
 
-	if (PageDirect(page)) {
-		ret = try_to_unmap_one(page, page->pte.direct);
-		if (ret == SWAP_SUCCESS) {
-			page->pte.direct = 0;
-			ClearPageDirect(page);
-		}
-		goto out;
-	}		
+	BUG_ON(PageReserved(page));
+	BUG_ON(!PageLocked(page));
+	BUG_ON(!page->mapcount);
+
+	if (PageAnon(page))
+		ret = try_to_unmap_anon(page);
+	else
+		ret = try_to_unmap_obj(page);
 
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
@@ -737,76 +406,3 @@ out:
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
-						0,
-						SLAB_MUST_HWCACHE_ALIGN,
-						pte_chain_ctor,
-						NULL);
-
-	if (!pte_chain_cache)
-		panic("failed to create pte_chain cache!\n");
-}
--- anobjrmap3/mm/swapfile.c	2004-03-18 21:27:03.832309120 +0000
+++ anobjrmap4/mm/swapfile.c	2004-03-18 21:27:15.365555800 +0000
@@ -391,20 +391,19 @@ void free_swap_and_cache(swp_entry_t ent
 /* vma->vm_mm->page_table_lock is held */
 static void
 unuse_pte(struct vm_area_struct *vma, unsigned long address, pte_t *dir,
-	swp_entry_t entry, struct page *page, struct pte_chain **pte_chainp)
+	swp_entry_t entry, struct page *page)
 {
 	vma->vm_mm->rss++;
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
-	SetPageAnon(page);
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
@@ -429,8 +428,7 @@ static int unuse_pmd(struct vm_area_stru
 		 * Test inline before going to call unuse_pte.
 		 */
 		if (unlikely(pte_same(*pte, swp_pte))) {
-			unuse_pte(vma, offset + address, pte,
-					entry, page, pte_chainp);
+			unuse_pte(vma, offset + address, pte, entry, page);
 			pte_unmap(pte);
 			return 1;
 		}
@@ -444,7 +442,7 @@ static int unuse_pmd(struct vm_area_stru
 /* vma->vm_mm->page_table_lock is held */
 static int unuse_pgd(struct vm_area_struct * vma, pgd_t *dir,
 	unsigned long address, unsigned long size,
-	swp_entry_t entry, struct page *page, struct pte_chain **pte_chainp)
+	swp_entry_t entry, struct page *page)
 {
 	pmd_t * pmd;
 	unsigned long offset, end;
@@ -466,7 +464,7 @@ static int unuse_pgd(struct vm_area_stru
 		BUG();
 	do {
 		if (unuse_pmd(vma, pmd, address, end - address,
-				offset, entry, page, pte_chainp))
+				offset, entry, page))
 			return 1;
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
@@ -476,15 +474,14 @@ static int unuse_pgd(struct vm_area_stru
 
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
@@ -492,15 +489,10 @@ static int unuse_vma(struct vm_area_stru
 	return 0;
 }
 
-static int unuse_process(struct mm_struct * mm,
+static void unuse_process(struct mm_struct * mm,
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
@@ -508,12 +500,10 @@ static int unuse_process(struct mm_struc
 	spin_lock(&mm->page_table_lock);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		pgd_t * pgd = pgd_offset(mm, vma->vm_start);
-		if (unuse_vma(vma, pgd, entry, page, &pte_chain))
+		if (unuse_vma(vma, pgd, entry, page))
 			break;
 	}
 	spin_unlock(&mm->page_table_lock);
-	pte_chain_free(pte_chain);
-	return 0;
 }
 
 /*
@@ -661,7 +651,7 @@ static int try_to_unuse(unsigned int typ
 			if (start_mm == &init_mm)
 				shmem = shmem_unuse(entry, page);
 			else
-				retval = unuse_process(start_mm, entry, page);
+				unuse_process(start_mm, entry, page);
 		}
 		if (*swap_map > 1) {
 			int set_start_mm = (*swap_map >= swcount);
@@ -673,7 +663,7 @@ static int try_to_unuse(unsigned int typ
 			atomic_inc(&new_start_mm->mm_users);
 			atomic_inc(&prev_mm->mm_users);
 			spin_lock(&mmlist_lock);
-			while (*swap_map > 1 && !retval &&
+			while (*swap_map > 1 &&
 					(p = p->next) != &start_mm->mmlist) {
 				mm = list_entry(p, struct mm_struct, mmlist);
 				atomic_inc(&mm->mm_users);
@@ -690,7 +680,7 @@ static int try_to_unuse(unsigned int typ
 					set_start_mm = 1;
 					shmem = shmem_unuse(entry, page);
 				} else
-					retval = unuse_process(mm, entry, page);
+					unuse_process(mm, entry, page);
 				if (set_start_mm && *swap_map < swcount) {
 					mmput(new_start_mm);
 					atomic_inc(&mm->mm_users);
@@ -704,11 +694,6 @@ static int try_to_unuse(unsigned int typ
 			mmput(start_mm);
 			start_mm = new_start_mm;
 		}
-		if (retval) {
-			unlock_page(page);
-			page_cache_release(page);
-			break;
-		}
 
 		/*
 		 * How could swap count reach 0x7fff when the maximum
--- anobjrmap3/mm/vmscan.c	2004-03-18 21:27:03.835308664 +0000
+++ anobjrmap4/mm/vmscan.c	2004-03-18 21:27:15.367555496 +0000
@@ -171,7 +171,7 @@ static int shrink_slab(unsigned long sca
 	return 0;
 }
 
-/* Must be called with page's pte_chain_lock held. */
+/* Must be called with page's rmap_lock held. */
 static inline int page_mapping_inuse(struct page *page)
 {
 	struct address_space *mapping;
@@ -275,11 +275,11 @@ shrink_list(struct list_head *page_list,
 		if (PageWriteback(page))
 			goto keep_locked;
 
-		pte_chain_lock(page);
+		rmap_lock(page);
 		referenced = page_referenced(page);
 		if (referenced && page_mapping_inuse(page)) {
 			/* In active use or really unfreeable.  Activate it. */
-			pte_chain_unlock(page);
+			rmap_unlock(page);
 			goto activate_locked;
 		}
 
@@ -295,10 +295,10 @@ shrink_list(struct list_head *page_list,
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
@@ -313,16 +313,16 @@ shrink_list(struct list_head *page_list,
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
@@ -660,13 +660,13 @@ refill_inactive_zone(struct zone *zone, 
 				list_add(&page->lru, &l_active);
 				continue;
 			}
-			pte_chain_lock(page);
+			rmap_lock(page);
 			if (page_referenced(page)) {
-				pte_chain_unlock(page);
+				rmap_unlock(page);
 				list_add(&page->lru, &l_active);
 				continue;
 			}
-			pte_chain_unlock(page);
+			rmap_unlock(page);
 		}
 		/*
 		 * FIXME: need to consider page_count(page) here if/when we

