Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267261AbTBDNcG>; Tue, 4 Feb 2003 08:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbTBDNcG>; Tue, 4 Feb 2003 08:32:06 -0500
Received: from pc-80-195-34-2-ed.blueyonder.co.uk ([80.195.34.2]:8834 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S267261AbTBDNcC>; Tue, 4 Feb 2003 08:32:02 -0500
Subject: [PATCH] Fix signed use of i_blocks in ext3 truncate
From: "Stephen C. Tweedie" <sct@redhat.com>
To: ext3 users list <ext3-users@redhat.com>,
       "Marcelo W. Tosatti" <marcelo@conectiva.com.br>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Stephen Tweedie <sct@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11james) 
Date: 04 Feb 2003 13:41:16 +0000
Message-Id: <1044366076.9106.63.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "h_buffer_credits<0" assert failure during truncate.

The bug occurs when the "i_blocks" count in the file's inode overflows
past 2^31.  That works fine most of the time, because i_blocks is an
unsigned long, and should go up to 2^32; but there's a place in truncate
where ext3 calculates the size of the next transaction chunk for the
delete, and that mistakenly uses a signed long instead.  Because the
huge i_blocks gets cast to a negative value, ext3 does not reserve
enough credits for the transaction and the above error results.

This is usually only possible on filesystems corrupted for other
reasons, but it is reproducible if you create a single, non-sparse file
larger than 1TB on ext3 and then try to delete it.

--- linux-2.4-tmp/fs/ext3/inode.c.=K0000=.orig	2003-02-03 19:14:43.000000000 +0000
+++ linux-2.4-tmp/fs/ext3/inode.c	2003-02-03 19:17:35.000000000 +0000
@@ -87,6 +87,34 @@
 	return err;
 }
 
+/*
+ * Work out how many blocks we need to progress with the next chunk of a
+ * truncate transaction.
+ */
+
+static unsigned long blocks_for_truncate(struct inode *inode) 
+{
+	unsigned long needed;
+	
+	needed = inode->i_blocks >> (inode->i_sb->s_blocksize_bits - 9);
+
+	/* Give ourselves just enough room to cope with inodes in which
+	 * i_blocks is corrupt: we've seen disk corruptions in the past
+	 * which resulted in random data in an inode which looked enough
+	 * like a regular file for ext3 to try to delete it.  Things
+	 * will go a bit crazy if that happens, but at least we should
+	 * try not to panic the whole kernel. */
+	if (needed < 2)
+		needed = 2;
+
+	/* But we need to bound the transaction so we don't overflow the
+	 * journal. */
+	if (needed > EXT3_MAX_TRANS_DATA) 
+		needed = EXT3_MAX_TRANS_DATA;
+
+	return EXT3_DATA_TRANS_BLOCKS + needed;
+}
+	
 /* 
  * Truncate transactions can be complex and absolutely huge.  So we need to
  * be able to restart the transaction at a conventient checkpoint to make
@@ -100,14 +128,9 @@
 
 static handle_t *start_transaction(struct inode *inode) 
 {
-	long needed;
 	handle_t *result;
 	
-	needed = inode->i_blocks;
-	if (needed > EXT3_MAX_TRANS_DATA) 
-		needed = EXT3_MAX_TRANS_DATA;
-	
-	result = ext3_journal_start(inode, EXT3_DATA_TRANS_BLOCKS + needed);
+	result = ext3_journal_start(inode, blocks_for_truncate(inode));
 	if (!IS_ERR(result))
 		return result;
 	
@@ -123,14 +146,9 @@
  */
 static int try_to_extend_transaction(handle_t *handle, struct inode *inode)
 {
-	long needed;
-	
 	if (handle->h_buffer_credits > EXT3_RESERVE_TRANS_BLOCKS)
 		return 0;
-	needed = inode->i_blocks;
-	if (needed > EXT3_MAX_TRANS_DATA) 
-		needed = EXT3_MAX_TRANS_DATA;
-	if (!ext3_journal_extend(handle, EXT3_RESERVE_TRANS_BLOCKS + needed))
+	if (!ext3_journal_extend(handle, blocks_for_truncate(inode)))
 		return 0;
 	return 1;
 }
@@ -142,11 +160,8 @@
  */
 static int ext3_journal_test_restart(handle_t *handle, struct inode *inode)
 {
-	long needed = inode->i_blocks;
-	if (needed > EXT3_MAX_TRANS_DATA) 
-		needed = EXT3_MAX_TRANS_DATA;
 	jbd_debug(2, "restarting handle %p\n", handle);
-	return ext3_journal_restart(handle, EXT3_DATA_TRANS_BLOCKS + needed);
+	return ext3_journal_restart(handle, blocks_for_truncate(inode));
 }
 
 /*
--- linux-2.4-tmp/include/linux/ext3_jbd.h.=K0000=.orig	2003-02-03 19:14:43.000000000 +0000
+++ linux-2.4-tmp/include/linux/ext3_jbd.h	2003-02-03 19:17:35.000000000 +0000
@@ -28,7 +28,7 @@
  * indirection blocks, the group and superblock summaries, and the data
  * block to complete the transaction.  */
 
-#define EXT3_SINGLEDATA_TRANS_BLOCKS	8
+#define EXT3_SINGLEDATA_TRANS_BLOCKS	8U
 
 /* Define the minimum size for a transaction which modifies data.  This
  * needs to take into account the fact that we may end up modifying two
@@ -52,7 +52,7 @@
  * start off at the maximum transaction size and grow the transaction
  * optimistically as we go. */
 
-#define EXT3_MAX_TRANS_DATA		64
+#define EXT3_MAX_TRANS_DATA		64U
 
 /* We break up a large truncate or write transaction once the handle's
  * buffer credits gets this low, we need either to extend the
@@ -61,7 +61,7 @@
  * one block, plus two quota updates.  Quota allocations are not
  * needed. */
 
-#define EXT3_RESERVE_TRANS_BLOCKS	12
+#define EXT3_RESERVE_TRANS_BLOCKS	12U
 
 int
 ext3_mark_iloc_dirty(handle_t *handle, 




