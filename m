Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSFQGrO>; Mon, 17 Jun 2002 02:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSFQGrN>; Mon, 17 Jun 2002 02:47:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16142 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316770AbSFQGrM>;
	Mon, 17 Jun 2002 02:47:12 -0400
Message-ID: <3D0D86E0.15A3C5E2@zip.com.au>
Date: Sun, 16 Jun 2002 23:51:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/19] ext3 corruption fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen and Neil Brown recently worked this out.  It's a
rare situation which only affects data=journal mode.


Fix problem in data=journal mode where writeback could be left pending on a 
journaled, deleted disk block.  If that block then gets reallocated, we can 
end up with an alias in which the old data can be written back to disk over
the new.  Thanks to Neil Brown for spotting this and coming up with the
initial fix.


--- 2.5.22/fs/jbd/transaction.c~nb-fix	Sun Jun 16 22:50:16 2002
+++ 2.5.22-akpm/fs/jbd/transaction.c	Sun Jun 16 23:22:45 2002
@@ -1861,6 +1861,7 @@ static int journal_unmap_buffer(journal_
 		 * running transaction if that is set, but nothing
 		 * else. */
 		JBUFFER_TRACE(jh, "on committing transaction");
+		set_buffer_freed(bh);
 		if (jh->b_next_transaction) {
 			J_ASSERT(jh->b_next_transaction ==
 					journal->j_running_transaction);
--- 2.5.22/fs/jbd/commit.c~nb-fix	Sun Jun 16 22:50:16 2002
+++ 2.5.22-akpm/fs/jbd/commit.c	Sun Jun 16 22:50:16 2002
@@ -659,6 +659,20 @@ skip_commit:
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
+		if (buffer_freed(bh)) {
+			clear_buffer_freed(bh);
+			clear_buffer_jbddirty(bh);
+		}
+			
 		if (buffer_jdirty(bh)) {
 			JBUFFER_TRACE(jh, "add to new checkpointing trans");
 			__journal_insert_checkpoint(jh, commit_transaction);
--- 2.5.22/include/linux/jbd.h~nb-fix	Sun Jun 16 22:50:16 2002
+++ 2.5.22-akpm/include/linux/jbd.h	Sun Jun 16 22:50:16 2002
@@ -238,6 +238,7 @@ enum jbd_state_bits {
 BUFFER_FNS(JBD, jbd)
 BUFFER_FNS(JBDDirty, jbddirty)
 TAS_BUFFER_FNS(JBDDirty, jbddirty)
+BUFFER_FNS(Freed, freed)
 
 static inline struct buffer_head *jh2bh(struct journal_head *jh)
 {

-
