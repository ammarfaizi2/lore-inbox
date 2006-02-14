Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWBNFKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWBNFKN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWBNFIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:08:36 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:35791 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030400AbWBNFFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:10 -0500
Message-Id: <20060214050449.146065000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:30 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 39/47] x86_64: use generic bitops
Content-Disposition: inline; filename=x86_64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove sched_find_first_bit()
- remove generic_hweight{64,32,16,8}()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/x86_64/Kconfig         |    4 ++++
 include/asm-x86_64/bitops.h |   42 ++++++------------------------------------
 2 files changed, 10 insertions(+), 36 deletions(-)

Index: 2.6-rc/include/asm-x86_64/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-x86_64/bitops.h
+++ 2.6-rc/include/asm-x86_64/bitops.h
@@ -356,14 +356,7 @@ static __inline__ unsigned long __fls(un
 
 #ifdef __KERNEL__
 
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-	if (b[0])
-		return __ffs(b[0]);
-	if (b[1])
-		return __ffs(b[1]) + 64;
-	return __ffs(b[2]) + 128;
-}
+#include <asm-generic/bitops/sched.h>
 
 /**
  * ffs - find first bit set
@@ -412,43 +405,20 @@ static __inline__ int fls(int x)
 	return r+1;
 }
 
-/**
- * hweightN - returns the hamming weight of a N-bit word
- * @x: the word to weigh
- *
- * The Hamming Weight of a number is the total number of bits set in it.
- */
-
-#define hweight64(x) generic_hweight64(x)
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#include <asm-generic/bitops/hweight.h>
 
 #endif /* __KERNEL__ */
 
 #ifdef __KERNEL__
 
-#define ext2_set_bit(nr,addr) \
-	__test_and_set_bit((nr),(unsigned long*)addr)
+#include <asm-generic/bitops/ext2-non-atomic.h>
+
 #define ext2_set_bit_atomic(lock,nr,addr) \
 	        test_and_set_bit((nr),(unsigned long*)addr)
-#define ext2_clear_bit(nr, addr) \
-	__test_and_clear_bit((nr),(unsigned long*)addr)
 #define ext2_clear_bit_atomic(lock,nr,addr) \
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
 
Index: 2.6-rc/arch/x86_64/Kconfig
===================================================================
--- 2.6-rc.orig/arch/x86_64/Kconfig
+++ 2.6-rc/arch/x86_64/Kconfig
@@ -45,6 +45,10 @@ config RWSEM_GENERIC_SPINLOCK
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
