Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270434AbTGPIbi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270412AbTGPIbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:31:38 -0400
Received: from dp.samba.org ([66.70.73.150]:15011 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270434AbTGPI0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:26:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/5] local_t for IA64
Date: Wed, 16 Jul 2003 18:41:02 +1000
Message-Id: <20030716084132.3076B2C141@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And then David M-T was second.

Rusty.

Name: local_t ia64 support
Author: David Mosberger <davidm@napali.hpl.hp.com>
Status: Tested on 2.6.0-test1
Depends: Percpu/local_t.patch.gz
Depends: Misc/i386_linker_symbols.patch.gz

D: There are others who wanted atomic64 for some time (on 64-bit
D: platforms), so I added it to asm-ia64/atomic.h as well.
D: 
D: I attached the percpu.h and local.h which I'm using on ia64.
D: It all seems to work very nicely.
D: 
D: __get_cpu_var() now returns the canonical address, so there is no
D: source of confusion (if someone really knows what they're doing, they
D: can still use __ia64_per_cpu_var() to get the aliased variable).
D: To avoid an array-lookup, I defined a per-CPU variable which holds
D: the per-CPU offset of the current CPU.  WIth that, __get_cpu_var()
D: becomes:
D: 
D: #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __ia64_per_cpu_var(local_per_cpu_offset)))
D: 
D: (Yeah, it runs the risk of messing with your head, but if you think
D: about it the right way, it's entirely obvious... ;-).

===== include/asm-ia64/percpu.h 1.8 vs edited =====
--- 1.8/include/asm-ia64/percpu.h	Thu Jun  5 23:36:29 2003
+++ edited/include/asm-ia64/percpu.h	Tue Jul 15 12:03:21 2003
@@ -1,42 +1,65 @@
 #ifndef _ASM_IA64_PERCPU_H
 #define _ASM_IA64_PERCPU_H
 
-#include <linux/config.h>
-#include <linux/compiler.h>
-
 /*
  * Copyright (C) 2002-2003 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
+
 #define PERCPU_ENOUGH_ROOM PERCPU_PAGE_SIZE
 
 #ifdef __ASSEMBLY__
-
-#define THIS_CPU(var)	(var##__per_cpu)  /* use this to mark accesses to per-CPU variables... */
-
+# define THIS_CPU(var)	(per_cpu__##var)  /* use this to mark accesses to per-CPU variables... */
 #else /* !__ASSEMBLY__ */
 
+#include <linux/config.h>
+
 #include <linux/threads.h>
 
+#define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
+
+/*
+ * Pretty much a literal copy of asm-generic/percpu.h, except that percpu_modcopy() is an
+ * external routine, to avoid include-hell.
+ */
+#ifdef CONFIG_SMP
+
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
+/* Equal to __per_cpu_offset[smp_processor_id()], but faster to access: */
+DECLARE_PER_CPU(unsigned long, local_per_cpu_offset);
+
+/* Separate out the type, so (int[3], foo) works. */
 #define DEFINE_PER_CPU(type, name) \
-    __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
-#define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
+    __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
 
-#define __get_cpu_var(var)	(var##__per_cpu)
-#ifdef CONFIG_SMP
-# define per_cpu(var, cpu)	(*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
+#define per_cpu(var, cpu)  (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
+#define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __ia64_per_cpu_var(local_per_cpu_offset)))
 
 extern void percpu_modcopy(void *pcpudst, const void *src, unsigned long size);
-#else
-# define per_cpu(var, cpu)	((void)cpu, __get_cpu_var(var))
-#endif
 
-#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
-#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)
+#else /* ! SMP */
+
+#define DEFINE_PER_CPU(type, name)		__typeof__(type) per_cpu__##name
+#define per_cpu(var, cpu)			((void)cpu, per_cpu__##var)
+#define __get_cpu_var(var)			per_cpu__##var
+
+#endif	/* SMP */
+
+#define EXPORT_PER_CPU_SYMBOL(var)		EXPORT_SYMBOL(per_cpu__##var)
+#define EXPORT_PER_CPU_SYMBOL_GPL(var)		EXPORT_SYMBOL_GPL(per_cpu__##var)
+
+/* ia64-specific part: */
 
 extern void setup_per_cpu_areas (void);
+
+/*
+ * Be extremely careful when taking the address of this variable!  Due to virtual
+ * remapping, it is different from the canonical address returned by __get_cpu_var(var)!
+ * On the positive side, using __ia64_per_cpu_var() instead of __get_cpu_var() is slightly
+ * more efficient.
+ */
+#define __ia64_per_cpu_var(var)	(per_cpu__##var)
 
 #endif /* !__ASSEMBLY__ */
 

===== include/asm-ia64/atomic.h 1.6 vs edited =====
--- 1.6/include/asm-ia64/atomic.h	Sat May 10 02:28:47 2003
+++ edited/include/asm-ia64/atomic.h	Tue Jul 15 11:56:20 2003
@@ -9,7 +9,7 @@
  * "int" types were carefully placed so as to ensure proper operation
  * of the macros.
  *
- * Copyright (C) 1998, 1999, 2002 Hewlett-Packard Co
+ * Copyright (C) 1998, 1999, 2002-2003 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
 #include <linux/types.h>
@@ -21,11 +21,16 @@
  * memory accesses are ordered.
  */
 typedef struct { volatile __s32 counter; } atomic_t;
+typedef struct { volatile __s64 counter; } atomic64_t;
 
 #define ATOMIC_INIT(i)		((atomic_t) { (i) })
+#define ATOMIC64_INIT(i)	((atomic64_t) { (i) })
 
 #define atomic_read(v)		((v)->counter)
+#define atomic64_read(v)	((v)->counter)
+
 #define atomic_set(v,i)		(((v)->counter) = (i))
+#define atomic64_set(v,i)	(((v)->counter) = (i))
 
 static __inline__ int
 ia64_atomic_add (int i, atomic_t *v)
@@ -37,7 +42,21 @@
 		CMPXCHG_BUGCHECK(v);
 		old = atomic_read(v);
 		new = old + i;
-	} while (ia64_cmpxchg("acq", v, old, old + i, sizeof(atomic_t)) != old);
+	} while (ia64_cmpxchg("acq", v, old, new, sizeof(atomic_t)) != old);
+	return new;
+}
+
+static __inline__ int
+ia64_atomic64_add (int i, atomic64_t *v)
+{
+	__s64 old, new;
+	CMPXCHG_BUGCHECK_DECL
+
+	do {
+		CMPXCHG_BUGCHECK(v);
+		old = atomic_read(v);
+		new = old + i;
+	} while (ia64_cmpxchg("acq", v, old, new, sizeof(atomic_t)) != old);
 	return new;
 }
 
@@ -55,6 +74,20 @@
 	return new;
 }
 
+static __inline__ int
+ia64_atomic64_sub (int i, atomic64_t *v)
+{
+	__s64 old, new;
+	CMPXCHG_BUGCHECK_DECL
+
+	do {
+		CMPXCHG_BUGCHECK(v);
+		old = atomic_read(v);
+		new = old - i;
+	} while (ia64_cmpxchg("acq", v, old, new, sizeof(atomic_t)) != old);
+	return new;
+}
+
 #define atomic_add_return(i,v)						\
 ({									\
 	int __ia64_aar_i = (i);						\
@@ -67,6 +100,18 @@
 		: ia64_atomic_add(__ia64_aar_i, v);			\
 })
 
+#define atomic64_add_return(i,v)					\
+({									\
+	long __ia64_aar_i = (i);					\
+	(__builtin_constant_p(i)					\
+	 && (   (__ia64_aar_i ==  1) || (__ia64_aar_i ==   4)		\
+	     || (__ia64_aar_i ==  8) || (__ia64_aar_i ==  16)		\
+	     || (__ia64_aar_i == -1) || (__ia64_aar_i ==  -4)		\
+	     || (__ia64_aar_i == -8) || (__ia64_aar_i == -16)))		\
+		? ia64_fetch_and_add(__ia64_aar_i, &(v)->counter)	\
+		: ia64_atomic64_add(__ia64_aar_i, v);			\
+})
+
 /*
  * Atomically add I to V and return TRUE if the resulting value is
  * negative.
@@ -77,6 +122,12 @@
 	return atomic_add_return(i, v) < 0;
 }
 
+static __inline__ int
+atomic_add64_negative (int i, atomic64_t *v)
+{
+	return atomic64_add_return(i, v) < 0;
+}
+
 #define atomic_sub_return(i,v)						\
 ({									\
 	int __ia64_asr_i = (i);						\
@@ -89,17 +140,39 @@
 		: ia64_atomic_sub(__ia64_asr_i, v);			\
 })
 
+#define atomic64_sub_return(i,v)					\
+({									\
+	long __ia64_asr_i = (i);					\
+	(__builtin_constant_p(i)					\
+	 && (   (__ia64_asr_i ==   1) || (__ia64_asr_i ==   4)		\
+	     || (__ia64_asr_i ==   8) || (__ia64_asr_i ==  16)		\
+	     || (__ia64_asr_i ==  -1) || (__ia64_asr_i ==  -4)		\
+	     || (__ia64_asr_i ==  -8) || (__ia64_asr_i == -16)))	\
+		? ia64_fetch_and_add(-__ia64_asr_i, &(v)->counter)	\
+		: ia64_atomic64_sub(__ia64_asr_i, v);			\
+})
+
 #define atomic_dec_return(v)		atomic_sub_return(1, (v))
 #define atomic_inc_return(v)		atomic_add_return(1, (v))
+#define atomic64_dec_return(v)		atomic64_sub_return(1, (v))
+#define atomic64_inc_return(v)		atomic64_add_return(1, (v))
 
 #define atomic_sub_and_test(i,v)	(atomic_sub_return((i), (v)) == 0)
 #define atomic_dec_and_test(v)		(atomic_sub_return(1, (v)) == 0)
 #define atomic_inc_and_test(v)		(atomic_add_return(1, (v)) != 0)
+#define atomic64_sub_and_test(i,v)	(atomic64_sub_return((i), (v)) == 0)
+#define atomic64_dec_and_test(v)	(atomic64_sub_return(1, (v)) == 0)
+#define atomic64_inc_and_test(v)	(atomic64_add_return(1, (v)) != 0)
 
 #define atomic_add(i,v)			atomic_add_return((i), (v))
 #define atomic_sub(i,v)			atomic_sub_return((i), (v))
 #define atomic_inc(v)			atomic_add(1, (v))
 #define atomic_dec(v)			atomic_sub(1, (v))
+
+#define atomic64_add(i,v)		atomic64_add_return((i), (v))
+#define atomic64_sub(i,v)		atomic64_sub_return((i), (v))
+#define atomic64_inc(v)			atomic64_add(1, (v))
+#define atomic64_dec(v)			atomic64_sub(1, (v))
 
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()

--- /dev/null	2003-03-27 10:58:26.000000000 -0800
+++ include/asm-ia64/local.h	2003-07-15 12:04:24.000000000 -0700
@@ -0,0 +1,50 @@
+#ifndef _ASM_IA64_LOCAL_H
+#define _ASM_IA64_LOCAL_H
+
+/*
+ * Copyright (C) 2003 Hewlett-Packard Co
+ *	David Mosberger-Tang <davidm@hpl.hp.com>
+ */
+
+#include <linux/percpu.h>
+
+typedef struct {
+	atomic64_t val;
+} local_t;
+
+#define LOCAL_INIT(i)	((local_t) { { (i) } })
+#define local_read(l)	atomic64_read(&(l)->val)
+#define local_set(l, i)	atomic64_set(&(l)->val, i)
+#define local_inc(l)	atomic64_inc(&(l)->val)
+#define local_dec(l)	atomic64_dec(&(l)->val)
+#define local_add(l)	atomic64_add(&(l)->val)
+#define local_sub(l)	atomic64_sub(&(l)->val)
+
+/* Non-atomic variants, i.e., preemption disabled and won't be touched in interrupt, etc.  */
+
+#define __local_inc(l)		(++(l)->val.counter)
+#define __local_dec(l)		(--(l)->val.counter)
+#define __local_add(i,l)	((l)->val.counter += (i))
+#define __local_sub(i,l)	((l)->val.counter -= (i))
+
+/*
+ * Use these for per-cpu local_t variables.  Note they take a variable (eg. mystruct.foo),
+ * not an address.
+ */
+#define cpu_local_read(v)	local_read(&__ia64_per_cpu_var(v))
+#define cpu_local_set(v, i)	local_set(&__ia64_per_cpu_var(v), (i))
+#define cpu_local_inc(v)	local_inc(&__ia64_per_cpu_var(v))
+#define cpu_local_dec(v)	local_dec(&__ia64_per_cpu_var(v))
+#define cpu_local_add(i, v)	local_add((i), &__ia64_per_cpu_var(v))
+#define cpu_local_sub(i, v)	local_sub((i), &__ia64_per_cpu_var(v))
+
+/*
+ * Non-atomic increments, i.e., preemption disabled and won't be touched in interrupt,
+ * etc.
+ */
+#define __cpu_local_inc(v)	__local_inc(&__ia64_per_cpu_var(v))
+#define __cpu_local_dec(v)	__local_dec(&__ia64_per_cpu_var(v))
+#define __cpu_local_add(i, v)	__local_add((i), &__ia64_per_cpu_var(v))
+#define __cpu_local_sub(i, v)	__local_sub((i), &__ia64_per_cpu_var(v))
+
+#endif /* _ASM_IA64_LOCAL_H */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
