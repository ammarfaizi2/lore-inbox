Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268597AbTCCRU5>; Mon, 3 Mar 2003 12:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268671AbTCCRU5>; Mon, 3 Mar 2003 12:20:57 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:21376 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S268597AbTCCRTV>;
	Mon, 3 Mar 2003 12:19:21 -0500
Date: Mon, 3 Mar 2003 18:29:47 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: pavel@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make nbd working in 2.5.x
Message-ID: <20030303172946.GA20197@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,
   we use nbd for our diskless systems, and it looks to me like that
it has some serious problems in 2.5.x... Can you apply this patch
and forward it to Linus? 

There were:
* Missing disk's queue initialization
* Driver should use list_del_init: put_request now verifies
  that req->queuelist is empty, and list_del was incompatible
  with this.
* I converted nbd_end_request back to end_that_request_{first,last}
  as I saw no reason why driver should do it itself... and 
  blk_put_request has no place under queue_lock, so apparently when
  semantic changed nobody went through drivers...
				Thanks,
					Petr Vandrovec
					vandrove@vc.cvut.cz

diff -urdN linux/drivers/block/nbd.c linux/drivers/block/nbd.c
--- linux/drivers/block/nbd.c	2003-02-28 20:56:05.000000000 +0100
+++ linux/drivers/block/nbd.c	2003-03-01 22:53:36.000000000 +0100
@@ -76,22 +76,15 @@
 {
 	int uptodate = (req->errors == 0) ? 1 : 0;
 	request_queue_t *q = req->q;
-	struct bio *bio;
-	unsigned nsect;
 	unsigned long flags;
 
 #ifdef PARANOIA
 	requests_out++;
 #endif
 	spin_lock_irqsave(q->queue_lock, flags);
-	while((bio = req->bio) != NULL) {
-		nsect = bio_sectors(bio);
-		blk_finished_io(nsect);
-		req->bio = bio->bi_next;
-		bio->bi_next = NULL;
-		bio_endio(bio, nsect << 9, uptodate ? 0 : -EIO);
+	if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
+		end_that_request_last(req);
 	}
-	blk_put_request(req);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
@@ -243,7 +236,7 @@
 		req = list_entry(tmp, struct request, queuelist);
 		if (req != xreq)
 			continue;
-		list_del(&req->queuelist);
+		list_del_init(&req->queuelist);
 		spin_unlock(&lo->queue_lock);
 		return req;
 	}
@@ -322,7 +315,7 @@
 		spin_lock(&lo->queue_lock);
 		if (!list_empty(&lo->queue_head)) {
 			req = list_entry(lo->queue_head.next, struct request, queuelist);
-			list_del(&req->queuelist);
+			list_del_init(&req->queuelist);
 		}
 		spin_unlock(&lo->queue_lock);
 		if (req) {
@@ -387,7 +380,7 @@
 		if (req->errors) {
 			printk(KERN_ERR "nbd: nbd_send_req failed\n");
 			spin_lock(&lo->queue_lock);
-			list_del(&req->queuelist);
+			list_del_init(&req->queuelist);
 			spin_unlock(&lo->queue_lock);
 			nbd_end_request(req);
 			spin_lock_irq(q->queue_lock);
@@ -592,6 +585,7 @@
 		disk->first_minor = i;
 		disk->fops = &nbd_fops;
 		disk->private_data = &nbd_dev[i];
+		disk->queue = &nbd_queue;
 		sprintf(disk->disk_name, "nbd%d", i);
 		set_capacity(disk, 0x3ffffe);
 		add_disk(disk);
