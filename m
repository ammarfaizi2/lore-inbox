Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263124AbTCYR3m>; Tue, 25 Mar 2003 12:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263125AbTCYR2r>; Tue, 25 Mar 2003 12:28:47 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2172 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263128AbTCYR2c>; Tue, 25 Mar 2003 12:28:32 -0500
Date: Tue, 25 Mar 2003 17:39:40 GMT
Message-Id: <200303251739.h2PHdeLm006924@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 8/8] 2.4: Fix flushtime ordering on BUF_DIRTY list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[From Andrew Morton.]  Set the flushtime on committing buffers when they
are actually sent to the dirty list, not when they are first dirtied.
Avoids some starvation scenarios when the flushtimes on BUF_DIRTY get
out-of-order.

--- linux-2.4-ext3push/fs/jbd/transaction.c.=K0007=.orig	2003-03-25 10:59:15.000000000 +0000
+++ linux-2.4-ext3push/fs/jbd/transaction.c	2003-03-25 10:59:15.000000000 +0000
@@ -1138,7 +1138,6 @@ int journal_dirty_metadata (handle_t *ha
 	
 	spin_lock(&journal_datalist_lock);
 	set_bit(BH_JBDDirty, &bh->b_state);
-	set_buffer_flushtime(bh);
 
 	J_ASSERT_JH(jh, jh->b_transaction != NULL);
 	
@@ -2090,6 +2089,13 @@ void journal_file_buffer(struct journal_
 	spin_unlock(&journal_datalist_lock);
 }
 
+static void jbd_refile_buffer(struct buffer_head *bh)
+{
+	if (buffer_dirty(bh) && (bh->b_list != BUF_DIRTY))
+		set_buffer_flushtime(bh);
+	refile_buffer(bh);
+}
+
 /* 
  * Remove a buffer from its current buffer list in preparation for
  * dropping it from its current transaction entirely.  If the buffer has
@@ -2110,7 +2116,7 @@ void __journal_refile_buffer(struct jour
 		__journal_unfile_buffer(jh);
 		jh->b_transaction = NULL;
 		/* Onto BUF_DIRTY for writeback */
-		refile_buffer(jh2bh(jh));
+		jbd_refile_buffer(jh2bh(jh));
 		return;
 	}
 	
