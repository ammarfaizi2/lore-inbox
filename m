Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVIJMEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVIJMEn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVIJMEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:04:43 -0400
Received: from cantor2.suse.de ([195.135.220.15]:28369 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750766AbVIJMEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:04:42 -0400
Date: Sat, 10 Sep 2005 14:04:41 +0200
From: "Andi Kleen" <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: [2/2] Change p[gum]d_clear_* inlines to macros to fix p?d_ERROR
Message-ID: <4322CBD9.mailE1P118OD2@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change p[gum]d_clear_* inlines to macros to fix p?d_ERROR

When this code was refactored by Hugh it was moved out of the actual
functions into these inlines. The problem is that pgd_ERROR
uses __FUNCTION__ and __LINE__ to show where the error happened,
and with the inline that is pretty meaningless now because
it's the same for all callers.

Change them to be macros to avoid this problem

Cc: hugh@veritas.com

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/asm-generic/pgtable.h
===================================================================
--- linux.orig/include/asm-generic/pgtable.h
+++ linux/include/asm-generic/pgtable.h
@@ -170,44 +170,46 @@ static inline void ptep_set_wrprotect(st
 /*
  * When walking page tables, we usually want to skip any p?d_none entries;
  * and any p?d_bad entries - reporting the error before resetting to none.
- * Do the tests inline, but report and clear the bad entry in mm/memory.c.
+ * Use ugly macros so that __LINE__ in *_ERROR does the right thing.
  */
-void pgd_clear_bad(pgd_t *);
-void pud_clear_bad(pud_t *);
-void pmd_clear_bad(pmd_t *);
-
-static inline int pgd_none_or_clear_bad(pgd_t *pgd)
-{
-	if (pgd_none(*pgd))
-		return 1;
-	if (unlikely(pgd_bad(*pgd))) {
-		pgd_clear_bad(pgd);
-		return 1;
-	}
-	return 0;
-}
-
-static inline int pud_none_or_clear_bad(pud_t *pud)
-{
-	if (pud_none(*pud))
-		return 1;
-	if (unlikely(pud_bad(*pud))) {
-		pud_clear_bad(pud);
-		return 1;
-	}
-	return 0;
-}
-
-static inline int pmd_none_or_clear_bad(pmd_t *pmd)
-{
-	if (pmd_none(*pmd))
-		return 1;
-	if (unlikely(pmd_bad(*pmd))) {
-		pmd_clear_bad(pmd);
-		return 1;
-	}
-	return 0;
-}
+
+#define pgd_none_or_clear_bad(pgd) ({ \
+	int ret__ = 0;			\
+	if (pgd_none(*pgd))		\
+		ret__ = 1;		\
+	else if (unlikely(pgd_bad(*pgd))) {	\
+		pgd_ERROR(*pgd);		\
+		pgd_clear(pgd);		\
+		ret__ = 1;		\
+	}				\
+	ret__;				\
+})
+
+#define pud_none_or_clear_bad(pud) ({ \
+	int ret__ = 0;			\
+	if (pud_none(*pud))		\
+		ret__ = 1;		\
+	else if (unlikely(pud_bad(*pud))) {	\
+		pud_ERROR(*pud);		\
+		pud_clear(pud);		\
+		ret__ = 1;		\
+	}				\
+	ret__;				\
+})
+
+#define pmd_none_or_clear_bad(pmd) ({ \
+	int ret__ = 0;			\
+	if (pmd_none(*pmd))		\
+		ret__ = 1;		\
+	else if (unlikely(pmd_bad(*pmd))) {	\
+		pmd_ERROR(*pmd);		\
+		pmd_clear(pmd);		\
+		ret__ = 1;		\
+	}				\
+	ret__;				\
+})
+
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_GENERIC_PGTABLE_H */
Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c
+++ linux/mm/memory.c
@@ -83,30 +83,6 @@ EXPORT_SYMBOL(high_memory);
 EXPORT_SYMBOL(vmalloc_earlyreserve);
 
 /*
- * If a p?d_bad entry is found while walking page tables, report
- * the error, before resetting entry to p?d_none.  Usually (but
- * very seldom) called out from the p?d_none_or_clear_bad macros.
- */
-
-void pgd_clear_bad(pgd_t *pgd)
-{
-	pgd_ERROR(*pgd);
-	pgd_clear(pgd);
-}
-
-void pud_clear_bad(pud_t *pud)
-{
-	pud_ERROR(*pud);
-	pud_clear(pud);
-}
-
-void pmd_clear_bad(pmd_t *pmd)
-{
-	pmd_ERROR(*pmd);
-	pmd_clear(pmd);
-}
-
-/*
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
  */
