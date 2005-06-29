Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVF2OO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVF2OO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 10:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVF2OO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 10:14:26 -0400
Received: from gold.veritas.com ([143.127.12.110]:18874 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S262581AbVF2OOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 10:14:22 -0400
Date: Wed, 29 Jun 2005 15:15:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.13-rc1 get_request nastiness
Message-ID: <Pine.LNX.4.61.0506291509170.13974@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 29 Jun 2005 14:14:21.0783 (UTC) FILETIME=[D87B1670:01C57CB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

get_request is now expected to be holding on to queue_lock, with interrupts
disabled, when it returns NULL; but one path forgot that, causing all kinds
of nastiness under swap load - badness backtraces, strange failures, BUGs.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.13-rc1/drivers/block/ll_rw_blk.c	2005-06-29 11:54:08.000000000 +0100
+++ linux/drivers/block/ll_rw_blk.c	2005-06-29 14:41:04.000000000 +0100
@@ -1917,10 +1917,9 @@ get_rq:
 	 * limit of requests, otherwise we could have thousands of requests
 	 * allocated with any setting of ->nr_requests
 	 */
-	if (rl->count[rw] >= (3 * q->nr_requests / 2)) {
-		spin_unlock_irq(q->queue_lock);
+	if (rl->count[rw] >= (3 * q->nr_requests / 2))
 		goto out;
-	}
+
 	rl->count[rw]++;
 	rl->starved[rw] = 0;
 	if (rl->count[rw] >= queue_congestion_on_threshold(q))
