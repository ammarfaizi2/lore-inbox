Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSEaABd>; Thu, 30 May 2002 20:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSEaABc>; Thu, 30 May 2002 20:01:32 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:13830 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S311871AbSEaABb>;
	Thu, 30 May 2002 20:01:31 -0400
Date: Thu, 30 May 2002 19:52:11 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: [PATCH] 2.5.19 : drivers/mtd/nftlcore.c
Message-ID: <Pine.LNX.4.33.0205301946500.22691-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch addresses a few compile warnings and an error (for 
blk_init_queue) . Please review. The only thing I don't particularly like 
is casting req->cmd to an int for WRITE .  

Regards,
Frank

--- drivers/mtd/nftlcore.c.old	Thu May 30 19:08:35 2002
+++ drivers/mtd/nftlcore.c	Thu May 30 19:44:59 2002
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
+		} else if ((int)req->cmd == WRITE) {
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
@@ -1015,10 +1015,11 @@
 };
 
 extern char nftlmountrev[];
+static spinlock_t nftl_lock = SPIN_LOCK_UNLOCKED;
 
 int __init init_nftl(void)
 {
-	int i;
+spin_lock_init(&nftl_lock);
 
 #ifdef PRERELEASE 
 	printk(KERN_INFO "NFTL driver: nftlcore.c $Revision: 1.82 $, nftlmount.c %s\n", nftlmountrev);
@@ -1028,7 +1029,7 @@
 		printk("unable to register NFTL block device on major %d\n", MAJOR_NR);
 		return -EBUSY;
 	} else {
-		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), &nftl_request);
+		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), &nftl_request, &nftl_lock);
 		add_gendisk(&nftl_gendisk);
 	}
 	
 

