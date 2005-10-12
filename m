Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbVJLGKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVJLGKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 02:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbVJLGKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 02:10:12 -0400
Received: from ozlabs.org ([203.10.76.45]:38362 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932467AbVJLGKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 02:10:10 -0400
Date: Wed, 12 Oct 2005 16:09:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Adam Litke <agl@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       ak@suse.de, hugh@veritas.com
Subject: Re: [PATCH 2/3] hugetlb: Demand fault handler
Message-ID: <20051012060934.GA14943@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Adam Litke <agl@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ak@suse.de,
	hugh@veritas.com
References: <1129055057.22182.8.camel@localhost.localdomain> <1129055559.22182.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129055559.22182.12.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 01:32:38PM -0500, Adam Litke wrote:
> Version 5 (Tue, 11 Oct 2005)
> 	Deal with hugetlbfs file truncation in find_get_huge_page()
> Version 4 (Mon, 03 Oct 2005)
> 	Make find_get_huge_page bale properly when add_to_page_cache fails
> 	  due to OOM conditions
> Version 3 (Thu, 08 Sep 2005)
>         Organized logic in hugetlb_pte_fault() by breaking out
>           find_get_page/alloc_huge_page logic into separate function
>         Removed a few more paranoid checks  ( Thanks       )
>         Fixed tlb flushing in a race case   ( Yanmin Zhang )
> 
> Version 2 (Wed, 17 Aug 2005)
>         Removed spurious WARN_ON()
>     Patches added earlier in the series (now in mainline):
>         Check for p?d_none() in arch/i386/mm/hugetlbpage.c:huge_pte_offset()
>         Move i386 stale pte check into huge_pte_alloc()

I'm not sure this does fully deal with truncation, I'm afraid - it
will deal with a truncation well before the fault, but not a
concurrent truncate().  We'll need the truncate_count/retry logic from
do_no_page, I think.  Andi/Hugh, can you confirm that's correct?

> Initial Post (Fri, 05 Aug 2005)
> 
> Below is a patch to implement demand faulting for huge pages.  The main
> motivation for changing from prefaulting to demand faulting is so that
> huge page memory areas can be allocated according to NUMA policy.
> 
> Thanks to consolidated hugetlb code, switching the behavior requires changing
> only one fault handler.  The bulk of the patch just moves the logic from 
> hugelb_prefault() to hugetlb_pte_fault() and find_get_huge_page().

While we're at it - it's a minor nit, but I find the distinction
between hugetlb_pte_fault() and hugetlb_fault() confusing.  A better
name for the former would be hugetlb_no_page(), in which case we
should probably also move the border between it and
hugetlb_find_get_page() to match the boundary between do_no_page() and
mapping->nopage.

How about this, for example:

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/fs/hugetlbfs/inode.c
===================================================================
--- working-2.6.orig/fs/hugetlbfs/inode.c	2005-10-12 14:28:08.000000000 +1000
+++ working-2.6/fs/hugetlbfs/inode.c	2005-10-12 14:40:54.000000000 +1000
@@ -48,7 +48,6 @@
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	struct address_space *mapping = inode->i_mapping;
 	loff_t len, vma_len;
 	int ret;
 
@@ -79,10 +78,7 @@
 	if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
 		goto out;
 
-	ret = hugetlb_prefault(mapping, vma);
-	if (ret)
-		goto out;
-
+	ret = 0;
 	if (inode->i_size < len)
 		inode->i_size = len;
 out:
Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2005-10-12 10:25:24.000000000 +1000
+++ working-2.6/include/linux/hugetlb.h	2005-10-12 14:28:18.000000000 +1000
@@ -25,6 +25,8 @@
 unsigned long hugetlb_total_pages(void);
 struct page *alloc_huge_page(void);
 void free_huge_page(struct page *);
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct * vma,
+			unsigned long address, int write_access);
 
 extern unsigned long max_huge_pages;
 extern const unsigned long hugetlb_zero, hugetlb_infinity;
Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2005-10-12 14:28:16.000000000 +1000
+++ working-2.6/mm/hugetlb.c	2005-10-12 16:00:12.000000000 +1000
@@ -312,9 +312,8 @@
 	for (address = start; address < end; address += HPAGE_SIZE) {
 		ptep = huge_pte_offset(mm, address);
 		if (! ptep)
-			/* This can happen on truncate, or if an
-			 * mmap() is aborted due to an error before
-			 * the prefault */
+			/* This can happen on truncate, or for pages
+			 * not yet faulted in */
 			continue;
 
 		pte = huge_ptep_get_and_clear(mm, address, ptep);
@@ -338,57 +337,128 @@
 	spin_unlock(&mm->page_table_lock);
 }
 
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
+static struct page *hugetlbfs_nopage(struct vm_area_struct *vma,
+				     unsigned long address)
 {
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
+	int err;
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct inode *inode = mapping->host;
+	unsigned long pgoff, size;
+	struct page *page = NULL;
+
+	pgoff = ((address - vma->vm_start) >> HPAGE_SHIFT)
+		+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+
+	/* Check to make sure the mapping hasn't been truncated */
+	size = i_size_read(inode) >> HPAGE_SHIFT;
+	if (pgoff >= size)
+		return NULL;
+
+ retry:
+	page = find_get_page(mapping, pgoff);
+	if (page)
+		/* Another thread won the race */
+		return page;
+
+	if (hugetlb_get_quota(mapping) != 0)
+		goto out;
+
+	page = alloc_huge_page();
+	if (!page) {
+		hugetlb_put_quota(mapping);
+		goto out;
+	}
+
+	/*
+	 * It would be better to use GFP_KERNEL here but then we'd need to
+	 * drop the page_table_lock and handle several race conditions.
+	 */
+	err = add_to_page_cache(page, mapping, pgoff, GFP_ATOMIC);
+	if (err) {
+		put_page(page);
+		page = NULL;
+		hugetlb_put_quota(mapping);
+		if (err == -ENOMEM)
+			goto out;
+		else
+			goto retry;
+	}
+	unlock_page(page);
+out:
+	return page;
+
+}
+
+static int hugetlb_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
+			   unsigned long address, pte_t *pte,
+			   int write_access)
+{
+	struct page *new_page;
+	struct address_space *mapping;
+	unsigned int sequence;
 
-	WARN_ON(!is_vm_hugetlb_page(vma));
 	BUG_ON(vma->vm_start & ~HPAGE_MASK);
 	BUG_ON(vma->vm_end & ~HPAGE_MASK);
+	BUG_ON(!vma->vm_file);
+	BUG_ON(!pte);
+	BUG_ON(!pte_none(*pte));
+
+	spin_unlock(&mm->page_table_lock);
 
-	hugetlb_prefault_arch_hook(mm);
+	mapping = vma->vm_file->f_mapping;
+	sequence = mapping->truncate_count;
+	smp_rmb(); /* serializes i_size against truncate_count */
+
+ retry:
+	new_page = hugetlbfs_nopage(vma, address & HPAGE_MASK);
 
 	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
 
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
+	if (!new_page)
+		return VM_FAULT_SIGBUS;
+
+	/*
+	 * Someone could have truncated this page.
+	 */
+	if (unlikely(sequence != mapping->truncate_count)) {
+		spin_unlock(&mm->page_table_lock);
+		page_cache_release(new_page);
+		cond_resched();
+		sequence = mapping->truncate_count;
+		smp_rmb();
+		goto retry;
+	}
 
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
-		page = find_get_page(mapping, idx);
-		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			page = alloc_huge_page();
-			if (!page) {
-				hugetlb_put_quota(mapping);
-				ret = -ENOMEM;
-				goto out;
-			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			if (! ret) {
-				unlock_page(page);
-			} else {
-				hugetlb_put_quota(mapping);
-				free_huge_page(page);
-				goto out;
-			}
-		}
+	if (pte_none(*pte)) {
+		set_huge_pte_at(mm, address, pte,
+				make_huge_pte(vma, new_page));
 		add_mm_counter(mm, file_rss, HPAGE_SIZE / PAGE_SIZE);
-		set_huge_pte_at(mm, addr, pte, make_huge_pte(vma, page));
+	} else {
+		/* One of our sibling threads was faster, back out. */
+		page_cache_release(new_page);
+	}
+	return VM_FAULT_MINOR;
+}
+
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long address, int write_access)
+{
+	pte_t *ptep;
+	int rc = VM_FAULT_MINOR;
+
+	spin_lock(&mm->page_table_lock);
+
+	ptep = huge_pte_alloc(mm, address);
+	if (!ptep) {
+		rc = VM_FAULT_SIGBUS;
+		goto out;
 	}
+	if (pte_none(*ptep))
+		rc = hugetlb_no_page(mm, vma, address, ptep, write_access);
+
+	if (rc == VM_FAULT_MINOR)
+		flush_tlb_page(vma, address);
 out:
 	spin_unlock(&mm->page_table_lock);
-	return ret;
+	return rc;
 }
Index: working-2.6/mm/memory.c
===================================================================
--- working-2.6.orig/mm/memory.c	2005-10-12 14:28:16.000000000 +1000
+++ working-2.6/mm/memory.c	2005-10-12 14:28:18.000000000 +1000
@@ -2040,7 +2040,7 @@
 	inc_page_state(pgfault);
 
 	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		return hugetlb_fault(mm, vma, address, write_access);
 
 	/*
 	 * We need the page table lock to synchronize with kswapd


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
