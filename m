Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262929AbVA2Pej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbVA2Pej (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 10:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbVA2Pej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 10:34:39 -0500
Received: from verein.lst.de ([213.95.11.210]:2237 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262929AbVA2Pdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 10:33:55 -0500
Date: Sat, 29 Jan 2005 16:33:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Attila Body <compi@freemail.hu>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>
Subject: Re: UDF madness
Message-ID: <20050129153339.GA19997@lst.de>
References: <1106688285.5297.3.camel@smiley> <20050126201141.59c90e69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126201141.59c90e69.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 08:11:41PM -0800, Andrew Morton wrote:
> Yes, me too.  generic_shutdown_super() takes lock_super().  And udf uses
> lock_super for protecting its block allocation data strutures.  Trivial
> deadlock on unmount.
> 
> Filesystems really shouldn't be using lock_super() for internal purposes,
> and the main filesystems have been taught to not do that any more, but UDF
> is a holdout.
> 
> It seems that this deadlock was introduced on Jan 5 by the "udf: fix
> reservation discarding" patch which added the udf_discard_prealloc() call
> into udf_clear_inode().  The below dopey patch prevents the deadlock, but
> perhaps we can think of something more appealing.  Ideally, use a new lock
> altogether?
> 
> (I had UDF deadlock on me once during the untar.  That was a multi-process
> lockup and is probably due to a lock ranking bug.  Will poke at that a bit
> further).

Okay, below is a fix to switch udf to it's own private locking.  It's
safe because it doesn't intefer with VFS lock_super usage anywhere.

udf_free_inode has some more updates than simply switching the used
lock:

 - clear_inode() call moved outside locked section to avoid another
   deadlock
 - unused variable ino killed
 - is_directory moved into the conditional it's actually used in


Signed-off-by: Christoph Hellwig <hch@lst.de>

(note that I see memory corruption in UDF_I_DATA(inode), but I've
reproduced that with a kernel without all recent udf changes.  I'll
debug that one further)

--- 1.13/fs/udf/balloc.c	2004-10-20 10:37:15 +02:00
+++ edited/fs/udf/balloc.c	2005-01-29 16:11:49 +01:00
@@ -148,6 +148,7 @@ static void udf_bitmap_free_blocks(struc
 	struct udf_bitmap *bitmap,
 	kernel_lb_addr bloc, uint32_t offset, uint32_t count)
 {
+	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct buffer_head * bh = NULL;
 	unsigned long block;
 	unsigned long block_group;
@@ -156,7 +157,7 @@ static void udf_bitmap_free_blocks(struc
 	int bitmap_nr;
 	unsigned long overflow;
 
-	lock_super(sb);
+	down(&sbi->s_alloc_sem);
 	if (bloc.logicalBlockNum < 0 ||
 		(bloc.logicalBlockNum + count) > UDF_SB_PARTLEN(sb, bloc.partitionReferenceNum))
 	{
@@ -215,7 +216,7 @@ error_return:
 	sb->s_dirt = 1;
 	if (UDF_SB_LVIDBH(sb))
 		mark_buffer_dirty(UDF_SB_LVIDBH(sb));
-	unlock_super(sb);
+	up(&sbi->s_alloc_sem);
 	return;
 }
 
@@ -224,13 +225,13 @@ static int udf_bitmap_prealloc_blocks(st
 	struct udf_bitmap *bitmap, uint16_t partition, uint32_t first_block,
 	uint32_t block_count)
 {
+	struct udf_sb_info *sbi = UDF_SB(sb);
 	int alloc_count = 0;
 	int bit, block, block_group, group_start;
 	int nr_groups, bitmap_nr;
 	struct buffer_head *bh;
 
-	lock_super(sb);
-
+	down(&sbi->s_alloc_sem);
 	if (first_block < 0 || first_block >= UDF_SB_PARTLEN(sb, partition))
 		goto out;
 
@@ -279,7 +280,7 @@ out:
 		mark_buffer_dirty(UDF_SB_LVIDBH(sb));
 	}
 	sb->s_dirt = 1;
-	unlock_super(sb);
+	up(&sbi->s_alloc_sem);
 	return alloc_count;
 }
 
@@ -287,6 +288,7 @@ static int udf_bitmap_new_block(struct s
 	struct inode * inode,
 	struct udf_bitmap *bitmap, uint16_t partition, uint32_t goal, int *err)
 {
+	struct udf_sb_info *sbi = UDF_SB(sb);
 	int newbit, bit=0, block, block_group, group_start;
 	int end_goal, nr_groups, bitmap_nr, i;
 	struct buffer_head *bh = NULL;
@@ -294,7 +296,7 @@ static int udf_bitmap_new_block(struct s
 	int newblock = 0;
 
 	*err = -ENOSPC;
-	lock_super(sb);
+	down(&sbi->s_alloc_sem);
 
 repeat:
 	if (goal < 0 || goal >= UDF_SB_PARTLEN(sb, partition))
@@ -367,7 +369,7 @@ repeat:
 	}
 	if (i >= (nr_groups*2))
 	{
-		unlock_super(sb);
+		up(&sbi->s_alloc_sem);
 		return newblock;
 	}
 	if (bit < sb->s_blocksize << 3)
@@ -376,7 +378,7 @@ repeat:
 		bit = udf_find_next_one_bit(bh->b_data, sb->s_blocksize << 3, group_start << 3);
 	if (bit >= sb->s_blocksize << 3)
 	{
-		unlock_super(sb);
+		up(&sbi->s_alloc_sem);
 		return 0;
 	}
 
@@ -390,7 +392,7 @@ got_block:
 	 */
 	if (inode && DQUOT_ALLOC_BLOCK(inode, 1))
 	{
-		unlock_super(sb);
+		up(&sbi->s_alloc_sem);
 		*err = -EDQUOT;
 		return 0;
 	}
@@ -413,13 +415,13 @@ got_block:
 		mark_buffer_dirty(UDF_SB_LVIDBH(sb));
 	}
 	sb->s_dirt = 1;
-	unlock_super(sb);
+	up(&sbi->s_alloc_sem);
 	*err = 0;
 	return newblock;
 
 error_return:
 	*err = -EIO;
-	unlock_super(sb);
+	up(&sbi->s_alloc_sem);
 	return 0;
 }
 
@@ -428,6 +430,7 @@ static void udf_table_free_blocks(struct
 	struct inode * table,
 	kernel_lb_addr bloc, uint32_t offset, uint32_t count)
 {
+	struct udf_sb_info *sbi = UDF_SB(sb);
 	uint32_t start, end;
 	uint32_t nextoffset, oextoffset, elen;
 	kernel_lb_addr nbloc, obloc, eloc;
@@ -435,7 +438,7 @@ static void udf_table_free_blocks(struct
 	int8_t etype;
 	int i;
 
-	lock_super(sb);
+	down(&sbi->s_alloc_sem);
 	if (bloc.logicalBlockNum < 0 ||
 		(bloc.logicalBlockNum + count) > UDF_SB_PARTLEN(sb, bloc.partitionReferenceNum))
 	{
@@ -669,7 +672,7 @@ static void udf_table_free_blocks(struct
 
 error_return:
 	sb->s_dirt = 1;
-	unlock_super(sb);
+	up(&sbi->s_alloc_sem);
 	return;
 }
 
@@ -678,6 +681,7 @@ static int udf_table_prealloc_blocks(str
 	struct inode *table, uint16_t partition, uint32_t first_block,
 	uint32_t block_count)
 {
+	struct udf_sb_info *sbi = UDF_SB(sb);
 	int alloc_count = 0;
 	uint32_t extoffset, elen, adsize;
 	kernel_lb_addr bloc, eloc;
@@ -694,8 +698,7 @@ static int udf_table_prealloc_blocks(str
 	else
 		return 0;
 
-	lock_super(sb);
-
+	down(&sbi->s_alloc_sem);
 	extoffset = sizeof(struct unallocSpaceEntry);
 	bloc = UDF_I_LOCATION(table);
 
@@ -739,7 +742,7 @@ static int udf_table_prealloc_blocks(str
 		mark_buffer_dirty(UDF_SB_LVIDBH(sb));
 		sb->s_dirt = 1;
 	}
-	unlock_super(sb);
+	up(&sbi->s_alloc_sem);
 	return alloc_count;
 }
 
@@ -747,6 +750,7 @@ static int udf_table_new_block(struct su
 	struct inode * inode,
 	struct inode *table, uint16_t partition, uint32_t goal, int *err)
 {
+	struct udf_sb_info *sbi = UDF_SB(sb);
 	uint32_t spread = 0xFFFFFFFF, nspread = 0xFFFFFFFF;
 	uint32_t newblock = 0, adsize;
 	uint32_t extoffset, goal_extoffset, elen, goal_elen = 0;
@@ -763,8 +767,7 @@ static int udf_table_new_block(struct su
 	else
 		return newblock;
 
-	lock_super(sb);
-
+	down(&sbi->s_alloc_sem);
 	if (goal < 0 || goal >= UDF_SB_PARTLEN(sb, partition))
 		goal = 0;
 
@@ -814,7 +817,7 @@ static int udf_table_new_block(struct su
 	if (spread == 0xFFFFFFFF)
 	{
 		udf_release_data(goal_bh);
-		unlock_super(sb);
+		up(&sbi->s_alloc_sem);
 		return 0;
 	}
 
@@ -830,7 +833,7 @@ static int udf_table_new_block(struct su
 	if (inode && DQUOT_ALLOC_BLOCK(inode, 1))
 	{
 		udf_release_data(goal_bh);
-		unlock_super(sb);
+		up(&sbi->s_alloc_sem);
 		*err = -EDQUOT;
 		return 0;
 	}
@@ -849,7 +852,7 @@ static int udf_table_new_block(struct su
 	}
 
 	sb->s_dirt = 1;
-	unlock_super(sb);
+	up(&sbi->s_alloc_sem);
 	*err = 0;
 	return newblock;
 }
--- 1.13/fs/udf/ialloc.c	2005-01-05 03:48:14 +01:00
+++ edited/fs/udf/ialloc.c	2005-01-29 16:32:16 +01:00
@@ -35,11 +35,8 @@
 
 void udf_free_inode(struct inode * inode)
 {
-	struct super_block * sb = inode->i_sb;
-	int is_directory;
-	unsigned long ino;
-
-	ino = inode->i_ino;
+	struct super_block *sb = inode->i_sb;
+	struct udf_sb_info *sbi = UDF_SB(sb);
 
 	/*
 	 * Note: we must free any quota before locking the superblock,
@@ -48,36 +45,32 @@ void udf_free_inode(struct inode * inode
 	DQUOT_FREE_INODE(inode);
 	DQUOT_DROP(inode);
 
-	lock_super(sb);
-
-	is_directory = S_ISDIR(inode->i_mode);
-
 	clear_inode(inode);
 
-	if (UDF_SB_LVIDBH(sb))
-	{
-		if (is_directory)
+	down(&sbi->s_alloc_sem);
+	if (sbi->s_lvidbh) {
+		if (S_ISDIR(inode->i_mode))
 			UDF_SB_LVIDIU(sb)->numDirs =
 				cpu_to_le32(le32_to_cpu(UDF_SB_LVIDIU(sb)->numDirs) - 1);
 		else
 			UDF_SB_LVIDIU(sb)->numFiles =
 				cpu_to_le32(le32_to_cpu(UDF_SB_LVIDIU(sb)->numFiles) - 1);
 		
-		mark_buffer_dirty(UDF_SB_LVIDBH(sb));
+		mark_buffer_dirty(sbi->s_lvidbh);
 	}
-	unlock_super(sb);
+	up(&sbi->s_alloc_sem);
 
 	udf_free_blocks(sb, NULL, UDF_I_LOCATION(inode), 0, 1);
 }
 
 struct inode * udf_new_inode (struct inode *dir, int mode, int * err)
 {
-	struct super_block *sb;
+	struct super_block *sb = dir->i_sb;
+	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct inode * inode;
 	int block;
 	uint32_t start = UDF_I_LOCATION(dir).logicalBlockNum;
 
-	sb = dir->i_sb;
 	inode = new_inode(sb);
 
 	if (!inode)
@@ -94,8 +87,8 @@ struct inode * udf_new_inode (struct ino
 		iput(inode);
 		return NULL;
 	}
-	lock_super(sb);
 
+	down(&sbi->s_alloc_sem);
 	UDF_I_UNIQUE(inode) = 0;
 	UDF_I_LENEXTENTS(inode) = 0;
 	UDF_I_NEXT_ALLOC_BLOCK(inode) = 0;
@@ -160,8 +153,8 @@ struct inode * udf_new_inode (struct ino
 		UDF_I_CRTIME(inode) = current_fs_time(inode->i_sb);
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
+	up(&sbi->s_alloc_sem);
 
-	unlock_super(sb);
 	if (DQUOT_ALLOC_INODE(inode))
 	{
 		DQUOT_DROP(inode);
--- 1.48/fs/udf/super.c	2005-01-05 03:48:18 +01:00
+++ edited/fs/udf/super.c	2005-01-29 16:23:52 +01:00
@@ -1504,6 +1504,8 @@ static int udf_fill_super(struct super_b
 	sb->s_fs_info = sbi;
 	memset(UDF_SB(sb), 0x00, sizeof(struct udf_sb_info));
 
+	init_MUTEX(&sbi->s_alloc_sem);
+
 	if (!udf_parse_options((char *)options, &uopt))
 		goto error_out;
 
===== include/linux/udf_fs_sb.h 1.5 vs edited =====
--- 1.5/include/linux/udf_fs_sb.h	2002-11-19 01:49:50 +01:00
+++ edited/include/linux/udf_fs_sb.h	2005-01-29 16:11:49 +01:00
@@ -18,6 +18,8 @@
 #ifndef _UDF_FS_SB_H
 #define _UDF_FS_SB_H 1
 
+#include <asm/semaphore.h>
+
 #pragma pack(1)
 
 #define UDF_MAX_BLOCK_LOADED	8
@@ -113,6 +115,8 @@ struct udf_sb_info
 
 	/* VAT inode */
 	struct inode		*s_vat;
+
+	struct semaphore	s_alloc_sem;
 };
 
 #endif /* _UDF_FS_SB_H */
