Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbVCQO7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbVCQO7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 09:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbVCQO7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 09:59:25 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:46294 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S263084AbVCQO4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 09:56:33 -0500
Date: Thu, 17 Mar 2005 15:56:45 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 4/8] s390: device unregistering.
Message-ID: <20050317145645.GD4807@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 4/8] s390: device unregistering.

From: Cornelia Huck <cohuck@de.ibm.com>

Common i/o layer changes:
 - Don't unregister devices from ccw_device_{on,off}line_notoper directly,
   but put the unregister on the ccw_device_work workqueue (as it is done
   for all other unregisters).

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/device_fsm.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2005-03-17 15:35:50.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2005-03-17 15:36:00.000000000 +0100
@@ -649,9 +649,11 @@
 
 	cdev->private->state = DEV_STATE_NOT_OPER;
 	sch = to_subchannel(cdev->dev.parent);
-	device_unregister(&sch->dev);
-	sch->schib.pmcw.intparm = 0;
-	cio_modify(sch);
+	if (get_device(&cdev->dev)) {
+		PREPARE_WORK(&cdev->private->kick_work,
+			     ccw_device_call_sch_unregister, (void *)cdev);
+		queue_work(ccw_device_work, &cdev->private->kick_work);
+	}
 	wake_up(&cdev->private->wait_q);
 }
 
@@ -678,9 +680,11 @@
 		// FIXME: not-oper indication to device driver ?
 		ccw_device_call_handler(cdev);
 	}
-	device_unregister(&sch->dev);
-	sch->schib.pmcw.intparm = 0;
-	cio_modify(sch);
+	if (get_device(&cdev->dev)) {
+		PREPARE_WORK(&cdev->private->kick_work,
+			     ccw_device_call_sch_unregister, (void *)cdev);
+		queue_work(ccw_device_work, &cdev->private->kick_work);
+	}
 	wake_up(&cdev->private->wait_q);
 }
 
