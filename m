Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266254AbUHFDfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266254AbUHFDfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 23:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUHFDfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 23:35:37 -0400
Received: from holomorphy.com ([207.189.100.168]:11720 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266254AbUHFDex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 23:34:53 -0400
Date: Thu, 5 Aug 2004 20:34:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1
Message-ID: <20040806033448.GP17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805031918.08790a82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805031918.08790a82.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 03:19:18AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc3/2.6.8-rc3-mm1/
> - Added David Woodhouse's MTD tree to the "external trees" list
> - Dropped the staircase scheduler, mainly because the schedstats patch broke
>   it.
>   We learned quite a lot from having staircase in there.  Now it's time for
>   a new scheduler anyway.

sched-clean-init-idle.patch is still broken. Removing deactivate_task()
from init_idle() breaks the arches that instead of doing copy_process()
do kernel_thread(NULL, NULL, CLONE_IDLETASK), with all of the obvious
consequences of leaving a task with a NULL program counter on one queue
where it may be executed by accident and simultaneously executed on yet
another cpu via the SMP trampoline, even sharing the stack between cpus.

The following applies immediately after sched-clean-init-idle.patch;
I'm not convinced fork_by_hand() is worth the bloat, as a simple
deactivate_task() in init_idle(), would allow all the arches to use the
sparc64 method; however, this is consistent with the theme of the
cleanup patch immediately preceding it. If desired, I can implement the
other alternative, and teach all arches to use kernel_thread(...) and
reinstate the deactivate_task() in init_idle().

It appears that init_idle() and fork_by_hand() could be combined into
a single method that calls init_idle() on behalf of the caller, which
would amount to something like:

task_t * __init fork_idle(int cpu)
{
	struct pt_regs regs;
	task_t *task;

	memset(&regs, 0, sizeof(struct pt_regs));
	task = copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
	if (!task)
		return ERR_PTR(-ENOMEM);
	init_idle(task, cpu);
	unhash_process(task);
	return task;
}

Then the call to init_idle() in init/main.c would be folded into
sched_init(), and so init_idle() would become private to kernel/sched.c

The following patch is merely what I used to get things working ASAP.
I'll create whatever form of the init_idle() consolidation's correction
is preferred against whatever tree is needed for merging.


-- wli

Index: mm1-2.6.8-rc3/arch/sparc/kernel/sun4m_smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/sparc/kernel/sun4m_smp.c
+++ mm1-2.6.8-rc3/arch/sparc/kernel/sun4m_smp.c
@@ -175,12 +175,9 @@
 			struct task_struct *p;
 			int timeout;
 
-			/* Cook up an idler for this guy. */
-			kernel_thread(start_secondary, NULL, CLONE_IDLETASK);
-
 			cpucount++;
 
-			p = prev_task(&init_task);
+			p = fork_by_hand();
 
 			init_idle(p, i);
 
Index: mm1-2.6.8-rc3/arch/i386/kernel/smpboot.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/i386/kernel/smpboot.c
+++ mm1-2.6.8-rc3/arch/i386/kernel/smpboot.c
@@ -496,16 +496,6 @@
 	unsigned short ss;
 } stack_start;
 
-static struct task_struct * __init fork_by_hand(void)
-{
-	struct pt_regs regs;
-	/*
-	 * don't care about the eip and regs settings since
-	 * we'll never reschedule the forked task.
-	 */
-	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
-}
-
 #ifdef CONFIG_NUMA
 
 /* which logical CPUs are on which nodes */
Index: mm1-2.6.8-rc3/include/linux/sched.h
===================================================================
--- mm1-2.6.8-rc3.orig/include/linux/sched.h
+++ mm1-2.6.8-rc3/include/linux/sched.h
@@ -885,7 +885,7 @@
 
 extern int do_execve(char *, char __user * __user *, char __user * __user *, struct pt_regs *);
 extern long do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);
-extern struct task_struct * copy_process(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);
+task_t *fork_by_hand(void);
 
 #ifdef CONFIG_SMP
 extern void wait_task_inactive(task_t * p);
Index: mm1-2.6.8-rc3/arch/sparc/kernel/sun4d_smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/sparc/kernel/sun4d_smp.c
+++ mm1-2.6.8-rc3/arch/sparc/kernel/sun4d_smp.c
@@ -204,12 +204,9 @@
 			int timeout;
 			int no;
 
-			/* Cook up an idler for this guy. */
-			kernel_thread(start_secondary, NULL, CLONE_IDLETASK);
-
 			cpucount++;
 
-			p = prev_task(&init_task);
+			p = fork_by_hand();
 
 			init_idle(p, i);
 
Index: mm1-2.6.8-rc3/arch/ppc64/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/ppc64/kernel/smp.c
+++ mm1-2.6.8-rc3/arch/ppc64/kernel/smp.c
@@ -799,14 +799,11 @@
 
 static void __init smp_create_idle(unsigned int cpu)
 {
-	struct pt_regs regs;
 	struct task_struct *p;
 
 	/* create a process for the processor */
 	/* only regs.msr is actually used, and 0 is OK for it */
-	memset(&regs, 0, sizeof(struct pt_regs));
-	p = copy_process(CLONE_VM | CLONE_IDLETASK,
-			 0, &regs, 0, NULL, NULL);
+	p = fork_by_hand();
 	if (IS_ERR(p))
 		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
 
Index: mm1-2.6.8-rc3/arch/mips/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/mips/kernel/smp.c
+++ mm1-2.6.8-rc3/arch/mips/kernel/smp.c
@@ -254,16 +254,6 @@
 	cpu_set(0, cpu_callin_map);
 }
 
-static struct task_struct * __init fork_by_hand(void)
-{
-	struct pt_regs regs;
-	/*
-	 * don't care about the eip and regs settings since
-	 * we'll never reschedule the forked task.
-	 */
-	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
-}
-
 /*
  * Startup the CPU with this logical number
  */
Index: mm1-2.6.8-rc3/arch/s390/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/s390/kernel/smp.c
+++ mm1-2.6.8-rc3/arch/s390/kernel/smp.c
@@ -562,15 +562,13 @@
 
 static void __init smp_create_idle(unsigned int cpu)
 {
-	struct pt_regs regs;
 	struct task_struct *p;
 
 	/*
 	 *  don't care about the psw and regs settings since we'll never
 	 *  reschedule the forked task.
 	 */
-	memset(&regs, 0, sizeof(struct pt_regs));
-	p = copy_process(CLONE_VM | CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
+	p = fork_by_hand();
 	if (IS_ERR(p))
 		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
 
Index: mm1-2.6.8-rc3/arch/ia64/kernel/smpboot.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/ia64/kernel/smpboot.c
+++ mm1-2.6.8-rc3/arch/ia64/kernel/smpboot.c
@@ -356,16 +356,6 @@
 	return cpu_idle();
 }
 
-static struct task_struct * __devinit
-fork_by_hand (void)
-{
-	/*
-	 * Don't care about the IP and regs settings since we'll never reschedule the
-	 * forked task.
-	 */
-	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, 0, 0, NULL, NULL);
-}
-
 struct create_idle {
 	struct task_struct *idle;
 	struct completion done;
Index: mm1-2.6.8-rc3/arch/alpha/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/alpha/kernel/smp.c
+++ mm1-2.6.8-rc3/arch/alpha/kernel/smp.c
@@ -411,15 +411,6 @@
 	return 0;
 }
 
-static struct task_struct * __init
-fork_by_hand(void)
-{
-	/* Don't care about the contents of regs since we'll never
-	   reschedule the forked task. */
-	struct pt_regs regs;
-	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
-}
-
 /*
  * Bring one cpu online.
  */
Index: mm1-2.6.8-rc3/arch/ppc/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/ppc/kernel/smp.c
+++ mm1-2.6.8-rc3/arch/ppc/kernel/smp.c
@@ -364,15 +364,13 @@
 
 int __cpu_up(unsigned int cpu)
 {
-	struct pt_regs regs;
 	struct task_struct *p;
 	char buf[32];
 	int c;
 
 	/* create a process for the processor */
 	/* only regs.msr is actually used, and 0 is OK for it */
-	memset(&regs, 0, sizeof(struct pt_regs));
-	p = copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
+	p = fork_by_hand();
 	if (IS_ERR(p))
 		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
 	init_idle(p, cpu);
Index: mm1-2.6.8-rc3/arch/sparc64/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/sparc64/kernel/smp.c
+++ mm1-2.6.8-rc3/arch/sparc64/kernel/smp.c
@@ -302,9 +302,7 @@
 	struct task_struct *p;
 	int timeout, ret, cpu_node;
 
-	kernel_thread(NULL, NULL, CLONE_IDLETASK);
-
-	p = prev_task(&init_task);
+	p = fork_by_hand();
 
 	init_idle(p, cpu);
 
Index: mm1-2.6.8-rc3/arch/x86_64/kernel/smpboot.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/x86_64/kernel/smpboot.c
+++ mm1-2.6.8-rc3/arch/x86_64/kernel/smpboot.c
@@ -392,16 +392,6 @@
 extern volatile unsigned long init_rsp; 
 extern void (*initial_code)(void);
 
-static struct task_struct * __init fork_by_hand(void)
-{
-	struct pt_regs regs;
-	/*
-	 * don't care about the eip and regs settings since
-	 * we'll never reschedule the forked task.
-	 */
-	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
-}
-
 #if APIC_DEBUG
 static inline void inquire_remote_apic(int apicid)
 {
Index: mm1-2.6.8-rc3/arch/i386/mach-voyager/voyager_smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/i386/mach-voyager/voyager_smp.c
+++ mm1-2.6.8-rc3/arch/i386/mach-voyager/voyager_smp.c
@@ -523,16 +523,6 @@
 	return cpu_idle();
 }
 
-static struct task_struct * __init
-fork_by_hand(void)
-{
-	struct pt_regs regs;
-	/* don't care about the eip and regs settings since we'll
-	 * never reschedule the forked task. */
-	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
-}
-
-
 /* Routine to kick start the given CPU and wait for it to report ready
  * (or timeout in startup).  When this routine returns, the requested
  * CPU is either fully running and configured or known to be dead.
Index: mm1-2.6.8-rc3/kernel/fork.c
===================================================================
--- mm1-2.6.8-rc3.orig/kernel/fork.c
+++ mm1-2.6.8-rc3/kernel/fork.c
@@ -864,7 +864,7 @@
  * parts of the process environment (as per the clone
  * flags). The actual kick-off is left to the caller.
  */
-struct task_struct *copy_process(unsigned long clone_flags,
+static task_t *copy_process(unsigned long clone_flags,
 				 unsigned long stack_start,
 				 struct pt_regs *regs,
 				 unsigned long stack_size,
@@ -1141,6 +1141,14 @@
 	goto fork_out;
 }
 
+task_t * __init fork_by_hand(void)
+{
+	struct pt_regs regs;
+
+	memset(&regs, 0, sizeof(struct pt_regs));
+	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
+}
+
 static inline int fork_traceflag (unsigned clone_flags)
 {
 	if (clone_flags & (CLONE_UNTRACED | CLONE_IDLETASK))
Index: mm1-2.6.8-rc3/arch/parisc/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/parisc/kernel/smp.c
+++ mm1-2.6.8-rc3/arch/parisc/kernel/smp.c
@@ -504,24 +504,6 @@
 
 #if 0
 /*
- * Create the idle task for a new Slave CPU.  DO NOT use kernel_thread()
- * because that could end up calling schedule(). If it did, the new idle
- * task could get scheduled before we had a chance to remove it from the
- * run-queue...
- */
-static struct task_struct *fork_by_hand(void)
-{
-	struct pt_regs regs;  
-
-	/*
-	 * don't care about the regs settings since
-	 * we'll never reschedule the forked task.
-	 */
-	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
-}
-
-
-/*
  * Bring one cpu online.
  */
 int __init smp_boot_one_cpu(int cpuid, int cpunum)
Index: mm1-2.6.8-rc3/arch/sh/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/sh/kernel/smp.c
+++ mm1-2.6.8-rc3/arch/sh/kernel/smp.c
@@ -98,10 +98,8 @@
 int __cpu_up(unsigned int cpu)
 {
 	struct task_struct *tsk;
-	struct pt_regs regs;
 
-	memset(&regs, 0, sizeof(struct pt_regs));
-	tsk = copy_process(CLONE_VM | CLONE_IDLETASK, 0, &regs, 0, 0, 0);
+	tsk = fork_by_hand();
 
 	if (IS_ERR(tsk))
 		panic("Failed forking idle task for cpu %d\n", cpu);
