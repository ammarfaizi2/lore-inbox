Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269496AbUJLGgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269496AbUJLGgl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269497AbUJLGeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:34:44 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:43419 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269492AbUJLGdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:33:33 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 3/4] Driver core: add "driver" default attribute
Date: Tue, 12 Oct 2004 01:32:15 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
References: <200410062354.18885.dtor_core@ameritech.net> <200410120131.05691.dtor_core@ameritech.net> <200410120131.38330.dtor_core@ameritech.net>
In-Reply-To: <200410120131.38330.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410120132.18217.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#### AUTHOR dtor_core@ameritech.net
#### COMMENT START
### Comments for ChangeSet
Driver core: add "driver" default device attribute that produces
             name of the driver currently bound to the device and
             allows execution of bus-specific actions for device
             and driver via bus->rebind_helper()

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
### Comments for drivers/base/interface.c
Add "driver" default device attribute.
### Comments for include/linux/device.h
Add rebind_helper method to bus_type structure.
### Comments for drivers/input/serio/serio.c
Do not create "driver": attribute as driver core will create it for us;
install serio_rebind_driver as serio_bus's rebind_helper.
#### COMMENT END

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/11 00:39:53-05:00 dtor_core@ameritech.net 
#   Driver core: add "driver" default device attribute that produces
#                name of the driver currently bound to the device and
#                allows execution of bus-specific actions for device
#                and driver via bus->rebind_helper()
#   
#   Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
# 
# include/linux/device.h
#   2004/10/11 00:39:34-05:00 dtor_core@ameritech.net +2 -1
#   Add rebind_helper method to bus_type structure.
# 
# drivers/input/serio/serio.c
#   2004/10/11 00:39:34-05:00 dtor_core@ameritech.net +31 -36
#   Do not create "driver": attribute as driver core will create it for us;
#   install serio_rebind_driver as serio_bus's rebind_helper.
# 
# drivers/base/interface.c
#   2004/10/11 00:39:33-05:00 dtor_core@ameritech.net +30 -1
#   Add "driver" default device attribute.
# 
diff -Nru a/drivers/base/interface.c b/drivers/base/interface.c
--- a/drivers/base/interface.c	2004-10-12 01:29:06 -05:00
+++ b/drivers/base/interface.c	2004-10-12 01:29:06 -05:00
@@ -42,10 +42,39 @@
 	return n;
 }
 
-static DEVICE_ATTR(detach_state, 0644, detach_show, detach_store);
+/**
+ *	driver - controls device and driver binding.
+ *
+ *	Reading from the attribute gives name of driver that is bound to
+ *	the device or "(none)". Result of writing to the attribute depends
+ *	on the bus's rebind_helper implementation and can cause device to
+ *	be disconnected or be rebound to a specific driver.
+ */
+
+static ssize_t driver_show(struct device * dev, char * buf)
+{
+	return sprintf(buf, "%s\n", dev->driver ? dev->driver->name : "(none)");
+}
+
+static ssize_t driver_store(struct device * dev, const char * buf, size_t count)
+{
+	int retval = -ENOSYS;
+
+	if (dev->bus->rebind_helper)
+		retval = dev->bus->rebind_helper(dev, buf, count);
 
+	if (retval < 0)
+		return retval;
+
+	return count;
+}
+
+
+static DEVICE_ATTR(detach_state, 0644, detach_show, detach_store);
+static DEVICE_ATTR(driver, 0644, driver_show, driver_store);
 
 struct attribute * dev_default_attrs[] = {
 	&dev_attr_detach_state.attr,
+	&dev_attr_driver.attr,
 	NULL,
 };
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-10-12 01:29:06 -05:00
+++ b/drivers/input/serio/serio.c	2004-10-12 01:29:06 -05:00
@@ -246,41 +246,6 @@
 	return sprintf(buf, "%s\n", serio->name);
 }
 
-static ssize_t serio_show_driver(struct device *dev, char *buf)
-{
-	return sprintf(buf, "%s\n", dev->driver ? dev->driver->name : "(none)");
-}
-
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
@@ -307,7 +272,6 @@
 
 static struct device_attribute serio_device_attrs[] = {
 	__ATTR(description, S_IRUGO, serio_show_description, NULL),
-	__ATTR(driver, S_IWUSR | S_IRUGO, serio_show_driver, serio_rebind_driver),
 	__ATTR(bind_mode, S_IWUSR | S_IRUGO, serio_show_bind_mode, serio_set_bind_mode),
 	__ATTR_NULL
 };
@@ -596,6 +560,36 @@
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
@@ -660,6 +654,7 @@
 
 	serio_bus.dev_attrs = serio_device_attrs;
 	serio_bus.drv_attrs = serio_driver_attrs;
+	serio_bus.rebind_helper = serio_rebind_driver;
 	bus_register(&serio_bus);
 
 	return 0;
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-10-12 01:29:06 -05:00
+++ b/include/linux/device.h	2004-10-12 01:29:06 -05:00
@@ -59,7 +59,8 @@
 	struct driver_attribute	* drv_attrs;
 
 	int		(*match)(struct device * dev, struct device_driver * drv);
-	int		(*hotplug) (struct device *dev, char **envp, 
+	int		(*rebind_helper)(struct device * dev, const char * buf, size_t count);
+	int		(*hotplug) (struct device *dev, char **envp,
 				    int num_envp, char *buffer, int buffer_size);
 	int		(*suspend)(struct device * dev, u32 state);
 	int		(*resume)(struct device * dev);
