Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVJYRgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVJYRgy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVJYRgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:36:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15066 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932247AbVJYRgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:36:53 -0400
Date: Tue, 25 Oct 2005 19:36:52 +0200
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix handling of ordered buffers
Message-ID: <20051025173652.GA1032@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  here is the second try for the fix of handling of ordered data buffers
in JBD. As the first round was quite some time ago I'll remind the
problem: current code in commit assumes that if the buffer is locked it
is being sent to disk (and hence just refiles such buffer to
t_locked_list). But that is not true as we sometimes lock the buffer
just to check some values and then unlock it. Hence we need to do more
complicated handling where we check if the buffer is dirty and if it is,
we get the buffer lock and write the buffer to disk. We have to be a bit
careful not to end in a livelock if someone is dirtying buffers under us.
But this is not a problem as we always refile the buffer to
t_locked_list if it is dirty and when we manage to get the buffer lock.
Buffers in t_locked_list are just waited-upon and then detached.
  The patch is against 2.6.14-rc5. Andrew, please apply it to -mm kernel
to get some wider testing. Especially we should check whether it does
not decrease performance as we are waiting on a buffer lock sometimes.
I checked this at home by running some processes wildly rewriting the
file again and again and I did not observe any negative effect but it
might be just my test-case...

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.14-rc5-1-orderedwrite.diff"

  The old code assumed that when the buffer is locked it is being
written. But need not be always true. Hence we have to be more
careful when processing ordered data buffers.
  If a buffer is not dirty, we know that write has already started
(and may be even already completed) and hence just refiling buffer
to t_locked_list (or unfiling it completely in case IO has finished)
is enough. If the buffer is dirty, we have to acquire the buffer lock
and do the write. In this case we also immediately refile the buffer
to t_locked_list thus making always some progress.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.14-rc5/fs/jbd/commit.c linux-2.6.14-rc5-1-orderedwrite/fs/jbd/commit.c
--- linux-2.6.14-rc5/fs/jbd/commit.c	2005-10-25 08:53:22.000000000 +0200
+++ linux-2.6.14-rc5-1-orderedwrite/fs/jbd/commit.c	2005-10-25 09:07:43.000000000 +0200
@@ -333,57 +333,77 @@ write_out_data:
 
 	while (commit_transaction->t_sync_datalist) {
 		struct buffer_head *bh;
+		int was_dirty;
 
 		jh = commit_transaction->t_sync_datalist;
-		commit_transaction->t_sync_datalist = jh->b_tnext;
 		bh = jh2bh(jh);
-		if (buffer_locked(bh)) {
-			BUFFER_TRACE(bh, "locked");
-			if (!inverted_lock(journal, bh))
-				goto write_out_data;
+
+		/*
+		 * If the buffer is not dirty, we don't need to submit any
+		 * IO (either it is running or it has already finished) and
+		 * hence we don't need the buffer lock. In case we need the
+		 * lock, try to lock the buffer without blocking. If we fail,
+		 * we need to drop j_list_lock and do blocking lock_buffer().
+		 */
+		was_dirty = buffer_dirty(bh);
+		if (was_dirty && test_set_buffer_locked(bh)) {
+			BUFFER_TRACE(bh, "needs blocking lock");
+			get_bh(bh);
+			spin_unlock(&journal->j_list_lock);
+			lock_buffer(bh);
+			spin_lock(&journal->j_list_lock);
+			/* Someone already cleaned up the buffer? Restart. */
+			if (!buffer_jbd(bh) || jh->b_jlist != BJ_SyncData) {
+				unlock_buffer(bh);
+				BUFFER_TRACE(bh, "already cleaned up");
+				put_bh(bh);
+				continue;
+			}
+			put_bh(bh);
+		}
+
+		if (!jbd_trylock_bh_state(bh)) {
+			if (was_dirty)
+				unlock_buffer(bh);
+			spin_unlock(&journal->j_list_lock);
+			schedule();
+			goto write_out_data;
+		}
+		/*
+		 * Now we know that the buffer either was not dirty or we
+		 * have the buffer lock. If the buffer was not dirty,
+		 * write-out is running or already complete and we can just
+		 * refile the buffer to Locked list or unfile the buffer
+		 * respectively. In case the buffer was dirty, we have to
+		 * submit the buffer for IO before refiling it.
+		 */
+		BUFFER_TRACE(bh, "locked the buffer");
+		if ((!was_dirty && !buffer_locked(bh))
+		    || (was_dirty && !test_clear_buffer_dirty(bh))) {
+			BUFFER_TRACE(bh, "writeout complete: unfile");
+			__journal_unfile_buffer(jh);
+			jbd_unlock_bh_state(bh);
+			journal_remove_journal_head(bh);
+			if (was_dirty)
+				unlock_buffer(bh);
+			put_bh(bh);
+		}
+		else {
+			BUFFER_TRACE(bh, "needs writeout, submitting");
 			__journal_temp_unlink_buffer(jh);
 			__journal_file_buffer(jh, commit_transaction,
 						BJ_Locked);
 			jbd_unlock_bh_state(bh);
-			if (lock_need_resched(&journal->j_list_lock)) {
-				spin_unlock(&journal->j_list_lock);
-				goto write_out_data;
-			}
-		} else {
-			if (buffer_dirty(bh)) {
-				BUFFER_TRACE(bh, "start journal writeout");
+			if (was_dirty) {
 				get_bh(bh);
-				wbuf[bufs++] = bh;
-				if (bufs == journal->j_wbufsize) {
-					jbd_debug(2, "submit %d writes\n",
-							bufs);
-					spin_unlock(&journal->j_list_lock);
-					ll_rw_block(SWRITE, bufs, wbuf);
-					journal_brelse_array(wbuf, bufs);
-					bufs = 0;
-					goto write_out_data;
-				}
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
+				bh->b_end_io = end_buffer_write_sync;
+				submit_bh(WRITE, bh);
 			}
 		}
-	}
-
-	if (bufs) {
-		spin_unlock(&journal->j_list_lock);
-		ll_rw_block(SWRITE, bufs, wbuf);
-		journal_brelse_array(wbuf, bufs);
-		spin_lock(&journal->j_list_lock);
+		if (lock_need_resched(&journal->j_list_lock)) {
+			spin_unlock(&journal->j_list_lock);
+			goto write_out_data;
+		}
 	}
 
 	/*

--UlVJffcvxoiEqYs2--
