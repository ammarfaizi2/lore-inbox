Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265612AbTFXBh0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 21:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265619AbTFXBh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 21:37:26 -0400
Received: from dm7-50.slc.aros.net ([66.219.221.50]:4493 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S265612AbTFXBhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 21:37:17 -0400
Message-ID: <3EF7AE96.5040006@aros.net>
Date: Mon, 23 Jun 2003 19:51:18 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>
Subject: [PATCH] nbd driver for 2.5+: cosmetics changes
Content-Type: multipart/mixed;
 boundary="------------090309060800020506010700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090309060800020506010700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This second patch (for cosmetic changes) applies incrementally after my 
last LKML'd patch (for 2.5 block layer). These changes are intended to 
help identify code inefficiencies and problems particularly w.r.t. 
locking. It also modifies some of the output messages for greater 
consistancy and better diagnostic support. This second patch is a lead 
in that way to the third patch (coming next), which introduces the 
dprintk() debugging facility that my jumbo patch originally had.

Again, feedback welcome!

PS: Andrew may have already queued this second patch up in -mm but I 
neglected to CC the LKML so here it is for everyone elses benefit.

--------------090309060800020506010700
Content-Type: text/plain;
 name="nbd-patch2.5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-patch2.5"

diff -urN linux-2.5.72-p1.5/drivers/block/nbd.c linux-2.5.72-p2.5/drivers/block/nbd.c
--- linux-2.5.72-p1.5/drivers/block/nbd.c	2003-06-22 19:13:08.000000000 -0600
+++ linux-2.5.72-p2.5/drivers/block/nbd.c	2003-06-22 23:25:14.000000000 -0600
@@ -31,6 +31,7 @@
  * 03-06-22 Make nbd work with new linux 2.5 block layer design. This fixes
  *   memory corruption from module removal and possible memory corruption
  *   from sending/receiving disk data. <ldl@aros.net>
+ * 03-06-23 Cosmetic changes. <ldl@aros.net>
  *
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
@@ -101,17 +102,11 @@
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
-static int nbd_open(struct inode *inode, struct file *file)
-{
-	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
-	lo->refcnt++;
-	return 0;
-}
-
 /*
  *  Send or receive packet.
  */
-static int nbd_xmit(int send, struct socket *sock, char *buf, int size, int msg_flags)
+static int sock_xmit(struct socket *sock, int send, void *buf, int size,
+		int msg_flags)
 {
 	mm_segment_t oldfs;
 	int result;
@@ -131,7 +126,6 @@
 	recalc_sigpending();
 	spin_unlock_irqrestore(&current->sighand->siglock, flags);
 
-
 	do {
 		sock->sk->sk_allocation = GFP_NOIO;
 		iov.iov_base = buf;
@@ -153,7 +147,7 @@
 		if (signal_pending(current)) {
 			siginfo_t info;
 			spin_lock_irqsave(&current->sighand->siglock, flags);
-			printk(KERN_WARNING "NBD (pid %d: %s) got signal %d\n",
+			printk(KERN_WARNING "nbd (pid %d: %s) got signal %d\n",
 				current->pid, current->comm, 
 				dequeue_signal(current, &current->blocked, &info));
 			spin_unlock_irqrestore(&current->sighand->siglock, flags);
@@ -163,8 +157,8 @@
 
 		if (result <= 0) {
 #ifdef PARANOIA
-			printk(KERN_ERR "NBD: %s - sock=%ld at buf=%ld, size=%d returned %d.\n",
-			       send ? "send" : "receive", (long) sock, (long) buf, size, result);
+			printk(KERN_ERR "nbd: %s - sock=%p at buf=%p, size=%d returned %d.\n",
+			       send? "send": "receive", sock, buf, size, result);
 #endif
 			break;
 		}
@@ -186,14 +180,12 @@
 {
 	int result;
 	void *kaddr = kmap(bvec->bv_page);
-	result = nbd_xmit(1, sock, kaddr + bvec->bv_offset, bvec->bv_len,
+	result = sock_xmit(sock, 1, kaddr + bvec->bv_offset, bvec->bv_len,
 			flags);
 	kunmap(bvec->bv_page);
 	return result;
 }
 
-#define FAIL( s ) { printk( KERN_ERR "NBD: " s "(result %d)\n", result ); goto error_out; }
-
 void nbd_send_req(struct nbd_device *lo, struct request *req)
 {
 	int result, i, flags;
@@ -201,24 +193,29 @@
 	unsigned long size = req->nr_sectors << 9;
 	struct socket *sock = lo->sock;
 
-	DEBUG("NBD: sending control, ");
+	DEBUG("nbd: sending control, ");
 	
 	request.magic = htonl(NBD_REQUEST_MAGIC);
 	request.type = htonl(nbd_cmd(req));
-	request.from = cpu_to_be64( (u64) req->sector << 9);
+	request.from = cpu_to_be64((u64) req->sector << 9);
 	request.len = htonl(size);
 	memcpy(request.handle, &req, sizeof(req));
 
 	down(&lo->tx_lock);
 
 	if (!sock || !lo->sock) {
-		printk(KERN_ERR "NBD: Attempted sendmsg to closed socket\n");
+		printk(KERN_ERR "%s: Attempted sendmsg to closed socket\n",
+				lo->disk->disk_name);
 		goto error_out;
 	}
 
-	result = nbd_xmit(1, sock, (char *) &request, sizeof(request), nbd_cmd(req) == NBD_CMD_WRITE ? MSG_MORE : 0);
-	if (result <= 0)
-		FAIL("Sendmsg failed for control.");
+	result = sock_xmit(sock, 1, &request, sizeof(request),
+			(nbd_cmd(req) == NBD_CMD_WRITE)? MSG_MORE: 0);
+	if (result <= 0) {
+		printk(KERN_ERR "%s: Sendmsg failed for control (result %d)\n",
+				lo->disk->disk_name, result);
+		goto error_out;
+	}
 
 	if (nbd_cmd(req) == NBD_CMD_WRITE) {
 		struct bio *bio;
@@ -234,8 +231,12 @@
 					flags = MSG_MORE;
 				DEBUG("data, ");
 				result = sock_send_bvec(sock, bvec, flags);
-				if (result <= 0)
-					FAIL("Send data failed.");
+				if (result <= 0) {
+					printk(KERN_ERR "%s: Send data failed (result %d)\n",
+							lo->disk->disk_name,
+							result);
+					goto error_out;
+				}
 			}
 		}
 	}
@@ -272,15 +273,14 @@
 {
 	int result;
 	void *kaddr = kmap(bvec->bv_page);
-	result = nbd_xmit(0, sock, kaddr + bvec->bv_offset, bvec->bv_len,
+	result = sock_xmit(sock, 0, kaddr + bvec->bv_offset, bvec->bv_len,
 			MSG_WAITALL);
 	kunmap(bvec->bv_page);
 	return result;
 }
 
-#define HARDFAIL( s ) { printk( KERN_ERR "NBD: " s "(result %d)\n", result ); lo->harderror = result; return NULL; }
+/* NULL returned = something went wrong, inform userspace */ 
 struct request *nbd_read_stat(struct nbd_device *lo)
-		/* NULL returned = something went wrong, inform userspace       */ 
 {
 	int result;
 	struct nbd_reply reply;
@@ -289,18 +289,34 @@
 
 	DEBUG("reading control, ");
 	reply.magic = 0;
-	result = nbd_xmit(0, sock, (char *) &reply, sizeof(reply), MSG_WAITALL);
-	if (result <= 0)
-		HARDFAIL("Recv control failed.");
+	result = sock_xmit(sock, 0, &reply, sizeof(reply), MSG_WAITALL);
+	if (result <= 0) {
+		printk(KERN_ERR "%s: Recv control failed (result %d)\n",
+				lo->disk->disk_name, result);
+		lo->harderror = result;
+		return NULL;
+	}
 	req = nbd_find_request(lo, reply.handle);
-	if (req == NULL)
-		HARDFAIL("Unexpected reply");
+	if (req == NULL) {
+		printk(KERN_ERR "%s: Unexpected reply (result %d)\n",
+				lo->disk->disk_name, result);
+		lo->harderror = result;
+		return NULL;
+	}
 
 	DEBUG("ok, ");
-	if (ntohl(reply.magic) != NBD_REPLY_MAGIC)
-		HARDFAIL("Not enough magic.");
-	if (ntohl(reply.error))
-		FAIL("Other side returned error.");
+	if (ntohl(reply.magic) != NBD_REPLY_MAGIC) {
+		printk(KERN_ERR "%s: Not enough magic (result %d)\n",
+				lo->disk->disk_name, result);
+		lo->harderror = result;
+		return NULL;
+	}
+	if (ntohl(reply.error)) {
+		printk(KERN_ERR "%s: Other side returned error (result %d)\n",
+				lo->disk->disk_name, result);
+		req->errors++;
+		return req;
+	}
 
 	if (nbd_cmd(req) == NBD_CMD_READ) {
 		int i;
@@ -310,35 +326,29 @@
 			struct bio_vec *bvec;
 			bio_for_each_segment(bvec, bio, i) {
 				result = sock_recv_bvec(sock, bvec);
-				if (result <= 0)
-					HARDFAIL("Recv data failed.");
+				if (result <= 0) {
+					printk(KERN_ERR "%s: Recv data failed (result %d)\n",
+							lo->disk->disk_name,
+							result);
+					lo->harderror = result;
+					return NULL;
+				}
 			}
 		}
 	}
 	DEBUG("done.\n");
 	return req;
-
-/* Can we get here? Yes, if other side returns error */
-      error_out:
-	req->errors++;
-	return req;
 }
 
 void nbd_do_it(struct nbd_device *lo)
 {
 	struct request *req;
 
-	while (1) {
-		req = nbd_read_stat(lo);
-
-		if (!req) {
-			printk(KERN_ALERT "req should never be null\n" );
-			goto out;
-		}
-		BUG_ON(lo->magic != LO_MAGIC);
+	BUG_ON(lo->magic != LO_MAGIC);
+	while ((req = nbd_read_stat(lo)) != NULL)
 		nbd_end_request(req);
-	}
- out:
+	printk(KERN_ALERT "%s: req should never be null\n",
+			lo->disk->disk_name);
 	return;
 }
 
@@ -360,7 +370,7 @@
 			req->errors++;
 			nbd_end_request(req);
 		}
-	} while(req);
+	} while (req);
 }
 
 /*
@@ -370,9 +380,6 @@
  *   { printk( "Warning: Ignoring result!\n"); nbd_end_request( req ); }
  */
 
-#undef FAIL
-#define FAIL( s ) { printk( KERN_ERR "%s: " s "\n", req->rq_disk->disk_name ); goto error_out; }
-
 static void do_nbd_request(request_queue_t * q)
 {
 	struct request *req;
@@ -380,30 +387,38 @@
 	while ((req = elv_next_request(q)) != NULL) {
 		struct nbd_device *lo;
 
+		blkdev_dequeue_request(req);
+
 		if (!(req->flags & REQ_CMD))
 			goto error_out;
 
 		lo = req->rq_disk->private_data;
-		if (!lo->file)
-			FAIL("Request when not-ready.");
+		BUG_ON(lo->magic != LO_MAGIC);
+		if (!lo->file) {
+			printk(KERN_ERR "%s: Request when not-ready\n",
+					lo->disk->disk_name);
+			goto error_out;
+		}
 		nbd_cmd(req) = NBD_CMD_READ;
 		if (rq_data_dir(req) == WRITE) {
 			nbd_cmd(req) = NBD_CMD_WRITE;
-			if (lo->flags & NBD_READ_ONLY)
-				FAIL("Write on read-only");
+			if (lo->flags & NBD_READ_ONLY) {
+				printk(KERN_ERR "%s: Write on read-only\n",
+						lo->disk->disk_name);
+				goto error_out;
+			}
 		}
-		BUG_ON(lo->magic != LO_MAGIC);
 		requests_in++;
 
 		req->errors = 0;
-		blkdev_dequeue_request(req);
 		spin_unlock_irq(q->queue_lock);
 
 		spin_lock(&lo->queue_lock);
 
 		if (!lo->file) {
 			spin_unlock(&lo->queue_lock);
-			printk(KERN_ERR "nbd: failed between accept and semaphore, file lost\n");
+			printk(KERN_ERR "%s: failed between accept and semaphore, file lost\n",
+					lo->disk->disk_name);
 			req->errors++;
 			nbd_end_request(req);
 			spin_lock_irq(q->queue_lock);
@@ -416,7 +431,8 @@
 		nbd_send_req(lo, req);
 
 		if (req->errors) {
-			printk(KERN_ERR "nbd: nbd_send_req failed\n");
+			printk(KERN_ERR "%s: nbd_send_req failed\n",
+					lo->disk->disk_name);
 			spin_lock(&lo->queue_lock);
 			list_del_init(&req->queuelist);
 			spin_unlock(&lo->queue_lock);
@@ -430,7 +446,6 @@
 
 	      error_out:
 		req->errors++;
-		blkdev_dequeue_request(req);
 		spin_unlock(q->queue_lock);
 		nbd_end_request(req);
 		spin_lock(q->queue_lock);
@@ -438,6 +453,24 @@
 	return;
 }
 
+static int nbd_open(struct inode *inode, struct file *file)
+{
+	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
+	lo->refcnt++;
+	return 0;
+}
+
+static int nbd_release(struct inode *inode, struct file *file)
+{
+	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
+	if (lo->refcnt <= 0)
+		printk(KERN_ALERT "%s: %s: refcount(%d) <= 0\n",
+				lo->disk->disk_name, __FUNCTION__, lo->refcnt);
+	lo->refcnt--;
+	/* N.B. Doesn't lo->file need an fput?? */
+	return 0;
+}
+
 static int nbd_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
@@ -451,7 +484,7 @@
 		return -EPERM;
 	switch (cmd) {
 	case NBD_DISCONNECT:
-	        printk(KERN_INFO "NBD_DISCONNECT\n");
+	        printk(KERN_INFO "%s: NBD_DISCONNECT\n", lo->disk->disk_name);
 		sreq.flags = REQ_SPECIAL;
 		nbd_cmd(&sreq) = NBD_CMD_DISC;
                 if (!lo->sock)
@@ -464,7 +497,8 @@
 		spin_lock(&lo->queue_lock);
 		if (!list_empty(&lo->queue_head)) {
 			spin_unlock(&lo->queue_lock);
-			printk(KERN_ERR "nbd: Some requests are in progress -> can not turn off.\n");
+			printk(KERN_ERR "%s: Some requests are in progress -> can not turn off.\n",
+					lo->disk->disk_name);
 			return -EBUSY;
 		}
 		file = lo->file;
@@ -526,7 +560,8 @@
 		 * there should be a more generic interface rather than
 		 * calling socket ops directly here */
 		down(&lo->tx_lock);
-		printk(KERN_WARNING "nbd: shutting down socket\n");
+		printk(KERN_WARNING "%s: shutting down socket\n",
+				lo->disk->disk_name);
 		lo->sock->ops->shutdown(lo->sock, SEND_SHUTDOWN|RCV_SHUTDOWN);
 		lo->sock = NULL;
 		up(&lo->tx_lock);
@@ -535,7 +570,7 @@
 		lo->file = NULL;
 		spin_unlock(&lo->queue_lock);
 		nbd_clear_que(lo);
-		printk(KERN_WARNING "nbd: queue cleared\n");
+		printk(KERN_WARNING "%s: queue cleared\n", lo->disk->disk_name);
 		if (file)
 			fput(file);
 		return lo->harderror;
@@ -553,16 +588,6 @@
 	return -EINVAL;
 }
 
-static int nbd_release(struct inode *inode, struct file *file)
-{
-	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
-	if (lo->refcnt <= 0)
-		printk(KERN_ALERT "nbd_release: refcount(%d) <= 0\n", lo->refcnt);
-	lo->refcnt--;
-	/* N.B. Doesn't lo->file need an fput?? */
-	return 0;
-}
-
 static struct block_device_operations nbd_fops =
 {
 	.owner =	THIS_MODULE,

--------------090309060800020506010700--

