Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWINKV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWINKV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWINKVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:21:55 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:15436 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750775AbWINKUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:20:35 -0400
Message-Id: <20060914102032.989190948@localhost.localdomain>
References: <20060914102012.251231177@localhost.localdomain>
Date: Thu, 14 Sep 2006 18:20:19 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 7/8] process filtering for fault-injection capabilities
Content-Disposition: inline; filename=process-filter.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides process filtering feature.
The process filter allows failing only permitted processes
by /proc/<pid>/make-it-fail

Please see the example that demostrates how to inject slab allocation
failures into module init/cleanup code
in Documentation/fault-injection/fault-injection.txt

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 fs/proc/base.c               |   77 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fault-inject.h |    3 +
 include/linux/sched.h        |    3 +
 lib/fault-inject.c           |   13 +++++++
 4 files changed, 96 insertions(+)

Index: work-shouldfail/fs/proc/base.c
===================================================================
--- work-shouldfail.orig/fs/proc/base.c
+++ work-shouldfail/fs/proc/base.c
@@ -138,6 +138,9 @@ enum pid_directory_inos {
 #endif
 	PROC_TGID_OOM_SCORE,
 	PROC_TGID_OOM_ADJUST,
+#ifdef CONFIG_FAULT_INJECTION
+	PROC_TGID_FAULT_INJECTION,
+#endif
 	PROC_TID_INO,
 	PROC_TID_STATUS,
 	PROC_TID_MEM,
@@ -181,6 +184,9 @@ enum pid_directory_inos {
 #endif
 	PROC_TID_OOM_SCORE,
 	PROC_TID_OOM_ADJUST,
+#ifdef CONFIG_FAULT_INJECTION
+	PROC_TID_FAULT_INJECTION,
+#endif
 
 	/* Add new entries before this */
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
@@ -240,6 +246,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TGID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+#ifdef CONFIG_FAULT_INJECTION
+	E(PROC_TGID_FAULT_INJECTION, "make-it-fail", S_IFREG|S_IWUSR|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -282,6 +291,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+#ifdef CONFIG_FAULT_INJECTION
+	E(PROC_TID_FAULT_INJECTION, "make-it-fail", S_IFREG|S_IWUSR|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 
@@ -992,6 +1004,65 @@ static struct file_operations proc_login
 };
 #endif
 
+#ifdef CONFIG_FAULT_INJECTION
+static ssize_t proc_fault_inject_read(struct file * file, char __user * buf,
+				      size_t count, loff_t *ppos)
+{
+	struct task_struct *task = get_proc_task(file->f_dentry->d_inode);
+	char buffer[PROC_NUMBUF];
+	size_t len;
+	int make_it_fail;
+	loff_t __ppos = *ppos;
+
+	if (!task)
+		return -ESRCH;
+	make_it_fail = task->make_it_fail;
+	put_task_struct(task);
+
+	len = snprintf(buffer, sizeof(buffer), "%i\n", make_it_fail);
+	if (__ppos >= len)
+		return 0;
+	if (count > len-__ppos)
+		count = len-__ppos;
+	if (copy_to_user(buf, buffer + __ppos, count))
+		return -EFAULT;
+	*ppos = __ppos + count;
+	return count;
+}
+
+static ssize_t proc_fault_inject_write(struct file * file,
+			const char __user * buf, size_t count, loff_t *ppos)
+{
+	struct task_struct *task;
+	char buffer[PROC_NUMBUF], *end;
+	int make_it_fail;
+
+	if (!capable(CAP_SYS_RESOURCE))
+		return -EPERM;
+	memset(buffer, 0, sizeof(buffer));
+	if (count > sizeof(buffer) - 1)
+		count = sizeof(buffer) - 1;
+	if (copy_from_user(buffer, buf, count))
+		return -EFAULT;
+	make_it_fail = simple_strtol(buffer, &end, 0);
+	if (*end == '\n')
+		end++;
+	task = get_proc_task(file->f_dentry->d_inode);
+	if (!task)
+		return -ESRCH;
+	task->make_it_fail = make_it_fail;
+	put_task_struct(task);
+	if (end - buffer == 0)
+		return -EIO;
+	return end - buffer;
+}
+
+static struct file_operations proc_fault_inject_operations = {
+	.read		= proc_fault_inject_read,
+	.write		= proc_fault_inject_write,
+};
+#endif
+
 #ifdef CONFIG_SECCOMP
 static ssize_t seccomp_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *ppos)
@@ -1834,6 +1905,12 @@ static struct dentry *proc_pident_lookup
 			inode->i_fop = &proc_loginuid_operations;
 			break;
 #endif
+#ifdef CONFIG_FAULT_INJECTION
+		case PROC_TID_FAULT_INJECTION:
+		case PROC_TGID_FAULT_INJECTION:
+			inode->i_fop = &proc_fault_inject_operations;
+			break;
+#endif
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
Index: work-shouldfail/include/linux/sched.h
===================================================================
--- work-shouldfail.orig/include/linux/sched.h
+++ work-shouldfail/include/linux/sched.h
@@ -996,6 +996,9 @@ struct task_struct {
 #ifdef	CONFIG_TASK_DELAY_ACCT
 	struct task_delay_info *delays;
 #endif
+#ifdef CONFIG_FAULT_INJECTION
+	int make_it_fail;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: work-shouldfail/include/linux/fault-inject.h
===================================================================
--- work-shouldfail.orig/include/linux/fault-inject.h
+++ work-shouldfail/include/linux/fault-inject.h
@@ -27,6 +27,9 @@ struct fault_attr {
 	atomic_t space;
 
 	unsigned long count;
+
+	/* A value of '0' means process filter is disabled. */
+	u32 process_filter;
 };
 
 #define DEFINE_FAULT_ATTR(name) \
Index: work-shouldfail/lib/fault-inject.c
===================================================================
--- work-shouldfail.orig/lib/fault-inject.c
+++ work-shouldfail/lib/fault-inject.c
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
 #include <linux/fault-inject.h>
 
 int setup_fault_attr(struct fault_attr *attr, char *str)
@@ -49,6 +50,15 @@ void should_fail_srandom(unsigned long e
 	should_fail_random();
 }
 
+static int fail_process(struct fault_attr *attr, struct task_struct *task)
+{
+	/* process filter is disabled */
+	if (!attr->process_filter)
+		return 1;
+
+	return !in_interrupt() && task->make_it_fail;
+}
+
 /*
  * This code is stolen from failmalloc-1.0
  * http://www.nongnu.org/failmalloc/
@@ -56,6 +66,9 @@ void should_fail_srandom(unsigned long e
 
 int should_fail(struct fault_attr *attr, ssize_t size)
 {
+	if (!fail_process(attr, current))
+		return 0;
+
 	if (atomic_read(&max_failures(attr)) == 0)
 		return 0;
 

--
