Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145106AbRA2Dub>; Sun, 28 Jan 2001 22:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145123AbRA2DuV>; Sun, 28 Jan 2001 22:50:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11533 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S145106AbRA2DuG>;
	Sun, 28 Jan 2001 22:50:06 -0500
Date: Mon, 29 Jan 2001 04:50:01 +0100
From: Jens Axboe <axboe@suse.de>
To: David Ford <david@linux.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: D state after applying ps hang patch
Message-ID: <20010129045001.C15679@suse.de>
In-Reply-To: <3A74B6AE.C179050B@linux.com> <20010129013145.G12772@suse.de> <3A74DCEE.7FBC1879@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A74DCEE.7FBC1879@linux.com>; from david@linux.com on Sun, Jan 28, 2001 at 07:01:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28 2001, David Ford wrote:
> The one LInus posted plus his addendum for the ll_rw_blk.
> http://blue-labs.org/patches/ps-hang.patch

You merged it wrong, Linus suggested to remove the entire

		if (!list_empty(&q->request_freelist[rw])) {
			blk_refill_freelist(q, rw);
			list_add(&req->table, &q->request_freelist[rw]);
			return;
		}

In fact, with the change you made the box can't possible survive
for very long - once the queue freelists are empty, you will
deadlock immediately.

Try this ll_rw_blk.c change instead, on top of pre11. Include
Linus' mm fixes of course.

--- /opt/kernel/linux-2.4.1-pre10/drivers/block/ll_rw_blk.c	Thu Jan 25 19:15:12 2001
+++ drivers/block/ll_rw_blk.c	Sun Jan 28 19:22:20 2001
@@ -633,6 +634,8 @@
 		if (!list_empty(&q->request_freelist[rw])) {
 			blk_refill_freelist(q, rw);
 			list_add(&req->table, &q->request_freelist[rw]);
+			if (waitqueue_active(&q->wait_for_request))
+				wake_up_nr(&q->wait_for_request, 2);
 			return;
 		}
 

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
