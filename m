Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269463AbRH0WdH>; Mon, 27 Aug 2001 18:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRH0Wc5>; Mon, 27 Aug 2001 18:32:57 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:49583 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S269463AbRH0Wcm>; Mon, 27 Aug 2001 18:32:42 -0400
Date: Mon, 27 Aug 2001 23:32:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: page table cache init cleanup
Message-ID: <20010827233257.D28096@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

The following patch cleans up the page table cache init functions.
This is now a generic function across all architectures.  Dummy
definitions are placed in the relevant asm-*/pgtable.h.

Background: on X86 with PAE enabled, and ARM, we require a method
to initialise slab caches for page tables.  We'd rather not have a
plethora of ifdef'd function calls in init/main.c.

This patch was generated against 2.4.8-ac12.

--- orig/init/main.c	Sun Aug 26 17:30:59 2001
+++ linux/init/main.c	Mon Aug 27 23:00:17 2001
@@ -665,9 +666,8 @@
 #endif
 	mem_init();
 	kmem_cache_sizes_init();
-#if CONFIG_X86_PAE
-	init_pae_pgd_cache();
-#endif
+	pgtable_cache_init();
+
 	mempages = num_physpages;
 
 	fork_init(mempages);
--- orig/include/asm-alpha/pgtable.h	Sun Aug 26 17:30:41 2001
+++ linux/include/asm-alpha/pgtable.h	Mon Aug 27 23:21:08 2001
@@ -358,5 +358,10 @@
 extern void paging_init(void);
 
 #include <asm-generic/pgtable.h>
+
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
 
 #endif /* _ALPHA_PGTABLE_H */
--- orig/include/asm-cris/pgtable.h	Sat May 26 14:42:29 2001
+++ linux/include/asm-cris/pgtable.h	Mon Aug 27 23:21:08 2001
@@ -501,4 +501,9 @@
 
 #include <asm-generic/pgtable.h>
 
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
+
 #endif /* _CRIS_PGTABLE_H */
--- orig/include/asm-i386/pgtable.h	Sat Mar 31 23:47:43 2001
+++ linux/include/asm-i386/pgtable.h	Mon Aug 27 23:27:51 2001
@@ -105,8 +105,20 @@
 #ifndef __ASSEMBLY__
 #if CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
+
+/*
+ * Need to initialise the X86 PAE caches
+ */
+extern void pgtable_cache_init(void);
+
 #else
 # include <asm/pgtable-2level.h>
+
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
+
 #endif
 #endif
 
--- orig/include/asm-ia64/pgtable.h	Sat Aug 11 14:59:47 2001
+++ linux/include/asm-ia64/pgtable.h	Mon Aug 27 23:21:08 2001
@@ -472,5 +472,10 @@
 #define KERNEL_PG_SHIFT		_PAGE_SIZE_64M
 #define KERNEL_PG_SIZE		(1 << KERNEL_PG_SHIFT)
 #define KERNEL_PG_NUM		((KERNEL_START - PAGE_OFFSET) / KERNEL_PG_SIZE)
+
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
 
 #endif /* _ASM_IA64_PGTABLE_H */
--- orig/include/asm-m68k/pgtable.h	Wed Dec 13 00:00:25 2000
+++ linux/include/asm-m68k/pgtable.h	Mon Aug 27 23:21:08 2001
@@ -181,5 +181,10 @@
 #ifndef __ASSEMBLY__
 #include <asm-generic/pgtable.h>
 #endif /* !__ASSEMBLY__ */
+
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
 
 #endif /* _M68K_PGTABLE_H */
--- orig/include/asm-mips/pgtable.h	Fri Jul  6 09:55:23 2001
+++ linux/include/asm-mips/pgtable.h	Mon Aug 27 23:21:08 2001
@@ -743,5 +743,10 @@
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
 #define io_remap_page_range remap_page_range
+
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
 
 #endif /* _ASM_PGTABLE_H */
--- orig/include/asm-mips64/pgtable.h	Sun Aug 26 17:30:46 2001
+++ linux/include/asm-mips64/pgtable.h	Mon Aug 27 23:21:09 2001
@@ -798,5 +798,10 @@
 #include <asm-generic/pgtable.h>
 
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
+
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
 
 #endif /* _ASM_PGTABLE_H */
--- orig/include/asm-parisc/pgtable.h	Wed Dec 13 00:00:27 2000
+++ linux/include/asm-parisc/pgtable.h	Mon Aug 27 23:21:10 2001
@@ -334,4 +334,9 @@
 
 #define io_remap_page_range remap_page_range
 
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
+
 #endif /* _PARISC_PAGE_H */
--- orig/include/asm-ppc/pgtable.h	Fri Jul  6 09:55:24 2001
+++ linux/include/asm-ppc/pgtable.h	Mon Aug 27 23:21:10 2001
@@ -531,6 +531,11 @@
 
 #define io_remap_page_range remap_page_range 
 
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
+
 #endif /* __ASSEMBLY__ */
 #endif /* _PPC_PGTABLE_H */
 #endif /* __KERNEL__ */
--- orig/include/asm-ppc64/pgtable.h	Sun Aug 26 17:30:49 2001
+++ linux/include/asm-ppc64/pgtable.h	Mon Aug 27 23:21:10 2001
@@ -438,5 +438,10 @@
 
 /* #include <asm-generic/pgtable.h> */
 
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
+
 #endif /* __ASSEMBLY__ */
 #endif /* _PPC64_PGTABLE_H */
--- orig/include/asm-s390/pgtable.h	Sat Aug 11 14:59:48 2001
+++ linux/include/asm-s390/pgtable.h	Mon Aug 27 23:21:10 2001
@@ -472,6 +472,11 @@
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define PageSkip(page)          (0)
 #define kern_addr_valid(addr)   (1)
+
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
 
 #endif /* _S390_PAGE_H */
 
--- orig/include/asm-s390x/pgtable.h	Sat Aug 11 14:59:49 2001
+++ linux/include/asm-s390x/pgtable.h	Mon Aug 27 23:21:10 2001
@@ -492,5 +492,10 @@
 #define PageSkip(page)          (0)
 #define kern_addr_valid(addr)   (1)
 
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
+
 #endif /* _S390_PAGE_H */
 
--- orig/include/asm-sh/pgtable.h	Fri Jul  6 09:55:24 2001
+++ linux/include/asm-sh/pgtable.h	Mon Aug 27 23:21:10 2001
@@ -275,6 +275,11 @@
 #define PageSkip(page)		(0)
 #define kern_addr_valid(addr)	(1)
 
 #define io_remap_page_range remap_page_range
+
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
 
 #endif /* __ASM_SH_PAGE_H */
--- orig/include/asm-sparc/pgtable.h	Sat Aug 11 14:59:49 2001
+++ linux/include/asm-sparc/pgtable.h	Mon Aug 27 23:21:10 2001
@@ -454,4 +454,9 @@
 /* We provide our own get_unmapped_area to cope with VA holes for userland */
 #define HAVE_ARCH_UNMAPPED_AREA
 
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
+
 #endif /* !(_SPARC_PGTABLE_H) */
--- orig/include/asm-sparc64/pgtable.h	Sun Aug 26 17:30:51 2001
+++ linux/include/asm-sparc64/pgtable.h	Mon Aug 27 23:21:10 2001
@@ -326,4 +326,9 @@
 
 #endif /* !(__ASSEMBLY__) */
 
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
+
 #endif /* !(_SPARC64_PGTABLE_H) */
--- orig/include/asm-um/pgtable.h	Sun Aug 26 17:30:51 2001
+++ linux/include/asm-um/pgtable.h	Mon Aug 27 23:21:10 2001
@@ -365,6 +365,11 @@
 
 #endif
 
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
+
 #endif
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
--- orig/include/asm-x86_64/pgtable.h	Sun Aug 26 17:30:53 2001
+++ linux/include/asm-x86_64/pgtable.h	Mon Aug 27 23:21:10 2001
@@ -398,4 +398,9 @@
 
 #define HAVE_ARCH_UNMAPPED_AREA
 
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
+
 #endif /* _X86_64_PGTABLE_H */

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

