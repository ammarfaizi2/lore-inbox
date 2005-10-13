Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbVJMA4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbVJMA4c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVJMA4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:56:32 -0400
Received: from gold.veritas.com ([143.127.12.110]:45074 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964838AbVJMA4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:56:31 -0400
Date: Thu, 13 Oct 2005 01:55:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/21] mm: ptd_alloc inline and out
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130155130.4060@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 00:56:31.0182 (UTC) FILETIME=[F32A8EE0:01C5CF90]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems odd to me that, whereas pud_alloc and pmd_alloc test inline,
only calling out-of-line __pud_alloc __pmd_alloc if allocation needed,
pte_alloc_map and pte_alloc_kernel are entirely out-of-line.  Though it
does add a little to kernel size, change them to macros testing inline,
calling __pte_alloc or __pte_alloc_kernel to allocate out-of-line.
Mark none of them as fastcalls, leave that to CONFIG_REGPARM or not.

It also seems more natural for the out-of-line functions to leave the
offset calculation and map to the inline, which has to do it anyway for
the common case.  At least mremap move wants __pte_alloc without _map.

Macros rather than inline functions, certainly to avoid the header file
issues which arise from CONFIG_HIGHPTE needing kmap_types.h, but also in
case any architectures I haven't built would have other such problems.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/asm-generic/4level-fixup.h |   11 +---
 include/linux/mm.h                 |   38 +++++++--------
 mm/memory.c                        |   93 +++++++++++++++----------------------
 mm/mremap.c                        |    7 --
 4 files changed, 61 insertions(+), 88 deletions(-)

--- mm09/include/asm-generic/4level-fixup.h	2005-06-17 20:48:29.000000000 +0100
+++ mm10/include/asm-generic/4level-fixup.h	2005-10-11 23:56:11.000000000 +0100
@@ -10,14 +10,9 @@
 
 #define pud_t				pgd_t
 
-#define pmd_alloc(mm, pud, address)			\
-({	pmd_t *ret;					\
-	if (pgd_none(*pud))				\
- 		ret = __pmd_alloc(mm, pud, address);	\
- 	else						\
-		ret = pmd_offset(pud, address);		\
- 	ret;						\
-})
+#define pmd_alloc(mm, pud, address) \
+	((unlikely(pgd_none(*(pud))) && __pmd_alloc(mm, pud, address))? \
+ 		NULL: pmd_offset(pud, address))
 
 #define pud_alloc(mm, pgd, address)	(pgd)
 #define pud_offset(pgd, start)		(pgd)
--- mm09/include/linux/mm.h	2005-10-11 23:55:54.000000000 +0100
+++ mm10/include/linux/mm.h	2005-10-11 23:56:11.000000000 +0100
@@ -709,10 +709,6 @@ static inline void unmap_shared_mapping_
 }
 
 extern int vmtruncate(struct inode * inode, loff_t offset);
-extern pud_t *FASTCALL(__pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address));
-extern pmd_t *FASTCALL(__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address));
-extern pte_t *FASTCALL(pte_alloc_kernel(pmd_t *pmd, unsigned long address));
-extern pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, unsigned long pgoff, pgprot_t prot);
 extern int __handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
@@ -765,32 +761,36 @@ struct shrinker;
 extern struct shrinker *set_shrinker(int, shrinker_t);
 extern void remove_shrinker(struct shrinker *shrinker);
 
-/*
- * On a two-level or three-level page table, this ends up being trivial. Thus
- * the inlining and the symmetry break with pte_alloc_map() that does all
- * of this out-of-line.
- */
+int __pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address);
+int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address);
+int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address);
+int __pte_alloc_kernel(pmd_t *pmd, unsigned long address);
+
 /*
  * The following ifdef needed to get the 4level-fixup.h header to work.
  * Remove it when 4level-fixup.h has been removed.
  */
-#ifdef CONFIG_MMU
-#ifndef __ARCH_HAS_4LEVEL_HACK 
+#if defined(CONFIG_MMU) && !defined(__ARCH_HAS_4LEVEL_HACK)
 static inline pud_t *pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
-	if (pgd_none(*pgd))
-		return __pud_alloc(mm, pgd, address);
-	return pud_offset(pgd, address);
+	return (unlikely(pgd_none(*pgd)) && __pud_alloc(mm, pgd, address))?
+		NULL: pud_offset(pgd, address);
 }
 
 static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
-	if (pud_none(*pud))
-		return __pmd_alloc(mm, pud, address);
-	return pmd_offset(pud, address);
+	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
+		NULL: pmd_offset(pud, address);
 }
-#endif
-#endif /* CONFIG_MMU */
+#endif /* CONFIG_MMU && !__ARCH_HAS_4LEVEL_HACK */
+
+#define pte_alloc_map(mm, pmd, address)			\
+	((unlikely(!pmd_present(*(pmd))) && __pte_alloc(mm, pmd, address))? \
+		NULL: pte_offset_map(pmd, address))
+
+#define pte_alloc_kernel(pmd, address)			\
+	((unlikely(!pmd_present(*(pmd))) && __pte_alloc_kernel(pmd, address))? \
+		NULL: pte_offset_kernel(pmd, address))
 
 extern void free_area_init(unsigned long * zones_size);
 extern void free_area_init_node(int nid, pg_data_t *pgdat,
--- mm09/mm/memory.c	2005-10-11 23:55:54.000000000 +0100
+++ mm10/mm/memory.c	2005-10-11 23:56:11.000000000 +0100
@@ -280,50 +280,39 @@ void free_pgtables(struct mmu_gather **t
 	}
 }
 
-pte_t fastcall *pte_alloc_map(struct mm_struct *mm, pmd_t *pmd,
-				unsigned long address)
+int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
 {
-	if (!pmd_present(*pmd)) {
-		struct page *new;
+	struct page *new;
 
-		spin_unlock(&mm->page_table_lock);
-		new = pte_alloc_one(mm, address);
-		spin_lock(&mm->page_table_lock);
-		if (!new)
-			return NULL;
-		/*
-		 * Because we dropped the lock, we should re-check the
-		 * entry, as somebody else could have populated it..
-		 */
-		if (pmd_present(*pmd)) {
-			pte_free(new);
-			goto out;
-		}
+	spin_unlock(&mm->page_table_lock);
+	new = pte_alloc_one(mm, address);
+	spin_lock(&mm->page_table_lock);
+	if (!new)
+		return -ENOMEM;
+
+	if (pmd_present(*pmd))		/* Another has populated it */
+		pte_free(new);
+	else {
 		mm->nr_ptes++;
 		inc_page_state(nr_page_table_pages);
 		pmd_populate(mm, pmd, new);
 	}
-out:
-	return pte_offset_map(pmd, address);
+	return 0;
 }
 
-pte_t fastcall * pte_alloc_kernel(pmd_t *pmd, unsigned long address)
+int __pte_alloc_kernel(pmd_t *pmd, unsigned long address)
 {
-	if (!pmd_present(*pmd)) {
-		pte_t *new;
-
-		new = pte_alloc_one_kernel(&init_mm, address);
-		if (!new)
-			return NULL;
+	pte_t *new = pte_alloc_one_kernel(&init_mm, address);
+	if (!new)
+		return -ENOMEM;
 
-		spin_lock(&init_mm.page_table_lock);
-		if (pmd_present(*pmd))
-			pte_free_kernel(new);
-		else
-			pmd_populate_kernel(&init_mm, pmd, new);
-		spin_unlock(&init_mm.page_table_lock);
-	}
-	return pte_offset_kernel(pmd, address);
+	spin_lock(&init_mm.page_table_lock);
+	if (pmd_present(*pmd))		/* Another has populated it */
+		pte_free_kernel(new);
+	else
+		pmd_populate_kernel(&init_mm, pmd, new);
+	spin_unlock(&init_mm.page_table_lock);
+	return 0;
 }
 
 static inline void add_mm_rss(struct mm_struct *mm, int file_rss, int anon_rss)
@@ -2093,7 +2082,7 @@ int __handle_mm_fault(struct mm_struct *
  * Allocate page upper directory.
  * We've already handled the fast-path in-line.
  */
-pud_t fastcall *__pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
+int __pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
 	pud_t *new;
 
@@ -2103,19 +2092,17 @@ pud_t fastcall *__pud_alloc(struct mm_st
 	if (!new) {
 		if (mm != &init_mm)	/* Temporary bridging hack */
 			spin_lock(&mm->page_table_lock);
-		return NULL;
+		return -ENOMEM;
 	}
 
 	spin_lock(&mm->page_table_lock);
-	if (pgd_present(*pgd)) {
+	if (pgd_present(*pgd))		/* Another has populated it */
 		pud_free(new);
-		goto out;
-	}
-	pgd_populate(mm, pgd, new);
- out:
+	else
+		pgd_populate(mm, pgd, new);
 	if (mm == &init_mm)		/* Temporary bridging hack */
 		spin_unlock(&mm->page_table_lock);
-	return pud_offset(pgd, address);
+	return 0;
 }
 #endif /* __PAGETABLE_PUD_FOLDED */
 
@@ -2124,7 +2111,7 @@ pud_t fastcall *__pud_alloc(struct mm_st
  * Allocate page middle directory.
  * We've already handled the fast-path in-line.
  */
-pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
+int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
 	pmd_t *new;
 
@@ -2134,28 +2121,24 @@ pmd_t fastcall *__pmd_alloc(struct mm_st
 	if (!new) {
 		if (mm != &init_mm)	/* Temporary bridging hack */
 			spin_lock(&mm->page_table_lock);
-		return NULL;
+		return -ENOMEM;
 	}
 
 	spin_lock(&mm->page_table_lock);
 #ifndef __ARCH_HAS_4LEVEL_HACK
-	if (pud_present(*pud)) {
+	if (pud_present(*pud))		/* Another has populated it */
 		pmd_free(new);
-		goto out;
-	}
-	pud_populate(mm, pud, new);
+	else
+		pud_populate(mm, pud, new);
 #else
-	if (pgd_present(*pud)) {
+	if (pgd_present(*pud))		/* Another has populated it */
 		pmd_free(new);
-		goto out;
-	}
-	pgd_populate(mm, pud, new);
+	else
+		pgd_populate(mm, pud, new);
 #endif /* __ARCH_HAS_4LEVEL_HACK */
-
- out:
 	if (mm == &init_mm)		/* Temporary bridging hack */
 		spin_unlock(&mm->page_table_lock);
-	return pmd_offset(pud, address);
+	return 0;
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
--- mm09/mm/mremap.c	2005-10-11 23:54:33.000000000 +0100
+++ mm10/mm/mremap.c	2005-10-11 23:56:11.000000000 +0100
@@ -51,7 +51,6 @@ static pmd_t *alloc_new_pmd(struct mm_st
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd = NULL;
-	pte_t *pte;
 
 	/*
 	 * We do need page_table_lock: because allocators expect that.
@@ -66,12 +65,8 @@ static pmd_t *alloc_new_pmd(struct mm_st
 	if (!pmd)
 		goto out;
 
-	pte = pte_alloc_map(mm, pmd, addr);
-	if (!pte) {
+	if (!pmd_present(*pmd) && __pte_alloc(mm, pmd, addr))
 		pmd = NULL;
-		goto out;
-	}
-	pte_unmap(pte);
 out:
 	spin_unlock(&mm->page_table_lock);
 	return pmd;
