Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVCOHu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVCOHu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 02:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbVCOHu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 02:50:57 -0500
Received: from zeus.kernel.org ([204.152.189.113]:12527 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262297AbVCOHu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 02:50:29 -0500
Date: Tue, 15 Mar 2005 18:49:49 +1100
From: Greg Banks <gnb@sgi.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] SGI 926917: make knfsd interact cleanly with HSMs
Message-ID: <20050315074949.GA4541@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

The NFSv3 protocol specifies an error, NFS3ERR_JUKEBOX, which a server
should return when an I/O operation will take a very long time.
This causes a different pattern of retries in clients, and avoids
a number of serious problems associated with I/Os which take longer
than an RPC timeout.  The Linux knfsd server has code to generate the
jukebox error and many NFS clients are known to have working code to
handle it.

One scenario in which a server should emit the JUKEBOX error is when
a file data which the client is attempting to access is managed by
an HSM (Hierarchical Storage Manager) and is not present on the disk
and needs to be brought in from tape.  Due to the nature of tapes this
operation can take minutes rather than the milliseconds normally seen
for local file data.

Currently the Linux knfsd handles this situation poorly.  A READ NFS
call will cause the nfsd thread handling it to block until the file
is available, without sending a reply to the NFS client.  After a
few seconds the client retries, and this second READ call causes
another nfsd to block behind the first one.  A few seconds later and
the client's retries have blocked *all* the nfsd threads, and all NFS
service from the server stops until the original file arrives on disk.

WRITEs and SETATTRs which truncate the file are marginally better, in
that the knfsd dupcache will catch the retries and drop them without
blocking an nfsd (the dupcache *will* catch the retries because the
cache entry remains in RC_INPROG state and is not reused until the
first call finishes).  However the first call still blocks, so given
WRITEs to enough offline files the server can still be locked up.

There are also client-side implications, depending on the client
implementation.  For example, on a Linux client an RPC retry loop uses
an RPC request slot, so reads from enough separate offline files can
lock up a mountpoint.

This patch seeks to remedy the interaction between knfsd and HSMs by
providing mechanisms to allow knfsd to tell an underlying filesystem
(which supports HSMs) not to block for reads, writes and truncates
of offline files.  It's a port of a Linux 2.4 patch used in SGI's
ProPack distro for the last 12 months.  The patch:

*  provides a new ATTR_NO_BLOCK flag which the kernel can
   use to tell a filesystem's inode_ops->setattr() operation not
   to block when truncating an offline file.  XFS already obeys
   this flag (inside a #ifdef)
   
*  changes knfsd to provide ATTR_NO_BLOCK when it does the VFS
   calls to implement the SETATTR NFS call.

*  changes knfsd to supply the O_NONBLOCK flag in the temporary
   struct file it uses for VFS reads and writes, in order to ask
   the filesystem not to block when reading or writing an offline
   file.  XFS already obeys this new semantic for O_NONBLOCK
   (and in SLES9 so does JFS).

*  adds code to translate the -EAGAIN the filesystem returns when
   it would have blocked, to the -ETIMEDOUT that knfsd expects.


Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---
 fs/nfsd/vfs.c      |   33 +++++++++++++++++++++++++++++++--
 include/linux/fs.h |    1 +
 2 files changed, 32 insertions(+), 2 deletions(-)


Index: linux/fs/nfsd/vfs.c
===================================================================
--- linux.orig/fs/nfsd/vfs.c	2005-03-07 13:13:57.000000000 +1100
+++ linux/fs/nfsd/vfs.c	2005-03-07 14:01:52.000000000 +1100
@@ -311,6 +311,16 @@ nfsd_setattr(struct svc_rqst *rqstp, str
 			goto out_nfserr;
 		}
 		DQUOT_INIT(inode);
+
+
+		/*
+		 * Tell a Hierarchical Storage Manager (e.g. via DMAPI) to
+		 * return EAGAIN when an action would take minutes instead of
+		 * milliseconds so that NFS can reply to the client with
+		 * NFSERR_JUKEBOX instead of blocking an nfsd thread.
+		 */
+		if (rqstp->rq_vers == 3)
+			iap->ia_valid |= ATTR_NO_BLOCK;
 	}
 
 	imode = inode->i_mode;
@@ -333,6 +343,9 @@ nfsd_setattr(struct svc_rqst *rqstp, str
 	if (!check_guard || guardtime == inode->i_ctime.tv_sec) {
 		fh_lock(fhp);
 		err = notify_change(dentry, iap);
+		/* to get NFSERR_JUKEBOX on the wire, need -ETIMEDOUT */
+		if (err == -EAGAIN)
+			err = -ETIMEDOUT;
 		err = nfserrno(err);
 		fh_unlock(fhp);
 	}
@@ -671,6 +684,10 @@ nfsd_read(struct svc_rqst *rqstp, struct
 	if (ra)
 		file.f_ra = ra->p_ra;
 
+	/* Support HSMs -- see comment in nfsd_setattr() */
+	if (rqstp->rq_vers == 3)
+		file.f_flags |= O_NONBLOCK;
+
 	if (file.f_op->sendfile) {
 		svc_pushback_unused_pages(rqstp);
 		err = file.f_op->sendfile(&file, &offset, *count,
@@ -694,8 +711,12 @@ nfsd_read(struct svc_rqst *rqstp, struct
 		*count = err;
 		err = 0;
 		dnotify_parent(file.f_dentry, DN_ACCESS);
-	} else 
+	} else {
+		/* to get NFSERR_JUKEBOX on the wire, need -ETIMEDOUT */
+		if (err == -EAGAIN)
+			err = -ETIMEDOUT;
 		err = nfserrno(err);
+	}
 out_close:
 	nfsd_close(&file);
 out:
@@ -756,6 +777,10 @@ nfsd_write(struct svc_rqst *rqstp, struc
 	if (stable && !EX_WGATHER(exp))
 		file.f_flags |= O_SYNC;
 
+	/* Support HSMs -- see comment in nfsd_setattr() */
+	if (rqstp->rq_vers == 3)
+		file.f_flags |= O_NONBLOCK;
+
 	/* Write the data. */
 	oldfs = get_fs(); set_fs(KERNEL_DS);
 	err = vfs_writev(&file, vec, vlen, &offset);
@@ -815,8 +840,12 @@ nfsd_write(struct svc_rqst *rqstp, struc
 	dprintk("nfsd: write complete err=%d\n", err);
 	if (err >= 0)
 		err = 0;
-	else 
+	else {
+		/* to get NFSERR_JUKEBOX on the wire, need -ETIMEDOUT */
+		if (err == -EAGAIN)
+			err = -ETIMEDOUT;
 		err = nfserrno(err);
+	}
 out_close:
 	nfsd_close(&file);
 out:
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2005-03-07 13:39:15.000000000 +1100
+++ linux/include/linux/fs.h	2005-03-07 14:01:52.000000000 +1100
@@ -257,6 +257,7 @@ typedef void (dio_iodone_t)(struct inode
 #define ATTR_KILL_SGID	4096
 #define ATTR_RAW       	8192    /* file system, not vfs will massage attrs */
 #define ATTR_FROM_OPEN 	16384    /* called from open path, ie O_TRUNC */
+#define ATTR_NO_BLOCK	32768	/* Return EAGAIN and don't block on long truncates */
 
 /*
  * This is the Inode Attributes structure, used for notify_change().  It

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
