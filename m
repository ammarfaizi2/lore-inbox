Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422787AbWJPSYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422787AbWJPSYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422786AbWJPSYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:24:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45696 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422783AbWJPSYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:24:43 -0400
Message-ID: <4533CE69.6050409@redhat.com>
Date: Mon, 16 Oct 2006 13:24:41 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
Subject: [PATCH] jbd journal_dirty_data re-check for unmapped buffers
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running several fsx's and other filesystem stress tests, we found 
cases where an unmapped buffer was still being sent to submit_bh by the 
ext3 dirty data journaling code.

I saw this happen in two ways, both related to another thread doing a 
truncate which would unmap the buffer in question.

Either we would get into journal_dirty_data with a bh which was already 
unmapped (although journal_dirty_data_fn had checked for this earlier, 
the state was not locked at that point), or it would get unmapped in 
the middle of journal_dirty_data when we dropped locks to call 
sync_dirty_buffer.

By re-checking for mapped state after we've acquired the bh state lock, 
we should avoid these races.  If we find a buffer which is no longer 
mapped, we essentially ignore it, because journal_unmap_buffer has 
already decided that this buffer can go away.

I've also added tracepoints in these two cases, and made a couple other 
tracepoint changes that I found useful in debugging this.

Thanks,
-Eric

Signed-off-by: Eric Sandeen <esandeen@redhat.com>


Index: linux-2.6.18/fs/jbd/transaction.c
===================================================================
--- linux-2.6.18.orig/fs/jbd/transaction.c
+++ linux-2.6.18/fs/jbd/transaction.c
@@ -967,6 +967,13 @@ int journal_dirty_data(handle_t *handle,
 	 */
 	jbd_lock_bh_state(bh);
 	spin_lock(&journal->j_list_lock);
+
+	/* Now that we have bh_state locked, are we really still mapped? */
+	if (!buffer_mapped(bh)) {
+		JBUFFER_TRACE(jh, "unmapped buffer, bailing out");
+		goto no_journal;
+	}
+
 	if (jh->b_transaction) {
 		JBUFFER_TRACE(jh, "has transaction");
 		if (jh->b_transaction != handle->h_transaction) {
@@ -1028,6 +1035,11 @@ int journal_dirty_data(handle_t *handle,
 				sync_dirty_buffer(bh);
 				jbd_lock_bh_state(bh);
 				spin_lock(&journal->j_list_lock);
+				/* Since we dropped the lock... */
+				if (!buffer_mapped(bh)) {
+					JBUFFER_TRACE(jh, "buffer got unmapped");
+					goto no_journal;
+				}
 				/* The buffer may become locked again at any
 				   time if it is redirtied */
 			}
@@ -1823,6 +1835,7 @@ static int journal_unmap_buffer(journal_
 			}
 		}
 	} else if (transaction == journal->j_committing_transaction) {
+		JBUFFER_TRACE(jh, "on committing transaction");
 		if (jh->b_jlist == BJ_Locked) {
 			/*
 			 * The buffer is on the committing transaction's locked
@@ -1837,7 +1850,6 @@ static int journal_unmap_buffer(journal_
 		 * can remove it's next_transaction pointer from the
 		 * running transaction if that is set, but nothing
 		 * else. */
-		JBUFFER_TRACE(jh, "on committing transaction");
 		set_buffer_freed(bh);
 		if (jh->b_next_transaction) {
 			J_ASSERT(jh->b_next_transaction ==
@@ -1857,6 +1869,7 @@ static int journal_unmap_buffer(journal_
 		 * i_size already for this truncate so recovery will not
 		 * expose the disk blocks we are discarding here.) */
 		J_ASSERT_JH(jh, transaction == journal->j_running_transaction);
+		JBUFFER_TRACE(jh, "on running transaction");
 		may_free = __dispose_buffer(jh, transaction);
 	}
 


