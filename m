Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263329AbUCRX1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbUCRXZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:25:50 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:62275 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263308AbUCRXVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:21:16 -0500
Date: Thu, 18 Mar 2004 23:21:07 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <Pine.LNX.4.44.0403182317050.16911-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of six patches implementing full object-based rmap over 2.6.5-rc1,
reviving my anonmm method to compare against Andrea's anon_vma method.
I've not yet implemented Linus' early-COW solution to the mremap move
issue, that will follow; handling of non-linear obj vmas also to follow.
Sorry, not yet checked against wli's tree, he may have some fixes to it.

anobjrmap 1/6 Dave McCracken's objrmap

Start with Dave McCracken's objrmap from Martin J. Bligh's tree, as did
Andrea.  We've each diverged slightly: I've not bothered to include the
filemap.c locking comment, just to remove it again later; and I've not
included the page_table_lock avoidance from mmap.c - I don't see how it
can be safe to unlink a vma while try_to_unmap might be in find_vma
(but that may be fine in Andrea's, which ends up not using find_vma).
In rmap.c: I've not seen the problem which led Andrea to change try
failures from 1 to 0; fixed three comment typos, positioning of
page_test_and_clear_dirty calls, and use ptep_clear_flush.

 fs/exec.c                  |    1 
 include/linux/mm.h         |    1 
 include/linux/page-flags.h |    5 
 include/linux/swap.h       |    2 
 mm/fremap.c                |   21 ++
 mm/memory.c                |    8 
 mm/page_alloc.c            |    2 
 mm/rmap.c                  |  390 +++++++++++++++++++++++++++++++++++++++++++--
 mm/swapfile.c              |    1 
 9 files changed, 417 insertions(+), 14 deletions(-)

--- 2.6.5-rc1/fs/exec.c	2004-03-11 01:56:08.000000000 +0000
+++ anobjrmap1/fs/exec.c	2004-03-18 21:26:40.786812568 +0000
@@ -324,6 +324,7 @@ void put_dirty_page(struct task_struct *
 	}
 	lru_cache_add_active(page);
 	flush_dcache_page(page);
+	SetPageAnon(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, prot))));
 	pte_chain = page_add_rmap(page, pte, pte_chain);
 	pte_unmap(pte);
--- 2.6.5-rc1/include/linux/mm.h	2004-03-11 01:56:06.000000000 +0000
+++ anobjrmap1/include/linux/mm.h	2004-03-18 21:26:40.787812416 +0000
@@ -180,6 +180,7 @@ struct page {
 		struct pte_chain *chain;/* Reverse pte mapping pointer.
 					 * protected by PG_chainlock */
 		pte_addr_t direct;
+		int mapcount;
 	} pte;
 	unsigned long private;		/* mapping-private opaque data */
 
--- 2.6.5-rc1/include/linux/page-flags.h	2004-03-16 07:00:20.000000000 +0000
+++ anobjrmap1/include/linux/page-flags.h	2004-03-18 21:26:40.789812112 +0000
@@ -75,6 +75,7 @@
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
+#define PG_anon			20	/* Anonymous page */
 
 
 /*
@@ -301,6 +302,10 @@ extern void get_full_page_state(struct p
 #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
 #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
 
+#define PageAnon(page)		test_bit(PG_anon, &(page)->flags)
+#define SetPageAnon(page)	set_bit(PG_anon, &(page)->flags)
+#define ClearPageAnon(page)	clear_bit(PG_anon, &(page)->flags)
+
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
  * but it may again do so one day.
--- 2.6.5-rc1/include/linux/swap.h	2004-02-04 02:45:16.000000000 +0000
+++ anobjrmap1/include/linux/swap.h	2004-03-18 21:26:40.790811960 +0000
@@ -185,6 +185,8 @@ struct pte_chain *FASTCALL(page_add_rmap
 void FASTCALL(page_remove_rmap(struct page *, pte_t *));
 int FASTCALL(try_to_unmap(struct page *));
 
+int page_convert_anon(struct page *);
+
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
 #else
--- 2.6.5-rc1/mm/fremap.c	2004-03-11 01:56:06.000000000 +0000
+++ anobjrmap1/mm/fremap.c	2004-03-18 21:26:40.791811808 +0000
@@ -61,10 +61,26 @@ int install_page(struct mm_struct *mm, s
 	pmd_t *pmd;
 	pte_t pte_val;
 	struct pte_chain *pte_chain;
+	unsigned long pgidx;
 
 	pte_chain = pte_chain_alloc(GFP_KERNEL);
 	if (!pte_chain)
 		goto err;
+
+	/*
+	 * Convert this page to anon for objrmap if it's nonlinear
+	 */
+	pgidx = (addr - vma->vm_start) >> PAGE_SHIFT;
+	pgidx += vma->vm_pgoff;
+	pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
+	if (!PageAnon(page) && (page->index != pgidx)) {
+		lock_page(page);
+		err = page_convert_anon(page);
+		unlock_page(page);
+		if (err < 0)
+			goto err_free;
+	}
+
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
 
@@ -85,12 +101,11 @@ int install_page(struct mm_struct *mm, s
 	pte_val = *pte;
 	pte_unmap(pte);
 	update_mmu_cache(vma, addr, pte_val);
-	spin_unlock(&mm->page_table_lock);
-	pte_chain_free(pte_chain);
-	return 0;
 
+	err = 0;
 err_unlock:
 	spin_unlock(&mm->page_table_lock);
+err_free:
 	pte_chain_free(pte_chain);
 err:
 	return err;
--- 2.6.5-rc1/mm/memory.c	2004-03-16 07:00:20.000000000 +0000
+++ anobjrmap1/mm/memory.c	2004-03-18 21:26:40.794811352 +0000
@@ -1071,6 +1071,7 @@ static int do_wp_page(struct mm_struct *
 			++mm->rss;
 		page_remove_rmap(old_page, page_table);
 		break_cow(vma, new_page, address, page_table);
+		SetPageAnon(new_page);
 		pte_chain = page_add_rmap(new_page, page_table, pte_chain);
 		lru_cache_add_active(new_page);
 
@@ -1310,6 +1311,7 @@ static int do_swap_page(struct mm_struct
 
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
+	SetPageAnon(page);
 	pte_chain = page_add_rmap(page, page_table, pte_chain);
 
 	/* No need to invalidate - it was non-present before */
@@ -1377,6 +1379,7 @@ do_anonymous_page(struct mm_struct *mm, 
 				      vma);
 		lru_cache_add_active(page);
 		mark_page_accessed(page);
+		SetPageAnon(page);
 	}
 
 	set_pte(page_table, entry);
@@ -1444,6 +1447,10 @@ retry:
 	if (!pte_chain)
 		goto oom;
 
+	/* See if nopage returned an anon page */
+	if (!new_page->mapping || PageSwapCache(new_page))
+		SetPageAnon(new_page);
+
 	/*
 	 * Should we do an early C-O-W break?
 	 */
@@ -1454,6 +1461,7 @@ retry:
 		copy_user_highpage(page, new_page, address);
 		page_cache_release(new_page);
 		lru_cache_add_active(page);
+		SetPageAnon(page);
 		new_page = page;
 	}
 
--- 2.6.5-rc1/mm/page_alloc.c	2004-03-16 07:00:20.000000000 +0000
+++ anobjrmap1/mm/page_alloc.c	2004-03-18 21:26:40.796811048 +0000
@@ -224,6 +224,8 @@ static inline void free_pages_check(cons
 		bad_page(function, page);
 	if (PageDirty(page))
 		ClearPageDirty(page);
+	if (PageAnon(page))
+		ClearPageAnon(page);
 }
 
 /*
--- 2.6.5-rc1/mm/rmap.c	2004-03-11 01:56:12.000000000 +0000
+++ anobjrmap1/mm/rmap.c	2004-03-18 21:26:40.800810440 +0000
@@ -102,6 +102,136 @@ pte_chain_encode(struct pte_chain *pte_c
  **/
 
 /**
+ * find_pte - Find a pte pointer given a vma and a struct page.
+ * @vma: the vma to search
+ * @page: the page to find
+ *
+ * Determine if this page is mapped in this vma.  If it is, map and return
+ * the pte pointer associated with it.  Return null if the page is not
+ * mapped in this vma for any reason.
+ *
+ * This is strictly an internal helper function for the object-based rmap
+ * functions.
+ * 
+ * It is the caller's responsibility to unmap the pte if it is returned.
+ */
+static inline pte_t *
+find_pte(struct vm_area_struct *vma, struct page *page, unsigned long *addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	unsigned long loffset;
+	unsigned long address;
+
+	loffset = (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
+	address = vma->vm_start + ((loffset - vma->vm_pgoff) << PAGE_SHIFT);
+	if (address < vma->vm_start || address >= vma->vm_end)
+		goto out;
+
+	pgd = pgd_offset(mm, address);
+	if (!pgd_present(*pgd))
+		goto out;
+
+	pmd = pmd_offset(pgd, address);
+	if (!pmd_present(*pmd))
+		goto out;
+
+	pte = pte_offset_map(pmd, address);
+	if (!pte_present(*pte))
+		goto out_unmap;
+
+	if (page_to_pfn(page) != pte_pfn(*pte))
+		goto out_unmap;
+
+	if (addr)
+		*addr = address;
+
+	return pte;
+
+out_unmap:
+	pte_unmap(pte);
+out:
+	return NULL;
+}
+
+/**
+ * page_referenced_obj_one - referenced check for object-based rmap
+ * @vma: the vma to look in.
+ * @page: the page we're working on.
+ *
+ * Find a pte entry for a page/vma pair, then check and clear the referenced
+ * bit.
+ *
+ * This is strictly a helper function for page_referenced_obj.
+ */
+static int
+page_referenced_obj_one(struct vm_area_struct *vma, struct page *page)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pte_t *pte;
+	int referenced = 0;
+
+	if (!spin_trylock(&mm->page_table_lock))
+		return 1;
+
+	pte = find_pte(vma, page, NULL);
+	if (pte) {
+		if (ptep_test_and_clear_young(pte))
+			referenced++;
+		pte_unmap(pte);
+	}
+
+	spin_unlock(&mm->page_table_lock);
+	return referenced;
+}
+
+/**
+ * page_referenced_obj - referenced check for object-based rmap
+ * @page: the page we're checking references on.
+ *
+ * For an object-based mapped page, find all the places it is mapped and
+ * check/clear the referenced flag.  This is done by following the page->mapping
+ * pointer, then walking the chain of vmas it holds.  It returns the number
+ * of references it found.
+ *
+ * This function is only called from page_referenced for object-based pages.
+ *
+ * The semaphore address_space->i_shared_sem is tried.  If it can't be gotten,
+ * assume a reference count of 1.
+ */
+static int
+page_referenced_obj(struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+	struct vm_area_struct *vma;
+	int referenced = 0;
+
+	if (!page->pte.mapcount)
+		return 0;
+
+	if (!mapping)
+		BUG();
+
+	if (PageSwapCache(page))
+		BUG();
+
+	if (down_trylock(&mapping->i_shared_sem))
+		return 1;
+	
+	list_for_each_entry(vma, &mapping->i_mmap, shared)
+		referenced += page_referenced_obj_one(vma, page);
+
+	list_for_each_entry(vma, &mapping->i_mmap_shared, shared)
+		referenced += page_referenced_obj_one(vma, page);
+
+	up(&mapping->i_shared_sem);
+
+	return referenced;
+}
+
+/**
  * page_referenced - test if the page was referenced
  * @page: the page to test
  *
@@ -123,6 +253,10 @@ int fastcall page_referenced(struct page
 	if (TestClearPageReferenced(page))
 		referenced++;
 
+	if (!PageAnon(page)) {
+		referenced += page_referenced_obj(page);
+		goto out;
+	}
 	if (PageDirect(page)) {
 		pte_t *pte = rmap_ptep_map(page->pte.direct);
 		if (ptep_test_and_clear_young(pte))
@@ -154,6 +288,7 @@ int fastcall page_referenced(struct page
 			__pte_chain_free(pc);
 		}
 	}
+out:
 	return referenced;
 }
 
@@ -176,6 +311,21 @@ page_add_rmap(struct page *page, pte_t *
 
 	pte_chain_lock(page);
 
+	/*
+	 * If this is an object-based page, just count it.  We can
+ 	 * find the mappings by walking the object vma chain for that object.
+	 */
+	if (!PageAnon(page)) {
+		if (!page->mapping)
+			BUG();
+		if (PageSwapCache(page))
+			BUG();
+		if (!page->pte.mapcount)
+			inc_page_state(nr_mapped);
+		page->pte.mapcount++;
+		goto out;
+	}
+
 	if (page->pte.direct == 0) {
 		page->pte.direct = pte_paddr;
 		SetPageDirect(page);
@@ -232,8 +382,21 @@ void fastcall page_remove_rmap(struct pa
 	pte_chain_lock(page);
 
 	if (!page_mapped(page))
-		goto out_unlock;	/* remap_page_range() from a driver? */
+		goto out_unlock;
 
+	/*
+	 * If this is an object-based page, just uncount it.  We can
+	 * find the mappings by walking the object vma chain for that object.
+	 */
+	if (!PageAnon(page)) {
+		if (!page->mapping)
+			BUG();
+		if (PageSwapCache(page))
+			BUG();
+		page->pte.mapcount--;
+		goto out;
+	}
+  
 	if (PageDirect(page)) {
 		if (page->pte.direct == pte_paddr) {
 			page->pte.direct = 0;
@@ -270,16 +433,112 @@ void fastcall page_remove_rmap(struct pa
 		}
 	}
 out:
-	if (page->pte.direct == 0 && page_test_and_clear_dirty(page))
-		set_page_dirty(page);
-	if (!page_mapped(page))
+	if (!page_mapped(page)) {
+		if (page_test_and_clear_dirty(page))
+			set_page_dirty(page);
 		dec_page_state(nr_mapped);
+	}
 out_unlock:
 	pte_chain_unlock(page);
 	return;
 }
 
 /**
+ * try_to_unmap_obj_one - unmap a page using the object-based rmap method
+ * @page: the page to unmap
+ *
+ * Determine whether a page is mapped in a given vma and unmap it if it's found.
+ *
+ * This function is strictly a helper function for try_to_unmap_obj.
+ */
+static inline int
+try_to_unmap_obj_one(struct vm_area_struct *vma, struct page *page)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long address;
+	pte_t *pte;
+	pte_t pteval;
+	int ret = SWAP_AGAIN;
+
+	if (!spin_trylock(&mm->page_table_lock))
+		return ret;
+
+	pte = find_pte(vma, page, &address);
+	if (!pte)
+		goto out;
+
+	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
+		ret =  SWAP_FAIL;
+		goto out_unmap;
+	}
+
+	flush_cache_page(vma, address);
+	pteval = ptep_clear_flush(vma, address, pte);
+
+	if (pte_dirty(pteval))
+		set_page_dirty(page);
+
+	if (!page->pte.mapcount)
+		BUG();
+
+	mm->rss--;
+	page->pte.mapcount--;
+	page_cache_release(page);
+
+out_unmap:
+	pte_unmap(pte);
+
+out:
+	spin_unlock(&mm->page_table_lock);
+	return ret;
+}
+
+/**
+ * try_to_unmap_obj - unmap a page using the object-based rmap method
+ * @page: the page to unmap
+ *
+ * Find all the mappings of a page using the mapping pointer and the vma chains
+ * contained in the address_space struct it points to.
+ *
+ * This function is only called from try_to_unmap for object-based pages.
+ *
+ * The semaphore address_space->i_shared_sem is tried.  If it can't be gotten,
+ * return a temporary error.
+ */
+static int
+try_to_unmap_obj(struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+	struct vm_area_struct *vma;
+	int ret = SWAP_AGAIN;
+
+	if (!mapping)
+		BUG();
+
+	if (PageSwapCache(page))
+		BUG();
+
+	if (down_trylock(&mapping->i_shared_sem))
+		return ret;
+	
+	list_for_each_entry(vma, &mapping->i_mmap, shared) {
+		ret = try_to_unmap_obj_one(vma, page);
+		if (ret == SWAP_FAIL || !page->pte.mapcount)
+			goto out;
+	}
+
+	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+		ret = try_to_unmap_obj_one(vma, page);
+		if (ret == SWAP_FAIL || !page->pte.mapcount)
+			goto out;
+	}
+
+out:
+	up(&mapping->i_shared_sem);
+	return ret;
+}
+
+/**
  * try_to_unmap_one - worker function for try_to_unmap
  * @page: page to unmap
  * @ptep: page table entry to unmap from page
@@ -323,7 +582,7 @@ static int fastcall try_to_unmap_one(str
 	}
 
 	/* The page is mlock()d, we cannot swap it out. */
-	if (vma->vm_flags & VM_LOCKED) {
+	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
 		ret = SWAP_FAIL;
 		goto out_unlock;
 	}
@@ -397,11 +656,18 @@ int fastcall try_to_unmap(struct page * 
 	if (!page->mapping)
 		BUG();
 
+	/*
+	 * If it's an object-based page, use the object vma chain to find all
+	 * the mappings.
+	 */
+	if (!PageAnon(page)) {
+		ret = try_to_unmap_obj(page);
+		goto out;
+	}
+
 	if (PageDirect(page)) {
 		ret = try_to_unmap_one(page, page->pte.direct);
 		if (ret == SWAP_SUCCESS) {
-			if (page_test_and_clear_dirty(page))
-				set_page_dirty(page);
 			page->pte.direct = 0;
 			ClearPageDirect(page);
 		}
@@ -438,9 +704,6 @@ int fastcall try_to_unmap(struct page * 
 				} else {
 					start->next_and_idx++;
 				}
-				if (page->pte.direct == 0 &&
-				    page_test_and_clear_dirty(page))
-					set_page_dirty(page);
 				break;
 			case SWAP_AGAIN:
 				/* Skip this pte, remembering status. */
@@ -453,12 +716,117 @@ int fastcall try_to_unmap(struct page * 
 		}
 	}
 out:
-	if (!page_mapped(page))
+	if (!page_mapped(page)) {
+		if (page_test_and_clear_dirty(page))
+			set_page_dirty(page);
 		dec_page_state(nr_mapped);
+		ret = SWAP_SUCCESS;
+	}
 	return ret;
 }
 
 /**
+ * page_convert_anon - Convert an object-based mapped page to pte_chain-based.
+ * @page: the page to convert
+ *
+ * Find all the mappings for an object-based page and convert them
+ * to 'anonymous', ie create a pte_chain and store all the pte pointers there.
+ *
+ * This function takes the address_space->i_shared_sem, sets the PageAnon flag,
+ * then sets the mm->page_table_lock for each vma and calls page_add_rmap. This
+ * means there is a period when PageAnon is set, but still has some mappings
+ * with no pte_chain entry.  This is in fact safe, since page_remove_rmap will
+ * simply not find it.  try_to_unmap might erroneously return success, but it
+ * will never be called because the page_convert_anon() caller has locked the
+ * page.
+ *
+ * page_referenced() may fail to scan all the appropriate pte's and may return
+ * an inaccurate result.  This is so rare that it does not matter.
+ */
+int page_convert_anon(struct page *page)
+{
+	struct address_space *mapping;
+	struct vm_area_struct *vma;
+	struct pte_chain *pte_chain = NULL;
+	pte_t *pte;
+	int err = 0;
+
+	mapping = page->mapping;
+	if (mapping == NULL)
+		goto out;		/* truncate won the lock_page() race */
+
+	down(&mapping->i_shared_sem);
+	pte_chain_lock(page);
+
+	/*
+	 * Has someone else done it for us before we got the lock?
+	 * If so, pte.direct or pte.chain has replaced pte.mapcount.
+	 */
+	if (PageAnon(page)) {
+		pte_chain_unlock(page);
+		goto out_unlock;
+	}
+
+	SetPageAnon(page);
+	if (page->pte.mapcount == 0) {
+		pte_chain_unlock(page);
+		goto out_unlock;
+	}
+	/* This is gonna get incremented by page_add_rmap */
+	dec_page_state(nr_mapped);
+	page->pte.mapcount = 0;
+
+	/*
+	 * Now that the page is marked as anon, unlock it.  page_add_rmap will
+	 * lock it as necessary.
+	 */
+	pte_chain_unlock(page);
+
+	list_for_each_entry(vma, &mapping->i_mmap, shared) {
+		if (!pte_chain) {
+			pte_chain = pte_chain_alloc(GFP_KERNEL);
+			if (!pte_chain) {
+				err = -ENOMEM;
+				goto out_unlock;
+			}
+		}
+		spin_lock(&vma->vm_mm->page_table_lock);
+		pte = find_pte(vma, page, NULL);
+		if (pte) {
+			/* Make sure this isn't a duplicate */
+			page_remove_rmap(page, pte);
+			pte_chain = page_add_rmap(page, pte, pte_chain);
+			pte_unmap(pte);
+		}
+		spin_unlock(&vma->vm_mm->page_table_lock);
+	}
+	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+		if (!pte_chain) {
+			pte_chain = pte_chain_alloc(GFP_KERNEL);
+			if (!pte_chain) {
+				err = -ENOMEM;
+				goto out_unlock;
+			}
+		}
+		spin_lock(&vma->vm_mm->page_table_lock);
+		pte = find_pte(vma, page, NULL);
+		if (pte) {
+			/* Make sure this isn't a duplicate */
+			page_remove_rmap(page, pte);
+			pte_chain = page_add_rmap(page, pte, pte_chain);
+			pte_unmap(pte);
+		}
+		spin_unlock(&vma->vm_mm->page_table_lock);
+	}
+
+out_unlock:
+	pte_chain_free(pte_chain);
+	up(&mapping->i_shared_sem);
+out:
+	return err;
+}
+
+/**
  ** No more VM stuff below this comment, only pte_chain helper
  ** functions.
  **/
--- 2.6.5-rc1/mm/swapfile.c	2004-03-16 07:00:20.000000000 +0000
+++ anobjrmap1/mm/swapfile.c	2004-03-18 21:26:40.802810136 +0000
@@ -390,6 +390,7 @@ unuse_pte(struct vm_area_struct *vma, un
 	vma->vm_mm->rss++;
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
+	SetPageAnon(page);
 	*pte_chainp = page_add_rmap(page, dir, *pte_chainp);
 	swap_free(entry);
 }

