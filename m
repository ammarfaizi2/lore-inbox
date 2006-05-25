Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbWEYNz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWEYNz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 09:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWEYNz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 09:55:59 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:38183 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S965172AbWEYNz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 09:55:57 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Thu, 25 May 2006 15:55:55 +0200
Message-Id: <20060525135555.20941.36612.sendpatchset@lappy>
In-Reply-To: <20060525135534.20941.91650.sendpatchset@lappy>
References: <20060525135534.20941.91650.sendpatchset@lappy>
Subject: [PATCH 1/3] mm: tracking shared dirty pages
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

 fs/buffer.c          |    2 -
 include/linux/mm.h   |    5 +++
 include/linux/rmap.h |    8 ++++++
 mm/fremap.c          |    4 +--
 mm/memory.c          |   20 +++++++++++++++
 mm/mmap.c            |    7 ++++-
 mm/mprotect.c        |    7 ++++-
 mm/page-writeback.c  |   13 ++++++++--
 mm/rmap.c            |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 122 insertions(+), 8 deletions(-)

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h	2006-05-25 15:46:03.000000000 +0200
+++ linux-2.6/include/linux/mm.h	2006-05-25 15:46:08.000000000 +0200
@@ -183,6 +183,11 @@ extern unsigned int kobjsize(const void 
 #define VM_SequentialReadHint(v)	((v)->vm_flags & VM_SEQ_READ)
 #define VM_RandomReadHint(v)		((v)->vm_flags & VM_RAND_READ)
 
+static inline int is_shared_writable(struct vm_area_struct *vma)
+{
+	return (vma->vm_flags & (VM_SHARED|VM_WRITE)) == (VM_SHARED|VM_WRITE);
+}
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
Index: linux-2.6/mm/fremap.c
===================================================================
--- linux-2.6.orig/mm/fremap.c	2006-05-25 15:07:43.000000000 +0200
+++ linux-2.6/mm/fremap.c	2006-05-25 15:46:08.000000000 +0200
@@ -79,9 +79,9 @@ int install_page(struct mm_struct *mm, s
 		inc_mm_counter(mm, file_rss);
 
 	flush_icache_page(vma, page);
-	set_pte_at(mm, addr, pte, mk_pte(page, prot));
+	pte_val = mk_pte(page, prot);
+	set_pte_at(mm, addr, pte, pte_val);
 	page_add_file_rmap(page);
-	pte_val = *pte;
 	update_mmu_cache(vma, addr, pte_val);
 	err = 0;
 unlock:
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2006-05-25 15:46:03.000000000 +0200
+++ linux-2.6/mm/memory.c	2006-05-25 15:47:10.000000000 +0200
@@ -48,6 +48,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/backing-dev.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -1446,12 +1447,13 @@ static int do_wp_page(struct mm_struct *
 	struct page *old_page, *new_page;
 	pte_t entry;
 	int reuse, ret = VM_FAULT_MINOR;
+	struct page *dirty_page = NULL;
 
 	old_page = vm_normal_page(vma, address, orig_pte);
 	if (!old_page)
 		goto gotten;
 
-	if (unlikely(vma->vm_flags & VM_SHARED)) {
+	if (vma->vm_flags & VM_SHARED) {
 		if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
 			/*
 			 * Notify the address space that the page is about to
@@ -1482,6 +1484,9 @@ static int do_wp_page(struct mm_struct *
 		}
 
 		reuse = 1;
+
+		dirty_page = old_page;
+		get_page(dirty_page);
 	} else if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
 		reuse = can_share_swap_page(old_page);
 		unlock_page(old_page);
@@ -1552,6 +1557,10 @@ gotten:
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
@@ -2084,6 +2093,7 @@ static int do_no_page(struct mm_struct *
 	unsigned int sequence = 0;
 	int ret = VM_FAULT_MINOR;
 	int anon = 0;
+	struct page *dirty_page = NULL;
 
 	pte_unmap(page_table);
 	BUG_ON(vma->vm_flags & VM_PFNMAP);
@@ -2178,6 +2188,10 @@ retry:
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
@@ -2190,6 +2204,10 @@ retry:
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
Index: linux-2.6/mm/page-writeback.c
===================================================================
--- linux-2.6.orig/mm/page-writeback.c	2006-05-25 15:07:44.000000000 +0200
+++ linux-2.6/mm/page-writeback.c	2006-05-25 15:47:10.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/rmap.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -725,8 +726,14 @@ int test_clear_page_dirty(struct page *p
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
@@ -756,8 +763,10 @@ int clear_page_dirty_for_io(struct page 
 
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
Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c	2006-05-25 15:07:46.000000000 +0200
+++ linux-2.6/mm/rmap.c	2006-05-25 15:46:08.000000000 +0200
@@ -472,6 +472,70 @@ int page_referenced(struct page *page, i
 	return referenced;
 }
 
+static int page_mkclean_one(struct page *page, struct vm_area_struct *vma)
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
+	if (!pte_write(*pte))
+		goto unlock;
+
+	entry = pte_mkclean(pte_wrprotect(*pte));
+	ptep_establish(vma, address, pte, entry);
+	update_mmu_cache(vma, address, entry);
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
+		if (is_shared_writable(vma))
+			ret += page_mkclean_one(page, vma);
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
Index: linux-2.6/include/linux/rmap.h
===================================================================
--- linux-2.6.orig/include/linux/rmap.h	2006-05-25 15:07:46.000000000 +0200
+++ linux-2.6/include/linux/rmap.h	2006-05-25 15:46:08.000000000 +0200
@@ -105,6 +105,14 @@ pte_t *page_check_address(struct page *,
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
Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c	2006-05-25 15:07:43.000000000 +0200
+++ linux-2.6/fs/buffer.c	2006-05-25 15:46:09.000000000 +0200
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
Index: linux-2.6/mm/mmap.c
===================================================================
--- linux-2.6.orig/mm/mmap.c	2006-05-25 15:46:03.000000000 +0200
+++ linux-2.6/mm/mmap.c	2006-05-25 15:46:45.000000000 +0200
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
@@ -1092,7 +1094,10 @@ munmap_back:
 
 	/* Don't make the VMA automatically writable if it's shared, but the
 	 * backer wishes to know when pages are first written to */
-	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
+	if (is_shared_writable(vma) && vma->vm_file)
+		mapping = vma->vm_file->f_mapping;
+	if ((mapping && mapping_cap_account_dirty(mapping)) ||
+			(vma->vm_ops && vma->vm_ops->page_mkwrite))
 		vma->vm_page_prot =
 			protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC)];
 
Index: linux-2.6/mm/mprotect.c
===================================================================
--- linux-2.6.orig/mm/mprotect.c	2006-05-25 15:46:03.000000000 +0200
+++ linux-2.6/mm/mprotect.c	2006-05-25 15:46:09.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/mempolicy.h>
 #include <linux/personality.h>
 #include <linux/syscalls.h>
+#include <linux/backing-dev.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -107,6 +108,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned long charged = 0;
 	unsigned int mask;
+	struct address_space *mapping = NULL;
 	pgprot_t newprot;
 	pgoff_t pgoff;
 	int error;
@@ -162,7 +164,10 @@ success:
 	/* Don't make the VMA automatically writable if it's shared, but the
 	 * backer wishes to know when pages are first written to */
 	mask = VM_READ|VM_WRITE|VM_EXEC|VM_SHARED;
-	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
+	if (is_shared_writable(vma) && vma->vm_file)
+		mapping = vma->vm_file->f_mapping;
+	if ((mapping && mapping_cap_account_dirty(mapping)) ||
+			(vma->vm_ops && vma->vm_ops->page_mkwrite))
 		mask &= ~VM_SHARED;
 
 	newprot = protection_map[newflags & mask];
