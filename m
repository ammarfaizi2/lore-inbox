Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbTLIIPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 03:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266135AbTLIIPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 03:15:45 -0500
Received: from tantale.fifi.org ([216.27.190.146]:48000 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S266134AbTLIIPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 03:15:33 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS client] NFS locks not released on abnormal process termination
References: <20031208033933.16136.qmail@web20024.mail.yahoo.com>
	<shszne3risb.fsf@charged.uio.no> <877k17rzai.fsf@ceramic.fifi.org>
	<1070913367.2941.137.camel@nidelv.trondhjem.org>
From: Philippe Troin <phil@fifi.org>
Date: 09 Dec 2003 00:15:24 -0800
Message-ID: <87llpms8yr.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> P=E5 m=E5 , 08/12/2003 klokka 12:32, skreiv Philippe Troin:
> > Trond, do you think I should push the patch to Marcelo, or should I
> > wait for a better fix?
>=20
> No. If I wanted a partial fix, I could just as well have pushed it to
> Marcelo myself. When I said "feel free" I was referring to pursuing the
> remaining signalling bugs.

Ok... Although I willing to "feel free", I might not have enough time
and ability...

> I have a feeling the second race case of your test is that you are
> interrupting the fcntl(F_SETLK) call while it is on the wire. If you do
> that, then the server may record the lock as taken, but the client will
> never receive the reply, and so will not know that it must clean up
> locks...
>
> Hmm... For that case, we probably want to have the locking code record
> the call as having succeeded in order to ensure that we do indeed clear
> out the lock on process exit. See if the appended patch helps...

Thanks Trond.

>From my reading of the patch, it supersedes the old patch, and is only
necessary on the client. Is also does not compile :-)
Here's an updated patch which does compile.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.4.23-nfs-lock-race-2.patch

diff -ruN linux-2.4.23.orig/fs/nfs/file.c linux-2.4.23/fs/nfs/file.c
--- linux-2.4.23.orig/fs/nfs/file.c	Mon Dec  8 12:11:39 2003
+++ linux-2.4.23/fs/nfs/file.c	Mon Dec  8 12:26:31 2003
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

--=-=-=


I am still running tests, but so far it looks good (that is all locks
are freed when a process with locks running on a NFS client is
killed).

I am still running tests and will report their result later.

Phil.

--=-=-=--
