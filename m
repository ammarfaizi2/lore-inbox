Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbTFYGhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 02:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTFYGhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 02:37:39 -0400
Received: from dm5-202.slc.aros.net ([66.219.220.202]:50326 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S262143AbTFYGh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 02:37:27 -0400
Message-ID: <3EF94672.3030201@aros.net>
Date: Wed, 25 Jun 2003 00:51:31 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>
Subject: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl UI
Content-Type: multipart/mixed;
 boundary="------------090702030303070005080707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090702030303070005080707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please review and comment...

This is the sixth patch to the NBD driver and it fixes a variety of 
outstanding locking issues with the ioctl user interface. This patch 
modifies both drivers/block/nbd.c and include/linux/nbd.h. It's intended 
to be applied incrementally (on top of the fifth patch).

Of major note is that since the linux 2.5 change in the block layer 
code, the distributions of the nbd-client user tool that I am familiar 
with (including the one in my anbd distribution up through release 0.4) 
will already be unable to correctly set the size of the served block 
device. This happens because nbd-client opens the nbd, calls the set 
size ioctl on its descriptor and eventually calls the do_it ioctl with 
that same still opened descriptor. The set size ioctl essentially just 
calls set_capacity() on the relevant gendisk structure. In the new block 
layer code however, the nbd descriptor has to be released after the set 
size ioctl call and then re-opened in order for the correct size to be 
registered by other openers. This could also be worked around in the 
driver but it has not been done (yet).

That said, this seems like an opportunistic time to further break 
compatibility with the existing nbd-client user tool and  do away with 
the problematic components of the ioctl user interface. This patch 
deprecates two ioctl's (NBD_SET_SOCK and NBD_CLEAR_SOCK) and changes the 
usage of the NBD_DO_IT ioctl to take the socket descriptor as its 
argument. As such, NBD_DO_IT rolls all the functionality of the three 
ioctls into just one. It simplifies the user interface and makes 
resource locking much easier. Consequently, several race conditions can 
be cleaned up in the driver itself (rather than via work arounds in 
nbd-client).

There are other ways of course... the new NBD_DO_IT style interface 
could be introduced instead as another ioctl completely and these 3 
ioctls could be maintained for backward compatibility for a while 
longer. That seems contradictory though to the idea of keeping the 
newest code the cleanest but at least it doesn't break existing 
nbd-client tools.

So look at the patch if you're interested and let me know what you 
think. Please don't make it part of the kernel distro though, at least 
not yet. I'll be "disconnected" from Thursday through Sunday so I won't 
be able to do any fixes should this introduce more problems than it 
fixes till next week.

--------------090702030303070005080707
Content-Type: text/plain;
 name="nbd-patch6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-patch6"

diff -urN linux-2.5.73-p5/drivers/block/nbd.c linux-2.5.73-p6/drivers/block/nbd.c
--- linux-2.5.73-p5/drivers/block/nbd.c	2003-06-24 21:44:14.114372240 -0600
+++ linux-2.5.73-p6/drivers/block/nbd.c	2003-06-24 21:43:09.565848344 -0600
@@ -36,6 +36,11 @@
  * 03-06-24 Remove unneeded blksize_bits field from nbd_device struct.
  *   <ldl@aros.net>
  * 03-06-24 Cleanup PARANOIA usage & code. <ldl@aros.net>
+ * 03-06-24 Fix resource locking issues with ioctl user interface. Note that
+ *   this change is incompatible with existing user tools (nbd-client) and
+ *   require them to be updated. Actually, the linux 2.5 block layer redisign
+ *   already required existing user tools to be updated to properly set the
+ *   correct device size. <ldl@aros.net>
  *
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
@@ -137,21 +142,26 @@
 }
 #endif /* NDEBUG */
 
-static void nbd_end_request(struct request *req)
+static void request_end_while_locked(struct request *req)
 {
 	int uptodate = (req->errors == 0) ? 1 : 0;
-	request_queue_t *q = req->q;
-	unsigned long flags;
 
 	dprintk(DBG_BLKDEV, "%s: request %p: %s\n", req->rq_disk->disk_name,
 			req, uptodate? "done": "failed");
+	if (!end_that_request_first(req, uptodate, req->nr_sectors))
+		end_that_request_last(req);
 #ifdef PARANOIA
 	requests_out++;
 #endif
+}
+
+static void request_end(struct request *req)
+{
+	unsigned long flags;
+	request_queue_t *q = req->q;
+
 	spin_lock_irqsave(q->queue_lock, flags);
-	if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
-		end_that_request_last(req);
-	}
+	request_end_while_locked(req);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
@@ -239,7 +249,7 @@
 	return result;
 }
 
-void nbd_send_req(struct nbd_device *lo, struct request *req)
+static void nbd_send_req(struct nbd_device *lo, struct request *req)
 {
 	int result, i, flags;
 	struct nbd_request request;
@@ -252,13 +262,7 @@
 	request.len = htonl(size);
 	memcpy(request.handle, &req, sizeof(req));
 
-	down(&lo->tx_lock);
-
-	if (!sock || !lo->sock) {
-		printk(KERN_ERR "%s: Attempted send on closed socket\n",
-				lo->disk->disk_name);
-		goto error_out;
-	}
+	BUG_ON(sock == NULL);
 
 	dprintk(DBG_TX, "%s: request %p: sending control (%s@%llu,%luB)\n",
 			lo->disk->disk_name, req,
@@ -297,11 +301,9 @@
 			}
 		}
 	}
-	up(&lo->tx_lock);
 	return;
 
-      error_out:
-	up(&lo->tx_lock);
+error_out:
 	req->errors++;
 }
 
@@ -398,28 +400,15 @@
 	return req;
 }
 
-void nbd_do_it(struct nbd_device *lo)
+static int nbd_clear_que(struct nbd_device *lo)
 {
 	struct request *req;
 
-#ifdef PARANOIA
-	BUG_ON(lo->magic != LO_MAGIC);
-#endif
-	while ((req = nbd_read_stat(lo)) != NULL)
-		nbd_end_request(req);
-	printk(KERN_NOTICE "%s: req should never be null\n",
-			lo->disk->disk_name);
-	return;
-}
-
-void nbd_clear_que(struct nbd_device *lo)
-{
-	struct request *req;
-
-#ifdef PARANOIA
-	BUG_ON(lo->magic != LO_MAGIC);
-#endif
-
+	down(&lo->tx_lock);
+	if (lo->sock) {
+		up(&lo->tx_lock);
+		return -EBUSY;
+	}
 	do {
 		req = NULL;
 		spin_lock(&lo->queue_lock);
@@ -430,16 +419,18 @@
 		spin_unlock(&lo->queue_lock);
 		if (req) {
 			req->errors++;
-			nbd_end_request(req);
+			request_end(req);
 		}
 	} while (req);
+	up(&lo->tx_lock);
+	return 0;
 }
 
 /*
  * We always wait for result of write, for now. It would be nice to make it optional
  * in future
  * if ((req->cmd == WRITE) && (lo->flags & NBD_WRITE_NOCHK)) 
- *   { printk( "Warning: Ignoring result!\n"); nbd_end_request( req ); }
+ *   { printk( "Warning: Ignoring result!\n"); request_end( req ); }
  */
 
 static void do_nbd_request(request_queue_t * q)
@@ -448,75 +439,69 @@
 	
 	while ((req = elv_next_request(q)) != NULL) {
 		struct nbd_device *lo;
+		int notready;
 
 		blkdev_dequeue_request(req);
+#ifdef PARANOIA
+		requests_in++;
+#endif
+		req->errors = 0;
 		dprintk(DBG_BLKDEV, "%s: request %p: dequeued (flags=%lx)\n",
 				req->rq_disk->disk_name, req, req->flags);
 
 		if (!(req->flags & REQ_CMD))
-			goto error_out;
+			goto fail_request;
 
 		lo = req->rq_disk->private_data;
 #ifdef PARANOIA
 		BUG_ON(lo->magic != LO_MAGIC);
 #endif
-		if (!lo->file) {
-			printk(KERN_ERR "%s: Request when not-ready\n",
-					lo->disk->disk_name);
-			goto error_out;
-		}
+
 		nbd_cmd(req) = NBD_CMD_READ;
 		if (rq_data_dir(req) == WRITE) {
 			nbd_cmd(req) = NBD_CMD_WRITE;
 			if (lo->flags & NBD_READ_ONLY) {
 				printk(KERN_ERR "%s: Write on read-only\n",
 						lo->disk->disk_name);
-				goto error_out;
+				goto fail_request;
 			}
 		}
-#ifdef PARANOIA
-		requests_in++;
-#endif
 
-		req->errors = 0;
 		spin_unlock_irq(q->queue_lock);
-
-		spin_lock(&lo->queue_lock);
-
-		if (!lo->file) {
-			spin_unlock(&lo->queue_lock);
-			printk(KERN_ERR "%s: failed between accept and semaphore, file lost\n",
-					lo->disk->disk_name);
-			req->errors++;
-			nbd_end_request(req);
-			spin_lock_irq(q->queue_lock);
-			continue;
-		}
-
-		list_add(&req->queuelist, &lo->queue_head);
-		spin_unlock(&lo->queue_lock);
-
-		nbd_send_req(lo, req);
-
-		if (req->errors) {
-			printk(KERN_ERR "%s: Request send failed\n",
-					lo->disk->disk_name);
+		down(&lo->tx_lock);
+		if (lo->sock) {
+			notready = 0;
 			spin_lock(&lo->queue_lock);
-			list_del_init(&req->queuelist);
+			list_add(&req->queuelist, &lo->queue_head);
 			spin_unlock(&lo->queue_lock);
-			nbd_end_request(req);
-			spin_lock_irq(q->queue_lock);
-			continue;
+			nbd_send_req(lo, req);
+			if (req->errors) {
+				printk(KERN_ERR "%s: Request send failed\n",
+						lo->disk->disk_name);
+				spin_lock(&lo->queue_lock);
+				list_del_init(&req->queuelist);
+				spin_unlock(&lo->queue_lock);
+			}
 		}
-
+		else
+			notready = 1;
+		up(&lo->tx_lock);
 		spin_lock_irq(q->queue_lock);
+		if (notready) {
+			printk(KERN_ERR "%s: Request when not-ready\n",
+					lo->disk->disk_name);
+			req->errors++;
+			request_end_while_locked(req);
+		}
 		continue;
 
-	      error_out:
+fail_request:
+		/*
+		 * Fail the request: anyone waiting on a read or write gets
+		 * an error and can move on to their close() call.
+		 */
 		req->errors++;
-		spin_unlock(q->queue_lock);
-		nbd_end_request(req);
-		spin_lock(q->queue_lock);
+		request_end_while_locked(req);
 	}
 	return;
 }
@@ -548,12 +533,86 @@
 	return 0;
 }
 
+static int nbd_do_it(struct nbd_device *lo, unsigned int fd)
+{
+	struct file *file;
+	struct inode *inode;
+	struct socket *sock;
+	struct request *req;
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+	inode = file->f_dentry->d_inode;
+	if (!inode->i_sock) {
+		fput(file);
+		return -ENOTSOCK;
+	}
+	sock = SOCKET_I(inode);
+	if (sock->type != SOCK_STREAM) {
+		fput(file);
+		return -EPROTONOSUPPORT;
+	}
+
+	down(&lo->tx_lock);
+	if (lo->sock) {
+		up(&lo->tx_lock);
+		fput(file);
+		return -EBUSY;
+	}
+	lo->sock = sock;
+	up(&lo->tx_lock);
+
+	/* no need for rx lock since here is the rx... */
+	dprintk(DBG_IOCTL, "%s: nbd_do_it: commencing read loop\n",
+			lo->disk->disk_name);
+	while ((req = nbd_read_stat(lo)) != NULL)
+		request_end(req);
+	dprintk(DBG_IOCTL, "%s: nbd_do_it: read loop finished\n",
+			lo->disk->disk_name);
+
+	down(&lo->tx_lock);
+	lo->sock = NULL;
+	up(&lo->tx_lock);
+
+	fput(file);
+	return lo->harderror;
+}
+
+static int nbd_disconnect(struct nbd_device *lo)
+{
+	int error;
+	struct request sreq;
+
+	printk(KERN_INFO "%s: NBD_DISCONNECT\n", lo->disk->disk_name);
+
+	sreq.flags = REQ_SPECIAL;
+	nbd_cmd(&sreq) = NBD_CMD_DISC;
+
+	/*
+	 * Set sreq to sane values in case server implementation
+	 * fails to check the request type first and also to keep
+	 * debugging output cleaner.
+	 */
+	sreq.sector = 0;
+	sreq.nr_sectors = 0;
+
+	down(&lo->tx_lock);
+	if (lo->sock) {
+		error = 0;
+		nbd_send_req(lo, &sreq);
+	}
+	else {
+		error = -ENOTCONN;
+	}
+	up(&lo->tx_lock);
+	return error;
+}
+
 static int nbd_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
 	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
-	int error;
-	struct request sreq ;
 
 #ifdef PARANOIA
 	BUG_ON(lo->magic != LO_MAGIC);
@@ -565,57 +624,15 @@
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	switch (cmd) {
+	case NBD_CLEAR_SOCK: /* deprecated! */
+	case NBD_SET_SOCK: /* deprecated! */
+		printk(KERN_WARNING "%s: %s[%d] called deprecated ioctl %s\n",
+				lo->disk->disk_name,
+				current->comm, current->pid,
+				ioctl_cmd_to_ascii(cmd));
+		return -EINVAL;
 	case NBD_DISCONNECT:
-	        printk(KERN_INFO "%s: NBD_DISCONNECT\n", lo->disk->disk_name);
-		sreq.flags = REQ_SPECIAL;
-		nbd_cmd(&sreq) = NBD_CMD_DISC;
-		/*
-		 * Set these to sane values in case server implementation
-		 * fails to check the request type first and also to keep
-		 * debugging output cleaner.
-		 */
-		sreq.sector = 0;
-		sreq.nr_sectors = 0;
-                if (!lo->sock)
-			return -EINVAL;
-                nbd_send_req(lo, &sreq);
-                return 0 ;
- 
-	case NBD_CLEAR_SOCK:
-		nbd_clear_que(lo);
-		spin_lock(&lo->queue_lock);
-		if (!list_empty(&lo->queue_head)) {
-			spin_unlock(&lo->queue_lock);
-			printk(KERN_ERR "%s: Some requests are in progress -> can not turn off.\n",
-					lo->disk->disk_name);
-			return -EBUSY;
-		}
-		file = lo->file;
-		if (!file) {
-			spin_unlock(&lo->queue_lock);
-			return -EINVAL;
-		}
-		lo->file = NULL;
-		lo->sock = NULL;
-		spin_unlock(&lo->queue_lock);
-		fput(file);
-		return 0;
-	case NBD_SET_SOCK:
-		if (lo->file)
-			return -EBUSY;
-		error = -EINVAL;
-		file = fget(arg);
-		if (file) {
-			inode = file->f_dentry->d_inode;
-			if (inode->i_sock) {
-				lo->file = file;
-				lo->sock = SOCKET_I(inode);
-				error = 0;
-			} else {
-				fput(file);
-			}
-		}
-		return error;
+		return nbd_disconnect(lo);
 	case NBD_SET_BLKSIZE:
 		if ((arg & (arg-1)) || (arg < 512) || (arg > PAGE_SIZE))
 			return -EINVAL;
@@ -632,34 +649,9 @@
 		set_capacity(lo->disk, lo->bytesize >> 9);
 		return 0;
 	case NBD_DO_IT:
-		if (!lo->file)
-			return -EINVAL;
-		nbd_do_it(lo);
-		/* on return tidy up in case we have a signal */
-		/* Forcibly shutdown the socket causing all listeners
-		 * to error
-		 *
-		 * FIXME: This code is duplicated from sys_shutdown, but
-		 * there should be a more generic interface rather than
-		 * calling socket ops directly here */
-		down(&lo->tx_lock);
-		printk(KERN_WARNING "%s: shutting down socket\n",
-				lo->disk->disk_name);
-		lo->sock->ops->shutdown(lo->sock, SEND_SHUTDOWN|RCV_SHUTDOWN);
-		lo->sock = NULL;
-		up(&lo->tx_lock);
-		spin_lock(&lo->queue_lock);
-		file = lo->file;
-		lo->file = NULL;
-		spin_unlock(&lo->queue_lock);
-		nbd_clear_que(lo);
-		printk(KERN_WARNING "%s: queue cleared\n", lo->disk->disk_name);
-		if (file)
-			fput(file);
-		return lo->harderror;
+		return nbd_do_it(lo, arg);
 	case NBD_CLEAR_QUE:
-		nbd_clear_que(lo);
-		return 0;
+		return nbd_clear_que(lo);
 	case NBD_PRINT_DEBUG:
 #ifdef PARANOIA
 		printk(KERN_INFO "%s: next = %p, prev = %p. Global: in %d, out %d\n",
@@ -731,7 +723,6 @@
 	for (i = 0; i < MAX_NBD; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
 		nbd_dev[i].refcnt = 0;
-		nbd_dev[i].file = NULL;
 #ifdef PARANOIA
 		nbd_dev[i].magic = LO_MAGIC;
 #endif
diff -urN linux-2.5.73-p5/include/linux/nbd.h linux-2.5.73-p6/include/linux/nbd.h
--- linux-2.5.73-p5/include/linux/nbd.h	2003-06-24 21:48:44.697043654 -0600
+++ linux-2.5.73-p6/include/linux/nbd.h	2003-06-24 21:48:29.595035591 -0600
@@ -8,6 +8,7 @@
  * 2003/06/24 Louis D. Langholtz <ldl@aros.net>
  *            Removed unneeded blksize_bits field from nbd_device struct.
  *            Cleanup PARANOIA usage & code.
+ *            Removed unneeded file field from nbd_device struct.
  */
 
 #ifndef LINUX_NBD_H
@@ -42,7 +43,6 @@
 #define NBD_READ_ONLY 0x0001
 #define NBD_WRITE_NOCHK 0x0002
 	struct socket * sock;
-	struct file * file; 	/* If == NULL, device is not ready, yet	*/
 #ifdef PARANOIA
 	int magic;		/* FIXME: not if debugging is off	*/
 #endif

--------------090702030303070005080707--

