Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268534AbVBEVCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268534AbVBEVCr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 16:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272482AbVBEVCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 16:02:47 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:54713 "EHLO suse.de")
	by vger.kernel.org with ESMTP id S269165AbVBEVBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 16:01:45 -0500
Date: Sat, 5 Feb 2005 22:02:03 +0100
From: Vojtech Pavlik <vojtech@suse.de>
To: Richard Koch <n1gp@hotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] adding the ICS MK712 touchscreen driver to 2.6
Message-ID: <20050205210203.GX2711@ucw.cz>
References: <BAY16-F34ACC3DA65154E040BEC5987800@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY16-F34ACC3DA65154E040BEC5987800@phx.gbl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 04:18:49PM -0500, Richard Koch wrote:
> Please include the patch below to bring the ICS MK712 touchscreen controller
> support, which is in kernel 2.4, in to kernel 2.6.
> 
> This patch was constructed and applied to kernel version 2.6.10 and tested
> successfully on several Gateway AOL Connected Touchpad computers.
> 
> This was based on the mk712.c 2.4.28 version. No functional changes applied 
> only minor
> changes to conform to the 2.6 build structure. I choose to place the driver 
> under
> input/touchscreen as this seemed most appropriate.
> 
> By making a contribution to this project, I certify that:
> 
> The contribution is based upon previous work that, to the best
> of my knowledge, is covered under an appropriate open source
> license and I have the right under that license to submit that
> work with modifications, whether created in whole or in part
> by me, under the same open source license (unless I am
> permitted to submit under a different license), as indicated
> in the file.
> 
> Signed-off-by: Rick Koch <n1gp@hotmail.com>
> 
> patch also available at: http://home.comcast.net/~n1gp/mk712_2.6_patch

I converted it to a proper input driver for you. ;) Can you check it if
it still works?


ChangeSet@1.2112, 2005-02-05 22:00:45+01:00, vojtech@silver.ucw.cz
  input: New driver for ICS MicroClock MK712 TouchScreens.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 Kconfig  |   11 +++
 Makefile |    3 
 mk712.c  |  201 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+), 1 deletion(-)


diff -Nru a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
--- a/drivers/input/touchscreen/Kconfig	2005-02-05 22:01:13 +01:00
+++ b/drivers/input/touchscreen/Kconfig	2005-02-05 22:01:13 +01:00
@@ -48,4 +48,15 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called gunze.
 
+config TOUCHSCREEN_MK712
+	tristate "ICS MicroClock MK712 touchscreen"
+	help
+	  Say Y here if you have the ICS MicroClock MK712 touchscreen
+	  controller chip in your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mk712.
+
 endif
diff -Nru a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
--- a/drivers/input/touchscreen/Makefile	2005-02-05 22:01:13 +01:00
+++ b/drivers/input/touchscreen/Makefile	2005-02-05 22:01:13 +01:00
@@ -5,5 +5,6 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_TOUCHSCREEN_BITSY)	+= h3600_ts_input.o
-obj-$(CONFIG_TOUCHSCREEN_GUNZE)	+= gunze.o
 obj-$(CONFIG_TOUCHSCREEN_CORGI)	+= corgi_ts.o
+obj-$(CONFIG_TOUCHSCREEN_GUNZE)	+= gunze.o
+obj-$(CONFIG_TOUCHSCREEN_MK712)	+= mk712.o
diff -Nru a/drivers/input/touchscreen/mk712.c b/drivers/input/touchscreen/mk712.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/input/touchscreen/mk712.c	2005-02-05 22:01:13 +01:00
@@ -0,0 +1,201 @@
+/*
+ * ICS MK712 touchscreen controller driver
+ *
+ * Copyright (c) 1999-2002 Transmeta Corporation
+ * Copyright (c) 2005 Rick Koch <n1gp@hotmail.com>
+ * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+/*
+ * This driver supports the ICS MicroClock MK712 TouchScreen controller,
+ * found in Gateway AOL Connected Touchpad computers. 
+ *
+ * Documentation for ICS MK712 can be found at:
+ * 	http://www.icst.com/pdf/mk712.pdf
+ */
+
+/*
+ * 1999-12-18: original version, Daniel Quinlan
+ * 1999-12-19: added anti-jitter code, report pen-up events, fixed mk712_poll
+ *             to use queue_empty, Nathan Laredo
+ * 1999-12-20: improved random point rejection, Nathan Laredo
+ * 2000-01-05: checked in new anti-jitter code, changed mouse protocol, fixed
+ *             queue code, added module options, other fixes, Daniel Quinlan
+ * 2002-03-15: Clean up for kernel merge <alan@redhat.com>
+ *	       Fixed multi open race, fixed memory checks, fixed resource
+ *	       allocation, fixed close/powerdown bug, switched to new init
+ * 2005-01-18: Ported to 2.6 from 2.4.28, Rick Koch
+ * 2005-02-05: Rewritten for the input layer, Vojtech Pavlik
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <asm/io.h>
+
+MODULE_AUTHOR("Daniel Quinlan <quinlan@pathname.com>, Vojtech Pavlik <vojtech@suse.cz>");
+MODULE_DESCRIPTION("ICS MicroClock MK712 TouchScreen driver");
+MODULE_LICENSE("GPL");
+
+static unsigned int mk712_io = 0x260;	/* Also 0x200, 0x208, 0x300 */
+module_param_named(io, mk712_io, uint, 0);
+MODULE_PARM_DESC(io, "I/O base address of MK712 touchscreen controller");
+
+static unsigned int mk712_irq = 10;	/* Also 12, 14, 15 */
+module_param_named(irq, mk712_irq, uint, 0);
+MODULE_PARM_DESC(irq, "IRQ of MK712 touchscreen controller");
+
+/* eight 8-bit registers */
+#define MK712_STATUS		0
+#define MK712_X			2
+#define MK712_Y			4
+#define MK712_CONTROL		6
+#define MK712_RATE		7
+
+/* status */
+#define	MK712_STATUS_TOUCH			0x10
+#define	MK712_CONVERSION_COMPLETE		0x80
+
+/* control */
+#define MK712_ENABLE_INT			0x01
+#define MK712_INT_ON_CONVERSION_COMPLETE	0x02
+#define MK712_INT_ON_CHANGE_IN_TOUCH_STATUS	0x04
+#define MK712_ENABLE_PERIODIC_CONVERSIONS	0x10
+#define MK712_READ_ONE_POINT			0x20
+#define MK712_POWERDOWN				0x40
+
+static int mk712_used = 0;
+static struct input_dev mk712_dev;
+
+static irqreturn_t mk712_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+        unsigned char status;
+        static int debounce = 1;
+	static unsigned short last_x;
+	static unsigned short last_y;
+
+	input_regs(&mk712_dev, regs);
+
+        status = inb(mk712_io + MK712_STATUS);
+
+	if (~status & MK712_CONVERSION_COMPLETE) {
+                debounce = 1;
+		goto end;
+	}
+
+	if (~status & MK712_STATUS_TOUCH)
+	{
+                debounce = 1;
+		input_report_key(&mk712_dev, BTN_TOUCH, 0);
+		goto end;
+	}
+
+        if (debounce)
+        {
+		debounce = 0;
+		goto end;
+        }
+
+	input_report_key(&mk712_dev, BTN_TOUCH, 1);
+	input_report_abs(&mk712_dev, ABS_X, last_x);
+	input_report_abs(&mk712_dev, ABS_Y, last_y);
+
+end:
+
+	last_x =  inw(mk712_io + MK712_X) & 0x0fff;
+	last_y = (inw(mk712_io + MK712_Y) & 0x0fff) * 3 / 4;
+	input_sync(&mk712_dev);
+        return IRQ_HANDLED;
+}
+
+static int mk712_open(struct input_dev *dev)
+{
+	
+	if (mk712_used++)
+		return 0;
+
+	outb(0, mk712_io + MK712_CONTROL); /* Reset */
+
+	outb(MK712_ENABLE_INT | MK712_INT_ON_CONVERSION_COMPLETE |
+                    MK712_INT_ON_CHANGE_IN_TOUCH_STATUS |
+                    MK712_ENABLE_PERIODIC_CONVERSIONS |
+                    MK712_POWERDOWN, mk712_io + MK712_CONTROL);
+
+	outb(10, mk712_io + MK712_RATE); /* 187 points per second */
+
+	return 0;
+}
+
+static void mk712_close(struct input_dev *dev)
+{
+	if (--mk712_used)
+		return;
+
+	outb(0, mk712_io + MK712_CONTROL);
+}
+
+static struct input_dev mk712_dev = {
+        .evbit  = { BIT(EV_KEY) | BIT(EV_ABS) },
+        .keybit = { [LONG(BTN_LEFT)] = BIT(BTN_TOUCH) },
+        .absbit = { BIT(ABS_X) | BIT(ABS_Y) },
+        .open   = mk712_open,
+        .close  = mk712_close,
+        .name   = "ICS MicroClock MK712 TouchScreen",
+        .phys   = "isa0260/input0",
+	.absmin = { [ABS_X] = 0, [ABS_Y] = 0 },
+	.absmax = { [ABS_X] = 0xfff, [ABS_Y] = 0xbff },
+	.absfuzz = { [ABS_X] = 88, [ABS_Y] = 88 },
+        .id     = {
+                .bustype = BUS_ISA,
+                .vendor  = 0x0005,
+                .product = 0x0001,
+                .version = 0x0100,
+        },
+};
+
+int __init mk712_init(void)
+{
+
+	if(!request_region(mk712_io, 8, "mk712"))
+	{
+		printk(KERN_WARNING "mk712: unable to get IO region\n");
+		return -ENODEV;
+	}
+
+	if(request_irq(mk712_irq, mk712_interrupt, 0, "mk712", &mk712_dev))
+	{
+		printk(KERN_WARNING "mk712: unable to get IRQ\n");
+		release_region(mk712_io, 8);
+		return -EBUSY;
+	}
+
+	input_register_device(&mk712_dev);
+
+	printk(KERN_INFO "input: ICS MicroClock MK712 TouchScreen at %#x irq %d\n", mk712_io, mk712_irq);
+
+ 	return 0;
+}
+
+static void __exit mk712_exit(void)
+{
+	input_unregister_device(&mk712_dev);
+	free_irq(mk712_irq, &mk712_dev);
+	release_region(mk712_io, 8);
+}
+
+
+module_init(mk712_init);
+module_exit(mk712_exit);
 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
