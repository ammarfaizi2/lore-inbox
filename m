Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbWF0WQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWF0WQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422654AbWF0WPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:15:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:40632 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030453AbWF0WO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:14:56 -0400
Subject: [PATCH 11/20] elevate write count over calls to vfs_rename()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:49 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221449.FAD07060@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This does create a little helper in the NFS code to
make an if() a little bit less ugly.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c    |    4 ++++
 lxc-dave/fs/nfsd/vfs.c |   25 ++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff -puN fs/namei.c~C-elevate-writers-vfs_rename-part1 fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_rename-part1	2006-06-27 10:40:30.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-27 10:40:30.000000000 -0700
@@ -2544,8 +2544,12 @@ static int do_rename(int olddfd, const c
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
--- lxc/fs/nfsd/vfs.c~C-elevate-writers-vfs_rename-part1	2006-06-27 10:40:30.000000000 -0700
+++ lxc-dave/fs/nfsd/vfs.c	2006-06-27 10:40:30.000000000 -0700
@@ -1534,6 +1534,14 @@ out_nfserr:
 	goto out_unlock;
 }
 
+static inline int svc_msnfs(struct svc_fh *ffhp)
+{
+#ifdef MSNFS
+	return (ffhp->fh_export->ex_flags & NFSEXP_MSNFS);
+#else
+	return 0;
+#endif
+}
 /*
  * Rename a file
  * N.B. After this call _both_ ffhp and tfhp need an fh_put
@@ -1594,20 +1602,27 @@ nfsd_rename(struct svc_rqst *rqstp, stru
 	if (ndentry == trap)
 		goto out_dput_new;
 
-#ifdef MSNFS
-	if ((ffhp->fh_export->ex_flags & NFSEXP_MSNFS) &&
+	if (svc_msnfs(ffhp) &&
 		((atomic_read(&odentry->d_count) > 1)
 		 || (atomic_read(&ndentry->d_count) > 1))) {
 			err = -EPERM;
-	} else
-#endif
+			goto out_dput_new;
+	}
+
+	err = -EXDEV;
+	if (ffhp->fh_export->ex_mnt != tfhp->fh_export->ex_mnt)
+		goto out_dput_new;
+	err = mnt_want_write(ffhp->fh_export->ex_mnt);
+	if (err)
+		goto out_dput_new;
+
 	err = vfs_rename(fdir, odentry, tdir, ndentry);
 	if (!err && EX_ISSYNC(tfhp->fh_export)) {
 		err = nfsd_sync_dir(tdentry);
 		if (!err)
 			err = nfsd_sync_dir(fdentry);
 	}
-
+	mnt_drop_write(ffhp->fh_export->ex_mnt);
  out_dput_new:
 	dput(ndentry);
  out_dput_old:
_
