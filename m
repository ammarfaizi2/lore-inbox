Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289581AbSA2LnJ>; Tue, 29 Jan 2002 06:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289573AbSA2Lm3>; Tue, 29 Jan 2002 06:42:29 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:55055 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289516AbSA2Lkr>; Tue, 29 Jan 2002 06:40:47 -0500
Date: Mon, 28 Jan 2002 20:52:16 +0300
Message-Id: <200201281752.g0SHqG723180@bitshadow.namesys.com>
From: Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com
CC: reiser@namesys.com, reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS 2.5 Update Patch Set 24 of 25
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This set of patches of which this is one will update ReiserFS in 2.5
to contain all bugfixes applied to 2.4 plus allow relocating the journal plus
uuid support plus fix the kdev_t compilation failure.

24-reiserfs-boot-verbose.diff
    Do not print unsuccesful superblocks read warnings 
    (if old or new one cannot be found). Print verbose journal info. 
    Convert warnings to standard format.


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





diff -u -r linux/fs/reiserfs/journal.c linux-patched/fs/reiserfs/journal.c
--- linux/fs/reiserfs/journal.c	Mon Jan 28 17:06:32 2002
+++ linux-patched/fs/reiserfs/journal.c	Mon Jan 28 17:03:26 2002
@@ -1887,7 +1887,7 @@
 	journal -> j_dev_file = NULL;
     }
     if( result != 0 ) {
-	reiserfs_warning("release_journal_dev: Cannot release journal device: %i", result );
+	reiserfs_warning("sh-457: release_journal_dev: Cannot release journal device: %i", result );
     }
     return result;
 }
@@ -1917,7 +1917,7 @@
 		else
 			result = -ENOMEM;
 		if( result != 0 )
-			printk( "journal_init_dev: cannot init journal device\n '%s': %i", 
+			printk( "sh-458: journal_init_dev: cannot init journal device\n '%s': %i", 
 				kdevname( jdev ), result );
 
 		return result;
@@ -1994,7 +1994,7 @@
 					     REISERFS_DISK_OFFSET_IN_BYTES / p_s_sb->s_blocksize + 2); 
     
     if( journal_init_dev( p_s_sb, journal, j_dev_name ) != 0 ) {
-      printk( "journal-1259: unable to initialize jornal device\n");
+      printk( "sh-462: unable to initialize jornal device\n");
       return 1;
     }
 
@@ -2005,7 +2005,7 @@
 		   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_ONDISK_JOURNAL_SIZE(p_s_sb),
 		   SB_BLOCKSIZE(p_s_sb));
      if (!bhjh) {
-	 printk("journal-1250: unable to read  journal header\n") ;
+	 printk("sh-459: unable to read  journal header\n") ;
 	 return 1 ;
      }
      jh = (struct reiserfs_journal_header *)(bhjh->b_data);
@@ -2017,7 +2017,7 @@
 	 
 	 strcpy( jname, kdevname( SB_JOURNAL_DEV(p_s_sb) ) );
 	 strcpy( fname, kdevname( p_s_sb->s_dev ) );
-	 printk("journal-460: journal header magic %x (device %s) does not match "
+	 printk("sh-460: journal header magic %x (device %s) does not match "
 		"to magic found in super block %x (device %s)\n",
 		jh->jh_journal.jp_journal_magic, jname,
 		sb_jp_journal_magic(rs), fname);
@@ -2046,7 +2046,7 @@
       SB_JOURNAL_TRANS_MAX(p_s_sb) = JOURNAL_TRANS_MIN_DEFAULT / ratio;
     
     if (SB_JOURNAL_TRANS_MAX(p_s_sb) != initial)
-      printk ("reiserfs warning: wrong transaction max size (%u). Changed to %u\n",
+      printk ("sh-461: journal_init: wrong transaction max size (%u). Changed to %u\n",
 	      initial, SB_JOURNAL_TRANS_MAX(p_s_sb));
 
     SB_JOURNAL_MAX_BATCH(p_s_sb) = SB_JOURNAL_TRANS_MAX(p_s_sb)*
@@ -2067,9 +2067,12 @@
       SB_JOURNAL_MAX_BATCH(p_s_sb) = (SB_JOURNAL_TRANS_MAX(p_s_sb)) * 9 / 10 ;
     }
   }
-  printk ("Journal params: device %s, size %u, journal first block %u, max trans len %u, max batch %u, "
+  printk ("Reiserfs journal params: device %s, size %u, "
+	  "journal first block %u, max trans len %u, max batch %u, "
 	  "max commit age %u, max trans age %u\n",
-	  kdevname( SB_JOURNAL_DEV(p_s_sb) ), SB_ONDISK_JOURNAL_SIZE(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb),
+	  kdevname( SB_JOURNAL_DEV(p_s_sb) ),
+	  SB_ONDISK_JOURNAL_SIZE(p_s_sb),
+	  SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb),
 	  SB_JOURNAL_TRANS_MAX(p_s_sb),
 	  SB_JOURNAL_MAX_BATCH(p_s_sb),
 	  SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb),
diff -u -r linux/fs/reiserfs/super.c linux-patched/fs/reiserfs/super.c
--- linux/fs/reiserfs/super.c	Mon Jan 28 17:06:53 2002
+++ linux-patched/fs/reiserfs/super.c	Mon Jan 28 15:32:36 2002
@@ -712,7 +712,7 @@
 
     bh = sb_bread (s, offset / s->s_blocksize);
     if (!bh) {
-      printk ("read_super_block: "
+      printk ("sh-2006: read_super_block: "
               "bread failed (dev %s, block %lu, size %lu)\n",
               s->s_id, offset / s->s_blocksize, s->s_blocksize);
       return 1;
@@ -720,9 +720,6 @@
  
     rs = (struct reiserfs_super_block *)bh->b_data;
     if (!is_any_reiserfs_magic_string (rs)) {
-      printk ("read_super_block: "
-              "can't find a reiserfs filesystem on (dev %s, block %lu, size %lu)\n",
-              s->s_id, bh->b_blocknr, s->s_blocksize);
       brelse (bh);
       return 1;
     }
@@ -733,22 +730,21 @@
     brelse (bh);
     
     sb_set_blocksize (s, sb_blocksize(rs));
-
+    
     bh = reiserfs_bread (s, offset / s->s_blocksize);
     if (!bh) {
-	printk("read_super_block: "
+	printk("sh-2007: read_super_block: "
                 "bread failed (dev %s, block %lu, size %lu)\n",
                 s->s_id, offset / s->s_blocksize, s->s_blocksize);
 	return 1;
     }
     
     rs = (struct reiserfs_super_block *)bh->b_data;
-    if (!is_any_reiserfs_magic_string (rs) || sb_blocksize(rs) != s->s_blocksize) {
-	printk ("read_super_block: "
+    if (sb_blocksize(rs) != s->s_blocksize) {
+	printk ("sh-2011: read_super_block: "
 		"can't find a reiserfs filesystem on (dev %s, block %lu, size %lu)\n",
 		s->s_id, bh->b_blocknr, s->s_blocksize);
 	brelse (bh);
-	printk ("read_super_block: can't find a reiserfs filesystem on dev %s.\n", s->s_id);
 	return 1;
     }
 
@@ -759,20 +755,22 @@
 	/* magic is of non-standard journal filesystem, look at s_version to
 	   find which format is in use */
 	if (sb_version(rs) == REISERFS_VERSION_2)
-	    printk ("reiserfs: found format \"3.6\" with non-standard journal\n");
+	  printk ("read_super_block: found reiserfs format \"3.6\" "
+		  "with non-standard journal\n");
 	else if (sb_version(rs) == REISERFS_VERSION_1)
-	    printk ("reiserfs: found format \"3.5\" with non-standard journal\n");
+	  printk ("read_super_block: found reiserfs format \"3.5\" "
+		  "with non-standard journal\n");
 	else {
-	    printk ("read_super_block: found unknown format \"%u\" "
-	            "with non-standard magic\n", sb_version(rs));
+	  printk ("sh-2012: read_super_block: found unknown format \"%u\" "
+	            "of reiserfs with non-standard magic\n", sb_version(rs));
 	return 1;
 	}
     }
     else
-	/* s_version may contain incorrect information. Look at the magic
-	   string */
-	    printk ("reiserfs: found format \"%s\" with standard journal\n",
-	            is_reiserfs_3_5 (rs) ? "3.5" : "3.6");
+      /* s_version of standard format may contain incorrect information,
+	 so we just look at the magic string */
+      printk ("found reiserfs format \"%s\" with standard journal\n",
+	      is_reiserfs_3_5 (rs) ? "3.5" : "3.6");
 
     s->s_op = &reiserfs_sops;
 
@@ -989,9 +987,10 @@
     if (!read_super_block (s, REISERFS_OLD_DISK_OFFSET_IN_BYTES)) 
       old_format = 1;
     /* try new format (64-th 1k block), which can contain reiserfs super block */
-    else if (read_super_block (s, REISERFS_DISK_OFFSET_IN_BYTES)) 
+    else if (read_super_block (s, REISERFS_DISK_OFFSET_IN_BYTES)) {
+      printk("sh-2021: reiserfs_read_super: can not find reiserfs on %s\n", s->s_id);
       goto error;    
-    
+    }
     s->u.reiserfs_sb.s_mount_state = SB_REISERFS_STATE(s);
     s->u.reiserfs_sb.s_mount_state = REISERFS_VALID_FS ;
 
@@ -1006,7 +1005,7 @@
 
     // set_device_ro(s->s_dev, 1) ;
     if( journal_init(s, jdev_name, old_format) ) {
-	printk("reiserfs_read_super: unable to initialize journal space\n") ;
+	printk("sh-2022: reiserfs_read_super: unable to initialize journal space\n") ;
 	goto error ;
     } else {
 	jinit_done = 1 ; /* once this is set, journal_release must be called

