Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264637AbUF1C0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbUF1C0P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 22:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbUF1C0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 22:26:15 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:17298 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264637AbUF1C0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 22:26:07 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [PARCH] driver core: add driver_find to find a driver by name
Date: Sun, 27 Jun 2004 21:26:03 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406272126.05220.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch that adds driver_find() that allows to search for a driver
on a bus by it's name. The function is similar to device_find already present
in the tree. I need it for my serio sysfs patches where user can re-bind
serio port to an alternate driver by echoing driver's name to serio port's
driver attribute.

-- 
Dmitry


===================================================================


ChangeSet@1.1792, 2004-06-27 20:49:01-05:00, dtor_core@ameritech.net
  Driver core: add driver_find helper to find a driver by its name
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/base/driver.c  |   16 ++++++++++++++++
 include/linux/device.h |    1 +
 2 files changed, 17 insertions(+)


===================================================================



diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	2004-06-27 21:24:06 -05:00
+++ b/drivers/base/driver.c	2004-06-27 21:24:06 -05:00
@@ -111,10 +111,26 @@
 	up(&drv->unload_sem);
 }
 
+/**
+ *	driver_find - find driver on a given bus by its name.
+ *	@name:	name of the driver.
+ *	@bus:	bus to seatch for the driver
+ */
+
+struct device_driver *driver_find(const char *name, struct bus_type *bus)
+{
+	struct kobject *k = kset_find_obj(&bus->drivers, name);
+	if (k)
+		return to_drv(k);
+	return NULL;
+}
+
+
 EXPORT_SYMBOL(driver_register);
 EXPORT_SYMBOL(driver_unregister);
 EXPORT_SYMBOL(get_driver);
 EXPORT_SYMBOL(put_driver);
+EXPORT_SYMBOL(driver_find);
 
 EXPORT_SYMBOL(driver_create_file);
 EXPORT_SYMBOL(driver_remove_file);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-06-27 21:24:06 -05:00
+++ b/include/linux/device.h	2004-06-27 21:24:06 -05:00
@@ -120,6 +120,7 @@
 
 extern struct device_driver * get_driver(struct device_driver * drv);
 extern void put_driver(struct device_driver * drv);
+extern struct device_driver *driver_find(const char *name, struct bus_type *bus);
 
 
 /* driverfs interface for exporting driver attributes */
