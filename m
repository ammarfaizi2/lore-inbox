Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311926AbSCOEEq>; Thu, 14 Mar 2002 23:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311927AbSCOEEi>; Thu, 14 Mar 2002 23:04:38 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:5138 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S311926AbSCOEET>; Thu, 14 Mar 2002 23:04:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas 
In-Reply-To: Your message of "Thu, 14 Mar 2002 19:51:22 BST."
             <20020314195122.A30566@wotan.suse.de> 
Date: Fri, 15 Mar 2002 15:07:27 +1100
Message-Id: <E16lj03-0007Zm-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020314195122.A30566@wotan.suse.de> you write:
> On Thu, Mar 14, 2002 at 10:04:05AM -0800, David Mosberger wrote:
> > How about the following proposal:
> > 
> > 	- taking the address of this_cpu(var) is never allowed (can be
> >           enforced with RELOC_HIDE())
> > 
> > 	- taking the address of per_cpu(var, n) is always legal and
> > 	  will return a pointer which will access CPU n's version of
> > 	  the variable, no matter what CPU dereferences the pointer
> > 
> > Andi, I think this would take care of the x86-64 problem as well, right?
> 
> Yes, it would. 

Sorry, after thought, I've reverted to my original position.  the
original SMP per_cpu()/this_cpu() implementations were broken.

They must return an lvalue, otherwise they're useless for 50% of cases
(ie. assignment).  x86_64 can still use its own mechanism for
arch-specific per-cpu data, of course.

If you disagree, please prove it by implementing an alternative to
this patch (which uses per-cpu areas):

	http://www.kernel.org/pub/linux/kernel/people/rusty/Misc/percpu-tasklet.patch.gz

So this is the patch I'll send to Linus if no complaints:

1) Make per_cpu()/this_cpu() return an lvalue on SMP.
2) Moves out of smp.h to percpu.h & asm/percpu.h, so it can be
   included anywhere (eg. processor.h)

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
