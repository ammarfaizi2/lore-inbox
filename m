Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267343AbUIJJtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267343AbUIJJtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUIJJtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:49:51 -0400
Received: from mail.renesas.com ([202.234.163.13]:40857 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S267343AbUIJJps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:45:48 -0400
Date: Fri, 10 Sep 2004 18:45:33 +0900 (JST)
Message-Id: <20040910.184533.350532260.takata.hirokazu@renesas.com>
To: akpm@osdl.org, hugh@veritas.com
Cc: wli@holomorphy.com, kaigai@ak.jp.nec.com, takata.hirokazu@renesas.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.9-rc1-mm4] [m32r] atomic_inc_return for m32r (Re:
 atomic_inc_return)
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here's a patch for m32r atomic.h against 2.6.9-rc1-mm4.
Please apply this.

	* include/asm-m32r/atomic.h:
	- Add atomic_inc_return(), atomic_dec_return(), atomic_add_return(),
	  atomic_sub_return() and atomic_clear_mask().

	- Change atomic_sub_and_test(), atomic_inc_and_test() and 
	  atomic_dec_and_test() from functions to macros.

	- Update comments, etc.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>


diff -rup linux-2.6.9-rc1-mm4.orig/include/asm-m32r/atomic.h linux-2.6.9-rc1-mm4.atomic_inc_return/include/asm-m32r/atomic.h
--- linux-2.6.9-rc1-mm4.orig/include/asm-m32r/atomic.h	2004-09-08 08:14:17.000000000 +0900
+++ linux-2.6.9-rc1-mm4.atomic_inc_return/include/asm-m32r/atomic.h	2004-09-10 18:08:39.000000000 +0900
@@ -1,14 +1,12 @@
 #ifndef _ASM_M32R_ATOMIC_H
 #define _ASM_M32R_ATOMIC_H
 
-/* $Id$ */
-
 /*
  *  linux/include/asm-m32r/atomic.h
- *    orig : i386 2.4.10
  *
  *  M32R version:
  *    Copyright (C) 2001, 2002  Hitoshi Yamamoto
+ *    Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
  */
 
 #include <linux/config.h>
@@ -42,8 +40,7 @@ typedef struct { volatile int counter; }
  * atomic_read - read atomic variable
  * @v: pointer of type atomic_t
  *
- * Atomically reads the value of @v.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically reads the value of @v.
  */
 #define atomic_read(v)	((v)->counter)
 
@@ -52,8 +49,7 @@ typedef struct { volatile int counter; }
  * @v: pointer of type atomic_t
  * @i: required value
  *
- * Atomically sets the value of @v to @i.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically sets the value of @v to @i.
  */
 #define atomic_set(v,i)	(((v)->counter) = (i))
 
@@ -62,10 +58,9 @@ typedef struct { volatile int counter; }
  * @i: integer value to add
  * @v: pointer of type atomic_t
  *
- * Atomically adds @i to @v.  Note that the guaranteed useful range
- * of an atomic_t is only 24 bits.
+ * Atomically adds @i to @v.
  */
-static __inline__ void atomic_add(int i, atomic_t *v)
+static inline void atomic_add(int i, atomic_t *v)
 {
 	unsigned long flags;
 
@@ -91,10 +86,9 @@ static __inline__ void atomic_add(int i,
  * @i: integer value to subtract
  * @v: pointer of type atomic_t
  *
- * Atomically subtracts @i from @v.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically subtracts @i from @v.
  */
-static __inline__ void atomic_sub(int i, atomic_t *v)
+static inline void atomic_sub(int i, atomic_t *v)
 {
 	unsigned long flags;
 
@@ -116,23 +110,51 @@ static __inline__ void atomic_sub(int i,
 }
 
 /**
- * atomic_sub_and_test - subtract value from variable and test result
+ * atomic_add_return - add integer to atomic variable and return
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically adds @i to @v and return (@i + @v).
+ */
+static inline int atomic_add_return(int i, atomic_t *v)
+{
+	unsigned long flags;
+	int result;
+
+	local_irq_save(flags);
+	__asm__ __volatile__ (
+		"# atomic_add			\n\t"
+		DCACHE_CLEAR("%0", "r4", "%1")
+		LOAD"	%0, @%1;		\n\t"
+		"add	%0, %2;			\n\t"
+		STORE"	%0, @%1;		\n\t"
+		: "=&r" (result)
+		: "r" (&v->counter), "r" (i)
+		: "memory"
+#ifdef CONFIG_CHIP_M32700_TS1
+		, "r4"
+#endif	/* CONFIG_CHIP_M32700_TS1 */
+	);
+	local_irq_restore(flags);
+
+	return result;
+}
+
+/**
+ * atomic_sub_return - subtract the atomic variable and return
  * @i: integer value to subtract
  * @v: pointer of type atomic_t
  *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically subtracts @i from @v and return (@v - @i).
  */
-static __inline__ int atomic_sub_and_test(int i, atomic_t *v)
+static inline int atomic_sub_return(int i, atomic_t *v)
 {
 	unsigned long flags;
 	int result;
 
 	local_irq_save(flags);
 	__asm__ __volatile__ (
-		"# atomic_sub_and_test		\n\t"
+		"# atomic_sub			\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
 		LOAD"	%0, @%1;		\n\t"
 		"sub	%0, %2;			\n\t"
@@ -146,17 +168,27 @@ static __inline__ int atomic_sub_and_tes
 	);
 	local_irq_restore(flags);
 
-	return (result == 0);
+	return result;
 }
 
 /**
+ * atomic_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
+
+/**
  * atomic_inc - increment atomic variable
  * @v: pointer of type atomic_t
  *
- * Atomically increments @v by 1.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically increments @v by 1.
  */
-static __inline__ void atomic_inc(atomic_t *v)
+static inline void atomic_inc(atomic_t *v)
 {
 	unsigned long flags;
 
@@ -181,10 +213,9 @@ static __inline__ void atomic_inc(atomic
  * atomic_dec - decrement atomic variable
  * @v: pointer of type atomic_t
  *
- * Atomically decrements @v by 1.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically decrements @v by 1.
  */
-static __inline__ void atomic_dec(atomic_t *v)
+static inline void atomic_dec(atomic_t *v)
 {
 	unsigned long flags;
 
@@ -206,15 +237,12 @@ static __inline__ void atomic_dec(atomic
 }
 
 /**
- * atomic_dec_and_test - decrement and test
+ * atomic_inc_return - increment atomic variable and return
  * @v: pointer of type atomic_t
  *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically increments @v by 1 and returns the result.
  */
-static __inline__ int atomic_dec_and_test(atomic_t *v)
+static inline int atomic_inc_return(atomic_t *v)
 {
 	unsigned long flags;
 	int result;
@@ -224,7 +252,7 @@ static __inline__ int atomic_dec_and_tes
 		"# atomic_dec_and_test		\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
 		LOAD"	%0, @%1;		\n\t"
-		"addi	%0, #-1;		\n\t"
+		"addi	%0, #1;			\n\t"
 		STORE"	%0, @%1;		\n\t"
 		: "=&r" (result)
 		: "r" (&v->counter)
@@ -235,19 +263,16 @@ static __inline__ int atomic_dec_and_tes
 	);
 	local_irq_restore(flags);
 
-	return (result == 0);
+	return result;
 }
 
 /**
- * atomic_inc_and_test - increment and test
+ * atomic_dec_return - decrement atomic variable and return
  * @v: pointer of type atomic_t
  *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically decrements @v by 1 and returns the result.
  */
-static __inline__ int atomic_inc_and_test(atomic_t *v)
+static inline int atomic_dec_return(atomic_t *v)
 {
 	unsigned long flags;
 	int result;
@@ -257,7 +282,7 @@ static __inline__ int atomic_inc_and_tes
 		"# atomic_dec_and_test		\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
 		LOAD"	%0, @%1;		\n\t"
-		"addi	%0, #1;			\n\t"
+		"addi	%0, #-1;		\n\t"
 		STORE"	%0, @%1;		\n\t"
 		: "=&r" (result)
 		: "r" (&v->counter)
@@ -268,45 +293,62 @@ static __inline__ int atomic_inc_and_tes
 	);
 	local_irq_restore(flags);
 
-	return (result == 0);
+	return result;
 }
 
 /**
+ * atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+
+/**
+ * atomic_dec_and_test - decrement and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all
+ * other cases.
+ */
+#define atomic_dec_and_test(v) (atomic_dec_return(v) == 0)
+
+/**
  * atomic_add_negative - add and test if negative
  * @v: pointer of type atomic_t
  * @i: integer value to add
  *
  * Atomically adds @i to @v and returns true
  * if the result is negative, or false when
- * result is greater than or equal to zero.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * result is greater than or equal to zero.
  */
-static __inline__ int atomic_add_negative(int i, atomic_t *v)
+#define atomic_add_negative(i,v) (atomic_add_return((i), (v)) < 0)
+
+static inline void atomic_clear_mask(unsigned long  mask, atomic_t *addr)
 {
 	unsigned long flags;
-	int result;
 
 	local_irq_save(flags);
 	__asm__ __volatile__ (
-		"# atomic_add_negative		\n\t"
-		DCACHE_CLEAR("%0", "r4", "%1")
-		LOAD"	%0, @%1;		\n\t"
-		"add	%0, %2;			\n\t"
-		STORE"	%0, @%1;		\n\t"
-		: "=&r" (result)
-		: "r" (&v->counter), "r" (i)
-		: "memory"
+		"# atomic_set_mask		\n\t"
+		DCACHE_CLEAR("r4", "r5", "%0")
+		LOAD"	r4, @%0;		\n\t"
+		"and	r4, %1;			\n\t"
+		STORE"	r4, @%0;		\n\t"
+		: /* no outputs */
+		: "r" (addr), "r" (~mask)
+		: "memory", "r4"
 #ifdef CONFIG_CHIP_M32700_TS1
-		, "r4"
+		, "r5"
 #endif	/* CONFIG_CHIP_M32700_TS1 */
 	);
 	local_irq_restore(flags);
-
-	return (result < 0);
 }
 
-/* These are x86-specific, used by some header files */
-static __inline__ void atomic_set_mask(unsigned long  mask, atomic_t *addr)
+static inline void atomic_set_mask(unsigned long  mask, atomic_t *addr)
 {
 	unsigned long flags;
 
@@ -327,7 +369,7 @@ static __inline__ void atomic_set_mask(u
 	local_irq_restore(flags);
 }
 
-/* Atomic operations are already serializing on x86 */
+/* Atomic operations are already serializing on m32r */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
 #define smp_mb__before_atomic_inc()	barrier()

--
Hirokazu Takata (takata@linux-m32r.org)
Linux/M32R project:  http://www.linux-m32r.org/
