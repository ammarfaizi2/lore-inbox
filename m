Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289657AbSA2MX6>; Tue, 29 Jan 2002 07:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289589AbSA2LnH>; Tue, 29 Jan 2002 06:43:07 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:62479 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289581AbSA2Lku>; Tue, 29 Jan 2002 06:40:50 -0500
Date: Mon, 28 Jan 2002 20:27:44 +0300
Message-Id: <200201281727.g0SHRik22950@bitshadow.namesys.com>
From: Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com
CC: reiser@namesys.com, reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS 2.5 Update Patch Set 2 of 25
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This set of patches of which this is one will update ReiserFS in 2.5
to contain all bugfixes applied to 2.4 plus allow relocating the journal plus
uuid support plus fix the kdev_t compilation failure.

02-reiserfs-journal-relocation.diff
    Support for relocated journals.


The other patches in this set are:


01-reiserfs-kdev-fixed.diff
    kdev_t fixes to comply with new interface.

02-reiserfs-journal-relocation.diff
    Support for relocated journals.

03-check_nlink_in_reiserfs_read_inode2.diff
    It is possible that knfsd is trying to access inode of a file
    that is being removed from the disk by some other thread. As we
    update sd on unlink all that is required is to check for nlink
    here. This bug was first found by Sizif when debugging
    SquidNG/Butterfly, forgotten, and found again after Philippe
    Gramoulle <philippe.gramoulle@mmania.com> reproduced it.

    More logical fix would require changes in fs/inode.c:iput() to
    remove inode from hash-table _after_ fs cleaned disk stuff up and
    in iget() to return NULL if I_FREEING inode is found in
    hash-table.  We await Al Viro doing the more logical fix, and we
    provide this fix so that users can work while we wait for the
    better fix.

04-bitmap-range-checking.diff
    Check that block number are going to free in a bitmap makes sense.
    This avoids oops after trying to access bitmap for wild block number.

05-prepare_for_delete_or_cut-cleanup.diff
    Patch by Chris Mason <Mason@Suse.COM>.
    prepare_for_delete_or_cut() tries to find the unformatted node in
    the buffer cache to make sure it isn't in use.  Since unformatted
    nodes are never in the buffer cache, this check is useless.  The
    page locking done by mm/vmscan.c:vmtruncate protects us from
    truncating away pages that are in use, so it is safe to just remove
    the bogus check from our code.

    Since the get_hash_table was also the reason for the repeat loop,
    this patch removes it as well.  

    This should make file deletes faster, at the very least it cuts down
    on CPU overhead for deletes/truncates.

06-E-cleanup.diff
    There is always place for Yet Another Cleanup of Reiserfs Code.

07-mmaped_data_loss_fix.diff
    fixes a bug first noticed using a Freebsd nfs testing tool. When writing to
    a previously mmaped-filled hole in file, and then writing with write() there
    again, page that write() hits loses mmap-written content.

08-unlink-truncate-opened.diff
    Fixes long-standing problem in reiserfs, when disk space gets leaked
    if crash occurred when some process hold a reference to unlinked file.

    It's possible to unlink file that is still opened by some
    process. In this case, body of file is actually removed at the time
    of last close. If crash occurs in between last unlink (when
    directory entry for this file is removed) and last close, body
    doesn't get unlinked and "disk-space-leak" occurs. To prevent this,
    unlink-truncate-opened patch stores in the tree a special record at the
    time of last unlink. This record is a form of logical logging and
    will be either removed during following close, or replayed during
    next mount after a crash.

09-chown-32-bit-fix.diff
        Reiserfs 3.5 disk format can only store 16 bit uid/gid inside
        stat-data. This patch adds error checking so that EINVAL is returned
        on attempt to change uid/gid of an old file to value that doesn't
        fit into 16 bit, in stead of silently truncating it into 16 bit.

10-journal-preallocated.diff
    Patch by Chris Mason for bug found and debugged by Anne Milicia
    (milicia@missioncriticallinux.com): don't run preallocated blocks
    through journal_mark_freed() and don't corrupt i_prealloc_block during
    __discard_prealloc().

11-double-replay.diff
    Patch by Chris Mason to avoid duplicate replay of last flushed
    transaction.

12-infinite-replay.diff
    Patch to break infinite loop in journal_read() in the case when the
    journal log area is completely filled with transactions.

13-scan_magic_cleanup.diff
    Fixes a problem with v3.6 fs mounted readonly and then remounted rw.
    
14-map_block_for_writepage_highmem_fix.diff
    Fixes erroroneous page access before making sure page is really accessable.
    Bug can be triggered only on highmem sysetms.

15-long_symlinks_fix.diff
    Symlink-body length check was made against an incorrect value, allowing for
    too long nodes to be inserted into tree. This might lead to obscure 
    warnings in some cases.

16-tail_data_corruption_on_mempressure.diff
    Fixes a bug when mmap-write to a file tail and subsequent read cause written
    data to be lost due to page-cache interacting mistake in low number of free 
    buffers situation.

17-kreiserfsd-sleep-timeout.diff
    Correct a typo in fs/reiserfs/journal.c:
    interruptible_sleep_on_timeout() takes timeout in jiffies, rather
    than seconds.

18-corrupted_fs_panic_on_lookup_fix.diff
    Certain disk corruptions and i/o errors may cause lookup() to panic, which
    is wrong.

19-big-endian-const.diff
    Suppress compilation warnings on big endian platform.

20-rename_stale_item_bug.diff
    This patch fixes 2 bugs in reiserfs_rename(). First one being attempt to
    access item before verifying it was not moved since last access. Second
    is a window, where old filename may be written to disk with 'visible'
    flag unset without these changes be journaled.

21-reiserfs-inode_cache-fixed.diff
    reiserfs_inode_cache seems to be too long. converting it to
    reiser_inode_cache.

22-expanding-truncate-5.diff
    This patch makes sure that indirect pointers for holes are correctly filled
    in by zeroes at
    hole-creation time. (Author is Chris Mason. fs/buffer.c
    (generic_cont_expand) were written by Alexander Viro)

23-romount-nobug-onclose.diff
    Somebody introduced a bug in reiserfs_release_file() leading to corrupting
    journal for ro filesystems.

24-reiserfs-boot-verbose.diff
    Do not print unsuccesful superblocks read warnings 
    (if old or new one cannot be found). Print verbose journal info. 
    Convert warnings to standard format.

25-mount-convert-fix.diff
    Fixes a case where v3.6 filesystem can get wrong magic after converting
    from v3.5 one.





--- linux-2.5.3-pre4.o/fs/reiserfs/Makefile	Wed Nov 21 20:56:28 2001
+++ linux-2.5.3-pre4/fs/reiserfs/Makefile	Thu Jan 24 10:47:15 2002
@@ -9,7 +9,7 @@
 
 O_TARGET := reiserfs.o
 obj-y   := bitmap.o do_balan.o namei.o inode.o file.o dir.o fix_node.o super.o prints.o objectid.o \
-lbalance.o ibalance.o stree.o hashes.o buffer2.o tail_conversion.o journal.o resize.o tail_conversion.o version.o item_ops.o ioctl.o procfs.o
+lbalance.o ibalance.o stree.o hashes.o buffer2.o tail_conversion.o journal.o resize.o tail_conversion.o item_ops.o ioctl.o procfs.o
 
 obj-m   := $(O_TARGET)
 
--- linux-2.5.3-pre4.o/fs/reiserfs/bitmap.c	Thu Jan 24 10:45:26 2002
+++ linux-2.5.3-pre4/fs/reiserfs/bitmap.c	Thu Jan 24 10:47:15 2002
@@ -382,16 +382,18 @@
       goto free_and_return ;
     }
     search_start = new_block ;
-    if (search_start >= reiserfs_get_journal_block(s) &&
-        search_start < (reiserfs_get_journal_block(s) + JOURNAL_BLOCK_COUNT)) {
-	reiserfs_warning("vs-4130: reiserfs_new_blocknrs: trying to allocate log block %lu\n",
-			 search_start) ;
-	search_start++ ;
-	amount_needed++ ;
-	continue ;
-    }
-       
 
+
+    /* make sure the block is not of journal or reserved area */
+    if (is_block_in_log_or_reserved_area(s, search_start)) {
+      reiserfs_warning("vs-4130: reiserfs_new_blocknrs: trying to allocate log block %lu\n",
+		       search_start) ;
+      search_start++ ;
+      amount_needed++ ;
+      continue ;
+    }
+    
+    
     reiserfs_prepare_for_journal(s, SB_AP_BITMAP(s)[i], 1) ;
 
     RFALSE( buffer_locked (SB_AP_BITMAP (s)[i]) || 
@@ -589,6 +591,7 @@
   *free_blocknrs = 0;
   blks = PREALLOCATION_SIZE-1;
   for (blks_gotten=0; blks_gotten<PREALLOCATION_SIZE; blks_gotten++) {
+
     ret = do_reiserfs_new_blocknrs(th, free_blocknrs, search_start, 
 				   1/*amount_needed*/, 
 				   0/*for root reserved*/,
--- linux-2.5.3-pre4.o/fs/reiserfs/journal.c	Thu Jan 24 10:45:26 2002
+++ linux-2.5.3-pre4/fs/reiserfs/journal.c	Thu Jan 24 10:47:15 2002
@@ -92,6 +92,8 @@
 static int flush_journal_list(struct super_block *s, struct reiserfs_journal_list *jl, int flushall) ;
 static int flush_commit_list(struct super_block *s, struct reiserfs_journal_list *jl, int flushall)  ;
 static int can_dirty(struct reiserfs_journal_cnode *cn) ;
+static int release_journal_dev( struct super_block *super,
+				struct reiserfs_journal *journal );
 
 static void init_journal_hash(struct super_block *p_s_sb) {
   memset(SB_JOURNAL(p_s_sb)->j_hash_table, 0, JOURNAL_HASH_SIZE * sizeof(struct reiserfs_journal_cnode *)) ;
@@ -670,7 +672,7 @@
   atomic_set(&(jl->j_commit_flushing), 1) ; 
 
 
-  if (jl->j_len > JOURNAL_TRANS_MAX) {
+  if (jl->j_len > SB_JOURNAL_TRANS_MAX(s)) {
     reiserfs_panic(s, "journal-512: flush_commit_list: length is %lu, list number %d\n", jl->j_len, jl - SB_JOURNAL_LIST(s)) ;
     return 0 ;
   }
@@ -684,8 +686,8 @@
 retry:
   count = 0 ;
   for (i = 0 ; atomic_read(&(jl->j_commit_left)) > 1 && i < (jl->j_len + 1) ; i++) {  /* everything but commit_bh */
-    bn = reiserfs_get_journal_block(s) + (jl->j_start+i) % JOURNAL_BLOCK_COUNT;
-    tbh = sb_get_hash_table(s, bn) ;
+    bn = SB_ONDISK_JOURNAL_1st_BLOCK(s) + (jl->j_start+i) %  SB_ONDISK_JOURNAL_SIZE(s);
+    tbh = get_hash_table(SB_JOURNAL_DEV(s), bn, s->s_blocksize) ;
 
 /* kill this sanity check */
 if (count > (orig_commit_left + 2)) {
@@ -713,8 +715,8 @@
   if (count > 0) {
     for (i = 0 ; atomic_read(&(jl->j_commit_left)) > 1 && 
                  i < (jl->j_len + 1) ; i++) {  /* everything but commit_bh */
-      bn = reiserfs_get_journal_block(s) + (jl->j_start + i) % JOURNAL_BLOCK_COUNT  ;
-      tbh = sb_get_hash_table(s, bn) ;
+      bn = SB_ONDISK_JOURNAL_1st_BLOCK(s) + (jl->j_start + i) % SB_ONDISK_JOURNAL_SIZE(s) ;
+      tbh = get_hash_table(SB_JOURNAL_DEV(s), bn, s->s_blocksize) ;
 
       wait_on_buffer(tbh) ;
       if (!buffer_uptodate(tbh)) {
@@ -928,7 +930,7 @@
   atomic_set(&(jl->j_flushing), 1) ;
 
   count = 0 ;
-  if (j_len_saved > JOURNAL_TRANS_MAX) {
+  if (j_len_saved > SB_JOURNAL_TRANS_MAX(s)) {
     reiserfs_panic(s, "journal-715: flush_journal_list, length is %lu, list number %d\n", j_len_saved, jl - SB_JOURNAL_LIST(s)) ;
     atomic_dec(&(jl->j_flushing)) ;
     return 0 ;
@@ -1085,7 +1087,7 @@
   ** being flushed
   */
   if (flushall) {
-    update_journal_header_block(s, (jl->j_start + jl->j_len + 2) % JOURNAL_BLOCK_COUNT, jl->j_trans_id) ;
+    update_journal_header_block(s, (jl->j_start + jl->j_len + 2) % SB_ONDISK_JOURNAL_SIZE(s), jl->j_trans_id) ;
   }
   remove_all_from_journal_list(s, jl, 0) ;
   jl->j_len = 0 ;
@@ -1342,6 +1344,7 @@
   wake_up(&reiserfs_commit_thread_wait) ;
   sleep_on(&reiserfs_commit_thread_done) ;
 
+  release_journal_dev( p_s_sb, SB_JOURNAL( p_s_sb ) );
   free_journal_ram(p_s_sb) ;
 
   return 0 ;
@@ -1365,7 +1368,7 @@
 			               struct reiserfs_journal_commit *commit) {
   if (le32_to_cpu(commit->j_trans_id) != le32_to_cpu(desc->j_trans_id) || 
       le32_to_cpu(commit->j_len) != le32_to_cpu(desc->j_len) || 
-      le32_to_cpu(commit->j_len) > JOURNAL_TRANS_MAX || 
+      le32_to_cpu(commit->j_len) > SB_JOURNAL_TRANS_MAX(p_s_sb) || 
       le32_to_cpu(commit->j_len) <= 0 
   ) {
     return 1 ;
@@ -1401,10 +1404,12 @@
 		     *newest_mount_id) ;
       return -1 ;
     }
-    offset = d_bh->b_blocknr - reiserfs_get_journal_block(p_s_sb) ;
+    offset = d_bh->b_blocknr - SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) ;
 
     /* ok, we have a journal description block, lets see if the transaction was valid */
-    c_bh = sb_bread(p_s_sb, reiserfs_get_journal_block(p_s_sb) + ((offset + le32_to_cpu(desc->j_len) + 1) % JOURNAL_BLOCK_COUNT)) ;
+    c_bh = bread(SB_JOURNAL_DEV(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) +
+		 ((offset + le32_to_cpu(desc->j_len) + 1) % SB_ONDISK_JOURNAL_SIZE(p_s_sb)), 
+		 p_s_sb->s_blocksize) ;
     if (!c_bh)
       return 0 ;
     commit = (struct reiserfs_journal_commit *)c_bh->b_data ;
@@ -1412,7 +1417,7 @@
       reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, 
                      "journal_transaction_is_valid, commit offset %ld had bad "
 		     "time %d or length %d\n", 
-		     c_bh->b_blocknr - reiserfs_get_journal_block(p_s_sb),
+		     c_bh->b_blocknr -  SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb),
 		     le32_to_cpu(commit->j_trans_id), 
 		     le32_to_cpu(commit->j_len));
       brelse(c_bh) ;
@@ -1426,7 +1431,7 @@
     brelse(c_bh) ;
     reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1006: found valid "
                    "transaction start offset %lu, len %d id %d\n", 
-		   d_bh->b_blocknr - reiserfs_get_journal_block(p_s_sb), 
+		   d_bh->b_blocknr - SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb), 
 		   le32_to_cpu(desc->j_len), le32_to_cpu(desc->j_trans_id)) ;
     return 1 ;
   } else {
@@ -1458,19 +1463,19 @@
   unsigned long trans_offset ;
   int i;
 
-  d_bh = sb_bread(p_s_sb, cur_dblock) ;
+  d_bh = bread(SB_JOURNAL_DEV(p_s_sb), cur_dblock, p_s_sb->s_blocksize) ;
   if (!d_bh)
     return 1 ;
   desc = (struct reiserfs_journal_desc *)d_bh->b_data ;
-  trans_offset = d_bh->b_blocknr - reiserfs_get_journal_block(p_s_sb) ;
+  trans_offset = d_bh->b_blocknr - SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) ;
   reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1037: "
                  "journal_read_transaction, offset %lu, len %d mount_id %d\n", 
-		 d_bh->b_blocknr - reiserfs_get_journal_block(p_s_sb), 
+		 d_bh->b_blocknr - SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb), 
 		 le32_to_cpu(desc->j_len), le32_to_cpu(desc->j_mount_id)) ;
   if (le32_to_cpu(desc->j_trans_id) < oldest_trans_id) {
     reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1039: "
                    "journal_read_trans skipping because %lu is too old\n", 
-		   cur_dblock - reiserfs_get_journal_block(p_s_sb)) ;
+		   cur_dblock - SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb)) ;
     brelse(d_bh) ;
     return 1 ;
   }
@@ -1482,7 +1487,9 @@
     brelse(d_bh) ;
     return 1 ;
   }
-  c_bh = sb_bread(p_s_sb, reiserfs_get_journal_block(p_s_sb) + ((trans_offset + le32_to_cpu(desc->j_len) + 1) % JOURNAL_BLOCK_COUNT)) ;
+  c_bh = bread(SB_JOURNAL_DEV(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) +
+		((trans_offset + le32_to_cpu(desc->j_len) + 1) % 
+		 SB_ONDISK_JOURNAL_SIZE(p_s_sb)), p_s_sb->s_blocksize) ;
   if (!c_bh) {
     brelse(d_bh) ;
     return 1 ;
@@ -1491,7 +1498,7 @@
   if (journal_compare_desc_commit(p_s_sb, desc, commit)) {
     reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal_read_transaction, "
                    "commit offset %ld had bad time %d or length %d\n", 
-		   c_bh->b_blocknr - reiserfs_get_journal_block(p_s_sb), 
+		   c_bh->b_blocknr -  SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb), 
 		   le32_to_cpu(commit->j_trans_id), le32_to_cpu(commit->j_len));
     brelse(c_bh) ;
     brelse(d_bh) ;
@@ -1511,14 +1518,14 @@
   }
   /* get all the buffer heads */
   for(i = 0 ; i < le32_to_cpu(desc->j_len) ; i++) {
-    log_blocks[i] = sb_getblk(p_s_sb, reiserfs_get_journal_block(p_s_sb) + (trans_offset + 1 + i) % JOURNAL_BLOCK_COUNT);
+    log_blocks[i] =  getblk(SB_JOURNAL_DEV(p_s_sb),  SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + (trans_offset + 1 + i) % SB_ONDISK_JOURNAL_SIZE(p_s_sb), p_s_sb->s_blocksize);
     if (i < JOURNAL_TRANS_HALF) {
       real_blocks[i] = sb_getblk(p_s_sb, le32_to_cpu(desc->j_realblock[i])) ;
     } else {
       real_blocks[i] = sb_getblk(p_s_sb, le32_to_cpu(commit->j_realblock[i - JOURNAL_TRANS_HALF])) ;
     }
-    if (real_blocks[i]->b_blocknr >= reiserfs_get_journal_block(p_s_sb) &&
-        real_blocks[i]->b_blocknr < (reiserfs_get_journal_block(p_s_sb)+JOURNAL_BLOCK_COUNT)) {
+    /* make sure we don't try to replay onto log or reserved area */
+    if (is_block_in_log_or_reserved_area(p_s_sb, real_blocks[i]->b_blocknr)) {
       reiserfs_warning("journal-1204: REPLAY FAILURE fsck required! Trying to replay onto a log block\n") ;
       brelse_array(log_blocks, i) ;
       brelse_array(real_blocks, i) ;
@@ -1565,13 +1572,13 @@
     }
     brelse(real_blocks[i]) ;
   }
-  cur_dblock = reiserfs_get_journal_block(p_s_sb) + ((trans_offset + le32_to_cpu(desc->j_len) + 2) % JOURNAL_BLOCK_COUNT) ;
+  cur_dblock =  SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + ((trans_offset + le32_to_cpu(desc->j_len) + 2) % SB_ONDISK_JOURNAL_SIZE(p_s_sb)) ;
   reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1095: setting journal "
                  "start to offset %ld\n", 
-		 cur_dblock - reiserfs_get_journal_block(p_s_sb)) ;
+		 cur_dblock -  SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb)) ;
   
   /* init starting values for the first transaction, in case this is the last transaction to be replayed. */
-  SB_JOURNAL(p_s_sb)->j_start = cur_dblock - reiserfs_get_journal_block(p_s_sb) ;
+  SB_JOURNAL(p_s_sb)->j_start = cur_dblock - SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) ;
   SB_JOURNAL(p_s_sb)->j_last_flush_trans_id = trans_id ;
   SB_JOURNAL(p_s_sb)->j_trans_id = trans_id + 1;
   brelse(c_bh) ;
@@ -1607,25 +1614,27 @@
   int continue_replay = 1 ;
   int ret ;
 
-  cur_dblock = reiserfs_get_journal_block(p_s_sb) ;
-  printk("reiserfs: checking transaction log (device %s) ...\n", p_s_sb->s_id) ;
+  cur_dblock = SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) ;
+  printk("reiserfs: checking transaction log (%s) for (%s)\n",
+	 bdevname(SB_JOURNAL_DEV(p_s_sb)), p_s_sb->s_id) ;
   start = CURRENT_TIME ;
 
   /* step 1, read in the journal header block.  Check the transaction it says 
   ** is the first unflushed, and if that transaction is not valid, 
   ** replay is done
   */
-  SB_JOURNAL(p_s_sb)->j_header_bh = sb_bread(p_s_sb, 
-                                          reiserfs_get_journal_block(p_s_sb) + 
-					  JOURNAL_BLOCK_COUNT) ;
+  SB_JOURNAL(p_s_sb)->j_header_bh = bread (SB_JOURNAL_DEV(p_s_sb),
+					   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
+					   SB_ONDISK_JOURNAL_SIZE(p_s_sb),
+					   p_s_sb->s_blocksize) ;
   if (!SB_JOURNAL(p_s_sb)->j_header_bh) {
     return 1 ;
   }
   jh = (struct reiserfs_journal_header *)(SB_JOURNAL(p_s_sb)->j_header_bh->b_data) ;
   if (le32_to_cpu(jh->j_first_unflushed_offset) >= 0 && 
-      le32_to_cpu(jh->j_first_unflushed_offset) < JOURNAL_BLOCK_COUNT &&
+      le32_to_cpu(jh->j_first_unflushed_offset) < SB_ONDISK_JOURNAL_SIZE(p_s_sb) && 
       le32_to_cpu(jh->j_last_flush_trans_id) > 0) {
-    last_flush_start = reiserfs_get_journal_block(p_s_sb) + 
+    last_flush_start = SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
                        le32_to_cpu(jh->j_first_unflushed_offset) ;
     last_flush_trans_id = le32_to_cpu(jh->j_last_flush_trans_id) ;
     reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1153: found in "
@@ -1638,7 +1647,7 @@
     ** there is nothing more we can do, and it makes no sense to read 
     ** through the whole log.
     */
-    d_bh = sb_bread(p_s_sb, reiserfs_get_journal_block(p_s_sb) + le32_to_cpu(jh->j_first_unflushed_offset)) ;
+    d_bh = bread(SB_JOURNAL_DEV(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + le32_to_cpu(jh->j_first_unflushed_offset), p_s_sb->s_blocksize) ;
     ret = journal_transaction_is_valid(p_s_sb, d_bh, NULL, NULL) ;
     if (!ret) {
       continue_replay = 0 ;
@@ -1657,8 +1666,8 @@
   /* ok, there are transactions that need to be replayed.  start with the first log block, find
   ** all the valid transactions, and pick out the oldest.
   */
-  while(continue_replay && cur_dblock < (reiserfs_get_journal_block(p_s_sb) + JOURNAL_BLOCK_COUNT)) {
-    d_bh = sb_bread(p_s_sb, cur_dblock) ;
+  while(continue_replay && cur_dblock < (SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_ONDISK_JOURNAL_SIZE(p_s_sb))) {
+    d_bh = bread(SB_JOURNAL_DEV(p_s_sb), cur_dblock, p_s_sb->s_blocksize) ;
     ret = journal_transaction_is_valid(p_s_sb, d_bh, &oldest_invalid_trans_id, &newest_mount_id) ;
     if (ret == 1) {
       desc = (struct reiserfs_journal_desc *)d_bh->b_data ;
@@ -1668,7 +1677,7 @@
 	newest_mount_id = le32_to_cpu(desc->j_mount_id) ;
 	reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1179: Setting "
 	               "oldest_start to offset %lu, trans_id %lu\n", 
-		       oldest_start - reiserfs_get_journal_block(p_s_sb), 
+		       oldest_start - SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb), 
 		       oldest_trans_id) ;
       } else if (oldest_trans_id > le32_to_cpu(desc->j_trans_id)) { 
         /* one we just read was older */
@@ -1676,7 +1685,7 @@
 	oldest_start = d_bh->b_blocknr ;
 	reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1180: Resetting "
 	               "oldest_start to offset %lu, trans_id %lu\n", 
-			oldest_start - reiserfs_get_journal_block(p_s_sb), 
+			oldest_start - SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb), 
 			oldest_trans_id) ;
       }
       if (newest_mount_id < le32_to_cpu(desc->j_mount_id)) {
@@ -1700,7 +1709,7 @@
   if (oldest_trans_id)  {
     reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1206: Starting replay "
                    "from offset %lu, trans_id %lu\n", 
-		   cur_dblock - reiserfs_get_journal_block(p_s_sb), 
+		   cur_dblock - SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb), 
 		   oldest_trans_id) ;
 
   }
@@ -1712,7 +1721,7 @@
     } else if (ret != 0) {
       break ;
     }
-    cur_dblock = reiserfs_get_journal_block(p_s_sb) + SB_JOURNAL(p_s_sb)->j_start ;
+    cur_dblock = SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_JOURNAL(p_s_sb)->j_start ;
     replay_count++ ;
   }
 
@@ -1859,11 +1868,106 @@
   }
 }
 
+static int release_journal_dev( struct super_block *super,
+				struct reiserfs_journal *journal )
+{
+    int result;
+    
+    result = 0;
+	
+    if( journal -> j_dev_bd != NULL ) {
+	result = blkdev_put( journal -> j_dev_bd, BDEV_FS );
+	journal -> j_dev_bd = NULL;
+    }
+    if( journal -> j_dev_file != NULL ) {
+	result = filp_close( journal -> j_dev_file, NULL );
+	journal -> j_dev_file = NULL;
+    }
+    if( result != 0 ) {
+	reiserfs_warning("release_journal_dev: Cannot release journal device: %i", result );
+    }
+    return result;
+}
+
+static int journal_init_dev( struct super_block *super, 
+			     struct reiserfs_journal *journal, 
+			     const char *jdev_name )
+{
+	int result;
+	kdev_t jdev;
+
+	result = 0;
+
+	journal -> j_dev_bd = NULL;
+	journal -> j_dev_file = NULL;
+	jdev = SB_JOURNAL_DEV( super ) = 
+      		SB_ONDISK_JOURNAL_DEVICE( super ) ?
+		to_kdev_t(SB_ONDISK_JOURNAL_DEVICE( super )) : super -> s_dev;	
+	/* there is no "jdev" option and journal is on separate device */
+	if( ( !jdev_name || !jdev_name[ 0 ] ) && 
+	    SB_ONDISK_JOURNAL_DEVICE( super ) ) {
+		journal -> j_dev_bd = bdget( kdev_t_to_nr( jdev ) );
+		if( journal -> j_dev_bd )
+			result = blkdev_get( journal -> j_dev_bd, 
+					     FMODE_READ | FMODE_WRITE, 0, 
+					     BDEV_FS );
+		else
+			result = -ENOMEM;
+		if( result != 0 )
+			printk( "journal_init_dev: cannot init journal device\n '%s': %i", 
+				kdevname( jdev ), result );
+
+		return result;
+	}
+
+	/* no "jdev" option and journal is on the host device */
+	if( !jdev_name || !jdev_name[ 0 ] )
+		return 0;
+	journal -> j_dev_file = filp_open( jdev_name, 0, 0 );
+	if( !IS_ERR( journal -> j_dev_file ) ) {
+		struct inode *jdev_inode;
+
+		jdev_inode = journal -> j_dev_file -> f_dentry -> d_inode;
+		journal -> j_dev_bd = jdev_inode -> i_bdev;
+		if( !S_ISBLK( jdev_inode -> i_mode ) ) {
+			printk( "journal_init_dev: '%s' is not a block device", jdev_name );
+			result = -ENOTBLK;
+		} else if( journal -> j_dev_file -> f_vfsmnt -> mnt_flags & MNT_NODEV) {
+			printk( "journal_init_dev: Cannot use devices on '%s'", jdev_name );
+			result = -EACCES;
+		} else if( jdev_inode -> i_bdev == NULL ) {
+			printk( "journal_init_dev: bdev unintialized for '%s'", jdev_name );
+			result = -ENOMEM;
+		} else if( ( result = blkdev_get( jdev_inode -> i_bdev, 
+						  FMODE_READ | FMODE_WRITE,
+						  0, BDEV_FS ) ) != 0 ) {
+			printk( "journal_init_dev: Cannot load device '%s': %i", jdev_name,
+			     result );
+		} else
+			/* ok */
+			SB_JOURNAL_DEV( super ) = 
+				to_kdev_t( jdev_inode -> i_bdev -> bd_dev );
+	} else {
+		result = PTR_ERR( journal -> j_dev_file );
+		journal -> j_dev_file = NULL;
+		printk( "journal_init_dev: Cannot open '%s': %i", jdev_name, result );
+	}
+	if( result != 0 ) {
+		release_journal_dev( super, journal );
+	}
+	printk( "journal_init_dev: journal device: %s", kdevname( SB_JOURNAL_DEV( super ) ) );
+	return result;
+}
+
 /*
 ** must be called once on fs mount.  calls journal_read for you
 */
-int journal_init(struct super_block *p_s_sb) {
-  int num_cnodes = JOURNAL_BLOCK_COUNT * 2 ;
+int journal_init(struct super_block *p_s_sb, const char * j_dev_name, int old_format) {
+    int num_cnodes = SB_ONDISK_JOURNAL_SIZE(p_s_sb) * 2 ;
+    struct buffer_head *bhjh;
+    struct reiserfs_super_block * rs;
+    struct reiserfs_journal_header *jh;
+    struct reiserfs_journal *journal;
 
   if (sizeof(struct reiserfs_journal_commit) != 4096 ||
       sizeof(struct reiserfs_journal_desc) != 4096
@@ -1872,19 +1976,104 @@
         sizeof(struct reiserfs_journal_desc)) ;
     return 1 ;
   }
-  /* sanity check to make sure they don't overflow the journal */
-  if (JOURNAL_BLOCK_COUNT > reiserfs_get_journal_orig_size(p_s_sb)) {
-    printk("journal-1393: current JOURNAL_BLOCK_COUNT (%d) is too big.  This FS was created with a journal size of %lu blocks\n",
-            JOURNAL_BLOCK_COUNT, reiserfs_get_journal_orig_size(p_s_sb)) ;
+
+    journal = SB_JOURNAL(p_s_sb) = vmalloc(sizeof (struct reiserfs_journal)) ;
+    if (!journal) {
+	printk("journal-1256: unable to get memory for journal structure\n") ;
     return 1 ;
   }
-  SB_JOURNAL(p_s_sb) = vmalloc(sizeof (struct reiserfs_journal)) ;
+    memset(journal, 0, sizeof(struct reiserfs_journal)) ;
 
-  if (!SB_JOURNAL(p_s_sb)) {
-    printk("journal-1256: unable to get memory for journal structure\n") ;
+    /* reserved for journal area support */
+    SB_JOURNAL_1st_RESERVED_BLOCK(p_s_sb) = (old_format ?
+					     REISERFS_OLD_DISK_OFFSET_IN_BYTES / p_s_sb->s_blocksize +
+					     SB_BMAP_NR(p_s_sb) + 1 :
+					     REISERFS_DISK_OFFSET_IN_BYTES / p_s_sb->s_blocksize + 2); 
+    
+    if( journal_init_dev( p_s_sb, journal, j_dev_name ) != 0 ) {
+      printk( "journal-1259: unable to initialize jornal device\n");
+      return 1;
+    }
+
+     rs = SB_DISK_SUPER_BLOCK(p_s_sb);
+     
+     /* read journal header */
+     bhjh = bread (SB_JOURNAL_DEV(p_s_sb),
+		   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_ONDISK_JOURNAL_SIZE(p_s_sb),
+		   SB_BLOCKSIZE(p_s_sb));
+     if (!bhjh) {
+	 printk("journal-1250: unable to read  journal header\n") ;
+	 return 1 ;
+     }
+     jh = (struct reiserfs_journal_header *)(bhjh->b_data);
+     
+     /* make sure that journal matches to the super block */
+     if (is_reiserfs_jr(rs) && (jh->jh_journal.jp_journal_magic != sb_jp_journal_magic(rs))) {
+	 char jname[ 32 ];
+	 char fname[ 32 ];
+	 
+	 strcpy( jname, kdevname( SB_JOURNAL_DEV(p_s_sb) ) );
+	 strcpy( fname, kdevname( p_s_sb->s_dev ) );
+	 printk("journal-460: journal header magic %x (device %s) does not match "
+		"to magic found in super block %x (device %s)\n",
+		jh->jh_journal.jp_journal_magic, jname,
+		sb_jp_journal_magic(rs), fname);
+	 brelse (bhjh);
     return 1 ;
   }
-  memset(SB_JOURNAL(p_s_sb), 0, sizeof(struct reiserfs_journal)) ;
+     
+  SB_JOURNAL_TRANS_MAX(p_s_sb)      = le32_to_cpu (jh->jh_journal.jp_journal_trans_max);
+  SB_JOURNAL_MAX_BATCH(p_s_sb)      = le32_to_cpu (jh->jh_journal.jp_journal_max_batch);
+  SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb) = le32_to_cpu (jh->jh_journal.jp_journal_max_commit_age);
+  SB_JOURNAL_MAX_TRANS_AGE(p_s_sb)  = JOURNAL_MAX_TRANS_AGE;
+
+  if (SB_JOURNAL_TRANS_MAX(p_s_sb)) {
+    /* make sure these parameters are available, assign it if they are not */
+    __u32 initial = SB_JOURNAL_TRANS_MAX(p_s_sb);
+    __u32 ratio = 1;
+    
+    if (p_s_sb->s_blocksize < 4096)
+      ratio = 4096 / p_s_sb->s_blocksize;
+    
+    if (SB_ONDISK_JOURNAL_SIZE(p_s_sb)/SB_JOURNAL_TRANS_MAX(p_s_sb) < JOURNAL_MIN_RATIO)
+      SB_JOURNAL_TRANS_MAX(p_s_sb) = SB_ONDISK_JOURNAL_SIZE(p_s_sb) / JOURNAL_MIN_RATIO;
+    if (SB_JOURNAL_TRANS_MAX(p_s_sb) > JOURNAL_TRANS_MAX_DEFAULT / ratio)
+      SB_JOURNAL_TRANS_MAX(p_s_sb) = JOURNAL_TRANS_MAX_DEFAULT / ratio;
+    if (SB_JOURNAL_TRANS_MAX(p_s_sb) < JOURNAL_TRANS_MIN_DEFAULT / ratio)
+      SB_JOURNAL_TRANS_MAX(p_s_sb) = JOURNAL_TRANS_MIN_DEFAULT / ratio;
+    
+    if (SB_JOURNAL_TRANS_MAX(p_s_sb) != initial)
+      printk ("reiserfs warning: wrong transaction max size (%u). Changed to %u\n",
+	      initial, SB_JOURNAL_TRANS_MAX(p_s_sb));
+
+    SB_JOURNAL_MAX_BATCH(p_s_sb) = SB_JOURNAL_TRANS_MAX(p_s_sb)*
+      JOURNAL_MAX_BATCH_DEFAULT/JOURNAL_TRANS_MAX_DEFAULT;
+  }  
+  
+  if (!SB_JOURNAL_TRANS_MAX(p_s_sb)) {
+    /*we have the file system was created by old version of mkreiserfs 
+      so this field contains zero value */
+    SB_JOURNAL_TRANS_MAX(p_s_sb)      = JOURNAL_TRANS_MAX_DEFAULT ;
+    SB_JOURNAL_MAX_BATCH(p_s_sb)      = JOURNAL_MAX_BATCH_DEFAULT ;  
+    SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb) = JOURNAL_MAX_COMMIT_AGE ;
+    
+    /* for blocksize >= 4096 - max transaction size is 1024. For block size < 4096
+       trans max size is decreased proportionally */
+    if (p_s_sb->s_blocksize < 4096) {
+      SB_JOURNAL_TRANS_MAX(p_s_sb) /= (4096 / p_s_sb->s_blocksize) ;
+      SB_JOURNAL_MAX_BATCH(p_s_sb) = (SB_JOURNAL_TRANS_MAX(p_s_sb)) * 9 / 10 ;
+    }
+  }
+  printk ("Journal params: device %s, size %u, journal first block %u, max trans len %u, max batch %u, "
+	  "max commit age %u, max trans age %u\n",
+	  kdevname( SB_JOURNAL_DEV(p_s_sb) ), SB_ONDISK_JOURNAL_SIZE(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb),
+	  SB_JOURNAL_TRANS_MAX(p_s_sb),
+	  SB_JOURNAL_MAX_BATCH(p_s_sb),
+	  SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb),
+	  SB_JOURNAL_MAX_TRANS_AGE(p_s_sb));
+
+  brelse (bhjh);
+     
 
   SB_JOURNAL(p_s_sb)->j_list_bitmap_index = 0 ;
   SB_JOURNAL_LIST_INDEX(p_s_sb) = -10000 ; /* make sure flush_old_commits does not try to flush a list while replay is on */
@@ -1948,6 +2137,7 @@
                   CLONE_FS | CLONE_FILES | CLONE_VM) ;
   }
   return 0 ;
+
 }
 
 /*
@@ -1960,10 +2150,10 @@
   if (reiserfs_dont_log(th->t_super)) 
     return 0 ;
   if ( SB_JOURNAL(th->t_super)->j_must_wait > 0 ||
-       (SB_JOURNAL(th->t_super)->j_len_alloc + new_alloc) >= JOURNAL_MAX_BATCH || 
+       (SB_JOURNAL(th->t_super)->j_len_alloc + new_alloc) >= SB_JOURNAL_MAX_BATCH(th->t_super) || 
        atomic_read(&(SB_JOURNAL(th->t_super)->j_jlock)) ||
-      (now - SB_JOURNAL(th->t_super)->j_trans_start_time) > JOURNAL_MAX_TRANS_AGE ||
-       SB_JOURNAL(th->t_super)->j_cnode_free < (JOURNAL_TRANS_MAX * 3)) { 
+      (now - SB_JOURNAL(th->t_super)->j_trans_start_time) > SB_JOURNAL_MAX_TRANS_AGE(th->t_super) ||
+       SB_JOURNAL(th->t_super)->j_cnode_free < (SB_JOURNAL_TRANS_MAX(th->t_super) * 3)) { 
     return 1 ;
   }
   return 0 ;
@@ -2030,13 +2220,12 @@
   ** we don't sleep if there aren't other writers
   */
 
-
   if (  (!join && SB_JOURNAL(p_s_sb)->j_must_wait > 0) ||
-     ( !join && (SB_JOURNAL(p_s_sb)->j_len_alloc + nblocks + 2) >= JOURNAL_MAX_BATCH) || 
+     ( !join && (SB_JOURNAL(p_s_sb)->j_len_alloc + nblocks + 2) >= SB_JOURNAL_MAX_BATCH(p_s_sb)) || 
      (!join && atomic_read(&(SB_JOURNAL(p_s_sb)->j_wcount)) > 0 && SB_JOURNAL(p_s_sb)->j_trans_start_time > 0 && 
-      (now - SB_JOURNAL(p_s_sb)->j_trans_start_time) > JOURNAL_MAX_TRANS_AGE) ||
+      (now - SB_JOURNAL(p_s_sb)->j_trans_start_time) > SB_JOURNAL_MAX_TRANS_AGE(p_s_sb)) ||
      (!join && atomic_read(&(SB_JOURNAL(p_s_sb)->j_jlock)) ) ||
-     (!join && SB_JOURNAL(p_s_sb)->j_cnode_free < (JOURNAL_TRANS_MAX * 3))) {
+     (!join && SB_JOURNAL(p_s_sb)->j_cnode_free < (SB_JOURNAL_TRANS_MAX(p_s_sb) * 3))) {
 
     unlock_journal(p_s_sb) ; /* allow others to finish this transaction */
 
@@ -2146,7 +2335,7 @@
   /* this error means I've screwed up, and we've overflowed the transaction.  
   ** Nothing can be done here, except make the FS readonly or panic.
   */ 
-  if (SB_JOURNAL(p_s_sb)->j_len >= JOURNAL_TRANS_MAX) { 
+  if (SB_JOURNAL(p_s_sb)->j_len >= SB_JOURNAL_TRANS_MAX(p_s_sb)) { 
     reiserfs_panic(th->t_super, "journal-1413: journal_mark_dirty: j_len (%lu) is too big\n", SB_JOURNAL(p_s_sb)->j_len) ;
   }
 
@@ -2396,7 +2585,7 @@
   /* starting with oldest, loop until we get to the start */
   i = (SB_JOURNAL_LIST_INDEX(p_s_sb) + 1) % JOURNAL_LIST_COUNT ;
   while(i != start) {
-    if (SB_JOURNAL_LIST(p_s_sb)[i].j_len > 0 && ((now - SB_JOURNAL_LIST(p_s_sb)[i].j_timestamp) > JOURNAL_MAX_COMMIT_AGE ||
+    if (SB_JOURNAL_LIST(p_s_sb)[i].j_len > 0 && ((now - SB_JOURNAL_LIST(p_s_sb)[i].j_timestamp) > SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb) ||
        immediate)) {
       /* we have to check again to be sure the current transaction did not change */
       if (i != SB_JOURNAL_LIST_INDEX(p_s_sb))  {
@@ -2412,7 +2601,7 @@
   if (!immediate && atomic_read(&(SB_JOURNAL(p_s_sb)->j_wcount)) <= 0 &&  
      SB_JOURNAL(p_s_sb)->j_trans_start_time > 0 && 
      SB_JOURNAL(p_s_sb)->j_len > 0 && 
-     (now - SB_JOURNAL(p_s_sb)->j_trans_start_time) > JOURNAL_MAX_TRANS_AGE) {
+     (now - SB_JOURNAL(p_s_sb)->j_trans_start_time) > SB_JOURNAL_MAX_TRANS_AGE(p_s_sb)) {
     journal_join(&th, p_s_sb, 1) ;
     reiserfs_prepare_for_journal(p_s_sb, SB_BUFFER_WITH_SB(p_s_sb), 1) ;
     journal_mark_dirty(&th, p_s_sb, SB_BUFFER_WITH_SB(p_s_sb)) ;
@@ -2504,21 +2693,21 @@
 
   /* deal with old transactions where we are the last writers */
   now = CURRENT_TIME ;
-  if ((now - SB_JOURNAL(p_s_sb)->j_trans_start_time) > JOURNAL_MAX_TRANS_AGE) {
+  if ((now - SB_JOURNAL(p_s_sb)->j_trans_start_time) > SB_JOURNAL_MAX_TRANS_AGE(p_s_sb)) {
     commit_now = 1 ;
     SB_JOURNAL(p_s_sb)->j_next_async_flush = 1 ;
   }
   /* don't batch when someone is waiting on j_join_wait */
   /* don't batch when syncing the commit or flushing the whole trans */
   if (!(SB_JOURNAL(p_s_sb)->j_must_wait > 0) && !(atomic_read(&(SB_JOURNAL(p_s_sb)->j_jlock))) && !flush && !commit_now && 
-      (SB_JOURNAL(p_s_sb)->j_len < JOURNAL_MAX_BATCH)  && 
-      SB_JOURNAL(p_s_sb)->j_len_alloc < JOURNAL_MAX_BATCH && SB_JOURNAL(p_s_sb)->j_cnode_free > (JOURNAL_TRANS_MAX * 3)) {
+      (SB_JOURNAL(p_s_sb)->j_len < SB_JOURNAL_MAX_BATCH(p_s_sb))  && 
+      SB_JOURNAL(p_s_sb)->j_len_alloc < SB_JOURNAL_MAX_BATCH(p_s_sb) && SB_JOURNAL(p_s_sb)->j_cnode_free > (SB_JOURNAL_TRANS_MAX(p_s_sb) * 3)) {
     SB_JOURNAL(p_s_sb)->j_bcount++ ;
     unlock_journal(p_s_sb) ;
     return 0 ;
   }
 
-  if (SB_JOURNAL(p_s_sb)->j_start > JOURNAL_BLOCK_COUNT) {
+  if (SB_JOURNAL(p_s_sb)->j_start > SB_ONDISK_JOURNAL_SIZE(p_s_sb)) {
     reiserfs_panic(p_s_sb, "journal-003: journal_end: j_start (%ld) is too high\n", SB_JOURNAL(p_s_sb)->j_start) ;
   }
   return 1 ;
@@ -2760,7 +2949,7 @@
   
   rs = SB_DISK_SUPER_BLOCK(p_s_sb) ;
   /* setup description block */
-  d_bh = sb_getblk(p_s_sb, reiserfs_get_journal_block(p_s_sb) + SB_JOURNAL(p_s_sb)->j_start) ; 
+  d_bh = getblk(SB_JOURNAL_DEV(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_JOURNAL(p_s_sb)->j_start, p_s_sb->s_blocksize) ; 
   mark_buffer_uptodate(d_bh, 1) ;
   desc = (struct reiserfs_journal_desc *)(d_bh)->b_data ;
   memset(desc, 0, sizeof(struct reiserfs_journal_desc)) ;
@@ -2768,8 +2957,9 @@
   desc->j_trans_id = cpu_to_le32(SB_JOURNAL(p_s_sb)->j_trans_id) ;
 
   /* setup commit block.  Don't write (keep it clean too) this one until after everyone else is written */
-  c_bh = sb_getblk(p_s_sb,  reiserfs_get_journal_block(p_s_sb) + 
-  				        ((SB_JOURNAL(p_s_sb)->j_start + SB_JOURNAL(p_s_sb)->j_len + 1) % JOURNAL_BLOCK_COUNT)) ;
+  c_bh =  getblk(SB_JOURNAL_DEV(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
+		 ((SB_JOURNAL(p_s_sb)->j_start + SB_JOURNAL(p_s_sb)->j_len + 1) % SB_ONDISK_JOURNAL_SIZE(p_s_sb)), 
+		 p_s_sb->s_blocksize) ;
   commit = (struct reiserfs_journal_commit *)c_bh->b_data ;
   memset(commit, 0, sizeof(struct reiserfs_journal_commit)) ;
   commit->j_trans_id = cpu_to_le32(SB_JOURNAL(p_s_sb)->j_trans_id) ;
@@ -2812,8 +3002,10 @@
         last_cn->next = jl_cn ;
       }
       last_cn = jl_cn ;
-      if (cn->bh->b_blocknr >= reiserfs_get_journal_block(p_s_sb) &&
-          cn->bh->b_blocknr < (reiserfs_get_journal_block(p_s_sb) + JOURNAL_BLOCK_COUNT)) {
+      /* make sure the block we are trying to log is not a block 
+         of journal or reserved area */
+
+      if (is_block_in_log_or_reserved_area(p_s_sb, cn->bh->b_blocknr)) {
         reiserfs_panic(p_s_sb, "journal-2332: Trying to log block %lu, which is a log block\n", cn->bh->b_blocknr) ;
       }
       jl_cn->blocknr = cn->bh->b_blocknr ; 
@@ -2857,8 +3049,9 @@
     /* copy all the real blocks into log area.  dirty log blocks */
     if (test_bit(BH_JDirty, &cn->bh->b_state)) {
       struct buffer_head *tmp_bh ;
-      tmp_bh = sb_getblk(p_s_sb, reiserfs_get_journal_block(p_s_sb) + 
-		     ((cur_write_start + jindex) % JOURNAL_BLOCK_COUNT)) ;
+      tmp_bh =  getblk(SB_JOURNAL_DEV(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
+		       ((cur_write_start + jindex) % SB_ONDISK_JOURNAL_SIZE(p_s_sb)), 
+		       p_s_sb->s_blocksize) ;
       mark_buffer_uptodate(tmp_bh, 1) ;
       memcpy(tmp_bh->b_data, cn->bh->b_data, cn->bh->b_size) ;  
       jindex++ ;
@@ -2919,7 +3112,7 @@
 
   /* reset journal values for the next transaction */
   old_start = SB_JOURNAL(p_s_sb)->j_start ;
-  SB_JOURNAL(p_s_sb)->j_start = (SB_JOURNAL(p_s_sb)->j_start + SB_JOURNAL(p_s_sb)->j_len + 2) % JOURNAL_BLOCK_COUNT;
+  SB_JOURNAL(p_s_sb)->j_start = (SB_JOURNAL(p_s_sb)->j_start + SB_JOURNAL(p_s_sb)->j_len + 2) % SB_ONDISK_JOURNAL_SIZE(p_s_sb);
   atomic_set(&(SB_JOURNAL(p_s_sb)->j_wcount), 0) ;
   SB_JOURNAL(p_s_sb)->j_bcount = 0 ;
   SB_JOURNAL(p_s_sb)->j_last = NULL ;
@@ -2940,12 +3133,12 @@
   for (i = 0 ; i < JOURNAL_LIST_COUNT ; i++) {
     jindex = i ;
     if (SB_JOURNAL_LIST(p_s_sb)[jindex].j_len > 0 && SB_JOURNAL(p_s_sb)->j_start <= SB_JOURNAL_LIST(p_s_sb)[jindex].j_start) {
-      if ((SB_JOURNAL(p_s_sb)->j_start + JOURNAL_TRANS_MAX + 1) >= SB_JOURNAL_LIST(p_s_sb)[jindex].j_start) {
+      if ((SB_JOURNAL(p_s_sb)->j_start + SB_JOURNAL_TRANS_MAX(p_s_sb) + 1) >= SB_JOURNAL_LIST(p_s_sb)[jindex].j_start) {
 	flush_journal_list(p_s_sb, SB_JOURNAL_LIST(p_s_sb) + jindex, 1) ; 
       }
     } else if (SB_JOURNAL_LIST(p_s_sb)[jindex].j_len > 0 && 
-              (SB_JOURNAL(p_s_sb)->j_start + JOURNAL_TRANS_MAX + 1) > JOURNAL_BLOCK_COUNT) {
-      if (((SB_JOURNAL(p_s_sb)->j_start + JOURNAL_TRANS_MAX + 1) % JOURNAL_BLOCK_COUNT) >= 
+              (SB_JOURNAL(p_s_sb)->j_start + SB_JOURNAL_TRANS_MAX(p_s_sb) + 1) > SB_ONDISK_JOURNAL_SIZE(p_s_sb)) {
+      if (((SB_JOURNAL(p_s_sb)->j_start + SB_JOURNAL_TRANS_MAX(p_s_sb) + 1) % SB_ONDISK_JOURNAL_SIZE(p_s_sb)) >= 
             SB_JOURNAL_LIST(p_s_sb)[jindex].j_start) {
 	flush_journal_list(p_s_sb, SB_JOURNAL_LIST(p_s_sb) + jindex, 1 ) ; 
       }
@@ -2953,7 +3146,7 @@
     /* this check should always be run, to send old lists to disk */
     if (SB_JOURNAL_LIST(p_s_sb)[jindex].j_len > 0 && 
               SB_JOURNAL_LIST(p_s_sb)[jindex].j_timestamp < 
-	      (CURRENT_TIME - (JOURNAL_MAX_TRANS_AGE * 4))) {
+	      (CURRENT_TIME - (SB_JOURNAL_MAX_TRANS_AGE(p_s_sb) * 4))) {
 	flush_journal_list(p_s_sb, SB_JOURNAL_LIST(p_s_sb) + jindex, 1 ) ; 
     }
   }
--- linux-2.5.3-pre4.o/fs/reiserfs/objectid.c	Sat Nov 10 01:18:25 2001
+++ linux-2.5.3-pre4/fs/reiserfs/objectid.c	Thu Jan 24 11:05:11 2002
@@ -5,9 +5,10 @@
 #include <linux/config.h>
 #include <linux/string.h>
 #include <linux/locks.h>
+#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/reiserfs_fs.h>
-
+#include <linux/reiserfs_fs_sb.h>
 
 // find where objectid map starts
 #define objectid_map(s,rs) (old_format_only (s) ? \
@@ -145,7 +146,7 @@
 	    }
 
             /* JDM comparing two little-endian values for equality -- safe */
-	if (rs->s_oid_cursize == rs->s_oid_maxsize) {
+	if (sb_oid_cursize(rs) == sb_oid_maxsize(rs)) {
 		/* objectid map must be expanded, but there is no space */
 		PROC_INFO_INC( s, leaked_oid );
 		return;
@@ -169,9 +170,9 @@
 
 int reiserfs_convert_objectid_map_v1(struct super_block *s) {
     struct reiserfs_super_block *disk_sb = SB_DISK_SUPER_BLOCK (s);
-    int cur_size = le16_to_cpu(disk_sb->s_oid_cursize) ;
+    int cur_size = sb_oid_cursize(disk_sb);
     int new_size = (s->s_blocksize - SB_SIZE) / sizeof(__u32) / 2 * 2 ;
-    int old_max = le16_to_cpu(disk_sb->s_oid_maxsize) ;
+    int old_max = sb_oid_maxsize(disk_sb);
     struct reiserfs_super_block_v1 *disk_sb_v1 ;
     __u32 *objectid_map, *new_objectid_map ;
     int i ;
@@ -185,7 +186,7 @@
 	** map 
 	*/
 	objectid_map[new_size - 1] = objectid_map[cur_size - 1] ;
-	disk_sb->s_oid_cursize = cpu_to_le16(new_size) ;
+	set_sb_oid_cursize(disk_sb,new_size) ;
     }
     /* move the smaller objectid map past the end of the new super */
     for (i = new_size - 1 ; i >= 0 ; i--) {
@@ -194,7 +195,11 @@
 
 
     /* set the max size so we don't overflow later */
-    disk_sb->s_oid_maxsize = cpu_to_le16(new_size) ;
+    set_sb_oid_maxsize(disk_sb,new_size) ;
+
+    /* Zero out label and generate random UUID */
+    memset(disk_sb->s_label, 0, sizeof(disk_sb->s_label)) ;
+    generate_random_uuid(disk_sb->s_uuid);
 
     /* finally, zero out the unused chunk of the new super */
     memset(disk_sb->s_unused, 0, sizeof(disk_sb->s_unused)) ;
--- linux-2.5.3-pre4.o/fs/reiserfs/prints.c	Fri Jan 18 15:01:36 2002
+++ linux-2.5.3-pre4/fs/reiserfs/prints.c	Thu Jan 24 10:47:15 2002
@@ -485,12 +485,13 @@
     char *version;
     
 
-    if (strncmp (rs->s_magic,  REISERFS_SUPER_MAGIC_STRING,
-                 strlen ( REISERFS_SUPER_MAGIC_STRING)) == 0) {
+    if (is_reiserfs_3_5(rs)) {
         version = "3.5";
-    } else if( strncmp (rs->s_magic,  REISER2FS_SUPER_MAGIC_STRING,
-                        strlen ( REISER2FS_SUPER_MAGIC_STRING)) == 0) {
+    } else if (is_reiserfs_3_6(rs)) {
         version = "3.6";
+    } else if (is_reiserfs_jr(rs)) {
+      version = ((sb_version(rs) == REISERFS_VERSION_2) ?
+ 		 "3.6" : "3.5");  
     } else {
 	return 1;
     }
@@ -505,27 +506,25 @@
     // someone stores reiserfs super block in some data block ;)
 //    skipped = (bh->b_blocknr * bh->b_size) / sb_blocksize(rs);
     skipped = bh->b_blocknr;
-    data_blocks = sb_block_count(rs) - skipped - 1 -
-                  sb_bmap_nr(rs) - (sb_orig_journal_size(rs) + 1) -
-                  sb_free_blocks(rs);
-    printk ("Busy blocks (skipped %d, bitmaps - %d, journal blocks - %d\n"
-	    "1 super blocks, %d data blocks\n", 
-	    skipped, sb_bmap_nr(rs), 
-	    (sb_orig_journal_size(rs) + 1), data_blocks);
+    data_blocks = sb_block_count(rs) - skipped - 1 - sb_bmap_nr(rs) -
+	    (!is_reiserfs_jr(rs) ? sb_jp_journal_size(rs) + 1 : sb_reserved_for_journal(rs)) -	    
+	    sb_free_blocks(rs);
+    printk ("Busy blocks (skipped %d, bitmaps - %d, journal (or reserved) blocks - %d\n"
+	    "1 super block, %d data blocks\n", 
+	    skipped, sb_bmap_nr(rs), (!is_reiserfs_jr(rs) ? (sb_jp_journal_size(rs) + 1) :
+				      sb_reserved_for_journal(rs)) , data_blocks);
     printk ("Root block %u\n", sb_root_block(rs));
-    printk ("Journal block (first) %d\n", sb_journal_block(rs));
-    printk ("Journal dev %d\n", sb_journal_dev(rs));
-    printk ("Journal orig size %d\n", sb_orig_journal_size(rs));
-    printk ("Filesystem state %s\n", 
-	    (sb_state(rs) == REISERFS_VALID_FS) ? "VALID" : "ERROR");
+    printk ("Journal block (first) %d\n", sb_jp_journal_1st_block(rs));
+    printk ("Journal dev %d\n", sb_jp_journal_dev(rs));
+    printk ("Journal orig size %d\n", sb_jp_journal_size(rs));
+    printk ("FS state %d\n", sb_fs_state(rs));
     printk ("Hash function \"%s\"\n",
             sb_hash_function_code(rs) == TEA_HASH ? "tea" :
 	    ( sb_hash_function_code(rs) == YURA_HASH ? "rupasov" : (sb_hash_function_code(rs) == R5_HASH ? "r5" : "unknown")));
-
+    
     printk ("Tree height %d\n", sb_tree_height(rs));
     return 0;
 }
-
 
 static int print_desc_block (struct buffer_head * bh)
 {
--- linux-2.5.3-pre4.o/fs/reiserfs/procfs.c	Thu Jan 24 11:07:46 2002
+++ linux-2.5.3-pre4/fs/reiserfs/procfs.c	Thu Jan 24 10:47:15 2002
@@ -96,15 +96,6 @@
 				     int count, int *eof, void *data )
 {
 	int len = 0;
-    
-	len += sprintf( &buffer[ len ], "%s [%s]\n", 
-			reiserfs_get_version_string(),
-#if defined( CONFIG_REISERFS_FS_MODULE )
-			"as module"
-#else
-			"built into kernel"
-#endif
-			);
 	return reiserfs_proc_tail( len, buffer, start, offset, count, eof );
 }
 
@@ -116,8 +107,8 @@
 
 #define D2C( x ) le16_to_cpu( x )
 #define D4C( x ) le32_to_cpu( x )
-#define DF( x ) D2C( rs -> x )
-#define DFL( x ) D4C( rs -> x )
+#define DF( x ) D2C( rs -> s_v1.x )
+#define DFL( x ) D4C( rs -> s_v1.x )
 
 #define objectid_map( s, rs ) (old_format_only (s) ?				\
                          (__u32 *)((struct reiserfs_super_block_v1 *)rs + 1) :	\
@@ -125,6 +116,8 @@
 #define MAP( i ) D4C( objectid_map( sb, rs )[ i ] )
 
 #define DJF( x ) le32_to_cpu( rs -> x )
+#define DJV( x ) le32_to_cpu( s_v1 -> x )
+#define DJP( x ) le32_to_cpu( jp -> x ) 
 #define JF( x ) ( r -> s_journal -> x )
 
 int reiserfs_super_in_proc( char *buffer, char **start, off_t offset,
@@ -348,12 +341,14 @@
 			"blocksize: \t%i\n"
 			"oid_maxsize: \t%i\n"
 			"oid_cursize: \t%i\n"
-			"state: \t%i\n"
-			"magic: \t%12.12s\n"
+			"umount_state: \t%i\n"
+			"magic: \t%10.10s\n"
+			"fs_state: \t%i\n"
 			"hash: \t%s\n"
 			"tree_height: \t%i\n"
 			"bmap_nr: \t%i\n"
-			"version: \t%i\n",
+			"version: \t%i\n"
+			"reserved_for_journal: \t%i\n",
 
 			DFL( s_block_count ),
 			DFL( s_free_blocks ),
@@ -361,15 +356,17 @@
 			DF( s_blocksize ),
 			DF( s_oid_maxsize ),
 			DF( s_oid_cursize ),
-			DF( s_state ),
-			rs -> s_magic,
+			DF( s_umount_state ),
+			rs -> s_v1.s_magic,
+			DF( s_fs_state ),
 			hash_code == TEA_HASH ? "tea" :
 			( hash_code == YURA_HASH ) ? "rupasov" :
 			( hash_code == R5_HASH ) ? "r5" :
 			( hash_code == UNSET_HASH ) ? "unset" : "unknown",
 			DF( s_tree_height ),
 			DF( s_bmap_nr ),
-			DF( s_version ) );
+			DF( s_version ),
+			DF (s_reserved_for_journal));
 
 	procinfo_epilogue( sb );
 	return reiserfs_proc_tail( len, buffer, start, offset, count, eof );
@@ -392,7 +389,7 @@
 		return -ENOENT;
 	sb_info = &sb->u.reiserfs_sb;
 	rs = sb_info -> s_rs;
-	mapsize = le16_to_cpu( rs -> s_oid_cursize );
+	mapsize = le16_to_cpu( rs -> s_v1.s_oid_cursize );
 	total_used = 0;
 
 	for( i = 0 ; i < mapsize ; ++i ) {
@@ -423,7 +420,7 @@
 	}
 	len += sprintf( &buffer[ len ], "total: \t%i [%i/%i] used: %lu [%s]\n", 
 			i, 
-			mapsize, le16_to_cpu( rs -> s_oid_maxsize ),
+			mapsize, le16_to_cpu( rs -> s_v1.s_oid_maxsize ),
 			total_used, exact ? "exact" : "estimation" );
 
 	procinfo_epilogue( sb );
@@ -436,6 +433,7 @@
 	struct super_block *sb;
 	struct reiserfs_sb_info *r;
 	struct reiserfs_super_block *rs;
+	struct journal_params *jp;	
 	int len = 0;
     
 	sb = procinfo_prologue( to_kdev_t((int)data) );
@@ -443,18 +441,20 @@
 		return -ENOENT;
 	r = &sb->u.reiserfs_sb;
 	rs = r -> s_rs;
+	jp = &rs->s_v1.s_journal;
 
 	len += sprintf( &buffer[ len ], 
 			/* on-disk fields */
-			"s_journal_block: \t%i\n"
-			"s_journal_dev: \t%s[%x]\n"
-			"s_orig_journal_size: \t%i\n"
-			"s_journal_trans_max: \t%i\n"
-			"s_journal_block_count: \t%i\n"
-			"s_journal_max_batch: \t%i\n"
-			"s_journal_max_commit_age: \t%i\n"
-			"s_journal_max_trans_age: \t%i\n"
+ 			"jp_journal_1st_block: \t%i\n"
+ 			"jp_journal_dev: \t%s[%x]\n"
+ 			"jp_journal_size: \t%i\n"
+ 			"jp_journal_trans_max: \t%i\n"
+ 			"jp_journal_magic: \t%i\n"
+ 			"jp_journal_max_batch: \t%i\n"
+ 			"jp_journal_max_commit_age: \t%i\n"
+ 			"jp_journal_max_trans_age: \t%i\n"
 			/* incore fields */
+			"j_1st_reserved_block: \t%i\n"	  
 			"j_state: \t%i\n"			
 			"j_trans_id: \t%lu\n"
 			"j_mount_id: \t%lu\n"
@@ -490,16 +490,17 @@
 			"prepare: \t%12lu\n"
 			"prepare_retry: \t%12lu\n",
 
-			DJF( s_journal_block ),
-			DJF( s_journal_dev ) == 0 ? "none" : bdevname( to_kdev_t( DJF( s_journal_dev ) ) ),
-			DJF( s_journal_dev ),
-			DJF( s_orig_journal_size ),
-			DJF( s_journal_trans_max ),
-			DJF( s_journal_block_count ),
-			DJF( s_journal_max_batch ),
-			DJF( s_journal_max_commit_age ),
-			DJF( s_journal_max_trans_age ),
-			
+                        DJP( jp_journal_1st_block ),
+                        DJP( jp_journal_dev ) == 0 ? "none" : bdevname(to_kdev_t(DJP( jp_journal_dev ))),
+                        DJP( jp_journal_dev ),
+                        DJP( jp_journal_size ),
+                        DJP( jp_journal_trans_max ),
+                        DJP( jp_journal_magic ),
+                        DJP( jp_journal_max_batch ),
+                        DJP( jp_journal_max_commit_age ),
+                        DJP( jp_journal_max_trans_age ),
+
+			JF( j_1st_reserved_block ),			
 			JF( j_state ),			
 			JF( j_trans_id ),
 			JF( j_mount_id ),
--- linux-2.5.3-pre4.o/fs/reiserfs/resize.c	Fri Jan 18 15:01:36 2002
+++ linux-2.5.3-pre4/fs/reiserfs/resize.c	Thu Jan 24 10:47:15 2002
@@ -112,7 +112,7 @@
 		bitmap[i] = SB_AP_BITMAP(s)[i];
 	    for (i = bmap_nr; i < bmap_nr_new; i++) {
 		bitmap[i] = reiserfs_getblk(s, i * s->s_blocksize * 8);
-		memset(bitmap[i]->b_data, 0, sb->s_blocksize);
+		memset(bitmap[i]->b_data, 0, sb_blocksize(sb));
 		reiserfs_test_and_set_le_bit(0, bitmap[i]->b_data);
 
 		mark_buffer_dirty(bitmap[i]) ;
--- linux-2.5.3-pre4.o/fs/reiserfs/super.c	Thu Jan 24 10:45:26 2002
+++ linux-2.5.3-pre4/fs/reiserfs/super.c	Thu Jan 24 11:03:57 2002
@@ -24,8 +24,36 @@
 #define REISERFS_OLD_BLOCKSIZE 4096
 #define REISERFS_SUPER_MAGIC_STRING_OFFSET_NJ 20
 
-char reiserfs_super_magic_string[] = REISERFS_SUPER_MAGIC_STRING;
-char reiser2fs_super_magic_string[] = REISER2FS_SUPER_MAGIC_STRING;
+const char reiserfs_3_5_magic_string[] = REISERFS_SUPER_MAGIC_STRING;
+const char reiserfs_3_6_magic_string[] = REISER2FS_SUPER_MAGIC_STRING;
+const char reiserfs_jr_magic_string[] = REISER2FS_JR_SUPER_MAGIC_STRING;
+
+int is_reiserfs_3_5 (struct reiserfs_super_block * rs)
+{
+  return !strncmp (rs->s_v1.s_magic, reiserfs_3_5_magic_string,
+		   strlen (reiserfs_3_5_magic_string));
+}
+
+
+int is_reiserfs_3_6 (struct reiserfs_super_block * rs)
+{
+  return !strncmp (rs->s_v1.s_magic, reiserfs_3_6_magic_string,
+ 		   strlen (reiserfs_3_6_magic_string));
+}
+
+
+int is_reiserfs_jr (struct reiserfs_super_block * rs)
+{
+  return !strncmp (rs->s_v1.s_magic, reiserfs_jr_magic_string,
+ 		   strlen (reiserfs_jr_magic_string));
+}
+
+
+static int is_any_reiserfs_magic_string (struct reiserfs_super_block * rs)
+{
+  return (is_reiserfs_3_5 (rs) || is_reiserfs_3_6 (rs) ||
+	  is_reiserfs_jr (rs));
+}
 
 //
 // a portion of this function, particularly the VFS interface portion,
@@ -90,7 +118,7 @@
   if (!(s->s_flags & MS_RDONLY)) {
     journal_begin(&th, s, 10) ;
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
-    set_sb_state( SB_DISK_SUPER_BLOCK(s), s->u.reiserfs_sb.s_mount_state );
+    set_sb_umount_state( SB_DISK_SUPER_BLOCK(s), s->u.reiserfs_sb.s_mount_state );
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
   }
 
@@ -190,7 +218,7 @@
 };
 
 /* this was (ext2)parse_options */
-static int parse_options (char * options, unsigned long * mount_options, unsigned long * blocks)
+static int parse_options (char * options, unsigned long * mount_options, unsigned long * blocks, char **jdev_name)
 {
     char * this_char;
     char * value;
@@ -257,6 +285,13 @@
 	  	printk("reiserfs: hash option requires a value\n");
 		return 0 ;
 	    }
+	} else if (!strcmp (this_char, "jdev")) {
+	    if (value && *value && jdev_name) {
+		    *jdev_name = value;
+	    } else {
+		    printk("reiserfs: jdev option requires a value\n");
+		    return 0 ;
+	    }
 	} else {
 	    printk ("reiserfs: Unrecognized mount option %s\n", this_char);
 	    return 0;
@@ -286,8 +321,7 @@
   unsigned long mount_options;
 
   rs = SB_DISK_SUPER_BLOCK (s);
-
-  if (!parse_options(data, &mount_options, &blocks))
+  if (!parse_options(data, &mount_options, &blocks, NULL))
   	return 0;
 
   if(blocks) {
@@ -303,26 +337,26 @@
   
   if (*flags & MS_RDONLY) {
     /* try to remount file system with read-only permissions */
-    if (sb_state(rs) == REISERFS_VALID_FS || s->u.reiserfs_sb.s_mount_state != REISERFS_VALID_FS) {
+    if (sb_umount_state(rs) == REISERFS_VALID_FS || s->u.reiserfs_sb.s_mount_state != REISERFS_VALID_FS) {
       return 0;
     }
 
     journal_begin(&th, s, 10) ;
     /* Mounting a rw partition read-only. */
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
-    set_sb_state( rs, s->u.reiserfs_sb.s_mount_state );
+    set_sb_umount_state( rs, s->u.reiserfs_sb.s_mount_state );
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     s->s_dirt = 0;
   } else {
-    s->u.reiserfs_sb.s_mount_state = sb_state(rs) ;
+    s->u.reiserfs_sb.s_mount_state = sb_umount_state(rs) ;
     s->s_flags &= ~MS_RDONLY ; /* now it is safe to call journal_begin */
     journal_begin(&th, s, 10) ;
 
     /* Mount a partition which is read-only, read-write */
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
-    s->u.reiserfs_sb.s_mount_state = sb_state(rs);
+    s->u.reiserfs_sb.s_mount_state = sb_umount_state(rs);
     s->s_flags &= ~MS_RDONLY;
-    set_sb_state( rs, REISERFS_ERROR_FS );
+    set_sb_umount_state( rs, REISERFS_ERROR_FS );
     /* mark_buffer_dirty (SB_BUFFER_WITH_SB (s), 1); */
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     s->s_dirt = 0;
@@ -411,15 +445,15 @@
     bh = sb_bread (s, offset / s->s_blocksize);
     if (!bh) {
       printk ("read_super_block: "
-              "bread failed (dev %s, block %ld, size %ld)\n",
+              "bread failed (dev %s, block %lu, size %lu)\n",
               s->s_id, offset / s->s_blocksize, s->s_blocksize);
       return 1;
     }
  
     rs = (struct reiserfs_super_block *)bh->b_data;
-    if (!is_reiserfs_magic_string (rs)) {
+    if (!is_any_reiserfs_magic_string (rs)) {
       printk ("read_super_block: "
-              "can't find a reiserfs filesystem on (dev %s, block %lu, size %ld)\n",
+              "can't find a reiserfs filesystem on (dev %s, block %lu, size %lu)\n",
               s->s_id, bh->b_blocknr, s->s_blocksize);
       brelse (bh);
       return 1;
@@ -435,35 +469,43 @@
     bh = reiserfs_bread (s, offset / s->s_blocksize);
     if (!bh) {
 	printk("read_super_block: "
-                "bread failed (dev %s, block %ld, size %ld)\n",
+                "bread failed (dev %s, block %lu, size %lu)\n",
                 s->s_id, offset / s->s_blocksize, s->s_blocksize);
 	return 1;
     }
     
     rs = (struct reiserfs_super_block *)bh->b_data;
-    if (!is_reiserfs_magic_string (rs) || sb_blocksize(rs) != s->s_blocksize) {
+    if (!is_any_reiserfs_magic_string (rs) || sb_blocksize(rs) != s->s_blocksize) {
 	printk ("read_super_block: "
-		"can't find a reiserfs filesystem on (dev %s, block %lu, size %ld)\n",
+		"can't find a reiserfs filesystem on (dev %s, block %lu, size %lu)\n",
 		s->s_id, bh->b_blocknr, s->s_blocksize);
 	brelse (bh);
 	printk ("read_super_block: can't find a reiserfs filesystem on dev %s.\n", s->s_id);
 	return 1;
     }
-    /* must check to be sure we haven't pulled an old format super out
-    ** of the old format's log.  This is a kludge of a check, but it
-    ** will work.  If block we've just read in is inside the
-    ** journal for that super, it can't be valid.  
-    */
-    if (bh->b_blocknr >= sb_journal_block(rs) && 
-	bh->b_blocknr < (sb_journal_block(rs) + JOURNAL_BLOCK_COUNT)) {
-	brelse(bh) ;
-	printk("super-459: read_super_block: "
-	       "super found at block %lu is within its own log. "
-	       "It must not be of this format type.\n", bh->b_blocknr) ;
-	return 1 ;
-    }
+
     SB_BUFFER_WITH_SB (s) = bh;
     SB_DISK_SUPER_BLOCK (s) = rs;
+
+    if (is_reiserfs_jr (rs)) {
+	/* magic is of non-standard journal filesystem, look at s_version to
+	   find which format is in use */
+	if (sb_version(rs) == REISERFS_VERSION_2)
+	    printk ("reiserfs: found format \"3.6\" with non-standard journal\n");
+	else if (sb_version(rs) == REISERFS_VERSION_1)
+	    printk ("reiserfs: found format \"3.5\" with non-standard journal\n");
+	else {
+	    printk ("read_super_block: found unknown format \"%u\" "
+	            "with non-standard magic\n", sb_version(rs));
+	return 1;
+	}
+    }
+    else
+	/* s_version may contain incorrect information. Look at the magic
+	   string */
+	    printk ("reiserfs: found format \"%s\" with standard journal\n",
+	            is_reiserfs_3_5 (rs) ? "3.5" : "3.6");
+
     s->s_op = &reiserfs_sops;
 
     /* new format is limited by the 32 bit wide i_blocks field, want to
@@ -658,11 +700,11 @@
     unsigned long blocks;
     int jinit_done = 0 ;
     struct reiserfs_iget4_args args ;
-
+    char *jdev_name;
 
     memset (&s->u.reiserfs_sb, 0, sizeof (struct reiserfs_sb_info));
-
-    if (parse_options ((char *) data, &(s->u.reiserfs_sb.s_mount_opt), &blocks) == 0) {
+    jdev_name = NULL;
+    if (parse_options ((char *) data, &(s->u.reiserfs_sb.s_mount_opt), &blocks, &jdev_name) == 0) {
 	return NULL;
     }
 
@@ -673,17 +715,14 @@
 
     size = block_size(s->s_dev);
     sb_set_blocksize(s, size);
-
-    /* read block (64-th 1k block), which can contain reiserfs super block */
-    if (read_super_block (s, REISERFS_DISK_OFFSET_IN_BYTES)) {
-	// try old format (undistributed bitmap, super block in 8-th 1k block of a device)
-	sb_set_blocksize(s, size);
-	if (read_super_block (s, REISERFS_OLD_DISK_OFFSET_IN_BYTES)) 
-	    goto error;
-	else
-	    old_format = 1;
-    }
-
+    
+    /* try old format (undistributed bitmap, super block in 8-th 1k block of a device) */
+    if (!read_super_block (s, REISERFS_OLD_DISK_OFFSET_IN_BYTES)) 
+      old_format = 1;
+    /* try new format (64-th 1k block), which can contain reiserfs super block */
+    else if (read_super_block (s, REISERFS_DISK_OFFSET_IN_BYTES)) 
+      goto error;    
+    
     s->u.reiserfs_sb.s_mount_state = SB_REISERFS_STATE(s);
     s->u.reiserfs_sb.s_mount_state = REISERFS_VALID_FS ;
 
@@ -697,7 +736,7 @@
 #endif
 
     // set_device_ro(s->s_dev, 1) ;
-    if (journal_init(s)) {
+    if( journal_init(s, jdev_name, old_format) ) {
 	printk("reiserfs_read_super: unable to initialize journal space\n") ;
 	goto error ;
     } else {
@@ -740,33 +779,30 @@
 
     if (!(s->s_flags & MS_RDONLY)) {
 	struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK (s);
-        int old_magic;
-
-      old_magic = strncmp (rs->s_magic,  REISER2FS_SUPER_MAGIC_STRING,
-                           strlen ( REISER2FS_SUPER_MAGIC_STRING));
-	if( old_magic && le16_to_cpu(rs->s_version) != 0 ) {
-	  dput(s->s_root) ;
-	  s->s_root = NULL ;
-	  reiserfs_warning("reiserfs: wrong version/magic combination in the super-block\n") ;
-	  goto error ;
-	}
 
 	journal_begin(&th, s, 1) ;
 	reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
 
-        set_sb_state( rs, REISERFS_ERROR_FS );
-
-        if ( old_magic ) {
-	    // filesystem created under 3.5.x found
-	    if (!old_format_only (s)) {
-		reiserfs_warning("reiserfs: converting 3.5.x filesystem to the new format\n") ;
-		// after this 3.5.x will not be able to mount this partition
-		memcpy (rs->s_magic, REISER2FS_SUPER_MAGIC_STRING, 
-			sizeof (REISER2FS_SUPER_MAGIC_STRING));
-
-		reiserfs_convert_objectid_map_v1(s) ;
-	    } else {
-		reiserfs_warning("reiserfs: using 3.5.x disk format\n") ;
+        set_sb_umount_state( rs, REISERFS_ERROR_FS );
+	set_sb_fs_state (rs, 0);
+	
+	if (is_reiserfs_3_5 (rs) || (is_reiserfs_jr (rs) && SB_VERSION (s) == REISERFS_VERSION_1)) {
+	  /* filesystem of format 3.5 either with standard or non-standard
+	     journal */       
+	  if (!old_format_only (s)) {
+	    /* and -o conv is given */ 
+	    reiserfs_warning ("reiserfs: converting 3.5 filesystem to the 3.6 format\n") ;
+	    
+	    if (is_reiserfs_3_5 (rs))
+	      /* put magic string of 3.6 format. 2.2 will not be able to
+		 mount this filesystem anymore */
+	      memcpy (rs->s_v1.s_magic, reiserfs_3_6_magic_string, 
+		      sizeof (reiserfs_3_6_magic_string));
+	    
+	    set_sb_version(rs,REISERFS_VERSION_2);
+	    reiserfs_convert_objectid_map_v1(s) ;
+	  } else {
+	    reiserfs_warning("reiserfs: using 3.5.x disk format\n") ;
 	    }
 	} else {
 	    // new format found
@@ -779,12 +815,6 @@
 	journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
 	journal_end(&th, s, 1) ;
 	s->s_dirt = 0;
-    } else {
-	struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK (s);
-	if (strncmp (rs->s_magic,  REISER2FS_SUPER_MAGIC_STRING, 
-		     strlen ( REISER2FS_SUPER_MAGIC_STRING))) {
-	    reiserfs_warning("reiserfs: using 3.5.x disk format\n") ;
-	}
     }
 
     reiserfs_proc_info_init( s );
@@ -797,7 +827,6 @@
     reiserfs_proc_register( s, "journal", reiserfs_journal_in_proc );
     init_waitqueue_head (&(s->u.reiserfs_sb.s_wait));
 
-    printk("%s\n", reiserfs_get_version_string()) ;
     return s;
 
  error:
--- linux-2.5.3-pre4.o/fs/reiserfs/version.c	Mon Jan 15 23:42:32 2001
+++ linux-2.5.3-pre4/fs/reiserfs/version.c	Thu Jan 24 11:10:32 2002
@@ -1,7 +0,0 @@
-/*
- * Copyright 2000 by Hans Reiser, licensing governed by reiserfs/README
- */
-
-char *reiserfs_get_version_string(void) {
-  return "ReiserFS version 3.6.25" ;
-}
--- linux-2.5.3-pre4.o/include/linux/reiserfs_fs.h	Thu Jan 24 10:45:26 2002
+++ linux-2.5.3-pre4/include/linux/reiserfs_fs.h	Thu Jan 24 11:07:50 2002
@@ -130,6 +130,135 @@
  * Structure of super block on disk, a version of which in RAM is often accessed as s->u.reiserfs_sb.s_rs
  * the version in RAM is part of a larger structure containing fields never written to disk.
  */
+#define UNSET_HASH 0 // read_super will guess about, what hash names
+                     // in directories were sorted with
+#define TEA_HASH  1
+#define YURA_HASH 2
+#define R5_HASH   3
+#define DEFAULT_HASH R5_HASH
+
+
+struct journal_params {
+    __u32 jp_journal_1st_block;	      /* where does journal start from on its
+				       * device */
+    __u32 jp_journal_dev;	      /* journal device st_rdev */
+    __u32 jp_journal_size;	      /* size of the journal */
+    __u32 jp_journal_trans_max;	      /* max number of blocks in a transaction. */
+    __u32 jp_journal_magic; 	      /* random value made on fs creation (this
+				       * was sb_journal_block_count) */
+    __u32 jp_journal_max_batch;	      /* max number of blocks to batch into a
+				       * trans */
+    __u32 jp_journal_max_commit_age;  /* in seconds, how old can an async
+				       * commit be */
+    __u32 jp_journal_max_trans_age;   /* in seconds, how old can a transaction
+				       * be */
+};
+
+/* this is the super from 3.5.X, where X >= 10 */
+struct reiserfs_super_block_v1
+{
+    __u32 s_block_count;	   /* blocks count         */
+    __u32 s_free_blocks;           /* free blocks count    */
+    __u32 s_root_block;            /* root block number    */
+    struct journal_params s_journal;
+    __u16 s_blocksize;             /* block size */
+    __u16 s_oid_maxsize;	   /* max size of object id array, see
+				    * get_objectid() commentary  */
+    __u16 s_oid_cursize;	   /* current size of object id array */
+    __u16 s_umount_state;          /* this is set to 1 when filesystem was
+				    * umounted, to 2 - when not */    
+    char s_magic[10];              /* reiserfs magic string indicates that
+				    * file system is reiserfs:
+				    * "ReIsErFs" or "ReIsEr2Fs" or "ReIsEr3Fs" */
+    __u16 s_fs_state;	           /* it is set to used by fsck to mark which
+				    * phase of rebuilding is done */
+    __u32 s_hash_function_code;    /* indicate, what hash function is being use
+				    * to sort names in a directory*/
+    __u16 s_tree_height;           /* height of disk tree */
+    __u16 s_bmap_nr;               /* amount of bitmap blocks needed to address
+				    * each block of file system */
+    __u16 s_version;               /* this field is only reliable on filesystem
+				    * with non-standard journal */
+    __u16 s_reserved_for_journal;  /* size in blocks of journal area on main
+				    * device, we need to keep after
+				    * making fs with non-standard journal */	
+} __attribute__ ((__packed__));
+
+#define SB_SIZE_V1 (sizeof(struct reiserfs_super_block_v1))
+
+/* this is the on disk super block */
+struct reiserfs_super_block
+{
+    struct reiserfs_super_block_v1 s_v1;
+    __u32 s_inode_generation;
+    __u32 s_flags;                  /* Right now used only by inode-attributes, if enabled */
+    unsigned char s_uuid[16];       /* filesystem unique identifier */
+    unsigned char s_label[16];      /* filesystem volume label */
+    char s_unused[88] ;             /* zero filled by mkreiserfs and
+				     * reiserfs_convert_objectid_map_v1()
+				     * so any additions must be updated
+				     * there as well. */
+}  __attribute__ ((__packed__));
+
+#define SB_SIZE (sizeof(struct reiserfs_super_block))
+
+#define REISERFS_VERSION_1 0
+#define REISERFS_VERSION_2 2
+
+
+// on-disk super block fields converted to cpu form
+#define SB_DISK_SUPER_BLOCK(s) ((s)->u.reiserfs_sb.s_rs)
+#define SB_V1_DISK_SUPER_BLOCK(s) (&(SB_DISK_SUPER_BLOCK(s)->s_v1))
+#define SB_BLOCKSIZE(s) \
+        le32_to_cpu ((SB_V1_DISK_SUPER_BLOCK(s)->s_blocksize))
+#define SB_BLOCK_COUNT(s) \
+        le32_to_cpu ((SB_V1_DISK_SUPER_BLOCK(s)->s_block_count))
+#define SB_FREE_BLOCKS(s) \
+        le32_to_cpu ((SB_V1_DISK_SUPER_BLOCK(s)->s_free_blocks))
+#define SB_REISERFS_MAGIC(s) \
+        (SB_V1_DISK_SUPER_BLOCK(s)->s_magic)
+#define SB_ROOT_BLOCK(s) \
+        le32_to_cpu ((SB_V1_DISK_SUPER_BLOCK(s)->s_root_block))
+#define SB_TREE_HEIGHT(s) \
+        le16_to_cpu ((SB_V1_DISK_SUPER_BLOCK(s)->s_tree_height))
+#define SB_REISERFS_STATE(s) \
+        le16_to_cpu ((SB_V1_DISK_SUPER_BLOCK(s)->s_umount_state))
+#define SB_VERSION(s) le16_to_cpu ((SB_V1_DISK_SUPER_BLOCK(s)->s_version))
+#define SB_BMAP_NR(s) le16_to_cpu ((SB_V1_DISK_SUPER_BLOCK(s)->s_bmap_nr))
+
+#define PUT_SB_BLOCK_COUNT(s, val) \
+   do { SB_V1_DISK_SUPER_BLOCK(s)->s_block_count = cpu_to_le32(val); } while (0)
+#define PUT_SB_FREE_BLOCKS(s, val) \
+   do { SB_V1_DISK_SUPER_BLOCK(s)->s_free_blocks = cpu_to_le32(val); } while (0)
+#define PUT_SB_ROOT_BLOCK(s, val) \
+   do { SB_V1_DISK_SUPER_BLOCK(s)->s_root_block = cpu_to_le32(val); } while (0)
+#define PUT_SB_TREE_HEIGHT(s, val) \
+   do { SB_V1_DISK_SUPER_BLOCK(s)->s_tree_height = cpu_to_le16(val); } while (0)
+#define PUT_SB_REISERFS_STATE(s, val) \
+   do { SB_V1_DISK_SUPER_BLOCK(s)->s_umount_state = cpu_to_le16(val); } while (0) 
+#define PUT_SB_VERSION(s, val) \
+   do { SB_V1_DISK_SUPER_BLOCK(s)->s_version = cpu_to_le16(val); } while (0)
+#define PUT_SB_BMAP_NR(s, val) \
+   do { SB_V1_DISK_SUPER_BLOCK(s)->s_bmap_nr = cpu_to_le16 (val); } while (0)
+
+
+#define SB_ONDISK_JP(s) (&SB_V1_DISK_SUPER_BLOCK(s)->s_journal)
+#define SB_ONDISK_JOURNAL_SIZE(s) \
+         le32_to_cpu ((SB_ONDISK_JP(s)->jp_journal_size))
+#define SB_ONDISK_JOURNAL_1st_BLOCK(s) \
+         le32_to_cpu ((SB_ONDISK_JP(s)->jp_journal_1st_block))
+#define SB_ONDISK_JOURNAL_DEVICE(s) \
+         le32_to_cpu ((SB_ONDISK_JP(s)->jp_journal_dev))
+#define SB_ONDISK_RESERVED_FOR_JOURNAL(s) \
+         le32_to_cpu ((SB_V1_DISK_SUPER_BLOCK(s)->s_reserved_for_journal))
+
+#define is_block_in_log_or_reserved_area(s, block) \
+         block >= SB_JOURNAL_1st_RESERVED_BLOCK(s) \
+         && block < SB_JOURNAL_1st_RESERVED_BLOCK(s) +  \
+         ((!is_reiserfs_jr(SB_DISK_SUPER_BLOCK(s)) ? \
+         SB_ONDISK_JOURNAL_SIZE(s) + 1 : SB_ONDISK_RESERVED_FOR_JOURNAL(s))) 
+
+
 
 				/* used by gcc */
 #define REISERFS_SUPER_MAGIC 0x52654973
@@ -137,17 +266,17 @@
                                    look at the superblock, etc. */
 #define REISERFS_SUPER_MAGIC_STRING "ReIsErFs"
 #define REISER2FS_SUPER_MAGIC_STRING "ReIsEr2Fs"
+#define REISER2FS_JR_SUPER_MAGIC_STRING "ReIsEr3Fs"
+
+extern const char reiserfs_3_5_magic_string[];
+extern const char reiserfs_3_6_magic_string[];
+extern const char reiserfs_jr_magic_string[];
+
+int is_reiserfs_3_5 (struct reiserfs_super_block * rs);
+int is_reiserfs_3_6 (struct reiserfs_super_block * rs);
+int is_reiserfs_jr (struct reiserfs_super_block * rs);
 
-extern char reiserfs_super_magic_string[];
-extern char reiser2fs_super_magic_string[];
 
-static inline int is_reiserfs_magic_string (const struct reiserfs_super_block * rs)
-{
-    return (!strncmp (rs->s_magic, reiserfs_super_magic_string, 
-		      strlen ( reiserfs_super_magic_string)) ||
-	    !strncmp (rs->s_magic, reiser2fs_super_magic_string, 
-		      strlen ( reiser2fs_super_magic_string)));
-}
 
 				/* ReiserFS leaves the first 64k unused,
                                    so that partition labels have enough
@@ -160,6 +289,7 @@
                                    break.  -Hans */
 #define REISERFS_DISK_OFFSET_IN_BYTES (64 * 1024)
 #define REISERFS_FIRST_BLOCK unused_define
+#define REISERFS_JOURNAL_OFFSET_IN_BYTES REISERFS_DISK_OFFSET_IN_BYTES
 
 /* the spot for the super in versions 3.5 - 3.5.10 (inclusive) */
 #define REISERFS_OLD_DISK_OFFSET_IN_BYTES (8 * 1024)
@@ -239,7 +369,7 @@
 
 
 /*
- * values for s_state field
+ * values for s_umount_state field
  */
 #define REISERFS_VALID_FS    1
 #define REISERFS_ERROR_FS    2
@@ -1626,6 +1756,7 @@
   __u32 j_last_flush_trans_id ;		/* id of last fully flushed transaction */
   __u32 j_first_unflushed_offset ;      /* offset in the log of where to start replay after a crash */
   __u32 j_mount_id ;
+  /* 12 */ struct journal_params jh_journal;
 } ;
 
 extern task_queue reiserfs_commit_thread_tq ;
@@ -1633,7 +1764,10 @@
 
 /* biggest tunable defines are right here */
 #define JOURNAL_BLOCK_COUNT 8192 /* number of blocks in the journal */
-#define JOURNAL_MAX_BATCH   900 /* max blocks to batch into one transaction, don't make this any bigger than 900 */
+#define JOURNAL_TRANS_MAX_DEFAULT 1024   /* biggest possible single transaction, don't change for now (8/3/99) */
+#define JOURNAL_TRANS_MIN_DEFAULT 256
+#define JOURNAL_MAX_BATCH_DEFAULT   900 /* max blocks to batch into one transaction, don't make this any bigger than 900 */
+#define JOURNAL_MIN_RATIO 2
 #define JOURNAL_MAX_COMMIT_AGE 30 
 #define JOURNAL_MAX_TRANS_AGE 30
 #define JOURNAL_PER_BALANCE_CNT (3 * (MAX_HEIGHT-2) + 9)
@@ -1671,7 +1805,7 @@
 void reiserfs_check_lock_depth(char *caller) ;
 void reiserfs_prepare_for_journal(struct super_block *, struct buffer_head *bh, int wait) ;
 void reiserfs_restore_prepared_buffer(struct super_block *, struct buffer_head *bh) ;
-int journal_init(struct super_block *) ;
+int journal_init(struct super_block *, const char * j_dev_name, int old_format) ;
 int journal_release(struct reiserfs_transaction_handle*, struct super_block *) ;
 int journal_release_error(struct reiserfs_transaction_handle*, struct super_block *) ;
 int journal_end(struct reiserfs_transaction_handle *, struct super_block *, unsigned long) ;
@@ -2091,9 +2225,6 @@
 __u32 yura_hash (const signed char *msg, int len);
 __u32 r5_hash (const signed char *msg, int len);
 
-/* version.c */
-const char *reiserfs_get_version_string(void) CONSTF;
-
 /* the ext2 bit routines adjust for big or little endian as
 ** appropriate for the arch, so in our laziness we use them rather
 ** than using the bit routines they call more directly.  These
@@ -2189,12 +2320,6 @@
    absolutely safe */
 #define SPARE_SPACE 500
 
-static inline unsigned long reiserfs_get_journal_block(const struct super_block *s) {
-    return le32_to_cpu(SB_DISK_SUPER_BLOCK(s)->s_journal_block) ;
-}
-static inline unsigned long reiserfs_get_journal_orig_size(const struct super_block *s) {
-    return le32_to_cpu(SB_DISK_SUPER_BLOCK(s)->s_orig_journal_size) ;
-}
 
 /* prototypes from ioctl.c */
 int reiserfs_ioctl (struct inode * inode, struct file * filp, 
--- linux-2.5.3-pre4.o/include/linux/reiserfs_fs_sb.h	Thu Jan 24 10:45:26 2002
+++ linux-2.5.3-pre4/include/linux/reiserfs_fs_sb.h	Thu Jan 24 11:06:50 2002
@@ -8,140 +8,71 @@
 #include <linux/tqueue.h>
 #endif
 
-//
-// super block's field values
-//
-/*#define REISERFS_VERSION 0 undistributed bitmap */
-/*#define REISERFS_VERSION 1 distributed bitmap and resizer*/
-#define REISERFS_VERSION_2 2 /* distributed bitmap, resizer, 64-bit, etc*/
-#define UNSET_HASH 0 // read_super will guess about, what hash names
-                     // in directories were sorted with
-#define TEA_HASH  1
-#define YURA_HASH 2
-#define R5_HASH   3
-#define DEFAULT_HASH R5_HASH
 
-/* this is the on disk super block */
-
-struct reiserfs_super_block
-{
-  __u32 s_block_count;
-  __u32 s_free_blocks;                  /* free blocks count    */
-  __u32 s_root_block;           	/* root block number    */
-  __u32 s_journal_block;           	/* journal block number    */
-  __u32 s_journal_dev;           	/* journal device number  */
-
-  /* Since journal size is currently a #define in a header file, if 
-  ** someone creates a disk with a 16MB journal and moves it to a 
-  ** system with 32MB journal default, they will overflow their journal 
-  ** when they mount the disk.  s_orig_journal_size, plus some checks
-  ** while mounting (inside journal_init) prevent that from happening
-  */
-
-				/* great comment Chris. Thanks.  -Hans */
-
-  __u32 s_orig_journal_size; 		
-  __u32 s_journal_trans_max ;           /* max number of blocks in a transaction.  */
-  __u32 s_journal_block_count ;         /* total size of the journal. can change over time  */
-  __u32 s_journal_max_batch ;           /* max number of blocks to batch into a trans */
-  __u32 s_journal_max_commit_age ;      /* in seconds, how old can an async commit be */
-  __u32 s_journal_max_trans_age ;       /* in seconds, how old can a transaction be */
-  __u16 s_blocksize;                   	/* block size           */
-  __u16 s_oid_maxsize;			/* max size of object id array, see get_objectid() commentary  */
-  __u16 s_oid_cursize;			/* current size of object id array */
-  __u16 s_state;                       	/* valid or error       */
-  char s_magic[12];                     /* reiserfs magic string indicates that file system is reiserfs */
-  __u32 s_hash_function_code;		/* indicate, what hash function is being use to sort names in a directory*/
-  __u16 s_tree_height;                  /* height of disk tree */
-  __u16 s_bmap_nr;                      /* amount of bitmap blocks needed to address each block of file system */
-  __u16 s_version;		/* I'd prefer it if this was a string,
-                                   something like "3.6.4", and maybe
-                                   16 bytes long mostly unused. We
-                                   don't need to save bytes in the
-                                   superblock. -Hans */
-  __u16 s_reserved;
-  __u32 s_inode_generation;
-  char s_unused[124] ;			/* zero filled by mkreiserfs */
-} __attribute__ ((__packed__));
-
-#define SB_SIZE (sizeof(struct reiserfs_super_block))
 /* struct reiserfs_super_block accessors/mutators
  * since this is a disk structure, it will always be in 
  * little endian format. */
-#define sb_block_count(sbp)           (le32_to_cpu((sbp)->s_block_count))
-#define set_sb_block_count(sbp,v)     ((sbp)->s_block_count = cpu_to_le32(v))
-#define sb_free_blocks(sbp)           (le32_to_cpu((sbp)->s_free_blocks))
-#define set_sb_free_blocks(sbp,v)     ((sbp)->s_free_blocks = cpu_to_le32(v))
-#define sb_root_block(sbp)            (le32_to_cpu((sbp)->s_root_block))
-#define set_sb_root_block(sbp,v)      ((sbp)->s_root_block = cpu_to_le32(v))
-#define sb_journal_block(sbp)         (le32_to_cpu((sbp)->s_journal_block))
-#define set_sb_journal_block(sbp,v)   ((sbp)->s_journal_block = cpu_to_le32(v))
-#define sb_journal_dev(sbp)           (le32_to_cpu((sbp)->s_journal_dev))
-#define set_sb_journal_dev(sbp,v)     ((sbp)->s_journal_dev = cpu_to_le32(v))
-#define sb_orig_journal_size(sbp)   (le32_to_cpu((sbp)->s_orig_journal_size))
-#define set_sb_orig_journal_size(sbp,v) \
-                            ((sbp)->s_orig_journal_size = cpu_to_le32(v))
-#define sb_journal_trans_max(sbp)     (le32_to_cpu((sbp)->s_journal_trans_max))
-#define set_journal_trans_max(sbp,v) \
-                            ((sbp)->s_journal_trans_max = cpu_to_le32(v))
-#define sb_journal_block_count(sbp)  (le32_to_cpu((sbp)->journal_block_count))
-#define sb_set_journal_block_count(sbp,v) \
-                            ((sbp)->s_journal_block_count = cpu_to_le32(v))
-#define sb_journal_max_batch(sbp)     (le32_to_cpu((sbp)->s_journal_max_batch))
-#define set_sb_journal_max_batch(sbp,v) \
-                            ((sbp)->s_journal_max_batch = cpu_to_le32(v))
-#define sb_jourmal_max_commit_age(sbp) \
-                            (le32_to_cpu((sbp)->s_journal_max_commit_age))
-#define set_sb_journal_max_commit_age(sbp,v) \
-                            ((sbp)->s_journal_max_commit_age = cpu_to_le32(v))
-#define sb_jourmal_max_trans_age(sbp) \
-                            (le32_to_cpu((sbp)->s_journal_max_trans_age))
-#define set_sb_journal_max_trans_age(sbp,v) \
-                            ((sbp)->s_journal_max_trans_age = cpu_to_le32(v))
-#define sb_blocksize(sbp)             (le16_to_cpu((sbp)->s_blocksize))
-#define set_sb_blocksize(sbp,v)       ((sbp)->s_blocksize = cpu_to_le16(v))
-#define sb_oid_maxsize(sbp)           (le16_to_cpu((sbp)->s_oid_maxsize))
-#define set_sb_oid_maxsize(sbp,v)     ((sbp)->s_oid_maxsize = cpu_to_le16(v))
-#define sb_oid_cursize(sbp)           (le16_to_cpu((sbp)->s_oid_cursize))
-#define set_sb_oid_cursize(sbp,v)     ((sbp)->s_oid_cursize = cpu_to_le16(v))
-#define sb_state(sbp)                 (le16_to_cpu((sbp)->s_state))
-#define set_sb_state(sbp,v)           ((sbp)->s_state = cpu_to_le16(v))
+#define sb_block_count(sbp)         (le32_to_cpu((sbp)->s_v1.s_block_count))
+#define set_sb_block_count(sbp,v)   ((sbp)->s_v1.s_block_count = cpu_to_le32(v))
+#define sb_free_blocks(sbp)         (le32_to_cpu((sbp)->s_v1.s_free_blocks))
+#define set_sb_free_blocks(sbp,v)   ((sbp)->s_v1.s_free_blocks = cpu_to_le32(v))
+#define sb_root_block(sbp)          (le32_to_cpu((sbp)->s_v1.s_root_block))
+#define set_sb_root_block(sbp,v)    ((sbp)->s_v1.s_root_block = cpu_to_le32(v))
+
+#define sb_jp_journal_1st_block(sbp)  \
+              (le32_to_cpu((sbp)->s_v1.s_journal.jp_journal_1st_block))
+#define set_sb_jp_journal_1st_block(sbp,v) \
+              ((sbp)->s_v1.s_journal.jp_journal_1st_block = cpu_to_le32(v))
+#define sb_jp_journal_dev(sbp) \
+              (le32_to_cpu((sbp)->s_v1.s_journal.jp_journal_dev))
+#define set_sb_jp_journal_dev(sbp,v) \
+              ((sbp)->s_v1.s_journal.jp_journal_dev = cpu_to_le32(v))
+#define sb_jp_journal_size(sbp) \
+              (le32_to_cpu((sbp)->s_v1.s_journal.jp_journal_size))
+#define set_sb_jp_journal_size(sbp,v) \
+              ((sbp)->s_v1.s_journal.jp_journal_size = cpu_to_le32(v))
+#define sb_jp_journal_trans_max(sbp) \
+              (le32_to_cpu((sbp)->s_v1.s_journal.jp_journal_trans_max))
+#define set_sb_jp_journal_trans_max(sbp,v) \
+              ((sbp)->s_v1.s_journal.jp_journal_trans_max = cpu_to_le32(v))
+#define sb_jp_journal_magic(sbp) \
+              (le32_to_cpu((sbp)->s_v1.s_journal.jp_journal_magic))
+#define set_sb_jp_journal_magic(sbp,v) \
+              ((sbp)->s_v1.s_journal.jp_journal_magic = cpu_to_le32(v))
+#define sb_jp_journal_max_batch(sbp) \
+              (le32_to_cpu((sbp)->s_v1.s_journal.jp_journal_max_batch))
+#define set_sb_jp_journal_max_batch(sbp,v) \
+              ((sbp)->s_v1.s_journal.jp_journal_max_batch = cpu_to_le32(v))
+#define sb_jp_jourmal_max_commit_age(sbp) \
+              (le32_to_cpu((sbp)->s_v1.s_journal.jp_journal_max_commit_age))
+#define set_sb_jp_journal_max_commit_age(sbp,v) \
+              ((sbp)->s_v1.s_journal.jp_journal_max_commit_age = cpu_to_le32(v))
+
+#define sb_blocksize(sbp)          (le16_to_cpu((sbp)->s_v1.s_blocksize))
+#define set_sb_blocksize(sbp,v)    ((sbp)->s_v1.s_blocksize = cpu_to_le16(v))
+#define sb_oid_maxsize(sbp)        (le16_to_cpu((sbp)->s_v1.s_oid_maxsize))
+#define set_sb_oid_maxsize(sbp,v)  ((sbp)->s_v1.s_oid_maxsize = cpu_to_le16(v))
+#define sb_oid_cursize(sbp)        (le16_to_cpu((sbp)->s_v1.s_oid_cursize))
+#define set_sb_oid_cursize(sbp,v)  ((sbp)->s_v1.s_oid_cursize = cpu_to_le16(v))
+#define sb_umount_state(sbp)       (le16_to_cpu((sbp)->s_v1.s_umount_state))
+#define set_sb_umount_state(sbp,v) ((sbp)->s_v1.s_umount_state = cpu_to_le16(v))
+#define sb_fs_state(sbp)           (le16_to_cpu((sbp)->s_v1.s_fs_state))
+#define set_sb_fs_state(sbp,v)     ((sbp)->s_v1.s_fs_state = cpu_to_le16(v)) 
 #define sb_hash_function_code(sbp) \
-                            (le32_to_cpu((sbp)->s_hash_function_code))
+              (le32_to_cpu((sbp)->s_v1.s_hash_function_code))
 #define set_sb_hash_function_code(sbp,v) \
-                            ((sbp)->s_hash_function_code = cpu_to_le32(v))
-#define sb_tree_height(sbp)           (le16_to_cpu((sbp)->s_tree_height))
-#define set_sb_tree_height(sbp,v)     ((sbp)->s_tree_height = cpu_to_le16(v))
-#define sb_bmap_nr(sbp)               (le16_to_cpu((sbp)->s_bmap_nr))
-#define set_sb_bmap_nr(sbp,v)         ((sbp)->s_bmap_nr = cpu_to_le16(v))
-#define sb_version(sbp)               (le16_to_cpu((sbp)->s_version))
-#define set_sb_version(sbp,v)         ((sbp)->s_version = cpu_to_le16(v))
-
-/* this is the super from 3.5.X, where X >= 10 */
-struct reiserfs_super_block_v1
-{
-  __u32 s_block_count;			/* blocks count         */
-  __u32 s_free_blocks;                  /* free blocks count    */
-  __u32 s_root_block;           	/* root block number    */
-  __u32 s_journal_block;           	/* journal block number    */
-  __u32 s_journal_dev;           	/* journal device number  */
-  __u32 s_orig_journal_size; 		/* size of the journal on FS creation.  used to make sure they don't overflow it */
-  __u32 s_journal_trans_max ;           /* max number of blocks in a transaction.  */
-  __u32 s_journal_block_count ;         /* total size of the journal. can change over time  */
-  __u32 s_journal_max_batch ;           /* max number of blocks to batch into a trans */
-  __u32 s_journal_max_commit_age ;      /* in seconds, how old can an async commit be */
-  __u32 s_journal_max_trans_age ;       /* in seconds, how old can a transaction be */
-  __u16 s_blocksize;                   	/* block size           */
-  __u16 s_oid_maxsize;			/* max size of object id array, see get_objectid() commentary  */
-  __u16 s_oid_cursize;			/* current size of object id array */
-  __u16 s_state;                       	/* valid or error       */
-  char s_magic[16];                     /* reiserfs magic string indicates that file system is reiserfs */
-  __u16 s_tree_height;                  /* height of disk tree */
-  __u16 s_bmap_nr;                      /* amount of bitmap blocks needed to address each block of file system */
-  __u32 s_reserved;
-} __attribute__ ((__packed__));
-
-#define SB_SIZE_V1 (sizeof(struct reiserfs_super_block_v1))
+              ((sbp)->s_v1.s_hash_function_code = cpu_to_le32(v))
+#define sb_tree_height(sbp)        (le16_to_cpu((sbp)->s_v1.s_tree_height))
+#define set_sb_tree_height(sbp,v)  ((sbp)->s_v1.s_tree_height = cpu_to_le16(v))
+#define sb_bmap_nr(sbp)            (le16_to_cpu((sbp)->s_v1.s_bmap_nr))
+#define set_sb_bmap_nr(sbp,v)      ((sbp)->s_v1.s_bmap_nr = cpu_to_le16(v))
+#define sb_version(sbp)            (le16_to_cpu((sbp)->s_v1.s_version))
+#define set_sb_version(sbp,v)      ((sbp)->s_v1.s_version = cpu_to_le16(v))
+
+#define sb_reserved_for_journal(sbp) \
+              (le16_to_cpu((sbp)->s_v1.s_reserved_for_journal))
+#define set_sb_reserved_for_journal(sbp,v) \
+              ((sbp)->s_v1.s_reserved_for_journal = cpu_to_le16(v))
 
 /* LOGGING -- */
 
@@ -170,7 +101,6 @@
 				/* we have a node size define somewhere in reiserfs_fs.h. -Hans */
 #define JOURNAL_BLOCK_SIZE  4096 /* BUG gotta get rid of this */
 #define JOURNAL_MAX_CNODE   1500 /* max cnodes to allocate. */
-#define JOURNAL_TRANS_MAX 1024   /* biggest possible single transaction, don't change for now (8/3/99) */
 #define JOURNAL_HASH_SIZE 8192   
 #define JOURNAL_NUM_BITMAPS 5 /* number of copies of the bitmaps to have floating.  Must be >= 2 */
 #define JOURNAL_LIST_COUNT 64
@@ -263,7 +193,12 @@
   struct buffer_head ** j_ap_blocks ; /* journal blocks on disk */
   struct reiserfs_journal_cnode *j_last ; /* newest journal block */
   struct reiserfs_journal_cnode *j_first ; /*  oldest journal block.  start here for traverse */
-				
+
+  kdev_t               j_dev;
+  struct file         *j_dev_file;
+  struct block_device *j_dev_bd;  
+  int j_1st_reserved_block;     /* first block on s_dev of reserved area journal */        
+	
   int j_state ;			
   unsigned long j_trans_id ;
   unsigned long j_mount_id ;
@@ -294,6 +229,11 @@
   int j_cnode_used ;	      /* number of cnodes on the used list */
   int j_cnode_free ;          /* number of cnodes on the free list */
 
+  unsigned int s_journal_trans_max ;           /* max number of blocks in a transaction.  */
+  unsigned int s_journal_max_batch ;           /* max number of blocks to batch into a trans */
+  unsigned int s_journal_max_commit_age ;      /* in seconds, how old can an async commit be */
+  unsigned int s_journal_max_trans_age ;       /* in seconds, how old can a transaction be */  
+
   struct reiserfs_journal_cnode *j_cnode_free_list ;
   struct reiserfs_journal_cnode *j_cnode_free_orig ; /* orig pointer returned from vmalloc */
 
@@ -474,7 +414,8 @@
 #define dont_have_tails(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << NOTAIL))
 #define replay_only(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REPLAYONLY))
 #define reiserfs_dont_log(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_NOLOG))
-#define old_format_only(s) ((SB_VERSION(s) != REISERFS_VERSION_2) && !((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_CONVERT)))
+#define old_format_only(s) ((SB_VERSION(s) != REISERFS_VERSION_2) \
+         && !((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_CONVERT)))
 
 
 void reiserfs_file_buffer (struct buffer_head * bh, int list);
@@ -490,29 +431,19 @@
 
 #define SB_BUFFER_WITH_SB(s) ((s)->u.reiserfs_sb.s_sbh)
 #define SB_JOURNAL(s) ((s)->u.reiserfs_sb.s_journal)
+#define SB_JOURNAL_1st_RESERVED_BLOCK(s) (SB_JOURNAL(s)->j_1st_reserved_block)
 #define SB_JOURNAL_LIST(s) (SB_JOURNAL(s)->j_journal_list)
 #define SB_JOURNAL_LIST_INDEX(s) (SB_JOURNAL(s)->j_journal_list_index) 
 #define SB_JOURNAL_LEN_FREE(s) (SB_JOURNAL(s)->j_journal_len_free) 
 #define SB_AP_BITMAP(s) ((s)->u.reiserfs_sb.s_ap_bitmap)
 
+#define SB_DISK_JOURNAL_HEAD(s) (SB_JOURNAL(s)->j_header_bh->)
 
-// on-disk super block fields converted to cpu form
-#define SB_DISK_SUPER_BLOCK(s)        ((s)->u.reiserfs_sb.s_rs)
-#define SB_BLOCK_COUNT(s)             sb_block_count (SB_DISK_SUPER_BLOCK(s))
-#define SB_FREE_BLOCKS(s)             sb_free_blocks (SB_DISK_SUPER_BLOCK(s))
-#define SB_REISERFS_MAGIC(s)          (SB_DISK_SUPER_BLOCK(s)->s_magic)
-#define SB_ROOT_BLOCK(s)              sb_root_block (SB_DISK_SUPER_BLOCK(s))
-#define SB_TREE_HEIGHT(s)             sb_tree_height (SB_DISK_SUPER_BLOCK(s))
-#define SB_REISERFS_STATE(s)          sb_state (SB_DISK_SUPER_BLOCK(s))
-#define SB_VERSION(s)                 sb_version (SB_DISK_SUPER_BLOCK(s))
-#define SB_BMAP_NR(s)                 sb_bmap_nr(SB_DISK_SUPER_BLOCK(s))
-
-#define PUT_SB_BLOCK_COUNT(s, val)    do { set_sb_block_count( SB_DISK_SUPER_BLOCK(s), val); } while (0)
-#define PUT_SB_FREE_BLOCKS(s, val)    do { set_sb_free_blocks( SB_DISK_SUPER_BLOCK(s), val); } while (0)
-#define PUT_SB_ROOT_BLOCK(s, val)     do { set_sb_root_block( SB_DISK_SUPER_BLOCK(s), val); } while (0)
-#define PUT_SB_TREE_HEIGHT(s, val)    do { set_sb_tree_height( SB_DISK_SUPER_BLOCK(s), val); } while (0)
-#define PUT_SB_REISERFS_STATE(s, val) do { set_sb_state( SB_DISK_SUPER_BLOCK(s), val); } while (0) 
-#define PUT_SB_VERSION(s, val)        do { set_sb_version( SB_DISK_SUPER_BLOCK(s), val); } while (0)
-#define PUT_SB_BMAP_NR(s, val)        do { set_sb_bmap_nr( SB_DISK_SUPER_BLOCK(s), val); } while (0)
+#define SB_JOURNAL_TRANS_MAX(s)      (SB_JOURNAL(s)->s_journal_trans_max)
+#define SB_JOURNAL_MAX_BATCH(s)      (SB_JOURNAL(s)->s_journal_max_batch)
+#define SB_JOURNAL_MAX_COMMIT_AGE(s) (SB_JOURNAL(s)->s_journal_max_commit_age)
+#define SB_JOURNAL_MAX_TRANS_AGE(s)  (SB_JOURNAL(s)->s_journal_max_trans_age)
+#define SB_JOURNAL_DEV(s)            (SB_JOURNAL(s)->j_dev)
+  
 
 #endif	/* _LINUX_REISER_FS_SB */

