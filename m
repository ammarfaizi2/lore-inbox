Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWIFNiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWIFNiy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWIFNii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:38:38 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:8218 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750919AbWIFNia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:38:30 -0400
Message-Id: <20060906133954.845224000@chello.nl>
References: <20060906131630.793619000@chello.nl>>
User-Agent: quilt/0.45-1
Date: Wed, 06 Sep 2006 15:16:41 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 11/21] nbd: limit blk_queue
Content-Disposition: inline; filename=nbd_queue.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Limit each request to 1 page, so that the request throttling also limits the
number of in-flight pages and force the IO scheduler to NOOP as anything else
doesn't make sense anyway.

(Pavel, I will analyse those !NOOP deadlocks I got, I'm just re-posting so 
people can comment on the rest)

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>
CC: Pavel Machek <pavel@ucw.cz>
---
 drivers/block/nbd.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/block/nbd.c
===================================================================
--- linux-2.6.orig/drivers/block/nbd.c
+++ linux-2.6/drivers/block/nbd.c
@@ -628,11 +636,16 @@ static int __init nbd_init(void)
 		 * every gendisk to have its very own request_queue struct.
 		 * These structs are big so we dynamically allocate them.
 		 */
-		disk->queue = blk_init_queue(do_nbd_request, &nbd_lock);
+		disk->queue = blk_init_queue_node_elv(do_nbd_request,
+				&nbd_lock, -1, "noop");
 		if (!disk->queue) {
 			put_disk(disk);
 			goto out;
 		}
+		blk_queue_pin_elevator(disk->queue);
+		blk_queue_max_segment_size(disk->queue, PAGE_SIZE);
+		blk_queue_max_hw_segments(disk->queue, 1);
+		blk_queue_max_phys_segments(disk->queue, 1);
 	}
 
 	if (register_blkdev(NBD_MAJOR, "nbd")) {

--
