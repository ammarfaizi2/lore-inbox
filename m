Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265335AbVBFHrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbVBFHrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 02:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbVBFHrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 02:47:08 -0500
Received: from smtp818.mail.sc5.yahoo.com ([66.163.170.4]:19097 "HELO
	smtp818.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S272654AbVBFHqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 02:46:24 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-input@atrey.karlin.mff.cuni.cz
Subject: [PATCH] Add resume support to serio bus.
Date: Sun, 6 Feb 2005 02:46:20 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502060246.20878.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds resume support to serio_bus based on serio reconnect
framework so now not only i8042 ports will be re-initialized at resume.
It also removes serio_reconnect calls from i8042 as they no longer
needed.

Tested on S4 (swsusp) with Synaptics touchpad.

-- 
Dmitry


===================================================================


ChangeSet@1.2007, 2005-02-06 02:39:30-05:00, dtor_core@ameritech.net
  Input: add resume method to serio bus so ports are properly
         set up at resume time. Remove calls to serio_reconnect
         from i8042 as they should now be reconnected in course
         of regular resume process.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 i8042.c |    8 ++++----
 serio.c |   17 +++++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2005-02-06 02:40:01 -05:00
+++ b/drivers/input/serio/i8042.c	2005-02-06 02:40:01 -05:00
@@ -899,7 +899,7 @@
  * Here we try to restore the original BIOS settings
  */
 
-static int i8042_suspend(struct device *dev, u32 state, u32 level)
+static int i8042_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_DISABLE) {
 		del_timer_sync(&i8042_timer);
@@ -932,12 +932,12 @@
 		}
 
 /*
- * Reconnect anything that was connected to the ports.
+ * Activate all ports.
  */
 
 	for (i = 0; i < I8042_NUM_PORTS; i++)
-		if (i8042_activate_port(&i8042_ports[i]) == 0)
-			serio_reconnect(i8042_ports[i].serio);
+		i8042_activate_port(&i8042_ports[i]);
+
 /*
  * Restart timer (for polling "stuck" data)
  */
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2005-02-06 02:40:01 -05:00
+++ b/drivers/input/serio/serio.c	2005-02-06 02:40:01 -05:00
@@ -774,6 +774,22 @@
 
 #endif /* CONFIG_HOTPLUG */
 
+static int serio_resume(struct device *dev)
+{
+	struct serio *serio = to_serio_port(dev);
+
+	if (!serio->drv || !serio->drv->reconnect || serio->drv->reconnect(serio)) {
+		serio_disconnect_port(serio);
+		/*
+		 * Driver re-probing can take a while, so better let kseriod
+		 * deal with it.
+		 */
+		serio_rescan(serio);
+	}
+
+	return 0;
+}
+
 /* called from serio_driver->connect/disconnect methods under serio_sem */
 int serio_open(struct serio *serio, struct serio_driver *drv)
 {
@@ -826,6 +842,7 @@
 	serio_bus.drv_attrs = serio_driver_attrs;
 	serio_bus.match = serio_bus_match;
 	serio_bus.hotplug = serio_hotplug;
+	serio_bus.resume = serio_resume;
 	bus_register(&serio_bus);
 
 	return 0;
