Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWHaVfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWHaVfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 17:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWHaVfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 17:35:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:188 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932338AbWHaVfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 17:35:50 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/4] NOMMU: Implement /proc/pid/maps for NOMMU
Date: Thu, 31 Aug 2006 22:35:30 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060831213530.29363.6372.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Implement /proc/pid/maps for NOMMU by reading the vm_area_list attached to
current->mm->context.vmlist.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 Documentation/nommu-mmap.txt |    3 ++
 fs/proc/internal.h           |    1 +
 fs/proc/nommu.c              |   20 ++++++++---
 fs/proc/task_nommu.c         |   74 ++++++++++++++++++++++++++++++++++--------
 include/linux/proc_fs.h      |    2 +
 5 files changed, 80 insertions(+), 20 deletions(-)

diff --git a/Documentation/nommu-mmap.txt b/Documentation/nommu-mmap.txt
index b88ebe4..83f4b08 100644
--- a/Documentation/nommu-mmap.txt
+++ b/Documentation/nommu-mmap.txt
@@ -116,6 +116,9 @@ FURTHER NOTES ON NO-MMU MMAP
  (*) A list of all the mappings on the system is visible through /proc/maps in
      no-MMU mode.
 
+ (*) A list of all the mappings in use by a process is visible through
+     /proc/<pid>/maps in no-MMU mode.
+
  (*) Supplying MAP_FIXED or a requesting a particular mapping address will
      result in an error.
 
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 146a434..987c773 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -28,6 +28,7 @@ do {						\
 	(vmi)->largest_chunk = 0;		\
 } while(0)
 
+extern int nommu_vma_show(struct seq_file *, struct vm_area_struct *);
 #endif
 
 extern void create_seq_entry(char *name, mode_t mode, const struct file_operations *f);
diff --git a/fs/proc/nommu.c b/fs/proc/nommu.c
index cff10ab..d7dbdf9 100644
--- a/fs/proc/nommu.c
+++ b/fs/proc/nommu.c
@@ -33,19 +33,15 @@ #include <asm/div64.h>
 #include "internal.h"
 
 /*
- * display a list of all the VMAs the kernel knows about
- * - nommu kernals have a single flat list
+ * display a single VMA to a sequenced file
  */
-static int nommu_vma_list_show(struct seq_file *m, void *v)
+int nommu_vma_show(struct seq_file *m, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *vma;
 	unsigned long ino = 0;
 	struct file *file;
 	dev_t dev = 0;
 	int flags, len;
 
-	vma = rb_entry((struct rb_node *) v, struct vm_area_struct, vm_rb);
-
 	flags = vma->vm_flags;
 	file = vma->vm_file;
 
@@ -78,6 +74,18 @@ static int nommu_vma_list_show(struct se
 	return 0;
 }
 
+/*
+ * display a list of all the VMAs the kernel knows about
+ * - nommu kernals have a single flat list
+ */
+static int nommu_vma_list_show(struct seq_file *m, void *v)
+{
+	struct vm_area_struct *vma;
+
+	vma = rb_entry((struct rb_node *) v, struct vm_area_struct, vm_rb);
+	return nommu_vma_show(m, vma);
+}
+
 static void *nommu_vma_list_start(struct seq_file *m, loff_t *_pos)
 {
 	struct rb_node *_rb;
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 4616ed5..091aa8e 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -138,25 +138,63 @@ out:
 }
 
 /*
- * Albert D. Cahalan suggested to fake entries for the traditional
- * sections here.  This might be worth investigating.
+ * display mapping lines for a particular process's /proc/pid/maps
  */
-static int show_map(struct seq_file *m, void *v)
+static int show_map(struct seq_file *m, void *_vml)
 {
-	return 0;
+	struct vm_list_struct *vml = _vml;
+	return nommu_vma_show(m, vml->vma);
 }
+
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
+	struct proc_maps_private *priv = m->private;
+	struct vm_list_struct *vml;
+	struct mm_struct *mm;
+	loff_t n = *pos;
+
+	/* pin the task and mm whilst we play with them */
+	priv->task = get_pid_task(priv->pid, PIDTYPE_PID);
+	if (!priv->task)
+		return NULL;
+
+	mm = get_task_mm(priv->task);
+	if (!mm) {
+		put_task_struct(priv->task);
+		priv->task = NULL;
+		return NULL;
+	}
+
+	down_read(&mm->mmap_sem);
+
+	/* start from the Nth VMA */
+	for (vml = mm->context.vmlist; vml; vml = vml->next)
+		if (n-- == 0)
+			return vml;
 	return NULL;
 }
-static void m_stop(struct seq_file *m, void *v)
+
+static void m_stop(struct seq_file *m, void *_vml)
 {
+	struct proc_maps_private *priv = m->private;
+
+	if (priv->task) {
+		struct mm_struct *mm = priv->task->mm;
+		up_read(&mm->mmap_sem);
+		mmput(mm);
+		put_task_struct(priv->task);
+	}
 }
-static void *m_next(struct seq_file *m, void *v, loff_t *pos)
+
+static void *m_next(struct seq_file *m, void *_vml, loff_t *pos)
 {
-	return NULL;
+	struct vm_list_struct *vml = _vml;
+
+	(*pos)++;
+	return vml ? vml->next : NULL;
 }
-static struct seq_operations proc_pid_maps_op = {
+
+static struct seq_operations proc_pid_maps_ops = {
 	.start	= m_start,
 	.next	= m_next,
 	.stop	= m_stop,
@@ -165,11 +203,19 @@ static struct seq_operations proc_pid_ma
 
 static int maps_open(struct inode *inode, struct file *file)
 {
-	int ret;
-	ret = seq_open(file, &proc_pid_maps_op);
-	if (!ret) {
-		struct seq_file *m = file->private_data;
-		m->private = NULL;
+	struct proc_maps_private *priv;
+	int ret = -ENOMEM;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (priv) {
+		priv->pid = proc_pid(inode);
+		ret = seq_open(file, &proc_pid_maps_ops);
+		if (!ret) {
+			struct seq_file *m = file->private_data;
+			m->private = priv;
+		} else {
+			kfree(priv);
+		}
 	}
 	return ret;
 }
@@ -178,6 +224,6 @@ struct file_operations proc_maps_operati
 	.open		= maps_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= seq_release,
+	.release	= seq_release_private,
 };
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 17e7578..73beb46 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -269,7 +269,9 @@ static inline struct proc_dir_entry *PDE
 struct proc_maps_private {
 	struct pid *pid;
 	struct task_struct *task;
+#ifdef CONFIG_MMU
 	struct vm_area_struct *tail_vma;
+#endif
 };
 
 #endif /* _LINUX_PROC_FS_H */
