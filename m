Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263314AbUCRXle (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbUCRXjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:39:54 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:16819 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263308AbUCRX0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:26:08 -0500
Date: Thu, 18 Mar 2004 23:26:04 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: [PATCH] anobjrmap 5/6 anonmm
In-Reply-To: <Pine.LNX.4.44.0403182317050.16911-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403182325280.16928-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anobjrmap 5/6 add anonmm to track anonymous pages

Introduce struct anonmm per mm to track anonymous pages,
all forks from one exec share same bundle of linked anonmms:
anonymous pages may start out in one mm but get forked into
another later.  Callouts from fork.c to rmap.c to allocate,
dup and exit anonmm.

page_referenced and try_to_unmap call _anon or _obj variants
to process lists, which call _one for each vma or anonmm.
The resulting rmap.c is a lot easier to read than this patch.

 include/linux/rmap.h  |   13 +
 include/linux/sched.h |    1 
 kernel/fork.c         |   19 +-
 mm/rmap.c             |  444 ++++++++++++++++++++++++++++++++++++++------------
 4 files changed, 376 insertions(+), 101 deletions(-)

--- anobjrmap4/include/linux/rmap.h	2004-03-18 21:27:15.345558840 +0000
+++ anobjrmap5/include/linux/rmap.h	2004-03-18 21:27:26.840811296 +0000
@@ -35,6 +35,14 @@ static inline void page_dup_rmap(struct 
 }
 
 /*
+ * Called from kernel/fork.c to manage anonymous memory
+ */
+void init_rmap(void);
+int exec_rmap(struct mm_struct *);
+int dup_rmap(struct mm_struct *, struct mm_struct *oldmm);
+void exit_rmap(struct mm_struct *);
+
+/*
  * Called from mm/vmscan.c to handle paging out
  */
 int fastcall page_referenced(struct page *);
@@ -42,6 +50,11 @@ int fastcall try_to_unmap(struct page *)
 
 #else	/* !CONFIG_MMU */
 
+#define init_rmap()		do {} while (0)
+#define exec_rmap(mm)		(0)
+#define dup_rmap(mm, oldmm)	(0)
+#define exit_rmap(mm)		do {} while (0)
+
 #define page_referenced(page)	TestClearPageReferenced(page)
 #define try_to_unmap(page)	SWAP_FAIL
 
--- anobjrmap4/include/linux/sched.h	2004-03-11 01:56:07.000000000 +0000
+++ anobjrmap5/include/linux/sched.h	2004-03-18 21:27:26.842810992 +0000
@@ -199,6 +199,7 @@ struct mm_struct {
 						 * together off init_mm.mmlist, and are protected
 						 * by mmlist_lock
 						 */
+	struct anonmm *anonmm;			/* For rmap to track anon mem */
 
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
--- anobjrmap4/kernel/fork.c	2004-03-11 01:56:07.000000000 +0000
+++ anobjrmap5/kernel/fork.c	2004-03-18 21:27:26.844810688 +0000
@@ -31,6 +31,7 @@
 #include <linux/futex.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
+#include <linux/rmap.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -417,9 +418,14 @@ struct mm_struct * mm_alloc(void)
 	mm = allocate_mm();
 	if (mm) {
 		memset(mm, 0, sizeof(*mm));
-		return mm_init(mm);
+		mm = mm_init(mm);
+		if (mm && exec_rmap(mm)) {
+			mm_free_pgd(mm);
+			free_mm(mm);
+			mm = NULL;
+		}
 	}
-	return NULL;
+	return mm;
 }
 
 /*
@@ -446,6 +452,7 @@ void mmput(struct mm_struct *mm)
 		spin_unlock(&mmlist_lock);
 		exit_aio(mm);
 		exit_mmap(mm);
+		exit_rmap(mm);
 		mmdrop(mm);
 	}
 }
@@ -550,6 +557,12 @@ static int copy_mm(unsigned long clone_f
 	if (!mm_init(mm))
 		goto fail_nomem;
 
+	if (dup_rmap(mm, oldmm)) {
+		mm_free_pgd(mm);
+		free_mm(mm);
+		goto fail_nomem;
+	}
+
 	if (init_new_context(tsk,mm))
 		goto fail_nocontext;
 
@@ -1246,4 +1259,6 @@ void __init proc_caches_init(void)
 			SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if(!mm_cachep)
 		panic("vma_init: Cannot alloc mm_struct SLAB cache");
+
+	init_rmap();
 }
--- anobjrmap4/mm/rmap.c	2004-03-18 21:27:15.362556256 +0000
+++ anobjrmap5/mm/rmap.c	2004-03-18 21:27:26.848810080 +0000
@@ -25,52 +25,173 @@
 #include <linux/init.h>
 #include <linux/rmap.h>
 
+/*
+ * struct anonmm: to track a bundle of anonymous memory mappings.
+ *
+ * Could be embedded in mm_struct, but mm_struct is rather heavyweight,
+ * and we may need the anonmm to stay around long after the mm_struct
+ * and its pgd have been freed: because pages originally faulted into
+ * that mm have been duped into forked mms, and still need tracking.
+ */
+struct anonmm {
+	atomic_t	 count;	/* ref count, incl. 1 per page */
+	spinlock_t	 lock;	/* head's locks list; others unused */
+	struct mm_struct *mm;	/* assoc mm_struct, NULL when gone */
+	struct anonmm	 *head;	/* exec starts new chain from head */
+	struct list_head list;	/* chain of associated anonmms */
+};
+static kmem_cache_t *anonmm_cachep;
+
+/**
+ ** Functions for creating and destroying struct anonmm.
+ **/
+
+void __init init_rmap(void)
+{
+	anonmm_cachep = kmem_cache_create("anonmm",
+			sizeof(struct anonmm), 0,
+			SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (!anonmm_cachep)
+		panic("init_rmap: Cannot alloc anonmm SLAB cache");
+}
+
+int exec_rmap(struct mm_struct *mm)
+{
+	struct anonmm *anonmm;
+
+	anonmm = kmem_cache_alloc(anonmm_cachep, SLAB_KERNEL);
+	if (unlikely(!anonmm))
+		return -ENOMEM;
+
+	atomic_set(&anonmm->count, 2);		/* ref by mm and head */
+	anonmm->lock = SPIN_LOCK_UNLOCKED;	/* this lock is used */
+	anonmm->mm = mm;
+	anonmm->head = anonmm;
+	INIT_LIST_HEAD(&anonmm->list);
+	mm->anonmm = anonmm;
+	return 0;
+}
+
+int dup_rmap(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	struct anonmm *anonmm;
+	struct anonmm *anonhd = oldmm->anonmm->head;
+
+	anonmm = kmem_cache_alloc(anonmm_cachep, SLAB_KERNEL);
+	if (unlikely(!anonmm))
+		return -ENOMEM;
+
+	/*
+	 * copy_mm calls us before dup_mmap has reset the mm fields,
+	 * so reset rss ourselves before adding to anonhd's list,
+	 * to keep away from this mm until it's worth examining.
+	 */
+	mm->rss = 0;
+
+	atomic_set(&anonmm->count, 1);		/* ref by mm */
+	anonmm->lock = SPIN_LOCK_UNLOCKED;	/* this lock is not used */
+	anonmm->mm = mm;
+	anonmm->head = anonhd;
+	spin_lock(&anonhd->lock);
+	atomic_inc(&anonhd->count);		/* ref by anonmm's head */
+	list_add_tail(&anonmm->list, &anonhd->list);
+	spin_unlock(&anonhd->lock);
+	mm->anonmm = anonmm;
+	return 0;
+}
+
+void exit_rmap(struct mm_struct *mm)
+{
+	struct anonmm *anonmm = mm->anonmm;
+	struct anonmm *anonhd = anonmm->head;
+
+	mm->anonmm = NULL;
+	spin_lock(&anonhd->lock);
+	anonmm->mm = NULL;
+	if (atomic_dec_and_test(&anonmm->count)) {
+		BUG_ON(anonmm == anonhd);
+		list_del(&anonmm->list);
+		kmem_cache_free(anonmm_cachep, anonmm);
+		if (atomic_dec_and_test(&anonhd->count))
+			BUG();
+	}
+	spin_unlock(&anonhd->lock);
+	if (atomic_read(&anonhd->count) == 1) {
+		BUG_ON(anonhd->mm);
+		BUG_ON(!list_empty(&anonhd->list));
+		kmem_cache_free(anonmm_cachep, anonhd);
+	}
+}
+
+static void free_anonmm(struct anonmm *anonmm)
+{
+	struct anonmm *anonhd = anonmm->head;
+
+	BUG_ON(anonmm->mm);
+	BUG_ON(anonmm == anonhd);
+	spin_lock(&anonhd->lock);
+	list_del(&anonmm->list);
+	if (atomic_dec_and_test(&anonhd->count))
+		BUG();
+	spin_unlock(&anonhd->lock);
+	kmem_cache_free(anonmm_cachep, anonmm);
+}
+
 static inline void clear_page_anon(struct page *page)
 {
+	struct anonmm *anonmm = (struct anonmm *) page->mapping;
+
 	page->mapping = NULL;
 	ClearPageAnon(page);
+	if (atomic_dec_and_test(&anonmm->count))
+		free_anonmm(anonmm);
 }
 
 /**
  ** VM stuff below this comment
  **/
 
-/**
- * find_pte - Find a pte pointer given a vma and a struct page.
- * @vma: the vma to search
- * @page: the page to find
- *
- * Determine if this page is mapped in this vma.  If it is, map and return
- * the pte pointer associated with it.  Return null if the page is not
- * mapped in this vma for any reason.
- *
- * This is strictly an internal helper function for the object-based rmap
- * functions.
- * 
- * It is the caller's responsibility to unmap the pte if it is returned.
+/*
+ * At what user virtual address is page expected in file-backed vma?
  */
-static inline pte_t *
-find_pte(struct vm_area_struct *vma, struct page *page, unsigned long *addr)
+#define NOADDR	(~0UL)		/* impossible user virtual address */
+static inline unsigned long
+vma_address(struct page *page, struct vm_area_struct *vma)
+{
+	unsigned long pgoff;
+	unsigned long address;
+
+	pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	return (address >= vma->vm_start && address < vma->vm_end)?
+		address: NOADDR;
+}
+
+/**
+ ** Subfunctions of page_referenced: page_referenced_one called
+ ** repeatedly from either page_referenced_anon or page_referenced_obj.
+ **/
+
+static int page_referenced_one(struct page *page,
+	struct mm_struct *mm, unsigned long address, int *mapcount)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long loffset;
-	unsigned long address;
+	int referenced = 0;
 
-	loffset = (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
-	address = vma->vm_start + ((loffset - vma->vm_pgoff) << PAGE_SHIFT);
-	if (address < vma->vm_start || address >= vma->vm_end)
+	if (!spin_trylock(&mm->page_table_lock)) {
+		referenced++;
 		goto out;
+	}
 
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
@@ -79,53 +200,59 @@ find_pte(struct vm_area_struct *vma, str
 	if (page_to_pfn(page) != pte_pfn(*pte))
 		goto out_unmap;
 
-	if (addr)
-		*addr = address;
+	if (ptep_test_and_clear_young(pte))
+		referenced++;
 
-	return pte;
+	(*mapcount)--;
 
 out_unmap:
 	pte_unmap(pte);
+
+out_unlock:
+	spin_unlock(&mm->page_table_lock);
+
 out:
-	return NULL;
+	return referenced;
 }
 
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
+static inline int page_referenced_anon(struct page *page, int *mapcount)
 {
-	struct mm_struct *mm = vma->vm_mm;
-	pte_t *pte;
+	struct anonmm *anonmm = (struct anonmm *) page->mapping;
+	struct anonmm *anonhd = anonmm->head;
+	struct list_head *seek_head;
 	int referenced = 0;
 
-	if (!spin_trylock(&mm->page_table_lock))
-		return 1;
-
-	pte = find_pte(vma, page, NULL);
-	if (pte) {
-		if (ptep_test_and_clear_young(pte))
-			referenced++;
-		pte_unmap(pte);
+	spin_lock(&anonhd->lock);
+	/*
+	 * First try the indicated mm, it's the most likely.
+	 */
+	if (anonmm->mm && anonmm->mm->rss) {
+		referenced += page_referenced_one(
+			page, anonmm->mm, page->index, mapcount);
+		if (!*mapcount)
+			goto out;
 	}
 
-	spin_unlock(&mm->page_table_lock);
+	/*
+	 * Then down the rest of the list, from that as the head.  Stop
+	 * when we reach anonhd?  No: although a page cannot get dup'ed
+	 * into an older mm, once swapped, its indicated mm may not be
+	 * the oldest, just the first into which it was faulted back.
+	 */
+	seek_head = &anonmm->list;
+	list_for_each_entry(anonmm, seek_head, list) {
+		if (!anonmm->mm || !anonmm->mm->rss)
+			continue;
+		referenced += page_referenced_one(
+			page, anonmm->mm, page->index, mapcount);
+		if (!*mapcount)
+			goto out;
+	}
+out:
+	spin_unlock(&anonhd->lock);
 	return referenced;
 }
 
-static inline int page_referenced_anon(struct page *page)
-{
-	return 0;	/* until next patch */
-}
-
 /**
  * page_referenced_obj - referenced check for object-based rmap
  * @page: the page we're checking references on.
@@ -140,24 +267,41 @@ static inline int page_referenced_anon(s
  * The semaphore address_space->i_shared_sem is tried.  If it can't be gotten,
  * assume a reference count of 1.
  */
-static int
-page_referenced_obj(struct page *page)
+static inline int page_referenced_obj(struct page *page, int *mapcount)
 {
 	struct address_space *mapping = page->mapping;
 	struct vm_area_struct *vma;
+	unsigned long address;
 	int referenced = 0;
 
 	if (down_trylock(&mapping->i_shared_sem))
 		return 1;
-	
-	list_for_each_entry(vma, &mapping->i_mmap, shared)
-		referenced += page_referenced_obj_one(vma, page);
 
-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared)
-		referenced += page_referenced_obj_one(vma, page);
+	list_for_each_entry(vma, &mapping->i_mmap, shared) {
+		if (!vma->vm_mm->rss)
+			continue;
+		address = vma_address(page, vma);
+		if (address != NOADDR) {
+			referenced += page_referenced_one(
+				page, vma->vm_mm, address, mapcount);
+			if (!*mapcount)
+				goto out;
+		}
+	}
 
+	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+		if (!vma->vm_mm->rss)
+			continue;
+		address = vma_address(page, vma);
+		if (address != NOADDR) {
+			referenced += page_referenced_one(
+				page, vma->vm_mm, address, mapcount);
+			if (!*mapcount)
+				goto out;
+		}
+	}
+out:
 	up(&mapping->i_shared_sem);
-
 	return referenced;
 }
 
@@ -166,11 +310,12 @@ page_referenced_obj(struct page *page)
  * @page: the page to test
  *
  * Quick test_and_clear_referenced for all mappings to a page,
- * returns the number of processes which referenced the page.
+ * returns the number of ptes which referenced the page.
  * Caller needs to hold the rmap_lock.
  */
 int fastcall page_referenced(struct page * page)
 {
+	int mapcount = page->mapcount;
 	int referenced = 0;
 
 	if (page_test_and_clear_young(page))
@@ -181,9 +326,9 @@ int fastcall page_referenced(struct page
 
 	if (page->mapcount && page->mapping) {
 		if (PageAnon(page))
-			referenced += page_referenced_anon(page);
+			referenced += page_referenced_anon(page, &mapcount);
 		else
-			referenced += page_referenced_obj(page);
+			referenced += page_referenced_obj(page, &mapcount);
 	}
 	return referenced;
 }
@@ -199,14 +344,18 @@ int fastcall page_referenced(struct page
 void fastcall page_add_anon_rmap(struct page *page,
 	struct mm_struct *mm, unsigned long address)
 {
+	struct anonmm *anonmm;
+
 	BUG_ON(PageReserved(page));
 	BUG_ON(page_mapping(page));
 
 	rmap_lock(page);
 	if (!page->mapcount) {
+		anonmm = mm->anonmm;
 		SetPageAnon(page);
 		page->index = address & PAGE_MASK;
-		page->mapping = (void *) mm;	/* until next patch */
+		page->mapping = (void *) anonmm;
+		atomic_inc(&anonmm->count);
 		inc_page_state(nr_mapped);
 	}
 	page->mapcount++;
@@ -227,13 +376,28 @@ void fastcall page_add_anon_rmap(struct 
 void fastcall page_update_anon_rmap(struct page *page,
 	struct mm_struct *mm, unsigned long address)
 {
+	struct anonmm *anonmm;
+
 	BUG_ON(!PageAnon(page));
 	if (page->mapcount != 1)
 		return;
 
+	anonmm = mm->anonmm;
+	address &= PAGE_MASK;
+	if (anonmm == (struct anonmm *) page->mapping &&
+	    address == page->index)
+		return;
+
 	rmap_lock(page);
-	page->index = address & PAGE_MASK;
-	page->mapping = (void *) mm;	/* until next patch */
+	if (page->mapcount == 1) {
+		page->index = address;
+		if (anonmm != (struct anonmm *) page->mapping) {
+			clear_page_anon(page);
+			SetPageAnon(page);
+			page->mapping = (void *) anonmm;
+			atomic_inc(&anonmm->count);
+		}
+	}
 	rmap_unlock(page);
 }
 
@@ -280,37 +444,71 @@ void fastcall page_remove_rmap(struct pa
 }
 
 /**
- * try_to_unmap_obj_one - unmap a page using the object-based rmap method
- * @page: the page to unmap
- *
- * Determine whether a page is mapped in a given vma and unmap it if it's found.
- *
- * This function is strictly a helper function for try_to_unmap_obj.
- */
-static inline int
-try_to_unmap_obj_one(struct vm_area_struct *vma, struct page *page)
+ ** Subfunctions of try_to_unmap: try_to_unmap_one called
+ ** repeatedly from either try_to_unmap_anon or try_to_unmap_obj.
+ **/
+
+static int try_to_unmap_one(struct page *page, struct mm_struct *mm,
+	unsigned long address, int *mapcount, struct vm_area_struct *vma)
 {
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long address;
+	pgd_t *pgd;
+	pmd_t *pmd;
 	pte_t *pte;
 	pte_t pteval;
 	int ret = SWAP_AGAIN;
 
+	/*
+	 * We need the page_table_lock to protect us from page faults,
+	 * munmap, fork, etc...
+	 */
 	if (!spin_trylock(&mm->page_table_lock))
-		return ret;
-
-	pte = find_pte(vma, page, &address);
-	if (!pte)
 		goto out;
 
-	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
+	pgd = pgd_offset(mm, address);
+	if (!pgd_present(*pgd))
+		goto out_unlock;
+
+	pmd = pmd_offset(pgd, address);
+	if (!pmd_present(*pmd))
+		goto out_unlock;
+
+	pte = pte_offset_map(pmd, address);
+	if (!pte_present(*pte))
+		goto out_unmap;
+
+	if (page_to_pfn(page) != pte_pfn(*pte))
+		goto out_unmap;
+
+	(*mapcount)--;
+
+	/*
+	 * If the page is mlock()d, we cannot swap it out.
+	 * During mremap, it's possible pages are not in a VMA.
+	 */
+	if (!vma)
+		vma = find_vma(mm, address);
+	if (!vma || (vma->vm_flags & (VM_LOCKED|VM_RESERVED))) {
 		ret =  SWAP_FAIL;
 		goto out_unmap;
 	}
 
+	/* Nuke the page table entry. */
 	flush_cache_page(vma, address);
 	pteval = ptep_clear_flush(vma, address, pte);
 
+	if (PageAnon(page)) {
+		swp_entry_t entry = { .val = page->private };
+		/*
+		 * Store the swap location in the pte.
+		 * See handle_pte_fault() ...
+		 */
+		BUG_ON(!PageSwapCache(page));
+		swap_duplicate(entry);
+		set_pte(pte, swp_entry_to_pte(entry));
+		BUG_ON(pte_file(*pte));
+	}
+
+	/* Move the dirty bit to the physical page now the pte is gone. */
 	if (pte_dirty(pteval))
 		set_page_dirty(page);
 
@@ -322,14 +520,49 @@ try_to_unmap_obj_one(struct vm_area_stru
 out_unmap:
 	pte_unmap(pte);
 
-out:
+out_unlock:
 	spin_unlock(&mm->page_table_lock);
+
+out:
 	return ret;
 }
 
-static inline int try_to_unmap_anon(struct page *page)
+static inline int try_to_unmap_anon(struct page *page, int *mapcount)
 {
-	return SWAP_FAIL;	/* until next patch */
+	struct anonmm *anonmm = (struct anonmm *) page->mapping;
+	struct anonmm *anonhd = anonmm->head;
+	struct list_head *seek_head;
+	int ret = SWAP_AGAIN;
+
+	spin_lock(&anonhd->lock);
+	/*
+	 * First try the indicated mm, it's the most likely.
+	 */
+	if (anonmm->mm && anonmm->mm->rss) {
+		ret = try_to_unmap_one(
+			page, anonmm->mm, page->index, mapcount, NULL);
+		if (ret == SWAP_FAIL || !*mapcount)
+			goto out;
+	}
+
+	/*
+	 * Then down the rest of the list, from that as the head.  Stop
+	 * when we reach anonhd?  No: although a page cannot get dup'ed
+	 * into an older mm, once swapped, its indicated mm may not be
+	 * the oldest, just the first into which it was faulted back.
+	 */
+	seek_head = &anonmm->list;
+	list_for_each_entry(anonmm, seek_head, list) {
+		if (!anonmm->mm || !anonmm->mm->rss)
+			continue;
+		ret = try_to_unmap_one(
+			page, anonmm->mm, page->index, mapcount, NULL);
+		if (ret == SWAP_FAIL || !*mapcount)
+			goto out;
+	}
+out:
+	spin_unlock(&anonhd->lock);
+	return ret;
 }
 
 /**
@@ -344,26 +577,38 @@ static inline int try_to_unmap_anon(stru
  * The semaphore address_space->i_shared_sem is tried.  If it can't be gotten,
  * return a temporary error.
  */
-static int
-try_to_unmap_obj(struct page *page)
+static inline int try_to_unmap_obj(struct page *page, int *mapcount)
 {
 	struct address_space *mapping = page->mapping;
 	struct vm_area_struct *vma;
+	unsigned long address;
 	int ret = SWAP_AGAIN;
 
 	if (down_trylock(&mapping->i_shared_sem))
 		return ret;
-	
+
 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
-		ret = try_to_unmap_obj_one(vma, page);
-		if (ret == SWAP_FAIL || !page->mapcount)
-			goto out;
+		if (!vma->vm_mm->rss)
+			continue;
+		address = vma_address(page, vma);
+		if (address != NOADDR) {
+			ret = try_to_unmap_one(
+				page, vma->vm_mm, address, mapcount, vma);
+			if (ret == SWAP_FAIL || !*mapcount)
+				goto out;
+		}
 	}
 
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
-		ret = try_to_unmap_obj_one(vma, page);
-		if (ret == SWAP_FAIL || !page->mapcount)
-			goto out;
+		if (!vma->vm_mm->rss)
+			continue;
+		address = vma_address(page, vma);
+		if (address != NOADDR) {
+			ret = try_to_unmap_one(
+				page, vma->vm_mm, address, mapcount, vma);
+			if (ret == SWAP_FAIL || !*mapcount)
+				goto out;
+		}
 	}
 
 out:
@@ -385,6 +630,7 @@ out:
  */
 int fastcall try_to_unmap(struct page * page)
 {
+	int mapcount = page->mapcount;
 	int ret;
 
 	BUG_ON(PageReserved(page));
@@ -392,9 +638,9 @@ int fastcall try_to_unmap(struct page * 
 	BUG_ON(!page->mapcount);
 
 	if (PageAnon(page))
-		ret = try_to_unmap_anon(page);
+		ret = try_to_unmap_anon(page, &mapcount);
 	else
-		ret = try_to_unmap_obj(page);
+		ret = try_to_unmap_obj(page, &mapcount);
 
 	if (!page->mapcount) {
 		if (page_test_and_clear_dirty(page))

