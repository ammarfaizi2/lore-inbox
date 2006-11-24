Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966210AbWKXWAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966210AbWKXWAq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 17:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966236AbWKXWAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 17:00:45 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:16320 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S966210AbWKXWAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 17:00:42 -0500
Date: Fri, 24 Nov 2006 16:55:18 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: [PATCH 4/16] LTTng 0.6.36 for 2.6.18 : atomic UP operations on SMP
Message-ID: <20061124215518.GE25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:54:02 up 93 days, 19:01,  4 users,  load average: 0.84, 0.48, 0.32
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a UP flavor of SMP operations which is intended to provide
atomic modification of per-cpu data without suffering from the LOCK of memory
barrier performance cost. Note that extreme care must be taken when accessing
this data from different CPUs : smp_wmb() and smp_rmb() must be used
explicitely. As this last scenario happens very rarely in LTTng, it provides an
interesting performance gain.


Some tests to see the speedup given by using atomic-up.h on per cpu variables.

Non LOCKed atomic ops that I now use on SMP :

A test ran on a 3GHz Pentium 4 shows that (20000 loops) :

irq save/restore pair      210.60 ns

cmpxchg                     49.46 ns
    (76 % speedup)
cmpxchg-up (no lock prefix)  9.00 ns
    (95 % speedup)

On my 3GHz Pentium 4, it takes 255.83ns to log a 4 bytes event when the LOCK
prefix is used (without atomic-up). When I enable my modified version, it drops
to 205.63ns. Therefore, the speedup is :

(205.63-255.83)/255.83 * 100% = -19.62 %

(Test : 3*20000 loops of 4 bytes event log in flight recorder mode)

patch04-2.6.18-lttng-core-0.6.36-atomic_up.diff

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--BEGIN--
--- /dev/null
+++ b/include/asm-i386/atomic-up.h
@@ -0,0 +1,229 @@
+#ifndef __ARCH_I386_ATOMIC_UP__
+#define __ARCH_I386_ATOMIC_UP__
+
+#include <linux/compiler.h>
+#include <asm/processor.h>
+#include <asm/atomic.h>
+
+/* 
+ * atomic_up variants insure operation atomicity only if the variable is not
+ * shared between cpus. This is useful to have per-cpu atomic operations to
+ * protect from contexts like non-maskable interrupts without the LOCK prefix
+ * performance cost.
+ */
+
+/**
+ * atomic_up_add - add integer to atomic variable
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically adds @i to @v.
+ */
+static __inline__ void atomic_up_add(int i, atomic_t *v)
+{
+	__asm__ __volatile__(
+		"addl %1,%0"
+		:"+m" (v->counter)
+		:"ir" (i));
+}
+
+/**
+ * atomic_up_sub - subtract the atomic variable
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically subtracts @i from @v.
+ */
+static __inline__ void atomic_up_sub(int i, atomic_t *v)
+{
+	__asm__ __volatile__(
+		"subl %1,%0"
+		:"+m" (v->counter)
+		:"ir" (i));
+}
+
+/**
+ * atomic_up_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __inline__ int atomic_up_sub_and_test(int i, atomic_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"subl %2,%0; sete %1"
+		:"+m" (v->counter), "=qm" (c)
+		:"ir" (i) : "memory");
+	return c;
+}
+
+/**
+ * atomic_up_inc - increment atomic variable
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically increments @v by 1.
+ */ 
+static __inline__ void atomic_up_inc(atomic_t *v)
+{
+	__asm__ __volatile__(
+		"incl %0"
+		:"+m" (v->counter));
+}
+
+/**
+ * atomic_up_dec - decrement atomic variable
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically decrements @v by 1.
+ */ 
+static __inline__ void atomic_up_dec(atomic_t *v)
+{
+	__asm__ __volatile__(
+		"decl %0"
+		:"+m" (v->counter));
+}
+
+/**
+ * atomic_up_dec_and_test - decrement and test
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */ 
+static __inline__ int atomic_up_dec_and_test(atomic_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"decl %0; sete %1"
+		:"+m" (v->counter), "=qm" (c)
+		: : "memory");
+	return c != 0;
+}
+
+/**
+ * atomic_up_inc_and_test - increment and test 
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */ 
+static __inline__ int atomic_up_inc_and_test(atomic_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"incl %0; sete %1"
+		:"+m" (v->counter), "=qm" (c)
+		: : "memory");
+	return c != 0;
+}
+
+/**
+ * atomic_up_add_negative - add and test if negative
+ * @v: pointer of type atomic_t
+ * @i: integer value to add
+ * 
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */ 
+static __inline__ int atomic_up_add_negative(int i, atomic_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"addl %2,%0; sets %1"
+		:"+m" (v->counter), "=qm" (c)
+		:"ir" (i) : "memory");
+	return c;
+}
+
+/**
+ * atomic_up_add_return - add and return
+ * @v: pointer of type atomic_t
+ * @i: integer value to add
+ *
+ * Atomically adds @i to @v and returns @i + @v
+ */
+static __inline__ int atomic_up_add_return(int i, atomic_t *v)
+{
+	int __i;
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
+		:"m"(v->counter), "0"(i));
+	return i + __i;
+
+#ifdef CONFIG_M386
+no_xadd: /* Legacy 386 processor */
+	local_irq_save(flags);
+	__i = atomic_up_read(v);
+	atomic_up_set(v, i + __i);
+	local_irq_restore(flags);
+	return i + __i;
+#endif
+}
+
+static __inline__ int atomic_up_sub_return(int i, atomic_t *v)
+{
+	return atomic_up_add_return(-i,v);
+}
+
+#define atomic_up_cmpxchg(v, old, new) ((int)cmpxchg_up(&((v)->counter), \
+	old, new))
+/* xchg always has a LOCK prefix */
+#define atomic_up_xchg(v, new) (xchg(&((v)->counter), new))
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
+#define atomic_up_add_unless(v, a, u)				\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	for (;;) {						\
+		if (unlikely(c == (u)))				\
+			break;					\
+		old = atomic_up_cmpxchg((v), c, c + (a));	\
+		if (likely(old == c))				\
+			break;					\
+		c = old;					\
+	}							\
+	c != (u);						\
+})
+#define atomic_up_inc_not_zero(v) atomic_up_add_unless((v), 1, 0)
+
+#define atomic_up_inc_return(v)  (atomic_up_add_return(1,v))
+#define atomic_up_dec_return(v)  (atomic_up_sub_return(1,v))
+
+/* These are x86-specific, used by some header files */
+#define atomic_up_clear_mask(mask, addr) \
+__asm__ __volatile__("andl %0,%1" \
+: : "r" (~(mask)),"m" (*addr) : "memory")
+
+#define atomic_up_set_mask(mask, addr) \
+__asm__ __volatile__("orl %0,%1" \
+: : "r" (mask),"m" (*(addr)) : "memory")
+
+#endif
--- a/include/asm-i386/system.h
+++ b/include/asm-i386/system.h
@@ -267,6 +267,9 @@ #define __HAVE_ARCH_CMPXCHG 1
 #define cmpxchg(ptr,o,n)\
 	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
 					(unsigned long)(n),sizeof(*(ptr))))
+#define cmpxchg_up(ptr,o,n)\
+	((__typeof__(*(ptr)))__cmpxchg_up((ptr),(unsigned long)(o),\
+					(unsigned long)(n),sizeof(*(ptr))))
 #endif
 
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
@@ -296,6 +299,33 @@ static inline unsigned long __cmpxchg(vo
 	return old;
 }
 
+static inline unsigned long __cmpxchg_up(volatile void *ptr, unsigned long old,
+				      unsigned long new, int size)
+{
+	unsigned long prev;
+	switch (size) {
+	case 1:
+		__asm__ __volatile__("cmpxchgb %b1,%2"
+				     : "=a"(prev)
+				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 2:
+		__asm__ __volatile__("cmpxchgw %w1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 4:
+		__asm__ __volatile__("cmpxchgl %1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	}
+	return old;
+}
+
 #ifndef CONFIG_X86_CMPXCHG
 /*
  * Building a kernel capable running on 80386. It may be necessary to
@@ -332,6 +362,17 @@ ({									\
 					(unsigned long)(n), sizeof(*(ptr))); \
 	__ret;								\
 })
+#define cmpxchg_up(ptr,o,n)						\
+({									\
+	__typeof__(*(ptr)) __ret;					\
+	if (likely(boot_cpu_data.x86 > 3))				\
+		__ret = __cmpxchg_up((ptr), (unsigned long)(o),		\
+					(unsigned long)(n), sizeof(*(ptr))); \
+	else								\
+		__ret = cmpxchg_386((ptr), (unsigned long)(o),		\
+					(unsigned long)(n), sizeof(*(ptr))); \
+	__ret;								\
+})
 #endif
 
 #ifdef CONFIG_X86_CMPXCHG64
@@ -350,10 +391,26 @@ static inline unsigned long long __cmpxc
 	return prev;
 }
 
+static inline unsigned long long __cmpxchg64_up(volatile void *ptr, unsigned long long old,
+				      unsigned long long new)
+{
+	unsigned long long prev;
+	__asm__ __volatile__("cmpxchg8b %3"
+			     : "=A"(prev)
+			     : "b"((unsigned long)new),
+			       "c"((unsigned long)(new >> 32)),
+			       "m"(*__xg(ptr)),
+			       "0"(old)
+			     : "memory");
+	return prev;
+}
+
 #define cmpxchg64(ptr,o,n)\
 	((__typeof__(*(ptr)))__cmpxchg64((ptr),(unsigned long long)(o),\
 					(unsigned long long)(n)))
-
+#define cmpxchg64_up(ptr,o,n)\
+	((__typeof__(*(ptr)))__cmpxchg64_up((ptr),(unsigned long long)(o),\
+					(unsigned long long)(n)))
 #endif
     
 /*
--- /dev/null
+++ b/include/asm-x86_64/atomic-up.h
@@ -0,0 +1,375 @@
+#ifndef __ARCH_X86_64_ATOMIC_UP__
+#define __ARCH_X86_64_ATOMIC_UP__
+
+#include <asm/alternative.h>
+#include <asm/atomic.h>
+
+/* 
+ * atomic_up variants insure operation atomicity only if the variable is not
+ * shared between cpus. This is useful to have per-cpu atomic operations to
+ * protect from contexts like non-maskable interrupts without the LOCK prefix
+ * performance cost.
+ */
+
+/**
+ * atomic_up_add - add integer to atomic variable
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically adds @i to @v.
+ */
+static __inline__ void atomic_up_add(int i, atomic_t *v)
+{
+	__asm__ __volatile__(
+		"addl %1,%0"
+		:"=m" (v->counter)
+		:"ir" (i), "m" (v->counter));
+}
+
+/**
+ * atomic_up_sub - subtract the atomic variable
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically subtracts @i from @v.
+ */
+static __inline__ void atomic_up_sub(int i, atomic_t *v)
+{
+	__asm__ __volatile__(
+		"subl %1,%0"
+		:"=m" (v->counter)
+		:"ir" (i), "m" (v->counter));
+}
+
+/**
+ * atomic_up_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __inline__ int atomic_up_sub_and_test(int i, atomic_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"subl %2,%0; sete %1"
+		:"=m" (v->counter), "=qm" (c)
+		:"ir" (i), "m" (v->counter) : "memory");
+	return c;
+}
+
+/**
+ * atomic_up_inc - increment atomic variable
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically increments @v by 1.
+ */ 
+static __inline__ void atomic_up_inc(atomic_t *v)
+{
+	__asm__ __volatile__(
+		"incl %0"
+		:"=m" (v->counter)
+		:"m" (v->counter));
+}
+
+/**
+ * atomic_up_dec - decrement atomic variable
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically decrements @v by 1.
+ */ 
+static __inline__ void atomic_up_dec(atomic_t *v)
+{
+	__asm__ __volatile__(
+		"decl %0"
+		:"=m" (v->counter)
+		:"m" (v->counter));
+}
+
+/**
+ * atomic_up_dec_and_test - decrement and test
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */ 
+static __inline__ int atomic_up_dec_and_test(atomic_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"decl %0; sete %1"
+		:"=m" (v->counter), "=qm" (c)
+		:"m" (v->counter) : "memory");
+	return c != 0;
+}
+
+/**
+ * atomic_up_inc_and_test - increment and test 
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */ 
+static __inline__ int atomic_up_inc_and_test(atomic_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"incl %0; sete %1"
+		:"=m" (v->counter), "=qm" (c)
+		:"m" (v->counter) : "memory");
+	return c != 0;
+}
+
+/**
+ * atomic_up_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */ 
+static __inline__ int atomic_up_add_negative(int i, atomic_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		"addl %2,%0; sets %1"
+		:"=m" (v->counter), "=qm" (c)
+		:"ir" (i), "m" (v->counter) : "memory");
+	return c;
+}
+
+/**
+ * atomic_up_add_return - add and return
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically adds @i to @v and returns @i + @v
+ */
+static __inline__ int atomic_up_add_return(int i, atomic_t *v)
+{
+	int __i = i;
+	__asm__ __volatile__(
+		"xaddl %0, %1;"
+		:"=r"(i)
+		:"m"(v->counter), "0"(i));
+	return i + __i;
+}
+
+static __inline__ int atomic_up_sub_return(int i, atomic_t *v)
+{
+	return atomic_up_add_return(-i,v);
+}
+
+#define atomic_up_inc_return(v)  (atomic_up_add_return(1,v))
+#define atomic_up_dec_return(v)  (atomic_up_sub_return(1,v))
+
+/**
+ * atomic64_up_add - add integer to atomic64 variable
+ * @i: integer value to add
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically adds @i to @v.
+ */
+static __inline__ void atomic64_up_add(long i, atomic64_t *v)
+{
+	__asm__ __volatile__(
+		"addq %1,%0"
+		:"=m" (v->counter)
+		:"ir" (i), "m" (v->counter));
+}
+
+/**
+ * atomic64_up_sub - subtract the atomic64 variable
+ * @i: integer value to subtract
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically subtracts @i from @v.
+ */
+static __inline__ void atomic64_up_sub(long i, atomic64_t *v)
+{
+	__asm__ __volatile__(
+		"subq %1,%0"
+		:"=m" (v->counter)
+		:"ir" (i), "m" (v->counter));
+}
+
+/**
+ * atomic64_up_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __inline__ int atomic64_up_sub_and_test(long i, atomic64_t *v)
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
+ * atomic64_up_inc - increment atomic64 variable
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically increments @v by 1.
+ */
+static __inline__ void atomic64_up_inc(atomic64_t *v)
+{
+	__asm__ __volatile__(
+		"incq %0"
+		:"=m" (v->counter)
+		:"m" (v->counter));
+}
+
+/**
+ * atomic64_up_dec - decrement atomic64 variable
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically decrements @v by 1.
+ */
+static __inline__ void atomic64_up_dec(atomic64_t *v)
+{
+	__asm__ __volatile__(
+		"decq %0"
+		:"=m" (v->counter)
+		:"m" (v->counter));
+}
+
+/**
+ * atomic64_up_dec_and_test - decrement and test
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static __inline__ int atomic64_up_dec_and_test(atomic64_t *v)
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
+ * atomic64_up_inc_and_test - increment and test
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static __inline__ int atomic64_up_inc_and_test(atomic64_t *v)
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
+ * atomic64_up_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static __inline__ int atomic64_up_add_negative(long i, atomic64_t *v)
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
+ * atomic64_up_add_return - add and return
+ * @i: integer value to add
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically adds @i to @v and returns @i + @v
+ */
+static __inline__ long atomic64_up_add_return(long i, atomic64_t *v)
+{
+	long __i = i;
+	__asm__ __volatile__(
+		"xaddq %0, %1;"
+		:"=r"(i)
+		:"m"(v->counter), "0"(i));
+	return i + __i;
+}
+
+static __inline__ long atomic64_up_sub_return(long i, atomic64_t *v)
+{
+	return atomic64_up_add_return(-i,v);
+}
+
+#define atomic64_up_inc_return(v)  (atomic64_up_add_return(1,v))
+#define atomic64_up_dec_return(v)  (atomic64_up_sub_return(1,v))
+
+#define atomic_up_cmpxchg(v, old, new) ((int)cmpxchg_up(&((v)->counter), \
+	old, new))
+/* Always has a lock prefix anyway */
+#define atomic_up_xchg(v, new) (xchg(&((v)->counter), new))
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
+#define atomic_up_add_unless(v, a, u)				\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	for (;;) {						\
+		if (unlikely(c == (u)))				\
+			break;					\
+		old = atomic_up_cmpxchg((v), c, c + (a));		\
+		if (likely(old == c))				\
+			break;					\
+		c = old;					\
+	}							\
+	c != (u);						\
+})
+#define atomic_up_inc_not_zero(v) atomic_up_add_unless((v), 1, 0)
+
+/* These are x86-specific, used by some header files */
+#define atomic_up_clear_mask(mask, addr) \
+__asm__ __volatile__("andl %0,%1" \
+: : "r" (~(mask)),"m" (*addr) : "memory")
+
+#define atomic_up_set_mask(mask, addr) \
+__asm__ __volatile__("orl %0,%1" \
+: : "r" ((unsigned)mask),"m" (*(addr)) : "memory")
+
+#endif
--- a/include/asm-x86_64/system.h
+++ b/include/asm-x86_64/system.h
@@ -208,9 +208,45 @@ static inline unsigned long __cmpxchg(vo
 	return old;
 }
 
+static inline unsigned long __cmpxchg_up(volatile void *ptr, unsigned long old,
+				      unsigned long new, int size)
+{
+	unsigned long prev;
+	switch (size) {
+	case 1:
+		__asm__ __volatile__("cmpxchgb %b1,%2"
+				     : "=a"(prev)
+				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 2:
+		__asm__ __volatile__("cmpxchgw %w1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 4:
+		__asm__ __volatile__("cmpxchgl %k1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 8:
+		__asm__ __volatile__("cmpxchgq %1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	}
+	return old;
+}
+
 #define cmpxchg(ptr,o,n)\
 	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
 					(unsigned long)(n),sizeof(*(ptr))))
+#define cmpxchg_up(ptr,o,n)\
+	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
+					(unsigned long)(n),sizeof(*(ptr))))
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
--- /dev/null
+++ b/include/asm-powerpc/atomic-up.h
@@ -0,0 +1,380 @@
+#ifndef _ASM_POWERPC_ATOMIC_UP_H_
+#define _ASM_POWERPC_ATOMIC_UP_H_
+
+#ifdef __KERNEL__
+#include <linux/compiler.h>
+#include <asm/synch.h>
+#include <asm/asm-compat.h>
+#include <asm/atomic.h>
+
+/* 
+ * atomic_up variants insure operation atomicity only if the variable is not
+ * shared between cpus. This is useful to have per-cpu atomic operations to
+ * protect from contexts like non-maskable interrupts without the LOCK prefix
+ * performance cost.
+ */
+
+static __inline__ void atomic_up_add(int a, atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%3		# atomic_up_add\n\
+	add	%0,%2,%0\n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%0,0,%3 \n\
+	bne-	1b"
+	: "=&r" (t), "+m" (v->counter)
+	: "r" (a), "r" (&v->counter)
+	: "cc");
+}
+
+static __inline__ int atomic_up_add_return(int a, atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%2		# atomic_up_add_return\n\
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
+#define atomic_up_add_negative(a, v)	(atomic_up_add_return((a), (v)) < 0)
+
+static __inline__ void atomic_up_sub(int a, atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%3		# atomic_up_sub\n\
+	subf	%0,%2,%0\n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%0,0,%3 \n\
+	bne-	1b"
+	: "=&r" (t), "+m" (v->counter)
+	: "r" (a), "r" (&v->counter)
+	: "cc");
+}
+
+static __inline__ int atomic_up_sub_return(int a, atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%2		# atomic_up_sub_return\n\
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
+static __inline__ void atomic_up_inc(atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%2		# atomic_up_inc\n\
+	addic	%0,%0,1\n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%0,0,%2 \n\
+	bne-	1b"
+	: "=&r" (t), "+m" (v->counter)
+	: "r" (&v->counter)
+	: "cc");
+}
+
+static __inline__ int atomic_up_inc_return(atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%1		# atomic_up_inc_return\n\
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
+ * atomic_up_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic_up_inc_and_test(v) (atomic_up_inc_return(v) == 0)
+
+static __inline__ void atomic_up_dec(atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%2		# atomic_up_dec\n\
+	addic	%0,%0,-1\n"
+	PPC405_ERR77(0,%2)\
+"	stwcx.	%0,0,%2\n\
+	bne-	1b"
+	: "=&r" (t), "+m" (v->counter)
+	: "r" (&v->counter)
+	: "cc");
+}
+
+static __inline__ int atomic_up_dec_return(atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%1		# atomic_up_dec_return\n\
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
+#define atomic_up_cmpxchg(v, o, n) ((int)cmpxchg_up(&((v)->counter), (o), (n)))
+#define atomic_up_xchg(v, new) (xchg_up(&((v)->counter), new))
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
+static __inline__ int atomic_up_add_unless(atomic_t *v, int a, int u)
+{
+	int t;
+
+	__asm__ __volatile__ (
+"1:	lwarx	%0,0,%1		# atomic_up_add_unless\n\
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
+#define atomic_up_inc_not_zero(v) atomic_up_add_unless((v), 1, 0)
+
+#define atomic_up_sub_and_test(a, v)	(atomic_up_sub_return((a), (v)) == 0)
+#define atomic_up_dec_and_test(v)	(atomic_up_dec_return((v)) == 0)
+
+/*
+ * Atomically test *v and decrement if it is greater than 0.
+ * The function returns the old value of *v minus 1.
+ */
+static __inline__ int atomic_up_dec_if_positive(atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%1		# atomic_up_dec_if_positive\n\
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
+#ifdef __powerpc64__
+
+static __inline__ void atomic64_up_add(long a, atomic64_t *v)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%3		# atomic64_up_add\n\
+	add	%0,%2,%0\n\
+	stdcx.	%0,0,%3 \n\
+	bne-	1b"
+	: "=&r" (t), "+m" (v->counter)
+	: "r" (a), "r" (&v->counter)
+	: "cc");
+}
+
+static __inline__ long atomic64_up_add_return(long a, atomic64_t *v)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%2		# atomic64_up_add_return\n\
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
+#define atomic64_up_add_negative(a, v)	(atomic64_up_add_return((a), (v)) < 0)
+
+static __inline__ void atomic64_up_sub(long a, atomic64_t *v)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%3		# atomic64_up_sub\n\
+	subf	%0,%2,%0\n\
+	stdcx.	%0,0,%3 \n\
+	bne-	1b"
+	: "=&r" (t), "+m" (v->counter)
+	: "r" (a), "r" (&v->counter)
+	: "cc");
+}
+
+static __inline__ long atomic64_up_sub_return(long a, atomic64_t *v)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%2		# atomic64_up_sub_return\n\
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
+static __inline__ void atomic64_up_inc(atomic64_t *v)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%2		# atomic64_up_inc\n\
+	addic	%0,%0,1\n\
+	stdcx.	%0,0,%2 \n\
+	bne-	1b"
+	: "=&r" (t), "+m" (v->counter)
+	: "r" (&v->counter)
+	: "cc");
+}
+
+static __inline__ long atomic64_up_inc_return(atomic64_t *v)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%1		# atomic64_up_inc_return\n\
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
+ * atomic64_up_inc_and_test - increment and test
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic64_up_inc_and_test(v) (atomic64_up_inc_return(v) == 0)
+
+static __inline__ void atomic64_up_dec(atomic64_t *v)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%2		# atomic64_up_dec\n\
+	addic	%0,%0,-1\n\
+	stdcx.	%0,0,%2\n\
+	bne-	1b"
+	: "=&r" (t), "+m" (v->counter)
+	: "r" (&v->counter)
+	: "cc");
+}
+
+static __inline__ long atomic64_up_dec_return(atomic64_t *v)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%1		# atomic64_up_dec_return\n\
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
+#define atomic64_up_sub_and_test(a, v)	(atomic64_up_sub_return((a), (v)) == 0)
+#define atomic64_up_dec_and_test(v)	(atomic64_up_dec_return((v)) == 0)
+
+/*
+ * Atomically test *v and decrement if it is greater than 0.
+ * The function returns the old value of *v minus 1.
+ */
+static __inline__ long atomic64_up_dec_if_positive(atomic64_t *v)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%1		# atomic64_up_dec_if_positive\n\
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
+#endif /* __powerpc64__ */
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_ATOMIC_UP_H_ */
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -235,6 +235,29 @@ __xchg_u32(volatile void *p, unsigned lo
 	return prev;
 }
 
+/*
+ * Atomic exchange
+ *
+ * Changes the memory location '*ptr' to be val and returns
+ * the previous value stored there.
+ */
+static __inline__ unsigned long
+__xchg_u32_up(volatile void *p, unsigned long val)
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
@@ -254,6 +277,23 @@ __xchg_u64(volatile void *p, unsigned lo
 
 	return prev;
 }
+
+static __inline__ unsigned long
+__xchg_u64_up(volatile void *p, unsigned long val)
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
@@ -277,12 +317,32 @@ #endif
 	return x;
 }
 
+static __inline__ unsigned long
+__xchg_up(volatile void *ptr, unsigned long x, unsigned int size)
+{
+	switch (size) {
+	case 4:
+		return __xchg_u32_up(ptr, x);
+#ifdef CONFIG_PPC64
+	case 8:
+		return __xchg_u64_up(ptr, x);
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
 
+#define xchg_up(ptr,x)							     \
+  ({									     \
+     __typeof__(*(ptr)) _x_ = (x);					     \
+     (__typeof__(*(ptr))) __xchg_up((ptr), (unsigned long)_x_, sizeof(*(ptr))); \
+  })
+
 #define tas(ptr) (xchg((ptr),1))
 
 /*
@@ -314,6 +374,27 @@ __cmpxchg_u32(volatile unsigned int *p, 
 	return prev;
 }
 
+static __inline__ unsigned long
+__cmpxchg_u32_up(volatile unsigned int *p, unsigned long old, unsigned long new)
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
@@ -336,6 +417,26 @@ __cmpxchg_u64(volatile unsigned long *p,
 
 	return prev;
 }
+
+static __inline__ unsigned long
+__cmpxchg_u64_up(volatile unsigned long *p, unsigned long old, unsigned long new)
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
@@ -358,6 +459,22 @@ #endif
 	return old;
 }
 
+static __inline__ unsigned long
+__cmpxchg_up(volatile void *ptr, unsigned long old, unsigned long new,
+	  unsigned int size)
+{
+	switch (size) {
+	case 4:
+		return __cmpxchg_u32_up(ptr, old, new);
+#ifdef CONFIG_PPC64
+	case 8:
+		return __cmpxchg_u64_up(ptr, old, new);
+#endif
+	}
+	__cmpxchg_called_with_bad_pointer();
+	return old;
+}
+
 #define cmpxchg(ptr,o,n)						 \
   ({									 \
      __typeof__(*(ptr)) _o_ = (o);					 \
@@ -366,6 +483,15 @@ #define cmpxchg(ptr,o,n)						 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
   })
 
+
+#define cmpxchg_up(ptr,o,n)						 \
+  ({									 \
+     __typeof__(*(ptr)) _o_ = (o);					 \
+     __typeof__(*(ptr)) _n_ = (n);					 \
+     (__typeof__(*(ptr))) __cmpxchg_up((ptr), (unsigned long)_o_,	 \
+				    (unsigned long)_n_, sizeof(*(ptr))); \
+  })
+
 #ifdef CONFIG_PPC64
 /*
  * We handle most unaligned accesses in hardware. On the other hand 
--- /dev/null
+++ b/include/asm-arm/atomic-up.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_ATOMIC_UP_H
+#define _ASM_ATOMIC_UP_H
+
+#include <asm-generic/atomic-up.h>
+
+#endif
--- /dev/null
+++ b/include/asm-mips/atomic-up.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_ATOMIC_UP_H
+#define _ASM_ATOMIC_UP_H
+
+#include <asm-generic/atomic-up.h>
+
+#endif
--- /dev/null
+++ b/include/asm-generic/atomic-up.h
@@ -0,0 +1,49 @@
+#ifndef _ASM_GENERIC_ATOMIC_UP_H
+#define _ASM_GENERIC_ATOMIC_UP_H
+
+/* Uniprocessor atomic operations.
+ *
+ * The generic version of up-only atomic ops falls back on atomic.h.
+ */
+
+#include <asm/atomic.h>
+
+#define atomic_up_add atomic_add
+#define atomic_up_sub atomic_sub
+#define atomic_up_add_return atomic_add_return
+#define atomic_up_sub_return atomic_sub_return
+#define atomic_up_sub_if_positive atomic_sub_if_positive
+#define atomic_up_cmpxchg atomic_cmpxchg
+#define atomic_up_xchg atomic_xchg
+#define atomic_up_add_unless atomic_add_unless
+#define atomic_up_inc_not_zero atomic_inc_not_zero
+#define atomic_up_dec_return atomic_dec_return
+#define atomic_up_inc_return atomic_inc_return
+#define atomic_up_sub_and_test atomic_sub_and_test
+#define atomic_up_inc_and_test atomic_inc_and_test
+#define atomic_up_dec_and_test atomic_dec_and_test
+#define atomic_up_dec_if_positive atomic_dec_if_positive
+#define atomic_up_inc atomic_inc
+#define atomic_up_dec atomic_dec
+#define atomic_up_add_negative atomic_add_negative
+
+#ifdef CONFIG_64BIT
+
+#define atomic64_up_add atomic64_add
+#define atomic64_up_sub atomic64_sub
+#define atomic64_up_add_return atomic64_add_return
+#define atomic64_up_sub_return atomic64_sub_return
+#define atomic64_up_sub_if_positive atomic64_sub_if_positive
+#define atomic64_up_dec_return atomic64_dec_return
+#define atomic64_up_inc_return atomic64_inc_return
+#define atomic64_up_sub_and_test atomic64_sub_and_test
+#define atomic64_up_inc_and_test atomic64_inc_and_test
+#define atomic64_up_dec_and_test atomic64_dec_and_test
+#define atomic64_up_dec_if_positive atomic64_dec_if_positive
+#define atomic64_up_inc atomic64_inc
+#define atomic64_up_dec atomic64_dec
+#define atomic64_up_add_negative atomic64_add_negative
+
+#endif /* CONFIG_64BIT */
+
+#endif /* _ASM_GENERIC_ATOMIC_UP_H */
--END--


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
