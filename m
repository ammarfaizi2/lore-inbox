Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWARAVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWARAVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWARAVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:21:12 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:19659 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964934AbWARAVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:21:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=hCr+619uyjcuVI2FSbX9c6aiDIqIbzP43Lvs9+yUusizg64tJpKc675aML1zh9RfUemXBBzaOoS1vfrD86qnl4qWpsKvRqKvWFtp7r7/dxqoGBsMAzU+qBUCYdxXPZbheFuFBSfRDfp0EEKqAQo4nQluxQOd8eTfFNQfldbbCXM=
Date: Wed, 18 Jan 2006 03:38:31 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ufs: switch to inode_inc_count, inode_dec_count
Message-ID: <20060118003831.GF24835@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/ufs/namei.c |   48 ++++++++++++++++++------------------------------
 1 files changed, 18 insertions(+), 30 deletions(-)

--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -43,18 +43,6 @@
 #define UFSD(x)
 #endif
 
-static inline void ufs_inc_count(struct inode *inode)
-{
-	inode->i_nlink++;
-	mark_inode_dirty(inode);
-}
-
-static inline void ufs_dec_count(struct inode *inode)
-{
-	inode->i_nlink--;
-	mark_inode_dirty(inode);
-}
-
 static inline int ufs_add_nondir(struct dentry *dentry, struct inode *inode)
 {
 	int err = ufs_add_link(dentry, inode);
@@ -62,7 +50,7 @@ static inline int ufs_add_nondir(struct 
 		d_instantiate(dentry, inode);
 		return 0;
 	}
-	ufs_dec_count(inode);
+	inode_dec_count(inode);
 	iput(inode);
 	return err;
 }
@@ -173,7 +161,7 @@ out:
 	return err;
 
 out_fail:
-	ufs_dec_count(inode);
+	inode_dec_count(inode);
 	iput(inode);
 	goto out;
 }
@@ -191,7 +179,7 @@ static int ufs_link (struct dentry * old
 	}
 
 	inode->i_ctime = CURRENT_TIME_SEC;
-	ufs_inc_count(inode);
+	inode_inc_count(inode);
 	atomic_inc(&inode->i_count);
 
 	error = ufs_add_nondir(dentry, inode);
@@ -208,7 +196,7 @@ static int ufs_mkdir(struct inode * dir,
 		goto out;
 
 	lock_kernel();
-	ufs_inc_count(dir);
+	inode_inc_count(dir);
 
 	inode = ufs_new_inode(dir, S_IFDIR|mode);
 	err = PTR_ERR(inode);
@@ -218,7 +206,7 @@ static int ufs_mkdir(struct inode * dir,
 	inode->i_op = &ufs_dir_inode_operations;
 	inode->i_fop = &ufs_dir_operations;
 
-	ufs_inc_count(inode);
+	inode_inc_count(inode);
 
 	err = ufs_make_empty(inode, dir);
 	if (err)
@@ -234,11 +222,11 @@ out:
 	return err;
 
 out_fail:
-	ufs_dec_count(inode);
-	ufs_dec_count(inode);
+	inode_dec_count(inode);
+	inode_dec_count(inode);
 	iput (inode);
 out_dir:
-	ufs_dec_count(dir);
+	inode_dec_count(dir);
 	unlock_kernel();
 	goto out;
 }
@@ -260,7 +248,7 @@ static int ufs_unlink(struct inode * dir
 		goto out;
 
 	inode->i_ctime = dir->i_ctime;
-	ufs_dec_count(inode);
+	inode_dec_count(inode);
 	err = 0;
 out:
 	unlock_kernel();
@@ -277,8 +265,8 @@ static int ufs_rmdir (struct inode * dir
 		err = ufs_unlink(dir, dentry);
 		if (!err) {
 			inode->i_size = 0;
-			ufs_dec_count(inode);
-			ufs_dec_count(dir);
+			inode_dec_count(inode);
+			inode_dec_count(dir);
 		}
 	}
 	unlock_kernel();
@@ -319,35 +307,35 @@ static int ufs_rename (struct inode * ol
 		new_de = ufs_find_entry (new_dentry, &new_bh);
 		if (!new_de)
 			goto out_dir;
-		ufs_inc_count(old_inode);
+		inode_inc_count(old_inode);
 		ufs_set_link(new_dir, new_de, new_bh, old_inode);
 		new_inode->i_ctime = CURRENT_TIME_SEC;
 		if (dir_de)
 			new_inode->i_nlink--;
-		ufs_dec_count(new_inode);
+		inode_dec_count(new_inode);
 	} else {
 		if (dir_de) {
 			err = -EMLINK;
 			if (new_dir->i_nlink >= UFS_LINK_MAX)
 				goto out_dir;
 		}
-		ufs_inc_count(old_inode);
+		inode_inc_count(old_inode);
 		err = ufs_add_link(new_dentry, old_inode);
 		if (err) {
-			ufs_dec_count(old_inode);
+			inode_dec_count(old_inode);
 			goto out_dir;
 		}
 		if (dir_de)
-			ufs_inc_count(new_dir);
+			inode_inc_count(new_dir);
 	}
 
 	ufs_delete_entry (old_dir, old_de, old_bh);
 
-	ufs_dec_count(old_inode);
+	inode_dec_count(old_inode);
 
 	if (dir_de) {
 		ufs_set_link(old_inode, dir_de, dir_bh, new_dir);
-		ufs_dec_count(old_dir);
+		inode_dec_count(old_dir);
 	}
 	unlock_kernel();
 	return 0;

