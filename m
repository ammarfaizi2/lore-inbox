Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318944AbSICVp2>; Tue, 3 Sep 2002 17:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318945AbSICVp1>; Tue, 3 Sep 2002 17:45:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53765 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318944AbSICVo1>; Tue, 3 Sep 2002 17:44:27 -0400
Date: Tue, 3 Sep 2002 14:52:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: One more bio for for floppy users in 2.5.33..
In-Reply-To: <15733.8764.96293.719729@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.33.0209031450240.10694-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Sep 2002, Mikael Pettersson wrote:
> 
> Confirmed. 2.5.33 + your two patches still corrupts data on a simple
> dd to then from /dev/fd0 test.

Ok, if you don't have BK, then here's the floppy driver end_request() 
cleanup as a plain patch.

This passes dd tests for me, but they were by no means very exhaustive.

		Linus

---
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/03	torvalds@home.transmeta.com	1.581.4.2
# Fix floppy driver end_request() handling - it used to do insane
# contortions instead of just calling "end_that_request_first()" with
# the proper sector count.
# --------------------------------------------
#
diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	Tue Sep  3 14:51:09 2002
+++ b/drivers/block/floppy.c	Tue Sep  3 14:51:09 2002
@@ -2295,16 +2295,15 @@
 {
 	kdev_t dev = req->rq_dev;
 
-	if (end_that_request_first(req, uptodate, req->hard_cur_sectors))
+	if (end_that_request_first(req, uptodate, current_count_sectors))
 		return;
 	add_blkdev_randomness(major(dev));
 	floppy_off(DEVICE_NR(dev));
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
 
-	/* Get the next request */
-	req = elv_next_request(QUEUE);
-	CURRENT = req;
+	/* We're done with the request */
+	CURRENT = NULL;
 }
 
 
@@ -2335,27 +2334,8 @@
 
 		/* unlock chained buffers */
 		spin_lock_irqsave(q->queue_lock, flags);
-		while (current_count_sectors && CURRENT &&
-		       current_count_sectors >= req->current_nr_sectors){
-			current_count_sectors -= req->current_nr_sectors;
-			req->nr_sectors -= req->current_nr_sectors;
-			req->sector += req->current_nr_sectors;
-			end_request(req, 1);
-		}
+		end_request(req, 1);
 		spin_unlock_irqrestore(q->queue_lock, flags);
-
-		if (current_count_sectors && CURRENT) {
-			/* "unlock" last subsector */
-			req->buffer += current_count_sectors <<9;
-			req->current_nr_sectors -= current_count_sectors;
-			req->nr_sectors -= current_count_sectors;
-			req->sector += current_count_sectors;
-			return;
-		}
-
-		if (current_count_sectors && !CURRENT)
-			DPRINT("request list destroyed in floppy request done\n");
-
 	} else {
 		if (rq_data_dir(req) == WRITE) {
 			/* record write error information */

