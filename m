Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315864AbSEGPMX>; Tue, 7 May 2002 11:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315858AbSEGPMW>; Tue, 7 May 2002 11:12:22 -0400
Received: from backtop.namesys.com ([212.16.7.71]:6529 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315864AbSEGPLN>;
	Tue, 7 May 2002 11:11:13 -0400
Date: Tue, 7 May 2002 19:05:44 +0400
From: Hans Reiser <reiser@namesys.com>
Message-Id: <200205071505.g47F5i104037@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.4] Reiserfs changeset 1 out of 4, please apply.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

  You can get this changeset from bk://thebsh.namesys.com/bk/reiser3-linux-2.4

  This changeset clarifies config descriptions of reiserfs-related config
  options, it also fixes a bug with incorrect transactions being replayed in
  some very rare cases and allows to change hash on empty filesystems.

Diffstat:
 Documentation/Configure.help |   13 +++++++------
 fs/Config.in                 |    2 +-
 fs/reiserfs/journal.c        |   23 ++++++++---------------
 fs/reiserfs/super.c          |   23 +++++++++++++++--------
 4  files changed, 31 insertions(+), 30 deletions(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.383.2.34 -> 1.383.2.35
#	fs/reiserfs/journal.c	1.21    -> 1.23   
#	        fs/Config.in	1.15    -> 1.16   
#	 fs/reiserfs/super.c	1.18    -> 1.19   
#	Documentation/Configure.help	1.93    -> 1.94   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/16	green@angband.namesys.com	1.383.2.35
# journal.c:
#   Fixed journal replay bug where old code would replay transactions with
#   mount_id != mount_id recorded in journal header.
#   By Chris Mason.
# super.c:
#   Allow to change hash function for empty fs with
#   mount option
# journal.c:
#   Remove confusing warning about journal replay on readonly FS
# Config.in:
#   Rename REISERFS_CHECK option to show it;s true meaning
# Configure.help:
#   Rewrite REISERFS_PROC_INFO comment to make it more clear
# --------------------------------------------
#
diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Tue May  7 17:53:59 2002
+++ b/Documentation/Configure.help	Tue May  7 17:53:59 2002
@@ -14171,12 +14171,13 @@
 
 Publish some reiserfs-specific info under /proc/fs/reiserfs
 CONFIG_REISERFS_PROC_INFO
-  Create under /proc/fs/reiserfs hierarchy of files, displaying
-  various ReiserFS statistics and internal data on the expense of
-  making your kernel or module slightly larger (+8 KB).  This also
-  increases amount of kernel memory required for each mount.  Almost
-  everyone but ReiserFS developers and people fine-tuning reiserfs or
-  tracing problems should say N.
+  Create under /proc/fs/reiserfs a hierarchy of files, displaying
+  various ReiserFS statistics and internal data at the expense of making
+  your kernel or module slightly larger (+8 KB). This also increases the
+  amount of kernel memory required for each mount by 440 bytes.
+  It isn't useful to average persons, and you probably can't measure the
+  performance cost of it.  If you are fine-tuning reiserfs, say Y,
+  otherwise say N.
 
 Second extended fs support
 CONFIG_EXT2_FS
diff -Nru a/fs/Config.in b/fs/Config.in
--- a/fs/Config.in	Tue May  7 17:53:59 2002
+++ b/fs/Config.in	Tue May  7 17:53:59 2002
@@ -9,7 +9,7 @@
 tristate 'Kernel automounter version 4 support (also supports v3)' CONFIG_AUTOFS4_FS
 
 tristate 'Reiserfs support' CONFIG_REISERFS_FS
-dep_mbool '  Have reiserfs do extra internal checking' CONFIG_REISERFS_CHECK $CONFIG_REISERFS_FS
+dep_mbool '  Enable reiserfs debug mode' CONFIG_REISERFS_CHECK $CONFIG_REISERFS_FS
 dep_mbool '  Stats in /proc/fs/reiserfs' CONFIG_REISERFS_PROC_INFO $CONFIG_REISERFS_FS
 
 dep_tristate 'ADFS file system support' CONFIG_ADFS_FS $CONFIG_EXPERIMENTAL
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Tue May  7 17:53:59 2002
+++ b/fs/reiserfs/journal.c	Tue May  7 17:53:59 2002
@@ -1630,11 +1630,9 @@
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
@@ -1664,13 +1662,14 @@
   if (le32_to_cpu(jh->j_first_unflushed_offset) >= 0 && 
       le32_to_cpu(jh->j_first_unflushed_offset) < JOURNAL_BLOCK_COUNT &&
       le32_to_cpu(jh->j_last_flush_trans_id) > 0) {
-    last_flush_start = reiserfs_get_journal_block(p_s_sb) + 
+    oldest_start = reiserfs_get_journal_block(p_s_sb) + 
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
@@ -1683,15 +1682,13 @@
       continue_replay = 0 ;
     }
     brelse(d_bh) ;
+    goto start_log_replay;
   }
 
   if (continue_replay && is_read_only(p_s_sb->s_dev)) {
     printk("clm-2076: device is readonly, unable to replay log\n") ;
     return -1 ;
   }
-  if (continue_replay && (p_s_sb->s_flags & MS_RDONLY)) {
-    printk("Warning, log replay starting on readonly filesystem\n") ;    
-  }
 
   /* ok, there are transactions that need to be replayed.  start with the first log block, find
   ** all the valid transactions, and pick out the oldest.
@@ -1725,17 +1722,13 @@
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
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Tue May  7 17:53:59 2002
+++ b/fs/reiserfs/super.c	Tue May  7 17:53:59 2002
@@ -793,10 +793,10 @@
 // hash detection stuff
 
 
-// if root directory is empty - we set default - Yura's - hash and
-// warn about it
+// if root directory is empty and no hash hint were supplied - we set 
+// default - r5 hash - (Rupasov's Hash Number 5) and warn about it.
 // FIXME: we look for only one name in a directory. If tea and yura
-// bith have the same value - we ask user to send report to the
+// both have the same value - we ask user to send report to the
 // mailing list
 __u32 find_hash_out (struct super_block * s)
 {
@@ -822,12 +822,19 @@
 	    de.de_entry_num --;
 	set_de_name_and_namelen (&de);
 	if (deh_offset( &(de.de_deh[de.de_entry_num]) ) == DOT_DOT_OFFSET) {
-	    /* allow override in this case */
-	    if (reiserfs_rupasov_hash(s)) {
-		hash = YURA_HASH ;
+	    if ( reiserfs_hash_detect(s) ) { // Hash hint was supplied
+	        if (reiserfs_rupasov_hash(s)) {
+		    hash = YURA_HASH ;
+		} else if (reiserfs_tea_hash(s)) {
+		    hash = TEA_HASH ;
+		} else if (reiserfs_r5_hash(s)) {
+		    hash = R5_HASH ;
+		}
+	    } 
+	    if (!(s->u.reiserfs_sb.s_mount_opt & (1<<FORCE_RUPASOV_HASH|1<<FORCE_TEA_HASH|1<<FORCE_R5_HASH)) ) { // we need this for hash=detect case
+		reiserfs_warning("reiserfs: FS seems to be empty, autodetect "
+				 "is using the default %s hash\n", reiserfs_hashname(hash));
 	    }
-	    reiserfs_warning("reiserfs: FS seems to be empty, autodetect "
-	                     "is using the default hash\n");
 	    break;
 	}
 	r5hash=GET_HASH_VALUE (r5_hash (de.de_name, de.de_namelen));
