Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWESRO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWESRO4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWESRO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:14:56 -0400
Received: from mx1.mail.ru ([194.67.23.121]:46867 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1751380AbWESROz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:14:55 -0400
Date: Fri, 19 May 2006 21:18:15 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] ufs: directory and page cache: install aops
Message-ID: <20060519171815.GA28292@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches finished "bugs fixing" mentioned 
here http://lkml.org/lkml/2006/1/31/275 .

The main bugs:
* for i in `seq 1 1000`; do touch $i; done - crash system
* mkdir create directory without "." and ".." entries

The suggested solution is
work with page cache instead of straight work with blocks.
Such solution has following advantages
* reduce code size and its complexity
* some global locks go away
* fix bugs

The most part of code is stolen from ext2, 
because of it has similar directory structure.

Patches testes with UFS1 and UFS2 file systems.



Patch in this letter install i_mapping->a_ops for
directory inodes and removes some duplicated code.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

diff -upr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4-vanilla/fs/ufs/inode.c linux-2.6.17-rc4/fs/ufs/inode.c
--- linux-2.6.17-rc4-vanilla/fs/ufs/inode.c	2006-05-17 13:00:17.995062750 +0400
+++ linux-2.6.17-rc4/fs/ufs/inode.c	2006-05-17 12:23:32.693240000 +0400
@@ -553,6 +553,28 @@ struct address_space_operations ufs_aops
 	.bmap = ufs_bmap
 };
 
+static void ufs_set_inode_ops(struct inode *inode)
+{
+	if (S_ISREG(inode->i_mode)) {
+		inode->i_op = &ufs_file_inode_operations;
+		inode->i_fop = &ufs_file_operations;
+		inode->i_mapping->a_ops = &ufs_aops;
+	} else if (S_ISDIR(inode->i_mode)) {
+		inode->i_op = &ufs_dir_inode_operations;
+		inode->i_fop = &ufs_dir_operations;
+		inode->i_mapping->a_ops = &ufs_aops;
+	} else if (S_ISLNK(inode->i_mode)) {
+		if (!inode->i_blocks)
+			inode->i_op = &ufs_fast_symlink_inode_operations;
+		else {
+			inode->i_op = &page_symlink_inode_operations;
+			inode->i_mapping->a_ops = &ufs_aops;
+		}
+	} else
+		init_special_inode(inode, inode->i_mode,
+				   ufs_get_inode_dev(inode->i_sb, UFS_I(inode)));
+}
+
 void ufs_read_inode (struct inode * inode)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
@@ -627,23 +649,7 @@ void ufs_read_inode (struct inode * inod
 	}
 	ufsi->i_osync = 0;
 
-	if (S_ISREG(inode->i_mode)) {
-		inode->i_op = &ufs_file_inode_operations;
-		inode->i_fop = &ufs_file_operations;
-		inode->i_mapping->a_ops = &ufs_aops;
-	} else if (S_ISDIR(inode->i_mode)) {
-		inode->i_op = &ufs_dir_inode_operations;
-		inode->i_fop = &ufs_dir_operations;
-	} else if (S_ISLNK(inode->i_mode)) {
-		if (!inode->i_blocks)
-			inode->i_op = &ufs_fast_symlink_inode_operations;
-		else {
-			inode->i_op = &page_symlink_inode_operations;
-			inode->i_mapping->a_ops = &ufs_aops;
-		}
-	} else
-		init_special_inode(inode, inode->i_mode,
-			ufs_get_inode_dev(sb, ufsi));
+	ufs_set_inode_ops(inode);
 
 	brelse (bh);
 
@@ -703,23 +709,7 @@ ufs2_inode :
 	}
 	ufsi->i_osync = 0;
 
-	if (S_ISREG(inode->i_mode)) {
-		inode->i_op = &ufs_file_inode_operations;
-		inode->i_fop = &ufs_file_operations;
-		inode->i_mapping->a_ops = &ufs_aops;
-	} else if (S_ISDIR(inode->i_mode)) {
-		inode->i_op = &ufs_dir_inode_operations;
-		inode->i_fop = &ufs_dir_operations;
-	} else if (S_ISLNK(inode->i_mode)) {
-		if (!inode->i_blocks)
-			inode->i_op = &ufs_fast_symlink_inode_operations;
-		else {
-			inode->i_op = &page_symlink_inode_operations;
-			inode->i_mapping->a_ops = &ufs_aops;
-		}
-	} else   /* TODO  : here ...*/
-		init_special_inode(inode, inode->i_mode,
-			ufs_get_inode_dev(sb, ufsi));
+	ufs_set_inode_ops(inode);
 
 	brelse(bh);
 
diff -upr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4-vanilla/fs/ufs/namei.c linux-2.6.17-rc4/fs/ufs/namei.c
--- linux-2.6.17-rc4-vanilla/fs/ufs/namei.c	2006-05-17 12:50:47.419404000 +0400
+++ linux-2.6.17-rc4/fs/ufs/namei.c	2006-05-17 12:23:31.773182500 +0400
@@ -205,6 +205,7 @@ static int ufs_mkdir(struct inode * dir,
 
 	inode->i_op = &ufs_dir_inode_operations;
 	inode->i_fop = &ufs_dir_operations;
+	inode->i_mapping->a_ops = &ufs_aops;
 
 	inode_inc_link_count(inode);
 


-- 
/Evgeniy

