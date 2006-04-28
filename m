Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWD1Bew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWD1Bew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWD1Bew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:34:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:47318 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030239AbWD1Bep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:34:45 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:34:43 -0700
Message-Id: <20060428013443.27212.13392.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
References: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
Subject: [PATCH 06/12] Add proc interface to get resource group info of task
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06/12: task_procsupport

Adds an interface in /proc to get the name of a resource group to which
a task is attached.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>

 fs/proc/base.c            |   19 +++++++++++++++++++
 include/linux/res_group.h |    2 ++
 kernel/res_group/task.c   |   32 +++++++++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

Index: linux-2617-rc3/fs/proc/base.c
===================================================================
--- linux-2617-rc3.orig/fs/proc/base.c	2006-04-27 09:18:03.000000000 -0700
+++ linux-2617-rc3/fs/proc/base.c	2006-04-27 09:22:27.000000000 -0700
@@ -70,6 +70,7 @@
 #include <linux/ptrace.h>
 #include <linux/seccomp.h>
 #include <linux/cpuset.h>
+#include <linux/res_group.h>
 #include <linux/audit.h>
 #include <linux/poll.h>
 #include "internal.h"
@@ -115,6 +116,9 @@ enum pid_directory_inos {
 #ifdef CONFIG_CPUSETS
 	PROC_TGID_CPUSET,
 #endif
+#ifdef CONFIG_RES_GROUPS
+	PROC_TGID_RES_GROUP,
+#endif
 #ifdef CONFIG_SECURITY
 	PROC_TGID_ATTR,
 	PROC_TGID_ATTR_CURRENT,
@@ -156,6 +160,9 @@ enum pid_directory_inos {
 #ifdef CONFIG_CPUSETS
 	PROC_TID_CPUSET,
 #endif
+#ifdef CONFIG_RES_GROUPS
+	PROC_TID_RES_GROUP,
+#endif
 #ifdef CONFIG_SECURITY
 	PROC_TID_ATTR,
 	PROC_TID_ATTR_CURRENT,
@@ -219,6 +226,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_CPUSETS
 	E(PROC_TGID_CPUSET,    "cpuset",  S_IFREG|S_IRUGO),
 #endif
+#ifdef CONFIG_RES_GROUPS
+	E(PROC_TGID_RES_GROUP,"res_group",S_IFREG|S_IRUGO),
+#endif
 	E(PROC_TGID_OOM_SCORE, "oom_score",S_IFREG|S_IRUGO),
 	E(PROC_TGID_OOM_ADJUST,"oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
 #ifdef CONFIG_AUDITSYSCALL
@@ -261,6 +271,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_CPUSETS
 	E(PROC_TID_CPUSET,     "cpuset",  S_IFREG|S_IRUGO),
 #endif
+#ifdef CONFIG_RES_GROUPS
+	E(PROC_TID_RES_GROUP, "res_group",S_IFREG|S_IRUGO),
+#endif
 	E(PROC_TID_OOM_SCORE,  "oom_score",S_IFREG|S_IRUGO),
 	E(PROC_TID_OOM_ADJUST, "oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
 #ifdef CONFIG_AUDITSYSCALL
@@ -1823,6 +1836,12 @@ static struct dentry *proc_pident_lookup
 			inode->i_fop = &proc_cpuset_operations;
 			break;
 #endif
+#ifdef CONFIG_RES_GROUPS
+		case PROC_TID_RES_GROUP:
+		case PROC_TGID_RES_GROUP:
+			inode->i_fop = &proc_res_group_operations;
+			break;
+#endif
 		case PROC_TID_OOM_SCORE:
 		case PROC_TGID_OOM_SCORE:
 			inode->i_fop = &proc_info_file_operations;
Index: linux-2617-rc3/kernel/res_group/task.c
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/task.c	2006-04-27 09:22:20.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/task.c	2006-04-27 09:22:27.000000000 -0700
@@ -13,7 +13,8 @@
  * (at your option) any later version.
  *
  */
-#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
 #include <linux/module.h>
 #include "local.h"
 
@@ -194,4 +195,33 @@ next_task:
 	kref_put(&rgroup->ref, release_res_group);
 }
 
+static int proc_res_group_show(struct seq_file *m, void *v)
+{
+	struct task_struct *tsk = m->private;
+	struct resource_group *rgroup = tsk->res_group;
+
+	if (!rgroup)
+		return -EINVAL;
+
+	kref_get(&rgroup->ref);
+	seq_puts(m, "/");
+	if (!is_res_group_root(rgroup))
+		seq_puts(m, rgroup->name);
+	seq_putc(m, '\n');
+	kref_put(&rgroup->ref, release_res_group);
+	return 0;
+}
+
+static int res_group_open(struct inode *inode, struct file *file)
+{
+	struct task_struct *tsk = PROC_I(inode)->task;
+	return single_open(file, proc_res_group_show, tsk);
+}
+
+struct file_operations proc_res_group_operations = {
+	.open		= res_group_open,
+	.read		= seq_read,
+	.llseek 	= seq_lseek,
+	.release	= single_release,
+};
 EXPORT_SYMBOL_GPL(set_res_group);
Index: linux-2617-rc3/include/linux/res_group.h
===================================================================
--- linux-2617-rc3.orig/include/linux/res_group.h	2006-04-27 09:22:20.000000000 -0700
+++ linux-2617-rc3/include/linux/res_group.h	2006-04-27 09:22:27.000000000 -0700
@@ -94,6 +94,8 @@ struct resource_group {
 	struct list_head children;	/* head of children */
 };
 
+extern struct file_operations proc_res_group_operations;
+
 extern void init_task_res_group(struct task_struct *);
 extern void clear_task_res_group(struct task_struct *);
 extern void res_group_init(void);

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
