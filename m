Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVCYGEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVCYGEY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVCYF5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 00:57:46 -0500
Received: from digitalimplant.org ([64.62.235.95]:11219 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261413AbVCYFzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:55:03 -0500
Date: Thu, 24 Mar 2005 21:54:54 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [10/12] More Driver Model Locking Changes
Message-ID: <Pine.LNX.4.50.0503242152520.19795-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2248, 2005-03-24 19:03:59-08:00, mochel@digitalimplant.org
  [scsi] Use device_for_each_child() to unregister devices in scsi_remove_target().


  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
--- a/drivers/scsi/scsi_sysfs.c	2005-03-24 20:32:54 -08:00
+++ b/drivers/scsi/scsi_sysfs.c	2005-03-24 20:32:54 -08:00
@@ -672,6 +672,13 @@
 	scsi_target_reap(starget);
 }

+static int __remove_child (struct device * dev, void * data)
+{
+	if (scsi_is_target_device(dev))
+		__scsi_remove_target(to_scsi_target(dev));
+	return 0;
+}
+
 /**
  * scsi_remove_target - try to remove a target and all its devices
  * @dev: generic starget or parent of generic stargets to be removed
@@ -682,7 +689,7 @@
  */
 void scsi_remove_target(struct device *dev)
 {
-	struct device *rdev, *idev, *next;
+	struct device *rdev;

 	if (scsi_is_target_device(dev)) {
 		__scsi_remove_target(to_scsi_target(dev));
@@ -690,10 +697,7 @@
 	}

 	rdev = get_device(dev);
-	list_for_each_entry_safe(idev, next, &dev->children, node) {
-		if (scsi_is_target_device(idev))
-			__scsi_remove_target(to_scsi_target(idev));
-	}
+	device_for_each_child(dev, NULL, __remove_child);
 	put_device(rdev);
 }
 EXPORT_SYMBOL(scsi_remove_target);
