Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbUKXHei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbUKXHei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbUKXHdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:33:19 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:7014 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262365AbUKXHPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:15:00 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 10/11] gameport renames part 2
Date: Wed, 24 Nov 2004 02:11:45 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411240205.10502.dtor_core@ameritech.net> <200411240210.49162.dtor_core@ameritech.net> <200411240211.20241.dtor_core@ameritech.net>
In-Reply-To: <200411240211.20241.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411240211.47746.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1965, 2004-11-24 01:27:02-05:00, dtor_core@ameritech.net
  nput: more renames in serio in preparations to sysfs integration
         - gameport_dev -> gameport_driver
         - gameport_[un]register_device -> gameport_[un]register_driver
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/gameport/gameport.c   |   52 ++++++++++++++++++------------------
 drivers/input/joystick/a3d.c        |   10 +++---
 drivers/input/joystick/adi.c        |   10 +++---
 drivers/input/joystick/analog.c     |   18 ++++++------
 drivers/input/joystick/cobra.c      |   10 +++---
 drivers/input/joystick/gf2k.c       |   10 +++---
 drivers/input/joystick/grip.c       |   10 +++---
 drivers/input/joystick/grip_mp.c    |   10 +++---
 drivers/input/joystick/guillemot.c  |   10 +++---
 drivers/input/joystick/interact.c   |   10 +++---
 drivers/input/joystick/joydump.c    |   10 +++---
 drivers/input/joystick/sidewinder.c |   10 +++---
 drivers/input/joystick/tmdc.c       |   10 +++---
 include/linux/gameport.h            |   12 ++++----
 14 files changed, 96 insertions(+), 96 deletions(-)


===================================================================



diff -Nru a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
--- a/drivers/input/gameport/gameport.c	2004-11-24 02:03:16 -05:00
+++ b/drivers/input/gameport/gameport.c	2004-11-24 02:03:16 -05:00
@@ -25,15 +25,15 @@
 
 EXPORT_SYMBOL(gameport_register_port);
 EXPORT_SYMBOL(gameport_unregister_port);
-EXPORT_SYMBOL(gameport_register_device);
-EXPORT_SYMBOL(gameport_unregister_device);
+EXPORT_SYMBOL(gameport_register_driver);
+EXPORT_SYMBOL(gameport_unregister_driver);
 EXPORT_SYMBOL(gameport_open);
 EXPORT_SYMBOL(gameport_close);
 EXPORT_SYMBOL(gameport_rescan);
 EXPORT_SYMBOL(gameport_cooked_read);
 
 static LIST_HEAD(gameport_list);
-static LIST_HEAD(gameport_dev_list);
+static LIST_HEAD(gameport_driver_list);
 
 #ifdef __i386__
 
@@ -100,61 +100,61 @@
 #endif
 }
 
-static void gameport_find_dev(struct gameport *gameport)
+static void gameport_find_driver(struct gameport *gameport)
 {
-        struct gameport_dev *dev;
+        struct gameport_driver *drv;
 
-        list_for_each_entry(dev, &gameport_dev_list, node) {
-		if (gameport->dev)
+        list_for_each_entry(drv, &gameport_driver_list, node) {
+		if (gameport->drv)
 			break;
-		if (dev->connect)
-                	dev->connect(gameport, dev);
+		if (drv->connect)
+                	drv->connect(gameport, drv);
         }
 }
 
 void gameport_rescan(struct gameport *gameport)
 {
 	gameport_close(gameport);
-	gameport_find_dev(gameport);
+	gameport_find_driver(gameport);
 }
 
 void gameport_register_port(struct gameport *gameport)
 {
 	list_add_tail(&gameport->node, &gameport_list);
 	gameport->speed = gameport_measure_speed(gameport);
-	gameport_find_dev(gameport);
+	gameport_find_driver(gameport);
 }
 
 void gameport_unregister_port(struct gameport *gameport)
 {
 	list_del_init(&gameport->node);
-	if (gameport->dev && gameport->dev->disconnect)
-		gameport->dev->disconnect(gameport);
+	if (gameport->drv && gameport->drv->disconnect)
+		gameport->drv->disconnect(gameport);
 }
 
-void gameport_register_device(struct gameport_dev *dev)
+void gameport_register_driver(struct gameport_driver *drv)
 {
 	struct gameport *gameport;
 
-	list_add_tail(&dev->node, &gameport_dev_list);
+	list_add_tail(&drv->node, &gameport_driver_list);
 	list_for_each_entry(gameport, &gameport_list, node)
-		if (!gameport->dev && dev->connect)
-			dev->connect(gameport, dev);
+		if (!gameport->drv && drv->connect)
+			drv->connect(gameport, drv);
 }
 
-void gameport_unregister_device(struct gameport_dev *dev)
+void gameport_unregister_driver(struct gameport_driver *drv)
 {
 	struct gameport *gameport;
 
-	list_del_init(&dev->node);
+	list_del_init(&drv->node);
 	list_for_each_entry(gameport, &gameport_list, node) {
-		if (gameport->dev == dev && dev->disconnect)
-			dev->disconnect(gameport);
-		gameport_find_dev(gameport);
+		if (gameport->drv == drv && drv->disconnect)
+			drv->disconnect(gameport);
+		gameport_find_driver(gameport);
 	}
 }
 
-int gameport_open(struct gameport *gameport, struct gameport_dev *dev, int mode)
+int gameport_open(struct gameport *gameport, struct gameport_driver *drv, int mode)
 {
 	if (gameport->open) {
 		if (gameport->open(gameport, mode))
@@ -164,17 +164,17 @@
 			return -1;
 	}
 
-	if (gameport->dev)
+	if (gameport->drv)
 		return -1;
 
-	gameport->dev = dev;
+	gameport->drv = drv;
 
 	return 0;
 }
 
 void gameport_close(struct gameport *gameport)
 {
-	gameport->dev = NULL;
+	gameport->drv = NULL;
 	if (gameport->close)
 		gameport->close(gameport);
 }
diff -Nru a/drivers/input/joystick/a3d.c b/drivers/input/joystick/a3d.c
--- a/drivers/input/joystick/a3d.c	2004-11-24 02:03:16 -05:00
+++ b/drivers/input/joystick/a3d.c	2004-11-24 02:03:16 -05:00
@@ -258,7 +258,7 @@
  * a3d_connect() probes for A3D joysticks.
  */
 
-static void a3d_connect(struct gameport *gameport, struct gameport_dev *dev)
+static void a3d_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct a3d *a3d;
 	unsigned char data[A3D_MAX_LENGTH];
@@ -275,7 +275,7 @@
 	a3d->timer.data = (long) a3d;
 	a3d->timer.function = a3d_timer;
 
-	if (gameport_open(gameport, dev, GAMEPORT_MODE_RAW))
+	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
 		goto fail1;
 
 	i = a3d_read_packet(gameport, A3D_MAX_LENGTH, data);
@@ -385,20 +385,20 @@
 	kfree(a3d);
 }
 
-static struct gameport_dev a3d_dev = {
+static struct gameport_driver a3d_drv = {
 	.connect =	a3d_connect,
 	.disconnect =	a3d_disconnect,
 };
 
 int __init a3d_init(void)
 {
-	gameport_register_device(&a3d_dev);
+	gameport_register_driver(&a3d_drv);
 	return 0;
 }
 
 void __exit a3d_exit(void)
 {
-	gameport_unregister_device(&a3d_dev);
+	gameport_unregister_driver(&a3d_drv);
 }
 
 module_init(a3d_init);
diff -Nru a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
--- a/drivers/input/joystick/adi.c	2004-11-24 02:03:16 -05:00
+++ b/drivers/input/joystick/adi.c	2004-11-24 02:03:16 -05:00
@@ -475,7 +475,7 @@
  * adi_connect() probes for Logitech ADI joysticks.
  */
 
-static void adi_connect(struct gameport *gameport, struct gameport_dev *dev)
+static void adi_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct adi_port *port;
 	int i;
@@ -491,7 +491,7 @@
 	port->timer.data = (long) port;
 	port->timer.function = adi_timer;
 
-	if (gameport_open(gameport, dev, GAMEPORT_MODE_RAW)) {
+	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW)) {
 		kfree(port);
 		return;
 	}
@@ -544,20 +544,20 @@
  * The gameport device structure.
  */
 
-static struct gameport_dev adi_dev = {
+static struct gameport_driver adi_drv = {
 	.connect =	adi_connect,
 	.disconnect =	adi_disconnect,
 };
 
 int __init adi_init(void)
 {
-	gameport_register_device(&adi_dev);
+	gameport_register_driver(&adi_drv);
 	return 0;
 }
 
 void __exit adi_exit(void)
 {
-	gameport_unregister_device(&adi_dev);
+	gameport_unregister_driver(&adi_drv);
 }
 
 module_init(adi_init);
diff -Nru a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
--- a/drivers/input/joystick/analog.c	2004-11-24 02:03:16 -05:00
+++ b/drivers/input/joystick/analog.c	2004-11-24 02:03:16 -05:00
@@ -587,7 +587,7 @@
 	return -!(analog[0].mask || analog[1].mask);
 }
 
-static int analog_init_port(struct gameport *gameport, struct gameport_dev *dev, struct analog_port *port)
+static int analog_init_port(struct gameport *gameport, struct gameport_driver *drv, struct analog_port *port)
 {
 	int i, t, u, v;
 
@@ -597,7 +597,7 @@
 	port->timer.data = (long) port;
 	port->timer.function = analog_timer;
 
-	if (!gameport_open(gameport, dev, GAMEPORT_MODE_RAW)) {
+	if (!gameport_open(gameport, drv, GAMEPORT_MODE_RAW)) {
 
 		analog_calibrate_timer(port);
 
@@ -632,7 +632,7 @@
 		gameport_close(gameport);
 	}
 
-	if (!gameport_open(gameport, dev, GAMEPORT_MODE_COOKED)) {
+	if (!gameport_open(gameport, drv, GAMEPORT_MODE_COOKED)) {
 
 		for (i = 0; i < ANALOG_INIT_RETRIES; i++)
 			if (!gameport_cooked_read(gameport, port->axes, &port->buttons))
@@ -645,13 +645,13 @@
 		return 0;
 	}
 
-	if (!gameport_open(gameport, dev, GAMEPORT_MODE_RAW))
+	if (!gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
 		return 0;
 
 	return -1;
 }
 
-static void analog_connect(struct gameport *gameport, struct gameport_dev *dev)
+static void analog_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct analog_port *port;
 	int i;
@@ -660,7 +660,7 @@
 		return;
 	memset(port, 0, sizeof(struct analog_port));
 
-	if (analog_init_port(gameport, dev, port)) {
+	if (analog_init_port(gameport, drv, port)) {
 		kfree(port);
 		return;
 	}
@@ -741,7 +741,7 @@
  * The gameport device structure.
  */
 
-static struct gameport_dev analog_dev = {
+static struct gameport_driver analog_drv = {
 	.connect =	analog_connect,
 	.disconnect =	analog_disconnect,
 };
@@ -749,13 +749,13 @@
 int __init analog_init(void)
 {
 	analog_parse_options();
-	gameport_register_device(&analog_dev);
+	gameport_register_driver(&analog_drv);
 	return 0;
 }
 
 void __exit analog_exit(void)
 {
-	gameport_unregister_device(&analog_dev);
+	gameport_unregister_driver(&analog_drv);
 }
 
 module_init(analog_init);
diff -Nru a/drivers/input/joystick/cobra.c b/drivers/input/joystick/cobra.c
--- a/drivers/input/joystick/cobra.c	2004-11-24 02:03:16 -05:00
+++ b/drivers/input/joystick/cobra.c	2004-11-24 02:03:16 -05:00
@@ -158,7 +158,7 @@
 		del_timer(&cobra->timer);
 }
 
-static void cobra_connect(struct gameport *gameport, struct gameport_dev *dev)
+static void cobra_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct cobra *cobra;
 	unsigned int data[2];
@@ -175,7 +175,7 @@
 	cobra->timer.data = (long) cobra;
 	cobra->timer.function = cobra_timer;
 
-	if (gameport_open(gameport, dev, GAMEPORT_MODE_RAW))
+	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
 		goto fail1;
 
 	cobra->exists = cobra_read_packet(gameport, data);
@@ -236,20 +236,20 @@
 	kfree(cobra);
 }
 
-static struct gameport_dev cobra_dev = {
+static struct gameport_driver cobra_drv = {
 	.connect =	cobra_connect,
 	.disconnect =	cobra_disconnect,
 };
 
 int __init cobra_init(void)
 {
-	gameport_register_device(&cobra_dev);
+	gameport_register_driver(&cobra_drv);
 	return 0;
 }
 
 void __exit cobra_exit(void)
 {
-	gameport_unregister_device(&cobra_dev);
+	gameport_unregister_driver(&cobra_drv);
 }
 
 module_init(cobra_init);
diff -Nru a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
--- a/drivers/input/joystick/gf2k.c	2004-11-24 02:03:16 -05:00
+++ b/drivers/input/joystick/gf2k.c	2004-11-24 02:03:16 -05:00
@@ -238,7 +238,7 @@
  * gf2k_connect() probes for Genius id joysticks.
  */
 
-static void gf2k_connect(struct gameport *gameport, struct gameport_dev *dev)
+static void gf2k_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct gf2k *gf2k;
 	unsigned char data[GF2K_LENGTH];
@@ -255,7 +255,7 @@
 	gf2k->timer.data = (long) gf2k;
 	gf2k->timer.function = gf2k_timer;
 
-	if (gameport_open(gameport, dev, GAMEPORT_MODE_RAW))
+	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
 		goto fail1;
 
 	gf2k_trigger_seq(gameport, gf2k_seq_reset);
@@ -346,20 +346,20 @@
 	kfree(gf2k);
 }
 
-static struct gameport_dev gf2k_dev = {
+static struct gameport_driver gf2k_drv = {
 	.connect =	gf2k_connect,
 	.disconnect =	gf2k_disconnect,
 };
 
 int __init gf2k_init(void)
 {
-	gameport_register_device(&gf2k_dev);
+	gameport_register_driver(&gf2k_drv);
 	return 0;
 }
 
 void __exit gf2k_exit(void)
 {
-	gameport_unregister_device(&gf2k_dev);
+	gameport_unregister_driver(&gf2k_drv);
 }
 
 module_init(gf2k_init);
diff -Nru a/drivers/input/joystick/grip.c b/drivers/input/joystick/grip.c
--- a/drivers/input/joystick/grip.c	2004-11-24 02:03:16 -05:00
+++ b/drivers/input/joystick/grip.c	2004-11-24 02:03:16 -05:00
@@ -298,7 +298,7 @@
 		del_timer(&grip->timer);
 }
 
-static void grip_connect(struct gameport *gameport, struct gameport_dev *dev)
+static void grip_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct grip *grip;
 	unsigned int data[GRIP_LENGTH_XT];
@@ -315,7 +315,7 @@
 	grip->timer.data = (long) grip;
 	grip->timer.function = grip_timer;
 
-	 if (gameport_open(gameport, dev, GAMEPORT_MODE_RAW))
+	 if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
 		goto fail1;
 
 	for (i = 0; i < 2; i++) {
@@ -409,20 +409,20 @@
 	kfree(grip);
 }
 
-static struct gameport_dev grip_dev = {
+static struct gameport_driver grip_drv = {
 	.connect =	grip_connect,
 	.disconnect =	grip_disconnect,
 };
 
 int __init grip_init(void)
 {
-	gameport_register_device(&grip_dev);
+	gameport_register_driver(&grip_drv);
 	return 0;
 }
 
 void __exit grip_exit(void)
 {
-	gameport_unregister_device(&grip_dev);
+	gameport_unregister_driver(&grip_drv);
 }
 
 module_init(grip_init);
diff -Nru a/drivers/input/joystick/grip_mp.c b/drivers/input/joystick/grip_mp.c
--- a/drivers/input/joystick/grip_mp.c	2004-11-24 02:03:16 -05:00
+++ b/drivers/input/joystick/grip_mp.c	2004-11-24 02:03:16 -05:00
@@ -616,7 +616,7 @@
 	mod_timer(&grip->timer, jiffies + GRIP_REFRESH_TIME);
 }
 
-static void grip_connect(struct gameport *gameport, struct gameport_dev *dev)
+static void grip_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct grip_mp *grip;
 
@@ -629,7 +629,7 @@
 	grip->timer.data = (long) grip;
 	grip->timer.function = grip_timer;
 
-	if (gameport_open(gameport, dev, GAMEPORT_MODE_RAW))
+	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
 		goto fail1;
 	if (!multiport_init(grip))
 		goto fail2;
@@ -654,20 +654,20 @@
 	kfree(grip);
 }
 
-static struct gameport_dev grip_dev = {
+static struct gameport_driver grip_drv = {
 	.connect	= grip_connect,
 	.disconnect	= grip_disconnect,
 };
 
 static int grip_init(void)
 {
-	gameport_register_device(&grip_dev);
+	gameport_register_driver(&grip_drv);
 	return 0;
 }
 
 static void grip_exit(void)
 {
-	gameport_unregister_device(&grip_dev);
+	gameport_unregister_driver(&grip_drv);
 }
 
 module_init(grip_init);
diff -Nru a/drivers/input/joystick/guillemot.c b/drivers/input/joystick/guillemot.c
--- a/drivers/input/joystick/guillemot.c	2004-11-24 02:03:16 -05:00
+++ b/drivers/input/joystick/guillemot.c	2004-11-24 02:03:16 -05:00
@@ -179,7 +179,7 @@
  * guillemot_connect() probes for Guillemot joysticks.
  */
 
-static void guillemot_connect(struct gameport *gameport, struct gameport_dev *dev)
+static void guillemot_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct guillemot *guillemot;
 	u8 data[GUILLEMOT_MAX_LENGTH];
@@ -196,7 +196,7 @@
 	guillemot->timer.data = (long) guillemot;
 	guillemot->timer.function = guillemot_timer;
 
-	if (gameport_open(gameport, dev, GAMEPORT_MODE_RAW))
+	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
 		goto fail1;
 
 	i = guillemot_read_packet(gameport, data);
@@ -266,20 +266,20 @@
 	kfree(guillemot);
 }
 
-static struct gameport_dev guillemot_dev = {
+static struct gameport_driver guillemot_drv = {
 	.connect =	guillemot_connect,
 	.disconnect =	guillemot_disconnect,
 };
 
 int __init guillemot_init(void)
 {
-	gameport_register_device(&guillemot_dev);
+	gameport_register_driver(&guillemot_drv);
 	return 0;
 }
 
 void __exit guillemot_exit(void)
 {
-	gameport_unregister_device(&guillemot_dev);
+	gameport_unregister_driver(&guillemot_drv);
 }
 
 module_init(guillemot_init);
diff -Nru a/drivers/input/joystick/interact.c b/drivers/input/joystick/interact.c
--- a/drivers/input/joystick/interact.c	2004-11-24 02:03:16 -05:00
+++ b/drivers/input/joystick/interact.c	2004-11-24 02:03:16 -05:00
@@ -209,7 +209,7 @@
  * interact_connect() probes for InterAct joysticks.
  */
 
-static void interact_connect(struct gameport *gameport, struct gameport_dev *dev)
+static void interact_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct interact *interact;
 	__u32 data[3];
@@ -226,7 +226,7 @@
 	interact->timer.data = (long) interact;
 	interact->timer.function = interact_timer;
 
-	if (gameport_open(gameport, dev, GAMEPORT_MODE_RAW))
+	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
 		goto fail1;
 
 	i = interact_read_packet(gameport, INTERACT_MAX_LENGTH * 2, data);
@@ -294,20 +294,20 @@
 	kfree(interact);
 }
 
-static struct gameport_dev interact_dev = {
+static struct gameport_driver interact_drv = {
 	.connect =	interact_connect,
 	.disconnect =	interact_disconnect,
 };
 
 int __init interact_init(void)
 {
-	gameport_register_device(&interact_dev);
+	gameport_register_driver(&interact_drv);
 	return 0;
 }
 
 void __exit interact_exit(void)
 {
-	gameport_unregister_device(&interact_dev);
+	gameport_unregister_driver(&interact_drv);
 }
 
 module_init(interact_init);
diff -Nru a/drivers/input/joystick/joydump.c b/drivers/input/joystick/joydump.c
--- a/drivers/input/joystick/joydump.c	2004-11-24 02:03:16 -05:00
+++ b/drivers/input/joystick/joydump.c	2004-11-24 02:03:16 -05:00
@@ -46,7 +46,7 @@
 	unsigned char data;
 };
 
-static void __devinit joydump_connect(struct gameport *gameport, struct gameport_dev *dev)
+static void __devinit joydump_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct joydump buf[BUF_SIZE];
 	int axes[4], buttons;
@@ -58,7 +58,7 @@
 	printk(KERN_INFO "joydump: | Dumping gameport%s.\n", gameport->phys);
 	printk(KERN_INFO "joydump: | Speed: %4d kHz.                            |\n", gameport->speed);
 
-	if (gameport_open(gameport, dev, GAMEPORT_MODE_RAW)) {
+	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW)) {
 
 		printk(KERN_INFO "joydump: | Raw mode not available - trying cooked.    |\n");
 
@@ -131,20 +131,20 @@
 	gameport_close(gameport);
 }
 
-static struct gameport_dev joydump_dev = {
+static struct gameport_driver joydump_drv = {
 	.connect =	joydump_connect,
 	.disconnect =	joydump_disconnect,
 };
 
 static int __init joydump_init(void)
 {
-	gameport_register_device(&joydump_dev);
+	gameport_register_driver(&joydump_drv);
 	return 0;
 }
 
 static void __exit joydump_exit(void)
 {
-	gameport_unregister_device(&joydump_dev);
+	gameport_unregister_driver(&joydump_drv);
 }
 
 module_init(joydump_init);
diff -Nru a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
--- a/drivers/input/joystick/sidewinder.c	2004-11-24 02:03:16 -05:00
+++ b/drivers/input/joystick/sidewinder.c	2004-11-24 02:03:16 -05:00
@@ -569,7 +569,7 @@
  * sw_connect() probes for SideWinder type joysticks.
  */
 
-static void sw_connect(struct gameport *gameport, struct gameport_dev *dev)
+static void sw_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct sw *sw;
 	int i, j, k, l;
@@ -595,7 +595,7 @@
 	sw->timer.data = (long) sw;
 	sw->timer.function = sw_timer;
 
-	if (gameport_open(gameport, dev, GAMEPORT_MODE_RAW))
+	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
 		goto fail1;
 
 	dbg("Init 0: Opened %s, io %#x, speed %d",
@@ -760,20 +760,20 @@
 	kfree(sw);
 }
 
-static struct gameport_dev sw_dev = {
+static struct gameport_driver sw_drv = {
 	.connect =	sw_connect,
 	.disconnect =	sw_disconnect,
 };
 
 int __init sw_init(void)
 {
-	gameport_register_device(&sw_dev);
+	gameport_register_driver(&sw_drv);
 	return 0;
 }
 
 void __exit sw_exit(void)
 {
-	gameport_unregister_device(&sw_dev);
+	gameport_unregister_driver(&sw_drv);
 }
 
 module_init(sw_init);
diff -Nru a/drivers/input/joystick/tmdc.c b/drivers/input/joystick/tmdc.c
--- a/drivers/input/joystick/tmdc.c	2004-11-24 02:03:16 -05:00
+++ b/drivers/input/joystick/tmdc.c	2004-11-24 02:03:16 -05:00
@@ -242,7 +242,7 @@
  * tmdc_probe() probes for ThrustMaster type joysticks.
  */
 
-static void tmdc_connect(struct gameport *gameport, struct gameport_dev *dev)
+static void tmdc_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct models {
 		unsigned char id;
@@ -275,7 +275,7 @@
 	tmdc->timer.data = (long) tmdc;
 	tmdc->timer.function = tmdc_timer;
 
-	if (gameport_open(gameport, dev, GAMEPORT_MODE_RAW))
+	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
 		goto fail1;
 
 	if (!(tmdc->exists = tmdc_read_packet(gameport, data)))
@@ -362,20 +362,20 @@
 	kfree(tmdc);
 }
 
-static struct gameport_dev tmdc_dev = {
+static struct gameport_driver tmdc_drv = {
 	.connect =	tmdc_connect,
 	.disconnect =	tmdc_disconnect,
 };
 
 int __init tmdc_init(void)
 {
-	gameport_register_device(&tmdc_dev);
+	gameport_register_driver(&tmdc_drv);
 	return 0;
 }
 
 void __exit tmdc_exit(void)
 {
-	gameport_unregister_device(&tmdc_dev);
+	gameport_unregister_driver(&tmdc_drv);
 }
 
 module_init(tmdc_init);
diff -Nru a/include/linux/gameport.h b/include/linux/gameport.h
--- a/include/linux/gameport.h	2004-11-24 02:03:16 -05:00
+++ b/include/linux/gameport.h	2004-11-24 02:03:16 -05:00
@@ -35,23 +35,23 @@
 	int (*open)(struct gameport *, int);
 	void (*close)(struct gameport *);
 
-	struct gameport_dev *dev;
+	struct gameport_driver *drv;
 
 	struct list_head node;
 };
 
-struct gameport_dev {
+struct gameport_driver {
 
 	void *private;
 	char *name;
 
-	void (*connect)(struct gameport *, struct gameport_dev *dev);
+	void (*connect)(struct gameport *, struct gameport_driver *drv);
 	void (*disconnect)(struct gameport *);
 
 	struct list_head node;
 };
 
-int gameport_open(struct gameport *gameport, struct gameport_dev *dev, int mode);
+int gameport_open(struct gameport *gameport, struct gameport_driver *drv, int mode);
 void gameport_close(struct gameport *gameport);
 void gameport_rescan(struct gameport *gameport);
 
@@ -63,8 +63,8 @@
 static inline void gameport_unregister_port(struct gameport *gameport) { return; }
 #endif
 
-void gameport_register_device(struct gameport_dev *dev);
-void gameport_unregister_device(struct gameport_dev *dev);
+void gameport_register_driver(struct gameport_driver *drv);
+void gameport_unregister_driver(struct gameport_driver *drv);
 
 #define GAMEPORT_MODE_DISABLED		0
 #define GAMEPORT_MODE_RAW		1
