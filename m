Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbVISX0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbVISX0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 19:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbVISX0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 19:26:25 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:4782 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932652AbVISX0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 19:26:25 -0400
Message-ID: <432F4914.3080905@in.ibm.com>
Date: Mon, 19 Sep 2005 18:26:12 -0500
From: Sripathi Kodi <sripathik@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ZenIV.linux.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [Fwd: Re: [PATCH 2.6.13.1] Patch for invisible threads]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al,

 >>Al,
 >>Done. Please find the patch below. I retained proc_task_root_link, because
 >>it has significant amount of code in it.


What do you feel about this patch now? Is it good enough to go into the kernel?

Thanks and regards,
Sripathi.


Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>

--- linux-2.6.13.1-orig/fs/proc/base.c	2005-09-16 17:22:44.000000000 -0500
+++ linux-2.6.13.1/fs/proc/base.c	2005-09-16 17:08:18.000000000 -0500
@@ -291,6 +291,52 @@ static int proc_root_link(struct inode *
  	return result;
  }

+
+/* Same as proc_root_link, but this addionally tries to get fs from other
+ * threads in the group */
+static int proc_task_root_link(struct inode *inode, struct dentry **dentry,
struct vfsmount **mnt)
+{
+	struct fs_struct *fs;
+	int result = -ENOENT;
+	struct task_struct *leader = proc_task(inode);
+
+	task_lock(leader);
+	fs = leader->fs;
+	if (fs) {
+		atomic_inc(&fs->count);
+		task_unlock(leader);
+	} else {
+		/* Try to get fs from other threads */
+		task_unlock(leader);
+		struct task_struct *task = leader;
+		read_lock(&tasklist_lock);
+		if (pid_alive(task)) {
+			while ((task = next_thread(task)) != leader) {
+				task_lock(task);
+				fs = task->fs;
+				if (fs) {
+					atomic_inc(&fs->count);
+					task_unlock(task);
+					break;
+				}
+				task_unlock(task);
+			}
+		}
+		read_unlock(&tasklist_lock);
+	}
+
+	if (fs) {
+		read_lock(&fs->lock);
+		*mnt = mntget(fs->rootmnt);
+		*dentry = dget(fs->root);
+		read_unlock(&fs->lock);
+		result = 0;
+		put_fs_struct(fs);
+	}
+	return result;
+}
+
+
  #define MAY_PTRACE(task) \
  	(task == current || \
  	(task->parent == current && \
@@ -449,14 +495,14 @@ static int proc_oom_score(struct task_st

  /* permission checks */

-static int proc_check_root(struct inode *inode)
+/* If the process being read is separated by chroot from the reading process,
+ * don't let the reader access the threads.
+ */
+static int proc_check_chroot(struct dentry *root, struct vfsmount *vfsmnt)
  {
-	struct dentry *de, *base, *root;
-	struct vfsmount *our_vfsmnt, *vfsmnt, *mnt;
+	struct dentry *de, *base;
+	struct vfsmount *our_vfsmnt, *mnt;
  	int res = 0;
-
-	if (proc_root_link(inode, &root, &vfsmnt)) /* Ewww... */
-		return -ENOENT;
  	read_lock(&current->fs->lock);
  	our_vfsmnt = mntget(current->fs->rootmnt);
  	base = dget(current->fs->root);
@@ -489,6 +535,16 @@ out:
  	goto exit;
  }

+static int proc_check_root(struct inode *inode)
+{
+	struct dentry *root;
+	struct vfsmount *vfsmnt;
+
+	if (proc_root_link(inode, &root, &vfsmnt)) /* Ewww... */
+		return -ENOENT;
+	return proc_check_chroot(root, vfsmnt);
+}
+
  static int proc_permission(struct inode *inode, int mask, struct nameidata
*nd)
  {
  	if (generic_permission(inode, mask, NULL) != 0)
@@ -496,6 +552,20 @@ static int proc_permission(struct inode
  	return proc_check_root(inode);
  }

+static int proc_task_permission(struct inode *inode, int mask, struct
nameidata *nd)
+{
+	struct dentry *root;
+	struct vfsmount *vfsmnt;
+
+	if (generic_permission(inode, mask, NULL) != 0)
+		return -EACCES;
+
+	if (proc_task_root_link(inode, &root, &vfsmnt))
+		return -ENOENT;
+
+	return proc_check_chroot(root, vfsmnt);
+}
+
  extern struct seq_operations proc_pid_maps_op;
  static int maps_open(struct inode *inode, struct file *file)
  {
@@ -1355,7 +1425,7 @@ static struct inode_operations proc_fd_i

  static struct inode_operations proc_task_inode_operations = {
  	.lookup		= proc_task_lookup,
-	.permission	= proc_permission,
+	.permission	= proc_task_permission,
  };

  #ifdef CONFIG_SECURITY

