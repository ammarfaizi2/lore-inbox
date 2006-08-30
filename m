Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWH3WRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWH3WRH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWH3WQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:16:42 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:16027 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932185AbWH3WQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:16:15 -0400
Subject: [RFC][PATCH 7/9] parisc generic PAGE_SIZE
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 30 Aug 2006 15:16:09 -0700
References: <20060830221604.E7320C0F@localhost.localdomain>
In-Reply-To: <20060830221604.E7320C0F@localhost.localdomain>
Message-Id: <20060830221609.DA8E9016@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the parisc portion to convert it over to the generic PAGE_SIZE
framework.

* remove parisc-specific Kconfig menu
* add parisc default of 4k pages to mm/Kconfig
* replace parisc Kconfig menu with plain bool Kconfig option to
  cover both 16KB and 64KB pages: PARISC_LARGER_PAGE_SIZES.
  This preserves the dependencies on PA8X00.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 threadalloc-dave/include/asm-parisc/pgtable.h |    8 +++---
 threadalloc-dave/include/asm-parisc/page.h    |   25 ---------------------
 threadalloc-dave/arch/parisc/Kconfig          |   30 +++-----------------------
 threadalloc-dave/arch/parisc/defconfig        |    6 ++---
 threadalloc-dave/arch/parisc/mm/init.c        |    2 -
 threadalloc-dave/mm/Kconfig                   |    7 +++---
 6 files changed, 17 insertions(+), 61 deletions(-)

diff -puN include/asm-parisc/pgtable.h~parisc include/asm-parisc/pgtable.h
--- threadalloc/include/asm-parisc/pgtable.h~parisc	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/include/asm-parisc/pgtable.h	2006-08-30 15:15:04.000000000 -0700
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
 
diff -puN include/asm-parisc/page.h~parisc include/asm-parisc/page.h
--- threadalloc/include/asm-parisc/page.h~parisc	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/include/asm-parisc/page.h	2006-08-30 15:15:04.000000000 -0700
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
+#include <asm-generic/page.h>
 
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
diff -puN arch/parisc/Kconfig~parisc arch/parisc/Kconfig
--- threadalloc/arch/parisc/Kconfig~parisc	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/arch/parisc/Kconfig	2006-08-30 15:15:04.000000000 -0700
@@ -142,34 +142,12 @@ config 64BIT
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
+config PARISC_LARGER_PAGE_SIZES
+	def_bool y
 	depends on PA8X00 && EXPERIMENTAL
 
-config PARISC_PAGE_SIZE_64KB
-	bool "64KB (EXPERIMENTAL)"
-	depends on PA8X00 && EXPERIMENTAL
+config ARCH_GENERIC_PAGE_SIZE
+	def_bool y
 
 endchoice
 
diff -puN arch/parisc/defconfig~parisc arch/parisc/defconfig
--- threadalloc/arch/parisc/defconfig~parisc	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/arch/parisc/defconfig	2006-08-30 15:15:04.000000000 -0700
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
diff -puN arch/parisc/mm/init.c~parisc arch/parisc/mm/init.c
--- threadalloc/arch/parisc/mm/init.c~parisc	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/arch/parisc/mm/init.c	2006-08-30 15:15:04.000000000 -0700
@@ -642,7 +642,7 @@ static void __init map_pages(unsigned lo
 				 * Map the fault vector writable so we can
 				 * write the HPMC checksum.
 				 */
-#if defined(CONFIG_PARISC_PAGE_SIZE_4KB)
+#if defined(CONFIG_PAGE_SIZE_4KB)
 				if (address >= ro_start && address < ro_end
 							&& address != fv_addr
 							&& address != gw_addr)
diff -puN mm/Kconfig~parisc mm/Kconfig
--- threadalloc/mm/Kconfig~parisc	2006-08-30 15:15:03.000000000 -0700
+++ threadalloc-dave/mm/Kconfig	2006-08-30 15:15:04.000000000 -0700
@@ -5,7 +5,7 @@ config ARCH_HAVE_GET_ORDER
 choice
 	prompt "Kernel Page Size"
 	depends on ARCH_GENERIC_PAGE_SIZE
-	default PAGE_SIZE_4KB if MIPS
+	default PAGE_SIZE_4KB if MIPS || PARISC
 	default PAGE_SIZE_8KB if SPARC64
 	default PAGE_SIZE_16KB if IA64
 config PAGE_SIZE_4KB
@@ -32,10 +32,11 @@ config PAGE_SIZE_8KB
 	depends on IA64 || SPARC64 || MIPS_PAGE_SIZE_8KB
 config PAGE_SIZE_16KB
 	bool "16KB"
-	depends on IA64 || MIPS_PAGE_SIZE_16KB
+	depends on IA64 || MIPS_PAGE_SIZE_16KB || PARISC_LARGER_PAGE_SIZES
 config PAGE_SIZE_64KB
 	bool "64KB"
-	depends on (IA64 && !ITANIUM) || SPARC64 || MIPS_PAGE_SIZE_64KB
+	depends on (IA64 && !ITANIUM) || SPARC64 || MIPS_PAGE_SIZE_64KB || \
+		   PARISC_LARGER_PAGE_SIZES
 config PAGE_SIZE_512KB
 	bool "512KB"
 	depends on SPARC64
_
