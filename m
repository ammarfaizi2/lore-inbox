Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWBMW0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWBMW0c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWBMW0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:26:32 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:40544 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964870AbWBMW0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:26:31 -0500
Date: Mon, 13 Feb 2006 14:26:06 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Claudio Martins <ctpm@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Jan Kara <jack@suse.cz>
Subject: Re: OCFS2 Filesystem inconsistency across nodes
Message-ID: <20060213222606.GC20175@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <200602100536.02893.ctpm@rnl.ist.utl.pt> <20060210064612.GE12046@ca-server1.us.oracle.com> <200602110540.57573.ctpm@rnl.ist.utl.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602110540.57573.ctpm@rnl.ist.utl.pt>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 05:40:57AM +0000, Claudio Martins wrote:
> This is my /etc/ocfs2/cluster.conf on every node:

Hi Claudio,
	Thanks for sending me your config files. Everything seems in order.
I was easily able to reproduce your problem on my cluster and was able to
git-bisect my way to some JBD changes which seem to be causing the issue.
Reverting those patches fixes things. Can you apply the attached patch and
confirm that it also fixes this particular problem for you? You'll have to
apply to all kernels in your cluster and either run fsck.ocfs2 or create a
new file system before testing again.

Linus, Andrew, Jan,
	OCFS2 uses journal_flush() to sync metadata out to disk when another
node wants to obtain a lock on an inode which has pending journaled changes.
Something in Jan Kara's patch titled "jbd: split checkpoint lists" broke
this for OCFS2 (and I suspect for other users of JBD as well). As a result
metadata is not always completely flushed to disk by the end of the
journal_flush() call.

One easy way to reproduce is to create files from one node and list the
directory from another. Switching the listing and creating nodes around
makes things reproduce more quickly -- eventually the listing node will
start missing new files.

Unfortunately I haven't been able to figure out exactly where the bug is,
leading me to develop a patch to revert the change for now. I suppose folks
can use this as a workaround until the bug is fixed.

Jan, I'd appreciate as much input as you can give -- in the meantime OCFS2
is totally broken for the multi-node case :(
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

[PATCH] jbd: revert checkpoint list changes

This patch reverts commit f93ea411b73594f7d144855fd34278bcf34a9afc:
  [PATCH] jbd: split checkpoint lists

This broke journal_flush() for OCFS2, which is its method of
being sure that metadata is sent to disk for another node.

And two related commits 8d3c7fce2d20ecc3264c8d8c91ae3beacdeaed1b and
43c3e6f5abdf6acac9b90c86bf03f995bf7d3d92 with the subjects:
  [PATCH] jbd: log_do_checkpoint fix
  [PATCH] jbd: remove_transaction fix

These seem to be incremental bugfixes on the original patch and as such are
no longer needed.

Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>

diff --git a/fs/jbd/checkpoint.c b/fs/jbd/checkpoint.c
index e6265a0..014a51f 100644
--- a/fs/jbd/checkpoint.c
+++ b/fs/jbd/checkpoint.c
@@ -24,75 +24,29 @@
 #include <linux/slab.h>
 
 /*
- * Unlink a buffer from a transaction checkpoint list.
+ * Unlink a buffer from a transaction. 
  *
  * Called with j_list_lock held.
  */
 
-static void __buffer_unlink_first(struct journal_head *jh)
+static inline void __buffer_unlink(struct journal_head *jh)
 {
 	transaction_t *transaction;
 
 	transaction = jh->b_cp_transaction;
+	jh->b_cp_transaction = NULL;
 
 	jh->b_cpnext->b_cpprev = jh->b_cpprev;
 	jh->b_cpprev->b_cpnext = jh->b_cpnext;
-	if (transaction->t_checkpoint_list == jh) {
+	if (transaction->t_checkpoint_list == jh)
 		transaction->t_checkpoint_list = jh->b_cpnext;
-		if (transaction->t_checkpoint_list == jh)
-			transaction->t_checkpoint_list = NULL;
-	}
-}
-
-/*
- * Unlink a buffer from a transaction checkpoint(io) list.
- *
- * Called with j_list_lock held.
- */
-
-static inline void __buffer_unlink(struct journal_head *jh)
-{
-	transaction_t *transaction;
-
-	transaction = jh->b_cp_transaction;
-
-	__buffer_unlink_first(jh);
-	if (transaction->t_checkpoint_io_list == jh) {
-		transaction->t_checkpoint_io_list = jh->b_cpnext;
-		if (transaction->t_checkpoint_io_list == jh)
-			transaction->t_checkpoint_io_list = NULL;
-	}
-}
-
-/*
- * Move a buffer from the checkpoint list to the checkpoint io list
- *
- * Called with j_list_lock held
- */
-
-static inline void __buffer_relink_io(struct journal_head *jh)
-{
-	transaction_t *transaction;
-
-	transaction = jh->b_cp_transaction;
-	__buffer_unlink_first(jh);
-
-	if (!transaction->t_checkpoint_io_list) {
-		jh->b_cpnext = jh->b_cpprev = jh;
-	} else {
-		jh->b_cpnext = transaction->t_checkpoint_io_list;
-		jh->b_cpprev = transaction->t_checkpoint_io_list->b_cpprev;
-		jh->b_cpprev->b_cpnext = jh;
-		jh->b_cpnext->b_cpprev = jh;
-	}
-	transaction->t_checkpoint_io_list = jh;
+	if (transaction->t_checkpoint_list == jh)
+		transaction->t_checkpoint_list = NULL;
 }
 
 /*
  * Try to release a checkpointed buffer from its transaction.
- * Returns 1 if we released it and 2 if we also released the
- * whole transaction.
- *
+ * Returns 1 if we released it.
  * Requires j_list_lock
  * Called under jbd_lock_bh_state(jh2bh(jh)), and drops it
  */
@@ -103,11 +57,12 @@ static int __try_to_free_cp_buf(struct j
 
 	if (jh->b_jlist == BJ_None && !buffer_locked(bh) && !buffer_dirty(bh)) {
 		JBUFFER_TRACE(jh, "remove from checkpoint list");
-		ret = __journal_remove_checkpoint(jh) + 1;
+		__journal_remove_checkpoint(jh);
 		jbd_unlock_bh_state(bh);
 		journal_remove_journal_head(bh);
 		BUFFER_TRACE(bh, "release");
 		__brelse(bh);
+		ret = 1;
 	} else {
 		jbd_unlock_bh_state(bh);
 	}
@@ -162,53 +117,83 @@ static void jbd_sync_bh(journal_t *journ
 }
 
 /*
- * Clean up transaction's list of buffers submitted for io.
- * We wait for any pending IO to complete and remove any clean
- * buffers. Note that we take the buffers in the opposite ordering
- * from the one in which they were submitted for IO.
+ * Clean up a transaction's checkpoint list.  
+ *
+ * We wait for any pending IO to complete and make sure any clean
+ * buffers are removed from the transaction. 
+ *
+ * Return 1 if we performed any actions which might have destroyed the
+ * checkpoint.  (journal_remove_checkpoint() deletes the transaction when
+ * the last checkpoint buffer is cleansed)
  *
  * Called with j_list_lock held.
  */
-
-static void __wait_cp_io(journal_t *journal, transaction_t *transaction)
+static int __cleanup_transaction(journal_t *journal, transaction_t *transaction)
 {
-	struct journal_head *jh;
+	struct journal_head *jh, *next_jh, *last_jh;
 	struct buffer_head *bh;
-	tid_t this_tid;
-	int released = 0;
+	int ret = 0;
+
+	assert_spin_locked(&journal->j_list_lock);
+	jh = transaction->t_checkpoint_list;
+	if (!jh)
+		return 0;
 
-	this_tid = transaction->t_tid;
-restart:
-	/* Didn't somebody clean up the transaction in the meanwhile */
-	if (journal->j_checkpoint_transactions != transaction ||
-		transaction->t_tid != this_tid)
-		return;
-	while (!released && transaction->t_checkpoint_io_list) {
-		jh = transaction->t_checkpoint_io_list;
+	last_jh = jh->b_cpprev;
+	next_jh = jh;
+	do {
+		jh = next_jh;
 		bh = jh2bh(jh);
-		if (!jbd_trylock_bh_state(bh)) {
-			jbd_sync_bh(journal, bh);
-			spin_lock(&journal->j_list_lock);
-			goto restart;
-		}
 		if (buffer_locked(bh)) {
 			atomic_inc(&bh->b_count);
 			spin_unlock(&journal->j_list_lock);
-			jbd_unlock_bh_state(bh);
 			wait_on_buffer(bh);
 			/* the journal_head may have gone by now */
 			BUFFER_TRACE(bh, "brelse");
 			__brelse(bh);
-			spin_lock(&journal->j_list_lock);
-			goto restart;
+			goto out_return_1;
 		}
+
 		/*
-		 * Now in whatever state the buffer currently is, we know that
-		 * it has been written out and so we can drop it from the list
+		 * This is foul
 		 */
-		released = __journal_remove_checkpoint(jh);
-		jbd_unlock_bh_state(bh);
-	}
+		if (!jbd_trylock_bh_state(bh)) {
+			jbd_sync_bh(journal, bh);
+			goto out_return_1;
+		}
+
+		if (jh->b_transaction != NULL) {
+			transaction_t *t = jh->b_transaction;
+			tid_t tid = t->t_tid;
+
+			spin_unlock(&journal->j_list_lock);
+			jbd_unlock_bh_state(bh);
+			log_start_commit(journal, tid);
+			log_wait_commit(journal, tid);
+			goto out_return_1;
+		}
+
+		/*
+		 * AKPM: I think the buffer_jbddirty test is redundant - it
+		 * shouldn't have NULL b_transaction?
+		 */
+		next_jh = jh->b_cpnext;
+		if (!buffer_dirty(bh) && !buffer_jbddirty(bh)) {
+			BUFFER_TRACE(bh, "remove from checkpoint");
+			__journal_remove_checkpoint(jh);
+			jbd_unlock_bh_state(bh);
+			journal_remove_journal_head(bh);
+			__brelse(bh);
+			ret = 1;
+		} else {
+			jbd_unlock_bh_state(bh);
+		}
+	} while (jh != last_jh);
+
+	return ret;
+out_return_1:
+	spin_lock(&journal->j_list_lock);
+	return 1;
 }
 
 #define NR_BATCH	64
@@ -218,7 +203,9 @@ __flush_batch(journal_t *journal, struct
 {
 	int i;
 
+	spin_unlock(&journal->j_list_lock);
 	ll_rw_block(SWRITE, *batch_count, bhs);
+	spin_lock(&journal->j_list_lock);
 	for (i = 0; i < *batch_count; i++) {
 		struct buffer_head *bh = bhs[i];
 		clear_buffer_jwrite(bh);
@@ -234,46 +221,19 @@ __flush_batch(journal_t *journal, struct
  * Return 1 if something happened which requires us to abort the current
  * scan of the checkpoint list.  
  *
- * Called with j_list_lock held and drops it if 1 is returned
+ * Called with j_list_lock held.
  * Called under jbd_lock_bh_state(jh2bh(jh)), and drops it
  */
-static int __process_buffer(journal_t *journal, struct journal_head *jh,
-			struct buffer_head **bhs, int *batch_count)
+static int __flush_buffer(journal_t *journal, struct journal_head *jh,
+			struct buffer_head **bhs, int *batch_count,
+			int *drop_count)
 {
 	struct buffer_head *bh = jh2bh(jh);
 	int ret = 0;
 
-	if (buffer_locked(bh)) {
-		get_bh(bh);
-		spin_unlock(&journal->j_list_lock);
-		jbd_unlock_bh_state(bh);
-		wait_on_buffer(bh);
-		/* the journal_head may have gone by now */
-		BUFFER_TRACE(bh, "brelse");
-		put_bh(bh);
-		ret = 1;
-	}
-	else if (jh->b_transaction != NULL) {
-		transaction_t *t = jh->b_transaction;
-		tid_t tid = t->t_tid;
+	if (buffer_dirty(bh) && !buffer_locked(bh) && jh->b_jlist == BJ_None) {
+		J_ASSERT_JH(jh, jh->b_transaction == NULL);
 
-		spin_unlock(&journal->j_list_lock);
-		jbd_unlock_bh_state(bh);
-		log_start_commit(journal, tid);
-		log_wait_commit(journal, tid);
-		ret = 1;
-	}
-	else if (!buffer_dirty(bh)) {
-		J_ASSERT_JH(jh, !buffer_jbddirty(bh));
-		BUFFER_TRACE(bh, "remove from checkpoint");
-		__journal_remove_checkpoint(jh);
-		spin_unlock(&journal->j_list_lock);
-		jbd_unlock_bh_state(bh);
-		journal_remove_journal_head(bh);
-		put_bh(bh);
-		ret = 1;
-	}
-	else {
 		/*
 		 * Important: we are about to write the buffer, and
 		 * possibly block, while still holding the journal lock.
@@ -286,30 +246,45 @@ static int __process_buffer(journal_t *j
 		J_ASSERT_BH(bh, !buffer_jwrite(bh));
 		set_buffer_jwrite(bh);
 		bhs[*batch_count] = bh;
-		__buffer_relink_io(jh);
 		jbd_unlock_bh_state(bh);
 		(*batch_count)++;
 		if (*batch_count == NR_BATCH) {
-			spin_unlock(&journal->j_list_lock);
 			__flush_batch(journal, bhs, batch_count);
 			ret = 1;
 		}
+	} else {
+		int last_buffer = 0;
+		if (jh->b_cpnext == jh) {
+			/* We may be about to drop the transaction.  Tell the
+			 * caller that the lists have changed.
+			 */
+			last_buffer = 1;
+		}
+		if (__try_to_free_cp_buf(jh)) {
+			(*drop_count)++;
+			ret = last_buffer;
+		}
 	}
 	return ret;
 }
 
 /*
- * Perform an actual checkpoint. We take the first transaction on the
- * list of transactions to be checkpointed and send all its buffers
- * to disk. We submit larger chunks of data at once.
+ * Perform an actual checkpoint.  We don't write out only enough to
+ * satisfy the current blocked requests: rather we submit a reasonably
+ * sized chunk of the outstanding data to disk at once for
+ * efficiency.  __log_wait_for_space() will retry if we didn't free enough.
  * 
+ * However, we _do_ take into account the amount requested so that once
+ * the IO has been queued, we can return as soon as enough of it has
+ * completed to disk.  
+ *
  * The journal should be locked before calling this function.
  */
 int log_do_checkpoint(journal_t *journal)
 {
-	transaction_t *transaction;
-	tid_t this_tid;
 	int result;
+	int batch_count = 0;
+	struct buffer_head *bhs[NR_BATCH];
 
 	jbd_debug(1, "Start checkpoint\n");
 
@@ -324,70 +299,79 @@ int log_do_checkpoint(journal_t *journal
 		return result;
 
 	/*
-	 * OK, we need to start writing disk blocks.  Take one transaction
-	 * and write it.
+	 * OK, we need to start writing disk blocks.  Try to free up a
+	 * quarter of the log in a single checkpoint if we can.
 	 */
-	spin_lock(&journal->j_list_lock);
-	if (!journal->j_checkpoint_transactions)
-		goto out;
-	transaction = journal->j_checkpoint_transactions;
-	this_tid = transaction->t_tid;
-restart:
 	/*
-	 * If someone cleaned up this transaction while we slept, we're
-	 * done (maybe it's a new transaction, but it fell at the same
-	 * address).
+	 * AKPM: check this code.  I had a feeling a while back that it
+	 * degenerates into a busy loop at unmount time.
 	 */
- 	if (journal->j_checkpoint_transactions == transaction &&
-			transaction->t_tid == this_tid) {
-		int batch_count = 0;
-		struct buffer_head *bhs[NR_BATCH];
-		struct journal_head *jh;
-		int retry = 0;
-
-		while (!retry && transaction->t_checkpoint_list) {
+	spin_lock(&journal->j_list_lock);
+	while (journal->j_checkpoint_transactions) {
+		transaction_t *transaction;
+		struct journal_head *jh, *last_jh, *next_jh;
+		int drop_count = 0;
+		int cleanup_ret, retry = 0;
+		tid_t this_tid;
+
+		transaction = journal->j_checkpoint_transactions;
+		this_tid = transaction->t_tid;
+		jh = transaction->t_checkpoint_list;
+		last_jh = jh->b_cpprev;
+		next_jh = jh;
+		do {
 			struct buffer_head *bh;
 
-			jh = transaction->t_checkpoint_list;
+			jh = next_jh;
+			next_jh = jh->b_cpnext;
 			bh = jh2bh(jh);
 			if (!jbd_trylock_bh_state(bh)) {
 				jbd_sync_bh(journal, bh);
+				spin_lock(&journal->j_list_lock);
 				retry = 1;
 				break;
 			}
-			retry = __process_buffer(journal, jh, bhs,
-						&batch_count);
-			if (!retry &&
-			    lock_need_resched(&journal->j_list_lock)) {
-				spin_unlock(&journal->j_list_lock);
+			retry = __flush_buffer(journal, jh, bhs, &batch_count, &drop_count);
+			if (cond_resched_lock(&journal->j_list_lock)) {
 				retry = 1;
 				break;
 			}
-		}
+		} while (jh != last_jh && !retry);
 
 		if (batch_count) {
-			if (!retry) {
-				spin_unlock(&journal->j_list_lock);
-				retry = 1;
-			}
 			__flush_batch(journal, bhs, &batch_count);
+			retry = 1;
 		}
 
-		if (retry) {
-			spin_lock(&journal->j_list_lock);
-			goto restart;
-		}
 		/*
-		 * Now we have cleaned up the first transaction's checkpoint
-		 * list.  Let's clean up the second one.
+		 * If someone cleaned up this transaction while we slept, we're
+		 * done
+		 */
+		if (journal->j_checkpoint_transactions != transaction)
+			break;
+		if (retry)
+			continue;
+		/*
+		 * Maybe it's a new transaction, but it fell at the same
+		 * address
 		 */
-		__wait_cp_io(journal, transaction);
+		if (transaction->t_tid != this_tid)
+			continue;
+		/*
+		 * We have walked the whole transaction list without
+		 * finding anything to write to disk.  We had better be
+		 * able to make some progress or we are in trouble. 
+		 */
+		cleanup_ret = __cleanup_transaction(journal, transaction);
+		J_ASSERT(drop_count != 0 || cleanup_ret != 0);
+		if (journal->j_checkpoint_transactions != transaction)
+			break;
 	}
-out:
 	spin_unlock(&journal->j_list_lock);
 	result = cleanup_journal_tail(journal);
 	if (result < 0)
 		return result;
+
 	return 0;
 }
 
@@ -472,91 +456,52 @@ int cleanup_journal_tail(journal_t *jour
 /* Checkpoint list management */
 
 /*
- * journal_clean_one_cp_list
- *
- * Find all the written-back checkpoint buffers in the given list and release them.
- *
- * Called with the journal locked.
- * Called with j_list_lock held.
- * Returns number of bufers reaped (for debug)
- */
-
-static int journal_clean_one_cp_list(struct journal_head *jh, int *released)
-{
-	struct journal_head *last_jh;
-	struct journal_head *next_jh = jh;
-	int ret, freed = 0;
-
-	*released = 0;
-	if (!jh)
-		return 0;
-
- 	last_jh = jh->b_cpprev;
-	do {
-		jh = next_jh;
-		next_jh = jh->b_cpnext;
-		/* Use trylock because of the ranking */
-		if (jbd_trylock_bh_state(jh2bh(jh))) {
-			ret = __try_to_free_cp_buf(jh);
-			if (ret) {
-				freed++;
-				if (ret == 2) {
-					*released = 1;
-					return freed;
-				}
-			}
-		}
-		/*
-		 * This function only frees up some memory if possible so we
-		 * dont have an obligation to finish processing. Bail out if
-		 * preemption requested:
-		 */
-		if (need_resched())
-			return freed;
-	} while (jh != last_jh);
-
-	return freed;
-}
-
-/*
  * journal_clean_checkpoint_list
  *
  * Find all the written-back checkpoint buffers in the journal and release them.
  *
  * Called with the journal locked.
  * Called with j_list_lock held.
- * Returns number of buffers reaped (for debug)
+ * Returns number of bufers reaped (for debug)
  */
 
 int __journal_clean_checkpoint_list(journal_t *journal)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
-	int ret = 0, released;
+	int ret = 0;
 
 	transaction = journal->j_checkpoint_transactions;
-	if (!transaction)
+	if (transaction == 0)
 		goto out;
 
 	last_transaction = transaction->t_cpprev;
 	next_transaction = transaction;
 	do {
+		struct journal_head *jh;
+
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
-		ret += journal_clean_one_cp_list(transaction->
-				t_checkpoint_list, &released);
-		if (need_resched())
-			goto out;
-		if (released)
-			continue;
-		/*
-		 * It is essential that we are as careful as in the case of
-		 * t_checkpoint_list with removing the buffer from the list as
-		 * we can possibly see not yet submitted buffers on io_list
-		 */
-		ret += journal_clean_one_cp_list(transaction->
-				t_checkpoint_io_list, &released);
-		if (need_resched())
-			goto out;
+		jh = transaction->t_checkpoint_list;
+		if (jh) {
+			struct journal_head *last_jh = jh->b_cpprev;
+			struct journal_head *next_jh = jh;
+
+			do {
+				jh = next_jh;
+				next_jh = jh->b_cpnext;
+				/* Use trylock because of the ranknig */
+				if (jbd_trylock_bh_state(jh2bh(jh)))
+					ret += __try_to_free_cp_buf(jh);
+				/*
+				 * This function only frees up some memory
+				 * if possible so we dont have an obligation
+				 * to finish processing. Bail out if preemption
+				 * requested:
+				 */
+				if (need_resched())
+					goto out;
+			} while (jh != last_jh);
+		}
 	} while (transaction != last_transaction);
 out:
 	return ret;
@@ -571,22 +516,18 @@ out:
  * buffer updates committed in that transaction have safely been stored
  * elsewhere on disk.  To achieve this, all of the buffers in a
  * transaction need to be maintained on the transaction's checkpoint
- * lists until they have been rewritten, at which point this function is
+ * list until they have been rewritten, at which point this function is
  * called to remove the buffer from the existing transaction's
- * checkpoint lists.
- *
- * The function returns 1 if it frees the transaction, 0 otherwise.
+ * checkpoint list.  
  *
  * This function is called with the journal locked.
  * This function is called with j_list_lock held.
- * This function is called with jbd_lock_bh_state(jh2bh(jh))
  */
 
-int __journal_remove_checkpoint(struct journal_head *jh)
+void __journal_remove_checkpoint(struct journal_head *jh)
 {
 	transaction_t *transaction;
 	journal_t *journal;
-	int ret = 0;
 
 	JBUFFER_TRACE(jh, "entry");
 
@@ -597,10 +538,8 @@ int __journal_remove_checkpoint(struct j
 	journal = transaction->t_journal;
 
 	__buffer_unlink(jh);
-	jh->b_cp_transaction = NULL;
 
-	if (transaction->t_checkpoint_list != NULL ||
-	    transaction->t_checkpoint_io_list != NULL)
+	if (transaction->t_checkpoint_list != NULL)
 		goto out;
 	JBUFFER_TRACE(jh, "transaction has no more buffers");
 
@@ -626,10 +565,8 @@ int __journal_remove_checkpoint(struct j
 	/* Just in case anybody was waiting for more transactions to be
            checkpointed... */
 	wake_up(&journal->j_wait_logspace);
-	ret = 1;
 out:
 	JBUFFER_TRACE(jh, "exit");
-	return ret;
 }
 
 /*
@@ -691,7 +628,6 @@ void __journal_drop_transaction(journal_
 	J_ASSERT(transaction->t_shadow_list == NULL);
 	J_ASSERT(transaction->t_log_list == NULL);
 	J_ASSERT(transaction->t_checkpoint_list == NULL);
-	J_ASSERT(transaction->t_checkpoint_io_list == NULL);
 	J_ASSERT(transaction->t_updates == 0);
 	J_ASSERT(journal->j_committing_transaction != transaction);
 	J_ASSERT(journal->j_running_transaction != transaction);
diff --git a/fs/jbd/commit.c b/fs/jbd/commit.c
index 29e62d9..002ad2b 100644
--- a/fs/jbd/commit.c
+++ b/fs/jbd/commit.c
@@ -829,8 +829,7 @@ restart_loop:
 	journal->j_committing_transaction = NULL;
 	spin_unlock(&journal->j_state_lock);
 
-	if (commit_transaction->t_checkpoint_list == NULL &&
-	    commit_transaction->t_checkpoint_io_list == NULL) {
+	if (commit_transaction->t_checkpoint_list == NULL) {
 		__journal_drop_transaction(journal, commit_transaction);
 	} else {
 		if (journal->j_checkpoint_transactions == NULL) {
diff --git a/include/linux/jbd.h b/include/linux/jbd.h
index 0fe4aa8..41ee799 100644
--- a/include/linux/jbd.h
+++ b/include/linux/jbd.h
@@ -498,12 +498,6 @@ struct transaction_s 
 	struct journal_head	*t_checkpoint_list;
 
 	/*
-	 * Doubly-linked circular list of all buffers submitted for IO while
-	 * checkpointing. [j_list_lock]
-	 */
-	struct journal_head	*t_checkpoint_io_list;
-
-	/*
 	 * Doubly-linked circular list of temporary buffers currently undergoing
 	 * IO in the log [j_list_lock]
 	 */
@@ -852,7 +846,7 @@ extern void journal_commit_transaction(j
 
 /* Checkpoint list management */
 int __journal_clean_checkpoint_list(journal_t *journal);
-int __journal_remove_checkpoint(struct journal_head *);
+void __journal_remove_checkpoint(struct journal_head *);
 void __journal_insert_checkpoint(struct journal_head *, transaction_t *);
 
 /* Buffer IO */
