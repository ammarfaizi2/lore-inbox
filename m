Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWD3RdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWD3RdE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWD3RdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:33:01 -0400
Received: from host157-96.pool873.interbusiness.it ([87.3.96.157]:45010 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751205AbWD3Rcp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:32:45 -0400
Message-Id: <20060430173026.547367000@zion.home.lan>
References: <20060430172953.409399000@zion.home.lan>
User-Agent: quilt/0.44-1
Date: Sun, 30 Apr 2006 19:30:06 +0200
From: blaisorblade@yahoo.it
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 13/14] remap_file_pages protection support: uml, i386, x64 bits
Content-Disposition: inline; filename=rfp/02-rfp-arch-uml-i386.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Ingo Molnar <mingo@elte.hu>

Various boilerplate stuff.

Update pte encoding macros for UML, i386 and x86-64.

*) remap_file_pages protection support: improvement for UML bits

Recover one bit by additionally using _PAGE_NEWPROT. Since I wasn't sure this
would work, I've split this out, but it has worked well. We rely on the fact
that pte_newprot always checks first if the PTE is marked present. This is
joined because it worked well during the unit testing I performed, beyond
making sense.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/include/asm-i386/pgtable-2level.h
===================================================================
--- linux-2.6.git.orig/include/asm-i386/pgtable-2level.h
+++ linux-2.6.git/include/asm-i386/pgtable-2level.h
@@ -43,16 +43,21 @@ static inline int pte_exec_kernel(pte_t 
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
-
-#define pgoff_to_pte(off) \
-	((pte_t) { (((off) & 0x1f) << 1) + (((off) >> 5) << 8) + _PAGE_FILE })
+	((((pte).pte_low >> 2) & 0xf ) + (((pte).pte_low >> 8) << 4 ))
+#define pte_to_pgprot(pte) \
+	__pgprot(((pte).pte_low & (_PAGE_RW | _PAGE_PROTNONE)) \
+		| (((pte).pte_low & _PAGE_PROTNONE) ? 0 : \
+			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
+
+#define pgoff_prot_to_pte(off, prot) \
+	((pte_t) { (((off) & 0xf) << 2) + (((off) >> 4) << 8) + \
+	 (pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) + _PAGE_FILE })
 
 /* Encode and de-code a swap entry */
 #define __swp_type(x)			(((x).val >> 1) & 0x1f)
Index: linux-2.6.git/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.git.orig/include/asm-i386/pgtable-3level.h
+++ linux-2.6.git/include/asm-i386/pgtable-3level.h
@@ -140,7 +140,16 @@ static inline pmd_t pfn_pmd(unsigned lon
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
Index: linux-2.6.git/include/asm-um/pgtable-2level.h
===================================================================
--- linux-2.6.git.orig/include/asm-um/pgtable-2level.h
+++ linux-2.6.git/include/asm-um/pgtable-2level.h
@@ -45,12 +45,19 @@ static inline void pgd_mkuptodate(pgd_t 
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
Index: linux-2.6.git/include/asm-um/pgtable-3level.h
===================================================================
--- linux-2.6.git.orig/include/asm-um/pgtable-3level.h
+++ linux-2.6.git/include/asm-um/pgtable-3level.h
@@ -101,25 +101,35 @@ static inline pmd_t pfn_pmd(pfn_t page_n
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
+#define pgoff_prot_to_pte(off, prot) ((pte_t) { ((off) << 32) | _PAGE_FILE | \
+		(pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) })
+#define __pte_flags(pte) pte_val(pte)
 
 #else
 
 #define pte_to_pgoff(pte) ((pte).pte_high)
-
-#define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })
+#define pgoff_prot_to_pte(off, prot) ((pte_t) { \
+		(pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) | _PAGE_FILE, \
+		(off) })
+/* Don't use pte_val below, useless to join the two halves */
+#define __pte_flags(pte) ((pte).pte_low)
 
 #endif
 
+#define pte_to_pgprot(pte) \
+	__pgprot((__pte_flags(pte) & (_PAGE_RW | _PAGE_PROTNONE)) \
+		| ((__pte_flags(pte) & _PAGE_PROTNONE) ? 0 : \
+			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
+
 #endif
 
 /*
Index: linux-2.6.git/include/asm-x86_64/pgtable.h
===================================================================
--- linux-2.6.git.orig/include/asm-x86_64/pgtable.h
+++ linux-2.6.git/include/asm-x86_64/pgtable.h
@@ -360,9 +360,19 @@ static inline pud_t *__pud_offset_k(pud_
 #define pmd_pfn(x)  ((pmd_val(x) & __PHYSICAL_MASK) >> PAGE_SHIFT)
 
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
@@ -454,6 +464,7 @@ extern int kern_addr_valid(unsigned long
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTE_SAME
+#define __HAVE_ARCH_PTE_TO_PGPROT
 #include <asm-generic/pgtable.h>
 
 #endif /* _X86_64_PGTABLE_H */
Index: linux-2.6.git/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.git.orig/include/asm-i386/pgtable.h
+++ linux-2.6.git/include/asm-i386/pgtable.h
@@ -452,6 +452,7 @@ extern void noexec_setup(const char *str
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTE_SAME
+#define __HAVE_ARCH_PTE_TO_PGPROT
 #include <asm-generic/pgtable.h>
 
 #endif /* _I386_PGTABLE_H */
Index: linux-2.6.git/include/asm-um/pgtable.h
===================================================================
--- linux-2.6.git.orig/include/asm-um/pgtable.h
+++ linux-2.6.git/include/asm-um/pgtable.h
@@ -410,6 +410,7 @@ static inline pte_t pte_modify(pte_t pte
 
 #define kern_addr_valid(addr) (1)
 
+#define __HAVE_ARCH_PTE_TO_PGPROT
 #include <asm-generic/pgtable.h>
 
 #include <asm-generic/pgtable-nopud.h>

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
