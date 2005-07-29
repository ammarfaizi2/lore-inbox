Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVG2MgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVG2MgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 08:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVG2MgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 08:36:19 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:58810 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262590AbVG2MgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 08:36:15 -0400
Message-ID: <018101c5943a$1a07a5d0$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: <ext2-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: OOM problems still left in 2.6.13-rc3
Date: Fri, 29 Jul 2005 21:36:11 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All

In April 4, Andrew Morton posted a patch to fix a memory leak in
ext3.
http://marc.theaimsgroup.com/?l=linux-kernel&m=111257874912387&w=2
>The patch teaches journal_unmap_buffer() about buffers which are on
>the committing transaction's t_locked_list.  These buffers have been
>written and I/O has completed.  We can take them off the transaction
>and undirty them within the context of journal_invalidatepage()->
>journal_unmap_buffer().

Andrew's patch modifies JBD to delete pages which are connected to
t_locked_list and due to be truncated.  But how about pages on
t_sync_datalist?  I think these pages won't be deleted and left in
the LRU list.

The buffers connected to t_sync_datalist can't simply be removed like
the buffers connected to t_locked_list, since we don't know if the
I/O against the buffers are complete.

So we should wait until the committing transaction becomes complete
if there are any buffers connected to the transaction's
t_sync_datalist.

I made a patch to do the following.

a) If a buffer is connected to t_sync_datalist in the transaction
   (jh->b_jlist == BJ_SyncData) on journal_unmap_buffer(),
   journal_unmap_buffer() returns -1, so that caller can wait for the
   completion of the transaction.

b) If journal_unmap_buffer() returns -1 on journal_invalidatepages(),
   call log_wait_commit() to wait for the completion of the
   transaction, and retry to call journal_unmap_buffer() again.

Below is the comparison of the memory leak rate before and after this
fix.  We counted them from (Active+Inactive)-(Cached+Buffers+SwapCached
+Mapped), which are in /proc/meminfo.
---------------------------------------------------------------------
Linux 2.6.13-rc3 (including Andrew's patch):
  leaked-rate   = 4869 KB/h
  (leaked memory = 53564 KB, 11 hours)
  
My patch applied:
  leaked-rate   = 213 KB/h
  (leaked memory = 1492 KB, 7 hours) 
---------------------------------------------------------------------

Here is the patch against 2.6.13-rc3.

--- fs/jbd/transaction-org.c 2005-07-28 16:07:32.000000000 +0900
+++ fs/jbd/transaction.c 2005-07-28 16:08:30.000000000 +0900
@@ -1732,7 +1732,8 @@ static int __dispose_buffer(struct journ
  * We're outside-transaction here.  Either or both of j_running_transaction
  * and j_committing_transaction may be NULL.
  */
-static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh)
+static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
+ tid_t *wait_tid)
 {
  transaction_t *transaction;
  struct journal_head *jh;
@@ -1820,24 +1821,18 @@ static int journal_unmap_buffer(journal_
     */
    may_free = __dispose_buffer(jh, transaction);
    goto zap_buffer;
+  } else {
+   /* When the buffer is in t_sync_datalist,
+    * truncate must wait for this transaction on
+    * journal_invalidatepages, so return -1.
+    */
+   *wait_tid = transaction->t_tid;
+   journal_put_journal_head(jh);
+   spin_unlock(&journal->j_list_lock);
+   jbd_unlock_bh_state(bh);
+   spin_unlock(&journal->j_state_lock);
+   return -1;
   }
-  /*
-   * If it is committing, we simply cannot touch it.  We
-   * can remove it's next_transaction pointer from the
-   * running transaction if that is set, but nothing
-   * else. */
-  JBUFFER_TRACE(jh, "on committing transaction");
-  set_buffer_freed(bh);
-  if (jh->b_next_transaction) {
-   J_ASSERT(jh->b_next_transaction ==
-     journal->j_running_transaction);
-   jh->b_next_transaction = NULL;
-  }
-  journal_put_journal_head(jh);
-  spin_unlock(&journal->j_list_lock);
-  jbd_unlock_bh_state(bh);
-  spin_unlock(&journal->j_state_lock);
-  return 0;
  } else {
   /* Good, the buffer belongs to the running transaction.
    * We are writing our own transaction's data, not any
@@ -1882,6 +1877,8 @@ int journal_invalidatepage(journal_t *jo
  struct buffer_head *head, *bh, *next;
  unsigned int curr_off = 0;
  int may_free = 1;
+ tid_t wait_tid;
+ int ret;
 
  if (!PageLocked(page))
   BUG();
@@ -1899,8 +1896,19 @@ int journal_invalidatepage(journal_t *jo
 
   if (offset <= curr_off) {
     /* This block is wholly outside the truncation point */
+retry:
    lock_buffer(bh);
-   may_free &= journal_unmap_buffer(journal, bh);
+   ret = journal_unmap_buffer(journal, bh, &wait_tid);
+   /* When this buffer is in transaction of
+    * t_sync_datalist, truncate must wait for
+    * that transaction.
+    */
+   if (ret < 0) {
+    unlock_buffer(bh);
+    log_wait_commit(journal, wait_tid);
+    goto retry;
+   }
+   may_free &= ret;
    unlock_buffer(bh);
   }
   curr_off = next_off;

Any feedback and comments are welcome.

Best regards, Takashi Sato

