Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbWBNFNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbWBNFNy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWBNFNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:13:53 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:22991 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030375AbWBNFFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:05 -0500
Message-Id: <20060214050446.720915000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:17 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux-ia64@vger.kernel.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 26/47] ia64: use generic bitops
Content-Disposition: inline; filename=ia64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove generic_fls64()
- remove find_{next,first}{,_zero}_bit()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()
- remove sched_find_first_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/ia64/Kconfig         |    4 ++
 arch/ia64/lib/Makefile    |    2 -
 arch/ia64/lib/bitop.c     |   88 ----------------------------------------------
 include/asm-ia64/bitops.h |   67 ++++++++---------------------------
 4 files changed, 22 insertions(+), 139 deletions(-)

Index: 2.6-rc/include/asm-ia64/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-ia64/bitops.h
+++ 2.6-rc/include/asm-ia64/bitops.h
@@ -5,8 +5,8 @@
  * Copyright (C) 1998-2003 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  *
- * 02/06/02 find_next_bit() and find_first_bit() added from Erich Focht's ia64 O(1)
- *	    scheduler patch
+ * 02/06/02 find_next_bit() and find_first_bit() added from Erich Focht's ia64
+ * O(1) scheduler patch
  */
 
 #include <linux/compiler.h>
@@ -25,9 +25,9 @@
  * restricted to acting on a single-word quantity.
  *
  * The address must be (at least) "long" aligned.
- * Note that there are driver (e.g., eepro100) which use these operations to operate on
- * hw-defined data-structures, so we can't easily change these operations to force a
- * bigger alignment.
+ * Note that there are driver (e.g., eepro100) which use these operations to
+ * operate on hw-defined data-structures, so we can't easily change these
+ * operations to force a bigger alignment.
  *
  * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
  */
@@ -284,8 +284,8 @@ test_bit (int nr, const volatile void *a
  * ffz - find the first zero bit in a long word
  * @x: The long word to find the bit in
  *
- * Returns the bit-number (0..63) of the first (least significant) zero bit.  Undefined if
- * no zero exists, so code should check against ~0UL first...
+ * Returns the bit-number (0..63) of the first (least significant) zero bit.
+ * Undefined if no zero exists, so code should check against ~0UL first...
  */
 static inline unsigned long
 ffz (unsigned long x)
@@ -345,13 +345,14 @@ fls (int t)
 	x |= x >> 16;
 	return ia64_popcnt(x);
 }
-#define fls64(x)   generic_fls64(x)
+
+#include <asm-generic/bitops/fls64.h>
 
 /*
- * ffs: find first bit set. This is defined the same way as the libc and compiler builtin
- * ffs routines, therefore differs in spirit from the above ffz (man ffs): it operates on
- * "int" values only and the result value is the bit number + 1.  ffs(0) is defined to
- * return zero.
+ * ffs: find first bit set. This is defined the same way as the libc and
+ * compiler builtin ffs routines, therefore differs in spirit from the above
+ * ffz (man ffs): it operates on "int" values only and the result value is the
+ * bit number + 1.  ffs(0) is defined to return zero.
  */
 #define ffs(x)	__builtin_ffs(x)
 
@@ -373,51 +374,17 @@ hweight64 (unsigned long x)
 
 #endif /* __KERNEL__ */
 
-extern int __find_next_zero_bit (const void *addr, unsigned long size,
-			unsigned long offset);
-extern int __find_next_bit(const void *addr, unsigned long size,
-			unsigned long offset);
-
-#define find_next_zero_bit(addr, size, offset) \
-			__find_next_zero_bit((addr), (size), (offset))
-#define find_next_bit(addr, size, offset) \
-			__find_next_bit((addr), (size), (offset))
-
-/*
- * The optimizer actually does good code for this case..
- */
-#define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
-
-#define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
+#include <asm-generic/bitops/find.h>
 
 #ifdef __KERNEL__
 
-#define __clear_bit(nr, addr)		clear_bit(nr, addr)
+#include <asm-generic/bitops/ext2-non-atomic.h>
 
-#define ext2_set_bit			__test_and_set_bit
 #define ext2_set_bit_atomic(l,n,a)	test_and_set_bit(n,a)
-#define ext2_clear_bit			__test_and_clear_bit
 #define ext2_clear_bit_atomic(l,n,a)	test_and_clear_bit(n,a)
-#define ext2_test_bit			test_bit
-#define ext2_find_first_zero_bit	find_first_zero_bit
-#define ext2_find_next_zero_bit		find_next_zero_bit
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr)		__test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr)			__set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr)	__test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr)			test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size)	find_first_zero_bit(addr,size)
 
-static inline int
-sched_find_first_bit (unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return 64 + __ffs(b[1]);
-	return __ffs(b[2]) + 128;
-}
+#include <asm-generic/bitops/minix.h>
+#include <asm-generic/bitops/sched.h>
 
 #endif /* __KERNEL__ */
 
Index: 2.6-rc/arch/ia64/lib/Makefile
===================================================================
--- 2.6-rc.orig/arch/ia64/lib/Makefile
+++ 2.6-rc/arch/ia64/lib/Makefile
@@ -6,7 +6,7 @@ obj-y := io.o
 
 lib-y := __divsi3.o __udivsi3.o __modsi3.o __umodsi3.o			\
 	__divdi3.o __udivdi3.o __moddi3.o __umoddi3.o			\
-	bitop.o checksum.o clear_page.o csum_partial_copy.o		\
+	checksum.o clear_page.o csum_partial_copy.o			\
 	clear_user.o strncpy_from_user.o strlen_user.o strnlen_user.o	\
 	flush.o ip_fast_csum.o do_csum.o				\
 	memset.o strlen.o
Index: 2.6-rc/arch/ia64/lib/bitop.c
===================================================================
--- 2.6-rc.orig/arch/ia64/lib/bitop.c
+++ /dev/null
@@ -1,88 +0,0 @@
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <asm/intrinsics.h>
-#include <linux/module.h>
-#include <linux/bitops.h>
-
-/*
- * Find next zero bit in a bitmap reasonably efficiently..
- */
-
-int __find_next_zero_bit (const void *addr, unsigned long size, unsigned long offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 6);
-	unsigned long result = offset & ~63UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 63UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (64-offset);
-		if (size < 64)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 64;
-		result += 64;
-	}
-	while (size & ~63UL) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += 64;
-		size -= 64;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-found_first:
-	tmp |= ~0UL << size;
-	if (tmp == ~0UL)		/* any bits zero? */
-		return result + size;	/* nope */
-found_middle:
-	return result + ffz(tmp);
-}
-EXPORT_SYMBOL(__find_next_zero_bit);
-
-/*
- * Find next bit in a bitmap reasonably efficiently..
- */
-int __find_next_bit(const void *addr, unsigned long size, unsigned long offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 6);
-	unsigned long result = offset & ~63UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 63UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp &= ~0UL << offset;
-		if (size < 64)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= 64;
-		result += 64;
-	}
-	while (size & ~63UL) {
-		if ((tmp = *(p++)))
-			goto found_middle;
-		result += 64;
-		size -= 64;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-  found_first:
-	tmp &= ~0UL >> (64-size);
-	if (tmp == 0UL)		/* Are any bits set? */
-		return result + size; /* Nope. */
-  found_middle:
-	return result + __ffs(tmp);
-}
-EXPORT_SYMBOL(__find_next_bit);
Index: 2.6-rc/arch/ia64/Kconfig
===================================================================
--- 2.6-rc.orig/arch/ia64/Kconfig
+++ 2.6-rc/arch/ia64/Kconfig
@@ -34,6 +34,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config GENERIC_FIND_NEXT_BIT
+	bool
+	default y
+
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y

--
