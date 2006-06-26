Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWFZNmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWFZNmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWFZNmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:42:22 -0400
Received: from mx1.mail.ru ([194.67.23.121]:22125 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S964841AbWFZNmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:42:21 -0400
Date: Mon, 26 Jun 2006 17:48:04 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3]: ufs: ufs_read_inode cleanup
Message-ID: <20060626134804.GA8138@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missed ufsi->i_dir_start_lookup initialization
in ufs_read_inode in UFS2 case. Also it cleans ufs_read_inode
function to prevent such kind of situation in the future:
it move depend on UFS type parts of code into separate
functions and leaves in ufs_read_inode only generic code.
It cleans code and avoids duplication.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.17-mm2/fs/ufs/inode.c
===================================================================
--- linux-2.6.17-mm2.orig/fs/ufs/inode.c
+++ linux-2.6.17-mm2/fs/ufs/inode.c
@@ -605,39 +605,12 @@ static void ufs_set_inode_ops(struct ino
 				   ufs_get_inode_dev(inode->i_sb, UFS_I(inode)));
 }
 
-void ufs_read_inode (struct inode * inode)
+static void ufs1_read_inode(struct inode *inode, struct ufs_inode *ufs_inode)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
-	struct super_block * sb;
-	struct ufs_sb_private_info * uspi;
-	struct ufs_inode * ufs_inode;	
-	struct ufs2_inode *ufs2_inode;
-	struct buffer_head * bh;
+	struct super_block *sb = inode->i_sb;
 	mode_t mode;
 	unsigned i;
-	unsigned flags;
-	
-	UFSD("ENTER, ino %lu\n", inode->i_ino);
-	
-	sb = inode->i_sb;
-	uspi = UFS_SB(sb)->s_uspi;
-	flags = UFS_SB(sb)->s_flags;
-
-	if (inode->i_ino < UFS_ROOTINO || 
-	    inode->i_ino > (uspi->s_ncg * uspi->s_ipg)) {
-		ufs_warning (sb, "ufs_read_inode", "bad inode number (%lu)\n", inode->i_ino);
-		goto bad_inode;
-	}
-	
-	bh = sb_bread(sb, uspi->s_sbbase + ufs_inotofsba(inode->i_ino));
-	if (!bh) {
-		ufs_warning (sb, "ufs_read_inode", "unable to read inode %lu\n", inode->i_ino);
-		goto bad_inode;
-	}
-	if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2)
-		goto ufs2_inode;
-
-	ufs_inode = (struct ufs_inode *) (bh->b_data + sizeof(struct ufs_inode) * ufs_inotofsbo(inode->i_ino));
 
 	/*
 	 * Copy data to the in-core inode.
@@ -661,14 +634,11 @@ void ufs_read_inode (struct inode * inod
 	inode->i_atime.tv_nsec = 0;
 	inode->i_ctime.tv_nsec = 0;
 	inode->i_blocks = fs32_to_cpu(sb, ufs_inode->ui_blocks);
-	inode->i_blksize = PAGE_SIZE;   /* This is the optimal IO size (for stat) */
-	inode->i_version++;
 	ufsi->i_flags = fs32_to_cpu(sb, ufs_inode->ui_flags);
 	ufsi->i_gen = fs32_to_cpu(sb, ufs_inode->ui_gen);
 	ufsi->i_shadow = fs32_to_cpu(sb, ufs_inode->ui_u3.ui_sun.ui_shadow);
 	ufsi->i_oeftflag = fs32_to_cpu(sb, ufs_inode->ui_u3.ui_sun.ui_oeftflag);
-	ufsi->i_lastfrag = (inode->i_size + uspi->s_fsize - 1) >> uspi->s_fshift;
-	ufsi->i_dir_start_lookup = 0;
+
 	
 	if (S_ISCHR(mode) || S_ISBLK(mode) || inode->i_blocks) {
 		for (i = 0; i < (UFS_NDADDR + UFS_NINDIR); i++)
@@ -677,24 +647,16 @@ void ufs_read_inode (struct inode * inod
 		for (i = 0; i < (UFS_NDADDR + UFS_NINDIR) * 4; i++)
 			ufsi->i_u1.i_symlink[i] = ufs_inode->ui_u2.ui_symlink[i];
 	}
-	ufsi->i_osync = 0;
-
-	ufs_set_inode_ops(inode);
-
-	brelse (bh);
-
-	UFSD("EXIT\n");
-	return;
+}
 
-bad_inode:
-	make_bad_inode(inode);
-	return;
+static void ufs2_read_inode(struct inode *inode, struct ufs2_inode *ufs2_inode)
+{
+	struct ufs_inode_info *ufsi = UFS_I(inode);
+	struct super_block *sb = inode->i_sb;
+	mode_t mode;
+	unsigned i;
 
-ufs2_inode :
 	UFSD("Reading ufs2 inode, ino %lu\n", inode->i_ino);
-
-	ufs2_inode = (struct ufs2_inode *)(bh->b_data + sizeof(struct ufs2_inode) * ufs_inotofsbo(inode->i_ino));
-
 	/*
 	 * Copy data to the in-core inode.
 	 */
@@ -717,26 +679,64 @@ ufs2_inode :
 	inode->i_atime.tv_nsec = 0;
 	inode->i_ctime.tv_nsec = 0;
 	inode->i_blocks = fs64_to_cpu(sb, ufs2_inode->ui_blocks);
-	inode->i_blksize = PAGE_SIZE; /*This is the optimal IO size(for stat)*/
-
-	inode->i_version++;
 	ufsi->i_flags = fs32_to_cpu(sb, ufs2_inode->ui_flags);
 	ufsi->i_gen = fs32_to_cpu(sb, ufs2_inode->ui_gen);
 	/*
 	ufsi->i_shadow = fs32_to_cpu(sb, ufs_inode->ui_u3.ui_sun.ui_shadow);
 	ufsi->i_oeftflag = fs32_to_cpu(sb, ufs_inode->ui_u3.ui_sun.ui_oeftflag);
 	*/
-	ufsi->i_lastfrag= (inode->i_size + uspi->s_fsize- 1) >> uspi->s_fshift;
 
 	if (S_ISCHR(mode) || S_ISBLK(mode) || inode->i_blocks) {
 		for (i = 0; i < (UFS_NDADDR + UFS_NINDIR); i++)
 			ufsi->i_u1.u2_i_data[i] =
 				ufs2_inode->ui_u2.ui_addr.ui_db[i];
-	}
-	else {
+	} else {
 		for (i = 0; i < (UFS_NDADDR + UFS_NINDIR) * 4; i++)
 			ufsi->i_u1.i_symlink[i] = ufs2_inode->ui_u2.ui_symlink[i];
 	}
+}
+
+void ufs_read_inode(struct inode * inode)
+{
+	struct ufs_inode_info *ufsi = UFS_I(inode);
+	struct super_block * sb;
+	struct ufs_sb_private_info * uspi;
+	struct buffer_head * bh;
+
+	UFSD("ENTER, ino %lu\n", inode->i_ino);
+
+	sb = inode->i_sb;
+	uspi = UFS_SB(sb)->s_uspi;
+
+	if (inode->i_ino < UFS_ROOTINO ||
+	    inode->i_ino > (uspi->s_ncg * uspi->s_ipg)) {
+		ufs_warning(sb, "ufs_read_inode", "bad inode number (%lu)\n",
+			    inode->i_ino);
+		goto bad_inode;
+	}
+
+	bh = sb_bread(sb, uspi->s_sbbase + ufs_inotofsba(inode->i_ino));
+	if (!bh) {
+		ufs_warning(sb, "ufs_read_inode", "unable to read inode %lu\n",
+			    inode->i_ino);
+		goto bad_inode;
+	}
+	if ((UFS_SB(sb)->s_flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2) {
+		struct ufs2_inode *ufs2_inode = (struct ufs2_inode *)bh->b_data;
+
+		ufs2_read_inode(inode,
+				ufs2_inode + ufs_inotofsbo(inode->i_ino));
+	} else {
+		struct ufs_inode *ufs_inode = (struct ufs_inode *)bh->b_data;
+
+		ufs1_read_inode(inode, ufs_inode + ufs_inotofsbo(inode->i_ino));
+	}
+
+	inode->i_blksize = PAGE_SIZE;/*This is the optimal IO size (for stat)*/
+	inode->i_version++;
+	ufsi->i_lastfrag =
+		(inode->i_size + uspi->s_fsize - 1) >> uspi->s_fshift;
+	ufsi->i_dir_start_lookup = 0;
 	ufsi->i_osync = 0;
 
 	ufs_set_inode_ops(inode);
@@ -745,6 +745,9 @@ ufs2_inode :
 
 	UFSD("EXIT\n");
 	return;
+
+bad_inode:
+	make_bad_inode(inode);
 }
 
 static int ufs_update_inode(struct inode * inode, int do_sync)

-- 
/Evgeniy

