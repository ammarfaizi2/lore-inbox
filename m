Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291165AbSBGP2s>; Thu, 7 Feb 2002 10:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291162AbSBGP2i>; Thu, 7 Feb 2002 10:28:38 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:9221 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S291158AbSBGP2Y>;
	Thu, 7 Feb 2002 10:28:24 -0500
Message-ID: <3C629A8A.4587D3DB@yahoo.com>
Date: Thu, 07 Feb 2002 10:27:30 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
To: linux-kernel list <linux-kernel@vger.kernel.org>
CC: axboe@suse.de, ben@bssc.edu.au
Subject: [PATCH] bio/kdev_t changes for cdrom/sbpcd.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems someone is still trying to use this stone-age device
with 2.5.x kernels.  Oh, the horror, the horror....   :)

Paul.


--- drivers/cdrom/sbpcd.c~	Tue Feb  5 02:39:38 2002
+++ drivers/cdrom/sbpcd.c	Thu Feb  7 10:25:44 2002
@@ -348,6 +348,12 @@
  */
 #define DONT_MERGE_REQUESTS
 
+/*
+ * Add bio/kdev_t changes for 2.5.x required to make it work again. 
+ * Still room for improvement in the request handling here if anyone
+ * actually cares.  Bring your own chainsaw.    Paul G.  02/2002
+ */
+
 #ifndef SBPCD_ISSUE
 #define SBPCD_ISSUE 1
 #endif /* SBPCD_ISSUE */
@@ -490,6 +496,8 @@
 
 #define NUM_PROBE  (sizeof(sbpcd) / sizeof(int))
 
+static spinlock_t sbpcd_lock = SPIN_LOCK_UNLOCKED;
+
 /*==========================================================================*/
 /*
  * the external references:
@@ -4887,7 +4895,6 @@
  */
 #undef DEBUG_GTL
 static inline void sbpcd_end_request(struct request *req, int uptodate) {
-	list_add(&req->queue, &req->q->queue_head);
 	end_request(uptodate);
 }
 /*==========================================================================*/
@@ -4923,8 +4930,7 @@
 		xnr, CURRENT, CURRENT->sector, CURRENT->nr_sectors, current->pid, jiffies);
 #endif
 	INIT_REQUEST;
-	req=CURRENT;		/* take out our request so no other */
-	blkdev_dequeue_request(req);	/* task can fuck it up         GTL  */
+	req=CURRENT;
 	
 	if (req->rq_status == RQ_INACTIVE)
 		sbpcd_end_request(req, 0);
@@ -4933,9 +4939,9 @@
 	spin_unlock_irq(q->queue_lock);
 
 	down(&ioctl_read_sem);
-	if (req->cmd != READ)
+	if (rq_data_dir(CURRENT) != READ)
 	{
-		msg(DBG_INF, "bad cmd %d\n", req->cmd);
+		msg(DBG_INF, "bad cmd %d\n", req->cmd[0]);
 		goto err_done;
 	}
 	i = minor(req->rq_dev);
@@ -5686,13 +5692,13 @@
 
 #ifdef DONT_MERGE_REQUESTS
 static int dont_merge_requests_fn(request_queue_t *q, struct request *req,
-                                struct request *next, int max_segments)
+                                struct request *next)
 {
 	return 0;
 }
 
 static int dont_bh_merge_fn(request_queue_t *q, struct request *req,
-                            struct buffer_head *bh, int max_segments)
+                            struct bio *bio)
 {
 	return 0;
 }
@@ -5864,7 +5870,7 @@
 		goto init_done;
 #endif /* MODULE */
 	}
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &sbpcd_lock);
 #ifdef DONT_MERGE_REQUESTS
 	(BLK_DEFAULT_QUEUE(MAJOR_NR))->back_merge_fn = dont_bh_merge_fn;
 	(BLK_DEFAULT_QUEUE(MAJOR_NR))->front_merge_fn = dont_bh_merge_fn;
@@ -5922,7 +5928,7 @@
 		}
 		D_S[j].sbpcd_infop = sbpcd_infop;
 		memcpy (sbpcd_infop, &sbpcd_info, sizeof(struct cdrom_device_info));
-		sbpcd_infop->dev = MKDEV(MAJOR_NR, j);
+		sbpcd_infop->dev = mk_kdev(MAJOR_NR, j);
 		strncpy(sbpcd_infop->name,major_name, sizeof(sbpcd_infop->name)); 
 
 		sprintf (nbuff, "c%dt%d/cd", SBPCD_ISSUE - 1, D_S[j].drv_id);

