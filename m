Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVDDBgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVDDBgj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 21:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVDDBgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 21:36:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:31658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261965AbVDDBgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 21:36:21 -0400
Date: Sun, 3 Apr 2005 18:35:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: andrea@suse.de, mjbligh@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: OOM problems on 2.6.12-rc1 with many fsx tests
Message-Id: <20050403183544.7c31f85c.akpm@osdl.org>
In-Reply-To: <1111607584.5786.55.camel@localhost.localdomain>
References: <20050315204413.GF20253@csail.mit.edu>
	<20050316003134.GY7699@opteron.random>
	<20050316040435.39533675.akpm@osdl.org>
	<20050316183701.GB21597@opteron.random>
	<1111607584.5786.55.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> I run into OOM problem again on 2.6.12-rc1. I run some(20) fsx tests on
>  2.6.12-rc1 kernel(and 2.6.11-mm4) on ext3 filesystem, after about 10
>  hours the system hit OOM, and OOM keep killing processes one by one. I
>  could reproduce this problem very constantly on a 2 way PIII 700MHZ with
>  512MB RAM. Also the problem could be reproduced on running the same test
>  on reiser fs.
> 
>  The fsx command is:
> 
>  ./fsx -c 10 -n -r 4096 -w 4096 /mnt/test/foo1 &


This ext3 bug goes all the way back to 2.6.6.

I don't know yet why you saw problems with reiser3 and I'm pretty sure I
saw problems with ext2.  More testing is needed there.

Without the below patch it's possible to make ext3 leak at around a
megabyte per minute by arranging for the fs to run a commit every 50
milliseconds, btw.

(Stephen, please review...)



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

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/jbd/transaction.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff -puN fs/jbd/transaction.c~jbd-dirty-buffer-leak-fix fs/jbd/transaction.c
--- 25/fs/jbd/transaction.c~jbd-dirty-buffer-leak-fix	2005-04-03 15:12:12.000000000 -0700
+++ 25-akpm/fs/jbd/transaction.c	2005-04-03 15:14:40.000000000 -0700
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

