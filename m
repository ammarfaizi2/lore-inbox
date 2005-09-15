Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbVIOHGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbVIOHGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbVIOHGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:06:18 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:27815 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030444AbVIOHEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:04:10 -0400
Message-Id: <20050915070305.039413000.dtor_core@ameritech.net>
References: <20050915070131.813650000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 02:01:53 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: [patch 22/28] drivers/media: convert to dynamic input_dev allocation
Content-Disposition: inline; filename=input-dynalloc-media.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: convert drivers/media to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/media/common/ir-common.c            |    1 
 drivers/media/dvb/cinergyT2/cinergyT2.c     |  108 ++++++++++++++++++----------
 drivers/media/dvb/dvb-usb/dvb-usb-remote.c  |   50 +++++++-----
 drivers/media/dvb/dvb-usb/dvb-usb.h         |    3 
 drivers/media/dvb/ttpci/av7110_ir.c         |   37 +++++----
 drivers/media/dvb/ttpci/budget-ci.c         |   24 +++---
 drivers/media/dvb/ttusb-dec/ttusb_dec.c     |   51 ++++++++-----
 drivers/media/video/bttvp.h                 |    2 
 drivers/media/video/cx88/cx88-input.c       |   58 ++++++++-------
 drivers/media/video/ir-kbd-gpio.c           |   52 +++++++------
 drivers/media/video/ir-kbd-i2c.c            |   33 ++++----
 drivers/media/video/saa7134/saa7134-input.c |   39 +++++-----
 drivers/media/video/saa7134/saa7134.h       |    2 
 13 files changed, 268 insertions(+), 192 deletions(-)

Index: work/drivers/media/video/ir-kbd-i2c.c
===================================================================
--- work.orig/drivers/media/video/ir-kbd-i2c.c
+++ work/drivers/media/video/ir-kbd-i2c.c
@@ -121,10 +121,9 @@ static IR_KEYTAB_TYPE ir_codes_purpletv[
 
 };
 
-struct IR;
 struct IR {
 	struct i2c_client      c;
-	struct input_dev       input;
+	struct input_dev       *input;
 	struct ir_input_state  ir;
 
 	struct work_struct     work;
@@ -271,9 +270,9 @@ static void ir_key_poll(struct IR *ir)
 	}
 
 	if (0 == rc) {
-		ir_input_nokey(&ir->input,&ir->ir);
+		ir_input_nokey(ir->input, &ir->ir);
 	} else {
-		ir_input_keydown(&ir->input,&ir->ir, ir_key, ir_raw);
+		ir_input_keydown(ir->input, &ir->ir, ir_key, ir_raw);
 	}
 }
 
@@ -318,11 +317,18 @@ static int ir_attach(struct i2c_adapter 
 	char *name;
 	int ir_type;
         struct IR *ir;
+	struct input_dev *input_dev;
 
-        if (NULL == (ir = kmalloc(sizeof(struct IR),GFP_KERNEL)))
+	ir = kzalloc(sizeof(struct IR), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ir || !input_dev) {
+		kfree(ir);
+		input_free_device(input_dev);
                 return -ENOMEM;
-	memset(ir,0,sizeof(*ir));
+	}
+
 	ir->c = client_template;
+	ir->input = input_dev;
 
 	i2c_set_clientdata(&ir->c, ir);
 	ir->c.adapter = adap;
@@ -375,13 +381,12 @@ static int ir_attach(struct i2c_adapter 
 		 ir->c.dev.bus_id);
 
 	/* init + register input device */
-	ir_input_init(&ir->input,&ir->ir,ir_type,ir_codes);
-	ir->input.id.bustype = BUS_I2C;
-	ir->input.name       = ir->c.name;
-	ir->input.phys       = ir->phys;
-	input_register_device(&ir->input);
-	printk(DEVNAME ": %s detected at %s [%s]\n",
-	       ir->input.name,ir->input.phys,adap->name);
+	ir_input_init(input_dev, &ir->ir, ir_type, ir_codes);
+	input_dev->id.bustype	= BUS_I2C;
+	input_dev->name		= ir->c.name;
+	input_dev->phys		= ir->phys;
+
+	input_register_device(ir->input);
 
 	/* start polling via eventd */
 	INIT_WORK(&ir->work, ir_work, ir);
@@ -402,7 +407,7 @@ static int ir_detach(struct i2c_client *
 	flush_scheduled_work();
 
 	/* unregister devices */
-	input_unregister_device(&ir->input);
+	input_unregister_device(ir->input);
 	i2c_detach_client(&ir->c);
 
 	/* free memory */
Index: work/drivers/media/video/ir-kbd-gpio.c
===================================================================
--- work.orig/drivers/media/video/ir-kbd-gpio.c
+++ work/drivers/media/video/ir-kbd-gpio.c
@@ -158,7 +158,7 @@ static IR_KEYTAB_TYPE ir_codes_apac_view
 
 struct IR {
 	struct bttv_sub_device  *sub;
-	struct input_dev        input;
+	struct input_dev        *input;
 	struct ir_input_state   ir;
 	char                    name[32];
 	char                    phys[32];
@@ -217,23 +217,23 @@ static void ir_handle_key(struct IR *ir)
 	if (ir->mask_keydown) {
 		/* bit set on keydown */
 		if (gpio & ir->mask_keydown) {
-			ir_input_keydown(&ir->input,&ir->ir,data,data);
+			ir_input_keydown(ir->input, &ir->ir, data, data);
 		} else {
-			ir_input_nokey(&ir->input,&ir->ir);
+			ir_input_nokey(ir->input, &ir->ir);
 		}
 
 	} else if (ir->mask_keyup) {
 		/* bit cleared on keydown */
 		if (0 == (gpio & ir->mask_keyup)) {
-			ir_input_keydown(&ir->input,&ir->ir,data,data);
+			ir_input_keydown(ir->input, &ir->ir, data, data);
 		} else {
-			ir_input_nokey(&ir->input,&ir->ir);
+			ir_input_nokey(ir->input, &ir->ir);
 		}
 
 	} else {
 		/* can't disturgissh keydown/up :-/ */
-		ir_input_keydown(&ir->input,&ir->ir,data,data);
-		ir_input_nokey(&ir->input,&ir->ir);
+		ir_input_keydown(ir->input, &ir->ir, data, data);
+		ir_input_nokey(ir->input, &ir->ir);
 	}
 }
 
@@ -268,13 +268,17 @@ static int ir_probe(struct device *dev)
 {
 	struct bttv_sub_device *sub = to_bttv_sub_dev(dev);
 	struct IR *ir;
+	struct input_dev *input_dev;
 	IR_KEYTAB_TYPE *ir_codes = NULL;
 	int ir_type = IR_TYPE_OTHER;
 
-	ir = kmalloc(sizeof(*ir),GFP_KERNEL);
-	if (NULL == ir)
+	ir = kzalloc(sizeof(*ir), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ir || !input_dev) {
+		kfree(ir);
+		input_free_device(input_dev);
 		return -ENOMEM;
-	memset(ir,0,sizeof(*ir));
+	}
 
 	/* detect & configure */
 	switch (sub->core->type) {
@@ -328,6 +332,7 @@ static int ir_probe(struct device *dev)
 	}
 	if (NULL == ir_codes) {
 		kfree(ir);
+		input_free_device(input_dev);
 		return -ENODEV;
 	}
 
@@ -341,19 +346,19 @@ static int ir_probe(struct device *dev)
 	snprintf(ir->phys, sizeof(ir->phys), "pci-%s/ir0",
 		 pci_name(sub->core->pci));
 
-	ir_input_init(&ir->input, &ir->ir, ir_type, ir_codes);
-	ir->input.name = ir->name;
-	ir->input.phys = ir->phys;
-	ir->input.id.bustype = BUS_PCI;
-	ir->input.id.version = 1;
+	ir_input_init(input_dev, &ir->ir, ir_type, ir_codes);
+	input_dev->name = ir->name;
+	input_dev->phys = ir->phys;
+	input_dev->id.bustype = BUS_PCI;
+	input_dev->id.version = 1;
 	if (sub->core->pci->subsystem_vendor) {
-		ir->input.id.vendor  = sub->core->pci->subsystem_vendor;
-		ir->input.id.product = sub->core->pci->subsystem_device;
+		input_dev->id.vendor  = sub->core->pci->subsystem_vendor;
+		input_dev->id.product = sub->core->pci->subsystem_device;
 	} else {
-		ir->input.id.vendor  = sub->core->pci->vendor;
-		ir->input.id.product = sub->core->pci->device;
+		input_dev->id.vendor  = sub->core->pci->vendor;
+		input_dev->id.product = sub->core->pci->device;
 	}
-	ir->input.dev = &sub->core->pci->dev;
+	input_dev->cdev.dev = &sub->core->pci->dev;
 
 	if (ir->polling) {
 		INIT_WORK(&ir->work, ir_work, ir);
@@ -364,9 +369,8 @@ static int ir_probe(struct device *dev)
 	}
 
 	/* all done */
-	dev_set_drvdata(dev,ir);
-	input_register_device(&ir->input);
-	printk(DEVNAME ": %s detected at %s\n",ir->input.name,ir->input.phys);
+	dev_set_drvdata(dev, ir);
+	input_register_device(ir->input);
 
 	return 0;
 }
@@ -380,7 +384,7 @@ static int ir_remove(struct device *dev)
 		flush_scheduled_work();
 	}
 
-	input_unregister_device(&ir->input);
+	input_unregister_device(ir->input);
 	kfree(ir);
 	return 0;
 }
Index: work/drivers/media/video/saa7134/saa7134.h
===================================================================
--- work.orig/drivers/media/video/saa7134/saa7134.h
+++ work/drivers/media/video/saa7134/saa7134.h
@@ -351,7 +351,7 @@ struct saa7134_oss {
 
 /* IR input */
 struct saa7134_ir {
-	struct input_dev           dev;
+	struct input_dev           *dev;
 	struct ir_input_state      ir;
 	char                       name[32];
 	char                       phys[32];
Index: work/drivers/media/video/saa7134/saa7134-input.c
===================================================================
--- work.orig/drivers/media/video/saa7134/saa7134-input.c
+++ work/drivers/media/video/saa7134/saa7134-input.c
@@ -425,9 +425,9 @@ static int build_key(struct saa7134_dev 
 
 	if ((ir->mask_keydown  &&  (0 != (gpio & ir->mask_keydown))) ||
 	    (ir->mask_keyup    &&  (0 == (gpio & ir->mask_keyup)))) {
-		ir_input_keydown(&ir->dev,&ir->ir,data,data);
+		ir_input_keydown(ir->dev, &ir->ir, data, data);
 	} else {
-		ir_input_nokey(&ir->dev,&ir->ir);
+		ir_input_nokey(ir->dev, &ir->ir);
 	}
 	return 0;
 }
@@ -456,6 +456,7 @@ static void saa7134_input_timer(unsigned
 int saa7134_input_init1(struct saa7134_dev *dev)
 {
 	struct saa7134_ir *ir;
+	struct input_dev *input_dev;
 	IR_KEYTAB_TYPE *ir_codes = NULL;
 	u32 mask_keycode = 0;
 	u32 mask_keydown = 0;
@@ -535,10 +536,13 @@ int saa7134_input_init1(struct saa7134_d
 		return -ENODEV;
 	}
 
-	ir = kmalloc(sizeof(*ir),GFP_KERNEL);
-	if (NULL == ir)
+	ir = kzalloc(sizeof(*ir), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ir || !input_dev) {
+		kfree(ir);
+		input_free_device(input_dev);
 		return -ENOMEM;
-	memset(ir,0,sizeof(*ir));
+	}
 
 	/* init hardware-specific stuff */
 	ir->mask_keycode = mask_keycode;
@@ -552,19 +556,19 @@ int saa7134_input_init1(struct saa7134_d
 	snprintf(ir->phys, sizeof(ir->phys), "pci-%s/ir0",
 		 pci_name(dev->pci));
 
-	ir_input_init(&ir->dev, &ir->ir, ir_type, ir_codes);
-	ir->dev.name = ir->name;
-	ir->dev.phys = ir->phys;
-	ir->dev.id.bustype = BUS_PCI;
-	ir->dev.id.version = 1;
+	ir_input_init(input_dev, &ir->ir, ir_type, ir_codes);
+	input_dev->name = ir->name;
+	input_dev->phys = ir->phys;
+	input_dev->id.bustype = BUS_PCI;
+	input_dev->id.version = 1;
 	if (dev->pci->subsystem_vendor) {
-		ir->dev.id.vendor  = dev->pci->subsystem_vendor;
-		ir->dev.id.product = dev->pci->subsystem_device;
+		input_dev->id.vendor  = dev->pci->subsystem_vendor;
+		input_dev->id.product = dev->pci->subsystem_device;
 	} else {
-		ir->dev.id.vendor  = dev->pci->vendor;
-		ir->dev.id.product = dev->pci->device;
+		input_dev->id.vendor  = dev->pci->vendor;
+		input_dev->id.product = dev->pci->device;
 	}
-	ir->dev.dev = &dev->pci->dev;
+	input_dev->cdev.dev = &dev->pci->dev;
 
 	/* all done */
 	dev->remote = ir;
@@ -576,8 +580,7 @@ int saa7134_input_init1(struct saa7134_d
 		add_timer(&ir->timer);
 	}
 
-	input_register_device(&dev->remote->dev);
-	printk("%s: registered input device for IR\n",dev->name);
+	input_register_device(ir->dev);
 	return 0;
 }
 
@@ -586,9 +589,9 @@ void saa7134_input_fini(struct saa7134_d
 	if (NULL == dev->remote)
 		return;
 
-	input_unregister_device(&dev->remote->dev);
 	if (dev->remote->polling)
 		del_timer_sync(&dev->remote->timer);
+	input_unregister_device(dev->remote->dev);
 	kfree(dev->remote);
 	dev->remote = NULL;
 }
Index: work/drivers/media/video/bttvp.h
===================================================================
--- work.orig/drivers/media/video/bttvp.h
+++ work/drivers/media/video/bttvp.h
@@ -240,7 +240,7 @@ struct bttv_pll_info {
 
 /* for gpio-connected remote control */
 struct bttv_input {
-	struct input_dev      dev;
+	struct input_dev      *dev;
 	struct ir_input_state ir;
 	char                  name[32];
 	char                  phys[32];
Index: work/drivers/media/dvb/ttpci/budget-ci.c
===================================================================
--- work.orig/drivers/media/dvb/ttpci/budget-ci.c
+++ work/drivers/media/dvb/ttpci/budget-ci.c
@@ -64,7 +64,7 @@
 
 struct budget_ci {
 	struct budget budget;
-	struct input_dev input_dev;
+	struct input_dev *input_dev;
 	struct tasklet_struct msp430_irq_tasklet;
 	struct tasklet_struct ciintf_irq_tasklet;
 	int slot_status;
@@ -145,7 +145,7 @@ static void msp430_ir_debounce(unsigned 
 static void msp430_ir_interrupt(unsigned long data)
 {
 	struct budget_ci *budget_ci = (struct budget_ci *) data;
-	struct input_dev *dev = &budget_ci->input_dev;
+	struct input_dev *dev = budget_ci->input_dev;
 	unsigned int code =
 		ttpci_budget_debiread(&budget_ci->budget, DEBINOSWAP, DEBIADDR_IR, 2, 1, 0) >> 8;
 
@@ -181,25 +181,27 @@ static void msp430_ir_interrupt(unsigned
 static int msp430_ir_init(struct budget_ci *budget_ci)
 {
 	struct saa7146_dev *saa = budget_ci->budget.dev;
+	struct input_dev *input_dev;
 	int i;
 
-	memset(&budget_ci->input_dev, 0, sizeof(struct input_dev));
+	budget_ci->input_dev = input_dev = input_allocate_device();
+	if (!input_dev)
+		return -ENOMEM;
 
 	sprintf(budget_ci->ir_dev_name, "Budget-CI dvb ir receiver %s", saa->name);
-	budget_ci->input_dev.name = budget_ci->ir_dev_name;
 
-	set_bit(EV_KEY, budget_ci->input_dev.evbit);
+	input_dev->name = budget_ci->ir_dev_name;
 
-	for (i = 0; i < sizeof(key_map) / sizeof(*key_map); i++)
+	set_bit(EV_KEY, input_dev->evbit);
+	for (i = 0; i < ARRAY_SIZE(key_map); i++)
 		if (key_map[i])
-			set_bit(key_map[i], budget_ci->input_dev.keybit);
+			set_bit(key_map[i], input_dev->keybit);
 
-	input_register_device(&budget_ci->input_dev);
+	input_register_device(budget_ci->input_dev);
 
-	budget_ci->input_dev.timer.function = msp430_ir_debounce;
+	input_dev->timer.function = msp430_ir_debounce;
 
 	saa7146_write(saa, IER, saa7146_read(saa, IER) | MASK_06);
-
 	saa7146_setgpio(saa, 3, SAA7146_GPIO_IRQHI);
 
 	return 0;
@@ -208,7 +210,7 @@ static int msp430_ir_init(struct budget_
 static void msp430_ir_deinit(struct budget_ci *budget_ci)
 {
 	struct saa7146_dev *saa = budget_ci->budget.dev;
-	struct input_dev *dev = &budget_ci->input_dev;
+	struct input_dev *dev = budget_ci->input_dev;
 
 	saa7146_write(saa, IER, saa7146_read(saa, IER) & ~MASK_06);
 	saa7146_setgpio(saa, 3, SAA7146_GPIO_INPUT);
Index: work/drivers/media/dvb/cinergyT2/cinergyT2.c
===================================================================
--- work.orig/drivers/media/dvb/cinergyT2/cinergyT2.c
+++ work/drivers/media/dvb/cinergyT2/cinergyT2.c
@@ -137,7 +137,8 @@ struct cinergyt2 {
 	struct urb *stream_urb [STREAM_URB_COUNT];
 
 #ifdef ENABLE_RC
-	struct input_dev rc_input_dev;
+	struct input_dev *rc_input_dev;
+	char phys[64];
 	struct work_struct rc_query_work;
 	int rc_input_event;
 	u32 rc_last_code;
@@ -683,6 +684,7 @@ static struct dvb_device cinergyt2_fe_te
 };
 
 #ifdef ENABLE_RC
+
 static void cinergyt2_query_rc (void *data)
 {
 	struct cinergyt2 *cinergyt2 = data;
@@ -703,7 +705,7 @@ static void cinergyt2_query_rc (void *da
 			/* stop key repeat */
 			if (cinergyt2->rc_input_event != KEY_MAX) {
 				dprintk(1, "rc_input_event=%d Up\n", cinergyt2->rc_input_event);
-				input_report_key(&cinergyt2->rc_input_dev,
+				input_report_key(cinergyt2->rc_input_dev,
 						 cinergyt2->rc_input_event, 0);
 				cinergyt2->rc_input_event = KEY_MAX;
 			}
@@ -722,7 +724,7 @@ static void cinergyt2_query_rc (void *da
 			/* keyrepeat bit -> just repeat last rc_input_event */
 		} else {
 			cinergyt2->rc_input_event = KEY_MAX;
-			for (i = 0; i < sizeof(rc_keys) / sizeof(rc_keys[0]); i += 3) {
+			for (i = 0; i < ARRAY_SIZE(rc_keys); i += 3) {
 				if (rc_keys[i + 0] == rc_events[n].type &&
 				    rc_keys[i + 1] == le32_to_cpu(rc_events[n].value)) {
 					cinergyt2->rc_input_event = rc_keys[i + 2];
@@ -736,11 +738,11 @@ static void cinergyt2_query_rc (void *da
 			    cinergyt2->rc_last_code != ~0) {
 				/* emit a key-up so the double event is recognized */
 				dprintk(1, "rc_input_event=%d UP\n", cinergyt2->rc_input_event);
-				input_report_key(&cinergyt2->rc_input_dev,
+				input_report_key(cinergyt2->rc_input_dev,
 						 cinergyt2->rc_input_event, 0);
 			}
 			dprintk(1, "rc_input_event=%d\n", cinergyt2->rc_input_event);
-			input_report_key(&cinergyt2->rc_input_dev,
+			input_report_key(cinergyt2->rc_input_dev,
 					 cinergyt2->rc_input_event, 1);
 			cinergyt2->rc_last_code = rc_events[n].value;
 		}
@@ -752,7 +754,59 @@ out:
 
 	up(&cinergyt2->sem);
 }
-#endif
+
+static int cinergyt2_register_rc(struct cinergyt2 *cinergyt2)
+{
+	struct input_dev *input_dev;
+	int i;
+
+	cinergyt2->rc_input_dev = input_dev = input_allocate_device();
+	if (!input_dev)
+		return -ENOMEM;
+
+	usb_make_path(cinergyt2->udev, cinergyt2->phys, sizeof(cinergyt2->phys));
+	strlcat(cinergyt2->phys, "/input0", sizeof(cinergyt2->phys));
+	cinergyt2->rc_input_event = KEY_MAX;
+	cinergyt2->rc_last_code = ~0;
+	INIT_WORK(&cinergyt2->rc_query_work, cinergyt2_query_rc, cinergyt2);
+
+	input_dev->name = DRIVER_NAME " remote control";
+	input_dev->phys = cinergyt2->phys;
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	for (i = 0; ARRAY_SIZE(rc_keys); i += 3)
+		set_bit(rc_keys[i + 2], input_dev->keybit);
+	input_dev->keycodesize = 0;
+	input_dev->keycodemax = 0;
+
+	input_register_device(cinergyt2->rc_input_dev);
+	schedule_delayed_work(&cinergyt2->rc_query_work, HZ/2);
+}
+
+static void cinergyt2_unregister_rc(struct cinergyt2 *cinergyt2)
+{
+	cancel_delayed_work(&cinergyt2->rc_query_work);
+	flush_scheduled_work();
+	input_unregister_device(cinergyt2->rc_input_dev);
+}
+
+static inline void cinergyt2_suspend_rc(struct cinergyt2 *cinergyt2)
+{
+	cancel_delayed_work(&cinergyt2->rc_query_work);
+}
+
+static inline void cinergyt2_resume_rc(struct cinergyt2 *cinergyt2)
+{
+	schedule_delayed_work(&cinergyt2->rc_query_work, HZ/2);
+}
+
+#else
+
+static inline int cinergyt2_register_rc(struct cinergyt2 *cinergyt2) { return 0; }
+static inline void cinergyt2_unregister_rc(struct cinergyt2 *cinergyt2) { }
+static inline void cinergyt2_suspend_rc(struct cinergyt2 *cinergyt2) { }
+static inline void cinergyt2_resume_rc(struct cinergyt2 *cinergyt2) { }
+
+#endif /* ENABLE_RC */
 
 static void cinergyt2_query (void *data)
 {
@@ -789,9 +843,6 @@ static int cinergyt2_probe (struct usb_i
 {
 	struct cinergyt2 *cinergyt2;
 	int err;
-#ifdef ENABLE_RC
-	int i;
-#endif
 
 	if (!(cinergyt2 = kmalloc (sizeof(struct cinergyt2), GFP_KERNEL))) {
 		dprintk(1, "out of memory?!?\n");
@@ -846,30 +897,17 @@ static int cinergyt2_probe (struct usb_i
 			    &cinergyt2_fe_template, cinergyt2,
 			    DVB_DEVICE_FRONTEND);
 
-#ifdef ENABLE_RC
-	cinergyt2->rc_input_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
-	cinergyt2->rc_input_dev.keycodesize = 0;
-	cinergyt2->rc_input_dev.keycodemax = 0;
-	cinergyt2->rc_input_dev.name = DRIVER_NAME " remote control";
-
-	for (i = 0; i < sizeof(rc_keys) / sizeof(rc_keys[0]); i += 3)
-		set_bit(rc_keys[i + 2], cinergyt2->rc_input_dev.keybit);
-
-	input_register_device(&cinergyt2->rc_input_dev);
-
-	cinergyt2->rc_input_event = KEY_MAX;
-	cinergyt2->rc_last_code = ~0;
+	err = cinergyt2_register_rc(cinergyt2);
+	if (err)
+		goto bailout;
 
-	INIT_WORK(&cinergyt2->rc_query_work, cinergyt2_query_rc, cinergyt2);
-	schedule_delayed_work(&cinergyt2->rc_query_work, HZ/2);
-#endif
 	return 0;
 
 bailout:
 	dvb_dmxdev_release(&cinergyt2->dmxdev);
 	dvb_dmx_release(&cinergyt2->demux);
-	dvb_unregister_adapter (&cinergyt2->adapter);
-	cinergyt2_free_stream_urbs (cinergyt2);
+	dvb_unregister_adapter(&cinergyt2->adapter);
+	cinergyt2_free_stream_urbs(cinergyt2);
 	kfree(cinergyt2);
 	return -ENOMEM;
 }
@@ -881,11 +919,7 @@ static void cinergyt2_disconnect (struct
 	if (down_interruptible(&cinergyt2->sem))
 		return;
 
-#ifdef ENABLE_RC
-	cancel_delayed_work(&cinergyt2->rc_query_work);
-	flush_scheduled_work();
-	input_unregister_device(&cinergyt2->rc_input_dev);
-#endif
+	cinergyt2_unregister_rc(cinergyt2);
 
 	cinergyt2->demux.dmx.close(&cinergyt2->demux.dmx);
 	dvb_net_release(&cinergyt2->dvbnet);
@@ -908,9 +942,8 @@ static int cinergyt2_suspend (struct usb
 
 	if (state.event > PM_EVENT_ON) {
 		struct cinergyt2 *cinergyt2 = usb_get_intfdata (intf);
-#ifdef ENABLE_RC
-		cancel_delayed_work(&cinergyt2->rc_query_work);
-#endif
+
+		cinergyt2_suspend_rc(cinergyt2);
 		cancel_delayed_work(&cinergyt2->query_work);
 		if (cinergyt2->streaming)
 			cinergyt2_stop_stream_xfer(cinergyt2);
@@ -938,9 +971,8 @@ static int cinergyt2_resume (struct usb_
 		schedule_delayed_work(&cinergyt2->query_work, HZ/2);
 	}
 
-#ifdef ENABLE_RC
-	schedule_delayed_work(&cinergyt2->rc_query_work, HZ/2);
-#endif
+	cinergyt2_resume_rc(cinergyt2);
+
 	up(&cinergyt2->sem);
 	return 0;
 }
Index: work/drivers/media/common/ir-common.c
===================================================================
--- work.orig/drivers/media/common/ir-common.c
+++ work/drivers/media/common/ir-common.c
@@ -252,7 +252,6 @@ void ir_input_init(struct input_dev *dev
 	if (ir_codes)
 		memcpy(ir->ir_codes, ir_codes, sizeof(ir->ir_codes));
 
-        init_input_dev(dev);
 	dev->keycode     = ir->ir_codes;
 	dev->keycodesize = sizeof(IR_KEYTAB_TYPE);
 	dev->keycodemax  = IR_KEYTAB_SIZE;
Index: work/drivers/media/dvb/dvb-usb/dvb-usb-remote.c
===================================================================
--- work.orig/drivers/media/dvb/dvb-usb/dvb-usb-remote.c
+++ work/drivers/media/dvb/dvb-usb/dvb-usb-remote.c
@@ -39,9 +39,9 @@ static void dvb_usb_read_remote_control(
 			d->last_event = event;
 		case REMOTE_KEY_REPEAT:
 			deb_rc("key repeated\n");
-			input_event(&d->rc_input_dev, EV_KEY, d->last_event, 1);
-			input_event(&d->rc_input_dev, EV_KEY, d->last_event, 0);
-			input_sync(&d->rc_input_dev);
+			input_event(d->rc_input_dev, EV_KEY, event, 1);
+			input_event(d->rc_input_dev, EV_KEY, d->last_event, 0);
+			input_sync(d->rc_input_dev);
 			break;
 		default:
 			break;
@@ -53,8 +53,8 @@ static void dvb_usb_read_remote_control(
 			deb_rc("NO KEY PRESSED\n");
 			if (d->last_state != REMOTE_NO_KEY_PRESSED) {
 				deb_rc("releasing event %d\n",d->last_event);
-				input_event(&d->rc_input_dev, EV_KEY, d->last_event, 0);
-				input_sync(&d->rc_input_dev);
+				input_event(d->rc_input_dev, EV_KEY, d->last_event, 0);
+				input_sync(d->rc_input_dev);
 			}
 			d->last_state = REMOTE_NO_KEY_PRESSED;
 			d->last_event = 0;
@@ -63,8 +63,8 @@ static void dvb_usb_read_remote_control(
 			deb_rc("KEY PRESSED\n");
 			deb_rc("pressing event %d\n",event);
 
-			input_event(&d->rc_input_dev, EV_KEY, event, 1);
-			input_sync(&d->rc_input_dev);
+			input_event(d->rc_input_dev, EV_KEY, event, 1);
+			input_sync(d->rc_input_dev);
 
 			d->last_event = event;
 			d->last_state = REMOTE_KEY_PRESSED;
@@ -73,8 +73,8 @@ static void dvb_usb_read_remote_control(
 			deb_rc("KEY_REPEAT\n");
 			if (d->last_state != REMOTE_NO_KEY_PRESSED) {
 				deb_rc("repeating event %d\n",d->last_event);
-				input_event(&d->rc_input_dev, EV_KEY, d->last_event, 2);
-				input_sync(&d->rc_input_dev);
+				input_event(d->rc_input_dev, EV_KEY, d->last_event, 2);
+				input_sync(d->rc_input_dev);
 				d->last_state = REMOTE_KEY_REPEAT;
 			}
 		default:
@@ -89,24 +89,30 @@ schedule:
 int dvb_usb_remote_init(struct dvb_usb_device *d)
 {
 	int i;
+
 	if (d->props.rc_key_map == NULL ||
 		d->props.rc_query == NULL ||
 		dvb_usb_disable_rc_polling)
 		return 0;
 
-	/* Initialise the remote-control structures.*/
-	init_input_dev(&d->rc_input_dev);
+	usb_make_path(d->udev, d->rc_phys, sizeof(d->rc_phys));
+	strlcpy(d->rc_phys, "/ir0", sizeof(d->rc_phys));
 
-	d->rc_input_dev.evbit[0] = BIT(EV_KEY);
-	d->rc_input_dev.keycodesize = sizeof(unsigned char);
-	d->rc_input_dev.keycodemax = KEY_MAX;
-	d->rc_input_dev.name = "IR-receiver inside an USB DVB receiver";
+	d->rc_input_dev = input_allocate_device();
+	if (!d->rc_input_dev)
+		return -ENOMEM;
+
+	d->rc_input_dev->evbit[0] = BIT(EV_KEY);
+	d->rc_input_dev->keycodesize = sizeof(unsigned char);
+	d->rc_input_dev->keycodemax = KEY_MAX;
+	d->rc_input_dev->name = "IR-receiver inside an USB DVB receiver";
+	d->rc_input_dev->phys = d->rc_phys;
 
 	/* set the bits for the keys */
-	deb_rc("key map size: %d\n",d->props.rc_key_map_size);
+	deb_rc("key map size: %d\n", d->props.rc_key_map_size);
 	for (i = 0; i < d->props.rc_key_map_size; i++) {
 		deb_rc("setting bit for event %d item %d\n",d->props.rc_key_map[i].event, i);
-		set_bit(d->props.rc_key_map[i].event, d->rc_input_dev.keybit);
+		set_bit(d->props.rc_key_map[i].event, d->rc_input_dev->keybit);
 	}
 
 	/* Start the remote-control polling. */
@@ -114,14 +120,14 @@ int dvb_usb_remote_init(struct dvb_usb_d
 		d->props.rc_interval = 100; /* default */
 
 	/* setting these two values to non-zero, we have to manage key repeats */
-	d->rc_input_dev.rep[REP_PERIOD] = d->props.rc_interval;
-	d->rc_input_dev.rep[REP_DELAY]  = d->props.rc_interval + 150;
+	d->rc_input_dev->rep[REP_PERIOD] = d->props.rc_interval;
+	d->rc_input_dev->rep[REP_DELAY]  = d->props.rc_interval + 150;
 
-	input_register_device(&d->rc_input_dev);
+	input_register_device(d->rc_input_dev);
 
 	INIT_WORK(&d->rc_query_work, dvb_usb_read_remote_control, d);
 
-	info("schedule remote query interval to %d msecs.",d->props.rc_interval);
+	info("schedule remote query interval to %d msecs.", d->props.rc_interval);
 	schedule_delayed_work(&d->rc_query_work,msecs_to_jiffies(d->props.rc_interval));
 
 	d->state |= DVB_USB_STATE_REMOTE;
@@ -134,7 +140,7 @@ int dvb_usb_remote_exit(struct dvb_usb_d
 	if (d->state & DVB_USB_STATE_REMOTE) {
 		cancel_delayed_work(&d->rc_query_work);
 		flush_scheduled_work();
-		input_unregister_device(&d->rc_input_dev);
+		input_unregister_device(d->rc_input_dev);
 	}
 	d->state &= ~DVB_USB_STATE_REMOTE;
 	return 0;
Index: work/drivers/media/dvb/dvb-usb/dvb-usb.h
===================================================================
--- work.orig/drivers/media/dvb/dvb-usb/dvb-usb.h
+++ work/drivers/media/dvb/dvb-usb/dvb-usb.h
@@ -300,7 +300,8 @@ struct dvb_usb_device {
 	int (*fe_init)  (struct dvb_frontend *);
 
 	/* remote control */
-	struct input_dev rc_input_dev;
+	struct input_dev *rc_input_dev;
+	char rc_phys[64];
 	struct work_struct rc_query_work;
 	u32 last_event;
 	int last_state;
Index: work/drivers/media/dvb/ttpci/av7110_ir.c
===================================================================
--- work.orig/drivers/media/dvb/ttpci/av7110_ir.c
+++ work/drivers/media/dvb/ttpci/av7110_ir.c
@@ -15,7 +15,7 @@
 
 static int av_cnt;
 static struct av7110 *av_list[4];
-static struct input_dev input_dev;
+static struct input_dev *input_dev;
 
 static u16 key_map [256] = {
 	KEY_0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7,
@@ -43,10 +43,10 @@ static u16 key_map [256] = {
 
 static void av7110_emit_keyup(unsigned long data)
 {
-	if (!data || !test_bit(data, input_dev.key))
+	if (!data || !test_bit(data, input_dev->key))
 		return;
 
-	input_event(&input_dev, EV_KEY, data, !!0);
+	input_event(input_dev, EV_KEY, data, !!0);
 }
 
 
@@ -112,13 +112,13 @@ static void av7110_emit_key(unsigned lon
 	if (timer_pending(&keyup_timer)) {
 		del_timer(&keyup_timer);
 		if (keyup_timer.data != keycode || new_toggle != old_toggle) {
-			input_event(&input_dev, EV_KEY, keyup_timer.data, !!0);
-			input_event(&input_dev, EV_KEY, keycode, !0);
+			input_event(input_dev, EV_KEY, keyup_timer.data, !!0);
+			input_event(input_dev, EV_KEY, keycode, !0);
 		} else
-			input_event(&input_dev, EV_KEY, keycode, 2);
+			input_event(input_dev, EV_KEY, keycode, 2);
 
 	} else
-		input_event(&input_dev, EV_KEY, keycode, !0);
+		input_event(input_dev, EV_KEY, keycode, !0);
 
 	keyup_timer.expires = jiffies + UP_TIMEOUT;
 	keyup_timer.data = keycode;
@@ -132,13 +132,13 @@ static void input_register_keys(void)
 {
 	int i;
 
-	memset(input_dev.keybit, 0, sizeof(input_dev.keybit));
+	memset(input_dev->keybit, 0, sizeof(input_dev->keybit));
 
-	for (i = 0; i < sizeof(key_map) / sizeof(key_map[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(key_map); i++) {
 		if (key_map[i] > KEY_MAX)
 			key_map[i] = 0;
 		else if (key_map[i] > KEY_RESERVED)
-			set_bit(key_map[i], input_dev.keybit);
+			set_bit(key_map[i], input_dev->keybit);
 	}
 }
 
@@ -216,12 +216,17 @@ int __init av7110_ir_init(struct av7110 
 		init_timer(&keyup_timer);
 		keyup_timer.data = 0;
 
-		input_dev.name = "DVB on-card IR receiver";
-		set_bit(EV_KEY, input_dev.evbit);
-		set_bit(EV_REP, input_dev.evbit);
+		input_dev = input_allocate_device();
+		if (!input_dev)
+			return -ENOMEM;
+
+		input_dev->name = "DVB on-card IR receiver";
+
+		set_bit(EV_KEY, input_dev->evbit);
+		set_bit(EV_REP, input_dev->evbit);
 		input_register_keys();
-		input_register_device(&input_dev);
-		input_dev.timer.function = input_repeat_key;
+		input_register_device(input_dev);
+		input_dev->timer.function = input_repeat_key;
 
 		e = create_proc_entry("av7110_ir", S_IFREG | S_IRUGO | S_IWUSR, NULL);
 		if (e) {
@@ -256,7 +261,7 @@ void __exit av7110_ir_exit(struct av7110
 	if (av_cnt == 1) {
 		del_timer_sync(&keyup_timer);
 		remove_proc_entry("av7110_ir", NULL);
-		input_unregister_device(&input_dev);
+		input_unregister_device(input_dev);
 	}
 
 	av_cnt--;
Index: work/drivers/media/dvb/ttusb-dec/ttusb_dec.c
===================================================================
--- work.orig/drivers/media/dvb/ttusb-dec/ttusb_dec.c
+++ work/drivers/media/dvb/ttusb-dec/ttusb_dec.c
@@ -152,7 +152,8 @@ struct ttusb_dec {
 	struct list_head	filter_info_list;
 	spinlock_t		filter_info_list_lock;
 
-	struct input_dev	rc_input_dev;
+	struct input_dev	*rc_input_dev;
+	char			rc_phys[64];
 
 	int			active; /* Loaded successfully */
 };
@@ -235,9 +236,9 @@ static void ttusb_dec_handle_irq( struct
 		 * this should/could be added later ...
 		 * for now lets report each signal as a key down and up*/
 		dprintk("%s:rc signal:%d\n", __FUNCTION__, buffer[4]);
-		input_report_key(&dec->rc_input_dev,rc_keys[buffer[4]-1],1);
-		input_report_key(&dec->rc_input_dev,rc_keys[buffer[4]-1],0);
-		input_sync(&dec->rc_input_dev);
+		input_report_key(dec->rc_input_dev, rc_keys[buffer[4] - 1], 1);
+		input_report_key(dec->rc_input_dev, rc_keys[buffer[4] - 1], 0);
+		input_sync(dec->rc_input_dev);
 	}
 
 exit:	retval = usb_submit_urb(urb, GFP_ATOMIC);
@@ -1181,29 +1182,38 @@ static void ttusb_dec_init_tasklet(struc
 		     (unsigned long)dec);
 }
 
-static void ttusb_init_rc( struct ttusb_dec *dec)
+static int ttusb_init_rc(struct ttusb_dec *dec)
 {
+	struct input_dev *input_dev;
 	u8 b[] = { 0x00, 0x01 };
 	int i;
 
-	init_input_dev(&dec->rc_input_dev);
+	usb_make_path(dec->udev, dec->rc_phys, sizeof(dec->rc_phys));
+	strlcpy(dec->rc_phys, "/input0", sizeof(dec->rc_phys));
 
-	dec->rc_input_dev.name = "ttusb_dec remote control";
-	dec->rc_input_dev.evbit[0] = BIT(EV_KEY);
-	dec->rc_input_dev.keycodesize = sizeof(u16);
-	dec->rc_input_dev.keycodemax = 0x1a;
-	dec->rc_input_dev.keycode = rc_keys;
+	dec->rc_input_dev = input_dev = input_allocate_device();
+	if (!input_dev)
+		return -ENOMEM;
+
+	input_dev->name = "ttusb_dec remote control";
+	input_dev->phys = dec->rc_phys;
+	input_dev->evbit[0] = BIT(EV_KEY);
+	input_dev->keycodesize = sizeof(u16);
+	input_dev->keycodemax = 0x1a;
+	input_dev->keycode = rc_keys;
 
-	 for (i = 0; i < sizeof(rc_keys)/sizeof(rc_keys[0]); i++)
-                set_bit(rc_keys[i], dec->rc_input_dev.keybit);
+	for (i = 0; i < ARRAY_SIZE(rc_keys); i++)
+                set_bit(rc_keys[i], input_dev->keybit);
 
-	input_register_device(&dec->rc_input_dev);
+	input_register_device(input_dev);
 
-	if(usb_submit_urb(dec->irq_urb,GFP_KERNEL)) {
+	if (usb_submit_urb(dec->irq_urb, GFP_KERNEL))
 		printk("%s: usb_submit_urb failed\n",__FUNCTION__);
-	}
+
 	/* enable irq pipe */
 	ttusb_dec_send_command(dec,0xb0,sizeof(b),b,NULL,NULL);
+
+	return 0;
 }
 
 static void ttusb_dec_init_v_pes(struct ttusb_dec *dec)
@@ -1513,7 +1523,7 @@ static void ttusb_dec_exit_rc(struct ttu
 	  * As the irq is submitted after the interface is changed,
 	  * this is the best method i figured out.
 	  * Any others?*/
-	if(dec->interface == TTUSB_DEC_INTERFACE_IN)
+	if (dec->interface == TTUSB_DEC_INTERFACE_IN)
 		usb_kill_urb(dec->irq_urb);
 
 	usb_free_urb(dec->irq_urb);
@@ -1521,7 +1531,10 @@ static void ttusb_dec_exit_rc(struct ttu
 	usb_buffer_free(dec->udev,IRQ_PACKET_SIZE,
 		           dec->irq_buffer, dec->irq_dma_handle);
 
-	input_unregister_device(&dec->rc_input_dev);
+	if (dec->rc_input_dev) {
+		input_unregister_device(dec->rc_input_dev);
+		dec->rc_input_dev = NULL;
+	}
 }
 
 
@@ -1659,7 +1672,7 @@ static int ttusb_dec_probe(struct usb_in
 
 	ttusb_dec_set_interface(dec, TTUSB_DEC_INTERFACE_IN);
 
-	if(enable_rc)
+	if (enable_rc)
 		ttusb_init_rc(dec);
 
 	return 0;
Index: work/drivers/media/video/cx88/cx88-input.c
===================================================================
--- work.orig/drivers/media/video/cx88/cx88-input.c
+++ work/drivers/media/video/cx88/cx88-input.c
@@ -260,7 +260,7 @@ static IR_KEYTAB_TYPE ir_codes_cinergy_1
 
 struct cx88_IR {
 	struct cx88_core *core;
-	struct input_dev input;
+	struct input_dev *input;
 	struct ir_input_state ir;
 	char name[32];
 	char phys[32];
@@ -315,23 +315,23 @@ static void cx88_ir_handle_key(struct cx
 	if (ir->mask_keydown) {
 		/* bit set on keydown */
 		if (gpio & ir->mask_keydown) {
-			ir_input_keydown(&ir->input, &ir->ir, data, data);
+			ir_input_keydown(ir->input, &ir->ir, data, data);
 		} else {
-			ir_input_nokey(&ir->input, &ir->ir);
+			ir_input_nokey(ir->input, &ir->ir);
 		}
 
 	} else if (ir->mask_keyup) {
 		/* bit cleared on keydown */
 		if (0 == (gpio & ir->mask_keyup)) {
-			ir_input_keydown(&ir->input, &ir->ir, data, data);
+			ir_input_keydown(ir->input, &ir->ir, data, data);
 		} else {
-			ir_input_nokey(&ir->input, &ir->ir);
+			ir_input_nokey(ir->input, &ir->ir);
 		}
 
 	} else {
 		/* can't distinguish keydown/up :-/ */
-		ir_input_keydown(&ir->input, &ir->ir, data, data);
-		ir_input_nokey(&ir->input, &ir->ir);
+		ir_input_keydown(ir->input, &ir->ir, data, data);
+		ir_input_nokey(ir->input, &ir->ir);
 	}
 }
 
@@ -357,13 +357,19 @@ static void cx88_ir_work(void *data)
 int cx88_ir_init(struct cx88_core *core, struct pci_dev *pci)
 {
 	struct cx88_IR *ir;
+	struct input_dev *input_dev;
 	IR_KEYTAB_TYPE *ir_codes = NULL;
 	int ir_type = IR_TYPE_OTHER;
 
-	ir = kmalloc(sizeof(*ir), GFP_KERNEL);
-	if (NULL == ir)
+	ir = kzalloc(sizeof(*ir), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ir || !input_dev) {
+		kfree(ir);
+		input_free_device(input_dev);
 		return -ENOMEM;
-	memset(ir, 0, sizeof(*ir));
+	}
+
+	ir->input = input_dev;
 
 	/* detect & configure */
 	switch (core->board) {
@@ -425,6 +431,7 @@ int cx88_ir_init(struct cx88_core *core,
 
 	if (NULL == ir_codes) {
 		kfree(ir);
+		input_free_device(input_dev);
 		return -ENODEV;
 	}
 
@@ -433,19 +440,19 @@ int cx88_ir_init(struct cx88_core *core,
 		 cx88_boards[core->board].name);
 	snprintf(ir->phys, sizeof(ir->phys), "pci-%s/ir0", pci_name(pci));
 
-	ir_input_init(&ir->input, &ir->ir, ir_type, ir_codes);
-	ir->input.name = ir->name;
-	ir->input.phys = ir->phys;
-	ir->input.id.bustype = BUS_PCI;
-	ir->input.id.version = 1;
+	ir_input_init(input_dev, &ir->ir, ir_type, ir_codes);
+	input_dev->name = ir->name;
+	input_dev->phys = ir->phys;
+	input_dev->id.bustype = BUS_PCI;
+	input_dev->id.version = 1;
 	if (pci->subsystem_vendor) {
-		ir->input.id.vendor = pci->subsystem_vendor;
-		ir->input.id.product = pci->subsystem_device;
+		input_dev->id.vendor = pci->subsystem_vendor;
+		input_dev->id.product = pci->subsystem_device;
 	} else {
-		ir->input.id.vendor = pci->vendor;
-		ir->input.id.product = pci->device;
+		input_dev->id.vendor = pci->vendor;
+		input_dev->id.product = pci->device;
 	}
-	ir->input.dev = &pci->dev;
+	input_dev->cdev.dev = &pci->dev;
 
 	/* record handles to ourself */
 	ir->core = core;
@@ -465,8 +472,7 @@ int cx88_ir_init(struct cx88_core *core,
 	}
 
 	/* all done */
-	input_register_device(&ir->input);
-	printk("%s: registered IR remote control\n", core->name);
+	input_register_device(ir->input);
 
 	return 0;
 }
@@ -484,7 +490,7 @@ int cx88_ir_fini(struct cx88_core *core)
 		flush_scheduled_work();
 	}
 
-	input_unregister_device(&ir->input);
+	input_unregister_device(ir->input);
 	kfree(ir);
 
 	/* done */
@@ -515,7 +521,7 @@ void cx88_ir_irq(struct cx88_core *core)
 	if (!ir->scount) {
 		/* nothing to sample */
 		if (ir->ir.keypressed && time_after(jiffies, ir->release))
-			ir_input_nokey(&ir->input, &ir->ir);
+			ir_input_nokey(ir->input, &ir->ir);
 		return;
 	}
 
@@ -557,7 +563,7 @@ void cx88_ir_irq(struct cx88_core *core)
 
 		ir_dprintk("Key Code: %x\n", (ircode >> 16) & 0x7f);
 
-		ir_input_keydown(&ir->input, &ir->ir, (ircode >> 16) & 0x7f, (ircode >> 16) & 0xff);
+		ir_input_keydown(ir->input, &ir->ir, (ircode >> 16) & 0x7f, (ircode >> 16) & 0xff);
 		ir->release = jiffies + msecs_to_jiffies(120);
 		break;
 	case CX88_BOARD_HAUPPAUGE:
@@ -566,7 +572,7 @@ void cx88_ir_irq(struct cx88_core *core)
 		ir_dprintk("biphase decoded: %x\n", ircode);
 		if ((ircode & 0xfffff000) != 0x3000)
 			break;
-		ir_input_keydown(&ir->input, &ir->ir, ircode & 0x3f, ircode);
+		ir_input_keydown(ir->input, &ir->ir, ircode & 0x3f, ircode);
 		ir->release = jiffies + msecs_to_jiffies(120);
 		break;
 	}

