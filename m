Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbUBUCga (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 21:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbUBUCga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 21:36:30 -0500
Received: from tantale.fifi.org ([216.27.190.146]:23945 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261481AbUBUCgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 21:36:13 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Nfs lost locks
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 20 Feb 2004 18:35:56 -0800
Message-ID: <87k72h17n7.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

The NFS client is prone to loose locks on filesystems when the locking
process is killed with a signal. This has been discussed on the nfs
mailing list in these threads:

  http://sourceforge.net/mailarchive/forum.php?thread_id=3213117&forum_id=4930

  http://marc.theaimsgroup.com/?l=linux-nfs&m=107074045907620&w=2

Marcelo, if the above links are not sufficient, please email back for
more details.

The enclosed patch is from Trond, and it fixes the problem.

Phil.

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.4.25-nfs-lock-race.patch

diff -ruN linux-2.4.25.orig/fs/nfs/file.c linux-2.4.25/fs/nfs/file.c
--- linux-2.4.25.orig/fs/nfs/file.c	Mon Aug 25 04:44:43 2003
+++ linux-2.4.25/fs/nfs/file.c	Wed Feb 18 13:32:05 2004
@@ -241,6 +241,93 @@
 	goto out;
 }
 
+static int
+do_getlk(struct inode *inode, int cmd, struct file_lock *fl)
+{
+	int status;
+
+	lock_kernel();
+	status = nlmclnt_proc(inode, cmd, fl);
+	unlock_kernel();
+	return status;
+}
+
+static int
+do_unlk(struct inode *inode, int cmd, struct file_lock *fl)
+{
+	sigset_t oldset;
+	int status;
+
+	rpc_clnt_sigmask(NFS_CLIENT(inode), &oldset);
+	/*
+	 * Flush all pending writes before doing anything
+	 * with locks..
+	 */
+	filemap_fdatasync(inode->i_mapping);
+	down(&inode->i_sem);
+	nfs_wb_all(inode);
+	up(&inode->i_sem);
+	filemap_fdatawait(inode->i_mapping);
+
+	/* NOTE: special case
+	 *	If we're signalled while cleaning up locks on process exit, we
+	 *	still need to complete the unlock.
+	 */
+	lock_kernel();
+	status = nlmclnt_proc(inode, cmd, fl);
+	unlock_kernel();
+	rpc_clnt_sigunmask(NFS_CLIENT(inode), &oldset);
+	return status;
+}
+
+static int
+do_setlk(struct file *filp, int cmd, struct file_lock *fl)
+{
+	struct inode * inode = filp->f_dentry->d_inode;
+	int status;
+
+	/*
+	 * Flush all pending writes before doing anything
+	 * with locks..
+	 */
+	status = filemap_fdatasync(inode->i_mapping);
+	if (status == 0) {
+		down(&inode->i_sem);
+		status = nfs_wb_all(inode);
+		up(&inode->i_sem);
+		if (status == 0)
+			status = filemap_fdatawait(inode->i_mapping);
+	}
+	if (status < 0)
+		return status;
+
+	lock_kernel();
+	status = nlmclnt_proc(inode, cmd, fl);
+	/* If we were signalled we still need to ensure that
+	 * we clean up any state on the server. We therefore
+	 * record the lock call as having succeeded in order to
+	 * ensure that locks_remove_posix() cleans it out when
+	 * the process exits.
+	 */
+	if (status == -EINTR || status == -ERESTARTSYS)
+		posix_lock_file(filp, fl, 0);
+	unlock_kernel();
+	if (status < 0)
+		return status;
+
+	/*
+	 * Make sure we clear the cache whenever we try to get the lock.
+	 * This makes locking act as a cache coherency point.
+	 */
+	filemap_fdatasync(inode->i_mapping);
+	down(&inode->i_sem);
+	nfs_wb_all(inode);      /* we may have slept */
+	up(&inode->i_sem);
+	filemap_fdatawait(inode->i_mapping);
+	nfs_zap_caches(inode);
+	return 0;
+}
+
 /*
  * Lock a (portion of) a file
  */
@@ -248,8 +335,6 @@
 nfs_lock(struct file *filp, int cmd, struct file_lock *fl)
 {
 	struct inode * inode = filp->f_dentry->d_inode;
-	int	status = 0;
-	int	status2;
 
 	dprintk("NFS: nfs_lock(f=%4x/%ld, t=%x, fl=%x, r=%Ld:%Ld)\n",
 			inode->i_dev, inode->i_ino,
@@ -266,8 +351,8 @@
 	/* Fake OK code if mounted without NLM support */
 	if (NFS_SERVER(inode)->flags & NFS_MOUNT_NONLM) {
 		if (IS_GETLK(cmd))
-			status = LOCK_USE_CLNT;
-		goto out_ok;
+			return LOCK_USE_CLNT;
+		return 0;
 	}
 
 	/*
@@ -280,42 +365,9 @@
 	if (!fl->fl_owner || (fl->fl_flags & (FL_POSIX|FL_BROKEN)) != FL_POSIX)
 		return -ENOLCK;
 
-	/*
-	 * Flush all pending writes before doing anything
-	 * with locks..
-	 */
-	status = filemap_fdatasync(inode->i_mapping);
-	down(&inode->i_sem);
-	status2 = nfs_wb_all(inode);
-	if (status2 && !status)
-		status = status2;
-	up(&inode->i_sem);
-	status2 = filemap_fdatawait(inode->i_mapping);
-	if (status2 && !status)
-		status = status2;
-	if (status < 0)
-		return status;
-
-	lock_kernel();
-	status = nlmclnt_proc(inode, cmd, fl);
-	unlock_kernel();
-	if (status < 0)
-		return status;
-	
-	status = 0;
-
-	/*
-	 * Make sure we clear the cache whenever we try to get the lock.
-	 * This makes locking act as a cache coherency point.
-	 */
- out_ok:
-	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
-		filemap_fdatasync(inode->i_mapping);
-		down(&inode->i_sem);
-		nfs_wb_all(inode);      /* we may have slept */
-		up(&inode->i_sem);
-		filemap_fdatawait(inode->i_mapping);
-		nfs_zap_caches(inode);
-	}
-	return status;
+	if (IS_GETLK(cmd))
+		return do_getlk(inode, cmd, fl);
+	if (fl->fl_type == F_UNLCK)
+		return do_unlk(inode, cmd, fl);
+	return do_setlk(filp, cmd, fl);
 }

--=-=-=--
