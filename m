Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVBKHjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVBKHjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVBKHjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:39:01 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:58974 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262214AbVBKHFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:05:47 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: InputML <linux-input@atrey.karlin.mff.cuni.cz>
Subject: [PATCH 10/10] Gameport: replace ->private with gameport_get/set_drvdata
Date: Fri, 11 Feb 2005 02:05:23 -0500
User-Agent: KMail/1.7.2
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <200502110158.47872.dtor_core@ameritech.net> <200502110204.00573.dtor_core@ameritech.net> <200502110204.40128.dtor_core@ameritech.net>
In-Reply-To: <200502110204.40128.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502110205.25146.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.2158, 2005-02-11 01:23:40-05:00, dtor_core@ameritech.net
  Input: remove gameport->private in favor of using driver-specific data
         in device structure, add gameport_get/set_drvdata to access it.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/joystick/a3d.c        |   10 ++++++----
 drivers/input/joystick/adi.c        |    7 ++++---
 drivers/input/joystick/analog.c     |    7 +++++--
 drivers/input/joystick/cobra.c      |   10 ++++++----
 drivers/input/joystick/gf2k.c       |   10 ++++++----
 drivers/input/joystick/grip.c       |   10 ++++++----
 drivers/input/joystick/grip_mp.c    |    9 ++++++---
 drivers/input/joystick/guillemot.c  |    9 +++++----
 drivers/input/joystick/interact.c   |   10 ++++++----
 drivers/input/joystick/sidewinder.c |   10 ++++++----
 drivers/input/joystick/tmdc.c       |   10 ++++++----
 include/linux/gameport.h            |   15 ++++++++++++++-
 12 files changed, 76 insertions(+), 41 deletions(-)


===================================================================



diff -Nru a/drivers/input/joystick/a3d.c b/drivers/input/joystick/a3d.c
--- a/drivers/input/joystick/a3d.c	2005-02-11 01:41:08 -05:00
+++ b/drivers/input/joystick/a3d.c	2005-02-11 01:41:08 -05:00
@@ -277,13 +277,13 @@
 	if (!(a3d = kcalloc(1, sizeof(struct a3d), GFP_KERNEL)))
 		return -ENOMEM;
 
-	gameport->private = a3d;
-
 	a3d->gameport = gameport;
 	init_timer(&a3d->timer);
 	a3d->timer.data = (long) a3d;
 	a3d->timer.function = a3d_timer;
 
+	gameport_set_drvdata(gameport, a3d);
+
 	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
 	if (err)
 		goto fail1;
@@ -379,13 +379,14 @@
 	return 0;
 
 fail2:	gameport_close(gameport);
-fail1:  kfree(a3d);
+fail1:  gameport_set_drvdata(gameport, NULL);
+	kfree(a3d);
 	return err;
 }
 
 static void a3d_disconnect(struct gameport *gameport)
 {
-	struct a3d *a3d = gameport->private;
+	struct a3d *a3d = gameport_get_drvdata(gameport);
 
 	input_unregister_device(&a3d->dev);
 	if (a3d->adc) {
@@ -393,6 +394,7 @@
 		a3d->adc = NULL;
 	}
 	gameport_close(gameport);
+	gameport_set_drvdata(gameport, NULL);
 	kfree(a3d);
 }
 
diff -Nru a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
--- a/drivers/input/joystick/adi.c	2005-02-11 01:41:08 -05:00
+++ b/drivers/input/joystick/adi.c	2005-02-11 01:41:08 -05:00
@@ -474,13 +474,13 @@
 	if (!(port = kcalloc(1, sizeof(struct adi_port), GFP_KERNEL)))
 		return -ENOMEM;
 
-	gameport->private = port;
-
 	port->gameport = gameport;
 	init_timer(&port->timer);
 	port->timer.data = (long) port;
 	port->timer.function = adi_timer;
 
+	gameport_set_drvdata(gameport, port);
+
 	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
 	if (err) {
 		kfree(port);
@@ -524,12 +524,13 @@
 static void adi_disconnect(struct gameport *gameport)
 {
 	int i;
-	struct adi_port *port = gameport->private;
+	struct adi_port *port = gameport_get_drvdata(gameport);
 
 	for (i = 0; i < 2; i++)
 		if (port->adi[i].length > 0)
 			input_unregister_device(&port->adi[i].dev);
 	gameport_close(gameport);
+	gameport_set_drvdata(gameport, NULL);
 	kfree(port);
 }
 
diff -Nru a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
--- a/drivers/input/joystick/analog.c	2005-02-11 01:41:08 -05:00
+++ b/drivers/input/joystick/analog.c	2005-02-11 01:41:08 -05:00
@@ -593,12 +593,13 @@
 {
 	int i, t, u, v;
 
-	gameport->private = port;
 	port->gameport = gameport;
 	init_timer(&port->timer);
 	port->timer.data = (long) port;
 	port->timer.function = analog_timer;
 
+	gameport_set_drvdata(gameport, port);
+
 	if (!gameport_open(gameport, drv, GAMEPORT_MODE_RAW)) {
 
 		analog_calibrate_timer(port);
@@ -672,6 +673,7 @@
 	err = analog_init_masks(port);
 	if (err) {
 		gameport_close(gameport);
+		gameport_set_drvdata(gameport, NULL);
 		kfree(port);
 		return err;
 	}
@@ -686,12 +688,13 @@
 static void analog_disconnect(struct gameport *gameport)
 {
 	int i;
-	struct analog_port *port = gameport->private;
+	struct analog_port *port = gameport_get_drvdata(gameport);
 
 	for (i = 0; i < 2; i++)
 		if (port->analog[i].mask)
 			input_unregister_device(&port->analog[i].dev);
 	gameport_close(gameport);
+	gameport_set_drvdata(gameport, NULL);
 	printk(KERN_INFO "analog.c: %d out of %d reads (%d%%) on %s failed\n",
 		port->bads, port->reads, port->reads ? (port->bads * 100 / port->reads) : 0,
 		port->gameport->phys);
diff -Nru a/drivers/input/joystick/cobra.c b/drivers/input/joystick/cobra.c
--- a/drivers/input/joystick/cobra.c	2005-02-11 01:41:08 -05:00
+++ b/drivers/input/joystick/cobra.c	2005-02-11 01:41:08 -05:00
@@ -170,13 +170,13 @@
 	if (!(cobra = kcalloc(1, sizeof(struct cobra), GFP_KERNEL)))
 		return -ENOMEM;
 
-	gameport->private = cobra;
-
 	cobra->gameport = gameport;
 	init_timer(&cobra->timer);
 	cobra->timer.data = (long) cobra;
 	cobra->timer.function = cobra_timer;
 
+	gameport_set_drvdata(gameport, cobra);
+
 	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
 	if (err)
 		goto fail1;
@@ -226,19 +226,21 @@
 	return 0;
 
 fail2:	gameport_close(gameport);
-fail1:	kfree(cobra);
+fail1:	gameport_set_drvdata(gameport, NULL);
+	kfree(cobra);
 	return err;
 }
 
 static void cobra_disconnect(struct gameport *gameport)
 {
+	struct cobra *cobra = gameport_get_drvdata(gameport);
 	int i;
-	struct cobra *cobra = gameport->private;
 
 	for (i = 0; i < 2; i++)
 		if ((cobra->exists >> i) & 1)
 			input_unregister_device(cobra->dev + i);
 	gameport_close(gameport);
+	gameport_set_drvdata(gameport, NULL);
 	kfree(cobra);
 }
 
diff -Nru a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
--- a/drivers/input/joystick/gf2k.c	2005-02-11 01:41:08 -05:00
+++ b/drivers/input/joystick/gf2k.c	2005-02-11 01:41:08 -05:00
@@ -249,13 +249,13 @@
 	if (!(gf2k = kcalloc(1, sizeof(struct gf2k), GFP_KERNEL)))
 		return -ENOMEM;
 
-	gameport->private = gf2k;
-
 	gf2k->gameport = gameport;
 	init_timer(&gf2k->timer);
 	gf2k->timer.data = (long) gf2k;
 	gf2k->timer.function = gf2k_timer;
 
+	gameport_set_drvdata(gameport, gf2k);
+
 	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
 	if (err)
 		goto fail1;
@@ -345,16 +345,18 @@
 	return 0;
 
 fail2:	gameport_close(gameport);
-fail1:	kfree(gf2k);
+fail1:	gameport_set_drvdata(gameport, NULL);
+	kfree(gf2k);
 	return err;
 }
 
 static void gf2k_disconnect(struct gameport *gameport)
 {
-	struct gf2k *gf2k = gameport->private;
+	struct gf2k *gf2k = gameport_get_drvdata(gameport);
 
 	input_unregister_device(&gf2k->dev);
 	gameport_close(gameport);
+	gameport_set_drvdata(gameport, NULL);
 	kfree(gf2k);
 }
 
diff -Nru a/drivers/input/joystick/grip.c b/drivers/input/joystick/grip.c
--- a/drivers/input/joystick/grip.c	2005-02-11 01:41:08 -05:00
+++ b/drivers/input/joystick/grip.c	2005-02-11 01:41:08 -05:00
@@ -310,13 +310,13 @@
 	if (!(grip = kcalloc(1, sizeof(struct grip), GFP_KERNEL)))
 		return -ENOMEM;
 
-	gameport->private = grip;
-
 	grip->gameport = gameport;
 	init_timer(&grip->timer);
 	grip->timer.data = (long) grip;
 	grip->timer.function = grip_timer;
 
+	gameport_set_drvdata(gameport, grip);
+
 	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
 	if (err)
 		goto fail1;
@@ -386,19 +386,21 @@
 	return 0;
 
 fail2:	gameport_close(gameport);
-fail1:	kfree(grip);
+fail1:	gameport_set_drvdata(gameport, NULL);
+	kfree(grip);
 	return err;
 }
 
 static void grip_disconnect(struct gameport *gameport)
 {
-	struct grip *grip = gameport->private;
+	struct grip *grip = gameport_get_drvdata(gameport);
 	int i;
 
 	for (i = 0; i < 2; i++)
 		if (grip->mode[i])
 			input_unregister_device(grip->dev + i);
 	gameport_close(gameport);
+	gameport_set_drvdata(gameport, NULL);
 	kfree(grip);
 }
 
diff -Nru a/drivers/input/joystick/grip_mp.c b/drivers/input/joystick/grip_mp.c
--- a/drivers/input/joystick/grip_mp.c	2005-02-11 01:41:08 -05:00
+++ b/drivers/input/joystick/grip_mp.c	2005-02-11 01:41:08 -05:00
@@ -626,12 +626,13 @@
 	if (!(grip = kcalloc(1, sizeof(struct grip_mp), GFP_KERNEL)))
 		return -ENOMEM;
 
-	gameport->private = grip;
 	grip->gameport = gameport;
 	init_timer(&grip->timer);
 	grip->timer.data = (long) grip;
 	grip->timer.function = grip_timer;
 
+	gameport_set_drvdata(gameport, grip);
+
 	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
 	if (err)
 		goto fail1;
@@ -650,19 +651,21 @@
 	return 0;
 
 fail2:	gameport_close(gameport);
-fail1:	kfree(grip);
+fail1:	gameport_set_drvdata(gameport, NULL);
+	kfree(grip);
 	return err;
 }
 
 static void grip_disconnect(struct gameport *gameport)
 {
+	struct grip_mp *grip = gameport_get_drvdata(gameport);
 	int i;
-	struct grip_mp *grip = gameport->private;
 
 	for (i = 0; i < 4; i++)
 		if (grip->registered[i])
 			input_unregister_device(grip->dev + i);
 	gameport_close(gameport);
+	gameport_set_drvdata(gameport, NULL);
 	kfree(grip);
 }
 
diff -Nru a/drivers/input/joystick/guillemot.c b/drivers/input/joystick/guillemot.c
--- a/drivers/input/joystick/guillemot.c	2005-02-11 01:41:08 -05:00
+++ b/drivers/input/joystick/guillemot.c	2005-02-11 01:41:08 -05:00
@@ -193,13 +193,13 @@
 	if (!(guillemot = kcalloc(1, sizeof(struct guillemot), GFP_KERNEL)))
 		return -ENOMEM;
 
-	gameport->private = guillemot;
-
 	guillemot->gameport = gameport;
 	init_timer(&guillemot->timer);
 	guillemot->timer.data = (long) guillemot;
 	guillemot->timer.function = guillemot_timer;
 
+	gameport_set_drvdata(gameport, guillemot);
+
 	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
 	if (err)
 		goto fail1;
@@ -257,13 +257,14 @@
 	return 0;
 
 fail2:	gameport_close(gameport);
-fail1:  kfree(guillemot);
+fail1:  gameport_set_drvdata(gameport, NULL);
+	kfree(guillemot);
 	return err;
 }
 
 static void guillemot_disconnect(struct gameport *gameport)
 {
-	struct guillemot *guillemot = gameport->private;
+	struct guillemot *guillemot = gameport_get_drvdata(gameport);
 
 	printk(KERN_INFO "guillemot.c: Failed %d reads out of %d on %s\n", guillemot->reads, guillemot->bads, guillemot->phys);
 	input_unregister_device(&guillemot->dev);
diff -Nru a/drivers/input/joystick/interact.c b/drivers/input/joystick/interact.c
--- a/drivers/input/joystick/interact.c	2005-02-11 01:41:08 -05:00
+++ b/drivers/input/joystick/interact.c	2005-02-11 01:41:08 -05:00
@@ -223,13 +223,13 @@
 	if (!(interact = kcalloc(1, sizeof(struct interact), GFP_KERNEL)))
 		return -ENOMEM;
 
-	gameport->private = interact;
-
 	interact->gameport = gameport;
 	init_timer(&interact->timer);
 	interact->timer.data = (long) interact;
 	interact->timer.function = interact_timer;
 
+	gameport_set_drvdata(gameport, interact);
+
 	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
 	if (err)
 		goto fail1;
@@ -291,16 +291,18 @@
 	return 0;
 
 fail2:	gameport_close(gameport);
-fail1:  kfree(interact);
+fail1:  gameport_set_drvdata(gameport, NULL);
+	kfree(interact);
 	return err;
 }
 
 static void interact_disconnect(struct gameport *gameport)
 {
-	struct interact *interact = gameport->private;
+	struct interact *interact = gameport_get_drvdata(gameport);
 
 	input_unregister_device(&interact->dev);
 	gameport_close(gameport);
+	gameport_set_drvdata(gameport, NULL);
 	kfree(interact);
 }
 
diff -Nru a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
--- a/drivers/input/joystick/sidewinder.c	2005-02-11 01:41:08 -05:00
+++ b/drivers/input/joystick/sidewinder.c	2005-02-11 01:41:08 -05:00
@@ -605,13 +605,13 @@
 		goto fail1;
 	}
 
-	gameport->private = sw;
-
 	sw->gameport = gameport;
 	init_timer(&sw->timer);
 	sw->timer.data = (long) sw;
 	sw->timer.function = sw_timer;
 
+	gameport_set_drvdata(gameport, sw);
+
 	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
 	if (err)
 		goto fail1;
@@ -770,7 +770,8 @@
 	return 0;
 
 fail2:	gameport_close(gameport);
-fail1:	kfree(sw);
+fail1:	gameport_set_drvdata(gameport, NULL);
+	kfree(sw);
 	kfree(buf);
 	kfree(idbuf);
 	return err;
@@ -778,12 +779,13 @@
 
 static void sw_disconnect(struct gameport *gameport)
 {
+	struct sw *sw = gameport_get_drvdata(gameport);
 	int i;
 
-	struct sw *sw = gameport->private;
 	for (i = 0; i < sw->number; i++)
 		input_unregister_device(sw->dev + i);
 	gameport_close(gameport);
+	gameport_set_drvdata(gameport, NULL);
 	kfree(sw);
 }
 
diff -Nru a/drivers/input/joystick/tmdc.c b/drivers/input/joystick/tmdc.c
--- a/drivers/input/joystick/tmdc.c	2005-02-11 01:41:08 -05:00
+++ b/drivers/input/joystick/tmdc.c	2005-02-11 01:41:08 -05:00
@@ -270,13 +270,13 @@
 	if (!(tmdc = kcalloc(1, sizeof(struct tmdc), GFP_KERNEL)))
 		return -ENOMEM;
 
-	gameport->private = tmdc;
-
 	tmdc->gameport = gameport;
 	init_timer(&tmdc->timer);
 	tmdc->timer.data = (long) tmdc;
 	tmdc->timer.function = tmdc_timer;
 
+	gameport_set_drvdata(gameport, tmdc);
+
 	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
 	if (err)
 		goto fail1;
@@ -347,19 +347,21 @@
 	return 0;
 
 fail2:	gameport_close(gameport);
-fail1:	kfree(tmdc);
+fail1:	gameport_set_drvdata(gameport, NULL);
+	kfree(tmdc);
 	return err;
 }
 
 static void tmdc_disconnect(struct gameport *gameport)
 {
-	struct tmdc *tmdc = gameport->private;
+	struct tmdc *tmdc = gameport_get_drvdata(gameport);
 	int i;
 
 	for (i = 0; i < 2; i++)
 		if (tmdc->exists & (1 << i))
 			input_unregister_device(tmdc->dev + i);
 	gameport_close(gameport);
+	gameport_set_drvdata(gameport, NULL);
 	kfree(tmdc);
 }
 
diff -Nru a/include/linux/gameport.h b/include/linux/gameport.h
--- a/include/linux/gameport.h	2005-02-11 01:41:08 -05:00
+++ b/include/linux/gameport.h	2005-02-11 01:41:08 -05:00
@@ -15,7 +15,6 @@
 
 struct gameport {
 
-	void *private;		/* Private pointer for joystick drivers */
 	void *port_data;	/* Private pointer for gameport drivers */
 	char name[32];
 	char phys[32];
@@ -89,6 +88,20 @@
 
 void gameport_set_phys(struct gameport *gameport, const char *fmt, ...)
 	__attribute__ ((format (printf, 2, 3)));
+
+/*
+ * Use the following fucntions to manipulate gameport's per-port
+ * driver-specific data.
+ */
+static inline void *gameport_get_drvdata(struct gameport *gameport)
+{
+	return dev_get_drvdata(&gameport->dev);
+}
+
+static inline void gameport_set_drvdata(struct gameport *gameport, void *data)
+{
+	dev_set_drvdata(&gameport->dev, data);
+}
 
 /*
  * Use the following fucntions to pin gameport's driver in process context
