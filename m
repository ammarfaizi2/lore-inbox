Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWDODLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWDODLm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 23:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWDODLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 23:11:15 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:39060 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030223AbWDODLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 23:11:06 -0400
Subject: [PATCH 08/08] percpu -v2 x86_64 arch updates
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 23:11:05 -0400
Message-Id: <1145070665.27407.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changed the x86_64 percpu.h file to use the asm-generic/percpu.h if
CONFIG_SMP and CONFIG_MODULES are defined.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>


Index: linux-2.6.17-rc1/include/asm-x86_64/percpu.h
===================================================================
--- linux-2.6.17-rc1.orig/include/asm-x86_64/percpu.h	2006-04-14 20:38:36.000000000 -0400
+++ linux-2.6.17-rc1/include/asm-x86_64/percpu.h	2006-04-14 20:45:08.000000000 -0400
@@ -9,6 +9,18 @@
 
 #ifdef CONFIG_SMP
 
+#ifdef CONFIG_MODULES
+/*
+ * When both CONFIG_SMP and CONFIG_MODULES are used, we can't take
+ * advantage of the pda structure. Since modules now have their own
+ * per_cpu section, to find the offset, we have a separate pointer
+ * to each per_cpu variable.
+ */
+
+#include <asm-generic/percpu.h>
+
+#else /* !CONFIG_MODULES */
+
 #include <asm/pda.h>
 
 #define __per_cpu_offset(cpu) (cpu_pda(cpu)->data_offset)
@@ -18,6 +30,9 @@
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
 
+#define DEFINE_STATIC_PER_CPU(type, name) \
+    static DEFINE_PER_CPU(type, name)
+
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset(cpu)))
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
@@ -33,19 +48,29 @@ do {								\
 
 extern void setup_per_cpu_areas(void);
 
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
+    static DEFINE_PER_CPU(type, name)
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
 #endif /* _ASM_X8664_PERCPU_H_ */
Index: linux-2.6.17-rc1/arch/x86_64/kernel/setup64.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/x86_64/kernel/setup64.c	2006-04-03 16:21:20.000000000 -0400
+++ linux-2.6.17-rc1/arch/x86_64/kernel/setup64.c	2006-04-14 20:43:05.000000000 -0400
@@ -78,11 +78,8 @@ static int __init nonx32_setup(char *str
 }
 __setup("noexec32=", nonx32_setup);
 
-/*
- * Great future plan:
- * Declare PDA itself and support (irqstack,tss,pgd) as per cpu data.
- * Always point %gs to its beginning
- */
+
+#if defined(CONFIG_SMP) && !defined(CONFIG_MODULES)
 void __init setup_per_cpu_areas(void)
 { 
 	int i;
@@ -94,10 +91,6 @@ void __init setup_per_cpu_areas(void)
 
 	/* Copy section for each CPU (we discard the original) */
 	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
-#ifdef CONFIG_MODULES
-	if (size < PERCPU_ENOUGH_ROOM)
-		size = PERCPU_ENOUGH_ROOM;
-#endif
 
 	for_each_cpu_mask (i, cpu_possible_map) {
 		char *ptr;
@@ -115,7 +108,13 @@ void __init setup_per_cpu_areas(void)
 		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
 	}
 } 
+#endif /* CONFIG_SMP && !CONFIG_MODULES */
 
+/*
+ * Great future plan:
+ * Declare PDA itself and support (irqstack,tss,pgd) as per cpu data.
+ * Always point %gs to its beginning
+ */
 void pda_init(int cpu)
 { 
 	struct x8664_pda *pda = cpu_pda(cpu);
Index: linux-2.6.17-rc1/arch/x86_64/kernel/smp.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/x86_64/kernel/smp.c	2006-04-14 18:46:04.000000000 -0400
+++ linux-2.6.17-rc1/arch/x86_64/kernel/smp.c	2006-04-14 20:46:39.000000000 -0400
@@ -202,9 +202,8 @@ static void flush_tlb_others(cpumask_t c
 int __cpuinit init_smp_flush(void)
 {
 	int i;
-	for_each_cpu_mask(i, cpu_possible_map) {
-		spin_lock_init(&per_cpu(flush_state.tlbstate_lock, i));
-	}
+	for_each_cpu_mask(i, cpu_possible_map)
+		spin_lock_init(&per_cpu(flush_state, i).tlbstate_lock);
 	return 0;
 }
 


