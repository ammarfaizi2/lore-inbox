Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270401AbUJUHrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270401AbUJUHrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270368AbUJUHkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:40:40 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:51355 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270396AbUJUHaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:30:13 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 3/7] Input: link input_dev and serio (sysfs)
Date: Thu, 21 Oct 2004 02:26:10 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200410210223.45498.dtor_core@ameritech.net> <200410210224.33971.dtor_core@ameritech.net> <200410210225.24364.dtor_core@ameritech.net>
In-Reply-To: <200410210225.24364.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210226.12239.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1956, 2004-10-13 01:15:51-05:00, dtor_core@ameritech.net
  Input: when creating input devices for hardware attached to
         a serio port properly set input_device->dev pointer
         so when corresponding class device is created it will
         show proper links to parent device and driver in sysfs
         hierarchy.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 joystick/iforce/iforce-main.c |   16 +++++++++++++++-
 joystick/magellan.c           |    1 +
 joystick/spaceball.c          |    1 +
 joystick/spaceorb.c           |    1 +
 joystick/stinger.c            |    1 +
 joystick/twidjoy.c            |    1 +
 joystick/warrior.c            |    1 +
 keyboard/atkbd.c              |    1 +
 keyboard/lkkbd.c              |    1 +
 keyboard/newtonkbd.c          |    1 +
 keyboard/sunkbd.c             |    1 +
 keyboard/xtkbd.c              |    1 +
 mouse/psmouse-base.c          |    1 +
 mouse/sermouse.c              |    1 +
 mouse/vsxxxaa.c               |    1 +
 15 files changed, 29 insertions(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
--- a/drivers/input/joystick/iforce/iforce-main.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/joystick/iforce/iforce-main.c	2004-10-21 02:09:49 -05:00
@@ -352,7 +352,21 @@
  * Input device fields.
  */
 
-	iforce->dev.id.bustype = BUS_USB;
+	switch (iforce->bus) {
+#ifdef CONFIG_JOYSTICK_IFORCE_USB
+	case IFORCE_USB:
+		iforce->dev.id.bustype = BUS_USB;
+		iforce->dev.dev = &iforce->usbdev->dev;
+		break;
+#endif
+#ifdef CONFIG_JOYSTICK_IFORCE_232
+	case IFORCE_232:
+		iforce->dev.id.bustype = BUS_RS232;
+		iforce->dev.dev = &iforce->serio->dev;
+		break;
+#endif
+	}
+
 	iforce->dev.private = iforce;
 	iforce->dev.name = "Unknown I-Force device";
 	iforce->dev.open = iforce_open;
diff -Nru a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
--- a/drivers/input/joystick/magellan.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/joystick/magellan.c	2004-10-21 02:09:49 -05:00
@@ -183,6 +183,7 @@
 	magellan->dev.id.vendor = SERIO_MAGELLAN;
 	magellan->dev.id.product = 0x0001;
 	magellan->dev.id.version = 0x0100;
+	magellan->dev.dev = &serio->dev;
 
 	serio->private = magellan;
 
diff -Nru a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
--- a/drivers/input/joystick/spaceball.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/joystick/spaceball.c	2004-10-21 02:09:49 -05:00
@@ -253,6 +253,7 @@
 	spaceball->dev.id.vendor = SERIO_SPACEBALL;
 	spaceball->dev.id.product = id;
 	spaceball->dev.id.version = 0x0100;
+	spaceball->dev.dev = &serio->dev;
 
 	serio->private = spaceball;
 
diff -Nru a/drivers/input/joystick/spaceorb.c b/drivers/input/joystick/spaceorb.c
--- a/drivers/input/joystick/spaceorb.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/joystick/spaceorb.c	2004-10-21 02:09:49 -05:00
@@ -200,6 +200,7 @@
 	spaceorb->dev.id.vendor = SERIO_SPACEORB;
 	spaceorb->dev.id.product = 0x0001;
 	spaceorb->dev.id.version = 0x0100;
+	spaceorb->dev.dev = &serio->dev;
 
 	serio->private = spaceorb;
 
diff -Nru a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
--- a/drivers/input/joystick/stinger.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/joystick/stinger.c	2004-10-21 02:09:49 -05:00
@@ -164,6 +164,7 @@
 	stinger->dev.id.vendor = SERIO_STINGER;
 	stinger->dev.id.product = 0x0001;
 	stinger->dev.id.version = 0x0100;
+	stinger->dev.dev = &serio->dev;
 
 	for (i = 0; i < 2; i++) {
 		stinger->dev.absmax[ABS_X+i] =  64;
diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/joystick/twidjoy.c	2004-10-21 02:09:49 -05:00
@@ -210,6 +210,7 @@
 	twidjoy->dev.id.vendor = SERIO_TWIDJOY;
 	twidjoy->dev.id.product = 0x0001;
 	twidjoy->dev.id.version = 0x0100;
+	twidjoy->dev.dev = &serio->dev;
 
 	twidjoy->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
diff -Nru a/drivers/input/joystick/warrior.c b/drivers/input/joystick/warrior.c
--- a/drivers/input/joystick/warrior.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/joystick/warrior.c	2004-10-21 02:09:49 -05:00
@@ -168,6 +168,7 @@
 	warrior->dev.id.vendor = SERIO_WARRIOR;
 	warrior->dev.id.product = 0x0001;
 	warrior->dev.id.version = 0x0100;
+	warrior->dev.dev = &serio->dev;
 
 	for (i = 0; i < 2; i++) {
 		warrior->dev.absmax[ABS_X+i] = -64;
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/keyboard/atkbd.c	2004-10-21 02:09:49 -05:00
@@ -727,6 +727,7 @@
 	atkbd->dev.id.version = atkbd->id;
 	atkbd->dev.event = atkbd_event;
 	atkbd->dev.private = atkbd;
+	atkbd->dev.dev = &atkbd->ps2dev.serio->dev;
 
 	atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_MSC);
 
diff -Nru a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
--- a/drivers/input/keyboard/lkkbd.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/keyboard/lkkbd.c	2004-10-21 02:09:49 -05:00
@@ -685,6 +685,7 @@
 	lk->dev.id.vendor = SERIO_LKKBD;
 	lk->dev.id.product = 0;
 	lk->dev.id.version = 0x0100;
+	lk->dev.dev = &serio->dev;
 
 	input_register_device (&lk->dev);
 
diff -Nru a/drivers/input/keyboard/newtonkbd.c b/drivers/input/keyboard/newtonkbd.c
--- a/drivers/input/keyboard/newtonkbd.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/keyboard/newtonkbd.c	2004-10-21 02:09:49 -05:00
@@ -126,6 +126,7 @@
 	nkbd->dev.id.vendor = SERIO_NEWTON;
 	nkbd->dev.id.product = 0x0001;
 	nkbd->dev.id.version = 0x0100;
+	nkbd->dev.dev = &serio->dev;
 
 	input_register_device(&nkbd->dev);
 
diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/keyboard/sunkbd.c	2004-10-21 02:09:49 -05:00
@@ -285,6 +285,7 @@
 	sunkbd->dev.id.vendor = SERIO_SUNKBD;
 	sunkbd->dev.id.product = sunkbd->type;
 	sunkbd->dev.id.version = 0x0100;
+	sunkbd->dev.dev = &serio->dev;
 
 	input_register_device(&sunkbd->dev);
 
diff -Nru a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
--- a/drivers/input/keyboard/xtkbd.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/keyboard/xtkbd.c	2004-10-21 02:09:49 -05:00
@@ -131,6 +131,7 @@
 	xtkbd->dev.id.vendor = 0x0001;
 	xtkbd->dev.id.product = 0x0001;
 	xtkbd->dev.id.version = 0x0100;
+	xtkbd->dev.dev = &serio->dev;
 
 	input_register_device(&xtkbd->dev);
 
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-10-21 02:09:49 -05:00
@@ -699,6 +699,7 @@
 	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
 	psmouse->dev.private = psmouse;
+	psmouse->dev.dev = &serio->dev;
 	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
 
 	serio->private = psmouse;
diff -Nru a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
--- a/drivers/input/mouse/sermouse.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/mouse/sermouse.c	2004-10-21 02:09:49 -05:00
@@ -280,6 +280,7 @@
 	sermouse->dev.id.vendor = sermouse->type;
 	sermouse->dev.id.product = c;
 	sermouse->dev.id.version = 0x0100;
+	sermouse->dev.dev = &serio->dev;
 
 	if (serio_open(serio, drv)) {
 		kfree(sermouse);
diff -Nru a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
--- a/drivers/input/mouse/vsxxxaa.c	2004-10-21 02:09:49 -05:00
+++ b/drivers/input/mouse/vsxxxaa.c	2004-10-21 02:09:49 -05:00
@@ -529,6 +529,7 @@
 	mouse->dev.name = mouse->name;
 	mouse->dev.phys = mouse->phys;
 	mouse->dev.id.bustype = BUS_RS232;
+	mouse->dev.dev = &serio->dev;
 	mouse->serio = serio;
 
 	if (serio_open (serio, drv)) {
