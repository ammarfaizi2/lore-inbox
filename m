Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263647AbUJ3I3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbUJ3I3m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 04:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbUJ3I3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 04:29:41 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:55709 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263647AbUJ3I33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 04:29:29 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 1/4] Driver core: add driver symlink to device
Date: Sat, 30 Oct 2004 03:27:22 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20041029185753.53517.qmail@web81307.mail.yahoo.com> <20041029202249.GB29171@kroah.com> <200410300326.23345.dtor_core@ameritech.net>
In-Reply-To: <200410300326.23345.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410300327.24589.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1955, 2004-10-30 01:08:14-05:00, dtor_core@ameritech.net
  Driver core: when binding device to a driver create "driver"
               symlink in device's directory. Rename serio's
               "driver" attribute to "drvctl" (write-only)
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 base/bus.c          |    2 ++
 input/serio/serio.c |    7 +------
 2 files changed, 3 insertions(+), 6 deletions(-)


===================================================================



diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-10-30 03:14:25 -05:00
+++ b/drivers/base/bus.c	2004-10-30 03:14:25 -05:00
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
--- a/drivers/input/serio/serio.c	2004-10-30 03:14:25 -05:00
+++ b/drivers/input/serio/serio.c	2004-10-30 03:14:25 -05:00
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
