Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271441AbTGRJb2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271567AbTGRJb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:31:27 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:22511 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S271441AbTGRJax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:30:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 3/7][v850]  Cleanup v850 cache-flushing code a bit
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030718094536.EAB913702@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 18 Jul 2003 18:45:36 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

(1) Add support for the V850E/ME2 processor

(2) Clean up the cache-flushing function naming a bit

(3) Similar to previous patches, rename everything from `nb85e' to `v850e'.
    This patch renames some files, and so contains a number of whole-file
    add/removes.

diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/nb85e_cache.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/nb85e_cache.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/nb85e_cache.c	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/nb85e_cache.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,178 +0,0 @@
-/*
- * arch/v850/kernel/nb85e_cache.c -- Cache control for NB85E_CACHE212 and
- * 	NB85E_CACHE213 cache memories
- *
- *  Copyright (C) 2003  NEC Electronics Corporation
- *  Copyright (C) 2003  Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- *
- * Written by Miles Bader <miles@gnu.org>
- */
-
-#include <asm/entry.h>
-#include <asm/nb85e_cache.h>
-
-#define WAIT_UNTIL_CLEAR(value) while (value) {}
-
-/* Set caching params via the BHC and DCC registers.  */
-void nb85e_cache_enable (u16 bhc, u16 dcc)
-{
-	unsigned long *r0_ram = (unsigned long *)R0_RAM_ADDR;
-	register u16 bhc_val asm ("r6") = bhc;
-
-	/* Configure data-cache.  */
-	NB85E_CACHE_DCC = dcc;
-
-	/* Configure caching for various memory regions by writing the BHC
-	   register.  The documentation says that an instruction _cannot_
-	   enable/disable caching for the memory region in which the
-	   instruction itself exists; to work around this, we store
-	   appropriate instructions into the on-chip RAM area (which is never
-	   cached), and briefly jump there to do the work.  */
-	r0_ram[0] = 0xf0720760;	/* st.h r0, 0xfffff072[r0] */
-	r0_ram[1] = 0xf06a3760;	/* st.h r6, 0xfffff06a[r0] */
-	r0_ram[2] = 0x5640006b;	/* jmp [r11] */
-	asm ("mov hilo(1f), r11; jmp [%1]; 1:;"
-	     :: "r" (bhc_val), "r" (R0_RAM_ADDR) : "r11");
-}
-
-static void clear_icache (void)
-{
-	/* 1. Read the instruction cache control register (ICC) and confirm
-	      that bits 0 and 1 (TCLR0, TCLR1) are all cleared.  */
-	WAIT_UNTIL_CLEAR (NB85E_CACHE_ICC & 0x3);
-
-	/* 2. Read the ICC register and confirm that bit 12 (LOCK0) is
-  	      cleared.  Bit 13 of the ICC register is always cleared.  */
-	WAIT_UNTIL_CLEAR (NB85E_CACHE_ICC & 0x1000);
-
-	/* 3. Set the TCLR0 and TCLR1 bits of the ICC register as follows,
-	      when clearing way 0 and way 1 at the same time:
-	        (a) Set the TCLR0 and TCLR1 bits.
-		(b) Read the TCLR0 and TCLR1 bits to confirm that these bits
-		    are cleared.
-		(c) Perform (a) and (b) above again.  */
-	NB85E_CACHE_ICC |= 0x3;
-	WAIT_UNTIL_CLEAR (NB85E_CACHE_ICC & 0x3);
-	/* Do it again.  */
-	NB85E_CACHE_ICC |= 0x3;
-	WAIT_UNTIL_CLEAR (NB85E_CACHE_ICC & 0x3);
-}
-
-/* Flush or clear (or both) the data cache, depending on the value of FLAGS;
-   the procedure is the same for both, just the control bits used differ (and
-   both may be performed simultaneously).  */
-static void dcache_op (unsigned short flags)
-{
-	/* 1. Read the data cache control register (DCC) and confirm that bits
-	      0, 1, 4, and 5 (DC00, DC01, DC04, DC05) are all cleared.  */
-	WAIT_UNTIL_CLEAR (NB85E_CACHE_DCC & 0x33);
-
-	/* 2. Clear DCC register bit 12 (DC12), bit 13 (DC13), or both
-	      depending on the way for which tags are to be cleared.  */
-	NB85E_CACHE_DCC &= ~0xC000;
-
-	/* 3. Set DCC register bit 0 (DC00), bit 1 (DC01) or both depending on
-	      the way for which tags are to be cleared.
-	      ...
-	      Set DCC register bit 4 (DC04), bit 5 (DC05), or both depending
-	      on the way to be data flushed.  */
-	NB85E_CACHE_DCC |= flags;
-
-	/* 4. Read DCC register bit DC00, DC01 [DC04, DC05], or both depending
-	      on the way for which tags were cleared [flushed] and confirm
-	      that that bit is cleared.  */
-	WAIT_UNTIL_CLEAR (NB85E_CACHE_DCC & flags);
-}
-
-/* Flushes the contents of the dcache to memory.  */
-static inline void flush_dcache (void)
-{
-	/* We only need to do something if in write-back mode.  */
-	if (NB85E_CACHE_DCC & 0x0400)
-		dcache_op (0x30);
-}
-
-/* Flushes the contents of the dcache to memory, and then clears it.  */
-static inline void clear_dcache (void)
-{
-	/* We only need to do something if the dcache is enabled.  */
-	if (NB85E_CACHE_DCC & 0x0C00)
-		dcache_op (0x33);
-}
-
-/* Clears the dcache without flushing to memory first.  */
-static inline void clear_dcache_no_flush (void)
-{
-	/* We only need to do something if the dcache is enabled.  */
-	if (NB85E_CACHE_DCC & 0x0C00)
-		dcache_op (0x3);
-}
-
-static inline void cache_exec_after_store (void)
-{
-	flush_dcache ();
-	clear_icache ();
-}
-
-
-/* Exported functions.  */
-
-void inline nb85e_cache_flush_all (void)
-{
-	clear_icache ();
-	clear_dcache ();
-}
-
-void nb85e_cache_flush_mm (struct mm_struct *mm)
-{
-	/* nothing */
-}
-
-void nb85e_cache_flush_range (struct mm_struct *mm,
-			      unsigned long start, unsigned long end)
-{
-	/* nothing */
-}
-
-void nb85e_cache_flush_page (struct vm_area_struct *vma,
-			     unsigned long page_addr)
-{
-	/* nothing */
-}
-
-void nb85e_cache_flush_dcache_page (struct page *page)
-{
-	/* nothing */
-}
-
-void nb85e_cache_flush_icache (void)
-{
-	cache_exec_after_store ();
-}
-
-void nb85e_cache_flush_icache_range (unsigned long start, unsigned long end)
-{
-	cache_exec_after_store ();
-}
-
-void nb85e_cache_flush_icache_page (struct vm_area_struct *vma,
-				    struct page *page)
-{
-	cache_exec_after_store ();
-}
-
-void nb85e_cache_flush_icache_user_range (struct vm_area_struct *vma,
-					  struct page *page,
-					  unsigned long adr, int len)
-{
-	cache_exec_after_store ();
-}
-
-void nb85e_cache_flush_sigtramp (unsigned long addr)
-{
-	cache_exec_after_store ();
-}
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/v850e_cache.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/v850e_cache.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/v850e_cache.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/v850e_cache.c	2003-07-17 20:25:27.000000000 +0900
@@ -0,0 +1,173 @@
+/*
+ * arch/v850/kernel/v850e_cache.c -- Cache control for V850E cache memories
+ *
+ *  Copyright (C) 2003  NEC Electronics Corporation
+ *  Copyright (C) 2003  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+/* This file implements cache control for the rather simple cache used on
+   some V850E CPUs, specifically the NB85E/TEG CPU-core and the V850E/ME2
+   CPU.  V850E2 processors have their own (better) cache
+   implementation.  */
+
+#include <asm/entry.h>
+#include <asm/v850e_cache.h>
+
+#define WAIT_UNTIL_CLEAR(value) while (value) {}
+
+/* Set caching params via the BHC and DCC registers.  */
+void v850e_cache_enable (u16 bhc, u16 icc, u16 dcc)
+{
+	unsigned long *r0_ram = (unsigned long *)R0_RAM_ADDR;
+	register u16 bhc_val asm ("r6") = bhc;
+
+	/* Read the instruction cache control register (ICC) and confirm
+	   that bits 0 and 1 (TCLR0, TCLR1) are all cleared.  */
+	WAIT_UNTIL_CLEAR (V850E_CACHE_ICC & 0x3);
+	V850E_CACHE_ICC = icc;
+
+#ifdef V850E_CACHE_DCC
+	/* Configure data-cache.  */
+	V850E_CACHE_DCC = dcc;
+#endif /* V850E_CACHE_DCC */
+
+	/* Configure caching for various memory regions by writing the BHC
+	   register.  The documentation says that an instruction _cannot_
+	   enable/disable caching for the memory region in which the
+	   instruction itself exists; to work around this, we store
+	   appropriate instructions into the on-chip RAM area (which is never
+	   cached), and briefly jump there to do the work.  */
+#ifdef V850E_CACHE_WRITE_IBS
+	*r0_ram++ 	= 0xf0720760;	/* st.h r0, 0xfffff072[r0] */
+#endif
+	*r0_ram++ 	= 0xf06a3760;	/* st.h r6, 0xfffff06a[r0] */
+	*r0_ram 	= 0x5640006b;	/* jmp [r11] */
+
+	asm ("mov hilo(1f), r11; jmp [%1]; 1:;"
+	     :: "r" (bhc_val), "r" (R0_RAM_ADDR) : "r11");
+}
+
+static void clear_icache (void)
+{
+	/* 1. Read the instruction cache control register (ICC) and confirm
+	      that bits 0 and 1 (TCLR0, TCLR1) are all cleared.  */
+	WAIT_UNTIL_CLEAR (V850E_CACHE_ICC & 0x3);
+
+	/* 2. Read the ICC register and confirm that bit 12 (LOCK0) is
+  	      cleared.  Bit 13 of the ICC register is always cleared.  */
+	WAIT_UNTIL_CLEAR (V850E_CACHE_ICC & 0x1000);
+
+	/* 3. Set the TCLR0 and TCLR1 bits of the ICC register as follows,
+	      when clearing way 0 and way 1 at the same time:
+	        (a) Set the TCLR0 and TCLR1 bits.
+		(b) Read the TCLR0 and TCLR1 bits to confirm that these bits
+		    are cleared.
+		(c) Perform (a) and (b) above again.  */
+	V850E_CACHE_ICC |= 0x3;
+	WAIT_UNTIL_CLEAR (V850E_CACHE_ICC & 0x3);
+
+#ifdef V850E_CACHE_REPEAT_ICC_WRITE
+	/* Do it again.  */
+	V850E_CACHE_ICC |= 0x3;
+	WAIT_UNTIL_CLEAR (V850E_CACHE_ICC & 0x3);
+#endif
+}
+
+#ifdef V850E_CACHE_DCC
+/* Flush or clear (or both) the data cache, depending on the value of FLAGS;
+   the procedure is the same for both, just the control bits used differ (and
+   both may be performed simultaneously).  */
+static void dcache_op (unsigned short flags)
+{
+	/* 1. Read the data cache control register (DCC) and confirm that bits
+	      0, 1, 4, and 5 (DC00, DC01, DC04, DC05) are all cleared.  */
+	WAIT_UNTIL_CLEAR (V850E_CACHE_DCC & 0x33);
+
+	/* 2. Clear DCC register bit 12 (DC12), bit 13 (DC13), or both
+	      depending on the way for which tags are to be cleared.  */
+	V850E_CACHE_DCC &= ~0xC000;
+
+	/* 3. Set DCC register bit 0 (DC00), bit 1 (DC01) or both depending on
+	      the way for which tags are to be cleared.
+	      ...
+	      Set DCC register bit 4 (DC04), bit 5 (DC05), or both depending
+	      on the way to be data flushed.  */
+	V850E_CACHE_DCC |= flags;
+
+	/* 4. Read DCC register bit DC00, DC01 [DC04, DC05], or both depending
+	      on the way for which tags were cleared [flushed] and confirm
+	      that that bit is cleared.  */
+	WAIT_UNTIL_CLEAR (V850E_CACHE_DCC & flags);
+}
+#endif /* V850E_CACHE_DCC */
+
+/* Flushes the contents of the dcache to memory.  */
+static inline void flush_dcache (void)
+{
+#ifdef V850E_CACHE_DCC
+	/* We only need to do something if in write-back mode.  */
+	if (V850E_CACHE_DCC & 0x0400)
+		dcache_op (0x30);
+#endif /* V850E_CACHE_DCC */
+}
+
+/* Flushes the contents of the dcache to memory, and then clears it.  */
+static inline void clear_dcache (void)
+{
+#ifdef V850E_CACHE_DCC
+	/* We only need to do something if the dcache is enabled.  */
+	if (V850E_CACHE_DCC & 0x0C00)
+		dcache_op (0x33);
+#endif /* V850E_CACHE_DCC */
+}
+
+/* Clears the dcache without flushing to memory first.  */
+static inline void clear_dcache_no_flush (void)
+{
+#ifdef V850E_CACHE_DCC
+	/* We only need to do something if the dcache is enabled.  */
+	if (V850E_CACHE_DCC & 0x0C00)
+		dcache_op (0x3);
+#endif /* V850E_CACHE_DCC */
+}
+
+static inline void cache_exec_after_store (void)
+{
+	flush_dcache ();
+	clear_icache ();
+}
+
+
+/* Exported functions.  */
+
+void flush_icache (void)
+{
+	cache_exec_after_store ();
+}
+
+void flush_icache_range (unsigned long start, unsigned long end)
+{
+	cache_exec_after_store ();
+}
+
+void flush_icache_page (struct vm_area_struct *vma, struct page *page)
+{
+	cache_exec_after_store ();
+}
+
+void flush_icache_user_range (struct vm_area_struct *vma, struct page *page,
+			      unsigned long adr, int len)
+{
+	cache_exec_after_store ();
+}
+
+void flush_cache_sigtramp (unsigned long addr)
+{
+	cache_exec_after_store ();
+}
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/cacheflush.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/cacheflush.h
--- linux-2.6.0-test1-moo/include/asm-v850/cacheflush.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/cacheflush.h	2003-07-17 20:25:27.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/cacheflush.h
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -21,21 +21,40 @@
 #include <asm/machdep.h>
 
 
-#ifndef flush_cache_all
-/* If there's no flush_cache_all macro defined by <asm/machdep.h>, then
-   this processor has no cache, so just define these as nops.  */
-
+/* The following are all used by the kernel in ways that only affect
+   systems with MMUs, so we don't need them.  */
 #define flush_cache_all()			((void)0)
 #define flush_cache_mm(mm)			((void)0)
 #define flush_cache_range(vma, start, end)	((void)0)
 #define flush_cache_page(vma, vmaddr)		((void)0)
 #define flush_dcache_page(page)			((void)0)
+
+#ifdef CONFIG_NO_CACHE
+
+/* Some systems have no cache at all, in which case we don't need these
+   either.  */
 #define flush_icache()				((void)0)
 #define flush_icache_range(start, end)		((void)0)
 #define flush_icache_page(vma,pg)		((void)0)
 #define flush_icache_user_range(vma,pg,adr,len)	((void)0)
 #define flush_cache_sigtramp(vaddr)		((void)0)
 
-#endif /* !flush_cache_all */
+#else /* !CONFIG_NO_CACHE */
+
+struct page;
+struct mm_struct;
+struct vm_area_struct;
+
+/* Otherwise, somebody had better define them.  */
+extern void flush_icache (void);
+extern void flush_icache_range (unsigned long start, unsigned long end);
+extern void flush_icache_page (struct vm_area_struct *vma, struct page *page);
+extern void flush_icache_user_range (struct vm_area_struct *vma,
+				     struct page *page,
+				     unsigned long adr, int len);
+extern void flush_cache_sigtramp (unsigned long addr);
+
+#endif /* CONFIG_NO_CACHE */
+
 
 #endif /* __V850_CACHEFLUSH_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/nb85e_cache.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/nb85e_cache.h
--- linux-2.6.0-test1-moo/include/asm-v850/nb85e_cache.h	2003-06-16 14:53:02.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/nb85e_cache.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,78 +0,0 @@
-/*
- * include/asm-v850/nb85e_cache_cache.h -- Cache control for NB85E_CACHE212 and
- * 	NB85E_CACHE213 cache memories
- *
- *  Copyright (C) 2001,03  NEC Electronics Corporation
- *  Copyright (C) 2001,03  Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- *
- * Written by Miles Bader <miles@gnu.org>
- */
-
-#ifndef __V850_NB85E_CACHE_H__
-#define __V850_NB85E_CACHE_H__
-
-#include <asm/types.h>
-
-
-/* Cache control registers.  */
-#define NB85E_CACHE_BHC_ADDR	0xFFFFF06A
-#define NB85E_CACHE_BHC		(*(volatile u16 *)NB85E_CACHE_BHC_ADDR)
-#define NB85E_CACHE_ICC_ADDR	0xFFFFF070
-#define NB85E_CACHE_ICC		(*(volatile u16 *)NB85E_CACHE_ICC_ADDR)
-#define NB85E_CACHE_ISI_ADDR	0xFFFFF072
-#define NB85E_CACHE_ISI		(*(volatile u16 *)NB85E_CACHE_ISI_ADDR)
-#define NB85E_CACHE_DCC_ADDR	0xFFFFF078
-#define NB85E_CACHE_DCC		(*(volatile u16 *)NB85E_CACHE_DCC_ADDR)
-
-/* Size of a cache line in bytes.  */
-#define NB85E_CACHE_LINE_SIZE	16
-
-/* For <asm/cache.h> */
-#define L1_CACHE_BYTES				NB85E_CACHE_LINE_SIZE
-
-
-#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
-
-/* Set caching params via the BHC and DCC registers.  */
-void nb85e_cache_enable (u16 bhc, u16 dcc);
-
-struct page;
-struct mm_struct;
-struct vm_area_struct;
-
-extern void nb85e_cache_flush_all (void);
-extern void nb85e_cache_flush_mm (struct mm_struct *mm);
-extern void nb85e_cache_flush_range (struct mm_struct *mm,
-				     unsigned long start,
-				     unsigned long end);
-extern void nb85e_cache_flush_page (struct vm_area_struct *vma,
-				    unsigned long page_addr);
-extern void nb85e_cache_flush_dcache_page (struct page *page);
-extern void nb85e_cache_flush_icache (void);
-extern void nb85e_cache_flush_icache_range (unsigned long start,
-					    unsigned long end);
-extern void nb85e_cache_flush_icache_page (struct vm_area_struct *vma,
-					   struct page *page);
-extern void nb85e_cache_flush_icache_user_range (struct vm_area_struct *vma,
-						 struct page *page,
-						 unsigned long adr, int len);
-extern void nb85e_cache_flush_sigtramp (unsigned long addr);
-
-#define flush_cache_all		nb85e_cache_flush_all
-#define flush_cache_mm		nb85e_cache_flush_mm
-#define flush_cache_range	nb85e_cache_flush_range
-#define flush_cache_page	nb85e_cache_flush_page
-#define flush_dcache_page	nb85e_cache_flush_dcache_page
-#define flush_icache		nb85e_cache_flush_icache
-#define flush_icache_range	nb85e_cache_flush_icache_range
-#define flush_icache_page	nb85e_cache_flush_icache_page
-#define flush_icache_user_range	nb85e_cache_flush_icache_user_range
-#define flush_cache_sigtramp	nb85e_cache_flush_sigtramp
-
-#endif /* __KERNEL__ && !__ASSEMBLY__ */
-
-#endif /* __V850_NB85E_CACHE_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/v850e_cache.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_cache.h
--- linux-2.6.0-test1-moo/include/asm-v850/v850e_cache.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e_cache.h	2003-07-17 20:25:27.000000000 +0900
@@ -0,0 +1,48 @@
+/*
+ * include/asm-v850/v850e_cache.h -- Cache control for V850E cache memories
+ *
+ *  Copyright (C) 2001,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+/* This file implements cache control for the rather simple cache used on
+   some V850E CPUs, specifically the NB85E/TEG CPU-core and the V850E/ME2
+   CPU.  V850E2 processors have their own (better) cache
+   implementation.  */
+
+#ifndef __V850_V850E_CACHE_H__
+#define __V850_V850E_CACHE_H__
+
+#include <asm/types.h>
+
+
+/* Cache control registers.  */
+#define V850E_CACHE_BHC_ADDR	0xFFFFF06A
+#define V850E_CACHE_BHC		(*(volatile u16 *)V850E_CACHE_BHC_ADDR)
+#define V850E_CACHE_ICC_ADDR	0xFFFFF070
+#define V850E_CACHE_ICC		(*(volatile u16 *)V850E_CACHE_ICC_ADDR)
+#define V850E_CACHE_ISI_ADDR	0xFFFFF072
+#define V850E_CACHE_ISI		(*(volatile u16 *)V850E_CACHE_ISI_ADDR)
+#define V850E_CACHE_DCC_ADDR	0xFFFFF078
+#define V850E_CACHE_DCC		(*(volatile u16 *)V850E_CACHE_DCC_ADDR)
+
+/* Size of a cache line in bytes.  */
+#define V850E_CACHE_LINE_SIZE	16
+
+/* For <asm/cache.h> */
+#define L1_CACHE_BYTES		V850E_CACHE_LINE_SIZE
+
+
+#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+/* Set caching params via the BHC, ICC, and DCC registers.  */
+void v850e_cache_enable (u16 bhc, u16 icc, u16 dcc);
+#endif /* __KERNEL__ && !__ASSEMBLY__ */
+
+
+#endif /* __V850_V850E_CACHE_H__ */
