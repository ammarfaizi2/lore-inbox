Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbUAOMYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 07:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266564AbUAOMYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 07:24:10 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:23475 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265056AbUAOMUH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 07:20:07 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 15 Jan 2004 12:59:37 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l-08 add bttv IR input support.
Message-ID: <20040115115937.GA16321@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch adds linux input layer based support for infrared remote
controls.  It adds two new modules:

 * ir-kbd-i2c supports i2c-based IR receivers.
 * ir-kbd-gpio supports IR receivers connected to the bt878 gpio pins.

This patch depends on the ir-input patch and the bttv driver update.

  Gerd

diff -u linux-2.6.1/drivers/media/video/Makefile linux/drivers/media/video/Makefile
--- linux-2.6.1/drivers/media/video/Makefile	2004-01-14 15:09:36.000000000 +0100
+++ linux/drivers/media/video/Makefile	2004-01-14 15:09:36.000000000 +0100
@@ -11,7 +11,7 @@
 obj-$(CONFIG_VIDEO_DEV) += videodev.o v4l2-common.o v4l1-compat.o
 
 obj-$(CONFIG_VIDEO_BT848) += bttv.o msp3400.o tvaudio.o \
-	tda7432.o tda9875.o
+	tda7432.o tda9875.o ir-kbd-i2c.o ir-kbd-gpio.o
 obj-$(CONFIG_SOUND_TVMIXER) += tvmixer.o
 
 obj-$(CONFIG_VIDEO_ZR36120) += zoran.o
diff -u linux-2.6.1/drivers/media/video/ir-kbd-gpio.c linux/drivers/media/video/ir-kbd-gpio.c
--- linux-2.6.1/drivers/media/video/ir-kbd-gpio.c	2004-01-14 15:09:36.000000000 +0100
+++ linux/drivers/media/video/ir-kbd-gpio.c	2004-01-14 15:09:36.000000000 +0100
@@ -0,0 +1,377 @@
+/*
+ * Copyright (c) 2003 Gerd Knorr
+ * Copyright (c) 2003 Pavel Machek
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
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/pci.h>
+
+#include <media/ir-common.h>
+
+#include "bttv.h"
+
+/* ---------------------------------------------------------------------- */
+
+static IR_KEYTAB_TYPE ir_codes_avermedia[IR_KEYTAB_SIZE] = {
+	[ 17 ] = KEY_KP0, 
+	[ 20 ] = KEY_KP1, 
+	[ 12 ] = KEY_KP2, 
+	[ 28 ] = KEY_KP3, 
+	[ 18 ] = KEY_KP4, 
+	[ 10 ] = KEY_KP5, 
+	[ 26 ] = KEY_KP6, 
+	[ 22 ] = KEY_KP7, 
+	[ 14 ] = KEY_KP8, 
+	[ 30 ] = KEY_KP9, 
+
+	[ 24 ] = KEY_EJECTCD,     // Unmarked on my controller
+	[  0 ] = KEY_POWER, 
+	[  9 ] = BTN_LEFT,        // DISPLAY/L
+	[ 25 ] = BTN_RIGHT,       // LOOP/R
+	[  5 ] = KEY_MUTE, 
+	[ 19 ] = KEY_RECORD, 
+	[ 11 ] = KEY_PAUSE, 
+	[ 27 ] = KEY_STOP, 
+	[ 15 ] = KEY_VOLUMEDOWN, 
+	[ 31 ] = KEY_VOLUMEUP, 
+
+	[ 16 ] = KEY_TUNER,       // TV/FM
+	[  8 ] = KEY_CD, 
+	[  4 ] = KEY_VIDEO, 
+	[  2 ] = KEY_AUDIO, 
+	[  6 ] = KEY_ZOOM,        // full screen
+	[  1 ] = KEY_INFO,        // preview 
+	[ 21 ] = KEY_SEARCH,      // autoscan
+	[ 13 ] = KEY_STOP,        // freeze 
+	[ 29 ] = KEY_RECORD,      // capture 
+	[  3 ] = KEY_PLAY,        // unmarked
+	[ 24 ] = KEY_RED,         // unmarked
+	[  7 ] = KEY_GREEN,       // unmarked
+
+#if 0
+	[ 16 ] = KEY_YELLOW,      // unmarked
+	[  8 ] = KEY_CHANNELDOWN, 
+	[ 24 ] = KEY_CHANNELUP, 
+	[  0 ] = KEY_BLUE,        // unmarked
+#endif
+};
+
+static IR_KEYTAB_TYPE winfast_codes[IR_KEYTAB_SIZE] = {
+	[  5 ] = KEY_KP1,
+	[  6 ] = KEY_KP2,
+	[  7 ] = KEY_KP3,
+	[  9 ] = KEY_KP4,
+	[ 10 ] = KEY_KP5,
+	[ 11 ] = KEY_KP6,
+	[ 13 ] = KEY_KP7,
+	[ 14 ] = KEY_KP8,
+	[ 15 ] = KEY_KP9,
+	[ 18 ] = KEY_KP0,
+
+	[  0 ] = KEY_POWER,
+//      [ 27 ] = MTS button
+	[  2 ] = KEY_TUNER,     // TV/FM
+	[ 30 ] = KEY_VIDEO,
+//      [ 22 ] = display button
+	[  4 ] = KEY_VOLUMEUP,
+	[  8 ] = KEY_VOLUMEDOWN,
+	[ 12 ] = KEY_CHANNELUP,
+	[ 16 ] = KEY_CHANNELDOWN,
+	[  3 ] = KEY_ZOOM,      // fullscreen
+	[ 31 ] = KEY_SUBTITLE,  // closed caption/teletext
+	[ 32 ] = KEY_SLEEP,
+//      [ 41 ] = boss key
+	[ 20 ] = KEY_MUTE,
+	[ 43 ] = KEY_RED,
+	[ 44 ] = KEY_GREEN,
+	[ 45 ] = KEY_YELLOW,
+	[ 46 ] = KEY_BLUE,
+	[ 24 ] = KEY_KPPLUS,    //fine tune +
+	[ 25 ] = KEY_KPMINUS,   //fine tune -
+//      [ 42 ] = picture in picture
+        [ 33 ] = KEY_KPDOT,
+	[ 19 ] = KEY_KPENTER,
+//      [ 17 ] = recall
+	[ 34 ] = KEY_BACK,
+	[ 35 ] = KEY_PLAYPAUSE,
+	[ 36 ] = KEY_NEXT,
+//      [ 37 ] = time shifting
+	[ 38 ] = KEY_STOP,
+	[ 39 ] = KEY_RECORD
+//      [ 40 ] = snapshot
+};
+
+static IR_KEYTAB_TYPE ir_codes_pixelview[IR_KEYTAB_SIZE] = {
+	[  2 ] = KEY_KP0,
+	[  1 ] = KEY_KP1,
+	[ 11 ] = KEY_KP2,
+	[ 27 ] = KEY_KP3,
+	[  5 ] = KEY_KP4,
+	[  9 ] = KEY_KP5,
+	[ 21 ] = KEY_KP6,
+	[  6 ] = KEY_KP7,
+	[ 10 ] = KEY_KP8,
+	[ 18 ] = KEY_KP9,
+	
+	[  3 ] = KEY_TUNER,       // TV/FM
+	[  7 ] = KEY_SEARCH,      // scan
+	[ 28 ] = KEY_ZOOM,        // full screen
+	[ 30 ] = KEY_POWER,
+	[ 23 ] = KEY_VOLUMEDOWN,
+	[ 31 ] = KEY_VOLUMEUP,
+	[ 20 ] = KEY_CHANNELDOWN,
+	[ 22 ] = KEY_CHANNELUP,
+	[ 24 ] = KEY_MUTE,
+	
+	[  0 ] = KEY_LIST,        // source
+	[ 19 ] = KEY_INFO,        // loop
+	[ 16 ] = KEY_LAST,        // +100
+	[ 13 ] = KEY_CLEAR,       // reset
+	[ 12 ] = BTN_RIGHT,       // fun++
+	[  4 ] = BTN_LEFT,        // fun--
+	[ 14 ] = KEY_GOTO,        // function
+	[ 15 ] = KEY_STOP,         // freeze
+};
+
+/* ---------------------------------------------------------------------- */
+
+struct IR {
+	struct bttv_sub_device  *sub;
+	struct input_dev        input;
+	struct ir_input_state   ir;
+	char                    name[32];
+	char                    phys[32];
+	u32                     mask_keycode;
+	u32                     mask_keydown;
+	u32                     mask_keyup;
+
+	int                     polling;
+	u32                     last_gpio;
+	struct work_struct      work;
+	struct timer_list       timer;
+};
+
+static int debug = 0;    /* debug level (0,1,2) */
+MODULE_PARM(debug,"i");
+
+#define DEVNAME "ir-kbd-gpio"
+#define dprintk(fmt, arg...)	if (debug) \
+	printk(KERN_DEBUG DEVNAME ": " fmt , ## arg)
+
+static void ir_irq(struct bttv_sub_device *sub);
+static int ir_probe(struct device *dev);
+static int ir_remove(struct device *dev);
+
+static struct bttv_sub_driver driver = {
+	.drv.name	= DEVNAME,
+	.drv.probe	= ir_probe,
+	.drv.remove	= ir_remove,
+	.gpio_irq       = ir_irq,
+};
+
+/* ---------------------------------------------------------------------- */
+
+static void ir_handle_key(struct IR *ir)
+{
+	u32 gpio,data;
+
+	/* read gpio value */
+	gpio = bttv_gpio_read(ir->sub->core);
+	if (ir->polling) {
+		if (ir->last_gpio == gpio)
+			return;
+		ir->last_gpio = gpio;
+	}
+	
+	/* extract data */
+	data = ir_extract_bits(gpio, ir->mask_keycode);
+	dprintk(DEVNAME ": irq gpio=0x%x code=%d | %s%s%s\n",
+		gpio, data,
+		ir->polling               ? "poll"  : "irq",
+		(gpio & ir->mask_keydown) ? " down" : "",
+		(gpio & ir->mask_keyup)   ? " up"   : "");
+
+	if (ir->mask_keydown) {
+		/* bit set on keydown */
+		if (gpio & ir->mask_keydown) {
+			ir_input_keydown(&ir->input,&ir->ir,data,data);
+		} else {
+			ir_input_nokey(&ir->input,&ir->ir);
+		}
+
+	} else if (ir->mask_keyup) {
+		/* bit cleared on keydown */
+		if (0 == (gpio & ir->mask_keyup)) {
+			ir_input_keydown(&ir->input,&ir->ir,data,data);
+		} else {
+			ir_input_nokey(&ir->input,&ir->ir);
+		}
+
+	} else {
+		/* can't disturgissh keydown/up :-/ */
+		ir_input_keydown(&ir->input,&ir->ir,data,data);
+		ir_input_nokey(&ir->input,&ir->ir);
+	}
+}
+
+static void ir_irq(struct bttv_sub_device *sub)
+{
+	struct IR *ir = dev_get_drvdata(&sub->dev);
+
+	if (!ir->polling)
+		ir_handle_key(ir);
+}
+
+static void ir_timer(unsigned long data)
+{
+	struct IR *ir = (struct IR*)data;
+
+	schedule_work(&ir->work);
+}
+
+static void ir_work(void *data)
+{
+	struct IR *ir = data;
+	unsigned long timeout;
+
+	ir_handle_key(ir);
+	timeout = jiffies + (ir->polling * HZ / 1000);
+	mod_timer(&ir->timer, timeout);
+}
+
+/* ---------------------------------------------------------------------- */
+
+static int ir_probe(struct device *dev)
+{
+	struct bttv_sub_device *sub = to_bttv_sub_dev(dev);
+	struct IR *ir;
+	IR_KEYTAB_TYPE *ir_codes = NULL;
+	int ir_type = IR_TYPE_OTHER;
+
+	ir = kmalloc(sizeof(*ir),GFP_KERNEL);
+	if (NULL == ir)
+		return -ENOMEM;
+	memset(ir,0,sizeof(*ir));
+
+	/* detect & configure */
+	switch (sub->core->type) {
+	case BTTV_AVERMEDIA:
+	case BTTV_AVPHONE98:
+		ir_codes         = ir_codes_avermedia;
+		ir->mask_keycode = 0xf80000;
+		ir->mask_keydown = 0x010000;
+		break;
+	case BTTV_WINFAST2000:
+		ir_codes         = winfast_codes;
+		ir->mask_keycode = 0x8f8;
+		break;
+	case BTTV_PV_BT878P_9B:
+	case BTTV_PV_BT878P_PLUS:
+		ir_codes         = ir_codes_pixelview;
+		ir->mask_keycode = 0x001f00;
+		ir->mask_keyup   = 0x008000;
+		ir->polling      = 50; // ms
+                break;
+	}
+	if (NULL == ir_codes) {
+		kfree(ir);
+		return -ENODEV;
+	}
+
+	/* init hardware-specific stuff */
+	bttv_gpio_inout(sub->core, ir->mask_keycode | ir->mask_keydown, 0);
+	ir->sub = sub;
+	
+	/* init input device */
+	snprintf(ir->name, sizeof(ir->name), "bttv IR (card=%d)",
+		 sub->core->type);
+	snprintf(ir->phys, sizeof(ir->phys), "pci-%s/ir0",
+		 pci_name(sub->core->pci));
+
+	ir_input_init(&ir->input, &ir->ir, ir_type, ir_codes);
+	ir->input.name = ir->name;
+	ir->input.phys = ir->phys;
+	ir->input.id.bustype = BUS_PCI;
+	ir->input.id.version = 1;
+	if (sub->core->pci->subsystem_vendor) {
+		ir->input.id.vendor  = sub->core->pci->subsystem_vendor;
+		ir->input.id.product = sub->core->pci->subsystem_device;
+	} else {
+		ir->input.id.vendor  = sub->core->pci->vendor;
+		ir->input.id.product = sub->core->pci->device;
+	}
+
+	if (ir->polling) {
+		INIT_WORK(&ir->work, ir_work, ir);
+		init_timer(&ir->timer);
+		ir->timer.function = ir_timer;
+		ir->timer.data     = (unsigned long)ir;
+		schedule_work(&ir->work);
+	}
+
+	/* all done */
+	dev_set_drvdata(dev,ir);
+	input_register_device(&ir->input);
+	printk(DEVNAME ": %s detected at %s\n",ir->input.name,ir->input.phys);
+
+	return 0;
+}
+
+static int ir_remove(struct device *dev)
+{
+	struct IR *ir = dev_get_drvdata(dev);
+
+	if (ir->polling) {
+		del_timer(&ir->timer);
+		flush_scheduled_work();
+	}
+
+	input_unregister_device(&ir->input);
+	kfree(ir);
+	return 0;
+}
+
+/* ---------------------------------------------------------------------- */
+
+MODULE_AUTHOR("Gerd Knorr, Pavel Machek");
+MODULE_DESCRIPTION("input driver for bt8x8 gpio IR remote controls");
+MODULE_LICENSE("GPL");
+
+static int ir_init(void)
+{
+	return bttv_sub_register(&driver, "remote");
+}
+
+static void ir_fini(void)
+{
+	bttv_sub_unregister(&driver);
+}
+
+module_init(ir_init);
+module_exit(ir_fini);
+
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
diff -u linux-2.6.1/drivers/media/video/ir-kbd-i2c.c linux/drivers/media/video/ir-kbd-i2c.c
--- linux-2.6.1/drivers/media/video/ir-kbd-i2c.c	2004-01-14 15:09:36.000000000 +0100
+++ linux/drivers/media/video/ir-kbd-i2c.c	2004-01-14 15:09:36.000000000 +0100
@@ -0,0 +1,372 @@
+/*
+ * keyboard input driver for i2c IR remote controls
+ *
+ * Copyright (c) 2000-2003 Gerd Knorr <kraxel@bytesex.org>
+ * modified for PixelView (BT878P+W/FM) by
+ *      Michal Kochanowicz <mkochano@pld.org.pl>
+ *      Christoph Bartelmus <lirc@bartelmus.de>
+ * modified for KNC ONE TV Station/Anubis Typhoon TView Tuner by
+ *      Ulrich Mueller <ulrich.mueller42@web.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/workqueue.h>
+
+#include <asm/semaphore.h>
+
+#include <media/ir-common.h>
+
+struct IR;
+struct IR {
+	struct i2c_client      c;
+	struct input_dev       input;
+	struct ir_input_state  ir;
+
+	struct work_struct     work;
+	struct timer_list      timer;
+	char                   phys[32];
+	int                    (*get_key)(struct IR*, u32*, u32*);
+};
+
+/* ----------------------------------------------------------------------- */
+/* insmod parameters                                                       */
+
+static int debug = 0;    /* debug level (0,1,2) */
+MODULE_PARM(debug,"i");
+
+#define DEVNAME "ir-kbd-i2c"
+#define dprintk(level, fmt, arg...)	if (debug >= level) \
+	printk(KERN_DEBUG DEVNAME ": " fmt , ## arg)
+
+/* ----------------------------------------------------------------------- */
+
+static inline int reverse(int data, int bits)
+{
+	int i,c;
+	
+	for (c=0,i=0; i<bits; i++) {
+		c |= (((data & (1<<i)) ? 1:0)) << (bits-1-i);
+	}
+	return c;
+}
+
+static int get_key_haup(struct IR *ir, u32 *ir_key, u32 *ir_raw)
+{
+	unsigned char buf[3];
+	int start, toggle, dev, code;
+
+	/* poll IR chip */
+	if (3 != i2c_master_recv(&ir->c,buf,3))
+		return -EIO;
+
+	/* split rc5 data block ... */
+	start  = (buf[0] >> 6) &    3;
+	toggle = (buf[0] >> 5) &    1;
+	dev    =  buf[0]       & 0x1f;
+	code   = (buf[1] >> 2) & 0x3f;
+
+	if (3 != start)
+		/* no key pressed */
+		return 0;
+	dprintk(1,"ir hauppauge (rc5): s%d t%d dev=%d code=%d\n",
+		start, toggle, dev, code);
+
+	/* return key */
+	*ir_key = code;
+	*ir_raw = (start << 12) | (toggle << 11) | (dev << 6) | code;
+	return 1;
+}
+
+static int get_key_pixelview(struct IR *ir, u32 *ir_key, u32 *ir_raw)
+{
+        unsigned char b;
+	
+	/* poll IR chip */
+	if (1 != i2c_master_recv(&ir->c,&b,1)) {
+		dprintk(1,"read error\n");
+		return -EIO;
+	}
+	*ir_key = b;
+	*ir_raw = b;
+	return 1;
+}
+
+static int get_key_pv951(struct IR *ir, u32 *ir_key, u32 *ir_raw)
+{
+        unsigned char b;
+	
+	/* poll IR chip */
+	if (1 != i2c_master_recv(&ir->c,&b,1)) {
+		dprintk(1,"read error\n");
+		return -EIO;
+	}
+
+	/* ignore 0xaa */
+	if (b==0xaa)
+		return 0;
+	dprintk(2,"key %02x\n", b);
+	
+	*ir_key = b;
+	*ir_raw = b;
+	return 1;
+}
+
+static int get_key_knc1(struct IR *ir, u32 *ir_key, u32 *ir_raw)
+{
+	unsigned char b;
+	
+	/* poll IR chip */
+	if (1 != i2c_master_recv(&ir->c,&b,1)) {
+		dprintk(1,"read error\n");
+		return -EIO;
+	}
+	
+	/* it seems that 0xFE indicates that a button is still hold
+	   down, while 0xFF indicates that no button is hold
+	   down. 0xFE sequences are sometimes interrupted by 0xFF */
+	
+	dprintk(2,"key %02x\n", b);
+	
+	if (b == 0xFF)
+		return 0;
+	
+	if (b == 0xFE)
+		/* keep old data */
+		return 1;
+	
+	*ir_key = b;
+	*ir_raw = b;
+	return 1;
+}
+
+/* ----------------------------------------------------------------------- */
+
+static void ir_key_poll(struct IR *ir)
+{
+	u32 ir_key, ir_raw;
+	int rc;
+
+	dprintk(2,"ir_poll_key\n");
+	rc = ir->get_key(ir, &ir_key, &ir_raw);
+	if (rc < 0) {
+		dprintk(2,"error\n");
+		return;
+	}
+
+	if (0 == rc) {
+		ir_input_nokey(&ir->input,&ir->ir);
+	} else {
+		ir_input_keydown(&ir->input,&ir->ir, ir_key, ir_raw);
+	}
+}
+
+static void ir_timer(unsigned long data)
+{
+	struct IR *ir = (struct IR*)data;
+	schedule_work(&ir->work);
+}
+
+static void ir_work(void *data)
+{
+	struct IR *ir = data;
+	ir_key_poll(ir);
+	mod_timer(&ir->timer, jiffies+HZ/10);
+}
+
+/* ----------------------------------------------------------------------- */
+
+static int ir_attach(struct i2c_adapter *adap, int addr,
+		      unsigned short flags, int kind);
+static int ir_detach(struct i2c_client *client);
+static int ir_probe(struct i2c_adapter *adap);
+
+static struct i2c_driver driver = {
+        .name           = "ir remote kbd driver",
+        .id             = I2C_DRIVERID_EXP3, /* FIXME */
+        .flags          = I2C_DF_NOTIFY,
+        .attach_adapter = ir_probe,
+        .detach_client  = ir_detach,
+};
+
+static struct i2c_client client_template = 
+{
+        I2C_DEVNAME("unset"),
+        .driver = &driver
+};
+
+static int ir_attach(struct i2c_adapter *adap, int addr,
+		     unsigned short flags, int kind)
+{
+	IR_KEYTAB_TYPE *ir_codes = NULL;
+	char *name;
+	int ir_type;
+        struct IR *ir;
+		
+        if (NULL == (ir = kmalloc(sizeof(struct IR),GFP_KERNEL)))
+                return -ENOMEM;
+	memset(ir,0,sizeof(*ir));
+	ir->c = client_template;
+
+	i2c_set_clientdata(&ir->c, ir);
+	ir->c.adapter = adap;
+	ir->c.addr    = addr;
+
+	switch(addr) {
+	case 0x64:
+		name        = "Pixelview";
+		ir->get_key = get_key_pixelview;
+		ir_type     = IR_TYPE_OTHER;
+		ir_codes    = ir_codes_empty;
+		break;
+	case 0x4b:
+		name        = "PV951";
+		ir->get_key = get_key_pv951;
+		ir_type     = IR_TYPE_OTHER;
+		ir_codes    = ir_codes_empty;
+		break;
+	case 0x18:
+	case 0x1a:
+		name        = "Hauppauge";
+		ir->get_key = get_key_haup;
+		ir_type     = IR_TYPE_RC5;
+		ir_codes    = ir_codes_rc5_tv;
+		break;
+	case 0x30:
+		name        = "KNC One";
+		ir->get_key = get_key_knc1;
+		ir_type     = IR_TYPE_OTHER;
+		ir_codes    = ir_codes_empty;
+		break;
+	default:
+		/* shouldn't happen */
+		printk(DEVNAME ": Huh? unknown i2c address (0x%02x)?\n",addr);
+		kfree(ir);
+		return -1;
+	}
+
+	/* register i2c device */
+	i2c_attach_client(&ir->c);
+	snprintf(ir->c.name, sizeof(ir->c.name), "i2c IR (%s)", name);
+	snprintf(ir->phys, sizeof(ir->phys), "%s/%s/ir0",
+		 ir->c.adapter->dev.bus_id,
+		 ir->c.dev.bus_id);
+
+	/* init + register input device */
+	ir_input_init(&ir->input,&ir->ir,ir_type,ir_codes);
+	ir->input.id.bustype = BUS_I2C;
+	ir->input.name       = ir->c.name;
+	ir->input.phys       = ir->phys;
+	input_register_device(&ir->input);
+	printk(DEVNAME ": %s detected at %s\n",ir->input.name,ir->input.phys);
+	       
+	/* start polling via eventd */
+	INIT_WORK(&ir->work, ir_work, ir);
+	init_timer(&ir->timer);
+	ir->timer.function = ir_timer;
+	ir->timer.data     = (unsigned long)ir;
+	schedule_work(&ir->work);
+	
+	return 0;
+}
+
+static int ir_detach(struct i2c_client *client)
+{
+        struct IR *ir = i2c_get_clientdata(client);
+
+	/* kill outstanding polls */
+	del_timer(&ir->timer);
+	flush_scheduled_work();
+
+	/* unregister devices */
+	input_unregister_device(&ir->input);
+	i2c_detach_client(&ir->c);
+
+	/* free memory */
+	kfree(ir);
+	return 0;
+}
+
+static int ir_probe(struct i2c_adapter *adap)
+{
+	
+	/* The external IR receiver is at i2c address 0x34 (0x35 for
+	   reads).  Future Hauppauge cards will have an internal
+	   receiver at 0x30 (0x31 for reads).  In theory, both can be
+	   fitted, and Hauppauge suggest an external overrides an
+	   internal. 
+	   
+	   That's why we probe 0x1a (~0x34) first. CB 
+	*/
+	
+	static const int probe[] = { 0x1a, 0x18, 0x4b, 0x64, 0x30, -1};
+	struct i2c_client c; char buf; int i,rc;
+
+	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848)) {
+		memset(&c,0,sizeof(c));
+		c.adapter = adap;
+		for (i = 0; -1 != probe[i]; i++) {
+			c.addr = probe[i];
+			rc = i2c_master_recv(&c,&buf,1);
+			dprintk(1,"probe 0x%02x @ %s: %s\n",
+				probe[i], adap->name, 
+				(1 == rc) ? "yes" : "no");
+			if (1 == rc) {
+				ir_attach(adap,probe[i],0,0);
+				break;
+			}
+		}
+	}
+	return 0;
+}
+
+/* ----------------------------------------------------------------------- */
+
+MODULE_AUTHOR("Gerd Knorr, Michal Kochanowicz, Christoph Bartelmus, Ulrich Mueller");
+MODULE_DESCRIPTION("input driver for i2c IR remote controls");
+MODULE_LICENSE("GPL");
+
+static int ir_init(void)
+{
+	i2c_add_driver(&driver);
+	return 0;
+}
+
+static void ir_fini(void)
+{
+	i2c_del_driver(&driver);
+}
+
+module_init(ir_init);
+module_exit(ir_fini);
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */

-- 
You have a new virus in /var/mail/kraxel
