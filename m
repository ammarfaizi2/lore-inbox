Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbUKXHTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbUKXHTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUKXHTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:19:23 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:59237 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262326AbUKXHOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:14:54 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 3/11] Addd serio_get/put_drvdata functions
Date: Wed, 24 Nov 2004 02:07:31 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411240205.10502.dtor_core@ameritech.net> <200411240206.05955.dtor_core@ameritech.net> <200411240206.45763.dtor_core@ameritech.net>
In-Reply-To: <200411240206.45763.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411240207.33932.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1939.3.36, 2004-11-15 00:01:17-05:00, dtor_core@ameritech.net
  Input: remove serio->private in favor of using driver-specific data
         in device structure, add serio_get_drvdata/serio_put_drvdata
         to access it.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/joystick/iforce/iforce-serio.c |   14 +++++++++----
 drivers/input/joystick/magellan.c            |    9 +++++---
 drivers/input/joystick/spaceball.c           |    9 +++++---
 drivers/input/joystick/spaceorb.c            |    9 +++++---
 drivers/input/joystick/stinger.c             |   10 ++++++---
 drivers/input/joystick/warrior.c             |    9 +++++---
 drivers/input/keyboard/atkbd.c               |   18 +++++++++-------
 drivers/input/keyboard/lkkbd.c               |    8 ++++---
 drivers/input/keyboard/newtonkbd.c           |   10 ++++++---
 drivers/input/keyboard/sunkbd.c              |    9 +++++---
 drivers/input/keyboard/xtkbd.c               |    9 +++++---
 drivers/input/mouse/psmouse-base.c           |   29 ++++++++++++++-------------
 drivers/input/mouse/sermouse.c               |   11 ++++++----
 drivers/input/mouse/synaptics.c              |    7 +++---
 drivers/input/mouse/vsxxxaa.c                |    9 +++++---
 drivers/input/serio/serio_raw.c              |   12 +++++------
 drivers/input/touchscreen/gunze.c            |   10 ++++++---
 drivers/input/touchscreen/h3600_ts_input.c   |   13 +++++++-----
 include/linux/serio.h                        |   14 ++++++++++++-
 19 files changed, 142 insertions(+), 77 deletions(-)


===================================================================



diff -Nru a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
--- a/drivers/input/joystick/iforce/iforce-serio.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/joystick/iforce/iforce-serio.c	2004-11-24 01:46:08 -05:00
@@ -75,13 +75,15 @@
 
 static void iforce_serio_write_wakeup(struct serio *serio)
 {
-	iforce_serial_xmit((struct iforce *)serio->private);
+	struct iforce *iforce = serio_get_drvdata(serio);
+
+	iforce_serial_xmit(iforce);
 }
 
 static irqreturn_t iforce_serio_irq(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
-	struct iforce* iforce = serio->private;
+	struct iforce *iforce = serio_get_drvdata(serio);
 
 	if (!iforce->pkt) {
 		if (data == 0x2b)
@@ -135,15 +137,18 @@
 
 	iforce->bus = IFORCE_232;
 	iforce->serio = serio;
-	serio->private = iforce;
+
+	serio_set_drvdata(serio, iforce);
 
 	if (serio_open(serio, drv)) {
+		serio_set_drvdata(serio, NULL);
 		kfree(iforce);
 		return;
 	}
 
 	if (iforce_init_device(iforce)) {
 		serio_close(serio);
+		serio_set_drvdata(serio, NULL);
 		kfree(iforce);
 		return;
 	}
@@ -151,10 +156,11 @@
 
 static void iforce_serio_disconnect(struct serio *serio)
 {
-	struct iforce* iforce = serio->private;
+	struct iforce *iforce = serio_get_drvdata(serio);
 
 	input_unregister_device(&iforce->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(iforce);
 }
 
diff -Nru a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
--- a/drivers/input/joystick/magellan.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/joystick/magellan.c	2004-11-24 01:46:08 -05:00
@@ -118,7 +118,7 @@
 static irqreturn_t magellan_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
-	struct magellan* magellan = serio->private;
+	struct magellan* magellan = serio_get_drvdata(serio);
 
 	if (data == '\r') {
 		magellan_process_packet(magellan, regs);
@@ -136,9 +136,11 @@
 
 static void magellan_disconnect(struct serio *serio)
 {
-	struct magellan* magellan = serio->private;
+	struct magellan* magellan = serio_get_drvdata(serio);
+
 	input_unregister_device(&magellan->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(magellan);
 }
 
@@ -185,9 +187,10 @@
 	magellan->dev.id.version = 0x0100;
 	magellan->dev.dev = &serio->dev;
 
-	serio->private = magellan;
+	serio_set_drvdata(serio, magellan);
 
 	if (serio_open(serio, drv)) {
+		serio_set_drvdata(serio, NULL);
 		kfree(magellan);
 		return;
 	}
diff -Nru a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
--- a/drivers/input/joystick/spaceball.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/joystick/spaceball.c	2004-11-24 01:46:08 -05:00
@@ -154,7 +154,7 @@
 static irqreturn_t spaceball_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
-	struct spaceball *spaceball = serio->private;
+	struct spaceball *spaceball = serio_get_drvdata(serio);
 
 	switch (data) {
 		case 0xd:
@@ -191,9 +191,11 @@
 
 static void spaceball_disconnect(struct serio *serio)
 {
-	struct spaceball* spaceball = serio->private;
+	struct spaceball* spaceball = serio_get_drvdata(serio);
+
 	input_unregister_device(&spaceball->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(spaceball);
 }
 
@@ -255,9 +257,10 @@
 	spaceball->dev.id.version = 0x0100;
 	spaceball->dev.dev = &serio->dev;
 
-	serio->private = spaceball;
+	serio_set_drvdata(serio, spaceball);
 
 	if (serio_open(serio, drv)) {
+		serio_set_drvdata(serio, NULL);
 		kfree(spaceball);
 		return;
 	}
diff -Nru a/drivers/input/joystick/spaceorb.c b/drivers/input/joystick/spaceorb.c
--- a/drivers/input/joystick/spaceorb.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/joystick/spaceorb.c	2004-11-24 01:46:08 -05:00
@@ -135,7 +135,7 @@
 static irqreturn_t spaceorb_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
-	struct spaceorb* spaceorb = serio->private;
+	struct spaceorb* spaceorb = serio_get_drvdata(serio);
 
 	if (~data & 0x80) {
 		if (spaceorb->idx) spaceorb_process_packet(spaceorb, regs);
@@ -152,9 +152,11 @@
 
 static void spaceorb_disconnect(struct serio *serio)
 {
-	struct spaceorb* spaceorb = serio->private;
+	struct spaceorb* spaceorb = serio_get_drvdata(serio);
+
 	input_unregister_device(&spaceorb->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(spaceorb);
 }
 
@@ -202,9 +204,10 @@
 	spaceorb->dev.id.version = 0x0100;
 	spaceorb->dev.dev = &serio->dev;
 
-	serio->private = spaceorb;
+	serio_set_drvdata(serio, spaceorb);
 
 	if (serio_open(serio, drv)) {
+		serio_set_drvdata(serio, NULL);
 		kfree(spaceorb);
 		return;
 	}
diff -Nru a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
--- a/drivers/input/joystick/stinger.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/joystick/stinger.c	2004-11-24 01:46:08 -05:00
@@ -103,7 +103,7 @@
 static irqreturn_t stinger_interrupt(struct serio *serio,
 	unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
-	struct stinger* stinger = serio->private;
+	struct stinger *stinger = serio_get_drvdata(serio);
 
 	/* All Stinger packets are 4 bytes */
 
@@ -124,9 +124,11 @@
 
 static void stinger_disconnect(struct serio *serio)
 {
-	struct stinger* stinger = serio->private;
+	struct stinger *stinger = serio_get_drvdata(serio);
+
 	input_unregister_device(&stinger->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(stinger);
 }
 
@@ -173,9 +175,11 @@
 	}
 
 	stinger->dev.private = stinger;
-	serio->private = stinger;
+
+	serio_set_drvdata(serio, stinger);
 
 	if (serio_open(serio, drv)) {
+		serio_set_drvdata(serio, NULL);
 		kfree(stinger);
 		return;
 	}
diff -Nru a/drivers/input/joystick/warrior.c b/drivers/input/joystick/warrior.c
--- a/drivers/input/joystick/warrior.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/joystick/warrior.c	2004-11-24 01:46:08 -05:00
@@ -104,7 +104,7 @@
 static irqreturn_t warrior_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
-	struct warrior* warrior = serio->private;
+	struct warrior *warrior = serio_get_drvdata(serio);
 
 	if (data & 0x80) {
 		if (warrior->idx) warrior_process_packet(warrior, regs);
@@ -129,9 +129,11 @@
 
 static void warrior_disconnect(struct serio *serio)
 {
-	struct warrior* warrior = serio->private;
+	struct warrior *warrior = serio_get_drvdata(serio);
+
 	input_unregister_device(&warrior->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(warrior);
 }
 
@@ -186,9 +188,10 @@
 
 	warrior->dev.private = warrior;
 
-	serio->private = warrior;
+	serio_set_drvdata(serio, warrior);
 
 	if (serio_open(serio, drv)) {
+		serio_set_drvdata(serio, NULL);
 		kfree(warrior);
 		return;
 	}
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/keyboard/atkbd.c	2004-11-24 01:46:08 -05:00
@@ -248,7 +248,7 @@
 static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 			unsigned int flags, struct pt_regs *regs)
 {
-	struct atkbd *atkbd = serio->private;
+	struct atkbd *atkbd = serio_get_drvdata(serio);
 	unsigned int code = data;
 	int scroll = 0, click = -1;
 	int value;
@@ -645,7 +645,7 @@
 
 static void atkbd_cleanup(struct serio *serio)
 {
-	struct atkbd *atkbd = serio->private;
+	struct atkbd *atkbd = serio_get_drvdata(serio);
 	ps2_command(&atkbd->ps2dev, NULL, ATKBD_CMD_RESET_BAT);
 }
 
@@ -656,7 +656,7 @@
 
 static void atkbd_disconnect(struct serio *serio)
 {
-	struct atkbd *atkbd = serio->private;
+	struct atkbd *atkbd = serio_get_drvdata(serio);
 
 	atkbd_disable(atkbd);
 
@@ -672,6 +672,7 @@
 
 	input_unregister_device(&atkbd->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(atkbd);
 }
 
@@ -808,9 +809,10 @@
 	atkbd->dev.keycodesize = sizeof(unsigned char);
 	atkbd->dev.keycodemax = ARRAY_SIZE(atkbd_set2_keycode);
 
-	serio->private = atkbd;
+	serio_set_drvdata(serio, atkbd);
 
 	if (serio_open(serio, drv)) {
+		serio_set_drvdata(serio, NULL);
 		kfree(atkbd);
 		return;
 	}
@@ -819,7 +821,7 @@
 
 		if (atkbd_probe(atkbd)) {
 			serio_close(serio);
-			serio->private = NULL;
+			serio_set_drvdata(serio, NULL);
 			kfree(atkbd);
 			return;
 		}
@@ -863,7 +865,7 @@
 
 static int atkbd_reconnect(struct serio *serio)
 {
-	struct atkbd *atkbd = serio->private;
+	struct atkbd *atkbd = serio_get_drvdata(serio);
 	struct serio_driver *drv = serio->drv;
 	unsigned char param[1];
 
@@ -922,7 +924,7 @@
 		goto out;
 	}
 
-	retval = handler((struct atkbd *)serio->private, buf);
+	retval = handler((struct atkbd *)serio_get_drvdata(serio), buf);
 
 out:
 	serio_unpin_driver(serio);
@@ -945,7 +947,7 @@
 		goto out;
 	}
 
-	atkbd = serio->private;
+	atkbd = serio_get_drvdata(serio);
 	atkbd_disable(atkbd);
 	retval = handler(atkbd, buf, count);
 	atkbd_enable(atkbd);
diff -Nru a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
--- a/drivers/input/keyboard/lkkbd.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/keyboard/lkkbd.c	2004-11-24 01:46:08 -05:00
@@ -417,7 +417,7 @@
 lkkbd_interrupt (struct serio *serio, unsigned char data, unsigned int flags,
 		struct pt_regs *regs)
 {
-	struct lkkbd *lk = serio->private;
+	struct lkkbd *lk = serio_get_drvdata (serio);
 	int i;
 
 	DBG (KERN_INFO "Got byte 0x%02x\n", data);
@@ -665,9 +665,10 @@
 	lk->dev.event = lkkbd_event;
 	lk->dev.private = lk;
 
-	serio->private = lk;
+	serio_set_drvdata (serio, lk);
 
 	if (serio_open (serio, drv)) {
+		serio_set_drvdata (serio, NULL);
 		kfree (lk);
 		return;
 	}
@@ -699,10 +700,11 @@
 static void
 lkkbd_disconnect (struct serio *serio)
 {
-	struct lkkbd *lk = serio->private;
+	struct lkkbd *lk = serio_get_drvdata (serio);
 
 	input_unregister_device (&lk->dev);
 	serio_close (serio);
+	serio_set_drvdata (serio, NULL);
 	kfree (lk);
 }
 
diff -Nru a/drivers/input/keyboard/newtonkbd.c b/drivers/input/keyboard/newtonkbd.c
--- a/drivers/input/keyboard/newtonkbd.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/keyboard/newtonkbd.c	2004-11-24 01:46:08 -05:00
@@ -69,7 +69,7 @@
 irqreturn_t nkbd_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
-	struct nkbd *nkbd = serio->private;
+	struct nkbd *nkbd = serio_get_drvdata(serio);
 
 	/* invalid scan codes are probably the init sequence, so we ignore them */
 	if (nkbd->keycode[data & NKBD_KEY]) {
@@ -106,9 +106,11 @@
 	nkbd->dev.keycodesize = sizeof(unsigned char);
 	nkbd->dev.keycodemax = ARRAY_SIZE(nkbd_keycode);
 	nkbd->dev.private = nkbd;
-	serio->private = nkbd;
+
+	serio_set_drvdata(serio, nkbd);
 
 	if (serio_open(serio, drv)) {
+		serio_set_drvdata(serio, NULL);
 		kfree(nkbd);
 		return;
 	}
@@ -135,9 +137,11 @@
 
 void nkbd_disconnect(struct serio *serio)
 {
-	struct nkbd *nkbd = serio->private;
+	struct nkbd *nkbd = serio_get_drvdata(serio);
+
 	input_unregister_device(&nkbd->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(nkbd);
 }
 
diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/keyboard/sunkbd.c	2004-11-24 01:46:08 -05:00
@@ -95,7 +95,7 @@
 static irqreturn_t sunkbd_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
-	struct sunkbd* sunkbd = serio->private;
+	struct sunkbd* sunkbd = serio_get_drvdata(serio);
 
 	if (sunkbd->reset <= -1) {		/* If cp[i] is 0xff, sunkbd->reset will stay -1. */
 		sunkbd->reset = data;		/* The keyboard sends 0xff 0xff 0xID on powerup */
@@ -257,15 +257,17 @@
 	sunkbd->dev.event = sunkbd_event;
 	sunkbd->dev.private = sunkbd;
 
-	serio->private = sunkbd;
+	serio_set_drvdata(serio, sunkbd);
 
 	if (serio_open(serio, drv)) {
+		serio_set_drvdata(serio, NULL);
 		kfree(sunkbd);
 		return;
 	}
 
 	if (sunkbd_initialize(sunkbd) < 0) {
 		serio_close(serio);
+		serio_set_drvdata(serio, NULL);
 		kfree(sunkbd);
 		return;
 	}
@@ -298,9 +300,10 @@
 
 static void sunkbd_disconnect(struct serio *serio)
 {
-	struct sunkbd *sunkbd = serio->private;
+	struct sunkbd *sunkbd = serio_get_drvdata(serio);
 	input_unregister_device(&sunkbd->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(sunkbd);
 }
 
diff -Nru a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
--- a/drivers/input/keyboard/xtkbd.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/keyboard/xtkbd.c	2004-11-24 01:46:08 -05:00
@@ -68,7 +68,7 @@
 irqreturn_t xtkbd_interrupt(struct serio *serio,
 	unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
-	struct xtkbd *xtkbd = serio->private;
+	struct xtkbd *xtkbd = serio_get_drvdata(serio);
 
 	switch (data) {
 		case XTKBD_EMUL0:
@@ -111,9 +111,10 @@
 	xtkbd->dev.keycodemax = ARRAY_SIZE(xtkbd_keycode);
 	xtkbd->dev.private = xtkbd;
 
-	serio->private = xtkbd;
+	serio_set_drvdata(serio, xtkbd);
 
 	if (serio_open(serio, drv)) {
+		serio_set_drvdata(serio, NULL);
 		kfree(xtkbd);
 		return;
 	}
@@ -140,9 +141,11 @@
 
 void xtkbd_disconnect(struct serio *serio)
 {
-	struct xtkbd *xtkbd = serio->private;
+	struct xtkbd *xtkbd = serio_get_drvdata(serio);
+
 	input_unregister_device(&xtkbd->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(xtkbd);
 }
 
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-11-24 01:46:08 -05:00
@@ -147,7 +147,7 @@
 static irqreturn_t psmouse_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
-	struct psmouse *psmouse = serio->private;
+	struct psmouse *psmouse = serio_get_drvdata(serio);
 	psmouse_ret_t rc;
 
 	if (psmouse->state == PSMOUSE_IGNORE)
@@ -690,7 +690,7 @@
 
 static void psmouse_cleanup(struct serio *serio)
 {
-	struct psmouse *psmouse = serio->private;
+	struct psmouse *psmouse = serio_get_drvdata(serio);
 
 	psmouse_reset(psmouse);
 }
@@ -709,13 +709,13 @@
 	device_remove_file(&serio->dev, &psmouse_attr_resolution);
 	device_remove_file(&serio->dev, &psmouse_attr_resetafter);
 
-	psmouse = serio->private;
+	psmouse = serio_get_drvdata(serio);
 
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 	del_timer_sync(&psmouse->ping_timer);
 
 	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
-		parent = serio->parent->private;
+		parent = serio_get_drvdata(serio->parent);
 		if (parent->pt_deactivate)
 			parent->pt_deactivate(parent);
 	}
@@ -727,6 +727,7 @@
 
 	input_unregister_device(&psmouse->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(psmouse);
 }
 
@@ -747,7 +748,7 @@
 	 * connected to this port can be successfully identified
 	 */
 	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
-		parent = serio->parent->private;
+		parent = serio_get_drvdata(serio->parent);
 		psmouse_deactivate(parent);
 	}
 
@@ -767,17 +768,18 @@
 	psmouse->dev.dev = &serio->dev;
 	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
 
-	serio->private = psmouse;
+	serio_set_drvdata(serio, psmouse);
+
 	if (serio_open(serio, drv)) {
+		serio_set_drvdata(serio, NULL);
 		kfree(psmouse);
-		serio->private = NULL;
 		goto out;
 	}
 
 	if (psmouse_probe(psmouse) < 0) {
 		serio_close(serio);
+		serio_set_drvdata(serio, NULL);
 		kfree(psmouse);
-		serio->private = NULL;
 		goto out;
 	}
 
@@ -841,7 +843,7 @@
 
 static int psmouse_reconnect(struct serio *serio)
 {
-	struct psmouse *psmouse = serio->private;
+	struct psmouse *psmouse = serio_get_drvdata(serio);
 	struct psmouse *parent = NULL;
 	struct serio_driver *drv = serio->drv;
 	int rc = -1;
@@ -852,7 +854,7 @@
 	}
 
 	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
-		parent = serio->parent->private;
+		parent = serio_get_drvdata(serio->parent);
 		psmouse_deactivate(parent);
 	}
 
@@ -914,7 +916,7 @@
 		goto out;
 	}
 
-	retval = handler(serio->private, buf);
+	retval = handler(serio_get_drvdata(serio), buf);
 
 out:
 	serio_unpin_driver(serio);
@@ -925,7 +927,8 @@
 				ssize_t (*handler)(struct psmouse *, const char *, size_t))
 {
 	struct serio *serio = to_serio_port(dev);
-	struct psmouse *psmouse = serio->private, *parent = NULL;
+	struct psmouse *psmouse = serio_get_drvdata(serio);
+	struct psmouse *parent = NULL;
 	int retval;
 
 	retval = serio_pin_driver(serio);
@@ -938,7 +941,7 @@
 	}
 
 	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
-		parent = serio->parent->private;
+		parent = serio_get_drvdata(serio->parent);
 		psmouse_deactivate(parent);
 	}
 	psmouse_deactivate(psmouse);
diff -Nru a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
--- a/drivers/input/mouse/sermouse.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/mouse/sermouse.c	2004-11-24 01:46:08 -05:00
@@ -209,7 +209,7 @@
 static irqreturn_t sermouse_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
-	struct sermouse *sermouse = serio->private;
+	struct sermouse *sermouse = serio_get_drvdata(serio);
 
 	if (time_after(jiffies, sermouse->last + HZ/10)) sermouse->count = 0;
 	sermouse->last = jiffies;
@@ -228,9 +228,11 @@
 
 static void sermouse_disconnect(struct serio *serio)
 {
-	struct sermouse *sermouse = serio->private;
+	struct sermouse *sermouse = serio_get_drvdata(serio);
+
 	input_unregister_device(&sermouse->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(sermouse);
 }
 
@@ -261,8 +263,6 @@
 	sermouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
 	sermouse->dev.private = sermouse;
 
-	serio->private = sermouse;
-
 	sermouse->type = serio->type & SERIO_PROTO;
 	c = (serio->type & SERIO_EXTRA) >> 16;
 
@@ -282,7 +282,10 @@
 	sermouse->dev.id.version = 0x0100;
 	sermouse->dev.dev = &serio->dev;
 
+	serio_set_drvdata(serio, sermouse);
+
 	if (serio_open(serio, drv)) {
+		serio_set_drvdata(serio, NULL);
 		kfree(sermouse);
 		return;
 	}
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/mouse/synaptics.c	2004-11-24 01:46:08 -05:00
@@ -229,7 +229,7 @@
  ****************************************************************************/
 static int synaptics_pt_write(struct serio *serio, unsigned char c)
 {
-	struct psmouse *parent = serio->parent->private;
+	struct psmouse *parent = serio_get_drvdata(serio->parent);
 	char rate_param = SYN_PS_CLIENT_CMD; /* indicates that we want pass-through port */
 
 	if (psmouse_sliced_command(parent, c))
@@ -246,7 +246,7 @@
 
 static void synaptics_pass_pt_packet(struct serio *ptport, unsigned char *packet)
 {
-	struct psmouse *child = ptport->private;
+	struct psmouse *child = serio_get_drvdata(ptport);
 
 	if (child && child->state == PSMOUSE_ACTIVATED) {
 		serio_interrupt(ptport, packet[1], 0, NULL);
@@ -260,7 +260,8 @@
 
 static void synaptics_pt_activate(struct psmouse *psmouse)
 {
-	struct psmouse *child = psmouse->ps2dev.serio->child->private;
+	struct serio *ptport = psmouse->ps2dev.serio->child;
+	struct psmouse *child = serio_get_drvdata(ptport);
 	struct synaptics_data *priv = psmouse->private;
 
 	/* adjust the touchpad to child's choice of protocol */
diff -Nru a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
--- a/drivers/input/mouse/vsxxxaa.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/mouse/vsxxxaa.c	2004-11-24 01:46:08 -05:00
@@ -470,7 +470,7 @@
 vsxxxaa_interrupt (struct serio *serio, unsigned char data, unsigned int flags,
 		struct pt_regs *regs)
 {
-	struct vsxxxaa *mouse = serio->private;
+	struct vsxxxaa *mouse = serio_get_drvdata (serio);
 
 	vsxxxaa_queue_byte (mouse, data);
 	vsxxxaa_parse_buffer (mouse, regs);
@@ -481,10 +481,11 @@
 static void
 vsxxxaa_disconnect (struct serio *serio)
 {
-	struct vsxxxaa *mouse = serio->private;
+	struct vsxxxaa *mouse = serio_get_drvdata (serio);
 
 	input_unregister_device (&mouse->dev);
 	serio_close (serio);
+	serio_set_drvdata (serio, NULL);
 	kfree (mouse);
 }
 
@@ -522,7 +523,6 @@
 	mouse->dev.absmax[ABS_Y] = 1023;
 
 	mouse->dev.private = mouse;
-	serio->private = mouse;
 
 	sprintf (mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer");
 	sprintf (mouse->phys, "%s/input0", serio->phys);
@@ -532,7 +532,10 @@
 	mouse->dev.dev = &serio->dev;
 	mouse->serio = serio;
 
+	serio_set_drvdata (serio, mouse);
+
 	if (serio_open (serio, drv)) {
+		serio_set_drvdata (serio, NULL);
 		kfree (mouse);
 		return;
 	}
diff -Nru a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
--- a/drivers/input/serio/serio_raw.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/serio/serio_raw.c	2004-11-24 01:46:08 -05:00
@@ -253,7 +253,7 @@
 static irqreturn_t serio_raw_interrupt(struct serio *serio, unsigned char data,
 					unsigned int dfl, struct pt_regs *regs)
 {
-	struct serio_raw *serio_raw = serio->private;
+	struct serio_raw *serio_raw = serio_get_drvdata(serio);
 	struct serio_raw_list *list;
 	unsigned int head = serio_raw->head;
 
@@ -292,7 +292,7 @@
 	INIT_LIST_HEAD(&serio_raw->list);
 	init_waitqueue_head(&serio_raw->wait);
 
-	serio->private = serio_raw;
+	serio_set_drvdata(serio, serio_raw);
 	if (serio_open(serio, drv))
 		goto out_free;
 
@@ -322,7 +322,7 @@
 	serio_close(serio);
 	list_del_init(&serio_raw->node);
 out_free:
-	serio->private = NULL;
+	serio_set_drvdata(serio, NULL);
 	kfree(serio_raw);
 out:
 	up(&serio_raw_sem);
@@ -330,7 +330,7 @@
 
 static int serio_raw_reconnect(struct serio *serio)
 {
-	struct serio_raw *serio_raw = serio->private;
+	struct serio_raw *serio_raw = serio_get_drvdata(serio);
 	struct serio_driver *drv = serio->drv;
 
 	if (!drv || !serio_raw) {
@@ -351,10 +351,10 @@
 
 	down(&serio_raw_sem);
 
-	serio_raw = serio->private;
+	serio_raw = serio_get_drvdata(serio);
 
 	serio_close(serio);
-	serio->private = NULL;
+	serio_set_drvdata(serio, NULL);
 
 	serio_raw->serio = NULL;
 	if (!serio_raw_cleanup(serio_raw))
diff -Nru a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
--- a/drivers/input/touchscreen/gunze.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/touchscreen/gunze.c	2004-11-24 01:46:08 -05:00
@@ -83,7 +83,7 @@
 static irqreturn_t gunze_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
-	struct gunze* gunze = serio->private;
+	struct gunze* gunze = serio_get_drvdata(serio);
 
 	if (data == '\r') {
 		gunze_process_packet(gunze, regs);
@@ -101,9 +101,11 @@
 
 static void gunze_disconnect(struct serio *serio)
 {
-	struct gunze* gunze = serio->private;
+	struct gunze* gunze = serio_get_drvdata(serio);
+
 	input_unregister_device(&gunze->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(gunze);
 }
 
@@ -132,7 +134,6 @@
 	input_set_abs_params(&gunze->dev, ABS_Y, 72, 3000, 0, 0);
 
 	gunze->serio = serio;
-	serio->private = gunze;
 
 	sprintf(gunze->phys, "%s/input0", serio->phys);
 
@@ -144,7 +145,10 @@
 	gunze->dev.id.product = 0x0051;
 	gunze->dev.id.version = 0x0100;
 
+	serio_set_drvdata(serio, gunze);
+
 	if (serio_open(serio, drv)) {
+		serio_set_drvdata(serio, NULL);
 		kfree(gunze);
 		return;
 	}
diff -Nru a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
--- a/drivers/input/touchscreen/h3600_ts_input.c	2004-11-24 01:46:08 -05:00
+++ b/drivers/input/touchscreen/h3600_ts_input.c	2004-11-24 01:46:08 -05:00
@@ -331,7 +331,7 @@
 static irqreturn_t h3600ts_interrupt(struct serio *serio, unsigned char data,
                                      unsigned int flags, struct pt_regs *regs)
 {
-        struct h3600_dev *ts = serio->private;
+        struct h3600_dev *ts = serio_get_drvdata(serio);
 
 	/*
          * We have a new frame coming in.
@@ -431,7 +431,6 @@
 	ts->dev.keybit[LONG(KEY_SUSPEND)] |= BIT(KEY_SUSPEND);
 
 	ts->serio = serio;
-	serio->private = ts;
 
 	sprintf(ts->phys, "%s/input0", serio->phys);
 
@@ -444,9 +443,12 @@
 	ts->dev.id.product = 0x0666;  /* FIXME !!! We can ask the hardware */
 	ts->dev.id.version = 0x0100;
 
+	serio_set_drvdata(serio, ts);
+
 	if (serio_open(serio, drv)) {
         	free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, ts);
         	free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, ts);
+		serio_set_drvdata(serio, NULL);
 		kfree(ts);
 		return;
 	}
@@ -468,12 +470,13 @@
 
 static void h3600ts_disconnect(struct serio *serio)
 {
-	struct h3600_dev *ts = serio->private;
+	struct h3600_dev *ts = serio_get_drvdata(serio);
 
-        free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, &ts->dev);
-        free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, &ts->dev);
+	free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, &ts->dev);
+	free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, &ts->dev);
 	input_unregister_device(&ts->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(ts);
 }
 
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-11-24 01:46:08 -05:00
+++ b/include/linux/serio.h	2004-11-24 01:46:08 -05:00
@@ -21,7 +21,6 @@
 #include <linux/device.h>
 
 struct serio {
-	void *private;
 	void *port_data;
 
 	char name[32];
@@ -110,6 +109,19 @@
 		serio->drv->cleanup(serio);
 }
 
+/*
+ * Use the following fucntions to manipulate serio's per-port
+ * driver-specific data.
+ */
+static __inline__ void *serio_get_drvdata(struct serio *serio)
+{
+	return dev_get_drvdata(&serio->dev);
+}
+
+static __inline__ void serio_set_drvdata(struct serio *serio, void *data)
+{
+	dev_set_drvdata(&serio->dev, data);
+}
 
 /*
  * Use the following fucntions to protect critical sections in
