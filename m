Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267718AbTGOM2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267647AbTGOM1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:27:39 -0400
Received: from mail.convergence.de ([212.84.236.4]:37792 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267533AbTGOMGL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:06:11 -0400
Subject: [PATCH 12/17] Add two drivers for Hexium frame grabber cards
In-Reply-To: <10582716573394@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 15 Jul 2003 14:20:57 +0200
Message-Id: <10582716571753@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[V4L] - add drivers for the Orion and Gemini frame grabber cards, based on the saa7146. For details, see http://www.hexium.hu/. Thanks to Michael Hunold <michael@mihu.de>.
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/video/Kconfig linux-2.6.0-test1.patch/drivers/media/video/Kconfig
--- linux-2.6.0-test1.work/drivers/media/video/Kconfig	2003-07-15 09:42:37.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/video/Kconfig	2003-06-25 11:02:24.000000000 +0200
@@ -257,5 +257,30 @@
 	  whenever you want). If you want to compile it as a module, say M
 	  here and read <file:Documentation/modules.txt>.
 
+config VIDEO_HEXIUM_ORION
+	tristate "Hexium HV-PCI6 and Orion frame grabber"
+	depends on VIDEO_DEV && PCI
+	---help---
+	  This is a video4linux driver for the Hexium HV-PCI6 and
+	  Orion frame grabber cards by Hexium.
+	  
+	  This driver is available as a module called hexium_orion
+	  ( = code which can be inserted in and removed from the
+	  running kernel whenever you want). If you want to compile
+	  it as a module, say M here and read <file:Documentation/modules.txt>.
+
+config VIDEO_HEXIUM_GEMINI
+	tristate "Hexium Gemini frame grabber"
+	depends on VIDEO_DEV && PCI
+	---help---
+	  This is a video4linux driver for the Hexium Gemini frame
+	  grabber card by Hexium. Please note that the Gemini Dual
+	  card is *not* fully supported.
+	  
+	  This driver is available as a module called hexium_gemini
+	  ( = code which can be inserted in and removed from the
+	  running kernel whenever you want). If you want to compile
+	  it as a module, say M here and read <file:Documentation/modules.txt>.
+
 endmenu
 
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/video/Makefile linux-2.6.0-test1.patch/drivers/media/video/Makefile
--- linux-2.6.0-test1.work/drivers/media/video/Makefile	2003-07-15 09:42:37.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/video/Makefile	2003-05-20 09:37:41.000000000 +0200
@@ -31,6 +31,8 @@
 obj-$(CONFIG_VIDEO_MEYE) += meye.o
 obj-$(CONFIG_VIDEO_SAA7134) += saa7134/
 obj-$(CONFIG_VIDEO_MXB) += saa7111.o tuner.o tda9840.o tea6415c.o tea6420.o mxb.o
+obj-$(CONFIG_VIDEO_HEXIUM_ORION) += hexium_orion.o
+obj-$(CONFIG_VIDEO_HEXIUM_GEMINI) += hexium_gemini.o
 obj-$(CONFIG_VIDEO_DPC) += saa7111.o dpc7146.o
 obj-$(CONFIG_TUNER_3036) += tuner-3036.o
 
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/video/hexium.h linux-2.6.0-test1.patch/drivers/media/video/hexium.h
--- linux-2.6.0-test1.work/drivers/media/video/hexium.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/video/hexium.h	2003-07-15 10:00:55.000000000 +0200
@@ -0,0 +1,51 @@
+#ifndef __HEXIUM__
+#define __HEXIUM__
+
+#define HEXIUM_HV_PCI6_ORION		1
+#define HEXIUM_ORION_1SVHS_3BNC		2
+#define HEXIUM_ORION_4BNC		3
+#define HEXIUM_GEMUINI			4
+#define HEXIUM_GEMUINI_DUAL		5
+
+static struct saa7146_standard hexium_standards[] = {
+	{
+		.name	= "PAL", 	.id	= V4L2_STD_PAL,
+		.v_offset	= 0x17,	.v_field 	= 288,	.v_calc		= 576,
+		.h_offset	= 0x14,	.h_pixels 	= 680,	.h_calc		= 680+1,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}, {
+		.name	= "NTSC", 	.id	= V4L2_STD_NTSC,
+		.v_offset	= 0x17,	.v_field 	= 240,	.v_calc		= 480,
+		.h_offset	= 0x06,	.h_pixels 	= 640,	.h_calc		= 641+1,
+		.v_max_out	= 480,	.h_max_out	= 640,
+	}, {
+		.name	= "SECAM", 	.id	= V4L2_STD_SECAM,
+		.v_offset	= 0x14,	.v_field 	= 288,	.v_calc		= 576,
+		.h_offset	= 0x14,	.h_pixels 	= 720,	.h_calc		= 720+1,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}
+};		
+
+
+#define HEXIUM_INPUTS	9
+static struct v4l2_input hexium_inputs[HEXIUM_INPUTS] = {
+	{ 0, "CVBS 1",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 1, "CVBS 2",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 2, "CVBS 3",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 3, "CVBS 4",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 4, "CVBS 5",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 5, "CVBS 6",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 6, "Y/C 1",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 7, "Y/C 2",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{ 8, "Y/C 3",	V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+};
+
+#define HEXIUM_AUDIOS	0
+
+struct hexium_data
+{
+	s8 adr;
+	u8 byte;
+};
+
+#endif
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/video/hexium_gemini.c linux-2.6.0-test1.patch/drivers/media/video/hexium_gemini.c
--- linux-2.6.0-test1.work/drivers/media/video/hexium_gemini.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/video/hexium_gemini.c	2003-07-15 10:05:56.000000000 +0200
@@ -0,0 +1,411 @@
+/*
+    hexium_gemini.c - v4l2 driver for Hexium Gemini frame grabber cards
+               
+    Visit http://www.mihu.de/linux/saa7146/ and follow the link
+    to "hexium" for further details about this card.
+    
+    Copyright (C) 2003 Michael Hunold <michael@mihu.de>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#define DEBUG_VARIABLE debug
+
+#include <media/saa7146_vv.h>
+
+static int debug = 255;
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "debug verbosity");
+
+/* global variables */
+int hexium_num = 0;
+
+#include "hexium_gemini.h"
+
+/* bring hardware to a sane state. this has to be done, just in case someone
+   wants to capture from this device before it has been properly initialized.
+   the capture engine would badly fail, because no valid signal arrives on the
+   saa7146, thus leading to timeouts and stuff. */
+static int hexium_init_done(struct saa7146_dev *dev)
+{
+	struct hexium *hexium = (struct hexium *) dev->ext_priv;
+	union i2c_smbus_data data;
+	int i = 0;
+
+	DEB_D(("hexium_init_done called.\n"));
+
+	/* initialize the helper ics to useful values */
+	for (i = 0; i < sizeof(hexium_ks0127b); i++) {
+		data.byte = hexium_ks0127b[i];
+		if (0 != i2c_smbus_xfer(&hexium->i2c_adapter, 0x6c, 0, I2C_SMBUS_WRITE, i, I2C_SMBUS_BYTE_DATA, &data)) {
+			printk("failed for address 0x%02x\n", i);
+		}
+	}
+
+	return 0;
+}
+
+static int hexium_set_input(struct hexium *hexium, int input)
+{
+	union i2c_smbus_data data;
+
+	DEB_D((".\n"));
+
+	data.byte = hexium_input_select[input].byte;
+	if (0 != i2c_smbus_xfer(&hexium->i2c_adapter, 0x6c, 0, I2C_SMBUS_WRITE, hexium_input_select[input].adr, I2C_SMBUS_BYTE_DATA, &data)) {
+		return -1;
+	}
+
+	return 0;
+}
+
+static int hexium_set_standard(struct hexium *hexium, struct hexium_data *vdec)
+{
+	union i2c_smbus_data data;
+	int i = 0;
+
+	DEB_D((".\n"));
+
+	while (vdec[i].adr != -1) {
+		data.byte = vdec[i].byte;
+		if (0 != i2c_smbus_xfer(&hexium->i2c_adapter, 0x6c, 0, I2C_SMBUS_WRITE, vdec[i].adr, I2C_SMBUS_BYTE_DATA, &data)) {
+			printk("failed for address 0x%02x\n", i);
+			return -1;
+		}
+		i++;
+	}
+	return 0;
+}
+
+static struct saa7146_ext_vv vv_data;
+
+/* this function only gets called when the probing was successful */
+static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_data *info)
+{
+	struct hexium *hexium = (struct hexium *) dev->ext_priv;
+
+	DEB_EE((".\n"));
+
+	hexium = (struct hexium *) kmalloc(sizeof(struct hexium), GFP_KERNEL);
+	if (NULL == hexium) {
+		printk("hexium_v4l2.o: hexium_probe: not enough kernel memory.\n");
+		return -ENOMEM;
+	}
+	memset(hexium, 0x0, sizeof(struct hexium));
+	(struct hexium *) dev->ext_priv = hexium;
+
+	/* FIXME: enable i2c-port pins, video-port-pins
+	   video port pins should be enabled here ?! */
+	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
+
+	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, SAA7146_I2C_BUS_BIT_RATE_480);
+	if (i2c_add_adapter(&hexium->i2c_adapter) < 0) {
+		DEB_S(("cannot register i2c-device. skipping.\n"));
+		kfree(hexium);
+		return -EFAULT;
+	}
+
+	/*  set HWControl GPIO number 2 */
+	saa7146_setgpio(dev, 2, SAA7146_GPIO_OUTHI);
+
+	saa7146_write(dev, DD1_INIT, 0x07000700);
+	saa7146_write(dev, DD1_STREAM_B, 0x00000000);
+	saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
+
+	/* the rest */
+	hexium->cur_input = 0;
+	hexium_init_done(dev);
+
+	hexium_set_standard(hexium, hexium_pal);
+	hexium->cur_std = V4L2_STD_PAL;
+
+	hexium_set_input(hexium, 0);
+	hexium->cur_input = 0;
+
+	saa7146_vv_init(dev, &vv_data);
+	if (0 != saa7146_register_device(&hexium->video_dev, dev, "hexium", VFL_TYPE_GRABBER)) {
+		ERR(("cannot register capture v4l2 device. skipping.\n"));
+		return -1;
+	}
+
+	printk("hexium: found 'hexium frame grabber'-%d.\n", hexium_num);
+	hexium_num++;
+
+	return 0;
+}
+
+static int hexium_detach(struct saa7146_dev *dev)
+{
+	struct hexium *hexium = (struct hexium *) dev->ext_priv;
+
+	DEB_EE(("dev:%p\n", dev));
+
+	saa7146_unregister_device(&hexium->video_dev, dev);
+	saa7146_vv_release(dev);
+
+	hexium_num--;
+
+	i2c_del_adapter(&hexium->i2c_adapter);
+	kfree(hexium);
+	return 0;
+}
+
+static int hexium_ioctl(struct saa7146_fh *fh, unsigned int cmd, void *arg)
+{
+	struct saa7146_dev *dev = fh->dev;
+	struct hexium *hexium = (struct hexium *) dev->ext_priv;
+/*
+	struct saa7146_vv *vv = dev->vv_data; 
+*/
+	switch (cmd) {
+	case VIDIOC_ENUMINPUT:
+		{
+			struct v4l2_input *i = arg;
+			DEB_EE(("VIDIOC_ENUMINPUT %d.\n", i->index));
+
+			if (i->index < 0 || i->index >= HEXIUM_INPUTS) {
+				return -EINVAL;
+			}
+
+			memcpy(i, &hexium_inputs[i->index], sizeof(struct v4l2_input));
+
+			DEB_D(("v4l2_ioctl: VIDIOC_ENUMINPUT %d.\n", i->index));
+			return 0;
+		}
+	case VIDIOC_G_INPUT:
+		{
+			int *input = (int *) arg;
+			*input = hexium->cur_input;
+
+			DEB_D(("VIDIOC_G_INPUT: %d\n", *input));
+			return 0;
+		}
+	case VIDIOC_S_INPUT:
+		{
+			int input = *(int *) arg;
+
+			DEB_EE(("VIDIOC_S_INPUT %d.\n", input));
+
+			if (input < 0 || input >= HEXIUM_INPUTS) {
+				return -EINVAL;
+			}
+
+			hexium->cur_input = input;
+			hexium_set_input(hexium, input);
+
+			return 0;
+		}
+		/* the saa7146 provides some controls (brightness, contrast, saturation)
+		   which gets registered *after* this function. because of this we have
+		   to return with a value != 0 even if the function succeded.. */
+	case VIDIOC_QUERYCTRL:
+		{
+			struct v4l2_queryctrl *qc = arg;
+			int i;
+
+			for (i = HEXIUM_CONTROLS - 1; i >= 0; i--) {
+				if (hexium_controls[i].id == qc->id) {
+					*qc = hexium_controls[i];
+					DEB_D(("VIDIOC_QUERYCTRL %d.\n", qc->id));
+					return 0;
+				}
+			}
+			return -EAGAIN;
+		}
+	case VIDIOC_G_CTRL:
+		{
+			struct v4l2_control *vc = arg;
+			int i;
+
+			for (i = HEXIUM_CONTROLS - 1; i >= 0; i--) {
+				if (hexium_controls[i].id == vc->id) {
+					break;
+				}
+			}
+
+			if (i < 0) {
+				return -EAGAIN;
+			}
+
+			switch (vc->id) {
+			case V4L2_CID_PRIVATE_BASE:{
+					vc->value = hexium->cur_bw;
+					DEB_D(("VIDIOC_G_CTRL BW:%d.\n", vc->value));
+					return 0;
+				}
+			}
+			return -EINVAL;
+		}
+
+	case VIDIOC_S_CTRL:
+		{
+			struct v4l2_control *vc = arg;
+			int i = 0;
+
+			for (i = HEXIUM_CONTROLS - 1; i >= 0; i--) {
+				if (hexium_controls[i].id == vc->id) {
+					break;
+				}
+			}
+
+			if (i < 0) {
+				return -EAGAIN;
+			}
+
+			switch (vc->id) {
+			case V4L2_CID_PRIVATE_BASE:{
+					hexium->cur_bw = vc->value;
+					break;
+				}
+			}
+
+			DEB_D(("VIDIOC_S_CTRL BW:%d.\n", hexium->cur_bw));
+
+			if (0 == hexium->cur_bw && V4L2_STD_PAL == hexium->cur_std) {
+				hexium_set_standard(hexium, hexium_pal);
+				return 0;
+			}
+			if (0 == hexium->cur_bw && V4L2_STD_NTSC == hexium->cur_std) {
+				hexium_set_standard(hexium, hexium_ntsc);
+				return 0;
+			}
+			if (0 == hexium->cur_bw && V4L2_STD_SECAM == hexium->cur_std) {
+				hexium_set_standard(hexium, hexium_secam);
+				return 0;
+			}
+			if (1 == hexium->cur_bw && V4L2_STD_PAL == hexium->cur_std) {
+				hexium_set_standard(hexium, hexium_pal_bw);
+				return 0;
+			}
+			if (1 == hexium->cur_bw && V4L2_STD_NTSC == hexium->cur_std) {
+				hexium_set_standard(hexium, hexium_ntsc_bw);
+				return 0;
+			}
+			if (1 == hexium->cur_bw && V4L2_STD_SECAM == hexium->cur_std) {
+				/* fixme: is there no bw secam mode? */
+				return -EINVAL;
+			}
+
+			return -EINVAL;
+		}
+	default:
+/*
+		DEB_D(("v4l2_ioctl does not handle this ioctl.\n"));
+*/
+		return -ENOIOCTLCMD;
+	}
+	return 0;
+}
+
+static int std_callback(struct saa7146_dev *dev, struct saa7146_standard *std)
+{
+	struct hexium *hexium = (struct hexium *) dev->ext_priv;
+
+	if (V4L2_STD_PAL == std->id) {
+		hexium_set_standard(hexium, hexium_pal);
+		hexium->cur_std = V4L2_STD_PAL;
+		return 0;
+	} else if (V4L2_STD_NTSC == std->id) {
+		hexium_set_standard(hexium, hexium_ntsc);
+		hexium->cur_std = V4L2_STD_NTSC;
+		return 0;
+	} else if (V4L2_STD_SECAM == std->id) {
+		hexium_set_standard(hexium, hexium_secam);
+		hexium->cur_std = V4L2_STD_SECAM;
+		return 0;
+	}
+
+	return -1;
+}
+
+static struct saa7146_extension hexium_extension;
+
+static struct saa7146_pci_extension_data hexium_gemini_4bnc = {
+	.ext_priv = "Hexium Gemini (4 BNC)",
+	.ext = &hexium_extension,
+};
+
+static struct saa7146_pci_extension_data hexium_gemini_dual_4bnc = {
+	.ext_priv = "Hexium Gemini Dual (4 BNC)",
+	.ext = &hexium_extension,
+};
+
+static struct pci_device_id pci_tbl[] = {
+	{
+	 .vendor = PCI_VENDOR_ID_PHILIPS,
+	 .device = PCI_DEVICE_ID_PHILIPS_SAA7146,
+	 .subvendor = 0x17c8,
+	 .subdevice = 0x2401,
+	 .driver_data = (unsigned long) &hexium_gemini_4bnc,
+	 },
+	{
+	 .vendor = PCI_VENDOR_ID_PHILIPS,
+	 .device = PCI_DEVICE_ID_PHILIPS_SAA7146,
+	 .subvendor = 0x17c8,
+	 .subdevice = 0x2402,
+	 .driver_data = (unsigned long) &hexium_gemini_dual_4bnc,
+	 },
+	{
+	 .vendor = 0,
+	 }
+};
+
+MODULE_DEVICE_TABLE(pci, pci_tbl);
+
+static struct saa7146_ext_vv vv_data = {
+	.inputs = HEXIUM_INPUTS,
+	.capabilities = 0,
+	.stds = &hexium_standards[0],
+	.num_stds = sizeof(hexium_standards) / sizeof(struct saa7146_standard),
+	.std_callback = &std_callback,
+	.ioctls = &ioctls[0],
+	.ioctl = hexium_ioctl,
+};
+
+static struct saa7146_extension hexium_extension = {
+	.name = "hexium gemini",
+	.flags = SAA7146_USE_I2C_IRQ,
+
+	.pci_tbl = &pci_tbl[0],
+	.module = THIS_MODULE,
+
+	.attach = hexium_attach,
+	.detach = hexium_detach,
+
+	.irq_mask = 0,
+	.irq_func = NULL,
+};
+
+int __init hexium_init_module(void)
+{
+	if (0 != saa7146_register_extension(&hexium_extension)) {
+		DEB_S(("failed to register extension.\n"));
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+void __exit hexium_cleanup_module(void)
+{
+	saa7146_unregister_extension(&hexium_extension);
+}
+
+module_init(hexium_init_module);
+module_exit(hexium_cleanup_module);
+
+MODULE_DESCRIPTION("video4linux-2 driver for Hexium Gemini frame grabber cards");
+MODULE_AUTHOR("Michael Hunold <michael@mihu.de>");
+MODULE_LICENSE("GPL");
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/video/hexium_gemini.h linux-2.6.0-test1.patch/drivers/media/video/hexium_gemini.h
--- linux-2.6.0-test1.work/drivers/media/video/hexium_gemini.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/video/hexium_gemini.h	2003-07-15 10:06:36.000000000 +0200
@@ -0,0 +1,103 @@
+#ifndef __HEXIUM_GEMINI__
+#define __HEXIUM_GEMINI__
+
+#include "hexium.h"
+
+static struct saa7146_extension_ioctls ioctls[] = {
+	{ VIDIOC_G_INPUT,	SAA7146_EXCLUSIVE },
+	{ VIDIOC_S_INPUT,	SAA7146_EXCLUSIVE },
+	{ VIDIOC_QUERYCTRL, 	SAA7146_BEFORE },
+	{ VIDIOC_ENUMINPUT, 	SAA7146_EXCLUSIVE },
+	{ VIDIOC_S_STD,		SAA7146_AFTER },
+	{ VIDIOC_G_CTRL,	SAA7146_BEFORE },
+	{ VIDIOC_S_CTRL,	SAA7146_BEFORE },
+	{ 0,			0 }
+};
+
+#define HEXIUM_CONTROLS	1
+static struct v4l2_queryctrl hexium_controls[] = {
+	{ V4L2_CID_PRIVATE_BASE, V4L2_CTRL_TYPE_BOOLEAN, "B/W", 0, 1, 1, 0, 0 },
+};
+
+#define HEXIUM_GEMUINI_V_1_0		1
+#define HEXIUM_GEMUINI_DUAL_V_1_0	2
+
+struct hexium
+{
+	int type;
+	struct video_device	video_dev;
+	struct i2c_adapter	i2c_adapter;
+		
+	int 		cur_input;	/* current input */
+	v4l2_std_id 	cur_std;	/* current standard */
+	int		cur_bw;		/* current black/white status */
+};
+
+/* Samsung KS0127B decoder default registers */
+static u8 hexium_ks0127b[0x100]={
+/*00*/ 0x00,0x52,0x30,0x40,0x01,0x0C,0x2A,0x10,
+/*08*/ 0x00,0x00,0x00,0x60,0x00,0x00,0x0F,0x06,
+/*10*/ 0x00,0x00,0xE4,0xC0,0x00,0x00,0x00,0x00,
+/*18*/ 0x14,0x9B,0xFE,0xFF,0xFC,0xFF,0x03,0x22,
+/*20*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*28*/ 0x00,0x00,0x00,0x00,0x00,0x2C,0x9B,0x00,
+/*30*/ 0x00,0x00,0x10,0x80,0x80,0x10,0x80,0x80,
+/*38*/ 0x01,0x04,0x00,0x00,0x00,0x29,0xC0,0x00,
+/*40*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*48*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*50*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*58*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*60*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*68*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*70*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*78*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*80*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*88*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*90*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*98*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*A0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*A8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*B0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*B8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*C0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*C8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*D0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*D8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*E0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*E8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*F0*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+/*F8*/ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
+};
+
+static struct hexium_data hexium_pal[] = {
+	{ 0x01, 0x52 }, { 0x12, 0x64 }, { 0x2D, 0x2C }, { 0x2E, 0x9B }, { -1 , 0xFF }
+};
+
+static struct hexium_data hexium_pal_bw[] = {
+	{ 0x01, 0x52 },	{ 0x12, 0x64 },	{ 0x2D, 0x2C },	{ 0x2E, 0x9B },	{ -1 , 0xFF }
+};
+
+static struct hexium_data hexium_ntsc[] = {
+	{ 0x01, 0x53 }, { 0x12, 0x04 }, { 0x2D, 0x23 }, { 0x2E, 0x81 }, { -1 , 0xFF }
+};
+
+static struct hexium_data hexium_ntsc_bw[] = {
+	{ 0x01, 0x53 }, { 0x12, 0x04 }, { 0x2D, 0x23 }, { 0x2E, 0x81 }, { -1 , 0xFF }
+};
+
+static struct hexium_data hexium_secam[] = {
+	{ 0x01, 0x52 }, { 0x12, 0x64 }, { 0x2D, 0x2C }, { 0x2E, 0x9B }, { -1 , 0xFF }
+};
+
+static struct hexium_data hexium_input_select[] = {
+	{ 0x02, 0x60 },
+	{ 0x02, 0x64 },
+	{ 0x02, 0x61 },
+	{ 0x02, 0x65 },
+	{ 0x02, 0x62 },
+	{ 0x02, 0x66 },
+	{ 0x02, 0x68 },
+	{ 0x02, 0x69 },
+	{ 0x02, 0x6A },
+};
+#endif
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/video/hexium_orion.c linux-2.6.0-test1.patch/drivers/media/video/hexium_orion.c
--- linux-2.6.0-test1.work/drivers/media/video/hexium_orion.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/video/hexium_orion.c	2003-07-15 10:05:42.000000000 +0200
@@ -0,0 +1,328 @@
+/*
+    hexium_orion.c - v4l2 driver for the Hexium Orion frame grabber cards
+
+    Visit http://www.mihu.de/linux/saa7146/ and follow the link
+    to "hexium" for further details about this card.
+    
+    Copyright (C) 2003 Michael Hunold <michael@mihu.de>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#define DEBUG_VARIABLE debug
+
+#include <media/saa7146_vv.h>
+
+static int debug = 255;
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "debug verbosity");
+
+/* global variables */
+int hexium_num = 0;
+
+#include "hexium_orion.h"
+
+/* this is only called for old HV-PCI6/Orion cards
+   without eeprom */
+static int hexium_probe(struct saa7146_dev *dev)
+{
+	struct hexium *hexium = 0;
+	union i2c_smbus_data data;
+	int err = 0;
+
+	DEB_EE((".\n"));
+
+	/* there are no hexium orion cards with revision 0 saa7146s */
+	if (0 == dev->revision) {
+		return -EFAULT;
+	}
+
+	hexium = (struct hexium *) kmalloc(sizeof(struct hexium), GFP_KERNEL);
+	if (NULL == hexium) {
+		printk("hexium_orion.o: hexium_probe: not enough kernel memory.\n");
+		return -ENOMEM;
+	}
+	memset(hexium, 0x0, sizeof(struct hexium));
+
+	/* FIXME: enable i2c-port pins, video-port-pins
+	   video port pins should be enabled here ?! */
+	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
+
+	saa7146_write(dev, DD1_INIT, 0x02000200);
+	saa7146_write(dev, DD1_STREAM_B, 0x00000000);
+	saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
+
+	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, SAA7146_I2C_BUS_BIT_RATE_480);
+	if (i2c_add_adapter(&hexium->i2c_adapter) < 0) {
+		DEB_S(("cannot register i2c-device. skipping.\n"));
+		kfree(hexium);
+		return -EFAULT;
+	}
+
+	/* set SAA7110 control GPIO 0 */
+	saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTHI);
+	/*  set HWControl GPIO number 2 */
+	saa7146_setgpio(dev, 2, SAA7146_GPIO_OUTHI);
+
+	mdelay(10);
+
+	/* detect newer Hexium Orion cards by subsystem ids */
+	if (0x17c8 == dev->pci->subsystem_vendor && 0x0101 == dev->pci->subsystem_device) {
+		printk("hexium_orion.o: device is a Hexium Orion w/ 1 SVHS + 3 BNC inputs.\n");
+		/* we store the pointer in our private data field */
+		(struct hexium *) dev->ext_priv = hexium;
+		hexium->type = HEXIUM_ORION_1SVHS_3BNC;
+		return 0;
+	}
+
+	if (0x17c8 == dev->pci->subsystem_vendor && 0x2101 == dev->pci->subsystem_device) {
+		printk("hexium_orion.o: device is a Hexium Orion w/ 4 BNC inputs.\n");
+		/* we store the pointer in our private data field */
+		(struct hexium *) dev->ext_priv = hexium;
+		hexium->type = HEXIUM_ORION_4BNC;
+		return 0;
+	}
+
+	/* check if this is an old hexium Orion card by looking at 
+	   a saa7110 at address 0x4e */
+	if (0 == (err = i2c_smbus_xfer(&hexium->i2c_adapter, 0x4e, 0, I2C_SMBUS_READ, 0x00, I2C_SMBUS_BYTE_DATA, &data))) {
+		printk("hexium_orion.o: device is a Hexium HV-PCI6/Orion (old).\n");
+		/* we store the pointer in our private data field */
+		(struct hexium *) dev->ext_priv = hexium;
+		hexium->type = HEXIUM_HV_PCI6_ORION;
+		return 0;
+	}
+
+	i2c_del_adapter(&hexium->i2c_adapter);
+	kfree(hexium);
+	return -EFAULT;
+}
+
+/* bring hardware to a sane state. this has to be done, just in case someone
+   wants to capture from this device before it has been properly initialized.
+   the capture engine would badly fail, because no valid signal arrives on the
+   saa7146, thus leading to timeouts and stuff. */
+static int hexium_init_done(struct saa7146_dev *dev)
+{
+	struct hexium *hexium = (struct hexium *) dev->ext_priv;
+	union i2c_smbus_data data;
+	int i = 0;
+
+	DEB_D(("hexium_init_done called.\n"));
+
+	/* initialize the helper ics to useful values */
+	for (i = 0; i < sizeof(hexium_saa7110); i++) {
+		data.byte = hexium_saa7110[i];
+		if (0 != i2c_smbus_xfer(&hexium->i2c_adapter, 0x4e, 0, I2C_SMBUS_WRITE, i, I2C_SMBUS_BYTE_DATA, &data)) {
+			printk("hexium_orion: failed for address 0x%02x\n", i);
+		}
+	}
+
+	return 0;
+}
+
+static struct saa7146_ext_vv vv_data;
+
+/* this function only gets called when the probing was successful */
+static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_data *info)
+{
+	struct hexium *hexium = (struct hexium *) dev->ext_priv;
+
+	DEB_EE((".\n"));
+
+	saa7146_vv_init(dev, &vv_data);
+	if (0 != saa7146_register_device(&hexium->video_dev, dev, "hexium", VFL_TYPE_GRABBER)) {
+		ERR(("cannot register capture v4l2 device. skipping.\n"));
+		return -1;
+	}
+
+	printk("hexium_orion.o: found 'hexium orion' frame grabber-%d.\n", hexium_num);
+	hexium_num++;
+
+	/* the rest */
+	hexium->cur_input = 0;
+	hexium_init_done(dev);
+
+	return 0;
+}
+
+static int hexium_detach(struct saa7146_dev *dev)
+{
+	struct hexium *hexium = (struct hexium *) dev->ext_priv;
+
+	DEB_EE(("dev:%p\n", dev));
+
+	saa7146_unregister_device(&hexium->video_dev, dev);
+	saa7146_vv_release(dev);
+
+	hexium_num--;
+
+	i2c_del_adapter(&hexium->i2c_adapter);
+	kfree(hexium);
+	return 0;
+}
+
+static int hexium_ioctl(struct saa7146_fh *fh, unsigned int cmd, void *arg)
+{
+	struct saa7146_dev *dev = fh->dev;
+	struct hexium *hexium = (struct hexium *) dev->ext_priv;
+/*
+	struct saa7146_vv *vv = dev->vv_data; 
+*/
+	switch (cmd) {
+	case VIDIOC_ENUMINPUT:
+		{
+			struct v4l2_input *i = arg;
+			DEB_EE(("VIDIOC_ENUMINPUT %d.\n", i->index));
+
+			if (i->index < 0 || i->index >= HEXIUM_INPUTS) {
+				return -EINVAL;
+			}
+
+			memcpy(i, &hexium_inputs[i->index], sizeof(struct v4l2_input));
+
+			DEB_D(("v4l2_ioctl: VIDIOC_ENUMINPUT %d.\n", i->index));
+			return 0;
+		}
+	case VIDIOC_G_INPUT:
+		{
+			int *input = (int *) arg;
+			*input = hexium->cur_input;
+
+			DEB_D(("VIDIOC_G_INPUT: %d\n", *input));
+			return 0;
+		}
+	case VIDIOC_S_INPUT:
+		{
+			int input = *(int *) arg;
+
+			if (input < 0 || input >= HEXIUM_INPUTS) {
+				return -EINVAL;
+			}
+
+			hexium->cur_input = input;
+
+			/* fixme: switch input here, switch audio, too! */
+//              saa7146_set_hps_source_and_sync(dev, input_port_selection[input].hps_source, input_port_selection[input].hps_sync);
+			printk("hexium_orion.o: VIDIOC_S_INPUT: fixme switch input.\n");
+
+			return 0;
+		}
+	default:
+/*
+		DEB_D(("v4l2_ioctl does not handle this ioctl.\n"));
+*/
+		return -ENOIOCTLCMD;
+	}
+	return 0;
+}
+
+static int std_callback(struct saa7146_dev *dev, struct saa7146_standard *std)
+{
+	return 0;
+}
+
+static struct saa7146_extension extension;
+
+static struct saa7146_pci_extension_data hexium_hv_pci6 = {
+	.ext_priv = "Hexium HV-PCI6 / Orion",
+	.ext = &extension,
+};
+
+static struct saa7146_pci_extension_data hexium_orion_1svhs_3bnc = {
+	.ext_priv = "Hexium HV-PCI6 / Orion (1 SVHS/3 BNC)",
+	.ext = &extension,
+};
+
+static struct saa7146_pci_extension_data hexium_orion_4bnc = {
+	.ext_priv = "Hexium HV-PCI6 / Orion (4 BNC)",
+	.ext = &extension,
+};
+
+static struct pci_device_id pci_tbl[] = {
+	{
+	 .vendor = PCI_VENDOR_ID_PHILIPS,
+	 .device = PCI_DEVICE_ID_PHILIPS_SAA7146,
+	 .subvendor = 0x0000,
+	 .subdevice = 0x0000,
+	 .driver_data = (unsigned long) &hexium_hv_pci6,
+	 },
+	{
+	 .vendor = PCI_VENDOR_ID_PHILIPS,
+	 .device = PCI_DEVICE_ID_PHILIPS_SAA7146,
+	 .subvendor = 0x17c8,
+	 .subdevice = 0x0101,
+	 .driver_data = (unsigned long) &hexium_orion_1svhs_3bnc,
+	 },
+	{
+	 .vendor = PCI_VENDOR_ID_PHILIPS,
+	 .device = PCI_DEVICE_ID_PHILIPS_SAA7146,
+	 .subvendor = 0x17c8,
+	 .subdevice = 0x2101,
+	 .driver_data = (unsigned long) &hexium_orion_4bnc,
+	 },
+	{
+	 .vendor = 0,
+	 }
+};
+
+MODULE_DEVICE_TABLE(pci, pci_tbl);
+
+static struct saa7146_ext_vv vv_data = {
+	.inputs = HEXIUM_INPUTS,
+	.capabilities = 0,
+	.stds = &hexium_standards[0],
+	.num_stds = sizeof(hexium_standards) / sizeof(struct saa7146_standard),
+	.std_callback = &std_callback,
+	.ioctls = &ioctls[0],
+	.ioctl = hexium_ioctl,
+};
+
+static struct saa7146_extension extension = {
+	.name = "hexium HV-PCI6/Orion",
+	.flags = 0,		// SAA7146_USE_I2C_IRQ,
+
+	.pci_tbl = &pci_tbl[0],
+	.module = THIS_MODULE,
+
+	.probe = hexium_probe,
+	.attach = hexium_attach,
+	.detach = hexium_detach,
+
+	.irq_mask = 0,
+	.irq_func = NULL,
+};
+
+int __init hexium_init_module(void)
+{
+	if (0 != saa7146_register_extension(&extension)) {
+		DEB_S(("failed to register extension.\n"));
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+void __exit hexium_cleanup_module(void)
+{
+	saa7146_unregister_extension(&extension);
+}
+
+module_init(hexium_init_module);
+module_exit(hexium_cleanup_module);
+
+MODULE_DESCRIPTION("video4linux-2 driver for Hexium Orion frame grabber cards");
+MODULE_AUTHOR("Michael Hunold <michael@mihu.de>");
+MODULE_LICENSE("GPL");
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/video/hexium_orion.h linux-2.6.0-test1.patch/drivers/media/video/hexium_orion.h
--- linux-2.6.0-test1.work/drivers/media/video/hexium_orion.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/video/hexium_orion.h	2003-07-15 10:01:57.000000000 +0200
@@ -0,0 +1,138 @@
+#ifndef __HEXIUM_ORION__
+#define __HEXIUM_ORION__
+
+#include "hexium.h"
+
+static struct saa7146_extension_ioctls ioctls[] = {
+	{ VIDIOC_G_INPUT,	SAA7146_EXCLUSIVE },
+	{ VIDIOC_S_INPUT,	SAA7146_EXCLUSIVE },
+	{ VIDIOC_ENUMINPUT, 	SAA7146_EXCLUSIVE },
+	{ VIDIOC_S_STD,		SAA7146_AFTER },
+	{ 0,			0 }
+};
+
+struct hexium
+{
+	int type;
+	struct video_device	video_dev;
+	struct i2c_adapter	i2c_adapter;	
+	int cur_input;	/* current input */
+};
+
+/* Philips SAA7110 decoder default registers */
+static u8 hexium_saa7110[53]={
+/*00*/ 0x4C,0x3C,0x0D,0xEF,0xBD,0xF0,0x00,0x00,
+/*08*/ 0xF8,0xF8,0x60,0x60,0x40,0x86,0x18,0x90,
+/*10*/ 0x00,0x2C,0x40,0x46,0x42,0x1A,0xFF,0xDA,
+/*18*/ 0xF0,0x8B,0x00,0x00,0x00,0x00,0x00,0x00,
+/*20*/ 0xD9,0x17,0x40,0x41,0x80,0x41,0x80,0x4F,
+/*28*/ 0xFE,0x01,0x0F,0x0F,0x03,0x01,0x81,0x03,
+/*30*/ 0x44,0x75,0x01,0x8C,0x03
+};
+
+static struct {
+	struct hexium_data data[8];	
+} hexium_input_select[] = {
+{
+	{ /* input 0 */
+		{ 0x06, 0x00 },
+		{ 0x20, 0xD9 },
+		{ 0x21, 0x17 }, // 0x16,
+		{ 0x22, 0x40 },
+		{ 0x2C, 0x03 },
+		{ 0x30, 0x44 },
+		{ 0x31, 0x75 }, // ??
+		{ 0x21, 0x16 }, // 0x03,
+	}
+}, {
+	{ /* input 1 */
+		{ 0x06, 0x00 },
+		{ 0x20, 0xD8 },
+		{ 0x21, 0x17 }, // 0x16,
+		{ 0x22, 0x40 },
+		{ 0x2C, 0x03 },
+		{ 0x30, 0x44 },
+		{ 0x31, 0x75 }, // ??
+		{ 0x21, 0x16 }, // 0x03,
+	}
+}, {
+	{ /* input 2 */
+		{ 0x06, 0x00 },
+		{ 0x20, 0xBA },
+		{ 0x21, 0x07 }, // 0x05,
+		{ 0x22, 0x91 },
+		{ 0x2C, 0x03 },
+		{ 0x30, 0x60 },
+		{ 0x31, 0xB5 }, // ??
+		{ 0x21, 0x05 }, // 0x03,
+	}
+}, {
+	{ /* input 3 */
+		{ 0x06, 0x00 },
+		{ 0x20, 0xB8 },
+		{ 0x21, 0x07 }, // 0x05,
+		{ 0x22, 0x91 },
+		{ 0x2C, 0x03 },
+		{ 0x30, 0x60 },
+		{ 0x31, 0xB5 }, // ??
+		{ 0x21, 0x05 }, // 0x03,
+	}
+}, {
+	{ /* input 4 */
+		{ 0x06, 0x00 },
+		{ 0x20, 0x7C },
+		{ 0x21, 0x07 }, // 0x03
+		{ 0x22, 0xD2 },
+		{ 0x2C, 0x83 },
+		{ 0x30, 0x60 },
+		{ 0x31, 0xB5 }, // ??
+		{ 0x21, 0x03 },
+	} 
+}, {
+	{ /* input 5 */
+		{ 0x06, 0x00 },
+		{ 0x20, 0x78 },
+		{ 0x21, 0x07 }, // 0x03,
+		{ 0x22, 0xD2 },
+		{ 0x2C, 0x83 },
+		{ 0x30, 0x60 },
+		{ 0x31, 0xB5 }, // ?
+		{ 0x21, 0x03 },
+	}
+}, {
+	{ /* input 6 */
+		{ 0x06, 0x80 },
+		{ 0x20, 0x59 },
+		{ 0x21, 0x17 },
+		{ 0x22, 0x42 },
+		{ 0x2C, 0xA3 },
+		{ 0x30, 0x44 },
+		{ 0x31, 0x75 },
+		{ 0x21, 0x12 },
+	}
+}, {
+	{ /* input 7 */
+		{ 0x06, 0x80 },
+		{ 0x20, 0x9A },
+		{ 0x21, 0x17 },
+		{ 0x22, 0xB1 },
+		{ 0x2C, 0x13 },
+		{ 0x30, 0x60 },
+		{ 0x31, 0xB5 },
+		{ 0x21, 0x14 },
+	}
+}, {
+	{ /* input 8 */
+		{ 0x06, 0x80 },
+		{ 0x20, 0x3C },
+		{ 0x21, 0x27 },
+		{ 0x22, 0xC1 },
+		{ 0x2C, 0x23 },
+		{ 0x30, 0x44 },
+		{ 0x31, 0x75 },
+		{ 0x21, 0x21 },
+	}
+}	
+};
+
+#endif

