Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSEaNIs>; Fri, 31 May 2002 09:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSEaNIr>; Fri, 31 May 2002 09:08:47 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:55050 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S315260AbSEaNIr>;
	Fri, 31 May 2002 09:08:47 -0400
Date: Fri, 31 May 2002 08:53:36 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.19 : drivers/mtd/nftlcore.c
Message-ID: <Pine.LNX.4.33.0205310847150.1058-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch fixes a few compiler warnings, as well as provides 
blk_init_queue() with the appropriate arguments. Please review for 
inclusion. Thanks to Jens Axboe for fixing the casting hack in 
the previous version of this patch. 

Regards,
Frank


--- drivers/mtd/nftlcore.c.old	Thu May 30 19:08:35 2002
+++ drivers/mtd/nftlcore.c	Fri May 31 08:45:08 2002
@@ -846,11 +846,11 @@
 		
 		/* We can do this because the generic code knows not to
 		   touch the request at the head of the queue */
-		spin_unlock_irq(&QUEUE->queue_lock);
+		spin_unlock_irq(QUEUE->queue_lock);
 
 		DEBUG(MTD_DEBUG_LEVEL2, "NFTL_request\n");
 		DEBUG(MTD_DEBUG_LEVEL3,
-		      "NFTL %s request, from sector 0x%04lx for 0x%04lx sectors\n",
+		      "NFTL %s request, from sector 0x%04lx for %d sectors\n",
 		      (req->cmd == READ) ? "Read " : "Write",
 		      req->sector, req->current_nr_sectors);
 
@@ -899,7 +899,7 @@
 			DEBUG(MTD_DEBUG_LEVEL2,"NFTL read request completed OK\n");
 			up(&nftl->mutex);
 			goto repeat;
-		} else if (req->cmd == WRITE) {
+		} else if (rq_data_dir(req) == WRITE) {
 			DEBUG(MTD_DEBUG_LEVEL2, "NFTL write request of 0x%x sectors @ %x "
 			      "(req->nr_sectors == %lx)\n", nsect, block,
 			      req->nr_sectors);
@@ -927,7 +927,7 @@
 		}
 	repeat: 
 		DEBUG(MTD_DEBUG_LEVEL3, "end_request(%d)\n", res);
-		spin_lock_irq(&QUEUE->queue_lock);
+		spin_lock_irq(QUEUE->queue_lock);
 		end_request(res);
 	}
 }
@@ -1015,10 +1015,10 @@
 };
 
 extern char nftlmountrev[];
+static spinlock_t nftl_lock = SPIN_LOCK_UNLOCKED;
 
 int __init init_nftl(void)
 {
-	int i;
 
 #ifdef PRERELEASE 
 	printk(KERN_INFO "NFTL driver: nftlcore.c $Revision: 1.82 $, nftlmount.c %s\n", nftlmountrev);
@@ -1028,7 +1028,7 @@
 		printk("unable to register NFTL block device on major %d\n", MAJOR_NR);
 		return -EBUSY;
 	} else {
-		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), &nftl_request);
+		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), &nftl_request, &nftl_lock);
 		add_gendisk(&nftl_gendisk);
 	}
 	

