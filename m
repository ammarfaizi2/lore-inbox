Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUG2O0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUG2O0e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUG2OW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:22:59 -0400
Received: from styx.suse.cz ([82.119.242.94]:29334 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264704AbUG2OIN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:13 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 38/47] allow users to manually rebind serio ports
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:56 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101962104@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101963805@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1757.15.33, 2004-06-29 01:29:39-05:00, dtor_core@ameritech.net
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
--- a/drivers/input/serio/serio.c	Thu Jul 29 14:39:12 2004
+++ b/drivers/input/serio/serio.c	Thu Jul 29 14:39:12 2004
@@ -250,7 +250,39 @@
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

