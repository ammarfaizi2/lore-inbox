Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422978AbWHZRo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422978AbWHZRo3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422974AbWHZRnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:43:08 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:18087 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1422975AbWHZRnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:43:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=mZykCCXanK3XcQzCu9WsoXts9IOlp+Z1agG/WqpRTD5qdDVvJSFXW4anvC15IxXKEIkpe7HL1ZjTNQkFcB3C/O3bZrL6tQwU0BR8/myyBe5Xob1RNhO/7n5qeoF0OA/veogRZsAMOmc8SO2PFwv+6nyu5uaFxQJYUslWrxF/468=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH RFP-V4 13/13] RFP prot support: uml, i386, x64 bits
Date: Sat, 26 Aug 2006 19:42:53 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <20060826174253.14790.47973.stgit@memento.home.lan>
In-Reply-To: <200608261933.36574.blaisorblade@yahoo.it>
References: <200608261933.36574.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
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

========
RFP: Avoid using _PAGE_PROTNONE

For i386, x86_64, uml:

To encode a pte_file PROTNONE pte, since _PAGE_PROTNONE makes pte_present be
set, and since such a pte actually still references a page, we need to use
another bit for our purposes. Implement this.

* Add _PAGE_FILE_PROTNONE, the bit describe above.
* Add to each arch pgprot_access_bits() to extract the value of protection bits
  (i.e._PAGE_RW and _PAGE_PROTNONE) and encode them (translate _PAGE_PROTNONE to
  _PAGE_FILE_PROTNONE), and use it in pgoff_prot_to_pte().
* Modify pte_to_pgprot() to do the inverse translation.
* Modify pte_to_pgoff() and pgoff_prot_to_pte() to leave alone the newly used
  bit (for 32-bit PTEs).
* Join for UML and x86 pte_to_pgprot() for 2level and 3level page tables, since
  they were identical.
* Decrease by 1 PTE_FILE_MAX_BITS where appropriate.
* Also replace in bit operations + with | where appropriate.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-i386/pgtable-2level.h |   11 ++++++-----
 include/asm-i386/pgtable-3level.h |    7 +++++--
 include/asm-i386/pgtable.h        |   24 ++++++++++++++++++++++++
 include/asm-um/pgtable-2level.h   |   16 ++++++++++++----
 include/asm-um/pgtable-3level.h   |   21 ++++++++++++++-------
 include/asm-um/pgtable.h          |   21 +++++++++++++++++++++
 include/asm-x86_64/pgtable.h      |   29 +++++++++++++++++++++++++++--
 7 files changed, 109 insertions(+), 20 deletions(-)

diff --git a/include/asm-i386/pgtable-2level.h b/include/asm-i386/pgtable-2level.h
index 2756d4b..01b7652 100644
--- a/include/asm-i386/pgtable-2level.h
+++ b/include/asm-i386/pgtable-2level.h
@@ -46,16 +46,17 @@ static inline int pte_exec_kernel(pte_t 
 }
 
 /*
- * Bits 0, 6 and 7 are taken, split up the 29 bits of offset
+ * Bits 0, 1, 6, 7 and 8 are taken, split up the 27 bits of offset
  * into this range:
  */
-#define PTE_FILE_MAX_BITS	29
+#define PTE_FILE_MAX_BITS	27
 
 #define pte_to_pgoff(pte) \
-	((((pte).pte_low >> 1) & 0x1f ) + (((pte).pte_low >> 8) << 5 ))
+	((((pte).pte_low >> 2) & 0xf ) | (((pte).pte_low >> 9) << 4 ))
 
-#define pgoff_to_pte(off) \
-	((pte_t) { (((off) & 0x1f) << 1) + (((off) >> 5) << 8) + _PAGE_FILE })
+#define pgoff_prot_to_pte(off, prot) \
+	((pte_t) { (((off) & 0xf) << 2) | (((off) >> 4) << 9) | \
+	 pgprot_access_bits(prot) | _PAGE_FILE })
 
 /* Encode and de-code a swap entry */
 #define __swp_type(x)			(((x).val >> 1) & 0x1f)
diff --git a/include/asm-i386/pgtable-3level.h b/include/asm-i386/pgtable-3level.h
index dccb1b3..8231017 100644
--- a/include/asm-i386/pgtable-3level.h
+++ b/include/asm-i386/pgtable-3level.h
@@ -156,11 +156,14 @@ static inline pmd_t pfn_pmd(unsigned lon
 }
 
 /*
- * Bits 0, 6 and 7 are taken in the low part of the pte,
+ * Bits 0, 1, 6, 7 and 8 are taken in the low part of the pte,
  * put the 32 bits of offset into the high part.
  */
 #define pte_to_pgoff(pte) ((pte).pte_high)
-#define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })
+
+#define pgoff_prot_to_pte(off, prot) \
+	((pte_t) { _PAGE_FILE | pgprot_access_bits(prot), (off) })
+
 #define PTE_FILE_MAX_BITS       32
 
 /* Encode and de-code a swap entry */
diff --git a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
index 09697fe..2661088 100644
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -14,6 +14,7 @@ #define _I386_PGTABLE_H
 #ifndef __ASSEMBLY__
 #include <asm/processor.h>
 #include <asm/fixmap.h>
+#include <linux/bitops.h>
 #include <linux/threads.h>
 
 #ifndef _I386_BITOPS_H
@@ -99,8 +100,10 @@ #define _PAGE_BIT_PWT		3
 #define _PAGE_BIT_PCD		4
 #define _PAGE_BIT_ACCESSED	5
 #define _PAGE_BIT_DIRTY		6
+#define _PAGE_BIT_PROTNONE	6
 #define _PAGE_BIT_PSE		7	/* 4 MB (or 2MB) page, Pentium+, if present.. */
 #define _PAGE_BIT_GLOBAL	8	/* Global TLB entry PPro+ */
+#define _PAGE_BIT_FILE_PROTNONE 8
 #define _PAGE_BIT_UNUSED1	9	/* available for programmer */
 #define _PAGE_BIT_UNUSED2	10
 #define _PAGE_BIT_UNUSED3	11
@@ -123,6 +126,26 @@ #define _PAGE_UNUSED3	0x800
 #define _PAGE_FILE	0x040	/* nonlinear file mapping, saved PTE; unset:swap */
 #define _PAGE_PROTNONE	0x080	/* if the user mapped it with PROT_NONE;
 				   pte_present gives true */
+#define _PAGE_FILE_PROTNONE	0x100	/* indicate that the page is remapped
+					   with PROT_NONE - this is different
+					   from _PAGE_PROTNONE as no page is
+					   held here, so pte_present() is false
+					   */
+
+/* Extracts _PAGE_RW and _PAGE_PROTNONE and replace the latter with
+ * _PAGE_FILE_PROTNONE. */
+#define pgprot_access_bits(prot) \
+	((pgprot_val(prot) & _PAGE_RW) | \
+	 bitmask_trans(pgprot_val(prot), _PAGE_PROTNONE, _PAGE_FILE_PROTNONE))
+
+#define pte_to_pgprot(pte) \
+	__pgprot(((pte).pte_low & (_PAGE_RW|_PAGE_PROTNONE)))
+
+#define pte_file_to_pgprot(pte) \
+	__pgprot(((pte).pte_low & _PAGE_RW) | _PAGE_ACCESSED | \
+		(((pte).pte_low & _PAGE_FILE_PROTNONE) ? _PAGE_PROTNONE : \
+			(_PAGE_USER | _PAGE_PRESENT)))
+
 #ifdef CONFIG_X86_PAE
 #define _PAGE_NX	(1ULL<<_PAGE_BIT_NX)
 #else
@@ -447,6 +470,7 @@ #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTE_SAME
+#define __HAVE_ARCH_PTE_TO_PGPROT
 #include <asm-generic/pgtable.h>
 
 #endif /* _I386_PGTABLE_H */
diff --git a/include/asm-um/pgtable-2level.h b/include/asm-um/pgtable-2level.h
index ffe017f..8066430 100644
--- a/include/asm-um/pgtable-2level.h
+++ b/include/asm-um/pgtable-2level.h
@@ -45,12 +45,20 @@ #define pmd_page_kernel(pmd) \
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 /*
- * Bits 0 through 3 are taken
+ * Bits 0, 1, 3 to 5 and 8 are taken, split up the 26 bits of offset
+ * into this range:
  */
-#define PTE_FILE_MAX_BITS	28
+#define PTE_FILE_MAX_BITS	26
 
-#define pte_to_pgoff(pte) (pte_val(pte) >> 4)
+#define pte_to_pgoff(pte) (((pte_val(pte) >> 2) & 0x1) | \
+		(((pte_val(pte) >> 6) & 0x3) << 1) | \
+		((pte_val(pte) >> 9) << 3))
 
-#define pgoff_to_pte(off) ((pte_t) { ((off) << 4) + _PAGE_FILE })
+#define pgoff_prot_to_pte(off, prot) \
+	__pte((((off) & 0x1) << 2) | ((((off) & 0x7) >> 1) << 6) | \
+	((off >> 3) << 9) | pgprot_access_bits(prot) | _PAGE_FILE)
+
+/* For pte_file_to_pgprot definition only */
+#define __pte_low(pte) pte_val(pte)
 
 #endif
diff --git a/include/asm-um/pgtable-3level.h b/include/asm-um/pgtable-3level.h
index 786c257..8b2fdb3 100644
--- a/include/asm-um/pgtable-3level.h
+++ b/include/asm-um/pgtable-3level.h
@@ -101,25 +101,32 @@ static inline pmd_t pfn_pmd(pfn_t page_n
 }
 
 /*
- * Bits 0 through 3 are taken in the low part of the pte,
+ * Bits 0 through 5 are taken in the low part of the pte,
  * put the 32 bits of offset into the high part.
  */
 #define PTE_FILE_MAX_BITS	32
 
-#ifdef CONFIG_64BIT
 
-#define pte_to_pgoff(p) ((p).pte >> 32)
+#ifdef CONFIG_64BIT
 
-#define pgoff_to_pte(off) ((pte_t) { ((off) << 32) | _PAGE_FILE })
+/* For pte_file_to_pgprot definition only */
+#define __pte_low(pte) pte_val(pte)
+#define __pte_high(pte) (pte_val(pte) >> 32)
+#define __build_pte(low, high) ((pte_t) { (high) << 32 | (low)})
 
 #else
 
-#define pte_to_pgoff(pte) ((pte).pte_high)
-
-#define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })
+/* Don't use pte_val below, useless to join the two halves */
+#define __pte_low(pte) ((pte).pte_low)
+#define __pte_high(pte) ((pte).pte_high)
+#define __build_pte(low, high) ((pte_t) {(low), (high)})
 
 #endif
 
+#define pte_to_pgoff(pte) __pte_high(pte)
+#define pgoff_prot_to_pte(off, prot) \
+	__build_pte(_PAGE_FILE | pgprot_access_bits(prot), (off))
+
 #endif
 
 /*
diff --git a/include/asm-um/pgtable.h b/include/asm-um/pgtable.h
index ac64eb9..2cea58f 100644
--- a/include/asm-um/pgtable.h
+++ b/include/asm-um/pgtable.h
@@ -10,6 +10,7 @@ #define __UM_PGTABLE_H
 
 #include "linux/sched.h"
 #include "linux/linkage.h"
+#include "linux/bitops.h"
 #include "asm/processor.h"
 #include "asm/page.h"
 #include "asm/fixmap.h"
@@ -25,6 +26,17 @@ #define _PAGE_DIRTY	0x100
 #define _PAGE_FILE	0x008	/* nonlinear file mapping, saved PTE; unset:swap */
 #define _PAGE_PROTNONE	0x010	/* if the user mapped it with PROT_NONE;
 				   pte_present gives true */
+#define _PAGE_FILE_PROTNONE	0x100	/* indicate that the page is remapped
+					   with PROT_NONE - this is different
+					   from _PAGE_PROTNONE as no page is
+					   held here, so pte_present() is false
+					   */
+
+/* Extracts _PAGE_RW and _PAGE_PROTNONE and replace the latter with
+ * _PAGE_FILE_PROTNONE. */
+#define pgprot_access_bits(prot) \
+	((pgprot_val(prot) & _PAGE_RW) | \
+	 bitmask_trans(pgprot_val(prot), _PAGE_PROTNONE, _PAGE_FILE_PROTNONE))
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
 #include "asm/pgtable-3level.h"
@@ -32,6 +44,14 @@ #else
 #include "asm/pgtable-2level.h"
 #endif
 
+#define pte_to_pgprot(pte) \
+	__pgprot((__pte_low(pte) & (_PAGE_RW|_PAGE_PROTNONE)))
+
+#define pte_file_to_pgprot(pte) \
+	__pgprot((__pte_low(pte) & _PAGE_RW) | _PAGE_ACCESSED | \
+		((__pte_low(pte) & _PAGE_FILE_PROTNONE) ? _PAGE_PROTNONE : \
+			(_PAGE_USER | _PAGE_PRESENT)))
+
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
 extern void *um_virt_to_phys(struct task_struct *task, unsigned long virt,
@@ -410,6 +430,7 @@ #define __swp_entry_to_pte(x)		((pte_t) 
 
 #define kern_addr_valid(addr) (1)
 
+#define __HAVE_ARCH_PTE_TO_PGPROT
 #include <asm-generic/pgtable.h>
 
 #include <asm-generic/pgtable-nopud.h>
diff --git a/include/asm-x86_64/pgtable.h b/include/asm-x86_64/pgtable.h
index a31ab4e..566bef7 100644
--- a/include/asm-x86_64/pgtable.h
+++ b/include/asm-x86_64/pgtable.h
@@ -7,7 +7,7 @@ #define _X86_64_PGTABLE_H
  */
 #include <asm/processor.h>
 #include <asm/fixmap.h>
-#include <asm/bitops.h>
+#include <linux/bitops.h>
 #include <linux/threads.h>
 #include <asm/pda.h>
 
@@ -151,6 +151,7 @@ #define _PAGE_BIT_ACCESSED	5
 #define _PAGE_BIT_DIRTY		6
 #define _PAGE_BIT_PSE		7	/* 4 MB (or 2MB) page */
 #define _PAGE_BIT_GLOBAL	8	/* Global TLB entry PPro+ */
+#define _PAGE_BIT_FILE_PROTNONE 8
 #define _PAGE_BIT_NX           63       /* No execute: only valid after cpuid check */
 
 #define _PAGE_PRESENT	0x001
@@ -165,6 +166,12 @@ #define _PAGE_FILE	0x040	/* nonlinear fi
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry */
 
 #define _PAGE_PROTNONE	0x080	/* If not present */
+#define _PAGE_FILE_PROTNONE	0x100	/* indicate that the page is remapped
+					   with PROT_NONE - this is different
+					   from _PAGE_PROTNONE as no page is
+					   held here, so pte_present() is false
+					   */
+
 #define _PAGE_NX        (1UL<<_PAGE_BIT_NX)
 
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)
@@ -354,9 +361,26 @@ #define pfn_pmd(nr,prot) (__pmd(((nr) <<
 #define pmd_pfn(x)  ((pmd_val(x) & __PHYSICAL_MASK) >> PAGE_SHIFT)
 
 #define pte_to_pgoff(pte) ((pte_val(pte) & PHYSICAL_PAGE_MASK) >> PAGE_SHIFT)
-#define pgoff_to_pte(off) ((pte_t) { ((off) << PAGE_SHIFT) | _PAGE_FILE })
 #define PTE_FILE_MAX_BITS __PHYSICAL_MASK_SHIFT
 
+#define pte_to_pgprot(pte) \
+	__pgprot((pte_val(pte) & (_PAGE_RW|_PAGE_PROTNONE)))
+
+#define pte_file_to_pgprot(pte) \
+	__pgprot((pte_val(pte) & _PAGE_RW) | _PAGE_ACCESSED | \
+		((pte_val(pte) & _PAGE_FILE_PROTNONE) ? _PAGE_PROTNONE : \
+			(_PAGE_USER | _PAGE_PRESENT)))
+
+/* Extracts _PAGE_RW and _PAGE_PROTNONE and replace the latter with
+ * _PAGE_FILE_PROTNONE. */
+#define pgprot_access_bits(prot) \
+	((pgprot_val(prot) & _PAGE_RW) | \
+	 bitmask_trans(pgprot_val(prot), _PAGE_PROTNONE, _PAGE_FILE_PROTNONE))
+
+#define pgoff_prot_to_pte(off, prot) \
+	((pte_t) { _PAGE_FILE | pgprot_access_bits(prot) | ((off) << PAGE_SHIFT) })
+
+
 /* PTE - Level 1 access. */
 
 /* page, protection -> pte */
@@ -448,6 +472,7 @@ #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTE_SAME
+#define __HAVE_ARCH_PTE_TO_PGPROT
 #include <asm-generic/pgtable.h>
 
 #endif /* _X86_64_PGTABLE_H */
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
