Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbSKEHoJ>; Tue, 5 Nov 2002 02:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264762AbSKEHoJ>; Tue, 5 Nov 2002 02:44:09 -0500
Received: from dp.samba.org ([66.70.73.150]:1504 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264706AbSKEHny>;
	Tue, 5 Nov 2002 02:43:54 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: linux/bug.h and asm/bug.h 
In-reply-to: Your message of "Mon, 04 Nov 2002 13:41:48 BST."
             <20021104134148.B19377@bacchus.dhis.org> 
Date: Tue, 05 Nov 2002 18:49:09 +1100
Message-Id: <20021105075030.2BC8B2C282@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021104134148.B19377@bacchus.dhis.org> you write:
> On Mon, Nov 04, 2002 at 01:22:45PM +1100, Rusty Russell wrote:
> 
> > As the number of bug-related macros grows, this makes sense.
> > 
> > 1) Introduce linux/bug.h and #include it from linux/kernel.h so noone
> >    breaks.
> > 2) Move BUG() macro from asm*/page.h to asm*/bug.h, and #include it.
> 
> Great, people were talking about the mess caused by this just last night.
> Just one request, move the BUG_ON definition into <asm/bug.h> also.  This
> permits the use of conditional trap instructions for those architecture
> that have them.

Hmm, I decided to use #ifndef BUG_ON instead, since most archs will
not bother.

BTW, looks like Russell did this first.  Wish I'd noticed 8(

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: bug.h
Author: Rusty Russell and Russell King
Status: Trivial

D: As the number of bug-related macros grows, this makes sense.
D: 
D: 1) Introduce linux/bug.h and #include it from linux/kernel.h so noone
D:    breaks.
D: 2) Move BUG() and BUG_ON() macro from asm*/page.h to asm*/bug.h,
D:    and #include it.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-alpha/bug.h .8725-linux-2.5-bk.updated/include/asm-alpha/bug.h
--- .8725-linux-2.5-bk/include/asm-alpha/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-alpha/bug.h	2002-11-05 18:44:59.000000000 +1100
@@ -0,0 +1,11 @@
+#ifndef _ALPHA_BUG_H
+#define _ALPHA_BUG_H
+#include <asm/pal.h>
+
+/* ??? Would be nice to use .gprel32 here, but we can't be sure that the
+   function loaded the GP, so this could fail in modules.  */
+#define BUG() \
+  __asm__ __volatile__("call_pal %0  # bugchk\n\t"".long %1\n\t.8byte %2" \
+		       : : "i" (PAL_bugchk), "i"(__LINE__), "i"(__FILE__))
+
+#endif /* _ALPHA_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-alpha/page.h .8725-linux-2.5-bk.updated/include/asm-alpha/page.h
--- .8725-linux-2.5-bk/include/asm-alpha/page.h	2002-08-11 15:31:42.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-alpha/page.h	2002-11-05 18:44:59.000000000 +1100
@@ -2,6 +2,7 @@
 #define _ALPHA_PAGE_H
 
 #include <asm/pal.h>
+#include <asm/bug.h>
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	13
@@ -59,12 +60,6 @@ typedef unsigned long pgprot_t;
 
 #endif /* STRICT_MM_TYPECHECKS */
 
-/* ??? Would be nice to use .gprel32 here, but we can't be sure that the
-   function loaded the GP, so this could fail in modules.  */
-#define BUG() \
-  __asm__ __volatile__("call_pal %0  # bugchk\n\t"".long %1\n\t.8byte %2" \
-		       : : "i" (PAL_bugchk), "i"(__LINE__), "i"(__FILE__))
-
 #define PAGE_BUG(page)	BUG()
 
 /* Pure 2^n version of get_order */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-arm/bug.h .8725-linux-2.5-bk.updated/include/asm-arm/bug.h
--- .8725-linux-2.5-bk/include/asm-arm/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-arm/bug.h	2002-11-05 18:44:59.000000000 +1100
@@ -0,0 +1,20 @@
+#ifndef _ASMARM_BUG_H
+#define _ASMARM_BUG_H
+#include <linux/config.h>
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+extern void __bug(const char *file, int line, void *data);
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
+#endif /* _ASMARM_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-arm/page.h .8725-linux-2.5-bk.updated/include/asm-arm/page.h
--- .8725-linux-2.5-bk/include/asm-arm/page.h	2002-10-16 15:01:23.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-arm/page.h	2002-11-05 18:44:59.000000000 +1100
@@ -7,6 +7,7 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/glue.h>
+#include <asm/bug.h>
 
 /*
  *	User Space Model
@@ -160,21 +161,6 @@ typedef unsigned long pgprot_t;
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-cris/bug.h .8725-linux-2.5-bk.updated/include/asm-cris/bug.h
--- .8725-linux-2.5-bk/include/asm-cris/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-cris/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,8 @@
+#ifndef _CRIS_BUG_H
+#define _CRIS_BUG_H
+
+#define BUG() do { \
+  printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+} while (0)
+
+#endif /* _CRIS_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-cris/page.h .8725-linux-2.5-bk.updated/include/asm-cris/page.h
--- .8725-linux-2.5-bk/include/asm-cris/page.h	2002-02-12 19:17:37.000000000 +1100
+++ .8725-linux-2.5-bk.updated/include/asm-cris/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <asm/mmu.h>
+#include <asm/bug.h>
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	13
@@ -70,18 +71,10 @@ typedef unsigned long pgprot_t;
 #define PAGE_OFFSET		KSEG_C   /* kseg_c is mapped to physical ram */
 #endif
 
-#ifndef __ASSEMBLY__
-
-#define BUG() do { \
-  printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-} while (0)
-
 #define PAGE_BUG(page) do { \
          BUG(); \
 } while (0)
 
-#endif /* __ASSEMBLY__ */
-
 /* macros to convert between really physical and virtual addresses
  * by stripping a selected bit, we can convert between KSEG_x and 0x40000000 where
  * the DRAM really resides
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-i386/bug.h .8725-linux-2.5-bk.updated/include/asm-i386/bug.h
--- .8725-linux-2.5-bk/include/asm-i386/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-i386/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,20 @@
+#ifndef _I386_BUG_H
+#define _I386_BUG_H
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
+#endif /* _I386_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-i386/page.h .8725-linux-2.5-bk.updated/include/asm-i386/page.h
--- .8725-linux-2.5-bk/include/asm-i386/page.h	2002-10-15 15:31:04.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-i386/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -13,6 +13,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/config.h>
+#include <asm/bug.h>
 
 #ifdef CONFIG_X86_USE_3DNOW
 
@@ -99,23 +100,6 @@ typedef struct { unsigned long pgprot; }
 
 #ifndef __ASSEMBLY__
 
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
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-ia64/bug.h .8725-linux-2.5-bk.updated/include/asm-ia64/bug.h
--- .8725-linux-2.5-bk/include/asm-ia64/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-ia64/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,11 @@
+#ifndef _ASM_IA64_BUG_H
+#define _ASM_IA64_BUG_H
+
+#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+# define ia64_abort()	__builtin_trap()
+#else
+# define ia64_abort()	(*(volatile int *) 0 = 0)
+#endif
+#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); ia64_abort(); } while (0)
+
+#endif /* _ASM_IA64_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-ia64/page.h .8725-linux-2.5-bk.updated/include/asm-ia64/page.h
--- .8725-linux-2.5-bk/include/asm-ia64/page.h	2002-11-05 10:54:27.000000000 +1100
+++ .8725-linux-2.5-bk.updated/include/asm-ia64/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -10,6 +10,7 @@
 #include <linux/config.h>
 
 #include <asm/types.h>
+#include <asm/bug.h>
 
 /*
  * PAGE_SHIFT determines the actual kernel page size.
@@ -125,12 +126,6 @@ typedef union ia64_va {
 # define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 #endif
 
-#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
-# define ia64_abort()	__builtin_trap()
-#else
-# define ia64_abort()	(*(volatile int *) 0 = 0)
-#endif
-#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); ia64_abort(); } while (0)
 #define PAGE_BUG(page) do { BUG(); } while (0)
 
 static __inline__ int
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-m68k/bug.h .8725-linux-2.5-bk.updated/include/asm-m68k/bug.h
--- .8725-linux-2.5-bk/include/asm-m68k/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-m68k/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,24 @@
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
+#endif /* _M68K_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-m68k/page.h .8725-linux-2.5-bk.updated/include/asm-m68k/page.h
--- .8725-linux-2.5-bk/include/asm-m68k/page.h	2002-11-05 10:54:27.000000000 +1100
+++ .8725-linux-2.5-bk.updated/include/asm-m68k/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -16,6 +16,7 @@
 #ifdef __KERNEL__
 
 #include <asm/setup.h>
+#include <asm/bug.h>
 
 #if PAGE_SHIFT < 13
 #define THREAD_SIZE (8192)
@@ -178,24 +179,6 @@ static inline void *__va(unsigned long x
 #define virt_addr_valid(kaddr)	((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
 #define pfn_valid(pfn)		virt_addr_valid(pfn_to_virt(pfn))
 
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
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-mips/bug.h .8725-linux-2.5-bk.updated/include/asm-mips/bug.h
--- .8725-linux-2.5-bk/include/asm-mips/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-mips/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef __ASM_BUG_H
+#define __ASM_BUG_H
+
+#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
+
+#endif /* __ASM_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-mips/page.h .8725-linux-2.5-bk.updated/include/asm-mips/page.h
--- .8725-linux-2.5-bk/include/asm-mips/page.h	2002-02-20 17:57:18.000000000 +1100
+++ .8725-linux-2.5-bk.updated/include/asm-mips/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -17,10 +17,10 @@
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
 #ifdef __KERNEL__
+#include <asm/bug.h>
 
 #ifndef _LANGUAGE_ASSEMBLY
 
-#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
 #define PAGE_BUG(page) do {  BUG(); } while (0)
 
 extern void (*_clear_page)(void * page);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-mips64/bug.h .8725-linux-2.5-bk.updated/include/asm-mips64/bug.h
--- .8725-linux-2.5-bk/include/asm-mips64/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-mips64/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,6 @@
+#ifndef _ASM_BUG_H
+#define _ASM_BUG_H
+
+#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
+
+#endif /* _ASM_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-mips64/page.h .8725-linux-2.5-bk.updated/include/asm-mips64/page.h
--- .8725-linux-2.5-bk/include/asm-mips64/page.h	2002-02-12 19:17:37.000000000 +1100
+++ .8725-linux-2.5-bk.updated/include/asm-mips64/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -10,6 +10,7 @@
 #define _ASM_PAGE_H
 
 #include <linux/config.h>
+#include <asm/bug.h>
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
@@ -20,7 +21,6 @@
 
 #ifndef _LANGUAGE_ASSEMBLY
 
-#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
 #define PAGE_BUG(page) do {  BUG(); } while (0)
 
 extern void (*_clear_page)(void * page);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-parisc/bug.h .8725-linux-2.5-bk.updated/include/asm-parisc/bug.h
--- .8725-linux-2.5-bk/include/asm-parisc/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-parisc/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,14 @@
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
+#endif /* _PARISC_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-parisc/page.h .8725-linux-2.5-bk.updated/include/asm-parisc/page.h
--- .8725-linux-2.5-bk/include/asm-parisc/page.h	2002-10-31 12:36:59.000000000 +1100
+++ .8725-linux-2.5-bk.updated/include/asm-parisc/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/cache.h>
+#include <asm/bug.h>
 
 #define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
 #define copy_page(to,from)      copy_user_page_asm((void *)(to), (void *)(from))
@@ -86,16 +87,6 @@ extern int npmem_ranges;
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
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
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-ppc/bug.h .8725-linux-2.5-bk.updated/include/asm-ppc/bug.h
--- .8725-linux-2.5-bk/include/asm-ppc/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-ppc/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,22 @@
+#ifndef _PPC_PAGE_H
+#define _PPC_PAGE_H
+
+#include <linux/config.h>
+
+#ifndef __ASSEMBLY__
+#include <asm/system.h> /* for xmon definition */
+
+#ifdef CONFIG_XMON
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
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _PPC_PAGE_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-ppc/page.h .8725-linux-2.5-bk.updated/include/asm-ppc/page.h
--- .8725-linux-2.5-bk/include/asm-ppc/page.h	2002-09-21 13:55:17.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-ppc/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -8,6 +8,7 @@
 
 #ifdef __KERNEL__
 #include <linux/config.h>
+#include <asm/bug.h>
 
 /* Be sure to change arch/ppc/Makefile to match */
 #ifdef CONFIG_KERNEL_START_BOOL
@@ -18,19 +19,6 @@
 #define KERNELBASE	PAGE_OFFSET
 
 #ifndef __ASSEMBLY__
-#include <asm/system.h> /* for xmon definition */
-
-#ifdef CONFIG_XMON
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
 #define PAGE_BUG(page) do { BUG(); } while (0)
 
 #define STRICT_MM_TYPECHECKS
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-ppc64/bug.h .8725-linux-2.5-bk.updated/include/asm-ppc64/bug.h
--- .8725-linux-2.5-bk/include/asm-ppc64/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-ppc64/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,27 @@
+#ifndef _PPC64_BUG_H
+#define _PPC64_BUG_H
+#include <linux/config.h>
+
+/* Define an illegal instr to trap on the bug.
+ * We don't use 0 because that marks the end of a function
+ * in the ELF ABI.  That's "Boo Boo" in case you wonder...
+ */
+#define BUG_OPCODE .long 0x00b00b00  /* For asm */
+#define BUG_ILLEGAL_INSTR "0x00b00b00" /* For BUG macro */
+
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_XMON
+extern void xmon(struct pt_regs *excp);
+#define BUG() do { \
+	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+	xmon(0); \
+} while (0)
+#else
+#define BUG() do { \
+	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+	__asm__ __volatile__(".long " BUG_ILLEGAL_INSTR); \
+} while (0)
+#endif
+#endif /* __ASSEMBLY__ */
+
+#endif /* _PPC64_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-ppc64/page.h .8725-linux-2.5-bk.updated/include/asm-ppc64/page.h
--- .8725-linux-2.5-bk/include/asm-ppc64/page.h	2002-09-21 13:55:18.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-ppc64/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -22,14 +22,8 @@
 #define SID_MASK        0xfffffffff
 #define GET_ESID(x)     (((x) >> SID_SHIFT) & SID_MASK)
 
-/* Define an illegal instr to trap on the bug.
- * We don't use 0 because that marks the end of a function
- * in the ELF ABI.  That's "Boo Boo" in case you wonder...
- */
-#define BUG_OPCODE .long 0x00b00b00  /* For asm */
-#define BUG_ILLEGAL_INSTR "0x00b00b00" /* For BUG macro */
-
 #ifdef __KERNEL__
+#include <asm/bug.h>
 #ifndef __ASSEMBLY__
 #include <asm/naca.h>
 
@@ -103,20 +97,6 @@ typedef unsigned long pgprot_t;
 
 #endif
 
-#ifdef CONFIG_XMON
-#include <asm/ptrace.h>
-extern void xmon(struct pt_regs *excp);
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	xmon(0); \
-} while (0)
-#else
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	__asm__ __volatile__(".long " BUG_ILLEGAL_INSTR); \
-} while (0)
-#endif
-
 #define PAGE_BUG(page) do { BUG(); } while (0)
 
 /* Pure 2^n version of get_order */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-s390/bug.h .8725-linux-2.5-bk.updated/include/asm-s390/bug.h
--- .8725-linux-2.5-bk/include/asm-s390/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-s390/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,9 @@
+#ifndef _S390_PAGE_H
+#define _S390_PAGE_H
+
+#define BUG() do { \
+        printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+        __asm__ __volatile__(".word 0x0000"); \
+} while (0)                                       
+
+#endif /* _S390_PAGE_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-s390/page.h .8725-linux-2.5-bk.updated/include/asm-s390/page.h
--- .8725-linux-2.5-bk/include/asm-s390/page.h	2002-06-10 16:03:55.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-s390/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -20,6 +20,8 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
+#include <asm/bug.h>
+
 static inline void clear_page(void *page)
 {
 	register_pair rp;
@@ -62,11 +64,6 @@ static inline void copy_page(void *to, v
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define BUG() do { \
-        printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-        __asm__ __volatile__(".word 0x0000"); \
-} while (0)                                       
-
 #define PAGE_BUG(page) do { \
         BUG(); \
 } while (0)                      
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-s390x/bug.h .8725-linux-2.5-bk.updated/include/asm-s390x/bug.h
--- .8725-linux-2.5-bk/include/asm-s390x/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-s390x/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,10 @@
+#ifndef _S390_PAGE_H
+#define _S390_PAGE_H
+
+#define BUG() do { \
+        printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+        __asm__ __volatile__(".long 0"); \
+} while (0)                                       
+
+#endif /* _S390_PAGE_H */
+
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-s390x/page.h .8725-linux-2.5-bk.updated/include/asm-s390x/page.h
--- .8725-linux-2.5-bk/include/asm-s390x/page.h	2002-06-09 17:22:49.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-s390x/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -19,6 +19,8 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
+#include <asm/bug.h>
+
 static inline void clear_page(void *page)
 {
         asm volatile ("   lgr  2,%0\n"
@@ -60,11 +62,6 @@ static inline void copy_page(void *to, v
 #define clear_user_page(page, vaddr, pg)    clear_page(page)
 #define copy_user_page(to, from, vaddr, pg) copy_page(to, from)
 
-#define BUG() do { \
-        printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-        __asm__ __volatile__(".long 0"); \
-} while (0)                                       
-
 #define PAGE_BUG(page) do { \
         BUG(); \
 } while (0)                      
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-sh/bug.h .8725-linux-2.5-bk.updated/include/asm-sh/bug.h
--- .8725-linux-2.5-bk/include/asm-sh/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-sh/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,12 @@
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
+#endif /* __ASM_SH_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-sh/page.h .8725-linux-2.5-bk.updated/include/asm-sh/page.h
--- .8725-linux-2.5-bk/include/asm-sh/page.h	2001-09-09 05:29:09.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-sh/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -24,6 +24,8 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
+#include <asm/bug.h>
+
 extern void clear_page(void *to);
 extern void copy_page(void *to, void *from);
 
@@ -90,14 +92,6 @@ typedef struct { unsigned long pgprot; }
 
 #ifndef __ASSEMBLY__
 
-/*
- * Tell the user there is some problem.
- */
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	asm volatile("nop"); \
-} while (0)
-
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-sparc/bug.h .8725-linux-2.5-bk.updated/include/asm-sparc/bug.h
--- .8725-linux-2.5-bk/include/asm-sparc/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-sparc/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,22 @@
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
+#endif /* _SPARC_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-sparc/page.h .8725-linux-2.5-bk.updated/include/asm-sparc/page.h
--- .8725-linux-2.5-bk/include/asm-sparc/page.h	2002-08-28 09:29:51.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-sparc/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -28,24 +28,7 @@
 #include <asm/btfixup.h>
 
 #ifndef __ASSEMBLY__
-
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
+#include <asm/bug.h>
 
 #define PAGE_BUG(page)	BUG()
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-sparc64/bug.h .8725-linux-2.5-bk.updated/include/asm-sparc64/bug.h
--- .8725-linux-2.5-bk/include/asm-sparc64/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-sparc64/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,15 @@
+#ifndef _SPARC64_BUG_H
+#define _SPARC64_BUG_H
+#include <linux/config.h>
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
+#endif /* _SPARC64_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-sparc64/page.h .8725-linux-2.5-bk.updated/include/asm-sparc64/page.h
--- .8725-linux-2.5-bk/include/asm-sparc64/page.h	2002-10-31 12:37:00.000000000 +1100
+++ .8725-linux-2.5-bk.updated/include/asm-sparc64/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -19,16 +19,7 @@
 #ifdef __KERNEL__
 
 #ifndef __ASSEMBLY__
-
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-extern void do_BUG(const char *file, int line);
-#define BUG() do {					\
-	do_BUG(__FILE__, __LINE__);			\
-	__builtin_trap();				\
-} while (0)
-#else
-#define BUG()		__builtin_trap()
-#endif
+#include <asm/bug.h>
 
 #define PAGE_BUG(page)	BUG()
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-um/bug.h .8725-linux-2.5-bk.updated/include/asm-um/bug.h
--- .8725-linux-2.5-bk/include/asm-um/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-um/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,8 @@
+#ifndef __UM_BUG_H
+#define __UM_BUG_H
+
+#define BUG() do { \
+	panic("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+} while (0)
+
+#endif /* __UM_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-um/page.h .8725-linux-2.5-bk.updated/include/asm-um/page.h
--- .8725-linux-2.5-bk/include/asm-um/page.h	2002-10-15 15:26:29.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-um/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -25,10 +25,7 @@ struct page;
 
 extern void stop(void);
 
-#define BUG() do { \
-	panic("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-} while (0)
-
+#include <asm/bug.h>
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-x86_64/bug.h .8725-linux-2.5-bk.updated/include/asm-x86_64/bug.h
--- .8725-linux-2.5-bk/include/asm-x86_64/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-x86_64/bug.h	2002-11-05 18:45:00.000000000 +1100
@@ -0,0 +1,18 @@
+#ifndef _X86_64_BUG_H
+#define _X86_64_BUG_H
+
+#include <linux/stringify.h>
+/*
+ * Tell the user there is some problem.  The exception handler decodes this frame.
+ */ 
+struct bug_frame { 
+       unsigned char ud2[2];          
+	char *filename;    /* should use 32bit offset instead, but the assembler doesn't like it */ 
+	unsigned short line; 
+} __attribute__((packed)); 
+#define BUG() \
+	asm volatile("ud2 ; .quad %c1 ; .short %c0" :: \
+		     "i"(__LINE__), "i" (__stringify(KBUILD_BASENAME)))
+void out_of_line_bug(void);
+
+#endif /* _X86_64_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/asm-x86_64/page.h .8725-linux-2.5-bk.updated/include/asm-x86_64/page.h
--- .8725-linux-2.5-bk/include/asm-x86_64/page.h	2002-10-16 15:01:24.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/asm-x86_64/page.h	2002-11-05 18:45:00.000000000 +1100
@@ -64,21 +64,9 @@ typedef struct { unsigned long pgprot; }
 
 #ifndef __ASSEMBLY__
 
-#include <linux/stringify.h>
+#include <asm/bug.h>
 
-/*
- * Tell the user there is some problem.  The exception handler decodes this frame.
- */ 
-struct bug_frame { 
-       unsigned char ud2[2];          
-	char *filename;    /* should use 32bit offset instead, but the assembler doesn't like it */ 
-	unsigned short line; 
-} __attribute__((packed)); 
-#define BUG() \
-	asm volatile("ud2 ; .quad %c1 ; .short %c0" :: \
-		     "i"(__LINE__), "i" (__stringify(KBUILD_BASENAME)))
 #define PAGE_BUG(page) BUG()
-void out_of_line_bug(void);
 
 /* Pure 2^n version of get_order */
 extern __inline__ int get_order(unsigned long size)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/linux/bug.h .8725-linux-2.5-bk.updated/include/linux/bug.h
--- .8725-linux-2.5-bk/include/linux/bug.h	1970-01-01 10:00:00.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/linux/bug.h	2002-11-05 18:47:14.000000000 +1100
@@ -0,0 +1,27 @@
+#ifndef _LINUX_BUG_H
+#define _LINUX_BUG_H
+#include <linux/compiler.h> /* likely/unlikely */
+#include <asm/bug.h> /* BUG() */
+
+extern void dump_stack(void);
+
+/* This permits the use of conditional trap instructions for those
+   architecture that have them -- Ralf Baechle */
+#ifndef BUG_ON
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+#endif
+
+#define WARN_ON(condition) do {					\
+	if (unlikely((condition)!=0)) {				\
+		printk("Badness in %s at %s:%d\n",		\
+			 __FUNCTION__, __FILE__, __LINE__);	\
+		dump_stack();					\
+	}							\
+} while (0)
+
+/* Fail at build-time (condition must be a constant expression:
+   BUILD_BUG does not exist). */
+extern void BUILD_BUG(void);
+#define BUILD_BUG_ON(condition) do { if (condition) BUILD_BUG(); } while(0)
+
+#endif /* _LINUX_BUG_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8725-linux-2.5-bk/include/linux/kernel.h .8725-linux-2.5-bk.updated/include/linux/kernel.h
--- .8725-linux-2.5-bk/include/linux/kernel.h	2002-10-19 17:48:10.000000000 +1000
+++ .8725-linux-2.5-bk.updated/include/linux/kernel.h	2002-11-05 18:44:59.000000000 +1100
@@ -11,7 +11,7 @@
 #include <linux/linkage.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
-#include <linux/compiler.h>
+#include <linux/bug.h>
 #include <asm/byteorder.h>
 
 /* Optimization barrier */
@@ -103,8 +103,6 @@ extern const char *print_tainted(void);
 #define TAINT_FORCED_MODULE		(1<<1)
 #define TAINT_UNSAFE_SMP		(1<<2)
 
-extern void dump_stack(void);
-
 #if DEBUG
 #define pr_debug(fmt,arg...) \
 	printk(KERN_DEBUG fmt,##arg)
@@ -199,17 +197,6 @@ struct sysinfo {
 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
 };
 
-#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
-#define WARN_ON(condition) do { \
-	if (unlikely((condition)!=0)) { \
-		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
-		dump_stack(); \
-	} \
-} while (0)
-
-extern void BUILD_BUG(void);
-#define BUILD_BUG_ON(condition) do { if (condition) BUILD_BUG(); } while(0)
-
 /* Trap pasters of __FUNCTION__ at compile-time */
 #if __GNUC__ > 2 || __GNUC_MINOR__ >= 95
 #define __FUNCTION__ (__func__)
