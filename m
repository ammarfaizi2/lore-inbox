Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272873AbTHEQxK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272894AbTHEQxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:53:10 -0400
Received: from dm4-153.slc.aros.net ([66.219.220.153]:40923 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S272873AbTHEQvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:51:08 -0400
Message-ID: <3F2FE078.6020305@aros.net>
Date: Tue, 05 Aug 2003 10:51:04 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Paul Clements <Paul.Clements@SteelEye.com>
Subject: [PATCH] 2.6.0 NBD driver: remove send/recieve race for request
Content-Type: multipart/mixed;
 boundary="------------080708000700080005040201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080708000700080005040201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The following patch removes a race condition in the network block device 
driver in 2.6.0*. Without this patch, the reply receiving thread could 
end (and free up the memory for) the request structure before the 
request sending thread is completely done accessing it and would then 
access invalid memory. This particular patch has only been compile 
tested and visually inspected. The invalid memory access had originally 
been found in a derivative nbd work that I've been developing and this 
race was found to be the cause (and removing the race fixed this problem).

--------------080708000700080005040201
Content-Type: text/plain;
 name="patch-2.6.0-test2-mm4-no_send_race"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.0-test2-mm4-no_send_race"

diff -urN linux-2.6.0-test2-mm4/drivers/block/nbd.c linux-2.6.0-test2-mm4-no_send_race/drivers/block/nbd.c
--- linux-2.6.0-test2-mm4/drivers/block/nbd.c	2003-08-04 22:01:24.000000000 -0600
+++ linux-2.6.0-test2-mm4-no_send_race/drivers/block/nbd.c	2003-08-04 22:01:45.000000000 -0600
@@ -234,15 +234,16 @@
 	return result;
 }
 
-void nbd_send_req(struct nbd_device *lo, struct request *req)
+static int nbd_send_req(struct nbd_device *lo, struct request *req)
 {
-	int result, i, flags;
+	int result, i, flags, rw;
 	struct nbd_request request;
 	unsigned long size = req->nr_sectors << 9;
 	struct socket *sock = lo->sock;
 
+	rw = nbd_cmd(req);
 	request.magic = htonl(NBD_REQUEST_MAGIC);
-	request.type = htonl(nbd_cmd(req));
+	request.type = htonl(rw);
 	request.from = cpu_to_be64((u64) req->sector << 9);
 	request.len = htonl(size);
 	memcpy(request.handle, &req, sizeof(req));
@@ -256,19 +257,18 @@
 	}
 
 	dprintk(DBG_TX, "%s: request %p: sending control (%s@%llu,%luB)\n",
-			lo->disk->disk_name, req,
-			nbdcmd_to_ascii(nbd_cmd(req)),
+			lo->disk->disk_name, req, nbdcmd_to_ascii(rw),
 			(unsigned long long)req->sector << 9,
 			req->nr_sectors << 9);
 	result = sock_xmit(sock, 1, &request, sizeof(request),
-			(nbd_cmd(req) == NBD_CMD_WRITE)? MSG_MORE: 0);
+			(rw == NBD_CMD_WRITE)? MSG_MORE: 0);
 	if (result <= 0) {
 		printk(KERN_ERR "%s: Send control failed (result %d)\n",
 				lo->disk->disk_name, result);
 		goto error_out;
 	}
 
-	if (nbd_cmd(req) == NBD_CMD_WRITE) {
+	if (rw == NBD_CMD_WRITE) {
 		struct bio *bio;
 		/*
 		 * we are really probing at internals to determine
@@ -294,11 +294,12 @@
 		}
 	}
 	up(&lo->tx_lock);
-	return;
+	return 0;
 
       error_out:
 	up(&lo->tx_lock);
 	req->errors++;
+	return req->errors;
 }
 
 static struct request *nbd_find_request(struct nbd_device *lo, char *handle)
@@ -492,9 +493,7 @@
 		list_add(&req->queuelist, &lo->queue_head);
 		spin_unlock(&lo->queue_lock);
 
-		nbd_send_req(lo, req);
-
-		if (req->errors) {
+		if (nbd_send_req(lo, req) != 0) {
 			printk(KERN_ERR "%s: Request send failed\n",
 					lo->disk->disk_name);
 			spin_lock(&lo->queue_lock);

--------------080708000700080005040201--

