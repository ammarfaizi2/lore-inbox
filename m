Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316435AbSEZUuG>; Sun, 26 May 2002 16:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316420AbSEZUos>; Sun, 26 May 2002 16:44:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55568 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316403AbSEZUoQ>;
	Sun, 26 May 2002 16:44:16 -0400
Message-ID: <3CF149DB.2BA18AC3@zip.com.au>
Date: Sun, 26 May 2002 13:47:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 14/18] fix ext3 __FUNCTION__ warnings
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch from Anton Blanchard which replaces

	printk(KERN_FOO __FUNCTION__ ": msg");

with
	printk(KERN_FOO "%s: msg", __FUNCTION__);

in ext3.

=====================================

--- 2.5.18/fs/ext3/inode.c~ext3-functions	Sun May 26 12:38:05 2002
+++ 2.5.18-akpm/fs/ext3/inode.c	Sun May 26 12:38:05 2002
@@ -2476,7 +2476,7 @@ ext3_mark_iloc_dirty(handle_t *handle, 
 		/* ext3_do_update_inode() does journal_dirty_metadata */
 		brelse(iloc->bh);
 	} else {
-		printk(KERN_EMERG __FUNCTION__ ": called with no handle!\n");
+		printk(KERN_EMERG "%s: called with no handle!\n", __FUNCTION__);
 	}
 	return err;
 }
@@ -2564,7 +2564,8 @@ void ext3_dirty_inode(struct inode *inod
 	if (current_handle &&
 		current_handle->h_transaction != handle->h_transaction) {
 		/* This task has a transaction open against a different fs */
-		printk(KERN_EMERG __FUNCTION__": transactions do not match!\n");
+		printk(KERN_EMERG "%s: transactions do not match!\n",
+		       __FUNCTION__);
 	} else {
 		jbd_debug(5, "marking dirty.  outer handle=%p\n",
 				current_handle);
--- 2.5.18/fs/ext3/super.c~ext3-functions	Sun May 26 12:38:05 2002
+++ 2.5.18-akpm/fs/ext3/super.c	Sun May 26 12:38:05 2002
@@ -892,17 +892,17 @@ static void ext3_orphan_cleanup (struct 
 
 		list_add(&EXT3_I(inode)->i_orphan, &EXT3_SB(sb)->s_orphan);
 		if (inode->i_nlink) {
-			printk(KERN_DEBUG __FUNCTION__
-				": truncating inode %ld to %Ld bytes\n",
-				inode->i_ino, inode->i_size);
+			printk(KERN_DEBUG
+				"%s: truncating inode %ld to %Ld bytes\n",
+				__FUNCTION__, inode->i_ino, inode->i_size);
 			jbd_debug(2, "truncating inode %ld to %Ld bytes\n",
 				  inode->i_ino, inode->i_size);
 			ext3_truncate(inode);
 			nr_truncates++;
 		} else {
-			printk(KERN_DEBUG __FUNCTION__
-				": deleting unreferenced inode %ld\n",
-				inode->i_ino);
+			printk(KERN_DEBUG
+				"%s: deleting unreferenced inode %ld\n",
+				__FUNCTION__, inode->i_ino);
 			jbd_debug(2, "deleting unreferenced inode %ld\n",
 				  inode->i_ino);
 			nr_orphans++;
--- 2.5.18/fs/jbd/journal.c~ext3-functions	Sun May 26 12:38:05 2002
+++ 2.5.18-akpm/fs/jbd/journal.c	Sun May 26 12:38:05 2002
@@ -466,9 +466,8 @@ int journal_write_metadata_buffer(transa
 	do {
 		new_bh = alloc_buffer_head(0);
 		if (!new_bh) {
-			printk (KERN_NOTICE __FUNCTION__
-				": ENOMEM at alloc_buffer_head, "
-				"trying again.\n");
+			printk (KERN_NOTICE "%s: ENOMEM at alloc_buffer_head, "
+				"trying again.\n", __FUNCTION__);
 			yield();
 		}
 	} while (!new_bh);
@@ -593,9 +592,9 @@ void log_wait_commit (journal_t *journal
 #ifdef CONFIG_JBD_DEBUG
 	lock_journal(journal);
 	if (!tid_geq(journal->j_commit_request, tid)) {
-		printk(KERN_EMERG __FUNCTION__
-			": error: j_commit_request=%d, tid=%d\n",
-			journal->j_commit_request, tid);
+		printk(KERN_EMERG
+		       "%s: error: j_commit_request=%d, tid=%d\n",
+		       __FUNCTION__, journal->j_commit_request, tid);
 	}
 	unlock_journal(journal);
 #endif
@@ -644,9 +643,9 @@ int journal_bmap(journal_t *journal, uns
 		if (ret)
 			*retp = ret;
 		else {
-			printk (KERN_ALERT __FUNCTION__ 
-				": journal block not found "
-				"at offset %lu on %s\n",
+			printk(KERN_ALERT "%s: journal block not found "
+					"at offset %lu on %s\n",
+				__FUNCTION__,
 				blocknr,
 				bdevname(journal->j_dev));
 			err = -EIO;
@@ -792,8 +791,8 @@ journal_t * journal_init_inode (struct i
 	err = journal_bmap(journal, 0, &blocknr);
 	/* If that failed, give up */
 	if (err) {
-		printk(KERN_ERR __FUNCTION__ ": Cannnot locate journal "
-		       "superblock\n");
+		printk(KERN_ERR "%s: Cannnot locate journal superblock\n",
+		       __FUNCTION__);
 		kfree(journal);
 		return NULL;
 	}
@@ -879,8 +878,9 @@ int journal_create (journal_t *journal)
 		/*
 		 * We don't know what block to start at!
 		 */
-		printk(KERN_EMERG __FUNCTION__
-			": creation of journal on external device!\n");
+		printk(KERN_EMERG
+		       "%s: creation of journal on external device!\n",
+		       __FUNCTION__);
 		BUG();
 	}
 
@@ -1601,8 +1601,8 @@ static struct journal_head *journal_allo
 	if (ret == 0) {
 		jbd_debug(1, "out of memory for journal_head\n");
 		if (time_after(jiffies, last_warning + 5*HZ)) {
-			printk(KERN_NOTICE "ENOMEM in " __FUNCTION__
-			       ", retrying.\n");
+			printk(KERN_NOTICE "ENOMEM in %s, retrying.\n",
+			       __FUNCTION__);
 			last_warning = jiffies;
 		}
 		while (ret == 0) {
--- 2.5.18/fs/jbd/transaction.c~ext3-functions	Sun May 26 12:38:05 2002
+++ 2.5.18-akpm/fs/jbd/transaction.c	Sun May 26 12:38:05 2002
@@ -709,8 +709,9 @@ repeat:
 							    GFP_NOFS);
 				lock_journal(journal);
 				if (!frozen_buffer) {
-					printk(KERN_EMERG __FUNCTION__
-						"OOM for frozen_buffer\n");
+					printk(KERN_EMERG
+					       "%s: OOM for frozen_buffer\n",
+					       __FUNCTION__);
 					JBUFFER_TRACE(jh, "oom!");
 					error = -ENOMEM;
 					spin_lock(&journal_datalist_lock);
@@ -906,8 +907,9 @@ int journal_get_undo_access (handle_t *h
 		jh->b_committed_data = jbd_kmalloc(jh2bh(jh)->b_size, 
 						   GFP_NOFS);
 		if (!jh->b_committed_data) {
-			printk(KERN_EMERG __FUNCTION__
-				": No memory for committed data!\n");
+			printk(KERN_EMERG
+			       "%s: No memory for committed data!\n",
+			       __FUNCTION__);
 			err = -ENOMEM;
 			goto out;
 		}

-
