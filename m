Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbVIIIxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbVIIIxi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbVIIIxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:53:37 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:61101 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S965106AbVIIIxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:53:36 -0400
Date: Fri, 9 Sep 2005 17:50:07 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com,
       ext3-users@redhat.com
Subject: [-mm PATCH 6/6] jbd: use list_head for a transaction checkpoint list
Message-ID: <20050909085007.GH14205@miraclelinux.com>
References: <20050909084214.GB14205@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909084214.GB14205@miraclelinux.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

use struct list_head for doubly-linked list of buffers still remaining to be
flushed before an old transaction can be checkpointed.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

---

 fs/jbd/checkpoint.c          |  119 +++++++------------------------------------
 fs/jbd/commit.c              |    4 -
 fs/jbd/journal.c             |    1 
 fs/jbd/transaction.c         |    2 
 include/linux/jbd.h          |    4 -
 include/linux/journal-head.h |    2 
 6 files changed, 30 insertions(+), 102 deletions(-)

diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/fs/jbd/checkpoint.c 2.6.13-mm1/fs/jbd/checkpoint.c
--- 2.6.13-mm1.old/fs/jbd/checkpoint.c	2005-09-05 03:21:20.000000000 +0900
+++ 2.6.13-mm1/fs/jbd/checkpoint.c	2005-09-05 03:21:33.000000000 +0900
@@ -22,71 +22,7 @@
 #include <linux/jbd.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
-
-/*
- * Unlink a buffer from a transaction checkpoint list.
- *
- * Called with j_list_lock held.
- */
-
-static void __buffer_unlink_first(struct journal_head *jh)
-{
-	transaction_t *transaction;
-
-	transaction = jh->b_cp_transaction;
-
-	jh->b_cpnext->b_cpprev = jh->b_cpprev;
-	jh->b_cpprev->b_cpnext = jh->b_cpnext;
-	if (transaction->t_checkpoint_list == jh) {
-		transaction->t_checkpoint_list = jh->b_cpnext;
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
-}
+#include <linux/list.h>
 
 /*
  * Try to release a checkpointed buffer from its transaction.
@@ -185,8 +121,9 @@ restart:
 			t_cplist) != transaction ||
 	    transaction->t_tid != this_tid)
 		return;
-	while (!released && transaction->t_checkpoint_io_list) {
-		jh = transaction->t_checkpoint_io_list;
+	while (!released && !list_empty(&transaction->t_checkpoint_io_list)) {
+		jh = list_entry(transaction->t_checkpoint_io_list.next,
+				struct journal_head, b_cplist);
 		bh = jh2bh(jh);
 		if (!jbd_trylock_bh_state(bh)) {
 			jbd_sync_bh(journal, bh);
@@ -288,7 +225,9 @@ static int __process_buffer(journal_t *j
 		J_ASSERT_BH(bh, !buffer_jwrite(bh));
 		set_buffer_jwrite(bh);
 		bhs[*batch_count] = bh;
-		__buffer_relink_io(jh);
+		list_del(&jh->b_cplist);
+		list_add(&jh->b_cplist,
+			 &jh->b_cp_transaction->t_checkpoint_io_list);
 		jbd_unlock_bh_state(bh);
 		(*batch_count)++;
 		if (*batch_count == NR_BATCH) {
@@ -350,10 +289,11 @@ restart:
 		struct journal_head *jh;
 		int retry = 0;
 
-		while (!retry && transaction->t_checkpoint_list) {
+		while (!retry && !list_empty(&transaction->t_checkpoint_list)) {
 			struct buffer_head *bh;
 
-			jh = transaction->t_checkpoint_list;
+			jh = list_entry(transaction->t_checkpoint_list.next,
+					struct journal_head, b_cplist);
 			bh = jh2bh(jh);
 			if (!jbd_trylock_bh_state(bh)) {
 				jbd_sync_bh(journal, bh);
@@ -488,20 +428,14 @@ int cleanup_journal_tail(journal_t *jour
  * Returns number of bufers reaped (for debug)
  */
 
-static int journal_clean_one_cp_list(struct journal_head *jh, int *released)
+static int journal_clean_one_cp_list(struct list_head *head, int *released)
 {
-	struct journal_head *last_jh;
-	struct journal_head *next_jh = jh;
+	struct journal_head *jh, *next_jh;
 	int ret, freed = 0;
 
 	*released = 0;
-	if (!jh)
-		return 0;
 
- 	last_jh = jh->b_cpprev;
-	do {
-		jh = next_jh;
-		next_jh = jh->b_cpnext;
+	list_for_each_entry_safe(jh, next_jh, head, b_cplist) {
 		/* Use trylock because of the ranking */
 		if (jbd_trylock_bh_state(jh2bh(jh))) {
 			ret = __try_to_free_cp_buf(jh);
@@ -520,7 +454,7 @@ static int journal_clean_one_cp_list(str
 		 */
 		if (need_resched())
 			return freed;
-	} while (jh != last_jh);
+	}
 
 	return freed;
 }
@@ -542,7 +476,7 @@ int __journal_clean_checkpoint_list(jour
 
 	list_for_each_entry_safe(transaction, next_transaction,
 				&journal->j_checkpoint_transactions, t_cplist) {
-		ret += journal_clean_one_cp_list(transaction->
+		ret += journal_clean_one_cp_list(&transaction->
 				t_checkpoint_list, &released);
 		if (need_resched())
 			goto out;
@@ -553,7 +487,7 @@ int __journal_clean_checkpoint_list(jour
 		 * t_checkpoint_list with removing the buffer from the list as
 		 * we can possibly see not yet submitted buffers on io_list
 		 */
-		ret += journal_clean_one_cp_list(transaction->
+		ret += journal_clean_one_cp_list(&transaction->
 				t_checkpoint_io_list, &released);
 		if (need_resched())
 			goto out;
@@ -596,11 +530,11 @@ int __journal_remove_checkpoint(struct j
 	}
 	journal = transaction->t_journal;
 
-	__buffer_unlink(jh);
+	list_del(&jh->b_cplist);
 	jh->b_cp_transaction = NULL;
 
-	if (transaction->t_checkpoint_list != NULL ||
-	    transaction->t_checkpoint_io_list != NULL)
+	if (!list_empty(&transaction->t_checkpoint_list) ||
+	    !list_empty(&transaction->t_checkpoint_io_list))
 		goto out;
 	JBUFFER_TRACE(jh, "transaction has no more buffers");
 
@@ -648,16 +582,7 @@ void __journal_insert_checkpoint(struct 
 	J_ASSERT_JH(jh, jh->b_cp_transaction == NULL);
 
 	jh->b_cp_transaction = transaction;
-
-	if (!transaction->t_checkpoint_list) {
-		jh->b_cpnext = jh->b_cpprev = jh;
-	} else {
-		jh->b_cpnext = transaction->t_checkpoint_list;
-		jh->b_cpprev = transaction->t_checkpoint_list->b_cpprev;
-		jh->b_cpprev->b_cpnext = jh;
-		jh->b_cpnext->b_cpprev = jh;
-	}
-	transaction->t_checkpoint_list = jh;
+	list_add(&jh->b_cplist, &transaction->t_checkpoint_list);
 }
 
 /*
@@ -682,8 +607,8 @@ void __journal_drop_transaction(journal_
 	J_ASSERT(list_empty(&transaction->t_io_list));
 	J_ASSERT(list_empty(&transaction->t_shadow_list));
 	J_ASSERT(list_empty(&transaction->t_logctl_list));
-	J_ASSERT(transaction->t_checkpoint_list == NULL);
-	J_ASSERT(transaction->t_checkpoint_io_list == NULL);
+	J_ASSERT(list_empty(&transaction->t_checkpoint_list));
+	J_ASSERT(list_empty(&transaction->t_checkpoint_io_list));
 	J_ASSERT(transaction->t_updates == 0);
 	J_ASSERT(journal->j_committing_transaction != transaction);
 	J_ASSERT(journal->j_running_transaction != transaction);
diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/fs/jbd/commit.c 2.6.13-mm1/fs/jbd/commit.c
--- 2.6.13-mm1.old/fs/jbd/commit.c	2005-09-05 03:21:20.000000000 +0900
+++ 2.6.13-mm1/fs/jbd/commit.c	2005-09-05 03:21:33.000000000 +0900
@@ -714,7 +714,7 @@ wait_for_iobuf:
 
 	J_ASSERT(list_empty(&commit_transaction->t_syncdata_list));
 	J_ASSERT(list_empty(&commit_transaction->t_metadata_list));
-	J_ASSERT(commit_transaction->t_checkpoint_list == NULL);
+	J_ASSERT(list_empty(&commit_transaction->t_checkpoint_list));
 	J_ASSERT(list_empty(&commit_transaction->t_io_list));
 	J_ASSERT(list_empty(&commit_transaction->t_shadow_list));
 	J_ASSERT(list_empty(&commit_transaction->t_logctl_list));
@@ -832,7 +832,7 @@ restart_loop:
 	journal->j_committing_transaction = NULL;
 	spin_unlock(&journal->j_state_lock);
 
-	if (commit_transaction->t_checkpoint_list == NULL) {
+	if (list_empty(&commit_transaction->t_checkpoint_list)) {
 		__journal_drop_transaction(journal, commit_transaction);
 	} else {
 		list_add_tail(&commit_transaction->t_cplist,
diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/fs/jbd/journal.c 2.6.13-mm1/fs/jbd/journal.c
--- 2.6.13-mm1.old/fs/jbd/journal.c	2005-09-05 03:21:20.000000000 +0900
+++ 2.6.13-mm1/fs/jbd/journal.c	2005-09-05 03:21:36.000000000 +0900
@@ -1763,6 +1763,7 @@ repeat:
 		bh->b_private = jh;
 		jh->b_bh = bh;
 		INIT_LIST_HEAD(&jh->b_list);
+		INIT_LIST_HEAD(&jh->b_cplist);
 		get_bh(bh);
 		BUFFER_TRACE(bh, "added journal_head");
 	}
diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/fs/jbd/transaction.c 2.6.13-mm1/fs/jbd/transaction.c
--- 2.6.13-mm1.old/fs/jbd/transaction.c	2005-09-05 03:21:20.000000000 +0900
+++ 2.6.13-mm1/fs/jbd/transaction.c	2005-09-05 03:21:36.000000000 +0900
@@ -60,6 +60,8 @@ get_transaction(journal_t *journal, tran
 	INIT_LIST_HEAD(&transaction->t_shadow_list);
 	INIT_LIST_HEAD(&transaction->t_logctl_list);
 	INIT_LIST_HEAD(&transaction->t_cplist);
+	INIT_LIST_HEAD(&transaction->t_checkpoint_list);
+	INIT_LIST_HEAD(&transaction->t_checkpoint_io_list);
 
 	/* Set up the commit timer for the new transaction. */
 	journal->j_commit_timer->expires = transaction->t_expires;
diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/include/linux/jbd.h 2.6.13-mm1/include/linux/jbd.h
--- 2.6.13-mm1.old/include/linux/jbd.h	2005-09-05 03:21:20.000000000 +0900
+++ 2.6.13-mm1/include/linux/jbd.h	2005-09-05 03:21:33.000000000 +0900
@@ -497,13 +497,13 @@ struct transaction_s 
 	 * Doubly-linked circular list of all buffers still to be flushed before
 	 * this transaction can be checkpointed. [j_list_lock]
 	 */
-	struct journal_head	*t_checkpoint_list;
+	struct list_head	t_checkpoint_list;
 
 	/*
 	 * Doubly-linked circular list of all buffers submitted for IO while
 	 * checkpointing. [j_list_lock]
 	 */
-	struct journal_head	*t_checkpoint_io_list;
+	struct list_head	t_checkpoint_io_list;
 
 	/*
 	 * Doubly-linked circular list of temporary buffers currently undergoing
diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/include/linux/journal-head.h 2.6.13-mm1/include/linux/journal-head.h
--- 2.6.13-mm1.old/include/linux/journal-head.h	2005-09-05 03:20:41.000000000 +0900
+++ 2.6.13-mm1/include/linux/journal-head.h	2005-09-05 03:21:33.000000000 +0900
@@ -86,7 +86,7 @@ struct journal_head {
 	 * before an old transaction can be checkpointed.
 	 * [j_list_lock]
 	 */
-	struct journal_head *b_cpnext, *b_cpprev;
+	struct list_head b_cplist;
 };
 
 #endif		/* JOURNAL_HEAD_H_INCLUDED */
