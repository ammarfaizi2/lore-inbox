Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318883AbSH1PmK>; Wed, 28 Aug 2002 11:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318885AbSH1PlJ>; Wed, 28 Aug 2002 11:41:09 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:2947 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318879AbSH1PlG>; Wed, 28 Aug 2002 11:41:06 -0400
Date: Wed, 28 Aug 2002 16:45:20 +0100
Message-Id: <200208281545.g7SFjK214346@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 7/8] 2.4.20-pre4/ext3: Fix buffer alias problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix problem in data=journal mode where writeback could be left pending on a
journaled, deleted disk block.  If that block then gets reallocated, we can
end up with an alias in which the old data can be written back to disk over
the new.  Thanks to Neil Brown for spotting this and coming up with the
initial fix.

--- linux-ext3-2.4merge/fs/jbd/commit.c.=K0008=.orig	Tue Aug 27 23:16:07 2002
+++ linux-ext3-2.4merge/fs/jbd/commit.c	Tue Aug 27 23:19:57 2002
@@ -663,6 +663,20 @@
 		 * there's no point in keeping a checkpoint record for
 		 * it. */
 		bh = jh2bh(jh);
+
+		/* A buffer which has been freed while still being
+		 * journaled by a previous transaction may end up still
+		 * being dirty here, but we want to avoid writing back
+		 * that buffer in the future now that the last use has
+		 * been committed.  That's not only a performance gain,
+		 * it also stops aliasing problems if the buffer is left
+		 * behind for writeback and gets reallocated for another
+		 * use in a different page. */
+		if (__buffer_state(bh, Freed)) {
+			clear_bit(BH_Freed, &bh->b_state);
+			clear_bit(BH_JBDDirty, &bh->b_state);
+		}
+			
 		if (buffer_jdirty(bh)) {
 			JBUFFER_TRACE(jh, "add to new checkpointing trans");
 			__journal_insert_checkpoint(jh, commit_transaction);
