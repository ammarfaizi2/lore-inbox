Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVK3N7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVK3N7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 08:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVK3N7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 08:59:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24251 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751243AbVK3N7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 08:59:05 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <15253.1130246296@warthog.cambridge.redhat.com> 
References: <15253.1130246296@warthog.cambridge.redhat.com>  <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com> <1130168619.19518.43.camel@imp.csi.cam.ac.uk> <1130167005.19518.35.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com> <7872.1130167591@warthog.cambridge.redhat.com> <9792.1130171024@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Add notification of page becoming writable to VMA ops [try #3] 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 30 Nov 2005 13:58:36 +0000
Message-ID: <5425.1133359116@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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

Updated to 2.6.14-git14.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 page-mkwrite-2614git14.diff 
 include/linux/mm.h |    4 ++
 mm/memory.c        |   95 +++++++++++++++++++++++++++++++++++++++--------------
 mm/mmap.c          |   12 +++++-
 mm/mprotect.c      |   11 +++++-
 4 files changed, 94 insertions(+), 28 deletions(-)

diff -uNrp linux-2.6.14-git14/include/linux/mm.h linux-2.6.14-git14-pagenotify/include/linux/mm.h
--- linux-2.6.14-git14/include/linux/mm.h	2005-11-30 13:01:27.000000000 +0000
+++ linux-2.6.14-git14-pagenotify/include/linux/mm.h	2005-11-30 13:02:48.000000000 +0000
@@ -196,6 +196,10 @@ struct vm_operations_struct {
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
diff -uNrp linux-2.6.14-git14/mm/memory.c linux-2.6.14-git14-pagenotify/mm/memory.c
--- linux-2.6.14-git14/mm/memory.c	2005-11-30 13:01:29.000000000 +0000
+++ linux-2.6.14-git14-pagenotify/mm/memory.c	2005-11-30 13:15:50.000000000 +0000
@@ -1253,7 +1253,7 @@ static int do_wp_page(struct mm_struct *
 	struct page *old_page, *new_page;
 	unsigned long pfn = pte_pfn(orig_pte);
 	pte_t entry;
-	int ret = VM_FAULT_MINOR;
+	int reuse, ret = VM_FAULT_MINOR;
 
 	BUG_ON(vma->vm_flags & VM_RESERVED);
 
@@ -1267,19 +1267,49 @@ static int do_wp_page(struct mm_struct *
 	}
 	old_page = pfn_to_page(pfn);
 
-	if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
-		int reuse = can_share_swap_page(old_page);
-		unlock_page(old_page);
-		if (reuse) {
-			flush_cache_page(vma, address, pfn);
-			entry = pte_mkyoung(orig_pte);
-			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-			ptep_set_access_flags(vma, address, page_table, entry, 1);
-			update_mmu_cache(vma, address, entry);
-			lazy_mmu_prot_update(entry);
-			ret |= VM_FAULT_WRITE;
-			goto unlock;
+	if (unlikely(vma->vm_flags & VM_SHARED)) {
+		if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
+			/*
+			 * Notify the page owner without the lock held,
+			 * so they can sleep if they want to.
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
 		}
+
+		reuse = 1;
+	} else if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
+		reuse = can_share_swap_page(old_page);
+		unlock_page(old_page);
+	} else {
+		reuse = 0;
+	}
+
+	if (reuse) {
+		flush_cache_page(vma, address, pfn);
+		entry = pte_mkyoung(orig_pte);
+		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		ptep_set_access_flags(vma, address, page_table, entry, 1);
+		update_mmu_cache(vma, address, entry);
+		lazy_mmu_prot_update(entry);
+		ret |= VM_FAULT_WRITE;
+		goto unlock;
 	}
 
 	/*
@@ -1332,6 +1362,10 @@ unlock:
 oom:
 	page_cache_release(old_page);
 	return VM_FAULT_OOM;
+
+unwritable_page:
+	page_cache_release(old_page);
+	return VM_FAULT_SIGBUS;
 }
 
 /*
@@ -1853,18 +1887,31 @@ retry:
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
+
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
diff -uNrp linux-2.6.14-git14/mm/mmap.c linux-2.6.14-git14-pagenotify/mm/mmap.c
--- linux-2.6.14-git14/mm/mmap.c	2005-11-30 13:01:29.000000000 +0000
+++ linux-2.6.14-git14-pagenotify/mm/mmap.c	2005-11-30 13:27:19.000000000 +0000
@@ -1058,7 +1058,8 @@ munmap_back:
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
 	vma->vm_flags = vm_flags;
-	vma->vm_page_prot = protection_map[vm_flags & 0x0f];
+	vma->vm_page_prot = protection_map[vm_flags &
+				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
@@ -1093,6 +1094,12 @@ munmap_back:
 			goto free_vma;
 	}
 
+	/* Don't make the VMA automatically writable if it's shared, but the
+	 * backer wishes to know when pages are first written to */
+	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
+		vma->vm_page_prot =
+			protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC)];
+
 	/* We set VM_ACCOUNT in a shared mapping's vm_flags, to inform
 	 * shmem_zero_setup (perhaps called through /dev/zero's ->mmap)
 	 * that memory reservation must be checked; but that reservation
@@ -1926,7 +1933,8 @@ unsigned long do_brk(unsigned long addr,
 	vma->vm_end = addr + len;
 	vma->vm_pgoff = pgoff;
 	vma->vm_flags = flags;
-	vma->vm_page_prot = protection_map[flags & 0x0f];
+	vma->vm_page_prot = protection_map[flags &
+				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 out:
 	mm->total_vm += len >> PAGE_SHIFT;
diff -uNrp linux-2.6.14-git14/mm/mprotect.c linux-2.6.14-git14-pagenotify/mm/mprotect.c
--- linux-2.6.14-git14/mm/mprotect.c	2005-11-30 13:01:29.000000000 +0000
+++ linux-2.6.14-git14-pagenotify/mm/mprotect.c	2005-11-30 13:26:37.000000000 +0000
@@ -106,6 +106,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	unsigned long oldflags = vma->vm_flags;
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	unsigned int mask;
 	pgprot_t newprot;
 	pgoff_t pgoff;
 	int error;
@@ -140,8 +141,6 @@ mprotect_fixup(struct vm_area_struct *vm
 		}
 	}
 
-	newprot = protection_map[newflags & 0xf];
-
 	/*
 	 * First try to merge with previous and/or next vma.
 	 */
@@ -168,6 +167,14 @@ mprotect_fixup(struct vm_area_struct *vm
 	}
 
 success:
+	/* Don't make the VMA automatically writable if it's shared, but the
+	 * backer wishes to know when pages are first written to */
+	mask = VM_READ|VM_WRITE|VM_EXEC|VM_SHARED;
+	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
+		mask &= ~VM_SHARED;
+
+	newprot = protection_map[newflags & mask];
+
 	/*
 	 * vm_flags and vm_page_prot are protected by the mmap_sem
 	 * held in write mode.
