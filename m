Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUHNTll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUHNTll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUHNTlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:41:04 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:53122 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264991AbUHNTdR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:33:17 -0400
Subject: PATCH [7/7] Fix posix locking code
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092511994.4109.39.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 15:33:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 VFS,CIFS,NLM,NFSv4: make filesystems directly responsible for
     calling posix_lock_file() if they need it. This fixes an
     NFS race whereby in case of a server reboot, the recovery
     thread could re-establish a lock that had just been freed.

 Signed-off-by: Trond Myklebust <trond.myklebust@fys.uio.no>

 fs/cifs/file.c      |    2 ++
 fs/lockd/clntproc.c |    9 ++++++++-
 fs/locks.c          |   37 ++++++++++++++++++++++++++++++++-----
 fs/nfs/nfs4proc.c   |    8 ++++++++
 include/linux/fs.h  |    1 +
 5 files changed, 51 insertions(+), 6 deletions(-)

diff -u --recursive --new-file --show-c-function linux-2.6.8.1-06-cleanup_locks/fs/cifs/file.c linux-2.6.8.1-07-cleanup_posix/fs/cifs/file.c
--- linux-2.6.8.1-06-cleanup_locks/fs/cifs/file.c	2004-08-14 14:25:48.000000000 -0400
+++ linux-2.6.8.1-07-cleanup_posix/fs/cifs/file.c	2004-08-14 14:29:49.000000000 -0400
@@ -569,6 +569,8 @@ cifs_lock(struct file *file, int cmd, st
 			 netfid, length,
 			 pfLock->fl_start, numUnlock, numLock, lockType,
 			 wait_flag);
+	if (rc == 0 && (pfLock->fl_flags & FL_POSIX))
+		posix_lock_file(file, pfLock);
 	FreeXid(xid);
 	return rc;
 }
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-06-cleanup_locks/fs/lockd/clntproc.c linux-2.6.8.1-07-cleanup_posix/fs/lockd/clntproc.c
--- linux-2.6.8.1-06-cleanup_locks/fs/lockd/clntproc.c	2004-08-14 14:29:34.000000000 -0400
+++ linux-2.6.8.1-07-cleanup_posix/fs/lockd/clntproc.c	2004-08-14 14:29:49.000000000 -0400
@@ -561,6 +561,10 @@ nlmclnt_lock(struct nlm_rqst *req, struc
 	if (resp->status == NLM_LCK_GRANTED) {
 		fl->fl_u.nfs_fl.state = host->h_state;
 		fl->fl_u.nfs_fl.flags |= NFS_LCK_GRANTED;
+		fl->fl_flags |= FL_SLEEP;
+		if (posix_lock_file_wait(fl->fl_file, fl) < 0)
+				printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n",
+						__FUNCTION__);
 	}
 	status = nlm_stat_to_errno(resp->status);
 out:
@@ -627,6 +631,9 @@ nlmclnt_unlock(struct nlm_rqst *req, str
 	if (req->a_flags & RPC_TASK_ASYNC) {
 		status = nlmclnt_async_call(req, NLMPROC_UNLOCK,
 					nlmclnt_unlock_callback);
+		/* Hrmf... Do the unlock early since locks_remove_posix()
+		 * really expects us to free the lock synchronously */
+		posix_lock_file(fl->fl_file, fl);
 		if (status < 0) {
 			nlmclnt_release_lockargs(req);
 			kfree(req);
@@ -639,6 +646,7 @@ nlmclnt_unlock(struct nlm_rqst *req, str
 	if (status < 0)
 		return status;
 
+	posix_lock_file(fl->fl_file, fl);
 	if (resp->status == NLM_LCK_GRANTED)
 		return 0;
 
@@ -669,7 +677,6 @@ nlmclnt_unlock_callback(struct rpc_task 
 	}
 	if (status != NLM_LCK_GRANTED)
 		printk(KERN_WARNING "lockd: unexpected unlock status: %d\n", status);
-
 die:
 	nlm_release_host(req->a_host);
 	nlmclnt_release_lockargs(req);
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-06-cleanup_locks/fs/locks.c linux-2.6.8.1-07-cleanup_posix/fs/locks.c
--- linux-2.6.8.1-06-cleanup_locks/fs/locks.c	2004-08-14 14:29:43.000000000 -0400
+++ linux-2.6.8.1-07-cleanup_posix/fs/locks.c	2004-08-14 14:29:49.000000000 -0400
@@ -906,6 +906,34 @@ int posix_lock_file(struct file *filp, s
 }
 
 /**
+ * posix_lock_file_wait - Apply a POSIX-style lock to a file
+ * @filp: The file to apply the lock to
+ * @fl: The lock to be applied
+ *
+ * Add a POSIX style lock to a file.
+ * We merge adjacent & overlapping locks whenever possible.
+ * POSIX locks are sorted by owner task, then by starting address
+ */
+int posix_lock_file_wait(struct file *filp, struct file_lock *fl)
+{
+	int error;
+	might_sleep ();
+	for (;;) {
+		error = __posix_lock_file(filp->f_dentry->d_inode, fl);
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
+EXPORT_SYMBOL(posix_lock_file_wait);
+
+/**
  * locks_mandatory_locked - Check for an active lock
  * @inode: the file to check
  *
@@ -1484,8 +1512,7 @@ int fcntl_setlk(struct file *filp, unsig
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
 		error = filp->f_op->lock(filp, cmd, file_lock);
-		if (error < 0)
-			goto out;
+		goto out;
 	}
 
 	for (;;) {
@@ -1619,8 +1646,7 @@ int fcntl_setlk64(struct file *filp, uns
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
 		error = filp->f_op->lock(filp, cmd, file_lock);
-		if (error < 0)
-			goto out;
+		goto out;
 	}
 
 	for (;;) {
@@ -1672,7 +1698,7 @@ void locks_remove_posix(struct file *fil
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
 		filp->f_op->lock(filp, F_SETLK, &lock);
-		/* Ignore any error -- we must remove the locks anyway */
+		goto out;
 	}
 
 	/* Can't use posix_lock_file here; we need to remove it no matter
@@ -1688,6 +1714,7 @@ void locks_remove_posix(struct file *fil
 		before = &fl->fl_next;
 	}
 	unlock_kernel();
+out:
 	if (lock.fl_ops && lock.fl_ops->fl_release_private)
 		lock.fl_ops->fl_release_private(&lock);
 }
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-06-cleanup_locks/fs/nfs/nfs4proc.c linux-2.6.8.1-07-cleanup_posix/fs/nfs/nfs4proc.c
--- linux-2.6.8.1-06-cleanup_locks/fs/nfs/nfs4proc.c	2004-08-14 14:27:16.000000000 -0400
+++ linux-2.6.8.1-07-cleanup_posix/fs/nfs/nfs4proc.c	2004-08-14 14:29:49.000000000 -0400
@@ -1856,6 +1856,8 @@ nfs4_proc_unlck(struct nfs4_state *state
 	nfs4_put_lock_state(lsp);
 out:
 	up(&state->lock_sema);
+	if (status == 0)
+		posix_lock_file(request->fl_file, request);
 	return nfs4_map_errors(status);
 }
 
@@ -1932,6 +1934,12 @@ nfs4_proc_setlk(struct nfs4_state *state
 	nfs4_put_lock_state(lsp);
 out:
 	up(&state->lock_sema);
+	if (status == 0) {
+		/* Note: we always want to sleep here! */
+		request->fl_flags |= FL_SLEEP;
+		if (posix_lock_file_wait(request->fl_file, request) < 0)
+			printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n", __FUNCTION__);
+	}
 	return nfs4_map_errors(status);
 }
 
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-06-cleanup_locks/include/linux/fs.h linux-2.6.8.1-07-cleanup_posix/include/linux/fs.h
--- linux-2.6.8.1-06-cleanup_locks/include/linux/fs.h	2004-08-14 14:29:43.000000000 -0400
+++ linux-2.6.8.1-07-cleanup_posix/include/linux/fs.h	2004-08-14 14:29:49.000000000 -0400
@@ -694,6 +694,7 @@ extern void locks_remove_posix(struct fi
 extern void locks_remove_flock(struct file *);
 extern struct file_lock *posix_test_lock(struct file *, struct file_lock *);
 extern int posix_lock_file(struct file *, struct file_lock *);
+extern int posix_lock_file_wait(struct file *, struct file_lock *);
 extern void posix_block_lock(struct file_lock *, struct file_lock *);
 extern void posix_unblock_lock(struct file *, struct file_lock *);
 extern int posix_locks_deadlock(struct file_lock *, struct file_lock *);

