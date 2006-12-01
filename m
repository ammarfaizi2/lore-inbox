Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162278AbWLAXYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162278AbWLAXYV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162320AbWLAXYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:24:20 -0500
Received: from ns2.suse.de ([195.135.220.15]:53485 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162247AbWLAXX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:56 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 30/36] driver core: Introduce device_find_child().
Date: Fri,  1 Dec 2006 15:22:00 -0800
Message-Id: <11650154251022-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650154221716-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com> <11650153891878-git-send-email-greg@kroah.com> <11650153
 922117-git-send-email-greg@kroah.com> <11650153961479-git-send-email-greg@kroah.com> <11650154001320-git-send-email-greg@kroah.com> <11650154032080-git-send-email-greg@kroah.com> <11650154071138-git-send-email-greg@kroah.com> <11650154123942-git-send-email-greg@kroah.com> <1165015415131-git-send-email-greg@kroah.com> <11650154181661-git-send-email-greg@kroah.com> <11650154221716-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Introduce device_find_child() to match device_for_each_child().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c    |   33 +++++++++++++++++++++++++++++++++
 include/linux/device.h |    2 ++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5d11bbd..a29e685 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
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
diff --git a/include/linux/device.h b/include/linux/device.h
index 2d9dc35..0a0370c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -421,6 +421,8 @@ extern int __must_check device_add(struc
 extern void device_del(struct device * dev);
 extern int device_for_each_child(struct device *, void *,
 		     int (*fn)(struct device *, void *));
+extern struct device *device_find_child(struct device *, void *data,
+					int (*match)(struct device *, void *));
 extern int device_rename(struct device *dev, char *new_name);
 
 /*
-- 
1.4.4.1

