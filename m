Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKUJJX>; Tue, 21 Nov 2000 04:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129960AbQKUJJE>; Tue, 21 Nov 2000 04:09:04 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:34003 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S129091AbQKUJIu>; Tue, 21 Nov 2000 04:08:50 -0500
From: kumon@flab.fujitsu.co.jp
Date: Tue, 21 Nov 2000 17:38:44 +0900
Message-Id: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp>
To: linux-kernel@vger.kernel.org
cc: Dave Jones <davej@suse.de>, Andrea Arcangeli <andrea@suse.de>
cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH] livelock in elevator scheduling
Reply-to: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current elevator_linus() doesn't obey the true elevator
scheduling, and causes I/O livelock during frequent random write
traffics. In such environment I/O (read/write) transactions may be
delayed almost infinitely (more than 1 hour).

Problem:
 Current elevator_linus() traverses the I/O requesting queue from the
tail to top. And when the current request has smaller sector number
than the request on the top of queue, it is always placed just after
the top.
 This means, if requests in some sector range are continuously
generated, a request with larger sector number is always places at the
last and has no chance to go to the front.  e.g. it is not scheduled.

 This is not hypothetical but actually observed.  Running a random
disk write benchmark can completely supress other disk I/O by this
reason.


 The following patch fixes this problem. It still doesn't follow a
strict elevator scheduling, but it does much better.  Additionally, it
may be better to add extra priority to reads than writes to obtain
better response, but this patch doesn't.

diff -ru linux-2.4.0-test11-pre2/drivers/block/elevator.c linux-2.4.0-test11-pre2-test5/drivers/block/elevator.c
--- linux-2.4.0-test11-pre2/drivers/block/elevator.c	Wed Aug 23 14:33:46 2000
+++ linux-2.4.0-test11-pre2-test5/drivers/block/elevator.c	Tue Nov 21 15:32:01 2000
@@ -47,6 +47,11 @@
 			break;
 		tmp->elevator_sequence--;
 	}
+	if (entry == head) {
+		tmp = blkdev_entry_to_request(entry);
+		if (IN_ORDER(req, tmp))
+			entry = real_head->prev;
+	}
 	list_add(&req->queue, entry);
 }
 

To implement a complete elevator scheduling, preparing an alternate
waiting queue is better, I think.

--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
