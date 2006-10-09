Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932960AbWJIQMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932960AbWJIQMn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 12:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932961AbWJIQMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 12:12:42 -0400
Received: from cantor2.suse.de ([195.135.220.15]:57001 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932960AbWJIQMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 12:12:39 -0400
From: Nick Piggin <npiggin@suse.de>
To: Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, Ingo Molnar <mingo@elte.hu>
Message-Id: <20061009140414.13840.90825.sendpatchset@linux.site>
In-Reply-To: <20061009140354.13840.71273.sendpatchset@linux.site>
References: <20061009140354.13840.71273.sendpatchset@linux.site>
Subject: [patch 2/5] mm: fault vs invalidate/truncate race fix
Date: Mon,  9 Oct 2006 18:12:26 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the race between invalidate_inode_pages and do_no_page.

Andrea Arcangeli identified a subtle race between invalidation of
pages from pagecache with userspace mappings, and do_no_page.

The issue is that invalidation has to shoot down all mappings to the
page, before it can be discarded from the pagecache. Between shooting
down ptes to a particular page, and actually dropping the struct page
from the pagecache, do_no_page from any process might fault on that
page and establish a new mapping to the page just before it gets
discarded from the pagecache.

The most common case where such invalidation is used is in file
truncation. This case was catered for by doing a sort of open-coded
seqlock between the file's i_size, and its truncate_count.

Truncation will decrease i_size, then increment truncate_count before
unmapping userspace pages; do_no_page will read truncate_count, then
find the page if it is within i_size, and then check truncate_count
under the page table lock and back out and retry if it had
subsequently been changed (ptl will serialise against unmapping, and
ensure a potentially updated truncate_count is actually visible).

Complexity and documentation issues aside, the locking protocol fails
in the case where we would like to invalidate pagecache inside i_size.
do_no_page can come in anytime and filemap_nopage is not aware of the
invalidation in progress (as it is when it is outside i_size). The
end result is that dangling (->mapping == NULL) pages that appear to
be from a particular file may be mapped into userspace with nonsense
data. Valid mappings to the same place will see a different page.

Andrea implemented two working fixes, one using a real seqlock,
another using a page->flags bit. He also proposed using the page lock
in do_no_page, but that was initially considered too heavyweight.
However, it is not a global or per-file lock, and the page cacheline
is modified in do_no_page to increment _count and _mapcount anyway, so
a further modification should not be a large performance hit.
Scalability is not an issue.

This patch implements this latter approach. ->nopage implementations
return with the page locked if it is possible for their underlying
file to be invalidated (in that case, they must set a special vm_flags
bit to indicate so). do_no_page only unlocks the page after setting
up the mapping completely. invalidation is excluded because it holds
the page lock during invalidation of each page (and ensures that the
page is not mapped while holding the lock).

This allows significant simplifications in do_no_page.

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -166,6 +166,11 @@ extern unsigned int kobjsize(const void 
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
 #define VM_INSERTPAGE	0x02000000	/* The vma has had "vm_insert_page()" done on it */
+#define VM_CAN_INVALIDATE	0x04000000	/* The mapping may be invalidated,
+					 * eg. truncate or invalidate_inode_*.
+					 * In this case, do_no_page must
+					 * return with the page locked.
+					 */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1363,9 +1363,10 @@ struct page *filemap_nopage(struct vm_ar
 	unsigned long size, pgoff;
 	int did_readaround = 0, majmin = VM_FAULT_MINOR;
 
+	BUG_ON(!(area->vm_flags & VM_CAN_INVALIDATE));
+
 	pgoff = ((address-area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
 
-retry_all:
 	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	if (pgoff >= size)
 		goto outside_data_content;
@@ -1387,7 +1388,7 @@ retry_all:
 	 * Do we have something in the page cache already?
 	 */
 retry_find:
-	page = find_get_page(mapping, pgoff);
+	page = find_lock_page(mapping, pgoff);
 	if (!page) {
 		unsigned long ra_pages;
 
@@ -1421,7 +1422,7 @@ retry_find:
 				start = pgoff - ra_pages / 2;
 			do_page_cache_readahead(mapping, file, start, ra_pages);
 		}
-		page = find_get_page(mapping, pgoff);
+		page = find_lock_page(mapping, pgoff);
 		if (!page)
 			goto no_cached_page;
 	}
@@ -1430,13 +1431,25 @@ retry_find:
 		ra->mmap_hit++;
 
 	/*
-	 * Ok, found a page in the page cache, now we need to check
-	 * that it's up-to-date.
+	 * We have a locked page in the page cache, now we need to check
+	 * that it's up-to-date. If not, it is going to be due to an error.
 	 */
-	if (!PageUptodate(page))
+	if (unlikely(!PageUptodate(page)))
 		goto page_not_uptodate;
 
-success:
+#if 0
+/*
+ * XXX: no we don't have to, because we check and unmap in
+ * truncate, when the page is locked. Verify and delete me.
+ */
+	/* Must recheck i_size under page lock */
+	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	if (unlikely(pgoff >= size)) {
+		unlock_page(page);
+		goto outside_data_content;
+	}
+#endif
+
 	/*
 	 * Found the page and have a reference on it.
 	 */
@@ -1479,34 +1492,11 @@ no_cached_page:
 	return NOPAGE_SIGBUS;
 
 page_not_uptodate:
+	/* IO error path */
 	if (!did_readaround) {
 		majmin = VM_FAULT_MAJOR;
 		count_vm_event(PGMAJFAULT);
 	}
-	lock_page(page);
-
-	/* Did it get unhashed while we waited for it? */
-	if (!page->mapping) {
-		unlock_page(page);
-		page_cache_release(page);
-		goto retry_all;
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
 
 	/*
 	 * Umm, take care of errors if the page isn't up-to-date.
@@ -1514,37 +1504,15 @@ page_not_uptodate:
 	 * because there really aren't any performance issues here
 	 * and we need to check for errors.
 	 */
-	lock_page(page);
-
-	/* Somebody truncated the page on us? */
-	if (!page->mapping) {
-		unlock_page(page);
-		page_cache_release(page);
-		goto retry_all;
-	}
-
-	/* Somebody else successfully read it in? */
-	if (PageUptodate(page)) {
-		unlock_page(page);
-		goto success;
-	}
 	ClearPageError(page);
 	error = mapping->a_ops->readpage(file, page);
-	if (!error) {
-		wait_on_page_locked(page);
-		if (PageUptodate(page))
-			goto success;
-	} else if (error == AOP_TRUNCATED_PAGE) {
-		page_cache_release(page);
+	page_cache_release(page);
+
+	if (!error || error == AOP_TRUNCATED_PAGE)
 		goto retry_find;
-	}
 
-	/*
-	 * Things didn't work out. Return zero to tell the
-	 * mm layer so, possibly freeing the page cache page first.
-	 */
+	/* Things didn't work out. Return zero to tell the mm layer so. */
 	shrink_readahead_size_eio(file, ra);
-	page_cache_release(page);
 	return NOPAGE_SIGBUS;
 }
 EXPORT_SYMBOL(filemap_nopage);
@@ -1737,6 +1705,7 @@ int generic_file_mmap(struct file * file
 		return -ENOEXEC;
 	file_accessed(file);
 	vma->vm_ops = &generic_file_vm_ops;
+	vma->vm_flags |= VM_CAN_INVALIDATE;
 	return 0;
 }
 
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -1675,6 +1675,13 @@ static int unmap_mapping_range_vma(struc
 	unsigned long restart_addr;
 	int need_break;
 
+	/*
+	 * files that support invalidating or truncating portions of the
+	 * file from under mmaped areas must set the VM_CAN_INVALIDATE flag, and
+	 * have their .nopage function return the page locked.
+	 */
+	BUG_ON(!(vma->vm_flags & VM_CAN_INVALIDATE));
+
 again:
 	restart_addr = vma->vm_truncate_count;
 	if (is_restart_addr(restart_addr) && start_addr < restart_addr) {
@@ -1805,17 +1812,8 @@ void unmap_mapping_range(struct address_
 
 	spin_lock(&mapping->i_mmap_lock);
 
-	/* serialize i_size write against truncate_count write */
-	smp_wmb();
-	/* Protect against page faults, and endless unmapping loops */
+	/* Protect against endless unmapping loops */
 	mapping->truncate_count++;
-	/*
-	 * For archs where spin_lock has inclusive semantics like ia64
-	 * this smp_mb() will prevent to read pagetable contents
-	 * before the truncate_count increment is visible to
-	 * other cpus.
-	 */
-	smp_mb();
 	if (unlikely(is_restart_addr(mapping->truncate_count))) {
 		if (mapping->truncate_count == 0)
 			reset_vma_truncate_counts(mapping);
@@ -1854,7 +1852,6 @@ int vmtruncate(struct inode * inode, lof
 	if (IS_SWAPFILE(inode))
 		goto out_busy;
 	i_size_write(inode, offset);
-	unmap_mapping_range(mapping, offset + PAGE_SIZE - 1, 0, 1);
 	truncate_inode_pages(mapping, offset);
 	goto out_truncate;
 
@@ -1893,7 +1890,6 @@ int vmtruncate_range(struct inode *inode
 
 	mutex_lock(&inode->i_mutex);
 	down_write(&inode->i_alloc_sem);
-	unmap_mapping_range(mapping, offset, (end - offset), 1);
 	truncate_inode_pages_range(mapping, offset, end);
 	inode->i_op->truncate_range(inode, offset, end);
 	up_write(&inode->i_alloc_sem);
@@ -2144,10 +2140,8 @@ static int do_no_page(struct mm_struct *
 		int write_access)
 {
 	spinlock_t *ptl;
-	struct page *new_page;
-	struct address_space *mapping = NULL;
+	struct page *page, *nopage_page;
 	pte_t entry;
-	unsigned int sequence = 0;
 	int ret = VM_FAULT_MINOR;
 	int anon = 0;
 	struct page *dirty_page = NULL;
@@ -2155,73 +2149,54 @@ static int do_no_page(struct mm_struct *
 	pte_unmap(page_table);
 	BUG_ON(vma->vm_flags & VM_PFNMAP);
 
-	if (vma->vm_file) {
-		mapping = vma->vm_file->f_mapping;
-		sequence = mapping->truncate_count;
-		smp_rmb(); /* serializes i_size against truncate_count */
-	}
-retry:
-	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &ret);
-	/*
-	 * No smp_rmb is needed here as long as there's a full
-	 * spin_lock/unlock sequence inside the ->nopage callback
-	 * (for the pagecache lookup) that acts as an implicit
-	 * smp_mb() and prevents the i_size read to happen
-	 * after the next truncate_count read.
-	 */
-
+	nopage_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &ret);
 	/* no page was available -- either SIGBUS, OOM or REFAULT */
-	if (unlikely(new_page == NOPAGE_SIGBUS))
+	if (unlikely(nopage_page == NOPAGE_SIGBUS))
 		return VM_FAULT_SIGBUS;
-	else if (unlikely(new_page == NOPAGE_OOM))
+	else if (unlikely(nopage_page == NOPAGE_OOM))
 		return VM_FAULT_OOM;
-	else if (unlikely(new_page == NOPAGE_REFAULT))
+	else if (unlikely(nopage_page == NOPAGE_REFAULT))
 		return VM_FAULT_MINOR;
 
+	BUG_ON(vma->vm_flags & VM_CAN_INVALIDATE && !PageLocked(nopage_page));
+	/*
+	 * For consistency in subsequent calls, make the nopage_page always
+	 * locked.  These should be in the minority but if they turn out to be
+	 * critical then this can always be revisited
+	 */
+	if (unlikely(!(vma->vm_flags & VM_CAN_INVALIDATE)))
+		lock_page(nopage_page);
+
 	/*
 	 * Should we do an early C-O-W break?
 	 */
+	page = nopage_page;
 	if (write_access) {
 		if (!(vma->vm_flags & VM_SHARED)) {
-			struct page *page;
-
-			if (unlikely(anon_vma_prepare(vma)))
-				goto oom;
+			if (unlikely(anon_vma_prepare(vma))) {
+				ret = VM_FAULT_OOM;
+				goto out_error;
+			}
 			page = alloc_page_vma(GFP_HIGHUSER, vma, address);
-			if (!page)
-				goto oom;
-			copy_user_highpage(page, new_page, address);
-			page_cache_release(new_page);
-			new_page = page;
+			if (!page) {
+				ret = VM_FAULT_OOM;
+				goto out_error;
+			}
+			copy_user_highpage(page, nopage_page, address);
 			anon = 1;
-
 		} else {
 			/* if the page will be shareable, see if the backing
 			 * address space wants to know that the page is about
 			 * to become writable */
 			if (vma->vm_ops->page_mkwrite &&
-			    vma->vm_ops->page_mkwrite(vma, new_page) < 0
-			    ) {
-				page_cache_release(new_page);
-				return VM_FAULT_SIGBUS;
+			    vma->vm_ops->page_mkwrite(vma, page) < 0) {
+				ret = VM_FAULT_SIGBUS;
+				goto out_error;
 			}
 		}
 	}
 
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
-	/*
-	 * For a file-backed vma, someone could have truncated or otherwise
-	 * invalidated this page.  If unmap_mapping_range got called,
-	 * retry getting the page.
-	 */
-	if (mapping && unlikely(sequence != mapping->truncate_count)) {
-		pte_unmap_unlock(page_table, ptl);
-		page_cache_release(new_page);
-		cond_resched();
-		sequence = mapping->truncate_count;
-		smp_rmb();
-		goto retry;
-	}
 
 	/*
 	 * This silly early PAGE_DIRTY setting removes a race
@@ -2234,43 +2209,51 @@ retry:
 	 * handle that later.
 	 */
 	/* Only go through if we didn't race with anybody else... */
-	if (pte_none(*page_table)) {
-		flush_icache_page(vma, new_page);
-		entry = mk_pte(new_page, vma->vm_page_prot);
+	if (likely(pte_none(*page_table))) {
+		flush_icache_page(vma, page);
+		entry = mk_pte(page, vma->vm_page_prot);
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
 			inc_mm_counter(mm, anon_rss);
-			lru_cache_add_active(new_page);
-			page_add_new_anon_rmap(new_page, vma, address);
+			lru_cache_add_active(page);
+			page_add_new_anon_rmap(page, vma, address);
 		} else {
 			inc_mm_counter(mm, file_rss);
-			page_add_file_rmap(new_page);
+			page_add_file_rmap(page);
 			if (write_access) {
-				dirty_page = new_page;
+				dirty_page = page;
 				get_page(dirty_page);
 			}
 		}
+
+		/* no need to invalidate: a not-present page won't be cached */
+		update_mmu_cache(vma, address, entry);
+		lazy_mmu_prot_update(entry);
 	} else {
-		/* One of our sibling threads was faster, back out. */
-		page_cache_release(new_page);
-		goto unlock;
+		if (anon)
+			page_cache_release(page);
+		else
+			anon = 1; /* not anon, but release nopage_page */
 	}
 
-	/* no need to invalidate: a not-present page shouldn't be cached */
-	update_mmu_cache(vma, address, entry);
-	lazy_mmu_prot_update(entry);
-unlock:
 	pte_unmap_unlock(page_table, ptl);
-	if (dirty_page) {
+
+out:
+	unlock_page(nopage_page);
+	if (anon)
+		page_cache_release(nopage_page);
+	else if (dirty_page) {
 		set_page_dirty_balance(dirty_page);
 		put_page(dirty_page);
 	}
+
 	return ret;
-oom:
-	page_cache_release(new_page);
-	return VM_FAULT_OOM;
+
+out_error:
+	anon = 1; /* relase nopage_page */
+	goto out;
 }
 
 /*
Index: linux-2.6/mm/shmem.c
===================================================================
--- linux-2.6.orig/mm/shmem.c
+++ linux-2.6/mm/shmem.c
@@ -81,6 +81,7 @@ enum sgp_type {
 	SGP_READ,	/* don't exceed i_size, don't allocate page */
 	SGP_CACHE,	/* don't exceed i_size, may allocate page */
 	SGP_WRITE,	/* may exceed i_size, may allocate page */
+	SGP_NOPAGE,	/* same as SGP_CACHE, return with page locked */
 };
 
 static int shmem_getpage(struct inode *inode, unsigned long idx,
@@ -1209,8 +1210,10 @@ repeat:
 	}
 done:
 	if (*pagep != filepage) {
-		unlock_page(filepage);
 		*pagep = filepage;
+		if (sgp != SGP_NOPAGE)
+			unlock_page(filepage);
+
 	}
 	return 0;
 
@@ -1229,13 +1232,15 @@ struct page *shmem_nopage(struct vm_area
 	unsigned long idx;
 	int error;
 
+	BUG_ON(!(vma->vm_flags & VM_CAN_INVALIDATE));
+
 	idx = (address - vma->vm_start) >> PAGE_SHIFT;
 	idx += vma->vm_pgoff;
 	idx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
 	if (((loff_t) idx << PAGE_CACHE_SHIFT) >= i_size_read(inode))
 		return NOPAGE_SIGBUS;
 
-	error = shmem_getpage(inode, idx, &page, SGP_CACHE, type);
+	error = shmem_getpage(inode, idx, &page, SGP_NOPAGE, type);
 	if (error)
 		return (error == -ENOMEM)? NOPAGE_OOM: NOPAGE_SIGBUS;
 
@@ -1333,6 +1338,7 @@ int shmem_mmap(struct file *file, struct
 {
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
+	vma->vm_flags |= VM_CAN_INVALIDATE;
 	return 0;
 }
 
@@ -2445,5 +2451,6 @@ int shmem_zero_setup(struct vm_area_stru
 		fput(vma->vm_file);
 	vma->vm_file = file;
 	vma->vm_ops = &shmem_vm_ops;
+	vma->vm_flags |= VM_CAN_INVALIDATE;
 	return 0;
 }
Index: linux-2.6/fs/ncpfs/mmap.c
===================================================================
--- linux-2.6.orig/fs/ncpfs/mmap.c
+++ linux-2.6/fs/ncpfs/mmap.c
@@ -123,6 +123,7 @@ int ncp_mmap(struct file *file, struct v
 		return -EFBIG;
 
 	vma->vm_ops = &ncp_file_mmap;
+	vma->vm_flags |= VM_CAN_INVALIDATE;
 	file_accessed(file);
 	return 0;
 }
Index: linux-2.6/fs/ocfs2/mmap.c
===================================================================
--- linux-2.6.orig/fs/ocfs2/mmap.c
+++ linux-2.6/fs/ocfs2/mmap.c
@@ -93,6 +93,7 @@ int ocfs2_mmap(struct file *file, struct
 
 	file_accessed(file);
 	vma->vm_ops = &ocfs2_file_vm_ops;
+	vma->vm_flags |= VM_CAN_INVALIDATE;
 	return 0;
 }
 
Index: linux-2.6/fs/xfs/linux-2.6/xfs_file.c
===================================================================
--- linux-2.6.orig/fs/xfs/linux-2.6/xfs_file.c
+++ linux-2.6/fs/xfs/linux-2.6/xfs_file.c
@@ -343,6 +343,7 @@ xfs_file_mmap(
 	struct vm_area_struct *vma)
 {
 	vma->vm_ops = &xfs_file_vm_ops;
+	vma->vm_flags |= VM_CAN_INVALIDATE;
 
 #ifdef CONFIG_XFS_DMAPI
 	if (vn_from_inode(filp->f_dentry->d_inode)->v_vfsp->vfs_flag & VFS_DMI)
Index: linux-2.6/ipc/shm.c
===================================================================
--- linux-2.6.orig/ipc/shm.c
+++ linux-2.6/ipc/shm.c
@@ -230,6 +230,7 @@ static int shm_mmap(struct file * file, 
 	ret = shmem_mmap(file, vma);
 	if (ret == 0) {
 		vma->vm_ops = &shm_vm_ops;
+		vma->vm_flags |= VM_CAN_INVALIDATE;
 		if (!(vma->vm_flags & VM_WRITE))
 			vma->vm_flags &= ~VM_MAYWRITE;
 		shm_inc(shm_file_ns(file), file->f_dentry->d_inode->i_ino);
Index: linux-2.6/fs/ocfs2/dlmglue.c
===================================================================
--- linux-2.6.orig/fs/ocfs2/dlmglue.c
+++ linux-2.6/fs/ocfs2/dlmglue.c
@@ -2656,7 +2656,6 @@ static int ocfs2_data_convert_worker(str
 	sync_mapping_buffers(mapping);
 	if (blocking == LKM_EXMODE) {
 		truncate_inode_pages(mapping, 0);
-		unmap_mapping_range(mapping, 0, 0, 0);
 	} else {
 		/* We only need to wait on the I/O if we're not also
 		 * truncating pages because truncate_inode_pages waits
Index: linux-2.6/mm/truncate.c
===================================================================
--- linux-2.6.orig/mm/truncate.c
+++ linux-2.6/mm/truncate.c
@@ -163,6 +163,11 @@ void truncate_inode_pages_range(struct a
 				unlock_page(page);
 				continue;
 			}
+			while (page_mapped(page)) {
+				unmap_mapping_range(mapping,
+				  (loff_t)page_index<<PAGE_CACHE_SHIFT,
+				  PAGE_CACHE_SIZE, 0);
+			}
 			truncate_complete_page(mapping, page);
 			unlock_page(page);
 		}
@@ -200,6 +205,11 @@ void truncate_inode_pages_range(struct a
 				break;
 			lock_page(page);
 			wait_on_page_writeback(page);
+			while (page_mapped(page)) {
+				unmap_mapping_range(mapping,
+				  (loff_t)page_index<<PAGE_CACHE_SHIFT,
+				  PAGE_CACHE_SIZE, 0);
+			}
 			if (page->index > next)
 				next = page->index;
 			next++;
Index: linux-2.6/fs/gfs2/ops_file.c
===================================================================
--- linux-2.6.orig/fs/gfs2/ops_file.c
+++ linux-2.6/fs/gfs2/ops_file.c
@@ -396,6 +396,8 @@ static int gfs2_mmap(struct file *file, 
 	else
 		vma->vm_ops = &gfs2_vm_ops_private;
 
+	vma->vm_flags |= VM_CAN_INVALIDATE;
+
 	gfs2_glock_dq_uninit(&i_gh);
 
 	return error;
