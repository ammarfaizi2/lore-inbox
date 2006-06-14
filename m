Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWFNOHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWFNOHJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWFNOHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:07:07 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:14401 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S964958AbWFNOHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:07:05 -0400
Date: Wed, 14 Jun 2006 15:59:50 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [patch 6/24] s390: ccwgroup device unregister.
Message-ID: <20060614135950.GG9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] ccwgroup device unregister.

Work around the problem that a device cannot be unregistered from
driver_for_each_device() because of klist node refcounting: Get device
after device owned by the driver to be unregistered with driver_find_device()
and then unregister it. This works because driver_get_device() gets us out of
the region of the elevated klist node refcount. driver_find_device() will
always get the next device in the list after the found one has been
unregistered.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/ccwgroup.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-patched/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/ccwgroup.c	2006-06-14 14:29:38.000000000 +0200
@@ -404,21 +404,24 @@ ccwgroup_driver_register (struct ccwgrou
 }
 
 static int
-__ccwgroup_driver_unregister_device(struct device *dev, void *data)
+__ccwgroup_match_all(struct device *dev, void *data)
 {
-	__ccwgroup_remove_symlinks(to_ccwgroupdev(dev));
-	device_unregister(dev);
-	put_device(dev);
-	return 0;
+	return 1;
 }
 
 void
 ccwgroup_driver_unregister (struct ccwgroup_driver *cdriver)
 {
+	struct device *dev;
+
 	/* We don't want ccwgroup devices to live longer than their driver. */
 	get_driver(&cdriver->driver);
-	driver_for_each_device(&cdriver->driver, NULL, NULL,
-			       __ccwgroup_driver_unregister_device);
+	while ((dev = driver_find_device(&cdriver->driver, NULL, NULL,
+					 __ccwgroup_match_all))) {
+		__ccwgroup_remove_symlinks(to_ccwgroupdev(dev));
+		device_unregister(dev);
+		put_device(dev);
+	}
 	put_driver(&cdriver->driver);
 	driver_unregister(&cdriver->driver);
 }
