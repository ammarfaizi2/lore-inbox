Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313645AbSDPJRv>; Tue, 16 Apr 2002 05:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313653AbSDPJRu>; Tue, 16 Apr 2002 05:17:50 -0400
Received: from slip-202-135-75-110.ca.au.prserv.net ([202.135.75.110]:23948
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S313645AbSDPJRr>; Tue, 16 Apr 2002 05:17:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Subject: [PATCH] set_bit takes a long
Date: Tue, 16 Apr 2002 19:20:38 +1000
Message-Id: <E16xP90-0005ZT-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally, this changes set_bit et al. to take a "unsigned long *" on
ppc and i386.  This will make the world a better place.

Please forward patches for any warnings which crop up in random code
to trivial@rustcorp.com.au.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-i386/bitops.h working-2.5.7-pre1-bitops/include/asm-i386/bitops.h
--- linux-2.5.7-pre1/include/asm-i386/bitops.h	Sat Mar 16 13:03:31 2002
+++ working-2.5.7-pre1-bitops/include/asm-i386/bitops.h	Sat Mar 16 13:48:31 2002
@@ -34,7 +34,7 @@
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static __inline__ void set_bit(int nr, volatile void * addr)
+static __inline__ void set_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__( LOCK_PREFIX
 		"btsl %1,%0"
@@ -51,7 +51,7 @@
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static __inline__ void __set_bit(int nr, volatile void * addr)
+static __inline__ void __set_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__(
 		"btsl %1,%0"
@@ -69,7 +69,7 @@
  * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
  * in order to ensure changes are visible on other processors.
  */
-static __inline__ void clear_bit(int nr, volatile void * addr)
+static __inline__ void clear_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__( LOCK_PREFIX
 		"btrl %1,%0"
@@ -77,7 +77,7 @@
 		:"Ir" (nr));
 }
 
-static __inline__ void __clear_bit(int nr, volatile void * addr)
+static __inline__ void __clear_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__(
 		"btrl %1,%0"
@@ -96,7 +96,7 @@
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static __inline__ void __change_bit(int nr, volatile void * addr)
+static __inline__ void __change_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__(
 		"btcl %1,%0"
@@ -113,7 +113,7 @@
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static __inline__ void change_bit(int nr, volatile void * addr)
+static __inline__ void change_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__( LOCK_PREFIX
 		"btcl %1,%0"
@@ -129,7 +129,7 @@
  * This operation is atomic and cannot be reordered.  
  * It also implies a memory barrier.
  */
-static __inline__ int test_and_set_bit(int nr, volatile void * addr)
+static __inline__ int test_and_set_bit(int nr, volatile unsigned long * addr)
 {
 	int oldbit;
 
@@ -149,7 +149,7 @@
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static __inline__ int __test_and_set_bit(int nr, volatile void * addr)
+static __inline__ int __test_and_set_bit(int nr, volatile unsigned long * addr)
 {
 	int oldbit;
 
@@ -168,7 +168,7 @@
  * This operation is atomic and cannot be reordered.  
  * It also implies a memory barrier.
  */
-static __inline__ int test_and_clear_bit(int nr, volatile void * addr)
+static __inline__ int test_and_clear_bit(int nr, volatile unsigned long * addr)
 {
 	int oldbit;
 
@@ -188,7 +188,7 @@
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static __inline__ int __test_and_clear_bit(int nr, volatile void * addr)
+static __inline__ int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	int oldbit;
 
@@ -200,7 +200,7 @@
 }
 
 /* WARNING: non atomic and it can be reordered! */
-static __inline__ int __test_and_change_bit(int nr, volatile void * addr)
+static __inline__ int __test_and_change_bit(int nr, volatile unsigned long *addr)
 {
 	int oldbit;
 
@@ -219,7 +219,7 @@
  * This operation is atomic and cannot be reordered.  
  * It also implies a memory barrier.
  */
-static __inline__ int test_and_change_bit(int nr, volatile void * addr)
+static __inline__ int test_and_change_bit(int nr, volatile unsigned long* addr)
 {
 	int oldbit;
 
@@ -239,12 +239,12 @@
 static int test_bit(int nr, const volatile void * addr);
 #endif
 
-static __inline__ int constant_test_bit(int nr, const volatile void * addr)
+static __inline__ int constant_test_bit(int nr, const volatile unsigned long * addr)
 {
 	return ((1UL << (nr & 31)) & (((const volatile unsigned int *) addr)[nr >> 5])) != 0;
 }
 
-static __inline__ int variable_test_bit(int nr, volatile void * addr)
+static __inline__ int variable_test_bit(int nr, volatile unsigned long * addr)
 {
 	int oldbit;
 
@@ -268,7 +268,7 @@
  * Returns the bit-number of the first zero bit, not the number of the byte
  * containing a bit.
  */
-static __inline__ int find_first_zero_bit(void * addr, unsigned size)
+static __inline__ int find_first_zero_bit(unsigned long * addr, unsigned size)
 {
 	int d0, d1, d2;
 	int res;
@@ -300,7 +300,7 @@
  * Returns the bit-number of the first set bit, not the number of the byte
  * containing a bit.
  */
-static __inline__ int find_first_bit(void * addr, unsigned size)
+static __inline__ int find_first_bit(unsigned long * addr, unsigned size)
 {
 	int d0, d1;
 	int res;
@@ -326,7 +326,7 @@
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-static __inline__ int find_next_zero_bit (void * addr, int size, int offset)
+static __inline__ int find_next_zero_bit(unsigned long * addr, int size, int offset)
 {
 	unsigned long * p = ((unsigned long *) addr) + (offset >> 5);
 	int set = 0, bit = offset & 31, res;
@@ -359,9 +359,9 @@
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-static __inline__ int find_next_bit(void * addr, int size, int offset)
+static __inline__ int find_next_bit(unsigned long *addr, int size, int offset)
 {
-	unsigned long * p = ((unsigned long *) addr) + (offset >> 5);
+	unsigned long * p = addr + (offset >> 5);
 	int set = 0, bit = offset & 31, res;
 
 	if (bit) {
@@ -382,7 +382,7 @@
 	/*
 	 * No set bit yet, search remaining full words for a bit
 	 */
-	res = find_first_bit (p, size - 32 * (p - (unsigned long *) addr));
+	res = find_first_bit (p, size - 32 * (p - addr));
 	return (offset + set + res);
 }
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-ppc/bitops.h working-2.5.7-pre1-bitops/include/asm-ppc/bitops.h
--- linux-2.5.7-pre1/include/asm-ppc/bitops.h	Fri Mar 15 13:00:59 2002
+++ working-2.5.7-pre1-bitops/include/asm-ppc/bitops.h	Sat Mar 16 12:59:37 2002
@@ -30,7 +30,7 @@
  * These used to be if'd out here because using : "cc" as a constraint
  * resulted in errors from egcs.  Things appear to be OK with gcc-2.95.
  */
-static __inline__ void set_bit(int nr, volatile void * addr)
+static __inline__ void set_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long old;
 	unsigned long mask = 1 << (nr & 0x1f);
@@ -50,7 +50,7 @@
 /*
  * non-atomic version
  */
-static __inline__ void __set_bit(int nr, volatile void *addr)
+static __inline__ void __set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
@@ -64,7 +64,7 @@
 #define smp_mb__before_clear_bit()	smp_mb()
 #define smp_mb__after_clear_bit()	smp_mb()
 
-static __inline__ void clear_bit(int nr, volatile void *addr)
+static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long old;
 	unsigned long mask = 1 << (nr & 0x1f);
@@ -84,7 +84,7 @@
 /*
  * non-atomic version
  */
-static __inline__ void __clear_bit(int nr, volatile void *addr)
+static __inline__ void __clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
@@ -92,7 +92,7 @@
 	*p &= ~mask;
 }
 
-static __inline__ void change_bit(int nr, volatile void *addr)
+static __inline__ void change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long old;
 	unsigned long mask = 1 << (nr & 0x1f);
@@ -112,7 +112,7 @@
 /*
  * non-atomic version
  */
-static __inline__ void __change_bit(int nr, volatile void *addr)
+static __inline__ void __change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
@@ -123,7 +123,7 @@
 /*
  * test_and_*_bit do imply a memory barrier (?)
  */
-static __inline__ int test_and_set_bit(int nr, volatile void *addr)
+static __inline__ int test_and_set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int old, t;
 	unsigned int mask = 1 << (nr & 0x1f);
@@ -146,7 +146,7 @@
 /*
  * non-atomic version
  */
-static __inline__ int __test_and_set_bit(int nr, volatile void *addr)
+static __inline__ int __test_and_set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
@@ -156,7 +156,7 @@
 	return (old & mask) != 0;
 }
 
-static __inline__ int test_and_clear_bit(int nr, volatile void *addr)
+static __inline__ int test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int old, t;
 	unsigned int mask = 1 << (nr & 0x1f);
@@ -179,7 +179,7 @@
 /*
  * non-atomic version
  */
-static __inline__ int __test_and_clear_bit(int nr, volatile void *addr)
+static __inline__ int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
@@ -189,7 +189,7 @@
 	return (old & mask) != 0;
 }
 
-static __inline__ int test_and_change_bit(int nr, volatile void *addr)
+static __inline__ int test_and_change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int old, t;
 	unsigned int mask = 1 << (nr & 0x1f);
@@ -212,7 +212,7 @@
 /*
  * non-atomic version
  */
-static __inline__ int __test_and_change_bit(int nr, volatile void *addr)
+static __inline__ int __test_and_change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
@@ -222,7 +222,7 @@
 	return (old & mask) != 0;
 }
 
-static __inline__ int test_bit(int nr, __const__ volatile void *addr)
+static __inline__ int test_bit(int nr, __const__ volatile unsigned long *addr)
 {
 	__const__ unsigned int *p = (__const__ unsigned int *) addr;
 
@@ -230,7 +230,7 @@
 }
 
 /* Return the bit position of the most significant 1 bit in a word */
-static __inline__ int __ilog2(unsigned int x)
+static __inline__ int __ilog2(unsigned long x)
 {
 	int lz;
 
@@ -238,7 +238,7 @@
 	return 31 - lz;
 }
 
-static __inline__ int ffz(unsigned int x)
+static __inline__ int ffz(unsigned long x)
 {
 	if ((x = ~x) == 0)
 		return 32;
@@ -296,7 +296,7 @@
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-static __inline__ unsigned long find_next_bit(void *addr,
+static __inline__ unsigned long find_next_bit(unsigned long *addr,
 	unsigned long size, unsigned long offset)
 {
 	unsigned int *p = ((unsigned int *) addr) + (offset >> 5);
@@ -353,7 +353,7 @@
 #define find_first_zero_bit(addr, size) \
 	find_next_zero_bit((addr), (size), 0)
 
-static __inline__ unsigned long find_next_zero_bit(void * addr,
+static __inline__ unsigned long find_next_zero_bit(unsigned long * addr,
 	unsigned long size, unsigned long offset)
 {
 	unsigned int * p = ((unsigned int *) addr) + (offset >> 5);
