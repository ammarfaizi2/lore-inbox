Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311598AbSCNMNv>; Thu, 14 Mar 2002 07:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311599AbSCNMNm>; Thu, 14 Mar 2002 07:13:42 -0500
Received: from [202.135.142.196] ([202.135.142.196]:38671 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S311598AbSCNMN3>; Thu, 14 Mar 2002 07:13:29 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas 
In-Reply-To: Your message of "Thu, 14 Mar 2002 06:26:40 CDT."
             <3C9088F0.8090602@mandrakesoft.com> 
Date: Thu, 14 Mar 2002 23:16:40 +1100
Message-Id: <E16lU9w-0005GY-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3C9088F0.8090602@mandrakesoft.com> you write:
> >It was an arbitrary and relatively crappy place to put it: I only put
> >it there so PPC could use it...
> >
> Will other arches -ever- use the macro?  If not, include/asm-ppc is a 
> better place...
> 
>     Jeff "mountain out of a molehill" Garzik

Yes, clearly this is a decision which should not be rushed into.  I
suggest long and vigorous debate on linux-kernel, with mentions of
devfs, source control systems...

Honestly, I think "compiler.h" is a really bad grouping if it's for
compiler-specific things: surely things should be grouped by
function.  Hence all of compiler.h should be move to kernel.h anyway.

Here's my latest attempt (untested: for reading only), which leaves it
in compiler.h: possession is 9/10 of the law...

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-generic/percpu.h working-2.5.7-pre1-percpu/include/asm-generic/percpu.h
--- linux-2.5.7-pre1/include/asm-generic/percpu.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.7-pre1-percpu/include/asm-generic/percpu.h	Thu Mar 14 23:14:17 2002
@@ -0,0 +1,16 @@
+#ifndef _ASM_GENERIC_PERCPU_H_
+#define _ASM_GENERIC_PERCPU_H_
+
+#define __GENERIC_PER_CPU
+#include <linux/compiler.h>
+
+extern unsigned long __per_cpu_offset[NR_CPUS];
+
+/* var is in discarded region: offset to particular copy we want */
+/* You can't take address.  Use per_cpu_ptr for that */
+#define per_cpu(var, cpu) ({ *RELOC_HIDE(&var, per_cpu_offset(cpu)); })
+#define per_cpu_ptr(var, cpu) RELOC_HIDE(&var, per_cpu_offset(cpu))
+
+#define this_cpu(var) per_cpu(var, smp_processor_id())
+
+#endif /* _ASM_GENERIC_PERCPU_H_ */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-i386/percpu.h working-2.5.7-pre1-percpu/include/asm-i386/percpu.h
--- linux-2.5.7-pre1/include/asm-i386/percpu.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.7-pre1-percpu/include/asm-i386/percpu.h	Thu Mar 14 22:59:52 2002
@@ -0,0 +1,8 @@
+#ifndef __ARCH_I386_PERCPU__
+#define __ARCH_I386_PERCPU__
+
+#ifdef CONFIG_SMP
+#include <asm-generic/percpu.h>
+#endif
+
+#endif /* __ARCH_I386_PERCPU__ */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/compiler.h working-2.5.7-pre1-percpu/include/linux/compiler.h
--- linux-2.5.7-pre1/include/linux/compiler.h	Fri Mar  8 14:49:29 2002
+++ working-2.5.7-pre1-percpu/include/linux/compiler.h	Thu Mar 14 22:54:53 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/percpu.h working-2.5.7-pre1-percpu/include/linux/percpu.h
--- linux-2.5.7-pre1/include/linux/percpu.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.7-pre1-percpu/include/linux/percpu.h	Thu Mar 14 22:52:25 2002
@@ -0,0 +1,22 @@
+#ifndef __LINUX_PERCPU_H
+#define __LINUX_PERCPU_H
+#include <linux/compiler.h>
+
+#ifdef CONFIG_SMP
+#define __per_cpu_data	__attribute__((section(".data.percpu")))
+
+#ifndef __HAVE_ARCH_PER_CPU
+extern unsigned long __per_cpu_offset[NR_CPUS];
+
+/* var is in discarded region: offset to particular copy we want */
+#define per_cpu(var, cpu) (*RELOC_HIDE(&var, per_cpu_offset(cpu)))
+
+#define this_cpu(var) per_cpu(var, smp_processor_id())
+#endif /* !__HAVE_ARCH_PER_CPU */
+#else
+#define __per_cpu_data
+#define per_cpu(var, cpu)			var
+#define this_cpu(var)				var
+#endif /* CONFIG_SMP */
+
+#endif /* __LINUX_PERCPU_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/smp.h working-2.5.7-pre1-percpu/include/linux/smp.h
--- linux-2.5.7-pre1/include/linux/smp.h	Mon Mar 11 14:33:14 2002
+++ working-2.5.7-pre1-percpu/include/linux/smp.h	Thu Mar 14 23:15:00 2002
@@ -74,14 +74,6 @@
 
 #define __per_cpu_data	__attribute__((section(".data.percpu")))
 
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
@@ -102,7 +94,8 @@
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
 #define __per_cpu_data
-#define per_cpu(var, cpu)			var
+#define per_cpu(var, cpu)			({ var; })
+#define per_cpu_ptr(var, cpu)			(&(var))
 #define this_cpu(var)				var
 
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/init/main.c working-2.5.7-pre1-percpu/init/main.c
--- linux-2.5.7-pre1/init/main.c	Fri Mar  8 14:49:30 2002
+++ working-2.5.7-pre1-percpu/init/main.c	Thu Mar 14 22:58:06 2002
@@ -275,7 +275,7 @@
 }
 #else
 
-#ifndef __HAVE_ARCH_PER_CPU
+#ifdef __GENERIC_PER_CPU
 unsigned long __per_cpu_offset[NR_CPUS];
 
 static void __init setup_per_cpu_areas(void)
@@ -297,7 +297,7 @@
 		memcpy(ptr, __per_cpu_start, size);
 	}
 }
-#endif /* !__HAVE_ARCH_PER_CPU */
+#endif /* __GENERIC_PER_CPU */
 
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
