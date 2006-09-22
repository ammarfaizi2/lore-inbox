Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWIVJjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWIVJjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWIVJgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:36:54 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:40015 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751124AbWIVJgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:36:50 -0400
Date: Fri, 22 Sep 2006 11:37:13 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [6/9] driver core fixes: device_add() cleanup on error
Message-ID: <20060922113713.4a36bbf1@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check for return code of device_create_file() and correct cleanup in
the error case in device_add().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/core.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- linux-2.6-CH.orig/drivers/base/core.c
+++ linux-2.6-CH/drivers/base/core.c
@@ -437,14 +437,16 @@ int device_add(struct device *dev)
 	if (dev->driver)
 		dev->uevent_attr.attr.owner = dev->driver->owner;
 	dev->uevent_attr.store = store_uevent;
-	device_create_file(dev, &dev->uevent_attr);
+	error = device_create_file(dev, &dev->uevent_attr);
+	if (error)
+		goto attrError;
 
 	if (MAJOR(dev->devt)) {
 		struct device_attribute *attr;
 		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 		if (!attr) {
 			error = -ENOMEM;
-			goto PMError;
+			goto ueventattrError;
 		}
 		attr->attr.name = "dev";
 		attr->attr.mode = S_IRUGO;
@@ -454,7 +456,7 @@ int device_add(struct device *dev)
 		error = device_create_file(dev, attr);
 		if (error) {
 			kfree(attr);
-			goto attrError;
+			goto ueventattrError;
 		}
 
 		dev->devt_attr = attr;
@@ -515,6 +517,8 @@ int device_add(struct device *dev)
 		device_remove_file(dev, dev->devt_attr);
 		kfree(dev->devt_attr);
 	}
+ ueventattrError:
+	device_remove_file(dev, &dev->uevent_attr);
  attrError:
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
