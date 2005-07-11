Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVGKP7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVGKP7N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVGKP5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:57:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28356 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262072AbVGKPyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:54:50 -0400
Date: Mon, 11 Jul 2005 17:54:45 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, reiserfs-devel@namesys.com
Subject: [PATCH] Change ll_rw_block() calls in Reiser
Message-ID: <20050711155445.GT12428@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  attached patch changes ll_rw_block() calls in Reiserfs to make sure
that submitted data really reach the disk (the patch relies on the
previous ll_rw_block() patch).

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reiser-2.6.12-ll_rw_block-fix.diff"

We need to be sure that current data in buffer are sent to disk.
Hence we need to call ll_rw_block() with SWRITE.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-1-forgetfix/fs/reiserfs/journal.c linux-2.6.12-2-ll_rw_block-fix/fs/reiserfs/journal.c
--- linux-2.6.12-1-forgetfix/fs/reiserfs/journal.c	2005-06-28 13:26:20.000000000 +0200
+++ linux-2.6.12-2-ll_rw_block-fix/fs/reiserfs/journal.c	2005-07-07 07:20:19.000000000 +0200
@@ -966,7 +966,7 @@ static int flush_commit_list(struct supe
          SB_ONDISK_JOURNAL_SIZE(s);
     tbh = journal_find_get_block(s, bn) ;
     if (buffer_dirty(tbh)) /* redundant, ll_rw_block() checks */
-	ll_rw_block(WRITE, 1, &tbh) ;
+	ll_rw_block(SWRITE, 1, &tbh) ;
     put_bh(tbh) ;
   }
   atomic_dec(&journal->j_async_throttle);
@@ -1977,7 +1977,7 @@ abort_replay:
   /* flush out the real blocks */
   for (i = 0 ; i < get_desc_trans_len(desc) ; i++) {
     set_buffer_dirty(real_blocks[i]) ;
-    ll_rw_block(WRITE, 1, real_blocks + i) ;
+    ll_rw_block(SWRITE, 1, real_blocks + i) ;
   }
   for (i = 0 ; i < get_desc_trans_len(desc) ; i++) {
     wait_on_buffer(real_blocks[i]) ; 

--11Y7aswkeuHtSBEs--
