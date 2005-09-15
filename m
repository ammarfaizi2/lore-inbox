Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbVIOHIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbVIOHIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbVIOHIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:08:21 -0400
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:38834 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030435AbVIOHEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:04:08 -0400
Message-Id: <20050915070303.839306000.dtor_core@ameritech.net>
References: <20050915070131.813650000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 02:01:46 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: [patch 15/28] drivers/input/touchscreen: convert to dynamic input_dev allocation
Content-Disposition: inline; filename=input-dynalloc-ts.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: convert drivers/input/touchscreen to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/corgi_ts.c       |   93 +++++++++---------
 drivers/input/touchscreen/elo.c            |   89 ++++++++---------
 drivers/input/touchscreen/gunze.c          |   66 ++++++------
 drivers/input/touchscreen/h3600_ts_input.c |  149 +++++++++++------------------
 drivers/input/touchscreen/hp680_ts_input.c |   58 +++++------
 drivers/input/touchscreen/mk712.c          |   80 +++++++--------
 drivers/input/touchscreen/mtouch.c         |   64 ++++++------
 7 files changed, 285 insertions(+), 314 deletions(-)

Index: work/drivers/input/touchscreen/gunze.c
===================================================================
--- work.orig/drivers/input/touchscreen/gunze.c
+++ work/drivers/input/touchscreen/gunze.c
@@ -48,14 +48,12 @@ MODULE_LICENSE("GPL");
 
 #define	GUNZE_MAX_LENGTH	10
 
-static char *gunze_name = "Gunze AHL-51S TouchScreen";
-
 /*
  * Per-touchscreen data.
  */
 
 struct gunze {
-	struct input_dev dev;
+	struct input_dev *dev;
 	struct serio *serio;
 	int idx;
 	unsigned char data[GUNZE_MAX_LENGTH];
@@ -64,7 +62,7 @@ struct gunze {
 
 static void gunze_process_packet(struct gunze* gunze, struct pt_regs *regs)
 {
-	struct input_dev *dev = &gunze->dev;
+	struct input_dev *dev = gunze->dev;
 
 	if (gunze->idx != GUNZE_MAX_LENGTH || gunze->data[5] != ',' ||
 		(gunze->data[0] != 'T' && gunze->data[0] != 'R')) {
@@ -100,11 +98,13 @@ static irqreturn_t gunze_interrupt(struc
 
 static void gunze_disconnect(struct serio *serio)
 {
-	struct gunze* gunze = serio_get_drvdata(serio);
+	struct gunze *gunze = serio_get_drvdata(serio);
 
-	input_unregister_device(&gunze->dev);
+	input_get_device(gunze->dev);
+	input_unregister_device(gunze->dev);
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
+	input_put_device(gunze->dev);
 	kfree(gunze);
 }
 
@@ -117,45 +117,45 @@ static void gunze_disconnect(struct seri
 static int gunze_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct gunze *gunze;
+	struct input_dev *input_dev;
 	int err;
 
-	if (!(gunze = kmalloc(sizeof(struct gunze), GFP_KERNEL)))
-		return -ENOMEM;
-
-	memset(gunze, 0, sizeof(struct gunze));
-
-	init_input_dev(&gunze->dev);
-	gunze->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-	gunze->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
-	input_set_abs_params(&gunze->dev, ABS_X, 24, 1000, 0, 0);
-	input_set_abs_params(&gunze->dev, ABS_Y, 24, 1000, 0, 0);
+	gunze = kzalloc(sizeof(struct gunze), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!gunze || !input_dev) {
+		err = -ENOMEM;
+		goto fail;
+	}
 
 	gunze->serio = serio;
-
+	gunze->dev = input_dev;
 	sprintf(gunze->phys, "%s/input0", serio->phys);
 
-	gunze->dev.private = gunze;
-	gunze->dev.name = gunze_name;
-	gunze->dev.phys = gunze->phys;
-	gunze->dev.id.bustype = BUS_RS232;
-	gunze->dev.id.vendor = SERIO_GUNZE;
-	gunze->dev.id.product = 0x0051;
-	gunze->dev.id.version = 0x0100;
+	input_dev->private = gunze;
+	input_dev->name = "Gunze AHL-51S TouchScreen";
+	input_dev->phys = gunze->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->id.vendor = SERIO_GUNZE;
+	input_dev->id.product = 0x0051;
+	input_dev->id.version = 0x0100;
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_set_abs_params(input_dev, ABS_X, 24, 1000, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 24, 1000, 0, 0);
 
 	serio_set_drvdata(serio, gunze);
 
 	err = serio_open(serio, drv);
-	if (err) {
-		serio_set_drvdata(serio, NULL);
-		kfree(gunze);
-		return err;
-	}
-
-	input_register_device(&gunze->dev);
-
-	printk(KERN_INFO "input: %s on %s\n", gunze_name, serio->phys);
+	if (err)
+		goto fail;
 
+	input_register_device(gunze->dev);
 	return 0;
+
+ fail:	serio_set_drvdata(serio, NULL);
+	input_free_device(input_dev);
+	kfree(gunze);
+	return err;
 }
 
 /*
Index: work/drivers/input/touchscreen/mk712.c
===================================================================
--- work.orig/drivers/input/touchscreen/mk712.c
+++ work/drivers/input/touchscreen/mk712.c
@@ -77,7 +77,7 @@ MODULE_PARM_DESC(irq, "IRQ of MK712 touc
 #define MK712_READ_ONE_POINT			0x20
 #define MK712_POWERUP				0x40
 
-static struct input_dev mk712_dev;
+static struct input_dev *mk712_dev;
 static DEFINE_SPINLOCK(mk712_lock);
 
 static irqreturn_t mk712_interrupt(int irq, void *dev_id, struct pt_regs *regs)
@@ -88,7 +88,7 @@ static irqreturn_t mk712_interrupt(int i
 	static unsigned short last_y;
 
 	spin_lock(&mk712_lock);
-	input_regs(&mk712_dev, regs);
+	input_regs(mk712_dev, regs);
 
 	status = inb(mk712_io + MK712_STATUS);
 
@@ -100,7 +100,7 @@ static irqreturn_t mk712_interrupt(int i
 	if (~status & MK712_STATUS_TOUCH)
 	{
 		debounce = 1;
-		input_report_key(&mk712_dev, BTN_TOUCH, 0);
+		input_report_key(mk712_dev, BTN_TOUCH, 0);
 		goto end;
 	}
 
@@ -110,15 +110,15 @@ static irqreturn_t mk712_interrupt(int i
 		goto end;
 	}
 
-	input_report_key(&mk712_dev, BTN_TOUCH, 1);
-	input_report_abs(&mk712_dev, ABS_X, last_x);
-	input_report_abs(&mk712_dev, ABS_Y, last_y);
+	input_report_key(mk712_dev, BTN_TOUCH, 1);
+	input_report_abs(mk712_dev, ABS_X, last_x);
+	input_report_abs(mk712_dev, ABS_Y, last_y);
 
 end:
 
 	last_x = inw(mk712_io + MK712_X) & 0x0fff;
 	last_y = inw(mk712_io + MK712_Y) & 0x0fff;
-	input_sync(&mk712_dev);
+	input_sync(mk712_dev);
 	spin_unlock(&mk712_lock);
 	return IRQ_HANDLED;
 }
@@ -154,30 +154,11 @@ static void mk712_close(struct input_dev
 	spin_unlock_irqrestore(&mk712_lock, flags);
 }
 
-static struct input_dev mk712_dev = {
-	.evbit   = { BIT(EV_KEY) | BIT(EV_ABS) },
-	.keybit  = { [LONG(BTN_TOUCH)] = BIT(BTN_TOUCH) },
-	.absbit  = { BIT(ABS_X) | BIT(ABS_Y) },
-	.open    = mk712_open,
-	.close   = mk712_close,
-	.name    = "ICS MicroClock MK712 TouchScreen",
-	.phys    = "isa0260/input0",
-	.absmin  = { [ABS_X] = 0, [ABS_Y] = 0 },
-	.absmax  = { [ABS_X] = 0xfff, [ABS_Y] = 0xfff },
-	.absfuzz = { [ABS_X] = 88, [ABS_Y] = 88 },
-	.id      = {
-		.bustype = BUS_ISA,
-		.vendor  = 0x0005,
-		.product = 0x0001,
-		.version = 0x0100,
-	},
-};
-
 int __init mk712_init(void)
 {
+	int err;
 
-	if(!request_region(mk712_io, 8, "mk712"))
-	{
+	if (!request_region(mk712_io, 8, "mk712")) {
 		printk(KERN_WARNING "mk712: unable to get IO region\n");
 		return -ENODEV;
 	}
@@ -188,28 +169,49 @@ int __init mk712_init(void)
 	    (inw(mk712_io + MK712_Y) & 0xf000) ||
 	    (inw(mk712_io + MK712_STATUS) & 0xf333)) {
 		printk(KERN_WARNING "mk712: device not present\n");
-		release_region(mk712_io, 8);
-		return -ENODEV;
+		err = -ENODEV;
+		goto fail;
 	}
 
-	if(request_irq(mk712_irq, mk712_interrupt, 0, "mk712", &mk712_dev))
-	{
-		printk(KERN_WARNING "mk712: unable to get IRQ\n");
-		release_region(mk712_io, 8);
-		return -EBUSY;
+	if (!(mk712_dev = input_allocate_device())) {
+		printk(KERN_ERR "mk712: not enough memory\n");
+		err = -ENOMEM;
+		goto fail;
 	}
 
-	input_register_device(&mk712_dev);
+	mk712_dev->name = "ICS MicroClock MK712 TouchScreen";
+	mk712_dev->phys = "isa0260/input0";
+	mk712_dev->id.bustype = BUS_ISA;
+	mk712_dev->id.vendor  = 0x0005;
+	mk712_dev->id.product = 0x0001;
+	mk712_dev->id.version = 0x0100;
+
+	mk712_dev->open    = mk712_open;
+	mk712_dev->close   = mk712_close;
 
-	printk(KERN_INFO "input: ICS MicroClock MK712 TouchScreen at %#x irq %d\n", mk712_io, mk712_irq);
+	mk712_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	mk712_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_set_abs_params(mk712_dev, ABS_X, 0, 0xfff, 88, 0);
+	input_set_abs_params(mk712_dev, ABS_Y, 0, 0xfff, 88, 0);
 
+	if (request_irq(mk712_irq, mk712_interrupt, 0, "mk712", mk712_dev)) {
+		printk(KERN_WARNING "mk712: unable to get IRQ\n");
+		err = -EBUSY;
+		goto fail;
+	}
+
+	input_register_device(mk712_dev);
 	return 0;
+
+ fail:	input_free_device(mk712_dev);
+	release_region(mk712_io, 8);
+	return err;
 }
 
 static void __exit mk712_exit(void)
 {
-	input_unregister_device(&mk712_dev);
-	free_irq(mk712_irq, &mk712_dev);
+	input_unregister_device(mk712_dev);
+	free_irq(mk712_irq, mk712_dev);
 	release_region(mk712_io, 8);
 }
 
Index: work/drivers/input/touchscreen/h3600_ts_input.c
===================================================================
--- work.orig/drivers/input/touchscreen/h3600_ts_input.c
+++ work/drivers/input/touchscreen/h3600_ts_input.c
@@ -39,7 +39,6 @@
 #include <linux/serio.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/pm.h>
 
 /* SA1100 serial defines */
 #include <asm/arch/hardware.h>
@@ -93,16 +92,12 @@ MODULE_LICENSE("GPL");
 #define H3600_SCANCODE_LEFT	8	 /* 8 -> left */
 #define H3600_SCANCODE_DOWN	9	 /* 9 -> down */
 
-static char *h3600_name = "H3600 TouchScreen";
-
 /*
  * Per-touchscreen data.
  */
 struct h3600_dev {
-	struct input_dev dev;
-	struct pm_dev *pm_dev;
+	struct input_dev *dev;
 	struct serio *serio;
-	struct pm_dev *pm_dev;
 	unsigned char event;	/* event ID from packet */
 	unsigned char chksum;
 	unsigned char len;
@@ -163,33 +158,6 @@ unsigned int h3600_flite_power(struct in
 	return 0;
 }
 
-static int suspended = 0;
-static int h3600ts_pm_callback(struct pm_dev *pm_dev, pm_request_t req,
-				void *data)
-{
-	struct input_dev *dev = (struct input_dev *) data;
-
-	switch (req) {
-	case PM_SUSPEND: /* enter D1-D3 */
-		suspended = 1;
-		h3600_flite_power(dev, FLITE_PWR_OFF);
-		break;
-	case PM_BLANK:
-		if (!suspended)
-			h3600_flite_power(dev, FLITE_PWR_OFF);
-		break;
-	case PM_RESUME:  /* enter D0 */
-		/* same as unblank */
-	case PM_UNBLANK:
-		if (suspended) {
-			//initSerial();
-			suspended = 0;
-		}
-		h3600_flite_power(dev, FLITE_PWR_ON);
-		break;
-	}
-	return 0;
-}
 #endif
 
 /*
@@ -199,7 +167,7 @@ static int h3600ts_pm_callback(struct pm
  */
 static void h3600ts_process_packet(struct h3600_dev *ts, struct pt_regs *regs)
 {
-	struct input_dev *dev = &ts->dev;
+	struct input_dev *dev = ts->dev;
 	static int touched = 0;
 	int key, down = 0;
 
@@ -295,6 +263,7 @@ static void h3600ts_process_packet(struc
 static int h3600ts_event(struct input_dev *dev, unsigned int type,
 			 unsigned int code, int value)
 {
+#if 0
 	struct h3600_dev *ts = dev->private;
 
 	switch (type) {
@@ -304,6 +273,8 @@ static int h3600ts_event(struct input_de
 		}
 	}
 	return -1;
+#endif
+	return 0;
 }
 
 /*
@@ -380,14 +351,48 @@ static irqreturn_t h3600ts_interrupt(str
 static int h3600ts_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct h3600_dev *ts;
+	struct input_dev *input_dev;
 	int err;
 
-	if (!(ts = kmalloc(sizeof(struct h3600_dev), GFP_KERNEL)))
-		return -ENOMEM;
+	ts = kzalloc(sizeof(struct h3600_dev), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ts || !input_dev) {
+		err = -ENOMEM;
+		goto fail1;
+	}
 
-	memset(ts, 0, sizeof(struct h3600_dev));
+	ts->serio = serio;
+	ts->dev = input_dev;
+	sprintf(ts->phys, "%s/input0", serio->phys);
 
-	init_input_dev(&ts->dev);
+	input_dev->name = "H3600 TouchScreen";
+	input_dev->phys = ts->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->id.vendor = SERIO_H3600;
+	input_dev->id.product = 0x0666;  /* FIXME !!! We can ask the hardware */
+	input_dev->id.version = 0x0100;
+	input_dev->cdev.dev = &serio->dev;
+	input_dev->private = ts;
+
+	input_dev->event = h3600ts_event;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_LED) | BIT(EV_PWR);
+	input_dev->ledbit[0] = BIT(LED_SLEEP);
+	input_set_abs_params(input_dev, ABS_X, 60, 985, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 35, 1024, 0, 0);
+
+	set_bit(KEY_RECORD, input_dev->keybit);
+	set_bit(KEY_Q, input_dev->keybit);
+	set_bit(KEY_PROG1, input_dev->keybit);
+	set_bit(KEY_PROG2, input_dev->keybit);
+	set_bit(KEY_PROG3, input_dev->keybit);
+	set_bit(KEY_UP, input_dev->keybit);
+	set_bit(KEY_RIGHT, input_dev->keybit);
+	set_bit(KEY_LEFT, input_dev->keybit);
+	set_bit(KEY_DOWN, input_dev->keybit);
+	set_bit(KEY_ENTER, input_dev->keybit);
+	set_bit(KEY_SUSPEND, input_dev->keybit);
+	set_bit(BTN_TOUCH, input_dev->keybit);
 
 	/* Device specific stuff */
 	set_GPIO_IRQ_edge(GPIO_BITSY_ACTION_BUTTON, GPIO_BOTH_EDGES);
@@ -397,73 +402,35 @@ static int h3600ts_connect(struct serio 
 			SA_SHIRQ | SA_INTERRUPT | SA_SAMPLE_RANDOM,
 			"h3600_action", &ts->dev)) {
 		printk(KERN_ERR "h3600ts.c: Could not allocate Action Button IRQ!\n");
-		kfree(ts);
-		return -EBUSY;
+		err = -EBUSY;
+		goto fail2;
 	}
 
 	if (request_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, npower_button_handler,
 			SA_SHIRQ | SA_INTERRUPT | SA_SAMPLE_RANDOM,
 			"h3600_suspend", &ts->dev)) {
-		free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, &ts->dev);
 		printk(KERN_ERR "h3600ts.c: Could not allocate Power Button IRQ!\n");
-		kfree(ts);
-		return -EBUSY;
+		err = -EBUSY;
+		goto fail3;
 	}
 
-	/* Now we have things going we setup our input device */
-	ts->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_LED) | BIT(EV_PWR);
-	ts->dev.ledbit[0] = BIT(LED_SLEEP);
-	input_set_abs_params(&ts->dev, ABS_X, 60, 985, 0, 0);
-	input_set_abs_params(&ts->dev, ABS_Y, 35, 1024, 0, 0);
-
-	set_bit(KEY_RECORD, ts->dev.keybit);
-	set_bit(KEY_Q, ts->dev.keybit);
-	set_bit(KEY_PROG1, ts->dev.keybit);
-	set_bit(KEY_PROG2, ts->dev.keybit);
-	set_bit(KEY_PROG3, ts->dev.keybit);
-	set_bit(KEY_UP, ts->dev.keybit);
-	set_bit(KEY_RIGHT, ts->dev.keybit);
-	set_bit(KEY_LEFT, ts->dev.keybit);
-	set_bit(KEY_DOWN, ts->dev.keybit);
-	set_bit(KEY_ENTER, ts->dev.keybit);
-	ts->dev.keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
-	ts->dev.keybit[LONG(KEY_SUSPEND)] |= BIT(KEY_SUSPEND);
-
-	ts->serio = serio;
-
-	sprintf(ts->phys, "%s/input0", serio->phys);
-
-	ts->dev.event = h3600ts_event;
-	ts->dev.private = ts;
-	ts->dev.name = h3600_name;
-	ts->dev.phys = ts->phys;
-	ts->dev.id.bustype = BUS_RS232;
-	ts->dev.id.vendor = SERIO_H3600;
-	ts->dev.id.product = 0x0666;  /* FIXME !!! We can ask the hardware */
-	ts->dev.id.version = 0x0100;
-
 	serio_set_drvdata(serio, ts);
 
 	err = serio_open(serio, drv);
-	if (err) {
-		free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, ts);
-		free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, ts);
-		serio_set_drvdata(serio, NULL);
-		kfree(ts);
+	if (err)
 		return err;
-	}
 
 	//h3600_flite_control(1, 25);     /* default brightness */
-#ifdef CONFIG_PM
-	ts->pm_dev = pm_register(PM_ILLUMINATION_DEV, PM_SYS_LIGHT,
-				h3600ts_pm_callback);
-	printk("registered pm callback\n");
-#endif
-	input_register_device(&ts->dev);
-
-	printk(KERN_INFO "input: %s on %s\n", h3600_name, serio->phys);
+	input_register_device(ts->dev);
 
 	return 0;
+
+fail3:	free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, ts->dev);
+fail2:	free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, ts->dev);
+fail1:	serio_set_drvdata(serio, NULL);
+	input_free_device(input_dev);
+	kfree(ts);
+	return err;
 }
 
 /*
@@ -476,9 +443,11 @@ static void h3600ts_disconnect(struct se
 
 	free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, &ts->dev);
 	free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, &ts->dev);
-	input_unregister_device(&ts->dev);
+	input_get_device(ts->dev);
+	input_unregister_device(ts->dev);
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
+	input_put_device(ts->dev);
 	kfree(ts);
 }
 
Index: work/drivers/input/touchscreen/corgi_ts.c
===================================================================
--- work.orig/drivers/input/touchscreen/corgi_ts.c
+++ work/drivers/input/touchscreen/corgi_ts.c
@@ -41,8 +41,7 @@ struct ts_event {
 };
 
 struct corgi_ts {
-	char phys[32];
-	struct input_dev input;
+	struct input_dev *input;
 	struct timer_list timer;
 	struct ts_event tc;
 	int pendown;
@@ -182,14 +181,12 @@ static void new_data(struct corgi_ts *co
 	if (!corgi_ts->tc.pressure && corgi_ts->pendown == 0)
 		return;
 
-	if (regs)
-		input_regs(&corgi_ts->input, regs);
-
-	input_report_abs(&corgi_ts->input, ABS_X, corgi_ts->tc.x);
-	input_report_abs(&corgi_ts->input, ABS_Y, corgi_ts->tc.y);
-	input_report_abs(&corgi_ts->input, ABS_PRESSURE, corgi_ts->tc.pressure);
-	input_report_key(&corgi_ts->input, BTN_TOUCH, (corgi_ts->pendown != 0));
-	input_sync(&corgi_ts->input);
+	input_regs(corgi_ts->input, regs);
+	input_report_abs(corgi_ts->input, ABS_X, corgi_ts->tc.x);
+	input_report_abs(corgi_ts->input, ABS_Y, corgi_ts->tc.y);
+	input_report_abs(corgi_ts->input, ABS_PRESSURE, corgi_ts->tc.pressure);
+	input_report_key(corgi_ts->input, BTN_TOUCH, (corgi_ts->pendown != 0));
+	input_sync(corgi_ts->input);
 }
 
 static void ts_interrupt_main(struct corgi_ts *corgi_ts, int isTimer, struct pt_regs *regs)
@@ -273,39 +270,44 @@ static int __init corgits_probe(struct d
 {
 	struct corgi_ts *corgi_ts;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct input_dev *input_dev;
+	int err = -ENOMEM;
 
-	if (!(corgi_ts = kmalloc(sizeof(struct corgi_ts), GFP_KERNEL)))
-		return -ENOMEM;
+	corgi_ts = kzalloc(sizeof(struct corgi_ts), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!corgi_ts || !input_dev)
+		goto fail;
 
 	dev_set_drvdata(dev, corgi_ts);
 
-	memset(corgi_ts, 0, sizeof(struct corgi_ts));
-
 	corgi_ts->machinfo = dev->platform_data;
 	corgi_ts->irq_gpio = platform_get_irq(pdev, 0);
 
 	if (corgi_ts->irq_gpio < 0) {
-		kfree(corgi_ts);
-		return -ENODEV;
+		err = -ENODEV;
+		goto fail;
 	}
 
-	init_input_dev(&corgi_ts->input);
-	corgi_ts->input.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-	corgi_ts->input.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
-	input_set_abs_params(&corgi_ts->input, ABS_X, X_AXIS_MIN, X_AXIS_MAX, 0, 0);
-	input_set_abs_params(&corgi_ts->input, ABS_Y, Y_AXIS_MIN, Y_AXIS_MAX, 0, 0);
-	input_set_abs_params(&corgi_ts->input, ABS_PRESSURE, PRESSURE_MIN, PRESSURE_MAX, 0, 0);
-
-	strcpy(corgi_ts->phys, "corgits/input0");
-
-	corgi_ts->input.private = corgi_ts;
-	corgi_ts->input.name = "Corgi Touchscreen";
-	corgi_ts->input.dev = dev;
-	corgi_ts->input.phys = corgi_ts->phys;
-	corgi_ts->input.id.bustype = BUS_HOST;
-	corgi_ts->input.id.vendor = 0x0001;
-	corgi_ts->input.id.product = 0x0002;
-	corgi_ts->input.id.version = 0x0100;
+	corgi_ts->input = input_dev;
+
+	init_timer(&corgi_ts->timer);
+	corgi_ts->timer.data = (unsigned long) corgi_ts;
+	corgi_ts->timer.function = corgi_ts_timer;
+
+	input_dev->name = "Corgi Touchscreen";
+	input_dev->phys = "corgits/input0";
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->id.vendor = 0x0001;
+	input_dev->id.product = 0x0002;
+	input_dev->id.version = 0x0100;
+	input_dev->cdev.dev = dev;
+	input_dev->private = corgi_ts;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_set_abs_params(input_dev, ABS_X, X_AXIS_MIN, X_AXIS_MAX, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, Y_AXIS_MIN, Y_AXIS_MAX, 0, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE, PRESSURE_MIN, PRESSURE_MAX, 0, 0);
 
 	pxa_gpio_mode(IRQ_TO_GPIO(corgi_ts->irq_gpio) | GPIO_IN);
 
@@ -319,25 +321,24 @@ static int __init corgits_probe(struct d
 	corgi_ssp_ads7846_putget((5u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
 	mdelay(5);
 
-	init_timer(&corgi_ts->timer);
-	corgi_ts->timer.data = (unsigned long) corgi_ts;
-	corgi_ts->timer.function = corgi_ts_timer;
-
-	input_register_device(&corgi_ts->input);
-	corgi_ts->power_mode = PWR_MODE_ACTIVE;
-
 	if (request_irq(corgi_ts->irq_gpio, ts_interrupt, SA_INTERRUPT, "ts", corgi_ts)) {
-		input_unregister_device(&corgi_ts->input);
-		kfree(corgi_ts);
-		return -EBUSY;
+		err = -EBUSY;
+		goto fail;
 	}
 
+	input_register_device(corgi_ts->input);
+
+	corgi_ts->power_mode = PWR_MODE_ACTIVE;
+
 	/* Enable Falling Edge */
 	set_irq_type(corgi_ts->irq_gpio, IRQT_FALLING);
 
-	printk(KERN_INFO "input: Corgi Touchscreen Registered\n");
-
 	return 0;
+
+ fail:	input_free_device(input_dev);
+	kfree(corgi_ts);
+	return err;
+
 }
 
 static int corgits_remove(struct device *dev)
@@ -347,7 +348,7 @@ static int corgits_remove(struct device 
 	free_irq(corgi_ts->irq_gpio, NULL);
 	del_timer_sync(&corgi_ts->timer);
 	corgi_ts->machinfo->put_hsync();
-	input_unregister_device(&corgi_ts->input);
+	input_unregister_device(corgi_ts->input);
 	kfree(corgi_ts);
 	return 0;
 }
Index: work/drivers/input/touchscreen/elo.c
===================================================================
--- work.orig/drivers/input/touchscreen/elo.c
+++ work/drivers/input/touchscreen/elo.c
@@ -36,14 +36,12 @@ MODULE_LICENSE("GPL");
 
 #define	ELO_MAX_LENGTH	10
 
-static char *elo_name = "Elo Serial TouchScreen";
-
 /*
  * Per-touchscreen data.
  */
 
 struct elo {
-	struct input_dev dev;
+	struct input_dev *dev;
 	struct serio *serio;
 	int id;
 	int idx;
@@ -54,7 +52,7 @@ struct elo {
 
 static void elo_process_data_10(struct elo* elo, unsigned char data, struct pt_regs *regs)
 {
-	struct input_dev *dev = &elo->dev;
+	struct input_dev *dev = elo->dev;
 
 	elo->csum += elo->data[elo->idx] = data;
 
@@ -80,7 +78,7 @@ static void elo_process_data_10(struct e
 				input_report_abs(dev, ABS_X, (elo->data[4] << 8) | elo->data[3]);
 				input_report_abs(dev, ABS_Y, (elo->data[6] << 8) | elo->data[5]);
 				input_report_abs(dev, ABS_PRESSURE, (elo->data[8] << 8) | elo->data[7]);
-				input_report_key(dev, BTN_TOUCH, elo->data[2] & 3);
+				input_report_key(dev, BTN_TOUCH, elo->data[8] || elo->data[7]);
 				input_sync(dev);
 			}
 			elo->idx = 0;
@@ -91,7 +89,7 @@ static void elo_process_data_10(struct e
 
 static void elo_process_data_6(struct elo* elo, unsigned char data, struct pt_regs *regs)
 {
-	struct input_dev *dev = &elo->dev;
+	struct input_dev *dev = elo->dev;
 
 	elo->data[elo->idx] = data;
 
@@ -129,7 +127,7 @@ static void elo_process_data_6(struct el
 		case 5:
 			if ((data & 0xf0) == 0) {
 				input_report_abs(dev, ABS_PRESSURE, elo->data[5]);
-				input_report_key(dev, BTN_TOUCH, elo->data[5]);
+				input_report_key(dev, BTN_TOUCH, !!elo->data[5]);
 			}
 			input_sync(dev);
 			elo->idx = 0;
@@ -139,7 +137,7 @@ static void elo_process_data_6(struct el
 
 static void elo_process_data_3(struct elo* elo, unsigned char data, struct pt_regs *regs)
 {
-	struct input_dev *dev = &elo->dev;
+	struct input_dev *dev = elo->dev;
 
 	elo->data[elo->idx] = data;
 
@@ -191,7 +189,7 @@ static void elo_disconnect(struct serio 
 {
 	struct elo* elo = serio_get_drvdata(serio);
 
-	input_unregister_device(&elo->dev);
+	input_unregister_device(elo->dev);
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
 	kfree(elo);
@@ -206,67 +204,68 @@ static void elo_disconnect(struct serio 
 static int elo_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct elo *elo;
+	struct input_dev *input_dev;
 	int err;
 
-	if (!(elo = kmalloc(sizeof(struct elo), GFP_KERNEL)))
-		return -ENOMEM;
+	elo = kzalloc(sizeof(struct elo), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!elo || !input_dev) {
+		err = -ENOMEM;
+		goto fail;
+	}
 
-	memset(elo, 0, sizeof(struct elo));
+	elo->serio = serio;
+	elo->id = serio->id.id;
+	elo->dev = input_dev;
+	snprintf(elo->phys, sizeof(elo->phys), "%s/input0", serio->phys);
 
-	init_input_dev(&elo->dev);
-	elo->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-	elo->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_dev->private = elo;
+	input_dev->name = "Elo Serial TouchScreen";
+	input_dev->phys = elo->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->id.vendor = SERIO_ELO;
+	input_dev->id.product = elo->id;
+	input_dev->id.version = 0x0100;
+	input_dev->cdev.dev = &serio->dev;
 
-	elo->id = serio->id.id;
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
 
 	switch (elo->id) {
 
 		case 0: /* 10-byte protocol */
-			input_set_abs_params(&elo->dev, ABS_X, 96, 4000, 0, 0);
-			input_set_abs_params(&elo->dev, ABS_Y, 96, 4000, 0, 0);
-			input_set_abs_params(&elo->dev, ABS_PRESSURE, 0, 255, 0, 0);
+			input_set_abs_params(input_dev, ABS_X, 96, 4000, 0, 0);
+			input_set_abs_params(input_dev, ABS_Y, 96, 4000, 0, 0);
+			input_set_abs_params(input_dev, ABS_PRESSURE, 0, 255, 0, 0);
 			break;
 
 		case 1: /* 6-byte protocol */
-			input_set_abs_params(&elo->dev, ABS_PRESSURE, 0, 15, 0, 0);
+			input_set_abs_params(input_dev, ABS_PRESSURE, 0, 15, 0, 0);
 
 		case 2: /* 4-byte protocol */
-			input_set_abs_params(&elo->dev, ABS_X, 96, 4000, 0, 0);
-			input_set_abs_params(&elo->dev, ABS_Y, 96, 4000, 0, 0);
+			input_set_abs_params(input_dev, ABS_X, 96, 4000, 0, 0);
+			input_set_abs_params(input_dev, ABS_Y, 96, 4000, 0, 0);
 			break;
 
 		case 3: /* 3-byte protocol */
-			input_set_abs_params(&elo->dev, ABS_X, 0, 255, 0, 0);
-			input_set_abs_params(&elo->dev, ABS_Y, 0, 255, 0, 0);
+			input_set_abs_params(input_dev, ABS_X, 0, 255, 0, 0);
+			input_set_abs_params(input_dev, ABS_Y, 0, 255, 0, 0);
 			break;
 	}
 
-	elo->serio = serio;
-
-	sprintf(elo->phys, "%s/input0", serio->phys);
-
-	elo->dev.private = elo;
-	elo->dev.name = elo_name;
-	elo->dev.phys = elo->phys;
-	elo->dev.id.bustype = BUS_RS232;
-	elo->dev.id.vendor = SERIO_ELO;
-	elo->dev.id.product = elo->id;
-	elo->dev.id.version = 0x0100;
-
 	serio_set_drvdata(serio, elo);
 
 	err = serio_open(serio, drv);
-	if (err) {
-		serio_set_drvdata(serio, NULL);
-		kfree(elo);
-		return err;
-	}
-
-	input_register_device(&elo->dev);
-
-	printk(KERN_INFO "input: %s on %s\n", elo_name, serio->phys);
+	if (err)
+		goto fail;
 
+	input_register_device(elo->dev);
 	return 0;
+
+ fail:	serio_set_drvdata(serio, NULL);
+	input_free_device(input_dev);
+	kfree(elo);
+	return err;
 }
 
 /*
Index: work/drivers/input/touchscreen/mtouch.c
===================================================================
--- work.orig/drivers/input/touchscreen/mtouch.c
+++ work/drivers/input/touchscreen/mtouch.c
@@ -51,14 +51,12 @@ MODULE_LICENSE("GPL");
 #define MTOUCH_GET_YC(data) (((data[4])<<7) | data[3])
 #define MTOUCH_GET_TOUCHED(data) (MTOUCH_FORMAT_TABLET_TOUCH_BIT & data[0])
 
-static char *mtouch_name = "MicroTouch Serial TouchScreen";
-
 /*
  * Per-touchscreen data.
  */
 
 struct mtouch {
-	struct input_dev dev;
+	struct input_dev *dev;
 	struct serio *serio;
 	int idx;
 	unsigned char data[MTOUCH_MAX_LENGTH];
@@ -67,7 +65,7 @@ struct mtouch {
 
 static void mtouch_process_format_tablet(struct mtouch *mtouch, struct pt_regs *regs)
 {
-	struct input_dev *dev = &mtouch->dev;
+	struct input_dev *dev = mtouch->dev;
 
 	if (MTOUCH_FORMAT_TABLET_LENGTH == ++mtouch->idx) {
 		input_regs(dev, regs);
@@ -116,9 +114,11 @@ static void mtouch_disconnect(struct ser
 {
 	struct mtouch* mtouch = serio_get_drvdata(serio);
 
-	input_unregister_device(&mtouch->dev);
+	input_get_device(mtouch->dev);
+	input_unregister_device(mtouch->dev);
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
+	input_put_device(mtouch->dev);
 	kfree(mtouch);
 }
 
@@ -131,46 +131,46 @@ static void mtouch_disconnect(struct ser
 static int mtouch_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct mtouch *mtouch;
+	struct input_dev *input_dev;
 	int err;
 
-	if (!(mtouch = kmalloc(sizeof(*mtouch), GFP_KERNEL)))
-		return -ENOMEM;
-
-	memset(mtouch, 0, sizeof(*mtouch));
-
-	init_input_dev(&mtouch->dev);
-	mtouch->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-	mtouch->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
-
-	input_set_abs_params(&mtouch->dev, ABS_X, MTOUCH_MIN_XC, MTOUCH_MAX_XC, 0, 0);
-	input_set_abs_params(&mtouch->dev, ABS_Y, MTOUCH_MIN_YC, MTOUCH_MAX_YC, 0, 0);
+	mtouch = kzalloc(sizeof(struct mtouch), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!mtouch || !input_dev) {
+		err = -ENOMEM;
+		goto fail;
+	}
 
 	mtouch->serio = serio;
-
+	mtouch->dev = input_dev;
 	sprintf(mtouch->phys, "%s/input0", serio->phys);
 
-	mtouch->dev.private = mtouch;
-	mtouch->dev.name = mtouch_name;
-	mtouch->dev.phys = mtouch->phys;
-	mtouch->dev.id.bustype = BUS_RS232;
-	mtouch->dev.id.vendor = SERIO_MICROTOUCH;
-	mtouch->dev.id.product = 0;
-	mtouch->dev.id.version = 0x0100;
+	input_dev->private = mtouch;
+	input_dev->name = "MicroTouch Serial TouchScreen";
+	input_dev->phys = mtouch->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->id.vendor = SERIO_MICROTOUCH;
+	input_dev->id.product = 0;
+	input_dev->id.version = 0x0100;
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_set_abs_params(mtouch->dev, ABS_X, MTOUCH_MIN_XC, MTOUCH_MAX_XC, 0, 0);
+	input_set_abs_params(mtouch->dev, ABS_Y, MTOUCH_MIN_YC, MTOUCH_MAX_YC, 0, 0);
 
 	serio_set_drvdata(serio, mtouch);
 
 	err = serio_open(serio, drv);
-	if (err) {
-		serio_set_drvdata(serio, NULL);
-		kfree(mtouch);
-		return err;
-	}
-
-	input_register_device(&mtouch->dev);
+	if (err)
+		goto fail;
 
-	printk(KERN_INFO "input: %s on %s\n", mtouch->dev.name, serio->phys);
+	input_register_device(mtouch->dev);
 
 	return 0;
+
+ fail:	serio_set_drvdata(serio, NULL);
+	input_free_device(input_dev);
+	kfree(mtouch);
+	return err;
 }
 
 /*
Index: work/drivers/input/touchscreen/hp680_ts_input.c
===================================================================
--- work.orig/drivers/input/touchscreen/hp680_ts_input.c
+++ work/drivers/input/touchscreen/hp680_ts_input.c
@@ -21,10 +21,8 @@
 
 static void do_softint(void *data);
 
-static struct input_dev hp680_ts_dev;
+static struct input_dev *hp680_ts_dev;
 static DECLARE_WORK(work, do_softint, 0);
-static char *hp680_ts_name = "HP Jornada touchscreen";
-static char *hp680_ts_phys = "input0";
 
 static void do_softint(void *data)
 {
@@ -58,14 +56,14 @@ static void do_softint(void *data)
 	}
 
 	if (touched) {
-		input_report_key(&hp680_ts_dev, BTN_TOUCH, 1);
-		input_report_abs(&hp680_ts_dev, ABS_X, absx);
-		input_report_abs(&hp680_ts_dev, ABS_Y, absy);
+		input_report_key(hp680_ts_dev, BTN_TOUCH, 1);
+		input_report_abs(hp680_ts_dev, ABS_X, absx);
+		input_report_abs(hp680_ts_dev, ABS_Y, absy);
 	} else {
-		input_report_key(&hp680_ts_dev, BTN_TOUCH, 0);
+		input_report_key(hp680_ts_dev, BTN_TOUCH, 0);
 	}
 
-	input_sync(&hp680_ts_dev);
+	input_sync(hp680_ts_dev);
 	enable_irq(HP680_TS_IRQ);
 }
 
@@ -92,27 +90,29 @@ static int __init hp680_ts_init(void)
 	scpcr |= SCPCR_TS_ENABLE;
 	ctrl_outw(scpcr, SCPCR);
 
-	memset(&hp680_ts_dev, 0, sizeof(hp680_ts_dev));
-	init_input_dev(&hp680_ts_dev);
-
-	hp680_ts_dev.evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
-	hp680_ts_dev.absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
-	hp680_ts_dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
-
-	hp680_ts_dev.absmin[ABS_X] = HP680_TS_ABS_X_MIN;
-	hp680_ts_dev.absmin[ABS_Y] = HP680_TS_ABS_Y_MIN;
-	hp680_ts_dev.absmax[ABS_X] = HP680_TS_ABS_X_MAX;
-	hp680_ts_dev.absmax[ABS_Y] = HP680_TS_ABS_Y_MAX;
-
-	hp680_ts_dev.name = hp680_ts_name;
-	hp680_ts_dev.phys = hp680_ts_phys;
-	input_register_device(&hp680_ts_dev);
-
-	if (request_irq
-	    (HP680_TS_IRQ, hp680_ts_interrupt, SA_INTERRUPT, MODNAME, 0) < 0) {
-		printk(KERN_ERR "hp680_touchscreen.c : Can't allocate irq %d\n",
+	hp680_ts_dev = input_allocate_device();
+	if (!hp680_ts_dev)
+		return -ENOMEM;
+
+	hp680_ts_dev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
+	hp680_ts_dev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
+	hp680_ts_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+
+	hp680_ts_dev->absmin[ABS_X] = HP680_TS_ABS_X_MIN;
+	hp680_ts_dev->absmin[ABS_Y] = HP680_TS_ABS_Y_MIN;
+	hp680_ts_dev->absmax[ABS_X] = HP680_TS_ABS_X_MAX;
+	hp680_ts_dev->absmax[ABS_Y] = HP680_TS_ABS_Y_MAX;
+
+	hp680_ts_dev->name = "HP Jornada touchscreen";
+	hp680_ts_dev->phys = "hp680_ts/input0";
+
+	input_register_device(hp680_ts_dev);
+
+	if (request_irq(HP680_TS_IRQ, hp680_ts_interrupt,
+			SA_INTERRUPT, MODNAME, 0) < 0) {
+		printk(KERN_ERR "hp680_touchscreen.c: Can't allocate irq %d\n",
 		       HP680_TS_IRQ);
-		input_unregister_device(&hp680_ts_dev);
+		input_unregister_device(hp680_ts_dev);
 		return -EBUSY;
 	}
 
@@ -124,7 +124,7 @@ static void __exit hp680_ts_exit(void)
 	free_irq(HP680_TS_IRQ, 0);
 	cancel_delayed_work(&work);
 	flush_scheduled_work();
-	input_unregister_device(&hp680_ts_dev);
+	input_unregister_device(hp680_ts_dev);
 }
 
 module_init(hp680_ts_init);

