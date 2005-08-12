Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVHLSEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVHLSEs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVHLSEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:04:47 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:56028 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S1750716AbVHLSEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:04:46 -0400
Subject: [patch 31/39] remap_file_pages protection support: s390 bits
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it,
       schwidefsky@de.ibm.com
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 19:32:53 +0200
Message-Id: <20050812173254.4263E24E812@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 memory management changes for remap-file-pages-prot patch:

- Add pgoff_prot_to_pte/pte_to_pgprot, remove pgoff_to_pte (required for
  'prot' parameteter in shared-writeable mappings).

- Handle VM_FAULT_SIGSEGV from handle_mm_fault in do_exception.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/s390/mm/fault.c       |    2 
 linux-2.6.git-paolo/include/asm-s390/pgtable.h |   90 ++++++++++++++++---------
 2 files changed, 60 insertions(+), 32 deletions(-)

diff -puN arch/s390/mm/fault.c~rfp-arch-s390 arch/s390/mm/fault.c
--- linux-2.6.git/arch/s390/mm/fault.c~rfp-arch-s390	2005-08-12 19:27:58.000000000 +0200
+++ linux-2.6.git-paolo/arch/s390/mm/fault.c	2005-08-12 19:27:58.000000000 +0200
@@ -260,6 +260,8 @@ survive:
 		goto do_sigbus;
 	case VM_FAULT_OOM:
 		goto out_of_memory;
+	case VM_FAULT_SIGSEGV:
+		goto bad_area;
 	default:
 		BUG();
 	}
diff -puN include/asm-s390/pgtable.h~rfp-arch-s390 include/asm-s390/pgtable.h
--- linux-2.6.git/include/asm-s390/pgtable.h~rfp-arch-s390	2005-08-12 19:27:58.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-s390/pgtable.h	2005-08-12 19:27:58.000000000 +0200
@@ -211,16 +211,41 @@ extern char empty_zero_page[PAGE_SIZE];
  * C  : changed bit
  */
 
-/* Hardware bits in the page table entry */
+/* Hardware bits in the page table entry. */
 #define _PAGE_RO        0x200          /* HW read-only                     */
 #define _PAGE_INVALID   0x400          /* HW invalid                       */
 
-/* Mask and four different kinds of invalid pages. */
-#define _PAGE_INVALID_MASK	0x601
+/* Software bits in the page table entry. */
+#define _PAGE_FILE	0x001
+#define _PAGE_PROTNONE	0x002
+
+/*
+ * We have 8 different page "types", two valid types and 6 invalid types
+ * (p = page address, o = swap offset, t = swap type, f = file offset):
+ *                     0 xxxxxxxxxxxxxxxxxxx 0IP0 yyyyyy NF
+ * valid rw:           0 <--------p--------> 0000 <--0-> 00
+ * valid ro:           0 <--------p--------> 0010 <--0-> 00
+ * invalid none:       0 <--------p--------> 0100 <--0-> 10
+ * invalid empty:      0 <--------0--------> 0100 <--0-> 00
+ * invalid swap:       0 <--------o--------> 0110 <--t-> 00
+ * invalid file rw:    0 <--------f--------> 0100 <--f-> 01
+ * invalid file ro:    0 <--------f--------> 0110 <--f-> 01
+ * invaild file none:  0 <--------f--------> 0100 <--f-> 11
+ *
+ * The format for 64 bit is almost identical, there isn't a leading zero
+ * and the number of bits in the page address part of the pte is 52 bits
+ * instead of 19.
+ */
+
 #define _PAGE_INVALID_EMPTY	0x400
-#define _PAGE_INVALID_NONE	0x401
 #define _PAGE_INVALID_SWAP	0x600
-#define _PAGE_INVALID_FILE	0x601
+#define _PAGE_INVALID_FILE	0x401
+
+#define _PTE_IS_VALID(__pte)	(!(pte_val(__pte) & _PAGE_INVALID))
+#define _PTE_IS_NONE(__pte)	((pte_val(__pte) & 0x603) == 0x402)
+#define _PTE_IS_EMPTY(__pte)	((pte_val(__pte) & 0x603) == 0x400)
+#define _PTE_IS_SWAP(__pte)	((pte_val(__pte) & 0x603) == 0x600)
+#define _PTE_IS_FILE(__pte)	((pte_val(__pte) & 0x401) == 0x401)
 
 #ifndef __s390x__
 
@@ -281,13 +306,11 @@ extern char empty_zero_page[PAGE_SIZE];
 /*
  * No mapping available
  */
-#define PAGE_NONE_SHARED  __pgprot(_PAGE_INVALID_NONE)
-#define PAGE_NONE_PRIVATE __pgprot(_PAGE_INVALID_NONE)
-#define PAGE_RO_SHARED	  __pgprot(_PAGE_RO)
-#define PAGE_RO_PRIVATE	  __pgprot(_PAGE_RO)
-#define PAGE_COPY	  __pgprot(_PAGE_RO)
-#define PAGE_SHARED	  __pgprot(0)
-#define PAGE_KERNEL	  __pgprot(0)
+#define PAGE_NONE	__pgprot(_PAGE_INVALID | _PAGE_PROTNONE)
+#define PAGE_READONLY	__pgprot(_PAGE_RO)
+#define PAGE_COPY	__pgprot(_PAGE_RO)
+#define PAGE_SHARED	__pgprot(0)
+#define PAGE_KERNEL	__pgprot(0)
 
 /*
  * The S390 can't do page protection for execute, and considers that the
@@ -295,21 +318,21 @@ extern char empty_zero_page[PAGE_SIZE];
  * the closest we can get..
  */
          /*xwr*/
-#define __P000  PAGE_NONE_PRIVATE
-#define __P001  PAGE_RO_PRIVATE
+#define __P000  PAGE_NONE
+#define __P001  PAGE_READONLY
 #define __P010  PAGE_COPY
 #define __P011  PAGE_COPY
-#define __P100  PAGE_RO_PRIVATE
-#define __P101  PAGE_RO_PRIVATE
+#define __P100  PAGE_READONLY
+#define __P101  PAGE_READONLY
 #define __P110  PAGE_COPY
 #define __P111  PAGE_COPY
 
-#define __S000  PAGE_NONE_SHARED
-#define __S001  PAGE_RO_SHARED
+#define __S000  PAGE_NONE
+#define __S001  PAGE_READONLY
 #define __S010  PAGE_SHARED
 #define __S011  PAGE_SHARED
-#define __S100  PAGE_RO_SHARED
-#define __S101  PAGE_RO_SHARED
+#define __S100  PAGE_READONLY
+#define __S101  PAGE_READONLY
 #define __S110  PAGE_SHARED
 #define __S111  PAGE_SHARED
 
@@ -376,18 +399,17 @@ extern inline int pmd_bad(pmd_t pmd)
 
 extern inline int pte_none(pte_t pte)
 {
-	return (pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_EMPTY;
+	return _PTE_IS_EMPTY(pte);
 }
 
 extern inline int pte_present(pte_t pte)
 {
-	return !(pte_val(pte) & _PAGE_INVALID) ||
-		(pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_NONE;
+	return _PTE_IS_VALID(pte) || _PTE_IS_NONE(pte);
 }
 
 extern inline int pte_file(pte_t pte)
 {
-	return (pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_FILE;
+	return _PTE_IS_FILE(pte);
 }
 
 #define pte_same(a,b)	(pte_val(a) == pte_val(b))
@@ -476,8 +498,8 @@ extern inline pte_t pte_modify(pte_t pte
 
 extern inline pte_t pte_wrprotect(pte_t pte)
 {
-	/* Do not clobber _PAGE_INVALID_NONE pages!  */
-	if (!(pte_val(pte) & _PAGE_INVALID))
+	/* Do not clobber PROT_NONE pages!  */
+	if (!_PTE_IS_NONE(pte))
 		pte_val(pte) |= _PAGE_RO;
 	return pte;
 }
@@ -774,17 +796,21 @@ extern inline pte_t mk_swap_pte(unsigned
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
 #ifndef __s390x__
-# define PTE_FILE_MAX_BITS	26
+# define PTE_FILE_MAX_BITS	25
 #else /* __s390x__ */
-# define PTE_FILE_MAX_BITS	59
+# define PTE_FILE_MAX_BITS	58
 #endif /* __s390x__ */
 
 #define pte_to_pgoff(__pte) \
-	((((__pte).pte >> 12) << 7) + (((__pte).pte >> 1) & 0x7f))
+	((((__pte).pte >> 12) << 6) + (((__pte).pte >> 2) & 0x3f))
+
+#define pte_to_pgprot(pte) \
+	__pgprot(pte_val(pte) & (_PAGE_RO | _PAGE_PROTNONE))
 
-#define pgoff_to_pte(__off) \
-	((pte_t) { ((((__off) & 0x7f) << 1) + (((__off) >> 7) << 12)) \
-		   | _PAGE_INVALID_FILE })
+#define pgoff_prot_to_pte(__off, __prot) \
+	((pte_t) { _PAGE_INVALID_FILE | \
+		((((__off) & 0x3f) << 2) + (((__off) >> 6) << 12)) | \
+		(pgprot_val(__prot) & (_PAGE_RO | _PAGE_PROTNONE)) })
 
 #endif /* !__ASSEMBLY__ */
 
_
