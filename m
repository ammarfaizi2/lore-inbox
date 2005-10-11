Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVJKScq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVJKScq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 14:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVJKScq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 14:32:46 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:45273 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932268AbVJKScp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 14:32:45 -0400
Subject: [PATCH 2/3] hugetlb: Demand fault handler
From: Adam Litke <agl@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       David Gibson <david@gibson.dropbear.id.au>, ak@suse.de,
       hugh@veritas.com
In-Reply-To: <1129055057.22182.8.camel@localhost.localdomain>
References: <1129055057.22182.8.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Tue, 11 Oct 2005 13:32:38 -0500
Message-Id: <1129055559.22182.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 5 (Tue, 11 Oct 2005)
	Deal with hugetlbfs file truncation in find_get_huge_page()
Version 4 (Mon, 03 Oct 2005)
	Make find_get_huge_page bale properly when add_to_page_cache fails
	  due to OOM conditions
Version 3 (Thu, 08 Sep 2005)
        Organized logic in hugetlb_pte_fault() by breaking out
          find_get_page/alloc_huge_page logic into separate function
        Removed a few more paranoid checks  ( Thanks       )
        Fixed tlb flushing in a race case   ( Yanmin Zhang )

Version 2 (Wed, 17 Aug 2005)
        Removed spurious WARN_ON()
    Patches added earlier in the series (now in mainline):
        Check for p?d_none() in arch/i386/mm/hugetlbpage.c:huge_pte_offset()
        Move i386 stale pte check into huge_pte_alloc()

Initial Post (Fri, 05 Aug 2005)

Below is a patch to implement demand faulting for huge pages.  The main
motivation for changing from prefaulting to demand faulting is so that
huge page memory areas can be allocated according to NUMA policy.

Thanks to consolidated hugetlb code, switching the behavior requires changing
only one fault handler.  The bulk of the patch just moves the logic from 
hugelb_prefault() to hugetlb_pte_fault() and find_get_huge_page().

Signed-off-by: Adam Litke <agl@us.ibm.com>
---
 fs/hugetlbfs/inode.c    |    6 --
 include/linux/hugetlb.h |    2 
 mm/hugetlb.c            |  139 ++++++++++++++++++++++++++++++++----------------
 mm/memory.c             |    2 
 4 files changed, 98 insertions(+), 51 deletions(-)
diff -upN reference/fs/hugetlbfs/inode.c current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c
+++ current/fs/hugetlbfs/inode.c
@@ -48,7 +48,6 @@ int sysctl_hugetlb_shm_group;
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	struct address_space *mapping = inode->i_mapping;
 	loff_t len, vma_len;
 	int ret;
 
@@ -79,10 +78,7 @@ static int hugetlbfs_file_mmap(struct fi
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
diff -upN reference/include/linux/hugetlb.h current/include/linux/hugetlb.h
--- reference/include/linux/hugetlb.h
+++ current/include/linux/hugetlb.h
@@ -25,6 +25,8 @@ int is_hugepage_mem_enough(size_t);
 unsigned long hugetlb_total_pages(void);
 struct page *alloc_huge_page(void);
 void free_huge_page(struct page *);
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct * vma,
+			unsigned long address, int write_access);
 
 extern unsigned long max_huge_pages;
 extern const unsigned long hugetlb_zero, hugetlb_infinity;
diff -upN reference/mm/hugetlb.c current/mm/hugetlb.c
--- reference/mm/hugetlb.c
+++ current/mm/hugetlb.c
@@ -312,9 +312,8 @@ void unmap_hugepage_range(struct vm_area
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
@@ -338,57 +337,107 @@ void zap_hugepage_range(struct vm_area_s
 	spin_unlock(&mm->page_table_lock);
 }
 
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
+static struct page *find_get_huge_page(struct address_space *mapping,
+			unsigned long idx)
 {
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
+	struct page *page = NULL;
+	int rc;
+	struct inode *inode = mapping->host;
+	unsigned long size;
+
+retry:
+	page = find_get_page(mapping, idx);
+	if (page)
+		goto out;
+
+	/* Check to make sure the mapping hasn't been truncated */
+	size = i_size_read(inode) >> HPAGE_SHIFT;
+	if (idx >= size)
+		goto out;
+	
+	if (hugetlb_get_quota(mapping))
+		goto out;
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
+	rc = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
+	if (rc) {
+		put_page(page);
+		page = NULL;
+		hugetlb_put_quota(mapping);
+		if (rc == -ENOMEM)
+			goto out;
+		else
+			goto retry;
+	}
+	unlock_page(page);
+out:
+	return page;
+}
+
+static int hugetlb_pte_fault(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long address, int write_access)
+{
+	int ret = VM_FAULT_MINOR;
+	unsigned long idx;
+	pte_t *pte;
+	struct page *page;
+	struct address_space *mapping;
 
-	WARN_ON(!is_vm_hugetlb_page(vma));
 	BUG_ON(vma->vm_start & ~HPAGE_MASK);
 	BUG_ON(vma->vm_end & ~HPAGE_MASK);
+	BUG_ON(!vma->vm_file);
 
-	hugetlb_prefault_arch_hook(mm);
+	pte = huge_pte_offset(mm, address);
+	if (!pte) {
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
+	if (!pte_none(*pte))
+		goto out;
 
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
+	mapping = vma->vm_file->f_mapping;
+	idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
+		+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+
+	page = find_get_huge_page(mapping, idx);
+	if (!page) {
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
 
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
+	add_mm_counter(mm, file_rss, HPAGE_SIZE / PAGE_SIZE);
+	set_huge_pte_at(mm, address, pte, make_huge_pte(vma, page));
+out:
+	return ret;
+}
 
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
-		add_mm_counter(mm, file_rss, HPAGE_SIZE / PAGE_SIZE);
-		set_huge_pte_at(mm, addr, pte, make_huge_pte(vma, page));
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
+		rc = hugetlb_pte_fault(mm, vma, address, write_access);
+	
+	if (rc == VM_FAULT_MINOR)
+		flush_tlb_page(vma, address);
 out:
 	spin_unlock(&mm->page_table_lock);
-	return ret;
+	return rc;
 }
diff -upN reference/mm/memory.c current/mm/memory.c
--- reference/mm/memory.c
+++ current/mm/memory.c
@@ -2040,7 +2040,7 @@ int __handle_mm_fault(struct mm_struct *
 	inc_page_state(pgfault);
 
 	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		return hugetlb_fault(mm, vma, address, write_access);
 
 	/*
 	 * We need the page table lock to synchronize with kswapd

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

