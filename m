Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277344AbRJEKqx>; Fri, 5 Oct 2001 06:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277347AbRJEKqq>; Fri, 5 Oct 2001 06:46:46 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:1284 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S277344AbRJEKq1>;
	Fri, 5 Oct 2001 06:46:27 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15293.36735.916722.498977@cargo.ozlabs.ibm.com>
Date: Fri, 5 Oct 2001 20:46:23 +1000 (EST)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: trini@kernel.crashing.org, benh@kernel.crashing.org
Subject: [PATCH] change name of rep_nop
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was a bit dismayed by the changes to smp_init() in init/main.c in
the pre4 patch, because:

* rep_nop() is a silly name, it is not at all obvious what it does, in
  fact even if you know it does the rep; nop instruction sequence on
  x86 it still isn't obvious even to most x86 users what it would do.
  I propose that we change the name to cpu_relax as a more descriptive
  name.

* The change breaks the SMP compile on all platforms except x86, since
  rep_nop is only defined for x86.

* Why are we using a volatile attribute on wait_init_idle instead of
  using a barrier?

Here is a patch that addresses those three issues.  It adds an empty
definition of cpu_relax for all architectures except x86 (for x86 it
is defined to be rep_nop), and it changes smp_init to use a barrier
instead of making wait_init_idle be volatile.

The patch also includes definitions for prefetch* on PPC since they
were also in our local asm-ppc/processor.h.

This compiles and runs correctly on a 4-way PPC box here.

Linus, please apply this to your tree.

Thanks,
Paul.

diff -urN linux/include/asm-alpha/processor.h pmac/include/asm-alpha/processor.h
--- linux/include/asm-alpha/processor.h	Mon Sep 24 09:31:35 2001
+++ pmac/include/asm-alpha/processor.h	Fri Oct  5 15:58:47 2001
@@ -148,6 +148,8 @@
 #define init_task	(init_task_union.task)
 #define init_stack	(init_task_union.stack)
 
+#define cpu_relax()	do { } while (0)
+
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
 #define ARCH_HAS_SPINLOCK_PREFETCH
diff -urN linux/include/asm-arm/processor.h pmac/include/asm-arm/processor.h
--- linux/include/asm-arm/processor.h	Mon Sep 24 09:31:35 2001
+++ pmac/include/asm-arm/processor.h	Fri Oct  5 15:59:05 2001
@@ -112,6 +112,8 @@
 #define init_task	(init_task_union.task)
 #define init_stack	(init_task_union.stack)
 
+#define cpu_relax()	do { } while (0)
+
 /*
  * Create a new kernel thread
  */
diff -urN linux/include/asm-cris/processor.h pmac/include/asm-cris/processor.h
--- linux/include/asm-cris/processor.h	Mon Sep 24 09:31:35 2001
+++ pmac/include/asm-cris/processor.h	Fri Oct  5 15:59:21 2001
@@ -141,4 +141,6 @@
 #define init_task       (init_task_union.task)
 #define init_stack      (init_task_union.stack)
 
+#define cpu_relax()	do { } while (0)
+
 #endif /* __ASM_CRIS_PROCESSOR_H */
diff -urN linux/include/asm-i386/processor.h pmac/include/asm-i386/processor.h
--- linux/include/asm-i386/processor.h	Mon Sep 24 09:31:35 2001
+++ pmac/include/asm-i386/processor.h	Fri Oct  5 15:58:05 2001
@@ -476,6 +476,8 @@
 	__asm__ __volatile__("rep;nop");
 }
 
+#define cpu_relax()	rep_nop()
+
 /* Prefetch instructions for Pentium III and AMD Athlon */
 #ifdef 	CONFIG_MPENTIUMIII
 
diff -urN linux/include/asm-ia64/processor.h pmac/include/asm-ia64/processor.h
--- linux/include/asm-ia64/processor.h	Mon Sep 24 09:31:35 2001
+++ pmac/include/asm-ia64/processor.h	Fri Oct  5 15:59:38 2001
@@ -969,6 +969,8 @@
 	return result;
 }
 
+#define cpu_relax()	do { } while (0)
+
 
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
diff -urN linux/include/asm-m68k/processor.h pmac/include/asm-m68k/processor.h
--- linux/include/asm-m68k/processor.h	Mon Sep 24 09:31:35 2001
+++ pmac/include/asm-m68k/processor.h	Fri Oct  5 15:59:52 2001
@@ -155,4 +155,6 @@
 #define init_task	(init_task_union.task)
 #define init_stack	(init_task_union.stack)
 
+#define cpu_relax()	do { } while (0)
+
 #endif
diff -urN linux/include/asm-mips/processor.h pmac/include/asm-mips/processor.h
--- linux/include/asm-mips/processor.h	Mon Sep 24 09:31:35 2001
+++ pmac/include/asm-mips/processor.h	Fri Oct  5 16:00:04 2001
@@ -259,6 +259,8 @@
 #define init_task	(init_task_union.task)
 #define init_stack	(init_task_union.stack)
 
+#define cpu_relax()	do { } while (0)
+
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 #endif /* __KERNEL__ */
 
diff -urN linux/include/asm-mips64/processor.h pmac/include/asm-mips64/processor.h
--- linux/include/asm-mips64/processor.h	Mon Sep 24 09:31:36 2001
+++ pmac/include/asm-mips64/processor.h	Fri Oct  5 16:00:18 2001
@@ -290,6 +290,8 @@
 #define init_task	(init_task_union.task)
 #define init_stack	(init_task_union.stack)
 
+#define cpu_relax()	do { } while (0)
+
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 #endif /* __KERNEL__ */
 
diff -urN linux/include/asm-parisc/processor.h pmac/include/asm-parisc/processor.h
--- linux/include/asm-parisc/processor.h	Mon Sep 24 09:31:36 2001
+++ pmac/include/asm-parisc/processor.h	Fri Oct  5 16:00:29 2001
@@ -333,5 +333,7 @@
 #define init_task (init_task_union.task) 
 #define init_stack (init_task_union.stack)
 
+#define cpu_relax()	do { } while (0)
+
 
 #endif /* __ASM_PARISC_PROCESSOR_H */
diff -urN linux/include/asm-ppc/processor.h pmac/include/asm-ppc/processor.h
--- linux/include/asm-ppc/processor.h	Mon Sep 24 09:31:36 2001
+++ pmac/include/asm-ppc/processor.h	Fri Oct  5 16:26:22 2001
@@ -1,5 +1,5 @@
 /*
- * BK Id: SCCS/s.processor.h 1.28 08/17/01 15:23:17 paulus
+ * BK Id: SCCS/s.processor.h 1.31 10/05/01 16:26:22 paulus
  */
 #ifdef __KERNEL__
 #ifndef __ASM_PPC_PROCESSOR_H
@@ -654,6 +654,27 @@
 
 /* In misc.c */
 void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
+
+#define cpu_relax()	do { } while (0)
+
+/*
+ * Prefetch macros.
+ */
+#define ARCH_HAS_PREFETCH
+#define ARCH_HAS_PREFETCHW
+#define ARCH_HAS_SPINLOCK_PREFETCH
+
+extern inline void prefetch(const void *x)
+{
+	 __asm__ __volatile__ ("dcbt 0,%0" : : "r" (x));
+}
+
+extern inline void prefetchw(const void *x)
+{
+	 __asm__ __volatile__ ("dcbtst 0,%0" : : "r" (x));
+}
+
+#define spin_lock_prefetch(x)	prefetchw(x)
 
 #endif /* !__ASSEMBLY__ */
 
diff -urN linux/include/asm-s390/processor.h pmac/include/asm-s390/processor.h
--- linux/include/asm-s390/processor.h	Mon Sep 24 09:31:36 2001
+++ pmac/include/asm-s390/processor.h	Fri Oct  5 16:01:03 2001
@@ -149,6 +149,8 @@
 #define init_task       (init_task_union.task)
 #define init_stack      (init_task_union.stack)
 
+#define cpu_relax()	do { } while (0)
+
 /*
  * Set of msr bits that gdb can change on behalf of a process.
  */
diff -urN linux/include/asm-s390x/processor.h pmac/include/asm-s390x/processor.h
--- linux/include/asm-s390x/processor.h	Mon Sep 24 09:31:36 2001
+++ pmac/include/asm-s390x/processor.h	Fri Oct  5 16:01:12 2001
@@ -159,6 +159,8 @@
 #define init_task       (init_task_union.task)
 #define init_stack      (init_task_union.stack)
 
+#define cpu_relax()	do { } while (0)
+
 /*
  * Set of msr bits that gdb can change on behalf of a process.
  */
diff -urN linux/include/asm-sh/processor.h pmac/include/asm-sh/processor.h
--- linux/include/asm-sh/processor.h	Mon Sep 24 09:31:37 2001
+++ pmac/include/asm-sh/processor.h	Fri Oct  5 16:01:20 2001
@@ -218,4 +218,6 @@
 #define init_task	(init_task_union.task)
 #define init_stack	(init_task_union.stack)
 
+#define cpu_relax()	do { } while (0)
+
 #endif /* __ASM_SH_PROCESSOR_H */
diff -urN linux/include/asm-sparc/processor.h pmac/include/asm-sparc/processor.h
--- linux/include/asm-sparc/processor.h	Mon Sep 24 09:31:37 2001
+++ pmac/include/asm-sparc/processor.h	Fri Oct  5 16:01:36 2001
@@ -201,6 +201,8 @@
 #define init_task	(init_task_union.task)
 #define init_stack	(init_task_union.stack)
 
+#define cpu_relax()	do { } while (0)
+
 #endif
 
 #endif /* __ASM_SPARC_PROCESSOR_H */
diff -urN linux/include/asm-sparc64/processor.h pmac/include/asm-sparc64/processor.h
--- linux/include/asm-sparc64/processor.h	Mon Sep 24 09:31:37 2001
+++ pmac/include/asm-sparc64/processor.h	Fri Oct  5 16:01:46 2001
@@ -276,6 +276,8 @@
 #define init_task	(init_task_union.task)
 #define init_stack	(init_task_union.stack)
 
+#define cpu_relax()	do { } while (0)
+
 #endif /* __KERNEL__ */
 
 #endif /* !(__ASSEMBLY__) */
diff -urN linux/init/main.c pmac/init/main.c
--- linux/init/main.c	Fri Oct  5 14:35:22 2001
+++ pmac/init/main.c	Fri Oct  5 16:09:38 2001
@@ -482,7 +482,7 @@
 extern void setup_arch(char **);
 extern void cpu_idle(void);
 
-volatile unsigned long wait_init_idle = 0UL;
+unsigned long wait_init_idle;
 
 #ifndef CONFIG_SMP
 
@@ -510,13 +510,12 @@
 	smp_commence();
 
 	/* Wait for the other cpus to set up their idle processes */
-        while (1) {
-                if (!wait_init_idle)
-                        break;
-                rep_nop();
-        }
+	while (wait_init_idle) {
+		cpu_relax();
+		barrier();
+	}
 	printk("All processors have done init_idle\n");
-}		
+}
 
 #endif
 
diff -urN linux/kernel/sched.c pmac/kernel/sched.c
--- linux/kernel/sched.c	Fri Oct  5 14:35:22 2001
+++ pmac/kernel/sched.c	Fri Oct  5 16:03:03 2001
@@ -1309,7 +1309,7 @@
 	atomic_inc(&current->files->count);
 }
 
-extern volatile unsigned long wait_init_idle;
+extern unsigned long wait_init_idle;
 
 void __init init_idle(void)
 {
