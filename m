Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVAXGkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVAXGkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVAXGgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:36:38 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:42932 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261453AbVAXGfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:35:23 -0500
Message-ID: <41F49721.4010903@steeleye.com>
Date: Mon, 24 Jan 2005 01:35:13 -0500
From: Paul Clements <paul.clements@steeleye.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com
CC: linux-kernel@vger.kernel.org, R.E.Wolff@harddisk-recovery.nl
Subject: [PATCH 2.4.29] nbd: fix ioctl permissions
Content-Type: multipart/mixed;
 boundary="------------070901020800090202030209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070901020800090202030209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcelo,

Here's a patch for nbd that Rogier recently sent me. It allows non-root 
to do BLKGETSIZE, et al. on nbd devices, which he needs for his data 
recovery applications.

Tested against 2.4.29. Please apply.

Thanks,
Paul

--------------070901020800090202030209
Content-Type: text/plain;
 name="nbd_fix_ioctl_perms.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd_fix_ioctl_perms.diff"

From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Signed-Off-By: Paul Clements <Paul.Clements@SteelEye.com>

Description: We shouldn't need CAP_SYS_ADMIN to ask for disk capacity and such.

===

diff -ur linux-2.4.28.clean/drivers/block/nbd.c linux-2.4.28.nbd-fix/drivers/block/nbd.c
--- linux-2.4.28.clean/drivers/block/nbd.c	Wed Jan 19 18:14:01 2005
+++ linux-2.4.28.nbd-fix/drivers/block/nbd.c	Wed Jan 19 16:36:59 2005
@@ -408,10 +408,7 @@
 	int dev, error, temp;
 	struct request sreq ;
 
-	/* Anyone capable of this syscall can do *real bad* things */
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
 	if (!inode)
 		return -EINVAL;
 	dev = MINOR(inode->i_rdev);
@@ -419,6 +416,20 @@
 		return -ENODEV;
 
 	lo = &nbd_dev[dev];
+
+	/* these are innocent, but.... */
+	switch (cmd) {
+	case BLKGETSIZE:
+		return put_user(nbd_bytesizes[dev] >> 9, (unsigned long *) arg);
+	case BLKGETSIZE64:
+		return put_user((u64)nbd_bytesizes[dev], (u64 *) arg);
+	}
+
+	/* ... anyone capable of any of the below ioctls can do *real bad* 
+	   things */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	switch (cmd) {
 	case NBD_DISCONNECT:
 	        printk("NBD_DISCONNECT\n");
@@ -524,10 +535,6 @@
 		       dev, lo->queue_head.next, lo->queue_head.prev, requests_in, requests_out);
 		return 0;
 #endif
-	case BLKGETSIZE:
-		return put_user(nbd_bytesizes[dev] >> 9, (unsigned long *) arg);
-	case BLKGETSIZE64:
-		return put_user((u64)nbd_bytesizes[dev], (u64 *) arg);
 	}
 	return -EINVAL;
 }


--------------070901020800090202030209--
