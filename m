Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266134AbUGEO7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbUGEO7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 10:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUGEO7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 10:59:15 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:30876 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S266134AbUGEO67
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 10:58:59 -0400
Date: Mon, 5 Jul 2004 16:59:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: common i/o layer.
Message-ID: <20040705145928.GB3756@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: common i/o layer.

From: Arnd Bergmann <arndb@de.ibm.com>

Common i/o layer changes:
 - Reorder checking and setting of the ccw device id.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/device_fsm.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-s390/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	Mon Jul  5 16:12:27 2004
+++ linux-2.6-s390/drivers/s390/cio/device_fsm.c	Mon Jul  5 16:12:48 2004
@@ -165,8 +165,6 @@
 		return;
 	}
 	cdev->private->flags.donotify = 1;
-	/* Get device online again. */
-	ccw_device_online(cdev);
 }
 
 /*
@@ -233,15 +231,23 @@
 			  cdev->private->devno, sch->irq);
 		break;
 	case DEV_STATE_OFFLINE:
-		if (cdev->private->state == DEV_STATE_DISCONNECTED_SENSE_ID)
+		if (cdev->private->state == DEV_STATE_DISCONNECTED_SENSE_ID) {
+			ccw_device_handle_oper(cdev);
 			notify = 1;
-		else  /* fill out sense information */
-			cdev->id = (struct ccw_device_id) {
-				.cu_type   = cdev->private->senseid.cu_type,
-				.cu_model  = cdev->private->senseid.cu_model,
-				.dev_type  = cdev->private->senseid.dev_type,
-				.dev_model = cdev->private->senseid.dev_model,
-			};
+		}
+		/* fill out sense information */
+		cdev->id = (struct ccw_device_id) {
+			.cu_type   = cdev->private->senseid.cu_type,
+			.cu_model  = cdev->private->senseid.cu_model,
+			.dev_type  = cdev->private->senseid.dev_type,
+			.dev_model = cdev->private->senseid.dev_model,
+		};
+		if (notify) {
+			/* Get device online again. */
+			ccw_device_online(cdev);
+			wake_up(&cdev->private->wait_q);
+			return;
+		}
 		/* Issue device info message. */
 		CIO_DEBUG(KERN_INFO, 2, "SenseID : device %04x reports: "
 			  "CU  Type/Mod = %04X/%02X, Dev Type/Mod = "
@@ -256,10 +262,7 @@
 		break;
 	}
 	cdev->private->state = state;
-	if (notify && state == DEV_STATE_OFFLINE)
-		ccw_device_handle_oper(cdev);
-	else
-		io_subchannel_recog_done(cdev);
+	io_subchannel_recog_done(cdev);
 	if (state != DEV_STATE_NOT_OPER)
 		wake_up(&cdev->private->wait_q);
 }
