Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311501AbSCNEel>; Wed, 13 Mar 2002 23:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311502AbSCNEec>; Wed, 13 Mar 2002 23:34:32 -0500
Received: from [202.135.142.194] ([202.135.142.194]:17419 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S311501AbSCNEeU>; Wed, 13 Mar 2002 23:34:20 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas 
In-Reply-To: Your message of "Wed, 13 Mar 2002 19:55:02 -0800."
             <15504.7958.677592.908691@napali.hpl.hp.com> 
Date: Thu, 14 Mar 2002 15:37:38 +1100
Message-Id: <E16lMzi-0002bb-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15504.7958.677592.908691@napali.hpl.hp.com> you write:
> OK, I see this.  Unfortunately, HIDE_RELOC() causes me problems
> because it prevents me from taking the address of a per-CPU variable.
> This is useful when you have a per-CPU structure (e.g., cpu_info).
> Perhaps there should/could be a version of HIDE_RELOC() that doesn't
> dereference the resulting address?

Yep, valid point.  Patch below: please play.

> I am also a bit concerned however about aliasing that the compiler
> might not detect.  For example, with this code:
> 
> 	this_cpu(foo) = 13;
> 	per_cpu(foo, 0) = 15;
> 	printf("foo=%d\n", this_cpu(foo);
> 
> might print the wrong value if gcc thinks that the first and second
> assignment never alias each other.  Does HIDE_RELOC() take care of
> this also?

I'd be pretty sure the compiler can't assume that.  Richard would
know...

> On a side-note, would you mind moving __per_cpu_data from smp.h into
> compiler.h?  I'd like to use it in processor.h and from that file, I
> can't include smp.h due to a recursive dependency.

I had to fight a similar #include battle with sched.h recently.

I came out with the conclusion that it's better to create a new
include than shuffle inappropriate stuff into other includes to solve
these kind of issues.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/compiler.h working-2.5.7-pre1-nfarp/include/linux/compiler.h
--- linux-2.5.7-pre1/include/linux/compiler.h	Fri Mar  8 14:49:29 2002
+++ working-2.5.7-pre1-nfarp/include/linux/compiler.h	Thu Mar 14 15:32:38 2002
@@ -13,10 +13,4 @@
 #define likely(x)	__builtin_expect((x),1)
 #define unlikely(x)	__builtin_expect((x),0)
 
-/* This macro obfuscates arithmetic on a variable address so that gcc
-   shouldn't recognize the original var, and make assumptions about it */
-#define RELOC_HIDE(var, off)					\
-  ({ __typeof__(&(var)) __ptr;					\
-    __asm__ ("" : "=g"(__ptr) : "0"((void *)&(var) + (off)));	\
-    *__ptr; })
 #endif /* __LINUX_COMPILER_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/percpu.h working-2.5.7-pre1-nfarp/include/linux/percpu.h
--- linux-2.5.7-pre1/include/linux/percpu.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.7-pre1-nfarp/include/linux/percpu.h	Thu Mar 14 15:32:44 2002
@@ -0,0 +1,28 @@
+#ifndef __LINUX_PERCPU_H
+#define __LINUX_PERCPU_H
+
+/* This macro obfuscates arithmetic on a variable address so that gcc
+   shouldn't recognize the original var, and make assumptions about it */
+#define RELOC_HIDE(ptr, off)					\
+  ({ __typeof__(ptr) __ptr;					\
+    __asm__ ("" : "=g"(__ptr) : "0"((void *)(ptr) + (off)));	\
+    __ptr; })
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/smp.h working-2.5.7-pre1-nfarp/include/linux/smp.h
--- linux-2.5.7-pre1/include/linux/smp.h	Mon Mar 11 14:33:14 2002
+++ working-2.5.7-pre1-nfarp/include/linux/smp.h	Thu Mar 14 15:32:23 2002
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
@@ -101,9 +91,5 @@
 #define cpu_online_map				1
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
-#define __per_cpu_data
-#define per_cpu(var, cpu)			var
-#define this_cpu(var)				var
-
 #endif
 #endif
