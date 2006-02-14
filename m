Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbWBNFQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbWBNFQM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWBNFNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:13:43 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:25807 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030379AbWBNFFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:06 -0500
Message-Id: <20060214050448.614652000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:27 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, sparclinux@vger.kernel.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 36/47] sparc: use generic bitops
Content-Disposition: inline; filename=sparc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- remove ffz()
- remove __ffs()
- remove sched_find_first_bit()
- remove ffs()
- remove generic_fls()
- remove generic_fls64()
- remove generic_hweight{32,16,8}()
- remove find_{next,first}{,_zero}_bit()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove ext2_{set,clear}_bit_atomic()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/sparc/Kconfig         |    8 
 include/asm-sparc/bitops.h |  388 +--------------------------------------------
 2 files changed, 20 insertions(+), 376 deletions(-)

Index: 2.6-rc/include/asm-sparc/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-sparc/bitops.h
+++ 2.6-rc/include/asm-sparc/bitops.h
@@ -152,386 +152,22 @@ static inline void change_bit(unsigned l
 	: "memory", "cc");
 }
 
-/*
- * non-atomic versions
- */
-static inline void __set_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = 1UL << (nr & 0x1f);
-	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
-
-	*p |= mask;
-}
-
-static inline void __clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = 1UL << (nr & 0x1f);
-	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
-
-	*p &= ~mask;
-}
-
-static inline void __change_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = 1UL << (nr & 0x1f);
-	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
-
-	*p ^= mask;
-}
-
-static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = 1UL << (nr & 0x1f);
-	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long old = *p;
-
-	*p = old | mask;
-	return (old & mask) != 0;
-}
-
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = 1UL << (nr & 0x1f);
-	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long old = *p;
-
-	*p = old & ~mask;
-	return (old & mask) != 0;
-}
-
-static inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = 1UL << (nr & 0x1f);
-	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long old = *p;
-
-	*p = old ^ mask;
-	return (old & mask) != 0;
-}
+#include <asm-generic/bitops/non-atomic.h>
 
 #define smp_mb__before_clear_bit()	do { } while(0)
 #define smp_mb__after_clear_bit()	do { } while(0)
 
-/* The following routine need not be atomic. */
-static inline int test_bit(int nr, __const__ volatile unsigned long *addr)
-{
-	return (1UL & (((unsigned long *)addr)[nr >> 5] >> (nr & 31))) != 0UL;
-}
-
-/* The easy/cheese version for now. */
-static inline unsigned long ffz(unsigned long word)
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
-/**
- * __ffs - find first bit in word.
- * @word: The word to search
- *
- * Undefined if no bit exists, so code should check against 0 first.
- */
-static inline int __ffs(unsigned long word)
-{
-	int num = 0;
-
-	if ((word & 0xffff) == 0) {
-		num += 16;
-		word >>= 16;
-	}
-	if ((word & 0xff) == 0) {
-		num += 8;
-		word >>= 8;
-	}
-	if ((word & 0xf) == 0) {
-		num += 4;
-		word >>= 4;
-	}
-	if ((word & 0x3) == 0) {
-		num += 2;
-		word >>= 2;
-	}
-	if ((word & 0x1) == 0)
-		num += 1;
-	return num;
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
-
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
- * ffs: find first bit set. This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-static inline int ffs(int x)
-{
-	if (!x)
-		return 0;
-	return __ffs((unsigned long)x) + 1;
-}
-
-/*
- * fls: find last (most-significant) bit set.
- * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
- */
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
-
-/*
- * find_next_zero_bit() finds the first zero bit in a bit string of length
- * 'size' bits, starting the search at bit 'offset'. This is largely based
- * on Linus's ALPHA routines, which are pretty portable BTW.
- */
-static inline unsigned long find_next_zero_bit(const unsigned long *addr,
-    unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr + (offset >> 5);
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
-	if (tmp == ~0UL)        /* Are any bits zero? */
-		return result + size; /* Nope. */
-found_middle:
-	return result + ffz(tmp);
-}
-
-/*
- * Linus sez that gcc can optimize the following correctly, we'll see if this
- * holds on the Sparc as it does for the ALPHA.
- */
-#define find_first_zero_bit(addr, size) \
-        find_next_zero_bit((addr), (size), 0)
-
-/**
- * find_next_bit - find the first set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- *
- * Scheduler induced bitop, do not use.
- */
-static inline int find_next_bit(const unsigned long *addr, int size, int offset)
-{
-	const unsigned long *p = addr + (offset >> 5);
-	int num = offset & ~0x1f;
-	unsigned long word;
-
-	word = *p++;
-	word &= ~((1 << (offset & 0x1f)) - 1);
-	while (num < size) {
-		if (word != 0) {
-			return __ffs(word) + num;
-		}
-		word = *p++;
-		num += 0x20;
-	}
-	return num;
-}
-
-/**
- * find_first_bit - find the first set bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit-number of the first set bit, not the number of the byte
- * containing a bit.
- */
-#define find_first_bit(addr, size) \
-	find_next_bit((addr), (size), 0)
-
-/*
- */
-static inline int test_le_bit(int nr, __const__ unsigned long * addr)
-{
-	__const__ unsigned char *ADDR = (__const__ unsigned char *) addr;
-	return (ADDR[nr >> 3] >> (nr & 7)) & 1;
-}
-
-/*
- * non-atomic versions
- */
-static inline void __set_le_bit(int nr, unsigned long *addr)
-{
-	unsigned char *ADDR = (unsigned char *)addr;
-
-	ADDR += nr >> 3;
-	*ADDR |= 1 << (nr & 0x07);
-}
-
-static inline void __clear_le_bit(int nr, unsigned long *addr)
-{
-	unsigned char *ADDR = (unsigned char *)addr;
-
-	ADDR += nr >> 3;
-	*ADDR &= ~(1 << (nr & 0x07));
-}
-
-static inline int __test_and_set_le_bit(int nr, unsigned long *addr)
-{
-	int mask, retval;
-	unsigned char *ADDR = (unsigned char *)addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR |= mask;
-	return retval;
-}
-
-static inline int __test_and_clear_le_bit(int nr, unsigned long *addr)
-{
-	int mask, retval;
-	unsigned char *ADDR = (unsigned char *)addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR &= ~mask;
-	return retval;
-}
-
-static inline unsigned long find_next_zero_le_bit(const unsigned long *addr,
-    unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if(offset) {
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
-	tmp = __swab32(tmp) | (~0UL << size);
-	if (tmp == ~0UL)        /* Are any bits zero? */
-		return result + size; /* Nope. */
-	return result + ffz(tmp);
-
-found_middle:
-	return result + ffz(__swab32(tmp));
-}
-
-#define find_first_zero_le_bit(addr, size) \
-        find_next_zero_le_bit((addr), (size), 0)
-
-#define ext2_set_bit(nr,addr)	\
-	__test_and_set_le_bit((nr),(unsigned long *)(addr))
-#define ext2_clear_bit(nr,addr)	\
-	__test_and_clear_le_bit((nr),(unsigned long *)(addr))
-
-#define ext2_set_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_set_bit((nr), (unsigned long *)(addr)); \
-		spin_unlock(lock);			\
-		ret;					\
-	})
-
-#define ext2_clear_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_clear_bit((nr), (unsigned long *)(addr)); \
-		spin_unlock(lock);			\
-		ret;					\
-	})
-
-#define ext2_test_bit(nr,addr)	\
-	test_le_bit((nr),(unsigned long *)(addr))
-#define ext2_find_first_zero_bit(addr, size) \
-	find_first_zero_le_bit((unsigned long *)(addr), (size))
-#define ext2_find_next_zero_bit(addr, size, off) \
-	find_next_zero_le_bit((unsigned long *)(addr), (size), (off))
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr)	\
-	__test_and_set_bit((nr),(unsigned long *)(addr))
-#define minix_set_bit(nr,addr)		\
-	__set_bit((nr),(unsigned long *)(addr))
-#define minix_test_and_clear_bit(nr,addr) \
-	__test_and_clear_bit((nr),(unsigned long *)(addr))
-#define minix_test_bit(nr,addr)		\
-	test_bit((nr),(unsigned long *)(addr))
-#define minix_find_first_zero_bit(addr,size) \
-	find_first_zero_bit((unsigned long *)(addr),(size))
+#include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/ffs.h>
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/find.h>
+#include <asm-generic/bitops/ext2-non-atomic.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+#include <asm-generic/bitops/minix.h>
 
 #endif /* __KERNEL__ */
 
Index: 2.6-rc/arch/sparc/Kconfig
===================================================================
--- 2.6-rc.orig/arch/sparc/Kconfig
+++ 2.6-rc/arch/sparc/Kconfig
@@ -151,6 +151,14 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
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
