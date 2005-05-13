Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVEMOMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVEMOMs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 10:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVEMOMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 10:12:47 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:62894 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262377AbVEMOLR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 10:11:17 -0400
Date: Fri, 13 May 2005 16:10:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] s390: dasd set online failure.
Message-ID: <20050513141007.GA4507@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
the following dasd patch should go into 2.6.12 if possible.
Without it only dasd devices specified with dasd= are usable,
setting device online later returns with an error.
The rest of my patches aren't important enough given the
late stage of 2.6.12-rc4.

blue skies,
  Martin.

---
[patch] s390: dasd set online failure.

From: Horst Hummel <horst.hummel@de.ibm.com>

dasd driver changes:
 - The feature check in dasd_generic_online returns an error if
   the devmap entry for the device is not yet available. Check
   for the feature after the device has been created.
 - Do symmetric registration/deregistration of cdev->handler.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/block/dasd.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2005-05-13 11:16:14.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2005-05-13 11:16:28.000000000 +0200
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.161 $
+ * $Revision: 1.164 $
  */
 
 #include <linux/config.h>
@@ -1766,10 +1766,10 @@ dasd_generic_probe (struct ccw_device *c
 		printk(KERN_WARNING
 		       "dasd_generic_probe: could not add sysfs entries "
 		       "for %s\n", cdev->dev.bus_id);
+	} else {
+		cdev->handler = &dasd_int_handler;
 	}
 
-	cdev->handler = &dasd_int_handler;
-
 	return ret;
 }
 
@@ -1780,6 +1780,8 @@ dasd_generic_remove (struct ccw_device *
 {
 	struct dasd_device *device;
 
+	cdev->handler = NULL;
+
 	dasd_remove_sysfs_files(cdev);
 	device = dasd_device_from_cdev(cdev);
 	if (IS_ERR(device))
@@ -1810,14 +1812,14 @@ dasd_generic_set_online (struct ccw_devi
 	struct dasd_device *device;
 	int feature_diag, rc;
 
-	feature_diag = dasd_get_feature(cdev, DASD_FEATURE_USEDIAG);
-	if (feature_diag < 0)
-		return feature_diag;
-
 	device = dasd_create_device(cdev);
 	if (IS_ERR(device))
 		return PTR_ERR(device);
 
+	feature_diag = dasd_get_feature(cdev, DASD_FEATURE_USEDIAG);
+	if (feature_diag < 0)
+		return feature_diag;
+
 	if (feature_diag) {
 	  	if (!dasd_diag_discipline_pointer) {
 		        printk (KERN_WARNING
