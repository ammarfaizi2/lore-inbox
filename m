Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263656AbUJ3Ict@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbUJ3Ict (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 04:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbUJ3IaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 04:30:07 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:56733 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263649AbUJ3I33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 04:29:29 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 2/4] Driver core: add drvctl device attribute
Date: Sat, 30 Oct 2004 03:28:11 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20041029185753.53517.qmail@web81307.mail.yahoo.com> <200410300326.23345.dtor_core@ameritech.net> <200410300327.24589.dtor_core@ameritech.net>
In-Reply-To: <200410300327.24589.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410300328.13995.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1956, 2004-10-30 01:40:43-05:00, dtor_core@ameritech.net
  Driver core: add "drvctl" default device attribute that allows
               userspace request execution of bus-specific actions
               for devices. Used to manually control driver and
               device binding/unbinding/rebinding, causes execution
               of bus->drvctl() helper.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/base/interface.c    |   25 +++++++++++++++++
 drivers/input/serio/serio.c |   62 ++++++++++++++++++++++----------------------
 include/linux/device.h      |    3 +-
 3 files changed, 57 insertions(+), 33 deletions(-)


===================================================================



diff -Nru a/drivers/base/interface.c b/drivers/base/interface.c
--- a/drivers/base/interface.c	2004-10-30 03:14:51 -05:00
+++ b/drivers/base/interface.c	2004-10-30 03:14:51 -05:00
@@ -42,10 +42,33 @@
 	return n;
 }
 
-static DEVICE_ATTR(detach_state, 0644, detach_show, detach_store);
+/**
+ *	drvctl - controls device and driver binding.
+ *
+ *	Writing to the attribute causes execution of bus-specific drvctl()
+ *	helper that is used to disconnect device from its driver or rebind
+ *	device to a specific driver.
+ */
+
+static ssize_t drvctl_store(struct device * dev, const char * buf, size_t count)
+{
+	int retval = -ENOSYS;
+
+	if (dev->bus->drvctl)
+		retval = dev->bus->drvctl(dev, buf, count);
+
+	if (retval < 0)
+		return retval;
 
+	return count;
+}
+
+
+static DEVICE_ATTR(detach_state, 0644, detach_show, detach_store);
+static DEVICE_ATTR(drvctl, 0200, NULL, drvctl_store);
 
 struct attribute * dev_default_attrs[] = {
 	&dev_attr_detach_state.attr,
+	&dev_attr_drvctl.attr,
 	NULL,
 };
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-10-30 03:14:51 -05:00
+++ b/drivers/input/serio/serio.c	2004-10-30 03:14:51 -05:00
@@ -246,36 +246,6 @@
 	return sprintf(buf, "%s\n", serio->name);
 }
 
-static ssize_t serio_rebind_driver(struct device *dev, const char *buf, size_t count)
-{
-	struct serio *serio = to_serio_port(dev);
-	struct device_driver *drv;
-	int retval;
-
-	retval = down_interruptible(&serio_sem);
-	if (retval)
-		return retval;
-
-	retval = count;
-	if (!strncmp(buf, "none", count)) {
-		serio_disconnect_port(serio);
-	} else if (!strncmp(buf, "reconnect", count)) {
-		serio_reconnect_port(serio);
-	} else if (!strncmp(buf, "rescan", count)) {
-		serio_disconnect_port(serio);
-		serio_connect_port(serio, NULL);
-	} else if ((drv = driver_find(buf, &serio_bus)) != NULL) {
-		serio_disconnect_port(serio);
-		serio_connect_port(serio, to_serio_driver(drv));
-		put_driver(drv);
-	} else {
-		retval = -EINVAL;
-	}
-
-	up(&serio_sem);
-
-	return retval;
-}
 
 static ssize_t serio_show_bind_mode(struct device *dev, char *buf)
 {
@@ -302,7 +272,6 @@
 
 static struct device_attribute serio_device_attrs[] = {
 	__ATTR(description, S_IRUGO, serio_show_description, NULL),
-	__ATTR(drvctl, S_IWUSR, NULL, serio_rebind_driver),
 	__ATTR(bind_mode, S_IWUSR | S_IRUGO, serio_show_bind_mode, serio_set_bind_mode),
 	__ATTR_NULL
 };
@@ -591,6 +560,36 @@
 	up(&serio_sem);
 }
 
+static int serio_rebind_driver(struct device *dev, const char *buf, size_t count)
+{
+	struct serio *serio = to_serio_port(dev);
+	struct device_driver *drv;
+	int retval;
+
+	retval = down_interruptible(&serio_sem);
+	if (retval)
+		return retval;
+
+	if (!strncmp(buf, "none", count)) {
+		serio_disconnect_port(serio);
+	} else if (!strncmp(buf, "reconnect", count)) {
+		serio_reconnect_port(serio);
+	} else if (!strncmp(buf, "rescan", count)) {
+		serio_disconnect_port(serio);
+		serio_connect_port(serio, NULL);
+	} else if ((drv = driver_find(buf, &serio_bus)) != NULL) {
+		serio_disconnect_port(serio);
+		serio_connect_port(serio, to_serio_driver(drv));
+		put_driver(drv);
+	} else {
+		retval = -EINVAL;
+	}
+
+	up(&serio_sem);
+
+	return retval;
+}
+
 static void serio_set_drv(struct serio *serio, struct serio_driver *drv)
 {
 	down(&serio->drv_sem);
@@ -655,6 +654,7 @@
 
 	serio_bus.dev_attrs = serio_device_attrs;
 	serio_bus.drv_attrs = serio_driver_attrs;
+	serio_bus.drvctl = serio_rebind_driver;
 	bus_register(&serio_bus);
 
 	return 0;
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-10-30 03:14:51 -05:00
+++ b/include/linux/device.h	2004-10-30 03:14:51 -05:00
@@ -59,7 +59,8 @@
 	struct driver_attribute	* drv_attrs;
 
 	int		(*match)(struct device * dev, struct device_driver * drv);
-	int		(*hotplug) (struct device *dev, char **envp, 
+	int		(*drvctl)(struct device * dev, const char * buf, size_t count);
+	int		(*hotplug) (struct device *dev, char **envp,
 				    int num_envp, char *buffer, int buffer_size);
 	int		(*suspend)(struct device * dev, u32 state);
 	int		(*resume)(struct device * dev);
