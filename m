Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261252AbRE2Q7L>; Tue, 29 May 2001 12:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbRE2Q7C>; Tue, 29 May 2001 12:59:02 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47020 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261217AbRE2Q6w>;
	Tue, 29 May 2001 12:58:52 -0400
Date: Tue, 29 May 2001 18:04:29 +0200
From: Jens Axboe <axboe@kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] I/O scheduler starvation
Message-ID: <20010529180429.A504@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Going over this a bit, an deviant from the original design of
elevator_linus seems to have snuck in. Well, almost, I've been aware of
this for some time...

The idea was _not_ to account request merges, since they will (in by far
the most cases) incur the cost of a seek. Instead we just account seeks,
any seek (and please don't start a debate on short vs long seeks again,
I'm not listening). The attached patch corrects this, and also corrects
the initial sequence numbers (typically this would be sequence / 8
number of seeks allowed to pass a request now).

I'll do some formal timing on this later.

-- 
Jens Axboe


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=elv-starv-245-1

--- drivers/block/ll_rw_blk.c~	Tue May 29 17:53:58 2001
+++ drivers/block/ll_rw_blk.c	Tue May 29 17:54:38 2001
@@ -742,7 +742,6 @@
 		case ELEVATOR_BACK_MERGE:
 			if (!q->back_merge_fn(q, req, bh, max_segments))
 				break;
-			elevator->elevator_merge_cleanup_fn(q, req, count);
 			req->bhtail->b_reqnext = bh;
 			req->bhtail = bh;
 			req->nr_sectors = req->hard_nr_sectors += count;
@@ -754,7 +753,6 @@
 		case ELEVATOR_FRONT_MERGE:
 			if (!q->front_merge_fn(q, req, bh, max_segments))
 				break;
-			elevator->elevator_merge_cleanup_fn(q, req, count);
 			bh->b_reqnext = req->bh;
 			req->bh = bh;
 			req->buffer = bh->b_data;
@@ -775,8 +773,10 @@
 			 * request. if no hints, just add it to the back
 			 * of the queue
 			 */
-			if (req)
+			if (req) {
 				insert_here = &req->queue;
+				elevator->elevator_merge_cleanup_fn(q, req, count);
+			}
 			break;
 
 		default:
--- drivers/block/elevator.c~	Tue May 29 17:54:03 2001
+++ drivers/block/elevator.c	Tue May 29 17:59:28 2001
@@ -110,7 +110,6 @@
 			break;
 		} else if (__rq->sector - count == bh->b_rsector) {
 			ret = ELEVATOR_FRONT_MERGE;
-			__rq->elevator_sequence -= count;
 			*req = __rq;
 			break;
 		}
@@ -126,10 +125,10 @@
 	/*
 	 * second pass scan of requests that got passed over, if any
 	 */
-	while ((entry = entry->next) != head) {
+	do {
 		struct request *tmp = blkdev_entry_to_request(entry);
 		tmp->elevator_sequence -= count;
-	}
+	} while ((entry = entry->next) != head);
 }
 
 void elevator_linus_merge_req(struct request *req, struct request *next)
--- include/linux/elevator.h~	Tue May 29 17:54:10 2001
+++ include/linux/elevator.h	Tue May 29 17:55:25 2001
@@ -93,8 +93,8 @@
 
 #define ELEVATOR_LINUS							\
 ((elevator_t) {								\
-	8192,				/* read passovers */		\
-	16384,				/* write passovers */		\
+	1024,				/* read passovers */		\
+	4096,				/* write passovers */		\
 									\
 	elevator_linus_merge,		/* elevator_merge_fn */		\
 	elevator_linus_merge_cleanup,	/* elevator_merge_cleanup_fn */	\

--iVCmgExH7+hIHJ1A--
