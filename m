Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265747AbUGHBoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265747AbUGHBoC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 21:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265749AbUGHBnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 21:43:06 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:51312 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265743AbUGHBm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 21:42:29 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [RESEND][PATCH 4/4] Driver core updates (needed for serio)
Date: Wed, 7 Jul 2004 20:41:32 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200407072038.27158.dtor_core@ameritech.net> <200407072040.01818.dtor_core@ameritech.net> <200407072040.48498.dtor_core@ameritech.net>
In-Reply-To: <200407072040.48498.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407072041.41497.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1822, 2004-07-07 18:18:04-05:00, dtor_core@ameritech.net
  Driver core: add driver_find helper to find a driver by its name
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/base/driver.c  |   19 +++++++++++++++++++
 include/linux/device.h |    1 +
 2 files changed, 20 insertions(+)


===================================================================



diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	2004-07-07 19:56:21 -05:00
+++ b/drivers/base/driver.c	2004-07-07 19:56:21 -05:00
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
--- a/include/linux/device.h	2004-07-07 19:56:21 -05:00
+++ b/include/linux/device.h	2004-07-07 19:56:21 -05:00
@@ -120,6 +120,7 @@
 
 extern struct device_driver * get_driver(struct device_driver * drv);
 extern void put_driver(struct device_driver * drv);
+extern struct device_driver *driver_find(const char *name, struct bus_type *bus);
 
 
 /* driverfs interface for exporting driver attributes */
