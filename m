Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130658AbRCEH5I>; Mon, 5 Mar 2001 02:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130660AbRCEH47>; Mon, 5 Mar 2001 02:56:59 -0500
Received: from atlrel1.hp.com ([156.153.255.210]:45564 "HELO atlrel1.hp.com")
	by vger.kernel.org with SMTP id <S130658AbRCEH4r>;
	Mon, 5 Mar 2001 02:56:47 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation for bitops
Message-Id: <E14ZprK-0000hC-00@chrysl>
From: Matthew Wilcox <willy@ldl.fc.hp.com>
Date: Mon, 05 Mar 2001 00:56:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is just the kernel-doc parts; the .tmpl file entry is missing until
i get the chance to sync up with Alan again.

--- linux-2.4.2/include/asm-i386/bitops.h	Wed Feb 21 17:09:56 2001
+++ linux-willy/include/asm-i386/bitops.h	Mon Mar  5 00:39:28 2001
@@ -23,6 +23,16 @@
 
 #define ADDR (*(volatile long *) addr)
 
+/**
+ * set_bit - Atomically set a bit in memory
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * This function is atomic and may not be reordered.  See __set_bit()
+ * if you do not require the atomic guarantees.
+ * Note that @nr may be almost arbitrarily large; this function is not
+ * restricted to acting on a single-word quantity.
+ */
 static __inline__ void set_bit(int nr, volatile void * addr)
 {
 	__asm__ __volatile__( LOCK_PREFIX
@@ -31,7 +41,15 @@
 		:"Ir" (nr));
 }
 
-/* WARNING: non atomic and it can be reordered! */
+/**
+ * __set_bit - Set a bit in memory
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * Unlike set_bit(), this function is non-atomic and may be reordered.
+ * If it's called on the same region of memory simultaneously, the effect
+ * may be that only one operation succeeds.
+ */
 static __inline__ void __set_bit(int nr, volatile void * addr)
 {
 	__asm__(
@@ -40,11 +58,16 @@
 		:"Ir" (nr));
 }
 
-/*
- * clear_bit() doesn't provide any barrier for the compiler.
+/**
+ * clear_bit - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ *
+ * clear_bit() is atomic and may not be reordered.  However, it does
+ * not contain a memory barrier, so if it is used for locking purposes,
+ * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
+ * in order to ensure changes are visible on other processors.
  */
-#define smp_mb__before_clear_bit()	barrier()
-#define smp_mb__after_clear_bit()	barrier()
 static __inline__ void clear_bit(int nr, volatile void * addr)
 {
 	__asm__ __volatile__( LOCK_PREFIX
@@ -52,7 +75,18 @@
 		:"=m" (ADDR)
 		:"Ir" (nr));
 }
+#define smp_mb__before_clear_bit()	barrier()
+#define smp_mb__after_clear_bit()	barrier()
 
+/**
+ * change_bit - Toggle a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ *
+ * change_bit() is atomic and may not be reordered.
+ * Note that @nr may be almost arbitrarily large; this function is not
+ * restricted to acting on a single-word quantity.
+ */
 static __inline__ void change_bit(int nr, volatile void * addr)
 {
 	__asm__ __volatile__( LOCK_PREFIX
@@ -61,10 +95,13 @@
 		:"Ir" (nr));
 }
 
-/*
- * It will also imply a memory barrier, thus it must clobber memory
- * to make sure to reload anything that was cached into registers
- * outside _this_ critical section.
+/**
+ * test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.  
+ * It also implies a memory barrier.
  */
 static __inline__ int test_and_set_bit(int nr, volatile void * addr)
 {
@@ -77,7 +114,15 @@
 	return oldbit;
 }
 
-/* WARNING: non atomic and it can be reordered! */
+/**
+ * __test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is non-atomic and can be reordered.  
+ * If two examples of this operation race, one can appear to succeed
+ * but actually fail.  You must protect multiple accesses with a lock.
+ */
 static __inline__ int __test_and_set_bit(int nr, volatile void * addr)
 {
 	int oldbit;
@@ -89,6 +134,14 @@
 	return oldbit;
 }
 
+/**
+ * test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.  
+ * It also implies a memory barrier.
+ */
 static __inline__ int test_and_clear_bit(int nr, volatile void * addr)
 {
 	int oldbit;
@@ -100,7 +153,15 @@
 	return oldbit;
 }
 
-/* WARNING: non atomic and it can be reordered! */
+/**
+ * __test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is non-atomic and can be reordered.  
+ * If two examples of this operation race, one can appear to succeed
+ * but actually fail.  You must protect multiple accesses with a lock.
+ */
 static __inline__ int __test_and_clear_bit(int nr, volatile void * addr)
 {
 	int oldbit;
@@ -112,6 +173,14 @@
 	return oldbit;
 }
 
+/**
+ * test_and_change_bit - Change a bit and return its new value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.  
+ * It also implies a memory barrier.
+ */
 static __inline__ int test_and_change_bit(int nr, volatile void * addr)
 {
 	int oldbit;
@@ -123,9 +192,15 @@
 	return oldbit;
 }
 
-/*
- * This routine doesn't need to be atomic.
+#if 0 /* Fool kernel-doc since it doesn't do macros yet */
+/**
+ * test_bit - Determine whether a bit is set
+ * @nr: bit number to test
+ * @addr: Address to start counting from
  */
+static int test_bit(int nr, const volatile void * addr);
+#endif
+
 static __inline__ int constant_test_bit(int nr, const volatile void * addr)
 {
 	return ((1UL << (nr & 31)) & (((const volatile unsigned int *) addr)[nr >> 5])) != 0;
@@ -147,8 +222,13 @@
  constant_test_bit((nr),(addr)) : \
  variable_test_bit((nr),(addr)))
 
-/*
- * Find-bit routines..
+/**
+ * find_first_zero_bit - find the first zero bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The maximum size to search
+ *
+ * Returns the bit-number of the first zero bit, not the number of the byte
+ * containing a bit.
  */
 static __inline__ int find_first_zero_bit(void * addr, unsigned size)
 {
@@ -174,6 +254,12 @@
 	return res;
 }
 
+/**
+ * find_next_zero_bit - find the first zero bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The maximum size to search
+ */
 static __inline__ int find_next_zero_bit (void * addr, int size, int offset)
 {
 	unsigned long * p = ((unsigned long *) addr) + (offset >> 5);
@@ -201,9 +287,11 @@
 	return (offset + set + res);
 }
 
-/*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
+/**
+ * ffz - find first zero in word.
+ * @word: The word to search
+ *
+ * Undefined if no zero exists, so code should check against ~0UL first.
  */
 static __inline__ unsigned long ffz(unsigned long word)
 {
@@ -215,12 +303,14 @@
 
 #ifdef __KERNEL__
 
-/*
- * ffs: find first bit set. This is defined the same way as
+/**
+ * ffs - find first bit set
+ * @x: the word to search
+ *
+ * This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-
 static __inline__ int ffs(int x)
 {
 	int r;
@@ -232,9 +322,11 @@
 	return r+1;
 }
 
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
+/**
+ * hweightN - returns the hamming weight of a N-bit word
+ * @x: the word to weigh
+ *
+ * The Hamming Weight of a number is the total number of bits set in it.
  */
 
 #define hweight32(x) generic_hweight32(x)
