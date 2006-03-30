Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWC3A5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWC3A5D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWC3A5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:57:03 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:61455 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751183AbWC3A5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:57:01 -0500
Message-ID: <442B2CCC.2080604@watson.ibm.com>
Date: Wed, 29 Mar 2006 19:56:44 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 7/8] proc interface for block I/O delays
References: <442B271D.10208@watson.ibm.com>
In-Reply-To: <442B271D.10208@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-procfs.patch

Export I/O delays seen by a task through /proc/<tgid>/stats
for use in top etc.

Note that delays for I/O done for swapping in pages (swapin I/O) is
clubbed together with all other I/O here (this is not the
case in the netlink interface where the swapin I/O is kept distinct)

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>


 fs/proc/array.c           |    6 ++++--
 include/linux/delayacct.h |   11 +++++++++++
 kernel/delayacct.c        |   15 +++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

Index: linux-2.6.16/fs/proc/array.c
===================================================================
--- linux-2.6.16.orig/fs/proc/array.c	2006-03-29 18:12:54.000000000 -0500
+++ linux-2.6.16/fs/proc/array.c	2006-03-29 18:13:21.000000000 -0500
@@ -75,6 +75,7 @@
 #include <linux/times.h>
 #include <linux/cpuset.h>
 #include <linux/rcupdate.h>
+#include <linux/delayacct.h>

 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -414,7 +415,7 @@ static int do_task_stat(struct task_stru

 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %llu\n",
 		task->pid,
 		tcomm,
 		state,
@@ -459,7 +460,8 @@ static int do_task_stat(struct task_stru
 		task->exit_signal,
 		task_cpu(task),
 		task->rt_priority,
-		task->policy);
+		task->policy,
+		delayacct_blkio_ticks(task));
 	if(mm)
 		mmput(mm);
 	return res;
Index: linux-2.6.16/include/linux/delayacct.h
===================================================================
--- linux-2.6.16.orig/include/linux/delayacct.h	2006-03-29 18:13:18.000000000 -0500
+++ linux-2.6.16/include/linux/delayacct.h	2006-03-29 18:13:21.000000000 -0500
@@ -29,6 +29,7 @@ extern void __delayacct_tsk_exit(struct
 extern void __delayacct_blkio_start(void);
 extern void __delayacct_blkio_end(void);
 extern int __delayacct_add_tsk(struct taskstats *, struct task_struct *);
+extern unsigned long long __delayacct_blkio_ticks(struct task_struct *);

 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
@@ -54,6 +55,12 @@ static inline void delayacct_blkio_end(v
 	if (current->delays)
 		__delayacct_blkio_end();
 }
+static inline unsigned long long delayacct_blkio_ticks(struct task_struct *tsk)
+{
+	if (unlikely(delayacct_on))
+		return __delayacct_blkio_ticks(tsk);
+	return 0;
+}
 #else
 static inline void delayacct_init(void)
 {}
@@ -65,6 +72,10 @@ static inline void delayacct_blkio_start
 {}
 static inline void delayacct_blkio_end(void)
 {}
+static inline unsigned long long delayacct_blkio_ticks(struct task_struct *tsk)
+{
+	return 0;
+}
 #endif /* CONFIG_TASK_DELAY_ACCT */
 #ifdef CONFIG_TASKSTATS
 static inline int delayacct_add_tsk(struct taskstats *d,
Index: linux-2.6.16/kernel/delayacct.c
===================================================================
--- linux-2.6.16.orig/kernel/delayacct.c	2006-03-29 18:13:20.000000000 -0500
+++ linux-2.6.16/kernel/delayacct.c	2006-03-29 18:13:21.000000000 -0500
@@ -118,6 +118,21 @@ void __delayacct_blkio_end(void)
 			      &current->delays->blkio_delay,
 			      &current->delays->blkio_count);
 }
+
+unsigned long long __delayacct_blkio_ticks(struct task_struct *tsk)
+{
+	unsigned long long ret;
+
+	if (!tsk->delays)
+		return 0;
+
+	spin_lock(&tsk->delays->lock);
+	ret = nsec_to_clock_t(tsk->delays->blkio_delay +
+				tsk->delays->swapin_delay);
+	spin_unlock(&tsk->delays->lock);
+	return ret;
+}
+
 #ifdef CONFIG_TASKSTATS
 int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 {

