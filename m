Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVJXQYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVJXQYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVJXQYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:24:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3306 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751138AbVJXQYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:24:07 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1130168619.19518.43.camel@imp.csi.cam.ac.uk> 
References: <1130168619.19518.43.camel@imp.csi.cam.ac.uk>  <1130167005.19518.35.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com> <7872.1130167591@warthog.cambridge.redhat.com> 
To: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org
Cc: David Howells <dhowells@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Add notification of page becoming writable to VMA ops
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Mon, 24 Oct 2005 17:23:44 +0100
Message-ID: <9792.1130171024@warthog.cambridge.redhat.com>
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

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 page-mkwrite-2614rc4mm1.diff
 include/linux/mm.h |    4 +
 mm/memory.c        |  125 ++++++++++++++++++++++++++++++++++++++++++-----------
 mm/mmap.c          |    9 ++-
 mm/mprotect.c      |    8 ++-
 4 files changed, 117 insertions(+), 29 deletions(-)

diff -uNrp linux-2.6.14-rc4-mm1/include/linux/mm.h linux-2.6.14-rc4-mm1-cachefs/include/linux/mm.h
--- linux-2.6.14-rc4-mm1/include/linux/mm.h	2005-10-17 14:26:43.000000000 +0100
+++ linux-2.6.14-rc4-mm1-cachefs/include/linux/mm.h	2005-10-18 14:02:39.000000000 +0100
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
diff -uNrp linux-2.6.14-rc4-mm1/mm/memory.c linux-2.6.14-rc4-mm1-cachefs/mm/memory.c
--- linux-2.6.14-rc4-mm1/mm/memory.c	2005-10-17 14:26:44.000000000 +0100
+++ linux-2.6.14-rc4-mm1-cachefs/mm/memory.c	2005-10-20 18:53:04.000000000 +0100
@@ -1247,7 +1247,7 @@ static int do_wp_page(struct mm_struct *
 	struct page *old_page, *new_page;
 	unsigned long pfn = pte_pfn(orig_pte);
 	pte_t entry;
-	int ret = VM_FAULT_MINOR;
+	int reuse, ret = VM_FAULT_MINOR;
 
 	BUG_ON(vma->vm_flags & VM_RESERVED);
 
@@ -1261,19 +1261,53 @@ static int do_wp_page(struct mm_struct *
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
+			pte_unmap(page_table);
+			if (!PageReserved(old_page))
+				page_cache_get(old_page);
+			spin_unlock(&mm->page_table_lock);
+
+			if (vma->vm_ops->page_mkwrite(vma, old_page) < 0)
+				goto unwritable_page;
+
+			spin_lock(&mm->page_table_lock);
+			page_cache_release(old_page);
+
+			/*
+			 * Since we dropped the lock we need to revalidate
+			 * the PTE as someone else may have changed it.  If
+			 * they did, we just return, as we can count on the
+			 * MMU to tell us if they didn't also make it writable.
+			 */
+			page_table = pte_offset_map(pmd, address);
+			if (!pte_same(*page_table, orig_pte)) {
+				ret |= VM_FAULT_WRITE;
+				goto success;
+			}
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
+		goto success;
 	}
 
 	/*
@@ -1326,6 +1360,15 @@ unlock:
 oom:
 	page_cache_release(old_page);
 	return VM_FAULT_OOM;
+
+success:
+ 	pte_unmap(page_table);
+  	spin_unlock(&mm->page_table_lock);
+  	return VM_FAULT_MINOR | VM_FAULT_WRITE;
+
+unwritable_page:
+	page_cache_release(old_page);
+	return VM_FAULT_SIGBUS;
 }
 
 /*
@@ -1847,18 +1890,28 @@ retry:
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
+			    vma->vm_ops->page_mkwrite(vma, new_page) < 0)
+				return VM_FAULT_SIGBUS;
+		}
 	}
 
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
@@ -1945,7 +1998,7 @@ static int do_file_page(struct mm_struct
 		return VM_FAULT_OOM;
 	}
 	/* We can then assume vm->vm_ops && vma->vm_ops->populate */
-
+again:
 	pgoff = pte_to_pgoff(orig_pte);
 	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE,
 					vma->vm_page_prot, pgoff, 0);
@@ -1953,6 +2006,28 @@ static int do_file_page(struct mm_struct
 		return VM_FAULT_OOM;
 	if (err)
 		return VM_FAULT_SIGBUS;
+
+	/* For the get_user_pages force write case, we must make sure that
+	 * page_mkwrite is called by this invocation of handle_mm_fault.
+	 */
+	if (write_access && vma->vm_ops->page_mkwrite) {
+		spinlock_t *ptl;
+		int ret;
+
+		page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
+
+		orig_pte = *page_table;
+
+		if (!pte_present(orig_pte)) {
+			pte_unmap_unlock(page_table, ptl);
+			goto again;
+		}
+		ret = do_wp_page(mm, vma, address, page_table, pmd, ptl,
+				 orig_pte);
+		if (ret != VM_FAULT_MINOR)
+			return ret;
+	}
+
 	return VM_FAULT_MAJOR;
 }
 
diff -uNrp linux-2.6.14-rc4-mm1/mm/mmap.c linux-2.6.14-rc4-mm1-cachefs/mm/mmap.c
--- linux-2.6.14-rc4-mm1/mm/mmap.c	2005-10-17 14:26:44.000000000 +0100
+++ linux-2.6.14-rc4-mm1-cachefs/mm/mmap.c	2005-10-18 14:02:39.000000000 +0100
@@ -1058,7 +1058,8 @@ munmap_back:
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
 	vma->vm_flags = vm_flags;
-	vma->vm_page_prot = protection_map[vm_flags & 0x0f];
+	vma->vm_page_prot = protection_map[vm_flags &
+				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
@@ -1092,6 +1093,9 @@ munmap_back:
 		if (error)
 			goto free_vma;
 	}
+	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
+		vma->vm_page_prot = protection_map[vm_flags &
+					(VM_READ|VM_WRITE|VM_EXEC)];
 
 	/* We set VM_ACCOUNT in a shared mapping's vm_flags, to inform
 	 * shmem_zero_setup (perhaps called through /dev/zero's ->mmap)
@@ -1926,7 +1930,8 @@ unsigned long do_brk(unsigned long addr,
 	vma->vm_end = addr + len;
 	vma->vm_pgoff = pgoff;
 	vma->vm_flags = flags;
-	vma->vm_page_prot = protection_map[flags & 0x0f];
+	vma->vm_page_prot = protection_map[flags &
+				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 out:
 	mm->total_vm += len >> PAGE_SHIFT;
diff -uNrp linux-2.6.14-rc4-mm1/mm/mprotect.c linux-2.6.14-rc4-mm1-cachefs/mm/mprotect.c
--- linux-2.6.14-rc4-mm1/mm/mprotect.c	2005-10-17 14:26:44.000000000 +0100
+++ linux-2.6.14-rc4-mm1-cachefs/mm/mprotect.c	2005-10-18 14:02:39.000000000 +0100
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
@@ -168,6 +167,11 @@ mprotect_fixup(struct vm_area_struct *vm
 	}
 
 success:
+	mask = VM_READ|VM_WRITE|VM_EXEC|VM_SHARED;
+	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
+		mask &= ~VM_SHARED;
+	newprot = protection_map[newflags & mask];
+
 	/*
 	 * vm_flags and vm_page_prot are protected by the mmap_sem
 	 * held in write mode.
