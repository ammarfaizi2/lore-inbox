Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWHCEUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWHCEUs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 00:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWHCEUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 00:20:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15794 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932339AbWHCEUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 00:20:47 -0400
Message-ID: <44D179A5.4000606@engr.sgi.com>
Date: Wed, 02 Aug 2006 21:20:53 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: [patch 1/3] basic accounting over taskstats
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020306020200010908020806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020306020200010908020806
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch is to replace the "[patch 1/3] add basic accounting
fields to taskstats" posted on 7/31.

This patch adds some basic accounting fields to the taskstats
struct, add a new kernel/tsacct.c to handle basic accounting
data handling upon exit. A handle is added to taskstats.c
to invoke the basic accounting data handling.


Signed-off-by: Jay Lan <jlan@sgi.com>



--------------020306020200010908020806
Content-Type: text/plain;
 name="taskstats-rev2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="taskstats-rev2.patch"

Index: linux/include/linux/taskstats.h
===================================================================
--- linux.orig/include/linux/taskstats.h	2006-07-31 11:38:54.132326042 -0700
+++ linux/include/linux/taskstats.h	2006-08-02 19:17:02.155010656 -0700
@@ -2,6 +2,7 @@
  *
  * Copyright (C) Shailabh Nagar, IBM Corp. 2006
  *           (C) Balbir Singh,   IBM Corp. 2006
+ *           (C) Jay Lan,        SGI, 2006
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2.1 of the GNU Lesser General Public License
@@ -29,16 +30,18 @@
  *	c) add new fields after version comment; maintain 64-bit alignment
  */
 
-#define TASKSTATS_VERSION	1
+
+#define TASKSTATS_VERSION	2
+#define TS_COMM_LEN		16	/* should sync up with TASK_COMM_LEN
+					 * in linux/sched.h */
 
 struct taskstats {
 
 	/* Version 1 */
 	__u16	version;
-	__u16	padding[3];	/* Userspace should not interpret the padding
-				 * field which can be replaced by useful
-				 * fields if struct taskstats is extended.
-				 */
+	__u32	ac_exitcode;	/* Exit status */
+	__u8	ac_flag;		/* Record flags */
+	__u8	ac_nice;		/* task_nice */
 
 	/* Delay accounting fields start
 	 *
@@ -88,6 +91,22 @@ struct taskstats {
 	__u64	cpu_run_virtual_total;
 	/* Delay accounting fields end */
 	/* version 1 ends here */
+
+	/* Basic Accounting Fields start */
+	char	ac_comm[TS_COMM_LEN];	/* Command name */
+	__u8	ac_sched;		/* Scheduling discipline */
+	__u8	ac_pad[3];
+	__u32	ac_uid;			/* User ID */
+	__u32	ac_gid;			/* Group ID */
+	__u32	ac_pid;			/* Process ID */
+	__u32	ac_ppid;		/* Parent process ID */
+	__u32	ac_btime;		/* Begin time [sec since 1970] */
+	__u64	ac_etime;		/* Elapsed time [usec] */
+	__u64	ac_utime;		/* User CPU time [usec] */
+	__u64	ac_stime;		/* SYstem CPU time [usec] */
+	__u64	ac_minflt;		/* Minor Page Fault */
+	__u64	ac_majflt;		/* Major Page Fault */
+	/* Basic Accounting Fields end */
 };
 
 
Index: linux/kernel/taskstats.c
===================================================================
--- linux.orig/kernel/taskstats.c	2006-07-31 11:38:54.160326367 -0700
+++ linux/kernel/taskstats.c	2006-08-02 19:17:02.155010656 -0700
@@ -18,6 +18,7 @@
 
 #include <linux/kernel.h>
 #include <linux/taskstats_kern.h>
+#include <linux/tsacct_kern.h>
 #include <linux/delayacct.h>
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
@@ -198,7 +199,10 @@ static int fill_pid(pid_t pid, struct ta
 	 */
 
 	delayacct_add_tsk(stats, tsk);
+
+	/* fill in basic acct fields */
 	stats->version = TASKSTATS_VERSION;
+	bacct_add_tsk(stats, tsk);
 
 	/* Define err: label here if needed */
 	put_task_struct(tsk);
Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile	2006-08-02 14:52:08.000000000 -0700
+++ linux/kernel/Makefile	2006-08-02 16:56:23.029588787 -0700
@@ -49,7 +49,7 @@ obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
-obj-$(CONFIG_TASKSTATS) += taskstats.o
+obj-$(CONFIG_TASKSTATS) += taskstats.o tsacct.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux/kernel/tsacct.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/kernel/tsacct.c	2006-08-02 19:17:20.859257731 -0700
@@ -0,0 +1,69 @@
+/*
+ * tsacct.c - System accounting over taskstats interface
+ *
+ * Copyright (C) Jay Lan,	<jlan@sgi.com>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/tsacct_kern.h>
+#include <linux/acct.h>
+
+
+#define USEC_PER_TICK	(USEC_PER_SEC/HZ)
+/*
+ * fill in basic accounting fields
+ */
+void bacct_add_tsk(struct taskstats *stats, struct task_struct *tsk)
+{
+	struct timespec uptime, ts;
+
+	BUILD_BUG_ON(TS_COMM_LEN < TASK_COMM_LEN);
+
+	/* calculate task elapsed time in timespec */
+	do_posix_clock_monotonic_gettime(&uptime);
+	ts = timespec_sub(uptime, current->group_leader->start_time);
+	/* rebase elapsed time to usec */
+	stats->ac_etime = (timespec_to_ns(&ts))/NSEC_PER_USEC;
+	stats->ac_btime = xtime.tv_sec - ts.tv_sec;
+	if (thread_group_leader(tsk)) {
+		stats->ac_exitcode = tsk->exit_code;
+		if (tsk->flags & PF_FORKNOEXEC)
+			stats->ac_flag |= AFORK;
+	}
+	if (tsk->flags & PF_SUPERPRIV)
+		stats->ac_flag |= ASU;
+	if (tsk->flags & PF_DUMPCORE)
+		stats->ac_flag |= ACORE;
+	if (tsk->flags & PF_SIGNALED)
+		stats->ac_flag |= AXSIG;
+	stats->ac_nice	 = task_nice(tsk);
+	stats->ac_sched	 = tsk->policy;
+	stats->ac_uid	 = tsk->uid;
+	stats->ac_gid	 = tsk->gid;
+	stats->ac_pid	 = tsk->pid;
+	stats->ac_ppid	 = (tsk->parent) ? tsk->parent->pid : 0;
+	stats->ac_utime	 = cputime_to_msecs(tsk->utime) * USEC_PER_MSEC;
+	stats->ac_stime	 = cputime_to_msecs(tsk->stime) * USEC_PER_MSEC;
+	stats->ac_minflt = tsk->min_flt;
+	stats->ac_majflt = tsk->maj_flt;
+	/* Each process gets a minimum of one usec cpu time */
+	if ((stats->ac_utime == 0) && (stats->ac_stime == 0)) {
+		stats->ac_stime = 1;
+	}
+
+	strncpy(stats->ac_comm, tsk->comm, sizeof(stats->ac_comm));
+}
+
Index: linux/include/linux/tsacct_kern.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/tsacct_kern.h	2006-08-02 19:17:02.155010656 -0700
@@ -0,0 +1,19 @@
+/*
+ * tsacct_kern.h - kernel header for system accounting over taskstats interface
+ *
+ * Copyright (C) Jay Lan	SGI
+ */
+
+#ifndef _LINUX_TSACCT_KERN_H
+#define _LINUX_TSACCT_KERN_H
+
+#include <linux/taskstats.h>
+
+#ifdef CONFIG_TASKSTATS
+extern void bacct_add_tsk(struct taskstats *stats, struct task_struct *tsk);
+#else
+static inline void bacct_add_tsk(struct taskstats *stats, struct task_struct *tsk)
+{}
+#endif /* CONFIG_TASKSTATS */
+
+#endif


--------------020306020200010908020806--
