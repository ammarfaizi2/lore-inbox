Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVJJUfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVJJUfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 16:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVJJUfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 16:35:18 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:39585 "EHLO
	tux06.ltc.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S1751212AbVJJUfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 16:35:16 -0400
Date: Mon, 10 Oct 2005 17:45:17 -0300
From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk,
       mikulas@artax.karlin.mff.cuni.cz, akpm@osdl.org
Subject: [PATCH] Use of getblk differs between locations
Message-ID: <20051010204517.GA30867@br.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I've just noticed that the use of sb_getblk differs between locations
inside the kernel. To be precise, in some locations there are tests
against its return value, and in some places there are not.

According to the comments in __getblk definition, the tests are not
necessary, as the function always return a buffer_head (maybe a wrong
one),

The patch bellow just make it's use homogeneous trough the whole code
in the various filesystems that use it.

One thing to mention, is that I've kept my hands away from hpfs code.
That's because sb_getblk is used inside another function, that returns
NULL in the case sb_getblk does it too (Which does not seem to happen).
The correct action would be trace down all the uses of that function and
change it.

-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
glommer@br.ibm.com
=====================================

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch_getblk

diff -Naurp linux-2.6.14-rc2-orig/fs/ext2/xattr.c linux-2.6.14-rc2-cleanp/fs/ext2/xattr.c
--- linux-2.6.14-rc2-orig/fs/ext2/xattr.c	2005-09-01 14:26:03.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext2/xattr.c	2005-10-10 19:47:27.000000000 +0000
@@ -679,11 +679,6 @@ ext2_xattr_set2(struct inode *inode, str
 			ea_idebug(inode, "creating block %d", block);
 
 			new_bh = sb_getblk(sb, block);
-			if (!new_bh) {
-				ext2_free_blocks(inode, block, 1);
-				error = -EIO;
-				goto cleanup;
-			}
 			lock_buffer(new_bh);
 			memcpy(new_bh->b_data, header, new_bh->b_size);
 			set_buffer_uptodate(new_bh);
diff -Naurp linux-2.6.14-rc2-orig/fs/fat/dir.c linux-2.6.14-rc2-cleanp/fs/fat/dir.c
--- linux-2.6.14-rc2-orig/fs/fat/dir.c	2005-09-26 13:58:15.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/fat/dir.c	2005-10-10 19:37:47.000000000 +0000
@@ -46,7 +46,7 @@ static inline void fat_dir_readahead(str
 		return;
 
 	bh = sb_getblk(sb, phys);
-	if (bh && !buffer_uptodate(bh)) {
+	if (!buffer_uptodate(bh)) {
 		for (sec = 0; sec < sbi->sec_per_clus; sec++)
 			sb_breadahead(sb, phys + sec);
 	}
@@ -978,10 +978,6 @@ static int fat_zeroed_cluster(struct ino
 	n = nr_used;
 	while (blknr < last_blknr) {
 		bhs[n] = sb_getblk(sb, blknr);
-		if (!bhs[n]) {
-			err = -ENOMEM;
-			goto error;
-		}
 		memset(bhs[n]->b_data, 0, sb->s_blocksize);
 		set_buffer_uptodate(bhs[n]);
 		mark_buffer_dirty(bhs[n]);
@@ -1031,10 +1027,6 @@ int fat_alloc_new_dir(struct inode *dir,
 
 	blknr = fat_clus_to_blknr(sbi, cluster);
 	bhs[0] = sb_getblk(sb, blknr);
-	if (!bhs[0]) {
-		err = -ENOMEM;
-		goto error_free;
-	}
 
 	fat_date_unix2dos(ts->tv_sec, &time, &date);
 
@@ -1113,10 +1105,6 @@ static int fat_add_new_entries(struct in
 		last_blknr = start_blknr + sbi->sec_per_clus;
 		while (blknr < last_blknr) {
 			bhs[n] = sb_getblk(sb, blknr);
-			if (!bhs[n]) {
-				err = -ENOMEM;
-				goto error_nomem;
-			}
 
 			/* fill the directory entry */
 			copy = min(size, sb->s_blocksize);
diff -Naurp linux-2.6.14-rc2-orig/fs/fat/fatent.c linux-2.6.14-rc2-cleanp/fs/fat/fatent.c
--- linux-2.6.14-rc2-orig/fs/fat/fatent.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/fat/fatent.c	2005-10-10 19:38:10.000000000 +0000
@@ -357,10 +357,6 @@ static int fat_mirror_bhs(struct super_b
 
 		for (n = 0; n < nr_bhs; n++) {
 			c_bh = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
-			if (!c_bh) {
-				err = -ENOMEM;
-				goto error;
-			}
 			memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
 			set_buffer_uptodate(c_bh);
 			mark_buffer_dirty(c_bh);
diff -Naurp linux-2.6.14-rc2-orig/fs/isofs/inode.c linux-2.6.14-rc2-cleanp/fs/isofs/inode.c
--- linux-2.6.14-rc2-orig/fs/isofs/inode.c	2005-09-01 14:26:03.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/isofs/inode.c	2005-10-10 19:55:40.000000000 +0000
@@ -994,8 +994,6 @@ int isofs_get_blocks(struct inode *inode
 			map_bh(*bh, inode->i_sb, firstext + b_off - offset);
 		} else {
 			*bh = sb_getblk(inode->i_sb, firstext+b_off-offset);
-			if ( !*bh )
-				goto abort;
 		}
 		bh++;	/* Next buffer head */
 		b_off++;	/* Next buffer offset */
diff -Naurp linux-2.6.14-rc2-orig/fs/ntfs/compress.c linux-2.6.14-rc2-cleanp/fs/ntfs/compress.c
--- linux-2.6.14-rc2-orig/fs/ntfs/compress.c	2005-09-26 13:58:16.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ntfs/compress.c	2005-10-10 19:50:15.000000000 +0000
@@ -641,8 +641,7 @@ lock_retry_remap:
 		max_block = block + (vol->cluster_size >> block_size_bits);
 		do {
 			ntfs_debug("block = 0x%x.", block);
-			if (unlikely(!(bhs[nr_bhs] = sb_getblk(sb, block))))
-				goto getblk_err;
+			bhs[nr_bhs] = sb_getblk(sb, block);
 			nr_bhs++;
 		} while (++block < max_block);
 	}
@@ -938,9 +937,6 @@ rl_err:
 			"compression block.");
 	goto err_out;
 
-getblk_err:
-	up_read(&ni->runlist.lock);
-	ntfs_error(vol->sb, "getblk() failed. Cannot read compression block.");
 
 err_out:
 	kfree(bhs);
diff -Naurp linux-2.6.14-rc2-orig/fs/sysv/balloc.c linux-2.6.14-rc2-cleanp/fs/sysv/balloc.c
--- linux-2.6.14-rc2-orig/fs/sysv/balloc.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/sysv/balloc.c	2005-10-10 19:52:03.000000000 +0000
@@ -75,11 +75,6 @@ void sysv_free_block(struct super_block 
 	if (count == sbi->s_flc_size || count == 0) {
 		block += sbi->s_block_base;
 		bh = sb_getblk(sb, block);
-		if (!bh) {
-			printk("sysv_free_block: getblk() failed\n");
-			unlock_super(sb);
-			return;
-		}
 		memset(bh->b_data, 0, sb->s_blocksize);
 		*(__fs16*)bh->b_data = cpu_to_fs16(sbi, count);
 		memcpy(get_chunk(sb,bh), blocks, count * sizeof(sysv_zone_t));

--6c2NcOVqGQ03X4Wi--
