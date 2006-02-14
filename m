Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWBNFJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWBNFJA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbWBNFIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:08:40 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:39887 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030390AbWBNFFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:10 -0500
Message-Id: <20060214050447.703313000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:22 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, parisc-linux@parisc-linux.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 31/47] parisc: use generic bitops
Content-Disposition: inline; filename=parisc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- remove ffz()
- remove generic_fls64()
- remove generic_hweight{32,16,8}()
- remove generic_hweight64()
- remove sched_find_first_bit()
- remove find_{next,first}{,_zero}_bit()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/parisc/Kconfig         |    8 +
 include/asm-parisc/bitops.h |  286 +-------------------------------------------
 2 files changed, 17 insertions(+), 277 deletions(-)

Index: 2.6-rc/include/asm-parisc/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-parisc/bitops.h
+++ 2.6-rc/include/asm-parisc/bitops.h
@@ -35,13 +35,6 @@ static __inline__ void set_bit(int nr, v
 	_atomic_spin_unlock_irqrestore(addr, flags);
 }
 
-static __inline__ void __set_bit(unsigned long nr, volatile unsigned long * addr)
-{
-	unsigned long *m = (unsigned long *) addr + (nr >> SHIFT_PER_LONG);
-
-	*m |= 1UL << CHOP_SHIFTCOUNT(nr);
-}
-
 static __inline__ void clear_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = ~(1UL << CHOP_SHIFTCOUNT(nr));
@@ -53,13 +46,6 @@ static __inline__ void clear_bit(int nr,
 	_atomic_spin_unlock_irqrestore(addr, flags);
 }
 
-static __inline__ void __clear_bit(unsigned long nr, volatile unsigned long * addr)
-{
-	unsigned long *m = (unsigned long *) addr + (nr >> SHIFT_PER_LONG);
-
-	*m &= ~(1UL << CHOP_SHIFTCOUNT(nr));
-}
-
 static __inline__ void change_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
@@ -71,13 +57,6 @@ static __inline__ void change_bit(int nr
 	_atomic_spin_unlock_irqrestore(addr, flags);
 }
 
-static __inline__ void __change_bit(unsigned long nr, volatile unsigned long * addr)
-{
-	unsigned long *m = (unsigned long *) addr + (nr >> SHIFT_PER_LONG);
-
-	*m ^= 1UL << CHOP_SHIFTCOUNT(nr);
-}
-
 static __inline__ int test_and_set_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
@@ -93,18 +72,6 @@ static __inline__ int test_and_set_bit(i
 	return (oldbit & mask) ? 1 : 0;
 }
 
-static __inline__ int __test_and_set_bit(int nr, volatile unsigned long * address)
-{
-	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
-	unsigned long oldbit;
-	unsigned long *addr = (unsigned long *)address + (nr >> SHIFT_PER_LONG);
-
-	oldbit = *addr;
-	*addr = oldbit | mask;
-
-	return (oldbit & mask) ? 1 : 0;
-}
-
 static __inline__ int test_and_clear_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
@@ -120,18 +87,6 @@ static __inline__ int test_and_clear_bit
 	return (oldbit & mask) ? 1 : 0;
 }
 
-static __inline__ int __test_and_clear_bit(int nr, volatile unsigned long * address)
-{
-	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
-	unsigned long *addr = (unsigned long *)address + (nr >> SHIFT_PER_LONG);
-	unsigned long oldbit;
-
-	oldbit = *addr;
-	*addr = oldbit & ~mask;
-
-	return (oldbit & mask) ? 1 : 0;
-}
-
 static __inline__ int test_and_change_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
@@ -147,25 +102,7 @@ static __inline__ int test_and_change_bi
 	return (oldbit & mask) ? 1 : 0;
 }
 
-static __inline__ int __test_and_change_bit(int nr, volatile unsigned long * address)
-{
-	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
-	unsigned long *addr = (unsigned long *)address + (nr >> SHIFT_PER_LONG);
-	unsigned long oldbit;
-
-	oldbit = *addr;
-	*addr = oldbit ^ mask;
-
-	return (oldbit & mask) ? 1 : 0;
-}
-
-static __inline__ int test_bit(int nr, const volatile unsigned long *address)
-{
-	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
-	const unsigned long *addr = (const unsigned long *)address + (nr >> SHIFT_PER_LONG);
-	
-	return !!(*addr & mask);
-}
+#include <asm-generic/bitops/non-atomic.h>
 
 #ifdef __KERNEL__
 
@@ -219,8 +156,7 @@ static __inline__ unsigned long __ffs(un
 	return ret;
 }
 
-/* Undefined if no bit is zero. */
-#define ffz(x)	__ffs(~(x))
+#include <asm-generic/bitops/ffz.h>
 
 /*
  * ffs: find first bit set. returns 1 to BITS_PER_LONG or 0 (if none set)
@@ -263,155 +199,22 @@ static __inline__ int fls(int x)
 
 	return ret;
 }
-#define fls64(x)   generic_fls64(x)
 
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-#define hweight64(x) generic_hweight64(x)
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
-
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-#ifdef __LP64__
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 64;
-	return __ffs(b[2]) + 128;
-#else
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
-}
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/sched.h>
 
 #endif /* __KERNEL__ */
 
-/*
- * This implementation of find_{first,next}_zero_bit was stolen from
- * Linus' asm-alpha/bitops.h.
- */
-#define find_first_zero_bit(addr, size) \
-	find_next_zero_bit((addr), (size), 0)
-
-static __inline__ unsigned long find_next_zero_bit(const void * addr, unsigned long size, unsigned long offset)
-{
-	const unsigned long * p = ((unsigned long *) addr) + (offset >> SHIFT_PER_LONG);
-	unsigned long result = offset & ~(BITS_PER_LONG-1);
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= (BITS_PER_LONG-1);
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (BITS_PER_LONG-offset);
-		if (size < BITS_PER_LONG)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= BITS_PER_LONG;
-		result += BITS_PER_LONG;
-	}
-	while (size & ~(BITS_PER_LONG -1)) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += BITS_PER_LONG;
-		size -= BITS_PER_LONG;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-found_first:
-	tmp |= ~0UL << size;
-found_middle:
-	return result + ffz(tmp);
-}
-
-static __inline__ unsigned long find_next_bit(const unsigned long *addr, unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr + (offset >> SHIFT_PER_LONG);
-	unsigned long result = offset & ~(BITS_PER_LONG-1);
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= (BITS_PER_LONG-1);
-	if (offset) {
-		tmp = *(p++);
-		tmp &= (~0UL << offset);
-		if (size < BITS_PER_LONG)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= BITS_PER_LONG;
-		result += BITS_PER_LONG;
-	}
-	while (size & ~(BITS_PER_LONG-1)) {
-		if ((tmp = *(p++)))
-			goto found_middle;
-		result += BITS_PER_LONG;
-		size -= BITS_PER_LONG;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp &= (~0UL >> (BITS_PER_LONG - size));
-	if (tmp == 0UL)        /* Are any bits set? */
-		return result + size; /* Nope. */
-found_middle:
-	return result + __ffs(tmp);
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
-        find_next_bit((addr), (size), 0)
-
-#define _EXT2_HAVE_ASM_BITOPS_
+#include <asm-generic/bitops/find.h>
 
 #ifdef __KERNEL__
-/*
- * test_and_{set,clear}_bit guarantee atomicity without
- * disabling interrupts.
- */
+
+#include <asm-generic/bitops/ext2-non-atomic.h>
 
 /* '3' is bits per byte */
 #define LE_BYTE_ADDR ((sizeof(unsigned long) - 1) << 3)
 
-#define ext2_test_bit(nr, addr) \
-			test_bit((nr)	^ LE_BYTE_ADDR, (unsigned long *)addr)
-#define ext2_set_bit(nr, addr)	\
-		__test_and_set_bit((nr) ^ LE_BYTE_ADDR, (unsigned long *)addr)
-#define ext2_clear_bit(nr, addr) \
-		__test_and_clear_bit((nr) ^ LE_BYTE_ADDR, (unsigned long *)addr)
-
 #define ext2_set_bit_atomic(l,nr,addr) \
 		test_and_set_bit((nr)   ^ LE_BYTE_ADDR, (unsigned long *)addr)
 #define ext2_clear_bit_atomic(l,nr,addr) \
@@ -419,77 +222,6 @@ found_middle:
 
 #endif	/* __KERNEL__ */
 
-
-#define ext2_find_first_zero_bit(addr, size) \
-	ext2_find_next_zero_bit((addr), (size), 0)
-
-/* include/linux/byteorder does not support "unsigned long" type */
-static inline unsigned long ext2_swabp(unsigned long * x)
-{
-#ifdef __LP64__
-	return (unsigned long) __swab64p((u64 *) x);
-#else
-	return (unsigned long) __swab32p((u32 *) x);
-#endif
-}
-
-/* include/linux/byteorder doesn't support "unsigned long" type */
-static inline unsigned long ext2_swab(unsigned long y)
-{
-#ifdef __LP64__
-	return (unsigned long) __swab64((u64) y);
-#else
-	return (unsigned long) __swab32((u32) y);
-#endif
-}
-
-static __inline__ unsigned long ext2_find_next_zero_bit(void *addr, unsigned long size, unsigned long offset)
-{
-	unsigned long *p = (unsigned long *) addr + (offset >> SHIFT_PER_LONG);
-	unsigned long result = offset & ~(BITS_PER_LONG - 1);
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= (BITS_PER_LONG - 1UL);
-	if (offset) {
-		tmp = ext2_swabp(p++);
-		tmp |= (~0UL >> (BITS_PER_LONG - offset));
-		if (size < BITS_PER_LONG)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= BITS_PER_LONG;
-		result += BITS_PER_LONG;
-	}
-
-	while (size & ~(BITS_PER_LONG - 1)) {
-		if (~(tmp = *(p++)))
-			goto found_middle_swap;
-		result += BITS_PER_LONG;
-		size -= BITS_PER_LONG;
-	}
-	if (!size)
-		return result;
-	tmp = ext2_swabp(p);
-found_first:
-	tmp |= ~0UL << size;
-	if (tmp == ~0UL)	/* Are any bits zero? */
-		return result + size; /* Nope. Skip ffz */
-found_middle:
-	return result + ffz(tmp);
-
-found_middle_swap:
-	return result + ffz(ext2_swab(tmp));
-}
-
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) ext2_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) ((void)ext2_set_bit(nr,addr))
-#define minix_test_and_clear_bit(nr,addr) ext2_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) ext2_test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) ext2_find_first_zero_bit(addr,size)
+#include <asm-generic/bitops/minix-le.h>
 
 #endif /* _PARISC_BITOPS_H */
Index: 2.6-rc/arch/parisc/Kconfig
===================================================================
--- 2.6-rc.orig/arch/parisc/Kconfig
+++ 2.6-rc/arch/parisc/Kconfig
@@ -25,6 +25,14 @@ config RWSEM_GENERIC_SPINLOCK
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
