Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVAXV6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVAXV6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVAXV4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:56:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25270 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261606AbVAXVxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:53:24 -0500
Date: Mon, 24 Jan 2005 21:53:18 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: ext2-devel@lists.sourceforge.net, "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] Factor out phase 6 of journal_commit_transaction
Message-ID: <20050124215318.GP31455@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


journal_commit_transaction() is 720 lines long.  This patch pulls about
55 of them out into their own function, removes a goto and cleans up
the control flow a little.  It does not fix akpm's little note as that
requires a bit more understanding of how jbd works ...

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

--- linux-2.6/fs/jbd/commit.c	12 Jan 2005 20:17:26 -0000	1.12
+++ linux-2.6/fs/jbd/commit.c	24 Jan 2005 21:44:21 -0000
@@ -93,6 +93,73 @@ static int inverted_lock(journal_t *jour
 	return 1;
 }
 
+/* Done it all: now write the commit record.  We should have
+ * cleaned up our previous buffers by now, so if we are in abort
+ * mode we can now just skip the rest of the journal write
+ * entirely.
+ *
+ * Returns 1 if the journal needs to be aborted or 0 on success
+ */
+static int journal_write_commit_record(journal_t *journal,
+					transaction_t *commit_transaction)
+{
+	struct journal_head *descriptor;
+	struct buffer_head *bh;
+	int i, ret;
+	int barrier_done = 0;
+
+	if (is_journal_aborted(journal))
+		return 0;
+
+	descriptor = journal_get_descriptor_buffer(journal);
+	if (!descriptor)
+		return 1;
+
+	bh = jh2bh(descriptor);
+
+	/* AKPM: buglet - add `i' to tmp! */
+	for (i = 0; i < bh->b_size; i += 512) {
+		journal_header_t *tmp = (journal_header_t*)bh->b_data;
+		tmp->h_magic = cpu_to_be32(JFS_MAGIC_NUMBER);
+		tmp->h_blocktype = cpu_to_be32(JFS_COMMIT_BLOCK);
+		tmp->h_sequence = cpu_to_be32(commit_transaction->t_tid);
+	}
+
+	JBUFFER_TRACE(descriptor, "write commit block");
+	set_buffer_dirty(bh);
+	if (journal->j_flags & JFS_BARRIER) {
+		set_buffer_ordered(bh);
+		barrier_done = 1;
+	}
+	ret = sync_dirty_buffer(bh);
+	/* is it possible for another commit to fail at roughly
+	 * the same time as this one?  If so, we don't want to
+	 * trust the barrier flag in the super, but instead want
+	 * to remember if we sent a barrier request
+	 */
+	if (ret == -EOPNOTSUPP && barrier_done) {
+		char b[BDEVNAME_SIZE];
+
+		printk(KERN_WARNING
+			"JBD: barrier-based sync failed on %s - "
+			"disabling barriers\n",
+			bdevname(journal->j_dev, b));
+		spin_lock(&journal->j_state_lock);
+		journal->j_flags &= ~JFS_BARRIER;
+		spin_unlock(&journal->j_state_lock);
+
+		/* And try again, without the barrier */
+		clear_buffer_ordered(bh);
+		set_buffer_uptodate(bh);
+		set_buffer_dirty(bh);
+		ret = sync_dirty_buffer(bh);
+	}
+	put_bh(bh);		/* One for getblk() */
+	journal_put_journal_head(descriptor);
+
+	return (ret == -EIO);
+}
+
 /*
  * journal_commit_transaction
  *
@@ -616,78 +683,16 @@ wait_for_iobuf:
 
 	jbd_debug(3, "JBD: commit phase 6\n");
 
-	if (is_journal_aborted(journal))
-		goto skip_commit;
-
-	/* Done it all: now write the commit record.  We should have
-	 * cleaned up our previous buffers by now, so if we are in abort
-	 * mode we can now just skip the rest of the journal write
-	 * entirely. */
+	if (journal_write_commit_record(journal, commit_transaction))
+		err = -EIO;
 
-	descriptor = journal_get_descriptor_buffer(journal);
-	if (!descriptor) {
+	if (err)
 		__journal_abort_hard(journal);
-		goto skip_commit;
-	}
-
-	/* AKPM: buglet - add `i' to tmp! */
-	for (i = 0; i < jh2bh(descriptor)->b_size; i += 512) {
-		journal_header_t *tmp =
-			(journal_header_t*)jh2bh(descriptor)->b_data;
-		tmp->h_magic = cpu_to_be32(JFS_MAGIC_NUMBER);
-		tmp->h_blocktype = cpu_to_be32(JFS_COMMIT_BLOCK);
-		tmp->h_sequence = cpu_to_be32(commit_transaction->t_tid);
-	}
-
-	JBUFFER_TRACE(descriptor, "write commit block");
-	{
-		struct buffer_head *bh = jh2bh(descriptor);
-		int ret;
-		int barrier_done = 0;
-
-		set_buffer_dirty(bh);
-		if (journal->j_flags & JFS_BARRIER) {
-			set_buffer_ordered(bh);
-			barrier_done = 1;
-		}
-		ret = sync_dirty_buffer(bh);
-		/* is it possible for another commit to fail at roughly
-		 * the same time as this one?  If so, we don't want to
-		 * trust the barrier flag in the super, but instead want
-		 * to remember if we sent a barrier request
-		 */
-		if (ret == -EOPNOTSUPP && barrier_done) {
-			char b[BDEVNAME_SIZE];
-
-			printk(KERN_WARNING
-				"JBD: barrier-based sync failed on %s - "
-				"disabling barriers\n",
-				bdevname(journal->j_dev, b));
-			spin_lock(&journal->j_state_lock);
-			journal->j_flags &= ~JFS_BARRIER;
-			spin_unlock(&journal->j_state_lock);
-
-			/* And try again, without the barrier */
-			clear_buffer_ordered(bh);
-			set_buffer_uptodate(bh);
-			set_buffer_dirty(bh);
-			ret = sync_dirty_buffer(bh);
-		}
-		if (unlikely(ret == -EIO))
-			err = -EIO;
-		put_bh(bh);		/* One for getblk() */
-		journal_put_journal_head(descriptor);
-	}
 
 	/* End of a transaction!  Finally, we can do checkpoint
            processing: any buffers committed as a result of this
            transaction can be removed from any checkpoint list it was on
            before. */
-
-skip_commit: /* The journal should be unlocked by now. */
-
-	if (err)
-		__journal_abort_hard(journal);
 
 	jbd_debug(3, "JBD: commit phase 7\n");
 
-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
