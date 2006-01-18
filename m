Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWARASU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWARASU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWARAST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:18:19 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:11903 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932515AbWARASR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:18:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=bXw8JBbhYFPxd+23+x+t5PVsej5d89qKMS4Bh6phdltZ2DwzSrJFDPaFoHLOM81sCCKS+v+2+koI4iUAGd/YLzg1mkJNN/tWeE2BfoMYC7RvseYPTi9C+oLoLK8ySd31CVANq4nkdFq43do/d5IGvJK7lqIvlH9dtNEXOPOxO50=
Date: Wed, 18 Jan 2006 03:35:38 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] minix: switch to inode_inc_count, inode_dec_count
Message-ID: <20060118003538.GC24835@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/minix/namei.c |   48 ++++++++++++++++++------------------------------
 1 files changed, 18 insertions(+), 30 deletions(-)

--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -6,18 +6,6 @@
 
 #include "minix.h"
 
-static inline void inc_count(struct inode *inode)
-{
-	inode->i_nlink++;
-	mark_inode_dirty(inode);
-}
-
-static inline void dec_count(struct inode *inode)
-{
-	inode->i_nlink--;
-	mark_inode_dirty(inode);
-}
-
 static int add_nondir(struct dentry *dentry, struct inode *inode)
 {
 	int err = minix_add_link(dentry, inode);
@@ -25,7 +13,7 @@ static int add_nondir(struct dentry *den
 		d_instantiate(dentry, inode);
 		return 0;
 	}
-	dec_count(inode);
+	inode_dec_count(inode);
 	iput(inode);
 	return err;
 }
@@ -125,7 +113,7 @@ out:
 	return err;
 
 out_fail:
-	dec_count(inode);
+	inode_dec_count(inode);
 	iput(inode);
 	goto out;
 }
@@ -139,7 +127,7 @@ static int minix_link(struct dentry * ol
 		return -EMLINK;
 
 	inode->i_ctime = CURRENT_TIME_SEC;
-	inc_count(inode);
+	inode_inc_count(inode);
 	atomic_inc(&inode->i_count);
 	return add_nondir(dentry, inode);
 }
@@ -152,7 +140,7 @@ static int minix_mkdir(struct inode * di
 	if (dir->i_nlink >= minix_sb(dir->i_sb)->s_link_max)
 		goto out;
 
-	inc_count(dir);
+	inode_inc_count(dir);
 
 	inode = minix_new_inode(dir, &err);
 	if (!inode)
@@ -163,7 +151,7 @@ static int minix_mkdir(struct inode * di
 		inode->i_mode |= S_ISGID;
 	minix_set_inode(inode, 0);
 
-	inc_count(inode);
+	inode_inc_count(inode);
 
 	err = minix_make_empty(inode, dir);
 	if (err)
@@ -178,11 +166,11 @@ out:
 	return err;
 
 out_fail:
-	dec_count(inode);
-	dec_count(inode);
+	inode_dec_count(inode);
+	inode_dec_count(inode);
 	iput(inode);
 out_dir:
-	dec_count(dir);
+	inode_dec_count(dir);
 	goto out;
 }
 
@@ -202,7 +190,7 @@ static int minix_unlink(struct inode * d
 		goto end_unlink;
 
 	inode->i_ctime = dir->i_ctime;
-	dec_count(inode);
+	inode_dec_count(inode);
 end_unlink:
 	return err;
 }
@@ -215,8 +203,8 @@ static int minix_rmdir(struct inode * di
 	if (minix_empty_dir(inode)) {
 		err = minix_unlink(dir, dentry);
 		if (!err) {
-			dec_count(dir);
-			dec_count(inode);
+			inode_dec_count(dir);
+			inode_dec_count(inode);
 		}
 	}
 	return err;
@@ -257,34 +245,34 @@ static int minix_rename(struct inode * o
 		new_de = minix_find_entry(new_dentry, &new_page);
 		if (!new_de)
 			goto out_dir;
-		inc_count(old_inode);
+		inode_inc_count(old_inode);
 		minix_set_link(new_de, new_page, old_inode);
 		new_inode->i_ctime = CURRENT_TIME_SEC;
 		if (dir_de)
 			new_inode->i_nlink--;
-		dec_count(new_inode);
+		inode_dec_count(new_inode);
 	} else {
 		if (dir_de) {
 			err = -EMLINK;
 			if (new_dir->i_nlink >= info->s_link_max)
 				goto out_dir;
 		}
-		inc_count(old_inode);
+		inode_inc_count(old_inode);
 		err = minix_add_link(new_dentry, old_inode);
 		if (err) {
-			dec_count(old_inode);
+			inode_dec_count(old_inode);
 			goto out_dir;
 		}
 		if (dir_de)
-			inc_count(new_dir);
+			inode_inc_count(new_dir);
 	}
 
 	minix_delete_entry(old_de, old_page);
-	dec_count(old_inode);
+	inode_dec_count(old_inode);
 
 	if (dir_de) {
 		minix_set_link(dir_de, dir_page, new_dir);
-		dec_count(old_dir);
+		inode_dec_count(old_dir);
 	}
 	return 0;
 

