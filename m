Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVCIWrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVCIWrN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVCIWpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:45:30 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:17284 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261652AbVCIWRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:17:01 -0500
Date: Wed, 9 Mar 2005 22:16:19 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] ptwalk: pud and pmd folded
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092215410.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 15/15] ptwalk: pud and pmd folded

Nick Piggin's patch to fold away most of the pud and pmd levels when not
required.  Adjusted to define minimal pud_addr_end (in the 4LEVEL_HACK
case too) and pmd_addr_end.  Responsible for half of the savings.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/asm-generic/4level-fixup.h  |    4 ++++
 include/asm-generic/pgtable-nopmd.h |    5 +++++
 include/asm-generic/pgtable-nopud.h |    5 +++++
 include/asm-generic/pgtable.h       |    4 ++++
 mm/memory.c                         |   34 ++++++++--------------------------
 5 files changed, 26 insertions(+), 26 deletions(-)

--- ptwalk14/include/asm-generic/4level-fixup.h	2005-03-02 07:39:19.000000000 +0000
+++ ptwalk15/include/asm-generic/4level-fixup.h	2005-03-09 01:39:43.000000000 +0000
@@ -2,6 +2,7 @@
 #define _4LEVEL_FIXUP_H
 
 #define __ARCH_HAS_4LEVEL_HACK
+#define __PAGETABLE_PUD_FOLDED
 
 #define PUD_SIZE			PGDIR_SIZE
 #define PUD_MASK			PGDIR_MASK
@@ -31,4 +32,7 @@
 #define pud_free(x)			do { } while (0)
 #define __pud_free_tlb(tlb, x)		do { } while (0)
 
+#undef  pud_addr_end
+#define pud_addr_end(addr, end)		(end)
+
 #endif
--- ptwalk14/include/asm-generic/pgtable-nopmd.h	2005-03-02 07:39:19.000000000 +0000
+++ ptwalk15/include/asm-generic/pgtable-nopmd.h	2005-03-09 01:39:43.000000000 +0000
@@ -5,6 +5,8 @@
 
 #include <asm-generic/pgtable-nopud.h>
 
+#define __PAGETABLE_PMD_FOLDED
+
 /*
  * Having the pmd type consist of a pud gets the size right, and allows
  * us to conceptually access the pud entry that this pmd is folded into
@@ -55,6 +57,9 @@ static inline pmd_t * pmd_offset(pud_t *
 #define pmd_free(x)				do { } while (0)
 #define __pmd_free_tlb(tlb, x)			do { } while (0)
 
+#undef  pmd_addr_end
+#define pmd_addr_end(addr, end)			(end)
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _PGTABLE_NOPMD_H */
--- ptwalk14/include/asm-generic/pgtable-nopud.h	2005-03-02 07:39:27.000000000 +0000
+++ ptwalk15/include/asm-generic/pgtable-nopud.h	2005-03-09 01:39:43.000000000 +0000
@@ -3,6 +3,8 @@
 
 #ifndef __ASSEMBLY__
 
+#define __PAGETABLE_PUD_FOLDED
+
 /*
  * Having the pud type consist of a pgd gets the size right, and allows
  * us to conceptually access the pgd entry that this pud is folded into
@@ -52,5 +54,8 @@ static inline pud_t * pud_offset(pgd_t *
 #define pud_free(x)				do { } while (0)
 #define __pud_free_tlb(tlb, x)			do { } while (0)
 
+#undef  pud_addr_end
+#define pud_addr_end(addr, end)			(end)
+
 #endif /* __ASSEMBLY__ */
 #endif /* _PGTABLE_NOPUD_H */
--- ptwalk14/include/asm-generic/pgtable.h	2005-03-09 01:36:01.000000000 +0000
+++ ptwalk15/include/asm-generic/pgtable.h	2005-03-09 01:39:43.000000000 +0000
@@ -146,15 +146,19 @@ static inline void ptep_set_wrprotect(st
 	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
 })
 
+#ifndef pud_addr_end
 #define pud_addr_end(addr, end)						\
 ({	unsigned long __boundary = ((addr) + PUD_SIZE) & PUD_MASK;	\
 	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
 })
+#endif
 
+#ifndef pmd_addr_end
 #define pmd_addr_end(addr, end)						\
 ({	unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;	\
 	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
 })
+#endif
 
 #ifndef __ASSEMBLY__
 /*
--- ptwalk14/mm/memory.c	2005-03-09 01:39:31.000000000 +0000
+++ ptwalk15/mm/memory.c	2005-03-09 01:39:43.000000000 +0000
@@ -1973,15 +1973,12 @@ int handle_mm_fault(struct mm_struct *mm
 	return VM_FAULT_OOM;
 }
 
-#ifndef __ARCH_HAS_4LEVEL_HACK
+#ifndef __PAGETABLE_PUD_FOLDED
 /*
  * Allocate page upper directory.
  *
  * We've already handled the fast-path in-line, and we own the
  * page table lock.
- *
- * On a two-level or three-level page table, this ends up actually being
- * entirely optimized away.
  */
 pud_t fastcall *__pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
@@ -2005,15 +2002,14 @@ pud_t fastcall *__pud_alloc(struct mm_st
  out:
 	return pud_offset(pgd, address);
 }
+#endif /* __PAGETABLE_PUD_FOLDED */
 
+#ifndef __PAGETABLE_PMD_FOLDED
 /*
  * Allocate page middle directory.
  *
  * We've already handled the fast-path in-line, and we own the
  * page table lock.
- *
- * On a two-level page table, this ends up actually being entirely
- * optimized away.
  */
 pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
@@ -2029,38 +2025,24 @@ pmd_t fastcall *__pmd_alloc(struct mm_st
 	 * Because we dropped the lock, we should re-check the
 	 * entry, as somebody else could have populated it..
 	 */
+#ifndef __ARCH_HAS_4LEVEL_HACK
 	if (pud_present(*pud)) {
 		pmd_free(new);
 		goto out;
 	}
 	pud_populate(mm, pud, new);
- out:
-	return pmd_offset(pud, address);
-}
 #else
-pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
-{
-	pmd_t *new;
-
-	spin_unlock(&mm->page_table_lock);
-	new = pmd_alloc_one(mm, address);
-	spin_lock(&mm->page_table_lock);
-	if (!new)
-		return NULL;
-
-	/*
-	 * Because we dropped the lock, we should re-check the
-	 * entry, as somebody else could have populated it..
-	 */
 	if (pgd_present(*pud)) {
 		pmd_free(new);
 		goto out;
 	}
 	pgd_populate(mm, pud, new);
-out:
+#endif /* __ARCH_HAS_4LEVEL_HACK */
+
+ out:
 	return pmd_offset(pud, address);
 }
-#endif
+#endif /* __PAGETABLE_PMD_FOLDED */
 
 int make_pages_present(unsigned long addr, unsigned long end)
 {
