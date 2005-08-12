Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVHLRzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVHLRzM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVHLRy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:54:56 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:36566 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1750770AbVHLRyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:54:16 -0400
Subject: [patch 12/39] remap_file_pages protection support: enhance syscall interface and swapout code
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 19:31:59 +0200
Message-Id: <20050812173200.2EAC724E7DC@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ingo Molnar <mingo@elte.hu>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This is the "main" patch for the syscall code, containing the core of what was
sent by Ingo Molnar, variously reworked.

Differently from his patch, I've *not* added a new syscall, choosing to add a
new flag (MAP_NOINHERIT) which the application must specify to get the new
behavior (prot != 0 is accepted and prot == 0 means PROT_NONE).

The changes to the page fault handler have been separated, even because that
has required considerable amount of effort.

Handle the possibility that remap_file_pages changes protections in 
various places.

* Enable the 'prot' parameter for shared-writable mappings (the ones
  which are the primary target for remap_file_pages), without breaking up the
  vma
* Use pte_file PTE's also when protections don't match, not only when the
  offset doesn't match; and add set_nonlinear_pte() for this testing
* Save the current protection too when clearing a nonlinear PTE, by
  replacing pgoff_to_pte() uses with pgoff_prot_to_pte().
* Use the supplied protections on restore and on populate (partially
  uncomplete, fixed in subsequent patches)

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/linux/pagemap.h |   19 ++++++++++
 linux-2.6.git-paolo/mm/fremap.c             |   50 +++++++++++++++++-----------
 linux-2.6.git-paolo/mm/memory.c             |   14 ++++---
 linux-2.6.git-paolo/mm/rmap.c               |    3 -
 4 files changed, 60 insertions(+), 26 deletions(-)

diff -puN include/linux/pagemap.h~rfp-enhance-syscall-and-swapout-code include/linux/pagemap.h
--- linux-2.6.git/include/linux/pagemap.h~rfp-enhance-syscall-and-swapout-code	2005-08-11 22:59:47.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/pagemap.h	2005-08-11 22:59:47.000000000 +0200
@@ -159,6 +159,25 @@ static inline pgoff_t linear_page_index(
 	return pgoff >> (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 }
 
+/***
+ * Checks if the PTE is nonlinear, and if yes sets it.
+ * @vma: the VMA in which @addr is; we don't check if it's VM_NONLINEAR, just
+ * if this PTE is nonlinear.
+ * @addr: the addr which @pte refers to.
+ * @pte: the old PTE value (to read its protections.
+ * @ptep: the PTE pointer (for setting it).
+ * @mm: passed to set_pte_at.
+ * @page: the page which was installed (to read its ->index, i.e. the old
+ * offset inside the file.
+ */
+static inline void set_nonlinear_pte(pte_t pte, pte_t * ptep, struct vm_area_struct *vma, struct mm_struct *mm, struct page* page, unsigned long addr)
+{
+	pgprot_t pgprot = pte_to_pgprot(pte);
+	if(linear_page_index(vma, addr) != page->index || 
+		pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot))
+		set_pte_at(mm, addr, ptep, pgoff_prot_to_pte(page->index, pgprot));
+}
+
 extern void FASTCALL(__lock_page(struct page *page));
 extern void FASTCALL(unlock_page(struct page *page));
 
diff -puN mm/fremap.c~rfp-enhance-syscall-and-swapout-code mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-enhance-syscall-and-swapout-code	2005-08-11 22:59:47.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-11 23:01:14.000000000 +0200
@@ -54,7 +54,7 @@ static inline void zap_pte(struct mm_str
  * previously existing mapping.
  */
 int install_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long addr, struct page *page, pgprot_t prot)
+		unsigned long addr, struct page *page, pgprot_t pgprot)
 {
 	struct inode *inode;
 	pgoff_t size;
@@ -94,7 +94,7 @@ int install_page(struct mm_struct *mm, s
 
 	inc_mm_counter(mm,rss);
 	flush_icache_page(vma, page);
-	set_pte_at(mm, addr, pte, mk_pte(page, prot));
+	set_pte_at(mm, addr, pte, mk_pte(page, pgprot));
 	page_add_file_rmap(page);
 	pte_val = *pte;
 	pte_unmap(pte);
@@ -113,7 +113,7 @@ EXPORT_SYMBOL(install_page);
  * previously existing mapping.
  */
 int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long pgoff, pgprot_t prot)
+		unsigned long addr, unsigned long pgoff, pgprot_t pgprot)
 {
 	int err = -ENOMEM;
 	pte_t *pte;
@@ -139,7 +139,7 @@ int install_file_pte(struct mm_struct *m
 
 	zap_pte(mm, vma, addr, pte);
 
-	set_pte_at(mm, addr, pte, pgoff_to_pte(pgoff));
+	set_pte_at(mm, addr, pte, pgoff_prot_to_pte(pgoff, pgprot));
 	pte_val = *pte;
 	pte_unmap(pte);
 	update_mmu_cache(vma, addr, pte_val);
@@ -157,31 +157,28 @@ err_unlock:
  *                        file within an existing vma.
  * @start: start of the remapped virtual memory range
  * @size: size of the remapped virtual memory range
- * @prot: new protection bits of the range
+ * @prot: new protection bits of the range, must be 0 if not using MAP_NOINHERIT
  * @pgoff: to be mapped page of the backing store file
- * @flags: 0 or MAP_NONBLOCKED - the later will cause no IO.
+ * @flags: bits MAP_NOINHERIT or MAP_NONBLOCKED - the later will cause no IO.
  *
  * this syscall works purely via pagetables, so it's the most efficient
  * way to map the same (large) file into a given virtual window. Unlike
  * mmap()/mremap() it does not create any new vmas. The new mappings are
  * also safe across swapout.
- *
- * NOTE: the 'prot' parameter right now is ignored, and the vma's default
- * protection is used. Arbitrary protections might be implemented in the
- * future.
  */
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
-	unsigned long __prot, unsigned long pgoff, unsigned long flags)
+	unsigned long prot, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
+	pgprot_t pgprot;
 	struct address_space *mapping;
 	unsigned long end = start + size;
 	struct vm_area_struct *vma;
 	int err = -EINVAL;
 	int has_write_lock = 0;
 
-	if (__prot)
-		return err;
+	if (prot && !(flags & MAP_NOINHERIT))
+		goto out;
 	/*
 	 * Sanitize the syscall parameters:
 	 */
@@ -200,7 +197,7 @@ asmlinkage long sys_remap_file_pages(uns
 
 	/* We need down_write() to change vma->vm_flags. */
 	down_read(&mm->mmap_sem);
- retry:
+retry:
 	vma = find_vma(mm, start);
 
 	/*
@@ -210,7 +207,22 @@ asmlinkage long sys_remap_file_pages(uns
 	 * swapout cursor in a VM_NONLINEAR vma (unless VM_RESERVED
 	 * or VM_LOCKED, but VM_LOCKED could be revoked later on).
 	 */
-	if (vma && (vma->vm_flags & VM_SHARED) &&
+	if (!vma)
+		goto out_unlock;
+
+	if (flags & MAP_NOINHERIT) {
+		err = -EPERM;
+		if (((prot & PROT_READ) && !(vma->vm_flags & VM_MAYREAD)))
+			goto out_unlock;
+		if (((prot & PROT_WRITE) && !(vma->vm_flags & VM_MAYWRITE)))
+			goto out_unlock;
+		if (((prot & PROT_EXEC) && !(vma->vm_flags & VM_MAYEXEC)))
+			goto out_unlock;
+		pgprot = protection_map[calc_vm_prot_bits(prot) | VM_SHARED];
+	} else 
+		pgprot = vma->vm_page_prot;
+
+	if ((vma->vm_flags & VM_SHARED) &&
 		(!vma->vm_private_data ||
 			(vma->vm_flags & (VM_NONLINEAR|VM_RESERVED))) &&
 		vma->vm_ops && vma->vm_ops->populate &&
@@ -236,9 +248,8 @@ asmlinkage long sys_remap_file_pages(uns
 			spin_unlock(&mapping->i_mmap_lock);
 		}
 
-		err = vma->vm_ops->populate(vma, start, size,
-					    vma->vm_page_prot,
-					    pgoff, flags & MAP_NONBLOCK);
+		err = vma->vm_ops->populate(vma, start, size, pgprot, pgoff,
+				flags & MAP_NONBLOCK);
 
 		/*
 		 * We can't clear VM_NONLINEAR because we'd have to do
@@ -246,11 +257,14 @@ asmlinkage long sys_remap_file_pages(uns
 		 * downgrading the lock.  (Locks can't be upgraded).
 		 */
 	}
+
+out_unlock:
 	if (likely(!has_write_lock))
 		up_read(&mm->mmap_sem);
 	else
 		up_write(&mm->mmap_sem);
 
+out:
 	return err;
 }
 
diff -puN mm/memory.c~rfp-enhance-syscall-and-swapout-code mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-enhance-syscall-and-swapout-code	2005-08-11 22:59:47.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-11 22:59:47.000000000 +0200
@@ -555,11 +555,11 @@ static void zap_pte_range(struct mmu_gat
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			if (unlikely(!page))
 				continue;
-			if (unlikely(details) && details->nonlinear_vma
-			    && linear_page_index(details->nonlinear_vma,
-						addr) != page->index)
-				set_pte_at(tlb->mm, addr, pte,
-					   pgoff_to_pte(page->index));
+			if (unlikely(details) && details->nonlinear_vma) {
+				set_nonlinear_pte(ptent, pte,
+						details->nonlinear_vma,
+						tlb->mm, page, addr);
+			}
 			if (pte_dirty(ptent))
 				set_page_dirty(page);
 			if (PageAnon(page))
@@ -1926,6 +1926,7 @@ static int do_file_page(struct mm_struct
 	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd)
 {
 	unsigned long pgoff;
+	pgprot_t pgprot;
 	int err;
 
 	BUG_ON(!vma->vm_ops || !vma->vm_ops->nopage);
@@ -1940,11 +1941,12 @@ static int do_file_page(struct mm_struct
 	}
 
 	pgoff = pte_to_pgoff(*pte);
+	pgprot = pte_to_pgprot(*pte);
 
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
 
-	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE, vma->vm_page_prot, pgoff, 0);
+	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE, pgprot, pgoff, 0);
 	if (err == -ENOMEM)
 		return VM_FAULT_OOM;
 	if (err)
diff -puN mm/rmap.c~rfp-enhance-syscall-and-swapout-code mm/rmap.c
--- linux-2.6.git/mm/rmap.c~rfp-enhance-syscall-and-swapout-code	2005-08-11 22:59:47.000000000 +0200
+++ linux-2.6.git-paolo/mm/rmap.c	2005-08-11 22:59:47.000000000 +0200
@@ -660,8 +660,7 @@ static void try_to_unmap_cluster(unsigne
 		pteval = ptep_clear_flush(vma, address, pte);
 
 		/* If nonlinear, store the file page offset in the pte. */
-		if (page->index != linear_page_index(vma, address))
-			set_pte_at(mm, address, pte, pgoff_to_pte(page->index));
+		set_nonlinear_pte(pteval, pte, vma, mm, page, address);
 
 		/* Move the dirty bit to the physical page now the pte is gone. */
 		if (pte_dirty(pteval))
_
