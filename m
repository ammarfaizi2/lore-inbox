Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWANPnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWANPnc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 10:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWANPnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 10:43:32 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:58027 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932180AbWANPnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 10:43:31 -0500
Date: Sat, 14 Jan 2006 16:43:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       bfennema@falcon.csc.calpoly.edu
Subject: [patch 2.6.15-mm4] sem2mutex: UDF
Message-ID: <20060114154342.GA30875@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 fs/udf/balloc.c           |   36 ++++++++++++++++++------------------
 fs/udf/ialloc.c           |    8 ++++----
 fs/udf/super.c            |    2 +-
 include/linux/udf_fs_sb.h |    4 ++--
 4 files changed, 25 insertions(+), 25 deletions(-)

Index: linux/fs/udf/balloc.c
===================================================================
--- linux.orig/fs/udf/balloc.c
+++ linux/fs/udf/balloc.c
@@ -152,7 +152,7 @@ static void udf_bitmap_free_blocks(struc
 	int bitmap_nr;
 	unsigned long overflow;
 
-	down(&sbi->s_alloc_sem);
+	mutex_lock(&sbi->s_alloc_mutex);
 	if (bloc.logicalBlockNum < 0 ||
 		(bloc.logicalBlockNum + count) > UDF_SB_PARTLEN(sb, bloc.partitionReferenceNum))
 	{
@@ -211,7 +211,7 @@ error_return:
 	sb->s_dirt = 1;
 	if (UDF_SB_LVIDBH(sb))
 		mark_buffer_dirty(UDF_SB_LVIDBH(sb));
-	up(&sbi->s_alloc_sem);
+	mutex_unlock(&sbi->s_alloc_mutex);
 	return;
 }
 
@@ -226,7 +226,7 @@ static int udf_bitmap_prealloc_blocks(st
 	int nr_groups, bitmap_nr;
 	struct buffer_head *bh;
 
-	down(&sbi->s_alloc_sem);
+	mutex_lock(&sbi->s_alloc_mutex);
 	if (first_block < 0 || first_block >= UDF_SB_PARTLEN(sb, partition))
 		goto out;
 
@@ -275,7 +275,7 @@ out:
 		mark_buffer_dirty(UDF_SB_LVIDBH(sb));
 	}
 	sb->s_dirt = 1;
-	up(&sbi->s_alloc_sem);
+	mutex_unlock(&sbi->s_alloc_mutex);
 	return alloc_count;
 }
 
@@ -291,7 +291,7 @@ static int udf_bitmap_new_block(struct s
 	int newblock = 0;
 
 	*err = -ENOSPC;
-	down(&sbi->s_alloc_sem);
+	mutex_lock(&sbi->s_alloc_mutex);
 
 repeat:
 	if (goal < 0 || goal >= UDF_SB_PARTLEN(sb, partition))
@@ -364,7 +364,7 @@ repeat:
 	}
 	if (i >= (nr_groups*2))
 	{
-		up(&sbi->s_alloc_sem);
+		mutex_unlock(&sbi->s_alloc_mutex);
 		return newblock;
 	}
 	if (bit < sb->s_blocksize << 3)
@@ -373,7 +373,7 @@ repeat:
 		bit = udf_find_next_one_bit(bh->b_data, sb->s_blocksize << 3, group_start << 3);
 	if (bit >= sb->s_blocksize << 3)
 	{
-		up(&sbi->s_alloc_sem);
+		mutex_unlock(&sbi->s_alloc_mutex);
 		return 0;
 	}
 
@@ -387,7 +387,7 @@ got_block:
 	 */
 	if (inode && DQUOT_ALLOC_BLOCK(inode, 1))
 	{
-		up(&sbi->s_alloc_sem);
+		mutex_unlock(&sbi->s_alloc_mutex);
 		*err = -EDQUOT;
 		return 0;
 	}
@@ -410,13 +410,13 @@ got_block:
 		mark_buffer_dirty(UDF_SB_LVIDBH(sb));
 	}
 	sb->s_dirt = 1;
-	up(&sbi->s_alloc_sem);
+	mutex_unlock(&sbi->s_alloc_mutex);
 	*err = 0;
 	return newblock;
 
 error_return:
 	*err = -EIO;
-	up(&sbi->s_alloc_sem);
+	mutex_unlock(&sbi->s_alloc_mutex);
 	return 0;
 }
 
@@ -433,7 +433,7 @@ static void udf_table_free_blocks(struct
 	int8_t etype;
 	int i;
 
-	down(&sbi->s_alloc_sem);
+	mutex_lock(&sbi->s_alloc_mutex);
 	if (bloc.logicalBlockNum < 0 ||
 		(bloc.logicalBlockNum + count) > UDF_SB_PARTLEN(sb, bloc.partitionReferenceNum))
 	{
@@ -666,7 +666,7 @@ static void udf_table_free_blocks(struct
 
 error_return:
 	sb->s_dirt = 1;
-	up(&sbi->s_alloc_sem);
+	mutex_unlock(&sbi->s_alloc_mutex);
 	return;
 }
 
@@ -692,7 +692,7 @@ static int udf_table_prealloc_blocks(str
 	else
 		return 0;
 
-	down(&sbi->s_alloc_sem);
+	mutex_lock(&sbi->s_alloc_mutex);
 	extoffset = sizeof(struct unallocSpaceEntry);
 	bloc = UDF_I_LOCATION(table);
 
@@ -736,7 +736,7 @@ static int udf_table_prealloc_blocks(str
 		mark_buffer_dirty(UDF_SB_LVIDBH(sb));
 		sb->s_dirt = 1;
 	}
-	up(&sbi->s_alloc_sem);
+	mutex_unlock(&sbi->s_alloc_mutex);
 	return alloc_count;
 }
 
@@ -761,7 +761,7 @@ static int udf_table_new_block(struct su
 	else
 		return newblock;
 
-	down(&sbi->s_alloc_sem);
+	mutex_lock(&sbi->s_alloc_mutex);
 	if (goal < 0 || goal >= UDF_SB_PARTLEN(sb, partition))
 		goal = 0;
 
@@ -811,7 +811,7 @@ static int udf_table_new_block(struct su
 	if (spread == 0xFFFFFFFF)
 	{
 		udf_release_data(goal_bh);
-		up(&sbi->s_alloc_sem);
+		mutex_unlock(&sbi->s_alloc_mutex);
 		return 0;
 	}
 
@@ -827,7 +827,7 @@ static int udf_table_new_block(struct su
 	if (inode && DQUOT_ALLOC_BLOCK(inode, 1))
 	{
 		udf_release_data(goal_bh);
-		up(&sbi->s_alloc_sem);
+		mutex_unlock(&sbi->s_alloc_mutex);
 		*err = -EDQUOT;
 		return 0;
 	}
@@ -846,7 +846,7 @@ static int udf_table_new_block(struct su
 	}
 
 	sb->s_dirt = 1;
-	up(&sbi->s_alloc_sem);
+	mutex_unlock(&sbi->s_alloc_mutex);
 	*err = 0;
 	return newblock;
 }
Index: linux/fs/udf/ialloc.c
===================================================================
--- linux.orig/fs/udf/ialloc.c
+++ linux/fs/udf/ialloc.c
@@ -42,7 +42,7 @@ void udf_free_inode(struct inode * inode
 
 	clear_inode(inode);
 
-	down(&sbi->s_alloc_sem);
+	mutex_lock(&sbi->s_alloc_mutex);
 	if (sbi->s_lvidbh) {
 		if (S_ISDIR(inode->i_mode))
 			UDF_SB_LVIDIU(sb)->numDirs =
@@ -53,7 +53,7 @@ void udf_free_inode(struct inode * inode
 		
 		mark_buffer_dirty(sbi->s_lvidbh);
 	}
-	up(&sbi->s_alloc_sem);
+	mutex_unlock(&sbi->s_alloc_mutex);
 
 	udf_free_blocks(sb, NULL, UDF_I_LOCATION(inode), 0, 1);
 }
@@ -83,7 +83,7 @@ struct inode * udf_new_inode (struct ino
 		return NULL;
 	}
 
-	down(&sbi->s_alloc_sem);
+	mutex_lock(&sbi->s_alloc_mutex);
 	UDF_I_UNIQUE(inode) = 0;
 	UDF_I_LENEXTENTS(inode) = 0;
 	UDF_I_NEXT_ALLOC_BLOCK(inode) = 0;
@@ -148,7 +148,7 @@ struct inode * udf_new_inode (struct ino
 		UDF_I_CRTIME(inode) = current_fs_time(inode->i_sb);
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
-	up(&sbi->s_alloc_sem);
+	mutex_unlock(&sbi->s_alloc_mutex);
 
 	if (DQUOT_ALLOC_INODE(inode))
 	{
Index: linux/fs/udf/super.c
===================================================================
--- linux.orig/fs/udf/super.c
+++ linux/fs/udf/super.c
@@ -1499,7 +1499,7 @@ static int udf_fill_super(struct super_b
 	sb->s_fs_info = sbi;
 	memset(UDF_SB(sb), 0x00, sizeof(struct udf_sb_info));
 
-	init_MUTEX(&sbi->s_alloc_sem);
+	mutex_init(&sbi->s_alloc_mutex);
 
 	if (!udf_parse_options((char *)options, &uopt))
 		goto error_out;
Index: linux/include/linux/udf_fs_sb.h
===================================================================
--- linux.orig/include/linux/udf_fs_sb.h
+++ linux/include/linux/udf_fs_sb.h
@@ -13,7 +13,7 @@
 #ifndef _UDF_FS_SB_H
 #define _UDF_FS_SB_H 1
 
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 #pragma pack(1)
 
@@ -111,7 +111,7 @@ struct udf_sb_info
 	/* VAT inode */
 	struct inode		*s_vat;
 
-	struct semaphore	s_alloc_sem;
+	struct semaphore	s_alloc_mutex;
 };
 
 #endif /* _UDF_FS_SB_H */
