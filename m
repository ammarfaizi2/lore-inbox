Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316831AbSFQGwk>; Mon, 17 Jun 2002 02:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316828AbSFQGwU>; Mon, 17 Jun 2002 02:52:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31246 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316821AbSFQGtb>;
	Mon, 17 Jun 2002 02:49:31 -0400
Message-ID: <3D0D876C.6C37408F@zip.com.au>
Date: Sun, 16 Jun 2002 23:53:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 17/19] rename get_hash_table() to find_get_block()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Renames the buffer_head lookup function `get_hash_table' to
`find_get_block'.

get_hash_table() is too generic a name. Plus it doesn't even use a hash
any more.




--- 2.5.22/fs/buffer.c~rename-get_hash_table	Sun Jun 16 23:12:53 2002
+++ 2.5.22-akpm/fs/buffer.c	Sun Jun 16 23:22:43 2002
@@ -378,7 +378,7 @@ out:
 }
 
 /*
- * Various filesystems appear to want __get_hash_table to be non-blocking.
+ * Various filesystems appear to want __find_get_block to be non-blocking.
  * But it's the page lock which protects the buffers.  To get around this,
  * we get exclusion from try_to_free_buffers with the blockdev mapping's
  * private_lock.
@@ -389,7 +389,7 @@ out:
  * private_lock is contended then so is mapping->page_lock).
  */
 struct buffer_head *
-__get_hash_table(struct block_device *bdev, sector_t block, int unused)
+__find_get_block(struct block_device *bdev, sector_t block, int unused)
 {
 	struct inode *bd_inode = bdev->bd_inode;
 	struct address_space *bd_mapping = bd_inode->i_mapping;
@@ -1091,7 +1091,7 @@ grow_dev_page(struct block_device *bdev,
 
 	/*
 	 * Link the page to the buffers and initialise them.  Take the
-	 * lock to be atomic wrt __get_hash_table(), which does not
+	 * lock to be atomic wrt __find_get_block(), which does not
 	 * run under the page lock.
 	 */
 	spin_lock(&inode->i_mapping->private_lock);
@@ -1164,7 +1164,7 @@ __getblk(struct block_device *bdev, sect
 	for (;;) {
 		struct buffer_head * bh;
 
-		bh = __get_hash_table(bdev, block, size);
+		bh = __find_get_block(bdev, block, size);
 		if (bh) {
 			touch_buffer(bh);
 			return bh;
@@ -1449,7 +1449,7 @@ void unmap_underlying_metadata(struct bl
 {
 	struct buffer_head *old_bh;
 
-	old_bh = __get_hash_table(bdev, block, 0);
+	old_bh = __find_get_block(bdev, block, 0);
 	if (old_bh) {
 #if 0	/* This happens.  Later. */
 		if (buffer_dirty(old_bh))
--- 2.5.22/fs/ext3/balloc.c~rename-get_hash_table	Sun Jun 16 23:12:53 2002
+++ 2.5.22-akpm/fs/ext3/balloc.c	Sun Jun 16 23:12:53 2002
@@ -352,7 +352,7 @@ do_more:
 #ifdef CONFIG_JBD_DEBUG
 		{
 			struct buffer_head *debug_bh;
-			debug_bh = sb_get_hash_table(sb, block + i);
+			debug_bh = sb_find_get_block(sb, block + i);
 			if (debug_bh) {
 				BUFFER_TRACE(debug_bh, "Deleted!");
 				if (!bh2jh(bitmap_bh)->b_committed_data)
@@ -701,7 +701,7 @@ got_block:
 		struct buffer_head *debug_bh;
 
 		/* Record bitmap buffer state in the newly allocated block */
-		debug_bh = sb_get_hash_table(sb, tmp);
+		debug_bh = sb_find_get_block(sb, tmp);
 		if (debug_bh) {
 			BUFFER_TRACE(debug_bh, "state when allocated");
 			BUFFER_TRACE2(debug_bh, bh, "bitmap state");
--- 2.5.22/fs/ext3/inode.c~rename-get_hash_table	Sun Jun 16 23:12:53 2002
+++ 2.5.22-akpm/fs/ext3/inode.c	Sun Jun 16 23:12:53 2002
@@ -1650,7 +1650,7 @@ ext3_clear_blocks(handle_t *handle, stru
 			struct buffer_head *bh;
 
 			*p = 0;
-			bh = sb_get_hash_table(inode->i_sb, nr);
+			bh = sb_find_get_block(inode->i_sb, nr);
 			ext3_forget(handle, 0, inode, bh, nr);
 		}
 	}
--- 2.5.22/fs/jbd/revoke.c~rename-get_hash_table	Sun Jun 16 23:12:53 2002
+++ 2.5.22-akpm/fs/jbd/revoke.c	Sun Jun 16 23:12:53 2002
@@ -293,7 +293,7 @@ int journal_revoke(handle_t *handle, uns
 	bh = bh_in;
 
 	if (!bh) {
-		bh = __get_hash_table(bdev, blocknr, journal->j_blocksize);
+		bh = __find_get_block(bdev, blocknr, journal->j_blocksize);
 		if (bh)
 			BUFFER_TRACE(bh, "found on hash");
 	}
@@ -303,7 +303,7 @@ int journal_revoke(handle_t *handle, uns
 
 		/* If there is a different buffer_head lying around in
 		 * memory anywhere... */
-		bh2 = __get_hash_table(bdev, blocknr, journal->j_blocksize);
+		bh2 = __find_get_block(bdev, blocknr, journal->j_blocksize);
 		if (bh2) {
 			/* ... and it has RevokeValid status... */
 			if ((bh2 != bh) &&
@@ -407,7 +407,7 @@ int journal_cancel_revoke(handle_t *hand
 	 * state machine will get very upset later on. */
 	if (need_cancel) {
 		struct buffer_head *bh2;
-		bh2 = __get_hash_table(bh->b_bdev, bh->b_blocknr, bh->b_size);
+		bh2 = __find_get_block(bh->b_bdev, bh->b_blocknr, bh->b_size);
 		if (bh2) {
 			if (bh2 != bh)
 				clear_bit(BH_Revoked, &bh2->b_state);
--- 2.5.22/fs/qnx4/fsync.c~rename-get_hash_table	Sun Jun 16 23:12:53 2002
+++ 2.5.22-akpm/fs/qnx4/fsync.c	Sun Jun 16 23:12:53 2002
@@ -37,7 +37,7 @@ static int sync_block(struct inode *inod
 	if (!*block)
 		return 0;
 	tmp = *block;
-	bh = sb_get_hash_table(inode->i_sb, *block);
+	bh = sb_find_get_block(inode->i_sb, *block);
 	if (!bh)
 		return 0;
 	if (*block != tmp) {
--- 2.5.22/fs/reiserfs/fix_node.c~rename-get_hash_table	Sun Jun 16 23:12:53 2002
+++ 2.5.22-akpm/fs/reiserfs/fix_node.c	Sun Jun 16 23:12:53 2002
@@ -920,7 +920,7 @@ static int  is_left_neighbor_in_cache(
   /* Get left neighbor block number. */
   n_left_neighbor_blocknr = B_N_CHILD_NUM(p_s_tb->FL[n_h], n_left_neighbor_position);
   /* Look for the left neighbor in the cache. */
-  if ( (left = sb_get_hash_table(p_s_sb, n_left_neighbor_blocknr)) ) {
+  if ( (left = sb_find_get_block(p_s_sb, n_left_neighbor_blocknr)) ) {
 
     RFALSE( buffer_uptodate (left) && ! B_IS_IN_TREE(left),
 	    "vs-8170: left neighbor (%b %z) is not in the tree", left, left);
--- 2.5.22/fs/reiserfs/journal.c~rename-get_hash_table	Sun Jun 16 23:12:53 2002
+++ 2.5.22-akpm/fs/reiserfs/journal.c	Sun Jun 16 23:12:53 2002
@@ -689,7 +689,7 @@ retry:
   count = 0 ;
   for (i = 0 ; atomic_read(&(jl->j_commit_left)) > 1 && i < (jl->j_len + 1) ; i++) {  /* everything but commit_bh */
     bn = SB_ONDISK_JOURNAL_1st_BLOCK(s) + (jl->j_start+i) %  SB_ONDISK_JOURNAL_SIZE(s);
-    tbh = journal_get_hash_table(s, bn) ;
+    tbh = journal_find_get_block(s, bn) ;
 
 /* kill this sanity check */
 if (count > (orig_commit_left + 2)) {
@@ -718,7 +718,7 @@ reiserfs_panic(s, "journal-539: flush_co
     for (i = 0 ; atomic_read(&(jl->j_commit_left)) > 1 && 
                  i < (jl->j_len + 1) ; i++) {  /* everything but commit_bh */
       bn = SB_ONDISK_JOURNAL_1st_BLOCK(s) + (jl->j_start + i) % SB_ONDISK_JOURNAL_SIZE(s) ;
-      tbh = journal_get_hash_table(s, bn) ;
+      tbh = journal_find_get_block(s, bn) ;
 
       wait_on_buffer(tbh) ;
       if (!buffer_uptodate(tbh)) {
@@ -2764,7 +2764,7 @@ int journal_mark_freed(struct reiserfs_t
   int cleaned = 0 ;
   
   if (reiserfs_dont_log(th->t_super)) {
-    bh = sb_get_hash_table(p_s_sb, blocknr) ;
+    bh = sb_find_get_block(p_s_sb, blocknr) ;
     if (bh && buffer_dirty (bh)) {
       printk ("journal_mark_freed(dont_log): dirty buffer on hash list: %lx %ld\n", bh->b_state, blocknr);
       BUG ();
@@ -2772,7 +2772,7 @@ int journal_mark_freed(struct reiserfs_t
     brelse (bh);
     return 0 ;
   }
-  bh = sb_get_hash_table(p_s_sb, blocknr) ;
+  bh = sb_find_get_block(p_s_sb, blocknr) ;
   /* if it is journal new, we just remove it from this transaction */
   if (bh && buffer_journal_new(bh)) {
     mark_buffer_notjournal_new(bh) ;
--- 2.5.22/fs/ufs/truncate.c~rename-get_hash_table	Sun Jun 16 23:12:53 2002
+++ 2.5.22-akpm/fs/ufs/truncate.c	Sun Jun 16 23:12:53 2002
@@ -117,7 +117,7 @@ static int ufs_trunc_direct (struct inod
 	frag1 = ufs_fragnum (frag1);
 	frag2 = ufs_fragnum (frag2);
 	for (j = frag1; j < frag2; j++) {
-		bh = sb_get_hash_table (sb, tmp + j);
+		bh = sb_find_get_block (sb, tmp + j);
 		if ((bh && DATA_BUFFER_USED(bh)) || tmp != fs32_to_cpu(sb, *p)) {
 			retry = 1;
 			brelse (bh);
@@ -140,7 +140,7 @@ next1:
 		if (!tmp)
 			continue;
 		for (j = 0; j < uspi->s_fpb; j++) {
-			bh = sb_get_hash_table(sb, tmp + j);
+			bh = sb_find_get_block(sb, tmp + j);
 			if ((bh && DATA_BUFFER_USED(bh)) || tmp != fs32_to_cpu(sb, *p)) {
 				retry = 1;
 				brelse (bh);
@@ -179,7 +179,7 @@ next2:;
 		ufs_panic(sb, "ufs_truncate_direct", "internal error");
 	frag4 = ufs_fragnum (frag4);
 	for (j = 0; j < frag4; j++) {
-		bh = sb_get_hash_table (sb, tmp + j);
+		bh = sb_find_get_block (sb, tmp + j);
 		if ((bh && DATA_BUFFER_USED(bh)) || tmp != fs32_to_cpu(sb, *p)) {
 			retry = 1;
 			brelse (bh);
@@ -238,7 +238,7 @@ static int ufs_trunc_indirect (struct in
 		if (!tmp)
 			continue;
 		for (j = 0; j < uspi->s_fpb; j++) {
-			bh = sb_get_hash_table(sb, tmp + j);
+			bh = sb_find_get_block(sb, tmp + j);
 			if ((bh && DATA_BUFFER_USED(bh)) || tmp != fs32_to_cpu(sb, *ind)) {
 				retry = 1;
 				brelse (bh);
--- 2.5.22/include/linux/buffer_head.h~rename-get_hash_table	Sun Jun 16 23:12:53 2002
+++ 2.5.22-akpm/include/linux/buffer_head.h	Sun Jun 16 23:22:43 2002
@@ -158,7 +158,7 @@ int fsync_dev(kdev_t);
 int fsync_bdev(struct block_device *);
 int fsync_super(struct super_block *);
 int fsync_no_super(struct block_device *);
-struct buffer_head *__get_hash_table(struct block_device *, sector_t, int);
+struct buffer_head *__find_get_block(struct block_device *, sector_t, int);
 struct buffer_head * __getblk(struct block_device *, sector_t, int);
 void __brelse(struct buffer_head *);
 void __bforget(struct buffer_head *);
@@ -252,9 +252,9 @@ static inline struct buffer_head * sb_ge
 }
 
 static inline struct buffer_head *
-sb_get_hash_table(struct super_block *sb, int block)
+sb_find_get_block(struct super_block *sb, int block)
 {
-	return __get_hash_table(sb->s_bdev, block, sb->s_blocksize);
+	return __find_get_block(sb->s_bdev, block, sb->s_blocksize);
 }
 
 static inline void
--- 2.5.22/kernel/ksyms.c~rename-get_hash_table	Sun Jun 16 23:12:53 2002
+++ 2.5.22-akpm/kernel/ksyms.c	Sun Jun 16 23:12:53 2002
@@ -554,7 +554,7 @@ EXPORT_SYMBOL(file_fsync);
 EXPORT_SYMBOL(fsync_buffers_list);
 EXPORT_SYMBOL(clear_inode);
 EXPORT_SYMBOL(init_special_inode);
-EXPORT_SYMBOL(__get_hash_table);
+EXPORT_SYMBOL(__find_get_block);
 EXPORT_SYMBOL(new_inode);
 EXPORT_SYMBOL(__insert_inode_hash);
 EXPORT_SYMBOL(remove_inode_hash);
--- 2.5.22/drivers/md/lvm-snap.c~rename-get_hash_table	Sun Jun 16 23:12:53 2002
+++ 2.5.22-akpm/drivers/md/lvm-snap.c	Sun Jun 16 23:12:53 2002
@@ -224,7 +224,7 @@ static inline void invalidate_snap_cache
 
 	for (i = 0; i < nr; i++)
 	{
-		bh = get_hash_table(dev, start++, blksize);
+		bh = find_get_block(dev, start++, blksize);
 		if (bh)
 			bforget(bh);
 	}
--- 2.5.22/include/linux/reiserfs_fs.h~rename-get_hash_table	Sun Jun 16 23:12:53 2002
+++ 2.5.22-akpm/include/linux/reiserfs_fs.h	Sun Jun 16 23:12:53 2002
@@ -1651,7 +1651,7 @@ extern wait_queue_head_t reiserfs_commit
 #define JOURNAL_BUFFER(j,n) ((j)->j_ap_blocks[((j)->j_start + (n)) % JOURNAL_BLOCK_COUNT])
 
 // We need these to make journal.c code more readable
-#define journal_get_hash_table(s, block) __get_hash_table(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize)
+#define journal_find_get_block(s, block) __find_get_block(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize)
 #define journal_getblk(s, block) __getblk(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize)
 #define journal_bread(s, block) __bread(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize)
 

-
