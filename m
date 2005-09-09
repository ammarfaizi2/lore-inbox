Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbVIIIux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbVIIIux (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVIIIux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:50:53 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:38317 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S965095AbVIIIuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:50:52 -0400
Date: Fri, 9 Sep 2005 17:47:23 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com,
       ext3-users@redhat.com
Subject: [PATCH 4/6] jbd: use list_head for the list of buffers on a transaction's data
Message-ID: <20050909084723.GF14205@miraclelinux.com>
References: <20050909084214.GB14205@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909084214.GB14205@miraclelinux.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

use struct list_head for doubly-linked list of buffers on a transaction's
data, metadata or forget queue.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

---

 fs/jbd/checkpoint.c          |   12 ++--
 fs/jbd/commit.c              |   79 ++++++++++++++++--------------
 fs/jbd/journal.c             |    1 
 fs/jbd/transaction.c         |  110 ++++++++-----------------------------------
 include/linux/jbd.h          |   20 +++----
 include/linux/journal-head.h |    2 
 6 files changed, 80 insertions(+), 144 deletions(-)

diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/fs/jbd/checkpoint.c 2.6.13-mm1/fs/jbd/checkpoint.c
--- 2.6.13-mm1.old/fs/jbd/checkpoint.c	2005-09-05 03:15:17.000000000 +0900
+++ 2.6.13-mm1/fs/jbd/checkpoint.c	2005-09-05 03:15:35.000000000 +0900
@@ -684,12 +684,12 @@ void __journal_drop_transaction(journal_
 	}
 
 	J_ASSERT(transaction->t_state == T_FINISHED);
-	J_ASSERT(transaction->t_buffers == NULL);
-	J_ASSERT(transaction->t_sync_datalist == NULL);
-	J_ASSERT(transaction->t_forget == NULL);
-	J_ASSERT(transaction->t_iobuf_list == NULL);
-	J_ASSERT(transaction->t_shadow_list == NULL);
-	J_ASSERT(transaction->t_log_list == NULL);
+	J_ASSERT(list_empty(&transaction->t_metadata_list));
+	J_ASSERT(list_empty(&transaction->t_syncdata_list));
+	J_ASSERT(list_empty(&transaction->t_forget_list));
+	J_ASSERT(list_empty(&transaction->t_io_list));
+	J_ASSERT(list_empty(&transaction->t_shadow_list));
+	J_ASSERT(list_empty(&transaction->t_logctl_list));
 	J_ASSERT(transaction->t_checkpoint_list == NULL);
 	J_ASSERT(transaction->t_checkpoint_io_list == NULL);
 	J_ASSERT(transaction->t_updates == 0);
diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/fs/jbd/commit.c 2.6.13-mm1/fs/jbd/commit.c
--- 2.6.13-mm1.old/fs/jbd/commit.c	2005-09-05 03:16:12.000000000 +0900
+++ 2.6.13-mm1/fs/jbd/commit.c	2005-09-05 03:15:35.000000000 +0900
@@ -250,8 +250,9 @@ void journal_commit_transaction(journal_
 	 * that multiple journal_get_write_access() calls to the same
 	 * buffer are perfectly permissable.
 	 */
-	while (commit_transaction->t_reserved_list) {
-		jh = commit_transaction->t_reserved_list;
+	while (!list_empty(&commit_transaction->t_reserved_list)) {
+		jh = list_entry(commit_transaction->t_reserved_list.next,
+				struct journal_head, b_list);
 		JBUFFER_TRACE(jh, "reserved, unused: refile");
 		/*
 		 * A journal_get_undo_access()+journal_release_buffer() may
@@ -300,14 +301,9 @@ void journal_commit_transaction(journal_
 	 * will be tracked for a new trasaction only -bzzz
 	 */
 	spin_lock(&journal->j_list_lock);
-	if (commit_transaction->t_buffers) {
-		new_jh = jh = commit_transaction->t_buffers->b_tnext;
-		do {
-			J_ASSERT_JH(new_jh, new_jh->b_modified == 1 ||
-					new_jh->b_modified == 0);
-			new_jh->b_modified = 0;
-			new_jh = new_jh->b_tnext;
-		} while (new_jh != jh);
+	list_for_each_entry(jh, &commit_transaction->t_metadata_list, b_list) {
+		J_ASSERT_JH(jh, jh->b_modified == 1 || jh->b_modified == 0);
+		jh->b_modified = 0;
 	}
 	spin_unlock(&journal->j_list_lock);
 
@@ -319,7 +315,7 @@ void journal_commit_transaction(journal_
 	err = 0;
 	/*
 	 * Whenever we unlock the journal and sleep, things can get added
-	 * onto ->t_sync_datalist, so we have to keep looping back to
+	 * onto ->t_syncdata_list, so we have to keep looping back to
 	 * write_out_data until we *know* that the list is empty.
 	 */
 	bufs = 0;
@@ -331,11 +327,12 @@ write_out_data:
 	cond_resched();
 	spin_lock(&journal->j_list_lock);
 
-	while (commit_transaction->t_sync_datalist) {
+	while (!list_empty(&commit_transaction->t_syncdata_list)) {
 		struct buffer_head *bh;
 
-		jh = commit_transaction->t_sync_datalist;
-		commit_transaction->t_sync_datalist = jh->b_tnext;
+		jh = list_entry(commit_transaction->t_syncdata_list.next,
+				struct journal_head, b_list);
+		list_move_tail(&jh->b_list, &commit_transaction->t_syncdata_list);
 		bh = jh2bh(jh);
 		if (buffer_locked(bh)) {
 			BUFFER_TRACE(bh, "locked");
@@ -389,10 +386,11 @@ write_out_data:
 	/*
 	 * Wait for all previously submitted IO to complete.
 	 */
-	while (commit_transaction->t_locked_list) {
+	while (!list_empty(&commit_transaction->t_locked_list)) {
 		struct buffer_head *bh;
 
-		jh = commit_transaction->t_locked_list->b_tprev;
+		jh = list_entry(commit_transaction->t_locked_list.prev,
+				struct journal_head, b_list);
 		bh = jh2bh(jh);
 		get_bh(bh);
 		if (buffer_locked(bh)) {
@@ -431,7 +429,7 @@ write_out_data:
 	 * any then journal_clean_data_list should have wiped the list
 	 * clean by now, so check that it is in fact empty.
 	 */
-	J_ASSERT (commit_transaction->t_sync_datalist == NULL);
+	J_ASSERT (list_empty(&commit_transaction->t_syncdata_list));
 
 	jbd_debug (3, "JBD: commit phase 3\n");
 
@@ -444,11 +442,12 @@ write_out_data:
 
 	descriptor = NULL;
 	bufs = 0;
-	while (commit_transaction->t_buffers) {
+	while (!list_empty(&commit_transaction->t_metadata_list)) {
 
 		/* Find the next buffer to be journaled... */
 
-		jh = commit_transaction->t_buffers;
+		jh = list_entry(commit_transaction->t_metadata_list.next,
+				struct journal_head, b_list);
 
 		/* If we're in abort mode, we just un-journal the buffer and
 		   release it for background writing. */
@@ -460,7 +459,7 @@ write_out_data:
 			 * any descriptor buffers which may have been
 			 * already allocated, even if we are now
 			 * aborting. */
-			if (!commit_transaction->t_buffers)
+			if (list_empty(&commit_transaction->t_metadata_list))
 				goto start_journal_io;
 			continue;
 		}
@@ -569,7 +568,7 @@ write_out_data:
 		   let the IO rip! */
 
 		if (bufs == journal->j_wbufsize ||
-		    commit_transaction->t_buffers == NULL ||
+		    list_empty(&commit_transaction->t_metadata_list) ||
 		    space_left < sizeof(journal_block_tag_t) + 16) {
 
 			jbd_debug(4, "JBD: Submit %d IOs\n", bufs);
@@ -601,8 +600,8 @@ start_journal_io:
 	/* Lo and behold: we have just managed to send a transaction to
            the log.  Before we can commit it, wait for the IO so far to
            complete.  Control buffers being written are on the
-           transaction's t_log_list queue, and metadata buffers are on
-           the t_iobuf_list queue.
+           transaction's t_logctl_list queue, and metadata buffers are on
+           the t_io_list queue.
 
 	   Wait for the buffers in reverse order.  That way we are
 	   less likely to be woken up until all IOs have completed, and
@@ -616,10 +615,11 @@ start_journal_io:
 	 * See __journal_try_to_free_buffer.
 	 */
 wait_for_iobuf:
-	while (commit_transaction->t_iobuf_list != NULL) {
+	while (!list_empty(&commit_transaction->t_io_list)) {
 		struct buffer_head *bh;
 
-		jh = commit_transaction->t_iobuf_list->b_tprev;
+		jh = list_entry(commit_transaction->t_io_list.prev,
+				struct journal_head, b_list);
 		bh = jh2bh(jh);
 		if (buffer_locked(bh)) {
 			wait_on_buffer(bh);
@@ -637,7 +637,7 @@ wait_for_iobuf:
 		journal_unfile_buffer(journal, jh);
 
 		/*
-		 * ->t_iobuf_list should contain only dummy buffer_heads
+		 * ->t_io_list should contain only dummy buffer_heads
 		 * which were created by journal_write_metadata_buffer().
 		 */
 		BUFFER_TRACE(bh, "dumping temporary bh");
@@ -648,7 +648,8 @@ wait_for_iobuf:
 
 		/* We also have to unlock and free the corresponding
                    shadowed buffer */
-		jh = commit_transaction->t_shadow_list->b_tprev;
+		jh = list_entry(commit_transaction->t_shadow_list.prev,
+				struct journal_head, b_list);
 		bh = jh2bh(jh);
 		clear_bit(BH_JWrite, &bh->b_state);
 		J_ASSERT_BH(bh, buffer_jbddirty(bh));
@@ -666,16 +667,17 @@ wait_for_iobuf:
 		__brelse(bh);
 	}
 
-	J_ASSERT (commit_transaction->t_shadow_list == NULL);
+	J_ASSERT (list_empty(&commit_transaction->t_shadow_list));
 
 	jbd_debug(3, "JBD: commit phase 5\n");
 
 	/* Here we wait for the revoke record and descriptor record buffers */
  wait_for_ctlbuf:
-	while (commit_transaction->t_log_list != NULL) {
+	while (!list_empty(&commit_transaction->t_logctl_list)) {
 		struct buffer_head *bh;
 
-		jh = commit_transaction->t_log_list->b_tprev;
+		jh = list_entry(commit_transaction->t_logctl_list.prev,
+				struct journal_head, b_list);
 		bh = jh2bh(jh);
 		if (buffer_locked(bh)) {
 			wait_on_buffer(bh);
@@ -710,12 +712,12 @@ wait_for_iobuf:
 
 	jbd_debug(3, "JBD: commit phase 7\n");
 
-	J_ASSERT(commit_transaction->t_sync_datalist == NULL);
-	J_ASSERT(commit_transaction->t_buffers == NULL);
+	J_ASSERT(list_empty(&commit_transaction->t_syncdata_list));
+	J_ASSERT(list_empty(&commit_transaction->t_metadata_list));
 	J_ASSERT(commit_transaction->t_checkpoint_list == NULL);
-	J_ASSERT(commit_transaction->t_iobuf_list == NULL);
-	J_ASSERT(commit_transaction->t_shadow_list == NULL);
-	J_ASSERT(commit_transaction->t_log_list == NULL);
+	J_ASSERT(list_empty(&commit_transaction->t_io_list));
+	J_ASSERT(list_empty(&commit_transaction->t_shadow_list));
+	J_ASSERT(list_empty(&commit_transaction->t_logctl_list));
 
 restart_loop:
 	/*
@@ -723,11 +725,12 @@ restart_loop:
 	 * to this list we have to be careful and hold the j_list_lock.
 	 */
 	spin_lock(&journal->j_list_lock);
-	while (commit_transaction->t_forget) {
+	while (!list_empty(&commit_transaction->t_forget_list)) {
 		transaction_t *cp_transaction;
 		struct buffer_head *bh;
 
-		jh = commit_transaction->t_forget;
+		jh = list_entry(commit_transaction->t_forget_list.next,
+				struct journal_head, b_list);
 		spin_unlock(&journal->j_list_lock);
 		bh = jh2bh(jh);
 		jbd_lock_bh_state(bh);
@@ -811,7 +814,7 @@ restart_loop:
 	 * Now recheck if some buffers did not get attached to the transaction
 	 * while the lock was dropped...
 	 */
-	if (commit_transaction->t_forget) {
+	if (!list_empty(&commit_transaction->t_forget_list)) {
 		spin_unlock(&journal->j_list_lock);
 		spin_unlock(&journal->j_state_lock);
 		goto restart_loop;
diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/fs/jbd/journal.c 2.6.13-mm1/fs/jbd/journal.c
--- 2.6.13-mm1.old/fs/jbd/journal.c	2005-09-05 03:15:17.000000000 +0900
+++ 2.6.13-mm1/fs/jbd/journal.c	2005-09-05 03:15:39.000000000 +0900
@@ -1761,6 +1761,7 @@ repeat:
 		set_buffer_jbd(bh);
 		bh->b_private = jh;
 		jh->b_bh = bh;
+		INIT_LIST_HEAD(&jh->b_list);
 		get_bh(bh);
 		BUFFER_TRACE(bh, "added journal_head");
 	}
diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/fs/jbd/transaction.c 2.6.13-mm1/fs/jbd/transaction.c
--- 2.6.13-mm1.old/fs/jbd/transaction.c	2005-09-05 03:15:17.000000000 +0900
+++ 2.6.13-mm1/fs/jbd/transaction.c	2005-09-05 03:15:35.000000000 +0900
@@ -51,6 +51,14 @@ get_transaction(journal_t *journal, tran
 	transaction->t_tid = journal->j_transaction_sequence++;
 	transaction->t_expires = jiffies + journal->j_commit_interval;
 	spin_lock_init(&transaction->t_handle_lock);
+	INIT_LIST_HEAD(&transaction->t_reserved_list);
+	INIT_LIST_HEAD(&transaction->t_locked_list);
+	INIT_LIST_HEAD(&transaction->t_metadata_list);
+	INIT_LIST_HEAD(&transaction->t_syncdata_list);
+	INIT_LIST_HEAD(&transaction->t_forget_list);
+	INIT_LIST_HEAD(&transaction->t_io_list);
+	INIT_LIST_HEAD(&transaction->t_shadow_list);
+	INIT_LIST_HEAD(&transaction->t_logctl_list);
 
 	/* Set up the commit timer for the new transaction. */
 	journal->j_commit_timer->expires = transaction->t_expires;
@@ -1414,64 +1422,12 @@ int journal_force_commit(journal_t *jour
 	return ret;
 }
 
-/*
- *
- * List management code snippets: various functions for manipulating the
- * transaction buffer lists.
- *
- */
-
-/*
- * Append a buffer to a transaction list, given the transaction's list head
- * pointer.
- *
- * j_list_lock is held.
- *
- * jbd_lock_bh_state(jh2bh(jh)) is held.
- */
-
-static inline void 
-__blist_add_buffer(struct journal_head **list, struct journal_head *jh)
-{
-	if (!*list) {
-		jh->b_tnext = jh->b_tprev = jh;
-		*list = jh;
-	} else {
-		/* Insert at the tail of the list to preserve order */
-		struct journal_head *first = *list, *last = first->b_tprev;
-		jh->b_tprev = last;
-		jh->b_tnext = first;
-		last->b_tnext = first->b_tprev = jh;
-	}
-}
-
-/* 
- * Remove a buffer from a transaction list, given the transaction's list
- * head pointer.
- *
- * Called with j_list_lock held, and the journal may not be locked.
- *
- * jbd_lock_bh_state(jh2bh(jh)) is held.
- */
-
-static inline void
-__blist_del_buffer(struct journal_head **list, struct journal_head *jh)
-{
-	if (*list == jh) {
-		*list = jh->b_tnext;
-		if (*list == jh)
-			*list = NULL;
-	}
-	jh->b_tprev->b_tnext = jh->b_tnext;
-	jh->b_tnext->b_tprev = jh->b_tprev;
-}
-
 /* 
  * Remove a buffer from the appropriate transaction list.
  *
  * Note that this function can *change* the value of
- * bh->b_transaction->t_sync_datalist, t_buffers, t_forget,
- * t_iobuf_list, t_shadow_list, t_log_list or t_reserved_list.  If the caller
+ * bh->b_transaction->t_syncdata_list, t_metadata_list, t_forget_list,
+ * t_io_list, t_shadow_list, t_logctl_list or t_reserved_list.  If the caller
  * is holding onto a copy of one of thee pointers, it could go bad.
  * Generally the caller needs to re-read the pointer from the transaction_t.
  *
@@ -1479,7 +1435,6 @@ __blist_del_buffer(struct journal_head *
  */
 void __journal_temp_unlink_buffer(struct journal_head *jh)
 {
-	struct journal_head **list = NULL;
 	transaction_t *transaction;
 	struct buffer_head *bh = jh2bh(jh);
 
@@ -1495,35 +1450,12 @@ void __journal_temp_unlink_buffer(struct
 	switch (jh->b_jlist) {
 	case BJ_None:
 		return;
-	case BJ_SyncData:
-		list = &transaction->t_sync_datalist;
-		break;
 	case BJ_Metadata:
-		transaction->t_nr_buffers--;
-		J_ASSERT_JH(jh, transaction->t_nr_buffers >= 0);
-		list = &transaction->t_buffers;
-		break;
-	case BJ_Forget:
-		list = &transaction->t_forget;
-		break;
-	case BJ_IO:
-		list = &transaction->t_iobuf_list;
-		break;
-	case BJ_Shadow:
-		list = &transaction->t_shadow_list;
-		break;
-	case BJ_LogCtl:
-		list = &transaction->t_log_list;
-		break;
-	case BJ_Reserved:
-		list = &transaction->t_reserved_list;
-		break;
-	case BJ_Locked:
-		list = &transaction->t_locked_list;
+		transaction->t_nr_metadata--;
+		J_ASSERT_JH(jh, transaction->t_nr_metadata >= 0);
 		break;
 	}
-
-	__blist_del_buffer(list, jh);
+	list_del(&jh->b_list);
 	jh->b_jlist = BJ_None;
 	if (test_clear_buffer_jbddirty(bh))
 		mark_buffer_dirty(bh);	/* Expose it to the VM */
@@ -1924,7 +1856,7 @@ int journal_invalidatepage(journal_t *jo
 void __journal_file_buffer(struct journal_head *jh,
 			transaction_t *transaction, int jlist)
 {
-	struct journal_head **list = NULL;
+	struct list_head *list = NULL;
 	int was_dirty = 0;
 	struct buffer_head *bh = jh2bh(jh);
 
@@ -1959,23 +1891,23 @@ void __journal_file_buffer(struct journa
 		J_ASSERT_JH(jh, !jh->b_frozen_data);
 		return;
 	case BJ_SyncData:
-		list = &transaction->t_sync_datalist;
+		list = &transaction->t_syncdata_list;
 		break;
 	case BJ_Metadata:
-		transaction->t_nr_buffers++;
-		list = &transaction->t_buffers;
+		transaction->t_nr_metadata++;
+		list = &transaction->t_metadata_list;
 		break;
 	case BJ_Forget:
-		list = &transaction->t_forget;
+		list = &transaction->t_forget_list;
 		break;
 	case BJ_IO:
-		list = &transaction->t_iobuf_list;
+		list = &transaction->t_io_list;
 		break;
 	case BJ_Shadow:
 		list = &transaction->t_shadow_list;
 		break;
 	case BJ_LogCtl:
-		list = &transaction->t_log_list;
+		list = &transaction->t_logctl_list;
 		break;
 	case BJ_Reserved:
 		list = &transaction->t_reserved_list;
@@ -1985,7 +1917,7 @@ void __journal_file_buffer(struct journa
 		break;
 	}
 
-	__blist_add_buffer(list, jh);
+	list_add_tail(&jh->b_list, list);
 	jh->b_jlist = jlist;
 
 	if (was_dirty)
diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/include/linux/jbd.h 2.6.13-mm1/include/linux/jbd.h
--- 2.6.13-mm1.old/include/linux/jbd.h	2005-09-05 03:15:24.000000000 +0900
+++ 2.6.13-mm1/include/linux/jbd.h	2005-09-05 03:15:35.000000000 +0900
@@ -459,39 +459,39 @@ struct transaction_s 
 	 */
 	unsigned long		t_log_start;
 
-	/* Number of buffers on the t_buffers list [j_list_lock] */
-	int			t_nr_buffers;
+	/* Number of buffers on the t_metadata_list [j_list_lock] */
+	int			t_nr_metadata;
 
 	/*
 	 * Doubly-linked circular list of all buffers reserved but not yet
 	 * modified by this transaction [j_list_lock]
 	 */
-	struct journal_head	*t_reserved_list;
+	struct list_head	t_reserved_list;
 
 	/*
 	 * Doubly-linked circular list of all buffers under writeout during
 	 * commit [j_list_lock]
 	 */
-	struct journal_head	*t_locked_list;
+	struct list_head	t_locked_list;
 
 	/*
 	 * Doubly-linked circular list of all metadata buffers owned by this
 	 * transaction [j_list_lock]
 	 */
-	struct journal_head	*t_buffers;
+	struct list_head	t_metadata_list;
 
 	/*
 	 * Doubly-linked circular list of all data buffers still to be
 	 * flushed before this transaction can be committed [j_list_lock]
 	 */
-	struct journal_head	*t_sync_datalist;
+	struct list_head	t_syncdata_list;
 
 	/*
 	 * Doubly-linked circular list of all forget buffers (superseded
 	 * buffers which we can un-checkpoint once this transaction commits)
 	 * [j_list_lock]
 	 */
-	struct journal_head	*t_forget;
+	struct list_head	t_forget_list;
 
 	/*
 	 * Doubly-linked circular list of all buffers still to be flushed before
@@ -509,20 +509,20 @@ struct transaction_s 
 	 * Doubly-linked circular list of temporary buffers currently undergoing
 	 * IO in the log [j_list_lock]
 	 */
-	struct journal_head	*t_iobuf_list;
+	struct list_head	t_io_list;
 
 	/*
 	 * Doubly-linked circular list of metadata buffers being shadowed by log
 	 * IO.  The IO buffers on the iobuf list and the shadow buffers on this
 	 * list match each other one for one at all times. [j_list_lock]
 	 */
-	struct journal_head	*t_shadow_list;
+	struct list_head	t_shadow_list;
 
 	/*
 	 * Doubly-linked circular list of control buffers being written to the
 	 * log. [j_list_lock]
 	 */
-	struct journal_head	*t_log_list;
+	struct list_head	t_logctl_list;
 
 	/*
 	 * Protects info related to handles
diff -X 2.6.13-mm1/Documentation/dontdiff -Nurp 2.6.13-mm1.old/include/linux/journal-head.h 2.6.13-mm1/include/linux/journal-head.h
--- 2.6.13-mm1.old/include/linux/journal-head.h	2005-09-05 03:15:24.000000000 +0900
+++ 2.6.13-mm1/include/linux/journal-head.h	2005-09-05 03:15:35.000000000 +0900
@@ -72,7 +72,7 @@ struct journal_head {
 	 * Doubly-linked list of buffers on a transaction's data, metadata or
 	 * forget queue. [t_list_lock] [jbd_lock_bh_state()]
 	 */
-	struct journal_head *b_tnext, *b_tprev;
+	struct list_head b_list;
 
 	/*
 	 * Pointer to the compound transaction against which this buffer
