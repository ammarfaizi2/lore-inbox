Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313752AbSDPQGb>; Tue, 16 Apr 2002 12:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313749AbSDPQFv>; Tue, 16 Apr 2002 12:05:51 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:16376 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313739AbSDPQFX>; Tue, 16 Apr 2002 12:05:23 -0400
Subject: [patch 2.5.8 ] nbd compile fix - Was: Re: [PATCH] 2.5.8 IDE 36
To: torvalds@transmeta.com
Date: Tue, 16 Apr 2002 17:05:21 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E16xVSL-0005Tw-00@libra.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

You just mentioned using nbd but nbd doesn't even compile at the moment
(and it hasn't for a while). Below is a patch that fixes compilation.

Note patch compiles but is otherwise untested as no kernel after 2.5.7
boots on my 2.5 box due to IDE hanging the box hard during device
discovery. )-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
WWW: http://www-stu.christs.cam.ac.uk/~aia21/

--- nbd-2.5.patch ---
--- nbd.c.old	Tue Apr 16 16:58:42 2002
+++ nbd.c	Thu Apr 11 00:13:33 2002
@@ -240,11 +240,11 @@ void nbd_do_it(struct nbd_device *lo)
 {
 	struct request *req;
 
-	down (&lo->queue_lock);
+	down (&lo->tx_lock);
 	while (1) {
-		up (&lo->queue_lock);
+		up (&lo->tx_lock);
 		req = nbd_read_stat(lo);
-		down (&lo->queue_lock);
+		down (&lo->tx_lock);
 
 		if (!req) {
 			printk(KERN_ALERT "req should never be null\n" );
@@ -264,14 +264,14 @@ void nbd_do_it(struct nbd_device *lo)
 		}
 #endif
 		blkdev_dequeue_request(req);
-		up (&lo->queue_lock);
+		up (&lo->tx_lock);
 		
 		nbd_end_request(req);
 
-		down (&lo->queue_lock);
+		down (&lo->tx_lock);
 	}
  out:
-	up (&lo->queue_lock);
+	up (&lo->tx_lock);
 }
 
 void nbd_clear_que(struct nbd_device *lo)
@@ -299,11 +299,11 @@ void nbd_clear_que(struct nbd_device *lo
 #endif
 		req->errors++;
 		blkdev_dequeue_request(req);
-		up(&lo->queue_lock);
+		up(&lo->tx_lock);
 
 		nbd_end_request(req);
 
-		down(&lo->queue_lock);
+		down(&lo->tx_lock);
 	}
 }
 
@@ -351,10 +351,10 @@ static void do_nbd_request(request_queue
 		blkdev_dequeue_request(req);
 		spin_unlock_irq(q->queue_lock);
 
-		down (&lo->queue_lock);
+		down (&lo->tx_lock);
 		list_add(&req->queuelist, &lo->queue_head);
 		nbd_send_req(lo->sock, req);	/* Why does this block?         */
-		up (&lo->queue_lock);
+		up (&lo->tx_lock);
 
 		spin_lock_irq(q->queue_lock);
 		continue;
@@ -396,14 +396,14 @@ static int nbd_ioctl(struct inode *inode
                 return 0 ;
  
 	case NBD_CLEAR_SOCK:
-		down(&lo->queue_lock);
+		down(&lo->tx_lock);
 		nbd_clear_que(lo);
 		if (!list_empty(&lo->queue_head)) {
-			up(&lo->queue_lock);
+			up(&lo->tx_lock);
 			printk(KERN_ERR "nbd: Some requests are in progress -> can not turn off.\n");
 			return -EBUSY;
 		}
-		up(&lo->queue_lock);
+		up(&lo->tx_lock);
 		file = lo->file;
 		if (!file)
 			return -EINVAL;
@@ -527,7 +527,7 @@ static int __init nbd_init(void)
 		nbd_dev[i].magic = LO_MAGIC;
 		nbd_dev[i].flags = 0;
 		INIT_LIST_HEAD(&nbd_dev[i].queue_head);
-		init_MUTEX(&nbd_dev[i].queue_lock);
+		init_MUTEX(&nbd_dev[i].tx_lock);
 		nbd_blksizes[i] = 1024;
 		nbd_blksize_bits[i] = 10;
 		nbd_bytesizes[i] = 0x7ffffc00; /* 2GB */

