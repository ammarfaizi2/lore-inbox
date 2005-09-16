Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbVIPAzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbVIPAzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 20:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbVIPAzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 20:55:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60113 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965054AbVIPAzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 20:55:37 -0400
Message-ID: <432A17E0.3060302@in.ibm.com>
Date: Thu, 15 Sep 2005 19:54:56 -0500
From: Sripathi Kodi <sripathik@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ZenIV.linux.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, patrics@interia.pl,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
References: <20050912134954.7bbd15b2.akpm@osdl.org> <4326CFE2.6000908@in.ibm.com> <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org> <20050913165102.GR25261@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org> <20050913171215.GS25261@ZenIV.linux.org.uk> <43274503.7090303@in.ibm.com> <Pine.LNX.4.58.0509131601400.26803@g5.osdl.org> <20050914015003.GW25261@ZenIV.linux.org.uk> <4328C0D0.6000909@in.ibm.com> <20050915011850.GZ25261@ZenIV.linux.org.uk>
In-Reply-To: <20050915011850.GZ25261@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Wed, Sep 14, 2005 at 07:31:12PM -0500, Sripathi Kodi wrote:
> 
>>I can move this code from proc_root_link() to proc_check_root(), but it 
>>will still not be completely limited to ->permission() path. I can create a 
>>separate ->permission() for proc_task_inode_operations, and have this 
>>additional code there. If I do that, I think I will have to duplicate much 
>>of proc_check_root(). Or else, I will have to split proc_check_root() into 
>>two functions to prevent code duplication. Please let me know if any of 
>>these makes sense, and I will send another patch.
> 
> 
> The last variant would be preferable if we go in that direction...

Al,

I have done the following changes in this new patch:
1) Changed proc_permission to call new function proc_task_check_root instead 
of proc_check_root. Other paths that call proc_check_root are not affected.
2) proc_task_check_root calls a new function proc_task_root_link to get fs. 
This is same as proc_root_link, but additionally tries to get fs from one of 
the other threads of the group when the main thread doesn't have it.
3) Moved the code that checks chroot boundary from proc_root_link to a new 
function proc_check_chroot. Both proc_check_root and proc_task_check_root 
call this function. This avoids duplication of this code.

With these changes, only ->permission path will encounter the new kludge code.

proc_root_link and proc_task_root_link still have some duplicated code. I 
could have split these functions further to avoid duplication completely, 
but that would move incrementing and decrementing fs->lock to two different 
functions, which I think will be confusing.

The other way of implementing this that I could think of was to have a flag 
to indicate that the call is from ->permission path and pass it all along. 
This will avoid having to change many existing functions, but it will defeat 
the purpose of limiting this kludge code to ->permission path.

Please let me know how it is looking now.

Further, about actual permission checks that we are doing, can we say: "A 
process should be able to see /proc/<pid>/task/* of another process only if 
they both belong to same uid or reader is root"? But any such change will 
change the behavior of commands like 'ps', right?

Thanks,
Sripathi.


Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>

--- linux-2.6.13.1-orig/fs/proc/base.c	2005-09-09 21:42:58.000000000 -0500
+++ linux-2.6.13.1/fs/proc/base.c	2005-09-16 00:57:31.000000000 -0500
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
@@ -489,11 +535,33 @@ out:
  	goto exit;
  }

+static int proc_check_root(struct inode *inode)
+{
+	struct dentry *root;
+	struct vfsmount *vfsmnt;
+
+	if (proc_root_link(inode, &root, &vfsmnt)) /* Ewww... */
+		return -ENOENT;
+
+	return proc_check_chroot(root, vfsmnt);
+}
+
+static int proc_task_check_root(struct inode *inode)
+{
+	struct dentry *root;
+	struct vfsmount *vfsmnt;
+
+	if (proc_task_root_link(inode, &root, &vfsmnt)) /* Ewww... */
+		return -ENOENT;
+
+	return proc_check_chroot(root, vfsmnt);
+}
+	
  static int proc_permission(struct inode *inode, int mask, struct nameidata 
*nd)
  {
  	if (generic_permission(inode, mask, NULL) != 0)
  		return -EACCES;
-	return proc_check_root(inode);
+	return proc_task_check_root(inode);
  }

  extern struct seq_operations proc_pid_maps_op;
