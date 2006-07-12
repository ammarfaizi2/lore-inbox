Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWGLSVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWGLSVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWGLSVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:21:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:63460 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932343AbWGLSRW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:22 -0400
Subject: [RFC][PATCH 10/27] elevate mnt writers for callers of vfs_mkdir()
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:17 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181717.40DA3238@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c            |    5 +++++
 lxc-dave/fs/nfsd/nfs4recover.c |    4 ++++
 2 files changed, 9 insertions(+)

diff -puN fs/namei.c~C-elevate-writers-vfs_mkdir fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_mkdir	2006-07-12 11:09:18.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-07-12 11:09:27.000000000 -0700
@@ -1939,7 +1939,12 @@ asmlinkage long sys_mkdirat(int dfd, con
 
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
--- lxc/fs/nfsd/nfs4recover.c~C-elevate-writers-vfs_mkdir	2006-07-12 11:09:15.000000000 -0700
+++ lxc-dave/fs/nfsd/nfs4recover.c	2006-07-12 11:09:27.000000000 -0700
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
