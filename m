Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270388AbTGPIXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270363AbTGPIXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:23:44 -0400
Received: from dp.samba.org ([66.70.73.150]:65442 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270388AbTGPIW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:22:58 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] percpu struct members.
Date: Wed, 16 Jul 2003 18:35:21 +1000
Message-Id: <20030716083750.6DC4A2C141@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

The current percpu macros do not allow __get_cpu_var(foo.val1)
which makes building macros on top of them really difficult.  The
reason for this is the __per_cpu postfix appended to per-cpu
variables, designed to catch direct uses.  Prepend it instead.

Name: Allow struct members in percpu macros.
Author: Rusty Russell
Status: Booted on 2.6.0-test1

D: The current percpu macros do not allow __get_cpu_var(foo.val1)
D: which makes building macros on top of them really difficult.  The
D: reason for this is the __per_cpu postfix appended to per-cpu
D: variables, designed to catch direct uses.  Prepend it instead.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4837-linux-2.5.75/include/asm-generic/percpu.h .4837-linux-2.5.75.updated/include/asm-generic/percpu.h
--- .4837-linux-2.5.75/include/asm-generic/percpu.h	2003-06-15 11:30:06.000000000 +1000
+++ .4837-linux-2.5.75.updated/include/asm-generic/percpu.h	2003-07-11 16:48:21.000000000 +1000
@@ -9,10 +9,10 @@ extern unsigned long __per_cpu_offset[NR
 
 /* Separate out the type, so (int[3], foo) works. */
 #define DEFINE_PER_CPU(type, name) \
-    __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
+    __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
 
 /* var is in discarded region: offset to particular copy we want */
-#define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
+#define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
 
 static inline void percpu_modcopy(void *pcpudst, const void *src,
@@ -26,16 +26,16 @@ static inline void percpu_modcopy(void *
 #else /* ! SMP */
 
 #define DEFINE_PER_CPU(type, name) \
-    __typeof__(type) name##__per_cpu
+    __typeof__(type) per_cpu__##name
 
-#define per_cpu(var, cpu)			((void)cpu, var##__per_cpu)
-#define __get_cpu_var(var)			var##__per_cpu
+#define per_cpu(var, cpu)			((void)cpu, per_cpu__##var)
+#define __get_cpu_var(var)			per_cpu__##var
 
 #endif	/* SMP */
 
-#define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
+#define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
 
-#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
-#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)
+#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
+#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
 
 #endif /* _ASM_GENERIC_PERCPU_H_ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4837-linux-2.5.75/include/asm-ia64/percpu.h .4837-linux-2.5.75.updated/include/asm-ia64/percpu.h
--- .4837-linux-2.5.75/include/asm-ia64/percpu.h	2003-06-15 11:30:07.000000000 +1000
+++ .4837-linux-2.5.75.updated/include/asm-ia64/percpu.h	2003-07-11 16:49:38.000000000 +1000
@@ -12,7 +12,7 @@
 
 #ifdef __ASSEMBLY__
 
-#define THIS_CPU(var)	(var##__per_cpu)  /* use this to mark accesses to per-CPU variables... */
+#define THIS_CPU(var)	(per_cpu__##var)  /* use this to mark accesses to per-CPU variables... */
 
 #else /* !__ASSEMBLY__ */
 
@@ -21,20 +21,20 @@
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
 #define DEFINE_PER_CPU(type, name) \
-    __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
-#define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
+    __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
+#define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
 
-#define __get_cpu_var(var)	(var##__per_cpu)
+#define __get_cpu_var(var)	(per_cpu__##var)
 #ifdef CONFIG_SMP
-# define per_cpu(var, cpu)	(*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
+# define per_cpu(var, cpu)	(*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
 
 extern void percpu_modcopy(void *pcpudst, const void *src, unsigned long size);
 #else
 # define per_cpu(var, cpu)	((void)cpu, __get_cpu_var(var))
 #endif
 
-#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
-#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)
+#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
+#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
 
 extern void setup_per_cpu_areas (void);
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
