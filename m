Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422645AbWF0WOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbWF0WOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWF0WOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:14:45 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:45786 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030436AbWF0WOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:14:44 -0400
Subject: [PATCH 04/20] elevate mnt writers for callers of vfs_mkdir()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:39 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221439.D22C5350@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c            |    5 +++++
 lxc-dave/fs/nfsd/nfs4recover.c |    4 ++++
 2 files changed, 9 insertions(+)

diff -puN fs/namei.c~C-elevate-writers-vfs_mkdir fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_mkdir	2006-06-27 10:40:26.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-27 10:40:26.000000000 -0700
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
--- lxc/fs/nfsd/nfs4recover.c~C-elevate-writers-vfs_mkdir	2006-06-27 10:40:26.000000000 -0700
+++ lxc-dave/fs/nfsd/nfs4recover.c	2006-06-27 10:40:26.000000000 -0700
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
