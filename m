Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVCPKBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVCPKBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVCPKBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:01:25 -0500
Received: from mx1.elte.hu ([157.181.1.137]:63657 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262318AbVCPJyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 04:54:16 -0500
Date: Wed, 16 Mar 2005 10:53:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: rostedt@goodmis.org, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: [patch 2/3] j_list_lock -> j_list_sem
Message-ID: <20050316095359.GB15460@elte.hu>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain> <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu> <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu> <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain> <20050316085029.GA11414@elte.hu> <20050316011510.2a3bdfdb.akpm@osdl.org> <20050316095155.GA15080@elte.hu> <20050316095322.GA15460@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316095322.GA15460@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch turns the j_list_lock spinlock into a mutex.
Builds/boots/works fine on x86.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/fs/jbd/checkpoint.c.orig
+++ linux/fs/jbd/checkpoint.c
@@ -26,7 +26,7 @@
 /*
  * Unlink a buffer from a transaction. 
  *
- * Called with j_list_lock held.
+ * Called with j_list_sem held.
  */
 
 static inline void __buffer_unlink(struct journal_head *jh)
@@ -47,7 +47,7 @@ static inline void __buffer_unlink(struc
 /*
  * Try to release a checkpointed buffer from its transaction.
  * Returns 1 if we released it.
- * Requires j_list_lock
+ * Requires j_list_sem
  * Called under jbd_lock_bh_state(jh2bh(jh)), and drops it
  */
 static int __try_to_free_cp_buf(struct journal_head *jh)
@@ -102,14 +102,14 @@ void __log_wait_for_space(journal_t *jou
 }
 
 /*
- * We were unable to perform jbd_trylock_bh_state() inside j_list_lock.
+ * We were unable to perform jbd_trylock_bh_state() inside j_list_sem.
  * The caller must restart a list walk.  Wait for someone else to run
  * jbd_unlock_bh_state().
  */
 static void jbd_sync_bh(journal_t *journal, struct buffer_head *bh)
 {
 	get_bh(bh);
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 	jbd_lock_bh_state(bh);
 	jbd_unlock_bh_state(bh);
 	put_bh(bh);
@@ -125,7 +125,7 @@ static void jbd_sync_bh(journal_t *journ
  * checkpoint.  (journal_remove_checkpoint() deletes the transaction when
  * the last checkpoint buffer is cleansed)
  *
- * Called with j_list_lock held.
+ * Called with j_list_sem held.
  */
 static int __cleanup_transaction(journal_t *journal, transaction_t *transaction)
 {
@@ -133,7 +133,6 @@ static int __cleanup_transaction(journal
 	struct buffer_head *bh;
 	int ret = 0;
 
-	assert_spin_locked(&journal->j_list_lock);
 	jh = transaction->t_checkpoint_list;
 	if (!jh)
 		return 0;
@@ -145,7 +144,7 @@ static int __cleanup_transaction(journal
 		bh = jh2bh(jh);
 		if (buffer_locked(bh)) {
 			atomic_inc(&bh->b_count);
-			spin_unlock(&journal->j_list_lock);
+			up(&journal->j_list_sem);
 			wait_on_buffer(bh);
 			/* the journal_head may have gone by now */
 			BUFFER_TRACE(bh, "brelse");
@@ -165,7 +164,7 @@ static int __cleanup_transaction(journal
 			transaction_t *t = jh->b_transaction;
 			tid_t tid = t->t_tid;
 
-			spin_unlock(&journal->j_list_lock);
+			up(&journal->j_list_sem);
 			jbd_unlock_bh_state(bh);
 			log_start_commit(journal, tid);
 			log_wait_commit(journal, tid);
@@ -192,7 +191,7 @@ static int __cleanup_transaction(journal
 
 	return ret;
 out_return_1:
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	return 1;
 }
 
@@ -203,9 +202,9 @@ __flush_batch(journal_t *journal, struct
 {
 	int i;
 
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 	ll_rw_block(WRITE, *batch_count, bhs);
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	for (i = 0; i < *batch_count; i++) {
 		struct buffer_head *bh = bhs[i];
 		clear_buffer_jwrite(bh);
@@ -221,7 +220,7 @@ __flush_batch(journal_t *journal, struct
  * Return 1 if something happened which requires us to abort the current
  * scan of the checkpoint list.  
  *
- * Called with j_list_lock held.
+ * Called with j_list_sem held.
  * Called under jbd_lock_bh_state(jh2bh(jh)), and drops it
  */
 static int __flush_buffer(journal_t *journal, struct journal_head *jh,
@@ -306,7 +305,7 @@ int log_do_checkpoint(journal_t *journal
 	 * AKPM: check this code.  I had a feeling a while back that it
 	 * degenerates into a busy loop at unmount time.
 	 */
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	while (journal->j_checkpoint_transactions) {
 		transaction_t *transaction;
 		struct journal_head *jh, *last_jh, *next_jh;
@@ -327,15 +326,11 @@ int log_do_checkpoint(journal_t *journal
 			bh = jh2bh(jh);
 			if (!jbd_trylock_bh_state(bh)) {
 				jbd_sync_bh(journal, bh);
-				spin_lock(&journal->j_list_lock);
+				down(&journal->j_list_sem);
 				retry = 1;
 				break;
 			}
 			retry = __flush_buffer(journal, jh, bhs, &batch_count, &drop_count);
-			if (cond_resched_lock(&journal->j_list_lock)) {
-				retry = 1;
-				break;
-			}
 		} while (jh != last_jh && !retry);
 
 		if (batch_count)
@@ -365,7 +360,7 @@ int log_do_checkpoint(journal_t *journal
 		if (journal->j_checkpoint_transactions != transaction)
 			break;
 	}
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 	result = cleanup_journal_tail(journal);
 	if (result < 0)
 		return result;
@@ -404,7 +399,7 @@ int cleanup_journal_tail(journal_t *jour
 	 * start. */
 
 	down(&journal->j_state_sem);
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	transaction = journal->j_checkpoint_transactions;
 	if (transaction) {
 		first_tid = transaction->t_tid;
@@ -419,7 +414,7 @@ int cleanup_journal_tail(journal_t *jour
 		first_tid = journal->j_transaction_sequence;
 		blocknr = journal->j_head;
 	}
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 	J_ASSERT(blocknr != 0);
 
 	/* If the oldest pinned transaction is at the tail of the log
@@ -459,7 +454,7 @@ int cleanup_journal_tail(journal_t *jour
  * Find all the written-back checkpoint buffers in the journal and release them.
  *
  * Called with the journal locked.
- * Called with j_list_lock held.
+ * Called with j_list_sem held.
  * Returns number of bufers reaped (for debug)
  */
 
@@ -519,7 +514,7 @@ out:
  * checkpoint list.  
  *
  * This function is called with the journal locked.
- * This function is called with j_list_lock held.
+ * This function is called with j_list_sem held.
  */
 
 void __journal_remove_checkpoint(struct journal_head *jh)
@@ -573,7 +568,7 @@ out:
  * the log.
  *
  * Called with the journal locked.
- * Called with j_list_lock held.
+ * Called with j_list_sem held.
  */
 void __journal_insert_checkpoint(struct journal_head *jh, 
 			       transaction_t *transaction)
@@ -602,12 +597,11 @@ void __journal_insert_checkpoint(struct 
  * point.
  *
  * Called with the journal locked.
- * Called with j_list_lock held.
+ * Called with j_list_sem held.
  */
 
 void __journal_drop_transaction(journal_t *journal, transaction_t *transaction)
 {
-	assert_spin_locked(&journal->j_list_lock);
 	if (transaction->t_cpnext) {
 		transaction->t_cpnext->t_cpprev = transaction->t_cpprev;
 		transaction->t_cpprev->t_cpnext = transaction->t_cpnext;
--- linux/fs/jbd/transaction.c.orig
+++ linux/fs/jbd/transaction.c
@@ -485,7 +485,7 @@ void journal_unlock_updates (journal_t *
  * continuing as gracefully as possible.  #
  *
  * The caller should already hold the journal lock and
- * j_list_lock spinlock: most callers will need those anyway
+ * j_list_sem mutex: most callers will need those anyway
  * in order to probe the buffer's journaling state safely.
  */
 static void jbd_unexpected_dirty_buffer(struct journal_head *jh)
@@ -694,9 +694,9 @@ repeat:
 		J_ASSERT_JH(jh, !jh->b_next_transaction);
 		jh->b_transaction = transaction;
 		JBUFFER_TRACE(jh, "file as BJ_Reserved");
-		spin_lock(&journal->j_list_lock);
+		down(&journal->j_list_sem);
 		__journal_file_buffer(jh, transaction, BJ_Reserved);
-		spin_unlock(&journal->j_list_lock);
+		up(&journal->j_list_sem);
 	}
 
 done:
@@ -796,7 +796,7 @@ int journal_get_create_access(handle_t *
 	 * reused here.
 	 */
 	jbd_lock_bh_state(bh);
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	J_ASSERT_JH(jh, (jh->b_transaction == transaction ||
 		jh->b_transaction == NULL ||
 		(jh->b_transaction == journal->j_committing_transaction &&
@@ -813,7 +813,7 @@ int journal_get_create_access(handle_t *
 		JBUFFER_TRACE(jh, "set next transaction");
 		jh->b_next_transaction = transaction;
 	}
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 	jbd_unlock_bh_state(bh);
 
 	/*
@@ -962,7 +962,7 @@ int journal_dirty_data(handle_t *handle,
 	 * about it in this layer.
 	 */
 	jbd_lock_bh_state(bh);
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	if (jh->b_transaction) {
 		JBUFFER_TRACE(jh, "has transaction");
 		if (jh->b_transaction != handle->h_transaction) {
@@ -1018,12 +1018,12 @@ int journal_dirty_data(handle_t *handle,
 			 */
 			if (buffer_dirty(bh)) {
 				get_bh(bh);
-				spin_unlock(&journal->j_list_lock);
+				up(&journal->j_list_sem);
 				jbd_unlock_bh_state(bh);
 				need_brelse = 1;
 				sync_dirty_buffer(bh);
 				jbd_lock_bh_state(bh);
-				spin_lock(&journal->j_list_lock);
+				down(&journal->j_list_sem);
 				/* The buffer may become locked again at any
 				   time if it is redirtied */
 			}
@@ -1055,7 +1055,7 @@ int journal_dirty_data(handle_t *handle,
 		__journal_file_buffer(jh, handle->h_transaction, BJ_SyncData);
 	}
 no_journal:
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 	jbd_unlock_bh_state(bh);
 	if (need_brelse) {
 		BUFFER_TRACE(bh, "brelse");
@@ -1145,9 +1145,9 @@ int journal_dirty_metadata(handle_t *han
 	J_ASSERT_JH(jh, jh->b_frozen_data == 0);
 
 	JBUFFER_TRACE(jh, "file as BJ_Metadata");
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	__journal_file_buffer(jh, handle->h_transaction, BJ_Metadata);
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 out_unlock_bh:
 	jbd_unlock_bh_state(bh);
 out:
@@ -1194,7 +1194,7 @@ int journal_forget (handle_t *handle, st
 	BUFFER_TRACE(bh, "entry");
 
 	jbd_lock_bh_state(bh);
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 
 	if (!buffer_jbd(bh))
 		goto not_jbd;
@@ -1246,7 +1246,7 @@ int journal_forget (handle_t *handle, st
 			journal_remove_journal_head(bh);
 			__brelse(bh);
 			if (!buffer_jbd(bh)) {
-				spin_unlock(&journal->j_list_lock);
+				up(&journal->j_list_sem);
 				jbd_unlock_bh_state(bh);
 				__bforget(bh);
 				goto drop;
@@ -1269,7 +1269,7 @@ int journal_forget (handle_t *handle, st
 	}
 
 not_jbd:
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 	jbd_unlock_bh_state(bh);
 	__brelse(bh);
 drop:
@@ -1416,7 +1416,7 @@ int journal_force_commit(journal_t *jour
  * Append a buffer to a transaction list, given the transaction's list head
  * pointer.
  *
- * j_list_lock is held.
+ * j_list_sem is held.
  *
  * jbd_lock_bh_state(jh2bh(jh)) is held.
  */
@@ -1440,7 +1440,7 @@ __blist_add_buffer(struct journal_head *
  * Remove a buffer from a transaction list, given the transaction's list
  * head pointer.
  *
- * Called with j_list_lock held, and the journal may not be locked.
+ * Called with j_list_sem held, and the journal may not be locked.
  *
  * jbd_lock_bh_state(jh2bh(jh)) is held.
  */
@@ -1466,7 +1466,7 @@ __blist_del_buffer(struct journal_head *
  * is holding onto a copy of one of thee pointers, it could go bad.
  * Generally the caller needs to re-read the pointer from the transaction_t.
  *
- * Called under j_list_lock.  The journal may not be locked.
+ * Called under j_list_sem.  The journal may not be locked.
  */
 void __journal_unfile_buffer(struct journal_head *jh)
 {
@@ -1476,8 +1476,6 @@ void __journal_unfile_buffer(struct jour
 
 	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
 	transaction = jh->b_transaction;
-	if (transaction)
-		assert_spin_locked(&transaction->t_journal->j_list_lock);
 
 	J_ASSERT_JH(jh, jh->b_jlist < BJ_Types);
 	if (jh->b_jlist != BJ_None)
@@ -1525,9 +1523,9 @@ out:
 void journal_unfile_buffer(journal_t *journal, struct journal_head *jh)
 {
 	jbd_lock_bh_state(jh2bh(jh));
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	__journal_unfile_buffer(jh);
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 	jbd_unlock_bh_state(jh2bh(jh));
 }
 
@@ -1549,7 +1547,7 @@ __journal_try_to_free_buffer(journal_t *
 	if (jh->b_next_transaction != 0)
 		goto out;
 
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	if (jh->b_transaction != 0 && jh->b_cp_transaction == 0) {
 		if (jh->b_jlist == BJ_SyncData || jh->b_jlist == BJ_Locked) {
 			/* A written-back ordered data buffer */
@@ -1567,7 +1565,7 @@ __journal_try_to_free_buffer(journal_t *
 			__brelse(bh);
 		}
 	}
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 out:
 	return;
 }
@@ -1650,7 +1648,7 @@ busy:
  * release it.
  * Returns non-zero if JBD no longer has an interest in the buffer.
  *
- * Called under j_list_lock.
+ * Called under j_list_sem.
  *
  * Called under jbd_lock_bh_state(bh).
  */
@@ -1731,7 +1729,7 @@ static int journal_unmap_buffer(journal_
 	BUFFER_TRACE(bh, "entry");
 
 	/*
-	 * It is safe to proceed here without the j_list_lock because the
+	 * It is safe to proceed here without the j_list_sem because the
 	 * buffers cannot be stolen by try_to_free_buffers as long as we are
 	 * holding the page lock. --sct
 	 */
@@ -1741,7 +1739,7 @@ static int journal_unmap_buffer(journal_
 
 	down(&journal->j_state_sem);
 	jbd_lock_bh_state(bh);
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 
 	jh = journal_grab_journal_head(bh);
 	if (!jh)
@@ -1774,7 +1772,7 @@ static int journal_unmap_buffer(journal_
 			JBUFFER_TRACE(jh, "checkpointed: add to BJ_Forget");
 			ret = __dispose_buffer(jh,
 					journal->j_running_transaction);
-			spin_unlock(&journal->j_list_lock);
+			up(&journal->j_list_sem);
 			jbd_unlock_bh_state(bh);
 			up(&journal->j_state_sem);
 			journal_put_journal_head(jh);
@@ -1788,7 +1786,7 @@ static int journal_unmap_buffer(journal_
 				JBUFFER_TRACE(jh, "give to committing trans");
 				ret = __dispose_buffer(jh,
 					journal->j_committing_transaction);
-				spin_unlock(&journal->j_list_lock);
+				up(&journal->j_list_sem);
 				jbd_unlock_bh_state(bh);
 				up(&journal->j_state_sem);
 				journal_put_journal_head(jh);
@@ -1812,7 +1810,7 @@ static int journal_unmap_buffer(journal_
 					journal->j_running_transaction);
 			jh->b_next_transaction = NULL;
 		}
-		spin_unlock(&journal->j_list_lock);
+		up(&journal->j_list_sem);
 		jbd_unlock_bh_state(bh);
 		up(&journal->j_state_sem);
 		journal_put_journal_head(jh);
@@ -1831,7 +1829,7 @@ static int journal_unmap_buffer(journal_
 zap_buffer:
 	journal_put_journal_head(jh);
 zap_buffer_no_jh:
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 	jbd_unlock_bh_state(bh);
 	up(&journal->j_state_sem);
 zap_buffer_unlocked:
@@ -1907,8 +1905,6 @@ void __journal_file_buffer(struct journa
 	struct buffer_head *bh = jh2bh(jh);
 
 	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
-	assert_spin_locked(&transaction->t_journal->j_list_lock);
-
 	J_ASSERT_JH(jh, jh->b_jlist < BJ_Types);
 	J_ASSERT_JH(jh, jh->b_transaction == transaction ||
 				jh->b_transaction == 0);
@@ -1974,9 +1970,9 @@ void journal_file_buffer(struct journal_
 				transaction_t *transaction, int jlist)
 {
 	jbd_lock_bh_state(jh2bh(jh));
-	spin_lock(&transaction->t_journal->j_list_lock);
+	down(&transaction->t_journal->j_list_sem);
 	__journal_file_buffer(jh, transaction, jlist);
-	spin_unlock(&transaction->t_journal->j_list_lock);
+	up(&transaction->t_journal->j_list_sem);
 	jbd_unlock_bh_state(jh2bh(jh));
 }
 
@@ -1986,7 +1982,7 @@ void journal_file_buffer(struct journal_
  * already started to be used by a subsequent transaction, refile the
  * buffer on that transaction's metadata list.
  *
- * Called under journal->j_list_lock
+ * Called under journal->j_list_sem
  *
  * Called under jbd_lock_bh_state(jh2bh(jh))
  */
@@ -1996,8 +1992,6 @@ void __journal_refile_buffer(struct jour
 	struct buffer_head *bh = jh2bh(jh);
 
 	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
-	if (jh->b_transaction)
-		assert_spin_locked(&jh->b_transaction->t_journal->j_list_lock);
 
 	/* If the buffer is now unused, just drop it. */
 	if (jh->b_next_transaction == NULL) {
@@ -2040,12 +2034,12 @@ void journal_refile_buffer(journal_t *jo
 	struct buffer_head *bh = jh2bh(jh);
 
 	jbd_lock_bh_state(bh);
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 
 	__journal_refile_buffer(jh);
 	jbd_unlock_bh_state(bh);
 	journal_remove_journal_head(bh);
 
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 	__brelse(bh);
 }
--- linux/fs/jbd/commit.c.orig
+++ linux/fs/jbd/commit.c
@@ -79,14 +79,14 @@ nope:
 }
 
 /*
- * Try to acquire jbd_lock_bh_state() against the buffer, when j_list_lock is
+ * Try to acquire jbd_lock_bh_state() against the buffer, when j_list_sem is
  * held.  For ranking reasons we must trylock.  If we lose, schedule away and
- * return 0.  j_list_lock is dropped in this case.
+ * return 0.  j_list_sem is dropped in this case.
  */
 static int inverted_lock(journal_t *journal, struct buffer_head *bh)
 {
 	if (!jbd_trylock_bh_state(bh)) {
-		spin_unlock(&journal->j_list_lock);
+		up(&journal->j_list_sem);
 		schedule();
 		return 0;
 	}
@@ -189,9 +189,9 @@ void journal_commit_transaction(journal_
 	 */
 
 #ifdef COMMIT_STATS
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	summarise_journal_usage(journal);
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 #endif
 
 	/* Do we need to erase the effects of a prior journal_flush? */
@@ -275,9 +275,9 @@ void journal_commit_transaction(journal_
 	 * checkpoint lists.  We do this *before* commit because it potentially
 	 * frees some memory
 	 */
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	__journal_clean_checkpoint_list(journal);
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 
 	jbd_debug (3, "JBD: commit phase 1\n");
 
@@ -299,7 +299,7 @@ void journal_commit_transaction(journal_
 	 * First, drop modified flag: all accesses to the buffers
 	 * will be tracked for a new trasaction only -bzzz
 	 */
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	if (commit_transaction->t_buffers) {
 		new_jh = jh = commit_transaction->t_buffers->b_tnext;
 		do {
@@ -309,7 +309,7 @@ void journal_commit_transaction(journal_
 			new_jh = new_jh->b_tnext;
 		} while (new_jh != jh);
 	}
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 
 	/*
 	 * Now start flushing things to disk, in the order they appear
@@ -329,7 +329,7 @@ void journal_commit_transaction(journal_
 	 */
 write_out_data:
 	cond_resched();
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 
 	while (commit_transaction->t_sync_datalist) {
 		struct buffer_head *bh;
@@ -345,10 +345,6 @@ write_out_data:
 			__journal_file_buffer(jh, commit_transaction,
 						BJ_Locked);
 			jbd_unlock_bh_state(bh);
-			if (lock_need_resched(&journal->j_list_lock)) {
-				spin_unlock(&journal->j_list_lock);
-				goto write_out_data;
-			}
 		} else {
 			if (buffer_dirty(bh)) {
 				BUFFER_TRACE(bh, "start journal writeout");
@@ -357,7 +353,7 @@ write_out_data:
 				if (bufs == journal->j_wbufsize) {
 					jbd_debug(2, "submit %d writes\n",
 							bufs);
-					spin_unlock(&journal->j_list_lock);
+					up(&journal->j_list_sem);
 					ll_rw_block(WRITE, bufs, wbuf);
 					journal_brelse_array(wbuf, bufs);
 					bufs = 0;
@@ -371,19 +367,15 @@ write_out_data:
 				jbd_unlock_bh_state(bh);
 				journal_remove_journal_head(bh);
 				put_bh(bh);
-				if (lock_need_resched(&journal->j_list_lock)) {
-					spin_unlock(&journal->j_list_lock);
-					goto write_out_data;
-				}
 			}
 		}
 	}
 
 	if (bufs) {
-		spin_unlock(&journal->j_list_lock);
+		up(&journal->j_list_sem);
 		ll_rw_block(WRITE, bufs, wbuf);
 		journal_brelse_array(wbuf, bufs);
-		spin_lock(&journal->j_list_lock);
+		down(&journal->j_list_sem);
 	}
 
 	/*
@@ -396,15 +388,15 @@ write_out_data:
 		bh = jh2bh(jh);
 		get_bh(bh);
 		if (buffer_locked(bh)) {
-			spin_unlock(&journal->j_list_lock);
+			up(&journal->j_list_sem);
 			wait_on_buffer(bh);
 			if (unlikely(!buffer_uptodate(bh)))
 				err = -EIO;
-			spin_lock(&journal->j_list_lock);
+			down(&journal->j_list_sem);
 		}
 		if (!inverted_lock(journal, bh)) {
 			put_bh(bh);
-			spin_lock(&journal->j_list_lock);
+			down(&journal->j_list_sem);
 			continue;
 		}
 		if (buffer_jbd(bh) && jh->b_jlist == BJ_Locked) {
@@ -416,9 +408,8 @@ write_out_data:
 			jbd_unlock_bh_state(bh);
 		}
 		put_bh(bh);
-		cond_resched_lock(&journal->j_list_lock);
 	}
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 
 	if (err)
 		__journal_abort_hard(journal);
@@ -614,7 +605,7 @@ start_journal_io:
 	jbd_debug(3, "JBD: commit phase 4\n");
 
 	/*
-	 * akpm: these are BJ_IO, and j_list_lock is not needed.
+	 * akpm: these are BJ_IO, and j_list_sem is not needed.
 	 * See __journal_try_to_free_buffer.
 	 */
 wait_for_iobuf:
@@ -752,7 +743,7 @@ restart_loop:
 			jh->b_frozen_data = NULL;
 		}
 
-		spin_lock(&journal->j_list_lock);
+		down(&journal->j_list_sem);
 		cp_transaction = jh->b_cp_transaction;
 		if (cp_transaction) {
 			JBUFFER_TRACE(jh, "remove from old cp transaction");
@@ -792,7 +783,7 @@ restart_loop:
 			journal_remove_journal_head(bh);  /* needs a brelse */
 			release_buffer_page(bh);
 		}
-		spin_unlock(&journal->j_list_lock);
+		up(&journal->j_list_sem);
 		if (cond_resched())
 			goto restart_loop;
 	}
@@ -804,13 +795,13 @@ restart_loop:
 	J_ASSERT(commit_transaction->t_state == T_COMMIT);
 
 	/*
-	 * This is a bit sleazy.  We borrow j_list_lock to protect
+	 * This is a bit sleazy.  We borrow j_list_sem to protect
 	 * journal->j_committing_transaction in __journal_remove_checkpoint.
 	 * Really, __jornal_remove_checkpoint should be using j_state_sem but
 	 * it's a bit hassle to hold that across __journal_remove_checkpoint
 	 */
 	down(&journal->j_state_sem);
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	commit_transaction->t_state = T_FINISHED;
 	J_ASSERT(commit_transaction == journal->j_committing_transaction);
 	journal->j_commit_sequence = commit_transaction->t_tid;
@@ -835,7 +826,7 @@ restart_loop:
 				commit_transaction;
 		}
 	}
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 
 	jbd_debug(1, "JBD: commit %d complete, head %d\n",
 		  journal->j_commit_sequence, journal->j_tail_sequence);
--- linux/fs/jbd/journal.c.orig
+++ linux/fs/jbd/journal.c
@@ -672,7 +672,7 @@ static journal_t * journal_init_common (
 	init_MUTEX(&journal->j_barrier);
 	init_MUTEX(&journal->j_checkpoint_sem);
 	spin_lock_init(&journal->j_revoke_lock);
-	spin_lock_init(&journal->j_list_lock);
+	init_MUTEX(&journal->j_list_sem);
 	init_MUTEX(&journal->j_state_sem);
 
 	journal->j_commit_interval = (HZ * JBD_DEFAULT_MAX_COMMIT_AGE);
@@ -1139,17 +1139,17 @@ void journal_destroy(journal_t *journal)
 	/* Force any old transactions to disk */
 
 	/* Totally anal locking here... */
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	while (journal->j_checkpoint_transactions != NULL) {
-		spin_unlock(&journal->j_list_lock);
+		up(&journal->j_list_sem);
 		log_do_checkpoint(journal);
-		spin_lock(&journal->j_list_lock);
+		down(&journal->j_list_sem);
 	}
 
 	J_ASSERT(journal->j_running_transaction == NULL);
 	J_ASSERT(journal->j_committing_transaction == NULL);
 	J_ASSERT(journal->j_checkpoint_transactions == NULL);
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 
 	/* We can now mark the journal as empty. */
 	journal->j_tail = 0;
@@ -1361,13 +1361,13 @@ int journal_flush(journal_t *journal)
 	}
 
 	/* ...and flush everything in the log out to disk. */
-	spin_lock(&journal->j_list_lock);
+	down(&journal->j_list_sem);
 	while (!err && journal->j_checkpoint_transactions != NULL) {
-		spin_unlock(&journal->j_list_lock);
+		up(&journal->j_list_sem);
 		err = log_do_checkpoint(journal);
-		spin_lock(&journal->j_list_lock);
+		down(&journal->j_list_sem);
 	}
-	spin_unlock(&journal->j_list_lock);
+	up(&journal->j_list_sem);
 	cleanup_journal_tail(journal);
 
 	/* Finally, mark the journal as really needing no recovery.
--- linux/include/linux/jbd.h.orig
+++ linux/include/linux/jbd.h
@@ -413,20 +413,20 @@ struct handle_s 
 /*
  * Lock ranking:
  *
- *    j_list_lock
+ *    j_list_sem
  *      ->jbd_lock_bh_journal_head()	(This is "innermost")
  *
  *    j_state_sem
  *    ->jbd_lock_bh_state()
  *
  *    jbd_lock_bh_state()
- *    ->j_list_lock
+ *    ->j_list_sem
  *
  *    j_state_sem
  *    ->t_handle_lock
  *
  *    j_state_sem
- *    ->j_list_lock			(journal_unmap_buffer)
+ *    ->j_list_sem			(journal_unmap_buffer)
  *
  */
 
@@ -458,62 +458,62 @@ struct transaction_s 
 	 */
 	unsigned long		t_log_start;
 
-	/* Number of buffers on the t_buffers list [j_list_lock] */
+	/* Number of buffers on the t_buffers list [j_list_sem] */
 	int			t_nr_buffers;
 
 	/*
 	 * Doubly-linked circular list of all buffers reserved but not yet
-	 * modified by this transaction [j_list_lock]
+	 * modified by this transaction [j_list_sem]
 	 */
 	struct journal_head	*t_reserved_list;
 
 	/*
 	 * Doubly-linked circular list of all buffers under writeout during
-	 * commit [j_list_lock]
+	 * commit [j_list_sem]
 	 */
 	struct journal_head	*t_locked_list;
 
 	/*
 	 * Doubly-linked circular list of all metadata buffers owned by this
-	 * transaction [j_list_lock]
+	 * transaction [j_list_sem]
 	 */
 	struct journal_head	*t_buffers;
 
 	/*
 	 * Doubly-linked circular list of all data buffers still to be
-	 * flushed before this transaction can be committed [j_list_lock]
+	 * flushed before this transaction can be committed [j_list_sem]
 	 */
 	struct journal_head	*t_sync_datalist;
 
 	/*
 	 * Doubly-linked circular list of all forget buffers (superseded
 	 * buffers which we can un-checkpoint once this transaction commits)
-	 * [j_list_lock]
+	 * [j_list_sem]
 	 */
 	struct journal_head	*t_forget;
 
 	/*
 	 * Doubly-linked circular list of all buffers still to be flushed before
-	 * this transaction can be checkpointed. [j_list_lock]
+	 * this transaction can be checkpointed. [j_list_sem]
 	 */
 	struct journal_head	*t_checkpoint_list;
 
 	/*
 	 * Doubly-linked circular list of temporary buffers currently undergoing
-	 * IO in the log [j_list_lock]
+	 * IO in the log [j_list_sem]
 	 */
 	struct journal_head	*t_iobuf_list;
 
 	/*
 	 * Doubly-linked circular list of metadata buffers being shadowed by log
 	 * IO.  The IO buffers on the iobuf list and the shadow buffers on this
-	 * list match each other one for one at all times. [j_list_lock]
+	 * list match each other one for one at all times. [j_list_sem]
 	 */
 	struct journal_head	*t_shadow_list;
 
 	/*
 	 * Doubly-linked circular list of control buffers being written to the
-	 * log. [j_list_lock]
+	 * log. [j_list_sem]
 	 */
 	struct journal_head	*t_log_list;
 
@@ -536,7 +536,7 @@ struct transaction_s 
 
 	/*
 	 * Forward and backward links for the circular list of all transactions
-	 * awaiting checkpoint. [j_list_lock]
+	 * awaiting checkpoint. [j_list_sem]
 	 */
 	transaction_t		*t_cpnext, *t_cpprev;
 
@@ -590,7 +590,7 @@ struct transaction_s 
  * @j_fs_dev: Device which holds the client fs.  For internal journal this will
  *     be equal to j_dev
  * @j_maxlen: Total maximum capacity of the journal region on disk.
- * @j_list_lock: Protects the buffer lists and internal buffer state.
+ * @j_list_sem: Protects the buffer lists and internal buffer state.
  * @j_inode: Optional inode where we store the journal.  If present, all journal
  *     block numbers are mapped into this inode via bmap().
  * @j_tail_sequence:  Sequence number of the oldest transaction in the log 
@@ -658,7 +658,7 @@ struct journal_s
 
 	/*
 	 * ... and a linked circular list of all transactions waiting for
-	 * checkpointing. [j_list_lock]
+	 * checkpointing. [j_list_sem]
 	 */
 	transaction_t		*j_checkpoint_transactions;
 
@@ -731,7 +731,7 @@ struct journal_s
 	/*
 	 * Protects the buffer lists and internal buffer state.
 	 */
-	spinlock_t		j_list_lock;
+	struct semaphore	j_list_sem;
 
 	/* Optional inode where we store the journal.  If present, all */
 	/* journal block numbers are mapped into this inode via */
--- linux/include/linux/journal-head.h.orig
+++ linux/include/linux/journal-head.h
@@ -56,7 +56,7 @@ struct journal_head {
 	 * metadata: either the running transaction or the committing
 	 * transaction (if there is one).  Only applies to buffers on a
 	 * transaction's data or metadata journaling list.
-	 * [j_list_lock] [jbd_lock_bh_state()]
+	 * [j_list_sem] [jbd_lock_bh_state()]
 	 */
 	transaction_t *b_transaction;
 
@@ -77,14 +77,14 @@ struct journal_head {
 	/*
 	 * Pointer to the compound transaction against which this buffer
 	 * is checkpointed.  Only dirty buffers can be checkpointed.
-	 * [j_list_lock]
+	 * [j_list_sem]
 	 */
 	transaction_t *b_cp_transaction;
 
 	/*
 	 * Doubly-linked list of buffers still remaining to be flushed
 	 * before an old transaction can be checkpointed.
-	 * [j_list_lock]
+	 * [j_list_sem]
 	 */
 	struct journal_head *b_cpnext, *b_cpprev;
 };
