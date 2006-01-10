Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030690AbWAJX0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030690AbWAJX0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030684AbWAJX0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:26:34 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:40928 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751351AbWAJX0a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:26:30 -0500
Subject: [PATCH 3/5] ext3-get-blocks: support multiple blocks allocation in
	ext3-new-block()
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: hch@lst.de, pbadari@us.ibm.com, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 10 Jan 2006 15:26:27 -0800
Message-Id: <1136935587.4901.44.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Second part of the multiple block allocation patch. This patch changed
ext3_try_to_allocate() (called via ext3_new_blocks()) to try
to allocate the requested number of blocks on a best effort basis:
After allocated the first block, it will always attempt to allocate
the next few(up to the requested size and not beyond the reservation window)
adjacent blocks at the same time.

Signed-off-by: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.15-ming/fs/ext3/balloc.c        |   48 +++++++++++++++++++++++-------
 linux-2.6.15-ming/include/linux/ext3_fs.h |    5 ++-
 2 files changed, 42 insertions(+), 11 deletions(-)

diff -puN fs/ext3/balloc.c~ext3-new-blocks-base fs/ext3/balloc.c
--- linux-2.6.15/fs/ext3/balloc.c~ext3-new-blocks-base	2006-01-10 14:25:34.270626899 -0800
+++ linux-2.6.15-ming/fs/ext3/balloc.c	2006-01-10 14:25:34.278625969 -0800
@@ -654,9 +654,11 @@ claim_block(spinlock_t *lock, int block,
  */
 static int
 ext3_try_to_allocate(struct super_block *sb, handle_t *handle, int group,
-	struct buffer_head *bitmap_bh, int goal, struct ext3_reserve_window *my_rsv)
+			struct buffer_head *bitmap_bh, int goal,
+			unsigned long *count, struct ext3_reserve_window *my_rsv)
 {
 	int group_first_block, start, end;
+	unsigned long num = 0;
 
 	/* we do allocation within the reservation window if we have a window */
 	if (my_rsv) {
@@ -714,8 +716,18 @@ repeat:
 			goto fail_access;
 		goto repeat;
 	}
-	return goal;
+	num++;
+	goal++;
+	while (num < *count && goal < end
+		&& ext3_test_allocatable(goal, bitmap_bh)
+		&& claim_block(sb_bgl_lock(EXT3_SB(sb), group), goal, bitmap_bh)) {
+		num++;
+		goal++;
+	}
+	*count = num;
+	return goal - num;
 fail_access:
+	*count = num;
 	return -1;
 }
 
@@ -1025,11 +1037,12 @@ static int
 ext3_try_to_allocate_with_rsv(struct super_block *sb, handle_t *handle,
 			unsigned int group, struct buffer_head *bitmap_bh,
 			int goal, struct ext3_reserve_window_node * my_rsv,
-			int *errp)
+			unsigned long *count, int *errp)
 {
 	unsigned long group_first_block;
 	int ret = 0;
 	int fatal;
+	unsigned long num = *count;
 
 	*errp = 0;
 
@@ -1052,7 +1065,8 @@ ext3_try_to_allocate_with_rsv(struct sup
 	 * or last attempt to allocate a block with reservation turned on failed
 	 */
 	if (my_rsv == NULL ) {
-		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal, NULL);
+		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh,
+						goal, count, NULL);
 		goto out;
 	}
 	/*
@@ -1094,11 +1108,13 @@ ext3_try_to_allocate_with_rsv(struct sup
 		    || (my_rsv->rsv_end < group_first_block))
 			BUG();
 		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal,
-					   &my_rsv->rsv_window);
+					   &num, &my_rsv->rsv_window);
 		if (ret >= 0) {
-			my_rsv->rsv_alloc_hit++;
+			my_rsv->rsv_alloc_hit += num;
+			*count = num;
 			break;				/* succeed */
 		}
+		num = *count;
 	}
 out:
 	if (ret >= 0) {
@@ -1155,8 +1171,8 @@ int ext3_should_retry_alloc(struct super
  * bitmap, and then for any free bit if that fails.
  * This function also updates quota and i_blocks field.
  */
-int ext3_new_block(handle_t *handle, struct inode *inode,
-			unsigned long goal, int *errp)
+int ext3_new_blocks(handle_t *handle, struct inode *inode,
+			unsigned long goal, unsigned long *count, int *errp)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *gdp_bh;
@@ -1179,6 +1195,7 @@ int ext3_new_block(handle_t *handle, str
 	static int goal_hits, goal_attempts;
 #endif
 	unsigned long ngroups;
+	unsigned long num = *count;
 
 	*errp = -ENOSPC;
 	sb = inode->i_sb;
@@ -1245,7 +1262,7 @@ retry:
 		if (!bitmap_bh)
 			goto io_error;
 		ret_block = ext3_try_to_allocate_with_rsv(sb, handle, group_no,
-					bitmap_bh, ret_block, my_rsv, &fatal);
+					bitmap_bh, ret_block, my_rsv, &num, &fatal);
 		if (fatal)
 			goto out;
 		if (ret_block >= 0)
@@ -1282,7 +1299,7 @@ retry:
 		if (!bitmap_bh)
 			goto io_error;
 		ret_block = ext3_try_to_allocate_with_rsv(sb, handle, group_no,
-					bitmap_bh, -1, my_rsv, &fatal);
+					bitmap_bh, -1, my_rsv, &num, &fatal);
 		if (fatal)
 			goto out;
 		if (ret_block >= 0) 
@@ -1389,6 +1406,7 @@ allocated:
 
 	*errp = 0;
 	brelse(bitmap_bh);
+	*count = num;
 	return ret_block;
 
 io_error:
@@ -1407,6 +1425,16 @@ out:
 	return 0;
 }
 
+int ext3_new_block(handle_t *handle, struct inode *inode,
+			unsigned long goal, int *errp)
+{
+	unsigned long ret;
+	unsigned long count = 1;
+
+	ret = ext3_new_blocks(handle, inode, goal, &count, errp);
+
+	return ret;
+}
 unsigned long ext3_count_free_blocks(struct super_block *sb)
 {
 	unsigned long desc_count;
diff -puN include/linux/ext3_fs.h~ext3-new-blocks-base include/linux/ext3_fs.h
--- linux-2.6.15/include/linux/ext3_fs.h~ext3-new-blocks-base	2006-01-10 14:25:34.273626550 -0800
+++ linux-2.6.15-ming/include/linux/ext3_fs.h	2006-01-10 14:25:34.280625736 -0800
@@ -36,7 +36,8 @@ struct statfs;
  * Define EXT3_RESERVATION to reserve data blocks for expanding files
  */
 #define EXT3_DEFAULT_RESERVE_BLOCKS     8
-#define EXT3_MAX_RESERVE_BLOCKS         1024
+/*max window size: 1024(direct blocks) + 3([t,d]indirect blocks) */
+#define EXT3_MAX_RESERVE_BLOCKS         1027
 #define EXT3_RESERVE_WINDOW_NOT_ALLOCATED 0
 /*
  * Always enable hashed directories
@@ -732,6 +733,8 @@ struct dir_private_info {
 extern int ext3_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext3_bg_num_gdb(struct super_block *sb, int group);
 extern int ext3_new_block (handle_t *, struct inode *, unsigned long, int *);
+extern int ext3_new_blocks (handle_t *, struct inode *, unsigned long,
+			unsigned long *, int *);
 extern void ext3_free_blocks (handle_t *, struct inode *, unsigned long,
 			      unsigned long);
 extern void ext3_free_blocks_sb (handle_t *, struct super_block *,

_


