Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVGKP5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVGKP5F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVGKPyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:54:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17860 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262064AbVGKPws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:52:48 -0400
Date: Mon, 11 Jul 2005 17:52:43 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] Change ll_rw_block() calls in JBD
Message-ID: <20050711155243.GS12428@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi,

  attached patch changes calls of ll_rw_block() in JBD to make sure the
data really reach the disk.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.12-2-ll_rw_block-fix.diff"

We must be sure that the current data in buffer are sent to disk. Hence
we have to call ll_rw_block() with SWRITE.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-1-forgetfix/fs/jbd/checkpoint.c linux-2.6.12-2-ll_rw_block-fix/fs/jbd/checkpoint.c
--- linux-2.6.12-1-forgetfix/fs/jbd/checkpoint.c	2005-06-28 13:26:18.000000000 +0200
+++ linux-2.6.12-2-ll_rw_block-fix/fs/jbd/checkpoint.c	2005-07-07 07:18:47.000000000 +0200
@@ -204,7 +204,7 @@ __flush_batch(journal_t *journal, struct
 	int i;
 
 	spin_unlock(&journal->j_list_lock);
-	ll_rw_block(WRITE, *batch_count, bhs);
+	ll_rw_block(SWRITE, *batch_count, bhs);
 	spin_lock(&journal->j_list_lock);
 	for (i = 0; i < *batch_count; i++) {
 		struct buffer_head *bh = bhs[i];
diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-1-forgetfix/fs/jbd/commit.c linux-2.6.12-2-ll_rw_block-fix/fs/jbd/commit.c
--- linux-2.6.12-1-forgetfix/fs/jbd/commit.c	2005-07-06 01:22:13.000000000 +0200
+++ linux-2.6.12-2-ll_rw_block-fix/fs/jbd/commit.c	2005-07-07 07:18:20.000000000 +0200
@@ -358,7 +358,7 @@ write_out_data:
 					jbd_debug(2, "submit %d writes\n",
 							bufs);
 					spin_unlock(&journal->j_list_lock);
-					ll_rw_block(WRITE, bufs, wbuf);
+					ll_rw_block(SWRITE, bufs, wbuf);
 					journal_brelse_array(wbuf, bufs);
 					bufs = 0;
 					goto write_out_data;
@@ -381,7 +381,7 @@ write_out_data:
 
 	if (bufs) {
 		spin_unlock(&journal->j_list_lock);
-		ll_rw_block(WRITE, bufs, wbuf);
+		ll_rw_block(SWRITE, bufs, wbuf);
 		journal_brelse_array(wbuf, bufs);
 		spin_lock(&journal->j_list_lock);
 	}
diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-1-forgetfix/fs/jbd/journal.c linux-2.6.12-2-ll_rw_block-fix/fs/jbd/journal.c
--- linux-2.6.12-1-forgetfix/fs/jbd/journal.c	2005-06-28 13:26:18.000000000 +0200
+++ linux-2.6.12-2-ll_rw_block-fix/fs/jbd/journal.c	2005-07-07 07:17:11.000000000 +0200
@@ -969,7 +969,7 @@ void journal_update_superblock(journal_t
 	if (wait)
 		sync_dirty_buffer(bh);
 	else
-		ll_rw_block(WRITE, 1, &bh);
+		ll_rw_block(SWRITE, 1, &bh);
 
 out:
 	/* If we have just flushed the log (by marking s_start==0), then
diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-1-forgetfix/fs/jbd/revoke.c linux-2.6.12-2-ll_rw_block-fix/fs/jbd/revoke.c
--- linux-2.6.12-1-forgetfix/fs/jbd/revoke.c	2005-03-03 18:58:29.000000000 +0100
+++ linux-2.6.12-2-ll_rw_block-fix/fs/jbd/revoke.c	2005-07-07 07:12:34.000000000 +0200
@@ -613,7 +613,7 @@ static void flush_descriptor(journal_t *
 	set_buffer_jwrite(bh);
 	BUFFER_TRACE(bh, "write");
 	set_buffer_dirty(bh);
-	ll_rw_block(WRITE, 1, &bh);
+	ll_rw_block(SWRITE, 1, &bh);
 }
 #endif
 

--VywGB/WGlW4DM4P8--
