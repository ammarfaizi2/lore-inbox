Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVF0Nbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVF0Nbu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVF0NYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:24:15 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:15845 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262060AbVF0MQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:36 -0400
Message-Id: <20050627121417.141370000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:38 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-medion-md95700.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 38/51] usb: support Medion hybrid USB2.0 DVB-T/analogue box
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Add preliminary support for the Medion Hybrid USB2.0 DVB-T/Analogue box.
Analogue part is not working yet (cx25842 --> ivtv?).

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/Kconfig       |   16 +
 drivers/media/dvb/dvb-usb/Makefile      |    3 
 drivers/media/dvb/dvb-usb/cxusb.c       |  287 ++++++++++++++++++++++++++++++++
 drivers/media/dvb/dvb-usb/cxusb.h       |   30 +++
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h |    2 
 5 files changed, 338 insertions(+)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/Kconfig
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/Kconfig	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/Kconfig	2005-06-27 13:26:10.000000000 +0200
@@ -21,12 +21,14 @@ config DVB_USB_DEBUG
 config DVB_USB_A800
 	tristate "AVerMedia AverTV DVB-T USB 2.0 (A800)"
 	depends on DVB_USB
+	select DVB_DIB3000MC
 	help
 	  Say Y here to support the AVerMedia AverTV DVB-T USB 2.0 (A800) receiver.
 
 config DVB_USB_DIBUSB_MB
 	tristate "DiBcom USB DVB-T devices (based on the DiB3000M-B) (see help for device list)"
 	depends on DVB_USB
+	select DVB_DIB3000MB
 	help
 	  Support for USB 1.1 and 2.0 DVB-T receivers based on reference designs made by
 	  DiBcom (<http://www.dibcom.fr>) equipped with a DiB3000M-B demodulator.
@@ -52,6 +54,7 @@ config DVB_USB_DIBUSB_MB
 config DVB_USB_DIBUSB_MC
 	tristate "DiBcom USB DVB-T devices (based on the DiB3000M-C/P) (see help for device list)"
 	depends on DVB_USB
+	select DVB_DIB3000MC
 	help
 	  Support for 2.0 DVB-T receivers based on reference designs made by
 	  DiBcom (<http://www.dibcom.fr>) equipped with a DiB3000M-C/P demodulator.
@@ -66,12 +69,24 @@ config DVB_USB_DIBUSB_MC
 config DVB_USB_UMT_010
 	tristate "HanfTek UMT-010 DVB-T USB2.0 support"
 	depends on DVB_USB
+	select DVB_DIB3000MC
 	help
 	  Say Y here to support the HanfTek UMT-010 USB2.0 stick-sized DVB-T receiver.
 
+config DVB_USB_CXUSB
+	tristate "Medion MD95700 hybrid USB2.0 (Conexant) support"
+	depends on DVB_USB
+	select DVB_CX22702
+	help
+	  Say Y here to support the Medion MD95700 hybrid USB2.0 device. Currently
+	  only the DVB-T part is supported and MPEG2 data transfer are not working
+	  :(.
+
 config DVB_USB_DIGITV
 	tristate "Nebula Electronics uDigiTV DVB-T USB2.0 support"
 	depends on DVB_USB
+	select DVB_NXT6000
+	select DVB_MT352
 	help
 	  Say Y here to support the Nebula Electronics uDigitV USB2.0 DVB-T receiver.
 
@@ -87,6 +102,7 @@ config DVB_USB_VP7045
 config DVB_USB_NOVA_T_USB2
 	tristate "Hauppauge WinTV-NOVA-T usb2 DVB-T USB2.0 support"
 	depends on DVB_USB
+	select DVB_DIB3000MC
 	help
 	  Say Y here to support the Hauppauge WinTV-NOVA-T usb2 DVB-T USB2.0 receiver.
 
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/Makefile
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/Makefile	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/Makefile	2005-06-27 13:26:10.000000000 +0200
@@ -27,4 +27,7 @@ obj-$(CONFIG_DVB_USB_UMT_010) += dvb-usb
 dvb-usb-digitv-objs = digitv.o
 obj-$(CONFIG_DVB_USB_DIGITV) += dvb-usb-digitv.o
 
+dvb-usb-cxusb-objs = cxusb.o
+obj-$(CONFIG_DVB_USB_CXUSB) += dvb-usb-cxusb.o
+
 EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/ -Idrivers/media/dvb/frontends/
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/cxusb.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/cxusb.c	2005-06-27 13:26:10.000000000 +0200
@@ -0,0 +1,287 @@
+/* DVB USB compliant linux driver for Conexant USB reference design.
+ *
+ * The Conexant reference design I saw on their website was only for analogue
+ * capturing (using the cx25842). The box I took to write this driver (reverse
+ * engineered) is the one labeled Medion MD95700. In addition to the cx25842
+ * for analogue capturing it also has a cx22702 DVB-T demodulator on the main
+ * board. Besides it has a atiremote (X10) and a USB2.0 hub onboard.
+ *
+ * Maybe it is a little bit premature to call this driver cxusb, but I assume
+ * the USB protocol is identical or at least inherited from the reference
+ * design, so it can be reused for the "analogue-only" device (if it will
+ * appear at all).
+ *
+ * TODO: check if the cx25840-driver (from ivtv) can be used for the analogue
+ * part
+ *
+ * FIXME: We're getting a lock and signal, but the isochronous transfer is empty
+ * for DVB-T.
+ *
+ * Copyright (C) 2005 Patrick Boettcher (patrick.boettcher@desy.de)
+ *
+ *	This program is free software; you can redistribute it and/or modify it
+ *	under the terms of the GNU General Public License as published by the Free
+ *	Software Foundation, version 2.
+ *
+ * see Documentation/dvb/README.dvb-usb for more information
+ */
+#include "cxusb.h"
+
+#include "cx22702.h"
+
+/* debug */
+int dvb_usb_cxusb_debug;
+module_param_named(debug,dvb_usb_cxusb_debug, int, 0644);
+MODULE_PARM_DESC(debug, "set debugging level (1=rc (or-able))." DVB_USB_DEBUG_STATUS);
+
+static int cxusb_ctrl_msg(struct dvb_usb_device *d,
+		u8 cmd, u8 *wbuf, int wlen, u8 *rbuf, int rlen)
+{
+	int wo = (rbuf == NULL || rlen == 0); /* write-only */
+	u8 sndbuf[1+wlen];
+	memset(sndbuf,0,1+wlen);
+
+	sndbuf[0] = cmd;
+	memcpy(&sndbuf[1],wbuf,wlen);
+	if (wo)
+		dvb_usb_generic_write(d,sndbuf,1+wlen);
+	else
+		dvb_usb_generic_rw(d,sndbuf,1+wlen,rbuf,rlen,0);
+
+	return 0;
+}
+
+/* I2C */
+static void cxusb_set_i2c_path(struct dvb_usb_device *d, enum cxusb_i2c_pathes path)
+{
+	struct cxusb_state *st = d->priv;
+	u8 o[2],i;
+
+	if (path == st->cur_i2c_path)
+		return;
+
+	o[0] = IOCTL_SET_I2C_PATH;
+	switch (path) {
+		case PATH_CX22702:
+			o[1] = 0;
+			break;
+		case PATH_TUNER_OTHER:
+			o[1] = 1;
+			break;
+		default:
+			err("unkown i2c path");
+			return;
+	}
+	cxusb_ctrl_msg(d,CMD_IOCTL,o,2,&i,1);
+
+	if (i != 0x01)
+		deb_info("i2c_path setting failed.\n");
+
+	st->cur_i2c_path = path;
+}
+
+static int cxusb_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num)
+{
+	struct dvb_usb_device *d = i2c_get_adapdata(adap);
+	int i;
+
+	if (down_interruptible(&d->i2c_sem) < 0)
+		return -EAGAIN;
+
+	if (num > 2)
+		warn("more than 2 i2c messages at a time is not handled yet. TODO.");
+
+	for (i = 0; i < num; i++) {
+
+		switch (msg[i].addr) {
+			case 0x63:
+				cxusb_set_i2c_path(d,PATH_CX22702);
+				break;
+			default:
+				cxusb_set_i2c_path(d,PATH_TUNER_OTHER);
+				break;
+		}
+
+		/* read request */
+		if (i+1 < num && (msg[i+1].flags & I2C_M_RD)) {
+			u8 obuf[3+msg[i].len], ibuf[1+msg[i+1].len];
+			obuf[0] = msg[i].len;
+			obuf[1] = msg[i+1].len;
+			obuf[2] = msg[i].addr;
+			memcpy(&obuf[3],msg[i].buf,msg[i].len);
+
+			if (cxusb_ctrl_msg(d, CMD_I2C_READ,
+						obuf, 3+msg[i].len,
+						ibuf, 1+msg[i+1].len) < 0)
+				break;
+
+			if (ibuf[0] != 0x08)
+				deb_info("i2c read could have been failed\n");
+
+			memcpy(msg[i+1].buf,&ibuf[1],msg[i+1].len);
+
+			i++;
+		} else { /* write */
+			u8 obuf[2+msg[i].len], ibuf;
+			obuf[0] = msg[i].addr;
+			obuf[1] = msg[i].len;
+			memcpy(&obuf[2],msg[i].buf,msg[i].len);
+
+			if (cxusb_ctrl_msg(d,CMD_I2C_WRITE, obuf, 2+msg[i].len, &ibuf,1) < 0)
+				break;
+			if (ibuf != 0x08)
+				deb_info("i2c write could have been failed\n");
+		}
+	}
+
+	up(&d->i2c_sem);
+	return i;
+}
+
+static u32 cxusb_i2c_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C;
+}
+
+static struct i2c_algorithm cxusb_i2c_algo = {
+	.name          = "Conexant USB I2C algorithm",
+	.id            = I2C_ALGO_BIT,
+	.master_xfer   = cxusb_i2c_xfer,
+	.functionality = cxusb_i2c_func,
+};
+
+static int cxusb_power_ctrl(struct dvb_usb_device *d, int onoff)
+{
+	return 0;
+}
+
+static int cxusb_streaming_ctrl(struct dvb_usb_device *d, int onoff)
+{
+	return 0;
+}
+
+struct cx22702_config cxusb_cx22702_config = {
+	.demod_address = 0x63,
+
+	.pll_init = dvb_usb_pll_init_i2c,
+	.pll_set  = dvb_usb_pll_set_i2c,
+};
+
+/* Callbacks for DVB USB */
+static int cxusb_tuner_attach(struct dvb_usb_device *d)
+{
+	u8 bpll[4] = { 0x0b, 0xdc, 0x9c, 0xa0 };
+	d->pll_addr = 0x61;
+	memcpy(d->pll_init,bpll,4);
+	d->pll_desc = &dvb_pll_fmd1216me;
+	return 0;
+}
+
+static int cxusb_frontend_attach(struct dvb_usb_device *d)
+{
+	u8 buf[2] = { 0x03, 0x00 };
+	u8 b = 0;
+
+	cxusb_ctrl_msg(d,0xde,&b,0,NULL,0);
+	cxusb_set_i2c_path(d,PATH_TUNER_OTHER);
+	cxusb_ctrl_msg(d,CMD_POWER_OFF, NULL, 0, &b, 1);
+
+	if (usb_set_interface(d->udev,0,6) < 0)
+		err("set interface failed\n");
+
+	cxusb_ctrl_msg(d,0x36, buf, 2, NULL, 0);
+	cxusb_set_i2c_path(d,PATH_CX22702);
+	cxusb_ctrl_msg(d,CMD_POWER_ON, NULL, 0, &b, 1);
+
+	if ((d->fe = cx22702_attach(&cxusb_cx22702_config, &d->i2c_adap)) != NULL)
+		return 0;
+
+	return -EIO;
+}
+
+/* DVB USB Driver stuff */
+static struct dvb_usb_properties cxusb_properties;
+
+static int cxusb_probe(struct usb_interface *intf,
+		const struct usb_device_id *id)
+{
+	return dvb_usb_device_init(intf,&cxusb_properties,THIS_MODULE);
+}
+
+static struct usb_device_id cxusb_table [] = {
+		{ USB_DEVICE(USB_VID_MEDION, USB_PID_MEDION_MD95700) },
+		{}		/* Terminating entry */
+};
+MODULE_DEVICE_TABLE (usb, cxusb_table);
+
+static struct dvb_usb_properties cxusb_properties = {
+	.caps = DVB_USB_IS_AN_I2C_ADAPTER,
+
+	.usb_ctrl = CYPRESS_FX2,
+
+	.size_of_priv     = sizeof(struct cxusb_state),
+
+	.streaming_ctrl   = cxusb_streaming_ctrl,
+	.power_ctrl       = cxusb_power_ctrl,
+	.frontend_attach  = cxusb_frontend_attach,
+	.tuner_attach     = cxusb_tuner_attach,
+
+	.i2c_algo         = &cxusb_i2c_algo,
+
+	.generic_bulk_ctrl_endpoint = 0x01,
+	/* parameter for the MPEG2-data transfer */
+	.urb = {
+		.type = DVB_USB_ISOC,
+		.count = 5,
+		.endpoint = 0x02,
+		.u = {
+			.isoc = {
+				.framesperurb = 64,
+				.framesize = 940*3,
+				.interval = 1,
+			}
+		}
+	},
+
+	.num_device_descs = 1,
+	.devices = {
+		{   "Medion MD95700 (MDUSBTV-HYBRID)",
+			{ NULL },
+			{ &cxusb_table[0], NULL },
+		},
+	}
+};
+
+static struct usb_driver cxusb_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "cxusb",
+	.probe		= cxusb_probe,
+	.disconnect = dvb_usb_device_exit,
+	.id_table	= cxusb_table,
+};
+
+/* module stuff */
+static int __init cxusb_module_init(void)
+{
+	int result;
+	if ((result = usb_register(&cxusb_driver))) {
+		err("usb_register failed. Error number %d",result);
+		return result;
+	}
+
+	return 0;
+}
+
+static void __exit cxusb_module_exit(void)
+{
+	/* deregister this driver from the USB subsystem */
+	usb_deregister(&cxusb_driver);
+}
+
+module_init (cxusb_module_init);
+module_exit (cxusb_module_exit);
+
+MODULE_AUTHOR("Patrick Boettcher <patrick.boettcher@desy.de>");
+MODULE_DESCRIPTION("Driver for Conexant USB2.0 hybrid reference design");
+MODULE_VERSION("1.0-alpha");
+MODULE_LICENSE("GPL");
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/cxusb.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/cxusb.h	2005-06-27 13:26:10.000000000 +0200
@@ -0,0 +1,30 @@
+#ifndef _DVB_USB_CXUSB_H_
+#define _DVB_USB_CXUSB_H_
+
+#define DVB_USB_LOG_PREFIX "digitv"
+#include "dvb-usb.h"
+
+extern int dvb_usb_cxusb_debug;
+#define deb_info(args...)   dprintk(dvb_usb_cxusb_debug,0x01,args)
+
+/* usb commands - some of it are guesses, don't have a reference yet */
+#define CMD_I2C_WRITE    0x08
+#define CMD_I2C_READ     0x09
+
+#define CMD_IOCTL        0x0e
+#define    IOCTL_SET_I2C_PATH 0x02
+
+#define CMD_POWER_OFF    0x50
+#define CMD_POWER_ON     0x51
+
+enum cxusb_i2c_pathes {
+	PATH_UNDEF       = 0x00,
+	PATH_CX22702     = 0x01,
+	PATH_TUNER_OTHER = 0x02,
+};
+
+struct cxusb_state {
+	enum cxusb_i2c_pathes cur_i2c_path;
+};
+
+#endif
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-ids.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dvb-usb-ids.h	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-ids.h	2005-06-27 13:26:10.000000000 +0200
@@ -24,6 +24,7 @@
 #define USB_VID_HANFTEK						0x15f4
 #define USB_VID_HAUPPAUGE					0x2040
 #define USB_VID_HYPER_PALTEK				0x1025
+#define USB_VID_MEDION						0x1660
 #define USB_VID_VISIONPLUS					0x13d3
 #define USB_VID_TWINHAN						0x1822
 #define USB_VID_ULTIMA_ELECTRONIC			0x05d8
@@ -78,6 +79,7 @@
 #define USB_PID_DVICO_BLUEBIRD_LGDT			0xd820
 #define USB_PID_DVICO_BLUEBIRD_LGZ201_1		0xdb01
 #define USB_PID_DVICO_BLUEBIRD_TH7579_2		0xdb11
+#define USB_PID_MEDION_MD95700				0x0932
 
 
 #endif

--

