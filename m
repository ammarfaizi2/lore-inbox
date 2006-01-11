Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWAKMUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWAKMUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWAKMUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:20:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32728 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751212AbWAKMUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:20:04 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <16217.1133364032@warthog.cambridge.redhat.com> 
References: <16217.1133364032@warthog.cambridge.redhat.com>  <5425.1133359116@warthog.cambridge.redhat.com> <15253.1130246296@warthog.cambridge.redhat.com> <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com> <1130168619.19518.43.camel@imp.csi.cam.ac.uk> <1130167005.19518.35.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com> <7872.1130167591@warthog.cambridge.redhat.com> <9792.1130171024@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       Miklos Szeredi <miklos@szeredi.hu>
Cc: Hugh Dickins <hugh@veritas.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Add notification of page becoming writable to VMA ops [try #5] 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 11 Jan 2006 12:19:41 +0000
Message-ID: <19464.1136981981@warthog.cambridge.redhat.com>
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

 (*) Account and limit number of dirty pages. This is one piece of the puzzle
     needed to make shared writable mapping work safely in FUSE.

Updated to 2.6.15-mm2.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 page-mkwrite-2615mm2.diff
 include/linux/mm.h |    4 ++
 mm/memory.c        |   99 ++++++++++++++++++++++++++++++++++++++++-------------
 mm/mmap.c          |   12 +++++-
 mm/mprotect.c      |   11 ++++-
 4 files changed, 98 insertions(+), 28 deletions(-)

diff -uNrp linux-2.6.15-mm2/include/linux/mm.h linux-2.6.15-mm2-page-mkwrite/include/linux/mm.h
--- linux-2.6.15-mm2/include/linux/mm.h	2006-01-11 11:21:16.000000000 +0000
+++ linux-2.6.15-mm2-page-mkwrite/include/linux/mm.h	2006-01-11 11:38:13.000000000 +0000
@@ -199,6 +199,10 @@ struct vm_operations_struct {
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
diff -uNrp linux-2.6.15-mm2/mm/memory.c linux-2.6.15-mm2-page-mkwrite/mm/memory.c
--- linux-2.6.15-mm2/mm/memory.c	2006-01-11 11:21:17.000000000 +0000
+++ linux-2.6.15-mm2-page-mkwrite/mm/memory.c	2006-01-11 11:52:05.000000000 +0000
@@ -1438,25 +1438,59 @@ static int do_wp_page(struct mm_struct *
 {
 	struct page *old_page, *new_page;
 	pte_t entry;
-	int ret = VM_FAULT_MINOR;
+	int reuse, ret = VM_FAULT_MINOR;
 
 	old_page = vm_normal_page(vma, address, orig_pte);
 	if (!old_page)
 		goto gotten;
 
-	if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
-		int reuse = can_share_swap_page(old_page);
-		unlock_page(old_page);
-		if (reuse) {
-			flush_cache_page(vma, address, pte_pfn(orig_pte));
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
@@ -1516,6 +1550,10 @@ oom:
 	if (old_page)
 		page_cache_release(old_page);
 	return VM_FAULT_OOM;
+
+unwritable_page:
+	page_cache_release(old_page);
+	return VM_FAULT_SIGBUS;
 }
 
 /*
@@ -2060,18 +2098,31 @@ retry:
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
diff -uNrp linux-2.6.15-mm2/mm/mmap.c linux-2.6.15-mm2-page-mkwrite/mm/mmap.c
--- linux-2.6.15-mm2/mm/mmap.c	2006-01-04 12:39:43.000000000 +0000
+++ linux-2.6.15-mm2-page-mkwrite/mm/mmap.c	2006-01-11 11:38:13.000000000 +0000
@@ -1058,7 +1058,8 @@ munmap_back:
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
 	vma->vm_flags = vm_flags;
-	vma->vm_page_prot = protection_map[vm_flags & 0x0f];
+	vma->vm_page_prot = protection_map[vm_flags &
+				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
@@ -1082,6 +1083,12 @@ munmap_back:
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
@@ -1915,7 +1922,8 @@ unsigned long do_brk(unsigned long addr,
 	vma->vm_end = addr + len;
 	vma->vm_pgoff = pgoff;
 	vma->vm_flags = flags;
-	vma->vm_page_prot = protection_map[flags & 0x0f];
+	vma->vm_page_prot = protection_map[flags &
+				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 out:
 	mm->total_vm += len >> PAGE_SHIFT;
diff -uNrp linux-2.6.15-mm2/mm/mprotect.c linux-2.6.15-mm2-page-mkwrite/mm/mprotect.c
--- linux-2.6.15-mm2/mm/mprotect.c	2006-01-04 12:39:43.000000000 +0000
+++ linux-2.6.15-mm2-page-mkwrite/mm/mprotect.c	2006-01-11 11:38:13.000000000 +0000
@@ -106,6 +106,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	unsigned long oldflags = vma->vm_flags;
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	unsigned int mask;
 	pgprot_t newprot;
 	pgoff_t pgoff;
 	int error;
@@ -132,8 +133,6 @@ mprotect_fixup(struct vm_area_struct *vm
 		}
 	}
 
-	newprot = protection_map[newflags & 0xf];
-
 	/*
 	 * First try to merge with previous and/or next vma.
 	 */
@@ -160,6 +159,14 @@ mprotect_fixup(struct vm_area_struct *vm
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
