Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbSJZKYQ>; Sat, 26 Oct 2002 06:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbSJZKYP>; Sat, 26 Oct 2002 06:24:15 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:20748 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262040AbSJZKXV>; Sat, 26 Oct 2002 06:23:21 -0400
X-Envelope-From: pavel@bug.ucw.cz
Date: Mon, 21 Oct 2002 11:52:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Clean up nbd.c
Message-ID: <20021021095254.GA8811@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've never seen any of those errors, so I guess its okay to convert
them to BUG_ONs. It makes code look better [I'm nbd
maintainer, and approve it ;-)]. Please apply,

								Pavel

--- clean/drivers/block/nbd.c	2002-10-20 16:22:38.000000000 +0200
+++ linux/drivers/block/nbd.c	2002-10-20 18:25:41.000000000 +0200
@@ -65,10 +65,8 @@
 /* #define DEBUG( s ) printk( s ) 
  */
 
-#ifdef PARANOIA
 static int requests_in;
 static int requests_out;
-#endif
 
 static int nbd_open(struct inode *inode, struct file *file)
 {
@@ -261,18 +259,8 @@
 			printk(KERN_ALERT "req should never be null\n" );
 			goto out;
 		}
-#ifdef PARANOIA
-		if (lo != req->rq_disk->private_data) {
-			printk(KERN_ALERT "NBD: request corrupted!\n");
-			continue;
-		}
-		if (lo->magic != LO_MAGIC) {
-			printk(KERN_ALERT "NBD: nbd_dev[] corrupted: Not enough magic\n");
-			goto out;
-		}
-#endif
+		BUG_ON(lo->magic != LO_MAGIC);
 		nbd_end_request(req);
-
 	}
  out:
 	return;
@@ -282,12 +270,7 @@
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
@@ -333,11 +316,9 @@
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
