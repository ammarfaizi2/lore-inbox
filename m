Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWH3CRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWH3CRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 22:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWH3CRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 22:17:50 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:44759 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932398AbWH3CRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 22:17:48 -0400
Date: Tue, 29 Aug 2006 19:17:16 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, chuck.lever@oracle.com
Subject: Re: [PATCH] Allow file systems to manually d_move() inside of ->rename()
Message-ID: <20060830021716.GQ2874@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060829215448.GO2874@ca-server1.us.oracle.com> <1156898152.5610.32.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156898152.5610.32.camel@localhost>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

On Tue, Aug 29, 2006 at 08:35:52PM -0400, Trond Myklebust wrote:
> Why have 2 synonyms for the FS_ODD_RENAME stuff? Just fix up the NFS
> client to do the d_move() unconditionally, and add a check for
> FS_ODD_RENAME to vfs_rename_dir().
Though I read through some of the nfs code when developing my ocfs2 patch, I
wasn't sure that approach was desired.

Partly because I'm not experienced enough with nfs internals to have known
whether that was safe to do, and partly because the comment in
vfs_rename_other() seemed to indicate that FS_ODD_RENAME was a temporary
solution for NFS, whereas I was looking for something more permanent.

That all said, how does this look? I took the liberty of renaming the flag
to something a little more descriptive.

During an irc conversation, Chuck pointed out that perhaps a better solution
is to just internalize the d_move() to all file systems. It makes the patch
a bit more sweeping, but I'm willing to handle it if everybody agrees on
that approach.
	--Mark


From: Mark Fasheh <mark.fasheh@oracle.com>

[PATCH] Allow file systems to manually d_move() inside of ->rename()

Some file systems want to manually d_move() the dentries involved in a
rename. We can do this by making use of the FS_ODD_RENAME flag if we just
have nfs_rename() unconditionally do the d_move(). While there, we rename
the flag to be more descriptive.

OCFS2 uses this to protect that part of the rename operation with a cluster
lock.

Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>

diff --git a/fs/namei.c b/fs/namei.c
index c784e8b..29418ec 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2353,7 +2353,8 @@ static int vfs_rename_dir(struct inode *
 		dput(new_dentry);
 	}
 	if (!error)
-		d_move(old_dentry,new_dentry);
+		if (!(old_dir->i_sb->s_type->fs_flags & FS_RENAME_DOES_D_MOVE))
+			d_move(old_dentry,new_dentry);
 	return error;
 }
 
@@ -2376,8 +2377,7 @@ static int vfs_rename_other(struct inode
 	else
 		error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
 	if (!error) {
-		/* The following d_move() should become unconditional */
-		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME))
+		if (!(old_dir->i_sb->s_type->fs_flags & FS_RENAME_DOES_D_MOVE))
 			d_move(old_dentry, new_dentry);
 	}
 	if (target)
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 3ddda6f..8ead2b9 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1623,8 +1623,7 @@ out:
 	if (rehash)
 		d_rehash(rehash);
 	if (!error) {
-		if (!S_ISDIR(old_inode->i_mode))
-			d_move(old_dentry, new_dentry);
+		d_move(old_dentry, new_dentry);
 		nfs_renew_times(new_dentry);
 		nfs_set_verifier(new_dentry, nfs_save_change_attribute(new_dir));
 	}
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index e8a9bee..6dd17db 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -120,7 +120,7 @@ static struct file_system_type nfs_fs_ty
 	.name		= "nfs",
 	.get_sb		= nfs_get_sb,
 	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
 };
 
 struct file_system_type clone_nfs_fs_type = {
@@ -128,7 +128,7 @@ struct file_system_type clone_nfs_fs_typ
 	.name		= "nfs",
 	.get_sb		= nfs_clone_nfs_sb,
 	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
 };
 
 static struct super_operations nfs_sops = {
@@ -156,7 +156,7 @@ static struct file_system_type nfs4_fs_t
 	.name		= "nfs4",
 	.get_sb		= nfs4_get_sb,
 	.kill_sb	= nfs4_kill_super,
-	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
 };
 
 struct file_system_type clone_nfs4_fs_type = {
@@ -164,7 +164,7 @@ struct file_system_type clone_nfs4_fs_ty
 	.name		= "nfs4",
 	.get_sb		= nfs_clone_nfs4_sb,
 	.kill_sb	= nfs4_kill_super,
-	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
 };
 
 struct file_system_type nfs_referral_nfs4_fs_type = {
@@ -172,7 +172,7 @@ struct file_system_type nfs_referral_nfs
 	.name		= "nfs4",
 	.get_sb		= nfs_referral_nfs4_sb,
 	.kill_sb	= nfs4_kill_super,
-	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
 };
 
 static struct super_operations nfs4_sops = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e04a5cf..7b5f889 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -88,9 +88,10 @@ #define SEL_EX		4
 #define FS_REQUIRES_DEV 1 
 #define FS_BINARY_MOUNTDATA 2
 #define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
-#define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
-				  * as nfs_rename() will be cleaned up
-				  */
+#define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move()
+					 * during rename() internally.
+					 */
+
 /*
  * These are the fs-independent mount-flags: up to 32 flags are supported
  */
