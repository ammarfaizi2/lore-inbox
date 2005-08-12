Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVHLR6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVHLR6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVHLRyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:54:47 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:36566 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1750787AbVHLRya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:54:30 -0400
Subject: [patch 08/39] remap_file_pages protection support: uml bits
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 19:31:48 +0200
Message-Id: <20050812173148.8C0B624E7D2@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update pte encoding macros for UML.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-um/pgtable-2level.h |   15 ++++++++++----
 linux-2.6.git-paolo/include/asm-um/pgtable-3level.h |   21 +++++++++++++++-----
 2 files changed, 27 insertions(+), 9 deletions(-)

diff -puN include/asm-um/pgtable-2level.h~rfp-arch-uml include/asm-um/pgtable-2level.h
--- linux-2.6.git/include/asm-um/pgtable-2level.h~rfp-arch-uml	2005-08-11 11:23:21.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable-2level.h	2005-08-11 11:23:21.000000000 +0200
@@ -72,12 +72,19 @@ static inline void set_pte(pte_t *pteptr
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 /*
- * Bits 0 through 3 are taken
+ * Bits 0 to 5 are taken, split up the 26 bits of offset
+ * into this range:
  */
-#define PTE_FILE_MAX_BITS	28
+#define PTE_FILE_MAX_BITS	26
 
-#define pte_to_pgoff(pte) (pte_val(pte) >> 4)
+#define pte_to_pgoff(pte) (pte_val(pte) >> 6)
+#define pte_to_pgprot(pte) \
+	__pgprot((pte_val(pte) & (_PAGE_RW | _PAGE_PROTNONE)) \
+		| ((pte_val(pte) & _PAGE_PROTNONE) ? 0 : \
+			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
 
-#define pgoff_to_pte(off) ((pte_t) { ((off) << 4) + _PAGE_FILE })
+#define pgoff_prot_to_pte(off, prot) \
+	((pte_t) { ((off) << 6) + \
+	 (pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) + _PAGE_FILE })
 
 #endif
diff -puN include/asm-um/pgtable-3level.h~rfp-arch-uml include/asm-um/pgtable-3level.h
--- linux-2.6.git/include/asm-um/pgtable-3level.h~rfp-arch-uml	2005-08-11 11:23:21.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable-3level.h	2005-08-11 11:23:21.000000000 +0200
@@ -140,25 +140,36 @@ static inline pmd_t pfn_pmd(pfn_t page_n
 }
 
 /*
- * Bits 0 through 3 are taken in the low part of the pte,
+ * Bits 0 through 5 are taken in the low part of the pte,
  * put the 32 bits of offset into the high part.
  */
 #define PTE_FILE_MAX_BITS	32
 
+
 #ifdef CONFIG_64BIT
 
 #define pte_to_pgoff(p) ((p).pte >> 32)
-
-#define pgoff_to_pte(off) ((pte_t) { ((off) << 32) | _PAGE_FILE })
+#define pgoff_to_pte(off) ((pte_t) { ((off) << 32) | _PAGE_FILE | \
+		(pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) })
+#define pte_flags(pte) pte_val(pte)
 
 #else
 
 #define pte_to_pgoff(pte) ((pte).pte_high)
-
-#define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })
+#define pgoff_prot_to_pte(off, prot) ((pte_t) { \
+		(pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) | _PAGE_FILE, \
+		(off) })
+/* Don't use pte_val below, useless to join the two halves */
+#define pte_flags(pte) ((pte).pte_low)
 
 #endif
 
+#define pte_to_pgprot(pte) \
+	__pgprot((pte_flags(pte) & (_PAGE_RW | _PAGE_PROTNONE)) \
+		| ((pte_flags(pte) & _PAGE_PROTNONE) ? 0 : \
+			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
+#undef pte_flags
+
 #endif
 
 /*
_
