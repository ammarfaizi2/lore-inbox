Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129155AbRCKVAu>; Sun, 11 Mar 2001 16:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbRCKVAl>; Sun, 11 Mar 2001 16:00:41 -0500
Received: from gw.chygwyn.com ([62.172.158.50]:3595 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S129155AbRCKVA0>;
	Sun, 11 Mar 2001 16:00:26 -0500
From: Steve Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200103112055.UAA11273@gw.chygwyn.com>
Subject: NBD Fix (attempt #2)
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 11 Mar 2001 20:55:25 +0000 (GMT)
Cc: pavel@ucw.cz, torvalds@transmeta.com, axboe@suse.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <E14Nzk7-0002ao-00@the-village.bc.nu> from "Alan Cox" at Jan 31, 2001 04:04:21 PM
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

Below is a patch which I think fixes the NBD hangs properly. It works for
me and doesn't need any changes to ll_rw_blk.c like my last patch did. I've
shown it to Pavel Machek who has approved it. The patch is against 2.4.2-ac18.

Pavel: I've made the change you requested and also added a flag I forgot before.
Alan: Please apply this patch to your kernel tree.

If memory serves correctly the MSG_MORE flag only appeared in 2.4.2-ac and
isn't in the standard 2.4.2 kernel so I'll prepare a separate patch for
2.4.2 if there are no plans to merge the ZC patches for a while. Is there
a timescale for this or some criteria by which the ZC changes will be judged 
ready for merging ?

The one other change which might be required is a userland change. The
buffer size used for I/O by the nbd-server program is not large enough
in the case that a lot of buffers get merged into a single request, this
is easy to change though. If you get a message in your syslog on your
server machine complaining of a request thats too large, then this is 
what has happened,

Steve.

------------------------------------------------------------------------------

diff -r -u linux-2.4.2-ac18/drivers/block/nbd.c linux/drivers/block/nbd.c
--- linux-2.4.2-ac18/drivers/block/nbd.c	Sun Mar 11 21:35:14 2001
+++ linux/drivers/block/nbd.c	Sun Mar 11 20:18:36 2001
@@ -26,7 +26,6 @@
  *          structure with userland
  */
 
-#undef	NBD_PLUGGABLE
 #define PARANOIA
 #include <linux/major.h>
 
@@ -68,8 +67,6 @@
 static int requests_out;
 #endif
 
-static void nbd_plug_device(request_queue_t *q, kdev_t dev) { }
-
 static int nbd_open(struct inode *inode, struct file *file)
 {
 	int dev;
@@ -88,7 +85,7 @@
 /*
  *  Send or receive packet.
  */
-static int nbd_xmit(int send, struct socket *sock, char *buf, int size)
+static int nbd_xmit(int send, struct socket *sock, char *buf, int size, int msg_flags)
 {
 	mm_segment_t oldfs;
 	int result;
@@ -118,7 +115,7 @@
 		msg.msg_control = NULL;
 		msg.msg_controllen = 0;
 		msg.msg_namelen = 0;
-		msg.msg_flags = 0;
+		msg.msg_flags = msg_flags | MSG_NOSIGNAL;
 
 		if (send)
 			result = sock_sendmsg(sock, &msg, size);
@@ -151,7 +148,7 @@
 {
 	int result;
 	struct nbd_request request;
-	unsigned long size = req->current_nr_sectors << 9;
+	unsigned long size = req->nr_sectors << 9;
 
 	DEBUG("NBD: sending control, ");
 	request.magic = htonl(NBD_REQUEST_MAGIC);
@@ -160,15 +157,19 @@
 	request.len = htonl(size);
 	memcpy(request.handle, &req, sizeof(req));
 
-	result = nbd_xmit(1, sock, (char *) &request, sizeof(request));
+	result = nbd_xmit(1, sock, (char *) &request, sizeof(request), req->cmd == WRITE ? MSG_MORE : 0);
 	if (result <= 0)
 		FAIL("Sendmsg failed for control.");
 
 	if (req->cmd == WRITE) {
+		struct buffer_head *bh = req->bh;
 		DEBUG("data, ");
-		result = nbd_xmit(1, sock, req->buffer, size);
-		if (result <= 0)
-			FAIL("Send data failed.");
+		do {
+			result = nbd_xmit(1, sock, bh->b_data, bh->b_size, bh->b_reqnext == NULL ? 0 : MSG_MORE);
+			if (result <= 0)
+				FAIL("Send data failed.");
+			bh = bh->b_reqnext;
+		} while(bh);
 	}
 	return;
 
@@ -186,7 +187,7 @@
 
 	DEBUG("reading control, ");
 	reply.magic = 0;
-	result = nbd_xmit(0, lo->sock, (char *) &reply, sizeof(reply));
+	result = nbd_xmit(0, lo->sock, (char *) &reply, sizeof(reply), MSG_WAITALL);
 	if (result <= 0)
 		HARDFAIL("Recv control failed.");
 	memcpy(&xreq, reply.handle, sizeof(xreq));
@@ -201,10 +202,14 @@
 	if (ntohl(reply.error))
 		FAIL("Other side returned error.");
 	if (req->cmd == READ) {
+		struct buffer_head *bh = req->bh;
 		DEBUG("data, ");
-		result = nbd_xmit(0, lo->sock, req->buffer, req->current_nr_sectors << 9);
-		if (result <= 0)
-			HARDFAIL("Recv data failed.");
+		do {
+			result = nbd_xmit(0, lo->sock, bh->b_data, bh->b_size, MSG_WAITALL);
+			if (result <= 0)
+				HARDFAIL("Recv data failed.");
+			bh = bh->b_reqnext;
+		} while(bh);
 	}
 	DEBUG("done.\n");
 	return req;
@@ -218,7 +223,6 @@
 void nbd_do_it(struct nbd_device *lo)
 {
 	struct request *req;
-	int dequeued;
 
 	down (&lo->queue_lock);
 	while (1) {
@@ -246,11 +250,9 @@
 		list_del(&req->queue);
 		up (&lo->queue_lock);
 		
-		dequeued = nbd_end_request(req);
+		nbd_end_request(req);
 
 		down (&lo->queue_lock);
-		if (!dequeued)
-			list_add(&req->queue, &lo->queue_head);
 	}
  out:
 	up (&lo->queue_lock);
@@ -259,7 +261,6 @@
 void nbd_clear_que(struct nbd_device *lo)
 {
 	struct request *req;
-	int dequeued;
 
 #ifdef PARANOIA
 	if (lo->magic != LO_MAGIC) {
@@ -284,11 +285,9 @@
 		list_del(&req->queue);
 		up(&lo->queue_lock);
 
-		dequeued = nbd_end_request(req);
+		nbd_end_request(req);
 
 		down(&lo->queue_lock);
-		if (!dequeued)
-			list_add(&req->queue, &lo->queue_head);
 	}
 }
 
@@ -498,9 +497,6 @@
 	blksize_size[MAJOR_NR] = nbd_blksizes;
 	blk_size[MAJOR_NR] = nbd_sizes;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_nbd_request);
-#ifndef NBD_PLUGGABLE
-	blk_queue_pluggable(BLK_DEFAULT_QUEUE(MAJOR_NR), nbd_plug_device);
-#endif
 	blk_queue_headactive(BLK_DEFAULT_QUEUE(MAJOR_NR), 0);
 	for (i = 0; i < MAX_NBD; i++) {
 		nbd_dev[i].refcnt = 0;
diff -r -u linux-2.4.2-ac18/include/linux/blk.h linux/include/linux/blk.h
--- linux-2.4.2-ac18/include/linux/blk.h	Sun Mar 11 21:35:17 2001
+++ linux/include/linux/blk.h	Sun Mar 11 20:20:08 2001
@@ -42,7 +42,6 @@
 extern int swimiop_init(void);
 extern int amiga_floppy_init(void);
 extern int atari_floppy_init(void);
-extern int nbd_init(void);
 extern int ez_init(void);
 extern int bpcd_init(void);
 extern int ps2esdi_init(void);
diff -r -u linux-2.4.2-ac18/include/linux/nbd.h linux/include/linux/nbd.h
--- linux-2.4.2-ac18/include/linux/nbd.h	Mon Dec 11 20:50:42 2000
+++ linux/include/linux/nbd.h	Sun Mar 11 20:23:48 2001
@@ -31,35 +31,27 @@
 extern int requests_out;
 #endif
 
-static int 
+static void
 nbd_end_request(struct request *req)
 {
+	struct buffer_head *bh;
+	unsigned nsect;
 	unsigned long flags;
-	int ret = 0;
+	int uptodate = (req->errors == 0) ? 1 : 0;
 
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
 	spin_lock_irqsave(&io_request_lock, flags);
-	if (end_that_request_first( req, !req->errors, "nbd" ))
-		goto out;
-	ret = 1;
-	end_that_request_last( req );
-
-out:
+	while((bh = req->bh) != NULL) {
+		nsect = bh->b_size >> 9;
+		blk_finished_io(nsect);
+		req->bh = bh->b_reqnext;
+		bh->b_reqnext = NULL;
+		bh->b_end_io(bh, uptodate);
+	}
+	blkdev_release_request(req);
 	spin_unlock_irqrestore(&io_request_lock, flags);
-	return ret;
 }
 
 #define MAX_NBD 128
