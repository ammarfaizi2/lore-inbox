Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314700AbSDTR5t>; Sat, 20 Apr 2002 13:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314701AbSDTR5s>; Sat, 20 Apr 2002 13:57:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62148 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314700AbSDTR5n>;
	Sat, 20 Apr 2002 13:57:43 -0400
Date: Sat, 20 Apr 2002 13:57:43 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [CFT][PATCH] (3/5) sane procfs/dcache interaction
In-Reply-To: <Pine.GSO.4.21.0204201356480.25383-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0204201357220.25383-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -urN C8-name_to_int/fs/proc/base.c C8-retain_dentry/fs/proc/base.c
--- C8-name_to_int/fs/proc/base.c	Fri Apr 19 01:17:11 2002
+++ C8-retain_dentry/fs/proc/base.c	Fri Apr 19 01:17:36 2002
@@ -747,7 +747,7 @@
  * directory. In this case, however, we can do it - no aliasing problems
  * due to the way we treat inodes.
  */
-static int pid_base_revalidate(struct dentry * dentry, int flags)
+static int pid_revalidate(struct dentry * dentry, int flags)
 {
 	if (proc_task(dentry->d_inode)->pid)
 		return 1;
@@ -755,25 +755,42 @@
 	return 0;
 }
 
-static int pid_delete_dentry(struct dentry * dentry)
+static void pid_base_iput(struct dentry *dentry, struct inode *inode)
+{
+	struct task_struct *task = proc_task(inode);
+	write_lock_irq(&tasklist_lock);
+	if (task->proc_dentry == dentry)
+		task->proc_dentry = NULL;
+	write_unlock_irq(&tasklist_lock);
+	iput(inode);
+}
+
+static int pid_fd_delete_dentry(struct dentry * dentry)
 {
 	return 1;
 }
 
+static int pid_delete_dentry(struct dentry * dentry)
+{
+	return proc_task(dentry->d_inode)->pid == 0;
+}
+
 static struct dentry_operations pid_fd_dentry_operations =
 {
 	d_revalidate:	pid_fd_revalidate,
-	d_delete:	pid_delete_dentry,
+	d_delete:	pid_fd_delete_dentry,
 };
 
 static struct dentry_operations pid_dentry_operations =
 {
+	d_revalidate:	pid_revalidate,
 	d_delete:	pid_delete_dentry,
 };
 
 static struct dentry_operations pid_base_dentry_operations =
 {
-	d_revalidate:	pid_base_revalidate,
+	d_revalidate:	pid_revalidate,
+	d_iput:		pid_base_iput,
 	d_delete:	pid_delete_dentry,
 };
 
@@ -842,6 +859,8 @@
 		inode->i_mode |= S_IWUSR | S_IXUSR;
 	dentry->d_op = &pid_fd_dentry_operations;
 	d_add(dentry, inode);
+	if (!proc_task(dentry->d_inode)->pid)
+		d_drop(dentry);
 	return NULL;
 
 out_unlock2:
@@ -959,6 +978,8 @@
 	}
 	dentry->d_op = &pid_dentry_operations;
 	d_add(dentry, inode);
+	if (!proc_task(dentry->d_inode)->pid)
+		d_drop(dentry);
 	return NULL;
 
 out:
@@ -1045,6 +1066,11 @@
 
 	dentry->d_op = &pid_base_dentry_operations;
 	d_add(dentry, inode);
+	read_lock(&tasklist_lock);
+	proc_task(dentry->d_inode)->proc_dentry = dentry;
+	read_unlock(&tasklist_lock);
+	if (!proc_task(dentry->d_inode)->pid)
+		d_drop(dentry);
 	return NULL;
 out:
 	return ERR_PTR(-ENOENT);
diff -urN C8-name_to_int/include/linux/sched.h C8-retain_dentry/include/linux/sched.h
--- C8-name_to_int/include/linux/sched.h	Fri Apr 19 01:16:35 2002
+++ C8-retain_dentry/include/linux/sched.h	Fri Apr 19 01:17:36 2002
@@ -346,6 +346,7 @@
 
 /* journalling filesystem info */
 	void *journal_info;
+	struct dentry *proc_dentry;
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
diff -urN C8-name_to_int/kernel/exit.c C8-retain_dentry/kernel/exit.c
--- C8-name_to_int/kernel/exit.c	Fri Apr 19 01:16:35 2002
+++ C8-retain_dentry/kernel/exit.c	Fri Apr 19 01:17:36 2002
@@ -29,13 +29,28 @@
 
 static inline void __unhash_process(struct task_struct *p)
 {
+	struct dentry *proc_dentry;
 	write_lock_irq(&tasklist_lock);
 	nr_threads--;
 	unhash_pid(p);
 	REMOVE_LINKS(p);
 	list_del(&p->thread_group);
 	p->pid = 0;
+	proc_dentry = p->proc_dentry;
+	if (unlikely(proc_dentry)) {
+		spin_lock(&dcache_lock);
+		if (!list_empty(&proc_dentry->d_hash)) {
+			dget_locked(proc_dentry);
+			list_del_init(&proc_dentry->d_hash);
+		} else
+			proc_dentry = NULL;
+		spin_unlock(&dcache_lock);
+	}
 	write_unlock_irq(&tasklist_lock);
+	if (unlikely(proc_dentry)) {
+		shrink_dcache_parent(proc_dentry);
+		dput(proc_dentry);
+	}
 }
 
 static void release_task(struct task_struct * p)
diff -urN C8-name_to_int/kernel/fork.c C8-retain_dentry/kernel/fork.c
--- C8-name_to_int/kernel/fork.c	Sun Apr 14 17:53:13 2002
+++ C8-retain_dentry/kernel/fork.c	Fri Apr 19 01:17:36 2002
@@ -665,6 +665,7 @@
 
 	copy_flags(clone_flags, p);
 	p->pid = get_pid(clone_flags);
+	p->proc_dentry = NULL;
 
 	INIT_LIST_HEAD(&p->run_list);
 


