Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265863AbUFXXLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265863AbUFXXLW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUFXXLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:11:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24264 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265863AbUFXXK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:10:58 -0400
Date: Thu, 24 Jun 2004 18:10:57 -0500
From: Ken Preslan <kpreslan@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Patch to allow distributed flock
Message-ID: <20040624231057.GA13033@potassium.msp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to start a discussion about changing the VFS so it allows
flocks to be enforced between machines in a cluster filesystem (such as
GFS).  The purpose of GFS it so allow local filesystem semantics
to a filesystem shared between the nodes of a cluster of tightly-coupled
machines.  As such, flock is probably expected to work across the cluster.

What are everyone's thoughts on a patch such as this?

Thanks.


# Make the VFS call down into the FS on flock calls.
diff -urN -p linux-2.6.7/fs/locks.c linux/fs/locks.c
--- linux-2.6.7/fs/locks.c	2004-06-16 12:00:44.567463632 -0500
+++ linux/fs/locks.c	2004-06-16 12:01:58.844205936 -0500
@@ -1294,6 +1294,27 @@ out_unlock:
 	return error;
 }
 
+/*
+ * Wrapper function around the file_operations lock routine when called for
+ * flock().  The lock routine is called for both fcntl() and flock(), so
+ * the flock parameters must be translated to an equivalent fcntl()-like
+ * lock.
+ *
+ * Don't use locks_alloc_lock() (or flock_make_lock()) here, as
+ * this is just a temporary lock structure.  We especially don't
+ * want to fail because we couldn't allocate a lock structure if
+ * this is an unlock operation.
+ */
+int flock_fs_file(struct file *filp, int type, int wait)
+{
+	struct file_lock fl = { .fl_flags = FL_FLOCK,
+				.fl_type = type };
+
+	return filp->f_op->lock(filp,
+				(wait) ? F_SETLKW : F_SETLK,
+				&fl);
+}
+
 /**
  *	sys_flock: - flock() system call.
  *	@fd: the file descriptor to lock.
@@ -1342,6 +1363,50 @@ asmlinkage long sys_flock(unsigned int f
 	if (error)
 		goto out_free;
 
+	/*
+	 * Execute any filesystem-specific flock routines.  The filesystem may
+	 * maintain supplemental locks.  This code allows the supplemental locks
+	 * to be kept in sync with the vfs flock lock.  If flock() is called on
+	 * a lock already held for the given filp, the current flock lock is
+	 * dropped before obtaining the requested lock.  This unlock operation
+	 * must be completed for the any filesystem specific locks and the vfs
+	 * flock lock before proceeding with obtaining the requested lock.  When
+	 * the filesystem routine drops a lock for such a request, it must
+	 * return -EDEADLK, allowing the vfs lock to be dropped, and the
+	 * filesystem code is then re-executed to obtain the lock.
+	 *
+	 * A non-blocking request that returns EWOULDBLOCK also causes any vfs
+	 * flock lock to be released, but then returns the error to the caller.
+	 */
+	if (filp->f_op && filp->f_op->lock) {
+ repeat:
+		error = flock_fs_file(filp, lock->fl_type, can_sleep);
+		if (error < 0) {
+			/*
+			 * We may have dropped a lock.  We need to
+			 * finish unlocking before returning or
+			 * continuing with lock acquisition.
+			 */
+			if (error != -ENOLCK)
+				flock_lock_file(filp, &(struct file_lock){.fl_type = F_UNLCK});
+
+			/*
+			 * We already held the lock in some mode, and
+			 * had to drop filesystem-specific locks before
+			 * proceeding.  We come back through this
+			 * routine to unlock the vfs flock lock.  Now go
+			 * back and try again.  Using EAGAIN as the
+			 * error here would be better, but the one valid
+			 * error value defined for flock(), EWOULDBLOCK,
+			 * is defined as EAGAIN.
+			 */
+			if (error == -EDEADLK)
+				goto repeat;
+
+			goto out_free;
+		}
+	}
+
 	for (;;) {
 		error = flock_lock_file(filp, lock);
 		if ((error != -EAGAIN) || !can_sleep)
@@ -1354,6 +1419,13 @@ asmlinkage long sys_flock(unsigned int f
 		break;
 	}
 
+	/*
+	 * If we failed to get the vfs flock, we need to clean up any
+	 * filesystem-specific lock state that we previously obtained.
+	 */
+	if (error && filp->f_op && filp->f_op->lock)
+		flock_fs_file(filp, F_UNLCK, 1);
+
  out_free:
 	if (list_empty(&lock->fl_link)) {
 		locks_free_lock(lock);
@@ -1714,6 +1786,8 @@ void locks_remove_flock(struct file *fil
 		if (fl->fl_file == filp) {
 			if (IS_FLOCK(fl)) {
 				locks_delete_lock(before);
+				if (filp->f_op && filp->f_op->lock)
+					flock_fs_file(filp, F_UNLCK, 1);
 				continue;
 			}
 			if (IS_LEASE(fl)) {

-- 
Ken Preslan <kpreslan@redhat.com>

