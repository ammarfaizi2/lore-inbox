Return-Path: <linux-kernel-owner+w=401wt.eu-S1161079AbWLUAZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWLUAZT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWLUAZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:25:18 -0500
Received: from tomts25.bellnexxia.net ([209.226.175.188]:37877 "EHLO
	tomts25-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161079AbWLUAZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:25:14 -0500
Date: Wed, 20 Dec 2006 19:25:08 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>,
       Linux-MIPS <linux-mips@linux-mips.org>
Cc: ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5/10] local_t : ia64
Message-ID: <20061221002508.GU28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061221001545.GP28643@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:23:50 up 119 days, 21:31,  6 users,  load average: 2.21, 2.10, 1.85
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 architecture local_t extension.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-mips/system.h
+++ b/include/asm-mips/system.h
@@ -253,6 +253,58 @@ static inline unsigned long __cmpxchg_u3
 	return retval;
 }
 
+static inline unsigned long __cmpxchg_u32_local(volatile int * m,
+	unsigned long old, unsigned long new)
+{
+	__u32 retval;
+
+	if (cpu_has_llsc && R10000_LLSC_WAR) {
+		__asm__ __volatile__(
+		"	.set	push					\n"
+		"	.set	noat					\n"
+		"	.set	mips3					\n"
+		"1:	ll	%0, %2			# __cmpxchg_u32	\n"
+		"	bne	%0, %z3, 2f				\n"
+		"	.set	mips0					\n"
+		"	move	$1, %z4					\n"
+		"	.set	mips3					\n"
+		"	sc	$1, %1					\n"
+		"	beqzl	$1, 1b					\n"
+		"2:							\n"
+		"	.set	pop					\n"
+		: "=&r" (retval), "=R" (*m)
+		: "R" (*m), "Jr" (old), "Jr" (new)
+		: "memory");
+	} else if (cpu_has_llsc) {
+		__asm__ __volatile__(
+		"	.set	push					\n"
+		"	.set	noat					\n"
+		"	.set	mips3					\n"
+		"1:	ll	%0, %2			# __cmpxchg_u32	\n"
+		"	bne	%0, %z3, 2f				\n"
+		"	.set	mips0					\n"
+		"	move	$1, %z4					\n"
+		"	.set	mips3					\n"
+		"	sc	$1, %1					\n"
+		"	beqz	$1, 1b					\n"
+		"2:							\n"
+		"	.set	pop					\n"
+		: "=&r" (retval), "=R" (*m)
+		: "R" (*m), "Jr" (old), "Jr" (new)
+		: "memory");
+	} else {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		retval = *m;
+		if (retval == old)
+			*m = new;
+		local_irq_restore(flags);	/* implies memory barrier  */
+	}
+
+	return retval;
+}
+
 #ifdef CONFIG_64BIT
 static inline unsigned long __cmpxchg_u64(volatile int * m, unsigned long old,
 	unsigned long new)
@@ -303,10 +355,62 @@ static inline unsigned long __cmpxchg_u6
 
 	return retval;
 }
+
+static inline unsigned long __cmpxchg_u64_local(volatile int * m,
+	unsigned long old, unsigned long new)
+{
+	__u64 retval;
+
+	if (cpu_has_llsc && R10000_LLSC_WAR) {
+		__asm__ __volatile__(
+		"	.set	push					\n"
+		"	.set	noat					\n"
+		"	.set	mips3					\n"
+		"1:	lld	%0, %2			# __cmpxchg_u64	\n"
+		"	bne	%0, %z3, 2f				\n"
+		"	move	$1, %z4					\n"
+		"	scd	$1, %1					\n"
+		"	beqzl	$1, 1b					\n"
+		"2:							\n"
+		"	.set	pop					\n"
+		: "=&r" (retval), "=R" (*m)
+		: "R" (*m), "Jr" (old), "Jr" (new)
+		: "memory");
+	} else if (cpu_has_llsc) {
+		__asm__ __volatile__(
+		"	.set	push					\n"
+		"	.set	noat					\n"
+		"	.set	mips3					\n"
+		"1:	lld	%0, %2			# __cmpxchg_u64	\n"
+		"	bne	%0, %z3, 2f				\n"
+		"	move	$1, %z4					\n"
+		"	scd	$1, %1					\n"
+		"	beqz	$1, 1b					\n"
+		"2:							\n"
+		"	.set	pop					\n"
+		: "=&r" (retval), "=R" (*m)
+		: "R" (*m), "Jr" (old), "Jr" (new)
+		: "memory");
+	} else {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		retval = *m;
+		if (retval == old)
+			*m = new;
+		local_irq_restore(flags);	/* implies memory barrier  */
+	}
+
+	return retval;
+}
+
 #else
 extern unsigned long __cmpxchg_u64_unsupported_on_32bit_kernels(
 	volatile int * m, unsigned long old, unsigned long new);
 #define __cmpxchg_u64 __cmpxchg_u64_unsupported_on_32bit_kernels
+extern unsigned long __cmpxchg_u64_local_unsupported_on_32bit_kernels(
+	volatile int * m, unsigned long old, unsigned long new);
+#define __cmpxchg_u64_local __cmpxchg_u64_local_unsupported_on_32bit_kernels
 #endif
 
 /* This function doesn't exist, so you'll get a linker error
@@ -326,7 +430,26 @@ static inline unsigned long __cmpxchg(vo
 	return old;
 }
 
-#define cmpxchg(ptr,old,new) ((__typeof__(*(ptr)))__cmpxchg((ptr), (unsigned long)(old), (unsigned long)(new),sizeof(*(ptr))))
+static inline unsigned long __cmpxchg_local(volatile void * ptr,
+	unsigned long old, unsigned long new, int size)
+{
+	switch (size) {
+	case 4:
+		return __cmpxchg_u32_local(ptr, old, new);
+	case 8:
+		return __cmpxchg_u64_local(ptr, old, new);
+	}
+	__cmpxchg_called_with_bad_pointer();
+	return old;
+}
+
+#define cmpxchg(ptr,old,new) \
+	((__typeof__(*(ptr)))__cmpxchg((ptr), \
+		(unsigned long)(old), (unsigned long)(new),sizeof(*(ptr))))
+
+#define cmpxchg_local(ptr,old,new) \
+	((__typeof__(*(ptr)))__cmpxchg_local((ptr), \
+		(unsigned long)(old), (unsigned long)(new),sizeof(*(ptr))))
 
 extern void set_handler (unsigned long offset, void *addr, unsigned long len);
 extern void set_uncached_handler (unsigned long offset, void *addr, unsigned long len);
--- a/include/asm-mips/local.h
+++ b/include/asm-mips/local.h
@@ -1,60 +1,527 @@
-#ifndef _ASM_LOCAL_H
-#define _ASM_LOCAL_H
+#ifndef _ARCH_POWERPC_LOCAL_H
+#define _ARCH_POWERPC_LOCAL_H
 
 #include <linux/percpu.h>
 #include <asm/atomic.h>
 
-#ifdef CONFIG_32BIT
+typedef struct
+{
+	local_long_t a;
+} local_t;
 
-typedef atomic_t local_t;
+#define LOCAL_INIT(i)	{ local_LONG_INIT(i) }
 
-#define LOCAL_INIT(i)	ATOMIC_INIT(i)
-#define local_read(v)	atomic_read(v)
-#define local_set(v,i)	atomic_set(v,i)
+#define local_read(l)	local_long_read(&(l)->a)
+#define local_set(l,i)	local_long_set(&(l)->a, (i))
 
-#define local_inc(v)	atomic_inc(v)
-#define local_dec(v)	atomic_dec(v)
-#define local_add(i, v)	atomic_add(i, v)
-#define local_sub(i, v)	atomic_sub(i, v)
+#define local_add(i,l)	local_long_add((i),(&(l)->a))
+#define local_sub(i,l)	local_long_sub((i),(&(l)->a))
+#define local_inc(l)	local_long_inc(&(l)->a)
+#define local_dec(l)	local_long_dec(&(l)->a)
 
-#endif
 
-#ifdef CONFIG_64BIT
+#ifndef CONFIG_64BITS
 
-typedef atomic64_t local_t;
+/*
+ * Same as above, but return the result value
+ */
+static __inline__ int local_add_return(int i, local_t * l)
+{
+	unsigned long result;
+
+	if (cpu_has_llsc && R10000_LLSC_WAR) {
+		unsigned long temp;
+
+		__asm__ __volatile__(
+		"	.set	mips3					\n"
+		"1:	ll	%1, %2		# local_add_return	\n"
+		"	addu	%0, %1, %3				\n"
+		"	sc	%0, %2					\n"
+		"	beqzl	%0, 1b					\n"
+		"	addu	%0, %1, %3				\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp), "=m" (&(l->a.counter))
+		: "Ir" (i), "m" (&(l->a.counter))
+		: "memory");
+	} else if (cpu_has_llsc) {
+		unsigned long temp;
+
+		__asm__ __volatile__(
+		"	.set	mips3					\n"
+		"1:	ll	%1, %2		# local_add_return	\n"
+		"	addu	%0, %1, %3				\n"
+		"	sc	%0, %2					\n"
+		"	beqz	%0, 1b					\n"
+		"	addu	%0, %1, %3				\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp), "=m" (&(l->a.counter))
+		: "Ir" (i), "m" (&(l->a.counter))
+		: "memory");
+	} else {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		result = &(l->a.counter);
+		result += i;
+		&(l->a.counter) = result;
+		local_irq_restore(flags);
+	}
+
+	return result;
+}
+
+static __inline__ int local_sub_return(int i, local_t * l)
+{
+	unsigned long result;
+
+	if (cpu_has_llsc && R10000_LLSC_WAR) {
+		unsigned long temp;
+
+		__asm__ __volatile__(
+		"	.set	mips3					\n"
+		"1:	ll	%1, %2		# local_sub_return	\n"
+		"	subu	%0, %1, %3				\n"
+		"	sc	%0, %2					\n"
+		"	beqzl	%0, 1b					\n"
+		"	subu	%0, %1, %3				\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp), "=m" (&(l->a.counter))
+		: "Ir" (i), "m" (&(l->a.counter))
+		: "memory");
+	} else if (cpu_has_llsc) {
+		unsigned long temp;
+
+		__asm__ __volatile__(
+		"	.set	mips3					\n"
+		"1:	ll	%1, %2		# local_sub_return	\n"
+		"	subu	%0, %1, %3				\n"
+		"	sc	%0, %2					\n"
+		"	beqz	%0, 1b					\n"
+		"	subu	%0, %1, %3				\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp), "=m" (&(l->a.counter))
+		: "Ir" (i), "m" (&(l->a.counter))
+		: "memory");
+	} else {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		result = &(l->a.counter);
+		result -= i;
+		&(l->a.counter) = result;
+		local_irq_restore(flags);
+	}
+
+	return result;
+}
+
+/*
+ * local_sub_if_positive - conditionally subtract integer from atomic variable
+ * @i: integer value to subtract
+ * @l: pointer of type local_t
+ *
+ * Atomically test @l and subtract @i if @l is greater or equal than @i.
+ * The function returns the old value of @l minus @i.
+ */
+static __inline__ int local_sub_if_positive(int i, local_t * l)
+{
+	unsigned long result;
+
+	if (cpu_has_llsc && R10000_LLSC_WAR) {
+		unsigned long temp;
+
+		__asm__ __volatile__(
+		"	.set	mips3					\n"
+		"1:	ll	%1, %2		# local_sub_if_positive\n"
+		"	subu	%0, %1, %3				\n"
+		"	bltz	%0, 1f					\n"
+		"	sc	%0, %2					\n"
+		"	.set	noreorder				\n"
+		"	beqzl	%0, 1b					\n"
+		"	 subu	%0, %1, %3				\n"
+		"	.set	reorder					\n"
+		"1:							\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp), "=m" (&(l->a.counter))
+		: "Ir" (i), "m" (&(l->a.counter))
+		: "memory");
+	} else if (cpu_has_llsc) {
+		unsigned long temp;
+
+		__asm__ __volatile__(
+		"	.set	mips3					\n"
+		"1:	ll	%1, %2		# local_sub_if_positive\n"
+		"	subu	%0, %1, %3				\n"
+		"	bltz	%0, 1f					\n"
+		"	sc	%0, %2					\n"
+		"	.set	noreorder				\n"
+		"	beqz	%0, 1b					\n"
+		"	 subu	%0, %1, %3				\n"
+		"	.set	reorder					\n"
+		"1:							\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp), "=m" (&(l->a.counter))
+		: "Ir" (i), "m" (&(l->a.counter))
+		: "memory");
+	} else {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		result = &(l->a.counter);
+		result -= i;
+		if (result >= 0)
+			&(l->a.counter) = result;
+		local_irq_restore(flags);
+	}
+
+	return result;
+}
+
+#define local_cmpxchg(l, o, n) \
+	((long)cmpxchg(&((l)->a.counter), (o), (n)))
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
+	while (c != (u) && (old = local_cmpxchg((l), c, c + (a))) != c) \
+		c = old;					\
+	c != (u);						\
+})
+#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+
+#define local_dec_return(l) local_sub_return(1,(l))
+#define local_inc_return(l) local_add_return(1,(l))
+
+/*
+ * local_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @l: pointer of type local_t
+ *
+ * Atomically subtracts @i from @l and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+#define local_sub_and_test(i,l) (local_sub_return((i), (l)) == 0)
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
+/*
+ * local_dec_and_test - decrement by 1 and test
+ * @l: pointer of type local_t
+ *
+ * Atomically decrements @l by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+#define local_dec_and_test(l) (local_sub_return(1, (l)) == 0)
+
+/*
+ * local_dec_if_positive - decrement by 1 if old value positive
+ * @l: pointer of type local_t
+ */
+#define local_dec_if_positive(l)	local_sub_if_positive(1, l)
+
+/*
+ * local_add_negative - add and test if negative
+ * @l: pointer of type local_t
+ * @i: integer value to add
+ *
+ * Atomically adds @i to @l and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+#define local_add_negative(i,l) (local_add_return(i, (l)) < 0)
+
+#else /* CONFIG_64BITS */
 
-#define LOCAL_INIT(i)	ATOMIC64_INIT(i)
-#define local_read(v)	atomic64_read(v)
-#define local_set(v,i)	atomic64_set(v,i)
+/*
+ * Same as above, but return the result value
+ */
+static __inline__ long local_add_return(long i, local_t * l)
+{
+	unsigned long result;
+
+	if (cpu_has_llsc && R10000_LLSC_WAR) {
+		unsigned long temp;
+
+		__asm__ __volatile__(
+		"	.set	mips3					\n"
+		"1:	lld	%1, %2		# local_add_return	\n"
+		"	addu	%0, %1, %3				\n"
+		"	scd	%0, %2					\n"
+		"	beqzl	%0, 1b					\n"
+		"	addu	%0, %1, %3				\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp), "=m" (&(l->a.counter))
+		: "Ir" (i), "m" (&(l->a.counter))
+		: "memory");
+	} else if (cpu_has_llsc) {
+		unsigned long temp;
+
+		__asm__ __volatile__(
+		"	.set	mips3					\n"
+		"1:	lld	%1, %2		# local_add_return	\n"
+		"	addu	%0, %1, %3				\n"
+		"	scd	%0, %2					\n"
+		"	beqz	%0, 1b					\n"
+		"	addu	%0, %1, %3				\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp), "=m" (&(l->a.counter))
+		: "Ir" (i), "m" (&(l->a.counter))
+		: "memory");
+	} else {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		result = &(l->a.counter);
+		result += i;
+		&(l->a.counter) = result;
+		local_irq_restore(flags);
+	}
 
-#define local_inc(v)	atomic64_inc(v)
-#define local_dec(v)	atomic64_dec(v)
-#define local_add(i, v)	atomic64_add(i, v)
-#define local_sub(i, v)	atomic64_sub(i, v)
+	return result;
+}
 
-#endif
+static __inline__ long local_sub_return(long i, local_t * l)
+{
+	unsigned long result;
 
-#define __local_inc(v)		((v)->counter++)
-#define __local_dec(v)		((v)->counter--)
-#define __local_add(i,v)	((v)->counter+=(i))
-#define __local_sub(i,v)	((v)->counter-=(i))
+	if (cpu_has_llsc && R10000_LLSC_WAR) {
+		unsigned long temp;
+
+		__asm__ __volatile__(
+		"	.set	mips3					\n"
+		"1:	lld	%1, %2		# local_sub_return	\n"
+		"	subu	%0, %1, %3				\n"
+		"	scd	%0, %2					\n"
+		"	beqzl	%0, 1b					\n"
+		"	subu	%0, %1, %3				\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp), "=m" (&(l->a.counter))
+		: "Ir" (i), "m" (&(l->a.counter))
+		: "memory");
+	} else if (cpu_has_llsc) {
+		unsigned long temp;
+
+		__asm__ __volatile__(
+		"	.set	mips3					\n"
+		"1:	lld	%1, %2		# local_sub_return	\n"
+		"	subu	%0, %1, %3				\n"
+		"	scd	%0, %2					\n"
+		"	beqz	%0, 1b					\n"
+		"	subu	%0, %1, %3				\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp), "=m" (&(l->a.counter))
+		: "Ir" (i), "m" (&(l->a.counter))
+		: "memory");
+	} else {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		result = &(l->a.counter);
+		result -= i;
+		&(l->a.counter) = result;
+		local_irq_restore(flags);
+	}
+
+	return result;
+}
 
 /*
- * Use these for per-cpu local_t variables: on some archs they are
+ * local_sub_if_positive - conditionally subtract integer from atomic variable
+ * @i: integer value to subtract
+ * @l: pointer of type local_t
+ *
+ * Atomically test @l and subtract @i if @l is greater or equal than @i.
+ * The function returns the old value of @l minus @i.
+ */
+static __inline__ long local_sub_if_positive(long i, local_t * l)
+{
+	unsigned long result;
+
+	if (cpu_has_llsc && R10000_LLSC_WAR) {
+		unsigned long temp;
+
+		__asm__ __volatile__(
+		"	.set	mips3					\n"
+		"1:	lld	%1, %2		# local_sub_if_positive\n"
+		"	dsubu	%0, %1, %3				\n"
+		"	bltz	%0, 1f					\n"
+		"	scd	%0, %2					\n"
+		"	.set	noreorder				\n"
+		"	beqzl	%0, 1b					\n"
+		"	 dsubu	%0, %1, %3				\n"
+		"	.set	reorder					\n"
+		"1:							\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp), "=m" (&(l->a.counter))
+		: "Ir" (i), "m" (&(l->a.counter))
+		: "memory");
+	} else if (cpu_has_llsc) {
+		unsigned long temp;
+
+		__asm__ __volatile__(
+		"	.set	mips3					\n"
+		"1:	lld	%1, %2		# local_sub_if_positive\n"
+		"	dsubu	%0, %1, %3				\n"
+		"	bltz	%0, 1f					\n"
+		"	scd	%0, %2					\n"
+		"	.set	noreorder				\n"
+		"	beqz	%0, 1b					\n"
+		"	 dsubu	%0, %1, %3				\n"
+		"	.set	reorder					\n"
+		"1:							\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp), "=m" (&(l->a.counter))
+		: "Ir" (i), "m" (&(l->a.counter))
+		: "memory");
+	} else {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		result = &(l->a.counter);
+		result -= i;
+		if (result >= 0)
+			&(l->a.counter) = result;
+		local_irq_restore(flags);
+	}
+
+	return result;
+}
+
+
+#define local_cmpxchg(l, o, n) \
+	((long)cmpxchg(&((l)->a.counter), (o), (n)))
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
+	while (c != (u) && (old = local_cmpxchg((l), c, c + (a))) != c) \
+		c = old;					\
+	c != (u);						\
+})
+#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+
+#define local_dec_return(l) local_sub_return(1,(l))
+#define local_inc_return(l) local_add_return(1,(l))
+
+/*
+ * local_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @l: pointer of type local_t
+ *
+ * Atomically subtracts @i from @l and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+#define local_sub_and_test(i,l) (local_sub_return((i), (l)) == 0)
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
+/*
+ * local_dec_and_test - decrement by 1 and test
+ * @l: pointer of type local_t
+ *
+ * Atomically decrements @l by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+#define local_dec_and_test(l) (local_sub_return(1, (l)) == 0)
+
+/*
+ * local_dec_if_positive - decrement by 1 if old value positive
+ * @l: pointer of type local_t
+ */
+#define local_dec_if_positive(l)	local_sub_if_positive(1, l)
+
+/*
+ * local_add_negative - add and test if negative
+ * @l: pointer of type local_t
+ * @i: integer value to add
+ *
+ * Atomically adds @i to @l and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+#define local_add_negative(i,l) (local_add_return(i, (l)) < 0)
+
+#endif /* !CONFIG_64BITS */
+
+
+/* Use these for per-cpu local_t variables: on some archs they are
  * much more efficient than these naive implementations.  Note they take
  * a variable, not an address.
+ *
+ * This could be done better if we moved the per cpu data directly
+ * after GS.
  */
-#define cpu_local_read(v)	local_read(&__get_cpu_var(v))
-#define cpu_local_set(v, i)	local_set(&__get_cpu_var(v), (i))
 
-#define cpu_local_inc(v)	local_inc(&__get_cpu_var(v))
-#define cpu_local_dec(v)	local_dec(&__get_cpu_var(v))
-#define cpu_local_add(i, v)	local_add((i), &__get_cpu_var(v))
-#define cpu_local_sub(i, v)	local_sub((i), &__get_cpu_var(v))
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
 
-#define __cpu_local_inc(v)	__local_inc(&__get_cpu_var(v))
-#define __cpu_local_dec(v)	__local_dec(&__get_cpu_var(v))
-#define __cpu_local_add(i, v)	__local_add((i), &__get_cpu_var(v))
-#define __cpu_local_sub(i, v)	__local_sub((i), &__get_cpu_var(v))
+#define __cpu_local_inc(l)	cpu_local_inc(l)
+#define __cpu_local_dec(l)	cpu_local_dec(l)
+#define __cpu_local_add(i, l)	cpu_local_add((i), (l))
+#define __cpu_local_sub(i, l)	cpu_local_sub((i), (l))
 
-#endif /* _ASM_LOCAL_H */
+#endif /* _ARCH_POWERPC_LOCAL_H */

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
