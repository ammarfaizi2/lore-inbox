Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVA3K6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVA3K6H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 05:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVA3K5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 05:57:51 -0500
Received: from [83.102.214.158] ([83.102.214.158]:15290 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261671AbVA3K5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 05:57:25 -0500
X-Comment-To: "Stephen C. Tweedie"
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Ext2-devel] [PATCH] JBD: journal_release_buffer()
References: <m3wtu9v3il.fsf@bzzz.home.net>
	<1106604342.2103.395.camel@sisko.sctweedie.blueyonder.co.uk>
	<m3brbebh43.fsf@bzzz.home.net>
	<1106609725.2103.616.camel@sisko.sctweedie.blueyonder.co.uk>
	<m3sm4p8tk7.fsf@bzzz.home.net>
	<1106670089.1985.766.camel@sisko.sctweedie.blueyonder.co.uk>
	<m3k6q18fwt.fsf@bzzz.home.net>
	<1106759535.1953.53.camel@sisko.sctweedie.blueyonder.co.uk>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Sun, 30 Jan 2005 13:55:40 +0300
Message-ID: <m3vf9ffaoj.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Stephen C Tweedie (SCT) writes:

 SCT> Hi,
 SCT> On Tue, 2005-01-25 at 19:30, Alex Tomas wrote:

 >> >> journal_dirty_metadata(handle, bh)
 >> >> {
 >> >>     transaction->t_reserved--;
 >> >>     handle->h_buffer_credits--;
 >> >>     if (jh->b_tcount > 0) {
 >> >>         /* modifed, no need to track it any more */
 >> >>          transaction-> t_outstanding_credits++;
 >> >>        jh-> b_tcount = -1;
 >> >>      }
 >> >> }
 >> 
 SCT> Actually, the whole thing can be wrapped in if (jh->b_tcount > 0) {}, I
 SCT> think.

 >> the idea is:
 >> 1) the sooner we drop reservation, the higher probability to cover many
 >> changes by single transaction

 SCT> But that's exactly why we _don't_ want to do this.  You're dropping the
 SCT> reservation, but remember, we return unused handle credits to the
 SCT> transaction at the end of the handle's life.

yup, you're right. so, here is an implementation of this.
tested on UP/SMP by dbench/fsx. Stephen, Andrew, could you
review the patch and give it a run? 

thanks, Alex


fix against credits leak in journal_release_buffer()

The idea is to charge a buffer in journal_dirty_metadata(),
not in journal_get_*_access()). Each buffer has flag call
journal_dirty_metadata() sets on the buffer.

Signed-off-by: Alex Tomas <alex@clusterfs.com>

Index: linux-2.6.10/include/linux/journal-head.h
===================================================================
--- linux-2.6.10.orig/include/linux/journal-head.h	2003-06-24 18:05:26.000000000 +0400
+++ linux-2.6.10/include/linux/journal-head.h	2005-01-29 03:20:05.000000000 +0300
@@ -32,6 +32,13 @@
 	unsigned b_jlist;
 
 	/*
+	 * This flag signals the buffer has been modified by
+	 * the currently running transaction
+	 * [jbd_lock_bh_state()]
+	 */
+	unsigned b_modified;
+
+	/*
 	 * Copy of the buffer data frozen for writing to the log.
 	 * [jbd_lock_bh_state()]
 	 */
Index: linux-2.6.10/include/linux/ext3_jbd.h
===================================================================
--- linux-2.6.10.orig/include/linux/ext3_jbd.h	2005-01-28 19:32:15.000000000 +0300
+++ linux-2.6.10/include/linux/ext3_jbd.h	2005-01-29 03:13:41.000000000 +0300
@@ -113,9 +113,9 @@
 
 static inline int
 __ext3_journal_get_undo_access(const char *where, handle_t *handle,
-				struct buffer_head *bh, int *credits)
+				struct buffer_head *bh)
 {
-	int err = journal_get_undo_access(handle, bh, credits);
+	int err = journal_get_undo_access(handle, bh);
 	if (err)
 		ext3_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
 	return err;
@@ -123,19 +123,18 @@
 
 static inline int
 __ext3_journal_get_write_access(const char *where, handle_t *handle,
-				struct buffer_head *bh, int *credits)
+				struct buffer_head *bh)
 {
-	int err = journal_get_write_access(handle, bh, credits);
+	int err = journal_get_write_access(handle, bh);
 	if (err)
 		ext3_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
 	return err;
 }
 
 static inline void
-ext3_journal_release_buffer(handle_t *handle, struct buffer_head *bh,
-				int credits)
+ext3_journal_release_buffer(handle_t *handle, struct buffer_head *bh)
 {
-	journal_release_buffer(handle, bh, credits);
+	journal_release_buffer(handle, bh);
 }
 
 static inline void
@@ -175,12 +174,10 @@
 }
 
 
-#define ext3_journal_get_undo_access(handle, bh, credits) \
-	__ext3_journal_get_undo_access(__FUNCTION__, (handle), (bh), (credits))
+#define ext3_journal_get_undo_access(handle, bh) \
+	__ext3_journal_get_undo_access(__FUNCTION__, (handle), (bh))
 #define ext3_journal_get_write_access(handle, bh) \
-	__ext3_journal_get_write_access(__FUNCTION__, (handle), (bh), NULL)
-#define ext3_journal_get_write_access_credits(handle, bh, credits) \
-	__ext3_journal_get_write_access(__FUNCTION__, (handle), (bh), (credits))
+	__ext3_journal_get_write_access(__FUNCTION__, (handle), (bh))
 #define ext3_journal_revoke(handle, blocknr, bh) \
 	__ext3_journal_revoke(__FUNCTION__, (handle), (blocknr), (bh))
 #define ext3_journal_get_create_access(handle, bh) \
Index: linux-2.6.10/include/linux/jbd.h
===================================================================
--- linux-2.6.10.orig/include/linux/jbd.h	2005-01-28 19:32:15.000000000 +0300
+++ linux-2.6.10/include/linux/jbd.h	2005-01-29 03:13:41.000000000 +0300
@@ -865,15 +865,12 @@
 extern handle_t *journal_start(journal_t *, int nblocks);
 extern int	 journal_restart (handle_t *, int nblocks);
 extern int	 journal_extend (handle_t *, int nblocks);
-extern int	 journal_get_write_access(handle_t *, struct buffer_head *,
-						int *credits);
+extern int	 journal_get_write_access(handle_t *, struct buffer_head *);
 extern int	 journal_get_create_access (handle_t *, struct buffer_head *);
-extern int	 journal_get_undo_access(handle_t *, struct buffer_head *,
-						int *credits);
+extern int	 journal_get_undo_access(handle_t *, struct buffer_head *);
 extern int	 journal_dirty_data (handle_t *, struct buffer_head *);
 extern int	 journal_dirty_metadata (handle_t *, struct buffer_head *);
-extern void	 journal_release_buffer (handle_t *, struct buffer_head *,
-						int credits);
+extern void	 journal_release_buffer (handle_t *, struct buffer_head *);
 extern void	 journal_forget (handle_t *, struct buffer_head *);
 extern void	 journal_sync_buffer (struct buffer_head *);
 extern int	 journal_invalidatepage(journal_t *,
Index: linux-2.6.10/fs/jbd/transaction.c
===================================================================
--- linux-2.6.10.orig/fs/jbd/transaction.c	2005-01-28 19:32:12.000000000 +0300
+++ linux-2.6.10/fs/jbd/transaction.c	2005-01-29 03:21:52.000000000 +0300
@@ -522,7 +522,7 @@
  */
 static int
 do_get_write_access(handle_t *handle, struct journal_head *jh,
-			int force_copy, int *credits) 
+			int force_copy) 
 {
 	struct buffer_head *bh;
 	transaction_t *transaction;
@@ -604,11 +604,6 @@
 		JBUFFER_TRACE(jh, "has frozen data");
 		J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
 		jh->b_next_transaction = transaction;
-
-		J_ASSERT_JH(jh, handle->h_buffer_credits > 0);
-		handle->h_buffer_credits--;
-		if (credits)
-			(*credits)++;
 		goto done;
 	}
 
@@ -688,10 +683,6 @@
 		jh->b_next_transaction = transaction;
 	}
 
-	J_ASSERT(handle->h_buffer_credits > 0);
-	handle->h_buffer_credits--;
-	if (credits)
-		(*credits)++;
 
 	/*
 	 * Finally, if the buffer is not journaled right now, we need to make
@@ -749,8 +740,7 @@
  * because we're write()ing a buffer which is also part of a shared mapping.
  */
 
-int journal_get_write_access(handle_t *handle,
-			struct buffer_head *bh, int *credits)
+int journal_get_write_access(handle_t *handle, struct buffer_head *bh)
 {
 	struct journal_head *jh = journal_add_journal_head(bh);
 	int rc;
@@ -758,7 +748,7 @@
 	/* We do not want to get caught playing with fields which the
 	 * log thread also manipulates.  Make sure that the buffer
 	 * completes any outstanding IO before proceeding. */
-	rc = do_get_write_access(handle, jh, 0, credits);
+	rc = do_get_write_access(handle, jh, 0);
 	journal_put_journal_head(jh);
 	return rc;
 }
@@ -814,9 +804,6 @@
 	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
 	J_ASSERT_JH(jh, buffer_locked(jh2bh(jh)));
 
-	J_ASSERT_JH(jh, handle->h_buffer_credits > 0);
-	handle->h_buffer_credits--;
-
 	if (jh->b_transaction == NULL) {
 		jh->b_transaction = transaction;
 		JBUFFER_TRACE(jh, "file as BJ_Reserved");
@@ -869,8 +856,7 @@
  *
  * Returns error number or 0 on success.
  */
-int journal_get_undo_access(handle_t *handle, struct buffer_head *bh,
-				int *credits)
+int journal_get_undo_access(handle_t *handle, struct buffer_head *bh)
 {
 	int err;
 	struct journal_head *jh = journal_add_journal_head(bh);
@@ -883,7 +869,7 @@
 	 * make sure that obtaining the committed_data is done
 	 * atomically wrt. completion of any outstanding commits.
 	 */
-	err = do_get_write_access(handle, jh, 1, credits);
+	err = do_get_write_access(handle, jh, 1);
 	if (err)
 		goto out;
 
@@ -1111,6 +1097,17 @@
 
 	jbd_lock_bh_state(bh);
 
+	if (jh->b_modified == 0) {
+		/*
+		 * This buffer's got modified and becoming part
+		 * of the transaction. This needs to be done
+		 * once a transaction -bzzz
+		 */
+		jh->b_modified = 1;
+		J_ASSERT_JH(jh, handle->h_buffer_credits > 0);
+		handle->h_buffer_credits--;
+	}
+
 	/*
 	 * fastpath, to avoid expensive locking.  If this buffer is already
 	 * on the running transaction's metadata list there is nothing to do.
@@ -1161,24 +1158,11 @@
  * journal_release_buffer: undo a get_write_access without any buffer
  * updates, if the update decided in the end that it didn't need access.
  *
- * The caller passes in the number of credits which should be put back for
- * this buffer (zero or one).
- *
- * We leave the buffer attached to t_reserved_list because even though this
- * handle doesn't want it, some other concurrent handle may want to journal
- * this buffer.  If that handle is curently in between get_write_access() and
- * journal_dirty_metadata() then it expects the buffer to be reserved.  If
- * we were to rip it off t_reserved_list here, the other handle will explode
- * when journal_dirty_metadata is presented with a non-reserved buffer.
- *
- * If nobody really wants to journal this buffer then it will be thrown
- * away at the start of commit.
  */
 void
-journal_release_buffer(handle_t *handle, struct buffer_head *bh, int credits)
+journal_release_buffer(handle_t *handle, struct buffer_head *bh)
 {
 	BUFFER_TRACE(bh, "entry");
-	handle->h_buffer_credits += credits;
 }
 
 /** 
@@ -1213,6 +1197,12 @@
 		goto not_jbd;
 	jh = bh2jh(bh);
 
+	/*
+	 * The buffer's going from the transaction, we must drop
+	 * all references -bzzz
+	 */
+	jh->b_modified = 0;
+
 	if (jh->b_transaction == handle->h_transaction) {
 		J_ASSERT_JH(jh, !jh->b_frozen_data);
 
Index: linux-2.6.10/fs/jbd/commit.c
===================================================================
--- linux-2.6.10.orig/fs/jbd/commit.c	2005-01-28 19:32:12.000000000 +0300
+++ linux-2.6.10/fs/jbd/commit.c	2005-01-29 03:32:24.000000000 +0300
@@ -229,6 +229,22 @@
 	jbd_debug (3, "JBD: commit phase 2\n");
 
 	/*
+	 * First, drop modified flag: all accesses to the buffers
+	 * will be tracked for a new trasaction only -bzzz
+	 */
+	spin_lock(&journal->j_list_lock);
+	if (commit_transaction->t_buffers) {
+		new_jh = jh = commit_transaction->t_buffers->b_tnext;
+		do {
+			J_ASSERT_JH(new_jh, new_jh->b_modified == 1 ||
+					new_jh->b_modified == 0);
+			new_jh->b_modified = 0;
+			new_jh = new_jh->b_tnext;
+		} while (new_jh != jh);
+	}
+	spin_unlock(&journal->j_list_lock);
+
+	/*
 	 * Now start flushing things to disk, in the order they appear
 	 * on the transaction lists.  Data blocks go first.
 	 */
Index: linux-2.6.10/fs/ext3/balloc.c
===================================================================
--- linux-2.6.10.orig/fs/ext3/balloc.c	2005-01-28 19:32:12.000000000 +0300
+++ linux-2.6.10/fs/ext3/balloc.c	2005-01-29 03:13:41.000000000 +0300
@@ -342,7 +342,7 @@
 	 */
 	/* @@@ check errors */
 	BUFFER_TRACE(bitmap_bh, "getting undo access");
-	err = ext3_journal_get_undo_access(handle, bitmap_bh, NULL);
+	err = ext3_journal_get_undo_access(handle, bitmap_bh);
 	if (err)
 		goto error_return;
 
@@ -986,7 +986,6 @@
 	unsigned long group_first_block;
 	int ret = 0;
 	int fatal;
-	int credits = 0;
 
 	*errp = 0;
 
@@ -996,7 +995,7 @@
 	 * if the buffer is in BJ_Forget state in the committing transaction.
 	 */
 	BUFFER_TRACE(bitmap_bh, "get undo access for new block");
-	fatal = ext3_journal_get_undo_access(handle, bitmap_bh, &credits);
+	fatal = ext3_journal_get_undo_access(handle, bitmap_bh);
 	if (fatal) {
 		*errp = fatal;
 		return -1;
@@ -1087,7 +1086,7 @@
 	}
 
 	BUFFER_TRACE(bitmap_bh, "journal_release_buffer");
-	ext3_journal_release_buffer(handle, bitmap_bh, credits);
+	ext3_journal_release_buffer(handle, bitmap_bh);
 	return ret;
 }
 
Index: linux-2.6.10/fs/ext3/ialloc.c
===================================================================
--- linux-2.6.10.orig/fs/ext3/ialloc.c	2005-01-28 19:32:12.000000000 +0300
+++ linux-2.6.10/fs/ext3/ialloc.c	2005-01-29 03:13:41.000000000 +0300
@@ -474,11 +474,9 @@
 		ino = ext3_find_next_zero_bit((unsigned long *)
 				bitmap_bh->b_data, EXT3_INODES_PER_GROUP(sb), ino);
 		if (ino < EXT3_INODES_PER_GROUP(sb)) {
-			int credits = 0;
 
 			BUFFER_TRACE(bitmap_bh, "get_write_access");
-			err = ext3_journal_get_write_access_credits(handle,
-							bitmap_bh, &credits);
+			err = ext3_journal_get_write_access(handle, bitmap_bh);
 			if (err)
 				goto fail;
 
@@ -494,7 +492,7 @@
 				goto got;
 			}
 			/* we lost it */
-			journal_release_buffer(handle, bitmap_bh, credits);
+			journal_release_buffer(handle, bitmap_bh);
 
 			if (++ino < EXT3_INODES_PER_GROUP(sb))
 				goto repeat_in_this_group;

