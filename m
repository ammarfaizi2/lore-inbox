Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSGPHGw>; Tue, 16 Jul 2002 03:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317773AbSGPHGv>; Tue, 16 Jul 2002 03:06:51 -0400
Received: from holomorphy.com ([66.224.33.161]:34689 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317772AbSGPHGs>;
	Tue, 16 Jul 2002 03:06:48 -0400
Date: Tue, 16 Jul 2002 00:09:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] shrink task_struct by removing per_cpu utime and stime
Message-ID: <20020716070943.GL1022@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These statistics severely bloat the task_struct and nothing in
userspace can rely on them as they're conditional on CONFIG_SMP. If
anyone is using them (or just wants them around), please speak up.


Cheers,
Bill


===== fs/proc/array.c 1.24 vs edited =====
--- 1.24/fs/proc/array.c	Thu Jul  4 22:54:38 2002
+++ edited/fs/proc/array.c	Tue Jul 16 00:35:26 2002
@@ -685,25 +685,3 @@
 out:
 	return retval;
 }
-
-#ifdef CONFIG_SMP
-int proc_pid_cpu(struct task_struct *task, char * buffer)
-{
-	int i, len;
-
-	len = sprintf(buffer,
-		"cpu  %lu %lu\n",
-		jiffies_to_clock_t(task->utime),
-		jiffies_to_clock_t(task->stime));
-		
-	for (i = 0 ; i < NR_CPUS; i++) {
-		if (cpu_online(i))
-		len += sprintf(buffer + len, "cpu%d %lu %lu\n",
-			i,
-			jiffies_to_clock_t(task->per_cpu_utime[i]),
-			jiffies_to_clock_t(task->per_cpu_stime[i]));
-
-	}
-	return len;
-}
-#endif
===== fs/proc/base.c 1.26 vs edited =====
--- 1.26/fs/proc/base.c	Wed May 22 08:48:14 2002
+++ edited/fs/proc/base.c	Tue Jul 16 00:36:12 2002
@@ -52,7 +52,6 @@
 	PROC_PID_STAT,
 	PROC_PID_STATM,
 	PROC_PID_MAPS,
-	PROC_PID_CPU,
 	PROC_PID_MOUNTS,
 	PROC_PID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
@@ -72,9 +71,6 @@
   E(PROC_PID_CMDLINE,	"cmdline",	S_IFREG|S_IRUGO),
   E(PROC_PID_STAT,	"stat",		S_IFREG|S_IRUGO),
   E(PROC_PID_STATM,	"statm",	S_IFREG|S_IRUGO),
-#ifdef CONFIG_SMP
-  E(PROC_PID_CPU,	"cpu",		S_IFREG|S_IRUGO),
-#endif
   E(PROC_PID_MAPS,	"maps",		S_IFREG|S_IRUGO),
   E(PROC_PID_MEM,	"mem",		S_IFREG|S_IRUSR|S_IWUSR),
   E(PROC_PID_CWD,	"cwd",		S_IFLNK|S_IRWXUGO),
@@ -1010,12 +1006,7 @@
 		case PROC_PID_MAPS:
 			inode->i_fop = &proc_maps_operations;
 			break;
-#ifdef CONFIG_SMP
-		case PROC_PID_CPU:
-			inode->i_fop = &proc_info_file_operations;
-			ei->op.proc_read = proc_pid_cpu;
-			break;
-#endif
+
 		case PROC_PID_MEM:
 			inode->i_op = &proc_mem_inode_operations;
 			inode->i_fop = &proc_mem_operations;
===== include/linux/sched.h 1.70 vs edited =====
--- 1.70/include/linux/sched.h	Thu Jul  4 22:33:26 2002
+++ edited/include/linux/sched.h	Tue Jul 16 00:35:26 2002
@@ -311,7 +311,6 @@
 	struct timer_list real_timer;
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long start_time;
-	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
 	int swappable:1;
===== kernel/fork.c 1.49 vs edited =====
--- 1.49/kernel/fork.c	Mon Jul  1 14:41:36 2002
+++ edited/kernel/fork.c	Tue Jul 16 00:35:26 2002
@@ -688,16 +688,7 @@
 	p->tty_old_pgrp = 0;
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
-#ifdef CONFIG_SMP
-	{
-		int i;
-
-		/* ?? should we just memset this ?? */
-		for(i = 0; i < NR_CPUS; i++)
-			p->per_cpu_utime[i] = p->per_cpu_stime[i] = 0;
-		spin_lock_init(&p->sigmask_lock);
-	}
-#endif
+	spin_lock_init(&p->sigmask_lock);
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = jiffies;
===== kernel/timer.c 1.17 vs edited =====
--- 1.17/kernel/timer.c	Mon Jul  1 14:41:36 2002
+++ edited/kernel/timer.c	Tue Jul 16 00:35:26 2002
@@ -569,8 +569,6 @@
 void update_one_process(struct task_struct *p, unsigned long user,
 			unsigned long system, int cpu)
 {
-	p->per_cpu_utime[cpu] += user;
-	p->per_cpu_stime[cpu] += system;
 	do_process_times(p, user, system);
 	do_it_virt(p, user);
 	do_it_prof(p);
