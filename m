Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVHLRyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVHLRyk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVHLRyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:54:17 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:33238 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1750764AbVHLRyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:54:15 -0400
Subject: [patch 09/39] remap_file_pages protection support: improvement for UML bits
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 19:31:50 +0200
Message-Id: <20050812173151.22F6424E7D6@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recover one bit by additionally using _PAGE_NEWPROT. Since I wasn't sure this
would work, I've split this out. We rely on the fact that pte_newprot always
checks first if the PTE is marked present.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-um/pgtable-2level.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -puN include/asm-um/pgtable-2level.h~rfp-arch-uml-improv include/asm-um/pgtable-2level.h
--- linux-2.6.git/include/asm-um/pgtable-2level.h~rfp-arch-uml-improv	2005-08-07 19:09:34.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable-2level.h	2005-08-07 19:09:34.000000000 +0200
@@ -72,19 +72,19 @@ static inline void set_pte(pte_t *pteptr
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 /*
- * Bits 0 to 5 are taken, split up the 26 bits of offset
+ * Bits 0, 1, 3 to 5 are taken, split up the 27 bits of offset
  * into this range:
  */
-#define PTE_FILE_MAX_BITS	26
+#define PTE_FILE_MAX_BITS	27
 
-#define pte_to_pgoff(pte) (pte_val(pte) >> 6)
+#define pte_to_pgoff(pte) (((pte_val(pte) >> 6) << 1) | ((pte_val(pte) >> 2) & 0x1))
 #define pte_to_pgprot(pte) \
 	__pgprot((pte_val(pte) & (_PAGE_RW | _PAGE_PROTNONE)) \
 		| ((pte_val(pte) & _PAGE_PROTNONE) ? 0 : \
 			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
 
 #define pgoff_prot_to_pte(off, prot) \
-	((pte_t) { ((off) << 6) + \
-	 (pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) + _PAGE_FILE })
+	__pte((((off) >> 1) << 6) + (((off) & 0x1) << 2) + \
+	 (pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) + _PAGE_FILE)
 
 #endif
_
