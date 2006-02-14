Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWBNFGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWBNFGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWBNFGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:06:04 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:46031 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030398AbWBNFFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:10 -0500
Message-Id: <20060214050449.328262000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:31 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Chris Zankel <chris@zankel.net>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 40/47] xtensa: use generic bitops
Content-Disposition: inline; filename=xtensa.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove {,test_and_}{set,clear,change}_bit()
- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- remove generic_fls64()
- remove find_{next,first}{,_zero}_bit()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove generic_hweight{32,16,8}()
- remove sched_find_first_bit()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/xtensa/Kconfig         |    8 +
 include/asm-xtensa/bitops.h |  340 +-------------------------------------------
 2 files changed, 16 insertions(+), 332 deletions(-)

Index: 2.6-rc/include/asm-xtensa/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-xtensa/bitops.h
+++ 2.6-rc/include/asm-xtensa/bitops.h
@@ -23,156 +23,11 @@
 # error SMP not supported on this architecture
 #endif
 
-static __inline__ void set_bit(int nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long flags;
-
-	local_irq_save(flags);
-	*a |= mask;
-	local_irq_restore(flags);
-}
-
-static __inline__ void __set_bit(int nr, volatile unsigned long * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-
-	*a |= mask;
-}
-
-static __inline__ void clear_bit(int nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long flags;
-
-	local_irq_save(flags);
-	*a &= ~mask;
-	local_irq_restore(flags);
-}
-
-static __inline__ void __clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-
-	*a &= ~mask;
-}
-
-/*
- * clear_bit() doesn't provide any barrier for the compiler.
- */
-
 #define smp_mb__before_clear_bit()	barrier()
 #define smp_mb__after_clear_bit()	barrier()
 
-static __inline__ void change_bit(int nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long flags;
-
-	local_irq_save(flags);
-	*a ^= mask;
-	local_irq_restore(flags);
-}
-
-static __inline__ void __change_bit(int nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-
-	*a ^= mask;
-}
-
-static __inline__ int test_and_set_bit(int nr, volatile void * addr)
-{
-  	unsigned long retval;
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long flags;
-
-	local_irq_save(flags);
-	retval = (mask & *a) != 0;
-	*a |= mask;
-	local_irq_restore(flags);
-
-	return retval;
-}
-
-static __inline__ int __test_and_set_bit(int nr, volatile void * addr)
-{
-  	unsigned long retval;
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-
-	retval = (mask & *a) != 0;
-	*a |= mask;
-
-	return retval;
-}
-
-static __inline__ int test_and_clear_bit(int nr, volatile void * addr)
-{
-  	unsigned long retval;
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long flags;
-
-	local_irq_save(flags);
-	retval = (mask & *a) != 0;
-	*a &= ~mask;
-	local_irq_restore(flags);
-
-	return retval;
-}
-
-static __inline__ int __test_and_clear_bit(int nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-  	unsigned long old = *a;
-
-	*a = old & ~mask;
-	return (old & mask) != 0;
-}
-
-static __inline__ int test_and_change_bit(int nr, volatile void * addr)
-{
-  	unsigned long retval;
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	retval = (mask & *a) != 0;
-	*a ^= mask;
-	local_irq_restore(flags);
-
-	return retval;
-}
-
-/*
- * non-atomic version; can be reordered
- */
-
-static __inline__ int __test_and_change_bit(int nr, volatile void *addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long old = *a;
-
-	*a = old ^ mask;
-	return (old & mask) != 0;
-}
-
-static __inline__ int test_bit(int nr, const volatile void *addr)
-{
-	return 1UL & (((const volatile unsigned int *)addr)[nr>>5] >> (nr&31));
-}
+#include <asm-generic/bitops/atomic.h>
+#include <asm-generic/bitops/non-atomic.h>
 
 #if XCHAL_HAVE_NSA
 
@@ -245,202 +100,23 @@ static __inline__ int fls (unsigned int 
 {
 	return __cntlz(x);
 }
-#define fls64(x)   generic_fls64(x)
-
-static __inline__ int
-find_next_bit(const unsigned long *addr, int size, int offset)
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
-	if (tmp == 0UL)	/* Are any bits set? */
-		return result + size;	/* Nope. */
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
-
-#define find_first_bit(addr, size) \
-        find_next_bit((addr), (size), 0)
-
-static __inline__ int
-find_next_zero_bit(const unsigned long *addr, int size, int offset)
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
-		tmp = *p++;
-		tmp |= ~0UL >> (32-offset);
-		if (size < 32)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size & ~31UL) {
-		if (~(tmp = *p++))
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
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/find.h>
+#include <asm-generic/bitops/ext2-non-atomic.h>
 
 #ifdef __XTENSA_EL__
-# define ext2_set_bit(nr,addr) __test_and_set_bit((nr), (addr))
 # define ext2_set_bit_atomic(lock,nr,addr) test_and_set_bit((nr),(addr))
-# define ext2_clear_bit(nr,addr) __test_and_clear_bit((nr), (addr))
 # define ext2_clear_bit_atomic(lock,nr,addr) test_and_clear_bit((nr),(addr))
-# define ext2_test_bit(nr,addr) test_bit((nr), (addr))
-# define ext2_find_first_zero_bit(addr, size) find_first_zero_bit((addr),(size))
-# define ext2_find_next_zero_bit(addr, size, offset) \
-                find_next_zero_bit((addr), (size), (offset))
 #elif defined(__XTENSA_EB__)
-# define ext2_set_bit(nr,addr) __test_and_set_bit((nr) ^ 0x18, (addr))
 # define ext2_set_bit_atomic(lock,nr,addr) test_and_set_bit((nr) ^ 0x18, (addr))
-# define ext2_clear_bit(nr,addr) __test_and_clear_bit((nr) ^ 18, (addr))
 # define ext2_clear_bit_atomic(lock,nr,addr) test_and_clear_bit((nr)^0x18,(addr))
-# define ext2_test_bit(nr,addr) test_bit((nr) ^ 0x18, (addr))
-# define ext2_find_first_zero_bit(addr, size) \
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
-
 #else
 # error processor byte order undefined!
 #endif
 
-
-#define hweight32(x)	generic_hweight32(x)
-#define hweight16(x)	generic_hweight16(x)
-#define hweight8(x)	generic_hweight8(x)
-
-/*
- * Find the first bit set in a 140-bit bitmap.
- * The first 100 bits are unlikely to be set.
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
-
-/* Bitmap functions for the minix filesystem.  */
-
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
+#include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/minix.h>
 
 #endif	/* __KERNEL__ */
 
Index: 2.6-rc/arch/xtensa/Kconfig
===================================================================
--- 2.6-rc.orig/arch/xtensa/Kconfig
+++ 2.6-rc/arch/xtensa/Kconfig
@@ -22,6 +22,14 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
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
