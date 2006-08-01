Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWHBAAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWHBAAZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 20:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWHBAAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 20:00:01 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:40869 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750770AbWHAXww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:52:52 -0400
Subject: [PATCH 12/28] elevate mnt writers for callers of vfs_mkdir()
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:49 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235249.D32CA134@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c            |    5 +++++
 lxc-dave/fs/nfsd/nfs4recover.c |    4 ++++
 2 files changed, 9 insertions(+)

diff -puN fs/namei.c~C-elevate-writers-vfs_mkdir fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_mkdir	2006-08-01 16:35:14.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-08-01 16:35:23.000000000 -0700
@@ -1952,7 +1952,12 @@ asmlinkage long sys_mkdirat(int dfd, con
 
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
--- lxc/fs/nfsd/nfs4recover.c~C-elevate-writers-vfs_mkdir	2006-08-01 16:35:10.000000000 -0700
+++ lxc-dave/fs/nfsd/nfs4recover.c	2006-08-01 16:35:23.000000000 -0700
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
