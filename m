Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965272AbWJLFF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965272AbWJLFF7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 01:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965273AbWJLFF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 01:05:59 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:53087 "EHLO
	asav14.insightbb.com") by vger.kernel.org with ESMTP
	id S965272AbWJLFF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 01:05:58 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAKZpLUWBSopPLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Greg KH <gregkh@suse.de>
Subject: [PATCH] Driver core: fix error handling in device_bind_driver()
Date: Thu, 12 Oct 2006 01:05:55 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610120105.56022.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Driver core: fix error handling in device_bind_driver()
From: Dmitry Torokhov <dtor@insightbb.com>

When link creation fails we not only need to signal error
but also remove device from driver's list of bound devices.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/dd.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

Index: work/drivers/base/dd.c
===================================================================
--- work.orig/drivers/base/dd.c
+++ work/drivers/base/dd.c
@@ -41,7 +41,7 @@
  */
 int device_bind_driver(struct device *dev)
 {
-	int ret;
+	int error;
 
 	if (klist_node_attached(&dev->knode_driver)) {
 		printk(KERN_WARNING "%s: device %s already bound\n",
@@ -52,16 +52,23 @@ int device_bind_driver(struct device *de
 	pr_debug("bound device '%s' to driver '%s'\n",
 		 dev->bus_id, dev->driver->name);
 	klist_add_tail(&dev->knode_driver, &dev->driver->klist_devices);
-	ret = sysfs_create_link(&dev->driver->kobj, &dev->kobj,
-			  kobject_name(&dev->kobj));
-	if (ret == 0) {
-		ret = sysfs_create_link(&dev->kobj, &dev->driver->kobj,
-					"driver");
-		if (ret)
-			sysfs_remove_link(&dev->driver->kobj,
-					kobject_name(&dev->kobj));
-	}
-	return ret;
+	error = sysfs_create_link(&dev->driver->kobj, &dev->kobj,
+				  kobject_name(&dev->kobj));
+	if (error)
+		goto err_remove_list;
+
+	error = sysfs_create_link(&dev->kobj, &dev->driver->kobj,
+				  "driver");
+	if (error)
+		goto err_remove_link;
+
+	return 0;
+
+ err_remove_link:
+	sysfs_remove_link(&dev->driver->kobj, kobject_name(&dev->kobj));
+ err_remove_list:
+	klist_remove(&dev->knode_driver);
+	return error;
 }
 
 struct stupid_thread_structure {
