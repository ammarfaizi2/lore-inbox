Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVCIXFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVCIXFS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVCIXDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:03:30 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:59909 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262076AbVCIW2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:28:15 -0500
Date: Wed, 9 Mar 2005 16:28:29 -0600
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 3/3] cciss: per disk queue support
Message-ID: <20050309222829.GC32723@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net, mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds per disk queue functionality. It seems that the 2.6 kernel expects a queue per disk. If you have multiple logical drives on a controller all of the queues actually point back to the same queue. If a drive is deleted it blows us out of the water.
We hold the lock during any queue operations and have added what we call a
"fair-enough" algorithm to prevent starving out any drive.

Please consider this for inclusion.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++----
 cciss.h |    5 +++++
 2 files changed, 53 insertions(+), 4 deletions(-)
----------------------------------------------------------------------------
diff -burNp lx2611-p002/drivers/block/cciss.c lx2611-p003/drivers/block/cciss.c
--- lx2611-p002/drivers/block/cciss.c	2005-03-08 16:50:47.149175280 -0600
+++ lx2611-p003/drivers/block/cciss.c	2005-03-08 17:17:50.148441888 -0600
@@ -2090,6 +2090,9 @@ static void do_cciss_request(request_que
 	drive_info_struct *drv;
 	int i, dir;
 
+	/* We call start_io here in case there is a command waiting on the
+	 * queue that has not been sent.
+	*/
 	if (blk_queue_plugged(q))
 		goto startio;
 
@@ -2178,6 +2181,9 @@ queue:
 full:
 	blk_stop_queue(q);
 startio:
+	/* We will already have the driver lock here so not need
+	 * to lock it.
+	*/
 	start_io(h);
 }
 
@@ -2187,7 +2193,8 @@ static irqreturn_t do_cciss_intr(int irq
 	CommandList_struct *c;
 	unsigned long flags;
 	__u32 a, a1;
-
+	int j;
+	int start_queue = h->next_to_run;
 
 	/* Is this interrupt for us? */
 	if (( h->access.intr_pending(h) == 0) || (h->interrupts_enabled == 0))
@@ -2234,13 +2241,50 @@ static irqreturn_t do_cciss_intr(int irq
 		}
 	}
 
-	/*
-	 * See if we can queue up some more IO
+ 	/* check to see if we have maxed out the number of commands that can
+ 	 * be placed on the queue.  If so then exit.  We do this check here
+ 	 * in case the interrupt we serviced was from an ioctl and did not
+ 	 * free any new commands.
 	 */
-	blk_start_queue(h->queue);
+ 	if ((find_first_zero_bit(h->cmd_pool_bits, NR_CMDS)) == NR_CMDS)
+ 		goto cleanup;
+ 
+ 	/* We have room on the queue for more commands.  Now we need to queue
+ 	 * them up.  We will also keep track of the next queue to run so
+ 	 * that every queue gets a chance to be started first.
+ 	*/
+ 	for (j=0; j < NWD; j++){
+ 		int curr_queue = (start_queue + j) % NWD;
+ 		/* make sure the disk has been added and the drive is real
+ 		 * because this can be called from the middle of init_one.
+ 		*/
+ 		if(!(h->gendisk[curr_queue]->queue) || 
+		 		   !(h->drv[curr_queue].heads))
+ 			continue;
+ 		blk_start_queue(h->gendisk[curr_queue]->queue);
+ 
+ 		/* check to see if we have maxed out the number of commands 
+ 		 * that can be placed on the queue.  
+ 		*/
+ 		if ((find_first_zero_bit(h->cmd_pool_bits, NR_CMDS)) == NR_CMDS)
+ 		{
+ 			if (curr_queue == start_queue){
+ 				h->next_to_run = (start_queue + 1) % NWD;
+ 				goto cleanup;
+ 			} else {
+ 				h->next_to_run = curr_queue;
+ 				goto cleanup;
+ 	}
+ 		} else {
+ 			curr_queue = (curr_queue + 1) % NWD;
+ 		}
+ 	}
+ 
+cleanup:
 	spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
 	return IRQ_HANDLED;
 }
+
 /* 
  *  We cannot read the structure directly, for portablity we must use 
  *   the io functions.
Files lx2611-p002/drivers/block/.cciss.c.rej.swp and lx2611-p003/drivers/block/.cciss.c.rej.swp differ
diff -burNp lx2611-p002/drivers/block/cciss.h lx2611-p003/drivers/block/cciss.h
--- lx2611-p002/drivers/block/cciss.h	2005-03-08 16:50:47.150175128 -0600
+++ lx2611-p003/drivers/block/cciss.h	2005-03-08 17:03:04.279114496 -0600
@@ -84,6 +84,11 @@ struct ctlr_info 
 	int			nr_frees; 
 	int			busy_configuring;
 
+	/* This element holds the zero based queue number of the last
+	 * queue to be started.  It is used for fairness.
+	*/
+	int			next_to_run;
+
 	// Disk structures we need to pass back
 	struct gendisk   *gendisk[NWD];
 #ifdef CONFIG_CISS_SCSI_TAPE
