Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281561AbRLAL2J>; Sat, 1 Dec 2001 06:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281562AbRLAL1w>; Sat, 1 Dec 2001 06:27:52 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:32911 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S281561AbRLAL1g>; Sat, 1 Dec 2001 06:27:36 -0500
Date: Sat, 1 Dec 2001 13:32:27 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] if (foo) brelse(foo) /fs cleanup
Message-ID: <Pine.LNX.4.33.0112011331310.11026-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the extra check. This patch is for the /fs directory

Zwane Mwaikambo

diffed against 2.5.1-pre4

diff -urN linux-2.5.1-pre4.orig/fs/affs/bitmap.c linux-2.5.1-pre4.brelse/fs/affs/bitmap.c
--- linux-2.5.1-pre4.orig/fs/affs/bitmap.c	Wed Apr 25 23:57:09 2001
+++ linux-2.5.1-pre4.brelse/fs/affs/bitmap.c	Sat Dec  1 08:08:07 2001
@@ -328,8 +328,8 @@
 		 */
 		if (++blk < end || i == 1)
 			continue;
-		if (bmap_bh)
-			affs_brelse(bmap_bh);
+
+		affs_brelse(bmap_bh);
 		bmap_bh = affs_bread(sb, be32_to_cpu(bmap_blk[blk]));
 		if (!bmap_bh) {
 			printk(KERN_ERR "AFFS: Cannot read bitmap extension\n");
diff -urN linux-2.5.1-pre4.orig/fs/efs/inode.c linux-2.5.1-pre4.brelse/fs/efs/inode.c
--- linux-2.5.1-pre4.orig/fs/efs/inode.c	Sun Sep 30 21:26:08 2001
+++ linux-2.5.1-pre4.brelse/fs/efs/inode.c	Sat Dec  1 07:59:21 2001
@@ -257,7 +257,7 @@
 		if (dirext == direxts) {
 			/* should never happen */
 			printk(KERN_ERR "EFS: couldn't find direct extent for indirect extent %d (block %u)\n", cur, block);
-			if (bh) brelse(bh);
+			brelse(bh);
 			return 0;
 		}

@@ -269,7 +269,7 @@
 			(EFS_BLOCKSIZE / sizeof(efs_extent));

 		if (first || lastblock != iblock) {
-			if (bh) brelse(bh);
+			brelse(bh);

 			bh = bread(inode->i_dev, iblock, EFS_BLOCKSIZE);
 			if (!bh) {
@@ -289,17 +289,17 @@

 		if (ext.cooked.ex_magic != 0) {
 			printk(KERN_ERR "EFS: extent %d has bad magic number in block %d\n", cur, iblock);
-			if (bh) brelse(bh);
+			brelse(bh);
 			return 0;
 		}

 		if ((result = efs_extent_check(&ext, block, sb))) {
-			if (bh) brelse(bh);
+			brelse(bh);
 			in->lastextent = cur;
 			return result;
 		}
 	}
-	if (bh) brelse(bh);
+	brelse(bh);
 	printk(KERN_ERR "EFS: map_block() failed to map block %u (indir)\n", block);
 	return 0;
 }
diff -urN linux-2.5.1-pre4.orig/fs/ext2/super.c linux-2.5.1-pre4.brelse/fs/ext2/super.c
--- linux-2.5.1-pre4.orig/fs/ext2/super.c	Mon Nov 12 19:34:16 2001
+++ linux-2.5.1-pre4.brelse/fs/ext2/super.c	Sat Dec  1 08:09:30 2001
@@ -129,15 +129,12 @@
 	}
 	db_count = EXT2_SB(sb)->s_gdb_count;
 	for (i = 0; i < db_count; i++)
-		if (sb->u.ext2_sb.s_group_desc[i])
-			brelse (sb->u.ext2_sb.s_group_desc[i]);
+		brelse (sb->u.ext2_sb.s_group_desc[i]);
 	kfree(sb->u.ext2_sb.s_group_desc);
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++)
-		if (sb->u.ext2_sb.s_inode_bitmap[i])
-			brelse (sb->u.ext2_sb.s_inode_bitmap[i]);
+		brelse (sb->u.ext2_sb.s_inode_bitmap[i]);
 	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++)
-		if (sb->u.ext2_sb.s_block_bitmap[i])
-			brelse (sb->u.ext2_sb.s_block_bitmap[i]);
+		brelse (sb->u.ext2_sb.s_block_bitmap[i]);
 	brelse (sb->u.ext2_sb.s_sbh);

 	return;
diff -urN linux-2.5.1-pre4.orig/fs/isofs/compress.c linux-2.5.1-pre4.brelse/fs/isofs/compress.c
--- linux-2.5.1-pre4.orig/fs/isofs/compress.c	Tue Nov  6 18:34:40 2001
+++ linux-2.5.1-pre4.brelse/fs/isofs/compress.c	Sat Dec  1 08:25:09 2001
@@ -117,7 +117,7 @@
 	ptrbh[0] = ptrbh[1] = 0;

 	if ( isofs_get_blocks(inode, blockptr >> bufshift, ptrbh, indexblocks) != indexblocks ) {
-		if ( ptrbh[0] ) brelse(ptrbh[0]);
+		brelse(ptrbh[0]);
 		printk(KERN_DEBUG "zisofs: Null buffer on reading block table, inode = %lu, block = %lu\n",
 		       inode->i_ino, blockptr >> bufshift);
 		goto eio;
@@ -128,8 +128,7 @@
 	if ( !bh || (wait_on_buffer(bh), !buffer_uptodate(bh)) ) {
 		printk(KERN_DEBUG "zisofs: Failed to read block table, inode = %lu, block = %lu\n",
 		       inode->i_ino, blockptr >> bufshift);
-		if ( ptrbh[1] )
-			brelse(ptrbh[1]);
+		brelse(ptrbh[1]);
 		goto eio;
 	}
 	cstart = le32_to_cpu(*(u32 *)(bh->b_data + (blockptr & bufmask)));
@@ -297,10 +296,8 @@
 		up(&zisofs_zlib_semaphore);

 	b_eio:
-		for ( i = 0 ; i < haveblocks ; i++ ) {
-			if ( bhs[i] )
-				brelse(bhs[i]);
-		}
+		for ( i = 0 ; i < haveblocks ; i++ )
+			brelse(bhs[i]);
 	}

 eio:
diff -urN linux-2.5.1-pre4.orig/fs/isofs/dir.c linux-2.5.1-pre4.brelse/fs/isofs/dir.c
--- linux-2.5.1-pre4.orig/fs/isofs/dir.c	Fri Feb  9 21:29:44 2001
+++ linux-2.5.1-pre4.brelse/fs/isofs/dir.c	Sat Dec  1 08:23:32 2001
@@ -237,7 +237,7 @@

 		continue;
 	}
-	if (bh) brelse(bh);
+	brelse(bh);
 	return 0;
 }

diff -urN linux-2.5.1-pre4.orig/fs/isofs/inode.c linux-2.5.1-pre4.brelse/fs/isofs/inode.c
--- linux-2.5.1-pre4.orig/fs/isofs/inode.c	Thu Oct 25 22:53:53 2001
+++ linux-2.5.1-pre4.brelse/fs/isofs/inode.c	Sat Dec  1 08:27:41 2001
@@ -1114,13 +1114,11 @@
 out:
 	if (tmpde)
 		kfree(tmpde);
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	return 0;

 out_nomem:
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	return -ENOMEM;

 out_noread:
@@ -1331,8 +1329,7 @@
  out:
 	if (tmpde)
 		kfree(tmpde);
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	return;

  out_badread:
diff -urN linux-2.5.1-pre4.orig/fs/isofs/namei.c linux-2.5.1-pre4.brelse/fs/isofs/namei.c
--- linux-2.5.1-pre4.orig/fs/isofs/namei.c	Fri Feb  9 21:29:44 2001
+++ linux-2.5.1-pre4.brelse/fs/isofs/namei.c	Sat Dec  1 08:26:22 2001
@@ -147,11 +147,11 @@
 			match = (isofs_cmp(dentry,dpnt,dlen) == 0);
 		}
 		if (match) {
-			if (bh) brelse(bh);
+			brelse(bh);
 			return inode_number;
 		}
 	}
-	if (bh) brelse(bh);
+	brelse(bh);
 	return 0;
 }

diff -urN linux-2.5.1-pre4.orig/fs/msdos/namei.c linux-2.5.1-pre4.brelse/fs/msdos/namei.c
--- linux-2.5.1-pre4.orig/fs/msdos/namei.c	Fri Oct 12 22:48:42 2001
+++ linux-2.5.1-pre4.brelse/fs/msdos/namei.c	Sat Dec  1 08:28:31 2001
@@ -233,8 +233,7 @@
 	d_add(dentry, inode);
 	res = 0;
 out:
-	if (bh)
-		fat_brelse(sb, bh);
+	fat_brelse(sb, bh);
 	return ERR_PTR(res);
 }

diff -urN linux-2.5.1-pre4.orig/fs/qnx4/inode.c linux-2.5.1-pre4.brelse/fs/qnx4/inode.c
--- linux-2.5.1-pre4.orig/fs/qnx4/inode.c	Sun Sep 30 21:26:08 2001
+++ linux-2.5.1-pre4.brelse/fs/qnx4/inode.c	Sat Dec  1 08:12:24 2001
@@ -267,8 +267,7 @@
 				bh = 0;
 			}
 		}
-		if ( bh )
-			brelse( bh );
+		brelse( bh );
 	}

 	QNX4DEBUG(("qnx4: mapping block %ld of inode %ld = %ld\n",iblock,inode->i_ino,block));
diff -urN linux-2.5.1-pre4.orig/fs/reiserfs/journal.c linux-2.5.1-pre4.brelse/fs/reiserfs/journal.c
--- linux-2.5.1-pre4.orig/fs/reiserfs/journal.c	Sat Nov 10 00:18:25 2001
+++ linux-2.5.1-pre4.brelse/fs/reiserfs/journal.c	Sat Dec  1 08:21:31 2001
@@ -1308,9 +1308,8 @@
   vfree(SB_JOURNAL(p_s_sb)->j_cnode_free_orig) ;
   free_list_bitmaps(p_s_sb, SB_JOURNAL(p_s_sb)->j_list_bitmap) ;
   free_bitmap_nodes(p_s_sb) ; /* must be after free_list_bitmaps */
-  if (SB_JOURNAL(p_s_sb)->j_header_bh) {
-    brelse(SB_JOURNAL(p_s_sb)->j_header_bh) ;
-  }
+  brelse(SB_JOURNAL(p_s_sb)->j_header_bh) ;
+
   vfree(SB_JOURNAL(p_s_sb)) ;
 }

diff -urN linux-2.5.1-pre4.orig/fs/reiserfs/super.c linux-2.5.1-pre4.brelse/fs/reiserfs/super.c
--- linux-2.5.1-pre4.orig/fs/reiserfs/super.c	Sat Nov 10 00:18:25 2001
+++ linux-2.5.1-pre4.brelse/fs/reiserfs/super.c	Sat Dec  1 08:22:28 2001
@@ -778,8 +778,7 @@
 	if (SB_AP_BITMAP (s))
 	    reiserfs_kfree (SB_AP_BITMAP (s), sizeof (struct buffer_head *) * SB_BMAP_NR (s), s);
     }
-    if (SB_BUFFER_WITH_SB (s))
-	brelse(SB_BUFFER_WITH_SB (s));
+    brelse(SB_BUFFER_WITH_SB (s));

     return NULL;
 }
diff -urN linux-2.5.1-pre4.orig/fs/sysv/balloc.c linux-2.5.1-pre4.brelse/fs/sysv/balloc.c
--- linux-2.5.1-pre4.orig/fs/sysv/balloc.c	Sun Sep  2 19:34:36 2001
+++ linux-2.5.1-pre4.brelse/fs/sysv/balloc.c	Sat Dec  1 08:13:28 2001
@@ -190,8 +190,7 @@
 			break;

 		block = fs32_to_cpu(sb, block);
-		if (bh)
-			brelse(bh);
+		brelse(bh);

 		if (block < sb->sv_firstdatazone || block >= sb->sv_nzones)
 			goto Einval;
@@ -202,8 +201,7 @@
 		n = fs16_to_cpu(sb, *(u16*)bh->b_data);
 		blocks = get_chunk(sb, bh);
 	}
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	if (count != sb_count)
 		goto Ecount;
 done:
@@ -219,8 +217,7 @@
 	goto trust_sb;
 E2big:
 	printk("sysv_count_free_blocks: >flc_size entries in free-list block\n");
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 trust_sb:
 	count = sb_count;
 	goto done;
diff -urN linux-2.5.1-pre4.orig/fs/udf/misc.c linux-2.5.1-pre4.brelse/fs/udf/misc.c
--- linux-2.5.1-pre4.orig/fs/udf/misc.c	Tue Jun 12 04:15:27 2001
+++ linux-2.5.1-pre4.brelse/fs/udf/misc.c	Sat Dec  1 08:01:13 2001
@@ -367,8 +367,7 @@

 void udf_release_data(struct buffer_head *bh)
 {
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 }

 #endif
diff -urN linux-2.5.1-pre4.orig/fs/ufs/super.c linux-2.5.1-pre4.brelse/fs/ufs/super.c
--- linux-2.5.1-pre4.orig/fs/ufs/super.c	Tue Nov 20 00:55:46 2001
+++ linux-2.5.1-pre4.brelse/fs/ufs/super.c	Sat Dec  1 08:02:23 2001
@@ -384,7 +384,7 @@
 	if (base) kfree (base);
 	if (sb->u.ufs_sb.s_ucg) {
 		for (i = 0; i < uspi->s_ncg; i++)
-			if (sb->u.ufs_sb.s_ucg[i]) brelse (sb->u.ufs_sb.s_ucg[i]);
+			brelse (sb->u.ufs_sb.s_ucg[i]);
 		kfree (sb->u.ufs_sb.s_ucg);
 		for (i = 0; i < UFS_MAX_GROUP_LOADED; i++)
 			if (sb->u.ufs_sb.s_ucpi[i]) kfree (sb->u.ufs_sb.s_ucpi[i]);
diff -urN linux-2.5.1-pre4.orig/fs/vfat/namei.c linux-2.5.1-pre4.brelse/fs/vfat/namei.c
--- linux-2.5.1-pre4.orig/fs/vfat/namei.c	Thu Oct 25 09:02:26 2001
+++ linux-2.5.1-pre4.brelse/fs/vfat/namei.c	Sat Dec  1 08:19:34 2001
@@ -1070,7 +1070,7 @@
 		de->attr = 0;
 		fat_mark_buffer_dirty(sb, bh);
 	}
-	if (bh) fat_brelse(sb, bh);
+	fat_brelse(sb, bh);
 }

 int vfat_rmdir(struct inode *dir,struct dentry* dentry)

