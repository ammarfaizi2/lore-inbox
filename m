Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbTJUPGd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTJUPGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:06:33 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:8623 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263122AbTJUPGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:06:23 -0400
Date: Tue, 21 Oct 2003 17:06:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (2/8): common i/o layer.
Message-ID: <20031021150636.GC1457@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Correctly initialize all spin_locks with spin_lock_init.
 - Use subchannel lock directly instead of ccw device lock pointer in
   ccw_device_recognition to avoid accessing an already free structure.
 - Take/release ccw device lock in ccw_device_console_enable.

diffstat:
 drivers/s390/cio/cio.c    |    3 ++-
 drivers/s390/cio/device.c |   13 +++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/cio.c linux-2.6-s390/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	Fri Oct 17 23:43:35 2003
+++ linux-2.6-s390/drivers/s390/cio/cio.c	Tue Oct 21 16:36:08 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.105 $
+ *   $Revision: 1.106 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -512,6 +512,7 @@
 	/* Nuke all fields. */
 	memset(sch, 0, sizeof(struct subchannel));
 
+	spin_lock_init(&sch->lock);
 	/*
 	 * The first subchannel that is not-operational (ccode==3)
 	 *  indicates that there aren't any more devices available.
diff -urN linux-2.6/drivers/s390/cio/device.c linux-2.6-s390/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	Fri Oct 17 23:43:24 2003
+++ linux-2.6-s390/drivers/s390/cio/device.c	Tue Oct 21 16:36:08 2003
@@ -562,9 +562,9 @@
 	atomic_inc(&ccw_device_init_count);
 
 	/* Start async. device sensing. */
-	spin_lock_irq(cdev->ccwlock);
+	spin_lock_irq(&sch->lock);
 	rc = ccw_device_recognition(cdev);
-	spin_unlock_irq(cdev->ccwlock);
+	spin_unlock_irq(&sch->lock);
 	if (rc) {
 		if (atomic_dec_and_test(&ccw_device_init_count))
 			wake_up(&ccw_device_init_wq);
@@ -662,15 +662,20 @@
 		return rc;
 
 	/* Now wait for the async. recognition to come to an end. */
+	spin_lock_irq(cdev->ccwlock);
 	while (!dev_fsm_final_state(cdev))
 		wait_cons_dev();
+	rc = -EIO;
 	if (cdev->private->state != DEV_STATE_OFFLINE)
-		return -EIO;
+		goto out_unlock;
 	ccw_device_online(cdev);
 	while (!dev_fsm_final_state(cdev))
 		wait_cons_dev();
 	if (cdev->private->state != DEV_STATE_ONLINE)
-		return -EIO;
+		goto out_unlock;
+	rc = 0;
+out_unlock:
+	spin_unlock_irq(cdev->ccwlock);
 	return 0;
 }
 
