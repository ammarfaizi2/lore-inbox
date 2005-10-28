Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbVJ1Gjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbVJ1Gjv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbVJ1Gif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:38:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:36330 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965131AbVJ1GbT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:19 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] drivers/input/mouse: convert to dynamic input_dev allocation
In-Reply-To: <11304810242041@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:24 -0700
Message-Id: <11304810242749@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] drivers/input/mouse: convert to dynamic input_dev allocation

Input: convert drivers/input/mouse to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit f18c31d676d42b4f75f1520733f4b5b2c966524d
tree 9e16a56703102547b10c664ef155099c0dad9e2d
parent 4086434e3a16b83e0cc651b5519f911dfa010cc7
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 15 Sep 2005 02:01:44 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:03 -0700

 drivers/input/mouse/alps.c         |   67 +++++++++++++-----------
 drivers/input/mouse/alps.h         |    2 -
 drivers/input/mouse/amimouse.c     |   51 +++++++++----------
 drivers/input/mouse/inport.c       |   96 ++++++++++++++++++-----------------
 drivers/input/mouse/lifebook.c     |   16 +++---
 drivers/input/mouse/logibm.c       |   88 ++++++++++++++++----------------
 drivers/input/mouse/logips2pp.c    |   20 ++++---
 drivers/input/mouse/maplemouse.c   |   10 +---
 drivers/input/mouse/pc110pad.c     |   70 ++++++++++++-------------
 drivers/input/mouse/psmouse-base.c |   99 +++++++++++++++++++-----------------
 drivers/input/mouse/psmouse.h      |    2 -
 drivers/input/mouse/rpcmouse.c     |   43 ++++++++--------
 drivers/input/mouse/sermouse.c     |   84 +++++++++++++++----------------
 drivers/input/mouse/synaptics.c    |    6 +-
 drivers/input/mouse/vsxxxaa.c      |   84 +++++++++++++++----------------
 15 files changed, 370 insertions(+), 368 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index b20783f..4acc7fd 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -79,8 +79,8 @@ static void alps_process_packet(struct p
 {
 	struct alps_data *priv = psmouse->private;
 	unsigned char *packet = psmouse->packet;
-	struct input_dev *dev = &psmouse->dev;
-	struct input_dev *dev2 = &priv->dev2;
+	struct input_dev *dev = psmouse->dev;
+	struct input_dev *dev2 = priv->dev2;
 	int x, y, z, ges, fin, left, right, middle;
 	int back = 0, forward = 0;
 
@@ -379,20 +379,24 @@ static int alps_reconnect(struct psmouse
 static void alps_disconnect(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
+
 	psmouse_reset(psmouse);
-	input_unregister_device(&priv->dev2);
+	input_unregister_device(priv->dev2);
 	kfree(priv);
 }
 
 int alps_init(struct psmouse *psmouse)
 {
 	struct alps_data *priv;
+	struct input_dev *dev1 = psmouse->dev, *dev2;
 	int version;
 
-	psmouse->private = priv = kmalloc(sizeof(struct alps_data), GFP_KERNEL);
-	if (!priv)
+	psmouse->private = priv = kzalloc(sizeof(struct alps_data), GFP_KERNEL);
+	dev2 = input_allocate_device();
+	if (!priv || !dev2)
 		goto init_fail;
-	memset(priv, 0, sizeof(struct alps_data));
+
+	priv->dev2 = dev2;
 
 	if (!(priv->i = alps_get_model(psmouse, &version)))
 		goto init_fail;
@@ -411,41 +415,39 @@ int alps_init(struct psmouse *psmouse)
 	if ((priv->i->flags & ALPS_PASS) && alps_passthrough_mode(psmouse, 0))
 		goto init_fail;
 
-	psmouse->dev.evbit[LONG(EV_KEY)] |= BIT(EV_KEY);
-	psmouse->dev.keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
-	psmouse->dev.keybit[LONG(BTN_TOOL_FINGER)] |= BIT(BTN_TOOL_FINGER);
-	psmouse->dev.keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
-
-	psmouse->dev.evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
-	input_set_abs_params(&psmouse->dev, ABS_X, 0, 1023, 0, 0);
-	input_set_abs_params(&psmouse->dev, ABS_Y, 0, 767, 0, 0);
-	input_set_abs_params(&psmouse->dev, ABS_PRESSURE, 0, 127, 0, 0);
+	dev1->evbit[LONG(EV_KEY)] |= BIT(EV_KEY);
+	dev1->keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
+	dev1->keybit[LONG(BTN_TOOL_FINGER)] |= BIT(BTN_TOOL_FINGER);
+	dev1->keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+
+	dev1->evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
+	input_set_abs_params(dev1, ABS_X, 0, 1023, 0, 0);
+	input_set_abs_params(dev1, ABS_Y, 0, 767, 0, 0);
+	input_set_abs_params(dev1, ABS_PRESSURE, 0, 127, 0, 0);
 
 	if (priv->i->flags & ALPS_WHEEL) {
-		psmouse->dev.evbit[LONG(EV_REL)] |= BIT(EV_REL);
-		psmouse->dev.relbit[LONG(REL_WHEEL)] |= BIT(REL_WHEEL);
+		dev1->evbit[LONG(EV_REL)] |= BIT(EV_REL);
+		dev1->relbit[LONG(REL_WHEEL)] |= BIT(REL_WHEEL);
 	}
 
 	if (priv->i->flags & (ALPS_FW_BK_1 | ALPS_FW_BK_2)) {
-		psmouse->dev.keybit[LONG(BTN_FORWARD)] |= BIT(BTN_FORWARD);
-		psmouse->dev.keybit[LONG(BTN_BACK)] |= BIT(BTN_BACK);
+		dev1->keybit[LONG(BTN_FORWARD)] |= BIT(BTN_FORWARD);
+		dev1->keybit[LONG(BTN_BACK)] |= BIT(BTN_BACK);
 	}
 
 	sprintf(priv->phys, "%s/input1", psmouse->ps2dev.serio->phys);
-	priv->dev2.phys = priv->phys;
-	priv->dev2.name = (priv->i->flags & ALPS_DUALPOINT) ? "DualPoint Stick" : "PS/2 Mouse";
-	priv->dev2.id.bustype = BUS_I8042;
-	priv->dev2.id.vendor = 0x0002;
-	priv->dev2.id.product = PSMOUSE_ALPS;
-	priv->dev2.id.version = 0x0000;
-
-	priv->dev2.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-	priv->dev2.relbit[LONG(REL_X)] |= BIT(REL_X) | BIT(REL_Y);
-	priv->dev2.keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
-
-	input_register_device(&priv->dev2);
+	dev2->phys = priv->phys;
+	dev2->name = (priv->i->flags & ALPS_DUALPOINT) ? "DualPoint Stick" : "PS/2 Mouse";
+	dev2->id.bustype = BUS_I8042;
+	dev2->id.vendor  = 0x0002;
+	dev2->id.product = PSMOUSE_ALPS;
+	dev2->id.version = 0x0000;
+
+	dev2->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	dev2->relbit[LONG(REL_X)] |= BIT(REL_X) | BIT(REL_Y);
+	dev2->keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 
-	printk(KERN_INFO "input: %s on %s\n", priv->dev2.name, psmouse->ps2dev.serio->phys);
+	input_register_device(priv->dev2);
 
 	psmouse->protocol_handler = alps_process_byte;
 	psmouse->disconnect = alps_disconnect;
@@ -455,6 +457,7 @@ int alps_init(struct psmouse *psmouse)
 	return 0;
 
 init_fail:
+	input_free_device(dev2);
 	kfree(priv);
 	return -1;
 }
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index aba103d..e428f8d 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -22,7 +22,7 @@ struct alps_model_info {
 };
 
 struct alps_data {
-	struct input_dev dev2;		/* Relative device */
+	struct input_dev *dev2;		/* Relative device */
 	char name[32];			/* Name */
 	char phys[32];			/* Phys */
 	struct alps_model_info *i; 	/* Info */
diff --git a/drivers/input/mouse/amimouse.c b/drivers/input/mouse/amimouse.c
index e994849..d13d4c8 100644
--- a/drivers/input/mouse/amimouse.c
+++ b/drivers/input/mouse/amimouse.c
@@ -34,10 +34,7 @@ MODULE_DESCRIPTION("Amiga mouse driver")
 MODULE_LICENSE("GPL");
 
 static int amimouse_lastx, amimouse_lasty;
-static struct input_dev amimouse_dev;
-
-static char *amimouse_name = "Amiga mouse";
-static char *amimouse_phys = "amimouse/input0";
+static struct input_dev *amimouse_dev;
 
 static irqreturn_t amimouse_interrupt(int irq, void *dummy, struct pt_regs *fp)
 {
@@ -62,16 +59,16 @@ static irqreturn_t amimouse_interrupt(in
 
 	potgor = custom.potgor;
 
-	input_regs(&amimouse_dev, fp);
+	input_regs(amimouse_dev, fp);
 
-	input_report_rel(&amimouse_dev, REL_X, dx);
-	input_report_rel(&amimouse_dev, REL_Y, dy);
+	input_report_rel(amimouse_dev, REL_X, dx);
+	input_report_rel(amimouse_dev, REL_Y, dy);
 
-	input_report_key(&amimouse_dev, BTN_LEFT,   ciaa.pra & 0x40);
-	input_report_key(&amimouse_dev, BTN_MIDDLE, potgor & 0x0100);
-	input_report_key(&amimouse_dev, BTN_RIGHT,  potgor & 0x0400);
+	input_report_key(amimouse_dev, BTN_LEFT,   ciaa.pra & 0x40);
+	input_report_key(amimouse_dev, BTN_MIDDLE, potgor & 0x0100);
+	input_report_key(amimouse_dev, BTN_RIGHT,  potgor & 0x0400);
 
-	input_sync(&amimouse_dev);
+	input_sync(amimouse_dev);
 
 	return IRQ_HANDLED;
 }
@@ -103,28 +100,30 @@ static int __init amimouse_init(void)
 	if (!MACH_IS_AMIGA || !AMIGAHW_PRESENT(AMI_MOUSE))
 		return -ENODEV;
 
-	amimouse_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-	amimouse_dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-	amimouse_dev.keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
-	amimouse_dev.open = amimouse_open;
-	amimouse_dev.close = amimouse_close;
-
-	amimouse_dev.name = amimouse_name;
-	amimouse_dev.phys = amimouse_phys;
-	amimouse_dev.id.bustype = BUS_AMIGA;
-	amimouse_dev.id.vendor = 0x0001;
-	amimouse_dev.id.product = 0x0002;
-	amimouse_dev.id.version = 0x0100;
+	if (!(amimouse_dev = input_allocate_device()))
+		return -ENOMEM;
+
+	amimouse_dev->name = "Amiga mouse";
+	amimouse_dev->phys = "amimouse/input0";
+	amimouse_dev->id.bustype = BUS_AMIGA;
+	amimouse_dev->id.vendor = 0x0001;
+	amimouse_dev->id.product = 0x0002;
+	amimouse_dev->id.version = 0x0100;
+
+	amimouse_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	amimouse_dev->relbit[0] = BIT(REL_X) | BIT(REL_Y);
+	amimouse_dev->keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+	amimouse_dev->open = amimouse_open;
+	amimouse_dev->close = amimouse_close;
 
-	input_register_device(&amimouse_dev);
+	input_register_device(amimouse_dev);
 
-        printk(KERN_INFO "input: %s at joy0dat\n", amimouse_name);
 	return 0;
 }
 
 static void __exit amimouse_exit(void)
 {
-        input_unregister_device(&amimouse_dev);
+        input_unregister_device(amimouse_dev);
 }
 
 module_init(amimouse_init);
diff --git a/drivers/input/mouse/inport.c b/drivers/input/mouse/inport.c
index 1f62c01..afc66f5 100644
--- a/drivers/input/mouse/inport.c
+++ b/drivers/input/mouse/inport.c
@@ -87,40 +87,7 @@ MODULE_PARM_DESC(irq, "IRQ number (5=def
 
 __obsolete_setup("inport_irq=");
 
-static irqreturn_t inport_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-
-static int inport_open(struct input_dev *dev)
-{
-	if (request_irq(inport_irq, inport_interrupt, 0, "inport", NULL))
-		return -EBUSY;
-	outb(INPORT_REG_MODE, INPORT_CONTROL_PORT);
-	outb(INPORT_MODE_IRQ | INPORT_MODE_BASE, INPORT_DATA_PORT);
-
-	return 0;
-}
-
-static void inport_close(struct input_dev *dev)
-{
-	outb(INPORT_REG_MODE, INPORT_CONTROL_PORT);
-	outb(INPORT_MODE_BASE, INPORT_DATA_PORT);
-	free_irq(inport_irq, NULL);
-}
-
-static struct input_dev inport_dev = {
-	.evbit	= { BIT(EV_KEY) | BIT(EV_REL) },
-	.keybit	= { [LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT) },
-	.relbit	= { BIT(REL_X) | BIT(REL_Y) },
-	.open	= inport_open,
-	.close	= inport_close,
-	.name	= INPORT_NAME,
-	.phys	= "isa023c/input0",
-	.id = {
-		.bustype = BUS_ISA,
-		.vendor  = INPORT_VENDOR,
-		.product = 0x0001,
-		.version = 0x0100,
-	},
-};
+static struct input_dev *inport_dev;
 
 static irqreturn_t inport_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
@@ -129,31 +96,48 @@ static irqreturn_t inport_interrupt(int 
 	outb(INPORT_REG_MODE, INPORT_CONTROL_PORT);
 	outb(INPORT_MODE_HOLD | INPORT_MODE_IRQ | INPORT_MODE_BASE, INPORT_DATA_PORT);
 
-	input_regs(&inport_dev, regs);
+	input_regs(inport_dev, regs);
 
 	outb(INPORT_REG_X, INPORT_CONTROL_PORT);
-	input_report_rel(&inport_dev, REL_X, inb(INPORT_DATA_PORT));
+	input_report_rel(inport_dev, REL_X, inb(INPORT_DATA_PORT));
 
 	outb(INPORT_REG_Y, INPORT_CONTROL_PORT);
-	input_report_rel(&inport_dev, REL_Y, inb(INPORT_DATA_PORT));
+	input_report_rel(inport_dev, REL_Y, inb(INPORT_DATA_PORT));
 
 	outb(INPORT_REG_BTNS, INPORT_CONTROL_PORT);
 	buttons = inb(INPORT_DATA_PORT);
 
-	input_report_key(&inport_dev, BTN_MIDDLE, buttons & 1);
-	input_report_key(&inport_dev, BTN_LEFT,   buttons & 2);
-	input_report_key(&inport_dev, BTN_RIGHT,  buttons & 4);
+	input_report_key(inport_dev, BTN_MIDDLE, buttons & 1);
+	input_report_key(inport_dev, BTN_LEFT,   buttons & 2);
+	input_report_key(inport_dev, BTN_RIGHT,  buttons & 4);
 
 	outb(INPORT_REG_MODE, INPORT_CONTROL_PORT);
 	outb(INPORT_MODE_IRQ | INPORT_MODE_BASE, INPORT_DATA_PORT);
 
-	input_sync(&inport_dev);
+	input_sync(inport_dev);
 	return IRQ_HANDLED;
 }
 
+static int inport_open(struct input_dev *dev)
+{
+	if (request_irq(inport_irq, inport_interrupt, 0, "inport", NULL))
+		return -EBUSY;
+	outb(INPORT_REG_MODE, INPORT_CONTROL_PORT);
+	outb(INPORT_MODE_IRQ | INPORT_MODE_BASE, INPORT_DATA_PORT);
+
+	return 0;
+}
+
+static void inport_close(struct input_dev *dev)
+{
+	outb(INPORT_REG_MODE, INPORT_CONTROL_PORT);
+	outb(INPORT_MODE_BASE, INPORT_DATA_PORT);
+	free_irq(inport_irq, NULL);
+}
+
 static int __init inport_init(void)
 {
-	unsigned char a,b,c;
+	unsigned char a, b, c;
 
 	if (!request_region(INPORT_BASE, INPORT_EXTENT, "inport")) {
 		printk(KERN_ERR "inport.c: Can't allocate ports at %#x\n", INPORT_BASE);
@@ -163,26 +147,44 @@ static int __init inport_init(void)
 	a = inb(INPORT_SIGNATURE_PORT);
 	b = inb(INPORT_SIGNATURE_PORT);
 	c = inb(INPORT_SIGNATURE_PORT);
-	if (( a == b ) || ( a != c )) {
+	if (a == b || a != c) {
 		release_region(INPORT_BASE, INPORT_EXTENT);
 		printk(KERN_ERR "inport.c: Didn't find InPort mouse at %#x\n", INPORT_BASE);
 		return -ENODEV;
 	}
 
+	if (!(inport_dev = input_allocate_device())) {
+		printk(KERN_ERR "inport.c: Not enough memory for input device\n");
+		release_region(INPORT_BASE, INPORT_EXTENT);
+		return -ENOMEM;
+	}
+
+	inport_dev->name = INPORT_NAME;
+	inport_dev->phys = "isa023c/input0";
+	inport_dev->id.bustype = BUS_ISA;
+	inport_dev->id.vendor  = INPORT_VENDOR;
+	inport_dev->id.product = 0x0001;
+	inport_dev->id.version = 0x0100;
+
+	inport_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	inport_dev->keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+	inport_dev->relbit[0] = BIT(REL_X) | BIT(REL_Y);
+
+	inport_dev->open  = inport_open;
+	inport_dev->close = inport_close;
+
 	outb(INPORT_RESET, INPORT_CONTROL_PORT);
 	outb(INPORT_REG_MODE, INPORT_CONTROL_PORT);
 	outb(INPORT_MODE_BASE, INPORT_DATA_PORT);
 
-	input_register_device(&inport_dev);
-
-	printk(KERN_INFO "input: " INPORT_NAME " at %#x irq %d\n", INPORT_BASE, inport_irq);
+	input_register_device(inport_dev);
 
 	return 0;
 }
 
 static void __exit inport_exit(void)
 {
-	input_unregister_device(&inport_dev);
+	input_unregister_device(inport_dev);
 	release_region(INPORT_BASE, INPORT_EXTENT);
 }
 
diff --git a/drivers/input/mouse/lifebook.c b/drivers/input/mouse/lifebook.c
index bd9df9b..5599142 100644
--- a/drivers/input/mouse/lifebook.c
+++ b/drivers/input/mouse/lifebook.c
@@ -34,7 +34,7 @@ static struct dmi_system_id lifebook_dmi
 static psmouse_ret_t lifebook_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
 	unsigned char *packet = psmouse->packet;
-	struct input_dev *dev = &psmouse->dev;
+	struct input_dev *dev = psmouse->dev;
 
 	if (psmouse->pktcnt != 3)
 		return PSMOUSE_GOOD_DATA;
@@ -113,15 +113,17 @@ int lifebook_detect(struct psmouse *psmo
 
 int lifebook_init(struct psmouse *psmouse)
 {
+	struct input_dev *input_dev = psmouse->dev;
+
 	if (lifebook_absolute_mode(psmouse))
 		return -1;
 
-	psmouse->dev.evbit[0] = BIT(EV_ABS) | BIT(EV_KEY) | BIT(EV_REL);
-	psmouse->dev.keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
-	psmouse->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
-	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-	input_set_abs_params(&psmouse->dev, ABS_X, 0, 1024, 0, 0);
-	input_set_abs_params(&psmouse->dev, ABS_Y, 0, 1024, 0, 0);
+	input_dev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY) | BIT(EV_REL);
+	input_dev->keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_dev->relbit[0] = BIT(REL_X) | BIT(REL_Y);
+	input_set_abs_params(input_dev, ABS_X, 0, 1024, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, 1024, 0, 0);
 
 	psmouse->protocol_handler = lifebook_process_byte;
 	psmouse->set_resolution = lifebook_set_resolution;
diff --git a/drivers/input/mouse/logibm.c b/drivers/input/mouse/logibm.c
index 8b52431..9c7ce38 100644
--- a/drivers/input/mouse/logibm.c
+++ b/drivers/input/mouse/logibm.c
@@ -77,39 +77,7 @@ MODULE_PARM_DESC(irq, "IRQ number (5=def
 
 __obsolete_setup("logibm_irq=");
 
-static irqreturn_t logibm_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-
-static int logibm_open(struct input_dev *dev)
-{
-	if (request_irq(logibm_irq, logibm_interrupt, 0, "logibm", NULL)) {
-		printk(KERN_ERR "logibm.c: Can't allocate irq %d\n", logibm_irq);
-		return -EBUSY;
-	}
-	outb(LOGIBM_ENABLE_IRQ, LOGIBM_CONTROL_PORT);
-	return 0;
-}
-
-static void logibm_close(struct input_dev *dev)
-{
-	outb(LOGIBM_DISABLE_IRQ, LOGIBM_CONTROL_PORT);
-	free_irq(logibm_irq, NULL);
-}
-
-static struct input_dev logibm_dev = {
-	.evbit	= { BIT(EV_KEY) | BIT(EV_REL) },
-	.keybit = { [LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT) },
-	.relbit	= { BIT(REL_X) | BIT(REL_Y) },
-	.open	= logibm_open,
-	.close	= logibm_close,
-	.name	= "Logitech bus mouse",
-	.phys	= "isa023c/input0",
-	.id	= {
-		.bustype = BUS_ISA,
-		.vendor  = 0x0003,
-		.product = 0x0001,
-		.version = 0x0100,
-	},
-};
+static struct input_dev *logibm_dev;
 
 static irqreturn_t logibm_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
@@ -127,18 +95,34 @@ static irqreturn_t logibm_interrupt(int 
 	dy |= (buttons & 0xf) << 4;
 	buttons = ~buttons >> 5;
 
-	input_regs(&logibm_dev, regs);
-	input_report_rel(&logibm_dev, REL_X, dx);
-	input_report_rel(&logibm_dev, REL_Y, dy);
-	input_report_key(&logibm_dev, BTN_RIGHT,  buttons & 1);
-	input_report_key(&logibm_dev, BTN_MIDDLE, buttons & 2);
-	input_report_key(&logibm_dev, BTN_LEFT,   buttons & 4);
-	input_sync(&logibm_dev);
+	input_regs(logibm_dev, regs);
+	input_report_rel(logibm_dev, REL_X, dx);
+	input_report_rel(logibm_dev, REL_Y, dy);
+	input_report_key(logibm_dev, BTN_RIGHT,  buttons & 1);
+	input_report_key(logibm_dev, BTN_MIDDLE, buttons & 2);
+	input_report_key(logibm_dev, BTN_LEFT,   buttons & 4);
+	input_sync(logibm_dev);
 
 	outb(LOGIBM_ENABLE_IRQ, LOGIBM_CONTROL_PORT);
 	return IRQ_HANDLED;
 }
 
+static int logibm_open(struct input_dev *dev)
+{
+	if (request_irq(logibm_irq, logibm_interrupt, 0, "logibm", NULL)) {
+		printk(KERN_ERR "logibm.c: Can't allocate irq %d\n", logibm_irq);
+		return -EBUSY;
+	}
+	outb(LOGIBM_ENABLE_IRQ, LOGIBM_CONTROL_PORT);
+	return 0;
+}
+
+static void logibm_close(struct input_dev *dev)
+{
+	outb(LOGIBM_DISABLE_IRQ, LOGIBM_CONTROL_PORT);
+	free_irq(logibm_irq, NULL);
+}
+
 static int __init logibm_init(void)
 {
 	if (!request_region(LOGIBM_BASE, LOGIBM_EXTENT, "logibm")) {
@@ -159,16 +143,34 @@ static int __init logibm_init(void)
 	outb(LOGIBM_DEFAULT_MODE, LOGIBM_CONFIG_PORT);
 	outb(LOGIBM_DISABLE_IRQ, LOGIBM_CONTROL_PORT);
 
-	input_register_device(&logibm_dev);
+	if (!(logibm_dev = input_allocate_device())) {
+		printk(KERN_ERR "logibm.c: Not enough memory for input device\n");
+		release_region(LOGIBM_BASE, LOGIBM_EXTENT);
+		return -ENOMEM;
+	}
+
+	logibm_dev->name = "Logitech bus mouse";
+	logibm_dev->phys = "isa023c/input0";
+	logibm_dev->id.bustype = BUS_ISA;
+	logibm_dev->id.vendor  = 0x0003;
+	logibm_dev->id.product = 0x0001;
+	logibm_dev->id.version = 0x0100;
+
+	logibm_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	logibm_dev->keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+	logibm_dev->relbit[0] = BIT(REL_X) | BIT(REL_Y);
+
+	logibm_dev->open  = logibm_open;
+	logibm_dev->close = logibm_close;
 
-	printk(KERN_INFO "input: Logitech bus mouse at %#x irq %d\n", LOGIBM_BASE, logibm_irq);
+	input_register_device(logibm_dev);
 
 	return 0;
 }
 
 static void __exit logibm_exit(void)
 {
-	input_unregister_device(&logibm_dev);
+	input_unregister_device(logibm_dev);
 	release_region(LOGIBM_BASE, LOGIBM_EXTENT);
 }
 
diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
index 7df9652..0f69ff4 100644
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -40,7 +40,7 @@ struct ps2pp_info {
 
 static psmouse_ret_t ps2pp_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
-	struct input_dev *dev = &psmouse->dev;
+	struct input_dev *dev = psmouse->dev;
 	unsigned char *packet = psmouse->packet;
 
 	if (psmouse->pktcnt < 3)
@@ -257,25 +257,27 @@ static struct ps2pp_info *get_model_info
 static void ps2pp_set_model_properties(struct psmouse *psmouse, struct ps2pp_info *model_info,
 				       int using_ps2pp)
 {
+	struct input_dev *input_dev = psmouse->dev;
+
 	if (model_info->features & PS2PP_SIDE_BTN)
-		set_bit(BTN_SIDE, psmouse->dev.keybit);
+		set_bit(BTN_SIDE, input_dev->keybit);
 
 	if (model_info->features & PS2PP_EXTRA_BTN)
-		set_bit(BTN_EXTRA, psmouse->dev.keybit);
+		set_bit(BTN_EXTRA, input_dev->keybit);
 
 	if (model_info->features & PS2PP_TASK_BTN)
-		set_bit(BTN_TASK, psmouse->dev.keybit);
+		set_bit(BTN_TASK, input_dev->keybit);
 
 	if (model_info->features & PS2PP_NAV_BTN) {
-		set_bit(BTN_FORWARD, psmouse->dev.keybit);
-		set_bit(BTN_BACK, psmouse->dev.keybit);
+		set_bit(BTN_FORWARD, input_dev->keybit);
+		set_bit(BTN_BACK, input_dev->keybit);
 	}
 
 	if (model_info->features & PS2PP_WHEEL)
-		set_bit(REL_WHEEL, psmouse->dev.relbit);
+		set_bit(REL_WHEEL, input_dev->relbit);
 
 	if (model_info->features & PS2PP_HWHEEL)
-		set_bit(REL_HWHEEL, psmouse->dev.relbit);
+		set_bit(REL_HWHEEL, input_dev->relbit);
 
 	switch (model_info->kind) {
 		case PS2PP_KIND_WHEEL:
@@ -387,7 +389,7 @@ int ps2pp_init(struct psmouse *psmouse, 
 		}
 
 		if (buttons < 3)
-			clear_bit(BTN_MIDDLE, psmouse->dev.keybit);
+			clear_bit(BTN_MIDDLE, psmouse->dev->keybit);
 
 		if (model_info)
 			ps2pp_set_model_properties(psmouse, model_info, use_ps2pp);
diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index e90c60c..b5b34fe 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -41,13 +41,12 @@ static int dc_mouse_connect(struct maple
 	unsigned long data = be32_to_cpu(dev->devinfo.function_data[0]);
 	struct input_dev *input_dev;
 
-	if (!(input_dev = kmalloc(sizeof(struct input_dev), GFP_KERNEL)))
-		return -1;
+	dev->private_data = input_dev = input_allocate_device();
+	if (!input_dev)
+		return -ENOMEM;
 
 	dev->private_data = input_dev;
 
-	memset(input_dev, 0, sizeof(struct dc_mouse));
-	init_input_dev(input_dev);
 	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
 	input_dev->keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_RIGHT) | BIT(BTN_MIDDLE);
 	input_dev->relbit[0] = BIT(REL_X) | BIT(REL_Y) | BIT(REL_WHEEL);
@@ -59,8 +58,6 @@ static int dc_mouse_connect(struct maple
 
 	maple_getcond_callback(dev, dc_mouse_callback, 1, MAPLE_FUNC_MOUSE);
 
-	printk(KERN_INFO "input: mouse(0x%lx): %s\n", data, input_dev->name);
-
 	return 0;
 }
 
@@ -70,7 +67,6 @@ static void dc_mouse_disconnect(struct m
 	struct input_dev *input_dev = dev->private_data;
 
 	input_unregister_device(input_dev);
-	kfree(input_dev);
 }
 
 
diff --git a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
index 93393d5..d284ea7 100644
--- a/drivers/input/mouse/pc110pad.c
+++ b/drivers/input/mouse/pc110pad.c
@@ -53,13 +53,10 @@ MODULE_LICENSE("GPL");
 static int pc110pad_irq = 10;
 static int pc110pad_io = 0x15e0;
 
-static struct input_dev pc110pad_dev;
+static struct input_dev *pc110pad_dev;
 static int pc110pad_data[3];
 static int pc110pad_count;
 
-static char *pc110pad_name = "IBM PC110 TouchPad";
-static char *pc110pad_phys = "isa15e0/input0";
-
 static irqreturn_t pc110pad_interrupt(int irq, void *ptr, struct pt_regs *regs)
 {
 	int value     = inb_p(pc110pad_io);
@@ -74,14 +71,14 @@ static irqreturn_t pc110pad_interrupt(in
 	if (pc110pad_count < 3)
 		return IRQ_HANDLED;
 
-	input_regs(&pc110pad_dev, regs);
-	input_report_key(&pc110pad_dev, BTN_TOUCH,
+	input_regs(pc110pad_dev, regs);
+	input_report_key(pc110pad_dev, BTN_TOUCH,
 		pc110pad_data[0] & 0x01);
-	input_report_abs(&pc110pad_dev, ABS_X,
+	input_report_abs(pc110pad_dev, ABS_X,
 		pc110pad_data[1] | ((pc110pad_data[0] << 3) & 0x80) | ((pc110pad_data[0] << 1) & 0x100));
-	input_report_abs(&pc110pad_dev, ABS_Y,
+	input_report_abs(pc110pad_dev, ABS_Y,
 		pc110pad_data[2] | ((pc110pad_data[0] << 4) & 0x80));
-	input_sync(&pc110pad_dev);
+	input_sync(pc110pad_dev);
 
 	pc110pad_count = 0;
 	return IRQ_HANDLED;
@@ -94,9 +91,9 @@ static void pc110pad_close(struct input_
 
 static int pc110pad_open(struct input_dev *dev)
 {
-	pc110pad_interrupt(0,NULL,NULL);
-	pc110pad_interrupt(0,NULL,NULL);
-	pc110pad_interrupt(0,NULL,NULL);
+	pc110pad_interrupt(0, NULL, NULL);
+	pc110pad_interrupt(0, NULL, NULL);
+	pc110pad_interrupt(0, NULL, NULL);
 	outb(PC110PAD_ON, pc110pad_io + 2);
 	pc110pad_count = 0;
 
@@ -127,45 +124,46 @@ static int __init pc110pad_init(void)
 
 	outb(PC110PAD_OFF, pc110pad_io + 2);
 
-	if (request_irq(pc110pad_irq, pc110pad_interrupt, 0, "pc110pad", NULL))
-	{
+	if (request_irq(pc110pad_irq, pc110pad_interrupt, 0, "pc110pad", NULL)) {
 		release_region(pc110pad_io, 4);
 		printk(KERN_ERR "pc110pad: Unable to get irq %d.\n", pc110pad_irq);
 		return -EBUSY;
 	}
 
-        pc110pad_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-        pc110pad_dev.absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
-        pc110pad_dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
-
-	pc110pad_dev.absmax[ABS_X] = 0x1ff;
-	pc110pad_dev.absmax[ABS_Y] = 0x0ff;
-
-	pc110pad_dev.open = pc110pad_open;
-        pc110pad_dev.close = pc110pad_close;
-
-	pc110pad_dev.name = pc110pad_name;
-	pc110pad_dev.phys = pc110pad_phys;
-	pc110pad_dev.id.bustype = BUS_ISA;
-	pc110pad_dev.id.vendor = 0x0003;
-	pc110pad_dev.id.product = 0x0001;
-	pc110pad_dev.id.version = 0x0100;
+	if (!(pc110pad_dev = input_allocate_device())) {
+		free_irq(pc110pad_irq, NULL);
+		release_region(pc110pad_io, 4);
+		printk(KERN_ERR "pc110pad: Not enough memory.\n");
+		return -ENOMEM;
+	}
+
+	pc110pad_dev->name = "IBM PC110 TouchPad";
+	pc110pad_dev->phys = "isa15e0/input0";
+	pc110pad_dev->id.bustype = BUS_ISA;
+	pc110pad_dev->id.vendor = 0x0003;
+	pc110pad_dev->id.product = 0x0001;
+	pc110pad_dev->id.version = 0x0100;
+
+	pc110pad_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	pc110pad_dev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
+	pc110pad_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
 
-	input_register_device(&pc110pad_dev);
+	pc110pad_dev->absmax[ABS_X] = 0x1ff;
+	pc110pad_dev->absmax[ABS_Y] = 0x0ff;
 
-	printk(KERN_INFO "input: %s at %#x irq %d\n",
-		pc110pad_name, pc110pad_io, pc110pad_irq);
+	pc110pad_dev->open = pc110pad_open;
+	pc110pad_dev->close = pc110pad_close;
+
+	input_register_device(pc110pad_dev);
 
 	return 0;
 }
 
 static void __exit pc110pad_exit(void)
 {
-	input_unregister_device(&pc110pad_dev);
-
 	outb(PC110PAD_OFF, pc110pad_io + 2);
-
 	free_irq(pc110pad_irq, NULL);
+	input_unregister_device(pc110pad_dev);
 	release_region(pc110pad_io, 4);
 }
 
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index af24313..6ee9999 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -114,7 +114,7 @@ struct psmouse_protocol {
 
 static psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
-	struct input_dev *dev = &psmouse->dev;
+	struct input_dev *dev = psmouse->dev;
 	unsigned char *packet = psmouse->packet;
 
 	if (psmouse->pktcnt < psmouse->pktsize)
@@ -333,12 +333,11 @@ static int genius_detect(struct psmouse 
 		return -1;
 
 	if (set_properties) {
-		set_bit(BTN_EXTRA, psmouse->dev.keybit);
-		set_bit(BTN_SIDE, psmouse->dev.keybit);
-		set_bit(REL_WHEEL, psmouse->dev.relbit);
+		set_bit(BTN_EXTRA, psmouse->dev->keybit);
+		set_bit(BTN_SIDE, psmouse->dev->keybit);
+		set_bit(REL_WHEEL, psmouse->dev->relbit);
 
 		psmouse->vendor = "Genius";
-		psmouse->name = "Wheel Mouse";
 		psmouse->pktsize = 4;
 	}
 
@@ -365,8 +364,8 @@ static int intellimouse_detect(struct ps
 		return -1;
 
 	if (set_properties) {
-		set_bit(BTN_MIDDLE, psmouse->dev.keybit);
-		set_bit(REL_WHEEL, psmouse->dev.relbit);
+		set_bit(BTN_MIDDLE, psmouse->dev->keybit);
+		set_bit(REL_WHEEL, psmouse->dev->relbit);
 
 		if (!psmouse->vendor) psmouse->vendor = "Generic";
 		if (!psmouse->name) psmouse->name = "Wheel Mouse";
@@ -398,10 +397,10 @@ static int im_explorer_detect(struct psm
 		return -1;
 
 	if (set_properties) {
-		set_bit(BTN_MIDDLE, psmouse->dev.keybit);
-		set_bit(REL_WHEEL, psmouse->dev.relbit);
-		set_bit(BTN_SIDE, psmouse->dev.keybit);
-		set_bit(BTN_EXTRA, psmouse->dev.keybit);
+		set_bit(BTN_MIDDLE, psmouse->dev->keybit);
+		set_bit(REL_WHEEL, psmouse->dev->relbit);
+		set_bit(BTN_SIDE, psmouse->dev->keybit);
+		set_bit(BTN_EXTRA, psmouse->dev->keybit);
 
 		if (!psmouse->vendor) psmouse->vendor = "Generic";
 		if (!psmouse->name) psmouse->name = "Explorer Mouse";
@@ -433,7 +432,7 @@ static int thinking_detect(struct psmous
 		return -1;
 
 	if (set_properties) {
-		set_bit(BTN_EXTRA, psmouse->dev.keybit);
+		set_bit(BTN_EXTRA, psmouse->dev->keybit);
 
 		psmouse->vendor = "Kensington";
 		psmouse->name = "ThinkingMouse";
@@ -839,9 +838,9 @@ static void psmouse_disconnect(struct se
 
 	psmouse_set_state(psmouse, PSMOUSE_IGNORE);
 
-	input_unregister_device(&psmouse->dev);
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
+	input_unregister_device(psmouse->dev);
 	kfree(psmouse);
 
 	if (parent)
@@ -852,16 +851,14 @@ static void psmouse_disconnect(struct se
 
 static int psmouse_switch_protocol(struct psmouse *psmouse, struct psmouse_protocol *proto)
 {
-	memset(&psmouse->dev, 0, sizeof(struct input_dev));
+	struct input_dev *input_dev = psmouse->dev;
 
-	init_input_dev(&psmouse->dev);
+	input_dev->private = psmouse;
+	input_dev->cdev.dev = &psmouse->ps2dev.serio->dev;
 
-	psmouse->dev.private = psmouse;
-	psmouse->dev.dev = &psmouse->ps2dev.serio->dev;
-
-	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
-	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	input_dev->keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+	input_dev->relbit[0] = BIT(REL_X) | BIT(REL_Y);
 
 	psmouse->set_rate = psmouse_set_rate;
 	psmouse->set_resolution = psmouse_set_resolution;
@@ -883,12 +880,12 @@ static int psmouse_switch_protocol(struc
 	sprintf(psmouse->devname, "%s %s %s",
 		psmouse_protocol_by_type(psmouse->type)->name, psmouse->vendor, psmouse->name);
 
-	psmouse->dev.name = psmouse->devname;
-	psmouse->dev.phys = psmouse->phys;
-	psmouse->dev.id.bustype = BUS_I8042;
-	psmouse->dev.id.vendor = 0x0002;
-	psmouse->dev.id.product = psmouse->type;
-	psmouse->dev.id.version = psmouse->model;
+	input_dev->name = psmouse->devname;
+	input_dev->phys = psmouse->phys;
+	input_dev->id.bustype = BUS_I8042;
+	input_dev->id.vendor = 0x0002;
+	input_dev->id.product = psmouse->type;
+	input_dev->id.version = psmouse->model;
 
 	return 0;
 }
@@ -900,7 +897,8 @@ static int psmouse_switch_protocol(struc
 static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct psmouse *psmouse, *parent = NULL;
-	int retval;
+	struct input_dev *input_dev;
+	int retval = -ENOMEM;
 
 	down(&psmouse_sem);
 
@@ -913,12 +911,13 @@ static int psmouse_connect(struct serio 
 		psmouse_deactivate(parent);
 	}
 
-	if (!(psmouse = kzalloc(sizeof(struct psmouse), GFP_KERNEL))) {
-		retval = -ENOMEM;
+	psmouse = kzalloc(sizeof(struct psmouse), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!psmouse || !input_dev)
 		goto out;
-	}
 
 	ps2_init(&psmouse->ps2dev, serio);
+	psmouse->dev = input_dev;
 	sprintf(psmouse->phys, "%s/input0", serio->phys);
 
 	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
@@ -926,16 +925,11 @@ static int psmouse_connect(struct serio 
 	serio_set_drvdata(serio, psmouse);
 
 	retval = serio_open(serio, drv);
-	if (retval) {
-		serio_set_drvdata(serio, NULL);
-		kfree(psmouse);
+	if (retval)
 		goto out;
-	}
 
 	if (psmouse_probe(psmouse) < 0) {
 		serio_close(serio);
-		serio_set_drvdata(serio, NULL);
-		kfree(psmouse);
 		retval = -ENODEV;
 		goto out;
 	}
@@ -947,13 +941,11 @@ static int psmouse_connect(struct serio 
 
 	psmouse_switch_protocol(psmouse, NULL);
 
-	input_register_device(&psmouse->dev);
-	printk(KERN_INFO "input: %s on %s\n", psmouse->devname, serio->phys);
-
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
-
 	psmouse_initialize(psmouse);
 
+	input_register_device(psmouse->dev);
+
 	if (parent && parent->pt_activate)
 		parent->pt_activate(parent);
 
@@ -964,6 +956,12 @@ static int psmouse_connect(struct serio 
 	retval = 0;
 
 out:
+	if (retval) {
+		serio_set_drvdata(serio, NULL);
+		input_free_device(input_dev);
+		kfree(psmouse);
+	}
+
 	/* If this is a pass-through port the parent needs to be re-activated */
 	if (parent)
 		psmouse_activate(parent);
@@ -1161,6 +1159,7 @@ static ssize_t psmouse_attr_set_protocol
 {
 	struct serio *serio = psmouse->ps2dev.serio;
 	struct psmouse *parent = NULL;
+	struct input_dev *new_dev;
 	struct psmouse_protocol *proto;
 	int retry = 0;
 
@@ -1170,9 +1169,13 @@ static ssize_t psmouse_attr_set_protocol
 	if (psmouse->type == proto->type)
 		return count;
 
+	if (!(new_dev = input_allocate_device()))
+		return -ENOMEM;
+
 	while (serio->child) {
 		if (++retry > 3) {
 			printk(KERN_WARNING "psmouse: failed to destroy child port, protocol change aborted.\n");
+			input_free_device(new_dev);
 			return -EIO;
 		}
 
@@ -1182,11 +1185,15 @@ static ssize_t psmouse_attr_set_protocol
 		serio_pin_driver_uninterruptible(serio);
 		down(&psmouse_sem);
 
-		if (serio->drv != &psmouse_drv)
+		if (serio->drv != &psmouse_drv) {
+			input_free_device(new_dev);
 			return -ENODEV;
+		}
 
-		if (psmouse->type == proto->type)
+		if (psmouse->type == proto->type) {
+			input_free_device(new_dev);
 			return count; /* switched by other thread */
+		}
 	}
 
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
@@ -1199,8 +1206,9 @@ static ssize_t psmouse_attr_set_protocol
 		psmouse->disconnect(psmouse);
 
 	psmouse_set_state(psmouse, PSMOUSE_IGNORE);
-	input_unregister_device(&psmouse->dev);
+	input_unregister_device(psmouse->dev);
 
+	psmouse->dev = new_dev;
 	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
 
 	if (psmouse_switch_protocol(psmouse, proto) < 0) {
@@ -1212,8 +1220,7 @@ static ssize_t psmouse_attr_set_protocol
 	psmouse_initialize(psmouse);
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
-	input_register_device(&psmouse->dev);
-	printk(KERN_INFO "input: %s on %s\n", psmouse->devname, serio->phys);
+	input_register_device(psmouse->dev);
 
 	if (parent && parent->pt_activate)
 		parent->pt_activate(parent);
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 45d2bd7..7c4192b 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -36,7 +36,7 @@ typedef enum {
 
 struct psmouse {
 	void *private;
-	struct input_dev dev;
+	struct input_dev *dev;
 	struct ps2dev ps2dev;
 	char *vendor;
 	char *name;
diff --git a/drivers/input/mouse/rpcmouse.c b/drivers/input/mouse/rpcmouse.c
index 8fe1212..09b6ffd 100644
--- a/drivers/input/mouse/rpcmouse.c
+++ b/drivers/input/mouse/rpcmouse.c
@@ -34,20 +34,7 @@ MODULE_DESCRIPTION("Acorn RiscPC mouse d
 MODULE_LICENSE("GPL");
 
 static short rpcmouse_lastx, rpcmouse_lasty;
-
-static struct input_dev rpcmouse_dev = {
-	.evbit	= { BIT(EV_KEY) | BIT(EV_REL) },
-	.keybit = { [LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT) },
-	.relbit	= { BIT(REL_X) | BIT(REL_Y) },
-	.name	= "Acorn RiscPC Mouse",
-	.phys	= "rpcmouse/input0",
-	.id	= {
-		.bustype = BUS_HOST,
-		.vendor  = 0x0005,
-		.product = 0x0001,
-		.version = 0x0100,
-	},
-};
+static struct input_dev *rpcmouse_dev;
 
 static irqreturn_t rpcmouse_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
@@ -78,29 +65,41 @@ static irqreturn_t rpcmouse_irq(int irq,
 	return IRQ_HANDLED;
 }
 
+
 static int __init rpcmouse_init(void)
 {
-	init_input_dev(&rpcmouse_dev);
+	if (!(rpcmouse_dev = input_allocate_device()))
+		return -ENOMEM;
+
+	rpcmouse_dev->name = "Acorn RiscPC Mouse";
+	rpcmouse_dev->phys = "rpcmouse/input0";
+	rpcmouse_dev->id.bustype = BUS_HOST;
+	rpcmouse_dev->id.vendor  = 0x0005;
+	rpcmouse_dev->id.product = 0x0001;
+	rpcmouse_dev->id.version = 0x0100;
+
+	rpcmouse_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	rpcmouse_dev->keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+	rpcmouse_dev->relbit[0]	= BIT(REL_X) | BIT(REL_Y);
 
 	rpcmouse_lastx = (short) iomd_readl(IOMD_MOUSEX);
 	rpcmouse_lasty = (short) iomd_readl(IOMD_MOUSEY);
 
-	if (request_irq(IRQ_VSYNCPULSE, rpcmouse_irq, SA_SHIRQ, "rpcmouse", &rpcmouse_dev)) {
+	if (request_irq(IRQ_VSYNCPULSE, rpcmouse_irq, SA_SHIRQ, "rpcmouse", rpcmouse_dev)) {
 		printk(KERN_ERR "rpcmouse: unable to allocate VSYNC interrupt\n");
-		return -1;
+		input_free_device(rpcmouse_dev);
+		return -EBUSY;
 	}
 
-	input_register_device(&rpcmouse_dev);
-
-	printk(KERN_INFO "input: Acorn RiscPC mouse\n");
+	input_register_device(rpcmouse_dev);
 
 	return 0;
 }
 
 static void __exit rpcmouse_exit(void)
 {
-	input_unregister_device(&rpcmouse_dev);
-	free_irq(IRQ_VSYNCPULSE, &rpcmouse_dev);
+	free_irq(IRQ_VSYNCPULSE, rpcmouse_dev);
+	input_unregister_device(rpcmouse_dev);
 }
 
 module_init(rpcmouse_init);
diff --git a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
index d12b93a..4bf5843 100644
--- a/drivers/input/mouse/sermouse.c
+++ b/drivers/input/mouse/sermouse.c
@@ -48,7 +48,7 @@ static char *sermouse_protocols[] = { "N
 					"Logitech MZ++ Mouse"};
 
 struct sermouse {
-	struct input_dev dev;
+	struct input_dev *dev;
 	signed char buf[8];
 	unsigned char count;
 	unsigned char type;
@@ -64,7 +64,7 @@ struct sermouse {
 
 static void sermouse_process_msc(struct sermouse *sermouse, signed char data, struct pt_regs *regs)
 {
-	struct input_dev *dev = &sermouse->dev;
+	struct input_dev *dev = sermouse->dev;
 	signed char *buf = sermouse->buf;
 
 	input_regs(dev, regs);
@@ -107,7 +107,7 @@ static void sermouse_process_msc(struct 
 
 static void sermouse_process_ms(struct sermouse *sermouse, signed char data, struct pt_regs *regs)
 {
-	struct input_dev *dev = &sermouse->dev;
+	struct input_dev *dev = sermouse->dev;
 	signed char *buf = sermouse->buf;
 
 	if (data & 0x40) sermouse->count = 0;
@@ -230,9 +230,9 @@ static void sermouse_disconnect(struct s
 {
 	struct sermouse *sermouse = serio_get_drvdata(serio);
 
-	input_unregister_device(&sermouse->dev);
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
+	input_unregister_device(sermouse->dev);
 	kfree(sermouse);
 }
 
@@ -244,56 +244,52 @@ static void sermouse_disconnect(struct s
 static int sermouse_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct sermouse *sermouse;
-	unsigned char c;
-	int err;
-
-	if (!serio->id.proto || serio->id.proto > SERIO_MZPP)
-		return -ENODEV;
-
-	if (!(sermouse = kmalloc(sizeof(struct sermouse), GFP_KERNEL)))
-		return -ENOMEM;
-
-	memset(sermouse, 0, sizeof(struct sermouse));
-
-	init_input_dev(&sermouse->dev);
-	sermouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-	sermouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_RIGHT);
-	sermouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-	sermouse->dev.private = sermouse;
-
-	sermouse->type = serio->id.proto;
-	c = serio->id.extra;
-
-	if (c & 0x01) set_bit(BTN_MIDDLE, sermouse->dev.keybit);
-	if (c & 0x02) set_bit(BTN_SIDE, sermouse->dev.keybit);
-	if (c & 0x04) set_bit(BTN_EXTRA, sermouse->dev.keybit);
-	if (c & 0x10) set_bit(REL_WHEEL, sermouse->dev.relbit);
-	if (c & 0x20) set_bit(REL_HWHEEL, sermouse->dev.relbit);
+	struct input_dev *input_dev;
+	unsigned char c = serio->id.extra;
+	int err = -ENOMEM;
+
+	sermouse = kzalloc(sizeof(struct sermouse), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!sermouse || !input_dev)
+		goto fail;
 
+	sermouse->dev = input_dev;
 	sprintf(sermouse->phys, "%s/input0", serio->phys);
+	sermouse->type = serio->id.proto;
 
-	sermouse->dev.name = sermouse_protocols[sermouse->type];
-	sermouse->dev.phys = sermouse->phys;
-	sermouse->dev.id.bustype = BUS_RS232;
-	sermouse->dev.id.vendor = sermouse->type;
-	sermouse->dev.id.product = c;
-	sermouse->dev.id.version = 0x0100;
-	sermouse->dev.dev = &serio->dev;
+	input_dev->name = sermouse_protocols[sermouse->type];
+	input_dev->phys = sermouse->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->id.vendor  = sermouse->type;
+	input_dev->id.product = c;
+	input_dev->id.version = 0x0100;
+	input_dev->cdev.dev = &serio->dev;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	input_dev->keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_RIGHT);
+	input_dev->relbit[0] = BIT(REL_X) | BIT(REL_Y);
+	input_dev->private = sermouse;
+
+	if (c & 0x01) set_bit(BTN_MIDDLE, input_dev->keybit);
+	if (c & 0x02) set_bit(BTN_SIDE, input_dev->keybit);
+	if (c & 0x04) set_bit(BTN_EXTRA, input_dev->keybit);
+	if (c & 0x10) set_bit(REL_WHEEL, input_dev->relbit);
+	if (c & 0x20) set_bit(REL_HWHEEL, input_dev->relbit);
 
 	serio_set_drvdata(serio, sermouse);
 
 	err = serio_open(serio, drv);
-	if (err) {
-		serio_set_drvdata(serio, NULL);
-		kfree(sermouse);
-		return err;
-	}
-
-	input_register_device(&sermouse->dev);
+	if (err)
+		goto fail;
 
-	printk(KERN_INFO "input: %s on %s\n", sermouse_protocols[sermouse->type], serio->phys);
+	input_register_device(sermouse->dev);
 
 	return 0;
+
+ fail:	serio_set_drvdata(serio, NULL);
+	input_free_device(input_dev);
+	kfree(sermouse);
+	return err;
 }
 
 static struct serio_device_id sermouse_serio_ids[] = {
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 0293094..97cdfd6 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -342,7 +342,7 @@ static void synaptics_parse_hw_state(uns
  */
 static void synaptics_process_packet(struct psmouse *psmouse)
 {
-	struct input_dev *dev = &psmouse->dev;
+	struct input_dev *dev = psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
 	struct synaptics_hw_state hw;
 	int num_fingers;
@@ -473,7 +473,7 @@ static unsigned char synaptics_detect_pk
 
 static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
-	struct input_dev *dev = &psmouse->dev;
+	struct input_dev *dev = psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
 
 	input_regs(dev, regs);
@@ -645,7 +645,7 @@ int synaptics_init(struct psmouse *psmou
 		SYN_ID_MAJOR(priv->identity), SYN_ID_MINOR(priv->identity),
 		priv->model_id, priv->capabilities, priv->ext_cap);
 
-	set_input_params(&psmouse->dev, priv);
+	set_input_params(psmouse->dev, priv);
 
 	psmouse->protocol_handler = synaptics_process_byte;
 	psmouse->set_rate = synaptics_set_rate;
diff --git a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
index f024be9..36e9442 100644
--- a/drivers/input/mouse/vsxxxaa.c
+++ b/drivers/input/mouse/vsxxxaa.c
@@ -112,7 +112,7 @@ MODULE_LICENSE ("GPL");
 
 
 struct vsxxxaa {
-	struct input_dev dev;
+	struct input_dev *dev;
 	struct serio *serio;
 #define BUFLEN 15 /* At least 5 is needed for a full tablet packet */
 	unsigned char buf[BUFLEN];
@@ -211,7 +211,7 @@ vsxxxaa_smells_like_packet (struct vsxxx
 static void
 vsxxxaa_handle_REL_packet (struct vsxxxaa *mouse, struct pt_regs *regs)
 {
-	struct input_dev *dev = &mouse->dev;
+	struct input_dev *dev = mouse->dev;
 	unsigned char *buf = mouse->buf;
 	int left, middle, right;
 	int dx, dy;
@@ -269,7 +269,7 @@ vsxxxaa_handle_REL_packet (struct vsxxxa
 static void
 vsxxxaa_handle_ABS_packet (struct vsxxxaa *mouse, struct pt_regs *regs)
 {
-	struct input_dev *dev = &mouse->dev;
+	struct input_dev *dev = mouse->dev;
 	unsigned char *buf = mouse->buf;
 	int left, middle, right, touch;
 	int x, y;
@@ -323,7 +323,7 @@ vsxxxaa_handle_ABS_packet (struct vsxxxa
 static void
 vsxxxaa_handle_POR_packet (struct vsxxxaa *mouse, struct pt_regs *regs)
 {
-	struct input_dev *dev = &mouse->dev;
+	struct input_dev *dev = mouse->dev;
 	unsigned char *buf = mouse->buf;
 	int left, middle, right;
 	unsigned char error;
@@ -483,9 +483,9 @@ vsxxxaa_disconnect (struct serio *serio)
 {
 	struct vsxxxaa *mouse = serio_get_drvdata (serio);
 
-	input_unregister_device (&mouse->dev);
 	serio_close (serio);
 	serio_set_drvdata (serio, NULL);
+	input_unregister_device (mouse->dev);
 	kfree (mouse);
 }
 
@@ -493,61 +493,57 @@ static int
 vsxxxaa_connect (struct serio *serio, struct serio_driver *drv)
 {
 	struct vsxxxaa *mouse;
-	int err;
+	struct input_dev *input_dev;
+	int err = -ENOMEM;
 
-	if (!(mouse = kmalloc (sizeof (struct vsxxxaa), GFP_KERNEL)))
-		return -ENOMEM;
-
-	memset (mouse, 0, sizeof (struct vsxxxaa));
-
-	init_input_dev (&mouse->dev);
-	set_bit (EV_KEY, mouse->dev.evbit);		/* We have buttons */
-	set_bit (EV_REL, mouse->dev.evbit);
-	set_bit (EV_ABS, mouse->dev.evbit);
-	set_bit (BTN_LEFT, mouse->dev.keybit);		/* We have 3 buttons */
-	set_bit (BTN_MIDDLE, mouse->dev.keybit);
-	set_bit (BTN_RIGHT, mouse->dev.keybit);
-	set_bit (BTN_TOUCH, mouse->dev.keybit);		/* ...and Tablet */
-	set_bit (REL_X, mouse->dev.relbit);
-	set_bit (REL_Y, mouse->dev.relbit);
-	set_bit (ABS_X, mouse->dev.absbit);
-	set_bit (ABS_Y, mouse->dev.absbit);
-
-	mouse->dev.absmin[ABS_X] = 0;
-	mouse->dev.absmax[ABS_X] = 1023;
-	mouse->dev.absmin[ABS_Y] = 0;
-	mouse->dev.absmax[ABS_Y] = 1023;
-
-	mouse->dev.private = mouse;
+	mouse = kzalloc (sizeof (struct vsxxxaa), GFP_KERNEL);
+	input_dev = input_allocate_device ();
+	if (!mouse || !input_dev)
+		goto fail;
 
+	mouse->dev = input_dev;
+	mouse->serio = serio;
 	sprintf (mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer");
 	sprintf (mouse->phys, "%s/input0", serio->phys);
-	mouse->dev.name = mouse->name;
-	mouse->dev.phys = mouse->phys;
-	mouse->dev.id.bustype = BUS_RS232;
-	mouse->dev.dev = &serio->dev;
-	mouse->serio = serio;
+
+	input_dev->name = mouse->name;
+	input_dev->phys = mouse->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->cdev.dev = &serio->dev;
+	input_dev->private = mouse;
+
+	set_bit (EV_KEY, input_dev->evbit);		/* We have buttons */
+	set_bit (EV_REL, input_dev->evbit);
+	set_bit (EV_ABS, input_dev->evbit);
+	set_bit (BTN_LEFT, input_dev->keybit);		/* We have 3 buttons */
+	set_bit (BTN_MIDDLE, input_dev->keybit);
+	set_bit (BTN_RIGHT, input_dev->keybit);
+	set_bit (BTN_TOUCH, input_dev->keybit);		/* ...and Tablet */
+	set_bit (REL_X, input_dev->relbit);
+	set_bit (REL_Y, input_dev->relbit);
+	input_set_abs_params (input_dev, ABS_X, 0, 1023, 0, 0);
+	input_set_abs_params (input_dev, ABS_Y, 0, 1023, 0, 0);
 
 	serio_set_drvdata (serio, mouse);
 
 	err = serio_open (serio, drv);
-	if (err) {
-		serio_set_drvdata (serio, NULL);
-		kfree (mouse);
-		return err;
-	}
+	if (err)
+		goto fail;
 
 	/*
 	 * Request selftest. Standard packet format and differential
 	 * mode will be requested after the device ID'ed successfully.
 	 */
-	mouse->serio->write (mouse->serio, 'T'); /* Test */
-
-	input_register_device (&mouse->dev);
+	serio->write (serio, 'T'); /* Test */
 
-	printk (KERN_INFO "input: %s on %s\n", mouse->name, mouse->phys);
+	input_register_device (input_dev);
 
 	return 0;
+
+ fail:	serio_set_drvdata (serio, NULL);
+	input_free_device (input_dev);
+	kfree (mouse);
+	return err;
 }
 
 static struct serio_device_id vsxxaa_serio_ids[] = {

