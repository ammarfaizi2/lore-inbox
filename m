Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWEBGWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWEBGWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWEBGWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:22:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:12436 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932395AbWEBGWX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:22:23 -0400
Date: Tue, 2 May 2006 11:49:30 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, jlan@engr.sgi.com
Subject: [Patch 6/8] delay accounting usage of taskstats interface
Message-ID: <20060502061930.GC22607@in.ibm.com>
Reply-To: balbir@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changelog

Fixes suggested by Jay Lan
- check for tidstats before taking the mutex_lock in taskstats_exit_send()
- add back version information for struct taskstats

Fixes comments by akpm (on earlier patch now incorporated here)
- detailed comments on atomicity rules of accounting fields
- replace use of nsec_t

Other changes
- fix coding style

delayacct-taskstats.patch

Usage of taskstats interface by delay accounting.

Signed-off-by: Shailabh Nagar <nagar@us.ibm.com>
Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/linux/delayacct.h |   13 +++++++++++
 include/linux/taskstats.h |   53 ++++++++++++++++++++++++++++++++++++++++++++--
 init/Kconfig              |    1 
 kernel/delayacct.c        |   42 ++++++++++++++++++++++++++++++++++++
 kernel/taskstats.c        |   13 ++++++++++-
 5 files changed, 119 insertions(+), 3 deletions(-)

diff -puN include/linux/delayacct.h~delayacct-taskstats include/linux/delayacct.h
--- linux-2.6.17-rc3/include/linux/delayacct.h~delayacct-taskstats	2006-05-02 10:36:31.000000000 +0530
+++ linux-2.6.17-rc3-balbir/include/linux/delayacct.h	2006-05-02 10:39:30.000000000 +0530
@@ -18,6 +18,7 @@
 #define _LINUX_DELAYACCT_H
 
 #include <linux/sched.h>
+#include <linux/taskstats_kern.h>
 
 /*
  * Per-task flags relevant to delay accounting
@@ -35,6 +36,7 @@ extern void __delayacct_tsk_init(struct 
 extern void __delayacct_tsk_exit(struct task_struct *);
 extern void __delayacct_blkio_start(void);
 extern void __delayacct_blkio_end(void);
+extern int __delayacct_add_tsk(struct taskstats *, struct task_struct *);
 
 static inline void delayacct_set_flag(int flag)
 {
@@ -74,6 +76,14 @@ static inline void delayacct_blkio_end(v
 		__delayacct_blkio_end();
 }
 
+static inline int delayacct_add_tsk(struct taskstats *d,
+					struct task_struct *tsk)
+{
+	if (!tsk->delays)
+		return -EINVAL;
+	return __delayacct_add_tsk(d, tsk);
+}
+
 #else
 static inline void delayacct_set_flag(int flag)
 {}
@@ -89,6 +99,9 @@ static inline void delayacct_blkio_start
 {}
 static inline void delayacct_blkio_end(void)
 {}
+static inline int delayacct_add_tsk(struct taskstats *d,
+					struct task_struct *tsk)
+{ return 0; }
 #endif /* CONFIG_TASK_DELAY_ACCT */
 
 #endif
diff -puN include/linux/taskstats.h~delayacct-taskstats include/linux/taskstats.h
--- linux-2.6.17-rc3/include/linux/taskstats.h~delayacct-taskstats	2006-05-02 10:36:31.000000000 +0530
+++ linux-2.6.17-rc3-balbir/include/linux/taskstats.h	2006-05-02 10:36:31.000000000 +0530
@@ -33,9 +33,58 @@
 
 struct taskstats {
 
-	/* Version 1 */
+	/* Delay accounting fields start
+	 *
+	 * All values, until comment "Delay accounting fields end" are
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
+	/* version of taskstats */
+	__u64	version;
 
-	int filler_avoids_empty_struct_warnings;
 };
 
 
diff -puN init/Kconfig~delayacct-taskstats init/Kconfig
--- linux-2.6.17-rc3/init/Kconfig~delayacct-taskstats	2006-05-02 10:36:31.000000000 +0530
+++ linux-2.6.17-rc3-balbir/init/Kconfig	2006-05-02 10:36:31.000000000 +0530
@@ -164,6 +164,7 @@ config TASKSTATS
 
 config TASK_DELAY_ACCT
 	bool "Enable per-task delay accounting (EXPERIMENTAL)"
+	depends on TASKSTATS
 	help
 	  Collect information on time spent by a task waiting for system
 	  resources like cpu, synchronous block I/O completion and swapping
diff -puN kernel/delayacct.c~delayacct-taskstats kernel/delayacct.c
--- linux-2.6.17-rc3/kernel/delayacct.c~delayacct-taskstats	2006-05-02 10:36:31.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/delayacct.c	2006-05-02 10:37:57.000000000 +0530
@@ -104,3 +104,45 @@ void __delayacct_blkio_end(void)
 			&current->delays->blkio_delay,
 			&current->delays->blkio_count);
 }
+
+int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
+{
+	s64 tmp;
+	struct timespec ts;
+	unsigned long t1,t2,t3;
+
+	tmp = (s64)d->cpu_run_real_total;
+	tmp += (u64)(tsk->utime + tsk->stime) * TICK_NSEC;
+	d->cpu_run_real_total = (tmp < (s64)d->cpu_run_real_total) ? 0 : tmp;
+
+	/*
+	 * No locking available for sched_info (and too expensive to add one)
+	 * Mitigate by taking snapshot of values
+	 */
+	t1 = tsk->sched_info.pcnt;
+	t2 = tsk->sched_info.run_delay;
+	t3 = tsk->sched_info.cpu_time;
+
+	d->cpu_count += t1;
+
+	jiffies_to_timespec(t2, &ts);
+	tmp = (s64)d->cpu_delay_total + timespec_to_ns(&ts);
+	d->cpu_delay_total = (tmp < (s64)d->cpu_delay_total) ? 0 : tmp;
+
+	tmp = (s64)d->cpu_run_virtual_total + (s64)jiffies_to_usecs(t3) * 1000;
+	d->cpu_run_virtual_total =
+		(tmp < (s64)d->cpu_run_virtual_total) ?	0 : tmp;
+
+	/* zero XXX_total, non-zero XXX_count implies XXX stat overflowed */
+
+	spin_lock(&tsk->delays->lock);
+	tmp = d->blkio_delay_total + tsk->delays->blkio_delay;
+	d->blkio_delay_total = (tmp < d->blkio_delay_total) ? 0 : tmp;
+	tmp = d->swapin_delay_total + tsk->delays->swapin_delay;
+	d->swapin_delay_total = (tmp < d->swapin_delay_total) ? 0 : tmp;
+	d->blkio_count += tsk->delays->blkio_count;
+	d->swapin_count += tsk->delays->swapin_count;
+	spin_unlock(&tsk->delays->lock);
+
+	return 0;
+}
diff -puN kernel/taskstats.c~delayacct-taskstats kernel/taskstats.c
--- linux-2.6.17-rc3/kernel/taskstats.c~delayacct-taskstats	2006-05-02 10:36:31.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/taskstats.c	2006-05-02 10:36:31.000000000 +0530
@@ -18,6 +18,7 @@
 
 #include <linux/kernel.h>
 #include <linux/taskstats_kern.h>
+#include <linux/delayacct.h>
 #include <net/genetlink.h>
 #include <asm/atomic.h>
 
@@ -120,7 +121,9 @@ static int fill_pid(pid_t pid, struct ta
 	 *		goto err;
 	 */
 
-err:
+	rc = delayacct_add_tsk(stats, tsk);
+
+	/* Define err: label here if needed */
 	put_task_struct(tsk);
 	return rc;
 
@@ -152,6 +155,10 @@ static int fill_tgid(pid_t tgid, struct 
 		 *		break;
 		 */
 
+		rc = delayacct_add_tsk(stats, tsk);
+		if (rc)
+			break;
+
 	} while_each_thread(first, tsk);
 	read_unlock(&tasklist_lock);
 
@@ -255,6 +262,8 @@ void taskstats_exit_send(struct task_str
 	if (rc < 0)
 		goto err_skb;
 
+	tidstats->version = TASKSTATS_VERSION;
+
 	na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_PID);
 	NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_PID, (u32)tsk->pid);
 	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS,
@@ -270,6 +279,8 @@ void taskstats_exit_send(struct task_str
 	if (rc < 0)
 		goto err_skb;
 
+	tgidstats->version = TASKSTATS_VERSION;
+
 	na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_TGID);
 	NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_TGID, (u32)tsk->tgid);
 	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS,
_
