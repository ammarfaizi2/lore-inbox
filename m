Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314227AbSFJNvy>; Mon, 10 Jun 2002 09:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSFJNvC>; Mon, 10 Jun 2002 09:51:02 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:25216 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315213AbSFJNuQ>;
	Mon, 10 Jun 2002 09:50:16 -0400
Date: Mon, 10 Jun 2002 17:42:55 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADgtS3003854@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 5 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 5 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message

   This patch moves BKL further down the call chain into reiserfs_truncate_file.
   By Josh MacDonald.

Chris Mason spent a lot of efforts in helping to convert this changeset to
Linus-compatible form.

Diffstat:
 file.c  |    2 --
 inode.c |    5 +++--
 stree.c |    4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

Plaintext patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.598   -> 1.599  
#	  fs/reiserfs/file.c	1.14    -> 1.15   
#	 fs/reiserfs/inode.c	1.61    -> 1.62   
#	 fs/reiserfs/stree.c	1.29    -> 1.30   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.599
# stree.c, inode.c, file.c:
#   reiserfs: move BKL further down the call chain into reiserfs_truncate_file. From Josh MacDonald
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/file.c b/fs/reiserfs/file.c
--- a/fs/reiserfs/file.c	Thu May 30 18:42:19 2002
+++ b/fs/reiserfs/file.c	Thu May 30 18:42:19 2002
@@ -66,9 +66,7 @@
 }
 
 static void reiserfs_vfs_truncate_file(struct inode *inode) {
-    lock_kernel();
     reiserfs_truncate_file(inode, 1) ;
-    unlock_kernel();
 }
 
 /* Sync a reiserfs file. */
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Thu May 30 18:42:19 2002
+++ b/fs/reiserfs/inode.c	Thu May 30 18:42:19 2002
@@ -1738,7 +1738,6 @@
 void reiserfs_truncate_file(struct inode *p_s_inode, int update_timestamps) {
     struct reiserfs_transaction_handle th ;
     int windex ;
-
     /* we want the offset for the first byte after the end of the file */
     unsigned long offset = p_s_inode->i_size & (PAGE_CACHE_SIZE - 1) ;
     unsigned blocksize = p_s_inode->i_sb->s_blocksize ;
@@ -1747,6 +1746,8 @@
     int error ;
     struct buffer_head *bh = NULL ;
 
+    lock_kernel ();
+
     if (p_s_inode->i_size > 0) {
         if ((error = grab_tail_page(p_s_inode, &page, &bh))) {
 	    // -ENOENT means we truncated past the end of the file, 
@@ -1800,7 +1801,7 @@
 	page_cache_release(page) ;
     }
 
-    return ;
+    unlock_kernel ();
 }
 
 static int map_block_for_writepage(struct inode *inode, 
diff -Nru a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
--- a/fs/reiserfs/stree.c	Thu May 30 18:42:19 2002
+++ b/fs/reiserfs/stree.c	Thu May 30 18:42:19 2002
@@ -1715,13 +1715,13 @@
 	/* Cut or delete file item. */
 	n_deleted = reiserfs_cut_from_item(th, &s_search_path, &s_item_key, p_s_inode,  page, n_new_file_size);
 	if (n_deleted < 0) {
-	    reiserfs_warning ("vs-5665: reiserfs_truncate_file: cut_from_item failed");
+	    reiserfs_warning ("vs-5665: reiserfs_do_truncate: reiserfs_cut_from_item failed");
 	    reiserfs_check_path(&s_search_path) ;
 	    return;
 	}
 
 	RFALSE( n_deleted > n_file_size,
-		"PAP-5670: reiserfs_truncate_file returns too big number: deleted %d, file_size %lu, item_key %K",
+		"PAP-5670: reiserfs_cut_from_item: too many bytes deleted: deleted %d, file_size %lu, item_key %K",
 		n_deleted, n_file_size, &s_item_key);
 
 	/* Change key to search the last file item. */
