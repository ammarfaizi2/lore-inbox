Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbUAAWHa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265455AbUAAWAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:00:18 -0500
Received: from thunk.org ([140.239.227.29]:61090 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265421AbUAAVvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 16:51:12 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [PATCH] [2.4.24-pre3] 1/5  EXT2/3 Updates
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1AcAiB-0000LP-Ma@thunk.org>
Date: Thu, 01 Jan 2004 16:50:35 -0500
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1356  -> 1.1357 
#	     fs/jbd/commit.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/01	tytso@think.thunk.org	1.1357
# Apply 4007-akpm-page-reap.patch
# 
# With data=ordered it is often the case that a quick write-and-truncate will
# leave large numbers of pages on the page LRU with no ->mapping, and attached
# buffers.  Because ext3 was not ready to let the pages go at the time of
# truncation.
#  
# These pages are trivially reclaimable, but their seeming absence makes the VM
# overcommit accounting confused (they don't count as "free", nor as
# pagecache).  And they make the /proc/meminfo stats look odd.
#  
# So what we do here is to try to strip the buffers from these pages as the
# buffers exit the journal commit.
# --------------------------------------------
#
diff -Nru a/fs/jbd/commit.c b/fs/jbd/commit.c
--- a/fs/jbd/commit.c	Thu Jan  1 16:29:08 2004
+++ b/fs/jbd/commit.c	Thu Jan  1 16:29:08 2004
@@ -19,6 +19,8 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/locks.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 
 extern spinlock_t journal_datalist_lock;
@@ -34,6 +36,49 @@
 }
 
 /*
+ * When an ext3-ordered file is truncated, it is possible that many pages are
+ * not sucessfully freed, because they are attached to a committing transaction.
+ * After the transaction commits, these pages are left on the LRU, with no
+ * ->mapping, and with attached buffers.  These pages are trivially reclaimable
+ * by the VM, but their apparent absence upsets the VM accounting, and it makes
+ * the numbers in /proc/meminfo look odd.
+ *
+ * So here, we have a buffer which has just come off the forget list.  Look to
+ * see if we can strip all buffers from the backing page.
+ *
+ * Called under lock_journal(), and possibly under journal_datalist_lock.  The
+ * caller provided us with a ref against the buffer, and we drop that here.
+ */
+static void release_buffer_page(struct buffer_head *bh)
+{
+	struct page *page;
+
+	if (buffer_dirty(bh))
+		goto nope;
+	if (atomic_read(&bh->b_count) != 1)
+		goto nope;
+	page = bh->b_page;
+	if (!page)
+		goto nope;
+	if (page->mapping)
+		goto nope;
+
+	/* OK, it's a truncated page */
+	if (TryLockPage(page))
+		goto nope;
+
+	page_cache_get(page);
+	__brelse(bh);
+	try_to_free_buffers(page, GFP_NOIO);
+	unlock_page(page);
+	page_cache_release(page);
+	return;
+
+nope:
+	__brelse(bh);
+}
+
+/*
  * journal_commit_transaction
  *
  * The primary function for committing a transaction to the log.  This
@@ -211,7 +256,7 @@
 				jh->b_transaction = NULL;
 				__journal_remove_journal_head(bh);
 				refile_buffer(bh);
-				__brelse(bh);
+				release_buffer_page(bh);
 			}
 		}
 		if (bufs == ARRAY_SIZE(wbuf)) {
@@ -648,7 +693,8 @@
 	while (commit_transaction->t_forget) {
 		transaction_t *cp_transaction;
 		struct buffer_head *bh;
-
+		int was_freed = 0;
+		
 		jh = commit_transaction->t_forget;
 		J_ASSERT_JH(jh,	jh->b_transaction == commit_transaction ||
 			jh->b_transaction == journal->j_running_transaction);
@@ -699,6 +745,7 @@
 		 * behind for writeback and gets reallocated for another
 		 * use in a different page. */
 		if (__buffer_state(bh, Freed)) {
+			was_freed = 1;
 			clear_bit(BH_Freed, &bh->b_state);
 			clear_bit(BH_JBDDirty, &bh->b_state);
 		}
@@ -714,7 +761,12 @@
 			__journal_unfile_buffer(jh);
 			jh->b_transaction = 0;
 			__journal_remove_journal_head(bh);
-			__brelse(bh);
+			spin_unlock(&journal_datalist_lock);
+			if (was_freed)
+				release_buffer_page(bh);
+			else
+				__brelse(bh);
+			continue;
 		}
 		spin_unlock(&journal_datalist_lock);
 	}
