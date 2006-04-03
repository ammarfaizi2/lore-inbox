Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751770AbWDCRXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWDCRXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 13:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWDCRXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 13:23:08 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:54299 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751769AbWDCRXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 13:23:07 -0400
Date: Mon, 3 Apr 2006 19:23:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, horst.hummel@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 6/9] s390: dasd device offline messages.
Message-ID: <20060403172304.GF11049@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[patch 6/9] s390: dasd device offline messages.

The dasd driver sometimes print the misleading message "Can't offline
dasd device with open count = 0". The reason why it can't offline the
device in this case is that the device is still in the startup phase.
Print a more meaningful message.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-04-03 18:46:20.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-04-03 18:46:39.000000000 +0200
@@ -1968,7 +1968,7 @@ int
 dasd_generic_set_offline (struct ccw_device *cdev)
 {
 	struct dasd_device *device;
-	int max_count;
+	int max_count, open_count;
 
 	device = dasd_device_from_cdev(cdev);
 	if (IS_ERR(device))
@@ -1985,10 +1985,16 @@ dasd_generic_set_offline (struct ccw_dev
 	 * in the other openers.
 	 */
 	max_count = device->bdev ? 0 : -1;
-	if (atomic_read(&device->open_count) > max_count) {
-		printk (KERN_WARNING "Can't offline dasd device with open"
-			" count = %i.\n",
-			atomic_read(&device->open_count));
+	open_count = (int) atomic_read(&device->open_count);
+	if (open_count > max_count) {
+		if (open_count > 0)
+			printk (KERN_WARNING "Can't offline dasd device with "
+				"open count = %i.\n",
+				open_count);
+		else
+			printk (KERN_WARNING "%s",
+				"Can't offline dasd device due to internal "
+				"use\n");
 		clear_bit(DASD_FLAG_OFFLINE, &device->flags);
 		dasd_put_device(device);
 		return -EBUSY;
