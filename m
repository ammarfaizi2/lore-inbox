Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289517AbSA2LnH>; Tue, 29 Jan 2002 06:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289580AbSA2Llq>; Tue, 29 Jan 2002 06:41:46 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:35855 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289549AbSA2Lkp>; Tue, 29 Jan 2002 06:40:45 -0500
Date: Mon, 28 Jan 2002 20:35:00 +0300
Message-Id: <200201281735.g0SHZ0923010@bitshadow.namesys.com>
From: Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com
CC: reiser@namesys.com, reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS 2.5 Update Patch Set 6 of 25
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This set of patches of which this is one will update ReiserFS in 2.5
to contain all bugfixes applied to 2.4 plus allow relocating the journal plus
uuid support plus fix the kdev_t compilation failure.

06-E-cleanup.diff
    There is always place for Yet Another Cleanup of Reiserfs Code.


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





--- linux-2.5.3-pre4.o/fs/reiserfs/bitmap.c	Thu Jan 24 11:16:52 2002
+++ linux-2.5.3-pre4/fs/reiserfs/bitmap.c	Thu Jan 24 11:17:47 2002
@@ -498,12 +498,7 @@
     ** to be grouped towards the start of the border
     */
     border = le32_to_cpu(INODE_PKEY(p_s_inode)->k_dir_id) % (SB_BLOCK_COUNT(th->t_super) - bstart - 1) ;
-  } else {
-    /* why would we want to delcare a local variable to this if statement
-    ** name border????? -chris
-    ** unsigned long border = 0;
-    */
-    if (!reiserfs_hashed_relocation(th->t_super)) {
+  } else if (!reiserfs_hashed_relocation(th->t_super)) {
       hash_in = le32_to_cpu((INODE_PKEY(p_s_inode))->k_dir_id);
 				/* I wonder if the CPU cost of the
                                    hash will obscure the layout
@@ -513,7 +508,6 @@
       
       hash_out = keyed_hash(((char *) (&hash_in)), 4);
       border = hash_out % (SB_BLOCK_COUNT(th->t_super) - bstart - 1) ;
-    }
   }
   border += bstart ;
   allocated[0] = 0 ; /* important.  Allows a check later on to see if at
--- linux-2.5.3-pre4.o/fs/reiserfs/buffer2.c	Thu Jan 24 10:45:26 2002
+++ linux-2.5.3-pre4/fs/reiserfs/buffer2.c	Thu Jan 24 11:18:59 2002
@@ -2,15 +2,6 @@
  *  Copyright 2000 by Hans Reiser, licensing governed by reiserfs/README  
  */
 
-
-/*
- * Contains code from
- *
- *  linux/include/linux/lock.h and linux/fs/buffer.c /linux/fs/minix/fsync.c
- *
- *  Copyright (C) 1991, 1992  Linus Torvalds
- */
-
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/locks.h>
@@ -21,12 +12,8 @@
 /*
  *  wait_buffer_until_released
  *  reiserfs_bread
- *  reiserfs_getblk
- *  get_new_buffer
  */
 
-
-
 /* when we allocate a new block (get_new_buffer, get_empty_nodes) and
    get buffer for it, it is possible that it is held by someone else
    or even by this process. In this function we wait until all other
@@ -61,7 +48,6 @@
    then it creates a new buffer and schedules I/O to read the
    block. */
 /* The function is NOT SCHEDULE-SAFE! */
-
 struct buffer_head  * reiserfs_bread (struct super_block *super, int n_block) 
 {
     struct buffer_head  *result;
@@ -73,275 +59,4 @@
 	      PROC_INFO_INC( super, bread_miss ) );
     return result;
 }
-
-/* This function looks for a buffer which contains a given block.  If
-   the block is in cache it returns it, otherwise it returns a new
-   buffer which is not uptodate.  This is called by reiserfs_bread and
-   other functions. Note that get_new_buffer ought to be called this
-   and this ought to be called get_new_buffer, since this doesn't
-   actually get the block off of the disk. */
-/* The function is NOT SCHEDULE-SAFE! */
-
-struct buffer_head  * reiserfs_getblk(struct super_block *sb, int n_block)
-{
-    return sb_getblk(sb, n_block);
-}
-
-#ifdef NEW_GET_NEW_BUFFER
-
-/* returns one buffer with a blocknr near blocknr. */
-static int get_new_buffer_near_blocknr(
-                   struct super_block *  p_s_sb,
-                   int blocknr,
-                   struct buffer_head ** pp_s_new_bh,
-                   struct path         * p_s_path 
-                   ) {
-  unsigned      long n_new_blocknumber = 0;
-  int           n_ret_value,
-                n_repeat = CARRY_ON;
-
-#ifdef CONFIG_REISERFS_CHECK
-  int repeat_counter = 0;
-  
-  if (!blocknr)
-    printk ("blocknr passed to get_new_buffer_near_blocknr was 0");
-#endif
-
-
-  if ( (n_ret_value = reiserfs_new_blocknrs (p_s_sb, &n_new_blocknumber,
-                                             blocknr, 1)) == NO_DISK_SPACE )
-    return NO_DISK_SPACE;
-  
-  *pp_s_new_bh = reiserfs_getblk(p_s_sb, n_new_blocknumber);
-  if ( buffer_uptodate(*pp_s_new_bh) ) {
-
-    RFALSE( buffer_dirty(*pp_s_new_bh) || (*pp_s_new_bh)->b_dev == NODEV,
-	    "PAP-14080: invalid uptodate buffer %b for the new block", 
-	    *pp_s_new_bh);
-
-    /* Free path buffers to prevent deadlock. */
-    /* It is possible that this process has the buffer, which this function is getting, already in
-       its path, and is responsible for double incrementing the value of b_count.  If we recalculate
-       the path after schedule we can avoid risking an endless loop.  This problematic situation is
-       possible in a multiple processing environment.  Suppose process 1 has acquired a path P; then
-       process 2 balanced and remove block A from the tree.  Process 1 continues and runs
-       get_new_buffer, that returns buffer with block A. If node A was on the path P, then it will
-       have b_count == 2. If we now will simply wait in while ( (*pp_s_new_bh)->b_count > 1 ) we get
-       into an endless loop, as nobody will release this buffer and the current process holds buffer
-       twice. That is why we do decrement_counters_in_path(p_s_path) before waiting until b_count
-       becomes 1. (it there were other processes holding node A, then eventually we will get a
-       moment, when all of them released a buffer). */
-    if ( atomic_read (&((*pp_s_new_bh)->b_count)) > 1  ) {
-      decrement_counters_in_path(p_s_path);
-      n_ret_value |= SCHEDULE_OCCURRED;
-    }
-
-    while ( atomic_read (&((*pp_s_new_bh)->b_count)) > 1 ) {
-
-#ifdef REISERFS_INFO
-      printk("get_new_buffer() calls schedule to decrement b_count\n");
-#endif
-
-#ifdef CONFIG_REISERFS_CHECK
-      if ( ! (++repeat_counter % 10000) )
-	printk("get_new_buffer(%u): counter(%d) too big", current->pid, repeat_counter);
-#endif
-      yield();
-    }
-
-#ifdef CONFIG_REISERFS_CHECK
-    if ( buffer_dirty(*pp_s_new_bh) || (*pp_s_new_bh)->b_dev == NODEV ) {
-      print_buffer_head(*pp_s_new_bh,"get_new_buffer");
-      reiserfs_panic(p_s_sb, "PAP-14090: get_new_buffer: invalid uptodate buffer %b for the new block(case 2)", *pp_s_new_bh);
-    }
-#endif
-
-  }
-  else {
-    ;
-
-    RFALSE( atomic_read (&((*pp_s_new_bh)->b_count)) != 1,
-	    "PAP-14100: not uptodate buffer %b for the new block has b_count more than one",
-	    *pp_s_new_bh);
-
-  }
-  return (n_ret_value | n_repeat);
-}
-
-
-/* returns the block number of the last unformatted node, assumes p_s_key_to_search.k_offset is a byte in the tail of
-   the file, Useful for when you want to append to a file, and convert a direct item into an unformatted node near the
-   last unformatted node of the file.  Putting the unformatted node near the direct item is potentially very bad to do.
-   If there is no unformatted node in the file, then we return the block number of the direct item.  */
-/* The function is NOT SCHEDULE-SAFE! */
-inline int get_last_unformatted_node_blocknr_of_file(  struct key * p_s_key_to_search, struct super_block * p_s_sb,
-                                                       struct buffer_head * p_s_bh
-                                                       struct path * p_unf_search_path, struct inode * p_s_inode)
-
-{
-  struct key unf_key_to_search;
-  struct item_head * p_s_ih;
-  int n_pos_in_item;
-  struct buffer_head * p_indirect_item_bh;
-
-      copy_key(&unf_key_to_search,p_s_key_to_search);
-      unf_key_to_search.k_uniqueness = TYPE_INDIRECT;
-      unf_key_to_search.k_offset = REISERFS_I(p_s_inode)->i_first_direct_byte - 1;
-
-        /* p_s_key_to_search->k_offset -  MAX_ITEM_LEN(p_s_sb->s_blocksize); */
-      if (search_for_position_by_key (p_s_sb, &unf_key_to_search, p_unf_search_path, &n_pos_in_item) == POSITION_FOUND)
-        {
-          p_s_ih = B_N_PITEM_HEAD(p_indirect_item_bh = PATH_PLAST_BUFFER(p_unf_search_path), PATH_LAST_POSITION(p_unf_search_path));
-          return (B_I_POS_UNFM_POINTER(p_indirect_item_bh, p_s_ih, n_pos_in_item));
-        }
-     /*  else */
-      printk("reiser-1800: search for unformatted node failed, p_s_key_to_search->k_offset = %u,  unf_key_to_search.k_offset = %u, MAX_ITEM_LEN(p_s_sb->s_blocksize) = %ld, debug this\n", p_s_key_to_search->k_offset, unf_key_to_search.k_offset,  MAX_ITEM_LEN(p_s_sb->s_blocksize) );
-      print_buffer_head(PATH_PLAST_BUFFER(p_unf_search_path), "the buffer holding the item before the key we failed to find");
-      print_block_head(PATH_PLAST_BUFFER(p_unf_search_path), "the block head");
-      return 0;                         /* keeps the compiler quiet */
-}
-
-
-                                /* hasn't been out of disk space tested  */
-/* The function is NOT SCHEDULE-SAFE! */
-static int get_buffer_near_last_unf ( struct super_block * p_s_sb, struct key * p_s_key_to_search,
-                                                 struct inode *  p_s_inode,  struct buffer_head * p_s_bh, 
-                                                 struct buffer_head ** pp_s_un_bh, struct path * p_s_search_path)
-{
-  int unf_blocknr = 0, /* blocknr from which we start search for a free block for an unformatted node, if 0
-                          then we didn't find an unformatted node though we might have found a file hole */
-      n_repeat = CARRY_ON;
-  struct key unf_key_to_search;
-  struct path unf_search_path;
-
-  copy_key(&unf_key_to_search,p_s_key_to_search);
-  unf_key_to_search.k_uniqueness = TYPE_INDIRECT;
-  
-  if (
-      (REISERFS_I(p_s_inode)->i_first_direct_byte > 4095) /* i_first_direct_byte gets used for all sorts of
-                                                              crap other than what the name indicates, thus
-                                                              testing to see if it is 0 is not enough */
-      && (REISERFS_I(p_s_inode)->i_first_direct_byte < MAX_KEY_OFFSET) /* if there is no direct item then
-                                                                           i_first_direct_byte = MAX_KEY_OFFSET */
-      )
-    {
-                                /* actually, we don't want the last unformatted node, we want the last unformatted node
-                                   which is before the current file offset */
-      unf_key_to_search.k_offset = ((REISERFS_I(p_s_inode)->i_first_direct_byte -1) < unf_key_to_search.k_offset) ? REISERFS_I(p_s_inode)->i_first_direct_byte -1 :  unf_key_to_search.k_offset;
-
-      while (unf_key_to_search.k_offset > -1)
-        {
-                                /* This is our poorly documented way of initializing paths. -Hans */
-          init_path (&unf_search_path);
-                                /* get the blocknr from which we start the search for a free block. */
-          unf_blocknr = get_last_unformatted_node_blocknr_of_file(  p_s_key_to_search, /* assumes this points to the file tail */
-                                                                    p_s_sb,     /* lets us figure out the block size */
-                                                                    p_s_bh, /* if there is no unformatted node in the file,
-                                                                               then it returns p_s_bh->b_blocknr */
-                                                                    &unf_search_path,
-                                                                    p_s_inode
-                                                                    );
-/*        printk("in while loop: unf_blocknr = %d,  *pp_s_un_bh = %p\n", unf_blocknr, *pp_s_un_bh); */
-          if (unf_blocknr) 
-            break;
-          else                  /* release the path and search again, this could be really slow for huge
-                                   holes.....better to spend the coding time adding compression though.... -Hans */
-            {
-                                /* Vladimir, is it a problem that I don't brelse these buffers ?-Hans */
-              decrement_counters_in_path(&unf_search_path);
-              unf_key_to_search.k_offset -= 4096;
-            }
-        }
-      if (unf_blocknr) {
-        n_repeat |= get_new_buffer_near_blocknr(p_s_sb, unf_blocknr, pp_s_un_bh, p_s_search_path);
-      }
-      else {                    /* all unformatted nodes are holes */
-        n_repeat |= get_new_buffer_near_blocknr(p_s_sb, p_s_bh->b_blocknr, pp_s_un_bh, p_s_search_path); 
-      }
-    }
-  else {                        /* file has no unformatted nodes */
-    n_repeat |= get_new_buffer_near_blocknr(p_s_sb, p_s_bh->b_blocknr, pp_s_un_bh, p_s_search_path);
-/*     printk("in else: unf_blocknr = %d,  *pp_s_un_bh = %p\n", unf_blocknr, *pp_s_un_bh); */
-/*     print_path (0,  p_s_search_path); */
-  }
-
-  return n_repeat;
-}
-
-#endif /* NEW_GET_NEW_BUFFER */
-
-
-#ifdef OLD_GET_NEW_BUFFER
-
-/* The function is NOT SCHEDULE-SAFE! */
-int get_new_buffer(
-		   struct reiserfs_transaction_handle *th, 
-		   struct buffer_head *  p_s_bh,
-		   struct buffer_head ** pp_s_new_bh,
-		   struct path	       * p_s_path
-		   ) {
-  unsigned	long n_new_blocknumber = 0;
-  int		n_repeat;
-  struct super_block *	 p_s_sb = th->t_super;
-
-  if ( (n_repeat = reiserfs_new_unf_blocknrs (th, &n_new_blocknumber, p_s_bh->b_blocknr)) == NO_DISK_SPACE )
-    return NO_DISK_SPACE;
-  
-  *pp_s_new_bh = reiserfs_getblk(p_s_sb, n_new_blocknumber);
-  if (atomic_read (&(*pp_s_new_bh)->b_count) > 1) {
-    /* Free path buffers to prevent deadlock which can occur in the
-       situation like : this process holds p_s_path; Block
-       (*pp_s_new_bh)->b_blocknr is on the path p_s_path, but it is
-       not necessary, that *pp_s_new_bh is in the tree; process 2
-       could remove it from the tree and freed block
-       (*pp_s_new_bh)->b_blocknr. Reiserfs_new_blocknrs in above
-       returns block (*pp_s_new_bh)->b_blocknr. Reiserfs_getblk gets
-       buffer for it, and it has b_count > 1. If we now will simply
-       wait in while ( (*pp_s_new_bh)->b_count > 1 ) we get into an
-       endless loop, as nobody will release this buffer and the
-       current process holds buffer twice. That is why we do
-       decrement_counters_in_path(p_s_path) before waiting until
-       b_count becomes 1. (it there were other processes holding node
-       pp_s_new_bh, then eventually we will get a moment, when all of
-       them released a buffer). */
-    decrement_counters_in_path(p_s_path);
-    wait_buffer_until_released (*pp_s_new_bh);
-    n_repeat |= SCHEDULE_OCCURRED;
-  }
-
-  RFALSE( atomic_read (&((*pp_s_new_bh)->b_count)) != 1 || 
-	  buffer_dirty (*pp_s_new_bh),
-	  "PAP-14100: not free or dirty buffer %b for the new block", 
-	  *pp_s_new_bh);
-
-  return n_repeat;
-}
-
-#endif /* OLD_GET_NEW_BUFFER */
-
-
-#ifdef GET_MANY_BLOCKNRS
-                                /* code not yet functional */
-get_next_blocknr (
-                  unsigned long *       p_blocknr_array,          /* we get a whole bunch of blocknrs all at once for
-                                                                     the write.  This is better than getting them one at
-                                                                     a time.  */
-                  unsigned long **      p_blocknr_index,        /* pointer to current offset into the array. */
-                  unsigned long        blocknr_array_length
-)
-{
-  unsigned long return_value;
-
-  if (*p_blocknr_index < p_blocknr_array + blocknr_array_length) {
-    return_value = **p_blocknr_index;
-    **p_blocknr_index = 0;
-    *p_blocknr_index++;
-    return (return_value);
-  }
-  else
-    {
-      kfree (p_blocknr_array);
-    }
-}
-#endif /* GET_MANY_BLOCKNRS */
 
--- linux-2.5.3-pre4.o/fs/reiserfs/dir.c	Wed Oct 31 02:11:34 2001
+++ linux-2.5.3-pre4/fs/reiserfs/dir.c	Thu Jan 24 11:17:47 2002
@@ -22,22 +22,6 @@
     fsync:	reiserfs_dir_fsync,
 };
 
-/*
- * directories can handle most operations...
- */
-struct inode_operations reiserfs_dir_inode_operations = {
-  //&reiserfs_dir_operations,	/* default_file_ops */
-    create:	reiserfs_create,
-    lookup:	reiserfs_lookup,
-    link:	reiserfs_link,
-    unlink:	reiserfs_unlink,
-    symlink:	reiserfs_symlink,
-    mkdir:	reiserfs_mkdir,
-    rmdir:	reiserfs_rmdir,
-    mknod:	reiserfs_mknod,
-    rename:	reiserfs_rename,
-};
-
 int reiserfs_dir_fsync(struct file *filp, struct dentry *dentry, int datasync) {
   lock_kernel();
   reiserfs_commit_for_inode(dentry->d_inode) ;
@@ -197,4 +181,72 @@
     pathrelse (&path_to_entry);
     reiserfs_check_path(&path_to_entry) ;
     return 0;
+}
+
+/* compose directory item containing "." and ".." entries (entries are
+   not aligned to 4 byte boundary) */
+/* the last four params are LE */
+void make_empty_dir_item_v1 (char * body, __u32 dirid, __u32 objid,
+			     __u32 par_dirid, __u32 par_objid)
+{
+    struct reiserfs_de_head * deh;
+
+    memset (body, 0, EMPTY_DIR_SIZE_V1);
+    deh = (struct reiserfs_de_head *)body;
+    
+    /* direntry header of "." */
+    put_deh_offset( &(deh[0]), DOT_OFFSET );
+    /* these two are from make_le_item_head, and are are LE */
+    deh[0].deh_dir_id = dirid;
+    deh[0].deh_objectid = objid;
+    deh[0].deh_state = 0; /* Endian safe if 0 */
+    put_deh_location( &(deh[0]), EMPTY_DIR_SIZE_V1 - strlen( "." ));
+    mark_de_visible(&(deh[0]));
+  
+    /* direntry header of ".." */
+    put_deh_offset( &(deh[1]), DOT_DOT_OFFSET);
+    /* key of ".." for the root directory */
+    /* these two are from the inode, and are are LE */
+    deh[1].deh_dir_id = par_dirid;
+    deh[1].deh_objectid = par_objid;
+    deh[1].deh_state = 0; /* Endian safe if 0 */
+    put_deh_location( &(deh[1]), deh_location( &(deh[0]) ) - strlen( ".." ) );
+    mark_de_visible(&(deh[1]));
+
+    /* copy ".." and "." */
+    memcpy (body + deh_location( &(deh[0]) ), ".", 1);
+    memcpy (body + deh_location( &(deh[1]) ), "..", 2);
+}
+
+/* compose directory item containing "." and ".." entries */
+void make_empty_dir_item (char * body, __u32 dirid, __u32 objid,
+			  __u32 par_dirid, __u32 par_objid)
+{
+    struct reiserfs_de_head * deh;
+
+    memset (body, 0, EMPTY_DIR_SIZE);
+    deh = (struct reiserfs_de_head *)body;
+    
+    /* direntry header of "." */
+    put_deh_offset( &(deh[0]), DOT_OFFSET );
+    /* these two are from make_le_item_head, and are are LE */
+    deh[0].deh_dir_id = dirid;
+    deh[0].deh_objectid = objid;
+    deh[0].deh_state = 0; /* Endian safe if 0 */
+    put_deh_location( &(deh[0]), EMPTY_DIR_SIZE - ROUND_UP( strlen( "." ) ) );
+    mark_de_visible(&(deh[0]));
+  
+    /* direntry header of ".." */
+    put_deh_offset( &(deh[1]), DOT_DOT_OFFSET );
+    /* key of ".." for the root directory */
+    /* these two are from the inode, and are are LE */
+    deh[1].deh_dir_id = par_dirid;
+    deh[1].deh_objectid = par_objid;
+    deh[1].deh_state = 0; /* Endian safe if 0 */
+    put_deh_location( &(deh[1]), deh_location( &(deh[0])) - ROUND_UP( strlen( ".." ) ) );
+    mark_de_visible(&(deh[1]));
+
+    /* copy ".." and "." */
+    memcpy (body + deh_location( &(deh[0]) ), ".", 1);
+    memcpy (body + deh_location( &(deh[1]) ), "..", 2);
 }
--- linux-2.5.3-pre4.o/fs/reiserfs/do_balan.c	Sat Nov 10 01:18:25 2001
+++ linux-2.5.3-pre4/fs/reiserfs/do_balan.c	Thu Jan 24 11:17:47 2002
@@ -274,13 +274,6 @@
     int pos_in_item;
     int zeros_num;
 
-#if 0
-    if (tb->insert_size [0] % 4) {
-	reiserfs_panic (tb->tb_sb, "balance_leaf: wrong insert_size %d", 
-			tb->insert_size [0]);
-    }
-#endif
-
     PROC_INFO_INC( tb -> tb_sb, balance_at[ 0 ] );
 
     /* Make balance in case insert_size[0] < 0 */
--- linux-2.5.3-pre4.o/fs/reiserfs/fix_node.c	Fri Jan 18 15:01:36 2002
+++ linux-2.5.3-pre4/fs/reiserfs/fix_node.c	Thu Jan 24 11:17:47 2002
@@ -806,7 +806,7 @@
     RFALSE( ! *p_n_blocknr,
 	    "PAP-8135: reiserfs_new_blocknrs failed when got new blocks");
 
-    p_s_new_bh = reiserfs_getblk(p_s_sb, *p_n_blocknr);
+    p_s_new_bh = sb_getblk(p_s_sb, *p_n_blocknr);
     if (atomic_read (&(p_s_new_bh->b_count)) > 1) {
 /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
 /*
@@ -2021,23 +2021,6 @@
   // entry would eat 2 byte of virtual node space
   return sb->s_blocksize;
 
-#if 0
-  size = sizeof (struct virtual_node) + sizeof (struct virtual_item);
-  ih = B_N_PITEM_HEAD (bh, 0);
-  nr_items = B_NR_ITEMS (bh);
-  for (i = 0; i < nr_items; i ++, ih ++) {
-    /* each item occupies some space in virtual node */
-    size += sizeof (struct virtual_item);
-    if (is_direntry_le_ih (ih))
-      /* each entry and new one occupeis 2 byte in the virtual node */
-      size += (ih_entry_count(ih) + 1) * sizeof( __u16 );
-  }
-  
-  /* 1 bit for each bitmap block to note whether bitmap block was
-     dirtied in the operation */
- /* size += (SB_BMAP_NR (sb) * 2 / 8 + 4);*/
-  return size;
-#endif
 }
 
 
@@ -2342,15 +2325,6 @@
 	reiserfs_panic (p_s_tb->tb_sb, "PAP-8320: fix_nodes: S[0] (%b %z) is not uptodate "
 			"at the beginning of fix_nodes or not in tree (mode %c)", p_s_tbS0, p_s_tbS0, n_op_mode);
     }
-
-    // FIXME: new items have to be of 8 byte multiples. Including new
-    // directory items those look like old ones
-    /*
-    if (p_s_tb->insert_size[0] % 8)
-	reiserfs_panic (p_s_tb->tb_sb, "vs-: fix_nodes: incorrect insert_size %d, "
-			"mode %c",
-			p_s_tb->insert_size[0], n_op_mode);
-    */
 
     /* Check parameters. */
     switch (n_op_mode) {
--- linux-2.5.3-pre4.o/fs/reiserfs/inode.c	Thu Jan 24 11:15:25 2002
+++ linux-2.5.3-pre4/fs/reiserfs/inode.c	Thu Jan 24 11:17:47 2002
@@ -17,6 +17,8 @@
 #define GET_BLOCK_READ_DIRECT 4  /* read the tail if indirect item not found */
 #define GET_BLOCK_NO_ISEM     8 /* i_sem is not held, don't preallocate */
 
+static int reiserfs_get_block (struct inode * inode, sector_t block,
+			       struct buffer_head * bh_result, int create);
 //
 // initially this function was derived from minix or ext2's analog and
 // evolved as the prototype did
@@ -1183,7 +1185,7 @@
 }
 
 struct dentry *reiserfs_fh_to_dentry(struct super_block *sb, __u32 *data,
-                                     int len, int fhtype, int parent) {
+				     int len, int fhtype, int parent) {
     struct cpu_key key ;
     struct inode *inode = NULL ;
     struct list_head *lp;
@@ -1323,26 +1325,6 @@
 	unlock_kernel() ;
     }
 }
-
-void reiserfs_dirty_inode (struct inode * inode) {
-    struct reiserfs_transaction_handle th ;
-
-    if (inode->i_sb->s_flags & MS_RDONLY) {
-        reiserfs_warning("clm-6006: writing inode %lu on readonly FS\n", 
-	                  inode->i_ino) ;
-        return ;
-    }
-    lock_kernel() ;
-
-    /* this is really only used for atime updates, so they don't have
-    ** to be included in O_SYNC or fsync
-    */
-    journal_begin(&th, inode->i_sb, 1) ;
-    reiserfs_update_sd (&th, inode);
-    journal_end(&th, inode->i_sb, 1) ;
-    unlock_kernel() ;
-}
-
 
 /* FIXME: no need any more. right? */
 int reiserfs_sync_inode (struct reiserfs_transaction_handle *th, struct inode * inode)
--- linux-2.5.3-pre4.o/fs/reiserfs/journal.c	Thu Jan 24 11:11:40 2002
+++ linux-2.5.3-pre4/fs/reiserfs/journal.c	Thu Jan 24 11:17:47 2002
@@ -2522,20 +2522,6 @@
 int show_reiserfs_locks(void) {
 
   dump_journal_writers() ;
-#if 0 /* debugging code for when we are compiled static don't delete */
-  p_s_sb = sb_entry(super_blocks.next);
-  while (p_s_sb != sb_entry(&super_blocks)) {
-    if (reiserfs_is_super(p_s_sb)) {
-printk("journal lock is %d, join lock is %d, writers %d must wait is %d\n", 
-        atomic_read(&(SB_JOURNAL(p_s_sb)->j_wlock)),
-        atomic_read(&(SB_JOURNAL(p_s_sb)->j_jlock)),
-	atomic_read(&(SB_JOURNAL(p_s_sb)->j_wcount)),
-	SB_JOURNAL(p_s_sb)->j_must_wait) ;
-	printk("used cnodes %d, free cnodes %d\n", SB_JOURNAL(p_s_sb)->j_cnode_used, SB_JOURNAL(p_s_sb)->j_cnode_free) ;
-    }
-    p_s_sb = sb_entry(p_s_sb->s_list.next);
-  }
-#endif
   return 0 ;
 }
 
--- linux-2.5.3-pre4.o/fs/reiserfs/namei.c	Wed Jan 23 13:10:03 2002
+++ linux-2.5.3-pre4/fs/reiserfs/namei.c	Thu Jan 24 11:17:47 2002
@@ -17,17 +17,6 @@
 #include <linux/reiserfs_fs.h>
 #include <linux/smp_lock.h>
 
-				/* there should be an overview right
-                                   here, as there should be in every
-                                   conceptual grouping of code.  This
-                                   should be combined with dir.c and
-                                   called dir.c (naming will become
-                                   too large to be called one file in
-                                   a few years), stop senselessly
-                                   imitating the incoherent
-                                   structuring of code used by other
-                                   filesystems.  */
-
 #define INC_DIR_INODE_NLINK(i) if (i->i_nlink != 1) { i->i_nlink++; if (i->i_nlink >= REISERFS_LINK_MAX) i->i_nlink=1; }
 #define DEC_DIR_INODE_NLINK(i) if (i->i_nlink != 1) i->i_nlink--;
 
@@ -347,7 +336,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-struct dentry * reiserfs_lookup (struct inode * dir, struct dentry * dentry)
+static struct dentry * reiserfs_lookup (struct inode * dir, struct dentry * dentry)
 {
     int retval;
     struct inode * inode = 0;
@@ -373,7 +362,6 @@
     return NULL;
 }
 
-
 //
 // a portion of this function, particularly the VFS interface portion,
 // was derived from minix or ext2's analog and evolved as the
@@ -518,7 +506,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-int reiserfs_create (struct inode * dir, struct dentry *dentry, int mode)
+static int reiserfs_create (struct inode * dir, struct dentry *dentry, int mode)
 {
     int retval;
     struct inode * inode;
@@ -574,7 +562,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-int reiserfs_mknod (struct inode * dir, struct dentry *dentry, int mode, int rdev)
+static int reiserfs_mknod (struct inode * dir, struct dentry *dentry, int mode, int rdev)
 {
     int retval;
     struct inode * inode;
@@ -629,7 +617,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-int reiserfs_mkdir (struct inode * dir, struct dentry *dentry, int mode)
+static int reiserfs_mkdir (struct inode * dir, struct dentry *dentry, int mode)
 {
     int retval;
     struct inode * inode;
@@ -708,7 +696,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-int reiserfs_rmdir (struct inode * dir, struct dentry *dentry)
+static int reiserfs_rmdir (struct inode * dir, struct dentry *dentry)
 {
     int retval;
     struct inode * inode;
@@ -785,7 +773,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-int reiserfs_unlink (struct inode * dir, struct dentry *dentry)
+static int reiserfs_unlink (struct inode * dir, struct dentry *dentry)
 {
     int retval;
     struct inode * inode;
@@ -855,7 +843,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-int reiserfs_symlink (struct inode * dir, struct dentry * dentry, const char * symname)
+static int reiserfs_symlink (struct inode * dir, struct dentry * dentry, const char * symname)
 {
     int retval;
     struct inode * inode;
@@ -932,7 +920,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-int reiserfs_link (struct dentry * old_dentry, struct inode * dir, struct dentry * dentry)
+static int reiserfs_link (struct dentry * old_dentry, struct inode * dir, struct dentry * dentry)
 {
     int retval;
     struct inode *inode = old_dentry->d_inode;
@@ -1032,8 +1020,8 @@
  * one path. If it holds 2 or more, it can get into endless waiting in
  * get_empty_nodes or its clones 
  */
-int reiserfs_rename (struct inode * old_dir, struct dentry *old_dentry,
-		     struct inode * new_dir, struct dentry *new_dentry)
+static int reiserfs_rename (struct inode * old_dir, struct dentry *old_dentry,
+			    struct inode * new_dir, struct dentry *new_dentry)
 {
     int retval;
     INITIALIZE_PATH (old_entry_path);
@@ -1096,8 +1084,8 @@
 	// FIXME: is it possible, that new_inode == 0 here? If yes, it
 	// is not clear how does ext2 handle that
 	if (!new_inode) {
-	    printk ("reiserfs_rename: new entry is found, new inode == 0\n");
-	    BUG ();
+	    reiserfs_panic (old_dir->i_sb,
+			    "vs-7050: new entry is found, new inode == 0\n");
 	}
     } else if (retval) {
 	pop_journal_writer(windex) ;
@@ -1164,11 +1152,6 @@
 	    reiserfs_restore_prepared_buffer (old_inode->i_sb, new_de.de_bh);
 	    if (S_ISDIR(old_inode->i_mode))
 		reiserfs_restore_prepared_buffer (old_inode->i_sb, dot_dot_de.de_bh);
-#if 0
-	    // FIXME: do we need this? shouldn't we simply continue?
-	    run_task_queue(&tq_disk);
-	    yield();
-#endif
 	    continue;
 	}
 
@@ -1226,7 +1209,7 @@
     // anybody, but it will panic if will not be able to find the
     // entry. This needs one more clean up
     if (reiserfs_cut_from_item (&th, &old_entry_path, &(old_de.de_entry_key), old_dir, NULL, 0) < 0)
-	reiserfs_warning ("vs-: reiserfs_rename: coudl not cut old name. Fsck later?\n");
+	reiserfs_warning ("vs-7060: reiserfs_rename: couldn't not cut old name. Fsck later?\n");
 
     old_dir->i_size -= DEH_SIZE + old_de.de_entrylen;
     old_dir->i_blocks = ((old_dir->i_size + 511) >> 9);
@@ -1240,4 +1223,20 @@
     journal_end(&th, old_dir->i_sb, jbegin_count) ;
     return 0;
 }
+
+/*
+ * directories can handle most operations...
+ */
+struct inode_operations reiserfs_dir_inode_operations = {
+  //&reiserfs_dir_operations,	/* default_file_ops */
+    create:	reiserfs_create,
+    lookup:	reiserfs_lookup,
+    link:	reiserfs_link,
+    unlink:	reiserfs_unlink,
+    symlink:	reiserfs_symlink,
+    mkdir:	reiserfs_mkdir,
+    rmdir:	reiserfs_rmdir,
+    mknod:	reiserfs_mknod,
+    rename:	reiserfs_rename,
+};
 
--- linux-2.5.3-pre4.o/fs/reiserfs/stree.c	Thu Jan 24 11:16:55 2002
+++ linux-2.5.3-pre4/fs/reiserfs/stree.c	Thu Jan 24 11:17:47 2002
@@ -604,7 +604,7 @@
     if (blocknr == 0)
 	return;
 
-    bh = reiserfs_getblk (s, blocknr);
+    bh = sb_getblk (s, blocknr);
   
     if (!buffer_uptodate (bh)) {
 	ll_rw_block (READA, 1, &bh);
@@ -1328,13 +1328,13 @@
     while (1) {
 	retval = search_item (th->t_super, &cpu_key, &path);
 	if (retval == IO_ERROR) {
-	    reiserfs_warning ("vs-: reiserfs_delete_solid_item: "
+	    reiserfs_warning ("vs-5350: reiserfs_delete_solid_item: "
 			      "i/o failure occurred trying to delete %K\n", &cpu_key);
 	    break;
 	}
 	if (retval != ITEM_FOUND) {
 	    pathrelse (&path);
-	    reiserfs_warning ("vs-: reiserfs_delete_solid_item: %k not found",
+	    reiserfs_warning ("vs-5355: reiserfs_delete_solid_item: %k not found",
 			      key);
 	    break;
 	}
@@ -1354,7 +1354,7 @@
 	}
 
 	// IO_ERROR, NO_DISK_SPACE, etc
-	reiserfs_warning ("vs-: reiserfs_delete_solid_item: "
+	reiserfs_warning ("vs-5360: reiserfs_delete_solid_item: "
 			  "could not delete %K due to fix_nodes failure\n", &cpu_key);
 	unfix_nodes (&tb);
 	break;
@@ -1371,15 +1371,6 @@
     /* for directory this deletes item containing "." and ".." */
     reiserfs_do_truncate (th, inode, NULL, 0/*no timestamp updates*/);
     
-    /* delete stat data */
-    /* this debug code needs to go away.  Trying to find a truncate race
-    ** -- clm -- 4/1/2000
-    */
-#if 0
-    if (inode->i_nlink != 0) {
-        reiserfs_warning("clm-4001: deleting inode with link count==%d\n", inode->i_nlink) ;
-    }
-#endif
 #if defined( USE_INODE_GENERATION_COUNTER )
     if( !old_format_only ( th -> t_super ) )
       {
--- linux-2.5.3-pre4.o/fs/reiserfs/super.c	Thu Jan 24 11:11:41 2002
+++ linux-2.5.3-pre4/fs/reiserfs/super.c	Thu Jan 24 11:17:47 2002
@@ -55,6 +55,9 @@
 	  is_reiserfs_jr (rs));
 }
 
+static int reiserfs_remount (struct super_block * s, int * flags, char * data);
+static int reiserfs_statfs (struct super_block * s, struct statfs * buf);
+
 //
 // a portion of this function, particularly the VFS interface portion,
 // was derived from minix or ext2's analog and evolved as the
@@ -62,7 +65,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-void reiserfs_write_super (struct super_block * s)
+static void reiserfs_write_super (struct super_block * s)
 {
 
   int dirty = 0 ;
@@ -81,7 +84,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-void reiserfs_write_super_lockfs (struct super_block * s)
+static void reiserfs_write_super_lockfs (struct super_block * s)
 {
 
   int dirty = 0 ;
@@ -109,7 +112,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-void reiserfs_put_super (struct super_block * s)
+static void reiserfs_put_super (struct super_block * s)
 {
   int i;
   struct reiserfs_transaction_handle th ;
@@ -196,6 +199,26 @@
 		printk(KERN_INFO "reiserfs_inode_cache: not all structures were freed\n");
 }
 
+/* we don't mark inodes dirty, we just log them */
+static void reiserfs_dirty_inode (struct inode * inode) {
+    struct reiserfs_transaction_handle th ;
+
+    if (inode->i_sb->s_flags & MS_RDONLY) {
+        reiserfs_warning("clm-6006: writing inode %lu on readonly FS\n", 
+	                  inode->i_ino) ;
+        return ;
+    }
+    lock_kernel() ;
+
+    /* this is really only used for atime updates, so they don't have
+    ** to be included in O_SYNC or fsync
+    */
+    journal_begin(&th, inode->i_sb, 1) ;
+    reiserfs_update_sd (&th, inode);
+    journal_end(&th, inode->i_sb, 1) ;
+    unlock_kernel() ;
+}
+
 struct super_operations reiserfs_sops = 
 {
   alloc_inode: reiserfs_alloc_inode,
@@ -313,7 +336,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-int reiserfs_remount (struct super_block * s, int * flags, char * data)
+static int reiserfs_remount (struct super_block * s, int * flags, char * data)
 {
   struct reiserfs_super_block * rs;
   struct reiserfs_transaction_handle th ;
@@ -690,7 +713,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-struct super_block * reiserfs_read_super (struct super_block * s, void * data, int silent)
+static struct super_block * reiserfs_read_super (struct super_block * s, void * data, int silent)
 {
     int size;
     struct inode *root_inode;
@@ -855,7 +878,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-int reiserfs_statfs (struct super_block * s, struct statfs * buf)
+static int reiserfs_statfs (struct super_block * s, struct statfs * buf)
 {
   struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK (s);
   
--- linux-2.5.3-pre4.o/include/linux/reiserfs_fs.h	Thu Jan 24 11:11:41 2002
+++ linux-2.5.3-pre4/include/linux/reiserfs_fs.h	Thu Jan 24 11:25:22 2002
@@ -53,48 +53,17 @@
 
 */
 
-				/* Vladimir, what is the story with
-                                   new_get_new_buffer nowadays?  I
-                                   want a complete explanation written
-                                   here. */
-
-/* NEW_GET_NEW_BUFFER will try to allocate new blocks better */
-/*#define NEW_GET_NEW_BUFFER*/
-#define OLD_GET_NEW_BUFFER
-
-				/* Vladimir, what about this one too? */
-/* if this is undefined, all inode changes get into stat data immediately, if it can be found in RAM */
-#define DIRTY_LATER
-
-/* enable journalling */
-#define ENABLE_JOURNAL
-
 #define USE_INODE_GENERATION_COUNTER
 
-
-#ifdef __KERNEL__
-
-/* #define REISERFS_CHECK */
-
 #define REISERFS_PREALLOCATE
-#endif
 #define PREALLOCATION_SIZE 8
 
-/* if this is undefined, all inode changes get into stat data
-   immediately, if it can be found in RAM */
-#define DIRTY_LATER
-
-
-/*#define READ_LOCK_REISERFS*/
-
-
 /* n must be power of 2 */
 #define _ROUND_UP(x,n) (((x)+(n)-1u) & ~((n)-1u))
 
 // to be ok for alpha and others we have to align structures to 8 byte
 // boundary.
 // FIXME: do not change 4 by anything else: there is code which relies on that
-				/* what 4? -Hans */
 #define ROUND_UP(x) _ROUND_UP(x,8LL)
 
 /* debug levels.  Right now, CONFIG_REISERFS_CHECK means print all debug
@@ -276,17 +245,11 @@
 int is_reiserfs_3_6 (struct reiserfs_super_block * rs);
 int is_reiserfs_jr (struct reiserfs_super_block * rs);
 
-
-
-				/* ReiserFS leaves the first 64k unused,
-                                   so that partition labels have enough
-                                   space.  If someone wants to write a
-                                   fancy bootloader that needs more than
-                                   64k, let us know, and this will be
-                                   increased in size.  This number must
-                                   be larger than than the largest block
-                                   size on any platform, or code will
-                                   break.  -Hans */
+/* ReiserFS leaves the first 64k unused, so that partition labels have
+   enough space.  If someone wants to write a fancy bootloader that
+   needs more than 64k, let us know, and this will be increased in size.
+   This number must be larger than than the largest block size on any
+   platform, or code will break.  -Hans */
 #define REISERFS_DISK_OFFSET_IN_BYTES (64 * 1024)
 #define REISERFS_FIRST_BLOCK unused_define
 #define REISERFS_JOURNAL_OFFSET_IN_BYTES REISERFS_DISK_OFFSET_IN_BYTES
@@ -294,7 +257,6 @@
 /* the spot for the super in versions 3.5 - 3.5.10 (inclusive) */
 #define REISERFS_OLD_DISK_OFFSET_IN_BYTES (8 * 1024)
 
-
 // reiserfs internal error code (used by search_by_key adn fix_nodes))
 #define CARRY_ON      0
 #define REPEAT_SEARCH -1
@@ -303,38 +265,14 @@
 #define NO_BALANCING_NEEDED  (-4)
 #define NO_MORE_UNUSED_CONTIGUOUS_BLOCKS (-5)
 
-//#define SCHEDULE_OCCURRED  	1
-//#define PATH_INCORRECT    	2
-
-//#define NO_DISK_SPACE        (-1)
-
-
-
 typedef unsigned long b_blocknr_t;
 typedef __u32 unp_t;
 
-				/* who is responsible for this
-                                   completely uncommented struct? */
 struct unfm_nodeinfo {
-				/* This is what? */
     unp_t unfm_nodenum;
-				/* now this I know what it is, and
-                                   most of the people on our project
-                                   know what it is, but I bet nobody
-                                   new I hire will have a clue. */
     unsigned short unfm_freespace;
 };
 
-
-/* when reiserfs_file_write is called with a byte count >= MIN_PACK_ON_CLOSE,
-** it sets the inode to pack on close, and when extending the file, will only
-** use unformatted nodes.
-**
-** This is a big speed up for the journal, which is badly hurt by direct->indirect
-** conversions (they must be logged).
-*/
-#define MIN_PACK_ON_CLOSE		512
-
 static inline struct reiserfs_inode_info *REISERFS_I(struct inode *inode)
 {
 	return list_entry(inode, struct reiserfs_inode_info, vfs_inode);
@@ -344,16 +282,16 @@
 #define inode_items_version(inode) (REISERFS_I(inode)->i_version)
 
 
-  /* This is an aggressive tail suppression policy, I am hoping it
-     improves our benchmarks. The principle behind it is that
-     percentage space saving is what matters, not absolute space
-     saving.  This is non-intuitive, but it helps to understand it if
-     you consider that the cost to access 4 blocks is not much more
-     than the cost to access 1 block, if you have to do a seek and
-     rotate.  A tail risks a non-linear disk access that is
-     significant as a percentage of total time cost for a 4 block file
-     and saves an amount of space that is less significant as a
-     percentage of space, or so goes the hypothesis.  -Hans */
+/* This is an aggressive tail suppression policy, I am hoping it
+   improves our benchmarks. The principle behind it is that percentage
+   space saving is what matters, not absolute space saving.  This is
+   non-intuitive, but it helps to understand it if you consider that the
+   cost to access 4 blocks is not much more than the cost to access 1
+   block, if you have to do a seek and rotate.  A tail risks a
+   non-linear disk access that is significant as a percentage of total
+   time cost for a 4 block file and saves an amount of space that is
+   less significant as a percentage of space, or so goes the hypothesis.
+   -Hans */
 #define STORE_TAIL_IN_UNFM(n_file_size,n_tail_size,n_block_size) \
 (\
   (!(n_tail_size)) || \
@@ -392,9 +330,6 @@
 #define ITEM_VERSION_2 1
 
 
-/* loff_t - long long */
-
-
 //
 // directories use this key as well as old files
 //
@@ -476,18 +411,11 @@
 		       indirect2direct conversion */
 };
 
-
-
-
-
-
-
- /* Our function for comparing keys can compare keys of different
-    lengths.  It takes as a parameter the length of the keys it is to
-    compare.  These defines are used in determining what is to be
-    passed to it as that parameter. */
+/* Our function for comparing keys can compare keys of different
+   lengths.  It takes as a parameter the length of the keys it is to
+   compare.  These defines are used in determining what is to be passed
+   to it as that parameter. */
 #define REISERFS_FULL_KEY_LEN     4
-
 #define REISERFS_SHORT_KEY_LEN    2
 
 /* The result of the key compare */
@@ -497,7 +425,6 @@
 #define KEY_FOUND 1
 #define KEY_NOT_FOUND 0
 
-
 #define KEY_SIZE (sizeof(struct key))
 #define SHORT_KEY_SIZE (sizeof (__u32) + sizeof (__u32))
 
@@ -522,8 +449,6 @@
 #define GOTO_PREVIOUS_ITEM 2
 #define NAME_FOUND_INVISIBLE 3
 
-
-
 /*  Everything in the filesystem is stored as a set of items.  The
     item head contains the key of the item, its free space (for
     indirect items) and specifies the location of the item itself
@@ -531,37 +456,28 @@
 
 struct item_head
 {
-  struct key ih_key; 	/* Everything in the tree is found by searching for it based on its key.*/
-
-				/* This is bloat, this should be part
-                                   of the item not the item
-                                   header. -Hans */
-  union {
-    __u16 ih_free_space_reserved; /* The free space in the last unformatted node of an indirect item if this
-				     is an indirect item.  This equals 0xFFFF iff this is a direct item or
-				     stat data item. Note that the key, not this field, is used to determine
-				     the item type, and thus which field this union contains. */
-    __u16 ih_entry_count; /* Iff this is a directory item, this field equals the number of directory
-				      entries in the directory item. */
-  } __attribute__ ((__packed__)) u;
-  __u16 ih_item_len;           /* total size of the item body */
-  __u16 ih_item_location;      /* an offset to the item body within the block */
-				/* I thought we were going to use this
-                                   for having lots of item types? Why
-                                   don't you use this for item type
-                                   not item version.  That is how you
-                                   talked me into this field a year
-                                   ago, remember?  I am still not
-                                   convinced it needs to be 16 bits
-                                   (for at least many years), but at
-                                   least I can sympathize with that
-                                   hope. Change the name from version
-                                   to type, and tell people not to use
-                                   FFFF in case 16 bits is someday too
-                                   small and needs to be extended:-). */
-  __u16 ih_version;	       /* 0 for all old items, 2 for new
-                                  ones. Highest bit is set by fsck
-                                  temporary, cleaned after all done */
+	/* Everything in the tree is found by searching for it based on
+	 * its key.*/
+	struct key ih_key; 	
+	union {
+		/* The free space in the last unformatted node of an
+		   indirect item if this is an indirect item.  This
+		   equals 0xFFFF iff this is a direct item or stat data
+		   item. Note that the key, not this field, is used to
+		   determine the item type, and thus which field this
+		   union contains. */
+		__u16 ih_free_space_reserved; 
+		/* Iff this is a directory item, this field equals the
+		   number of directory entries in the directory item. */
+		__u16 ih_entry_count; 
+	} __attribute__ ((__packed__)) u;
+	__u16 ih_item_len;           /* total size of the item body */
+	__u16 ih_item_location;      /* an offset to the item body
+				      * within the block */
+	__u16 ih_version;	     /* 0 for all old items, 2 for new
+					ones. Highest bit is set by fsck
+					temporary, cleaned after all
+					done */
 } __attribute__ ((__packed__));
 /* size of item header     */
 #define IH_SIZE (sizeof(struct item_head))
@@ -611,6 +527,9 @@
 #define V1_DIRENTRY_UNIQUENESS 500
 #define V1_ANY_UNIQUENESS 555 // FIXME: comment is required
 
+extern void reiserfs_warning (const char * fmt, ...);
+/* __attribute__( ( format ( printf, 1, 2 ) ) ); */
+
 //
 // here are conversion routines
 //
@@ -622,14 +541,11 @@
     case V1_INDIRECT_UNIQUENESS: return TYPE_INDIRECT;
     case V1_DIRECT_UNIQUENESS: return TYPE_DIRECT;
     case V1_DIRENTRY_UNIQUENESS: return TYPE_DIRENTRY;
+    default:
+	    reiserfs_warning( "vs-500: unknown uniqueness %d\n", uniqueness);
+	case V1_ANY_UNIQUENESS:
+	    return TYPE_ANY;
     }
-/*
-    if (uniqueness != V1_ANY_UNIQUENESS) {
-	printk ("uniqueness %d\n", uniqueness);
-	BUG (); 
-    }
-*/
-    return TYPE_ANY;
 }
 
 static inline __u32 type2uniqueness (int type) CONSTF;
@@ -640,15 +556,13 @@
     case TYPE_INDIRECT: return V1_INDIRECT_UNIQUENESS;
     case TYPE_DIRECT: return V1_DIRECT_UNIQUENESS;
     case TYPE_DIRENTRY: return V1_DIRENTRY_UNIQUENESS;
+    default:
+	    reiserfs_warning( "vs-501: unknown type %d\n", type);
+	case TYPE_ANY:
+	    return V1_ANY_UNIQUENESS;
     }
-    /*
-    if (type != TYPE_ANY)
-	BUG ();
-    */
-    return V1_ANY_UNIQUENESS;
 }
 
-
 //
 // key is pointer to on disk key which is stored in le, result is cpu,
 // there is no way to get version of object from key, so, provide
@@ -1084,76 +998,10 @@
 #define de_visible(deh)	    	    test_bit_unaligned (DEH_Visible, &((deh)->deh_state))
 #define de_hidden(deh)	    	    !test_bit_unaligned (DEH_Visible, &((deh)->deh_state))
 
-/* compose directory item containing "." and ".." entries (entries are
-   not aligned to 4 byte boundary) */
-/* the last four params are LE */
-static inline void make_empty_dir_item_v1 (char * body,
-                                           __u32 dirid, __u32 objid,
-					   __u32 par_dirid, __u32 par_objid)
-{
-    struct reiserfs_de_head * deh;
-
-    memset (body, 0, EMPTY_DIR_SIZE_V1);
-    deh = (struct reiserfs_de_head *)body;
-    
-    /* direntry header of "." */
-    put_deh_offset( &(deh[0]), DOT_OFFSET );
-    /* these two are from make_le_item_head, and are are LE */
-    deh[0].deh_dir_id = dirid;
-    deh[0].deh_objectid = objid;
-    deh[0].deh_state = 0; /* Endian safe if 0 */
-    put_deh_location( &(deh[0]), EMPTY_DIR_SIZE_V1 - strlen( "." ));
-    mark_de_visible(&(deh[0]));
-  
-    /* direntry header of ".." */
-    put_deh_offset( &(deh[1]), DOT_DOT_OFFSET);
-    /* key of ".." for the root directory */
-    /* these two are from the inode, and are are LE */
-    deh[1].deh_dir_id = par_dirid;
-    deh[1].deh_objectid = par_objid;
-    deh[1].deh_state = 0; /* Endian safe if 0 */
-    put_deh_location( &(deh[1]), deh_location( &(deh[0]) ) - strlen( ".." ) );
-    mark_de_visible(&(deh[1]));
-
-    /* copy ".." and "." */
-    memcpy (body + deh_location( &(deh[0]) ), ".", 1);
-    memcpy (body + deh_location( &(deh[1]) ), "..", 2);
-}
-
-/* compose directory item containing "." and ".." entries */
-static inline void make_empty_dir_item (char * body,
-                                        __u32 dirid, __u32 objid,
-					__u32 par_dirid, __u32 par_objid)
-{
-    struct reiserfs_de_head * deh;
-
-    memset (body, 0, EMPTY_DIR_SIZE);
-    deh = (struct reiserfs_de_head *)body;
-    
-    /* direntry header of "." */
-    put_deh_offset( &(deh[0]), DOT_OFFSET );
-    /* these two are from make_le_item_head, and are are LE */
-    deh[0].deh_dir_id = dirid;
-    deh[0].deh_objectid = objid;
-    deh[0].deh_state = 0; /* Endian safe if 0 */
-    put_deh_location( &(deh[0]), EMPTY_DIR_SIZE - ROUND_UP( strlen( "." ) ) );
-    mark_de_visible(&(deh[0]));
-  
-    /* direntry header of ".." */
-    put_deh_offset( &(deh[1]), DOT_DOT_OFFSET );
-    /* key of ".." for the root directory */
-    /* these two are from the inode, and are are LE */
-    deh[1].deh_dir_id = par_dirid;
-    deh[1].deh_objectid = par_objid;
-    deh[1].deh_state = 0; /* Endian safe if 0 */
-    put_deh_location( &(deh[1]), deh_location( &(deh[0])) - ROUND_UP( strlen( ".." ) ) );
-    mark_de_visible(&(deh[1]));
-
-    /* copy ".." and "." */
-    memcpy (body + deh_location( &(deh[0]) ), ".", 1);
-    memcpy (body + deh_location( &(deh[1]) ), "..", 2);
-}
-
+extern void make_empty_dir_item_v1 (char * body, __u32 dirid, __u32 objid,
+				    __u32 par_dirid, __u32 par_objid);
+extern void make_empty_dir_item (char * body, __u32 dirid, __u32 objid,
+				 __u32 par_dirid, __u32 par_objid);
 
 /* array of the entry headers */
  /* get item body */
@@ -1194,13 +1042,9 @@
 // two entries per block (at least)
 //#define REISERFS_MAX_NAME_LEN(block_size) 
 //((block_size - BLKH_SIZE - IH_SIZE - DEH_SIZE * 2) / 2)
-
-// two entries per block (at least)
 #define REISERFS_MAX_NAME_LEN(block_size) 255
 
 
-
-
 /* this structure is used for operations on directory entries. It is
    not a disk structure. */
 /* When reiserfs_find_entry or search_by_entry_key find directory
@@ -1393,18 +1237,11 @@
 
 // in in-core inode key is stored on le form
 #define INODE_PKEY(inode) ((struct key *)(REISERFS_I(inode)->i_key))
-//#define mark_tail_converted(inode) (atomic_set(&(REISERFS_I(inode)->i_converted),1))
-//#define unmark_tail_converted(inode) (REISERFS_I(inode)->i_converted), 0))
-//#define is_tail_converted(inode) (REISERFS_I(inode)->i_converted)))
-
-
 
 #define MAX_UL_INT 0xffffffff
 #define MAX_INT    0x7ffffff
 #define MAX_US_INT 0xffff
 
-///#define TOO_LONG_LENGTH		(~0ULL)
-
 // reiserfs version 2 has max offset 60 bits. Version 1 - 32 bit offset
 #define U32_MAX (~(__u32)0)
 static inline loff_t max_reiserfs_offset (struct inode * inode)
@@ -1442,13 +1279,6 @@
 /*                  FIXATE NODES                                           */
 /***************************************************************************/
 
-//#define VI_TYPE_STAT_DATA 1
-//#define VI_TYPE_DIRECT 2
-//#define VI_TYPE_INDIRECT 4
-//#define VI_TYPE_DIRECTORY 8
-//#define VI_TYPE_FIRST_DIRECTORY_ITEM 16
-//#define VI_TYPE_INSERTED_DIRECTORY_ITEM 32
-
 #define VI_TYPE_LEFT_MERGEABLE 1
 #define VI_TYPE_RIGHT_MERGEABLE 2
 
@@ -1958,12 +1788,6 @@
 void reiserfs_do_truncate (struct reiserfs_transaction_handle *th, 
 			   struct  inode * p_s_inode, struct page *, 
 			   int update_timestamps);
-//
-//void lock_inode_to_convert (struct inode * p_s_inode);
-//void unlock_inode_after_convert (struct inode * p_s_inode);
-//void increment_i_read_sync_counter (struct inode * p_s_inode);
-//void decrement_i_read_sync_counter (struct inode * p_s_inode);
-
 
 #define i_block_size(inode) ((inode)->i_sb->s_blocksize)
 #define file_size(inode) ((inode)->i_size)
@@ -1972,19 +1796,18 @@
 #define tail_has_to_be_packed(inode) (!dont_have_tails ((inode)->i_sb) &&\
 !STORE_TAIL_IN_UNFM(file_size (inode), tail_size(inode), i_block_size (inode)))
 
-/*
-int get_buffer_by_range (struct super_block * p_s_sb, struct key * p_s_range_begin, struct key * p_s_range_end, 
-			 struct buffer_head ** pp_s_buf, unsigned long * p_n_objectid);
-int get_buffers_from_range (struct super_block * p_s_sb, struct key * p_s_range_start, struct key * p_s_range_end, 
-                            struct buffer_head ** p_s_range_buffers,
-			    int n_max_nr_buffers_to_return);
-*/
-
 void padd_item (char * item, int total_length, int length);
 
-
 /* inode.c */
 
+void reiserfs_read_inode (struct inode * inode) ;
+void reiserfs_read_inode2(struct inode * inode, void *p) ;
+void reiserfs_delete_inode (struct inode * inode);
+void reiserfs_write_inode (struct inode * inode, int) ;
+struct dentry *reiserfs_fh_to_dentry(struct super_block *sb, __u32 *data,
+									 int len, int fhtype, int parent);
+int reiserfs_dentry_to_fh(struct dentry *dentry, __u32 *data, int *lenp, int need_parent);
+
 int reiserfs_prepare_write(struct file *, struct page *, unsigned, unsigned) ;
 void reiserfs_truncate_file(struct inode *, int update_timestamps) ;
 void make_cpu_key (struct cpu_key * cpu_key, struct inode * inode, loff_t offset,
@@ -1992,24 +1815,9 @@
 void make_le_item_head (struct item_head * ih, const struct cpu_key * key, 
 			int version,
 			loff_t offset, int type, int length, int entry_count);
-/*void store_key (struct key * key);
-void forget_key (struct key * key);*/
-int reiserfs_get_block (struct inode * inode, sector_t block,
-			struct buffer_head * bh_result, int create);
 struct inode * reiserfs_iget (struct super_block * s, 
 			      const struct cpu_key * key);
-void reiserfs_read_inode (struct inode * inode) ;
-void reiserfs_read_inode2(struct inode * inode, void *p) ;
-void reiserfs_delete_inode (struct inode * inode);
-extern int reiserfs_notify_change(struct dentry * dentry, struct iattr * attr);
-void reiserfs_write_inode (struct inode * inode, int) ;
-
-/* nfsd support functions */
-struct dentry *reiserfs_fh_to_dentry(struct super_block *sb, __u32 *fh, int len, int fhtype, int parent);
-int reiserfs_dentry_to_fh(struct dentry *, __u32 *fh, int *lenp, int need_parent);
 
-/* we don't mark inodes dirty, we just log them */
-void reiserfs_dirty_inode (struct inode * inode) ;
 
 struct inode * reiserfs_new_inode (struct reiserfs_transaction_handle *th, 
 				   struct inode * dir, int mode, 
@@ -2017,36 +1825,12 @@
 				   struct dentry *dentry, struct inode *inode, int * err);
 int reiserfs_sync_inode (struct reiserfs_transaction_handle *th, struct inode * inode);
 void reiserfs_update_sd (struct reiserfs_transaction_handle *th, struct inode * inode);
-int reiserfs_inode_setattr(struct dentry *,  struct iattr * attr);
 
 /* namei.c */
 inline void set_de_name_and_namelen (struct reiserfs_dir_entry * de);
 int search_by_entry_key (struct super_block * sb, const struct cpu_key * key, 
 			 struct path * path, 
 			 struct reiserfs_dir_entry * de);
-struct dentry * reiserfs_lookup (struct inode * dir, struct dentry *dentry);
-int reiserfs_create (struct inode * dir, struct dentry *dentry,	int mode);
-int reiserfs_mknod (struct inode * dir_inode, struct dentry *dentry, int mode, int rdev);
-int reiserfs_mkdir (struct inode * dir, struct dentry *dentry, int mode);
-int reiserfs_rmdir (struct inode * dir,	struct dentry *dentry);
-int reiserfs_unlink (struct inode * dir, struct dentry *dentry);
-int reiserfs_symlink (struct inode * dir, struct dentry *dentry, const char * symname);
-int reiserfs_link (struct dentry * old_dentry, struct inode * dir, struct dentry *dentry);
-int reiserfs_rename (struct inode * old_dir, struct dentry *old_dentry, struct inode * new_dir, struct dentry *new_dentry);
-
-/* super.c */
-inline void reiserfs_mark_buffer_dirty (struct buffer_head * bh, int flag);
-inline void reiserfs_mark_buffer_clean (struct buffer_head * bh);
-void reiserfs_write_super (struct super_block * s);
-void reiserfs_put_super (struct super_block * s);
-int reiserfs_remount (struct super_block * s, int * flags, char * data);
-/*int read_super_block (struct super_block * s, int size);
-int read_bitmaps (struct super_block * s);
-int read_old_bitmaps (struct super_block * s);
-int read_old_super_block (struct super_block * s, int size);*/
-struct super_block * reiserfs_read_super (struct super_block * s, void * data, int silent);
-int reiserfs_statfs (struct super_block * s, struct statfs * buf);
-
 /* procfs.c */
 
 #if defined( CONFIG_PROC_FS ) && defined( CONFIG_REISERFS_PROC_INFO )
@@ -2143,8 +1927,6 @@
 /* prints.c */
 void reiserfs_panic (struct super_block * s, const char * fmt, ...)
 __attribute__ ( ( noreturn ) );/* __attribute__( ( format ( printf, 2, 3 ) ) ) */
-void reiserfs_warning (const char * fmt, ...);
-/* __attribute__( ( format ( printf, 1, 2 ) ) ); */
 void reiserfs_debug (struct super_block *s, int level, const char * fmt, ...);
 /* __attribute__( ( format ( printf, 3, 4 ) ) ); */
 void print_virtual_node (struct virtual_node * vn);
@@ -2233,83 +2015,6 @@
 #define reiserfs_test_and_clear_le_bit ext2_clear_bit
 #define reiserfs_test_le_bit           ext2_test_bit
 #define reiserfs_find_next_zero_le_bit ext2_find_next_zero_bit
-
-
-//
-// this was totally copied from from linux's
-// find_first_zero_bit and changed a bit
-//
-
-#ifdef __i386__
-
-static __inline__ int 
-find_first_nonzero_bit(const void * addr, unsigned size) {
-  int res;
-  int __d0;
-  void *__d1;
-
-
-  if (!size) {
-    return (0);
-  }
-  __asm__ __volatile__ (
-	  "cld\n\t"
-	  "xorl %%eax,%%eax\n\t"
-	  "repe; scasl\n\t"
-	  "je 1f\n\t"
-	  "movl -4(%%edi),%%eax\n\t"
-	  "subl $4, %%edi\n\t"
-	  "bsfl %%eax,%%eax\n\t"
-	  "1:\tsubl %%edx,%%edi\n\t"
-	  "shll $3,%%edi\n\t"
-	  "addl %%edi,%%eax"
-	  :"=a" (res),
-	  "=c"(__d0), "=D"(__d1)
-	  :"1" ((size + 31) >> 5), "d" (addr), "2" (addr));
-  return (res);
-}
-
-#else /* __i386__ */
-
-static __inline__ int find_next_nonzero_bit(const void * addr, unsigned size, 
-											unsigned offset)
-{
-	unsigned int * p = ((unsigned int *) addr) + (offset >> 5);
-	unsigned int result = offset & ~31UL;
-	unsigned int tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *p++;
-		/* set to zero first offset bits */
-		tmp &= ~(~0UL >> (32-offset));
-		if (size < 32)
-			goto found_first;
-		if (tmp != 0U)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size >= 32) {
-		if ((tmp = *p++) != 0U)
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-found_first:
-found_middle:
-	return result + ffs(tmp);
-}
-
-#define find_first_nonzero_bit(addr,size) find_next_nonzero_bit((addr), (size), 0)
-
-#endif /* 0 */
 
 /* sometimes reiserfs_truncate may require to allocate few new blocks
    to perform indirect2direct conversion. People probably used to
--- linux-2.5.3-pre4.o/fs/reiserfs/resize.c	Thu Jan 24 11:11:41 2002
+++ linux-2.5.3-pre4/fs/reiserfs/resize.c	Thu Jan 24 11:17:47 2002
@@ -111,7 +111,7 @@
 	    for (i = 0; i < bmap_nr; i++)
 		bitmap[i] = SB_AP_BITMAP(s)[i];
 	    for (i = bmap_nr; i < bmap_nr_new; i++) {
-		bitmap[i] = reiserfs_getblk(s, i * s->s_blocksize * 8);
+		bitmap[i] = sb_getblk(s, i * s->s_blocksize * 8);
 		memset(bitmap[i]->b_data, 0, sb_blocksize(sb));
 		reiserfs_test_and_set_le_bit(0, bitmap[i]->b_data);
 

