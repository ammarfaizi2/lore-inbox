Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVBKHcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVBKHcq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVBKHcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:32:45 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:55902 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262212AbVBKHFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:05:44 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: InputML <linux-input@atrey.karlin.mff.cuni.cz>
Subject: [PATCH 8/10] Gameport: add "gameport" sysfs bus, add drivers
Date: Fri, 11 Feb 2005 02:04:00 -0500
User-Agent: KMail/1.7.2
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <200502110158.47872.dtor_core@ameritech.net> <200502110202.48966.dtor_core@ameritech.net> <200502110203.15425.dtor_core@ameritech.net>
In-Reply-To: <200502110203.15425.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502110204.00573.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.2156, 2005-02-11 01:21:02-05:00, dtor_core@ameritech.net
  Input: integrate gameport drivers info dribver model/sysfs,
         create "gameport" bus. drivers' connect() routines
         now return error code instead of void.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/Makefile                    |    2 
 drivers/input/gameport/gameport.c   |   39 ++++++++++++++++++
 drivers/input/joystick/a3d.c        |   44 ++++++++++++++-------
 drivers/input/joystick/adi.c        |   63 ++++++++++++++----------------
 drivers/input/joystick/analog.c     |   52 +++++++++++++++---------
 drivers/input/joystick/cobra.c      |   42 ++++++++++++--------
 drivers/input/joystick/gf2k.c       |   42 +++++++++++++-------
 drivers/input/joystick/grip.c       |   61 +++++++++++++----------------
 drivers/input/joystick/grip_mp.c    |   56 +++++++++++++++++---------
 drivers/input/joystick/guillemot.c  |   53 ++++++++++++++-----------
 drivers/input/joystick/interact.c   |   32 +++++++++++----
 drivers/input/joystick/joydump.c    |   20 ++++++---
 drivers/input/joystick/sidewinder.c |   75 +++++++++++++++++++++++++-----------
 drivers/input/joystick/tmdc.c       |   53 +++++++++++++------------
 include/linux/gameport.h            |    6 +-
 15 files changed, 407 insertions(+), 233 deletions(-)


===================================================================



diff -Nru a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile	2005-02-11 01:40:01 -05:00
+++ b/drivers/Makefile	2005-02-11 01:40:01 -05:00
@@ -47,8 +47,8 @@
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_USB)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
-obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
+obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_W1)		+= w1/
diff -Nru a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
--- a/drivers/input/gameport/gameport.c	2005-02-11 01:40:01 -05:00
+++ b/drivers/input/gameport/gameport.c	2005-02-11 01:40:01 -05:00
@@ -37,6 +37,10 @@
 static LIST_HEAD(gameport_list);
 static LIST_HEAD(gameport_driver_list);
 
+static struct bus_type gameport_bus = {
+	.name =	"gameport",
+};
+
 #ifdef __i386__
 
 #define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193182/HZ:0))
@@ -146,6 +150,21 @@
 	gameport_find_driver(gameport);
 }
 
+/*
+ * Gameport driver operations
+ */
+
+static ssize_t gameport_driver_show_description(struct device_driver *drv, char *buf)
+{
+	struct gameport_driver *driver = to_gameport_driver(drv);
+	return sprintf(buf, "%s\n", driver->description ? driver->description : "(none)");
+}
+
+static struct driver_attribute gameport_driver_attrs[] = {
+	__ATTR(description, S_IRUGO, gameport_driver_show_description, NULL),
+	__ATTR_NULL
+};
+
 void gameport_unregister_port(struct gameport *gameport)
 {
 	list_del_init(&gameport->node);
@@ -159,6 +178,9 @@
 {
 	struct gameport *gameport;
 
+	drv->driver.bus = &gameport_bus;
+	driver_register(&drv->driver);
+
 	list_add_tail(&drv->node, &gameport_driver_list);
 	list_for_each_entry(gameport, &gameport_list, node)
 		if (!gameport->drv)
@@ -175,6 +197,7 @@
 			drv->disconnect(gameport);
 		gameport_find_driver(gameport);
 	}
+	driver_unregister(&drv->driver);
 }
 
 int gameport_open(struct gameport *gameport, struct gameport_driver *drv, int mode)
@@ -201,3 +224,19 @@
 	if (gameport->close)
 		gameport->close(gameport);
 }
+
+static int __init gameport_init(void)
+{
+	gameport_bus.drv_attrs = gameport_driver_attrs;
+	bus_register(&gameport_bus);
+
+	return 0;
+}
+
+static void __exit gameport_exit(void)
+{
+	bus_unregister(&gameport_bus);
+}
+
+module_init(gameport_init);
+module_exit(gameport_exit);
diff -Nru a/drivers/input/joystick/a3d.c b/drivers/input/joystick/a3d.c
--- a/drivers/input/joystick/a3d.c	2005-02-11 01:40:01 -05:00
+++ b/drivers/input/joystick/a3d.c	2005-02-11 01:40:01 -05:00
@@ -35,8 +35,10 @@
 #include <linux/gameport.h>
 #include <linux/input.h>
 
+#define DRIVER_DESC	"FP-Gaming Assasin 3D joystick driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("FP-Gaming Assasin 3D joystick driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 #define A3D_MAX_START		400	/* 400 us */
@@ -108,7 +110,9 @@
 static int a3d_csum(char *data, int count)
 {
 	int i, csum = 0;
-	for (i = 0; i < count - 2; i++) csum += data[i];
+
+	for (i = 0; i < count - 2; i++)
+		csum += data[i];
 	return (csum & 0x3f) != ((data[count - 2] << 3) | data[count - 1]);
 }
 
@@ -138,7 +142,7 @@
 
 			a3d->buttons = ((data[3] << 3) | data[4]) & 0xf;
 
-			return;
+			break;
 
 		case A3D_MODE_PXL:
 
@@ -168,7 +172,7 @@
 
 			input_sync(dev);
 
-			return;
+			break;
 	}
 }
 
@@ -181,6 +185,7 @@
 {
 	struct a3d *a3d = (void *) private;
 	unsigned char data[A3D_MAX_LENGTH];
+
 	a3d->reads++;
 	if (a3d_read_packet(a3d->gameport, a3d->length, data) != a3d->length
 		|| data[0] != a3d->mode || a3d_csum(data, a3d->length))
@@ -198,6 +203,7 @@
 {
 	struct a3d *a3d = gameport->port_data;
 	int i;
+
 	for (i = 0; i < 4; i++)
 		axes[i] = (a3d->axes[i] < 254) ? a3d->axes[i] : -1;
 	*buttons = a3d->buttons;
@@ -226,6 +232,7 @@
 static void a3d_adc_close(struct gameport *gameport)
 {
 	struct a3d *a3d = gameport->port_data;
+
 	if (!--a3d->used)
 		del_timer(&a3d->timer);
 }
@@ -237,6 +244,7 @@
 static int a3d_open(struct input_dev *dev)
 {
 	struct a3d *a3d = dev->private;
+
 	if (!a3d->used++)
 		mod_timer(&a3d->timer, jiffies + A3D_REFRESH_TIME);
 	return 0;
@@ -249,6 +257,7 @@
 static void a3d_close(struct input_dev *dev)
 {
 	struct a3d *a3d = dev->private;
+
 	if (!--a3d->used)
 		del_timer(&a3d->timer);
 }
@@ -257,16 +266,16 @@
  * a3d_connect() probes for A3D joysticks.
  */
 
-static void a3d_connect(struct gameport *gameport, struct gameport_driver *drv)
+static int a3d_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct a3d *a3d;
 	struct gameport *adc;
 	unsigned char data[A3D_MAX_LENGTH];
 	int i;
+	int err;
 
-	if (!(a3d = kmalloc(sizeof(struct a3d), GFP_KERNEL)))
-		return;
-	memset(a3d, 0, sizeof(struct a3d));
+	if (!(a3d = kcalloc(1, sizeof(struct a3d), GFP_KERNEL)))
+		return -ENOMEM;
 
 	gameport->private = a3d;
 
@@ -275,19 +284,23 @@
 	a3d->timer.data = (long) a3d;
 	a3d->timer.function = a3d_timer;
 
-	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
+	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
+	if (err)
 		goto fail1;
 
 	i = a3d_read_packet(gameport, A3D_MAX_LENGTH, data);
 
-	if (!i || a3d_csum(data, i))
+	if (!i || a3d_csum(data, i)) {
+		err = -ENODEV;
 		goto fail2;
+	}
 
 	a3d->mode = data[0];
 
 	if (!a3d->mode || a3d->mode > 5) {
 		printk(KERN_WARNING "a3d.c: Unknown A3D device detected "
 			"(%s, id=%d), contact <vojtech@ucw.cz>\n", gameport->phys, a3d->mode);
+		err = -ENODEV;
 		goto fail2;
 	}
 
@@ -363,10 +376,11 @@
 	input_register_device(&a3d->dev);
 	printk(KERN_INFO "input: %s on %s\n", a3d_names[a3d->mode], a3d->phys);
 
-	return;
+	return 0;
 
 fail2:	gameport_close(gameport);
 fail1:  kfree(a3d);
+	return err;
 }
 
 static void a3d_disconnect(struct gameport *gameport)
@@ -383,8 +397,12 @@
 }
 
 static struct gameport_driver a3d_drv = {
-	.connect =	a3d_connect,
-	.disconnect =	a3d_disconnect,
+	.driver		= {
+		.name	= "adc",
+	},
+	.description	= DRIVER_DESC,
+	.connect	= a3d_connect,
+	.disconnect	= a3d_disconnect,
 };
 
 static int __init a3d_init(void)
diff -Nru a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
--- a/drivers/input/joystick/adi.c	2005-02-11 01:40:01 -05:00
+++ b/drivers/input/joystick/adi.c	2005-02-11 01:40:01 -05:00
@@ -37,8 +37,10 @@
 #include <linux/gameport.h>
 #include <linux/init.h>
 
+#define DRIVER_DESC	"Logitech ADI joystick family driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Logitech ADI joystick family driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 /*
@@ -439,35 +441,23 @@
 {
 	int i, t, x;
 
-	if (!adi->length) return;
+	if (!adi->length)
+		return;
 
 	for (i = 0; i < adi->axes10 + adi->axes8 + (adi->hats + (adi->pad != -1)) * 2; i++) {
 
 		t = adi->abs[i];
 		x = adi->dev.abs[t];
 
-		if (t == ABS_THROTTLE || t == ABS_RUDDER || adi->id == ADI_ID_WGPE) {
-			if (i < adi->axes10) x = 512; else x = 128;
-		}
-
-		if (i < adi->axes10) {
-			adi->dev.absmax[t] = x * 2 - 64;
-			adi->dev.absmin[t] = 64;
-			adi->dev.absfuzz[t] = 2;
-			adi->dev.absflat[t] = 16;
-			continue;
-		}
-
-		if (i < adi->axes10 + adi->axes8) {
-			adi->dev.absmax[t] = x * 2 - 48;
-			adi->dev.absmin[t] = 48;
-			adi->dev.absfuzz[t] = 1;
-			adi->dev.absflat[t] = 16;
-			continue;
-		}
+		if (t == ABS_THROTTLE || t == ABS_RUDDER || adi->id == ADI_ID_WGPE)
+			x = i < adi->axes10 ? 512 : 128;
 
-		adi->dev.absmax[t] = 1;
-		adi->dev.absmin[t] = -1;
+		if (i < adi->axes10)
+			input_set_abs_params(&adi->dev, t, 64, x * 2 - 64, 2, 16);
+		else if (i < adi->axes10 + adi->axes8)
+			input_set_abs_params(&adi->dev, t, 48, x * 2 - 48, 1, 16);
+		else
+			input_set_abs_params(&adi->dev, t, -1, 1, 0, 0);
 	}
 }
 
@@ -475,14 +465,14 @@
  * adi_connect() probes for Logitech ADI joysticks.
  */
 
-static void adi_connect(struct gameport *gameport, struct gameport_driver *drv)
+static int adi_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct adi_port *port;
 	int i;
+	int err;
 
-	if (!(port = kmalloc(sizeof(struct adi_port), GFP_KERNEL)))
-		return;
-	memset(port, 0, sizeof(struct adi_port));
+	if (!(port = kcalloc(1, sizeof(struct adi_port), GFP_KERNEL)))
+		return -ENOMEM;
 
 	gameport->private = port;
 
@@ -491,9 +481,10 @@
 	port->timer.data = (long) port;
 	port->timer.function = adi_timer;
 
-	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW)) {
+	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
+	if (err) {
 		kfree(port);
-		return;
+		return err;
 	}
 
 	adi_init_digital(gameport);
@@ -510,7 +501,7 @@
 	if (!port->adi[0].length && !port->adi[1].length) {
 		gameport_close(gameport);
 		kfree(port);
-		return;
+		return -ENODEV;
 	}
 
 	msleep(ADI_INIT_DELAY);
@@ -526,13 +517,15 @@
 			printk(KERN_INFO "input: %s [%s] on %s\n",
 				port->adi[i].name, port->adi[i].cname, gameport->phys);
 		}
+
+	return 0;
 }
 
 static void adi_disconnect(struct gameport *gameport)
 {
 	int i;
-
 	struct adi_port *port = gameport->private;
+
 	for (i = 0; i < 2; i++)
 		if (port->adi[i].length > 0)
 			input_unregister_device(&port->adi[i].dev);
@@ -545,8 +538,12 @@
  */
 
 static struct gameport_driver adi_drv = {
-	.connect =	adi_connect,
-	.disconnect =	adi_disconnect,
+	.driver		= {
+		.name	= "adi",
+	},
+	.description	= DRIVER_DESC,
+	.connect	= adi_connect,
+	.disconnect	= adi_disconnect,
 };
 
 static int __init adi_init(void)
diff -Nru a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
--- a/drivers/input/joystick/analog.c	2005-02-11 01:40:01 -05:00
+++ b/drivers/input/joystick/analog.c	2005-02-11 01:40:01 -05:00
@@ -40,8 +40,10 @@
 #include <linux/gameport.h>
 #include <asm/timex.h>
 
+#define DRIVER_DESC	"Analog joystick and gamepad driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Analog joystick and gamepad driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 /*
@@ -608,7 +610,8 @@
 		port->fuzz = (port->speed * ANALOG_FUZZ_MAGIC) / port->loop / 1000 + ANALOG_FUZZ_BITS;
 
 		for (i = 0; i < ANALOG_INIT_RETRIES; i++) {
-			if (!analog_cooked_read(port)) break;
+			if (!analog_cooked_read(port))
+				break;
 			msleep(ANALOG_MAX_TIME);
 		}
 
@@ -617,11 +620,13 @@
 		msleep(ANALOG_MAX_TIME);
 		t = gameport_time(gameport, ANALOG_MAX_TIME * 1000);
 		gameport_trigger(gameport);
-		while ((gameport_read(port->gameport) & port->mask) && (u < t)) u++;
+		while ((gameport_read(port->gameport) & port->mask) && (u < t))
+			u++;
 		udelay(ANALOG_SAITEK_DELAY);
 		t = gameport_time(gameport, ANALOG_SAITEK_TIME);
 		gameport_trigger(gameport);
-		while ((gameport_read(port->gameport) & port->mask) && (v < t)) v++;
+		while ((gameport_read(port->gameport) & port->mask) && (v < t))
+			v++;
 
 		if (v < (u >> 1)) { /* FIXME - more than one port */
 			analog_options[0] |= /* FIXME - more than one port */
@@ -638,49 +643,51 @@
 			if (!gameport_cooked_read(gameport, port->axes, &port->buttons))
 				break;
 		for (i = 0; i < 4; i++)
-			if (port->axes[i] != -1) port->mask |= 1 << i;
+			if (port->axes[i] != -1)
+				port->mask |= 1 << i;
 
 		port->fuzz = gameport->fuzz;
 		port->cooked = 1;
 		return 0;
 	}
 
-	if (!gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
-		return 0;
-
-	return -1;
+	return gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
 }
 
-static void analog_connect(struct gameport *gameport, struct gameport_driver *drv)
+static int analog_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct analog_port *port;
 	int i;
+	int err;
 
-	if (!(port = kmalloc(sizeof(struct analog_port), GFP_KERNEL)))
-		return;
-	memset(port, 0, sizeof(struct analog_port));
+	if (!(port = kcalloc(1, sizeof(struct analog_port), GFP_KERNEL)))
+		return - ENOMEM;
 
-	if (analog_init_port(gameport, drv, port)) {
+	err = analog_init_port(gameport, drv, port);
+	if (err) {
 		kfree(port);
-		return;
+		return err;
 	}
 
-	if (analog_init_masks(port)) {
+	err = analog_init_masks(port);
+	if (err) {
 		gameport_close(gameport);
 		kfree(port);
-		return;
+		return err;
 	}
 
 	for (i = 0; i < 2; i++)
 		if (port->analog[i].mask)
 			analog_init_device(port, port->analog + i, i);
+
+	return 0;
 }
 
 static void analog_disconnect(struct gameport *gameport)
 {
 	int i;
-
 	struct analog_port *port = gameport->private;
+
 	for (i = 0; i < 2; i++)
 		if (port->analog[i].mask)
 			input_unregister_device(&port->analog[i].dev);
@@ -742,14 +749,19 @@
  */
 
 static struct gameport_driver analog_drv = {
-	.connect =	analog_connect,
-	.disconnect =	analog_disconnect,
+	.driver		= {
+		.name	= "analog",
+	},
+	.description	= DRIVER_DESC,
+	.connect	= analog_connect,
+	.disconnect	= analog_disconnect,
 };
 
 static int __init analog_init(void)
 {
 	analog_parse_options();
 	gameport_register_driver(&analog_drv);
+
 	return 0;
 }
 
diff -Nru a/drivers/input/joystick/cobra.c b/drivers/input/joystick/cobra.c
--- a/drivers/input/joystick/cobra.c	2005-02-11 01:40:01 -05:00
+++ b/drivers/input/joystick/cobra.c	2005-02-11 01:40:01 -05:00
@@ -35,8 +35,10 @@
 #include <linux/gameport.h>
 #include <linux/input.h>
 
+#define DRIVER_DESC	"Creative Labs Blaster GamePad Cobra driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Creative Labs Blaster GamePad Cobra driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 #define COBRA_MAX_STROBE	45	/* 45 us max wait for first strobe */
@@ -158,15 +160,15 @@
 		del_timer(&cobra->timer);
 }
 
-static void cobra_connect(struct gameport *gameport, struct gameport_driver *drv)
+static int cobra_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct cobra *cobra;
 	unsigned int data[2];
 	int i, j;
+	int err;
 
-	if (!(cobra = kmalloc(sizeof(struct cobra), GFP_KERNEL)))
-		return;
-	memset(cobra, 0, sizeof(struct cobra));
+	if (!(cobra = kcalloc(1, sizeof(struct cobra), GFP_KERNEL)))
+		return -ENOMEM;
 
 	gameport->private = cobra;
 
@@ -175,7 +177,8 @@
 	cobra->timer.data = (long) cobra;
 	cobra->timer.function = cobra_timer;
 
-	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
+	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
+	if (err)
 		goto fail1;
 
 	cobra->exists = cobra_read_packet(gameport, data);
@@ -187,8 +190,10 @@
 			cobra->exists &= ~(1 << i);
 		}
 
-	if (!cobra->exists)
+	if (!cobra->exists) {
+		err = -ENODEV;
 		goto fail2;
+	}
 
 	for (i = 0; i < 2; i++)
 		if ((cobra->exists >> i) & 1) {
@@ -207,28 +212,29 @@
 			cobra->dev[i].id.version = 0x0100;
 
 			cobra->dev[i].evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-			cobra->dev[i].absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
+
+			input_set_abs_params(&cobra->dev[i], ABS_X, -1, 1, 0, 0);
+			input_set_abs_params(&cobra->dev[i], ABS_Y, -1, 1, 0, 0);
 
 			for (j = 0; cobra_btn[j]; j++)
 				set_bit(cobra_btn[j], cobra->dev[i].keybit);
 
-			cobra->dev[i].absmin[ABS_X] = -1; cobra->dev[i].absmax[ABS_X] = 1;
-			cobra->dev[i].absmin[ABS_Y] = -1; cobra->dev[i].absmax[ABS_Y] = 1;
-
-			input_register_device(cobra->dev + i);
+			input_register_device(&cobra->dev[i]);
 			printk(KERN_INFO "input: %s on %s\n", cobra_name, gameport->phys);
 		}
 
-	return;
+	return 0;
+
 fail2:	gameport_close(gameport);
 fail1:	kfree(cobra);
+	return err;
 }
 
 static void cobra_disconnect(struct gameport *gameport)
 {
 	int i;
-
 	struct cobra *cobra = gameport->private;
+
 	for (i = 0; i < 2; i++)
 		if ((cobra->exists >> i) & 1)
 			input_unregister_device(cobra->dev + i);
@@ -237,8 +243,12 @@
 }
 
 static struct gameport_driver cobra_drv = {
-	.connect =	cobra_connect,
-	.disconnect =	cobra_disconnect,
+	.driver		= {
+		.name	= "cobra",
+	},
+	.description	= DRIVER_DESC,
+	.connect	= cobra_connect,
+	.disconnect	= cobra_disconnect,
 };
 
 static int __init cobra_init(void)
diff -Nru a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
--- a/drivers/input/joystick/gf2k.c	2005-02-11 01:40:01 -05:00
+++ b/drivers/input/joystick/gf2k.c	2005-02-11 01:40:01 -05:00
@@ -36,8 +36,10 @@
 #include <linux/input.h>
 #include <linux/gameport.h>
 
+#define DRIVER_DESC	"Genius Flight 2000 joystick driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Genius Flight 2000 joystick driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 #define GF2K_START		400	/* The time we wait for the first bit [400 us] */
@@ -238,15 +240,14 @@
  * gf2k_connect() probes for Genius id joysticks.
  */
 
-static void gf2k_connect(struct gameport *gameport, struct gameport_driver *drv)
+static int gf2k_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct gf2k *gf2k;
 	unsigned char data[GF2K_LENGTH];
-	int i;
+	int i, err;
 
-	if (!(gf2k = kmalloc(sizeof(struct gf2k), GFP_KERNEL)))
-		return;
-	memset(gf2k, 0, sizeof(struct gf2k));
+	if (!(gf2k = kcalloc(1, sizeof(struct gf2k), GFP_KERNEL)))
+		return -ENOMEM;
 
 	gameport->private = gf2k;
 
@@ -255,7 +256,8 @@
 	gf2k->timer.data = (long) gf2k;
 	gf2k->timer.function = gf2k_timer;
 
-	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
+	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
+	if (err)
 		goto fail1;
 
 	gf2k_trigger_seq(gameport, gf2k_seq_reset);
@@ -266,16 +268,22 @@
 
 	msleep(GF2K_TIMEOUT);
 
-	if (gf2k_read_packet(gameport, GF2K_LENGTH, data) < 12)
+	if (gf2k_read_packet(gameport, GF2K_LENGTH, data) < 12) {
+		err = -ENODEV;
 		goto fail2;
+	}
 
-	if (!(gf2k->id = GB(7,2,0) | GB(3,3,2) | GB(0,3,5)))
+	if (!(gf2k->id = GB(7,2,0) | GB(3,3,2) | GB(0,3,5))) {
+		err = -ENODEV;
 		goto fail2;
+	}
 
 #ifdef RESET_WORKS
 	if ((gf2k->id != (GB(19,2,0) | GB(15,3,2) | GB(12,3,5))) ||
-	    (gf2k->id != (GB(31,2,0) | GB(27,3,2) | GB(24,3,5))))
+	    (gf2k->id != (GB(31,2,0) | GB(27,3,2) | GB(24,3,5)))) {
+		err = -ENODEV;
 		goto fail2;
+	}
 #else
 	gf2k->id = 6;
 #endif
@@ -283,6 +291,7 @@
 	if (gf2k->id > GF2K_ID_MAX || !gf2k_axes[gf2k->id]) {
 		printk(KERN_WARNING "gf2k.c: Not yet supported joystick on %s. [id: %d type:%s]\n",
 			gameport->phys, gf2k->id, gf2k->id > GF2K_ID_MAX ? "Unknown" : gf2k_names[gf2k->id]);
+		err = -ENODEV;
 		goto fail2;
 	}
 
@@ -333,22 +342,29 @@
 	input_register_device(&gf2k->dev);
 	printk(KERN_INFO "input: %s on %s\n", gf2k_names[gf2k->id], gameport->phys);
 
-	return;
+	return 0;
+
 fail2:	gameport_close(gameport);
 fail1:	kfree(gf2k);
+	return err;
 }
 
 static void gf2k_disconnect(struct gameport *gameport)
 {
 	struct gf2k *gf2k = gameport->private;
+
 	input_unregister_device(&gf2k->dev);
 	gameport_close(gameport);
 	kfree(gf2k);
 }
 
 static struct gameport_driver gf2k_drv = {
-	.connect =	gf2k_connect,
-	.disconnect =	gf2k_disconnect,
+	.driver		= {
+		.name	= "gf2k",
+	},
+	.description	= DRIVER_DESC,
+	.connect	= gf2k_connect,
+	.disconnect	= gf2k_disconnect,
 };
 
 static int __init gf2k_init(void)
diff -Nru a/drivers/input/joystick/grip.c b/drivers/input/joystick/grip.c
--- a/drivers/input/joystick/grip.c	2005-02-11 01:40:01 -05:00
+++ b/drivers/input/joystick/grip.c	2005-02-11 01:40:01 -05:00
@@ -35,8 +35,10 @@
 #include <linux/gameport.h>
 #include <linux/input.h>
 
+#define DRIVER_DESC	"Gravis GrIP protocol joystick driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Gravis GrIP protocol joystick driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 #define GRIP_MODE_GPP		1
@@ -298,15 +300,15 @@
 		del_timer(&grip->timer);
 }
 
-static void grip_connect(struct gameport *gameport, struct gameport_driver *drv)
+static int grip_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct grip *grip;
 	unsigned int data[GRIP_LENGTH_XT];
 	int i, j, t;
+	int err;
 
-	if (!(grip = kmalloc(sizeof(struct grip), GFP_KERNEL)))
-		return;
-	memset(grip, 0, sizeof(struct grip));
+	if (!(grip = kcalloc(1, sizeof(struct grip), GFP_KERNEL)))
+		return -ENOMEM;
 
 	gameport->private = grip;
 
@@ -315,7 +317,8 @@
 	grip->timer.data = (long) grip;
 	grip->timer.function = grip_timer;
 
-	 if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
+	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
+	if (err)
 		goto fail1;
 
 	for (i = 0; i < 2; i++) {
@@ -337,8 +340,10 @@
 		}
 	}
 
-	if (!grip->mode[0] && !grip->mode[1])
+	if (!grip->mode[0] && !grip->mode[1]) {
+		err = -ENODEV;
 		goto fail2;
+	}
 
 	for (i = 0; i < 2; i++)
 		if (grip->mode[i]) {
@@ -361,47 +366,35 @@
 
 			for (j = 0; (t = grip_abs[grip->mode[i]][j]) >= 0; j++) {
 
-				set_bit(t, grip->dev[i].absbit);
-
-				if (j < grip_cen[grip->mode[i]]) {
-					grip->dev[i].absmin[t] = 14;
-					grip->dev[i].absmax[t] = 52;
-					grip->dev[i].absfuzz[t] = 1;
-					grip->dev[i].absflat[t] = 2;
-					continue;
-				}
-
-				if (j < grip_anx[grip->mode[i]]) {
-					grip->dev[i].absmin[t] = 3;
-					grip->dev[i].absmax[t] = 57;
-					grip->dev[i].absfuzz[t] = 1;
-					continue;
-				}
-
-				grip->dev[i].absmin[t] = -1;
-				grip->dev[i].absmax[t] = 1;
+				if (j < grip_cen[grip->mode[i]])
+					input_set_abs_params(&grip->dev[i], t, 14, 52, 1, 2);
+				else if (j < grip_anx[grip->mode[i]])
+					input_set_abs_params(&grip->dev[i], t, 3, 57, 1, 0);
+				else
+					input_set_abs_params(&grip->dev[i], t, -1, 1, 0, 0);
 			}
 
 			for (j = 0; (t = grip_btn[grip->mode[i]][j]) >= 0; j++)
 				if (t > 0)
 					set_bit(t, grip->dev[i].keybit);
 
-			input_register_device(grip->dev + i);
-
 			printk(KERN_INFO "input: %s on %s\n",
 				grip_name[grip->mode[i]], gameport->phys);
+			input_register_device(grip->dev + i);
 		}
 
-	return;
+	return 0;
+
 fail2:	gameport_close(gameport);
 fail1:	kfree(grip);
+	return err;
 }
 
 static void grip_disconnect(struct gameport *gameport)
 {
+	struct grip *grip = gameport->private;
 	int i;
 
-	struct grip *grip = gameport->private;
 	for (i = 0; i < 2; i++)
 		if (grip->mode[i])
 			input_unregister_device(grip->dev + i);
@@ -410,8 +403,12 @@
 }
 
 static struct gameport_driver grip_drv = {
-	.connect =	grip_connect,
-	.disconnect =	grip_disconnect,
+	.driver		= {
+		.name	= "grip",
+	},
+	.description	= DRIVER_DESC,
+	.connect	= grip_connect,
+	.disconnect	= grip_disconnect,
 };
 
 static int __init grip_init(void)
diff -Nru a/drivers/input/joystick/grip_mp.c b/drivers/input/joystick/grip_mp.c
--- a/drivers/input/joystick/grip_mp.c	2005-02-11 01:40:01 -05:00
+++ b/drivers/input/joystick/grip_mp.c	2005-02-11 01:40:01 -05:00
@@ -20,8 +20,10 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 
+#define DRIVER_DESC	"Gravis Grip Multiport driver"
+
 MODULE_AUTHOR("Brian Bonnlander");
-MODULE_DESCRIPTION("Gravis Grip Multiport driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 #ifdef GRIP_DEBUG
@@ -477,9 +479,9 @@
 	}
 
 	if (dig_mode)
-		dbg("multiport_init(): digital mode achieved.\n");
+		dbg("multiport_init(): digital mode activated.\n");
 	else {
-		dbg("multiport_init(): unable to achieve digital mode.\n");
+		dbg("multiport_init(): unable to activate digital mode.\n");
 		return 0;
 	}
 
@@ -551,6 +553,7 @@
 static int grip_open(struct input_dev *dev)
 {
 	struct grip_mp *grip = dev->private;
+
 	if (!grip->used++)
 		mod_timer(&grip->timer, jiffies + GRIP_REFRESH_TIME);
 	return 0;
@@ -563,6 +566,7 @@
 static void grip_close(struct input_dev *dev)
 {
 	struct grip_mp *grip = dev->private;
+
 	if (!--grip->used)
 		del_timer(&grip->timer);
 }
@@ -585,11 +589,8 @@
 	grip->dev[slot].id.version = 0x0100;
 	grip->dev[slot].evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
-	for (j = 0; (t = grip_abs[grip->mode[slot]][j]) >= 0; j++) {
-		set_bit(t, grip->dev[slot].absbit);
-		grip->dev[slot].absmin[t] = -1;
-		grip->dev[slot].absmax[t] = 1;
-	}
+	for (j = 0; (t = grip_abs[grip->mode[slot]][j]) >= 0; j++)
+		input_set_abs_params(&grip->dev[slot], t, -1, 1, 0, 0);
 
 	for (j = 0; (t = grip_btn[grip->mode[slot]][j]) >= 0; j++)
 		if (t > 0)
@@ -612,41 +613,52 @@
 static void grip_timer(unsigned long private)
 {
 	struct grip_mp *grip = (void*) private;
+
 	get_and_report_mp_state(grip);
 	mod_timer(&grip->timer, jiffies + GRIP_REFRESH_TIME);
 }
 
-static void grip_connect(struct gameport *gameport, struct gameport_driver *drv)
+static int grip_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct grip_mp *grip;
+	int err;
+
+	if (!(grip = kcalloc(1, sizeof(struct grip_mp), GFP_KERNEL)))
+		return -ENOMEM;
 
-	if (!(grip = kmalloc(sizeof(struct grip_mp), GFP_KERNEL)))
-		return;
-	memset(grip, 0, sizeof(struct grip_mp));
 	gameport->private = grip;
 	grip->gameport = gameport;
 	init_timer(&grip->timer);
 	grip->timer.data = (long) grip;
 	grip->timer.function = grip_timer;
 
-	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
+	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
+	if (err)
 		goto fail1;
-	if (!multiport_init(grip))
+
+	if (!multiport_init(grip)) {
+		err = -ENODEV;
 		goto fail2;
-	if (!grip->mode[0] && !grip->mode[1] &&   /* nothing plugged in */
-	    !grip->mode[2] && !grip->mode[3])
+	}
+
+	if (!grip->mode[0] && !grip->mode[1] && !grip->mode[2] && !grip->mode[3]) {
+		/* nothing plugged in */
+		err = -ENODEV;
 		goto fail2;
-	return;
+	}
+
+	return 0;
 
 fail2:	gameport_close(gameport);
 fail1:	kfree(grip);
+	return err;
 }
 
 static void grip_disconnect(struct gameport *gameport)
 {
 	int i;
-
 	struct grip_mp *grip = gameport->private;
+
 	for (i = 0; i < 4; i++)
 		if (grip->registered[i])
 			input_unregister_device(grip->dev + i);
@@ -655,17 +667,21 @@
 }
 
 static struct gameport_driver grip_drv = {
+	.driver		= {
+		.name	= "grip_mp",
+	},
+	.description	= DRIVER_DESC,
 	.connect	= grip_connect,
 	.disconnect	= grip_disconnect,
 };
 
-static int grip_init(void)
+static int __init grip_init(void)
 {
 	gameport_register_driver(&grip_drv);
 	return 0;
 }
 
-static void grip_exit(void)
+static void __exit grip_exit(void)
 {
 	gameport_unregister_driver(&grip_drv);
 }
diff -Nru a/drivers/input/joystick/guillemot.c b/drivers/input/joystick/guillemot.c
--- a/drivers/input/joystick/guillemot.c	2005-02-11 01:40:01 -05:00
+++ b/drivers/input/joystick/guillemot.c	2005-02-11 01:40:01 -05:00
@@ -36,8 +36,10 @@
 #include <linux/gameport.h>
 #include <linux/input.h>
 
+#define DRIVER_DESC	"Guillemot Digital joystick driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Guillemot Digital joystick driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 #define GUILLEMOT_MAX_START	600	/* 600 us */
@@ -159,6 +161,7 @@
 static int guillemot_open(struct input_dev *dev)
 {
 	struct guillemot *guillemot = dev->private;
+
 	if (!guillemot->used++)
 		mod_timer(&guillemot->timer, jiffies + GUILLEMOT_REFRESH_TIME);
 	return 0;
@@ -171,6 +174,7 @@
 static void guillemot_close(struct input_dev *dev)
 {
 	struct guillemot *guillemot = dev->private;
+
 	if (!--guillemot->used)
 		del_timer(&guillemot->timer);
 }
@@ -179,15 +183,15 @@
  * guillemot_connect() probes for Guillemot joysticks.
  */
 
-static void guillemot_connect(struct gameport *gameport, struct gameport_driver *drv)
+static int guillemot_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct guillemot *guillemot;
 	u8 data[GUILLEMOT_MAX_LENGTH];
 	int i, t;
+	int err;
 
-	if (!(guillemot = kmalloc(sizeof(struct guillemot), GFP_KERNEL)))
-		return;
-	memset(guillemot, 0, sizeof(struct guillemot));
+	if (!(guillemot = kcalloc(1, sizeof(struct guillemot), GFP_KERNEL)))
+		return -ENOMEM;
 
 	gameport->private = guillemot;
 
@@ -196,13 +200,16 @@
 	guillemot->timer.data = (long) guillemot;
 	guillemot->timer.function = guillemot_timer;
 
-	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
+	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
+	if (err)
 		goto fail1;
 
 	i = guillemot_read_packet(gameport, data);
 
-	if (i != GUILLEMOT_MAX_LENGTH * 8 || data[0] != 0x55 || data[16] != 0xaa)
+	if (i != GUILLEMOT_MAX_LENGTH * 8 || data[0] != 0x55 || data[16] != 0xaa) {
+		err = -ENODEV;
 		goto fail2;
+	}
 
 	for (i = 0; guillemot_type[i].name; i++)
 		if (guillemot_type[i].id == data[11])
@@ -211,6 +218,7 @@
 	if (!guillemot_type[i].name) {
 		printk(KERN_WARNING "guillemot.c: Unknown joystick on %s. [ %02x%02x:%04x, ver %d.%02d ]\n",
 			gameport->phys, data[12], data[13], data[11], data[14], data[15]);
+		err = -ENODEV;
 		goto fail2;
 	}
 
@@ -231,19 +239,13 @@
 
 	guillemot->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
-	for (i = 0; (t = guillemot->type->abs[i]) >= 0; i++) {
-		set_bit(t, guillemot->dev.absbit);
-		guillemot->dev.absmin[t] = 0;
-		guillemot->dev.absmax[t] = 255;
-	}
+	for (i = 0; (t = guillemot->type->abs[i]) >= 0; i++)
+		input_set_abs_params(&guillemot->dev, t, 0, 255, 0, 0);
 
-	if (guillemot->type->hat)
-		for (i = 0; i < 2; i++) {
-			t = ABS_HAT0X + i;
-			set_bit(t, guillemot->dev.absbit);
-			guillemot->dev.absmin[t] = -1;
-			guillemot->dev.absmax[t] = 1;
-		}
+	if (guillemot->type->hat) {
+		input_set_abs_params(&guillemot->dev, ABS_HAT0X, -1, 1, 0, 0);
+		input_set_abs_params(&guillemot->dev, ABS_HAT0Y, -1, 1, 0, 0);
+	}
 
 	for (i = 0; (t = guillemot->type->btn[i]) >= 0; i++)
 		set_bit(t, guillemot->dev.keybit);
@@ -252,14 +254,17 @@
 	printk(KERN_INFO "input: %s ver %d.%02d on %s\n",
 		guillemot->type->name, data[14], data[15], gameport->phys);
 
-	return;
+	return 0;
+
 fail2:	gameport_close(gameport);
 fail1:  kfree(guillemot);
+	return err;
 }
 
 static void guillemot_disconnect(struct gameport *gameport)
 {
 	struct guillemot *guillemot = gameport->private;
+
 	printk(KERN_INFO "guillemot.c: Failed %d reads out of %d on %s\n", guillemot->reads, guillemot->bads, guillemot->phys);
 	input_unregister_device(&guillemot->dev);
 	gameport_close(gameport);
@@ -267,8 +272,12 @@
 }
 
 static struct gameport_driver guillemot_drv = {
-	.connect =	guillemot_connect,
-	.disconnect =	guillemot_disconnect,
+	.driver		= {
+		.name	= "guillemot",
+	},
+	.description	= DRIVER_DESC,
+	.connect	= guillemot_connect,
+	.disconnect	= guillemot_disconnect,
 };
 
 static int __init guillemot_init(void)
diff -Nru a/drivers/input/joystick/interact.c b/drivers/input/joystick/interact.c
--- a/drivers/input/joystick/interact.c	2005-02-11 01:40:01 -05:00
+++ b/drivers/input/joystick/interact.c	2005-02-11 01:40:01 -05:00
@@ -39,8 +39,10 @@
 #include <linux/gameport.h>
 #include <linux/input.h>
 
+#define DRIVER_DESC	"InterAct digital joystick driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("InterAct digital joystick driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 #define INTERACT_MAX_START	400	/* 400 us */
@@ -189,6 +191,7 @@
 static int interact_open(struct input_dev *dev)
 {
 	struct interact *interact = dev->private;
+
 	if (!interact->used++)
 		mod_timer(&interact->timer, jiffies + INTERACT_REFRESH_TIME);
 	return 0;
@@ -201,6 +204,7 @@
 static void interact_close(struct input_dev *dev)
 {
 	struct interact *interact = dev->private;
+
 	if (!--interact->used)
 		del_timer(&interact->timer);
 }
@@ -209,15 +213,15 @@
  * interact_connect() probes for InterAct joysticks.
  */
 
-static void interact_connect(struct gameport *gameport, struct gameport_driver *drv)
+static int interact_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct interact *interact;
 	__u32 data[3];
 	int i, t;
+	int err;
 
-	if (!(interact = kmalloc(sizeof(struct interact), GFP_KERNEL)))
-		return;
-	memset(interact, 0, sizeof(struct interact));
+	if (!(interact = kcalloc(1, sizeof(struct interact), GFP_KERNEL)))
+		return -ENOMEM;
 
 	gameport->private = interact;
 
@@ -226,12 +230,14 @@
 	interact->timer.data = (long) interact;
 	interact->timer.function = interact_timer;
 
-	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
+	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
+	if (err)
 		goto fail1;
 
 	i = interact_read_packet(gameport, INTERACT_MAX_LENGTH * 2, data);
 
 	if (i != 32 || (data[0] >> 24) != 0x0c || (data[1] >> 24) != 0x02) {
+		err = -ENODEV;
 		goto fail2;
 	}
 
@@ -242,6 +248,7 @@
 	if (!interact_type[i].length) {
 		printk(KERN_WARNING "interact.c: Unknown joystick on %s. [len %d d0 %08x d1 %08x i2 %08x]\n",
 			gameport->phys, i, data[0], data[1], data[2]);
+		err = -ENODEV;
 		goto fail2;
 	}
 
@@ -281,22 +288,29 @@
 	printk(KERN_INFO "input: %s on %s\n",
 		interact_type[interact->type].name, gameport->phys);
 
-	return;
+	return 0;
+
 fail2:	gameport_close(gameport);
 fail1:  kfree(interact);
+	return err;
 }
 
 static void interact_disconnect(struct gameport *gameport)
 {
 	struct interact *interact = gameport->private;
+
 	input_unregister_device(&interact->dev);
 	gameport_close(gameport);
 	kfree(interact);
 }
 
 static struct gameport_driver interact_drv = {
-	.connect =	interact_connect,
-	.disconnect =	interact_disconnect,
+	.driver		= {
+		.name	= "interact",
+	},
+	.description	= DRIVER_DESC,
+	.connect	= interact_connect,
+	.disconnect	= interact_disconnect,
 };
 
 static int __init interact_init(void)
diff -Nru a/drivers/input/joystick/joydump.c b/drivers/input/joystick/joydump.c
--- a/drivers/input/joystick/joydump.c	2005-02-11 01:40:01 -05:00
+++ b/drivers/input/joystick/joydump.c	2005-02-11 01:40:01 -05:00
@@ -35,8 +35,10 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 
+#define DRIVER_DESC	"Gameport data dumper module"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Gameport data dumper module");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 #define BUF_SIZE 256
@@ -46,7 +48,7 @@
 	unsigned char data;
 };
 
-static void __devinit joydump_connect(struct gameport *gameport, struct gameport_driver *drv)
+static int joydump_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct joydump *buf;	/* all entries */
 	struct joydump *dump, *prev;	/* one entry each */
@@ -67,7 +69,7 @@
 
 			printk(KERN_INFO "joydump: | Cooked not available either. Failing.      |\n");
 			printk(KERN_INFO "joydump: `-------------------- END -------------------'\n");
-			return;
+			return -ENODEV;
 		}
 
 		gameport_cooked_read(gameport, axes, &buttons);
@@ -140,16 +142,22 @@
 
 jd_end:
 	printk(KERN_INFO "joydump: `-------------------- END -------------------'\n");
+
+	return 0;
 }
 
-static void __devexit joydump_disconnect(struct gameport *gameport)
+static void joydump_disconnect(struct gameport *gameport)
 {
 	gameport_close(gameport);
 }
 
 static struct gameport_driver joydump_drv = {
-	.connect =	joydump_connect,
-	.disconnect =	joydump_disconnect,
+	.driver		= {
+		.name	= "joydump",
+	},
+	.description	= DRIVER_DESC,
+	.connect	= joydump_connect,
+	.disconnect	= joydump_disconnect,
 };
 
 static int __init joydump_init(void)
diff -Nru a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
--- a/drivers/input/joystick/sidewinder.c	2005-02-11 01:40:01 -05:00
+++ b/drivers/input/joystick/sidewinder.c	2005-02-11 01:40:01 -05:00
@@ -36,8 +36,10 @@
 #include <linux/input.h>
 #include <linux/gameport.h>
 
+#define DRIVER_DESC	"Microsoft SideWinder joystick family driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Microsoft SideWinder joystick family driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 /*
@@ -160,7 +162,8 @@
 		v = gameport_read(gameport);
 	} while (!(~v & u & 0x10) && (bitout > 0));		/* Wait for first falling edge on clock */
 
-	if (bitout > 0) bitout = strobe;			/* Extend time if not timed out */
+	if (bitout > 0)
+		bitout = strobe;				/* Extend time if not timed out */
 
 	while ((timeout > 0 || bitout > 0) && (i < length)) {
 
@@ -266,6 +269,7 @@
 static int sw_parity(__u64 t)
 {
 	int x = t ^ (t >> 32);
+
 	x ^= x >> 16;
 	x ^= x >> 8;
 	x ^= x >> 4;
@@ -307,7 +311,8 @@
 
 		case SW_ID_3DP:
 
-			if (sw_check(GB(0,64)) || (hat = (GB(6,1) << 3) | GB(60,3)) > 8) return -1;
+			if (sw_check(GB(0,64)) || (hat = (GB(6,1) << 3) | GB(60,3)) > 8)
+				return -1;
 
 			input_report_abs(dev, ABS_X,        (GB( 3,3) << 7) | GB(16,7));
 			input_report_abs(dev, ABS_Y,        (GB( 0,3) << 7) | GB(24,7));
@@ -331,7 +336,8 @@
 
 			for (i = 0; i < sw->number; i ++) {
 
-				if (sw_parity(GB(i*15,15))) return -1;
+				if (sw_parity(GB(i*15,15)))
+					return -1;
 
 				input_report_abs(dev + i, ABS_X, GB(i*15+3,1) - GB(i*15+2,1));
 				input_report_abs(dev + i, ABS_Y, GB(i*15+0,1) - GB(i*15+1,1));
@@ -347,7 +353,8 @@
 		case SW_ID_PP:
 		case SW_ID_FFP:
 
-			if (!sw_parity(GB(0,48)) || (hat = GB(42,4)) > 8) return -1;
+			if (!sw_parity(GB(0,48)) || (hat = GB(42,4)) > 8)
+				return -1;
 
 			input_report_abs(dev, ABS_X,        GB( 9,10));
 			input_report_abs(dev, ABS_Y,        GB(19,10));
@@ -366,7 +373,8 @@
 
 		case SW_ID_FSP:
 
-			if (!sw_parity(GB(0,43)) || (hat = GB(28,4)) > 8) return -1;
+			if (!sw_parity(GB(0,43)) || (hat = GB(28,4)) > 8)
+				return -1;
 
 			input_report_abs(dev, ABS_X,        GB( 0,10));
 			input_report_abs(dev, ABS_Y,        GB(16,10));
@@ -389,7 +397,8 @@
 
 		case SW_ID_FFW:
 
-			if (!sw_parity(GB(0,33))) return -1;
+			if (!sw_parity(GB(0,33)))
+				return -1;
 
 			input_report_abs(dev, ABS_RX,       GB( 0,10));
 			input_report_abs(dev, ABS_RUDDER,   GB(10, 6));
@@ -466,7 +475,8 @@
 		sw->length = 66;
 	}
 
-	if (sw->fail < SW_FAIL) return -1;					/* Not enough, don't reinitialize yet */
+	if (sw->fail < SW_FAIL)
+		return -1;							/* Not enough, don't reinitialize yet */
 
 	printk(KERN_WARNING "sidewinder.c: Too many bit errors on %s"
 		" - reinitializing joystick.\n", sw->gameport->phys);
@@ -491,13 +501,15 @@
 	struct sw *sw = (void *) private;
 
 	sw->reads++;
-	if (sw_read(sw)) sw->bads++;
+	if (sw_read(sw))
+		sw->bads++;
 	mod_timer(&sw->timer, jiffies + SW_REFRESH);
 }
 
 static int sw_open(struct input_dev *dev)
 {
 	struct sw *sw = dev->private;
+
 	if (!sw->used++)
 		mod_timer(&sw->timer, jiffies + SW_REFRESH);
 	return 0;
@@ -506,6 +518,7 @@
 static void sw_close(struct input_dev *dev)
 {
 	struct sw *sw = dev->private;
+
 	if (!--sw->used)
 		del_timer(&sw->timer);
 }
@@ -561,7 +574,10 @@
 {
 	int i;
 	unsigned char xor = 0;
-	for (i = 1; i < len; i++) xor |= (buf[i - 1] ^ buf[i]) & 6;
+
+	for (i = 1; i < len; i++)
+		xor |= (buf[i - 1] ^ buf[i]) & 6;
+
 	return !!xor * 2 + 1;
 }
 
@@ -569,10 +585,11 @@
  * sw_connect() probes for SideWinder type joysticks.
  */
 
-static void sw_connect(struct gameport *gameport, struct gameport_driver *drv)
+static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct sw *sw;
 	int i, j, k, l;
+	int err;
 	unsigned char *buf = NULL;	/* [SW_LENGTH] */
 	unsigned char *idbuf = NULL;	/* [SW_LENGTH] */
 	unsigned char m = 1;
@@ -580,13 +597,13 @@
 
 	comment[0] = 0;
 
-	if (!(sw = kmalloc(sizeof(struct sw), GFP_KERNEL))) return;
-	memset(sw, 0, sizeof(struct sw));
-
+	sw = kcalloc(1, sizeof(struct sw), GFP_KERNEL);
 	buf = kmalloc(SW_LENGTH, GFP_KERNEL);
 	idbuf = kmalloc(SW_LENGTH, GFP_KERNEL);
-	if (!buf || !idbuf)
+	if (!sw || !buf || !idbuf) {
+		err = -ENOMEM;
 		goto fail1;
+	}
 
 	gameport->private = sw;
 
@@ -595,7 +612,8 @@
 	sw->timer.data = (long) sw;
 	sw->timer.function = sw_timer;
 
-	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
+	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
+	if (err)
 		goto fail1;
 
 	dbg("Init 0: Opened %s, io %#x, speed %d",
@@ -611,7 +629,10 @@
 		i = sw_read_packet(gameport, buf, SW_LENGTH, 0);	/* Retry reading packet */
 		udelay(SW_TIMEOUT);
 		dbg("Init 1b: Length %d.", i);
-		if (!i) goto fail2;					/* No data -> FAIL */
+		if (!i) {						/* No data -> FAIL */
+			err = -ENODEV;
+			goto fail2;
+		}
 	}
 
 	j = sw_read_packet(gameport, idbuf, SW_LENGTH, i);		/* Read ID. This initializes the stick */
@@ -622,7 +643,10 @@
 		udelay(SW_TIMEOUT);
 		i = sw_read_packet(gameport, buf, SW_LENGTH, 0);	/* Retry reading packet */
 		dbg("Init 2b: Mode %d. Length %d.", m, i);
-		if (!i) goto fail2;
+		if (!i) {
+			err = -ENODEV;
+			goto fail2;
+		}
 		udelay(SW_TIMEOUT);
 		j = sw_read_packet(gameport, idbuf, SW_LENGTH, i);	/* Retry reading ID */
 		dbg("Init 2c: ID Length %d.", j);
@@ -686,13 +710,14 @@
 			}
 		}
 
-	} while (k && (sw->type == -1));
+	} while (k && sw->type == -1);
 
 	if (sw->type == -1) {
 		printk(KERN_WARNING "sidewinder.c: unknown joystick device detected "
 			"on %s, contact <vojtech@ucw.cz>\n", gameport->phys);
 		sw_print_packet("ID", j * 3, idbuf, 3);
 		sw_print_packet("Data", i * m, buf, m);
+		err = -ENODEV;
 		goto fail2;
 	}
 
@@ -742,11 +767,13 @@
 			sw->name, comment, gameport->phys, m, l, k);
 	}
 
-	return;
+	return 0;
+
 fail2:	gameport_close(gameport);
 fail1:	kfree(sw);
 	kfree(buf);
 	kfree(idbuf);
+	return err;
 }
 
 static void sw_disconnect(struct gameport *gameport)
@@ -761,8 +788,12 @@
 }
 
 static struct gameport_driver sw_drv = {
-	.connect =	sw_connect,
-	.disconnect =	sw_disconnect,
+	.driver		= {
+		.name	= "sidewinder",
+	},
+	.description	= DRIVER_DESC,
+	.connect	= sw_connect,
+	.disconnect	= sw_disconnect,
 };
 
 static int __init sw_init(void)
diff -Nru a/drivers/input/joystick/tmdc.c b/drivers/input/joystick/tmdc.c
--- a/drivers/input/joystick/tmdc.c	2005-02-11 01:40:01 -05:00
+++ b/drivers/input/joystick/tmdc.c	2005-02-11 01:40:01 -05:00
@@ -39,8 +39,10 @@
 #include <linux/gameport.h>
 #include <linux/input.h>
 
+#define DRIVER_DESC	"ThrustMaster DirectConnect joystick driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("ThrustMaster DirectConnect joystick driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 #define TMDC_MAX_START		400	/* 400 us */
@@ -242,9 +244,9 @@
  * tmdc_probe() probes for ThrustMaster type joysticks.
  */
 
-static void tmdc_connect(struct gameport *gameport, struct gameport_driver *drv)
+static int tmdc_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
-	struct models {
+	static struct models {
 		unsigned char id;
 		char *name;
 		char abs;
@@ -263,10 +265,10 @@
 	unsigned char data[2][TMDC_MAX_LENGTH];
 	struct tmdc *tmdc;
 	int i, j, k, l, m;
+	int err;
 
-	if (!(tmdc = kmalloc(sizeof(struct tmdc), GFP_KERNEL)))
-		return;
-	memset(tmdc, 0, sizeof(struct tmdc));
+	if (!(tmdc = kcalloc(1, sizeof(struct tmdc), GFP_KERNEL)))
+		return -ENOMEM;
 
 	gameport->private = tmdc;
 
@@ -275,11 +277,14 @@
 	tmdc->timer.data = (long) tmdc;
 	tmdc->timer.function = tmdc_timer;
 
-	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW))
+	err = gameport_open(gameport, drv, GAMEPORT_MODE_RAW);
+	if (err)
 		goto fail1;
 
-	if (!(tmdc->exists = tmdc_read_packet(gameport, data)))
+	if (!(tmdc->exists = tmdc_read_packet(gameport, data))) {
+		err = -ENODEV;
 		goto fail2;
+	}
 
 	for (j = 0; j < 2; j++)
 		if (tmdc->exists & (1 << j)) {
@@ -321,20 +326,13 @@
 
 			tmdc->dev[j].evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
-			for (i = 0; i < models[m].abs && i < TMDC_ABS; i++) {
-				if (tmdc->abs[j][i] < 0) continue;
-				set_bit(tmdc->abs[j][i], tmdc->dev[j].absbit);
-				tmdc->dev[j].absmin[tmdc->abs[j][i]] = 8;
-				tmdc->dev[j].absmax[tmdc->abs[j][i]] = 248;
-				tmdc->dev[j].absfuzz[tmdc->abs[j][i]] = 2;
-				tmdc->dev[j].absflat[tmdc->abs[j][i]] = 4;
-			}
+			for (i = 0; i < models[m].abs && i < TMDC_ABS; i++)
+				if (tmdc->abs[j][i] >= 0)
+					input_set_abs_params(&tmdc->dev[j], tmdc->abs[j][i], 8, 248, 2, 4);
+
+			for (i = 0; i < models[m].hats && i < TMDC_ABS_HAT; i++)
+				input_set_abs_params(&tmdc->dev[j], tmdc_abs_hat[i], -1, 1, 0, 0);
 
-			for (i = 0; i < models[m].hats && i < TMDC_ABS_HAT; i++) {
-				set_bit(tmdc_abs_hat[i], tmdc->dev[j].absbit);
-				tmdc->dev[j].absmin[tmdc_abs_hat[i]] = -1;
-				tmdc->dev[j].absmax[tmdc_abs_hat[i]] = 1;
-			}
 
 			for (k = l = 0; k < 4; k++) {
 				for (i = 0; i < models[m].btnc[k] && i < TMDC_BTN; i++)
@@ -346,15 +344,18 @@
 			printk(KERN_INFO "input: %s on %s\n", tmdc->name[j], gameport->phys);
 		}
 
-	return;
+	return 0;
+
 fail2:	gameport_close(gameport);
 fail1:	kfree(tmdc);
+	return err;
 }
 
 static void tmdc_disconnect(struct gameport *gameport)
 {
 	struct tmdc *tmdc = gameport->private;
 	int i;
+
 	for (i = 0; i < 2; i++)
 		if (tmdc->exists & (1 << i))
 			input_unregister_device(tmdc->dev + i);
@@ -363,8 +364,12 @@
 }
 
 static struct gameport_driver tmdc_drv = {
-	.connect =	tmdc_connect,
-	.disconnect =	tmdc_disconnect,
+	.driver		= {
+		.name	= "tmdc",
+	},
+	.description	= DRIVER_DESC,
+	.connect	= tmdc_connect,
+	.disconnect	= tmdc_disconnect,
 };
 
 static int __init tmdc_init(void)
diff -Nru a/include/linux/gameport.h b/include/linux/gameport.h
--- a/include/linux/gameport.h	2005-02-11 01:40:01 -05:00
+++ b/include/linux/gameport.h	2005-02-11 01:40:01 -05:00
@@ -45,13 +45,15 @@
 struct gameport_driver {
 
 	void *private;
-	char *name;
+	char *description;
 
-	void (*connect)(struct gameport *, struct gameport_driver *drv);
+	int (*connect)(struct gameport *, struct gameport_driver *drv);
 	void (*disconnect)(struct gameport *);
 
+	struct device_driver driver;
 	struct list_head node;
 };
+#define to_gameport_driver(d)	container_of(d, struct gameport_driver, driver)
 
 int gameport_open(struct gameport *gameport, struct gameport_driver *drv, int mode);
 void gameport_close(struct gameport *gameport);
