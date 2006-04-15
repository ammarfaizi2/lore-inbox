Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWDODLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWDODLq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 23:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWDODLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 23:11:10 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:2287 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030220AbWDODKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 23:10:50 -0400
Subject: [PATCH 04/08] percpu -v2 asm-generic/percpu.h
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 23:10:49 -0400
Message-Id: <1145070649.27407.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the per_cpu setup in asm-generic/percpu.h

This is the main magic to use the per_cpu variable offsets
instead of one global one.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc1/include/asm-generic/percpu.h
===================================================================
--- linux-2.6.17-rc1.orig/include/asm-generic/percpu.h	2006-04-13 22:37:57.000000000 -0400
+++ linux-2.6.17-rc1/include/asm-generic/percpu.h	2006-04-14 15:42:09.000000000 -0400
@@ -5,37 +5,85 @@
 #define __GENERIC_PER_CPU
 #ifdef CONFIG_SMP
 
+# ifdef CONFIG_MODULES
+
+/*
+ *
+ * We declare an percpu_offset section that will hold one pointer
+ * per per_cpu variable.  We don't need to copy this section for every
+ * CPU, so it doesn't waste that much space.  But this makes it more
+ * robust for loading modules, since module per_cpu variables will now
+ * have their own offset and we don't need to allocate space in the kernel
+ * for per_cpu variables that might be loaded by modules. So in the long
+ * run, this saves space since we don't allocate wasted space for each CPU.
+ * - SDR
+ */
+#define DEFINE_PER_CPU(type, name) \
+    __attribute__((__section__(".data.percpu_offset"))) unsigned long *per_cpu_offset__##name; \
+    __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
+
+#define DEFINE_STATIC_PER_CPU(type, name) \
+    static __attribute__((__section__(".data.percpu_offset"))) unsigned long *per_cpu_offset__##name; \
+    static __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
+
+/* var is in discarded region: offset to particular copy we want */
+#define per_cpu(var, cpu) \
+	(*RELOC_HIDE(&per_cpu__##var, (*((unsigned long**)&per_cpu_offset__##var))[cpu]))
+
+#define __get_cpu_var(var) per_cpu(var, smp_processor_id())
+
+#define DECLARE_PER_CPU(type, name)			\
+	extern __typeof__(type) per_cpu__##name;	\
+	extern unsigned long *per_cpu_offset__##name
+
+#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var); \
+	EXPORT_SYMBOL(per_cpu_offset__##var)
+#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var); \
+	EXPORT_SYMBOL_GPL(per_cpu_offset__##var)
+
+#else /* !CONFIG_MODULES */
+
+/*
+ * If we don't have to worry about loading per_cpu variables in modules
+ * then we can just use one global offset.
+ */
+
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
 /* Separate out the type, so (int[3], foo) works. */
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
 
+#define DEFINE_STATIC_PER_CPU(type, name) \
+    static __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
+
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
 
-/* A macro to avoid #include hell... */
-#define percpu_modcopy(pcpudst, src, size)			\
-do {								\
-	unsigned int __i;					\
-	for_each_possible_cpu(__i)				\
-		memcpy((pcpudst)+__per_cpu_offset[__i],		\
-		       (src), (size));				\
-} while (0)
+#define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
+
+#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
+#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
+
+#endif /* CONFIG_MODULES */
+
 #else /* ! SMP */
 
 #define DEFINE_PER_CPU(type, name) \
     __typeof__(type) per_cpu__##name
 
+#define DEFINE_STATIC_PER_CPU(type, name) \
+    static __typeof__(type) per_cpu__##name
+
 #define per_cpu(var, cpu)			(*((void)(cpu), &per_cpu__##var))
 #define __get_cpu_var(var)			per_cpu__##var
 
-#endif	/* SMP */
-
 #define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
 
 #define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
 #define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
 
+#endif	/* SMP */
+
 #endif /* _ASM_GENERIC_PERCPU_H_ */


