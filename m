Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVGGF4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVGGF4P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 01:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVGGF4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 01:56:15 -0400
Received: from ozlabs.org ([203.10.76.45]:2233 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261151AbVGGF4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 01:56:13 -0400
Date: Thu, 7 Jul 2005 15:55:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: RFC: Hugepage COW
Message-ID: <20050707055554.GC11246@localhost.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the hugepage code has been consolidated across the
architectures, it becomes much easier to implement copy-on-write.
Hugepage COW is of limited utility of itself, however, it is
essentially a prerequisite for any of a number of methods of allowing
userland programs to automatically use hugepages without code changes
e.g. hugepage malloc() libraries, implicit hugepage mmap(), hugepage
ELF segments.  For certain applications (particularly enormous HPC
FORTRAN programs), these can result in a large performance
improvement.

Thoughts?  Flames?

This patch implements copy-on-write for hugepages, thus allowing
MAP_PRIVATE|MAP_WRITE mappings of hugetlbfs.  Because the pool of
hugepages is limited, a write to a MAP_PRIVATE hugepage region may
result in a SIGBUS, if a new hugepage cannot be allocated.  This patch
is currently broken on sparc64, sh and sh64 (anything with
ARCH_HAS_SETCLEAR_HUGE_PTE) - that will need to be fixed, obviously.

Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2005-06-23 10:10:30.000000000 +1000
+++ working-2.6/mm/hugetlb.c	2005-06-23 11:35:22.000000000 +1000
@@ -253,11 +253,12 @@
 	.nopage = hugetlb_nopage,
 };
 
-static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page)
+static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
+			   int writable)
 {
 	pte_t entry;
 
-	if (vma->vm_flags & VM_WRITE) {
+	if (writable) {
 		entry =
 		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 	} else {
@@ -276,6 +277,9 @@
 	struct page *ptepage;
 	unsigned long addr = vma->vm_start;
 	unsigned long end = vma->vm_end;
+	int cow;
+
+	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 
 	while (addr < end) {
 		dst_pte = huge_pte_alloc(dst, addr);
@@ -283,6 +287,10 @@
 			goto nomem;
 		src_pte = huge_pte_offset(src, addr);
 		BUG_ON(!src_pte || pte_none(*src_pte)); /* prefaulted */
+
+		if (cow)
+			huge_ptep_set_wrprotect(src, addr, src_pte);
+
 		entry = *src_pte;
 		ptepage = pte_page(entry);
 		get_page(ptepage);
@@ -334,6 +342,7 @@
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
 	int ret = 0;
+	int writable;
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
 	BUG_ON(vma->vm_start & ~HPAGE_MASK);
@@ -342,6 +351,7 @@
 	hugetlb_prefault_arch_hook(mm);
 
 	spin_lock(&mm->page_table_lock);
+
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		unsigned long idx;
 		pte_t *pte = huge_pte_alloc(mm, addr);
@@ -369,17 +379,35 @@
 				ret = -ENOMEM;
 				goto out;
 			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			if (! ret) {
+
+			/* This is a new page, all full of zeroes.  If
+			 * we're MAP_SHARED, the page needs to go into
+			 * the page cache.  If it's MAP_PRIVATE it
+			 * might as well be made "anonymous" now or
+			 * we'll just have to copy it on the first
+			 * write. */
+			if (vma->vm_flags & VM_SHARED) {
+				ret = add_to_page_cache(page, mapping, idx,
+							GFP_ATOMIC);
+				if (ret) {
+					hugetlb_put_quota(mapping);
+					free_huge_page(page);
+					goto out;
+				}
+
 				unlock_page(page);
-			} else {
-				hugetlb_put_quota(mapping);
-				free_huge_page(page);
-				goto out;
 			}
+
+			writable = vma->vm_flags & VM_WRITE;
+		} else {
+			/* Existing page in page cache.  Can only
+			 * allow writes if mapping is both writable
+			 * and shared */
+			writable = (vma->vm_flags & VM_SHARED)
+				&& (vma->vm_flags & VM_WRITE);
 		}
 		add_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);
-		set_huge_pte_at(mm, addr, pte, make_huge_pte(vma, page));
+		set_huge_pte_at(mm, addr, pte, make_huge_pte(vma, page, writable));
 	}
 out:
 	spin_unlock(&mm->page_table_lock);
@@ -433,3 +461,91 @@
 
 	return i;
 }
+
+static int hugepage_cow(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long address, pte_t *ptep, pte_t pte)
+{
+	struct page *old_page, *new_page;
+	int i;
+
+	old_page = pte_page(*ptep);
+
+	/* If no-one else is actually using this page, avoid the copy
+	 * and just make the page writable */
+	if (!TestSetPageLocked(old_page)) {
+		int avoidcopy = (page_count(old_page) == 1);
+		unlock_page(old_page);
+		if (avoidcopy) {
+			set_huge_ptep_writable(vma, address, ptep);
+			spin_unlock(&mm->page_table_lock);
+			return VM_FAULT_MINOR;
+		}
+	}
+
+	page_cache_get(old_page);
+
+	spin_unlock(&mm->page_table_lock);
+
+	new_page = alloc_huge_page();
+
+	if (! new_page) {
+		page_cache_release(old_page);
+
+		/* Logically this is OOM, not a SIGBUS, but an OOM
+		 * could cause the kernel to go killing other
+		 * processes which won't help the hugepage situation
+		 * at all (?) */
+		return VM_FAULT_SIGBUS;
+	}
+
+	for (i = 0; i < HPAGE_SIZE/PAGE_SIZE; i++)
+		copy_user_highpage(new_page + i, old_page + i,
+				   address + i*PAGE_SIZE);
+
+	spin_lock(&mm->page_table_lock);
+
+	ptep = huge_pte_offset(mm, address & HPAGE_MASK);
+	if (pte_same(*ptep, pte)) {
+		/* Break COW */
+		set_huge_pte_at(mm, address, ptep,
+				make_huge_pte(vma, new_page, 1));
+
+		/* Make the old page be freed below */
+		new_page = old_page;
+	}
+	page_cache_release(new_page);
+	page_cache_release(old_page);
+	spin_unlock(&mm->page_table_lock);
+	return VM_FAULT_MINOR;
+}
+
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
+		  unsigned long address, int write_access)
+{
+	pte_t *ptep;
+	int rc = VM_FAULT_SIGBUS;
+
+	spin_lock(&mm->page_table_lock);
+
+	ptep = huge_pte_offset(mm, address & HPAGE_MASK);
+
+	if ( (! ptep) || pte_none(*ptep))
+		goto fail;
+
+	rc = VM_FAULT_MINOR;
+
+	if (! (write_access && !pte_write(*ptep))) {
+		printk(KERN_WARNING "Unexpected hugepte fault (wr=%d hugepte=%08lx\n",
+		       write_access, pte_val(*ptep));
+		goto fail;
+	}
+
+	/* The only faults we should actually get are COWs */
+	/* this drops the page_table_lock */
+	return hugepage_cow(mm, vma, address, ptep, *ptep);
+
+ fail:
+	spin_unlock(&mm->page_table_lock);
+
+	return rc;
+}
Index: working-2.6/mm/memory.c
===================================================================
--- working-2.6.orig/mm/memory.c	2005-06-23 10:10:30.000000000 +1000
+++ working-2.6/mm/memory.c	2005-06-23 11:28:53.000000000 +1000
@@ -2019,7 +2019,7 @@
 	inc_page_state(pgfault);
 
 	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		return hugetlb_fault(mm, vma, address, write_access);
 
 	/*
 	 * We need the page table lock to synchronize with kswapd
Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2005-06-23 10:10:30.000000000 +1000
+++ working-2.6/include/linux/hugetlb.h	2005-06-23 11:32:20.000000000 +1000
@@ -25,6 +25,8 @@
 unsigned long hugetlb_total_pages(void);
 struct page *alloc_huge_page(void);
 void free_huge_page(struct page *);
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct * vma,
+		  unsigned long address, int write_access);
 
 extern unsigned long max_huge_pages;
 extern const unsigned long hugetlb_zero, hugetlb_infinity;
@@ -57,11 +59,26 @@
 #ifndef ARCH_HAS_SETCLEAR_HUGE_PTE
 #define set_huge_pte_at(mm, addr, ptep, pte)	set_pte_at(mm, addr, ptep, pte)
 #define huge_ptep_get_and_clear(mm, addr, ptep) ptep_get_and_clear(mm, addr, ptep)
+#define huge_ptep_set_wrprotect(mm, addr, ptep) ptep_set_wrprotect(mm, addr, ptep)
+static inline void set_huge_ptep_writable(struct vm_area_struct *vma,
+					  unsigned long address,
+					  pte_t *ptep)
+{
+	pte_t entry;
+
+	entry = pte_mkwrite(pte_mkdirty(*ptep));
+	ptep_set_access_flags(vma, address, ptep, entry, 1);
+	update_mmu_cache(vma, address, entry);
+}
 #else
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte);
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep);
+void huge_ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
+			     pte_t *ptep);
+void set_huge_ptep_writable(struct vm_struct *vm, unsigned long address,
+			    pte_t *ptep);
 #endif
 
 #ifndef ARCH_HAS_HUGETLB_PREFAULT_HOOK
Index: working-2.6/fs/hugetlbfs/inode.c
===================================================================
--- working-2.6.orig/fs/hugetlbfs/inode.c	2005-06-23 10:10:30.000000000 +1000
+++ working-2.6/fs/hugetlbfs/inode.c	2005-06-23 11:28:54.000000000 +1000
@@ -52,9 +52,6 @@
 	loff_t len, vma_len;
 	int ret;
 
-	if ((vma->vm_flags & (VM_MAYSHARE | VM_WRITE)) == VM_WRITE)
-		return -EINVAL;
-
 	if (vma->vm_pgoff & (HPAGE_SIZE / PAGE_SIZE - 1))
 		return -EINVAL;
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
