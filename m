Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWDVVS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWDVVS0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWDVVSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:18:25 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:16859 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751229AbWDVVSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:18:15 -0400
Message-ID: <44499757.90501@watson.ibm.com>
Date: Fri, 21 Apr 2006 22:39:19 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LSE <lse-tech@lists.sourceforge.net>, Jay Lan <jlan@engr.sgi.com>
Subject: [Patch 6/8] delay accounting usage of taskstats interface
References: <444991EF.3080708@watson.ibm.com>
In-Reply-To: <444991EF.3080708@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog

Fixes comments by akpm (on earlier patch now incorporated here)
- detailed comments on atomicity rules of accounting fields
- replace use of nsec_t


delayacct-taskstats.patch

Usage of taskstats interface by delay accounting.


Signed-off-by: Shailabh Nagar <nagar@us.ibm.com>
Signed-off-by: Balbir Singh <balbir@in.ibm.com>


 include/linux/delayacct.h |   11 ++++++++++
 include/linux/taskstats.h |   48 +++++++++++++++++++++++++++++++++++++++++++++-
 init/Kconfig              |    1
 kernel/delayacct.c        |   42 ++++++++++++++++++++++++++++++++++++++++
 kernel/taskstats.c        |    9 +++++++-
 5 files changed, 109 insertions(+), 2 deletions(-)

Index: linux-2.6.17-rc1/include/linux/delayacct.h
===================================================================
--- linux-2.6.17-rc1.orig/include/linux/delayacct.h	2006-04-21 20:29:13.000000000 -0400
+++ linux-2.6.17-rc1/include/linux/delayacct.h	2006-04-21 20:42:41.000000000 -0400
@@ -18,6 +18,7 @@
 #define _LINUX_TASKDELAYS_H

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
@@ -74,6 +76,13 @@ static inline void delayacct_blkio_end(v
 		__delayacct_blkio_end();
 }

+static inline int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
+{
+	if (!tsk->delays)
+		return -EINVAL;
+	return __delayacct_add_tsk(d, tsk);
+}
+
 #else
 static inline void delayacct_set_flag(int flag)
 {}
@@ -89,6 +98,8 @@ static inline void delayacct_blkio_start
 {}
 static inline void delayacct_blkio_end(void)
 {}
+static inline int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
+{ return 0; }
 #endif /* CONFIG_TASK_DELAY_ACCT */

 #endif
Index: linux-2.6.17-rc1/kernel/delayacct.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/delayacct.c	2006-04-21 20:29:13.000000000 -0400
+++ linux-2.6.17-rc1/kernel/delayacct.c	2006-04-21 20:40:03.000000000 -0400
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
+
+	tmp = (s64)d->cpu_run_real_total;
+	tmp += (u64)(tsk->utime + tsk->stime) * TICK_NSEC;
+	d->cpu_run_real_total = (tmp < (s64)d->cpu_run_real_total) ? 0 : tmp;
+
+	/* No locking available for sched_info (and too expensive to add one)
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
Index: linux-2.6.17-rc1/kernel/taskstats.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/taskstats.c	2006-04-21 20:29:22.000000000 -0400
+++ linux-2.6.17-rc1/kernel/taskstats.c	2006-04-21 20:40:03.000000000 -0400
@@ -18,6 +18,7 @@

 #include <linux/kernel.h>
 #include <linux/taskstats_kern.h>
+#include <linux/delayacct.h>
 #include <net/genetlink.h>
 #include <asm/atomic.h>

@@ -119,7 +120,9 @@ static int fill_pid(pid_t pid, struct ta
 	 *		goto err;
 	 */

-err:
+	rc = delayacct_add_tsk(stats, tsk);
+
+	/* Define err: label here if needed */
 	put_task_struct(tsk);
 	return rc;

@@ -151,6 +154,10 @@ static int fill_tgid(pid_t tgid, struct
 		 *		break;
 		 */

+		rc = delayacct_add_tsk(stats, tsk);
+		if (rc)
+			break;
+
 	} while_each_thread(first, tsk);
 	read_unlock(&tasklist_lock);

Index: linux-2.6.17-rc1/init/Kconfig
===================================================================
--- linux-2.6.17-rc1.orig/init/Kconfig	2006-04-21 20:29:22.000000000 -0400
+++ linux-2.6.17-rc1/init/Kconfig	2006-04-21 20:40:03.000000000 -0400
@@ -164,6 +164,7 @@ config TASKSTATS

 config TASK_DELAY_ACCT
 	bool "Enable per-task delay accounting (EXPERIMENTAL)"
+	depends on TASKSTATS
 	help
 	  Collect information on time spent by a task waiting for system
 	  resources like cpu, synchronous block I/O completion and swapping
Index: linux-2.6.17-rc1/include/linux/taskstats.h
===================================================================
--- linux-2.6.17-rc1.orig/include/linux/taskstats.h	2006-04-21 20:31:11.000000000 -0400
+++ linux-2.6.17-rc1/include/linux/taskstats.h	2006-04-21 20:45:17.000000000 -0400
@@ -35,7 +35,53 @@ struct taskstats {

 	/* Version 1 */

-	int filler_avoids_empty_struct_warnings;
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
 };


