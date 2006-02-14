Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbWBNFI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWBNFI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWBNFIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:08:44 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:49103 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030396AbWBNFFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:10 -0500
Message-Id: <20060214050447.881160000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:23 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 32/47] powerpc: use generic bitops
Content-Disposition: inline; filename=powerpc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- remove generic_fls64()
- remove generic_hweight{64,32,16,8}()
- remove sched_find_first_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/powerpc/Kconfig         |    4 +
 include/asm-powerpc/bitops.h |  105 +------------------------------------------
 2 files changed, 8 insertions(+), 101 deletions(-)

Index: 2.6-rc/include/asm-powerpc/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-powerpc/bitops.h
+++ 2.6-rc/include/asm-powerpc/bitops.h
@@ -184,72 +184,7 @@ static __inline__ void set_bits(unsigned
 	: "cc");
 }
 
-/* Non-atomic versions */
-static __inline__ int test_bit(unsigned long nr,
-			       __const__ volatile unsigned long *addr)
-{
-	return 1UL & (addr[BITOP_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
-}
-
-static __inline__ void __set_bit(unsigned long nr,
-				 volatile unsigned long *addr)
-{
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
-
-	*p  |= mask;
-}
-
-static __inline__ void __clear_bit(unsigned long nr,
-				   volatile unsigned long *addr)
-{
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
-
-	*p &= ~mask;
-}
-
-static __inline__ void __change_bit(unsigned long nr,
-				    volatile unsigned long *addr)
-{
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
-
-	*p ^= mask;
-}
-
-static __inline__ int __test_and_set_bit(unsigned long nr,
-					 volatile unsigned long *addr)
-{
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
-	unsigned long old = *p;
-
-	*p = old | mask;
-	return (old & mask) != 0;
-}
-
-static __inline__ int __test_and_clear_bit(unsigned long nr,
-					   volatile unsigned long *addr)
-{
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
-	unsigned long old = *p;
-
-	*p = old & ~mask;
-	return (old & mask) != 0;
-}
-
-static __inline__ int __test_and_change_bit(unsigned long nr,
-					    volatile unsigned long *addr)
-{
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
-	unsigned long old = *p;
-
-	*p = old ^ mask;
-	return (old & mask) != 0;
-}
+#include <asm-generic/bitops/non-atomic.h>
 
 /*
  * Return the zero-based bit position (LE, not IBM bit numbering) of
@@ -310,16 +245,9 @@ static __inline__ int fls(unsigned int x
 	asm ("cntlzw %0,%1" : "=r" (lz) : "r" (x));
 	return 32 - lz;
 }
-#define fls64(x)   generic_fls64(x)
+#include <asm-generic/bitops/fls64.h>
 
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-#define hweight64(x) generic_hweight64(x)
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#include <asm-generic/bitops/hweight.h>
 
 #define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
 unsigned long find_next_zero_bit(const unsigned long *addr,
@@ -397,32 +325,7 @@ unsigned long find_next_zero_le_bit(cons
 #define minix_find_first_zero_bit(addr,size) \
 	find_first_zero_le_bit((unsigned long *)addr, size)
 
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-#ifdef CONFIG_PPC64
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
+#include <asm-generic/bitops/sched.h>
 
 #endif /* __KERNEL__ */
 
Index: 2.6-rc/arch/powerpc/Kconfig
===================================================================
--- 2.6-rc.orig/arch/powerpc/Kconfig
+++ 2.6-rc/arch/powerpc/Kconfig
@@ -37,6 +37,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config GENERIC_HWEIGHT
+	bool
+	default y
+
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y

--
