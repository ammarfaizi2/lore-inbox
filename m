Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266045AbTGDOox (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 10:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266046AbTGDOox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 10:44:53 -0400
Received: from tmi.comex.ru ([217.10.33.92]:57777 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S266045AbTGDOot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 10:44:49 -0400
Subject: minor JBD tunings
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Cc: ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Fri, 04 Jul 2003 18:58:45 +0000
Message-ID: <87d6gqp196.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


hi!

I'm trying to improve JBD performance. please, take a look at numbers.

creation of 500K files in single dir (with htree, of course):
before: 4m16.094s, 4m12.035s, 4m11.911s
after:  1m41.364s, 1m43.461s, 1m45.189s

removal of 500K files in single dir:
before: 43m50.161s
after:  38m45.510s
patches are attached

with best regards, Alex Tomas
 


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=jbd-dont-account-blocks-twice.patch


start_this_handle() takes in account t_outstanding_credits calculating
log free space, but journal_next_log_block() accounts blocks being logged
also. hence, blocks are accounting twice. we don't want this.




diff -puN fs/jbd/commit.c~jbd-dont-account-blocks-twice fs/jbd/commit.c
--- linux-2.5.73/fs/jbd/commit.c~jbd-dont-account-blocks-twice	Sun Jun 29 13:20:23 2003
+++ linux-2.5.73-alexey/fs/jbd/commit.c	Sun Jun 29 13:22:33 2003
@@ -401,6 +401,11 @@ sync_datalist_empty:
 			continue;
 		}
 
+		/* start_this_handle() accounts t_outstanding_credits
+		 * to know free space in log, but this counter is changed
+		 * by journal_next_log_block() also. */
+		commit_transaction->t_outstanding_credits--;
+
 		/* Bump b_count to prevent truncate from stumbling over
                    the shadowed buffer!  @@@ This can go if we ever get
                    rid of the BJ_IO/BJ_Shadow pairing of buffers. */

_

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=jbd-commit-tricks.patch


- __log_wait_for_space() recalculates needed blocks because journal free
  space changes during commit
- log_do_checkpoint() starts scaning from the oldest transaction  
- log_do_checkpoint() stop scaning if some transaction gets dropped




diff -puN fs/jbd/checkpoint.c~jbd-commit-tricks fs/jbd/checkpoint.c
--- linux-2.5.73/fs/jbd/checkpoint.c~jbd-commit-tricks	Fri Jul  4 18:02:02 2003
+++ linux-2.5.73-alexey/fs/jbd/checkpoint.c	Fri Jul  4 18:12:40 2003
@@ -80,6 +80,10 @@ void __log_wait_for_space(journal_t *jou
 {
 	assert_spin_locked(&journal->j_state_lock);
 
+	nblocks = journal->j_max_transaction_buffers;
+	if (journal->j_committing_transaction) 
+		nblocks += journal->j_committing_transaction->
+					t_outstanding_credits;
 	while (__log_space_left(journal) < nblocks) {
 		if (journal->j_flags & JFS_ABORT)
 			return;
@@ -91,6 +95,10 @@ void __log_wait_for_space(journal_t *jou
 		 * were waiting for the checkpoint lock
 		 */
 		spin_lock(&journal->j_state_lock);
+		nblocks = journal->j_max_transaction_buffers;
+		if (journal->j_committing_transaction) 
+			nblocks += journal->j_committing_transaction->
+				t_outstanding_credits;
 		if (__log_space_left(journal) < nblocks) {
 			spin_unlock(&journal->j_state_lock);
 			log_do_checkpoint(journal, nblocks);
@@ -225,11 +233,13 @@ __flush_batch(journal_t *journal, struct
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
 
@@ -262,6 +272,8 @@ static int __flush_buffer(journal_t *jou
 		if (__try_to_free_cp_buf(jh)) {
 			(*drop_count)++;
 			ret = last_buffer;
+			if (last_buffer)
+				*freed = 1;
 		}
 	}
 	return ret;
@@ -286,6 +298,7 @@ int log_do_checkpoint(journal_t *journal
 	int result;
 	int batch_count = 0;
 	struct buffer_head *bhs[NR_BATCH];
+	int stid;
 
 	jbd_debug(1, "Start checkpoint\n");
 
@@ -308,14 +321,23 @@ int log_do_checkpoint(journal_t *journal
 	 * degenerates into a busy loop at unmount time.
 	 */
 	spin_lock(&journal->j_list_lock);
+	if (journal->j_checkpoint_transactions)
+		stid = journal->j_checkpoint_transactions->t_tid - 1;
 	while (journal->j_checkpoint_transactions) {
 		transaction_t *transaction;
 		struct journal_head *jh, *last_jh, *next_jh;
 		int drop_count = 0;
 		int cleanup_ret, retry = 0;
 		tid_t this_tid;
+		int freed = 0;
 
-		transaction = journal->j_checkpoint_transactions->t_cpnext;
+		transaction = journal->j_checkpoint_transactions;
+		while (transaction->t_tid <= stid) {
+			transaction = transaction->t_cpnext;
+			if (transaction == journal->j_checkpoint_transactions)
+				goto finish;
+		}
+		stid = transaction->t_tid;
 		this_tid = transaction->t_tid;
 		jh = transaction->t_checkpoint_list;
 		last_jh = jh->b_cpprev;
@@ -333,15 +355,22 @@ int log_do_checkpoint(journal_t *journal
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
+		 * transaction was freed, so we're gonna return to check is
+		 * log has enough space for next transaction
+		 */
+		if (freed)
+			break;
+
+		if (retry) {
+			stid--;
 			continue;
 		}
-		if (retry)
-			continue;
-
 		/*
 		 * If someone emptied the checkpoint list while we slept, we're
 		 * done.
@@ -349,12 +378,6 @@ int log_do_checkpoint(journal_t *journal
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
@@ -368,6 +391,7 @@ int log_do_checkpoint(journal_t *journal
 		cleanup_ret = __cleanup_transaction(journal, transaction);
 		J_ASSERT(drop_count != 0 || cleanup_ret != 0);
 	}
+finish:
 	spin_unlock(&journal->j_list_lock);
 	result = cleanup_journal_tail(journal);
 	if (result < 0)
diff -puN fs/jbd/commit.c~jbd-commit-tricks fs/jbd/commit.c

_

--=-=-=--

