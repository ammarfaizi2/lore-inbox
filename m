Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWFBOI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWFBOI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWFBOI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:08:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3025 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932145AbWFBOI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:08:57 -0400
Date: Fri, 2 Jun 2006 16:10:31 +0200
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix for reallocated deleted buffers
Message-ID: <20060602141031.GB5642@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello Andrew,

  my original patch (jbd-fix-bug-in-journal_commit_transaction.patch in -mm)
fixing assertion failure in journal_commit_transaction() on
  J_ASSERT_JH(jh, jh->b_next_transaction == NULL);

had one flaw in it. The fix was to refile buffers that had
b_next_transaction set as that was perfectly correct situation. But
__journal_refile_buffer() places all the buffers on BJ_Metadata list.
As we can refile also buffers that are not jbddirty() it sometimes
happened that the buffer was never marked jbddirty() and an assertion
in journal_write_metadata_buffer() failed when committing the next
transaction.
  Attached patch makes journal_refile_buffer() file buffer into
BJ_Reserved list when it is not jbddirty(). IBM and one other guy seeing
the problem are now testing the patch and it seems to do its job. Please
put it into -mm tree for some more widespread testing. Thanks.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.16-3-refile_nodirty_fix.diff"

Non-jbddirty buffers should be filed to BJ_Reserved and not BJ_Metadata list.
It can actually happen that we refile such buffers during the commit phase
when we reallocate in the running transaction blocks deleted in committing
transaction (and that can happen if the committing transaction already wrote
all the data and is just cleaning up BJ_Forget list).

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.16-2-realloc_freed_fix/fs/jbd/transaction.c linux-2.6.16-3-refile_nodirty_fix/fs/jbd/transaction.c
--- linux-2.6.16-2-realloc_freed_fix/fs/jbd/transaction.c	2006-04-22 03:44:01.000000000 +0200
+++ linux-2.6.16-3-refile_nodirty_fix/fs/jbd/transaction.c	2006-05-25 01:58:14.000000000 +0200
@@ -2041,7 +2041,8 @@ void __journal_refile_buffer(struct jour
 	__journal_temp_unlink_buffer(jh);
 	jh->b_transaction = jh->b_next_transaction;
 	jh->b_next_transaction = NULL;
-	__journal_file_buffer(jh, jh->b_transaction, BJ_Metadata);
+	__journal_file_buffer(jh, jh->b_transaction,
+				was_dirty ? BJ_Metadata : BJ_Reserved);
 	J_ASSERT_JH(jh, jh->b_transaction->t_state == T_RUNNING);
 
 	if (was_dirty)

--DBIVS5p969aUjpLe--
