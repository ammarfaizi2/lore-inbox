Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268101AbUHXAeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268101AbUHXAeB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267520AbUHWTqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:46:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:52419 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266870AbUHWSg1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:27 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860881362@kroah.com>
Date: Mon, 23 Aug 2004 11:34:48 -0700
Message-Id: <1093286088860@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.32, 2004/08/06 15:46:38-07:00, johnpol@2ka.mipt.ru

[PATCH] w1: Added driver for Dallas' DS9490* USB <-> W1 master.

Added driver for Dallas' DS9490* USB <-> W1 master.
Should handle any device based on DS2490 chip.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/Kconfig        |   19 +
 drivers/w1/Makefile       |    6 
 drivers/w1/ds_w1_bridge.c |  176 ++++++++++
 drivers/w1/dscore.c       |  788 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/w1/dscore.h       |  173 ++++++++++
 5 files changed, 1162 insertions(+)


diff -Nru a/drivers/w1/Kconfig b/drivers/w1/Kconfig
--- a/drivers/w1/Kconfig	2004-08-23 11:03:35 -07:00
+++ b/drivers/w1/Kconfig	2004-08-23 11:03:35 -07:00
@@ -21,6 +21,25 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called matrox_w1.ko.
 
+config W1_DS9490
+	tristate "DS9490R transport layer driver"
+	depends on W1 && USB
+	help
+	  Say Y here if you want to have a driver for DS9490R UWB <-> W1 bridge.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called ds9490r.ko.
+
+config W1_DS9490R_BRIDGE
+	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
+	depends on W1_DS9490
+	help
+	  Say Y here if you want to communicate with your 1-wire devices
+	  using DS9490R USB bridge.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called ds_w1_bridge.ko.
+
 config W1_THERM
 	tristate "Thermal family implementation"
 	depends on W1
diff -Nru a/drivers/w1/Makefile b/drivers/w1/Makefile
--- a/drivers/w1/Makefile	2004-08-23 11:03:35 -07:00
+++ b/drivers/w1/Makefile	2004-08-23 11:03:35 -07:00
@@ -8,3 +8,9 @@
 obj-$(CONFIG_W1_MATROX)		+= matrox_w1.o
 obj-$(CONFIG_W1_THERM)		+= w1_therm.o
 obj-$(CONFIG_W1_SMEM)		+= w1_smem.o
+
+obj-$(CONFIG_W1_DS9490)		+= ds9490r.o 
+ds9490r-objs    := dscore.o
+
+obj-$(CONFIG_W1_DS9490_BRIDGE)	+= ds_w1_bridge.o
+
diff -Nru a/drivers/w1/ds_w1_bridge.c b/drivers/w1/ds_w1_bridge.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/ds_w1_bridge.c	2004-08-23 11:03:35 -07:00
@@ -0,0 +1,176 @@
+/*
+ * 	ds_w1_bridge.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
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
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include "../w1/w1.h"
+#include "../w1/w1_int.h"
+#include "dscore.h"
+	
+static struct ds_device *ds_dev;
+static struct w1_bus_master *ds_bus_master;
+
+static u8 ds9490r_touch_bit(unsigned long data, u8 bit)
+{
+	u8 ret;
+	struct ds_device *dev = (struct ds_device *)data;
+
+	if (ds_touch_bit(dev, bit, &ret))
+		return 0;
+
+	return ret;
+}
+
+static void ds9490r_write_bit(unsigned long data, u8 bit)
+{
+	struct ds_device *dev = (struct ds_device *)data;
+
+	ds_write_bit(dev, bit);
+}
+
+static void ds9490r_write_byte(unsigned long data, u8 byte)
+{
+	struct ds_device *dev = (struct ds_device *)data;
+
+	ds_write_byte(dev, byte);
+}
+
+static u8 ds9490r_read_bit(unsigned long data)
+{
+	struct ds_device *dev = (struct ds_device *)data;
+	int err;
+	u8 bit = 0;
+
+	err = ds_touch_bit(dev, 1, &bit);
+	if (err)
+		return 0;
+	//err = ds_read_bit(dev, &bit);
+	//if (err)
+	//	return 0;
+
+	return bit & 1;
+}
+
+static u8 ds9490r_read_byte(unsigned long data)
+{
+	struct ds_device *dev = (struct ds_device *)data;
+	int err;
+	u8 byte = 0;
+
+	err = ds_read_byte(dev, &byte);
+	if (err)
+		return 0;
+
+	return byte;
+}
+
+static void ds9490r_write_block(unsigned long data, u8 *buf, int len)
+{
+	struct ds_device *dev = (struct ds_device *)data;
+
+	ds_write_block(dev, buf, len);
+}
+
+static u8 ds9490r_read_block(unsigned long data, u8 *buf, int len)
+{
+	struct ds_device *dev = (struct ds_device *)data;
+	int err;
+
+	err = ds_read_block(dev, buf, len);
+	if (err < 0)
+		return 0;
+
+	return len;
+}
+
+static u8 ds9490r_reset(unsigned long data)
+{
+	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_status st;
+	int err;
+
+	memset(&st, 0, sizeof(st));
+
+	err = ds_reset(dev, &st);
+	if (err)
+		return 1;
+
+	return 0;
+}
+
+static int __devinit ds_w1_init(void)
+{
+	int err;
+	
+	ds_bus_master = kmalloc(sizeof(*ds_bus_master), GFP_KERNEL);
+	if (!ds_bus_master)
+	{
+		printk(KERN_ERR "Failed to allocate DS9490R USB<->W1 bus_master structure.\n");
+		return -ENOMEM;
+	}
+
+	ds_dev = ds_get_device();
+	if (!ds_dev)
+	{
+		printk(KERN_ERR "DS9490R is not registered.\n");
+		err =  -ENODEV;
+		goto err_out_free_bus_master;
+	}
+
+	memset(ds_bus_master, 0, sizeof(*ds_bus_master));
+
+	ds_bus_master->data 		= (unsigned long)ds_dev;
+	ds_bus_master->touch_bit 	= &ds9490r_touch_bit;
+	ds_bus_master->read_bit 	= &ds9490r_read_bit;
+	ds_bus_master->write_bit 	= &ds9490r_write_bit;
+	ds_bus_master->read_byte 	= &ds9490r_read_byte;
+	ds_bus_master->write_byte 	= &ds9490r_write_byte;
+	ds_bus_master->read_block 	= &ds9490r_read_block;
+	ds_bus_master->write_block 	= &ds9490r_write_block;
+	ds_bus_master->reset_bus	= &ds9490r_reset;
+
+	err = w1_add_master_device(ds_bus_master);
+	if (err)
+		goto err_out_put_device;
+
+	return 0;
+
+err_out_put_device:
+	ds_put_device(ds_dev);
+err_out_free_bus_master:
+	kfree(ds_bus_master);
+
+	return err;
+}
+
+static void __devexit ds_w1_fini(void)
+{
+	w1_remove_master_device(ds_bus_master);
+	ds_put_device(ds_dev);
+	kfree(ds_bus_master);
+}
+
+module_init(ds_w1_init);
+module_exit(ds_w1_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
diff -Nru a/drivers/w1/dscore.c b/drivers/w1/dscore.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/dscore.c	2004-08-23 11:03:35 -07:00
@@ -0,0 +1,788 @@
+/*
+ * 	dscore.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
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
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/usb.h>
+
+#include "dscore.h"
+
+static struct usb_device_id ds_id_table [] = {
+	{ USB_DEVICE(0x04fa, 0x2490) },
+	{ },
+};
+MODULE_DEVICE_TABLE(usb, ds_id_table);
+
+int ds_probe(struct usb_interface *, const struct usb_device_id *);
+void ds_disconnect(struct usb_interface *);
+
+inline int ds_touch_bit(struct ds_device *, u8, u8 *);
+inline int ds_read_byte(struct ds_device *, u8 *);
+inline int ds_read_bit(struct ds_device *, u8 *);
+inline int ds_write_byte(struct ds_device *, u8);
+inline int ds_write_bit(struct ds_device *, u8);
+inline int ds_start_pulse(struct ds_device *, int);
+inline int ds_set_speed(struct ds_device *, int);
+inline int ds_reset(struct ds_device *, struct ds_status *);
+inline int ds_detect(struct ds_device *, struct ds_status *);
+inline int ds_stop_pulse(struct ds_device *, int);
+inline int ds_send_data(struct ds_device *, unsigned char *, int);
+inline int ds_recv_data(struct ds_device *, unsigned char *, int);
+inline int ds_recv_status(struct ds_device *, struct ds_status *);
+inline struct ds_device * ds_get_device(void);
+inline void ds_put_device(struct ds_device *);
+
+static inline void ds_dump_status(unsigned char *, unsigned char *, int);
+static inline int ds_send_control(struct ds_device *, u16, u16);
+static inline int ds_send_control_mode(struct ds_device *, u16, u16);
+static inline int ds_send_control_cmd(struct ds_device *, u16, u16);
+
+
+static struct usb_driver ds_driver = {
+	.owner =	THIS_MODULE,
+	.name =		"DS9490R",
+	.probe =	ds_probe,
+	.disconnect =	ds_disconnect,
+	.id_table =	ds_id_table,
+};
+
+static struct ds_device *ds_dev;
+
+struct ds_device * ds_get_device(void)
+{
+	if (ds_dev)
+		atomic_inc(&ds_dev->refcnt);
+	return ds_dev;
+}
+
+void ds_put_device(struct ds_device *dev)
+{
+	atomic_dec(&dev->refcnt);
+}
+
+static int ds_send_control_cmd(struct ds_device *dev, u16 value, u16 index)
+{
+	int err;
+	
+	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]), 
+			CONTROL_CMD, 0x40, value, index, NULL, 0, HZ);
+	if (err < 0) {
+		printk(KERN_ERR "Failed to send command control message %x.%x: err=%d.\n", 
+				value, index, err);
+		return err;
+	}
+
+	return err;
+}
+
+static int ds_send_control_mode(struct ds_device *dev, u16 value, u16 index)
+{
+	int err;
+	
+	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]), 
+			MODE_CMD, 0x40, value, index, NULL, 0, HZ);
+	if (err < 0) {
+		printk(KERN_ERR "Failed to send mode control message %x.%x: err=%d.\n", 
+				value, index, err);
+		return err;
+	}
+
+	return err;
+}
+
+static int ds_send_control(struct ds_device *dev, u16 value, u16 index)
+{
+	int err;
+	
+	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]), 
+			COMM_CMD, 0x40, value, index, NULL, 0, HZ);
+	if (err < 0) {
+		printk(KERN_ERR "Failed to send control message %x.%x: err=%d.\n", 
+				value, index, err);
+		return err;
+	}
+
+	return err;
+}
+
+static inline void ds_dump_status(unsigned char *buf, unsigned char *str, int off)
+{
+	printk("%45s: %8x\n", str, buf[off]);
+}
+
+int ds_recv_status_nodump(struct ds_device *dev, struct ds_status *st, unsigned char *buf, int size)
+{
+	int count, err;
+		
+	memset(st, 0, sizeof(st));
+	
+	count = 0;
+	err = usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_STATUS]), buf, size, &count, 100);
+	if (err < 0) {
+		printk(KERN_ERR "Failed to read 1-wire data from 0x%x: err=%d.\n", dev->ep[EP_STATUS], err);
+		return err;
+	}
+	
+	if (count >= sizeof(*st))
+		memcpy(st, buf, sizeof(*st));
+
+	return count;
+}
+
+int ds_recv_status(struct ds_device *dev, struct ds_status *st)
+{
+	unsigned char buf[64];
+	int count, err = 0, i;
+	
+	memcpy(st, buf, sizeof(*st));
+		
+	count = ds_recv_status_nodump(dev, st, buf, sizeof(buf));
+	if (count < 0)
+		return err;
+	
+	printk("0x%x: count=%d, status: ", dev->ep[EP_STATUS], count);
+	for (i=0; i<count; ++i)
+		printk("%02x ", buf[i]);
+	printk("\n");
+
+	if (count >= 16)
+	{
+		ds_dump_status(buf, "enable flag", 0);
+		ds_dump_status(buf, "1-wire speed", 1);
+		ds_dump_status(buf, "strong pullup duration", 2);
+		ds_dump_status(buf, "programming pulse duration", 3);
+		ds_dump_status(buf, "pulldown slew rate control", 4);
+		ds_dump_status(buf, "write-1 low time", 5);
+		ds_dump_status(buf, "data sample offset/write-0 recovery time", 6);
+		ds_dump_status(buf, "reserved (test register)", 7);
+		ds_dump_status(buf, "device status flags", 8);
+		ds_dump_status(buf, "communication command byte 1", 9);
+		ds_dump_status(buf, "communication command byte 2", 10);
+		ds_dump_status(buf, "communication command buffer status", 11);
+		ds_dump_status(buf, "1-wire data output buffer status", 12);
+		ds_dump_status(buf, "1-wire data input buffer status", 13);
+		ds_dump_status(buf, "reserved", 14);
+		ds_dump_status(buf, "reserved", 15);
+	}
+
+	memcpy(st, buf, sizeof(*st));
+
+	if (st->status & ST_EPOF)
+	{
+		printk(KERN_INFO "Resetting device after ST_EPOF.\n");
+		err = ds_send_control_cmd(dev, CTL_RESET_DEVICE, 0);
+		if (err)
+			return err;
+		count = ds_recv_status_nodump(dev, st, buf, sizeof(buf));
+		if (count < 0)
+			return err;
+	}
+#if 0
+	if (st->status & ST_IDLE)
+	{
+		printk(KERN_INFO "Resetting pulse after ST_IDLE.\n");
+		err = ds_start_pulse(dev, PULLUP_PULSE_DURATION);
+		if (err)
+			return err;
+	}
+#endif
+	
+	return err;
+}
+
+int ds_recv_data(struct ds_device *dev, unsigned char *buf, int size)
+{
+	int count, err;
+	struct ds_status st;
+	
+	count = 0;
+	err = usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DATA_IN]), 
+				buf, size, &count, HZ);
+	if (err < 0) {
+		printk(KERN_INFO "Clearing ep0x%x.\n", dev->ep[EP_DATA_IN]);
+		usb_clear_halt(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DATA_IN]));
+		ds_recv_status(dev, &st);
+		return err;
+	}
+
+#if 0
+	{
+		int i;
+
+		printk("%s: count=%d: ", __func__, count);
+		for (i=0; i<count; ++i)
+			printk("%02x ", buf[i]);
+		printk("\n");
+	}
+#endif
+	return count;
+}
+
+int ds_send_data(struct ds_device *dev, unsigned char *buf, int len)
+{
+	int count, err;
+	
+	count = 0;
+	err = usb_bulk_msg(dev->udev, usb_sndbulkpipe(dev->udev, dev->ep[EP_DATA_OUT]), buf, len, &count, HZ);
+	if (err < 0) {
+		printk(KERN_ERR "Failed to read 1-wire data from 0x02: err=%d.\n", err);
+		return err;
+	}
+
+	return err;
+}
+
+int ds_stop_pulse(struct ds_device *dev, int limit)
+{
+	struct ds_status st;
+	int count = 0, err = 0;
+	u8 buf[0x20];
+	
+	do {
+		err = ds_send_control(dev, CTL_HALT_EXE_IDLE, 0);
+		if (err)
+			break;
+		err = ds_send_control(dev, CTL_RESUME_EXE, 0);
+		if (err)
+			break;
+		err = ds_recv_status_nodump(dev, &st, buf, sizeof(buf));
+		if (err)
+			break;
+
+		if ((st.status & ST_SPUA) == 0) {
+			err = ds_send_control_mode(dev, MOD_PULSE_EN, 0);
+			if (err)
+				break;
+		}
+	} while(++count < limit);
+
+	return err;
+}
+
+int ds_detect(struct ds_device *dev, struct ds_status *st)
+{
+	int err;
+	
+	err = ds_send_control_cmd(dev, CTL_RESET_DEVICE, 0);
+	if (err)
+		return err;
+
+	err = ds_send_control(dev, COMM_SET_DURATION | COMM_IM, 0);
+	if (err)
+		return err;
+	
+	err = ds_send_control(dev, COMM_SET_DURATION | COMM_IM | COMM_TYPE, 0x40);
+	if (err)
+		return err;
+	
+	err = ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_PROG);
+	if (err)
+		return err;
+
+	err = ds_recv_status(dev, st);
+
+	return err;
+}
+
+int ds_wait_status(struct ds_device *dev, struct ds_status *st)
+{
+	u8 buf[0x20];
+	int err, count = 0;
+
+	do {
+		err = ds_recv_status_nodump(dev, st, buf, sizeof(buf));
+#if 0
+		if (err >= 0)
+		{	
+			int i;
+			printk("0x%x: count=%d, status: ", dev->ep[EP_STATUS], err);
+			for (i=0; i<err; ++i)
+				printk("%02x ", buf[i]);
+			printk("\n");
+		}
+#endif
+	} while(!(buf[0x08] & 0x20) && !(err < 0) && ++count < 100);
+
+
+	if (((err > 16) && (buf[0x10] & 0x01)) || count >= 100 || err < 0) {
+		ds_recv_status(dev, st);
+		return -1;
+	}
+	else {
+		return 0;
+	}
+}
+
+int ds_reset(struct ds_device *dev, struct ds_status *st)
+{
+	int err;
+
+	//err = ds_send_control(dev, COMM_1_WIRE_RESET | COMM_F | COMM_IM | COMM_SE, SPEED_FLEXIBLE);
+	err = ds_send_control(dev, 0x43, SPEED_NORMAL);
+	if (err)
+		return err;
+
+	ds_wait_status(dev, st);
+#if 0
+	if (st->command_buffer_status)
+	{
+		printk(KERN_INFO "Short circuit.\n");
+		return -EIO;
+	}
+#endif
+	
+	return 0;
+}
+
+int ds_set_speed(struct ds_device *dev, int speed)
+{
+	int err;
+	
+	if (speed != SPEED_NORMAL && speed != SPEED_FLEXIBLE && speed != SPEED_OVERDRIVE)
+		return -EINVAL;
+
+	if (speed != SPEED_OVERDRIVE)
+		speed = SPEED_FLEXIBLE;
+
+	speed &= 0xff;
+	
+	err = ds_send_control_mode(dev, MOD_1WIRE_SPEED, speed);
+	if (err)
+		return err;
+
+	return err;
+}
+
+int ds_start_pulse(struct ds_device *dev, int delay)
+{
+	int err;
+	u8 del = 1 + (u8)(delay >> 4);
+	struct ds_status st;
+	
+#if 0
+	err = ds_stop_pulse(dev, 10);
+	if (err)
+		return err;
+
+	err = ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_SPUE);
+	if (err)
+		return err;
+#endif
+	err = ds_send_control(dev, COMM_SET_DURATION | COMM_IM, del);
+	if (err)
+		return err;
+
+	err = ds_send_control(dev, COMM_PULSE | COMM_IM | COMM_F, 0);
+	if (err)
+		return err;
+
+	mdelay(delay);
+
+	ds_wait_status(dev, &st);
+	
+	return err;
+}
+
+int ds_touch_bit(struct ds_device *dev, u8 bit, u8 *tbit)
+{
+	int err, count;
+	struct ds_status st;
+	u16 value = (COMM_BIT_IO | COMM_IM) | ((bit) ? COMM_D : 0);
+	u16 cmd;
+	
+	err = ds_send_control(dev, value, 0);
+	if (err)
+		return err;
+
+	count = 0;
+	do {
+		err = ds_wait_status(dev, &st);
+		if (err)
+			return err;
+
+		cmd = st.command0 | (st.command1 << 8);
+	} while (cmd != value && ++count < 10);
+
+	if (err < 0 || count >= 10) {
+		printk(KERN_ERR "Failed to obtain status.\n");
+		return -EINVAL;
+	}
+
+	err = ds_recv_data(dev, tbit, sizeof(*tbit));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+int ds_write_bit(struct ds_device *dev, u8 bit)
+{
+	int err;
+	struct ds_status st;
+	
+	err = ds_send_control(dev, COMM_BIT_IO | COMM_IM | (bit) ? COMM_D : 0, 0);
+	if (err)
+		return err;
+
+	ds_wait_status(dev, &st);
+
+	return 0;
+}
+
+int ds_write_byte(struct ds_device *dev, u8 byte)
+{
+	int err;
+	struct ds_status st;
+	u8 rbyte;
+	
+	err = ds_send_control(dev, COMM_BYTE_IO | COMM_IM | COMM_SPU, byte);
+	if (err)
+		return err;
+
+	err = ds_wait_status(dev, &st);
+	if (err)
+		return err;
+		
+	err = ds_recv_data(dev, &rbyte, sizeof(rbyte));
+	if (err < 0)
+		return err;
+	
+	ds_start_pulse(dev, PULLUP_PULSE_DURATION);
+
+	return !(byte == rbyte);
+}
+
+int ds_read_bit(struct ds_device *dev, u8 *bit)
+{
+	int err;
+
+	err = ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_SPUE);
+	if (err)
+		return err;
+	
+	err = ds_send_control(dev, COMM_BIT_IO | COMM_IM | COMM_SPU | COMM_D, 0);
+	if (err)
+		return err;
+	
+	err = ds_recv_data(dev, bit, sizeof(*bit));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+int ds_read_byte(struct ds_device *dev, u8 *byte)
+{
+	int err;
+	struct ds_status st;
+
+	err = ds_send_control(dev, COMM_BYTE_IO | COMM_IM , 0xff);
+	if (err)
+		return err;
+
+	ds_wait_status(dev, &st);
+	
+	err = ds_recv_data(dev, byte, sizeof(*byte));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+inline int ds_read_block(struct ds_device *dev, u8 *buf, int len)
+{
+	struct ds_status st;
+	int err;
+
+	if (len > 64*1024)
+		return -E2BIG;
+
+	memset(buf, 0xFF, len);
+	
+	err = ds_send_data(dev, buf, len);
+	if (err < 0)
+		return err;
+	
+	err = ds_send_control(dev, COMM_BLOCK_IO | COMM_IM | COMM_SPU, len);
+	if (err)
+		return err;
+
+	ds_wait_status(dev, &st);
+	
+	memset(buf, 0x00, len);
+	err = ds_recv_data(dev, buf, len);
+
+	return err;
+}
+
+inline int ds_write_block(struct ds_device *dev, u8 *buf, int len)
+{
+	int err;
+	struct ds_status st;
+	
+	err = ds_send_data(dev, buf, len);
+	if (err < 0)
+		return err;
+	
+	ds_wait_status(dev, &st);
+
+	err = ds_send_control(dev, COMM_BLOCK_IO | COMM_IM | COMM_SPU, len);
+	if (err)
+		return err;
+
+	ds_wait_status(dev, &st);
+
+	err = ds_recv_data(dev, buf, len);
+	if (err < 0)
+		return err;
+
+	ds_start_pulse(dev, PULLUP_PULSE_DURATION);
+	
+	return !(err == len);
+}
+
+int ds_search(struct ds_device *dev, u64 init, u64 *buf, u8 id_number, int conditional_search)
+{
+	int err;
+	u16 value, index;
+	struct ds_status st;
+
+	memset(buf, 0, sizeof(buf));
+	
+	err = ds_send_data(ds_dev, (unsigned char *)&init, 8);
+	if (err)
+		return err;
+	
+	ds_wait_status(ds_dev, &st);
+
+	value = COMM_SEARCH_ACCESS | COMM_IM | COMM_SM | COMM_F | COMM_RTS;
+	index = (conditional_search ? 0xEC : 0xF0) | (id_number << 8);
+	err = ds_send_control(ds_dev, value, index);
+	if (err)
+		return err;
+
+	ds_wait_status(ds_dev, &st);
+
+	err = ds_recv_data(ds_dev, (unsigned char *)buf, 8*id_number);
+	if (err < 0)
+		return err;
+
+	return err/8;
+}
+
+int ds_match_access(struct ds_device *dev, u64 init)
+{
+	int err;
+	struct ds_status st;
+
+	err = ds_send_data(dev, (unsigned char *)&init, sizeof(init));
+	if (err)
+		return err;
+	
+	ds_wait_status(dev, &st);
+
+	err = ds_send_control(dev, COMM_MATCH_ACCESS | COMM_IM | COMM_RST, 0x0055);
+	if (err)
+		return err;
+
+	ds_wait_status(dev, &st);
+
+	return 0;
+}
+
+int ds_set_path(struct ds_device *dev, u64 init)
+{
+	int err;
+	struct ds_status st;
+	u8 buf[9];
+
+	memcpy(buf, &init, 8);
+	buf[8] = BRANCH_MAIN;
+	
+	err = ds_send_data(dev, buf, sizeof(buf));
+	if (err)
+		return err;
+	
+	ds_wait_status(dev, &st);
+
+	err = ds_send_control(dev, COMM_SET_PATH | COMM_IM | COMM_RST, 0);
+	if (err)
+		return err;
+
+	ds_wait_status(dev, &st);
+
+	return 0;
+}
+
+int ds_probe(struct usb_interface *intf, const struct usb_device_id *udev_id)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct usb_endpoint_descriptor *endpoint;
+	struct usb_host_interface *iface_desc;
+	int i, err;
+
+	ds_dev = kmalloc(sizeof(struct ds_device), GFP_KERNEL);
+	if (!ds_dev) {
+		printk(KERN_INFO "Failed to allocate new DS9490R structure.\n");
+		return -ENOMEM;
+	}
+
+	ds_dev->udev = usb_get_dev(udev);
+	usb_set_intfdata(intf, ds_dev);
+
+	err = usb_set_interface(ds_dev->udev, intf->altsetting[0].desc.bInterfaceNumber, 3);
+	if (err) {
+		printk(KERN_ERR "Failed to set alternative setting 3 for %d interface: err=%d.\n",
+				intf->altsetting[0].desc.bInterfaceNumber, err);
+		return err;
+	}
+
+	err = usb_reset_configuration(ds_dev->udev);
+	if (err) {
+		printk(KERN_ERR "Failed to reset configuration: err=%d.\n", err);
+		return err;
+	}
+	
+	iface_desc = &intf->altsetting[0];
+	if (iface_desc->desc.bNumEndpoints != NUM_EP-1) {
+		printk(KERN_INFO "Num endpoints=%d. It is not DS9490R.\n", iface_desc->desc.bNumEndpoints);
+		return -ENODEV;
+	}
+
+	atomic_set(&ds_dev->refcnt, 0);
+	memset(ds_dev->ep, 0, sizeof(ds_dev->ep));
+	
+	/*
+	 * This loop doesn'd show control 0 endpoint, 
+	 * so we will fill only 1-3 endpoints entry.
+	 */
+	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
+		endpoint = &iface_desc->endpoint[i].desc;
+
+		ds_dev->ep[i+1] = endpoint->bEndpointAddress;
+		
+		printk("%d: addr=%x, size=%d, dir=%s, type=%x\n",
+			i, endpoint->bEndpointAddress, endpoint->wMaxPacketSize,
+			(endpoint->bEndpointAddress & USB_DIR_IN)?"IN":"OUT",
+			endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK);
+	}
+	
+#if 0
+	{
+		int err, i;
+		u64 buf[3];
+		u64 init=0xb30000002078ee81ull;
+		struct ds_status st;
+		
+		ds_reset(ds_dev, &st);
+		err = ds_search(ds_dev, init, buf, 3, 0);
+		if (err < 0)
+			return err;
+		for (i=0; i<err; ++i)
+			printk("%d: %llx\n", i, buf[i]);
+		
+		printk("Resetting...\n");	
+		ds_reset(ds_dev, &st);
+		printk("Setting path for %llx.\n", init);
+		err = ds_set_path(ds_dev, init);
+		if (err)
+			return err;
+		printk("Calling MATCH_ACCESS.\n");
+		err = ds_match_access(ds_dev, init);
+		if (err)
+			return err;
+
+		printk("Searching the bus...\n");
+		err = ds_search(ds_dev, init, buf, 3, 0);
+
+		printk("ds_search() returned %d\n", err);
+		
+		if (err < 0)
+			return err;
+		for (i=0; i<err; ++i)
+			printk("%d: %llx\n", i, buf[i]);
+		
+		return 0;
+	}
+#endif
+
+	return 0;
+}
+
+void ds_disconnect(struct usb_interface *intf)
+{
+	struct ds_device *dev;
+	
+	dev = usb_get_intfdata (intf);
+	usb_set_intfdata (intf, NULL);
+
+	while(atomic_read(&dev->refcnt))
+		schedule_timeout(HZ);
+
+	usb_put_dev(dev->udev);
+	kfree(dev);
+	ds_dev = NULL;
+}
+
+int ds_init(void)
+{
+	int err;
+
+	err = usb_register(&ds_driver);
+	if (err) {
+		printk(KERN_INFO "Failed to register DS9490R USB device: err=%d.\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+void ds_fini(void)
+{
+	usb_deregister(&ds_driver);
+}
+
+module_init(ds_init);
+module_exit(ds_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+
+EXPORT_SYMBOL(ds_touch_bit);
+EXPORT_SYMBOL(ds_read_byte);
+EXPORT_SYMBOL(ds_read_bit);
+EXPORT_SYMBOL(ds_read_block);
+EXPORT_SYMBOL(ds_write_byte);
+EXPORT_SYMBOL(ds_write_bit);
+EXPORT_SYMBOL(ds_write_block);
+EXPORT_SYMBOL(ds_start_pulse);
+EXPORT_SYMBOL(ds_set_speed);
+EXPORT_SYMBOL(ds_reset);
+EXPORT_SYMBOL(ds_detect);
+EXPORT_SYMBOL(ds_stop_pulse);
+EXPORT_SYMBOL(ds_send_data);
+EXPORT_SYMBOL(ds_recv_data);
+EXPORT_SYMBOL(ds_recv_status);
+EXPORT_SYMBOL(ds_search);
+EXPORT_SYMBOL(ds_get_device);
+EXPORT_SYMBOL(ds_put_device);
+
diff -Nru a/drivers/w1/dscore.h b/drivers/w1/dscore.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/dscore.h	2004-08-23 11:03:35 -07:00
@@ -0,0 +1,173 @@
+/*
+ * 	dscore.h
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
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
+ */
+
+#ifndef __DSCORE_H
+#define __DSCORE_H
+
+#include <linux/usb.h>
+#include <asm/atomic.h>
+
+/* COMMAND TYPE CODES */
+#define CONTROL_CMD			0x00
+#define COMM_CMD			0x01
+#define MODE_CMD			0x02
+
+/* CONTROL COMMAND CODES */
+#define CTL_RESET_DEVICE		0x0000
+#define CTL_START_EXE			0x0001
+#define CTL_RESUME_EXE			0x0002
+#define CTL_HALT_EXE_IDLE		0x0003
+#define CTL_HALT_EXE_DONE		0x0004
+#define CTL_FLUSH_COMM_CMDS		0x0007
+#define CTL_FLUSH_RCV_BUFFER		0x0008
+#define CTL_FLUSH_XMT_BUFFER		0x0009
+#define CTL_GET_COMM_CMDS		0x000A
+
+/* MODE COMMAND CODES */
+#define MOD_PULSE_EN			0x0000
+#define MOD_SPEED_CHANGE_EN		0x0001
+#define MOD_1WIRE_SPEED			0x0002
+#define MOD_STRONG_PU_DURATION		0x0003
+#define MOD_PULLDOWN_SLEWRATE		0x0004
+#define MOD_PROG_PULSE_DURATION		0x0005
+#define MOD_WRITE1_LOWTIME		0x0006
+#define MOD_DSOW0_TREC			0x0007
+
+/* COMMUNICATION COMMAND CODES */
+#define COMM_ERROR_ESCAPE		0x0601
+#define COMM_SET_DURATION		0x0012
+#define COMM_BIT_IO			0x0020
+#define COMM_PULSE			0x0030
+#define COMM_1_WIRE_RESET		0x0042
+#define COMM_BYTE_IO			0x0052
+#define COMM_MATCH_ACCESS		0x0064
+#define COMM_BLOCK_IO			0x0074
+#define COMM_READ_STRAIGHT		0x0080
+#define COMM_DO_RELEASE			0x6092
+#define COMM_SET_PATH			0x00A2
+#define COMM_WRITE_SRAM_PAGE		0x00B2
+#define COMM_WRITE_EPROM		0x00C4
+#define COMM_READ_CRC_PROT_PAGE		0x00D4
+#define COMM_READ_REDIRECT_PAGE_CRC	0x21E4
+#define COMM_SEARCH_ACCESS		0x00F4
+
+/* Communication command bits */
+#define COMM_TYPE			0x0008
+#define COMM_SE				0x0008
+#define COMM_D				0x0008
+#define COMM_Z				0x0008
+#define COMM_CH				0x0008
+#define COMM_SM				0x0008
+#define COMM_R				0x0008
+#define COMM_IM				0x0001
+
+#define COMM_PS				0x4000
+#define COMM_PST			0x4000
+#define COMM_CIB			0x4000
+#define COMM_RTS			0x4000
+#define COMM_DT				0x2000
+#define COMM_SPU			0x1000
+#define COMM_F				0x0800
+#define COMM_NTP			0x0400
+#define COMM_ICP			0x0200
+#define COMM_RST			0x0100
+
+#define PULSE_PROG			0x01
+#define PULSE_SPUE			0x02
+
+#define BRANCH_MAIN			0xCC
+#define BRANCH_AUX			0x33
+
+/*
+ * Duration of the strong pull-up pulse in milliseconds.
+ */
+#define PULLUP_PULSE_DURATION		750
+
+/* Status flags */
+#define ST_SPUA				0x01  /* Strong Pull-up is active */
+#define ST_PRGA				0x02  /* 12V programming pulse is being generated */
+#define ST_12VP				0x04  /* external 12V programming voltage is present */
+#define ST_PMOD				0x08  /* DS2490 powered from USB and external sources */
+#define ST_HALT				0x10  /* DS2490 is currently halted */
+#define ST_IDLE				0x20  /* DS2490 is currently idle */
+#define ST_EPOF				0x80
+
+#define SPEED_NORMAL			0x00
+#define SPEED_FLEXIBLE			0x01
+#define SPEED_OVERDRIVE			0x02
+
+#define NUM_EP				4
+#define EP_CONTROL			0
+#define EP_STATUS			1
+#define EP_DATA_OUT			2
+#define EP_DATA_IN			3
+
+struct ds_device
+{
+	struct usb_device 	*udev;
+	struct usb_interface	*intf;
+
+	int			ep[NUM_EP];
+
+	atomic_t		refcnt;
+};
+
+struct ds_status
+{
+	u8			enable;
+	u8			speed;
+	u8			pullup_dur;
+	u8			ppuls_dur;
+	u8			pulldown_slew;
+	u8			write1_time;
+	u8			write0_time;
+	u8			reserved0;
+	u8			status;
+	u8			command0;
+	u8			command1;
+	u8			command_buffer_status;
+	u8			data_out_buffer_status;
+	u8			data_in_buffer_status;
+	u8			reserved1;
+	u8			reserved2;
+
+};
+
+inline int ds_touch_bit(struct ds_device *, u8, u8 *);
+inline int ds_read_byte(struct ds_device *, u8 *);
+inline int ds_read_bit(struct ds_device *, u8 *);
+inline int ds_write_byte(struct ds_device *, u8);
+inline int ds_write_bit(struct ds_device *, u8);
+inline int ds_start_pulse(struct ds_device *, int);
+inline int ds_set_speed(struct ds_device *, int);
+inline int ds_reset(struct ds_device *, struct ds_status *);
+inline int ds_detect(struct ds_device *, struct ds_status *);
+inline int ds_stop_pulse(struct ds_device *, int);
+inline int ds_send_data(struct ds_device *, unsigned char *, int);
+inline int ds_recv_data(struct ds_device *, unsigned char *, int);
+inline int ds_recv_status(struct ds_device *, struct ds_status *);
+inline struct ds_device * ds_get_device(void);
+inline void ds_put_device(struct ds_device *);
+inline int ds_write_block(struct ds_device *, u8 *, int);
+inline int ds_read_block(struct ds_device *, u8 *, int);
+
+#endif /* __DSCORE_H */
+

