Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWFMLXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWFMLXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 07:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWFMLXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 07:23:07 -0400
Received: from [213.46.243.16] ([213.46.243.16]:38224 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751024AbWFMLW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 07:22:58 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Tue, 13 Jun 2006 13:22:34 +0200
Message-Id: <20060613112234.27913.61662.sendpatchset@lappy>
In-Reply-To: <20060613112120.27913.71986.sendpatchset@lappy>
References: <20060613112120.27913.71986.sendpatchset@lappy>
Subject: [PATCH 7/6] mm: page_mkwrite
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: David Howells <dhowells@redhat.com>

The attached patch adds a new VMA operation to notify a filesystem or other
driver about the MMU generating a fault because userspace attempted to write
to a page mapped through a read-only PTE.

This facility permits the filesystem or driver to:

 (*) Implement storage allocation/reservation on attempted write, and so to
     deal with problems such as ENOSPC more gracefully (perhaps by generating
     SIGBUS).

 (*) Delay making the page writable until the contents have been written to a
     backing cache. This is useful for NFS/AFS when using FS-Cache/CacheFS.
     It permits the filesystem to have some guarantee about the state of the
     cache.

 (*) Account and limit number of dirty pages. This is one piece of the puzzle
     needed to make shared writable mapping work safely in FUSE.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-Off-By: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 include/linux/mm.h |    4 +++
 mm/memory.c        |   67 ++++++++++++++++++++++++++++++++++++++++++++---------
 mm/mmap.c          |    3 +-
 mm/mprotect.c      |    3 +-
 4 files changed, 64 insertions(+), 13 deletions(-)

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h	2006-06-13 12:15:28.000000000 +0200
+++ linux-2.6/include/linux/mm.h	2006-06-13 12:15:33.000000000 +0200
@@ -206,6 +206,10 @@ struct vm_operations_struct {
 	void (*close)(struct vm_area_struct * area);
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int *type);
 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
+
+	/* notification that a previously read-only page is about to become
+	 * writable, if an error is returned it will cause a SIGBUS */
+	int (*page_mkwrite)(struct vm_area_struct *vma, struct page *page);
 #ifdef CONFIG_NUMA
 	int (*set_policy)(struct vm_area_struct *vma, struct mempolicy *new);
 	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2006-06-13 12:15:28.000000000 +0200
+++ linux-2.6/mm/memory.c	2006-06-13 12:20:00.000000000 +0200
@@ -1465,6 +1465,35 @@ static int do_wp_page(struct mm_struct *
 	 * Makes COW happen for readonly shared mappings too.
 	 */
 	if (unlikely(is_shared_writable(vma->vm_flags))) {
+		if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
+			/*
+			 * Notify the address space that the page is about to
+			 * become writable so that it can prohibit this or wait
+			 * for the page to get into an appropriate state.
+			 *
+			 * We do this without the lock held, so that it can
+			 * sleep if it needs to.
+			 */
+			page_cache_get(old_page);
+			pte_unmap_unlock(page_table, ptl);
+
+			if (vma->vm_ops->page_mkwrite(vma, old_page) < 0)
+				goto unwritable_page;
+
+			page_cache_release(old_page);
+
+			/*
+			 * Since we dropped the lock we need to revalidate
+			 * the PTE as someone else may have changed it.  If
+			 * they did, we just return, as we can count on the
+			 * MMU to tell us if they didn't also make it writable.
+			 */
+			page_table = pte_offset_map_lock(mm, pmd, address,
+							 &ptl);
+			if (!pte_same(*page_table, orig_pte))
+				goto unlock;
+		}
+
 		reuse = 1;
 		dirty_page = old_page;
 		get_page(dirty_page);
@@ -1544,6 +1573,10 @@ oom:
 	if (old_page)
 		page_cache_release(old_page);
 	return VM_FAULT_OOM;
+
+unwritable_page:
+	page_cache_release(old_page);
+	return VM_FAULT_SIGBUS;
 }
 
 /*
@@ -2096,18 +2129,30 @@ retry:
 	/*
 	 * Should we do an early C-O-W break?
 	 */
-	if (write_access && !(vma->vm_flags & VM_SHARED)) {
-		struct page *page;
+	if (write_access) {
+		if (!(vma->vm_flags & VM_SHARED)) {
+			struct page *page;
 
-		if (unlikely(anon_vma_prepare(vma)))
-			goto oom;
-		page = alloc_page_vma(GFP_HIGHUSER, vma, address);
-		if (!page)
-			goto oom;
-		copy_user_highpage(page, new_page, address);
-		page_cache_release(new_page);
-		new_page = page;
-		anon = 1;
+			if (unlikely(anon_vma_prepare(vma)))
+				goto oom;
+			page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+			if (!page)
+				goto oom;
+			copy_user_highpage(page, new_page, address);
+			page_cache_release(new_page);
+			new_page = page;
+			anon = 1;
+		} else {
+			/* if the page will be shareable, see if the backing
+			 * address space wants to know that the page is about
+			 * to become writable */
+			if (vma->vm_ops->page_mkwrite &&
+			    vma->vm_ops->page_mkwrite(vma, new_page) < 0
+			    ) {
+				page_cache_release(new_page);
+				return VM_FAULT_SIGBUS;
+			}
+		}
 	}
 
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
Index: linux-2.6/mm/mmap.c
===================================================================
--- linux-2.6.orig/mm/mmap.c	2006-06-13 12:15:28.000000000 +0200
+++ linux-2.6/mm/mmap.c	2006-06-13 12:21:49.000000000 +0200
@@ -1128,7 +1128,8 @@ munmap_back:
 	 */
 	if (is_shared_writable(vm_flags) && vma->vm_file)
 		mapping = vma->vm_file->f_mapping;
-	if (mapping && mapping_cap_account_dirty(mapping))
+	if ((mapping && mapping_cap_account_dirty(mapping)) ||
+			(vma->vm_ops && vma->vm_ops->page_mkwrite))
 		vma->vm_page_prot =
 			__pgprot(pte_val
 				(pte_wrprotect
Index: linux-2.6/mm/mprotect.c
===================================================================
--- linux-2.6.orig/mm/mprotect.c	2006-06-13 12:15:28.000000000 +0200
+++ linux-2.6/mm/mprotect.c	2006-06-13 12:26:46.000000000 +0200
@@ -176,7 +176,8 @@ success:
 	mask = VM_READ|VM_WRITE|VM_EXEC|VM_SHARED;
 	if (is_shared_writable(newflags) && vma->vm_file)
 		mapping = vma->vm_file->f_mapping;
-	if (mapping && mapping_cap_account_dirty(mapping)) {
+	if ((mapping && mapping_cap_account_dirty(mapping)) ||
+			(vma->vm_ops && vma->vm_ops->page_mkwrite)) {
 		mask &= ~VM_SHARED;
 		is_accountable = 1;
 	}
