Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSI3SDG>; Mon, 30 Sep 2002 14:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262825AbSI3SDG>; Mon, 30 Sep 2002 14:03:06 -0400
Received: from [195.39.17.254] ([195.39.17.254]:772 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262824AbSI3SDC>;
	Mon, 30 Sep 2002 14:03:02 -0400
Date: Mon, 30 Sep 2002 19:02:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: NBD cleanups
Message-ID: <20020930170234.GA122@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Having special #ifdef for paranoia check is probably bad idea, turn it
into BUG_ON().
								Pavel

--- clean/drivers/block/nbd.c	2002-09-23 00:09:12.000000000 +0200
+++ linux/drivers/block/nbd.c	2002-09-23 00:09:22.000000000 +0200
@@ -71,10 +71,8 @@
 /* #define DEBUG( s ) printk( s ) 
  */
 
-#ifdef PARANOIA
 static int requests_in;
 static int requests_out;
-#endif
 
 static int nbd_open(struct inode *inode, struct file *file)
 {
@@ -270,18 +268,9 @@
 			printk(KERN_ALERT "req should never be null\n" );
 			goto out;
 		}
-#ifdef PARANOIA
-		if (lo != &nbd_dev[minor(req->rq_dev)]) {
-			printk(KERN_ALERT "NBD: request corrupted!\n");
-			continue;
-		}
-		if (lo->magic != LO_MAGIC) {
-			printk(KERN_ALERT "NBD: nbd_dev[] corrupted: Not enough magic\n");
-			goto out;
-		}
-#endif
+		BUG_ON(lo != &nbd_dev[minor(req->rq_dev)]);
+		BUG_ON(lo->magic != LO_MAGIC);
 		nbd_end_request(req);
-
 	}
  out:
 	return;
@@ -291,12 +280,7 @@
 {
 	struct request *req;
 
-#ifdef PARANOIA
-	if (lo->magic != LO_MAGIC) {
-		printk(KERN_ERR "NBD: nbd_dev[] corrupted: Not enough magic when clearing!\n");
-		return;
-	}
-#endif
+	BUG_ON(lo->magic != LO_MAGIC);
 
 	do {
 		req = NULL;
@@ -331,15 +315,9 @@
 
 	while (!blk_queue_empty(QUEUE)) {
 		req = CURRENT;
-#ifdef PARANOIA
-		if (!req)
-			FAIL("queue not empty but no request?");
-#endif
+		BUG_ON(!req);
 		dev = minor(req->rq_dev);
-#ifdef PARANOIA
-		if (dev >= MAX_NBD)
-			FAIL("Minor too big.");		/* Probably can not happen */
-#endif
+		BUG_ON(dev >= MAX_NBD);
 		if (!(req->flags & REQ_CMD))
 			goto error_out;
 
@@ -352,11 +330,9 @@
 			if (lo->flags & NBD_READ_ONLY)
 				FAIL("Write on read-only");
 		}
-#ifdef PARANOIA
-		if (lo->magic != LO_MAGIC)
-			FAIL("nbd[] is not magical!");
+		BUG_ON(lo->magic != LO_MAGIC);
 		requests_in++;
-#endif
+
 		req->errors = 0;
 		blkdev_dequeue_request(req);
 		spin_unlock_irq(q->queue_lock);

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
