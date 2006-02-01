Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWBAJJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWBAJJW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWBAJIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:08:50 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:3659 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932383AbWBAJDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:34 -0500
Message-Id: <20060201090332.783740000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:51 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: linux-m68k@vger.kernel.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 27/44] m68k: use generic bitops
Content-Disposition: inline; filename=m68k.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove generic_fls64()
- remove sched_find_first_bit()
- remove generic_hweight()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-m68k/bitops.h |   86 ++--------------------------------------------
 1 files changed, 5 insertions(+), 81 deletions(-)

Index: 2.6-git/include/asm-m68k/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-m68k/bitops.h
+++ 2.6-git/include/asm-m68k/bitops.h
@@ -310,36 +310,10 @@ static inline int fls(int x)
 
 	return 32 - cnt;
 }
-#define fls64(x)   generic_fls64(x)
-
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
 
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/hweight.h>
 
 /* Bitmap functions for the minix filesystem */
 
@@ -377,61 +351,11 @@ static inline int minix_test_bit(int nr,
 
 /* Bitmap functions for the ext2 filesystem. */
 
-#define ext2_set_bit(nr, addr)			__test_and_set_bit((nr) ^ 24, (unsigned long *)(addr))
+#include <asm-generic/bitops/ext2-non-atomic.h>
+
 #define ext2_set_bit_atomic(lock, nr, addr)	test_and_set_bit((nr) ^ 24, (unsigned long *)(addr))
-#define ext2_clear_bit(nr, addr)		__test_and_clear_bit((nr) ^ 24, (unsigned long *)(addr))
 #define ext2_clear_bit_atomic(lock, nr, addr)	test_and_clear_bit((nr) ^ 24, (unsigned long *)(addr))
 
-static inline int ext2_test_bit(int nr, const void *vaddr)
-{
-	const unsigned char *p = vaddr;
-	return (p[nr >> 3] & (1U << (nr & 7))) != 0;
-}
-
-static inline int ext2_find_first_zero_bit(const void *vaddr, unsigned size)
-{
-	const unsigned long *p = vaddr, *addr = vaddr;
-	int res;
-
-	if (!size)
-		return 0;
-
-	size = (size >> 5) + ((size & 31) > 0);
-	while (*p++ == ~0UL)
-	{
-		if (--size == 0)
-			return (p - addr) << 5;
-	}
-
-	--p;
-	for (res = 0; res < 32; res++)
-		if (!ext2_test_bit (res, p))
-			break;
-	return (p - addr) * 32 + res;
-}
-
-static inline int ext2_find_next_zero_bit(const void *vaddr, unsigned size,
-					  unsigned offset)
-{
-	const unsigned long *addr = vaddr;
-	const unsigned long *p = addr + (offset >> 5);
-	int bit = offset & 31UL, res;
-
-	if (offset >= size)
-		return size;
-
-	if (bit) {
-		/* Look for zero in first longword */
-		for (res = bit; res < 32; res++)
-			if (!ext2_test_bit (res, p))
-				return (p - addr) * 32 + res;
-		p++;
-	}
-	/* No zero yet, search remaining full bytes for a zero */
-	res = ext2_find_first_zero_bit (p, size - 32 * (p - addr));
-	return (p - addr) * 32 + res;
-}
-
 #endif /* __KERNEL__ */
 
 #endif /* _M68K_BITOPS_H */

--
