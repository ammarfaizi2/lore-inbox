Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbWBNFRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWBNFRH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWBNFNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:13:32 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:30927 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030385AbWBNFFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:07 -0500
Message-Id: <20060214050445.411720000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:10 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 19/47] alpha: use generic bitops
Content-Disposition: inline; filename=alpha-2.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- unless defined(__alpha_cix__) and defined(__alpha_fix__)

  - remove generic_fls()
  - remove generic_hweight{64,32,16,8}()

- remove generic_fls64()
- remove find_{next,first}{,_zero}_bit()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/alpha/Kconfig         |    8 ++
 include/asm-alpha/bitops.h |  123 ++-------------------------------------------
 2 files changed, 15 insertions(+), 116 deletions(-)

Index: 2.6-rc/include/asm-alpha/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-alpha/bitops.h
+++ 2.6-rc/include/asm-alpha/bitops.h
@@ -319,9 +319,9 @@ static inline int fls(int word)
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
@@ -358,112 +358,12 @@ static inline unsigned long hweight64(un
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
 
@@ -487,21 +387,12 @@ sched_find_first_bit(unsigned long b[3])
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
 
Index: 2.6-rc/arch/alpha/Kconfig
===================================================================
--- 2.6-rc.orig/arch/alpha/Kconfig
+++ 2.6-rc/arch/alpha/Kconfig
@@ -25,6 +25,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config GENERIC_FIND_NEXT_BIT
+	bool
+	default y
+
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
@@ -447,6 +451,10 @@ config ALPHA_IRONGATE
 	depends on ALPHA_NAUTILUS
 	default y
 
+config GENERIC_HWEIGHT
+	bool
+	default y if !ALPHA_EV6 && !ALPHA_EV67
+
 config ALPHA_AVANTI
 	bool
 	depends on ALPHA_XL || ALPHA_AVANTI_CH

--
