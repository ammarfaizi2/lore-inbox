Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUF1F20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUF1F20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbUF1F20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:28:26 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:16056 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264660AbUF1FQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:16:30 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 8/19] serio rebind
Date: Mon, 28 Jun 2004 00:16:27 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net> <200406280014.48692.dtor_core@ameritech.net> <200406280015.38752.dtor_core@ameritech.net>
In-Reply-To: <200406280015.38752.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280016.29032.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1782, 2004-06-27 15:56:07-05:00, dtor_core@ameritech.net
  Input: allow users manually rebind serio ports, like this:
         echo -n "psmouse" > /sys/bus/serio/devices/serio0/driver
         echo -n "atkbd" > /sys/bus/serio/devices/serio1/driver
         echo -n "none" > /sys/bus/serio/devices/serio1/driver
         echo -n "reconnect" > /sys/bus/serio/devices/serio1/driver
         echo -n "rescan" > /sys/bus/serio/devices/serio1/driver
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 serio.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-06-27 17:49:15 -05:00
+++ b/drivers/input/serio/serio.c	2004-06-27 17:49:15 -05:00
@@ -257,7 +257,39 @@
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
+	retval = count;
+	if (!strncmp(buf, "none", count)) {
+		serio_disconnect_port(serio);
+	} else if (!strncmp(buf, "reconnect", count)) {
+		serio_reconnect_port(serio);
+	} else if (!strncmp(buf, "rescan", count)) {
+		serio_disconnect_port(serio);
+		serio_connect_port(serio, NULL);
+	} else if ((k = kset_find_obj(&serio_bus.drivers, buf)) != NULL) {
+		drv = container_of(k, struct device_driver, kobj);
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
+static DEVICE_ATTR(driver, S_IWUSR | S_IRUGO, serio_show_driver, serio_rebind_driver);
 
 static void serio_release_port(struct device *dev)
 {
