Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVHLO4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVHLO4Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVHLO4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:56:24 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:7061 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S1751034AbVHLO4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:56:23 -0400
Message-ID: <42FCB873.8070900@namesys.com>
Date: Fri, 12 Aug 2005 18:55:47 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Tarmo_T=E4nav?= <tarmo@itech.ee>
CC: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, mason@suse.com, jeffm@suse.com,
       grev@namesys.com
Subject: Re: BUG: reiserfs+acl+quota deadlock
References: <1123643111.27819.23.camel@localhost> <20050810130009.GE22112@atrey.karlin.mff.cuni.cz> <1123684298.14562.4.camel@localhost> <20050810144024.GA18584@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20050810144024.GA18584@atrey.karlin.mff.cuni.cz>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010909010609050103010403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010909010609050103010403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

Jan Kara wrote:
>>Tried the attached patch but it changed nothing, I trying to create
>>a new file as a user whose quota grace time has ran out will still
>>cause everything accessing the users homedir (the one with the quota)
>>to hang in D state.
>>
>>Also note that the bug I reported only exists when acl is also
>>enabled (does not have to be used). And although my kernel is not
>>built with debug (or reiserfs debug) support, I don't get any
>>oopses or reiserfs errors.. it just hangs.
> 

It looks like the problem is that reiserfs_new_inode can be called either having xattrs locked or not.
It does unlocking/locking xattrs on error handling path, but has no idea about whether
xattrs are locked of not.
The attached patch seems to fix the problem.
I am not sure whether it is correct way to fix this problem, though.

Tarmo, please check if this patch works for you.

--------------010909010609050103010403
Content-Type: text/plain;
 name="reiserfs-fix-xattr-deadlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiserfs-fix-xattr-deadlock.patch"

 fs/reiserfs/inode.c         |   13 +++++++++----
 fs/reiserfs/namei.c         |    8 ++++----
 include/linux/reiserfs_fs.h |    2 +-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff -puN fs/reiserfs/inode.c~reiserfs-debug-1 fs/reiserfs/inode.c
--- linux-2.6.13-rc4-mm1/fs/reiserfs/inode.c~reiserfs-debug-1	2005-08-12 15:25:13.548577536 +0400
+++ linux-2.6.13-rc4-mm1-vs/fs/reiserfs/inode.c	2005-08-12 18:49:08.384891765 +0400
@@ -1776,7 +1776,7 @@ int reiserfs_new_inode(struct reiserfs_t
 		       /* 0 for regular, EMTRY_DIR_SIZE for dirs, 
 		          strlen (symname) for symlinks) */
 		       loff_t i_size, struct dentry *dentry,
-		       struct inode *inode)
+		       struct inode *inode, int locked)
 {
 	struct super_block *sb;
 	INITIALIZE_PATH(path_to_key);
@@ -1966,6 +1966,7 @@ int reiserfs_new_inode(struct reiserfs_t
  * are place holders for what the quota code actually needs.
  */
       out_bad_inode:
+
 	/* Invalidate the object, nothing was inserted yet */
 	INODE_PKEY(inode)->k_objectid = 0;
 
@@ -1988,11 +1989,15 @@ int reiserfs_new_inode(struct reiserfs_t
 	 * code really needs to be reworked, but this will take care of it
 	 * for now. -jeffm */
 	if (REISERFS_I(dir)->i_acl_default) {
-		reiserfs_write_unlock_xattrs(dir->i_sb);
+		if (locked)
+			reiserfs_write_unlock_xattrs(dir->i_sb);
 		iput(inode);
-		reiserfs_write_lock_xattrs(dir->i_sb);
-	} else
+		if (locked)
+			reiserfs_write_lock_xattrs(dir->i_sb);
+	} else {
 		iput(inode);
+	}
+
 	return err;
 }
 
diff -puN fs/reiserfs/namei.c~reiserfs-debug-1 fs/reiserfs/namei.c
--- linux-2.6.13-rc4-mm1/fs/reiserfs/namei.c~reiserfs-debug-1	2005-08-12 18:48:29.985413281 +0400
+++ linux-2.6.13-rc4-mm1-vs/fs/reiserfs/namei.c	2005-08-12 18:48:30.061420166 +0400
@@ -638,7 +638,7 @@ static int reiserfs_create(struct inode 
 
 	retval =
 	    reiserfs_new_inode(&th, dir, mode, NULL, 0 /*i_size */ , dentry,
-			       inode);
+			       inode, locked);
 	if (retval)
 		goto out_failed;
 
@@ -713,7 +713,7 @@ static int reiserfs_mknod(struct inode *
 
 	retval =
 	    reiserfs_new_inode(&th, dir, mode, NULL, 0 /*i_size */ , dentry,
-			       inode);
+			       inode, locked);
 	if (retval) {
 		goto out_failed;
 	}
@@ -798,7 +798,7 @@ static int reiserfs_mkdir(struct inode *
 	    retval = reiserfs_new_inode(&th, dir, mode, NULL /*symlink */ ,
 					old_format_only(dir->i_sb) ?
 					EMPTY_DIR_SIZE_V1 : EMPTY_DIR_SIZE,
-					dentry, inode);
+					dentry, inode, locked);
 	if (retval) {
 		dir->i_nlink--;
 		goto out_failed;
@@ -1086,7 +1086,7 @@ static int reiserfs_symlink(struct inode
 
 	retval =
 	    reiserfs_new_inode(&th, parent_dir, mode, name, strlen(symname),
-			       dentry, inode);
+			       dentry, inode, 0);
 	reiserfs_kfree(name, item_len, parent_dir->i_sb);
 	if (retval) {		/* reiserfs_new_inode iputs for us */
 		goto out_failed;
diff -puN include/linux/reiserfs_fs.h~reiserfs-debug-1 include/linux/reiserfs_fs.h
--- linux-2.6.13-rc4-mm1/include/linux/reiserfs_fs.h~reiserfs-debug-1	2005-08-12 18:48:30.041418354 +0400
+++ linux-2.6.13-rc4-mm1-vs/include/linux/reiserfs_fs.h	2005-08-12 18:48:30.061420166 +0400
@@ -1890,7 +1890,7 @@ struct inode *reiserfs_iget(struct super
 int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
 		       struct inode *dir, int mode,
 		       const char *symname, loff_t i_size,
-		       struct dentry *dentry, struct inode *inode);
+		       struct dentry *dentry, struct inode *inode, int locked);
 
 void reiserfs_update_sd_size(struct reiserfs_transaction_handle *th,
 			     struct inode *inode, loff_t size);

_

--------------010909010609050103010403--
