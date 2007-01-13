Return-Path: <linux-kernel-owner+w=401wt.eu-S1161219AbXAMDaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbXAMDaO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161205AbXAMD3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:29:42 -0500
Received: from mx1.suse.de ([195.135.220.2]:49802 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161250AbXAMD3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:29:06 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, thomas@tungstengraphics.com
Message-Id: <20070113011644.9479.11734.sendpatchset@linux.site>
In-Reply-To: <20070113011526.9479.79596.sendpatchset@linux.site>
References: <20070113011526.9479.79596.sendpatchset@linux.site>
Subject: [patch 7/7] mm: remove legacy cruft
Date: Sat, 13 Jan 2007 04:29:00 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove legacy filemap_nopage and all of the .populate API cruft.

This patch is optional and can be left out (eg. for a cleaner merge with -mm),
and rebased after the previous patches go upstream.

 include/linux/mm.h |    9 --
 mm/filemap.c       |  195 -----------------------------------------------------
 mm/fremap.c        |   71 ++-----------------
 mm/memory.c        |   37 ++--------
 4 files changed, 21 insertions(+), 291 deletions(-)

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -228,8 +228,6 @@ struct vm_operations_struct {
 	void (*close)(struct vm_area_struct * area);
 	struct page * (*fault)(struct vm_area_struct *vma, struct fault_data * fdata);
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int *type);
-	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
-
 	/* notification that a previously read-only page is about to become
 	 * writable, if an error is returned it will cause a SIGBUS */
 	int (*page_mkwrite)(struct vm_area_struct *vma, struct page *page);
@@ -771,8 +769,6 @@ static inline void unmap_shared_mapping_
 
 extern int vmtruncate(struct inode * inode, loff_t offset);
 extern int vmtruncate_range(struct inode * inode, loff_t offset, loff_t end);
-extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
-extern int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, unsigned long pgoff, pgprot_t prot);
 
 #ifdef CONFIG_MMU
 extern int __handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma,
@@ -1083,10 +1079,6 @@ extern void truncate_inode_pages_range(s
 
 /* generic vm_area_ops exported for stackable file systems */
 extern struct page *filemap_fault(struct vm_area_struct *, struct fault_data *);
-extern struct page * __deprecated_for_modules filemap_nopage(
-			struct vm_area_struct *, unsigned long, int *);
-extern int __deprecated_for_modules filemap_populate(struct vm_area_struct *,
-		unsigned long, unsigned long, pgprot_t, unsigned long, int);
 
 /* mm/page-writeback.c */
 int write_one_page(struct page *page, int wait);
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1496,201 +1496,6 @@ page_not_uptodate:
 }
 EXPORT_SYMBOL(filemap_fault);
 
-/*
- * filemap_nopage and filemap_populate are legacy exports that are not used
- * in tree. Scheduled for removal.
- */
-struct page *filemap_nopage(struct vm_area_struct *area,
-				unsigned long address, int *type)
-{
-	struct page *page;
-	struct fault_data fdata;
-	fdata.address = address;
-	fdata.pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT)
-			+ area->vm_pgoff;
-	fdata.flags = 0;
-
-	page = filemap_fault(area, &fdata);
-	if (type)
-		*type = fdata.type;
-
-	return page;
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
-	return NULL;
-}
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
-
 struct vm_operations_struct generic_file_vm_ops = {
 	.fault		= filemap_fault,
 };
Index: linux-2.6/mm/fremap.c
===================================================================
--- linux-2.6.orig/mm/fremap.c
+++ linux-2.6/mm/fremap.c
@@ -45,58 +45,10 @@ static int zap_pte(struct mm_struct *mm,
 }
 
 /*
- * Install a file page to a given virtual memory address, release any
- * previously existing mapping.
- */
-int install_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long addr, struct page *page, pgprot_t prot)
-{
-	struct inode *inode;
-	pgoff_t size;
-	int err = -ENOMEM;
-	pte_t *pte;
-	pte_t pte_val;
-	spinlock_t *ptl;
-
-	pte = get_locked_pte(mm, addr, &ptl);
-	if (!pte)
-		goto out;
-
-	/*
-	 * This page may have been truncated. Tell the
-	 * caller about it.
-	 */
-	err = -EINVAL;
-	inode = vma->vm_file->f_mapping->host;
-	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	if (!page->mapping || page->index >= size)
-		goto unlock;
-	err = -ENOMEM;
-	if (page_mapcount(page) > INT_MAX/2)
-		goto unlock;
-
-	if (pte_none(*pte) || !zap_pte(mm, vma, addr, pte))
-		inc_mm_counter(mm, file_rss);
-
-	flush_icache_page(vma, page);
-	pte_val = mk_pte(page, prot);
-	set_pte_at(mm, addr, pte, pte_val);
-	page_add_file_rmap(page);
-	update_mmu_cache(vma, addr, pte_val);
-	lazy_mmu_prot_update(pte_val);
-	err = 0;
-unlock:
-	pte_unmap_unlock(pte, ptl);
-out:
-	return err;
-}
-EXPORT_SYMBOL(install_page);
-
-/*
  * Install a file pte to a given virtual memory address, release any
  * previously existing mapping.
  */
-int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma,
+static int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long pgoff, pgprot_t prot)
 {
 	int err = -ENOMEM;
@@ -208,8 +160,7 @@ asmlinkage long sys_remap_file_pages(uns
 	if (vma->vm_private_data && !(vma->vm_flags & VM_NONLINEAR))
 		goto out;
 
-	if ((!vma->vm_ops || !vma->vm_ops->populate) &&
-					!(vma->vm_flags & VM_CAN_NONLINEAR))
+	if (!vma->vm_flags & VM_CAN_NONLINEAR)
 		goto out;
 
 	if (end <= start || start < vma->vm_start || end > vma->vm_end)
@@ -239,18 +190,14 @@ asmlinkage long sys_remap_file_pages(uns
 		spin_unlock(&mapping->i_mmap_lock);
 	}
 
-	if (vma->vm_flags & VM_CAN_NONLINEAR) {
-		err = populate_range(mm, vma, start, size, pgoff);
-		if (!err && !(flags & MAP_NONBLOCK)) {
-			if (unlikely(has_write_lock)) {
-				downgrade_write(&mm->mmap_sem);
-				has_write_lock = 0;
-			}
-			make_pages_present(start, start+size);
+	err = populate_range(mm, vma, start, size, pgoff);
+	if (!err && !(flags & MAP_NONBLOCK)) {
+		if (unlikely(has_write_lock)) {
+			downgrade_write(&mm->mmap_sem);
+			has_write_lock = 0;
 		}
-	} else
-		err = vma->vm_ops->populate(vma, start, size, vma->vm_page_prot,
-					    	pgoff, flags & MAP_NONBLOCK);
+		make_pages_present(start, start+size);
+	}
 
 	/*
 	 * We can't clear VM_NONLINEAR because we'd have to do
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -2337,18 +2337,10 @@ static int do_linear_fault(struct mm_str
 			- vma->vm_start) >> PAGE_CACHE_SHIFT) + vma->vm_pgoff;
 	unsigned int flags = (write_access ? FAULT_FLAG_WRITE : 0);
 
-	return __do_fault(mm, vma, address, page_table, pmd, pgoff, flags, orig_pte);
+	return __do_fault(mm, vma, address, page_table, pmd, pgoff,
+							flags, orig_pte);
 }
 
-static int do_nonlinear_fault(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long address, pte_t *page_table, pmd_t *pmd,
-		int write_access, pgoff_t pgoff, pte_t orig_pte)
-{
-	unsigned int flags = FAULT_FLAG_NONLINEAR |
-				(write_access ? FAULT_FLAG_WRITE : 0);
-
-	return __do_fault(mm, vma, address, page_table, pmd, pgoff, flags, orig_pte);
-}
 
 /*
  * Fault of a previously existing named mapping. Repopulate the pte
@@ -2359,17 +2351,19 @@ static int do_nonlinear_fault(struct mm_
  * but allow concurrent faults), and pte mapped but not yet locked.
  * We return with mmap_sem still held, but pte unmapped and unlocked.
  */
-static int do_file_page(struct mm_struct *mm, struct vm_area_struct *vma,
+static int do_nonlinear_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long address, pte_t *page_table, pmd_t *pmd,
 		int write_access, pte_t orig_pte)
 {
+	unsigned int flags = FAULT_FLAG_NONLINEAR |
+				(write_access ? FAULT_FLAG_WRITE : 0);
 	pgoff_t pgoff;
-	int err;
 
 	if (!pte_unmap_same(mm, pmd, page_table, orig_pte))
 		return VM_FAULT_MINOR;
 
-	if (unlikely(!(vma->vm_flags & VM_NONLINEAR))) {
+	if (unlikely(!(vma->vm_flags & VM_NONLINEAR) ||
+			!(vma->vm_flags & VM_CAN_NONLINEAR))) {
 		/*
 		 * Page table corrupted: show pte and kill process.
 		 */
@@ -2379,18 +2373,8 @@ static int do_file_page(struct mm_struct
 
 	pgoff = pte_to_pgoff(orig_pte);
 
-	if (vma->vm_ops && vma->vm_ops->fault)
-		return do_nonlinear_fault(mm, vma, address, page_table, pmd,
-					write_access, pgoff, orig_pte);
-
-	/* We can then assume vm->vm_ops && vma->vm_ops->populate */
-	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE,
-					vma->vm_page_prot, pgoff, 0);
-	if (err == -ENOMEM)
-		return VM_FAULT_OOM;
-	if (err)
-		return VM_FAULT_SIGBUS;
-	return VM_FAULT_MAJOR;
+	return __do_fault(mm, vma, address, page_table, pmd, pgoff,
+							flags, orig_pte);
 }
 
 /*
@@ -2426,7 +2410,7 @@ static inline int handle_pte_fault(struc
 						 pte, pmd, write_access);
 		}
 		if (pte_file(entry))
-			return do_file_page(mm, vma, address,
+			return do_nonlinear_fault(mm, vma, address,
 					pte, pmd, write_access, entry);
 		return do_swap_page(mm, vma, address,
 					pte, pmd, write_access, entry);
Index: linux-2.6/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.orig/Documentation/feature-removal-schedule.txt
+++ linux-2.6/Documentation/feature-removal-schedule.txt
@@ -198,24 +198,6 @@ Who:	Nick Piggin <npiggin@suse.de>
 
 ---------------------------
 
-What:	filemap_nopage, filemap_populate
-When:	February 2007
-Why:	These legacy interfaces no longer have any callers in the kernel and
-	any functionality provided can be provided with filemap_fault. The
-	removal schedule is short because they are a big maintainence burden
-	and have some bugs.
-Who:	Nick Piggin <npiggin@suse.de>
-
----------------------------
-
-What:	vm_ops.populate, install_page
-When:	February 2007
-Why:	These legacy interfaces no longer have any callers in the kernel and
-	any functionality provided can be provided with vm_ops.fault.
-Who:	Nick Piggin <npiggin@suse.de>
-
----------------------------
-
 What:	vm_ops.nopage
 When:	October 2007, provided in-kernel callers have been converted
 Why:	This interface is replaced by vm_ops.fault, but it has been around
