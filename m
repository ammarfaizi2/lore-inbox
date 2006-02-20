Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWBTMu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWBTMu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 07:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWBTMu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 07:50:26 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:27781 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030193AbWBTMuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 07:50:25 -0500
Date: Mon, 20 Feb 2006 13:50:20 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Subject: [patch 2/3] s390: dasd reference counting
Message-ID: <20060220125020.GG12039@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

When using the dasd diag discipline, the base discipline module (eckd or fba)
can be unloaded, even though the dasd driver requires both discipline modules
(base and diag) to work correctly.

Implement reference counting for both base and diag discipline modules in
order to fix this.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/block/dasd.c     |   21 ++++++++++++++++++++-
 drivers/s390/block/dasd_int.h |    1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-02-20 10:33:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-02-20 10:33:14.000000000 +0100
@@ -156,7 +156,12 @@ dasd_state_known_to_new(struct dasd_devi
 	/* disable extended error reporting for this device */
 	dasd_disable_eer(device);
 	/* Forget the discipline information. */
+	if (device->discipline)
+		module_put(device->discipline->owner);
 	device->discipline = NULL;
+	if (device->base_discipline)
+		module_put(device->base_discipline->owner);
+	device->base_discipline = NULL;
 	device->state = DASD_STATE_NEW;
 
 	dasd_free_queue(device);
@@ -1880,9 +1885,10 @@ dasd_generic_remove (struct ccw_device *
  */
 int
 dasd_generic_set_online (struct ccw_device *cdev,
-			 struct dasd_discipline *discipline)
+			 struct dasd_discipline *base_discipline)
 
 {
+	struct dasd_discipline *discipline;
 	struct dasd_device *device;
 	int rc;
 
@@ -1890,6 +1896,7 @@ dasd_generic_set_online (struct ccw_devi
 	if (IS_ERR(device))
 		return PTR_ERR(device);
 
+	discipline = base_discipline;
 	if (device->features & DASD_FEATURE_USEDIAG) {
 	  	if (!dasd_diag_discipline_pointer) {
 		        printk (KERN_WARNING
@@ -1901,6 +1908,16 @@ dasd_generic_set_online (struct ccw_devi
 		}
 		discipline = dasd_diag_discipline_pointer;
 	}
+	if (!try_module_get(base_discipline->owner)) {
+		dasd_delete_device(device);
+		return -EINVAL;
+	}
+	if (!try_module_get(discipline->owner)) {
+		module_put(base_discipline->owner);
+		dasd_delete_device(device);
+		return -EINVAL;
+	}
+	device->base_discipline = base_discipline;
 	device->discipline = discipline;
 
 	rc = discipline->check_device(device);
@@ -1909,6 +1926,8 @@ dasd_generic_set_online (struct ccw_devi
 			"dasd_generic couldn't online device %s "
 			"with discipline %s rc=%i\n",
 			cdev->dev.bus_id, discipline->name, rc);
+		module_put(discipline->owner);
+		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return rc;
 	}
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2006-02-20 10:33:01.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2006-02-20 10:33:14.000000000 +0100
@@ -321,6 +321,7 @@ struct dasd_device {
 
 	/* Device discipline stuff. */
 	struct dasd_discipline *discipline;
+	struct dasd_discipline *base_discipline;
 	char *private;
 
 	/* Device state and target state. */
