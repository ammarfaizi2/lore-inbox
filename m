Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265734AbTFNU1X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265735AbTFNU1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:27:23 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:6634 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265734AbTFNU0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:26:38 -0400
Date: Sat, 14 Jun 2003 22:40:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Add PCI PS/2 controller support [5/13]
Message-ID: <20030614224022.D25997@ucw.cz>
References: <20030614223513.A25948@ucw.cz> <20030614223629.A25997@ucw.cz> <20030614223708.B25997@ucw.cz> <20030614223934.C25997@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030614223934.C25997@ucw.cz>; from vojtech@suse.cz on Sat, Jun 14, 2003 at 10:39:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1215.104.22, 2003-06-09 14:02:05+02:00, rmk@arm.linux.org.uk
  input: PCI PS/2 keyboard and mouse controller (Mobility Docking station)


 Kconfig  |   11 +++
 Makefile |    1 
 pcips2.c |  230 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)

===================================================================

diff -Nru a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
--- a/drivers/input/serio/Kconfig	Sat Jun 14 22:22:39 2003
+++ b/drivers/input/serio/Kconfig	Sat Jun 14 22:22:39 2003
@@ -119,3 +119,14 @@
 	  The module will be called rpckbd.o. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+config SERIO_PCIPS2
+	tristate "PCI PS/2 keyboard and PS/2 mouse controller"
+	depends on PCI && SERIO
+	help
+	  Say Y here if you have a Mobility Docking station with PS/2
+	  keyboard and mice ports.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called rpckbd. If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.
diff -Nru a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
--- a/drivers/input/serio/Makefile	Sat Jun 14 22:22:39 2003
+++ b/drivers/input/serio/Makefile	Sat Jun 14 22:22:39 2003
@@ -14,3 +14,4 @@
 obj-$(CONFIG_SERIO_AMBAKMI)	+= ambakmi.o
 obj-$(CONFIG_SERIO_Q40KBD)	+= q40kbd.o
 obj-$(CONFIG_SERIO_98KBD)	+= 98kbd-io.o
+obj-$(CONFIG_SERIO_PCIPS2)	+= pcips2.o
diff -Nru a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/input/serio/pcips2.c	Sat Jun 14 22:22:39 2003
@@ -0,0 +1,230 @@
+/*
+ * linux/drivers/input/serio/pcips2.c
+ *
+ *  Copyright (C) 2003 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ *  I'm not sure if this is a generic PS/2 PCI interface or specific to
+ *  the Mobility Electronics docking station.
+ */
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/input.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/serio.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+
+#define PS2_CTRL		(0)
+#define PS2_STATUS		(1)
+#define PS2_DATA		(2)
+
+#define PS2_CTRL_CLK		(1<<0)
+#define PS2_CTRL_DAT		(1<<1)
+#define PS2_CTRL_TXIRQ		(1<<2)
+#define PS2_CTRL_ENABLE		(1<<3)
+#define PS2_CTRL_RXIRQ		(1<<4)
+
+#define PS2_STAT_CLK		(1<<0)
+#define PS2_STAT_DAT		(1<<1)
+#define PS2_STAT_PARITY		(1<<2)
+#define PS2_STAT_RXFULL		(1<<5)
+#define PS2_STAT_TXBUSY		(1<<6)
+#define PS2_STAT_TXEMPTY	(1<<7)
+
+struct pcips2_data {
+	struct serio	io;
+	unsigned int	base;
+	struct pci_dev	*dev;
+};
+
+static int pcips2_write(struct serio *io, unsigned char val)
+{
+	struct pcips2_data *ps2if = io->driver;
+	unsigned int stat;
+
+	do {
+		stat = inb(ps2if->base + PS2_STATUS);
+		cpu_relax();
+	} while (!(stat & PS2_STAT_TXEMPTY));
+
+	outb(val, ps2if->base + PS2_DATA);
+
+	return 0;
+}
+
+static void pcips2_interrupt(int irq, void *devid, struct pt_regs *regs)
+{
+	struct pcips2_data *ps2if = devid;
+	unsigned char status, scancode;
+
+	do {
+		unsigned int flag;
+
+		status = inb(ps2if->base + PS2_STATUS);
+		if (!(status & PS2_STAT_RXFULL))
+			break;
+		scancode = inb(ps2if->base + PS2_DATA);
+		if (status == 0xff && scancode == 0xff)
+			break;
+
+		flag = (status & PS2_STAT_PARITY) ? 0 : SERIO_PARITY;
+
+		if (hweight8(scancode) & 1)
+			flag ^= SERIO_PARITY;
+
+		serio_interrupt(&ps2if->io, scancode, flag, regs);
+	} while (1);
+}
+
+static void pcips2_flush_input(struct pcips2_data *ps2if)
+{
+	unsigned char status, scancode;
+
+	do {
+		status = inb(ps2if->base + PS2_STATUS);
+		if (!(status & PS2_STAT_RXFULL))
+			break;
+		scancode = inb(ps2if->base + PS2_DATA);
+		if (status == 0xff && scancode == 0xff)
+			break;
+	} while (1);
+}
+
+static int pcips2_open(struct serio *io)
+{
+	struct pcips2_data *ps2if = io->driver;
+	int ret, val = 0;
+
+	outb(PS2_CTRL_ENABLE, ps2if->base);
+	pcips2_flush_input(ps2if);
+
+	ret = request_irq(ps2if->dev->irq, pcips2_interrupt, SA_SHIRQ,
+			  "pcips2", ps2if);
+	if (ret == 0)
+		val = PS2_CTRL_ENABLE | PS2_CTRL_RXIRQ;
+
+	outb(val, ps2if->base);
+
+	return ret;
+}
+
+static void pcips2_close(struct serio *io)
+{
+	struct pcips2_data *ps2if = io->driver;
+
+	outb(0, ps2if->base);
+
+	free_irq(ps2if->dev->irq, ps2if);
+}
+
+static int __devinit pcips2_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	struct pcips2_data *ps2if;
+	int ret;
+
+	ret = pci_enable_device(dev);
+	if (ret)
+		return ret;
+
+	if (!request_region(pci_resource_start(dev, 0),
+			    pci_resource_len(dev, 0), "pcips2")) {
+		ret = -EBUSY;
+		goto disable;
+	}
+
+	ps2if = kmalloc(sizeof(struct pcips2_data), GFP_KERNEL);
+	if (!ps2if) {
+		ret = -ENOMEM;
+		goto release;
+	}
+
+	memset(ps2if, 0, sizeof(struct pcips2_data));
+
+	ps2if->io.type		= SERIO_8042;
+	ps2if->io.write		= pcips2_write;
+	ps2if->io.open		= pcips2_open;
+	ps2if->io.close		= pcips2_close;
+	ps2if->io.name		= dev->dev.name;
+	ps2if->io.phys		= dev->dev.bus_id;
+	ps2if->io.driver	= ps2if;
+	ps2if->dev		= dev;
+	ps2if->base		= pci_resource_start(dev, 0);
+
+	pci_set_drvdata(dev, ps2if);
+
+	serio_register_port(&ps2if->io);
+	return 0;
+
+ release:
+	release_region(pci_resource_start(dev, 0),
+		       pci_resource_len(dev, 0));
+ disable:
+	pci_disable_device(dev);
+	return ret;
+}
+
+static void __devexit pcips2_remove(struct pci_dev *dev)
+{
+	struct pcips2_data *ps2if = pci_get_drvdata(dev);
+
+	serio_unregister_port(&ps2if->io);
+	release_region(pci_resource_start(dev, 0),
+		       pci_resource_len(dev, 0));
+	pci_set_drvdata(dev, NULL);
+	kfree(ps2if);
+	pci_disable_device(dev);
+}
+
+static struct pci_device_id pcips2_ids[] = {
+	{
+		.vendor		= 0x14f2,	/* MOBILITY */
+		.device		= 0x0123,	/* Keyboard */
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.class		= PCI_CLASS_INPUT_KEYBOARD << 8,
+		.class_mask	= 0xffff00,
+	},
+	{
+		.vendor		= 0x14f2,	/* MOBILITY */
+		.device		= 0x0124,	/* Mouse */
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.class		= PCI_CLASS_INPUT_MOUSE << 8,
+		.class_mask	= 0xffff00,
+	},
+	{ 0, }
+};
+
+static struct pci_driver pcips2_driver = {
+	.name			= "pcips2",
+	.id_table		= pcips2_ids,
+	.probe			= pcips2_probe,
+	.remove			= __devexit_p(pcips2_remove),
+	.driver = {
+		.devclass	= &input_devclass,
+	},
+};
+
+static int __init pcips2_init(void)
+{
+	return pci_module_init(&pcips2_driver);
+}
+
+static void __exit pcips2_exit(void)
+{
+	pci_unregister_driver(&pcips2_driver);
+}
+
+module_init(pcips2_init);
+module_exit(pcips2_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
+MODULE_DESCRIPTION("PCI PS/2 keyboard/mouse driver");
+MODULE_DEVICE_TABLE(pci, pcips2_ids);
