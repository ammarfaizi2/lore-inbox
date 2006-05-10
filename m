Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWEJVzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWEJVzb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWEJVzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:55:31 -0400
Received: from [67.104.119.229] ([67.104.119.229]:51212 "EHLO ssai.us")
	by vger.kernel.org with ESMTP id S1751165AbWEJVza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:55:30 -0400
Message-ID: <44626150.9050804@ssai.us>
Date: Wed, 10 May 2006 14:55:28 -0700
From: Scott Alfter <salfter@ssai.us>
User-Agent: Mail/News 1.5 (X11/20060324)
MIME-Version: 1.0
To: v4l-dvb-maintainer@linuxtv.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] new driver for TLV320AIC23B
Content-Type: multipart/mixed;
 boundary="------------080302020404060102000703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080302020404060102000703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Signed-off-by: Scott Alfter <salfter@ssai.us>

It took a little bit longer than I thought, but the attached patch adds a
driver for the TI TLV320AIC23B audio codec.  It implements analog audio capture
at 32, 44.1, and 48 kHz (16-bit stereo).  The hardware is capable of more (it
supports more sample rates and includes analog output), but in its current
form, the driver works well with ivtv.

The patch is attached; a test mailing indicated that Thunderbird attaches
patches inline instead of encoded.  The patch is also available from this URL:

http://alfter.us/files/linux-2.6.16-tlv320aic23b.patch

Scott Alfter
salfter@ssai.us



--------------080302020404060102000703
Content-Type: text/plain;
 name="linux-2.6.16-tlv320aic23b.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.16-tlv320aic23b.patch"

diff -Nupr -X dontdiff linux-2.6.16-gentoo-r1/drivers/media/video/Makefile linux-2.6.16-gentoo-r1/drivers/media/video/Makefile
--- linux-2.6.16-gentoo-r1/drivers/media/video/Makefile	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16-gentoo-r1/drivers/media/video/Makefile	2006-04-25 15:37:58.000000000 -0700
@@ -45,7 +45,7 @@ obj-$(CONFIG_VIDEO_SAA7134) += ir-kbd-i2
 obj-$(CONFIG_VIDEO_CX88) += cx88/
 obj-$(CONFIG_VIDEO_EM28XX) += em28xx/
 obj-$(CONFIG_VIDEO_EM28XX) += saa711x.o tvp5150.o
-obj-$(CONFIG_VIDEO_AUDIO_DECODER) += wm8775.o cs53l32a.o
+obj-$(CONFIG_VIDEO_AUDIO_DECODER) += wm8775.o cs53l32a.o tlv320aic23b.o
 obj-$(CONFIG_VIDEO_OVCAMCHIP) += ovcamchip/
 obj-$(CONFIG_VIDEO_MXB) += saa7111.o tuner.o tda9840.o tea6415c.o tea6420.o mxb.o
 obj-$(CONFIG_VIDEO_HEXIUM_ORION) += hexium_orion.o
diff -Nupr -X dontdiff linux-2.6.16-gentoo-r1/drivers/media/video/tlv320aic23b.c linux-2.6.16-gentoo-r1/drivers/media/video/tlv320aic23b.c
--- linux-2.6.16-gentoo-r1/drivers/media/video/tlv320aic23b.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-gentoo-r1/drivers/media/video/tlv320aic23b.c	2006-05-09 17:19:00.000000000 -0700
@@ -0,0 +1,248 @@
+/*
+ * tlv320aic23b - driver version 0.0.1
+ *
+ * Copyright (C) 2006 Scott Alfter <salfter@ssai.us>
+ *
+ * Based on wm8775 driver
+ *
+ * Copyright (C) 2004 Ulf Eklund <ivtv at eklund.to>
+ * Copyright (C) 2005 Hans Verkuil <hverkuil@xs4all.nl>
+ * - Cleanup
+ * - V4L2 API update
+ * - sound fixes
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
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/ioctl.h>
+#include <asm/uaccess.h>
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <linux/videodev.h>
+#include <media/v4l2-common.h>
+
+MODULE_DESCRIPTION("tlv320aic23b driver");
+MODULE_AUTHOR("Scott Alfter, Ulf Eklund, Hans Verkuil");
+MODULE_LICENSE("GPL");
+
+static unsigned short normal_i2c[] = { 0x34 >> 1, I2C_CLIENT_END };
+
+
+I2C_CLIENT_INSMOD;
+
+/* ----------------------------------------------------------------------- */
+
+enum {
+	R7 = 7, R11 = 11,
+	R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R23 = 23,
+	TOT_REGS
+};
+
+struct tlv320aic23b_state {
+	u8 input;		/* Last selected input (0-0xf) */
+	u8 muted;
+};
+
+static int tlv320aic23b_write(struct i2c_client *client, int reg, u16 val)
+{
+	int i;
+
+	if ((reg < 0 || reg >9)&&(reg!=15)) {
+		v4l_err(client, "Invalid register R%d\n", reg);
+		return -1;
+	}
+
+	for (i = 0; i < 3; i++) {
+		if (i2c_smbus_write_byte_data(client, (reg << 1) |
+					(val >> 8), val & 0xff) == 0) {
+			return 0;
+		}
+	}
+	v4l_err(client, "I2C: cannot write %03x to register R%d\n", val, reg);
+	return -1;
+}
+
+static int tlv320aic23b_command(struct i2c_client *client, unsigned int cmd,
+			  void *arg)
+{
+	struct tlv320aic23b_state *state = i2c_get_clientdata(client);
+	struct v4l2_audio *input = arg;
+	struct v4l2_control *ctrl = arg;
+	u32* freq=arg;
+
+	switch (cmd) {
+	case VIDIOC_INT_AUDIO_CLOCK_FREQ:
+		// TODO: set sample rate according to arg, which is an unsigned int
+		// with the sample rate: 32000, 44100, or 48000 Hz
+		switch (*freq)
+		{
+			case 32000:
+				tlv320aic23b_write(client, 8, 0x018); /* set sample rate to 32 kHz */
+				break;
+			case 44100:
+				tlv320aic23b_write(client, 8, 0x022); /* set sample rate to 44.1 kHz */
+				break;
+			case 48000:
+				tlv320aic23b_write(client, 8, 0x000); /* set sample rate to 48 kHz */
+				break;
+		}
+		break;
+	case VIDIOC_S_AUDIO:
+		
+		/* With only one line-level input, the input value can be ignored */
+		if (state->muted)
+			break;
+		tlv320aic23b_write(client, 0, 0x119); // set gain on both channels to +3.0 dB
+		break;
+
+	case VIDIOC_G_AUDIO:
+		break;
+
+	case VIDIOC_G_CTRL:
+		if (ctrl->id != V4L2_CID_AUDIO_MUTE)
+			return -EINVAL;
+		ctrl->value = state->muted;
+		break;
+
+	case VIDIOC_S_CTRL:
+		if (ctrl->id != V4L2_CID_AUDIO_MUTE)
+			return -EINVAL;
+		state->muted = ctrl->value;
+		tlv320aic23b_write(client, 0, 0x180); // mute both channels
+		if (!state->muted)
+			tlv320aic23b_write(client, 0, 0x119); // set gain on both channels to +3.0 dB
+		break;
+
+	case VIDIOC_LOG_STATUS:
+		v4l_info(client, "Input: %d%s\n", state->input,
+			    state->muted ? " (muted)" : "");
+		break;
+
+	case VIDIOC_S_FREQUENCY:
+		/* If I remove this, then it can happen that I have no
+		   sound the first time I tune from static to a valid channel.
+		   It's difficult to reproduce and is almost certainly related
+		   to the zero cross detect circuit. */
+		/* original looks like a dupe of VIDIOC_S_AUDIO */
+		tlv320aic23b_write(client, 0, 0x119); // set gain on both channels to +3.0 dB
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/* ----------------------------------------------------------------------- */
+
+/* i2c implementation */
+
+/*
+ * Generic i2c probe
+ * concerning the addresses: i2c wants 7 bit (without the r/w bit), so '>>1'
+ */
+
+static struct i2c_driver i2c_driver;
+
+static int tlv320aic23b_attach(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *client;
+	struct tlv320aic23b_state *state;
+
+	/* Check if the adapter supports the needed features */
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return 0;
+
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	if (client == 0)
+		return -ENOMEM;
+
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &i2c_driver;
+	snprintf(client->name, sizeof(client->name) - 1, "tlv320aic23b");
+
+	v4l_info(client, "chip found @ 0x%x (%s)\n", address << 1, adapter->name);
+
+	state = kmalloc(sizeof(struct tlv320aic23b_state), GFP_KERNEL);
+	if (state == NULL) {
+		kfree(client);
+		return -ENOMEM;
+	}
+	state->input = 2;
+	state->muted = 0;
+	i2c_set_clientdata(client, state);
+
+	/* initialize tlv320aic23b */
+	tlv320aic23b_write(client, 15, 0x000);	/* RESET */
+	tlv320aic23b_write(client, 6, 0x00A); /* turn off DAC & mic input */
+	tlv320aic23b_write(client, 7, 0x049); /* left-justified, 24-bit, master mode */
+	tlv320aic23b_write(client, 0, 0x119); /* set gain on both channels to +3.0 dB */
+	tlv320aic23b_write(client, 8, 0x000); /* set sample rate to 48 kHz */
+	tlv320aic23b_write(client, 9, 0x001); /* activate digital interface */
+	
+	i2c_attach_client(client);
+
+	return 0;
+}
+
+static int tlv320aic23b_probe(struct i2c_adapter *adapter)
+{
+	if (adapter->class & I2C_CLASS_TV_ANALOG)
+		return i2c_probe(adapter, &addr_data, tlv320aic23b_attach);
+	return 0;
+}
+
+static int tlv320aic23b_detach(struct i2c_client *client)
+{
+	int err;
+
+	err = i2c_detach_client(client);
+	if (err) {
+		return err;
+	}
+	kfree(client);
+
+	return 0;
+}
+
+/* ----------------------------------------------------------------------- */
+
+/* i2c implementation */
+static struct i2c_driver i2c_driver = {
+	.driver = {
+		.name = "tlv320aic23b",
+	},
+	.id             = I2C_DRIVERID_TLV320AIC23B,
+	.attach_adapter = tlv320aic23b_probe,
+	.detach_client  = tlv320aic23b_detach,
+	.command        = tlv320aic23b_command,
+};
+
+
+static int __init tlv320aic23b_init_module(void)
+{
+	return i2c_add_driver(&i2c_driver);
+}
+
+static void __exit tlv320aic23b_cleanup_module(void)
+{
+	i2c_del_driver(&i2c_driver);
+}
+
+module_init(tlv320aic23b_init_module);
+module_exit(tlv320aic23b_cleanup_module);
diff -Nupr -X dontdiff linux-2.6.16-gentoo-r1/drivers/media/video/tlv320aic23b.mod.c linux-2.6.16-gentoo-r1/drivers/media/video/tlv320aic23b.mod.c
--- linux-2.6.16-gentoo-r1/drivers/media/video/tlv320aic23b.mod.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-gentoo-r1/drivers/media/video/tlv320aic23b.mod.c	2006-05-08 17:41:44.000000000 -0700
@@ -0,0 +1,44 @@
+#include <linux/module.h>
+#include <linux/vermagic.h>
+#include <linux/compiler.h>
+
+MODULE_INFO(vermagic, VERMAGIC_STRING);
+
+struct module __this_module
+__attribute__((section(".gnu.linkonce.this_module"))) = {
+ .name = KBUILD_MODNAME,
+ .init = init_module,
+#ifdef CONFIG_MODULE_UNLOAD
+ .exit = cleanup_module,
+#endif
+};
+
+static const struct modversion_info ____versions[]
+__attribute_used__
+__attribute__((section("__versions"))) = {
+	{ 0x799c1ddd, "struct_module" },
+	{ 0x2583286b, "i2c_del_driver" },
+	{ 0x181d00ce, "i2c_register_driver" },
+	{ 0xb4e757c0, "i2c_detach_client" },
+	{ 0x81713cdd, "i2c_probe" },
+	{ 0x2a6031cb, "i2c_attach_client" },
+	{ 0x37a0cba, "kfree" },
+	{ 0x16f2559e, "kmem_cache_alloc" },
+	{ 0xb76ba150, "malloc_sizes" },
+	{ 0xaf25400d, "snprintf" },
+	{ 0x5a3b6eca, "kzalloc" },
+	{ 0x9ddcce27, "i2c_smbus_write_byte_data" },
+	{ 0xdd132261, "printk" },
+	{ 0x6483655c, "param_get_short" },
+	{ 0x40046949, "param_set_short" },
+	{ 0x806d5133, "param_array_get" },
+	{ 0x89cef6fb, "param_array_set" },
+};
+
+static const char __module_depends[]
+__attribute_used__
+__attribute__((section(".modinfo"))) =
+"depends=i2c-core";
+
+
+MODULE_INFO(srcversion, "519388420026FA82AF6CAD0");


--------------080302020404060102000703--
