Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266480AbUFQNLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266480AbUFQNLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUFQNLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:11:06 -0400
Received: from adsl-63-194-232-126.dsl.lsan03.pacbell.net ([63.194.232.126]:44562
	"HELO alpha.dyndns.org") by vger.kernel.org with SMTP
	id S266480AbUFQNHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:07:50 -0400
Message-ID: <40D1974C.3000203@alpha.dyndns.org>
Date: Thu, 17 Jun 2004 06:06:20 -0700
From: Mark McClelland <mark@alpha.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.7] Add ovcamchip driver
Content-Type: multipart/mixed;
 boundary="------------020904050300050904070503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020904050300050904070503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds a new driver for the OmniVision OV6xx0 and OV7xx0 series of CMOS
image sensors. It is currently used by the w9968cf USB webcam driver, which is
already in mainline 2.6. Up until now it had to be compiled outside the kernel
tree, which is clearly suboptimal.

It is also used by version 2 of the ov511 USB webcam driver, which will be
merged in the near future. That will reduce some code duplication, since the
existing ov511 has much of this code built-in.

This was previously submitted to Linux-USB-Devel, and I have fixed the concerns
that came up at that time.

The patch is tested on 2.6.7 but compiles cleanly on 2.6.6-rc3-mm2.

Affected files:
drivers/media/video/Kconfig                    |   11
drivers/media/video/Makefile                   |    1
drivers/media/video/ovcamchip/Makefile         |    4
drivers/media/video/ovcamchip/ov6x20.c         |  415 ++++++++++++++++++++++
drivers/media/video/ovcamchip/ov6x30.c         |  374 ++++++++++++++++++++
drivers/media/video/ovcamchip/ov76be.c         |  303 ++++++++++++++++
drivers/media/video/ovcamchip/ov7x10.c         |  335 ++++++++++++++++++
drivers/media/video/ovcamchip/ov7x20.c         |  455 +++++++++++++++++++++++++
drivers/media/video/ovcamchip/ovcamchip_core.c |  446 ++++++++++++++++++++++++
drivers/media/video/ovcamchip/ovcamchip_priv.h |   87 ++++
include/media/ovcamchip.h                      |  104 +++++
     11 files changed, 2535 insertions(+)


Developer's Certificate of Origin 1.0

By making a contribution to this project, I certify that:

(a) The contribution was created in whole or in part by me and I
        have the right to submit it under the open source license
        indicated in the file; or

(b) The contribution is based upon previous work that, to the best
        of my knowledge, is covered under an appropriate open source
        license and I have the right under that license to submit that
        work with modifications, whether created in whole or in part
        by me, under the same open source license (unless I am
        by me, under the same open source license (unless I am
        permitted to submit under a different license), as indicated
        in the file; or

(c) The contribution was provided directly to me by some other
        person who certified (a), (b) or (c) and I have not modified
        it.

Signed-off-by: Mark McClelland <mark@alpha.dyndns.org>

-- 
Mark McClelland
mark@alpha.dyndns.org




--------------020904050300050904070503
Content-Type: text/plain;
 name="2.6.7-add-ovcamchip.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.7-add-ovcamchip.patch"

diff -Nur old/drivers/media/video/Kconfig new/drivers/media/video/Kconfig
--- old/drivers/media/video/Kconfig	2004-06-16 16:55:47.000000000 -0700
+++ new/drivers/media/video/Kconfig	2004-06-16 16:57:27.000000000 -0700
@@ -295,5 +295,16 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called cx8800
 
+config VIDEO_OVCAMCHIP
+	tristate "OmniVision Camera Chip support"
+	depends on VIDEO_DEV && I2C
+	---help---
+	  Support for the OmniVision OV6xxx and OV7xxx series of camera chips.
+	  This driver is intended to be used with the ov511 and w9968cf USB
+	  camera drivers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ovcamchip
+
 endmenu
 
diff -Nur old/drivers/media/video/Makefile new/drivers/media/video/Makefile
--- old/drivers/media/video/Makefile	2004-05-08 03:16:03.000000000 -0700
+++ new/drivers/media/video/Makefile	2004-05-08 03:17:33.000000000 -0700
@@ -37,6 +37,7 @@
 obj-$(CONFIG_VIDEO_MEYE) += meye.o
 obj-$(CONFIG_VIDEO_SAA7134) += saa7134/
 obj-$(CONFIG_VIDEO_CX88) += cx88/
+obj-$(CONFIG_VIDEO_OVCAMCHIP) += ovcamchip/
 obj-$(CONFIG_VIDEO_MXB) += saa7111.o tuner.o tda9840.o tea6415c.o tea6420.o mxb.o
 obj-$(CONFIG_VIDEO_HEXIUM_ORION) += hexium_orion.o
 obj-$(CONFIG_VIDEO_HEXIUM_GEMINI) += hexium_gemini.o
diff -Nur old/drivers/media/video/ovcamchip/Makefile new/drivers/media/video/ovcamchip/Makefile
--- old/drivers/media/video/ovcamchip/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ new/drivers/media/video/ovcamchip/Makefile	2004-05-08 00:48:14.000000000 -0700
@@ -0,0 +1,4 @@
+ovcamchip-objs     := ovcamchip_core.o ov6x20.o ov6x30.o ov7x10.o ov7x20.o \
+                      ov76be.o
+
+obj-$(CONFIG_VIDEO_OVCAMCHIP) += ovcamchip.o
diff -Nur old/drivers/media/video/ovcamchip/ov6x20.c new/drivers/media/video/ovcamchip/ov6x20.c
--- old/drivers/media/video/ovcamchip/ov6x20.c	1969-12-31 16:00:00.000000000 -0800
+++ new/drivers/media/video/ovcamchip/ov6x20.c	2004-06-17 03:31:15.000000000 -0700
@@ -0,0 +1,415 @@
+/* OmniVision OV6620/OV6120 Camera Chip Support Code
+ *
+ * Copyright (c) 1999-2004 Mark McClelland <mark@alpha.dyndns.org>
+ * http://alpha.dyndns.org/ov511/
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version. NO WARRANTY OF ANY KIND is expressed or implied.
+ */
+
+#define DEBUG
+
+#include <linux/slab.h>
+#include "ovcamchip_priv.h"
+
+/* Registers */
+#define REG_GAIN		0x00	/* gain [5:0] */
+#define REG_BLUE		0x01	/* blue gain */
+#define REG_RED			0x02	/* red gain */
+#define REG_SAT			0x03	/* saturation */
+#define REG_CNT			0x05	/* Y contrast */
+#define REG_BRT			0x06	/* Y brightness */
+#define REG_WB_BLUE		0x0C	/* WB blue ratio [5:0] */
+#define REG_WB_RED		0x0D	/* WB red ratio [5:0] */
+#define REG_EXP			0x10	/* exposure */
+
+/* Window parameters */
+#define HWSBASE 0x38
+#define HWEBASE 0x3A
+#define VWSBASE 0x05
+#define VWEBASE 0x06
+
+struct ov6x20 {
+	int auto_brt;
+	int auto_exp;
+	int backlight;
+	int bandfilt;
+	int mirror;
+};
+
+/* Initial values for use with OV511/OV511+ cameras */
+static struct ovcamchip_regvals regvals_init_6x20_511[] = {
+	{ 0x12, 0x80 }, /* reset */
+	{ 0x11, 0x01 },
+	{ 0x03, 0x60 },
+	{ 0x05, 0x7f }, /* For when autoadjust is off */
+	{ 0x07, 0xa8 },
+	{ 0x0c, 0x24 },
+	{ 0x0d, 0x24 },
+	{ 0x0f, 0x15 }, /* COMS */
+	{ 0x10, 0x75 }, /* AEC Exposure time */
+	{ 0x12, 0x24 }, /* Enable AGC and AWB */
+	{ 0x14, 0x04 },
+	{ 0x16, 0x03 },
+	{ 0x26, 0xb2 }, /* BLC enable */
+	/* 0x28: 0x05 Selects RGB format if RGB on */
+	{ 0x28, 0x05 },
+	{ 0x2a, 0x04 }, /* Disable framerate adjust */
+	{ 0x2d, 0x99 },
+	{ 0x33, 0xa0 }, /* Color Processing Parameter */
+	{ 0x34, 0xd2 }, /* Max A/D range */
+	{ 0x38, 0x8b },
+	{ 0x39, 0x40 },
+
+	{ 0x3c, 0x39 }, /* Enable AEC mode changing */
+	{ 0x3c, 0x3c }, /* Change AEC mode */
+	{ 0x3c, 0x24 }, /* Disable AEC mode changing */
+
+	{ 0x3d, 0x80 },
+	/* These next two registers (0x4a, 0x4b) are undocumented. They
+	 * control the color balance */
+	{ 0x4a, 0x80 },
+	{ 0x4b, 0x80 },
+	{ 0x4d, 0xd2 }, /* This reduces noise a bit */
+	{ 0x4e, 0xc1 },
+	{ 0x4f, 0x04 },
+	{ 0xff, 0xff },	/* END MARKER */
+};
+
+/* Initial values for use with OV518 cameras */
+static struct ovcamchip_regvals regvals_init_6x20_518[] = {
+	{ 0x12, 0x80 }, /* Do a reset */
+	{ 0x03, 0xc0 }, /* Saturation */
+	{ 0x05, 0x8a }, /* Contrast */
+	{ 0x0c, 0x24 }, /* AWB blue */
+	{ 0x0d, 0x24 }, /* AWB red */
+	{ 0x0e, 0x8d }, /* Additional 2x gain */
+	{ 0x0f, 0x25 }, /* Black expanding level = 1.3V */
+	{ 0x11, 0x01 }, /* Clock div. */
+	{ 0x12, 0x24 }, /* Enable AGC and AWB */
+	{ 0x13, 0x01 }, /* (default) */
+	{ 0x14, 0x80 }, /* Set reserved bit 7 */
+	{ 0x15, 0x01 }, /* (default) */
+	{ 0x16, 0x03 }, /* (default) */
+	{ 0x17, 0x38 }, /* (default) */
+	{ 0x18, 0xea }, /* (default) */
+	{ 0x19, 0x04 },
+	{ 0x1a, 0x93 },
+	{ 0x1b, 0x00 }, /* (default) */
+	{ 0x1e, 0xc4 }, /* (default) */
+	{ 0x1f, 0x04 }, /* (default) */
+	{ 0x20, 0x20 }, /* Enable 1st stage aperture correction */
+	{ 0x21, 0x10 }, /* Y offset */
+	{ 0x22, 0x88 }, /* U offset */
+	{ 0x23, 0xc0 }, /* Set XTAL power level */
+	{ 0x24, 0x53 }, /* AEC bright ratio */
+	{ 0x25, 0x7a }, /* AEC black ratio */
+	{ 0x26, 0xb2 }, /* BLC enable */
+	{ 0x27, 0xa2 }, /* Full output range */
+	{ 0x28, 0x01 }, /* (default) */
+	{ 0x29, 0x00 }, /* (default) */
+	{ 0x2a, 0x84 }, /* (default) */
+	{ 0x2b, 0xa8 }, /* Set custom frame rate */
+	{ 0x2c, 0xa0 }, /* (reserved) */
+	{ 0x2d, 0x95 }, /* Enable banding filter */
+	{ 0x2e, 0x88 }, /* V offset */
+	{ 0x33, 0x22 }, /* Luminance gamma on */
+	{ 0x34, 0xc7 }, /* A/D bias */
+	{ 0x36, 0x12 }, /* (reserved) */
+	{ 0x37, 0x63 }, /* (reserved) */
+	{ 0x38, 0x8b }, /* Quick AEC/AEB */
+	{ 0x39, 0x00 }, /* (default) */
+	{ 0x3a, 0x0f }, /* (default) */
+	{ 0x3b, 0x3c }, /* (default) */
+	{ 0x3c, 0x5c }, /* AEC controls */
+	{ 0x3d, 0x80 }, /* Drop 1 (bad) frame when AEC change */
+	{ 0x3e, 0x80 }, /* (default) */
+	{ 0x3f, 0x02 }, /* (default) */
+	{ 0x40, 0x10 }, /* (reserved) */
+	{ 0x41, 0x10 }, /* (reserved) */
+	{ 0x42, 0x00 }, /* (reserved) */
+	{ 0x43, 0x7f }, /* (reserved) */
+	{ 0x44, 0x80 }, /* (reserved) */
+	{ 0x45, 0x1c }, /* (reserved) */
+	{ 0x46, 0x1c }, /* (reserved) */
+	{ 0x47, 0x80 }, /* (reserved) */
+	{ 0x48, 0x5f }, /* (reserved) */
+	{ 0x49, 0x00 }, /* (reserved) */
+	{ 0x4a, 0x00 }, /* Color balance (undocumented) */
+	{ 0x4b, 0x80 }, /* Color balance (undocumented) */
+	{ 0x4c, 0x58 }, /* (reserved) */
+	{ 0x4d, 0xd2 }, /* U *= .938, V *= .838 */
+	{ 0x4e, 0xa0 }, /* (default) */
+	{ 0x4f, 0x04 }, /* UV 3-point average */
+	{ 0x50, 0xff }, /* (reserved) */
+	{ 0x51, 0x58 }, /* (reserved) */
+	{ 0x52, 0xc0 }, /* (reserved) */
+	{ 0x53, 0x42 }, /* (reserved) */
+	{ 0x27, 0xa6 }, /* Enable manual offset adj. (reg 21 & 22) */
+	{ 0x12, 0x20 },
+	{ 0x12, 0x24 },
+
+	{ 0xff, 0xff },	/* END MARKER */
+};
+
+/* This initializes the OV6x20 camera chip and relevant variables. */
+static int ov6x20_init(struct i2c_client *c)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov6x20 *s;
+	int rc;
+
+	DDEBUG(4, &c->dev, "entered");
+
+	switch (c->adapter->id) {
+	case I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV511:
+		rc = ov_write_regvals(c, regvals_init_6x20_511);
+		break;
+	case I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518:
+		rc = ov_write_regvals(c, regvals_init_6x20_518);
+		break;
+	default:
+		dev_err(&c->dev, "ov6x20: Unsupported adapter\n");
+		rc = -ENODEV;
+	}
+
+	if (rc < 0)
+		return rc;
+
+	ov->spriv = s = kmalloc(sizeof *s, GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+	memset(s, 0, sizeof *s);
+
+	s->auto_brt = 1;
+	s->auto_exp = 1;
+
+	return rc;
+}
+
+static int ov6x20_free(struct i2c_client *c)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+
+	kfree(ov->spriv);
+	return 0;
+}
+
+static int ov6x20_set_control(struct i2c_client *c,
+			      struct ovcamchip_control *ctl)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov6x20 *s = ov->spriv;
+	int rc;
+	int v = ctl->value;
+
+	switch (ctl->id) {
+	case OVCAMCHIP_CID_CONT:
+		rc = ov_write(c, REG_CNT, v >> 8);
+		break;
+	case OVCAMCHIP_CID_BRIGHT:
+		rc = ov_write(c, REG_BRT, v >> 8);
+		break;
+	case OVCAMCHIP_CID_SAT:
+		rc = ov_write(c, REG_SAT, v >> 8);
+		break;
+	case OVCAMCHIP_CID_HUE:
+		rc = ov_write(c, REG_RED, 0xFF - (v >> 8));
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write(c, REG_BLUE, v >> 8);
+		break;
+	case OVCAMCHIP_CID_EXP:
+		rc = ov_write(c, REG_EXP, v);
+		break;
+	case OVCAMCHIP_CID_FREQ:
+	{
+		int sixty = (v == 60);
+
+		rc = ov_write(c, 0x2b, sixty?0xa8:0x28);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write(c, 0x2a, sixty?0x84:0xa4);
+		break;
+	}
+	case OVCAMCHIP_CID_BANDFILT:
+		rc = ov_write_mask(c, 0x2d, v?0x04:0x00, 0x04);
+		s->bandfilt = v;
+		break;
+	case OVCAMCHIP_CID_AUTOBRIGHT:
+		rc = ov_write_mask(c, 0x2d, v?0x10:0x00, 0x10);
+		s->auto_brt = v;
+		break;
+	case OVCAMCHIP_CID_AUTOEXP:
+		rc = ov_write_mask(c, 0x13, v?0x01:0x00, 0x01);
+		s->auto_exp = v;
+		break;
+	case OVCAMCHIP_CID_BACKLIGHT:
+	{
+		rc = ov_write_mask(c, 0x4e, v?0xe0:0xc0, 0xe0);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write_mask(c, 0x29, v?0x08:0x00, 0x08);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write_mask(c, 0x0e, v?0x80:0x00, 0x80);
+		s->backlight = v;
+		break;
+	}
+	case OVCAMCHIP_CID_MIRROR:
+		rc = ov_write_mask(c, 0x12, v?0x40:0x00, 0x40);
+		s->mirror = v;
+		break;
+	default:
+		DDEBUG(2, &c->dev, "control not supported: %d", ctl->id);
+		return -EPERM;
+	}
+
+out:
+	DDEBUG(3, &c->dev, "id=%d, arg=%d, rc=%d", ctl->id, v, rc);
+	return rc;
+}
+
+static int ov6x20_get_control(struct i2c_client *c,
+			      struct ovcamchip_control *ctl)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov6x20 *s = ov->spriv;
+	int rc = 0;
+	unsigned char val = 0;
+
+	switch (ctl->id) {
+	case OVCAMCHIP_CID_CONT:
+		rc = ov_read(c, REG_CNT, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_BRIGHT:
+		rc = ov_read(c, REG_BRT, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_SAT:
+		rc = ov_read(c, REG_SAT, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_HUE:
+		rc = ov_read(c, REG_BLUE, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_EXP:
+		rc = ov_read(c, REG_EXP, &val);
+		ctl->value = val;
+		break;
+	case OVCAMCHIP_CID_BANDFILT:
+		ctl->value = s->bandfilt;
+		break;
+	case OVCAMCHIP_CID_AUTOBRIGHT:
+		ctl->value = s->auto_brt;
+		break;
+	case OVCAMCHIP_CID_AUTOEXP:
+		ctl->value = s->auto_exp;
+		break;
+	case OVCAMCHIP_CID_BACKLIGHT:
+		ctl->value = s->backlight;
+		break;
+	case OVCAMCHIP_CID_MIRROR:
+		ctl->value = s->mirror;
+		break;
+	default:
+		DDEBUG(2, &c->dev, "control not supported: %d", ctl->id);
+		return -EPERM;
+	}
+
+	DDEBUG(3, &c->dev, "id=%d, arg=%d, rc=%d", ctl->id, ctl->value, rc);
+	return rc;
+}
+
+static int ov6x20_mode_init(struct i2c_client *c, struct ovcamchip_window *win)
+{
+	/******** QCIF-specific regs ********/
+
+	ov_write(c, 0x14, win->quarter?0x24:0x04);
+
+	/******** Palette-specific regs ********/
+
+	/* OV518 needs 8 bit multiplexed in color mode, and 16 bit in B&W */
+	if (c->adapter->id == (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518)) {
+		if (win->format == VIDEO_PALETTE_GREY)
+			ov_write_mask(c, 0x13, 0x00, 0x20);
+		else
+			ov_write_mask(c, 0x13, 0x20, 0x20);
+	} else {
+		if (win->format == VIDEO_PALETTE_GREY)
+			ov_write_mask(c, 0x13, 0x20, 0x20);
+		else
+			ov_write_mask(c, 0x13, 0x00, 0x20);
+	}
+
+	/******** Clock programming ********/
+
+	/* The OV6620 needs special handling. This prevents the 
+	 * severe banding that normally occurs */
+
+	/* Clock down */
+	ov_write(c, 0x2a, 0x04);
+
+	ov_write(c, 0x11, win->clockdiv);
+
+	ov_write(c, 0x2a, 0x84);
+	/* This next setting is critical. It seems to improve
+	 * the gain or the contrast. The "reserved" bits seem
+	 * to have some effect in this case. */
+	ov_write(c, 0x2d, 0x85); /* FIXME: This messes up banding filter */
+
+	return 0;
+}
+
+static int ov6x20_set_window(struct i2c_client *c, struct ovcamchip_window *win)
+{
+	int ret, hwscale, vwscale;
+
+	ret = ov6x20_mode_init(c, win);
+	if (ret < 0)
+		return ret;
+
+	if (win->quarter) {
+		hwscale = 0;
+		vwscale = 0;
+	} else {
+		hwscale = 1;
+		vwscale = 1;	/* The datasheet says 0; it's wrong */
+	}
+
+	ov_write(c, 0x17, HWSBASE + (win->x >> hwscale));
+	ov_write(c, 0x18, HWEBASE + ((win->x + win->width) >> hwscale));
+	ov_write(c, 0x19, VWSBASE + (win->y >> vwscale));
+	ov_write(c, 0x1a, VWEBASE + ((win->y + win->height) >> vwscale));
+
+	return 0;
+}
+
+static int ov6x20_command(struct i2c_client *c, unsigned int cmd, void *arg)
+{
+	switch (cmd) {
+	case OVCAMCHIP_CMD_S_CTRL:
+		return ov6x20_set_control(c, arg);
+	case OVCAMCHIP_CMD_G_CTRL:
+		return ov6x20_get_control(c, arg);
+	case OVCAMCHIP_CMD_S_MODE:
+		return ov6x20_set_window(c, arg);
+	default:
+		DDEBUG(2, &c->dev, "command not supported: %d", cmd);
+		return -ENOIOCTLCMD;
+	}
+}
+
+struct ovcamchip_ops ov6x20_ops = {
+	.init    =	ov6x20_init,
+	.free    =	ov6x20_free,
+	.command =	ov6x20_command,
+};
diff -Nur old/drivers/media/video/ovcamchip/ov6x30.c new/drivers/media/video/ovcamchip/ov6x30.c
--- old/drivers/media/video/ovcamchip/ov6x30.c	1969-12-31 16:00:00.000000000 -0800
+++ new/drivers/media/video/ovcamchip/ov6x30.c	2004-06-17 03:32:00.000000000 -0700
@@ -0,0 +1,374 @@
+/* OmniVision OV6630/OV6130 Camera Chip Support Code
+ *
+ * Copyright (c) 1999-2004 Mark McClelland <mark@alpha.dyndns.org>
+ * http://alpha.dyndns.org/ov511/
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version. NO WARRANTY OF ANY KIND is expressed or implied.
+ */
+
+#define DEBUG
+
+#include <linux/slab.h>
+#include "ovcamchip_priv.h"
+
+/* Registers */
+#define REG_GAIN		0x00	/* gain [5:0] */
+#define REG_BLUE		0x01	/* blue gain */
+#define REG_RED			0x02	/* red gain */
+#define REG_SAT			0x03	/* saturation [7:3] */
+#define REG_CNT			0x05	/* Y contrast [3:0] */
+#define REG_BRT			0x06	/* Y brightness */
+#define REG_SHARP		0x07	/* sharpness */
+#define REG_WB_BLUE		0x0C	/* WB blue ratio [5:0] */
+#define REG_WB_RED		0x0D	/* WB red ratio [5:0] */
+#define REG_EXP			0x10	/* exposure */
+
+/* Window parameters */
+#define HWSBASE 0x38
+#define HWEBASE 0x3A
+#define VWSBASE 0x05
+#define VWEBASE 0x06
+
+struct ov6x30 {
+	int auto_brt;
+	int auto_exp;
+	int backlight;
+	int bandfilt;
+	int mirror;
+};
+
+static struct ovcamchip_regvals regvals_init_6x30[] = {
+	{ 0x12, 0x80 }, /* reset */
+	{ 0x00, 0x1f }, /* Gain */
+	{ 0x01, 0x99 }, /* Blue gain */
+	{ 0x02, 0x7c }, /* Red gain */
+	{ 0x03, 0xc0 }, /* Saturation */
+	{ 0x05, 0x0a }, /* Contrast */
+	{ 0x06, 0x95 }, /* Brightness */
+	{ 0x07, 0x2d }, /* Sharpness */
+	{ 0x0c, 0x20 },
+	{ 0x0d, 0x20 },
+	{ 0x0e, 0x20 },
+	{ 0x0f, 0x05 },
+	{ 0x10, 0x9a }, /* "exposure check" */
+	{ 0x11, 0x00 }, /* Pixel clock = fastest */
+	{ 0x12, 0x24 }, /* Enable AGC and AWB */
+	{ 0x13, 0x21 },
+	{ 0x14, 0x80 },
+	{ 0x15, 0x01 },
+	{ 0x16, 0x03 },
+	{ 0x17, 0x38 },
+	{ 0x18, 0xea },
+	{ 0x19, 0x04 },
+	{ 0x1a, 0x93 },
+	{ 0x1b, 0x00 },
+	{ 0x1e, 0xc4 },
+	{ 0x1f, 0x04 },
+	{ 0x20, 0x20 },
+	{ 0x21, 0x10 },
+	{ 0x22, 0x88 },
+	{ 0x23, 0xc0 }, /* Crystal circuit power level */
+	{ 0x25, 0x9a }, /* Increase AEC black pixel ratio */
+	{ 0x26, 0xb2 }, /* BLC enable */
+	{ 0x27, 0xa2 },
+	{ 0x28, 0x00 },
+	{ 0x29, 0x00 },
+	{ 0x2a, 0x84 }, /* (keep) */
+	{ 0x2b, 0xa8 }, /* (keep) */
+	{ 0x2c, 0xa0 },
+	{ 0x2d, 0x95 },	/* Enable auto-brightness */
+	{ 0x2e, 0x88 },
+	{ 0x33, 0x26 },
+	{ 0x34, 0x03 },
+	{ 0x36, 0x8f }, 
+	{ 0x37, 0x80 },
+	{ 0x38, 0x83 },
+	{ 0x39, 0x80 },
+	{ 0x3a, 0x0f }, 
+	{ 0x3b, 0x3c },
+	{ 0x3c, 0x1a },
+	{ 0x3d, 0x80 },
+	{ 0x3e, 0x80 },
+	{ 0x3f, 0x0e }, 
+	{ 0x40, 0x00 }, /* White bal */
+	{ 0x41, 0x00 }, /* White bal */
+	{ 0x42, 0x80 },
+	{ 0x43, 0x3f }, /* White bal */
+	{ 0x44, 0x80 },
+	{ 0x45, 0x20 },
+	{ 0x46, 0x20 },
+	{ 0x47, 0x80 },
+	{ 0x48, 0x7f },
+	{ 0x49, 0x00 },
+	{ 0x4a, 0x00 }, 
+	{ 0x4b, 0x80 },
+	{ 0x4c, 0xd0 },
+	{ 0x4d, 0x10 }, /* U = 0.563u, V = 0.714v */
+	{ 0x4e, 0x40 },
+	{ 0x4f, 0x07 }, /* UV average mode, color killer: strongest */
+	{ 0x50, 0xff },
+	{ 0x54, 0x23 }, /* Max AGC gain: 18dB */
+	{ 0x55, 0xff },
+	{ 0x56, 0x12 },
+	{ 0x57, 0x81 }, /* (default) */
+	{ 0x58, 0x75 },
+	{ 0x59, 0x01 }, /* AGC dark current compensation: +1 */
+	{ 0x5a, 0x2c },
+	{ 0x5b, 0x0f }, /* AWB chrominance levels */
+	{ 0x5c, 0x10 },
+	{ 0x3d, 0x80 },
+	{ 0x27, 0xa6 },
+	/* Toggle AWB off and on */
+	{ 0x12, 0x20 },
+	{ 0x12, 0x24 },
+
+	{ 0xff, 0xff },	/* END MARKER */
+};
+
+/* This initializes the OV6x30 camera chip and relevant variables. */
+static int ov6x30_init(struct i2c_client *c)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov6x30 *s;
+	int rc;
+
+	DDEBUG(4, &c->dev, "entered");
+
+	rc = ov_write_regvals(c, regvals_init_6x30);
+	if (rc < 0)
+		return rc;
+
+	ov->spriv = s = kmalloc(sizeof *s, GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+	memset(s, 0, sizeof *s);
+
+	s->auto_brt = 1;
+	s->auto_exp = 1;
+
+	return rc;
+}
+
+static int ov6x30_free(struct i2c_client *c)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+
+	kfree(ov->spriv);
+	return 0;
+}
+
+static int ov6x30_set_control(struct i2c_client *c,
+			      struct ovcamchip_control *ctl)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov6x30 *s = ov->spriv;
+	int rc;
+	int v = ctl->value;
+
+	switch (ctl->id) {
+	case OVCAMCHIP_CID_CONT:
+		rc = ov_write_mask(c, REG_CNT, v >> 12, 0x0f);
+		break;
+	case OVCAMCHIP_CID_BRIGHT:
+		rc = ov_write(c, REG_BRT, v >> 8);
+		break;
+	case OVCAMCHIP_CID_SAT:
+		rc = ov_write(c, REG_SAT, v >> 8);
+		break;
+	case OVCAMCHIP_CID_HUE:
+		rc = ov_write(c, REG_RED, 0xFF - (v >> 8));
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write(c, REG_BLUE, v >> 8);
+		break;
+	case OVCAMCHIP_CID_EXP:
+		rc = ov_write(c, REG_EXP, v);
+		break;
+	case OVCAMCHIP_CID_FREQ:
+	{
+		int sixty = (v == 60);
+
+		rc = ov_write(c, 0x2b, sixty?0xa8:0x28);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write(c, 0x2a, sixty?0x84:0xa4);
+		break;
+	}
+	case OVCAMCHIP_CID_BANDFILT:
+		rc = ov_write_mask(c, 0x2d, v?0x04:0x00, 0x04);
+		s->bandfilt = v;
+		break;
+	case OVCAMCHIP_CID_AUTOBRIGHT:
+		rc = ov_write_mask(c, 0x2d, v?0x10:0x00, 0x10);
+		s->auto_brt = v;
+		break;
+	case OVCAMCHIP_CID_AUTOEXP:
+		rc = ov_write_mask(c, 0x28, v?0x00:0x10, 0x10);
+		s->auto_exp = v;
+		break;
+	case OVCAMCHIP_CID_BACKLIGHT:
+	{
+		rc = ov_write_mask(c, 0x4e, v?0x80:0x60, 0xe0);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write_mask(c, 0x29, v?0x08:0x00, 0x08);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write_mask(c, 0x28, v?0x02:0x00, 0x02);
+		s->backlight = v;
+		break;
+	}
+	case OVCAMCHIP_CID_MIRROR:
+		rc = ov_write_mask(c, 0x12, v?0x40:0x00, 0x40);
+		s->mirror = v;
+		break;
+	default:
+		DDEBUG(2, &c->dev, "control not supported: %d", ctl->id);
+		return -EPERM;
+	}
+
+out:
+	DDEBUG(3, &c->dev, "id=%d, arg=%d, rc=%d", ctl->id, v, rc);
+	return rc;
+}
+
+static int ov6x30_get_control(struct i2c_client *c,
+			      struct ovcamchip_control *ctl)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov6x30 *s = ov->spriv;
+	int rc = 0;
+	unsigned char val = 0;
+
+	switch (ctl->id) {
+	case OVCAMCHIP_CID_CONT:
+		rc = ov_read(c, REG_CNT, &val);
+		ctl->value = (val & 0x0f) << 12;
+		break;
+	case OVCAMCHIP_CID_BRIGHT:
+		rc = ov_read(c, REG_BRT, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_SAT:
+		rc = ov_read(c, REG_SAT, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_HUE:
+		rc = ov_read(c, REG_BLUE, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_EXP:
+		rc = ov_read(c, REG_EXP, &val);
+		ctl->value = val;
+		break;
+	case OVCAMCHIP_CID_BANDFILT:
+		ctl->value = s->bandfilt;
+		break;
+	case OVCAMCHIP_CID_AUTOBRIGHT:
+		ctl->value = s->auto_brt;
+		break;
+	case OVCAMCHIP_CID_AUTOEXP:
+		ctl->value = s->auto_exp;
+		break;
+	case OVCAMCHIP_CID_BACKLIGHT:
+		ctl->value = s->backlight;
+		break;
+	case OVCAMCHIP_CID_MIRROR:
+		ctl->value = s->mirror;
+		break;
+	default:
+		DDEBUG(2, &c->dev, "control not supported: %d", ctl->id);
+		return -EPERM;
+	}
+
+	DDEBUG(3, &c->dev, "id=%d, arg=%d, rc=%d", ctl->id, ctl->value, rc);
+	return rc;
+}
+
+static int ov6x30_mode_init(struct i2c_client *c, struct ovcamchip_window *win)
+{
+	/******** QCIF-specific regs ********/
+
+	ov_write_mask(c, 0x14, win->quarter?0x20:0x00, 0x20);
+
+	/******** Palette-specific regs ********/
+
+	if (win->format == VIDEO_PALETTE_GREY) {
+		if (c->adapter->id == (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518)) {
+			/* Do nothing - we're already in 8-bit mode */
+		} else {
+			ov_write_mask(c, 0x13, 0x20, 0x20);
+		}
+	} else {
+		/* The OV518 needs special treatment. Although both the OV518
+		 * and the OV6630 support a 16-bit video bus, only the 8 bit Y
+		 * bus is actually used. The UV bus is tied to ground.
+		 * Therefore, the OV6630 needs to be in 8-bit multiplexed
+		 * output mode */
+
+		if (c->adapter->id == (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518)) {
+			/* Do nothing - we want to stay in 8-bit mode */
+			/* Warning: Messing with reg 0x13 breaks OV518 color */
+		} else {
+			ov_write_mask(c, 0x13, 0x00, 0x20);
+		}
+	}
+
+	/******** Clock programming ********/
+
+	ov_write(c, 0x11, win->clockdiv);
+
+	return 0;
+}
+
+static int ov6x30_set_window(struct i2c_client *c, struct ovcamchip_window *win)
+{
+	int ret, hwscale, vwscale;
+
+	ret = ov6x30_mode_init(c, win);
+	if (ret < 0)
+		return ret;
+
+	if (win->quarter) {
+		hwscale = 0;
+		vwscale = 0;
+	} else {
+		hwscale = 1;
+		vwscale = 1;	/* The datasheet says 0; it's wrong */
+	}
+
+	ov_write(c, 0x17, HWSBASE + (win->x >> hwscale));
+	ov_write(c, 0x18, HWEBASE + ((win->x + win->width) >> hwscale));
+	ov_write(c, 0x19, VWSBASE + (win->y >> vwscale));
+	ov_write(c, 0x1a, VWEBASE + ((win->y + win->height) >> vwscale));
+
+	return 0;
+}
+
+static int ov6x30_command(struct i2c_client *c, unsigned int cmd, void *arg)
+{
+	switch (cmd) {
+	case OVCAMCHIP_CMD_S_CTRL:
+		return ov6x30_set_control(c, arg);
+	case OVCAMCHIP_CMD_G_CTRL:
+		return ov6x30_get_control(c, arg);
+	case OVCAMCHIP_CMD_S_MODE:
+		return ov6x30_set_window(c, arg);
+	default:
+		DDEBUG(2, &c->dev, "command not supported: %d", cmd);
+		return -ENOIOCTLCMD;
+	}
+}
+
+struct ovcamchip_ops ov6x30_ops = {
+	.init    =	ov6x30_init,
+	.free    =	ov6x30_free,
+	.command =	ov6x30_command,
+};
diff -Nur old/drivers/media/video/ovcamchip/ov76be.c new/drivers/media/video/ovcamchip/ov76be.c
--- old/drivers/media/video/ovcamchip/ov76be.c	1969-12-31 16:00:00.000000000 -0800
+++ new/drivers/media/video/ovcamchip/ov76be.c	2004-06-17 03:32:08.000000000 -0700
@@ -0,0 +1,303 @@
+/* OmniVision OV76BE Camera Chip Support Code
+ *
+ * Copyright (c) 1999-2004 Mark McClelland <mark@alpha.dyndns.org>
+ * http://alpha.dyndns.org/ov511/
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version. NO WARRANTY OF ANY KIND is expressed or implied.
+ */
+
+#define DEBUG
+
+#include <linux/slab.h>
+#include "ovcamchip_priv.h"
+
+/* OV7610 registers: Since the OV76BE is undocumented, we'll settle for these
+ * for now. */
+#define REG_GAIN		0x00	/* gain [5:0] */
+#define REG_BLUE		0x01	/* blue channel balance */
+#define REG_RED			0x02	/* red channel balance */
+#define REG_SAT			0x03	/* saturation */
+#define REG_CNT			0x05	/* Y contrast */
+#define REG_BRT			0x06	/* Y brightness */
+#define REG_BLUE_BIAS		0x0C	/* blue channel bias [5:0] */
+#define REG_RED_BIAS		0x0D	/* red channel bias [5:0] */
+#define REG_GAMMA_COEFF		0x0E	/* gamma settings */
+#define REG_WB_RANGE		0x0F	/* AEC/ALC/S-AWB settings */
+#define REG_EXP			0x10	/* manual exposure setting */
+#define REG_CLOCK		0x11	/* polarity/clock prescaler */
+#define REG_FIELD_DIVIDE	0x16	/* field interval/mode settings */
+#define REG_HWIN_START		0x17	/* horizontal window start */
+#define REG_HWIN_END		0x18	/* horizontal window end */
+#define REG_VWIN_START		0x19	/* vertical window start */
+#define REG_VWIN_END		0x1A	/* vertical window end */
+#define REG_PIXEL_SHIFT   	0x1B	/* pixel shift */
+#define REG_YOFFSET		0x21	/* Y channel offset */
+#define REG_UOFFSET		0x22	/* U channel offset */
+#define REG_ECW			0x24	/* exposure white level for AEC */
+#define REG_ECB			0x25	/* exposure black level for AEC */
+#define REG_FRAMERATE_H		0x2A	/* frame rate MSB + misc */
+#define REG_FRAMERATE_L		0x2B	/* frame rate LSB */
+#define REG_ALC			0x2C	/* Auto Level Control settings */
+#define REG_VOFFSET		0x2E	/* V channel offset adjustment */
+#define REG_ARRAY_BIAS		0x2F	/* array bias -- don't change */
+#define REG_YGAMMA		0x33	/* misc gamma settings [7:6] */
+#define REG_BIAS_ADJUST		0x34	/* misc bias settings */
+
+/* Window parameters */
+#define HWSBASE 0x38
+#define HWEBASE 0x3a
+#define VWSBASE 0x05
+#define VWEBASE 0x05
+
+struct ov76be {
+	int auto_brt;
+	int auto_exp;
+	int bandfilt;
+	int mirror;
+};
+
+/* NOTE: These are the same as the 7x10 settings, but should eventually be
+ * optimized for the OV76BE */
+static struct ovcamchip_regvals regvals_init_76be[] = {
+	{ 0x10, 0xff },
+	{ 0x16, 0x03 },
+	{ 0x28, 0x24 },
+	{ 0x2b, 0xac },
+	{ 0x12, 0x00 },
+	{ 0x38, 0x81 },
+	{ 0x28, 0x24 },	/* 0c */
+	{ 0x0f, 0x85 },	/* lg's setting */
+	{ 0x15, 0x01 },
+	{ 0x20, 0x1c },
+	{ 0x23, 0x2a },
+	{ 0x24, 0x10 },
+	{ 0x25, 0x8a },
+	{ 0x26, 0xa2 },
+	{ 0x27, 0xc2 },
+	{ 0x2a, 0x04 },
+	{ 0x2c, 0xfe },
+	{ 0x2d, 0x93 },
+	{ 0x30, 0x71 },
+	{ 0x31, 0x60 },
+	{ 0x32, 0x26 },
+	{ 0x33, 0x20 },
+	{ 0x34, 0x48 },
+	{ 0x12, 0x24 },
+	{ 0x11, 0x01 },
+	{ 0x0c, 0x24 },
+	{ 0x0d, 0x24 },
+	{ 0xff, 0xff },	/* END MARKER */
+};
+
+/* This initializes the OV76be camera chip and relevant variables. */
+static int ov76be_init(struct i2c_client *c)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov76be *s;
+	int rc;
+
+	DDEBUG(4, &c->dev, "entered");
+
+	rc = ov_write_regvals(c, regvals_init_76be);
+	if (rc < 0)
+		return rc;
+
+	ov->spriv = s = kmalloc(sizeof *s, GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+	memset(s, 0, sizeof *s);
+
+	s->auto_brt = 1;
+	s->auto_exp = 1;
+
+	return rc;
+}
+
+static int ov76be_free(struct i2c_client *c)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+
+	kfree(ov->spriv);
+	return 0;
+}
+
+static int ov76be_set_control(struct i2c_client *c,
+			      struct ovcamchip_control *ctl)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov76be *s = ov->spriv;
+	int rc;
+	int v = ctl->value;
+
+	switch (ctl->id) {
+	case OVCAMCHIP_CID_BRIGHT:
+		rc = ov_write(c, REG_BRT, v >> 8);
+		break;
+	case OVCAMCHIP_CID_SAT:
+		rc = ov_write(c, REG_SAT, v >> 8);
+		break;
+	case OVCAMCHIP_CID_EXP:
+		rc = ov_write(c, REG_EXP, v);
+		break;
+	case OVCAMCHIP_CID_FREQ:
+	{
+		int sixty = (v == 60);
+
+		rc = ov_write_mask(c, 0x2a, sixty?0x00:0x80, 0x80);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write(c, 0x2b, sixty?0x00:0xac);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write_mask(c, 0x76, 0x01, 0x01);
+		break;
+	}
+	case OVCAMCHIP_CID_BANDFILT:
+		rc = ov_write_mask(c, 0x2d, v?0x04:0x00, 0x04);
+		s->bandfilt = v;
+		break;
+	case OVCAMCHIP_CID_AUTOBRIGHT:
+		rc = ov_write_mask(c, 0x2d, v?0x10:0x00, 0x10);
+		s->auto_brt = v;
+		break;
+	case OVCAMCHIP_CID_AUTOEXP:
+		rc = ov_write_mask(c, 0x13, v?0x01:0x00, 0x01);
+		s->auto_exp = v;
+		break;
+	case OVCAMCHIP_CID_MIRROR:
+		rc = ov_write_mask(c, 0x12, v?0x40:0x00, 0x40);
+		s->mirror = v;
+		break;
+	default:
+		DDEBUG(2, &c->dev, "control not supported: %d", ctl->id);
+		return -EPERM;
+	}
+
+out:
+	DDEBUG(3, &c->dev, "id=%d, arg=%d, rc=%d", ctl->id, v, rc);
+	return rc;
+}
+
+static int ov76be_get_control(struct i2c_client *c,
+			      struct ovcamchip_control *ctl)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov76be *s = ov->spriv;
+	int rc = 0;
+	unsigned char val = 0;
+
+	switch (ctl->id) {
+	case OVCAMCHIP_CID_BRIGHT:
+		rc = ov_read(c, REG_BRT, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_SAT:
+		rc = ov_read(c, REG_SAT, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_EXP:
+		rc = ov_read(c, REG_EXP, &val);
+		ctl->value = val;
+		break;
+	case OVCAMCHIP_CID_BANDFILT:
+		ctl->value = s->bandfilt;
+		break;
+	case OVCAMCHIP_CID_AUTOBRIGHT:
+		ctl->value = s->auto_brt;
+		break;
+	case OVCAMCHIP_CID_AUTOEXP:
+		ctl->value = s->auto_exp;
+		break;
+	case OVCAMCHIP_CID_MIRROR:
+		ctl->value = s->mirror;
+		break;
+	default:
+		DDEBUG(2, &c->dev, "control not supported: %d", ctl->id);
+		return -EPERM;
+	}
+
+	DDEBUG(3, &c->dev, "id=%d, arg=%d, rc=%d", ctl->id, ctl->value, rc);
+	return rc;
+}
+
+static int ov76be_mode_init(struct i2c_client *c, struct ovcamchip_window *win)
+{
+	int qvga = win->quarter;
+
+	/******** QVGA-specific regs ********/
+
+	ov_write(c, 0x14, qvga?0xa4:0x84);
+
+	/******** Palette-specific regs ********/
+
+	if (win->format == VIDEO_PALETTE_GREY) {
+		ov_write_mask(c, 0x0e, 0x40, 0x40);
+		ov_write_mask(c, 0x13, 0x20, 0x20);
+	} else {
+		ov_write_mask(c, 0x0e, 0x00, 0x40);
+		ov_write_mask(c, 0x13, 0x00, 0x20);
+	}
+
+	/******** Clock programming ********/
+
+	ov_write(c, 0x11, win->clockdiv);
+
+	/******** Resolution-specific ********/
+
+	if (win->width == 640 && win->height == 480)
+		ov_write(c, 0x35, 0x9e);
+	else
+		ov_write(c, 0x35, 0x1e);
+
+	return 0;
+}
+
+static int ov76be_set_window(struct i2c_client *c, struct ovcamchip_window *win)
+{
+	int ret, hwscale, vwscale;
+
+	ret = ov76be_mode_init(c, win);
+	if (ret < 0)
+		return ret;
+
+	if (win->quarter) {
+		hwscale = 1;
+		vwscale = 0;
+	} else {
+		hwscale = 2;
+		vwscale = 1;
+	}
+
+	ov_write(c, 0x17, HWSBASE + (win->x >> hwscale));
+	ov_write(c, 0x18, HWEBASE + ((win->x + win->width) >> hwscale));
+	ov_write(c, 0x19, VWSBASE + (win->y >> vwscale));
+	ov_write(c, 0x1a, VWEBASE + ((win->y + win->height) >> vwscale));
+
+	return 0;
+}
+
+static int ov76be_command(struct i2c_client *c, unsigned int cmd, void *arg)
+{
+	switch (cmd) {
+	case OVCAMCHIP_CMD_S_CTRL:
+		return ov76be_set_control(c, arg);
+	case OVCAMCHIP_CMD_G_CTRL:
+		return ov76be_get_control(c, arg);
+	case OVCAMCHIP_CMD_S_MODE:
+		return ov76be_set_window(c, arg);
+	default:
+		DDEBUG(2, &c->dev, "command not supported: %d", cmd);
+		return -ENOIOCTLCMD;
+	}
+}
+
+struct ovcamchip_ops ov76be_ops = {
+	.init    =	ov76be_init,
+	.free    =	ov76be_free,
+	.command =	ov76be_command,
+};
diff -Nur old/drivers/media/video/ovcamchip/ov7x10.c new/drivers/media/video/ovcamchip/ov7x10.c
--- old/drivers/media/video/ovcamchip/ov7x10.c	1969-12-31 16:00:00.000000000 -0800
+++ new/drivers/media/video/ovcamchip/ov7x10.c	2004-06-17 03:32:19.000000000 -0700
@@ -0,0 +1,335 @@
+/* OmniVision OV7610/OV7110 Camera Chip Support Code
+ *
+ * Copyright (c) 1999-2004 Mark McClelland <mark@alpha.dyndns.org>
+ * http://alpha.dyndns.org/ov511/
+ *
+ * Color fixes by by Orion Sky Lawlor <olawlor@acm.org> (2/26/2000)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version. NO WARRANTY OF ANY KIND is expressed or implied.
+ */
+
+#define DEBUG
+
+#include <linux/slab.h>
+#include "ovcamchip_priv.h"
+
+/* Registers */
+#define REG_GAIN		0x00	/* gain [5:0] */
+#define REG_BLUE		0x01	/* blue channel balance */
+#define REG_RED			0x02	/* red channel balance */
+#define REG_SAT			0x03	/* saturation */
+#define REG_CNT			0x05	/* Y contrast */
+#define REG_BRT			0x06	/* Y brightness */
+#define REG_BLUE_BIAS		0x0C	/* blue channel bias [5:0] */
+#define REG_RED_BIAS		0x0D	/* red channel bias [5:0] */
+#define REG_GAMMA_COEFF		0x0E	/* gamma settings */
+#define REG_WB_RANGE		0x0F	/* AEC/ALC/S-AWB settings */
+#define REG_EXP			0x10	/* manual exposure setting */
+#define REG_CLOCK		0x11	/* polarity/clock prescaler */
+#define REG_FIELD_DIVIDE	0x16	/* field interval/mode settings */
+#define REG_HWIN_START		0x17	/* horizontal window start */
+#define REG_HWIN_END		0x18	/* horizontal window end */
+#define REG_VWIN_START		0x19	/* vertical window start */
+#define REG_VWIN_END		0x1A	/* vertical window end */
+#define REG_PIXEL_SHIFT   	0x1B	/* pixel shift */
+#define REG_YOFFSET		0x21	/* Y channel offset */
+#define REG_UOFFSET		0x22	/* U channel offset */
+#define REG_ECW			0x24	/* exposure white level for AEC */
+#define REG_ECB			0x25	/* exposure black level for AEC */
+#define REG_FRAMERATE_H		0x2A	/* frame rate MSB + misc */
+#define REG_FRAMERATE_L		0x2B	/* frame rate LSB */
+#define REG_ALC			0x2C	/* Auto Level Control settings */
+#define REG_VOFFSET		0x2E	/* V channel offset adjustment */
+#define REG_ARRAY_BIAS		0x2F	/* array bias -- don't change */
+#define REG_YGAMMA		0x33	/* misc gamma settings [7:6] */
+#define REG_BIAS_ADJUST		0x34	/* misc bias settings */
+
+/* Window parameters */
+#define HWSBASE 0x38
+#define HWEBASE 0x3a
+#define VWSBASE 0x05
+#define VWEBASE 0x05
+
+struct ov7x10 {
+	int auto_brt;
+	int auto_exp;
+	int bandfilt;
+	int mirror;
+};
+
+/* Lawrence Glaister <lg@jfm.bc.ca> reports:
+ *
+ * Register 0x0f in the 7610 has the following effects:
+ *
+ * 0x85 (AEC method 1): Best overall, good contrast range
+ * 0x45 (AEC method 2): Very overexposed
+ * 0xa5 (spec sheet default): Ok, but the black level is
+ *	shifted resulting in loss of contrast
+ * 0x05 (old driver setting): very overexposed, too much
+ *	contrast
+ */
+static struct ovcamchip_regvals regvals_init_7x10[] = {
+	{ 0x10, 0xff },
+	{ 0x16, 0x03 },
+	{ 0x28, 0x24 },
+	{ 0x2b, 0xac },
+	{ 0x12, 0x00 },
+	{ 0x38, 0x81 },
+	{ 0x28, 0x24 },	/* 0c */
+	{ 0x0f, 0x85 },	/* lg's setting */
+	{ 0x15, 0x01 },
+	{ 0x20, 0x1c },
+	{ 0x23, 0x2a },
+	{ 0x24, 0x10 },
+	{ 0x25, 0x8a },
+	{ 0x26, 0xa2 },
+	{ 0x27, 0xc2 },
+	{ 0x2a, 0x04 },
+	{ 0x2c, 0xfe },
+	{ 0x2d, 0x93 },
+	{ 0x30, 0x71 },
+	{ 0x31, 0x60 },
+	{ 0x32, 0x26 },
+	{ 0x33, 0x20 },
+	{ 0x34, 0x48 },
+	{ 0x12, 0x24 },
+	{ 0x11, 0x01 },
+	{ 0x0c, 0x24 },
+	{ 0x0d, 0x24 },
+	{ 0xff, 0xff },	/* END MARKER */
+};
+
+/* This initializes the OV7x10 camera chip and relevant variables. */
+static int ov7x10_init(struct i2c_client *c)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov7x10 *s;
+	int rc;
+
+	DDEBUG(4, &c->dev, "entered");
+
+	rc = ov_write_regvals(c, regvals_init_7x10);
+	if (rc < 0)
+		return rc;
+
+	ov->spriv = s = kmalloc(sizeof *s, GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+	memset(s, 0, sizeof *s);
+
+	s->auto_brt = 1;
+	s->auto_exp = 1;
+
+	return rc;
+}
+
+static int ov7x10_free(struct i2c_client *c)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+
+	kfree(ov->spriv);
+	return 0;
+}
+
+static int ov7x10_set_control(struct i2c_client *c,
+			      struct ovcamchip_control *ctl)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov7x10 *s = ov->spriv;
+	int rc;
+	int v = ctl->value;
+
+	switch (ctl->id) {
+	case OVCAMCHIP_CID_CONT:
+		rc = ov_write(c, REG_CNT, v >> 8);
+		break;
+	case OVCAMCHIP_CID_BRIGHT:
+		rc = ov_write(c, REG_BRT, v >> 8);
+		break;
+	case OVCAMCHIP_CID_SAT:
+		rc = ov_write(c, REG_SAT, v >> 8);
+		break;
+	case OVCAMCHIP_CID_HUE:
+		rc = ov_write(c, REG_RED, 0xFF - (v >> 8));
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write(c, REG_BLUE, v >> 8);
+		break;
+	case OVCAMCHIP_CID_EXP:
+		rc = ov_write(c, REG_EXP, v);
+		break;
+	case OVCAMCHIP_CID_FREQ:
+	{
+		int sixty = (v == 60);
+
+		rc = ov_write_mask(c, 0x2a, sixty?0x00:0x80, 0x80);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write(c, 0x2b, sixty?0x00:0xac);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write_mask(c, 0x13, 0x10, 0x10);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write_mask(c, 0x13, 0x00, 0x10);
+		break;
+	}
+	case OVCAMCHIP_CID_BANDFILT:
+		rc = ov_write_mask(c, 0x2d, v?0x04:0x00, 0x04);
+		s->bandfilt = v;
+		break;
+	case OVCAMCHIP_CID_AUTOBRIGHT:
+		rc = ov_write_mask(c, 0x2d, v?0x10:0x00, 0x10);
+		s->auto_brt = v;
+		break;
+	case OVCAMCHIP_CID_AUTOEXP:
+		rc = ov_write_mask(c, 0x29, v?0x00:0x80, 0x80);
+		s->auto_exp = v;
+		break;
+	case OVCAMCHIP_CID_MIRROR:
+		rc = ov_write_mask(c, 0x12, v?0x40:0x00, 0x40);
+		s->mirror = v;
+		break;
+	default:
+		DDEBUG(2, &c->dev, "control not supported: %d", ctl->id);
+		return -EPERM;
+	}
+
+out:
+	DDEBUG(3, &c->dev, "id=%d, arg=%d, rc=%d", ctl->id, v, rc);
+	return rc;
+}
+
+static int ov7x10_get_control(struct i2c_client *c,
+			      struct ovcamchip_control *ctl)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov7x10 *s = ov->spriv;
+	int rc = 0;
+	unsigned char val = 0;
+
+	switch (ctl->id) {
+	case OVCAMCHIP_CID_CONT:
+		rc = ov_read(c, REG_CNT, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_BRIGHT:
+		rc = ov_read(c, REG_BRT, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_SAT:
+		rc = ov_read(c, REG_SAT, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_HUE:
+		rc = ov_read(c, REG_BLUE, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_EXP:
+		rc = ov_read(c, REG_EXP, &val);
+		ctl->value = val;
+		break;
+	case OVCAMCHIP_CID_BANDFILT:
+		ctl->value = s->bandfilt;
+		break;
+	case OVCAMCHIP_CID_AUTOBRIGHT:
+		ctl->value = s->auto_brt;
+		break;
+	case OVCAMCHIP_CID_AUTOEXP:
+		ctl->value = s->auto_exp;
+		break;
+	case OVCAMCHIP_CID_MIRROR:
+		ctl->value = s->mirror;
+		break;
+	default:
+		DDEBUG(2, &c->dev, "control not supported: %d", ctl->id);
+		return -EPERM;
+	}
+
+	DDEBUG(3, &c->dev, "id=%d, arg=%d, rc=%d", ctl->id, ctl->value, rc);
+	return rc;
+}
+
+static int ov7x10_mode_init(struct i2c_client *c, struct ovcamchip_window *win)
+{
+	int qvga = win->quarter;
+
+	/******** QVGA-specific regs ********/
+
+	ov_write(c, 0x14, qvga?0x24:0x04);
+
+	/******** Palette-specific regs ********/
+
+	if (win->format == VIDEO_PALETTE_GREY) {
+		ov_write_mask(c, 0x0e, 0x40, 0x40);
+		ov_write_mask(c, 0x13, 0x20, 0x20);
+	} else {
+		ov_write_mask(c, 0x0e, 0x00, 0x40);
+		ov_write_mask(c, 0x13, 0x00, 0x20);
+	}
+
+	/******** Clock programming ********/
+
+	ov_write(c, 0x11, win->clockdiv);
+
+	/******** Resolution-specific ********/
+
+	if (win->width == 640 && win->height == 480)
+		ov_write(c, 0x35, 0x9e);
+	else
+		ov_write(c, 0x35, 0x1e);
+
+	return 0;
+}
+
+static int ov7x10_set_window(struct i2c_client *c, struct ovcamchip_window *win)
+{
+	int ret, hwscale, vwscale;
+
+	ret = ov7x10_mode_init(c, win);
+	if (ret < 0)
+		return ret;
+
+	if (win->quarter) {
+		hwscale = 1;
+		vwscale = 0;
+	} else {
+		hwscale = 2;
+		vwscale = 1;
+	}
+
+	ov_write(c, 0x17, HWSBASE + (win->x >> hwscale));
+	ov_write(c, 0x18, HWEBASE + ((win->x + win->width) >> hwscale));
+	ov_write(c, 0x19, VWSBASE + (win->y >> vwscale));
+	ov_write(c, 0x1a, VWEBASE + ((win->y + win->height) >> vwscale));
+
+	return 0;
+}
+
+static int ov7x10_command(struct i2c_client *c, unsigned int cmd, void *arg)
+{
+	switch (cmd) {
+	case OVCAMCHIP_CMD_S_CTRL:
+		return ov7x10_set_control(c, arg);
+	case OVCAMCHIP_CMD_G_CTRL:
+		return ov7x10_get_control(c, arg);
+	case OVCAMCHIP_CMD_S_MODE:
+		return ov7x10_set_window(c, arg);
+	default:
+		DDEBUG(2, &c->dev, "command not supported: %d", cmd);
+		return -ENOIOCTLCMD;
+	}
+}
+
+struct ovcamchip_ops ov7x10_ops = {
+	.init    =	ov7x10_init,
+	.free    =	ov7x10_free,
+	.command =	ov7x10_command,
+};
diff -Nur old/drivers/media/video/ovcamchip/ov7x20.c new/drivers/media/video/ovcamchip/ov7x20.c
--- old/drivers/media/video/ovcamchip/ov7x20.c	1969-12-31 16:00:00.000000000 -0800
+++ new/drivers/media/video/ovcamchip/ov7x20.c	2004-06-17 03:32:25.000000000 -0700
@@ -0,0 +1,455 @@
+/* OmniVision OV7620/OV7120 Camera Chip Support Code
+ *
+ * Copyright (c) 1999-2004 Mark McClelland <mark@alpha.dyndns.org>
+ * http://alpha.dyndns.org/ov511/
+ *
+ * OV7620 fixes by Charl P. Botha <cpbotha@ieee.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version. NO WARRANTY OF ANY KIND is expressed or implied.
+ */
+
+#define DEBUG
+
+#include <linux/slab.h>
+#include "ovcamchip_priv.h"
+
+/* Registers */
+#define REG_GAIN		0x00	/* gain [5:0] */
+#define REG_BLUE		0x01	/* blue gain */
+#define REG_RED			0x02	/* red gain */
+#define REG_SAT			0x03	/* saturation */
+#define REG_BRT			0x06	/* Y brightness */
+#define REG_SHARP		0x07	/* analog sharpness */
+#define REG_BLUE_BIAS		0x0C	/* WB blue ratio [5:0] */
+#define REG_RED_BIAS		0x0D	/* WB red ratio [5:0] */
+#define REG_EXP			0x10	/* exposure */
+
+/* Default control settings. Values are in terms of V4L2 controls. */
+#define OV7120_DFL_BRIGHT     0x60
+#define OV7620_DFL_BRIGHT     0x60
+#define OV7120_DFL_SAT        0xb0
+#define OV7620_DFL_SAT        0xc0
+#define DFL_AUTO_EXP             1
+#define DFL_AUTO_GAIN            1
+#define OV7120_DFL_GAIN       0x00
+#define OV7620_DFL_GAIN       0x00
+/* NOTE: Since autoexposure is the default, these aren't programmed into the
+ * OV7x20 chip. They are just here because V4L2 expects a default */
+#define OV7120_DFL_EXP        0x7f
+#define OV7620_DFL_EXP        0x7f
+
+/* Window parameters */
+#define HWSBASE 0x2F	/* From 7620.SET (spec is wrong) */
+#define HWEBASE 0x2F
+#define VWSBASE 0x05
+#define VWEBASE 0x05
+
+struct ov7x20 {
+	int auto_brt;
+	int auto_exp;
+	int auto_gain;
+	int backlight;
+	int bandfilt;
+	int mirror;
+};
+
+/* Contrast look-up table */
+static unsigned char ctab[] = {
+	0x01, 0x05, 0x09, 0x11, 0x15, 0x35, 0x37, 0x57,
+	0x5b, 0xa5, 0xa7, 0xc7, 0xc9, 0xcf, 0xef, 0xff
+};
+
+/* Settings for (Black & White) OV7120 camera chip */
+static struct ovcamchip_regvals regvals_init_7120[] = {
+	{ 0x12, 0x80 }, /* reset */
+	{ 0x13, 0x00 }, /* Autoadjust off */
+	{ 0x12, 0x20 }, /* Disable AWB */
+	{ 0x13, DFL_AUTO_GAIN?0x01:0x00 }, /* Autoadjust on (if desired) */
+	{ 0x00, OV7120_DFL_GAIN },
+	{ 0x01, 0x80 },
+	{ 0x02, 0x80 },
+	{ 0x03, OV7120_DFL_SAT },
+	{ 0x06, OV7120_DFL_BRIGHT },
+	{ 0x07, 0x00 },
+	{ 0x0c, 0x20 },
+	{ 0x0d, 0x20 },
+	{ 0x11, 0x01 },
+	{ 0x14, 0x84 },
+	{ 0x15, 0x01 },
+	{ 0x16, 0x03 },
+	{ 0x17, 0x2f },
+	{ 0x18, 0xcf },
+	{ 0x19, 0x06 },
+	{ 0x1a, 0xf5 },
+	{ 0x1b, 0x00 },
+	{ 0x20, 0x08 },
+	{ 0x21, 0x80 },
+	{ 0x22, 0x80 },
+	{ 0x23, 0x00 },
+	{ 0x26, 0xa0 },
+	{ 0x27, 0xfa },
+	{ 0x28, 0x20 }, /* DON'T set bit 6. It is for the OV7620 only */
+	{ 0x29, DFL_AUTO_EXP?0x00:0x80 },
+	{ 0x2a, 0x10 },
+	{ 0x2b, 0x00 },
+	{ 0x2c, 0x88 },
+	{ 0x2d, 0x95 },
+	{ 0x2e, 0x80 },
+	{ 0x2f, 0x44 },
+	{ 0x60, 0x20 },
+	{ 0x61, 0x02 },
+	{ 0x62, 0x5f },
+	{ 0x63, 0xd5 },
+	{ 0x64, 0x57 },
+	{ 0x65, 0x83 }, /* OV says "don't change this value" */
+	{ 0x66, 0x55 },
+	{ 0x67, 0x92 },
+	{ 0x68, 0xcf },
+	{ 0x69, 0x76 },
+	{ 0x6a, 0x22 },
+	{ 0x6b, 0xe2 },
+	{ 0x6c, 0x40 },
+	{ 0x6d, 0x48 },
+	{ 0x6e, 0x80 },
+	{ 0x6f, 0x0d },
+	{ 0x70, 0x89 },
+	{ 0x71, 0x00 },
+	{ 0x72, 0x14 },
+	{ 0x73, 0x54 },
+	{ 0x74, 0xa0 },
+	{ 0x75, 0x8e },
+	{ 0x76, 0x00 },
+	{ 0x77, 0xff },
+	{ 0x78, 0x80 },
+	{ 0x79, 0x80 },
+	{ 0x7a, 0x80 },
+	{ 0x7b, 0xe6 },
+	{ 0x7c, 0x00 },
+	{ 0x24, 0x3a },
+	{ 0x25, 0x60 },
+	{ 0xff, 0xff },	/* END MARKER */
+};
+
+/* Settings for (color) OV7620 camera chip */
+static struct ovcamchip_regvals regvals_init_7620[] = {
+	{ 0x12, 0x80 }, /* reset */
+	{ 0x00, OV7620_DFL_GAIN },
+	{ 0x01, 0x80 },
+	{ 0x02, 0x80 },
+	{ 0x03, OV7620_DFL_SAT },
+	{ 0x06, OV7620_DFL_BRIGHT },
+	{ 0x07, 0x00 },
+	{ 0x0c, 0x24 },
+	{ 0x0c, 0x24 },
+	{ 0x0d, 0x24 },
+	{ 0x11, 0x01 },
+	{ 0x12, 0x24 },
+	{ 0x13, DFL_AUTO_GAIN?0x01:0x00 },
+	{ 0x14, 0x84 },
+	{ 0x15, 0x01 },
+	{ 0x16, 0x03 },
+	{ 0x17, 0x2f },
+	{ 0x18, 0xcf },
+	{ 0x19, 0x06 },
+	{ 0x1a, 0xf5 },
+	{ 0x1b, 0x00 },
+	{ 0x20, 0x18 },
+	{ 0x21, 0x80 },
+	{ 0x22, 0x80 },
+	{ 0x23, 0x00 },
+	{ 0x26, 0xa2 },
+	{ 0x27, 0xea },
+	{ 0x28, 0x20 },
+	{ 0x29, DFL_AUTO_EXP?0x00:0x80 },
+	{ 0x2a, 0x10 },
+	{ 0x2b, 0x00 },
+	{ 0x2c, 0x88 },
+	{ 0x2d, 0x91 },
+	{ 0x2e, 0x80 },
+	{ 0x2f, 0x44 },
+	{ 0x60, 0x27 },
+	{ 0x61, 0x02 },
+	{ 0x62, 0x5f },
+	{ 0x63, 0xd5 },
+	{ 0x64, 0x57 },
+	{ 0x65, 0x83 },
+	{ 0x66, 0x55 },
+	{ 0x67, 0x92 },
+	{ 0x68, 0xcf },
+	{ 0x69, 0x76 },
+	{ 0x6a, 0x22 },
+	{ 0x6b, 0x00 },
+	{ 0x6c, 0x02 },
+	{ 0x6d, 0x44 },
+	{ 0x6e, 0x80 },
+	{ 0x6f, 0x1d },
+	{ 0x70, 0x8b },
+	{ 0x71, 0x00 },
+	{ 0x72, 0x14 },
+	{ 0x73, 0x54 },
+	{ 0x74, 0x00 },
+	{ 0x75, 0x8e },
+	{ 0x76, 0x00 },
+	{ 0x77, 0xff },
+	{ 0x78, 0x80 },
+	{ 0x79, 0x80 },
+	{ 0x7a, 0x80 },
+	{ 0x7b, 0xe2 },
+	{ 0x7c, 0x00 },
+	{ 0xff, 0xff },	/* END MARKER */
+};
+
+/* Returns index into the specified look-up table, with 'n' elements, for which
+ * the value is greater than or equal to "val". If a match isn't found, (n-1)
+ * is returned. The entries in the table must be in ascending order. */
+static inline int ov7x20_lut_find(unsigned char lut[], int n, unsigned char val)
+{
+	int i = 0;
+
+	while (lut[i] < val && i < n)
+		i++;
+
+	return i;
+}
+
+/* This initializes the OV7x20 camera chip and relevant variables. */
+static int ov7x20_init(struct i2c_client *c)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov7x20 *s;
+	int rc;
+
+	DDEBUG(4, &c->dev, "entered");
+
+	if (ov->mono)
+		rc = ov_write_regvals(c, regvals_init_7120);
+	else
+		rc = ov_write_regvals(c, regvals_init_7620);
+
+	if (rc < 0)
+		return rc;
+
+	ov->spriv = s = kmalloc(sizeof *s, GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+	memset(s, 0, sizeof *s);
+
+	s->auto_brt = 1;
+	s->auto_exp = DFL_AUTO_EXP;
+	s->auto_gain = DFL_AUTO_GAIN;
+
+	return 0;
+}
+
+static int ov7x20_free(struct i2c_client *c)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+
+	kfree(ov->spriv);
+	return 0;
+}
+
+static int ov7x20_set_v4l1_control(struct i2c_client *c,
+				   struct ovcamchip_control *ctl)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov7x20 *s = ov->spriv;
+	int rc;
+	int v = ctl->value;
+
+	switch (ctl->id) {
+	case OVCAMCHIP_CID_CONT:
+	{
+		/* Use Y gamma control instead. Bit 0 enables it. */
+		rc = ov_write(c, 0x64, ctab[v >> 12]);
+		break;
+	}
+	case OVCAMCHIP_CID_BRIGHT:
+		/* 7620 doesn't like manual changes when in auto mode */
+		if (!s->auto_brt)
+			rc = ov_write(c, REG_BRT, v >> 8);
+		else
+			rc = 0;
+		break;
+	case OVCAMCHIP_CID_SAT:
+		rc = ov_write(c, REG_SAT, v >> 8);
+		break;
+	case OVCAMCHIP_CID_EXP:
+		if (!s->auto_exp)
+			rc = ov_write(c, REG_EXP, v);
+		else
+			rc = -EBUSY;
+		break;
+	case OVCAMCHIP_CID_FREQ:
+	{
+		int sixty = (v == 60);
+
+		rc = ov_write_mask(c, 0x2a, sixty?0x00:0x80, 0x80);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write(c, 0x2b, sixty?0x00:0xac);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write_mask(c, 0x76, 0x01, 0x01);
+		break;
+	}
+	case OVCAMCHIP_CID_BANDFILT:
+		rc = ov_write_mask(c, 0x2d, v?0x04:0x00, 0x04);
+		s->bandfilt = v;
+		break;
+	case OVCAMCHIP_CID_AUTOBRIGHT:
+		rc = ov_write_mask(c, 0x2d, v?0x10:0x00, 0x10);
+		s->auto_brt = v;
+		break;
+	case OVCAMCHIP_CID_AUTOEXP:
+		rc = ov_write_mask(c, 0x13, v?0x01:0x00, 0x01);
+		s->auto_exp = v;
+		break;
+	case OVCAMCHIP_CID_BACKLIGHT:
+	{
+		rc = ov_write_mask(c, 0x68, v?0xe0:0xc0, 0xe0);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write_mask(c, 0x29, v?0x08:0x00, 0x08);
+		if (rc < 0)
+			goto out;
+
+		rc = ov_write_mask(c, 0x28, v?0x02:0x00, 0x02);
+		s->backlight = v;
+		break;
+	}
+	case OVCAMCHIP_CID_MIRROR:
+		rc = ov_write_mask(c, 0x12, v?0x40:0x00, 0x40);
+		s->mirror = v;
+		break;
+	default:
+		DDEBUG(2, &c->dev, "control not supported: %d", ctl->id);
+		return -EPERM;
+	}
+
+out:
+	DDEBUG(3, &c->dev, "id=%d, arg=%d, rc=%d", ctl->id, v, rc);
+	return rc;
+}
+
+static int ov7x20_get_v4l1_control(struct i2c_client *c,
+				   struct ovcamchip_control *ctl)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	struct ov7x20 *s = ov->spriv;
+	int rc = 0;
+	unsigned char val = 0;
+
+	switch (ctl->id) {
+	case OVCAMCHIP_CID_CONT:
+		rc = ov_read(c, 0x64, &val);
+		ctl->value = ov7x20_lut_find(ctab, 16, val) << 12;
+		break;
+	case OVCAMCHIP_CID_BRIGHT:
+		rc = ov_read(c, REG_BRT, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_SAT:
+		rc = ov_read(c, REG_SAT, &val);
+		ctl->value = val << 8;
+		break;
+	case OVCAMCHIP_CID_EXP:
+		rc = ov_read(c, REG_EXP, &val);
+		ctl->value = val;
+		break;
+	case OVCAMCHIP_CID_BANDFILT:
+		ctl->value = s->bandfilt;
+		break;
+	case OVCAMCHIP_CID_AUTOBRIGHT:
+		ctl->value = s->auto_brt;
+		break;
+	case OVCAMCHIP_CID_AUTOEXP:
+		ctl->value = s->auto_exp;
+		break;
+	case OVCAMCHIP_CID_BACKLIGHT:
+		ctl->value = s->backlight;
+		break;
+	case OVCAMCHIP_CID_MIRROR:
+		ctl->value = s->mirror;
+		break;
+	default:
+		DDEBUG(2, &c->dev, "control not supported: %d", ctl->id);
+		return -EPERM;
+	}
+
+	DDEBUG(3, &c->dev, "id=%d, arg=%d, rc=%d", ctl->id, ctl->value, rc);
+	return rc;
+}
+
+static int ov7x20_mode_init(struct i2c_client *c, struct ovcamchip_window *win)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	int qvga = win->quarter;
+
+	/******** QVGA-specific regs ********/
+	ov_write_mask(c, 0x14, qvga?0x20:0x00, 0x20);
+	ov_write_mask(c, 0x28, qvga?0x00:0x20, 0x20);
+	ov_write(c, 0x24, qvga?0x20:0x3a);
+	ov_write(c, 0x25, qvga?0x30:0x60);
+	ov_write_mask(c, 0x2d, qvga?0x40:0x00, 0x40);
+	if (!ov->mono)
+		ov_write_mask(c, 0x67, qvga?0xf0:0x90, 0xf0);
+	ov_write_mask(c, 0x74, qvga?0x20:0x00, 0x20);
+
+	/******** Clock programming ********/
+
+	ov_write(c, 0x11, win->clockdiv);
+
+	return 0;
+}
+
+static int ov7x20_set_window(struct i2c_client *c, struct ovcamchip_window *win)
+{
+	int ret, hwscale, vwscale;
+
+	ret = ov7x20_mode_init(c, win);
+	if (ret < 0)
+		return ret;
+
+	if (win->quarter) {
+		hwscale = 1;
+		vwscale = 0;
+	} else {
+		hwscale = 2;
+		vwscale = 1;
+	}
+
+	ov_write(c, 0x17, HWSBASE + (win->x >> hwscale));
+	ov_write(c, 0x18, HWEBASE + ((win->x + win->width) >> hwscale));
+	ov_write(c, 0x19, VWSBASE + (win->y >> vwscale));
+	ov_write(c, 0x1a, VWEBASE + ((win->y + win->height) >> vwscale));
+
+	return 0;
+}
+
+static int ov7x20_command(struct i2c_client *c, unsigned int cmd, void *arg)
+{
+	switch (cmd) {
+	case OVCAMCHIP_CMD_S_CTRL:
+		return ov7x20_set_v4l1_control(c, arg);
+	case OVCAMCHIP_CMD_G_CTRL:
+		return ov7x20_get_v4l1_control(c, arg);
+	case OVCAMCHIP_CMD_S_MODE:
+		return ov7x20_set_window(c, arg);
+	default:
+		DDEBUG(2, &c->dev, "command not supported: %d", cmd);
+		return -ENOIOCTLCMD;
+	}
+}
+
+struct ovcamchip_ops ov7x20_ops = {
+	.init    =	ov7x20_init,
+	.free    =	ov7x20_free,
+	.command =	ov7x20_command,
+};
diff -Nur old/drivers/media/video/ovcamchip/ovcamchip_core.c new/drivers/media/video/ovcamchip/ovcamchip_core.c
--- old/drivers/media/video/ovcamchip/ovcamchip_core.c	1969-12-31 16:00:00.000000000 -0800
+++ new/drivers/media/video/ovcamchip/ovcamchip_core.c	2004-06-17 04:21:37.000000000 -0700
@@ -0,0 +1,446 @@
+/* Shared Code for OmniVision Camera Chip Drivers
+ *
+ * Copyright (c) 2004 Mark McClelland <mark@alpha.dyndns.org>
+ * http://alpha.dyndns.org/ov511/
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version. NO WARRANTY OF ANY KIND is expressed or implied.
+ */
+
+#define DEBUG
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include "ovcamchip_priv.h"
+
+#define DRIVER_VERSION "v2.27 for Linux 2.6"
+#define DRIVER_AUTHOR "Mark McClelland <mark@alpha.dyndns.org>"
+#define DRIVER_DESC "OV camera chip I2C driver"
+
+#define PINFO(fmt, args...) printk(KERN_INFO "ovcamchip: " fmt "\n" , ## args);
+#define PERROR(fmt, args...) printk(KERN_ERR "ovcamchip: " fmt "\n" , ## args);
+
+#ifdef DEBUG
+int ovcamchip_debug = 0;
+static int debug;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug,
+  "Debug level: 0=none, 1=inits, 2=warning, 3=config, 4=functions, 5=all");
+#endif
+
+/* By default, let bridge driver tell us if chip is monochrome. mono=0
+ * will ignore that and always treat chips as color. mono=1 will force
+ * monochrome mode for all chips. */
+static int mono = -1;
+module_param(mono, int, 0);
+MODULE_PARM_DESC(mono,
+  "1=chips are monochrome (OVx1xx), 0=force color, -1=autodetect (default)");
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+/* Registers common to all chips, that are needed for detection */
+#define GENERIC_REG_ID_HIGH       0x1C	/* manufacturer ID MSB */
+#define GENERIC_REG_ID_LOW        0x1D	/* manufacturer ID LSB */
+#define GENERIC_REG_COM_I         0x29	/* misc ID bits */
+
+extern struct ovcamchip_ops ov6x20_ops;
+extern struct ovcamchip_ops ov6x30_ops;
+extern struct ovcamchip_ops ov7x10_ops;
+extern struct ovcamchip_ops ov7x20_ops;
+extern struct ovcamchip_ops ov76be_ops;
+
+static char *chip_names[NUM_CC_TYPES] = {
+	[CC_UNKNOWN]	= "Unknown chip",
+	[CC_OV76BE]	= "OV76BE",
+	[CC_OV7610]	= "OV7610",
+	[CC_OV7620]	= "OV7620",
+	[CC_OV7620AE]	= "OV7620AE",
+	[CC_OV6620]	= "OV6620",
+	[CC_OV6630]	= "OV6630",
+	[CC_OV6630AE]	= "OV6630AE",
+	[CC_OV6630AF]	= "OV6630AF",
+};
+
+/* Forward declarations */
+static struct i2c_driver driver;
+static struct i2c_client client_template;
+
+/* ----------------------------------------------------------------------- */
+
+int ov_write_regvals(struct i2c_client *c, struct ovcamchip_regvals *rvals)
+{
+	int rc;
+
+	while (rvals->reg != 0xff) {
+		rc = ov_write(c, rvals->reg, rvals->val);
+		if (rc < 0)
+			return rc;
+		rvals++;
+	}
+
+	return 0;
+}
+
+/* Writes bits at positions specified by mask to an I2C reg. Bits that are in
+ * the same position as 1's in "mask" are cleared and set to "value". Bits
+ * that are in the same position as 0's in "mask" are preserved, regardless
+ * of their respective state in "value".
+ */
+int ov_write_mask(struct i2c_client *c,
+		  unsigned char reg,
+		  unsigned char value,
+		  unsigned char mask)
+{
+	int rc;
+	unsigned char oldval, newval;
+
+	if (mask == 0xff) {
+		newval = value;
+	} else {
+		rc = ov_read(c, reg, &oldval);
+		if (rc < 0)
+			return rc;
+
+		oldval &= (~mask);		/* Clear the masked bits */
+		value &= mask;			/* Enforce mask on value */
+		newval = oldval | value;	/* Set the desired bits */
+	}
+
+	return ov_write(c, reg, newval);
+}
+
+/* ----------------------------------------------------------------------- */
+
+/* Reset the chip and ensure that I2C is synchronized. Returns <0 if failure.
+ */
+static int init_camchip(struct i2c_client *c)
+{
+	int i, success;
+	unsigned char high, low;
+
+	/* Reset the chip */
+	ov_write(c, 0x12, 0x80);
+
+	/* Wait for it to initialize */
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(1 + 150 * HZ / 1000);
+
+	for (i = 0, success = 0; i < I2C_DETECT_RETRIES && !success; i++) {
+		if (ov_read(c, GENERIC_REG_ID_HIGH, &high) >= 0) {
+			if (ov_read(c, GENERIC_REG_ID_LOW, &low) >= 0) {
+				if (high == 0x7F && low == 0xA2) {
+					success = 1;
+					continue;
+				}
+			}
+		}
+
+		/* Reset the chip */
+		ov_write(c, 0x12, 0x80);
+
+		/* Wait for it to initialize */
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1 + 150 * HZ / 1000);
+
+		/* Dummy read to sync I2C */
+		ov_read(c, 0x00, &low);
+	}
+
+	if (!success)
+		return -EIO;
+
+	PDEBUG(1, "I2C synced in %d attempt(s)", i);
+
+	return 0;
+}
+
+/* This detects the OV7610, OV7620, or OV76BE chip. */
+static int ov7xx0_detect(struct i2c_client *c)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	int rc;
+	unsigned char val;
+
+	PDEBUG(4, "");
+
+	/* Detect chip (sub)type */
+	rc = ov_read(c, GENERIC_REG_COM_I, &val);
+	if (rc < 0) {
+		PERROR("Error detecting ov7xx0 type");
+		return rc;
+	} 
+
+	if ((val & 3) == 3) {
+		PINFO("Camera chip is an OV7610");
+		ov->subtype = CC_OV7610;
+	} else if ((val & 3) == 1) {
+		rc = ov_read(c, 0x15, &val);
+		if (rc < 0) {
+			PERROR("Error detecting ov7xx0 type");
+			return rc;
+		} 
+
+		if (val & 1) {
+			PINFO("Camera chip is an OV7620AE");
+			/* OV7620 is a close enough match for now. There are
+			 * some definite differences though, so this should be
+			 * fixed */
+			ov->subtype = CC_OV7620;
+		} else {
+			PINFO("Camera chip is an OV76BE");
+			ov->subtype = CC_OV76BE;
+		}
+	} else if ((val & 3) == 0) {
+		PINFO("Camera chip is an OV7620");
+		ov->subtype = CC_OV7620;
+	} else {
+		PERROR("Unknown camera chip version: %d", val & 3);
+		return -ENOSYS;
+	}
+
+	if (ov->subtype == CC_OV76BE)
+		ov->sops = &ov76be_ops;
+	else if (ov->subtype == CC_OV7620)
+		ov->sops = &ov7x20_ops;
+	else
+		ov->sops = &ov7x10_ops;
+
+	return 0;
+}
+
+/* This detects the OV6620, OV6630, OV6630AE, or OV6630AF chip. */
+static int ov6xx0_detect(struct i2c_client *c)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	int rc;
+	unsigned char val;
+
+	PDEBUG(4, "");
+
+	/* Detect chip (sub)type */
+	rc = ov_read(c, GENERIC_REG_COM_I, &val);
+	if (rc < 0) {
+		PERROR("Error detecting ov6xx0 type");
+		return -1;
+	}
+
+	if ((val & 3) == 0) {
+		ov->subtype = CC_OV6630;
+		PINFO("Camera chip is an OV6630");
+	} else if ((val & 3) == 1) {
+		ov->subtype = CC_OV6620;
+		PINFO("Camera chip is an OV6620");
+	} else if ((val & 3) == 2) {
+		ov->subtype = CC_OV6630;
+		PINFO("Camera chip is an OV6630AE");
+	} else if ((val & 3) == 3) {
+		ov->subtype = CC_OV6630;
+		PINFO("Camera chip is an OV6630AF");
+	}
+
+	if (ov->subtype == CC_OV6620)
+		ov->sops = &ov6x20_ops;
+	else
+		ov->sops = &ov6x30_ops;
+
+	return 0;
+}
+
+static int ovcamchip_detect(struct i2c_client *c)
+{
+	/* Ideally we would just try a single register write and see if it NAKs.
+	 * That isn't possible since the OV518 can't report I2C transaction
+	 * failures. So, we have to try to initialize the chip (i.e. reset it
+	 * and check the ID registers) to detect its presence. */
+
+	/* Test for 7xx0 */
+	PDEBUG(3, "Testing for 0V7xx0");
+	c->addr = OV7xx0_SID;
+	if (init_camchip(c) < 0) {
+		/* Test for 6xx0 */
+		PDEBUG(3, "Testing for 0V6xx0");
+		c->addr = OV6xx0_SID;
+		if (init_camchip(c) < 0) {
+ 			return -ENODEV;
+		} else {
+			if (ov6xx0_detect(c) < 0) {
+				PERROR("Failed to init OV6xx0");
+ 				return -EIO;
+			}
+		}
+	} else {
+		if (ov7xx0_detect(c) < 0) {
+			PERROR("Failed to init OV7xx0");
+ 			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+/* ----------------------------------------------------------------------- */
+
+static int ovcamchip_attach(struct i2c_adapter *adap)
+{
+	int rc = 0;
+	struct ovcamchip *ov;
+	struct i2c_client *c;
+
+	/* I2C is not a PnP bus, so we can never be certain that we're talking
+	 * to the right chip. To prevent damage to EEPROMS and such, only
+	 * attach to adapters that are known to contain OV camera chips. */
+
+	switch (adap->id) {
+	case (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV511):
+	case (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OV518):
+	case (I2C_ALGO_SMBUS | I2C_HW_SMBUS_OVFX2):
+	case (I2C_ALGO_SMBUS | I2C_HW_SMBUS_W9968CF):
+		PDEBUG(1, "Adapter ID 0x%06x accepted", adap->id);
+		break;
+	default:
+		PDEBUG(1, "Adapter ID 0x%06x rejected", adap->id);
+		return -ENODEV;
+	}
+
+	c = kmalloc(sizeof *c, GFP_KERNEL);
+	if (!c) {
+		rc = -ENOMEM;
+		goto no_client;
+	}
+	memcpy(c, &client_template, sizeof *c);
+	c->adapter = adap;
+	strcpy(i2c_clientname(c), "OV????");
+
+	ov = kmalloc(sizeof *ov, GFP_KERNEL);
+	if (!ov) {
+		rc = -ENOMEM;
+		goto no_ov;
+	}
+	memset(ov, 0, sizeof *ov);
+	i2c_set_clientdata(c, ov);
+
+	rc = ovcamchip_detect(c);
+	if (rc < 0)
+		goto error;
+
+	strcpy(i2c_clientname(c), chip_names[ov->subtype]);
+
+	PDEBUG(1, "Camera chip detection complete");
+
+	i2c_attach_client(c);
+
+	return rc;
+error:
+	kfree(ov);
+no_ov:
+	kfree(c);
+no_client:
+	PDEBUG(1, "returning %d", rc);
+	return rc;
+}
+
+static int ovcamchip_detach(struct i2c_client *c)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+	int rc;
+
+	rc = ov->sops->free(c);
+	if (rc < 0)
+		return rc;
+
+	i2c_detach_client(c);
+
+	kfree(ov);
+	kfree(c);
+	return 0;
+}
+
+static int ovcamchip_command(struct i2c_client *c, unsigned int cmd, void *arg)
+{
+	struct ovcamchip *ov = i2c_get_clientdata(c);
+
+	if (!ov->initialized &&
+	    cmd != OVCAMCHIP_CMD_Q_SUBTYPE &&
+	    cmd != OVCAMCHIP_CMD_INITIALIZE) {
+		dev_err(&c->dev, "ERROR: Camera chip not initialized yet!\n");
+		return -EPERM;
+	}
+
+	switch (cmd) {
+	case OVCAMCHIP_CMD_Q_SUBTYPE:
+	{
+		*(int *)arg = ov->subtype;
+		return 0;
+	}
+	case OVCAMCHIP_CMD_INITIALIZE:
+	{
+		int rc;
+
+		if (mono == -1)
+			ov->mono = *(int *)arg;
+		else
+			ov->mono = mono;
+
+		if (ov->mono) {
+			if (ov->subtype != CC_OV7620)
+				dev_warn(&c->dev, "Warning: Monochrome not "
+					"implemented for this chip\n");
+			else
+				dev_info(&c->dev, "Initializing chip as "
+					"monochrome\n");
+		}
+
+		rc = ov->sops->init(c);
+		if (rc < 0)
+			return rc;
+
+		ov->initialized = 1;
+		return 0;		
+	}
+	default:
+		return ov->sops->command(c, cmd, arg);
+	}
+}
+
+/* ----------------------------------------------------------------------- */
+
+static struct i2c_driver driver = {
+	.owner =		THIS_MODULE,
+	.name =			"ovcamchip",
+	.id =			I2C_DRIVERID_OVCAMCHIP,
+	.class =		I2C_CLASS_CAM_DIGITAL,
+	.flags =		I2C_DF_NOTIFY,
+	.attach_adapter =	ovcamchip_attach,
+	.detach_client =	ovcamchip_detach,
+	.command =		ovcamchip_command,
+};
+
+static struct i2c_client client_template = {
+	I2C_DEVNAME("(unset)"),
+	.id =		-1,
+	.driver =	&driver,
+};
+
+static int __init ovcamchip_init(void)
+{
+#ifdef DEBUG
+	ovcamchip_debug = debug;
+#endif
+
+	PINFO(DRIVER_VERSION " : " DRIVER_DESC);
+	return i2c_add_driver(&driver);
+}
+
+static void __exit ovcamchip_exit(void)
+{
+	i2c_del_driver(&driver);
+}
+
+module_init(ovcamchip_init);
+module_exit(ovcamchip_exit);
diff -Nur old/drivers/media/video/ovcamchip/ovcamchip_priv.h new/drivers/media/video/ovcamchip/ovcamchip_priv.h
--- old/drivers/media/video/ovcamchip/ovcamchip_priv.h	1969-12-31 16:00:00.000000000 -0800
+++ new/drivers/media/video/ovcamchip/ovcamchip_priv.h	2004-06-17 03:38:55.000000000 -0700
@@ -0,0 +1,87 @@
+/* OmniVision* camera chip driver private definitions for core code and
+ * chip-specific code
+ *
+ * Copyright (c) 1999-2004 Mark McClelland
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version. NO WARRANTY OF ANY KIND is expressed or implied.
+ *
+ * * OmniVision is a trademark of OmniVision Technologies, Inc. This driver
+ * is not sponsored or developed by them.
+ */
+
+#ifndef __LINUX_OVCAMCHIP_PRIV_H
+#define __LINUX_OVCAMCHIP_PRIV_H
+
+#include <media/ovcamchip.h>
+
+#ifdef DEBUG
+extern int ovcamchip_debug;
+#endif
+
+#define PDEBUG(level, fmt, args...) \
+	if (ovcamchip_debug >= (level))	pr_debug("[%s:%d] " fmt "\n", \
+		__FUNCTION__, __LINE__ , ## args)
+
+#define DDEBUG(level, dev, fmt, args...) \
+	if (ovcamchip_debug >= (level))	dev_dbg(dev, "[%s:%d] " fmt "\n", \
+		__FUNCTION__, __LINE__ , ## args)
+
+/* Number of times to retry chip detection. Increase this if you are getting
+ * "Failed to init camera chip" */
+#define I2C_DETECT_RETRIES	10
+
+struct ovcamchip_regvals {
+	unsigned char reg;
+	unsigned char val;
+};
+
+struct ovcamchip_ops {
+	int (*init)(struct i2c_client *);
+	int (*free)(struct i2c_client *);
+	int (*command)(struct i2c_client *, unsigned int, void *);
+};
+
+struct ovcamchip {
+	struct ovcamchip_ops *sops;
+	void *spriv;               /* Private data for OV7x10.c etc... */
+	int subtype;               /* = SEN_OV7610 etc... */
+	int mono;                  /* Monochrome chip? (invalid until init) */
+	int initialized;           /* OVCAMCHIP_CMD_INITIALIZE was successful */
+};
+
+/* --------------------------------- */
+/*              I2C I/O              */
+/* --------------------------------- */
+
+static inline int ov_read(struct i2c_client *c, unsigned char reg,
+			  unsigned char *value)
+{	
+	int rc;
+	
+	rc = i2c_smbus_read_byte_data(c, reg);
+	*value = (unsigned char) rc;
+	return rc;
+}
+
+static inline int ov_write(struct i2c_client *c, unsigned char reg,
+			   unsigned char value )
+{
+	return i2c_smbus_write_byte_data(c, reg, value);
+}
+
+/* --------------------------------- */
+/*        FUNCTION PROTOTYPES        */
+/* --------------------------------- */
+
+/* Functions in ovcamchip_core.c */
+
+extern int ov_write_regvals(struct i2c_client *c,
+			    struct ovcamchip_regvals *rvals);
+
+extern int ov_write_mask(struct i2c_client *c, unsigned char reg,
+	      		 unsigned char value, unsigned char mask);
+
+#endif
diff -Nur old/include/media/ovcamchip.h new/include/media/ovcamchip.h
--- old/include/media/ovcamchip.h	1969-12-31 16:00:00.000000000 -0800
+++ new/include/media/ovcamchip.h	2004-05-08 00:15:49.000000000 -0700
@@ -0,0 +1,104 @@
+/* OmniVision* camera chip driver API
+ *
+ * Copyright (c) 1999-2004 Mark McClelland
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version. NO WARRANTY OF ANY KIND is expressed or implied.
+ *
+ * * OmniVision is a trademark of OmniVision Technologies, Inc. This driver
+ * is not sponsored or developed by them.
+ */
+
+#ifndef __LINUX_OVCAMCHIP_H
+#define __LINUX_OVCAMCHIP_H
+
+#include <linux/videodev.h>
+#include <linux/i2c.h>
+
+/* Remove these once they are officially defined */
+#ifndef I2C_DRIVERID_OVCAMCHIP
+	#define I2C_DRIVERID_OVCAMCHIP	0xf00f
+#endif
+#ifndef I2C_HW_SMBUS_OV511
+	#define I2C_HW_SMBUS_OV511	0xfe
+#endif
+#ifndef I2C_HW_SMBUS_OV518
+	#define I2C_HW_SMBUS_OV518	0xff
+#endif
+#ifndef I2C_HW_SMBUS_OVFX2
+	#define I2C_HW_SMBUS_OVFX2	0xfd
+#endif
+
+/* --------------------------------- */
+/*           ENUMERATIONS            */
+/* --------------------------------- */
+
+/* Controls */
+enum {
+	OVCAMCHIP_CID_CONT,		/* Contrast */
+	OVCAMCHIP_CID_BRIGHT,		/* Brightness */
+	OVCAMCHIP_CID_SAT,		/* Saturation */
+	OVCAMCHIP_CID_HUE,		/* Hue */
+	OVCAMCHIP_CID_EXP,		/* Exposure */
+	OVCAMCHIP_CID_FREQ,		/* Light frequency */
+	OVCAMCHIP_CID_BANDFILT,		/* Banding filter */
+	OVCAMCHIP_CID_AUTOBRIGHT,	/* Auto brightness */
+	OVCAMCHIP_CID_AUTOEXP,		/* Auto exposure */
+	OVCAMCHIP_CID_BACKLIGHT,	/* Back light compensation */
+	OVCAMCHIP_CID_MIRROR,		/* Mirror horizontally */
+};
+
+/* Chip types */
+#define NUM_CC_TYPES	9
+enum {
+	CC_UNKNOWN,
+	CC_OV76BE,
+	CC_OV7610,
+	CC_OV7620,
+	CC_OV7620AE,
+	CC_OV6620,
+	CC_OV6630,
+	CC_OV6630AE,
+	CC_OV6630AF,
+};
+
+/* --------------------------------- */
+/*           I2C ADDRESSES           */
+/* --------------------------------- */
+
+#define OV7xx0_SID   (0x42 >> 1)
+#define OV6xx0_SID   (0xC0 >> 1)
+
+/* --------------------------------- */
+/*                API                */
+/* --------------------------------- */
+
+struct ovcamchip_control {
+	__u32 id;
+	__s32 value;
+};
+
+struct ovcamchip_window {
+	int x;
+	int y;
+	int width;
+	int height;
+	int format;
+	int quarter;		/* Scale width and height down 2x */
+
+	/* This stuff will be removed eventually */
+	int clockdiv;		/* Clock divisor setting */
+};
+
+/* Commands */
+#define OVCAMCHIP_CMD_Q_SUBTYPE     _IOR  (0x88, 0x00, int)
+#define OVCAMCHIP_CMD_INITIALIZE    _IOW  (0x88, 0x01, int)
+/* You must call OVCAMCHIP_CMD_INITIALIZE before any of commands below! */
+#define OVCAMCHIP_CMD_S_CTRL        _IOW  (0x88, 0x02, struct ovcamchip_control)
+#define OVCAMCHIP_CMD_G_CTRL        _IOWR (0x88, 0x03, struct ovcamchip_control)
+#define OVCAMCHIP_CMD_S_MODE        _IOW  (0x88, 0x04, struct ovcamchip_window)
+#define OVCAMCHIP_MAX_CMD           _IO   (0x88, 0x3f)
+
+#endif



--------------020904050300050904070503--
