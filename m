Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbWBNFTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWBNFTG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbWBNFNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:13:25 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:35023 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030388AbWBNFFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:07 -0500
Message-Id: <20060214050448.975047000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:29 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 38/47] v850: use generic bitops
Content-Disposition: inline; filename=v850.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove ffz()
- remove find_{next,first}{,_zero}_bit()
- remove generic_ffs()
- remove generic_fls()
- remove generic_fls64()
- remove __ffs()
- remove sched_find_first_bit()
- remove generic_hweight{32,16,8}()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/v850/Kconfig         |    6 +
 include/asm-v850/bitops.h |  222 ++--------------------------------------------
 2 files changed, 18 insertions(+), 210 deletions(-)

Index: 2.6-rc/include/asm-v850/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-v850/bitops.h
+++ 2.6-rc/include/asm-v850/bitops.h
@@ -22,25 +22,11 @@
 
 #ifdef __KERNEL__
 
-/*
- * The __ functions are not atomic
- */
+#include <asm-generic/bitops/ffz.h>
 
 /*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
+ * The __ functions are not atomic
  */
-static inline unsigned long ffz (unsigned long word)
-{
-	unsigned long result = 0;
-
-	while (word & 1) {
-		result++;
-		word >>= 1;
-	}
-	return result;
-}
-
 
 /* In the following constant-bit-op macros, a "g" constraint is used when
    we really need an integer ("i" constraint).  This is to avoid
@@ -153,203 +139,19 @@ static inline int __test_bit (int nr, co
 #define smp_mb__before_clear_bit()	barrier ()
 #define smp_mb__after_clear_bit()	barrier ()
 
+#include <asm-generic/bitops/ffs.h>
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/find.h>
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/hweight.h>
 
-#define find_first_zero_bit(addr, size) \
-  find_next_zero_bit ((addr), (size), 0)
-
-static inline int find_next_zero_bit(const void *addr, int size, int offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = * (p++);
-		tmp |= ~0UL >> (32-offset);
-		if (size < 32)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size & ~31UL) {
-		if (~ (tmp = * (p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
- found_first:
-	tmp |= ~0UL << size;
- found_middle:
-	return result + ffz (tmp);
-}
-
-
-/* This is the same as generic_ffs, but we can't use that because it's
-   inline and the #include order mucks things up.  */
-static inline int generic_ffs_for_find_next_bit(int x)
-{
-	int r = 1;
-
-	if (!x)
-		return 0;
-	if (!(x & 0xffff)) {
-		x >>= 16;
-		r += 16;
-	}
-	if (!(x & 0xff)) {
-		x >>= 8;
-		r += 8;
-	}
-	if (!(x & 0xf)) {
-		x >>= 4;
-		r += 4;
-	}
-	if (!(x & 3)) {
-		x >>= 2;
-		r += 2;
-	}
-	if (!(x & 1)) {
-		x >>= 1;
-		r += 1;
-	}
-	return r;
-}
-
-/*
- * Find next one bit in a bitmap reasonably efficiently.
- */
-static __inline__ unsigned long find_next_bit(const unsigned long *addr,
-	unsigned long size, unsigned long offset)
-{
-	unsigned int *p = ((unsigned int *) addr) + (offset >> 5);
-	unsigned int result = offset & ~31UL;
-	unsigned int tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *p++;
-		tmp &= ~0UL << offset;
-		if (size < 32)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size >= 32) {
-		if ((tmp = *p++) != 0)
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp &= ~0UL >> (32 - size);
-	if (tmp == 0UL)        /* Are any bits set? */
-		return result + size; /* Nope. */
-found_middle:
-	return result + generic_ffs_for_find_next_bit(tmp);
-}
-
-/*
- * find_first_bit - find the first set bit in a memory region
- */
-#define find_first_bit(addr, size) \
-	find_next_bit((addr), (size), 0)
-
-
-#define ffs(x) generic_ffs (x)
-#define fls(x) generic_fls (x)
-#define fls64(x) generic_fls64(x)
-#define __ffs(x) ffs(x)
-
-
-/*
- * This is just `generic_ffs' from <linux/bitops.h>, except that it assumes
- * that at least one bit is set, and returns the real index of the bit
- * (rather than the bit index + 1, like ffs does).
- */
-static inline int sched_ffs(int x)
-{
-	int r = 0;
-
-	if (!(x & 0xffff)) {
-		x >>= 16;
-		r += 16;
-	}
-	if (!(x & 0xff)) {
-		x >>= 8;
-		r += 8;
-	}
-	if (!(x & 0xf)) {
-		x >>= 4;
-		r += 4;
-	}
-	if (!(x & 3)) {
-		x >>= 2;
-		r += 2;
-	}
-	if (!(x & 1)) {
-		x >>= 1;
-		r += 1;
-	}
-	return r;
-}
-
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is set.
- */
-static inline int sched_find_first_bit(unsigned long *b)
-{
-	unsigned offs = 0;
-	while (! *b) {
-		b++;
-		offs += 32;
-	}
-	return sched_ffs (*b) + offs;
-}
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-#define hweight32(x) 			generic_hweight32 (x)
-#define hweight16(x) 			generic_hweight16 (x)
-#define hweight8(x) 			generic_hweight8 (x)
-
-#define ext2_set_bit			__test_and_set_bit
+#include <asm-generic/bitops/ext2-non-atomic.h>
 #define ext2_set_bit_atomic(l,n,a)      test_and_set_bit(n,a)
-#define ext2_clear_bit			__test_and_clear_bit
 #define ext2_clear_bit_atomic(l,n,a)    test_and_clear_bit(n,a)
-#define ext2_test_bit			test_bit
-#define ext2_find_first_zero_bit	find_first_zero_bit
-#define ext2_find_next_zero_bit		find_next_zero_bit
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit		__test_and_set_bit
-#define minix_set_bit			__set_bit
-#define minix_test_and_clear_bit	__test_and_clear_bit
-#define minix_test_bit 			test_bit
-#define minix_find_first_zero_bit 	find_first_zero_bit
+
+#include <asm-generic/bitops/minix.h>
 
 #endif /* __KERNEL__ */
 
Index: 2.6-rc/arch/v850/Kconfig
===================================================================
--- 2.6-rc.orig/arch/v850/Kconfig
+++ 2.6-rc/arch/v850/Kconfig
@@ -16,6 +16,12 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default n
+config GENERIC_FIND_NEXT_BIT
+	bool
+	default y
+config GENERIC_HWEIGHT
+	bool
+	default y
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y

--
