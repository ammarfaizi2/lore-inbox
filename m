Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbULQMPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbULQMPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 07:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbULQMPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 07:15:13 -0500
Received: from mail.renesas.com ([202.234.163.13]:64728 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262791AbULQMNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 07:13:21 -0500
Date: Fri, 17 Dec 2004 21:13:03 +0900 (JST)
Message-Id: <20041217.211303.582765980.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Make kernel headers for mutual
 exclusion publishable to userland
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch to update kernel headers for mutual exclusion,
atomic.h, bitops.h and semaphore.h of m32r.
This patch is for making these headers publishable to userland.

	* include/asm-m32r/assembler.h (M32R_LOCK, M32R_UNLOCK):
	  Define M32R_LOCK and M32R_UNLOCK macros. For SMP configuration,
	  these macros are expanded to m32r's LOCK and UNLOCK instructions.
	  While, for UP configuration, these are simply expanded to m32r's 
	  LD(load) and ST(store) instructions, respectively.

	* include/asm-m32r/atomic.h, include/asm-m32r/bitops.h,
	  include/asm-m32r/semaphore.h:
	  - Change macros from LOAD and STORE to M32R_LOCK and M32R_UNLOCK,
	    respectively.  It is because LOAD and STORE are too generic words.
	  - Change inline to __inline__.
	    Retrieve __inline__ modifiers for functions which are placed
	    outside of __KERNEL__ region in these headers, because those
	    functions might be included and used from ISO C program in
	    userland.

Currently, it seems that these headers are allowed to be included from
userland.  Indeed, they are kernel stuff, but these headers provide
useful definitions and functions even for userland applications, I think.

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/assembler.h |   35 ++++++++++++------
 include/asm-m32r/atomic.h    |   48 ++++++++++---------------
 include/asm-m32r/bitops.h    |   81 +++++++++++++++++--------------------------
 include/asm-m32r/semaphore.h |   27 ++++----------
 4 files changed, 85 insertions(+), 106 deletions(-)


diff -ruNp a/include/asm-m32r/assembler.h b/include/asm-m32r/assembler.h
--- a/include/asm-m32r/assembler.h	2004-10-19 06:53:06.000000000 +0900
+++ b/include/asm-m32r/assembler.h	2004-12-16 11:50:30.000000000 +0900
@@ -1,20 +1,33 @@
 #ifndef _ASM_M32R_ASSEMBLER_H
 #define _ASM_M32R_ASSEMBLER_H
 
-/* $Id$ */
-
 /*
  * linux/asm-m32r/assembler.h
  *
- * This file contains M32R architecture specific defines.
+ * Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
  *
- * Do not include any C declarations in this file - it is included by
- * assembler source.
+ * This file contains M32R architecture specific macro definitions.
  */
 
 #include <linux/config.h>
 
+#ifndef __STR
+#ifdef __ASSEMBLY__
+#define __STR(x) x
+#else
+#define __STR(x) #x
+#endif
+#endif /* __STR */
+
+#ifdef CONFIG_SMP
+#define M32R_LOCK	__STR(lock)
+#define M32R_UNLOCK	__STR(unlock)
+#else
+#define M32R_LOCK	__STR(ld)
+#define M32R_UNLOCK	__STR(st)
+#endif
 
+#ifdef __ASSEMBLY__
 #undef ENTRY
 #define ENTRY(name) ENTRY_M name
 	.macro  ENTRY_M name
@@ -22,12 +35,13 @@
 	ALIGN
 \name:
 	.endm
+#endif
 
-/*
- * LDIMM: load immediate value
- *
- * STI: enable interruption
- * CLI: disable interruption
+
+/**
+ * LDIMM - load immediate value
+ * STI - enable interruption
+ * CLI - disable interruption
  */
 
 #ifdef __ASSEMBLY__
@@ -209,4 +223,3 @@
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* _ASM_M32R_ASSEMBLER_H */
-
diff -ruNp a/include/asm-m32r/atomic.h b/include/asm-m32r/atomic.h
--- a/include/asm-m32r/atomic.h	2004-10-19 06:54:08.000000000 +0900
+++ b/include/asm-m32r/atomic.h	2004-12-16 11:50:30.000000000 +0900
@@ -10,6 +10,7 @@
  */
 
 #include <linux/config.h>
+#include <asm/assembler.h>
 #include <asm/system.h>
 
 /*
@@ -17,16 +18,6 @@
  * resource counting etc..
  */
 
-#undef LOAD
-#undef STORE
-#ifdef CONFIG_SMP
-#define LOAD	"lock"
-#define STORE	"unlock"
-#else
-#define LOAD	"ld"
-#define STORE	"st"
-#endif
-
 /*
  * Make sure gcc doesn't try to be clever and move things around
  * on us. We need to use _exactly_ the address the user gave us,
@@ -60,7 +51,7 @@ typedef struct { volatile int counter; }
  *
  * Atomically adds @i to @v and return (@i + @v).
  */
-static inline int atomic_add_return(int i, atomic_t *v)
+static __inline__ int atomic_add_return(int i, atomic_t *v)
 {
 	unsigned long flags;
 	int result;
@@ -69,9 +60,9 @@ static inline int atomic_add_return(int 
 	__asm__ __volatile__ (
 		"# atomic_add_return		\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
-		LOAD"	%0, @%1;		\n\t"
+		M32R_LOCK" %0, @%1;		\n\t"
 		"add	%0, %2;			\n\t"
-		STORE"	%0, @%1;		\n\t"
+		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (result)
 		: "r" (&v->counter), "r" (i)
 		: "memory"
@@ -91,7 +82,7 @@ static inline int atomic_add_return(int 
  *
  * Atomically subtracts @i from @v and return (@v - @i).
  */
-static inline int atomic_sub_return(int i, atomic_t *v)
+static __inline__ int atomic_sub_return(int i, atomic_t *v)
 {
 	unsigned long flags;
 	int result;
@@ -100,9 +91,9 @@ static inline int atomic_sub_return(int 
 	__asm__ __volatile__ (
 		"# atomic_sub_return		\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
-		LOAD"	%0, @%1;		\n\t"
+		M32R_LOCK" %0, @%1;		\n\t"
 		"sub	%0, %2;			\n\t"
-		STORE"	%0, @%1;		\n\t"
+		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (result)
 		: "r" (&v->counter), "r" (i)
 		: "memory"
@@ -150,7 +141,7 @@ static inline int atomic_sub_return(int 
  *
  * Atomically increments @v by 1 and returns the result.
  */
-static inline int atomic_inc_return(atomic_t *v)
+static __inline__ int atomic_inc_return(atomic_t *v)
 {
 	unsigned long flags;
 	int result;
@@ -159,9 +150,9 @@ static inline int atomic_inc_return(atom
 	__asm__ __volatile__ (
 		"# atomic_inc_return		\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
-		LOAD"	%0, @%1;		\n\t"
+		M32R_LOCK" %0, @%1;		\n\t"
 		"addi	%0, #1;			\n\t"
-		STORE"	%0, @%1;		\n\t"
+		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (result)
 		: "r" (&v->counter)
 		: "memory"
@@ -180,7 +171,7 @@ static inline int atomic_inc_return(atom
  *
  * Atomically decrements @v by 1 and returns the result.
  */
-static inline int atomic_dec_return(atomic_t *v)
+static __inline__ int atomic_dec_return(atomic_t *v)
 {
 	unsigned long flags;
 	int result;
@@ -189,9 +180,9 @@ static inline int atomic_dec_return(atom
 	__asm__ __volatile__ (
 		"# atomic_dec_return		\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
-		LOAD"	%0, @%1;		\n\t"
+		M32R_LOCK" %0, @%1;		\n\t"
 		"addi	%0, #-1;		\n\t"
-		STORE"	%0, @%1;		\n\t"
+		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (result)
 		: "r" (&v->counter)
 		: "memory"
@@ -251,7 +242,7 @@ static inline int atomic_dec_return(atom
  */
 #define atomic_add_negative(i,v) (atomic_add_return((i), (v)) < 0)
 
-static inline void atomic_clear_mask(unsigned long  mask, atomic_t *addr)
+static __inline__ void atomic_clear_mask(unsigned long  mask, atomic_t *addr)
 {
 	unsigned long flags;
 	unsigned long tmp;
@@ -260,9 +251,9 @@ static inline void atomic_clear_mask(uns
 	__asm__ __volatile__ (
 		"# atomic_clear_mask		\n\t"
 		DCACHE_CLEAR("%0", "r5", "%1")
-		LOAD"	%0, @%1;		\n\t"
+		M32R_LOCK" %0, @%1;		\n\t"
 		"and	%0, %2;			\n\t"
-		STORE"	%0, @%1;		\n\t"
+		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (tmp)
 		: "r" (addr), "r" (~mask)
 		: "memory"
@@ -273,7 +264,7 @@ static inline void atomic_clear_mask(uns
 	local_irq_restore(flags);
 }
 
-static inline void atomic_set_mask(unsigned long  mask, atomic_t *addr)
+static __inline__ void atomic_set_mask(unsigned long  mask, atomic_t *addr)
 {
 	unsigned long flags;
 	unsigned long tmp;
@@ -282,9 +273,9 @@ static inline void atomic_set_mask(unsig
 	__asm__ __volatile__ (
 		"# atomic_set_mask		\n\t"
 		DCACHE_CLEAR("%0", "r5", "%1")
-		LOAD"	%0, @%1;		\n\t"
+		M32R_LOCK" %0, @%1;		\n\t"
 		"or	%0, %2;			\n\t"
-		STORE"	%0, @%1;		\n\t"
+		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (tmp)
 		: "r" (addr), "r" (mask)
 		: "memory"
@@ -302,4 +293,3 @@ static inline void atomic_set_mask(unsig
 #define smp_mb__after_atomic_inc()	barrier()
 
 #endif	/* _ASM_M32R_ATOMIC_H */
-
diff -ruNp a/include/asm-m32r/bitops.h b/include/asm-m32r/bitops.h
--- a/include/asm-m32r/bitops.h	2004-10-19 06:54:31.000000000 +0900
+++ b/include/asm-m32r/bitops.h	2004-12-16 11:50:30.000000000 +0900
@@ -13,6 +13,7 @@
 
 #include <linux/config.h>
 #include <linux/compiler.h>
+#include <asm/assembler.h>
 #include <asm/system.h>
 #include <asm/byteorder.h>
 #include <asm/types.h>
@@ -25,18 +26,6 @@
  * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
  */
 
-#undef LOAD
-#undef STORE
-#ifdef CONFIG_SMP
-#define LOAD	"lock"
-#define STORE	"unlock"
-#else
-#define LOAD	"ld"
-#define STORE	"st"
-#endif
-
-/* #define ADDR (*(volatile long *) addr) */
-
 /**
  * set_bit - Atomically set a bit in memory
  * @nr: the bit to set
@@ -47,7 +36,7 @@
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void set_bit(int nr, volatile void * addr)
+static __inline__ void set_bit(int nr, volatile void * addr)
 {
 	__u32 mask;
 	volatile __u32 *a = addr;
@@ -60,9 +49,9 @@ static inline void set_bit(int nr, volat
 	local_irq_save(flags);
 	__asm__ __volatile__ (
 		DCACHE_CLEAR("%0", "r6", "%1")
-		LOAD"	%0, @%1;		\n\t"
+		M32R_LOCK" %0, @%1;		\n\t"
 		"or	%0, %2;			\n\t"
-		STORE"	%0, @%1;		\n\t"
+		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (tmp)
 		: "r" (a), "r" (mask)
 		: "memory"
@@ -82,7 +71,7 @@ static inline void set_bit(int nr, volat
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static inline void __set_bit(int nr, volatile void * addr)
+static __inline__ void __set_bit(int nr, volatile void * addr)
 {
 	__u32 mask;
 	volatile __u32 *a = addr;
@@ -102,7 +91,7 @@ static inline void __set_bit(int nr, vol
  * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
  * in order to ensure changes are visible on other processors.
  */
-static inline void clear_bit(int nr, volatile void * addr)
+static __inline__ void clear_bit(int nr, volatile void * addr)
 {
 	__u32 mask;
 	volatile __u32 *a = addr;
@@ -116,9 +105,9 @@ static inline void clear_bit(int nr, vol
 
 	__asm__ __volatile__ (
 		DCACHE_CLEAR("%0", "r6", "%1")
-		LOAD"	%0, @%1;		\n\t"
+		M32R_LOCK" %0, @%1;		\n\t"
 		"and	%0, %2;			\n\t"
-		STORE"	%0, @%1;		\n\t"
+		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (tmp)
 		: "r" (a), "r" (~mask)
 		: "memory"
@@ -129,7 +118,7 @@ static inline void clear_bit(int nr, vol
 	local_irq_restore(flags);
 }
 
-static inline void __clear_bit(int nr, volatile unsigned long * addr)
+static __inline__ void __clear_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask;
 	volatile unsigned long *a = addr;
@@ -151,7 +140,7 @@ static inline void __clear_bit(int nr, v
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static inline void __change_bit(int nr, volatile void * addr)
+static __inline__ void __change_bit(int nr, volatile void * addr)
 {
 	__u32 mask;
 	volatile __u32 *a = addr;
@@ -170,7 +159,7 @@ static inline void __change_bit(int nr, 
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void change_bit(int nr, volatile void * addr)
+static __inline__ void change_bit(int nr, volatile void * addr)
 {
 	__u32  mask;
 	volatile __u32  *a = addr;
@@ -183,9 +172,9 @@ static inline void change_bit(int nr, vo
 	local_irq_save(flags);
 	__asm__ __volatile__ (
 		DCACHE_CLEAR("%0", "r6", "%1")
-		LOAD"	%0, @%1;		\n\t"
+		M32R_LOCK" %0, @%1;		\n\t"
 		"xor	%0, %2;			\n\t"
-		STORE"	%0, @%1;		\n\t"
+		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (tmp)
 		: "r" (a), "r" (mask)
 		: "memory"
@@ -204,7 +193,7 @@ static inline void change_bit(int nr, vo
  * This operation is atomic and cannot be reordered.
  * It also implies a memory barrier.
  */
-static inline int test_and_set_bit(int nr, volatile void * addr)
+static __inline__ int test_and_set_bit(int nr, volatile void * addr)
 {
 	__u32 mask, oldbit;
 	volatile __u32 *a = addr;
@@ -217,11 +206,11 @@ static inline int test_and_set_bit(int n
 	local_irq_save(flags);
 	__asm__ __volatile__ (
 		DCACHE_CLEAR("%0", "%1", "%2")
-		LOAD"	%0, @%2;		\n\t"
+		M32R_LOCK" %0, @%2;		\n\t"
 		"mv	%1, %0;			\n\t"
 		"and	%0, %3;			\n\t"
 		"or	%1, %3;			\n\t"
-		STORE"	%1, @%2;		\n\t"
+		M32R_UNLOCK" %1, @%2;		\n\t"
 		: "=&r" (oldbit), "=&r" (tmp)
 		: "r" (a), "r" (mask)
 		: "memory"
@@ -240,7 +229,7 @@ static inline int test_and_set_bit(int n
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_set_bit(int nr, volatile void * addr)
+static __inline__ int __test_and_set_bit(int nr, volatile void * addr)
 {
 	__u32 mask, oldbit;
 	volatile __u32 *a = addr;
@@ -261,7 +250,7 @@ static inline int __test_and_set_bit(int
  * This operation is atomic and cannot be reordered.
  * It also implies a memory barrier.
  */
-static inline int test_and_clear_bit(int nr, volatile void * addr)
+static __inline__ int test_and_clear_bit(int nr, volatile void * addr)
 {
 	__u32 mask, oldbit;
 	volatile __u32 *a = addr;
@@ -275,12 +264,12 @@ static inline int test_and_clear_bit(int
 
 	__asm__ __volatile__ (
 		DCACHE_CLEAR("%0", "%1", "%3")
-		LOAD"	%0, @%3;		\n\t"
-		"mv	%1, %0; \n\t"
-		"and	%0, %2; \n\t"
-		"not	%2, %2; \n\t"
-		"and	%1, %2; \n\t"
-		STORE"	%1, @%3;		\n\t"
+		M32R_LOCK" %0, @%3;		\n\t"
+		"mv	%1, %0;			\n\t"
+		"and	%0, %2;			\n\t"
+		"not	%2, %2;			\n\t"
+		"and	%1, %2;			\n\t"
+		M32R_UNLOCK" %1, @%3;		\n\t"
 		: "=&r" (oldbit), "=&r" (tmp), "+r" (mask)
 		: "r" (a)
 		: "memory"
@@ -299,7 +288,7 @@ static inline int test_and_clear_bit(int
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_clear_bit(int nr, volatile void * addr)
+static __inline__ int __test_and_clear_bit(int nr, volatile void * addr)
 {
 	__u32 mask, oldbit;
 	volatile __u32 *a = addr;
@@ -313,7 +302,7 @@ static inline int __test_and_clear_bit(i
 }
 
 /* WARNING: non atomic and it can be reordered! */
-static inline int __test_and_change_bit(int nr, volatile void * addr)
+static __inline__ int __test_and_change_bit(int nr, volatile void * addr)
 {
 	__u32 mask, oldbit;
 	volatile __u32 *a = addr;
@@ -334,7 +323,7 @@ static inline int __test_and_change_bit(
  * This operation is atomic and cannot be reordered.
  * It also implies a memory barrier.
  */
-static inline int test_and_change_bit(int nr, volatile void * addr)
+static __inline__ int test_and_change_bit(int nr, volatile void * addr)
 {
 	__u32 mask, oldbit;
 	volatile __u32 *a = addr;
@@ -347,11 +336,11 @@ static inline int test_and_change_bit(in
 	local_irq_save(flags);
 	__asm__ __volatile__ (
 		DCACHE_CLEAR("%0", "%1", "%2")
-		LOAD"	%0, @%2;		\n\t"
+		M32R_LOCK" %0, @%2;		\n\t"
 		"mv	%1, %0;			\n\t"
 		"and	%0, %3;			\n\t"
 		"xor	%1, %3;			\n\t"
-		STORE"	%1, @%2;		\n\t"
+		M32R_UNLOCK" %1, @%2;		\n\t"
 		: "=&r" (oldbit), "=&r" (tmp)
 		: "r" (a), "r" (mask)
 		: "memory"
@@ -361,16 +350,12 @@ static inline int test_and_change_bit(in
 	return (oldbit != 0);
 }
 
-#if 0 /* Fool kernel-doc since it doesn't do macros yet */
 /**
  * test_bit - Determine whether a bit is set
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
-static int test_bit(int nr, const volatile void * addr);
-#endif
-
-static inline int test_bit(int nr, const volatile void * addr)
+static __inline__ int test_bit(int nr, const volatile void * addr)
 {
 	__u32 mask;
 	const volatile __u32 *a = addr;
@@ -387,7 +372,7 @@ static inline int test_bit(int nr, const
  *
  * Undefined if no zero exists, so code should check against ~0UL first.
  */
-static inline unsigned long ffz(unsigned long word)
+static __inline__ unsigned long ffz(unsigned long word)
 {
 	int k;
 
@@ -420,7 +405,7 @@ static inline unsigned long ffz(unsigned
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-static inline int find_next_zero_bit(void *addr, int size, int offset)
+static __inline__ int find_next_zero_bit(void *addr, int size, int offset)
 {
 	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
 	unsigned long result = offset & ~31UL;
@@ -462,7 +447,7 @@ found_middle:
  *
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static inline unsigned long __ffs(unsigned long word)
+static __inline__ unsigned long __ffs(unsigned long word)
 {
 	int k = 0;
 
diff -ruNp a/include/asm-m32r/semaphore.h b/include/asm-m32r/semaphore.h
--- a/include/asm-m32r/semaphore.h	2004-10-19 06:53:43.000000000 +0900
+++ b/include/asm-m32r/semaphore.h	2004-12-16 11:50:30.000000000 +0900
@@ -15,19 +15,10 @@
 #include <linux/config.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
+#include <asm/assembler.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 
-#undef LOAD
-#undef STORE
-#ifdef CONFIG_SMP
-#define LOAD	"lock"
-#define STORE	"unlock"
-#else
-#define LOAD	"ld"
-#define STORE	"st"
-#endif
-
 struct semaphore {
 	atomic_t count;
 	int sleepers;
@@ -97,9 +88,9 @@ static inline void down(struct semaphore
 	__asm__ __volatile__ (
 		"# down				\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
-		LOAD"	%0, @%1;		\n\t"
+		M32R_LOCK" %0, @%1;		\n\t"
 		"addi	%0, #-1;		\n\t"
-		STORE"	%0, @%1;		\n\t"
+		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (count)
 		: "r" (&sem->count)
 		: "memory"
@@ -128,9 +119,9 @@ static inline int down_interruptible(str
 	__asm__ __volatile__ (
 		"# down_interruptible		\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
-		LOAD"	%0, @%1;		\n\t"
+		M32R_LOCK" %0, @%1;		\n\t"
 		"addi	%0, #-1;		\n\t"
-		STORE"	%0, @%1;		\n\t"
+		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (count)
 		: "r" (&sem->count)
 		: "memory"
@@ -160,9 +151,9 @@ static inline int down_trylock(struct se
 	__asm__ __volatile__ (
 		"# down_trylock			\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
-		LOAD"	%0, @%1;		\n\t"
+		M32R_LOCK" %0, @%1;		\n\t"
 		"addi	%0, #-1;		\n\t"
-		STORE"	%0, @%1;		\n\t"
+		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (count)
 		: "r" (&sem->count)
 		: "memory"
@@ -193,9 +184,9 @@ static inline void up(struct semaphore *
 	__asm__ __volatile__ (
 		"# up				\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
-		LOAD"	%0, @%1;		\n\t"
+		M32R_LOCK" %0, @%1;		\n\t"
 		"addi	%0, #1;			\n\t"
-		STORE"	%0, @%1;		\n\t"
+		M32R_UNLOCK" %0, @%1;		\n\t"
 		: "=&r" (count)
 		: "r" (&sem->count)
 		: "memory"

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
