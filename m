Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129666AbRBYUCS>; Sun, 25 Feb 2001 15:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129671AbRBYUCJ>; Sun, 25 Feb 2001 15:02:09 -0500
Received: from gw.chygwyn.com ([62.172.158.50]:17156 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S129666AbRBYUB4>;
	Sun, 25 Feb 2001 15:01:56 -0500
From: Steve Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200102251957.TAA01718@gw.chygwyn.com>
Subject: NBD Cleanup patch and bugfix in ll_rw_blk.c
To: torvalds@transmeta.com
Date: Sun, 25 Feb 2001 19:57:29 +0000 (GMT)
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
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

Here is a new version of the patch I recently sent to the list with some 
NBD cleanups and a bug fix in ll_rw_blk.c. The changes to NBD have Pavel 
Machek's approval as I've left out the two changes as he suggested.

The bug fix in ll_rw_blk.c prevents hangs when using block devices which
don't have plugging functions,

Steve.

------------------------------------------------------------------------------

diff -u -r linux-2.4.2/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.4.2/drivers/block/ll_rw_blk.c	Thu Feb 22 19:46:23 2001
+++ linux/drivers/block/ll_rw_blk.c	Sun Feb 25 19:35:43 2001
@@ -588,6 +588,9 @@
 	 * inserted at elevator_merge time
 	 */
 	list_add(&req->queue, insert_here);
+
+	if (!q->plugged && insert_here == &q->queue_head)
+		q->request_fn(q);
 }
 
 void inline blk_refill_freelist(request_queue_t *q, int rw)
diff -u -r linux-2.4.2/drivers/block/nbd.c linux/drivers/block/nbd.c
--- linux-2.4.2/drivers/block/nbd.c	Mon Oct 30 22:30:33 2000
+++ linux/drivers/block/nbd.c	Sun Feb 25 19:35:43 2001
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
@@ -475,11 +476,7 @@
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
 
@@ -526,8 +523,7 @@
 	return 0;
 }
 
-#ifdef MODULE
-void cleanup_module(void)
+void __exit nbd_cleanup(void)
 {
 	devfs_unregister (devfs_handle);
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
@@ -537,4 +533,9 @@
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
