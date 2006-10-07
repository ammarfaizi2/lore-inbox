Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751778AbWJGNHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbWJGNHN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 09:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWJGNHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 09:07:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:37298 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751777AbWJGNGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 09:06:39 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>
Message-Id: <20061007105853.14024.95383.sendpatchset@linux.site>
In-Reply-To: <20061007105758.14024.70048.sendpatchset@linux.site>
References: <20061007105758.14024.70048.sendpatchset@linux.site>
Subject: [patch 3/3] mm: fault handler to replace nopage and populate
Date: Sat,  7 Oct 2006 15:06:32 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nonlinear mappings are (AFAIKS) simply a virtual memory concept that
encodes the virtual address -> file offset differently from linear
mappings.

I can't see why the filesystem/pagecache code should need to know anything
about it, except for the fact that the ->nopage handler didn't quite pass
down enough information (ie. pgoff). But it is more logical to pass pgoff
rather than have the ->nopage function calculate it itself anyway. And
having the nopage handler install the pte itself is sort of nasty.

This patch introduces a new fault handler that replaces ->nopage and ->populate
and (hopefully) ->page_mkwrite. Most of the old mechanism is still in place
so there is a lot of duplication and nice cleanups that can be removed if
everyone switches over.

The rationale for doing this in the first place is that nonlinear mappings
are subject to the pagefault vs invalidate/truncate race too, and it seemed
stupid to duplicate the synchronisation logic rather than just consolidate
the two.

Comments?

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -166,11 +166,12 @@ extern unsigned int kobjsize(const void 
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
 #define VM_INSERTPAGE	0x02000000	/* The vma has had "vm_insert_page()" done on it */
-#define VM_CAN_INVALIDATE	0x04000000	/* The mapping may be invalidated,
+#define VM_CAN_INVALIDATE 0x04000000	/* The mapping may be invalidated,
 					 * eg. truncate or invalidate_inode_*.
 					 * In this case, do_no_page must
 					 * return with the page locked.
 					 */
+#define VM_CAN_NONLINEAR 0x08000000	/* Has ->fault & does nonlinear pages */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
@@ -194,6 +195,23 @@ extern unsigned int kobjsize(const void 
  */
 extern pgprot_t protection_map[16];
 
+#define FAULT_FLAG_WRITE	0x01
+#define FAULT_FLAG_NONLINEAR	0x02
+
+/*
+ * fault_data is filled in the the pagefault handler and passed to the
+ * vma's ->fault function. That function is responsible for filling in
+ * 'type', which is the type of fault if a page is returned, or the type
+ * of error if NULL is returned.
+ */
+struct fault_data {
+	struct vm_area_struct *vma;
+	unsigned long address;
+	pgoff_t pgoff;
+	unsigned int flags;
+
+	int type;
+};
 
 /*
  * These are the virtual MM functions - opening of an area, closing and
@@ -203,6 +221,7 @@ extern pgprot_t protection_map[16];
 struct vm_operations_struct {
 	void (*open)(struct vm_area_struct * area);
 	void (*close)(struct vm_area_struct * area);
+	struct page * (*fault)(struct fault_data * data);
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int *type);
 	unsigned long (*nopfn)(struct vm_area_struct * area, unsigned long address);
 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
@@ -1028,9 +1047,7 @@ extern void truncate_inode_pages_range(s
 				       loff_t lstart, loff_t lend);
 
 /* generic vm_area_ops exported for stackable file systems */
-extern struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int *);
-extern int filemap_populate(struct vm_area_struct *, unsigned long,
-		unsigned long, pgprot_t, unsigned long, int);
+extern struct page *filemap_fault(struct fault_data *data);
 
 /* mm/page-writeback.c */
 int write_one_page(struct page *page, int wait);
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -2121,6 +2121,137 @@ oom:
 	return VM_FAULT_OOM;
 }
 
+static int __do_fault(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long address, pte_t *page_table, pmd_t *pmd,
+		pgoff_t pgoff, unsigned int flags, pte_t orig_pte)
+{
+	spinlock_t *ptl;
+	struct page *page, *faulted_page;
+	pte_t entry;
+	int anon = 0;
+	struct page *dirty_page = NULL;
+
+	struct fault_data fdata = {
+		.vma = vma,
+		.address = address & PAGE_MASK,
+		.pgoff = pgoff,
+		.flags = flags,
+	};
+
+	pte_unmap(page_table);
+	BUG_ON(vma->vm_flags & VM_PFNMAP);
+
+	faulted_page = vma->vm_ops->fault(&fdata);
+	if (unlikely(!faulted_page))
+		return fdata.type;
+
+	/*
+	 * For consistency in subsequent calls, make the faulted_page always
+	 * locked.  These should be in the minority but if they turn out to be
+	 * critical then this can always be revisited
+	 */
+	if (unlikely(!(vma->vm_flags & VM_CAN_INVALIDATE)))
+		lock_page(faulted_page);
+	else
+		BUG_ON(!PageLocked(faulted_page));
+
+	/*
+	 * Should we do an early C-O-W break?
+	 */
+	page = faulted_page;
+	if (flags & FAULT_FLAG_WRITE) {
+		if (!(vma->vm_flags & VM_SHARED)) {
+			anon = 1;
+			if (unlikely(anon_vma_prepare(vma))) {
+				fdata.type = VM_FAULT_OOM;
+				goto out;
+			}
+			page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+			if (!page) {
+				fdata.type = VM_FAULT_OOM;
+				goto out;
+			}
+			copy_user_highpage(page, faulted_page, address);
+		}
+	}
+
+	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
+
+	/*
+	 * This silly early PAGE_DIRTY setting removes a race
+	 * due to the bad i386 page protection. But it's valid
+	 * for other architectures too.
+	 *
+	 * Note that if write_access is true, we either now have
+	 * an exclusive copy of the page, or this is a shared mapping,
+	 * so we can make it writable and dirty to avoid having to
+	 * handle that later.
+	 */
+	/* Only go through if we didn't race with anybody else... */
+	if (likely(pte_same(*page_table, orig_pte))) {
+		flush_icache_page(vma, page);
+		entry = mk_pte(page, vma->vm_page_prot);
+		if (flags & FAULT_FLAG_WRITE)
+			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		set_pte_at(mm, address, page_table, entry);
+		if (anon) {
+			inc_mm_counter(mm, anon_rss);
+			lru_cache_add_active(page);
+			page_add_new_anon_rmap(page, vma, address);
+		} else {
+			inc_mm_counter(mm, file_rss);
+			page_add_file_rmap(page);
+			if (flags & FAULT_FLAG_WRITE) {
+				dirty_page = page;
+				get_page(dirty_page);
+			}
+		}
+
+		/* no need to invalidate: a not-present page won't be cached */
+		update_mmu_cache(vma, address, entry);
+		lazy_mmu_prot_update(entry);
+	} else {
+		if (anon)
+			page_cache_release(page);
+		else
+			anon = 1; /* not anon, but release faulted_page */
+	}
+
+	pte_unmap_unlock(page_table, ptl);
+
+out:
+	unlock_page(faulted_page);
+	if (anon)
+		page_cache_release(faulted_page);
+	else if (dirty_page) {
+		set_page_dirty_balance(dirty_page);
+		put_page(dirty_page);
+	}
+
+	return fdata.type;
+}
+
+static int do_linear_fault(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long address, pte_t *page_table, pmd_t *pmd,
+		int write_access, pte_t orig_pte)
+{
+	pgoff_t pgoff = (((address & PAGE_MASK)
+			- vma->vm_start) >> PAGE_CACHE_SHIFT) + vma->vm_pgoff;
+	unsigned int flags = (write_access ? FAULT_FLAG_WRITE : 0);
+
+	return __do_fault(mm, vma, address, page_table, pmd, pgoff, flags, orig_pte);
+}
+
+static int do_nonlinear_fault(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long address, pte_t *page_table, pmd_t *pmd,
+		int write_access, pgoff_t pgoff, pte_t orig_pte)
+{
+	unsigned int flags = FAULT_FLAG_NONLINEAR |
+				(write_access ? FAULT_FLAG_WRITE : 0);
+
+	return __do_fault(mm, vma, address, page_table, pmd, pgoff, flags, orig_pte);
+}
+
 /*
  * do_no_page() tries to create a new page mapping. It aggressively
  * tries to share with existing pages, but makes a separate copy if
@@ -2327,9 +2458,14 @@ static int do_file_page(struct mm_struct
 		print_bad_pte(vma, orig_pte, address);
 		return VM_FAULT_OOM;
 	}
-	/* We can then assume vm->vm_ops && vma->vm_ops->populate */
 
 	pgoff = pte_to_pgoff(orig_pte);
+
+	if (vma->vm_ops && vma->vm_ops->fault)
+		return do_nonlinear_fault(mm, vma, address, page_table, pmd,
+					write_access, pgoff, orig_pte);
+
+	/* We can then assume vm->vm_ops && vma->vm_ops->populate */
 	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE,
 					vma->vm_page_prot, pgoff, 0);
 	if (err == -ENOMEM)
@@ -2364,10 +2500,12 @@ static inline int handle_pte_fault(struc
 	if (!pte_present(entry)) {
 		if (pte_none(entry)) {
 			if (vma->vm_ops) {
+				if (vma->vm_ops->fault)
+					return do_linear_fault(mm, vma, address,
+						pte, pmd, write_access, entry);
 				if (vma->vm_ops->nopage)
 					return do_no_page(mm, vma, address,
-							  pte, pmd,
-							  write_access);
+							pte, pmd, write_access);
 				if (unlikely(vma->vm_ops->nopfn))
 					return do_no_pfn(mm, vma, address, pte,
 							 pmd, write_access);
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1339,40 +1339,37 @@ static int fastcall page_cache_read(stru
 #define MMAP_LOTSAMISS  (100)
 
 /**
- * filemap_nopage - read in file data for page fault handling
- * @area:	the applicable vm_area
- * @address:	target address to read in
- * @type:	returned with VM_FAULT_{MINOR,MAJOR} if not %NULL
+ * filemap_fault - read in file data for page fault handling
+ * @data:	the applicable fault_data
  *
- * filemap_nopage() is invoked via the vma operations vector for a
+ * filemap_fault() is invoked via the vma operations vector for a
  * mapped memory region to read in file data during a page fault.
  *
  * The goto's are kind of ugly, but this streamlines the normal case of having
  * it in the page cache, and handles the special cases reasonably without
  * having a lot of duplicated code.
  */
-struct page *filemap_nopage(struct vm_area_struct *area,
-				unsigned long address, int *type)
+struct page *filemap_fault(struct fault_data *data)
 {
 	int error;
-	struct file *file = area->vm_file;
+	struct file *file = data->vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
 	struct file_ra_state *ra = &file->f_ra;
 	struct inode *inode = mapping->host;
 	struct page *page;
-	unsigned long size, pgoff;
-	int did_readaround = 0, majmin = VM_FAULT_MINOR;
+	unsigned long size;
+	int did_readaround = 0;
 
-	BUG_ON(!(area->vm_flags & VM_CAN_INVALIDATE));
+	data->type = VM_FAULT_MINOR;
 
-	pgoff = ((address-area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
+	BUG_ON(!(data->vma->vm_flags & VM_CAN_INVALIDATE));
 
 	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	if (pgoff >= size)
+	if (data->pgoff >= size)
 		goto outside_data_content;
 
 	/* If we don't want any read-ahead, don't bother */
-	if (VM_RandomReadHint(area))
+	if (VM_RandomReadHint(data->vma))
 		goto no_cached_page;
 
 	/*
@@ -1381,19 +1378,19 @@ struct page *filemap_nopage(struct vm_ar
 	 *
 	 * For sequential accesses, we use the generic readahead logic.
 	 */
-	if (VM_SequentialReadHint(area))
-		page_cache_readahead(mapping, ra, file, pgoff, 1);
+	if (VM_SequentialReadHint(data->vma))
+		page_cache_readahead(mapping, ra, file, data->pgoff, 1);
 
 	/*
 	 * Do we have something in the page cache already?
 	 */
 retry_find:
-	page = find_lock_page(mapping, pgoff);
+	page = find_lock_page(mapping, data->pgoff);
 	if (!page) {
 		unsigned long ra_pages;
 
-		if (VM_SequentialReadHint(area)) {
-			handle_ra_miss(mapping, ra, pgoff);
+		if (VM_SequentialReadHint(data->vma)) {
+			handle_ra_miss(mapping, ra, data->pgoff);
 			goto no_cached_page;
 		}
 		ra->mmap_miss++;
@@ -1410,7 +1407,7 @@ retry_find:
 		 * check did_readaround, as this is an inner loop.
 		 */
 		if (!did_readaround) {
-			majmin = VM_FAULT_MAJOR;
+			data->type = VM_FAULT_MAJOR;
 			count_vm_event(PGMAJFAULT);
 		}
 		did_readaround = 1;
@@ -1418,11 +1415,11 @@ retry_find:
 		if (ra_pages) {
 			pgoff_t start = 0;
 
-			if (pgoff > ra_pages / 2)
-				start = pgoff - ra_pages / 2;
+			if (data->pgoff > ra_pages / 2)
+				start = data->pgoff - ra_pages / 2;
 			do_page_cache_readahead(mapping, file, start, ra_pages);
 		}
-		page = find_lock_page(mapping, pgoff);
+		page = find_lock_page(mapping, data->pgoff);
 		if (!page)
 			goto no_cached_page;
 	}
@@ -1439,7 +1436,7 @@ retry_find:
 
 	/* Must recheck i_size under page lock */
 	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	if (unlikely(pgoff >= size)) {
+	if (unlikely(data->pgoff >= size)) {
 		unlock_page(page);
 		goto outside_data_content;
 	}
@@ -1448,8 +1445,6 @@ retry_find:
 	 * Found the page and have a reference on it.
 	 */
 	mark_page_accessed(page);
-	if (type)
-		*type = majmin;
 	return page;
 
 outside_data_content:
@@ -1457,15 +1452,17 @@ outside_data_content:
 	 * An external ptracer can access pages that normally aren't
 	 * accessible..
 	 */
-	if (area->vm_mm == current->mm)
-		return NOPAGE_SIGBUS;
+	if (data->vma->vm_mm == current->mm) {
+		data->type = VM_FAULT_SIGBUS;
+		return NULL;
+	}
 	/* Fall through to the non-read-ahead case */
 no_cached_page:
 	/*
 	 * We're only likely to ever get here if MADV_RANDOM is in
 	 * effect.
 	 */
-	error = page_cache_read(file, pgoff);
+	error = page_cache_read(file, data->pgoff);
 	grab_swap_token();
 
 	/*
@@ -1482,13 +1479,15 @@ no_cached_page:
 	 * to schedule I/O.
 	 */
 	if (error == -ENOMEM)
-		return NOPAGE_OOM;
-	return NOPAGE_SIGBUS;
+		data->type = VM_FAULT_OOM;
+	else
+		data->type = VM_FAULT_SIGBUS;
+	return NULL;
 
 page_not_uptodate:
 	/* IO error path */
 	if (!did_readaround) {
-		majmin = VM_FAULT_MAJOR;
+		data->type = VM_FAULT_MAJOR;
 		count_vm_event(PGMAJFAULT);
 	}
 
@@ -1507,186 +1506,13 @@ page_not_uptodate:
 
 	/* Things didn't work out. Return zero to tell the mm layer so. */
 	shrink_readahead_size_eio(file, ra);
-	return NOPAGE_SIGBUS;
-}
-EXPORT_SYMBOL(filemap_nopage);
-
-static struct page * filemap_getpage(struct file *file, unsigned long pgoff,
-					int nonblock)
-{
-	struct address_space *mapping = file->f_mapping;
-	struct page *page;
-	int error;
-
-	/*
-	 * Do we have something in the page cache already?
-	 */
-retry_find:
-	page = find_get_page(mapping, pgoff);
-	if (!page) {
-		if (nonblock)
-			return NULL;
-		goto no_cached_page;
-	}
-
-	/*
-	 * Ok, found a page in the page cache, now we need to check
-	 * that it's up-to-date.
-	 */
-	if (!PageUptodate(page)) {
-		if (nonblock) {
-			page_cache_release(page);
-			return NULL;
-		}
-		goto page_not_uptodate;
-	}
-
-success:
-	/*
-	 * Found the page and have a reference on it.
-	 */
-	mark_page_accessed(page);
-	return page;
-
-no_cached_page:
-	error = page_cache_read(file, pgoff);
-
-	/*
-	 * The page we want has now been added to the page cache.
-	 * In the unlikely event that someone removed it in the
-	 * meantime, we'll just come back here and read it again.
-	 */
-	if (error >= 0)
-		goto retry_find;
-
-	/*
-	 * An error return from page_cache_read can result if the
-	 * system is low on memory, or a problem occurs while trying
-	 * to schedule I/O.
-	 */
-	return NULL;
-
-page_not_uptodate:
-	lock_page(page);
-
-	/* Did it get truncated while we waited for it? */
-	if (!page->mapping) {
-		unlock_page(page);
-		goto err;
-	}
-
-	/* Did somebody else get it up-to-date? */
-	if (PageUptodate(page)) {
-		unlock_page(page);
-		goto success;
-	}
-
-	error = mapping->a_ops->readpage(file, page);
-	if (!error) {
-		wait_on_page_locked(page);
-		if (PageUptodate(page))
-			goto success;
-	} else if (error == AOP_TRUNCATED_PAGE) {
-		page_cache_release(page);
-		goto retry_find;
-	}
-
-	/*
-	 * Umm, take care of errors if the page isn't up-to-date.
-	 * Try to re-read it _once_. We do this synchronously,
-	 * because there really aren't any performance issues here
-	 * and we need to check for errors.
-	 */
-	lock_page(page);
-
-	/* Somebody truncated the page on us? */
-	if (!page->mapping) {
-		unlock_page(page);
-		goto err;
-	}
-	/* Somebody else successfully read it in? */
-	if (PageUptodate(page)) {
-		unlock_page(page);
-		goto success;
-	}
-
-	ClearPageError(page);
-	error = mapping->a_ops->readpage(file, page);
-	if (!error) {
-		wait_on_page_locked(page);
-		if (PageUptodate(page))
-			goto success;
-	} else if (error == AOP_TRUNCATED_PAGE) {
-		page_cache_release(page);
-		goto retry_find;
-	}
-
-	/*
-	 * Things didn't work out. Return zero to tell the
-	 * mm layer so, possibly freeing the page cache page first.
-	 */
-err:
-	page_cache_release(page);
-
+	data->type = VM_FAULT_SIGBUS;
 	return NULL;
 }
-
-int filemap_populate(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long len, pgprot_t prot, unsigned long pgoff,
-		int nonblock)
-{
-	struct file *file = vma->vm_file;
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	unsigned long size;
-	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
-	int err;
-
-	if (!nonblock)
-		force_page_cache_readahead(mapping, vma->vm_file,
-					pgoff, len >> PAGE_CACHE_SHIFT);
-
-repeat:
-	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	if (pgoff + (len >> PAGE_CACHE_SHIFT) > size)
-		return -EINVAL;
-
-	page = filemap_getpage(file, pgoff, nonblock);
-
-	/* XXX: This is wrong, a filesystem I/O error may have happened. Fix that as
-	 * done in shmem_populate calling shmem_getpage */
-	if (!page && !nonblock)
-		return -ENOMEM;
-
-	if (page) {
-		err = install_page(mm, vma, addr, page, prot);
-		if (err) {
-			page_cache_release(page);
-			return err;
-		}
-	} else if (vma->vm_flags & VM_NONLINEAR) {
-		/* No page was found just because we can't read it in now (being
-		 * here implies nonblock != 0), but the page may exist, so set
-		 * the PTE to fault it in later. */
-		err = install_file_pte(mm, vma, addr, pgoff, prot);
-		if (err)
-			return err;
-	}
-
-	len -= PAGE_SIZE;
-	addr += PAGE_SIZE;
-	pgoff++;
-	if (len)
-		goto repeat;
-
-	return 0;
-}
-EXPORT_SYMBOL(filemap_populate);
+EXPORT_SYMBOL(filemap_fault);
 
 struct vm_operations_struct generic_file_vm_ops = {
-	.nopage		= filemap_nopage,
-	.populate	= filemap_populate,
+	.fault		= filemap_fault,
 };
 
 /* This is used for a general mmap of a disk file */
@@ -1699,7 +1525,7 @@ int generic_file_mmap(struct file * file
 		return -ENOEXEC;
 	file_accessed(file);
 	vma->vm_ops = &generic_file_vm_ops;
-	vma->vm_flags |= VM_CAN_INVALIDATE;
+	vma->vm_flags |= VM_CAN_INVALIDATE | VM_CAN_NONLINEAR;
 	return 0;
 }
 
Index: linux-2.6/mm/fremap.c
===================================================================
--- linux-2.6.orig/mm/fremap.c
+++ linux-2.6/mm/fremap.c
@@ -115,6 +115,7 @@ int install_file_pte(struct mm_struct *m
 
 	set_pte_at(mm, addr, pte, pgoff_to_pte(pgoff));
 	pte_val = *pte;
+
 	/*
 	 * We don't need to run update_mmu_cache() here because the "file pte"
 	 * being installed by install_file_pte() is not a real pte - it's a
@@ -128,6 +129,25 @@ out:
 	return err;
 }
 
+static int populate_range(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long addr, unsigned long size, pgoff_t pgoff)
+{
+	int err;
+
+	do {
+		err = install_file_pte(mm, vma, addr, pgoff, vma->vm_page_prot);
+		if (err)
+			return err;
+
+		size -= PAGE_SIZE;
+		addr += PAGE_SIZE;
+		pgoff++;
+	} while (size);
+
+        return 0;
+
+}
+
 /***
  * sys_remap_file_pages - remap arbitrary pages of a shared backing store
  *                        file within an existing vma.
@@ -185,41 +205,56 @@ asmlinkage long sys_remap_file_pages(uns
 	 * the single existing vma.  vm_private_data is used as a
 	 * swapout cursor in a VM_NONLINEAR vma.
 	 */
-	if (vma && (vma->vm_flags & VM_SHARED) &&
-		(!vma->vm_private_data || (vma->vm_flags & VM_NONLINEAR)) &&
-		vma->vm_ops && vma->vm_ops->populate &&
-			end > start && start >= vma->vm_start &&
-				end <= vma->vm_end) {
-
-		/* Must set VM_NONLINEAR before any pages are populated. */
-		if (pgoff != linear_page_index(vma, start) &&
-		    !(vma->vm_flags & VM_NONLINEAR)) {
-			if (!has_write_lock) {
-				up_read(&mm->mmap_sem);
-				down_write(&mm->mmap_sem);
-				has_write_lock = 1;
-				goto retry;
-			}
-			mapping = vma->vm_file->f_mapping;
-			spin_lock(&mapping->i_mmap_lock);
-			flush_dcache_mmap_lock(mapping);
-			vma->vm_flags |= VM_NONLINEAR;
-			vma_prio_tree_remove(vma, &mapping->i_mmap);
-			vma_nonlinear_insert(vma, &mapping->i_mmap_nonlinear);
-			flush_dcache_mmap_unlock(mapping);
-			spin_unlock(&mapping->i_mmap_lock);
+	if (!vma || !(vma->vm_flags & VM_SHARED))
+		goto out;
+
+	if (vma->vm_private_data && !(vma->vm_flags & VM_NONLINEAR))
+		goto out;
+
+	if ((!vma->vm_ops || !vma->vm_ops->populate) &&
+					!(vma->vm_flags & VM_CAN_NONLINEAR))
+		goto out;
+
+	if (end <= start || start < vma->vm_start || end > vma->vm_end)
+		goto out;
+
+	/* Must set VM_NONLINEAR before any pages are populated. */
+	if (!(vma->vm_flags & VM_NONLINEAR)) {
+		/* Don't need a nonlinear mapping, exit success */
+		if (pgoff == linear_page_index(vma, start)) {
+			err = 0;
+			goto out;
 		}
 
-		err = vma->vm_ops->populate(vma, start, size,
-					    vma->vm_page_prot,
-					    pgoff, flags & MAP_NONBLOCK);
-
-		/*
-		 * We can't clear VM_NONLINEAR because we'd have to do
-		 * it after ->populate completes, and that would prevent
-		 * downgrading the lock.  (Locks can't be upgraded).
-		 */
+		if (!has_write_lock) {
+			up_read(&mm->mmap_sem);
+			down_write(&mm->mmap_sem);
+			has_write_lock = 1;
+			goto retry;
+		}
+		mapping = vma->vm_file->f_mapping;
+		spin_lock(&mapping->i_mmap_lock);
+		flush_dcache_mmap_lock(mapping);
+		vma->vm_flags |= VM_NONLINEAR;
+		vma_prio_tree_remove(vma, &mapping->i_mmap);
+		vma_nonlinear_insert(vma, &mapping->i_mmap_nonlinear);
+		flush_dcache_mmap_unlock(mapping);
+		spin_unlock(&mapping->i_mmap_lock);
 	}
+
+	if (vma->vm_flags & VM_CAN_NONLINEAR)
+		err = populate_range(mm, vma, start, size, pgoff);
+	else
+		err = vma->vm_ops->populate(vma, start, size, vma->vm_page_prot,
+					    	pgoff, flags & MAP_NONBLOCK);
+
+	/*
+	 * We can't clear VM_NONLINEAR because we'd have to do
+	 * it after ->populate completes, and that would prevent
+	 * downgrading the lock.  (Locks can't be upgraded).
+	 */
+
+out:
 	if (likely(!has_write_lock))
 		up_read(&mm->mmap_sem);
 	else
