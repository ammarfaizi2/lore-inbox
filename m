Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSFJNxp>; Mon, 10 Jun 2002 09:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSFJNu2>; Mon, 10 Jun 2002 09:50:28 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:24448 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315168AbSFJNuN>;
	Mon, 10 Jun 2002 09:50:13 -0400
Date: Mon, 10 Jun 2002 17:42:56 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADgu6D003860@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 7 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 7 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message

  renamed journal device buffer head funcs and moved them into reiserfs_fs.h

Chris Mason spent a lot of efforts in helping to convert this changeset to
Linus-compatible form.

Diffstat:
 fs/reiserfs/journal.c       |   39 ++++++++++++---------------------------
 include/linux/reiserfs_fs.h |    5 +++++
 2 files changed, 17 insertions(+), 27 deletions(-)

Plaintext patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.600   -> 1.601  
#	fs/reiserfs/journal.c	1.46    -> 1.47   
#	include/linux/reiserfs_fs.h	1.32    -> 1.33   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.601
# reiserfs_fs.h, journal.c:
#   renamed journal device buffer head funcs and moved them into reiserfs_fs.h.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Thu May 30 18:42:21 2002
+++ b/fs/reiserfs/journal.c	Thu May 30 18:42:21 2002
@@ -99,21 +99,6 @@
 static int release_journal_dev( struct super_block *super,
 				struct reiserfs_journal *journal );
 
-static inline struct buffer_head *journ_get_hash_table(struct super_block *s, int block)
-{
-	return __get_hash_table(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize);
-}
- 
-static inline struct buffer_head *journ_getblk(struct super_block *s, int block)
-{
-	return __getblk(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize);
-}
-
-static inline struct buffer_head *journ_bread(struct super_block *s, int block)
-{
-	return __bread(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize);
-}
-
 static void init_journal_hash(struct super_block *p_s_sb) {
   memset(SB_JOURNAL(p_s_sb)->j_hash_table, 0, JOURNAL_HASH_SIZE * sizeof(struct reiserfs_journal_cnode *)) ;
 }
@@ -704,7 +689,7 @@
   count = 0 ;
   for (i = 0 ; atomic_read(&(jl->j_commit_left)) > 1 && i < (jl->j_len + 1) ; i++) {  /* everything but commit_bh */
     bn = SB_ONDISK_JOURNAL_1st_BLOCK(s) + (jl->j_start+i) %  SB_ONDISK_JOURNAL_SIZE(s);
-    tbh = journ_get_hash_table(s, bn) ;
+    tbh = journal_get_hash_table(s, bn) ;
 
 /* kill this sanity check */
 if (count > (orig_commit_left + 2)) {
@@ -733,7 +718,7 @@
     for (i = 0 ; atomic_read(&(jl->j_commit_left)) > 1 && 
                  i < (jl->j_len + 1) ; i++) {  /* everything but commit_bh */
       bn = SB_ONDISK_JOURNAL_1st_BLOCK(s) + (jl->j_start + i) % SB_ONDISK_JOURNAL_SIZE(s) ;
-      tbh = journ_get_hash_table(s, bn) ;
+      tbh = journal_get_hash_table(s, bn) ;
 
       wait_on_buffer(tbh) ;
       if (!buffer_uptodate(tbh)) {
@@ -1426,7 +1411,7 @@
     offset = d_bh->b_blocknr - SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) ;
 
     /* ok, we have a journal description block, lets see if the transaction was valid */
-    c_bh = journ_bread(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) +
+    c_bh = journal_bread(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) +
 		 ((offset + le32_to_cpu(desc->j_len) + 1) % SB_ONDISK_JOURNAL_SIZE(p_s_sb))) ;
     if (!c_bh)
       return 0 ;
@@ -1481,7 +1466,7 @@
   unsigned long trans_offset ;
   int i;
 
-  d_bh = journ_bread(p_s_sb, cur_dblock) ;
+  d_bh = journal_bread(p_s_sb, cur_dblock) ;
   if (!d_bh)
     return 1 ;
   desc = (struct reiserfs_journal_desc *)d_bh->b_data ;
@@ -1505,7 +1490,7 @@
     brelse(d_bh) ;
     return 1 ;
   }
-  c_bh = journ_bread(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) +
+  c_bh = journal_bread(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) +
 		((trans_offset + le32_to_cpu(desc->j_len) + 1) % 
 		 SB_ONDISK_JOURNAL_SIZE(p_s_sb))) ;
   if (!c_bh) {
@@ -1536,7 +1521,7 @@
   }
   /* get all the buffer heads */
   for(i = 0 ; i < le32_to_cpu(desc->j_len) ; i++) {
-    log_blocks[i] =  journ_getblk(p_s_sb,  SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + (trans_offset + 1 + i) % SB_ONDISK_JOURNAL_SIZE(p_s_sb));
+    log_blocks[i] =  journal_getblk(p_s_sb,  SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + (trans_offset + 1 + i) % SB_ONDISK_JOURNAL_SIZE(p_s_sb));
     if (i < JOURNAL_TRANS_HALF) {
       real_blocks[i] = sb_getblk(p_s_sb, le32_to_cpu(desc->j_realblock[i])) ;
     } else {
@@ -1674,7 +1659,7 @@
   ** is the first unflushed, and if that transaction is not valid, 
   ** replay is done
   */
-  SB_JOURNAL(p_s_sb)->j_header_bh = journ_bread(p_s_sb,
+  SB_JOURNAL(p_s_sb)->j_header_bh = journal_bread(p_s_sb,
 					   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
 					   SB_ONDISK_JOURNAL_SIZE(p_s_sb));
   if (!SB_JOURNAL(p_s_sb)->j_header_bh) {
@@ -1698,7 +1683,7 @@
     ** there is nothing more we can do, and it makes no sense to read 
     ** through the whole log.
     */
-    d_bh = journ_bread(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + le32_to_cpu(jh->j_first_unflushed_offset)) ;
+    d_bh = journal_bread(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + le32_to_cpu(jh->j_first_unflushed_offset)) ;
     ret = journal_transaction_is_valid(p_s_sb, d_bh, NULL, NULL) ;
     if (!ret) {
       continue_replay = 0 ;
@@ -2048,7 +2033,7 @@
      rs = SB_DISK_SUPER_BLOCK(p_s_sb);
      
      /* read journal header */
-     bhjh = journ_bread(p_s_sb,
+     bhjh = journal_bread(p_s_sb,
 		   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_ONDISK_JOURNAL_SIZE(p_s_sb));
      if (!bhjh) {
 	 printk("sh-459: unable to read  journal header\n") ;
@@ -2988,7 +2973,7 @@
   
   rs = SB_DISK_SUPER_BLOCK(p_s_sb) ;
   /* setup description block */
-  d_bh = journ_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_JOURNAL(p_s_sb)->j_start) ; 
+  d_bh = journal_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_JOURNAL(p_s_sb)->j_start) ; 
   set_buffer_uptodate(d_bh) ;
   desc = (struct reiserfs_journal_desc *)(d_bh)->b_data ;
   memset(desc, 0, sizeof(struct reiserfs_journal_desc)) ;
@@ -2996,7 +2981,7 @@
   desc->j_trans_id = cpu_to_le32(SB_JOURNAL(p_s_sb)->j_trans_id) ;
 
   /* setup commit block.  Don't write (keep it clean too) this one until after everyone else is written */
-  c_bh =  journ_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
+  c_bh =  journal_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
 		 ((SB_JOURNAL(p_s_sb)->j_start + SB_JOURNAL(p_s_sb)->j_len + 1) % SB_ONDISK_JOURNAL_SIZE(p_s_sb))) ;
   commit = (struct reiserfs_journal_commit *)c_bh->b_data ;
   memset(commit, 0, sizeof(struct reiserfs_journal_commit)) ;
@@ -3087,7 +3072,7 @@
     /* copy all the real blocks into log area.  dirty log blocks */
     if (test_bit(BH_JDirty, &cn->bh->b_state)) {
       struct buffer_head *tmp_bh ;
-      tmp_bh =  journ_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
+      tmp_bh =  journal_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
 		       ((cur_write_start + jindex) % SB_ONDISK_JOURNAL_SIZE(p_s_sb))) ;
       set_buffer_uptodate(tmp_bh) ;
       memcpy(tmp_bh->b_data, cn->bh->b_data, cn->bh->b_size) ;  
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Thu May 30 18:42:21 2002
+++ b/include/linux/reiserfs_fs.h	Thu May 30 18:42:21 2002
@@ -1652,6 +1652,11 @@
 */
 #define JOURNAL_BUFFER(j,n) ((j)->j_ap_blocks[((j)->j_start + (n)) % JOURNAL_BLOCK_COUNT])
 
+// We need these to make journal.c code more readable
+#define journal_get_hash_table(s, block) __get_hash_table(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize)
+#define journal_getblk(s, block) __getblk(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize)
+#define journal_bread(s, block) __bread(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize)
+
 void reiserfs_commit_for_inode(struct inode *) ;
 void reiserfs_update_inode_transaction(struct inode *) ;
 void reiserfs_wait_on_write_block(struct super_block *s) ;
