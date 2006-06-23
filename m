Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752138AbWFWWbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbWFWWbR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbWFWWbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:31:17 -0400
Received: from [213.46.243.16] ([213.46.243.16]:64867 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1752138AbWFWWbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:31:16 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Sat, 24 Jun 2006 00:31:13 +0200
Message-Id: <20060623223113.11513.10015.sendpatchset@lappy>
In-Reply-To: <20060623223103.11513.50991.sendpatchset@lappy>
References: <20060623223103.11513.50991.sendpatchset@lappy>
Subject: [PATCH 1/5] mm: tracking shared dirty pages
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Tracking of dirty pages in shared writeable mmap()s.

The idea is simple: write protect clean shared writeable pages,
catch the write-fault, make writeable and set dirty. On page write-back
clean all the PTE dirty bits and write protect them once again.

The implementation is a tad harder, mainly because the default
backing_dev_info capabilities were too loosely maintained. Hence it is
not enough to test the backing_dev_info for cap_account_dirty.

The current heuristic is as follows, a VMA is eligible when:
 - its shared writeable 
    (vm_flags & (VM_WRITE|VM_SHARED)) == (VM_WRITE|VM_SHARED)
 - it is not a PFN mapping
    (vm_flags & VM_PFNMAP) == 0
 - the backing_dev_info is cap_account_dirty
    mapping_cap_account_dirty(vma->vm_file->f_mapping)
 - f_op->mmap() didn't change the default page protection

NOTE: the last rule is only checked in do_mmap_pgoff(), other code-
paths assume they will not be reached in that case.

Page from remap_pfn_range() are explicitly excluded because their
COW semantics are already horrid enough (see vm_normal_page() in
do_wp_page()) and because they don't have a backing store anyway.

mprotect() is taught about the new behaviour as well.

Cleaning the pages on write-back is done with page_mkclean() a new
rmap call. It can be called on any page, but is currently only
implemented for mapped pages (does it make sense to also implement
anon pages?), if the page is found the be of a trackable VMA it
will also wrprotect the PTE.

Finally, in fs/buffers.c:try_to_free_buffers(); remove clear_page_dirty()
from under ->private_lock. This seems to be save, since ->private_lock 
is used to serialize access to the buffers, not the page itself.
This is needed because clear_page_dirty() will call into page_mkclean()
and would thereby violate locking order.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
Changes in -v11

 - small cleanups
 - pulled page_mkclean back under mapping_cap_account_dirty()

Changes in -v10

 - 2.6.17-mm1
 - Drop the ugly duckling pgprotting, Hugh suggested resetting the
   vma->vm_page_prot when f_op->mmap() didn't modify it. If it were
   modified we're not interested anyway.
 - abandon is_shared_writable() because its actually spelled writeable
   and it didn't actually mean that any more.
 - Comments all round.

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

 fs/buffer.c          |    2 -
 include/linux/rmap.h |    8 +++++
 mm/memory.c          |   29 ++++++++++++++++-----
 mm/mmap.c            |   40 +++++++++++++++++++++++------
 mm/mprotect.c        |   17 ++++++++++--
 mm/page-writeback.c  |   15 ++++++++--
 mm/rmap.c            |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 160 insertions(+), 21 deletions(-)

Index: 2.6-mm/mm/memory.c
===================================================================
--- 2.6-mm.orig/mm/memory.c	2006-06-23 23:08:49.000000000 +0200
+++ 2.6-mm/mm/memory.c	2006-06-23 23:09:26.000000000 +0200
@@ -1458,14 +1458,19 @@ static int do_wp_page(struct mm_struct *
 {
 	struct page *old_page, *new_page;
 	pte_t entry;
-	int reuse, ret = VM_FAULT_MINOR;
+	int reuse = 0, ret = VM_FAULT_MINOR;
+	struct page *dirty_page = NULL;
 
 	old_page = vm_normal_page(vma, address, orig_pte);
 	if (!old_page)
 		goto gotten;
 
-	if (unlikely((vma->vm_flags & (VM_SHARED|VM_WRITE)) ==
-				(VM_SHARED|VM_WRITE))) {
+	/*
+	 * Only catch write-faults on shared writable pages, read-only
+	 * shared pages can get COWed by get_user_pages(.write=1, .force=1).
+	 */
+	if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
+					(VM_WRITE|VM_SHARED))) {
 		if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
 			/*
 			 * Notify the address space that the page is about to
@@ -1494,13 +1499,12 @@ static int do_wp_page(struct mm_struct *
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
@@ -1566,6 +1570,10 @@ gotten:
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
@@ -2098,6 +2106,7 @@ static int do_no_page(struct mm_struct *
 	unsigned int sequence = 0;
 	int ret = VM_FAULT_MINOR;
 	int anon = 0;
+	struct page *dirty_page = NULL;
 
 	pte_unmap(page_table);
 	BUG_ON(vma->vm_flags & VM_PFNMAP);
@@ -2192,6 +2201,10 @@ retry:
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
@@ -2204,6 +2217,10 @@ retry:
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
--- 2.6-mm.orig/mm/mmap.c	2006-06-23 23:08:49.000000000 +0200
+++ 2.6-mm/mm/mmap.c	2006-06-23 23:09:26.000000000 +0200
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
+	pgprot_t vm_page_prot;
 
 	if (file) {
 		if (is_file_hugepages(file))
@@ -1065,8 +1067,8 @@ munmap_back:
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
 	vma->vm_flags = vm_flags;
-	vma->vm_page_prot = protection_map[vm_flags &
-				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
+	vma->vm_page_prot = vm_page_prot = protection_map[vm_flags &
+		(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
@@ -1090,12 +1092,6 @@ munmap_back:
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
@@ -1113,6 +1109,34 @@ munmap_back:
 	pgoff = vma->vm_pgoff;
 	vm_flags = vma->vm_flags;
 
+	/*
+	 * Tracking of dirty pages for shared writable mappings. Do this by
+	 * write protecting writable pages, and mark dirty in the write fault.
+	 *
+	 * Cannot do before because the condition depends on:
+	 *  - backing_dev_info having the right capabilities
+	 *  - vma->vm_flags being fully set
+	 *    (finished in f_op->mmap(), which could call remap_pfn_range())
+	 *
+	 * If f_op->mmap() changed vma->vm_page_prot its a funny mapping
+	 * and we won't touch it.
+	 * NOTE: in a perfect world backing_dev_info would have the proper
+	 * capabilities.
+	 *
+	 * OR
+	 *
+	 * Don't make the VMA automatically writable if it's shared, but the
+	 * backer wishes to know when pages are first written to.
+	 */
+	if (((pgprot_val(vma->vm_page_prot) == pgprot_val(vm_page_prot)) &&
+	     ((vm_flags & (VM_WRITE|VM_SHARED|VM_PFNMAP|VM_INSERTPAGE)) ==
+			  (VM_WRITE|VM_SHARED)) &&
+	     vma->vm_file && vma->vm_file->f_mapping &&
+	     mapping_cap_account_dirty(vma->vm_file->f_mapping)) ||
+	    (vma->vm_ops && vma->vm_ops->page_mkwrite))
+		vma->vm_page_prot =
+			protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC)];
+
 	if (!file || !vma_merge(mm, prev, addr, vma->vm_end,
 			vma->vm_flags, NULL, file, pgoff, vma_policy(vma))) {
 		file = vma->vm_file;
Index: 2.6-mm/mm/mprotect.c
===================================================================
--- 2.6-mm.orig/mm/mprotect.c	2006-06-23 23:08:49.000000000 +0200
+++ 2.6-mm/mm/mprotect.c	2006-06-23 23:10:08.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/syscalls.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/backing-dev.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
@@ -176,10 +177,20 @@ mprotect_fixup(struct vm_area_struct *vm
 	}
 
 success:
-	/* Don't make the VMA automatically writable if it's shared, but the
-	 * backer wishes to know when pages are first written to */
+	/*
+	 * Tracking of dirty pages logic (see comment in do_mmap_pgoff)
+	 *
+	 * OR
+	 *
+	 * Don't make the VMA automatically writable if it's shared, but the
+	 * backer wishes to know when pages are first written to.
+	 */
 	mask = VM_READ|VM_WRITE|VM_EXEC|VM_SHARED;
-	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
+	if ((((newflags & (VM_WRITE|VM_SHARED|VM_PFNMAP|VM_INSERTPAGE)) ==
+			  (VM_WRITE|VM_SHARED)) &&
+	     vma->vm_file && vma->vm_file->f_mapping &&
+	     mapping_cap_account_dirty(vma->vm_file->f_mapping)) ||
+	    (vma->vm_ops && vma->vm_ops->page_mkwrite))
 		mask &= ~VM_SHARED;
 
 	newprot = protection_map[newflags & mask];
Index: 2.6-mm/mm/page-writeback.c
===================================================================
--- 2.6-mm.orig/mm/page-writeback.c	2006-06-23 23:08:49.000000000 +0200
+++ 2.6-mm/mm/page-writeback.c	2006-06-23 23:09:26.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/rmap.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -566,7 +567,7 @@ int do_writepages(struct address_space *
 		return 0;
 	wbc->for_writepages = 1;
 	if (mapping->a_ops->writepages)
-		ret =  mapping->a_ops->writepages(mapping, wbc);
+		ret = mapping->a_ops->writepages(mapping, wbc);
 	else
 		ret = generic_writepages(mapping, wbc);
 	wbc->for_writepages = 0;
@@ -728,8 +729,14 @@ int test_clear_page_dirty(struct page *p
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
 			write_unlock_irqrestore(&mapping->tree_lock, flags);
-			if (mapping_cap_account_dirty(mapping))
+			/*
+			 * We can continue to use `mapping' here because the
+			 * page is locked, which pins the address_space
+			 */
+			if (mapping_cap_account_dirty(mapping)) {
+				page_mkclean(page);
 				dec_page_state(nr_dirty);
+			}
 			return 1;
 		}
 		write_unlock_irqrestore(&mapping->tree_lock, flags);
@@ -759,8 +766,10 @@ int clear_page_dirty_for_io(struct page 
 
 	if (mapping) {
 		if (TestClearPageDirty(page)) {
-			if (mapping_cap_account_dirty(mapping))
+			if (mapping_cap_account_dirty(mapping)) {
+				page_mkclean(page);
 				dec_page_state(nr_dirty);
+			}
 			return 1;
 		}
 		return 0;
Index: 2.6-mm/mm/rmap.c
===================================================================
--- 2.6-mm.orig/mm/rmap.c	2006-06-23 23:08:49.000000000 +0200
+++ 2.6-mm/mm/rmap.c	2006-06-23 23:09:26.000000000 +0200
@@ -53,6 +53,7 @@
 #include <linux/rmap.h>
 #include <linux/rcupdate.h>
 #include <linux/module.h>
+#include <linux/backing-dev.h>
 
 #include <asm/tlbflush.h>
 
@@ -434,6 +435,75 @@ int page_referenced(struct page *page, i
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
+			((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
+			 (VM_WRITE|VM_SHARED));
+		BUG_ON(vma->vm_flags & (VM_PFNMAP|VM_INSERTPAGE));
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
--- 2.6-mm.orig/include/linux/rmap.h	2006-06-23 23:08:49.000000000 +0200
+++ 2.6-mm/include/linux/rmap.h	2006-06-23 23:09:26.000000000 +0200
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
--- 2.6-mm.orig/fs/buffer.c	2006-06-23 23:08:49.000000000 +0200
+++ 2.6-mm/fs/buffer.c	2006-06-23 23:09:26.000000000 +0200
@@ -2983,6 +2983,7 @@ int try_to_free_buffers(struct page *pag
 
 	spin_lock(&mapping->private_lock);
 	ret = drop_buffers(page, &buffers_to_free);
+	spin_unlock(&mapping->private_lock);
 	if (ret) {
 		/*
 		 * If the filesystem writes its buffers by hand (eg ext3)
@@ -2994,7 +2995,6 @@ int try_to_free_buffers(struct page *pag
 		 */
 		clear_page_dirty(page);
 	}
-	spin_unlock(&mapping->private_lock);
 out:
 	if (buffers_to_free) {
 		struct buffer_head *bh = buffers_to_free;
