Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263017AbUKTARX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbUKTARX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbUKTARO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:17:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54160 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262858AbUKTAN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:13:26 -0500
Date: Sat, 20 Nov 2004 00:13:10 GMT
Message-Id: <200411200013.iAK0DAu6006630@sisko.sctweedie.blueyonder.co.uk>
From: Stephen Tweedie <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 2/3]: ext3: handle attempted delete of bitmap blocks.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves ext3's ability to deal with corruption on-disk.
If we ever get a corrupt inode or indirect block, then an attempt to
delete it can end up trying to remove any block on the fs, including
bitmap blocks.  This can cause ext3 to assert-fail as we end up trying
to do an ext3_forget on a buffer with b_committed_data set.

The fix is to downgrade this to an IO error and journal abort, so that
we take the filesystem readonly but don't bring down the whole kernel.

Make J_EXPECT_JH() return a value so it can be easily tested and yet
still retained as an assert failure if we build ext3 with full
internal debugging enabled.  Make journal_forget() return an error
code so that in this case the error can be passed up to the caller.

This is easily reproduced with a sample ext3 fs image containing an
inode whose direct and indirect blocks refer to a block bitmap block.
Allocating new blocks and then deleting that inode will BUG() with:

Assertion failure in journal_forget() at fs/jbd/transaction.c:1228: 
"!jh->b_committed_data"

With the fix, ext3 recovers gracefully.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6-ext3/fs/ext3/inode.c.=K0001=.orig
+++ linux-2.6-ext3/fs/ext3/inode.c
@@ -84,7 +84,7 @@ int ext3_forget(handle_t *handle, int is
 	    (!is_metadata && !ext3_should_journal_data(inode))) {
 		if (bh) {
 			BUFFER_TRACE(bh, "call journal_forget");
-			ext3_journal_forget(handle, bh);
+			return ext3_journal_forget(handle, bh);
 		}
 		return 0;
 	}
--- linux-2.6-ext3/fs/jbd/transaction.c.=K0001=.orig
+++ linux-2.6-ext3/fs/jbd/transaction.c
@@ -1198,12 +1198,13 @@ journal_release_buffer(handle_t *handle,
  * Allow this call even if the handle has aborted --- it may be part of
  * the caller's cleanup after an abort.
  */
-void journal_forget(handle_t *handle, struct buffer_head *bh)
+int journal_forget (handle_t *handle, struct buffer_head *bh)
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal = transaction->t_journal;
 	struct journal_head *jh;
-
+	int err = 0;
+	
 	BUFFER_TRACE(bh, "entry");
 
 	jbd_lock_bh_state(bh);
@@ -1213,6 +1214,14 @@ void journal_forget(handle_t *handle, st
 		goto not_jbd;
 	jh = bh2jh(bh);
 
+	/* Critical error: attempting to delete a bitmap buffer, maybe?
+	 * Don't do any jbd operations, and return an error. */
+	if (!J_EXPECT_JH(jh, !jh->b_committed_data,
+			 "inconsistent data on disk")) {
+		err = -EIO;
+		goto not_jbd;
+	}
+
 	if (jh->b_transaction == handle->h_transaction) {
 		J_ASSERT_JH(jh, !jh->b_frozen_data);
 
@@ -1223,7 +1232,6 @@ void journal_forget(handle_t *handle, st
 		clear_buffer_jbddirty(bh);
 
 		JBUFFER_TRACE(jh, "belongs to current transaction: unfile");
-		J_ASSERT_JH(jh, !jh->b_committed_data);
 
 		__journal_unfile_buffer(jh);
 
@@ -1248,7 +1256,7 @@ void journal_forget(handle_t *handle, st
 				spin_unlock(&journal->j_list_lock);
 				jbd_unlock_bh_state(bh);
 				__bforget(bh);
-				return;
+				return 0;
 			}
 		}
 	} else if (jh->b_transaction) {
@@ -1270,7 +1278,7 @@ not_jbd:
 	spin_unlock(&journal->j_list_lock);
 	jbd_unlock_bh_state(bh);
 	__brelse(bh);
-	return;
+	return err;
 }
 
 /**
--- linux-2.6-ext3/include/linux/ext3_jbd.h.=K0001=.orig
+++ linux-2.6-ext3/include/linux/ext3_jbd.h
@@ -138,10 +138,13 @@ ext3_journal_release_buffer(handle_t *ha
 	journal_release_buffer(handle, bh, credits);
 }
 
-static inline void
-ext3_journal_forget(handle_t *handle, struct buffer_head *bh)
+static inline int
+__ext3_journal_forget(const char *where, handle_t *handle, struct buffer_head *bh)
 {
-	journal_forget(handle, bh);
+	int err = journal_forget(handle, bh);
+	if (err)
+		ext3_journal_abort_handle(where, __FUNCTION__, bh, handle,err);
+	return err;
 }
 
 static inline int
@@ -187,6 +190,8 @@ __ext3_journal_dirty_metadata(const char
 	__ext3_journal_get_create_access(__FUNCTION__, (handle), (bh))
 #define ext3_journal_dirty_metadata(handle, bh) \
 	__ext3_journal_dirty_metadata(__FUNCTION__, (handle), (bh))
+#define ext3_journal_forget(handle, bh) \
+	__ext3_journal_forget(__FUNCTION__, (handle), (bh))
 
 handle_t *ext3_journal_start_sb(struct super_block *sb, int nblocks);
 int __ext3_journal_stop(const char *where, handle_t *handle);
--- linux-2.6-ext3/include/linux/jbd.h.=K0001=.orig
+++ linux-2.6-ext3/include/linux/jbd.h
@@ -277,13 +277,15 @@ void buffer_assertion_failure(struct buf
 #define J_EXPECT_JH(jh, expr, why...)	J_ASSERT_JH(jh, expr)
 #else
 #define __journal_expect(expr, why...)					     \
-	do {								     \
-		if (!(expr)) {						     \
+	({								     \
+		int val = (expr);					     \
+		if (!val) {						     \
 			printk(KERN_ERR					     \
 				"EXT3-fs unexpected failure: %s;\n",# expr); \
-			printk(KERN_ERR why);				     \
+			printk(KERN_ERR why "\n");			     \
 		}							     \
-	} while (0)
+		val;							     \
+	})
 #define J_EXPECT(expr, why...)		__journal_expect(expr, ## why)
 #define J_EXPECT_BH(bh, expr, why...)	__journal_expect(expr, ## why)
 #define J_EXPECT_JH(jh, expr, why...)	__journal_expect(expr, ## why)
@@ -874,7 +876,7 @@ extern int	 journal_dirty_data (handle_t
 extern int	 journal_dirty_metadata (handle_t *, struct buffer_head *);
 extern void	 journal_release_buffer (handle_t *, struct buffer_head *,
 						int credits);
-extern void	 journal_forget (handle_t *, struct buffer_head *);
+extern int	 journal_forget (handle_t *, struct buffer_head *);
 extern void	 journal_sync_buffer (struct buffer_head *);
 extern int	 journal_invalidatepage(journal_t *,
 				struct page *, unsigned long);
