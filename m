Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbTH2O6F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbTH2O5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:57:11 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:44612 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261322AbTH2OwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:52:07 -0400
Date: Fri, 29 Aug 2003 16:51:14 +0200
Message-Id: <200308291451.h7TEpE8k005932@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k cache
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k icache flush fixes from Roman Zippel:
  - uninline flush_icache_range() and rename it to flush_icache_user_range()
  - add virt_to_phys_slow() which handles vmalloc()ed space
  - add flush_icache_range and flush_icache_user_page

--- linux-2.4.23-pre1/arch/m68k/kernel/m68k_ksyms.c	Thu Jul 10 16:22:26 2003
+++ linux-m68k-2.4.23-pre1/arch/m68k/kernel/m68k_ksyms.c	Fri Jul 25 20:02:38 2003
@@ -48,6 +48,7 @@
 EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(kernel_set_cachemode);
 #endif /* !CONFIG_SUN3 */
+EXPORT_SYMBOL(flush_icache_user_range);
 EXPORT_SYMBOL(m68k_debug_device);
 EXPORT_SYMBOL(mach_hwclk);
 EXPORT_SYMBOL(mach_get_ss);
--- linux-2.4.23-pre1/arch/m68k/mm/Makefile	Sun Apr  6 10:28:29 2003
+++ linux-m68k-2.4.23-pre1/arch/m68k/mm/Makefile	Fri Jul 25 20:02:43 2003
@@ -9,7 +9,7 @@
 
 O_TARGET := mm.o
 
-obj-y		:= init.o fault.o extable.o hwtest.o
+obj-y		:= cache.o init.o fault.o extable.o hwtest.o
 
 ifndef CONFIG_SUN3
 obj-y		+= kmap.o memory.o motorola.o
--- linux-2.4.23-pre1/arch/m68k/mm/cache.c	Thu Jan  1 01:00:00 1970
+++ linux-m68k-2.4.23-pre1/arch/m68k/mm/cache.c	Fri Jul 25 20:02:43 2003
@@ -0,0 +1,167 @@
+/*
+ *  linux/arch/m68k/mm/cache.c
+ *
+ *  Instruction cache handling
+ *
+ *  Copyright (C) 1995  Hamish Macdonald
+ */
+
+#include <linux/config.h>
+#include <linux/pagemap.h>
+
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <asm/segment.h>
+#include <asm/setup.h>
+#include <asm/traps.h>
+#include <asm/virtconvert.h>
+
+
+static unsigned long virt_to_phys_slow(unsigned long vaddr, mm_segment_t fs)
+{
+	if (CPU_IS_060) {
+		mm_segment_t old_fs = get_fs();
+		unsigned long paddr;
+
+		set_fs(fs);
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
+		set_fs(old_fs);
+		return paddr;
+	} else if (CPU_IS_040) {
+		mm_segment_t old_fs = get_fs();
+		unsigned long mmusr;
+
+		set_fs(fs);
+		
+		asm volatile (".chip 68040\n\t"
+			      "ptestr (%1)\n\t"
+			      "movec %%mmusr, %0\n\t"
+			      ".chip 68k"
+			      : "=r" (mmusr)
+			      : "a" (vaddr));
+		set_fs(old_fs);
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
+			      : "a" (&mmusr), "a" (vaddr), "d" (fs.seg));
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
+	if (CPU_IS_040_OR_060) {
+		address &= PAGE_MASK;
+
+		if (address >= PAGE_OFFSET && address < (unsigned long)high_memory) {
+			do {
+				asm volatile ("nop\n\t"
+					      ".chip 68040\n\t"
+					      "cpushp %%bc,(%0)\n\t"
+					      ".chip 68k"
+					      : : "a" (virt_to_phys((void *)address)));
+				address += PAGE_SIZE;
+			} while (address < endaddr);
+		} else {
+			do {
+				asm volatile ("nop\n\t"
+					      ".chip 68040\n\t"
+					      "cpushp %%bc,(%0)\n\t"
+					      ".chip 68k"
+					      : : "a" (virt_to_phys_slow(address, KERNEL_DS)));
+				address += PAGE_SIZE;
+			} while (address < endaddr);
+		}
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
+void flush_icache_user_range(void *addr, unsigned long size)
+{
+	unsigned long address = (unsigned long)addr;
+	unsigned long endaddr = address + size;
+
+	if (CPU_IS_040_OR_060) {
+		address &= PAGE_MASK;
+
+		do {
+			asm volatile ("nop\n\t"
+				      ".chip 68040\n\t"
+				      "cpushp %%bc,(%0)\n\t"
+				      ".chip 68k"
+				      : : "a" (virt_to_phys_slow(address, get_fs())));
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
+
+void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
+			    unsigned long addr, int len)
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
--- linux-2.4.23-pre1/include/asm-m68k/pgalloc.h	Tue Mar 12 09:51:43 2002
+++ linux-m68k-2.4.23-pre1/include/asm-m68k/pgalloc.h	Fri Jul 25 20:02:38 2003
@@ -127,35 +127,12 @@
 
 #define flush_dcache_page(page)			do { } while (0)
 #define flush_icache_page(vma,pg)              do { } while (0)
-#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
-
-/* Push n pages at kernel virtual address and clear the icache */
-/* RZ: use cpush %bc instead of cpush %dc, cinv %ic */
-extern inline void flush_icache_range (unsigned long address,
-				       unsigned long endaddr)
-{
-	if (CPU_IS_040_OR_060) {
-		short n = (endaddr - address + PAGE_SIZE - 1) / PAGE_SIZE;
-
-		while (--n >= 0) {
-			__asm__ __volatile__("nop\n\t"
-					     ".chip 68040\n\t"
-					     "cpushp %%bc,(%0)\n\t"
-					     ".chip 68k"
-					     : : "a" (virt_to_phys((void *)address)));
-			address += PAGE_SIZE;
-		}
-	} else {
-		unsigned long tmp;
-		__asm__ __volatile__("movec %%cacr,%0\n\t"
-				     "orw %1,%0\n\t"
-				     "movec %0,%%cacr"
-				     : "=&d" (tmp)
-				     : "di" (FLUSH_I));
-	}
-}
 
+extern void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
+				   unsigned long addr, int len);
 
+extern void flush_icache_range(unsigned long address, unsigned long endaddr);
+extern void flush_icache_user_range(void *address, unsigned long size);
 
 
 #ifdef CONFIG_SUN3
--- linux-2.4.23-pre1/kernel/ptrace.c	Wed May 28 13:11:52 2003
+++ linux-m68k-2.4.23-pre1/kernel/ptrace.c	Fri Jul 25 20:02:39 2003
@@ -165,7 +165,7 @@
 		if (write) {
 			memcpy(maddr + offset, buf, bytes);
 			flush_page_to_ram(page);
-			flush_icache_user_range(vma, page, addr, len);
+			flush_icache_user_page(vma, page, addr, len);
 			set_page_dirty(page);
 		} else {
 			memcpy(buf, maddr + offset, bytes);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
