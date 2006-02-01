Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWBAFJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWBAFJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWBAFJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:17 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:27005 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030309AbWBAFJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:02 -0500
Message-Id: <20060201050733.395925000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:15 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 01/18] NSLU2 beeper driver
Content-Disposition: inline; filename=nslu2-beeper.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alessandro Zummo <alessandro.zummo@towertech.it>

Input: add ixp4xx beeper driver

This is a driver for beeper found in LinkSys NSLU2 boxes. It should work
on any ixp4xx based platform.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/Kconfig         |   12 ++
 drivers/input/misc/Makefile        |    1 
 drivers/input/misc/ixp4xx-beeper.c |  183 +++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)

Index: work/drivers/input/misc/Kconfig
===================================================================
--- work.orig/drivers/input/misc/Kconfig
+++ work/drivers/input/misc/Kconfig
@@ -50,6 +50,18 @@ config INPUT_WISTRON_BTNS
 	  To compile this driver as a module, choose M here: the module will
 	  be called wistron_btns.
 
+config INPUT_IXP4XX_BEEPER
+	tristate "IXP4XX Beeper support"
+	depends on ARCH_IXP4XX
+	help
+	  If you say yes here, you can connect a beeper to the
+	  ixp4xx gpio pins. This is used by the LinkSys NSLU2.
+
+	  If unsure, say Y.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ixp4xx-beeper.
+
 config INPUT_UINPUT
 	tristate "User level driver support"
 	help
Index: work/drivers/input/misc/Makefile
===================================================================
--- work.orig/drivers/input/misc/Makefile
+++ work/drivers/input/misc/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_INPUT_98SPKR)		+= 98spkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
+obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
Index: work/drivers/input/misc/ixp4xx-beeper.c
===================================================================
--- /dev/null
+++ work/drivers/input/misc/ixp4xx-beeper.c
@@ -0,0 +1,183 @@
+/*
+ * Generic IXP4xx beeper driver
+ *
+ * Copyright (C) 2005 Tower Technologies
+ *
+ * based on nslu2-io.c
+ *  Copyright (C) 2004 Karen Spearel
+ *
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ * Maintainers: http://www.nslu2-linux.org/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <asm/hardware.h>
+
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
+MODULE_DESCRIPTION("ixp4xx beeper driver");
+MODULE_LICENSE("GPL");
+
+static DEFINE_SPINLOCK(beep_lock);
+
+static void ixp4xx_spkr_control(unsigned int pin, unsigned int count)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&beep_lock, flags);
+
+	 if (count) {
+		gpio_line_config(pin, IXP4XX_GPIO_OUT);
+		gpio_line_set(pin, IXP4XX_GPIO_LOW);
+
+		*IXP4XX_OSRT2 = (count & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE;
+	} else {
+		gpio_line_config(pin, IXP4XX_GPIO_IN);
+		gpio_line_set(pin, IXP4XX_GPIO_HIGH);
+
+		*IXP4XX_OSRT2 = 0;
+	}
+
+	spin_unlock_irqrestore(&beep_lock, flags);
+}
+
+static int ixp4xx_spkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	unsigned int pin = (unsigned int) dev->private;
+	unsigned int count = 0;
+
+	if (type != EV_SND)
+		return -1;
+
+	switch (code) {
+		case SND_BELL:
+			if (value)
+				value = 1000;
+		case SND_TONE:
+			break;
+		default:
+			return -1;
+	}
+
+	if (value > 20 && value < 32767)
+#ifndef FREQ
+		count = (ixp4xx_get_board_tick_rate() / (value * 4)) - 1;
+#else
+		count = (FREQ / (value * 4)) - 1;
+#endif
+
+	ixp4xx_spkr_control(pin, count);
+
+	return 0;
+}
+
+static irqreturn_t ixp4xx_spkr_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	/* clear interrupt */
+	*IXP4XX_OSST = IXP4XX_OSST_TIMER_2_PEND;
+
+	/* flip the beeper output */
+	*IXP4XX_GPIO_GPOUTR ^= (1 << (unsigned int) dev_id);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit ixp4xx_spkr_probe(struct platform_device *dev)
+{
+	struct input_dev *input_dev;
+	int err;
+
+	input_dev = input_allocate_device();
+	if (!input_dev)
+		return -ENOMEM;
+
+	input_dev->private = (void *) dev->id;
+	input_dev->name = "ixp4xx beeper",
+	input_dev->phys = "ixp4xx/gpio";
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->id.vendor  = 0x001f;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
+	input_dev->cdev.dev = &dev->dev;
+
+	input_dev->evbit[0] = BIT(EV_SND);
+	input_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	input_dev->event = ixp4xx_spkr_event;
+
+	err = request_irq(IRQ_IXP4XX_TIMER2, &ixp4xx_spkr_interrupt,
+			  SA_INTERRUPT | SA_TIMER, "ixp4xx-beeper", (void *) dev->id);
+	if (err)
+		goto err_free_device;
+
+	err = input_register_device(input_dev);
+	if (err)
+		goto err_free_irq;
+
+	platform_set_drvdata(dev, input_dev);
+
+	return 0;
+
+ err_free_irq:
+	free_irq(IRQ_IXP4XX_TIMER2, dev);
+ err_free_device:
+	input_free_device(input_dev);
+
+	return err;
+}
+
+static int __devexit ixp4xx_spkr_remove(struct platform_device *dev)
+{
+	struct input_dev *input_dev = platform_get_drvdata(dev);
+	unsigned int pin = (unsigned int) input_dev->private;
+
+	input_unregister_device(input_dev);
+	platform_set_drvdata(dev, NULL);
+
+	/* turn the speaker off */
+	disable_irq(IRQ_IXP4XX_TIMER2);
+	ixp4xx_spkr_control(pin, 0);
+
+	free_irq(IRQ_IXP4XX_TIMER2, dev);
+
+	return 0;
+}
+
+static void ixp4xx_spkr_shutdown(struct platform_device *dev)
+{
+	struct input_dev *input_dev = platform_get_drvdata(dev);
+	unsigned int pin = (unsigned int) input_dev->private;
+
+	/* turn off the speaker */
+	disable_irq(IRQ_IXP4XX_TIMER2);
+	ixp4xx_spkr_control(pin, 0);
+}
+
+static struct platform_driver ixp4xx_spkr_platform_driver = {
+	.driver		= {
+		.name	= "ixp4xx-beeper",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ixp4xx_spkr_probe,
+	.remove		= __devexit_p(ixp4xx_spkr_remove),
+	.shutdown	= ixp4xx_spkr_shutdown,
+};
+
+static int __init ixp4xx_spkr_init(void)
+{
+	return platform_driver_register(&ixp4xx_spkr_platform_driver);
+}
+
+static void __exit ixp4xx_spkr_exit(void)
+{
+	platform_driver_unregister(&ixp4xx_spkr_platform_driver);
+}
+
+module_init(ixp4xx_spkr_init);
+module_exit(ixp4xx_spkr_exit);

