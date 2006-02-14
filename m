Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbWBNFOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbWBNFOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbWBNFN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:13:57 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:22223 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030372AbWBNFFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:05 -0500
Message-Id: <20060214050446.354702000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:15 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 24/47] h8300: use generic bitops
Content-Disposition: inline; filename=h8300.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove generic_ffs()
- remove find_{next,first}{,_zero}_bit()
- remove sched_find_first_bit()
- remove generic_hweight{32,16,8}()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove ext2_{set,clear}_bit_atomic()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()
- remove generic_fls()
- remove generic_fls64()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/h8300/Kconfig         |    8 +
 include/asm-h8300/bitops.h |  222 +--------------------------------------------
 2 files changed, 17 insertions(+), 213 deletions(-)

Index: 2.6-rc/include/asm-h8300/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-h8300/bitops.h
+++ 2.6-rc/include/asm-h8300/bitops.h
@@ -8,7 +8,6 @@
 
 #include <linux/config.h>
 #include <linux/compiler.h>
-#include <asm/byteorder.h>	/* swab32 */
 #include <asm/system.h>
 
 #ifdef __KERNEL__
@@ -177,10 +176,7 @@ H8300_GEN_TEST_BITOP(test_and_change_bit
 #undef H8300_GEN_TEST_BITOP_CONST_INT
 #undef H8300_GEN_TEST_BITOP
 
-#define find_first_zero_bit(addr, size) \
-	find_next_zero_bit((addr), (size), 0)
-
-#define ffs(x) generic_ffs(x)
+#include <asm-generic/bitops/ffs.h>
 
 static __inline__ unsigned long __ffs(unsigned long word)
 {
@@ -196,216 +192,16 @@ static __inline__ unsigned long __ffs(un
 	return result;
 }
 
-static __inline__ int find_next_zero_bit (const unsigned long * addr, int size, int offset)
-{
-	unsigned long *p = (unsigned long *)(((unsigned long)addr + (offset >> 3)) & ~3);
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
-static __inline__ unsigned long find_next_bit(const unsigned long *addr,
-	unsigned long size, unsigned long offset)
-{
-	unsigned long *p = (unsigned long *)(((unsigned long)addr + (offset >> 3)) & ~3);
-	unsigned int result = offset & ~31UL;
-	unsigned int tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *(p++);
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
-	if (tmp == 0UL)
-		return result + size;
-found_middle:
-	return result + __ffs(tmp);
-}
-
-#define find_first_bit(addr, size) find_next_bit(addr, size, 0)
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
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
-
-static __inline__ int ext2_set_bit(int nr, volatile void * addr)
-{
-	int		mask, retval;
-	unsigned long	flags;
-	volatile unsigned char	*ADDR = (unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	local_irq_save(flags);
-	retval = (mask & *ADDR) != 0;
-	*ADDR |= mask;
-	local_irq_restore(flags);
-	return retval;
-}
-#define ext2_set_bit_atomic(lock, nr, addr) ext2_set_bit(nr, addr)
-
-static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
-{
-	int		mask, retval;
-	unsigned long	flags;
-	volatile unsigned char	*ADDR = (unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	local_irq_save(flags);
-	retval = (mask & *ADDR) != 0;
-	*ADDR &= ~mask;
-	local_irq_restore(flags);
-	return retval;
-}
-#define ext2_clear_bit_atomic(lock, nr, addr) ext2_set_bit(nr, addr)
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
-	ext2_find_next_zero_bit((addr), (size), 0)
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
-		 * but this would decrease performance, so we change the
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
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
+#include <asm-generic/bitops/find.h>
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/ext2-non-atomic.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+#include <asm-generic/bitops/minix.h>
 
 #endif /* __KERNEL__ */
 
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/fls64.h>
 
 #endif /* _H8300_BITOPS_H */
Index: 2.6-rc/arch/h8300/Kconfig
===================================================================
--- 2.6-rc.orig/arch/h8300/Kconfig
+++ 2.6-rc/arch/h8300/Kconfig
@@ -29,6 +29,14 @@ config RWSEM_XCHGADD_ALGORITHM
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
