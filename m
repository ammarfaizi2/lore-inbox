Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272516AbTGZOmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272515AbTGZOgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:36:07 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:8012 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272516AbTGZOcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:42 -0400
Date: Sat, 26 Jul 2003 16:51:50 +0200
Message-Id: <200307261451.h6QEpopd002382@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k cache
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m68k cache updates (from Roman Zippel):
  - Uninline flush_icache_range()
  - Add virt_to_phys_slow() which handles vmalloc()ed space

--- linux-2.6.x/arch/m68k/mm/memory.c	Tue Mar 25 10:06:08 2003
+++ linux-m68k-2.6.x/arch/m68k/mm/memory.c	Thu Mar 27 10:58:32 2003
@@ -358,6 +358,109 @@
 #endif
 }
 
+static unsigned long virt_to_phys_slow(unsigned long vaddr)
+{
+	if (CPU_IS_060) {
+		mm_segment_t fs = get_fs();
+		unsigned long paddr;
+
+		set_fs(get_ds());
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
+		set_fs(fs);
+		return paddr;
+	} else if (CPU_IS_040) {
+		mm_segment_t fs = get_fs();
+		unsigned long mmusr;
+
+		set_fs(get_ds());
+		
+		asm volatile (".chip 68040\n\t"
+			      "ptestr (%1)\n\t"
+			      "movec %%mmusr, %0\n\t"
+			      ".chip 68k"
+			      : "=r" (mmusr)
+			      : "a" (vaddr));
+		set_fs(fs);
+
+		if (mmusr & MMU_R_040)
+			return (mmusr & PAGE_MASK) | (vaddr & ~PAGE_MASK);
+	} else {
+		unsigned short mmusr;
+		unsigned long *descaddr;
+
+		asm volatile ("ptestr #5,%2@,#7,%0\n\t"
+			      "pmove %%psr,%1@"
+			      : "=a&" (descaddr)
+			      : "a" (&mmusr), "a" (vaddr));
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
+					      : : "a" (virt_to_phys_slow(address)));
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
 
 #ifndef CONFIG_SINGLE_MEMORY_CHUNK
 int mm_end_of_chunk (unsigned long addr, int len)
--- linux-2.6.x/include/asm-m68k/cacheflush.h	Thu Jul 25 12:54:07 2002
+++ linux-m68k-2.6.x/include/asm-m68k/cacheflush.h	Thu Mar 27 10:58:34 2003
@@ -129,30 +129,6 @@
 #define flush_icache_page(vma,pg)              do { } while (0)
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
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
+extern void flush_icache_range(unsigned long address, unsigned long endaddr);
 
 #endif /* _M68K_CACHEFLUSH_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
