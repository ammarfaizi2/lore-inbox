Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129612AbRCAOtw>; Thu, 1 Mar 2001 09:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129614AbRCAOtn>; Thu, 1 Mar 2001 09:49:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26374 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129612AbRCAOt2>;
	Thu, 1 Mar 2001 09:49:28 -0500
Date: Thu, 1 Mar 2001 15:49:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steve Whitehouse <steve@gw.chygwyn.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NBD Cleanup patch and bugfix in ll_rw_blk.c
Message-ID: <20010301154914.Q21518@suse.de>
In-Reply-To: <200102282127.VAA20600@gw.chygwyn.com> <Pine.LNX.4.10.10102281525420.6380-100000@penguin.transmeta.com> <20010301010751.Y21518@suse.de> <200103010314.TAA06827@penguin.transmeta.com> <20010301143943.P21518@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
In-Reply-To: <20010301143943.P21518@suse.de>; from axboe@suse.de on Thu, Mar 01, 2001 at 02:39:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 01 2001, Jens Axboe wrote:
> I've suggested that before, turn ndb into ndb_make_request style
> driver and all of this will disappear. I'll give it a shot.

Here's a first shot, compile tested but that's it. Steve, does this
work for you? Against 2.4.2-ac7

-- 
Jens Axboe


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=nbd-1

diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.2-ac7/drivers/block/nbd.c linux/drivers/block/nbd.c
--- /opt/kernel/linux-2.4.2-ac7/drivers/block/nbd.c	Thu Mar  1 15:46:14 2001
+++ linux/drivers/block/nbd.c	Thu Mar  1 15:44:57 2001
@@ -24,7 +24,6 @@
  *          structure with userland
  */
 
-#undef	NBD_PLUGGABLE
 #define PARANOIA
 #include <linux/major.h>
 
@@ -44,6 +43,8 @@
 #include <asm/uaccess.h>
 #include <asm/types.h>
 
+static kmem_cache_t *nbd_cachep;
+
 #define MAJOR_NR NBD_MAJOR
 #include <linux/nbd.h>
 
@@ -66,8 +67,6 @@
 static int requests_out;
 #endif
 
-static void nbd_plug_device(request_queue_t *q, kdev_t dev) { }
-
 static int nbd_open(struct inode *inode, struct file *file)
 {
 	int dev;
@@ -145,52 +144,52 @@
 
 #define FAIL( s ) { printk( KERN_ERR "NBD: " s "(result %d)\n", result ); goto error_out; }
 
-void nbd_send_req(struct socket *sock, struct request *req)
+void nbd_send_req(struct socket *sock, struct nbd_bh *nbh)
 {
 	int result;
 	struct nbd_request request;
-	unsigned long size = req->current_nr_sectors << 9;
+	struct buffer_head *bh = nbh->bh;
 
 	DEBUG("NBD: sending control, ");
 	request.magic = htonl(NBD_REQUEST_MAGIC);
-	request.type = htonl(req->cmd);
-	request.from = cpu_to_be64( (u64) req->sector << 9);
-	request.len = htonl(size);
-	memcpy(request.handle, &req, sizeof(req));
+	request.type = htonl(nbh->cmd);
+	request.from = cpu_to_be64( (u64) bh->b_rsector << 9);
+	request.len = htonl(bh->b_size);
+	memcpy(request.handle, &nbh, sizeof(nbh));
 
 	result = nbd_xmit(1, sock, (char *) &request, sizeof(request));
 	if (result <= 0)
 		FAIL("Sendmsg failed for control.");
 
-	if (req->cmd == WRITE) {
+	if (nbh->cmd == WRITE) {
 		DEBUG("data, ");
-		result = nbd_xmit(1, sock, req->buffer, size);
+		result = nbd_xmit(1, sock, bh->b_data, bh->b_size);
 		if (result <= 0)
 			FAIL("Send data failed.");
 	}
 	return;
 
       error_out:
-	req->errors++;
+	nbh->errors++;
 }
 
 #define HARDFAIL( s ) { printk( KERN_ERR "NBD: " s "(result %d)\n", result ); lo->harderror = result; return NULL; }
-struct request *nbd_read_stat(struct nbd_device *lo)
+struct nbd_bh *nbd_read_stat(struct nbd_device *lo)
 		/* NULL returned = something went wrong, inform userspace       */ 
 {
 	int result;
 	struct nbd_reply reply;
-	struct request *xreq, *req;
+	struct nbd_bh *xnbh, *nbh;
 
 	DEBUG("reading control, ");
 	reply.magic = 0;
 	result = nbd_xmit(0, lo->sock, (char *) &reply, sizeof(reply));
 	if (result <= 0)
 		HARDFAIL("Recv control failed.");
-	memcpy(&xreq, reply.handle, sizeof(xreq));
-	req = blkdev_entry_prev_request(&lo->queue_head);
+	memcpy(&xnbh, reply.handle, sizeof(xnbh));
+	nbh = list_entry(lo->queue_head.prev, struct nbd_bh, queue);
 
-	if (xreq != req)
+	if (xnbh != nbh)
 		FAIL("Unexpected handle received.\n");
 
 	DEBUG("ok, ");
@@ -198,41 +197,37 @@
 		HARDFAIL("Not enough magic.");
 	if (ntohl(reply.error))
 		FAIL("Other side returned error.");
-	if (req->cmd == READ) {
+	if (nbh->cmd == READ) {
 		DEBUG("data, ");
-		result = nbd_xmit(0, lo->sock, req->buffer, req->current_nr_sectors << 9);
+		result = nbd_xmit(0, lo->sock, nbh->bh->b_data,nbh->bh->b_size);
 		if (result <= 0)
 			HARDFAIL("Recv data failed.");
 	}
 	DEBUG("done.\n");
-	return req;
+	return nbh;
 
 /* Can we get here? Yes, if other side returns error */
       error_out:
-	req->errors++;
-	return req;
+	nbh->errors++;
+	return nbh;
 }
 
 void nbd_do_it(struct nbd_device *lo)
 {
-	struct request *req;
-	int dequeued;
+	struct nbd_bh *nbh;
 
 	down (&lo->queue_lock);
 	while (1) {
 		up (&lo->queue_lock);
-		req = nbd_read_stat(lo);
+		nbh = nbd_read_stat(lo);
 		down (&lo->queue_lock);
 
-		if (!req) {
+		if (!nbh) {
 			printk(KERN_ALERT "req should never be null\n" );
 			goto out;
 		}
 #ifdef PARANOIA
-		if (req != blkdev_entry_prev_request(&lo->queue_head)) {
-			printk(KERN_ALERT "NBD: I have problem...\n");
-		}
-		if (lo != &nbd_dev[MINOR(req->rq_dev)]) {
+		if (lo != &nbd_dev[MINOR(nbh->bh->b_rdev)]) {
 			printk(KERN_ALERT "NBD: request corrupted!\n");
 			continue;
 		}
@@ -241,14 +236,12 @@
 			goto out;
 		}
 #endif
-		list_del(&req->queue);
+		list_del(&nbh->queue);
 		up (&lo->queue_lock);
 		
-		dequeued = nbd_end_request(req);
+		nbd_end_request(nbh);
 
 		down (&lo->queue_lock);
-		if (!dequeued)
-			list_add(&req->queue, &lo->queue_head);
 	}
  out:
 	up (&lo->queue_lock);
@@ -256,8 +249,7 @@
 
 void nbd_clear_que(struct nbd_device *lo)
 {
-	struct request *req;
-	int dequeued;
+	struct nbd_bh *nbh;
 
 #ifdef PARANOIA
 	if (lo->magic != LO_MAGIC) {
@@ -267,29 +259,43 @@
 #endif
 
 	while (!list_empty(&lo->queue_head)) {
-		req = blkdev_entry_prev_request(&lo->queue_head);
+		nbh = list_entry(lo->queue_head.prev, struct nbd_bh, queue);
 #ifdef PARANOIA
-		if (!req) {
-			printk( KERN_ALERT "NBD: panic, panic, panic\n" );
-			break;
-		}
-		if (lo != &nbd_dev[MINOR(req->rq_dev)]) {
+		if (lo != &nbd_dev[MINOR(nbh->bh->b_rdev)]) {
 			printk(KERN_ALERT "NBD: request corrupted when clearing!\n");
 			continue;
 		}
 #endif
-		req->errors++;
-		list_del(&req->queue);
+		nbh->errors++;
+		list_del(&nbh->queue);
 		up(&lo->queue_lock);
 
-		dequeued = nbd_end_request(req);
+		nbd_end_request(nbh);
 
 		down(&lo->queue_lock);
-		if (!dequeued)
-			list_add(&req->queue, &lo->queue_head);
 	}
 }
 
+static struct nbd_bh *nbd_alloc_bh(struct buffer_head *bh, int rw)
+{
+	struct nbd_bh *nbh;
+
+	do {
+		nbh = kmem_cache_alloc(nbd_cachep, SLAB_BUFFER);
+		if (nbh)
+			break;
+
+		run_task_queue(&tq_disk);
+		schedule_timeout(HZ);
+	} while (1);
+
+	nbh->bh = bh;
+	nbh->cmd = rw;
+	nbh->errors = 0;
+	INIT_LIST_HEAD(&nbh->queue);
+	return nbh;
+}
+
 /*
  * We always wait for result of write, for now. It would be nice to make it optional
  * in future
@@ -300,53 +306,45 @@
 #undef FAIL
 #define FAIL( s ) { printk( KERN_ERR "NBD, minor %d: " s "\n", dev ); goto error_out; }
 
-static void do_nbd_request(request_queue_t * q)
+static int nbd_make_request(request_queue_t *q, int rw, struct buffer_head *bh)
 {
-	struct request *req;
 	int dev = 0;
 	struct nbd_device *lo;
+	struct nbd_bh *nbh;
 
-	while (!QUEUE_EMPTY) {
-		req = CURRENT;
+	dev = MINOR(bh->b_rdev);
 #ifdef PARANOIA
-		if (!req)
-			FAIL("que not empty but no request?");
-#endif
-		dev = MINOR(req->rq_dev);
-#ifdef PARANOIA
-		if (dev >= MAX_NBD)
-			FAIL("Minor too big.");		/* Probably can not happen */
+	if (dev >= MAX_NBD)
+		FAIL("Minor too big.");		/* Probably can not happen */
 #endif
-		lo = &nbd_dev[dev];
-		if (!lo->file)
-			FAIL("Request when not-ready.");
-		if ((req->cmd == WRITE) && (lo->flags & NBD_READ_ONLY))
-			FAIL("Write on read-only");
+	lo = &nbd_dev[dev];
+	if (!lo->file)
+		FAIL("Request when not-ready.");
+	if ((rw == WRITE) && (lo->flags & NBD_READ_ONLY))
+		FAIL("Write on read-only");
 #ifdef PARANOIA
-		if (lo->magic != LO_MAGIC)
-			FAIL("nbd[] is not magical!");
-		requests_in++;
+	if (lo->magic != LO_MAGIC)
+		FAIL("nbd[] is not magical!");
+	requests_in++;
 #endif
-		req->errors = 0;
-		blkdev_dequeue_request(req);
-		spin_unlock_irq(&io_request_lock);
 
-		down (&lo->queue_lock);
-		list_add(&req->queue, &lo->queue_head);
-		nbd_send_req(lo->sock, req);	/* Why does this block?         */
-		up (&lo->queue_lock);
+	/*
+	 * not an error, but we don't want to do read-aheads
+	 */
+	if (rw == READA)
+		goto error_out;
 
-		spin_lock_irq(&io_request_lock);
-		continue;
+	nbh = nbd_alloc_bh(bh, rw);
 
-	      error_out:
-		req->errors++;
-		blkdev_dequeue_request(req);
-		spin_unlock(&io_request_lock);
-		nbd_end_request(req);
-		spin_lock(&io_request_lock);
-	}
-	return;
+	down (&lo->queue_lock);
+	list_add(&nbh->queue, &lo->queue_head);
+	nbd_send_req(lo->sock, nbh);	/* Why does this block?         */
+	up (&lo->queue_lock);
+	return 0;
+
+error_out:
+	bh->b_end_io(bh, test_bit(BH_Uptodate, &bh->b_state));
+	return 0;
 }
 
 static int nbd_ioctl(struct inode *inode, struct file *file,
@@ -354,7 +352,7 @@
 {
 	struct nbd_device *lo;
 	int dev, error, temp;
-	struct request sreq ;
+	struct nbd_bh snbh;
 
 	/* Anyone capable of this syscall can do *real bad* things */
 
@@ -370,9 +368,9 @@
 	switch (cmd) {
 	case NBD_DISCONNECT:
 	        printk("NBD_DISCONNECT\n") ;
-                sreq.cmd=2 ; /* shutdown command */
+                snbh.cmd=2 ; /* shutdown command */
                 if (!lo->sock) return -EINVAL ;
-                nbd_send_req(lo->sock,&sreq) ;
+                nbd_send_req(lo->sock, &snbh);
                 return 0 ;
  
 	case NBD_CLEAR_SOCK:
@@ -476,16 +474,25 @@
  *  (Just smiley confuses emacs :-)
  */
 
-static int __init nbd_init(void)
+int __init nbd_init(void)
 {
 	int i;
 
+	nbd_cachep = kmem_cache_create("nbd_requests", sizeof(struct nbd_bh),
+					0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (nbd_cachep == NULL) {
+		printk("nbd: unable to setup slab cache\n");
+		return -ENOMEM;
+	}
+
 	if (sizeof(struct nbd_request) != 28) {
+		kmem_cache_destroy(nbd_cachep);
 		printk(KERN_CRIT "Sizeof nbd_request needs to be 28 in order to work!\n" );
 		return -EIO;
 	}
 
 	if (register_blkdev(MAJOR_NR, "nbd", &nbd_fops)) {
+		kmem_cache_destroy(nbd_cachep);
 		printk("Unable to get major number %d for NBD\n",
 		       MAJOR_NR);
 		return -EIO;
@@ -495,11 +502,7 @@
 #endif
 	blksize_size[MAJOR_NR] = nbd_blksizes;
 	blk_size[MAJOR_NR] = nbd_sizes;
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_nbd_request);
-#ifndef NBD_PLUGGABLE
-	blk_queue_pluggable(BLK_DEFAULT_QUEUE(MAJOR_NR), nbd_plug_device);
-#endif
-	blk_queue_headactive(BLK_DEFAULT_QUEUE(MAJOR_NR), 0);
+	blk_queue_make_request(BLK_DEFAULT_QUEUE(MAJOR_NR), nbd_make_request);
 	for (i = 0; i < MAX_NBD; i++) {
 		nbd_dev[i].refcnt = 0;
 		nbd_dev[i].file = NULL;
@@ -526,7 +529,7 @@
 static void __exit nbd_cleanup(void)
 {
 	devfs_unregister (devfs_handle);
-	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
+	kmem_cache_destroy(nbd_cachep);
 
 	if (unregister_blkdev(MAJOR_NR, "nbd") != 0)
 		printk("nbd: cleanup_module failed\n");
diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.2-ac7/include/linux/blk.h linux/include/linux/blk.h
--- /opt/kernel/linux-2.4.2-ac7/include/linux/blk.h	Thu Mar  1 15:46:17 2001
+++ linux/include/linux/blk.h	Thu Mar  1 15:44:30 2001
@@ -291,12 +291,6 @@
 #define DEVICE_REQUEST do_mfm_request
 #define DEVICE_NR(device) (MINOR(device) >> 6)
 
-#elif (MAJOR_NR == NBD_MAJOR)
-
-#define DEVICE_NAME "nbd"
-#define DEVICE_REQUEST do_nbd_request
-#define DEVICE_NR(device) (MINOR(device))
-
 #elif (MAJOR_NR == MDISK_MAJOR)
 
 #define DEVICE_NAME "mdisk"
diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.2-ac7/include/linux/nbd.h linux/include/linux/nbd.h
--- /opt/kernel/linux-2.4.2-ac7/include/linux/nbd.h	Mon Dec 11 21:50:42 2000
+++ linux/include/linux/nbd.h	Thu Mar  1 15:44:05 2001
@@ -22,8 +22,6 @@
 #include <linux/locks.h>
 #include <asm/semaphore.h>
 
-#define LOCAL_END_REQUEST
-
 #include <linux/blk.h>
 
 #ifdef PARANOIA
@@ -31,35 +29,31 @@
 extern int requests_out;
 #endif
 
+/*
+ * a bit of a hack...
+ */
+struct nbd_bh
+{
+	struct buffer_head *bh;
+	int cmd, errors;
+	struct list_head queue;
+};
+
 static int 
-nbd_end_request(struct request *req)
+nbd_end_request(struct nbd_bh *nbh)
 {
-	unsigned long flags;
-	int ret = 0;
+	struct buffer_head *bh = nbh->bh;
 
 #ifdef PARANOIA
 	requests_out++;
 #endif
-	/*
-	 * This is a very dirty hack that we have to do to handle
-	 * merged requests because end_request stuff is a bit
-	 * broken. The fact we have to do this only if there
-	 * aren't errors looks even more silly.
-	 */
-	if (!req->errors) {
-		req->sector += req->current_nr_sectors;
-		req->nr_sectors -= req->current_nr_sectors;
-	}
-
-	spin_lock_irqsave(&io_request_lock, flags);
-	if (end_that_request_first( req, !req->errors, "nbd" ))
-		goto out;
-	ret = 1;
-	end_that_request_last( req );
-
-out:
-	spin_unlock_irqrestore(&io_request_lock, flags);
-	return ret;
+
+	if (!bh)
+		BUG();
+
+	bh->b_end_io(bh, !nbh->errors);
+	kmem_cache_free(nbd_cachep, nbh);
+	return 1;
 }
 
 #define MAX_NBD 128

--6WlEvdN9Dv0WHSBl--
