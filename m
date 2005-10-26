Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbVJZDSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVJZDSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 23:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVJZDSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 23:18:07 -0400
Received: from ozlabs.org ([203.10.76.45]:479 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932499AbVJZDSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 23:18:06 -0400
Date: Wed, 26 Oct 2005 12:48:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Adam Litke <agl@us.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hugh@veritas.com,
       William Irwin <wli@holomorphy.com>
Subject: Re: RFC: Cleanup / small fixes to hugetlb fault handling
Message-ID: <20051026024831.GB17191@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Adam Litke <agl@us.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hugh@veritas.com,
	William Irwin <wli@holomorphy.com>
References: <20051026020055.GA17191@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051026020055.GA17191@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 12:00:55PM +1000, David Gibson wrote:
> Hi, Adam, Bill, Hugh,
> 
> Does this look like a reasonable patch to send to akpm for -mm.

Ahem.  Or rather this version, which actually compiles.

This patch makes some slight tweaks / cleanups to the fault handling
path for huge pages in -mm.  My main motivation is to make it simpler
to fit COW in, but along the way it addresses a few minor problems
with the existing code:

- The check against i_size was duplicated: once in
  find_lock_huge_page() and again in hugetlb_fault() after taking the
  page_table_lock.  We only really need the locked one, so remove the
  other.

- find_lock_huge_page() didn't, in fact, lock the page if it newly
  allocated one, rather than finding it in the page cache already.  As
  far as I can tell this is a bug, so the patch corrects it.

- find_lock_huge_page() isn't a great name, since it does extra things
  not analagous to find_lock_page().  Rename it
  find_or_alloc_huge_page() which is closer to the mark.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2005-10-26 11:18:39.000000000 +1000
+++ working-2.6/mm/hugetlb.c	2005-10-26 12:46:29.000000000 +1000
@@ -336,32 +336,28 @@
 	flush_tlb_range(vma, start, end);
 }
 
-static struct page *find_lock_huge_page(struct address_space *mapping,
-			unsigned long idx)
+static struct page *find_or_alloc_huge_page(struct address_space *mapping,
+					    unsigned long idx)
 {
 	struct page *page;
 	int err;
-	struct inode *inode = mapping->host;
-	unsigned long size;
 
 retry:
 	page = find_lock_page(mapping, idx);
 	if (page)
-		goto out;
-
-	/* Check to make sure the mapping hasn't been truncated */
-	size = i_size_read(inode) >> HPAGE_SHIFT;
-	if (idx >= size)
-		goto out;
+		return page;
 
 	if (hugetlb_get_quota(mapping))
-		goto out;
+		return NULL;
+
 	page = alloc_huge_page();
 	if (!page) {
 		hugetlb_put_quota(mapping);
-		goto out;
+		return NULL;
 	}
 
+	lock_page(page);
+
 	err = add_to_page_cache(page, mapping, idx, GFP_KERNEL);
 	if (err) {
 		put_page(page);
@@ -370,50 +366,49 @@
 			goto retry;
 		page = NULL;
 	}
-out:
+
 	return page;
 }
 
-int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
-			unsigned long address, int write_access)
+int hugetlb_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
+		    unsigned long address, pte_t *ptep)
 {
-	int ret = VM_FAULT_SIGBUS;
+	int ret;
 	unsigned long idx;
 	unsigned long size;
-	pte_t *pte;
 	struct page *page;
 	struct address_space *mapping;
 
-	pte = huge_pte_alloc(mm, address);
-	if (!pte)
-		goto out;
-
 	mapping = vma->vm_file->f_mapping;
 	idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
 		+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
 
-	/*
-	 * Use page lock to guard against racing truncation
-	 * before we get page_table_lock.
-	 */
-	page = find_lock_huge_page(mapping, idx);
+	/* This returns a locked page, which keeps us safe in the
+	 * event of a race with truncate() */
+	page = find_or_alloc_huge_page(mapping, idx);
 	if (!page)
-		goto out;
+		return VM_FAULT_SIGBUS;
 
 	spin_lock(&mm->page_table_lock);
+
+	ret = VM_FAULT_SIGBUS;
+
 	size = i_size_read(mapping->host) >> HPAGE_SHIFT;
 	if (idx >= size)
 		goto backout;
 
 	ret = VM_FAULT_MINOR;
-	if (!pte_none(*pte))
+
+	if (!pte_none(*ptep))
+		/* oops, someone instantiated this PTE before us */
 		goto backout;
 
 	add_mm_counter(mm, file_rss, HPAGE_SIZE / PAGE_SIZE);
-	set_huge_pte_at(mm, address, pte, make_huge_pte(vma, page));
+	set_huge_pte_at(mm, address, ptep, make_huge_pte(vma, page));
+
 	spin_unlock(&mm->page_table_lock);
 	unlock_page(page);
-out:
+
 	return ret;
 
 backout:
@@ -421,7 +416,30 @@
 	hugetlb_put_quota(mapping);
 	unlock_page(page);
 	put_page(page);
-	goto out;
+
+	return ret;
+}
+
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
+		  unsigned long address, int write_access)
+{
+	pte_t *ptep;
+	pte_t entry;
+
+	ptep = huge_pte_alloc(mm, address);
+	if (! ptep)
+		/* OOM */
+		return VM_FAULT_SIGBUS;
+
+	entry = *ptep;
+
+	if (pte_none(entry))
+		return hugetlb_no_page(mm, vma, address, ptep);
+
+	/* we could get here if another thread instantiated the pte
+	 * before the test above */
+
+	return VM_FAULT_SIGBUS;
 }
 
 int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
