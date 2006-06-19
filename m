Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWFSRxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWFSRxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWFSRxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:53:09 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:64720 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S964794AbWFSRxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:53:06 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Mon, 19 Jun 2006 19:52:53 +0200
Message-Id: <20060619175253.24655.96323.sendpatchset@lappy>
In-Reply-To: <20060619175243.24655.76005.sendpatchset@lappy>
References: <20060619175243.24655.76005.sendpatchset@lappy>
Subject: [PATCH 1/6] mm: tracking shared dirty pages
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

People expressed the need to track dirty pages in shared mappings.

Linus outlined the general idea of doing that through making clean
writable pages write-protected and taking the write fault.

This patch does exactly that, it makes pages in a shared writable
mapping write-protected. On write-fault the pages are marked dirty and
made writable. When the pages get synced with their backing store, the
write-protection is re-instated.

It survives a simple test and shows the dirty pages in /proc/vmstat.

Changes in -v9

 - respin against latest -mm.

Changes in -v8

 - access_process_vm() and other force users of get_user_pages() can
   induce COW of read-only shared mappings.

Changes in -v7

 - changed is_shared_writable() to exclude VM_PFNMAP'ed regions.
 - Hugh's tiresome problem wasn't fully solved, now using the ugly duckling
   method.

Changes in -v6

 - make page_mkclean_one() modify the pte more like change_pte_range() 
   (suggested by Christoph Lameter)
 - made is_shared_writable() take vm_flags, it now resembles is_cow_mapping().
 - fixed the mprotect() bug (spotted by Hugh Dickins)
 - hopefully fixed the tiresome issue of do_mmap_pgoff() trampling on
   driver specific vm_page_prot settings (spotted by Hugh Dickins)
 - made a new version of the page_mkwrite() patch to go on top of all this.
   This so that Linus could merge this very early on in 2.6.18.

Changes in -v5

 - rename page_wrprotect() to page_mkclean() (suggested by Nick Piggin)
 - added comment to test_clear_page_dirty() (Andrew Morton)
 - cleanup page_wrprotect() (Andrew Morton)
 - renamed VM_SharedWritable() to is_shared_writable()
 - fs/buffers.c try_to_free_buffers(): remove clear_page_dirty() from under
   ->private_lock. This seems to be save, since ->private_lock is used to
   serialize access to the buffers, not the page itself.
 - rebased on top of David Howells' page_mkwrite() patch.

Changes in -v4:

 - small cleanup as suggested by Christoph Lameter.

Changes in -v3:

 - move set_page_dirty() outside pte lock (suggested by Christoph Lameter)

Changes in -v2:

 - only wrprotect pages from dirty capable mappings. (Nick Piggin)
 - move the writefault handling from do_wp_page() into handle_pte_fault(). 
   (Nick Piggin)
 - revert to the old install_page interface. (Nick Piggin)
 - also clear the pte dirty bit when we make pages read-only again.
   (spotted by Rik van Riel)
 - make page_wrprotect() return the number of reprotected ptes.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---

 fs/buffer.c          |    2 -
 include/linux/mm.h   |    6 ++++
 include/linux/rmap.h |    8 ++++++
 mm/memory.c          |   29 ++++++++++++++++++---
 mm/mmap.c            |   34 +++++++++++++++++++++----
 mm/mprotect.c        |    7 ++++-
 mm/page-writeback.c  |    9 ++++++
 mm/rmap.c            |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 149 insertions(+), 14 deletions(-)

Index: 2.6-mm/include/linux/mm.h
===================================================================
--- 2.6-mm.orig/include/linux/mm.h	2006-06-14 10:29:04.000000000 +0200
+++ 2.6-mm/include/linux/mm.h	2006-06-19 14:45:18.000000000 +0200
@@ -182,6 +182,12 @@ extern unsigned int kobjsize(const void 
 #define VM_SequentialReadHint(v)	((v)->vm_flags & VM_SEQ_READ)
 #define VM_RandomReadHint(v)		((v)->vm_flags & VM_RAND_READ)
 
+static inline int is_shared_writable(unsigned int flags)
+{
+	return (flags & (VM_SHARED|VM_WRITE|VM_PFNMAP)) ==
+		(VM_SHARED|VM_WRITE);
+}
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
Index: 2.6-mm/mm/memory.c
===================================================================
--- 2.6-mm.orig/mm/memory.c	2006-06-14 10:29:06.000000000 +0200
+++ 2.6-mm/mm/memory.c	2006-06-19 16:20:06.000000000 +0200
@@ -938,6 +938,12 @@ struct page *follow_page(struct vm_area_
 	pte = *ptep;
 	if (!pte_present(pte))
 		goto unlock;
+	/*
+	 * This is not fully correct in the light of trapping write faults
+	 * for writable shared mappings. However since we're going to mark
+	 * the page dirty anyway some few lines downward, we might as well
+	 * take the write fault now.
+	 */
 	if ((flags & FOLL_WRITE) && !pte_write(pte))
 		goto unlock;
 	page = vm_normal_page(vma, address, pte);
@@ -1458,13 +1464,14 @@ static int do_wp_page(struct mm_struct *
 {
 	struct page *old_page, *new_page;
 	pte_t entry;
-	int reuse, ret = VM_FAULT_MINOR;
+	int reuse = 0, ret = VM_FAULT_MINOR;
+	struct page *dirty_page = NULL;
 
 	old_page = vm_normal_page(vma, address, orig_pte);
 	if (!old_page)
 		goto gotten;
 
-	if (unlikely(vma->vm_flags & VM_SHARED)) {
+	if (unlikely(is_shared_writable(vma->vm_flags))) {
 		if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
 			/*
 			 * Notify the address space that the page is about to
@@ -1493,13 +1500,12 @@ static int do_wp_page(struct mm_struct *
 			if (!pte_same(*page_table, orig_pte))
 				goto unlock;
 		}
-
+		dirty_page = old_page;
+		get_page(dirty_page);
 		reuse = 1;
 	} else if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
 		reuse = can_share_swap_page(old_page);
 		unlock_page(old_page);
-	} else {
-		reuse = 0;
 	}
 
 	if (reuse) {
@@ -1565,6 +1571,10 @@ gotten:
 		page_cache_release(old_page);
 unlock:
 	pte_unmap_unlock(page_table, ptl);
+	if (dirty_page) {
+		set_page_dirty(dirty_page);
+		put_page(dirty_page);
+	}
 	return ret;
 oom:
 	if (old_page)
@@ -2097,6 +2107,7 @@ static int do_no_page(struct mm_struct *
 	unsigned int sequence = 0;
 	int ret = VM_FAULT_MINOR;
 	int anon = 0;
+	struct page *dirty_page = NULL;
 
 	pte_unmap(page_table);
 	BUG_ON(vma->vm_flags & VM_PFNMAP);
@@ -2191,6 +2202,10 @@ retry:
 		} else {
 			inc_mm_counter(mm, file_rss);
 			page_add_file_rmap(new_page);
+			if (write_access) {
+				dirty_page = new_page;
+				get_page(dirty_page);
+			}
 		}
 	} else {
 		/* One of our sibling threads was faster, back out. */
@@ -2203,6 +2218,10 @@ retry:
 	lazy_mmu_prot_update(entry);
 unlock:
 	pte_unmap_unlock(page_table, ptl);
+	if (dirty_page) {
+		set_page_dirty(dirty_page);
+		put_page(dirty_page);
+	}
 	return ret;
 oom:
 	page_cache_release(new_page);
Index: 2.6-mm/mm/mmap.c
===================================================================
--- 2.6-mm.orig/mm/mmap.c	2006-06-14 10:29:06.000000000 +0200
+++ 2.6-mm/mm/mmap.c	2006-06-19 15:41:53.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/mount.h>
 #include <linux/mempolicy.h>
 #include <linux/rmap.h>
+#include <linux/backing-dev.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -888,6 +889,7 @@ unsigned long do_mmap_pgoff(struct file 
 	struct rb_node ** rb_link, * rb_parent;
 	int accountable = 1;
 	unsigned long charged = 0, reqprot = prot;
+	struct address_space *mapping = NULL;
 
 	if (file) {
 		if (is_file_hugepages(file))
@@ -1084,18 +1086,13 @@ munmap_back:
 		error = file->f_op->mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
+
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
 		if (error)
 			goto free_vma;
 	}
 
-	/* Don't make the VMA automatically writable if it's shared, but the
-	 * backer wishes to know when pages are first written to */
-	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
-		vma->vm_page_prot =
-			protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC)];
-
 	/* We set VM_ACCOUNT in a shared mapping's vm_flags, to inform
 	 * shmem_zero_setup (perhaps called through /dev/zero's ->mmap)
 	 * that memory reservation must be checked; but that reservation
@@ -1113,6 +1110,31 @@ munmap_back:
 	pgoff = vma->vm_pgoff;
 	vm_flags = vma->vm_flags;
 
+	/*
+	 * Tracking of dirty pages for shared writable mappings. Do this by
+	 * write protecting writable pages, and mark dirty in the write fault.
+	 *
+	 * Modify vma->vm_page_prot (the default protection for new pages)
+	 * to this effect.
+	 *
+	 * Cannot do before because the condition depends on:
+	 *  - backing_dev_info having the right capabilities
+	 *    (set by f_op->open())
+	 *  - vma->vm_flags being fully set
+	 *    (finished in f_op->mmap(), which could call remap_pfn_range())
+	 *
+	 *  Also, cannot reset vma->vm_page_prot from vma->vm_flags because
+	 *  f_op->mmap() can modify it.
+	 */
+	if (is_shared_writable(vm_flags) && vma->vm_file)
+		mapping = vma->vm_file->f_mapping;
+	if ((mapping && mapping_cap_account_dirty(mapping)) ||
+			(vma->vm_ops && vma->vm_ops->page_mkwrite))
+		vma->vm_page_prot =
+			__pgprot(pte_val
+				(pte_wrprotect
+				 (__pte(pgprot_val(vma->vm_page_prot)))));
+
 	if (!file || !vma_merge(mm, prev, addr, vma->vm_end,
 			vma->vm_flags, NULL, file, pgoff, vma_policy(vma))) {
 		file = vma->vm_file;
Index: 2.6-mm/mm/mprotect.c
===================================================================
--- 2.6-mm.orig/mm/mprotect.c	2006-06-14 10:29:06.000000000 +0200
+++ 2.6-mm/mm/mprotect.c	2006-06-19 16:19:42.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/syscalls.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/backing-dev.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
@@ -124,6 +125,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned long charged = 0;
 	unsigned int mask;
+	struct address_space *mapping = NULL;
 	pgprot_t newprot;
 	pgoff_t pgoff;
 	int error;
@@ -179,7 +181,10 @@ success:
 	/* Don't make the VMA automatically writable if it's shared, but the
 	 * backer wishes to know when pages are first written to */
 	mask = VM_READ|VM_WRITE|VM_EXEC|VM_SHARED;
-	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
+	if (is_shared_writable(newflags) && vma->vm_file)
+		mapping = vma->vm_file->f_mapping;
+	if ((mapping && mapping_cap_account_dirty(mapping)) ||
+			(vma->vm_ops && vma->vm_ops->page_mkwrite))
 		mask &= ~VM_SHARED;
 
 	newprot = protection_map[newflags & mask];
Index: 2.6-mm/mm/page-writeback.c
===================================================================
--- 2.6-mm.orig/mm/page-writeback.c	2006-06-14 10:29:07.000000000 +0200
+++ 2.6-mm/mm/page-writeback.c	2006-06-19 16:19:42.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/rmap.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -540,7 +541,7 @@ int do_writepages(struct address_space *
 		return 0;
 	wbc->for_writepages = 1;
 	if (mapping->a_ops->writepages)
-		ret =  mapping->a_ops->writepages(mapping, wbc);
+		ret = mapping->a_ops->writepages(mapping, wbc);
 	else
 		ret = generic_writepages(mapping, wbc);
 	wbc->for_writepages = 0;
@@ -704,6 +705,11 @@ int test_clear_page_dirty(struct page *p
 			if (mapping_cap_account_dirty(mapping))
 				__dec_zone_page_state(page, NR_DIRTY);
 			write_unlock_irqrestore(&mapping->tree_lock, flags);
+			/*
+			 * We can continue to use `mapping' here because the
+			 * page is locked, which pins the address_space
+			 */
+			page_mkclean(page);
 			return 1;
 		}
 		write_unlock_irqrestore(&mapping->tree_lock, flags);
@@ -733,6 +739,7 @@ int clear_page_dirty_for_io(struct page 
 
 	if (mapping) {
 		if (TestClearPageDirty(page)) {
+			page_mkclean(page);
 			if (mapping_cap_account_dirty(mapping))
 				dec_zone_page_state(page, NR_DIRTY);
 			return 1;
Index: 2.6-mm/mm/rmap.c
===================================================================
--- 2.6-mm.orig/mm/rmap.c	2006-06-14 10:29:07.000000000 +0200
+++ 2.6-mm/mm/rmap.c	2006-06-19 14:45:18.000000000 +0200
@@ -53,6 +53,7 @@
 #include <linux/rmap.h>
 #include <linux/rcupdate.h>
 #include <linux/module.h>
+#include <linux/backing-dev.h>
 
 #include <asm/tlbflush.h>
 
@@ -434,6 +435,73 @@ int page_referenced(struct page *page, i
 	return referenced;
 }
 
+static int page_mkclean_one(struct page *page, struct vm_area_struct *vma, int protect)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long address;
+	pte_t *pte, entry;
+	spinlock_t *ptl;
+	int ret = 0;
+
+	address = vma_address(page, vma);
+	if (address == -EFAULT)
+		goto out;
+
+	pte = page_check_address(page, mm, address, &ptl);
+	if (!pte)
+		goto out;
+
+	if (!(pte_dirty(*pte) || (protect && pte_write(*pte))))
+		goto unlock;
+
+	entry = ptep_get_and_clear(mm, address, pte);
+	entry = pte_mkclean(entry);
+	if (protect)
+		entry = pte_wrprotect(entry);
+	ptep_establish(vma, address, pte, entry);
+	lazy_mmu_prot_update(entry);
+	ret = 1;
+
+unlock:
+	pte_unmap_unlock(pte, ptl);
+out:
+	return ret;
+}
+
+static int page_mkclean_file(struct address_space *mapping, struct page *page)
+{
+	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+	struct vm_area_struct *vma;
+	struct prio_tree_iter iter;
+	int ret = 0;
+
+	BUG_ON(PageAnon(page));
+
+	spin_lock(&mapping->i_mmap_lock);
+	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
+		int protect = mapping_cap_account_dirty(mapping) &&
+			is_shared_writable(vma->vm_flags);
+		ret += page_mkclean_one(page, vma, protect);
+	}
+	spin_unlock(&mapping->i_mmap_lock);
+	return ret;
+}
+
+int page_mkclean(struct page *page)
+{
+	int ret = 0;
+
+	BUG_ON(!PageLocked(page));
+
+	if (page_mapped(page)) {
+		struct address_space *mapping = page_mapping(page);
+		if (mapping)
+			ret = page_mkclean_file(mapping, page);
+	}
+
+	return ret;
+}
+
 /**
  * page_set_anon_rmap - setup new anonymous rmap
  * @page:	the page to add the mapping to
Index: 2.6-mm/include/linux/rmap.h
===================================================================
--- 2.6-mm.orig/include/linux/rmap.h	2006-06-14 10:29:04.000000000 +0200
+++ 2.6-mm/include/linux/rmap.h	2006-06-19 14:45:18.000000000 +0200
@@ -103,6 +103,14 @@ pte_t *page_check_address(struct page *,
  */
 unsigned long page_address_in_vma(struct page *, struct vm_area_struct *);
 
+/*
+ * Cleans the PTEs of shared mappings.
+ * (and since clean PTEs should also be readonly, write protects them too)
+ *
+ * returns the number of cleaned PTEs.
+ */
+int page_mkclean(struct page *);
+
 #else	/* !CONFIG_MMU */
 
 #define anon_vma_init()		do {} while (0)
Index: 2.6-mm/fs/buffer.c
===================================================================
--- 2.6-mm.orig/fs/buffer.c	2006-06-14 10:28:52.000000000 +0200
+++ 2.6-mm/fs/buffer.c	2006-06-19 14:45:18.000000000 +0200
@@ -2985,6 +2985,7 @@ int try_to_free_buffers(struct page *pag
 
 	spin_lock(&mapping->private_lock);
 	ret = drop_buffers(page, &buffers_to_free);
+	spin_unlock(&mapping->private_lock);
 	if (ret) {
 		/*
 		 * If the filesystem writes its buffers by hand (eg ext3)
@@ -2996,7 +2997,6 @@ int try_to_free_buffers(struct page *pag
 		 */
 		clear_page_dirty(page);
 	}
-	spin_unlock(&mapping->private_lock);
 out:
 	if (buffers_to_free) {
 		struct buffer_head *bh = buffers_to_free;
