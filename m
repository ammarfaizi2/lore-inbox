Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSIZNv6>; Thu, 26 Sep 2002 09:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSIZNv4>; Thu, 26 Sep 2002 09:51:56 -0400
Received: from pc-62-31-66-34-ed.blueyonder.co.uk ([62.31.66.34]:22659 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261295AbSIZNue>; Thu, 26 Sep 2002 09:50:34 -0400
Date: Thu, 26 Sep 2002 14:55:32 +0100
Message-Id: <200209261355.g8QDtWc16998@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 3/7] 2.4.20-pre4/ext3: evict truncated buffers more easily.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Performance tweak: when we truncate a file but encounter pages which are still
being journaled from a previous transaction, we can't evict the page from
memory immediately.

This patch just makes it a little easier for the VM to evict the page later on:
the page is marked unreferenced while we're committing the transaction which
pins it, and the commit logic tries to free the page completely once the
transaction has committed.

--- linux-2.4-ext3merge/fs/jbd/commit.c.=K0002=.orig	Thu Sep 26 12:19:14 2002
+++ linux-2.4-ext3merge/fs/jbd/commit.c	Thu Sep 26 12:25:37 2002
@@ -683,13 +683,25 @@
 			JBUFFER_TRACE(jh, "refile for checkpoint writeback");
 			__journal_refile_buffer(jh);
 		} else {
+			struct page *page = bh->b_page;
+			
 			J_ASSERT_BH(bh, !buffer_dirty(bh));
 			J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
 			__journal_unfile_buffer(jh);
 			jh->b_transaction = 0;
 			__journal_remove_journal_head(bh);
-			__brelse(bh);
+
+			if (TryLockPage(page)) {	
+				__brelse(bh);
+			} else {
+				__brelse(bh);
+				page_cache_get(page);
+				try_to_free_buffers(page, 0);
+				unlock_page(page);
+				page_cache_release(page);
+			}
 		}
+		
 		spin_unlock(&journal_datalist_lock);
 	}
 
--- linux-2.4-ext3merge/fs/jbd/transaction.c.=K0002=.orig	Thu Sep 26 12:19:14 2002
+++ linux-2.4-ext3merge/fs/jbd/transaction.c	Thu Sep 26 12:25:37 2002
@@ -1903,8 +1903,17 @@
 	unlock_journal(journal);
 
 	if (!offset) {
-		if (!may_free || !try_to_free_buffers(page, 0))
+		if (!may_free || !try_to_free_buffers(page, 0)) {
+			if (!offset) {
+				/* We are still using the page, but only
+                                   because a transaction is pinning the
+                                   page.  Once it commits, we want to
+                                   encourage the page to be reaped as
+                                   quickly as possible. */
+				ClearPageReferenced(page);
+			}
 			return 0;
+		}
 		J_ASSERT(page->buffers == NULL);
 	}
 	return 1;
