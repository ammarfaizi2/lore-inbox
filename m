Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWERNpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWERNpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 09:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWERNpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 09:45:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52641 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751084AbWERNpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 09:45:19 -0400
Date: Thu, 18 May 2006 15:45:33 +0200
From: Jan Kara <jack@suse.cz>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change ll_rw_block() calls in JBD
Message-ID: <20060518134533.GA20159@atrey.karlin.mff.cuni.cz>
References: <446C2F89.5020300@bull.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <446C2F89.5020300@bull.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> >We must be sure that the current data in buffer are sent to disk.
> >Hence we have to call ll_rw_block() with SWRITE.
> 
> Let's consider the following case:
> 
> 	while (commit_transaction->t_sync_datalist) {
> 		...
> 
> 		// Assume a "bh" got locked before starting this loop
> 
> 		if (buffer_locked(bh)) {
> 			...
> 			__journal_temp_unlink_buffer(jh);
> 			__journal_file_buffer(jh, commit_transaction, 
> 			BJ_Locked);
> 		} else ...
> 	}
> 	...
> 	while (commit_transaction->t_locked_list) {
> 		...
> 
> 		// Assume our "bh" is not locked any more
> 		// Nothing has happened to this "bh", someone just wanted
> 		// to look at it in a safe way
> 
> 		if (buffer_jbd(bh) && jh->b_jlist == BJ_Locked) {
> 			__journal_unfile_buffer(jh);
> 			jbd_unlock_bh_state(bh);
> 			journal_remove_journal_head(bh);
> 			put_bh(bh);
> 		} else ...
> 	}
> 
> I.e. having an already locked "bh", it is missed out from the log.
  Yes, I'm aware of this problem. Actually I wrote a patch (attached) for it
some time ago but as I'm checking current kernels it got lost somewhere on
the way. I'll rediff it and submit again. Thanks for spotting the
problem.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--zhXaljGHf11kAtnf
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

--zhXaljGHf11kAtnf--
