Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbVH2U0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbVH2U0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbVH2U0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:26:52 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:41998 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751217AbVH2UZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:25:50 -0400
Message-Id: <200508292007.j7TK7FsA029949@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 8/9] UML - Merge duplicated page table code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Aug 2005 16:07:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a lot of code which is duplicated between the 2 and 3 level
implementation, with the only difference that the 3-level implementation is a
bit more generalized (instead of accessing directly pte_t.pte, it uses the
appropriate access macros).

So this code is joined together.

As obvious, a "core code nice cleanup" is not a "stability-friendly patch" so
usual care applies.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

---

 linux-2.6.git-paolo/include/asm-um/pgtable-2level.h |   27 -----------
 linux-2.6.git-paolo/include/asm-um/pgtable-3level.h |   36 ---------------
 linux-2.6.git-paolo/include/asm-um/pgtable.h        |   46 ++++++++++++++++++++
 3 files changed, 46 insertions(+), 63 deletions(-)

diff -puN include/asm-um/pgtable-2level.h~uml-join-page-bits-handling include/asm-um/pgtable-2level.h
--- linux-2.6.git/include/asm-um/pgtable-2level.h~uml-join-page-bits-handling	2005-07-24 00:49:30.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable-2level.h	2005-07-24 00:49:30.000000000 +0200
@@ -35,35 +35,8 @@
 static inline int pgd_newpage(pgd_t pgd)	{ return 0; }
 static inline void pgd_mkuptodate(pgd_t pgd)	{ }
 
-#define pte_present(x)	(pte_val(x) & (_PAGE_PRESENT | _PAGE_PROTNONE))
-
-static inline pte_t pte_mknewprot(pte_t pte)
-{
- 	pte_val(pte) |= _PAGE_NEWPROT;
-	return(pte);
-}
-
-static inline pte_t pte_mknewpage(pte_t pte)
-{
-	pte_val(pte) |= _PAGE_NEWPAGE;
-	return(pte);
-}
-
-static inline void set_pte(pte_t *pteptr, pte_t pteval)
-{
-	/* If it's a swap entry, it needs to be marked _PAGE_NEWPAGE so
-	 * fix_range knows to unmap it.  _PAGE_NEWPROT is specific to
-	 * mapped pages.
-	 */
-	*pteptr = pte_mknewpage(pteval);
-	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
-}
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
-
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 
-#define pte_page(x) pfn_to_page(pte_pfn(x))
-#define pte_none(x) !(pte_val(x) & ~_PAGE_NEWPAGE)
 #define pte_pfn(x) phys_to_pfn(pte_val(x))
 #define pfn_pte(pfn, prot) __pte(pfn_to_phys(pfn) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot) __pmd(pfn_to_phys(pfn) | pgprot_val(prot))
diff -puN include/asm-um/pgtable-3level.h~uml-join-page-bits-handling include/asm-um/pgtable-3level.h
--- linux-2.6.git/include/asm-um/pgtable-3level.h~uml-join-page-bits-handling	2005-07-24 00:49:30.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable-3level.h	2005-07-24 00:49:30.000000000 +0200
@@ -57,35 +57,6 @@ static inline int pgd_newpage(pgd_t pgd)
 
 static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEWPAGE; }
 
-
-#define pte_present(x)	pte_get_bits(x, (_PAGE_PRESENT | _PAGE_PROTNONE))
-
-static inline pte_t pte_mknewprot(pte_t pte)
-{
-        pte_set_bits(pte, _PAGE_NEWPROT);
-	return(pte);
-}
-
-static inline pte_t pte_mknewpage(pte_t pte)
-{
-	pte_set_bits(pte, _PAGE_NEWPAGE);
-	return(pte);
-}
-
-static inline void set_pte(pte_t *pteptr, pte_t pteval)
-{
-	pte_copy(*pteptr, pteval);
-
-	/* If it's a swap entry, it needs to be marked _PAGE_NEWPAGE so
-	 * fix_range knows to unmap it.  _PAGE_NEWPROT is specific to
-	 * mapped pages.
-	 */
-
-	*pteptr = pte_mknewpage(*pteptr);
-	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
-}
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
-
 #define set_pmd(pmdptr, pmdval) set_64bit((phys_t *) (pmdptr), pmd_val(pmdval))
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
@@ -113,13 +84,6 @@ static inline void pud_clear (pud_t * pu
 #define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
 			pmd_index(address))
 
-#define pte_page(x) pfn_to_page(pte_pfn(x))
-
-static inline int pte_none(pte_t pte)
-{
-	return pte_is_zero(pte);
-}
-
 static inline unsigned long pte_pfn(pte_t pte)
 {
 	return phys_to_pfn(pte_val(pte));
diff -puN include/asm-um/pgtable.h~uml-join-page-bits-handling include/asm-um/pgtable.h
--- linux-2.6.git/include/asm-um/pgtable.h~uml-join-page-bits-handling	2005-07-24 00:49:30.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable.h	2005-07-24 06:11:58.000000000 +0200
@@ -151,10 +151,24 @@ extern unsigned long pg0[1024];
 
 #define pmd_page(pmd) phys_to_page(pmd_val(pmd) & PAGE_MASK)
 
+#define pte_page(x) pfn_to_page(pte_pfn(x))
 #define pte_address(x) (__va(pte_val(x) & PAGE_MASK))
 #define mk_phys(a, r) ((a) + (((unsigned long) r) << REGION_SHIFT))
 #define phys_addr(p) ((p) & ~REGION_MASK)
 
+#define pte_present(x)	pte_get_bits(x, (_PAGE_PRESENT | _PAGE_PROTNONE))
+
+/*
+ * =================================
+ * Flags checking section.
+ * =================================
+ */
+
+static inline int pte_none(pte_t pte)
+{
+	return pte_is_zero(pte);
+}
+
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
@@ -210,6 +224,18 @@ static inline int pte_newprot(pte_t pte)
 	return(pte_present(pte) && (pte_get_bits(pte, _PAGE_NEWPROT)));
 }
 
+/*
+ * =================================
+ * Flags setting section.
+ * =================================
+ */
+
+static inline pte_t pte_mknewprot(pte_t pte)
+{
+	pte_set_bits(pte, _PAGE_NEWPROT);
+	return(pte);
+}
+
 static inline pte_t pte_rdprotect(pte_t pte)
 { 
 	pte_clear_bits(pte, _PAGE_USER);
@@ -278,6 +304,26 @@ static inline pte_t pte_mkuptodate(pte_t
 	return(pte); 
 }
 
+static inline pte_t pte_mknewpage(pte_t pte)
+{
+	pte_set_bits(pte, _PAGE_NEWPAGE);
+	return(pte);
+}
+
+static inline void set_pte(pte_t *pteptr, pte_t pteval)
+{
+	pte_copy(*pteptr, pteval);
+
+	/* If it's a swap entry, it needs to be marked _PAGE_NEWPAGE so
+	 * fix_range knows to unmap it.  _PAGE_NEWPROT is specific to
+	 * mapped pages.
+	 */
+
+	*pteptr = pte_mknewpage(*pteptr);
+	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
+}
+#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+
 extern phys_t page_to_phys(struct page *page);
 
 /*
_


