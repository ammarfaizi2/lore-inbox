Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbUL2INo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbUL2INo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 03:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUL2INo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 03:13:44 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:24239 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261436AbUL2Hdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 02:33:36 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 16/16] serio connect methods should return error codes
Date: Wed, 29 Dec 2004 02:33:11 -0500
User-Agent: KMail/1.6.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
References: <200412290217.36282.dtor_core@ameritech.net> <200412290231.36450.dtor_core@ameritech.net> <200412290232.29236.dtor_core@ameritech.net>
In-Reply-To: <200412290232.29236.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412290233.13414.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1977, 2004-12-29 02:00:32-05:00, dtor_core@ameritech.net
  Input: make serio's connect routines return error code
         instead of void.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/joystick/iforce/iforce-serio.c |   15 ++++++++++-----
 drivers/input/joystick/magellan.c            |   11 +++++++----
 drivers/input/joystick/spaceorb.c            |   13 +++++++++----
 drivers/input/joystick/stinger.c             |   11 +++++++----
 drivers/input/joystick/twidjoy.c             |   12 ++++++++----
 drivers/input/joystick/warrior.c             |   12 ++++++++----
 drivers/input/keyboard/atkbd.c               |   15 ++++++++++-----
 drivers/input/keyboard/lkkbd.c               |   13 +++++++++----
 drivers/input/keyboard/newtonkbd.c           |   12 ++++++++----
 drivers/input/keyboard/sunkbd.c              |   14 +++++++++-----
 drivers/input/keyboard/xtkbd.c               |   12 ++++++++----
 drivers/input/mouse/psmouse-base.c           |   15 ++++++++++++---
 drivers/input/mouse/sermouse.c               |   12 ++++++++----
 drivers/input/mouse/vsxxxaa.c                |   12 ++++++++----
 drivers/input/serio/serio.c                  |    6 ++----
 drivers/input/touchscreen/gunze.c            |   12 ++++++++----
 drivers/input/touchscreen/h3600_ts_input.c   |   16 ++++++++++------
 include/linux/serio.h                        |    2 +-
 18 files changed, 142 insertions(+), 73 deletions(-)


===================================================================



diff -Nru a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
--- a/drivers/input/joystick/iforce/iforce-serio.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/joystick/iforce/iforce-serio.c	2004-12-29 02:01:00 -05:00
@@ -126,12 +126,14 @@
 	return IRQ_HANDLED;
 }
 
-static void iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
+static int iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct iforce *iforce;
+	int err;
 
 	if (!(iforce = kmalloc(sizeof(struct iforce), GFP_KERNEL)))
-		return;
+		return -ENOMEM;
+
 	memset(iforce, 0, sizeof(struct iforce));
 
 	iforce->bus = IFORCE_232;
@@ -139,18 +141,21 @@
 
 	serio_set_drvdata(serio, iforce);
 
-	if (serio_open(serio, drv)) {
+	err = serio_open(serio, drv);
+	if (err) {
 		serio_set_drvdata(serio, NULL);
 		kfree(iforce);
-		return;
+		return err;
 	}
 
 	if (iforce_init_device(iforce)) {
 		serio_close(serio);
 		serio_set_drvdata(serio, NULL);
 		kfree(iforce);
-		return;
+		return -ENODEV;
 	}
+
+	return 0;
 }
 
 static void iforce_serio_disconnect(struct serio *serio)
diff -Nru a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
--- a/drivers/input/joystick/magellan.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/joystick/magellan.c	2004-12-29 02:01:00 -05:00
@@ -150,13 +150,14 @@
  * an input device.
  */
 
-static void magellan_connect(struct serio *serio, struct serio_driver *drv)
+static int magellan_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct magellan *magellan;
 	int i, t;
+	int err;
 
 	if (!(magellan = kmalloc(sizeof(struct magellan), GFP_KERNEL)))
-		return;
+		return -ENOMEM;
 
 	memset(magellan, 0, sizeof(struct magellan));
 
@@ -186,16 +187,18 @@
 
 	serio_set_drvdata(serio, magellan);
 
-	if (serio_open(serio, drv)) {
+	err = serio_open(serio, drv);
+	if (err) {
 		serio_set_drvdata(serio, NULL);
 		kfree(magellan);
-		return;
+		return err;
 	}
 
 	input_register_device(&magellan->dev);
 
 	printk(KERN_INFO "input: %s on %s\n", magellan_name, serio->phys);
 
+	return 0;
 }
 
 /*
diff -Nru a/drivers/input/joystick/spaceorb.c b/drivers/input/joystick/spaceorb.c
--- a/drivers/input/joystick/spaceorb.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/joystick/spaceorb.c	2004-12-29 02:01:00 -05:00
@@ -166,13 +166,15 @@
  * it as an input device.
  */
 
-static void spaceorb_connect(struct serio *serio, struct serio_driver *drv)
+static int spaceorb_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct spaceorb *spaceorb;
 	int i, t;
+	int err;
 
 	if (!(spaceorb = kmalloc(sizeof(struct spaceorb), GFP_KERNEL)))
-		return;
+		return -ENOMEM;
+
 	memset(spaceorb, 0, sizeof(struct spaceorb));
 
 	spaceorb->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
@@ -203,13 +205,16 @@
 
 	serio_set_drvdata(serio, spaceorb);
 
-	if (serio_open(serio, drv)) {
+	err = serio_open(serio, drv);
+	if (err) {
 		serio_set_drvdata(serio, NULL);
 		kfree(spaceorb);
-		return;
+		return err;
 	}
 
 	input_register_device(&spaceorb->dev);
+
+	return 0;
 }
 
 /*
diff -Nru a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
--- a/drivers/input/joystick/stinger.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/joystick/stinger.c	2004-12-29 02:01:00 -05:00
@@ -138,13 +138,14 @@
  * an input device.
  */
 
-static void stinger_connect(struct serio *serio, struct serio_driver *drv)
+static int stinger_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct stinger *stinger;
 	int i;
+	int err;
 
 	if (!(stinger = kmalloc(sizeof(struct stinger), GFP_KERNEL)))
-		return;
+		return -ENOMEM;
 
 	memset(stinger, 0, sizeof(struct stinger));
 
@@ -175,16 +176,18 @@
 
 	serio_set_drvdata(serio, stinger);
 
-	if (serio_open(serio, drv)) {
+	err = serio_open(serio, drv);
+	if (err) {
 		serio_set_drvdata(serio, NULL);
 		kfree(stinger);
-		return;
+		return err;
 	}
 
 	input_register_device(&stinger->dev);
 
 	printk(KERN_INFO "input: %s on %s\n",  stinger_name, serio->phys);
 
+	return 0;
 }
 
 /*
diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/joystick/twidjoy.c	2004-12-29 02:01:00 -05:00
@@ -191,14 +191,15 @@
  * it as an input device.
  */
 
-static void twidjoy_connect(struct serio *serio, struct serio_driver *drv)
+static int twidjoy_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct twidjoy_button_spec *bp;
 	struct twidjoy *twidjoy;
 	int i;
+	int err;
 
 	if (!(twidjoy = kmalloc(sizeof(struct twidjoy), GFP_KERNEL)))
-		return;
+		return -ENOMEM;
 
 	memset(twidjoy, 0, sizeof(struct twidjoy));
 
@@ -235,15 +236,18 @@
 
 	serio_set_drvdata(serio, twidjoy);
 
-	if (serio_open(serio, drv)) {
+	err = serio_open(serio, drv);
+	if (err) {
 		serio_set_drvdata(serio, NULL);
 		kfree(twidjoy);
-		return;
+		return err;
 	}
 
 	input_register_device(&twidjoy->dev);
 
 	printk(KERN_INFO "input: %s on %s\n", twidjoy_name, serio->phys);
+
+	return 0;
 }
 
 /*
diff -Nru a/drivers/input/joystick/warrior.c b/drivers/input/joystick/warrior.c
--- a/drivers/input/joystick/warrior.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/joystick/warrior.c	2004-12-29 02:01:00 -05:00
@@ -143,13 +143,14 @@
  * it as an input device.
  */
 
-static void warrior_connect(struct serio *serio, struct serio_driver *drv)
+static int warrior_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct warrior *warrior;
 	int i;
+	int err;
 
 	if (!(warrior = kmalloc(sizeof(struct warrior), GFP_KERNEL)))
-		return;
+		return -ENOMEM;
 
 	memset(warrior, 0, sizeof(struct warrior));
 
@@ -187,15 +188,18 @@
 
 	serio_set_drvdata(serio, warrior);
 
-	if (serio_open(serio, drv)) {
+	err = serio_open(serio, drv);
+	if (err) {
 		serio_set_drvdata(serio, NULL);
 		kfree(warrior);
-		return;
+		return err;
 	}
 
 	input_register_device(&warrior->dev);
 
 	printk(KERN_INFO "input: Logitech WingMan Warrior on %s\n", serio->phys);
+
+	return 0;
 }
 
 /*
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/keyboard/atkbd.c	2004-12-29 02:01:00 -05:00
@@ -773,12 +773,14 @@
  * to the input module.
  */
 
-static void atkbd_connect(struct serio *serio, struct serio_driver *drv)
+static int atkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct atkbd *atkbd;
+	int err;
 
 	if (!(atkbd = kmalloc(sizeof(struct atkbd), GFP_KERNEL)))
-		return;
+		return - ENOMEM;
+
 	memset(atkbd, 0, sizeof(struct atkbd));
 
 	ps2_init(&atkbd->ps2dev, serio);
@@ -805,10 +807,11 @@
 
 	serio_set_drvdata(serio, atkbd);
 
-	if (serio_open(serio, drv)) {
+	err = serio_open(serio, drv);
+	if (err) {
 		serio_set_drvdata(serio, NULL);
 		kfree(atkbd);
-		return;
+		return err;
 	}
 
 	if (atkbd->write) {
@@ -817,7 +820,7 @@
 			serio_close(serio);
 			serio_set_drvdata(serio, NULL);
 			kfree(atkbd);
-			return;
+			return -ENODEV;
 		}
 
 		atkbd->set = atkbd_select_set(atkbd, atkbd_set, atkbd_extra);
@@ -850,6 +853,8 @@
 	atkbd_enable(atkbd);
 
 	printk(KERN_INFO "input: %s on %s\n", atkbd->name, serio->phys);
+
+	return 0;
 }
 
 /*
diff -Nru a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
--- a/drivers/input/keyboard/lkkbd.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/keyboard/lkkbd.c	2004-12-29 02:01:00 -05:00
@@ -623,14 +623,16 @@
 /*
  * lkkbd_connect() probes for a LK keyboard and fills the necessary structures.
  */
-static void
+static int
 lkkbd_connect (struct serio *serio, struct serio_driver *drv)
 {
 	struct lkkbd *lk;
 	int i;
+	int err;
 
 	if (!(lk = kmalloc (sizeof (struct lkkbd), GFP_KERNEL)))
-		return;
+		return -ENOMEM;
+
 	memset (lk, 0, sizeof (struct lkkbd));
 
 	init_input_dev (&lk->dev);
@@ -662,10 +664,11 @@
 
 	serio_set_drvdata (serio, lk);
 
-	if (serio_open (serio, drv)) {
+	err = serio_open (serio, drv);
+	if (err) {
 		serio_set_drvdata (serio, NULL);
 		kfree (lk);
-		return;
+		return err;
 	}
 
 	sprintf (lk->name, "DEC LK keyboard");
@@ -687,6 +690,8 @@
 
 	printk (KERN_INFO "input: %s on %s, initiating reset\n", lk->name, serio->phys);
 	lk->serio->write (lk->serio, LK_CMD_POWERCYCLE_RESET);
+
+	return 0;
 }
 
 /*
diff -Nru a/drivers/input/keyboard/newtonkbd.c b/drivers/input/keyboard/newtonkbd.c
--- a/drivers/input/keyboard/newtonkbd.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/keyboard/newtonkbd.c	2004-12-29 02:01:00 -05:00
@@ -84,13 +84,14 @@
 
 }
 
-void nkbd_connect(struct serio *serio, struct serio_driver *drv)
+int nkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct nkbd *nkbd;
 	int i;
+	int err;
 
 	if (!(nkbd = kmalloc(sizeof(struct nkbd), GFP_KERNEL)))
-		return;
+		return -ENOMEM;
 
 	memset(nkbd, 0, sizeof(struct nkbd));
 
@@ -106,10 +107,11 @@
 
 	serio_set_drvdata(serio, nkbd);
 
-	if (serio_open(serio, drv)) {
+	err = serio_open(serio, drv);
+	if (err) {
 		serio_set_drvdata(serio, NULL);
 		kfree(nkbd);
-		return;
+		return err;
 	}
 
 	memcpy(nkbd->keycode, nkbd_keycode, sizeof(nkbd->keycode));
@@ -130,6 +132,8 @@
 	input_register_device(&nkbd->dev);
 
 	printk(KERN_INFO "input: %s on %s\n", nkbd_name, serio->phys);
+
+	return 0;
 }
 
 void nkbd_disconnect(struct serio *serio)
diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/keyboard/sunkbd.c	2004-12-29 02:01:00 -05:00
@@ -223,13 +223,14 @@
  * sunkbd_connect() probes for a Sun keyboard and fills the necessary structures.
  */
 
-static void sunkbd_connect(struct serio *serio, struct serio_driver *drv)
+static int sunkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct sunkbd *sunkbd;
 	int i;
+	int err;
 
 	if (!(sunkbd = kmalloc(sizeof(struct sunkbd), GFP_KERNEL)))
-		return;
+		return -ENOMEM;
 
 	memset(sunkbd, 0, sizeof(struct sunkbd));
 
@@ -253,17 +254,18 @@
 
 	serio_set_drvdata(serio, sunkbd);
 
-	if (serio_open(serio, drv)) {
+	err = serio_open(serio, drv);
+	if (err) {
 		serio_set_drvdata(serio, NULL);
 		kfree(sunkbd);
-		return;
+		return err;
 	}
 
 	if (sunkbd_initialize(sunkbd) < 0) {
 		serio_close(serio);
 		serio_set_drvdata(serio, NULL);
 		kfree(sunkbd);
-		return;
+		return -ENODEV;
 	}
 
 	sprintf(sunkbd->name, "Sun Type %d keyboard", sunkbd->type);
@@ -286,6 +288,8 @@
 	input_register_device(&sunkbd->dev);
 
 	printk(KERN_INFO "input: %s on %s\n", sunkbd->name, serio->phys);
+
+	return 0;
 }
 
 /*
diff -Nru a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
--- a/drivers/input/keyboard/xtkbd.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/keyboard/xtkbd.c	2004-12-29 02:01:00 -05:00
@@ -88,13 +88,14 @@
 	return IRQ_HANDLED;
 }
 
-void xtkbd_connect(struct serio *serio, struct serio_driver *drv)
+int xtkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct xtkbd *xtkbd;
 	int i;
+	int err;
 
 	if (!(xtkbd = kmalloc(sizeof(struct xtkbd), GFP_KERNEL)))
-		return;
+		return -ENOMEM;
 
 	memset(xtkbd, 0, sizeof(struct xtkbd));
 
@@ -110,10 +111,11 @@
 
 	serio_set_drvdata(serio, xtkbd);
 
-	if (serio_open(serio, drv)) {
+	err = serio_open(serio, drv);
+	if (err) {
 		serio_set_drvdata(serio, NULL);
 		kfree(xtkbd);
-		return;
+		return err;
 	}
 
 	memcpy(xtkbd->keycode, xtkbd_keycode, sizeof(xtkbd->keycode));
@@ -134,6 +136,8 @@
 	input_register_device(&xtkbd->dev);
 
 	printk(KERN_INFO "input: %s on %s\n", xtkbd_name, serio->phys);
+
+	return 0;
 }
 
 void xtkbd_disconnect(struct serio *serio)
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-12-29 02:01:00 -05:00
@@ -673,9 +673,10 @@
  * psmouse_connect() is a callback from the serio module when
  * an unhandled serio port is found.
  */
-static void psmouse_connect(struct serio *serio, struct serio_driver *drv)
+static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct psmouse *psmouse, *parent = NULL;
+	int retval;
 
 	/*
 	 * If this is a pass-through port deactivate parent so the device
@@ -686,8 +687,10 @@
 		psmouse_deactivate(parent);
 	}
 
-	if (!(psmouse = kmalloc(sizeof(struct psmouse), GFP_KERNEL)))
+	if (!(psmouse = kmalloc(sizeof(struct psmouse), GFP_KERNEL))) {
+		retval = -ENOMEM;
 		goto out;
+	}
 
 	memset(psmouse, 0, sizeof(struct psmouse));
 
@@ -702,7 +705,8 @@
 
 	serio_set_drvdata(serio, psmouse);
 
-	if (serio_open(serio, drv)) {
+	retval = serio_open(serio, drv);
+	if (retval) {
 		serio_set_drvdata(serio, NULL);
 		kfree(psmouse);
 		goto out;
@@ -712,6 +716,7 @@
 		serio_close(serio);
 		serio_set_drvdata(serio, NULL);
 		kfree(psmouse);
+		retval = -ENODEV;
 		goto out;
 	}
 
@@ -753,10 +758,14 @@
 
 	psmouse_activate(psmouse);
 
+	retval = 0;
+
 out:
 	/* If this is a pass-through port the parent awaits to be activated */
 	if (parent)
 		psmouse_activate(parent);
+
+	return retval;
 }
 
 
diff -Nru a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
--- a/drivers/input/mouse/sermouse.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/mouse/sermouse.c	2004-12-29 02:01:00 -05:00
@@ -241,16 +241,17 @@
  * an unhandled serio port is found.
  */
 
-static void sermouse_connect(struct serio *serio, struct serio_driver *drv)
+static int sermouse_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct sermouse *sermouse;
 	unsigned char c;
+	int err;
 
 	if (!serio->id.proto || serio->id.proto > SERIO_MZPP)
-		return;
+		return -ENODEV;
 
 	if (!(sermouse = kmalloc(sizeof(struct sermouse), GFP_KERNEL)))
-		return;
+		return -ENOMEM;
 
 	memset(sermouse, 0, sizeof(struct sermouse));
 
@@ -281,15 +282,18 @@
 
 	serio_set_drvdata(serio, sermouse);
 
+	err = serio_open(serio, drv);
 	if (serio_open(serio, drv)) {
 		serio_set_drvdata(serio, NULL);
 		kfree(sermouse);
-		return;
+		return err;
 	}
 
 	input_register_device(&sermouse->dev);
 
 	printk(KERN_INFO "input: %s on %s\n", sermouse_protocols[sermouse->type], serio->phys);
+
+	return 0;
 }
 
 static struct serio_id sermouse_serio_ids[] = {
diff -Nru a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
--- a/drivers/input/mouse/vsxxxaa.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/mouse/vsxxxaa.c	2004-12-29 02:01:00 -05:00
@@ -489,13 +489,14 @@
 	kfree (mouse);
 }
 
-static void
+static int
 vsxxxaa_connect (struct serio *serio, struct serio_driver *drv)
 {
 	struct vsxxxaa *mouse;
+	int err;
 
 	if (!(mouse = kmalloc (sizeof (struct vsxxxaa), GFP_KERNEL)))
-		return;
+		return -ENOMEM;
 
 	memset (mouse, 0, sizeof (struct vsxxxaa));
 
@@ -529,10 +530,11 @@
 
 	serio_set_drvdata (serio, mouse);
 
-	if (serio_open (serio, drv)) {
+	err = serio_open (serio, drv);
+	if (err) {
 		serio_set_drvdata (serio, NULL);
 		kfree (mouse);
-		return;
+		return err;
 	}
 
 	/*
@@ -544,6 +546,8 @@
 	input_register_device (&mouse->dev);
 
 	printk (KERN_INFO "input: %s on %s\n", mouse->name, mouse->phys);
+
+	return 0;
 }
 
 static struct serio_id vsxxaa_serio_ids[] = {
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/serio/serio.c	2004-12-29 02:01:00 -05:00
@@ -92,8 +92,7 @@
 
 	if (serio_match_port(drv->ids, serio)) {
 		serio->dev.driver = &drv->driver;
-		drv->connect(serio, drv);
-		if (!serio->drv) {
+		if (drv->connect(serio, drv)) {
 			serio->dev.driver = NULL;
 			goto out;
 		}
@@ -636,8 +635,7 @@
 	struct serio *serio = to_serio_port(dev);
 	struct serio_driver *drv = to_serio_driver(dev->driver);
 
-	drv->connect(serio, drv);
-	return serio->drv ? 0 : -ENODEV;
+	return drv->connect(serio, drv);
 }
 
 static int serio_driver_remove(struct device *dev)
diff -Nru a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
--- a/drivers/input/touchscreen/gunze.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/touchscreen/gunze.c	2004-12-29 02:01:00 -05:00
@@ -115,12 +115,13 @@
  * an input device.
  */
 
-static void gunze_connect(struct serio *serio, struct serio_driver *drv)
+static int gunze_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct gunze *gunze;
+	int err;
 
 	if (!(gunze = kmalloc(sizeof(struct gunze), GFP_KERNEL)))
-		return;
+		return -ENOMEM;
 
 	memset(gunze, 0, sizeof(struct gunze));
 
@@ -144,15 +145,18 @@
 
 	serio_set_drvdata(serio, gunze);
 
-	if (serio_open(serio, drv)) {
+	err = serio_open(serio, drv);
+	if (err) {
 		serio_set_drvdata(serio, NULL);
 		kfree(gunze);
-		return;
+		return err;
 	}
 
 	input_register_device(&gunze->dev);
 
 	printk(KERN_INFO "input: %s on %s\n", gunze_name, serio->phys);
+
+	return 0;
 }
 
 /*
diff -Nru a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
--- a/drivers/input/touchscreen/h3600_ts_input.c	2004-12-29 02:01:00 -05:00
+++ b/drivers/input/touchscreen/h3600_ts_input.c	2004-12-29 02:01:00 -05:00
@@ -377,12 +377,13 @@
  * new serio device that supports H3600 protocol and registers it as
  * an input device.
  */
-static void h3600ts_connect(struct serio *serio, struct serio_driver *drv)
+static int h3600ts_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct h3600_dev *ts;
+	int err;
 
 	if (!(ts = kmalloc(sizeof(struct h3600_dev), GFP_KERNEL)))
-		return;
+		return -ENOMEM;
 
 	memset(ts, 0, sizeof(struct h3600_dev));
 
@@ -397,7 +398,7 @@
 			"h3600_action", &ts->dev)) {
 		printk(KERN_ERR "h3600ts.c: Could not allocate Action Button IRQ!\n");
 		kfree(ts);
-		return;
+		return -EBUSY;
 	}
 
         if (request_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, npower_button_handler,
@@ -406,7 +407,7 @@
 		free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, &ts->dev);
 		printk(KERN_ERR "h3600ts.c: Could not allocate Power Button IRQ!\n");
 		kfree(ts);
-		return;
+		return -EBUSY;
 	}
 
 	/* Now we have things going we setup our input device */
@@ -443,12 +444,13 @@
 
 	serio_set_drvdata(serio, ts);
 
-	if (serio_open(serio, drv)) {
+	err = serio_open(serio, drv);
+	if (err) {
         	free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, ts);
         	free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, ts);
 		serio_set_drvdata(serio, NULL);
 		kfree(ts);
-		return;
+		return err;
 	}
 
 	//h3600_flite_control(1, 25);     /* default brightness */
@@ -460,6 +462,8 @@
 	input_register_device(&ts->dev);
 
 	printk(KERN_INFO "input: %s on %s\n", h3600_name, serio->phys);
+
+	return 0;
 }
 
 /*
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-12-29 02:01:00 -05:00
+++ b/include/linux/serio.h	2004-12-29 02:01:00 -05:00
@@ -67,7 +67,7 @@
 	void (*write_wakeup)(struct serio *);
 	irqreturn_t (*interrupt)(struct serio *, unsigned char,
 			unsigned int, struct pt_regs *);
-	void (*connect)(struct serio *, struct serio_driver *drv);
+	int  (*connect)(struct serio *, struct serio_driver *drv);
 	int  (*reconnect)(struct serio *);
 	void (*disconnect)(struct serio *);
 	void (*cleanup)(struct serio *);
