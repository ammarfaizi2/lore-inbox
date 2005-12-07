Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbVLGWaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbVLGWaA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbVLGW37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:29:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:58297 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030426AbVLGW36
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:29:58 -0500
Message-ID: <4397625F.2020208@watson.ibm.com>
Date: Wed, 07 Dec 2005 22:29:51 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       lse-tech@lists.sourceforge.net,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>
Subject: [RFC][Patch 5/5] Per-task delay accounting: procfs interface
References: <43975D45.3080801@watson.ibm.com>
In-Reply-To: <43975D45.3080801@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Creates /proc/<pid>/delay interface for getting per-task
delay statistics (time spent by a task waiting for cpu,
sync block I/O completion, swapping in pages etc.) The cpu
stats are available only if CONFIG_SCHEDSTATS is enabled.

The interface allows a task's delay stats (excluding cpu)
to be reset to zero. This is particularly useful if
delay accounting is being turned on/off dynamically.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 fs/proc/base.c            |   65 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/delayacct.h |    6 ++++
 kernel/delayacct.c        |   33 +++++++++++++++++++++++
 3 files changed, 104 insertions(+)

Index: linux-2.6.15-rc5/fs/proc/base.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/proc/base.c
+++ linux-2.6.15-rc5/fs/proc/base.c
@@ -71,6 +71,8 @@
 #include <linux/cpuset.h>
 #include <linux/audit.h>
 #include <linux/poll.h>
+#include <linux/delayacct.h>
+#include <linux/kernel.h>
 #include "internal.h"

 /*
@@ -166,6 +168,10 @@ enum pid_directory_inos {
 	PROC_TID_OOM_SCORE,
 	PROC_TID_OOM_ADJUST,

+#ifdef CONFIG_TASK_DELAY_ACCT
+        PROC_TID_DELAY_ACCT,
+        PROC_TGID_DELAY_ACCT,
+#endif
 	/* Add new entries before this */
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
@@ -220,6 +226,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TGID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+#ifdef CONFIG_TASK_DELAY_ACCT
+	E(PROC_TGID_DELAY_ACCT,"delay",   S_IFREG|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -262,6 +271,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+#ifdef CONFIG_TASK_DELAY_ACCT
+	E(PROC_TID_DELAY_ACCT,"delay",   S_IFREG|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };

@@ -1066,6 +1078,53 @@ static struct file_operations proc_secco
 };
 #endif /* CONFIG_SECCOMP */

+#ifdef CONFIG_TASK_DELAY_ACCT
+ssize_t proc_delayacct_write(struct file *file, const char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	struct task_struct *tsk = proc_task(file->f_dentry->d_inode);
+	char kbuf[DELAYACCT_PROC_MAX_WRITE + 1];
+	int cmd, ret;
+
+	if (count > DELAYACCT_PROC_MAX_WRITE)
+		return -EINVAL;
+	if (copy_from_user(&kbuf, buffer, count))
+        	return -EFAULT;
+
+	cmd = simple_strtoul(kbuf, NULL, 10);
+	ret = delayacct_task_write(tsk, cmd);
+
+	if (ret)
+		return ret;
+	return count;
+}
+
+ssize_t proc_delayacct_read(struct file *file, char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	struct task_struct *tsk = proc_task(file->f_dentry->d_inode);
+	char kbuf[DELAYACCT_PROC_MAX_READ + 1];
+	size_t len;
+	loff_t __ppos = *ppos;
+
+	len = delayacct_task_read(tsk, kbuf);
+
+	if (__ppos >= len)
+		return 0;
+	if (count > len-__ppos)
+		count = len-__ppos;
+	if (copy_to_user(buffer, kbuf + __ppos, count))
+		return -EFAULT;
+	*ppos = __ppos + count;
+	return count;
+}
+
+static struct file_operations proc_delayacct_operations = {
+        .read           = proc_delayacct_read,
+        .write          = proc_delayacct_write,
+};
+#endif
+
 static void *proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
@@ -1786,6 +1845,12 @@ static struct dentry *proc_pident_lookup
 			inode->i_fop = &proc_loginuid_operations;
 			break;
 #endif
+#ifdef CONFIG_TASK_DELAY_ACCT
+		case PROC_TID_DELAY_ACCT:
+		case PROC_TGID_DELAY_ACCT:
+			inode->i_fop = &proc_delayacct_operations;
+			break;
+#endif
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
Index: linux-2.6.15-rc5/include/linux/delayacct.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/delayacct.h
+++ linux-2.6.15-rc5/include/linux/delayacct.h
@@ -16,11 +16,17 @@

 #include <linux/sched.h>

+/* Maximum data that a user can read/write from/to /proc/<tgid>/delay */
+#define DELAYACCT_PROC_MAX_READ	256
+#define DELAYACCT_PROC_MAX_WRITE	8
+
 #ifdef CONFIG_TASK_DELAY_ACCT
 extern int delayacct_on;	/* Delay accounting turned on/off */
 extern void delayacct_tsk_init(struct task_struct *tsk);
 extern void delayacct_blkio(struct timespec *start, struct timespec *end);
 extern void delayacct_swapin(struct timespec *start, struct timespec *end);
+extern int delayacct_task_write(struct task_struct *tsk, int cmd);
+extern size_t delayacct_task_read(struct task_struct *tsk, char *buf);
 #else
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {}
Index: linux-2.6.15-rc5/kernel/delayacct.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/delayacct.c
+++ linux-2.6.15-rc5/kernel/delayacct.c
@@ -13,6 +13,7 @@

 #include <linux/sched.h>
 #include <linux/time.h>
+#include <linux/delayacct.h>

 int delayacct_on;	/* Delay accounting turned on/off */

@@ -65,3 +66,35 @@ inline void delayacct_swapin(struct time
 	current->delays.swapin_count++;
 	spin_unlock(&current->delays.lock);
 }
+
+/* User writes @cmd to /proc/<tgid>/delay */
+inline int delayacct_task_write(struct task_struct *tsk, int cmd)
+{
+	if (cmd == 0) {
+		spin_lock(&tsk->delays.lock);
+		memset(&tsk->delays, 0, sizeof(tsk->delays));
+		spin_unlock(&tsk->delays.lock);
+	}
+	return 0;
+}
+
+/* User reads from /proc/<tgid>/delay */
+inline size_t delayacct_task_read(struct task_struct *tsk, char *buf)
+{
+	unsigned long long run_delay = 0;
+	unsigned long run_count = 0;
+
+#ifdef CONFIG_SCHEDSTATS
+	run_delay = jiffies_to_usecs(tsk->sched_info.run_delay) * 1000;
+	run_count = tsk->sched_info.pcnt ;
+#endif
+	return snprintf(buf, DELAYACCT_PROC_MAX_READ,
+		 "%lu %llu %llu %u %llu %u %llu\n",
+		 run_count,
+		 (uint64_t) current_sched_time(tsk),
+		 (uint64_t) run_delay,
+		 (unsigned int) tsk->delays.blkio_count,
+		 (uint64_t) tsk->delays.blkio_delay,
+		 (unsigned int) tsk->delays.swapin_count,
+		 (uint64_t) tsk->delays.swapin_delay);
+}
