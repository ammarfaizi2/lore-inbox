Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVASPfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVASPfQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 10:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVASPeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 10:34:07 -0500
Received: from [83.102.214.158] ([83.102.214.158]:16351 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261752AbVASPdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 10:33:18 -0500
From: Alex Tomas <alex@clusterfs.com>
Subject: [PATCH] JBD: log space management optimization
To: linux-kernel@vger.kernel.org
CC: ext2-devel@lists.sourceforge.net, akpm@osdl.org, alex@clusterfs.com
Date: Wed, 19 Jan 2005 18:32:16 +0300
Message-ID: <m3llapv3i7.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good day,

during truncate ext3 calls journal_forget() for freed blocks, but
before these blocks go to the transaction and jbd reserves space
in log for them (->t_outstanding_credits). also, journal_forget()
removes these blocks from the transaction, but doesn't correct
log space reservation. for example, removal of 500MB file reserves
136 blocks, but only 10 blocks go to the log. a commit is expensive
and correct reservation allows us to avoid needless commits. here
is the patch. tested on UP.

thanks, Alex


Signed-off-by: Alex Tomas <alex@clusterfs.com>

Index: linux-2.6.7/fs/jbd/transaction.c
===================================================================
--- linux-2.6.7.orig/fs/jbd/transaction.c	2004-08-26 17:12:40.000000000 +0400
+++ linux-2.6.7/fs/jbd/transaction.c	2005-01-19 17:23:30.058160408 +0300
@@ -1204,6 +1257,7 @@
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal = transaction->t_journal;
 	struct journal_head *jh;
+	int drop_reserve = 0;
 
 	BUFFER_TRACE(bh, "entry");
 
@@ -1227,6 +1281,7 @@
 		J_ASSERT_JH(jh, !jh->b_committed_data);
 
 		__journal_unfile_buffer(jh);
+		drop_reserve = 1;
 
 		/* 
 		 * We are no longer going to journal this buffer.
@@ -1249,7 +1304,7 @@
 				spin_unlock(&journal->j_list_lock);
 				jbd_unlock_bh_state(bh);
 				__bforget(bh);
-				return;
+				goto drop;
 			}
 		}
 	} else if (jh->b_transaction) {
@@ -1264,6 +1319,7 @@
 		if (jh->b_next_transaction) {
 			J_ASSERT(jh->b_next_transaction == transaction);
 			jh->b_next_transaction = NULL;
+			drop_reserve = 1;
 		}
 	}
 
@@ -1271,6 +1327,15 @@
 	spin_unlock(&journal->j_list_lock);
 	jbd_unlock_bh_state(bh);
 	__brelse(bh);
+
+drop:
+	if (drop_reserve) {
+		/* no need to reserve log space for this block -bzzz */
+		spin_lock(&transaction->t_handle_lock);
+		transaction->t_outstanding_credits--;
+		spin_unlock(&transaction->t_handle_lock);
+	}
+
 	return;
 }
 

