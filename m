Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751771AbWI1IcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWI1IcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 04:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWI1IcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 04:32:05 -0400
Received: from mga06.intel.com ([134.134.136.21]:41567 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751779AbWI1IcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 04:32:03 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,228,1157353200"; 
   d="scan'208"; a="137541176:sNHT21202209"
Subject: Re: [PATCH] Fix commit of ordered data buffers
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Jan Kara <jack@suse.cz>
Cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, fedora-ia64-list@redhat.com
In-Reply-To: <20060911210530.GA28445@atrey.karlin.mff.cuni.cz>
References: <20060911210530.GA28445@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Message-Id: <1159432266.20092.700.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 28 Sep 2006 16:31:06 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 05:05, Jan Kara wrote:
>   Hi Andrew,
> 
>   here is the patch that came out of the thread "set_page_buffer_dirty
> should skip unmapped buffers". It fixes several flaws in the code
> writing out ordered data buffers during commit. It definitely fixed the
> problem Badari was seeing with fsx-linux test.  Could you include it
> into -mm? Since there are quite complex interactions with other JBD code
> and the locking is kind of ugly, I'd leave it in -mm for a while whether
> some bug does not emerge ;). Thanks.
> 
> 								Honza
I also worked on it because I didn't know you were working on it until I
located the root cause and tried to check bugzilla.

I reviewed your patch.

+		if (!inverted_lock(journal, bh)) {
+			jbd_lock_bh_state(bh);
+			spin_lock(&journal->j_list_lock);
+		}
Should journal->j_list_lock be unlocked before jbd_lock_bh_state(bh)?


The fsx-linux test issue is a race between journal_commit_transaction
and journal_dirty_data. After journal_commit_transaction adds buffer_head pointers
to wbuf, it might unlock journal->j_list_lock. Although all buffer head in wbuf are locked,
does that prevent journal_dirty_data from unlinking the buffer head from the transaction
and fsx-linux from truncating it?

I'm not a journal expert. But I want to discuss it.

My investigation is below (Scenario):

fsx-linux starts journal_dirty_data and journal_dirty_data links a jh to
journal->j_running_transaction's t_sync_datalist, kjournald might not
write the buffer to disk quickly, but saves it to array wbuf.
Then, fsx-linux starts the second journal_dirty_data of a new transaction
might submit the same buffer head and move the jh to the new transaction's
t_sync_datalist.
Then, fsx-linux truncates the last a couple of buffers of a page.
Then, block_write_full_page calls invalidatepage to invalidate the last a couple
of buffers of the page, so the journal_heads of the buffer_head are unlinked and
are marked as unmapped.
Then, fsx-linux extend the file and does a msync after changing the page content
by mmaping the page, so the page (inclduing the last buffer head) is marked dirty
again.
Then, kjournald's journal_commit_transaction goes through wbuf to submit_bh all
dirty buffers, but one buffer head is already marked as unmapped. A bug check is
triggerred.

>From above scenario, as long as the late calls doesn't try to lock the buffer head,
the race condition still exists.

I think the right way is to let journal_dirty_data to wait till wbuf is flushed.

Below is my patch. Any idea?

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

diff -Nraup linux-2.6.18-rc7/fs/jbd/commit.c linux-2.6.18-rc7_jbd/fs/jbd/commit.c
--- linux-2.6.18-rc7/fs/jbd/commit.c	2006-09-20 08:57:12.000000000 +0800
+++ linux-2.6.18-rc7_jbd/fs/jbd/commit.c	2006-09-27 16:33:14.000000000 +0800
@@ -384,6 +384,8 @@ write_out_data:
 		spin_lock(&journal->j_list_lock);
 	}
 
+	wake_up(&journal->j_wait_commit_sync_datalist_free);
+
 	/*
 	 * Wait for all previously submitted IO to complete.
 	 */
diff -Nraup linux-2.6.18-rc7/fs/jbd/journal.c linux-2.6.18-rc7_jbd/fs/jbd/journal.c
--- linux-2.6.18-rc7/fs/jbd/journal.c	2006-09-20 08:57:12.000000000 +0800
+++ linux-2.6.18-rc7_jbd/fs/jbd/journal.c	2006-09-27 16:11:27.000000000 +0800
@@ -656,6 +656,7 @@ static journal_t * journal_init_common (
 
 	init_waitqueue_head(&journal->j_wait_transaction_locked);
 	init_waitqueue_head(&journal->j_wait_logspace);
+	init_waitqueue_head(&journal->j_wait_commit_sync_datalist_free);
 	init_waitqueue_head(&journal->j_wait_done_commit);
 	init_waitqueue_head(&journal->j_wait_checkpoint);
 	init_waitqueue_head(&journal->j_wait_commit);
diff -Nraup linux-2.6.18-rc7/fs/jbd/transaction.c linux-2.6.18-rc7_jbd/fs/jbd/transaction.c
--- linux-2.6.18-rc7/fs/jbd/transaction.c	2006-09-20 08:57:12.000000000 +0800
+++ linux-2.6.18-rc7_jbd/fs/jbd/transaction.c	2006-09-28 14:42:05.000000000 +0800
@@ -965,6 +965,8 @@ int journal_dirty_data(handle_t *handle,
 	 * never, ever allow this to happen: there's nothing we can do
 	 * about it in this layer.
 	 */
+
+repeat_ifcase2:
 	jbd_lock_bh_state(bh);
 	spin_lock(&journal->j_list_lock);
 	if (jh->b_transaction) {
@@ -1032,6 +1034,32 @@ int journal_dirty_data(handle_t *handle,
 				   time if it is redirtied */
 			}
 
+			if (jh->b_transaction != NULL &&
+				journal->j_committing_transaction ==
+				jh->b_transaction &&
+				jh->b_jlist == BJ_SyncData) {
+
+				wait_queue_head_t *queue_head;
+				spin_unlock(&journal->j_list_lock);
+				jbd_unlock_bh_state(bh);
+
+				if (need_brelse) {
+					BUFFER_TRACE(bh, "brelse");
+					__brelse(bh);
+					need_brelse = 0;
+				}
+
+				queue_head =
+				  &journal->j_wait_commit_sync_datalist_free;
+				wait_event(*queue_head,
+					!(jh->b_transaction != NULL &&
+					 journal->j_committing_transaction ==
+					 	jh->b_transaction &&
+					 jh->b_jlist == BJ_SyncData));
+
+				goto repeat_ifcase2;
+			}
+
 			/* journal_clean_data_list() may have got there first */
 			if (jh->b_transaction != NULL) {
 				JBUFFER_TRACE(jh, "unfile from commit");
diff -Nraup linux-2.6.18-rc7/include/linux/jbd.h linux-2.6.18-rc7_jbd/include/linux/jbd.h
--- linux-2.6.18-rc7/include/linux/jbd.h	2006-09-20 08:57:13.000000000 +0800
+++ linux-2.6.18-rc7_jbd/include/linux/jbd.h	2006-09-27 16:29:47.000000000 +0800
@@ -583,6 +583,8 @@ struct transaction_s 
  * @j_wait_transaction_locked: Wait queue for waiting for a locked transaction
  *  to start committing, or for a barrier lock to be released
  * @j_wait_logspace: Wait queue for waiting for checkpointing to complete
+ * @j_wait_commit_sync_datalist_free: Wait queue for waiting for commit
+ *  transaction sync_datalist becomes null
  * @j_wait_done_commit: Wait queue for waiting for commit to complete 
  * @j_wait_checkpoint:  Wait queue to trigger checkpointing
  * @j_wait_commit: Wait queue to trigger commit
@@ -686,6 +688,12 @@ struct journal_s
 	/* Wait queue for waiting for checkpointing to complete */
 	wait_queue_head_t	j_wait_logspace;
 
+	/*
+	 * Wait queue for waiting for commit transaction
+	 * sync_datalist becomes null
+	 */
+	wait_queue_head_t	j_wait_commit_sync_datalist_free;
+
 	/* Wait queue for waiting for commit to complete */
 	wait_queue_head_t	j_wait_done_commit;
 
