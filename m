Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264734AbUF1F1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbUF1F1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbUF1F1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:27:42 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:59256 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264677AbUF1FPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:15:42 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 7/19] serio sysfs intergration
Date: Mon, 28 Jun 2004 00:15:35 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net> <200406280013.58543.dtor_core@ameritech.net> <200406280014.48692.dtor_core@ameritech.net>
In-Reply-To: <200406280014.48692.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280015.38752.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1781, 2004-06-27 15:55:37-05:00, dtor_core@ameritech.net
  Input: serio sysfs integration
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/Makefile                             |    2 
 drivers/input/joystick/iforce/iforce-serio.c |   12 ++-
 drivers/input/joystick/magellan.c            |   14 ++--
 drivers/input/joystick/spaceball.c           |   14 ++--
 drivers/input/joystick/spaceorb.c            |   14 ++--
 drivers/input/joystick/stinger.c             |   14 ++--
 drivers/input/joystick/twidjoy.c             |   10 ++
 drivers/input/joystick/warrior.c             |   14 ++--
 drivers/input/keyboard/atkbd.c               |   18 +++--
 drivers/input/keyboard/lkkbd.c               |   14 ++--
 drivers/input/keyboard/newtonkbd.c           |   14 ++--
 drivers/input/keyboard/sunkbd.c              |   14 ++--
 drivers/input/keyboard/xtkbd.c               |   14 ++--
 drivers/input/mouse/psmouse-base.c           |   18 +++--
 drivers/input/mouse/sermouse.c               |   14 ++--
 drivers/input/mouse/vsxxxaa.c                |   14 ++--
 drivers/input/serio/serio.c                  |   93 ++++++++++++++++++++++++---
 drivers/input/touchscreen/gunze.c            |   14 ++--
 drivers/input/touchscreen/h3600_ts_input.c   |   14 ++--
 include/linux/serio.h                        |    9 ++
 20 files changed, 261 insertions(+), 83 deletions(-)


===================================================================



diff -Nru a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile	2004-06-27 17:48:52 -05:00
+++ b/drivers/Makefile	2004-06-27 17:48:52 -05:00
@@ -37,9 +37,9 @@
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_USB)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
+obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
-obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_PHONE)		+= telephony/
diff -Nru a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
--- a/drivers/input/joystick/iforce/iforce-serio.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/joystick/iforce/iforce-serio.c	2004-06-27 17:48:52 -05:00
@@ -159,8 +159,12 @@
 }
 
 struct serio_driver iforce_serio_drv = {
-	.write_wakeup =	iforce_serio_write_wakeup,
-	.interrupt =	iforce_serio_irq,
-	.connect =	iforce_serio_connect,
-	.disconnect =	iforce_serio_disconnect,
+	.driver		= {
+		.name	= "iforce",
+	},
+	.description	= "RS232 I-Force joysticks and wheels driver",
+	.write_wakeup	= iforce_serio_write_wakeup,
+	.interrupt	= iforce_serio_irq,
+	.connect	= iforce_serio_connect,
+	.disconnect	= iforce_serio_disconnect,
 };
diff -Nru a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
--- a/drivers/input/joystick/magellan.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/joystick/magellan.c	2004-06-27 17:48:52 -05:00
@@ -35,8 +35,10 @@
 #include <linux/serio.h>
 #include <linux/init.h>
 
+#define DRIVER_DESC	"Magellan and SpaceMouse 6dof controller driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Magellan and SpaceMouse 6dof controller driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 /*
@@ -200,9 +202,13 @@
  */
 
 static struct serio_driver magellan_drv = {
-	.interrupt =	magellan_interrupt,
-	.connect =	magellan_connect,
-	.disconnect =	magellan_disconnect,
+	.driver		= {
+		.name	= "magellan",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= magellan_interrupt,
+	.connect	= magellan_connect,
+	.disconnect	= magellan_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
--- a/drivers/input/joystick/spaceball.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/joystick/spaceball.c	2004-06-27 17:48:52 -05:00
@@ -39,8 +39,10 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 
+#define DRIVER_DESC	"SpaceTec SpaceBall 2003/3003/4000 FLX driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("SpaceTec SpaceBall 2003/3003/4000 FLX driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 /*
@@ -270,9 +272,13 @@
  */
 
 static struct serio_driver spaceball_drv = {
-	.interrupt =	spaceball_interrupt,
-	.connect =	spaceball_connect,
-	.disconnect =	spaceball_disconnect,
+	.driver		= {
+		.name	= "spaceball",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= spaceball_interrupt,
+	.connect	= spaceball_connect,
+	.disconnect	= spaceball_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/joystick/spaceorb.c b/drivers/input/joystick/spaceorb.c
--- a/drivers/input/joystick/spaceorb.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/joystick/spaceorb.c	2004-06-27 17:48:52 -05:00
@@ -38,8 +38,10 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 
+#define DRIVER_DESC	"SpaceTec SpaceOrb 360 and Avenger 6dof controller driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("SpaceTec SpaceOrb 360 and Avenger 6dof controller driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 /*
@@ -214,9 +216,13 @@
  */
 
 static struct serio_driver spaceorb_drv = {
-	.interrupt =	spaceorb_interrupt,
-	.connect =	spaceorb_connect,
-	.disconnect =	spaceorb_disconnect,
+	.driver		= {
+		.name	= "spaceorb",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= spaceorb_interrupt,
+	.connect	= spaceorb_connect,
+	.disconnect	= spaceorb_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
--- a/drivers/input/joystick/stinger.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/joystick/stinger.c	2004-06-27 17:48:52 -05:00
@@ -36,8 +36,10 @@
 #include <linux/serio.h>
 #include <linux/init.h>
 
+#define DRIVER_DESC	"Gravis Stinger gamepad driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Gravis Stinger gamepad driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 /*
@@ -188,9 +190,13 @@
  */
 
 static struct serio_driver stinger_drv = {
-	.interrupt =	stinger_interrupt,
-	.connect =	stinger_connect,
-	.disconnect =	stinger_disconnect,
+	.driver		= {
+		.name	= "stinger",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= stinger_interrupt,
+	.connect	= stinger_connect,
+	.disconnect	= stinger_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/joystick/twidjoy.c	2004-06-27 17:48:52 -05:00
@@ -247,9 +247,13 @@
  */
 
 static struct serio_driver twidjoy_drv = {
-	.interrupt =	twidjoy_interrupt,
-	.connect =	twidjoy_connect,
-	.disconnect =	twidjoy_disconnect,
+	.driver		= {
+		.name	= "twidjoy",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= twidjoy_interrupt,
+	.connect	= twidjoy_connect,
+	.disconnect	= twidjoy_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/joystick/warrior.c b/drivers/input/joystick/warrior.c
--- a/drivers/input/joystick/warrior.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/joystick/warrior.c	2004-06-27 17:48:52 -05:00
@@ -35,8 +35,10 @@
 #include <linux/serio.h>
 #include <linux/init.h>
 
+#define DRIVER_DESC	"Logitech WingMan Warrior joystick driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Logitech WingMan Warrior joystick driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 /*
@@ -200,9 +202,13 @@
  */
 
 static struct serio_driver warrior_drv = {
-	.interrupt =	warrior_interrupt,
-	.connect =	warrior_connect,
-	.disconnect =	warrior_disconnect,
+	.driver		= {
+		.name	= "warrior",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= warrior_interrupt,
+	.connect	= warrior_connect,
+	.disconnect	= warrior_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/keyboard/atkbd.c	2004-06-27 17:48:52 -05:00
@@ -27,8 +27,10 @@
 #include <linux/serio.h>
 #include <linux/workqueue.h>
 
+#define DRIVER_DESC	"AT and PS/2 keyboard driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
-MODULE_DESCRIPTION("AT and PS/2 keyboard driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 static int atkbd_set = 2;
@@ -891,11 +893,15 @@
 }
 
 static struct serio_driver atkbd_drv = {
-	.interrupt =	atkbd_interrupt,
-	.connect =	atkbd_connect,
-	.reconnect = 	atkbd_reconnect,
-	.disconnect =	atkbd_disconnect,
-	.cleanup =	atkbd_cleanup,
+	.driver		= {
+		.name	= "atkbd",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= atkbd_interrupt,
+	.connect	= atkbd_connect,
+	.reconnect	= atkbd_reconnect,
+	.disconnect	= atkbd_disconnect,
+	.cleanup	= atkbd_cleanup,
 };
 
 int __init atkbd_init(void)
diff -Nru a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
--- a/drivers/input/keyboard/lkkbd.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/keyboard/lkkbd.c	2004-06-27 17:48:52 -05:00
@@ -76,8 +76,10 @@
 #include <linux/serio.h>
 #include <linux/workqueue.h>
 
+#define DRIVER_DESC	"LK keyboard driver"
+
 MODULE_AUTHOR ("Jan-Benedict Glaw <jbglaw@lug-owl.de>");
-MODULE_DESCRIPTION ("LK keyboard driver");
+MODULE_DESCRIPTION (DRIVER_DESC);
 MODULE_LICENSE ("GPL");
 
 /*
@@ -704,9 +706,13 @@
 }
 
 static struct serio_driver lkkbd_drv = {
-	.connect = lkkbd_connect,
-	.disconnect = lkkbd_disconnect,
-	.interrupt = lkkbd_interrupt,
+	.driver		= {
+		.name	= "lkkbd",
+	},
+	.description	= DRIVER_DESC,
+	.connect	= lkkbd_connect,
+	.disconnect	= lkkbd_disconnect,
+	.interrupt	= lkkbd_interrupt,
 };
 
 /*
diff -Nru a/drivers/input/keyboard/newtonkbd.c b/drivers/input/keyboard/newtonkbd.c
--- a/drivers/input/keyboard/newtonkbd.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/keyboard/newtonkbd.c	2004-06-27 17:48:52 -05:00
@@ -32,8 +32,10 @@
 #include <linux/init.h>
 #include <linux/serio.h>
 
+#define DRIVER_DESC	"Newton keyboard driver"
+
 MODULE_AUTHOR("Justin Cormack <j.cormack@doc.ic.ac.uk>");
-MODULE_DESCRIPTION("Newton keyboard driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 #define NKBD_KEY	0x7f
@@ -139,9 +141,13 @@
 }
 
 struct serio_driver nkbd_drv = {
-	.interrupt =	nkbd_interrupt,
-	.connect =	nkbd_connect,
-	.disconnect =	nkbd_disconnect
+	.driver		= {
+		.name	= "newtonkbd",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= nkbd_interrupt,
+	.connect	= nkbd_connect,
+	.disconnect	= nkbd_disconnect,
 };
 
 int __init nkbd_init(void)
diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/keyboard/sunkbd.c	2004-06-27 17:48:52 -05:00
@@ -37,8 +37,10 @@
 #include <linux/serio.h>
 #include <linux/workqueue.h>
 
+#define DRIVER_DESC	"Sun keyboard driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Sun keyboard driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 static unsigned char sunkbd_keycode[128] = {
@@ -302,9 +304,13 @@
 }
 
 static struct serio_driver sunkbd_drv = {
-	.interrupt =	sunkbd_interrupt,
-	.connect =	sunkbd_connect,
-	.disconnect =	sunkbd_disconnect
+	.driver		= {
+		.name	= "sunkbd",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= sunkbd_interrupt,
+	.connect	= sunkbd_connect,
+	.disconnect	= sunkbd_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
--- a/drivers/input/keyboard/xtkbd.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/keyboard/xtkbd.c	2004-06-27 17:48:52 -05:00
@@ -34,8 +34,10 @@
 #include <linux/init.h>
 #include <linux/serio.h>
 
+#define DRIVER_DESC	"XT keyboard driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("XT keyboard driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 #define XTKBD_EMUL0	0xe0
@@ -144,9 +146,13 @@
 }
 
 struct serio_driver xtkbd_drv = {
-	.interrupt =	xtkbd_interrupt,
-	.connect =	xtkbd_connect,
-	.disconnect =	xtkbd_disconnect
+	.driver		= {
+		.name	= "xtkbd",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= xtkbd_interrupt,
+	.connect	= xtkbd_connect,
+	.disconnect	= xtkbd_disconnect,
 };
 
 int __init xtkbd_init(void)
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-06-27 17:48:52 -05:00
@@ -22,8 +22,10 @@
 #include "synaptics.h"
 #include "logips2pp.h"
 
+#define DRIVER_DESC	"PS/2 mouse driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
-MODULE_DESCRIPTION("PS/2 mouse driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 static char *psmouse_proto;
@@ -825,11 +827,15 @@
 
 
 static struct serio_driver psmouse_drv = {
-	.interrupt =	psmouse_interrupt,
-	.connect =	psmouse_connect,
-	.reconnect =	psmouse_reconnect,
-	.disconnect =	psmouse_disconnect,
-	.cleanup =	psmouse_cleanup,
+	.driver		= {
+		.name	= "psmouse",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= psmouse_interrupt,
+	.connect	= psmouse_connect,
+	.reconnect	= psmouse_reconnect,
+	.disconnect	= psmouse_disconnect,
+	.cleanup	= psmouse_cleanup,
 };
 
 static inline void psmouse_parse_proto(void)
diff -Nru a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
--- a/drivers/input/mouse/sermouse.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/mouse/sermouse.c	2004-06-27 17:48:52 -05:00
@@ -37,8 +37,10 @@
 #include <linux/serio.h>
 #include <linux/init.h>
 
+#define DRIVER_DESC	"Serial mouse driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Serial mouse driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 static char *sermouse_protocols[] = { "None", "Mouse Systems Mouse", "Sun Mouse", "Microsoft Mouse",
@@ -290,9 +292,13 @@
 }
 
 static struct serio_driver sermouse_drv = {
-	.interrupt =	sermouse_interrupt,
-	.connect =	sermouse_connect,
-	.disconnect =	sermouse_disconnect
+	.driver		= {
+		.name	= "sermouse",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= sermouse_interrupt,
+	.connect	= sermouse_connect,
+	.disconnect	= sermouse_disconnect,
 };
 
 int __init sermouse_init(void)
diff -Nru a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
--- a/drivers/input/mouse/vsxxxaa.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/mouse/vsxxxaa.c	2004-06-27 17:48:52 -05:00
@@ -82,8 +82,10 @@
 #include <linux/serio.h>
 #include <linux/init.h>
 
+#define DRIVER_DESC	"Serial DEC VSXXX-AA/GA mouse / DEC tablet driver"
+
 MODULE_AUTHOR ("Jan-Benedict Glaw <jbglaw@lug-owl.de>");
-MODULE_DESCRIPTION ("Serial DEC VSXXX-AA/GA mouse / DEC tablet driver");
+MODULE_DESCRIPTION (DRIVER_DESC);
 MODULE_LICENSE ("GPL");
 
 #undef VSXXXAA_DEBUG
@@ -541,9 +543,13 @@
 }
 
 static struct serio_driver vsxxxaa_drv = {
-	.connect = vsxxxaa_connect,
-	.interrupt = vsxxxaa_interrupt,
-	.disconnect = vsxxxaa_disconnect,
+	.driver		= {
+		.name	= "vsxxxaa",
+	},
+	.description	= DRIVER_DESC,
+	.connect	= vsxxxaa_connect,
+	.interrupt	= vsxxxaa_interrupt,
+	.disconnect	= vsxxxaa_disconnect,
 };
 
 int __init
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/serio/serio.c	2004-06-27 17:48:52 -05:00
@@ -56,6 +56,11 @@
 static DECLARE_MUTEX(serio_sem);	/* protects serio_list and serio_diriver_list */
 static LIST_HEAD(serio_list);
 static LIST_HEAD(serio_driver_list);
+static unsigned int serio_no;
+
+struct bus_type serio_bus = {
+	.name =	"serio",
+};
 
 static void serio_find_driver(struct serio *serio);
 static void serio_create_port(struct serio *serio);
@@ -66,9 +71,19 @@
 
 static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
 {
+	get_driver(&drv->driver);
+
 	drv->connect(serio, drv);
+	if (serio->drv) {
+		down_write(&serio_bus.subsys.rwsem);
+		serio->dev.driver = &drv->driver;
+		device_bind_driver(&serio->dev);
+		up_write(&serio_bus.subsys.rwsem);
+		return 1;
+	}
 
-	return serio->drv != NULL;
+	put_driver(&drv->driver);
+	return 0;
 }
 
 /* serio_find_driver() must be called with serio_sem down.  */
@@ -224,10 +239,49 @@
  * Serio port operations
  */
 
+static ssize_t serio_show_description(struct device *dev, char *buf)
+{
+	struct serio *serio = to_serio_port(dev);
+	return sprintf(buf, "%s\n", serio->name);
+}
+static DEVICE_ATTR(description, S_IRUGO, serio_show_description, NULL);
+
+static ssize_t serio_show_legacy_position(struct device *dev, char *buf)
+{
+	struct serio *serio = to_serio_port(dev);
+	return sprintf(buf, "%s\n", serio->phys);
+}
+static DEVICE_ATTR(legacy_position, S_IRUGO, serio_show_legacy_position, NULL);
+
+static ssize_t serio_show_driver(struct device *dev, char *buf)
+{
+	return sprintf(buf, "%s\n", dev->driver ? dev->driver->name : "(none)");
+}
+static DEVICE_ATTR(driver, S_IRUGO, serio_show_driver, NULL);
+
+static void serio_release_port(struct device *dev)
+{
+	struct serio *serio = to_serio_port(dev);
+
+	kfree(serio);
+	module_put(THIS_MODULE);
+}
+
 static void serio_create_port(struct serio *serio)
 {
+	try_module_get(THIS_MODULE);
+
 	spin_lock_init(&serio->lock);
 	list_add_tail(&serio->node, &serio_list);
+	snprintf(serio->dev.bus_id, sizeof(serio->dev.bus_id), "serio%d", serio_no++);
+	serio->dev.bus = &serio_bus;
+	serio->dev.release = serio_release_port;
+	if (serio->parent)
+		serio->dev.parent = &serio->parent->dev;
+	device_register(&serio->dev);
+	device_create_file(&serio->dev, &dev_attr_description);
+	device_create_file(&serio->dev, &dev_attr_legacy_position);
+	device_create_file(&serio->dev, &dev_attr_driver);
 }
 
 /*
@@ -242,8 +296,13 @@
 	serio_remove_pending_events(serio);
 	list_del_init(&serio->node);
 
-	if (drv)
+	if (drv) {
 		drv->disconnect(serio);
+		down_write(&serio_bus.subsys.rwsem);
+		device_release_driver(&serio->dev);
+		up_write(&serio_bus.subsys.rwsem);
+		put_driver(&drv->driver);
+	}
 
 	if (serio->parent) {
 		spin_lock_irqsave(&serio->parent->lock, flags);
@@ -251,7 +310,7 @@
 		spin_unlock_irqrestore(&serio->parent->lock, flags);
 	}
 
-	kfree(serio);
+	device_unregister(&serio->dev);
 }
 
 /*
@@ -332,8 +391,13 @@
 	/*
 	 * Ok, no children left, now disconnect this port
 	 */
-	if (drv)
+	if (drv) {
 		drv->disconnect(serio);
+		down_write(&serio_bus.subsys.rwsem);
+		device_release_driver(&serio->dev);
+		up_write(&serio_bus.subsys.rwsem);
+		put_driver(&drv->driver);
+	}
 }
 
 void serio_rescan(struct serio *serio)
@@ -387,6 +451,12 @@
  * Serio driver operations
  */
 
+static ssize_t serio_driver_show_description(struct device_driver *drv, char *buf)
+{
+	struct serio_driver *driver = to_serio_driver(drv);
+	return sprintf(buf, "%s\n", driver->description ? driver->description : "(none)");
+}
+static DRIVER_ATTR(description, S_IRUGO, serio_driver_show_description, NULL);
 
 void serio_register_driver(struct serio_driver *drv)
 {
@@ -396,6 +466,10 @@
 
 	list_add_tail(&drv->node, &serio_driver_list);
 
+	drv->driver.bus = &serio_bus;
+	driver_register(&drv->driver);
+	driver_create_file(&drv->driver, &driver_attr_description);
+
 start_over:
 	list_for_each_entry(serio, &serio_list, node) {
 		if (!serio->drv) {
@@ -430,6 +504,8 @@
 		}
 	}
 
+	driver_unregister(&drv->driver);
+
 	up(&serio_sem);
 }
 
@@ -489,22 +565,19 @@
 
 static int __init serio_init(void)
 {
-	int pid;
-
-	pid = kernel_thread(serio_thread, NULL, CLONE_KERNEL);
-
-	if (!pid) {
+	if (!(serio_pid = kernel_thread(serio_thread, NULL, CLONE_KERNEL))) {
 		printk(KERN_WARNING "serio: Failed to start kseriod\n");
 		return -1;
 	}
 
-	serio_pid = pid;
+	bus_register(&serio_bus);
 
 	return 0;
 }
 
 static void __exit serio_exit(void)
 {
+	bus_unregister(&serio_bus);
 	kill_proc(serio_pid, SIGTERM, 1);
 	wait_for_completion(&serio_exited);
 }
diff -Nru a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
--- a/drivers/input/touchscreen/gunze.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/touchscreen/gunze.c	2004-06-27 17:48:52 -05:00
@@ -36,8 +36,10 @@
 #include <linux/serio.h>
 #include <linux/init.h>
 
+#define DRIVER_DESC	"Gunze AHL-51S touchscreen driver"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Gunze AHL-51S touchscreen driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 /*
@@ -157,9 +159,13 @@
  */
 
 static struct serio_driver gunze_drv = {
-	.interrupt =	gunze_interrupt,
-	.connect =	gunze_connect,
-	.disconnect =	gunze_disconnect,
+	.driver		= {
+		.name	= "gunze",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= gunze_interrupt,
+	.connect	= gunze_connect,
+	.disconnect	= gunze_disconnect,
 };
 
 /*
diff -Nru a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
--- a/drivers/input/touchscreen/h3600_ts_input.c	2004-06-27 17:48:52 -05:00
+++ b/drivers/input/touchscreen/h3600_ts_input.c	2004-06-27 17:48:52 -05:00
@@ -45,8 +45,10 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/irqs.h>
 
+#define DRIVER_DESC	"H3600 touchscreen driver"
+
 MODULE_AUTHOR("James Simmons <jsimmons@transvirtual.com>");
-MODULE_DESCRIPTION("H3600 touchscreen driver");
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 /*
@@ -479,9 +481,13 @@
  */
 
 static struct serio_driver h3600ts_drv = {
-	.interrupt =	h3600ts_interrupt,
-	.connect =	h3600ts_connect,
-	.disconnect =	h3600ts_disconnect,
+	.driver		= {
+		.name	= "h3600ts",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= h3600ts_interrupt,
+	.connect	= h3600ts_connect,
+	.disconnect	= h3600ts_disconnect,
 };
 
 /*
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-06-27 17:48:52 -05:00
+++ b/include/linux/serio.h	2004-06-27 17:48:52 -05:00
@@ -18,6 +18,7 @@
 
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/device.h>
 
 struct serio {
 	void *private;
@@ -44,12 +45,15 @@
 
 	struct serio_driver *drv; /* Accessed from interrupt, writes must be protected by serio_lock */
 
+	struct device dev;
+
 	struct list_head node;
 };
+#define to_serio_port(d)	container_of(d, struct serio, dev)
 
 struct serio_driver {
 	void *private;
-	char *name;
+	char *description;
 
 	void (*write_wakeup)(struct serio *);
 	irqreturn_t (*interrupt)(struct serio *, unsigned char,
@@ -59,8 +63,11 @@
 	void (*disconnect)(struct serio *);
 	void (*cleanup)(struct serio *);
 
+	struct device_driver driver;
+
 	struct list_head node;
 };
+#define to_serio_driver(d)	container_of(d, struct serio_driver, driver)
 
 int serio_open(struct serio *serio, struct serio_driver *drv);
 void serio_close(struct serio *serio);
