Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVDLSka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVDLSka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVDLSiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:38:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:4043 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262301AbVDLKeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:34:01 -0400
Message-Id: <200504121033.j3CAXbpP005926@shell0.pdx.osdl.net>
Subject: [patch 191/198] jbd dirty buffer leak fix
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sct@redhat.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This fixes the lots-of-fsx-linux-instances-cause-a-slow-leak bug.

It's been there since 2.6.6, caused by:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm4/broken-out/jbd-move-locked-buffers.patch

That patch moves under-writeout ordered-data buffers onto a separate journal
list during commit.  It took out the old code which was based on a single
list.

The old code (necessarily) had logic which would restart I/O against buffers
which had been redirtied while they were on the committing transaction's
t_sync_datalist list.  The new code only writes buffers once, ignoring
redirtyings by a later transaction, which is good.

But over on the truncate side of things, in journal_unmap_buffer(), we're
treating buffers on the t_locked_list as inviolable things which belong to the
committing transaction, and we just leave them alone during concurrent
truncate-vs-commit.

The net effect is that when truncate tries to invalidate a page whose buffers
are on t_locked_list and have been redirtied, journal_unmap_buffer() just
leaves those buffers alone.  truncate will remove the page from its mapping
and we end up with an anonymous clean page with dirty buffers, which is an
illegal state for a page.  The JBD commit will not clean those buffers as they
are removed from t_locked_list.  The VM (try_to_free_buffers) cannot reclaim
these pages.

The patch teaches journal_unmap_buffer() about buffers which are on the
committing transaction's t_locked_list.  These buffers have been written and
I/O has completed.  We can take them off the transaction and undirty them
within the context of journal_invalidatepage()->journal_unmap_buffer().

Acked-by: "Stephen C. Tweedie" <sct@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/jbd/transaction.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff -puN fs/jbd/transaction.c~jbd-dirty-buffer-leak-fix fs/jbd/transaction.c
--- 25/fs/jbd/transaction.c~jbd-dirty-buffer-leak-fix	2005-04-12 03:21:48.891704232 -0700
+++ 25-akpm/fs/jbd/transaction.c	2005-04-12 03:21:48.895703624 -0700
@@ -1812,7 +1812,17 @@ static int journal_unmap_buffer(journal_
 			}
 		}
 	} else if (transaction == journal->j_committing_transaction) {
-		/* If it is committing, we simply cannot touch it.  We
+		if (jh->b_jlist == BJ_Locked) {
+			/*
+			 * The buffer is on the committing transaction's locked
+			 * list.  We have the buffer locked, so I/O has
+			 * completed.  So we can nail the buffer now.
+			 */
+			may_free = __dispose_buffer(jh, transaction);
+			goto zap_buffer;
+		}
+		/*
+		 * If it is committing, we simply cannot touch it.  We
 		 * can remove it's next_transaction pointer from the
 		 * running transaction if that is set, but nothing
 		 * else. */
@@ -1887,7 +1897,6 @@ int journal_invalidatepage(journal_t *jo
 		unsigned int next_off = curr_off + bh->b_size;
 		next = bh->b_this_page;
 
-		/* AKPM: doing lock_buffer here may be overly paranoid */
 		if (offset <= curr_off) {
 		 	/* This block is wholly outside the truncation point */
 			lock_buffer(bh);
_
