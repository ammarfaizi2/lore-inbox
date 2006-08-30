Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWH3WS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWH3WS2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWH3WR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:17:59 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:23268 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932179AbWH3WQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:16:11 -0400
Subject: [RFC][PATCH 6/9] mips generic PAGE_SIZE
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 30 Aug 2006 15:16:08 -0700
References: <20060830221604.E7320C0F@localhost.localdomain>
In-Reply-To: <20060830221604.E7320C0F@localhost.localdomain>
Message-Id: <20060830221608.4B510A13@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the mips portion to convert it over to the generic PAGE_SIZE
framework.

* remove mips-specific Kconfig menu
* add mips default of 4k pages to mm/Kconfig
* replace mips Kconfig menu with plain bool variables to preserve
  dependencies on specific CPUs.  Add to mm/Kconfig


Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 threadalloc-dave/include/asm-mips/page.h |   23 ----------------
 threadalloc-dave/arch/mips/Kconfig       |   43 +++++--------------------------
 threadalloc-dave/mm/Kconfig              |    7 ++---
 3 files changed, 13 insertions(+), 60 deletions(-)

diff -puN include/asm-mips/page.h~mips include/asm-mips/page.h
--- threadalloc/include/asm-mips/page.h~mips	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/include/asm-mips/page.h	2006-08-30 15:15:03.000000000 -0700
@@ -9,6 +9,7 @@
 #ifndef _ASM_PAGE_H
 #define _ASM_PAGE_H
 
+#include <asm-generic/page.h>
 
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
 
diff -puN arch/mips/Kconfig~mips arch/mips/Kconfig
--- threadalloc/arch/mips/Kconfig~mips	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/arch/mips/Kconfig	2006-08-30 15:15:03.000000000 -0700
@@ -1432,47 +1432,20 @@ config 64BIT
 
 endchoice
 
-choice
-	prompt "Kernel page size"
-	default PAGE_SIZE_4KB
-
-config PAGE_SIZE_4KB
-	bool "4kB"
-	help
-	 This option select the standard 4kB Linux page size.  On some
-	 R3000-family processors this is the only available page size.  Using
-	 4kB page size will minimize memory consumption and is therefore
-	 recommended for low memory systems.
-
-config PAGE_SIZE_8KB
-	bool "8kB"
+config MIPS_PAGE_SIZE_8KB
+	def_bool y
 	depends on EXPERIMENTAL && CPU_R8000
-	help
-	  Using 8kB page size will result in higher performance kernel at
-	  the price of higher memory consumption.  This option is available
-	  only on the R8000 processor.  Not that at the time of this writing
-	  this option is still high experimental; there are also issues with
-	  compatibility of user applications.
 
-config PAGE_SIZE_16KB
-	bool "16kB"
+config MIPS_PAGE_SIZE_16KB
+	def_bool y
 	depends on !CPU_R3000 && !CPU_TX39XX
-	help
-	  Using 16kB page size will result in higher performance kernel at
-	  the price of higher memory consumption.  This option is available on
-	  all non-R3000 family processors.  Note that you will need a suitable
-	  Linux distribution to support this.
 
-config PAGE_SIZE_64KB
-	bool "64kB"
+config MIPS_PAGE_SIZE_64KB
+	def_bool y
 	depends on EXPERIMENTAL && !CPU_R3000 && !CPU_TX39XX
-	help
-	  Using 64kB page size will result in higher performance kernel at
-	  the price of higher memory consumption.  This option is available on
-	  all non-R3000 family processor.  Not that at the time of this
-	  writing this option is still high experimental.
 
-endchoice
+config ARCH_GENERIC_PAGE_SIZE
+	def_bool y
 
 config BOARD_SCACHE
 	bool
diff -puN mm/Kconfig~mips mm/Kconfig
--- threadalloc/mm/Kconfig~mips	2006-08-30 15:15:03.000000000 -0700
+++ threadalloc-dave/mm/Kconfig	2006-08-30 15:15:03.000000000 -0700
@@ -5,6 +5,7 @@ config ARCH_HAVE_GET_ORDER
 choice
 	prompt "Kernel Page Size"
 	depends on ARCH_GENERIC_PAGE_SIZE
+	default PAGE_SIZE_4KB if MIPS
 	default PAGE_SIZE_8KB if SPARC64
 	default PAGE_SIZE_16KB if IA64
 config PAGE_SIZE_4KB
@@ -28,13 +29,13 @@ config PAGE_SIZE_4KB
 	  architecture.
 config PAGE_SIZE_8KB
 	bool "8KB"
-	depends on IA64 || SPARC64
+	depends on IA64 || SPARC64 || MIPS_PAGE_SIZE_8KB
 config PAGE_SIZE_16KB
 	bool "16KB"
-	depends on IA64
+	depends on IA64 || MIPS_PAGE_SIZE_16KB
 config PAGE_SIZE_64KB
 	bool "64KB"
-	depends on (IA64 && !ITANIUM) || SPARC64
+	depends on (IA64 && !ITANIUM) || SPARC64 || MIPS_PAGE_SIZE_64KB
 config PAGE_SIZE_512KB
 	bool "512KB"
 	depends on SPARC64
_
