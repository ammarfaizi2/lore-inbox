Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162960AbWLBLPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162960AbWLBLPn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162961AbWLBLPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:15:43 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:20767 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1162960AbWLBLPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:15:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=fkNycan6QXwkAsgcFlPL0WniAEQQIPNGfCxa3ebNV4VEygxMqYXmx83GoqbQE0pgasVGVdrt413sa4yRlWHUV5ydDQyyn754/1TAKRSKKPhIl9tSiO2OT8pa94ct+YSdzVcMIG3IqKhsBwynjc25Ol6in8WpO7YwNL5j/beX/zM=
Subject: [PATCH 2.6.19] ext[2-4]: replace kmalloc+memset with kzalloc
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com, trivial@kernel.org
Content-Type: text/plain
Date: Sat, 02 Dec 2006 13:17:39 +0200
Message-Id: <1165058259.4523.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Replace kmalloc+memset with kzalloc

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc5_orig/fs/ext2/super.c linux-2.6.19-rc5_kzalloc/fs/ext2/super.c
--- linux-2.6.19-rc5_orig/fs/ext2/super.c	2006-11-09 12:16:20.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/fs/ext2/super.c	2006-11-11 22:44:04.000000000 +0200
@@ -883,13 +883,12 @@ static int ext2_fill_super(struct super_
 		goto failed_mount;
 	}
 	bgl_lock_init(&sbi->s_blockgroup_lock);
-	sbi->s_debts = kmalloc(sbi->s_groups_count * sizeof(*sbi->s_debts),
+	sbi->s_debts = kcalloc(sbi->s_groups_count, sizeof(*sbi->s_debts),
 			       GFP_KERNEL);
 	if (!sbi->s_debts) {
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount_group_desc;
 	}
-	memset(sbi->s_debts, 0, sbi->s_groups_count * sizeof(*sbi->s_debts));
 	for (i = 0; i < db_count; i++) {
 		block = descriptor_loc(sb, logic_sb_block, i);
 		sbi->s_group_desc[i] = sb_bread(sb, block);
diff -rubp linux-2.6.19-rc5_orig/fs/ext3/xattr.c linux-2.6.19-rc5_kzalloc/fs/ext3/xattr.c
--- linux-2.6.19-rc5_orig/fs/ext3/xattr.c	2006-11-09 12:16:20.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/fs/ext3/xattr.c	2006-11-11 22:44:04.000000000 +0200
@@ -733,12 +733,11 @@ ext3_xattr_block_set(handle_t *handle, s
 		}
 	} else {
 		/* Allocate a buffer where we construct the new block. */
-		s->base = kmalloc(sb->s_blocksize, GFP_KERNEL);
+		s->base = kzalloc(sb->s_blocksize, GFP_KERNEL);
 		/* assert(header == s->base) */
 		error = -ENOMEM;
 		if (s->base == NULL)
 			goto cleanup;
-		memset(s->base, 0, sb->s_blocksize);
 		header(s->base)->h_magic = cpu_to_le32(EXT3_XATTR_MAGIC);
 		header(s->base)->h_blocks = cpu_to_le32(1);
 		header(s->base)->h_refcount = cpu_to_le32(1);
diff -rubp linux-2.6.19-rc5_orig/fs/ext4/extents.c linux-2.6.19-rc5_kzalloc/fs/ext4/extents.c
--- linux-2.6.19-rc5_orig/fs/ext4/extents.c	2006-11-09 12:16:20.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/fs/ext4/extents.c	2006-11-11 22:44:04.000000000 +0200
@@ -641,10 +641,9 @@ static int ext4_ext_split(handle_t *hand
 	 * We need this to handle errors and free blocks
 	 * upon them.
 	 */
-	ablocks = kmalloc(sizeof(ext4_fsblk_t) * depth, GFP_NOFS);
+	ablocks = kcalloc(depth, sizeof(ext4_fsblk_t), GFP_NOFS);
 	if (!ablocks)
 		return -ENOMEM;
-	memset(ablocks, 0, sizeof(ext4_fsblk_t) * depth);
 
 	/* allocate all needed blocks */
 	ext_debug("allocate %d blocks for indexes/leaf\n", depth - at);
@@ -1756,12 +1755,11 @@ int ext4_ext_remove_space(struct inode *
 	 * We start scanning from right side, freeing all the blocks
 	 * after i_size and walking into the tree depth-wise.
 	 */
-	path = kmalloc(sizeof(struct ext4_ext_path) * (depth + 1), GFP_KERNEL);
+	path = kcalloc(depth + 1, sizeof(struct ext4_ext_path), GFP_KERNEL);
 	if (path == NULL) {
 		ext4_journal_stop(handle);
 		return -ENOMEM;
 	}
-	memset(path, 0, sizeof(struct ext4_ext_path) * (depth + 1));
 	path[0].p_hdr = ext_inode_hdr(inode);
 	if (ext4_ext_check_header(__FUNCTION__, inode, path[0].p_hdr)) {
 		err = -EIO;
diff -rubp linux-2.6.19-rc5_orig/fs/ext4/xattr.c linux-2.6.19-rc5_kzalloc/fs/ext4/xattr.c
--- linux-2.6.19-rc5_orig/fs/ext4/xattr.c	2006-11-09 12:16:20.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/fs/ext4/xattr.c	2006-11-11 22:44:04.000000000 +0200
@@ -733,12 +733,11 @@ ext4_xattr_block_set(handle_t *handle, s
 		}
 	} else {
 		/* Allocate a buffer where we construct the new block. */
-		s->base = kmalloc(sb->s_blocksize, GFP_KERNEL);
+		s->base = kzalloc(sb->s_blocksize, GFP_KERNEL);
 		/* assert(header == s->base) */
 		error = -ENOMEM;
 		if (s->base == NULL)
 			goto cleanup;
-		memset(s->base, 0, sb->s_blocksize);
 		header(s->base)->h_magic = cpu_to_le32(EXT4_XATTR_MAGIC);
 		header(s->base)->h_blocks = cpu_to_le32(1);
 		header(s->base)->h_refcount = cpu_to_le32(1);




