Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWF0S2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWF0S2W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWF0S2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:28:22 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:65534 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030257AbWF0S2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:28:20 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Tue, 27 Jun 2006 20:28:14 +0200
Message-Id: <20060627182814.20891.36856.sendpatchset@lappy>
In-Reply-To: <20060627182801.20891.11456.sendpatchset@lappy>
References: <20060627182801.20891.11456.sendpatchset@lappy>
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
 - it is not a 'special' mapping
    (vm_flags & (VM_PFNMAP|VM_INSERTPAGE)) == 0
 - the backing_dev_info is cap_account_dirty
    mapping_cap_account_dirty(vma->vm_file->f_mapping)
 - f_op->mmap() didn't change the default page protection

Page from remap_pfn_range() are explicitly excluded because their
COW semantics are already horrid enough (see vm_normal_page() in
do_wp_page()) and because they don't have a backing store anyway.

mprotect() is taught about the new behaviour as well. However it
overrides the last condition.

Cleaning the pages on write-back is done with page_mkclean() a new
rmap call. It can be called on any page, but is currently only
implemented for mapped pages, if the page is found the be of a 
VMA that accounts dirty pages it will also wrprotect the PTE.

Finally, in fs/buffers.c:try_to_free_buffers(); remove clear_page_dirty()
from under ->private_lock. This seems to be safe, since ->private_lock 
is used to serialize access to the buffers, not the page itself.
This is needed because clear_page_dirty() will call into page_mkclean()
and would thereby violate locking order.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
Changes in -v13

 - against Linus' tree again
 - added flags to vma_wants_notification()

Changes in -v12

 - Linus suggested a nice replacement for the beast condition

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
 include/linux/mm.h   |   39 ++++++++++++++++++++++++++++++
 include/linux/rmap.h |    8 ++++++
 mm/memory.c          |   29 +++++++++++++++++-----
 mm/mmap.c            |   10 +++----
 mm/mprotect.c        |   20 +++++----------
 mm/page-writeback.c  |   15 +++++++++--
 mm/rmap.c            |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 160 insertions(+), 29 deletions(-)

Index: linux-2.6-dirty/mm/memory.c
===================================================================
--- linux-2.6-dirty.orig/mm/memory.c	2006-06-27 13:28:59.000000000 +0200
+++ linux-2.6-dirty/mm/memory.c	2006-06-27 20:03:53.000000000 +0200
@@ -1457,14 +1457,19 @@ static int do_wp_page(struct mm_struct *
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
@@ -1493,13 +1498,12 @@ static int do_wp_page(struct mm_struct *
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
@@ -1565,6 +1569,10 @@ gotten:
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
@@ -2094,6 +2102,7 @@ static int do_no_page(struct mm_struct *
 	unsigned int sequence = 0;
 	int ret = VM_FAULT_MINOR;
 	int anon = 0;
+	struct page *dirty_page = NULL;
 
 	pte_unmap(page_table);
 	BUG_ON(vma->vm_flags & VM_PFNMAP);
@@ -2188,6 +2197,10 @@ retry:
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
@@ -2200,6 +2213,10 @@ retry:
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
Index: linux-2.6-dirty/mm/mmap.c
===================================================================
--- linux-2.6-dirty.orig/mm/mmap.c	2006-06-27 13:29:00.000000000 +0200
+++ linux-2.6-dirty/mm/mmap.c	2006-06-27 13:35:10.000000000 +0200
@@ -1090,12 +1090,6 @@ munmap_back:
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
@@ -1113,6 +1107,10 @@ munmap_back:
 	pgoff = vma->vm_pgoff;
 	vm_flags = vma->vm_flags;
 
+	if (vma_wants_writenotify(vma, 0))
+		vma->vm_page_prot =
+			protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC)];
+
 	if (!file || !vma_merge(mm, prev, addr, vma->vm_end,
 			vma->vm_flags, NULL, file, pgoff, vma_policy(vma))) {
 		file = vma->vm_file;
Index: linux-2.6-dirty/mm/mprotect.c
===================================================================
--- linux-2.6-dirty.orig/mm/mprotect.c	2006-06-27 13:29:00.000000000 +0200
+++ linux-2.6-dirty/mm/mprotect.c	2006-06-27 20:03:53.000000000 +0200
@@ -123,8 +123,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	unsigned long oldflags = vma->vm_flags;
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned long charged = 0;
-	unsigned int mask;
-	pgprot_t newprot;
+	unsigned long mask = VM_READ|VM_WRITE|VM_EXEC|VM_SHARED;
 	pgoff_t pgoff;
 	int error;
 
@@ -176,24 +175,19 @@ mprotect_fixup(struct vm_area_struct *vm
 	}
 
 success:
-	/* Don't make the VMA automatically writable if it's shared, but the
-	 * backer wishes to know when pages are first written to */
-	mask = VM_READ|VM_WRITE|VM_EXEC|VM_SHARED;
-	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
-		mask &= ~VM_SHARED;
-
-	newprot = protection_map[newflags & mask];
-
 	/*
 	 * vm_flags and vm_page_prot are protected by the mmap_sem
 	 * held in write mode.
 	 */
 	vma->vm_flags = newflags;
-	vma->vm_page_prot = newprot;
+	if (vma_wants_writenotify(vma, VM_NOTIFY_NO_PROT))
+		mask &= ~VM_SHARED;
+	vma->vm_page_prot = protection_map[newflags & mask];
+
 	if (is_vm_hugetlb_page(vma))
-		hugetlb_change_protection(vma, start, end, newprot);
+		hugetlb_change_protection(vma, start, end, vma->vm_page_prot);
 	else
-		change_protection(vma, start, end, newprot);
+		change_protection(vma, start, end, vma->vm_page_prot);
 	vm_stat_account(mm, oldflags, vma->vm_file, -nrpages);
 	vm_stat_account(mm, newflags, vma->vm_file, nrpages);
 	return 0;
Index: linux-2.6-dirty/mm/page-writeback.c
===================================================================
--- linux-2.6-dirty.orig/mm/page-writeback.c	2006-06-27 13:29:00.000000000 +0200
+++ linux-2.6-dirty/mm/page-writeback.c	2006-06-27 20:03:53.000000000 +0200
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
Index: linux-2.6-dirty/mm/rmap.c
===================================================================
--- linux-2.6-dirty.orig/mm/rmap.c	2006-06-27 13:29:00.000000000 +0200
+++ linux-2.6-dirty/mm/rmap.c	2006-06-27 13:53:50.000000000 +0200
@@ -434,6 +434,72 @@ int page_referenced(struct page *page, i
 	return referenced;
 }
 
+static int page_mkclean_one(struct page *page, struct vm_area_struct *vma)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long address;
+	pte_t *pte, entry;
+	spinlock_t *ptl;
+	int writefault = vma_wants_writenotify(vma,
+			VM_NOTIFY_NO_PROT|VM_NOTIFY_NO_MKWRITE);
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
+	if (!(pte_dirty(*pte) || (writefault && pte_write(*pte))))
+		goto unlock;
+
+	entry = ptep_get_and_clear(mm, address, pte);
+	entry = pte_mkclean(entry);
+	if (writefault)
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
+	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff)
+		ret += page_mkclean_one(page, vma);
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
Index: linux-2.6-dirty/include/linux/rmap.h
===================================================================
--- linux-2.6-dirty.orig/include/linux/rmap.h	2006-06-27 13:29:00.000000000 +0200
+++ linux-2.6-dirty/include/linux/rmap.h	2006-06-27 13:35:10.000000000 +0200
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
Index: linux-2.6-dirty/fs/buffer.c
===================================================================
--- linux-2.6-dirty.orig/fs/buffer.c	2006-06-27 13:29:00.000000000 +0200
+++ linux-2.6-dirty/fs/buffer.c	2006-06-27 13:35:10.000000000 +0200
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
Index: linux-2.6-dirty/include/linux/mm.h
===================================================================
--- linux-2.6-dirty.orig/include/linux/mm.h	2006-06-27 13:29:00.000000000 +0200
+++ linux-2.6-dirty/include/linux/mm.h	2006-06-27 13:35:10.000000000 +0200
@@ -14,6 +14,7 @@
 #include <linux/prio_tree.h>
 #include <linux/fs.h>
 #include <linux/mutex.h>
+#include <linux/backing-dev.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -796,6 +797,44 @@ struct shrinker;
 extern struct shrinker *set_shrinker(int, shrinker_t);
 extern void remove_shrinker(struct shrinker *shrinker);
 
+#define VM_NOTIFY_NO_PROT	0x01
+#define VM_NOTIFY_NO_MKWRITE	0x02
+
+/*
+ * Some shared mappigns will want the pages marked read-only
+ * to track write events. If so, we'll downgrade vm_page_prot
+ * to the private version (using protection_map[] without the
+ * VM_SHARED bit).
+ */
+static inline int vma_wants_writenotify(struct vm_area_struct *vma, int flags)
+{
+	unsigned int vm_flags = vma->vm_flags;
+
+	/* If it was private or non-writable, the write bit is already clear */
+	if ((vm_flags & (VM_WRITE|VM_SHARED)) != ((VM_WRITE|VM_SHARED)))
+		return 0;
+
+	/* The backer wishes to know when pages are first written to? */
+	if (!(flags & VM_NOTIFY_NO_MKWRITE) &&
+			vma->vm_ops && vma->vm_ops->page_mkwrite)
+		return 1;
+
+	/* The open routine did something to the protections already? */
+	if (!(flags & VM_NOTIFY_NO_PROT) &&
+			pgprot_val(vma->vm_page_prot) !=
+			pgprot_val(protection_map[vm_flags &
+				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]))
+		return 0;
+
+	/* Specialty mapping? */
+	if (vm_flags & (VM_PFNMAP|VM_INSERTPAGE))
+		return 0;
+
+	/* Can the mapping track the dirty pages? */
+	return vma->vm_file && vma->vm_file->f_mapping &&
+		mapping_cap_account_dirty(vma->vm_file->f_mapping);
+}
+
 extern pte_t *FASTCALL(get_locked_pte(struct mm_struct *mm, unsigned long addr, spinlock_t **ptl));
 
 int __pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address);
