Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWCBVi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWCBVi6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWCBVi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:38:58 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:61865 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932306AbWCBVi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:38:57 -0500
Message-ID: <440765E2.6000209@vilain.net>
Date: Fri, 03 Mar 2006 10:38:42 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH] proc: Use sane permission checks on the /proc/<pid>/fd/ symlinks.
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com>

Since 2.2 we have been doing a chroot check to see if it is appropriate
to return a read or follow one of these magic symlinks.  The chroot
check was asking a question about the visibility of files to the
calling process and it was actually checking the destination process,
and not the files themselves.  That test was clearly bogus.

In my first pass through I simply fixed the test to check the visibility
of the files themselves.  That naive approach to fixing the permissions
was too strict and resulted in cases where a task could not even see
all of it's file descriptors.

What has disturbed me about relaxing this check is that file descriptors 
are per-process private things, and they are occasionaly used a user 
space capability tokens.  Looking a little farther into the symlink path 
on /proc I did find userid checks and a check for capability 
(CAP_DAC_OVERRIDE) so there were permissions checking this.

But I was still concerned about privacy.  Besides /proc there is only 
one other way to find out this kind of information, and that is ptrace. 
  ptrace has been around for a long time and it has a well established 
security model.

So after thinking about it I finally realized that the permission checks
that make sense are the permission checks applied to ptrace_attach.
The checks are simple per process, and won't cause nasty surprises for
people coming from less capable unices.

Unfortunately there is one case that the current ptrace_attach test
does not cover: Zombies and kernel threads.  Single stepping those
kinds of processes is impossible.  Being able to see which file
descriptors are open on these tasks is important to lsof, fuser and
friends.  So for these special processes I made the rule you can't
find out unless you have CAP_SYS_PTRACE.

These proc permission checks should now conform to the principle of
least surprise.  As well as using much less code to implement :)

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Acked-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
Nice solution to this problem we were discussion, Eric!  I agree with 
the ptrace analogy and support it in the context of Linux-VServer.

Sorry for the missing References: header, blame Thunderbird :)

There are long lines here that have been wrapped, if your e-mail client 
does not support flowed content you will have to un-flow it before the 
patch will apply.

  fs/proc/base.c |  123 
++++++++++++--------------------------------------------
  1 files changed, 27 insertions(+), 96 deletions(-)

64ea648d12af9f8bc0556ec118b27fbfcbe17722
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6a26847..d9be807 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -508,44 +508,33 @@ static int proc_oom_score(struct task_st
  /************************************************************************/

  /* permission checks */
-
-/* If the process being read is separated by chroot from the reading 
process,
- * don't let the reader access the threads.
- */
-static int proc_check_chroot(struct dentry *de, struct vfsmount *mnt)
+static int proc_fd_access_allowed(struct inode *inode)
  {
-	struct dentry *base;
-	struct vfsmount *our_vfsmnt;
-	int res = 0;
-
-	read_lock(&current->fs->lock);
-	our_vfsmnt = mntget(current->fs->rootmnt);
-	base = dget(current->fs->root);
-	read_unlock(&current->fs->lock);
-
-	spin_lock(&vfsmount_lock);
-
-	while (mnt != our_vfsmnt) {
-		if (mnt == mnt->mnt_parent)
-			goto out;
-		de = mnt->mnt_mountpoint;
-		mnt = mnt->mnt_parent;
+	struct task_struct *task;
+	int allowed = 0;
+	/* Allow access to a task's file descriptors if either we may
+	 * use ptrace attach to the process and find out that
+	 * information, or if the task cannot possibly be ptraced
+	 * allow access if we have the proper capability.
+	 */
+	task = get_proc_task(inode);
+	if (task) {
+		int alive;
+		task_lock(task);
+		alive = !!task->mm;
+		task_unlock(task);
+		if (alive)
+			/* For a living task obey ptrace_may_attach */
+			allowed = ptrace_may_attach(task);
+		else
+			/* For a special task simply check the capability */
+			allowed = capable(CAP_SYS_PTRACE);
  	}
-
-	if (!is_subdir(de, base))
-		goto out;
-	spin_unlock(&vfsmount_lock);
-
-exit:
-	dput(base);
-	mntput(our_vfsmnt);
-	return res;
-out:
-	spin_unlock(&vfsmount_lock);
-	res = -EACCES;
-	goto exit;
+	put_task_struct(task);
+	return allowed;
  }

+
  extern struct seq_operations mounts_op;
  struct proc_mounts {
  	struct seq_file m;
@@ -1001,52 +990,6 @@ static struct file_operations proc_secco
  };
  #endif /* CONFIG_SECCOMP */

-static int proc_check_dentry_visible(struct inode *inode,
-	struct dentry *dentry, struct vfsmount *mnt)
-{
-	/* Verify that the current process can already see the
-	 * file pointed at by the file descriptor.
-	 * This prevents /proc from being an accidental information leak.
-	 *
-	 * This prevents access to files that are not visible do to
-	 * being on the otherside of a chroot, in a different
-	 * namespace, or are simply process local (like pipes).
-	 */
-	struct task_struct *task;
-	int error = -EACCES;
-
-	/* See if the the two tasks share a commone set of
-	 * file descriptors.  If so everything is visible.
-	 */
-	rcu_read_lock();
-	task = tref_task(proc_tref(inode));
-	if (task) {
-		struct files_struct *task_files, *files;
-		/* This test answeres the question:
-		 * Is there a point in time since we looked up the
-		 * file descriptor where the two tasks share the
-		 * same files struct?
-		 */
-		rmb();
-		files = current->files;
-		task_files = task->files;
-		if (files && (files == task_files))
-			error = 0;
-	}
-	rcu_read_unlock();
-	if (!error)
-		goto out;
-
-	/* If the two tasks don't share a common set of file
-	 * descriptors see if the destination dentry is already
-	 * visible in the current tasks filesystem namespace.
-	 */
-	error = proc_check_chroot(dentry, mnt);
-out:
-	return error;
-
-}
-
  static void *proc_pid_follow_link(struct dentry *dentry, struct 
nameidata *nd)
  {
  	struct inode *inode = dentry->d_inode;
@@ -1055,18 +998,12 @@ static void *proc_pid_follow_link(struct
  	/* We don't need a base pointer in the /proc filesystem */
  	path_release(nd);

-	if (current->fsuid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
+	/* Are we allowed to snoop on the tasks file descriptors? */
+	if (!proc_fd_access_allowed(inode))
  		goto out;

  	error = PROC_I(inode)->op.proc_get_link(inode, &nd->dentry, &nd->mnt);
  	nd->last_type = LAST_BIND;
-	if (error)
-		goto out;
-
-	/* Only return files this task can already see */
-	error = proc_check_dentry_visible(inode, nd->dentry, nd->mnt);
-	if (error)
-		path_release(nd);
  out:
  	return ERR_PTR(error);
  }
@@ -1104,21 +1041,15 @@ static int proc_pid_readlink(struct dent
  	struct dentry *de;
  	struct vfsmount *mnt = NULL;

-
-	if (current->fsuid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
+	/* Are we allowed to snoop on the tasks file descriptors? */
+	if (!proc_fd_access_allowed(inode))
  		goto out;

  	error = PROC_I(inode)->op.proc_get_link(inode, &de, &mnt);
  	if (error)
  		goto out;

-	/* Only return files this task can already see */
-	error = proc_check_dentry_visible(inode, de, mnt);
-	if (error)
-		goto out_put;
-
  	error = do_proc_readlink(de, mnt, buffer, buflen);
-out_put:
  	dput(de);
  	mntput(mnt);
  out:
