Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVGKQNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVGKQNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVGKQK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:10:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41157 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262153AbVGKQKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:10:16 -0400
Date: Mon, 11 Jul 2005 18:10:11 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, sct@redhat.com
Subject: [PATCH] Fix race in do_get_write_access()
Message-ID: <20050711161011.GA28238@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  attached patch should fix the following race:
     Proc 1                               Proc 2

     __flush_batch()
       ll_rw_block()
                                        do_get_write_access()
					   lock_buffer
                                             jh is only waiting for checkpoint
					     -> b_transaction == NULL ->
					     do nothing
                                           unlock_buffer
    test_set_buffer_locked()
    test_clear_buffer_dirty()
                                           __journal_file_buffer()
                                        change the data
    submit_bh()

  and we have sent wrong data to disk... We now clean the dirty buffer
flag under buffer lock in all cases and hence we know that whenever a buffer
is starting to be journaled we either finish the pending write-out
before attaching a buffer to a transaction or we won't write the buffer
until the transaction is going to be committed... Please apply.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.12-3-early-writeout-fix.diff"

The test in jbd_unexpected_dirty_buffer() is redundant - remove it.
Furthermore we have to clear the buffer dirty bit under the buffer lock
to prevent races with buffer write-out (and hence prevent returning
a buffer with IO happening).

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-2-ll_rw_block-fix/fs/jbd/transaction.c linux-2.6.12-3-early-writeout-fix/fs/jbd/transaction.c
--- linux-2.6.12-2-ll_rw_block-fix/fs/jbd/transaction.c	2005-06-28 13:26:18.000000000 +0200
+++ linux-2.6.12-3-early-writeout-fix/fs/jbd/transaction.c	2005-07-09 08:40:01.000000000 +0200
@@ -493,20 +493,17 @@ static void jbd_unexpected_dirty_buffer(
 	struct buffer_head *bh = jh2bh(jh);
 	int jlist;
 
-	if (buffer_dirty(bh)) {
-		/* If this buffer is one which might reasonably be dirty
-		 * --- ie. data, or not part of this journal --- then
-		 * we're OK to leave it alone, but otherwise we need to
-		 * move the dirty bit to the journal's own internal
-		 * JBDDirty bit. */
-		jlist = jh->b_jlist;
-
-		if (jlist == BJ_Metadata || jlist == BJ_Reserved || 
-		    jlist == BJ_Shadow || jlist == BJ_Forget) {
-			if (test_clear_buffer_dirty(jh2bh(jh))) {
-				set_bit(BH_JBDDirty, &jh2bh(jh)->b_state);
-			}
-		}
+	/* If this buffer is one which might reasonably be dirty
+	 * --- ie. data, or not part of this journal --- then
+	 * we're OK to leave it alone, but otherwise we need to
+	 * move the dirty bit to the journal's own internal
+	 * JBDDirty bit. */
+	jlist = jh->b_jlist;
+
+	if (jlist == BJ_Metadata || jlist == BJ_Reserved || 
+	    jlist == BJ_Shadow || jlist == BJ_Forget) {
+		if (test_clear_buffer_dirty(jh2bh(jh)))
+			set_bit(BH_JBDDirty, &jh2bh(jh)->b_state);
 	}
 }
 
@@ -574,9 +571,14 @@ repeat:
 			if (jh->b_next_transaction)
 				J_ASSERT_JH(jh, jh->b_next_transaction ==
 							transaction);
-			JBUFFER_TRACE(jh, "Unexpected dirty buffer");
-			jbd_unexpected_dirty_buffer(jh);
- 		}
+		}
+		/*
+		 * In any case we need to clean the dirty flag and we must
+		 * do it under the buffer lock to be sure we don't race
+		 * with running write-out.
+		 */
+		JBUFFER_TRACE(jh, "Unexpected dirty buffer");
+		jbd_unexpected_dirty_buffer(jh);
  	}
 
 	unlock_buffer(bh);

--ZPt4rx8FFjLCG7dd--
