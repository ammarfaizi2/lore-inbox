Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313855AbSDILvP>; Tue, 9 Apr 2002 07:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313857AbSDILvO>; Tue, 9 Apr 2002 07:51:14 -0400
Received: from [62.221.7.202] ([62.221.7.202]:43913 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S313855AbSDILvN>; Tue, 9 Apr 2002 07:51:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] per-cpu cleanup
Date: Tue, 09 Apr 2002 21:54:35 +1000
Message-Id: <E16uuCp-00028a-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Retransmit.  As per David Mosberger's request, splits into per-arch
files (solves the #include mess), and fixes my "was not an lvalue"
bug.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-generic/percpu.h working-2.5.7-pre1-percpu-sched/include/asm-generic/percpu.h
--- linux-2.5.7-pre1/include/asm-generic/percpu.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.7-pre1-percpu-sched/include/asm-generic/percpu.h	Fri Mar 15 13:24:57 2002
@@ -0,0 +1,13 @@
+#ifndef _ASM_GENERIC_PERCPU_H_
+#define _ASM_GENERIC_PERCPU_H_
+
+#define __GENERIC_PER_CPU
+#include <linux/compiler.h>
+
+extern unsigned long __per_cpu_offset[NR_CPUS];
+
+/* var is in discarded region: offset to particular copy we want */
+#define per_cpu(var, cpu) (*RELOC_HIDE(&var, __per_cpu_offset[cpu]))
+#define this_cpu(var) per_cpu(var, smp_processor_id())
+
+#endif /* _ASM_GENERIC_PERCPU_H_ */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-i386/percpu.h working-2.5.7-pre1-percpu-sched/include/asm-i386/percpu.h
--- linux-2.5.7-pre1/include/asm-i386/percpu.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.7-pre1-percpu-sched/include/asm-i386/percpu.h	Fri Mar 15 12:55:35 2002
@@ -0,0 +1,6 @@
+#ifndef __ARCH_I386_PERCPU__
+#define __ARCH_I386_PERCPU__
+
+#include <asm-generic/percpu.h>
+
+#endif /* __ARCH_I386_PERCPU__ */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-ppc/percpu.h working-2.5.7-pre1-percpu-sched/include/asm-ppc/percpu.h
--- linux-2.5.7-pre1/include/asm-ppc/percpu.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.7-pre1-percpu-sched/include/asm-ppc/percpu.h	Fri Mar 15 14:05:36 2002
@@ -0,0 +1,6 @@
+#ifndef __ARCH_PPC_PERCPU__
+#define __ARCH_PPC_PERCPU__
+
+#include <asm-generic/percpu.h>
+
+#endif /* __ARCH_PPC_PERCPU__ */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/compiler.h working-2.5.7-pre1-percpu-sched/include/linux/compiler.h
--- linux-2.5.7-pre1/include/linux/compiler.h	Fri Mar  8 14:49:29 2002
+++ working-2.5.7-pre1-percpu-sched/include/linux/compiler.h	Fri Mar 15 12:56:39 2002
@@ -15,8 +15,8 @@
 
 /* This macro obfuscates arithmetic on a variable address so that gcc
    shouldn't recognize the original var, and make assumptions about it */
-#define RELOC_HIDE(var, off)					\
-  ({ __typeof__(&(var)) __ptr;					\
-    __asm__ ("" : "=g"(__ptr) : "0"((void *)&(var) + (off)));	\
-    *__ptr; })
+#define RELOC_HIDE(ptr, off)					\
+  ({ __typeof__(ptr) __ptr;					\
+    __asm__ ("" : "=g"(__ptr) : "0"((void *)(ptr) + (off)));	\
+    __ptr; })
 #endif /* __LINUX_COMPILER_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/percpu.h working-2.5.7-pre1-percpu-sched/include/linux/percpu.h
--- linux-2.5.7-pre1/include/linux/percpu.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.7-pre1-percpu-sched/include/linux/percpu.h	Fri Mar 15 14:05:36 2002
@@ -0,0 +1,14 @@
+#ifndef __LINUX_PERCPU_H
+#define __LINUX_PERCPU_H
+#include <linux/config.h>
+
+#ifdef CONFIG_SMP
+#define __per_cpu_data	__attribute__((section(".data.percpu")))
+#include <asm/percpu.h>
+#else
+#define __per_cpu_data
+#define per_cpu(var, cpu)			var
+#define this_cpu(var)				var
+#endif
+
+#endif /* __LINUX_PERCPU_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/smp.h working-2.5.7-pre1-percpu-sched/include/linux/smp.h
--- linux-2.5.7-pre1/include/linux/smp.h	Mon Mar 11 14:33:14 2002
+++ working-2.5.7-pre1-percpu-sched/include/linux/smp.h	Fri Mar 15 14:02:21 2002
@@ -72,16 +72,6 @@
 #define MSG_RESCHEDULE		0x0003	/* Reschedule request from master CPU*/
 #define MSG_CALL_FUNCTION       0x0004  /* Call function on all other CPUs */
 
-#define __per_cpu_data	__attribute__((section(".data.percpu")))
-
-#ifndef __HAVE_ARCH_PER_CPU
-extern unsigned long __per_cpu_offset[NR_CPUS];
-
-/* var is in discarded region: offset to particular copy we want */
-#define per_cpu(var, cpu) RELOC_HIDE(var, per_cpu_offset(cpu))
-
-#define this_cpu(var) per_cpu(var, smp_processor_id())
-#endif /* !__HAVE_ARCH_PER_CPU */
 #else /* !SMP */
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/init/main.c working-2.5.7-pre1-percpu-sched/init/main.c
--- linux-2.5.7-pre1/init/main.c	Fri Mar  8 14:49:30 2002
+++ working-2.5.7-pre1-percpu-sched/init/main.c	Fri Mar 15 14:01:31 2002
@@ -27,6 +27,7 @@
 #include <linux/iobuf.h>
 #include <linux/bootmem.h>
 #include <linux/tty.h>
+#include <linux/percpu.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -270,12 +271,9 @@
 #define smp_init()	do { } while (0)
 #endif
 
-static inline void setup_per_cpu_areas(void)
-{
-}
 #else
 
-#ifndef __HAVE_ARCH_PER_CPU
+#ifdef __GENERIC_PER_CPU
 unsigned long __per_cpu_offset[NR_CPUS];
 
 static void __init setup_per_cpu_areas(void)
@@ -297,7 +295,11 @@
 		memcpy(ptr, __per_cpu_start, size);
 	}
 }
-#endif /* !__HAVE_ARCH_PER_CPU */
+#else
+static inline void setup_per_cpu_areas(void)
+{
+}
+#endif /* !__GENERIC_PER_CPU */
 
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
