Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263938AbTCVWrE>; Sat, 22 Mar 2003 17:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263967AbTCVWpd>; Sat, 22 Mar 2003 17:45:33 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14725
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263925AbTCVWl6>; Sat, 22 Mar 2003 17:41:58 -0500
Date: Sat, 22 Mar 2003 23:57:40 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303222357.h2MNveER020727@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: merge PC9800 mouse driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/input/mouse/98busmouse.c linux-2.5.65-ac3/drivers/input/mouse/98busmouse.c
--- linux-2.5.65-bk3/drivers/input/mouse/98busmouse.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac3/drivers/input/mouse/98busmouse.c	2003-02-20 16:30:36.000000000 +0000
@@ -0,0 +1,202 @@
+/*
+ *
+ *  Copyright (c) 2002 Osamu Tomita
+ *
+ *  Based on the work of:
+ *	James Banks		Matthew Dillon
+ *	David Giller		Nathan Laredo
+ *	Linus Torvalds		Johan Myreen
+ *	Cliff Matthews		Philip Blundell
+ *	Russell King		Vojtech Pavlik
+ */
+
+/*
+ * NEC PC-9801 Bus Mouse Driver for Linux
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or 
+ * (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ * 
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+
+MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
+MODULE_DESCRIPTION("PC-9801 busmouse driver");
+MODULE_LICENSE("GPL");
+
+#define	PC98BM_BASE		0x7fd9
+#define	PC98BM_DATA_PORT	PC98BM_BASE + 0
+/*	PC98BM_SIGNATURE_PORT	does not exist */
+#define	PC98BM_CONTROL_PORT	PC98BM_BASE + 4
+/*	PC98BM_INTERRUPT_PORT	does not exist */
+#define	PC98BM_CONFIG_PORT	PC98BM_BASE + 6
+
+#define	PC98BM_ENABLE_IRQ	0x00
+#define	PC98BM_DISABLE_IRQ	0x10
+#define	PC98BM_READ_X_LOW	0x80
+#define	PC98BM_READ_X_HIGH	0xa0
+#define	PC98BM_READ_Y_LOW	0xc0
+#define	PC98BM_READ_Y_HIGH	0xe0
+
+#define PC98BM_DEFAULT_MODE	0x93
+/*	PC98BM_CONFIG_BYTE	is not used */
+/*	PC98BM_SIGNATURE_BYTE	is not used */
+
+#define PC98BM_TIMER_PORT	0xbfdb
+#define PC98BM_DEFAULT_TIMER_VAL	0x00
+
+#define PC98BM_IRQ		13
+
+MODULE_PARM(pc98bm_irq, "i");
+
+static int pc98bm_irq = PC98BM_IRQ;
+static int pc98bm_used = 0;
+
+static void pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+
+static int pc98bm_open(struct input_dev *dev)
+{
+	if (pc98bm_used++)
+		return 0;
+	if (request_irq(pc98bm_irq, pc98bm_interrupt, 0, "98busmouse", NULL)) {
+		pc98bm_used--;
+		printk(KERN_ERR "98busmouse.c: Can't allocate irq %d\n", pc98bm_irq);
+		return -EBUSY;
+	}
+	outb(PC98BM_ENABLE_IRQ, PC98BM_CONTROL_PORT);
+	return 0;
+}
+
+static void pc98bm_close(struct input_dev *dev)
+{
+	if (--pc98bm_used)
+		return;
+	outb(PC98BM_DISABLE_IRQ, PC98BM_CONTROL_PORT);
+	free_irq(pc98bm_irq, NULL);
+}
+
+static struct input_dev pc98bm_dev = {
+	.evbit	= { BIT(EV_KEY) | BIT(EV_REL) },
+	.keybit = { [LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT) },
+	.relbit	= { BIT(REL_X) | BIT(REL_Y) },
+	.open	= pc98bm_open,
+	.close	= pc98bm_close,
+	.name	= "PC-9801 bus mouse",
+	.phys	= "isa7fd9/input0",
+	.id	= {
+		.bustype = BUS_ISA,
+		.vendor  = 0x0004,
+		.product = 0x0001,
+		.version = 0x0100,
+	},
+};
+
+static void pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	char dx, dy;
+	unsigned char buttons;
+
+	outb(PC98BM_READ_X_LOW, PC98BM_CONTROL_PORT);
+	dx = (inb(PC98BM_DATA_PORT) & 0xf);
+	outb(PC98BM_READ_X_HIGH, PC98BM_CONTROL_PORT);
+	dx |= (inb(PC98BM_DATA_PORT) & 0xf) << 4;
+	outb(PC98BM_READ_Y_LOW, PC98BM_CONTROL_PORT);
+	dy = (inb(PC98BM_DATA_PORT) & 0xf);
+	outb(PC98BM_READ_Y_HIGH, PC98BM_CONTROL_PORT);
+	buttons = inb(PC98BM_DATA_PORT);
+	dy |= (buttons & 0xf) << 4;
+	buttons = ~buttons >> 5;
+
+	input_report_rel(&pc98bm_dev, REL_X, dx);
+	input_report_rel(&pc98bm_dev, REL_Y, dy);
+	input_report_key(&pc98bm_dev, BTN_RIGHT,  buttons & 1);
+	input_report_key(&pc98bm_dev, BTN_MIDDLE, buttons & 2);
+	input_report_key(&pc98bm_dev, BTN_LEFT,   buttons & 4);
+	input_sync(&pc98bm_dev);
+
+	outb(PC98BM_ENABLE_IRQ, PC98BM_CONTROL_PORT);
+}
+
+#ifndef MODULE
+static int __init pc98bm_setup(char *str)
+{
+        int ints[4];
+        str = get_options(str, ARRAY_SIZE(ints), ints);
+        if (ints[0] > 0) pc98bm_irq = ints[1];
+        return 1;
+}
+__setup("pc98bm_irq=", pc98bm_setup);
+#endif
+
+static int __init pc98bm_init(void)
+{
+	int i;
+
+	for (i = 0; i <= 6; i += 2) {
+		if (!request_region(PC98BM_BASE + i, 1, "98busmouse")) {
+			printk(KERN_ERR "98busmouse.c: Can't allocate ports at %#x\n", PC98BM_BASE + i);
+			while (i > 0) {
+				i -= 2;
+				release_region(PC98BM_BASE + i, 1);
+			}
+
+			return -EBUSY;
+		}
+
+	}
+
+	if (!request_region(PC98BM_TIMER_PORT, 1, "98busmouse")) {
+		printk(KERN_ERR "98busmouse.c: Can't allocate ports at %#x\n", PC98BM_TIMER_PORT);
+		for (i = 0; i <= 6; i += 2)
+			release_region(PC98BM_BASE + i, 1);
+
+		return -EBUSY;
+	}
+
+	outb(PC98BM_DEFAULT_MODE, PC98BM_CONFIG_PORT);
+	outb(PC98BM_DISABLE_IRQ, PC98BM_CONTROL_PORT);
+
+	outb(PC98BM_DEFAULT_TIMER_VAL, PC98BM_TIMER_PORT);
+
+	input_register_device(&pc98bm_dev);
+	
+	printk(KERN_INFO "input: PC-9801 bus mouse at %#x irq %d\n", PC98BM_BASE, pc98bm_irq);
+
+	return 0;
+}
+
+static void __exit pc98bm_exit(void)
+{
+	int i;
+
+	input_unregister_device(&pc98bm_dev);
+	for (i = 0; i <= 6; i += 2)
+		release_region(PC98BM_BASE + i, 1);
+
+	release_region(PC98BM_TIMER_PORT, 1);
+}
+
+module_init(pc98bm_init);
+module_exit(pc98bm_exit);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/input/mouse/Kconfig linux-2.5.65-ac3/drivers/input/mouse/Kconfig
--- linux-2.5.65-bk3/drivers/input/mouse/Kconfig	2003-03-22 19:33:54.000000000 +0000
+++ linux-2.5.65-ac3/drivers/input/mouse/Kconfig	2003-02-20 16:30:36.000000000 +0000
@@ -121,3 +121,15 @@
 	  The module will be called rpcmouse. If you want to compile it as a
 	  module, say M here and read <file.:Documentation/modules.txt>.
 
+config MOUSE_PC9800
+	tristate "NEC PC-9800 busmouse"
+	depends on X86_PC9800 && INPUT && INPUT_MOUSE && ISA
+	help
+	  Say Y here if you have NEC PC-9801/PC-9821 computer and want its
+	  native mouse supported.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called logibm.o. If you want to compile it as a
+	  module, say M here and read <file.:Documentation/modules.txt>.
+
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/input/mouse/Makefile linux-2.5.65-ac3/drivers/input/mouse/Makefile
--- linux-2.5.65-bk3/drivers/input/mouse/Makefile	2003-03-22 19:33:54.000000000 +0000
+++ linux-2.5.65-ac3/drivers/input/mouse/Makefile	2003-02-14 23:19:40.000000000 +0000
@@ -10,5 +10,6 @@
 obj-$(CONFIG_MOUSE_LOGIBM)	+= logibm.o
 obj-$(CONFIG_MOUSE_MAPLE)	+= maplemouse.o
 obj-$(CONFIG_MOUSE_PC110PAD)	+= pc110pad.o
+obj-$(CONFIG_MOUSE_PC9800)	+= 98busmouse.o
 obj-$(CONFIG_MOUSE_PS2)		+= psmouse.o
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
