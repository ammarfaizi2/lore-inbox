Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313506AbSDETae>; Fri, 5 Apr 2002 14:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSDETa0>; Fri, 5 Apr 2002 14:30:26 -0500
Received: from backtop.namesys.com ([212.16.7.71]:27265 "EHLO
	bitshadow.namesys.com") by vger.kernel.org with ESMTP
	id <S313506AbSDETaO>; Fri, 5 Apr 2002 14:30:14 -0500
Date: Sat, 6 Apr 2002 00:27:38 +0400
Message-Id: <200204052027.g35KRc002869@bitshadow.namesys.com>
From: Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: ReiserFS Bug Fixes 3 of 6 (Please apply all 6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This changeset is to fix several reiserfs problems which can be
fixed in non-intrusive way.

You can use bk receive to get it.

Diffstat:
 Makefile |    2 +-
 bitmap.c |    6 ++----
 dir.c    |    1 +
 inode.c  |   13 ++++++++-----
 super.c  |    2 +-
 5 files changed, 13 insertions(+), 11 deletions(-)

patch and changelog:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.587   -> 1.588  
#	   fs/reiserfs/dir.c	1.12    -> 1.13   
#	 fs/reiserfs/inode.c	1.38    -> 1.41   
#	 fs/reiserfs/super.c	1.33    -> 1.34   
#	fs/reiserfs/Makefile	1.5     -> 1.6    
#	fs/reiserfs/bitmap.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/05	green@angband.namesys.com	1.588
# bitmap.c:
#   fixed "unused variable" warning.
# super.c:
#   Fix a mispelling in info message.
# Makefile:
#   tail_conversion.o was specified twice in list of objects to build
# inode.c:
#   Add forgotten metadata journaling.
#   Fix a case where flag was not set at inode-read time which prevented
#   32bit uid/gid to work correctly.
#   Fix a lookup problem on big-endian platforms.
# dir.c:
#   Fix a case where atime were not updated when needed.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/Makefile b/fs/reiserfs/Makefile
--- a/fs/reiserfs/Makefile	Fri Apr  5 14:16:14 2002
+++ b/fs/reiserfs/Makefile	Fri Apr  5 14:16:14 2002
@@ -9,7 +9,7 @@
 
 O_TARGET := reiserfs.o
 obj-y   := bitmap.o do_balan.o namei.o inode.o file.o dir.o fix_node.o super.o prints.o objectid.o \
-lbalance.o ibalance.o stree.o hashes.o buffer2.o tail_conversion.o journal.o resize.o tail_conversion.o item_ops.o ioctl.o procfs.o
+lbalance.o ibalance.o stree.o hashes.o buffer2.o tail_conversion.o journal.o resize.o item_ops.o ioctl.o procfs.o
 
 obj-m   := $(O_TARGET)
 
diff -Nru a/fs/reiserfs/bitmap.c b/fs/reiserfs/bitmap.c
--- a/fs/reiserfs/bitmap.c	Fri Apr  5 14:16:14 2002
+++ b/fs/reiserfs/bitmap.c	Fri Apr  5 14:16:14 2002
@@ -139,10 +139,8 @@
 /* preallocated blocks don't need to be run through journal_mark_freed */
 void reiserfs_free_prealloc_block (struct reiserfs_transaction_handle *th, 
                           unsigned long block) {
-    struct super_block * s = th->t_super;
-
-    RFALSE(!s, "vs-4060: trying to free block on nonexistent device");
-    RFALSE(is_reusable (s, block, 1) == 0, "vs-4070: can not free such block");
+    RFALSE(!th->t_super, "vs-4060: trying to free block on nonexistent device");
+    RFALSE(is_reusable (th->t_super, block, 1) == 0, "vs-4070: can not free such block");
     _reiserfs_free_block(th, block) ;
 }
 
diff -Nru a/fs/reiserfs/dir.c b/fs/reiserfs/dir.c
--- a/fs/reiserfs/dir.c	Fri Apr  5 14:16:14 2002
+++ b/fs/reiserfs/dir.c	Fri Apr  5 14:16:14 2002
@@ -180,6 +180,7 @@
     filp->f_pos = next_pos;
     pathrelse (&path_to_entry);
     reiserfs_check_path(&path_to_entry) ;
+    UPDATE_ATIME(inode) ;
     return 0;
 }
 
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Fri Apr  5 14:16:14 2002
+++ b/fs/reiserfs/inode.c	Fri Apr  5 14:16:14 2002
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
@@ -933,9 +937,6 @@
 	// (directories and symlinks)
 	struct stat_data * sd = (struct stat_data *)B_I_PITEM (bh, ih);
 
-	/* both old and new directories have old keys */
-	//version = (S_ISDIR (sd->sd_mode) ? ITEM_VERSION_1 : ITEM_VERSION_2);
-
 	inode->i_mode   = sd_v2_mode(sd);
 	inode->i_nlink  = sd_v2_nlink(sd);
 	inode->i_uid    = sd_v2_uid(sd);
@@ -956,6 +957,7 @@
 	else
 	    set_inode_item_key_version (inode, KEY_FORMAT_3_6);
 	REISERFS_I(inode)->i_first_direct_byte = 0;
+	set_inode_sd_version (inode, STAT_DATA_V2);
     }
 
     pathrelse (path);
@@ -1218,7 +1220,8 @@
     struct reiserfs_iget4_args *args;
 
     args = opaque;
-    return INODE_PKEY( inode ) -> k_dir_id == args -> objectid;
+    /* args is already in CPU order */
+    return le32_to_cpu(INODE_PKEY(inode)->k_dir_id) == args -> objectid;
 }
 
 struct inode * reiserfs_iget (struct super_block * s, const struct cpu_key * key)
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Fri Apr  5 14:16:14 2002
+++ b/fs/reiserfs/super.c	Fri Apr  5 14:16:14 2002
@@ -765,7 +765,7 @@
     if ( rs->s_v1.s_root_block == -1 ) {
        brelse(bh) ;
        printk("dev %s: Unfinished reiserfsck --rebuild-tree run detected. Please run\n"
-              "reiserfsck --rebuild-tree and wait for a completion. If that fais\n"
+              "reiserfsck --rebuild-tree and wait for a completion. If that fails\n"
               "get newer reiserfsprogs package\n", s->s_id);
        return 1;
     }

BK changeset:

This BitKeeper patch contains the following changesets:
1.588
## Wrapped with gzip_uu ##


begin 664 bkpatch2245
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
=J/8_/8'-9C*[-LOYL<`V+\K3POL_D.3+5_45````
`
end
