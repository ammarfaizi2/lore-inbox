Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbULJPnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbULJPnN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 10:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbULJPnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 10:43:13 -0500
Received: from mail.convergence.de ([212.227.36.84]:37534 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S261743AbULJPiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:38:03 -0500
Message-ID: <41B9C2AA.5050101@linuxtv.org>
Date: Fri, 10 Dec 2004 16:37:14 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][DVB][2/6] B2C2 driver splitup
Content-Type: multipart/mixed;
 boundary="------------000300060806030902050902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000300060806030902050902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------000300060806030902050902
Content-Type: text/plain;
 name="02-dvb-b2c2-splitup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-dvb-b2c2-splitup.diff"

- [DVB] B2C2: move generic b2c2 code a separate module, added basic b2c2-usb support
- [DVB] Skystar2: add mt312/vp310 support

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/b2c2/Kconfig linux-2.6.10-rc3-bk3-p/drivers/media/dvb/b2c2/Kconfig
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/b2c2/Kconfig	2004-12-08 14:31:31.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/b2c2/Kconfig	2004-12-08 14:45:05.000000000 +0100
@@ -1,10 +1,24 @@
 config DVB_B2C2_SKYSTAR
-	tristate "Technisat Skystar2 PCI"
+	tristate "B2C2/Technisat Air/Sky/CableStar 2 PCI"
 	depends on DVB_CORE && PCI
 	select DVB_STV0299
 	select DVB_MT352
+	select DVB_MT312
 	help
 	  Support for the Skystar2 PCI DVB card by Technisat, which
 	  is equipped with the FlexCopII chipset by B2C2.
 
 	  Say Y if you own such a device and want to use it.
+
+config DVB_B2C2_USB
+	tristate "B2C2/Technisat Air/Sky/Cable2PC USB"
+	depends on DVB_CORE && USB && EXPERIMENTAL
+	select DVB_STV0299
+	select DVB_MT352
+	help
+	  Support for the Air/Sky/Cable2PC USB DVB device by B2C2. Currently 
+	  this does nothing, but providing basic function for the used usb 
+	  protocol.
+
+	  Say Y if you own such a device and want to use it.
+	  
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/b2c2/Makefile linux-2.6.10-rc3-bk3-p/drivers/media/dvb/b2c2/Makefile
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/b2c2/Makefile	2004-12-08 14:31:31.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/b2c2/Makefile	2004-12-08 14:45:05.000000000 +0100
@@ -1,3 +1,6 @@
+obj-b2c2-usb = b2c2-usb-core.o b2c2-common.o
+
 obj-$(CONFIG_DVB_B2C2_SKYSTAR) += skystar2.o
+obj-$(CONFIG_DVB_B2C2_USB) + = b2c2-usb.o
 
 EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/ -Idrivers/media/dvb/frontends/
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/b2c2/b2c2-common.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/b2c2/b2c2-common.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/b2c2/b2c2-common.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/b2c2/b2c2-common.c	2004-12-02 20:48:07.000000000 +0100
@@ -0,0 +1,214 @@
+/*
+ * b2c2-common.c - common methods for the B2C2/Technisat SkyStar2 PCI DVB card and
+ *                 for the B2C2/Technisat Sky/Cable/AirStar USB devices
+ *                 based on the FlexCopII/FlexCopIII by B2C2, Inc.
+ *
+ * Copyright (C) 2003  Vadim Catana, skystar@moldova.cc
+ *
+ * FIX: DISEQC Tone Burst in flexcop_diseqc_ioctl()
+ * FIX: FULL soft DiSEqC for skystar2 (FlexCopII rev 130) VP310 equipped
+ *     Vincenzo Di Massa, hawk.it at tiscalinet.it
+ *
+ * Converted to Linux coding style
+ * Misc reorganization, polishing, restyling
+ *     Roberto Ragusa, r.ragusa at libero.it
+ *
+ * Added hardware filtering support,
+ *     Niklas Peinecke, peinecke at gdv.uni-hannover.de
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2.1
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ * 
+ */
+#include "stv0299.h"
+#include "mt352.h"
+#include "mt312.h"
+
+static int samsung_tbmu24112_set_symbol_rate(struct dvb_frontend* fe, u32 srate, u32 ratio)
+{
+	u8 aclk = 0;
+	u8 bclk = 0;
+
+	if (srate < 1500000) { aclk = 0xb7; bclk = 0x47; }
+	else if (srate < 3000000) { aclk = 0xb7; bclk = 0x4b; }
+	else if (srate < 7000000) { aclk = 0xb7; bclk = 0x4f; }
+	else if (srate < 14000000) { aclk = 0xb7; bclk = 0x53; }
+	else if (srate < 30000000) { aclk = 0xb6; bclk = 0x53; }
+	else if (srate < 45000000) { aclk = 0xb4; bclk = 0x51; }
+
+	stv0299_writereg (fe, 0x13, aclk);
+	stv0299_writereg (fe, 0x14, bclk);
+	stv0299_writereg (fe, 0x1f, (ratio >> 16) & 0xff);
+	stv0299_writereg (fe, 0x20, (ratio >>  8) & 0xff);
+	stv0299_writereg (fe, 0x21, (ratio      ) & 0xf0);
+
+	return 0;
+}
+
+static int samsung_tbmu24112_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+{
+	u8 buf[4];
+	u32 div;
+	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = buf, .len = sizeof(buf) };
+//	struct adapter* adapter = (struct adapter*) fe->dvb->priv;
+
+	div = params->frequency / 125;
+
+	buf[0] = (div >> 8) & 0x7f;
+	buf[1] = div & 0xff;
+	buf[2] = 0x84;  // 0xC4
+	buf[3] = 0x08;
+
+	if (params->frequency < 1500000) buf[3] |= 0x10;
+
+//	if (i2c_transfer (&adapter->i2c_adap, &msg, 1) != 1) return -EIO;
+	return 0;
+}
+
+static u8 samsung_tbmu24112_inittab[] = {
+	     0x01, 0x15,
+	     0x02, 0x30,
+	     0x03, 0x00,
+	     0x04, 0x7D,
+	     0x05, 0x35,
+	     0x06, 0x02,
+	     0x07, 0x00,
+	     0x08, 0xC3,
+	     0x0C, 0x00,
+	     0x0D, 0x81,
+	     0x0E, 0x23,
+	     0x0F, 0x12,
+	     0x10, 0x7E,
+	     0x11, 0x84,
+	     0x12, 0xB9,
+	     0x13, 0x88,
+	     0x14, 0x89,
+	     0x15, 0xC9,
+	     0x16, 0x00,
+	     0x17, 0x5C,
+	     0x18, 0x00,
+	     0x19, 0x00,
+	     0x1A, 0x00,
+	     0x1C, 0x00,
+	     0x1D, 0x00,
+	     0x1E, 0x00,
+	     0x1F, 0x3A,
+	     0x20, 0x2E,
+	     0x21, 0x80,
+	     0x22, 0xFF,
+	     0x23, 0xC1,
+	     0x28, 0x00,
+	     0x29, 0x1E,
+	     0x2A, 0x14,
+	     0x2B, 0x0F,
+	     0x2C, 0x09,
+	     0x2D, 0x05,
+	     0x31, 0x1F,
+	     0x32, 0x19,
+	     0x33, 0xFE,
+	     0x34, 0x93,
+	     0xff, 0xff,
+};
+
+static struct stv0299_config samsung_tbmu24112_config = {
+	.demod_address = 0x68,
+	.inittab = samsung_tbmu24112_inittab,
+	.mclk = 88000000UL,
+	.invert = 0,
+	.enhanced_tuning = 0,
+	.skip_reinit = 0,
+	.lock_output = STV0229_LOCKOUTPUT_LK,
+	.volt13_op0_op1 = STV0299_VOLT13_OP1,
+	.min_delay_ms = 100,
+	.set_symbol_rate = samsung_tbmu24112_set_symbol_rate,
+   	.pll_set = samsung_tbmu24112_pll_set,
+};
+
+
+
+
+
+static int samsung_tdtc9251dh0_demod_init(struct dvb_frontend* fe)
+{
+	static u8 mt352_clock_config [] = { 0x89, 0x10, 0x2d };
+	static u8 mt352_reset [] = { 0x50, 0x80 };
+	static u8 mt352_adc_ctl_1_cfg [] = { 0x8E, 0x40 };
+	static u8 mt352_agc_cfg [] = { 0x67, 0x28, 0xa1 };
+	static u8 mt352_capt_range_cfg[] = { 0x75, 0x32 };
+
+	mt352_write(fe, mt352_clock_config, sizeof(mt352_clock_config));
+	udelay(2000);
+	mt352_write(fe, mt352_reset, sizeof(mt352_reset));
+	mt352_write(fe, mt352_adc_ctl_1_cfg, sizeof(mt352_adc_ctl_1_cfg));
+
+	mt352_write(fe, mt352_agc_cfg, sizeof(mt352_agc_cfg));
+	mt352_write(fe, mt352_capt_range_cfg, sizeof(mt352_capt_range_cfg));
+
+	return 0;
+}
+
+int samsung_tdtc9251dh0_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pllbuf)
+{
+	u32 div;
+	unsigned char bs = 0;
+
+	#define IF_FREQUENCYx6 217    /* 6 * 36.16666666667MHz */
+	div = (((params->frequency + 83333) * 3) / 500000) + IF_FREQUENCYx6;
+
+	if (params->frequency >= 48000000 && params->frequency <= 154000000) bs = 0x09;
+	if (params->frequency >= 161000000 && params->frequency <= 439000000) bs = 0x0a;
+	if (params->frequency >= 447000000 && params->frequency <= 863000000) bs = 0x08;
+
+	pllbuf[0] = 0xc2; // Note: non-linux standard PLL i2c address
+	pllbuf[1] = div >> 8;
+   	pllbuf[2] = div & 0xff;
+   	pllbuf[3] = 0xcc;
+   	pllbuf[4] = bs;
+
+	return 0;
+}
+
+static struct mt352_config samsung_tdtc9251dh0_config = {
+
+	.demod_address = 0x0f,
+	.demod_init = samsung_tdtc9251dh0_demod_init,
+   	.pll_set = samsung_tdtc9251dh0_pll_set,
+};
+
+static int skystar23_samsung_tbdu18132_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+{
+	u8 buf[4];
+	u32 div;
+	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = buf, .len = sizeof(buf) };
+//	struct adapter* adapter = (struct adapter*) fe->dvb->priv;
+
+	div = (params->frequency + (125/2)) / 125;
+
+	buf[0] = (div >> 8) & 0x7f;
+	buf[1] = (div >> 0) & 0xff;
+	buf[2] = 0x84 | ((div >> 10) & 0x60);
+	buf[3] = 0x80;
+
+	if (params->frequency < 1550000)
+		buf[3] |= 0x02;
+
+	//if (i2c_transfer (&adapter->i2c_adap, &msg, 1) != 1) return -EIO;
+	return 0;
+}
+
+static struct mt312_config skystar23_samsung_tbdu18132_config = {
+
+	.demod_address = 0x0e,
+   	.pll_set = skystar23_samsung_tbdu18132_pll_set,
+};
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/b2c2/b2c2-usb-core.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/b2c2/b2c2-usb-core.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/b2c2/b2c2-usb-core.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/b2c2/b2c2-usb-core.c	2004-12-06 09:04:08.000000000 +0100
@@ -0,0 +1,538 @@
+/*
+ * Copyright (C) 2004 Patrick Boettcher <patrick.boettcher@desy.de>,
+ *                    Luca Bertagnolio <>,
+ *
+ * based on information provided by John Jurrius from BBTI, Inc.
+ * 
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/usb.h>
+#include <linux/moduleparam.h>
+#include <linux/pci.h>
+#include <linux/version.h>
+
+#include "dmxdev.h"
+#include "dvb_demux.h"
+#include "dvb_filter.h"
+#include "dvb_net.h"
+#include "dvb_frontend.h"
+
+/* debug */
+#define dprintk(level,args...) \
+	    do { if ((debug & level)) { printk(args); } } while (0)
+#define debug_dump(b,l) if (debug) {\
+	int i; deb_xfer("%s: %d > ",__FUNCTION__,l); \
+	for (i = 0; i < l; i++) deb_xfer("%02x ", b[i]); \
+	deb_xfer("\n");\
+}
+
+static int debug;
+module_param(debug, int, 0x644);
+MODULE_PARM_DESC(debug, "set debugging level (1=info,ts=2,ctrl=4 (or-able)).");
+
+#define deb_info(args...) dprintk(0x01,args)
+#define deb_ts(args...)   dprintk(0x02,args)
+#define deb_ctrl(args...) dprintk(0x04,args)
+
+/* Version information */
+#define DRIVER_VERSION "0.0"
+#define DRIVER_DESC "Driver for B2C2/Technisat Air/Cable/Sky-2-PC USB devices"
+#define DRIVER_AUTHOR "Patrick Boettcher, patrick.boettcher@desy.de"
+
+/* transfer parameters */
+#define B2C2_USB_FRAMES_PER_ISO		4
+#define B2C2_USB_NUM_ISO_URB		4    /* TODO check out a good value */
+
+#define B2C2_USB_CTRL_PIPE_IN		usb_rcvctrlpipe(b2c2->udev,0)
+#define B2C2_USB_CTRL_PIPE_OUT		usb_sndctrlpipe(b2c2->udev,0)
+#define B2C2_USB_DATA_PIPE			usb_rcvisocpipe(b2c2->udev,0x81)
+
+struct usb_b2c2_usb {
+	struct usb_device *udev;
+	struct usb_interface *uintf;
+
+	u8 *iso_buffer;
+	int buffer_size;
+	dma_addr_t iso_dma_handle;
+	struct urb *iso_urb[B2C2_USB_NUM_ISO_URB];
+};
+
+
+/*
+ * USB 
+ * 10 90 34 12 78 56 04 00 
+ * usb_control_msg(udev, usb_sndctrlpipe(udev,0),
+ * 0x90, 
+ * 0x10, 
+ * 0x1234, 
+ * 0x5678, 
+ * buf, 
+ * 4, 
+ * 5*HZ);
+ *
+ * extern int usb_control_msg(struct usb_device *dev, unsigned int pipe, 
+ * __u8 request, 
+ * __u8 requesttype, 
+ * __u16 value, 
+ * __u16 index,
+ * void *data, 
+ * __u16 size, 
+ * int timeout);
+ *
+ */
+
+/* request types */
+typedef enum {
+	RTYPE_READ_DW         = (1 << 6),
+	RTYPE_WRITE_DW_1      = (3 << 6),
+	RTYPE_READ_V8_MEMORY  = (6 << 6),
+	RTYPE_WRITE_V8_MEMORY = (7 << 6),
+	RTYPE_WRITE_V8_FLASH  = (8 << 6),
+	RTYPE_GENERIC         = (9 << 6),
+} b2c2_usb_request_type_t;
+
+/* request */
+typedef enum {
+	B2C2_USB_WRITE_V8_MEM = 0x04,
+	B2C2_USB_READ_V8_MEM  = 0x05,
+	B2C2_USB_READ_REG     = 0x08,
+	B2C2_USB_WRITE_REG    = 0x0A,
+/*	B2C2_USB_WRITEREGLO   = 0x0A, */
+	B2C2_USB_WRITEREGHI   = 0x0B,
+	B2C2_USB_FLASH_BLOCK  = 0x10,
+	B2C2_USB_I2C_REQUEST  = 0x11,
+	B2C2_USB_UTILITY      = 0x12,
+} b2c2_usb_request_t;
+
+/* function definition for I2C_REQUEST */
+typedef enum {
+	USB_FUNC_I2C_WRITE       = 0x01,
+	USB_FUNC_I2C_MULTIWRITE  = 0x02,
+	USB_FUNC_I2C_READ        = 0x03,
+	USB_FUNC_I2C_REPEATWRITE = 0x04,
+	USB_FUNC_GET_DESCRIPTOR  = 0x05,
+	USB_FUNC_I2C_REPEATREAD  = 0x06,
+/* DKT 020208 - add this to support special case of DiSEqC */
+	USB_FUNC_I2C_CHECKWRITE  = 0x07,
+	USB_FUNC_I2C_CHECKRESULT = 0x08,
+} b2c2_usb_i2c_function_t;
+
+/*
+ * function definition for UTILITY request 0x12
+ * DKT 020304 - new utility function
+ */
+typedef enum {
+	UTILITY_SET_FILTER          = 0x01,
+	UTILITY_DATA_ENABLE         = 0x02,
+	UTILITY_FLEX_MULTIWRITE     = 0x03,
+	UTILITY_SET_BUFFER_SIZE     = 0x04,
+	UTILITY_FLEX_OPERATOR       = 0x05,
+	UTILITY_FLEX_RESET300_START = 0x06,
+	UTILITY_FLEX_RESET300_STOP  = 0x07,
+	UTILITY_FLEX_RESET300       = 0x08,
+	UTILITY_SET_ISO_SIZE        = 0x09,
+	UTILITY_DATA_RESET          = 0x0A,
+	UTILITY_GET_DATA_STATUS     = 0x10,
+	UTILITY_GET_V8_REG          = 0x11,
+/* DKT 020326 - add function for v1.14 */
+	UTILITY_SRAM_WRITE          = 0x12,
+	UTILITY_SRAM_READ           = 0x13,
+	UTILITY_SRAM_TESTFILL       = 0x14,
+	UTILITY_SRAM_TESTSET        = 0x15,
+	UTILITY_SRAM_TESTVERIFY     = 0x16,
+} b2c2_usb_utility_function_t;
+
+#define B2C2_WAIT_FOR_OPERATION_RW  1  // 1 s
+#define B2C2_WAIT_FOR_OPERATION_RDW 3  // 3 s
+#define B2C2_WAIT_FOR_OPERATION_WDW 1  // 1 s
+
+#define B2C2_WAIT_FOR_OPERATION_V8READ   3  // 3 s
+#define B2C2_WAIT_FOR_OPERATION_V8WRITE  3  // 3 s
+#define B2C2_WAIT_FOR_OPERATION_V8FLASH  3  // 3 s
+
+/* JLP 111700: we will include the 1 bit gap between the upper and lower 3 bits
+ * in the IBI address, to make the V8 code simpler.
+ * PCI ADDRESS FORMAT: 0x71C -> 0000 0111 0001 1100 (these are the six bits used)
+ *                  in general: 0000 0HHH 000L LL00
+ * IBI ADDRESS FORMAT:                    RHHH BLLL
+ * 
+ * where R is the read(1)/write(0) bit, B is the busy bit
+ * and HHH and LLL are the two sets of three bits from the PCI address.
+ */
+#define B2C2_FLEX_PCIOFFSET_TO_INTERNALADDR(usPCI) (u8) (((usPCI >> 2) & 0x07) + ((usPCI >> 4) & 0x70))
+#define B2C2_FLEX_INTERNALADDR_TO_PCIOFFSET(ucAddr) (u16) (((ucAddr & 0x07) << 2) + ((ucAddr & 0x70) << 4))
+
+/* 
+ * DKT 020228 - forget about this VENDOR_BUFFER_SIZE, read and write register
+ * deal with DWORD or 4 bytes, that should be should from now on
+ */
+static u32 b2c2_usb_read_dw(struct usb_b2c2_usb *b2c2, u16 wRegOffsPCI) 
+{
+	u32 val;
+	u16 wAddress = B2C2_FLEX_PCIOFFSET_TO_INTERNALADDR(wRegOffsPCI) | 0x0080;
+	int len = usb_control_msg(b2c2->udev,
+			B2C2_USB_CTRL_PIPE_IN, 
+			B2C2_USB_READ_REG,
+			RTYPE_READ_DW,
+			wAddress,
+			0,
+			&val,
+			sizeof(u32),
+			B2C2_WAIT_FOR_OPERATION_RDW * HZ);
+	
+	if (len != sizeof(u32)) {
+		err("error while reading dword from %d (%d).",wAddress,wRegOffsPCI);
+		return -EIO;
+	} else
+		return val;
+}
+
+/*
+ * DKT 020228 - from now on, we don't support anything older than firm 1.00
+ * I eliminated the write register as a 2 trip of writing hi word and lo word
+ * and force this to write only 4 bytes at a time.
+ * NOTE: this should work with all the firmware from 1.00 and newer
+ */
+static int b2c2_usb_write_dw(struct usb_b2c2_usb *b2c2, u16 wRegOffsPCI, u32 val)
+{
+	u16 wAddress = B2C2_FLEX_PCIOFFSET_TO_INTERNALADDR(wRegOffsPCI);
+	int len = usb_control_msg(b2c2->udev,
+			B2C2_USB_CTRL_PIPE_OUT, 
+			B2C2_USB_WRITE_REG,
+			RTYPE_WRITE_DW_1,
+			wAddress,
+			0,
+			&val,
+			sizeof(u32),
+			B2C2_WAIT_FOR_OPERATION_RDW * HZ);
+	
+	if (len != sizeof(u32)) {
+		err("error while reading dword from %d (%d).",wAddress,wRegOffsPCI);
+		return -EIO;
+	} else
+		return 0;
+}
+
+/* 
+ * DKT 010817 - add support for V8 memory read/write and flash update
+ */
+static int b2c2_usb_v8_memory_req(struct usb_b2c2_usb *b2c2,
+		b2c2_usb_request_t req, u8 page, u16 wAddress, 
+		u16 buflen, u8 *pbBuffer)
+{
+	u8 dwRequestType;
+	u16 wIndex;
+	int nWaitTime,pipe,len;
+	
+	wIndex = page << 8;
+	
+	switch (req) {
+		case B2C2_USB_READ_V8_MEM:
+			nWaitTime = B2C2_WAIT_FOR_OPERATION_V8READ;
+			dwRequestType = (u8) RTYPE_READ_V8_MEMORY;
+			pipe = B2C2_USB_CTRL_PIPE_IN;
+		break;
+		case B2C2_USB_WRITE_V8_MEM:
+			wIndex |= pbBuffer[0];
+			nWaitTime = B2C2_WAIT_FOR_OPERATION_V8WRITE;
+			dwRequestType = (u8) RTYPE_WRITE_V8_MEMORY;
+			pipe = B2C2_USB_CTRL_PIPE_OUT;
+		break;
+		case B2C2_USB_FLASH_BLOCK:
+			nWaitTime = B2C2_WAIT_FOR_OPERATION_V8FLASH;
+			dwRequestType = (u8) RTYPE_WRITE_V8_FLASH;
+			pipe = B2C2_USB_CTRL_PIPE_OUT;
+		break;
+		default:
+			deb_info("unsupported request for v8_mem_req %x.\n",req);
+		return -EINVAL;
+	}
+	len = usb_control_msg(b2c2->udev,pipe,
+			req,
+			dwRequestType,
+			wAddress,
+			wIndex,
+			pbBuffer,
+			buflen,
+			nWaitTime * HZ);
+	return len == buflen ? 0 : -EIO;
+}
+
+static int b2c2_usb_i2c_req(struct usb_b2c2_usb *b2c2,
+		b2c2_usb_request_t req, b2c2_usb_i2c_function_t func,
+		u8 port, u8 chipaddr, u8 addr, u8 buflen, u8 *buf)
+{
+	u16 wValue, wIndex;
+	int nWaitTime,pipe,len;
+	u8 dwRequestType;
+	
+	switch (func) {
+		case USB_FUNC_I2C_WRITE:
+		case USB_FUNC_I2C_MULTIWRITE:
+		case USB_FUNC_I2C_REPEATWRITE:
+		/* DKT 020208 - add this to support special case of DiSEqC */
+		case USB_FUNC_I2C_CHECKWRITE:
+			pipe = B2C2_USB_CTRL_PIPE_OUT;
+			nWaitTime = 2;
+			dwRequestType = (u8) RTYPE_GENERIC;
+		break;
+		case USB_FUNC_I2C_READ:
+		case USB_FUNC_I2C_REPEATREAD:
+			pipe = B2C2_USB_CTRL_PIPE_IN;
+			nWaitTime = 2;
+			dwRequestType = (u8) RTYPE_GENERIC;
+		break;
+		default:
+			deb_info("unsupported function for i2c_req %x\n",func);
+			return -EINVAL;
+	}
+	wValue = (func << 8 ) | port;
+	wIndex = (chipaddr << 8 ) | addr;
+	
+	len = usb_control_msg(b2c2->udev,pipe,
+			req,
+			dwRequestType,
+			addr,
+			wIndex,
+			buf,
+			buflen,
+			nWaitTime * HZ);
+	return len == buflen ? 0 : -EIO;
+}
+
+int static b2c2_usb_utility_req(struct usb_b2c2_usb *b2c2, int set,
+		b2c2_usb_utility_function_t func, u8 extra, u16 wIndex, 
+		u16 buflen, u8 *pvBuffer)
+{
+	u16 wValue;
+	int nWaitTime = 2,
+		pipe = set ? B2C2_USB_CTRL_PIPE_OUT : B2C2_USB_CTRL_PIPE_IN,
+		len;
+	
+	wValue = (func << 8) | extra;
+
+	len = usb_control_msg(b2c2->udev,pipe,
+			B2C2_USB_UTILITY,
+			(u8) RTYPE_GENERIC,
+			wValue,
+			wIndex,
+			pvBuffer,
+			buflen,
+			nWaitTime * HZ);
+	return len == buflen ? 0 : -EIO;
+}
+
+
+
+static void b2c2_dumpfourreg(struct usb_b2c2_usb *b2c2, u16 offs)
+{
+	u32 r0,r1,r2,r3;
+	r0 = r1 = r2 = r3 = 0;
+	r0 = b2c2_usb_read_dw(b2c2,offs);
+	r1 = b2c2_usb_read_dw(b2c2,offs + 0x04);
+	r2 = b2c2_usb_read_dw(b2c2,offs + 0x08);
+	r3 = b2c2_usb_read_dw(b2c2,offs + 0x0c);
+	deb_ctrl("dump: offset: %03x, %08x, %08x, %08x, %08x\n",offs,r0,r1,r2,r3);
+}
+
+static void b2c2_urb_complete(struct urb *urb, struct pt_regs *ptregs)
+{
+	struct usb_b2c2_usb *b2c2 = urb->context;
+	deb_ts("urb completed, bufsize: %d\n",urb->transfer_buffer_length);
+
+//	urb_submit_urb(urb,GFP_ATOMIC); enable for real action
+}
+
+static void b2c2_exit_usb(struct usb_b2c2_usb *b2c2)
+{
+	int i;
+	for (i = 0; i < B2C2_USB_NUM_ISO_URB; i++)
+		if (b2c2->iso_urb[i] != NULL) { /* not sure about unlink_urb and iso-urbs TODO */
+			deb_info("unlinking/killing urb no. %d\n",i);
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,7)
+			usb_unlink_urb(b2c2->iso_urb[i]);
+#else
+			usb_kill_urb(b2c2->iso_urb[i]);
+#endif
+			usb_free_urb(b2c2->iso_urb[i]);
+		}
+
+	if (b2c2->iso_buffer != NULL) 
+		pci_free_consistent(NULL,b2c2->buffer_size, b2c2->iso_buffer, b2c2->iso_dma_handle);
+
+}
+
+static int b2c2_init_usb(struct usb_b2c2_usb *b2c2)
+{
+	u16 frame_size = b2c2->uintf->cur_altsetting->endpoint[0].desc.wMaxPacketSize;
+	int bufsize = B2C2_USB_NUM_ISO_URB * B2C2_USB_FRAMES_PER_ISO * frame_size,i,j,ret;
+	int buffer_offset = 0;
+
+	deb_info("creating %d iso-urbs with %d frames each of %d bytes size = %d.\n",
+			B2C2_USB_NUM_ISO_URB, B2C2_USB_FRAMES_PER_ISO, frame_size,bufsize);
+
+	b2c2->iso_buffer = pci_alloc_consistent(NULL,bufsize,&b2c2->iso_dma_handle);
+	if (b2c2->iso_buffer == NULL)
+		return -ENOMEM;
+	memset(b2c2->iso_buffer, 0, bufsize);
+	b2c2->buffer_size = bufsize;
+
+	/* creating iso urbs */
+	for (i = 0; i < B2C2_USB_NUM_ISO_URB; i++) 
+		if (!(b2c2->iso_urb[i] = usb_alloc_urb(B2C2_USB_FRAMES_PER_ISO,GFP_ATOMIC))) {
+			ret = -ENOMEM;
+			goto urb_error;
+		}
+	/* initialising and submitting iso urbs */
+	for (i = 0; i < B2C2_USB_NUM_ISO_URB; i++) {
+		deb_info("initializing and submitting urb no. %d (buf_offset: %d).\n",i,buffer_offset);
+		int frame_offset = 0;
+		struct urb *urb = b2c2->iso_urb[i];
+
+		urb->dev = b2c2->udev;
+		urb->context = b2c2;
+		urb->complete = b2c2_urb_complete;
+		urb->pipe = B2C2_USB_DATA_PIPE;
+		urb->transfer_flags = URB_ISO_ASAP;
+		urb->interval = 1;
+		urb->number_of_packets = B2C2_USB_FRAMES_PER_ISO;
+		urb->transfer_buffer_length = frame_size * B2C2_USB_FRAMES_PER_ISO;
+		urb->transfer_buffer = b2c2->iso_buffer + buffer_offset;
+		
+		buffer_offset += frame_size * B2C2_USB_FRAMES_PER_ISO;
+		for (j = 0; j < B2C2_USB_FRAMES_PER_ISO; j++) {
+			deb_info("urb no: %d, frame: %d, frame_offset: %d\n",i,j,frame_offset);
+			urb->iso_frame_desc[j].offset = frame_offset;
+			urb->iso_frame_desc[j].length = frame_size;
+			frame_offset += frame_size;
+		}
+
+		if ((ret = usb_submit_urb(b2c2->iso_urb[i],GFP_ATOMIC))) {
+			err("submitting urb %d failed with %d.",i,ret);
+			goto urb_error;
+		}
+		deb_info("submitted urb no. %d.\n",i);						
+	}
+
+	ret = 0;
+	goto success;
+urb_error:
+	b2c2_exit_usb(b2c2);
+success:
+	return ret;
+}
+
+static int b2c2_usb_probe(struct usb_interface *intf, 
+		const struct usb_device_id *id)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct usb_b2c2_usb *b2c2 = NULL;
+	int ret;
+
+	b2c2 = kmalloc(sizeof(struct usb_b2c2_usb),GFP_KERNEL);
+	if (b2c2 == NULL) {
+		err("no memory");
+		return -ENOMEM;
+	}
+	b2c2->udev = udev;
+	b2c2->uintf = intf;
+
+	/* use the alternate setting with the larges buffer */
+	usb_set_interface(udev,0,1);
+
+	if ((ret = b2c2_init_usb(b2c2)))
+		goto usb_init_error;
+	
+	usb_set_intfdata(intf,b2c2);
+
+	switch (udev->speed) {
+		case USB_SPEED_LOW:
+			err("cannot handle USB speed because it is to sLOW.");
+			break;
+		case USB_SPEED_FULL:
+			info("running at FULL speed.");
+			break;
+		case USB_SPEED_HIGH:
+			info("running at HIGH speed.");
+			break;
+		case USB_SPEED_UNKNOWN: /* fall through */
+		default:
+			err("cannot handle USB speed because it is unkown.");
+		break;
+	}
+
+	b2c2_dumpfourreg(b2c2,0x200);
+	b2c2_dumpfourreg(b2c2,0x300);
+	b2c2_dumpfourreg(b2c2,0x400);
+	b2c2_dumpfourreg(b2c2,0x700);
+
+	
+	if (ret == 0)
+		info("%s successfully initialized and connected.",DRIVER_DESC);
+	else 
+		info("%s error while loading driver (%d)",DRIVER_DESC,ret);
+
+	ret = 0;
+	goto success;
+
+usb_init_error:
+	kfree(b2c2);
+success:
+	return ret;
+}
+
+static void b2c2_usb_disconnect(struct usb_interface *intf)
+{
+	struct usb_b2c2_usb *b2c2 = usb_get_intfdata(intf);
+	usb_set_intfdata(intf,NULL);
+	if (b2c2 != NULL) {
+		b2c2_exit_usb(b2c2);
+		kfree(b2c2);
+	}
+	info("%s successfully deinitialized and disconnected.",DRIVER_DESC);
+	
+}
+
+static struct usb_device_id b2c2_usb_table [] = {
+	    { USB_DEVICE(0x0af7, 0x0101) }
+};
+
+/* usb specific object needed to register this driver with the usb subsystem */
+static struct usb_driver b2c2_usb_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "dvb_b2c2_usb",
+	.probe 		= b2c2_usb_probe,
+	.disconnect = b2c2_usb_disconnect,
+	.id_table 	= b2c2_usb_table,
+};
+
+/* module stuff */
+static int __init b2c2_usb_init(void)
+{
+	int result;
+	if ((result = usb_register(&b2c2_usb_driver))) {
+		err("usb_register failed. Error number %d",result);
+		return result;
+	}
+	
+	return 0;
+}
+
+static void __exit b2c2_usb_exit(void)
+{
+	/* deregister this driver from the USB subsystem */
+	usb_deregister(&b2c2_usb_driver);
+}
+
+module_init (b2c2_usb_init);
+module_exit (b2c2_usb_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/b2c2/skystar2.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/b2c2/skystar2.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/b2c2/skystar2.c	2004-12-08 14:31:31.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/b2c2/skystar2.c	2004-11-30 15:26:46.000000000 +0100
@@ -52,6 +52,7 @@
 #include "dvb_net.h"
 #include "stv0299.h"
 #include "mt352.h"
+#include "mt312.h"
 
 
 static int debug;
@@ -315,10 +316,10 @@
 		up(&tmp->i2c_sem);
 
 		if (ret != msgs[1].len) {
-			printk("%s: read error !\n", __FUNCTION__);
+			dprintk("%s: read error !\n", __FUNCTION__);
 
 			for (i = 0; i < 2; i++) {
-				printk("message %d: flags=0x%x, addr=0x%x, buf=0x%x, len=%d \n", i,
+				dprintk("message %d: flags=0x%x, addr=0x%x, buf=0x%x, len=%d \n", i,
 				       msgs[i].flags, msgs[i].addr, msgs[i].buf[0], msgs[i].len);
 		}
 
@@ -338,9 +339,9 @@
 		up(&tmp->i2c_sem);
 
 		if (ret != msgs[0].len - 1) {
-			printk("%s: write error %i !\n", __FUNCTION__, ret);
+			dprintk("%s: write error %i !\n", __FUNCTION__, ret);
 
-			printk("message %d: flags=0x%x, addr=0x%x, buf[0]=0x%x, len=%d \n", i,
+			dprintk("message %d: flags=0x%x, addr=0x%x, buf[0]=0x%x, len=%d \n", i,
 			       msgs[i].flags, msgs[i].addr, msgs[i].buf[0], msgs[i].len);
 
 			return -EREMOTEIO;
@@ -2026,7 +2026,6 @@
 	return 0;
 }
 
-#if 0
 /* lnb control */
 static void set_tuner_tone(struct adapter *adapter, u8 tone)
 {
@@ -2061,7 +2060,6 @@
 		write_reg_dw(adapter, 0x200, 0x40ff8000);
 	}
 }
-#endif
 
 static void set_tuner_polarity(struct adapter *adapter, u8 polarity)
 {
@@ -2089,7 +2087,6 @@
 	write_reg_dw(adapter, 0x204, var);
 }
 
-#if 0
 static void diseqc_send_bit(struct adapter *adapter, int data)
 {
 	set_tuner_tone(adapter, 1);
@@ -2139,12 +2136,11 @@
 	return 0;
 }
 
-
-static int soft_diseqc(struct adapter *adapter, unsigned int cmd, void *arg)
+static int flexcop_set_tone(struct dvb_frontend* fe, fe_sec_tone_mode_t tone)
 {
-	switch (cmd) {
-	case FE_SET_TONE:
-		switch ((fe_sec_tone_mode_t) arg) {
+	struct adapter* adapter = (struct adapter*) fe->dvb->priv;
+
+	switch(tone) {
 		case SEC_TONE_ON:
 			set_tuner_tone(adapter, 1);
 			break;
@@ -2154,27 +2150,27 @@
 			default:
 				return -EINVAL;
 			};
-		break;
 
-	case FE_DISEQC_SEND_MASTER_CMD:
+	return 0;
+}
+
+static int flexcop_diseqc_send_master_cmd(struct dvb_frontend* fe, struct dvb_diseqc_master_cmd* cmd)
 		{
-			struct dvb_diseqc_master_cmd *cmd = arg;
+	struct adapter* adapter = (struct adapter*) fe->dvb->priv;
 
 			send_diseqc_msg(adapter, cmd->msg_len, cmd->msg, 0);
-			break;
+
+	return 0;
 		}
 
-	case FE_DISEQC_SEND_BURST:
-		send_diseqc_msg(adapter, 0, NULL, (unsigned long) arg);
-		break;
+static int flexcop_diseqc_send_burst(struct dvb_frontend* fe, fe_sec_mini_cmd_t minicmd)
+{
+	struct adapter* adapter = (struct adapter*) fe->dvb->priv;
 
-	default:
-		return -EOPNOTSUPP;
-	};
+	send_diseqc_msg(adapter, 0, NULL, minicmd);
 
 	return 0;
 }
-#endif
 
 static int flexcop_set_voltage(struct dvb_frontend* fe, fe_sec_voltage_t voltage)
 		{
@@ -2377,6 +2373,32 @@
    	.pll_set = samsung_tdtc9251dh0_pll_set,
 };
 
+static int skystar23_samsung_tbdu18132_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+{
+	u8 buf[4];
+	u32 div;
+	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = buf, .len = sizeof(buf) };
+	struct adapter* adapter = (struct adapter*) fe->dvb->priv;
+
+	div = (params->frequency + (125/2)) / 125;
+
+	buf[0] = (div >> 8) & 0x7f;
+	buf[1] = (div >> 0) & 0xff;
+	buf[2] = 0x84 | ((div >> 10) & 0x60);
+	buf[3] = 0x80;
+
+	if (params->frequency < 1550000)
+		buf[3] |= 0x02;
+
+	if (i2c_transfer (&adapter->i2c_adap, &msg, 1) != 1) return -EIO;
+	return 0;
+}
+
+static struct mt312_config skystar23_samsung_tbdu18132_config = {
+
+	.demod_address = 0x0e,
+   	.pll_set = skystar23_samsung_tbdu18132_pll_set,
+};
 
 
 
@@ -2386,7 +2408,7 @@
 	switch(skystar2->pdev->device) {
 	case 0x2103: // Technisat Skystar2 OR Technisat Airstar2
 
-		// try the skystar2 first (stv0299/Samsung tbmu24112(sl1935))
+		// try the skystar2 v2.6 first (stv0299/Samsung tbmu24112(sl1935))
 		skystar2->fe = stv0299_attach(&samsung_tbmu24112_config, &skystar2->i2c_adap);
 		if (skystar2->fe != NULL) {
 			skystar2->fe->ops->set_voltage = flexcop_set_voltage;
@@ -2402,6 +2424,18 @@
 			skystar2->fe->ops->info.frequency_max = 858000000;
 			break;
 		}
+
+		// try the skystar2 v2.3 (vp310/Samsung tbdu18132(tsa5059))
+		skystar2->fe = vp310_attach(&skystar23_samsung_tbdu18132_config, &skystar2->i2c_adap);
+		if (skystar2->fe != NULL) {
+			skystar2->fe->ops->diseqc_send_master_cmd = flexcop_diseqc_send_master_cmd;
+			skystar2->fe->ops->diseqc_send_burst = flexcop_diseqc_send_burst;
+			skystar2->fe->ops->set_tone = flexcop_set_tone;
+			skystar2->fe->ops->set_voltage = flexcop_set_voltage;
+			skystar2->fe_sleep = skystar2->fe->ops->sleep;
+			skystar2->fe->ops->sleep = flexcop_sleep;
+			break;
+		}
 		break;
 	}
 

--------------000300060806030902050902--
