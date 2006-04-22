Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWDVVOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWDVVOx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWDVVOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:14:53 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:9691 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751155AbWDVVOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:14:52 -0400
Message-ID: <44499809.1000301@watson.ibm.com>
Date: Fri, 21 Apr 2006 22:42:17 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LSE <lse-tech@lists.sourceforge.net>, Jay Lan <jlan@engr.sgi.com>
Subject: [Patch 8/8] /proc export of aggregated block I/O delays
References: <444991EF.3080708@watson.ibm.com>
In-Reply-To: <444991EF.3080708@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
 fs/proc/array.c           |    6 ++++--
 include/linux/delayacct.h |   10 ++++++++++
 kernel/delayacct.c        |   12 ++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

Index: linux-2.6.17-rc1/fs/proc/array.c
===================================================================
--- linux-2.6.17-rc1.orig/fs/proc/array.c	2006-04-21 19:39:28.000000000 -0400
+++ linux-2.6.17-rc1/fs/proc/array.c	2006-04-21 20:55:09.000000000 -0400
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
Index: linux-2.6.17-rc1/include/linux/delayacct.h
===================================================================
--- linux-2.6.17-rc1.orig/include/linux/delayacct.h	2006-04-21 20:42:41.000000000 -0400
+++ linux-2.6.17-rc1/include/linux/delayacct.h	2006-04-21 20:55:58.000000000 -0400
@@ -37,6 +37,7 @@ extern void __delayacct_tsk_exit(struct
 extern void __delayacct_blkio_start(void);
 extern void __delayacct_blkio_end(void);
 extern int __delayacct_add_tsk(struct taskstats *, struct task_struct *);
+extern __u64 __delayacct_blkio_ticks(struct task_struct *);

 static inline void delayacct_set_flag(int flag)
 {
@@ -83,6 +84,13 @@ static inline int delayacct_add_tsk(stru
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
@@ -100,6 +108,8 @@ static inline void delayacct_blkio_end(v
 {}
 static inline int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 { return 0; }
+static inline __u64 delayacct_blkio_ticks(struct task_struct *tsk)
+{ return 0; }
 #endif /* CONFIG_TASK_DELAY_ACCT */

 #endif
Index: linux-2.6.17-rc1/kernel/delayacct.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/delayacct.c	2006-04-21 20:40:03.000000000 -0400
+++ linux-2.6.17-rc1/kernel/delayacct.c	2006-04-21 20:55:09.000000000 -0400
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
