Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263380AbUKAXBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbUKAXBf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S380344AbUKAXBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:01:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:64675 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S286266AbUKAV7P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:59:15 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <10993462772966@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Mon, 1 Nov 2004 13:57:57 -0800
Message-Id: <10993462772266@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2451, 2004/11/01 13:06:31-08:00, dtor_core@ameritech.net

[PATCH] Driver core: add driver symlink to device

Driver core: when binding device to a driver create "driver"
             symlink in device's directory. Rename serio's
             "driver" attribute to "drvctl" (write-only)

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/bus.c          |    2 ++
 drivers/input/serio/serio.c |    7 +------
 2 files changed, 3 insertions(+), 6 deletions(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-11-01 13:36:05 -08:00
+++ b/drivers/base/bus.c	2004-11-01 13:36:05 -08:00
@@ -246,6 +246,7 @@
 	list_add_tail(&dev->driver_list, &dev->driver->devices);
 	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
 			  kobject_name(&dev->kobj));
+	sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
 }
 
 
@@ -370,6 +371,7 @@
 	struct device_driver * drv = dev->driver;
 	if (drv) {
 		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
+		sysfs_remove_link(&dev->kobj, "driver");
 		list_del_init(&dev->driver_list);
 		device_detach_shutdown(dev);
 		if (drv->remove)
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-11-01 13:36:05 -08:00
+++ b/drivers/input/serio/serio.c	2004-11-01 13:36:05 -08:00
@@ -246,11 +246,6 @@
 	return sprintf(buf, "%s\n", serio->name);
 }
 
-static ssize_t serio_show_driver(struct device *dev, char *buf)
-{
-	return sprintf(buf, "%s\n", dev->driver ? dev->driver->name : "(none)");
-}
-
 static ssize_t serio_rebind_driver(struct device *dev, const char *buf, size_t count)
 {
 	struct serio *serio = to_serio_port(dev);
@@ -307,7 +302,7 @@
 
 static struct device_attribute serio_device_attrs[] = {
 	__ATTR(description, S_IRUGO, serio_show_description, NULL),
-	__ATTR(driver, S_IWUSR | S_IRUGO, serio_show_driver, serio_rebind_driver),
+	__ATTR(drvctl, S_IWUSR, NULL, serio_rebind_driver),
 	__ATTR(bind_mode, S_IWUSR | S_IRUGO, serio_show_bind_mode, serio_set_bind_mode),
 	__ATTR_NULL
 };

