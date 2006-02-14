Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbWBNFNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbWBNFNy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWBNFNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:13:48 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:23247 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030376AbWBNFFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:05 -0500
Message-Id: <20060214050446.161072000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:14 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, David Howells <dhowells@redhat.com>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 23/47] frv: use generic bitops
Content-Disposition: inline; filename=frv.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove ffz()
- remove find_{next,first}{,_zero}_bit()
- remove generic_ffs()
- remove __ffs()
- remove generic_fls64()
- remove sched_find_first_bit()
- remove generic_hweight{32,16,8}()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/frv/Kconfig         |    4 +
 include/asm-frv/bitops.h |  170 ++---------------------------------------------
 2 files changed, 13 insertions(+), 161 deletions(-)

Index: 2.6-rc/include/asm-frv/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-frv/bitops.h
+++ 2.6-rc/include/asm-frv/bitops.h
@@ -22,20 +22,7 @@
 
 #ifdef __KERNEL__
 
-/*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
- */
-static inline unsigned long ffz(unsigned long word)
-{
-	unsigned long result = 0;
-
-	while (word & 1) {
-		result++;
-		word >>= 1;
-	}
-	return result;
-}
+#include <asm-generic/bitops/ffz.h>
 
 /*
  * clear_bit() doesn't provide any barrier for the compiler.
@@ -171,51 +158,9 @@ static inline int __test_bit(int nr, con
  __constant_test_bit((nr),(addr)) : \
  __test_bit((nr),(addr)))
 
-extern int find_next_bit(const unsigned long *addr, int size, int offset);
-
-#define find_first_bit(addr, size) find_next_bit(addr, size, 0)
-
-#define find_first_zero_bit(addr, size) \
-        find_next_zero_bit((addr), (size), 0)
-
-static inline int find_next_zero_bit(const void *addr, int size, int offset)
-{
-	const unsigned long *p = ((const unsigned long *) addr) + (offset >> 5);
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
-#define ffs(x) generic_ffs(x)
-#define __ffs(x) (ffs(x) - 1)
+#include <asm-generic/bitops/ffs.h>
+#include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/find.h>
 
 /*
  * fls: find last bit set.
@@ -228,114 +173,17 @@ found_middle:
 							\
 	bit ? 33 - bit : bit;				\
 })
-#define fls64(x)   generic_fls64(x)
 
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(const unsigned long *b)
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
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/hweight.h>
 
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
-#define ext2_set_bit(nr, addr)		__test_and_set_bit  ((nr) ^ 0x18, (addr))
-#define ext2_clear_bit(nr, addr)	__test_and_clear_bit((nr) ^ 0x18, (addr))
+#include <asm-generic/bitops/ext2-non-atomic.h>
 
 #define ext2_set_bit_atomic(lock,nr,addr)	test_and_set_bit  ((nr) ^ 0x18, (addr))
 #define ext2_clear_bit_atomic(lock,nr,addr)	test_and_clear_bit((nr) ^ 0x18, (addr))
 
-static inline int ext2_test_bit(int nr, const volatile void * addr)
-{
-	const volatile unsigned char *ADDR = (const unsigned char *) addr;
-	int mask;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	return ((mask & *ADDR) != 0);
-}
-
-#define ext2_find_first_zero_bit(addr, size) \
-        ext2_find_next_zero_bit((addr), (size), 0)
-
-static inline unsigned long ext2_find_next_zero_bit(const void *addr,
-						    unsigned long size,
-						    unsigned long offset)
-{
-	const unsigned long *p = ((const unsigned long *) addr) + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if(offset) {
-		/* We hold the little endian value in tmp, but then the
-		 * shift is illegal. So we could keep a big endian value
-		 * in tmp, like this:
-		 *
-		 * tmp = __swab32(*(p++));
-		 * tmp |= ~0UL >> (32-offset);
-		 *
-		 * but this would decrease preformance, so we change the
-		 * shift:
-		 */
-		tmp = *(p++);
-		tmp |= __swab32(~0UL >> (32-offset));
-		if(size < 32)
-			goto found_first;
-		if(~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while(size & ~31UL) {
-		if(~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if(!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	/* tmp is little endian, so we would have to swab the shift,
-	 * see above. But then we have to swab tmp below for ffz, so
-	 * we might as well do this here.
-	 */
-	return result + ffz(__swab32(tmp) | (~0UL << size));
-found_middle:
-	return result + ffz(__swab32(tmp));
-}
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr)		__test_and_set_bit  ((nr) ^ 0x18, (addr))
-#define minix_set_bit(nr,addr)			__set_bit((nr) ^ 0x18, (addr))
-#define minix_test_and_clear_bit(nr,addr)	__test_and_clear_bit((nr) ^ 0x18, (addr))
-#define minix_test_bit(nr,addr)			ext2_test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size)	ext2_find_first_zero_bit(addr,size)
+#include <asm-generic/bitops/minix-le.h>
 
 #endif /* __KERNEL__ */
 
Index: 2.6-rc/arch/frv/Kconfig
===================================================================
--- 2.6-rc.orig/arch/frv/Kconfig
+++ 2.6-rc/arch/frv/Kconfig
@@ -17,6 +17,10 @@ config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
 
+config GENERIC_HWEIGHT
+	bool
+	default y
+
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default n

--
