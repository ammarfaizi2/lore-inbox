Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWARAUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWARAUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWARAUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:20:05 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:22178 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932530AbWARAUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:20:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ni9utud/Y9DF04vvqMqvVLUdU9+2xMamvdFjISW4mywsIa7us0nsopqFjXAB5mJJ/T/qKj3o4yXaTve1H5LJwp1qhIjJ2HivbN7+3MP705OIDJcnrjVpl5k/F+/Sk0a0xLT7cTMwgHjJur0tlVT+nPkhkyjtrCr18Q5Yx0BNaF4=
Date: Wed, 18 Jan 2006 03:37:24 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ext2: switch to inode_inc_count, inode_dec_count
Message-ID: <20060118003724.GE24835@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/ext2/namei.c |   54 +++++++++++++++++++-----------------------------------
 1 files changed, 19 insertions(+), 35 deletions(-)

--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -36,22 +36,6 @@
 #include "acl.h"
 #include "xip.h"
 
-/*
- * Couple of helper functions - make the code slightly cleaner.
- */
-
-static inline void ext2_inc_count(struct inode *inode)
-{
-	inode->i_nlink++;
-	mark_inode_dirty(inode);
-}
-
-static inline void ext2_dec_count(struct inode *inode)
-{
-	inode->i_nlink--;
-	mark_inode_dirty(inode);
-}
-
 static inline int ext2_add_nondir(struct dentry *dentry, struct inode *inode)
 {
 	int err = ext2_add_link(dentry, inode);
@@ -59,7 +43,7 @@ static inline int ext2_add_nondir(struct
 		d_instantiate(dentry, inode);
 		return 0;
 	}
-	ext2_dec_count(inode);
+	inode_dec_count(inode);
 	iput(inode);
 	return err;
 }
@@ -201,7 +185,7 @@ out:
 	return err;
 
 out_fail:
-	ext2_dec_count(inode);
+	inode_dec_count(inode);
 	iput (inode);
 	goto out;
 }
@@ -215,7 +199,7 @@ static int ext2_link (struct dentry * ol
 		return -EMLINK;
 
 	inode->i_ctime = CURRENT_TIME_SEC;
-	ext2_inc_count(inode);
+	inode_inc_count(inode);
 	atomic_inc(&inode->i_count);
 
 	return ext2_add_nondir(dentry, inode);
@@ -229,7 +213,7 @@ static int ext2_mkdir(struct inode * dir
 	if (dir->i_nlink >= EXT2_LINK_MAX)
 		goto out;
 
-	ext2_inc_count(dir);
+	inode_inc_count(dir);
 
 	inode = ext2_new_inode (dir, S_IFDIR | mode);
 	err = PTR_ERR(inode);
@@ -243,7 +227,7 @@ static int ext2_mkdir(struct inode * dir
 	else
 		inode->i_mapping->a_ops = &ext2_aops;
 
-	ext2_inc_count(inode);
+	inode_inc_count(inode);
 
 	err = ext2_make_empty(inode, dir);
 	if (err)
@@ -258,11 +242,11 @@ out:
 	return err;
 
 out_fail:
-	ext2_dec_count(inode);
-	ext2_dec_count(inode);
+	inode_dec_count(inode);
+	inode_dec_count(inode);
 	iput(inode);
 out_dir:
-	ext2_dec_count(dir);
+	inode_dec_count(dir);
 	goto out;
 }
 
@@ -282,7 +266,7 @@ static int ext2_unlink(struct inode * di
 		goto out;
 
 	inode->i_ctime = dir->i_ctime;
-	ext2_dec_count(inode);
+	inode_dec_count(inode);
 	err = 0;
 out:
 	return err;
@@ -297,8 +281,8 @@ static int ext2_rmdir (struct inode * di
 		err = ext2_unlink(dir, dentry);
 		if (!err) {
 			inode->i_size = 0;
-			ext2_dec_count(inode);
-			ext2_dec_count(dir);
+			inode_dec_count(inode);
+			inode_dec_count(dir);
 		}
 	}
 	return err;
@@ -338,41 +322,41 @@ static int ext2_rename (struct inode * o
 		new_de = ext2_find_entry (new_dir, new_dentry, &new_page);
 		if (!new_de)
 			goto out_dir;
-		ext2_inc_count(old_inode);
+		inode_inc_count(old_inode);
 		ext2_set_link(new_dir, new_de, new_page, old_inode);
 		new_inode->i_ctime = CURRENT_TIME_SEC;
 		if (dir_de)
 			new_inode->i_nlink--;
-		ext2_dec_count(new_inode);
+		inode_dec_count(new_inode);
 	} else {
 		if (dir_de) {
 			err = -EMLINK;
 			if (new_dir->i_nlink >= EXT2_LINK_MAX)
 				goto out_dir;
 		}
-		ext2_inc_count(old_inode);
+		inode_inc_count(old_inode);
 		err = ext2_add_link(new_dentry, old_inode);
 		if (err) {
-			ext2_dec_count(old_inode);
+			inode_dec_count(old_inode);
 			goto out_dir;
 		}
 		if (dir_de)
-			ext2_inc_count(new_dir);
+			inode_inc_count(new_dir);
 	}
 
 	/*
 	 * Like most other Unix systems, set the ctime for inodes on a
  	 * rename.
-	 * ext2_dec_count() will mark the inode dirty.
+	 * inode_dec_count() will mark the inode dirty.
 	 */
 	old_inode->i_ctime = CURRENT_TIME_SEC;
 
 	ext2_delete_entry (old_de, old_page);
-	ext2_dec_count(old_inode);
+	inode_dec_count(old_inode);
 
 	if (dir_de) {
 		ext2_set_link(old_inode, dir_de, dir_page, new_dir);
-		ext2_dec_count(old_dir);
+		inode_dec_count(old_dir);
 	}
 	return 0;
 

