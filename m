Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVCYVZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVCYVZG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVCYVX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:23:59 -0500
Received: from mail.dif.dk ([193.138.115.101]:32179 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261810AbVCYVXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:23:06 -0500
Date: Fri, 25 Mar 2005 22:25:00 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill off redundant NULL checks before kfree() in fs/jbd/
Message-ID: <Pine.LNX.4.62.0503252222440.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No need to check for NULL before calling kfree().

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/fs/jbd/commit.c	2005-03-25 15:28:59.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/jbd/commit.c	2005-03-25 21:38:48.000000000 +0100
@@ -261,10 +261,8 @@ void journal_commit_transaction(journal_
 			struct buffer_head *bh = jh2bh(jh);
 
 			jbd_lock_bh_state(bh);
-			if (jh->b_committed_data) {
-				kfree(jh->b_committed_data);
-				jh->b_committed_data = NULL;
-			}
+			kfree(jh->b_committed_data);
+			jh->b_committed_data = NULL;
 			jbd_unlock_bh_state(bh);
 		}
 		journal_refile_buffer(journal, jh);
--- linux-2.6.12-rc1-mm3-orig/fs/jbd/transaction.c	2005-03-25 15:28:59.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/jbd/transaction.c	2005-03-25 21:40:35.000000000 +0100
@@ -227,8 +227,7 @@ repeat_locked:
 	spin_unlock(&transaction->t_handle_lock);
 	spin_unlock(&journal->j_state_lock);
 out:
-	if (new_transaction)
-		kfree(new_transaction);
+	kfree(new_transaction);
 	return ret;
 }
 
@@ -722,8 +721,7 @@ done:
 	journal_cancel_revoke(handle, jh);
 
 out:
-	if (frozen_buffer)
-		kfree(frozen_buffer);
+	kfree(frozen_buffer);
 
 	JBUFFER_TRACE(jh, "exit");
 	return error;
@@ -902,8 +900,7 @@ repeat:
 	jbd_unlock_bh_state(bh);
 out:
 	journal_put_journal_head(jh);
-	if (committed_data)
-		kfree(committed_data);
+	kfree(committed_data);
 	return err;
 }
 


