Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424103AbWKPOlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424103AbWKPOlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 09:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424104AbWKPOlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 09:41:36 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:11023 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1424103AbWKPOlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 09:41:35 -0500
Date: Thu, 16 Nov 2006 15:42:07 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg K-H <greg@kroah.com>,
       Kay Sievers <kay.sievers@vrfy.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [Patch -mm 1/2] driver core: Introduce device_find_child().
Message-ID: <20061116154207.4e59ce23@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Introduce device_find_child() to match device_for_each_child().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/core.c    |   33 +++++++++++++++++++++++++++++++++
 include/linux/device.h |    2 ++
 2 files changed, 35 insertions(+)

--- linux-2.6-CH.orig/drivers/base/core.c
+++ linux-2.6-CH/drivers/base/core.c
@@ -750,12 +750,45 @@ int device_for_each_child(struct device 
 	return error;
 }
 
+/**
+ * device_find_child - device iterator for locating a particular device.
+ * @parent: parent struct device
+ * @data: Data to pass to match function
+ * @match: Callback function to check device
+ *
+ * This is similar to the device_for_each_child() function above, but it
+ * returns a reference to a device that is 'found' for later use, as
+ * determined by the @match callback.
+ *
+ * The callback should return 0 if the device doesn't match and non-zero
+ * if it does.  If the callback returns non-zero and a reference to the
+ * current device can be obtained, this function will return to the caller
+ * and not iterate over any more devices.
+ */
+struct device * device_find_child(struct device *parent, void *data,
+				  int (*match)(struct device *, void *))
+{
+	struct klist_iter i;
+	struct device *child;
+
+	if (!parent)
+		return NULL;
+
+	klist_iter_init(&parent->klist_children, &i);
+	while ((child = next_device(&i)))
+		if (match(child, data) && get_device(child))
+			break;
+	klist_iter_exit(&i);
+	return child;
+}
+
 int __init devices_init(void)
 {
 	return subsystem_register(&devices_subsys);
 }
 
 EXPORT_SYMBOL_GPL(device_for_each_child);
+EXPORT_SYMBOL_GPL(device_find_child);
 
 EXPORT_SYMBOL_GPL(device_initialize);
 EXPORT_SYMBOL_GPL(device_add);
--- linux-2.6-CH.orig/include/linux/device.h
+++ linux-2.6-CH/include/linux/device.h
@@ -420,6 +420,8 @@ extern int __must_check device_add(struc
 extern void device_del(struct device * dev);
 extern int device_for_each_child(struct device *, void *,
 		     int (*fn)(struct device *, void *));
+extern struct device *device_find_child(struct device *, void *data,
+					int (*match)(struct device *, void *));
 extern int device_rename(struct device *dev, char *new_name);
 
 /*
