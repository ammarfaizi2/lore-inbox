Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992857AbWJUHQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992857AbWJUHQX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992887AbWJUHO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:14:59 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:27015 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992857AbWJUHOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:14:37 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 14 of 23] kernel: change uses of f_{dentry,
	vfsmnt} to use f_path
Message-Id: <84ddeab0dabc18d63a67.1161411459@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:39 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in linux/kernel/.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

5 files changed, 16 insertions(+), 16 deletions(-)
kernel/acct.c   |   14 +++++++-------
kernel/fork.c   |    2 +-
kernel/futex.c  |   10 +++++-----
kernel/relay.c  |    4 ++--
kernel/sysctl.c |    2 +-

diff --git a/kernel/acct.c b/kernel/acct.c
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -117,7 +117,7 @@ static int check_free_space(struct file 
 	spin_unlock(&acct_globals.lock);
 
 	/* May block */
-	if (vfs_statfs(file->f_dentry, &sbuf))
+	if (vfs_statfs(file->f_path.dentry, &sbuf))
 		return res;
 	suspend = sbuf.f_blocks * SUSPEND;
 	resume = sbuf.f_blocks * RESUME;
@@ -193,7 +193,7 @@ static void acct_file_reopen(struct file
 		add_timer(&acct_globals.timer);
 	}
 	if (old_acct) {
-		mnt_unpin(old_acct->f_vfsmnt);
+		mnt_unpin(old_acct->f_path.mnt);
 		spin_unlock(&acct_globals.lock);
 		do_acct_process(old_acct);
 		filp_close(old_acct, NULL);
@@ -211,7 +211,7 @@ static int acct_on(char *name)
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	if (!S_ISREG(file->f_dentry->d_inode->i_mode)) {
+	if (!S_ISREG(file->f_path.dentry->d_inode->i_mode)) {
 		filp_close(file, NULL);
 		return -EACCES;
 	}
@@ -228,11 +228,11 @@ static int acct_on(char *name)
 	}
 
 	spin_lock(&acct_globals.lock);
-	mnt_pin(file->f_vfsmnt);
+	mnt_pin(file->f_path.mnt);
 	acct_file_reopen(file);
 	spin_unlock(&acct_globals.lock);
 
-	mntput(file->f_vfsmnt);	/* it's pinned, now give up active reference */
+	mntput(file->f_path.mnt); /* it's pinned, now give up active reference */
 
 	return 0;
 }
@@ -282,7 +282,7 @@ void acct_auto_close_mnt(struct vfsmount
 void acct_auto_close_mnt(struct vfsmount *m)
 {
 	spin_lock(&acct_globals.lock);
-	if (acct_globals.file && acct_globals.file->f_vfsmnt == m)
+	if (acct_globals.file && acct_globals.file->f_path.mnt == m)
 		acct_file_reopen(NULL);
 	spin_unlock(&acct_globals.lock);
 }
@@ -298,7 +298,7 @@ void acct_auto_close(struct super_block 
 {
 	spin_lock(&acct_globals.lock);
 	if (acct_globals.file &&
-	    acct_globals.file->f_vfsmnt->mnt_sb == sb) {
+	    acct_globals.file->f_path.mnt->mnt_sb == sb) {
 		acct_file_reopen(NULL);
 	}
 	spin_unlock(&acct_globals.lock);
diff --git a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -252,7 +252,7 @@ static inline int dup_mmap(struct mm_str
 		anon_vma_link(tmp);
 		file = tmp->vm_file;
 		if (file) {
-			struct inode *inode = file->f_dentry->d_inode;
+			struct inode *inode = file->f_path.dentry->d_inode;
 			get_file(file);
 			if (tmp->vm_flags & VM_DENYWRITE)
 				atomic_dec(&inode->i_writecount);
diff --git a/kernel/futex.c b/kernel/futex.c
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -166,7 +166,7 @@ static inline int match_futex(union fute
 /*
  * Get parameters which are the keys for a futex.
  *
- * For shared mappings, it's (page->index, vma->vm_file->f_dentry->d_inode,
+ * For shared mappings, it's (page->index, vma->vm_file->f_path.dentry->d_inode,
  * offset_within_page).  For private mappings, it's (uaddr, current->mm).
  * We can usually work out the index without swapping in the page.
  *
@@ -223,7 +223,7 @@ static int get_futex_key(u32 __user *uad
 	/*
 	 * Linear file mappings are also simple.
 	 */
-	key->shared.inode = vma->vm_file->f_dentry->d_inode;
+	key->shared.inode = vma->vm_file->f_path.dentry->d_inode;
 	key->both.offset++; /* Bit 0 of offset indicates inode-based key. */
 	if (likely(!(vma->vm_flags & VM_NONLINEAR))) {
 		key->shared.pgoff = (((address - vma->vm_start) >> PAGE_SHIFT)
@@ -1522,9 +1522,9 @@ static int futex_fd(u32 __user *uaddr, i
 		goto out;
 	}
 	filp->f_op = &futex_fops;
-	filp->f_vfsmnt = mntget(futex_mnt);
-	filp->f_dentry = dget(futex_mnt->mnt_root);
-	filp->f_mapping = filp->f_dentry->d_inode->i_mapping;
+	filp->f_path.mnt = mntget(futex_mnt);
+	filp->f_path.dentry = dget(futex_mnt->mnt_root);
+	filp->f_mapping = filp->f_path.dentry->d_inode->i_mapping;
 
 	if (signal) {
 		err = __f_setown(filp, task_pid(current), PIDTYPE_PID, 1);
diff --git a/kernel/relay.c b/kernel/relay.c
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -957,7 +957,7 @@ static inline ssize_t relay_file_read_su
 	if (!desc->count)
 		return 0;
 
-	mutex_lock(&filp->f_dentry->d_inode->i_mutex);
+	mutex_lock(&filp->f_path.dentry->d_inode->i_mutex);
 	do {
 		if (!relay_file_read_avail(buf, *ppos))
 			break;
@@ -977,7 +977,7 @@ static inline ssize_t relay_file_read_su
 			*ppos = relay_file_read_end_pos(buf, read_start, ret);
 		}
 	} while (desc->count && ret);
-	mutex_unlock(&filp->f_dentry->d_inode->i_mutex);
+	mutex_unlock(&filp->f_path.dentry->d_inode->i_mutex);
 
 	return desc->written;
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1614,7 +1614,7 @@ static ssize_t do_rw_proc(int write, str
 			  size_t count, loff_t *ppos)
 {
 	int op;
-	struct proc_dir_entry *de = PDE(file->f_dentry->d_inode);
+	struct proc_dir_entry *de = PDE(file->f_path.dentry->d_inode);
 	struct ctl_table *table;
 	size_t res;
 	ssize_t error = -ENOTDIR;


