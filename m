Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317035AbSHJP1r>; Sat, 10 Aug 2002 11:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317056AbSHJP1r>; Sat, 10 Aug 2002 11:27:47 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:33550 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317035AbSHJP1n>; Sat, 10 Aug 2002 11:27:43 -0400
Date: Sat, 10 Aug 2002 19:30:52 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.30] alpha: percpu update [7/10]
Message-ID: <20020810193052.F20534@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generic per-cpu areas; wrappers for SMP boot process.

Ivan.

--- 2.5.30/include/asm-alpha/percpu.h	Thu Jan  1 00:00:00 1970
+++ linux/include/asm-alpha/percpu.h	Sat Aug 10 01:29:20 2002
@@ -0,0 +1,6 @@
+#ifndef __ALPHA_PERCPU_H
+#define __ALPHA_PERCPU_H
+
+#include <asm-generic/percpu.h>
+
+#endif /* __ALPHA_PERCPU_H */
--- 2.5.30/arch/alpha/vmlinux.lds.in	Sun May 26 13:58:11 2002
+++ linux/arch/alpha/vmlinux.lds.in	Sat Aug 10 01:29:20 2002
@@ -58,6 +58,11 @@ SECTIONS
 	__initcall_end = .;
   }
 
+  . = ALIGN(64);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
+
   /* The initial task and kernel stack */
   .data.init_thread ALIGN(2*8192) : {
 	__init_end = .;
--- 2.5.30/arch/alpha/kernel/smp.c	Sat Aug 10 01:24:08 2002
+++ linux/arch/alpha/kernel/smp.c	Sat Aug 10 01:29:20 2002
@@ -441,7 +441,7 @@ fork_by_hand(void)
  * Bring one cpu online.
  */
 static int __init
-smp_boot_one_cpu(int cpuid, int cpunum)
+smp_boot_one_cpu(int cpuid)
 {
 	struct task_struct *idle;
 	long timeout;
@@ -578,7 +578,7 @@ smp_boot_cpus(void)
 		if (((hwrpb_cpu_present_mask >> i) & 1) == 0)
 			continue;
 
-		if (smp_boot_one_cpu(i, cpu_count))
+		if (smp_boot_one_cpu(i))
 			continue;
 
 		cpu_present_mask |= 1UL << i;
@@ -603,14 +603,22 @@ smp_boot_cpus(void)
 	smp_num_cpus = cpu_count;
 }
 
-/*
- * Called by smp_init to release the blocking online cpus once they 
- * are all started.
- */
 void __init
-smp_commence(void)
+smp_prepare_cpus(unsigned int max_cpus)
+{
+	smp_boot_cpus();
+}
+
+int __devinit
+__cpu_up(unsigned int cpu)
+{
+	return cpu_online(cpu) ? 0 : -ENOSYS;
+}
+
+void __init
+smp_cpus_done(unsigned int max_cpus)
 {
-	/* smp_init sets smp_threads_ready -- that's enough.  */
+	smp_threads_ready = 1;
 	mb();
 }
 
