Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbVIOHQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbVIOHQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbVIOHQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:16:27 -0400
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:9134 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030459AbVIOHQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:16:08 -0400
Message-Id: <20050915064944.593949000.dtor_core@ameritech.net>
References: <20050915064552.836273000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 01:46:06 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de>,
Kay Sievers <kay.sievers@vrfy.org>,
Vojtech Pavlik <vojtech@suse.cz>,
Hannes Reinecke <hare@suse.de>
Subject: [patch 14/28] drivers/input/keyboard: convert to dynamic input_dev allocation
Content-Disposition: inline; filename=input-dynalloc-keyboard.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Input: convert drivers/input/keyboard to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/amikbd.c     |   59 +++++------
 drivers/input/keyboard/atkbd.c      |  188 +++++++++++++++++++-----------------
 drivers/input/keyboard/corgikbd.c   |   74 +++++++-------
 drivers/input/keyboard/lkkbd.c      |  126 ++++++++++++------------
 drivers/input/keyboard/maple_keyb.c |   76 ++++++--------
 drivers/input/keyboard/newtonkbd.c  |   83 +++++++--------
 drivers/input/keyboard/spitzkbd.c   |   77 ++++++++------
 drivers/input/keyboard/sunkbd.c     |  117 +++++++++++-----------
 drivers/input/keyboard/xtkbd.c      |   82 +++++++--------
 9 files changed, 450 insertions(+), 432 deletions(-)

Index: work/drivers/input/keyboard/atkbd.c
===================================================================
--- work.orig/drivers/input/keyboard/atkbd.c
+++ work/drivers/input/keyboard/atkbd.c
@@ -185,12 +185,12 @@ static struct {
 
 struct atkbd {
 
-	struct ps2dev	ps2dev;
+	struct ps2dev ps2dev;
+	struct input_dev *dev;
 
 	/* Written only during init */
 	char name[64];
 	char phys[32];
-	struct input_dev dev;
 
 	unsigned short id;
 	unsigned char keycode[512];
@@ -290,7 +290,7 @@ static irqreturn_t atkbd_interrupt(struc
 	if (!atkbd->enabled)
 		goto out;
 
-	input_event(&atkbd->dev, EV_MSC, MSC_RAW, code);
+	input_event(atkbd->dev, EV_MSC, MSC_RAW, code);
 
 	if (atkbd->translated) {
 
@@ -326,10 +326,10 @@ static irqreturn_t atkbd_interrupt(struc
 			atkbd->release = 1;
 			goto out;
 		case ATKBD_RET_HANGUEL:
-			atkbd_report_key(&atkbd->dev, regs, KEY_HANGUEL, 3);
+			atkbd_report_key(atkbd->dev, regs, KEY_HANGUEL, 3);
 			goto out;
 		case ATKBD_RET_HANJA:
-			atkbd_report_key(&atkbd->dev, regs, KEY_HANJA, 3);
+			atkbd_report_key(atkbd->dev, regs, KEY_HANJA, 3);
 			goto out;
 		case ATKBD_RET_ERR:
 			printk(KERN_DEBUG "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
@@ -345,7 +345,7 @@ static irqreturn_t atkbd_interrupt(struc
 	}
 
 	if (atkbd->keycode[code] != ATKBD_KEY_NULL)
-		input_event(&atkbd->dev, EV_MSC, MSC_SCAN, code);
+		input_event(atkbd->dev, EV_MSC, MSC_SCAN, code);
 
 	switch (atkbd->keycode[code]) {
 		case ATKBD_KEY_NULL:
@@ -365,7 +365,7 @@ static irqreturn_t atkbd_interrupt(struc
 				       "to make it known.\n",
 				       code & 0x80 ? "e0" : "", code & 0x7f);
 			}
-			input_sync(&atkbd->dev);
+			input_sync(atkbd->dev);
 			break;
 		case ATKBD_SCR_1:
 			scroll = 1 - atkbd->release * 2;
@@ -390,7 +390,7 @@ static irqreturn_t atkbd_interrupt(struc
 			break;
 		default:
 			value = atkbd->release ? 0 :
-				(1 + (!atkbd->softrepeat && test_bit(atkbd->keycode[code], atkbd->dev.key)));
+				(1 + (!atkbd->softrepeat && test_bit(atkbd->keycode[code], atkbd->dev->key)));
 
 			switch (value) {	/* Workaround Toshiba laptop multiple keypress */
 				case 0:
@@ -398,7 +398,7 @@ static irqreturn_t atkbd_interrupt(struc
 					break;
 				case 1:
 					atkbd->last = code;
-					atkbd->time = jiffies + msecs_to_jiffies(atkbd->dev.rep[REP_DELAY]) / 2;
+					atkbd->time = jiffies + msecs_to_jiffies(atkbd->dev->rep[REP_DELAY]) / 2;
 					break;
 				case 2:
 					if (!time_after(jiffies, atkbd->time) && atkbd->last == code)
@@ -406,16 +406,16 @@ static irqreturn_t atkbd_interrupt(struc
 					break;
 			}
 
-			atkbd_report_key(&atkbd->dev, regs, atkbd->keycode[code], value);
+			atkbd_report_key(atkbd->dev, regs, atkbd->keycode[code], value);
 	}
 
 	if (atkbd->scroll) {
-		input_regs(&atkbd->dev, regs);
+		input_regs(atkbd->dev, regs);
 		if (click != -1)
-			input_report_key(&atkbd->dev, BTN_MIDDLE, click);
-		input_report_rel(&atkbd->dev, REL_WHEEL, scroll);
-		input_report_rel(&atkbd->dev, REL_HWHEEL, hscroll);
-		input_sync(&atkbd->dev);
+			input_report_key(atkbd->dev, BTN_MIDDLE, click);
+		input_report_rel(atkbd->dev, REL_WHEEL, scroll);
+		input_report_rel(atkbd->dev, REL_HWHEEL, hscroll);
+		input_sync(atkbd->dev);
 	}
 
 	atkbd->release = 0;
@@ -463,7 +463,6 @@ static int atkbd_event(struct input_dev 
 
 			return 0;
 
-
 		case EV_REP:
 
 			if (atkbd->softrepeat) return 0;
@@ -693,7 +692,7 @@ static void atkbd_disconnect(struct seri
 	device_remove_file(&serio->dev, &atkbd_attr_softrepeat);
 	device_remove_file(&serio->dev, &atkbd_attr_softraw);
 
-	input_unregister_device(&atkbd->dev);
+	input_unregister_device(atkbd->dev);
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
 	kfree(atkbd);
@@ -701,7 +700,7 @@ static void atkbd_disconnect(struct seri
 
 
 /*
- * atkbd_set_device_attrs() initializes keyboard's keycode table
+ * atkbd_set_keycode_table() initializes keyboard's keycode table
  * according to the selected scancode set
  */
 
@@ -737,53 +736,58 @@ static void atkbd_set_keycode_table(stru
 
 static void atkbd_set_device_attrs(struct atkbd *atkbd)
 {
+	struct input_dev *input_dev = atkbd->dev;
 	int i;
 
-	memset(&atkbd->dev, 0, sizeof(struct input_dev));
+	if (atkbd->extra)
+		sprintf(atkbd->name, "AT Set 2 Extra keyboard");
+	else
+		sprintf(atkbd->name, "AT %s Set %d keyboard",
+			atkbd->translated ? "Translated" : "Raw", atkbd->set);
 
-	init_input_dev(&atkbd->dev);
+	sprintf(atkbd->phys, "%s/input0", atkbd->ps2dev.serio->phys);
 
-	atkbd->dev.name = atkbd->name;
-	atkbd->dev.phys = atkbd->phys;
-	atkbd->dev.id.bustype = BUS_I8042;
-	atkbd->dev.id.vendor = 0x0001;
-	atkbd->dev.id.product = atkbd->translated ? 1 : atkbd->set;
-	atkbd->dev.id.version = atkbd->id;
-	atkbd->dev.event = atkbd_event;
-	atkbd->dev.private = atkbd;
-	atkbd->dev.dev = &atkbd->ps2dev.serio->dev;
+	input_dev->name = atkbd->name;
+	input_dev->phys = atkbd->phys;
+	input_dev->id.bustype = BUS_I8042;
+	input_dev->id.vendor = 0x0001;
+	input_dev->id.product = atkbd->translated ? 1 : atkbd->set;
+	input_dev->id.version = atkbd->id;
+	input_dev->event = atkbd_event;
+	input_dev->private = atkbd;
+	input_dev->cdev.dev = &atkbd->ps2dev.serio->dev;
 
-	atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_MSC);
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_MSC);
 
 	if (atkbd->write) {
-		atkbd->dev.evbit[0] |= BIT(EV_LED);
-		atkbd->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
+		input_dev->evbit[0] |= BIT(EV_LED);
+		input_dev->ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
 	}
 
 	if (atkbd->extra)
-		atkbd->dev.ledbit[0] |= BIT(LED_COMPOSE) | BIT(LED_SUSPEND) |
+		input_dev->ledbit[0] |= BIT(LED_COMPOSE) | BIT(LED_SUSPEND) |
 					BIT(LED_SLEEP) | BIT(LED_MUTE) | BIT(LED_MISC);
 
 	if (!atkbd->softrepeat) {
-		atkbd->dev.rep[REP_DELAY] = 250;
-		atkbd->dev.rep[REP_PERIOD] = 33;
+		input_dev->rep[REP_DELAY] = 250;
+		input_dev->rep[REP_PERIOD] = 33;
 	}
 
-	atkbd->dev.mscbit[0] = atkbd->softraw ? BIT(MSC_SCAN) : BIT(MSC_RAW) | BIT(MSC_SCAN);
+	input_dev->mscbit[0] = atkbd->softraw ? BIT(MSC_SCAN) : BIT(MSC_RAW) | BIT(MSC_SCAN);
 
 	if (atkbd->scroll) {
-		atkbd->dev.evbit[0] |= BIT(EV_REL);
-		atkbd->dev.relbit[0] = BIT(REL_WHEEL) | BIT(REL_HWHEEL);
-		set_bit(BTN_MIDDLE, atkbd->dev.keybit);
+		input_dev->evbit[0] |= BIT(EV_REL);
+		input_dev->relbit[0] = BIT(REL_WHEEL) | BIT(REL_HWHEEL);
+		set_bit(BTN_MIDDLE, input_dev->keybit);
 	}
 
-	atkbd->dev.keycode = atkbd->keycode;
-	atkbd->dev.keycodesize = sizeof(unsigned char);
-	atkbd->dev.keycodemax = ARRAY_SIZE(atkbd_set2_keycode);
+	input_dev->keycode = atkbd->keycode;
+	input_dev->keycodesize = sizeof(unsigned char);
+	input_dev->keycodemax = ARRAY_SIZE(atkbd_set2_keycode);
 
 	for (i = 0; i < 512; i++)
 		if (atkbd->keycode[i] && atkbd->keycode[i] < ATKBD_SPECIAL)
-			set_bit(atkbd->keycode[i], atkbd->dev.keybit);
+			set_bit(atkbd->keycode[i], input_dev->keybit);
 }
 
 /*
@@ -796,13 +800,15 @@ static void atkbd_set_device_attrs(struc
 static int atkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct atkbd *atkbd;
-	int err;
-
-	if (!(atkbd = kmalloc(sizeof(struct atkbd), GFP_KERNEL)))
-		return - ENOMEM;
+	struct input_dev *dev;
+	int err = -ENOMEM;
 
-	memset(atkbd, 0, sizeof(struct atkbd));
+	atkbd = kzalloc(sizeof(struct atkbd), GFP_KERNEL);
+	dev = input_allocate_device();
+	if (!atkbd || !dev)
+		goto fail;
 
+	atkbd->dev = dev;
 	ps2_init(&atkbd->ps2dev, serio);
 
 	switch (serio->id.type) {
@@ -828,19 +834,15 @@ static int atkbd_connect(struct serio *s
 	serio_set_drvdata(serio, atkbd);
 
 	err = serio_open(serio, drv);
-	if (err) {
-		serio_set_drvdata(serio, NULL);
-		kfree(atkbd);
-		return err;
-	}
+	if (err)
+		goto fail;
 
 	if (atkbd->write) {
 
 		if (atkbd_probe(atkbd)) {
 			serio_close(serio);
-			serio_set_drvdata(serio, NULL);
-			kfree(atkbd);
-			return -ENODEV;
+			err = -ENODEV;
+			goto fail;
 		}
 
 		atkbd->set = atkbd_select_set(atkbd, atkbd_set, atkbd_extra);
@@ -851,19 +853,9 @@ static int atkbd_connect(struct serio *s
 		atkbd->id = 0xab00;
 	}
 
-	if (atkbd->extra)
-		sprintf(atkbd->name, "AT Set 2 Extra keyboard");
-	else
-		sprintf(atkbd->name, "AT %s Set %d keyboard",
-			atkbd->translated ? "Translated" : "Raw", atkbd->set);
-
-	sprintf(atkbd->phys, "%s/input0", serio->phys);
-
 	atkbd_set_keycode_table(atkbd);
 	atkbd_set_device_attrs(atkbd);
 
-	input_register_device(&atkbd->dev);
-
 	device_create_file(&serio->dev, &atkbd_attr_extra);
 	device_create_file(&serio->dev, &atkbd_attr_scroll);
 	device_create_file(&serio->dev, &atkbd_attr_set);
@@ -872,9 +864,14 @@ static int atkbd_connect(struct serio *s
 
 	atkbd_enable(atkbd);
 
-	printk(KERN_INFO "input: %s on %s\n", atkbd->name, serio->phys);
+	input_register_device(atkbd->dev);
 
 	return 0;
+
+ fail:	serio_set_drvdata(serio, NULL);
+	input_free_device(dev);
+	kfree(atkbd);
+	return err;
 }
 
 /*
@@ -896,9 +893,9 @@ static int atkbd_reconnect(struct serio 
 	atkbd_disable(atkbd);
 
 	if (atkbd->write) {
-		param[0] = (test_bit(LED_SCROLLL, atkbd->dev.led) ? 1 : 0)
-		         | (test_bit(LED_NUML,    atkbd->dev.led) ? 2 : 0)
-		         | (test_bit(LED_CAPSL,   atkbd->dev.led) ? 4 : 0);
+		param[0] = (test_bit(LED_SCROLLL, atkbd->dev->led) ? 1 : 0)
+		         | (test_bit(LED_NUML,    atkbd->dev->led) ? 2 : 0)
+		         | (test_bit(LED_CAPSL,   atkbd->dev->led) ? 4 : 0);
 
 		if (atkbd_probe(atkbd))
 			return -1;
@@ -1008,6 +1005,7 @@ static ssize_t atkbd_show_extra(struct a
 
 static ssize_t atkbd_set_extra(struct atkbd *atkbd, const char *buf, size_t count)
 {
+	struct input_dev *new_dev;
 	unsigned long value;
 	char *rest;
 
@@ -1019,12 +1017,19 @@ static ssize_t atkbd_set_extra(struct at
 		return -EINVAL;
 
 	if (atkbd->extra != value) {
-		/* unregister device as it's properties will change */
-		input_unregister_device(&atkbd->dev);
+		/*
+		 * Since device's properties will change we need to
+		 * unregister old device. But allocate new one first
+		 * to make sure we have it.
+		 */
+		if (!(new_dev = input_allocate_device()))
+			return -ENOMEM;
+		input_unregister_device(atkbd->dev);
+		atkbd->dev = new_dev;
 		atkbd->set = atkbd_select_set(atkbd, atkbd->set, value);
 		atkbd_activate(atkbd);
 		atkbd_set_device_attrs(atkbd);
-		input_register_device(&atkbd->dev);
+		input_register_device(atkbd->dev);
 	}
 	return count;
 }
@@ -1036,6 +1041,7 @@ static ssize_t atkbd_show_scroll(struct 
 
 static ssize_t atkbd_set_scroll(struct atkbd *atkbd, const char *buf, size_t count)
 {
+	struct input_dev *new_dev;
 	unsigned long value;
 	char *rest;
 
@@ -1044,12 +1050,14 @@ static ssize_t atkbd_set_scroll(struct a
 		return -EINVAL;
 
 	if (atkbd->scroll != value) {
-		/* unregister device as it's properties will change */
-		input_unregister_device(&atkbd->dev);
+		if (!(new_dev = input_allocate_device()))
+			return -ENOMEM;
+		input_unregister_device(atkbd->dev);
+		atkbd->dev = new_dev;
 		atkbd->scroll = value;
 		atkbd_set_keycode_table(atkbd);
 		atkbd_set_device_attrs(atkbd);
-		input_register_device(&atkbd->dev);
+		input_register_device(atkbd->dev);
 	}
 	return count;
 }
@@ -1061,6 +1069,7 @@ static ssize_t atkbd_show_set(struct atk
 
 static ssize_t atkbd_set_set(struct atkbd *atkbd, const char *buf, size_t count)
 {
+	struct input_dev *new_dev;
 	unsigned long value;
 	char *rest;
 
@@ -1072,13 +1081,15 @@ static ssize_t atkbd_set_set(struct atkb
 		return -EINVAL;
 
 	if (atkbd->set != value) {
-		/* unregister device as it's properties will change */
-		input_unregister_device(&atkbd->dev);
+		if (!(new_dev = input_allocate_device()))
+			return -ENOMEM;
+		input_unregister_device(atkbd->dev);
+		atkbd->dev = new_dev;
 		atkbd->set = atkbd_select_set(atkbd, value, atkbd->extra);
 		atkbd_activate(atkbd);
 		atkbd_set_keycode_table(atkbd);
 		atkbd_set_device_attrs(atkbd);
-		input_register_device(&atkbd->dev);
+		input_register_device(atkbd->dev);
 	}
 	return count;
 }
@@ -1090,6 +1101,7 @@ static ssize_t atkbd_show_softrepeat(str
 
 static ssize_t atkbd_set_softrepeat(struct atkbd *atkbd, const char *buf, size_t count)
 {
+	struct input_dev *new_dev;
 	unsigned long value;
 	char *rest;
 
@@ -1101,15 +1113,16 @@ static ssize_t atkbd_set_softrepeat(stru
 		return -EINVAL;
 
 	if (atkbd->softrepeat != value) {
-		/* unregister device as it's properties will change */
-		input_unregister_device(&atkbd->dev);
+		if (!(new_dev = input_allocate_device()))
+			return -ENOMEM;
+		input_unregister_device(atkbd->dev);
+		atkbd->dev = new_dev;
 		atkbd->softrepeat = value;
 		if (atkbd->softrepeat)
 			atkbd->softraw = 1;
 		atkbd_set_device_attrs(atkbd);
-		input_register_device(&atkbd->dev);
+		input_register_device(atkbd->dev);
 	}
-
 	return count;
 }
 
@@ -1121,6 +1134,7 @@ static ssize_t atkbd_show_softraw(struct
 
 static ssize_t atkbd_set_softraw(struct atkbd *atkbd, const char *buf, size_t count)
 {
+	struct input_dev *new_dev;
 	unsigned long value;
 	char *rest;
 
@@ -1129,11 +1143,13 @@ static ssize_t atkbd_set_softraw(struct 
 		return -EINVAL;
 
 	if (atkbd->softraw != value) {
-		/* unregister device as it's properties will change */
-		input_unregister_device(&atkbd->dev);
+		if (!(new_dev = input_allocate_device()))
+			return -ENOMEM;
+		input_unregister_device(atkbd->dev);
+		atkbd->dev = new_dev;
 		atkbd->softraw = value;
 		atkbd_set_device_attrs(atkbd);
-		input_register_device(&atkbd->dev);
+		input_register_device(atkbd->dev);
 	}
 	return count;
 }
Index: work/drivers/input/keyboard/amikbd.c
===================================================================
--- work.orig/drivers/input/keyboard/amikbd.c
+++ work/drivers/input/keyboard/amikbd.c
@@ -155,10 +155,7 @@ static const char *amikbd_messages[8] = 
 	[7] = KERN_WARNING "amikbd: keyboard interrupt\n"
 };
 
-static struct input_dev amikbd_dev;
-
-static char *amikbd_name = "Amiga keyboard";
-static char *amikbd_phys = "amikbd/input0";
+static struct input_dev *amikbd_dev;
 
 static irqreturn_t amikbd_interrupt(int irq, void *dummy, struct pt_regs *fp)
 {
@@ -176,16 +173,16 @@ static irqreturn_t amikbd_interrupt(int 
 
 		scancode = amikbd_keycode[scancode];
 
-		input_regs(&amikbd_dev, fp);
+		input_regs(amikbd_dev, fp);
 
 		if (scancode == KEY_CAPSLOCK) {	/* CapsLock is a toggle switch key on Amiga */
-			input_report_key(&amikbd_dev, scancode, 1);
-			input_report_key(&amikbd_dev, scancode, 0);
-			input_sync(&amikbd_dev);
+			input_report_key(amikbd_dev, scancode, 1);
+			input_report_key(amikbd_dev, scancode, 0);
 		} else {
-			input_report_key(&amikbd_dev, scancode, down);
-			input_sync(&amikbd_dev);
+			input_report_key(amikbd_dev, scancode, down);
 		}
+
+		input_sync(amikbd_dev);
 	} else				/* scancodes >= 0x78 are error codes */
 		printk(amikbd_messages[scancode - 0x78]);
 
@@ -202,39 +199,41 @@ static int __init amikbd_init(void)
 	if (!request_mem_region(CIAA_PHYSADDR-1+0xb00, 0x100, "amikeyb"))
 		return -EBUSY;
 
-	init_input_dev(&amikbd_dev);
-
-	amikbd_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
-	amikbd_dev.keycode = amikbd_keycode;
-	amikbd_dev.keycodesize = sizeof(unsigned char);
-	amikbd_dev.keycodemax = ARRAY_SIZE(amikbd_keycode);
+	amikbd_dev = input_dev_allocate();
+	if (!amikbd_dev) {
+		printk(KERN_ERR "amikbd: not enough memory for input device\n");
+		release_mem_region(CIAA_PHYSADDR - 1 + 0xb00, 0x100);
+		return -ENOMEM;
+	}
+
+	amikbd_dev->name = "Amiga Keyboard";
+	amikbd_dev->phys = "amikbd/input0";
+	amikbd_dev->id.bustype = BUS_AMIGA;
+	amikbd_dev->id.vendor = 0x0001;
+	amikbd_dev->id.product = 0x0001;
+	amikbd_dev->id.version = 0x0100;
+
+	amikbd_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	amikbd_dev->keycode = amikbd_keycode;
+	amikbd_dev->keycodesize = sizeof(unsigned char);
+	amikbd_dev->keycodemax = ARRAY_SIZE(amikbd_keycode);
 
 	for (i = 0; i < 0x78; i++)
 		if (amikbd_keycode[i])
-			set_bit(amikbd_keycode[i], amikbd_dev.keybit);
+			set_bit(amikbd_keycode[i], amikbd_dev->keybit);
 
 	ciaa.cra &= ~0x41;	 /* serial data in, turn off TA */
 	request_irq(IRQ_AMIGA_CIAA_SP, amikbd_interrupt, 0, "amikbd", amikbd_interrupt);
 
-	amikbd_dev.name = amikbd_name;
-	amikbd_dev.phys = amikbd_phys;
-	amikbd_dev.id.bustype = BUS_AMIGA;
-	amikbd_dev.id.vendor = 0x0001;
-	amikbd_dev.id.product = 0x0001;
-	amikbd_dev.id.version = 0x0100;
-
-	input_register_device(&amikbd_dev);
-
-	printk(KERN_INFO "input: %s\n", amikbd_name);
-
+	input_register_device(amikbd_dev);
 	return 0;
 }
 
 static void __exit amikbd_exit(void)
 {
-	input_unregister_device(&amikbd_dev);
 	free_irq(IRQ_AMIGA_CIAA_SP, amikbd_interrupt);
-	release_mem_region(CIAA_PHYSADDR-1+0xb00, 0x100);
+	input_unregister_device(amikbd_dev);
+	release_mem_region(CIAA_PHYSADDR - 1 + 0xb00, 0x100);
 }
 
 module_init(amikbd_init);
Index: work/drivers/input/keyboard/lkkbd.c
===================================================================
--- work.orig/drivers/input/keyboard/lkkbd.c
+++ work/drivers/input/keyboard/lkkbd.c
@@ -102,7 +102,7 @@ static int ctrlclick_volume = 100; /* % 
 module_param (ctrlclick_volume, int, 0);
 MODULE_PARM_DESC (ctrlclick_volume, "Ctrlclick volume (in %), default is 100%");
 
-static int lk201_compose_is_alt = 0;
+static int lk201_compose_is_alt;
 module_param (lk201_compose_is_alt, int, 0);
 MODULE_PARM_DESC (lk201_compose_is_alt, "If set non-zero, LK201' Compose key "
 		"will act as an Alt key");
@@ -274,7 +274,7 @@ static lk_keycode_t lkkbd_keycode[LK_NUM
 };
 
 #define CHECK_LED(LED, BITS) do {		\
-	if (test_bit (LED, lk->dev.led))	\
+	if (test_bit (LED, lk->dev->led))	\
 		leds_on |= BITS;		\
 	else					\
 		leds_off |= BITS;		\
@@ -287,7 +287,7 @@ struct lkkbd {
 	lk_keycode_t keycode[LK_NUM_KEYCODES];
 	int ignore_bytes;
 	unsigned char id[LK_NUM_IGNORE_BYTES];
-	struct input_dev dev;
+	struct input_dev *dev;
 	struct serio *serio;
 	struct work_struct tq;
 	char name[64];
@@ -423,8 +423,7 @@ lkkbd_interrupt (struct serio *serio, un
 	DBG (KERN_INFO "Got byte 0x%02x\n", data);
 
 	if (lk->ignore_bytes > 0) {
-		DBG (KERN_INFO "Ignoring a byte on %s\n",
-				lk->name);
+		DBG (KERN_INFO "Ignoring a byte on %s\n", lk->name);
 		lk->id[LK_NUM_IGNORE_BYTES - lk->ignore_bytes--] = data;
 
 		if (lk->ignore_bytes == 0)
@@ -435,14 +434,14 @@ lkkbd_interrupt (struct serio *serio, un
 
 	switch (data) {
 		case LK_ALL_KEYS_UP:
-			input_regs (&lk->dev, regs);
+			input_regs (lk->dev, regs);
 			for (i = 0; i < ARRAY_SIZE (lkkbd_keycode); i++)
 				if (lk->keycode[i] != KEY_RESERVED)
-					input_report_key (&lk->dev, lk->keycode[i], 0);
-			input_sync (&lk->dev);
+					input_report_key (lk->dev, lk->keycode[i], 0);
+			input_sync (lk->dev);
 			break;
 		case LK_METRONOME:
-			DBG (KERN_INFO "Got LK_METRONOME and don't "
+			DBG (KERN_INFO "Got %#d and don't "
 					"know how to handle...\n");
 			break;
 		case LK_OUTPUT_ERROR:
@@ -482,12 +481,12 @@ lkkbd_interrupt (struct serio *serio, un
 
 		default:
 			if (lk->keycode[data] != KEY_RESERVED) {
-				input_regs (&lk->dev, regs);
-				if (!test_bit (lk->keycode[data], lk->dev.key))
-					input_report_key (&lk->dev, lk->keycode[data], 1);
+				input_regs (lk->dev, regs);
+				if (!test_bit (lk->keycode[data], lk->dev->key))
+					input_report_key (lk->dev, lk->keycode[data], 1);
 				else
-					input_report_key (&lk->dev, lk->keycode[data], 0);
-				input_sync (&lk->dev);
+					input_report_key (lk->dev, lk->keycode[data], 0);
+				input_sync (lk->dev);
                         } else
                                 printk (KERN_WARNING "%s: Unknown key with "
 						"scancode 0x%02x on %s.\n",
@@ -605,7 +604,7 @@ lkkbd_reinit (void *data)
 	lk->serio->write (lk->serio, volume_to_hw (lk->bell_volume));
 
 	/* Enable/disable keyclick (and possibly set volume) */
-	if (test_bit (SND_CLICK, lk->dev.snd)) {
+	if (test_bit (SND_CLICK, lk->dev->snd)) {
 		lk->serio->write (lk->serio, LK_CMD_ENABLE_KEYCLICK);
 		lk->serio->write (lk->serio, volume_to_hw (lk->keyclick_volume));
 		lk->serio->write (lk->serio, LK_CMD_ENABLE_CTRCLICK);
@@ -616,7 +615,7 @@ lkkbd_reinit (void *data)
 	}
 
 	/* Sound the bell if needed */
-	if (test_bit (SND_BELL, lk->dev.snd))
+	if (test_bit (SND_BELL, lk->dev->snd))
 		lk->serio->write (lk->serio, LK_CMD_SOUND_BELL);
 }
 
@@ -627,71 +626,70 @@ static int
 lkkbd_connect (struct serio *serio, struct serio_driver *drv)
 {
 	struct lkkbd *lk;
+	struct input_dev *input_dev;
 	int i;
 	int err;
 
-	if (!(lk = kmalloc (sizeof (struct lkkbd), GFP_KERNEL)))
-		return -ENOMEM;
-
-	memset (lk, 0, sizeof (struct lkkbd));
-
-	init_input_dev (&lk->dev);
-	set_bit (EV_KEY, lk->dev.evbit);
-	set_bit (EV_LED, lk->dev.evbit);
-	set_bit (EV_SND, lk->dev.evbit);
-	set_bit (EV_REP, lk->dev.evbit);
-	set_bit (LED_CAPSL, lk->dev.ledbit);
-	set_bit (LED_SLEEP, lk->dev.ledbit);
-	set_bit (LED_COMPOSE, lk->dev.ledbit);
-	set_bit (LED_SCROLLL, lk->dev.ledbit);
-	set_bit (SND_BELL, lk->dev.sndbit);
-	set_bit (SND_CLICK, lk->dev.sndbit);
+	lk = kzalloc (sizeof (struct lkkbd), GFP_KERNEL);
+	input_dev = input_allocate_device ();
+	if (!lk || !input_dev) {
+		err = -ENOMEM;
+		goto fail;
+	}
 
 	lk->serio = serio;
-
+	lk->dev = input_dev;
 	INIT_WORK (&lk->tq, lkkbd_reinit, lk);
-
 	lk->bell_volume = bell_volume;
 	lk->keyclick_volume = keyclick_volume;
 	lk->ctrlclick_volume = ctrlclick_volume;
+	memcpy (lk->keycode, lkkbd_keycode, sizeof (lk_keycode_t) * LK_NUM_KEYCODES);
 
-	lk->dev.keycode = lk->keycode;
-	lk->dev.keycodesize = sizeof (lk_keycode_t);
-	lk->dev.keycodemax = LK_NUM_KEYCODES;
+	strlcpy (lk->name, "DEC LK keyboard", sizeof(lk->name));
+	snprintf (lk->phys, sizeof(lk->phys), "%s/input0", serio->phys);
 
-	lk->dev.event = lkkbd_event;
-	lk->dev.private = lk;
+	input_dev->name = lk->name;
+	input_dev->phys = lk->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->id.vendor = SERIO_LKKBD;
+	input_dev->id.product = 0;
+	input_dev->id.version = 0x0100;
+	input_dev->cdev.dev = &serio->dev;
+	input_dev->event = lkkbd_event;
+	input_dev->private = lk;
+
+	set_bit (EV_KEY, input_dev->evbit);
+	set_bit (EV_LED, input_dev->evbit);
+	set_bit (EV_SND, input_dev->evbit);
+	set_bit (EV_REP, input_dev->evbit);
+	set_bit (LED_CAPSL, input_dev->ledbit);
+	set_bit (LED_SLEEP, input_dev->ledbit);
+	set_bit (LED_COMPOSE, input_dev->ledbit);
+	set_bit (LED_SCROLLL, input_dev->ledbit);
+	set_bit (SND_BELL, input_dev->sndbit);
+	set_bit (SND_CLICK, input_dev->sndbit);
+
+	input_dev->keycode = lk->keycode;
+	input_dev->keycodesize = sizeof (lk_keycode_t);
+	input_dev->keycodemax = LK_NUM_KEYCODES;
+	for (i = 0; i < LK_NUM_KEYCODES; i++)
+		set_bit (lk->keycode[i], input_dev->keybit);
 
 	serio_set_drvdata (serio, lk);
 
 	err = serio_open (serio, drv);
-	if (err) {
-		serio_set_drvdata (serio, NULL);
-		kfree (lk);
-		return err;
-	}
+	if (err)
+		goto fail;
 
-	sprintf (lk->name, "DEC LK keyboard");
-	sprintf (lk->phys, "%s/input0", serio->phys);
-
-	memcpy (lk->keycode, lkkbd_keycode, sizeof (lk_keycode_t) * LK_NUM_KEYCODES);
-	for (i = 0; i < LK_NUM_KEYCODES; i++)
-		set_bit (lk->keycode[i], lk->dev.keybit);
-
-	lk->dev.name = lk->name;
-	lk->dev.phys = lk->phys;
-	lk->dev.id.bustype = BUS_RS232;
-	lk->dev.id.vendor = SERIO_LKKBD;
-	lk->dev.id.product = 0;
-	lk->dev.id.version = 0x0100;
-	lk->dev.dev = &serio->dev;
-
-	input_register_device (&lk->dev);
-
-	printk (KERN_INFO "input: %s on %s, initiating reset\n", lk->name, serio->phys);
+	input_register_device (lk->dev);
 	lk->serio->write (lk->serio, LK_CMD_POWERCYCLE_RESET);
 
 	return 0;
+
+ fail:	serio_set_drvdata (serio, NULL);
+	input_free_device (input_dev);
+	kfree (lk);
+	return err;
 }
 
 /*
@@ -702,9 +700,11 @@ lkkbd_disconnect (struct serio *serio)
 {
 	struct lkkbd *lk = serio_get_drvdata (serio);
 
-	input_unregister_device (&lk->dev);
+	input_get_device (lk->dev);
+	input_unregister_device (lk->dev);
 	serio_close (serio);
 	serio_set_drvdata (serio, NULL);
+	input_put_device (lk->dev);
 	kfree (lk);
 }
 
Index: work/drivers/input/keyboard/corgikbd.c
===================================================================
--- work.orig/drivers/input/keyboard/corgikbd.c
+++ work/drivers/input/keyboard/corgikbd.c
@@ -70,8 +70,7 @@ static unsigned char corgikbd_keycode[NR
 
 struct corgikbd {
 	unsigned char keycode[ARRAY_SIZE(corgikbd_keycode)];
-	struct input_dev input;
-	char phys[32];
+	struct input_dev *input;
 
 	spinlock_t lock;
 	struct timer_list timer;
@@ -147,7 +146,7 @@ static void corgikbd_scankeyboard(struct
 	spin_lock_irqsave(&corgikbd_data->lock, flags);
 
 	if (regs)
-		input_regs(&corgikbd_data->input, regs);
+		input_regs(corgikbd_data->input, regs);
 
 	num_pressed = 0;
 	for (col = 0; col < KB_COLS; col++) {
@@ -169,14 +168,14 @@ static void corgikbd_scankeyboard(struct
 			scancode = SCANCODE(row, col);
 			pressed = rowd & KB_ROWMASK(row);
 
-			input_report_key(&corgikbd_data->input, corgikbd_data->keycode[scancode], pressed);
+			input_report_key(corgikbd_data->input, corgikbd_data->keycode[scancode], pressed);
 
 			if (pressed)
 				num_pressed++;
 
 			if (pressed && (corgikbd_data->keycode[scancode] == CORGI_KEY_OFF)
 					&& time_after(jiffies, corgikbd_data->suspend_jiffies + HZ)) {
-				input_event(&corgikbd_data->input, EV_PWR, CORGI_KEY_OFF, 1);
+				input_event(corgikbd_data->input, EV_PWR, CORGI_KEY_OFF, 1);
 				corgikbd_data->suspend_jiffies=jiffies;
 			}
 		}
@@ -185,7 +184,7 @@ static void corgikbd_scankeyboard(struct
 
 	corgikbd_activate_all();
 
-	input_sync(&corgikbd_data->input);
+	input_sync(corgikbd_data->input);
 
 	/* if any keys are pressed, enable the timer */
 	if (num_pressed)
@@ -249,9 +248,9 @@ static void corgikbd_hinge_timer(unsigne
 		if (hinge_count >= HINGE_STABLE_COUNT) {
 			spin_lock_irqsave(&corgikbd_data->lock, flags);
 
-			input_report_switch(&corgikbd_data->input, SW_0, ((sharpsl_hinge_state & CORGI_SCP_SWA) != 0));
-			input_report_switch(&corgikbd_data->input, SW_1, ((sharpsl_hinge_state & CORGI_SCP_SWB) != 0));
-			input_sync(&corgikbd_data->input);
+			input_report_switch(corgikbd_data->input, SW_0, ((sharpsl_hinge_state & CORGI_SCP_SWA) != 0));
+			input_report_switch(corgikbd_data->input, SW_1, ((sharpsl_hinge_state & CORGI_SCP_SWB) != 0));
+			input_sync(corgikbd_data->input);
 
 			spin_unlock_irqrestore(&corgikbd_data->lock, flags);
 		}
@@ -287,16 +286,21 @@ static int corgikbd_resume(struct device
 
 static int __init corgikbd_probe(struct device *dev)
 {
-	int i;
 	struct corgikbd *corgikbd;
+	struct input_dev *input_dev;
+	int i;
 
 	corgikbd = kzalloc(sizeof(struct corgikbd), GFP_KERNEL);
-	if (!corgikbd)
+	input_dev = input_allocate_device();
+	if (!corgikbd || !input_dev) {
+		kfree(corgikbd);
+		input_free_device(input_dev);
 		return -ENOMEM;
+	}
 
-	dev_set_drvdata(dev,corgikbd);
-	strcpy(corgikbd->phys, "corgikbd/input0");
+	dev_set_drvdata(dev, corgikbd);
 
+	corgikbd->input = input_dev;
 	spin_lock_init(&corgikbd->lock);
 
 	/* Init Keyboard rescan timer */
@@ -311,28 +315,30 @@ static int __init corgikbd_probe(struct 
 
 	corgikbd->suspend_jiffies=jiffies;
 
-	init_input_dev(&corgikbd->input);
-	corgikbd->input.private = corgikbd;
-	corgikbd->input.name = "Corgi Keyboard";
-	corgikbd->input.dev = dev;
-	corgikbd->input.phys = corgikbd->phys;
-	corgikbd->input.id.bustype = BUS_HOST;
-	corgikbd->input.id.vendor = 0x0001;
-	corgikbd->input.id.product = 0x0001;
-	corgikbd->input.id.version = 0x0100;
-	corgikbd->input.evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_PWR) | BIT(EV_SW);
-	corgikbd->input.keycode = corgikbd->keycode;
-	corgikbd->input.keycodesize = sizeof(unsigned char);
-	corgikbd->input.keycodemax = ARRAY_SIZE(corgikbd_keycode);
-
 	memcpy(corgikbd->keycode, corgikbd_keycode, sizeof(corgikbd->keycode));
+
+	input_dev->name = "Corgi Keyboard";
+	input_dev->phys = "corgikbd/input0";
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->id.vendor = 0x0001;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
+	input_dev->cdev.dev = dev;
+	input_dev->private = corgikbd;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_PWR) | BIT(EV_SW);
+	input_dev->keycode = corgikbd->keycode;
+	input_dev->keycodesize = sizeof(unsigned char);
+	input_dev->keycodemax = ARRAY_SIZE(corgikbd_keycode);
+
 	for (i = 0; i < ARRAY_SIZE(corgikbd_keycode); i++)
-		set_bit(corgikbd->keycode[i], corgikbd->input.keybit);
-	clear_bit(0, corgikbd->input.keybit);
-	set_bit(SW_0, corgikbd->input.swbit);
-	set_bit(SW_1, corgikbd->input.swbit);
+		set_bit(corgikbd->keycode[i], input_dev->keybit);
+	clear_bit(0, input_dev->keybit);
+	set_bit(SW_0, input_dev->swbit);
+	set_bit(SW_1, input_dev->swbit);
+
+	input_register_device(corgikbd->input);
 
-	input_register_device(&corgikbd->input);
 	mod_timer(&corgikbd->htimer, jiffies + HINGE_SCAN_INTERVAL);
 
 	/* Setup sense interrupts - RisingEdge Detect, sense lines as inputs */
@@ -349,8 +355,6 @@ static int __init corgikbd_probe(struct 
 	for (i = 0; i < CORGI_KEY_STROBE_NUM; i++)
 		pxa_gpio_mode(CORGI_GPIO_KEY_STROBE(i) | GPIO_OUT | GPIO_DFLT_HIGH);
 
-	printk(KERN_INFO "input: Corgi Keyboard Registered\n");
-
 	return 0;
 }
 
@@ -365,7 +369,7 @@ static int corgikbd_remove(struct device
 	del_timer_sync(&corgikbd->htimer);
 	del_timer_sync(&corgikbd->timer);
 
-	input_unregister_device(&corgikbd->input);
+	input_unregister_device(corgikbd->input);
 
 	kfree(corgikbd);
 
Index: work/drivers/input/keyboard/xtkbd.c
===================================================================
--- work.orig/drivers/input/keyboard/xtkbd.c
+++ work/drivers/input/keyboard/xtkbd.c
@@ -56,11 +56,9 @@ static unsigned char xtkbd_keycode[256] 
 	106
 };
 
-static char *xtkbd_name = "XT Keyboard";
-
 struct xtkbd {
 	unsigned char keycode[256];
-	struct input_dev dev;
+	struct input_dev *dev;
 	struct serio *serio;
 	char phys[32];
 };
@@ -77,9 +75,9 @@ static irqreturn_t xtkbd_interrupt(struc
 		default:
 
 			if (xtkbd->keycode[data & XTKBD_KEY]) {
-				input_regs(&xtkbd->dev, regs);
-				input_report_key(&xtkbd->dev, xtkbd->keycode[data & XTKBD_KEY], !(data & XTKBD_RELEASE));
-				input_sync(&xtkbd->dev);
+				input_regs(xtkbd->dev, regs);
+				input_report_key(xtkbd->dev, xtkbd->keycode[data & XTKBD_KEY], !(data & XTKBD_RELEASE));
+				input_sync(xtkbd->dev);
 			} else {
 				printk(KERN_WARNING "xtkbd.c: Unknown key (scancode %#x) %s.\n",
 					data & XTKBD_KEY, data & XTKBD_RELEASE ? "released" : "pressed");
@@ -91,62 +89,60 @@ static irqreturn_t xtkbd_interrupt(struc
 static int xtkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct xtkbd *xtkbd;
+	struct input_dev *input_dev;
+	int err = -ENOMEM;
 	int i;
-	int err;
-
-	if (!(xtkbd = kmalloc(sizeof(struct xtkbd), GFP_KERNEL)))
-		return -ENOMEM;
-
-	memset(xtkbd, 0, sizeof(struct xtkbd));
 
-	xtkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	xtkbd = kmalloc(sizeof(struct xtkbd), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!xtkbd || !input_dev)
+		goto fail;
 
 	xtkbd->serio = serio;
-
-	init_input_dev(&xtkbd->dev);
-	xtkbd->dev.keycode = xtkbd->keycode;
-	xtkbd->dev.keycodesize = sizeof(unsigned char);
-	xtkbd->dev.keycodemax = ARRAY_SIZE(xtkbd_keycode);
-	xtkbd->dev.private = xtkbd;
-
-	serio_set_drvdata(serio, xtkbd);
-
-	err = serio_open(serio, drv);
-	if (err) {
-		serio_set_drvdata(serio, NULL);
-		kfree(xtkbd);
-		return err;
-	}
-
+	xtkbd->dev = input_dev;
+	sprintf(xtkbd->phys, "%s/input0", serio->phys);
 	memcpy(xtkbd->keycode, xtkbd_keycode, sizeof(xtkbd->keycode));
-	for (i = 0; i < 255; i++)
-		set_bit(xtkbd->keycode[i], xtkbd->dev.keybit);
-	clear_bit(0, xtkbd->dev.keybit);
 
-	sprintf(xtkbd->phys, "%s/input0", serio->phys);
+	input_dev->name = "XT Keyboard";
+	input_dev->phys = xtkbd->phys;
+	input_dev->id.bustype = BUS_XTKBD;
+	input_dev->id.vendor  = 0x0001;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
+	input_dev->cdev.dev = &serio->dev;
+	input_dev->private = xtkbd;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	input_dev->keycode = xtkbd->keycode;
+	input_dev->keycodesize = sizeof(unsigned char);
+	input_dev->keycodemax = ARRAY_SIZE(xtkbd_keycode);
 
-	xtkbd->dev.name = xtkbd_name;
-	xtkbd->dev.phys = xtkbd->phys;
-	xtkbd->dev.id.bustype = BUS_XTKBD;
-	xtkbd->dev.id.vendor = 0x0001;
-	xtkbd->dev.id.product = 0x0001;
-	xtkbd->dev.id.version = 0x0100;
-	xtkbd->dev.dev = &serio->dev;
+	for (i = 0; i < 255; i++)
+		set_bit(xtkbd->keycode[i], input_dev->keybit);
+	clear_bit(0, input_dev->keybit);
 
-	input_register_device(&xtkbd->dev);
+	serio_set_drvdata(serio, xtkbd);
 
-	printk(KERN_INFO "input: %s on %s\n", xtkbd_name, serio->phys);
+	err = serio_open(serio, drv);
+	if (err)
+		goto fail;
 
+	input_register_device(xtkbd->dev);
 	return 0;
+
+ fail:	serio_set_drvdata(serio, NULL);
+	input_free_device(input_dev);
+	kfree(xtkbd);
+	return err;
 }
 
 static void xtkbd_disconnect(struct serio *serio)
 {
 	struct xtkbd *xtkbd = serio_get_drvdata(serio);
 
-	input_unregister_device(&xtkbd->dev);
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
+	input_unregister_device(xtkbd->dev);
 	kfree(xtkbd);
 }
 
Index: work/drivers/input/keyboard/newtonkbd.c
===================================================================
--- work.orig/drivers/input/keyboard/newtonkbd.c
+++ work/drivers/input/keyboard/newtonkbd.c
@@ -57,11 +57,9 @@ static unsigned char nkbd_keycode[128] =
 	KEY_LEFT, KEY_RIGHT, KEY_DOWN, KEY_UP, 0
 };
 
-static char *nkbd_name = "Newton Keyboard";
-
 struct nkbd {
 	unsigned char keycode[128];
-	struct input_dev dev;
+	struct input_dev *dev;
 	struct serio *serio;
 	char phys[32];
 };
@@ -73,13 +71,13 @@ static irqreturn_t nkbd_interrupt(struct
 
 	/* invalid scan codes are probably the init sequence, so we ignore them */
 	if (nkbd->keycode[data & NKBD_KEY]) {
-		input_regs(&nkbd->dev, regs);
-		input_report_key(&nkbd->dev, nkbd->keycode[data & NKBD_KEY], data & NKBD_PRESS);
-		input_sync(&nkbd->dev);
+		input_regs(nkbd->dev, regs);
+		input_report_key(nkbd->dev, nkbd->keycode[data & NKBD_KEY], data & NKBD_PRESS);
+		input_sync(nkbd->dev);
 	}
 
 	else if (data == 0xe7) /* end of init sequence */
-		printk(KERN_INFO "input: %s on %s\n", nkbd_name, serio->phys);
+		printk(KERN_INFO "input: %s on %s\n", nkbd->dev->name, serio->phys);
 	return IRQ_HANDLED;
 
 }
@@ -87,62 +85,59 @@ static irqreturn_t nkbd_interrupt(struct
 static int nkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct nkbd *nkbd;
+	struct input_dev *input_dev;
+	int err = -ENOMEM;
 	int i;
-	int err;
-
-	if (!(nkbd = kmalloc(sizeof(struct nkbd), GFP_KERNEL)))
-		return -ENOMEM;
-
-	memset(nkbd, 0, sizeof(struct nkbd));
 
-	nkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	nkbd = kzalloc(sizeof(struct nkbd), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!nkbd || !input_dev)
+		goto fail;
 
 	nkbd->serio = serio;
+	nkbd->dev = input_dev;
+	sprintf(nkbd->phys, "%s/input0", serio->phys);
+	memcpy(nkbd->keycode, nkbd_keycode, sizeof(nkbd->keycode));
 
-	init_input_dev(&nkbd->dev);
-	nkbd->dev.keycode = nkbd->keycode;
-	nkbd->dev.keycodesize = sizeof(unsigned char);
-	nkbd->dev.keycodemax = ARRAY_SIZE(nkbd_keycode);
-	nkbd->dev.private = nkbd;
+	input_dev->name = "Newton Keyboard";
+	input_dev->phys = nkbd->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->id.vendor = SERIO_NEWTON;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
+	input_dev->cdev.dev = &serio->dev;
+	input_dev->private = nkbd;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	input_dev->keycode = nkbd->keycode;
+	input_dev->keycodesize = sizeof(unsigned char);
+	input_dev->keycodemax = ARRAY_SIZE(nkbd_keycode);
+	for (i = 0; i < 128; i++)
+		set_bit(nkbd->keycode[i], input_dev->keybit);
+	clear_bit(0, input_dev->keybit);
 
 	serio_set_drvdata(serio, nkbd);
 
 	err = serio_open(serio, drv);
-	if (err) {
-		serio_set_drvdata(serio, NULL);
-		kfree(nkbd);
-		return err;
-	}
-
-	memcpy(nkbd->keycode, nkbd_keycode, sizeof(nkbd->keycode));
-	for (i = 0; i < 128; i++)
-		set_bit(nkbd->keycode[i], nkbd->dev.keybit);
-	clear_bit(0, nkbd->dev.keybit);
-
-	sprintf(nkbd->phys, "%s/input0", serio->phys);
-
-	nkbd->dev.name = nkbd_name;
-	nkbd->dev.phys = nkbd->phys;
-	nkbd->dev.id.bustype = BUS_RS232;
-	nkbd->dev.id.vendor = SERIO_NEWTON;
-	nkbd->dev.id.product = 0x0001;
-	nkbd->dev.id.version = 0x0100;
-	nkbd->dev.dev = &serio->dev;
-
-	input_register_device(&nkbd->dev);
-
-	printk(KERN_INFO "input: %s on %s\n", nkbd_name, serio->phys);
+	if (err)
+		goto fail;
 
+	input_register_device(nkbd->dev);
 	return 0;
+
+ fail:	serio_set_drvdata(serio, NULL);
+	input_free_device(input_dev);
+	kfree(nkbd);
+	return err;
 }
 
 static void nkbd_disconnect(struct serio *serio)
 {
 	struct nkbd *nkbd = serio_get_drvdata(serio);
 
-	input_unregister_device(&nkbd->dev);
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
+	input_unregister_device(nkbd->dev);
 	kfree(nkbd);
 }
 
Index: work/drivers/input/keyboard/sunkbd.c
===================================================================
--- work.orig/drivers/input/keyboard/sunkbd.c
+++ work/drivers/input/keyboard/sunkbd.c
@@ -76,13 +76,14 @@ static unsigned char sunkbd_keycode[128]
 
 struct sunkbd {
 	unsigned char keycode[128];
-	struct input_dev dev;
+	struct input_dev *dev;
 	struct serio *serio;
 	struct work_struct tq;
 	wait_queue_head_t wait;
 	char name[64];
 	char phys[32];
 	char type;
+	unsigned char enabled;
 	volatile s8 reset;
 	volatile s8 layout;
 };
@@ -124,10 +125,13 @@ static irqreturn_t sunkbd_interrupt(stru
 			break;
 
 		default:
+			if (!sunkbd->enabled)
+				break;
+
 			if (sunkbd->keycode[data & SUNKBD_KEY]) {
-				input_regs(&sunkbd->dev, regs);
-                                input_report_key(&sunkbd->dev, sunkbd->keycode[data & SUNKBD_KEY], !(data & SUNKBD_RELEASE));
-				input_sync(&sunkbd->dev);
+				input_regs(sunkbd->dev, regs);
+                                input_report_key(sunkbd->dev, sunkbd->keycode[data & SUNKBD_KEY], !(data & SUNKBD_RELEASE));
+				input_sync(sunkbd->dev);
                         } else {
                                 printk(KERN_WARNING "sunkbd.c: Unknown key (scancode %#x) %s.\n",
                                         data & SUNKBD_KEY, data & SUNKBD_RELEASE ? "released" : "pressed");
@@ -184,7 +188,7 @@ static int sunkbd_initialize(struct sunk
 	sunkbd->reset = -2;
 	sunkbd->serio->write(sunkbd->serio, SUNKBD_CMD_RESET);
 	wait_event_interruptible_timeout(sunkbd->wait, sunkbd->reset >= 0, HZ);
-	if (sunkbd->reset <0)
+	if (sunkbd->reset < 0)
 		return -1;
 
 	sunkbd->type = sunkbd->reset;
@@ -213,10 +217,17 @@ static void sunkbd_reinit(void *data)
 
 	sunkbd->serio->write(sunkbd->serio, SUNKBD_CMD_SETLED);
 	sunkbd->serio->write(sunkbd->serio,
-		(!!test_bit(LED_CAPSL, sunkbd->dev.led) << 3) | (!!test_bit(LED_SCROLLL, sunkbd->dev.led) << 2) |
-		(!!test_bit(LED_COMPOSE, sunkbd->dev.led) << 1) | !!test_bit(LED_NUML, sunkbd->dev.led));
-	sunkbd->serio->write(sunkbd->serio, SUNKBD_CMD_NOCLICK - !!test_bit(SND_CLICK, sunkbd->dev.snd));
-	sunkbd->serio->write(sunkbd->serio, SUNKBD_CMD_BELLOFF - !!test_bit(SND_BELL, sunkbd->dev.snd));
+		(!!test_bit(LED_CAPSL, sunkbd->dev->led) << 3) | (!!test_bit(LED_SCROLLL, sunkbd->dev->led) << 2) |
+		(!!test_bit(LED_COMPOSE, sunkbd->dev->led) << 1) | !!test_bit(LED_NUML, sunkbd->dev->led));
+	sunkbd->serio->write(sunkbd->serio, SUNKBD_CMD_NOCLICK - !!test_bit(SND_CLICK, sunkbd->dev->snd));
+	sunkbd->serio->write(sunkbd->serio, SUNKBD_CMD_BELLOFF - !!test_bit(SND_BELL, sunkbd->dev->snd));
+}
+
+static void sunkbd_enable(struct sunkbd *sunkbd, int enable)
+{
+	serio_pause_rx(sunkbd->serio);
+	sunkbd->enabled = 1;
+	serio_continue_rx(sunkbd->serio);
 }
 
 /*
@@ -226,70 +237,64 @@ static void sunkbd_reinit(void *data)
 static int sunkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct sunkbd *sunkbd;
+	struct input_dev *input_dev;
+	int err = -ENOMEM;
 	int i;
-	int err;
-
-	if (!(sunkbd = kmalloc(sizeof(struct sunkbd), GFP_KERNEL)))
-		return -ENOMEM;
 
-	memset(sunkbd, 0, sizeof(struct sunkbd));
-
-	init_input_dev(&sunkbd->dev);
-	init_waitqueue_head(&sunkbd->wait);
-
-	sunkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_SND) | BIT(EV_REP);
-	sunkbd->dev.ledbit[0] = BIT(LED_CAPSL) | BIT(LED_COMPOSE) | BIT(LED_SCROLLL) | BIT(LED_NUML);
-	sunkbd->dev.sndbit[0] = BIT(SND_CLICK) | BIT(SND_BELL);
+	sunkbd = kzalloc(sizeof(struct sunkbd), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!sunkbd || !input_dev)
+		goto fail;
 
 	sunkbd->serio = serio;
-
+	sunkbd->dev = input_dev;
+	init_waitqueue_head(&sunkbd->wait);
 	INIT_WORK(&sunkbd->tq, sunkbd_reinit, sunkbd);
-
-	sunkbd->dev.keycode = sunkbd->keycode;
-	sunkbd->dev.keycodesize = sizeof(unsigned char);
-	sunkbd->dev.keycodemax = ARRAY_SIZE(sunkbd_keycode);
-
-	sunkbd->dev.event = sunkbd_event;
-	sunkbd->dev.private = sunkbd;
+	snprintf(sunkbd->phys, sizeof(sunkbd->phys), "%s/input0", serio->phys);
 
 	serio_set_drvdata(serio, sunkbd);
 
 	err = serio_open(serio, drv);
-	if (err) {
-		serio_set_drvdata(serio, NULL);
-		kfree(sunkbd);
-		return err;
-	}
+	if (err)
+		goto fail;
 
 	if (sunkbd_initialize(sunkbd) < 0) {
 		serio_close(serio);
-		serio_set_drvdata(serio, NULL);
-		kfree(sunkbd);
-		return -ENODEV;
+		goto fail;
 	}
 
 	sprintf(sunkbd->name, "Sun Type %d keyboard", sunkbd->type);
-
 	memcpy(sunkbd->keycode, sunkbd_keycode, sizeof(sunkbd->keycode));
-	for (i = 0; i < 128; i++)
-		set_bit(sunkbd->keycode[i], sunkbd->dev.keybit);
-	clear_bit(0, sunkbd->dev.keybit);
-
-	sprintf(sunkbd->phys, "%s/input0", serio->phys);
-
-	sunkbd->dev.name = sunkbd->name;
-	sunkbd->dev.phys = sunkbd->phys;
-	sunkbd->dev.id.bustype = BUS_RS232;
-	sunkbd->dev.id.vendor = SERIO_SUNKBD;
-	sunkbd->dev.id.product = sunkbd->type;
-	sunkbd->dev.id.version = 0x0100;
-	sunkbd->dev.dev = &serio->dev;
 
-	input_register_device(&sunkbd->dev);
-
-	printk(KERN_INFO "input: %s on %s\n", sunkbd->name, serio->phys);
+	input_dev->name = sunkbd->name;
+	input_dev->phys = sunkbd->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->id.vendor  = SERIO_SUNKBD;
+	input_dev->id.product = sunkbd->type;
+	input_dev->id.version = 0x0100;
+	input_dev->cdev.dev = &serio->dev;
+	input_dev->private = sunkbd;
+	input_dev->event = sunkbd_event;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_SND) | BIT(EV_REP);
+	input_dev->ledbit[0] = BIT(LED_CAPSL) | BIT(LED_COMPOSE) | BIT(LED_SCROLLL) | BIT(LED_NUML);
+	input_dev->sndbit[0] = BIT(SND_CLICK) | BIT(SND_BELL);
+
+	input_dev->keycode = sunkbd->keycode;
+	input_dev->keycodesize = sizeof(unsigned char);
+	input_dev->keycodemax = ARRAY_SIZE(sunkbd_keycode);
+	for (i = 0; i < 128; i++)
+		set_bit(sunkbd->keycode[i], input_dev->keybit);
+	clear_bit(0, input_dev->keybit);
 
+	sunkbd_enable(sunkbd, 1);
+	input_register_device(sunkbd->dev);
 	return 0;
+
+ fail:	serio_set_drvdata(serio, NULL);
+	input_free_device(input_dev);
+	kfree(sunkbd);
+	return err;
 }
 
 /*
@@ -299,7 +304,9 @@ static int sunkbd_connect(struct serio *
 static void sunkbd_disconnect(struct serio *serio)
 {
 	struct sunkbd *sunkbd = serio_get_drvdata(serio);
-	input_unregister_device(&sunkbd->dev);
+
+	sunkbd_enable(sunkbd, 0);
+	input_unregister_device(sunkbd->dev);
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
 	kfree(sunkbd);
Index: work/drivers/input/keyboard/maple_keyb.c
===================================================================
--- work.orig/drivers/input/keyboard/maple_keyb.c
+++ work/drivers/input/keyboard/maple_keyb.c
@@ -37,7 +37,7 @@ static unsigned char dc_kbd_keycode[256]
 
 
 struct dc_kbd {
-	struct input_dev dev;
+	struct input_dev *dev;
 	unsigned char new[8];
 	unsigned char old[8];
 };
@@ -46,30 +46,24 @@ struct dc_kbd {
 static void dc_scan_kbd(struct dc_kbd *kbd)
 {
 	int i;
-	struct input_dev *dev = &kbd->dev;
+	struct input_dev *dev = kbd->dev;
 
-	for(i=0; i<8; i++)
-		input_report_key(dev,
-				 dc_kbd_keycode[i+224],
-				 (kbd->new[0]>>i)&1);
-
-	for(i=2; i<8; i++) {
-
-		if(kbd->old[i]>3&&memscan(kbd->new+2, kbd->old[i], 6)==NULL) {
-			if(dc_kbd_keycode[kbd->old[i]])
-				input_report_key(dev,
-						 dc_kbd_keycode[kbd->old[i]],
-						 0);
+	for (i = 0; i < 8; i++)
+		input_report_key(dev, dc_kbd_keycode[i + 224], (kbd->new[0] >> i) & 1);
+
+	for (i = 2; i < 8; i++) {
+
+		if (kbd->old[i] > 3 && memscan(kbd->new + 2, kbd->old[i], 6) == NULL) {
+			if (dc_kbd_keycode[kbd->old[i]])
+				input_report_key(dev, dc_kbd_keycode[kbd->old[i]], 0);
 			else
 				printk("Unknown key (scancode %#x) released.",
 				       kbd->old[i]);
 		}
 
-		if(kbd->new[i]>3&&memscan(kbd->old+2, kbd->new[i], 6)!=NULL) {
+		if (kbd->new[i] > 3 && memscan(kbd->old + 2, kbd->new[i], 6) != NULL) {
 			if(dc_kbd_keycode[kbd->new[i]])
-				input_report_key(dev,
-						 dc_kbd_keycode[kbd->new[i]],
-						 1);
+				input_report_key(dev, dc_kbd_keycode[kbd->new[i]], 1);
 			else
 				printk("Unknown key (scancode %#x) pressed.",
 				       kbd->new[i]);
@@ -89,43 +83,39 @@ static void dc_kbd_callback(struct maple
 	unsigned long *buf = mq->recvbuf;
 
 	if (buf[1] == mapledev->function) {
-		memcpy(kbd->new, buf+2, 8);
+		memcpy(kbd->new, buf + 2, 8);
 		dc_scan_kbd(kbd);
 	}
 }
 
 static int dc_kbd_connect(struct maple_device *dev)
 {
-	int i;
-	unsigned long data = be32_to_cpu(dev->devinfo.function_data[0]);
 	struct dc_kbd *kbd;
+	struct input_dev *input_dev;
+	unsigned long data = be32_to_cpu(dev->devinfo.function_data[0]);
+	int i;
 
-	if (!(kbd = kmalloc(sizeof(struct dc_kbd), GFP_KERNEL)))
-		return -1;
-	memset(kbd, 0, sizeof(struct dc_kbd));
-
-	dev->private_data = kbd;
-
-	kbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
-
-	init_input_dev(&kbd->dev);
-
-	for (i=0; i<255; i++)
-		set_bit(dc_kbd_keycode[i], kbd->dev.keybit);
-
-	clear_bit(0, kbd->dev.keybit);
+	dev->private_data = kbd = kzalloc(sizeof(struct dc_kbd), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!kbd || !input_dev) {
+		kfree(kbd);
+		input_free_device(input_dev);
+		return -ENOMEM;
+	}
 
-	kbd->dev.private = kbd;
+	kbd->dev = input_dev;
 
-	kbd->dev.name = dev->product_name;
-	kbd->dev.id.bustype = BUS_MAPLE;
+	input_dev->name = dev->product_name;
+	input_dev->id.bustype = BUS_MAPLE;
+	input_dev->private = kbd;
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	for (i = 0; i < 255; i++)
+		set_bit(dc_kbd_keycode[i], input_dev->keybit);
+	clear_bit(0, input_dev->keybit);
 
-	input_register_device(&kbd->dev);
+	input_register_device(kbd->dev);
 
 	maple_getcond_callback(dev, dc_kbd_callback, 1, MAPLE_FUNC_KEYBOARD);
-
-	printk(KERN_INFO "input: keyboard(0x%lx): %s\n", data, kbd->dev.name);
-
 	return 0;
 }
 
@@ -134,7 +124,7 @@ static void dc_kbd_disconnect(struct map
 {
 	struct dc_kbd *kbd = dev->private_data;
 
-	input_unregister_device(&kbd->dev);
+	input_unregister_device(kbd->dev);
 	kfree(kbd);
 }
 
Index: work/drivers/input/keyboard/spitzkbd.c
===================================================================
--- work.orig/drivers/input/keyboard/spitzkbd.c
+++ work/drivers/input/keyboard/spitzkbd.c
@@ -85,7 +85,7 @@ static int spitz_senses[] = {
 
 struct spitzkbd {
 	unsigned char keycode[ARRAY_SIZE(spitzkbd_keycode)];
-	struct input_dev input;
+	struct input_dev *input;
 	char phys[32];
 
 	spinlock_t lock;
@@ -187,8 +187,7 @@ static void spitzkbd_scankeyboard(struct
 
 	spin_lock_irqsave(&spitzkbd_data->lock, flags);
 
-	if (regs)
-		input_regs(&spitzkbd_data->input, regs);
+	input_regs(spitzkbd_data->input, regs);
 
 	num_pressed = 0;
 	for (col = 0; col < KB_COLS; col++) {
@@ -210,7 +209,7 @@ static void spitzkbd_scankeyboard(struct
 			scancode = SCANCODE(row, col);
 			pressed = rowd & KB_ROWMASK(row);
 
-			input_report_key(&spitzkbd_data->input, spitzkbd_data->keycode[scancode], pressed);
+			input_report_key(spitzkbd_data->input, spitzkbd_data->keycode[scancode], pressed);
 
 			if (pressed)
 				num_pressed++;
@@ -220,15 +219,15 @@ static void spitzkbd_scankeyboard(struct
 
 	spitzkbd_activate_all();
 
-	input_report_key(&spitzkbd_data->input, SPITZ_KEY_SYNC, (GPLR(SPITZ_GPIO_SYNC) & GPIO_bit(SPITZ_GPIO_SYNC)) != 0 );
-	input_report_key(&spitzkbd_data->input, KEY_SUSPEND, pwrkey);
+	input_report_key(spitzkbd_data->input, SPITZ_KEY_SYNC, (GPLR(SPITZ_GPIO_SYNC) & GPIO_bit(SPITZ_GPIO_SYNC)) != 0 );
+	input_report_key(spitzkbd_data->input, KEY_SUSPEND, pwrkey);
 
 	if (pwrkey && time_after(jiffies, spitzkbd_data->suspend_jiffies + msecs_to_jiffies(1000))) {
-		input_event(&spitzkbd_data->input, EV_PWR, KEY_SUSPEND, 1);
+		input_event(spitzkbd_data->input, EV_PWR, KEY_SUSPEND, 1);
 		spitzkbd_data->suspend_jiffies = jiffies;
 	}
 
-	input_sync(&spitzkbd_data->input);
+	input_sync(spitzkbd_data->input);
 
 	/* if any keys are pressed, enable the timer */
 	if (num_pressed)
@@ -259,6 +258,7 @@ static irqreturn_t spitzkbd_interrupt(in
 static void spitzkbd_timer_callback(unsigned long data)
 {
 	struct spitzkbd *spitzkbd_data = (struct spitzkbd *) data;
+
 	spitzkbd_scankeyboard(spitzkbd_data, NULL);
 }
 
@@ -298,9 +298,9 @@ static void spitzkbd_hinge_timer(unsigne
 	if (hinge_count >= HINGE_STABLE_COUNT) {
 		spin_lock_irqsave(&spitzkbd_data->lock, flags);
 
-		input_report_switch(&spitzkbd_data->input, SW_0, ((GPLR(SPITZ_GPIO_SWA) & GPIO_bit(SPITZ_GPIO_SWA)) != 0));
-		input_report_switch(&spitzkbd_data->input, SW_1, ((GPLR(SPITZ_GPIO_SWB) & GPIO_bit(SPITZ_GPIO_SWB)) != 0));
-		input_sync(&spitzkbd_data->input);
+		input_report_switch(spitzkbd_data->input, SW_0, ((GPLR(SPITZ_GPIO_SWA) & GPIO_bit(SPITZ_GPIO_SWA)) != 0));
+		input_report_switch(spitzkbd_data->input, SW_1, ((GPLR(SPITZ_GPIO_SWB) & GPIO_bit(SPITZ_GPIO_SWB)) != 0));
+		input_sync(spitzkbd_data->input);
 
 		spin_unlock_irqrestore(&spitzkbd_data->lock, flags);
 	} else {
@@ -346,14 +346,21 @@ static int spitzkbd_resume(struct device
 
 static int __init spitzkbd_probe(struct device *dev)
 {
-	int i;
 	struct spitzkbd *spitzkbd;
+	struct input_dev *input_dev;
+	int i;
 
 	spitzkbd = kzalloc(sizeof(struct spitzkbd), GFP_KERNEL);
 	if (!spitzkbd)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev,spitzkbd);
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		kfree(spitzkbd);
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(dev, spitzkbd);
 	strcpy(spitzkbd->phys, "spitzkbd/input0");
 
 	spin_lock_init(&spitzkbd->lock);
@@ -368,30 +375,34 @@ static int __init spitzkbd_probe(struct 
 	spitzkbd->htimer.function = spitzkbd_hinge_timer;
 	spitzkbd->htimer.data = (unsigned long) spitzkbd;
 
-	spitzkbd->suspend_jiffies=jiffies;
+	spitzkbd->suspend_jiffies = jiffies;
 
-	init_input_dev(&spitzkbd->input);
-	spitzkbd->input.private = spitzkbd;
-	spitzkbd->input.name = "Spitz Keyboard";
-	spitzkbd->input.dev = dev;
-	spitzkbd->input.phys = spitzkbd->phys;
-	spitzkbd->input.id.bustype = BUS_HOST;
-	spitzkbd->input.id.vendor = 0x0001;
-	spitzkbd->input.id.product = 0x0001;
-	spitzkbd->input.id.version = 0x0100;
-	spitzkbd->input.evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_PWR) | BIT(EV_SW);
-	spitzkbd->input.keycode = spitzkbd->keycode;
-	spitzkbd->input.keycodesize = sizeof(unsigned char);
-	spitzkbd->input.keycodemax = ARRAY_SIZE(spitzkbd_keycode);
+	spitzkbd->input = input_dev;
+
+	input_dev->private = spitzkbd;
+	input_dev->name = "Spitz Keyboard";
+	input_dev->phys = spitzkbd->phys;
+	input_dev->cdev.dev = dev;
+
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->id.vendor = 0x0001;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_PWR) | BIT(EV_SW);
+	input_dev->keycode = spitzkbd->keycode;
+	input_dev->keycodesize = sizeof(unsigned char);
+	input_dev->keycodemax = ARRAY_SIZE(spitzkbd_keycode);
 
 	memcpy(spitzkbd->keycode, spitzkbd_keycode, sizeof(spitzkbd->keycode));
 	for (i = 0; i < ARRAY_SIZE(spitzkbd_keycode); i++)
-		set_bit(spitzkbd->keycode[i], spitzkbd->input.keybit);
-	clear_bit(0, spitzkbd->input.keybit);
-	set_bit(SW_0, spitzkbd->input.swbit);
-	set_bit(SW_1, spitzkbd->input.swbit);
+		set_bit(spitzkbd->keycode[i], input_dev->keybit);
+	clear_bit(0, input_dev->keybit);
+	set_bit(SW_0, input_dev->swbit);
+	set_bit(SW_1, input_dev->swbit);
+
+	input_register_device(input_dev);
 
-	input_register_device(&spitzkbd->input);
 	mod_timer(&spitzkbd->htimer, jiffies + msecs_to_jiffies(HINGE_SCAN_INTERVAL));
 
 	/* Setup sense interrupts - RisingEdge Detect, sense lines as inputs */
@@ -444,7 +455,7 @@ static int spitzkbd_remove(struct device
 	del_timer_sync(&spitzkbd->htimer);
 	del_timer_sync(&spitzkbd->timer);
 
-	input_unregister_device(&spitzkbd->input);
+	input_unregister_device(spitzkbd->input);
 
 	kfree(spitzkbd);
 

