Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbWACXcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWACXcn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbWACXcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:32:39 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:62951 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965114AbWACXb5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:31:57 -0500
Message-ID: <43BB095C.5000809@watson.ibm.com>
Date: Tue, 03 Jan 2006 23:31:40 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: [Patch 5/6] Delay accounting: /proc interface
References: <43BB05D8.6070101@watson.ibm.com>
In-Reply-To: <43BB05D8.6070101@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since 12/7/05
- Return per-tgid stats as sum of constituent tid data
- for cpu running time, use tsk->sched_info.cpu_time (collected by schedstats)

12/07/05: First post

delayacct-procfs.patch

Creates /proc/<pid>/delay interface for getting delay and cpu statistics
for tasks. The cpu stats are available (non-zero) only if CONFIG_SCHEDSTATS
is enabled.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 fs/proc/array.c    |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/proc/base.c     |   21 +++++++++++++++-
 fs/proc/internal.h |    2 +
 3 files changed, 90 insertions(+), 1 deletion(-)

Index: linux-2.6.15-rc7/fs/proc/array.c
===================================================================
--- linux-2.6.15-rc7.orig/fs/proc/array.c
+++ linux-2.6.15-rc7/fs/proc/array.c
@@ -488,3 +488,71 @@ int proc_pid_statm(struct task_struct *t
 	return sprintf(buffer,"%d %d %d %d %d %d %d\n",
 		       size, resident, shared, text, lib, data, 0);
 }
+
+#ifdef CONFIG_TASK_DELAY_ACCT
+int proc_pid_delay(struct task_struct *task, char * buffer)
+{
+	unsigned long long run_delay, run_time;
+	unsigned long run_count;
+
+#ifdef CONFIG_SCHEDSTATS
+	run_count = task->sched_info.pcnt ;
+	run_time = jiffies_to_usecs(task->sched_info.cpu_time)*1000;
+	run_delay = jiffies_to_usecs(task->sched_info.run_delay)*1000;
+#else
+	/* Non-zero values, zero count indicates data not collected */
+	run_count = 0;
+	run_time = run_delay = 1;
+#endif
+	return sprintf(buffer,"%lu %llu %llu %u %llu %u %llu\n",
+		       run_count, (uint64_t) run_time, (uint64_t) run_delay,
+		       (unsigned int) task->delays.blkio_count,
+		       (uint64_t) task->delays.blkio_delay,
+		       (unsigned int) task->delays.swapin_count,
+		       (uint64_t) task->delays.swapin_delay);
+}
+
+/*
+ * Sum up delay stats for tid's of the tgid
+ * For any delay stat, a zero delay and non-zero count indicates overflow
+ *
+ */
+int proc_tgid_delay(struct task_struct *task, char * buffer)
+{
+	uint64_t run_time = 0, run_delay = 0, run_count = 0;
+	uint64_t blkio_delay = 0, blkio_count = 0;
+	uint64_t swapin_delay = 0, swapin_count = 0, tmp;
+	struct task_struct *t = task;
+
+	read_lock(&tasklist_lock);
+	do {
+#ifdef CONFIG_SCHEDSTATS
+		run_count += t->sched_info.pcnt;
+		tmp = run_time + jiffies_to_usecs(t->sched_info.cpu_time)*1000;
+		run_time = (tmp < run_time)? 0:tmp ;
+		tmp = run_delay + jiffies_to_usecs(t->sched_info.run_delay)*1000;
+		run_delay = (tmp < run_delay)? 0:tmp;
+#else
+		/* Non-zero values, zero count indicates data not collected */
+		run_count = 0;
+		run_time = run_delay = 1;
+#endif
+		spin_lock(&t->delays.lock);
+		tmp = blkio_delay + t->delays.blkio_delay;
+		blkio_delay = (tmp < blkio_delay)? 0:tmp ;
+		tmp = swapin_delay + t->delays.swapin_delay;
+		swapin_delay = (tmp < swapin_delay)? 0:tmp ;
+		blkio_count += t->delays.blkio_count;
+		swapin_count += t->delays.swapin_count;
+		spin_unlock(&t->delays.lock);
+
+	} while_each_thread(task, t);
+	read_unlock(&tasklist_lock);
+
+	return sprintf(buffer,"%llu %llu %llu %llu %llu %llu %llu\n",
+		       run_count, run_time, run_delay,
+		       blkio_count, blkio_delay,
+		       swapin_count, swapin_delay);
+}
+
+#endif
Index: linux-2.6.15-rc7/fs/proc/base.c
===================================================================
--- linux-2.6.15-rc7.orig/fs/proc/base.c
+++ linux-2.6.15-rc7/fs/proc/base.c
@@ -165,7 +165,10 @@ enum pid_directory_inos {
 #endif
 	PROC_TID_OOM_SCORE,
 	PROC_TID_OOM_ADJUST,
-
+#ifdef CONFIG_TASK_DELAY_ACCT
+        PROC_TID_DELAY_ACCT,
+        PROC_TGID_DELAY_ACCT,
+#endif
 	/* Add new entries before this */
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
@@ -220,6 +223,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TGID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+#ifdef CONFIG_TASK_DELAY_ACCT
+	E(PROC_TGID_DELAY_ACCT,"delay",   S_IFREG|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -262,6 +268,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+#ifdef CONFIG_TASK_DELAY_ACCT
+	E(PROC_TID_DELAY_ACCT,"delay",   S_IFREG|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };

@@ -1786,6 +1795,16 @@ static struct dentry *proc_pident_lookup
 			inode->i_fop = &proc_loginuid_operations;
 			break;
 #endif
+#ifdef CONFIG_TASK_DELAY_ACCT
+		case PROC_TID_DELAY_ACCT:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_delay;
+			break;
+		case PROC_TGID_DELAY_ACCT:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_tgid_delay;
+			break;
+#endif
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
Index: linux-2.6.15-rc7/fs/proc/internal.h
===================================================================
--- linux-2.6.15-rc7.orig/fs/proc/internal.h
+++ linux-2.6.15-rc7/fs/proc/internal.h
@@ -36,6 +36,8 @@ extern int proc_tid_stat(struct task_str
 extern int proc_tgid_stat(struct task_struct *, char *);
 extern int proc_pid_status(struct task_struct *, char *);
 extern int proc_pid_statm(struct task_struct *, char *);
+extern int proc_pid_delay(struct task_struct *, char*);
+extern int proc_tgid_delay(struct task_struct *, char*);

 static inline struct task_struct *proc_task(struct inode *inode)
 {
