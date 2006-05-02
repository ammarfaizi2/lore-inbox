Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWEBGYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWEBGYM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWEBGYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:24:12 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:63442 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932397AbWEBGYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:24:10 -0400
Date: Tue, 2 May 2006 11:51:17 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, jlan@engr.sgi.com
Subject: [Patch 8/8] /proc export of aggregated block I/O delays
Message-ID: <20060502062117.GE22607@in.ibm.com>
Reply-To: balbir@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changelog
Fixed comments by akpm
- use __u64 for delayacct_blkio_ticks() return type
- redundant check for tsk->delays in __delayacct_blkio_ticks()

delayacct-procfs.patch

Export I/O delays seen by a task through /proc/<tgid>/stats
for use in top etc.

Note that delays for I/O done for swapping in pages (swapin I/O) is
clubbed together with all other I/O here (this is not the
case in the netlink interface where the swapin I/O is kept distinct)

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 fs/proc/array.c           |    6 ++++--
 include/linux/delayacct.h |   10 ++++++++++
 kernel/delayacct.c        |   12 ++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff -puN fs/proc/array.c~delayacct-procfs fs/proc/array.c
--- linux-2.6.17-rc3/fs/proc/array.c~delayacct-procfs	2006-05-02 10:40:06.000000000 +0530
+++ linux-2.6.17-rc3-balbir/fs/proc/array.c	2006-05-02 10:40:06.000000000 +0530
@@ -75,6 +75,7 @@
 #include <linux/times.h>
 #include <linux/cpuset.h>
 #include <linux/rcupdate.h>
+#include <linux/delayacct.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -412,7 +413,7 @@ static int do_task_stat(struct task_stru
 
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d 0 %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %llu\n",
 		task->pid,
 		tcomm,
 		state,
@@ -456,7 +457,8 @@ static int do_task_stat(struct task_stru
 		task->exit_signal,
 		task_cpu(task),
 		task->rt_priority,
-		task->policy);
+		task->policy,
+		delayacct_blkio_ticks(task));
 	if(mm)
 		mmput(mm);
 	return res;
diff -puN include/linux/delayacct.h~delayacct-procfs include/linux/delayacct.h
--- linux-2.6.17-rc3/include/linux/delayacct.h~delayacct-procfs	2006-05-02 10:40:06.000000000 +0530
+++ linux-2.6.17-rc3-balbir/include/linux/delayacct.h	2006-05-02 10:40:06.000000000 +0530
@@ -37,6 +37,7 @@ extern void __delayacct_tsk_exit(struct 
 extern void __delayacct_blkio_start(void);
 extern void __delayacct_blkio_end(void);
 extern int __delayacct_add_tsk(struct taskstats *, struct task_struct *);
+extern __u64 __delayacct_blkio_ticks(struct task_struct *);
 
 static inline void delayacct_set_flag(int flag)
 {
@@ -84,6 +85,13 @@ static inline int delayacct_add_tsk(stru
 	return __delayacct_add_tsk(d, tsk);
 }
 
+static inline __u64 delayacct_blkio_ticks(struct task_struct *tsk)
+{
+	if (tsk->delays)
+		return __delayacct_blkio_ticks(tsk);
+	return 0;
+}
+
 #else
 static inline void delayacct_set_flag(int flag)
 {}
@@ -102,6 +110,8 @@ static inline void delayacct_blkio_end(v
 static inline int delayacct_add_tsk(struct taskstats *d,
 					struct task_struct *tsk)
 { return 0; }
+static inline __u64 delayacct_blkio_ticks(struct task_struct *tsk)
+{ return 0; }
 #endif /* CONFIG_TASK_DELAY_ACCT */
 
 #endif
diff -puN kernel/delayacct.c~delayacct-procfs kernel/delayacct.c
--- linux-2.6.17-rc3/kernel/delayacct.c~delayacct-procfs	2006-05-02 10:40:06.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/delayacct.c	2006-05-02 10:40:06.000000000 +0530
@@ -146,3 +146,15 @@ int __delayacct_add_tsk(struct taskstats
 
 	return 0;
 }
+
+__u64 __delayacct_blkio_ticks(struct task_struct *tsk)
+{
+	__u64 ret;
+
+	spin_lock(&tsk->delays->lock);
+	ret = nsec_to_clock_t(tsk->delays->blkio_delay +
+				tsk->delays->swapin_delay);
+	spin_unlock(&tsk->delays->lock);
+	return ret;
+}
+
_
