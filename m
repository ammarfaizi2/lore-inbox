Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313669AbSDHPPt>; Mon, 8 Apr 2002 11:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313670AbSDHPPs>; Mon, 8 Apr 2002 11:15:48 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:32521 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S313669AbSDHPPn>; Mon, 8 Apr 2002 11:15:43 -0400
Message-ID: <3CB1B332.3020007@namesys.com>
Date: Mon, 08 Apr 2002 19:11:46 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS bug fixes
Content-Type: multipart/mixed;
 boundary="------------070000050909010801050800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070000050909010801050800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

We will set up a secure bitkeeper clone later this week, for now we send 
you old fashioned patches.

There is one patch in here that is important, the one described as:

 Fixes a problem that was created during inode structure
 cleanup/ private parts separation. This fix was made by Chris Mason.
 This is very critical bugfix. Without it, filesystem corruption
 happens on savelinks processing and possibly in some other cases.

Hans

--------------070000050909010801050800
Content-Type: message/rfc822;
 name="patches for 2.5.8-pre1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patches for 2.5.8-pre1"


>From - Mon Apr  8 16:34:34 2002
X-Mozilla-Status2: 10000000
Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 14694 invoked from network); 8 Apr 2002 11:49:41 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 8 Apr 2002 11:49:41 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 95B174EC235; Mon,  8 Apr 2002 15:49:41 +0400 (MSD)
Date: Mon, 8 Apr 2002 15:49:41 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: patches for 2.5.8-pre1
Message-ID: <20020408154941.A906@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!
 
   Attached are 13 messagebodies for pending patches.
   Non-brokenness was verified by me and Edward. (and by Chris Mason
   to some degree)

Bye,
    Oleg

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mail1

This patch is to fix a problem when directory's atime was not updated on
readdir(). Patch is written by Chris Mason.

--- linux-2.5.8-pre2.o/fs/reiserfs/dir.c Thu, 13 Dec 2001 11:06:51 -0500
+++ linux-2.5.8-pre2/fs/reiserfs/dir.c Tue, 29 Jan 2002 17:56:04 -0500
@@ -180,6 +180,7 @@
     filp->f_pos = next_pos;
     pathrelse (&path_to_entry);
     reiserfs_check_path(&path_to_entry) ;
+    UPDATE_ATIME(inode) ;
     return 0;
 }
 


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mail2


This patch is to fix a lookup problem on bigendian platforms

--- linux-2.5.8-pre2.orig/fs/reiserfs/inode.c Mon, 11 Feb 2002 12:21:42 -0500
+++ linux-2.5.8-pre2/fs/reiserfs/inode.c Mon, 18 Feb 2002 19:43:55 -0500
@@ -1207,7 +1211,8 @@
     struct reiserfs_iget4_args *args;
 
     args = opaque;
-    return INODE_PKEY( inode ) -> k_dir_id == args -> objectid;
+    /* args is already in CPU order */
+    return le32_to_cpu(INODE_PKEY(inode)->k_dir_id) == args -> objectid;
 }
 
 struct inode * reiserfs_iget (struct super_block * s, const struct cpu_key * key)


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mail3


This patch is to convert pap14030 panic into warning. While doing this,
a bug was uncovered, that when get_block() returns a failure, buffer
is still marked as mapped, and on subsequent access to this buffer
get_block() was not called anymore. This is also fixed.
 
--- linux-2.5.8-pre2/fs/reiserfs/inode.c.orig	Mon Apr  8 14:08:06 2002
+++ linux-2.5.8-pre2/fs/reiserfs/inode.c	Mon Apr  8 14:08:28 2002
@@ -752,6 +752,11 @@
 		goto research ;
 	    }
 	    retval = direct2indirect (&th, inode, &path, unbh, tail_offset);
+	    if (retval) {
+		reiserfs_unmap_buffer(unbh);
+		reiserfs_free_block (&th, allocated_block_nr);
+		goto failure;
+	    }
 	    /* it is important the mark_buffer_uptodate is done after
 	    ** the direct2indirect.  The buffer might contain valid
 	    ** data newer than the data on disk (read by readpage, changed,
@@ -761,10 +766,7 @@
 	    ** the disk
 	    */
 	    mark_buffer_uptodate (unbh, 1);
-	    if (retval) {
-		reiserfs_free_block (&th, allocated_block_nr);
-		goto failure;
-	    }
+
 	    /* we've converted the tail, so we must 
 	    ** flush unbh before the transaction commits
 	    */
--- linux-2.5.8-pre2.orig/fs/reiserfs/tail_conversion.c	Mon Apr  8 14:00:50 2002
+++ linux-2.5.8-pre2/fs/reiserfs/tail_conversion.c	Mon Apr  8 14:08:28 2002
@@ -49,9 +49,13 @@
     make_cpu_key (&end_key, inode, tail_offset, TYPE_INDIRECT, 4);
 
     // FIXME: we could avoid this 
-    if ( search_for_position_by_key (sb, &end_key, path) == POSITION_FOUND )
-	reiserfs_panic (sb, "PAP-14030: direct2indirect: "
-			"pasted or inserted byte exists in the tree");
+    if ( search_for_position_by_key (sb, &end_key, path) == POSITION_FOUND ) {
+	reiserfs_warning ("PAP-14030: direct2indirect: "
+			"pasted or inserted byte exists in the tree %K. "
+			"Use fsck to repair.\n", &end_key);
+	pathrelse(path);
+	return -EIO;
+    }
     
     p_le_ih = PATH_PITEM_HEAD (path);
 

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mail4


This patch is to fix a case where flag was not set at inode-read time which
prevented 32bit uid/gid to work correctly.

--- linux-2.5.8-pre2/fs/reiserfs/inode.c.orig	Mon Apr  8 14:08:28 2002
+++ linux-2.5.8-pre2/fs/reiserfs/inode.c	Mon Apr  8 14:09:34 2002
@@ -935,9 +935,6 @@
 	// (directories and symlinks)
 	struct stat_data * sd = (struct stat_data *)B_I_PITEM (bh, ih);
 
-	/* both old and new directories have old keys */
-	//version = (S_ISDIR (sd->sd_mode) ? ITEM_VERSION_1 : ITEM_VERSION_2);
-
 	inode->i_mode   = sd_v2_mode(sd);
 	inode->i_nlink  = sd_v2_nlink(sd);
 	inode->i_uid    = sd_v2_uid(sd);
@@ -958,6 +955,7 @@
 	else
 	    set_inode_item_key_version (inode, KEY_FORMAT_3_6);
 	REISERFS_I(inode)->i_first_direct_byte = 0;
+	set_inode_sd_version (inode, STAT_DATA_V2);
     }
 
     pathrelse (path);

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mail5


This patch is to add forgotten metadata journaling for a case when
we free blocks after tail conversion failures. Found and fixed by Chris Mason

--- linux-2.5.8-pre2/fs/reiserfs/inode.c.orig	Mon Apr  8 14:09:34 2002
+++ linux-2.5.8-pre2/fs/reiserfs/inode.c	Mon Apr  8 14:09:57 2002
@@ -745,8 +745,12 @@
 		if (retval) {
 		    if ( retval != -ENOSPC )
 			printk("clm-6004: convert tail failed inode %lu, error %d\n", inode->i_ino, retval) ;
-		    if (allocated_block_nr)
+		    if (allocated_block_nr) {
+			/* the bitmap, the super, and the stat data == 3 */
+			journal_begin(&th, inode->i_sb, 3) ;
 			reiserfs_free_block (&th, allocated_block_nr);
+			transaction_started = 1 ;
+		    }
 		    goto failure ;
 		}
 		goto research ;

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mail6


This patch solves a problem where separate journal device was not freed
if journal initialisation failed

--- linux-2.5.8-pre2/fs/reiserfs/journal.c.orig	Mon Apr  8 14:00:50 2002
+++ linux-2.5.8-pre2/fs/reiserfs/journal.c	Mon Apr  8 15:31:43 2002
@@ -2049,6 +2049,7 @@
 		   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_ONDISK_JOURNAL_SIZE(p_s_sb));
      if (!bhjh) {
 	 printk("sh-459: unable to read  journal header\n") ;
+	 release_journal_dev(p_s_sb, journal);
 	 return 1 ;
      }
      jh = (struct reiserfs_journal_header *)(bhjh->b_data);
@@ -2065,7 +2066,8 @@
 		jh->jh_journal.jp_journal_magic, jname,
 		sb_jp_journal_magic(rs), fname);
 	 brelse (bhjh);
-    return 1 ;
+	 release_journal_dev(p_s_sb, journal);
+	 return 1 ;
   }
      
   SB_JOURNAL_TRANS_MAX(p_s_sb)      = le32_to_cpu (jh->jh_journal.jp_journal_trans_max);
@@ -2165,11 +2167,13 @@
   SB_JOURNAL_LIST(p_s_sb)[0].j_list_bitmap = get_list_bitmap(p_s_sb, SB_JOURNAL_LIST(p_s_sb)) ;
   if (!(SB_JOURNAL_LIST(p_s_sb)[0].j_list_bitmap)) {
     reiserfs_warning("journal-2005, get_list_bitmap failed for journal list 0\n") ;
+    release_journal_dev(p_s_sb, journal);
     return 1 ;
   }
   if (journal_read(p_s_sb) < 0) {
     reiserfs_warning("Replay Failure, unable to mount\n") ;
     free_journal_ram(p_s_sb) ;
+    release_journal_dev(p_s_sb, journal);
     return 1 ;
   }
   SB_JOURNAL_LIST_INDEX(p_s_sb) = 0 ; /* once the read is done, we can set this

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mail7


This patch is to fix journal replay bug where old code would replay
transactions with mount_id != mount_id recorded in journal header.
Fixed by Chris Mason.

--- linux-2.5.8-pre2/fs/reiserfs/journal.c.orig	Mon Apr  8 15:31:43 2002
+++ linux-2.5.8-pre2/fs/reiserfs/journal.c	Mon Apr  8 15:32:20 2002
@@ -1651,11 +1651,9 @@
 }
 static int journal_read(struct super_block *p_s_sb) {
   struct reiserfs_journal_desc *desc ;
-  unsigned long last_flush_trans_id = 0 ;
   unsigned long oldest_trans_id = 0;
   unsigned long oldest_invalid_trans_id = 0 ;
   time_t start ;
-  unsigned long last_flush_start = 0;
   unsigned long oldest_start = 0;
   unsigned long cur_dblock = 0 ;
   unsigned long newest_mount_id = 9 ;
@@ -1685,13 +1683,14 @@
   if (le32_to_cpu(jh->j_first_unflushed_offset) >= 0 && 
       le32_to_cpu(jh->j_first_unflushed_offset) < SB_ONDISK_JOURNAL_SIZE(p_s_sb) && 
       le32_to_cpu(jh->j_last_flush_trans_id) > 0) {
-    last_flush_start = SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
+    oldest_start = SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
                        le32_to_cpu(jh->j_first_unflushed_offset) ;
-    last_flush_trans_id = le32_to_cpu(jh->j_last_flush_trans_id) ;
+    oldest_trans_id = le32_to_cpu(jh->j_last_flush_trans_id) + 1;
+    newest_mount_id = le32_to_cpu(jh->j_mount_id);
     reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1153: found in "
                    "header: first_unflushed_offset %d, last_flushed_trans_id "
 		   "%lu\n", le32_to_cpu(jh->j_first_unflushed_offset), 
-		   last_flush_trans_id) ;
+		   le32_to_cpu(jh->j_last_flush_trans_id)) ;
     valid_journal_header = 1 ;
 
     /* now, we try to read the first unflushed offset.  If it is not valid, 
@@ -1704,6 +1703,7 @@
       continue_replay = 0 ;
     }
     brelse(d_bh) ;
+    goto start_log_replay;
   }
 
   if (continue_replay && is_read_only(p_s_sb->s_dev)) {
@@ -1746,17 +1746,13 @@
 	              "newest_mount_id to %d\n", le32_to_cpu(desc->j_mount_id));
       }
       cur_dblock += le32_to_cpu(desc->j_len) + 2 ;
-    } 
-    else {
+    } else {
       cur_dblock++ ;
     }
     brelse(d_bh) ;
   }
-  /* step three, starting at the oldest transaction, replay */
-  if (last_flush_start > 0) {
-    oldest_start = last_flush_start ;
-    oldest_trans_id = last_flush_trans_id + 1 ;
-  } 
+
+start_log_replay:
   cur_dblock = oldest_start ;
   if (oldest_trans_id)  {
     reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1206: Starting replay "

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mail8


This patch renames reiserfs debugging option in config output,
to make its meaning more clear.


--- linux-2.5.8-pre2/fs/Config.in.orig	Thu Mar 21 12:50:18 2002
+++ linux-2.5.8-pre2/fs/Config.in	Thu Mar 21 12:50:58 2002
@@ -9,7 +9,7 @@
 tristate 'Kernel automounter version 4 support (also supports v3)' CONFIG_AUTOFS4_FS
 
 tristate 'Reiserfs support' CONFIG_REISERFS_FS
-dep_mbool '  Have reiserfs do extra internal checking' CONFIG_REISERFS_CHECK $CONFIG_REISERFS_FS
+dep_mbool '  Enable reiserfs debug mode' CONFIG_REISERFS_CHECK $CONFIG_REISERFS_FS
 dep_mbool '  Stats in /proc/fs/reiserfs' CONFIG_REISERFS_PROC_INFO $CONFIG_REISERFS_FS
 
 dep_tristate 'ADFS file system support' CONFIG_ADFS_FS $CONFIG_EXPERIMENTAL

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mail9


This patch is to change comment of CONFIG_REISERFS_PROC_INFO config item,
to make it more clear.

===== Config.help 1.4 vs 1.5 =====
--- 1.4/fs/Config.help	Mon Feb 25 12:31:17 2002
+++ 1.5/fs/Config.help	Thu Mar 28 15:45:04 2002
@@ -59,12 +59,12 @@
   everyone should say N.
 
 CONFIG_REISERFS_PROC_INFO
-  Create under /proc/fs/reiserfs hierarchy of files, displaying
-  various ReiserFS statistics and internal data on the expense of
-  making your kernel or module slightly larger (+8 KB).  This also
-  increases amount of kernel memory required for each mount.  Almost
-  everyone but ReiserFS developers and people fine-tuning reiserfs or
-  tracing problems should say N.
+  Create under /proc/fs/reiserfs a hierarchy of files, displaying
+  various ReiserFS statistics and internal data at the expense of
+  making your kernel or module slightly larger (+8 KB). This also
+  increases the amount of kernel memory required for each mount.
+  Almost everyone but ReiserFS developers and people fine-tuning
+  reiserfs or tracing problems should say N.
 
 CONFIG_EXT2_FS
   This is the de facto standard Linux file system (method to organize

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mail10


This patch removes confusing warning about journal replay on readonly FS

--- linux-2.5.8-pre2/fs/reiserfs/journal.c.orig	Mon Apr  8 15:32:20 2002
+++ linux-2.5.8-pre2/fs/reiserfs/journal.c	Mon Apr  8 15:32:36 2002
@@ -1710,9 +1710,6 @@
     printk("clm-2076: device is readonly, unable to replay log\n") ;
     return -1 ;
   }
-  if (continue_replay && (p_s_sb->s_flags & MS_RDONLY)) {
-    printk("Warning, log replay starting on readonly filesystem\n") ;    
-  }
 
   /* ok, there are transactions that need to be replayed.  start with the first log block, find
   ** all the valid transactions, and pick out the oldest.

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mail11


This patch removes one tail_conversion object out of build list,
because it was specified twice. (noticed by Jeff Garzik)

===== fs/reiserfs/Makefile 1.5 vs 1.6 =====
--- 1.5/fs/reiserfs/Makefile	Tue Feb  5 18:28:32 2002
+++ 1.6/fs/reiserfs/Makefile	Thu Mar 28 15:50:18 2002
@@ -9,7 +9,7 @@
 
 O_TARGET := reiserfs.o
 obj-y   := bitmap.o do_balan.o namei.o inode.o file.o dir.o fix_node.o super.o prints.o objectid.o \
-lbalance.o ibalance.o stree.o hashes.o buffer2.o tail_conversion.o journal.o resize.o tail_conversion.o item_ops.o ioctl.o procfs.o
+lbalance.o ibalance.o stree.o hashes.o buffer2.o tail_conversion.o journal.o resize.o item_ops.o ioctl.o procfs.o
 
 obj-m   := $(O_TARGET)
 

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mail12


 This patch fixes a problem that was created during inode structure
 cleanup/ private parts separation. This fix was made by Chris Mason.
 This is very critical bugfix. Without it, filesystem corruption
 happens on savelinks processing and possibly in some other cases.


--- linux-2.5.8-pre2/fs/reiserfs/inode.c.orig	Mon Apr  8 14:09:57 2002
+++ linux-2.5.8-pre2/fs/reiserfs/inode.c	Mon Apr  8 14:23:15 2002
@@ -1111,8 +1111,19 @@
     return;
 }
 
+/* reiserfs_read_inode2 is called to read the inode off disk, and it
+** does a make_bad_inode when things go wrong.  But, we need to make sure
+** and clear the key in the private portion of the inode, otherwise a
+** corresponding iput might try to delete whatever object the inode last
+** represented.
+*/
+static void reiserfs_make_bad_inode(struct inode *inode) {
+    memset(INODE_PKEY(inode), 0, KEY_SIZE);
+    make_bad_inode(inode);
+}
+
 void reiserfs_read_inode(struct inode *inode) {
-    make_bad_inode(inode) ;
+    reiserfs_make_bad_inode(inode) ;
 }
 
 
@@ -1132,7 +1143,7 @@
     int retval;
 
     if (!p) {
-	make_bad_inode(inode) ;
+	reiserfs_make_bad_inode(inode) ;
 	return;
     }
 
@@ -1152,13 +1163,13 @@
 	reiserfs_warning ("vs-13070: reiserfs_read_inode2: "
                     "i/o failure occurred trying to find stat data of %K\n",
                     &key);
-	make_bad_inode(inode) ;
+	reiserfs_make_bad_inode(inode) ;
 	return;
     }
     if (retval != ITEM_FOUND) {
 	/* a stale NFS handle can trigger this without it being an error */
 	pathrelse (&path_to_sd);
-	make_bad_inode(inode) ;
+	reiserfs_make_bad_inode(inode) ;
 	inode->i_nlink = 0;
 	return;
     }
@@ -1185,7 +1196,7 @@
 			      "dead inode read from disk %K. "
 			      "This is likely to be race with knfsd. Ignore\n", 
 			      &key );
-	    make_bad_inode( inode );
+	    reiserfs_make_bad_inode( inode );
     }
 
     reiserfs_check_path(&path_to_sd) ; /* init inode should be relsing */
--- linux-2.5.8-pre2/fs/reiserfs/super.c.orig	Mon Apr  8 14:00:50 2002
+++ linux-2.5.8-pre2/fs/reiserfs/super.c	Mon Apr  8 14:23:15 2002
@@ -746,9 +746,8 @@
     //
     // ok, reiserfs signature (old or new) found in at the given offset
     //    
-    brelse (bh);
-    
     sb_set_blocksize (s, sb_blocksize(rs));
+    brelse (bh);
     
     bh = reiserfs_bread (s, offset / s->s_blocksize);
     if (!bh) {

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mail13


  This patch fixes small typo in ikernel informational message.

--- linux-2.5.8-pre2/fs/reiserfs/super.c.orig	Mon Apr  8 14:23:15 2002
+++ linux-2.5.8-pre2/fs/reiserfs/super.c	Mon Apr  8 14:24:23 2002
@@ -769,7 +769,7 @@
     if ( rs->s_v1.s_root_block == -1 ) {
        brelse(bh) ;
        printk("dev %s: Unfinished reiserfsck --rebuild-tree run detected. Please run\n"
-              "reiserfsck --rebuild-tree and wait for a completion. If that fais\n"
+              "reiserfsck --rebuild-tree and wait for a completion. If that fails\n"
               "get newer reiserfsprogs package\n", s->s_id);
        return 1;
     }

--G4iJoqBmSsgzjUCe--



--------------070000050909010801050800--

