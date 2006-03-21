Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWCURQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWCURQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWCURQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:16:33 -0500
Received: from pat.uio.no ([129.240.130.16]:42914 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932206AbWCURQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:16:32 -0500
Subject: VFS,fs/locks.c,NFSD4: add race_free posix_lock_file_conf()
	interface
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       Neil Brown <neilb@suse.de>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 12:16:22 -0500
Message-Id: <1142961383.7987.23.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.886, required 12,
	autolearn=disabled, AWL 1.11, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Author: Andy Adamson <andros@citi.umich.edu>

Lockd and the NFSv4 server both exercise a race condition where
posix_test_lock() is called either before or after posix_lock_file()
to deal with a denied lock request due to a conflicting lock. 

Remove the race condition for the NFSv4 server by adding a new conflicting lock 
parameter to __posix_lock_file() , changing the name to 
__posix_lock_file_conf().

Keep posix_lock_file() interface, add posix_lock_conf() interface, both 
call __posix_lock_file_conf().

Signed-off-by: Andy Adamson <andros@citi.umich.edu>
Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/locks.c         |   28 ++++++++++++++++++++++------
 include/linux/fs.h |    1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 56f996e..1b4b899 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -798,8 +798,9 @@ out:
 }
 
 EXPORT_SYMBOL(posix_lock_file);
+EXPORT_SYMBOL(posix_lock_file_conf);
 
-static int __posix_lock_file(struct inode *inode, struct file_lock *request)
+static int __posix_lock_file_conf(struct inode *inode, struct file_lock *request, struct file_lock *conflock)
 {
 	struct file_lock *fl;
 	struct file_lock *new_fl, *new_fl2;
@@ -823,6 +824,8 @@ static int __posix_lock_file(struct inod
 				continue;
 			if (!posix_locks_conflict(request, fl))
 				continue;
+			if (conflock)
+				locks_copy_lock(conflock, fl);
 			error = -EAGAIN;
 			if (!(request->fl_flags & FL_SLEEP))
 				goto out;
@@ -992,7 +995,20 @@ static int __posix_lock_file(struct inod
  */
 int posix_lock_file(struct file *filp, struct file_lock *fl)
 {
-	return __posix_lock_file(filp->f_dentry->d_inode, fl);
+	return __posix_lock_file_conf(filp->f_dentry->d_inode, fl, NULL);
+}
+
+/**
+ * posix_lock_file_conf - Apply a POSIX-style lock to a file
+ * @filp: The file to apply the lock to
+ * @fl: The lock to be applied
+ * @conflock: Place to return a copy of the conflicting lock, if found.
+ *
+ * Except for the conflock parameter, acts just like posix_lock_file.
+ */
+int posix_lock_file_conf(struct file *filp, struct file_lock *fl, struct file_lock *conflock)
+{
+	return __posix_lock_file_conf(filp->f_dentry->d_inode, fl, conflock);
 }
 
 /**
@@ -1009,7 +1025,7 @@ int posix_lock_file_wait(struct file *fi
 	int error;
 	might_sleep ();
 	for (;;) {
-		error = __posix_lock_file(filp->f_dentry->d_inode, fl);
+		error = posix_lock_file(filp, fl);
 		if ((error != -EAGAIN) || !(fl->fl_flags & FL_SLEEP))
 			break;
 		error = wait_event_interruptible(fl->fl_wait, !fl->fl_next);
@@ -1081,7 +1097,7 @@ int locks_mandatory_area(int read_write,
 	fl.fl_end = offset + count - 1;
 
 	for (;;) {
-		error = __posix_lock_file(inode, &fl);
+		error = __posix_lock_file_conf(inode, &fl, NULL);
 		if (error != -EAGAIN)
 			break;
 		if (!(fl.fl_flags & FL_SLEEP))
@@ -1694,7 +1710,7 @@ again:
 		error = filp->f_op->lock(filp, cmd, file_lock);
 	else {
 		for (;;) {
-			error = __posix_lock_file(inode, file_lock);
+			error = posix_lock_file(filp, file_lock);
 			if ((error != -EAGAIN) || (cmd == F_SETLK))
 				break;
 			error = wait_event_interruptible(file_lock->fl_wait,
@@ -1837,7 +1853,7 @@ again:
 		error = filp->f_op->lock(filp, cmd, file_lock);
 	else {
 		for (;;) {
-			error = __posix_lock_file(inode, file_lock);
+			error = posix_lock_file(filp, file_lock);
 			if ((error != -EAGAIN) || (cmd == F_SETLK64))
 				break;
 			error = wait_event_interruptible(file_lock->fl_wait,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5dc0fa2..0824e6e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -752,6 +752,7 @@ extern void locks_copy_lock(struct file_
 extern void locks_remove_posix(struct file *, fl_owner_t);
 extern void locks_remove_flock(struct file *);
 extern int posix_test_lock(struct file *, struct file_lock *, struct file_lock *);
+extern int posix_lock_file_conf(struct file *, struct file_lock *, struct file_lock *);
 extern int posix_lock_file(struct file *, struct file_lock *);
 extern int posix_lock_file_wait(struct file *, struct file_lock *);
 extern int posix_unblock_lock(struct file *, struct file_lock *);



