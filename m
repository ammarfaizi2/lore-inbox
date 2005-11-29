Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVK2AN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVK2AN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 19:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVK2AN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 19:13:26 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:42067 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932312AbVK2ANZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 19:13:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=KZZ0Q6JXBkNeKQ9Eukur00bamrhNKqOMjCLxKeVwwKV2luAElXfoU3LeHra83UjxMKmA40ncOOcvUE1p0hbox3j/up9sxC9jZ8stA+p9vm+9CWI5dwREt8S5hT51adUBUOmO2oRobQ/enaJPhRDESXAy5vmwi+hKquRWwdOYRA0=
Date: Tue, 29 Nov 2005 03:28:02 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] un petite hack: /proc/*/ctl
Message-ID: <20051129002801.GA9785@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

echo kill >/proc/$PID/ctl
	send SIGKILL to process

echo term >/proc/$PID/ctl
	send SIGTERM to process

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -71,6 +71,7 @@
 #include <linux/cpuset.h>
 #include <linux/audit.h>
 #include <linux/poll.h>
+#include <linux/syscalls.h>
 #include "internal.h"
 
 /*
@@ -125,6 +126,7 @@ enum pid_directory_inos {
 #endif
 	PROC_TGID_OOM_SCORE,
 	PROC_TGID_OOM_ADJUST,
+	PROC_TGID_CTL,
 	PROC_TID_INO,
 	PROC_TID_STATUS,
 	PROC_TID_MEM,
@@ -165,6 +167,7 @@ enum pid_directory_inos {
 #endif
 	PROC_TID_OOM_SCORE,
 	PROC_TID_OOM_ADJUST,
+	PROC_TID_CTL,
 
 	/* Add new entries before this */
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
@@ -220,6 +223,7 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TGID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+	E(PROC_TGID_CTL,       "ctl",     S_IFREG|S_IWUSR),
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -262,6 +266,7 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+	E(PROC_TID_CTL,        "ctl",     S_IFREG|S_IWUSR),
 	{0,0,NULL,0}
 };
 
@@ -942,6 +947,42 @@ static struct file_operations proc_oom_a
 	.write		= oom_adjust_write,
 };
 
+static ssize_t ctl_write(struct file *file, const char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	char __buf[5];
+	struct task_struct *task;
+	int sig;
+
+	count = min(count, sizeof(__buf));
+	memset(__buf, 0, sizeof(__buf));
+	if (copy_from_user(__buf, buf, count))
+		return -EFAULT;
+	__buf[sizeof(__buf) - 1] = '\0';
+
+enum {
+	CONFIG_BOFH = 0,
+};
+
+	if (strcmp(__buf, "kill") == 0)
+		sig = SIGKILL;
+	else if (CONFIG_BOFH && strcmp(__buf, "FOAD") == 0)
+		sig = SIGKILL;
+	else if (strcmp(__buf, "term") == 0)
+		sig = SIGTERM;
+	else
+		goto exit;
+
+	task = proc_task(file->f_dentry->d_inode);
+	sys_kill(task->pid, sig);
+exit:
+	return count;
+}
+
+static struct file_operations proc_ctl_operations = {
+	.write		= ctl_write,
+};
+
 static struct inode_operations proc_mem_inode_operations = {
 	.permission	= proc_permission,
 };
@@ -1780,6 +1821,10 @@ static struct dentry *proc_pident_lookup
 		case PROC_TGID_OOM_ADJUST:
 			inode->i_fop = &proc_oom_adjust_operations;
 			break;
+		case PROC_TID_CTL:
+		case PROC_TGID_CTL:
+			inode->i_fop = &proc_ctl_operations;
+			break;
 #ifdef CONFIG_AUDITSYSCALL
 		case PROC_TID_LOGINUID:
 		case PROC_TGID_LOGINUID:

