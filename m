Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbQLRSnB>; Mon, 18 Dec 2000 13:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132357AbQLRSmv>; Mon, 18 Dec 2000 13:42:51 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:55989 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S130017AbQLRSmj>; Mon, 18 Dec 2000 13:42:39 -0500
Date: Mon, 18 Dec 2000 18:13:53 +0000 (GMT)
From: Mark Hemment <markhe@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Linus elevator
Message-ID: <Pine.LNX.4.21.0012181750350.22851-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Looking at the second loop in elevator_linus_merge(), it is possible for
requests to have their elevator_sequence go negative.  This can cause a
v long latency before the request is finally serviced.

  Say, for example, a request (in the queue) is jumped in the first loop
in elevator_linus_merge() as "cmd != rw", even though its 
elevator_sequence is zero.  If it is found that the new request will
merge, the walking back over requests which were jumped makes no test for
an already zeroed elevator_sequence.  Hence it zero values can occur.

  With high default values for read/wite_latency, this hardly ever occurs.

  A simple fix for this is to test for zero before decrementing (patch
below) in the second loop.
  Alternatively, should testing in the first loop be modified?

Mark


diff -u --recursive --new-file -X dontdiff linux-2.4.0-test12/drivers/block/elevator.c markhe-2.4.0-test12/drivers/block/elevator.c
--- linux-2.4.0-test12/drivers/block/elevator.c	Tue Dec  5 23:05:26 2000
+++ markhe-2.4.0-test12/drivers/block/elevator.c	Mon Dec 18 17:50:19 2000
@@ -90,6 +90,9 @@
 	if (ret != ELEVATOR_NO_MERGE && *req) {
 		while ((entry = entry->next) != &q->queue_head) {
 			struct request *tmp = blkdev_entry_to_request(entry);
+
+			if (!tmp->elevator_sequence)
+				continue;
 			tmp->elevator_sequence--;
 		}
 	}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
