Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTALMG7>; Sun, 12 Jan 2003 07:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTALMG7>; Sun, 12 Jan 2003 07:06:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41222 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261486AbTALMGq>; Sun, 12 Jan 2003 07:06:46 -0500
To: Linus Torvalds <torvalds@transmeta.com>
CC: LKML <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 2.5.56-bug
Message-Id: <E18Xh1V-0000R7-00@raistlin.arm.linux.org.uk>
Date: Sun, 12 Jan 2003 12:15:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.56, but applies cleanly.

This patch moves BUG() and PAGE_BUG() from asm/page.h into asm/bug.h.

We also fix up linux/dcache.h, which included asm/page.h for the sole
purpose of getting the BUG() definition.

Since linux/kernel.h and linux/smp.h make use of BUG(), asm/bug.h is
included there as well.

In addition, linux/jbd.h did not contain a clear path with which to
obtain the archtecture BUG() definition, but did contain its own
definition.

Please apply.


 include/asm-alpha/bug.h     |   14 ++++++++++++++
 include/asm-alpha/page.h    |    8 --------
 include/asm-arm/bug.h       |   21 +++++++++++++++++++++
 include/asm-arm/page.h      |   15 ---------------
 include/asm-cris/bug.h      |   12 ++++++++++++
 include/asm-cris/page.h     |   12 ------------
 include/asm-i386/bug.h      |   27 +++++++++++++++++++++++++++
 include/asm-i386/page.h     |   21 ---------------------
 include/asm-ia64/bug.h      |   12 ++++++++++++
 include/asm-ia64/page.h     |    8 --------
 include/asm-m68k/bug.h      |   28 ++++++++++++++++++++++++++++
 include/asm-m68k/page.h     |   22 ----------------------
 include/asm-mips/bug.h      |    8 ++++++++
 include/asm-mips/page.h     |    3 ---
 include/asm-mips64/bug.h    |    7 +++++++
 include/asm-mips64/page.h   |    3 ---
 include/asm-parisc/bug.h    |   18 ++++++++++++++++++
 include/asm-parisc/page.h   |   14 --------------
 include/asm-ppc/bug.h       |   21 +++++++++++++++++++++
 include/asm-ppc/page.h      |    3 ---
 include/asm-ppc/processor.h |   13 -------------
 include/asm-s390/bug.h      |   13 +++++++++++++
 include/asm-s390/page.h     |    9 ---------
 include/asm-s390x/bug.h     |   13 +++++++++++++
 include/asm-s390x/page.h    |    9 ---------
 include/asm-sh/bug.h        |   16 ++++++++++++++++
 include/asm-sh/page.h       |   12 ------------
 include/asm-sparc/bug.h     |   25 +++++++++++++++++++++++++
 include/asm-sparc/page.h    |   20 --------------------
 include/asm-sparc64/bug.h   |   17 +++++++++++++++++
 include/asm-sparc64/page.h  |   12 ------------
 include/linux/dcache.h      |    2 +-
 include/linux/jbd.h         |    9 +--------
 include/linux/kernel.h      |    1 +
 include/linux/smp.h         |    2 +-
 35 files changed, 256 insertions, 194 deletions

diff -urN orig/include/asm-alpha/bug.h linux/include/asm-alpha/bug.h
--- orig/include/asm-alpha/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-alpha/bug.h	Sun Feb 24 16:51:44 2002
@@ -0,0 +1,14 @@
+#ifndef _ALPHA_BUG_H
+#define _ALPHA_BUG_H
+
+#include <asm/pal.h>
+
+/* ??? Would be nice to use .gprel32 here, but we can't be sure that the
+   function loaded the GP, so this could fail in modules.  */
+#define BUG() \
+  __asm__ __volatile__("call_pal %0  # bugchk\n\t"".long %1\n\t.8byte %2" \
+		       : : "i" (PAL_bugchk), "i"(__LINE__), "i"(__FILE__))
+
+#define PAGE_BUG(page)	BUG()
+
+#endif
diff -urN orig/include/asm-alpha/page.h linux/include/asm-alpha/page.h
--- orig/include/asm-alpha/page.h	Tue Mar  5 19:56:30 2002
+++ linux/include/asm-alpha/page.h	Sun Feb 24 16:47:52 2002
@@ -58,14 +58,6 @@
 #define __pgprot(x)	(x)
 
 #endif /* STRICT_MM_TYPECHECKS */
-
-/* ??? Would be nice to use .gprel32 here, but we can't be sure that the
-   function loaded the GP, so this could fail in modules.  */
-#define BUG() \
-  __asm__ __volatile__("call_pal %0  # bugchk\n\t"".long %1\n\t.8byte %2" \
-		       : : "i" (PAL_bugchk), "i"(__LINE__), "i"(__FILE__))
-
-#define PAGE_BUG(page)	BUG()
 
 /* Pure 2^n version of get_order */
 extern __inline__ int get_order(unsigned long size)
diff -urN orig/include/asm-arm/bug.h linux/include/asm-arm/bug.h
--- orig/include/asm-arm/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-arm/bug.h	Tue May 21 17:24:33 2002
@@ -0,0 +1,20 @@
+#ifndef _ASMARM_BUG_H
+#define _ASMARM_BUG_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+extern volatile void __bug(const char *file, int line, void *data);
+
+/* give file/line information */
+#define BUG()		__bug(__FILE__, __LINE__, NULL)
+#define PAGE_BUG(page)	__bug(__FILE__, __LINE__, page)
+
+#else
+
+/* these just cause an oops */
+#define BUG()		(*(int *)0 = 0)
+#define PAGE_BUG(page)	(*(int *)0 = 0)
+
+#endif
+
+#endif
diff -ur orig/include/asm-arm/page.h linux/include/asm-arm/page.h
--- orig/include/asm-arm/page.h	Wed Oct 16 09:17:08 2002
+++ linux/include/asm-arm/page.h	Thu Oct 10 12:14:05 2002
@@ -160,21 +160,6 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-extern void __bug(const char *file, int line, void *data);
-
-/* give file/line information */
-#define BUG()		__bug(__FILE__, __LINE__, NULL)
-#define PAGE_BUG(page)	__bug(__FILE__, __LINE__, page)
-
-#else
-
-/* these just cause an oops */
-#define BUG()		(*(int *)0 = 0)
-#define PAGE_BUG(page)	(*(int *)0 = 0)
-
-#endif
-
 /* Pure 2^n version of get_order */
 static inline int get_order(unsigned long size)
 {
diff -urN orig/include/asm-cris/bug.h linux/include/asm-cris/bug.h
--- orig/include/asm-cris/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-cris/bug.h	Sun Jan  6 11:46:09 2002
@@ -0,0 +1,12 @@
+#ifndef _CRIS_BUG_H
+#define _CRIS_BUG_H
+
+#define BUG() do { \
+  printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+} while (0)
+
+#define PAGE_BUG(page) do { \
+         BUG(); \
+} while (0)
+
+#endif
diff -urN orig/include/asm-cris/page.h linux/include/asm-cris/page.h
--- orig/include/asm-cris/page.h	Tue Mar  5 19:56:30 2002
+++ linux/include/asm-cris/page.h	Sun Feb 24 16:47:53 2002
@@ -69,18 +69,6 @@
 #else
 #define PAGE_OFFSET		KSEG_C   /* kseg_c is mapped to physical ram */
 #endif
-
-#ifndef __ASSEMBLY__
-
-#define BUG() do { \
-  printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-} while (0)
-
-#define PAGE_BUG(page) do { \
-         BUG(); \
-} while (0)
-
-#endif /* __ASSEMBLY__ */
 
 /* macros to convert between really physical and virtual addresses
  * by stripping a selected bit, we can convert between KSEG_x and 0x40000000 where
diff -urN orig/include/asm-i386/bug.h linux/include/asm-i386/bug.h
--- orig/include/asm-i386/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-i386/bug.h	Tue Feb 26 13:19:26 2002
@@ -0,0 +1,27 @@
+#ifndef _I386_BUG_H
+#define _I386_BUG_H
+
+#include <linux/config.h>
+
+/*
+ * Tell the user there is some problem. Beep too, so we can
+ * see^H^H^Hhear bugs in early bootup as well!
+ * The offending file and line are encoded after the "officially
+ * undefined" opcode for parsing in the trap handler.
+ */
+
+#if 1	/* Set to zero for a slightly smaller kernel */
+#define BUG()				\
+ __asm__ __volatile__(	"ud2\n"		\
+			"\t.word %c0\n"	\
+			"\t.long %c1\n"	\
+			 : : "i" (__LINE__), "i" (__FILE__))
+#else
+#define BUG() __asm__ __volatile__("ud2\n")
+#endif
+
+#define PAGE_BUG(page) do { \
+	BUG(); \
+} while (0)
+
+#endif
diff -urN orig/include/asm-i386/page.h linux/include/asm-i386/page.h
--- orig/include/asm-i386/page.h	Sat Jul  6 17:36:36 2002
+++ linux/include/asm-i386/page.h	Sat Jun 22 01:04:04 2002
@@ -98,27 +98,6 @@
 #define __VMALLOC_RESERVE	(128 << 20)
 
 #ifndef __ASSEMBLY__
-
-/*
- * Tell the user there is some problem. Beep too, so we can
- * see^H^H^Hhear bugs in early bootup as well!
- * The offending file and line are encoded after the "officially
- * undefined" opcode for parsing in the trap handler.
- */
-
-#if 1	/* Set to zero for a slightly smaller kernel */
-#define BUG()				\
- __asm__ __volatile__(	"ud2\n"		\
-			"\t.word %c0\n"	\
-			"\t.long %c1\n"	\
-			 : : "i" (__LINE__), "i" (__FILE__))
-#else
-#define BUG() __asm__ __volatile__("ud2\n")
-#endif
-
-#define PAGE_BUG(page) do { \
-	BUG(); \
-} while (0)
 
 /* Pure 2^n version of get_order */
 static __inline__ int get_order(unsigned long size)
diff -urN orig/include/asm-ia64/bug.h linux/include/asm-ia64/bug.h
--- orig/include/asm-ia64/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-ia64/bug.h	Sun Jan  6 11:57:28 2002
@@ -0,0 +1,12 @@
+#ifndef _ASM_IA64_BUG_H
+#define _ASM_IA64_BUG_H
+
+#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+# define ia64_abort()	__builtin_trap()
+#else
+# define ia64_abort()	(*(volatile int *) 0 = 0)
+#endif
+#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); ia64_abort(); } while (0)
+#define PAGE_BUG(page) do { BUG(); } while (0)
+
+#endif
diff -urN orig/include/asm-ia64/page.h linux/include/asm-ia64/page.h
--- orig/include/asm-ia64/page.h	Wed May 29 21:40:41 2002
+++ linux/include/asm-ia64/page.h	Wed May 29 21:57:51 2002
@@ -124,14 +124,6 @@
 				 | (REGION_OFFSET(x) >> (HPAGE_SHIFT-PAGE_SHIFT)))
 # define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 #endif
-
-#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
-# define ia64_abort()	__builtin_trap()
-#else
-# define ia64_abort()	(*(volatile int *) 0 = 0)
-#endif
-#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); ia64_abort(); } while (0)
-#define PAGE_BUG(page) do { BUG(); } while (0)
 
 static __inline__ int
 get_order (unsigned long size)
diff -urN orig/include/asm-m68k/bug.h linux/include/asm-m68k/bug.h
--- orig/include/asm-m68k/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-m68k/bug.h	Thu Jul 25 20:17:16 2002
@@ -0,0 +1,28 @@
+#ifndef _M68K_BUG_H
+#define _M68K_BUG_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#ifndef CONFIG_SUN3
+#define BUG() do { \
+	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+	asm volatile("illegal"); \
+} while (0)
+#else
+#define BUG() do { \
+	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+	panic("BUG!"); \
+} while (0)
+#endif
+#else
+#define BUG() do { \
+	asm volatile("illegal"); \
+} while (0)
+#endif
+
+#define PAGE_BUG(page) do { \
+	BUG(); \
+} while (0)
+
+#endif
diff -urN orig/include/asm-m68k/page.h linux/include/asm-m68k/page.h
--- orig/include/asm-m68k/page.h	Thu Jul 25 20:13:52 2002
+++ linux/include/asm-m68k/page.h	Thu Jul 25 20:17:19 2002
@@ -177,28 +177,6 @@
 
 #define virt_addr_valid(kaddr)	((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
 #define pfn_valid(pfn)		virt_addr_valid(pfn_to_virt(pfn))
-
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-#ifndef CONFIG_SUN3
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	asm volatile("illegal"); \
-} while (0)
-#else
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	panic("BUG!"); \
-} while (0)
-#endif
-#else
-#define BUG() do { \
-	asm volatile("illegal"); \
-} while (0)
-#endif
-
-#define PAGE_BUG(page) do { \
-	BUG(); \
-} while (0)
 
 #endif /* __ASSEMBLY__ */
 
diff -urN orig/include/asm-mips/bug.h linux/include/asm-mips/bug.h
--- orig/include/asm-mips/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-mips/bug.h	Sun Jan  6 11:57:49 2002
@@ -0,0 +1,8 @@
+/* $Id$ */
+#ifndef __ASM_BUG_H
+#define __ASM_BUG_H
+
+#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
+#define PAGE_BUG(page) do {  BUG(); } while (0)
+
+#endif
diff -urN orig/include/asm-mips/page.h linux/include/asm-mips/page.h
--- orig/include/asm-mips/page.h	Tue Mar  5 19:56:31 2002
+++ linux/include/asm-mips/page.h	Sun Feb 24 16:47:53 2002
@@ -20,9 +20,6 @@
 
 #ifndef _LANGUAGE_ASSEMBLY
 
-#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
-#define PAGE_BUG(page) do {  BUG(); } while (0)
-
 extern void (*_clear_page)(void * page);
 extern void (*_copy_page)(void * to, void * from);
 
diff -urN orig/include/asm-mips64/bug.h linux/include/asm-mips64/bug.h
--- orig/include/asm-mips64/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-mips64/bug.h	Sun Jan  6 11:51:12 2002
@@ -0,0 +1,7 @@
+#ifndef _ASM_BUG_H
+#define _ASM_BUG_H
+
+#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
+#define PAGE_BUG(page) do {  BUG(); } while (0)
+
+#endif
diff -urN orig/include/asm-mips64/page.h linux/include/asm-mips64/page.h
--- orig/include/asm-mips64/page.h	Tue Mar  5 19:56:31 2002
+++ linux/include/asm-mips64/page.h	Sun Feb 24 16:47:54 2002
@@ -20,9 +20,6 @@
 
 #ifndef _LANGUAGE_ASSEMBLY
 
-#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
-#define PAGE_BUG(page) do {  BUG(); } while (0)
-
 extern void (*_clear_page)(void * page);
 extern void (*_copy_page)(void * to, void * from);
 
diff -urN orig/include/asm-parisc/bug.h linux/include/asm-parisc/bug.h
--- orig/include/asm-parisc/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-parisc/bug.h	Sun Jan  6 11:51:59 2002
@@ -0,0 +1,18 @@
+#ifndef _PARISC_BUG_H
+#define _PARISC_BUG_H
+
+/*
+ * Tell the user there is some problem. Beep too, so we can
+ * see^H^H^Hhear bugs in early bootup as well!
+ *
+ * We don't beep yet.  prumpf
+ */
+#define BUG() do { \
+	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+} while (0)
+
+#define PAGE_BUG(page) do { \
+	BUG(); \
+} while (0)
+
+#endif
diff -urN orig/include/asm-parisc/page.h linux/include/asm-parisc/page.h
--- orig/include/asm-parisc/page.h	Tue Mar  5 19:56:31 2002
+++ linux/include/asm-parisc/page.h	Sun Feb 24 16:47:54 2002
@@ -85,20 +85,6 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
-/*
- * Tell the user there is some problem. Beep too, so we can
- * see^H^H^Hhear bugs in early bootup as well!
- *
- * We don't beep yet.  prumpf
- */
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-} while (0)
-
-#define PAGE_BUG(page) do { \
-	BUG(); \
-} while (0)
 
 
 #define LINUX_GATEWAY_SPACE     0
diff -urN orig/include/asm-ppc/bug.h linux/include/asm-ppc/bug.h
--- orig/include/asm-ppc/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-ppc/bug.h	Sun Jan  6 11:58:18 2002
@@ -0,0 +1,21 @@
+#ifndef _PPC_BUG_H
+#define _PPC_BUG_H
+
+#include <linux/config.h>
+#include <asm/system.h> /* for xmon definition */
+
+#ifdef CONFIG_XMON
+extern void xmon(struct pt_regs *);
+#define BUG() do { \
+	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+	xmon(0); \
+} while (0)
+#else
+#define BUG() do { \
+	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+	__asm__ __volatile__(".long 0x0"); \
+} while (0)
+#endif
+#define PAGE_BUG(page) do { BUG(); } while (0)
+
+#endif
diff -urN orig/include/asm-ppc/processor.h linux/include/asm-ppc/processor.h
--- orig/include/asm-ppc/processor.h	Thu Jan  9 10:40:20 2003
+++ linux/include/asm-ppc/processor.h	Thu Jan 12 10:34:47 2003
@@ -718,19 +718,6 @@
 
 #define spin_lock_prefetch(x)	prefetchw(x)
 
-#ifdef CONFIG_XMON
-extern void xmon(struct pt_regs *);
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	xmon(0); \
-} while (0)
-#else
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	__asm__ __volatile__(".long 0x0"); \
-} while (0)
-#endif
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PPC_PROCESSOR_H */
diff -urN orig/include/asm-ppc/page.h linux/include/asm-ppc/page.h
--- orig/include/asm-ppc/page.h	Sun Jul  7 23:21:25 2002
+++ linux/include/asm-ppc/page.h	Sun Jul  7 17:42:14 2002
@@ -14,9 +14,6 @@
 #define KERNELBASE	PAGE_OFFSET
 
 #ifndef __ASSEMBLY__
-#include <asm/processor.h>	/* for BUG definition */
-
-#define PAGE_BUG(page) do { BUG(); } while (0)
 
 #define STRICT_MM_TYPECHECKS
 
diff -urN orig/include/asm-s390/bug.h linux/include/asm-s390/bug.h
--- orig/include/asm-s390/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-s390/bug.h	Sun Jan  6 11:53:36 2002
@@ -0,0 +1,13 @@
+#ifndef _S390_BUG_H
+#define _S390_BUG_H
+
+#define BUG() do { \
+        printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+        __asm__ __volatile__(".long 0"); \
+} while (0)                                       
+
+#define PAGE_BUG(page) do { \
+        BUG(); \
+} while (0)                      
+
+#endif
diff -urN orig/include/asm-s390/page.h linux/include/asm-s390/page.h
--- orig/include/asm-s390/page.h	Sun Jun  9 16:01:59 2002
+++ linux/include/asm-s390/page.h	Sun Jun  9 11:45:59 2002
@@ -61,15 +61,6 @@
 
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
-
-#define BUG() do { \
-        printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-        __asm__ __volatile__(".long 0"); \
-} while (0)                                       
-
-#define PAGE_BUG(page) do { \
-        BUG(); \
-} while (0)                      
 
 /* Pure 2^n version of get_order */
 extern __inline__ int get_order(unsigned long size)
diff -urN orig/include/asm-s390x/bug.h linux/include/asm-s390x/bug.h
--- orig/include/asm-s390x/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-s390x/bug.h	Sun Jan  6 11:54:13 2002
@@ -0,0 +1,13 @@
+#ifndef _S390_BUG_H
+#define _S390_BUG_H
+
+#define BUG() do { \
+        printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+        __asm__ __volatile__(".long 0"); \
+} while (0)                                       
+
+#define PAGE_BUG(page) do { \
+        BUG(); \
+} while (0)                      
+
+#endif
diff -urN orig/include/asm-s390x/page.h linux/include/asm-s390x/page.h
--- orig/include/asm-s390x/page.h	Sun Jun  9 16:02:00 2002
+++ linux/include/asm-s390x/page.h	Sun Jun  9 11:46:26 2002
@@ -59,15 +59,6 @@
 
 #define clear_user_page(page, vaddr, pg)    clear_page(page)
 #define copy_user_page(to, from, vaddr, pg) copy_page(to, from)
-
-#define BUG() do { \
-        printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-        __asm__ __volatile__(".long 0"); \
-} while (0)                                       
-
-#define PAGE_BUG(page) do { \
-        BUG(); \
-} while (0)                      
 
 /* Pure 2^n version of get_order */
 extern __inline__ int get_order(unsigned long size)
diff -urN orig/include/asm-sh/bug.h linux/include/asm-sh/bug.h
--- orig/include/asm-sh/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-sh/bug.h	Sun Jan  6 11:54:51 2002
@@ -0,0 +1,16 @@
+#ifndef __ASM_SH_BUG_H
+#define __ASM_SH_BUG_H
+
+/*
+ * Tell the user there is some problem.
+ */
+#define BUG() do { \
+	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+	asm volatile("nop"); \
+} while (0)
+
+#define PAGE_BUG(page) do { \
+	BUG(); \
+} while (0)
+
+#endif
diff -urN orig/include/asm-sh/page.h linux/include/asm-sh/page.h
--- orig/include/asm-sh/page.h	Mon Oct  1 23:11:32 2001
+++ linux/include/asm-sh/page.h	Sun Jan  6 11:54:54 2002
@@ -89,18 +89,6 @@
 #define virt_to_page(kaddr)	phys_to_page(__pa(kaddr))
 
 #ifndef __ASSEMBLY__
-
-/*
- * Tell the user there is some problem.
- */
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	asm volatile("nop"); \
-} while (0)
-
-#define PAGE_BUG(page) do { \
-	BUG(); \
-} while (0)
 
 /* Pure 2^n version of get_order */
 static __inline__ int get_order(unsigned long size)
diff -urN orig/include/asm-sparc/bug.h linux/include/asm-sparc/bug.h
--- orig/include/asm-sparc/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-sparc/bug.h	Sun Jan  6 11:58:47 2002
@@ -0,0 +1,25 @@
+/* $Id$ */
+#ifndef _SPARC_BUG_H
+#define _SPARC_BUG_H
+
+/*
+ * XXX I am hitting compiler bugs with __builtin_trap. This has
+ * hit me before and rusty was blaming his netfilter bugs on
+ * this so lets disable it. - Anton
+ */
+#if 0
+/* We need the mb()'s so we don't trigger a compiler bug - Anton */
+#define BUG() do { \
+	mb(); \
+	__builtin_trap(); \
+	mb(); \
+} while(0)
+#else
+#define BUG() do { \
+	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; \
+} while (0)
+#endif
+
+#define PAGE_BUG(page)	BUG()
+
+#endif
diff -urN orig/include/asm-sparc/page.h linux/include/asm-sparc/page.h
--- orig/include/asm-sparc/page.h	Sun Jun  9 16:02:00 2002
+++ linux/include/asm-sparc/page.h	Sun Jun  9 11:27:41 2002
@@ -29,26 +29,6 @@
 
 #ifndef __ASSEMBLY__
 
-/*
- * XXX I am hitting compiler bugs with __builtin_trap. This has
- * hit me before and rusty was blaming his netfilter bugs on
- * this so lets disable it. - Anton
- */
-#if 0
-/* We need the mb()'s so we don't trigger a compiler bug - Anton */
-#define BUG() do { \
-	mb(); \
-	__builtin_trap(); \
-	mb(); \
-} while(0)
-#else
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; \
-} while (0)
-#endif
-
-#define PAGE_BUG(page)	BUG()
-
 #define clear_page(page)	 memset((void *)(page), 0, PAGE_SIZE)
 #define copy_page(to,from) 	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 #define clear_user_page(addr, vaddr, page)	clear_page(addr)
diff -urN orig/include/asm-sparc64/bug.h linux/include/asm-sparc64/bug.h
--- orig/include/asm-sparc64/bug.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-sparc64/bug.h	Tue Jan 15 16:13:30 2002
@@ -0,0 +1,17 @@
+/* $Id$ */
+
+#ifndef _SPARC64_BUG_H
+#define _SPARC64_BUG_H
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+extern void do_BUG(const char *file, int line);
+#define BUG() do {					\
+	do_BUG(__FILE__, __LINE__);			\
+	__builtin_trap();				\
+} while (0)
+#else
+#define BUG()		__builtin_trap()
+#endif
+
+
+#endif
diff -urN orig/include/asm-sparc64/page.h linux/include/asm-sparc64/page.h
--- orig/include/asm-sparc64/page.h	Sun Jun  9 16:02:01 2002
+++ linux/include/asm-sparc64/page.h	Sun Jun  9 11:27:41 2002
@@ -20,18 +20,6 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-extern void do_BUG(const char *file, int line);
-#define BUG() do {					\
-	do_BUG(__FILE__, __LINE__);			\
-	__builtin_trap();				\
-} while (0)
-#else
-#define BUG()		__builtin_trap()
-#endif
-
-#define PAGE_BUG(page)	BUG()
-
 /* Sparc64 is slow at multiplication, we prefer to use some extra space. */
 #define WANT_PAGE_VIRTUAL 1
 
diff -urN orig/include/linux/dcache.h linux/include/linux/dcache.h
--- orig/include/linux/dcache.h	Sat May 25 23:13:52 2002
+++ linux/include/linux/dcache.h	Sat May 25 10:45:47 2002
@@ -7,7 +7,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/cache.h>
-#include <asm/page.h>			/* for BUG() */
+#include <asm/bug.h>
 
 struct vfsmount;
 
diff -urN orig/include/linux/jbd.h linux/include/linux/jbd.h
--- orig/include/linux/jbd.h	Sat Oct 12 10:02:12 2002
+++ linux/include/linux/jbd.h	Sun Jan 12 11:43:31 2003
@@ -194,6 +194,7 @@
 
 #include <linux/fs.h>
 #include <linux/sched.h>
+#include <asm/bug.h>
 
 #define JBD_ASSERTIONS
 #ifdef JBD_ASSERTIONS
@@ -778,14 +779,6 @@
 {
 	handle->h_aborted = 1;
 }
-
-/* Not all architectures define BUG() */
-#ifndef BUG
- #define BUG() do { \
-        printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	* ((char *) 0) = 0; \
- } while (0)
-#endif /* BUG */
 
 #endif /* __KERNEL__   */
 
diff -urN orig/include/linux/kernel.h linux/include/linux/kernel.h
--- orig/include/linux/kernel.h	Mon Nov 18 09:52:20 2002
+++ linux/include/linux/kernel.h	Mon Nov 18 10:03:05 2002
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <asm/byteorder.h>
+#include <asm/bug.h>
 
 /* Optimization barrier */
 /* The "volatile" is due to gcc bugs */
diff -urN orig/include/linux/smp.h linux/include/linux/smp.h
--- orig/include/linux/smp.h	Thu Oct  3 12:45:28 2002
+++ linux/include/linux/smp.h	Mon Nov 18 10:00:26 2002
@@ -14,6 +14,7 @@
 #include <linux/compiler.h>
 #include <linux/threads.h>
 #include <asm/smp.h>
+#include <asm/bug.h>
 
 /*
  * main cross-CPU interfaces, handles INIT, TLB flush, STOP, etc.
@@ -86,7 +87,6 @@
 void smp_prepare_boot_cpu(void);
 
 #else /* !SMP */
-#include <asm/page.h> /* For BUG() */
 
 /*
  *	These macros fold the SMP functionality into a single CPU system
