Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRBYMV3>; Sun, 25 Feb 2001 07:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBYMVU>; Sun, 25 Feb 2001 07:21:20 -0500
Received: from gw.chygwyn.com ([62.172.158.50]:33801 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S129115AbRBYMVC>;
	Sun, 25 Feb 2001 07:21:02 -0500
From: Steve Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200102251217.MAA19785@gw.chygwyn.com>
Subject: NBD Hangs
To: pavel@atrey.karlin.mff.cuni.cz, andrea@suse.de
Date: Sun, 25 Feb 2001 12:17:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been having some NBD hangs with the 2.4.2 kernel. It appears that
block devices which don't use plugging will not have their request
functions called when the request is queued. I propose the following
patch to ll_rw_blk.c which seems to do the trick for me. Also I have
done a small amount of tidying in nbd.c.

Btw, do you know what the deadlock problem is when plugging is enabled
on nbd ? I had a good look through the code and did some tests and there
certainly are problems with deadlocks with plugging enabled but I couldn't
quite pin down the source. I guessed it might have something to do with 
blocking in the request function.

Thanks,

Steve.

------------------------------------------------------------------------------

diff -u -r linux-2.4.2-zc1/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.4.2-zc1/drivers/block/ll_rw_blk.c	Thu Feb 22 19:46:23 2001
+++ linux/drivers/block/ll_rw_blk.c	Sun Feb 25 11:23:42 2001
@@ -588,6 +588,9 @@
 	 * inserted at elevator_merge time
 	 */
 	list_add(&req->queue, insert_here);
+
+	if (!q->plugged && insert_here == &q->queue_head)
+		q->request_fn(q);
 }
 
 void inline blk_refill_freelist(request_queue_t *q, int rw)
diff -u -r linux-2.4.2-zc1/drivers/block/nbd.c linux/drivers/block/nbd.c
--- linux-2.4.2-zc1/drivers/block/nbd.c	Mon Oct 30 22:30:33 2000
+++ linux/drivers/block/nbd.c	Sun Feb 25 11:23:45 2001
@@ -29,7 +29,7 @@
 #include <linux/major.h>
 
 #include <linux/module.h>
-
+#include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/stat.h>
@@ -149,12 +149,13 @@
 {
 	int result;
 	struct nbd_request request;
+	unsigned long size = req->current_nr_sectors << 9;
 
 	DEBUG("NBD: sending control, ");
 	request.magic = htonl(NBD_REQUEST_MAGIC);
 	request.type = htonl(req->cmd);
 	request.from = cpu_to_be64( (u64) req->sector << 9);
-	request.len = htonl(req->current_nr_sectors << 9);
+	request.len = htonl(size);
 	memcpy(request.handle, &req, sizeof(req));
 
 	result = nbd_xmit(1, sock, (char *) &request, sizeof(request));
@@ -163,7 +164,7 @@
 
 	if (req->cmd == WRITE) {
 		DEBUG("data, ");
-		result = nbd_xmit(1, sock, req->buffer, req->current_nr_sectors << 9);
+		result = nbd_xmit(1, sock, req->buffer, size);
 		if (result <= 0)
 			FAIL("Send data failed.");
 	}
@@ -174,8 +175,11 @@
 }
 
 #define HARDFAIL( s ) { printk( KERN_ERR "NBD: " s "(result %d)\n", result ); lo->harderror = result; return NULL; }
+
+/* 
+ * NULL returned = something went wrong, inform userspace
+ */ 
 struct request *nbd_read_stat(struct nbd_device *lo)
-		/* NULL returned = something went wrong, inform userspace       */ 
 {
 	int result;
 	struct nbd_reply reply;
@@ -475,11 +479,7 @@
  *  (Just smiley confuses emacs :-)
  */
 
-#ifdef MODULE
-#define nbd_init init_module
-#endif
-
-int nbd_init(void)
+int __init nbd_init(void)
 {
 	int i;
 
@@ -493,9 +493,7 @@
 		       MAJOR_NR);
 		return -EIO;
 	}
-#ifdef MODULE
 	printk("nbd: registered device at major %d\n", MAJOR_NR);
-#endif
 	blksize_size[MAJOR_NR] = nbd_blksizes;
 	blk_size[MAJOR_NR] = nbd_sizes;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_nbd_request);
@@ -526,8 +524,7 @@
 	return 0;
 }
 
-#ifdef MODULE
-void cleanup_module(void)
+void __exit nbd_cleanup(void)
 {
 	devfs_unregister (devfs_handle);
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
@@ -537,4 +534,9 @@
 	else
 		printk("nbd: module cleaned up.\n");
 }
-#endif
+
+module_init(nbd_init);
+module_exit(nbd_cleanup);
+
+MODULE_DESCRIPTION("Network Block Device");
+
