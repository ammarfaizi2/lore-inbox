Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266157AbUHBPTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUHBPTP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 11:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUHBPTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 11:19:15 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:23315 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266157AbUHBPTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 11:19:04 -0400
Message-ID: <410E5B58.4000002@steeleye.com>
Date: Mon, 02 Aug 2004 11:18:48 -0400
From: Paul Clements <paul.clements@steeleye.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] nbd: fix struct request race condition
Content-Type: multipart/mixed;
 boundary="------------070005090605010103070907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070005090605010103070907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

Here's a patch to fix a race condition in nbd that was causing struct 
request corruption (requests were being freed while still in use). This 
patch improves on the previous one, which admittedly was a bit dodgy, 
using struct request's ref_count field (I should have listened to Jens 
in the first place :). This should fix all the corner cases related to 
struct request usage/freeing in nbd. My stress tests do a lot better 
with this patch applied.

Thanks,
Paul

--------------070005090605010103070907
Content-Type: text/plain;
 name="nbd_cant_find_req_2_6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd_cant_find_req_2_6.diff"

--- linux-2.6.7/drivers/block/nbd.c.PRISTINE	Fri Jul 30 12:09:00 2004
+++ linux-2.6.7/drivers/block/nbd.c	Fri Jul 30 12:37:43 2004
@@ -128,23 +128,11 @@ static void nbd_end_request(struct reque
 {
 	int uptodate = (req->errors == 0) ? 1 : 0;
 	request_queue_t *q = req->q;
-	struct nbd_device *lo = req->rq_disk->private_data;
 	unsigned long flags;
 
 	dprintk(DBG_BLKDEV, "%s: request %p: %s\n", req->rq_disk->disk_name,
 			req, uptodate? "done": "failed");
 
-	spin_lock(&lo->queue_lock);
-	while (req->ref_count > 1) { /* still in send */
-		spin_unlock(&lo->queue_lock);
-		printk(KERN_DEBUG "%s: request %p still in use (%d), waiting\n",
-		    lo->disk->disk_name, req, req->ref_count);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ); /* wait a second */
-		spin_lock(&lo->queue_lock);
-	}
-	spin_unlock(&lo->queue_lock);
-
 	spin_lock_irqsave(q->queue_lock, flags);
 	if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
 		end_that_request_last(req);
@@ -234,7 +222,7 @@ static inline int sock_send_bvec(struct 
 	return result;
 }
 
-void nbd_send_req(struct nbd_device *lo, struct request *req)
+static int nbd_send_req(struct nbd_device *lo, struct request *req)
 {
 	int result, i, flags;
 	struct nbd_request request;
@@ -294,11 +282,11 @@ void nbd_send_req(struct nbd_device *lo,
 		}
 	}
 	up(&lo->tx_lock);
-	return;
+	return 0;
 
 error_out:
 	up(&lo->tx_lock);
-	req->errors++;
+	return 1;
 }
 
 static struct request *nbd_find_request(struct nbd_device *lo, char *handle)
@@ -483,26 +471,19 @@ static void do_nbd_request(request_queue
 		}
 
 		list_add(&req->queuelist, &lo->queue_head);
-		req->ref_count++; /* make sure req does not get freed */
 		spin_unlock(&lo->queue_lock);
 
-		nbd_send_req(lo, req);
-
-		if (req->errors) {
+		if (nbd_send_req(lo, req) != 0) {
 			printk(KERN_ERR "%s: Request send failed\n",
 					lo->disk->disk_name);
-			spin_lock(&lo->queue_lock);
-			list_del_init(&req->queuelist);
-			req->ref_count--;
-			spin_unlock(&lo->queue_lock);
-			nbd_end_request(req);
-			spin_lock_irq(q->queue_lock);
-			continue;
+			if (nbd_find_request(lo, (char *)&req) != NULL) {
+				/* we still own req */
+				req->errors++;
+				nbd_end_request(req);
+			} else /* we're racing with nbd_clear_que */
+				printk(KERN_DEBUG "nbd: can't find req\n");
 		}
 
-		spin_lock(&lo->queue_lock);
-		req->ref_count--;
-		spin_unlock(&lo->queue_lock);
 		spin_lock_irq(q->queue_lock);
 		continue;
 

--------------070005090605010103070907--
