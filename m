Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWHHTdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWHHTdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWHHTdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:33:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:64958 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030236AbWHHTdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:33:43 -0400
Message-ID: <44D8E709.2040705@sgi.com>
Date: Tue, 08 Aug 2006 12:33:29 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: [PATCH] csa accounting taskstats update
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010309030801050505060402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010309030801050505060402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch addresses the feedbacks from you and Balbir.

This patch is generated against 2.6.18-rc3 plus your patch
+ csa-basic-accounting-over-taskstats-fix.patch

This patch is to be applied after your patch which you
already added to -mm tree.



Signed-off-by: Jay Lan <jlan@sgi.com>


I test built on ia64, i386 and x86_64 build servers.

ChangeLog:
   Feedbacks from Andrew Morton:
   - define TS_COMM_LEN to 32
   - change acct_stimexpd field of task_struct to be of
     cputime_t, which is to be used to save the tsk->stime
     of last timer interrupt update.
   - a new Documentation/accounting/taskstats-struct.txt
     to describe fields of taskstats struct.

   Feedback from Balbir Singh:
   - keep the stime of a task to be zero when both stime
     and utime are zero as recoreded in task_struct.

   Misc:
   - convert accumulated RSS/VM from platform dependent
     pages-ticks to MBytes-usecs in the kernel


--------------010309030801050505060402
Content-Type: text/plain;
 name="2.6.18-rc2-taskstats-acct-update"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.18-rc2-taskstats-acct-update"

Index: linux/include/linux/taskstats.h
===================================================================
--- linux.orig/include/linux/taskstats.h	2006-08-08 11:14:05.180663670 -0700
+++ linux/include/linux/taskstats.h	2006-08-08 11:44:27.934463619 -0700
@@ -32,14 +32,21 @@
 
 
 #define TASKSTATS_VERSION	2
-#define TS_COMM_LEN		16	/* should sync up with TASK_COMM_LEN
+#define TS_COMM_LEN		32	/* should sync up with TASK_COMM_LEN
 					 * in linux/sched.h */
 
 struct taskstats {
 
-	/* Version 1 */
+	/* The version number of this struct. This field is always set to
+	 * TAKSTATS_VERSION, which is defined in <linux/taskstats.h>.
+	 * Each time the struct is changed, the value should be incremented.
+	 */
 	__u16	version;
-	__u32	ac_exitcode;	/* Exit status */
+	__u32	ac_exitcode;		/* Exit status */
+
+	/* The accounting flags of a task as defined in <linux/acct.h>
+	 * Defined values are AFORK, ASU, ACOMPAT, ACORE, and AXSIG.
+	 */
 	__u8	ac_flag;		/* Record flags */
 	__u8	ac_nice;		/* task_nice */
 
@@ -104,15 +111,30 @@ struct taskstats {
 	__u64	ac_etime;		/* Elapsed time [usec] */
 	__u64	ac_utime;		/* User CPU time [usec] */
 	__u64	ac_stime;		/* SYstem CPU time [usec] */
-	__u64	ac_minflt;		/* Minor Page Fault */
-	__u64	ac_majflt;		/* Major Page Fault */
+	__u64	ac_minflt;		/* Minor Page Fault Count */
+	__u64	ac_majflt;		/* Major Page Fault Count */
 	/* Basic Accounting Fields end */
 
  	/* Extended accounting fields start */
- 	__u64	acct_rss_mem1;		/* accumulated rss usage */
- 	__u64	acct_vm_mem1;		/* accumulated virtual memory usage */
- 	__u64	hiwater_rss;		/* High-watermark of RSS usage */
- 	__u64	hiwater_vm;		/* High-water virtual memory usage */
+	/* Accumulated RSS usage in duration of a task, in MBytes-usecs.
+	 * The current rss usage is added to this counter every time
+	 * a tick is charged to a task's system time. So, at the end we
+	 * will have memory usage multiplied by system time. Thus an
+	 * average usage per system time unit can be calculated.
+	 */
+ 	__u64	coremem;		/* accumulated RSS usage in MB-usec */
+	/* Accumulated virtual memory usage in duration of a task.
+	 * Same as acct_rss_mem1 above except that we keep track of VM usage.
+	 */
+ 	__u64	virtmem;		/* accumulated VM  usage in MB-usec */
+
+	/* High watermark of RSS and virtual memory usage in duration of
+	 * a task, in KBytes.
+	 */
+ 	__u64	hiwater_rss;		/* High-watermark of RSS usage, in KB */
+ 	__u64	hiwater_vm;		/* High-water VM usage, in KB */
+
+	/* The following four fields are I/O statistics of a task. */
  	__u64	read_char;		/* bytes read */
  	__u64	write_char;		/* bytes written */
  	__u64	read_syscalls;		/* read syscalls */
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2006-08-08 11:14:06.468678357 -0700
+++ linux/include/linux/sched.h	2006-08-08 11:14:14.964775244 -0700
@@ -967,7 +967,7 @@ struct task_struct {
 #if defined(CONFIG_TASK_XACCT)
 	u64 acct_rss_mem1;	/* accumulated rss usage */
 	u64 acct_vm_mem1;	/* accumulated virtual memory usage */
-	clock_t acct_stimexpd;	/* clock_t-converted stime since last update */
+	cputime_t acct_stimexpd;/* stime since last update */
 #endif
 #ifdef CONFIG_NUMA
   	struct mempolicy *mempolicy;
Index: linux/kernel/tsacct.c
===================================================================
--- linux.orig/kernel/tsacct.c	2006-08-08 11:14:12.132742947 -0700
+++ linux/kernel/tsacct.c	2006-08-08 11:14:14.968775290 -0700
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/tsacct_kern.h>
 #include <linux/acct.h>
+#include <linux/jiffies.h>
 
 
 #define USEC_PER_TICK	(USEC_PER_SEC/HZ)
@@ -62,33 +63,35 @@ void bacct_add_tsk(struct taskstats *sta
 	stats->ac_stime	 = cputime_to_msecs(tsk->stime) * USEC_PER_MSEC;
 	stats->ac_minflt = tsk->min_flt;
 	stats->ac_majflt = tsk->maj_flt;
-	/* Each process gets a minimum of one usec cpu time */
-	if ((stats->ac_utime == 0) && (stats->ac_stime == 0)) {
-		stats->ac_stime = 1;
-	}
 
 	strncpy(stats->ac_comm, tsk->comm, sizeof(stats->ac_comm));
 }
 
 
 #ifdef CONFIG_TASK_XACCT
+
+#define KB 1024
+#define MB (1024*KB)
 /*
  * fill in extended accounting fields
  */
 void xacct_add_tsk(struct taskstats *stats, struct task_struct *p)
 {
-	stats->acct_rss_mem1 = p->acct_rss_mem1;
-	stats->acct_vm_mem1  = p->acct_vm_mem1;
+	/* convert pages-jiffies to Mbyte-usec */
+	stats->coremem = jiffies_to_usecs(p->acct_rss_mem1) * PAGE_SIZE / MB;
+	stats->virtmem = jiffies_to_usecs(p->acct_vm_mem1) * PAGE_SIZE / MB;
 	if (p->mm) {
-		stats->hiwater_rss   = p->mm->hiwater_rss;
-		stats->hiwater_vm    = p->mm->hiwater_vm;
+		/* adjust to KB unit */
+		stats->hiwater_rss   = p->mm->hiwater_rss * PAGE_SIZE / KB;
+		stats->hiwater_vm    = p->mm->hiwater_vm * PAGE_SIZE / KB;
 	}
 	stats->read_char	= p->rchar;
 	stats->write_char	= p->wchar;
 	stats->read_syscalls	= p->syscr;
 	stats->write_syscalls	= p->syscw;
 }
-
+#undef KB
+#undef MB
 
 /**
  * acct_update_integrals - update mm integral fields in task_struct
@@ -97,8 +100,8 @@ void xacct_add_tsk(struct taskstats *sta
 void acct_update_integrals(struct task_struct *tsk)
 {
 	if (likely(tsk->mm)) {
-		long delta =
-			cputime_to_jiffies(tsk->stime) - tsk->acct_stimexpd;
+		long delta = cputime_to_jiffies(
+			cputime_sub(tsk->stime, tsk->acct_stimexpd));
 
 		if (delta == 0)
 			return;
Index: linux/Documentation/accounting/taskstats-struct.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/Documentation/accounting/taskstats-struct.txt	2006-08-08 11:35:56.724246832 -0700
@@ -0,0 +1,161 @@
+The struct taskstats
+--------------------
+
+This document contains an explanation of the struct taskstats fields.
+
+There are three different groups of fields in the struct taskstats:
+
+1) Common and basic accounting fields
+    If CONFIG_TASKSTATS is set, the taskstats inteface is enabled and
+    the common fields and basic accounting fields are collected for
+    delivery at do_exit() of a task.
+2) Delay accounting fields
+    These fields are placed between
+    /* Delay accounting fields start */
+    and
+    /* Delay accounting fields end */
+    Their values are collected if CONFIG_TASK_DELAY_ACCT is set.
+3) Extended accounting fields
+    These fields are placed between
+    /* Extended accounting fields start */
+    and
+    /* Extended accounting fields end */
+    Their values are collected if CONFIG_TASK_XACCT is set.
+
+Future extension should add fields to the end of the taskstats struct, and
+should not change the relative position of each field within the struct.
+
+
+struct taskstats {
+
+1) Common and basic accounting fields:
+	/* The version number of this struct. This field is always set to
+	 * TAKSTATS_VERSION, which is defined in <linux/taskstats.h>.
+	 * Each time the struct is changed, the value should be incremented.
+	 */
+	__u16	version;
+
+  	/* The exit code of a task. */
+	__u32	ac_exitcode;		/* Exit status */
+
+  	/* The accounting flags of a task as defined in <linux/acct.h>
+	 * Defined values are AFORK, ASU, ACOMPAT, ACORE, and AXSIG.
+	 */
+	__u8	ac_flag;		/* Record flags */
+
+  	/* The value of task_nice() of a task. */
+	__u8	ac_nice;		/* task_nice */
+
+  	/* The name of the command that started this task. */
+	char	ac_comm[TS_COMM_LEN];	/* Command name */
+
+  	/* The scheduling discipline as set in task->policy field. */
+	__u8	ac_sched;		/* Scheduling discipline */
+
+	__u8	ac_pad[3];
+	__u32	ac_uid;			/* User ID */
+	__u32	ac_gid;			/* Group ID */
+	__u32	ac_pid;			/* Process ID */
+	__u32	ac_ppid;		/* Parent process ID */
+
+  	/* The time when a task begins, in [secs] since 1970. */
+	__u32	ac_btime;		/* Begin time [sec since 1970] */
+
+  	/* The elapsed time of a task, in [usec]. */
+	__u64	ac_etime;		/* Elapsed time [usec] */
+
+  	/* The user CPU time of a task, in [usec]. */
+	__u64	ac_utime;		/* User CPU time [usec] */
+
+  	/* The system CPU time of a task, in [usec]. */
+	__u64	ac_stime;		/* System CPU time [usec] */
+
+  	/* The minor page fault count of a task, as set in task->min_flt. */
+	__u64	ac_minflt;		/* Minor Page Fault Count */
+
+	/* The major page fault count of a task, as set in task->maj_flt. */
+	__u64	ac_majflt;		/* Major Page Fault Count */
+
+
+2) Delay accounting fields:
+	/* Delay accounting fields start
+	 *
+	 * All values, until the comment "Delay accounting fields end" are
+	 * available only if delay accounting is enabled, even though the last
+	 * few fields are not delays
+	 *
+	 * xxx_count is the number of delay values recorded
+	 * xxx_delay_total is the corresponding cumulative delay in nanoseconds
+	 *
+	 * xxx_delay_total wraps around to zero on overflow
+	 * xxx_count incremented regardless of overflow
+	 */
+
+	/* Delay waiting for cpu, while runnable
+	 * count, delay_total NOT updated atomically
+	 */
+	__u64	cpu_count;
+	__u64	cpu_delay_total;
+
+	/* Following four fields atomically updated using task->delays->lock */
+
+	/* Delay waiting for synchronous block I/O to complete
+	 * does not account for delays in I/O submission
+	 */
+	__u64	blkio_count;
+	__u64	blkio_delay_total;
+
+	/* Delay waiting for page fault I/O (swap in only) */
+	__u64	swapin_count;
+	__u64	swapin_delay_total;
+
+	/* cpu "wall-clock" running time
+	 * On some architectures, value will adjust for cpu time stolen
+	 * from the kernel in involuntary waits due to virtualization.
+	 * Value is cumulative, in nanoseconds, without a corresponding count
+	 * and wraps around to zero silently on overflow
+	 */
+	__u64	cpu_run_real_total;
+
+	/* cpu "virtual" running time
+	 * Uses time intervals seen by the kernel i.e. no adjustment
+	 * for kernel's involuntary waits due to virtualization.
+	 * Value is cumulative, in nanoseconds, without a corresponding count
+	 * and wraps around to zero silently on overflow
+	 */
+	__u64	cpu_run_virtual_total;
+	/* Delay accounting fields end */
+	/* version 1 ends here */
+
+
+3) Extended accounting fields
+	/* Extended accounting fields start */
+
+	/* Accumulated RSS usage in duration of a task, in MBytes-usecs.
+	 * The current rss usage is added to this counter every time
+	 * a tick is charged to a task's system time. So, at the end we
+	 * will have memory usage multiplied by system time. Thus an
+	 * average usage per system time unit can be calculated.
+	 */
+	__u64	coremem;		/* accumulated RSS usage in MB-usec */
+
+  	/* Accumulated virtual memory usage in duration of a task.
+	 * Same as acct_rss_mem1 above except that we keep track of VM usage.
+	 */
+	__u64	virtmem;		/* accumulated VM usage in MB-usec */
+
+  	/* High watermark of RSS usage in duration of a task, in KBytes. */
+	__u64	hiwater_rss;		/* High-watermark of RSS usage */
+
+  	/* High watermark of VM  usage in duration of a task, in KBytes. */
+	__u64	hiwater_vm;		/* High-water virtual memory usage */
+
+	/* The following four fields are I/O statistics of a task. */
+	__u64	read_char;		/* bytes read */
+	__u64	write_char;		/* bytes written */
+	__u64	read_syscalls;		/* read syscalls */
+	__u64	write_syscalls;		/* write syscalls */
+
+	/* Extended accounting fields end */
+
+}

--------------010309030801050505060402--
