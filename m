Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWH3WQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWH3WQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWH3WQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:16:15 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:27585 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932176AbWH3WQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:16:10 -0400
Subject: [RFC][PATCH 3/9] actual generic PAGE_SIZE infrastructure
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 30 Aug 2006 15:16:06 -0700
References: <20060830221604.E7320C0F@localhost.localdomain>
In-Reply-To: <20060830221604.E7320C0F@localhost.localdomain>
Message-Id: <20060830221606.40937644@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Add _ALIGN_UP() which we'll use now and _ALIGN_DOWN(), just for
  parity.
* Define ASM_CONST() macro to help using constants in both assembly
  and C code.  Several architectures have some form of this, and
  they will be consolidated around this one.
* Actually create PAGE_SHIFT and PAGE_SIZE macros
* For now, require that architectures enable GENERIC_PAGE_SIZE in
  order to get this new code.  This option will be removed by the
  last patch in the series, and makes the series bisect-safe.
* Note that this moves the compiler.h define outside of the
  #ifdef __KERNEL__, but that's OK because it has its own.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 threadalloc-dave/include/asm-generic/page.h |   31 ++++++++++++++++++--
 threadalloc-dave/mm/Kconfig                 |   43 ++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 3 deletions(-)

diff -puN include/asm-generic/page.h~generic-PAGE_SIZE-infrastructure include/asm-generic/page.h
--- threadalloc/include/asm-generic/page.h~generic-PAGE_SIZE-infrastructure	2006-08-30 15:15:00.000000000 -0700
+++ threadalloc-dave/include/asm-generic/page.h	2006-08-30 15:15:01.000000000 -0700
@@ -1,11 +1,36 @@
 #ifndef _ASM_GENERIC_PAGE_H
 #define _ASM_GENERIC_PAGE_H
 
+#include <linux/compiler.h>
+#include <linux/align.h>
+
 #ifdef __KERNEL__
-#ifndef __ASSEMBLY__
 
-#include <linux/compiler.h>
+#ifdef __ASSEMBLY__
+#define ASM_CONST(x) x
+#else
+#define __ASM_CONST(x) x##UL
+#define ASM_CONST(x) __ASM_CONST(x)
+#endif
+
+#ifdef CONFIG_ARCH_GENERIC_PAGE_SIZE
+
+#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
+#define PAGE_SIZE       (ASM_CONST(1) << PAGE_SHIFT)
+
+/*
+ * Subtle: (1 << PAGE_SHIFT) is an int, not an unsigned long. So if we
+ * assign PAGE_MASK to a larger type it gets extended the way we want
+ * (i.e. with 1s in the high bits)
+ */
+#define PAGE_MASK      (~((1 << PAGE_SHIFT) - 1))
 
+/* to align the pointer to the (next) page boundary */
+#define PAGE_ALIGN(addr)        ALIGN(addr, PAGE_SIZE)
+
+#endif /* CONFIG_ARCH_GENERIC_PAGE_SIZE */
+
+#ifndef __ASSEMBLY__
 #ifndef CONFIG_ARCH_HAVE_GET_ORDER
 /* Pure 2^n version of get_order */
 static __inline__ __attribute_const__ int get_order(unsigned long size)
@@ -22,7 +47,7 @@ static __inline__ __attribute_const__ in
 }
 
 #endif	/* CONFIG_ARCH_HAVE_GET_ORDER */
-#endif /*  __ASSEMBLY__ */
+#endif  /* __ASSEMBLY__ */
 #endif	/* __KERNEL__ */
 
 #endif	/* _ASM_GENERIC_PAGE_H */
diff -puN mm/Kconfig~generic-PAGE_SIZE-infrastructure mm/Kconfig
--- threadalloc/mm/Kconfig~generic-PAGE_SIZE-infrastructure	2006-08-30 15:15:00.000000000 -0700
+++ threadalloc-dave/mm/Kconfig	2006-08-30 15:15:01.000000000 -0700
@@ -2,6 +2,49 @@ config ARCH_HAVE_GET_ORDER
 	def_bool y
 	depends on IA64 || PPC32 || XTENSA
 
+choice
+	prompt "Kernel Page Size"
+	depends on ARCH_GENERIC_PAGE_SIZE
+config PAGE_SIZE_4KB
+	bool "4KB"
+	help
+	  This lets you select the page size of the kernel.  For best
+	  32-bit compatibility on 64-bit architectures, a page size of 4KB
+	  should be selected (although most binaries work perfectly fine with
+	  a larger page size).  For best performance, a page size of larger
+	  than 4KB is recommended.  However, there are a number of
+	  side-effects of larger page sizes, like small files fitting poorly
+	  into the page cache.
+
+	  4KB                For best 32-bit compatibility
+	  8KB-64KB           Better performace
+	  above 64KB	     For kernel hackers only
+
+	  If you don't know what to do, choose 4KB, or simply leave this
+	  option alone.  A sane default has already been selected for your
+	  architecture.
+config PAGE_SIZE_8KB
+	bool "8KB"
+config PAGE_SIZE_16KB
+	bool "16KB"
+config PAGE_SIZE_64KB
+	bool "64KB"
+config PAGE_SIZE_512KB
+	bool "512KB"
+config PAGE_SIZE_4MB
+	bool "4MB"
+endchoice
+
+config PAGE_SHIFT
+	int
+	depends on ARCH_GENERIC_PAGE_SIZE
+	default "13" if PAGE_SIZE_8KB
+	default "14" if PAGE_SIZE_16KB
+	default "16" if PAGE_SIZE_64KB
+	default "19" if PAGE_SIZE_512KB
+	default "22" if PAGE_SIZE_4MB
+	default "12"
+
 config SELECT_MEMORY_MODEL
 	def_bool y
 	depends on EXPERIMENTAL || ARCH_SELECT_MEMORY_MODEL
_
