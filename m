Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWFPXMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWFPXMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWFPXM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:12:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:10916 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751553AbWFPXMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:12:21 -0400
Subject: [RFC][PATCH 04/20] elevate mnt writers for callers of vfs_mkdir()
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 16 Jun 2006 16:12:16 -0700
References: <20060616231213.D4C5D6AF@localhost.localdomain>
In-Reply-To: <20060616231213.D4C5D6AF@localhost.localdomain>
Message-Id: <20060616231216.BDCE739F@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c            |    5 +++++
 lxc-dave/fs/nfsd/nfs4recover.c |    4 ++++
 2 files changed, 9 insertions(+)

diff -puN fs/namei.c~C-elevate-writers-vfs_mkdir fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_mkdir	2006-06-16 15:58:01.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-16 15:58:01.000000000 -0700
@@ -1917,7 +1917,12 @@ asmlinkage long sys_mkdirat(int dfd, con
 
 	if (!IS_POSIXACL(nd.dentry->d_inode))
 		mode &= ~current->fs->umask;
+	error = mnt_want_write(nd.mnt);
+	if (error)
+		goto out_dput;
 	error = vfs_mkdir(nd.dentry->d_inode, dentry, mode);
+	mnt_drop_write(nd.mnt);
+out_dput:
 	dput(dentry);
 out_unlock:
 	mutex_unlock(&nd.dentry->d_inode->i_mutex);
diff -puN fs/nfsd/nfs4recover.c~C-elevate-writers-vfs_mkdir fs/nfsd/nfs4recover.c
--- lxc/fs/nfsd/nfs4recover.c~C-elevate-writers-vfs_mkdir	2006-06-16 15:58:01.000000000 -0700
+++ lxc-dave/fs/nfsd/nfs4recover.c	2006-06-16 15:58:01.000000000 -0700
@@ -155,7 +155,11 @@ nfsd4_create_clid_dir(struct nfs4_client
 		dprintk("NFSD: nfsd4_create_clid_dir: DIRECTORY EXISTS\n");
 		goto out_put;
 	}
+	status = mnt_want_write(rec_dir.mnt);
+	if (status)
+		goto out_put;
 	status = vfs_mkdir(rec_dir.dentry->d_inode, dentry, S_IRWXU);
+	mnt_drop_write(rec_dir.mnt);
 out_put:
 	dput(dentry);
 out_unlock:
_
