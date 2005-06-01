Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVFAIGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVFAIGj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 04:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVFAIGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 04:06:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13544 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261324AbVFAIEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 04:04:00 -0400
Date: Wed, 1 Jun 2005 10:03:57 +0200
From: Jan Kara <jack@ucw.cz>
To: sct@redhat.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Split the checkpoint lists
Message-ID: <20050601080357.GF5933@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IU5/I01NYhRvwH70"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  attached patch (to be applied after my previous two bugfixes) is a new
version of my patch splitting the JBD checkpoint lists into two. In the
first list are buffers yet-to-be-submitted for IO and in the second list
are buffers already submitted for IO. I hoped that this split will make
the list handling simplier but it did not help much as we still have to
deal with the cases where buffers are sent to disk by pdflush or are
linked into a new transaction. We should get some performance gain as we
are now not rescanning the submitted buffers and we don't resubmit them
if someone makes them dirty them before we notice. So I still think it
is a step in the right direction but any ideas for improvement are
welcome. I gave the patch some reasonable beating so I guess it is sound
enough to be put into -mm tree to live there for a while.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.12-rc5-3-checklist.diff"

Split the checkpoint list of the transaction into two lists. In the first list
we keep the buffers that need to be submitted for IO. In the second list are
kept buffers that were already submitted and we just have to wait for the IO
to complete. This should simplify a handling of checkpoint lists a bit and
can eventually be also a performance gain.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-rc5-2-checkskip/fs/jbd/checkpoint.c linux-2.6.12-rc5-3-checklist/fs/jbd/checkpoint.c
--- linux-2.6.12-rc5-2-checkskip/fs/jbd/checkpoint.c	2005-05-27 11:18:08.000000000 +0200
+++ linux-2.6.12-rc5-3-checklist/fs/jbd/checkpoint.c	2005-05-31 18:31:09.000000000 +0200
@@ -24,24 +24,68 @@
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
@@ -117,7 +161,53 @@ static void jbd_sync_bh(journal_t *journ
 }
 
 /*
- * Clean up a transaction's checkpoint list.  
+ * Clean up transaction's list of buffers submitted for io.
+ * We wait for any pending IO to complete and remove any clean
+ * buffers. Note that we take the buffers in the opposite ordering
+ * from the one in which they were submitted for IO.
+ *
+ * Called with j_list_lock held.
+ */
+
+static void __wait_cp_io(journal_t *journal, transaction_t *transaction)
+{
+	struct journal_head *jh, *next_jh, *last_jh;
+	struct buffer_head *bh;
+	tid_t this_tid;
+
+	this_tid = transaction->t_tid;
+restart:
+	/* Didn't somebody cleaned up the transaction in the meanwhile */
+	if (journal->j_checkpoint_transactions != transaction ||
+		transaction->t_tid != this_tid)
+		return;
+	jh = transaction->t_checkpoint_io_list;
+	if (!jh)
+		return;
+	last_jh = jh->b_cpprev;
+	next_jh = jh;
+	do {
+		jh = next_jh;
+		bh = jh2bh(jh);
+		if (buffer_locked(bh)) {
+			atomic_inc(&bh->b_count);
+			spin_unlock(&journal->j_list_lock);
+			wait_on_buffer(bh);
+			/* the journal_head may have gone by now */
+			BUFFER_TRACE(bh, "brelse");
+			__brelse(bh);
+			spin_lock(&journal->j_list_lock);
+			goto restart;
+		}
+		next_jh = jh->b_cpnext;
+		/* Now in whatever state the buffer currently is, we know that
+		 * it has been written out and so we can drop it from the list */
+		__journal_remove_checkpoint(jh);
+	} while (jh != last_jh);
+}
+
+/*
+ * Clean up a transaction's checkpoint lists.
  *
  * We wait for any pending IO to complete and make sure any clean
  * buffers are removed from the transaction. 
@@ -132,7 +222,7 @@ static int __cleanup_transaction(journal
 {
 	struct journal_head *jh, *next_jh, *last_jh;
 	struct buffer_head *bh;
-	int ret = 0;
+	int ret = 0, released = 0;
 
 	assert_spin_locked(&journal->j_list_lock);
 	jh = transaction->t_checkpoint_list;
@@ -180,16 +270,31 @@ static int __cleanup_transaction(journal
 		next_jh = jh->b_cpnext;
 		if (!buffer_dirty(bh) && !buffer_jbddirty(bh)) {
 			BUFFER_TRACE(bh, "remove from checkpoint");
-			__journal_remove_checkpoint(jh);
+			released = __journal_remove_checkpoint(jh);
 			jbd_unlock_bh_state(bh);
 			journal_remove_journal_head(bh);
 			__brelse(bh);
+			/*
+			 * If we released the transaction we should have
+			 * scanned the whole list
+			 */
+			J_ASSERT(!released || jh == last_jh);
 			ret = 1;
 		} else {
 			jbd_unlock_bh_state(bh);
 		}
 	} while (jh != last_jh);
 
+	/*
+	 * If the transaction was not released and we only need to wait
+	 * for the pending IO, do it.
+	 */
+	if (!released && transaction->t_checkpoint_list == NULL &&
+	    transaction->t_checkpoint_io_list != NULL) {
+		ret = 1;
+		__wait_cp_io(journal, transaction);
+	}
+
 	return ret;
 out_return_1:
 	spin_lock(&journal->j_list_lock);
@@ -246,6 +351,7 @@ static int __flush_buffer(journal_t *jou
 		J_ASSERT_BH(bh, !buffer_jwrite(bh));
 		set_buffer_jwrite(bh);
 		bhs[*batch_count] = bh;
+		__buffer_relink_io(jh);
 		jbd_unlock_bh_state(bh);
 		(*batch_count)++;
 		if (*batch_count == NR_BATCH) {
@@ -456,13 +562,52 @@ int cleanup_journal_tail(journal_t *jour
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
+static int journal_clean_one_cp_list(struct journal_head *jh)
+{
+	struct journal_head *last_jh;
+	struct journal_head *next_jh = jh;
+	int ret = 0;
+
+	if (!jh)
+		return 0;
+
+ 	last_jh = jh->b_cpprev;
+	do {
+		jh = next_jh;
+		next_jh = jh->b_cpnext;
+		/* Use trylock because of the ranking */
+		if (jbd_trylock_bh_state(jh2bh(jh)))
+			ret += __try_to_free_cp_buf(jh);
+		/*
+		 * This function only frees up some memory
+		 * if possible so we dont have an obligation
+		 * to finish processing. Bail out if preemption
+		 * requested:
+		 */
+		if (need_resched())
+			return ret;
+	} while (jh != last_jh);
+
+	return ret;
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
@@ -477,31 +622,20 @@ int __journal_clean_checkpoint_list(jour
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
+				t_checkpoint_list);
+		if (need_resched())
+			goto out;
+		/* It is essential that we are as careful as in the case of
+		   t_checkpoint_list with removing the buffer from the list
+		   as we can possibly see not yet submitted buffers on
+		   io_list */
+		ret += journal_clean_one_cp_list(transaction->
+				t_checkpoint_io_list);
+		if (need_resched())
+			goto out;
 	} while (transaction != last_transaction);
 out:
 	return ret;
@@ -516,18 +650,22 @@ out:
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
 
@@ -538,8 +676,10 @@ void __journal_remove_checkpoint(struct 
 	journal = transaction->t_journal;
 
 	__buffer_unlink(jh);
+	jh->b_cp_transaction = NULL;
 
-	if (transaction->t_checkpoint_list != NULL)
+	if (transaction->t_checkpoint_list != NULL ||
+	    transaction->t_checkpoint_io_list != NULL)
 		goto out;
 	JBUFFER_TRACE(jh, "transaction has no more buffers");
 
@@ -565,8 +705,10 @@ void __journal_remove_checkpoint(struct 
 	/* Just in case anybody was waiting for more transactions to be
            checkpointed... */
 	wake_up(&journal->j_wait_logspace);
+	ret = 1;
 out:
 	JBUFFER_TRACE(jh, "exit");
+	return ret;
 }
 
 /*
@@ -628,6 +770,7 @@ void __journal_drop_transaction(journal_
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

--IU5/I01NYhRvwH70--
