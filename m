Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270429AbTGPIdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270437AbTGPIcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:32:05 -0400
Received: from dp.samba.org ([66.70.73.150]:12707 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270429AbTGPIZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:25:59 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] local_t
Date: Wed, 16 Jul 2003 18:38:38 +1000
Message-Id: <20030716084051.459502C141@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply (with the next one, otherwise module.h breaks).

Dave Miller and David Mosberger both liked it.

This has been on the wishlist for a while (at least module refcounts
and network stats really want it), but with the discovery of the
problems with the ia64's implementation of per-cpu variables, it's
become more urgent.

Patch introduces local_t, a type which is like atomic_t, but the
operations are only atomic from a single CPU's point of view
(ie. atomic against interrupts and softirqs). Some architectures
(eg. i386) can implement these very efficiently.

There are special operations for the case of a local operation on a
per-cpu variable (which is common), which some architectures can
implement efficiently (eg. IA64 keeps all per-cpu variables mapped
at the same address, so no address arithmetic is needed).

The generic implementation given here simply uses atomics on 32-bit
archs, three variables on others.  x86 is already implemented specially.

Name: local_t
Author: Rusty Russell
Status: Booted on 2.6.0-test1
Depends: Percpu/struct_members.patch.gz

D: Introduces local_t, a type which is like atomic_t, but the
D: operations are only atomic from a single CPU's point of view
D: (ie. atomic against interrupts and softirqs). Some architectures
D: (eg. i386) can implement these very efficiently.
D: 
D: There are special operations for the case of a local operation on a
D: per-cpu variable (which is common), which some architectures can
D: implement efficiently (eg. IA64 keeps all per-cpu variables mapped
D: at the same address, so no address arithmetic is needed).
D: 
D: The generic implementation given here simply uses atomics on 32-bit
D: archs, three variables on others.  x86 is already implemented specially.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4756-linux-2.5.75-bk3/include/asm-generic/local.h .4756-linux-2.5.75-bk3.updated/include/asm-generic/local.h
--- .4756-linux-2.5.75-bk3/include/asm-generic/local.h	1970-01-01 10:00:00.000000000 +1000
+++ .4756-linux-2.5.75-bk3.updated/include/asm-generic/local.h	2003-07-14 13:49:11.000000000 +1000
@@ -0,0 +1,118 @@
+#ifndef _ASM_GENERIC_LOCAL_H
+#define _ASM_GENERIC_LOCAL_H
+
+#include <linux/config.h>
+#include <linux/percpu.h>
+#include <asm/types.h>
+#include <asm/hardirq.h>
+
+/* An unsigned long type for operations which are atomic for a single
+ * CPU.  Usually used in combination with per-cpu variables. */
+
+#if BITS_PER_LONG == 32 && !defined(CONFIG_SPARC32)
+/* Implement in terms of atomics. */
+
+/* Don't use typedef: don't want them to be mixed with atomic_t's. */
+typedef struct
+{
+	atomic_t a;
+} local_t;
+
+#define LOCAL_INIT(i)	{ ATOMIC_INIT(i) }
+
+#define local_read(l)	((unsigned long)atomic_read(&(l)->a))
+#define local_set(l,i)	atomic_set((&(l)->a),(i))
+#define local_inc(l)	atomic_inc(&(l)->a)
+#define local_dec(l)	atomic_dec(&(l)->a)
+#define local_add(i,l)	atomic_add((i),(&(l)->a))
+#define local_sub(i,l)	atomic_sub((i),(&(l)->a))
+
+/* Non-atomic variants, ie. preemption disabled and won't be touched
+ * in interrupt, etc.  Some archs can optimize this case well. */
+#define __local_inc(l)		local_set((l), local_read(l) + 1)
+#define __local_dec(l)		local_set((l), local_read(l) - 1)
+#define __local_add(i,l)	local_set((l), local_read(l) + (i))
+#define __local_sub(i,l)	local_set((l), local_read(l) - (i))
+
+#else /* ... can't use atomics. */
+/* Implement in terms of three variables.
+   Another option would be to use local_irq_save/restore. */
+
+typedef struct
+{
+	/* 0 = in hardirq, 1 = in softirq, 2 = usermode. */
+	unsigned long v[3];
+} local_t;
+
+#define _LOCAL_VAR(l)	((l)->v[!in_interrupt() + !in_irq()])
+
+#define LOCAL_INIT(i)	{ { (i), 0, 0 } }
+
+static inline unsigned long local_read(local_t *l)
+{
+	return l->v[0] + l->v[1] + l->v[2];
+}
+
+static inline void local_set(local_t *l, unsigned long v)
+{
+	l->v[0] = v;
+	l->v[1] = l->v[2] = 0;
+}
+
+static inline void local_inc(local_t *l)
+{
+	preempt_disable();
+	_LOCAL_VAR(l)++;
+	preempt_enable();
+}
+
+static inline void local_dec(local_t *l)
+{
+	preempt_disable();
+	_LOCAL_VAR(l)--;
+	preempt_enable();
+}
+
+static inline void local_add(unsigned long v, local_t *l)
+{
+	preempt_disable();
+	_LOCAL_VAR(l) += v;
+	preempt_enable();
+}
+
+static inline void local_sub(unsigned long v, local_t *l)
+{
+	preempt_disable();
+	_LOCAL_VAR(l) -= v;
+	preempt_enable();
+}
+
+/* Non-atomic variants, ie. preemption disabled and won't be touched
+ * in interrupt, etc.  Some archs can optimize this case well. */
+#define __local_inc(l)		((l)->v[0]++)
+#define __local_dec(l)		((l)->v[0]--)
+#define __local_add(i,l)	((l)->v[0] += (i))
+#define __local_sub(i,l)	((l)->v[0] -= (i))
+
+#endif /* Non-atomic implementation */
+
+/* Use these for per-cpu local_t variables: on some archs they are
+ * much more efficient than these naive implementations.  Note they take
+ * a variable (eg. mystruct.foo), not an address.
+ */
+#define cpu_local_read(v)	local_read(&__get_cpu_var(v))
+#define cpu_local_set(v, i)	local_set(&__get_cpu_var(v), (i))
+#define cpu_local_inc(v)	local_inc(&__get_cpu_var(v))
+#define cpu_local_dec(v)	local_dec(&__get_cpu_var(v))
+#define cpu_local_add(i, v)	local_add((i), &__get_cpu_var(v))
+#define cpu_local_sub(i, v)	local_sub((i), &__get_cpu_var(v))
+
+/* Non-atomic increments, ie. preemption disabled and won't be touched
+ * in interrupt, etc.  Some archs can optimize this case well.
+ */
+#define __cpu_local_inc(v)	__local_inc(&__get_cpu_var(v))
+#define __cpu_local_dec(v)	__local_dec(&__get_cpu_var(v))
+#define __cpu_local_add(i, v)	__local_add((i), &__get_cpu_var(v))
+#define __cpu_local_sub(i, v)	__local_sub((i), &__get_cpu_var(v))
+
+#endif /* _ASM_GENERIC_LOCAL_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4756-linux-2.5.75-bk3/include/asm-i386/local.h .4756-linux-2.5.75-bk3.updated/include/asm-i386/local.h
--- .4756-linux-2.5.75-bk3/include/asm-i386/local.h	1970-01-01 10:00:00.000000000 +1000
+++ .4756-linux-2.5.75-bk3.updated/include/asm-i386/local.h	2003-07-14 13:47:03.000000000 +1000
@@ -0,0 +1,70 @@
+#ifndef _ARCH_I386_LOCAL_H
+#define _ARCH_I386_LOCAL_H
+
+#include <linux/percpu.h>
+
+typedef struct
+{
+	volatile unsigned long counter;
+} local_t;
+
+#define LOCAL_INIT(i)	{ (i) }
+
+#define local_read(v)	((v)->counter)
+#define local_set(v,i)	(((v)->counter) = (i))
+
+static __inline__ void local_inc(local_t *v)
+{
+	__asm__ __volatile__(
+		"incl %0"
+		:"=m" (v->counter)
+		:"m" (v->counter));
+}
+
+static __inline__ void local_dec(local_t *v)
+{
+	__asm__ __volatile__(
+		"decl %0"
+		:"=m" (v->counter)
+		:"m" (v->counter));
+}
+
+static __inline__ void local_add(unsigned long i, local_t *v)
+{
+	__asm__ __volatile__(
+		"addl %1,%0"
+		:"=m" (v->counter)
+		:"ir" (i), "m" (v->counter));
+}
+
+static __inline__ void local_sub(unsigned long i, local_t *v)
+{
+	__asm__ __volatile__(
+		"subl %1,%0"
+		:"=m" (v->counter)
+		:"ir" (i), "m" (v->counter));
+}
+
+/* On x86, these are no better than the atomic variants. */
+#define __local_inc(l)		local_inc(l)
+#define __local_dec(l)		local_dec(l)
+#define __local_add(i,l)	local_add((i),(l))
+#define __local_sub(i,l)	local_sub((i),(l))
+
+/* Use these for per-cpu local_t variables: on some archs they are
+ * much more efficient than these naive implementations.  Note they take
+ * a variable, not an address.
+ */
+#define cpu_local_read(v)	local_read(&__get_cpu_var(v))
+#define cpu_local_set(v, i)	local_set(&__get_cpu_var(v), (i))
+#define cpu_local_inc(v)	local_inc(&__get_cpu_var(v))
+#define cpu_local_dec(v)	local_dec(&__get_cpu_var(v))
+#define cpu_local_add(i, v)	local_add((i), &__get_cpu_var(v))
+#define cpu_local_sub(i, v)	local_sub((i), &__get_cpu_var(v))
+
+#define __cpu_local_inc(v)	cpu_local_inc(v)
+#define __cpu_local_dec(v)	cpu_local_dec(v)
+#define __cpu_local_add(i, v)	cpu_local_add((i), (v))
+#define __cpu_local_sub(i, v)	cpu_local_sub((i), (v))
+
+#endif /* _ARCH_I386_LOCAL_H */
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
