Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUGBLEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUGBLEE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 07:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUGBLED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 07:04:03 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:10707 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262547AbUGBKyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 06:54:37 -0400
Date: Fri, 2 Jul 2004 03:53:36 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Jack Steiner <steiner@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>, Sylvain <sylvain.jeaugey@bull.net>,
       Dan Higgins <djh@sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Simon <Simon.Derr@bull.net>, Dimitri Sivanich <sivanich@sgi.com>
Message-Id: <20040702105339.15684.37230.77121@sam.engr.sgi.com>
In-Reply-To: <20040702105147.15684.22242.27912@sam.engr.sgi.com>
References: <20040702105147.15684.22242.27912@sam.engr.sgi.com>
Subject: [patch 7/8] cpusets v4 - The few, small kernel hooks needed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpuset kernel hooks in init, exit, fork, sched_setaffinity,
Kconfig and sched.h.

These hooks establish and propogate cpusets, and enforce
their CPU placement limitations on sched_setaffinity, and
Memory Node placement limitations on mbind, sys_set_mempolicy.

Index: 2.6.7-mm5/include/linux/sched.h
===================================================================
--- 2.6.7-mm5.orig/include/linux/sched.h	2004-07-01 19:30:10.000000000 -0700
+++ 2.6.7-mm5/include/linux/sched.h	2004-07-01 19:30:22.000000000 -0700
@@ -366,6 +366,7 @@ struct k_itimer {
 
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
+struct cpuset;
 
 #define NGROUPS_SMALL		32
 #define NGROUPS_PER_BLOCK	((int)(PAGE_SIZE / sizeof(gid_t)))
@@ -535,6 +536,10 @@ struct task_struct {
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */
 #endif
+
+#ifdef CONFIG_CPUSETS
+	struct cpuset *cpuset;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: 2.6.7-mm5/init/Kconfig
===================================================================
--- 2.6.7-mm5.orig/init/Kconfig	2004-07-01 19:30:10.000000000 -0700
+++ 2.6.7-mm5/init/Kconfig	2004-07-01 19:30:22.000000000 -0700
@@ -279,6 +279,16 @@ config EPOLL
 	  Disabling this option will cause the kernel to be built without
 	  support for epoll family of system calls.
 
+config CPUSETS
+	bool "Cpuset support"
+	help
+	  This options will let you create and manage CPUSET's which
+	  allow dynamically partitioning a system into sets of CPUs and
+	  Memory Nodes and assigning tasks to run only within those sets.
+	  This is primarily useful on large SMP or NUMA systems.
+
+	  Say N if unsure.
+
 source "drivers/block/Kconfig.iosched"
 
 config CC_OPTIMIZE_FOR_SIZE
Index: 2.6.7-mm5/init/main.c
===================================================================
--- 2.6.7-mm5.orig/init/main.c	2004-07-01 19:30:10.000000000 -0700
+++ 2.6.7-mm5/init/main.c	2004-07-01 19:30:22.000000000 -0700
@@ -41,6 +41,7 @@
 #include <linux/writeback.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
+#include <linux/cpuset.h>
 #include <linux/unistd.h>
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
@@ -536,6 +537,8 @@ asmlinkage void __init start_kernel(void
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
 #endif
+	cpuset_init();
+
 	check_bugs();
 
 	/* Do the rest non-__init'ed, we're now alive */
Index: 2.6.7-mm5/kernel/exit.c
===================================================================
--- 2.6.7-mm5.orig/kernel/exit.c	2004-07-01 19:30:10.000000000 -0700
+++ 2.6.7-mm5/kernel/exit.c	2004-07-01 19:30:22.000000000 -0700
@@ -28,6 +28,7 @@
 #include <asm/unistd.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
+#include <linux/cpuset.h>
 
 extern void sem_exit (void);
 extern struct task_struct *child_reaper;
@@ -807,6 +808,7 @@ asmlinkage NORET_TYPE void do_exit(long 
 	__exit_fs(tsk);
 	exit_namespace(tsk);
 	exit_thread();
+	cpuset_exit(tsk);
 #ifdef CONFIG_NUMA
 	mpol_free(tsk->mempolicy);
 #endif
Index: 2.6.7-mm5/kernel/fork.c
===================================================================
--- 2.6.7-mm5.orig/kernel/fork.c	2004-07-01 19:30:10.000000000 -0700
+++ 2.6.7-mm5/kernel/fork.c	2004-07-01 19:30:22.000000000 -0700
@@ -36,6 +36,7 @@
 #include <linux/mount.h>
 #include <linux/audit.h>
 #include <linux/rmap.h>
+#include <linux/cpuset.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1093,6 +1094,8 @@ struct task_struct *copy_process(unsigne
 	if (p->ptrace & PT_PTRACED)
 		__ptrace_link(p, current->parent);
 
+	cpuset_fork(p);
+
 	attach_pid(p, PIDTYPE_PID, p->pid);
 	if (thread_group_leader(p)) {
 		attach_pid(p, PIDTYPE_TGID, p->tgid);
Index: 2.6.7-mm5/kernel/sched.c
===================================================================
--- 2.6.7-mm5.orig/kernel/sched.c	2004-07-01 19:30:10.000000000 -0700
+++ 2.6.7-mm5/kernel/sched.c	2004-07-01 19:30:22.000000000 -0700
@@ -41,6 +41,7 @@
 #include <linux/percpu.h>
 #include <linux/perfctr.h>
 #include <linux/kthread.h>
+#include <linux/cpuset.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -2886,7 +2887,7 @@ out_unlock:
 asmlinkage long sys_sched_setaffinity(pid_t pid, unsigned int len,
 				      unsigned long __user *user_mask_ptr)
 {
-	cpumask_t new_mask;
+	cpumask_t new_mask, cpus_allowed;
 	int retval;
 	task_t *p;
 
@@ -2919,6 +2920,8 @@ asmlinkage long sys_sched_setaffinity(pi
 			!capable(CAP_SYS_NICE))
 		goto out_unlock;
 
+	cpus_allowed = cpuset_cpus_allowed(p);
+	cpus_and(new_mask, new_mask, cpus_allowed);
 	retval = set_cpus_allowed(p, new_mask);
 
 out_unlock:
@@ -3498,7 +3501,9 @@ static void migrate_all_tasks(int src_cp
 		if (dest_cpu == NR_CPUS)
 			dest_cpu = any_online_cpu(tsk->cpus_allowed);
 		if (dest_cpu == NR_CPUS) {
-			cpus_setall(tsk->cpus_allowed);
+			tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
+			if (!cpus_intersects(tsk->cpus_allowed, cpu_online_map))
+				cpus_setall(tsk->cpus_allowed);
 			dest_cpu = any_online_cpu(tsk->cpus_allowed);
 
 			/* Don't tell them about moving exiting tasks
Index: 2.6.7-mm5/mm/mempolicy.c
===================================================================
--- 2.6.7-mm5.orig/mm/mempolicy.c	2004-07-01 19:30:18.000000000 -0700
+++ 2.6.7-mm5/mm/mempolicy.c	2004-07-01 19:30:22.000000000 -0700
@@ -67,6 +67,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/nodemask.h>
+#include <linux/cpuset.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -132,6 +133,7 @@ static int get_nodes(unsigned long *node
 	unsigned long k;
 	unsigned long nlongs;
 	unsigned long endmask;
+	nodemask_t mems_allowed;
 
 	--maxnode;
 	bitmap_zero(nodes, MAX_NUMNODES);
@@ -164,6 +166,9 @@ static int get_nodes(unsigned long *node
 	if (copy_from_user(nodes, nmask, nlongs*sizeof(unsigned long)))
 		return -EFAULT;
 	nodes[nlongs-1] &= endmask;
+	/* Ignore nodes not allowed in current cpuset */
+	mems_allowed = cpuset_mems_allowed(current);
+	bitmap_and(nodes, nodes, nodes_addr(mems_allowed), MAX_NUMNODES);
 	return mpol_check_policy(mode, nodes);
 }
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
