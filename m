Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266910AbUIPC5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266910AbUIPC5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 22:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUIPC5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 22:57:14 -0400
Received: from mail.renesas.com ([202.234.163.13]:34725 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S266910AbUIPC47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 22:56:59 -0400
Date: Thu, 16 Sep 2004 11:56:43 +0900 (JST)
Message-Id: <20040916.115643.1025228044.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm5] [m32r] Fix to build SMP kernel
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patch to fix compile errors to build SMP kernel for m32r.
This patch is against 2.6.9-rc1-mm5.
Please apply.

Thank you.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/smp.c     |   21 +++++++++++++++------
 arch/m32r/kernel/smpboot.c |   28 ++--------------------------
 2 files changed, 17 insertions(+), 32 deletions(-)


diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/smp.c linux-2.6.9-rc1-mm5/arch/m32r/kernel/smp.c
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/smp.c	2004-09-13 21:44:05.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/kernel/smp.c	2004-09-14 20:02:18.000000000 +0900
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/profile.h>
+#include <linux/cpu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgalloc.h>
@@ -130,6 +131,7 @@ unsigned long send_IPI_mask_phys(cpumask
  *==========================================================================*/
 void smp_send_reschedule(int cpu_id)
 {
+	WARN_ON(cpu_is_offline(cpu_id));
 	send_IPI_mask(cpumask_of_cpu(cpu_id), RESCHEDULE_IPI, 1);
 }
 
@@ -394,7 +396,6 @@ void smp_flush_tlb_page(struct vm_area_s
 static void flush_tlb_others(cpumask_t cpumask, struct mm_struct *mm,
 	struct vm_area_struct *vma, unsigned long va)
 {
-	cpumask_t tmp;
 	unsigned long *mask;
 #ifdef DEBUG_SMP
 	unsigned long flags;
@@ -412,11 +413,14 @@ static void flush_tlb_others(cpumask_t c
 	 */
 	BUG_ON(cpus_empty(cpumask));
 
-	cpus_and(tmp, cpumask, cpu_online_map);
-	BUG_ON(!cpus_equal(cpumask, tmp));
 	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
 	BUG_ON(!mm);
 
+	/* If a CPU which we ran on has gone down, OK. */
+	cpus_and(cpumask, cpumask, cpu_online_map);
+	if (cpus_empty(cpumask))
+		return;
+
 	/*
 	 * i'm not happy about this global shared spinlock in the
 	 * MM hot path, but we'll see how contended it is.
@@ -592,7 +596,7 @@ int smp_call_function(void (*func) (void
 	int wait)
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus() - 1;
+	int cpus;
 
 #ifdef DEBUG_SMP
 	unsigned long flags;
@@ -601,8 +605,14 @@ int smp_call_function(void (*func) (void
 		BUG();
 #endif /* DEBUG_SMP */
 
-	if (!cpus)
+	/* Holding any lock stops cpus from going down. */
+	spin_lock(&call_lock);
+	cpus = num_online_cpus() - 1;
+
+	if (!cpus) {
+		spin_unlock(&call_lock);
 		return 0;
+	}
 
 	/* Can deadlock when called with interrupts disabled */
 	WARN_ON(irqs_disabled());
@@ -614,7 +624,6 @@ int smp_call_function(void (*func) (void
 	if (wait)
 		atomic_set(&data.finished, 0);
 
-	spin_lock(&call_lock);
 	call_data = &data;
 	mb();
 
diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/smpboot.c linux-2.6.9-rc1-mm5/arch/m32r/kernel/smpboot.c
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/smpboot.c	2004-09-13 21:44:05.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/kernel/smpboot.c	2004-09-15 16:07:15.000000000 +0900
@@ -2,7 +2,7 @@
  *  linux/arch/m32r/kernel/smpboot.c
  *    orig : i386 2.4.10
  *
- *  MITSUBISHI M32R SMP booting functions
+ *  M32R SMP booting functions
  *
  *  Copyright (c) 2001, 2002, 2003  Hitoshi Yamamoto
  *
@@ -39,8 +39,6 @@
  *		Martin J. Bligh	: 	Added support for multi-quad systems
  */
 
-/* $Id$ */
-
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -117,7 +115,6 @@ unsigned long cache_decay_ticks = HZ / 1
 
 void smp_prepare_boot_cpu(void);
 void smp_prepare_cpus(unsigned int);
-static struct task_struct *fork_by_hand(void);
 static void smp_tune_scheduling(void);
 static void init_ipi_lock(void);
 static void do_boot_cpu(int);
@@ -238,20 +235,6 @@ smp_done:
 	Dprintk("Boot done.\n");
 }
 
-/*
- * fork_by_hand : This routin executes do_fork for APs idle process.
- */
-static struct task_struct * __init fork_by_hand(void)
-{
-	struct pt_regs regs = { 0 };
-
-	/*
-	 * don't care about the eip and regs settings since
-	 * we'll never reschedule the forked task.
-	 */
-	return copy_process(CLONE_VM | CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
-}
-
 static void __init smp_tune_scheduling(void)
 {
 	/* Nothing to do. */
@@ -297,18 +280,11 @@ static void __init do_boot_cpu(int phys_
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
 	 */
-	idle = fork_by_hand();
+	idle = fork_idle(cpu_id);
 	if (IS_ERR(idle))
 		panic("failed fork for CPU#%d.", cpu_id);
-	wake_up_forked_process(idle);
 
-	/*
-	 * We remove it from the pidhash and the runqueue
-	 * once we got the process:
-	 */
-	init_idle(idle, cpu_id);
 	idle->thread.lr = (unsigned long)start_secondary;
-	unhash_process(idle);
 
 	map_cpu_to_physid(cpu_id, phys_id);
 

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
