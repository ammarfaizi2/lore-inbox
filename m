Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbSIZNxn>; Thu, 26 Sep 2002 09:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261294AbSIZNwZ>; Thu, 26 Sep 2002 09:52:25 -0400
Received: from pc-62-31-66-34-ed.blueyonder.co.uk ([62.31.66.34]:22147 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261293AbSIZNud>; Thu, 26 Sep 2002 09:50:33 -0400
Date: Thu, 26 Sep 2002 14:55:32 +0100
Message-Id: <200209261355.g8QDtWa17006@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 5/7] 2.4.20-pre4/ext3: ext3 commit notification for InterMezzo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add jbd callback mechanism, requested for InterMezzo.  We allow the jbd's
client to request notification when a given handle's IO finally commits to
disk, so that clients can manage their own writeback state asynchronously.

--- linux-2.4-ext3merge/fs/jbd/checkpoint.c.=K0004=.orig	Thu Sep 26 12:19:14 2002
+++ linux-2.4-ext3merge/fs/jbd/checkpoint.c	Thu Sep 26 12:25:37 2002
@@ -594,7 +594,8 @@
 	J_ASSERT (transaction->t_log_list == NULL);
 	J_ASSERT (transaction->t_checkpoint_list == NULL);
 	J_ASSERT (transaction->t_updates == 0);
-	
+	J_ASSERT (list_empty(&transaction->t_jcb));
+
 	J_ASSERT (transaction->t_journal->j_committing_transaction !=
 					transaction);
 	
--- linux-2.4-ext3merge/fs/jbd/commit.c.=K0004=.orig	Thu Sep 26 12:25:37 2002
+++ linux-2.4-ext3merge/fs/jbd/commit.c	Thu Sep 26 12:25:37 2002
@@ -475,7 +475,7 @@
            transaction's t_log_list queue, and metadata buffers are on
            the t_iobuf_list queue.
 
-	   Wait for the transactions in reverse order.  That way we are
+	   Wait for the buffers in reverse order.  That way we are
 	   less likely to be woken up until all IOs have completed, and
 	   so we incur less scheduling load.
 	*/
@@ -566,8 +566,10 @@
 
 	jbd_debug(3, "JBD: commit phase 6\n");
 
-	if (is_journal_aborted(journal))
+	if (is_journal_aborted(journal)) {
+		unlock_journal(journal);
 		goto skip_commit;
+	}
 
 	/* Done it all: now write the commit record.  We should have
 	 * cleaned up our previous buffers by now, so if we are in abort
@@ -577,9 +579,10 @@
 	descriptor = journal_get_descriptor_buffer(journal);
 	if (!descriptor) {
 		__journal_abort_hard(journal);
+		unlock_journal(journal);
 		goto skip_commit;
 	}
-	
+
 	/* AKPM: buglet - add `i' to tmp! */
 	for (i = 0; i < jh2bh(descriptor)->b_size; i += 512) {
 		journal_header_t *tmp =
@@ -600,14 +603,32 @@
 		put_bh(bh);		/* One for getblk() */
 		journal_unlock_journal_head(descriptor);
 	}
-	lock_journal(journal);
 
 	/* End of a transaction!  Finally, we can do checkpoint
            processing: any buffers committed as a result of this
            transaction can be removed from any checkpoint list it was on
            before. */
 
-skip_commit:
+skip_commit: /* The journal should be unlocked by now. */
+
+	/* Call any callbacks that had been registered for handles in this
+	 * transaction.  It is up to the callback to free any allocated
+	 * memory.
+	 */
+	if (!list_empty(&commit_transaction->t_jcb)) {
+		struct list_head *p, *n;
+		int error = is_journal_aborted(journal);
+
+		list_for_each_safe(p, n, &commit_transaction->t_jcb) {
+			struct journal_callback *jcb;
+
+			jcb = list_entry(p, struct journal_callback, jcb_list);
+			list_del(p);
+			jcb->jcb_func(jcb, error);
+		}
+	}
+
+	lock_journal(journal);
 
 	jbd_debug(3, "JBD: commit phase 7\n");
 
--- linux-2.4-ext3merge/fs/jbd/journal.c.=K0004=.orig	Thu Sep 26 12:19:14 2002
+++ linux-2.4-ext3merge/fs/jbd/journal.c	Thu Sep 26 12:25:37 2002
@@ -58,6 +58,7 @@
 #endif
 EXPORT_SYMBOL(journal_flush);
 EXPORT_SYMBOL(journal_revoke);
+EXPORT_SYMBOL(journal_callback_set);
 
 EXPORT_SYMBOL(journal_init_dev);
 EXPORT_SYMBOL(journal_init_inode);
--- linux-2.4-ext3merge/fs/jbd/transaction.c.=K0004=.orig	Thu Sep 26 12:25:37 2002
+++ linux-2.4-ext3merge/fs/jbd/transaction.c	Thu Sep 26 12:25:37 2002
@@ -57,6 +57,7 @@
 	transaction->t_state = T_RUNNING;
 	transaction->t_tid = journal->j_transaction_sequence++;
 	transaction->t_expires = jiffies + journal->j_commit_interval;
+	INIT_LIST_HEAD(&transaction->t_jcb);
 
 	/* Set up the commit timer for the new transaction. */
 	J_ASSERT (!journal->j_commit_timer_active);
@@ -208,6 +209,20 @@
 	return 0;
 }
 
+/* Allocate a new handle.  This should probably be in a slab... */
+static handle_t *new_handle(int nblocks)
+{
+	handle_t *handle = jbd_kmalloc(sizeof (handle_t), GFP_NOFS);
+	if (!handle)
+		return NULL;
+	memset(handle, 0, sizeof (handle_t));
+	handle->h_buffer_credits = nblocks;
+	handle->h_ref = 1;
+	INIT_LIST_HEAD(&handle->h_jcb);
+
+	return handle;
+}
+
 /*
  * Obtain a new handle.  
  *
@@ -234,14 +249,11 @@
 		handle->h_ref++;
 		return handle;
 	}
-	
-	handle = jbd_kmalloc(sizeof (handle_t), GFP_NOFS);
+
+	handle = new_handle(nblocks);
 	if (!handle)
 		return ERR_PTR(-ENOMEM);
-	memset (handle, 0, sizeof (handle_t));
 
-	handle->h_buffer_credits = nblocks;
-	handle->h_ref = 1;
 	current->journal_info = handle;
 
 	err = start_this_handle(journal, handle);
@@ -340,14 +352,11 @@
 	
 	if (is_journal_aborted(journal))
 		return ERR_PTR(-EIO);
-	
-	handle = jbd_kmalloc(sizeof (handle_t), GFP_NOFS);
+
+	handle = new_handle(nblocks);
 	if (!handle)
 		return ERR_PTR(-ENOMEM);
-	memset (handle, 0, sizeof (handle_t));
 
-	handle->h_buffer_credits = nblocks;
-	handle->h_ref = 1;
 	current->journal_info = handle;
 
 	err = try_start_this_handle(journal, handle);
@@ -1327,6 +1336,28 @@
 #endif
 
 /*
+ * Register a callback function for this handle.  The function will be
+ * called when the transaction that this handle is part of has been
+ * committed to disk with the original callback data struct and the
+ * error status of the journal as parameters.  There is no guarantee of
+ * ordering between handles within a single transaction, nor between
+ * callbacks registered on the same handle.
+ *
+ * The caller is responsible for allocating the journal_callback struct.
+ * This is to allow the caller to add as much extra data to the callback
+ * as needed, but reduce the overhead of multiple allocations.  The caller
+ * allocated struct must start with a struct journal_callback at offset 0,
+ * and has the caller-specific data afterwards.
+ */
+void journal_callback_set(handle_t *handle,
+			  void (*func)(struct journal_callback *jcb, int error),
+			  struct journal_callback *jcb)
+{
+	list_add_tail(&jcb->jcb_list, &handle->h_jcb);
+	jcb->jcb_func = func;
+}
+
+/*
  * All done for a particular handle.
  *
  * There is not much action needed here.  We just return any remaining
@@ -1390,7 +1421,10 @@
 			wake_up(&journal->j_wait_transaction_locked);
 	}
 
-	/* 
+	/* Move callbacks from the handle to the transaction. */
+	list_splice(&handle->h_jcb, &transaction->t_jcb);
+
+	/*
 	 * If the handle is marked SYNC, we need to set another commit
 	 * going!  We also want to force a commit if the current
 	 * transaction is occupying too much of the log, or if the
--- linux-2.4-ext3merge/include/linux/jbd.h.=K0004=.orig	Thu Sep 26 12:19:14 2002
+++ linux-2.4-ext3merge/include/linux/jbd.h	Thu Sep 26 12:25:37 2002
@@ -257,6 +257,13 @@
 	return bh->b_private;
 }
 
+#define HAVE_JOURNAL_CALLBACK_STATUS
+struct journal_callback {
+	struct list_head jcb_list;
+	void (*jcb_func)(struct journal_callback *jcb, int error);
+	/* user data goes here */
+};
+
 struct jbd_revoke_table_s;
 
 /* The handle_t type represents a single atomic update being performed
@@ -287,6 +294,12 @@
 	   operations */
 	int			h_err;
 
+	/* List of application registered callbacks for this handle.
+	 * The function(s) will be called after the transaction that
+	 * this handle is part of has been committed to disk.
+	 */
+	struct list_head	h_jcb;
+
 	/* Flags */
 	unsigned int	h_sync:		1;	/* sync-on-close */
 	unsigned int	h_jdata:	1;	/* force data journaling */
@@ -406,6 +419,10 @@
 
 	/* How many handles used this transaction? */
 	int t_handle_count;
+
+	/* List of registered callback functions for this transaction.
+	 * Called when the transaction is committed. */
+	struct list_head	t_jcb;
 };
 
 
@@ -654,6 +671,9 @@
 extern int	 journal_try_to_free_buffers(journal_t *, struct page *, int);
 extern int	 journal_stop(handle_t *);
 extern int	 journal_flush (journal_t *);
+extern void	 journal_callback_set(handle_t *handle,
+				      void (*fn)(struct journal_callback *,int),
+				      struct journal_callback *jcb);
 
 extern void	 journal_lock_updates (journal_t *);
 extern void	 journal_unlock_updates (journal_t *);
