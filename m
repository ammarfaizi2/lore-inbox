Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318031AbSHVXPv>; Thu, 22 Aug 2002 19:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318040AbSHVXPu>; Thu, 22 Aug 2002 19:15:50 -0400
Received: from pc-62-31-66-89-ed.blueyonder.co.uk ([62.31.66.89]:33156 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318031AbSHVXPr>; Thu, 22 Aug 2002 19:15:47 -0400
Date: Fri, 23 Aug 2002 00:19:36 +0100
Message-Id: <200208222319.g7MNJaS09086@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 2/2] 2.4.20-pre4/ext3: Fix "buffer_jdirty" assert failure.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a race window in buffer refiling where we could temporarily
expose the journal's internal BH_JBDDirect flag as BH_Dirty, which is
visible to the rest of the VFS.  That doesn't affect the journaling,
because we hold journal_head locks while the buffer is in this transient
state, but bdflush can see the buffer and write it out unexpectedly,
causing ext3 to find the buffer in an unexpected state later.

The fix simply keeps the dirty bits clear during the internal buffer
processing, restoring the state to the private BH_JBDDirect once
refiling is complete.

--- linux-ext3-2.4merge-2/fs/jbd/transaction.c.=K0001=.orig	Thu Aug 22 23:43:16 2002
+++ linux-ext3-2.4merge-2/fs/jbd/transaction.c	Thu Aug 22 23:43:34 2002
@@ -1833,6 +1833,7 @@
 		 * running transaction if that is set, but nothing
 		 * else. */
 		JBUFFER_TRACE(jh, "on committing transaction");
+		set_bit(BH_Freed, &bh->b_state);
 		if (jh->b_next_transaction) {
 			J_ASSERT(jh->b_next_transaction ==
 					journal->j_running_transaction);
@@ -1916,6 +1917,7 @@
 			transaction_t *transaction, int jlist)
 {
 	struct journal_head **list = 0;
+	int was_dirty = 0;
 
 	assert_spin_locked(&journal_datalist_lock);
 	
@@ -1926,13 +1928,24 @@
 	J_ASSERT_JH(jh, jh->b_transaction == transaction ||
 				jh->b_transaction == 0);
 
-	if (jh->b_transaction) {
-		if (jh->b_jlist == jlist)
-			return;
+	if (jh->b_transaction && jh->b_jlist == jlist)
+		return;
+	
+	/* The following list of buffer states needs to be consistent
+	 * with __jbd_unexpected_dirty_buffer()'s handling of dirty
+	 * state. */
+
+	if (jlist == BJ_Metadata || jlist == BJ_Reserved || 
+	    jlist == BJ_Shadow || jlist == BJ_Forget) {
+		if (atomic_set_buffer_clean(jh2bh(jh)) ||
+		    test_and_clear_bit(BH_JBDDirty, &jh2bh(jh)->b_state))
+			was_dirty = 1;
+	}
+
+	if (jh->b_transaction)
 		__journal_unfile_buffer(jh);
-	} else {
+	else
 		jh->b_transaction = transaction;
-	}
 
 	switch (jlist) {
 	case BJ_None:
@@ -1969,16 +1982,8 @@
 	__blist_add_buffer(list, jh);
 	jh->b_jlist = jlist;
 
-	/* The following list of buffer states needs to be consistent
-	 * with __jbd_unexpected_dirty_buffer()'s handling of dirty
-	 * state. */
-
-	if (jlist == BJ_Metadata || jlist == BJ_Reserved || 
-	    jlist == BJ_Shadow || jlist == BJ_Forget) {
-		if (atomic_set_buffer_clean(jh2bh(jh))) {
-			set_bit(BH_JBDDirty, &jh2bh(jh)->b_state);
-		}
-	}
+	if (was_dirty)
+		set_bit(BH_JBDDirty, &jh2bh(jh)->b_state);
 }
 
 void journal_file_buffer(struct journal_head *jh,
@@ -1998,26 +2003,36 @@
 
 void __journal_refile_buffer(struct journal_head *jh)
 {
+	int was_dirty = 0;
+
 	assert_spin_locked(&journal_datalist_lock);
 #ifdef __SMP__
 	J_ASSERT_JH(jh, current->lock_depth >= 0);
 #endif
-	__journal_unfile_buffer(jh);
+	/* If the buffer is now unused, just drop it. */
+	if (jh->b_next_transaction == NULL) {
+		__journal_unfile_buffer(jh);
+		jh->b_transaction = NULL;
+		/* Onto BUF_DIRTY for writeback */
+		refile_buffer(jh2bh(jh));
+		return;
+	}
+	
+	/* It has been modified by a later transaction: add it to the
+	 * new transaction's metadata list. */
 
-	/* If the buffer is now unused, just drop it.  If it has been
-	   modified by a later transaction, add it to the new
-	   transaction's metadata list. */
+	if (test_and_clear_bit(BH_JBDDirty, &jh2bh(jh)->b_state))
+			was_dirty = 1;
 
+	__journal_unfile_buffer(jh);
 	jh->b_transaction = jh->b_next_transaction;
 	jh->b_next_transaction = NULL;
+	__journal_file_buffer(jh, jh->b_transaction, BJ_Metadata);
+	J_ASSERT_JH(jh, jh->b_transaction->t_state == T_RUNNING);
+
+	if (was_dirty)
+		set_bit(BH_JBDDirty, &jh2bh(jh)->b_state);
 
-	if (jh->b_transaction != NULL) {
-		__journal_file_buffer(jh, jh->b_transaction, BJ_Metadata);
-		J_ASSERT_JH(jh, jh->b_transaction->t_state == T_RUNNING);
-	} else {
-		/* Onto BUF_DIRTY for writeback */
-		refile_buffer(jh2bh(jh));
-	}
 }
 
 /*
