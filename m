Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUCKTKC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUCKTKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:10:02 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:6096 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S261479AbUCKTJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:09:05 -0500
Date: Thu, 11 Mar 2004 20:08:52 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 bits for remap-file-pages-prot.
Message-ID: <20040311190852.GA6887@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
I tried 2.6.4-mm1 and found that it wouldn't even compile because
of the remap-file-pages-prot changes. After some bit moving in the
definition of the s390 ptes I got it to work. Please add to -mm
and send it with the remap-file-pages-prot patch when it goes 
into the mainline.

blue skies,
  Martin.

---
s390 memory management changes for remap-file-pages-prot patch:
  - Add pgoff_prot_to_pte/pte_to_pgprot, remove pgoff_to_pte (required for
    'prot' parameteter in shared-writeable mappings).
  - Handle VM_FAULT_SIGSEGV from handle_mm_fault in do_exception.
  - Add sys_remap_file_pages system call.
  - Add MAP_INHERIT.

diffstat:
 arch/s390/kernel/compat_wrapper.S |   10 +++
 arch/s390/kernel/syscalls.S       |    1 
 arch/s390/mm/fault.c              |    2 
 include/asm-s390/mman.h           |    1 
 include/asm-s390/pgtable.h        |  122 +++++++++++++++++++++++---------------
 include/asm-s390/unistd.h         |    3 
 6 files changed, 90 insertions(+), 49 deletions(-)

diff -urN linux-2.6-orig/arch/s390/kernel/compat_wrapper.S linux-2.6/arch/s390/kernel/compat_wrapper.S
--- linux-2.6-orig/arch/s390/kernel/compat_wrapper.S	Thu Mar 11 15:09:52 2004
+++ linux-2.6/arch/s390/kernel/compat_wrapper.S	Thu Mar 11 15:08:19 2004
@@ -1338,3 +1338,13 @@
 	llgtr	%r3,%r3			# struct iocb *
 	llgtr	%r4,%r4			# struct io_event *
 	jg	sys_io_cancel
+
+	.globl  sys32_remap_file_pages_wrapper
+sys32_remap_file_pages_wrapper:
+	llgfr	%r2,%r2			# unsigned long
+	llgfr	%r3,%r3			# unsigned long
+	llgfr	%r4,%r4			# unsigned long
+	llgfr	%r5,%r5			# unsigned long
+	llgfr	%r6,%r6			# unsigned long
+	jg	sys_remap_file_pages
+
diff -urN linux-2.6-orig/arch/s390/kernel/syscalls.S linux-2.6/arch/s390/kernel/syscalls.S
--- linux-2.6-orig/arch/s390/kernel/syscalls.S	Thu Mar 11 15:09:52 2004
+++ linux-2.6/arch/s390/kernel/syscalls.S	Thu Mar 11 15:08:19 2004
@@ -273,3 +273,4 @@
 SYSCALL(sys_clock_nanosleep,sys_clock_nanosleep,sys32_clock_nanosleep_wrapper)
 NI_SYSCALL							/* reserved for vserver */
 SYSCALL(s390_fadvise64_64,sys_ni_syscall,sys32_fadvise64_64_wrapper)
+SYSCALL(sys_remap_file_pages,sys_remap_file_pages,sys32_remap_file_pages_wrapper)
diff -urN linux-2.6-orig/arch/s390/mm/fault.c linux-2.6/arch/s390/mm/fault.c
--- linux-2.6-orig/arch/s390/mm/fault.c	Thu Mar 11 15:09:52 2004
+++ linux-2.6/arch/s390/mm/fault.c	Thu Mar 11 15:08:19 2004
@@ -256,6 +256,8 @@
 		goto do_sigbus;
 	case VM_FAULT_OOM:
 		goto out_of_memory;
+	case VM_FAULT_SIGSEGV:
+		goto bad_area;
 	default:
 		BUG();
 	}
diff -urN linux-2.6-orig/include/asm-s390/mman.h linux-2.6/include/asm-s390/mman.h
--- linux-2.6-orig/include/asm-s390/mman.h	Thu Mar 11 15:09:52 2004
+++ linux-2.6/include/asm-s390/mman.h	Thu Mar 11 15:08:19 2004
@@ -30,6 +30,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_INHERIT	0x20000		/* inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -urN linux-2.6-orig/include/asm-s390/pgtable.h linux-2.6/include/asm-s390/pgtable.h
--- linux-2.6-orig/include/asm-s390/pgtable.h	Thu Mar 11 15:09:52 2004
+++ linux-2.6/include/asm-s390/pgtable.h	Thu Mar 11 15:10:13 2004
@@ -209,16 +209,41 @@
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
 
@@ -279,13 +304,11 @@
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
@@ -293,21 +316,21 @@
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
 
@@ -373,18 +396,17 @@
 
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
@@ -465,8 +487,8 @@
 
 extern inline pte_t pte_wrprotect(pte_t pte)
 {
-	/* Do not clobber _PAGE_INVALID_NONE pages!  */
-	if (!(pte_val(pte) & _PAGE_INVALID))
+	/* Do not clobber PROT_NONE pages!  */
+	if (!_PTE_IS_NONE(pte))
 		pte_val(pte) |= _PAGE_RO;
 	return pte;
 }
@@ -719,14 +741,14 @@
  * information in the lowcore.
  * Bit 21 and bit 22 are the page invalid bit and the page protection
  * bit. We set both to indicate a swapped page.
- * Bit 31 is used as the software page present bit. If a page is
- * swapped this obviously has to be zero.
- * This leaves the bits 1-19 and bits 24-30 to store type and offset.
- * We use the 7 bits from 24-30 for the type and the 19 bits from 1-19
+ * Bit 30 and 31 are used to distinguish the different page types. For
+ * a swapped page these bits need to be zero.
+ * This leaves the bits 1-19 and bits 24-29 to store type and offset.
+ * We use the 6 bits from 24-29 for the type and the 19 bits from 1-19
  * for the offset.
- * 0|     offset      |0110|type |0
- * 00000000001111111111222222222233
- * 01234567890123456789012345678901
+ * 0|     offset        |0110| type |00|
+ * 0 0000000001111111111 2222 222222 33
+ * 0 1234567890123456789 0123 456789 01
  *
  * 64 bit swap entry format:
  * A page-table entry has some bits we have to treat in a special way.
@@ -736,19 +758,19 @@
  * information in the lowcore.
  * Bit 53 and bit 54 are the page invalid bit and the page protection
  * bit. We set both to indicate a swapped page.
- * Bit 63 is used as the software page present bit. If a page is
- * swapped this obviously has to be zero.
- * This leaves the bits 0-51 and bits 56-62 to store type and offset.
- * We use the 7 bits from 56-62 for the type and the 52 bits from 0-51
+ * Bit 62 and 63 are used to distinguish the different page types. For
+ * a swapped page these bits need to be zero.
+ * This leaves the bits 0-51 and bits 56-61 to store type and offset.
+ * We use the 6 bits from 56-61 for the type and the 52 bits from 0-51
  * for the offset.
- * |                     offset                       |0110|type |0
- * 0000000000111111111122222222223333333333444444444455555555556666
- * 0123456789012345678901234567890123456789012345678901234567890123
+ * |                      offset                        |0110| type |00|
+ *  0000000000111111111122222222223333333333444444444455 5555 555566 66
+ *  0123456789012345678901234567890123456789012345678901 2345 678901 23
  */
 extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 {
 	pte_t pte;
-	pte_val(pte) = (type << 1) | (offset << 12) | _PAGE_INVALID_SWAP;
+	pte_val(pte) = (type << 2) | (offset << 12) | _PAGE_INVALID_SWAP;
 #ifndef __s390x__
 	BUG_ON((pte_val(pte) & 0x80000901) != 0);
 #else /* __s390x__ */
@@ -757,7 +779,7 @@
 	return pte;
 }
 
-#define __swp_type(entry)	(((entry).val >> 1) & 0x3f)
+#define __swp_type(entry)	(((entry).val >> 2) & 0x3f)
 #define __swp_offset(entry)	((entry).val >> 12)
 #define __swp_entry(type,offset) ((swp_entry_t) { pte_val(mk_swap_pte((type),(offset))) })
 
@@ -767,17 +789,21 @@
 typedef pte_t *pte_addr_t;
 
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
 
diff -urN linux-2.6-orig/include/asm-s390/unistd.h linux-2.6/include/asm-s390/unistd.h
--- linux-2.6-orig/include/asm-s390/unistd.h	Thu Mar 11 15:09:52 2004
+++ linux-2.6/include/asm-s390/unistd.h	Thu Mar 11 15:08:19 2004
@@ -260,8 +260,9 @@
  * Number 263 is reserved for vserver
  */
 #define __NR_fadvise64_64	264
+#define __NR_remap_file_pages	265
 
-#define NR_syscalls 265
+#define NR_syscalls 266
 
 /* 
  * There are some system calls that are not present on 64 bit, some
