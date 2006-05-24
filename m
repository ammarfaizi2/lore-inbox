Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWEXJOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWEXJOp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 05:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWEXJOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 05:14:45 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:36303 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932535AbWEXJOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 05:14:44 -0400
Message-ID: <447423F7.5000002@bull.net>
Date: Wed, 24 May 2006 11:14:31 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change ll_rw_block() calls in JBD
References: <446C2F89.5020300@bull.net> <20060518134533.GA20159@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060518134533.GA20159@atrey.karlin.mff.cuni.cz>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/05/2006 11:17:58,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/05/2006 11:18:01,
	Serialize complete at 24/05/2006 11:18:01
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I forgot a small "spin_unlock(&journal->j_list_lock);".

Thanks,

Zoltan

--- linux-2.6.16.16-save/fs/jbd/commit.c	2006-05-19 15:00:50.000000000 +0200
+++ linux-2.6.16.16/fs/jbd/commit.c	2006-05-24 10:43:32.000000000 +0200
@@ -161,6 +161,107 @@
 }
 
 /*
+ * Flush data from the "->t_sync_datalist" of the committing transaction.
+ */
+static void write_out_sync_data(journal_t *journal,
+					transaction_t *commit_transaction)
+{
+	struct journal_head *jh;
+	struct buffer_head *bh;
+	int err = 0;
+
+	/*
+	 * Whenever we unlock the journal and sleep, things can get removed
+	 * from "->t_sync_datalist" by "journal_dirty_data()", so we have
+	 * to keep looping back to write_out_data until we *know* that the
+	 * list is empty.
+	 *
+	 * Cleanup any flushed data buffers from the data list.  Even in
+	 * abort mode, we want to flush this out as soon as possible.
+	 */
+write_out_data:
+	cond_resched();
+	spin_lock(&journal->j_list_lock);
+	while ((jh = commit_transaction->t_sync_datalist) != NULL){
+		bh = jh2bh(jh);
+		if (buffer_locked(bh)){		/* Unsafe */
+			BUFFER_TRACE(bh, "locked");
+			if (!inverted_lock(journal, bh)) /* jbd_lock_bh_state */
+				goto write_out_data;
+			/* "bh" may have been unlocked in the mean time */
+			__journal_file_buffer(jh, commit_transaction, BJ_Locked);
+			jbd_unlock_bh_state(bh);
+		} else {
+			/* "bh" may have become locked in the mean time */
+			if (buffer_dirty(bh)){	/* Unsafe */
+				if (test_set_buffer_locked(bh)){
+					BUFFER_TRACE(bh, "locked");
+					/* Put it on the BJ_Locked list */
+					continue;
+				}
+				if (test_clear_buffer_dirty(bh)){
+					BUFFER_TRACE(bh, "start journal wr");
+					spin_unlock(&journal->j_list_lock);
+					get_bh(bh);
+					bh->b_end_io = end_buffer_write_sync;
+					submit_bh(WRITE, bh);
+					/* Put it on the BJ_Locked list */
+					goto write_out_data;
+				}
+				unlock_buffer(bh);
+			} else {
+				/* "bh" may have become dirty in the mean time */
+				/* Just do nothing for this transaction */
+			}
+			BUFFER_TRACE(bh, "writeout complete: unfile");
+			if (!inverted_lock(journal, bh)) /* jbd_lock_bh_state */
+				goto write_out_data;
+			__journal_unfile_buffer(jh);
+			jbd_unlock_bh_state(bh);
+			journal_remove_journal_head(bh);
+			put_bh(bh);
+		}
+		if (lock_need_resched(&journal->j_list_lock)){
+			spin_unlock(&journal->j_list_lock);
+			goto write_out_data;
+		}
+	}
+	/*
+	 * Wait for all previously submitted IO to complete.
+	 */
+	while (commit_transaction->t_locked_list) {
+		jh = commit_transaction->t_locked_list->b_tprev;
+		bh = jh2bh(jh);
+		get_bh(bh);
+		if (buffer_locked(bh)) {
+			spin_unlock(&journal->j_list_lock);
+			wait_on_buffer(bh);
+			if (unlikely(!buffer_uptodate(bh)))
+				err = -EIO;
+			spin_lock(&journal->j_list_lock);
+		}
+		if (!inverted_lock(journal, bh)) {
+			put_bh(bh);
+			spin_lock(&journal->j_list_lock);
+			continue;
+		}
+		if (buffer_jbd(bh) && jh->b_jlist == BJ_Locked) {
+			__journal_unfile_buffer(jh);
+			jbd_unlock_bh_state(bh);
+			journal_remove_journal_head(bh);
+			put_bh(bh);
+		} else {
+			jbd_unlock_bh_state(bh);
+		}
+		put_bh(bh);
+		cond_resched_lock(&journal->j_list_lock);
+	}
+	spin_unlock(&journal->j_list_lock);
+	if (err)
+		__journal_abort_hard(journal);
+}
+
+/*
  * journal_commit_transaction
  *
  * The primary function for committing a transaction to the log.  This
@@ -173,7 +274,7 @@
 	struct buffer_head **wbuf = journal->j_wbuf;
 	int bufs;
 	int flags;
-	int err;
+	int err = 0;
 	unsigned long blocknr;
 	char *tagp = NULL;
 	journal_header_t *header;
@@ -313,113 +414,7 @@
 	 * Now start flushing things to disk, in the order they appear
 	 * on the transaction lists.  Data blocks go first.
 	 */
-
-	err = 0;
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
-
-	/*
-	 * Wait for all previously submitted IO to complete.
-	 */
-	while (commit_transaction->t_locked_list) {
-		struct buffer_head *bh;
-
-		jh = commit_transaction->t_locked_list->b_tprev;
-		bh = jh2bh(jh);
-		get_bh(bh);
-		if (buffer_locked(bh)) {
-			spin_unlock(&journal->j_list_lock);
-			wait_on_buffer(bh);
-			if (unlikely(!buffer_uptodate(bh)))
-				err = -EIO;
-			spin_lock(&journal->j_list_lock);
-		}
-		if (!inverted_lock(journal, bh)) {
-			put_bh(bh);
-			spin_lock(&journal->j_list_lock);
-			continue;
-		}
-		if (buffer_jbd(bh) && jh->b_jlist == BJ_Locked) {
-			__journal_unfile_buffer(jh);
-			jbd_unlock_bh_state(bh);
-			journal_remove_journal_head(bh);
-			put_bh(bh);
-		} else {
-			jbd_unlock_bh_state(bh);
-		}
-		put_bh(bh);
-		cond_resched_lock(&journal->j_list_lock);
-	}
-	spin_unlock(&journal->j_list_lock);
-
-	if (err)
-		__journal_abort_hard(journal);
+	write_out_sync_data(journal, commit_transaction);
 
 	journal_write_revoke_records(journal, commit_transaction);
 

