Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030735AbWJDR6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030735AbWJDR6t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030731AbWJDR6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:58:35 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:55900 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030735AbWJDR6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:58:31 -0400
Date: Wed, 4 Oct 2006 19:58:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, rwuerthn@de.ibm.com
Subject: [S390] zcrypt device registration/unregistration race.
Message-ID: <20061004175833.GD26756@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

[S390] zcrypt device registration/unregistration race.

Fix a race condition during AP device registration and unregistration.

Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff -urpN linux-2.6/drivers/s390/crypto/ap_bus.c linux-2.6-patched/drivers/s390/crypto/ap_bus.c
--- linux-2.6/drivers/s390/crypto/ap_bus.c	2006-10-04 19:53:33.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/ap_bus.c	2006-10-04 19:53:47.000000000 +0200
@@ -449,8 +449,6 @@ static int ap_device_probe(struct device
 
 	ap_dev->drv = ap_drv;
 	rc = ap_drv->probe ? ap_drv->probe(ap_dev) : -ENODEV;
-	if (rc)
-		ap_dev->unregistered = 1;
 	return rc;
 }
 
@@ -487,14 +485,7 @@ static int ap_device_remove(struct devic
 	struct ap_device *ap_dev = to_ap_dev(dev);
 	struct ap_driver *ap_drv = ap_dev->drv;
 
-	spin_lock_bh(&ap_dev->lock);
-	__ap_flush_queue(ap_dev);
-	/**
-	 * set ->unregistered to 1 while holding the lock. This prevents
-	 * new messages to be put on the queue from now on.
-	 */
-	ap_dev->unregistered = 1;
-	spin_unlock_bh(&ap_dev->lock);
+	ap_flush_queue(ap_dev);
 	if (ap_drv->remove)
 		ap_drv->remove(ap_dev);
 	return 0;
@@ -763,6 +754,7 @@ static void ap_scan_bus(void *data)
 			break;
 		ap_dev->qid = qid;
 		ap_dev->queue_depth = queue_depth;
+		ap_dev->unregistered = 1;
 		spin_lock_init(&ap_dev->lock);
 		INIT_LIST_HEAD(&ap_dev->pendingq);
 		INIT_LIST_HEAD(&ap_dev->requestq);
@@ -784,7 +776,12 @@ static void ap_scan_bus(void *data)
 		/* Add device attributes. */
 		rc = sysfs_create_group(&ap_dev->device.kobj,
 					&ap_dev_attr_group);
-		if (rc)
+		if (!rc) {
+			spin_lock_bh(&ap_dev->lock);
+			ap_dev->unregistered = 0;
+			spin_unlock_bh(&ap_dev->lock);
+		}
+		else
 			device_unregister(&ap_dev->device);
 	}
 }
@@ -970,6 +967,8 @@ void ap_queue_message(struct ap_device *
 			rc = __ap_queue_message(ap_dev, ap_msg);
 		if (!rc)
 			wake_up(&ap_poll_wait);
+		if (rc == -ENODEV)
+			ap_dev->unregistered = 1;
 	} else {
 		ap_dev->drv->receive(ap_dev, ap_msg, ERR_PTR(-ENODEV));
 		rc = 0;
@@ -1028,6 +1027,8 @@ static int __ap_poll_all(struct device *
 	spin_lock(&ap_dev->lock);
 	if (!ap_dev->unregistered) {
 		rc = ap_poll_queue(to_ap_dev(dev), (unsigned long *) data);
+		if (rc)
+			ap_dev->unregistered = 1;
 	} else
 		rc = 0;
 	spin_unlock(&ap_dev->lock);
