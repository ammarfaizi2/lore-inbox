Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290627AbSBFPwH>; Wed, 6 Feb 2002 10:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290634AbSBFPvt>; Wed, 6 Feb 2002 10:51:49 -0500
Received: from angband.namesys.com ([212.16.7.85]:62080 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S290627AbSBFPvm>; Wed, 6 Feb 2002 10:51:42 -0500
Date: Wed, 6 Feb 2002 18:51:41 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs fix for inodes with wrong item versions (2.5)
Message-ID: <20020206185141.A2113@namesys.com>
Reply-To: green@namesys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   This is hopefully last bugfix for a bug introduced by struct inode splitting.
   Because of setting i_flags to some value and then cleaning the i_flags
   contents later, on-disk items received wrong item version ob v3.6 filesystems

   Please apply.

Bye,
    Oleg
   
--- linux-2.5.4-pre1/fs/reiserfs/inode.c.orig	Wed Feb  6 11:18:35 2002
+++ linux-2.5.4-pre1/fs/reiserfs/inode.c	Wed Feb  6 11:12:08 2002
@@ -890,6 +890,13 @@
     inode->i_blksize = PAGE_SIZE;
 
     INIT_LIST_HEAD(&(REISERFS_I(inode)->i_prealloc_list ));
+    REISERFS_I(inode)->i_flags = 0;
+    REISERFS_I(inode)->i_prealloc_block = 0;
+    REISERFS_I(inode)->i_prealloc_count = 0;
+    REISERFS_I(inode)->i_trans_id = 0;
+    REISERFS_I(inode)->i_trans_index = 0;
+    /* nopack = 0, by default */
+    REISERFS_I(inode)->i_flags &= ~i_nopack_mask;
 
     if (stat_data_v1 (ih)) {
 	struct stat_data_v1 * sd = (struct stat_data_v1 *)B_I_PITEM (bh, ih);
@@ -950,13 +957,6 @@
 	    set_inode_item_key_version (inode, KEY_FORMAT_3_6);
 	REISERFS_I(inode)->i_first_direct_byte = 0;
     }
-    REISERFS_I(inode)->i_flags = 0;
-    REISERFS_I(inode)->i_prealloc_block = 0;
-    REISERFS_I(inode)->i_prealloc_count = 0;
-    REISERFS_I(inode)->i_trans_id = 0;
-    REISERFS_I(inode)->i_trans_index = 0;
-    /* nopack = 0, by default */
-    REISERFS_I(inode)->i_flags &= ~i_nopack_mask;
 
     pathrelse (path);
     if (S_ISREG (inode->i_mode)) {
