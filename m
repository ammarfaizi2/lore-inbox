Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUKHH1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUKHH1c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 02:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbUKHH1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 02:27:32 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:31336 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261763AbUKHH06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 02:26:58 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Add drvctl default device attribute
Date: Mon, 8 Nov 2004 02:23:54 -0500
User-Agent: KMail/1.6.2
Cc: Tejun Heo <tj@home-tj.org>, Greg KH <greg@kroah.com>,
       rusty@rustcorp.com.au, mochel@osdl.org
References: <20041104074330.GG25567@home-tj.org> <20041105063237.GA28308@home-tj.org> <200411080223.07639.dtor_core@ameritech.net>
In-Reply-To: <200411080223.07639.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411080223.56536.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1961, 2004-11-08 02:03:59-05:00, dtor_core@ameritech.net
  Driver core: add "drvctl" default device attribute that allows
               userspace request execution of bus-specific actions
               for devices. Used to manually control driver and
               device binding/unbinding/rebinding, causes execution
               of bus->drvctl() helper. Expects commands in form of
               "CMD [DRIVER NAME] [ARG ARG...]]".
  
               Serio bus's drvctl rearranged to accept the following
               commands: "detach", "attach <driver>", "rescan", and
               "reconnect".
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/base/interface.c    |   74 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/input/serio/serio.c |   61 +++++++++++++++++-------------------
 include/linux/device.h      |    4 +-
 3 files changed, 106 insertions(+), 33 deletions(-)


===================================================================



diff -Nru a/drivers/base/interface.c b/drivers/base/interface.c
--- a/drivers/base/interface.c	2004-11-08 02:10:34 -05:00
+++ b/drivers/base/interface.c	2004-11-08 02:10:34 -05:00
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/stat.h>
 #include <linux/string.h>
+#include <linux/ctype.h>
 
 /**
  *	detach_state - control the default power state for the device.
@@ -42,10 +43,81 @@
 	return n;
 }
 
-static DEVICE_ATTR(detach_state, 0644, detach_show, detach_store);
+/**
+ *	drvctl - controls device and driver binding.
+ *
+ *	Writing to the attribute causes execution of bus-specific drvctl()
+ *	helper that is used to disconnect device from its driver or rebind
+ *	device to a specific driver.
+ *	Commands are expected in the following format:
+ *	CMD [DRIVER_NAME] [ARG ARG ARG]
+ *	drvctl handler is free to mangle the args string.
+ */
+
+#define GET_WORD(x)					\
+do {							\
+	while (isspace(*args)) args++;			\
+	(x) = args;					\
+	while (*args && !isspace(*args)) args++;	\
+	if (isspace(*args)) {				\
+		save_chr = *args;			\
+		*args++ = '\0';				\
+	}						\
+} while (0)						\
 
+static ssize_t drvctl_store(struct device * dev, const char * buf, size_t count)
+{
+	int retval = -ENOSYS;
+	struct device_driver *drv = NULL;
+	char *str, *action, *drv_name, *args;
+	char save_chr = 0;
+
+	if (!dev->bus->drvctl)
+		return -ENOSYS;
+
+	/* copy buffer so we can mangle it */
+	if (!(args = str = kmalloc(count + 1, GFP_KERNEL)))
+		return -ENOMEM;
+
+	memcpy(str, buf, count);
+	str[count] = '\0';
+
+	GET_WORD(action);
+	GET_WORD(drv_name);
+
+	if (*drv_name) {
+		if (!(drv = driver_find(drv_name, dev->bus))) {
+			/*
+			 * if this is not a name of existing driver
+			 * merge it with thye rest of the string and
+			 * pass to drvctl as 'args'
+			 */
+			if (*args)
+				*--args = save_chr;
+			args = drv_name;
+		}
+	}
+
+	while (*args == ' ') args++;
+
+	pr_debug("drvctl -  action: '%s', driver: '%s', args: '%s'\n",
+		 action, drv ? drv->name : "", args);
+
+	retval = dev->bus->drvctl(dev, action, drv, args);
+
+	if (drv)
+		put_driver(drv);
+	kfree(str);
+
+	return (retval < 0) ? retval : count;
+}
+#undef GET_WORD
+
+static DEVICE_ATTR(detach_state, 0644, detach_show, detach_store);
+static DEVICE_ATTR(drvctl, 0200, NULL, drvctl_store);
 
 struct attribute * dev_default_attrs[] = {
 	&dev_attr_detach_state.attr,
+	&dev_attr_drvctl.attr,
 	NULL,
 };
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-11-08 02:10:34 -05:00
+++ b/drivers/input/serio/serio.c	2004-11-08 02:10:34 -05:00
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
@@ -597,6 +566,35 @@
 	up(&serio_sem);
 }
 
+static int serio_rebind_driver(struct device *dev, const char *action,
+			       struct device_driver *drv, char *args)
+{
+	struct serio *serio = to_serio_port(dev);
+	int retval;
+
+	retval = down_interruptible(&serio_sem);
+	if (retval)
+		return retval;
+
+	if (!strcmp(action, "detach")) {
+		serio_disconnect_port(serio);
+	} else if (!strcmp(action, "reconnect")) {
+		serio_reconnect_port(serio);
+	} else if (!strcmp(action, "rescan")) {
+		serio_disconnect_port(serio);
+		serio_connect_port(serio, NULL);
+	} else if (!strcmp(action, "attach") && drv) {
+		serio_disconnect_port(serio);
+		serio_connect_port(serio, to_serio_driver(drv));
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
@@ -661,6 +659,7 @@
 
 	serio_bus.dev_attrs = serio_device_attrs;
 	serio_bus.drv_attrs = serio_driver_attrs;
+	serio_bus.drvctl = serio_rebind_driver;
 	bus_register(&serio_bus);
 
 	return 0;
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-11-08 02:10:34 -05:00
+++ b/include/linux/device.h	2004-11-08 02:10:34 -05:00
@@ -59,7 +59,9 @@
 	struct driver_attribute	* drv_attrs;
 
 	int		(*match)(struct device * dev, struct device_driver * drv);
-	int		(*hotplug) (struct device *dev, char **envp, 
+	int		(*drvctl)(struct device * dev, const char * action,
+				  struct device_driver * drv, char * args);
+	int		(*hotplug) (struct device *dev, char **envp,
 				    int num_envp, char *buffer, int buffer_size);
 	int		(*suspend)(struct device * dev, u32 state);
 	int		(*resume)(struct device * dev);
