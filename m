Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbWBNFI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWBNFI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWBNFIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:08:43 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:46799 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030392AbWBNFFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:10 -0500
Message-Id: <20060214050448.246311000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:25 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linuxsh-dev@lists.sourceforge.net,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 34/47] sh: use generic bitops
Content-Disposition: inline; filename=sh.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- remove find_{next,first}{,_zero}_bit()
- remove generic_ffs()
- remove generic_hweight{32,16,8}()
- remove sched_find_first_bit()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove ext2_{set,clear}_bit_atomic()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()
- remove generic_fls()
- remove generic_fls64()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/sh/Kconfig         |    8 +
 include/asm-sh/bitops.h |  342 +-----------------------------------------------
 2 files changed, 18 insertions(+), 332 deletions(-)

Index: 2.6-rc/include/asm-sh/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-sh/bitops.h
+++ 2.6-rc/include/asm-sh/bitops.h
@@ -19,16 +19,6 @@ static __inline__ void set_bit(int nr, v
 	local_irq_restore(flags);
 }
 
-static __inline__ void __set_bit(int nr, volatile void * addr)
-{
-	int	mask;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	*a |= mask;
-}
-
 /*
  * clear_bit() doesn't provide any barrier for the compiler.
  */
@@ -47,16 +37,6 @@ static __inline__ void clear_bit(int nr,
 	local_irq_restore(flags);
 }
 
-static __inline__ void __clear_bit(int nr, volatile void * addr)
-{
-	int	mask;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	*a &= ~mask;
-}
-
 static __inline__ void change_bit(int nr, volatile void * addr)
 {
 	int	mask;
@@ -70,16 +50,6 @@ static __inline__ void change_bit(int nr
 	local_irq_restore(flags);
 }
 
-static __inline__ void __change_bit(int nr, volatile void * addr)
-{
-	int	mask;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	*a ^= mask;
-}
-
 static __inline__ int test_and_set_bit(int nr, volatile void * addr)
 {
 	int	mask, retval;
@@ -96,19 +66,6 @@ static __inline__ int test_and_set_bit(i
 	return retval;
 }
 
-static __inline__ int __test_and_set_bit(int nr, volatile void * addr)
-{
-	int	mask, retval;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *a) != 0;
-	*a |= mask;
-
-	return retval;
-}
-
 static __inline__ int test_and_clear_bit(int nr, volatile void * addr)
 {
 	int	mask, retval;
@@ -125,19 +82,6 @@ static __inline__ int test_and_clear_bit
 	return retval;
 }
 
-static __inline__ int __test_and_clear_bit(int nr, volatile void * addr)
-{
-	int	mask, retval;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *a) != 0;
-	*a &= ~mask;
-
-	return retval;
-}
-
 static __inline__ int test_and_change_bit(int nr, volatile void * addr)
 {
 	int	mask, retval;
@@ -154,23 +98,7 @@ static __inline__ int test_and_change_bi
 	return retval;
 }
 
-static __inline__ int __test_and_change_bit(int nr, volatile void * addr)
-{
-	int	mask, retval;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *a) != 0;
-	*a ^= mask;
-
-	return retval;
-}
-
-static __inline__ int test_bit(int nr, const volatile void *addr)
-{
-	return 1UL & (((const volatile unsigned int *) addr)[nr >> 5] >> (nr & 31));
-}
+#include <asm-generic/bitops/non-atomic.h>
 
 static __inline__ unsigned long ffz(unsigned long word)
 {
@@ -206,265 +134,15 @@ static __inline__ unsigned long __ffs(un
 	return result;
 }
 
-/**
- * find_next_bit - find the next set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
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
-static __inline__ int find_next_zero_bit(const unsigned long *addr, int size, int offset)
-{
-	const unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
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
-#define find_first_zero_bit(addr, size) \
-        find_next_zero_bit((addr), (size), 0)
-
-/*
- * ffs: find first bit set. This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-
-#define ffs(x) generic_ffs(x)
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
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-
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
-
-#ifdef __LITTLE_ENDIAN__
-#define ext2_set_bit(nr, addr) __test_and_set_bit((nr), (addr))
-#define ext2_clear_bit(nr, addr) __test_and_clear_bit((nr), (addr))
-#define ext2_test_bit(nr, addr) test_bit((nr), (addr))
-#define ext2_find_first_zero_bit(addr, size) find_first_zero_bit((addr), (size))
-#define ext2_find_next_zero_bit(addr, size, offset) \
-                find_next_zero_bit((unsigned long *)(addr), (size), (offset))
-#else
-static __inline__ int ext2_set_bit(int nr, volatile void * addr)
-{
-	int		mask, retval;
-	volatile unsigned char	*ADDR = (unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR |= mask;
-	return retval;
-}
-
-static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
-{
-	int		mask, retval;
-	volatile unsigned char	*ADDR = (unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR &= ~mask;
-	return retval;
-}
-
-static __inline__ int ext2_test_bit(int nr, const volatile void * addr)
-{
-	int			mask;
-	const volatile unsigned char	*ADDR = (const unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	return ((mask & *ADDR) != 0);
-}
-
-#define ext2_find_first_zero_bit(addr, size) \
-        ext2_find_next_zero_bit((addr), (size), 0)
-
-static __inline__ unsigned long ext2_find_next_zero_bit(void *addr, unsigned long size, unsigned long offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
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
-#endif
-
-#define ext2_set_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_set_bit((nr), (addr));	\
-		spin_unlock(lock);			\
-		ret;					\
-	})
-
-#define ext2_clear_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_clear_bit((nr), (addr));	\
-		spin_unlock(lock);			\
-		ret;					\
-	})
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
-
-/*
- * fls: find last bit set.
- */
-
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
+#include <asm-generic/bitops/find.h>
+#include <asm-generic/bitops/ffs.h>
+#include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/ext2-non-atomic.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+#include <asm-generic/bitops/minix.h>
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/fls64.h>
 
 #endif /* __KERNEL__ */
 
Index: 2.6-rc/arch/sh/Kconfig
===================================================================
--- 2.6-rc.orig/arch/sh/Kconfig
+++ 2.6-rc/arch/sh/Kconfig
@@ -21,6 +21,14 @@ config RWSEM_GENERIC_SPINLOCK
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
 config GENERIC_HARDIRQS
 	bool
 	default y

--
