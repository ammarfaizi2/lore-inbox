Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315334AbSGINqs>; Tue, 9 Jul 2002 09:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSGINqs>; Tue, 9 Jul 2002 09:46:48 -0400
Received: from mons.uio.no ([129.240.130.14]:6385 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S315334AbSGINqq>;
	Tue, 9 Jul 2002 09:46:46 -0400
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
Date: Tue, 9 Jul 2002 15:49:15 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_3EIZKYOXMIGWH0CRXSTH"
Message-Id: <200207091549.15913.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_3EIZKYOXMIGWH0CRXSTH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi,

   There was a bug reported on the 'exim' user list a couple of months ago: 
the Linux NFS client reports -EINVAL if you try to fsync() a directory.

   The correct response would be to return a dummy '0' for success, since all 
NFS operations that change the directory are supposed to be performed 
synchronously on the server anyway...

Cheers,
  Trond


--------------Boundary-00=_3EIZKYOXMIGWH0CRXSTH
Content-Type: text/plain;
  charset="us-ascii";
  name="linux-2.4.19-fsync_dir.dif"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.4.19-fsync_dir.dif"

diff -u --recursive --new-file linux-2.4.19-rc1/fs/nfs/dir.c linux-2.4.19-fsync_dir/fs/nfs/dir.c
--- linux-2.4.19-rc1/fs/nfs/dir.c	Tue Mar 12 16:35:02 2002
+++ linux-2.4.19-fsync_dir/fs/nfs/dir.c	Tue Jul  9 15:41:29 2002
@@ -45,12 +45,14 @@
 static int nfs_mknod(struct inode *, struct dentry *, int, int);
 static int nfs_rename(struct inode *, struct dentry *,
 		      struct inode *, struct dentry *);
+static int nfs_fsync_dir(struct file *, struct dentry *, int);
 
 struct file_operations nfs_dir_operations = {
 	read:		generic_read_dir,
 	readdir:	nfs_readdir,
 	open:		nfs_open,
 	release:	nfs_release,
+	fsync:		nfs_fsync_dir
 };
 
 struct inode_operations nfs_dir_inode_operations = {
@@ -401,6 +403,15 @@
 	return 0;
 }
 
+/*
+ * All directory operations under NFS are synchronous, so fsync()
+ * is a dummy operation.
+ */
+int nfs_fsync_dir(struct file *filp, struct dentry *dentry, int datasync)
+{
+	return 0;
+}
+
 /*
  * A check for whether or not the parent directory has changed.
  * In the case it has, we assume that the dentries are untrustworthy

--------------Boundary-00=_3EIZKYOXMIGWH0CRXSTH--
