Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992764AbWKATgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992764AbWKATgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 14:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992765AbWKATgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 14:36:20 -0500
Received: from scalix.xandros.com ([142.46.212.37]:4292 "EHLO
	scalix.xandros.com") by vger.kernel.org with ESMTP id S2992764AbWKATgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 14:36:18 -0500
Date: Wed, 1 Nov 2006 14:30:51 -0500
From: Holden Karau <holden@pigscanfly.ca>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org,
       Holden Karau <holdenk@xandros.com>, "akpm@osdl.org" <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, holden@pigscanfly.ca,
       holden.karau@gmail.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Matthew Wilcox <matthew@wil.cx>, holden@pigscanfly.ca,
       holden.karau@gmail.com, Holden Karau <holdenk@xandros.com>
Message-ID: <4548F5EB.3070201@pigscanfly.ca>
Subject: [PATCH 1/1] fat: improve sync performance by grouping writes revised  yet again
x-scalix-Hops: 1
User-Agent: Thunderbird 1.5.0.7 (X11/20061023)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Holden Karau <holden@pigscanfly.ca> http://www.holdenkarau.com
This is an attempt at improving fat_mirror_bhs in sync mode [namely it
writes all of the data for a backup block, and then blocks untill
finished]. The old behavior would write & block in smaller chunks, so
this should be slightly faster. It also removes the fix me requesting
that it be fixed to behave this way :-)
Signed-off-by: Holden Karau <holden@pigscanfly.ca>
---
This is an improved version of an earlier patch, I've cleaned up the
formatting, it now also groups the write for the primary fat block
[so even if the user has only 2 FATs it should still be slightly
faster]. and it now handles running running out of memory more 
gracefully. Hopefully, there aren't any other things that still
need fixing in this patch :-) If no one objects, I'd like to see if it 
would be possible to put this in the -mm tree to make sure it doesn't eat 
anyones fs :-) In case the patch gets mangled, I've put it up at 
http://www.holdenkarau.com/~holden/projects/fat/001_improve_fat_sync_performance_revised5.patch


And now for the patch:

--- a/fs/fat/fatent.c	2006-09-19 23:42:06.000000000 -0400
+++ b/fs/fat/fatent.c	2006-11-01 14:06:56.000000000 -0500
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2004, OGAWA Hirofumi
+ * Copyright (C) 2006, Holden Karau [Xandros] 
  * Released under GPL v2.
  */
 
@@ -343,52 +344,77 @@ int fat_ent_read(struct inode *inode, st
 	return ops->ent_get(fatent);
 }
 
-/* FIXME: We can write the blocks as more big chunk. */
-static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
-			  int nr_bhs)
+
+
+static int fat_mirror_bhs_optw(struct super_block *sb, struct buffer_head **bhs,
+			       int nr_bhs , int wait)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	struct buffer_head *c_bh;
-	int err, n, copy;
+	struct buffer_head **c_bh;
+	int err, n, copy, i;
 
+	/* Always wait if mounted -o sync */
+	if (sb->s_flags & MS_SYNCHRONOUS )
+		wait = 1;
+	c_bh = kmalloc(nr_bhs*(sbi->fats) , GFP_KERNEL);
+	if (!c_bh) {
+		err = -ENOMEM;
+		goto error;
+	}
 	err = 0;
+	i = 0;
 	for (copy = 1; copy < sbi->fats; copy++) {
 		sector_t backup_fat = sbi->fat_length * copy;
-
-		for (n = 0; n < nr_bhs; n++) {
-			c_bh = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
-			if (!c_bh) {
-				err = -ENOMEM;
-				goto error;
+		for (n = 0 ; n < nr_bhs ;  n++ ) {
+			c_bh[(copy-1)*nr_bhs+n] = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
+			/* If there is not enough memory, fall back to the old system */
+			if (!c_bh[(copy-1)*nr_bhs+n]) {
+				fat_sync_bhs_optw( c_bh+i  , (copy-1)*nr_bhs+n-i-1 , wait );
+				/* Free the now sync'd blocks */
+				for (; i < (copy-1)*nr_bhs+n ; i++) 
+					brelse(c_bh[i]);
+				/* We try the same block again */
+				c_bh[(copy-1)*nr_bhs+n] = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
+				if (!c_bh[(copy-1)*nr_bhs+n]) {
+					err = -ENOMEM;
+					goto error;
+				}
 			}
-			memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
-			set_buffer_uptodate(c_bh);
-			mark_buffer_dirty(c_bh);
-			if (sb->s_flags & MS_SYNCHRONOUS)
-				err = sync_dirty_buffer(c_bh);
-			brelse(c_bh);
-			if (err)
-				goto error;
+			memcpy(c_bh[(copy-1)*nr_bhs+n]->b_data, bhs[n]->b_data, sb->s_blocksize);
+			set_buffer_uptodate(c_bh[(copy-1)*nr_bhs+n]);
+			mark_buffer_dirty(c_bh[(copy-1)*nr_bhs+n]);
 		}
 	}
+
+	/* If we have to, sync the primary FAT table as well as the backups */
+	if (wait)
+		for (n = 0 ; n < nr_bhs ; n++)
+			c_bh[nr_bhs*(sbi->fats-1)+n] = bhs[n];
+	err = fat_sync_bhs_optw( c_bh+i  , nr_bhs*(sbi->fats+wait-1)-i , wait );
+	if (err)
+		goto error;
+	for (n = 0; n+i < nr_bhs*(sbi->fats-1); n++ )
+		brelse(c_bh[n+i]);
 error:
+	kfree(c_bh);
 	return err;
 }
 
+static inline int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
+				 int nr_bhs )
+{
+	return fat_mirror_bhs_optw(sb , bhs , nr_bhs, 0);
+}
+
+
 int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
 		  int new, int wait)
 {
 	struct super_block *sb = inode->i_sb;
 	struct fatent_operations *ops = MSDOS_SB(sb)->fatent_ops;
-	int err;
 
 	ops->ent_put(fatent, new);
-	if (wait) {
-		err = fat_sync_bhs(fatent->bhs, fatent->nr_bhs);
-		if (err)
-			return err;
-	}
-	return fat_mirror_bhs(sb, fatent->bhs, fatent->nr_bhs);
+	return fat_mirror_bhs_optw(sb, fatent->bhs, fatent->nr_bhs , wait);
 }
 
 static inline int fat_ent_next(struct msdos_sb_info *sbi,
@@ -505,9 +531,9 @@ out:
 	fatent_brelse(&fatent);
 	if (!err) {
 		if (inode_needs_sync(inode))
-			err = fat_sync_bhs(bhs, nr_bhs);
-		if (!err)
-			err = fat_mirror_bhs(sb, bhs, nr_bhs);
+			err = fat_mirror_bhs_optw(sb , bhs, nr_bhs , 1);
+		else
+			err = fat_mirror_bhs_optw(sb, bhs, nr_bhs , 0 );
 	}
 	for (i = 0; i < nr_bhs; i++)
 		brelse(bhs[i]);
@@ -549,11 +575,6 @@ int fat_free_clusters(struct inode *inod
 		}
 
 		if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
-			if (sb->s_flags & MS_SYNCHRONOUS) {
-				err = fat_sync_bhs(bhs, nr_bhs);
-				if (err)
-					goto error;
-			}
 			err = fat_mirror_bhs(sb, bhs, nr_bhs);
 			if (err)
 				goto error;
@@ -564,11 +585,6 @@ int fat_free_clusters(struct inode *inod
 		fat_collect_bhs(bhs, &nr_bhs, &fatent);
 	} while (cluster != FAT_ENT_EOF);
 
-	if (sb->s_flags & MS_SYNCHRONOUS) {
-		err = fat_sync_bhs(bhs, nr_bhs);
-		if (err)
-			goto error;
-	}
 	err = fat_mirror_bhs(sb, bhs, nr_bhs);
 error:
 	fatent_brelse(&fatent);
--- a/fs/fat/misc.c	2006-09-19 23:42:06.000000000 -0400
+++ b/fs/fat/misc.c	2006-11-01 13:37:07.000000000 -0500
@@ -194,11 +194,15 @@ void fat_date_unix2dos(int unix_date, __
 
 EXPORT_SYMBOL_GPL(fat_date_unix2dos);
 
-int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
+
+
+int fat_sync_bhs_optw(struct buffer_head **bhs, int nr_bhs ,int wait)
 {
 	int i, err = 0;
 
 	ll_rw_block(SWRITE, nr_bhs, bhs);
+	if (!wait) 
+		return 0;
 	for (i = 0; i < nr_bhs; i++) {
 		wait_on_buffer(bhs[i]);
 		if (buffer_eopnotsupp(bhs[i])) {
@@ -207,6 +211,11 @@ int fat_sync_bhs(struct buffer_head **bh
 		} else if (!err && !buffer_uptodate(bhs[i]))
 			err = -EIO;
 	}
+
 	return err;
 }
 
+inline int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs ) {
+	return fat_sync_bhs_optw(bhs , nr_bhs , 1);
+}
+
--- a/include/linux/msdos_fs.h	2006-09-19 23:42:06.000000000 -0400
+++ b/include/linux/msdos_fs.h	2006-10-25 18:53:50.000000000 -0400
@@ -419,6 +419,7 @@ extern int fat_chain_add(struct inode *i
 extern int date_dos2unix(unsigned short time, unsigned short date);
 extern void fat_date_unix2dos(int unix_date, __le16 *time, __le16 *date);
 extern int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs);
+extern int fat_sync_bhs_optw(struct buffer_head **bhs, int nr_bhs, int wait);
 
 int fat_cache_init(void);
 void fat_cache_destroy(void);


