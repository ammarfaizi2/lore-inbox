Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbULPV4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbULPV4W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 16:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbULPV4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 16:56:22 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51415 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262039AbULPV4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 16:56:06 -0500
Subject: [patch] [RFC] make WANT_PAGE_VIRTUAL a config option
To: linux-kernel@vger.kernel.org
Cc: geert@linux-m68k.org, zippel@linux-m68k.org, ralf@linux-mips.org,
       linux-mm@kvack.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Thu, 16 Dec 2004 13:56:02 -0800
Message-Id: <E1Cf3bP-0002el-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm working on breaking out the struct page definition into its
own file.  There seem to be a ton of header dependencies that
crop up around struct page, and I'd like to start getting rid
of thise.

In order to reduce those dependencies that a structpage.h has on 
other include files, make the #define WANT_PAGE_VIRTUAL a Kconfig
option.  This keeps the number of things that structpage.h will
include to a bare minimum.

I don't have a MIPS or m68k system to test this on, but it's
pretty simple.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 apw2-dave/arch/m68k/Kconfig       |    5 +++++
 apw2-dave/arch/mips/Kconfig       |    5 +++++
 apw2-dave/include/asm-frv/page.h  |    4 ----
 apw2-dave/include/asm-m68k/page.h |    1 -
 apw2-dave/include/asm-mips/page.h |    4 ----
 apw2-dave/include/linux/mm.h      |   12 ++++++------
 apw2-dave/mm/highmem.c            |    2 +-
 apw2-dave/mm/page_alloc.c         |    2 +-
 arch/frv/Kconfig                  |    0 
 9 files changed, 18 insertions(+), 17 deletions(-)

diff -puN include/asm-mips/page.h~000-CONFIG_WANT_PAGE_VIRTUAL include/asm-mips/page.h
--- apw2/include/asm-mips/page.h~000-CONFIG_WANT_PAGE_VIRTUAL	2004-12-16 13:50:53.000000000 -0800
+++ apw2-dave/include/asm-mips/page.h	2004-12-16 13:50:53.000000000 -0800
@@ -144,10 +144,6 @@ static __inline__ int get_order(unsigned
 
 #endif /* defined (__KERNEL__) */
 
-#ifdef CONFIG_LIMITED_DMA
-#define WANT_PAGE_VIRTUAL
-#endif
-
 #define devmem_is_allowed(x) 1
 
 #endif /* _ASM_PAGE_H */
diff -puN include/asm-m68k/page.h~000-CONFIG_WANT_PAGE_VIRTUAL include/asm-m68k/page.h
--- apw2/include/asm-m68k/page.h~000-CONFIG_WANT_PAGE_VIRTUAL	2004-12-16 13:50:53.000000000 -0800
+++ apw2-dave/include/asm-m68k/page.h	2004-12-16 13:50:53.000000000 -0800
@@ -131,7 +131,6 @@ static inline int get_order(unsigned lon
 
 #ifndef CONFIG_SUN3
 
-#define WANT_PAGE_VIRTUAL
 #ifdef CONFIG_SINGLE_MEMORY_CHUNK
 extern unsigned long m68k_memoffset;
 
diff -puN include/linux/mm.h~000-CONFIG_WANT_PAGE_VIRTUAL include/linux/mm.h
--- apw2/include/linux/mm.h~000-CONFIG_WANT_PAGE_VIRTUAL	2004-12-16 13:50:53.000000000 -0800
+++ apw2-dave/include/linux/mm.h	2004-12-16 13:50:53.000000000 -0800
@@ -262,12 +262,12 @@ struct page {
 	 * Note that this field could be 16 bits on x86 ... ;)
 	 *
 	 * Architectures with slow multiplication can define
-	 * WANT_PAGE_VIRTUAL in asm/page.h
+	 * WANT_PAGE_VIRTUAL in their architecture's Kconfig
 	 */
-#if defined(WANT_PAGE_VIRTUAL)
+#if defined(CONFIG_WANT_PAGE_VIRTUAL)
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
-#endif /* WANT_PAGE_VIRTUAL */
+#endif /* CONFIG_WANT_PAGE_VIRTUAL */
 };
 
 /*
@@ -445,11 +445,11 @@ static inline void *lowmem_page_address(
 	return __va(page_to_pfn(page) << PAGE_SHIFT);
 }
 
-#if defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL)
+#if defined(CONFIG_HIGHMEM) && !defined(CONFIG_WANT_PAGE_VIRTUAL)
 #define HASHED_PAGE_VIRTUAL
 #endif
 
-#if defined(WANT_PAGE_VIRTUAL)
+#if defined(CONFIG_WANT_PAGE_VIRTUAL)
 #define page_address(page) ((page)->virtual)
 #define set_page_address(page, address)			\
 	do {						\
@@ -464,7 +464,7 @@ void set_page_address(struct page *page,
 void page_address_init(void);
 #endif
 
-#if !defined(HASHED_PAGE_VIRTUAL) && !defined(WANT_PAGE_VIRTUAL)
+#if !defined(HASHED_PAGE_VIRTUAL) && !defined(CONFIG_WANT_PAGE_VIRTUAL)
 #define page_address(page) lowmem_page_address(page)
 #define set_page_address(page, address)  do { } while(0)
 #define page_address_init()  do { } while(0)
diff -puN include/asm-frv/page.h~000-CONFIG_WANT_PAGE_VIRTUAL include/asm-frv/page.h
--- apw2/include/asm-frv/page.h~000-CONFIG_WANT_PAGE_VIRTUAL	2004-12-16 13:50:53.000000000 -0800
+++ apw2-dave/include/asm-frv/page.h	2004-12-16 13:50:53.000000000 -0800
@@ -97,8 +97,4 @@ extern unsigned long max_pfn;
 
 #endif /* __KERNEL__ */
 
-#ifdef CONFIG_CONTIGUOUS_PAGE_ALLOC
-#define WANT_PAGE_VIRTUAL	1
-#endif
-
 #endif /* _ASM_PAGE_H */
diff -puN mm/page_alloc.c~000-CONFIG_WANT_PAGE_VIRTUAL mm/page_alloc.c
--- apw2/mm/page_alloc.c~000-CONFIG_WANT_PAGE_VIRTUAL	2004-12-16 13:50:53.000000000 -0800
+++ apw2-dave/mm/page_alloc.c	2004-12-16 13:50:53.000000000 -0800
@@ -1597,7 +1597,7 @@ void __init memmap_init_zone(unsigned lo
 		reset_page_mapcount(page);
 		SetPageReserved(page);
 		INIT_LIST_HEAD(&page->lru);
-#ifdef WANT_PAGE_VIRTUAL
+#ifdef CONFIG_WANT_PAGE_VIRTUAL
 		/* The shift won't overflow because ZONE_NORMAL is below 4G. */
 		if (!is_highmem_idx(zone))
 			set_page_address(page, __va(start_pfn << PAGE_SHIFT));
diff -puN mm/highmem.c~000-CONFIG_WANT_PAGE_VIRTUAL mm/highmem.c
--- apw2/mm/highmem.c~000-CONFIG_WANT_PAGE_VIRTUAL	2004-12-16 13:50:53.000000000 -0800
+++ apw2-dave/mm/highmem.c	2004-12-16 13:50:53.000000000 -0800
@@ -602,4 +602,4 @@ void __init page_address_init(void)
 	spin_lock_init(&pool_lock);
 }
 
-#endif	/* defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL) */
+#endif	/* defined(CONFIG_HIGHMEM) && !defined(CONFIG_WANT_PAGE_VIRTUAL) */
diff -puN arch/mips/Kconfig~000-CONFIG_WANT_PAGE_VIRTUAL arch/mips/Kconfig
--- apw2/arch/mips/Kconfig~000-CONFIG_WANT_PAGE_VIRTUAL	2004-12-16 13:50:53.000000000 -0800
+++ apw2-dave/arch/mips/Kconfig	2004-12-16 13:50:53.000000000 -0800
@@ -896,6 +896,11 @@ config LIMITED_DMA
 	bool
 	select HIGHMEM
 
+config WANT_PAGE_VIRTUAL
+	bool
+	depends on LIMITED_DMA
+	default y
+
 config MIPS_BONITO64
 	bool
 	depends on MIPS_ATLAS || MIPS_MALTA
diff -puN arch/m68k/Kconfig~000-CONFIG_WANT_PAGE_VIRTUAL arch/m68k/Kconfig
--- apw2/arch/m68k/Kconfig~000-CONFIG_WANT_PAGE_VIRTUAL	2004-12-16 13:50:53.000000000 -0800
+++ apw2-dave/arch/m68k/Kconfig	2004-12-16 13:50:53.000000000 -0800
@@ -230,6 +230,11 @@ config Q40
 	  Q60. Select your CPU below.  For 68LC060 don't forget to enable FPU
 	  emulation.
 
+config WANT_PAGE_VIRTUAL
+	bool
+	depends on !SUN3
+	default y
+
 comment "Processor type"
 
 config M68020
diff -puN arch/frv/Kconfig~000-CONFIG_WANT_PAGE_VIRTUAL arch/frv/Kconfig
_
