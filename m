Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbTGDRVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 13:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbTGDRVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 13:21:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:8652 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265291AbTGDRVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 13:21:00 -0400
Date: Fri, 4 Jul 2003 10:36:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       bzzz@tmi.comex.ru
Subject: Re: minor JBD tunings
Message-Id: <20030704103609.67dc4650.akpm@osdl.org>
In-Reply-To: <87d6gqp196.fsf@gw.home.net>
References: <87d6gqp196.fsf@gw.home.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> I'm trying to improve JBD performance.

Not a bad thing to be doing ;)

I made quite a few changes, mainly removing some unused function args.

This code in log_do_checkpoint() confuses me:

		transaction = journal->j_checkpoint_transactions;
		while (transaction->t_tid <= start_tid) {
			transaction = transaction->t_cpnext;
			if (transaction == journal->j_checkpoint_transactions)
				goto finish;
		}

what are you actually searching for here?  What is the intent?

If seems to be saying "I want to find the oldest transaction to checkpoint,
but I refuse to checkpoint the most recently checkpointed transaction",
yes?

If so, then it could be simplified to:

	transaction = journal->j_checkpoint_transactions->t_cpprev;

could it not?

You'll never actually wrap around to the most-recently-checkpointed
transaction in here because that would mean that there is only a single
checkpoint transaction.  And when there's only a single checkpointed
transaction this function will never be called, because there is sufficient
log space.

Unless someone diddles with the journal parameters to make the max
transaction size larger than journal_size/4.  So to be robust in the
presence of such a change, we shouldn't make any explicit provision to
avoid checkpointing the trasnaction at journal->j_checkpoint_transactions.

So I think the above line is sufficient.

Some other possible improvements to the checkpointing code would be:

- Get some async writeout underway before we actually run out of journal
  space.

- Don't wait on each transaction individually: schedule enough IO to
  reclaim sufficient log space and then wait on all those transactions.


errr, what's going on here?  __flush_buffer() unconditionally does

	*freed = 1;

so log_do_checkpoint() will _always_ break out of the loop, without having
waited on any I/O.  log_do_checkpoint() returns to caller, caller calls
log_do_checkpoint() again, we walk over the same transaction again, not
scheduling any new I/O.  Look like it'll all turn into a busy loop?



 fs/jbd/checkpoint.c  |   62 ++++++++++++++++++++++++++++++++++++---------------
 fs/jbd/journal.c     |    4 +--
 fs/jbd/transaction.c |    2 -
 include/linux/jbd.h  |    4 +--
 4 files changed, 49 insertions(+), 23 deletions(-)

diff -puN fs/jbd/checkpoint.c~jbd-commit-tricks fs/jbd/checkpoint.c
--- 25/fs/jbd/checkpoint.c~jbd-commit-tricks	2003-07-04 10:08:22.000000000 -0700
+++ 25-akpm/fs/jbd/checkpoint.c	2003-07-04 10:08:22.000000000 -0700
@@ -72,14 +72,19 @@ static int __try_to_free_cp_buf(struct j
 /*
  * __log_wait_for_space: wait until there is space in the journal.
  *
- * Called under j-state_lock *only*.  It will be unlocked if we have to wait
+ * Called under j_state_lock *only*.  It will be unlocked if we have to wait
  * for a checkpoint to free up some space in the log.
  */
-
-void __log_wait_for_space(journal_t *journal, int nblocks)
+void __log_wait_for_space(journal_t *journal)
 {
+	int nblocks;
+
 	assert_spin_locked(&journal->j_state_lock);
 
+	nblocks = journal->j_max_transaction_buffers;
+	if (journal->j_committing_transaction)
+		nblocks += journal->j_committing_transaction->
+					t_outstanding_credits;
 	while (__log_space_left(journal) < nblocks) {
 		if (journal->j_flags & JFS_ABORT)
 			return;
@@ -91,9 +96,13 @@ void __log_wait_for_space(journal_t *jou
 		 * were waiting for the checkpoint lock
 		 */
 		spin_lock(&journal->j_state_lock);
+		nblocks = journal->j_max_transaction_buffers;
+		if (journal->j_committing_transaction)
+			nblocks += journal->j_committing_transaction->
+				t_outstanding_credits;
 		if (__log_space_left(journal) < nblocks) {
 			spin_unlock(&journal->j_state_lock);
-			log_do_checkpoint(journal, nblocks);
+			log_do_checkpoint(journal);
 			spin_lock(&journal->j_state_lock);
 		}
 		up(&journal->j_checkpoint_sem);
@@ -222,14 +231,17 @@ __flush_batch(journal_t *journal, struct
  *
  * Called with j_list_lock held.
  * Called under jbd_lock_bh_state(jh2bh(jh)), and drops it
+ * Sets *freed true if the transaction was dropped.
  */
 static int __flush_buffer(journal_t *journal, struct journal_head *jh,
 			struct buffer_head **bhs, int *batch_count,
-			int *drop_count)
+			int *drop_count, int *freed)
 {
 	struct buffer_head *bh = jh2bh(jh);
 	int ret = 0;
 
+	*freed = 1;
+
 	if (buffer_dirty(bh) && !buffer_locked(bh) && jh->b_jlist == BJ_None) {
 		J_ASSERT_JH(jh, jh->b_transaction == NULL);
 
@@ -262,6 +274,8 @@ static int __flush_buffer(journal_t *jou
 		if (__try_to_free_cp_buf(jh)) {
 			(*drop_count)++;
 			ret = last_buffer;
+			if (last_buffer)
+				*freed = 1;
 		}
 	}
 	return ret;
@@ -280,12 +294,12 @@ static int __flush_buffer(journal_t *jou
  * The journal should be locked before calling this function.
  */
 
-/* @@@ `nblocks' is unused.  Should it be used? */
-int log_do_checkpoint(journal_t *journal, int nblocks)
+int log_do_checkpoint(journal_t *journal)
 {
 	int result;
 	int batch_count = 0;
 	struct buffer_head *bhs[NR_BATCH];
+	int start_tid;
 
 	jbd_debug(1, "Start checkpoint\n");
 
@@ -308,14 +322,23 @@ int log_do_checkpoint(journal_t *journal
 	 * degenerates into a busy loop at unmount time.
 	 */
 	spin_lock(&journal->j_list_lock);
+	if (journal->j_checkpoint_transactions)
+		start_tid = journal->j_checkpoint_transactions->t_tid - 1;
 	while (journal->j_checkpoint_transactions) {
 		transaction_t *transaction;
 		struct journal_head *jh, *last_jh, *next_jh;
 		int drop_count = 0;
 		int cleanup_ret, retry = 0;
 		tid_t this_tid;
+		int freed = 0;
 
-		transaction = journal->j_checkpoint_transactions->t_cpnext;
+		transaction = journal->j_checkpoint_transactions;
+		while (transaction->t_tid <= start_tid) {
+			transaction = transaction->t_cpnext;
+			if (transaction == journal->j_checkpoint_transactions)
+				goto finish;
+		}
+		start_tid = transaction->t_tid;
 		this_tid = transaction->t_tid;
 		jh = transaction->t_checkpoint_list;
 		last_jh = jh->b_cpprev;
@@ -333,14 +356,22 @@ int log_do_checkpoint(journal_t *journal
 				break;
 			}
 			retry = __flush_buffer(journal, jh, bhs, &batch_count,
-						&drop_count);
+						&drop_count, &freed);
 		} while (jh != last_jh && !retry);
-		if (batch_count) {
+
+		if (batch_count)
 			__flush_batch(journal, bhs, &batch_count);
+		/*
+		 * transaction was freed, so we return to check whether
+		 * sufficient log space was made available.
+		 */
+		if (freed)
+			break;
+
+		if (retry) {
+			start_tid--;
 			continue;
 		}
-		if (retry)
-			continue;
 
 		/*
 		 * If someone emptied the checkpoint list while we slept, we're
@@ -349,12 +380,6 @@ int log_do_checkpoint(journal_t *journal
 		if (!journal->j_checkpoint_transactions)
 			break;
 		/*
-		 * If someone cleaned up this transaction while we slept, we're
-		 * done
-		 */
-		if (journal->j_checkpoint_transactions->t_cpnext != transaction)
-			continue;
-		/*
 		 * Maybe it's a new transaction, but it fell at the same
 		 * address
 		 */
@@ -368,6 +393,7 @@ int log_do_checkpoint(journal_t *journal
 		cleanup_ret = __cleanup_transaction(journal, transaction);
 		J_ASSERT(drop_count != 0 || cleanup_ret != 0);
 	}
+finish:
 	spin_unlock(&journal->j_list_lock);
 	result = cleanup_journal_tail(journal);
 	if (result < 0)
diff -puN fs/jbd/transaction.c~jbd-commit-tricks fs/jbd/transaction.c
--- 25/fs/jbd/transaction.c~jbd-commit-tricks	2003-07-04 10:08:22.000000000 -0700
+++ 25-akpm/fs/jbd/transaction.c	2003-07-04 10:08:22.000000000 -0700
@@ -214,7 +214,7 @@ repeat_locked:
 	if (__log_space_left(journal) < needed) {
 		jbd_debug(2, "Handle %p waiting for checkpoint...\n", handle);
 		spin_unlock(&transaction->t_handle_lock);
-		__log_wait_for_space(journal, needed);
+		__log_wait_for_space(journal);
 		goto repeat_locked;
 	}
 
diff -puN fs/jbd/journal.c~jbd-commit-tricks fs/jbd/journal.c
--- 25/fs/jbd/journal.c~jbd-commit-tricks	2003-07-04 10:08:22.000000000 -0700
+++ 25-akpm/fs/jbd/journal.c	2003-07-04 10:08:22.000000000 -0700
@@ -1076,7 +1076,7 @@ void journal_destroy(journal_t *journal)
 	spin_lock(&journal->j_list_lock);
 	while (journal->j_checkpoint_transactions != NULL) {
 		spin_unlock(&journal->j_list_lock);
-		log_do_checkpoint(journal, 1);
+		log_do_checkpoint(journal);
 		spin_lock(&journal->j_list_lock);
 	}
 
@@ -1284,7 +1284,7 @@ int journal_flush(journal_t *journal)
 	spin_lock(&journal->j_list_lock);
 	while (!err && journal->j_checkpoint_transactions != NULL) {
 		spin_unlock(&journal->j_list_lock);
-		err = log_do_checkpoint(journal, journal->j_maxlen);
+		err = log_do_checkpoint(journal);
 		spin_lock(&journal->j_list_lock);
 	}
 	spin_unlock(&journal->j_list_lock);
diff -puN include/linux/jbd.h~jbd-commit-tricks include/linux/jbd.h
--- 25/include/linux/jbd.h~jbd-commit-tricks	2003-07-04 10:08:22.000000000 -0700
+++ 25-akpm/include/linux/jbd.h	2003-07-04 10:08:22.000000000 -0700
@@ -992,9 +992,9 @@ int log_start_commit(journal_t *journal,
 int __log_start_commit(journal_t *journal, tid_t tid);
 int journal_start_commit(journal_t *journal, tid_t *tid);
 int log_wait_commit(journal_t *journal, tid_t tid);
-int log_do_checkpoint(journal_t *journal, int nblocks);
+int log_do_checkpoint(journal_t *journal);
 
-void __log_wait_for_space(journal_t *journal, int nblocks);
+void __log_wait_for_space(journal_t *journal);
 extern void	__journal_drop_transaction(journal_t *, transaction_t *);
 extern int	cleanup_journal_tail(journal_t *);
 

_

