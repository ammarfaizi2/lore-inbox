Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbVCIWUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVCIWUI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVCIWSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:18:40 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:5106 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262116AbVCIWIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:08:54 -0500
Date: Wed, 9 Mar 2005 22:08:11 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/15] ptwalk: sync_page_range
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092207250.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert filemap_sync pagetable walkers to loops using p?d_addr_end; use
similar loop to split filemap_sync into chunks.  Merge filemap_sync_pte
into sync_pte_range, cut filemap_ off the longer names, vma arg first.

There is no error from filemap_sync, nor is any use made of the flags:
if it should do something else for MS_INVALIDATE, reinstate it when that
is implemented.  Remove the redundant flush_tlb_range from afterwards:
as its comment noted, each dirty pte has already been flushed.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/msync.c |  180 ++++++++++++++++++++++---------------------------------------
 1 files changed, 67 insertions(+), 113 deletions(-)

--- ptwalk2/mm/msync.c	2005-03-09 01:35:49.000000000 +0000
+++ ptwalk3/mm/msync.c	2005-03-09 01:36:14.000000000 +0000
@@ -21,155 +21,109 @@
  * Called with mm->page_table_lock held to protect against other
  * threads/the swapper from ripping pte's out from under us.
  */
-static int filemap_sync_pte(pte_t *ptep, struct vm_area_struct *vma,
-	unsigned long address, unsigned int flags)
-{
-	pte_t pte = *ptep;
-	unsigned long pfn = pte_pfn(pte);
-	struct page *page;
 
-	if (pte_present(pte) && pfn_valid(pfn)) {
-		page = pfn_to_page(pfn);
-		if (!PageReserved(page) &&
-		    (ptep_clear_flush_dirty(vma, address, ptep) ||
-		     page_test_and_clear_dirty(page)))
-			set_page_dirty(page);
-	}
-	return 0;
-}
-
-static int filemap_sync_pte_range(pmd_t * pmd,
-	unsigned long address, unsigned long end, 
-	struct vm_area_struct *vma, unsigned int flags)
+static void sync_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
+				unsigned long addr, unsigned long end)
 {
 	pte_t *pte;
-	int error;
 
 	if (pmd_none_or_clear_bad(pmd))
-		return 0;
-	pte = pte_offset_map(pmd, address);
-	if ((address & PMD_MASK) != (end & PMD_MASK))
-		end = (address & PMD_MASK) + PMD_SIZE;
-	error = 0;
+		return;
+	pte = pte_offset_map(pmd, addr);
 	do {
-		error |= filemap_sync_pte(pte, vma, address, flags);
-		address += PAGE_SIZE;
-		pte++;
-	} while (address && (address < end));
+		unsigned long pfn;
+		struct page *page;
 
-	pte_unmap(pte - 1);
+		if (!pte_present(*pte))
+			continue;
+		pfn = pte_pfn(*pte);
+		if (!pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
+		if (PageReserved(page))
+			continue;
 
-	return error;
+		if (ptep_clear_flush_dirty(vma, addr, pte) ||
+		    page_test_and_clear_dirty(page))
+			set_page_dirty(page);
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_unmap(pte - 1);
 }
 
-static inline int filemap_sync_pmd_range(pud_t * pud,
-	unsigned long address, unsigned long end, 
-	struct vm_area_struct *vma, unsigned int flags)
+static inline void sync_pmd_range(struct vm_area_struct *vma, pud_t *pud,
+				unsigned long addr, unsigned long end)
 {
-	pmd_t * pmd;
-	int error;
+	pmd_t *pmd;
+	unsigned long next;
 
 	if (pud_none_or_clear_bad(pud))
-		return 0;
-	pmd = pmd_offset(pud, address);
-	if ((address & PUD_MASK) != (end & PUD_MASK))
-		end = (address & PUD_MASK) + PUD_SIZE;
-	error = 0;
+		return;
+	pmd = pmd_offset(pud, addr);
 	do {
-		error |= filemap_sync_pte_range(pmd, address, end, vma, flags);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
-	return error;
+		next = pmd_addr_end(addr, end);
+		sync_pte_range(vma, pmd, addr, next);
+	} while (pmd++, addr = next, addr != end);
 }
 
-static inline int filemap_sync_pud_range(pgd_t *pgd,
-	unsigned long address, unsigned long end,
-	struct vm_area_struct *vma, unsigned int flags)
+static inline void sync_pud_range(struct vm_area_struct *vma, pgd_t *pgd,
+				unsigned long addr, unsigned long end)
 {
 	pud_t *pud;
-	int error;
+	unsigned long next;
 
 	if (pgd_none_or_clear_bad(pgd))
-		return 0;
-	pud = pud_offset(pgd, address);
-	if ((address & PGDIR_MASK) != (end & PGDIR_MASK))
-		end = (address & PGDIR_MASK) + PGDIR_SIZE;
-	error = 0;
+		return;
+	pud = pud_offset(pgd, addr);
 	do {
-		error |= filemap_sync_pmd_range(pud, address, end, vma, flags);
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
-	return error;
+		next = pud_addr_end(addr, end);
+		sync_pmd_range(vma, pud, addr, next);
+	} while (pud++, addr = next, addr != end);
 }
 
-static int __filemap_sync(struct vm_area_struct *vma, unsigned long address,
-			size_t size, unsigned int flags)
+static void sync_page_range(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
-	unsigned long end = address + size;
 	unsigned long next;
-	int i;
-	int error = 0;
-
-	/* Aquire the lock early; it may be possible to avoid dropping
-	 * and reaquiring it repeatedly.
-	 */
-	spin_lock(&vma->vm_mm->page_table_lock);
-
-	pgd = pgd_offset(vma->vm_mm, address);
-	flush_cache_range(vma, address, end);
 
 	/* For hugepages we can't go walking the page table normally,
 	 * but that's ok, hugetlbfs is memory based, so we don't need
 	 * to do anything more on an msync() */
 	if (is_vm_hugetlb_page(vma))
-		goto out;
-
-	if (address >= end)
-		BUG();
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= address || next > end)
-			next = end;
-		error |= filemap_sync_pud_range(pgd, address, next, vma, flags);
-		address = next;
-		pgd++;
-	}
-	/*
-	 * Why flush ? filemap_sync_pte already flushed the tlbs with the
-	 * dirty bits.
-	 */
-	flush_tlb_range(vma, end - size, end);
- out:
-	spin_unlock(&vma->vm_mm->page_table_lock);
+		return;
 
-	return error;
+	BUG_ON(addr >= end);
+	pgd = pgd_offset(mm, addr);
+	flush_cache_range(vma, addr, end);
+	spin_lock(&mm->page_table_lock);
+	do {
+		next = pgd_addr_end(addr, end);
+		sync_pud_range(vma, pgd, addr, next);
+	} while (pgd++, addr = next, addr != end);
+	spin_unlock(&mm->page_table_lock);
 }
 
 #ifdef CONFIG_PREEMPT
-static int filemap_sync(struct vm_area_struct *vma, unsigned long address,
-			size_t size, unsigned int flags)
+static void filemap_sync(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end)
 {
 	const size_t chunk = 64 * 1024;	/* bytes */
-	int error = 0;
-
-	while (size) {
-		size_t sz = min(size, chunk);
+	unsigned long next;
 
-		error |= __filemap_sync(vma, address, sz, flags);
+	do {
+		next = addr + chunk;
+		if (next > end || next < addr)
+			next = end;
+		sync_page_range(vma, addr, next);
 		cond_resched();
-		address += sz;
-		size -= sz;
-	}
-	return error;
+	} while (addr = next, addr != end);
 }
 #else
-static int filemap_sync(struct vm_area_struct *vma, unsigned long address,
-			size_t size, unsigned int flags)
+static void filemap_sync(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end)
 {
-	return __filemap_sync(vma, address, size, flags);
+	sync_page_range(vma, addr, end);
 }
 #endif
 
@@ -184,19 +138,19 @@ static int filemap_sync(struct vm_area_s
  * So my _not_ starting I/O in MS_ASYNC we provide complete flexibility to
  * applications.
  */
-static int msync_interval(struct vm_area_struct * vma,
-	unsigned long start, unsigned long end, int flags)
+static int msync_interval(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long end, int flags)
 {
 	int ret = 0;
-	struct file * file = vma->vm_file;
+	struct file *file = vma->vm_file;
 
 	if ((flags & MS_INVALIDATE) && (vma->vm_flags & VM_LOCKED))
 		return -EBUSY;
 
 	if (file && (vma->vm_flags & VM_SHARED)) {
-		ret = filemap_sync(vma, start, end-start, flags);
+		filemap_sync(vma, addr, end);
 
-		if (!ret && (flags & MS_SYNC)) {
+		if (flags & MS_SYNC) {
 			struct address_space *mapping = file->f_mapping;
 			int err;
 
@@ -221,7 +175,7 @@ static int msync_interval(struct vm_area
 asmlinkage long sys_msync(unsigned long start, size_t len, int flags)
 {
 	unsigned long end;
-	struct vm_area_struct * vma;
+	struct vm_area_struct *vma;
 	int unmapped_error, error = -EINVAL;
 
 	if (flags & MS_SYNC)
