Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263445AbTETBSf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 21:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTETBSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 21:18:34 -0400
Received: from dp.samba.org ([66.70.73.150]:10649 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263445AbTETBSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 21:18:32 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, David Mosberger-Tang <davidm@hpl.hp.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [PATCH 2/3] Per-cpu SMP unification
Date: Tue, 20 May 2003 11:23:46 +1000
Message-Id: <20030520013131.294E42C082@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Untested on ia64, but fairly trivial if I've broken something ].

Name: Unification of per-cpu headers for SMP
Author: Rusty Russell
Status: Trivial
Depends: Misc/percpu-up-unify.patch.gz

D: There's really only one sane way to implement accessing other CPU's
D: variables, there's no real reason for archs to use a method other
D: than __per_cpu_offset[], so move that from asm-*/percpu.h to
D: linux/percpu.h.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14538-linux-2.5.69-bk13/include/asm-generic/percpu.h .14538-linux-2.5.69-bk13.updated/include/asm-generic/percpu.h
--- .14538-linux-2.5.69-bk13/include/asm-generic/percpu.h	2003-05-19 15:08:47.000000000 +1000
+++ .14538-linux-2.5.69-bk13.updated/include/asm-generic/percpu.h	2003-05-19 15:08:48.000000000 +1000
@@ -5,16 +5,12 @@
 #define __GENERIC_PER_CPU
 #ifdef CONFIG_SMP
 
-extern unsigned long __per_cpu_offset[NR_CPUS];
-
 /* Separate out the type, so (int[3], foo) works. */
 #ifndef MODULE
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
 #endif
 
-/* var is in discarded region: offset to particular copy we want */
-#define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
 
 #endif	/* SMP */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14538-linux-2.5.69-bk13/include/asm-ia64/percpu.h .14538-linux-2.5.69-bk13.updated/include/asm-ia64/percpu.h
--- .14538-linux-2.5.69-bk13/include/asm-ia64/percpu.h	2003-05-19 15:08:47.000000000 +1000
+++ .14538-linux-2.5.69-bk13.updated/include/asm-ia64/percpu.h	2003-05-19 15:08:48.000000000 +1000
@@ -18,15 +18,12 @@
 #include <linux/threads.h>
 
 #ifdef CONFIG_SMP
-extern unsigned long __per_cpu_offset[NR_CPUS];
-
 #ifndef MODULE
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
 #endif
 
 #define __get_cpu_var(var)	(var##__per_cpu)
-#define per_cpu(var, cpu)	(*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
 #endif /* CONFIG_SMP */
 
 extern void setup_per_cpu_areas (void);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14538-linux-2.5.69-bk13/include/linux/percpu.h .14538-linux-2.5.69-bk13.updated/include/linux/percpu.h
--- .14538-linux-2.5.69-bk13/include/linux/percpu.h	2003-05-19 15:08:47.000000000 +1000
+++ .14538-linux-2.5.69-bk13.updated/include/linux/percpu.h	2003-05-19 15:08:48.000000000 +1000
@@ -10,6 +10,10 @@
 
 #ifdef CONFIG_SMP
 
+/* var is in discarded region: offset to particular copy we want */
+#define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
+extern unsigned long __per_cpu_offset[NR_CPUS];
+
 struct percpu_data {
 	void *ptrs[NR_CPUS];
 	void *blkp;

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
