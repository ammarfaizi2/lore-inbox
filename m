Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWDUCcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWDUCcv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWDUCZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:25:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:13007 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750851AbWDUCYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:24:46 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:24:45 -0700
Message-Id: <20060421022445.6145.79833.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 06/12] Add proc interface to get class info of task
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06/12: ckrm_tasksupport_procsupport

Adds an interface in /proc to get the class name of a task.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>

 fs/proc/base.c          |   19 +++++++++++++++++++
 include/linux/ckrm.h    |    2 ++
 kernel/ckrm/ckrm_task.c |   32 +++++++++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

Index: linux2617-rc2/fs/proc/base.c
===================================================================
--- linux2617-rc2.orig/fs/proc/base.c
+++ linux2617-rc2/fs/proc/base.c
@@ -70,6 +70,7 @@
 #include <linux/ptrace.h>
 #include <linux/seccomp.h>
 #include <linux/cpuset.h>
+#include <linux/ckrm.h>
 #include <linux/audit.h>
 #include <linux/poll.h>
 #include "internal.h"
@@ -115,6 +116,9 @@ enum pid_directory_inos {
 #ifdef CONFIG_CPUSETS
 	PROC_TGID_CPUSET,
 #endif
+#ifdef CONFIG_CKRM
+	PROC_TGID_CKRM_CLASS,
+#endif
 #ifdef CONFIG_SECURITY
 	PROC_TGID_ATTR,
 	PROC_TGID_ATTR_CURRENT,
@@ -156,6 +160,9 @@ enum pid_directory_inos {
 #ifdef CONFIG_CPUSETS
 	PROC_TID_CPUSET,
 #endif
+#ifdef CONFIG_CKRM
+	PROC_TID_CKRM_CLASS,
+#endif
 #ifdef CONFIG_SECURITY
 	PROC_TID_ATTR,
 	PROC_TID_ATTR_CURRENT,
@@ -219,6 +226,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_CPUSETS
 	E(PROC_TGID_CPUSET,    "cpuset",  S_IFREG|S_IRUGO),
 #endif
+#ifdef CONFIG_CKRM
+	E(PROC_TGID_CKRM_CLASS,"ckrm_class",S_IFREG|S_IRUGO),
+#endif
 	E(PROC_TGID_OOM_SCORE, "oom_score",S_IFREG|S_IRUGO),
 	E(PROC_TGID_OOM_ADJUST,"oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
 #ifdef CONFIG_AUDITSYSCALL
@@ -261,6 +271,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_CPUSETS
 	E(PROC_TID_CPUSET,     "cpuset",  S_IFREG|S_IRUGO),
 #endif
+#ifdef CONFIG_CKRM
+	E(PROC_TID_CKRM_CLASS, "ckrm_class",S_IFREG|S_IRUGO),
+#endif
 	E(PROC_TID_OOM_SCORE,  "oom_score",S_IFREG|S_IRUGO),
 	E(PROC_TID_OOM_ADJUST, "oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
 #ifdef CONFIG_AUDITSYSCALL
@@ -1814,6 +1827,12 @@ static struct dentry *proc_pident_lookup
 			inode->i_fop = &proc_cpuset_operations;
 			break;
 #endif
+#ifdef CONFIG_CKRM
+		case PROC_TID_CKRM_CLASS:
+		case PROC_TGID_CKRM_CLASS:
+			inode->i_fop = &proc_ckrm_class_operations;
+			break;
+#endif
 		case PROC_TID_OOM_SCORE:
 		case PROC_TGID_OOM_SCORE:
 			inode->i_fop = &proc_info_file_operations;
Index: linux2617-rc2/kernel/ckrm/ckrm_task.c
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm_task.c
+++ linux2617-rc2/kernel/ckrm/ckrm_task.c
@@ -13,7 +13,8 @@
  * (at your option) any later version.
  *
  */
-#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
 #include <linux/module.h>
 #include "ckrm_local.h"
 
@@ -193,4 +194,33 @@ next_task:
 	kref_put(&class->ref, ckrm_release_class);
 }
 
+static int proc_ckrm_class_show(struct seq_file *m, void *v)
+{
+	struct task_struct *tsk = m->private;
+	struct ckrm_class *class = tsk->class;
+
+	if (!class)
+		return -EINVAL;
+
+	kref_get(&class->ref);
+	seq_puts(m, "/");
+	if (!ckrm_is_class_root(class))
+		seq_puts(m, class->name);
+	seq_putc(m, '\n');
+	kref_put(&class->ref, ckrm_release_class);
+	return 0;
+}
+
+static int ckrm_class_open(struct inode *inode, struct file *file)
+{
+	struct task_struct *tsk = PROC_I(inode)->task;
+	return single_open(file, proc_ckrm_class_show, tsk);
+}
+
+struct file_operations proc_ckrm_class_operations = {
+	.open		= ckrm_class_open,
+	.read		= seq_read,
+	.llseek 	= seq_lseek,
+	.release	= single_release,
+};
 EXPORT_SYMBOL_GPL(ckrm_setclass);
Index: linux2617-rc2/include/linux/ckrm.h
===================================================================
--- linux2617-rc2.orig/include/linux/ckrm.h
+++ linux2617-rc2/include/linux/ckrm.h
@@ -94,6 +94,8 @@ struct ckrm_class {
 	struct list_head children;	/* head of children */
 };
 
+extern struct file_operations proc_ckrm_class_operations;
+
 extern void ckrm_init_task(struct task_struct *);
 extern void ckrm_clear_task(struct task_struct *);
 extern void ckrm_init(void);

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
