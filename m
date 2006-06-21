Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWFUTwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWFUTwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWFUTu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:50:56 -0400
Received: from ns2.suse.de ([195.135.220.15]:21146 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030238AbWFUTuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:50:17 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 21/22] [PATCH] Driver Core: Make dev_info and friends print the bus name if there is no driver
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:46:04 -0700
Message-Id: <11509192314067-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <1150919228328-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com> <115091918546-git-send-email-greg@kroah.com> <11509191893358-git-send-email-greg@kroah.com> <1150919192294-git-send-email-greg@kroah.com> <11509191951525-git-send-email-greg@kroah.com> <11509191982588-git-send-email-greg@kroah.com> <11509192022315-git-send-email-greg@kroah.com> <11509192043044-git-send-email-greg@kroah.com> <11509192081167-git-send-email-greg@kroah.com> <11509192111668-git-send-email-greg@kroah.com> <1150919214366-git-send-email-greg@kroah.com> <1150919218895-git-send-email-greg@kroah.com> <1150919221158-git-send-email-greg@kroah.com> <11509192252062-git-send-email-greg@kroah.com> <1150919228328-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch (as721) makes dev_info and related macros print the device's
bus name if the device doesn't have a driver, instead of printing just a
blank.  If the device isn't on a bus either... well, then it does leave
a blank space.  But it will be easier for someone else to change if they
want.

Cc: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c    |   16 ++++++++++++++++
 include/linux/device.h |    3 ++-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a979bc3..d0f84ff 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -29,6 +29,22 @@ int (*platform_notify_remove)(struct dev
  * sysfs bindings for devices.
  */
 
+/**
+ * dev_driver_string - Return a device's driver name, if at all possible
+ * @dev: struct device to get the name of
+ *
+ * Will return the device's driver's name if it is bound to a device.  If
+ * the device is not bound to a device, it will return the name of the bus
+ * it is attached to.  If it is not attached to a bus either, an empty
+ * string will be returned.
+ */
+const char *dev_driver_string(struct device *dev)
+{
+	return dev->driver ? dev->driver->name :
+			(dev->bus ? dev->bus->name : "");
+}
+EXPORT_SYMBOL_GPL(dev_driver_string);
+
 #define to_dev(obj) container_of(obj, struct device, kobj)
 #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
 
diff --git a/include/linux/device.h b/include/linux/device.h
index b473f42..1e5f30d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -416,8 +416,9 @@ extern int firmware_register(struct subs
 extern void firmware_unregister(struct subsystem *);
 
 /* debugging and troubleshooting/diagnostic helpers. */
+extern const char *dev_driver_string(struct device *dev);
 #define dev_printk(level, dev, format, arg...)	\
-	printk(level "%s %s: " format , (dev)->driver ? (dev)->driver->name : "" , (dev)->bus_id , ## arg)
+	printk(level "%s %s: " format , dev_driver_string(dev) , (dev)->bus_id , ## arg)
 
 #ifdef DEBUG
 #define dev_dbg(dev, format, arg...)		\
-- 
1.4.0

