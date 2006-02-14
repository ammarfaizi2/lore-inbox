Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbWBNFN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbWBNFN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWBNFNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:13:21 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:33487 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030386AbWBNFFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:07 -0500
Message-Id: <20060214050447.512369000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:21 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux-mips@linux-mips.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 30/47] mips: use generic bitops
Content-Disposition: inline; filename=mips.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()

- unless defined(CONFIG_CPU_MIPS32) or defined(CONFIG_CPU_MIPS64)

  - remove __ffs()
  - remove ffs()
  - remove ffz()
  - remove fls()

- remove fls64()
- remove find_{next,first}{,_zero}_bit()
- remove sched_find_first_bit()
- remove generic_hweight64()
- remove generic_hweight{32,16,8}()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove ext2_{set,clear}_bit_atomic()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/mips/Kconfig         |    8 
 include/asm-mips/bitops.h |  465 +---------------------------------------------
 2 files changed, 24 insertions(+), 449 deletions(-)

Index: 2.6-rc/include/asm-mips/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-mips/bitops.h
+++ 2.6-rc/include/asm-mips/bitops.h
@@ -105,22 +105,6 @@ static inline void set_bit(unsigned long
 }
 
 /*
- * __set_bit - Set a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * Unlike set_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static inline void __set_bit(unsigned long nr, volatile unsigned long * addr)
-{
-	unsigned long * m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-
-	*m |= 1UL << (nr & SZLONG_MASK);
-}
-
-/*
  * clear_bit - Clears a bit in memory
  * @nr: Bit to clear
  * @addr: Address to start counting from
@@ -169,22 +153,6 @@ static inline void clear_bit(unsigned lo
 }
 
 /*
- * __clear_bit - Clears a bit in memory
- * @nr: Bit to clear
- * @addr: Address to start counting from
- *
- * Unlike clear_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static inline void __clear_bit(unsigned long nr, volatile unsigned long * addr)
-{
-	unsigned long * m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-
-	*m &= ~(1UL << (nr & SZLONG_MASK));
-}
-
-/*
  * change_bit - Toggle a bit in memory
  * @nr: Bit to change
  * @addr: Address to start counting from
@@ -235,22 +203,6 @@ static inline void change_bit(unsigned l
 }
 
 /*
- * __change_bit - Toggle a bit in memory
- * @nr: the bit to change
- * @addr: the address to start counting from
- *
- * Unlike change_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static inline void __change_bit(unsigned long nr, volatile unsigned long * addr)
-{
-	unsigned long * m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-
-	*m ^= 1UL << (nr & SZLONG_MASK);
-}
-
-/*
  * test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
@@ -321,30 +273,6 @@ static inline int test_and_set_bit(unsig
 }
 
 /*
- * __test_and_set_bit - Set a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-static inline int __test_and_set_bit(unsigned long nr,
-	volatile unsigned long *addr)
-{
-	volatile unsigned long *a = addr;
-	unsigned long mask;
-	int retval;
-
-	a += nr >> SZLONG_LOG;
-	mask = 1UL << (nr & SZLONG_MASK);
-	retval = (mask & *a) != 0;
-	*a |= mask;
-
-	return retval;
-}
-
-/*
  * test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
  * @addr: Address to count from
@@ -417,30 +345,6 @@ static inline int test_and_clear_bit(uns
 }
 
 /*
- * __test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to clear
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-static inline int __test_and_clear_bit(unsigned long nr,
-	volatile unsigned long * addr)
-{
-	volatile unsigned long *a = addr;
-	unsigned long mask;
-	int retval;
-
-	a += (nr >> SZLONG_LOG);
-	mask = 1UL << (nr & SZLONG_MASK);
-	retval = ((mask & *a) != 0);
-	*a &= ~mask;
-
-	return retval;
-}
-
-/*
  * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
@@ -509,43 +413,11 @@ static inline int test_and_change_bit(un
 	}
 }
 
-/*
- * __test_and_change_bit - Change a bit and return its old value
- * @nr: Bit to change
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-static inline int __test_and_change_bit(unsigned long nr,
-	volatile unsigned long *addr)
-{
-	volatile unsigned long *a = addr;
-	unsigned long mask;
-	int retval;
-
-	a += (nr >> SZLONG_LOG);
-	mask = 1UL << (nr & SZLONG_MASK);
-	retval = ((mask & *a) != 0);
-	*a ^= mask;
-
-	return retval;
-}
-
 #undef __bi_flags
 #undef __bi_local_irq_save
 #undef __bi_local_irq_restore
 
-/*
- * test_bit - Determine whether a bit is set
- * @nr: bit number to test
- * @addr: Address to start counting from
- */
-static inline int test_bit(unsigned long nr, const volatile unsigned long *addr)
-{
-	return 1UL & (addr[nr >> SZLONG_LOG] >> (nr & SZLONG_MASK));
-}
+#include <asm-generic/bitops/non-atomic.h>
 
 /*
  * Return the bit position (0..63) of the most significant 1 bit in a word
@@ -580,6 +452,8 @@ static inline int __ilog2(unsigned long 
 	return 63 - lz;
 }
 
+#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
+
 /*
  * __ffs - find first bit in word.
  * @word: The word to search
@@ -589,31 +463,7 @@ static inline int __ilog2(unsigned long 
  */
 static inline unsigned long __ffs(unsigned long word)
 {
-#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
 	return __ilog2(word & -word);
-#else
-	int b = 0, s;
-
-#ifdef CONFIG_32BIT
-	s = 16; if (word << 16 != 0) s = 0; b += s; word >>= s;
-	s =  8; if (word << 24 != 0) s = 0; b += s; word >>= s;
-	s =  4; if (word << 28 != 0) s = 0; b += s; word >>= s;
-	s =  2; if (word << 30 != 0) s = 0; b += s; word >>= s;
-	s =  1; if (word << 31 != 0) s = 0; b += s;
-
-	return b;
-#endif
-#ifdef CONFIG_64BIT
-	s = 32; if (word << 32 != 0) s = 0; b += s; word >>= s;
-	s = 16; if (word << 48 != 0) s = 0; b += s; word >>= s;
-	s =  8; if (word << 56 != 0) s = 0; b += s; word >>= s;
-	s =  4; if (word << 60 != 0) s = 0; b += s; word >>= s;
-	s =  2; if (word << 62 != 0) s = 0; b += s; word >>= s;
-	s =  1; if (word << 63 != 0) s = 0; b += s;
-
-	return b;
-#endif
-#endif
 }
 
 /*
@@ -652,321 +502,38 @@ static inline unsigned long ffz(unsigned
  */
 static inline unsigned long fls(unsigned long word)
 {
-#ifdef CONFIG_32BIT
 #ifdef CONFIG_CPU_MIPS32
 	__asm__ ("clz %0, %1" : "=r" (word) : "r" (word));
 
 	return 32 - word;
-#else
-	{
-	int r = 32, s;
-
-	if (word == 0)
-		return 0;
-
-	s = 16; if ((word & 0xffff0000)) s = 0; r -= s; word <<= s;
-	s = 8;  if ((word & 0xff000000)) s = 0; r -= s; word <<= s;
-	s = 4;  if ((word & 0xf0000000)) s = 0; r -= s; word <<= s;
-	s = 2;  if ((word & 0xc0000000)) s = 0; r -= s; word <<= s;
-	s = 1;  if ((word & 0x80000000)) s = 0; r -= s;
-
-	return r;
-	}
 #endif
-#endif /* CONFIG_32BIT */
 
-#ifdef CONFIG_64BIT
 #ifdef CONFIG_CPU_MIPS64
-
 	__asm__ ("dclz %0, %1" : "=r" (word) : "r" (word));
 
 	return 64 - word;
-#else
-	{
-	int r = 64, s;
-
-	if (word == 0)
-		return 0;
-
-	s = 32; if ((word & 0xffffffff00000000UL)) s = 0; r -= s; word <<= s;
-	s = 16; if ((word & 0xffff000000000000UL)) s = 0; r -= s; word <<= s;
-	s = 8;  if ((word & 0xff00000000000000UL)) s = 0; r -= s; word <<= s;
-	s = 4;  if ((word & 0xf000000000000000UL)) s = 0; r -= s; word <<= s;
-	s = 2;  if ((word & 0xc000000000000000UL)) s = 0; r -= s; word <<= s;
-	s = 1;  if ((word & 0x8000000000000000UL)) s = 0; r -= s;
-
-	return r;
-	}
 #endif
-#endif /* CONFIG_64BIT */
 }
 
-#define fls64(x)   generic_fls64(x)
-
-/*
- * find_next_zero_bit - find the first zero bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-static inline unsigned long find_next_zero_bit(const unsigned long *addr,
-	unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr + (offset >> SZLONG_LOG);
-	unsigned long result = offset & ~SZLONG_MASK;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= SZLONG_MASK;
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (_MIPS_SZLONG-offset);
-		if (size < _MIPS_SZLONG)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= _MIPS_SZLONG;
-		result += _MIPS_SZLONG;
-	}
-	while (size & ~SZLONG_MASK) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += _MIPS_SZLONG;
-		size -= _MIPS_SZLONG;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp |= ~0UL << size;
-	if (tmp == ~0UL)		/* Are any bits zero? */
-		return result + size;	/* Nope. */
-found_middle:
-	return result + ffz(tmp);
-}
+#else
 
-#define find_first_zero_bit(addr, size) \
-	find_next_zero_bit((addr), (size), 0)
+#include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/ffs.h>
+#include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/fls.h>
 
-/*
- * find_next_bit - find the next set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-static inline unsigned long find_next_bit(const unsigned long *addr,
-	unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr + (offset >> SZLONG_LOG);
-	unsigned long result = offset & ~SZLONG_MASK;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= SZLONG_MASK;
-	if (offset) {
-		tmp = *(p++);
-		tmp &= ~0UL << offset;
-		if (size < _MIPS_SZLONG)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= _MIPS_SZLONG;
-		result += _MIPS_SZLONG;
-	}
-	while (size & ~SZLONG_MASK) {
-		if ((tmp = *(p++)))
-			goto found_middle;
-		result += _MIPS_SZLONG;
-		size -= _MIPS_SZLONG;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp &= ~0UL >> (_MIPS_SZLONG - size);
-	if (tmp == 0UL)			/* Are any bits set? */
-		return result + size;	/* Nope. */
-found_middle:
-	return result + __ffs(tmp);
-}
+#endif /*defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64) */
 
-/*
- * find_first_bit - find the first set bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit-number of the first set bit, not the number of the byte
- * containing a bit.
- */
-#define find_first_bit(addr, size) \
-	find_next_bit((addr), (size), 0)
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/find.h>
 
 #ifdef __KERNEL__
 
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-#ifdef CONFIG_32BIT
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-#endif
-#ifdef CONFIG_64BIT
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 64;
-	return __ffs(b[2]) + 128;
-#endif
-}
-
-/*
- * hweightN - returns the hamming weight of a N-bit word
- * @x: the word to weigh
- *
- * The Hamming Weight of a number is the total number of bits set in it.
- */
-
-#define hweight64(x)	generic_hweight64(x)
-#define hweight32(x)	generic_hweight32(x)
-#define hweight16(x)	generic_hweight16(x)
-#define hweight8(x)	generic_hweight8(x)
-
-static inline int __test_and_set_le_bit(unsigned long nr, unsigned long *addr)
-{
-	unsigned char	*ADDR = (unsigned char *) addr;
-	int		mask, retval;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR |= mask;
-
-	return retval;
-}
-
-static inline int __test_and_clear_le_bit(unsigned long nr, unsigned long *addr)
-{
-	unsigned char	*ADDR = (unsigned char *) addr;
-	int		mask, retval;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR &= ~mask;
-
-	return retval;
-}
-
-static inline int test_le_bit(unsigned long nr, const unsigned long * addr)
-{
-	const unsigned char	*ADDR = (const unsigned char *) addr;
-	int			mask;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-
-	return ((mask & *ADDR) != 0);
-}
-
-static inline unsigned long find_next_zero_le_bit(unsigned long *addr,
-	unsigned long size, unsigned long offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> SZLONG_LOG);
-	unsigned long result = offset & ~SZLONG_MASK;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= SZLONG_MASK;
-	if (offset) {
-		tmp = cpu_to_lelongp(p++);
-		tmp |= ~0UL >> (_MIPS_SZLONG-offset); /* bug or feature ? */
-		if (size < _MIPS_SZLONG)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= _MIPS_SZLONG;
-		result += _MIPS_SZLONG;
-	}
-	while (size & ~SZLONG_MASK) {
-		if (~(tmp = cpu_to_lelongp(p++)))
-			goto found_middle;
-		result += _MIPS_SZLONG;
-		size -= _MIPS_SZLONG;
-	}
-	if (!size)
-		return result;
-	tmp = cpu_to_lelongp(p);
-
-found_first:
-	tmp |= ~0UL << size;
-	if (tmp == ~0UL)		/* Are any bits zero? */
-		return result + size;	/* Nope. */
-
-found_middle:
-	return result + ffz(tmp);
-}
-
-#define find_first_zero_le_bit(addr, size) \
-	find_next_zero_le_bit((addr), (size), 0)
-
-#define ext2_set_bit(nr,addr) \
-	__test_and_set_le_bit((nr),(unsigned long*)addr)
-#define ext2_clear_bit(nr, addr) \
-	__test_and_clear_le_bit((nr),(unsigned long*)addr)
- #define ext2_set_bit_atomic(lock, nr, addr)		\
-({							\
-	int ret;					\
-	spin_lock(lock);				\
-	ret = ext2_set_bit((nr), (addr));		\
-	spin_unlock(lock);				\
-	ret;						\
-})
-
-#define ext2_clear_bit_atomic(lock, nr, addr)		\
-({							\
-	int ret;					\
-	spin_lock(lock);				\
-	ret = ext2_clear_bit((nr), (addr));		\
-	spin_unlock(lock);				\
-	ret;						\
-})
-#define ext2_test_bit(nr, addr)	test_le_bit((nr),(unsigned long*)addr)
-#define ext2_find_first_zero_bit(addr, size) \
-	find_first_zero_le_bit((unsigned long*)addr, size)
-#define ext2_find_next_zero_bit(addr, size, off) \
-	find_next_zero_le_bit((unsigned long*)addr, size, off)
-
-/*
- * Bitmap functions for the minix filesystem.
- *
- * FIXME: These assume that Minix uses the native byte/bitorder.
- * This limits the Minix filesystem's value for data exchange very much.
- */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/ext2-non-atomic.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+#include <asm-generic/bitops/minix.h>
 
 #endif /* __KERNEL__ */
 
Index: 2.6-rc/arch/mips/Kconfig
===================================================================
--- 2.6-rc.orig/arch/mips/Kconfig
+++ 2.6-rc/arch/mips/Kconfig
@@ -800,6 +800,14 @@ config RWSEM_GENERIC_SPINLOCK
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
