Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422794AbWJLHoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422794AbWJLHoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422801AbWJLHoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:44:00 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:12718 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422794AbWJLHnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:43:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:references:user-agent:date:from:to:cc:subject:content-disposition:message-id;
        b=IkVE3qqKOAbS7N7vQ/WxO96ZBMQbzfma4fEPrktN0qHD8Bq7rj/2lELl1OenhvpLhJRn1EHXwLJ0MSNKMoUcFoKTg/YWbldsyD6f0tw4QWXgv49g0MYCfU7g81uO/MKBgYQ/jWAotnVDMRtLl8VMRYxFoXJuPFTwS7RmnVWDX9Y=
References: <20061012074305.047696736@gmail.com>>
User-Agent: quilt/0.45-1
Date: Thu, 12 Oct 2006 16:43:11 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>
Subject: [patch 6/7] process filtering for fault-injection capabilities
Content-Disposition: inline; filename=process-filter.patch
Message-ID: <452df238.04819267.55ff.ffffd8a2@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

This patch provides process filtering feature.
The process filter allows failing only permitted processes
by /proc/<pid>/make-it-fail

Please see the example that demostrates how to inject slab allocation
failures into module init/cleanup code
in Documentation/fault-injection/fault-injection.txt

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 fs/proc/base.c               |   65 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fault-inject.h |    2 +
 include/linux/sched.h        |    3 +
 lib/fault-inject.c           |   19 ++++++++++++
 4 files changed, 89 insertions(+)

Index: work-fault-inject/fs/proc/base.c
===================================================================
--- work-fault-inject.orig/fs/proc/base.c
+++ work-fault-inject/fs/proc/base.c
@@ -776,6 +776,65 @@ static struct file_operations proc_login
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
@@ -1788,6 +1847,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_AUDITSYSCALL
 	REG("loginuid",   S_IWUSR|S_IRUGO, loginuid),
 #endif
+#ifdef CONFIG_FAULT_INJECTION
+	REG("make-it-fail", S_IRUGO|S_IWUSR, fault_inject),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file * filp,
@@ -2062,6 +2124,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_AUDITSYSCALL
 	REG("loginuid",  S_IWUSR|S_IRUGO, loginuid),
 #endif
+#ifdef CONFIG_FAULT_INJECTION
+	REG("make-it-fail", S_IRUGO|S_IWUSR, fault_inject),
+#endif
 };
 
 static int proc_tid_base_readdir(struct file * filp,
Index: work-fault-inject/include/linux/sched.h
===================================================================
--- work-fault-inject.orig/include/linux/sched.h
+++ work-fault-inject/include/linux/sched.h
@@ -1051,6 +1051,9 @@ struct task_struct {
 #ifdef	CONFIG_TASK_DELAY_ACCT
 	struct task_delay_info *delays;
 #endif
+#ifdef CONFIG_FAULT_INJECTION
+	int make_it_fail;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: work-fault-inject/include/linux/fault-inject.h
===================================================================
--- work-fault-inject.orig/include/linux/fault-inject.h
+++ work-fault-inject/include/linux/fault-inject.h
@@ -17,6 +17,7 @@ struct fault_attr {
 	atomic_t times;
 	atomic_t space;
 	unsigned long verbose;
+	u32 task_filter;
 
 	unsigned long count;
 
@@ -30,6 +31,7 @@ struct fault_attr {
 		struct dentry *times_file;
 		struct dentry *space_file;
 		struct dentry *verbose_file;
+		struct dentry *task_filter_file;
 	} entries;
 
 #endif
Index: work-fault-inject/lib/fault-inject.c
===================================================================
--- work-fault-inject.orig/lib/fault-inject.c
+++ work-fault-inject/lib/fault-inject.c
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
 #include <linux/fault-inject.h>
 
 int setup_fault_attr(struct fault_attr *attr, char *str)
@@ -58,6 +59,11 @@ static void fail_dump(struct fault_attr 
 		dump_stack();
 }
 
+static int fail_task(struct fault_attr *attr, struct task_struct *task)
+{
+	return !in_interrupt() && task->make_it_fail;
+}
+
 /*
  * This code is stolen from failmalloc-1.0
  * http://www.nongnu.org/failmalloc/
@@ -65,6 +71,9 @@ static void fail_dump(struct fault_attr 
 
 int should_fail(struct fault_attr *attr, ssize_t size)
 {
+	if (attr->task_filter && !fail_task(attr, current))
+		return 0;
+
 	if (atomic_read(&max_failures(attr)) == 0)
 		return 0;
 
@@ -155,6 +164,10 @@ void cleanup_fault_attr_entries(struct f
 			debugfs_remove(attr->entries.verbose_file);
 			attr->entries.verbose_file = NULL;
 		}
+		if (attr->entries.task_filter_file) {
+			debugfs_remove(attr->entries.task_filter_file);
+			attr->entries.task_filter_file = NULL;
+		}
 		debugfs_remove(attr->entries.dir);
 		attr->entries.dir = NULL;
 	}
@@ -198,6 +211,12 @@ int init_fault_attr_entries(struct fault
 		goto fail;
 	attr->entries.verbose_file = file;
 
+	file = debugfs_create_bool("task-filter", mode, dir,
+				   &attr->task_filter);
+	if (!file)
+		goto fail;
+	attr->entries.task_filter_file = file;
+
 	return 0;
 fail:
 	cleanup_fault_attr_entries(attr);

--
