Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbVKGVjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbVKGVjG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbVKGVjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:39:05 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:12260 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964970AbVKGVjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:39:03 -0500
Subject: [RFC 1/2] Hugetlb fault fixes and reorg
From: Adam Litke <agl@us.ibm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
       hugh@veritas.com, rohit.seth@intel.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org
In-Reply-To: <1131397841.25133.90.camel@localhost.localdomain>
References: <1131397841.25133.90.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Mon, 07 Nov 2005 15:38:16 -0600
Message-Id: <1131399496.25133.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RFC] Cleanup / small fixes to hugetlb fault handling
(Patch originally from David Gibson <david@gibson.dropbear.id.au>)
Initial Post: Tue. 25 Oct 2005

On Thu, 2005-10-27 at 16:37 +1000, 'David Gibson' wrote:
> This patch makes some slight tweaks / cleanups to the fault handling
> path for huge pages in -mm.  My main motivation is to make it simpler
> to fit COW in, but along the way it addresses a few minor problems
> with the existing code:
> 
> - The check against i_size was duplicated: once in
>   find_lock_huge_page() and again in hugetlb_fault() after taking the
>   page_table_lock.  We only really need the locked one, so remove the
>   other.
> 
> - find_lock_huge_page() isn't a great name, since it does extra things
>   not analagous to find_lock_page().  Rename it
>   find_or_alloc_huge_page() which is closer to the mark.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Adam Litke <agl@us.ibm.com>

---
 hugetlb.c |   77 +++++++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 46 insertions(+), 31 deletions(-)
diff -upN reference/mm/hugetlb.c current/mm/hugetlb.c
--- reference/mm/hugetlb.c
+++ current/mm/hugetlb.c
@@ -339,30 +339,24 @@ void unmap_hugepage_range(struct vm_area
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
 
 	err = add_to_page_cache(page, mapping, idx, GFP_KERNEL);
@@ -373,50 +367,49 @@ retry:
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
@@ -424,7 +417,29 @@ backout:
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
+		return VM_FAULT_OOM;
+
+	entry = *ptep;
+
+	if (pte_none(entry))
+		return hugetlb_no_page(mm, vma, address, ptep);
+
+	/* we could get here if another thread instantiated the pte
+	 * before the test above */
+
+	return VM_FAULT_MINOR;
 }
 
 int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

