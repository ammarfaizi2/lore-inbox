Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030738AbWJDR6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030738AbWJDR6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030733AbWJDR6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:58:21 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:42599 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030731AbWJDR6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:58:09 -0400
Date: Wed, 4 Oct 2006 19:58:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] Add timeouts during sense PGID, path verification and disband PGID.
Message-ID: <20061004175811.GC26756@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] Add timeouts during sense PGID, path verification and disband PGID.

While the machine owns us an interrupt in these cases (and we should get
one), reality isn't always like that...

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_fsm.c  |    2 ++
 drivers/s390/cio/device_ops.c  |    3 +++
 drivers/s390/cio/device_pgid.c |    8 ++++++++
 3 files changed, 13 insertions(+)

diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-10-04 19:53:33.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-10-04 19:53:46.000000000 +0200
@@ -349,6 +349,8 @@ ccw_device_done(struct ccw_device *cdev,
 
 	sch = to_subchannel(cdev->dev.parent);
 
+	ccw_device_set_timeout(cdev, 0);
+
 	if (state != DEV_STATE_ONLINE)
 		cio_disable_subchannel(sch);
 
diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2006-10-04 19:53:33.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2006-10-04 19:53:46.000000000 +0200
@@ -216,6 +216,9 @@ ccw_device_call_handler(struct ccw_devic
 	      (stctl & SCSW_STCTL_PRIM_STATUS)))
 		return 0;
 
+	/* Clear pending timers for device driver initiated I/O. */
+	if (ending_status)
+		ccw_device_set_timeout(cdev, 0);
 	/*
 	 * Now we are ready to call the device driver interrupt handler.
 	 */
diff -urpN linux-2.6/drivers/s390/cio/device_pgid.c linux-2.6-patched/drivers/s390/cio/device_pgid.c
--- linux-2.6/drivers/s390/cio/device_pgid.c	2006-10-04 19:53:33.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_pgid.c	2006-10-04 19:53:46.000000000 +0200
@@ -96,6 +96,9 @@ ccw_device_sense_pgid_start(struct ccw_d
 {
 	int ret;
 
+	/* Set a timeout of 60s */
+	ccw_device_set_timeout(cdev, 60*HZ);
+
 	cdev->private->state = DEV_STATE_SENSE_PGID;
 	cdev->private->imask = 0x80;
 	cdev->private->iretry = 5;
@@ -480,6 +483,8 @@ ccw_device_verify_start(struct ccw_devic
 		ccw_device_verify_done(cdev, -ENODEV);
 		return;
 	}
+	/* After 60s path verification is considered to have failed. */
+	ccw_device_set_timeout(cdev, 60*HZ);
 	__ccw_device_verify_start(cdev);
 }
 
@@ -554,6 +559,9 @@ ccw_device_disband_irq(struct ccw_device
 void
 ccw_device_disband_start(struct ccw_device *cdev)
 {
+	/* After 60s disbanding is considered to have failed. */
+	ccw_device_set_timeout(cdev, 60*HZ);
+
 	cdev->private->flags.pgid_single = 0;
 	cdev->private->iretry = 5;
 	cdev->private->imask = 0x80;
