Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWILPwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWILPwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWILPvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:51:36 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:59119 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751441AbWILPvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:51:03 -0400
Message-Id: <20060912144904.299910000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 12/20] nbd: limit blk_queue
Content-Disposition: inline; filename=nbd_queue.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Limit each request to 1 page, so that the request throttling also limits the
number of in-flight pages.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>
CC: Pavel Machek <pavel@ucw.cz>
---
 drivers/block/nbd.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/block/nbd.c
===================================================================
--- linux-2.6.orig/drivers/block/nbd.c	2006-09-07 18:43:41.000000000 +0200
+++ linux-2.6/drivers/block/nbd.c	2006-09-07 18:44:12.000000000 +0200
@@ -638,6 +638,9 @@ static int __init nbd_init(void)
 			put_disk(disk);
 			goto out;
 		}
+		blk_queue_max_segment_size(disk->queue, PAGE_SIZE);
+		blk_queue_max_hw_segments(disk->queue, 1);
+		blk_queue_max_phys_segments(disk->queue, 1);
 	}
 
 	if (register_blkdev(NBD_MAJOR, "nbd")) {

--

