Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263264AbTCTXHF>; Thu, 20 Mar 2003 18:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263259AbTCTXGH>; Thu, 20 Mar 2003 18:06:07 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:57249 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S263235AbTCTXDE>; Thu, 20 Mar 2003 18:03:04 -0500
Date: Thu, 20 Mar 2003 23:15:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: [PATCH] anobjrmap 4/6 anonmm
In-Reply-To: <Pine.LNX.4.44.0303202310440.2743-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303202315191.2743-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anobjrmap 4/6 add anonmm to track anonymous pages

Introduce struct anonmm per mm to track anonymous pages,
all forks from one exec share same bundle of linked anonmms:
anonymous pages may start out in one mm but get forked into
another later.  Callouts from fork.c to rmap.c to allocate,
dup and exit anonmm.

page_add_rmap now takes page*, vma*, uvaddr, anon args.
In file-backed case, vma will be used to check whether uvaddr
matches vma_address from page->index and vm_pgoff: nonlinear
handled in next the patch.  In anonymous case, vma used to find
vma->vm_mm->anonmm to save in page->mapping, uvaddr in index.

page_referenced and try_to_unmap call _anon or _obj variants
to process lists, which call _one for each vma or anonmm.

put_dirty_page (put_dirty_page? odd, let's call it put_stack_page)
in exec.c take vma* instead of tsk*, it's always on current anyway.
Make a habit of raising rss before page_add_rmap, the loops skip
rss 0, partly to save time, but also to avoid catching child mm
when inconsistent between dup_rmap and dup_mmap.

 fs/exec.c             |   27 +--
 include/linux/mm.h    |    7 
 include/linux/rmap.h  |   16 +-
 include/linux/sched.h |    1 
 kernel/fork.c         |   21 ++
 mm/fremap.c           |    2 
 mm/memory.c           |    9 -
 mm/mremap.c           |    7 
 mm/rmap.c             |  380 +++++++++++++++++++++++++++++++++++++++++---------
 mm/swapfile.c         |    7 
 10 files changed, 381 insertions(+), 96 deletions(-)

--- anobjrmap3/fs/exec.c	Thu Mar 20 17:10:12 2003
+++ anobjrmap4/fs/exec.c	Thu Mar 20 17:10:23 2003
@@ -286,10 +286,12 @@
  * This routine is used to map in a page into an address space: needed by
  * execve() for the initial stack and environment pages.
  *
- * tsk->mmap_sem is held for writing.
+ * mm->mmap_sem is held for writing.
  */
-void put_dirty_page(struct task_struct * tsk, struct page *page, unsigned long address)
+void put_stack_page(struct vm_area_struct *mpnt,
+	struct page *page, unsigned long address)
 {
+	struct mm_struct *mm = mpnt->vm_mm;
 	pgd_t * pgd;
 	pmd_t * pmd;
 	pte_t * pte;
@@ -297,33 +299,33 @@
 	if (page_count(page) != 1)
 		printk(KERN_ERR "mem_map disagrees with %p at %08lx\n", page, address);
 
-	pgd = pgd_offset(tsk->mm, address);
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
 	flush_page_to_ram(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, PAGE_COPY))));
-	page_add_rmap(page, 1);
+	page_add_rmap(page, mpnt, address, 1);
 	pte_unmap(pte);
-	tsk->mm->rss++;
-	spin_unlock(&tsk->mm->page_table_lock);
+	spin_unlock(&mm->page_table_lock);
 
 	/* no need for flush_tlb */
 	return;
 out:
-	spin_unlock(&tsk->mm->page_table_lock);
+	spin_unlock(&mm->page_table_lock);
 	__free_page(page);
-	force_sig(SIGKILL, tsk);
+	force_sig(SIGKILL, current);
 	return;
 }
 
@@ -416,7 +418,7 @@
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;
-			put_dirty_page(current,page,stack_base);
+			put_stack_page(mpnt,page,stack_base);
 		}
 		stack_base += PAGE_SIZE;
 	}
@@ -429,7 +431,6 @@
 
 #else
 
-#define put_dirty_page(tsk, page, address)
 #define setup_arg_pages(bprm)			(0)
 static inline void free_arg_pages(struct linux_binprm *bprm)
 {
--- anobjrmap3/include/linux/mm.h	Thu Mar 20 17:10:12 2003
+++ anobjrmap4/include/linux/mm.h	Thu Mar 20 17:10:23 2003
@@ -577,12 +577,19 @@
 extern unsigned int nr_used_zone_pages(void);
 
 #ifdef CONFIG_MMU
+extern void put_stack_page(struct vm_area_struct *,
+		struct page *, unsigned long);
 extern struct page * vmalloc_to_page(void *addr);
 extern struct page * follow_page(struct mm_struct *mm, unsigned long address,
 		int write);
 extern int remap_page_range(struct vm_area_struct *vma, unsigned long from,
 		unsigned long to, unsigned long size, pgprot_t prot);
 #else
+static inline void put_stack_page(struct vm_area_struct *,
+		struct page *, unsigned long)
+{
+	return;
+}
 static inline struct page * vmalloc_to_page(void *addr)
 {
 	return NULL;
--- anobjrmap3/include/linux/rmap.h	Thu Mar 20 17:10:12 2003
+++ anobjrmap4/include/linux/rmap.h	Thu Mar 20 17:10:23 2003
@@ -8,7 +8,9 @@
 #include <linux/linkage.h>
 
 #ifdef CONFIG_MMU
-void FASTCALL(page_add_rmap(struct page *, int anon));
+void page_add_rmap(struct page *, struct vm_area_struct *,
+			unsigned long addr, int anon);
+void page_turn_rmap(struct page *, struct vm_area_struct *);
 void FASTCALL(page_dup_rmap(struct page *));
 void FASTCALL(page_remove_rmap(struct page *));
 
@@ -18,10 +20,22 @@
 int FASTCALL(page_referenced(struct page *));
 int FASTCALL(try_to_unmap(struct page *));
 
+/*
+ * Called from kernel/fork.c to manage anonymous memory
+ */
+void init_rmap(void);
+int exec_rmap(struct mm_struct *);
+int dup_rmap(struct mm_struct *, struct mm_struct *oldmm);
+void exit_rmap(struct mm_struct *);
+
 #else	/* !CONFIG_MMU */
 
 #define page_referenced(page)	TestClearPageReferenced(page)
 #define try_to_unmap(page)	SWAP_FAIL
+#define init_rmap()		do {} while (0)
+#define exec_rmap(mm)		(0)
+#define dup_rmap(mm, oldmm)	(0)
+#define exit_rmap(mm)		do {} while (0)
 
 #endif /* CONFIG_MMU */
 
--- anobjrmap3/include/linux/sched.h	Wed Mar 19 11:05:16 2003
+++ anobjrmap4/include/linux/sched.h	Thu Mar 20 17:10:23 2003
@@ -198,6 +198,7 @@
 						 * together off init_mm.mmlist, and are protected
 						 * by mmlist_lock
 						 */
+	struct anonmm *anonmm;			/* For rmap to track anon mem */
 
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
--- anobjrmap3/kernel/fork.c	Wed Mar 19 11:05:16 2003
+++ anobjrmap4/kernel/fork.c	Thu Mar 20 17:10:23 2003
@@ -30,6 +30,7 @@
 #include <linux/futex.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
+#include <linux/rmap.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -333,6 +334,7 @@
 	vm_unacct_memory(charge);
 	goto out;
 }
+
 static inline int mm_alloc_pgd(struct mm_struct * mm)
 {
 	mm->pgd = pgd_alloc(mm);
@@ -377,7 +379,6 @@
 	free_mm(mm);
 	return NULL;
 }
-	
 
 /*
  * Allocate and initialize an mm_struct.
@@ -389,9 +390,14 @@
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
@@ -418,6 +424,7 @@
 		spin_unlock(&mmlist_lock);
 		exit_aio(mm);
 		exit_mmap(mm);
+		exit_rmap(mm);
 		mmdrop(mm);
 	}
 }
@@ -504,6 +511,12 @@
 	if (!mm_init(mm))
 		goto fail_nomem;
 
+	if (dup_rmap(mm, oldmm)) {
+		mm_free_pgd(mm);
+		free_mm(mm);
+		goto fail_nomem;
+	}
+
 	if (init_new_context(tsk,mm))
 		goto free_pt;
 
@@ -1177,4 +1190,6 @@
 			SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if(!mm_cachep)
 		panic("vma_init: Cannot alloc mm_struct SLAB cache");
+
+	init_rmap();
 }
--- anobjrmap3/mm/fremap.c	Thu Mar 20 17:10:12 2003
+++ anobjrmap4/mm/fremap.c	Thu Mar 20 17:10:23 2003
@@ -75,7 +75,7 @@
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, prot);
 	set_pte(pte, entry);
-	page_add_rmap(page, 0);
+	page_add_rmap(page, vma, addr, 0);
 	pte_unmap(pte);
 	if (flush)
 		flush_tlb_page(vma, addr);
--- anobjrmap3/mm/memory.c	Thu Mar 20 17:10:12 2003
+++ anobjrmap4/mm/memory.c	Thu Mar 20 17:10:23 2003
@@ -940,6 +940,7 @@
 			flush_cache_page(vma, address);
 			establish_pte(vma, address, page_table,
 				pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
+			page_turn_rmap(old_page, vma);
 			pte_unmap(page_table);
 			ret = VM_FAULT_MINOR;
 			goto out;
@@ -969,7 +970,7 @@
 		else
 			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
-		page_add_rmap(new_page, 1);
+		page_add_rmap(new_page, vma, address, 1);
 		lru_cache_add_active(new_page);
 
 		/* Free the old page.. */
@@ -1170,7 +1171,7 @@
 	flush_page_to_ram(page);
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
-	page_add_rmap(page, 1);
+	page_add_rmap(page, vma, address, 1);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
@@ -1227,7 +1228,7 @@
 
 	set_pte(page_table, entry);
 	/* ignores ZERO_PAGE */
-	page_add_rmap(page, 1);
+	page_add_rmap(page, vma, addr, 1);
 	pte_unmap(page_table);
 
 	/* No need to invalidate - it was non-present before */
@@ -1312,7 +1313,7 @@
 		if (write_access)
 			entry = pte_mkwrite(pte_mkdirty(entry));
 		set_pte(page_table, entry);
-		page_add_rmap(new_page, anon);
+		page_add_rmap(new_page, vma, address, anon);
 		pte_unmap(page_table);
 	} else {
 		/* One of our sibling threads was faster, back out. */
--- anobjrmap3/mm/mremap.c	Thu Mar 20 17:10:12 2003
+++ anobjrmap4/mm/mremap.c	Thu Mar 20 17:10:23 2003
@@ -83,7 +83,8 @@
 }
 
 static int
-copy_one_pte(struct mm_struct *mm, pte_t *src, pte_t *dst)
+copy_one_pte(struct vm_area_struct *vma, pte_t *src, pte_t *dst,
+	unsigned long old_addr, unsigned long new_addr)
 {
 	pte_t pte;
 	struct page *page = NULL;
@@ -98,7 +99,7 @@
 		if (page) {
 			int anon = PageAnon(page);
 			page_remove_rmap(page);
-			page_add_rmap(page, anon);
+			page_add_rmap(page, vma, new_addr, anon);
 		}
 	}
 	return 0;
@@ -127,7 +128,7 @@
 		dst = alloc_one_pte_map(mm, new_addr);
 		if (src == NULL)
 			src = get_one_pte_map_nested(mm, old_addr);
-		error = copy_one_pte(mm, src, dst);
+		error = copy_one_pte(vma, src, dst, old_addr, new_addr);
 		pte_unmap_nested(src);
 		pte_unmap(dst);
 	}
--- anobjrmap3/mm/rmap.c	Thu Mar 20 17:10:12 2003
+++ anobjrmap4/mm/rmap.c	Thu Mar 20 17:10:23 2003
@@ -29,45 +29,165 @@
 
 #define page_mapcount(page)	((page)->rmap_count)
 
+#define NOADDR	(~0UL)		/* impossible user virtual address */
+
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
 /*
- * Something oopsable to put for now in the page->mapping
- * of an anonymous page, to test that it is ignored.
+ * At what user virtual address is page expected in file-backed vma?
  */
-#define ANON_MAPPING_DEBUG	((struct address_space *) 1)
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
+ ** Functions for creating and destroying struct anonmm.
+ **/
+
+void __init
+init_rmap(void)
+{
+	anonmm_cachep = kmem_cache_create("anonmm",
+			sizeof(struct anonmm), 0,
+			SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (!anonmm_cachep)
+		panic("init_rmap: Cannot alloc anonmm SLAB cache");
+}
+
+int
+exec_rmap(struct mm_struct *mm)
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
+int
+dup_rmap(struct mm_struct *mm, struct mm_struct *oldmm)
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
+void
+exit_rmap(struct mm_struct *mm)
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
+static void
+free_anonmm(struct anonmm *anonmm)
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
 
 static inline void
 clear_page_anon(struct page *page)
 {
-	BUG_ON(page->mapping != ANON_MAPPING_DEBUG);
+	struct anonmm *anonmm = (struct anonmm *) page->mapping;
+
 	page->mapping = NULL;
 	ClearPageAnon(page);
+	if (atomic_dec_and_test(&anonmm->count))
+		free_anonmm(anonmm);
 }
 
 /**
  ** Subfunctions of page_referenced: page_referenced_one called
- ** repeatedly from page_referenced_obj.
+ ** repeatedly from either page_referenced_anon or page_referenced_obj.
  **/
 
 static int
-page_referenced_one(struct page *page, struct vm_area_struct *vma)
+page_referenced_one(struct page *page, struct mm_struct *mm,
+	unsigned long address, unsigned long *mapcount)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long loffset;
-	unsigned long address;
 	int referenced = 0;
 
-	loffset = (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
-	if (loffset < vma->vm_pgoff)
-		goto out;
-
-	address = vma->vm_start + ((loffset - vma->vm_pgoff) << PAGE_SHIFT);
-
-	if (address >= vma->vm_end)
-		goto out;
-
 	if (!spin_trylock(&mm->page_table_lock)) {
 		referenced = 1;
 		goto out;
@@ -91,6 +211,8 @@
 	if (ptep_test_and_clear_young(pte))
 		referenced++;
 
+	(*mapcount)--;
+
 out_unmap:
 	pte_unmap(pte);
 
@@ -102,21 +224,69 @@
 }
 
 static inline int
-page_referenced_obj(struct page *page)
+page_referenced_anon(struct page *page, unsigned long *mapcount)
+{
+	struct anonmm *anonmm = (struct anonmm *) page->mapping;
+	struct anonmm *anonhd = anonmm->head;
+	struct list_head *seek_head;
+	int referenced = 0;
+
+	spin_lock(&anonhd->lock);
+	if (anonmm->mm && anonmm->mm->rss) {
+		referenced += page_referenced_one(
+			page, anonmm->mm, page->index, mapcount);
+		if (!*mapcount)
+			goto out;
+	}
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
+	return referenced;
+}
+
+static inline int
+page_referenced_obj(struct page *page, unsigned long *mapcount)
 {
 	struct address_space *mapping = page->mapping;
 	struct vm_area_struct *vma;
+	unsigned long address;
 	int referenced = 0;
 
 	if (down_trylock(&mapping->i_shared_sem))
 		return 1;
 
-	list_for_each_entry(vma, &mapping->i_mmap, shared)
-		referenced += page_referenced_one(page, vma);
-
-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared)
-		referenced += page_referenced_one(page, vma);
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
 	return referenced;
 }
@@ -132,28 +302,38 @@
 int
 page_referenced(struct page *page)
 {
+	unsigned long mapcount;
 	int referenced;
 
 	referenced = !!TestClearPageReferenced(page);
-	if (page_mapcount(page) && page->mapping && !PageAnon(page))
-		referenced += page_referenced_obj(page);
+	mapcount = page_mapcount(page);
+	if (mapcount && page->mapping) {
+		referenced += PageAnon(page)?
+			page_referenced_anon(page, &mapcount):
+			page_referenced_obj(page, &mapcount);
+	}
 	return referenced;
 }
 
 /**
  * page_add_rmap - add reverse mapping entry to a page
  * @page:	the page to add the mapping to
+ * @vma:	the vma into which this page is being mapped
+ * @address:	the virtual address at which page is mapped
  * @anon:	is this an anonymous (not file-backed) page?
  *
  * For general use: Add a new reverse mapping to a page.
  * The caller needs to hold the mm->page_table_lock.
  */
 void
-page_add_rmap(struct page *page, int anon)
+page_add_rmap(struct page *page, struct vm_area_struct *vma,
+	unsigned long address, int anon)
 {
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
 		return;
 
+	address &= PAGE_MASK;
+
 	rmap_lock(page);
 
 	if (!page_mapped(page))
@@ -168,8 +348,11 @@
 		}
 	} else {
 		if (anon) {
+			struct anonmm *anonmm = vma->vm_mm->anonmm;
 			SetPageAnon(page);
-			page->mapping = ANON_MAPPING_DEBUG;
+			page->index = address;
+			page->mapping = (struct address_space *) anonmm;
+			atomic_inc(&anonmm->count);
 		} else {
 			/*
 			 * Driver did not assign page->mapping,
@@ -198,6 +381,35 @@
 }
 
 /**
+ * page_turn_rmap - turn reverse mapping from one mm to another.
+ * @page:	the anonymous page originally mapped into some vma
+ * @vma:	the new vma into which this page is now being mapped
+ *
+ * For do_wp_page only: update exclusive page with new mm,
+ * so that it can be located more quickly later on.
+ */
+void
+page_turn_rmap(struct page *page, struct vm_area_struct *vma)
+{
+	struct anonmm *old_anonmm = (struct anonmm *) page->mapping;
+	struct anonmm *new_anonmm = vma->vm_mm->anonmm;
+
+	BUG_ON(!PageAnon(page));
+	BUG_ON(page_mapcount(page) != 1);
+	if (new_anonmm == old_anonmm)
+		return;
+	/*
+	 * Take rmap_lock since we don't hold old mm's page_table_lock.
+	 */
+	rmap_lock(page);
+	clear_page_anon(page);
+	SetPageAnon(page);
+	page->mapping = (struct address_space *) new_anonmm;
+	atomic_inc(&new_anonmm->count);
+	rmap_unlock(page);
+}
+
+/**
  * page_remove_rmap - take down reverse mapping to a page
  * @page: page to remove mapping from
  *
@@ -227,30 +439,20 @@
 
 /**
  ** Subfunctions of try_to_unmap: try_to_unmap_one called
- ** repeatedly from try_to_unmap_obj.
+ ** repeatedly from either try_to_unmap_anon or try_to_unmap_obj.
  **/
 
 static int
-try_to_unmap_one(struct page *page, struct vm_area_struct *vma)
+try_to_unmap_one(struct page *page, struct mm_struct *mm,
+	unsigned long address, unsigned long *mapcount,
+	struct vm_area_struct *vma)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
 	pte_t pteval;
-	unsigned long loffset;
-	unsigned long address;
 	int ret = SWAP_AGAIN;
 
-	loffset = (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
-	if (loffset < vma->vm_pgoff)
-		goto out;
-
-	address = vma->vm_start + ((loffset - vma->vm_pgoff) << PAGE_SHIFT);
-
-	if (address >= vma->vm_end)
-		goto out;
-
 	/*
 	 * We need the page_table_lock to protect us from page faults,
 	 * munmap, fork, etc...
@@ -273,8 +475,15 @@
 	if (page_to_pfn(page) != pte_pfn(*pte))
 		goto out_unmap;
 
-	/* If the page is mlock()d, we cannot swap it out. */
-	if (vma->vm_flags & VM_LOCKED) {
+	(*mapcount)--;
+
+	/*
+	 * If the page is mlock()d, we cannot swap it out.
+	 * During mremap, it's possible pages are not in a VMA.
+	 */
+	if (!vma)
+		vma = find_vma(mm, address);
+	if (!vma || (vma->vm_flags & VM_LOCKED)) {
 		ret =  SWAP_FAIL;
 		goto out_unmap;
 	}
@@ -284,11 +493,6 @@
 	pteval = ptep_get_and_clear(pte);
 	flush_tlb_page(vma, address);
 
-	/*
-	 * This block makes no sense in this subpatch: neither anon
-	 * pages nor nonlinear pages get here.  But we want to hold on
-	 * to this code, to use in later patches which correct that.
-	 */
 	if (PageAnon(page)) {
 		swp_entry_t entry = { .val = page->private };
 		/*
@@ -300,15 +504,12 @@
 		set_pte(pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
 	} else {
-		unsigned long pgidx;
 		/*
-		 * If a nonlinear mapping from sys_remap_file_pages,
-		 * then store the file page offset in the pte.
+		 * This only comes into play with the next patch...
+		 * If a nonlinear mapping then store
+		 * the file page offset in the pte.
 		 */
-		pgidx = (address - vma->vm_start) >> PAGE_SHIFT;
-		pgidx += vma->vm_pgoff;
-		pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
-		if (page->index != pgidx) {
+		if (address != vma_address(page, vma)) {
 			set_pte(pte, pgoff_to_pte(page->index));
 			BUG_ON(!pte_file(*pte));
 		}
@@ -318,10 +519,10 @@
 	if (pte_dirty(pteval))
 		set_page_dirty(page);
 
-	mm->rss--;
 	BUG_ON(!page_mapcount(page));
 	page_mapcount(page)--;
 	page_cache_release(page);
+	mm->rss--;
 
 out_unmap:
 	pte_unmap(pte);
@@ -334,25 +535,67 @@
 }
 
 static inline int
-try_to_unmap_obj(struct page *page)
+try_to_unmap_anon(struct page *page, unsigned long *mapcount)
+{
+	struct anonmm *anonmm = (struct anonmm *) page->mapping;
+	struct anonmm *anonhd = anonmm->head;
+	struct list_head *seek_head;
+	int ret = SWAP_AGAIN;
+
+	spin_lock(&anonhd->lock);
+	if (anonmm->mm && anonmm->mm->rss) {
+		ret = try_to_unmap_one(
+			page, anonmm->mm, page->index, mapcount, NULL);
+		if (ret == SWAP_FAIL || !*mapcount)
+			goto out;
+	}
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
+}
+
+static inline int
+try_to_unmap_obj(struct page *page, unsigned long *mapcount)
 {
 	struct address_space *mapping = page->mapping;
 	struct vm_area_struct *vma;
+	unsigned long address;
 	int ret = SWAP_AGAIN;
 
 	if (down_trylock(&mapping->i_shared_sem))
 		return ret;
 
 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
-		ret = try_to_unmap_one(page, vma);
-		if (ret == SWAP_FAIL)
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
-		ret = try_to_unmap_one(page, vma);
-		if (ret == SWAP_FAIL)
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
@@ -375,14 +618,17 @@
 int
 try_to_unmap(struct page *page)
 {
-	int ret = SWAP_FAIL;
+	unsigned long mapcount;
+	int ret;
 
 	BUG_ON(PageReserved(page));
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!page_mapped(page));
 
-	if (!PageAnon(page))
-		ret = try_to_unmap_obj(page);
+	mapcount = page_mapcount(page);
+	ret = PageAnon(page)?
+		try_to_unmap_anon(page, &mapcount):
+		try_to_unmap_obj(page, &mapcount);
 
 	if (!page_mapped(page)) {
 		dec_page_state(nr_mapped);
--- anobjrmap3/mm/swapfile.c	Thu Mar 20 17:10:12 2003
+++ anobjrmap4/mm/swapfile.c	Thu Mar 20 17:10:23 2003
@@ -396,11 +396,11 @@
 		return;
 	if (unlikely(pte_none(pte) || pte_present(pte)))
 		return;
+	vma->vm_mm->rss++;
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
-	page_add_rmap(page, 1);
+	page_add_rmap(page, vma, address, 1);
 	swap_free(entry);
-	++vma->vm_mm->rss;
 }
 
 /* mmlist_lock and vma->vm_mm->page_table_lock are held */
@@ -425,8 +425,7 @@
 	if (end > PMD_SIZE)
 		end = PMD_SIZE;
 	do {
-		unuse_pte(vma, offset+address-vma->vm_start,
-				pte, entry, page);
+		unuse_pte(vma, offset + address, pte, entry, page);
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));

