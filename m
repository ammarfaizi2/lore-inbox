Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUA1Qdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 11:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbUA1Qdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 11:33:31 -0500
Received: from www.trustcorps.com ([213.165.226.2]:44558 "EHLO raq1.nitrex.net")
	by vger.kernel.org with ESMTP id S266004AbUA1QdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 11:33:19 -0500
Message-ID: <4017E3B9.3090605@hcunix.net>
Date: Wed, 28 Jan 2004 16:30:49 +0000
From: the grugq <grugq@hcunix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PATCH - ext2fs privacy (i.e. secure deletion) patch
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030906060107060000070901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030906060107060000070901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've written a quick patch to the ext2fs which ensures that inodes, data 
  blocks, and directory entries are overwritten with null bytes when 
they are deleted. The patch adds a couple of inline functions to 
overwrite the appropriate data with zeroes. Its quite simple and 
self-explanitory. Both attached patches are to a vanilla 2.4.24 kernel.

inodes: ext2_delete_inode() now uses the inline function delete_inode() 
to mark the on-disk inode as 'deleted'. If the privacy option is not 
enabled, then the i_dtime is set as per usual operation, otherwise the 
meta-data are all set to 0. After the inode has been truncated, the 
i_data is set to 0 by delete_blocks() and the inode is written to disk 
again.

Splitting the delete_inode() and delete_blocks() functions is not ideal, 
I would prefer that one function remove the meta-data and the inode be 
written out just once. The problem is that ext2_truncate() needs the 
i_data information from the struct inode, and we want to remove this 
information from the inode on the disk. To ensure that the i_data is 0 
by the time it hits the disk, I write the inode to disk twice, which is 
not optimal.

directory entries: ext2_delete_entry() now uses the inline function 
mark_delete_dir() to indicate that the directory entry is no longer 
valid. If the privacy patch is not enabled, then the dir->inode is set 
to  0 as per normal operation, otherwise the entry is memset 0. Very 
straightforward.

blocks: ext2_free_blocks() now uses the inline function destroy_block() 
before it updates the group meta-data. The destroy_block() function 
overwrites the block with zeroes. I'm not sure that it is implemented 
correctly, I don't know anything about buffer_heads. The block is only 
overwritten with a single pass of zeroes. It is, of course, possible to 
have a full 37 pass overwriter with full bit toggling maps and all that, 
but I think it might make more sense to add a new option for that, 
something like: CONFIG_EXT2_FS_PRIVACY_EXTREME_PARANOIA. For preventing 
simple forensic analysis (that is, what the police, employers and even 
most government agencies do) a single pass with zeroes is sufficient. 
Users can use userland tools like wipe or srm for more thorough overwriting.

There is also a patch to ext3fs, which adds the same functionality (in 
the same way) as the ext2fs privacy patch. However, the main problem 
with privacy on the ext3fs is the journal. I am not familiar enough with 
how the journal transactions are handled to implement what seems to me 
the obvious solution: when a transaction is complete (i.e. doesn't need 
to be replayed by fsck) overwrite it with null bytes. If done correctly, 
it is possible to leave sufficient information for fsck to find the 
right transaction to begin replaying, without leaving any data which 
would be of use to a forensic analyst.

Given the existing global political climate, privacy control over a file 
system seems like a no-brainer to me. Full privacy options would include 
things like mounting disks with noatime, and possibly normalizing the 
mtime and ctime of all inodes (setting everthing to an arbitrary date, 
e.g. 0). Certainly this will break tools like make which require atime, 
but it would provide even less information to a forensic analyst 
examining the file system.



peace,

--gq

ps. apologies for posting to the kernel mailing list, but I'm not sure 
who is the maintainer for ext2/3.





--------------030906060107060000070901
Content-Type: text/plain;
 name="privacy_patch_ext2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="privacy_patch_ext2"

--- linux-2.4.24/fs/Config.in	2003-11-28 18:26:21.000000000 +0000
+++ linux-2.4.24/fs/Config.in-ext2-privacy	2004-01-27 21:56:58.000000000 +0000
@@ -92,6 +92,7 @@
 tristate 'ROM file system support' CONFIG_ROMFS_FS
 
 tristate 'Second extended fs support' CONFIG_EXT2_FS
+dep_mbool '  ext2 privacy support' CONFIG_EXT2_FS_PRIVACY $CONFIG_EXT2_FS
 
 tristate 'System V/Xenix/V7/Coherent file system support' CONFIG_SYSV_FS
 
--- linux-2.4.24/fs/ext2/balloc.c	2003-06-13 15:51:37.000000000 +0100
+++ linux-2.4.24/fs/ext2-privacy/balloc.c	2004-01-28 00:52:59.000000000 +0000
@@ -247,6 +247,23 @@
 	return slot;
 }
 
+static inline void destroy_block(struct inode *inode, unsigned long block)
+{
+#ifdef CONFIG_EXT2_FS_PRIVACY
+	struct buffer_head	* bh;
+
+	bh = sb_getblk(inode->i_sb, block);
+
+	memset(bh->b_data, 0x00, bh->b_size);
+
+	mark_buffer_dirty(bh);
+	wait_on_buffer(bh);
+	brelse(bh);
+
+	return;
+#endif
+}
+
 /* Free given blocks, update quota and i_blocks field */
 void ext2_free_blocks (struct inode * inode, unsigned long block,
 		       unsigned long count)
@@ -319,6 +336,8 @@
 				   "bit already cleared for block %lu", block);
 		else {
 			DQUOT_FREE_BLOCK(inode, 1);
+
+			destroy_block(sb, block);
 			gdp->bg_free_blocks_count =
 				cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count)+1);
 			es->s_free_blocks_count =
--- linux-2.4.24/fs/ext2/dir.c	2002-11-28 23:53:15.000000000 +0000
+++ linux-2.4.24/fs/ext2-privacy/dir.c	2004-01-25 17:15:27.000000000 +0000
@@ -468,6 +468,15 @@
 	return err;
 }
 
+static inline mark_deleted_dir(struct ext2_dir_entry_2 *dir)
+{
+#ifndef CONFIG_EXT2_FS_PRIVACY
+	dir->inode = 0;
+#else
+	memset(dir, 0, dir->rec_len);
+#endif
+}
+
 /*
  * ext2_delete_entry deletes a directory entry by merging it with the
  * previous entry. Page is up-to-date. Releases the page.
@@ -495,7 +504,7 @@
 		BUG();
 	if (pde)
 		pde->rec_len = cpu_to_le16(to-from);
-	dir->inode = 0;
+	mark_deleted_dir(dir);
 	err = ext2_commit_chunk(page, from, to);
 	UnlockPage(page);
 	ext2_put_page(page);
--- linux-2.4.24/fs/ext2/inode.c	2003-06-13 15:51:37.000000000 +0100
+++ linux-2.4.24/fs/ext2-privacy/inode.c	2004-01-27 21:33:59.000000000 +0000
@@ -46,6 +46,36 @@
 	ext2_discard_prealloc (inode);
 }
 
+static inline void delete_inode(struct inode *inode)
+{
+#ifndef CONFIG_EXT2_FS_PRIVACY
+	inode->u.ext2_i.i_dtime	= CURRENT_TIME;
+#else
+	inode->i_mode	= 0;
+	inode->i_uid	= 0;
+	inode->i_gid	= 0;
+	inode->i_nlink	= 0;
+	inode->i_atime	= 0;
+	inode->i_ctime	= 0;
+	inode->i_mtime	= 0;
+	inode->u.ext2_i.i_dtime	= 0;
+	inode->u.ext2_i.i_flags	= 0;
+	inode->u.ext2_i.i_faddr	= 0;
+	inode->u.ext2_i.i_frag_no	= 0;
+	inode->u.ext2_i.i_frag_size	= 0;
+	inode->u.ext2_i.i_file_acl	= 0;
+	inode->i_generation	= 0;
+#endif
+}
+
+static inline void delete_blocks(struct inode *inode)
+{
+#ifdef CONFIG_EXT2_FS_PRIVACY
+	inode->i_blocks	= 0;
+	memset(&inode->u.ext2_i.i_data, 0x00, sizeof(inode->u.ext2_i.i_data));
+#endif
+}
+
 /*
  * Called at the last iput() if i_nlink is zero.
  */
@@ -57,12 +87,18 @@
 	    inode->i_ino == EXT2_ACL_IDX_INO ||
 	    inode->i_ino == EXT2_ACL_DATA_INO)
 		goto no_delete;
-	inode->u.ext2_i.i_dtime	= CURRENT_TIME;
+
+	delete_inode(inode);
 	mark_inode_dirty(inode);
 	ext2_update_inode(inode, IS_SYNC(inode));
+
 	inode->i_size = 0;
 	if (inode->i_blocks)
 		ext2_truncate (inode);
+	delete_blocks(inode);
+       mark_inode_dirty(inode);
+       ext2_update_inode(inode, IS_SYNC(inode));
+
 	ext2_free_inode (inode);
 
 	unlock_kernel();

--------------030906060107060000070901
Content-Type: text/plain;
 name="privacy_patch_ext3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="privacy_patch_ext3"

--- linux-2.4.24/fs/Config.in	2003-11-28 18:26:21.000000000 +0000
+++ linux-2.4.24/fs/Config.in-ext3-privacy	2004-01-27 21:57:22.000000000 +0000
@@ -34,6 +34,7 @@
 # dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
 define_bool CONFIG_JBD $CONFIG_EXT3_FS
 dep_mbool '  JBD (ext3) debugging support' CONFIG_JBD_DEBUG $CONFIG_JBD
+dep_mbool '  ext3 privacy support' CONFIG_EXT3_FS_PRIVACY $CONFIG_EXT3_FS
 
 # msdos file systems
 tristate 'DOS FAT fs support' CONFIG_FAT_FS
--- linux-2.4.24/fs/ext3/balloc.c	2003-06-13 15:51:37.000000000 +0100
+++ linux-2.4.24/fs/ext3-privacy/balloc.c	2004-01-28 00:44:56.000000000 +0000
@@ -252,6 +252,23 @@
 	return slot;
 }
 
+static inline void destroy_block(struct inode *inode, unsigned long block)
+{
+#ifdef CONFIG_EXT3_FS_PRIVACY
+	struct buffer_head	* bh;
+
+	bh = sb_getblk(inode->i_sb, block);
+
+	memset(bh->b_data, 0x00, bh->b_size);
+
+	mark_buffer_dirty(bh);
+	wait_on_buffer(bh);
+	brelse(bh);
+
+	return;
+#endif
+}
+
 /* Free given blocks, update quota and i_blocks field */
 void ext3_free_blocks (handle_t *handle, struct inode * inode,
 			unsigned long block, unsigned long count)
@@ -370,6 +387,7 @@
 			BUFFER_TRACE(bitmap_bh, "bit already cleared");
 		} else {
 			dquot_freed_blocks++;
+			destroy_block(sb, block);
 			gdp->bg_free_blocks_count =
 			  cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count)+1);
 			es->s_free_blocks_count =
--- linux-2.4.24/fs/ext3/inode.c	2003-08-25 12:44:43.000000000 +0100
+++ linux-2.4.24/fs/ext3-privacy/inode.c	2004-01-27 21:48:54.000000000 +0000
@@ -172,6 +172,28 @@
 	ext3_discard_prealloc (inode);
 }
 
+static inline void delete_inode(struct inode *inode)
+{
+#ifndef CONFIG_EXT3_FS_PRIVACY
+	inode->u.ext3_i.i_dtime	= CURRENT_TIME;
+#else
+	inode->i_mode	= 0;
+	inode->i_uid	= 0;
+	inode->i_gid	= 0;
+	inode->i_nlink	= 0;
+	inode->i_size	= 0;
+	inode->i_blocks	= 0;
+	inode->i_atime	= 0;
+	inode->i_ctime	= 0;
+	inode->i_mtime	= 0;
+	inode->u.ext3_i.i_dtime	= 0;
+	inode->u.ext3_i.i_flags	= 0;
+	inode->u.ext3_i.i_file_acl	= 0;
+	inode->i_generation	= 0;
+	memset(&inode->u.ext3_i.i_data, 0x00, sizeof(inode->u.ext3_i.i_data));
+#endif
+}
+
 /*
  * Called at the last iput() if i_nlink is zero.
  */
@@ -211,7 +233,7 @@
 	 * (Well, we could do this if we need to, but heck - it works)
 	 */
 	ext3_orphan_del(handle, inode);
-	inode->u.ext3_i.i_dtime	= CURRENT_TIME;
+	delete_inode(inode);
 
 	/* 
 	 * One subtle ordering requirement: if anything has gone wrong

--------------030906060107060000070901--
