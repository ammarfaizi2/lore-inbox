Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWEZOWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWEZOWO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWEZOWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:22:10 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:2482 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750790AbWEZOWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:22:03 -0400
In-reply-to: <20060526142117.GA2764@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 10/10] Overhaul file locking
Message-Id: <E1FjdCG-00033w-QA@localhost.localdomain>
Date: Fri, 26 May 2006 09:21:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use exported posix_lock_file_wait() rather than re-implement it. Note
that ecryptfs_getlk() and ecryptfs_setlk() still need work; we need to
figure out how to best integrate with the existing fcntl_setlk() and
fcntl_getlk() functions in fs/locks.c.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/file.c |   71 +++++++++++++---------------------------------------
 1 files changed, 18 insertions(+), 53 deletions(-)

494162519c1eee8de78405ac35302f488a6b8ef0
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index c984ea6..c4ea9f0 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -336,40 +336,12 @@ ecryptfs_fsync(struct file *file, struct
 	return rc;
 }
 
-static void locks_delete_block(struct file_lock *waiter)
-{
-	lock_kernel();
-	list_del_init(&waiter->fl_block);
-	list_del_init(&waiter->fl_link);
-	waiter->fl_next = NULL;
-	unlock_kernel();
-}
-
-static int ecryptfs_posix_lock(struct file *file, struct file_lock *fl, int cmd)
-{
-	int rc;
-
-lock_file:
-	rc = posix_lock_file(file, fl);
-	if ((rc != -EAGAIN) || (cmd == F_SETLK))
-		goto out;
-	rc = wait_event_interruptible(fl->fl_wait, !fl->fl_next);
-	if (!rc)
-		goto lock_file;
-	locks_delete_block(fl);
-out:
-	return rc;
-}
-
 static int ecryptfs_setlk(struct file *file, int cmd, struct file_lock *fl)
 {
-	int rc = -EINVAL;
-	struct inode *inode, *lower_inode;
-	struct file *lower_file = NULL;
+	struct file *lower_file = ecryptfs_file_to_lower(file);
+	struct inode *lower_inode = lower_file->f_dentry->d_inode;
+	int rc;
 
-	lower_file = ecryptfs_file_to_lower(file);
-	inode = file->f_dentry->d_inode;
-	lower_inode = lower_file->f_dentry->d_inode;
 	/* Don't allow mandatory locks on files that may be memory mapped
 	 * and shared. */
 	if (IS_MANDLOCK(lower_inode) &&
@@ -378,7 +350,7 @@ static int ecryptfs_setlk(struct file *f
 		rc = -EAGAIN;
 		goto out;
 	}
-	if (cmd == F_SETLKW)
+	if (IS_SETLKW(cmd))
 		fl->fl_flags |= FL_SLEEP;
 	rc = -EBADF;
 	switch (fl->fl_type) {
@@ -406,29 +378,29 @@ static int ecryptfs_setlk(struct file *f
 			goto out;
 		goto upper_lock;
 	}
-	rc = ecryptfs_posix_lock(lower_file, fl, cmd);
+	rc = posix_lock_file_wait(lower_file, fl);
 	if (rc)
 		goto out;
 upper_lock:
 	fl->fl_file = file;
-	rc = ecryptfs_posix_lock(file, fl, cmd);
+	rc = posix_lock_file_wait(lower_file, fl);
 	if (rc) {
 		fl->fl_type = F_UNLCK;
 		fl->fl_file = lower_file;
-		ecryptfs_posix_lock(lower_file, fl, cmd);
+		rc = posix_lock_file_wait(lower_file, fl);
 	}
 out:
 	return rc;
 }
 
-static int ecryptfs_getlk(struct file *file, struct file_lock *fl)
+static int ecryptfs_getlk(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct file_lock cfl;
 	struct file_lock *tempfl = NULL;
 	int rc = 0;
 
 	if (file->f_op && file->f_op->lock) {
-		rc = file->f_op->lock(file, F_GETLK, fl);
+		rc = file->f_op->lock(file, cmd, fl);
 		if (rc < 0)
 			goto out;
 	} else
@@ -454,27 +426,20 @@ static int ecryptfs_fasync(int fd, struc
 
 static int ecryptfs_lock(struct file *file, int cmd, struct file_lock *fl)
 {
-	int rc = 0;
-	struct file *lower_file = NULL;
+	struct file *lower_file = ecryptfs_file_to_lower(file);
+	int rc = -EINVAL;
 
-	lower_file = ecryptfs_file_to_lower(file);
-	rc = -EINVAL;
 	if (!fl)
 		goto out;
-	fl->fl_file = lower_file;
-	switch (cmd) {
-	case F_GETLK:
-		rc = ecryptfs_getlk(lower_file, fl);
-		break;
-	case F_SETLK:
-	case F_SETLKW:
+	if (IS_GETLK(cmd)) {
+		fl->fl_file = lower_file;
+		rc = ecryptfs_getlk(lower_file, cmd, fl);
+		fl->fl_file = file;
+	} else if (IS_SETLK(cmd) || IS_SETLKW(cmd)) {
 		fl->fl_file = file;
 		rc = ecryptfs_setlk(file, cmd, fl);
-		break;
-	default:
-		rc = -EINVAL;
-	}
-	fl->fl_file = file;
+	} else
+		fl->fl_file = file;
 out:
 	return rc;
 }
-- 
1.3.3

