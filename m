Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289542AbSA2Lp7>; Tue, 29 Jan 2002 06:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289545AbSA2Loa>; Tue, 29 Jan 2002 06:44:30 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:48911 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289547AbSA2Lkn>; Tue, 29 Jan 2002 06:40:43 -0500
Date: Mon, 28 Jan 2002 20:48:20 +0300
Message-Id: <200201281748.g0SHmKi23106@bitshadow.namesys.com>
From: Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com
CC: reiser@namesys.com, reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS 2.5 Update Patch Set 13 of 25
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This set of patches of which this is one will update ReiserFS in 2.5
to contain all bugfixes applied to 2.4 plus allow relocating the journal plus
uuid support plus fix the kdev_t compilation failure.

13-scan_magic_cleanup.diff
    Fixes a problem with v3.6 fs mounted readonly and then remounted rw.
    

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





--- linux-2.5.3-pre4.o/include/linux/reiserfs_fs_sb.h	Thu Jan 24 12:21:23 2002
+++ linux-2.5.3-pre4/include/linux/reiserfs_fs_sb.h	Thu Jan 24 12:53:45 2002
@@ -347,6 +347,8 @@
 				/* To be obsoleted soon by per buffer seals.. -Hans */
     atomic_t s_generation_counter; // increased by one every time the
     // tree gets re-balanced
+    unsigned long s_properties;    /* File system properties. Currently holds
+				     on-disk FS format */
     
     /* session statistics */
     int s_kmallocs;
@@ -368,7 +370,11 @@
     struct proc_dir_entry *procdir;
 };
 
+/* Definitions of reiserfs on-disk properties: */
+#define REISERFS_3_5 0
+#define REISERFS_3_6 1
 
+/* Mount options */
 #define NOTAIL 0  /* -o notail: no tails will be created in a session */
 #define REPLAYONLY 3 /* replay journal and return 0. Use by fsck */
 #define REISERFS_NOLOG 4      /* -o nolog: turn journalling off */
@@ -418,8 +424,8 @@
 #define dont_have_tails(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << NOTAIL))
 #define replay_only(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REPLAYONLY))
 #define reiserfs_dont_log(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_NOLOG))
-#define old_format_only(s) ((SB_VERSION(s) != REISERFS_VERSION_2) \
-         && !((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_CONVERT)))
+#define old_format_only(s) ((s)->u.reiserfs_sb.s_properties & (1 << REISERFS_3_5))
+#define convert_reiserfs(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_CONVERT))
 
 
 void reiserfs_file_buffer (struct buffer_head * bh, int list);
--- linux-2.5.3-pre4.o/fs/reiserfs/procfs.c	Thu Jan 24 12:21:23 2002
+++ linux-2.5.3-pre4/fs/reiserfs/procfs.c	Thu Jan 24 12:53:45 2002
@@ -15,6 +15,7 @@
 #include <linux/sched.h>
 #include <asm/uaccess.h>
 #include <linux/reiserfs_fs.h>
+#include <linux/reiserfs_fs_sb.h>
 #include <linux/smp_lock.h>
 #include <linux/locks.h>
 #include <linux/init.h>
@@ -76,12 +77,21 @@
 {
 	int len = 0;
 	struct super_block *sb;
+	char *format;
     
 	sb = procinfo_prologue( to_kdev_t((int)data) );
 	if( sb == NULL )
 		return -ENOENT;
+	if ( sb->u.reiserfs_sb.s_properties & (1 << REISERFS_3_6) ) {
+		format = "3.6";
+	} else if ( sb->u.reiserfs_sb.s_properties & (1 << REISERFS_3_5) ) {
+		format = "3.5";
+	} else {
+		format = "unknown";
+	}
+
 	len += sprintf( &buffer[ len ], "%s format\twith checks %s\n",
-			old_format_only( sb ) ? "old" : "new",
+			format,
 #if defined( CONFIG_REISERFS_CHECK )
 			"on"
 #else
@@ -172,7 +182,7 @@
 			dont_have_tails( sb ) ? "NO_TAILS " : "TAILS ",
 			replay_only( sb ) ? "REPLAY_ONLY " : "",
 			reiserfs_dont_log( sb ) ? "DONT_LOG " : "LOG ",
-			old_format_only( sb ) ? "CONV " : "",
+			convert_reiserfs( sb ) ? "CONV " : "",
 
 			atomic_read( &r -> s_generation_counter ),
 			SF( s_kmallocs ),
--- linux-2.5.3-pre4.o/fs/reiserfs/super.c	Thu Jan 24 12:25:16 2002
+++ linux-2.5.3-pre4/fs/reiserfs/super.c	Thu Jan 24 12:53:45 2002
@@ -968,6 +968,7 @@
     unsigned long blocks;
     int jinit_done = 0 ;
     struct reiserfs_iget4_args args ;
+    struct reiserfs_super_block * rs;
     char *jdev_name;
 
     memset (&s->u.reiserfs_sb, 0, sizeof (struct reiserfs_sb_info));
@@ -1045,8 +1046,13 @@
       goto error ;
     }
 
+    rs = SB_DISK_SUPER_BLOCK (s);
+    if (is_reiserfs_3_5 (rs) || (is_reiserfs_jr (rs) && SB_VERSION (s) == REISERFS_VERSION_1))
+	set_bit(REISERFS_3_5, &(s->u.reiserfs_sb.s_properties));
+    else
+	set_bit(REISERFS_3_6, &(s->u.reiserfs_sb.s_properties));
+    
     if (!(s->s_flags & MS_RDONLY)) {
-	struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK (s);
 
 	journal_begin(&th, s, 1) ;
 	reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
@@ -1054,14 +1060,13 @@
         set_sb_umount_state( rs, REISERFS_ERROR_FS );
 	set_sb_fs_state (rs, 0);
 	
-	if (is_reiserfs_3_5 (rs) || (is_reiserfs_jr (rs) && SB_VERSION (s) == REISERFS_VERSION_1)) {
+	if (old_format_only(s)) {
 	  /* filesystem of format 3.5 either with standard or non-standard
 	     journal */       
-	  if (!old_format_only (s)) {
+	  if (convert_reiserfs (s)) {
 	    /* and -o conv is given */ 
 	    reiserfs_warning ("reiserfs: converting 3.5 filesystem to the 3.6 format\n") ;
 	    
-	    if (is_reiserfs_3_5 (rs))
 	      /* put magic string of 3.6 format. 2.2 will not be able to
 		 mount this filesystem anymore */
 	      memcpy (rs->s_v1.s_magic, reiserfs_3_6_magic_string, 
@@ -1069,17 +1074,13 @@
 	    
 	    set_sb_version(rs,REISERFS_VERSION_2);
 	    reiserfs_convert_objectid_map_v1(s) ;
+	    set_bit(REISERFS_3_6, &(s->u.reiserfs_sb.s_properties));
+	    clear_bit(REISERFS_3_5, &(s->u.reiserfs_sb.s_properties));
 	  } else {
 	    reiserfs_warning("reiserfs: using 3.5.x disk format\n") ;
-	    }
-	} else {
-	    // new format found
-	    set_bit (REISERFS_CONVERT, &(s->u.reiserfs_sb.s_mount_opt));
+	  }
 	}
 
-	// mark hash in super block: it could be unset. overwrite should be ok
-        set_sb_hash_function_code( rs, function2code(s->u.reiserfs_sb.s_hash_function ) );
-
 	journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
 	journal_end(&th, s, 1) ;
 	
@@ -1087,7 +1088,13 @@
 	finish_unfinished (s);
 
 	s->s_dirt = 0;
+    } else {
+	if ( old_format_only(s) ) {
+	    reiserfs_warning("reiserfs: using 3.5.x disk format\n") ;
+	}
     }
+    // mark hash in super block: it could be unset. overwrite should be ok
+    set_sb_hash_function_code( rs, function2code(s->u.reiserfs_sb.s_hash_function ) );
 
     reiserfs_proc_info_init( s );
     reiserfs_proc_register( s, "version", reiserfs_version_in_proc );

