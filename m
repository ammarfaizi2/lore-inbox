Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTETBKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 21:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTETBKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 21:10:10 -0400
Received: from dp.samba.org ([66.70.73.150]:3737 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263274AbTETBKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 21:10:08 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, David Mosberger-Tang <davidm@hpl.hp.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [PATCH 1/3] Per-cpu UP unification
Date: Tue, 20 May 2003 11:22:01 +1000
Message-Id: <20030520012307.53A502C082@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Untested on ia64, but fairly trivial if I've broken something ].

Name: Unification of per-cpu headers for non-SMP
Author: Rusty Russell
Status: Trivial

D: Move non-SMP per-cpu operations from asm-*/percpu.h to
D: linux/percpu.h.  There is no reason why archs would want to have
D: their own versions of non-SMP per-cpu operations, and making each
D: arch override them is just silly.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14436-linux-2.5.69-bk13/include/asm-generic/percpu.h .14436-linux-2.5.69-bk13.updated/include/asm-generic/percpu.h
--- .14436-linux-2.5.69-bk13/include/asm-generic/percpu.h	2003-01-02 12:32:47.000000000 +1100
+++ .14436-linux-2.5.69-bk13.updated/include/asm-generic/percpu.h	2003-05-19 15:08:28.000000000 +1000
@@ -17,22 +17,6 @@ extern unsigned long __per_cpu_offset[NR
 #define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
 
-#else /* ! SMP */
-
-/* Can't define per-cpu variables in modules.  Sorry --RR */
-#ifndef MODULE
-#define DEFINE_PER_CPU(type, name) \
-    __typeof__(type) name##__per_cpu
-#endif
-
-#define per_cpu(var, cpu)			((void)cpu, var##__per_cpu)
-#define __get_cpu_var(var)			var##__per_cpu
-
 #endif	/* SMP */
 
-#define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
-
-#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
-#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)
-
 #endif /* _ASM_GENERIC_PERCPU_H_ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14436-linux-2.5.69-bk13/include/asm-ia64/percpu.h .14436-linux-2.5.69-bk13.updated/include/asm-ia64/percpu.h
--- .14436-linux-2.5.69-bk13/include/asm-ia64/percpu.h	2003-05-19 10:53:49.000000000 +1000
+++ .14436-linux-2.5.69-bk13.updated/include/asm-ia64/percpu.h	2003-05-19 15:08:39.000000000 +1000
@@ -17,23 +17,17 @@
 
 #include <linux/threads.h>
 
+#ifdef CONFIG_SMP
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
 #ifndef MODULE
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
 #endif
-#define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
 
 #define __get_cpu_var(var)	(var##__per_cpu)
-#ifdef CONFIG_SMP
-# define per_cpu(var, cpu)	(*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
-#else
-# define per_cpu(var, cpu)	((void)cpu, __get_cpu_var(var))
-#endif
-
-#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
-#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)
+#define per_cpu(var, cpu)	(*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
+#endif /* CONFIG_SMP */
 
 extern void setup_per_cpu_areas (void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14436-linux-2.5.69-bk13/include/linux/percpu.h .14436-linux-2.5.69-bk13.updated/include/linux/percpu.h
--- .14436-linux-2.5.69-bk13/include/linux/percpu.h	2003-02-07 19:20:01.000000000 +1100
+++ .14436-linux-2.5.69-bk13.updated/include/linux/percpu.h	2003-05-19 15:08:28.000000000 +1000
@@ -44,6 +44,15 @@ static inline void kfree_percpu(const vo
 }
 static inline void kmalloc_percpu_init(void) { }
 
+/* Can't define per-cpu variables in modules.  Sorry --RR */
+#ifndef MODULE
+#define DEFINE_PER_CPU(type, name) \
+    __typeof__(type) name##__per_cpu
+#endif
+
+#define per_cpu(var, cpu)			((void)cpu, var##__per_cpu)
+#define __get_cpu_var(var)			var##__per_cpu
+
 #endif /* CONFIG_SMP */
 
 /* 
@@ -68,4 +77,9 @@ static inline void kmalloc_percpu_init(v
 #define get_cpu_ptr(ptr) per_cpu_ptr(ptr, get_cpu())
 #define put_cpu_ptr(ptr) put_cpu()
 
+#define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
+
+#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
+#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)
+
 #endif /* __LINUX_PERCPU_H */
_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)
+
 #endif /* __LINUX_PERCPU_H */
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
