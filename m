Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSHIQiD>; Fri, 9 Aug 2002 12:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSHIQhu>; Fri, 9 Aug 2002 12:37:50 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:51329 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S314602AbSHIQeJ>;
	Fri, 9 Aug 2002 12:34:09 -0400
Date: Fri, 9 Aug 2002 20:36:39 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200208091636.g79GadOY007885@bitshadow.namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [BK] [PATCH] reiserfs changeset 5 of 7 to include into 2.4 tree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   This changeset implements clearing of private parts of reiserfs inode
   structure which is believed to help to prevent races between knfsd and
   reiserfs wrt accessing deleted files.
   You can pull it from bk://thebsh.namesys.com/bk/reiser3-linux-2.4

Diffstat:

 inode.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.685   -> 1.686  
#	 fs/reiserfs/inode.c	1.33    -> 1.34   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/06	green@angband.namesys.com	1.686
# inode.c:
#   Clear private reiserfs struct parts in inode as part
#   of make_bad_inode(), this should prevent messages about races between knfsd
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Tue Aug  6 10:38:13 2002
+++ b/fs/reiserfs/inode.c	Tue Aug  6 10:38:13 2002
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
