Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271204AbTHHFD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 01:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271205AbTHHFD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 01:03:58 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:36869 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S271204AbTHHFDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 01:03:54 -0400
Message-ID: <3F332ED7.712DFE5D@SteelEye.com>
Date: Fri, 08 Aug 2003 01:02:15 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lou Langholtz <ldl@aros.net>, Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 NBD driver: remove send/recieve race for request
References: <3F2FE078.6020305@aros.net> <3F300760.8F703814@SteelEye.com> <3F303430.1080908@aros.net> <3F30510A.E918924B@SteelEye.com> <3F30AF81.4070308@aros.net>
Content-Type: multipart/mixed;
 boundary="------------38AC7E28CC256138A3D356C8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------38AC7E28CC256138A3D356C8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Lou Langholtz wrote:
> 
> Paul Clements wrote:
> 
> >>Except that in the error case, the send basically didn't succeed. So no
> >>need to worry about recieving a reply and no race possibility in that case.
> >
> >As long as the request is on the queue, it is possible for nbd-client to
> >die, thus freeing the request (via nbd_clear_que -> nbd_end_request),
> >and leaving us with a race between the free and do_nbd_request()
> >accessing the request structure.
>
> Quite right. I missed that case in this last patch (when nbd_do_it has
> returned and NBD_DO_IT is about to call nbd_clear_que [1]). Just moving
> the errors increment (near the end of nbd_send_req) to within the
> semaphore protected region would fix this particular case. An even
> larger race window exists with the request getting free'd when
> nbd-client is used to disconnect in which it calls NBD_CLEAR_QUE before
> NBD_DISCONNECT [2]. In this case, moving the errors increment doesn't
> help of course since the nbd_clear_queue in 2.6.0-test2 doesn't bother
> to check the tx_lock semaphore anyway. I believe reference counting the
> request (as you suggest) would protect against both these windows though.

> Will you be working on closing the other clear-queue race also then?

Here's the patch to fix up several race conditions in nbd. It requires
reverting the already included (but admittedly incomplete)
nbd-race-fix.patch that's in -mm5.

Andrew, please apply.

Thanks,
Paul
--------------38AC7E28CC256138A3D356C8
Content-Type: text/x-diff; charset=us-ascii;
 name="nbd-race_fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-race_fixes.diff"

--- linux-2.6.0-test2-mm4-PRISTINE/drivers/block/nbd.c	Sun Jul 27 12:58:51 2003
+++ linux-2.6.0-test2-mm4/drivers/block/nbd.c	Thu Aug  7 18:02:23 2003
@@ -416,11 +416,19 @@ void nbd_clear_que(struct nbd_device *lo
 	BUG_ON(lo->magic != LO_MAGIC);
 #endif
 
+retry:
 	do {
 		req = NULL;
 		spin_lock(&lo->queue_lock);
 		if (!list_empty(&lo->queue_head)) {
 			req = list_entry(lo->queue_head.next, struct request, queuelist);
+			if (req->ref_count > 1) { /* still in xmit */
+				spin_unlock(&lo->queue_lock);
+				printk(KERN_DEBUG "%s: request %p: still in use (%d), waiting...\n",
+				    lo->disk->disk_name, req, req->ref_count);
+				schedule_timeout(HZ); /* wait a second */
+				goto retry;
+			}
 			list_del_init(&req->queuelist);
 		}
 		spin_unlock(&lo->queue_lock);
@@ -490,6 +498,7 @@ static void do_nbd_request(request_queue
 		}
 
 		list_add(&req->queuelist, &lo->queue_head);
+		req->ref_count++; /* make sure req does not get freed */
 		spin_unlock(&lo->queue_lock);
 
 		nbd_send_req(lo, req);
@@ -499,12 +508,14 @@ static void do_nbd_request(request_queue
 					lo->disk->disk_name);
 			spin_lock(&lo->queue_lock);
 			list_del_init(&req->queuelist);
+			req->ref_count--;
 			spin_unlock(&lo->queue_lock);
 			nbd_end_request(req);
 			spin_lock_irq(q->queue_lock);
 			continue;
 		}
 
+		req->ref_count--;
 		spin_lock_irq(q->queue_lock);
 		continue;
 
@@ -548,27 +559,27 @@ static int nbd_ioctl(struct inode *inode
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
@@ -616,10 +627,13 @@ static int nbd_ioctl(struct inode *inode
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

--------------38AC7E28CC256138A3D356C8--

