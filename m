Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVGKPhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVGKPhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVGKPem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:34:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11970 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261976AbVGKPeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:34:20 -0400
Date: Mon, 11 Jul 2005 17:34:15 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@osdl.org
Subject: [PATCH] Fix JBD race in t_forget list handling
Message-ID: <20050711153415.GP12428@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello all,

  attached patch should close the possible race between
journal_commit_transaction() and journal_unmap_buffer() (which adds
buffers to committing transaction's t_forget list) that could leave
some buffers on transaction's t_forget list (hence leading to an
assertion failure later when transaction is dropped). The patch is
against 2.6.13-rc2 kernel.  The race was really happening to David Wilk
<davidwilk@gmail.com> (thanks for testing) so please apply if you find
the patch correct.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.13-rc2-1-forgetfix.diff"

Fix race between journal_commit_transaction() and other places as
journal_unmap_buffer() that are adding buffers to transaction's t_forget
list. We have to protect against such places by holding j_list_lock even when
traversing the t_forget list. The fact that other places can only add buffers
to the list makes the locking easier. OTOH the lock ranking complicates
the stuff...

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rup -x*.o -x.* linux-2.6.13-rc2/fs/jbd/commit.c linux-2.6.13-rc2-1-forgetfix/fs/jbd/commit.c
--- linux-2.6.13-rc2/fs/jbd/commit.c	Fri Jun 24 16:27:10 2005
+++ linux-2.6.13-rc2-1-forgetfix/fs/jbd/commit.c	Mon Jul 11 17:20:48 2005
@@ -720,11 +720,17 @@ wait_for_iobuf:
 	J_ASSERT(commit_transaction->t_log_list == NULL);
 
 restart_loop:
+	/*
+	 * As there are other places (journal_unmap_buffer()) adding buffers
+	 * to this list we have to be careful and hold the j_list_lock.
+	 */
+	spin_lock(&journal->j_list_lock);
 	while (commit_transaction->t_forget) {
 		transaction_t *cp_transaction;
 		struct buffer_head *bh;
 
 		jh = commit_transaction->t_forget;
+		spin_unlock(&journal->j_list_lock);
 		bh = jh2bh(jh);
 		jbd_lock_bh_state(bh);
 		J_ASSERT_JH(jh,	jh->b_transaction == commit_transaction ||
@@ -792,9 +798,25 @@ restart_loop:
 			journal_remove_journal_head(bh);  /* needs a brelse */
 			release_buffer_page(bh);
 		}
+		cond_resched_lock(&journal->j_list_lock);
+	}
+	spin_unlock(&journal->j_list_lock);
+	/*
+	 * This is a bit sleazy.  We borrow j_list_lock to protect
+	 * journal->j_committing_transaction in __journal_remove_checkpoint.
+	 * Really, __journal_remove_checkpoint should be using j_state_lock but
+	 * it's a bit hassle to hold that across __journal_remove_checkpoint
+	 */
+	spin_lock(&journal->j_state_lock);
+	spin_lock(&journal->j_list_lock);
+	/*
+	 * Now recheck if some buffers did not get attached to the transaction
+	 * while the lock was dropped...
+	 */
+	if (commit_transaction->t_forget) {
 		spin_unlock(&journal->j_list_lock);
-		if (cond_resched())
-			goto restart_loop;
+		spin_unlock(&journal->j_state_lock);
+		goto restart_loop;
 	}
 
 	/* Done with this transaction! */
@@ -803,14 +825,6 @@ restart_loop:
 
 	J_ASSERT(commit_transaction->t_state == T_COMMIT);
 
-	/*
-	 * This is a bit sleazy.  We borrow j_list_lock to protect
-	 * journal->j_committing_transaction in __journal_remove_checkpoint.
-	 * Really, __jornal_remove_checkpoint should be using j_state_lock but
-	 * it's a bit hassle to hold that across __journal_remove_checkpoint
-	 */
-	spin_lock(&journal->j_state_lock);
-	spin_lock(&journal->j_list_lock);
 	commit_transaction->t_state = T_FINISHED;
 	J_ASSERT(commit_transaction == journal->j_committing_transaction);
 	journal->j_commit_sequence = commit_transaction->t_tid;

--IS0zKkzwUGydFO0o--
