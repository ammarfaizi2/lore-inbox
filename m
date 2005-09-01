Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbVIAUB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbVIAUB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbVIAUB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:01:27 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:65414 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030345AbVIAUBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:01:16 -0400
Date: Thu, 1 Sep 2005 22:01:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] m68k: move cache functions into separate file
Message-ID: <Pine.LNX.4.61.0509012200240.7243@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Move a few cache functions into its own file and fix flush_icache_range() 
so it can handle both kernel and user addresses correctly (assuming 
context is set correctly).
Turn copy_to_user_page/copy_from_user_page into inline functions and add a 
missing cache flush.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/mm/Makefile         |    2 
 arch/m68k/mm/cache.c          |  118 ++++++++++++++++++++++++++++++++++++++++++
 arch/m68k/mm/memory.c         |  104 -------------------------------------
 include/asm-m68k/cacheflush.h |   31 ++++++-----
 4 files changed, 137 insertions(+), 118 deletions(-)

Index: linux-2.6/arch/m68k/mm/Makefile
===================================================================
--- linux-2.6.orig/arch/m68k/mm/Makefile	2004-03-11 19:29:38.000000000 +0100
+++ linux-2.6/arch/m68k/mm/Makefile	2005-08-30 02:36:04.862428281 +0200
@@ -2,7 +2,7 @@
 # Makefile for the linux m68k-specific parts of the memory manager.
 #
 
-obj-y		:= init.o fault.o hwtest.o
+obj-y		:= cache.o init.o fault.o hwtest.o
 
 obj-$(CONFIG_MMU_MOTOROLA)	+= kmap.o memory.o motorola.o
 obj-$(CONFIG_MMU_SUN3)		+= sun3kmap.o sun3mmu.o
Index: linux-2.6/arch/m68k/mm/cache.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/m68k/mm/cache.c	2005-08-30 02:45:50.289417938 +0200
@@ -0,0 +1,118 @@
+/*
+ *  linux/arch/m68k/mm/cache.c
+ *
+ *  Instruction cache handling
+ *
+ *  Copyright (C) 1995  Hamish Macdonald
+ */
+
+#include <linux/module.h>
+#include <asm/pgalloc.h>
+#include <asm/traps.h>
+
+
+static unsigned long virt_to_phys_slow(unsigned long vaddr)
+{
+	if (CPU_IS_060) {
+		unsigned long paddr;
+
+		/* The PLPAR instruction causes an access error if the translation
+		 * is not possible. To catch this we use the same exception mechanism
+		 * as for user space accesses in <asm/uaccess.h>. */
+		asm volatile (".chip 68060\n"
+			      "1: plpar (%0)\n"
+			      ".chip 68k\n"
+			      "2:\n"
+			      ".section .fixup,\"ax\"\n"
+			      "   .even\n"
+			      "3: sub.l %0,%0\n"
+			      "   jra 2b\n"
+			      ".previous\n"
+			      ".section __ex_table,\"a\"\n"
+			      "   .align 4\n"
+			      "   .long 1b,3b\n"
+			      ".previous"
+			      : "=a" (paddr)
+			      : "0" (vaddr));
+		return paddr;
+	} else if (CPU_IS_040) {
+		unsigned long mmusr;
+
+		asm volatile (".chip 68040\n\t"
+			      "ptestr (%1)\n\t"
+			      "movec %%mmusr, %0\n\t"
+			      ".chip 68k"
+			      : "=r" (mmusr)
+			      : "a" (vaddr));
+
+		if (mmusr & MMU_R_040)
+			return (mmusr & PAGE_MASK) | (vaddr & ~PAGE_MASK);
+	} else {
+		unsigned short mmusr;
+		unsigned long *descaddr;
+
+		asm volatile ("ptestr %3,%2@,#7,%0\n\t"
+			      "pmove %%psr,%1@"
+			      : "=a&" (descaddr)
+			      : "a" (&mmusr), "a" (vaddr), "d" (get_fs().seg));
+		if (mmusr & (MMU_I|MMU_B|MMU_L))
+			return 0;
+		descaddr = phys_to_virt((unsigned long)descaddr);
+		switch (mmusr & MMU_NUM) {
+		case 1:
+			return (*descaddr & 0xfe000000) | (vaddr & 0x01ffffff);
+		case 2:
+			return (*descaddr & 0xfffc0000) | (vaddr & 0x0003ffff);
+		case 3:
+			return (*descaddr & PAGE_MASK) | (vaddr & ~PAGE_MASK);
+		}
+	}
+	return 0;
+}
+
+/* Push n pages at kernel virtual address and clear the icache */
+/* RZ: use cpush %bc instead of cpush %dc, cinv %ic */
+void flush_icache_range(unsigned long address, unsigned long endaddr)
+{
+
+	if (CPU_IS_040_OR_060) {
+		address &= PAGE_MASK;
+
+		do {
+			asm volatile ("nop\n\t"
+				      ".chip 68040\n\t"
+				      "cpushp %%bc,(%0)\n\t"
+				      ".chip 68k"
+				      : : "a" (virt_to_phys_slow(address)));
+			address += PAGE_SIZE;
+		} while (address < endaddr);
+	} else {
+		unsigned long tmp;
+		asm volatile ("movec %%cacr,%0\n\t"
+			      "orw %1,%0\n\t"
+			      "movec %0,%%cacr"
+			      : "=&d" (tmp)
+			      : "di" (FLUSH_I));
+	}
+}
+EXPORT_SYMBOL(flush_icache_range);
+
+void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+			     unsigned long addr, int len)
+{
+	if (CPU_IS_040_OR_060) {
+		asm volatile ("nop\n\t"
+			      ".chip 68040\n\t"
+			      "cpushp %%bc,(%0)\n\t"
+			      ".chip 68k"
+			      : : "a" (page_to_phys(page)));
+	} else {
+		unsigned long tmp;
+		asm volatile ("movec %%cacr,%0\n\t"
+			      "orw %1,%0\n\t"
+			      "movec %0,%%cacr"
+			      : "=&d" (tmp)
+			      : "di" (FLUSH_I));
+	}
+}
+
Index: linux-2.6/arch/m68k/mm/memory.c
===================================================================
--- linux-2.6.orig/arch/m68k/mm/memory.c	2005-01-13 22:02:21.000000000 +0100
+++ linux-2.6/arch/m68k/mm/memory.c	2005-08-30 02:36:04.863428110 +0200
@@ -354,110 +354,6 @@ void cache_push (unsigned long paddr, in
 #endif
 }
 
-static unsigned long virt_to_phys_slow(unsigned long vaddr)
-{
-	if (CPU_IS_060) {
-		mm_segment_t fs = get_fs();
-		unsigned long paddr;
-
-		set_fs(get_ds());
-
-		/* The PLPAR instruction causes an access error if the translation
-		 * is not possible. To catch this we use the same exception mechanism
-		 * as for user space accesses in <asm/uaccess.h>. */
-		asm volatile (".chip 68060\n"
-			      "1: plpar (%0)\n"
-			      ".chip 68k\n"
-			      "2:\n"
-			      ".section .fixup,\"ax\"\n"
-			      "   .even\n"
-			      "3: sub.l %0,%0\n"
-			      "   jra 2b\n"
-			      ".previous\n"
-			      ".section __ex_table,\"a\"\n"
-			      "   .align 4\n"
-			      "   .long 1b,3b\n"
-			      ".previous"
-			      : "=a" (paddr)
-			      : "0" (vaddr));
-		set_fs(fs);
-		return paddr;
-	} else if (CPU_IS_040) {
-		mm_segment_t fs = get_fs();
-		unsigned long mmusr;
-
-		set_fs(get_ds());
-
-		asm volatile (".chip 68040\n\t"
-			      "ptestr (%1)\n\t"
-			      "movec %%mmusr, %0\n\t"
-			      ".chip 68k"
-			      : "=r" (mmusr)
-			      : "a" (vaddr));
-		set_fs(fs);
-
-		if (mmusr & MMU_R_040)
-			return (mmusr & PAGE_MASK) | (vaddr & ~PAGE_MASK);
-	} else {
-		unsigned short mmusr;
-		unsigned long *descaddr;
-
-		asm volatile ("ptestr #5,%2@,#7,%0\n\t"
-			      "pmove %%psr,%1@"
-			      : "=a&" (descaddr)
-			      : "a" (&mmusr), "a" (vaddr));
-		if (mmusr & (MMU_I|MMU_B|MMU_L))
-			return 0;
-		descaddr = phys_to_virt((unsigned long)descaddr);
-		switch (mmusr & MMU_NUM) {
-		case 1:
-			return (*descaddr & 0xfe000000) | (vaddr & 0x01ffffff);
-		case 2:
-			return (*descaddr & 0xfffc0000) | (vaddr & 0x0003ffff);
-		case 3:
-			return (*descaddr & PAGE_MASK) | (vaddr & ~PAGE_MASK);
-		}
-	}
-	return 0;
-}
-
-/* Push n pages at kernel virtual address and clear the icache */
-/* RZ: use cpush %bc instead of cpush %dc, cinv %ic */
-void flush_icache_range(unsigned long address, unsigned long endaddr)
-{
-	if (CPU_IS_040_OR_060) {
-		address &= PAGE_MASK;
-
-		if (address >= PAGE_OFFSET && address < (unsigned long)high_memory) {
-			do {
-				asm volatile ("nop\n\t"
-					      ".chip 68040\n\t"
-					      "cpushp %%bc,(%0)\n\t"
-					      ".chip 68k"
-					      : : "a" (virt_to_phys((void *)address)));
-				address += PAGE_SIZE;
-			} while (address < endaddr);
-		} else {
-			do {
-				asm volatile ("nop\n\t"
-					      ".chip 68040\n\t"
-					      "cpushp %%bc,(%0)\n\t"
-					      ".chip 68k"
-					      : : "a" (virt_to_phys_slow(address)));
-				address += PAGE_SIZE;
-			} while (address < endaddr);
-		}
-	} else {
-		unsigned long tmp;
-		asm volatile ("movec %%cacr,%0\n\t"
-			      "orw %1,%0\n\t"
-			      "movec %0,%%cacr"
-			      : "=&d" (tmp)
-			      : "di" (FLUSH_I));
-	}
-}
-
-
 #ifndef CONFIG_SINGLE_MEMORY_CHUNK
 int mm_end_of_chunk (unsigned long addr, int len)
 {
Index: linux-2.6/include/asm-m68k/cacheflush.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/cacheflush.h	2005-06-18 18:04:49.000000000 +0200
+++ linux-2.6/include/asm-m68k/cacheflush.h	2005-08-30 02:36:04.863428110 +0200
@@ -130,20 +130,25 @@ static inline void __flush_page_to_ram(v
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_page(vma, page)	__flush_page_to_ram(page_address(page))
-#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
-
-#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-	do {							\
-		flush_cache_page(vma, vaddr, page_to_pfn(page));\
-		memcpy(dst, src, len);				\
-	} while (0)
-
-#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	do {							\
-		flush_cache_page(vma, vaddr, page_to_pfn(page));\
-		memcpy(dst, src, len);				\
-	} while (0)
 
+extern void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+				    unsigned long addr, int len);
 extern void flush_icache_range(unsigned long address, unsigned long endaddr);
 
+static inline void copy_to_user_page(struct vm_area_struct *vma,
+				     struct page *page, unsigned long vaddr,
+				     void *dst, void *src, int len)
+{
+	flush_cache_page(vma, vaddr, page_to_pfn(page));
+	memcpy(dst, src, len);
+	flush_icache_user_range(vma, page, vaddr, len);
+}
+static inline void copy_from_user_page(struct vm_area_struct *vma,
+				       struct page *page, unsigned long vaddr,
+				       void *dst, void *src, int len)
+{
+	flush_cache_page(vma, vaddr, page_to_pfn(page));
+	memcpy(dst, src, len);
+}
+
 #endif /* _M68K_CACHEFLUSH_H */
