Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVC3C5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVC3C5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 21:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVC3C5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 21:57:24 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:54948 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261723AbVC3CzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 21:55:01 -0500
From: gh@us.ibm.com
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net
Subject: [patch 2/8] CKRM:  Processor Delay Accounting
Content-Disposition: inline; filename=02-diff_delay_acct
X-Evolution: 0000000a-0000
Date: Tue, 29 Mar 2005 18:54:57 -0800
Message-Id: <E1DGTM9-0007ve-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CKRM processor scheduling delay accounting - provides a mechanism
to In addition to counting frequency the total delay in ns is also
recorded. CPU delays are specified as cpu-wait and cpu-run.  I/O delays
are recorded for memory and regular I/O.  Information is accessible
through /proc/<pid>/delay.

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

 fs/proc/array.c            |   18 +++++++++
 fs/proc/base.c             |   18 +++++++++
 include/linux/sched.h      |   86 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/taskdelays.h |   45 +++++++++++++++++++++++
 init/Kconfig               |    8 ++++
 kernel/fork.c              |    1 
 kernel/sched.c             |   17 ++++++++
 mm/memory.c                |    9 +++-
 8 files changed, 200 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc1/fs/proc/array.c
===================================================================
--- linux-2.6.12-rc1.orig/fs/proc/array.c	2005-03-17 17:34:18.000000000 -0800
+++ linux-2.6.12-rc1/fs/proc/array.c	2005-03-18 15:16:20.884475861 -0800
@@ -482,3 +482,21 @@ int proc_pid_statm(struct task_struct *t
 	return sprintf(buffer,"%d %d %d %d %d %d %d\n",
 		       size, resident, shared, text, lib, data, 0);
 }
+
+
+int proc_pid_delay(struct task_struct *task, char * buffer)
+{
+	int res;
+
+	res  = sprintf(buffer,"%u %llu %llu %u %llu %u %llu\n",
+		       (unsigned int) get_delay(task,runs),
+		       (uint64_t) get_delay(task,runcpu_total),
+		       (uint64_t) get_delay(task,waitcpu_total),
+		       (unsigned int) get_delay(task,num_iowaits),
+		       (uint64_t) get_delay(task,iowait_total),
+		       (unsigned int) get_delay(task,num_memwaits),
+		       (uint64_t) get_delay(task,mem_iowait_total)
+		);
+	return res;
+}
+
Index: linux-2.6.12-rc1/fs/proc/base.c
===================================================================
--- linux-2.6.12-rc1.orig/fs/proc/base.c	2005-03-17 17:34:18.000000000 -0800
+++ linux-2.6.12-rc1/fs/proc/base.c	2005-03-18 15:16:20.889475463 -0800
@@ -120,6 +120,10 @@ enum pid_directory_inos {
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TID_LOGINUID,
 #endif
+#ifdef CONFIG_DELAY_ACCT
+        PROC_TID_DELAY_ACCT,
+        PROC_TGID_DELAY_ACCT,
+#endif
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 	PROC_TID_OOM_SCORE,
 	PROC_TID_OOM_ADJUST,
@@ -155,6 +159,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
+#ifdef CONFIG_DELAY_ACCT
+	E(PROC_TGID_DELAY_ACCT,"delay",   S_IFREG|S_IRUGO),
+#endif
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TGID_WCHAN,     "wchan",   S_IFREG|S_IRUGO),
 #endif
@@ -191,6 +198,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_SECURITY
 	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
+#ifdef CONFIG_DELAY_ACCT
+	E(PROC_TGID_DELAY_ACCT,"delay",   S_IFREG|S_IRUGO),
+#endif
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TID_WCHAN,      "wchan",   S_IFREG|S_IRUGO),
 #endif
@@ -1564,6 +1574,13 @@ static struct dentry *proc_pident_lookup
 			ei->op.proc_read = proc_pid_wchan;
 			break;
 #endif
+#ifdef CONFIG_DELAY_ACCT
+		case PROC_TID_DELAY_ACCT:
+		case PROC_TGID_DELAY_ACCT:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_delay;
+			break;
+#endif
 #ifdef CONFIG_SCHEDSTATS
 		case PROC_TID_SCHEDSTAT:
 		case PROC_TGID_SCHEDSTAT:
Index: linux-2.6.12-rc1/fs/proc/internal.h
===================================================================
--- linux-2.6.12-rc1.orig/fs/proc/internal.h	2005-03-17 17:33:50.000000000 -0800
+++ linux-2.6.12-rc1/fs/proc/internal.h	2005-03-18 15:16:20.889475463 -0800
@@ -36,6 +36,7 @@ extern int proc_tid_stat(struct task_str
 extern int proc_tgid_stat(struct task_struct *, char *);
 extern int proc_pid_status(struct task_struct *, char *);
 extern int proc_pid_statm(struct task_struct *, char *);
+extern int proc_pid_delay(struct task_struct *, char*);
 
 static inline struct task_struct *proc_task(struct inode *inode)
 {
Index: linux-2.6.12-rc1/include/linux/sched.h
===================================================================
--- linux-2.6.12-rc1.orig/include/linux/sched.h	2005-03-17 17:33:50.000000000 -0800
+++ linux-2.6.12-rc1/include/linux/sched.h	2005-03-18 15:16:20.891475304 -0800
@@ -34,6 +34,7 @@
 #include <linux/percpu.h>
 #include <linux/topology.h>
 #include <linux/seccomp.h>
+#include <linux/taskdelays.h>
 
 struct exec_domain;
 
@@ -727,6 +728,9 @@ struct task_struct {
 	nodemask_t mems_allowed;
 	int cpuset_mems_generation;
 #endif
+#ifdef CONFIG_DELAY_ACCT
+	struct task_delay_info delays;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
@@ -1024,6 +1028,9 @@ task_t *fork_idle(int);
 extern void set_task_comm(struct task_struct *tsk, char *from);
 extern void get_task_comm(char *to, struct task_struct *tsk);
 
+#define PF_MEMIO	0x00400000      /* I am potentially doing I/O for mem */
+#define PF_IOWAIT	0x00800000      /* I am waiting on disk I/O */
+
 #ifdef CONFIG_SMP
 extern void wait_task_inactive(task_t * p);
 #else
@@ -1258,6 +1265,88 @@ static inline int try_to_freeze(unsigned
 	return 0;
 }
 #endif /* CONFIG_PM */
+
+/* API for registering delay info */
+#ifdef CONFIG_DELAY_ACCT
+
+#define test_delay_flag(tsk,flg)	((tsk)->flags & (flg))
+#define set_delay_flag(tsk,flg)		((tsk)->flags |= (flg))
+#define clear_delay_flag(tsk,flg)	((tsk)->flags &= ~(flg))
+
+#define def_delay_var(var)		unsigned long long var
+#define get_delay(tsk,field)		((tsk)->delays.field)
+
+#define start_delay(var)		((var) = sched_clock())
+#define start_delay_set(var,flg)	(set_delay_flag(current,flg),(var) = \
+							sched_clock())
+
+#define inc_delay(tsk,field)		(((tsk)->delays.field)++)
+
+/* because of hardware timer drifts in SMPs and task continue on different cpu
+ * then where the start_ts was taken there is a possibility that
+ * end_ts < start_ts by some usecs. In this case we ignore the diff
+ * and add nothing to the total.
+ */
+#ifdef CONFIG_SMP
+#define test_ts_integrity(start_ts,end_ts)  (likely((end_ts) > (start_ts)))
+#else
+#define test_ts_integrity(start_ts,end_ts)  (1)
+#endif
+
+#define add_delay_ts(tsk,field,start_ts,end_ts) \
+	do { if (test_ts_integrity(start_ts,end_ts)) (tsk)->delays.field += ((end_ts)-(start_ts)); } while (0)
+
+#define add_delay_clear(tsk,field,start_ts,flg)		\
+	do {						\
+		unsigned long long now = sched_clock();	\
+		add_delay_ts(tsk,field,start_ts,now);	\
+		clear_delay_flag(tsk,flg);		\
+	} while (0)
+
+static inline void add_io_delay(unsigned long long dstart) 
+{
+	struct task_struct * tsk = current;
+	unsigned long long now = sched_clock();
+	unsigned long long val;
+
+	if (test_ts_integrity(dstart,now))
+		val = now - dstart;
+	else
+		val = 0;
+	if (test_delay_flag(tsk,PF_MEMIO)) {
+		tsk->delays.mem_iowait_total += val;
+		tsk->delays.num_memwaits++;
+	} else {
+		tsk->delays.iowait_total += val;
+		tsk->delays.num_iowaits++;
+	}
+	clear_delay_flag(tsk,PF_IOWAIT);
+}
+
+inline static void init_delays(struct task_struct *tsk)
+{
+	memset((void*)&tsk->delays,0,sizeof(tsk->delays));
+}
+
+#else
+
+#define test_delay_flag(tsk,flg)                (0)
+#define set_delay_flag(tsk,flg)                 do { } while (0)
+#define clear_delay_flag(tsk,flg)               do { } while (0)
+
+#define def_delay_var(var)			      
+#define get_delay(tsk,field)                    (0)
+
+#define start_delay(var)                        do { } while (0)
+#define start_delay_set(var,flg)                do { } while (0)
+
+#define inc_delay(tsk,field)                    do { } while (0)
+#define add_delay_ts(tsk,field,start_ts,now)    do { } while (0)
+#define add_delay_clear(tsk,field,start_ts,flg) do { } while (0)
+#define add_io_delay(dstart)			do { } while (0) 
+#define init_delays(tsk)                        do { } while (0)
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif
Index: linux-2.6.12-rc1/include/linux/taskdelays.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-rc1/include/linux/taskdelays.h	2005-03-18 15:16:20.891475304 -0800
@@ -0,0 +1,35 @@
+/* taskdelays.h - for delay accounting
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003, 2004
+ * 
+ * Has the data structure for delay counting.
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#ifndef _LINUX_TASKDELAYS_H
+#define _LINUX_TASKDELAYS_H
+
+#include <linux/config.h>
+#include <linux/types.h>
+
+struct task_delay_info {
+	/* delay statistics in usecs */
+	uint64_t waitcpu_total;
+	uint64_t runcpu_total;
+	uint64_t iowait_total;
+	uint64_t mem_iowait_total;
+	uint32_t runs;
+	uint32_t num_iowaits;
+	uint32_t num_memwaits;
+};
+
+#endif /* _LINUX_TASKDELAYS_H */
Index: linux-2.6.12-rc1/init/Kconfig
===================================================================
--- linux-2.6.12-rc1.orig/init/Kconfig	2005-03-18 15:16:16.982786187 -0800
+++ linux-2.6.12-rc1/init/Kconfig	2005-03-18 15:16:20.892475224 -0800
@@ -253,6 +253,14 @@ menuconfig EMBEDDED
           environments which can tolerate a "non-standard" kernel.
           Only use this if you really know what you are doing.
 
+config DELAY_ACCT
+	bool "Enable delay accounting (EXPERIMENTAL)"
+	help
+	  In addition to counting frequency the total delay in ns is also
+	  recorded. CPU delays are specified as cpu-wait and cpu-run. 
+	  I/O delays are recorded for memory and regular I/O.
+	  Information is accessible through /proc/<pid>/delay.
+
 config KALLSYMS
 	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
 	 default y
Index: linux-2.6.12-rc1/kernel/fork.c
===================================================================
--- linux-2.6.12-rc1.orig/kernel/fork.c	2005-03-18 15:16:16.985785948 -0800
+++ linux-2.6.12-rc1/kernel/fork.c	2005-03-18 15:16:20.893475145 -0800
@@ -901,6 +901,7 @@ static task_t *copy_process(unsigned lon
 	if (p->binfmt && !try_module_get(p->binfmt->module))
 		goto bad_fork_cleanup_put_domain;
 
+	init_delays(p);
 	p->did_exec = 0;
 	copy_flags(clone_flags, p);
 	p->pid = pid;
Index: linux-2.6.12-rc1/kernel/sched.c
===================================================================
--- linux-2.6.12-rc1.orig/kernel/sched.c	2005-03-17 17:34:27.000000000 -0800
+++ linux-2.6.12-rc1/kernel/sched.c	2005-03-18 15:16:20.896474906 -0800
@@ -268,6 +268,8 @@ static DEFINE_PER_CPU(struct runqueue, r
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 
+#define task_is_running(p)	(this_rq() == task_rq(p))
+
 /*
  * Default context-switch locking:
  */
@@ -2749,6 +2751,7 @@ switch_tasks:
 
 	update_cpu_clock(prev, rq, now);
 
+	add_delay_ts(prev, runcpu_total, prev->timestamp, now);
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0)
 		prev->sleep_avg = 0;
@@ -2756,6 +2759,8 @@ switch_tasks:
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
+		add_delay_ts(next, waitcpu_total, next->timestamp, now);
+		inc_delay(next, runs);
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
@@ -3802,9 +3807,12 @@ void __sched io_schedule(void)
 {
 	struct runqueue *rq = &per_cpu(runqueues, _smp_processor_id());
 
+	def_delay_var(dstart);
+	start_delay_set(dstart, PF_IOWAIT);
 	atomic_inc(&rq->nr_iowait);
 	schedule();
 	atomic_dec(&rq->nr_iowait);
+	add_io_delay(dstart);
 }
 
 EXPORT_SYMBOL(io_schedule);
@@ -3813,10 +3821,13 @@ long __sched io_schedule_timeout(long ti
 {
 	struct runqueue *rq = &per_cpu(runqueues, _smp_processor_id());
 	long ret;
+	def_delay_var(dstart);
 
+	start_delay_set(dstart,PF_IOWAIT);
 	atomic_inc(&rq->nr_iowait);
 	ret = schedule_timeout(timeout);
 	atomic_dec(&rq->nr_iowait);
+	add_io_delay(dstart);
 	return ret;
 }
 
@@ -5005,3 +5016,12 @@ void normalize_rt_tasks(void)
 }
 
 #endif /* CONFIG_MAGIC_SYSRQ */
+
+#ifdef CONFIG_DELAY_ACCT
+int task_running_sys(struct task_struct *p)
+{
+	return task_is_running(p);
+}
+EXPORT_SYMBOL_GPL(task_running_sys);
+#endif
+
Index: linux-2.6.12-rc1/mm/memory.c
===================================================================
--- linux-2.6.12-rc1.orig/mm/memory.c	2005-03-17 17:34:10.000000000 -0800
+++ linux-2.6.12-rc1/mm/memory.c	2005-03-18 15:16:20.897474827 -0800
@@ -1939,6 +1939,7 @@ int handle_mm_fault(struct mm_struct *mm
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	int rc;
 
 	__set_current_state(TASK_RUNNING);
 
@@ -1952,6 +1953,9 @@ int handle_mm_fault(struct mm_struct *mm
 	 * and the SMP-safe atomic PTE updates.
 	 */
 	pgd = pgd_offset(mm, address);
+
+	set_delay_flag(current, PF_MEMIO);
+
 	spin_lock(&mm->page_table_lock);
 
 	pud = pud_alloc(mm, pgd, address);
@@ -1966,10 +1970,13 @@ int handle_mm_fault(struct mm_struct *mm
 	if (!pte)
 		goto oom;
 	
-	return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+	rc = handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+	clear_delay_flag(current, PF_MEMIO);
+	return rc;
 
  oom:
 	spin_unlock(&mm->page_table_lock);
+	clear_delay_flag(current, PF_MEMIO);
 	return VM_FAULT_OOM;
 }
 

--
