Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVJQNWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVJQNWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 09:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVJQNWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 09:22:52 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:19585 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751250AbVJQNWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 09:22:51 -0400
Date: Mon, 17 Oct 2005 11:23:06 -0200
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, adilger@clusterfs.com, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] Test for sb_getblk return value
Message-ID: <20051017132306.GA30328@br.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: glauber@br.ibm.com (Glauber de Oliveira Costa)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

As we discussed earlier, I'm sending a patch that adds test for the
return value of sb_getblk. This time I focused on the code of the ext2/3
filesystems. I'm assuming that getblk fails happens due to I/O errors
and thus returning returning an EIO back wherever it's needed.

Al, hope it's better this time.

-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
glommer@br.ibm.com
=====================================

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch_getblk_ext3

diff -Naurp linux-2.6.14-rc2-orig/fs/ext2/inode.c linux-2.6.14-rc2-cleanp/fs/ext2/inode.c
--- linux-2.6.14-rc2-orig/fs/ext2/inode.c	2005-09-26 13:58:15.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext2/inode.c	2005-10-17 12:32:46.000000000 +0000
@@ -439,7 +439,10 @@ static int ext2_alloc_branch(struct inod
 		 * Get buffer_head for parent block, zero it out and set 
 		 * the pointer to new one, then send parent to disk.
 		 */
-		bh = sb_getblk(inode->i_sb, parent);
+		if (!(bh = sb_getblk(inode->i_sb, parent))){
+			err = -EIO;
+			break;
+		}
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;
diff -Naurp linux-2.6.14-rc2-orig/fs/ext3/inode.c linux-2.6.14-rc2-cleanp/fs/ext3/inode.c
--- linux-2.6.14-rc2-orig/fs/ext3/inode.c	2005-10-09 20:26:54.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext3/inode.c	2005-10-17 12:28:38.000000000 +0000
@@ -523,14 +523,15 @@ static int ext3_alloc_branch(handle_t *h
 			if (!nr)
 				break;
 			branch[n].key = cpu_to_le32(nr);
-			keys = n+1;
 
 			/*
 			 * Get buffer_head for parent block, zero it out
 			 * and set the pointer to new one, then send
 			 * parent to disk.  
 			 */
-			bh = sb_getblk(inode->i_sb, parent);
+			if (!(bh = sb_getblk(inode->i_sb, parent)))
+				break;	
+			keys = n+1;
 			branch[n].bh = bh;
 			lock_buffer(bh);
 			BUFFER_TRACE(bh, "call get_create_access");
@@ -863,7 +864,10 @@ struct buffer_head *ext3_getblk(handle_t
 	*errp = ext3_get_block_handle(handle, inode, block, &dummy, create, 1);
 	if (!*errp && buffer_mapped(&dummy)) {
 		struct buffer_head *bh;
-		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
+		if (!(bh = sb_getblk(inode->i_sb, dummy.b_blocknr))){
+			*errp = -EIO;
+			return NULL;
+		}
 		if (buffer_new(&dummy)) {
 			J_ASSERT(create != 0);
 			J_ASSERT(handle != 0);
diff -Naurp linux-2.6.14-rc2-orig/fs/ext3/resize.c linux-2.6.14-rc2-cleanp/fs/ext3/resize.c
--- linux-2.6.14-rc2-orig/fs/ext3/resize.c	2005-10-09 19:58:40.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext3/resize.c	2005-10-17 12:41:49.000000000 +0000
@@ -117,7 +117,8 @@ static struct buffer_head *bclean(handle
 	struct buffer_head *bh;
 	int err;
 
-	bh = sb_getblk(sb, blk);
+	if (!(bh = sb_getblk(sb, blk)))
+		return ERR_PTR(-EIO);
 	if ((err = ext3_journal_get_write_access(handle, bh))) {
 		brelse(bh);
 		bh = ERR_PTR(err);
@@ -201,7 +202,10 @@ static int setup_new_group_blocks(struct
 
 		ext3_debug("update backup group %#04lx (+%d)\n", block, bit);
 
-		gdb = sb_getblk(sb, block);
+		if (!(gdb = sb_getblk(sb, block))){
+			err = -EIO;
+			goto exit_bh;
+		}
 		if ((err = ext3_journal_get_write_access(handle, gdb))) {
 			brelse(gdb);
 			goto exit_bh;
@@ -642,7 +646,10 @@ static void update_backups(struct super_
 		    (err = ext3_journal_restart(handle, EXT3_MAX_TRANS_DATA)))
 			break;
 
-		bh = sb_getblk(sb, group * bpg + blk_off);
+		if (!(bh = sb_getblk(sb, group * bpg + blk_off))){
+			err = -EIO;
+			goto exit_err;
+		}
 		ext3_debug("update metadata backup %#04lx\n",
 			  (unsigned long)bh->b_blocknr);
 		if ((err = ext3_journal_get_write_access(handle, bh)))

--AhhlLboLdkugWU4S--
