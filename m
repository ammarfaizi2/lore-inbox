Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbSKGDzc>; Wed, 6 Nov 2002 22:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266326AbSKGDxg>; Wed, 6 Nov 2002 22:53:36 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:43393 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S266320AbSKGDwY>;
	Wed, 6 Nov 2002 22:52:24 -0500
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ext2/3 bugfix 3/6: Check for failed kmalloc in ext3_htree_store_dirent
From: tytso@mit.edu
Message-Id: <E189dot-0007Gc-00@snap.thunk.org>
Date: Wed, 06 Nov 2002 22:59:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check for failed kmalloc() in ext3_htree_store_dirent()

This patch checks for a failed kmalloc() in ext3_htree_store_dirent(),
and passes the error up to its caller, ext3_htree_fill_tree().

fs/ext3/dir.c           |    7 +++++--
fs/ext3/namei.c         |   11 +++++++----
include/linux/ext3_fs.h |    2 +-
3 files changed, 13 insertions(+), 7 deletions(-)

diff -Nru a/fs/ext3/dir.c b/fs/ext3/dir.c
--- a/fs/ext3/dir.c	Wed Nov  6 17:30:01 2002
+++ b/fs/ext3/dir.c	Wed Nov  6 17:30:01 2002
@@ -314,7 +314,7 @@
 /*
  * Given a directory entry, enter it into the fname rb tree.
  */
-void ext3_htree_store_dirent(struct file *dir_file, __u32 hash,
+int ext3_htree_store_dirent(struct file *dir_file, __u32 hash,
 			     __u32 minor_hash,
 			     struct ext3_dir_entry_2 *dirent)
 {
@@ -329,6 +329,8 @@
 	/* Create and allocate the fname structure */
 	len = sizeof(struct fname) + dirent->name_len + 1;
 	new_fn = kmalloc(len, GFP_KERNEL);
+	if (!new_fn)
+		return -ENOMEM;
 	memset(new_fn, 0, len);
 	new_fn->hash = hash;
 	new_fn->minor_hash = minor_hash;
@@ -350,7 +352,7 @@
 		    (new_fn->minor_hash == fname->minor_hash)) {
 			new_fn->next = fname->next;
 			fname->next = new_fn;
-			return;
+			return 0;
 		}
 			
 		if (new_fn->hash < fname->hash)
@@ -365,6 +367,7 @@
 
 	rb_link_node(&new_fn->rb_hash, parent, p);
 	rb_insert_color(&new_fn->rb_hash, &info->root);
+	return 0;
 }
 
 
diff -Nru a/fs/ext3/namei.c b/fs/ext3/namei.c
--- a/fs/ext3/namei.c	Wed Nov  6 17:30:01 2002
+++ b/fs/ext3/namei.c	Wed Nov  6 17:30:01 2002
@@ -552,9 +552,11 @@
 	/* Add '.' and '..' from the htree header */
 	if (!start_hash && !start_minor_hash) {
 		de = (struct ext3_dir_entry_2 *) frames[0].bh->b_data;
-		ext3_htree_store_dirent(dir_file, 0, 0, de);
+		if ((err = ext3_htree_store_dirent(dir_file, 0, 0, de)) != 0)
+			goto errout;
 		de = ext3_next_entry(de);
-		ext3_htree_store_dirent(dir_file, 0, 0, de);
+		if ((err = ext3_htree_store_dirent(dir_file, 0, 0, de)) != 0)
+			goto errout;
 		count += 2;
 	}
 
@@ -573,8 +575,9 @@
 			    ((hinfo.hash == start_hash) &&
 			     (hinfo.minor_hash < start_minor_hash)))
 				continue;
-			ext3_htree_store_dirent(dir_file, hinfo.hash,
-						hinfo.minor_hash, de);
+			if ((err = ext3_htree_store_dirent(dir_file,
+				   hinfo.hash, hinfo.minor_hash, de)) != 0)
+				goto errout;
 			count++;
 		}
 		brelse (bh);
diff -Nru a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
--- a/include/linux/ext3_fs.h	Wed Nov  6 17:30:01 2002
+++ b/include/linux/ext3_fs.h	Wed Nov  6 17:30:01 2002
@@ -689,7 +689,7 @@
 extern int ext3_check_dir_entry(const char *, struct inode *,
 				struct ext3_dir_entry_2 *,
 				struct buffer_head *, unsigned long);
-extern void ext3_htree_store_dirent(struct file *dir_file, __u32 hash,
+extern int ext3_htree_store_dirent(struct file *dir_file, __u32 hash,
 				    __u32 minor_hash,
 				    struct ext3_dir_entry_2 *dirent);
 extern void ext3_htree_free_dir_info(struct dir_private_info *p);
