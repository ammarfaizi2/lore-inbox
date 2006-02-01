Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWBAJSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWBAJSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWBAJN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:13:26 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:65098 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932346AbWBAJDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:33 -0500
Message-Id: <20060201090331.940886000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:48 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 24/44] i386: use generic bitops
Content-Disposition: inline; filename=i386.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove generic_fls64()
- remove sched_find_first_bit()
- remove generic_hweight{32,16,8}()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-i386/bitops.h |   55 ++++++----------------------------------------
 1 files changed, 8 insertions(+), 47 deletions(-)

Index: 2.6-git/include/asm-i386/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-i386/bitops.h
+++ 2.6-git/include/asm-i386/bitops.h
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
 

--
