Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265651AbTFXDzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 23:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265653AbTFXDzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 23:55:38 -0400
Received: from dm1-36.slc.aros.net ([66.219.220.36]:45203 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S265651AbTFXDz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 23:55:28 -0400
Message-ID: <3EF7CEF7.7020800@aros.net>
Date: Mon, 23 Jun 2003 22:09:27 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] nbd driver for 2.5+: enhanced diagnostics support
References: <3EF7B1C1.5040502@aros.net> <20030624025959.GO6754@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030624025959.GO6754@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/mixed;
 boundary="------------000200070707000503070506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000200070707000503070506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

viro@parcelfarce.linux.theplanet.co.uk wrote:

> . . .
>
>>+	case BLKROSET: return "set-read-only";
>>+	case BLKROGET: return "get-read-only";
>>+	case BLKGETSIZE: return "block-get-size";
>>+	case BLKFLSBUF: return "flush-buffer-cache";
>>    
>>
>
>The last 4 never make it to the driver (nor should they, being generic
>ioctls).
>  
>
Aarg! A little too fast I was with me cut-and-patse! Actually though, 
BLKFLSBUF and BLKROSET do make it to the driver (at least according to 
my reading of linux-2.5.73/drivers/block/ioctl.c). The others are gone 
in the attached updated patch.

>>+	reply.magic = ntohl(reply.magic);
>>+	if (reply.magic != NBD_REPLY_MAGIC) {
>>+		printk(KERN_ERR "%s: Wrong magic (0x%lx)\n",
>>+				lo->disk->disk_name,
>>+				(unsigned long)reply.magic);
>>    
>>
>
>  
>
>>+	reply.error = ntohl(reply.error);
>>+	if (reply.error) {
>>+		printk(KERN_ERR "%s: Other side returned error (%d)\n",
>>+				lo->disk->disk_name, reply.error);
>>    
>>
>
>Generally a bad taste - it's harmless in this case, but such endianness
>conversions in place are asking for trouble.
>
Sure. I could have used local variables instead to hold the endianess 
results (which seems overkill). Or can just call ntohl again in printk 
and so it is now.

>> 	lo->refcnt--;
>>+	dprintk(DBG_RELEASE, "%s: %s refcnt=%d\n", lo->disk->disk_name,
>>+			__FUNCTION__, lo->refcnt);
>> 	/* N.B. Doesn't lo->file need an fput?? */
>> 	return 0;
>>    
>>
>
>a) please, lose __FUNCTION__ - using it in macros is one thing, but
>directly in a function that got a name shorter than `__FUNCTION__'?
>  
>
Done.

>b) no, it doesn't.
>  
>
The N.B. is a left over from the original which agreeably can be cleaned 
up too. So it's gone now too.

>c) ->refcnt is never used.  How about losing it completely?  Along with
>->open() and ->release()...
>  
>
There's a few other things that could be "lost" too. Like lo->file and 
lo->blksize_bits. I'm trying to go one step at a time though with these 
patches. And actually ->open() and ->release() will be needed later when 
I get that far. ;-)

>> 		sreq.flags = REQ_SPECIAL;
>> 		nbd_cmd(&sreq) = NBD_CMD_DISC;
>>    
>>
>
>;-/
>  
>
That's how it was already. Maybe it's wrong too or just not so good. But 
changing this should wait till a patch that's not dealing with enhanced 
diags no??

>>+		sreq.sector = 0;
>>+		sreq.nr_sectors = 0;
>>    
>>
>
>Umm... What for?
>
I added some comments now to explain why.

>> 	if (sizeof(struct nbd_request) != 28) {
>>-		printk(KERN_CRIT "Sizeof nbd_request needs to be 28 in order to work!\n" );
>>+		printk(KERN_CRIT "nbd: Sizeof nbd_request needs to be 28 in order to work!\n" );
>> 		return -EIO;
>> 	}
>>    
>>
>
>FWIW, I'm less than sure that struct nbd_request is worth defining.
>We use it in two places - the check above and nbd_send_req() where
>it is filled and then its address is cast to char *.  It might be
>better to use u32[7] directly and forget about all alignment issues.
>Hell knows...  In this situation I would probably just define an
>enum for offsets and be done with that.  Same goes for nbd_reply.
>  
>
I've thought about this too. I have to say so far that I don't like the 
idea though of getting rid of these structs. They're shared with the 
remote end also.

Here's the revised patch then for enhanced diagnostics...

--------------000200070707000503070506
Content-Type: text/plain;
 name="nbd-patch3.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-patch3.1"

diff -urN linux-2.5.72-p2.5/drivers/block/nbd.c linux-2.5.73-p3.1/drivers/block/nbd.c
--- linux-2.5.72-p2.5/drivers/block/nbd.c	2003-06-22 23:25:14.000000000 -0600
+++ linux-2.5.73-p3.1/drivers/block/nbd.c	2003-06-23 22:00:44.057332192 -0600
@@ -32,6 +32,7 @@
  *   memory corruption from module removal and possible memory corruption
  *   from sending/receiving disk data. <ldl@aros.net>
  * 03-06-23 Cosmetic changes. <ldl@aros.net>
+ * 03-06-23 Enhance diagnostics support. <ldl@aros.net>
  *
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
@@ -65,6 +66,23 @@
 
 #define LO_MAGIC 0x68797548
 
+#ifdef NDEBUG
+#define dprintk(flags, fmt...)
+#else /* NDEBUG */
+#define dprintk(flags, fmt...) do { \
+	if (debugflags & (flags)) printk(KERN_DEBUG fmt); \
+} while (0)
+#define DBG_OPEN        0x0001
+#define DBG_RELEASE     0x0002
+#define DBG_IOCTL       0x0004
+#define DBG_INIT        0x0010
+#define DBG_EXIT        0x0020
+#define DBG_BLKDEV      0x0100
+#define DBG_RX          0x0200
+#define DBG_TX          0x0400
+static unsigned int debugflags;
+#endif /* NDEBUG */
+
 static struct nbd_device nbd_dev[MAX_NBD];
 
 /*
@@ -79,19 +97,47 @@
  */
 static spinlock_t nbd_lock = SPIN_LOCK_UNLOCKED;
 
-#define DEBUG( s )
-/* #define DEBUG( s ) printk( s ) 
- */
-
 static int requests_in;
 static int requests_out;
 
+#ifndef NDEBUG
+static const char *ioctl_cmd_to_ascii(int cmd)
+{
+	switch (cmd) {
+	case NBD_SET_SOCK: return "set-sock";
+	case NBD_SET_BLKSIZE: return "set-blksize";
+	case NBD_SET_SIZE: return "set-size";
+	case NBD_DO_IT: return "do-it";
+	case NBD_CLEAR_SOCK: return "clear-sock";
+	case NBD_CLEAR_QUE: return "clear-que";
+	case NBD_PRINT_DEBUG: return "print-debug";
+	case NBD_SET_SIZE_BLOCKS: return "set-size-blocks";
+	case NBD_DISCONNECT: return "disconnect";
+	case BLKROSET: return "set-read-only";
+	case BLKFLSBUF: return "flush-buffer-cache";
+	}
+	return "unknown";
+}
+
+static const char *nbdcmd_to_ascii(int cmd)
+{
+	switch (cmd) {
+	case  NBD_CMD_READ: return "read";
+	case NBD_CMD_WRITE: return "write";
+	case  NBD_CMD_DISC: return "disconnect";
+	}
+	return "invalid";
+}
+#endif /* NDEBUG */
+
 static void nbd_end_request(struct request *req)
 {
 	int uptodate = (req->errors == 0) ? 1 : 0;
 	request_queue_t *q = req->q;
 	unsigned long flags;
 
+	dprintk(DBG_BLKDEV, "%s: request %p: %s\n", req->rq_disk->disk_name,
+			req, uptodate? "done": "failed");
 #ifdef PARANOIA
 	requests_out++;
 #endif
@@ -193,8 +239,6 @@
 	unsigned long size = req->nr_sectors << 9;
 	struct socket *sock = lo->sock;
 
-	DEBUG("nbd: sending control, ");
-	
 	request.magic = htonl(NBD_REQUEST_MAGIC);
 	request.type = htonl(nbd_cmd(req));
 	request.from = cpu_to_be64((u64) req->sector << 9);
@@ -204,15 +248,19 @@
 	down(&lo->tx_lock);
 
 	if (!sock || !lo->sock) {
-		printk(KERN_ERR "%s: Attempted sendmsg to closed socket\n",
+		printk(KERN_ERR "%s: Attempted send on closed socket\n",
 				lo->disk->disk_name);
 		goto error_out;
 	}
 
+	dprintk(DBG_TX, "%s: request %p: sending control (%s@%llu,%luB)\n",
+			lo->disk->disk_name, req,
+			nbdcmd_to_ascii(nbd_cmd(req)),
+			req->sector << 9, req->nr_sectors << 9);
 	result = sock_xmit(sock, 1, &request, sizeof(request),
 			(nbd_cmd(req) == NBD_CMD_WRITE)? MSG_MORE: 0);
 	if (result <= 0) {
-		printk(KERN_ERR "%s: Sendmsg failed for control (result %d)\n",
+		printk(KERN_ERR "%s: Send control failed (result %d)\n",
 				lo->disk->disk_name, result);
 		goto error_out;
 	}
@@ -229,7 +277,9 @@
 				flags = 0;
 				if ((i < (bio->bi_vcnt - 1)) || bio->bi_next)
 					flags = MSG_MORE;
-				DEBUG("data, ");
+				dprintk(DBG_TX, "%s: request %p: sending %d bytes data\n",
+						lo->disk->disk_name, req,
+						bvec->bv_len);
 				result = sock_send_bvec(sock, bvec, flags);
 				if (result <= 0) {
 					printk(KERN_ERR "%s: Send data failed (result %d)\n",
@@ -287,56 +337,57 @@
 	struct request *req;
 	struct socket *sock = lo->sock;
 
-	DEBUG("reading control, ");
 	reply.magic = 0;
 	result = sock_xmit(sock, 0, &reply, sizeof(reply), MSG_WAITALL);
 	if (result <= 0) {
-		printk(KERN_ERR "%s: Recv control failed (result %d)\n",
+		printk(KERN_ERR "%s: Receive control failed (result %d)\n",
 				lo->disk->disk_name, result);
 		lo->harderror = result;
 		return NULL;
 	}
 	req = nbd_find_request(lo, reply.handle);
 	if (req == NULL) {
-		printk(KERN_ERR "%s: Unexpected reply (result %d)\n",
-				lo->disk->disk_name, result);
+		printk(KERN_ERR "%s: Unexpected reply (%p)\n",
+				lo->disk->disk_name, reply.handle);
 		lo->harderror = result;
 		return NULL;
 	}
 
-	DEBUG("ok, ");
 	if (ntohl(reply.magic) != NBD_REPLY_MAGIC) {
-		printk(KERN_ERR "%s: Not enough magic (result %d)\n",
-				lo->disk->disk_name, result);
+		printk(KERN_ERR "%s: Wrong magic (0x%lx)\n",
+				lo->disk->disk_name,
+				(unsigned long)ntohl(reply.magic));
 		lo->harderror = result;
 		return NULL;
 	}
 	if (ntohl(reply.error)) {
-		printk(KERN_ERR "%s: Other side returned error (result %d)\n",
-				lo->disk->disk_name, result);
+		printk(KERN_ERR "%s: Other side returned error (%d)\n",
+				lo->disk->disk_name, ntohl(reply.error));
 		req->errors++;
 		return req;
 	}
 
+	dprintk(DBG_RX, "%s: request %p: got reply\n",
+			lo->disk->disk_name, req);
 	if (nbd_cmd(req) == NBD_CMD_READ) {
 		int i;
 		struct bio *bio;
-		DEBUG("data, ");
 		rq_for_each_bio(bio, req) {
 			struct bio_vec *bvec;
 			bio_for_each_segment(bvec, bio, i) {
 				result = sock_recv_bvec(sock, bvec);
 				if (result <= 0) {
-					printk(KERN_ERR "%s: Recv data failed (result %d)\n",
+					printk(KERN_ERR "%s: Receive data failed (result %d)\n",
 							lo->disk->disk_name,
 							result);
 					lo->harderror = result;
 					return NULL;
 				}
+				dprintk(DBG_RX, "%s: request %p: got %d bytes data\n",
+					lo->disk->disk_name, req, bvec->bv_len);
 			}
 		}
 	}
-	DEBUG("done.\n");
 	return req;
 }
 
@@ -347,7 +398,7 @@
 	BUG_ON(lo->magic != LO_MAGIC);
 	while ((req = nbd_read_stat(lo)) != NULL)
 		nbd_end_request(req);
-	printk(KERN_ALERT "%s: req should never be null\n",
+	printk(KERN_NOTICE "%s: req should never be null\n",
 			lo->disk->disk_name);
 	return;
 }
@@ -388,6 +439,8 @@
 		struct nbd_device *lo;
 
 		blkdev_dequeue_request(req);
+		dprintk(DBG_BLKDEV, "%s: request %p: dequeued (flags=%lx)\n",
+				req->rq_disk->disk_name, req, req->flags);
 
 		if (!(req->flags & REQ_CMD))
 			goto error_out;
@@ -431,7 +484,7 @@
 		nbd_send_req(lo, req);
 
 		if (req->errors) {
-			printk(KERN_ERR "%s: nbd_send_req failed\n",
+			printk(KERN_ERR "%s: Request send failed\n",
 					lo->disk->disk_name);
 			spin_lock(&lo->queue_lock);
 			list_del_init(&req->queuelist);
@@ -456,6 +509,9 @@
 static int nbd_open(struct inode *inode, struct file *file)
 {
 	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
+
+	dprintk(DBG_OPEN, "%s: nbd_open refcnt=%d\n", lo->disk->disk_name,
+			lo->refcnt);
 	lo->refcnt++;
 	return 0;
 }
@@ -463,11 +519,15 @@
 static int nbd_release(struct inode *inode, struct file *file)
 {
 	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
-	if (lo->refcnt <= 0)
-		printk(KERN_ALERT "%s: %s: refcount(%d) <= 0\n",
-				lo->disk->disk_name, __FUNCTION__, lo->refcnt);
+
+	if (lo->refcnt <= 0) {
+		printk(KERN_ALERT "%s: nbd_release: refcount(%d) <= 0\n",
+				lo->disk->disk_name, lo->refcnt);
+		BUG();
+	}
 	lo->refcnt--;
-	/* N.B. Doesn't lo->file need an fput?? */
+	dprintk(DBG_RELEASE, "%s: nbd_release: refcnt=%d\n",
+			lo->disk->disk_name, lo->refcnt);
 	return 0;
 }
 
@@ -479,6 +539,8 @@
 	struct request sreq ;
 
 	/* Anyone capable of this syscall can do *real bad* things */
+	dprintk(DBG_IOCTL, "%s: nbd_ioctl cmd=%s(0x%x) arg=%lu\n",
+			lo->disk->disk_name, ioctl_cmd_to_ascii(cmd), cmd, arg);
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -487,6 +549,13 @@
 	        printk(KERN_INFO "%s: NBD_DISCONNECT\n", lo->disk->disk_name);
 		sreq.flags = REQ_SPECIAL;
 		nbd_cmd(&sreq) = NBD_CMD_DISC;
+		/*
+		 * Set these to sane values in case server implementation
+		 * fails to check the request type first and also to keep
+		 * debugging output cleaner.
+		 */
+		sreq.sector = 0;
+		sreq.nr_sectors = 0;
                 if (!lo->sock)
 			return -EINVAL;
                 nbd_send_req(lo, &sreq);
@@ -607,7 +676,7 @@
 	int i;
 
 	if (sizeof(struct nbd_request) != 28) {
-		printk(KERN_CRIT "Sizeof nbd_request needs to be 28 in order to work!\n" );
+		printk(KERN_CRIT "nbd: Sizeof nbd_request needs to be 28 in order to work!\n" );
 		return -EIO;
 	}
 
@@ -633,9 +702,10 @@
 		err = -EIO;
 		goto out;
 	}
-#ifdef MODULE
-	printk("nbd: registered device at major %d\n", NBD_MAJOR);
-#endif
+
+	printk(KERN_INFO "nbd: registered device at major %d\n", NBD_MAJOR);
+	dprintk(DBG_INIT, "nbd: debugflags=0x%x\n", debugflags);
+
 	devfs_mk_dir("nbd");
 	for (i = 0; i < MAX_NBD; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
@@ -685,9 +755,7 @@
 	}
 	devfs_remove("nbd");
 	unregister_blkdev(NBD_MAJOR, "nbd");
-#ifdef MODULE
-	printk("nbd: unregistered device at major %d\n", NBD_MAJOR);
-#endif
+	printk(KERN_INFO "nbd: unregistered device at major %d\n", NBD_MAJOR);
 }
 
 module_init(nbd_init);
@@ -696,4 +764,7 @@
 MODULE_DESCRIPTION("Network Block Device");
 MODULE_LICENSE("GPL");
 
-
+#ifndef NDEBUG
+MODULE_PARM(debugflags, "i");
+MODULE_PARM_DESC(debugflags, "flags for controlling debug output");
+#endif

--------------000200070707000503070506--

