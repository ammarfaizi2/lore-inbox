Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbWHXXof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWHXXof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 19:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWHXXof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 19:44:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:61855 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030410AbWHXXod
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 19:44:33 -0400
Subject: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Thu, 24 Aug 2006 16:44:30 -0700
Message-Id: <20060824234430.6AC970F7@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All architectures currently explicitly define their page size.  In some
cases (ppc, parisc, ia64, sparc64) this size is somewhat configurable.

There several reimplementations of ways to make sure that PAGE_SIZE
is usable in assembly code, yet still somewhat type safe for use in
C code (as a UL type).  These are all very similar.  There are also a
number of macros based off of PAGE_SIZE/SHIFT which are duplicated
across architectures.

This patch unifies all of those definitions.  It defines PAGE_SIZE in
a single header which gets its definitions from Kconfig.  The new
Kconfig options mirror what used to be done with #ifdefs and
arch-specific Kconfig options.  The new Kconfig menu eliminates
the need for parisc, ia64, and sparc64 to have their own "choice"
menus for selecting page size.  The help text has been adapted from
these three architectures, but is now more generic.

This survives cross-compilation on arm, i386, x86_64, sparc64 and
ia64.

---

 threadalloc-dave/include/asm-generic/page_size.h       |   31 +++++++++
 threadalloc-dave/mm/Kconfig                            |   56 +++++++++++++++++
 threadalloc-dave/include/asm-xtensa/page.h             |   11 ---
 threadalloc-dave/include/asm-x86_64/page.h             |   12 ---
 threadalloc-dave/include/asm-v850/page.h               |   12 ---
 threadalloc-dave/include/asm-um/page.h                 |    9 --
 threadalloc-dave/include/asm-sparc64/page.h            |   19 -----
 threadalloc-dave/include/asm-sparc64/mmu.h             |    8 +-
 threadalloc-dave/include/asm-sparc/page.h              |   16 ----
 threadalloc-dave/include/asm-sh64/page.h               |   12 ---
 threadalloc-dave/include/asm-sh/page.h                 |   10 ---
 threadalloc-dave/include/asm-s390/page.h               |    8 --
 threadalloc-dave/include/asm-ppc/page.h                |   22 ------
 threadalloc-dave/include/asm-powerpc/page.h            |   34 ----------
 threadalloc-dave/include/asm-parisc/pgtable.h          |    8 +-
 threadalloc-dave/include/asm-parisc/page.h             |   25 -------
 threadalloc-dave/include/asm-mips/page.h               |   23 ------
 threadalloc-dave/include/asm-m68knommu/page.h          |   10 ---
 threadalloc-dave/include/asm-m68k/page.h               |   20 ------
 threadalloc-dave/include/asm-m32r/page.h               |    9 --
 threadalloc-dave/include/asm-ia64/ptrace.h             |    6 -
 threadalloc-dave/include/asm-ia64/page.h               |   21 ------
 threadalloc-dave/include/asm-i386/page.h               |    8 --
 threadalloc-dave/include/asm-h8300/page.h              |   11 ---
 threadalloc-dave/include/asm-generic/page.h            |    1 
 threadalloc-dave/include/asm-frv/page.h                |    4 -
 threadalloc-dave/include/asm-frv/mem-layout.h          |   15 ----
 threadalloc-dave/include/asm-cris/page.h               |   13 ---
 threadalloc-dave/include/asm-arm26/page.h              |    7 --
 threadalloc-dave/include/asm-arm/page.h                |    9 --
 threadalloc-dave/include/asm-alpha/page.h              |    9 --
 threadalloc-dave/arch/ia64/Kconfig                     |   33 ----------
 threadalloc-dave/arch/ia64/configs/bigsur_defconfig    |    8 +-
 threadalloc-dave/arch/ia64/configs/gensparse_defconfig |    8 +-
 threadalloc-dave/arch/ia64/configs/sim_defconfig       |    8 +-
 threadalloc-dave/arch/ia64/configs/sn2_defconfig       |    8 +-
 threadalloc-dave/arch/ia64/configs/tiger_defconfig     |    8 +-
 threadalloc-dave/arch/ia64/configs/zx1_defconfig       |    8 +-
 threadalloc-dave/arch/ia64/defconfig                   |    8 +-
 threadalloc-dave/arch/parisc/Kconfig                   |   29 --------
 threadalloc-dave/arch/parisc/defconfig                 |    6 -
 threadalloc-dave/arch/parisc/mm/init.c                 |    2 
 threadalloc-dave/arch/powerpc/Kconfig                  |    2 
 threadalloc-dave/arch/powerpc/boot/page.h              |   22 ------
 threadalloc-dave/arch/sparc64/Kconfig                  |   31 ---------
 threadalloc-dave/arch/sparc64/defconfig                |    8 +-
 threadalloc-dave/arch/sparc64/mm/tsb.c                 |    8 +-
 47 files changed, 173 insertions(+), 483 deletions(-)

diff -puN /dev/null include/asm-generic/page_size.h
--- /dev/null	2005-03-30 22:36:15.000000000 -0800
+++ threadalloc-dave/include/asm-generic/page_size.h	2006-08-24 16:37:05.000000000 -0700
@@ -0,0 +1,31 @@
+#ifndef _INCLUDE_GENERIC_PAGE_SIZE_H
+#define _INCLUDE_GENERIC_PAGE_SIZE_H
+
+#ifdef __ASSEMBLY__
+#define ASM_CONST(x) x
+#else
+#define __ASM_CONST(x) x##UL
+#define ASM_CONST(x) __ASM_CONST(x)
+#endif
+
+#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
+#define PAGE_SIZE       (ASM_CONST(1) << PAGE_SHIFT)
+
+/* align addr on a size boundary - adjust address up/down if needed */
+#define _ALIGN_UP(addr,size)    (((addr)+((size)-1))&(~((size)-1)))
+#define _ALIGN_DOWN(addr,size)  ((addr)&(~((size)-1)))
+
+/* align addr on a size boundary - adjust address up if needed */
+#define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
+
+/* to align the pointer to the (next) page boundary */
+#define PAGE_ALIGN(addr)        _ALIGN(addr, PAGE_SIZE)
+
+/*
+ * Subtle: (1 << PAGE_SHIFT) is an int, not an unsigned long. So if we
+ * assign PAGE_MASK to a larger type it gets extended the way we want
+ * (i.e. with 1s in the high bits)
+ */
+#define PAGE_MASK      (~((1 << PAGE_SHIFT) - 1))
+
+#endif /* _INCLUDE_GENERIC_PAGE_SIZE_H */
diff -puN mm/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT mm/Kconfig
--- threadalloc/mm/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/mm/Kconfig	2006-08-24 16:37:05.000000000 -0700
@@ -1,3 +1,59 @@
+#
+# On PPC32 page size is 4K. For PPC64 we support either 4K or 64K software
+# page size. When using 64K pages however, whether we are really supporting
+# 64K pages in HW or not is irrelevant to those definitions.
+#
+choice
+	prompt "Kernel Page Size"
+	default PAGE_SIZE_8KB
+config PAGE_SIZE_4KB
+	bool "4KB"
+	help
+	  This lets you select the page size of the kernel.  For best 64-bit
+	  performance, a page size of larger than 4k is recommended.  For best
+	  32-bit compatibility on 64-bit architectures, a page size of 4KB
+	  should be selected (although most binaries work perfectly fine with
+	  a larger page size).
+
+	  4KB                For best 32-bit compatibility
+	  8KB and up         For best performance
+	  above 64k	     For kernel hackers only
+
+	  If you don't know what to do, choose 8KB (if available).
+	  Otherwise, choose 4KB.
+	depends on !SPARC64 && !PPC_64K_PAGES
+config PAGE_SIZE_8KB
+	bool "8KB"
+	depends on IA64 || SPARC64
+config PAGE_SIZE_16KB
+	bool "16KB"
+	depends on IA64 || PARISC_LARGER_PAGE_SIZES || SPARC64
+config PAGE_SIZE_64KB
+	bool "64KB"
+	depends on (IA64 && !ITANIUM) || PARISC_LARGER_PAGE_SIZES ||\
+		   PPC_64K_PAGES || SPARC64
+config PAGE_SIZE_512KB
+	bool "512KB"
+	depends on SPARC64
+config PAGE_SIZE_4MB
+	bool "4MB"
+	depends on SPARC64
+endchoice
+
+#
+# Note that sparc and m68k vary thier page sizes based
+# on the SUN3/4 options, so they are not explicitly listed
+#
+config PAGE_SHIFT
+	int
+	default "13" if PAGE_SIZE_8KB || ALPHA || SUN3 || SUN4
+	default "14" if PAGE_SIZE_16KB || FRV || CRIS
+	default "16" if PAGE_SIZE_64KB || FRV || CRIS
+	default "19" if PAGE_SIZE_512KB
+	default "22" if PAGE_SIZE_4MB
+	default "12" # arm || h8300 || i386 | m68knommu |ppc
+		     # s390 || um || v850 || xtensa
+
 config SELECT_MEMORY_MODEL
 	def_bool y
 	depends on EXPERIMENTAL || ARCH_SELECT_MEMORY_MODEL
diff -puN include/asm-xtensa/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-xtensa/page.h
--- threadalloc/include/asm-xtensa/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-xtensa/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -14,16 +14,7 @@
 #ifdef __KERNEL__
 
 #include <asm/processor.h>
-
-/*
- * PAGE_SHIFT determines the page size
- * PAGE_ALIGN(x) aligns the pointer to the (next) page boundary
- */
-
-#define PAGE_SHIFT		XCHAL_MMU_MIN_PTE_PAGE_SIZE
-#define PAGE_SIZE		(1 << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE-1))
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE - 1) & PAGE_MASK)
+#include <asm-generic/page_size.h>
 
 #define DCACHE_WAY_SIZE		(XCHAL_DCACHE_SIZE / XCHAL_DCACHE_WAYS)
 #define PAGE_OFFSET		XCHAL_KSEG_CACHED_VADDR
diff -puN include/asm-x86_64/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-x86_64/page.h
--- threadalloc/include/asm-x86_64/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-x86_64/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -1,15 +1,8 @@
 #ifndef _X86_64_PAGE_H
 #define _X86_64_PAGE_H
 
+#include <asm-generic/page_size.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
-#ifdef __ASSEMBLY__
-#define PAGE_SIZE	(0x1 << PAGE_SHIFT)
-#else
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#endif
-#define PAGE_MASK	(~(PAGE_SIZE-1))
 #define PHYSICAL_PAGE_MASK	(~(PAGE_SIZE-1) & __PHYSICAL_MASK)
 
 #define THREAD_ORDER 1 
@@ -88,9 +81,6 @@ typedef struct { unsigned long pgprot; }
 #define __PAGE_OFFSET           0xffff810000000000
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 /* See Documentation/x86_64/mm.txt for a description of the memory map. */
 #define __PHYSICAL_MASK_SHIFT	46
 #define __PHYSICAL_MASK		((1UL << __PHYSICAL_MASK_SHIFT) - 1)
diff -puN include/asm-v850/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-v850/page.h
--- threadalloc/include/asm-v850/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-v850/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -15,12 +15,7 @@
 #define __V850_PAGE_H__
 
 #include <asm/machdep.h>
-
-
-#define PAGE_SHIFT	12
-#define PAGE_SIZE       (1UL << PAGE_SHIFT)
-#define PAGE_MASK       (~(PAGE_SIZE-1))
-
+#include <asm-generic/page_size.h>
 
 /*
  * PAGE_OFFSET -- the first address of the first page of memory. For archs with
@@ -93,11 +88,6 @@ typedef unsigned long pgprot_t;
 
 #endif /* !__ASSEMBLY__ */
 
-
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
-
-
 /* No current v850 processor has virtual memory.  */
 #define __virt_to_phys(addr)	(addr)
 #define __phys_to_virt(addr)	(addr)
diff -puN include/asm-um/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-um/page.h
--- threadalloc/include/asm-um/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-um/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -10,11 +10,7 @@
 struct page;
 
 #include <asm/vm-flags.h>
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <asm-generic/page_size.h>
 
 /*
  * These are used to make use of C type-checking..
@@ -85,9 +81,6 @@ typedef struct { unsigned long pgprot; }
 #define __pgd(x) ((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 extern unsigned long uml_physmem;
 
 #define PAGE_OFFSET (uml_physmem)
diff -puN include/asm-sparc64/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-sparc64/page.h
--- threadalloc/include/asm-sparc64/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-sparc64/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -4,21 +4,7 @@
 #define _SPARC64_PAGE_H
 
 #include <asm/const.h>
-
-#if defined(CONFIG_SPARC64_PAGE_SIZE_8KB)
-#define PAGE_SHIFT   13
-#elif defined(CONFIG_SPARC64_PAGE_SIZE_64KB)
-#define PAGE_SHIFT   16
-#elif defined(CONFIG_SPARC64_PAGE_SIZE_512KB)
-#define PAGE_SHIFT   19
-#elif defined(CONFIG_SPARC64_PAGE_SIZE_4MB)
-#define PAGE_SHIFT   22
-#else
-#error No page size specified in kernel configuration
-#endif
-
-#define PAGE_SIZE    (_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK    (~(PAGE_SIZE-1))
+#include <asm-generic/page_size.h>
 
 /* Flushing for D-cache alias handling is only needed if
  * the page size is smaller than 16K.
@@ -114,9 +100,6 @@ typedef unsigned long pgprot_t;
 
 #endif /* !(__ASSEMBLY__) */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 /* We used to stick this into a hard-coded global register (%g4)
  * but that does not make sense anymore.
  */
diff -puN include/asm-sparc64/mmu.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-sparc64/mmu.h
--- threadalloc/include/asm-sparc64/mmu.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-sparc64/mmu.h	2006-08-24 16:37:05.000000000 -0700
@@ -30,13 +30,13 @@
 #define CTX_PGSZ_MASK		((CTX_PGSZ_BITS << CTX_PGSZ0_SHIFT) | \
 				 (CTX_PGSZ_BITS << CTX_PGSZ1_SHIFT))
 
-#if defined(CONFIG_SPARC64_PAGE_SIZE_8KB)
+#if defined(CONFIG_PAGE_SIZE_8KB)
 #define CTX_PGSZ_BASE	CTX_PGSZ_8KB
-#elif defined(CONFIG_SPARC64_PAGE_SIZE_64KB)
+#elif defined(CONFIG_PAGE_SIZE_64KB)
 #define CTX_PGSZ_BASE	CTX_PGSZ_64KB
-#elif defined(CONFIG_SPARC64_PAGE_SIZE_512KB)
+#elif defined(CONFIG_PAGE_SIZE_512KB)
 #define CTX_PGSZ_BASE	CTX_PGSZ_512KB
-#elif defined(CONFIG_SPARC64_PAGE_SIZE_4MB)
+#elif defined(CONFIG_PAGE_SIZE_4MB)
 #define CTX_PGSZ_BASE	CTX_PGSZ_4MB
 #else
 #error No page size specified in kernel configuration
diff -puN include/asm-sparc/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-sparc/page.h
--- threadalloc/include/asm-sparc/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-sparc/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -8,18 +8,7 @@
 #ifndef _SPARC_PAGE_H
 #define _SPARC_PAGE_H
 
-#ifdef CONFIG_SUN4
-#define PAGE_SHIFT   13
-#else
-#define PAGE_SHIFT   12
-#endif
-#ifndef __ASSEMBLY__
-/* I have my suspicions... -DaveM */
-#define PAGE_SIZE    (1UL << PAGE_SHIFT)
-#else
-#define PAGE_SIZE    (1 << PAGE_SHIFT)
-#endif
-#define PAGE_MASK    (~(PAGE_SIZE-1))
+#include <asm-generic/page_size.h>
 
 #ifdef __KERNEL__
 
@@ -137,9 +126,6 @@ BTFIXUPDEF_SETHI(sparc_unmapped_base)
 
 #endif /* !(__ASSEMBLY__) */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)  (((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 #define PAGE_OFFSET	0xf0000000
 #ifndef __ASSEMBLY__
 extern unsigned long phys_base;
diff -puN include/asm-sh64/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-sh64/page.h
--- threadalloc/include/asm-sh64/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-sh64/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -17,15 +17,8 @@
  *
  */
 
+#include <asm-generic/page_size.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
-#ifdef __ASSEMBLY__
-#define PAGE_SIZE	4096
-#else
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#endif
-#define PAGE_MASK	(~(PAGE_SIZE-1))
 #define PTE_MASK	PAGE_MASK
 
 #if defined(CONFIG_HUGETLB_PAGE_SIZE_64K)
@@ -85,9 +78,6 @@ typedef struct { unsigned long pgprot; }
 
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 /*
  * Kconfig defined.
  */
diff -puN include/asm-sh/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-sh/page.h
--- threadalloc/include/asm-sh/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-sh/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -13,12 +13,7 @@
    [ P4 control   ]		0xE0000000
  */
 
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
-#define PTE_MASK	PAGE_MASK
+#include <asm-generic/page_size.h>
 
 #if defined(CONFIG_HUGETLB_PAGE_SIZE_64K)
 #define HPAGE_SHIFT	16
@@ -79,9 +74,6 @@ typedef struct { unsigned long pgprot; }
 
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 /*
  * IF YOU CHANGE THIS, PLEASE ALSO CHANGE
  *
diff -puN include/asm-s390/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-s390/page.h
--- threadalloc/include/asm-s390/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-s390/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -10,11 +10,8 @@
 #define _S390_PAGE_H
 
 #include <asm/types.h>
+#include <asm-generic/page_size.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT      12
-#define PAGE_SIZE       (1UL << PAGE_SHIFT)
-#define PAGE_MASK       (~(PAGE_SIZE-1))
 #define PAGE_DEFAULT_ACC	0
 #define PAGE_DEFAULT_KEY	(PAGE_DEFAULT_ACC << 4)
 
@@ -174,9 +171,6 @@ page_get_storage_key(unsigned long addr)
 
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)        (((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 #define __PAGE_OFFSET           0x0UL
 #define PAGE_OFFSET             0x0UL
 #define __pa(x)                 (unsigned long)(x)
diff -puN include/asm-ppc/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-ppc/page.h
--- threadalloc/include/asm-ppc/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-ppc/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -2,16 +2,7 @@
 #define _PPC_PAGE_H
 
 #include <asm/asm-compat.h>
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
-#define PAGE_SIZE	(ASM_CONST(1) << PAGE_SHIFT)
-
-/*
- * Subtle: this is an int (not an unsigned long) and so it
- * gets extended to 64 bits the way want (i.e. with 1s).  -- paulus
- */
-#define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
+#include <asm-generic/page_size.h>
 
 #ifdef __KERNEL__
 
@@ -36,17 +27,6 @@ typedef unsigned long pte_basic_t;
 #define PTE_FMT		"%.8lx"
 #endif
 
-/* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
-
-/* align addr on a size boundary - adjust address up if needed */
-#define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
-
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	_ALIGN(addr, PAGE_SIZE)
-
-
 #undef STRICT_MM_TYPECHECKS
 
 #ifdef STRICT_MM_TYPECHECKS
diff -puN include/asm-powerpc/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-powerpc/page.h
--- threadalloc/include/asm-powerpc/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-powerpc/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -10,32 +10,14 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <asm-generic/page_size.h>
+
 #ifdef __KERNEL__
 #include <asm/asm-compat.h>
 #include <asm/kdump.h>
 
-/*
- * On PPC32 page size is 4K. For PPC64 we support either 4K or 64K software
- * page size. When using 64K pages however, whether we are really supporting
- * 64K pages in HW or not is irrelevant to those definitions.
- */
-#ifdef CONFIG_PPC_64K_PAGES
-#define PAGE_SHIFT		16
-#else
-#define PAGE_SHIFT		12
-#endif
-
-#define PAGE_SIZE		(ASM_CONST(1) << PAGE_SHIFT)
-
 /* We do define AT_SYSINFO_EHDR but don't use the gate mechanism */
-#define __HAVE_ARCH_GATE_AREA		1
-
-/*
- * Subtle: (1 << PAGE_SHIFT) is an int, not an unsigned long. So if we
- * assign PAGE_MASK to a larger type it gets extended the way we want
- * (i.e. with 1s in the high bits)
- */
-#define PAGE_MASK      (~((1 << PAGE_SHIFT) - 1))
+#define __HAVE_ARCH_GATE_AREA          1
 
 /*
  * KERNELBASE is the virtual address of the start of the kernel, it's often
@@ -89,16 +71,6 @@
 #include <asm/page_32.h>
 #endif
 
-/* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
-
-/* align addr on a size boundary - adjust address up if needed */
-#define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
-
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	_ALIGN(addr, PAGE_SIZE)
-
 /*
  * Don't compare things with KERNELBASE or PAGE_OFFSET to test for
  * "kernelness", use is_kernel_addr() - it should do what you want.
diff -puN include/asm-parisc/pgtable.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-parisc/pgtable.h
--- threadalloc/include/asm-parisc/pgtable.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-parisc/pgtable.h	2006-08-24 16:37:05.000000000 -0700
@@ -66,7 +66,7 @@
 #endif
 #define KERNEL_INITIAL_SIZE	(1 << KERNEL_INITIAL_ORDER)
 
-#if defined(CONFIG_64BIT) && defined(CONFIG_PARISC_PAGE_SIZE_4KB)
+#if defined(CONFIG_64BIT) && defined(CONFIG_PAGE_SIZE_4KB)
 #define PT_NLEVELS	3
 #define PGD_ORDER	1 /* Number of pages per pgd */
 #define PMD_ORDER	1 /* Number of pages per pmd */
@@ -514,11 +514,11 @@ static inline void ptep_set_wrprotect(st
 #define _PAGE_SIZE_ENCODING_16M		6
 #define _PAGE_SIZE_ENCODING_64M		7
 
-#if defined(CONFIG_PARISC_PAGE_SIZE_4KB)
+#if defined(CONFIG_PAGE_SIZE_4KB)
 # define _PAGE_SIZE_ENCODING_DEFAULT _PAGE_SIZE_ENCODING_4K
-#elif defined(CONFIG_PARISC_PAGE_SIZE_16KB)
+#elif defined(CONFIG_PAGE_SIZE_16KB)
 # define _PAGE_SIZE_ENCODING_DEFAULT _PAGE_SIZE_ENCODING_16K
-#elif defined(CONFIG_PARISC_PAGE_SIZE_64KB)
+#elif defined(CONFIG_PAGE_SIZE_64KB)
 # define _PAGE_SIZE_ENCODING_DEFAULT _PAGE_SIZE_ENCODING_64K
 #endif
 
diff -puN include/asm-parisc/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-parisc/page.h
--- threadalloc/include/asm-parisc/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-parisc/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -1,29 +1,10 @@
 #ifndef _PARISC_PAGE_H
 #define _PARISC_PAGE_H
 
-#if !defined(__KERNEL__)
-/* this is for userspace applications (4k page size) */
-# define PAGE_SHIFT	12	/* 4k */
-# define PAGE_SIZE	(1UL << PAGE_SHIFT)
-# define PAGE_MASK	(~(PAGE_SIZE-1))
-#endif
-
+#include <asm-generic/page_size.h>
 
 #ifdef __KERNEL__
 
-#if defined(CONFIG_PARISC_PAGE_SIZE_4KB)
-# define PAGE_SHIFT	12	/* 4k */
-#elif defined(CONFIG_PARISC_PAGE_SIZE_16KB)
-# define PAGE_SHIFT	14	/* 16k */
-#elif defined(CONFIG_PARISC_PAGE_SIZE_64KB)
-# define PAGE_SHIFT	16	/* 64k */
-#else
-# error "unknown default kernel page size"
-#endif
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
-
-
 #ifndef __ASSEMBLY__
 
 #include <asm/types.h>
@@ -140,10 +121,6 @@ extern int npmem_ranges;
 #define PMD_ENTRY_SIZE	(1UL << BITS_PER_PMD_ENTRY)
 #define PTE_ENTRY_SIZE	(1UL << BITS_PER_PTE_ENTRY)
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
-
 #define LINUX_GATEWAY_SPACE     0
 
 /* This governs the relationship between virtual and physical addresses.
diff -puN include/asm-mips/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-mips/page.h
--- threadalloc/include/asm-mips/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-mips/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -9,6 +9,7 @@
 #ifndef _ASM_PAGE_H
 #define _ASM_PAGE_H
 
+#include <asm-generic/page_size.h>
 
 #ifdef __KERNEL__
 
@@ -16,25 +17,6 @@
 
 #endif
 
-/*
- * PAGE_SHIFT determines the page size
- */
-#ifdef CONFIG_PAGE_SIZE_4KB
-#define PAGE_SHIFT	12
-#endif
-#ifdef CONFIG_PAGE_SIZE_8KB
-#define PAGE_SHIFT	13
-#endif
-#ifdef CONFIG_PAGE_SIZE_16KB
-#define PAGE_SHIFT	14
-#endif
-#ifdef CONFIG_PAGE_SIZE_64KB
-#define PAGE_SHIFT	16
-#endif
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK       (~((1 << PAGE_SHIFT) - 1))
-
-
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
@@ -130,9 +112,6 @@ typedef struct { unsigned long pgprot; }
 
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
-
 #define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
 
diff -puN include/asm-m68knommu/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-m68knommu/page.h
--- threadalloc/include/asm-m68knommu/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-m68knommu/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -1,12 +1,7 @@
 #ifndef _M68KNOMMU_PAGE_H
 #define _M68KNOMMU_PAGE_H
 
-
-/* PAGE_SHIFT determines the page size */
-
-#define PAGE_SHIFT	(12)
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <asm-generic/page_size.h>
 
 #ifdef __KERNEL__
 
@@ -44,9 +39,6 @@ typedef struct { unsigned long pgprot; }
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 extern unsigned long memory_start;
 extern unsigned long memory_end;
 
diff -puN include/asm-m68k/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-m68k/page.h
--- threadalloc/include/asm-m68k/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-m68k/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -1,22 +1,7 @@
 #ifndef _M68K_PAGE_H
 #define _M68K_PAGE_H
 
-
-/* PAGE_SHIFT determines the page size */
-#ifndef CONFIG_SUN3
-#define PAGE_SHIFT	(12)
-#else
-#define PAGE_SHIFT	(13)
-#endif
-#ifdef __ASSEMBLY__
-#define PAGE_SIZE	(1 << PAGE_SHIFT)
-#else
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#endif
-#define PAGE_MASK	(~(PAGE_SIZE-1))
-
-#ifdef __KERNEL__
-
+#include <asm-generic/page_size.h>
 #include <asm/setup.h>
 
 #if PAGE_SHIFT < 13
@@ -103,9 +88,6 @@ typedef struct { unsigned long pgprot; }
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 #endif /* !__ASSEMBLY__ */
 
 #include <asm/page_offset.h>
diff -puN include/asm-m32r/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-m32r/page.h
--- threadalloc/include/asm-m32r/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-m32r/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -1,11 +1,7 @@
 #ifndef _ASM_M32R_PAGE_H
 #define _ASM_M32R_PAGE_H
 
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <asm-generic/page_size.h>
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
@@ -41,9 +37,6 @@ typedef struct { unsigned long pgprot; }
 
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
-
 /*
  * This handles the memory map.. We could make this a config
  * option, but too many people screw it up, and too few need
diff -puN include/asm-ia64/ptrace.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-ia64/ptrace.h
--- threadalloc/include/asm-ia64/ptrace.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-ia64/ptrace.h	2006-08-24 16:37:05.000000000 -0700
@@ -64,11 +64,11 @@
  * Base-2 logarithm of number of pages to allocate per task structure
  * (including register backing store and memory stack):
  */
-#if defined(CONFIG_IA64_PAGE_SIZE_4KB)
+#if defined(CONFIG_PAGE_SIZE_4KB)
 # define KERNEL_STACK_SIZE_ORDER		3
-#elif defined(CONFIG_IA64_PAGE_SIZE_8KB)
+#elif defined(CONFIG_PAGE_SIZE_8KB)
 # define KERNEL_STACK_SIZE_ORDER		2
-#elif defined(CONFIG_IA64_PAGE_SIZE_16KB)
+#elif defined(CONFIG_PAGE_SIZE_16KB)
 # define KERNEL_STACK_SIZE_ORDER		1
 #else
 # define KERNEL_STACK_SIZE_ORDER		0
diff -puN include/asm-ia64/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-ia64/page.h
--- threadalloc/include/asm-ia64/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-ia64/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -7,7 +7,7 @@
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
 
-
+#include <asm-generic/page_size.h>
 #include <asm/intrinsics.h>
 #include <asm/types.h>
 
@@ -24,25 +24,6 @@
 #define RGN_GATE	5	/* Gate page, Kernel text, etc */
 #define RGN_HPAGE	4	/* For Huge TLB pages */
 
-/*
- * PAGE_SHIFT determines the actual kernel page size.
- */
-#if defined(CONFIG_IA64_PAGE_SIZE_4KB)
-# define PAGE_SHIFT	12
-#elif defined(CONFIG_IA64_PAGE_SIZE_8KB)
-# define PAGE_SHIFT	13
-#elif defined(CONFIG_IA64_PAGE_SIZE_16KB)
-# define PAGE_SHIFT	14
-#elif defined(CONFIG_IA64_PAGE_SIZE_64KB)
-# define PAGE_SHIFT	16
-#else
-# error Unsupported page size!
-#endif
-
-#define PAGE_SIZE		(__IA64_UL_CONST(1) << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE - 1))
-#define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
-
 #define PERCPU_PAGE_SHIFT	16	/* log2() of max. size of per-CPU area */
 #define PERCPU_PAGE_SIZE	(__IA64_UL_CONST(1) << PERCPU_PAGE_SHIFT)
 
diff -puN include/asm-i386/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-i386/page.h
--- threadalloc/include/asm-i386/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-i386/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -1,10 +1,7 @@
 #ifndef _I386_PAGE_H
 #define _I386_PAGE_H
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <asm-generic/page_size.h>
 
 #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
 #define LARGE_PAGE_SIZE (1UL << PMD_SHIFT)
@@ -78,9 +75,6 @@ typedef struct { unsigned long pgprot; }
 
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 /*
  * This handles the memory map.. We could make this a config
  * option, but too many people screw it up, and too few need
diff -puN include/asm-h8300/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-h8300/page.h
--- threadalloc/include/asm-h8300/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-h8300/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -1,16 +1,10 @@
 #ifndef _H8300_PAGE_H
 #define _H8300_PAGE_H
 
-
-/* PAGE_SHIFT determines the page size */
-
-#define PAGE_SHIFT	(12)
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
-
 #ifdef __KERNEL__
 
 #include <asm/setup.h>
+#include <asm-generic/page_size.h>
 
 #ifndef __ASSEMBLY__
  
@@ -44,9 +38,6 @@ typedef struct { unsigned long pgprot; }
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 extern unsigned long memory_start;
 extern unsigned long memory_end;
 
diff -puN include/asm-generic/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-generic/page.h
--- threadalloc/include/asm-generic/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-generic/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -5,6 +5,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/compiler.h>
+#include <asm-generic/page_size.h>
 
 /* Pure 2^n version of get_order */
 static __inline__ __attribute_const__ int get_order(unsigned long size)
diff -puN include/asm-frv/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-frv/page.h
--- threadalloc/include/asm-frv/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-frv/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -3,6 +3,7 @@
 
 #ifdef __KERNEL__
 
+#include <asm-generic/page_size.h>
 #include <asm/virtconvert.h>
 #include <asm/mem-layout.h>
 #include <asm/sections.h>
@@ -41,9 +42,6 @@ typedef struct { unsigned long	pgprot;	}
 #define __pgprot(x)	((pgprot_t) { (x) } )
 #define PTE_MASK	PAGE_MASK
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
-
 #define devmem_is_allowed(pfn)	1
 
 #define __pa(vaddr)		virt_to_phys((void *) (unsigned long) (vaddr))
diff -puN include/asm-frv/mem-layout.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-frv/mem-layout.h
--- threadalloc/include/asm-frv/mem-layout.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-frv/mem-layout.h	2006-08-24 16:37:05.000000000 -0700
@@ -12,25 +12,14 @@
 #ifndef _ASM_MEM_LAYOUT_H
 #define _ASM_MEM_LAYOUT_H
 
+#include <asm-generic/page_size.h>
+
 #ifndef __ASSEMBLY__
 #define __UL(X)	((unsigned long) (X))
 #else
 #define __UL(X)	(X)
 #endif
 
-/*
- * PAGE_SHIFT determines the page size
- */
-#define PAGE_SHIFT			14
-
-#ifndef __ASSEMBLY__
-#define PAGE_SIZE			(1UL << PAGE_SHIFT)
-#else
-#define PAGE_SIZE			(1 << PAGE_SHIFT)
-#endif
-
-#define PAGE_MASK			(~(PAGE_SIZE-1))
-
 /*****************************************************************************/
 /*
  * virtual memory layout from kernel's point of view
diff -puN include/asm-cris/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-cris/page.h
--- threadalloc/include/asm-cris/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-cris/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -1,17 +1,9 @@
 #ifndef _CRIS_PAGE_H
 #define _CRIS_PAGE_H
 
+#include <asm-generic/page_size.h>
 #include <asm/arch/page.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	13
-#ifndef __ASSEMBLY__
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#else
-#define PAGE_SIZE	(1 << PAGE_SHIFT)
-#endif
-#define PAGE_MASK	(~(PAGE_SIZE-1))
-
 #ifdef __KERNEL__
 
 #define clear_page(page)        memset((void *)(page), 0, PAGE_SIZE)
@@ -63,9 +55,6 @@ typedef struct { unsigned long pgprot; }
 
 #define page_to_phys(page)     __pa((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 #ifndef __ASSEMBLY__
 
 #endif /* __ASSEMBLY__ */
diff -puN include/asm-arm26/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-arm26/page.h
--- threadalloc/include/asm-arm26/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-arm26/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -1,6 +1,7 @@
 #ifndef _ASMARM_PAGE_H
 #define _ASMARM_PAGE_H
 
+#include <asm-generic/page_size.h>
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
@@ -79,12 +80,6 @@ typedef unsigned long pgprot_t;
 
 #define EXEC_PAGESIZE   32768
 
-#define PAGE_SIZE		(1UL << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE-1))
-
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
diff -puN include/asm-arm/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-arm/page.h
--- threadalloc/include/asm-arm/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-arm/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -10,17 +10,10 @@
 #ifndef _ASMARM_PAGE_H
 #define _ASMARM_PAGE_H
 
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT		12
-#define PAGE_SIZE		(1UL << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE-1))
+#include <asm-generic/page_size.h>
 
 #ifdef __KERNEL__
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 #ifndef __ASSEMBLY__
 
 #ifndef CONFIG_MMU
diff -puN include/asm-alpha/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-alpha/page.h
--- threadalloc/include/asm-alpha/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/include/asm-alpha/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -2,11 +2,7 @@
 #define _ALPHA_PAGE_H
 
 #include <asm/pal.h>
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	13
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <asm-generic/page_size.h>
 
 #ifdef __KERNEL__
 
@@ -78,9 +74,6 @@ typedef unsigned long pgprot_t;
 
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 #define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
 #ifndef CONFIG_DISCONTIGMEM
diff -puN arch/ia64/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/ia64/Kconfig
--- threadalloc/arch/ia64/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/Kconfig	2006-08-24 16:37:05.000000000 -0700
@@ -150,39 +150,6 @@ config MCKINLEY
 endchoice
 
 choice
-	prompt "Kernel page size"
-	default IA64_PAGE_SIZE_16KB
-
-config IA64_PAGE_SIZE_4KB
-	bool "4KB"
-	help
-	  This lets you select the page size of the kernel.  For best IA-64
-	  performance, a page size of 8KB or 16KB is recommended.  For best
-	  IA-32 compatibility, a page size of 4KB should be selected (the vast
-	  majority of IA-32 binaries work perfectly fine with a larger page
-	  size).  For Itanium 2 or newer systems, a page size of 64KB can also
-	  be selected.
-
-	  4KB                For best IA-32 compatibility
-	  8KB                For best IA-64 performance
-	  16KB               For best IA-64 performance
-	  64KB               Requires Itanium 2 or newer processor.
-
-	  If you don't know what to do, choose 16KB.
-
-config IA64_PAGE_SIZE_8KB
-	bool "8KB"
-
-config IA64_PAGE_SIZE_16KB
-	bool "16KB"
-
-config IA64_PAGE_SIZE_64KB
-	depends on !ITANIUM
-	bool "64KB"
-
-endchoice
-
-choice
 	prompt "Page Table Levels"
 	default PGTABLE_3
 
diff -puN arch/ia64/configs/bigsur_defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/ia64/configs/bigsur_defconfig
--- threadalloc/arch/ia64/configs/bigsur_defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/configs/bigsur_defconfig	2006-08-24 16:37:05.000000000 -0700
@@ -98,10 +98,10 @@ CONFIG_IA64_DIG=y
 # CONFIG_IA64_HP_SIM is not set
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
-# CONFIG_IA64_PAGE_SIZE_4KB is not set
-# CONFIG_IA64_PAGE_SIZE_8KB is not set
-CONFIG_IA64_PAGE_SIZE_16KB=y
-# CONFIG_IA64_PAGE_SIZE_64KB is not set
+# CONFIG_PAGE_SIZE_4KB is not set
+# CONFIG_PAGE_SIZE_8KB is not set
+CONFIG_PAGE_SIZE_16KB=y
+# CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_PGTABLE_3=y
 # CONFIG_PGTABLE_4 is not set
 # CONFIG_HZ_100 is not set
diff -puN arch/ia64/configs/gensparse_defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/ia64/configs/gensparse_defconfig
--- threadalloc/arch/ia64/configs/gensparse_defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/configs/gensparse_defconfig	2006-08-24 16:37:05.000000000 -0700
@@ -99,10 +99,10 @@ CONFIG_IA64_GENERIC=y
 # CONFIG_IA64_HP_SIM is not set
 # CONFIG_ITANIUM is not set
 CONFIG_MCKINLEY=y
-# CONFIG_IA64_PAGE_SIZE_4KB is not set
-# CONFIG_IA64_PAGE_SIZE_8KB is not set
-CONFIG_IA64_PAGE_SIZE_16KB=y
-# CONFIG_IA64_PAGE_SIZE_64KB is not set
+# CONFIG_PAGE_SIZE_4KB is not set
+# CONFIG_PAGE_SIZE_8KB is not set
+CONFIG_PAGE_SIZE_16KB=y
+# CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_PGTABLE_3=y
 # CONFIG_PGTABLE_4 is not set
 # CONFIG_HZ_100 is not set
diff -puN arch/ia64/configs/sim_defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/ia64/configs/sim_defconfig
--- threadalloc/arch/ia64/configs/sim_defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/configs/sim_defconfig	2006-08-24 16:37:05.000000000 -0700
@@ -99,10 +99,10 @@ CONFIG_DMA_IS_DMA32=y
 CONFIG_IA64_HP_SIM=y
 # CONFIG_ITANIUM is not set
 CONFIG_MCKINLEY=y
-# CONFIG_IA64_PAGE_SIZE_4KB is not set
-# CONFIG_IA64_PAGE_SIZE_8KB is not set
-# CONFIG_IA64_PAGE_SIZE_16KB is not set
-CONFIG_IA64_PAGE_SIZE_64KB=y
+# CONFIG_PAGE_SIZE_4KB is not set
+# CONFIG_PAGE_SIZE_8KB is not set
+# CONFIG_PAGE_SIZE_16KB is not set
+CONFIG_PAGE_SIZE_64KB=y
 CONFIG_PGTABLE_3=y
 # CONFIG_PGTABLE_4 is not set
 # CONFIG_HZ_100 is not set
diff -puN arch/ia64/configs/sn2_defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/ia64/configs/sn2_defconfig
--- threadalloc/arch/ia64/configs/sn2_defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/configs/sn2_defconfig	2006-08-24 16:37:05.000000000 -0700
@@ -98,10 +98,10 @@ CONFIG_IA64_SGI_SN2=y
 # CONFIG_IA64_HP_SIM is not set
 # CONFIG_ITANIUM is not set
 CONFIG_MCKINLEY=y
-# CONFIG_IA64_PAGE_SIZE_4KB is not set
-# CONFIG_IA64_PAGE_SIZE_8KB is not set
-CONFIG_IA64_PAGE_SIZE_16KB=y
-# CONFIG_IA64_PAGE_SIZE_64KB is not set
+# CONFIG_PAGE_SIZE_4KB is not set
+# CONFIG_PAGE_SIZE_8KB is not set
+CONFIG_PAGE_SIZE_16KB=y
+# CONFIG_PAGE_SIZE_64KB is not set
 # CONFIG_PGTABLE_3 is not set
 CONFIG_PGTABLE_4=y
 # CONFIG_HZ_100 is not set
diff -puN arch/ia64/configs/tiger_defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/ia64/configs/tiger_defconfig
--- threadalloc/arch/ia64/configs/tiger_defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/configs/tiger_defconfig	2006-08-24 16:37:05.000000000 -0700
@@ -99,10 +99,10 @@ CONFIG_IA64_DIG=y
 # CONFIG_IA64_HP_SIM is not set
 # CONFIG_ITANIUM is not set
 CONFIG_MCKINLEY=y
-# CONFIG_IA64_PAGE_SIZE_4KB is not set
-# CONFIG_IA64_PAGE_SIZE_8KB is not set
-CONFIG_IA64_PAGE_SIZE_16KB=y
-# CONFIG_IA64_PAGE_SIZE_64KB is not set
+# CONFIG_PAGE_SIZE_4KB is not set
+# CONFIG_PAGE_SIZE_8KB is not set
+CONFIG_PAGE_SIZE_16KB=y
+# CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_PGTABLE_3=y
 # CONFIG_PGTABLE_4 is not set
 # CONFIG_HZ_100 is not set
diff -puN arch/ia64/configs/zx1_defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/ia64/configs/zx1_defconfig
--- threadalloc/arch/ia64/configs/zx1_defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/configs/zx1_defconfig	2006-08-24 16:37:05.000000000 -0700
@@ -97,10 +97,10 @@ CONFIG_IA64_HP_ZX1=y
 # CONFIG_IA64_HP_SIM is not set
 # CONFIG_ITANIUM is not set
 CONFIG_MCKINLEY=y
-# CONFIG_IA64_PAGE_SIZE_4KB is not set
-# CONFIG_IA64_PAGE_SIZE_8KB is not set
-CONFIG_IA64_PAGE_SIZE_16KB=y
-# CONFIG_IA64_PAGE_SIZE_64KB is not set
+# CONFIG_PAGE_SIZE_4KB is not set
+# CONFIG_PAGE_SIZE_8KB is not set
+CONFIG_PAGE_SIZE_16KB=y
+# CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_PGTABLE_3=y
 # CONFIG_PGTABLE_4 is not set
 # CONFIG_HZ_100 is not set
diff -puN arch/ia64/defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/ia64/defconfig
--- threadalloc/arch/ia64/defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/defconfig	2006-08-24 16:37:05.000000000 -0700
@@ -99,10 +99,10 @@ CONFIG_IA64_GENERIC=y
 # CONFIG_IA64_HP_SIM is not set
 # CONFIG_ITANIUM is not set
 CONFIG_MCKINLEY=y
-# CONFIG_IA64_PAGE_SIZE_4KB is not set
-# CONFIG_IA64_PAGE_SIZE_8KB is not set
-CONFIG_IA64_PAGE_SIZE_16KB=y
-# CONFIG_IA64_PAGE_SIZE_64KB is not set
+# CONFIG_PAGE_SIZE_4KB is not set
+# CONFIG_PAGE_SIZE_8KB is not set
+CONFIG_PAGE_SIZE_16KB=y
+# CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_PGTABLE_3=y
 # CONFIG_PGTABLE_4 is not set
 # CONFIG_HZ_100 is not set
diff -puN arch/parisc/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/parisc/Kconfig
--- threadalloc/arch/parisc/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/parisc/Kconfig	2006-08-24 16:37:05.000000000 -0700
@@ -142,33 +142,8 @@ config 64BIT
 	  enable this option otherwise. The 64bit kernel is significantly bigger
 	  and slower than the 32bit one.
 
-choice
-	prompt "Kernel page size"
-	default PARISC_PAGE_SIZE_4KB  if !64BIT
-	default PARISC_PAGE_SIZE_4KB  if 64BIT
-#	default PARISC_PAGE_SIZE_16KB if 64BIT
-
-config PARISC_PAGE_SIZE_4KB
-	bool "4KB"
-	help
-	  This lets you select the page size of the kernel.  For best
-	  performance, a page size of 16KB is recommended.  For best
-	  compatibility with 32bit applications, a page size of 4KB should be
-	  selected (the vast majority of 32bit binaries work perfectly fine
-	  with a larger page size).
-
-	  4KB                For best 32bit compatibility
-	  16KB               For best performance
-	  64KB               For best performance, might give more overhead.
-
-	  If you don't know what to do, choose 4KB.
-
-config PARISC_PAGE_SIZE_16KB
-	bool "16KB (EXPERIMENTAL)"
-	depends on PA8X00 && EXPERIMENTAL
-
-config PARISC_PAGE_SIZE_64KB
-	bool "64KB (EXPERIMENTAL)"
+config PARISC_LARGER_PAGE_SIZES
+	def_bool y
 	depends on PA8X00 && EXPERIMENTAL
 
 endchoice
diff -puN arch/parisc/defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/parisc/defconfig
--- threadalloc/arch/parisc/defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/parisc/defconfig	2006-08-24 16:37:05.000000000 -0700
@@ -91,9 +91,9 @@ CONFIG_PA7100LC=y
 # CONFIG_PA7300LC is not set
 # CONFIG_PA8X00 is not set
 CONFIG_PA11=y
-CONFIG_PARISC_PAGE_SIZE_4KB=y
-# CONFIG_PARISC_PAGE_SIZE_16KB is not set
-# CONFIG_PARISC_PAGE_SIZE_64KB is not set
+CONFIG_PAGE_SIZE_4KB=y
+# CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_64KB is not set
 # CONFIG_SMP is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 # CONFIG_PREEMPT_NONE is not set
diff -puN arch/parisc/mm/init.c~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/parisc/mm/init.c
--- threadalloc/arch/parisc/mm/init.c~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/parisc/mm/init.c	2006-08-24 16:37:05.000000000 -0700
@@ -642,7 +642,7 @@ static void __init map_pages(unsigned lo
 				 * Map the fault vector writable so we can
 				 * write the HPMC checksum.
 				 */
-#if defined(CONFIG_PARISC_PAGE_SIZE_4KB)
+#if defined(CONFIG_PAGE_SIZE_4KB)
 				if (address >= ro_start && address < ro_end
 							&& address != fv_addr
 							&& address != gw_addr)
diff -puN arch/powerpc/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/powerpc/Kconfig
--- threadalloc/arch/powerpc/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/powerpc/Kconfig	2006-08-24 16:37:05.000000000 -0700
@@ -726,7 +726,7 @@ config ARCH_MEMORY_PROBE
 	depends on MEMORY_HOTPLUG
 
 config PPC_64K_PAGES
-	bool "64k page size"
+	bool "enable 64k page size"
 	depends on PPC64
 	help
 	  This option changes the kernel logical page size to 64k. On machines
diff -puN arch/powerpc/boot/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/powerpc/boot/page.h
--- threadalloc/arch/powerpc/boot/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/powerpc/boot/page.h	2006-08-24 16:37:05.000000000 -0700
@@ -9,26 +9,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#ifdef __ASSEMBLY__
-#define ASM_CONST(x) x
-#else
-#define __ASM_CONST(x) x##UL
-#define ASM_CONST(x) __ASM_CONST(x)
-#endif
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
-#define PAGE_SIZE	(ASM_CONST(1) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
-
-/* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
-
-/* align addr on a size boundary - adjust address up if needed */
-#define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
-
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	_ALIGN(addr, PAGE_SIZE)
+#include <asm-generic/page_size.h>
 
 #endif				/* _PPC_BOOT_PAGE_H */
diff -puN arch/sparc64/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/sparc64/Kconfig
--- threadalloc/arch/sparc64/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/sparc64/Kconfig	2006-08-24 16:37:05.000000000 -0700
@@ -34,33 +34,6 @@ config ARCH_MAY_HAVE_PC_FDC
 	bool
 	default y
 
-choice
-	prompt "Kernel page size"
-	default SPARC64_PAGE_SIZE_8KB
-
-config SPARC64_PAGE_SIZE_8KB
-	bool "8KB"
-	help
-	  This lets you select the page size of the kernel.
-
-	  8KB and 64KB work quite well, since Sparc ELF sections
-	  provide for up to 64KB alignment.
-
-	  Therefore, 512KB and 4MB are for expert hackers only.
-
-	  If you don't know what to do, choose 8KB.
-
-config SPARC64_PAGE_SIZE_64KB
-	bool "64KB"
-
-config SPARC64_PAGE_SIZE_512KB
-	bool "512KB"
-
-config SPARC64_PAGE_SIZE_4MB
-	bool "4MB"
-
-endchoice
-
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
@@ -187,11 +160,11 @@ config HUGETLB_PAGE_SIZE_4MB
 	bool "4MB"
 
 config HUGETLB_PAGE_SIZE_512K
-	depends on !SPARC64_PAGE_SIZE_4MB && !SPARC64_PAGE_SIZE_512KB
+	depends on !PAGE_SIZE_4MB && !PAGE_SIZE_512KB
 	bool "512K"
 
 config HUGETLB_PAGE_SIZE_64K
-	depends on !SPARC64_PAGE_SIZE_4MB && !SPARC64_PAGE_SIZE_512KB && !SPARC64_PAGE_SIZE_64KB
+	depends on !PAGE_SIZE_4MB && !PAGE_SIZE_512KB && !PAGE_SIZE_64KB
 	bool "64K"
 
 endchoice
diff -puN arch/sparc64/defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/sparc64/defconfig
--- threadalloc/arch/sparc64/defconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/sparc64/defconfig	2006-08-24 16:37:05.000000000 -0700
@@ -9,10 +9,10 @@ CONFIG_64BIT=y
 CONFIG_MMU=y
 CONFIG_TIME_INTERPOLATION=y
 CONFIG_ARCH_MAY_HAVE_PC_FDC=y
-CONFIG_SPARC64_PAGE_SIZE_8KB=y
-# CONFIG_SPARC64_PAGE_SIZE_64KB is not set
-# CONFIG_SPARC64_PAGE_SIZE_512KB is not set
-# CONFIG_SPARC64_PAGE_SIZE_4MB is not set
+CONFIG_PAGE_SIZE_8KB=y
+# CONFIG_PAGE_SIZE_64KB is not set
+# CONFIG_PAGE_SIZE_512KB is not set
+# CONFIG_PAGE_SIZE_4MB is not set
 CONFIG_SECCOMP=y
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
diff -puN arch/sparc64/mm/tsb.c~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/sparc64/mm/tsb.c
--- threadalloc/arch/sparc64/mm/tsb.c~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-24 16:36:56.000000000 -0700
+++ threadalloc-dave/arch/sparc64/mm/tsb.c	2006-08-24 16:37:05.000000000 -0700
@@ -90,16 +90,16 @@ void flush_tsb_user(struct mmu_gather *m
 	spin_unlock_irqrestore(&mm->context.lock, flags);
 }
 
-#if defined(CONFIG_SPARC64_PAGE_SIZE_8KB)
+#if defined(CONFIG_PAGE_SIZE_8KB)
 #define HV_PGSZ_IDX_BASE	HV_PGSZ_IDX_8K
 #define HV_PGSZ_MASK_BASE	HV_PGSZ_MASK_8K
-#elif defined(CONFIG_SPARC64_PAGE_SIZE_64KB)
+#elif defined(CONFIG_PAGE_SIZE_64KB)
 #define HV_PGSZ_IDX_BASE	HV_PGSZ_IDX_64K
 #define HV_PGSZ_MASK_BASE	HV_PGSZ_MASK_64K
-#elif defined(CONFIG_SPARC64_PAGE_SIZE_512KB)
+#elif defined(CONFIG_PAGE_SIZE_512KB)
 #define HV_PGSZ_IDX_BASE	HV_PGSZ_IDX_512K
 #define HV_PGSZ_MASK_BASE	HV_PGSZ_MASK_512K
-#elif defined(CONFIG_SPARC64_PAGE_SIZE_4MB)
+#elif defined(CONFIG_PAGE_SIZE_4MB)
 #define HV_PGSZ_IDX_BASE	HV_PGSZ_IDX_4MB
 #define HV_PGSZ_MASK_BASE	HV_PGSZ_MASK_4MB
 #else
_
