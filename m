Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965302AbVIPPIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965302AbVIPPIb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbVIPPIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:08:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:43410 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932663AbVIPPIa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 11:08:30 -0400
Message-ID: <432ADF8D.8010503@in.ibm.com>
Date: Fri, 16 Sep 2005 10:06:53 -0500
From: Sripathi Kodi <sripathik@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
References: <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org> <20050913165102.GR25261@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org> <20050913171215.GS25261@ZenIV.linux.org.uk> <43274503.7090303@in.ibm.com> <Pine.LNX.4.58.0509131601400.26803@g5.osdl.org> <20050914015003.GW25261@ZenIV.linux.org.uk> <4328C0D0.6000909@in.ibm.com> <20050915011850.GZ25261@ZenIV.linux.org.uk> <432A17E0.3060302@in.ibm.com> <20050916074606.GE19626@ftp.linux.org.uk>
In-Reply-To: <20050916074606.GE19626@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> Ugh...  Considering that all of that is _only_ for /proc/<pid>/task and
> that proc_permission() is a couple of function calls, why bother with
> proc_task_check_root() instead of just adding proc_task_permission() with
> 
> {
> 	struct dentry *root;
> 	struct vfsmount *vfsmnt;
> 
> 	if (generic_permission(inode, mask, NULL) != 0)
> 		return -EACCES;
> 
> 	/* or just open-code it here, for that matter */
> 	if (proc_task_root_link(inode, &root, &vfsmnt))
> 		return -ENOENT;
> 
> 	return proc_check_chroot(root, vfsmnt);
> }
> 
> for a body and leaving proc_permission() without any changes at all?

Al,
Done. Please find the patch below. I retained proc_task_root_link, because 
it has significant amount of code in it.

> Right.  The real question is whether the current behaviour makes any sense.
> I've no objections to your patch + modification above, but I really wonder
> if we should keep current rules in that area.

I don't know what would be the right behavior for this area. If you have any 
ideas for changes we could introduce here, I am ready to code and test it out.

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
