Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133062AbRD3SOs>; Mon, 30 Apr 2001 14:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133024AbRD3SOh>; Mon, 30 Apr 2001 14:14:37 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:7892 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133062AbRD3SOT>;
	Mon, 30 Apr 2001 14:14:19 -0400
Date: Mon, 30 Apr 2001 14:14:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix fsync/fdatasync races 
In-Reply-To: <Pine.LNX.4.21.0104301213350.2097-100000@freak.distro.conectiva>
Message-ID: <Pine.GSO.4.21.0104301409380.5737-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Apr 2001, Marcelo Tosatti wrote:

> 
> Hi, 
> 
> The following patch implements a new super_operations "wait_inode"
> operation on ext2 to fix the generic_osync_inode/fsync/fdatasync race I
> mentioned sometime ago.
> 
> We still have to implement the wait_inode operation on _all_ block
> filesystems to make them safe. 
> 
> Comments?

Just one: we already have two copies of "find the on-disk inode by inumber"
code. No need to introduce the third one.

	If we do it at all, please consider the patch below. It takes the
inode-loading stuff into struct ext2_inode *ext2_get_inode(sb, ino, bhp)
and does corresponding cleanup of ext2_read_inode() and ext2_update_inode().

								Al

diff -urN S4/fs/ext2/inode.c S4-ext2_get_inode/fs/ext2/inode.c
--- S4/fs/ext2/inode.c	Sat Apr 28 02:12:56 2001
+++ S4-ext2_get_inode/fs/ext2/inode.c	Mon Apr 30 13:44:43 2001
@@ -958,56 +958,60 @@
 		mark_inode_dirty(inode);
 }
 
-void ext2_read_inode (struct inode * inode)
+static struct ext2_inode *ext2_get_inode(struct super_block *sb, ino_t ino,
+					struct buffer_head **p)
 {
 	struct buffer_head * bh;
-	struct ext2_inode * raw_inode;
 	unsigned long block_group;
-	unsigned long group_desc;
-	unsigned long desc;
 	unsigned long block;
 	unsigned long offset;
 	struct ext2_group_desc * gdp;
 
-	if ((inode->i_ino != EXT2_ROOT_INO && inode->i_ino != EXT2_ACL_IDX_INO &&
-	     inode->i_ino != EXT2_ACL_DATA_INO &&
-	     inode->i_ino < EXT2_FIRST_INO(inode->i_sb)) ||
-	    inode->i_ino > le32_to_cpu(inode->i_sb->u.ext2_sb.s_es->s_inodes_count)) {
-		ext2_error (inode->i_sb, "ext2_read_inode",
-			    "bad inode number: %lu", inode->i_ino);
-		goto bad_inode;
-	}
-	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
-	if (block_group >= inode->i_sb->u.ext2_sb.s_groups_count) {
-		ext2_error (inode->i_sb, "ext2_read_inode",
-			    "group >= groups count");
-		goto bad_inode;
-	}
-	group_desc = block_group >> EXT2_DESC_PER_BLOCK_BITS(inode->i_sb);
-	desc = block_group & (EXT2_DESC_PER_BLOCK(inode->i_sb) - 1);
-	bh = inode->i_sb->u.ext2_sb.s_group_desc[group_desc];
-	if (!bh) {
-		ext2_error (inode->i_sb, "ext2_read_inode",
-			    "Descriptor not loaded");
-		goto bad_inode;
-	}
-
-	gdp = (struct ext2_group_desc *) bh->b_data;
+	*p = NULL;
+	if ((ino != EXT2_ROOT_INO && ino != EXT2_ACL_IDX_INO &&
+	     ino != EXT2_ACL_DATA_INO && ino < EXT2_FIRST_INO(sb)) ||
+	    ino > le32_to_cpu(sb->u.ext2_sb.s_es->s_inodes_count))
+		goto Einval;
+
+	block_group = (ino - 1) / EXT2_INODES_PER_GROUP(sb);
+	gdp = ext2_get_group_desc(sb, block_group, &bh);
+	if (!gdp)
+		goto Egdp;
 	/*
 	 * Figure out the offset within the block group inode table
 	 */
-	offset = ((inode->i_ino - 1) % EXT2_INODES_PER_GROUP(inode->i_sb)) *
-		EXT2_INODE_SIZE(inode->i_sb);
-	block = le32_to_cpu(gdp[desc].bg_inode_table) +
-		(offset >> EXT2_BLOCK_SIZE_BITS(inode->i_sb));
-	if (!(bh = bread (inode->i_dev, block, inode->i_sb->s_blocksize))) {
-		ext2_error (inode->i_sb, "ext2_read_inode",
-			    "unable to read inode block - "
-			    "inode=%lu, block=%lu", inode->i_ino, block);
+	offset = ((ino - 1) % EXT2_INODES_PER_GROUP(sb))* EXT2_INODE_SIZE(sb);
+	block = le32_to_cpu(gdp->bg_inode_table) +
+		(offset >> EXT2_BLOCK_SIZE_BITS(sb));
+	if (!(bh = bread (sb->s_dev, block, sb->s_blocksize)))
+		goto Eio;
+
+	*p = bh;
+	offset &= (EXT2_BLOCK_SIZE(sb) - 1);
+	return (struct ext2_inode *) (bh->b_data + offset);
+	
+Einval:
+	ext2_error (sb, "ext2_get_inode", "bad inode number: %lu", ino);
+	return ERR_PTR(-EINVAL);
+Eio:
+	ext2_error (sb, "ext2_get_inode",
+		    "unable to read inode block - inode=%lu, block=%lu",
+		    ino, block);
+Egdp:
+	return ERR_PTR(-EIO);
+}
+
+void ext2_read_inode (struct inode * inode)
+{
+	struct ext2_inode * raw_inode;
+	struct ext2_inode_info * ei = &inode->u.ext2_i;
+	ino_t ino = inode->i_ino;
+	struct buffer_head * bh;
+	unsigned long block;
+
+	raw_inode = ext2_get_inode(inode->i_sb, ino, &bh);
+	if (IS_ERR(raw_inode))
 		goto bad_inode;
-	}
-	offset &= (EXT2_BLOCK_SIZE(inode->i_sb) - 1);
-	raw_inode = (struct ext2_inode *) (bh->b_data + offset);
 
 	inode->i_mode = le16_to_cpu(raw_inode->i_mode);
 	inode->i_uid = (uid_t)le16_to_cpu(raw_inode->i_uid_low);
@@ -1021,13 +1025,13 @@
 	inode->i_atime = le32_to_cpu(raw_inode->i_atime);
 	inode->i_ctime = le32_to_cpu(raw_inode->i_ctime);
 	inode->i_mtime = le32_to_cpu(raw_inode->i_mtime);
-	inode->u.ext2_i.i_dtime = le32_to_cpu(raw_inode->i_dtime);
+	ei->i_dtime = le32_to_cpu(raw_inode->i_dtime);
 	/* We now have enough fields to check if the inode was active or not.
 	 * This is needed because nfsd might try to access dead inodes
 	 * the test is that same one that e2fsck uses
 	 * NeilBrown 1999oct15
 	 */
-	if (inode->i_nlink == 0 && (inode->i_mode == 0 || inode->u.ext2_i.i_dtime)) {
+	if (inode->i_nlink == 0 && (inode->i_mode == 0 || ei->i_dtime)) {
 		/* this inode is deleted */
 		brelse (bh);
 		goto bad_inode;
@@ -1035,30 +1039,29 @@
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
 	inode->i_version = ++event;
-	inode->u.ext2_i.i_flags = le32_to_cpu(raw_inode->i_flags);
-	inode->u.ext2_i.i_faddr = le32_to_cpu(raw_inode->i_faddr);
-	inode->u.ext2_i.i_frag_no = raw_inode->i_frag;
-	inode->u.ext2_i.i_frag_size = raw_inode->i_fsize;
-	inode->u.ext2_i.i_file_acl = le32_to_cpu(raw_inode->i_file_acl);
+	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
+	ei->i_faddr = le32_to_cpu(raw_inode->i_faddr);
+	ei->i_frag_no = raw_inode->i_frag;
+	ei->i_frag_size = raw_inode->i_fsize;
+	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl);
 	if (S_ISDIR(inode->i_mode))
-		inode->u.ext2_i.i_dir_acl = le32_to_cpu(raw_inode->i_dir_acl);
+		ei->i_dir_acl = le32_to_cpu(raw_inode->i_dir_acl);
 	else {
-		inode->u.ext2_i.i_high_size = le32_to_cpu(raw_inode->i_size_high);
+		ei->i_high_size = le32_to_cpu(raw_inode->i_size_high);
 		inode->i_size |= ((__u64)le32_to_cpu(raw_inode->i_size_high)) << 32;
 	}
 	inode->i_generation = le32_to_cpu(raw_inode->i_generation);
-	inode->u.ext2_i.i_prealloc_count = 0;
-	inode->u.ext2_i.i_block_group = block_group;
+	ei->i_prealloc_count = 0;
+	ei->i_block_group = (ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
 
 	/*
 	 * NOTE! The in-memory inode i_data array is in little-endian order
 	 * even on big-endian machines: we do NOT byteswap the block numbers!
 	 */
 	for (block = 0; block < EXT2_N_BLOCKS; block++)
-		inode->u.ext2_i.i_data[block] = raw_inode->i_block[block];
+		ei->i_data[block] = raw_inode->i_block[block];
 
-	if (inode->i_ino == EXT2_ACL_IDX_INO ||
-	    inode->i_ino == EXT2_ACL_DATA_INO)
+	if (ino == EXT2_ACL_IDX_INO || ino == EXT2_ACL_DATA_INO)
 		/* Nothing to do */ ;
 	else if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext2_file_inode_operations;
@@ -1106,70 +1109,33 @@
 {
 	struct buffer_head * bh;
 	struct ext2_inode * raw_inode;
-	unsigned long block_group;
-	unsigned long group_desc;
-	unsigned long desc;
 	unsigned long block;
-	unsigned long offset;
 	int err = 0;
-	struct ext2_group_desc * gdp;
+	uid_t uid = inode->i_uid;
+	gid_t gid = inode->i_gid;
 
-	if ((inode->i_ino != EXT2_ROOT_INO &&
-	     inode->i_ino < EXT2_FIRST_INO(inode->i_sb)) ||
-	    inode->i_ino > le32_to_cpu(inode->i_sb->u.ext2_sb.s_es->s_inodes_count)) {
-		ext2_error (inode->i_sb, "ext2_write_inode",
-			    "bad inode number: %lu", inode->i_ino);
-		return -EIO;
-	}
-	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
-	if (block_group >= inode->i_sb->u.ext2_sb.s_groups_count) {
-		ext2_error (inode->i_sb, "ext2_write_inode",
-			    "group >= groups count");
+	raw_inode = ext2_get_inode(inode->i_sb, inode->i_ino, &bh);
+	if (IS_ERR(bh))
 		return -EIO;
-	}
-	group_desc = block_group >> EXT2_DESC_PER_BLOCK_BITS(inode->i_sb);
-	desc = block_group & (EXT2_DESC_PER_BLOCK(inode->i_sb) - 1);
-	bh = inode->i_sb->u.ext2_sb.s_group_desc[group_desc];
-	if (!bh) {
-		ext2_error (inode->i_sb, "ext2_write_inode",
-			    "Descriptor not loaded");
-		return -EIO;
-	}
-	gdp = (struct ext2_group_desc *) bh->b_data;
-	/*
-	 * Figure out the offset within the block group inode table
-	 */
-	offset = ((inode->i_ino - 1) % EXT2_INODES_PER_GROUP(inode->i_sb)) *
-		EXT2_INODE_SIZE(inode->i_sb);
-	block = le32_to_cpu(gdp[desc].bg_inode_table) +
-		(offset >> EXT2_BLOCK_SIZE_BITS(inode->i_sb));
-	if (!(bh = bread (inode->i_dev, block, inode->i_sb->s_blocksize))) {
-		ext2_error (inode->i_sb, "ext2_write_inode",
-			    "unable to read inode block - "
-			    "inode=%lu, block=%lu", inode->i_ino, block);
-		return -EIO;
-	}
-	offset &= EXT2_BLOCK_SIZE(inode->i_sb) - 1;
-	raw_inode = (struct ext2_inode *) (bh->b_data + offset);
 
 	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
 	if(!(test_opt(inode->i_sb, NO_UID32))) {
-		raw_inode->i_uid_low = cpu_to_le16(low_16_bits(inode->i_uid));
-		raw_inode->i_gid_low = cpu_to_le16(low_16_bits(inode->i_gid));
+		raw_inode->i_uid_low = cpu_to_le16(low_16_bits(uid));
+		raw_inode->i_gid_low = cpu_to_le16(low_16_bits(gid));
 /*
  * Fix up interoperability with old kernels. Otherwise, old inodes get
  * re-used with the upper 16 bits of the uid/gid intact
  */
 		if(!inode->u.ext2_i.i_dtime) {
-			raw_inode->i_uid_high = cpu_to_le16(high_16_bits(inode->i_uid));
-			raw_inode->i_gid_high = cpu_to_le16(high_16_bits(inode->i_gid));
+			raw_inode->i_uid_high = cpu_to_le16(high_16_bits(uid));
+			raw_inode->i_gid_high = cpu_to_le16(high_16_bits(gid));
 		} else {
 			raw_inode->i_uid_high = 0;
 			raw_inode->i_gid_high = 0;
 		}
 	} else {
-		raw_inode->i_uid_low = cpu_to_le16(fs_high2lowuid(inode->i_uid));
-		raw_inode->i_gid_low = cpu_to_le16(fs_high2lowgid(inode->i_gid));
+		raw_inode->i_uid_low = cpu_to_le16(fs_high2lowuid(uid));
+		raw_inode->i_gid_low = cpu_to_le16(fs_high2lowgid(gid));
 		raw_inode->i_uid_high = 0;
 		raw_inode->i_gid_high = 0;
 	}
@@ -1218,8 +1184,7 @@
 		ll_rw_block (WRITE, 1, &bh);
 		wait_on_buffer (bh);
 		if (buffer_req(bh) && !buffer_uptodate(bh)) {
-			printk ("IO error syncing ext2 inode ["
-				"%s:%08lx]\n",
+			printk ("IO error syncing ext2 inode [%s:%08lx]\n",
 				bdevname(inode->i_dev), inode->i_ino);
 			err = -EIO;
 		}

