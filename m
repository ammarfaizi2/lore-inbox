Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263408AbSJHOB0>; Tue, 8 Oct 2002 10:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263414AbSJHOBM>; Tue, 8 Oct 2002 10:01:12 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:4501 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263408AbSJHN5r>;
	Tue, 8 Oct 2002 09:57:47 -0400
Date: Tue, 8 Oct 2002 16:03:19 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Make sure input_dev is initialized where needed [23/23]
Message-ID: <20021008160319.V18546@ucw.cz>
References: <20021008155045.L18546@ucw.cz> <20021008155125.M18546@ucw.cz> <20021008155236.N18546@ucw.cz> <20021008155651.O18546@ucw.cz> <20021008155825.P18546@ucw.cz> <20021008155915.Q18546@ucw.cz> <20021008160001.R18546@ucw.cz> <20021008160100.S18546@ucw.cz> <20021008160148.T18546@ucw.cz> <20021008160241.U18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008160241.U18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 04:02:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.58, 2002-10-08 12:51:35+02:00, vojtech@suse.cz
  Initialize struct input_dev in input drivers before it's passed to input_event().
  input_register_device() usually does that, but some drivers will call
  input_event() before registering to pre-load the absolute values in
  struct input_dev in an easy way.


 drivers/input/joystick/a3d.c               |    4 ++++
 drivers/input/joystick/adi.c               |    2 ++
 drivers/input/joystick/analog.c            |    3 ++-
 drivers/input/joystick/gf2k.c              |    2 ++
 drivers/input/joystick/magellan.c          |    2 ++
 drivers/input/joystick/spaceball.c         |    1 +
 drivers/input/joystick/spaceorb.c          |    1 +
 drivers/input/joystick/stinger.c           |    3 ++-
 drivers/input/joystick/twidjoy.c           |    2 +-
 drivers/input/joystick/warrior.c           |    3 ++-
 drivers/input/keyboard/amikbd.c            |    2 ++
 drivers/input/keyboard/atkbd.c             |    2 ++
 drivers/input/keyboard/newtonkbd.c         |    2 +-
 drivers/input/keyboard/sunkbd.c            |    2 ++
 drivers/input/keyboard/xtkbd.c             |    1 +
 drivers/input/mouse/inport.c               |   25 ++++++++++++++-----------
 drivers/input/mouse/logibm.c               |   12 +++++++-----
 drivers/input/mouse/psmouse.c              |    1 +
 drivers/input/mouse/rpcmouse.c             |   12 ++++++++----
 drivers/input/mouse/sermouse.c             |    1 +
 drivers/input/touchscreen/gunze.c          |    1 +
 drivers/input/touchscreen/h3600_ts_input.c |    2 ++
 drivers/macintosh/adbhid.c                 |    2 ++
 drivers/macintosh/mac_hid.c                |    2 ++
 drivers/usb/input/powermate.c              |    1 +
 include/linux/input.h                      |    2 ++
 26 files changed, 68 insertions(+), 25 deletions(-)

===================================================================

diff -Nru a/drivers/input/joystick/a3d.c b/drivers/input/joystick/a3d.c
--- a/drivers/input/joystick/a3d.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/joystick/a3d.c	Tue Oct  8 15:25:03 2002
@@ -300,6 +300,8 @@
 
 		a3d->length = 33;
 
+		init_input_dev(&a3d->dev);
+
 		a3d->dev.evbit[0] |= BIT(EV_ABS) | BIT(EV_KEY) | BIT(EV_REL);
 		a3d->dev.relbit[0] |= BIT(REL_X) | BIT(REL_Y);
 		a3d->dev.absbit[0] |= BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_THROTTLE) | BIT(ABS_RUDDER)
@@ -327,6 +329,8 @@
 
 	} else {
 		a3d->length = 29;
+
+		init_input_dev(&a3d->dev);
 
 		a3d->dev.evbit[0] |= BIT(EV_KEY) | BIT(EV_REL);
 		a3d->dev.relbit[0] |= BIT(REL_X) | BIT(REL_Y);
diff -Nru a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
--- a/drivers/input/joystick/adi.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/joystick/adi.c	Tue Oct  8 15:25:03 2002
@@ -404,6 +404,8 @@
 
 	if (!adi->length) return;
 
+	init_input_dev(&adi->dev);
+
 	t = adi->id < ADI_ID_MAX ? adi->id : ADI_ID_MAX;
 
 	sprintf(buf, adi_names[t], adi->id);
diff -Nru a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
--- a/drivers/input/joystick/analog.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/joystick/analog.c	Tue Oct  8 15:25:03 2002
@@ -431,8 +431,9 @@
 
 	analog_name(analog);
 	sprintf(analog->phys, "%s/input%d", port->gameport->phys, index);
-
 	analog->buttons = (analog->mask & ANALOG_GAMEPAD) ? analog_pad_btn : analog_joy_btn;
+
+	init_input_dev(&analog->dev);
 
 	analog->dev.name = analog->name;
 	analog->dev.phys = analog->phys;
diff -Nru a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
--- a/drivers/input/joystick/gf2k.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/joystick/gf2k.c	Tue Oct  8 15:25:03 2002
@@ -290,6 +290,8 @@
 
 	gf2k->length = gf2k_lens[gf2k->id];
 
+	init_input_dev(&gf2k->dev);
+
 	gf2k->dev.private = gf2k;
 	gf2k->dev.open = gf2k_open;
 	gf2k->dev.close = gf2k_close;
diff -Nru a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
--- a/drivers/input/joystick/magellan.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/joystick/magellan.c	Tue Oct  8 15:25:03 2002
@@ -169,6 +169,7 @@
 
 	sprintf(magellan->phys, "%s/input0", serio->phys);
 
+	init_input_dev(&magellan->dev);
 	magellan->dev.private = magellan;
 	magellan->dev.name = magellan_name;
 	magellan->dev.phys = magellan->phys;
@@ -187,6 +188,7 @@
 	input_register_device(&magellan->dev);
 
 	printk(KERN_INFO "input: %s on %s\n", magellan_name, serio->phys);
+
 }
 
 /*
diff -Nru a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
--- a/drivers/input/joystick/spaceball.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/joystick/spaceball.c	Tue Oct  8 15:25:03 2002
@@ -240,6 +240,7 @@
 
 	sprintf(spaceball->phys, "%s/input0", serio->phys);
 
+	init_input_dev(&spaceball->dev);
 	spaceball->dev.name = spaceball_names[id];
 	spaceball->dev.phys = spaceball->phys;
 	spaceball->dev.id.bustype = BUS_RS232;
diff -Nru a/drivers/input/joystick/spaceorb.c b/drivers/input/joystick/spaceorb.c
--- a/drivers/input/joystick/spaceorb.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/joystick/spaceorb.c	Tue Oct  8 15:25:03 2002
@@ -187,6 +187,7 @@
 
 	sprintf(spaceorb->phys, "%s/input0", serio->phys);
 
+	init_input_dev(&spaceorb->dev);
 	spaceorb->dev.name = spaceorb_name;
 	spaceorb->dev.phys = spaceorb->phys;
 	spaceorb->dev.id.bustype = BUS_RS232;
diff -Nru a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
--- a/drivers/input/joystick/stinger.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/joystick/stinger.c	Tue Oct  8 15:25:03 2002
@@ -152,6 +152,7 @@
 
 	sprintf(stinger->phys, "%s/serio0", serio->phys);
 
+	init_input_dev(&stinger->dev);
 	stinger->dev.name = stinger_name;
 	stinger->dev.phys = stinger->phys;
 	stinger->dev.id.bustype = BUS_RS232;
@@ -166,7 +167,6 @@
 	}
 
 	stinger->dev.private = stinger;
-	
 	serio->private = stinger;
 
 	if (serio_open(serio, dev)) {
@@ -177,6 +177,7 @@
 	input_register_device(&stinger->dev);
 
 	printk(KERN_INFO "input: %s on %s\n",  stinger_name, serio->phys);
+
 }
 
 /*
diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/joystick/twidjoy.c	Tue Oct  8 15:25:03 2002
@@ -198,6 +198,7 @@
 
 	sprintf(twidjoy->phys, "%s/input0", serio->phys);
 
+	init_input_dev(&twidjoy->dev);
 	twidjoy->dev.name = twidjoy_name;
 	twidjoy->dev.phys = twidjoy->phys;
 	twidjoy->dev.id.bustype = BUS_RS232;
@@ -224,7 +225,6 @@
 	}
 
 	twidjoy->dev.private = twidjoy;
-	
 	serio->private = twidjoy;
 
 	if (serio_open(serio, dev)) {
diff -Nru a/drivers/input/joystick/warrior.c b/drivers/input/joystick/warrior.c
--- a/drivers/input/joystick/warrior.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/joystick/warrior.c	Tue Oct  8 15:25:03 2002
@@ -155,6 +155,7 @@
 
 	sprintf(warrior->phys, "%s/input0", serio->phys);
 
+	init_input_dev(&warrior->dev);
 	warrior->dev.name = warrior_name;
 	warrior->dev.phys = warrior->phys;
 	warrior->dev.id.bustype = BUS_RS232;
@@ -180,7 +181,7 @@
 	
 	serio->private = warrior;
 
-	if (serio_open(serio, dev)) {
+	if (serio_open(serio, dev)) { 
 		kfree(warrior);
 		return;
 	}
diff -Nru a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
--- a/drivers/input/keyboard/amikbd.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/keyboard/amikbd.c	Tue Oct  8 15:25:03 2002
@@ -112,6 +112,8 @@
 	if (!request_mem_region(CIAA_PHYSADDR-1+0xb00, 0x100, "amikeyb"))
 		return -EBUSY;
 
+	init_input_dev(&amibkd_dev);
+
 	amikbd_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
 	amikbd_dev.keycode = amikbd_keycode;
 	amikbd_dev.keycodesize = sizeof(unsigned char);
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/keyboard/atkbd.c	Tue Oct  8 15:25:03 2002
@@ -474,6 +474,8 @@
 
 	atkbd->serio = serio;
 
+	init_input_dev(&atkbd->dev);
+
 	atkbd->dev.keycode = atkbd->keycode;
 	atkbd->dev.keycodesize = sizeof(unsigned char);
 	atkbd->dev.keycodemax = ARRAY_SIZE(atkbd_set2_keycode);
diff -Nru a/drivers/input/keyboard/newtonkbd.c b/drivers/input/keyboard/newtonkbd.c
--- a/drivers/input/keyboard/newtonkbd.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/keyboard/newtonkbd.c	Tue Oct  8 15:25:03 2002
@@ -93,11 +93,11 @@
 
 	nkbd->serio = serio;
 
+	init_input_dev(&nkbd->dev);
 	nkbd->dev.keycode = nkbd->keycode;
 	nkbd->dev.keycodesize = sizeof(unsigned char);
 	nkbd->dev.keycodemax = ARRAY_SIZE(nkbd_keycode);
 	nkbd->dev.private = nkbd;
-
 	serio->private = nkbd;
 
 	if (serio_open(serio, dev)) {
diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/keyboard/sunkbd.c	Tue Oct  8 15:25:03 2002
@@ -234,6 +234,8 @@
 
 	memset(sunkbd, 0, sizeof(struct sunkbd));
 
+	init_input_dev(&sunkbd->dev);
+
 	sunkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_SND) | BIT(EV_REP);
 	sunkbd->dev.ledbit[0] = BIT(LED_CAPSL) | BIT(LED_COMPOSE) | BIT(LED_SCROLLL) | BIT(LED_NUML);
 	sunkbd->dev.sndbit[0] = BIT(SND_CLICK) | BIT(SND_BELL);
diff -Nru a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
--- a/drivers/input/keyboard/xtkbd.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/keyboard/xtkbd.c	Tue Oct  8 15:25:03 2002
@@ -100,6 +100,7 @@
 
 	xtkbd->serio = serio;
 
+	init_input_dev(&xtkbd->dev);
 	xtkbd->dev.keycode = xtkbd->keycode;
 	xtkbd->dev.keycodesize = sizeof(unsigned char);
 	xtkbd->dev.keycodemax = ARRAY_SIZE(xtkbd_keycode);
diff -Nru a/drivers/input/mouse/inport.c b/drivers/input/mouse/inport.c
--- a/drivers/input/mouse/inport.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/mouse/inport.c	Tue Oct  8 15:25:03 2002
@@ -115,6 +115,12 @@
 	.close	= inport_close,
 	.name	= INPORT_NAME,
 	.phys	= "isa023c/input0",
+	.id = { 
+ 		.bustype = BUS_ISA,
+        	.vendor  = INPORT_VENDOR,
+        	.product = 0x0001,
+        	.version = 0x0100,
+	},
 };
 
 static void inport_interrupt(int irq, void *dev_id, struct pt_regs *regs)
@@ -158,30 +164,27 @@
 {
 	unsigned char a,b,c;
 
-	if (check_region(INPORT_BASE, INPORT_EXTENT))
+	if (!request_region(INPORT_BASE, INPORT_EXTENT, "inport")) {
+		printk(KERN_ERR "inport.c: Can't allocate ports at %#x\n", INPORT_BASE);
 		return -EBUSY;
+	}
 
 	a = inb(INPORT_SIGNATURE_PORT);
 	b = inb(INPORT_SIGNATURE_PORT);
 	c = inb(INPORT_SIGNATURE_PORT);
-	if (( a == b ) || ( a != c ))
+	if (( a == b ) || ( a != c )) {
+		release_region(INPORT_BASE, INPORT_EXTENT);
+		printk(KERN_ERR "inport.c: Didn't find InPort mouse at %#x\n", INPORT_BASE);
 		return -ENODEV;
+	}
 
 	outb(INPORT_RESET, INPORT_CONTROL_PORT);
 	outb(INPORT_REG_MODE, INPORT_CONTROL_PORT);
 	outb(INPORT_MODE_BASE, INPORT_DATA_PORT);
 
-	request_region(INPORT_BASE, INPORT_EXTENT, "inport");
-
 	input_register_device(&inport_dev);
-	inport_dev.id.bustype	=BUS_ISA;
-	inport_dev.id.vendor	=INPORT_VENDOR;
-	inport_dev.id.product	=0x0001;
-	inport_dev.id.version	=0x0100;
-
 
-	printk(KERN_INFO "input: " INPORT_NAME " at %#x irq %d\n",
-		INPORT_BASE, inport_irq);
+	printk(KERN_INFO "input: " INPORT_NAME " at %#x irq %d\n", INPORT_BASE, inport_irq);
 
 	return 0;
 }
diff -Nru a/drivers/input/mouse/logibm.c b/drivers/input/mouse/logibm.c
--- a/drivers/input/mouse/logibm.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/mouse/logibm.c	Tue Oct  8 15:25:03 2002
@@ -105,6 +105,12 @@
 	.close	= logibm_close,
 	.name	= "Logitech bus mouse",
 	.phys	= "isa023c/input0",
+	.id	= {
+		.bustype = BUS_ISA,
+		.vendor  = 0x0003,
+		.product = 0x0001,
+		.version = 0x0100,
+	},
 };
 
 static void logibm_interrupt(int irq, void *dev_id, struct pt_regs *regs)
@@ -165,11 +171,7 @@
 	outb(LOGIBM_DISABLE_IRQ, LOGIBM_CONTROL_PORT);
 
 	input_register_device(&logibm_dev);
-	logibm_dev.id.bustype	= BUS_ISA;
-	logibm_dev.id.vendor	= 0x0003;
-	logibm_dev.id.product	= 0x0001;
-	logibm_dev.id.version	= 0x0100;
-
+	
 	printk(KERN_INFO "input: Logitech bus mouse at %#x irq %d\n", LOGIBM_BASE, logibm_irq);
 
 	return 0;
diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/mouse/psmouse.c	Tue Oct  8 15:25:03 2002
@@ -583,6 +583,7 @@
 
 	memset(psmouse, 0, sizeof(struct psmouse));
 
+	init_input_dev(&psmouse->dev);
 	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
 	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
diff -Nru a/drivers/input/mouse/rpcmouse.c b/drivers/input/mouse/rpcmouse.c
--- a/drivers/input/mouse/rpcmouse.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/mouse/rpcmouse.c	Tue Oct  8 15:25:03 2002
@@ -41,6 +41,12 @@
 	.relbit	= { BIT(REL_X) | BIT(REL_Y) },
 	.name	= "Acorn RiscPC Mouse",
 	.phys	= "rpcmouse/input0",
+	.id	= {
+		.bustype = BUS_HOST,
+		.vendor  = 0x0005,
+		.product = 0x0001,
+		.version = 0x0100,
+	},
 };
 
 static void rpcmouse_irq(int irq, void *dev_id, struct pt_regs *regs)
@@ -69,6 +75,8 @@
 
 static int __init rpcmouse_init(void)
 {
+	init_input_dev(&rpcmouse_dev);
+
 	rpcmouse_lastx = (short) iomd_readl(IOMD_MOUSEX);
 	rpcmouse_lasty = (short) iomd_readl(IOMD_MOUSEY);
 
@@ -78,10 +86,6 @@
 	}
 
 	input_register_device(&rpcmouse_dev);
-	rpcmouse.id.bustype	=BUS_HOST,
-	rpcmouse.id.vendor	=0x0005,
-	rpcmouse.id.product	=0x0001,
-	rpcmouse.id.version	=0x0100,
 
 	printk(KERN_INFO "input: Acorn RiscPC mouse irq %d", IRQ_VSYNCPULSE);
 
diff -Nru a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
--- a/drivers/input/mouse/sermouse.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/mouse/sermouse.c	Tue Oct  8 15:25:03 2002
@@ -247,6 +247,7 @@
 
 	memset(sermouse, 0, sizeof(struct sermouse));
 
+	init_input_dev(&sermouse->dev);
 	sermouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
 	sermouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_RIGHT);
 	sermouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
diff -Nru a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
--- a/drivers/input/touchscreen/gunze.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/touchscreen/gunze.c	Tue Oct  8 15:25:03 2002
@@ -120,6 +120,7 @@
 
 	memset(gunze, 0, sizeof(struct gunze));
 
+	init_input_dev(&gunze->dev);
 	gunze->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);	
 	gunze->dev.absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
 	gunze->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
diff -Nru a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
--- a/drivers/input/touchscreen/h3600_ts_input.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/input/touchscreen/h3600_ts_input.c	Tue Oct  8 15:25:03 2002
@@ -371,6 +371,8 @@
 
 	memset(ts, 0, sizeof(struct h3600_dev));
 
+	init_input_dev(&ts->dev);
+
 	/* Device specific stuff */
         set_GPIO_IRQ_edge( GPIO_BITSY_ACTION_BUTTON, GPIO_BOTH_EDGES );
         set_GPIO_IRQ_edge( GPIO_BITSY_NPOWER_BUTTON, GPIO_RISING_EDGE );
diff -Nru a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
--- a/drivers/macintosh/adbhid.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/macintosh/adbhid.c	Tue Oct  8 15:25:03 2002
@@ -479,6 +479,8 @@
 	memset(adbhid[id], 0, sizeof(struct adbhid));
 	sprintf(adbhid[id]->phys, "adb%d:%d.%02x/input", id, default_id, original_handler_id);
 
+	init_input_dev(&adbhid[id]);
+
 	adbhid[id]->id = default_id;
 	adbhid[id]->original_handler_id = original_handler_id;
 	adbhid[id]->current_handler_id = current_handler_id;
diff -Nru a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
--- a/drivers/macintosh/mac_hid.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/macintosh/mac_hid.c	Tue Oct  8 15:25:03 2002
@@ -91,6 +91,8 @@
 {
 	emumousebtn.name = "Macintosh mouse button emulation";
 
+	init_input_dev(&emumousebtn);
+
 	emumousebtn.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
 	emumousebtn.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 	emumousebtn.relbit[0] = BIT(REL_X) | BIT(REL_Y);
diff -Nru a/drivers/usb/input/powermate.c b/drivers/usb/input/powermate.c
--- a/drivers/usb/input/powermate.c	Tue Oct  8 15:25:03 2002
+++ b/drivers/usb/input/powermate.c	Tue Oct  8 15:25:03 2002
@@ -317,6 +317,7 @@
 	}
 
 	init_MUTEX(&pm->lock);
+	init_input_dev(&pm->input);
 
 	/* get a handle to the interrupt data pipe */
 	pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Tue Oct  8 15:25:03 2002
+++ b/include/linux/input.h	Tue Oct  8 15:25:03 2002
@@ -744,6 +744,8 @@
 #define INPUT_KEYCODE(dev, scancode) ((dev->keycodesize == 1) ? ((u8*)dev->keycode)[scancode] : \
 	((dev->keycodesize == 1) ? ((u16*)dev->keycode)[scancode] : (((u32*)dev->keycode)[scancode])))
 
+#define init_input_dev(dev)	do { INIT_LIST_HEAD(&((dev)->h_list)); INIT_LIST_HEAD(&((dev)->node)); } while (0)
+
 struct input_dev {
 
 	void *private;

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.58
## Wrapped with gzip_uu ##


begin 664 bkpatch17835
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
*^B\SRB*[RDX`````
`
end
