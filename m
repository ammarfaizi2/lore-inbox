Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWFPXNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWFPXNs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWFPXMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:12:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:47263 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751547AbWFPXM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:12:26 -0400
Subject: [RFC][PATCH 11/20] elevate write count over calls to vfs_rename()
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 16 Jun 2006 16:12:21 -0700
References: <20060616231213.D4C5D6AF@localhost.localdomain>
In-Reply-To: <20060616231213.D4C5D6AF@localhost.localdomain>
Message-Id: <20060616231221.C30C0D59@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c    |    4 ++++
 lxc-dave/fs/nfsd/vfs.c |   12 +++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff -puN fs/namei.c~C-elevate-writers-vfs_rename-part1 fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_rename-part1	2006-06-16 15:58:06.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-16 15:58:06.000000000 -0700
@@ -2520,8 +2520,12 @@ static int do_rename(int olddfd, const c
 	if (new_dentry == trap)
 		goto exit5;
 
+	error = mnt_want_write(oldnd.mnt);
+	if (error)
+		goto exit5;
 	error = vfs_rename(old_dir->d_inode, old_dentry,
 				   new_dir->d_inode, new_dentry);
+	mnt_drop_write(oldnd.mnt);
 exit5:
 	dput(new_dentry);
 exit4:
diff -puN fs/nfsd/vfs.c~C-elevate-writers-vfs_rename-part1 fs/nfsd/vfs.c
--- lxc/fs/nfsd/vfs.c~C-elevate-writers-vfs_rename-part1	2006-06-16 15:58:06.000000000 -0700
+++ lxc-dave/fs/nfsd/vfs.c	2006-06-16 15:58:06.000000000 -0700
@@ -1597,13 +1597,23 @@ nfsd_rename(struct svc_rqst *rqstp, stru
 			err = -EPERM;
 	} else
 #endif
+	err = mnt_want_write(ffhp->fh_export->ex_mnt);
+	if (err)
+		goto out_dput_new;
+
+	err = mnt_want_write(tfhp->fh_export->ex_mnt);
+	if (err)
+		goto out_mnt_drop_write_old;
+
 	err = vfs_rename(fdir, odentry, tdir, ndentry);
 	if (!err && EX_ISSYNC(tfhp->fh_export)) {
 		err = nfsd_sync_dir(tdentry);
 		if (!err)
 			err = nfsd_sync_dir(fdentry);
 	}
-
+	mnt_drop_write(tfhp->fh_export->ex_mnt);
+ out_mnt_drop_write_old:
+	mnt_drop_write(ffhp->fh_export->ex_mnt);
  out_dput_new:
 	dput(ndentry);
  out_dput_old:
_
