Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbUDOXeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 19:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUDOXeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 19:34:09 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50458 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261752AbUDOXdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 19:33:36 -0400
Date: Fri, 16 Apr 2004 00:33:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmap 10 add anonmm rmap
In-Reply-To: <Pine.LNX.4.44.0404160030330.10431-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0404160032331.10431-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmap 10 anonmm to track anonymous pages

Hugh's anonmm object-based reverse mapping scheme for anonymous pages.
We have not yet decided whether to adopt this scheme, or Andrea's more
advanced anon_vma scheme.  anonmm is easier for me to merge quickly,
to replace the pte_chain rmap taken out in the previous patch;
a patch to install Andrea's anon_vma will follow in due course.

Why build up and tear down chains of pte pointers for anonymous pages,
when a page can only appear at one particular address, in a restricted
group of mms that might share it?  (Except: see next patch on mremap.)

Introduce struct anonmm per mm to track anonymous pages, all forks from
one exec sharing the same bundle of linked anonmms.  Anonymous pages
originate in one mm, but may be forked into another mm of the bundle
later on.  Callouts from fork.c to allocate, dup and exit the anonmm
structure private to rmap.c.

 include/linux/rmap.h  |   13 ++
 include/linux/sched.h |    1 
 kernel/fork.c         |   18 +++
 mm/rmap.c             |  237 +++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 264 insertions(+), 5 deletions(-)

--- rmap9/include/linux/rmap.h	2004-04-15 20:23:55.469969032 +0100
+++ rmap10/include/linux/rmap.h	2004-04-15 20:24:06.976219816 +0100
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
 
--- rmap9/include/linux/sched.h	2004-04-15 09:01:59.349786976 +0100
+++ rmap10/include/linux/sched.h	2004-04-15 20:24:06.978219512 +0100
@@ -215,6 +215,7 @@ struct mm_struct {
 						 * together off init_mm.mmlist, and are protected
 						 * by mmlist_lock
 						 */
+	struct anonmm *anonmm;			/* For rmap to track anon mem */
 
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
--- rmap9/kernel/fork.c	2004-04-15 09:01:59.495764784 +0100
+++ rmap10/kernel/fork.c	2004-04-15 20:24:06.980219208 +0100
@@ -33,6 +33,7 @@
 #include <linux/ptrace.h>
 #include <linux/mount.h>
 #include <linux/audit.h>
+#include <linux/rmap.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -426,9 +427,14 @@ struct mm_struct * mm_alloc(void)
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
@@ -455,6 +461,7 @@ void mmput(struct mm_struct *mm)
 		spin_unlock(&mmlist_lock);
 		exit_aio(mm);
 		exit_mmap(mm);
+		exit_rmap(mm);
 		mmdrop(mm);
 	}
 }
@@ -558,6 +565,12 @@ static int copy_mm(unsigned long clone_f
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
 
@@ -1270,4 +1283,5 @@ void __init proc_caches_init(void)
 	mm_cachep = kmem_cache_create("mm_struct",
 			sizeof(struct mm_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+	init_rmap();
 }
--- rmap9/mm/rmap.c	2004-04-15 20:23:55.482967056 +0100
+++ rmap10/mm/rmap.c	2004-04-15 20:24:06.983218752 +0100
@@ -27,10 +27,123 @@
 
 #include <asm/tlbflush.h>
 
+/*
+ * struct anonmm: to track a bundle of anonymous memory mappings.
+ *
+ * Could be embedded in mm_struct, but mm_struct is rather heavyweight,
+ * and we may need the anonmm to stay around long after the mm_struct
+ * and its pgd have been freed: because pages originally faulted into
+ * that mm have been duped into forked mms, and still need tracking.
+ */
+struct anonmm {
+	atomic_t	 count;	/* ref count, including 1 per page */
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
+			sizeof(struct anonmm), 0, SLAB_PANIC, NULL, NULL);
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
@@ -103,7 +216,69 @@ out_unlock:
 
 static inline int page_referenced_anon(struct page *page)
 {
-	return 1;	/* until next patch */
+	unsigned int mapcount = page->mapcount;
+	struct anonmm *anonmm = (struct anonmm *) page->mapping;
+	struct anonmm *anonhd = anonmm->head;
+	struct anonmm *new_anonmm = anonmm;
+	struct list_head *seek_head;
+	int referenced = 0;
+	int failed = 0;
+
+	spin_lock(&anonhd->lock);
+	/*
+	 * First try the indicated mm, it's the most likely.
+	 * Make a note to migrate the page if this mm is extinct.
+	 */
+	if (!anonmm->mm)
+		new_anonmm = NULL;
+	else if (anonmm->mm->rss) {
+		referenced += page_referenced_one(page,
+			anonmm->mm, page->index, &mapcount, &failed);
+		if (!mapcount)
+			goto out;
+	}
+
+	/*
+	 * Then down the rest of the list, from that as the head.  Stop
+	 * when we reach anonhd?  No: although a page cannot get dup'ed
+	 * into an older mm, once swapped, its indicated mm may not be
+	 * the oldest, just the first into which it was faulted back.
+	 * If original mm now extinct, note first to contain the page.
+	 */
+	seek_head = &anonmm->list;
+	list_for_each_entry(anonmm, seek_head, list) {
+		if (!anonmm->mm || !anonmm->mm->rss)
+			continue;
+		referenced += page_referenced_one(page,
+			anonmm->mm, page->index, &mapcount, &failed);
+		if (!new_anonmm && mapcount < page->mapcount)
+			new_anonmm = anonmm;
+		if (!mapcount) {
+			anonmm = (struct anonmm *) page->mapping;
+			if (new_anonmm == anonmm)
+				goto out;
+			goto migrate;
+		}
+	}
+
+	WARN_ON(!failed);
+out:
+	spin_unlock(&anonhd->lock);
+	return referenced;
+
+migrate:
+	/*
+	 * Migrate pages away from an extinct mm, so that its anonmm
+	 * can be freed in due course: we could leave this to happen
+	 * through the natural attrition of try_to_unmap, but that
+	 * would miss locked pages and frequently referenced pages.
+	 */
+	spin_unlock(&anonhd->lock);
+	page->mapping = (void *) new_anonmm;
+	atomic_inc(&new_anonmm->count);
+	if (atomic_dec_and_test(&anonmm->count))
+		free_anonmm(anonmm);
+	return referenced;
 }
 
 /**
@@ -214,6 +389,8 @@ int fastcall page_referenced(struct page
 void fastcall page_add_anon_rmap(struct page *page,
 	struct mm_struct *mm, unsigned long address)
 {
+	struct anonmm *anonmm = mm->anonmm;
+
 	BUG_ON(PageReserved(page));
 	BUG_ON(page_mapping(page));
 
@@ -221,7 +398,8 @@ void fastcall page_add_anon_rmap(struct 
 	if (!page->mapcount) {
 		SetPageAnon(page);
 		page->index = address & PAGE_MASK;
-		page->mapping = (void *) mm;	/* until next patch */
+		page->mapping = (void *) anonmm;
+		atomic_inc(&anonmm->count);
 		inc_page_state(nr_mapped);
 	}
 	page->mapcount++;
@@ -309,6 +487,13 @@ static int try_to_unmap_one(struct page 
 
 	(*mapcount)--;
 
+	if (!vma) {
+		vma = find_vma(mm, address);
+		/* unmap_vmas drops page_table_lock with vma unlinked */
+		if (!vma)
+			goto out_unmap;
+	}
+
 	/*
 	 * If the page is mlock()d, we cannot swap it out.
 	 * If it's recently referenced (perhaps page_referenced
@@ -328,6 +513,18 @@ static int try_to_unmap_one(struct page 
 	if (pte_dirty(pteval))
 		set_page_dirty(page);
 
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
 	mm->rss--;
 	BUG_ON(!page->mapcount);
 	page->mapcount--;
@@ -433,7 +630,41 @@ out_unlock:
 
 static inline int try_to_unmap_anon(struct page *page)
 {
-	return SWAP_FAIL;	/* until next patch */
+	unsigned int mapcount = page->mapcount;
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
+		ret = try_to_unmap_one(page,
+			anonmm->mm, page->index, &mapcount, NULL);
+		if (ret == SWAP_FAIL || !mapcount)
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
+		ret = try_to_unmap_one(page,
+			anonmm->mm, page->index, &mapcount, NULL);
+		if (ret == SWAP_FAIL || !mapcount)
+			goto out;
+	}
+out:
+	spin_unlock(&anonhd->lock);
+	return ret;
 }
 
 /**

