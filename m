Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbWBNFNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWBNFNx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbWBNFNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:13:50 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:22735 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030374AbWBNFFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:05 -0500
Message-Id: <20060214050446.525640000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:16 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 25/47] i386: use generic bitops
Content-Disposition: inline; filename=i386.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove generic_fls64()
- remove sched_find_first_bit()
- remove generic_hweight{32,16,8}()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/i386/Kconfig         |    4 +++
 include/asm-i386/bitops.h |   55 ++++++----------------------------------------
 2 files changed, 12 insertions(+), 47 deletions(-)

Index: 2.6-rc/include/asm-i386/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-i386/bitops.h
+++ 2.6-rc/include/asm-i386/bitops.h
@@ -367,28 +367,9 @@ static inline unsigned long ffz(unsigned
 	return word;
 }
 
-#define fls64(x)   generic_fls64(x)
-
 #ifdef __KERNEL__
 
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
+#include <asm-generic/bitops/sched.h>
 
 /**
  * ffs - find first bit set
@@ -426,42 +407,22 @@ static inline int fls(int x)
 	return r+1;
 }
 
-/**
- * hweightN - returns the hamming weight of a N-bit word
- * @x: the word to weigh
- *
- * The Hamming Weight of a number is the total number of bits set in it.
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#include <asm-generic/bitops/hweight.h>
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops/fls64.h>
+
 #ifdef __KERNEL__
 
-#define ext2_set_bit(nr,addr) \
-	__test_and_set_bit((nr),(unsigned long*)addr)
+#include <asm-generic/bitops/ext2-non-atomic.h>
+
 #define ext2_set_bit_atomic(lock,nr,addr) \
         test_and_set_bit((nr),(unsigned long*)addr)
-#define ext2_clear_bit(nr, addr) \
-	__test_and_clear_bit((nr),(unsigned long*)addr)
 #define ext2_clear_bit_atomic(lock,nr, addr) \
 	        test_and_clear_bit((nr),(unsigned long*)addr)
-#define ext2_test_bit(nr, addr)      test_bit((nr),(unsigned long*)addr)
-#define ext2_find_first_zero_bit(addr, size) \
-	find_first_zero_bit((unsigned long*)addr, size)
-#define ext2_find_next_zero_bit(addr, size, off) \
-	find_next_zero_bit((unsigned long*)addr, size, off)
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,(void*)addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,(void*)addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,(void*)addr)
-#define minix_test_bit(nr,addr) test_bit(nr,(void*)addr)
-#define minix_find_first_zero_bit(addr,size) \
-	find_first_zero_bit((void*)addr,size)
+
+#include <asm-generic/bitops/minix.h>
 
 #endif /* __KERNEL__ */
 
Index: 2.6-rc/arch/i386/Kconfig
===================================================================
--- 2.6-rc.orig/arch/i386/Kconfig
+++ 2.6-rc/arch/i386/Kconfig
@@ -37,6 +37,10 @@ config GENERIC_IOMAP
 	bool
 	default y
 
+config GENERIC_HWEIGHT
+	bool
+	default y
+
 config ARCH_MAY_HAVE_PC_FDC
 	bool
 	default y

--
