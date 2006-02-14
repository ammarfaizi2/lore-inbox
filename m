Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWBNFPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWBNFPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbWBNFNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:13:45 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:23503 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030377AbWBNFFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:05 -0500
Message-Id: <20060214050448.800881000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:28 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ultralinux@vger.kernel.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 37/47] sparc64: use generic bitops
Content-Disposition: inline; filename=sparc64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- remove ffz()
- remove __ffs()
- remove generic_fls()
- remove generic_fls64()
- remove sched_find_first_bit()
- remove ffs()

- unless defined(ULTRA_HAS_POPULATION_COUNT)

  - remove generic_hweight{64,32,16,8}()

- remove find_{next,first}{,_zero}_bit()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/sparc64/Kconfig                |    8 +
 arch/sparc64/kernel/sparc64_ksyms.c |    5 
 arch/sparc64/lib/Makefile           |    2 
 arch/sparc64/lib/find_bit.c         |  127 --------------------
 include/asm-sparc64/bitops.h        |  221 ++----------------------------------
 5 files changed, 23 insertions(+), 340 deletions(-)

Index: 2.6-rc/include/asm-sparc64/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-sparc64/bitops.h
+++ 2.6-rc/include/asm-sparc64/bitops.h
@@ -18,58 +18,7 @@ extern void set_bit(unsigned long nr, vo
 extern void clear_bit(unsigned long nr, volatile unsigned long *addr);
 extern void change_bit(unsigned long nr, volatile unsigned long *addr);
 
-/* "non-atomic" versions... */
-
-static inline void __set_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long *m = ((unsigned long *)addr) + (nr >> 6);
-
-	*m |= (1UL << (nr & 63));
-}
-
-static inline void __clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long *m = ((unsigned long *)addr) + (nr >> 6);
-
-	*m &= ~(1UL << (nr & 63));
-}
-
-static inline void __change_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long *m = ((unsigned long *)addr) + (nr >> 6);
-
-	*m ^= (1UL << (nr & 63));
-}
-
-static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long *m = ((unsigned long *)addr) + (nr >> 6);
-	unsigned long old = *m;
-	unsigned long mask = (1UL << (nr & 63));
-
-	*m = (old | mask);
-	return ((old & mask) != 0);
-}
-
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long *m = ((unsigned long *)addr) + (nr >> 6);
-	unsigned long old = *m;
-	unsigned long mask = (1UL << (nr & 63));
-
-	*m = (old & ~mask);
-	return ((old & mask) != 0);
-}
-
-static inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long *m = ((unsigned long *)addr) + (nr >> 6);
-	unsigned long old = *m;
-	unsigned long mask = (1UL << (nr & 63));
-
-	*m = (old ^ mask);
-	return ((old & mask) != 0);
-}
+#include <asm-generic/bitops/non-atomic.h>
 
 #ifdef CONFIG_SMP
 #define smp_mb__before_clear_bit()	membar_storeload_loadload()
@@ -79,78 +28,15 @@ static inline int __test_and_change_bit(
 #define smp_mb__after_clear_bit()	barrier()
 #endif
 
-static inline int test_bit(int nr, __const__ volatile unsigned long *addr)
-{
-	return (1UL & (addr[nr >> 6] >> (nr & 63))) != 0UL;
-}
-
-/* The easy/cheese version for now. */
-static inline unsigned long ffz(unsigned long word)
-{
-	unsigned long result;
-
-	result = 0;
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
-static inline unsigned long __ffs(unsigned long word)
-{
-	unsigned long result = 0;
-
-	while (!(word & 1UL)) {
-		result++;
-		word >>= 1;
-	}
-	return result;
-}
-
-/*
- * fls: find last bit set.
- */
-
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
+#include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/fls64.h>
 
 #ifdef __KERNEL__
 
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
-	if (unlikely(((unsigned int)b[1])))
-		return __ffs(b[1]) + 64;
-	if (b[1] >> 32)
-		return __ffs(b[1] >> 32) + 96;
-	return __ffs(b[2]) + 128;
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
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/ffs.h>
 
 /*
  * hweightN: returns the hamming weight (i.e. the number
@@ -193,102 +79,23 @@ static inline unsigned int hweight8(unsi
 
 #else
 
-#define hweight64(x) generic_hweight64(x)
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#include <asm-generic/bitops/hweight.h>
 
 #endif
 #endif /* __KERNEL__ */
 
-/**
- * find_next_bit - find the next set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-extern unsigned long find_next_bit(const unsigned long *, unsigned long,
-					unsigned long);
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
-/* find_next_zero_bit() finds the first zero bit in a bit string of length
- * 'size' bits, starting the search at bit 'offset'. This is largely based
- * on Linus's ALPHA routines, which are pretty portable BTW.
- */
-
-extern unsigned long find_next_zero_bit(const unsigned long *,
-					unsigned long, unsigned long);
-
-#define find_first_zero_bit(addr, size) \
-        find_next_zero_bit((addr), (size), 0)
-
-#define test_and_set_le_bit(nr,addr)	\
-	test_and_set_bit((nr) ^ 0x38, (addr))
-#define test_and_clear_le_bit(nr,addr)	\
-	test_and_clear_bit((nr) ^ 0x38, (addr))
-
-static inline int test_le_bit(int nr, __const__ unsigned long * addr)
-{
-	int			mask;
-	__const__ unsigned char	*ADDR = (__const__ unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	return ((mask & *ADDR) != 0);
-}
-
-#define find_first_zero_le_bit(addr, size) \
-        find_next_zero_le_bit((addr), (size), 0)
-
-extern unsigned long find_next_zero_le_bit(unsigned long *, unsigned long, unsigned long);
+#include <asm-generic/bitops/find.h>
 
 #ifdef __KERNEL__
 
-#define __set_le_bit(nr, addr) \
-	__set_bit((nr) ^ 0x38, (addr))
-#define __clear_le_bit(nr, addr) \
-	__clear_bit((nr) ^ 0x38, (addr))
-#define __test_and_clear_le_bit(nr, addr) \
-	__test_and_clear_bit((nr) ^ 0x38, (addr))
-#define __test_and_set_le_bit(nr, addr) \
-	__test_and_set_bit((nr) ^ 0x38, (addr))
+#include <asm-generic/bitops/ext2-non-atomic.h>
 
-#define ext2_set_bit(nr,addr)	\
-	__test_and_set_le_bit((nr),(unsigned long *)(addr))
 #define ext2_set_bit_atomic(lock,nr,addr) \
-	test_and_set_le_bit((nr),(unsigned long *)(addr))
-#define ext2_clear_bit(nr,addr)	\
-	__test_and_clear_le_bit((nr),(unsigned long *)(addr))
+	test_and_set_bit((nr) ^ 0x38,(unsigned long *)(addr))
 #define ext2_clear_bit_atomic(lock,nr,addr) \
-	test_and_clear_le_bit((nr),(unsigned long *)(addr))
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
-#define minix_set_bit(nr,addr)	\
-	__set_bit((nr),(unsigned long *)(addr))
-#define minix_test_and_clear_bit(nr,addr) \
-	__test_and_clear_bit((nr),(unsigned long *)(addr))
-#define minix_test_bit(nr,addr)	\
-	test_bit((nr),(unsigned long *)(addr))
-#define minix_find_first_zero_bit(addr,size) \
-	find_first_zero_bit((unsigned long *)(addr),(size))
+	test_and_clear_bit((nr) ^ 0x38,(unsigned long *)(addr))
+
+#include <asm-generic/bitops/minix.h>
 
 #endif /* __KERNEL__ */
 
Index: 2.6-rc/arch/sparc64/kernel/sparc64_ksyms.c
===================================================================
--- 2.6-rc.orig/arch/sparc64/kernel/sparc64_ksyms.c
+++ 2.6-rc/arch/sparc64/kernel/sparc64_ksyms.c
@@ -170,11 +170,6 @@ EXPORT_SYMBOL(set_bit);
 EXPORT_SYMBOL(clear_bit);
 EXPORT_SYMBOL(change_bit);
 
-/* Bit searching */
-EXPORT_SYMBOL(find_next_bit);
-EXPORT_SYMBOL(find_next_zero_bit);
-EXPORT_SYMBOL(find_next_zero_le_bit);
-
 EXPORT_SYMBOL(ivector_table);
 EXPORT_SYMBOL(enable_irq);
 EXPORT_SYMBOL(disable_irq);
Index: 2.6-rc/arch/sparc64/lib/Makefile
===================================================================
--- 2.6-rc.orig/arch/sparc64/lib/Makefile
+++ 2.6-rc/arch/sparc64/lib/Makefile
@@ -12,6 +12,6 @@ lib-y := PeeCeeI.o copy_page.o clear_pag
 	 U1memcpy.o U1copy_from_user.o U1copy_to_user.o \
 	 U3memcpy.o U3copy_from_user.o U3copy_to_user.o U3patch.o \
 	 copy_in_user.o user_fixup.o memmove.o \
-	 mcount.o ipcsum.o rwsem.o xor.o find_bit.o delay.o
+	 mcount.o ipcsum.o rwsem.o xor.o delay.o
 
 obj-y += iomap.o
Index: 2.6-rc/arch/sparc64/lib/find_bit.c
===================================================================
--- 2.6-rc.orig/arch/sparc64/lib/find_bit.c
+++ /dev/null
@@ -1,127 +0,0 @@
-#include <linux/bitops.h>
-
-/**
- * find_next_bit - find the next set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
-				unsigned long offset)
-{
-	const unsigned long *p = addr + (offset >> 6);
-	unsigned long result = offset & ~63UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 63UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp &= (~0UL << offset);
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
-
-found_first:
-	tmp &= (~0UL >> (64 - size));
-	if (tmp == 0UL)        /* Are any bits set? */
-		return result + size; /* Nope. */
-found_middle:
-	return result + __ffs(tmp);
-}
-
-/* find_next_zero_bit() finds the first zero bit in a bit string of length
- * 'size' bits, starting the search at bit 'offset'. This is largely based
- * on Linus's ALPHA routines, which are pretty portable BTW.
- */
-
-unsigned long find_next_zero_bit(const unsigned long *addr,
-			unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr + (offset >> 6);
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
-
-found_first:
-	tmp |= ~0UL << size;
-	if (tmp == ~0UL)        /* Are any bits zero? */
-		return result + size; /* Nope. */
-found_middle:
-	return result + ffz(tmp);
-}
-
-unsigned long find_next_zero_le_bit(unsigned long *addr, unsigned long size, unsigned long offset)
-{
-	unsigned long *p = addr + (offset >> 6);
-	unsigned long result = offset & ~63UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 63UL;
-	if(offset) {
-		tmp = __swab64p(p++);
-		tmp |= (~0UL >> (64-offset));
-		if(size < 64)
-			goto found_first;
-		if(~tmp)
-			goto found_middle;
-		size -= 64;
-		result += 64;
-	}
-	while(size & ~63) {
-		if(~(tmp = __swab64p(p++)))
-			goto found_middle;
-		result += 64;
-		size -= 64;
-	}
-	if(!size)
-		return result;
-	tmp = __swab64p(p);
-found_first:
-	tmp |= (~0UL << size);
-	if (tmp == ~0UL)        /* Are any bits zero? */
-		return result + size; /* Nope. */
-found_middle:
-	return result + ffz(tmp);
-}
Index: 2.6-rc/arch/sparc64/Kconfig
===================================================================
--- 2.6-rc.orig/arch/sparc64/Kconfig
+++ 2.6-rc/arch/sparc64/Kconfig
@@ -162,6 +162,14 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config GENERIC_FIND_NEXT_BIT
+	bool
+	default y
+
+config GENERIC_HWEIGHT
+	bool
+	default y if !ULTRA_HAS_POPULATION_COUNT
+
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y

--
