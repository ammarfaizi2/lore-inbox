Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVARUpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVARUpY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 15:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVARUpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 15:45:23 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:35285 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S261412AbVARUo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 15:44:57 -0500
Date: Tue, 18 Jan 2005 15:44:57 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] /proc/<pid>/rlimit
Message-ID: <20050118204457.GA7824@ti64.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.11-rc1-bk6 adds /proc/<pid>/rlimit to export
per-process resource limit settings.  It was written to help analyze
daemon core dump size settings, but may be more generally useful.
Tested on 2.6.10. Sample output:

	root@tiny ~ # cat /proc/$$/rlimit
	cpu unlimited unlimited
	fsize unlimited unlimited
	data unlimited unlimited
	stack 8388608 unlimited
	core 0 unlimited
	rss unlimited unlimited
	nproc 111 111
	nofile 1024 1024
	memlock 32768 32768
	as unlimited unlimited
	locks unlimited unlimited
	sigpending 1024 1024
	msgqueue 819200 819200

Feedback welcome.

Signed-off-by: Bill Rugolsky <brugolsky@telemetry-investments.com>

--- linux-2.6.11-rc1-bk6/fs/proc/base.c.rlimit	2005-01-18 15:01:10.120960254 -0500
+++ linux-2.6.11-rc1-bk6/fs/proc/base.c	2005-01-18 15:07:28.102661832 -0500
@@ -32,6 +32,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/resource.h>
 #include "internal.h"
 
 /*
@@ -61,6 +62,7 @@
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
+	PROC_TGID_RLIMIT,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TGID_SCHEDSTAT,
 #endif
@@ -87,6 +89,7 @@
 	PROC_TID_MAPS,
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
+	PROC_TID_RLIMIT,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TID_SCHEDSTAT,
 #endif
@@ -124,6 +127,7 @@
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TGID_RLIMIT,    "rlimit",  S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -149,6 +153,7 @@
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TID_RLIMIT,     "rlimit",  S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -496,6 +501,107 @@
 	.release	= mounts_release,
 };
 
+const char * const rlim_name[RLIM_NLIMITS] = {
+#ifdef RLIMIT_CPU
+	[RLIMIT_CPU] = "cpu",
+#endif
+#ifdef RLIMIT_FSIZE
+	[RLIMIT_FSIZE] = "fsize",
+#endif
+#ifdef RLIMIT_DATA
+	[RLIMIT_DATA] =  "data",
+#endif
+#ifdef RLIMIT_STACK
+	[RLIMIT_STACK] = "stack",
+#endif
+#ifdef RLIMIT_CORE
+	[RLIMIT_CORE] = "core",
+#endif
+#ifdef RLIMIT_RSS
+	[RLIMIT_RSS] = "rss",
+#endif
+#ifdef RLIMIT_NPROC
+	[RLIMIT_NPROC] = "nproc",
+#endif
+#ifdef RLIMIT_NOFILE
+	[RLIMIT_NOFILE] = "nofile",
+#endif
+#ifdef RLIMIT_MEMLOCK
+	[RLIMIT_MEMLOCK] = "memlock",
+#endif
+#ifdef RLIMIT_AS
+	[RLIMIT_AS] = "as",
+#endif
+#ifdef RLIMIT_LOCKS
+	[RLIMIT_LOCKS] = "locks",
+#endif
+#ifdef RLIMIT_SIGPENDING
+	[RLIMIT_SIGPENDING] = "sigpending",
+#endif
+#ifdef RLIMIT_MSGQUEUE
+	[RLIMIT_MSGQUEUE] = "msgqueue",
+#endif
+};
+
+static int rlimit_show(struct seq_file *s, void *v)
+{
+	struct rlimit *rlim = (struct rlimit *) s->private;
+	int i;
+
+	for (i = 0 ; i < RLIM_NLIMITS ; i++) {
+		if (rlim_name[i] != NULL)
+			seq_puts(s, rlim_name[i]);
+		else
+			seq_printf(s, "rlimit-%d", i);
+
+		if (rlim[i].rlim_cur == RLIM_INFINITY)
+			seq_puts(s, " unlimited");
+		else
+			seq_printf(s, " %lu", (unsigned long)rlim[i].rlim_cur);
+
+		if (rlim[i].rlim_max == RLIM_INFINITY)
+			seq_puts(s, " unlimited\n");
+		else
+			seq_printf(s, " %lu\n", (unsigned long)rlim[i].rlim_max);
+	}
+		return 0;
+}
+
+static int rlimit_open(struct inode *inode, struct file *file)
+{
+	struct task_struct *task = proc_task(inode);
+	struct rlimit *rlim = kmalloc(RLIM_NLIMITS * sizeof (struct rlimit), GFP_KERNEL);
+	int ret;
+
+	if (!rlim)
+		return -ENOMEM;
+
+	task_lock(task->group_leader);
+	memcpy(rlim, task->signal->rlim, RLIM_NLIMITS * sizeof (struct rlimit));
+	task_unlock(task->group_leader);
+
+	ret = single_open(file, rlimit_show, rlim);
+
+	if (ret)
+		kfree(rlim);
+
+	return ret;
+}
+
+static int rlimit_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *s = file->private_data;
+	kfree(s->private);
+	return single_release(inode, file);
+}
+
+static struct file_operations proc_rlimit_operations = {
+	.open		= rlimit_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= rlimit_release,
+};
+
 #define PROC_BLOCK_SIZE	(3*1024)		/* 4K page size but our output routines use some slack for overruns */
 
 static ssize_t proc_info_read(struct file * file, char __user * buf,
@@ -1300,6 +1406,10 @@
 		case PROC_TGID_MOUNTS:
 			inode->i_fop = &proc_mounts_operations;
 			break;
+		case PROC_TID_RLIMIT:
+		case PROC_TGID_RLIMIT:
+			inode->i_fop = &proc_rlimit_operations;
+			break;
 #ifdef CONFIG_SECURITY
 		case PROC_TID_ATTR:
 			inode->i_nlink = 2;
