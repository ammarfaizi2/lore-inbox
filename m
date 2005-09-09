Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbVIIIwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVIIIwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbVIIIwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:52:23 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:47789 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S965103AbVIIIwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:52:19 -0400
Date: Fri, 9 Sep 2005 17:48:51 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com,
       ext3-users@redhat.com
Subject: [-mm PATCH 5/6] jbd: use list_head for the list of all transactions waiting for
Message-ID: <20050909084851.GG14205@miraclelinux.com>
References: <20050909084214.GB14205@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909084214.GB14205@miraclelinux.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

use struct list_head for a linked circular list of all transactions
waiting for checkpointing on a journal control structure.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

---

 fs/jbd/checkpoint.c  |   48 ++++++++++++++++++++----------------------------
 fs/jbd/commit.c      |   16 ++--------------
 fs/jbd/journal.c     |    9 +++++----
 fs/jbd/transaction.c |    1 +
 include/linux/jbd.h  |    4 ++--
 5 files changed, 30 insertions(+), 48 deletions(-)

diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/fs/jbd/checkpoint.c 2.6.13-mm1/fs/jbd/checkpoint.c
--- 2.6.13-mm1.old/fs/jbd/checkpoint.c	2005-09-04 23:31:48.000000000 +0900
+++ 2.6.13-mm1/fs/jbd/checkpoint.c	2005-09-05 00:23:28.000000000 +0900
@@ -180,8 +180,10 @@ static void __wait_cp_io(journal_t *jour
 	this_tid = transaction->t_tid;
 restart:
 	/* Didn't somebody clean up the transaction in the meanwhile */
-	if (journal->j_checkpoint_transactions != transaction ||
-		transaction->t_tid != this_tid)
+	if (list_empty(&journal->j_checkpoint_transactions) ||
+	    list_entry(journal->j_checkpoint_transactions.next, transaction_t,
+			t_cplist) != transaction ||
+	    transaction->t_tid != this_tid)
 		return;
 	while (!released && transaction->t_checkpoint_io_list) {
 		jh = transaction->t_checkpoint_io_list;
@@ -328,9 +330,10 @@ int log_do_checkpoint(journal_t *journal
 	 * and write it.
 	 */
 	spin_lock(&journal->j_list_lock);
-	if (!journal->j_checkpoint_transactions)
+	if (list_empty(&journal->j_checkpoint_transactions))
 		goto out;
-	transaction = journal->j_checkpoint_transactions;
+	transaction = list_entry(journal->j_checkpoint_transactions.next,
+				 transaction_t, t_cplist);
 	this_tid = transaction->t_tid;
 restart:
 	/*
@@ -338,8 +341,10 @@ restart:
 	 * done (maybe it's a new transaction, but it fell at the same
 	 * address).
 	 */
- 	if (journal->j_checkpoint_transactions == transaction ||
-			transaction->t_tid == this_tid) {
+ 	if ((!list_empty(&journal->j_checkpoint_transactions) &&
+	     list_entry(journal->j_checkpoint_transactions.next,
+			transaction_t, t_cplist) == transaction) ||
+	      transaction->t_tid == this_tid) {
 		int batch_count = 0;
 		struct buffer_head *bhs[NR_BATCH];
 		struct journal_head *jh;
@@ -410,7 +415,7 @@ out:
 
 int cleanup_journal_tail(journal_t *journal)
 {
-	transaction_t * transaction;
+	transaction_t * transaction = NULL;
 	tid_t		first_tid;
 	unsigned long	blocknr, freed;
 
@@ -423,7 +428,9 @@ int cleanup_journal_tail(journal_t *jour
 
 	spin_lock(&journal->j_state_lock);
 	spin_lock(&journal->j_list_lock);
-	transaction = journal->j_checkpoint_transactions;
+	if (!list_empty(&journal->j_checkpoint_transactions))
+		transaction = list_entry(journal->j_checkpoint_transactions.next,
+					 transaction_t, t_cplist);
 	if (transaction) {
 		first_tid = transaction->t_tid;
 		blocknr = transaction->t_log_start;
@@ -530,18 +537,11 @@ static int journal_clean_one_cp_list(str
 
 int __journal_clean_checkpoint_list(journal_t *journal)
 {
-	transaction_t *transaction, *last_transaction, *next_transaction;
+	transaction_t *transaction, *next_transaction;
 	int ret = 0, released;
 
-	transaction = journal->j_checkpoint_transactions;
-	if (!transaction)
-		goto out;
-
-	last_transaction = transaction->t_cpprev;
-	next_transaction = transaction;
-	do {
-		transaction = next_transaction;
-		next_transaction = transaction->t_cpnext;
+	list_for_each_entry_safe(transaction, next_transaction,
+				&journal->j_checkpoint_transactions, t_cplist) {
 		ret += journal_clean_one_cp_list(transaction->
 				t_checkpoint_list, &released);
 		if (need_resched())
@@ -557,7 +557,7 @@ int __journal_clean_checkpoint_list(jour
 				t_checkpoint_io_list, &released);
 		if (need_resched())
 			goto out;
-	} while (transaction != last_transaction);
+	}
 out:
 	return ret;
 }
@@ -673,15 +673,7 @@ void __journal_insert_checkpoint(struct 
 void __journal_drop_transaction(journal_t *journal, transaction_t *transaction)
 {
 	assert_spin_locked(&journal->j_list_lock);
-	if (transaction->t_cpnext) {
-		transaction->t_cpnext->t_cpprev = transaction->t_cpprev;
-		transaction->t_cpprev->t_cpnext = transaction->t_cpnext;
-		if (journal->j_checkpoint_transactions == transaction)
-			journal->j_checkpoint_transactions =
-				transaction->t_cpnext;
-		if (journal->j_checkpoint_transactions == transaction)
-			journal->j_checkpoint_transactions = NULL;
-	}
+	list_del(&transaction->t_cplist);
 
 	J_ASSERT(transaction->t_state == T_FINISHED);
 	J_ASSERT(list_empty(&transaction->t_metadata_list));
diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/fs/jbd/commit.c 2.6.13-mm1/fs/jbd/commit.c
--- 2.6.13-mm1.old/fs/jbd/commit.c	2005-09-04 23:31:48.000000000 +0900
+++ 2.6.13-mm1/fs/jbd/commit.c	2005-09-04 23:41:01.000000000 +0900
@@ -835,20 +835,8 @@ restart_loop:
 	if (commit_transaction->t_checkpoint_list == NULL) {
 		__journal_drop_transaction(journal, commit_transaction);
 	} else {
-		if (journal->j_checkpoint_transactions == NULL) {
-			journal->j_checkpoint_transactions = commit_transaction;
-			commit_transaction->t_cpnext = commit_transaction;
-			commit_transaction->t_cpprev = commit_transaction;
-		} else {
-			commit_transaction->t_cpnext =
-				journal->j_checkpoint_transactions;
-			commit_transaction->t_cpprev =
-				commit_transaction->t_cpnext->t_cpprev;
-			commit_transaction->t_cpnext->t_cpprev =
-				commit_transaction;
-			commit_transaction->t_cpprev->t_cpnext =
-				commit_transaction;
-		}
+		list_add_tail(&commit_transaction->t_cplist,
+			 &journal->j_checkpoint_transactions);
 	}
 	spin_unlock(&journal->j_list_lock);
 
diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/fs/jbd/journal.c 2.6.13-mm1/fs/jbd/journal.c
--- 2.6.13-mm1.old/fs/jbd/journal.c	2005-09-04 23:31:48.000000000 +0900
+++ 2.6.13-mm1/fs/jbd/journal.c	2005-09-04 23:33:19.000000000 +0900
@@ -653,6 +653,7 @@ static journal_t * journal_init_common (
 		goto fail;
 	memset(journal, 0, sizeof(*journal));
 
+	INIT_LIST_HEAD(&journal->j_checkpoint_transactions);
 	init_waitqueue_head(&journal->j_wait_transaction_locked);
 	init_waitqueue_head(&journal->j_wait_logspace);
 	init_waitqueue_head(&journal->j_wait_done_commit);
@@ -1130,7 +1131,7 @@ void journal_destroy(journal_t *journal)
 
 	/* Totally anal locking here... */
 	spin_lock(&journal->j_list_lock);
-	while (journal->j_checkpoint_transactions != NULL) {
+	while (!list_empty(&journal->j_checkpoint_transactions)) {
 		spin_unlock(&journal->j_list_lock);
 		log_do_checkpoint(journal);
 		spin_lock(&journal->j_list_lock);
@@ -1138,7 +1139,7 @@ void journal_destroy(journal_t *journal)
 
 	J_ASSERT(journal->j_running_transaction == NULL);
 	J_ASSERT(journal->j_committing_transaction == NULL);
-	J_ASSERT(journal->j_checkpoint_transactions == NULL);
+	J_ASSERT(list_empty(&journal->j_checkpoint_transactions));
 	spin_unlock(&journal->j_list_lock);
 
 	/* We can now mark the journal as empty. */
@@ -1352,7 +1353,7 @@ int journal_flush(journal_t *journal)
 
 	/* ...and flush everything in the log out to disk. */
 	spin_lock(&journal->j_list_lock);
-	while (!err && journal->j_checkpoint_transactions != NULL) {
+	while (!err && !list_empty(&journal->j_checkpoint_transactions)) {
 		spin_unlock(&journal->j_list_lock);
 		err = log_do_checkpoint(journal);
 		spin_lock(&journal->j_list_lock);
@@ -1375,7 +1376,7 @@ int journal_flush(journal_t *journal)
 
 	J_ASSERT(!journal->j_running_transaction);
 	J_ASSERT(!journal->j_committing_transaction);
-	J_ASSERT(!journal->j_checkpoint_transactions);
+	J_ASSERT(list_empty(&journal->j_checkpoint_transactions));
 	J_ASSERT(journal->j_head == journal->j_tail);
 	J_ASSERT(journal->j_tail_sequence == journal->j_transaction_sequence);
 	spin_unlock(&journal->j_state_lock);
diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/fs/jbd/transaction.c 2.6.13-mm1/fs/jbd/transaction.c
--- 2.6.13-mm1.old/fs/jbd/transaction.c	2005-09-04 23:31:47.000000000 +0900
+++ 2.6.13-mm1/fs/jbd/transaction.c	2005-09-04 23:33:19.000000000 +0900
@@ -59,6 +59,7 @@ get_transaction(journal_t *journal, tran
 	INIT_LIST_HEAD(&transaction->t_io_list);
 	INIT_LIST_HEAD(&transaction->t_shadow_list);
 	INIT_LIST_HEAD(&transaction->t_logctl_list);
+	INIT_LIST_HEAD(&transaction->t_cplist);
 
 	/* Set up the commit timer for the new transaction. */
 	journal->j_commit_timer->expires = transaction->t_expires;
diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/include/linux/jbd.h 2.6.13-mm1/include/linux/jbd.h
--- 2.6.13-mm1.old/include/linux/jbd.h	2005-09-04 23:32:35.000000000 +0900
+++ 2.6.13-mm1/include/linux/jbd.h	2005-09-04 23:33:15.000000000 +0900
@@ -545,7 +545,7 @@ struct transaction_s 
 	 * Forward and backward links for the circular list of all transactions
 	 * awaiting checkpoint. [j_list_lock]
 	 */
-	transaction_t		*t_cpnext, *t_cpprev;
+	struct list_head	t_cplist;
 
 	/*
 	 * When will the transaction expire (become due for commit), in jiffies?
@@ -667,7 +667,7 @@ struct journal_s
 	 * ... and a linked circular list of all transactions waiting for
 	 * checkpointing. [j_list_lock]
 	 */
-	transaction_t		*j_checkpoint_transactions;
+	struct list_head	j_checkpoint_transactions;
 
 	/*
 	 * Wait queue for waiting for a locked transaction to start committing,
