Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264435AbTDOLNn (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 07:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbTDOLNn (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 07:13:43 -0400
Received: from zero.aec.at ([193.170.194.10]:7443 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264435AbTDOLNd (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 07:13:33 -0400
Date: Tue, 15 Apr 2003 13:24:30 +0200
From: Andi Kleen <ak@muc.de>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, anton@samba.org,
       schwidefsky@de.ibm.com, davidm@hpl.hp.com, matthew@wil.cx,
       ralf@linux-mips.org, rth@redhat.com
Subject: Reduce struct page by 8 bytes on 64bit
Message-ID: <20030415112430.GA21072@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(all 64bit maintainers in cc) 

struct page currently has this:

struct page {
        unsigned long flags;            /* atomic flags, some possibly
                                           updated asynchronously */
        atomic_t count;                 /* Usage count, see below. */
        struct list_head list;          /* ->mapping has some page lists. */

On a 64bit host only 32bit of flags are used, the second 32bit are wated. 
atomic_t is also normally 32bit, which requires 4 bytes of padding for 
natural alignment. Together this gives 8 byte wasted. 

8 byte overhead in struct page is 2MB wasted on a 1GB 64bit system with 4K pages.

This could be avoided if flags was declared to a 32bit type.
The problem is that some architectures need the unsigned long for atomic
set_bit/clear_bit. Others like x86-64 do not - they can toggle bits
atomically in any data type.

I worked around this by declaring a new data type atomic_bitmask32
with matching set_bit32/clear_bit32 etc. interfaces. Currently only 
on x86-64 aomitc_bitmask32 is defined to unsigned, everybody else
still uses unsigned long. The other 64bit architectures can define it to
unsigned too if they can confirm that it's ok to do.

Patch for 2.5.67.

-Andi


diff -u linux-2.5.67-work/include/asm-alpha/bitops.h-BM32 linux-2.5.67-work/include/asm-alpha/bitops.h
--- linux-2.5.67-work/include/asm-alpha/bitops.h-BM32	2003-03-05 10:40:23.000000000 +0100
+++ linux-2.5.67-work/include/asm-alpha/bitops.h	2003-04-14 10:41:54.000000000 +0200
@@ -499,6 +499,8 @@
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _ALPHA_BITOPS_H */
diff -u linux-2.5.67-work/include/asm-arm/bitops.h-BM32 linux-2.5.67-work/include/asm-arm/bitops.h
--- linux-2.5.67-work/include/asm-arm/bitops.h-BM32	2003-03-05 10:40:23.000000000 +0100
+++ linux-2.5.67-work/include/asm-arm/bitops.h	2003-04-14 10:41:53.000000000 +0200
@@ -381,6 +381,8 @@
 #define minix_find_first_zero_bit(p,sz)		\
 		_find_first_zero_bit_le(p,sz)
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _ARM_BITOPS_H */
diff -u linux-2.5.67-work/include/asm-cris/bitops.h-BM32 linux-2.5.67-work/include/asm-cris/bitops.h
--- linux-2.5.67-work/include/asm-cris/bitops.h-BM32	2003-02-10 19:38:53.000000000 +0100
+++ linux-2.5.67-work/include/asm-cris/bitops.h	2003-04-14 10:41:53.000000000 +0200
@@ -410,6 +410,8 @@
 #undef MAX_RT_PRIO
 #endif
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _CRIS_BITOPS_H */
diff -u /dev/null linux-2.5.67-work/include/asm-generic/bitops32.h
--- /dev/null	2002-10-01 20:59:47.000000000 +0200
+++ linux-2.5.67-work/include/asm-generic/bitops32.h	2003-04-14 10:44:51.000000000 +0200
@@ -0,0 +1,17 @@
+#ifndef _BITFLAGS32_H
+#define _BITFLAGS32_H 1
+
+/* Fallback. Use unsigned long for 32bit bitflags operations.
+   If your architecture supports this on unsigned change it in bitops.h
+   (makes only sense on 64bit architectures) */
+
+typedef unsigned long atomic_bitmask32; 
+#define set_bit32 set_bit
+#define __set_bit32 __set_bit
+#define clear_bit32 clear_bit
+#define __clear_bit32 __clear_bit
+#define test_bit32 test_bit
+#define test_and_set_bit32 test_and_set_bit
+#define test_and_clear_bit32 test_and_clear_bit
+
+#endif
diff -u linux-2.5.67-work/include/asm-i386/bitops.h-BM32 linux-2.5.67-work/include/asm-i386/bitops.h
--- linux-2.5.67-work/include/asm-i386/bitops.h-BM32	2003-03-28 18:32:28.000000000 +0100
+++ linux-2.5.67-work/include/asm-i386/bitops.h	2003-04-14 10:41:53.000000000 +0200
@@ -495,6 +495,8 @@
 #define minix_find_first_zero_bit(addr,size) \
 	find_first_zero_bit((void*)addr,size)
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _I386_BITOPS_H */
diff -u linux-2.5.67-work/include/asm-ia64/bitops.h-BM32 linux-2.5.67-work/include/asm-ia64/bitops.h
--- linux-2.5.67-work/include/asm-ia64/bitops.h-BM32	2003-02-10 19:38:53.000000000 +0100
+++ linux-2.5.67-work/include/asm-ia64/bitops.h	2003-04-14 10:41:53.000000000 +0200
@@ -475,6 +475,8 @@
 	return __ffs(b[2]) + 128;
 }
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_IA64_BITOPS_H */
diff -u linux-2.5.67-work/include/asm-m68k/bitops.h-BM32 linux-2.5.67-work/include/asm-m68k/bitops.h
--- linux-2.5.67-work/include/asm-m68k/bitops.h-BM32	2003-02-10 19:39:18.000000000 +0100
+++ linux-2.5.67-work/include/asm-m68k/bitops.h	2003-04-14 10:41:52.000000000 +0200
@@ -416,6 +416,8 @@
 	return (p - addr) * 32 + res;
 }
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _M68K_BITOPS_H */
diff -u linux-2.5.67-work/include/asm-m68knommu/bitops.h-BM32 linux-2.5.67-work/include/asm-m68knommu/bitops.h
--- linux-2.5.67-work/include/asm-m68knommu/bitops.h-BM32	2003-02-10 19:37:58.000000000 +0100
+++ linux-2.5.67-work/include/asm-m68knommu/bitops.h	2003-04-14 10:41:52.000000000 +0200
@@ -483,6 +483,8 @@
 #define hweight16(x) generic_hweight16(x)
 #define hweight8(x) generic_hweight8(x)
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _M68KNOMMU_BITOPS_H */
diff -u linux-2.5.67-work/include/asm-mips/bitops.h-BM32 linux-2.5.67-work/include/asm-mips/bitops.h
--- linux-2.5.67-work/include/asm-mips/bitops.h-BM32	2003-02-10 19:37:58.000000000 +0100
+++ linux-2.5.67-work/include/asm-mips/bitops.h	2003-04-14 10:41:52.000000000 +0200
@@ -909,4 +909,6 @@
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
+#include <asm-generic/bitops32.h>
+
 #endif /* _ASM_BITOPS_H */
diff -u linux-2.5.67-work/include/asm-mips64/bitops.h-BM32 linux-2.5.67-work/include/asm-mips64/bitops.h
--- linux-2.5.67-work/include/asm-mips64/bitops.h-BM32	2003-02-10 19:38:52.000000000 +0100
+++ linux-2.5.67-work/include/asm-mips64/bitops.h	2003-04-14 10:41:52.000000000 +0200
@@ -618,6 +618,8 @@
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_BITOPS_H */
diff -u linux-2.5.67-work/include/asm-parisc/bitops.h-BM32 linux-2.5.67-work/include/asm-parisc/bitops.h
--- linux-2.5.67-work/include/asm-parisc/bitops.h-BM32	2003-02-10 19:37:56.000000000 +0100
+++ linux-2.5.67-work/include/asm-parisc/bitops.h	2003-04-14 10:41:51.000000000 +0200
@@ -455,4 +455,6 @@
 #define minix_test_bit(nr,addr) ext2_test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) ext2_find_first_zero_bit(addr,size)
 
+#include <asm-generic/bitops32.h>
+
 #endif /* _PARISC_BITOPS_H */
diff -u linux-2.5.67-work/include/asm-ppc/bitops.h-BM32 linux-2.5.67-work/include/asm-ppc/bitops.h
--- linux-2.5.67-work/include/asm-ppc/bitops.h-BM32	2003-02-10 19:38:37.000000000 +0100
+++ linux-2.5.67-work/include/asm-ppc/bitops.h	2003-04-14 10:41:51.000000000 +0200
@@ -454,5 +454,7 @@
 #define minix_test_bit(nr,addr) ext2_test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) ext2_find_first_zero_bit(addr,size)
 
+#include <asm-generic/bitops32.h>
+
 #endif /* _PPC_BITOPS_H */
 #endif /* __KERNEL__ */
diff -u linux-2.5.67-work/include/asm-ppc64/bitops.h-BM32 linux-2.5.67-work/include/asm-ppc64/bitops.h
--- linux-2.5.67-work/include/asm-ppc64/bitops.h-BM32	2003-02-10 19:38:49.000000000 +0100
+++ linux-2.5.67-work/include/asm-ppc64/bitops.h	2003-04-14 10:41:51.000000000 +0200
@@ -350,5 +350,7 @@
 #define minix_test_bit(nr,addr)			test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size)	find_first_zero_bit(addr,size)
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 #endif /* _PPC64_BITOPS_H */
diff -u linux-2.5.67-work/include/asm-s390/bitops.h-BM32 linux-2.5.67-work/include/asm-s390/bitops.h
--- linux-2.5.67-work/include/asm-s390/bitops.h-BM32	2003-04-09 22:35:12.000000000 +0200
+++ linux-2.5.67-work/include/asm-s390/bitops.h	2003-04-14 10:41:51.000000000 +0200
@@ -901,6 +901,8 @@
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _S390_BITOPS_H */
diff -u linux-2.5.67-work/include/asm-s390x/bitops.h-BM32 linux-2.5.67-work/include/asm-s390x/bitops.h
--- linux-2.5.67-work/include/asm-s390x/bitops.h-BM32	2003-03-28 18:32:29.000000000 +0100
+++ linux-2.5.67-work/include/asm-s390x/bitops.h	2003-04-14 10:41:51.000000000 +0200
@@ -941,6 +941,8 @@
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _S390_BITOPS_H */
diff -u linux-2.5.67-work/include/asm-sh/bitops.h-BM32 linux-2.5.67-work/include/asm-sh/bitops.h
--- linux-2.5.67-work/include/asm-sh/bitops.h-BM32	2003-02-10 19:37:56.000000000 +0100
+++ linux-2.5.67-work/include/asm-sh/bitops.h	2003-04-14 10:41:50.000000000 +0200
@@ -351,6 +351,8 @@
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_SH_BITOPS_H */
diff -u linux-2.5.67-work/include/asm-sparc/bitops.h-BM32 linux-2.5.67-work/include/asm-sparc/bitops.h
--- linux-2.5.67-work/include/asm-sparc/bitops.h-BM32	2003-02-10 19:38:53.000000000 +0100
+++ linux-2.5.67-work/include/asm-sparc/bitops.h	2003-04-14 10:41:50.000000000 +0200
@@ -466,6 +466,8 @@
 #define minix_test_bit(nr,addr)			test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size)	find_first_zero_bit(addr,size)
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* defined(_SPARC_BITOPS_H) */
diff -u linux-2.5.67-work/include/asm-sparc64/bitops.h-BM32 linux-2.5.67-work/include/asm-sparc64/bitops.h
--- linux-2.5.67-work/include/asm-sparc64/bitops.h-BM32	2003-02-10 19:38:00.000000000 +0100
+++ linux-2.5.67-work/include/asm-sparc64/bitops.h	2003-04-14 10:41:50.000000000 +0200
@@ -367,6 +367,8 @@
 #define minix_find_first_zero_bit(addr,size) \
 	find_first_zero_bit((unsigned long *)(addr),(size))
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* defined(_SPARC64_BITOPS_H) */
diff -u linux-2.5.67-work/include/asm-v850/bitops.h-BM32 linux-2.5.67-work/include/asm-v850/bitops.h
--- linux-2.5.67-work/include/asm-v850/bitops.h-BM32	2003-02-10 19:37:56.000000000 +0100
+++ linux-2.5.67-work/include/asm-v850/bitops.h	2003-04-14 10:41:50.000000000 +0200
@@ -264,6 +264,8 @@
 #define minix_test_bit 			test_bit
 #define minix_find_first_zero_bit 	find_first_zero_bit
 
+#include <asm-generic/bitops32.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* __V850_BITOPS_H__ */
diff -u linux-2.5.67-work/include/asm-x86_64/bitops.h-BM32 linux-2.5.67-work/include/asm-x86_64/bitops.h
--- linux-2.5.67-work/include/asm-x86_64/bitops.h-BM32	2003-02-26 12:55:30.000000000 +0100
+++ linux-2.5.67-work/include/asm-x86_64/bitops.h	2003-04-14 10:46:18.000000000 +0200
@@ -506,6 +506,16 @@
 /* find last set bit */
 #define fls(x) generic_fls(x)
 
+/* bitflag operations on 32bit */
+typedef unsigned int atomic_bitmask32; 
+#define set_bit32 set_bit
+#define __set_bit32 __set_bit
+#define clear_bit32 clear_bit
+#define __clear_bit32 __clear_bit
+#define test_bit32 test_bit
+#define test_and_set_bit32 test_and_set_bit
+#define test_and_clear_bit32 test_and_clear_bit
+
 #endif /* __KERNEL__ */
 
 #endif /* _X86_64_BITOPS_H */
diff -u linux-2.5.67-work/include/linux/mm.h-BM32 linux-2.5.67-work/include/linux/mm.h
--- linux-2.5.67-work/include/linux/mm.h-BM32	2003-03-28 18:32:29.000000000 +0100
+++ linux-2.5.67-work/include/linux/mm.h	2003-04-14 10:47:22.000000000 +0200
@@ -24,6 +24,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/atomic.h>
+#include <asm/bitops.h>
 
 /*
  * Linux kernel virtual memory manager primitives.
@@ -158,7 +159,7 @@
  * TODO: make this structure smaller, it could be as small as 32 bytes.
  */
 struct page {
-	unsigned long flags;		/* atomic flags, some possibly
+	atomic_bitmask32 flags;	/* atomic flags, some possibly
 					   updated asynchronously */
 	atomic_t count;			/* Usage count, see below. */
 	struct list_head list;		/* ->mapping has some page lists. */
@@ -314,7 +315,7 @@
  * sets it, so none of the operations on it need to be atomic.
  */
 #define NODE_SHIFT 4
-#define ZONE_SHIFT (BITS_PER_LONG - 8)
+#define ZONE_SHIFT (sizeof(atomic_bitmask32)*8 - 8)
 
 struct zone;
 extern struct zone *zone_table[];
@@ -326,7 +327,7 @@
 
 static inline void set_page_zone(struct page *page, unsigned long zone_num)
 {
-	page->flags &= ~(~0UL << ZONE_SHIFT);
+	page->flags &= ~(~(atomic_bitmask32)0U << ZONE_SHIFT);
 	page->flags |= zone_num << ZONE_SHIFT;
 }
 
diff -u linux-2.5.67-work/include/linux/page-flags.h-BM32 linux-2.5.67-work/include/linux/page-flags.h
--- linux-2.5.67-work/include/linux/page-flags.h-BM32	2003-03-28 18:32:29.000000000 +0100
+++ linux-2.5.67-work/include/linux/page-flags.h	2003-04-14 10:44:30.000000000 +0200
@@ -137,78 +137,78 @@
  * Manipulation of page state flags
  */
 #define PageLocked(page)		\
-		test_bit(PG_locked, &(page)->flags)
+		test_bit32(PG_locked, &(page)->flags)
 #define SetPageLocked(page)		\
-		set_bit(PG_locked, &(page)->flags)
+		set_bit32(PG_locked, &(page)->flags)
 #define TestSetPageLocked(page)		\
 		test_and_set_bit(PG_locked, &(page)->flags)
 #define ClearPageLocked(page)		\
-		clear_bit(PG_locked, &(page)->flags)
+		clear_bit32(PG_locked, &(page)->flags)
 #define TestClearPageLocked(page)	\
-		test_and_clear_bit(PG_locked, &(page)->flags)
+		test_and_clear_bit32(PG_locked, &(page)->flags)
 
-#define PageError(page)		test_bit(PG_error, &(page)->flags)
-#define SetPageError(page)	set_bit(PG_error, &(page)->flags)
-#define ClearPageError(page)	clear_bit(PG_error, &(page)->flags)
-
-#define PageReferenced(page)	test_bit(PG_referenced, &(page)->flags)
-#define SetPageReferenced(page)	set_bit(PG_referenced, &(page)->flags)
-#define ClearPageReferenced(page)	clear_bit(PG_referenced, &(page)->flags)
-#define TestClearPageReferenced(page) test_and_clear_bit(PG_referenced, &(page)->flags)
-
-#define PageUptodate(page)	test_bit(PG_uptodate, &(page)->flags)
-#define SetPageUptodate(page)	set_bit(PG_uptodate, &(page)->flags)
-#define ClearPageUptodate(page)	clear_bit(PG_uptodate, &(page)->flags)
-
-#define PageDirty(page)		test_bit(PG_dirty, &(page)->flags)
-#define SetPageDirty(page)	set_bit(PG_dirty, &(page)->flags)
-#define TestSetPageDirty(page)	test_and_set_bit(PG_dirty, &(page)->flags)
-#define ClearPageDirty(page)	clear_bit(PG_dirty, &(page)->flags)
-#define TestClearPageDirty(page) test_and_clear_bit(PG_dirty, &(page)->flags)
-
-#define SetPageLRU(page)	set_bit(PG_lru, &(page)->flags)
-#define PageLRU(page)		test_bit(PG_lru, &(page)->flags)
-#define TestSetPageLRU(page)	test_and_set_bit(PG_lru, &(page)->flags)
-#define TestClearPageLRU(page)	test_and_clear_bit(PG_lru, &(page)->flags)
-
-#define PageActive(page)	test_bit(PG_active, &(page)->flags)
-#define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
-#define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
-#define TestClearPageActive(page) test_and_clear_bit(PG_active, &(page)->flags)
-#define TestSetPageActive(page) test_and_set_bit(PG_active, &(page)->flags)
-
-#define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
-#define SetPageSlab(page)	set_bit(PG_slab, &(page)->flags)
-#define ClearPageSlab(page)	clear_bit(PG_slab, &(page)->flags)
+#define PageError(page)		test_bit32(PG_error, &(page)->flags)
+#define SetPageError(page)	set_bit32(PG_error, &(page)->flags)
+#define ClearPageError(page)	clear_bit32(PG_error, &(page)->flags)
+
+#define PageReferenced(page)	test_bit32(PG_referenced, &(page)->flags)
+#define SetPageReferenced(page)	set_bit32(PG_referenced, &(page)->flags)
+#define ClearPageReferenced(page)	clear_bit32(PG_referenced, &(page)->flags)
+#define TestClearPageReferenced(page) test_and_clear_bit32(PG_referenced, &(page)->flags)
+
+#define PageUptodate(page)	test_bit32(PG_uptodate, &(page)->flags)
+#define SetPageUptodate(page)	set_bit32(PG_uptodate, &(page)->flags)
+#define ClearPageUptodate(page)	clear_bit32(PG_uptodate, &(page)->flags)
+
+#define PageDirty(page)		test_bit32(PG_dirty, &(page)->flags)
+#define SetPageDirty(page)	set_bit32(PG_dirty, &(page)->flags)
+#define TestSetPageDirty(page)	test_and_set_bit32(PG_dirty, &(page)->flags)
+#define ClearPageDirty(page)	clear_bit32(PG_dirty, &(page)->flags)
+#define TestClearPageDirty(page) test_and_clear_bit32(PG_dirty, &(page)->flags)
+
+#define SetPageLRU(page)	set_bit32(PG_lru, &(page)->flags)
+#define PageLRU(page)		test_bit32(PG_lru, &(page)->flags)
+#define TestSetPageLRU(page)	test_and_set_bit32(PG_lru, &(page)->flags)
+#define TestClearPageLRU(page)	test_and_clear_bit32(PG_lru, &(page)->flags)
+
+#define PageActive(page)	test_bit32(PG_active, &(page)->flags)
+#define SetPageActive(page)	set_bit32(PG_active, &(page)->flags)
+#define ClearPageActive(page)	clear_bit32(PG_active, &(page)->flags)
+#define TestClearPageActive(page) test_and_clear_bit32(PG_active, &(page)->flags)
+#define TestSetPageActive(page) test_and_set_bit32(PG_active, &(page)->flags)
+
+#define PageSlab(page)		test_bit32(PG_slab, &(page)->flags)
+#define SetPageSlab(page)	set_bit32(PG_slab, &(page)->flags)
+#define ClearPageSlab(page)	clear_bit32(PG_slab, &(page)->flags)
 
 #ifdef CONFIG_HIGHMEM
-#define PageHighMem(page)	test_bit(PG_highmem, &(page)->flags)
+#define PageHighMem(page)	test_bit32(PG_highmem, &(page)->flags)
 #else
 #define PageHighMem(page)	0 /* needed to optimize away at compile time */
 #endif
 
-#define PageChecked(page)	test_bit(PG_checked, &(page)->flags)
-#define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
+#define PageChecked(page)	test_bit32(PG_checked, &(page)->flags)
+#define SetPageChecked(page)	set_bit32(PG_checked, &(page)->flags)
 
-#define PageReserved(page)	test_bit(PG_reserved, &(page)->flags)
-#define SetPageReserved(page)	set_bit(PG_reserved, &(page)->flags)
-#define ClearPageReserved(page)	clear_bit(PG_reserved, &(page)->flags)
-
-#define SetPagePrivate(page)	set_bit(PG_private, &(page)->flags)
-#define ClearPagePrivate(page)	clear_bit(PG_private, &(page)->flags)
-#define PagePrivate(page)	test_bit(PG_private, &(page)->flags)
+#define PageReserved(page)	test_bit32(PG_reserved, &(page)->flags)
+#define SetPageReserved(page)	set_bit32(PG_reserved, &(page)->flags)
+#define ClearPageReserved(page)	clear_bit32(PG_reserved, &(page)->flags)
+
+#define SetPagePrivate(page)	set_bit32(PG_private, &(page)->flags)
+#define ClearPagePrivate(page)	clear_bit32(PG_private, &(page)->flags)
+#define PagePrivate(page)	test_bit32(PG_private, &(page)->flags)
 
-#define PageWriteback(page)	test_bit(PG_writeback, &(page)->flags)
+#define PageWriteback(page)	test_bit32(PG_writeback, &(page)->flags)
 #define SetPageWriteback(page)						\
 	do {								\
-		if (!test_and_set_bit(PG_writeback,			\
+		if (!test_and_set_bit32(PG_writeback,			\
 				&(page)->flags))			\
 			inc_page_state(nr_writeback);			\
 	} while (0)
 #define TestSetPageWriteback(page)					\
 	({								\
 		int ret;						\
-		ret = test_and_set_bit(PG_writeback,			\
+		ret = test_and_set_bit32(PG_writeback,			\
 					&(page)->flags);		\
 		if (!ret)						\
 			inc_page_state(nr_writeback);			\
@@ -216,44 +216,44 @@
 	})
 #define ClearPageWriteback(page)					\
 	do {								\
-		if (test_and_clear_bit(PG_writeback,			\
+		if (test_and_clear_bit32(PG_writeback,			\
 				&(page)->flags))			\
 			dec_page_state(nr_writeback);			\
 	} while (0)
 #define TestClearPageWriteback(page)					\
 	({								\
 		int ret;						\
-		ret = test_and_clear_bit(PG_writeback,			\
+		ret = test_and_clear_bit32(PG_writeback,			\
 				&(page)->flags);			\
 		if (ret)						\
 			dec_page_state(nr_writeback);			\
 		ret;							\
 	})
 
-#define PageNosave(page)	test_bit(PG_nosave, &(page)->flags)
-#define SetPageNosave(page)	set_bit(PG_nosave, &(page)->flags)
-#define TestSetPageNosave(page)	test_and_set_bit(PG_nosave, &(page)->flags)
-#define ClearPageNosave(page)		clear_bit(PG_nosave, &(page)->flags)
-#define TestClearPageNosave(page)	test_and_clear_bit(PG_nosave, &(page)->flags)
-
-#define PageDirect(page)	test_bit(PG_direct, &(page)->flags)
-#define SetPageDirect(page)	set_bit(PG_direct, &(page)->flags)
-#define TestSetPageDirect(page)	test_and_set_bit(PG_direct, &(page)->flags)
-#define ClearPageDirect(page)		clear_bit(PG_direct, &(page)->flags)
-#define TestClearPageDirect(page)	test_and_clear_bit(PG_direct, &(page)->flags)
-
-#define PageMappedToDisk(page)	test_bit(PG_mappedtodisk, &(page)->flags)
-#define SetPageMappedToDisk(page) set_bit(PG_mappedtodisk, &(page)->flags)
-#define ClearPageMappedToDisk(page) clear_bit(PG_mappedtodisk, &(page)->flags)
-
-#define PageReclaim(page)	test_bit(PG_reclaim, &(page)->flags)
-#define SetPageReclaim(page)	set_bit(PG_reclaim, &(page)->flags)
-#define ClearPageReclaim(page)	clear_bit(PG_reclaim, &(page)->flags)
-#define TestClearPageReclaim(page) test_and_clear_bit(PG_reclaim, &(page)->flags)
-
-#define PageCompound(page)	test_bit(PG_compound, &(page)->flags)
-#define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
-#define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
+#define PageNosave(page)	test_bit32(PG_nosave, &(page)->flags)
+#define SetPageNosave(page)	set_bit32(PG_nosave, &(page)->flags)
+#define TestSetPageNosave(page)	test_and_set_bit32(PG_nosave, &(page)->flags)
+#define ClearPageNosave(page)		clear_bit32(PG_nosave, &(page)->flags)
+#define TestClearPageNosave(page)	test_and_clear_bit32(PG_nosave, &(page)->flags)
+
+#define PageDirect(page)	test_bit32(PG_direct, &(page)->flags)
+#define SetPageDirect(page)	set_bit32(PG_direct, &(page)->flags)
+#define TestSetPageDirect(page)	test_and_set_bit32(PG_direct, &(page)->flags)
+#define ClearPageDirect(page)		clear_bit32(PG_direct, &(page)->flags)
+#define TestClearPageDirect(page)	test_and_clear_bit32(PG_direct, &(page)->flags)
+
+#define PageMappedToDisk(page)	test_bit32(PG_mappedtodisk, &(page)->flags)
+#define SetPageMappedToDisk(page) set_bit32(PG_mappedtodisk, &(page)->flags)
+#define ClearPageMappedToDisk(page) clear_bit32(PG_mappedtodisk, &(page)->flags)
+
+#define PageReclaim(page)	test_bit32(PG_reclaim, &(page)->flags)
+#define SetPageReclaim(page)	set_bit32(PG_reclaim, &(page)->flags)
+#define ClearPageReclaim(page)	clear_bit32(PG_reclaim, &(page)->flags)
+#define TestClearPageReclaim(page) test_and_clear_bit32(PG_reclaim, &(page)->flags)
+
+#define PageCompound(page)	test_bit32(PG_compound, &(page)->flags)
+#define SetPageCompound(page)	set_bit32(PG_compound, &(page)->flags)
+#define ClearPageCompound(page)	clear_bit32(PG_compound, &(page)->flags)
 
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
diff -u linux-2.5.67-work/mm/page_alloc.c-BM32 linux-2.5.67-work/mm/page_alloc.c
--- linux-2.5.67-work/mm/page_alloc.c-BM32	2003-04-11 20:06:58.000000000 +0200
+++ linux-2.5.67-work/mm/page_alloc.c	2003-04-14 10:49:34.000000000 +0200
@@ -70,7 +70,7 @@
 {
 	printk("Bad page state at %s\n", function);
 	printk("flags:0x%08lx mapping:%p mapped:%d count:%d\n",
-		page->flags, page->mapping,
+		(unsigned long)page->flags, page->mapping,
 		page_mapped(page), page_count(page));
 	printk("Backtrace:\n");
 	dump_stack();


