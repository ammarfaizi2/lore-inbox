Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289770AbSBKOZP>; Mon, 11 Feb 2002 09:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289757AbSBKOZG>; Mon, 11 Feb 2002 09:25:06 -0500
Received: from angband.namesys.com ([212.16.7.85]:17536 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289772AbSBKOYy>; Mon, 11 Feb 2002 09:24:54 -0500
Date: Mon, 11 Feb 2002 17:24:49 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] 2.5 [3 of 8] 03-savelink_dir_truncate.diff
Message-ID: <20020211172449.C1768@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Do not panic on incorrect savelink entries (truncate on directory).
   Currently we suppose these can be created if switching between kernels
   with and without savelinks support.


--- linux/fs/reiserfs/super.c.orig	Mon Feb 11 09:55:58 2002
+++ linux/fs/reiserfs/super.c	Mon Feb 11 09:58:31 2002
@@ -115,7 +115,7 @@
    protecting unlink is bigger that a key lf "save link" which
    protects truncate), so there left no items to make truncate
    completion on */
-static void remove_save_link_only (struct super_block * s, struct key * key)
+static void remove_save_link_only (struct super_block * s, struct key * key, int oid_free)
 {
     struct reiserfs_transaction_handle th;
 
@@ -123,7 +123,7 @@
      journal_begin (&th, s, JOURNAL_PER_BALANCE_CNT);
  
      reiserfs_delete_solid_item (&th, key);
-     if (is_direct_le_key (KEY_FORMAT_3_5, key))
+     if (oid_free)
         /* removals are protected by direct items */
         reiserfs_release_objectid (&th, le32_to_cpu (key->k_objectid));
 
@@ -196,7 +196,7 @@
 	       "save" link and release objectid */
             reiserfs_warning ("vs-2180: finish_unfinished: iget failed for %K\n",
                               &obj_key);
-            remove_save_link_only (s, &save_link_key);
+            remove_save_link_only (s, &save_link_key, 1);
             continue;
         }
 
@@ -204,9 +204,21 @@
 	    /* file is not unlinked */
             reiserfs_warning ("vs-2185: finish_unfinished: file %K is not unlinked\n",
                               &obj_key);
-            remove_save_link_only (s, &save_link_key);
+            remove_save_link_only (s, &save_link_key, 0);
             continue;
 	}
+
+	if (truncate && S_ISDIR (inode->i_mode) ) {
+	    /* We got a truncate request for a dir which is impossible.
+	       The only imaginable way is to execute unfinished truncate request
+	       then boot into old kernel, remove the file and create dir with
+	       the same key. */
+	    reiserfs_warning("green-2101: impossible truncate on a directory %k. Please report\n", INODE_PKEY (inode));
+	    remove_save_link_only (s, &save_link_key, 0);
+	    truncate = 0;
+	    iput (inode); 
+	    continue;
+	}
  
         if (truncate) {
             REISERFS_I(inode) -> i_flags |= i_link_saved_truncate_mask;
@@ -272,6 +284,8 @@
 			   4/*length*/, 0xffff/*free space*/);
     } else {
 	/* truncate */
+	if (S_ISDIR (inode->i_mode))
+	    reiserfs_warning("green-2102: Adding a truncate savelink for a directory %k! Please report\n", INODE_PKEY(inode));
 	set_cpu_key_k_offset (&key, 1);
 	set_cpu_key_k_type (&key, TYPE_INDIRECT);
 
