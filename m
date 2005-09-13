Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbVIMP2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbVIMP2q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbVIMP2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:28:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59820 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932673AbVIMP2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:28:45 -0400
Date: Tue, 13 Sep 2005 17:30:24 +0200
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org, sct@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix commit of ordered data buffers
Message-ID: <20050913153024.GL30108@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  attached patch should fix handling of ordered data buffers in
journal_commit_write(). Currently the code simply moves the buffer
from t_sync_data list to t_locked list when the buffer is locked.
But in theory (I'm not sure this currently really happens for ext3
ordered data buffer) the buffer can be locked just for "examination"
purposes and not being sent to disk. Hence it could happen we don't
write some ordered buffer when we should.
  What the patch does is that it writes the buffer when it is dirty
(even if it is locked - hence it can happen we call ll_rw_block()
on the buffer currently under write-out but in this case ll_rw_block()
just waits until IO is complete and returns (as the buffer won't be
dirty anymore) and this race with pdflush should be rare enough not
to affect the performance). The patch also moves buffer to t_locked
list immediately after queing the buffer for write-out (as otherwise
we would have to detect which buffers are already queued and that's not
nice). This changes a bit a logic of t_locked list - unlocked buffer
for the users different from journal_commit_transaction() does not mean
the buffer is already written. But only journal_unmap_buffer() cares
about this changes and I changed that one to check if the buffer is not
dirty.
  Andrew, if you think the change is fine, please put it into -mm so
that it gets some testing.

							Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.13-mm1-2-orderedwrite.diff"

When a buffer is locked it does not mean that write-out is in progress. We
have to check if the buffer is dirty and if it is we have to submit it
for write-out. We unconditionally move the buffer to t_locked_list so
that we don't mistake unprocessed buffer and buffer not yet given to
ll_rw_block(). This subtly changes the meaning of buffer states in
t_locked_list - unlock buffer (for list users different from
journal_commit_transaction()) does not mean it has been written. But
only journal_unmap_buffer() cares and it now checks if the buffer
is not dirty.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.13-mm1-1-invalidatepage/fs/jbd/commit.c linux-2.6.13-mm1-2-orderedwrite/fs/jbd/commit.c
--- linux-2.6.13-mm1-1-invalidatepage/fs/jbd/commit.c	2005-09-11 22:49:07.000000000 +0200
+++ linux-2.6.13-mm1-2-orderedwrite/fs/jbd/commit.c	2005-09-17 01:53:46.000000000 +0200
@@ -337,19 +337,32 @@ write_out_data:
 		jh = commit_transaction->t_sync_datalist;
 		commit_transaction->t_sync_datalist = jh->b_tnext;
 		bh = jh2bh(jh);
-		if (buffer_locked(bh)) {
-			BUFFER_TRACE(bh, "locked");
+
+		/*
+		 * If the buffer is dirty, it needs a write-out (the write-out
+		 * may be already in progress but that should be rare so giving
+		 * the buffer once more to ll_rw_block() should not affect
+		 * the performance). We move the buffer out of t_sync_datalist
+		 * to t_locked_list to make a progress. This handling of dirty
+		 * buffer has the disadvantage that for functions different
+		 * from journal_commit_transaction() unlocked buffer in
+		 * t_locked_list does not mean it has been written. *BUT* the
+		 * only place that cares is journal_unmap_buffer() and that
+		 * checks that the buffer is not dirty.
+		 *
+		 * If the buffer is locked and not dirty, someone has submitted
+		 * the buffer for IO before us so we just move the buffer to
+		 * t_locked_list (to wait for IO completion).
+		 */
+		if (buffer_locked(bh) || buffer_dirty(bh)) {
+			BUFFER_TRACE(bh, "locked or dirty");
 			if (!inverted_lock(journal, bh))
 				goto write_out_data;
 			__journal_temp_unlink_buffer(jh);
 			__journal_file_buffer(jh, commit_transaction,
 						BJ_Locked);
 			jbd_unlock_bh_state(bh);
-			if (lock_need_resched(&journal->j_list_lock)) {
-				spin_unlock(&journal->j_list_lock);
-				goto write_out_data;
-			}
-		} else {
+
 			if (buffer_dirty(bh)) {
 				BUFFER_TRACE(bh, "start journal writeout");
 				get_bh(bh);
@@ -363,19 +376,19 @@ write_out_data:
 					bufs = 0;
 					goto write_out_data;
 				}
-			} else {
-				BUFFER_TRACE(bh, "writeout complete: unfile");
-				if (!inverted_lock(journal, bh))
-					goto write_out_data;
-				__journal_unfile_buffer(jh);
-				jbd_unlock_bh_state(bh);
-				journal_remove_journal_head(bh);
-				put_bh(bh);
-				if (lock_need_resched(&journal->j_list_lock)) {
-					spin_unlock(&journal->j_list_lock);
-					goto write_out_data;
-				}
 			}
+		} else {
+			BUFFER_TRACE(bh, "writeout complete: unfile");
+			if (!inverted_lock(journal, bh))
+				goto write_out_data;
+			__journal_unfile_buffer(jh);
+			jbd_unlock_bh_state(bh);
+			journal_remove_journal_head(bh);
+			put_bh(bh);
+		}
+		if (lock_need_resched(&journal->j_list_lock)) {
+			spin_unlock(&journal->j_list_lock);
+			goto write_out_data;
 		}
 	}
 
diff -rupX /home/jack/.kerndiffexclude linux-2.6.13-mm1-1-invalidatepage/fs/jbd/transaction.c linux-2.6.13-mm1-2-orderedwrite/fs/jbd/transaction.c
--- linux-2.6.13-mm1-1-invalidatepage/fs/jbd/transaction.c	2005-09-11 22:49:07.000000000 +0200
+++ linux-2.6.13-mm1-2-orderedwrite/fs/jbd/transaction.c	2005-09-17 01:53:46.000000000 +0200
@@ -1814,11 +1814,11 @@ static int journal_unmap_buffer(journal_
 			}
 		}
 	} else if (transaction == journal->j_committing_transaction) {
-		if (jh->b_jlist == BJ_Locked) {
+		if (jh->b_jlist == BJ_Locked && !buffer_dirty(bh)) {
 			/*
 			 * The buffer is on the committing transaction's locked
-			 * list.  We have the buffer locked, so I/O has
-			 * completed.  So we can nail the buffer now.
+			 * list.  We have the buffer locked and !dirty, so I/O
+			 * has completed.  So we can nail the buffer now.
 			 */
 			may_free = __dispose_buffer(jh, transaction);
 			goto zap_buffer;

--kXdP64Ggrk/fb43R--
