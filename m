Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315862AbSEGPNc>; Tue, 7 May 2002 11:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315868AbSEGPNM>; Tue, 7 May 2002 11:13:12 -0400
Received: from backtop.namesys.com ([212.16.7.71]:6273 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315862AbSEGPLI>;
	Tue, 7 May 2002 11:11:08 -0400
Date: Tue, 7 May 2002 19:05:44 +0400
From: Hans Reiser <reiser@namesys.com>
Message-Id: <200205071505.g47F5iT04042@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.4] Reiserfs changeset 3 out of 4, please apply.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

  You can get this changeset from bk://thebsh.namesys.com/bk/reiser3-linux-2.4

  This changeset  fixes 2 incorrect padding problems and a race with knfsd,
  where file might be attemted to be deleted twice.

Diffstat:
 inode.c           |   17 ++++++++++++-----
 namei.c           |    2 +-
 tail_conversion.c |    2 +-
 3 files changed, 14 insertions(+), 7 deletions(-)

Plain text patch
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.383.2.39 -> 1.383.2.40
#	 fs/reiserfs/namei.c	1.20    -> 1.21   
#	 fs/reiserfs/inode.c	1.33    -> 1.34   
#	fs/reiserfs/tail_conversion.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/30	green@angband.namesys.com	1.383.2.40
# inode.c:
#   implemented reiserfs_make_bad_inode() function that
#   zeroes inode key therefore avoiding races with knfsd
#   and other stuff that might access files bypassing directory lookups
# tail_conversion.c:
#   old format DIRECT items were incorrectly aligned on new format filesystems
# namei.c:
#   old format DIR entries were incorrectly aligned on new format filesystems
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Tue May  7 17:54:21 2002
+++ b/fs/reiserfs/inode.c	Tue May  7 17:54:21 2002
@@ -1128,8 +1128,15 @@
     return;
 }
 
+/* We need to clear inode key in private part of inode to avoid races between
+   blocking iput, knfsd and file deletion with creating of safelinks.*/
+static void reiserfs_make_bad_inode(struct inode *inode) {
+    memset(INODE_PKEY(inode), 0, KEY_SIZE);
+    make_bad_inode(inode);
+}
+
 void reiserfs_read_inode(struct inode *inode) {
-    make_bad_inode(inode) ;
+    reiserfs_make_bad_inode(inode) ;
 }
 
 
@@ -1144,7 +1151,7 @@
     int retval;
 
     if (!p) {
-	make_bad_inode(inode) ;
+	reiserfs_make_bad_inode(inode) ;
 	return;
     }
 
@@ -1164,13 +1171,13 @@
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
@@ -1197,7 +1204,7 @@
 			      "dead inode read from disk %K. "
 			      "This is likely to be race with knfsd. Ignore\n", 
 			      &key );
-	    make_bad_inode( inode );
+	    reiserfs_make_bad_inode( inode );
     }
 
     reiserfs_check_path(&path_to_sd) ; /* init inode should be relsing */
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Tue May  7 17:54:21 2002
+++ b/fs/reiserfs/namei.c	Tue May  7 17:54:21 2002
@@ -388,7 +388,7 @@
     } else
 	buffer = small_buf;
 
-    paste_size = (old_format_only (dir->i_sb)) ? (DEH_SIZE + namelen) : buflen;
+    paste_size = (get_inode_sd_version (dir) == STAT_DATA_V1) ? (DEH_SIZE + namelen) : buflen;
 
     /* fill buffer : directory entry head, name[, dir objectid | , stat data | ,stat data, dir objectid ] */
     deh = (struct reiserfs_de_head *)buffer;
diff -Nru a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
--- a/fs/reiserfs/tail_conversion.c	Tue May  7 17:54:21 2002
+++ b/fs/reiserfs/tail_conversion.c	Tue May  7 17:54:21 2002
@@ -213,7 +213,7 @@
     copy_item_head (&s_ih, PATH_PITEM_HEAD(p_s_path));
 
     tail_len = (n_new_file_size & (n_block_size - 1));
-    if (!old_format_only (p_s_sb))
+    if (get_inode_sd_version (p_s_inode) == STAT_DATA_V2)
 	round_tail_len = ROUND_UP (tail_len);
     else
 	round_tail_len = tail_len;
