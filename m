Return-Path: <linux-kernel-owner+w=401wt.eu-S1161087AbWLUA1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWLUA1c (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWLUA1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:27:30 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:56382 "EHLO
	tomts16-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161083AbWLUA1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:27:11 -0500
Date: Wed, 20 Dec 2006 19:27:05 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, paulus@samba.org
Cc: ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@ozlabs.org
Subject: [PATCH 7/10] local_t : powerpc
Message-ID: <20061221002705.GW28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061221001545.GP28643@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:25:59 up 119 days, 21:33,  6 users,  load average: 1.97, 2.03, 1.85
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PowerPC local_t extension.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -226,6 +226,29 @@ __xchg_u32(volatile void *p, unsigned lo
 	return prev;
 }
 
+/*
+ * Atomic exchange
+ *
+ * Changes the memory location '*ptr' to be val and returns
+ * the previous value stored there.
+ */
+static __inline__ unsigned long
+__xchg_u32_local(volatile void *p, unsigned long val)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%2 \n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%3,0,%2 \n\
+	bne-	1b"
+	: "=&r" (prev), "+m" (*(volatile unsigned int *)p)
+	: "r" (p), "r" (val)
+	: "cc", "memory");
+
+	return prev;
+}
+
 #ifdef CONFIG_PPC64
 static __inline__ unsigned long
 __xchg_u64(volatile void *p, unsigned long val)
@@ -245,6 +268,23 @@ __xchg_u64(volatile void *p, unsigned lo
 
 	return prev;
 }
+
+static __inline__ unsigned long
+__xchg_u64_local(volatile void *p, unsigned long val)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%2 \n"
+	PPC405_ERR77(0,%2)
+"	stdcx.	%3,0,%2 \n\
+	bne-	1b"
+	: "=&r" (prev), "+m" (*(volatile unsigned long *)p)
+	: "r" (p), "r" (val)
+	: "cc", "memory");
+
+	return prev;
+}
 #endif
 
 /*
@@ -268,12 +308,33 @@ #endif
 	return x;
 }
 
+static __inline__ unsigned long
+__xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
+{
+	switch (size) {
+	case 4:
+		return __xchg_u32_local(ptr, x);
+#ifdef CONFIG_PPC64
+	case 8:
+		return __xchg_u64_local(ptr, x);
+#endif
+	}
+	__xchg_called_with_bad_pointer();
+	return x;
+}
 #define xchg(ptr,x)							     \
   ({									     \
      __typeof__(*(ptr)) _x_ = (x);					     \
      (__typeof__(*(ptr))) __xchg((ptr), (unsigned long)_x_, sizeof(*(ptr))); \
   })
 
+#define xchg_local(ptr,x)						     \
+  ({									     \
+     __typeof__(*(ptr)) _x_ = (x);					     \
+     (__typeof__(*(ptr))) __xchg_local((ptr),				     \
+     		(unsigned long)_x_, sizeof(*(ptr))); 			     \
+  })
+
 #define tas(ptr) (xchg((ptr),1))
 
 /*
@@ -305,6 +366,28 @@ __cmpxchg_u32(volatile unsigned int *p, 
 	return prev;
 }
 
+static __inline__ unsigned long
+__cmpxchg_u32_local(volatile unsigned int *p, unsigned long old,
+			unsigned long new)
+{
+	unsigned int prev;
+
+	__asm__ __volatile__ (
+"1:	lwarx	%0,0,%2		# __cmpxchg_u32\n\
+	cmpw	0,%0,%3\n\
+	bne-	2f\n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%4,0,%2\n\
+	bne-	1b"
+	"\n\
+2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc", "memory");
+
+	return prev;
+}
+
 #ifdef CONFIG_PPC64
 static __inline__ unsigned long
 __cmpxchg_u64(volatile unsigned long *p, unsigned long old, unsigned long new)
@@ -327,6 +410,27 @@ __cmpxchg_u64(volatile unsigned long *p,
 
 	return prev;
 }
+
+static __inline__ unsigned long
+__cmpxchg_u64_local(volatile unsigned long *p, unsigned long old,
+			unsigned long new)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__ (
+"1:	ldarx	%0,0,%2		# __cmpxchg_u64\n\
+	cmpd	0,%0,%3\n\
+	bne-	2f\n\
+	stdcx.	%4,0,%2\n\
+	bne-	1b"
+	"\n\
+2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc", "memory");
+
+	return prev;
+}
 #endif
 
 /* This function doesn't exist, so you'll get a linker error
@@ -349,6 +453,22 @@ #endif
 	return old;
 }
 
+static __inline__ unsigned long
+__cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
+	  unsigned int size)
+{
+	switch (size) {
+	case 4:
+		return __cmpxchg_u32_local(ptr, old, new);
+#ifdef CONFIG_PPC64
+	case 8:
+		return __cmpxchg_u64_local(ptr, old, new);
+#endif
+	}
+	__cmpxchg_called_with_bad_pointer();
+	return old;
+}
+
 #define cmpxchg(ptr,o,n)						 \
   ({									 \
      __typeof__(*(ptr)) _o_ = (o);					 \
@@ -357,6 +477,15 @@ #define cmpxchg(ptr,o,n)						 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
   })
 
+
+#define cmpxchg_local(ptr,o,n)						 \
+  ({									 \
+     __typeof__(*(ptr)) _o_ = (o);					 \
+     __typeof__(*(ptr)) _n_ = (n);					 \
+     (__typeof__(*(ptr))) __cmpxchg_local((ptr), (unsigned long)_o_,	 \
+				    (unsigned long)_n_, sizeof(*(ptr))); \
+  })
+
 #ifdef CONFIG_PPC64
 /*
  * We handle most unaligned accesses in hardware. On the other hand 
--- a/include/asm-powerpc/local.h
+++ b/include/asm-powerpc/local.h
@@ -1 +1,345 @@
-#include <asm-generic/local.h>
+#ifndef _ARCH_POWERPC_LOCAL_H
+#define _ARCH_POWERPC_LOCAL_H
+
+#include <linux/percpu.h>
+#include <asm/atomic.h>
+
+typedef struct
+{
+	atomic_long_t a;
+} local_t;
+
+#define LOCAL_INIT(i)	{ ATOMIC_LONG_INIT(i) }
+
+#define local_read(l)	atomic_long_read(&(l)->a)
+#define local_set(l,i)	atomic_long_set(&(l)->a, (i))
+
+#define local_add(i,l)	atomic_long_add((i),(&(l)->a))
+#define local_sub(i,l)	atomic_long_sub((i),(&(l)->a))
+#define local_inc(l)	atomic_long_inc(&(l)->a)
+#define local_dec(l)	atomic_long_dec(&(l)->a)
+
+#ifndef __powerpc64__
+
+static __inline__ int local_add_return(int a, local_t *l)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%2		# local_add_return\n\
+	add	%0,%1,%0\n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%0,0,%2 \n\
+	bne-	1b"
+	: "=&r" (t)
+	: "r" (a), "r" (&(l->a.counter))
+	: "cc", "memory");
+
+	return t;
+}
+
+#define local_add_negative(a, l)	(local_add_return((a), (l)) < 0)
+
+static __inline__ int local_sub_return(int a, local_t *l)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%2		# local_sub_return\n\
+	subf	%0,%1,%0\n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%0,0,%2 \n\
+	bne-	1b"
+	: "=&r" (t)
+	: "r" (a), "r" (&(l->a.counter))
+	: "cc", "memory");
+
+	return t;
+}
+
+static __inline__ int local_inc_return(local_t *l)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%1		# local_inc_return\n\
+	addic	%0,%0,1\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%0,0,%1 \n\
+	bne-	1b"
+	: "=&r" (t)
+	: "r" (&(l->a.counter))
+	: "cc", "memory");
+
+	return t;
+}
+
+/*
+ * local_inc_and_test - increment and test
+ * @l: pointer of type local_t
+ *
+ * Atomically increments @l by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define local_inc_and_test(l) (local_inc_return(l) == 0)
+
+static __inline__ int local_dec_return(local_t *l)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%1		# local_dec_return\n\
+	addic	%0,%0,-1\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%0,0,%1\n\
+	bne-	1b"
+	: "=&r" (t)
+	: "r" (&(l->a.counter))
+	: "cc", "memory");
+
+	return t;
+}
+
+#define local_cmpxchg(l, o, n) \
+	((long)cmpxchg(&((l)->a.counter), (o), (n)))
+#define local_xchg(l, new) (xchg(&((l)->a.counter), new))
+
+/**
+ * local_add_unless - add unless the number is a given value
+ * @l: pointer of type local_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @l, so long as it was not @u.
+ * Returns non-zero if @l was not @u, and zero otherwise.
+ */
+static __inline__ int local_add_unless(local_t *l, int a, int u)
+{
+	int t;
+
+	__asm__ __volatile__ (
+"1:	lwarx	%0,0,%1		# local_add_unless\n\
+	cmpw	0,%0,%3 \n\
+	beq-	2f \n\
+	add	%0,%2,%0 \n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%0,0,%1 \n\
+	bne-	1b \n"
+"	subf	%0,%2,%0 \n\
+2:"
+	: "=&r" (t)
+	: "r" (&(l->a.counter)), "r" (a), "r" (u)
+	: "cc", "memory");
+
+	return t != u;
+}
+
+#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+
+#define local_sub_and_test(a, l)	(local_sub_return((a), (l)) == 0)
+#define local_dec_and_test(l)		(local_dec_return((l)) == 0)
+
+/*
+ * Atomically test *l and decrement if it is greater than 0.
+ * The function returns the old value of *l minus 1.
+ */
+static __inline__ int local_dec_if_positive(local_t *l)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%1		# local_dec_if_positive\n\
+	addic.	%0,%0,-1\n\
+	blt-	2f\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%0,0,%1\n\
+	bne-	1b"
+	"\n\
+2:"	: "=&r" (t)
+	: "r" (&(l->a.counter))
+	: "cc", "memory");
+
+	return t;
+}
+
+#else /* __powerpc64__ */
+
+static __inline__ long local_add_return(long a, local_t *l)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%2		# local_add_return\n\
+	add	%0,%1,%0\n\
+	stdcx.	%0,0,%2 \n\
+	bne-	1b"
+	: "=&r" (t)
+	: "r" (a), "r" (&(l->a.counter))
+	: "cc", "memory");
+
+	return t;
+}
+
+#define local_add_negative(a, l)	(local_add_return((a), (l)) < 0)
+
+static __inline__ long local_sub_return(long a, local_t *l)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%2		# local_sub_return\n\
+	subf	%0,%1,%0\n\
+	stdcx.	%0,0,%2 \n\
+	bne-	1b"
+	: "=&r" (t)
+	: "r" (a), "r" (&(l->a.counter))
+	: "cc", "memory");
+
+	return t;
+}
+
+static __inline__ long local_inc_return(local_t *l)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%1		# local_inc_return\n\
+	addic	%0,%0,1\n\
+	stdcx.	%0,0,%1 \n\
+	bne-	1b"
+	: "=&r" (t)
+	: "r" (&(l->a.counter))
+	: "cc", "memory");
+
+	return t;
+}
+
+/*
+ * local_inc_and_test - increment and test
+ * @l: pointer of type local_t
+ *
+ * Atomically increments @l by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define local_inc_and_test(l) (local_inc_return(l) == 0)
+
+static __inline__ long local_dec_return(local_t *l)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%1		# local_dec_return\n\
+	addic	%0,%0,-1\n\
+	stdcx.	%0,0,%1\n\
+	bne-	1b"
+	: "=&r" (t)
+	: "r" (&(l->a.counter))
+	: "cc", "memory");
+
+	return t;
+}
+
+#define local_sub_and_test(a, l)	(local_sub_return((a), (l)) == 0)
+#define local_dec_and_test(l)	(local_dec_return((l)) == 0)
+
+/*
+ * Atomically test *l and decrement if it is greater than 0.
+ * The function returns the old value of *l minus 1.
+ */
+static __inline__ long local_dec_if_positive(local_t *l)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%1		# local_dec_if_positive\n\
+	addic.	%0,%0,-1\n\
+	blt-	2f\n\
+	stdcx.	%0,0,%1\n\
+	bne-	1b"
+	"\n\
+2:"	: "=&r" (t)
+	: "r" (&(l->a.counter))
+	: "cc", "memory");
+
+	return t;
+}
+
+#define local_cmpxchg(l, o, n) \
+	((__typeof__((l)->a.counter))cmpxchg_local(&((l)->a.counter), (o), (n)))
+#define local_xchg(l, new) (xchg_local(&((l)->a.counter), new))
+
+/**
+ * local_add_unless - add unless the number is a given value
+ * @l: pointer of type local_t
+ * @a: the amount to add to l...
+ * @u: ...unless l is equal to u.
+ *
+ * Atomically adds @a to @l, so long as it was not @u.
+ * Returns non-zero if @l was not @u, and zero otherwise.
+ */
+static __inline__ int local_add_unless(local_t *l, long a, long u)
+{
+	long t;
+
+	__asm__ __volatile__ (
+"1:	ldarx	%0,0,%1		# local_add_unless\n\
+	cmpd	0,%0,%3 \n\
+	beq-	2f \n\
+	add	%0,%2,%0 \n"
+	PPC405_ERR77(0,%2)
+"	stdcx.	%0,0,%1 \n\
+	bne-	1b \n"
+"	subf	%0,%2,%0 \n\
+2:"
+	: "=&r" (t)
+	: "r" (&(l->a.counter)), "r" (a), "r" (u)
+	: "cc", "memory");
+
+	return t != u;
+}
+
+#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+
+#endif /* !__powerpc64__ */
+
+/* Use these for per-cpu local_t variables: on some archs they are
+ * much more efficient than these naive implementations.  Note they take
+ * a variable, not an address.
+ *
+ * This could be done better if we moved the per cpu data directly
+ * after GS.
+ */
+
+#define __local_inc(l)		((l)->a.counter++)
+#define __local_dec(l)		((l)->a.counter++)
+#define __local_add(i,l)	((l)->a.counter+=(i))
+#define __local_sub(i,l)	((l)->a.counter-=(i))
+
+/* Need to disable preemption for the cpu local counters otherwise we could
+   still access a variable of a previous CPU in a non atomic way. */
+#define cpu_local_wrap_v(l)	 	\
+	({ local_t res__;		\
+	   preempt_disable(); 		\
+	   res__ = (l);			\
+	   preempt_enable();		\
+	   res__; })
+#define cpu_local_wrap(l)		\
+	({ preempt_disable();		\
+	   l;				\
+	   preempt_enable(); })		\
+
+#define cpu_local_read(l)    cpu_local_wrap_v(local_read(&__get_cpu_var(l)))
+#define cpu_local_set(l, i)  cpu_local_wrap(local_set(&__get_cpu_var(l), (i)))
+#define cpu_local_inc(l)     cpu_local_wrap(local_inc(&__get_cpu_var(l)))
+#define cpu_local_dec(l)     cpu_local_wrap(local_dec(&__get_cpu_var(l)))
+#define cpu_local_add(i, l)  cpu_local_wrap(local_add((i), &__get_cpu_var(l)))
+#define cpu_local_sub(i, l)  cpu_local_wrap(local_sub((i), &__get_cpu_var(l)))
+
+#define __cpu_local_inc(l)	cpu_local_inc(l)
+#define __cpu_local_dec(l)	cpu_local_dec(l)
+#define __cpu_local_add(i, l)	cpu_local_add((i), (l))
+#define __cpu_local_sub(i, l)	cpu_local_sub((i), (l))
+
+#endif /* _ARCH_POWERPC_LOCAL_H */

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
