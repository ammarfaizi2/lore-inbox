Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbSJPUk4>; Wed, 16 Oct 2002 16:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbSJPUk4>; Wed, 16 Oct 2002 16:40:56 -0400
Received: from smtp06.iddeo.es ([62.81.186.16]:44287 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S261400AbSJPUky>;
	Wed, 16 Oct 2002 16:40:54 -0400
Date: Wed, 16 Oct 2002 22:46:48 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: sct@redhat.com, akpm@zip.com.au, adilger@clusterfs.com
Subject: Latest ext3 merge in mainline lacks 2 hunks ?
Message-ID: <20021016204648.GA1616@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I  was patching mainline kernels with the ext3 update until this was
merged recently.
The merge differs from what I had (taken from LKML) in two missing hunks
not present still in -pre11.
Some of the maintainers can say if they are important ?

Here they are:

diff -ruN linux-2.4.20-pre8-jam1/fs/jbd/commit.c linux-2.4.20-pre8-jam1-ext3/fs/jbd/commit.c
--- linux-2.4.20-pre8-jam1/fs/jbd/commit.c	2002-09-28 02:04:49.000000000 +0200
+++ linux-2.4.20-pre8-jam1-ext3/fs/jbd/commit.c	2002-09-28 02:11:55.000000000 +0200
@@ -714,13 +714,25 @@
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
 
diff -ruN linux-2.4.20-pre8-jam1/fs/jbd/transaction.c linux-2.4.20-pre8-jam1-ext3/fs/jbd/transaction.c
--- linux-2.4.20-pre8-jam1/fs/jbd/transaction.c	2002-09-28 02:04:49.000000000 +0200
+++ linux-2.4.20-pre8-jam1-ext3/fs/jbd/transaction.c	2002-09-28 02:11:55.000000000 +0200
@@ -1945,8 +1945,17 @@
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


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre11-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
