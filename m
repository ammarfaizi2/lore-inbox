Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWBAJOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWBAJOU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWBAJOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:14:01 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:40778 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932259AbWBAJD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:28 -0500
Message-Id: <20060201090326.824836000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:42 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 18/44] alpha: use generic bitops
Content-Disposition: inline; filename=alpha-2.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()

- unless defined(__alpha_cix__) and defined(__alpha_fix__)

  - remove generic_fls()
  - remove generic_hweight{64,32,16,8}()

- remove generic_fls64()
- remove find_{next,first}{,_zero}_bit()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-alpha/bitops.h |  204 +--------------------------------------------
 1 files changed, 8 insertions(+), 196 deletions(-)

Index: 2.6-git/include/asm-alpha/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-alpha/bitops.h
+++ 2.6-git/include/asm-alpha/bitops.h
@@ -38,17 +38,6 @@ set_bit(unsigned long nr, volatile void 
 	:"Ir" (1UL << (nr & 31)), "m" (*m));
 }
 
-/*
- * WARNING: non atomic version.
- */
-static inline void
-__set_bit(unsigned long nr, volatile void * addr)
-{
-	int *m = ((int *) addr) + (nr >> 5);
-
-	*m |= 1 << (nr & 31);
-}
-
 #define smp_mb__before_clear_bit()	smp_mb()
 #define smp_mb__after_clear_bit()	smp_mb()
 
@@ -70,17 +59,6 @@ clear_bit(unsigned long nr, volatile voi
 	:"Ir" (1UL << (nr & 31)), "m" (*m));
 }
 
-/*
- * WARNING: non atomic version.
- */
-static __inline__ void
-__clear_bit(unsigned long nr, volatile void * addr)
-{
-	int *m = ((int *) addr) + (nr >> 5);
-
-	*m &= ~(1 << (nr & 31));
-}
-
 static inline void
 change_bit(unsigned long nr, volatile void * addr)
 {
@@ -99,17 +77,6 @@ change_bit(unsigned long nr, volatile vo
 	:"Ir" (1UL << (nr & 31)), "m" (*m));
 }
 
-/*
- * WARNING: non atomic version.
- */
-static __inline__ void
-__change_bit(unsigned long nr, volatile void * addr)
-{
-	int *m = ((int *) addr) + (nr >> 5);
-
-	*m ^= 1 << (nr & 31);
-}
-
 static inline int
 test_and_set_bit(unsigned long nr, volatile void *addr)
 {
@@ -137,20 +104,6 @@ test_and_set_bit(unsigned long nr, volat
 	return oldbit != 0;
 }
 
-/*
- * WARNING: non atomic version.
- */
-static inline int
-__test_and_set_bit(unsigned long nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	int *m = ((int *) addr) + (nr >> 5);
-	int old = *m;
-
-	*m = old | mask;
-	return (old & mask) != 0;
-}
-
 static inline int
 test_and_clear_bit(unsigned long nr, volatile void * addr)
 {
@@ -178,20 +131,6 @@ test_and_clear_bit(unsigned long nr, vol
 	return oldbit != 0;
 }
 
-/*
- * WARNING: non atomic version.
- */
-static inline int
-__test_and_clear_bit(unsigned long nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	int *m = ((int *) addr) + (nr >> 5);
-	int old = *m;
-
-	*m = old & ~mask;
-	return (old & mask) != 0;
-}
-
 static inline int
 test_and_change_bit(unsigned long nr, volatile void * addr)
 {
@@ -217,25 +156,7 @@ test_and_change_bit(unsigned long nr, vo
 	return oldbit != 0;
 }
 
-/*
- * WARNING: non atomic version.
- */
-static __inline__ int
-__test_and_change_bit(unsigned long nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	int *m = ((int *) addr) + (nr >> 5);
-	int old = *m;
-
-	*m = old ^ mask;
-	return (old & mask) != 0;
-}
-
-static inline int
-test_bit(int nr, const volatile void * addr)
-{
-	return (1UL & (((const int *) addr)[nr >> 5] >> (nr & 31))) != 0UL;
-}
+#include <asm-generic/bitops/non-atomic.h>
 
 /*
  * ffz = Find First Zero in word. Undefined if no zero exists,
@@ -319,9 +240,9 @@ static inline int fls(int word)
 	return 64 - __kernel_ctlz(word & 0xffffffff);
 }
 #else
-#define fls	generic_fls
+#include <asm-generic/bitops/fls.h>
 #endif
-#define fls64   generic_fls64
+#include <asm-generic/bitops/fls64.h>
 
 /* Compute powers of two for the given integer.  */
 static inline long floor_log2(unsigned long word)
@@ -358,112 +279,12 @@ static inline unsigned long hweight64(un
 #define hweight16(x)	(unsigned int) hweight64((x) & 0xfffful)
 #define hweight8(x)	(unsigned int) hweight64((x) & 0xfful)
 #else
-static inline unsigned long hweight64(unsigned long w)
-{
-	unsigned long result;
-	for (result = 0; w ; w >>= 1)
-		result += (w & 1);
-	return result;
-}
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x)  generic_hweight8(x)
+#include <asm-generic/bitops/hweight.h>
 #endif
 
 #endif /* __KERNEL__ */
 
-/*
- * Find next zero bit in a bitmap reasonably efficiently..
- */
-static inline unsigned long
-find_next_zero_bit(const void *addr, unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr;
-	unsigned long result = offset & ~63UL;
-	unsigned long tmp;
-
-	p += offset >> 6;
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
- found_first:
-	tmp |= ~0UL << size;
-	if (tmp == ~0UL)        /* Are any bits zero? */
-		return result + size; /* Nope. */
- found_middle:
-	return result + ffz(tmp);
-}
-
-/*
- * Find next one bit in a bitmap reasonably efficiently.
- */
-static inline unsigned long
-find_next_bit(const void * addr, unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr;
-	unsigned long result = offset & ~63UL;
-	unsigned long tmp;
-
-	p += offset >> 6;
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
- found_first:
-	tmp &= ~0UL >> (64 - size);
-	if (!tmp)
-		return result + size;
- found_middle:
-	return result + __ffs(tmp);
-}
-
-/*
- * The optimizer actually does good code for this case.
- */
-#define find_first_zero_bit(addr, size) \
-	find_next_zero_bit((addr), (size), 0)
-#define find_first_bit(addr, size) \
-	find_next_bit((addr), (size), 0)
+#include <asm-generic/bitops/find.h>
 
 #ifdef __KERNEL__
 
@@ -487,21 +308,12 @@ sched_find_first_bit(unsigned long b[3])
 	return __ffs(b0) + ofs;
 }
 
+#include <asm-generic/bitops/ext2-non-atomic.h>
 
-#define ext2_set_bit                 __test_and_set_bit
 #define ext2_set_bit_atomic(l,n,a)   test_and_set_bit(n,a)
-#define ext2_clear_bit               __test_and_clear_bit
 #define ext2_clear_bit_atomic(l,n,a) test_and_clear_bit(n,a)
-#define ext2_test_bit                test_bit
-#define ext2_find_first_zero_bit     find_first_zero_bit
-#define ext2_find_next_zero_bit      find_next_zero_bit
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
+
+#include <asm-generic/bitops/minix.h>
 
 #endif /* __KERNEL__ */
 

--
