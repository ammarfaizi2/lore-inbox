Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSFJNvz>; Mon, 10 Jun 2002 09:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315213AbSFJNvI>; Mon, 10 Jun 2002 09:51:08 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:27008 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315239AbSFJNuQ>;
	Mon, 10 Jun 2002 09:50:16 -0400
Date: Mon, 10 Jun 2002 17:42:55 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADgtBX003845@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 2 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 2 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message

  Creaets reiserfscode to use reiserfs_bdevname(s) instead of s->s_id. 
  By Josh MacDonald.

Chris Mason spent a lot of efforts in helping to convert this changeset to
Linus-compatible form.

Diffstat:
 fs/reiserfs/bitmap.c           |    4 ++--
 fs/reiserfs/inode.c            |    5 +++--
 fs/reiserfs/journal.c          |   10 +++-------
 fs/reiserfs/namei.c            |    2 +-
 fs/reiserfs/prints.c           |    2 +-
 fs/reiserfs/procfs.c           |    6 +++---
 fs/reiserfs/super.c            |   14 +++++++-------
 include/linux/reiserfs_fs_sb.h |    8 ++++++++
 8 files changed, 28 insertions(+), 23 deletions(-)

Plaintext patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.595   -> 1.596  
#	 fs/reiserfs/namei.c	1.37    -> 1.38   
#	fs/reiserfs/journal.c	1.44    -> 1.45   
#	fs/reiserfs/procfs.c	1.8     -> 1.9    
#	 fs/reiserfs/inode.c	1.59    -> 1.60   
#	 fs/reiserfs/super.c	1.43    -> 1.44   
#	include/linux/reiserfs_fs_sb.h	1.12    -> 1.13   
#	fs/reiserfs/prints.c	1.17    -> 1.18   
#	fs/reiserfs/bitmap.c	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.596
# Many files:
#   reiserfs: use reiserfs_bdevname(s) instead of s->s_id. From Josh MacDonald.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/bitmap.c b/fs/reiserfs/bitmap.c
--- a/fs/reiserfs/bitmap.c	Thu May 30 18:42:16 2002
+++ b/fs/reiserfs/bitmap.c	Thu May 30 18:42:16 2002
@@ -103,7 +103,7 @@
   if (nr >= sb_bmap_nr (rs)) {
 	  reiserfs_warning ("vs-4075: reiserfs_free_block: "
 			    "block %lu is out of range on %s\n", 
-			    block, s->s_id);
+			    block, reiserfs_bdevname (s));
 	  return;
   }
 
@@ -113,7 +113,7 @@
   if (!reiserfs_test_and_clear_le_bit (offset, apbh[nr]->b_data)) {
       reiserfs_warning ("vs-4080: reiserfs_free_block: "
 			"free_block (%s:%lu)[dev:blocknr]: bit already cleared\n", 
-	    s->s_id, block);
+			reiserfs_bdevname (s), block);
   }
   journal_mark_dirty (th, s, apbh[nr]);
 
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Thu May 30 18:42:16 2002
+++ b/fs/reiserfs/inode.c	Thu May 30 18:42:16 2002
@@ -1725,7 +1725,8 @@
 	** call prepare_write
 	*/
 	reiserfs_warning("clm-6000: error reading block %lu on dev %s\n",
-	                  bh->b_blocknr, p_s_inode->i_sb->s_id) ;
+			 bh->b_blocknr,
+			 reiserfs_bdevname (p_s_inode->i_sb)) ;
 	error = -EIO ;
 	goto unlock ;
     }
@@ -1894,7 +1895,7 @@
 	    goto research ;
 	}
     } else {
-        reiserfs_warning("clm-6003: bad item inode %lu, device %s\n", inode->i_ino, inode->i_sb->s_id) ;
+        reiserfs_warning("clm-6003: bad item inode %lu, device %s\n", inode->i_ino, reiserfs_bdevname (inode->i_sb)) ;
         retval = -EIO ;
 	goto out ;
     }
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Thu May 30 18:42:16 2002
+++ b/fs/reiserfs/journal.c	Thu May 30 18:42:16 2002
@@ -1667,7 +1667,7 @@
 
   cur_dblock = SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) ;
   printk("reiserfs: checking transaction log (%s) for (%s)\n",
-	 __bdevname(SB_JOURNAL_DEV(p_s_sb)), p_s_sb->s_id) ;
+	 __bdevname(SB_JOURNAL_DEV(p_s_sb)), reiserfs_bdevname(p_s_sb));
   start = CURRENT_TIME ;
 
   /* step 1, read in the journal header block.  Check the transaction it says 
@@ -2052,15 +2052,11 @@
      
      /* make sure that journal matches to the super block */
      if (is_reiserfs_jr(rs) && (jh->jh_journal.jp_journal_magic != sb_jp_journal_magic(rs))) {
-	 char jname[ 32 ];
-	 char fname[ 32 ];
 	 
-	 strcpy( jname, kdevname( SB_JOURNAL_DEV(p_s_sb) ) );
-	 strcpy( fname, p_s_sb->s_id);
 	 printk("sh-460: journal header magic %x (device %s) does not match "
 		"to magic found in super block %x (device %s)\n",
-		jh->jh_journal.jp_journal_magic, jname,
-		sb_jp_journal_magic(rs), fname);
+		jh->jh_journal.jp_journal_magic, kdevname( SB_JOURNAL_DEV(p_s_sb) ),
+		sb_jp_journal_magic(rs), reiserfs_bdevname (p_s_sb));
 	 brelse (bhjh);
 	 release_journal_dev(p_s_sb, journal);
 	 return 1 ;
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Thu May 30 18:42:16 2002
+++ b/fs/reiserfs/namei.c	Thu May 30 18:42:16 2002
@@ -918,7 +918,7 @@
   
     if (!inode->i_nlink) {
 	printk("reiserfs_unlink: deleting nonexistent file (%s:%lu), %d\n",
-	       inode->i_sb->s_id, inode->i_ino, inode->i_nlink);
+	       reiserfs_bdevname (inode->i_sb), inode->i_ino, inode->i_nlink);
 	inode->i_nlink = 1;
     }
 
diff -Nru a/fs/reiserfs/prints.c b/fs/reiserfs/prints.c
--- a/fs/reiserfs/prints.c	Thu May 30 18:42:16 2002
+++ b/fs/reiserfs/prints.c	Thu May 30 18:42:16 2002
@@ -337,7 +337,7 @@
 
   /* this is not actually called, but makes reiserfs_panic() "noreturn" */
   panic ("REISERFS: panic (device %s): %s\n",
-	 sb ? sb->s_id : "sb == 0", error_buf);
+	 reiserfs_bdevname (sb), error_buf);
 }
 
 
diff -Nru a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
--- a/fs/reiserfs/procfs.c	Thu May 30 18:42:16 2002
+++ b/fs/reiserfs/procfs.c	Thu May 30 18:42:16 2002
@@ -556,13 +556,13 @@
 int reiserfs_proc_info_init( struct super_block *sb )
 {
 	spin_lock_init( & __PINFO( sb ).lock );
-	REISERFS_SB(sb)->procdir = proc_mkdir(sb->s_id, proc_info_root);
+	REISERFS_SB(sb)->procdir = proc_mkdir(reiserfs_bdevname (sb), proc_info_root);
 	if( REISERFS_SB(sb)->procdir ) {
 		REISERFS_SB(sb)->procdir -> owner = THIS_MODULE;
 		return 0;
 	}
 	reiserfs_warning( "reiserfs: cannot create /proc/%s/%s\n",
-			  proc_info_root_name, sb->s_id );
+			  proc_info_root_name, reiserfs_bdevname (sb) );
 	return 1;
 }
 
@@ -573,7 +573,7 @@
 	__PINFO( sb ).exiting = 1;
 	spin_unlock( & __PINFO( sb ).lock );
 	if ( proc_info_root ) {
-		remove_proc_entry( sb->s_id, proc_info_root );
+		remove_proc_entry( reiserfs_bdevname (sb), proc_info_root );
 		REISERFS_SB(sb)->procdir = NULL;
 	}
 	return 0;
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Thu May 30 18:42:16 2002
+++ b/fs/reiserfs/super.c	Thu May 30 18:42:16 2002
@@ -735,7 +735,7 @@
     if (!bh) {
       printk ("sh-2006: read_super_block: "
               "bread failed (dev %s, block %lu, size %lu)\n",
-              s->s_id, offset / s->s_blocksize, s->s_blocksize);
+              reiserfs_bdevname (s), offset / s->s_blocksize, s->s_blocksize);
       return 1;
     }
  
@@ -755,7 +755,7 @@
     if (!bh) {
 	printk("sh-2007: read_super_block: "
                 "bread failed (dev %s, block %lu, size %lu)\n",
-                s->s_id, offset / s->s_blocksize, s->s_blocksize);
+                reiserfs_bdevname (s), offset / s->s_blocksize, s->s_blocksize);
 	return 1;
     }
     
@@ -763,7 +763,7 @@
     if (sb_blocksize(rs) != s->s_blocksize) {
 	printk ("sh-2011: read_super_block: "
 		"can't find a reiserfs filesystem on (dev %s, block %lu, size %lu)\n",
-		s->s_id, bh->b_blocknr, s->s_blocksize);
+		reiserfs_bdevname (s), bh->b_blocknr, s->s_blocksize);
 	brelse (bh);
 	return 1;
     }
@@ -772,7 +772,7 @@
        brelse(bh) ;
        printk("dev %s: Unfinished reiserfsck --rebuild-tree run detected. Please run\n"
               "reiserfsck --rebuild-tree and wait for a completion. If that fails\n"
-              "get newer reiserfsprogs package\n", s->s_id);
+              "get newer reiserfsprogs package\n", reiserfs_bdevname (s));
        return 1;
     }
 
@@ -884,7 +884,7 @@
 	     ( (r5hash == yurahash) && (yurahash == GET_HASH_VALUE( deh_offset(&(de.de_deh[de.de_entry_num])))) ) ) {
 	    reiserfs_warning("reiserfs: Unable to automatically detect hash"
 		"function for device %s\n"
-		"please mount with -o hash={tea,rupasov,r5}\n", s->s_id);
+		"please mount with -o hash={tea,rupasov,r5}\n", reiserfs_bdevname (s));
 	    hash = UNSET_HASH;
 	    break;
 	}
@@ -896,7 +896,7 @@
 	    hash = R5_HASH;
 	else {
 	    reiserfs_warning("reiserfs: Unrecognised hash function for "
-			     "device %s\n", s->s_id);
+			     "device %s\n", reiserfs_bdevname (s));
 	    hash = UNSET_HASH;
 	}
     } while (0);
@@ -1031,7 +1031,7 @@
       old_format = 1;
     /* try new format (64-th 1k block), which can contain reiserfs super block */
     else if (read_super_block (s, REISERFS_DISK_OFFSET_IN_BYTES)) {
-      printk("sh-2021: reiserfs_fill_super: can not find reiserfs on %s\n", s->s_id);
+      printk("sh-2021: reiserfs_fill_super: can not find reiserfs on %s\n", reiserfs_bdevname (s));
       goto error;    
     }
     sbi->s_mount_state = SB_REISERFS_STATE(s);
diff -Nru a/include/linux/reiserfs_fs_sb.h b/include/linux/reiserfs_fs_sb.h
--- a/include/linux/reiserfs_fs_sb.h	Thu May 30 18:42:16 2002
+++ b/include/linux/reiserfs_fs_sb.h	Thu May 30 18:42:16 2002
@@ -456,4 +456,12 @@
 #define SB_JOURNAL_MAX_TRANS_AGE(s)  (SB_JOURNAL(s)->s_journal_max_trans_age)
 #define SB_JOURNAL_DEV(s)            (SB_JOURNAL(s)->j_dev)
 
+/* A safe version of the "bdevname", which returns the "s_id" field of
+ * a superblock or else "Null superblock" if the super block is NULL.
+ */
+static inline char *reiserfs_bdevname(struct super_block *s)
+{
+        return (s == NULL) ? "Null superblock" : s -> s_id;
+}
+
 #endif	/* _LINUX_REISER_FS_SB */
