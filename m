Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271411AbTGXJOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 05:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271414AbTGXJOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 05:14:23 -0400
Received: from [63.205.85.133] ([63.205.85.133]:25832 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S271411AbTGXJN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 05:13:27 -0400
Date: Thu, 24 Jul 2003 02:33:18 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: linux-kernel@vger.kernel.org
Cc: Andrey Panin <pazke@orbita1.ru>
Subject: [RFC] get_order() cleanup
Message-ID: <20030724093318.GD11746@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote a patch to clean up get_order().  When I'd done a rough cut of it
I did some google searches and found that Andrey Panin had already wrote
a nearly equivelant patch (down to some of the same identifier names :-)
over a year ago for kernel 2.5.10:
  http://www.ussg.iu.edu/hypermail/linux/kernel/0204.3/0720.html

I combined some ideas from his patch into mine.  He really deserves
the credit since he came up with it first.

Anyway, all architectures but two (ia64, ppc) use the same get_order()
inline function in asm-*/page.h.  This patch adds a asm-generic/get_order.h
file that all of them now #include.

1. For the majority of archs that DON'T have their own assembly version
   of get_order() we now provide it in one place - lib/get_order.c

   This is one place where my patch is different than Andrey's - he left
   it as an inline like it is currently.  I personally don't think it's
   worth inlining - it IS very short (22 bytes on i386) but it's still
   longer than a function call.  It's rarely (if ever) called from
   performance cricial points.  Usually it's just used in setup/teardown
   code.

   Architectures with inline-assembly implementations of get_order()
   continue to use them instead.

2. We now compute get_order(CONSTANT) at compile-time.  There aren't
   too many cases of this, but there are some.  Now that it's free
   it may get useful in more places.

When Andrey posted his patch it didn't seem to generate any discussion.
Any interest this time?

-Mitch

diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-alpha/page.h linux-2.6.0-test1-getorder/include/asm-alpha/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-alpha/page.h	2003-07-13 20:36:48.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-alpha/page.h	2003-07-23 14:52:11.000000000 -0700
@@ -59,19 +59,7 @@
 
 #endif /* STRICT_MM_TYPECHECKS */
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 #endif /* !__ASSEMBLY__ */
 
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-arm/page.h linux-2.6.0-test1-getorder/include/asm-arm/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-arm/page.h	2003-07-13 20:31:20.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-arm/page.h	2003-07-23 14:54:43.000000000 -0700
@@ -160,20 +160,7 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
-/* Pure 2^n version of get_order */
-static inline int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
+#include <asm-generic/get_order.h>
 #include <asm/memory.h>
 
 #endif /* !__ASSEMBLY__ */
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-arm26/page.h linux-2.6.0-test1-getorder/include/asm-arm26/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-arm26/page.h	2003-07-13 20:36:32.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-arm26/page.h	2003-07-23 14:54:25.000000000 -0700
@@ -89,20 +89,7 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
-/* Pure 2^n version of get_order */
-static inline int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
+#include <asm-generic/get_order.h>
 #include <asm/memory.h>
 
 #endif /* !__ASSEMBLY__ */
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-cris/page.h linux-2.6.0-test1-getorder/include/asm-cris/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-cris/page.h	2003-07-13 20:32:34.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-cris/page.h	2003-07-23 14:55:01.000000000 -0700
@@ -74,19 +74,7 @@
 
 #endif /* __ASSEMBLY__ */
 
-/* Pure 2^n version of get_order */
-static inline int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-generic/get_order.h linux-2.6.0-test1-getorder/include/asm-generic/get_order.h
--- linux-2.6.0-test1-VIRGIN/include/asm-generic/get_order.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.0-test1-getorder/include/asm-generic/get_order.h	2003-07-23 15:23:55.000000000 -0700
@@ -0,0 +1,42 @@
+#ifndef _ASM_GENERIC_GET_ORDER_H
+#define _ASM_GENERIC_GET_ORDER_H
+
+/* Non-existent function so you can get link error if called wrong */
+extern int __get_order_called_with_too_large_of_argument(void);
+
+#define __constant_get_order(size)					\
+		(((unsigned long) (size) <= PAGE_SIZE <<  0) ?  0 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE <<  1) ?  1 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE <<  2) ?  2 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE <<  3) ?  3 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE <<  4) ?  4 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE <<  5) ?  5 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE <<  6) ?  6 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE <<  7) ?  7 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE <<  8) ?  8 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE <<  9) ?  9 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE << 10) ? 10 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE << 11) ? 11 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE << 12) ? 12 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE << 13) ? 13 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE << 14) ? 14 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE << 15) ? 15 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE << 16) ? 16 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE << 17) ? 17 :	\
+		 ((unsigned long) (size) <= PAGE_SIZE << 18) ? 18 :	\
+		 __get_order_called_with_too_large_of_argument())
+
+#ifndef __HAVE_ARCH_GET_ORDER
+extern int __get_order(unsigned long size);
+#endif /* !__HAVE_ARCH_GET_ORDER */
+
+/**
+ * get_order - given a number of bytes return N where (PAGE_SIZE << N) is at least that size
+ * @size:	number of bytes
+ */
+#define get_order(size)					\
+		(__builtin_constant_p(size) ?		\
+		  __constant_get_order(size) :		\
+		  __get_order(size))
+
+#endif /* !_ASM_GENERIC_GET_ORDER_H */
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-h8300/page.h linux-2.6.0-test1-getorder/include/asm-h8300/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-h8300/page.h	2003-07-13 20:37:27.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-h8300/page.h	2003-07-23 14:55:17.000000000 -0700
@@ -51,19 +51,7 @@
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 extern unsigned long memory_start;
 extern unsigned long memory_end;
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-i386/page.h linux-2.6.0-test1-getorder/include/asm-i386/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-i386/page.h	2003-07-13 20:30:48.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-i386/page.h	2003-07-23 14:55:28.000000000 -0700
@@ -98,19 +98,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Pure 2^n version of get_order */
-static __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 #endif /* __ASSEMBLY__ */
 
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-ia64/page.h linux-2.6.0-test1-getorder/include/asm-ia64/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-ia64/page.h	2003-07-13 20:30:42.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-ia64/page.h	2003-07-23 14:57:22.000000000 -0700
@@ -138,7 +138,7 @@
 #endif
 
 static __inline__ int
-get_order (unsigned long size)
+__get_order (unsigned long size)
 {
 	double d = size - 1;
 	long order;
@@ -149,6 +149,8 @@
 		order = 0;
 	return order;
 }
+#define __HAVE_ARCH_GET_ORDER
+#include <asm-generic/get_order.h>
 
 # endif /* __KERNEL__ */
 #endif /* !__ASSEMBLY__ */
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-m68k/page.h linux-2.6.0-test1-getorder/include/asm-m68k/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-m68k/page.h	2003-07-13 20:39:30.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-m68k/page.h	2003-07-23 14:57:47.000000000 -0700
@@ -109,19 +109,7 @@
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 #endif /* !__ASSEMBLY__ */
 
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-m68knommu/page.h linux-2.6.0-test1-getorder/include/asm-m68knommu/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-m68knommu/page.h	2003-07-13 20:33:46.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-m68knommu/page.h	2003-07-23 14:57:37.000000000 -0700
@@ -51,19 +51,7 @@
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 extern unsigned long memory_start;
 extern unsigned long memory_end;
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-mips/page.h linux-2.6.0-test1-getorder/include/asm-mips/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-mips/page.h	2003-07-13 20:32:43.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-mips/page.h	2003-07-23 14:58:17.000000000 -0700
@@ -81,19 +81,7 @@
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 #endif /* !__ASSEMBLY__ */
 
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-mips64/page.h linux-2.6.0-test1-getorder/include/asm-mips64/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-mips64/page.h	2003-07-13 20:28:55.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-mips64/page.h	2003-07-23 14:58:02.000000000 -0700
@@ -76,19 +76,7 @@
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 #endif /* !__ASSEMBLY__ */
 
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-parisc/page.h linux-2.6.0-test1-getorder/include/asm-parisc/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-parisc/page.h	2003-07-13 20:31:50.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-parisc/page.h	2003-07-23 14:58:40.000000000 -0700
@@ -53,19 +53,7 @@
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 #ifdef __LP64__
 #define MAX_PHYSMEM_RANGES 8 /* Fix the size for now (current known max is 3) */
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-ppc/page.h linux-2.6.0-test1-getorder/include/asm-ppc/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-ppc/page.h	2003-07-13 20:32:29.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-ppc/page.h	2003-07-23 14:59:36.000000000 -0700
@@ -128,7 +128,7 @@
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
 /* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
+extern __inline__ int __get_order(unsigned long size)
 {
 	int lz;
 
@@ -136,6 +136,8 @@
 	asm ("cntlzw %0,%1" : "=r" (lz) : "r" (size));
 	return 32 - lz;
 }
+#define __HAVE_ARCH_GET_ORDER
+#include <asm-generic/get_order.h>
 
 #endif /* __ASSEMBLY__ */
 
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-ppc64/page.h linux-2.6.0-test1-getorder/include/asm-ppc64/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-ppc64/page.h	2003-07-13 20:28:55.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-ppc64/page.h	2003-07-23 14:58:57.000000000 -0700
@@ -113,19 +113,7 @@
 
 #endif
 
-/* Pure 2^n version of get_order */
-static inline int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 #define __pa(x) ((unsigned long)(x)-PAGE_OFFSET)
 
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-s390/page.h linux-2.6.0-test1-getorder/include/asm-s390/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-s390/page.h	2003-07-13 20:31:19.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-s390/page.h	2003-07-23 14:59:51.000000000 -0700
@@ -106,19 +106,7 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-        int order;
-
-        size = (size-1) >> (PAGE_SHIFT-1);
-        order = -1;
-        do {
-                size >>= 1;
-                order++;
-        } while (size);
-        return order;
-}
+#include <asm-generic/get_order.h>
 
 /*
  * These are used to make use of C type-checking..
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-sh/page.h linux-2.6.0-test1-getorder/include/asm-sh/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-sh/page.h	2003-07-13 20:37:58.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-sh/page.h	2003-07-23 15:00:02.000000000 -0700
@@ -102,19 +102,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Pure 2^n version of get_order */
-static __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 #endif
 
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-sparc/page.h linux-2.6.0-test1-getorder/include/asm-sparc/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-sparc/page.h	2003-07-13 20:32:31.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-sparc/page.h	2003-07-23 15:00:30.000000000 -0700
@@ -132,19 +132,7 @@
 
 #define TASK_UNMAPPED_BASE	BTFIXUP_SETHI(sparc_unmapped_base)
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 #else /* !(__ASSEMBLY__) */
 
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-sparc64/page.h linux-2.6.0-test1-getorder/include/asm-sparc64/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-sparc64/page.h	2003-07-13 20:33:45.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-sparc64/page.h	2003-07-23 15:00:12.000000000 -0700
@@ -149,19 +149,7 @@
 
 extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS];
 
-/* Pure 2^n version of get_order */
-static __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 #endif /* !(__ASSEMBLY__) */
 
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-v850/page.h linux-2.6.0-test1-getorder/include/asm-v850/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-v850/page.h	2003-07-13 20:35:13.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-v850/page.h	2003-07-23 15:00:43.000000000 -0700
@@ -100,19 +100,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order (unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 #endif /* !__ASSEMBLY__ */
 
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/include/asm-x86_64/page.h linux-2.6.0-test1-getorder/include/asm-x86_64/page.h
--- linux-2.6.0-test1-VIRGIN/include/asm-x86_64/page.h	2003-07-13 20:29:30.000000000 -0700
+++ linux-2.6.0-test1-getorder/include/asm-x86_64/page.h	2003-07-23 15:00:53.000000000 -0700
@@ -86,19 +86,7 @@
 
 #include <asm/bug.h>
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
 
 #endif /* __ASSEMBLY__ */
 
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/lib/get_order.c linux-2.6.0-test1-getorder/lib/get_order.c
--- linux-2.6.0-test1-VIRGIN/lib/get_order.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.0-test1-getorder/lib/get_order.c	2003-07-23 16:21:40.000000000 -0700
@@ -0,0 +1,25 @@
+/*
+ *  linux/lib/get_order.c
+ *
+ * See <asm-generic/get_order.h> for information about this function
+ */
+
+#include <linux/module.h>
+#include <asm/page.h>
+
+#ifndef __HAVE_ARCH_GET_ORDER
+
+int __get_order(unsigned long size)
+{
+	int order = -1;
+
+	size = (size - 1) >> (PAGE_SHIFT - 1);
+	do {
+		size >>= 1;
+		order++;
+	} while (size != 0);
+	return order;
+}
+EXPORT_SYMBOL(__get_order);
+
+#endif /* !__HAVE_ARCH_GET_ORDER */
diff -urN -X dontdiff linux-2.6.0-test1-VIRGIN/lib/Makefile linux-2.6.0-test1-getorder/lib/Makefile
--- linux-2.6.0-test1-VIRGIN/lib/Makefile	2003-07-13 20:29:30.000000000 -0700
+++ linux-2.6.0-test1-getorder/lib/Makefile	2003-07-23 14:44:41.000000000 -0700
@@ -5,7 +5,7 @@
 
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
-	 kobject.o idr.o div64.o
+	 kobject.o idr.o div64.o get_order.o
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
