Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbTEZRUE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTEZRTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:19:21 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:51428 "EHLO
	d06lmsgate-4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S261878AbTEZRPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:15:31 -0400
Date: Mon, 26 May 2003 19:26:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (7/10): block device drivers.
Message-ID: <20030526172642.GH3748@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 block device driver fixes:
 - dasd: Don't continue on error in dasd_increase_state. Use hex_ascii view
         for the dasd debug area. Fix typo.
 - xpram: Fix setup of devfs_name.

diffstat:
 drivers/s390/block/dasd.c  |   19 ++++++++++++-------
 drivers/s390/block/xpram.c |    3 ++-
 2 files changed, 14 insertions(+), 8 deletions(-)

diff -urN linux-2.5/drivers/s390/block/dasd.c linux-2.5-s390/drivers/s390/block/dasd.c
--- linux-2.5/drivers/s390/block/dasd.c	Mon May  5 01:53:14 2003
+++ linux-2.5-s390/drivers/s390/block/dasd.c	Mon May 26 19:20:46 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.94 $
+ * $Revision: 1.99 $
  */
 
 #include <linux/config.h>
@@ -297,19 +297,23 @@
 	    device->target >= DASD_STATE_KNOWN)
 		rc = dasd_state_new_to_known(device);
 
-	if (device->state == DASD_STATE_KNOWN &&
+	if (!rc &&
+	    device->state == DASD_STATE_KNOWN &&
 	    device->target >= DASD_STATE_BASIC)
 		rc = dasd_state_known_to_basic(device);
 
-	if (device->state == DASD_STATE_BASIC &&
+	if (!rc &&
+	    device->state == DASD_STATE_BASIC &&
 	    device->target >= DASD_STATE_ACCEPT)
 		rc = dasd_state_basic_to_accept(device);
 
-	if (device->state == DASD_STATE_ACCEPT &&
+	if (!rc &&
+	    device->state == DASD_STATE_ACCEPT &&
 	    device->target >= DASD_STATE_READY)
 		rc = dasd_state_accept_to_ready(device);
 
-	if (device->state == DASD_STATE_READY &&
+	if (!rc &&
+	    device->state == DASD_STATE_READY &&
 	    device->target >= DASD_STATE_ONLINE)
 		rc = dasd_state_ready_to_online(device);
 
@@ -729,6 +733,7 @@
 			DBF_DEV_EVENT(DBF_ERR, device, "%s",
 				      "I/O error, retry");
 			break;
+		case -EINVAL:
 		case -EBUSY:
 			DBF_DEV_EVENT(DBF_ERR, device, "%s",
 				      "device busy, retry later");
@@ -1727,7 +1732,7 @@
 dasd_release(struct inode *inp, struct file *filp)
 {
 	struct gendisk *disk = inp->i_bdev->bd_disk;
-	struct dasd_device *device = isk->private_data;
+	struct dasd_device *device = disk->private_data;
 
 	if (device->state < DASD_STATE_ACCEPT) {
 		DBF_DEV_EVENT(DBF_ERR, device, " %s",
@@ -2051,7 +2056,7 @@
 		rc = -ENOMEM;
 		goto failed;
 	}
-	debug_register_view(dasd_debug_area, &debug_sprintf_view);
+	debug_register_view(dasd_debug_area, &debug_hex_ascii_view);
 	debug_set_level(dasd_debug_area, DBF_ERR);
 
 	DBF_EVENT(DBF_EMERG, "%s", "debug area created");
diff -urN linux-2.5/drivers/s390/block/xpram.c linux-2.5-s390/drivers/s390/block/xpram.c
--- linux-2.5/drivers/s390/block/xpram.c	Mon May  5 01:53:36 2003
+++ linux-2.5-s390/drivers/s390/block/xpram.c	Mon May 26 19:20:46 2003
@@ -36,6 +36,7 @@
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
 #include <linux/device.h>
 #include <linux/bio.h>
+#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 
 #define XPRAM_NAME	"xpram"
@@ -459,7 +460,7 @@
 		disk->private_data = &xpram_devices[i];
 		disk->queue = &xpram_queue;
 		sprintf(disk->disk_name, "slram%d", i);
-		sprintf(disk->disk_name, "slram/%d", i);
+		sprintf(disk->devfs_name, "slram/%d", i);
 		set_capacity(disk, xpram_sizes[i] << 1);
 		add_disk(disk);
 	}
