Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVASPdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVASPdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 10:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVASPda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 10:33:30 -0500
Received: from [83.102.214.158] ([83.102.214.158]:15839 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261750AbVASPdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 10:33:16 -0500
From: Alex Tomas <alex@clusterfs.com>
Subject: [PATCH] JBD: journal_release_buffer()
To: linux-kernel@vger.kernel.org
CC: ext2-devel@lists.sourceforge.net, akpm@osdl.org, alex@clusterfs.com
Date: Wed, 19 Jan 2005 18:32:02 +0300
Message-ID: <m3wtu9v3il.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good day,

journal_release_buffer() can cause journal overflow in some
(very rare) conditions. Please, take a look at possible fix.

Th journal_head structure holds number of users of the buffer
for current transaction. The routines do_get_write_access()
and journal_get_create_access() tracks this number:
1) resets it to zero if the block's becoming part of the current
   transaction
2) increments it

journal_release_buffer() decrements it and if it's 0, then the
blocks isn't member of the transaction.

The patch has been tested on UP with dbench and tool that
uses xattr very much. 


Signed-off-by: Alex Tomas <alex@clusterfs.com>

Index: linux-2.6.7/include/linux/journal-head.h
===================================================================
--- linux-2.6.7.orig/include/linux/journal-head.h	2003-06-24 18:05:26.000000000 +0400
+++ linux-2.6.7/include/linux/journal-head.h	2005-01-19 14:09:59.000000000 +0300
@@ -80,6 +80,11 @@
 	 * [j_list_lock]
 	 */
 	struct journal_head *b_cpnext, *b_cpprev;
+
+	/*
+	 * counter to track users of the buffer in current transaction
+	 */
+	int b_tcount;
 };
 
 #endif		/* JOURNAL_HEAD_H_INCLUDED */
Index: linux-2.6.7/fs/jbd/transaction.c
===================================================================
--- linux-2.6.7.orig/fs/jbd/transaction.c	2004-08-26 17:12:40.000000000 +0400
+++ linux-2.6.7/fs/jbd/transaction.c	2005-01-19 17:23:30.058160408 +0300
@@ -611,6 +611,10 @@
 		handle->h_buffer_credits--;
 		if (credits)
 			(*credits)++;
+
+		/* the block's becoming member of the trasaction -bzzz */
+		jh->b_tcount = 0;
+
 		goto done;
 	}
 
@@ -694,6 +698,9 @@
 	if (credits)
 		(*credits)++;
 
+	/* the block's becoming member of the trasaction -bzzz */
+	jh->b_tcount = 0;
+
 	/*
 	 * Finally, if the buffer is not journaled right now, we need to make
 	 * sure it doesn't get written to disk before the caller actually
@@ -723,6 +730,11 @@
 		memcpy(jh->b_frozen_data, source+offset, jh2bh(jh)->b_size);
 		kunmap_atomic(source, KM_USER0);
 	}
+
+	/* track all references to the block to be able to recognize the
+	 * situation when the buffer is not part of transaction -bzzz */
+	jh->b_tcount++;
+
 	jbd_unlock_bh_state(bh);
 
 	/*
@@ -822,11 +834,20 @@
 		jh->b_transaction = transaction;
 		JBUFFER_TRACE(jh, "file as BJ_Reserved");
 		__journal_file_buffer(jh, transaction, BJ_Reserved);
+		jh->b_tcount = 0;
 	} else if (jh->b_transaction == journal->j_committing_transaction) {
 		JBUFFER_TRACE(jh, "set next transaction");
 		jh->b_next_transaction = transaction;
+		jh->b_tcount = 0;
 	}
 	spin_unlock(&journal->j_list_lock);
+
+	/*
+	 * track all reference to the block to be able to recognize
+	 * the situation when the buffer is not part of transaction -bzzz
+	 */
+	jh->b_tcount++;
+
 	jbd_unlock_bh_state(bh);
 
 	/*
@@ -1178,8 +1199,40 @@
 void
 journal_release_buffer(handle_t *handle, struct buffer_head *bh, int credits)
 {
+	journal_t *journal = handle->h_transaction->t_journal;
+	struct journal_head *jh = bh2jh(bh);
+
 	BUFFER_TRACE(bh, "entry");
-	handle->h_buffer_credits += credits;
+
+	/* return credit back to the handle if it was really spent */
+	if (credits)
+		handle->h_buffer_credits++; 
+
+	jbd_lock_bh_state(bh);
+	J_ASSERT(jh->b_tcount > 0);
+
+	jh->b_tcount--;
+	if (jh->b_tcount == 0) {
+		/* we can drop it from the transaction -bzzz */
+		J_ASSERT(jh->b_transaction == handle->h_transaction ||
+				jh->b_next_transaction == handle->h_transaction);
+		if (jh->b_transaction == handle->h_transaction) {
+			spin_lock(&journal->j_list_lock);
+			__journal_unfile_buffer(jh);
+			spin_unlock(&journal->j_list_lock);
+		} else if(jh->b_next_transaction) {
+			jh->b_next_transaction = NULL;
+		}
+
+		/* 
+		 * this was last reference to the block from the current
+		 * transaction and we'd like to return credit to the
+		 * whole transaction -bzzz
+		 */
+		if (!credits)
+			handle->h_buffer_credits++; 
+	}
+	jbd_unlock_bh_state(bh);
 }
 
 /** 

