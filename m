Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263645AbUERWMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUERWMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 18:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263673AbUERWMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 18:12:13 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:18421 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263645AbUERWKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 18:10:23 -0400
Date: Tue, 18 May 2004 23:10:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 38 remove anonmm rmap
In-Reply-To: <Pine.LNX.4.44.0405182304150.3416-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405182309030.3416-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before moving on to anon_vma rmap, remove now what's peculiar to anonmm
rmap: the anonmm handling and the mremap move cows.  Temporarily reduce
page_referenced_anon and try_to_unmap_anon to stubs, so a kernel built
with this patch will not swap anonymous at all.

 include/linux/page-flags.h |    2 
 include/linux/rmap.h       |   53 ---------
 include/linux/sched.h      |    1 
 kernel/fork.c              |   13 --
 mm/memory.c                |    2 
 mm/mremap.c                |   51 +--------
 mm/rmap.c                  |  250 ---------------------------------------------
 mm/swapfile.c              |    9 -
 8 files changed, 18 insertions(+), 363 deletions(-)

--- rmap37/include/linux/page-flags.h	2004-05-16 11:39:21.000000000 +0100
+++ rmap38/include/linux/page-flags.h	2004-05-18 20:51:27.663295648 +0100
@@ -76,7 +76,7 @@
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
 
-#define PG_anon			20	/* Anonymous page: anonmm in mapping */
+#define PG_anon			20	/* Anonymous: anon_vma in mapping */
 
 
 /*
--- rmap37/include/linux/rmap.h	2004-05-18 20:51:12.099661680 +0100
+++ rmap38/include/linux/rmap.h	2004-05-18 20:51:27.664295496 +0100
@@ -35,54 +35,6 @@ static inline void page_dup_rmap(struct 
 	page_map_unlock(page);
 }
 
-int mremap_move_anon_rmap(struct page *page, unsigned long addr);
-
-/**
- * mremap_moved_anon_rmap - does new address clash with that noted?
- * @page:	the page just brought back in from swap
- * @addr:	the user virtual address at which it is mapped
- *
- * Returns boolean, true if addr clashes with address already in page.
- *
- * For do_swap_page and unuse_pte: anonmm rmap cannot find the page if
- * it's at different addresses in different mms, so caller must take a
- * copy of the page to avoid that: not very clever, but too rare a case
- * to merit cleverness.
- */
-static inline int mremap_moved_anon_rmap(struct page *page, unsigned long addr)
-{
-	return page->index != (addr & PAGE_MASK);
-}
-
-/**
- * make_page_exclusive - try to make page exclusive to one mm
- * @vma		the vm_area_struct covering this address
- * @addr	the user virtual address of the page in question
- *
- * Assumes that the page at this address is anonymous (COWable),
- * and that the caller holds mmap_sem for reading or for writing.
- *
- * For mremap's move_page_tables and for swapoff's unuse_process:
- * not a general purpose routine, and in general may not succeed.
- * But move_page_tables loops until it succeeds, and unuse_process
- * holds the original page locked, which protects against races.
- */
-static inline int make_page_exclusive(struct vm_area_struct *vma,
-					unsigned long addr)
-{
-	if (handle_mm_fault(vma->vm_mm, vma, addr, 1) != VM_FAULT_OOM)
-		return 0;
-	return -ENOMEM;
-}
-
-/*
- * Called from kernel/fork.c to manage anonymous memory
- */
-void init_rmap(void);
-int exec_rmap(struct mm_struct *);
-int dup_rmap(struct mm_struct *, struct mm_struct *oldmm);
-void exit_rmap(struct mm_struct *);
-
 /*
  * Called from mm/vmscan.c to handle paging out
  */
@@ -91,11 +43,6 @@ int try_to_unmap(struct page *);
 
 #else	/* !CONFIG_MMU */
 
-#define init_rmap()		do {} while (0)
-#define exec_rmap(mm)		(0)
-#define dup_rmap(mm, oldmm)	(0)
-#define exit_rmap(mm)		do {} while (0)
-
 #define page_referenced(page)	TestClearPageReferenced(page)
 #define try_to_unmap(page)	SWAP_FAIL
 
--- rmap37/include/linux/sched.h	2004-05-16 11:39:26.000000000 +0100
+++ rmap38/include/linux/sched.h	2004-05-18 20:51:27.665295344 +0100
@@ -215,7 +215,6 @@ struct mm_struct {
 						 * together off init_mm.mmlist, and are protected
 						 * by mmlist_lock
 						 */
-	struct anonmm *anonmm;			/* For rmap to track anon mem */
 
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
--- rmap37/kernel/fork.c	2004-05-16 11:39:22.000000000 +0100
+++ rmap38/kernel/fork.c	2004-05-18 20:51:27.667295040 +0100
@@ -432,11 +432,6 @@ struct mm_struct * mm_alloc(void)
 	if (mm) {
 		memset(mm, 0, sizeof(*mm));
 		mm = mm_init(mm);
-		if (mm && exec_rmap(mm)) {
-			mm_free_pgd(mm);
-			free_mm(mm);
-			mm = NULL;
-		}
 	}
 	return mm;
 }
@@ -465,7 +460,6 @@ void mmput(struct mm_struct *mm)
 		spin_unlock(&mmlist_lock);
 		exit_aio(mm);
 		exit_mmap(mm);
-		exit_rmap(mm);
 		mmdrop(mm);
 	}
 }
@@ -569,12 +563,6 @@ static int copy_mm(unsigned long clone_f
 	if (!mm_init(mm))
 		goto fail_nomem;
 
-	if (dup_rmap(mm, oldmm)) {
-		mm_free_pgd(mm);
-		free_mm(mm);
-		goto fail_nomem;
-	}
-
 	if (init_new_context(tsk,mm))
 		goto fail_nocontext;
 
@@ -1298,5 +1286,4 @@ void __init proc_caches_init(void)
 	mm_cachep = kmem_cache_create("mm_struct",
 			sizeof(struct mm_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
-	init_rmap();
 }
--- rmap37/mm/memory.c	2004-05-18 20:51:12.101661376 +0100
+++ rmap38/mm/memory.c	2004-05-18 20:51:27.703289568 +0100
@@ -1379,7 +1379,7 @@ static int do_swap_page(struct mm_struct
 	set_pte(page_table, pte);
 	page_add_anon_rmap(page, vma, address);
 
-	if (write_access || mremap_moved_anon_rmap(page, address)) {
+	if (write_access) {
 		if (do_wp_page(mm, vma, address,
 				page_table, pmd, pte) == VM_FAULT_OOM)
 			ret = VM_FAULT_OOM;
--- rmap37/mm/mremap.c	2004-05-16 11:39:24.000000000 +0100
+++ rmap38/mm/mremap.c	2004-05-18 20:51:27.704289416 +0100
@@ -15,7 +15,6 @@
 #include <linux/swap.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
-#include <linux/rmap.h>
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
@@ -80,21 +79,6 @@ static inline pte_t *alloc_one_pte_map(s
 	return pte;
 }
 
-static inline int
-can_move_one_pte(pte_t *src, unsigned long new_addr)
-{
-	int move = 1;
-	if (pte_present(*src)) {
-		unsigned long pfn = pte_pfn(*src);
-		if (pfn_valid(pfn)) {
-			struct page *page = pfn_to_page(pfn);
-			if (PageAnon(page))
-				move = mremap_move_anon_rmap(page, new_addr);
-		}
-	}
-	return move;
-}
-
 static int
 move_one_page(struct vm_area_struct *vma, unsigned long old_addr,
 		unsigned long new_addr)
@@ -141,15 +125,12 @@ move_one_page(struct vm_area_struct *vma
 		 * page_table_lock, we should re-check the src entry...
 		 */
 		if (src) {
-			if (!dst)
-				error = -ENOMEM;
-			else if (!can_move_one_pte(src, new_addr))
-				error = -EAGAIN;
-			else {
+			if (dst) {
 				pte_t pte;
 				pte = ptep_clear_flush(vma, old_addr, src);
 				set_pte(dst, pte);
-			}
+			} else
+				error = -ENOMEM;
 			pte_unmap_nested(src);
 		}
 		if (dst)
@@ -163,7 +144,7 @@ move_one_page(struct vm_area_struct *vma
 
 static unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long new_addr, unsigned long old_addr,
-		unsigned long len, int *cows)
+		unsigned long len)
 {
 	unsigned long offset;
 
@@ -175,21 +156,7 @@ static unsigned long move_page_tables(st
 	 * only a few pages.. This also makes error recovery easier.
 	 */
 	for (offset = 0; offset < len; offset += PAGE_SIZE) {
-		int ret = move_one_page(vma, old_addr+offset, new_addr+offset);
-		/*
-		 * The anonmm objrmap can only track anon page movements
-		 * if the page is exclusive to one mm.  In the rare case
-		 * when mremap move is applied to a shared page, break
-		 * COW (take a copy of the page) to make it exclusive.
-		 * If shared while on swap, page will be copied when
-		 * brought back in (if it's still shared by then).
-		 */
-		if (ret == -EAGAIN) {
-			ret = make_page_exclusive(vma, old_addr+offset);
-			offset -= PAGE_SIZE;
-			(*cows)++;
-		}
-		if (ret)
+		if (move_one_page(vma, old_addr+offset, new_addr+offset) < 0)
 			break;
 		cond_resched();
 	}
@@ -207,7 +174,6 @@ static unsigned long move_vma(struct vm_
 	unsigned long moved_len;
 	unsigned long excess = 0;
 	int split = 0;
-	int cows = 0;
 
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
@@ -221,22 +187,19 @@ static unsigned long move_vma(struct vm_
 	if (!new_vma)
 		return -ENOMEM;
 
-	moved_len = move_page_tables(vma, new_addr, old_addr, old_len, &cows);
+	moved_len = move_page_tables(vma, new_addr, old_addr, old_len);
 	if (moved_len < old_len) {
 		/*
 		 * On error, move entries back from new area to old,
 		 * which will succeed since page tables still there,
 		 * and then proceed to unmap new area instead of old.
 		 */
-		move_page_tables(new_vma, old_addr, new_addr, moved_len, &cows);
+		move_page_tables(new_vma, old_addr, new_addr, moved_len);
 		vma = new_vma;
 		old_len = new_len;
 		old_addr = new_addr;
 		new_addr = -ENOMEM;
 	}
-	if (cows)	/* Downgrade or remove this message later */
-		printk(KERN_WARNING "%s: mremap moved %d cows\n",
-							current->comm, cows);
 
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
 	if (vm_flags & VM_ACCOUNT) {
--- rmap37/mm/rmap.c	2004-05-18 20:51:12.103661072 +0100
+++ rmap38/mm/rmap.c	2004-05-18 20:51:27.706289112 +0100
@@ -27,125 +27,11 @@
 
 #include <asm/tlbflush.h>
 
-/*
- * struct anonmm: to track a bundle of anonymous memory mappings.
- *
- * Could be embedded in mm_struct, but mm_struct is rather heavyweight,
- * and we may need the anonmm to stay around long after the mm_struct
- * and its pgd have been freed: because pages originally faulted into
- * that mm have been duped into forked mms, and still need tracking.
- */
-struct anonmm {
-	atomic_t	 count;	/* ref count, including 1 per page */
-	spinlock_t	 lock;	/* head's locks list; others unused */
-	struct mm_struct *mm;	/* assoc mm_struct, NULL when gone */
-	struct anonmm	 *head;	/* exec starts new chain from head */
-	struct list_head list;	/* chain of associated anonmms */
-};
-static kmem_cache_t *anonmm_cachep;
-
-/**
- ** Functions for creating and destroying struct anonmm.
- **/
-
-void __init init_rmap(void)
-{
-	anonmm_cachep = kmem_cache_create("anonmm",
-			sizeof(struct anonmm), 0, SLAB_PANIC, NULL, NULL);
-}
-
-int exec_rmap(struct mm_struct *mm)
-{
-	struct anonmm *anonmm;
-
-	anonmm = kmem_cache_alloc(anonmm_cachep, SLAB_KERNEL);
-	if (unlikely(!anonmm))
-		return -ENOMEM;
-
-	atomic_set(&anonmm->count, 2);		/* ref by mm and head */
-	anonmm->lock = SPIN_LOCK_UNLOCKED;	/* this lock is used */
-	anonmm->mm = mm;
-	anonmm->head = anonmm;
-	INIT_LIST_HEAD(&anonmm->list);
-	mm->anonmm = anonmm;
-	return 0;
-}
-
-int dup_rmap(struct mm_struct *mm, struct mm_struct *oldmm)
-{
-	struct anonmm *anonmm;
-	struct anonmm *anonhd = oldmm->anonmm->head;
-
-	anonmm = kmem_cache_alloc(anonmm_cachep, SLAB_KERNEL);
-	if (unlikely(!anonmm))
-		return -ENOMEM;
-
-	/*
-	 * copy_mm calls us before dup_mmap has reset the mm fields,
-	 * so reset rss ourselves before adding to anonhd's list,
-	 * to keep away from this mm until it's worth examining.
-	 */
-	mm->rss = 0;
-
-	atomic_set(&anonmm->count, 1);		/* ref by mm */
-	anonmm->lock = SPIN_LOCK_UNLOCKED;	/* this lock is not used */
-	anonmm->mm = mm;
-	anonmm->head = anonhd;
-	spin_lock(&anonhd->lock);
-	atomic_inc(&anonhd->count);		/* ref by anonmm's head */
-	list_add_tail(&anonmm->list, &anonhd->list);
-	spin_unlock(&anonhd->lock);
-	mm->anonmm = anonmm;
-	return 0;
-}
-
-void exit_rmap(struct mm_struct *mm)
-{
-	struct anonmm *anonmm = mm->anonmm;
-	struct anonmm *anonhd = anonmm->head;
-	int anonhd_count;
-
-	mm->anonmm = NULL;
-	spin_lock(&anonhd->lock);
-	anonmm->mm = NULL;
-	if (atomic_dec_and_test(&anonmm->count)) {
-		BUG_ON(anonmm == anonhd);
-		list_del(&anonmm->list);
-		kmem_cache_free(anonmm_cachep, anonmm);
-		if (atomic_dec_and_test(&anonhd->count))
-			BUG();
-	}
-	anonhd_count = atomic_read(&anonhd->count);
-	spin_unlock(&anonhd->lock);
-	if (anonhd_count == 1) {
-		BUG_ON(anonhd->mm);
-		BUG_ON(!list_empty(&anonhd->list));
-		kmem_cache_free(anonmm_cachep, anonhd);
-	}
-}
-
-static void free_anonmm(struct anonmm *anonmm)
-{
-	struct anonmm *anonhd = anonmm->head;
-
-	BUG_ON(anonmm->mm);
-	BUG_ON(anonmm == anonhd);
-	spin_lock(&anonhd->lock);
-	list_del(&anonmm->list);
-	if (atomic_dec_and_test(&anonhd->count))
-		BUG();
-	spin_unlock(&anonhd->lock);
-	kmem_cache_free(anonmm_cachep, anonmm);
-}
-
 static inline void clear_page_anon(struct page *page)
 {
-	struct anonmm *anonmm = (struct anonmm *) page->mapping;
-
+	BUG_ON(!page->mapping);
 	page->mapping = NULL;
 	ClearPageAnon(page);
-	if (atomic_dec_and_test(&anonmm->count))
-		free_anonmm(anonmm);
 }
 
 /*
@@ -213,75 +99,7 @@ out_unlock:
 
 static inline int page_referenced_anon(struct page *page)
 {
-	unsigned int mapcount = page->mapcount;
-	struct anonmm *anonmm = (struct anonmm *) page->mapping;
-	struct anonmm *anonhd = anonmm->head;
-	struct anonmm *new_anonmm = anonmm;
-	struct list_head *seek_head;
-	int referenced = 0;
-	int failed = 0;
-
-	spin_lock(&anonhd->lock);
-	/*
-	 * First try the indicated mm, it's the most likely.
-	 * Make a note to migrate the page if this mm is extinct.
-	 */
-	if (!anonmm->mm)
-		new_anonmm = NULL;
-	else if (anonmm->mm->rss) {
-		referenced += page_referenced_one(page,
-			anonmm->mm, page->index, &mapcount, &failed);
-		if (!mapcount)
-			goto out;
-	}
-
-	/*
-	 * Then down the rest of the list, from that as the head.  Stop
-	 * when we reach anonhd?  No: although a page cannot get dup'ed
-	 * into an older mm, once swapped, its indicated mm may not be
-	 * the oldest, just the first into which it was faulted back.
-	 * If original mm now extinct, note first to contain the page.
-	 */
-	seek_head = &anonmm->list;
-	list_for_each_entry(anonmm, seek_head, list) {
-		if (!anonmm->mm || !anonmm->mm->rss)
-			continue;
-		referenced += page_referenced_one(page,
-			anonmm->mm, page->index, &mapcount, &failed);
-		if (!new_anonmm && mapcount < page->mapcount)
-			new_anonmm = anonmm;
-		if (!mapcount) {
-			anonmm = (struct anonmm *) page->mapping;
-			if (new_anonmm == anonmm)
-				goto out;
-			goto migrate;
-		}
-	}
-
-	/*
-	 * The warning below may appear if page_referenced_anon catches
-	 * the page in between page_add_anon_rmap and its replacement
-	 * demanded by mremap_moved_anon_page: so remove the warning once
-	 * we're convinced that anonmm rmap really is finding its pages.
-	 */
-	WARN_ON(!failed);
-out:
-	spin_unlock(&anonhd->lock);
-	return referenced;
-
-migrate:
-	/*
-	 * Migrate pages away from an extinct mm, so that its anonmm
-	 * can be freed in due course: we could leave this to happen
-	 * through the natural attrition of try_to_unmap, but that
-	 * would miss locked pages and frequently referenced pages.
-	 */
-	spin_unlock(&anonhd->lock);
-	page->mapping = (void *) new_anonmm;
-	atomic_inc(&new_anonmm->count);
-	if (atomic_dec_and_test(&anonmm->count))
-		free_anonmm(anonmm);
-	return referenced;
+	return 1;	/* until next patch */
 }
 
 /**
@@ -373,8 +191,6 @@ int page_referenced(struct page *page)
 void page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address)
 {
-	struct anonmm *anonmm = vma->vm_mm->anonmm;
-
 	BUG_ON(PageReserved(page));
 
 	page_map_lock(page);
@@ -382,8 +198,7 @@ void page_add_anon_rmap(struct page *pag
 		BUG_ON(page->mapping);
 		SetPageAnon(page);
 		page->index = address & PAGE_MASK;
-		page->mapping = (void *) anonmm;
-		atomic_inc(&anonmm->count);
+		page->mapping = (void *) vma;	/* until next patch */
 		inc_page_state(nr_mapped);
 	}
 	page->mapcount++;
@@ -432,32 +247,6 @@ void page_remove_rmap(struct page *page)
 	page_map_unlock(page);
 }
 
-/**
- * mremap_move_anon_rmap - try to note new address of anonymous page
- * @page:	page about to be moved
- * @address:	user virtual address at which it is going to be mapped
- *
- * Returns boolean, true if page is not shared, so address updated.
- *
- * For mremap's can_move_one_page: to update address when vma is moved,
- * provided that anon page is not shared with a parent or child mm.
- * If it is shared, then caller must take a copy of the page instead:
- * not very clever, but too rare a case to merit cleverness.
- */
-int mremap_move_anon_rmap(struct page *page, unsigned long address)
-{
-	int move = 0;
-	if (page->mapcount == 1) {
-		page_map_lock(page);
-		if (page->mapcount == 1) {
-			page->index = address & PAGE_MASK;
-			move = 1;
-		}
-		page_map_unlock(page);
-	}
-	return move;
-}
-
 /*
  * Subfunctions of try_to_unmap: try_to_unmap_one called
  * repeatedly from either try_to_unmap_anon or try_to_unmap_file.
@@ -651,38 +440,7 @@ out_unlock:
 
 static inline int try_to_unmap_anon(struct page *page)
 {
-	struct anonmm *anonmm = (struct anonmm *) page->mapping;
-	struct anonmm *anonhd = anonmm->head;
-	struct list_head *seek_head;
-	int ret = SWAP_AGAIN;
-
-	spin_lock(&anonhd->lock);
-	/*
-	 * First try the indicated mm, it's the most likely.
-	 */
-	if (anonmm->mm && anonmm->mm->rss) {
-		ret = try_to_unmap_one(page, anonmm->mm, page->index, NULL);
-		if (ret == SWAP_FAIL || !page->mapcount)
-			goto out;
-	}
-
-	/*
-	 * Then down the rest of the list, from that as the head.  Stop
-	 * when we reach anonhd?  No: although a page cannot get dup'ed
-	 * into an older mm, once swapped, its indicated mm may not be
-	 * the oldest, just the first into which it was faulted back.
-	 */
-	seek_head = &anonmm->list;
-	list_for_each_entry(anonmm, seek_head, list) {
-		if (!anonmm->mm || !anonmm->mm->rss)
-			continue;
-		ret = try_to_unmap_one(page, anonmm->mm, page->index, NULL);
-		if (ret == SWAP_FAIL || !page->mapcount)
-			goto out;
-	}
-out:
-	spin_unlock(&anonhd->lock);
-	return ret;
+	return SWAP_FAIL;	/* until next patch */
 }
 
 /**
--- rmap37/mm/swapfile.c	2004-05-18 20:51:12.104660920 +0100
+++ rmap38/mm/swapfile.c	2004-05-18 20:51:27.708288808 +0100
@@ -537,7 +537,6 @@ static int unuse_process(struct mm_struc
 {
 	struct vm_area_struct* vma;
 	unsigned long foundaddr = 0;
-	int ret = 0;
 
 	/*
 	 * Go through process' page directory.
@@ -553,10 +552,12 @@ static int unuse_process(struct mm_struc
 		}
 	}
 	spin_unlock(&mm->page_table_lock);
-	if (foundaddr && mremap_moved_anon_rmap(page, foundaddr))
-		ret = make_page_exclusive(vma, foundaddr);
 	up_read(&mm->mmap_sem);
-	return ret;
+	/*
+	 * Currently unuse_process cannot fail, but leave error handling
+	 * at call sites for now, since we change it from time to time.
+	 */
+	return 0;
 }
 
 /*

