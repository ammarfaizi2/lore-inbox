Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbWBWQGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWBWQGp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWBWQGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:06:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2455 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751523AbWBWQGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:06:44 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/23] proc: Remove bogus proc_task_permission.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1fymahxwr.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqwyhxua.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j7mhxs0.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biahxpd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0aqgiyv.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:05:35 -0700
In-Reply-To: <m1u0aqgiyv.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:04:08 -0700")
Message-ID: <m1pslegiwg.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First we can access every /proc/<tgid>/task/<pid> directory as
/proc/<pid> so proc_task_permission is not usefully limiting
visibility.

Second having related filesystems information should have nothing to
do with process visibility.  kill does not implement any checks
like that.

It looks like proc_task_permission was added when the /proc/<tgid>/task
directories were added and someone misunderstood what proc_permission
was trying to accomplish.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |   63 --------------------------------------------------------
 1 files changed, 0 insertions(+), 63 deletions(-)

e1ab81806f60fd8ccda2773f9cdadd05990b5e81
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8357c52..8b938ef 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -350,54 +350,6 @@ static int proc_root_link(struct inode *
 	return result;
 }
 
-
-/* Same as proc_root_link, but this addionally tries to get fs from other
- * threads in the group */
-static int proc_task_root_link(struct inode *inode, struct dentry **dentry,
-				struct vfsmount **mnt)
-{
-	struct fs_struct *fs;
-	int result = -ENOENT;
-	struct task_struct *leader = proc_task(inode);
-
-	task_lock(leader);
-	fs = leader->fs;
-	if (fs) {
-		atomic_inc(&fs->count);
-		task_unlock(leader);
-	} else {
-		/* Try to get fs from other threads */
-		task_unlock(leader);
-		read_lock(&tasklist_lock);
-		if (pid_alive(leader)) {
-			struct task_struct *task = leader;
-
-			while ((task = next_thread(task)) != leader) {
-				task_lock(task);
-				fs = task->fs;
-				if (fs) {
-					atomic_inc(&fs->count);
-					task_unlock(task);
-					break;
-				}
-				task_unlock(task);
-			}
-		}
-		read_unlock(&tasklist_lock);
-	}
-
-	if (fs) {
-		read_lock(&fs->lock);
-		*mnt = mntget(fs->rootmnt);
-		*dentry = dget(fs->root);
-		read_unlock(&fs->lock);
-		result = 0;
-		put_fs_struct(fs);
-	}
-	return result;
-}
-
-
 #define MAY_PTRACE(task) \
 	(task == current || \
 	(task->parent == current && \
@@ -586,20 +538,6 @@ static int proc_permission(struct inode 
 	return proc_check_root(inode);
 }
 
-static int proc_task_permission(struct inode *inode, int mask, struct nameidata *nd)
-{
-	struct dentry *root;
-	struct vfsmount *vfsmnt;
-
-	if (generic_permission(inode, mask, NULL) != 0)
-		return -EACCES;
-
-	if (proc_task_root_link(inode, &root, &vfsmnt))
-		return -ENOENT;
-
-	return proc_check_chroot(root, vfsmnt);
-}
-
 extern struct seq_operations proc_pid_maps_op;
 static int maps_open(struct inode *inode, struct file *file)
 {
@@ -1531,7 +1469,6 @@ static struct inode_operations proc_fd_i
 
 static struct inode_operations proc_task_inode_operations = {
 	.lookup		= proc_task_lookup,
-	.permission	= proc_task_permission,
 };
 
 #ifdef CONFIG_SECURITY
-- 
1.2.2.g709a

