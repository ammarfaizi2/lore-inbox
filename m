Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUGOAqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUGOAqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266052AbUGOAg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:36:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:33664 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266049AbUGOAUC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:20:02 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.8-rc1
In-Reply-To: <10898507033692@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 14 Jul 2004 17:18:23 -0700
Message-Id: <10898507032619@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.12.5, 2004/07/08 16:46:47-07:00, dtor_core@ameritech.net

[PATCH] Driver core: add driver_find helper to find a driver by its name

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/driver.c  |   19 +++++++++++++++++++
 include/linux/device.h |    1 +
 2 files changed, 20 insertions(+)


diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	2004-07-14 17:11:24 -07:00
+++ b/drivers/base/driver.c	2004-07-14 17:11:24 -07:00
@@ -111,10 +111,29 @@
 	up(&drv->unload_sem);
 }
 
+/**
+ *	driver_find - locate driver on a bus by its name.
+ *	@name:	name of the driver.
+ *	@bus:	bus to scan for the driver.
+ *
+ *	Call kset_find_obj() to iterate over list of drivers on
+ *	a bus to find driver by name. Return driver if found.
+ *
+ *	Note that kset_find_obj increments driver's reference count.
+ */
+struct device_driver *driver_find(const char *name, struct bus_type *bus)
+{
+	struct kobject *k = kset_find_obj(&bus->drivers, name);
+	if (k)
+		return to_drv(k);
+	return NULL;
+}
+
 EXPORT_SYMBOL(driver_register);
 EXPORT_SYMBOL(driver_unregister);
 EXPORT_SYMBOL(get_driver);
 EXPORT_SYMBOL(put_driver);
+EXPORT_SYMBOL(driver_find);
 
 EXPORT_SYMBOL(driver_create_file);
 EXPORT_SYMBOL(driver_remove_file);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-07-14 17:11:24 -07:00
+++ b/include/linux/device.h	2004-07-14 17:11:24 -07:00
@@ -120,6 +120,7 @@
 
 extern struct device_driver * get_driver(struct device_driver * drv);
 extern void put_driver(struct device_driver * drv);
+extern struct device_driver *driver_find(const char *name, struct bus_type *bus);
 
 
 /* driverfs interface for exporting driver attributes */

