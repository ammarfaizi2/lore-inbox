Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266659AbUF3Mhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266659AbUF3Mhv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266656AbUF3Mhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:37:51 -0400
Received: from styx.suse.cz ([82.119.242.94]:1152 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S266669AbUF3MhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:37:02 -0400
Date: Wed, 30 Jun 2004 14:38:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Experimental PS/2 driver with heuristic synchronization
Message-ID: <20040630123839.GA1333@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I wanted to try if my thoughts about how to reliably synchronize the
PS/2 mouse stream would work, and as a test I created this driver.

It supports only bare PS/2 protocol, because it's just an experiment.

The driver drops every 63rd byte from the input stream to simulate
missing bytes, yet it never loses sync, and the mouse is perfectly
usable.

Try it, take a look. It should be possible to extend this to all the
other protocols the current psmouse Linux driver supports.

[Nevertheless, we still should try to find the cause of the missing
 bytes, as those don't happen in 2.4 on many of the affected machines.]

ChangeSet@1.1859, 2004-06-30 14:32:06+02:00, vojtech@suse.cz
  input: PS/2 mouse stream autosynchronization experiment.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 Kconfig   |   11 +
 Makefile  |    1 
 ps2sync.c |  356 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 368 insertions(+)


diff -Nru a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
--- a/drivers/input/mouse/Kconfig	Wed Jun 30 14:36:18 2004
+++ b/drivers/input/mouse/Kconfig	Wed Jun 30 14:36:18 2004
@@ -36,6 +36,17 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called psmouse.
 
+config MOUSE_PS2SYNC
+	tristate "Experimental PS/2 autosync mouse driver"
+	default y
+	depends on INPUT && INPUT_MOUSE
+	select SERIO
+	select SERIO_I8042 if PC
+	select SERIO_GSCPS2 if GSC
+	---help---
+	  This is an Experiment on autosyncing the PS/2 mouse data stream.
+	  It may or may not work.
+
 config MOUSE_SERIAL
 	tristate "Serial mouse"
 	depends on INPUT && INPUT_MOUSE
diff -Nru a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
--- a/drivers/input/mouse/Makefile	Wed Jun 30 14:36:18 2004
+++ b/drivers/input/mouse/Makefile	Wed Jun 30 14:36:18 2004
@@ -11,6 +11,7 @@
 obj-$(CONFIG_MOUSE_MAPLE)	+= maplemouse.o
 obj-$(CONFIG_MOUSE_PC110PAD)	+= pc110pad.o
 obj-$(CONFIG_MOUSE_PS2)		+= psmouse.o
+obj-$(CONFIG_MOUSE_PS2SYNC)	+= ps2sync.o
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
 
diff -Nru a/drivers/input/mouse/ps2sync.c b/drivers/input/mouse/ps2sync.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/input/mouse/ps2sync.c	Wed Jun 30 14:36:18 2004
@@ -0,0 +1,356 @@
+/*
+ * Experimantal PS/2 mouse driver
+ *
+ * Copyright (c) 1999-2004 Vojtech Pavlik
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/init.h>
+#include "psmouse.h"
+
+#define DRIVER_DESC	"Experimental PS/2 mouse driver"
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+struct ps2sync {
+	struct input_dev dev;
+	struct serio *serio;
+
+	unsigned long flags;
+
+	unsigned char cmdbuf[8];
+	unsigned int cmdcnt;
+	unsigned int nak;
+
+	unsigned char data[5];
+	unsigned long time[5];
+	unsigned long lasttime;
+	unsigned int lastoffset;
+
+	char devname[64];
+	char phys[32];
+};
+
+static int ps2sync_score_data(unsigned char *data, unsigned long *time, int step)
+{
+	int score = 0;
+	int x, y;
+
+	if (~data[0] & 0x80) score += 4;
+	if (~data[0] & 0x40) score += 4;
+	if ( data[0] & 0x08) score += 4;
+
+	if (~data[0] & 0x04) score++;
+	if (~data[0] & 0x02) score++;
+	if (~data[0] & 0x01) score++;
+
+	x = abs(data[1] ? (int) data[1] - (int) ((data[0] << 4) & 0x100) : 0);
+	y = abs(data[2] ? (int) ((data[0] << 3) & 0x100) - (int) data[2] : 0);
+
+	if (x < 128) score++;
+	if (y < 128) score++;
+	if (x <   8) score++;
+	if (y <   8) score++;
+	if (x <   4) score++;
+	if (y <   4) score++;
+	if (x <   2) score++;
+	if (y <   2) score++;
+
+	if (time[1] < time[0] / 2 && time[2] < time[0] / 2)
+		score += 16;
+
+	if (!(step % 3))
+		score += 8;
+
+	return score;
+}
+
+static void ps2sync_process_packet(struct ps2sync *ps2sync, unsigned char *data, struct pt_regs *regs)
+{
+	struct input_dev *dev = &ps2sync->dev;
+
+	input_regs(dev, regs);
+
+	input_report_key(dev, BTN_LEFT,    data[0]       & 1);
+	input_report_key(dev, BTN_MIDDLE, (data[0] >> 2) & 1);
+	input_report_key(dev, BTN_RIGHT,  (data[0] >> 1) & 1);
+
+	input_report_rel(dev, REL_X, data[1] ? (int) data[1] - (int) ((data[0] << 4) & 0x100) : 0);
+	input_report_rel(dev, REL_Y, data[2] ? (int) ((data[0] << 3) & 0x100) - (int) data[2] : 0);
+
+	input_sync(dev);
+
+	printk(KERN_INFO "ps2sync: Packet processed.\n");
+}
+
+static irqreturn_t ps2sync_interrupt(struct serio *serio,
+		unsigned char data, unsigned int flags, struct pt_regs *regs)
+{
+	struct ps2sync *ps2sync = serio->private;
+	int offset = 0, score = 0;
+	int i, t;
+
+	if (test_bit(PSMOUSE_FLAG_ACK, &ps2sync->flags))
+		switch (data) {
+			case 0x00:/* Workaround for mice which don't ACK the Get ID command */
+			case PSMOUSE_RET_ACK:
+				ps2sync->nak = 0;
+				if (ps2sync->cmdcnt) {
+					set_bit(PSMOUSE_FLAG_CMD, &ps2sync->flags);
+					set_bit(PSMOUSE_FLAG_CMD1, &ps2sync->flags);
+					set_bit(PSMOUSE_FLAG_ID, &ps2sync->flags);
+				}
+				clear_bit(PSMOUSE_FLAG_ACK, &ps2sync->flags);
+				if (data == 0x00) break;
+				goto out;
+			case PSMOUSE_RET_NAK:
+				ps2sync->nak = 1;
+				clear_bit(PSMOUSE_FLAG_ACK, &ps2sync->flags);
+				goto out;
+		}
+
+	if (test_bit(PSMOUSE_FLAG_CMD, &ps2sync->flags)) {
+
+		ps2sync->cmdcnt--;
+		ps2sync->cmdbuf[ps2sync->cmdcnt] = data;
+
+		if (ps2sync->cmdcnt == 1) {
+			if (data != 0xab && data != 0xac)
+				clear_bit(PSMOUSE_FLAG_ID, &ps2sync->flags);
+			clear_bit(PSMOUSE_FLAG_CMD1, &ps2sync->flags);
+		}
+
+		if (!ps2sync->cmdcnt)
+			clear_bit(PSMOUSE_FLAG_CMD, &ps2sync->flags);
+
+		goto out;
+	}
+
+
+	{
+		static int killbyte = 0;
+		if (!(killbyte++ % 63)) {
+			printk(KERN_INFO "ps2sync: ------------------- DROPPING A BYTE -----------------\n");
+			goto out;
+		}
+	}
+
+	for (i = 0; i < 4; i++) {
+		ps2sync->data[i] = ps2sync->data[i + 1];
+		ps2sync->time[i] = ps2sync->time[i + 1];
+	}
+
+	ps2sync->time[4] = jiffies - ps2sync->lasttime;
+	ps2sync->data[4] = data;
+
+	for (i = 0; i < 3; i++) {
+		t = ps2sync_score_data(ps2sync->data + i, ps2sync->time + i, i - ps2sync->lastoffset + 1);
+		if (t > score) {
+			score = t;
+			offset = i;
+		}
+	}
+
+	printk(KERN_INFO "ps2sync: data: %02x, time: %ld, score: %d\n",
+		data, ps2sync->time[4], score);
+
+	if (offset - ps2sync->lastoffset + 1 != 0 && score > 30)
+			ps2sync_process_packet(ps2sync, ps2sync->data + offset, regs);
+
+	ps2sync->lasttime = jiffies;
+	ps2sync->lastoffset = offset;
+
+out:
+
+	return IRQ_HANDLED;
+}
+
+static int ps2sync_sendbyte(struct ps2sync *ps2sync, unsigned char byte)
+{
+	int timeout = 200000; /* 200 msec */
+
+	set_bit(PSMOUSE_FLAG_ACK, &ps2sync->flags);
+	if (serio_write(ps2sync->serio, byte))
+		return -1;
+	while (test_bit(PSMOUSE_FLAG_ACK, &ps2sync->flags) && timeout--) udelay(1);
+	clear_bit(PSMOUSE_FLAG_ACK, &ps2sync->flags);
+
+	return -ps2sync->nak;
+}
+
+static int ps2sync_command(struct ps2sync *ps2sync, unsigned char *param, int command)
+{
+	int timeout = 500000; /* 500 msec */
+	int send = (command >> 12) & 0xf;
+	int receive = (command >> 8) & 0xf;
+	int i;
+
+	ps2sync->cmdcnt = receive;
+
+	if (command == PSMOUSE_CMD_RESET_BAT)
+		timeout = 4000000; /* 4 sec */
+
+	if (receive && param)
+		for (i = 0; i < receive; i++)
+			ps2sync->cmdbuf[(receive - 1) - i] = param[i];
+
+	if (command & 0xff)
+		if (ps2sync_sendbyte(ps2sync, command & 0xff))
+			return -1;
+
+	for (i = 0; i < send; i++)
+		if (ps2sync_sendbyte(ps2sync, param[i]))
+			return -1;
+
+	while (test_bit(PSMOUSE_FLAG_CMD, &ps2sync->flags) && timeout--) {
+
+		if (!test_bit(PSMOUSE_FLAG_CMD1, &ps2sync->flags)) {
+
+			if (command == PSMOUSE_CMD_RESET_BAT && timeout > 100000)
+				timeout = 100000;
+
+			if (command == PSMOUSE_CMD_GETID && !test_bit(PSMOUSE_FLAG_ID, &ps2sync->flags)) {
+				clear_bit(PSMOUSE_FLAG_CMD, &ps2sync->flags);
+				ps2sync->cmdcnt = 0;
+				break;
+			}
+		}
+
+		udelay(1);
+	}
+
+	clear_bit(PSMOUSE_FLAG_CMD, &ps2sync->flags);
+
+	if (param)
+		for (i = 0; i < receive; i++)
+			param[i] = ps2sync->cmdbuf[(receive - 1) - i];
+
+	if (command == PSMOUSE_CMD_RESET_BAT && ps2sync->cmdcnt == 1)
+		return 0;
+
+	if (ps2sync->cmdcnt)
+		return -1;
+
+	return 0;
+}
+
+static int ps2sync_probe(struct ps2sync *ps2sync)
+{
+	unsigned char param[2];
+
+	if (ps2sync_command(ps2sync, param, PSMOUSE_CMD_RESET_BAT))
+		return -1;
+
+	if (param[0] != PSMOUSE_RET_BAT && param[1] != PSMOUSE_RET_ID)
+		return -1;
+
+	return 0;
+}
+
+static int ps2sync_initialize(struct ps2sync *ps2sync)
+{
+	unsigned char param[2];
+
+	if (ps2sync_command(ps2sync, NULL, PSMOUSE_CMD_ENABLE))
+		return -1;
+
+	if (ps2sync_command(ps2sync, param, PSMOUSE_CMD_SETSTREAM))
+		return -1;
+
+	return 0;
+}
+
+static void ps2sync_disconnect(struct serio *serio)
+{
+	struct ps2sync *ps2sync;
+	ps2sync = serio->private;
+	input_unregister_device(&ps2sync->dev);
+	serio_close(serio);
+	kfree(ps2sync);
+}
+
+static void ps2sync_connect(struct serio *serio, struct serio_driver *drv)
+{
+	struct ps2sync *ps2sync;
+
+	if ((serio->type & SERIO_TYPE) != SERIO_8042)
+		return;
+
+	if (!(ps2sync = kmalloc(sizeof(struct ps2sync), GFP_KERNEL))) return;
+	memset(ps2sync, 0, sizeof(struct ps2sync));
+
+	init_input_dev(&ps2sync->dev);
+	ps2sync->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	ps2sync->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+	ps2sync->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
+	ps2sync->serio = serio;
+	ps2sync->dev.private = ps2sync;
+	serio->private = ps2sync;
+
+	if (serio_open(serio, drv)) {
+		kfree(ps2sync);
+		serio->private = NULL;
+		return;
+	}
+
+	if (ps2sync_probe(ps2sync) < 0) {
+		serio_close(serio);
+		kfree(ps2sync);
+		serio->private = NULL;
+		return;
+	}
+
+	sprintf(ps2sync->devname, "PS/2 Experimental Mouse");
+	sprintf(ps2sync->phys, "%s/input0", serio->phys);
+
+	ps2sync->dev.name = ps2sync->devname;
+	ps2sync->dev.phys = ps2sync->phys;
+	ps2sync->dev.id.bustype = BUS_I8042;
+	ps2sync->dev.id.vendor = 0xeee1;
+	ps2sync->dev.id.product = 0x01;
+	ps2sync->dev.id.version = 0x00;
+
+	input_register_device(&ps2sync->dev);
+
+	printk(KERN_INFO "input: %s on %s\n", ps2sync->devname, serio->phys);
+
+	ps2sync_initialize(ps2sync);
+}
+
+static struct serio_driver ps2sync_drv = {
+	.driver		= {
+		.name	= "ps2sync",
+	},
+	.description	= DRIVER_DESC,
+	.interrupt	= ps2sync_interrupt,
+	.connect	= ps2sync_connect,
+	.disconnect	= ps2sync_disconnect,
+};
+
+int __init ps2sync_init(void)
+{
+	serio_register_driver(&ps2sync_drv);
+	return 0;
+}
+
+void __exit ps2sync_exit(void)
+{
+	serio_unregister_driver(&ps2sync_drv);
+}
+
+module_init(ps2sync_init);
+module_exit(ps2sync_exit);

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
