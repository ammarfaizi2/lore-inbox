Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbULPNFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbULPNFh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 08:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbULPNFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 08:05:37 -0500
Received: from mail.renesas.com ([202.234.163.13]:54748 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262662AbULPM7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 07:59:49 -0500
Date: Thu, 16 Dec 2004 21:59:38 +0900 (JST)
Message-Id: <20041216.215938.27800182.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Clean up include/asm-m32r/pgtable.h
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041216.214100.278750319.takata.hirokazu@renesas.com>
References: <20041216.214100.278750319.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hirokazu Takata <takata@linux-m32r.org>
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Fix not to execute noexec pages (0/3)
Date: Thu, 16 Dec 2004 21:41:00 +0900 (JST)
> Hello,
> 
> Here is a patchset to fix a bug of m32r kernel 2.6.9 that a code on
> a noexec page can be executed incorrectly.
> 
> For good security, stack region should be non-executable. 
> This fix is also needed to achieve non-executable stack.
> 
> Please apply this to 2.6.10 kernel if possible.
> 
> Thank you.
> 
> Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
> ---
> 
> [PATCH 2.6.10-rc3-mm1] m32r: Cause SIGSEGV for nonexec page execution (1/3)
> - Cause a segmentation fault for an illegal execution of a code on
>   non-executable memory page.
> 
> [PATCH 2.6.10-rc3-mm1] m32r: Don't encode ACE_INSTRUCTION in address (2/3)
> - To be more comprehensive, keep ACE_INSTRUCTION (access exception 
>   on instruction execution) information in thread_info->flags,
>   instead of encoding it into address parameter.
> 
> [PATCH 2.6.10-rc3-mm1] m32r: Clean up arch/m32r/mm/fault.c (3/3)
> - Fix a typo: ACE_USEMODE --> ACE_USERMODE.
> - Update copyright statement, and so on.
> 

Sorry, this patchset includes one more patch.


[PATCH 2.6.10-rc3-mm1] m32r: Clean up include/asm-m32r/pgtable.h
- Change PAGE_*_X to PAGE_*_EXEC for good readability.
- Add #include __KERNEL__
- Change __inline__ to inline for the __KERNEL__ portion.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/pgtable.h |  168 ++++++++++++++++++---------------------------
 1 files changed, 70 insertions(+), 98 deletions(-)


diff -ruNp a/include/asm-m32r/pgtable.h b/include/asm-m32r/pgtable.h
--- a/include/asm-m32r/pgtable.h	2004-12-16 15:11:25.000000000 +0900
+++ b/include/asm-m32r/pgtable.h	2004-12-16 15:11:56.000000000 +0900
@@ -1,8 +1,7 @@
 #ifndef _ASM_M32R_PGTABLE_H
 #define _ASM_M32R_PGTABLE_H
 
-/* $Id$ */
-
+#ifdef __KERNEL__
 /*
  * The Linux memory management assumes a three-level page table setup. On
  * the M32R, we use that, but "fold" the mid level into the top-level page
@@ -38,11 +37,6 @@ extern unsigned long empty_zero_page[102
 
 #endif /* !__ASSEMBLY__ */
 
-/*
- * The Linux x86 paging architecture is 'compile-time dual-mode', it
- * implements both the traditional 2-level x86 page tables and the
- * newer 3-level PAE-mode page tables.
- */
 #ifndef __ASSEMBLY__
 #include <asm/pgtable-2level.h>
 #endif
@@ -69,14 +63,6 @@ extern unsigned long empty_zero_page[102
 #define VMALLOC_END		KSEG3
 
 /*
- * The 4MB page is guessing..  Detailed in the infamous "Chapter H"
- * of the Pentium details, but assuming intel did the straightforward
- * thing, this bit set in the page directory entry just means that
- * the page directory entry points directly to a 4MB-aligned block of
- * memory.
- */
-
-/*
  *     M32R TLB format
  *
  *     [0]    [1:19]           [20:23]       [24:31]
@@ -89,43 +75,31 @@ extern unsigned long empty_zero_page[102
  *                                     RWX
  */
 
-#define _PAGE_BIT_DIRTY		0	/* software */
+#define _PAGE_BIT_DIRTY		0	/* software: page changed */
 #define _PAGE_BIT_FILE		0	/* when !present: nonlinear file
 					   mapping */
-#define _PAGE_BIT_PRESENT	1	/* Valid */
+#define _PAGE_BIT_PRESENT	1	/* Valid: page is valid */
 #define _PAGE_BIT_GLOBAL	2	/* Global */
 #define _PAGE_BIT_LARGE		3	/* Large */
 #define _PAGE_BIT_EXEC		4	/* Execute */
 #define _PAGE_BIT_WRITE		5	/* Write */
 #define _PAGE_BIT_READ		6	/* Read */
 #define _PAGE_BIT_NONCACHABLE	7	/* Non cachable */
-#define _PAGE_BIT_USER		8	/* software */
-#define _PAGE_BIT_ACCESSED	9	/* software */
-
-#define _PAGE_DIRTY	\
-	(1UL << _PAGE_BIT_DIRTY)	/* software : page changed */
-#define _PAGE_FILE	\
-	(1UL << _PAGE_BIT_FILE)		/* when !present: nonlinear file
-					   mapping */
-#define _PAGE_PRESENT	\
-	(1UL << _PAGE_BIT_PRESENT)	/* Valid : Page is Valid */
-#define _PAGE_GLOBAL	\
-	(1UL << _PAGE_BIT_GLOBAL)	/* Global */
-#define _PAGE_LARGE	\
-	(1UL << _PAGE_BIT_LARGE)	/* Large */
-#define _PAGE_EXEC	\
-	(1UL << _PAGE_BIT_EXEC)		/* Execute */
-#define _PAGE_WRITE	\
-	(1UL << _PAGE_BIT_WRITE)	/* Write */
-#define _PAGE_READ	\
-	(1UL << _PAGE_BIT_READ)		/* Read */
-#define _PAGE_NONCACHABLE	\
-	(1UL<<_PAGE_BIT_NONCACHABLE)	/* Non cachable */
-#define _PAGE_USER	\
-	(1UL << _PAGE_BIT_USER)		/* software : user space access
+#define _PAGE_BIT_USER		8	/* software: user space access
 					   allowed */
-#define _PAGE_ACCESSED	\
-	(1UL << _PAGE_BIT_ACCESSED)	/* software : page referenced */
+#define _PAGE_BIT_ACCESSED	9	/* software: page referenced */
+
+#define _PAGE_DIRTY		(1UL << _PAGE_BIT_DIRTY)
+#define _PAGE_FILE		(1UL << _PAGE_BIT_FILE)
+#define _PAGE_PRESENT		(1UL << _PAGE_BIT_PRESENT)
+#define _PAGE_GLOBAL		(1UL << _PAGE_BIT_GLOBAL)
+#define _PAGE_LARGE		(1UL << _PAGE_BIT_LARGE)
+#define _PAGE_EXEC		(1UL << _PAGE_BIT_EXEC)	
+#define _PAGE_WRITE		(1UL << _PAGE_BIT_WRITE)
+#define _PAGE_READ		(1UL << _PAGE_BIT_READ)	
+#define _PAGE_NONCACHABLE	(1UL << _PAGE_BIT_NONCACHABLE)
+#define _PAGE_USER		(1UL << _PAGE_BIT_USER)
+#define _PAGE_ACCESSED		(1UL << _PAGE_BIT_ACCESSED)
 
 #define _PAGE_TABLE	\
 	( _PAGE_PRESENT | _PAGE_WRITE | _PAGE_READ | _PAGE_USER \
@@ -142,17 +116,17 @@ extern unsigned long empty_zero_page[102
 #define PAGE_SHARED	\
 	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | _PAGE_READ | _PAGE_USER \
 		| _PAGE_ACCESSED)
-#define PAGE_SHARED_X	\
+#define PAGE_SHARED_EXEC \
 	__pgprot(_PAGE_PRESENT | _PAGE_EXEC | _PAGE_WRITE | _PAGE_READ \
 		| _PAGE_USER | _PAGE_ACCESSED)
 #define PAGE_COPY	\
 	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_USER | _PAGE_ACCESSED)
-#define PAGE_COPY_X	\
+#define PAGE_COPY_EXEC	\
 	__pgprot(_PAGE_PRESENT | _PAGE_EXEC | _PAGE_READ | _PAGE_USER \
 		| _PAGE_ACCESSED)
 #define PAGE_READONLY	\
 	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_USER | _PAGE_ACCESSED)
-#define PAGE_READONLY_X	\
+#define PAGE_READONLY_EXEC \
 	__pgprot(_PAGE_PRESENT | _PAGE_EXEC | _PAGE_READ | _PAGE_USER \
 		| _PAGE_ACCESSED)
 
@@ -169,42 +143,37 @@ extern unsigned long empty_zero_page[102
 #define PAGE_KERNEL_NOCACHE	MAKE_GLOBAL(__PAGE_KERNEL_NOCACHE)
 
 #else
-#define PAGE_NONE               __pgprot(0)
-#define PAGE_SHARED             __pgprot(0)
-#define PAGE_SHARED_X           __pgprot(0)
-#define PAGE_COPY               __pgprot(0)
-#define PAGE_COPY_X             __pgprot(0)
-#define PAGE_READONLY           __pgprot(0)
-#define PAGE_READONLY_X         __pgprot(0)
-
-#define PAGE_KERNEL             __pgprot(0)
-#define PAGE_KERNEL_RO          __pgprot(0)
-#define PAGE_KERNEL_NOCACHE     __pgprot(0)
+#define PAGE_NONE		__pgprot(0)
+#define PAGE_SHARED		__pgprot(0)
+#define PAGE_SHARED_EXEC	__pgprot(0)
+#define PAGE_COPY		__pgprot(0)
+#define PAGE_COPY_EXEC		__pgprot(0)
+#define PAGE_READONLY		__pgprot(0)
+#define PAGE_READONLY_EXEC	__pgprot(0)
+
+#define PAGE_KERNEL		__pgprot(0)
+#define PAGE_KERNEL_RO		__pgprot(0)
+#define PAGE_KERNEL_NOCACHE	__pgprot(0)
 #endif /* CONFIG_MMU */
 
-/*
- * The i386 can't do page protection for execute, and considers that
- * the same are read. Also, write permissions imply read permissions.
- * This is the closest we can get..
- */
 	/* xwr */
 #define __P000	PAGE_NONE
 #define __P001	PAGE_READONLY
 #define __P010	PAGE_COPY
 #define __P011	PAGE_COPY
-#define __P100	PAGE_READONLY_X
-#define __P101	PAGE_READONLY_X
-#define __P110	PAGE_COPY_X
-#define __P111	PAGE_COPY_X
+#define __P100	PAGE_READONLY_EXEC
+#define __P101	PAGE_READONLY_EXEC
+#define __P110	PAGE_COPY_EXEC
+#define __P111	PAGE_COPY_EXEC
 
 #define __S000	PAGE_NONE
 #define __S001	PAGE_READONLY
 #define __S010	PAGE_SHARED
 #define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY_X
-#define __S101	PAGE_READONLY_X
-#define __S110	PAGE_SHARED_X
-#define __S111	PAGE_SHARED_X
+#define __S100	PAGE_READONLY_EXEC
+#define __S101	PAGE_READONLY_EXEC
+#define __S110	PAGE_SHARED_EXEC
+#define __S111	PAGE_SHARED_EXEC
 
 /* page table for 0-4MB for everybody */
 
@@ -223,32 +192,32 @@ extern unsigned long empty_zero_page[102
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
-static __inline__ int pte_user(pte_t pte)
+static inline int pte_user(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_USER;
 }
 
-static __inline__ int pte_read(pte_t pte)
+static inline int pte_read(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_READ;
 }
 
-static __inline__ int pte_exec(pte_t pte)
+static inline int pte_exec(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_EXEC;
 }
 
-static __inline__ int pte_dirty(pte_t pte)
+static inline int pte_dirty(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_DIRTY;
 }
 
-static __inline__ int pte_young(pte_t pte)
+static inline int pte_young(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_ACCESSED;
 }
 
-static __inline__ int pte_write(pte_t pte)
+static inline int pte_write(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_WRITE;
 }
@@ -256,85 +225,87 @@ static __inline__ int pte_write(pte_t pt
 /*
  * The following only works if pte_present() is not true.
  */
-static __inline__ int pte_file(pte_t pte)
+static inline int pte_file(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_FILE;
 }
 
-static __inline__ pte_t pte_rdprotect(pte_t pte)
+static inline pte_t pte_rdprotect(pte_t pte)
 {
 	pte_val(pte) &= ~_PAGE_READ;
 	return pte;
 }
 
-static __inline__ pte_t pte_exprotect(pte_t pte)
+static inline pte_t pte_exprotect(pte_t pte)
 {
 	pte_val(pte) &= ~_PAGE_EXEC;
 	return pte;
 }
 
-static __inline__ pte_t pte_mkclean(pte_t pte)
+static inline pte_t pte_mkclean(pte_t pte)
 {
 	pte_val(pte) &= ~_PAGE_DIRTY;
 	return pte;
 }
 
-static __inline__ pte_t pte_mkold(pte_t pte)
+static inline pte_t pte_mkold(pte_t pte)
 {
-	pte_val(pte) &= ~_PAGE_ACCESSED;return pte;}
+	pte_val(pte) &= ~_PAGE_ACCESSED;
+	return pte;
+}
 
-static __inline__ pte_t pte_wrprotect(pte_t pte)
+static inline pte_t pte_wrprotect(pte_t pte)
 {
 	pte_val(pte) &= ~_PAGE_WRITE;
 	return pte;
 }
 
-static __inline__ pte_t pte_mkread(pte_t pte)
+static inline pte_t pte_mkread(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_READ;
 	return pte;
 }
 
-static __inline__ pte_t pte_mkexec(pte_t pte)
+static inline pte_t pte_mkexec(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_EXEC;
 	return pte;
 }
 
-static __inline__ pte_t pte_mkdirty(pte_t pte)
+static inline pte_t pte_mkdirty(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_DIRTY;
 	return pte;
 }
 
-static __inline__ pte_t pte_mkyoung(pte_t pte)
+static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_ACCESSED;
 	return pte;
 }
 
-static __inline__ pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_WRITE;
 	return pte;
 }
 
-static __inline__  int ptep_test_and_clear_dirty(pte_t *ptep)
+static inline  int ptep_test_and_clear_dirty(pte_t *ptep)
 {
 	return test_and_clear_bit(_PAGE_BIT_DIRTY, ptep);
 }
 
-static __inline__  int ptep_test_and_clear_young(pte_t *ptep)
+static inline  int ptep_test_and_clear_young(pte_t *ptep)
 {
 	return test_and_clear_bit(_PAGE_BIT_ACCESSED, ptep);
 }
 
-static __inline__ void ptep_set_wrprotect(pte_t *ptep)
+static inline void ptep_set_wrprotect(pte_t *ptep)
 {
 	clear_bit(_PAGE_BIT_WRITE, ptep);
 }
 
-static __inline__ void ptep_mkdirty(pte_t *ptep)
+static inline void ptep_mkdirty(pte_t *ptep)
 {
 	set_bit(_PAGE_BIT_DIRTY, ptep);
 }
@@ -342,7 +313,7 @@ static __inline__ void ptep_mkdirty(pte_
 /*
  * Macro and implementation to make a page protection as uncachable.
  */
-static __inline__ pgprot_t pgprot_noncached(pgprot_t _prot)
+static inline pgprot_t pgprot_noncached(pgprot_t _prot)
 {
 	unsigned long prot = pgprot_val(_prot);
 
@@ -358,7 +329,7 @@ static __inline__ pgprot_t pgprot_noncac
  */
 #define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), pgprot)
 
-static __inline__ pte_t pte_modify(pte_t pte, pgprot_t newprot)
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	set_pte(&pte, __pte((pte_val(pte) & _PAGE_CHG_MASK) \
 		| pgprot_val(newprot)));
@@ -373,7 +344,7 @@ static __inline__ pte_t pte_modify(pte_t
  * and a page entry and page directory to the page they refer to.
  */
 
-static __inline__ void pmd_set(pmd_t * pmdp, pte_t * ptep)
+static inline void pmd_set(pmd_t * pmdp, pte_t * ptep)
 {
 	pmd_val(*pmdp) = (((unsigned long) ptep) & PAGE_MASK);
 }
@@ -417,8 +388,8 @@ static __inline__ void pmd_set(pmd_t * p
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)	\
+	remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
@@ -430,5 +401,6 @@ static __inline__ void pmd_set(pmd_t * p
 
 #include <asm-generic/nopml4-pgtable.h>
 
-#endif /* _ASM_M32R_PGTABLE_H */
+#endif /* __KERNEL__ */
 
+#endif /* _ASM_M32R_PGTABLE_H */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
