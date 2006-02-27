Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWB0ISq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWB0ISq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWB0ISp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:18:45 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:57069 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932189AbWB0ISp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:18:45 -0500
Subject: [Patch 4/7] Add sysctl for delay accounting
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <1141026996.5785.38.camel@elinux04.optonline.net>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1141028322.5785.60.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 27 Feb 2006 03:18:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-sysctl.patch

Adds a sysctl to turn delay accounting on/off dynamically. 
(defaults to off). When turning off, struct task_delay_info
associated with each task need to be cleared. When turning
on, tasks without struct task_delay_info need to be allocated
one. 

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
Signed-off-by: Balbir Singh <balbir@in.ibm.com>
Signed-off-by: Srivatsa Vaddagiri <vatsa@in.ibm.com>

 include/linux/delayacct.h |   12 +++-
 include/linux/sysctl.h    |    1 
 kernel/delayacct.c        |  128 ++++++++++++++++++++++++++++++++++++++++++++--
 kernel/fork.c             |    3 -
 kernel/sysctl.c           |   11 +++
 5 files changed, 147 insertions(+), 8 deletions(-)

Index: linux-2.6.16-rc4/include/linux/delayacct.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/delayacct.h	2006-02-27 01:52:54.000000000 -0500
+++ linux-2.6.16-rc4/include/linux/delayacct.h	2006-02-27 01:52:56.000000000 -0500
@@ -15,18 +15,24 @@
 #define _LINUX_TASKDELAYS_H
 
 #include <linux/sched.h>
+#include <linux/sysctl.h>
 
 #ifdef CONFIG_TASK_DELAY_ACCT
 extern int delayacct_on;	/* Delay accounting turned on/off */
 extern kmem_cache_t *delayacct_cache;
+int delayacct_sysctl_handler(ctl_table *table, int write, struct file *filp,
+			     void __user *buffer, size_t *lenp, loff_t *ppos);
 extern int delayacct_init(void);
 extern void __delayacct_tsk_init(struct task_struct *);
 extern void __delayacct_tsk_exit(struct task_struct *);
 
-static inline void delayacct_tsk_init(struct task_struct *tsk)
+static inline void delayacct_tsk_early_init(struct task_struct *tsk)
 {
-	/* reinitialize in case parent's non-null pointer was dup'ed*/
 	tsk->delays = NULL;
+}
+
+static inline void delayacct_tsk_init(struct task_struct *tsk)
+{
 	if (unlikely(delayacct_on))
 		__delayacct_tsk_init(tsk);
 }
@@ -43,6 +49,8 @@ static inline void delayacct_timestamp_s
 		do_posix_clock_monotonic_gettime(&current->delays->start);
 }
 #else
+static inline void delayacct_tsk_early_init(struct task_struct *tsk)
+{}
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {}
 static inline void delayacct_tsk_exit(struct task_struct *tsk)
Index: linux-2.6.16-rc4/include/linux/sysctl.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/sysctl.h	2006-02-27 01:52:52.000000000 -0500
+++ linux-2.6.16-rc4/include/linux/sysctl.h	2006-02-27 01:52:56.000000000 -0500
@@ -147,6 +147,7 @@ enum
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_SCHEDSTATS=71,	/* int: Schedstats on/off */
+	KERN_DELAYACCT=74,	/* int: Per-task delay accounting on/off */
 };
 
 
Index: linux-2.6.16-rc4/kernel/delayacct.c
===================================================================
--- linux-2.6.16-rc4.orig/kernel/delayacct.c	2006-02-27 01:52:54.000000000 -0500
+++ linux-2.6.16-rc4/kernel/delayacct.c	2006-02-27 01:52:56.000000000 -0500
@@ -1,6 +1,7 @@
 /* delayacct.c - per-task delay accounting
  *
  * Copyright (C) Shailabh Nagar, IBM Corp. 2006
+ *           (C) Balbir Singh,   IBM Corp. 2006
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2.1 of the GNU Lesser General Public License
@@ -42,17 +43,30 @@ int delayacct_init(void)
 
 void __delayacct_tsk_init(struct task_struct *tsk)
 {
-	tsk->delays = kmem_cache_alloc(delayacct_cache, SLAB_KERNEL);
-	if (tsk->delays) {
+	struct task_delay_info *delays = NULL;
+
+	delays = kmem_cache_alloc(delayacct_cache, SLAB_KERNEL);
+	if (!delays)
+		return;
+
+	task_lock(tsk);
+	if (!tsk->delays) {
+		tsk->delays = delays;
 		memset(tsk->delays, 0, sizeof(*tsk->delays));
 		spin_lock_init(&tsk->delays->lock);
-	}
+	} else
+		kmem_cache_free(delayacct_cache, delays);
+	task_unlock(tsk);
 }
 
 void __delayacct_tsk_exit(struct task_struct *tsk)
 {
-	kmem_cache_free(delayacct_cache, tsk->delays);
-	tsk->delays = NULL;
+	task_lock(tsk);
+	if (tsk->delays) {
+		kmem_cache_free(delayacct_cache, tsk->delays);
+		tsk->delays = NULL;
+	}
+	task_unlock(tsk);
 }
 
 static inline nsec_t delayacct_measure(void)
@@ -63,3 +77,107 @@ static inline nsec_t delayacct_measure(v
 	do_posix_clock_monotonic_gettime(&current->delays->end);
 	return timespec_diff_ns(&current->delays->start, &current->delays->end);
 }
+
+/* Allocate task_delay_info for all tasks without one */
+static int alloc_delays(void)
+{
+	int cnt=0, i, j;
+	struct task_struct *g, *t;
+	struct task_delay_info **delayp;
+	int err = 0;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, t)
+		if (!t->delays && !(t->flags & (PF_EXITING | PF_DEAD)))
+			cnt++;
+	while_each_thread(g, t);
+	read_unlock(&tasklist_lock);
+
+	if (!cnt)
+		return 0;
+retry_allocs:
+
+	delayp = kmalloc(cnt *sizeof(struct task_delay_info *), GFP_KERNEL);
+	if (!delayp)
+		return -ENOMEM;
+	for (i = 0; i < cnt; i++) {
+		delayp[i] = kmem_cache_alloc(delayacct_cache, SLAB_KERNEL);
+		if (!delayp[i]) {
+			err = -ENOMEM;
+			goto out;
+		}
+		memset(delayp[i], 0, sizeof(*delayp[i]));
+		spin_lock_init(&delayp[i]->lock);
+	}
+
+	i--;
+	j = 0;
+	read_lock(&tasklist_lock);
+	do_each_thread(g, t) {
+		task_lock(t);
+		if (t->delays) {
+			task_unlock(t);
+			continue;
+		}
+		/* Did some additional unaccounted tasks get created */
+		if (i < 0) {
+			j++;
+			task_unlock(t);
+			continue;
+		}
+		if (!(t->flags & (PF_EXITING | PF_DEAD))) {
+			t->delays = delayp[i--];
+		}
+		task_unlock(t);
+	} while_each_thread(g, t);
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * Retry allocations for all tasks created in between the two
+	 * tasklist_locks
+	 */
+	if (j > 0) {
+		kfree(delayp);
+		cnt = j;
+		goto retry_allocs;
+	}
+out:
+	while (i >= 0)
+		kmem_cache_free(delayacct_cache, delayp[i--]);
+	kfree(delayp);
+	return err;
+}
+
+/* Reset task_delay_info structs for all tasks */
+static void reset_delays(void)
+{
+	struct task_struct *g, *t;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, t) {
+		if (!t->delays)
+			continue;
+		memset(t->delays, 0, sizeof(struct task_delay_info));
+		spin_lock_init(&t->delays->lock);
+	} while_each_thread(g, t);
+	read_unlock(&tasklist_lock);
+}
+
+int delayacct_sysctl_handler(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret, prev;
+
+	prev = delayacct_on;
+	ret = proc_dointvec(table, write, filp, buffer, lenp, ppos);
+	if (ret || (prev == delayacct_on))
+		return ret;
+
+	if (delayacct_on)
+		ret = alloc_delays();
+	else
+		reset_delays();
+	if (ret)
+		delayacct_on = prev;
+	return ret;
+}
Index: linux-2.6.16-rc4/kernel/fork.c
===================================================================
--- linux-2.6.16-rc4.orig/kernel/fork.c	2006-02-27 01:52:54.000000000 -0500
+++ linux-2.6.16-rc4/kernel/fork.c	2006-02-27 01:52:56.000000000 -0500
@@ -971,7 +971,6 @@ static task_t *copy_process(unsigned lon
 		goto bad_fork_cleanup_put_domain;
 
 	p->did_exec = 0;
-	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
 	copy_flags(clone_flags, p);
 	p->pid = pid;
 	retval = -EFAULT;
@@ -1013,6 +1012,7 @@ static task_t *copy_process(unsigned lon
 	p->io_wait = NULL;
 	p->audit_context = NULL;
 	cpuset_fork(p);
+	delayacct_tsk_early_init(p);
 #ifdef CONFIG_NUMA
  	p->mempolicy = mpol_copy(p->mempolicy);
  	if (IS_ERR(p->mempolicy)) {
@@ -1191,6 +1191,7 @@ static task_t *copy_process(unsigned lon
 	total_forks++;
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
+	delayacct_tsk_init(p);
 	proc_fork_connector(p);
 	return p;
 
Index: linux-2.6.16-rc4/kernel/sysctl.c
===================================================================
--- linux-2.6.16-rc4.orig/kernel/sysctl.c	2006-02-27 01:52:52.000000000 -0500
+++ linux-2.6.16-rc4/kernel/sysctl.c	2006-02-27 01:52:56.000000000 -0500
@@ -44,6 +44,7 @@
 #include <linux/limits.h>
 #include <linux/dcache.h>
 #include <linux/syscalls.h>
+#include <linux/delayacct.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -666,6 +667,16 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &schedstats_sysctl_handler,
 	},
 #endif
+#if defined(CONFIG_TASK_DELAY_ACCT)
+	{
+		.ctl_name	= KERN_DELAYACCT,
+		.procname	= "delayacct",
+		.data		= &delayacct_on,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &delayacct_sysctl_handler,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 


