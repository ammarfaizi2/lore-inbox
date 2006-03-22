Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWCVGmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWCVGmt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWCVGmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:42:15 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:31619 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750939AbWCVGif
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:38:35 -0500
Message-Id: <20060322063745.064004000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:30:45 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 05/35] Add sync bitops
Content-Disposition: inline; filename=04-synch-ops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add "always lock'd" implementations of set_bit, clear_bit and
change_bit and the corresponding test_and_ functions.  Also add
"always lock'd" implementation of cmpxchg.  These give guaranteed
strong synchronisation and are required for non-SMP kernels running on
an SMP hypervisor.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/asm-i386/bitops-fns.h |   97 +++++++++++++++++
 include/asm-i386/bitops.h     |  230 ++++++++++++++++--------------------------
 include/asm-i386/system.h     |   33 ++++++
 3 files changed, 222 insertions(+), 138 deletions(-)

--- xen-subarch-2.6.orig/include/asm-i386/bitops.h
+++ xen-subarch-2.6/include/asm-i386/bitops.h
@@ -24,6 +24,34 @@
 
 #define ADDR (*(volatile long *) addr)
 
+#define __LOCK_PREFIX LOCK_PREFIX
+#define __NAME(name) name
+#define __BARRIER : "memory"
+#include "bitops-fns.h"
+#undef __LOCK_PREFIX
+#undef __NAME
+#undef __BARRIER
+
+#define __LOCK_PREFIX
+#define __NAME(name) __##name
+#define __BARRIER
+#include "bitops-fns.h"
+#undef __LOCK_PREFIX
+#undef __NAME
+#undef __BARRIER
+
+#define __LOCK_PREFIX "lock ; "
+#define __NAME(name) synch_##name
+#define __BARRIER : "memory"
+#include "bitops-fns.h"
+#undef __LOCK_PREFIX
+#undef __NAME
+#undef __BARRIER
+
+#define smp_mb__before_clear_bit()	barrier()
+#define smp_mb__after_clear_bit()	barrier()
+
+#if 0 /* Fool kernel-doc */
 /**
  * set_bit - Atomically set a bit in memory
  * @nr: the bit to set
@@ -39,30 +67,7 @@
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void set_bit(int nr, volatile unsigned long * addr)
-{
-	__asm__ __volatile__( LOCK_PREFIX
-		"btsl %1,%0"
-		:"+m" (ADDR)
-		:"Ir" (nr));
-}
-
-/**
- * __set_bit - Set a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * Unlike set_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static inline void __set_bit(int nr, volatile unsigned long * addr)
-{
-	__asm__(
-		"btsl %1,%0"
-		:"+m" (ADDR)
-		:"Ir" (nr));
-}
+static inline void set_bit(int nr, volatile unsigned long *addr);
 
 /**
  * clear_bit - Clears a bit in memory
@@ -74,40 +79,7 @@ static inline void __set_bit(int nr, vol
  * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
  * in order to ensure changes are visible on other processors.
  */
-static inline void clear_bit(int nr, volatile unsigned long * addr)
-{
-	__asm__ __volatile__( LOCK_PREFIX
-		"btrl %1,%0"
-		:"+m" (ADDR)
-		:"Ir" (nr));
-}
-
-static inline void __clear_bit(int nr, volatile unsigned long * addr)
-{
-	__asm__ __volatile__(
-		"btrl %1,%0"
-		:"+m" (ADDR)
-		:"Ir" (nr));
-}
-#define smp_mb__before_clear_bit()	barrier()
-#define smp_mb__after_clear_bit()	barrier()
-
-/**
- * __change_bit - Toggle a bit in memory
- * @nr: the bit to change
- * @addr: the address to start counting from
- *
- * Unlike change_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static inline void __change_bit(int nr, volatile unsigned long * addr)
-{
-	__asm__ __volatile__(
-		"btcl %1,%0"
-		:"+m" (ADDR)
-		:"Ir" (nr));
-}
+static inline void clear_bit(int nr, volatile unsigned long *addr);
 
 /**
  * change_bit - Toggle a bit in memory
@@ -119,13 +91,7 @@ static inline void __change_bit(int nr, 
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void change_bit(int nr, volatile unsigned long * addr)
-{
-	__asm__ __volatile__( LOCK_PREFIX
-		"btcl %1,%0"
-		:"+m" (ADDR)
-		:"Ir" (nr));
-}
+static inline void change_bit(int nr, volatile unsigned long *addr);
 
 /**
  * test_and_set_bit - Set a bit and return its old value
@@ -136,56 +102,72 @@ static inline void change_bit(int nr, vo
  * It may be reordered on other architectures than x86.
  * It also implies a memory barrier.
  */
-static inline int test_and_set_bit(int nr, volatile unsigned long * addr)
-{
-	int oldbit;
-
-	__asm__ __volatile__( LOCK_PREFIX
-		"btsl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit),"+m" (ADDR)
-		:"Ir" (nr) : "memory");
-	return oldbit;
-}
+static inline int test_and_set_bit(int nr, volatile unsigned long *addr);
 
 /**
- * __test_and_set_bit - Set a bit and return its old value
- * @nr: Bit to set
+ * test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
  * @addr: Address to count from
  *
- * This operation is non-atomic and can be reordered.  
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
+ * This operation is atomic and cannot be reordered.
+ * It can be reordered on other architectures other than x86.
+ * It also implies a memory barrier.
  */
-static inline int __test_and_set_bit(int nr, volatile unsigned long * addr)
-{
-	int oldbit;
-
-	__asm__(
-		"btsl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit),"+m" (ADDR)
-		:"Ir" (nr));
-	return oldbit;
-}
+static inline int test_and_clear_bit(int nr, volatile unsigned long *addr);
 
 /**
- * test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to clear
+ * test_and_change_bit - Change a bit and return its old value
+ * @nr: Bit to change
  * @addr: Address to count from
  *
- * This operation is atomic and cannot be reordered.
- * It can be reorderdered on other architectures other than x86.
+ * This operation is atomic and cannot be reordered.  
  * It also implies a memory barrier.
  */
-static inline int test_and_clear_bit(int nr, volatile unsigned long * addr)
-{
-	int oldbit;
+static inline int test_and_change_bit(int nr, volatile unsigned long *addr);
 
-	__asm__ __volatile__( LOCK_PREFIX
-		"btrl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit),"+m" (ADDR)
-		:"Ir" (nr) : "memory");
-	return oldbit;
-}
+/**
+ * __set_bit - Set a bit in memory
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * Unlike set_bit(), this function is non-atomic and may be reordered.
+ * If it's called on the same region of memory simultaneously, the effect
+ * may be that only one operation succeeds.
+ */
+static inline void __set_bit(int nr, volatile unsigned long * addr);
+
+/**
+ * __clear_bit - Clear a bit in memory
+ * @nr: the bit to clear
+ * @addr: the address to start counting from
+ *
+ * Unlike clear_bit(), this function is non-atomic and may be reordered.
+ * If it's called on the same region of memory simultaneously, the effect
+ * may be that only one operation succeeds.
+ */
+static inline void __clear_bit(int nr, volatile unsigned long * addr);
+
+/**
+ * __change_bit - Toggle a bit in memory
+ * @nr: the bit to change
+ * @addr: the address to start counting from
+ *
+ * Unlike change_bit(), this function is non-atomic and may be reordered.
+ * If it's called on the same region of memory simultaneously, the effect
+ * may be that only one operation succeeds.
+ */
+static inline void __change_bit(int nr, volatile unsigned long * addr);
+
+/**
+ * __test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is non-atomic and can be reordered.  
+ * If two examples of this operation race, one can appear to succeed
+ * but actually fail.  You must protect multiple accesses with a lock.
+ */
+static inline int __test_and_set_bit(int nr, volatile unsigned long * addr);
 
 /**
  * __test_and_clear_bit - Clear a bit and return its old value
@@ -196,47 +178,19 @@ static inline int test_and_clear_bit(int
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
-{
-	int oldbit;
-
-	__asm__(
-		"btrl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit),"+m" (ADDR)
-		:"Ir" (nr));
-	return oldbit;
-}
-
-/* WARNING: non atomic and it can be reordered! */
-static inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
-{
-	int oldbit;
-
-	__asm__ __volatile__(
-		"btcl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit),"+m" (ADDR)
-		:"Ir" (nr) : "memory");
-	return oldbit;
-}
+static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr);
 
 /**
- * test_and_change_bit - Change a bit and return its old value
+ * __test_and_clear_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *
- * This operation is atomic and cannot be reordered.  
- * It also implies a memory barrier.
+ * This operation is non-atomic and can be reordered.  
+ * If two examples of this operation race, one can appear to succeed
+ * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int test_and_change_bit(int nr, volatile unsigned long* addr)
-{
-	int oldbit;
-
-	__asm__ __volatile__( LOCK_PREFIX
-		"btcl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit),"+m" (ADDR)
-		:"Ir" (nr) : "memory");
-	return oldbit;
-}
+static inline int __test_and_change_bit(int nr, volatile unsigned long *addr);
+#endif
 
 #if 0 /* Fool kernel-doc since it doesn't do macros yet */
 /**
--- xen-subarch-2.6.orig/include/asm-i386/system.h
+++ xen-subarch-2.6/include/asm-i386/system.h
@@ -263,6 +263,9 @@ static inline unsigned long __xchg(unsig
 #define cmpxchg(ptr,o,n)\
 	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
 					(unsigned long)(n),sizeof(*(ptr))))
+#define synch_cmpxchg(ptr,o,n)\
+	((__typeof__(*(ptr)))__synch_cmpxchg((ptr),(unsigned long)(o),\
+					(unsigned long)(n),sizeof(*(ptr))))
 #endif
 
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
@@ -292,6 +295,36 @@ static inline unsigned long __cmpxchg(vo
 	return old;
 }
 
+#define __LOCK_PREFIX "lock ; "
+static inline unsigned long __synch_cmpxchg(volatile void *ptr,
+					    unsigned long old,
+					    unsigned long new, int size)
+{
+	unsigned long prev;
+	switch (size) {
+	case 1:
+		__asm__ __volatile__(__LOCK_PREFIX "cmpxchgb %b1,%2"
+				     : "=a"(prev)
+				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 2:
+		__asm__ __volatile__(__LOCK_PREFIX "cmpxchgw %w1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 4:
+		__asm__ __volatile__(__LOCK_PREFIX "cmpxchgl %1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	}
+	return old;
+}
+#undef __LOCK_PREFIX
+
 #ifndef CONFIG_X86_CMPXCHG
 /*
  * Building a kernel capable running on 80386. It may be necessary to
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/bitops-fns.h
@@ -0,0 +1,97 @@
+/*
+ * Copyright 1992, Linus Torvalds.
+ */
+
+#ifndef __NAME
+# error "please don't include this file directly"
+#endif
+
+/**
+ * set_bit - Atomically set a bit in memory
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ */
+static inline void __NAME(set_bit)(int nr, volatile unsigned long *addr)
+{
+	__asm__ __volatile__( __LOCK_PREFIX
+		"btsl %1,%0"
+		:"+m" (ADDR)
+		:"Ir" (nr));
+}
+
+/**
+ * clear_bit - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ */
+static inline void __NAME(clear_bit)(int nr, volatile unsigned long *addr)
+{
+	__asm__ __volatile__( __LOCK_PREFIX
+		"btrl %1,%0"
+		:"+m" (ADDR)
+		:"Ir" (nr));
+}
+
+/**
+ * change_bit - Toggle a bit in memory
+ * @nr: Bit to change
+ * @addr: Address to start counting from
+ */
+static inline void __NAME(change_bit)(int nr, volatile unsigned long *addr)
+{
+	__asm__ __volatile__( __LOCK_PREFIX
+		"btcl %1,%0"
+		:"+m" (ADDR)
+		:"Ir" (nr));
+}
+
+/**
+ * test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ */
+static inline int __NAME(test_and_set_bit)(int nr,
+					   volatile unsigned long *addr)
+{
+	int oldbit;
+
+	__asm__ __volatile__( __LOCK_PREFIX
+		"btsl %2,%1\n\tsbbl %0,%0"
+		:"=r" (oldbit),"+m" (ADDR)
+		:"Ir" (nr) __BARRIER);
+	return oldbit;
+}
+
+/**
+ * test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ */
+static inline int __NAME(test_and_clear_bit)(int nr,
+					     volatile unsigned long *addr)
+{
+	int oldbit;
+
+	__asm__ __volatile__( __LOCK_PREFIX
+		"btrl %2,%1\n\tsbbl %0,%0"
+		:"=r" (oldbit),"+m" (ADDR)
+		:"Ir" (nr) __BARRIER);
+	return oldbit;
+}
+
+/**
+ * test_and_change_bit - Change a bit and return its old value
+ * @nr: Bit to change
+ * @addr: Address to count from
+ */
+static inline int __NAME(test_and_change_bit)(int nr,
+					      volatile unsigned long *addr)
+{
+	int oldbit;
+
+	__asm__ __volatile__( __LOCK_PREFIX
+		"btcl %2,%1\n\tsbbl %0,%0"
+		:"=r" (oldbit),"+m" (ADDR)
+		:"Ir" (nr) __BARRIER);
+	return oldbit;
+}

--
