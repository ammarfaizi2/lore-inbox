Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbVKHCEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbVKHCEV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbVKHCBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:50 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:28621 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965248AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 1/18] saner handling of auto_acct_off() and DQUOT_OFF() in umount
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001Ed-68@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1131401619 -0500

The way we currently deal with quota and process accounting that might keep
vfsmount busy at umount time is inherently broken; we try to turn them off
just in case (not quite correctly, at that) and
	a) pray umount doesn't fail (otherwise they'll stay turned off)
	b) pray nobody doesn anything funny just as we turn quota off
Moreover, LSM provides hooks for doing the same sort of broken logics.

Proper way to deal with that is to introduce the second kind of reference
to vfsmount.  Semantics:
	* when the last normal reference is dropped, all special ones
are converted to normal ones and if there had been any, cleanup is done.
	* normal reference can be cloned into a special one
	* special reference can be converted to normal one; that's a no-op
if we'd already passed the point of no return (i.e. mntput() had converted
special references to normal and started cleanup).

The way it works: e.g. starting process accounting converts the vfsmount
reference pinned by the opened file into special one and turns it back
to normal when it gets shut down; acct_auto_close() is done when no normal
references are left.  That way it does *not* obstruct umount(2) and it
silently gets turned off when the last normal reference to vfsmount is
gone.  Which is exactly what we want...

The same should be done by LSM module that holds some internal references
to vfsmount and wants to shut them down on umount - it should make them
special and security_sb_umount_close() will be called exactly when the
last normal reference to vfsmount is gone.

quota handling is even simpler - we don't use normal file IO anymore,
so there's no need to hold vfsmounts at all.  DQUOT_OFF() is done
from deactivate_super(), where it really belongs.
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/dquot.c            |   18 +---------
 fs/namespace.c        |   64 ++++++++++++++++++++++------------
 fs/super.c            |    1 +
 include/linux/acct.h  |    3 ++
 include/linux/mount.h |   13 ++-----
 include/linux/quota.h |    1 -
 kernel/acct.c         |   92 +++++++++++++++++++++++++++++++++----------------
 7 files changed, 113 insertions(+), 79 deletions(-)

30cbb9cc9732bb7aa1fb9e0ce0943bed606cd715
diff --git a/fs/dquot.c b/fs/dquot.c
--- a/fs/dquot.c
+++ b/fs/dquot.c
@@ -1321,13 +1321,11 @@ int vfs_quota_off(struct super_block *sb
 	int cnt;
 	struct quota_info *dqopt = sb_dqopt(sb);
 	struct inode *toputinode[MAXQUOTAS];
-	struct vfsmount *toputmnt[MAXQUOTAS];
 
 	/* We need to serialize quota_off() for device */
 	down(&dqopt->dqonoff_sem);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		toputinode[cnt] = NULL;
-		toputmnt[cnt] = NULL;
 		if (type != -1 && cnt != type)
 			continue;
 		if (!sb_has_quota_enabled(sb, cnt))
@@ -1348,9 +1346,7 @@ int vfs_quota_off(struct super_block *sb
 		put_quota_format(dqopt->info[cnt].dqi_format);
 
 		toputinode[cnt] = dqopt->files[cnt];
-		toputmnt[cnt] = dqopt->mnt[cnt];
 		dqopt->files[cnt] = NULL;
-		dqopt->mnt[cnt] = NULL;
 		dqopt->info[cnt].dqi_flags = 0;
 		dqopt->info[cnt].dqi_igrace = 0;
 		dqopt->info[cnt].dqi_bgrace = 0;
@@ -1358,10 +1354,7 @@ int vfs_quota_off(struct super_block *sb
 	}
 	up(&dqopt->dqonoff_sem);
 	/* Sync the superblock so that buffers with quota data are written to
-	 * disk (and so userspace sees correct data afterwards).
-	 * The reference to vfsmnt we are still holding protects us from
-	 * umount (we don't have it only when quotas are turned on/off for
-	 * journal replay but in that case we are guarded by the fs anyway). */
+	 * disk (and so userspace sees correct data afterwards). */
 	if (sb->s_op->sync_fs)
 		sb->s_op->sync_fs(sb, 1);
 	sync_blockdev(sb->s_bdev);
@@ -1385,10 +1378,6 @@ int vfs_quota_off(struct super_block *sb
 				iput(toputinode[cnt]);
 			}
 			up(&dqopt->dqonoff_sem);
-			/* We don't hold the reference when we turned on quotas
-			 * just for the journal replay... */
-			if (toputmnt[cnt])
-				mntput(toputmnt[cnt]);
 		}
 	if (sb->s_bdev)
 		invalidate_bdev(sb->s_bdev, 0);
@@ -1503,11 +1492,8 @@ int vfs_quota_on(struct super_block *sb,
 	/* Quota file not on the same filesystem? */
 	if (nd.mnt->mnt_sb != sb)
 		error = -EXDEV;
-	else {
+	else
 		error = vfs_quota_on_inode(nd.dentry->d_inode, type, format_id);
-		if (!error)
-			sb_dqopt(sb)->mnt[type] = mntget(nd.mnt);
-	}
 out_path:
 	path_release(&nd);
 	return error;
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -172,7 +172,7 @@ clone_mnt(struct vfsmount *old, struct d
 	return mnt;
 }
 
-void __mntput(struct vfsmount *mnt)
+static inline void __mntput(struct vfsmount *mnt)
 {
 	struct super_block *sb = mnt->mnt_sb;
 	dput(mnt->mnt_root);
@@ -180,7 +180,46 @@ void __mntput(struct vfsmount *mnt)
 	deactivate_super(sb);
 }
 
-EXPORT_SYMBOL(__mntput);
+void mntput_no_expire(struct vfsmount *mnt)
+{
+repeat:
+	if (atomic_dec_and_lock(&mnt->mnt_count, &vfsmount_lock)) {
+		if (likely(!mnt->mnt_pinned)) {
+			spin_unlock(&vfsmount_lock);
+			__mntput(mnt);
+			return;
+		}
+		atomic_add(mnt->mnt_pinned + 1, &mnt->mnt_count);
+		mnt->mnt_pinned = 0;
+		spin_unlock(&vfsmount_lock);
+		acct_auto_close_mnt(mnt);
+		security_sb_umount_close(mnt);
+		goto repeat;
+	}
+}
+
+EXPORT_SYMBOL(mntput_no_expire);
+
+void mnt_pin(struct vfsmount *mnt)
+{
+	spin_lock(&vfsmount_lock);
+	mnt->mnt_pinned++;
+	spin_unlock(&vfsmount_lock);
+}
+
+EXPORT_SYMBOL(mnt_pin);
+
+void mnt_unpin(struct vfsmount *mnt)
+{
+	spin_lock(&vfsmount_lock);
+	if (mnt->mnt_pinned) {
+		atomic_inc(&mnt->mnt_count);
+		mnt->mnt_pinned--;
+	}
+	spin_unlock(&vfsmount_lock);
+}
+
+EXPORT_SYMBOL(mnt_unpin);
 
 /* iterator */
 static void *m_start(struct seq_file *m, loff_t *pos)
@@ -435,16 +474,6 @@ static int do_umount(struct vfsmount *mn
 	down_write(&current->namespace->sem);
 	spin_lock(&vfsmount_lock);
 
-	if (atomic_read(&sb->s_active) == 1) {
-		/* last instance - try to be smart */
-		spin_unlock(&vfsmount_lock);
-		lock_kernel();
-		DQUOT_OFF(sb);
-		acct_auto_close(sb);
-		unlock_kernel();
-		security_sb_umount_close(mnt);
-		spin_lock(&vfsmount_lock);
-	}
 	retval = -EBUSY;
 	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
 		if (!list_empty(&mnt->mnt_list))
@@ -850,17 +879,6 @@ static void expire_mount(struct vfsmount
 		detach_mnt(mnt, &old_nd);
 		spin_unlock(&vfsmount_lock);
 		path_release(&old_nd);
-
-		/*
-		 * Now lay it to rest if this was the last ref on the superblock
-		 */
-		if (atomic_read(&mnt->mnt_sb->s_active) == 1) {
-			/* last instance - try to be smart */
-			lock_kernel();
-			DQUOT_OFF(mnt->mnt_sb);
-			acct_auto_close(mnt->mnt_sb);
-			unlock_kernel();
-		}
 		mntput(mnt);
 	} else {
 		/*
diff --git a/fs/super.c b/fs/super.c
--- a/fs/super.c
+++ b/fs/super.c
@@ -171,6 +171,7 @@ void deactivate_super(struct super_block
 	if (atomic_dec_and_lock(&s->s_active, &sb_lock)) {
 		s->s_count -= S_BIAS-1;
 		spin_unlock(&sb_lock);
+		DQUOT_OFF(s);
 		down_write(&s->s_umount);
 		fs->kill_sb(s);
 		put_filesystem(fs);
diff --git a/include/linux/acct.h b/include/linux/acct.h
--- a/include/linux/acct.h
+++ b/include/linux/acct.h
@@ -117,12 +117,15 @@ struct acct_v3
 #include <linux/config.h>
 
 #ifdef CONFIG_BSD_PROCESS_ACCT
+struct vfsmount;
 struct super_block;
+extern void acct_auto_close_mnt(struct vfsmount *m);
 extern void acct_auto_close(struct super_block *sb);
 extern void acct_process(long exitcode);
 extern void acct_update_integrals(struct task_struct *tsk);
 extern void acct_clear_integrals(struct task_struct *tsk);
 #else
+#define acct_auto_close_mnt(x)	do { } while (0)
 #define acct_auto_close(x)	do { } while (0)
 #define acct_process(x)		do { } while (0)
 #define acct_update_integrals(x)		do { } while (0)
diff --git a/include/linux/mount.h b/include/linux/mount.h
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -37,6 +37,7 @@ struct vfsmount
 	struct list_head mnt_list;
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
 	struct namespace *mnt_namespace; /* containing namespace */
+	int mnt_pinned;
 };
 
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
@@ -46,15 +47,9 @@ static inline struct vfsmount *mntget(st
 	return mnt;
 }
 
-extern void __mntput(struct vfsmount *mnt);
-
-static inline void mntput_no_expire(struct vfsmount *mnt)
-{
-	if (mnt) {
-		if (atomic_dec_and_test(&mnt->mnt_count))
-			__mntput(mnt);
-	}
-}
+extern void mntput_no_expire(struct vfsmount *mnt);
+extern void mnt_pin(struct vfsmount *mnt);
+extern void mnt_unpin(struct vfsmount *mnt);
 
 static inline void mntput(struct vfsmount *mnt)
 {
diff --git a/include/linux/quota.h b/include/linux/quota.h
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -289,7 +289,6 @@ struct quota_info {
 	struct semaphore dqonoff_sem;		/* Serialize quotaon & quotaoff */
 	struct rw_semaphore dqptr_sem;		/* serialize ops using quota_info struct, pointers from inode to dquots */
 	struct inode *files[MAXQUOTAS];		/* inodes of quotafiles */
-	struct vfsmount *mnt[MAXQUOTAS];	/* mountpoint entries of filesystems with quota files */
 	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
 	struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each type */
 };
diff --git a/kernel/acct.c b/kernel/acct.c
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -54,6 +54,7 @@
 #include <linux/jiffies.h>
 #include <linux/times.h>
 #include <linux/syscalls.h>
+#include <linux/mount.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <linux/blkdev.h> /* sector_div */
@@ -192,6 +193,7 @@ static void acct_file_reopen(struct file
 		add_timer(&acct_globals.timer);
 	}
 	if (old_acct) {
+		mnt_unpin(old_acct->f_vfsmnt);
 		spin_unlock(&acct_globals.lock);
 		do_acct_process(0, old_acct);
 		filp_close(old_acct, NULL);
@@ -199,6 +201,42 @@ static void acct_file_reopen(struct file
 	}
 }
 
+static int acct_on(char *name)
+{
+	struct file *file;
+	int error;
+
+	/* Difference from BSD - they don't do O_APPEND */
+	file = filp_open(name, O_WRONLY|O_APPEND|O_LARGEFILE, 0);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	if (!S_ISREG(file->f_dentry->d_inode->i_mode)) {
+		filp_close(file, NULL);
+		return -EACCES;
+	}
+
+	if (!file->f_op->write) {
+		filp_close(file, NULL);
+		return -EIO;
+	}
+
+	error = security_acct(file);
+	if (error) {
+		filp_close(file, NULL);
+		return error;
+	}
+
+	spin_lock(&acct_globals.lock);
+	mnt_pin(file->f_vfsmnt);
+	acct_file_reopen(file);
+	spin_unlock(&acct_globals.lock);
+
+	mntput(file->f_vfsmnt);	/* it's pinned, now give up active reference */
+
+	return 0;
+}
+
 /**
  * sys_acct - enable/disable process accounting
  * @name: file name for accounting records or NULL to shutdown accounting
@@ -212,47 +250,41 @@ static void acct_file_reopen(struct file
  */
 asmlinkage long sys_acct(const char __user *name)
 {
-	struct file *file = NULL;
-	char *tmp;
 	int error;
 
 	if (!capable(CAP_SYS_PACCT))
 		return -EPERM;
 
 	if (name) {
-		tmp = getname(name);
-		if (IS_ERR(tmp)) {
+		char *tmp = getname(name);
+		if (IS_ERR(tmp))
 			return (PTR_ERR(tmp));
-		}
-		/* Difference from BSD - they don't do O_APPEND */
-		file = filp_open(tmp, O_WRONLY|O_APPEND|O_LARGEFILE, 0);
+		error = acct_on(tmp);
 		putname(tmp);
-		if (IS_ERR(file)) {
-			return (PTR_ERR(file));
-		}
-		if (!S_ISREG(file->f_dentry->d_inode->i_mode)) {
-			filp_close(file, NULL);
-			return (-EACCES);
-		}
-
-		if (!file->f_op->write) {
-			filp_close(file, NULL);
-			return (-EIO);
+	} else {
+		error = security_acct(NULL);
+		if (!error) {
+			spin_lock(&acct_globals.lock);
+			acct_file_reopen(NULL);
+			spin_unlock(&acct_globals.lock);
 		}
 	}
+	return error;
+}
 
-	error = security_acct(file);
-	if (error) {
-		if (file)
-			filp_close(file, NULL);
-		return error;
-	}
-
+/**
+ * acct_auto_close - turn off a filesystem's accounting if it is on
+ * @m: vfsmount being shut down
+ *
+ * If the accounting is turned on for a file in the subtree pointed to
+ * to by m, turn accounting off.  Done when m is about to die.
+ */
+void acct_auto_close_mnt(struct vfsmount *m)
+{
 	spin_lock(&acct_globals.lock);
-	acct_file_reopen(file);
+	if (acct_globals.file && acct_globals.file->f_vfsmnt == m)
+		acct_file_reopen(NULL);
 	spin_unlock(&acct_globals.lock);
-
-	return (0);
 }
 
 /**
@@ -266,8 +298,8 @@ void acct_auto_close(struct super_block 
 {
 	spin_lock(&acct_globals.lock);
 	if (acct_globals.file &&
-	    acct_globals.file->f_dentry->d_inode->i_sb == sb) {
-		acct_file_reopen((struct file *)NULL);
+	    acct_globals.file->f_vfsmnt->mnt_sb == sb) {
+		acct_file_reopen(NULL);
 	}
 	spin_unlock(&acct_globals.lock);
 }
