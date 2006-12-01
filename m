Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758462AbWLADZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758462AbWLADZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 22:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758476AbWLADZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 22:25:06 -0500
Received: from tomts10-srv.bellnexxia.net ([209.226.175.54]:19336 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1758461AbWLADZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 22:25:01 -0500
Date: Thu, 30 Nov 2006 22:24:58 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 2/2] local.h modifications
Message-ID: <20061201032458.GB32440@Krystal>
References: <20061124215518.GE25048@Krystal> <20061127165643.GD5348@infradead.org> <20061201031400.GB10835@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061201031400.GB10835@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 22:24:13 up 100 days, 32 min,  2 users,  load average: 0.16, 0.33, 0.37
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New version, fixes PowerPC typo (cut'n'pasted from the atomic.h typo).

Mathieu

--- a/include/asm-i386/atomic.h
+++ b/include/asm-i386/atomic.h
@@ -207,8 +207,9 @@ static __inline__ int atomic_sub_return(
 	return atomic_add_return(-i,v);
 }
 
-#define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define atomic_cmpxchg(v, old, new) \
+	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (old), (new)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), (new)))
 
 /**
  * atomic_add_unless - add unless the number is a given value
@@ -221,7 +222,7 @@ #define atomic_xchg(v, new) (xchg(&((v)-
  */
 #define atomic_add_unless(v, a, u)				\
 ({								\
-	int c, old;						\
+	__typeof__((v)->counter) c, old;			\
 	c = atomic_read(v);					\
 	for (;;) {						\
 		if (unlikely(c == (u)))				\
--- a/include/asm-x86_64/local.h
+++ b/include/asm-x86_64/local.h
@@ -45,6 +45,139 @@ static inline void local_sub(long i, loc
 		:"ir" (i), "m" (v->counter));
 }
 
+/**
+ * local_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer to type local_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __inline__ int local_sub_and_test(long i, local_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"subq %2,%0; sete %1"
+		:"=m" (v->counter), "=qm" (c)
+		:"ir" (i), "m" (v->counter) : "memory");
+	return c;
+}
+
+/**
+ * local_dec_and_test - decrement and test
+ * @v: pointer to type local_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static __inline__ int local_dec_and_test(local_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"decq %0; sete %1"
+		:"=m" (v->counter), "=qm" (c)
+		:"m" (v->counter) : "memory");
+	return c != 0;
+}
+
+/**
+ * local_inc_and_test - increment and test
+ * @v: pointer to type local_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static __inline__ int local_inc_and_test(local_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"incq %0; sete %1"
+		:"=m" (v->counter), "=qm" (c)
+		:"m" (v->counter) : "memory");
+	return c != 0;
+}
+
+/**
+ * local_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer to type local_t
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static __inline__ int local_add_negative(long i, local_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"addq %2,%0; sets %1"
+		:"=m" (v->counter), "=qm" (c)
+		:"ir" (i), "m" (v->counter) : "memory");
+	return c;
+}
+
+/**
+ * local_add_return - add and return
+ * @i: integer value to add
+ * @v: pointer to type local_t
+ *
+ * Atomically adds @i to @v and returns @i + @v
+ */
+static __inline__ long local_add_return(long i, local_t *v)
+{
+	long __i = i;
+	__asm__ __volatile__(
+		"xaddq %0, %1;"
+		:"=r"(i)
+		:"m"(v->counter), "0"(i));
+	return i + __i;
+}
+
+static __inline__ long local_sub_return(long i, local_t *v)
+{
+	return local_add_return(-i,v);
+}
+
+#define local_inc_return(v)  (local_add_return(1,v))
+#define local_dec_return(v)  (local_sub_return(1,v))
+
+#define local_cmpxchg(v, old, new) \
+	((__typeof__((v)->counter))cmpxchg_local(&((v)->counter), (old), (new)))
+/* Always has a lock prefix anyway */
+#define local_xchg(v, new) (xchg(&((v)->counter), new))
+
+/**
+ * atomic_up_add_unless - add unless the number is a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as it was not @u.
+ * Returns non-zero if @v was not @u, and zero otherwise.
+ */
+#define local_add_unless(v, a, u)				\
+({								\
+	__typeof__((v)->counter) c, old;			\
+	c = local_read(v);					\
+	for (;;) {						\
+		if (unlikely(c == (u)))				\
+			break;					\
+		old = local_cmpxchg((v), c, c + (a));		\
+		if (likely(old == c))				\
+			break;					\
+		c = old;					\
+	}							\
+	c != (u);						\
+})
+#define local_inc_not_zero(v) local_add_unless((v), 1, 0)
+
 /* On x86-64 these are better than the atomic variants on SMP kernels
    because they dont use a lock prefix. */
 #define __local_inc(l)		local_inc(l)
@@ -85,4 +218,4 @@ #define __cpu_local_dec(v)	cpu_local_dec
 #define __cpu_local_add(i, v)	cpu_local_add((i), (v))
 #define __cpu_local_sub(i, v)	cpu_local_sub((i), (v))
 
-#endif /* _ARCH_I386_LOCAL_H */
+#endif /* _ARCH_X8664_LOCAL_H */
--- a/include/asm-powerpc/local.h
+++ b/include/asm-powerpc/local.h
@@ -1 +1,340 @@
-#include <asm-generic/local.h>
+#ifndef _ARCH_POWERPC_LOCAL_H
+#define _ARCH_POWERPC_LOCAL_H
+
+#include <linux/percpu.h>
+#include <asm/atomic.h>
+
+typedef struct
+{
+	volatile long counter;
+} local_t;
+
+#define LOCAL_INIT(i)	{ (i) }
+
+#define local_read(v)	((v)->counter)
+#define local_set(v,i)	(((v)->counter) = (i))
+
+#define local_add(i,l)	atomic_long_add((i),(&(l)->a))
+#define local_sub(i,l)	atomic_long_sub((i),(&(l)->a))
+#define local_inc(l)	atomic_long_inc(&(l)->a)
+#define local_dec(l)	atomic_long_dec(&(l)->a)
+
+#ifndef __powerpc64__
+
+static __inline__ int local_add_return(int a, local_t *v)
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
+	: "r" (a), "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+#define local_add_negative(a, v)	(local_add_return((a), (v)) < 0)
+
+static __inline__ int local_sub_return(int a, local_t *v)
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
+	: "r" (a), "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+static __inline__ int local_inc_return(local_t *v)
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
+	: "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+/*
+ * local_inc_and_test - increment and test
+ * @v: pointer of type local_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define local_inc_and_test(v) (local_inc_return(v) == 0)
+
+static __inline__ int local_dec_return(local_t *v)
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
+	: "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+#define local_cmpxchg(v, o, n) \
+	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
+#define local_xchg(v, new) (xchg(&((v)->counter), new))
+
+/**
+ * local_add_unless - add unless the number is a given value
+ * @v: pointer of type local_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as it was not @u.
+ * Returns non-zero if @v was not @u, and zero otherwise.
+ */
+static __inline__ int local_add_unless(local_t *v, int a, int u)
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
+	: "r" (&v->counter), "r" (a), "r" (u)
+	: "cc", "memory");
+
+	return t != u;
+}
+
+#define local_inc_not_zero(v) local_add_unless((v), 1, 0)
+
+#define local_sub_and_test(a, v)	(local_sub_return((a), (v)) == 0)
+#define local_dec_and_test(v)		(local_dec_return((v)) == 0)
+
+/*
+ * Atomically test *v and decrement if it is greater than 0.
+ * The function returns the old value of *v minus 1.
+ */
+static __inline__ int local_dec_if_positive(local_t *v)
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
+	: "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+#else /* __powerpc64__ */
+
+static __inline__ long local_add_return(long a, local_t *v)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%2		# local_add_return\n\
+	add	%0,%1,%0\n\
+	stdcx.	%0,0,%2 \n\
+	bne-	1b"
+	: "=&r" (t)
+	: "r" (a), "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+#define local_add_negative(a, v)	(local_add_return((a), (v)) < 0)
+
+static __inline__ long local_sub_return(long a, local_t *v)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%2		# local_sub_return\n\
+	subf	%0,%1,%0\n\
+	stdcx.	%0,0,%2 \n\
+	bne-	1b"
+	: "=&r" (t)
+	: "r" (a), "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+static __inline__ long local_inc_return(local_t *v)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%1		# local_inc_return\n\
+	addic	%0,%0,1\n\
+	stdcx.	%0,0,%1 \n\
+	bne-	1b"
+	: "=&r" (t)
+	: "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+/*
+ * local_inc_and_test - increment and test
+ * @v: pointer of type local_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define local_inc_and_test(v) (local_inc_return(v) == 0)
+
+static __inline__ long local_dec_return(local_t *v)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%1		# local_dec_return\n\
+	addic	%0,%0,-1\n\
+	stdcx.	%0,0,%1\n\
+	bne-	1b"
+	: "=&r" (t)
+	: "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+#define local_sub_and_test(a, v)	(local_sub_return((a), (v)) == 0)
+#define local_dec_and_test(v)	(local_dec_return((v)) == 0)
+
+/*
+ * Atomically test *v and decrement if it is greater than 0.
+ * The function returns the old value of *v minus 1.
+ */
+static __inline__ long local_dec_if_positive(local_t *v)
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
+	: "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+#define local_cmpxchg(v, o, n) \
+	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
+#define local_xchg(v, new) (xchg(&((v)->counter), new))
+
+/**
+ * local_add_unless - add unless the number is a given value
+ * @v: pointer of type local_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as it was not @u.
+ * Returns non-zero if @v was not @u, and zero otherwise.
+ */
+static __inline__ int local_add_unless(local_t *v, long a, long u)
+{
+	long t;
+
+	__asm__ __volatile__ (
+"1:	ldarx	%0,0,%1		# atomic_add_unless\n\
+	cmpd	0,%0,%3 \n\
+	beq-	2f \n\
+	add	%0,%2,%0 \n"
+	PPC405_ERR77(0,%2)
+"	stdcx.	%0,0,%1 \n\
+	bne-	1b \n"
+"	subf	%0,%2,%0 \n\
+2:"
+	: "=&r" (t)
+	: "r" (&v->counter), "r" (a), "r" (u)
+	: "cc", "memory");
+
+	return t != u;
+}
+
+#define local_inc_not_zero(v) local_add_unless((v), 1, 0)
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
+/* Need to disable preemption for the cpu local counters otherwise we could
+   still access a variable of a previous CPU in a non atomic way. */
+#define cpu_local_wrap_v(v)	 	\
+	({ local_t res__;		\
+	   preempt_disable(); 		\
+	   res__ = (v);			\
+	   preempt_enable();		\
+	   res__; })
+#define cpu_local_wrap(v)		\
+	({ preempt_disable();		\
+	   v;				\
+	   preempt_enable(); })		\
+
+#define cpu_local_read(v)    cpu_local_wrap_v(local_read(&__get_cpu_var(v)))
+#define cpu_local_set(v, i)  cpu_local_wrap(local_set(&__get_cpu_var(v), (i)))
+#define cpu_local_inc(v)     cpu_local_wrap(local_inc(&__get_cpu_var(v)))
+#define cpu_local_dec(v)     cpu_local_wrap(local_dec(&__get_cpu_var(v)))
+#define cpu_local_add(i, v)  cpu_local_wrap(local_add((i), &__get_cpu_var(v)))
+#define cpu_local_sub(i, v)  cpu_local_wrap(local_sub((i), &__get_cpu_var(v)))
+
+#define __cpu_local_inc(v)	cpu_local_inc(v)
+#define __cpu_local_dec(v)	cpu_local_dec(v)
+#define __cpu_local_add(i, v)	cpu_local_add((i), (v))
+#define __cpu_local_sub(i, v)	cpu_local_sub((i), (v))
+
+#endif /* _ARCH_POWERPC_LOCAL_H */
--- a/include/asm-mips/local.h
+++ b/include/asm-mips/local.h
@@ -1,60 +1 @@
-#ifndef _ASM_LOCAL_H
-#define _ASM_LOCAL_H
-
-#include <linux/percpu.h>
-#include <asm/atomic.h>
-
-#ifdef CONFIG_32BIT
-
-typedef atomic_t local_t;
-
-#define LOCAL_INIT(i)	ATOMIC_INIT(i)
-#define local_read(v)	atomic_read(v)
-#define local_set(v,i)	atomic_set(v,i)
-
-#define local_inc(v)	atomic_inc(v)
-#define local_dec(v)	atomic_dec(v)
-#define local_add(i, v)	atomic_add(i, v)
-#define local_sub(i, v)	atomic_sub(i, v)
-
-#endif
-
-#ifdef CONFIG_64BIT
-
-typedef atomic64_t local_t;
-
-#define LOCAL_INIT(i)	ATOMIC64_INIT(i)
-#define local_read(v)	atomic64_read(v)
-#define local_set(v,i)	atomic64_set(v,i)
-
-#define local_inc(v)	atomic64_inc(v)
-#define local_dec(v)	atomic64_dec(v)
-#define local_add(i, v)	atomic64_add(i, v)
-#define local_sub(i, v)	atomic64_sub(i, v)
-
-#endif
-
-#define __local_inc(v)		((v)->counter++)
-#define __local_dec(v)		((v)->counter--)
-#define __local_add(i,v)	((v)->counter+=(i))
-#define __local_sub(i,v)	((v)->counter-=(i))
-
-/*
- * Use these for per-cpu local_t variables: on some archs they are
- * much more efficient than these naive implementations.  Note they take
- * a variable, not an address.
- */
-#define cpu_local_read(v)	local_read(&__get_cpu_var(v))
-#define cpu_local_set(v, i)	local_set(&__get_cpu_var(v), (i))
-
-#define cpu_local_inc(v)	local_inc(&__get_cpu_var(v))
-#define cpu_local_dec(v)	local_dec(&__get_cpu_var(v))
-#define cpu_local_add(i, v)	local_add((i), &__get_cpu_var(v))
-#define cpu_local_sub(i, v)	local_sub((i), &__get_cpu_var(v))
-
-#define __cpu_local_inc(v)	__local_inc(&__get_cpu_var(v))
-#define __cpu_local_dec(v)	__local_dec(&__get_cpu_var(v))
-#define __cpu_local_add(i, v)	__local_add((i), &__get_cpu_var(v))
-#define __cpu_local_sub(i, v)	__local_sub((i), &__get_cpu_var(v))
-
-#endif /* _ASM_LOCAL_H */
+#include <asm-generic/local.h>
--- a/include/asm-generic/local.h
+++ b/include/asm-generic/local.h
@@ -33,6 +33,19 @@ #define local_dec(l)	atomic_long_dec(&(l
 #define local_add(i,l)	atomic_long_add((i),(&(l)->a))
 #define local_sub(i,l)	atomic_long_sub((i),(&(l)->a))
 
+#define local_sub_and_test(i, l) atomic_long_sub_and_test((i), (&(l)->a))
+#define local_dec_and_test(l) atomic_long_dec_and_test(&(l)->a)
+#define local_inc_and_test(l) atomic_long_inc_and_test(&(l)->a)
+#define local_add_negative(i, l) atomic_long_add_negative((i), (&(l)->a))
+#define local_add_return(i, l) atomic_long_add_return((i), (&(l)->a))
+#define local_sub_return(i, l) atomic_long_sub_return((i), (&(l)->a))
+#define local_inc_return(l) atomic_long_inc_return(&(l)->a)
+
+#define local_cmpxchg(l, old, new) atomic_long_cmpxchg((&(l)->a), (old), (new))
+#define local_xchg(l, new) atomic_long_xchg((&(l)->a), (new))
+#define local_add_unless(l, a, u) atomic_long_add_unless((&(l)->a), (a), (u))
+#define local_inc_not_zero(l) atomic_long_inc_not_zero(&(l)->a)
+
 /* Non-atomic variants, ie. preemption disabled and won't be touched
  * in interrupt, etc.  Some archs can optimize this case well. */
 #define __local_inc(l)		local_set((l), local_read(l) + 1)

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
