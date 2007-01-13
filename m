Return-Path: <linux-kernel-owner+w=401wt.eu-S1161249AbXAMD3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161249AbXAMD3l (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161205AbXAMD3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:29:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:46798 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161250AbXAMD2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:28:34 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, thomas@tungstengraphics.com
Message-Id: <20070113011608.9479.66595.sendpatchset@linux.site>
In-Reply-To: <20070113011526.9479.79596.sendpatchset@linux.site>
References: <20070113011526.9479.79596.sendpatchset@linux.site>
Subject: [patch 4/7] mm: merge populate and nopage into fault (fixes nonlinear)
Date: Sat, 13 Jan 2007 04:28:24 +0100 (CET)
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

This patch introduces a new fault handler that replaces ->nopage and
->populate and (later) ->nopfn. Most of the old mechanism is still in place
so there is a lot of duplication and nice cleanups that can be removed if
everyone switches over.

The rationale for doing this in the first place is that nonlinear mappings
are subject to the pagefault vs invalidate/truncate race too, and it seemed
stupid to duplicate the synchronisation logic rather than just consolidate
the two.

After this patch, MAP_NONBLOCK no longer sets up ptes for pages present in
pagecache. Seems like a fringe functionality anyway.

NOPAGE_REFAULT is removed. This should be implemented with ->fault, and
no users have hit mainline yet.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -168,11 +168,12 @@ extern unsigned int kobjsize(const void 
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
@@ -196,6 +197,26 @@ extern unsigned int kobjsize(const void 
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
+ *
+ * pgoff should be used in favour of address, if possible. If pgoff is
+ * used, one may set VM_CAN_NONLINEAR in the vma->vm_flags to get
+ * nonlinear mapping support.
+ */
+struct fault_data {
+	unsigned long address;
+	pgoff_t pgoff;
+	unsigned int flags;
+
+	int type;
+};
 
 /*
  * These are the virtual MM functions - opening of an area, closing and
@@ -205,6 +226,7 @@ extern pgprot_t protection_map[16];
 struct vm_operations_struct {
 	void (*open)(struct vm_area_struct * area);
 	void (*close)(struct vm_area_struct * area);
+	struct page * (*fault)(struct vm_area_struct *vma, struct fault_data * fdata);
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int *type);
 	unsigned long (*nopfn)(struct vm_area_struct * area, unsigned long address);
 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
@@ -635,7 +657,6 @@ static inline int page_mapped(struct pag
  */
 #define NOPAGE_SIGBUS	(NULL)
 #define NOPAGE_OOM	((struct page *) (-1))
-#define NOPAGE_REFAULT	((struct page *) (-2))	/* Return to userspace, rerun */
 
 /*
  * Error return values for the *_nopfn functions
@@ -669,14 +690,13 @@ extern void pagefault_out_of_memory(void
 extern void show_free_areas(void);
 
 #ifdef CONFIG_SHMEM
-struct page *shmem_nopage(struct vm_area_struct *vma,
-			unsigned long address, int *type);
+struct page *shmem_fault(struct vm_area_struct *vma, struct fault_data *fdata);
 int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *new);
 struct mempolicy *shmem_get_policy(struct vm_area_struct *vma,
 					unsigned long addr);
 int shmem_lock(struct file *file, int lock, struct user_struct *user);
 #else
-#define shmem_nopage filemap_nopage
+#define shmem_fault filemap_fault
 
 static inline int shmem_lock(struct file *file, int lock,
 			     struct user_struct *user)
@@ -1069,9 +1089,11 @@ extern void truncate_inode_pages_range(s
 				       loff_t lstart, loff_t lend);
 
 /* generic vm_area_ops exported for stackable file systems */
-extern struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int *);
-extern int filemap_populate(struct vm_area_struct *, unsigned long,
-		unsigned long, pgprot_t, unsigned long, int);
+extern struct page *filemap_fault(struct vm_area_struct *, struct fault_data *);
+extern struct page * __deprecated_for_modules filemap_nopage(
+			struct vm_area_struct *, unsigned long, int *);
+extern int __deprecated_for_modules filemap_populate(struct vm_area_struct *,
+		unsigned long, unsigned long, pgprot_t, unsigned long, int);
 
 /* mm/page-writeback.c */
 int write_one_page(struct page *page, int wait);
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -2133,10 +2133,10 @@ oom:
 }
 
 /*
- * do_no_page() tries to create a new page mapping. It aggressively
+ * __do_fault() tries to create a new page mapping. It aggressively
  * tries to share with existing pages, but makes a separate copy if
- * the "write_access" parameter is true in order to avoid the next
- * page fault.
+ * the FAULT_FLAG_WRITE is set in the flags parameter in order to avoid
+ * the next page fault.
  *
  * As this is called only for pages that do not currently exist, we
  * do not need to flush old virtual caches or the TLB.
@@ -2145,65 +2145,83 @@ oom:
  * but allow concurrent faults), and pte mapped but not yet locked.
  * We return with mmap_sem still held, but pte unmapped and unlocked.
  */
-static int do_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
+static int __do_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long address, pte_t *page_table, pmd_t *pmd,
-		int write_access)
+		pgoff_t pgoff, unsigned int flags, pte_t orig_pte)
 {
 	spinlock_t *ptl;
-	struct page *page, *nopage_page;
+	struct page *page, *faulted_page;
 	pte_t entry;
-	int ret = VM_FAULT_MINOR;
 	int anon = 0;
 	struct page *dirty_page = NULL;
+	struct fault_data fdata;
+
+	fdata.address = address & PAGE_MASK;
+	fdata.pgoff = pgoff;
+	fdata.flags = flags;
 
 	pte_unmap(page_table);
 	BUG_ON(vma->vm_flags & VM_PFNMAP);
 
-	nopage_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &ret);
-	/* no page was available -- either SIGBUS, OOM or REFAULT */
-	if (unlikely(nopage_page == NOPAGE_SIGBUS))
-		return VM_FAULT_SIGBUS;
-	else if (unlikely(nopage_page == NOPAGE_OOM))
-		return VM_FAULT_OOM;
-	else if (unlikely(nopage_page == NOPAGE_REFAULT))
-		return VM_FAULT_MINOR;
+	if (likely(vma->vm_ops->fault)) {
+		fdata.type = -1;
+		faulted_page = vma->vm_ops->fault(vma, &fdata);
+		WARN_ON(fdata.type == -1);
+		if (unlikely(!faulted_page))
+			return fdata.type;
+	} else {
+		/* Legacy ->nopage path */
+		fdata.type = VM_FAULT_MINOR;
+		faulted_page = vma->vm_ops->nopage(vma, address & PAGE_MASK,
+								&fdata.type);
+		/* no page was available -- either SIGBUS or OOM */
+		if (unlikely(faulted_page == NOPAGE_SIGBUS))
+			return VM_FAULT_SIGBUS;
+		else if (unlikely(faulted_page == NOPAGE_OOM))
+			return VM_FAULT_OOM;
+	}
 
-	BUG_ON(vma->vm_flags & VM_CAN_INVALIDATE && !PageLocked(nopage_page));
 	/*
-	 * For consistency in subsequent calls, make the nopage_page always
+	 * For consistency in subsequent calls, make the faulted_page always
 	 * locked.  These should be in the minority but if they turn out to be
 	 * critical then this can always be revisited
 	 */
 	if (unlikely(!(vma->vm_flags & VM_CAN_INVALIDATE)))
-		lock_page(nopage_page);
+		lock_page(faulted_page);
+	else
+		BUG_ON(!PageLocked(faulted_page));
 
 	/*
 	 * Should we do an early C-O-W break?
 	 */
-	page = nopage_page;
-	if (write_access) {
+	page = faulted_page;
+	if (flags & FAULT_FLAG_WRITE) {
 		if (!(vma->vm_flags & VM_SHARED)) {
+			anon = 1;
 			if (unlikely(anon_vma_prepare(vma))) {
-				ret = VM_FAULT_OOM;
-				goto out_error;
+				fdata.type = VM_FAULT_OOM;
+				goto out;
 			}
 			page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 			if (!page) {
-				ret = VM_FAULT_OOM;
-				goto out_error;
+				fdata.type = VM_FAULT_OOM;
+				goto out;
 			}
-			copy_user_highpage(page, nopage_page, address, vma);
-			anon = 1;
+			copy_user_highpage(page, faulted_page, address, vma);
 		} else {
-			/* if the page will be shareable, see if the backing
+			/*
+			 * If the page will be shareable, see if the backing
 			 * address space wants to know that the page is about
-			 * to become writable */
+			 * to become writable
+			 */
 			if (vma->vm_ops->page_mkwrite &&
 			    vma->vm_ops->page_mkwrite(vma, page) < 0) {
-				ret = VM_FAULT_SIGBUS;
-				goto out_error;
+				fdata.type = VM_FAULT_SIGBUS;
+				anon = 1; /* no anon but release faulted_page */
+				goto out;
 			}
 		}
+
 	}
 
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
@@ -2219,10 +2237,10 @@ static int do_no_page(struct mm_struct *
 	 * handle that later.
 	 */
 	/* Only go through if we didn't race with anybody else... */
-	if (likely(pte_none(*page_table))) {
+	if (likely(pte_same(*page_table, orig_pte))) {
 		flush_icache_page(vma, page);
 		entry = mk_pte(page, vma->vm_page_prot);
-		if (write_access)
+		if (flags & FAULT_FLAG_WRITE)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
@@ -2232,7 +2250,7 @@ static int do_no_page(struct mm_struct *
 		} else {
 			inc_mm_counter(mm, file_rss);
 			page_add_file_rmap(page);
-			if (write_access) {
+			if (flags & FAULT_FLAG_WRITE) {
 				dirty_page = page;
 				get_page(dirty_page);
 			}
@@ -2245,25 +2263,42 @@ static int do_no_page(struct mm_struct *
 		if (anon)
 			page_cache_release(page);
 		else
-			anon = 1; /* not anon, but release nopage_page */
+			anon = 1; /* no anon but release faulted_page */
 	}
 
 	pte_unmap_unlock(page_table, ptl);
 
 out:
-	unlock_page(nopage_page);
+	unlock_page(faulted_page);
 	if (anon)
-		page_cache_release(nopage_page);
+		page_cache_release(faulted_page);
 	else if (dirty_page) {
 		set_page_dirty_balance(dirty_page);
 		put_page(dirty_page);
 	}
 
-	return ret;
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
 
-out_error:
-	anon = 1; /* relase nopage_page */
-	goto out;
+static int do_nonlinear_fault(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long address, pte_t *page_table, pmd_t *pmd,
+		int write_access, pgoff_t pgoff, pte_t orig_pte)
+{
+	unsigned int flags = FAULT_FLAG_NONLINEAR |
+				(write_access ? FAULT_FLAG_WRITE : 0);
+
+	return __do_fault(mm, vma, address, page_table, pmd, pgoff, flags, orig_pte);
 }
 
 /*
@@ -2340,9 +2375,14 @@ static int do_file_page(struct mm_struct
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
@@ -2377,10 +2417,9 @@ static inline int handle_pte_fault(struc
 	if (!pte_present(entry)) {
 		if (pte_none(entry)) {
 			if (vma->vm_ops) {
-				if (vma->vm_ops->nopage)
-					return do_no_page(mm, vma, address,
-							  pte, pmd,
-							  write_access);
+				if (vma->vm_ops->fault || vma->vm_ops->nopage)
+					return do_linear_fault(mm, vma, address,
+						pte, pmd, write_access, entry);
 				if (unlikely(vma->vm_ops->nopfn))
 					return do_no_pfn(mm, vma, address, pte,
 							 pmd, write_access);
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1325,40 +1325,37 @@ static int fastcall page_cache_read(stru
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
+struct page *filemap_fault(struct vm_area_struct *vma, struct fault_data *fdata)
 {
 	int error;
-	struct file *file = area->vm_file;
+	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
 	struct file_ra_state *ra = &file->f_ra;
 	struct inode *inode = mapping->host;
 	struct page *page;
-	unsigned long size, pgoff;
-	int did_readaround = 0, majmin = VM_FAULT_MINOR;
+	unsigned long size;
+	int did_readaround = 0;
 
-	BUG_ON(!(area->vm_flags & VM_CAN_INVALIDATE));
+	fdata->type = VM_FAULT_MINOR;
 
-	pgoff = ((address-area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
+	BUG_ON(!(vma->vm_flags & VM_CAN_INVALIDATE));
 
 	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	if (pgoff >= size)
+	if (fdata->pgoff >= size)
 		goto outside_data_content;
 
 	/* If we don't want any read-ahead, don't bother */
-	if (VM_RandomReadHint(area))
+	if (VM_RandomReadHint(vma))
 		goto no_cached_page;
 
 	/*
@@ -1367,19 +1364,19 @@ struct page *filemap_nopage(struct vm_ar
 	 *
 	 * For sequential accesses, we use the generic readahead logic.
 	 */
-	if (VM_SequentialReadHint(area))
-		page_cache_readahead(mapping, ra, file, pgoff, 1);
+	if (VM_SequentialReadHint(vma))
+		page_cache_readahead(mapping, ra, file, fdata->pgoff, 1);
 
 	/*
 	 * Do we have something in the page cache already?
 	 */
 retry_find:
-	page = find_lock_page(mapping, pgoff);
+	page = find_lock_page(mapping, fdata->pgoff);
 	if (!page) {
 		unsigned long ra_pages;
 
-		if (VM_SequentialReadHint(area)) {
-			handle_ra_miss(mapping, ra, pgoff);
+		if (VM_SequentialReadHint(vma)) {
+			handle_ra_miss(mapping, ra, fdata->pgoff);
 			goto no_cached_page;
 		}
 		ra->mmap_miss++;
@@ -1396,7 +1393,7 @@ retry_find:
 		 * check did_readaround, as this is an inner loop.
 		 */
 		if (!did_readaround) {
-			majmin = VM_FAULT_MAJOR;
+			fdata->type = VM_FAULT_MAJOR;
 			count_vm_event(PGMAJFAULT);
 		}
 		did_readaround = 1;
@@ -1404,11 +1401,11 @@ retry_find:
 		if (ra_pages) {
 			pgoff_t start = 0;
 
-			if (pgoff > ra_pages / 2)
-				start = pgoff - ra_pages / 2;
+			if (fdata->pgoff > ra_pages / 2)
+				start = fdata->pgoff - ra_pages / 2;
 			do_page_cache_readahead(mapping, file, start, ra_pages);
 		}
-		page = find_lock_page(mapping, pgoff);
+		page = find_lock_page(mapping, fdata->pgoff);
 		if (!page)
 			goto no_cached_page;
 	}
@@ -1425,7 +1422,7 @@ retry_find:
 
 	/* Must recheck i_size under page lock */
 	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	if (unlikely(pgoff >= size)) {
+	if (unlikely(fdata->pgoff >= size)) {
 		unlock_page(page);
 		goto outside_data_content;
 	}
@@ -1434,8 +1431,6 @@ retry_find:
 	 * Found the page and have a reference on it.
 	 */
 	mark_page_accessed(page);
-	if (type)
-		*type = majmin;
 	return page;
 
 outside_data_content:
@@ -1443,15 +1438,17 @@ outside_data_content:
 	 * An external ptracer can access pages that normally aren't
 	 * accessible..
 	 */
-	if (area->vm_mm == current->mm)
-		return NOPAGE_SIGBUS;
+	if (vma->vm_mm == current->mm) {
+		fdata->type = VM_FAULT_SIGBUS;
+		return NULL;
+	}
 	/* Fall through to the non-read-ahead case */
 no_cached_page:
 	/*
 	 * We're only likely to ever get here if MADV_RANDOM is in
 	 * effect.
 	 */
-	error = page_cache_read(file, pgoff);
+	error = page_cache_read(file, fdata->pgoff);
 
 	/*
 	 * The page we want has now been added to the page cache.
@@ -1467,13 +1464,15 @@ no_cached_page:
 	 * to schedule I/O.
 	 */
 	if (error == -ENOMEM)
-		return NOPAGE_OOM;
-	return NOPAGE_SIGBUS;
+		fdata->type = VM_FAULT_OOM;
+	else
+		fdata->type = VM_FAULT_SIGBUS;
+	return NULL;
 
 page_not_uptodate:
 	/* IO error path */
 	if (!did_readaround) {
-		majmin = VM_FAULT_MAJOR;
+		fdata->type = VM_FAULT_MAJOR;
 		count_vm_event(PGMAJFAULT);
 	}
 
@@ -1492,7 +1491,30 @@ page_not_uptodate:
 
 	/* Things didn't work out. Return zero to tell the mm layer so. */
 	shrink_readahead_size_eio(file, ra);
-	return NOPAGE_SIGBUS;
+	fdata->type = VM_FAULT_SIGBUS;
+	return NULL;
+}
+EXPORT_SYMBOL(filemap_fault);
+
+/*
+ * filemap_nopage and filemap_populate are legacy exports that are not used
+ * in tree. Scheduled for removal.
+ */
+struct page *filemap_nopage(struct vm_area_struct *area,
+				unsigned long address, int *type)
+{
+	struct page *page;
+	struct fault_data fdata;
+	fdata.address = address;
+	fdata.pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT)
+			+ area->vm_pgoff;
+	fdata.flags = 0;
+
+	page = filemap_fault(area, &fdata);
+	if (type)
+		*type = fdata.type;
+
+	return page;
 }
 EXPORT_SYMBOL(filemap_nopage);
 
@@ -1670,8 +1692,7 @@ repeat:
 EXPORT_SYMBOL(filemap_populate);
 
 struct vm_operations_struct generic_file_vm_ops = {
-	.nopage		= filemap_nopage,
-	.populate	= filemap_populate,
+	.fault		= filemap_fault,
 };
 
 /* This is used for a general mmap of a disk file */
@@ -1684,7 +1705,7 @@ int generic_file_mmap(struct file * file
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
@@ -126,6 +126,25 @@ out:
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
@@ -183,41 +202,63 @@ asmlinkage long sys_remap_file_pages(uns
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
+	if (vma->vm_flags & VM_CAN_NONLINEAR) {
+		err = populate_range(mm, vma, start, size, pgoff);
+		if (!err && !(flags & MAP_NONBLOCK)) {
+			if (unlikely(has_write_lock)) {
+				downgrade_write(&mm->mmap_sem);
+				has_write_lock = 0;
+			}
+			make_pages_present(start, start+size);
+		}
+	} else
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
Index: linux-2.6/fs/gfs2/ops_file.c
===================================================================
--- linux-2.6.orig/fs/gfs2/ops_file.c
+++ linux-2.6/fs/gfs2/ops_file.c
@@ -416,7 +416,7 @@ static int gfs2_mmap(struct file *file, 
 	else
 		vma->vm_ops = &gfs2_vm_ops_private;
 
-	vma->vm_flags |= VM_CAN_INVALIDATE;
+	vma->vm_flags |= VM_CAN_INVALIDATE|VM_CAN_NONLINEAR;
 
 	gfs2_glock_dq_uninit(&i_gh);
 
Index: linux-2.6/fs/gfs2/ops_vm.c
===================================================================
--- linux-2.6.orig/fs/gfs2/ops_vm.c
+++ linux-2.6/fs/gfs2/ops_vm.c
@@ -42,17 +42,17 @@ static void pfault_be_greedy(struct gfs2
 		iput(&ip->i_inode);
 }
 
-static struct page *gfs2_private_nopage(struct vm_area_struct *area,
-					unsigned long address, int *type)
+static struct page *gfs2_private_fault(struct vm_area_struct *vma,
+						struct fault_data *fdata)
 {
-	struct gfs2_inode *ip = GFS2_I(area->vm_file->f_mapping->host);
+	struct gfs2_inode *ip = GFS2_I(vma->vm_file->f_mapping->host);
 	struct page *result;
 
 	set_bit(GIF_PAGED, &ip->i_flags);
 
-	result = filemap_nopage(area, address, type);
+	result = filemap_fault(vma, fdata);
 
-	if (result && result != NOPAGE_OOM)
+	if (result)
 		pfault_be_greedy(ip);
 
 	return result;
@@ -126,16 +126,14 @@ out:
 	return error;
 }
 
-static struct page *gfs2_sharewrite_nopage(struct vm_area_struct *area,
-					   unsigned long address, int *type)
+static struct page *gfs2_sharewrite_fault(struct vm_area_struct *vma,
+						struct fault_data *fdata)
 {
-	struct file *file = area->vm_file;
+	struct file *file = vma->vm_file;
 	struct gfs2_file *gf = file->private_data;
 	struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
 	struct gfs2_holder i_gh;
 	struct page *result = NULL;
-	unsigned long index = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) +
-			      area->vm_pgoff;
 	int alloc_required;
 	int error;
 
@@ -146,21 +144,25 @@ static struct page *gfs2_sharewrite_nopa
 	set_bit(GIF_PAGED, &ip->i_flags);
 	set_bit(GIF_SW_PAGED, &ip->i_flags);
 
-	error = gfs2_write_alloc_required(ip, (u64)index << PAGE_CACHE_SHIFT,
-					  PAGE_CACHE_SIZE, &alloc_required);
-	if (error)
+	error = gfs2_write_alloc_required(ip,
+					(u64)fdata->pgoff << PAGE_CACHE_SHIFT,
+					PAGE_CACHE_SIZE, &alloc_required);
+	if (error) {
+		fdata->type = VM_FAULT_OOM; /* XXX: are these right? */
 		goto out;
+	}
 
 	set_bit(GFF_EXLOCK, &gf->f_flags);
-	result = filemap_nopage(area, address, type);
+	result = filemap_fault(vma, fdata);
 	clear_bit(GFF_EXLOCK, &gf->f_flags);
-	if (!result || result == NOPAGE_OOM)
+	if (!result)
 		goto out;
 
 	if (alloc_required) {
 		error = alloc_page_backing(ip, result);
 		if (error) {
 			page_cache_release(result);
+			fdata->type = VM_FAULT_OOM;
 			result = NULL;
 			goto out;
 		}
@@ -175,10 +177,10 @@ out:
 }
 
 struct vm_operations_struct gfs2_vm_ops_private = {
-	.nopage = gfs2_private_nopage,
+	.fault = gfs2_private_fault,
 };
 
 struct vm_operations_struct gfs2_vm_ops_sharewrite = {
-	.nopage = gfs2_sharewrite_nopage,
+	.fault = gfs2_sharewrite_fault,
 };
 
Index: linux-2.6/fs/ocfs2/mmap.c
===================================================================
--- linux-2.6.orig/fs/ocfs2/mmap.c
+++ linux-2.6/fs/ocfs2/mmap.c
@@ -42,16 +42,14 @@
 #include "inode.h"
 #include "mmap.h"
 
-static struct page *ocfs2_nopage(struct vm_area_struct * area,
-				 unsigned long address,
-				 int *type)
+static struct page *ocfs2_fault(struct vm_area_struct *area,
+						struct fault_data *fdata)
 {
-	struct page *page = NOPAGE_SIGBUS;
+	struct page *page = NULL;
 	sigset_t blocked, oldset;
 	int ret;
 
-	mlog_entry("(area=%p, address=%lu, type=%p)\n", area, address,
-		   type);
+	mlog_entry("(area=%p, page offset=%lu)\n", area, fdata->pgoff);
 
 	/* The best way to deal with signals in this path is
 	 * to block them upfront, rather than allowing the
@@ -62,11 +60,12 @@ static struct page *ocfs2_nopage(struct 
 	 * from sigprocmask */
 	ret = sigprocmask(SIG_BLOCK, &blocked, &oldset);
 	if (ret < 0) {
+		fdata->type = VM_FAULT_SIGBUS;
 		mlog_errno(ret);
 		goto out;
 	}
 
-	page = filemap_nopage(area, address, type);
+	page = filemap_fault(area, fdata);
 
 	ret = sigprocmask(SIG_SETMASK, &oldset, NULL);
 	if (ret < 0)
@@ -77,7 +76,7 @@ out:
 }
 
 static struct vm_operations_struct ocfs2_file_vm_ops = {
-	.nopage = ocfs2_nopage,
+	.fault = ocfs2_fault,
 };
 
 int ocfs2_mmap(struct file *file, struct vm_area_struct *vma)
@@ -104,7 +103,7 @@ int ocfs2_mmap(struct file *file, struct
 	ocfs2_meta_unlock(file->f_dentry->d_inode, lock_level);
 out:
 	vma->vm_ops = &ocfs2_file_vm_ops;
-	vma->vm_flags |= VM_CAN_INVALIDATE;
+	vma->vm_flags |= VM_CAN_INVALIDATE | VM_CAN_NONLINEAR;
 	return 0;
 }
 
Index: linux-2.6/fs/xfs/linux-2.6/xfs_file.c
===================================================================
--- linux-2.6.orig/fs/xfs/linux-2.6/xfs_file.c
+++ linux-2.6/fs/xfs/linux-2.6/xfs_file.c
@@ -246,18 +246,19 @@ xfs_file_fsync(
 
 #ifdef CONFIG_XFS_DMAPI
 STATIC struct page *
-xfs_vm_nopage(
-	struct vm_area_struct	*area,
-	unsigned long		address,
-	int			*type)
+xfs_vm_fault(
+	struct vm_area_struct	*vma,
+	struct fault_data	*fdata)
 {
-	struct inode	*inode = area->vm_file->f_path.dentry->d_inode;
+	struct inode	*inode = vma->vm_file->f_path.dentry->d_inode;
 	bhv_vnode_t	*vp = vn_from_inode(inode);
 
 	ASSERT_ALWAYS(vp->v_vfsp->vfs_flag & VFS_DMI);
-	if (XFS_SEND_MMAP(XFS_VFSTOM(vp->v_vfsp), area, 0))
+	if (XFS_SEND_MMAP(XFS_VFSTOM(vp->v_vfsp), vma, 0)) {
+		fdata->type = VM_FAULT_SIGBUS;
 		return NULL;
-	return filemap_nopage(area, address, type);
+	}
+	return filemap_fault(vma, fdata);
 }
 #endif /* CONFIG_XFS_DMAPI */
 
@@ -343,7 +344,7 @@ xfs_file_mmap(
 	struct vm_area_struct *vma)
 {
 	vma->vm_ops = &xfs_file_vm_ops;
-	vma->vm_flags |= VM_CAN_INVALIDATE;
+	vma->vm_flags |= VM_CAN_INVALIDATE | VM_CAN_NONLINEAR;
 
 #ifdef CONFIG_XFS_DMAPI
 	if (vn_from_inode(filp->f_path.dentry->d_inode)->v_vfsp->vfs_flag & VFS_DMI)
@@ -502,14 +503,12 @@ const struct file_operations xfs_dir_fil
 };
 
 static struct vm_operations_struct xfs_file_vm_ops = {
-	.nopage		= filemap_nopage,
-	.populate	= filemap_populate,
+	.fault		= filemap_fault,
 };
 
 #ifdef CONFIG_XFS_DMAPI
 static struct vm_operations_struct xfs_dmapi_file_vm_ops = {
-	.nopage		= xfs_vm_nopage,
-	.populate	= filemap_populate,
+	.fault		= xfs_vm_fault,
 #ifdef HAVE_VMOP_MPROTECT
 	.mprotect	= xfs_vm_mprotect,
 #endif
Index: linux-2.6/mm/mmap.c
===================================================================
--- linux-2.6.orig/mm/mmap.c
+++ linux-2.6/mm/mmap.c
@@ -1147,12 +1147,8 @@ out:	
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
 	}
-	if (flags & MAP_POPULATE) {
-		up_write(&mm->mmap_sem);
-		sys_remap_file_pages(addr, len, 0,
-					pgoff, flags & MAP_NONBLOCK);
-		down_write(&mm->mmap_sem);
-	}
+	if ((flags & MAP_POPULATE) && !(flags & MAP_NONBLOCK))
+		make_pages_present(addr, addr + len);
 	return addr;
 
 unmap_and_free_vma:
Index: linux-2.6/ipc/shm.c
===================================================================
--- linux-2.6.orig/ipc/shm.c
+++ linux-2.6/ipc/shm.c
@@ -261,7 +261,7 @@ static struct file_operations shm_file_o
 static struct vm_operations_struct shm_vm_ops = {
 	.open	= shm_open,	/* callback for a new vm-area open */
 	.close	= shm_close,	/* callback for when the vm-area is released */
-	.nopage	= shmem_nopage,
+	.fault	= shmem_fault,
 #if defined(CONFIG_NUMA) && defined(CONFIG_SHMEM)
 	.set_policy = shmem_set_policy,
 	.get_policy = shmem_get_policy,
Index: linux-2.6/mm/filemap_xip.c
===================================================================
--- linux-2.6.orig/mm/filemap_xip.c
+++ linux-2.6/mm/filemap_xip.c
@@ -200,62 +200,63 @@ __xip_unmap (struct address_space * mapp
 }
 
 /*
- * xip_nopage() is invoked via the vma operations vector for a
+ * xip_fault() is invoked via the vma operations vector for a
  * mapped memory region to read in file data during a page fault.
  *
- * This function is derived from filemap_nopage, but used for execute in place
+ * This function is derived from filemap_fault, but used for execute in place
  */
-static struct page *
-xip_file_nopage(struct vm_area_struct * area,
-		   unsigned long address,
-		   int *type)
+static struct page *xip_file_fault(struct vm_area_struct *area,
+					struct fault_data *fdata)
 {
 	struct file *file = area->vm_file;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	struct page *page;
-	unsigned long size, pgoff, endoff;
+	pgoff_t size;
 
-	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT)
-		+ area->vm_pgoff;
-	endoff = ((area->vm_end - area->vm_start) >> PAGE_CACHE_SHIFT)
-		+ area->vm_pgoff;
+	/* XXX: are VM_FAULT_ codes OK? */
 
 	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	if (pgoff >= size) {
+	if (fdata->pgoff >= size) {
+		fdata->type = VM_FAULT_SIGBUS;
 		return NULL;
 	}
 
-	page = mapping->a_ops->get_xip_page(mapping, pgoff*(PAGE_SIZE/512), 0);
-	if (!IS_ERR(page)) {
+	page = mapping->a_ops->get_xip_page(mapping,
+					fdata->pgoff*(PAGE_SIZE/512), 0);
+	if (!IS_ERR(page))
 		goto out;
-	}
-	if (PTR_ERR(page) != -ENODATA)
+	if (PTR_ERR(page) != -ENODATA) {
+		fdata->type = VM_FAULT_OOM;
 		return NULL;
+	}
 
 	/* sparse block */
 	if ((area->vm_flags & (VM_WRITE | VM_MAYWRITE)) &&
 	    (area->vm_flags & (VM_SHARED| VM_MAYSHARE)) &&
 	    (!(mapping->host->i_sb->s_flags & MS_RDONLY))) {
 		/* maybe shared writable, allocate new block */
-		page = mapping->a_ops->get_xip_page (mapping,
-			pgoff*(PAGE_SIZE/512), 1);
-		if (IS_ERR(page))
+		page = mapping->a_ops->get_xip_page(mapping,
+					fdata->pgoff*(PAGE_SIZE/512), 1);
+		if (IS_ERR(page)) {
+			fdata->type = VM_FAULT_SIGBUS;
 			return NULL;
+		}
 		/* unmap page at pgoff from all other vmas */
-		__xip_unmap(mapping, pgoff);
+		__xip_unmap(mapping, fdata->pgoff);
 	} else {
 		/* not shared and writable, use ZERO_PAGE() */
-		page = ZERO_PAGE(address);
+		page = ZERO_PAGE(fdata->address);
 	}
 
 out:
+	fdata->type = VM_FAULT_MINOR;
 	page_cache_get(page);
 	return page;
 }
 
 static struct vm_operations_struct xip_file_vm_ops = {
-	.nopage         = xip_file_nopage,
+	.fault	= xip_file_fault,
 };
 
 int xip_file_mmap(struct file * file, struct vm_area_struct * vma)
@@ -264,6 +265,7 @@ int xip_file_mmap(struct file * file, st
 
 	file_accessed(file);
 	vma->vm_ops = &xip_file_vm_ops;
+	vma->vm_flags |= VM_CAN_NONLINEAR;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xip_file_mmap);
Index: linux-2.6/mm/nommu.c
===================================================================
--- linux-2.6.orig/mm/nommu.c
+++ linux-2.6/mm/nommu.c
@@ -1299,8 +1299,7 @@ int in_gate_area_no_task(unsigned long a
 	return 0;
 }
 
-struct page *filemap_nopage(struct vm_area_struct *area,
-			unsigned long address, int *type)
+struct page *filemap_fault(struct vm_area_struct *vma, struct fault_data *fdata)
 {
 	BUG();
 	return NULL;
Index: linux-2.6/mm/shmem.c
===================================================================
--- linux-2.6.orig/mm/shmem.c
+++ linux-2.6/mm/shmem.c
@@ -82,7 +82,7 @@ enum sgp_type {
 	SGP_READ,	/* don't exceed i_size, don't allocate page */
 	SGP_CACHE,	/* don't exceed i_size, may allocate page */
 	SGP_WRITE,	/* may exceed i_size, may allocate page */
-	SGP_NOPAGE,	/* same as SGP_CACHE, return with page locked */
+	SGP_FAULT,	/* same as SGP_CACHE, return with page locked */
 };
 
 static int shmem_getpage(struct inode *inode, unsigned long idx,
@@ -1027,6 +1027,10 @@ static int shmem_getpage(struct inode *i
 
 	if (idx >= SHMEM_MAX_INDEX)
 		return -EFBIG;
+
+	if (type)
+		*type = VM_FAULT_MINOR;
+
 	/*
 	 * Normally, filepage is NULL on entry, and either found
 	 * uptodate immediately, or allocated and zeroed, or read
@@ -1217,7 +1221,7 @@ repeat:
 done:
 	if (*pagep != filepage) {
 		*pagep = filepage;
-		if (sgp != SGP_NOPAGE)
+		if (sgp != SGP_FAULT)
 			unlock_page(filepage);
 
 	}
@@ -1231,75 +1235,30 @@ failed:
 	return error;
 }
 
-struct page *shmem_nopage(struct vm_area_struct *vma, unsigned long address, int *type)
+struct page *shmem_fault(struct vm_area_struct *vma, struct fault_data *fdata)
 {
 	struct inode *inode = vma->vm_file->f_path.dentry->d_inode;
 	struct page *page = NULL;
-	unsigned long idx;
 	int error;
 
 	BUG_ON(!(vma->vm_flags & VM_CAN_INVALIDATE));
 
-	idx = (address - vma->vm_start) >> PAGE_SHIFT;
-	idx += vma->vm_pgoff;
-	idx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
-	if (((loff_t) idx << PAGE_CACHE_SHIFT) >= i_size_read(inode))
-		return NOPAGE_SIGBUS;
+	if (((loff_t)fdata->pgoff << PAGE_CACHE_SHIFT) >= i_size_read(inode)) {
+		fdata->type = VM_FAULT_SIGBUS;
+		return NULL;
+	}
 
-	error = shmem_getpage(inode, idx, &page, SGP_NOPAGE, type);
-	if (error)
-		return (error == -ENOMEM)? NOPAGE_OOM: NOPAGE_SIGBUS;
+	error = shmem_getpage(inode, fdata->pgoff, &page,
+						SGP_FAULT, &fdata->type);
+	if (error) {
+		fdata->type = ((error == -ENOMEM)?VM_FAULT_OOM:VM_FAULT_SIGBUS);
+		return NULL;
+	}
 
 	mark_page_accessed(page);
 	return page;
 }
 
-static int shmem_populate(struct vm_area_struct *vma,
-	unsigned long addr, unsigned long len,
-	pgprot_t prot, unsigned long pgoff, int nonblock)
-{
-	struct inode *inode = vma->vm_file->f_path.dentry->d_inode;
-	struct mm_struct *mm = vma->vm_mm;
-	enum sgp_type sgp = nonblock? SGP_QUICK: SGP_CACHE;
-	unsigned long size;
-
-	size = (i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	if (pgoff >= size || pgoff + (len >> PAGE_SHIFT) > size)
-		return -EINVAL;
-
-	while ((long) len > 0) {
-		struct page *page = NULL;
-		int err;
-		/*
-		 * Will need changing if PAGE_CACHE_SIZE != PAGE_SIZE
-		 */
-		err = shmem_getpage(inode, pgoff, &page, sgp, NULL);
-		if (err)
-			return err;
-		/* Page may still be null, but only if nonblock was set. */
-		if (page) {
-			mark_page_accessed(page);
-			err = install_page(mm, vma, addr, page, prot);
-			if (err) {
-				page_cache_release(page);
-				return err;
-			}
-		} else if (vma->vm_flags & VM_NONLINEAR) {
-			/* No page was found just because we can't read it in
-			 * now (being here implies nonblock != 0), but the page
-			 * may exist, so set the PTE to fault it in later. */
-    			err = install_file_pte(mm, vma, addr, pgoff, prot);
-			if (err)
-	    			return err;
-		}
-
-		len -= PAGE_SIZE;
-		addr += PAGE_SIZE;
-		pgoff++;
-	}
-	return 0;
-}
-
 #ifdef CONFIG_NUMA
 int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
 {
@@ -1344,7 +1303,7 @@ int shmem_mmap(struct file *file, struct
 {
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
-	vma->vm_flags |= VM_CAN_INVALIDATE;
+	vma->vm_flags |= VM_CAN_INVALIDATE | VM_CAN_NONLINEAR;
 	return 0;
 }
 
@@ -2401,8 +2360,7 @@ static struct super_operations shmem_ops
 };
 
 static struct vm_operations_struct shmem_vm_ops = {
-	.nopage		= shmem_nopage,
-	.populate	= shmem_populate,
+	.fault		= shmem_fault,
 #ifdef CONFIG_NUMA
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
Index: linux-2.6/mm/truncate.c
===================================================================
--- linux-2.6.orig/mm/truncate.c
+++ linux-2.6/mm/truncate.c
@@ -74,7 +74,7 @@ EXPORT_SYMBOL(cancel_dirty_page);
 /*
  * If truncate cannot remove the fs-private metadata from the page, the page
  * becomes anonymous.  It will be left on the LRU and may even be mapped into
- * user pagetables if we're racing with filemap_nopage().
+ * user pagetables if we're racing with filemap_fault().
  *
  * We need to bale out if page->mapping is no longer equal to the original
  * mapping.  This happens a) when the VM reclaimed the page while we waited on
Index: linux-2.6/fs/gfs2/ops_address.c
===================================================================
--- linux-2.6.orig/fs/gfs2/ops_address.c
+++ linux-2.6/fs/gfs2/ops_address.c
@@ -212,7 +212,7 @@ static int gfs2_readpage(struct file *fi
 		if (file) {
 			gf = file->private_data;
 			if (test_bit(GFF_EXLOCK, &gf->f_flags))
-				/* gfs2_sharewrite_nopage has grabbed the ip->i_gl already */
+				/* gfs2_sharewrite_fault has grabbed the ip->i_gl already */
 				goto skip_lock;
 		}
 		gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME|LM_FLAG_TRY_1CB, &gh);
Index: linux-2.6/fs/ncpfs/mmap.c
===================================================================
--- linux-2.6.orig/fs/ncpfs/mmap.c
+++ linux-2.6/fs/ncpfs/mmap.c
@@ -25,8 +25,8 @@
 /*
  * Fill in the supplied page for mmap
  */
-static struct page* ncp_file_mmap_nopage(struct vm_area_struct *area,
-				     unsigned long address, int *type)
+static struct page* ncp_file_mmap_fault(struct vm_area_struct *area,
+						struct fault_data *fdata)
 {
 	struct file *file = area->vm_file;
 	struct dentry *dentry = file->f_path.dentry;
@@ -40,15 +40,17 @@ static struct page* ncp_file_mmap_nopage
 
 	page = alloc_page(GFP_HIGHUSER); /* ncpfs has nothing against high pages
 	           as long as recvmsg and memset works on it */
-	if (!page)
-		return page;
+	if (!page) {
+		fdata->type = VM_FAULT_OOM;
+		return NULL;
+	}
 	pg_addr = kmap(page);
-	address &= PAGE_MASK;
-	pos = address - area->vm_start + (area->vm_pgoff << PAGE_SHIFT);
+	pos = fdata->pgoff << PAGE_SHIFT;
 
 	count = PAGE_SIZE;
-	if (address + PAGE_SIZE > area->vm_end) {
-		count = area->vm_end - address;
+	if (fdata->address + PAGE_SIZE > area->vm_end) {
+		WARN_ON(1); /* shouldn't happen? */
+		count = area->vm_end - fdata->address;
 	}
 	/* what we can read in one go */
 	bufsize = NCP_SERVER(inode)->buffer_size;
@@ -91,15 +93,14 @@ static struct page* ncp_file_mmap_nopage
 	 * fetches from the network, here the analogue of disk.
 	 * -- wli
 	 */
-	if (type)
-		*type = VM_FAULT_MAJOR;
+	fdata->type = VM_FAULT_MAJOR;
 	count_vm_event(PGMAJFAULT);
 	return page;
 }
 
 static struct vm_operations_struct ncp_file_mmap =
 {
-	.nopage	= ncp_file_mmap_nopage,
+	.fault = ncp_file_mmap_fault,
 };
 
 
Index: linux-2.6/fs/ocfs2/aops.c
===================================================================
--- linux-2.6.orig/fs/ocfs2/aops.c
+++ linux-2.6/fs/ocfs2/aops.c
@@ -215,7 +215,7 @@ static int ocfs2_readpage(struct file *f
 	 * might now be discovering a truncate that hit on another node.
 	 * block_read_full_page->get_block freaks out if it is asked to read
 	 * beyond the end of a file, so we check here.  Callers
-	 * (generic_file_read, fault->nopage) are clever enough to check i_size
+	 * (generic_file_read, vm_ops->fault) are clever enough to check i_size
 	 * and notice that the page they just read isn't needed.
 	 *
 	 * XXX sys_readahead() seems to get that wrong?
Index: linux-2.6/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.orig/Documentation/feature-removal-schedule.txt
+++ linux-2.6/Documentation/feature-removal-schedule.txt
@@ -198,6 +198,33 @@ Who:	Nick Piggin <npiggin@suse.de>
 
 ---------------------------
 
+What:	filemap_nopage, filemap_populate
+When:	February 2007
+Why:	These legacy interfaces no longer have any callers in the kernel and
+	any functionality provided can be provided with filemap_fault. The
+	removal schedule is short because they are a big maintainence burden
+	and have some bugs.
+Who:	Nick Piggin <npiggin@suse.de>
+
+---------------------------
+
+What:	vm_ops.populate, install_page
+When:	February 2007
+Why:	These legacy interfaces no longer have any callers in the kernel and
+	any functionality provided can be provided with vm_ops.fault.
+Who:	Nick Piggin <npiggin@suse.de>
+
+---------------------------
+
+What:	vm_ops.nopage
+When:	October 2007, provided in-kernel callers have been converted
+Why:	This interface is replaced by vm_ops.fault, but it has been around
+	forever, is used by a lot of drivers, and doesn't cost much to
+	maintain.
+Who:	Nick Piggin <npiggin@suse.de>
+
+---------------------------
+
 What:	Interrupt only SA_* flags
 When:	Januar 2007
 Why:	The interrupt related SA_* flags are replaced by IRQF_* to move them
Index: linux-2.6/Documentation/filesystems/Locking
===================================================================
--- linux-2.6.orig/Documentation/filesystems/Locking
+++ linux-2.6/Documentation/filesystems/Locking
@@ -500,12 +500,14 @@ More details about quota locking can be 
 prototypes:
 	void (*open)(struct vm_area_struct*);
 	void (*close)(struct vm_area_struct*);
+	struct page *(*fault)(struct vm_area_struct*, struct fault_data *);
 	struct page *(*nopage)(struct vm_area_struct*, unsigned long, int *);
 
 locking rules:
 		BKL	mmap_sem
 open:		no	yes
 close:		no	yes
+fault:		no	yes
 nopage:		no	yes
 
 ================================================================================
