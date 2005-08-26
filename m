Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbVHZRDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbVHZRDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbVHZRCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:02:53 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:38037 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965127AbVHZRCp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:02:45 -0400
Subject: [patch 17/18] remap_file_pages linear nonuniform support: (1) try_to_unmap_one fix
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:54:03 +0200
Message-Id: <20050826165403.E8860254866@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Since we probably will not support linear nonuniform VMAs, this will not
probably be needed. However I'm sending it just in case.

Fix try_to_unmap_one for linear VM_NONUNIFORM vma's.

When unmapping linear but non uniform VMA's in try_to_unmap_one, we must
encode the prots in the PTE.

However, we don't use the generic save_nonlinear_pte() function as it allows
for nonlinear offsets, on which we instead BUG() in this code path, by using
save_nonuniform_pte().

I've not added any TLB flush because PTE's have already been cleared and
flushed in both cases, and (I assume from existing practice and common sense,
but I don't trust CPU architects on having the latter ;-) ) TLB won't need to
know about changes in the "software" part of absent PTEs.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/linux/pagemap.h |   11 +++++++++++
 linux-2.6.git-paolo/mm/rmap.c               |    3 +++
 2 files changed, 14 insertions(+)

diff -puN include/linux/pagemap.h~rfp-linear-nonuniform-1 include/linux/pagemap.h
--- linux-2.6.git/include/linux/pagemap.h~rfp-linear-nonuniform-1	2005-08-25 12:46:20.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/pagemap.h	2005-08-25 12:46:20.000000000 +0200
@@ -180,6 +180,17 @@ static inline void save_nonlinear_pte(pt
 		set_pte_at(mm, addr, ptep, pgoff_prot_to_pte(page->index, pgprot));
 }
 
+/* For linear but nonuniform VMA's*/
+static inline void save_nonuniform_pte(pte_t pte, pte_t * ptep, struct
+		vm_area_struct *vma, struct mm_struct *mm, struct page* page,
+		unsigned long addr)
+{
+	pgprot_t pgprot = pte_to_pgprot(pte);
+	BUG_ON(linear_page_index(vma, addr) != page->index);
+	if (pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot))
+		set_pte_at(mm, addr, ptep, pgoff_prot_to_pte(page->index, pgprot));
+}
+
 extern void FASTCALL(__lock_page(struct page *page));
 extern void FASTCALL(unlock_page(struct page *page));
 
diff -puN mm/rmap.c~rfp-linear-nonuniform-1 mm/rmap.c
--- linux-2.6.git/mm/rmap.c~rfp-linear-nonuniform-1	2005-08-25 12:46:20.000000000 +0200
+++ linux-2.6.git-paolo/mm/rmap.c	2005-08-25 12:46:20.000000000 +0200
@@ -543,6 +543,9 @@ static int try_to_unmap_one(struct page 
 	flush_cache_page(vma, address, page_to_pfn(page));
 	pteval = ptep_clear_flush(vma, address, pte);
 
+	/* If nonlinear, store the file page offset in the pte. */
+	save_nonuniform_pte(pteval, pte, vma, mm, page, address);
+
 	/* Move the dirty bit to the physical page now the pte is gone. */
 	if (pte_dirty(pteval))
 		set_page_dirty(page);
_
