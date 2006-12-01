Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161722AbWLAVOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161722AbWLAVOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161719AbWLAVOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:14:44 -0500
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:13188 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1161722AbWLAVOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:14:42 -0500
Date: Fri, 1 Dec 2006 16:14:33 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Message-ID: <20061201211433.GB27155@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bcc: 
Subject: Re: [PATCH 2/2] local.h modifications (all arch support)
Reply-To: 
In-Reply-To: <20061201032458.GB32440@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime:  16:11:23 up 100 days, 18:19,  5 users,  load average: 0.72, 0.62, 0.53

Hi,

I also completed the support for all atomic operations in local.h for all
architectures. The local_t type is now identical on each architectures : it
contains an atomic_long_t field, just like the asm-generic implementation.

Please review.

Mathieu

---BEGIN---
--- a/include/asm-alpha/local.h
+++ b/include/asm-alpha/local.h
@@ -4,37 +4,115 @@ #define _ALPHA_LOCAL_H
 #include <linux/percpu.h>
 #include <asm/atomic.h>
 
-typedef atomic64_t local_t;
+typedef struct
+{
+	atomic_long_t a;
+} local_t;
 
-#define LOCAL_INIT(i)	ATOMIC64_INIT(i)
-#define local_read(v)	atomic64_read(v)
-#define local_set(v,i)	atomic64_set(v,i)
+#define LOCAL_INIT(i)	{ ATOMIC_LONG_INIT(i) }
+#define local_read(l)	atomic_long_read(&(l)->a)
+#define local_set(l,i)	atomic_long_set(&(l)->a, (i))
+#define local_inc(l)	atomic_long_inc(&(l)->a)
+#define local_dec(l)	atomic_long_dec(&(l)->a)
+#define local_add(i,l)	atomic_long_add((i),(&(l)->a))
+#define local_sub(i,l)	atomic_long_sub((i),(&(l)->a))
 
-#define local_inc(v)	atomic64_inc(v)
-#define local_dec(v)	atomic64_dec(v)
-#define local_add(i, v)	atomic64_add(i, v)
-#define local_sub(i, v)	atomic64_sub(i, v)
+static __inline__ long local_add_return(long i, local_t * l)
+{
+	long temp, result;
+	__asm__ __volatile__(
+	"1:	ldq_l %0,%1\n"
+	"	addq %0,%3,%2\n"
+	"	addq %0,%3,%0\n"
+	"	stq_c %0,%1\n"
+	"	beq %0,2f\n"
+	".subsection 2\n"
+	"2:	br 1b\n"
+	".previous"
+	:"=&r" (temp), "=m" (l->a.counter), "=&r" (result)
+	:"Ir" (i), "m" (l->a.counter) : "memory");
+	return result;
+}
 
-#define __local_inc(v)		((v)->counter++)
-#define __local_dec(v)		((v)->counter++)
-#define __local_add(i,v)	((v)->counter+=(i))
-#define __local_sub(i,v)	((v)->counter-=(i))
+static __inline__ long local_sub_return(long i, local_t * v)
+{
+	long temp, result;
+	__asm__ __volatile__(
+	"1:	ldq_l %0,%1\n"
+	"	subq %0,%3,%2\n"
+	"	subq %0,%3,%0\n"
+	"	stq_c %0,%1\n"
+	"	beq %0,2f\n"
+	".subsection 2\n"
+	"2:	br 1b\n"
+	".previous"
+	:"=&r" (temp), "=m" (l->a.counter), "=&r" (result)
+	:"Ir" (i), "m" (l->a.counter) : "memory");
+	return result;
+}
+
+#define local_cmpxchg(l, old, new) \
+	((long)cmpxchg_local(&((l)->a.counter), old, new))
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
+#define local_add_unless(l, a, u)				\
+({								\
+	long c, old;						\
+	c = local_read(l);					\
+	for (;;) {						\
+		if (unlikely(c == (u)))				\
+			break;					\
+		old = local_cmpxchg((l), c, c + (a));	\
+		if (likely(old == c))				\
+			break;					\
+		c = old;					\
+	}							\
+	c != (u);						\
+})
+#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+
+#define local_add_negative(a, l) (local_add_return((a), (l)) < 0)
+
+#define local_dec_return(l) local_sub_return(1,(l))
+
+#define local_inc_return(l) local_add_return(1,(l))
+
+#define local_sub_and_test(i,l) (local_sub_return((i), (l)) == 0)
+
+#define local_inc_and_test(l) (local_add_return(1, (l)) == 0)
+
+#define local_dec_and_test(l) (local_sub_return(1, (l)) == 0)
+
+/* Verify if faster than atomic ops */
+#define __local_inc(l)		((l)->a.counter++)
+#define __local_dec(l)		((l)->a.counter++)
+#define __local_add(i,l)	((l)->a.counter+=(i))
+#define __local_sub(i,l)	((l)->a.counter-=(i))
 
 /* Use these for per-cpu local_t variables: on some archs they are
  * much more efficient than these naive implementations.  Note they take
  * a variable, not an address.
  */
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
+#define cpu_local_read(l)	local_read(&__get_cpu_var(l))
+#define cpu_local_set(l, i)	local_set(&__get_cpu_var(l), (i))
+
+#define cpu_local_inc(l)	local_inc(&__get_cpu_var(l))
+#define cpu_local_dec(l)	local_dec(&__get_cpu_var(l))
+#define cpu_local_add(i, l)	local_add((i), &__get_cpu_var(l))
+#define cpu_local_sub(i, l)	local_sub((i), &__get_cpu_var(l))
+
+#define __cpu_local_inc(l)	__local_inc(&__get_cpu_var(l))
+#define __cpu_local_dec(l)	__local_dec(&__get_cpu_var(l))
+#define __cpu_local_add(i, l)	__local_add((i), &__get_cpu_var(l))
+#define __cpu_local_sub(i, l)	__local_sub((i), &__get_cpu_var(l))
 
 #endif /* _ALPHA_LOCAL_H */
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
@@ -44,19 +57,19 @@ #define __local_sub(i,l)	local_set((l), 
  * much more efficient than these naive implementations.  Note they take
  * a variable (eg. mystruct.foo), not an address.
  */
-#define cpu_local_read(v)	local_read(&__get_cpu_var(v))
-#define cpu_local_set(v, i)	local_set(&__get_cpu_var(v), (i))
-#define cpu_local_inc(v)	local_inc(&__get_cpu_var(v))
-#define cpu_local_dec(v)	local_dec(&__get_cpu_var(v))
-#define cpu_local_add(i, v)	local_add((i), &__get_cpu_var(v))
-#define cpu_local_sub(i, v)	local_sub((i), &__get_cpu_var(v))
+#define cpu_local_read(l)	local_read(&__get_cpu_var(l))
+#define cpu_local_set(l, i)	local_set(&__get_cpu_var(l), (i))
+#define cpu_local_inc(l)	local_inc(&__get_cpu_var(l))
+#define cpu_local_dec(l)	local_dec(&__get_cpu_var(l))
+#define cpu_local_add(i, l)	local_add((i), &__get_cpu_var(l))
+#define cpu_local_sub(i, l)	local_sub((i), &__get_cpu_var(l))
 
 /* Non-atomic increments, ie. preemption disabled and won't be touched
  * in interrupt, etc.  Some archs can optimize this case well.
  */
-#define __cpu_local_inc(v)	__local_inc(&__get_cpu_var(v))
-#define __cpu_local_dec(v)	__local_dec(&__get_cpu_var(v))
-#define __cpu_local_add(i, v)	__local_add((i), &__get_cpu_var(v))
-#define __cpu_local_sub(i, v)	__local_sub((i), &__get_cpu_var(v))
+#define __cpu_local_inc(l)	__local_inc(&__get_cpu_var(l))
+#define __cpu_local_dec(l)	__local_dec(&__get_cpu_var(l))
+#define __cpu_local_add(i, l)	__local_add((i), &__get_cpu_var(l))
+#define __cpu_local_sub(i, l)	__local_sub((i), &__get_cpu_var(l))
 
 #endif /* _ASM_GENERIC_LOCAL_H */
--- a/include/asm-i386/local.h
+++ b/include/asm-i386/local.h
@@ -2,47 +2,198 @@ #ifndef _ARCH_I386_LOCAL_H
 #define _ARCH_I386_LOCAL_H
 
 #include <linux/percpu.h>
+#include <asm/system.h>
+#include <asm/atomic.h>
 
 typedef struct
 {
-	volatile long counter;
+	atomic_long_t a;
 } local_t;
 
-#define LOCAL_INIT(i)	{ (i) }
+#define LOCAL_INIT(i)	{ ATOMIC_LONG_INIT(i) }
 
-#define local_read(v)	((v)->counter)
-#define local_set(v,i)	(((v)->counter) = (i))
+#define local_read(l)	atomic_long_read(&(l)->a)
+#define local_set(l,i)	atomic_long_set(&(l)->a, (i))
 
-static __inline__ void local_inc(local_t *v)
+static __inline__ void local_inc(local_t *l)
 {
 	__asm__ __volatile__(
 		"incl %0"
-		:"+m" (v->counter));
+		:"+m" (l->a.counter));
 }
 
-static __inline__ void local_dec(local_t *v)
+static __inline__ void local_dec(local_t *l)
 {
 	__asm__ __volatile__(
 		"decl %0"
-		:"+m" (v->counter));
+		:"+m" (l->a.counter));
 }
 
-static __inline__ void local_add(long i, local_t *v)
+static __inline__ void local_add(long i, local_t *l)
 {
 	__asm__ __volatile__(
 		"addl %1,%0"
-		:"+m" (v->counter)
+		:"+m" (l->a.counter)
 		:"ir" (i));
 }
 
-static __inline__ void local_sub(long i, local_t *v)
+static __inline__ void local_sub(long i, local_t *l)
 {
 	__asm__ __volatile__(
 		"subl %1,%0"
-		:"+m" (v->counter)
+		:"+m" (l->a.counter)
 		:"ir" (i));
 }
 
+/**
+ * local_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @l: pointer of type local_t
+ * 
+ * Atomically subtracts @i from @l and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __inline__ int local_sub_and_test(long i, local_t *l)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"subl %2,%0; sete %1"
+		:"+m" (l->a.counter), "=qm" (c)
+		:"ir" (i) : "memory");
+	return c;
+}
+
+/**
+ * local_dec_and_test - decrement and test
+ * @l: pointer of type local_t
+ * 
+ * Atomically decrements @l by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */ 
+static __inline__ int local_dec_and_test(local_t *l)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"decl %0; sete %1"
+		:"+m" (l->a.counter), "=qm" (c)
+		: : "memory");
+	return c != 0;
+}
+
+/**
+ * local_inc_and_test - increment and test 
+ * @l: pointer of type local_t
+ * 
+ * Atomically increments @l by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */ 
+static __inline__ int local_inc_and_test(local_t *l)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"incl %0; sete %1"
+		:"+m" (l->a.counter), "=qm" (c)
+		: : "memory");
+	return c != 0;
+}
+
+/**
+ * local_add_negative - add and test if negative
+ * @l: pointer of type local_t
+ * @i: integer value to add
+ * 
+ * Atomically adds @i to @l and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */ 
+static __inline__ int local_add_negative(long i, local_t *l)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"addl %2,%0; sets %1"
+		:"+m" (l->a.counter), "=qm" (c)
+		:"ir" (i) : "memory");
+	return c;
+}
+
+/**
+ * local_add_return - add and return
+ * @l: pointer of type local_t
+ * @i: integer value to add
+ *
+ * Atomically adds @i to @l and returns @i + @l
+ */
+static __inline__ long local_add_return(long i, local_t *l)
+{
+	long __i;
+#ifdef CONFIG_M386
+	unsigned long flags;
+	if(unlikely(boot_cpu_data.x86==3))
+		goto no_xadd;
+#endif
+	/* Modern 486+ processor */
+	__i = i;
+	__asm__ __volatile__(
+		"xaddl %0, %1;"
+		:"=r"(i)
+		:"m"(l->a.counter), "0"(i));
+	return i + __i;
+
+#ifdef CONFIG_M386
+no_xadd: /* Legacy 386 processor */
+	local_irq_save(flags);
+	__i = local_read(l);
+	local_set(l, i + __i);
+	local_irq_restore(flags);
+	return i + __i;
+#endif
+}
+
+static __inline__ long local_sub_return(long i, local_t *l)
+{
+	return local_add_return(-i,l);
+}
+
+#define local_inc_return(l)  (local_add_return(1,l))
+#define local_dec_return(l)  (local_sub_return(1,l))
+
+#define local_cmpxchg(l, o, n) \
+	((long)cmpxchg_local(&((l)->a.counter), (o), (n)))
+/* Always has a lock prefix anyway */
+#define local_xchg(l, new) (xchg(&((l)->a.counter), new))
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
+#define local_add_unless(l, a, u)				\
+({								\
+	long c, old;						\
+	c = local_read(l);					\
+	for (;;) {						\
+		if (unlikely(c == (u)))				\
+			break;					\
+		old = local_cmpxchg((l), c, c + (a));	\
+		if (likely(old == c))				\
+			break;					\
+		c = old;					\
+	}							\
+	c != (u);						\
+})
+#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+
 /* On x86, these are no better than the atomic variants. */
 #define __local_inc(l)		local_inc(l)
 #define __local_dec(l)		local_dec(l)
@@ -56,27 +207,27 @@ #define __local_sub(i,l)	local_sub((i),(
 
 /* Need to disable preemption for the cpu local counters otherwise we could
    still access a variable of a previous CPU in a non atomic way. */
-#define cpu_local_wrap_v(v)	 	\
+#define cpu_local_wrap_v(l)	 	\
 	({ local_t res__;		\
 	   preempt_disable(); 		\
-	   res__ = (v);			\
+	   res__ = (l);			\
 	   preempt_enable();		\
 	   res__; })
-#define cpu_local_wrap(v)		\
+#define cpu_local_wrap(l)		\
 	({ preempt_disable();		\
-	   v;				\
+	   l;				\
 	   preempt_enable(); })		\
 
-#define cpu_local_read(v)    cpu_local_wrap_v(local_read(&__get_cpu_var(v)))
-#define cpu_local_set(v, i)  cpu_local_wrap(local_set(&__get_cpu_var(v), (i)))
-#define cpu_local_inc(v)     cpu_local_wrap(local_inc(&__get_cpu_var(v)))
-#define cpu_local_dec(v)     cpu_local_wrap(local_dec(&__get_cpu_var(v)))
-#define cpu_local_add(i, v)  cpu_local_wrap(local_add((i), &__get_cpu_var(v)))
-#define cpu_local_sub(i, v)  cpu_local_wrap(local_sub((i), &__get_cpu_var(v)))
-
-#define __cpu_local_inc(v)	cpu_local_inc(v)
-#define __cpu_local_dec(v)	cpu_local_dec(v)
-#define __cpu_local_add(i, v)	cpu_local_add((i), (v))
-#define __cpu_local_sub(i, v)	cpu_local_sub((i), (v))
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
 
 #endif /* _ARCH_I386_LOCAL_H */
--- a/include/asm-ia64/local.h
+++ b/include/asm-ia64/local.h
@@ -1,50 +1 @@
-#ifndef _ASM_IA64_LOCAL_H
-#define _ASM_IA64_LOCAL_H
-
-/*
- * Copyright (C) 2003 Hewlett-Packard Co
- *	David Mosberger-Tang <davidm@hpl.hp.com>
- */
-
-#include <linux/percpu.h>
-
-typedef struct {
-	atomic64_t val;
-} local_t;
-
-#define LOCAL_INIT(i)	((local_t) { { (i) } })
-#define local_read(l)	atomic64_read(&(l)->val)
-#define local_set(l, i)	atomic64_set(&(l)->val, i)
-#define local_inc(l)	atomic64_inc(&(l)->val)
-#define local_dec(l)	atomic64_dec(&(l)->val)
-#define local_add(i, l)	atomic64_add((i), &(l)->val)
-#define local_sub(i, l)	atomic64_sub((i), &(l)->val)
-
-/* Non-atomic variants, i.e., preemption disabled and won't be touched in interrupt, etc.  */
-
-#define __local_inc(l)		(++(l)->val.counter)
-#define __local_dec(l)		(--(l)->val.counter)
-#define __local_add(i,l)	((l)->val.counter += (i))
-#define __local_sub(i,l)	((l)->val.counter -= (i))
-
-/*
- * Use these for per-cpu local_t variables.  Note they take a variable (eg. mystruct.foo),
- * not an address.
- */
-#define cpu_local_read(v)	local_read(&__ia64_per_cpu_var(v))
-#define cpu_local_set(v, i)	local_set(&__ia64_per_cpu_var(v), (i))
-#define cpu_local_inc(v)	local_inc(&__ia64_per_cpu_var(v))
-#define cpu_local_dec(v)	local_dec(&__ia64_per_cpu_var(v))
-#define cpu_local_add(i, v)	local_add((i), &__ia64_per_cpu_var(v))
-#define cpu_local_sub(i, v)	local_sub((i), &__ia64_per_cpu_var(v))
-
-/*
- * Non-atomic increments, i.e., preemption disabled and won't be touched in interrupt,
- * etc.
- */
-#define __cpu_local_inc(v)	__local_inc(&__ia64_per_cpu_var(v))
-#define __cpu_local_dec(v)	__local_dec(&__ia64_per_cpu_var(v))
-#define __cpu_local_add(i, v)	__local_add((i), &__ia64_per_cpu_var(v))
-#define __cpu_local_sub(i, v)	__local_sub((i), &__ia64_per_cpu_var(v))
-
-#endif /* _ASM_IA64_LOCAL_H */
+#include <asm-generic/local.h>
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
--- a/include/asm-parisc/local.h
+++ b/include/asm-parisc/local.h
@@ -1,40 +1 @@
-#ifndef _ARCH_PARISC_LOCAL_H
-#define _ARCH_PARISC_LOCAL_H
-
-#include <linux/percpu.h>
-#include <asm/atomic.h>
-
-typedef atomic_long_t local_t;
-
-#define LOCAL_INIT(i)	ATOMIC_LONG_INIT(i)
-#define local_read(v)	atomic_long_read(v)
-#define local_set(v,i)	atomic_long_set(v,i)
-
-#define local_inc(v)	atomic_long_inc(v)
-#define local_dec(v)	atomic_long_dec(v)
-#define local_add(i, v)	atomic_long_add(i, v)
-#define local_sub(i, v)	atomic_long_sub(i, v)
-
-#define __local_inc(v)		((v)->counter++)
-#define __local_dec(v)		((v)->counter--)
-#define __local_add(i,v)	((v)->counter+=(i))
-#define __local_sub(i,v)	((v)->counter-=(i))
-
-/* Use these for per-cpu local_t variables: on some archs they are
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
-#endif /* _ARCH_PARISC_LOCAL_H */
+#include <asm-generic/local.h>
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
--- a/include/asm-s390/local.h
+++ b/include/asm-s390/local.h
@@ -1,58 +1 @@
-#ifndef _ASM_LOCAL_H
-#define _ASM_LOCAL_H
-
-#include <linux/percpu.h>
-#include <asm/atomic.h>
-
-#ifndef __s390x__
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
-#else
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
--- a/include/asm-sparc64/local.h
+++ b/include/asm-sparc64/local.h
@@ -1,40 +1 @@
-#ifndef _ARCH_SPARC64_LOCAL_H
-#define _ARCH_SPARC64_LOCAL_H
-
-#include <linux/percpu.h>
-#include <asm/atomic.h>
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
-#define __local_inc(v)		((v)->counter++)
-#define __local_dec(v)		((v)->counter--)
-#define __local_add(i,v)	((v)->counter+=(i))
-#define __local_sub(i,v)	((v)->counter-=(i))
-
-/* Use these for per-cpu local_t variables: on some archs they are
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
-#endif /* _ARCH_SPARC64_LOCAL_H */
+#include <asm-generic/local.h>
--- a/include/asm-x86_64/local.h
+++ b/include/asm-x86_64/local.h
@@ -2,49 +2,183 @@ #ifndef _ARCH_X8664_LOCAL_H
 #define _ARCH_X8664_LOCAL_H
 
 #include <linux/percpu.h>
+#include <asm/atomic.h>
 
 typedef struct
 {
-	volatile long counter;
+	atomic_long_t a;
 } local_t;
 
-#define LOCAL_INIT(i)	{ (i) }
+#define LOCAL_INIT(i)	{ ATOMIC_LONG_INIT(i) }
 
-#define local_read(v)	((v)->counter)
-#define local_set(v,i)	(((v)->counter) = (i))
+#define local_read(l)	atomic_long_read(&(l)->a)
+#define local_set(l,i)	atomic_long_set(&(l)->a, (i))
 
-static inline void local_inc(local_t *v)
+static inline void local_inc(local_t *l)
 {
 	__asm__ __volatile__(
 		"incq %0"
-		:"=m" (v->counter)
-		:"m" (v->counter));
+		:"=m" (l->a.counter)
+		:"m" (l->a.counter));
 }
 
-static inline void local_dec(local_t *v)
+static inline void local_dec(local_t *l)
 {
 	__asm__ __volatile__(
 		"decq %0"
-		:"=m" (v->counter)
-		:"m" (v->counter));
+		:"=m" (l->a.counter)
+		:"m" (l->a.counter));
 }
 
-static inline void local_add(long i, local_t *v)
+static inline void local_add(long i, local_t *l)
 {
 	__asm__ __volatile__(
 		"addq %1,%0"
-		:"=m" (v->counter)
-		:"ir" (i), "m" (v->counter));
+		:"=m" (l->a.counter)
+		:"ir" (i), "m" (l->a.counter));
 }
 
-static inline void local_sub(long i, local_t *v)
+static inline void local_sub(long i, local_t *l)
 {
 	__asm__ __volatile__(
 		"subq %1,%0"
-		:"=m" (v->counter)
-		:"ir" (i), "m" (v->counter));
+		:"=m" (l->a.counter)
+		:"ir" (i), "m" (l->a.counter));
 }
 
+/**
+ * local_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @l: pointer to type local_t
+ *
+ * Atomically subtracts @i from @l and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __inline__ int local_sub_and_test(long i, local_t *l)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"subq %2,%0; sete %1"
+		:"=m" (l->a.counter), "=qm" (c)
+		:"ir" (i), "m" (l->a.counter) : "memory");
+	return c;
+}
+
+/**
+ * local_dec_and_test - decrement and test
+ * @l: pointer to type local_t
+ *
+ * Atomically decrements @l by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static __inline__ int local_dec_and_test(local_t *l)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"decq %0; sete %1"
+		:"=m" (l->a.counter), "=qm" (c)
+		:"m" (l->a.counter) : "memory");
+	return c != 0;
+}
+
+/**
+ * local_inc_and_test - increment and test
+ * @l: pointer to type local_t
+ *
+ * Atomically increments @l by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static __inline__ int local_inc_and_test(local_t *l)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"incq %0; sete %1"
+		:"=m" (l->a.counter), "=qm" (c)
+		:"m" (l->a.counter) : "memory");
+	return c != 0;
+}
+
+/**
+ * local_add_negative - add and test if negative
+ * @i: integer value to add
+ * @l: pointer to type local_t
+ *
+ * Atomically adds @i to @l and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static __inline__ int local_add_negative(long i, local_t *l)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"addq %2,%0; sets %1"
+		:"=m" (l->a.counter), "=qm" (c)
+		:"ir" (i), "m" (l->a.counter) : "memory");
+	return c;
+}
+
+/**
+ * local_add_return - add and return
+ * @i: integer value to add
+ * @l: pointer to type local_t
+ *
+ * Atomically adds @i to @l and returns @i + @l
+ */
+static __inline__ long local_add_return(long i, local_t *l)
+{
+	long __i = i;
+	__asm__ __volatile__(
+		"xaddq %0, %1;"
+		:"=r"(i)
+		:"m"(l->a.counter), "0"(i));
+	return i + __i;
+}
+
+static __inline__ long local_sub_return(long i, local_t *l)
+{
+	return local_add_return(-i,l);
+}
+
+#define local_inc_return(l)  (local_add_return(1,l))
+#define local_dec_return(l)  (local_sub_return(1,l))
+
+#define local_cmpxchg(l, o, n) \
+	((long)cmpxchg_local(&((l)->a.counter), (o), (n)))
+/* Always has a lock prefix anyway */
+#define local_xchg(l, new) (xchg(&((l)->a.counter), new))
+
+/**
+ * atomic_up_add_unless - add unless the number is a given value
+ * @l: pointer of type local_t
+ * @a: the amount to add to l...
+ * @u: ...unless l is equal to u.
+ *
+ * Atomically adds @a to @l, so long as it was not @u.
+ * Returns non-zero if @l was not @u, and zero otherwise.
+ */
+#define local_add_unless(l, a, u)				\
+({								\
+	long c, old;						\
+	c = local_read(l);					\
+	for (;;) {						\
+		if (unlikely(c == (u)))				\
+			break;					\
+		old = local_cmpxchg((l), c, c + (a));	\
+		if (likely(old == c))				\
+			break;					\
+		c = old;					\
+	}							\
+	c != (u);						\
+})
+#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+
 /* On x86-64 these are better than the atomic variants on SMP kernels
    because they dont use a lock prefix. */
 #define __local_inc(l)		local_inc(l)
@@ -62,27 +196,27 @@ #define __local_sub(i,l)	local_sub((i),(
 
 /* Need to disable preemption for the cpu local counters otherwise we could
    still access a variable of a previous CPU in a non atomic way. */
-#define cpu_local_wrap_v(v)	 	\
+#define cpu_local_wrap_v(l)	 	\
 	({ local_t res__;		\
 	   preempt_disable(); 		\
-	   res__ = (v);			\
+	   res__ = (l);			\
 	   preempt_enable();		\
 	   res__; })
-#define cpu_local_wrap(v)		\
+#define cpu_local_wrap(l)		\
 	({ preempt_disable();		\
-	   v;				\
+	   l;				\
 	   preempt_enable(); })		\
 
-#define cpu_local_read(v)    cpu_local_wrap_v(local_read(&__get_cpu_var(v)))
-#define cpu_local_set(v, i)  cpu_local_wrap(local_set(&__get_cpu_var(v), (i)))
-#define cpu_local_inc(v)     cpu_local_wrap(local_inc(&__get_cpu_var(v)))
-#define cpu_local_dec(v)     cpu_local_wrap(local_dec(&__get_cpu_var(v)))
-#define cpu_local_add(i, v)  cpu_local_wrap(local_add((i), &__get_cpu_var(v)))
-#define cpu_local_sub(i, v)  cpu_local_wrap(local_sub((i), &__get_cpu_var(v)))
+#define cpu_local_read(l)    cpu_local_wrap_v(local_read(&__get_cpu_var(l)))
+#define cpu_local_set(l, i)  cpu_local_wrap(local_set(&__get_cpu_var(l), (i)))
+#define cpu_local_inc(l)     cpu_local_wrap(local_inc(&__get_cpu_var(l)))
+#define cpu_local_dec(l)     cpu_local_wrap(local_dec(&__get_cpu_var(l)))
+#define cpu_local_add(i, l)  cpu_local_wrap(local_add((i), &__get_cpu_var(l)))
+#define cpu_local_sub(i, l)  cpu_local_wrap(local_sub((i), &__get_cpu_var(l)))
 
-#define __cpu_local_inc(v)	cpu_local_inc(v)
-#define __cpu_local_dec(v)	cpu_local_dec(v)
-#define __cpu_local_add(i, v)	cpu_local_add((i), (v))
-#define __cpu_local_sub(i, v)	cpu_local_sub((i), (v))
+#define __cpu_local_inc(l)	cpu_local_inc(l)
+#define __cpu_local_dec(l)	cpu_local_dec(l)
+#define __cpu_local_add(i, l)	cpu_local_add((i), (l))
+#define __cpu_local_sub(i, l)	cpu_local_sub((i), (l))
 
-#endif /* _ARCH_I386_LOCAL_H */
+#endif /* _ARCH_X8664_LOCAL_H */
---END---

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
