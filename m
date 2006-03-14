Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWCNAxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWCNAxt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWCNAxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:53:48 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:43227 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932521AbWCNAxr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:53:47 -0500
Subject: [Patch 7/9] /proc interface for all I/O delays
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1142296834.5858.3.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1142297625.5858.25.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Mar 2006 19:53:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-procfs.patch

Export I/O delays seen by a task through /proc/<tgid>/stats
for use in top etc.

Note that delays for I/O done for swapping in pages (swapin I/O) is 
clubbed together with all other I/O here (this is not the 
case for the other interface where the swapin I/O is kept distinct)

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>


 fs/proc/array.c           |    6 ++++--
 include/linux/delayacct.h |   10 ++++++++++
 include/linux/jiffies.h   |    6 ++++++
 kernel/delayacct.c        |   13 +++++++++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc5/fs/proc/array.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/proc/array.c	2006-03-11 07:41:32.000000000 -0500
+++ linux-2.6.16-rc5/fs/proc/array.c	2006-03-11 07:41:40.000000000 -0500
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
+		      task->policy,
+		delayacct_blkio_ticks(task));
 	if(mm)
 		mmput(mm);
 	return res;
Index: linux-2.6.16-rc5/include/linux/delayacct.h
===================================================================
--- linux-2.6.16-rc5.orig/include/linux/delayacct.h	2006-03-11 07:41:38.000000000 -0500
+++ linux-2.6.16-rc5/include/linux/delayacct.h	2006-03-11 07:41:40.000000000 -0500
@@ -24,6 +24,7 @@ extern void __delayacct_tsk_init(struct 
 extern void __delayacct_tsk_exit(struct task_struct *);
 extern void __delayacct_blkio_start(void);
 extern void __delayacct_blkio_end(void);
+extern unsigned long long __delayacct_blkio_ticks(struct task_struct *);
 
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
@@ -49,6 +50,11 @@ static inline void delayacct_blkio_end(v
 	if (unlikely(delayacct_on))
 		__delayacct_blkio_end();
 }
+static inline unsigned long long delayacct_blkio_ticks(struct task_struct *tsk)
+{
+	if (unlikely(delayacct_on))
+		return __delayacct_blkio_ticks(tsk);
+}
 #else
 static inline int delayacct_init(void)
 {}
@@ -60,5 +66,9 @@ static inline void delayacct_blkio_start
 {}
 static inline void delayacct_blkio_end(void)
 {}
+static inline unsigned long long delayacct_blkio_ticks(struct task_struct *tsk)
+{
+	return 0;
+}
 #endif /* CONFIG_TASK_DELAY_ACCT */
 #endif /* _LINUX_TASKDELAYS_H */
Index: linux-2.6.16-rc5/include/linux/jiffies.h
===================================================================
--- linux-2.6.16-rc5.orig/include/linux/jiffies.h	2006-03-11 07:41:32.000000000 -0500
+++ linux-2.6.16-rc5/include/linux/jiffies.h	2006-03-11 07:41:40.000000000 -0500
@@ -291,6 +291,12 @@ static inline unsigned long usecs_to_jif
 #endif
 }
 
+static inline unsigned long nsecs_to_jiffies(const nsec_t n)
+{
+	return (((u64)n * NSEC_CONVERSION) >>
+		(NSEC_JIFFIE_SC - SEC_JIFFIE_SC)) >> SEC_JIFFIE_SC;
+}
+
 /*
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
  * that a remainder subtract here would not do the right thing as the
Index: linux-2.6.16-rc5/kernel/delayacct.c
===================================================================
--- linux-2.6.16-rc5.orig/kernel/delayacct.c	2006-03-11 07:41:39.000000000 -0500
+++ linux-2.6.16-rc5/kernel/delayacct.c	2006-03-11 07:41:40.000000000 -0500
@@ -111,3 +111,16 @@ void __delayacct_blkio_end(void)
 				      &current->delays->blkio_count);
 	}
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
+	ret = nsec_to_clock_t(tsk->delays->blkio_delay + tsk->delays->swapin_delay);
+	spin_unlock(&tsk->delays->lock);
+	return ret;
+}


