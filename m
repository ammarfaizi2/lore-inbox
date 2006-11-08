Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754633AbWKHRro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbWKHRro (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754631AbWKHRrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:47:43 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:23158 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754630AbWKHRrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:47:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:references:user-agent:date:from:to:cc:subject:content-disposition:message-id;
        b=cnDEI70oGTy95DAWYduW/xmvmJIHwqDAGeMgiI2PtjbXVknsUk1wd/12I93sPK3QonkcrJyGzSYYkb5IPaTK7ky8vTEiYFg+IyQmyj9Hbeg/iTNitEynsWycmVevjIcBGU8MWdk+KhSHEMl0usj0J+3DCYfYcnq+3UF0Yw5NYYY=
References: <20061108174540.976625689@gmail.com>>
User-Agent: quilt/0.45-1
Date: Thu, 09 Nov 2006 02:45:47 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>
Subject: [patch 6/7] process filtering for fault-injection capabilities
Content-Disposition: inline; filename=process-filter.patch
Message-ID: <45521839.14700f72.6873.ffffb6d8@mx.google.com>
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
 lib/fault-inject.c           |   17 ++++++++++-
 4 files changed, 86 insertions(+), 1 deletion(-)

Index: 2.6-rc/fs/proc/base.c
===================================================================
--- 2.6-rc.orig/fs/proc/base.c
+++ 2.6-rc/fs/proc/base.c
@@ -850,6 +850,65 @@ static struct file_operations proc_secco
 };
 #endif /* CONFIG_SECCOMP */
 
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
 static void *proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
@@ -1790,6 +1849,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_AUDITSYSCALL
 	REG("loginuid",   S_IWUSR|S_IRUGO, loginuid),
 #endif
+#ifdef CONFIG_FAULT_INJECTION
+	REG("make-it-fail", S_IRUGO|S_IWUSR, fault_inject),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file * filp,
@@ -2064,6 +2126,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_AUDITSYSCALL
 	REG("loginuid",  S_IWUSR|S_IRUGO, loginuid),
 #endif
+#ifdef CONFIG_FAULT_INJECTION
+	REG("make-it-fail", S_IRUGO|S_IWUSR, fault_inject),
+#endif
 };
 
 static int proc_tid_base_readdir(struct file * filp,
Index: 2.6-rc/include/linux/sched.h
===================================================================
--- 2.6-rc.orig/include/linux/sched.h
+++ 2.6-rc/include/linux/sched.h
@@ -1023,6 +1023,9 @@ struct task_struct {
 #ifdef	CONFIG_TASK_DELAY_ACCT
 	struct task_delay_info *delays;
 #endif
+#ifdef CONFIG_FAULT_INJECTION
+	int make_it_fail;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: 2.6-rc/include/linux/fault-inject.h
===================================================================
--- 2.6-rc.orig/include/linux/fault-inject.h
+++ 2.6-rc/include/linux/fault-inject.h
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
 	} dentries;
 
 #endif
Index: 2.6-rc/lib/fault-inject.c
===================================================================
--- 2.6-rc.orig/lib/fault-inject.c
+++ 2.6-rc/lib/fault-inject.c
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
 #include <linux/fault-inject.h>
 
 int setup_fault_attr(struct fault_attr *attr, char *str)
@@ -40,6 +41,11 @@ static void fail_dump(struct fault_attr 
 
 #define atomic_dec_not_zero(v)		atomic_add_unless((v), -1, 0)
 
+static int fail_task(struct fault_attr *attr, struct task_struct *task)
+{
+	return !in_interrupt() && task->make_it_fail;
+}
+
 /*
  * This code is stolen from failmalloc-1.0
  * http://www.nongnu.org/failmalloc/
@@ -47,6 +53,9 @@ static void fail_dump(struct fault_attr 
 
 int should_fail(struct fault_attr *attr, ssize_t size)
 {
+	if (attr->task_filter && !fail_task(attr, current))
+		return 0;
+
 	if (atomic_read(&attr->times) == 0)
 		return 0;
 
@@ -131,6 +140,9 @@ void cleanup_fault_attr_dentries(struct 
 	debugfs_remove(attr->dentries.verbose_file);
 	attr->dentries.verbose_file = NULL;
 
+	debugfs_remove(attr->dentries.task_filter_file);
+	attr->dentries.task_filter_file = NULL;
+
 	if (attr->dentries.dir)
 		WARN_ON(!simple_empty(attr->dentries.dir));
 
@@ -165,9 +177,12 @@ int init_fault_attr_dentries(struct faul
 	attr->dentries.verbose_file =
 		debugfs_create_ul("verbose", mode, dir, &attr->verbose);
 
+	attr->dentries.task_filter_file = debugfs_create_bool("task-filter",
+						mode, dir, &attr->task_filter);
+
 	if (!attr->dentries.probability_file || !attr->dentries.interval_file
 	    || !attr->dentries.times_file || !attr->dentries.space_file
-	    || !attr->dentries.verbose_file)
+	    || !attr->dentries.verbose_file || !attr->dentries.task_filter_file)
 		goto fail;
 
 	return 0;

--
