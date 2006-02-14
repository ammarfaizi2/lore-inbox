Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbWBNFKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWBNFKN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWBNFIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:08:38 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:51407 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030399AbWBNFFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:10 -0500
Message-Id: <20060214050447.315051000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:20 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Greg Ungerer <gerg@uclinux.org>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 29/47] m68knommu: use generic bitops
Content-Disposition: inline; filename=m68knommu.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove ffs()
- remove __ffs()
- remove sched_find_first_bit()
- remove ffz()
- remove find_{next,first}{,_zero}_bit()
- remove generic_hweight()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()
- remove generic_fls()
- remove generic_fls64()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/m68knommu/Kconfig         |    8 +
 include/asm-m68knommu/bitops.h |  221 +----------------------------------------
 2 files changed, 17 insertions(+), 212 deletions(-)

Index: 2.6-rc/include/asm-m68knommu/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-m68knommu/bitops.h
+++ 2.6-rc/include/asm-m68knommu/bitops.h
@@ -12,104 +12,10 @@
 
 #ifdef __KERNEL__
 
-/*
- *	Generic ffs().
- */
-static inline int ffs(int x)
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
- *	Generic __ffs().
- */
-static inline int __ffs(int x)
-{
-	int r = 0;
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
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-}
-
-/*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
- */
-static __inline__ unsigned long ffz(unsigned long word)
-{
-	unsigned long result = 0;
-
-	while(word & 1) {
-		result++;
-		word >>= 1;
-	}
-	return result;
-}
-
+#include <asm-generic/bitops/ffs.h>
+#include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/ffz.h>
 
 static __inline__ void set_bit(int nr, volatile unsigned long * addr)
 {
@@ -254,98 +160,8 @@ static __inline__ int __test_bit(int nr,
  __constant_test_bit((nr),(addr)) : \
  __test_bit((nr),(addr)))
 
-#define find_first_zero_bit(addr, size) \
-        find_next_zero_bit((addr), (size), 0)
-#define find_first_bit(addr, size) \
-        find_next_bit((addr), (size), 0)
-
-static __inline__ int find_next_zero_bit (const void * addr, int size, int offset)
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
-		tmp = *(p++);
-		tmp |= ~0UL >> (32-offset);
-		if (size < 32)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size & ~31UL) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp |= ~0UL << size;
-found_middle:
-	return result + ffz(tmp);
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
-	return result + __ffs(tmp);
-}
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
-
+#include <asm-generic/bitops/find.h>
+#include <asm-generic/bitops/hweight.h>
 
 static __inline__ int ext2_set_bit(int nr, volatile void * addr)
 {
@@ -475,30 +291,11 @@ found_middle:
 	return result + ffz(__swab32(tmp));
 }
 
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
-
-/**
- * hweightN - returns the hamming weight of a N-bit word
- * @x: the word to weigh
- *
- * The Hamming Weight of a number is the total number of bits set in it.
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#include <asm-generic/bitops/minix.h>
 
 #endif /* __KERNEL__ */
 
-/*
- * fls: find last bit set.
- */
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/fls64.h>
 
 #endif /* _M68KNOMMU_BITOPS_H */
Index: 2.6-rc/arch/m68knommu/Kconfig
===================================================================
--- 2.6-rc.orig/arch/m68knommu/Kconfig
+++ 2.6-rc/arch/m68knommu/Kconfig
@@ -25,6 +25,14 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default n
 
+config GENERIC_FIND_NEXT_BIT
+	bool
+	default y
+
+config GENERIC_HWEIGHT
+	bool
+	default y
+
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y

--
