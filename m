Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbWHALML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbWHALML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbWHALMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:12:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8413 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932654AbWHALGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:06:07 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 16/33] x86_64: Assembly safe page.h and pgtable.h
Date: Tue,  1 Aug 2006 05:03:31 -0600
Message-Id: <115443023860-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes pgtable.h and page.h safe to include
in assembly files like head.S.  Allowing us to use
symbolic constants instead of hard coded numbers when
refering to the page tables.

This patch copies asm-sparc64/const.h to asm-x86_64 to
get a definition of _AC() a very convinient macro that
allows us to force the type when we are compiling the
code in C and to drop all of the type information when
we are using the constant in assembly.  Previously this
was done with multiple definition of the same constant.
const.h was modified slightly so that it works when given
CONFIG options as arguments.

This patch adds #ifndef __ASSEMBLY__ ... #endif
and _AC(1,UL) where appropriate so the assembler won't
choke on the header files.  Otherwise nothing
should have changed.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/asm-x86_64/const.h   |   20 ++++++++++++++++++++
 include/asm-x86_64/page.h    |   34 +++++++++++++---------------------
 include/asm-x86_64/pgtable.h |   33 +++++++++++++++++++++------------
 3 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/include/asm-x86_64/const.h b/include/asm-x86_64/const.h
new file mode 100644
index 0000000..54fb08f
--- /dev/null
+++ b/include/asm-x86_64/const.h
@@ -0,0 +1,20 @@
+/* const.h: Macros for dealing with constants.  */
+
+#ifndef _X86_64_CONST_H
+#define _X86_64_CONST_H
+
+/* Some constant macros are used in both assembler and
+ * C code.  Therefore we cannot annotate them always with
+ * 'UL' and other type specificers unilaterally.  We
+ * use the following macros to deal with this.
+ */
+
+#ifdef __ASSEMBLY__
+#define _AC(X,Y)	X
+#else
+#define __AC(X,Y)	(X##Y)
+#define _AC(X,Y)	__AC(X,Y)
+#endif
+
+
+#endif /* !(_X86_64_CONST_H) */
diff --git a/include/asm-x86_64/page.h b/include/asm-x86_64/page.h
index 10f3461..f030260 100644
--- a/include/asm-x86_64/page.h
+++ b/include/asm-x86_64/page.h
@@ -1,14 +1,11 @@
 #ifndef _X86_64_PAGE_H
 #define _X86_64_PAGE_H
 
+#include <asm/const.h>
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
-#ifdef __ASSEMBLY__
-#define PAGE_SIZE	(0x1 << PAGE_SHIFT)
-#else
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#endif
+#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 #define PHYSICAL_PAGE_MASK	(~(PAGE_SIZE-1) & __PHYSICAL_MASK)
 
@@ -33,10 +30,10 @@ #define MCE_STACK 5
 #define N_EXCEPTION_STACKS 5  /* hw limit: 7 */
 
 #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
-#define LARGE_PAGE_SIZE (1UL << PMD_SHIFT)
+#define LARGE_PAGE_SIZE (_AC(1,UL) << PMD_SHIFT)
 
 #define HPAGE_SHIFT PMD_SHIFT
-#define HPAGE_SIZE	((1UL) << HPAGE_SHIFT)
+#define HPAGE_SIZE	(_AC(1,UL) << HPAGE_SHIFT)
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 
@@ -76,29 +73,24 @@ #define __pud(x) ((pud_t) { (x) } )
 #define __pgd(x) ((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-#define __PHYSICAL_START	((unsigned long)CONFIG_PHYSICAL_START)
-#define __START_KERNEL		(__START_KERNEL_map + __PHYSICAL_START)
-#define __START_KERNEL_map	0xffffffff80000000UL
-#define __PAGE_OFFSET           0xffff810000000000UL
+#endif /* !__ASSEMBLY__ */
 
-#else
-#define __PHYSICAL_START	CONFIG_PHYSICAL_START
+#define __PHYSICAL_START	_AC(CONFIG_PHYSICAL_START,UL)
 #define __START_KERNEL		(__START_KERNEL_map + __PHYSICAL_START)
-#define __START_KERNEL_map	0xffffffff80000000
-#define __PAGE_OFFSET           0xffff810000000000
-#endif /* !__ASSEMBLY__ */
+#define __START_KERNEL_map	_AC(0xffffffff80000000,UL)
+#define __PAGE_OFFSET           _AC(0xffff810000000000,UL)
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
 /* See Documentation/x86_64/mm.txt for a description of the memory map. */
 #define __PHYSICAL_MASK_SHIFT	46
-#define __PHYSICAL_MASK		((1UL << __PHYSICAL_MASK_SHIFT) - 1)
+#define __PHYSICAL_MASK		((_AC(1,UL) << __PHYSICAL_MASK_SHIFT) - 1)
 #define __VIRTUAL_MASK_SHIFT	48
-#define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
+#define __VIRTUAL_MASK		((_AC(1,UL) << __VIRTUAL_MASK_SHIFT) - 1)
 
-#define KERNEL_TEXT_SIZE  (40UL*1024*1024)
-#define KERNEL_TEXT_START 0xffffffff80000000UL 
+#define KERNEL_TEXT_SIZE  (_AC(40,UL)*1024*1024)
+#define KERNEL_TEXT_START _AC(0xffffffff80000000,UL)
 
 #ifndef __ASSEMBLY__
 
@@ -106,7 +98,7 @@ #include <asm/bug.h>
 
 #endif /* __ASSEMBLY__ */
 
-#define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
+#define PAGE_OFFSET		__PAGE_OFFSET
 
 /* Note: __pa(&symbol_visible_to_c) should be always replaced with __pa_symbol.
    Otherwise you risk miscompilation. */ 
diff --git a/include/asm-x86_64/pgtable.h b/include/asm-x86_64/pgtable.h
index a31ab4e..211a2ca 100644
--- a/include/asm-x86_64/pgtable.h
+++ b/include/asm-x86_64/pgtable.h
@@ -1,6 +1,9 @@
 #ifndef _X86_64_PGTABLE_H
 #define _X86_64_PGTABLE_H
 
+#include <asm/const.h>
+#ifndef __ASSEMBLY__
+
 /*
  * This file contains the functions and defines necessary to modify and use
  * the x86-64 page table tree.
@@ -34,6 +37,8 @@ extern unsigned long pgkern_mask;
 extern unsigned long empty_zero_page[PAGE_SIZE/sizeof(unsigned long)];
 #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
 
+#endif /* !__ASSEMBLY__ */
+
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
  */
@@ -58,6 +63,8 @@ #define PTRS_PER_PMD	512
  */
 #define PTRS_PER_PTE	512
 
+#ifndef __ASSEMBLY__
+
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %p(%016lx).\n", __FILE__, __LINE__, &(e), pte_val(e))
 #define pmd_ERROR(e) \
@@ -124,22 +131,23 @@ #define pte_same(a, b)		((a).pte == (b).
 
 #define pte_pgprot(a)	(__pgprot((a).pte & ~PHYSICAL_PAGE_MASK))
 
-#define PMD_SIZE	(1UL << PMD_SHIFT)
+#endif /* !__ASSEMBLY__ */
+
+#define PMD_SIZE	(_AC(1,UL) << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
-#define PUD_SIZE	(1UL << PUD_SHIFT)
+#define PUD_SIZE	(_AC(1,UL) << PUD_SHIFT)
 #define PUD_MASK	(~(PUD_SIZE-1))
-#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
+#define PGDIR_SIZE	(_AC(1,UL) << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 #define USER_PTRS_PER_PGD	((TASK_SIZE-1)/PGDIR_SIZE+1)
 #define FIRST_USER_ADDRESS	0
 
-#ifndef __ASSEMBLY__
-#define MAXMEM		 0x3fffffffffffUL
-#define VMALLOC_START    0xffffc20000000000UL
-#define VMALLOC_END      0xffffe1ffffffffffUL
-#define MODULES_VADDR    0xffffffff88000000UL
-#define MODULES_END      0xfffffffffff00000UL
+#define MAXMEM		 _AC(0x3fffffffffff,UL)
+#define VMALLOC_START    _AC(0xffffc20000000000,UL)
+#define VMALLOC_END      _AC(0xffffe1ffffffffff,UL)
+#define MODULES_VADDR    _AC(0xffffffff88000000,UL)
+#define MODULES_END      _AC(0xfffffffffff00000,UL)
 #define MODULES_LEN   (MODULES_END - MODULES_VADDR)
 
 #define _PAGE_BIT_PRESENT	0
@@ -165,7 +173,7 @@ #define _PAGE_FILE	0x040	/* nonlinear fi
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry */
 
 #define _PAGE_PROTNONE	0x080	/* If not present */
-#define _PAGE_NX        (1UL<<_PAGE_BIT_NX)
+#define _PAGE_NX        (_AC(1,UL)<<_PAGE_BIT_NX)
 
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _KERNPG_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
@@ -227,6 +235,8 @@ #define __S101	PAGE_READONLY_EXEC
 #define __S110	PAGE_SHARED_EXEC
 #define __S111	PAGE_SHARED_EXEC
 
+#ifndef __ASSEMBLY__
+
 static inline unsigned long pgd_bad(pgd_t pgd) 
 { 
        unsigned long val = pgd_val(pgd);
@@ -418,8 +428,6 @@ extern spinlock_t pgd_lock;
 extern struct page *pgd_list;
 void vmalloc_sync_all(void);
 
-#endif /* !__ASSEMBLY__ */
-
 extern int kern_addr_valid(unsigned long addr); 
 
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
@@ -449,5 +457,6 @@ #define __HAVE_ARCH_PTEP_GET_AND_CLEAR_F
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTE_SAME
 #include <asm-generic/pgtable.h>
+#endif /* !__ASSEMBLY__ */
 
 #endif /* _X86_64_PGTABLE_H */
-- 
1.4.2.rc2.g5209e

