Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWHaKKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWHaKKM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWHaKIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:08:50 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:2836 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751420AbWHaKIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:08:45 -0400
Message-Id: <20060831100821.807784048@localhost.localdomain>
References: <20060831100756.866727476@localhost.localdomain>
Date: Thu, 31 Aug 2006 19:08:02 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, okuji@enbug.org
Subject: [patch 6/6] process filtering for fault-injection capabilities
Content-Disposition: inline; filename=process-filter.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides process filtering feature.

Example:

# modprobe should_fail_knobs
# echo 1 > /debug/failslab/process-filter
# echo 30 > /debug/failslab/probability
# find /lib/modules/`uname -r` -name '*.ko' -exec basename {} .ko \; > list
# for i in `cat list`;do failmodprobe $i;done

failmodprobe:
-------------
#!/bin/bash
echo 1 > /proc/self/make-it-fail
exec modprobe $*

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 fs/proc/base.c              |   77 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h       |    3 +
 include/linux/should_fail.h |    3 +
 lib/should_fail.c           |   11 ++++--
 lib/should_fail_knobs.c     |   10 +++++
 5 files changed, 101 insertions(+), 3 deletions(-)

Index: work-shouldfail/fs/proc/base.c
===================================================================
--- work-shouldfail.orig/fs/proc/base.c
+++ work-shouldfail/fs/proc/base.c
@@ -138,6 +138,9 @@ enum pid_directory_inos {
 #endif
 	PROC_TGID_OOM_SCORE,
 	PROC_TGID_OOM_ADJUST,
+#ifdef CONFIG_SHOULD_FAIL
+	PROC_TGID_SHOULD_FAIL,
+#endif
 	PROC_TID_INO,
 	PROC_TID_STATUS,
 	PROC_TID_MEM,
@@ -181,6 +184,9 @@ enum pid_directory_inos {
 #endif
 	PROC_TID_OOM_SCORE,
 	PROC_TID_OOM_ADJUST,
+#ifdef CONFIG_SHOULD_FAIL
+	PROC_TID_SHOULD_FAIL,
+#endif
 
 	/* Add new entries before this */
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
@@ -240,6 +246,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TGID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+#ifdef CONFIG_SHOULD_FAIL
+	E(PROC_TGID_SHOULD_FAIL, "make-it-fail", S_IFREG|S_IWUSR|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -282,6 +291,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+#ifdef CONFIG_SHOULD_FAIL
+	E(PROC_TID_SHOULD_FAIL, "make-it-fail", S_IFREG|S_IWUSR|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 
@@ -992,6 +1004,65 @@ static struct file_operations proc_login
 };
 #endif
 
+#ifdef CONFIG_SHOULD_FAIL
+static ssize_t proc_should_fail_read(struct file * file, char __user * buf,
+				     size_t count, loff_t *ppos)
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
+static ssize_t proc_should_fail_write(struct file * file,
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
+static struct file_operations proc_should_fail_operations = {
+	.read		= proc_should_fail_read,
+	.write		= proc_should_fail_write,
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
+#ifdef CONFIG_SHOULD_FAIL
+		case PROC_TID_SHOULD_FAIL:
+		case PROC_TGID_SHOULD_FAIL:
+			inode->i_fop = &proc_should_fail_operations;
+			break;
+#endif
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
Index: work-shouldfail/include/linux/sched.h
===================================================================
--- work-shouldfail.orig/include/linux/sched.h
+++ work-shouldfail/include/linux/sched.h
@@ -997,6 +997,9 @@ struct task_struct {
 	spinlock_t delays_lock;
 	struct task_delay_info *delays;
 #endif
+#ifdef CONFIG_SHOULD_FAIL
+	int make_it_fail;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: work-shouldfail/include/linux/should_fail.h
===================================================================
--- work-shouldfail.orig/include/linux/should_fail.h
+++ work-shouldfail/include/linux/should_fail.h
@@ -27,6 +27,9 @@ struct should_fail_data {
 	atomic_t space;
 
 	unsigned long count;
+
+	/* process filter */
+	unsigned long process_filter;
 };
 
 #define DEFINE_SHOULD_FAIL(name) \
Index: work-shouldfail/lib/should_fail.c
===================================================================
--- work-shouldfail.orig/lib/should_fail.c
+++ work-shouldfail/lib/should_fail.c
@@ -13,16 +13,18 @@ int setup_should_fail(struct should_fail
 	unsigned long interval;
 	int times;
 	int space;
+	unsigned long filter;
 
-	/* "<probability>,<interval>,<times>,<space>" */
-	if (sscanf(str, "%lu,%lu,%d,%d", &probability, &interval, &times,
-		   &space) < 4)
+	/* "<probability>,<interval>,<times>,<space>,<process-filter>" */
+	if (sscanf(str, "%lu,%lu,%d,%d,%d", &probability, &interval, &times,
+		   &space, &filter) < 5)
 		return 0;
 
 	data->probability = probability;
 	data->interval = interval;
 	atomic_set(&data->times, times);
 	atomic_set(&data->space, space);
+	data->process_filter = filter;
 
 	return 1;
 }
@@ -54,6 +56,9 @@ void should_fail_srandom(unsigned long e
 
 int should_fail(struct should_fail_data *data, ssize_t size)
 {
+	if (data->process_filter && !current->make_it_fail)
+		return 0;
+
 	if (atomic_read(&max_failures(data)) == 0)
 		return 0;
 
Index: work-shouldfail/lib/should_fail_knobs.c
===================================================================
--- work-shouldfail.orig/lib/should_fail_knobs.c
+++ work-shouldfail/lib/should_fail_knobs.c
@@ -8,6 +8,7 @@ struct should_fail_knobs {
 	struct dentry *interval_file;
 	struct dentry *times_file;
 	struct dentry *space_file;
+	struct dentry *filter_file;
 };
 
 static void debugfs_ul_set(void *data, u64 val)
@@ -66,6 +67,10 @@ static void cleanup_should_fail_knobs(st
 			debugfs_remove(knobs->space_file);
 			knobs->space_file = NULL;
 		}
+		if (knobs->filter_file) {
+			debugfs_remove(knobs->filter_file);
+			knobs->filter_file = NULL;
+		}
 		debugfs_remove(knobs->dir);
 		knobs->dir = NULL;
 	}
@@ -105,6 +110,11 @@ static int init_should_fail_knobs(struct
 		goto fail;
 	knobs->space_file = file;
 
+	file = debugfs_create_ul("process-filter", mode, dir, &data->process_filter);
+	if (!file)
+		goto fail;
+	knobs->filter_file = file;
+
 	return 0;
 fail:
 	cleanup_should_fail_knobs(knobs);

--
