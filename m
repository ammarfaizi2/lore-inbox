Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbULQEGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbULQEGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 23:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbULQEGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 23:06:40 -0500
Received: from mail.renesas.com ([202.234.163.13]:37846 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262737AbULQEGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 23:06:21 -0500
Date: Fri, 17 Dec 2004 13:06:07 +0900 (JST)
Message-Id: <20041217.130607.635751981.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, gniibe@fsij.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Support PAGE_NONE (1/3)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041217.130507.241920387.takata.hirokazu@renesas.com>
References: <20041217.130507.241920387.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.10-rc3-mm1] m32r: Support PAGE_NONE (1/3)
- Support PAGE_NONE attribute for memory protection.
- Add _PAGE_PROTNONE bit to pte (software bit).

Signed-off-by: NIIBE Yutaka <gniibe@fsij.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/pgtable-2level.h |    7 +++----
 include/asm-m32r/pgtable.h        |   12 +++++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)


diff -ruNp a/include/asm-m32r/pgtable-2level.h b/include/asm-m32r/pgtable-2level.h
--- a/include/asm-m32r/pgtable-2level.h	2004-12-16 15:10:31.000000000 +0900
+++ b/include/asm-m32r/pgtable-2level.h	2004-12-16 15:18:46.000000000 +0900
@@ -68,10 +68,9 @@ static __inline__ pmd_t *pmd_offset(pgd_
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
-/* M32R_FIXME : PTE_FILE_MAX_BITS, pte_to_pgoff, pgoff_to_pte */
-#define PTE_FILE_MAX_BITS	31
-#define pte_to_pgoff(pte)	(pte_val(pte) >> 1)
-#define pgoff_to_pte(off)	((pte_t) { ((off) << 1) | _PAGE_FILE })
+#define PTE_FILE_MAX_BITS	29
+#define pte_to_pgoff(pte)	(((pte_val(pte) >> 2) & 0xff) | (((pte_val(pte) >> 11)) << 8))
+#define pgoff_to_pte(off)	((pte_t) { (((off) & 0xff) << 2) | (((off) >> 8) << 11) | _PAGE_FILE })
 
 #endif /* _ASM_M32R_PGTABLE_2LEVEL_H */
 
diff -ruNp a/include/asm-m32r/pgtable.h b/include/asm-m32r/pgtable.h
--- a/include/asm-m32r/pgtable.h	2004-12-16 15:13:39.000000000 +0900
+++ b/include/asm-m32r/pgtable.h	2004-12-16 15:19:12.000000000 +0900
@@ -88,6 +88,7 @@ extern unsigned long empty_zero_page[102
 #define _PAGE_BIT_USER		8	/* software: user space access
 					   allowed */
 #define _PAGE_BIT_ACCESSED	9	/* software: page referenced */
+#define _PAGE_BIT_PROTNONE	10	/* software: if not present */
 
 #define _PAGE_DIRTY		(1UL << _PAGE_BIT_DIRTY)
 #define _PAGE_FILE		(1UL << _PAGE_BIT_FILE)
@@ -100,6 +101,7 @@ extern unsigned long empty_zero_page[102
 #define _PAGE_NONCACHABLE	(1UL << _PAGE_BIT_NONCACHABLE)
 #define _PAGE_USER		(1UL << _PAGE_BIT_USER)
 #define _PAGE_ACCESSED		(1UL << _PAGE_BIT_ACCESSED)
+#define _PAGE_PROTNONE		(1UL << _PAGE_BIT_PROTNONE)
 
 #define _PAGE_TABLE	\
 	( _PAGE_PRESENT | _PAGE_WRITE | _PAGE_READ | _PAGE_USER \
@@ -112,7 +114,7 @@ extern unsigned long empty_zero_page[102
 
 #ifdef CONFIG_MMU
 #define PAGE_NONE	\
-	__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED)
+	__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
 #define PAGE_SHARED	\
 	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | _PAGE_READ | _PAGE_USER \
 		| _PAGE_ACCESSED)
@@ -177,7 +179,7 @@ extern unsigned long empty_zero_page[102
 
 /* page table for 0-4MB for everybody */
 
-#define pte_present(x)	(pte_val(x) & _PAGE_PRESENT)
+#define pte_present(x)	(pte_val(x) & (_PAGE_PRESENT | _PAGE_PROTNONE))
 #define pte_clear(xp)	do { set_pte(xp, __pte(0)); } while (0)
 
 #define pmd_none(x)	(!pmd_val(x))
@@ -376,10 +378,10 @@ static inline void pmd_set(pmd_t * pmdp,
 #define pte_unmap_nested(pte)	do { } while (0)
 
 /* Encode and de-code a swap entry */
-#define __swp_type(x)			(((x).val >> 1) & 0x3f)
-#define __swp_offset(x)			((x).val >> 8)
+#define __swp_type(x)			(((x).val >> 2) & 0x3f)
+#define __swp_offset(x)			((x).val >> 11)
 #define __swp_entry(type, offset)	\
-	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
+	((swp_entry_t) { ((type) << 2) | ((offset) << 11) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

