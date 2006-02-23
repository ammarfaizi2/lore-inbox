Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWBWQOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWBWQOB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWBWQOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:14:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12183 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751595AbWBWQN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:13:59 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/23] proc: Move proc_maps_operations into task_mmu.c
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1fymahxwr.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqwyhxua.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j7mhxs0.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biahxpd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0aqgiyv.fsf_-_@ebiederm.dsl.xmission.com>
	<m1pslegiwg.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkw2giue.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hd6qgirv.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5heginy.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:12:52 -0700
In-Reply-To: <m1d5heginy.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:10:41 -0700")
Message-ID: <m18xs2gikb.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All of the functions for proc_maps_operations are already
defined in task_mmu.c so move the operations structure to
keep the functionality together.

Since task_nommu.c implements a dummy version of
/proc/<pid>/maps give it a simplified version
of proc_maps_operations that it can modify
to best suit its needs.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c       |   61 --------------------------------------------------
 fs/proc/internal.h   |    4 +++
 fs/proc/task_mmu.c   |   54 ++++++++++++++++++++++++++++++++++++++++++--
 fs/proc/task_nommu.c |   21 ++++++++++++++++-
 4 files changed, 75 insertions(+), 65 deletions(-)

b5c8957160dd4dd4a680f3bc99cdcda6af7bf1de
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1a39258..4bdc859 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -489,67 +489,6 @@ static int proc_oom_score(struct task_st
 /*                       Here the fs part begins                        */
 /************************************************************************/
 
-extern struct seq_operations proc_pid_maps_op;
-static int maps_open(struct inode *inode, struct file *file)
-{
-	struct task_struct *task = proc_task(inode);
-	int ret = seq_open(file, &proc_pid_maps_op);
-	if (!ret) {
-		struct seq_file *m = file->private_data;
-		m->private = task;
-	}
-	return ret;
-}
-
-static struct file_operations proc_maps_operations = {
-	.open		= maps_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-#ifdef CONFIG_NUMA
-extern struct seq_operations proc_pid_numa_maps_op;
-static int numa_maps_open(struct inode *inode, struct file *file)
-{
-	struct task_struct *task = proc_task(inode);
-	int ret = seq_open(file, &proc_pid_numa_maps_op);
-	if (!ret) {
-		struct seq_file *m = file->private_data;
-		m->private = task;
-	}
-	return ret;
-}
-
-static struct file_operations proc_numa_maps_operations = {
-	.open		= numa_maps_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-#endif
-
-#ifdef CONFIG_MMU
-extern struct seq_operations proc_pid_smaps_op;
-static int smaps_open(struct inode *inode, struct file *file)
-{
-	struct task_struct *task = proc_task(inode);
-	int ret = seq_open(file, &proc_pid_smaps_op);
-	if (!ret) {
-		struct seq_file *m = file->private_data;
-		m->private = task;
-	}
-	return ret;
-}
-
-static struct file_operations proc_smaps_operations = {
-	.open		= smaps_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-#endif
-
 extern struct seq_operations mounts_op;
 struct proc_mounts {
 	struct seq_file m;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 8ea21d3..ac95bfc 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -37,6 +37,10 @@ extern int proc_tgid_stat(struct task_st
 extern int proc_pid_status(struct task_struct *, char *);
 extern int proc_pid_statm(struct task_struct *, char *);
 
+extern struct file_operations proc_maps_operations;
+extern struct file_operations proc_numa_maps_operations;
+extern struct file_operations proc_smaps_operations;
+
 void free_proc_entry(struct proc_dir_entry *de);
 
 int proc_init_inodecache(void);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 0eaad41..56cd932 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -375,27 +375,75 @@ static void *m_next(struct seq_file *m, 
 	return (vma != tail_vma)? tail_vma: NULL;
 }
 
-struct seq_operations proc_pid_maps_op = {
+static struct seq_operations proc_pid_maps_op = {
 	.start	= m_start,
 	.next	= m_next,
 	.stop	= m_stop,
 	.show	= show_map
 };
 
-struct seq_operations proc_pid_smaps_op = {
+static struct seq_operations proc_pid_smaps_op = {
 	.start	= m_start,
 	.next	= m_next,
 	.stop	= m_stop,
 	.show	= show_smap
 };
 
+static int do_maps_open(struct inode *inode, struct file *file, 
+			struct seq_operations *ops)
+{
+	struct task_struct *task = proc_task(inode);
+	int ret = seq_open(file, ops);
+	if (!ret) {
+		struct seq_file *m = file->private_data;
+		m->private = task;
+	}
+	return ret;
+}
+
+static int maps_open(struct inode *inode, struct file *file)
+{
+	return do_maps_open(inode, file, &proc_pid_maps_op);
+}
+
+struct file_operations proc_maps_operations = {
+	.open		= maps_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 #ifdef CONFIG_NUMA
 extern int show_numa_map(struct seq_file *m, void *v);
 
-struct seq_operations proc_pid_numa_maps_op = {
+static struct seq_operations proc_pid_numa_maps_op = {
         .start  = m_start,
         .next   = m_next,
         .stop   = m_stop,
         .show   = show_numa_map
 };
+
+static int numa_maps_open(struct inode *inode, struct file *file)
+{
+	return do_maps_open(inode, file, &proc_pid_numa_maps_op);
+}
+
+struct file_operations proc_numa_maps_operations = {
+	.open		= numa_maps_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
 #endif
+
+static int smaps_open(struct inode *inode, struct file *file)
+{
+	return do_maps_open(inode, file, &proc_pid_smaps_op);
+}
+
+struct file_operations proc_smaps_operations = {
+	.open		= smaps_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 8f68827..af69f28 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -156,9 +156,28 @@ static void *m_next(struct seq_file *m, 
 {
 	return NULL;
 }
-struct seq_operations proc_pid_maps_op = {
+static struct seq_operations proc_pid_maps_op = {
 	.start	= m_start,
 	.next	= m_next,
 	.stop	= m_stop,
 	.show	= show_map
 };
+
+static int maps_open(struct inode *inode, struct file *file)
+{
+	int ret;
+	ret = seq_open(file, &proc_pid_maps_op);
+	if (!ret) {
+		struct seq_file *m = file->private_data;
+		m->private = NULL;
+	}
+	return ret;
+}
+
+struct file_operations proc_maps_operations = {
+	.open		= maps_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
-- 
1.2.2.g709a

