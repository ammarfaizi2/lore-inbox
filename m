Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbULQEI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbULQEI7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 23:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbULQEHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 23:07:00 -0500
Received: from mail.renesas.com ([202.234.163.13]:47096 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262491AbULQEGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 23:06:33 -0500
Date: Fri, 17 Dec 2004 13:06:21 +0900 (JST)
Message-Id: <20041217.130621.295420367.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Remove PAGE_USER (2/3)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041217.130507.241920387.takata.hirokazu@renesas.com>
References: <20041217.130507.241920387.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.10-rc3-mm1] m32r: Remove PAGE_USER (2/3)
- Remove _PAGE_USER bit from pte.
- The m32r doesn't support _PAGE_USER bit by hardware. 

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/pgtable-2level.h |    5 ++---
 include/asm-m32r/pgtable.h        |   38 +++++++++++++-------------------------
 2 files changed, 15 insertions(+), 28 deletions(-)


diff -ruNp a/include/asm-m32r/pgtable-2level.h b/include/asm-m32r/pgtable-2level.h
--- a/include/asm-m32r/pgtable-2level.h	2004-12-16 15:24:14.000000000 +0900
+++ b/include/asm-m32r/pgtable-2level.h	2004-12-16 16:08:35.000000000 +0900
@@ -69,8 +69,7 @@ static __inline__ pmd_t *pmd_offset(pgd_
 #define pfn_pmd(pfn, prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
 #define PTE_FILE_MAX_BITS	29
-#define pte_to_pgoff(pte)	(((pte_val(pte) >> 2) & 0xff) | (((pte_val(pte) >> 11)) << 8))
-#define pgoff_to_pte(off)	((pte_t) { (((off) & 0xff) << 2) | (((off) >> 8) << 11) | _PAGE_FILE })
+#define pte_to_pgoff(pte)	(((pte_val(pte) >> 2) & 0xef) | (((pte_val(pte) >> 10)) << 7))
+#define pgoff_to_pte(off)	((pte_t) { (((off) & 0xef) << 2) | (((off) >> 7) << 10) | _PAGE_FILE })
 
 #endif /* _ASM_M32R_PGTABLE_2LEVEL_H */
-
diff -ruNp a/include/asm-m32r/pgtable.h b/include/asm-m32r/pgtable.h
--- a/include/asm-m32r/pgtable.h	2004-12-16 15:24:14.000000000 +0900
+++ b/include/asm-m32r/pgtable.h	2004-12-16 16:08:21.000000000 +0900
@@ -85,10 +85,8 @@ extern unsigned long empty_zero_page[102
 #define _PAGE_BIT_WRITE		5	/* Write */
 #define _PAGE_BIT_READ		6	/* Read */
 #define _PAGE_BIT_NONCACHABLE	7	/* Non cachable */
-#define _PAGE_BIT_USER		8	/* software: user space access
-					   allowed */
-#define _PAGE_BIT_ACCESSED	9	/* software: page referenced */
-#define _PAGE_BIT_PROTNONE	10	/* software: if not present */
+#define _PAGE_BIT_ACCESSED	8	/* software: page referenced */
+#define _PAGE_BIT_PROTNONE	9	/* software: if not present */
 
 #define _PAGE_DIRTY		(1UL << _PAGE_BIT_DIRTY)
 #define _PAGE_FILE		(1UL << _PAGE_BIT_FILE)
@@ -99,13 +97,12 @@ extern unsigned long empty_zero_page[102
 #define _PAGE_WRITE		(1UL << _PAGE_BIT_WRITE)
 #define _PAGE_READ		(1UL << _PAGE_BIT_READ)	
 #define _PAGE_NONCACHABLE	(1UL << _PAGE_BIT_NONCACHABLE)
-#define _PAGE_USER		(1UL << _PAGE_BIT_USER)
 #define _PAGE_ACCESSED		(1UL << _PAGE_BIT_ACCESSED)
 #define _PAGE_PROTNONE		(1UL << _PAGE_BIT_PROTNONE)
 
 #define _PAGE_TABLE	\
-	( _PAGE_PRESENT | _PAGE_WRITE | _PAGE_READ | _PAGE_USER \
-	| _PAGE_ACCESSED | _PAGE_DIRTY )
+	( _PAGE_PRESENT | _PAGE_WRITE | _PAGE_READ | _PAGE_ACCESSED \
+	| _PAGE_DIRTY )
 #define _KERNPG_TABLE	\
 	( _PAGE_PRESENT | _PAGE_WRITE | _PAGE_READ | _PAGE_ACCESSED \
 	| _PAGE_DIRTY )
@@ -116,21 +113,18 @@ extern unsigned long empty_zero_page[102
 #define PAGE_NONE	\
 	__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
 #define PAGE_SHARED	\
-	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | _PAGE_READ | _PAGE_USER \
-		| _PAGE_ACCESSED)
+	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | _PAGE_READ | _PAGE_ACCESSED)
 #define PAGE_SHARED_EXEC \
 	__pgprot(_PAGE_PRESENT | _PAGE_EXEC | _PAGE_WRITE | _PAGE_READ \
-		| _PAGE_USER | _PAGE_ACCESSED)
+		| _PAGE_ACCESSED)
 #define PAGE_COPY	\
-	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_USER | _PAGE_ACCESSED)
+	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_ACCESSED)
 #define PAGE_COPY_EXEC	\
-	__pgprot(_PAGE_PRESENT | _PAGE_EXEC | _PAGE_READ | _PAGE_USER \
-		| _PAGE_ACCESSED)
+	__pgprot(_PAGE_PRESENT | _PAGE_EXEC | _PAGE_READ | _PAGE_ACCESSED)
 #define PAGE_READONLY	\
-	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_USER | _PAGE_ACCESSED)
+	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_ACCESSED)
 #define PAGE_READONLY_EXEC \
-	__pgprot(_PAGE_PRESENT | _PAGE_EXEC | _PAGE_READ | _PAGE_USER \
-		| _PAGE_ACCESSED)
+	__pgprot(_PAGE_PRESENT | _PAGE_EXEC | _PAGE_READ | _PAGE_ACCESSED)
 
 #define __PAGE_KERNEL	\
 	( _PAGE_PRESENT | _PAGE_EXEC | _PAGE_WRITE | _PAGE_READ | _PAGE_DIRTY \
@@ -185,8 +179,7 @@ extern unsigned long empty_zero_page[102
 #define pmd_none(x)	(!pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
-#define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) \
-	!= _KERNPG_TABLE)
+#define	pmd_bad(x)	((pmd_val(x) & ~PAGE_MASK) != _KERNPG_TABLE)
 
 #define pages_to_mb(x)	((x) >> (20 - PAGE_SHIFT))
 
@@ -194,11 +187,6 @@ extern unsigned long empty_zero_page[102
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
-static inline int pte_user(pte_t pte)
-{
-	return pte_val(pte) & _PAGE_USER;
-}
-
 static inline int pte_read(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_READ;
@@ -379,9 +367,9 @@ static inline void pmd_set(pmd_t * pmdp,
 
 /* Encode and de-code a swap entry */
 #define __swp_type(x)			(((x).val >> 2) & 0x3f)
-#define __swp_offset(x)			((x).val >> 11)
+#define __swp_offset(x)			((x).val >> 10)
 #define __swp_entry(type, offset)	\
-	((swp_entry_t) { ((type) << 2) | ((offset) << 11) })
+	((swp_entry_t) { ((type) << 2) | ((offset) << 10) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
