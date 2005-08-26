Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbVHZRGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbVHZRGF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVHZRF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:05:28 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:33429 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965125AbVHZRCO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:02:14 -0400
Subject: [patch 01/18] remap_file_pages protection support: uml, i386, x64 bits
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:52:50 +0200
Message-Id: <20050826165253.8705999E3D@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Ingo Molnar <mingo@elte.hu>

Update pte encoding macros for UML, i386 and x86-64. Also, add the
MAP_NOINHERIT flag to arch headers.

*** remap_file_pages protection support: improvement for UML bits

Recover one bit by additionally using _PAGE_NEWPROT. Since I wasn't sure this
would work, I've split this out, but it has worked well. We rely on the fact
that pte_newprot always checks first if the PTE is marked present.


Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-i386/mman.h           |    1 
 linux-2.6.git-paolo/include/asm-i386/pgtable-2level.h |   15 ++++++++----
 linux-2.6.git-paolo/include/asm-i386/pgtable-3level.h |   11 ++++++++-
 linux-2.6.git-paolo/include/asm-ia64/mman.h           |    1 
 linux-2.6.git-paolo/include/asm-ppc/mman.h            |    1 
 linux-2.6.git-paolo/include/asm-ppc64/mman.h          |    1 
 linux-2.6.git-paolo/include/asm-s390/mman.h           |    1 
 linux-2.6.git-paolo/include/asm-um/pgtable-2level.h   |   15 +++++++++---
 linux-2.6.git-paolo/include/asm-um/pgtable-3level.h   |   21 +++++++++++++-----
 linux-2.6.git-paolo/include/asm-x86_64/mman.h         |    1 
 linux-2.6.git-paolo/include/asm-x86_64/pgtable.h      |   12 +++++++++-
 11 files changed, 64 insertions(+), 16 deletions(-)

diff -puN include/asm-um/pgtable-2level.h~rfp-arch-uml include/asm-um/pgtable-2level.h
--- linux-2.6.git/include/asm-um/pgtable-2level.h~rfp-arch-uml	2005-08-21 21:09:42.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable-2level.h	2005-08-21 21:09:42.000000000 +0200
@@ -72,12 +72,19 @@ static inline void set_pte(pte_t *pteptr
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 /*
- * Bits 0 through 3 are taken
+ * Bits 0, 1, 3 to 5 are taken, split up the 27 bits of offset
+ * into this range:
  */
-#define PTE_FILE_MAX_BITS	28
+#define PTE_FILE_MAX_BITS	27
 
-#define pte_to_pgoff(pte) (pte_val(pte) >> 4)
+#define pte_to_pgoff(pte) (((pte_val(pte) >> 6) << 1) | ((pte_val(pte) >> 2) & 0x1))
+#define pte_to_pgprot(pte) \
+	__pgprot((pte_val(pte) & (_PAGE_RW | _PAGE_PROTNONE)) \
+		| ((pte_val(pte) & _PAGE_PROTNONE) ? 0 : \
+			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
 
-#define pgoff_to_pte(off) ((pte_t) { ((off) << 4) + _PAGE_FILE })
+#define pgoff_prot_to_pte(off, prot) \
+	__pte((((off) >> 1) << 6) + (((off) & 0x1) << 2) + \
+	 (pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) + _PAGE_FILE)
 
 #endif
diff -puN include/asm-um/pgtable-3level.h~rfp-arch-uml include/asm-um/pgtable-3level.h
--- linux-2.6.git/include/asm-um/pgtable-3level.h~rfp-arch-uml	2005-08-21 21:09:42.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable-3level.h	2005-08-21 21:09:42.000000000 +0200
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
diff -puN include/asm-i386/pgtable-2level.h~rfp-arch-uml include/asm-i386/pgtable-2level.h
--- linux-2.6.git/include/asm-i386/pgtable-2level.h~rfp-arch-uml	2005-08-21 21:09:53.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-i386/pgtable-2level.h	2005-08-21 21:09:53.000000000 +0200
@@ -48,16 +48,21 @@ static inline int pte_exec_kernel(pte_t 
 }
 
 /*
- * Bits 0, 6 and 7 are taken, split up the 29 bits of offset
+ * Bits 0, 1, 6 and 7 are taken, split up the 28 bits of offset
  * into this range:
  */
-#define PTE_FILE_MAX_BITS	29
+#define PTE_FILE_MAX_BITS	28
 
 #define pte_to_pgoff(pte) \
-	((((pte).pte_low >> 1) & 0x1f ) + (((pte).pte_low >> 8) << 5 ))
+	((((pte).pte_low >> 2) & 0xf ) + (((pte).pte_low >> 8) << 4 ))
+#define pte_to_pgprot(pte) \
+	__pgprot(((pte).pte_low & (_PAGE_RW | _PAGE_PROTNONE)) \
+		| (((pte).pte_low & _PAGE_PROTNONE) ? 0 : \
+			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
 
-#define pgoff_to_pte(off) \
-	((pte_t) { (((off) & 0x1f) << 1) + (((off) >> 5) << 8) + _PAGE_FILE })
+#define pgoff_prot_to_pte(off, prot) \
+	((pte_t) { (((off) & 0xf) << 2) + (((off) >> 4) << 8) + \
+	 (pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) + _PAGE_FILE })
 
 /* Encode and de-code a swap entry */
 #define __swp_type(x)			(((x).val >> 1) & 0x1f)
diff -puN include/asm-i386/pgtable-3level.h~rfp-arch-uml include/asm-i386/pgtable-3level.h
--- linux-2.6.git/include/asm-i386/pgtable-3level.h~rfp-arch-uml	2005-08-21 21:09:53.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-i386/pgtable-3level.h	2005-08-21 21:09:53.000000000 +0200
@@ -145,7 +145,16 @@ static inline pmd_t pfn_pmd(unsigned lon
  * put the 32 bits of offset into the high part.
  */
 #define pte_to_pgoff(pte) ((pte).pte_high)
-#define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })
+
+#define pte_to_pgprot(pte) \
+	__pgprot(((pte).pte_low & (_PAGE_RW | _PAGE_PROTNONE)) \
+		| (((pte).pte_low & _PAGE_PROTNONE) ? 0 : \
+			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
+
+#define pgoff_prot_to_pte(off, prot) \
+	((pte_t) { _PAGE_FILE + \
+		(pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) , (off) })
+
 #define PTE_FILE_MAX_BITS       32
 
 /* Encode and de-code a swap entry */
diff -puN include/asm-x86_64/pgtable.h~rfp-arch-uml include/asm-x86_64/pgtable.h
--- linux-2.6.git/include/asm-x86_64/pgtable.h~rfp-arch-uml	2005-08-21 21:09:53.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-x86_64/pgtable.h	2005-08-21 21:09:53.000000000 +0200
@@ -343,9 +343,19 @@ static inline pud_t *__pud_offset_k(pud_
 #define pmd_pfn(x)  ((pmd_val(x) >> PAGE_SHIFT) & __PHYSICAL_MASK)
 
 #define pte_to_pgoff(pte) ((pte_val(pte) & PHYSICAL_PAGE_MASK) >> PAGE_SHIFT)
-#define pgoff_to_pte(off) ((pte_t) { ((off) << PAGE_SHIFT) | _PAGE_FILE })
 #define PTE_FILE_MAX_BITS __PHYSICAL_MASK_SHIFT
 
+#define pte_to_pgprot(pte) \
+	__pgprot((pte_val(pte) & (_PAGE_RW | _PAGE_PROTNONE)) \
+		| ((pte_val(pte) & _PAGE_PROTNONE) ? 0 : \
+			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
+
+#define pgoff_prot_to_pte(off, prot) \
+	((pte_t) { _PAGE_FILE + \
+		(pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) + \
+			((off) << PAGE_SHIFT) })
+
+
 /* PTE - Level 1 access. */
 
 /* page, protection -> pte */
diff -puN include/asm-i386/mman.h~rfp-arch-uml include/asm-i386/mman.h
--- linux-2.6.git/include/asm-i386/mman.h~rfp-arch-uml	2005-08-21 21:11:12.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-i386/mman.h	2005-08-21 21:11:12.000000000 +0200
@@ -22,6 +22,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -puN include/asm-ia64/mman.h~rfp-arch-uml include/asm-ia64/mman.h
--- linux-2.6.git/include/asm-ia64/mman.h~rfp-arch-uml	2005-08-21 21:11:12.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ia64/mman.h	2005-08-21 21:11:12.000000000 +0200
@@ -30,6 +30,7 @@
 #define MAP_NORESERVE	0x04000		/* don't check for reservations */
 #define MAP_POPULATE	0x08000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -puN include/asm-ppc64/mman.h~rfp-arch-uml include/asm-ppc64/mman.h
--- linux-2.6.git/include/asm-ppc64/mman.h~rfp-arch-uml	2005-08-21 21:11:12.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ppc64/mman.h	2005-08-21 21:11:12.000000000 +0200
@@ -38,6 +38,7 @@
 
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MADV_NORMAL	0x0		/* default page-in behavior */
 #define MADV_RANDOM	0x1		/* page-in minimum required */
diff -puN include/asm-ppc/mman.h~rfp-arch-uml include/asm-ppc/mman.h
--- linux-2.6.git/include/asm-ppc/mman.h~rfp-arch-uml	2005-08-21 21:11:12.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ppc/mman.h	2005-08-21 21:11:12.000000000 +0200
@@ -23,6 +23,7 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -puN include/asm-s390/mman.h~rfp-arch-uml include/asm-s390/mman.h
--- linux-2.6.git/include/asm-s390/mman.h~rfp-arch-uml	2005-08-21 21:11:12.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-s390/mman.h	2005-08-21 21:11:12.000000000 +0200
@@ -30,6 +30,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -puN include/asm-x86_64/mman.h~rfp-arch-uml include/asm-x86_64/mman.h
--- linux-2.6.git/include/asm-x86_64/mman.h~rfp-arch-uml	2005-08-21 21:11:12.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-x86_64/mman.h	2005-08-21 21:11:13.000000000 +0200
@@ -23,6 +23,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
_
