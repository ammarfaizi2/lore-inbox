Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWCBHIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWCBHIX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 02:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWCBHIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 02:08:23 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14826 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751191AbWCBHIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 02:08:22 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Simon.Derr@bull.net, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, ebiederm@xmission.com
Date: Wed, 01 Mar 2006 23:08:12 -0800
Message-Id: <20060302070812.15674.50176.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] Proc: move proc fs hooks from cpuset.c to proc/fs/base.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Move the generic proc file operations support for
/proc/<pid>/cpuset from kernel/cpuset.c to fs/proc/base.c.

Leave behind in kernel/cpuset.c, now as an exported function, the
cpuset specific support for this /proc/<pid>/cpuset file, which
writes the cpuset pathname of a tasks cpuset into a seq_file.

The motivation for this move is to put proc stuff in fs/proc,
while keeping cpuset stuff in kernel/cpuset.c.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 fs/proc/base.c         |   16 ++++++++++++++++
 include/linux/cpuset.h |    3 ++-
 kernel/cpuset.c        |   17 ++---------------
 3 files changed, 20 insertions(+), 16 deletions(-)

--- 2.6.16-rc5-mm2-pre1.orig/kernel/cpuset.c	2006-03-01 21:06:49.375756164 -0800
+++ 2.6.16-rc5-mm2-pre1/kernel/cpuset.c	2006-03-01 21:22:58.072838717 -0800
@@ -2368,7 +2368,7 @@ void __cpuset_memory_pressure_bump(void)
 }
 
 /*
- * proc_cpuset_show()
+ * cpuset_proc_show_path()
  *  - Print tasks cpuset path into seq_file.
  *  - Used for /proc/<pid>/cpuset.
  *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
@@ -2377,7 +2377,7 @@ void __cpuset_memory_pressure_bump(void)
  *    anyway.
  */
 
-static int proc_cpuset_show(struct seq_file *m, void *v)
+int cpuset_proc_show_path(struct seq_file *m, void *v)
 {
 	struct cpuset *cs;
 	struct task_ref *tref;
@@ -2416,19 +2416,6 @@ out:
 	return retval;
 }
 
-static int cpuset_open(struct inode *inode, struct file *file)
-{
-	struct task_ref *tref = PROC_I(inode)->tref;
-	return single_open(file, proc_cpuset_show, tref);
-}
-
-struct file_operations proc_cpuset_operations = {
-	.open		= cpuset_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 /* Display task cpus_allowed, mems_allowed in /proc/<pid>/status file. */
 char *cpuset_task_status_allowed(struct task_struct *task, char *buffer)
 {
--- 2.6.16-rc5-mm2-pre1.orig/fs/proc/base.c	2006-03-01 21:06:49.377709312 -0800
+++ 2.6.16-rc5-mm2-pre1/fs/proc/base.c	2006-03-01 21:23:54.773712871 -0800
@@ -695,6 +695,22 @@ static struct file_operations proc_info_
 	.read		= proc_info_read,
 };
 
+#ifdef CONFIG_CPUSETS
+static int cpuset_open(struct inode *inode, struct file *file)
+{
+	struct task_ref *tref = PROC_I(inode)->tref;
+
+	return single_open(file, cpuset_proc_show_path, tref);
+}
+
+static struct file_operations proc_cpuset_operations = {
+	.open		= cpuset_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif
+
 static int mem_open(struct inode* inode, struct file* file)
 {
 	file->private_data = (void*)((long)current->self_exec_id);
--- 2.6.16-rc5-mm2-pre1.orig/include/linux/cpuset.h	2006-03-01 21:06:49.378685886 -0800
+++ 2.6.16-rc5-mm2-pre1/include/linux/cpuset.h	2006-03-01 21:07:24.419141265 -0800
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/cpumask.h>
 #include <linux/nodemask.h>
+#include <linux/seq_file.h>
 
 #ifdef CONFIG_CPUSETS
 
@@ -45,7 +46,7 @@ extern int cpuset_excl_nodes_overlap(con
 extern int cpuset_memory_pressure_enabled;
 extern void __cpuset_memory_pressure_bump(void);
 
-extern struct file_operations proc_cpuset_operations;
+int cpuset_proc_show_path(struct seq_file *m, void *v);
 extern char *cpuset_task_status_allowed(struct task_struct *task, char *buffer);
 
 extern void cpuset_lock(void);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
