Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289532AbSA2MOH>; Tue, 29 Jan 2002 07:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289527AbSA2Lng>; Tue, 29 Jan 2002 06:43:36 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:21263 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289523AbSA2Lkj>; Tue, 29 Jan 2002 06:40:39 -0500
Date: Mon, 28 Jan 2002 20:32:14 +0300
Message-Id: <200201281732.g0SHWEa23000@bitshadow.namesys.com>
From: Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com
CC: reiser@namesys.com, reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS 2.5 Update Patch Set 5 of 25
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This set of patches of which this is one will update ReiserFS in 2.5
to contain all bugfixes applied to 2.4 plus allow relocating the journal plus
uuid support plus fix the kdev_t compilation failure.

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





--- linux-2.5.3-pre3/fs/reiserfs/stree.c.orig	Wed Jan 23 13:53:36 2002
+++ linux-2.5.3-pre3/fs/reiserfs/stree.c	Wed Jan 23 14:05:13 2002
@@ -991,10 +991,6 @@
     struct item_head    * p_le_ih = PATH_PITEM_HEAD(p_s_path);
     struct buffer_head  * p_s_bh = PATH_PLAST_BUFFER(p_s_path);
 
-#ifdef CONFIG_REISERFS_CHECK
-    int n_repeat_counter = 0;
-#endif
-
     /* Stat_data item. */
     if ( is_statdata_le_ih (p_le_ih) ) {
 
@@ -1019,13 +1015,11 @@
     {
 	int                   n_unfm_number,    /* Number of the item unformatted nodes. */
 	    n_counter,
-	    n_retry,        /* Set to one if there is unformatted node buffer in use. */
 	    n_blk_size;
 	__u32               * p_n_unfm_pointer; /* Pointer to the unformatted node number. */
 	__u32 tmp;
 	struct item_head      s_ih;           /* Item header. */
 	char                  c_mode;           /* Returned mode of the balance. */
-	struct buffer_head  * p_s_un_bh;
 	int need_research;
 
 
@@ -1098,8 +1092,8 @@
 	    // note: path could be changed, first line in for loop takes care
 	    // of it
 
-	    for ( n_retry = 0, n_counter = *p_n_removed;
-		  n_counter < n_unfm_number; n_counter++, p_n_unfm_pointer-- )  {
+	    for (n_counter = *p_n_removed;
+		 n_counter < n_unfm_number; n_counter++, p_n_unfm_pointer-- ) {
 
 		if (item_moved (&s_ih, p_s_path)) {
 		    need_research = 1 ;
@@ -1109,69 +1103,23 @@
 			p_n_unfm_pointer > (__u32 *)B_I_PITEM(p_s_bh, &s_ih) + I_UNFM_NUM(&s_ih) - 1,
 			"vs-5265: pointer out of range");
 
-		if ( ! get_block_num(p_n_unfm_pointer,0) )  { /* Hole, nothing to remove. */
-		    if ( ! n_retry )
+		/* Hole, nothing to remove. */
+		if ( ! get_block_num(p_n_unfm_pointer,0) )  {
 			(*p_n_removed)++;
-		    continue;
+			continue;
 		}
-		/* Search for the buffer in cache. */
-		p_s_un_bh = sb_get_hash_table(p_s_sb, get_block_num(p_n_unfm_pointer,0));
 
-		if (p_s_un_bh) {
-		    mark_buffer_clean(p_s_un_bh) ;
-		    if (buffer_locked(p_s_un_bh)) {
-		  __wait_on_buffer(p_s_un_bh) ;
-		    }
-		    /* even if the item moves, the block number of the
-		    ** unformatted node we want to cut won't.  So, it was
-		    ** safe to clean the buffer here, this block _will_
-		    ** get freed during this call to prepare_for_delete_or_cut
-		    */
-		  if ( item_moved (&s_ih, p_s_path) )  {
-		      need_research = 1;
-		      brelse(p_s_un_bh) ;
-		      break ;
-		  }
-		}
-		if ( p_s_un_bh && block_in_use (p_s_un_bh)) {
-		    /* Block is locked or held more than by one holder and by
-                       journal. */
-
-#ifdef CONFIG_REISERFS_CHECK
-		    if (n_repeat_counter && (n_repeat_counter % 100000) == 0) {
-		      printk("prepare_for_delete, waiting on buffer %lu, b_count %d, %s%cJDIRTY %cJDIRTY_WAIT\n", 
-			     p_s_un_bh->b_blocknr, atomic_read (&p_s_un_bh->b_count),
-			     buffer_locked (p_s_un_bh) ? "locked, " : "",
-			     buffer_journaled(p_s_un_bh) ? ' ' : '!', 
-			     buffer_journal_dirty(p_s_un_bh) ? ' ' : '!') ;
-
-		    }
-#endif
-		    n_retry = 1;
-		    brelse (p_s_un_bh);
-		    continue;
-		}
-      
-		if ( ! n_retry )
-		    (*p_n_removed)++;
-      
-		RFALSE( p_s_un_bh &&
-                     get_block_num(p_n_unfm_pointer, 0) != p_s_un_bh->b_blocknr,
-		    // note: minix_truncate allows that. As truncate is
-		    // protected by down (inode->i_sem), two truncates can not
-		    // co-exist
-		    "PAP-5280: blocks numbers are different");	
+		(*p_n_removed)++;
 
 		tmp = get_block_num(p_n_unfm_pointer,0);
 		put_block_num(p_n_unfm_pointer, 0, 0);
 		journal_mark_dirty (th, p_s_sb, p_s_bh);
-		bforget (p_s_un_bh);
 		inode->i_blocks -= p_s_sb->s_blocksize / 512;
 		reiserfs_free_block(th, tmp);
 		if ( item_moved (&s_ih, p_s_path) )  {
-		    need_research = 1;
-		    break ;
-		    }
+			need_research = 1;
+			break ;
+		}
 	    }
 
 	    /* a trick.  If the buffer has been logged, this
@@ -1181,27 +1129,6 @@
 	    */
 	    reiserfs_restore_prepared_buffer(p_s_sb, p_s_bh);
 
-	    if ( n_retry ) {
-		/* There is block in use. Wait, they should release it soon */
-
-		RFALSE( *p_n_removed >= n_unfm_number, "PAP-5290: illegal case");
-#ifdef CONFIG_REISERFS_CHECK
-		if ( !(++n_repeat_counter % 500000) ) {
-		    reiserfs_warning("PAP-5300: prepare_for_delete_or_cut: (pid %u): "
-				     "could not delete item %k in (%d) iterations. New file length %Lu. (inode %Ld), Still trying\n",
-				     current->pid, p_s_item_key, n_repeat_counter, n_new_file_length, inode->i_size);
-		    if (n_repeat_counter == 5000000) {
-			print_block (PATH_PLAST_BUFFER(p_s_path), 3, 
-				     PATH_LAST_POSITION (p_s_path) - 2, PATH_LAST_POSITION (p_s_path) + 2);
-			reiserfs_panic(p_s_sb, "PAP-5305: prepare_for_delete_or_cut: key %k, new_file_length %Ld",
-				       p_s_item_key, n_new_file_length);
-		    }
-		}
-#endif
-
-		run_task_queue(&tq_disk);
-		yield();
-	    }
 	    /* This loop can be optimized. */
 	} while ( (*p_n_removed < n_unfm_number || need_research) &&
 		  search_for_position_by_key(p_s_sb, p_s_item_key, p_s_path) == POSITION_FOUND );

