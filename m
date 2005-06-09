Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVFINU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVFINU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 09:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVFINUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 09:20:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30380 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262400AbVFINPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 09:15:06 -0400
Date: Thu, 9 Jun 2005 15:14:55 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Split the checkpoint lists
Message-ID: <20050609131455.GB13325@atrey.karlin.mff.cuni.cz>
References: <20050601080357.GF5933@atrey.karlin.mff.cuni.cz> <20050603015717.7512ea3a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20050603015717.7512ea3a.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Jan Kara <jack@ucw.cz> wrote:
> >
> > 
> >    attached patch (to be applied after my previous two bugfixes) is a new
> >  version of my patch splitting the JBD checkpoint lists into two
> 
> Seems to have a use-after-free bug.  Did you test it with CONFIG_SLAB_DEBUG?
  So I managed to debug this. I've also fixed one more bug I found and
simplified the code so that it should be now more straightforward. I
also changed several comments as they were rather outdated (at least
they seemed to me ;). The new version of the patch is attached (if you
would like relative diff better then write me but the changes were quite
big and I think replacing the patch makes things clearer).

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.12-rc5-3-checklist2.diff"

Split the checkpoint list of the transaction into two lists. In the first list
we keep the buffers that need to be submitted for IO. In the second list are
kept buffers that were already submitted and we just have to wait for the IO
to complete. This should simplify a handling of checkpoint lists a bit and
can eventually be also a performance gain.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-rc5-2-checkskip/fs/jbd/checkpoint.c linux-2.6.12-rc5-3-checklist/fs/jbd/checkpoint.c
--- linux-2.6.12-rc5-2-checkskip/fs/jbd/checkpoint.c	2005-05-27 11:18:08.000000000 +0200
+++ linux-2.6.12-rc5-3-checklist/fs/jbd/checkpoint.c	2005-06-09 12:23:00.000000000 +0200
@@ -24,29 +24,75 @@
 #include <linux/slab.h>
 
 /*
- * Unlink a buffer from a transaction. 
+ * Unlink a buffer from a transaction checkpoint list.
  *
  * Called with j_list_lock held.
  */
 
-static inline void __buffer_unlink(struct journal_head *jh)
+static inline void __buffer_unlink_first(struct journal_head *jh)
 {
 	transaction_t *transaction;
 
 	transaction = jh->b_cp_transaction;
-	jh->b_cp_transaction = NULL;
 
 	jh->b_cpnext->b_cpprev = jh->b_cpprev;
 	jh->b_cpprev->b_cpnext = jh->b_cpnext;
-	if (transaction->t_checkpoint_list == jh)
+	if (transaction->t_checkpoint_list == jh) {
 		transaction->t_checkpoint_list = jh->b_cpnext;
-	if (transaction->t_checkpoint_list == jh)
-		transaction->t_checkpoint_list = NULL;
+		if (transaction->t_checkpoint_list == jh)
+			transaction->t_checkpoint_list = NULL;
+	}
+}
+
+/*
+ * Unlink a buffer from a transaction checkpoint(io) list.
+ *
+ * Called with j_list_lock held.
+ */
+
+static inline void __buffer_unlink(struct journal_head *jh)
+{
+	transaction_t *transaction;
+
+	transaction = jh->b_cp_transaction;
+
+	__buffer_unlink_first(jh);
+	if (transaction->t_checkpoint_io_list == jh) {
+		transaction->t_checkpoint_io_list = jh->b_cpnext;
+		if (transaction->t_checkpoint_io_list == jh)
+			transaction->t_checkpoint_io_list = NULL;
+	}
+}
+
+/*
+ * Move a buffer from the checkpoint list to the checkpoint io list
+ *
+ * Called with j_list_lock held
+ */
+
+static inline void __buffer_relink_io(struct journal_head *jh)
+{
+	transaction_t *transaction;
+
+	transaction = jh->b_cp_transaction;
+	__buffer_unlink_first(jh);
+	
+	if (!transaction->t_checkpoint_io_list) {
+		jh->b_cpnext = jh->b_cpprev = jh;
+	} else {
+		jh->b_cpnext = transaction->t_checkpoint_io_list;
+		jh->b_cpprev = transaction->t_checkpoint_io_list->b_cpprev;
+		jh->b_cpprev->b_cpnext = jh;
+		jh->b_cpnext->b_cpprev = jh;
+	}
+	transaction->t_checkpoint_io_list = jh;
 }
 
 /*
  * Try to release a checkpointed buffer from its transaction.
- * Returns 1 if we released it.
+ * Returns 1 if we released it and 2 if we also released the
+ * whole transaction.
+ *
  * Requires j_list_lock
  * Called under jbd_lock_bh_state(jh2bh(jh)), and drops it
  */
@@ -57,12 +103,11 @@ static int __try_to_free_cp_buf(struct j
 
 	if (jh->b_jlist == BJ_None && !buffer_locked(bh) && !buffer_dirty(bh)) {
 		JBUFFER_TRACE(jh, "remove from checkpoint list");
-		__journal_remove_checkpoint(jh);
+		ret = __journal_remove_checkpoint(jh) + 1;
 		jbd_unlock_bh_state(bh);
 		journal_remove_journal_head(bh);
 		BUFFER_TRACE(bh, "release");
 		__brelse(bh);
-		ret = 1;
 	} else {
 		jbd_unlock_bh_state(bh);
 	}
@@ -117,83 +162,51 @@ static void jbd_sync_bh(journal_t *journ
 }
 
 /*
- * Clean up a transaction's checkpoint list.  
- *
- * We wait for any pending IO to complete and make sure any clean
- * buffers are removed from the transaction. 
- *
- * Return 1 if we performed any actions which might have destroyed the
- * checkpoint.  (journal_remove_checkpoint() deletes the transaction when
- * the last checkpoint buffer is cleansed)
+ * Clean up transaction's list of buffers submitted for io.
+ * We wait for any pending IO to complete and remove any clean
+ * buffers. Note that we take the buffers in the opposite ordering
+ * from the one in which they were submitted for IO.
  *
  * Called with j_list_lock held.
  */
-static int __cleanup_transaction(journal_t *journal, transaction_t *transaction)
+
+static void __wait_cp_io(journal_t *journal, transaction_t *transaction)
 {
-	struct journal_head *jh, *next_jh, *last_jh;
+	struct journal_head *jh;
 	struct buffer_head *bh;
-	int ret = 0;
-
-	assert_spin_locked(&journal->j_list_lock);
-	jh = transaction->t_checkpoint_list;
-	if (!jh)
-		return 0;
+	tid_t this_tid;
+	int released = 0;
 
-	last_jh = jh->b_cpprev;
-	next_jh = jh;
-	do {
-		jh = next_jh;
+	this_tid = transaction->t_tid;
+restart:
+	/* Didn't somebody clean up the transaction in the meanwhile */
+	if (journal->j_checkpoint_transactions != transaction ||
+		transaction->t_tid != this_tid)
+		return;
+	while (!released && transaction->t_checkpoint_io_list) {
+		jh = transaction->t_checkpoint_io_list;
 		bh = jh2bh(jh);
+		if (!jbd_trylock_bh_state(bh)) {
+			jbd_sync_bh(journal, bh);
+			spin_lock(&journal->j_list_lock);
+			goto restart;
+		}
 		if (buffer_locked(bh)) {
 			atomic_inc(&bh->b_count);
 			spin_unlock(&journal->j_list_lock);
+			jbd_unlock_bh_state(bh);
 			wait_on_buffer(bh);
 			/* the journal_head may have gone by now */
 			BUFFER_TRACE(bh, "brelse");
 			__brelse(bh);
-			goto out_return_1;
-		}
-
-		/*
-		 * This is foul
-		 */
-		if (!jbd_trylock_bh_state(bh)) {
-			jbd_sync_bh(journal, bh);
-			goto out_return_1;
-		}
-
-		if (jh->b_transaction != NULL) {
-			transaction_t *t = jh->b_transaction;
-			tid_t tid = t->t_tid;
-
-			spin_unlock(&journal->j_list_lock);
-			jbd_unlock_bh_state(bh);
-			log_start_commit(journal, tid);
-			log_wait_commit(journal, tid);
-			goto out_return_1;
-		}
-
-		/*
-		 * AKPM: I think the buffer_jbddirty test is redundant - it
-		 * shouldn't have NULL b_transaction?
-		 */
-		next_jh = jh->b_cpnext;
-		if (!buffer_dirty(bh) && !buffer_jbddirty(bh)) {
-			BUFFER_TRACE(bh, "remove from checkpoint");
-			__journal_remove_checkpoint(jh);
-			jbd_unlock_bh_state(bh);
-			journal_remove_journal_head(bh);
-			__brelse(bh);
-			ret = 1;
-		} else {
-			jbd_unlock_bh_state(bh);
+			spin_lock(&journal->j_list_lock);
+			goto restart;
 		}
-	} while (jh != last_jh);
-
-	return ret;
-out_return_1:
-	spin_lock(&journal->j_list_lock);
-	return 1;
+		/* Now in whatever state the buffer currently is, we know that
+		 * it has been written out and so we can drop it from the list */
+		released = __journal_remove_checkpoint(jh);
+		jbd_unlock_bh_state(bh);
+	}
 }
 
 #define NR_BATCH	64
@@ -203,9 +216,7 @@ __flush_batch(journal_t *journal, struct
 {
 	int i;
 
-	spin_unlock(&journal->j_list_lock);
 	ll_rw_block(WRITE, *batch_count, bhs);
-	spin_lock(&journal->j_list_lock);
 	for (i = 0; i < *batch_count; i++) {
 		struct buffer_head *bh = bhs[i];
 		clear_buffer_jwrite(bh);
@@ -221,19 +232,46 @@ __flush_batch(journal_t *journal, struct
  * Return 1 if something happened which requires us to abort the current
  * scan of the checkpoint list.  
  *
- * Called with j_list_lock held.
+ * Called with j_list_lock held and drops it if 1 is returned
  * Called under jbd_lock_bh_state(jh2bh(jh)), and drops it
  */
-static int __flush_buffer(journal_t *journal, struct journal_head *jh,
-			struct buffer_head **bhs, int *batch_count,
-			int *drop_count)
+static int __process_buffer(journal_t *journal, struct journal_head *jh,
+			struct buffer_head **bhs, int *batch_count)
 {
 	struct buffer_head *bh = jh2bh(jh);
 	int ret = 0;
 
-	if (buffer_dirty(bh) && !buffer_locked(bh) && jh->b_jlist == BJ_None) {
-		J_ASSERT_JH(jh, jh->b_transaction == NULL);
+	if (buffer_locked(bh)) {
+		atomic_inc(&bh->b_count);
+		spin_unlock(&journal->j_list_lock);
+		jbd_unlock_bh_state(bh);
+		wait_on_buffer(bh);
+		/* the journal_head may have gone by now */
+		BUFFER_TRACE(bh, "brelse");
+		__brelse(bh);
+		ret = 1;
+	}
+	else if (jh->b_transaction != NULL) {
+		transaction_t *t = jh->b_transaction;
+		tid_t tid = t->t_tid;
 
+		spin_unlock(&journal->j_list_lock);
+		jbd_unlock_bh_state(bh);
+		log_start_commit(journal, tid);
+		log_wait_commit(journal, tid);
+		ret = 1;
+	}
+	else if (!buffer_dirty(bh)) {
+		J_ASSERT_JH(jh, !buffer_jbddirty(bh));
+		BUFFER_TRACE(bh, "remove from checkpoint");
+		__journal_remove_checkpoint(jh);
+		spin_unlock(&journal->j_list_lock);
+		jbd_unlock_bh_state(bh);
+		journal_remove_journal_head(bh);
+		__brelse(bh);
+		ret = 1;
+	}
+	else {
 		/*
 		 * Important: we are about to write the buffer, and
 		 * possibly block, while still holding the journal lock.
@@ -246,45 +284,30 @@ static int __flush_buffer(journal_t *jou
 		J_ASSERT_BH(bh, !buffer_jwrite(bh));
 		set_buffer_jwrite(bh);
 		bhs[*batch_count] = bh;
+		__buffer_relink_io(jh);
 		jbd_unlock_bh_state(bh);
 		(*batch_count)++;
 		if (*batch_count == NR_BATCH) {
+			spin_unlock(&journal->j_list_lock);
 			__flush_batch(journal, bhs, batch_count);
 			ret = 1;
 		}
-	} else {
-		int last_buffer = 0;
-		if (jh->b_cpnext == jh) {
-			/* We may be about to drop the transaction.  Tell the
-			 * caller that the lists have changed.
-			 */
-			last_buffer = 1;
-		}
-		if (__try_to_free_cp_buf(jh)) {
-			(*drop_count)++;
-			ret = last_buffer;
-		}
 	}
 	return ret;
 }
 
 /*
- * Perform an actual checkpoint.  We don't write out only enough to
- * satisfy the current blocked requests: rather we submit a reasonably
- * sized chunk of the outstanding data to disk at once for
- * efficiency.  __log_wait_for_space() will retry if we didn't free enough.
+ * Perform an actual checkpoint. We take the first transaction on the
+ * list of transactions to be checkpointed and send all its buffers
+ * to disk. We submit larger chunks of data at once.
  * 
- * However, we _do_ take into account the amount requested so that once
- * the IO has been queued, we can return as soon as enough of it has
- * completed to disk.  
- *
  * The journal should be locked before calling this function.
  */
 int log_do_checkpoint(journal_t *journal)
 {
+	transaction_t *transaction;
+	tid_t this_tid;
 	int result;
-	int batch_count = 0;
-	struct buffer_head *bhs[NR_BATCH];
 
 	jbd_debug(1, "Start checkpoint\n");
 
@@ -299,79 +322,68 @@ int log_do_checkpoint(journal_t *journal
 		return result;
 
 	/*
-	 * OK, we need to start writing disk blocks.  Try to free up a
-	 * quarter of the log in a single checkpoint if we can.
+	 * OK, we need to start writing disk blocks.  Take one transaction
+	 * and write it.
 	 */
+	spin_lock(&journal->j_list_lock);
+	if (!journal->j_checkpoint_transactions)
+		goto out;
+	transaction = journal->j_checkpoint_transactions;
+	this_tid = transaction->t_tid;
+restart:
 	/*
-	 * AKPM: check this code.  I had a feeling a while back that it
-	 * degenerates into a busy loop at unmount time.
+	 * If someone cleaned up this transaction while we slept, we're
+	 * done (maybe it's a new transaction, but it fell at the same
+	 * address).
 	 */
-	spin_lock(&journal->j_list_lock);
-	while (journal->j_checkpoint_transactions) {
-		transaction_t *transaction;
-		struct journal_head *jh, *last_jh, *next_jh;
-		int drop_count = 0;
-		int cleanup_ret, retry = 0;
-		tid_t this_tid;
-
-		transaction = journal->j_checkpoint_transactions;
-		this_tid = transaction->t_tid;
-		jh = transaction->t_checkpoint_list;
-		last_jh = jh->b_cpprev;
-		next_jh = jh;
-		do {
+ 	if (journal->j_checkpoint_transactions == transaction
+		|| transaction->t_tid == this_tid) {
+		int batch_count = 0;
+		struct buffer_head *bhs[NR_BATCH];
+		struct journal_head *jh;
+		int retry = 0;
+
+		while (!retry && transaction->t_checkpoint_list) {
 			struct buffer_head *bh;
 
-			jh = next_jh;
-			next_jh = jh->b_cpnext;
+			jh = transaction->t_checkpoint_list;
 			bh = jh2bh(jh);
 			if (!jbd_trylock_bh_state(bh)) {
 				jbd_sync_bh(journal, bh);
-				spin_lock(&journal->j_list_lock);
 				retry = 1;
 				break;
 			}
-			retry = __flush_buffer(journal, jh, bhs, &batch_count, &drop_count);
-			if (cond_resched_lock(&journal->j_list_lock)) {
+			retry = __process_buffer(journal, jh, bhs,
+				&batch_count);
+			if (!retry &&
+			    lock_need_resched(&journal->j_list_lock)) {
+				spin_unlock(&journal->j_list_lock);
 				retry = 1;
 				break;
 			}
-		} while (jh != last_jh && !retry);
+		}
 
 		if (batch_count) {
+			if (!retry) {
+				spin_unlock(&journal->j_list_lock);
+				retry = 1;
+			}
 			__flush_batch(journal, bhs, &batch_count);
-			retry = 1;
 		}
 
-		/*
-		 * If someone cleaned up this transaction while we slept, we're
-		 * done
-		 */
-		if (journal->j_checkpoint_transactions != transaction)
-			break;
-		if (retry)
-			continue;
-		/*
-		 * Maybe it's a new transaction, but it fell at the same
-		 * address
-		 */
-		if (transaction->t_tid != this_tid)
-			continue;
-		/*
-		 * We have walked the whole transaction list without
-		 * finding anything to write to disk.  We had better be
-		 * able to make some progress or we are in trouble. 
-		 */
-		cleanup_ret = __cleanup_transaction(journal, transaction);
-		J_ASSERT(drop_count != 0 || cleanup_ret != 0);
-		if (journal->j_checkpoint_transactions != transaction)
-			break;
+		if (retry) {
+			spin_lock(&journal->j_list_lock);
+			goto restart;
+		}
+		/* Now we have cleaned up the first transaction's checkpoint
+		 * list. Let's clean up the second one. */
+		__wait_cp_io(journal, transaction);
 	}
+out:
 	spin_unlock(&journal->j_list_lock);
 	result = cleanup_journal_tail(journal);
 	if (result < 0)
 		return result;
-
 	return 0;
 }
 
@@ -456,52 +468,91 @@ int cleanup_journal_tail(journal_t *jour
 /* Checkpoint list management */
 
 /*
+ * journal_clean_one_cp_list
+ *
+ * Find all the written-back checkpoint buffers in the given list and release them.
+ *
+ * Called with the journal locked.
+ * Called with j_list_lock held.
+ * Returns number of bufers reaped (for debug)
+ */
+
+static int journal_clean_one_cp_list(struct journal_head *jh, int *released)
+{
+	struct journal_head *last_jh;
+	struct journal_head *next_jh = jh;
+	int ret, freed = 0;
+
+	*released = 0;
+	if (!jh)
+		return 0;
+
+ 	last_jh = jh->b_cpprev;
+	do {
+		jh = next_jh;
+		next_jh = jh->b_cpnext;
+		/* Use trylock because of the ranking */
+		if (jbd_trylock_bh_state(jh2bh(jh))) {
+			ret = __try_to_free_cp_buf(jh);
+			if (ret) {
+				freed++;
+				if (ret == 2) {
+					*released = 1;
+					return freed;
+				}
+			}
+		}
+		/*
+		 * This function only frees up some memory
+		 * if possible so we dont have an obligation
+		 * to finish processing. Bail out if preemption
+		 * requested:
+		 */
+		if (need_resched())
+			return freed;
+	} while (jh != last_jh);
+
+	return freed;
+}
+
+/*
  * journal_clean_checkpoint_list
  *
  * Find all the written-back checkpoint buffers in the journal and release them.
  *
  * Called with the journal locked.
  * Called with j_list_lock held.
- * Returns number of bufers reaped (for debug)
+ * Returns number of buffers reaped (for debug)
  */
 
 int __journal_clean_checkpoint_list(journal_t *journal)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
-	int ret = 0;
+	int ret = 0, released;
 
 	transaction = journal->j_checkpoint_transactions;
-	if (transaction == 0)
+	if (!transaction)
 		goto out;
 
 	last_transaction = transaction->t_cpprev;
 	next_transaction = transaction;
 	do {
-		struct journal_head *jh;
-
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
-		jh = transaction->t_checkpoint_list;
-		if (jh) {
-			struct journal_head *last_jh = jh->b_cpprev;
-			struct journal_head *next_jh = jh;
-
-			do {
-				jh = next_jh;
-				next_jh = jh->b_cpnext;
-				/* Use trylock because of the ranknig */
-				if (jbd_trylock_bh_state(jh2bh(jh)))
-					ret += __try_to_free_cp_buf(jh);
-				/*
-				 * This function only frees up some memory
-				 * if possible so we dont have an obligation
-				 * to finish processing. Bail out if preemption
-				 * requested:
-				 */
-				if (need_resched())
-					goto out;
-			} while (jh != last_jh);
-		}
+		ret += journal_clean_one_cp_list(transaction->
+				t_checkpoint_list, &released);
+		if (need_resched())
+			goto out;
+		if (released)
+			continue;
+		/* It is essential that we are as careful as in the case of
+		   t_checkpoint_list with removing the buffer from the list
+		   as we can possibly see not yet submitted buffers on
+		   io_list */
+		ret += journal_clean_one_cp_list(transaction->
+				t_checkpoint_io_list, &released);
+		if (need_resched())
+			goto out;
 	} while (transaction != last_transaction);
 out:
 	return ret;
@@ -516,18 +567,22 @@ out:
  * buffer updates committed in that transaction have safely been stored
  * elsewhere on disk.  To achieve this, all of the buffers in a
  * transaction need to be maintained on the transaction's checkpoint
- * list until they have been rewritten, at which point this function is
+ * lists until they have been rewritten, at which point this function is
  * called to remove the buffer from the existing transaction's
- * checkpoint list.  
+ * checkpoint lists.  
+ *
+ * The function returns 1 if it frees the transaction, 0 otherwise.
  *
  * This function is called with the journal locked.
  * This function is called with j_list_lock held.
+ * This function is called with jbd_lock_bh_state(jh2bh(jh))
  */
 
-void __journal_remove_checkpoint(struct journal_head *jh)
+int __journal_remove_checkpoint(struct journal_head *jh)
 {
 	transaction_t *transaction;
 	journal_t *journal;
+	int ret = 0;
 
 	JBUFFER_TRACE(jh, "entry");
 
@@ -538,8 +593,10 @@ void __journal_remove_checkpoint(struct 
 	journal = transaction->t_journal;
 
 	__buffer_unlink(jh);
+	jh->b_cp_transaction = NULL;
 
-	if (transaction->t_checkpoint_list != NULL)
+	if (transaction->t_checkpoint_list != NULL ||
+	    transaction->t_checkpoint_io_list != NULL)
 		goto out;
 	JBUFFER_TRACE(jh, "transaction has no more buffers");
 
@@ -565,8 +622,10 @@ void __journal_remove_checkpoint(struct 
 	/* Just in case anybody was waiting for more transactions to be
            checkpointed... */
 	wake_up(&journal->j_wait_logspace);
+	ret = 1;
 out:
 	JBUFFER_TRACE(jh, "exit");
+	return ret;
 }
 
 /*
@@ -628,6 +687,7 @@ void __journal_drop_transaction(journal_
 	J_ASSERT(transaction->t_shadow_list == NULL);
 	J_ASSERT(transaction->t_log_list == NULL);
 	J_ASSERT(transaction->t_checkpoint_list == NULL);
+	J_ASSERT(transaction->t_checkpoint_io_list == NULL);
 	J_ASSERT(transaction->t_updates == 0);
 	J_ASSERT(journal->j_committing_transaction != transaction);
 	J_ASSERT(journal->j_running_transaction != transaction);
diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-rc5-2-checkskip/include/linux/jbd.h linux-2.6.12-rc5-3-checklist/include/linux/jbd.h
--- linux-2.6.12-rc5-2-checkskip/include/linux/jbd.h	2005-05-27 10:48:50.000000000 +0200
+++ linux-2.6.12-rc5-3-checklist/include/linux/jbd.h	2005-05-31 18:19:44.000000000 +0200
@@ -499,6 +499,12 @@ struct transaction_s 
 	struct journal_head	*t_checkpoint_list;
 
 	/*
+	 * Doubly-linked circular list of all buffers submitted for IO while
+	 * checkpointing. [j_list_lock]
+	 */
+	struct journal_head	*t_checkpoint_io_list;
+
+	/*
 	 * Doubly-linked circular list of temporary buffers currently undergoing
 	 * IO in the log [j_list_lock]
 	 */
@@ -841,7 +847,7 @@ extern void journal_commit_transaction(j
 
 /* Checkpoint list management */
 int __journal_clean_checkpoint_list(journal_t *journal);
-void __journal_remove_checkpoint(struct journal_head *);
+int __journal_remove_checkpoint(struct journal_head *);
 void __journal_insert_checkpoint(struct journal_head *, transaction_t *);
 
 /* Buffer IO */

--n8g4imXOkfNTN/H1--
