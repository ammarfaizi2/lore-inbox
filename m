Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWILP4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWILP4u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWILP4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:56:21 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:31737 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751428AbWILPu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:50:58 -0400
Message-Id: <20060912144904.417049000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 13/20] nbd: use swapdev hook to make swap deadlock free
Content-Disposition: inline; filename=nbd_vmio.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set SOCK_VMIO on the NBD socket and make sure the request_fn always
runs with PF_MEMALLOC when used as a swapper, this ensures we can
always flush the requests.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>
CC: Pavel Machek <pavel@ucw.cz>
---
 drivers/block/nbd.c |   36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/block/nbd.c
===================================================================
--- linux-2.6.orig/drivers/block/nbd.c	2006-09-07 18:44:12.000000000 +0200
+++ linux-2.6/drivers/block/nbd.c	2006-09-07 18:44:22.000000000 +0200
@@ -139,7 +139,6 @@ static int sock_xmit(struct socket *sock
 	spin_unlock_irqrestore(&current->sighand->siglock, flags);
 
 	do {
-		sock->sk->sk_allocation = GFP_NOIO;
 		iov.iov_base = buf;
 		iov.iov_len = size;
 		msg.msg_name = NULL;
@@ -406,10 +405,13 @@ static void nbd_clear_que(struct nbd_dev
 static void do_nbd_request(request_queue_t * q)
 {
 	struct request *req;
+	unsigned long pflags = current->flags;
+	struct nbd_device *lo = q->queuedata;
+
+	if (lo->sock && sk_has_vmio(lo->sock->sk))
+		current->flags |= PF_MEMALLOC;
 	
 	while ((req = elv_next_request(q)) != NULL) {
-		struct nbd_device *lo;
-
 		blkdev_dequeue_request(req);
 		dprintk(DBG_BLKDEV, "%s: request %p: dequeued (flags=%lx)\n",
 				req->rq_disk->disk_name, req, req->flags);
@@ -417,8 +419,6 @@ static void do_nbd_request(request_queue
 		if (!(req->flags & REQ_CMD))
 			goto error_out;
 
-		lo = req->rq_disk->private_data;
-
 		BUG_ON(lo->magic != LO_MAGIC);
 
 		nbd_cmd(req) = NBD_CMD_READ;
@@ -472,6 +472,7 @@ error_out:
 	 * plug the device to close it.
 	 */
 	blk_plug_device(q);
+	current->flags = pflags;
 	return;
 }
 
@@ -530,6 +531,7 @@ static int nbd_ioctl(struct inode *inode
 			if (S_ISSOCK(inode->i_mode)) {
 				lo->file = file;
 				lo->sock = SOCKET_I(inode);
+				lo->sock->sk->sk_allocation = GFP_NOIO;
 				error = 0;
 			} else {
 				fput(file);
@@ -599,10 +601,33 @@ static int nbd_ioctl(struct inode *inode
 	return -EINVAL;
 }
 
+static int nbd_swapdev(struct gendisk *disk, int enable)
+{
+	struct nbd_device *lo = disk->private_data;
+
+	if (!lo->sock)
+		return -ENODEV;
+
+	if (enable) {
+		sk_adjust_memalloc(0, TX_RESERVE_PAGES);
+		if (!sk_set_vmio(lo->sock->sk))
+			printk(KERN_WARNING
+				"failed to set SOCK_VMIO on NBD socket\n");
+	} else {
+		if (!sk_clear_vmio(lo->sock->sk))
+			printk(KERN_WARNING
+				"failed to clear SOCK_VMIO on NBD socket\n");
+		sk_adjust_memalloc(0, -TX_RESERVE_PAGES);
+	}
+
+	return 0;
+}
+
 static struct block_device_operations nbd_fops =
 {
 	.owner =	THIS_MODULE,
 	.ioctl =	nbd_ioctl,
+	.swapdev =	nbd_swapdev,
 };
 
 /*
@@ -638,6 +663,7 @@ static int __init nbd_init(void)
 			put_disk(disk);
 			goto out;
 		}
+		disk->queue->queuedata = &nbd_dev[i];
 		blk_queue_max_segment_size(disk->queue, PAGE_SIZE);
 		blk_queue_max_hw_segments(disk->queue, 1);
 		blk_queue_max_phys_segments(disk->queue, 1);

--

