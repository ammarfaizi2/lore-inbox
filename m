Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVBXKJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVBXKJS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 05:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVBXKIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 05:08:30 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:52707 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262147AbVBXJeK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:34:10 -0500
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ckrm-tech@lists.sourceforge.net
Subject: [PATCH] CKRM [2/8] More accurate account for CPU & IO scheduling
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26653.1109237648.1@us.ibm.com>
Date: Thu, 24 Feb 2005 01:34:08 -0800
Message-Id: <E1D4FNo-0006vw-00@w-gerrit.beaverton.ibm.com>
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

Index: linux-2.6.11-rc5/fs/proc/array.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/proc/array.c	2005-02-23 20:03:03.000000000 -0800
+++ linux-2.6.11-rc5/fs/proc/array.c	2005-02-24 00:54:56.449085584 -0800
@@ -473,3 +473,21 @@
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
Index: linux-2.6.11-rc5/fs/proc/base.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/proc/base.c	2005-02-23 20:03:04.000000000 -0800
+++ linux-2.6.11-rc5/fs/proc/base.c	2005-02-24 00:54:56.451085343 -0800
@@ -105,6 +105,10 @@
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
@@ -137,6 +141,9 @@
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
+#ifdef CONFIG_DELAY_ACCT
+	E(PROC_TGID_DELAY_ACCT,"delay",   S_IFREG|S_IRUGO),
+#endif
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TGID_WCHAN,     "wchan",   S_IFREG|S_IRUGO),
 #endif
@@ -167,6 +174,9 @@
 #ifdef CONFIG_SECURITY
 	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
+#ifdef CONFIG_DELAY_ACCT
+	E(PROC_TGID_DELAY_ACCT,"delay",   S_IFREG|S_IRUGO),
+#endif
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TID_WCHAN,      "wchan",   S_IFREG|S_IRUGO),
 #endif
@@ -1476,6 +1486,13 @@
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
Index: linux-2.6.11-rc5/include/linux/sched.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/sched.h	2005-02-23 20:02:21.000000000 -0800
+++ linux-2.6.11-rc5/include/linux/sched.h	2005-02-24 00:54:56.482081606 -0800
@@ -32,6 +32,7 @@
 #include <linux/pid.h>
 #include <linux/percpu.h>
 #include <linux/topology.h>
+#include <linux/taskdelays.h>
 
 struct exec_domain;
 
@@ -685,6 +686,9 @@
   	struct mempolicy *mempolicy;
 	short il_next;
 #endif
+#ifdef CONFIG_DELAY_ACCT
+	struct task_delay_info delays;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
@@ -980,6 +984,9 @@
 extern void set_task_comm(struct task_struct *tsk, char *from);
 extern void get_task_comm(char *to, struct task_struct *tsk);
 
+#define PF_MEMIO	0x00400000      /* I am potentially doing I/O for mem */
+#define PF_IOWAIT	0x00800000      /* I am waiting on disk I/O */
+
 #ifdef CONFIG_SMP
 extern void wait_task_inactive(task_t * p);
 #else
@@ -1214,6 +1221,88 @@
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
Index: linux-2.6.11-rc5/include/linux/taskdelays.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11-rc5/include/linux/taskdelays.h	2005-02-24 00:54:56.483081485 -0800
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
Index: linux-2.6.11-rc5/init/Kconfig
===================================================================
--- linux-2.6.11-rc5.orig/init/Kconfig	2005-02-24 00:54:50.538798203 -0800
+++ linux-2.6.11-rc5/init/Kconfig	2005-02-24 00:54:56.554072926 -0800
@@ -262,6 +262,14 @@
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
Index: linux-2.6.11-rc5/kernel/fork.c
===================================================================
--- linux-2.6.11-rc5.orig/kernel/fork.c	2005-02-24 00:54:50.647785063 -0800
+++ linux-2.6.11-rc5/kernel/fork.c	2005-02-24 00:54:56.555072805 -0800
@@ -849,6 +849,7 @@
 	if (p->binfmt && !try_module_get(p->binfmt->module))
 		goto bad_fork_cleanup_put_domain;
 
+	init_delays(p);
 	p->did_exec = 0;
 	copy_flags(clone_flags, p);
 	p->pid = pid;
Index: linux-2.6.11-rc5/kernel/sched.c
===================================================================
--- linux-2.6.11-rc5.orig/kernel/sched.c	2005-02-23 20:03:10.000000000 -0800
+++ linux-2.6.11-rc5/kernel/sched.c	2005-02-24 00:54:56.572070756 -0800
@@ -288,6 +288,8 @@
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 
+#define task_is_running(p)	(this_rq() == task_rq(p))
+
 /*
  * Default context-switch locking:
  */
@@ -2799,6 +2801,7 @@
 	clear_tsk_need_resched(prev);
 	rcu_qsctr_inc(task_cpu(prev));
 
+	add_delay_ts(prev, runcpu_total, prev->timestamp, now);
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0)
 		prev->sleep_avg = 0;
@@ -2806,6 +2809,8 @@
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
+		add_delay_ts(next, waitcpu_total, next->timestamp, now);
+		inc_delay(next, runs);
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
@@ -3849,9 +3854,12 @@
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
@@ -3860,10 +3868,13 @@
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
 
@@ -5051,3 +5062,12 @@
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
Index: linux-2.6.11-rc5/mm/memory.c
===================================================================
--- linux-2.6.11-rc5.orig/mm/memory.c	2005-02-23 20:02:38.000000000 -0800
+++ linux-2.6.11-rc5/mm/memory.c	2005-02-24 00:54:56.589068706 -0800
@@ -2065,6 +2065,7 @@
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	int rc;
 
 	__set_current_state(TASK_RUNNING);
 
@@ -2078,6 +2079,9 @@
 	 * and the SMP-safe atomic PTE updates.
 	 */
 	pgd = pgd_offset(mm, address);
+
+	set_delay_flag(current, PF_MEMIO);
+
 	spin_lock(&mm->page_table_lock);
 
 	pud = pud_alloc(mm, pgd, address);
@@ -2092,10 +2096,13 @@
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
 
Index: linux-2.6.11-rc5/fs/proc/internal.h
===================================================================
--- linux-2.6.11-rc5.orig/fs/proc/internal.h	2005-02-23 20:02:21.000000000 -0800
+++ linux-2.6.11-rc5/fs/proc/internal.h	2005-02-24 00:54:56.590068586 -0800
@@ -36,6 +36,7 @@
 extern int proc_tgid_stat(struct task_struct *, char *);
 extern int proc_pid_status(struct task_struct *, char *);
 extern int proc_pid_statm(struct task_struct *, char *);
+extern int proc_pid_delay(struct task_struct *, char*);
 
 static inline struct task_struct *proc_task(struct inode *inode)
 {
