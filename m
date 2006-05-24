Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWEXRc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWEXRc3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbWEXRc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:32:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24961 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932443AbWEXRc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:32:28 -0400
Date: Wed, 24 May 2006 19:33:14 +0200
From: Jan Kara <jack@suse.cz>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Change ll_rw_block() calls in JBD
Message-ID: <20060524173314.GB28568@atrey.karlin.mff.cuni.cz>
References: <446C2F89.5020300@bull.net> <20060518134533.GA20159@atrey.karlin.mff.cuni.cz> <1148051208.5156.31.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <1148051208.5156.31.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

> On Thu, 2006-05-18 at 15:45 +0200, Jan Kara wrote:
  <snip>

> The way was_dirty is used here seems confusing and hard to read; there
> are completely separate code paths for dirty and non-dirty, lockable and
> already-locked buffers, with all the paths interleaved to share a few
> common bits of locking.  It would be far more readable with any sharable
> locking code simply removed to a separate function (such as we already
> have for inverted_lock(), for example), and the different dirty/clean
> logic laid out separately.  Otherwise the code is littered with 
> 
> > +                       if (was_dirty)
> > +                               unlock_buffer(bh);
> 
> and it's not obvious at any point just what locks are held.
> 
> Having said that, it looks like it should work --- it just took more
> effort than it should have to check!
  Thanks for comments. I have written a new patch that tries to address
both your and Zsoltan's comments. I've also fixed a bug caused by calling
submit_bh() under j_list_lock (submit_bh() can sleep on allocating the
bio). That actually required some more changes because I don't want to
drop the j_list_lock for writing each buffer but I also want to keep the
buffer locked so that I can immediately refile it to BJ_Locked list.
If I just released buffer_lock() I would have to keep the buffer in
BJ_SyncData list and I'm afraid that could cause live-locks when
somebody is redirtying the buffer all the time.
  So I'm not totally convinced this is the right way of doing things.
Anyway please have a look at the code and tell me what you think about
it. Thanks.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.17-rc3-1-orderedwrite.diff"

  The old code assumed that when the buffer is locked it is being
written. But need not be always true. Hence we have to be more
careful when processing ordered data buffers.
  If a buffer is not dirty, we know that write has already started
(and may be even already completed) and hence just refiling buffer
to t_locked_list (or unfiling it completely in case IO has finished)
is enough. If the buffer is dirty, we have to acquire the buffer lock
and do the write. This gets a bit tricky as sending buffer for IO
requires blocking but we don't want to drop j_list_lock too often.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.16.orig/fs/jbd/commit.c linux-2.6.16-2-realloc_freed_fix/fs/jbd/commit.c
--- linux-2.6.16.orig/fs/jbd/commit.c	2006-01-28 08:59:58.000000000 +0100
+++ linux-2.6.16-2-realloc_freed_fix/fs/jbd/commit.c	2006-05-25 02:46:04.000000000 +0200
@@ -160,6 +160,117 @@ static int journal_write_commit_record(j
 	return (ret == -EIO);
 }
 
+static void submit_buffers(int bufs, struct buffer_head **wbuf)
+{
+	int i;
+
+	jbd_debug(2, "submit %d writes\n", bufs);
+	for (i = 0; i < bufs; i++) {
+		wbuf[i]->b_end_io = end_buffer_write_sync;
+		submit_bh(WRITE, wbuf[i]);
+	}
+}
+
+/*
+ *  Submit all the data buffers to disk
+ */
+static void journal_submit_data_buffers(journal_t *journal,
+				transaction_t *commit_transaction)
+{
+	struct journal_head *jh;
+	struct buffer_head *bh;
+	struct buffer_head **wbuf = journal->j_wbuf;
+	int bufs = 0;
+
+	/*
+	 * Whenever we unlock the journal and sleep, things can get added
+	 * onto ->t_sync_datalist, so we have to keep looping back to
+	 * write_out_data until we *know* that the list is empty.
+	 *
+	 * Cleanup any flushed data buffers from the data list.  Even in
+	 * abort mode, we want to flush this out as soon as possible.
+	 */
+write_out_data:
+	/* Submit all the buffers we locked so far. We had to release
+	 * j_list_lock anyway so there is no point in not sending all
+	 * those buffers for IO. */
+	submit_buffers(bufs, wbuf);
+	bufs = 0;
+	cond_resched();
+	spin_lock(&journal->j_list_lock);
+
+	while (commit_transaction->t_sync_datalist) {
+		jh = commit_transaction->t_sync_datalist;
+		bh = jh2bh(jh);
+
+		/* If the buffer is dirty, we need to submit IO and hence
+		 * we need the buffer lock. We try to lock the buffer without
+		 * blocking. If we fail, we need to drop j_list_lock and do
+		 * blocking lock_buffer().
+		 */
+		if (buffer_dirty(bh)) {
+			if (test_set_buffer_locked(bh)) {
+				BUFFER_TRACE(bh, "needs blocking lock");
+				get_bh(bh);
+				spin_unlock(&journal->j_list_lock);
+				/* Submit all accumulated buffers to prevent
+				 * possible deadlocks */
+				submit_buffers(bufs, wbuf);
+				bufs = 0;
+				lock_buffer(bh);
+				spin_lock(&journal->j_list_lock);
+				/* Someone already cleaned up the buffer? */
+				if (!buffer_jbd(bh)
+					|| jh->b_jlist != BJ_SyncData) {
+					unlock_buffer(bh);
+					BUFFER_TRACE(bh, "already cleaned up");
+					put_bh(bh);
+					continue;
+				}
+				put_bh(bh);
+			}
+			if (test_clear_buffer_dirty(bh)) {
+				BUFFER_TRACE(bh, "needs writeout, submitting");
+				get_bh(bh);
+				wbuf[bufs++] = bh;
+				if (bufs == journal->j_wbufsize) {
+					spin_unlock(&journal->j_list_lock);
+					/* Writeout will be done at the
+					 * beginning of the loop */
+					goto write_out_data;
+				}
+			}
+			else
+				unlock_buffer(bh);
+		}
+		/* Now we are sure the buffer has been submitted for IO if it
+		 * was needed. The only thing left is to put it on the
+		 * correct list. */
+		if (!inverted_lock(journal, bh))
+			goto write_out_data;
+		if (buffer_locked(bh)) {
+			__journal_file_buffer(jh, commit_transaction,
+						BJ_Locked);
+			jbd_unlock_bh_state(bh);
+		}
+		else {
+			BUFFER_TRACE(bh, "writeout complete: unfile");
+			__journal_unfile_buffer(jh);
+			jbd_unlock_bh_state(bh);
+			journal_remove_journal_head(bh);
+			put_bh(bh);
+		}
+
+		if (lock_need_resched(&journal->j_list_lock)) {
+			spin_unlock(&journal->j_list_lock);
+			goto write_out_data;
+		}
+	}
+	spin_unlock(&journal->j_list_lock);
+	/* Submit the rest of buffers */
+	submit_buffers(bufs, wbuf);
+}
+
 /*
  * journal_commit_transaction
  *
@@ -313,80 +424,13 @@ void journal_commit_transaction(journal_
 	 * Now start flushing things to disk, in the order they appear
 	 * on the transaction lists.  Data blocks go first.
 	 */
-
 	err = 0;
-	/*
-	 * Whenever we unlock the journal and sleep, things can get added
-	 * onto ->t_sync_datalist, so we have to keep looping back to
-	 * write_out_data until we *know* that the list is empty.
-	 */
-	bufs = 0;
-	/*
-	 * Cleanup any flushed data buffers from the data list.  Even in
-	 * abort mode, we want to flush this out as soon as possible.
-	 */
-write_out_data:
-	cond_resched();
-	spin_lock(&journal->j_list_lock);
-
-	while (commit_transaction->t_sync_datalist) {
-		struct buffer_head *bh;
-
-		jh = commit_transaction->t_sync_datalist;
-		commit_transaction->t_sync_datalist = jh->b_tnext;
-		bh = jh2bh(jh);
-		if (buffer_locked(bh)) {
-			BUFFER_TRACE(bh, "locked");
-			if (!inverted_lock(journal, bh))
-				goto write_out_data;
-			__journal_temp_unlink_buffer(jh);
-			__journal_file_buffer(jh, commit_transaction,
-						BJ_Locked);
-			jbd_unlock_bh_state(bh);
-			if (lock_need_resched(&journal->j_list_lock)) {
-				spin_unlock(&journal->j_list_lock);
-				goto write_out_data;
-			}
-		} else {
-			if (buffer_dirty(bh)) {
-				BUFFER_TRACE(bh, "start journal writeout");
-				get_bh(bh);
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
-			}
-		}
-	}
-
-	if (bufs) {
-		spin_unlock(&journal->j_list_lock);
-		ll_rw_block(SWRITE, bufs, wbuf);
-		journal_brelse_array(wbuf, bufs);
-		spin_lock(&journal->j_list_lock);
-	}
+	journal_submit_data_buffers(journal, commit_transaction);
 
 	/*
 	 * Wait for all previously submitted IO to complete.
 	 */
+	spin_lock(&journal->j_list_lock);
 	while (commit_transaction->t_locked_list) {
 		struct buffer_head *bh;
 

--vtzGhvizbBRQ85DL--
