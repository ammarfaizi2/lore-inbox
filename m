Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315287AbSFJNv7>; Mon, 10 Jun 2002 09:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315168AbSFJNub>; Mon, 10 Jun 2002 09:50:31 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:25472 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S314485AbSFJNuN>;
	Mon, 10 Jun 2002 09:50:13 -0400
Date: Mon, 10 Jun 2002 17:42:56 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADguKT003869@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 10 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 10 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message

   fix reiserfs_breada to read from the correct device when it isn't on the
   same device as the main filesystem.

Chris Mason spent a lot of efforts in helping to convert this changeset to
Linus-compatible form.

Diffstat:
 journal.c |   35 ++++++++++++++++++++++-------------
 1 files changed, 22 insertions(+), 13 deletions(-)

Plaintext patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.603   -> 1.604  
#	fs/reiserfs/journal.c	1.47    -> 1.48   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.604
# journal.c:
#   fix reiserfs_breada to read from the correct device when it isn't on the same device as the main filesystem.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Thu May 30 18:42:24 2002
+++ b/fs/reiserfs/journal.c	Thu May 30 18:42:24 2002
@@ -1591,16 +1591,13 @@
   return 0 ;
 }
 
-/*
-** read and replay the log
-** on a clean unmount, the journal header's next unflushed pointer will be to an invalid
-** transaction.  This tests that before finding all the transactions in the log, whic makes normal mount times fast.
-**
-** After a crash, this starts with the next unflushed transaction, and replays until it finds one too old, or invalid.
-**
-** On exit, it sets things up so the first transaction will work correctly.
-*/
-struct buffer_head * reiserfs_breada (struct super_block *sb, int block, 
+/* This function reads blocks starting from block and to max_block of bufsize
+   size (but no more than BUFNR blocks at a time). This proved to improve
+   mounting speed on self-rebuilding raid5 arrays at least.
+   Right now it is only used from journal code. But later we might use it
+   from other places.
+   Note: Do not use journal_getblk/sb_getblk functions here! */
+struct buffer_head * reiserfs_breada (struct block_device *dev, int block, int bufsize,
 			    unsigned int max_block)
 {
 	struct buffer_head * bhlist[BUFNR];
@@ -1608,7 +1605,7 @@
 	struct buffer_head * bh;
 	int i, j;
 	
-	bh = sb_getblk (sb, block);
+	bh = __getblk (dev, block, bufsize );
 	if (buffer_uptodate (bh))
 		return (bh);   
 		
@@ -1618,7 +1615,7 @@
 	bhlist[0] = bh;
 	j = 1;
 	for (i = 1; i < blocks; i++) {
-		bh = sb_getblk (sb, block + i);
+		bh = __getblk (dev, block + i, bufsize);
 		if (buffer_uptodate (bh)) {
 			brelse (bh);
 			break;
@@ -1635,6 +1632,16 @@
 	brelse (bh);
 	return NULL;
 }
+
+/*
+** read and replay the log
+** on a clean unmount, the journal header's next unflushed pointer will be to an invalid
+** transaction.  This tests that before finding all the transactions in the log, whic makes normal mount times fast.
+**
+** After a crash, this starts with the next unflushed transaction, and replays until it finds one too old, or invalid.
+**
+** On exit, it sets things up so the first transaction will work correctly.
+*/
 static int journal_read(struct super_block *p_s_sb) {
   struct reiserfs_journal_desc *desc ;
   unsigned long oldest_trans_id = 0;
@@ -1701,7 +1708,9 @@
   ** all the valid transactions, and pick out the oldest.
   */
   while(continue_replay && cur_dblock < (SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_ONDISK_JOURNAL_SIZE(p_s_sb))) {
-    d_bh = reiserfs_breada(p_s_sb, cur_dblock,
+    /* Note that it is required for blocksize of primary fs device and journal
+       device to be the same */
+    d_bh = reiserfs_breada(SB_JOURNAL(p_s_sb)->j_dev_bd, cur_dblock, p_s_sb->s_blocksize,
 			   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_ONDISK_JOURNAL_SIZE(p_s_sb)) ;
     ret = journal_transaction_is_valid(p_s_sb, d_bh, &oldest_invalid_trans_id, &newest_mount_id) ;
     if (ret == 1) {
