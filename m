Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbUK2TFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbUK2TFY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUK2TFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:05:24 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:59026 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261536AbUK2Sy7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:54:59 -0500
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Rik van Riel <riel@redhat.com>,
       Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: [PATCH] CKRM: 2/10 CKRM:  Accurate delay accounting
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19665.1101754013.1@us.ibm.com>
Date: Mon, 29 Nov 2004 10:46:53 -0800
Message-Id: <E1CYqY1-00057E-00@w-gerrit.beaverton.ibm.com>
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

Index: linux-2.6.10-rc2/fs/proc/array.c
===================================================================
--- linux-2.6.10-rc2.orig/fs/proc/array.c	2004-11-14 17:27:52.000000000 -0800
+++ linux-2.6.10-rc2/fs/proc/array.c	2004-11-19 20:41:45.550901897 -0800
@@ -470,3 +470,21 @@
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
Index: linux-2.6.10-rc2/fs/proc/base.c
===================================================================
--- linux-2.6.10-rc2.orig/fs/proc/base.c	2004-11-14 17:27:53.000000000 -0800
+++ linux-2.6.10-rc2/fs/proc/base.c	2004-11-19 20:41:45.557900788 -0800
@@ -96,6 +96,10 @@
 	PROC_TID_ATTR_EXEC,
 	PROC_TID_ATTR_FSCREATE,
 #endif
+#ifdef CONFIG_DELAY_ACCT
+        PROC_TID_DELAY_ACCT,
+        PROC_TGID_DELAY_ACCT,
+#endif
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
 
@@ -126,6 +130,9 @@
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
+#ifdef CONFIG_DELAY_ACCT
+	E(PROC_TGID_DELAY_ACCT,"delay",   S_IFREG|S_IRUGO),
+#endif
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TGID_WCHAN,     "wchan",   S_IFREG|S_IRUGO),
 #endif
@@ -151,6 +158,9 @@
 #ifdef CONFIG_SECURITY
 	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
+#ifdef CONFIG_DELAY_ACCT
+	E(PROC_TGID_DELAY_ACCT,"delay",   S_IFREG|S_IRUGO),
+#endif
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TID_WCHAN,      "wchan",   S_IFREG|S_IRUGO),
 #endif
@@ -193,6 +203,7 @@
 int proc_tgid_stat(struct task_struct*,char*);
 int proc_pid_status(struct task_struct*,char*);
 int proc_pid_statm(struct task_struct*,char*);
+int proc_pid_delay(struct task_struct*,char*);
 
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
@@ -1375,6 +1386,13 @@
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
Index: linux-2.6.10-rc2/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc2.orig/include/linux/sched.h	2004-11-14 17:26:43.000000000 -0800
+++ linux-2.6.10-rc2/include/linux/sched.h	2004-11-19 20:41:45.564899680 -0800
@@ -664,6 +664,9 @@
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */
 #endif
+#ifdef CONFIG_DELAY_ACCT
+	struct task_delay_info delays;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
@@ -912,6 +915,9 @@
 extern void set_task_comm(struct task_struct *tsk, char *from);
 extern void get_task_comm(char *to, struct task_struct *tsk);
 
+#define PF_MEMIO   	0x00400000      /* I am  potentially doing I/O for mem */
+#define PF_IOWAIT       0x00800000      /* I am waiting on disk I/O */
+
 #ifdef CONFIG_SMP
 extern void wait_task_inactive(task_t * p);
 #else
@@ -1111,6 +1117,86 @@
 
 #endif
 
+/* API for registering delay info */
+#ifdef CONFIG_DELAY_ACCT
+
+#define test_delay_flag(tsk,flg)                ((tsk)->flags & (flg))
+#define set_delay_flag(tsk,flg)                 ((tsk)->flags |= (flg))
+#define clear_delay_flag(tsk,flg)               ((tsk)->flags &= ~(flg))
+
+#define def_delay_var(var)		        unsigned long long var
+#define get_delay(tsk,field)                    ((tsk)->delays.field)
+
+#define start_delay(var)                        ((var) = sched_clock())
+#define start_delay_set(var,flg)                (set_delay_flag(current,flg),(var) = sched_clock())
+
+#define inc_delay(tsk,field) (((tsk)->delays.field)++)
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
+#define add_delay_clear(tsk,field,start_ts,flg)        \
+	do {                                           \
+		unsigned long long now = sched_clock();\
+           	add_delay_ts(tsk,field,start_ts,now);  \
+           	clear_delay_flag(tsk,flg);             \
+        } while (0)
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
Index: linux-2.6.10-rc2/include/linux/taskdelays.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/include/linux/taskdelays.h	2004-11-19 20:41:45.568899046 -0800
@@ -0,0 +1,45 @@
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
+ * 
+ *
+ */
+
+/* Changes
+ *
+ * 24 Aug 2003
+ *    Created.
+ */
+
+#ifndef _LINUX_TASKDELAYS_H
+#define _LINUX_TASKDELAYS_H
+
+#include <linux/config.h>
+#include <linux/types.h>
+
+struct task_delay_info {
+#if defined CONFIG_DELAY_ACCT 
+	/* delay statistics in usecs */
+	uint64_t waitcpu_total;
+	uint64_t runcpu_total;
+	uint64_t iowait_total;
+	uint64_t mem_iowait_total;
+	uint32_t runs;
+	uint32_t num_iowaits;
+	uint32_t num_memwaits;
+#endif				
+};
+
+#endif				// _LINUX_TASKDELAYS_H
Index: linux-2.6.10-rc2/init/Kconfig
===================================================================
--- linux-2.6.10-rc2.orig/init/Kconfig	2004-11-19 20:40:52.521303189 -0800
+++ linux-2.6.10-rc2/init/Kconfig	2004-11-19 20:41:45.572898412 -0800
@@ -273,6 +273,14 @@
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
Index: linux-2.6.10-rc2/kernel/fork.c
===================================================================
--- linux-2.6.10-rc2.orig/kernel/fork.c	2004-11-19 20:40:52.540300179 -0800
+++ linux-2.6.10-rc2/kernel/fork.c	2004-11-19 20:41:45.578897462 -0800
@@ -849,6 +849,7 @@
 	if (p->binfmt && !try_module_get(p->binfmt->module))
 		goto bad_fork_cleanup_put_domain;
 
+	init_delays(p);
 	p->did_exec = 0;
 	copy_flags(clone_flags, p);
 	p->pid = pid;
Index: linux-2.6.10-rc2/kernel/sched.c
===================================================================
--- linux-2.6.10-rc2.orig/kernel/sched.c	2004-11-14 17:28:18.000000000 -0800
+++ linux-2.6.10-rc2/kernel/sched.c	2004-11-19 20:43:27.495751135 -0800
@@ -289,6 +289,8 @@
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 
+#define task_is_running(p)	(this_rq() == task_rq(p))
+
 /*
  * Default context-switch locking:
  */
@@ -2652,6 +2654,7 @@
 	clear_tsk_need_resched(prev);
 	rcu_qsctr_inc(task_cpu(prev));
 
+	add_delay_ts(prev, runcpu_total, prev->timestamp, now);
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0) {
 		prev->sleep_avg = 0;
@@ -2662,6 +2665,8 @@
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
+		add_delay_ts(next, waitcpu_total, next->timestamp, now);
+		inc_delay(next, runs);
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
@@ -3467,9 +3472,12 @@
 {
 	struct runqueue *rq = this_rq();
 
+	def_delay_var(dstart);
+	start_delay_set(dstart, PF_IOWAIT);
 	atomic_inc(&rq->nr_iowait);
 	schedule();
 	atomic_dec(&rq->nr_iowait);
+	add_io_delay(dstart);
 }
 
 EXPORT_SYMBOL(io_schedule);
@@ -3478,10 +3486,13 @@
 {
 	struct runqueue *rq = this_rq();
 	long ret;
+	def_delay_var(dstart);
 
+	start_delay_set(dstart,PF_IOWAIT);
 	atomic_inc(&rq->nr_iowait);
 	ret = schedule_timeout(timeout);
 	atomic_dec(&rq->nr_iowait);
+	add_io_delay(dstart);
 	return ret;
 }
 
@@ -4636,3 +4647,12 @@
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
Index: linux-2.6.10-rc2/mm/memory.c
===================================================================
--- linux-2.6.10-rc2.orig/mm/memory.c	2004-11-14 17:27:26.000000000 -0800
+++ linux-2.6.10-rc2/mm/memory.c	2004-11-19 20:41:45.602893660 -0800
@@ -1714,15 +1714,20 @@
 	 * We need the page table lock to synchronize with kswapd
 	 * and the SMP-safe atomic PTE updates.
 	 */
+	set_delay_flag(current,PF_MEMIO);
 	spin_lock(&mm->page_table_lock);
 	pmd = pmd_alloc(mm, pgd, address);
 
 	if (pmd) {
 		pte_t * pte = pte_alloc_map(mm, pmd, address);
-		if (pte)
-			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+		if (pte) {
+			int rc = handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+			clear_delay_flag(current,PF_MEMIO);
+			return rc;
+		}
 	}
 	spin_unlock(&mm->page_table_lock);
+	clear_delay_flag(current,PF_MEMIO);
 	return VM_FAULT_OOM;
 }
 
