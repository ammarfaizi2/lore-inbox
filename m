Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263431AbTCNSw4>; Fri, 14 Mar 2003 13:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263436AbTCNSw4>; Fri, 14 Mar 2003 13:52:56 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:6049 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S263431AbTCNSwv>;
	Fri, 14 Mar 2003 13:52:51 -0500
Message-ID: <3E722788.8010506@namesys.com>
Date: Fri, 14 Mar 2003 22:03:36 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: [BK][PATCH] ReiserFS Attempt 3: fix reiserfs memleaks on journal
 opening failures in 2.5.64
Content-Type: multipart/mixed;
 boundary="------------010201060808060508070403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010201060808060508070403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Hans


--------------010201060808060508070403
Content-Type: message/rfc822;
 name="Attempt 3: fix reiserfs memleaks on journal opening failures in 2.5.64"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Attempt 3: fix reiserfs memleaks on journal opening failures in 2.5.64"

Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 15482 invoked from network); 14 Mar 2003 16:41:35 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 14 Mar 2003 16:41:35 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id EE9103289C6; Fri, 14 Mar 2003 19:41:31 +0300 (MSK)
Date: Fri, 14 Mar 2003 19:41:31 +0300
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: Attempt 3: fix reiserfs memleaks on journal opening failures in 2.5.64
Message-ID: <20030314194131.A20489@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i

Hello!

    This changesets forward-ports Chris Mason's fixes to free up allocated
    memory when we fail to open relocated journal in reiserfs. Also
    it adds new line marks in printed messages, when needed.

    Please pull it from: bk://thebsh.namesys.com/bk/reiser3-linux-2.5-relocation-fix

Diffstat:
 journal.c |   76 +++++++++++++++++++++++++++++---------------------------------
 1 files changed, 36 insertions(+), 40 deletions(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1105  -> 1.1106 
#	fs/reiserfs/journal.c	1.65    -> 1.66   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/14	green@angband.namesys.com	1.1106
# reiserfs: Correctly free all the allocated memory if open of the journal failed.
#   Also added \n to some error messages.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Fri Mar 14 19:30:28 2003
+++ b/fs/reiserfs/journal.c	Fri Mar 14 19:30:28 2003
@@ -1310,6 +1310,10 @@
   if (SB_JOURNAL(p_s_sb)->j_header_bh) {
     brelse(SB_JOURNAL(p_s_sb)->j_header_bh) ;
   }
+  /* j_header_bh is on the journal dev, make sure not to release the journal
+   * dev until we brelse j_header_bh
+   */
+  release_journal_dev(p_s_sb, SB_JOURNAL(p_s_sb));
   vfree(SB_JOURNAL(p_s_sb)) ;
 }
 
@@ -1341,7 +1345,6 @@
     commit_wq = NULL;
   }
 
-  release_journal_dev( p_s_sb, SB_JOURNAL( p_s_sb ) );
   free_journal_ram(p_s_sb) ;
 
   return 0 ;
@@ -1867,24 +1870,18 @@
     int result;
     
     result = 0;
-	
 
     if( journal -> j_dev_file != NULL ) {
-	/*
-	 * journal block device was taken via filp_open
-	 */
 	result = filp_close( journal -> j_dev_file, NULL );
 	journal -> j_dev_file = NULL;
 	journal -> j_dev_bd = NULL;
     } else if( journal -> j_dev_bd != NULL ) {
-	/*
-	 * journal block device was taken via bdget and blkdev_get
-	 */
 	result = blkdev_put( journal -> j_dev_bd, BDEV_FS );
 	journal -> j_dev_bd = NULL;
     }
+
     if( result != 0 ) {
-	reiserfs_warning("sh-457: release_journal_dev: Cannot release journal device: %i", result );
+	reiserfs_warning("sh-457: release_journal_dev: Cannot release journal device: %i\n", result );
     }
     return result;
 }
@@ -1895,6 +1892,7 @@
 {
 	int result;
 	dev_t jdev;
+	int blkdev_mode = FMODE_READ | FMODE_WRITE;
 
 	result = 0;
 
@@ -1902,12 +1900,16 @@
 	journal -> j_dev_file = NULL;
 	jdev = SB_ONDISK_JOURNAL_DEVICE( super ) ?
 		SB_ONDISK_JOURNAL_DEVICE( super ) : super->s_dev;	
+
+	if (bdev_read_only(super->s_bdev))
+	    blkdev_mode = FMODE_READ;
+
 	/* there is no "jdev" option and journal is on separate device */
 	if( ( !jdev_name || !jdev_name[ 0 ] ) ) {
 		journal -> j_dev_bd = bdget(jdev);
 		if( journal -> j_dev_bd )
 			result = blkdev_get( journal -> j_dev_bd, 
-					     FMODE_READ | FMODE_WRITE, 0, 
+					     blkdev_mode, 0, 
 					     BDEV_FS );
 		else
 			result = -ENOMEM;
@@ -1928,10 +1930,10 @@
 		jdev_inode = journal -> j_dev_file -> f_dentry -> d_inode;
 		journal -> j_dev_bd = jdev_inode -> i_bdev;
 		if( !S_ISBLK( jdev_inode -> i_mode ) ) {
-			printk( "journal_init_dev: '%s' is not a block device", jdev_name );
+			printk( "journal_init_dev: '%s' is not a block device\n", jdev_name );
 			result = -ENOTBLK;
 		} else if( jdev_inode -> i_bdev == NULL ) {
-			printk( "journal_init_dev: bdev uninitialized for '%s'", jdev_name );
+			printk( "journal_init_dev: bdev uninitialized for '%s'\n", jdev_name );
 			result = -ENOMEM;
 		} else  {
 			/* ok */
@@ -1941,12 +1943,12 @@
 	} else {
 		result = PTR_ERR( journal -> j_dev_file );
 		journal -> j_dev_file = NULL;
-		printk( "journal_init_dev: Cannot open '%s': %i", jdev_name, result );
+		printk( "journal_init_dev: Cannot open '%s': %i\n", jdev_name, result );
 	}
 	if( result != 0 ) {
 		release_journal_dev( super, journal );
 	}
-	printk( "journal_init_dev: journal device: %s", bdevname(journal->j_dev_bd));
+	printk( "journal_init_dev: journal device: %s\n", bdevname(journal->j_dev_bd));
 	return result;
 }
 
@@ -1960,20 +1962,24 @@
     struct reiserfs_journal_header *jh;
     struct reiserfs_journal *journal;
 
-  if (sizeof(struct reiserfs_journal_commit) != 4096 ||
-      sizeof(struct reiserfs_journal_desc) != 4096
-     ) {
-    printk("journal-1249: commit or desc struct not 4096 %Zd %Zd\n", sizeof(struct reiserfs_journal_commit), 
+    if (sizeof(struct reiserfs_journal_commit) != 4096 ||
+      sizeof(struct reiserfs_journal_desc) != 4096) {
+	printk("journal-1249: commit or desc struct not 4096 %Zd %Zd\n", sizeof(struct reiserfs_journal_commit), 
         sizeof(struct reiserfs_journal_desc)) ;
-    return 1 ;
-  }
+	return 1 ;
+    }
 
     journal = SB_JOURNAL(p_s_sb) = vmalloc(sizeof (struct reiserfs_journal)) ;
     if (!journal) {
 	printk("journal-1256: unable to get memory for journal structure\n") ;
-    return 1 ;
-  }
+	return 1 ;
+    }
     memset(journal, 0, sizeof(struct reiserfs_journal)) ;
+    INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_bitmap_nodes) ;
+    INIT_LIST_HEAD (&SB_JOURNAL(p_s_sb)->j_prealloc_list);
+    reiserfs_allocate_list_bitmaps(p_s_sb, SB_JOURNAL(p_s_sb)->j_list_bitmap, 
+ 				   SB_BMAP_NR(p_s_sb)) ;
+    allocate_bitmap_nodes(p_s_sb) ;
 
     /* reserved for journal area support */
     SB_JOURNAL_1st_RESERVED_BLOCK(p_s_sb) = (old_format ?
@@ -1983,7 +1989,7 @@
     
     if( journal_init_dev( p_s_sb, journal, j_dev_name ) != 0 ) {
       printk( "sh-462: unable to initialize jornal device\n");
-      return 1;
+      goto free_and_return;
     }
 
      rs = SB_DISK_SUPER_BLOCK(p_s_sb);
@@ -1993,8 +1999,7 @@
 		   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_ONDISK_JOURNAL_SIZE(p_s_sb));
      if (!bhjh) {
 	 printk("sh-459: unable to read  journal header\n") ;
-	 release_journal_dev(p_s_sb, journal);
-	 return 1 ;
+	 goto free_and_return;
      }
      jh = (struct reiserfs_journal_header *)(bhjh->b_data);
      
@@ -2005,8 +2010,7 @@
 		jh->jh_journal.jp_journal_magic, bdevname( SB_JOURNAL(p_s_sb)->j_dev_bd ),
 		sb_jp_journal_magic(rs), reiserfs_bdevname (p_s_sb));
 	 brelse (bhjh);
-	 release_journal_dev(p_s_sb, journal);
-	 return 1 ;
+	 goto free_and_return;
   }
      
   SB_JOURNAL_TRANS_MAX(p_s_sb)      = le32_to_cpu (jh->jh_journal.jp_journal_trans_max);
@@ -2064,7 +2068,6 @@
 
   brelse (bhjh);
      
-
   SB_JOURNAL(p_s_sb)->j_list_bitmap_index = 0 ;
   SB_JOURNAL_LIST_INDEX(p_s_sb) = -10000 ; /* make sure flush_old_commits does not try to flush a list while replay is on */
 
@@ -2075,12 +2078,8 @@
   memset(SB_JOURNAL(p_s_sb)->j_list_hash_table, 0, JOURNAL_HASH_SIZE * sizeof(struct reiserfs_journal_cnode *)) ;
   memset(journal_writers, 0, sizeof(char *) * 512) ; /* debug code */
 
-  INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_bitmap_nodes) ;
   INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_dirty_buffers) ;
   spin_lock_init(&SB_JOURNAL(p_s_sb)->j_dirty_buffers_lock) ;
-  reiserfs_allocate_list_bitmaps(p_s_sb, SB_JOURNAL(p_s_sb)->j_list_bitmap, 
-                                 SB_BMAP_NR(p_s_sb)) ;
-  allocate_bitmap_nodes(p_s_sb) ;
 
   SB_JOURNAL(p_s_sb)->j_start = 0 ;
   SB_JOURNAL(p_s_sb)->j_len = 0 ;
@@ -2107,20 +2106,15 @@
   SB_JOURNAL_LIST(p_s_sb)[0].j_list_bitmap = get_list_bitmap(p_s_sb, SB_JOURNAL_LIST(p_s_sb)) ;
   if (!(SB_JOURNAL_LIST(p_s_sb)[0].j_list_bitmap)) {
     reiserfs_warning("journal-2005, get_list_bitmap failed for journal list 0\n") ;
-    release_journal_dev(p_s_sb, journal);
-    return 1 ;
+    goto free_and_return;
   }
   if (journal_read(p_s_sb) < 0) {
     reiserfs_warning("Replay Failure, unable to mount\n") ;
-    free_journal_ram(p_s_sb) ;
-    release_journal_dev(p_s_sb, journal);
-    return 1 ;
+    goto free_and_return;
   }
   SB_JOURNAL_LIST_INDEX(p_s_sb) = 0 ; /* once the read is done, we can set this
                                          where it belongs */
 
-  INIT_LIST_HEAD (&SB_JOURNAL(p_s_sb)->j_prealloc_list);
-
   if (reiserfs_dont_log (p_s_sb))
     return 0;
 
@@ -2129,7 +2123,9 @@
     commit_wq = create_workqueue("reiserfs");
 
   return 0 ;
-
+free_and_return:
+  free_journal_ram(p_s_sb);
+  return 1;
 }
 
 /*



--------------010201060808060508070403--

