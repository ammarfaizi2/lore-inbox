Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265054AbUFRJCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbUFRJCe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUFRJBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:01:50 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:45397 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265056AbUFRIpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 04:45:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 9/11] serio allow rebinding
Date: Fri, 18 Jun 2004 03:42:39 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       vojtech@ucw.cz
References: <200406180335.52843.dtor_core@ameritech.net> <200406180341.39441.dtor_core@ameritech.net> <200406180342.11056.dtor_core@ameritech.net>
In-Reply-To: <200406180342.11056.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406180342.41100.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1798, 2004-06-18 02:31:47-05:00, dtor_core@ameritech.net
  Input: allow users manually rebind serio ports, like this:
         echo -n "psmouse" > /sys/bus/serio/devices/serio0/driver
         echo -n "atkbd" > /sys/bus/serio/devices/serio1/driver
         echo -n "none" > /sys/devices/serio1/driver
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 serio.c |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-06-18 03:17:30 -05:00
+++ b/drivers/input/serio/serio.c	2004-06-18 03:17:30 -05:00
@@ -257,7 +257,35 @@
 {
 	return sprintf(buf, "%s\n", dev->driver ? dev->driver->name : "(none)");
 }
-static DEVICE_ATTR(driver, S_IRUGO, serio_show_driver, NULL);
+
+static ssize_t serio_rebind_driver(struct device *dev, const char *buf, size_t count)
+{
+	struct serio *serio = to_serio_port(dev);
+	struct device_driver *drv;
+	struct kobject *k;
+	int retval;
+
+	retval = down_interruptible(&serio_sem);
+	if (retval)
+		return retval;
+
+	if (!strncmp(buf, "none", count)) {
+		serio_disconnect_port(serio);
+		retval = count;
+	} else if (!(k = kset_find_obj(&serio_bus.drivers, buf))) {
+		retval = -EINVAL;
+	} else {
+		serio_disconnect_port(serio);
+		drv = container_of(k, struct device_driver, kobj);
+		serio_connect_port(serio, to_serio_driver(drv));
+		retval = count;
+	}
+
+	up(&serio_sem);
+
+	return retval;
+}
+static DEVICE_ATTR(driver, S_IWUSR | S_IRUGO, serio_show_driver, serio_rebind_driver);
 
 static void serio_release_port(struct device *dev)
 {
