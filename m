Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWH3WQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWH3WQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWH3WQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:16:17 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:35265 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932178AbWH3WQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:16:11 -0400
Subject: [RFC][PATCH 4/9] ia64 generic PAGE_SIZE
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 30 Aug 2006 15:16:07 -0700
References: <20060830221604.E7320C0F@localhost.localdomain>
In-Reply-To: <20060830221604.E7320C0F@localhost.localdomain>
Message-Id: <20060830221607.1DB81421@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the ia64 portion to convert it over to the generic PAGE_SIZE
framework.

* Change all references to CONFIG_IA64_PAGE_SIZE_*KB to
  CONFIG_PAGE_SIZE_* and update the defconfigs.  
* remove ia64-specific Kconfig menu
* add ia64 default of 16k pages to mm/Kconfig
* add support for 8k and 16k pages, plus 64k if !ITANIUM

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 threadalloc-dave/include/asm-ia64/ptrace.h             |    6 +--
 threadalloc-dave/include/asm-ia64/page.h               |   21 ----------
 threadalloc-dave/arch/ia64/Kconfig                     |   34 +----------------
 threadalloc-dave/arch/ia64/configs/bigsur_defconfig    |    8 ++--
 threadalloc-dave/arch/ia64/configs/gensparse_defconfig |    8 ++--
 threadalloc-dave/arch/ia64/configs/sim_defconfig       |    8 ++--
 threadalloc-dave/arch/ia64/configs/sn2_defconfig       |    8 ++--
 threadalloc-dave/arch/ia64/configs/tiger_defconfig     |    8 ++--
 threadalloc-dave/arch/ia64/configs/zx1_defconfig       |    8 ++--
 threadalloc-dave/arch/ia64/defconfig                   |    8 ++--
 threadalloc-dave/mm/Kconfig                            |    4 ++
 11 files changed, 38 insertions(+), 83 deletions(-)

diff -puN include/asm-ia64/ptrace.h~ia64 include/asm-ia64/ptrace.h
--- threadalloc/include/asm-ia64/ptrace.h~ia64	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/include/asm-ia64/ptrace.h	2006-08-30 15:15:02.000000000 -0700
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
diff -puN include/asm-ia64/page.h~ia64 include/asm-ia64/page.h
--- threadalloc/include/asm-ia64/page.h~ia64	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/include/asm-ia64/page.h	2006-08-30 15:15:02.000000000 -0700
@@ -7,7 +7,7 @@
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
 
-
+#include <asm-generic/page.h>
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
 
diff -puN arch/ia64/Kconfig~ia64 arch/ia64/Kconfig
--- threadalloc/arch/ia64/Kconfig~ia64	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/Kconfig	2006-08-30 15:15:02.000000000 -0700
@@ -149,38 +149,8 @@ config MCKINLEY
 
 endchoice
 
-choice
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
+config ARCH_GENERIC_PAGE_SIZE
+	def_bool y
 
 choice
 	prompt "Page Table Levels"
diff -puN arch/ia64/configs/bigsur_defconfig~ia64 arch/ia64/configs/bigsur_defconfig
--- threadalloc/arch/ia64/configs/bigsur_defconfig~ia64	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/configs/bigsur_defconfig	2006-08-30 15:15:02.000000000 -0700
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
diff -puN arch/ia64/configs/gensparse_defconfig~ia64 arch/ia64/configs/gensparse_defconfig
--- threadalloc/arch/ia64/configs/gensparse_defconfig~ia64	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/configs/gensparse_defconfig	2006-08-30 15:15:02.000000000 -0700
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
diff -puN arch/ia64/configs/sim_defconfig~ia64 arch/ia64/configs/sim_defconfig
--- threadalloc/arch/ia64/configs/sim_defconfig~ia64	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/configs/sim_defconfig	2006-08-30 15:15:02.000000000 -0700
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
diff -puN arch/ia64/configs/sn2_defconfig~ia64 arch/ia64/configs/sn2_defconfig
--- threadalloc/arch/ia64/configs/sn2_defconfig~ia64	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/configs/sn2_defconfig	2006-08-30 15:15:02.000000000 -0700
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
diff -puN arch/ia64/configs/tiger_defconfig~ia64 arch/ia64/configs/tiger_defconfig
--- threadalloc/arch/ia64/configs/tiger_defconfig~ia64	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/configs/tiger_defconfig	2006-08-30 15:15:02.000000000 -0700
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
diff -puN arch/ia64/configs/zx1_defconfig~ia64 arch/ia64/configs/zx1_defconfig
--- threadalloc/arch/ia64/configs/zx1_defconfig~ia64	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/configs/zx1_defconfig	2006-08-30 15:15:02.000000000 -0700
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
diff -puN arch/ia64/defconfig~ia64 arch/ia64/defconfig
--- threadalloc/arch/ia64/defconfig~ia64	2006-08-30 15:14:56.000000000 -0700
+++ threadalloc-dave/arch/ia64/defconfig	2006-08-30 15:15:02.000000000 -0700
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
diff -puN mm/Kconfig~ia64 mm/Kconfig
--- threadalloc/mm/Kconfig~ia64	2006-08-30 15:15:01.000000000 -0700
+++ threadalloc-dave/mm/Kconfig	2006-08-30 15:15:02.000000000 -0700
@@ -5,6 +5,7 @@ config ARCH_HAVE_GET_ORDER
 choice
 	prompt "Kernel Page Size"
 	depends on ARCH_GENERIC_PAGE_SIZE
+	default PAGE_SIZE_16KB if IA64
 config PAGE_SIZE_4KB
 	bool "4KB"
 	help
@@ -25,10 +26,13 @@ config PAGE_SIZE_4KB
 	  architecture.
 config PAGE_SIZE_8KB
 	bool "8KB"
+	depends on IA64
 config PAGE_SIZE_16KB
 	bool "16KB"
+	depends on IA64
 config PAGE_SIZE_64KB
 	bool "64KB"
+	depends on (IA64 && !ITANIUM)
 config PAGE_SIZE_512KB
 	bool "512KB"
 config PAGE_SIZE_4MB
_
