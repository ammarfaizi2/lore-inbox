Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271827AbTHHUJQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 16:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271831AbTHHUJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 16:09:16 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:32516 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S271827AbTHHUI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 16:08:59 -0400
Message-ID: <3F3402F7.A8986417@SteelEye.com>
Date: Fri, 08 Aug 2003 16:07:19 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Lou Langholtz <ldl@aros.net>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.0-test2-mm] nbd: fix send/receive/shutdown/disconnect races
References: <3F2FE078.6020305@aros.net> <3F300760.8F703814@SteelEye.com> <3F303430.1080908@aros.net> <3F30510A.E918924B@SteelEye.com> <3F30AF81.4070308@aros.net> <3F332ED7.712DFE5D@SteelEye.com> <3F334396.7030008@aros.net> <3F33D41E.89CFA182@SteelEye.com>
Content-Type: multipart/mixed;
 boundary="------------873E788DA8D98DBB005A05B5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------873E788DA8D98DBB005A05B5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here's the updated patch to fix several race conditions in nbd. It
requires reverting the already included (but incomplete)
nbd-race-fix.patch that's in -mm5.

This patch fixes the following race conditions:

1) adds an increment of req->ref_count to eliminate races between
do_nbd_request and nbd_end_request, which resulted in the freeing of
in-use requests -- there were races between send/receive, send/shutdown
(killall -9 nbd-client), and send/disconnect (nbd-client -d), which are
now all fixed

2) adds locking and properly orders the code in NBD_CLEAR_SOCK to
eliminate races with other code

3) adds an lo->sock check to nbd_clear_que to eliminate races between
do_nbd_request and nbd_clear_que, which resulted in the dequeuing of
active requests

4) adds an lo->sock check to NBD_DO_IT to eliminate races with
NBD_CLEAR_SOCK, which caused an Oops when "nbd-client -d" was called

--
Paul
--------------873E788DA8D98DBB005A05B5
Content-Type: text/x-diff; charset=us-ascii;
 name="nbd-race_fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-race_fixes.diff"

--- linux-2.6.0-test2-mm4-PRISTINE/drivers/block/nbd.c	Sun Jul 27 12:58:51 2003
+++ linux-2.6.0-test2-mm4/drivers/block/nbd.c	Fri Aug  8 15:23:33 2003
@@ -136,10 +136,23 @@ static void nbd_end_request(struct reque
 {
 	int uptodate = (req->errors == 0) ? 1 : 0;
 	request_queue_t *q = req->q;
+	struct nbd_device *lo = req->rq_disk->private_data;
 	unsigned long flags;
 
 	dprintk(DBG_BLKDEV, "%s: request %p: %s\n", req->rq_disk->disk_name,
 			req, uptodate? "done": "failed");
+
+	spin_lock(&lo->queue_lock);
+	while (req->ref_count > 1) { /* still in send */
+		spin_unlock(&lo->queue_lock);
+		printk(KERN_DEBUG "%s: request %p still in use (%d), waiting\n",
+		    lo->disk->disk_name, req, req->ref_count);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ); /* wait a second */
+		spin_lock(&lo->queue_lock);
+	}
+	spin_unlock(&lo->queue_lock);
+
 #ifdef PARANOIA
 	requests_out++;
 #endif
@@ -490,6 +503,7 @@ static void do_nbd_request(request_queue
 		}
 
 		list_add(&req->queuelist, &lo->queue_head);
+		req->ref_count++; /* make sure req does not get freed */
 		spin_unlock(&lo->queue_lock);
 
 		nbd_send_req(lo, req);
@@ -499,12 +513,16 @@ static void do_nbd_request(request_queue
 					lo->disk->disk_name);
 			spin_lock(&lo->queue_lock);
 			list_del_init(&req->queuelist);
+			req->ref_count--;
 			spin_unlock(&lo->queue_lock);
 			nbd_end_request(req);
 			spin_lock_irq(q->queue_lock);
 			continue;
 		}
 
+		spin_lock(&lo->queue_lock);
+		req->ref_count--;
+		spin_unlock(&lo->queue_lock);
 		spin_lock_irq(q->queue_lock);
 		continue;
 
@@ -548,27 +566,27 @@ static int nbd_ioctl(struct inode *inode
                 if (!lo->sock)
 			return -EINVAL;
                 nbd_send_req(lo, &sreq);
-                return 0 ;
+                return 0;
  
 	case NBD_CLEAR_SOCK:
+		error = 0;
+		down(&lo->tx_lock);
+		lo->sock = NULL;
+		up(&lo->tx_lock);
+		spin_lock(&lo->queue_lock);
+		file = lo->file;
+		lo->file = NULL;
+		spin_unlock(&lo->queue_lock);
 		nbd_clear_que(lo);
 		spin_lock(&lo->queue_lock);
 		if (!list_empty(&lo->queue_head)) {
-			spin_unlock(&lo->queue_lock);
-			printk(KERN_ERR "%s: Some requests are in progress -> can not turn off.\n",
-					lo->disk->disk_name);
-			return -EBUSY;
+			printk(KERN_ERR "nbd: disconnect: some requests are in progress -> please try again.\n");
+			error = -EBUSY;
 		}
-		file = lo->file;
-		if (!file) {
-			spin_unlock(&lo->queue_lock);
-			return -EINVAL;
-		}
-		lo->file = NULL;
-		lo->sock = NULL;
 		spin_unlock(&lo->queue_lock);
-		fput(file);
-		return 0;
+		if (file)
+			fput(file);
+		return error;
 	case NBD_SET_SOCK:
 		if (lo->file)
 			return -EBUSY;
@@ -616,10 +634,13 @@ static int nbd_ioctl(struct inode *inode
 		 * there should be a more generic interface rather than
 		 * calling socket ops directly here */
 		down(&lo->tx_lock);
-		printk(KERN_WARNING "%s: shutting down socket\n",
+		if (lo->sock) {
+			printk(KERN_WARNING "%s: shutting down socket\n",
 				lo->disk->disk_name);
-		lo->sock->ops->shutdown(lo->sock, SEND_SHUTDOWN|RCV_SHUTDOWN);
-		lo->sock = NULL;
+			lo->sock->ops->shutdown(lo->sock,
+				SEND_SHUTDOWN|RCV_SHUTDOWN);
+			lo->sock = NULL;
+		}
 		up(&lo->tx_lock);
 		spin_lock(&lo->queue_lock);
 		file = lo->file;
@@ -631,6 +652,13 @@ static int nbd_ioctl(struct inode *inode
 			fput(file);
 		return lo->harderror;
 	case NBD_CLEAR_QUE:
+		down(&lo->tx_lock);
+		if (lo->sock) {
+			up(&lo->tx_lock);
+			return 0; /* probably should be error, but that would
+				   * break "nbd-client -d", so just return 0 */
+		}
+		up(&lo->tx_lock);
 		nbd_clear_que(lo);
 		return 0;
 	case NBD_PRINT_DEBUG:

--------------873E788DA8D98DBB005A05B5--

