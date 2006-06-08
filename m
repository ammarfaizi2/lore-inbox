Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWFHMot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWFHMot (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 08:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWFHMot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 08:44:49 -0400
Received: from [213.46.243.16] ([213.46.243.16]:25188 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S964820AbWFHMos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 08:44:48 -0400
Subject: [PATCH] mm: tracking dirty pages -v6
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606062056540.1507@blonde.wat.veritas.com>
References: <20060525135534.20941.91650.sendpatchset@lappy>
	 <Pine.LNX.4.64.0606062056540.1507@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 14:44:14 +0200
Message-Id: <1149770654.4408.71.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
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

Changes in -v6

 - make page_mkclean_one() modify the pte more like change_pte_range() 
   (suggested by Christoph Lameter)
 - made is_shared_writable() take vm_flags, it now resembles is_cow_mapping().
 - fixed the mprotect() bug (spotted by Hugh Dickins)
 - hopefully fixed the tiresome issue of do_mmap_pgoff() trampling on
   driver specific vm_page_prot settings (spotted by Hugh Dickins)

   This does add the requirement that f_op->mmap() may not 'reset' 
   vm_page_prot from vm_flags. I checked all in-kernel users and non seem
   to do this.

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

 drivers/char/drm/drm_vm.c |    5 ++-
 fs/buffer.c               |    2 -
 include/linux/mm.h        |    5 +++
 include/linux/rmap.h      |    8 +++++
 mm/memory.c               |   45 +++++++++++++++++++++++---------
 mm/mmap.c                 |   28 ++++++++++++++++++--
 mm/mprotect.c             |   14 ++++++++--
 mm/page-writeback.c       |   13 +++++++--
 mm/rmap.c                 |   64 ++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 163 insertions(+), 21 deletions(-)

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h	2006-06-08 13:59:35.000000000 +0200
+++ linux-2.6/include/linux/mm.h	2006-06-08 13:59:37.000000000 +0200
@@ -183,6 +183,11 @@ extern unsigned int kobjsize(const void 
 #define VM_SequentialReadHint(v)	((v)->vm_flags & VM_SEQ_READ)
 #define VM_RandomReadHint(v)		((v)->vm_flags & VM_RAND_READ)
 
+static inline int is_shared_writable(unsigned int flags)
+{
+	return (flags & (VM_SHARED|VM_WRITE)) == (VM_SHARED|VM_WRITE);
+}
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2006-06-08 13:59:35.000000000 +0200
+++ linux-2.6/mm/memory.c	2006-06-08 13:59:37.000000000 +0200
@@ -1445,25 +1445,31 @@ static int do_wp_page(struct mm_struct *
 {
 	struct page *old_page, *new_page;
 	pte_t entry;
-	int ret = VM_FAULT_MINOR;
+	int reuse = 0, ret = VM_FAULT_MINOR;
+	struct page *dirty_page = NULL;
 
 	old_page = vm_normal_page(vma, address, orig_pte);
 	if (!old_page)
 		goto gotten;
 
-	if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
-		int reuse = can_share_swap_page(old_page);
+	if (vma->vm_flags & VM_SHARED) {
+		reuse = 1;
+		dirty_page = old_page;
+		get_page(dirty_page);
+	} else if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
+		reuse = can_share_swap_page(old_page);
 		unlock_page(old_page);
-		if (reuse) {
-			flush_cache_page(vma, address, pte_pfn(orig_pte));
-			entry = pte_mkyoung(orig_pte);
-			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-			ptep_set_access_flags(vma, address, page_table, entry, 1);
-			update_mmu_cache(vma, address, entry);
-			lazy_mmu_prot_update(entry);
-			ret |= VM_FAULT_WRITE;
-			goto unlock;
-		}
+	}
+
+	if (reuse) {
+		flush_cache_page(vma, address, pte_pfn(orig_pte));
+		entry = pte_mkyoung(orig_pte);
+		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		ptep_set_access_flags(vma, address, page_table, entry, 1);
+		update_mmu_cache(vma, address, entry);
+		lazy_mmu_prot_update(entry);
+		ret |= VM_FAULT_WRITE;
+		goto unlock;
 	}
 
 	/*
@@ -1518,6 +1524,10 @@ gotten:
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
@@ -2046,6 +2056,7 @@ static int do_no_page(struct mm_struct *
 	unsigned int sequence = 0;
 	int ret = VM_FAULT_MINOR;
 	int anon = 0;
+	struct page *dirty_page = NULL;
 
 	pte_unmap(page_table);
 	BUG_ON(vma->vm_flags & VM_PFNMAP);
@@ -2127,6 +2138,10 @@ retry:
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
@@ -2139,6 +2154,10 @@ retry:
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
Index: linux-2.6/mm/mmap.c
===================================================================
--- linux-2.6.orig/mm/mmap.c	2006-06-08 13:59:35.000000000 +0200
+++ linux-2.6/mm/mmap.c	2006-06-08 14:08:04.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/mount.h>
 #include <linux/mempolicy.h>
 #include <linux/rmap.h>
+#include <linux/backing-dev.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -1065,10 +1066,13 @@ munmap_back:
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
 	vma->vm_flags = vm_flags;
-	vma->vm_page_prot = protection_map[vm_flags & 0x0f];
+	vma->vm_page_prot = protection_map[vm_flags &
+				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
+		struct address_space *mapping = NULL;
+
 		error = -EINVAL;
 		if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
 			goto free_vma;
@@ -1080,6 +1084,25 @@ munmap_back:
 		}
 		vma->vm_file = file;
 		get_file(file);
+
+		/* Trap writes to shared writable mappings that have
+		 * dirty page accounting.
+		 *
+		 * f_op->open() - sets the backing_dev_info
+		 * f_op->mmap() - modifies vm_page_prot; but will not reset
+		 *                from vm_flags.
+		 *
+		 * Hence between the two calls (here) it is save to modify
+		 * vm_page_prot depending on backing_dev_info capabilities.
+		 *
+		 * shmem_backing_dev_info does have BDI_CAP_NO_ACCT_DIRTY.
+		 */
+		if (is_shared_writable(vm_flags))
+			mapping = file->f_mapping;
+		if (mapping && mapping_cap_account_dirty(mapping))
+			vma->vm_page_prot = protection_map[vm_flags &
+				(VM_READ|VM_WRITE|VM_EXEC)];
+
 		error = file->f_op->mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
@@ -1921,7 +1944,8 @@ unsigned long do_brk(unsigned long addr,
 	vma->vm_end = addr + len;
 	vma->vm_pgoff = pgoff;
 	vma->vm_flags = flags;
-	vma->vm_page_prot = protection_map[flags & 0x0f];
+	vma->vm_page_prot = protection_map[flags &
+				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 out:
 	mm->total_vm += len >> PAGE_SHIFT;
Index: linux-2.6/mm/mprotect.c
===================================================================
--- linux-2.6.orig/mm/mprotect.c	2006-06-08 13:59:35.000000000 +0200
+++ linux-2.6/mm/mprotect.c	2006-06-08 14:15:24.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/mempolicy.h>
 #include <linux/personality.h>
 #include <linux/syscalls.h>
+#include <linux/backing-dev.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -106,6 +107,8 @@ mprotect_fixup(struct vm_area_struct *vm
 	unsigned long oldflags = vma->vm_flags;
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	unsigned int mask;
+	struct address_space *mapping = NULL;
 	pgprot_t newprot;
 	pgoff_t pgoff;
 	int error;
@@ -132,8 +135,6 @@ mprotect_fixup(struct vm_area_struct *vm
 		}
 	}
 
-	newprot = protection_map[newflags & 0xf];
-
 	/*
 	 * First try to merge with previous and/or next vma.
 	 */
@@ -160,6 +161,15 @@ mprotect_fixup(struct vm_area_struct *vm
 	}
 
 success:
+	/* Don't make the VMA automatically writable if it's shared. */
+	mask = VM_READ|VM_WRITE|VM_EXEC|VM_SHARED;
+	if (is_shared_writable(newflags) && vma->vm_file)
+		mapping = vma->vm_file->f_mapping;
+	if (mapping && mapping_cap_account_dirty(mapping))
+		mask &= ~VM_SHARED;
+
+	newprot = protection_map[newflags & mask];
+
 	/*
 	 * vm_flags and vm_page_prot are protected by the mmap_sem
 	 * held in write mode.
Index: linux-2.6/mm/page-writeback.c
===================================================================
--- linux-2.6.orig/mm/page-writeback.c	2006-06-08 13:59:35.000000000 +0200
+++ linux-2.6/mm/page-writeback.c	2006-06-08 13:59:37.000000000 +0200
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
--- linux-2.6.orig/mm/rmap.c	2006-06-08 13:59:35.000000000 +0200
+++ linux-2.6/mm/rmap.c	2006-06-08 13:59:37.000000000 +0200
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
+	entry = ptep_get_and_clear(mm, address, pte);
+	entry = pte_mkclean(pte_wrprotect(entry));
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
+		if (is_shared_writable(vma->vm_flags))
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
--- linux-2.6.orig/include/linux/rmap.h	2006-06-08 13:59:35.000000000 +0200
+++ linux-2.6/include/linux/rmap.h	2006-06-08 13:59:37.000000000 +0200
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
--- linux-2.6.orig/fs/buffer.c	2006-06-08 13:59:35.000000000 +0200
+++ linux-2.6/fs/buffer.c	2006-06-08 13:59:37.000000000 +0200
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
Index: linux-2.6/drivers/char/drm/drm_vm.c
===================================================================
--- linux-2.6.orig/drivers/char/drm/drm_vm.c	2006-04-07 10:54:38.000000000 +0200
+++ linux-2.6/drivers/char/drm/drm_vm.c	2006-06-08 14:11:37.000000000 +0200
@@ -574,7 +574,10 @@ int drm_mmap(struct file *filp, struct v
 #else
 		/* Ye gads this is ugly.  With more thought
 		   we could move this up higher and use
-		   `protection_map' instead.  */
+		   `protection_map' instead.
+
+		   One cannot; drivers are not allowed to 'reset'
+		   vm_page_prot from vm_flags. */
 		vma->vm_page_prot =
 		    __pgprot(pte_val
 			     (pte_wrprotect


