Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUEUXma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUEUXma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUEUXl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:41:26 -0400
Received: from zeus.kernel.org ([204.152.189.113]:30391 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262380AbUEUXXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:23:08 -0400
Date: Thu, 20 May 2004 00:14:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: 2.6.6-mm4: missing symbol __log_start_commit in ext3.o
Message-Id: <20040520001432.0f466182.akpm@osdl.org>
In-Reply-To: <20040519151913.47070.qmail@web13906.mail.yahoo.com>
References: <20040519151913.47070.qmail@web13906.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch <knobi@knobisoft.de> wrote:
>
> Hi,
> 
>  ext3 complains about a missing symbol in 2.6.6.-mm4:
> 
>   SPLIT   include/linux/autoconf.h -> include/config/*
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CC [M]  fs/ext3/balloc.o
>   LD [M]  fs/ext3/ext3.o
>   Building modules, stage 2.
>   MODPOST
> *** Warning: "__log_start_commit" [fs/ext3/ext3.ko] undefined!
> 

Ah, we forgot to export that symbol.

Actually that patch is being a bit naughty playing with JBD internals - it
should be cast as a JBD entrypoint.

This isn't runtime-tested:




---

 25-akpm/fs/ext3/balloc.c    |   28 ++--------------------------
 25-akpm/fs/jbd/journal.c    |   34 ++++++++++++++++++++++++++++++++++
 25-akpm/include/linux/jbd.h |    1 +
 3 files changed, 37 insertions(+), 26 deletions(-)

diff -puN fs/jbd/journal.c~ext3-retry-allocation-after-transaction-commit-v2-jbd-api fs/jbd/journal.c
--- 25/fs/jbd/journal.c~ext3-retry-allocation-after-transaction-commit-v2-jbd-api	2004-05-20 00:04:58.390761800 -0700
+++ 25-akpm/fs/jbd/journal.c	2004-05-20 00:11:04.682077056 -0700
@@ -73,6 +73,7 @@ EXPORT_SYMBOL(journal_ack_err);
 EXPORT_SYMBOL(journal_clear_err);
 EXPORT_SYMBOL(log_wait_commit);
 EXPORT_SYMBOL(journal_start_commit);
+EXPORT_SYMBOL(journal_force_commit_nested);
 EXPORT_SYMBOL(journal_wipe);
 EXPORT_SYMBOL(journal_blocks_per_page);
 EXPORT_SYMBOL(journal_invalidatepage);
@@ -465,6 +466,39 @@ int log_start_commit(journal_t *journal,
 }
 
 /*
+ * Force and wait upon a commit if the calling process is not within
+ * transaction.  This is used for forcing out undo-protected data which contains
+ * bitmaps, when the fs is running out of space.
+ *
+ * We can only force the running transaction if we don't have an active handle;
+ * otherwise, we will deadlock.
+ *
+ * Returns true if a transaction was started.
+ */
+int journal_force_commit_nested(journal_t *journal)
+{
+	transaction_t *transaction = NULL;
+	tid_t tid;
+
+	spin_lock(&journal->j_state_lock);
+	if (journal->j_running_transaction && !current->journal_info) {
+		transaction = journal->j_running_transaction;
+		__log_start_commit(journal, transaction->t_tid);
+	} else if (journal->j_committing_transaction)
+		transaction = journal->j_committing_transaction;
+
+	if (!transaction) {
+		spin_unlock(&journal->j_state_lock);
+		return 0;	/* Nothing to retry */
+	}
+
+	tid = transaction->t_tid;
+	spin_unlock(&journal->j_state_lock);
+	log_wait_commit(journal, tid);
+	return 1;
+}
+
+/*
  * Start a commit of the current running transaction (if any).  Returns true
  * if a transaction was started, and fills its tid in at *ptid
  */
diff -puN fs/ext3/balloc.c~ext3-retry-allocation-after-transaction-commit-v2-jbd-api fs/ext3/balloc.c
--- 25/fs/ext3/balloc.c~ext3-retry-allocation-after-transaction-commit-v2-jbd-api	2004-05-20 00:04:58.411758608 -0700
+++ 25-akpm/fs/ext3/balloc.c	2004-05-20 00:12:10.623052504 -0700
@@ -977,43 +977,19 @@ static int ext3_has_free_blocks(struct e
 }
 
 /*
- * Ext3_should_retry_alloc is called when ENOSPC is returned, and if
+ * ext3_should_retry_alloc() is called when ENOSPC is returned, and if
  * it is profitable to retry the operation, this function will wait
  * for the current or commiting transaction to complete, and then
  * return TRUE.
  */
 int ext3_should_retry_alloc(struct super_block *sb, int *retries)
 {
-	transaction_t *transaction = NULL;
-	journal_t *journal = EXT3_SB(sb)->s_journal;
-	tid_t tid;
-
 	if (!ext3_has_free_blocks(EXT3_SB(sb)) || (*retries)++ > 3)
 		return 0;
 
 	jbd_debug(1, "%s: retrying operation after ENOSPC\n", sb->s_id);
 
-	/*
-	 * We can only force the running transaction if we don't have
-	 * an active handle; otherwise, we will deadlock.
-	 */
-	spin_lock(&journal->j_state_lock);
-	if (journal->j_running_transaction && !current->journal_info) {
-		transaction = journal->j_running_transaction;
-		__log_start_commit(journal, transaction->t_tid);
-	} else if (journal->j_committing_transaction)
-		transaction = journal->j_committing_transaction;
-
-	if (!transaction) {
-		spin_unlock(&journal->j_state_lock);
-		return 0;	/* Nothing to retry */
-	}
-
-	tid = transaction->t_tid;
-	spin_unlock(&journal->j_state_lock);
-	log_wait_commit(journal, tid);
-
-	return 1;
+	return journal_force_commit_nested(EXT3_SB(sb)->s_journal);
 }
 
 /*
diff -puN include/linux/jbd.h~ext3-retry-allocation-after-transaction-commit-v2-jbd-api include/linux/jbd.h
--- 25/include/linux/jbd.h~ext3-retry-allocation-after-transaction-commit-v2-jbd-api	2004-05-20 00:11:09.466349736 -0700
+++ 25-akpm/include/linux/jbd.h	2004-05-20 00:11:33.140750680 -0700
@@ -1006,6 +1006,7 @@ int __log_space_left(journal_t *); /* Ca
 int log_start_commit(journal_t *journal, tid_t tid);
 int __log_start_commit(journal_t *journal, tid_t tid);
 int journal_start_commit(journal_t *journal, tid_t *tid);
+int journal_force_commit_nested(journal_t *journal);
 int log_wait_commit(journal_t *journal, tid_t tid);
 int log_do_checkpoint(journal_t *journal);
 

_


