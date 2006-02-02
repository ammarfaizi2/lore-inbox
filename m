Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWBBXCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWBBXCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWBBXCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:02:37 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:45221 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751114AbWBBXCg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:02:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=J0v+kMQpxYPTsk3Xmrg38b/Zhb85l45zAD4usBRghCoR03Fa0LMQmd/FzNr8jgoTVv/nxVF08xDQCQtRjGdHf/gTxffIyYfRarRZj4po/SReKCgPSr7V40/+RUNaaIRkcox+sQsSvqjFBBPtJC0NmFLD5mgeKCjQkHXRFPmrTpU=
Message-ID: <7f45d9390602021502q325752d7oe635569cde7ce2c7@mail.gmail.com>
Date: Thu, 2 Feb 2006 16:02:35 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] liyitec: Liyitec PS/2 touchscreen driver
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] liyitec: Liyitec PS/2 touchscreen driver

Add an input driver for the Liyitec PS/2 touchscreen.

Signed-off-by: Shaun Jackman <sjackman@gmail.com>

diff --git a/drivers/input/touchscreen/Kconfig
b/drivers/input/touchscreen/Kconfig
index b1b14f8..392cce2 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -73,6 +73,19 @@ config TOUCHSCREEN_ELO
 	  To compile this driver as a module, choose M here: the
 	  module will be called elo.

+config TOUCHSCREEN_LIYITEC
+	tristate "Lyitec PS/2 touchscreen"
+	select SERIO
+	select SERIO_I8042 if X86_PC
+	help
+	  Say Y here if you have a Liyitec PS/2 touchscreen connected to
+	  your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called liyitec.
+
 config TOUCHSCREEN_MTOUCH
 	tristate "MicroTouch serial touchscreens"
 	select SERIO
diff --git a/drivers/input/touchscreen/Makefile
b/drivers/input/touchscreen/Makefile
index 5e5557c..001c97c 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_TOUCHSCREEN_BITSY)	+= h3600
 obj-$(CONFIG_TOUCHSCREEN_CORGI)	+= corgi_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)	+= gunze.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)	+= elo.o
+obj-$(CONFIG_TOUCHSCREEN_LIYITEC) += liyitec.o
 obj-$(CONFIG_TOUCHSCREEN_MTOUCH) += mtouch.o
 obj-$(CONFIG_TOUCHSCREEN_MK712)	+= mk712.o
 obj-$(CONFIG_TOUCHSCREEN_HP600)	+= hp680_ts_input.o
diff --git a/drivers/input/touchscreen/liyitec.c
b/drivers/input/touchscreen/liyitec.c
new file mode 100644
index 0000000..d262d2d
--- /dev/null
+++ b/drivers/input/touchscreen/liyitec.c
@@ -0,0 +1,185 @@
+/* Liyitec PS/2 touchscreen driver
+ * Written by Shaun Jackman <sjackman@gmail.com>.
+ * Copyright 2006 Pathway Connectivity
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This driver was derived from mtouch.c.
+ */
+
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/serio.h>
+
+#define DRIVER_DESC "Liyitec PS/2 touchscreen driver"
+
+MODULE_AUTHOR("Shaun Jackman <sjackman@gmail.com>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+#define LIYITEC_MAX_X 0x3ff
+#define LIYITEC_MAX_Y 0x3ff
+
+#define LIYITEC_Y9    0x80
+#define LIYITEC_X9    0x40
+#define LIYITEC_Y8    0x20
+#define LIYITEC_X8    0x10
+#define LIYITEC_SYNC  0x08
+#define LIYITEC_ABS   0x04
+#define LIYITEC_RIGHT 0x02
+#define LIYITEC_TOUCH 0x01
+
+#define LIYITEC_PACKET_SIZE 3
+#define LIYITEC_CMD_SETSTREAM 0xea
+#define LIYITEC_CMD_ENABLE    0xf4
+#define LIYITEC_RET_ACK       0xfa
+
+struct liyitec {
+	struct input_dev *dev;
+	struct serio *serio;
+	char phys[32];
+	signed char count;
+	unsigned char data[LIYITEC_PACKET_SIZE];
+};
+
+static irqreturn_t liyitec_interrupt(struct serio *serio,
+		unsigned char data, unsigned int flags, struct pt_regs *regs)
+{
+	struct liyitec *liyitec = serio_get_drvdata(serio);
+
+	if (liyitec->count < 0) {
+		if (data != LIYITEC_RET_ACK)
+			dev_dbg(&serio->dev, "expected ACK: 0x%02x\n", data);
+	} else
+		liyitec->data[liyitec->count] = data;
+	liyitec->count++;
+
+	if (liyitec->count == 1 && !(data & LIYITEC_SYNC)) {
+		dev_dbg(&serio->dev, "unsynchronized data: 0x%02x\n", data);
+		liyitec->count = 0;
+	}
+	else if (liyitec->count == LIYITEC_PACKET_SIZE) {
+		struct input_dev *dev = liyitec->dev;
+		input_regs(dev, regs);
+		if (liyitec->data[0] & LIYITEC_ABS) {
+			unsigned x = liyitec->data[1] +
+				(liyitec->data[0] & LIYITEC_X8 ? 0x100 : 0) +
+				(liyitec->data[0] & LIYITEC_X9 ? 0x200 : 0);
+			unsigned y = liyitec->data[2] +
+				(liyitec->data[0] & LIYITEC_Y8 ? 0x100 : 0) +
+				(liyitec->data[0] & LIYITEC_Y9 ? 0x200 : 0);
+			input_report_abs(dev, ABS_X, x);
+			input_report_abs(dev, ABS_Y, y);
+		}
+		input_report_key(dev, BTN_TOUCH, liyitec->data[0] & LIYITEC_TOUCH);
+		input_report_key(dev, BTN_RIGHT, liyitec->data[0] & LIYITEC_RIGHT);
+		input_sync(dev);
+		liyitec->count = 0;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int liyitec_connect(struct serio *serio, struct serio_driver *drv)
+{
+	struct liyitec *liyitec;
+	struct input_dev *input_dev;
+	int retval;
+
+	liyitec = kzalloc(sizeof *liyitec, GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (liyitec == NULL || input_dev == NULL) {
+		retval = -ENOMEM;
+		goto out;
+	}
+
+	liyitec->serio = serio;
+	liyitec->dev = input_dev;
+	sprintf(liyitec->phys, "%s/input0", serio->phys);
+
+	input_dev->private = liyitec;
+	input_dev->name = "Liyitec PS/2 touchscreen";
+	input_dev->phys = liyitec->phys;
+	input_dev->id.bustype = BUS_I8042;
+	input_dev->id.vendor = SERIO_LIYITEC;
+	input_dev->id.product = 0;
+	input_dev->id.version = 0x0100;
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_dev->keybit[LONG(BTN_MOUSE)] = BIT(BTN_RIGHT);
+	input_set_abs_params(liyitec->dev, ABS_X, 0, LIYITEC_MAX_X, 0, 0);
+	input_set_abs_params(liyitec->dev, ABS_Y, 0, LIYITEC_MAX_Y, 0, 0);
+
+	serio_set_drvdata(serio, liyitec);
+	retval = serio_open(serio, drv);
+	if (retval)
+		goto out;
+	input_register_device(liyitec->dev);
+
+	liyitec->count = -2;
+	retval = serio_write(serio, LIYITEC_CMD_SETSTREAM);
+	if (retval)
+		goto out;
+	retval = serio_write(serio, LIYITEC_CMD_ENABLE);
+
+out:
+	if (retval) {
+		serio_set_drvdata(serio, NULL);
+		input_free_device(input_dev);
+		kfree(liyitec);
+	}
+	return retval;
+}
+
+static void liyitec_disconnect(struct serio *serio)
+{
+	struct liyitec *liyitec = serio_get_drvdata(serio);
+
+	input_get_device(liyitec->dev);
+	input_unregister_device(liyitec->dev);
+	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
+	input_put_device(liyitec->dev);
+	kfree(liyitec);
+}
+
+static struct serio_device_id liyitec_serio_ids[] = {
+	{
+		.type  = SERIO_8042,
+		.proto = SERIO_ANY,
+		.id    = SERIO_ANY,
+		.extra = SERIO_ANY,
+	},
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(serio, liyitec_serio_ids);
+
+static struct serio_driver liyitec_drv = {
+	.driver = {
+		.name = "liyitec",
+	},
+	.description = DRIVER_DESC,
+	.id_table    = liyitec_serio_ids,
+	.interrupt   = liyitec_interrupt,
+	.connect     = liyitec_connect,
+	.disconnect  = liyitec_disconnect,
+};
+
+static int __init liyitec_init(void)
+{
+	printk(KERN_INFO "liyitec: %s\n", DRIVER_DESC);
+	serio_register_driver(&liyitec_drv);
+	return 0;
+}
+
+static void __exit liyitec_exit(void)
+{
+	serio_unregister_driver(&liyitec_drv);
+}
+
+module_init(liyitec_init);
+module_exit(liyitec_exit);
diff --git a/include/linux/serio.h b/include/linux/serio.h
index aa4d649..199bd34 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -216,5 +216,6 @@ static inline void serio_unpin_driver(st
 #define SERIO_LKKBD	0x28
 #define SERIO_ELO	0x29
 #define SERIO_MICROTOUCH	0x30
+#define SERIO_LIYITEC	0x31

 #endif
