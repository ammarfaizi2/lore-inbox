Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSFJNv4>; Mon, 10 Jun 2002 09:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315245AbSFJNvM>; Mon, 10 Jun 2002 09:51:12 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:25984 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315257AbSFJNuU>;
	Mon, 10 Jun 2002 09:50:20 -0400
Date: Mon, 10 Jun 2002 17:42:55 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADgtXl003857@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 6 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 6 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message

   Fix initialization and cleanup of the external logging (Vladimir Saveliev),
   and make sure to call set_blocksize() on the bdev for the external device.
   (Chris Mason)

Chris Mason spent a lot of efforts in helping to convert this changeset to
Linus-compatible form.

Diffstat:
 journal.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

Plaintext patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.599   -> 1.600  
#	fs/reiserfs/journal.c	1.45    -> 1.46   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.600
# journal.c:
#   reiserfs: Fix initialization and cleanup of the external logging (Vladimir Saveliev) , and make sure to call set_blocksize() on the bdev for the external device. (Chris Mason)
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Thu May 30 18:42:20 2002
+++ b/fs/reiserfs/journal.c	Thu May 30 18:42:20 2002
@@ -1925,13 +1925,20 @@
     
     result = 0;
 	
-    if( journal -> j_dev_bd != NULL ) {
-	result = blkdev_put( journal -> j_dev_bd, BDEV_FS );
-	journal -> j_dev_bd = NULL;
-    }
+
     if( journal -> j_dev_file != NULL ) {
+	/*
+	 * journal block device was taken via filp_open
+	 */
 	result = filp_close( journal -> j_dev_file, NULL );
 	journal -> j_dev_file = NULL;
+	journal -> j_dev_bd = NULL;
+    } else if( journal -> j_dev_bd != NULL ) {
+	/*
+	 * journal block device was taken via bdget and blkdev_get
+	 */
+	result = blkdev_put( journal -> j_dev_bd, BDEV_FS );
+	journal -> j_dev_bd = NULL;
     }
     if( result != 0 ) {
 	reiserfs_warning("sh-457: release_journal_dev: Cannot release journal device: %i", result );
@@ -1966,6 +1973,9 @@
 			printk( "sh-458: journal_init_dev: cannot init journal device\n '%s': %i", 
 				kdevname( jdev ), result );
 
+		else if (!kdev_same(jdev, super->s_dev)) {
+			set_blocksize(journal->j_dev_bd, super->s_blocksize);
+		}
 		return result;
 	}
 
@@ -1981,15 +1991,12 @@
 		} else if( jdev_inode -> i_bdev == NULL ) {
 			printk( "journal_init_dev: bdev unintialized for '%s'", jdev_name );
 			result = -ENOMEM;
-		} else if( ( result = blkdev_get( jdev_inode -> i_bdev, 
-						  FMODE_READ | FMODE_WRITE,
-						  0, BDEV_FS ) ) != 0 ) {
-			printk( "journal_init_dev: Cannot load device '%s': %i", jdev_name,
-			     result );
-		} else
+		} else  {
 			/* ok */
 			SB_JOURNAL_DEV( super ) = 
 				to_kdev_t( jdev_inode -> i_bdev -> bd_dev );
+			set_blocksize(journal->j_dev_bd, super->s_blocksize);
+		}
 	} else {
 		result = PTR_ERR( journal -> j_dev_file );
 		journal -> j_dev_file = NULL;
