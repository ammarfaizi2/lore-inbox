Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbWBWQJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWBWQJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWBWQJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:09:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6551 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751518AbWBWQJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:09:28 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/23] proc: Properly filter out files that are not visible
 to a process.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1fymahxwr.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqwyhxua.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j7mhxs0.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biahxpd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0aqgiyv.fsf_-_@ebiederm.dsl.xmission.com>
	<m1pslegiwg.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkw2giue.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:08:20 -0700
In-Reply-To: <m1lkw2giue.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:06:49 -0700")
Message-ID: <m1hd6qgirv.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Long ago and far away in 2.2 we started checking to ensure the files
we displayed in /proc were visible to the current process.  It was
an unsophisticated time and no one was worried about functions
full of FIXMES in a stable kernel.  As time passed the function
became sacred and was enshrined in the shrine of how things
have always been.  The fixes came in but only to keep the function
working no one really remembering or documenting why we did things
that way.

The intent and the functionality make a lot of sense.  Don't let
/proc be an be a way to access files a process can see no other way.
The implementation however is completely wrong.

We are currently checking the root directories of the two processes,
we are not checking the actual file descriptors themselves.

We are strangely checking with a permission method instead of just when
we use the data.

This patch fixes the logic to actually check the files being returned and
makes a note that implementing a permission method for this part of
/proc almost certainly the wrong way to implement a permission check.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |  153 ++++++++++++++++++++++++++++++++------------------------
 1 files changed, 87 insertions(+), 66 deletions(-)

2c3a592c549bde816af8d38fc41542ce32f24bef
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1d1feb7..81c2f2a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -74,6 +74,16 @@
 #include <linux/poll.h>
 #include "internal.h"
 
+/* NOTE:   
+ *	Implementing inode permission operations in /proc is almost
+ *	certainly an error.  Permission checks need to happen during
+ *	each system call not at open time.  The reason is that most of
+ *	what we wish to check for permissions in /proc varies at runtime.
+ *	 
+ *	The classic example of a problem is opening file descriptors
+ *	in /proc for a task before it execs a suid executable.
+ */
+
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
  * Feel free to change the macro below - just keep the range distinct from
@@ -479,65 +489,6 @@ static int proc_oom_score(struct task_st
 /*                       Here the fs part begins                        */
 /************************************************************************/
 
-/* permission checks */
-
-/* If the process being read is separated by chroot from the reading process,
- * don't let the reader access the threads.
- */
-static int proc_check_chroot(struct dentry *root, struct vfsmount *vfsmnt)
-{
-	struct dentry *de, *base;
-	struct vfsmount *our_vfsmnt, *mnt;
-	int res = 0;
-	read_lock(&current->fs->lock);
-	our_vfsmnt = mntget(current->fs->rootmnt);
-	base = dget(current->fs->root);
-	read_unlock(&current->fs->lock);
-
-	spin_lock(&vfsmount_lock);
-	de = root;
-	mnt = vfsmnt;
-
-	while (vfsmnt != our_vfsmnt) {
-		if (vfsmnt == vfsmnt->mnt_parent)
-			goto out;
-		de = vfsmnt->mnt_mountpoint;
-		vfsmnt = vfsmnt->mnt_parent;
-	}
-
-	if (!is_subdir(de, base))
-		goto out;
-	spin_unlock(&vfsmount_lock);
-
-exit:
-	dput(base);
-	mntput(our_vfsmnt);
-	dput(root);
-	mntput(mnt);
-	return res;
-out:
-	spin_unlock(&vfsmount_lock);
-	res = -EACCES;
-	goto exit;
-}
-
-static int proc_check_root(struct inode *inode)
-{
-	struct dentry *root;
-	struct vfsmount *vfsmnt;
-
-	if (proc_root_link(inode, &root, &vfsmnt)) /* Ewww... */
-		return -ENOENT;
-	return proc_check_chroot(root, vfsmnt);
-}
-
-static int proc_permission(struct inode *inode, int mask, struct nameidata *nd)
-{
-	if (generic_permission(inode, mask, NULL) != 0)
-		return -EACCES;
-	return proc_check_root(inode);
-}
-
 extern struct seq_operations proc_pid_maps_op;
 static int maps_open(struct inode *inode, struct file *file)
 {
@@ -1001,6 +952,70 @@ static struct file_operations proc_secco
 };
 #endif /* CONFIG_SECCOMP */
 
+static int proc_check_dentry_visible(struct inode *inode,
+	struct dentry *dentry, struct vfsmount *mnt)
+{
+	/* Verify that the current process can already see the
+	 * file pointed at by the file descriptor.
+	 * This prevents /proc from being an accidental information leak.
+	 * 
+	 * This prevents access to files that are not visible do to
+	 * being on the otherside of a chroot, in a different
+	 * namespace, or are simply process local (like pipes).
+	 */
+	struct dentry *root;
+	struct vfsmount *rootmnt;
+	struct task_struct *task;
+	struct files_struct *task_files, *files;
+	int error = -EACCES;
+
+	/* See if the the two tasks share a commone set of 
+	 * file descriptors.  If so everything is visible.
+	 */
+	task = get_proc_task(inode);
+	if (!task)
+		goto out;
+	files = get_files_struct(current);
+	task_files = get_files_struct(task);
+	if (files && task_files && (files == task_files))
+		error = 0;
+	if (task_files)
+		put_files_struct(task_files);
+	if (files)
+		put_files_struct(files);
+	put_task_struct(task);
+	if (!error)
+		goto out;
+
+	/* If the two tasks don't share a common set of file
+	 * descriptors see if the destination dentry is already
+	 * visible in the current tasks filesystem namespace.
+	 */
+	read_lock(&current->fs->lock);
+	rootmnt = mntget(current->fs->rootmnt);
+	root = dget(current->fs->root);
+	read_unlock(&current->fs->lock);
+
+	spin_lock(&vfsmount_lock);
+	while (mnt != rootmnt) {
+		if (mnt == mnt->mnt_parent)
+			goto out_unlock;
+		dentry = mnt->mnt_mountpoint;
+		mnt = mnt->mnt_parent;
+	}
+	if (!is_subdir(dentry, root))
+		goto out_unlock;
+	error = 0;
+out_unlock:
+	spin_unlock(&vfsmount_lock);
+
+	dput(root);
+	mntput(rootmnt);
+out:
+	return error;
+
+}
+
 static void *proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
@@ -1011,12 +1026,16 @@ static void *proc_pid_follow_link(struct
 
 	if (current->fsuid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
 		goto out;
-	error = proc_check_root(inode);
-	if (error)
-		goto out;
 
 	error = PROC_I(inode)->op.proc_get_link(inode, &nd->dentry, &nd->mnt);
 	nd->last_type = LAST_BIND;
+	if (error)
+		goto out;
+
+	/* Only return files this task can already see */
+	error = proc_check_dentry_visible(inode, nd->dentry, nd->mnt);
+	if (error)
+		path_release(nd);
 out:
 	return ERR_PTR(error);
 }
@@ -1057,15 +1076,18 @@ static int proc_pid_readlink(struct dent
 
 	if (current->fsuid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
 		goto out;
-	error = proc_check_root(inode);
-	if (error)
-		goto out;
 
 	error = PROC_I(inode)->op.proc_get_link(inode, &de, &mnt);
 	if (error)
 		goto out;
 
+	/* Only return files this task can already see */
+	error = proc_check_dentry_visible(inode, de, mnt);
+	if (error)
+		goto out_put;
+
 	error = do_proc_readlink(de, mnt, buffer, buflen);
+out_put:
 	dput(de);
 	mntput(mnt);
 out:
@@ -1460,7 +1482,6 @@ static struct file_operations proc_task_
  */
 static struct inode_operations proc_fd_inode_operations = {
 	.lookup		= proc_lookupfd,
-	.permission	= proc_permission,
 };
 
 static struct inode_operations proc_task_inode_operations = {
-- 
1.2.2.g709a

