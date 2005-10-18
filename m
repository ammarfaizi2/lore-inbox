Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVJRWkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVJRWkQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 18:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVJRWkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 18:40:16 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:19104 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932198AbVJRWkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 18:40:13 -0400
Subject: [PATCH 1/2] hugetlb: demand fault handler
From: Adam Litke <agl@us.ibm.com>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hugh@veritas.com,
       William Irwin <wli@holomorphy.com>,
       David Gibson <david@gibson.dropbear.id.au>,
       "ADAM G. LITKE [imap]" <agl@us.ibm.com>
In-Reply-To: <1129674980.8702.19.camel@localhost.localdomain>
References: <1129674980.8702.19.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Tue, 18 Oct 2005 17:39:56 -0500
Message-Id: <1129675197.8702.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 5 (Tue, 18 Oct 2005)
	Large update from Hugh Dickins to merge with his page_table_lock
	  scalability patches
	Use lock_page() to guard against truncation races
	Fault handler hierarchy changed to more closely resemble do_no_page()
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
 fs/hugetlbfs/inode.c    |    7 -
 include/linux/hugetlb.h |    2 
 mm/hugetlb.c            |  180 ++++++++++++++++++++++++++++--------------------
 mm/memory.c             |    2 
 4 files changed, 111 insertions(+), 80 deletions(-)
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
 
@@ -79,10 +78,8 @@ static int hugetlbfs_file_mmap(struct fi
 	if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
 		goto out;
 
-	ret = hugetlb_prefault(mapping, vma);
-	if (ret)
-		goto out;
-
+	ret = 0;
+	hugetlb_prefault_arch_hook(vma->vm_mm);
 	if (inode->i_size < len)
 		inode->i_size = len;
 out:
diff -upN reference/include/linux/hugetlb.h current/include/linux/hugetlb.h
--- reference/include/linux/hugetlb.h
+++ current/include/linux/hugetlb.h
@@ -24,6 +24,8 @@ int is_hugepage_mem_enough(size_t);
 unsigned long hugetlb_total_pages(void);
 struct page *alloc_huge_page(void);
 void free_huge_page(struct page *);
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long address, int write_access);
 
 extern unsigned long max_huge_pages;
 extern const unsigned long hugetlb_zero, hugetlb_infinity;
diff -upN reference/mm/hugetlb.c current/mm/hugetlb.c
--- reference/mm/hugetlb.c
+++ current/mm/hugetlb.c
@@ -320,10 +320,7 @@ void unmap_hugepage_range(struct vm_area
 
 	for (address = start; address < end; address += HPAGE_SIZE) {
 		ptep = huge_pte_offset(mm, address);
-		if (! ptep)
-			/* This can happen on truncate, or if an
-			 * mmap() is aborted due to an error before
-			 * the prefault */
+		if (!ptep)
 			continue;
 
 		pte = huge_ptep_get_and_clear(mm, address, ptep);
@@ -339,59 +336,92 @@ void unmap_hugepage_range(struct vm_area
 	flush_tlb_range(vma, start, end);
 }
 
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
+static struct page *find_lock_huge_page(struct address_space *mapping,
+			unsigned long idx)
 {
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
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
+	struct page *page;
+	int err;
+	struct inode *inode = mapping->host;
+	unsigned long size;
+
+retry:
+	page = find_lock_page(mapping, idx);
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
-		spin_lock(&mm->page_table_lock);
-		add_mm_counter(mm, file_rss, HPAGE_SIZE / PAGE_SIZE);
-		set_huge_pte_at(mm, addr, pte, make_huge_pte(vma, page));
-		spin_unlock(&mm->page_table_lock);
+	err = add_to_page_cache(page, mapping, idx, GFP_KERNEL);
+	if (err) {
+		put_page(page);
+		hugetlb_put_quota(mapping);
+		if (err == -EEXIST)
+			goto retry;
+		page = NULL;
 	}
 out:
+	return page;
+}
+
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long address, int write_access)
+{
+	int ret = VM_FAULT_SIGBUS;
+	unsigned long idx;
+	unsigned long size;
+	pte_t *pte;
+	struct page *page;
+	struct address_space *mapping;
+
+	pte = huge_pte_alloc(mm, address);
+	if (!pte)
+		goto out;
+
+	mapping = vma->vm_file->f_mapping;
+	idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
+		+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+
+	/*
+	 * Use page lock to guard against racing truncation
+	 * before we get page_table_lock.
+	 */
+	page = find_lock_huge_page(mapping, idx);
+	if (!page)
+		goto out;
+
+	spin_lock(&mm->page_table_lock);
+	size = i_size_read(mapping->host) >> HPAGE_SHIFT;
+	if (idx >= size)
+		goto backout;
+
+	ret = VM_FAULT_MINOR;
+	if (!pte_none(*pte))
+		goto backout;
+
+	add_mm_counter(mm, file_rss, HPAGE_SIZE / PAGE_SIZE);
+	set_huge_pte_at(mm, address, pte, make_huge_pte(vma, page));
+	spin_unlock(&mm->page_table_lock);
+	unlock_page(page);
+out:
 	return ret;
+
+backout:
+	spin_unlock(&mm->page_table_lock);
+	hugetlb_put_quota(mapping);
+	unlock_page(page);
+	put_page(page);
+	goto out;
 }
 
 int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -401,34 +431,36 @@ int follow_hugetlb_page(struct mm_struct
 	unsigned long vpfn, vaddr = *position;
 	int remainder = *length;
 
-	BUG_ON(!is_vm_hugetlb_page(vma));
-
 	vpfn = vaddr/PAGE_SIZE;
 	spin_lock(&mm->page_table_lock);
 	while (vaddr < vma->vm_end && remainder) {
+		pte_t *pte;
+		struct page *page;
 
-		if (pages) {
-			pte_t *pte;
-			struct page *page;
-
-			/* Some archs (sparc64, sh*) have multiple
-			 * pte_ts to each hugepage.  We have to make
-			 * sure we get the first, for the page
-			 * indexing below to work. */
-			pte = huge_pte_offset(mm, vaddr & HPAGE_MASK);
-
-			/* the hugetlb file might have been truncated */
-			if (!pte || pte_none(*pte)) {
-				remainder = 0;
-				if (!i)
-					i = -EFAULT;
-				break;
-			}
+		/*
+		 * Some archs (sparc64, sh*) have multiple pte_ts to
+		 * each hugepage.  We have to make * sure we get the
+		 * first, for the page indexing below to work.
+		 */
+		pte = huge_pte_offset(mm, vaddr & HPAGE_MASK);
+
+		if (!pte || pte_none(*pte)) {
+			int ret;
+
+			spin_unlock(&mm->page_table_lock);
+			ret = hugetlb_fault(mm, vma, vaddr, 0);
+			spin_lock(&mm->page_table_lock);
+			if (ret == VM_FAULT_MINOR)
+				continue;
+
+			remainder = 0;
+			if (!i)
+				i = -EFAULT;
+			break;
+		}
 
+		if (pages) {
 			page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
-
-			WARN_ON(!PageCompound(page));
-
 			get_page(page);
 			pages[i] = page;
 		}
diff -upN reference/mm/memory.c current/mm/memory.c
--- reference/mm/memory.c
+++ current/mm/memory.c
@@ -2027,7 +2027,7 @@ int __handle_mm_fault(struct mm_struct *
 	inc_page_state(pgfault);
 
 	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		return hugetlb_fault(mm, vma, address, write_access);
 
 	pgd = pgd_offset(mm, address);
 	pud = pud_alloc(mm, pgd, address);

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

