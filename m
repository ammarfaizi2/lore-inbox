Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWARATL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWARATL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWARATK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:19:10 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:60295 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964797AbWARATJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:19:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=JTwsILxWrJxvpKct+FKPEvlKSoZMuaTcl/JugAsLOjfKltLQvk6D6iQJn20lLNCGp/970MjEAUDaLd8zIL9UTXXC8qmItqRr0arrec1hFmT1uZNW+MSmYhRzMKFerVThVAHYobf8GP1wsLuQSI0t5tG2qeRno5ZTK6KTB1PqpDQ=
Date: Wed, 18 Jan 2006 03:36:30 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] sysv: switch to inode_inc_count, inode_dec_count
Message-ID: <20060118003630.GD24835@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/sysv/namei.c |   48 ++++++++++++++++++------------------------------
 1 files changed, 18 insertions(+), 30 deletions(-)

--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -16,18 +16,6 @@
 #include <linux/smp_lock.h>
 #include "sysv.h"
 
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
 	int err = sysv_add_link(dentry, inode);
@@ -35,7 +23,7 @@ static int add_nondir(struct dentry *den
 		d_instantiate(dentry, inode);
 		return 0;
 	}
-	dec_count(inode);
+	inode_dec_count(inode);
 	iput(inode);
 	return err;
 }
@@ -124,7 +112,7 @@ out:
 	return err;
 
 out_fail:
-	dec_count(inode);
+	inode_dec_count(inode);
 	iput(inode);
 	goto out;
 }
@@ -138,7 +126,7 @@ static int sysv_link(struct dentry * old
 		return -EMLINK;
 
 	inode->i_ctime = CURRENT_TIME_SEC;
-	inc_count(inode);
+	inode_inc_count(inode);
 	atomic_inc(&inode->i_count);
 
 	return add_nondir(dentry, inode);
@@ -151,7 +139,7 @@ static int sysv_mkdir(struct inode * dir
 
 	if (dir->i_nlink >= SYSV_SB(dir->i_sb)->s_link_max) 
 		goto out;
-	inc_count(dir);
+	inode_inc_count(dir);
 
 	inode = sysv_new_inode(dir, S_IFDIR|mode);
 	err = PTR_ERR(inode);
@@ -160,7 +148,7 @@ static int sysv_mkdir(struct inode * dir
 
 	sysv_set_inode(inode, 0);
 
-	inc_count(inode);
+	inode_inc_count(inode);
 
 	err = sysv_make_empty(inode, dir);
 	if (err)
@@ -175,11 +163,11 @@ out:
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
 
@@ -199,7 +187,7 @@ static int sysv_unlink(struct inode * di
 		goto out;
 
 	inode->i_ctime = dir->i_ctime;
-	dec_count(inode);
+	inode_dec_count(inode);
 out:
 	return err;
 }
@@ -213,8 +201,8 @@ static int sysv_rmdir(struct inode * dir
 		err = sysv_unlink(dir, dentry);
 		if (!err) {
 			inode->i_size = 0;
-			dec_count(inode);
-			dec_count(dir);
+			inode_dec_count(inode);
+			inode_dec_count(dir);
 		}
 	}
 	return err;
@@ -258,34 +246,34 @@ static int sysv_rename(struct inode * ol
 		new_de = sysv_find_entry(new_dentry, &new_page);
 		if (!new_de)
 			goto out_dir;
-		inc_count(old_inode);
+		inode_inc_count(old_inode);
 		sysv_set_link(new_de, new_page, old_inode);
 		new_inode->i_ctime = CURRENT_TIME_SEC;
 		if (dir_de)
 			new_inode->i_nlink--;
-		dec_count(new_inode);
+		inode_dec_count(new_inode);
 	} else {
 		if (dir_de) {
 			err = -EMLINK;
 			if (new_dir->i_nlink >= SYSV_SB(new_dir->i_sb)->s_link_max)
 				goto out_dir;
 		}
-		inc_count(old_inode);
+		inode_inc_count(old_inode);
 		err = sysv_add_link(new_dentry, old_inode);
 		if (err) {
-			dec_count(old_inode);
+			inode_dec_count(old_inode);
 			goto out_dir;
 		}
 		if (dir_de)
-			inc_count(new_dir);
+			inode_inc_count(new_dir);
 	}
 
 	sysv_delete_entry(old_de, old_page);
-	dec_count(old_inode);
+	inode_dec_count(old_inode);
 
 	if (dir_de) {
 		sysv_set_link(dir_de, dir_page, new_dir);
-		dec_count(old_dir);
+		inode_dec_count(old_dir);
 	}
 	return 0;
 

