Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268479AbUH3PT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268479AbUH3PT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 11:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268484AbUH3PT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 11:19:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37347 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268479AbUH3PTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 11:19:49 -0400
Date: Mon, 30 Aug 2004 10:19:45 -0500
From: Ken Preslan <kpreslan@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Allow cluster-wide flock
Message-ID: <20040830151945.GA16894@potassium.msp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is a patch that lets a cluster filesystem (such as GFS) implement
flock across a the cluster.  Please apply.

Thanks!


diff -urN -p linux-2.6.9-rc1-mm1/fs/locks.c linux/fs/locks.c
--- linux-2.6.9-rc1-mm1/fs/locks.c	2004-08-27 10:54:32.939282703 -0500
+++ linux/fs/locks.c	2004-08-27 10:54:34.540910950 -0500
@@ -1318,6 +1318,33 @@ out_unlock:
 }
 
 /**
+ * flock_lock_file_wait - Apply a FLOCK-style lock to a file
+ * @filp: The file to apply the lock to
+ * @fl: The lock to be applied
+ *
+ * Add a FLOCK style lock to a file.
+ */
+int flock_lock_file_wait(struct file *filp, struct file_lock *fl)
+{
+	int error;
+	might_sleep();
+	for (;;) {
+		error = flock_lock_file(filp, fl);
+		if ((error != -EAGAIN) || !(fl->fl_flags & FL_SLEEP))
+			break;
+		error = wait_event_interruptible(fl->fl_wait, !fl->fl_next);
+		if (!error)
+			continue;
+
+		locks_delete_block(fl);
+		break;
+	}
+	return error;
+}
+
+EXPORT_SYMBOL(flock_lock_file_wait);
+
+/**
  *	sys_flock: - flock() system call.
  *	@fd: the file descriptor to lock.
  *	@cmd: the type of lock to apply.
@@ -1365,6 +1392,13 @@ asmlinkage long sys_flock(unsigned int f
 	if (error)
 		goto out_free;
 
+	if (filp->f_op && filp->f_op->lock) {
+		error = filp->f_op->lock(filp,
+					(can_sleep) ? F_SETLKW : F_SETLK,
+					lock);
+		goto out_free;
+	}
+
 	for (;;) {
 		error = flock_lock_file(filp, lock);
 		if ((error != -EAGAIN) || !can_sleep)
@@ -1732,6 +1766,12 @@ void locks_remove_flock(struct file *fil
 	if (!inode->i_flock)
 		return;
 
+	if (filp->f_op && filp->f_op->lock) {
+		struct file_lock fl = { .fl_flags = FL_FLOCK,
+					.fl_type = F_UNLCK };
+		filp->f_op->lock(filp, F_SETLKW, &fl);
+	}	
+
 	lock_kernel();
 	before = &inode->i_flock;
 
diff -urN -p linux-2.6.9-rc1-mm1/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.6.9-rc1-mm1/include/linux/fs.h	2004-08-27 10:54:32.941282239 -0500
+++ linux/include/linux/fs.h	2004-08-27 10:54:34.541910717 -0500
@@ -697,6 +697,7 @@ extern int posix_lock_file_wait(struct f
 extern void posix_block_lock(struct file_lock *, struct file_lock *);
 extern void posix_unblock_lock(struct file *, struct file_lock *);
 extern int posix_locks_deadlock(struct file_lock *, struct file_lock *);
+extern int flock_lock_file_wait(struct file *filp, struct file_lock *fl);
 extern int __break_lease(struct inode *inode, unsigned int flags);
 extern void lease_get_mtime(struct inode *, struct timespec *time);
 extern int lock_may_read(struct inode *, loff_t start, unsigned long count);


