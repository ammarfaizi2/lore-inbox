Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUCSVGc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 16:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbUCSVGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 16:06:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:42127 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262029AbUCSVGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 16:06:13 -0500
Date: Fri, 19 Mar 2004 13:08:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: mason@suse.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-Id: <20040319130818.29703791.akpm@osdl.org>
In-Reply-To: <s5h3c8436qf.wl@alsa2.suse.de>
References: <40591EC1.1060204@geizhals.at>
	<20040318060358.GC29530@dualathlon.random>
	<s5hlllycgz3.wl@alsa2.suse.de>
	<20040318143205.6a9c4e89.akpm@osdl.org>
	<1079650437.11058.31.camel@watt.suse.com>
	<20040318155745.36d4785d.akpm@osdl.org>
	<s5h3c8436qf.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> At Thu, 18 Mar 2004 15:57:45 -0800,
> Andrew Morton wrote:
> > 
> > Chris Mason <mason@suse.com> wrote:
> > >
> > > > What we're doing here is walking (under spinlock) a ring of buffers
> > > > searching for unlocked dirty ones to write out.
> > > > 
> > > > Suppose the ring has thousands of locked buffers and there is a RT task
> > > > scheduling at 1kHz.  Each time need_resched() comes true we break out of
> > > > the search, schedule away and then restart the search from the beginning.
> > > > 
> > > Why not just put all the locked buffers onto a different list as you
> > > find them or lock them.  That way you can always make progress...
> > 
> > Coz that made me look at the code and hence rewrite the whole thing, damn
> > you.  It's definitely better, but is of scary scope.
> 
> wow, interesting, i'll give a shot with your patch.

It had a bug.  This version has been well tested.



There's some nasty code in commit which deals with a lock ranking problem. 
Currently if it fails to get the lock when and local variable `bufs' is zero
we forget to write out some ordered-data buffers.  So a subsequent
crash+recovery could yield stale data in existing files.

Fix it by correctly restarting the t_sync_datalist search.


---

 25-akpm/fs/jbd/commit.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN fs/jbd/commit.c~jbd-commit-ordered-fix fs/jbd/commit.c
--- 25/fs/jbd/commit.c~jbd-commit-ordered-fix	Thu Mar 18 14:08:13 2004
+++ 25-akpm/fs/jbd/commit.c	Thu Mar 18 14:28:52 2004
@@ -262,8 +262,7 @@ write_out_data_locked:
 				if (!jbd_trylock_bh_state(bh)) {
 					spin_unlock(&journal->j_list_lock);
 					schedule();
-					spin_lock(&journal->j_list_lock);
-					break;
+					goto write_out_data;
 				}
 				__journal_unfile_buffer(jh);
 				jh->b_transaction = NULL;

_



For data=ordered, kjournald at commit time has to write out and wait upon a
long list of buffers.  It does this in a rather awkward way with a single
list.  it causes complexity and long lock hold times, and makes the addition
of rescheduling points quite hard

So what we do instead (based on Chris Mason's suggestion) is to add a new
buffer list (t_locked_list) to the journal.  It contains buffers which have
been placed under I/O.

So as we walk the t_sync_datalist list we move buffers over to t_locked_list
as they are written out.

When t_sync_datalist is empty we may then walk t_locked_list waiting for the
I/O to complete.

As a side-effect this means that we can remove the nasty synchronous wait in
journal_dirty_data which is there to avoid the kjournald livelock which would
otherwise occur when someone is continuously dirtying a buffer.



---

 25-akpm/fs/jbd/commit.c      |  143 +++++++++++++++++++++----------------------
 25-akpm/fs/jbd/transaction.c |   13 +++
 25-akpm/include/linux/jbd.h  |    9 ++
 3 files changed, 91 insertions(+), 74 deletions(-)

diff -puN fs/jbd/commit.c~jbd-move-locked-buffers fs/jbd/commit.c
--- 25/fs/jbd/commit.c~jbd-move-locked-buffers	2004-03-18 22:28:53.207331840 -0800
+++ 25-akpm/fs/jbd/commit.c	2004-03-18 22:33:57.569061824 -0800
@@ -79,6 +79,21 @@ nope:
 }
 
 /*
+ * Try to acquire jbd_lock_bh_state() against the buffer, when j_list_lock is
+ * held.  For ranking reasons we must trylock.  If we lose, schedule away and
+ * return 0.  j_list_lock is dropped in this case.
+ */
+static int inverted_lock(journal_t *journal, struct buffer_head *bh)
+{
+	if (!jbd_trylock_bh_state(bh)) {
+		spin_unlock(&journal->j_list_lock);
+		schedule();
+		return 0;
+	}
+	return 1;
+}
+
+/*
  * journal_commit_transaction
  *
  * The primary function for committing a transaction to the log.  This
@@ -88,7 +103,6 @@ void journal_commit_transaction(journal_
 {
 	transaction_t *commit_transaction;
 	struct journal_head *jh, *new_jh, *descriptor;
-	struct journal_head *next_jh, *last_jh;
 	struct buffer_head *wbuf[64];
 	int bufs;
 	int flags;
@@ -222,113 +236,102 @@ void journal_commit_transaction(journal_
 	err = 0;
 	/*
 	 * Whenever we unlock the journal and sleep, things can get added
-	 * onto ->t_datalist, so we have to keep looping back to write_out_data
-	 * until we *know* that the list is empty.
+	 * onto ->t_sync_datalist, so we have to keep looping back to
+	 * write_out_data until we *know* that the list is empty.
 	 */
-write_out_data:
-
+	bufs = 0;
 	/*
 	 * Cleanup any flushed data buffers from the data list.  Even in
 	 * abort mode, we want to flush this out as soon as possible.
-	 *
-	 * We take j_list_lock to protect the lists from
-	 * journal_try_to_free_buffers().
 	 */
+write_out_data:
+	cond_resched();
 	spin_lock(&journal->j_list_lock);
 
-write_out_data_locked:
-	bufs = 0;
-	next_jh = commit_transaction->t_sync_datalist;
-	if (next_jh == NULL)
-		goto sync_datalist_empty;
-	last_jh = next_jh->b_tprev;
-
-	do {
+	while (commit_transaction->t_sync_datalist) {
 		struct buffer_head *bh;
 
-		jh = next_jh;
-		next_jh = jh->b_tnext;
+		jh = commit_transaction->t_sync_datalist;
+		commit_transaction->t_sync_datalist = jh->b_tnext;
 		bh = jh2bh(jh);
-		if (!buffer_locked(bh)) {
+		if (buffer_locked(bh)) {
+			BUFFER_TRACE(bh, "locked");
+			if (!inverted_lock(journal, bh))
+				goto write_out_data;
+			__journal_unfile_buffer(jh);
+			__journal_file_buffer(jh, jh->b_transaction, BJ_Locked);
+			jbd_unlock_bh_state(bh);
+			if (need_resched()) {
+				spin_unlock(&journal->j_list_lock);
+				goto write_out_data;
+			}
+		} else {
 			if (buffer_dirty(bh)) {
 				BUFFER_TRACE(bh, "start journal writeout");
-				atomic_inc(&bh->b_count);
+				get_bh(bh);
 				wbuf[bufs++] = bh;
-			} else {
-				BUFFER_TRACE(bh, "writeout complete: unfile");
-				/*
-				 * We have a lock ranking problem..
-				 */
-				if (!jbd_trylock_bh_state(bh)) {
+				if (bufs == ARRAY_SIZE(wbuf)) {
+					jbd_debug(2, "submit %d writes\n",
+							bufs);
 					spin_unlock(&journal->j_list_lock);
-					schedule();
+					ll_rw_block(WRITE, bufs, wbuf);
+					journal_brelse_array(wbuf, bufs);
+					bufs = 0;
 					goto write_out_data;
 				}
+			} else {
+				BUFFER_TRACE(bh, "writeout complete: unfile");
+				if (!inverted_lock(journal, bh))
+					goto write_out_data;
 				__journal_unfile_buffer(jh);
 				jh->b_transaction = NULL;
 				jbd_unlock_bh_state(bh);
 				journal_remove_journal_head(bh);
-				__brelse(bh);
-				if (need_resched() && commit_transaction->
-							t_sync_datalist) {
-					commit_transaction->t_sync_datalist =
-								next_jh;
-					if (bufs)
-						break;
+				put_bh(bh);
+				if (need_resched()) {
 					spin_unlock(&journal->j_list_lock);
-					cond_resched();
 					goto write_out_data;
 				}
 			}
 		}
-		if (bufs == ARRAY_SIZE(wbuf)) {
-			/*
-			 * Major speedup: start here on the next scan
-			 */
-			J_ASSERT(commit_transaction->t_sync_datalist != 0);
-			commit_transaction->t_sync_datalist = jh;
-			break;
-		}
-	} while (jh != last_jh);
-
-	if (bufs || need_resched()) {
-		jbd_debug(2, "submit %d writes\n", bufs);
-		spin_unlock(&journal->j_list_lock);
-		if (bufs)
-			ll_rw_block(WRITE, bufs, wbuf);
-		cond_resched();
-		journal_brelse_array(wbuf, bufs);
-		spin_lock(&journal->j_list_lock);
-		goto write_out_data_locked;
 	}
 
 	/*
-	 * Wait for all previously submitted IO on the data list to complete.
+	 * Wait for all previously submitted IO to complete.
 	 */
-	jh = commit_transaction->t_sync_datalist;
-	if (jh == NULL)
-		goto sync_datalist_empty;
-
-	do {
+	while (commit_transaction->t_locked_list) {
 		struct buffer_head *bh;
-		jh = jh->b_tprev;	/* Wait on the last written */
+
+		jh = commit_transaction->t_locked_list->b_tprev;
 		bh = jh2bh(jh);
+		get_bh(bh);
 		if (buffer_locked(bh)) {
-			get_bh(bh);
 			spin_unlock(&journal->j_list_lock);
 			wait_on_buffer(bh);
 			if (unlikely(!buffer_uptodate(bh)))
 				err = -EIO;
+			spin_lock(&journal->j_list_lock);
+		}
+		if (!inverted_lock(journal, bh)) {
 			put_bh(bh);
-			/* the journal_head may have been removed now */
-			goto write_out_data;
-		} else if (buffer_dirty(bh)) {
-			goto write_out_data_locked;
+			spin_lock(&journal->j_list_lock);
+			continue;
 		}
-	} while (jh != commit_transaction->t_sync_datalist);
-	goto write_out_data_locked;
-
-sync_datalist_empty:
+		if (buffer_jbd(bh) && jh->b_jlist == BJ_Locked) {
+			__journal_unfile_buffer(jh);
+			jh->b_transaction = NULL;
+			jbd_unlock_bh_state(bh);
+			journal_remove_journal_head(bh);
+		} else {
+			jbd_unlock_bh_state(bh);
+		}
+		put_bh(bh);
+		if (need_resched()) {
+			spin_unlock(&journal->j_list_lock);
+			cond_resched();
+			spin_lock(&journal->j_list_lock);
+		}
+	}
 	spin_unlock(&journal->j_list_lock);
 
 	journal_write_revoke_records(journal, commit_transaction);
diff -puN include/linux/jbd.h~jbd-move-locked-buffers include/linux/jbd.h
--- 25/include/linux/jbd.h~jbd-move-locked-buffers	2004-03-18 22:28:53.208331688 -0800
+++ 25-akpm/include/linux/jbd.h	2004-03-18 22:28:53.214330776 -0800
@@ -487,6 +487,12 @@ struct transaction_s 
 	struct journal_head	*t_reserved_list;
 
 	/*
+	 * Doubly-linked circular list of all buffers under writeout during
+	 * commit [j_list_lock]
+	 */
+	struct journal_head	*t_locked_list;
+
+	/*
 	 * Doubly-linked circular list of all metadata buffers owned by this
 	 * transaction [j_list_lock]
 	 */
@@ -1079,7 +1085,8 @@ static inline int jbd_space_needed(journ
 #define BJ_Shadow	5	/* Buffer contents being shadowed to the log */
 #define BJ_LogCtl	6	/* Buffer contains log descriptors */
 #define BJ_Reserved	7	/* Buffer is reserved for access by journal */
-#define BJ_Types	8
+#define BJ_Locked	8	/* Locked for I/O during commit */
+#define BJ_Types	9
  
 extern int jbd_blocks_per_page(struct inode *inode);
 
diff -puN fs/jbd/transaction.c~jbd-move-locked-buffers fs/jbd/transaction.c
--- 25/fs/jbd/transaction.c~jbd-move-locked-buffers	2004-03-18 22:28:53.210331384 -0800
+++ 25-akpm/fs/jbd/transaction.c	2004-03-18 22:33:38.948892520 -0800
@@ -1010,7 +1010,8 @@ int journal_dirty_data(handle_t *handle,
 			 * the write() data.
 			 */
 			if (jh->b_jlist != BJ_None &&
-					jh->b_jlist != BJ_SyncData) {
+					jh->b_jlist != BJ_SyncData &&
+					jh->b_jlist != BJ_Locked) {
 				JBUFFER_TRACE(jh, "Not stealing");
 				goto no_journal;
 			}
@@ -1048,7 +1049,7 @@ int journal_dirty_data(handle_t *handle,
 		 * committing transaction, so might still be left on that
 		 * transaction's metadata lists.
 		 */
-		if (jh->b_jlist != BJ_SyncData) {
+		if (jh->b_jlist != BJ_SyncData && jh->b_jlist != BJ_Locked) {
 			JBUFFER_TRACE(jh, "not on correct data list: unfile");
 			J_ASSERT_JH(jh, jh->b_jlist != BJ_Shadow);
 			__journal_unfile_buffer(jh);
@@ -1539,6 +1540,9 @@ void __journal_unfile_buffer(struct jour
 	case BJ_Reserved:
 		list = &transaction->t_reserved_list;
 		break;
+	case BJ_Locked:
+		list = &transaction->t_locked_list;
+		break;
 	}
 
 	__blist_del_buffer(list, jh);
@@ -1576,7 +1580,7 @@ __journal_try_to_free_buffer(journal_t *
 
 	spin_lock(&journal->j_list_lock);
 	if (jh->b_transaction != 0 && jh->b_cp_transaction == 0) {
-		if (jh->b_jlist == BJ_SyncData) {
+		if (jh->b_jlist == BJ_SyncData || jh->b_jlist == BJ_Locked) {
 			/* A written-back ordered data buffer */
 			JBUFFER_TRACE(jh, "release data");
 			__journal_unfile_buffer(jh);
@@ -1985,6 +1989,9 @@ void __journal_file_buffer(struct journa
 	case BJ_Reserved:
 		list = &transaction->t_reserved_list;
 		break;
+	case BJ_Locked:
+		list =  &transaction->t_locked_list;
+		break;
 	}
 
 	__blist_add_buffer(list, jh);

_



