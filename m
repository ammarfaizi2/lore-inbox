Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264029AbRFEQKQ>; Tue, 5 Jun 2001 12:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264030AbRFEQKF>; Tue, 5 Jun 2001 12:10:05 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:5637 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S264029AbRFEQJz>; Tue, 5 Jun 2001 12:09:55 -0400
Date: Tue, 05 Jun 2001 12:09:37 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
cc: alan@redhat.com
Subject: [PATCH] reiserfs mark_journal_new 
Message-ID: <838190000.991757377@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

The 2.2.x reiserfs journal code marks newly allocated metadata so that if
it is freed in the same transaction (common due to balancing), it can
immediately be reused as a data block.  It also allows faster freeing for
these blocks.

This tested patch enables that code for 2.4.x, Alan please include.

-chris

diff -ur diff/linux/fs/reiserfs/fix_node.c linux/fs/reiserfs/fix_node.c
--- diff/linux/fs/reiserfs/fix_node.c	Mon Jan 15 18:31:19 2001
+++ linux/fs/reiserfs/fix_node.c	Fri Feb  2 15:40:54 2001
@@ -936,6 +936,7 @@
     if (p_s_tb->FEB[p_s_tb->cur_blknum])
       BUG();
 
+    mark_buffer_journal_new(p_s_new_bh) ;
     p_s_tb->FEB[p_s_tb->cur_blknum++] = p_s_new_bh;
   }
 
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Fri Jun  1 13:22:16 2001
+++ b/fs/reiserfs/journal.c	Fri Jun  1 13:22:16 2001
@@ -2550,6 +2550,7 @@
   bh = get_hash_table(p_s_sb->s_dev, blocknr, p_s_sb->s_blocksize) ;
   /* if it is journal new, we just remove it from this transaction */
   if (bh && buffer_journal_new(bh)) {
+    mark_buffer_notjournal_new(bh) ;
     clear_prepared_bits(bh) ;
     cleaned = remove_from_transaction(p_s_sb, blocknr, cleaned) ;
   } else {

