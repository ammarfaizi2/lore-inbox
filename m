Return-Path: <linux-kernel-owner+w=401wt.eu-S1030460AbXALBxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbXALBxi (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 20:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbXALBxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 20:53:19 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:45630 "EHLO
	tomts10-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932822AbXALBxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 20:53:17 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [PATCH 02/10] local_t : alpha extension
Date: Thu, 11 Jan 2007 20:42:53 -0500
Message-Id: <11685661823444-git-send-email-mathieu.desnoyers@polymtl.ca>
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <11685661813181-git-send-email-mathieu.desnoyers@polymtl.ca>
References: <11685661813181-git-send-email-mathieu.desnoyers@polymtl.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

local_t : alpha extension

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-alpha/local.h
+++ b/include/asm-alpha/local.h
@@ -4,37 +4,115 @@
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
--- a/include/asm-alpha/system.h
+++ b/include/asm-alpha/system.h
@@ -443,6 +443,111 @@ extern void __xchg_called_with_bad_pointer(void);
      (__typeof__(*(ptr))) __xchg((ptr), (unsigned long)_x_, sizeof(*(ptr))); \
   })
 
+static inline unsigned long
+__xchg_u8_local(volatile char *m, unsigned long val)
+{
+	unsigned long ret, tmp, addr64;
+
+	__asm__ __volatile__(
+	"	andnot	%4,7,%3\n"
+	"	insbl	%1,%4,%1\n"
+	"1:	ldq_l	%2,0(%3)\n"
+	"	extbl	%2,%4,%0\n"
+	"	mskbl	%2,%4,%2\n"
+	"	or	%1,%2,%2\n"
+	"	stq_c	%2,0(%3)\n"
+	"	beq	%2,2f\n"
+	".subsection 2\n"
+	"2:	br	1b\n"
+	".previous"
+	: "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
+	: "r" ((long)m), "1" (val) : "memory");
+
+	return ret;
+}
+
+static inline unsigned long
+__xchg_u16_local(volatile short *m, unsigned long val)
+{
+	unsigned long ret, tmp, addr64;
+
+	__asm__ __volatile__(
+	"	andnot	%4,7,%3\n"
+	"	inswl	%1,%4,%1\n"
+	"1:	ldq_l	%2,0(%3)\n"
+	"	extwl	%2,%4,%0\n"
+	"	mskwl	%2,%4,%2\n"
+	"	or	%1,%2,%2\n"
+	"	stq_c	%2,0(%3)\n"
+	"	beq	%2,2f\n"
+	".subsection 2\n"
+	"2:	br	1b\n"
+	".previous"
+	: "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
+	: "r" ((long)m), "1" (val) : "memory");
+
+	return ret;
+}
+
+static inline unsigned long
+__xchg_u32_local(volatile int *m, unsigned long val)
+{
+	unsigned long dummy;
+
+	__asm__ __volatile__(
+	"1:	ldl_l %0,%4\n"
+	"	bis $31,%3,%1\n"
+	"	stl_c %1,%2\n"
+	"	beq %1,2f\n"
+	".subsection 2\n"
+	"2:	br 1b\n"
+	".previous"
+	: "=&r" (val), "=&r" (dummy), "=m" (*m)
+	: "rI" (val), "m" (*m) : "memory");
+
+	return val;
+}
+
+static inline unsigned long
+__xchg_u64_local(volatile long *m, unsigned long val)
+{
+	unsigned long dummy;
+
+	__asm__ __volatile__(
+	"1:	ldq_l %0,%4\n"
+	"	bis $31,%3,%1\n"
+	"	stq_c %1,%2\n"
+	"	beq %1,2f\n"
+	".subsection 2\n"
+	"2:	br 1b\n"
+	".previous"
+	: "=&r" (val), "=&r" (dummy), "=m" (*m)
+	: "rI" (val), "m" (*m) : "memory");
+
+	return val;
+}
+
+#define __xchg_local(ptr, x, size) \
+({ \
+	unsigned long __xchg__res; \
+	volatile void *__xchg__ptr = (ptr); \
+	switch (size) { \
+		case 1: __xchg__res = __xchg_u8_local(__xchg__ptr, x); break; \
+		case 2: __xchg__res = __xchg_u16_local(__xchg__ptr, x); break; \
+		case 4: __xchg__res = __xchg_u32_local(__xchg__ptr, x); break; \
+		case 8: __xchg__res = __xchg_u64_local(__xchg__ptr, x); break; \
+		default: __xchg_called_with_bad_pointer(); __xchg__res = x; \
+	} \
+	__xchg__res; \
+})
+
+#define xchg_local(ptr,x)						     \
+  ({									     \
+     __typeof__(*(ptr)) _x_ = (x);					     \
+     (__typeof__(*(ptr))) __xchg_local((ptr), (unsigned long)_x_,	     \
+     		sizeof(*(ptr))); \
+  })
+
 #define tas(ptr) (xchg((ptr),1))
 
 
@@ -596,6 +701,128 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 				    (unsigned long)_n_, sizeof(*(ptr))); \
   })
 
+static inline unsigned long
+__cmpxchg_u8_local(volatile char *m, long old, long new)
+{
+	unsigned long prev, tmp, cmp, addr64;
+
+	__asm__ __volatile__(
+	"	andnot	%5,7,%4\n"
+	"	insbl	%1,%5,%1\n"
+	"1:	ldq_l	%2,0(%4)\n"
+	"	extbl	%2,%5,%0\n"
+	"	cmpeq	%0,%6,%3\n"
+	"	beq	%3,2f\n"
+	"	mskbl	%2,%5,%2\n"
+	"	or	%1,%2,%2\n"
+	"	stq_c	%2,0(%4)\n"
+	"	beq	%2,3f\n"
+	"2:\n"
+	".subsection 2\n"
+	"3:	br	1b\n"
+	".previous"
+	: "=&r" (prev), "=&r" (new), "=&r" (tmp), "=&r" (cmp), "=&r" (addr64)
+	: "r" ((long)m), "Ir" (old), "1" (new) : "memory");
+
+	return prev;
+}
+
+static inline unsigned long
+__cmpxchg_u16_local(volatile short *m, long old, long new)
+{
+	unsigned long prev, tmp, cmp, addr64;
+
+	__asm__ __volatile__(
+	"	andnot	%5,7,%4\n"
+	"	inswl	%1,%5,%1\n"
+	"1:	ldq_l	%2,0(%4)\n"
+	"	extwl	%2,%5,%0\n"
+	"	cmpeq	%0,%6,%3\n"
+	"	beq	%3,2f\n"
+	"	mskwl	%2,%5,%2\n"
+	"	or	%1,%2,%2\n"
+	"	stq_c	%2,0(%4)\n"
+	"	beq	%2,3f\n"
+	"2:\n"
+	".subsection 2\n"
+	"3:	br	1b\n"
+	".previous"
+	: "=&r" (prev), "=&r" (new), "=&r" (tmp), "=&r" (cmp), "=&r" (addr64)
+	: "r" ((long)m), "Ir" (old), "1" (new) : "memory");
+
+	return prev;
+}
+
+static inline unsigned long
+__cmpxchg_u32_local(volatile int *m, int old, int new)
+{
+	unsigned long prev, cmp;
+
+	__asm__ __volatile__(
+	"1:	ldl_l %0,%5\n"
+	"	cmpeq %0,%3,%1\n"
+	"	beq %1,2f\n"
+	"	mov %4,%1\n"
+	"	stl_c %1,%2\n"
+	"	beq %1,3f\n"
+	"2:\n"
+	".subsection 2\n"
+	"3:	br 1b\n"
+	".previous"
+	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
+	: "r"((long) old), "r"(new), "m"(*m) : "memory");
+
+	return prev;
+}
+
+static inline unsigned long
+__cmpxchg_u64_local(volatile long *m, unsigned long old, unsigned long new)
+{
+	unsigned long prev, cmp;
+
+	__asm__ __volatile__(
+	"1:	ldq_l %0,%5\n"
+	"	cmpeq %0,%3,%1\n"
+	"	beq %1,2f\n"
+	"	mov %4,%1\n"
+	"	stq_c %1,%2\n"
+	"	beq %1,3f\n"
+	"2:\n"
+	".subsection 2\n"
+	"3:	br 1b\n"
+	".previous"
+	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
+	: "r"((long) old), "r"(new), "m"(*m) : "memory");
+
+	return prev;
+}
+
+static __always_inline unsigned long
+__cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
+		int size)
+{
+	switch (size) {
+		case 1:
+			return __cmpxchg_u8_local(ptr, old, new);
+		case 2:
+			return __cmpxchg_u16_local(ptr, old, new);
+		case 4:
+			return __cmpxchg_u32_local(ptr, old, new);
+		case 8:
+			return __cmpxchg_u64_local(ptr, old, new);
+	}
+	__cmpxchg_called_with_bad_pointer();
+	return old;
+}
+
+#define cmpxchg_local(ptr,o,n)						 \
+  ({									 \
+     __typeof__(*(ptr)) _o_ = (o);					 \
+     __typeof__(*(ptr)) _n_ = (n);					 \
+     (__typeof__(*(ptr))) __cmpxchg_local((ptr), (unsigned long)_o_,	 \
+				    (unsigned long)_n_, sizeof(*(ptr))); \
+  })
+
 #endif /* __ASSEMBLY__ */
 
 #define arch_align_stack(x) (x)
