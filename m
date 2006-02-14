Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbWBNFUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbWBNFUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWBNFUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:20:06 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:11471 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030370AbWBNFFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:04 -0500
Message-Id: <20060214050445.773162000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:12 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Ian Molton <spyro@f2s.com>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 21/47] arm26: use generic bitops
Content-Disposition: inline; filename=arm26.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- remove ffz()
- remove __ffs()
- remove generic_fls()
- remove generic_fls64()
- remove generic_ffs()
- remove sched_find_first_bit()
- remove generic_hweight{32,16,8}()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/arm26/Kconfig         |    4 +
 include/asm-arm26/bitops.h |  146 +++------------------------------------------
 2 files changed, 14 insertions(+), 136 deletions(-)

Index: 2.6-rc/include/asm-arm26/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-arm26/bitops.h
+++ 2.6-rc/include/asm-arm26/bitops.h
@@ -117,65 +117,7 @@ ____atomic_test_and_change_bit(unsigned 
 	return res & mask;
 }
 
-/*
- * Now the non-atomic variants.  We let the compiler handle all
- * optimisations for these.  These are all _native_ endian.
- */
-static inline void __set_bit(int nr, volatile unsigned long *p)
-{
-	p[nr >> 5] |= (1UL << (nr & 31));
-}
-
-static inline void __clear_bit(int nr, volatile unsigned long *p)
-{
-	p[nr >> 5] &= ~(1UL << (nr & 31));
-}
-
-static inline void __change_bit(int nr, volatile unsigned long *p)
-{
-	p[nr >> 5] ^= (1UL << (nr & 31));
-}
-
-static inline int __test_and_set_bit(int nr, volatile unsigned long *p)
-{
-	unsigned long oldval, mask = 1UL << (nr & 31);
-
-	p += nr >> 5;
-
-	oldval = *p;
-	*p = oldval | mask;
-	return oldval & mask;
-}
-
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *p)
-{
-	unsigned long oldval, mask = 1UL << (nr & 31);
-
-	p += nr >> 5;
-
-	oldval = *p;
-	*p = oldval & ~mask;
-	return oldval & mask;
-}
-
-static inline int __test_and_change_bit(int nr, volatile unsigned long *p)
-{
-	unsigned long oldval, mask = 1UL << (nr & 31);
-
-	p += nr >> 5;
-
-	oldval = *p;
-	*p = oldval ^ mask;
-	return oldval & mask;
-}
-
-/*
- * This routine doesn't need to be atomic.
- */
-static inline int __test_bit(int nr, const volatile unsigned long * p)
-{
-	return (p[nr >> 5] >> (nr & 31)) & 1UL;
-}
+#include <asm-generic/bitops/non-atomic.h>
 
 /*
  * Little endian assembly bitops.  nr = 0 -> byte 0 bit 0.
@@ -211,7 +153,6 @@ extern int _find_next_bit_le(const unsig
 #define test_and_set_bit(nr,p)		ATOMIC_BITOP_LE(test_and_set_bit,nr,p)
 #define test_and_clear_bit(nr,p)	ATOMIC_BITOP_LE(test_and_clear_bit,nr,p)
 #define test_and_change_bit(nr,p)	ATOMIC_BITOP_LE(test_and_change_bit,nr,p)
-#define test_bit(nr,p)			__test_bit(nr,p)
 #define find_first_zero_bit(p,sz)	_find_first_zero_bit_le(p,sz)
 #define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_le(p,sz,off)
 #define find_first_bit(p,sz)		_find_first_bit_le(p,sz)
@@ -219,80 +160,13 @@ extern int _find_next_bit_le(const unsig
 
 #define WORD_BITOFF_TO_LE(x)		((x))
 
-/*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
- */
-static inline unsigned long ffz(unsigned long word)
-{
-	int k;
-
-	word = ~word;
-	k = 31;
-	if (word & 0x0000ffff) { k -= 16; word <<= 16; }
-	if (word & 0x00ff0000) { k -= 8;  word <<= 8;  }
-	if (word & 0x0f000000) { k -= 4;  word <<= 4;  }
-	if (word & 0x30000000) { k -= 2;  word <<= 2;  }
-	if (word & 0x40000000) { k -= 1; }
-        return k;
-}
-
-/*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
- */
-static inline unsigned long __ffs(unsigned long word)
-{
-	int k;
-
-	k = 31;
-	if (word & 0x0000ffff) { k -= 16; word <<= 16; }
-	if (word & 0x00ff0000) { k -= 8;  word <<= 8;  }
-	if (word & 0x0f000000) { k -= 4;  word <<= 4;  }
-	if (word & 0x30000000) { k -= 2;  word <<= 2;  }
-	if (word & 0x40000000) { k -= 1; }
-        return k;
-}
-
-/*
- * fls: find last bit set.
- */
-
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
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
- * Find first bit set in a 168-bit bitmap, where the first
- * 128 bits are unlikely to be set.
- */
-static inline int sched_find_first_bit(unsigned long *b)
-{
-	unsigned long v;
-	unsigned int off;
-
-	for (off = 0; v = b[off], off < 4; off++) {
-		if (unlikely(v))
-			break;
-	}
-	return __ffs(v) + off * 32;
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
+#include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/ffs.h>
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/hweight.h>
 
 /*
  * Ext2 is defined to use little-endian byte ordering.
@@ -307,7 +181,7 @@ static inline int sched_find_first_bit(u
 #define ext2_clear_bit_atomic(lock,nr,p)        \
                 test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
 #define ext2_test_bit(nr,p)			\
-		__test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
 #define ext2_find_first_zero_bit(p,sz)		\
 		_find_first_zero_bit_le(p,sz)
 #define ext2_find_next_zero_bit(p,sz,off)	\
@@ -320,7 +194,7 @@ static inline int sched_find_first_bit(u
 #define minix_set_bit(nr,p)			\
 		__set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
 #define minix_test_bit(nr,p)			\
-		__test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
 #define minix_test_and_set_bit(nr,p)		\
 		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
 #define minix_test_and_clear_bit(nr,p)		\
Index: 2.6-rc/arch/arm26/Kconfig
===================================================================
--- 2.6-rc.orig/arch/arm26/Kconfig
+++ 2.6-rc/arch/arm26/Kconfig
@@ -41,6 +41,10 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config GENERIC_HWEIGHT
+	bool
+	default y
+
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y

--
