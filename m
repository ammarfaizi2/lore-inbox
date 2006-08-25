Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422901AbWHYUzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422901AbWHYUzt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWHYUzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:55:49 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:14037 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932464AbWHYUzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:55:48 -0400
Date: Fri, 25 Aug 2006 15:55:45 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: mhalcrow@us.ibm.com, jsipek@cs.sunysb.edu, dquigley@fsl.cs.sunysb.edu,
       linux-kernel@vger.kernel.org
Subject: [PATCH] eCryptfs: Remove lock propagation
Message-ID: <20060825205545.GB8171@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove propagation of locks down to the lower filesystem.

The current implementation does not work right (in some use case
scenarios, IS_FLOCK(fl) and IS_LEASE(fl) are both false for the lower
file in locks_remove_flock(), leading to a BUG()). I attribute this to
the fact that the code is copied and hacked from locks.c, when in
reality, stacked filesystems should find a way to call the locking
code in locks.c. As long as there is no propagation of locks up from
the lower filesystem, there really is little point in pretending to
keep upper and lower locks in sync. When eCryptfs is operating on the
files in a lower directory, nothing else should be trying to operate
on those files at the same time.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/file.c |   99 ----------------------------------------------------
 1 files changed, 0 insertions(+), 99 deletions(-)

fcca7f5a1e7b966855ef5eaae2258cd1e3a9fee1
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 6d6c62c..bfb5453 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -343,83 +343,6 @@ ecryptfs_fsync(struct file *file, struct
 	return rc;
 }
 
-static int ecryptfs_setlk(struct file *file, int cmd, struct file_lock *fl)
-{
-	struct file *lower_file = ecryptfs_file_to_lower(file);
-	struct inode *lower_inode = lower_file->f_dentry->d_inode;
-	int rc;
-
-	/* Don't allow mandatory locks on files that may be memory mapped
-	 * and shared. */
-	if (IS_MANDLOCK(lower_inode) &&
-	    (lower_inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID &&
-	    mapping_writably_mapped(lower_file->f_mapping)) {
-		rc = -EAGAIN;
-		goto out;
-	}
-	if (IS_SETLKW(cmd))
-		fl->fl_flags |= FL_SLEEP;
-	rc = -EBADF;
-	switch (fl->fl_type) {
-	case F_RDLCK:
-		if (!(lower_file->f_mode & FMODE_READ))
-			goto out;
-		break;
-	case F_WRLCK:
-		if (!(lower_file->f_mode & FMODE_WRITE))
-			goto out;
-		break;
-	case F_UNLCK:
-		break;
-	default:
-		rc = -EINVAL;
-		goto out;
-	}
-	fl->fl_file = lower_file;
-	rc = security_file_lock(lower_file, fl->fl_type);
-	if (rc)
-		goto out;
-	if (lower_file->f_op && lower_file->f_op->lock) {
-		rc = lower_file->f_op->lock(lower_file, cmd, fl);
-		if (rc)
-			goto out;
-		goto upper_lock;
-	}
-	rc = posix_lock_file_wait(lower_file, fl);
-	if (rc)
-		goto out;
-upper_lock:
-	fl->fl_file = file;
-	rc = posix_lock_file_wait(lower_file, fl);
-	if (rc) {
-		fl->fl_type = F_UNLCK;
-		fl->fl_file = lower_file;
-		rc = posix_lock_file_wait(lower_file, fl);
-	}
-out:
-	return rc;
-}
-
-static int ecryptfs_getlk(struct file *file, int cmd, struct file_lock *fl)
-{
-	struct file_lock cfl;
-	struct file_lock *tempfl = NULL;
-	int rc = 0;
-
-	if (file->f_op && file->f_op->lock) {
-		rc = file->f_op->lock(file, cmd, fl);
-		if (rc < 0)
-			goto out;
-	} else
-		tempfl = (posix_test_lock(file, fl, &cfl) ? &cfl : NULL);
-	if (!tempfl)
-		fl->fl_type = F_UNLCK;
-	else
-		memcpy(fl, tempfl, sizeof(struct file_lock));
-out:
-	return rc;
-}
-
 static int ecryptfs_fasync(int fd, struct file *file, int flag)
 {
 	int rc = 0;
@@ -431,26 +354,6 @@ static int ecryptfs_fasync(int fd, struc
 	return rc;
 }
 
-static int ecryptfs_lock(struct file *file, int cmd, struct file_lock *fl)
-{
-	struct file *lower_file = ecryptfs_file_to_lower(file);
-	int rc = -EINVAL;
-
-	if (!fl)
-		goto out;
-	if (IS_GETLK(cmd)) {
-		fl->fl_file = lower_file;
-		rc = ecryptfs_getlk(lower_file, cmd, fl);
-		fl->fl_file = file;
-	} else if (IS_SETLK(cmd) || IS_SETLKW(cmd)) {
-		fl->fl_file = file;
-		rc = ecryptfs_setlk(file, cmd, fl);
-	} else
-		fl->fl_file = file;
-out:
-	return rc;
-}
-
 static ssize_t ecryptfs_sendfile(struct file *file, loff_t * ppos,
 				 size_t count, read_actor_t actor, void *target)
 {
@@ -477,7 +380,6 @@ const struct file_operations ecryptfs_di
 	.release = ecryptfs_release,
 	.fsync = ecryptfs_fsync,
 	.fasync = ecryptfs_fasync,
-	.lock = ecryptfs_lock,
 	.sendfile = ecryptfs_sendfile,
 };
 
@@ -495,7 +397,6 @@ const struct file_operations ecryptfs_ma
 	.release = ecryptfs_release,
 	.fsync = ecryptfs_fsync,
 	.fasync = ecryptfs_fasync,
-	.lock = ecryptfs_lock,
 	.sendfile = ecryptfs_sendfile,
 };
 
-- 
1.3.3

