Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbVHZRB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVHZRB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbVHZRB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:01:56 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:28309 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965103AbVHZRBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:01:50 -0400
Subject: [patch 02/18] remap_file_pages protection support: handle nonuniform VMAs
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:52:57 +0200
Message-Id: <20050826165258.2E3AC156D1B@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Handle the possible existance of VM_NONUNIFORM vmas, without actually creating
them.

* Replace old uses of pgoff_to_pte with pgoff_prot_to_pte.
* Introduce the flag, use it to read permissions from the PTE rather than from
  the VMA flags.
* Replace the linear_page_index() check with save_nonlinear_pte(), which
  encapsulates the check.

Below there is a long explaination of why I've added VM_NONUNIFORM, rather
than simply overload VM_NONLINEAR.

However, this patch assumes that VM_NONUNIFORM vmas are also marked as
nonlinear. Otherwise other changes are needed too.

*** remap_file_pages protection support: add VM_NONUNIFORM to fix existing usage of mprotect()

Distinguish between "normal" VMA and VMA with non-uniform protection, by
adding the VM_NONUNIFORM flag. This is needed for various reasons:

* notify the arch fault handlers that they must not check VMA protection for
  giving SIGSEGV 
* fixing regression of mprotect() on !VM_NONUNIFORM mappings (see below)
* (in next patches) giving a sensible behaviour to mprotect on VM_NONUNIFORM
  mappings
* (TODO?) avoid regression in max file offset with r_f_p() for older mappings;
  we could use either the old offset encoding or the new offset-prot encoding
  depending on this flag.
  It's trivial to do, just I don't know whether existing apps will overflow
  the new limits. They go down from 2Tb to 1Tb on i386 and 512G on PPC, and
  from 256G to 128G on S390/31 bits. Give me a call in case.

In fact, without this flag, we'd have indeed a regression with
remap_file_pages VS mprotect.

mprotect alters the VMA prots and walks each present PTE, ignoring installed
ones; their saved prots will be restored on faults, ignoring VMA ones and
losing the mprotect() on them. So, we must restore VMA prots when the VMA is
uniform, as we used to do.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/linux/mm.h      |    7 +++++++
 linux-2.6.git-paolo/include/linux/pagemap.h |   21 +++++++++++++++++++++
 linux-2.6.git-paolo/mm/fremap.c             |    8 ++++----
 linux-2.6.git-paolo/mm/memory.c             |   14 ++++++++------
 linux-2.6.git-paolo/mm/rmap.c               |    3 +--
 5 files changed, 41 insertions(+), 12 deletions(-)

diff -puN include/linux/mm.h~rfp-add-VM_NONUNIF include/linux/mm.h
--- linux-2.6.git/include/linux/mm.h~rfp-add-VM_NONUNIF	2005-08-24 13:27:38.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/mm.h	2005-08-24 13:27:39.000000000 +0200
@@ -160,7 +160,14 @@ extern unsigned int kobjsize(const void 
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
+
+#ifndef CONFIG_MMU
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
+#else
+#define VM_NONUNIFORM	0x01000000	/* The VM individual pages have
+					   different protections
+					   (remap_file_pages)*/
+#endif
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
diff -puN include/linux/pagemap.h~rfp-add-VM_NONUNIF include/linux/pagemap.h
--- linux-2.6.git/include/linux/pagemap.h~rfp-add-VM_NONUNIF	2005-08-24 13:27:38.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/pagemap.h	2005-08-24 13:27:39.000000000 +0200
@@ -159,6 +159,27 @@ static inline pgoff_t linear_page_index(
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
+static inline void save_nonlinear_pte(pte_t pte, pte_t * ptep, struct
+		vm_area_struct *vma, struct mm_struct *mm, struct page* page,
+		unsigned long addr)
+{
+	pgprot_t pgprot = pte_to_pgprot(pte);
+	if (linear_page_index(vma, addr) != page->index || 
+		pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot))
+		set_pte_at(mm, addr, ptep, pgoff_prot_to_pte(page->index, pgprot));
+}
+
 extern void FASTCALL(__lock_page(struct page *page));
 extern void FASTCALL(unlock_page(struct page *page));
 
diff -puN mm/fremap.c~rfp-add-VM_NONUNIF mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-add-VM_NONUNIF	2005-08-24 13:27:38.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-24 13:27:39.000000000 +0200
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
diff -puN mm/memory.c~rfp-add-VM_NONUNIF mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-add-VM_NONUNIF	2005-08-24 13:27:39.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-24 13:27:39.000000000 +0200
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
+				save_nonlinear_pte(ptent, pte,
+						details->nonlinear_vma,
+						tlb->mm, page, addr);
+			}
 			if (pte_dirty(ptent))
 				set_page_dirty(page);
 			if (PageAnon(page))
@@ -1937,6 +1937,7 @@ static int do_file_page(struct mm_struct
 	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd)
 {
 	unsigned long pgoff;
+	pgprot_t pgprot;
 	int err;
 
 	BUG_ON(!vma->vm_ops || !vma->vm_ops->nopage);
@@ -1951,11 +1952,12 @@ static int do_file_page(struct mm_struct
 	}
 
 	pgoff = pte_to_pgoff(*pte);
+	pgprot = vma->vm_flags & VM_NONUNIFORM ? pte_to_pgprot(*pte): vma->vm_page_prot;
 
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
 
-	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE, vma->vm_page_prot, pgoff, 0);
+	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE, pgprot, pgoff, 0);
 	if (err == -ENOMEM)
 		return VM_FAULT_OOM;
 	if (err)
diff -puN mm/rmap.c~rfp-add-VM_NONUNIF mm/rmap.c
--- linux-2.6.git/mm/rmap.c~rfp-add-VM_NONUNIF	2005-08-24 13:27:39.000000000 +0200
+++ linux-2.6.git-paolo/mm/rmap.c	2005-08-24 13:27:39.000000000 +0200
@@ -660,8 +660,7 @@ static void try_to_unmap_cluster(unsigne
 		pteval = ptep_clear_flush(vma, address, pte);
 
 		/* If nonlinear, store the file page offset in the pte. */
-		if (page->index != linear_page_index(vma, address))
-			set_pte_at(mm, address, pte, pgoff_to_pte(page->index));
+		save_nonlinear_pte(pteval, pte, vma, mm, page, address);
 
 		/* Move the dirty bit to the physical page now the pte is gone. */
 		if (pte_dirty(pteval))
_
