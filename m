Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbVIHVUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbVIHVUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 17:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbVIHVUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 17:20:55 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:27873 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964998AbVIHVUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 17:20:54 -0400
Subject: Re: [PATCH 2/3 htlb-fault] Demand faulting for hugetlb
From: Adam Litke <agl@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: agl@us.ibm.com
In-Reply-To: <1126214145.28895.13.camel@localhost.localdomain>
References: <1126214145.28895.13.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Thu, 08 Sep 2005 16:20:34 -0500
Message-Id: <1126214434.28895.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 3 (Thu, 08 Aug 2005)
	Organized logic in hugetlb_pte_fault() by breaking out
	  find_get_page/alloc_huge_page logic into separate function
	Removed a few more paranoid checks <
	Fixed tlb flushing in a race case  < (thanks Yanmin Zhang)

Version 2 (Wed, 17 Aug 2005)
        Removed spurious WARN_ON()
    Patches added earlier in the series:
        Check for p?d_none() in arch/i386/mm/hugetlbpage.c:huge_pte_offset()
	Move i386 stale pte check into huge_pte_alloc()

Initial Post (Fri, 05 Aug 2005)

Below is a patch to implement demand faulting for huge pages.  The main
motivation for changing from prefaulting to demand faulting is so that
huge page memory areas can be allocated according to NUMA policy.

Thanks to consolidated hugetlb code, switching the behavior requires changing
only one fault handler.  The bulk of the patch just moves the logic from 
hugelb_prefault() to hugetlb_pte_fault().

Diffed against 2.6.13-git6

Signed-off-by: Adam Litke <agl@us.ibm.com>
---
 fs/hugetlbfs/inode.c    |    6 -
 include/linux/hugetlb.h |    2 
 mm/hugetlb.c            |  154 +++++++++++++++++++++++++++++-------------------
 mm/memory.c             |    2 
 4 files changed, 98 insertions(+), 66 deletions(-)
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
@@ -274,21 +274,22 @@ int copy_hugetlb_page_range(struct mm_st
 {
 	pte_t *src_pte, *dst_pte, entry;
 	struct page *ptepage;
-	unsigned long addr = vma->vm_start;
+	unsigned long addr;
 	unsigned long end = vma->vm_end;
 
-	while (addr < end) {
+	for (addr = vma->vm_start; addr < end; addr += HPAGE_SIZE) {
+		src_pte = huge_pte_offset(src, addr);
+		if (!src_pte || pte_none(*src_pte))
+			continue;
+		
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
 			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
-		BUG_ON(!src_pte || pte_none(*src_pte)); /* prefaulted */
 		entry = *src_pte;
 		ptepage = pte_page(entry);
 		get_page(ptepage);
 		add_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
 		set_huge_pte_at(dst, addr, dst_pte, entry);
-		addr += HPAGE_SIZE;
 	}
 	return 0;
 
@@ -338,61 +339,6 @@ void zap_hugepage_range(struct vm_area_s
 	spin_unlock(&mm->page_table_lock);
 }
 
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-	BUG_ON(vma->vm_start & ~HPAGE_MASK);
-	BUG_ON(vma->vm_end & ~HPAGE_MASK);
-
-	hugetlb_prefault_arch_hook(mm);
-
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
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
-		add_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);
-		set_huge_pte_at(mm, addr, pte, make_huge_pte(vma, page));
-	}
-out:
-	spin_unlock(&mm->page_table_lock);
-	return ret;
-}
-
 int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct page **pages, struct vm_area_struct **vmas,
 			unsigned long *position, int *length, int i)
@@ -440,3 +386,91 @@ int follow_hugetlb_page(struct mm_struct
 
 	return i;
 }
+
+static struct page *find_get_huge_page(struct address_space *mapping,
+			unsigned long idx)
+{
+	struct page *page = NULL;
+
+retry:
+	page = find_get_page(mapping, idx);
+	if (page)
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
+	if (add_to_page_cache(page, mapping, idx, GFP_ATOMIC)) {
+		put_page(page);
+		hugetlb_put_quota(mapping);
+		goto retry;
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
+
+	BUG_ON(vma->vm_start & ~HPAGE_MASK);
+	BUG_ON(vma->vm_end & ~HPAGE_MASK);
+	BUG_ON(!vma->vm_file);
+
+	pte = huge_pte_offset(mm, address);
+	if (!pte) {
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
+	if (!pte_none(*pte))
+		goto out;
+
+	mapping = vma->vm_file->f_mapping;
+	idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
+		+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+
+	page = find_get_huge_page(mapping, idx);
+	if (!page) {
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
+
+	add_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);
+	set_huge_pte_at(mm, address, pte, make_huge_pte(vma, page));
+out:
+	return ret;
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
+	}
+	if (pte_none(*ptep))
+		rc = hugetlb_pte_fault(mm, vma, address, write_access);
+out:
+	if (rc == VM_FAULT_MINOR)
+		flush_tlb_page(vma, address);
+
+	spin_unlock(&mm->page_table_lock);
+	return rc;
+}
diff -upN reference/mm/memory.c current/mm/memory.c
--- reference/mm/memory.c
+++ current/mm/memory.c
@@ -2041,7 +2041,7 @@ int __handle_mm_fault(struct mm_struct *
 	inc_page_state(pgfault);
 
 	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		return hugetlb_fault(mm, vma, address, write_access);
 
 	/*
 	 * We need the page table lock to synchronize with kswapd

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

