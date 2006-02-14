Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWBNFOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWBNFOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWBNFNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:13:54 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:22479 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030373AbWBNFFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:05 -0500
Message-Id: <20060214050445.985970000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:13 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, dev-etrax@axis.com, Akinobu Mita <mita@miraclelinux.com>,
       Mikael Starvik <starvik@axis.com>
Subject: [patch 22/47] cris: use generic bitops
Content-Disposition: inline; filename=cris.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- remove generic_fls()
- remove generic_fls64()
- remove generic_hweight{32,16,8}()
- remove find_{next,first}{,_zero}_bit()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()
- remove sched_find_first_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
acked-by: Mikael Starvik <starvik@axis.com>

 arch/cris/Kconfig         |    8 +
 include/asm-cris/bitops.h |  234 +---------------------------------------------
 2 files changed, 16 insertions(+), 226 deletions(-)

Index: 2.6-rc/include/asm-cris/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-cris/bitops.h
+++ 2.6-rc/include/asm-cris/bitops.h
@@ -39,8 +39,6 @@ struct __dummy { unsigned long a[100]; }
 
 #define set_bit(nr, addr)    (void)test_and_set_bit(nr, addr)
 
-#define __set_bit(nr, addr)    (void)__test_and_set_bit(nr, addr)
-
 /*
  * clear_bit - Clears a bit in memory
  * @nr: Bit to clear
@@ -54,8 +52,6 @@ struct __dummy { unsigned long a[100]; }
 
 #define clear_bit(nr, addr)  (void)test_and_clear_bit(nr, addr)
 
-#define __clear_bit(nr, addr)  (void)__test_and_clear_bit(nr, addr)
-
 /*
  * change_bit - Toggle a bit in memory
  * @nr: Bit to change
@@ -68,18 +64,6 @@ struct __dummy { unsigned long a[100]; }
 
 #define change_bit(nr, addr) (void)test_and_change_bit(nr, addr)
 
-/*
- * __change_bit - Toggle a bit in memory
- * @nr: the bit to change
- * @addr: the address to start counting from
- *
- * Unlike change_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-
-#define __change_bit(nr, addr) (void)__test_and_change_bit(nr, addr)
-
 /**
  * test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
@@ -104,18 +88,6 @@ static inline int test_and_set_bit(int n
 	return retval;
 }
 
-static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned int mask, retval;
-	unsigned int *adr = (unsigned int *)addr;
-	
-	adr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *adr) != 0;
-	*adr |= mask;
-	return retval;
-}
-
 /*
  * clear_bit() doesn't provide any barrier for the compiler.
  */
@@ -147,27 +119,6 @@ static inline int test_and_clear_bit(int
 }
 
 /**
- * __test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to clear
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.  
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned int mask, retval;
-	unsigned int *adr = (unsigned int *)addr;
-	
-	adr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *adr) != 0;
-	*adr &= ~mask;
-	return retval;
-}
-/**
  * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
@@ -190,42 +141,7 @@ static inline int test_and_change_bit(in
 	return retval;
 }
 
-/* WARNING: non atomic and it can be reordered! */
-
-static inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned int mask, retval;
-	unsigned int *adr = (unsigned int *)addr;
-
-	adr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *adr) != 0;
-	*adr ^= mask;
-
-	return retval;
-}
-
-/**
- * test_bit - Determine whether a bit is set
- * @nr: bit number to test
- * @addr: Address to start counting from
- *
- * This routine doesn't need to be atomic.
- */
-
-static inline int test_bit(int nr, const volatile unsigned long *addr)
-{
-	unsigned int mask;
-	unsigned int *adr = (unsigned int *)addr;
-	
-	adr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	return ((mask & *adr) != 0);
-}
-
-/*
- * Find-bit routines..
- */
+#include <asm-generic/bitops/non-atomic.h>
 
 /*
  * Since we define it "external", it collides with the built-in
@@ -234,152 +150,18 @@ static inline int test_bit(int nr, const
  */
 #define ffs kernel_ffs
 
-/*
- * fls: find last bit set.
- */
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/find.h>
 
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
+#include <asm-generic/bitops/ext2-non-atomic.h>
 
-/*
- * hweightN - returns the hamming weight of a N-bit word
- * @x: the word to weigh
- *
- * The Hamming Weight of a number is the total number of bits set in it.
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
-
-/**
- * find_next_zero_bit - find the first zero bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-static inline int find_next_zero_bit (const unsigned long * addr, int size, int offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
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
- found_first:
-	tmp |= ~0UL << size;
- found_middle:
-	return result + ffz(tmp);
-}
-
-/**
- * find_next_bit - find the first set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-static __inline__ int find_next_bit(const unsigned long *addr, int size, int offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
-        unsigned long result = offset & ~31UL;
-        unsigned long tmp;
-
-        if (offset >= size)
-                return size;
-        size -= result;
-        offset &= 31UL;
-        if (offset) {
-                tmp = *(p++);
-                tmp &= (~0UL << offset);
-                if (size < 32)
-                        goto found_first;
-                if (tmp)
-                        goto found_middle;
-                size -= 32;
-                result += 32;
-        }
-        while (size & ~31UL) {
-                if ((tmp = *(p++)))
-                        goto found_middle;
-                result += 32;
-                size -= 32;
-        }
-        if (!size)
-                return result;
-        tmp = *p;
-
-found_first:
-        tmp &= (~0UL >> (32 - size));
-        if (tmp == 0UL)        /* Are any bits set? */
-                return result + size; /* Nope. */
-found_middle:
-        return result + __ffs(tmp);
-}
-
-/**
- * find_first_zero_bit - find the first zero bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit-number of the first zero bit, not the number of the byte
- * containing a bit.
- */
-
-#define find_first_zero_bit(addr, size) \
-        find_next_zero_bit((addr), (size), 0)
-#define find_first_bit(addr, size) \
-        find_next_bit((addr), (size), 0)
-
-#define ext2_set_bit                 __test_and_set_bit
 #define ext2_set_bit_atomic(l,n,a)   test_and_set_bit(n,a)
-#define ext2_clear_bit               __test_and_clear_bit
 #define ext2_clear_bit_atomic(l,n,a) test_and_clear_bit(n,a)
-#define ext2_test_bit                test_bit
-#define ext2_find_first_zero_bit     find_first_zero_bit
-#define ext2_find_next_zero_bit      find_next_zero_bit
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (unlikely(b[3]))
-		return __ffs(b[3]) + 96;
-	if (b[4])
-		return __ffs(b[4]) + 128;
-	return __ffs(b[5]) + 32 + 128;
-}
+#include <asm-generic/bitops/minix.h>
+#include <asm-generic/bitops/sched.h>
 
 #endif /* __KERNEL__ */
 
Index: 2.6-rc/arch/cris/Kconfig
===================================================================
--- 2.6-rc.orig/arch/cris/Kconfig
+++ 2.6-rc/arch/cris/Kconfig
@@ -16,6 +16,14 @@ config RWSEM_GENERIC_SPINLOCK
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
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y

--
