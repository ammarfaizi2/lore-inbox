Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936971AbWLDO6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936971AbWLDO6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936964AbWLDO5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:57:36 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:6309 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936973AbWLDO52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:57:28 -0500
Date: Mon, 4 Dec 2006 15:57:24 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] cio: Use device_reprobe() instead of bus_rescan_devices().
Message-ID: <20061204145724.GG32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] cio: Use device_reprobe() instead of bus_rescan_devices().

In io_subchannel_register(), it is better to just reprobe the current
device if it hasn't a driver yet than to rescan the whole bus.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-12-04 14:51:06.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-12-04 14:51:06.000000000 +0100
@@ -687,8 +687,20 @@ io_subchannel_register(void *data)
 	cdev = data;
 	sch = to_subchannel(cdev->dev.parent);
 
+	/*
+	 * io_subchannel_register() will also be called after device
+	 * recognition has been done for a boxed device (which will already
+	 * be registered). We need to reprobe since we may now have sense id
+	 * information.
+	 */
 	if (klist_node_attached(&cdev->dev.knode_parent)) {
-		bus_rescan_devices(&ccw_bus_type);
+		if (!cdev->drv) {
+			ret = device_reprobe(&cdev->dev);
+			if (ret)
+				/* We can't do much here. */
+				dev_info(&cdev->dev, "device_reprobe() returned"
+					 " %d\n", ret);
+		}
 		goto out;
 	}
 	/* make it known to the system */
