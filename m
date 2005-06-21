Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVFUQYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVFUQYl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVFUQXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:23:39 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:51611 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262171AbVFUQWr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:22:47 -0400
Date: Tue, 21 Jun 2005 18:22:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, mochel@digitalimplant.org, gregkh@suse.de,
       cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 3/16] s390: use klist in dasd driver.
Message-ID: <20050621162249.GC6053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/16] s390: use klist in dasd driver.

From: Cornelia Huck <cohuck@de.ibm.com>

Convert the dasd driver to use the new klist interface.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/block/dasd.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2005-06-21 17:36:46.000000000 +0200
@@ -1952,26 +1952,24 @@ dasd_generic_notify(struct ccw_device *c
  * Automatically online either all dasd devices (dasd_autodetect) or
  * all devices specified with dasd= parameters.
  */
+static int
+__dasd_auto_online(struct device *dev, void *data)
+{
+	struct ccw_device *cdev;
+
+	cdev = to_ccwdev(dev);
+	if (dasd_autodetect || dasd_busid_known(cdev->dev.bus_id) == 0)
+		ccw_device_set_online(cdev);
+	return 0;
+}
+
 void
 dasd_generic_auto_online (struct ccw_driver *dasd_discipline_driver)
 {
 	struct device_driver *drv;
-	struct device *d, *dev;
-	struct ccw_device *cdev;
 
 	drv = get_driver(&dasd_discipline_driver->driver);
-	down_read(&drv->bus->subsys.rwsem);
-	dev = NULL;
-	list_for_each_entry(d, &drv->devices, driver_list) {
-		dev = get_device(d);
-		if (!dev)
-			continue;
-		cdev = to_ccwdev(dev);
-		if (dasd_autodetect || dasd_busid_known(cdev->dev.bus_id) == 0)
-			ccw_device_set_online(cdev);
-		put_device(dev);
-	}
-	up_read(&drv->bus->subsys.rwsem);
+	driver_for_each_device(drv, NULL, NULL, __dasd_auto_online);
 	put_driver(drv);
 }
 
